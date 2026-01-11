// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.AbstractProducer

package mx.messaging
{
    import flash.utils.Timer;
    import mx.messaging.messages.CommandMessage;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.events.PropertyChangeEvent;
    import mx.logging.Log;
    import flash.events.TimerEvent;
    import mx.messaging.events.ChannelEvent;
    import mx.messaging.messages.ErrorMessage;
    import mx.messaging.messages.IMessage;
    import mx.messaging.messages.AcknowledgeMessage;
    import mx.messaging.events.ChannelFaultEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AbstractProducer extends MessageAgent 
    {

        private var _priority:int = -1;
        private var _reconnectInterval:int;
        private var _autoConnect:Boolean = true;
        private var _reconnectTimer:Timer;
        protected var _shouldBeConnected:Boolean;
        private var _connectMsg:CommandMessage;
        private var _defaultHeaders:Object;
        private var _currentAttempt:int;
        private var _reconnectAttempts:int;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();


        public function set reconnectAttempts(_arg_1:int):void
        {
            var _local_2:PropertyChangeEvent;
            if (_reconnectAttempts != _arg_1)
            {
                if (_arg_1 == 0)
                {
                    stopReconnectTimer();
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "reconnectAttempts", _reconnectAttempts, _arg_1);
                _reconnectAttempts = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        [Bindable(event="propertyChange")]
        public function get defaultHeaders():Object
        {
            return (_defaultHeaders);
        }

        public function set reconnectInterval(_arg_1:int):void
        {
            var _local_2:PropertyChangeEvent;
            var _local_3:String;
            if (_reconnectInterval != _arg_1)
            {
                if (_arg_1 < 0)
                {
                    _local_3 = resourceManager.getString("messaging", "reconnectIntervalNegative");
                    throw (new ArgumentError(_local_3));
                };
                if (_arg_1 == 0)
                {
                    stopReconnectTimer();
                }
                else
                {
                    if (_reconnectTimer != null)
                    {
                        _reconnectTimer.delay = _arg_1;
                    };
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "reconnectInterval", _reconnectInterval, _arg_1);
                _reconnectInterval = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        public function set defaultHeaders(_arg_1:Object):void
        {
            var _local_2:PropertyChangeEvent;
            if (_defaultHeaders != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "defaultHeaders", _defaultHeaders, _arg_1);
                _defaultHeaders = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        public function set priority(_arg_1:int):void
        {
            var _local_2:PropertyChangeEvent;
            if (_priority != _arg_1)
            {
                _arg_1 = ((_arg_1 < 0) ? 0 : ((_arg_1 > 9) ? 9 : _arg_1));
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "priority", _priority, _arg_1);
                _priority = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        protected function stopReconnectTimer():void
        {
            if (_reconnectTimer != null)
            {
                if (Log.isDebug())
                {
                    _log.debug("'{0}' {1} stopping reconnect timer.", id, _agentType);
                };
                _reconnectTimer.removeEventListener(TimerEvent.TIMER, reconnect);
                _reconnectTimer.reset();
                _reconnectTimer = null;
            };
        }

        override public function channelDisconnectHandler(_arg_1:ChannelEvent):void
        {
            super.channelDisconnectHandler(_arg_1);
            if (((_shouldBeConnected) && (!(_arg_1.rejected))))
            {
                startReconnectTimer();
            };
        }

        public function send(_arg_1:IMessage):void
        {
            var _local_2:String;
            var _local_3:ErrorMessage;
            if (((!(connected)) && (autoConnect)))
            {
                _shouldBeConnected = true;
            };
            if (defaultHeaders != null)
            {
                for (_local_2 in defaultHeaders)
                {
                    if (!_arg_1.headers.hasOwnProperty(_local_2))
                    {
                        _arg_1.headers[_local_2] = defaultHeaders[_local_2];
                    };
                };
            };
            if (((!(connected)) && (!(autoConnect))))
            {
                _shouldBeConnected = false;
                _local_3 = new ErrorMessage();
                _local_3.faultCode = "Client.Error.MessageSend";
                _local_3.faultString = resourceManager.getString("messaging", "producerSendError");
                _local_3.faultDetail = resourceManager.getString("messaging", "producerSendErrorDetails");
                _local_3.correlationId = _arg_1.messageId;
                internalFault(_local_3, _arg_1, false, true);
            }
            else
            {
                if (Log.isInfo())
                {
                    _log.info("'{0}' {1} sending message '{2}'", id, _agentType, _arg_1.messageId);
                };
                internalSend(_arg_1);
            };
        }

        private function buildConnectErrorMessage():ErrorMessage
        {
            var _local_1:ErrorMessage = new ErrorMessage();
            _local_1.faultCode = "Client.Error.Connect";
            _local_1.faultString = resourceManager.getString("messaging", "producerConnectError");
            _local_1.faultDetail = resourceManager.getString("messaging", "failedToConnect");
            _local_1.correlationId = _connectMsg.messageId;
            return (_local_1);
        }

        override public function acknowledge(_arg_1:AcknowledgeMessage, _arg_2:IMessage):void
        {
            if (_disconnectBarrier)
            {
                return;
            };
            super.acknowledge(_arg_1, _arg_2);
            if (((_arg_2 is CommandMessage) && (CommandMessage(_arg_2).operation == CommandMessage.TRIGGER_CONNECT_OPERATION)))
            {
                stopReconnectTimer();
            };
        }

        [Bindable(event="propertyChange")]
        public function get reconnectInterval():int
        {
            return (_reconnectInterval);
        }

        override public function fault(_arg_1:ErrorMessage, _arg_2:IMessage):void
        {
            internalFault(_arg_1, _arg_2);
        }

        override public function disconnect():void
        {
            _shouldBeConnected = false;
            stopReconnectTimer();
            super.disconnect();
        }

        mx_internal function internalFault(_arg_1:ErrorMessage, _arg_2:IMessage, _arg_3:Boolean=true, _arg_4:Boolean=false):void
        {
            var _local_5:ErrorMessage;
            if (((_disconnectBarrier) && (!(_arg_4))))
            {
                return;
            };
            if (((_arg_2 is CommandMessage) && (CommandMessage(_arg_2).operation == CommandMessage.TRIGGER_CONNECT_OPERATION)))
            {
                if (_reconnectTimer == null)
                {
                    if (((!(_connectMsg == null)) && (_arg_1.correlationId == _connectMsg.messageId)))
                    {
                        _shouldBeConnected = false;
                        _local_5 = buildConnectErrorMessage();
                        _local_5.rootCause = _arg_1.rootCause;
                        super.fault(_local_5, _arg_2);
                    }
                    else
                    {
                        super.fault(_arg_1, _arg_2);
                    };
                };
            }
            else
            {
                super.fault(_arg_1, _arg_2);
            };
        }

        public function connect():void
        {
            if (!connected)
            {
                _shouldBeConnected = true;
                if (_connectMsg == null)
                {
                    _connectMsg = buildConnectMessage();
                };
                internalSend(_connectMsg, false);
            };
        }

        [Bindable(event="propertyChange")]
        public function get priority():int
        {
            return (_priority);
        }

        private function buildConnectMessage():CommandMessage
        {
            var _local_1:CommandMessage = new CommandMessage();
            _local_1.operation = CommandMessage.TRIGGER_CONNECT_OPERATION;
            _local_1.clientId = clientId;
            _local_1.destination = destination;
            return (_local_1);
        }

        protected function reconnect(_arg_1:TimerEvent):void
        {
            if (((!(_reconnectAttempts == -1)) && (_currentAttempt >= _reconnectAttempts)))
            {
                stopReconnectTimer();
                _shouldBeConnected = false;
                fault(buildConnectErrorMessage(), _connectMsg);
                return;
            };
            if (Log.isDebug())
            {
                _log.debug("'{0}' {1} trying to reconnect.", id, _agentType);
            };
            _reconnectTimer.delay = _reconnectInterval;
            _currentAttempt++;
            if (_connectMsg == null)
            {
                _connectMsg = buildConnectMessage();
            };
            internalSend(_connectMsg, false);
        }

        protected function startReconnectTimer():void
        {
            if (((_shouldBeConnected) && (_reconnectTimer == null)))
            {
                if (((!(_reconnectAttempts == 0)) && (_reconnectInterval > 0)))
                {
                    if (Log.isDebug())
                    {
                        _log.debug("'{0}' {1} starting reconnect timer.", id, _agentType);
                    };
                    _reconnectTimer = new Timer(1);
                    _reconnectTimer.addEventListener(TimerEvent.TIMER, reconnect);
                    _reconnectTimer.start();
                    _currentAttempt = 0;
                };
            };
        }

        override public function channelFaultHandler(_arg_1:ChannelFaultEvent):void
        {
            super.channelFaultHandler(_arg_1);
            if ((((_shouldBeConnected) && (!(_arg_1.rejected))) && (!(_arg_1.channel.connected))))
            {
                startReconnectTimer();
            };
        }

        public function set autoConnect(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            if (_autoConnect != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "autoConnect", _autoConnect, _arg_1);
                _autoConnect = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        [Bindable(event="propertyChange")]
        public function get autoConnect():Boolean
        {
            return (_autoConnect);
        }

        [Bindable(event="propertyChange")]
        public function get reconnectAttempts():int
        {
            return (_reconnectAttempts);
        }


    }
}//package mx.messaging

