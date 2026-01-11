// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.channels.PollingChannel

package mx.messaging.channels
{
    import mx.messaging.Channel;
    import flash.utils.Timer;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.TimerEvent;
    import mx.messaging.ChannelSet;
    import mx.messaging.MessageAgent;
    import mx.messaging.Consumer;
    import mx.messaging.ConsumerMessageDispatcher;
    import mx.messaging.messages.CommandMessage;
    import mx.logging.Log;
    import mx.messaging.messages.IMessage;
    import mx.messaging.events.ChannelFaultEvent;
    import flash.events.Event;
    import mx.messaging.MessageResponder;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PollingChannel extends Channel 
    {

        private static const DEFAULT_POLLING_INTERVAL:int = 3000;

        mx_internal var _timer:Timer;
        private var _pollingEnabled:Boolean;
        private var _piggybackingEnabled:Boolean;
        mx_internal var _pollingInterval:int;
        mx_internal var pollOutstanding:Boolean;
        private var _pollingRef:int = -1;
        mx_internal var _shouldPoll:Boolean;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function PollingChannel(_arg_1:String=null, _arg_2:String=null)
        {
            super(_arg_1, _arg_2);
            _pollingEnabled = true;
            _shouldPoll = false;
            if (timerRequired())
            {
                _pollingInterval = DEFAULT_POLLING_INTERVAL;
                _timer = new Timer(_pollingInterval, 1);
                _timer.addEventListener(TimerEvent.TIMER, internalPoll);
            };
        }

        public function enablePolling():void
        {
            _pollingRef++;
            if (_pollingRef == 0)
            {
                startPolling();
            };
        }

        mx_internal function get timerRunning():Boolean
        {
            return ((!(_timer == null)) && (_timer.running));
        }

        protected function timerRequired():Boolean
        {
            return (true);
        }

        override protected function setConnected(_arg_1:Boolean):void
        {
            var _local_2:ChannelSet;
            var _local_3:MessageAgent;
            if (connected != _arg_1)
            {
                if (_arg_1)
                {
                    for each (_local_2 in channelSets)
                    {
                        for each (_local_3 in _local_2.messageAgents)
                        {
                            if (((_local_3 is Consumer) && ((_local_3 as Consumer).subscribed)))
                            {
                                enablePolling();
                            };
                        };
                    };
                };
                super.setConnected(_arg_1);
            };
        }

        override public function send(agent:MessageAgent, message:IMessage):void
        {
            var consumerDispatcher:ConsumerMessageDispatcher;
            var msg:CommandMessage;
            var piggyback:Boolean;
            if ((((!(pollOutstanding)) && (_piggybackingEnabled)) && (!(message is CommandMessage))))
            {
                if (_shouldPoll)
                {
                    piggyback = true;
                }
                else
                {
                    consumerDispatcher = ConsumerMessageDispatcher.getInstance();
                    if (consumerDispatcher.isChannelUsedForSubscriptions(this))
                    {
                        piggyback = true;
                    };
                };
            };
            if (piggyback)
            {
                internalPoll();
            };
            super.send(agent, message);
            if (piggyback)
            {
                msg = new CommandMessage();
                msg.operation = CommandMessage.POLL_OPERATION;
                if (Log.isDebug())
                {
                    _log.debug("'{0}' channel sending poll message\n{1}\n", id, msg.toString());
                };
                try
                {
                    internalSend(new PollCommandMessageResponder(null, msg, this, _log));
                }
                catch(e:Error)
                {
                    stopPolling();
                    throw (e);
                };
            };
        }

        protected function applyPollingSettings(_arg_1:XML):void
        {
            var _local_2:XML;
            if (_arg_1.properties.length())
            {
                _local_2 = _arg_1.properties[0];
                if (_local_2["polling-enabled"].length())
                {
                    internalPollingEnabled = (_local_2["polling-enabled"].toString() == "true");
                };
                if (_local_2["polling-interval-millis"].length())
                {
                    internalPollingInterval = parseInt(_local_2["polling-interval-millis"].toString());
                }
                else
                {
                    if (_local_2["polling-interval-seconds"].length())
                    {
                        internalPollingInterval = (parseInt(_local_2["polling-interval-seconds"].toString()) * 1000);
                    };
                };
                if (_local_2["piggybacking-enabled"].length())
                {
                    internalPiggybackingEnabled = (_local_2["piggybacking-enabled"].toString() == "true");
                };
                if (_local_2["login-after-disconnect"].length())
                {
                    _loginAfterDisconnect = (_local_2["login-after-disconnect"].toString() == "true");
                };
            };
        }

        mx_internal function set internalPollingInterval(_arg_1:Number):void
        {
            var _local_2:String;
            if (_arg_1 == 0)
            {
                _pollingInterval = _arg_1;
                if (_timer != null)
                {
                    _timer.stop();
                };
                if (_shouldPoll)
                {
                    startPolling();
                };
            }
            else
            {
                if (_arg_1 > 0)
                {
                    if (_timer != null)
                    {
                        _timer.delay = (_pollingInterval = _arg_1);
                        if (((!(timerRunning)) && (_shouldPoll)))
                        {
                            startPolling();
                        };
                    };
                }
                else
                {
                    _local_2 = resourceManager.getString("messaging", "pollingIntervalNonPositive");
                    throw (new ArgumentError(_local_2));
                };
            };
        }

        public function poll():void
        {
            internalPoll();
        }

        protected function set internalPiggybackingEnabled(_arg_1:Boolean):void
        {
            _piggybackingEnabled = _arg_1;
        }

        protected function get internalPollingEnabled():Boolean
        {
            return (_pollingEnabled);
        }

        mx_internal function pollFailed(_arg_1:Boolean=false):void
        {
            internalDisconnect(_arg_1);
        }

        override protected function connectFailed(_arg_1:ChannelFaultEvent):void
        {
            stopPolling();
            super.connectFailed(_arg_1);
        }

        mx_internal function stopPolling():void
        {
            if (Log.isInfo())
            {
                _log.info("'{0}' channel polling stopped.", id);
            };
            if (_timer != null)
            {
                _timer.stop();
            };
            _pollingRef = -1;
            _shouldPoll = false;
            pollOutstanding = false;
        }

        protected function internalPoll(event:Event=null):void
        {
            var poll:CommandMessage;
            if (!pollOutstanding)
            {
                if (Log.isInfo())
                {
                    _log.info("'{0}' channel requesting queued messages.", id);
                };
                if (timerRunning)
                {
                    _timer.stop();
                };
                poll = new CommandMessage();
                poll.operation = CommandMessage.POLL_OPERATION;
                if (Log.isDebug())
                {
                    _log.debug("'{0}' channel sending poll message\n{1}\n", id, poll.toString());
                };
                try
                {
                    internalSend(new PollCommandMessageResponder(null, poll, this, _log));
                    pollOutstanding = true;
                }
                catch(e:Error)
                {
                    stopPolling();
                    throw (e);
                };
            }
            else
            {
                if (Log.isInfo())
                {
                    _log.info("'{0}' channel waiting for poll response.", id);
                };
            };
        }

        protected function getDefaultMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage):MessageResponder
        {
            return (super.getMessageResponder(_arg_1, _arg_2));
        }

        mx_internal function get internalPollingInterval():Number
        {
            return ((_timer == null) ? 0 : _pollingInterval);
        }

        protected function startPolling():void
        {
            if (_pollingEnabled)
            {
                if (Log.isInfo())
                {
                    _log.info("'{0}' channel polling started.", id);
                };
                _shouldPoll = true;
                poll();
            };
        }

        protected function get internalPiggybackingEnabled():Boolean
        {
            return (_piggybackingEnabled);
        }

        override mx_internal function get realtime():Boolean
        {
            return (_pollingEnabled);
        }

        final override protected function getMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage):MessageResponder
        {
            if (((_arg_2 is CommandMessage) && ((_arg_2 as CommandMessage).operation == CommandMessage.POLL_OPERATION)))
            {
                return (new PollCommandMessageResponder(_arg_1, _arg_2, this, _log));
            };
            return (getDefaultMessageResponder(_arg_1, _arg_2));
        }

        override protected function internalDisconnect(_arg_1:Boolean=false):void
        {
            stopPolling();
            super.internalDisconnect(_arg_1);
        }

        public function disablePolling():void
        {
            _pollingRef--;
            if (_pollingRef < 0)
            {
                stopPolling();
            };
        }

        protected function set internalPollingEnabled(_arg_1:Boolean):void
        {
            _pollingEnabled = _arg_1;
            if (((!(_arg_1)) && ((timerRunning) || ((!(timerRunning)) && (_pollingInterval == 0)))))
            {
                stopPolling();
            }
            else
            {
                if ((((_arg_1) && (_shouldPoll)) && (!(timerRunning))))
                {
                    startPolling();
                };
            };
        }


    }
}//package mx.messaging.channels

