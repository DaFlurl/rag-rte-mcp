// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.AbstractConsumer

package mx.messaging
{
    import flash.utils.Timer;
    import mx.messaging.messages.CommandMessage;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.logging.Log;
    import mx.messaging.events.ChannelFaultEvent;
    import mx.messaging.messages.ErrorMessage;
    import flash.events.TimerEvent;
    import mx.messaging.events.ChannelEvent;
    import mx.messaging.messages.IMessage;
    import mx.messaging.channels.PollingChannel;
    import mx.messaging.events.MessageFaultEvent;
    import mx.messaging.events.MessageEvent;
    import mx.events.PropertyChangeEvent;
    import mx.messaging.messages.AcknowledgeMessage;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AbstractConsumer extends MessageAgent 
    {

        private var _currentAttempt:int;
        private var _timestamp:Number = -1;
        private var _resubscribeInterval:int = 5000;
        private var _resubscribeAttempts:int = 5;
        private var _resubscribeTimer:Timer;
        protected var _shouldBeSubscribed:Boolean;
        private var _subscribeMsg:CommandMessage;
        private var _maxFrequency:uint = 0;
        private var _subscribed:Boolean;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function AbstractConsumer()
        {
            _log = Log.getLogger("mx.messaging.Consumer");
            _agentType = "consumer";
        }

        override public function channelFaultHandler(_arg_1:ChannelFaultEvent):void
        {
            if (!_arg_1.channel.connected)
            {
                setSubscribed(false);
            };
            super.channelFaultHandler(_arg_1);
            if ((((_shouldBeSubscribed) && (!(_arg_1.rejected))) && (!(_arg_1.channel.connected))))
            {
                startResubscribeTimer();
            };
        }

        protected function buildUnsubscribeMessage(_arg_1:Boolean):CommandMessage
        {
            var _local_2:CommandMessage = new CommandMessage();
            _local_2.operation = CommandMessage.UNSUBSCRIBE_OPERATION;
            _local_2.clientId = clientId;
            _local_2.destination = destination;
            if (_arg_1)
            {
                _local_2.headers[CommandMessage.PRESERVE_DURABLE_HEADER] = _arg_1;
            };
            return (_local_2);
        }

        public function receive(_arg_1:Number=0):void
        {
            var _local_2:CommandMessage;
            if (clientId != null)
            {
                _local_2 = new CommandMessage();
                _local_2.operation = CommandMessage.POLL_OPERATION;
                _local_2.destination = destination;
                internalSend(_local_2);
            };
        }

        protected function resubscribe(_arg_1:TimerEvent):void
        {
            var _local_2:ErrorMessage;
            if (((!(_resubscribeAttempts == -1)) && (_currentAttempt >= _resubscribeAttempts)))
            {
                stopResubscribeTimer();
                _shouldBeSubscribed = false;
                _local_2 = new ErrorMessage();
                _local_2.faultCode = "Client.Error.Subscribe";
                _local_2.faultString = resourceManager.getString("messaging", "consumerSubscribeError");
                _local_2.faultDetail = resourceManager.getString("messaging", "failedToSubscribe");
                _local_2.correlationId = _subscribeMsg.messageId;
                fault(_local_2, _subscribeMsg);
                return;
            };
            if (Log.isDebug())
            {
                _log.debug("'{0}' {1} trying to resubscribe.", id, _agentType);
            };
            _resubscribeTimer.delay = _resubscribeInterval;
            _currentAttempt++;
            internalSend(_subscribeMsg, false);
        }

        override mx_internal function setClientId(_arg_1:String):void
        {
            var _local_2:Boolean;
            if (super.clientId != _arg_1)
            {
                _local_2 = false;
                if (subscribed)
                {
                    unsubscribe();
                    _local_2 = true;
                };
                super.setClientId(_arg_1);
                if (_local_2)
                {
                    subscribe(_arg_1);
                };
            };
        }

        override public function disconnect():void
        {
            _shouldBeSubscribed = false;
            stopResubscribeTimer();
            setSubscribed(false);
            super.disconnect();
        }

        public function subscribe(_arg_1:String=null):void
        {
            var _local_2:Boolean = (((!(_arg_1 == null)) && (!(super.clientId == _arg_1))) ? true : false);
            if (((subscribed) && (_local_2)))
            {
                unsubscribe();
            };
            stopResubscribeTimer();
            _shouldBeSubscribed = true;
            if (_local_2)
            {
                super.setClientId(_arg_1);
            };
            if (Log.isInfo())
            {
                _log.info("'{0}' {1} subscribe.", id, _agentType);
            };
            _subscribeMsg = buildSubscribeMessage();
            internalSend(_subscribeMsg);
        }

        override public function channelDisconnectHandler(_arg_1:ChannelEvent):void
        {
            setSubscribed(false);
            super.channelDisconnectHandler(_arg_1);
            if (((_shouldBeSubscribed) && (!(_arg_1.rejected))))
            {
                startResubscribeTimer();
            };
        }

        protected function buildSubscribeMessage():CommandMessage
        {
            var _local_1:CommandMessage = new CommandMessage();
            _local_1.operation = CommandMessage.SUBSCRIBE_OPERATION;
            _local_1.clientId = clientId;
            _local_1.destination = destination;
            if (maxFrequency > 0)
            {
                _local_1.headers[CommandMessage.MAX_FREQUENCY_HEADER] = maxFrequency;
            };
            return (_local_1);
        }

        protected function startResubscribeTimer():void
        {
            if (((_shouldBeSubscribed) && (_resubscribeTimer == null)))
            {
                if (((!(_resubscribeAttempts == 0)) && (_resubscribeInterval > 0)))
                {
                    if (Log.isDebug())
                    {
                        _log.debug("'{0}' {1} starting resubscribe timer.", id, _agentType);
                    };
                    _resubscribeTimer = new Timer(1);
                    _resubscribeTimer.addEventListener(TimerEvent.TIMER, resubscribe);
                    _resubscribeTimer.start();
                    _currentAttempt = 0;
                };
            };
        }

        public function unsubscribe(_arg_1:Boolean=false):void
        {
            _shouldBeSubscribed = false;
            if (subscribed)
            {
                if (channelSet != null)
                {
                    channelSet.removeEventListener(destination, messageHandler);
                };
                if (Log.isInfo())
                {
                    _log.info("'{0}' {1} unsubscribe.", id, _agentType);
                };
                internalSend(buildUnsubscribeMessage(_arg_1));
            }
            else
            {
                stopResubscribeTimer();
            };
        }

        mx_internal function messageHandler(_arg_1:MessageEvent):void
        {
            var _local_3:CommandMessage;
            var _local_2:IMessage = _arg_1.message;
            if ((_local_2 is CommandMessage))
            {
                _local_3 = (_local_2 as CommandMessage);
                switch (_local_3.operation)
                {
                    case CommandMessage.SUBSCRIPTION_INVALIDATE_OPERATION:
                        if ((channelSet.currentChannel is PollingChannel))
                        {
                            PollingChannel(channelSet.currentChannel).disablePolling();
                        };
                        setSubscribed(false);
                        return;
                    default:
                        if (Log.isWarn())
                        {
                            _log.warn("'{0}' received a CommandMessage '{1}' that could not be handled.", id, CommandMessage.getOperationAsString(_local_3.operation));
                        };
                };
                return;
            };
            if (_local_2.timestamp > _timestamp)
            {
                _timestamp = _local_2.timestamp;
            };
            if ((_local_2 is ErrorMessage))
            {
                dispatchEvent(MessageFaultEvent.createEvent(ErrorMessage(_local_2)));
            }
            else
            {
                dispatchEvent(MessageEvent.createEvent(MessageEvent.MESSAGE, _local_2));
            };
        }

        [Bindable(event="propertyChange")]
        public function get timestamp():Number
        {
            return (_timestamp);
        }

        [Bindable(event="propertyChange")]
        public function get maxFrequency():uint
        {
            return (_maxFrequency);
        }

        [Bindable(event="propertyChange")]
        public function get resubscribeInterval():int
        {
            return (_resubscribeInterval);
        }

        [Bindable(event="propertyChange")]
        public function get subscribed():Boolean
        {
            return (_subscribed);
        }

        override public function fault(_arg_1:ErrorMessage, _arg_2:IMessage):void
        {
            if (_disconnectBarrier)
            {
                return;
            };
            if (_arg_1.headers[ErrorMessage.RETRYABLE_HINT_HEADER])
            {
                if (_resubscribeTimer == null)
                {
                    if (((!(_subscribeMsg == null)) && (_arg_1.correlationId == _subscribeMsg.messageId)))
                    {
                        _shouldBeSubscribed = false;
                    };
                    super.fault(_arg_1, _arg_2);
                };
            }
            else
            {
                super.fault(_arg_1, _arg_2);
            };
        }

        override public function set destination(_arg_1:String):void
        {
            var _local_2:Boolean;
            if (destination != _arg_1)
            {
                _local_2 = false;
                if (subscribed)
                {
                    unsubscribe();
                    _local_2 = true;
                };
                super.destination = _arg_1;
                if (_local_2)
                {
                    subscribe();
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get resubscribeAttempts():int
        {
            return (_resubscribeAttempts);
        }

        protected function stopResubscribeTimer():void
        {
            if (_resubscribeTimer != null)
            {
                if (Log.isDebug())
                {
                    _log.debug("'{0}' {1} stopping resubscribe timer.", id, _agentType);
                };
                _resubscribeTimer.removeEventListener(TimerEvent.TIMER, resubscribe);
                _resubscribeTimer.reset();
                _resubscribeTimer = null;
            };
        }

        override public function channelConnectHandler(_arg_1:ChannelEvent):void
        {
            super.channelConnectHandler(_arg_1);
            if ((((((connected) && (!(channelSet == null))) && (!(channelSet.currentChannel == null))) && (!(channelSet.currentChannel.realtime))) && (Log.isWarn())))
            {
                _log.warn(("'{0}' {1} connected over a non-realtime channel '{2}'" + " which means channel is not automatically receiving updates via polling or server push."), id, _agentType, channelSet.currentChannel.id);
            };
        }

        protected function setSubscribed(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            if (_subscribed != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "subscribed", _subscribed, _arg_1);
                _subscribed = _arg_1;
                if (_subscribed)
                {
                    ConsumerMessageDispatcher.getInstance().registerSubscription(this);
                    if ((((!(channelSet == null)) && (!(channelSet.currentChannel == null))) && (channelSet.currentChannel is PollingChannel)))
                    {
                        PollingChannel(channelSet.currentChannel).enablePolling();
                    };
                }
                else
                {
                    ConsumerMessageDispatcher.getInstance().unregisterSubscription(this);
                    if ((((!(channelSet == null)) && (!(channelSet.currentChannel == null))) && (channelSet.currentChannel is PollingChannel)))
                    {
                        PollingChannel(channelSet.currentChannel).disablePolling();
                    };
                };
                dispatchEvent(_local_2);
            };
        }

        public function set maxFrequency(_arg_1:uint):void
        {
            var _local_2:PropertyChangeEvent = PropertyChangeEvent.createUpdateEvent(this, "maxFrequency", _maxFrequency, _arg_1);
            _maxFrequency = _arg_1;
            dispatchEvent(_local_2);
        }

        override public function acknowledge(_arg_1:AcknowledgeMessage, _arg_2:IMessage):void
        {
            var _local_3:CommandMessage;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:IMessage;
            if (_disconnectBarrier)
            {
                return;
            };
            if (((!(_arg_1.headers[AcknowledgeMessage.ERROR_HINT_HEADER])) && (_arg_2 is CommandMessage)))
            {
                _local_3 = (_arg_2 as CommandMessage);
                _local_4 = _local_3.operation;
                if (_local_4 == CommandMessage.MULTI_SUBSCRIBE_OPERATION)
                {
                    if (_arg_2.headers.DSlastUnsub != null)
                    {
                        _local_4 = CommandMessage.UNSUBSCRIBE_OPERATION;
                    }
                    else
                    {
                        _local_4 = CommandMessage.SUBSCRIBE_OPERATION;
                    };
                };
                switch (_local_4)
                {
                    case CommandMessage.UNSUBSCRIBE_OPERATION:
                        if (Log.isInfo())
                        {
                            _log.info("'{0}' {1} acknowledge for unsubscribe.", id, _agentType);
                        };
                        super.setClientId(null);
                        setSubscribed(false);
                        _arg_1.clientId = null;
                        super.acknowledge(_arg_1, _arg_2);
                        break;
                    case CommandMessage.SUBSCRIBE_OPERATION:
                        stopResubscribeTimer();
                        if (_arg_1.timestamp > _timestamp)
                        {
                            _timestamp = (_arg_1.timestamp - 1);
                        };
                        if (Log.isInfo())
                        {
                            _log.info("'{0}' {1} acknowledge for subscribe. Client id '{2}' new timestamp {3}", id, _agentType, _arg_1.clientId, _timestamp);
                        };
                        super.setClientId(_arg_1.clientId);
                        setSubscribed(true);
                        super.acknowledge(_arg_1, _arg_2);
                        break;
                    case CommandMessage.POLL_OPERATION:
                        if (((!(_arg_1.body == null)) && (_arg_1.body is Array)))
                        {
                            _local_5 = (_arg_1.body as Array);
                            for each (_local_6 in _local_5)
                            {
                                messageHandler(MessageEvent.createEvent(MessageEvent.MESSAGE, _local_6));
                            };
                        };
                        super.acknowledge(_arg_1, _arg_2);
                        break;
                };
            }
            else
            {
                super.acknowledge(_arg_1, _arg_2);
            };
        }

        public function set resubscribeInterval(_arg_1:int):void
        {
            var _local_2:PropertyChangeEvent;
            var _local_3:String;
            if (_resubscribeInterval != _arg_1)
            {
                if (_arg_1 < 0)
                {
                    _local_3 = resourceManager.getString("messaging", "resubscribeIntervalNegative");
                    throw (new ArgumentError(_local_3));
                };
                if (_arg_1 == 0)
                {
                    stopResubscribeTimer();
                }
                else
                {
                    if (_resubscribeTimer != null)
                    {
                        _resubscribeTimer.delay = _arg_1;
                    };
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "resubscribeInterval", _resubscribeInterval, _arg_1);
                _resubscribeInterval = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        public function set resubscribeAttempts(_arg_1:int):void
        {
            var _local_2:PropertyChangeEvent;
            if (_resubscribeAttempts != _arg_1)
            {
                if (_arg_1 == 0)
                {
                    stopResubscribeTimer();
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "resubscribeAttempts", _resubscribeAttempts, _arg_1);
                _resubscribeAttempts = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        public function set timestamp(_arg_1:Number):void
        {
            var _local_2:PropertyChangeEvent;
            if (_timestamp != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "timestamp", _timestamp, _arg_1);
                _timestamp = _arg_1;
                dispatchEvent(_local_2);
            };
        }


    }
}//package mx.messaging