import mx.messaging.MessageResponder;
import mx.logging.ILogger;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.events.PropertyChangeEvent;
import mx.messaging.MessageAgent;
import mx.messaging.messages.IMessage;
import mx.messaging.channels.PollingChannel;
import mx.messaging.messages.MessagePerformanceUtils;
import mx.messaging.messages.ErrorMessage;
import mx.logging.Log;
import mx.messaging.messages.CommandMessage;
import mx.messaging.events.MessageEvent;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.events.ChannelFaultEvent;
import mx.core.mx_internal; 

use namespace mx_internal;

class PollCommandMessageResponder extends MessageResponder 
{

    /*private*/ var _log:ILogger;
    /*private*/ var suppressHandlers:Boolean;
    /*private*/ var resourceManager:IResourceManager = ResourceManager.getInstance();

    public function PollCommandMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage, _arg_3:PollingChannel, _arg_4:ILogger)
    {
        super(_arg_1, _arg_2, _arg_3);
        _log = _arg_4;
        _arg_3.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, channelPropertyChangeHandler);
    }

    /*private*/ function doPoll(_arg_1:int=0):void
    {
        var _local_2:PollingChannel = PollingChannel(channel);
        if (((_local_2.connected) && (_local_2._shouldPoll)))
        {
            if (_arg_1 == 0)
            {
                if (_local_2.internalPollingInterval == 0)
                {
                    _local_2.poll();
                }
                else
                {
                    if (!_local_2.timerRunning)
                    {
                        _local_2._timer.delay = _local_2._pollingInterval;
                        _local_2._timer.start();
                    };
                };
            }
            else
            {
                _local_2._timer.delay = _arg_1;
                _local_2._timer.start();
            };
        };
    }

    /*private*/ function channelPropertyChangeHandler(_arg_1:PropertyChangeEvent):void
    {
        if (((_arg_1.property == "connected") && (!(_arg_1.newValue))))
        {
            suppressHandlers = true;
        };
    }

    override protected function resultHandler(msg:IMessage):void
    {
        var messageList:Array;
        var message:IMessage;
        var mpiutil:MessagePerformanceUtils;
        var errMsg:ErrorMessage;
        var pollingChannel:PollingChannel = (channel as PollingChannel);
        if (suppressHandlers)
        {
            if (Log.isDebug())
            {
                _log.debug("'{0}' channel ignoring response for poll request preceeding most recent disconnect.\n", channel.id);
            };
            doPoll();
            return;
        };
        if ((msg is CommandMessage))
        {
            pollingChannel.pollOutstanding = false;
            if (msg.headers[CommandMessage.NO_OP_POLL_HEADER] == true)
            {
                return;
            };
            if (msg.body != null)
            {
                messageList = (msg.body as Array);
                for each (message in messageList)
                {
                    if (Log.isDebug())
                    {
                        _log.debug("'{0}' channel got message\n{1}\n", channel.id, message.toString());
                        if (channel.mpiEnabled)
                        {
                            try
                            {
                                mpiutil = new MessagePerformanceUtils(message);
                                _log.debug(mpiutil.prettyPrint());
                            }
                            catch(e:Error)
                            {
                                _log.debug(("Could not get message performance information for: " + msg.toString()));
                            };
                        };
                    };
                    channel.dispatchEvent(MessageEvent.createEvent(MessageEvent.MESSAGE, message));
                };
            };
        }
        else
        {
            if ((msg is AcknowledgeMessage))
            {
                pollingChannel.pollOutstanding = false;
            }
            else
            {
                errMsg = new ErrorMessage();
                errMsg.faultDetail = resourceManager.getString("messaging", "receivedNull");
                status(errMsg);
                return;
            };
        };
        if (msg.headers[CommandMessage.POLL_WAIT_HEADER] != null)
        {
            doPoll(msg.headers[CommandMessage.POLL_WAIT_HEADER]);
        }
        else
        {
            doPoll();
        };
    }

    override protected function statusHandler(_arg_1:IMessage):void
    {
        if (suppressHandlers)
        {
            if (Log.isDebug())
            {
                _log.debug("'{0}' channel ignoring response for poll request preceeding most recent disconnect.\n", channel.id);
            };
            return;
        };
        var _local_2:PollingChannel = PollingChannel(channel);
        _local_2.stopPolling();
        var _local_3:ErrorMessage = (_arg_1 as ErrorMessage);
        var _local_4:String = ((_local_3 != null) ? _local_3.faultDetail : "");
        var _local_5:ChannelFaultEvent = ChannelFaultEvent.createEvent(_local_2, false, "Channel.Polling.Error", "error", _local_4);
        _local_5.rootCause = _arg_1;
        _local_2.dispatchEvent(_local_5);
        if (((!(_local_3 == null)) && (_local_3.faultCode == "Server.PollNotSupported")))
        {
            _local_2.pollFailed(true);
        }
        else
        {
            _local_2.pollFailed(false);
        };
    }


}


