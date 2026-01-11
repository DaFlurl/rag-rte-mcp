// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.ChannelSet

package mx.messaging
{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import mx.utils.Base64Encoder;
    import flash.errors.IllegalOperationError;
    import mx.messaging.messages.CommandMessage;
    import mx.rpc.AsyncToken;
    import mx.messaging.channels.PollingChannel;
    import mx.messaging.errors.NoChannelAvailableError;
    import mx.messaging.config.ServerConfig;
    import mx.messaging.events.ChannelEvent;
    import mx.messaging.events.ChannelFaultEvent;
    import mx.messaging.messages.AcknowledgeMessage;
    import mx.rpc.AsyncDispatcher;
    import mx.messaging.channels.NetConnectionChannel;
    import mx.messaging.messages.IMessage;
    import mx.messaging.events.MessageEvent;
    import mx.events.PropertyChangeEvent;
    import mx.messaging.messages.ErrorMessage;
    import mx.rpc.events.AbstractEvent;
    import mx.rpc.events.ResultEvent;
    import mx.messaging.events.MessageFaultEvent;
    import mx.rpc.events.FaultEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ChannelSet extends EventDispatcher 
    {

        private var _shouldHunt:Boolean;
        private var _connected:Boolean;
        private var _hasRequestedClusterEndpoints:Boolean;
        private var _clustered:Boolean;
        private var _channels:Array;
        private var _hunting:Boolean;
        private var _authenticated:Boolean;
        private var _pendingMessages:Dictionary;
        private var _authAgent:AuthenticationAgent;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _heartbeatTimer:Timer;
        private var _credentials:String;
        private var _reconnectTimer:Timer = null;
        private var _credentialsCharset:String;
        private var _initialDestinationId:String;
        private var _shouldBeConnected:Boolean;
        private var _connecting:Boolean;
        private var _channelIds:Array;
        private var _configured:Boolean;
        private var _heartbeatInterval:int = 0;
        private var _currentChannel:Channel;
        private var _currentChannelIndex:int;
        private var _pendingSends:Array;
        private var _messageAgents:Array;
        private var _channelFailoverURIs:Object;

        public function ChannelSet(_arg_1:Array=null, _arg_2:Boolean=false)
        {
            _clustered = _arg_2;
            _connected = false;
            _connecting = false;
            _currentChannelIndex = -1;
            if (_arg_1 != null)
            {
                _channelIds = _arg_1;
                _channels = new Array(_channelIds.length);
                _configured = true;
            }
            else
            {
                _channels = [];
                _configured = false;
            };
            _hasRequestedClusterEndpoints = false;
            _hunting = false;
            _messageAgents = [];
            _pendingMessages = new Dictionary();
            _pendingSends = [];
            _shouldBeConnected = false;
            _shouldHunt = true;
        }

        private function reconnectChannel(_arg_1:TimerEvent):void
        {
            _reconnectTimer.stop();
            _reconnectTimer.removeEventListener(TimerEvent.TIMER, reconnectChannel);
            _reconnectTimer = null;
            connectChannel();
        }

        [Bindable(event="propertyChange")]
        public function get connected():Boolean
        {
            return (_connected);
        }

        public function login(_arg_1:String, _arg_2:String, _arg_3:String=null):AsyncToken
        {
            var _local_7:String;
            var _local_8:Base64Encoder;
            if (authenticated)
            {
                throw (new IllegalOperationError("ChannelSet is already authenticated."));
            };
            if (((!(_authAgent == null)) && (!(_authAgent.state == AuthenticationAgent.LOGGED_OUT_STATE))))
            {
                throw (new IllegalOperationError("ChannelSet is in the process of logging in or logging out."));
            };
            if (_arg_3 != Base64Encoder.CHARSET_UTF_8)
            {
                _arg_3 = null;
            };
            var _local_4:String;
            if (((!(_arg_1 == null)) && (!(_arg_2 == null))))
            {
                _local_7 = ((_arg_1 + ":") + _arg_2);
                _local_8 = new Base64Encoder();
                if (_arg_3 == Base64Encoder.CHARSET_UTF_8)
                {
                    _local_8.encodeUTFBytes(_local_7);
                }
                else
                {
                    _local_8.encode(_local_7);
                };
                _local_4 = _local_8.drain();
            };
            var _local_5:CommandMessage = new CommandMessage();
            _local_5.operation = CommandMessage.LOGIN_OPERATION;
            _local_5.body = _local_4;
            if (_arg_3 != null)
            {
                _local_5.headers[CommandMessage.CREDENTIALS_CHARSET_HEADER] = _arg_3;
            };
            _local_5.destination = "auth";
            var _local_6:AsyncToken = new AsyncToken(_local_5);
            if (_authAgent == null)
            {
                _authAgent = new AuthenticationAgent(this);
            };
            _authAgent.registerToken(_local_6);
            _authAgent.state = AuthenticationAgent.LOGGING_IN_STATE;
            send(_authAgent, _local_5);
            return (_local_6);
        }

        protected function sendHeartbeat():void
        {
            var _local_1:PollingChannel = (currentChannel as PollingChannel);
            if (((!(_local_1 == null)) && (_local_1._shouldPoll)))
            {
                return;
            };
            var _local_2:CommandMessage = new CommandMessage();
            _local_2.operation = CommandMessage.CLIENT_PING_OPERATION;
            _local_2.headers[CommandMessage.HEARTBEAT_HEADER] = true;
            currentChannel.sendInternalMessage(new MessageResponder(null, _local_2));
        }

        private function hunt():Boolean
        {
            var _local_1:String;
            if (_channels.length == 0)
            {
                _local_1 = resourceManager.getString("messaging", "noAvailableChannels");
                throw (new NoChannelAvailableError(_local_1));
            };
            if (_currentChannel != null)
            {
                disconnectChannel();
            };
            if (++_currentChannelIndex >= _channels.length)
            {
                _currentChannelIndex = -1;
                return (false);
            };
            if (_currentChannelIndex > 0)
            {
                _hunting = true;
            };
            if (configured)
            {
                if (_channels[_currentChannelIndex] != null)
                {
                    _currentChannel = _channels[_currentChannelIndex];
                }
                else
                {
                    _currentChannel = ServerConfig.getChannel(_channelIds[_currentChannelIndex], _clustered);
                    _currentChannel.setCredentials(_credentials);
                    _channels[_currentChannelIndex] = _currentChannel;
                };
            }
            else
            {
                _currentChannel = _channels[_currentChannelIndex];
            };
            if (((!(_channelFailoverURIs == null)) && (!(_channelFailoverURIs[_currentChannel.id] == null))))
            {
                _currentChannel.failoverURIs = _channelFailoverURIs[_currentChannel.id];
            };
            return (true);
        }

        public function get clustered():Boolean
        {
            return (_clustered);
        }

        public function disconnect(_arg_1:MessageAgent):void
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:PendingSend;
            if (_arg_1 == null)
            {
                _local_2 = _messageAgents.slice();
                _local_3 = _local_2.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_2[_local_4].disconnect();
                    _local_4++;
                };
                if (_authAgent != null)
                {
                    _authAgent.state = AuthenticationAgent.SHUTDOWN_STATE;
                    _authAgent = null;
                };
            }
            else
            {
                _local_5 = ((_arg_1 != null) ? _messageAgents.indexOf(_arg_1) : -1);
                if (_local_5 != -1)
                {
                    _messageAgents.splice(_local_5, 1);
                    removeEventListener(ChannelEvent.CONNECT, _arg_1.channelConnectHandler);
                    removeEventListener(ChannelEvent.DISCONNECT, _arg_1.channelDisconnectHandler);
                    removeEventListener(ChannelFaultEvent.FAULT, _arg_1.channelFaultHandler);
                    if (((connected) || (_connecting)))
                    {
                        _arg_1.channelDisconnectHandler(ChannelEvent.createEvent(ChannelEvent.DISCONNECT, _currentChannel, false));
                    }
                    else
                    {
                        _local_6 = _pendingSends.length;
                        _local_7 = 0;
                        while (_local_7 < _local_6)
                        {
                            _local_8 = PendingSend(_pendingSends[_local_7]);
                            if (_local_8.agent == _arg_1)
                            {
                                _pendingSends.splice(_local_7, 1);
                                _local_7--;
                                _local_6--;
                                delete _pendingMessages[_local_8.message];
                            };
                            _local_7++;
                        };
                    };
                    if (_messageAgents.length == 0)
                    {
                        _shouldBeConnected = false;
                        _currentChannelIndex = -1;
                        if (connected)
                        {
                            disconnectChannel();
                        };
                    };
                    if (_arg_1.channelSetMode == MessageAgent.AUTO_CONFIGURED_CHANNELSET)
                    {
                        _arg_1.internalSetChannelSet(null);
                    };
                };
            };
        }

        public function set channels(_arg_1:Array):void
        {
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            if (configured)
            {
                _local_5 = resourceManager.getString("messaging", "cannotAddWhenConfigured");
                throw (new IllegalOperationError(_local_5));
            };
            var _local_2:Array = _channels.slice();
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                removeChannel(_local_2[_local_4]);
                _local_4++;
            };
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                _local_6 = _arg_1.length;
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    addChannel(_arg_1[_local_7]);
                    _local_7++;
                };
            };
        }

        public function addChannel(_arg_1:Channel):void
        {
            var _local_2:String;
            if (_arg_1 == null)
            {
                return;
            };
            if (configured)
            {
                _local_2 = resourceManager.getString("messaging", "cannotAddWhenConfigured");
                throw (new IllegalOperationError(_local_2));
            };
            if (((clustered) && (_arg_1.id == null)))
            {
                _local_2 = resourceManager.getString("messaging", "cannotAddNullIdChannelWhenClustered");
                throw (new IllegalOperationError(_local_2));
            };
            if (_channels.indexOf(_arg_1) != -1)
            {
                return;
            };
            _channels.push(_arg_1);
            if (_credentials)
            {
                _arg_1.setCredentials(_credentials, null, _credentialsCharset);
            };
        }

        protected function scheduleHeartbeat():void
        {
            if (((_heartbeatTimer == null) && (heartbeatInterval > 0)))
            {
                _heartbeatTimer = new Timer(heartbeatInterval, 1);
                _heartbeatTimer.addEventListener(TimerEvent.TIMER, sendHeartbeatHandler);
                _heartbeatTimer.start();
            };
        }

        public function send(_arg_1:MessageAgent, _arg_2:IMessage):void
        {
            var _local_3:AcknowledgeMessage;
            var _local_4:CommandMessage;
            if ((((!(_currentChannel == null)) && (_currentChannel.connected)) && (!(_arg_1.needsConfig))))
            {
                if (((_arg_2 is CommandMessage) && (CommandMessage(_arg_2).operation == CommandMessage.TRIGGER_CONNECT_OPERATION)))
                {
                    _local_3 = new AcknowledgeMessage();
                    _local_3.clientId = _arg_1.clientId;
                    _local_3.correlationId = _arg_2.messageId;
                    new AsyncDispatcher(_arg_1.acknowledge, [_local_3, _arg_2], 1);
                    return;
                };
                if (((!(_hasRequestedClusterEndpoints)) && (clustered)))
                {
                    _local_4 = new CommandMessage();
                    if ((_arg_1 is AuthenticationAgent))
                    {
                        _local_4.destination = initialDestinationId;
                    }
                    else
                    {
                        _local_4.destination = _arg_1.destination;
                    };
                    _local_4.operation = CommandMessage.CLUSTER_REQUEST_OPERATION;
                    _currentChannel.sendInternalMessage(new ClusterMessageResponder(_local_4, this));
                    _hasRequestedClusterEndpoints = true;
                };
                unscheduleHeartbeat();
                _currentChannel.send(_arg_1, _arg_2);
                scheduleHeartbeat();
            }
            else
            {
                if (_pendingMessages[_arg_2] == null)
                {
                    _pendingMessages[_arg_2] = true;
                    _pendingSends.push(new PendingSend(_arg_1, _arg_2));
                };
                if (!_connecting)
                {
                    if (((_currentChannel == null) || (_currentChannelIndex == -1)))
                    {
                        hunt();
                    };
                    if ((_currentChannel is NetConnectionChannel))
                    {
                        if (_reconnectTimer == null)
                        {
                            _reconnectTimer = new Timer(1, 1);
                            _reconnectTimer.addEventListener(TimerEvent.TIMER, reconnectChannel);
                            _reconnectTimer.start();
                        };
                    }
                    else
                    {
                        connectChannel();
                    };
                };
            };
        }

        public function logout(_arg_1:MessageAgent=null):AsyncToken
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:CommandMessage;
            var _local_5:AsyncToken;
            var _local_6:int;
            var _local_7:int;
            _credentials = null;
            if (_arg_1 == null)
            {
                if (((!(_authAgent == null)) && ((_authAgent.state == AuthenticationAgent.LOGGING_OUT_STATE) || (_authAgent.state == AuthenticationAgent.LOGGING_IN_STATE))))
                {
                    throw (new IllegalOperationError("ChannelSet is in the process of logging in or logging out."));
                };
                _local_2 = _messageAgents.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _messageAgents[_local_3].internalSetCredentials(null);
                    _local_3++;
                };
                _local_2 = _channels.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (_channels[_local_3] != null)
                    {
                        _channels[_local_3].internalSetCredentials(null);
                        if ((_channels[_local_3] is PollingChannel))
                        {
                            PollingChannel(_channels[_local_3]).disablePolling();
                        };
                    };
                    _local_3++;
                };
                _local_4 = new CommandMessage();
                _local_4.operation = CommandMessage.LOGOUT_OPERATION;
                _local_4.destination = "auth";
                _local_5 = new AsyncToken(_local_4);
                if (_authAgent == null)
                {
                    _authAgent = new AuthenticationAgent(this);
                };
                _authAgent.registerToken(_local_5);
                _authAgent.state = AuthenticationAgent.LOGGING_OUT_STATE;
                send(_authAgent, _local_4);
                return (_local_5);
            };
            _local_6 = _channels.length;
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                if (_channels[_local_7] != null)
                {
                    _channels[_local_7].logout(_arg_1);
                };
                _local_7++;
            };
            return (null);
        }

        public function set clustered(_arg_1:Boolean):void
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:int;
            var _local_5:String;
            if (_clustered != _arg_1)
            {
                if (_arg_1)
                {
                    _local_2 = channelIds;
                    _local_3 = _local_2.length;
                    _local_4 = 0;
                    while (_local_4 < _local_3)
                    {
                        if (_local_2[_local_4] == null)
                        {
                            _local_5 = resourceManager.getString("messaging", "cannotSetClusteredWithdNullChannelIds");
                            throw (new IllegalOperationError(_local_5));
                        };
                        _local_4++;
                    };
                };
                _clustered = _arg_1;
            };
        }

        public function get channelIds():Array
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:int;
            if (_channelIds != null)
            {
                return (_channelIds);
            };
            _local_1 = [];
            _local_2 = _channels.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                if (_channels[_local_3] != null)
                {
                    _local_1.push(_channels[_local_3].id);
                }
                else
                {
                    _local_1.push(null);
                };
                _local_3++;
            };
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get authenticated():Boolean
        {
            return (_authenticated);
        }

        private function connectChannel():void
        {
            _connecting = true;
            _currentChannel.connect(this);
            _currentChannel.addEventListener(MessageEvent.MESSAGE, messageHandler);
        }

        protected function unscheduleHeartbeat():void
        {
            if (_heartbeatTimer != null)
            {
                _heartbeatTimer.stop();
                _heartbeatTimer.removeEventListener(TimerEvent.TIMER, sendHeartbeatHandler);
                _heartbeatTimer = null;
            };
        }

        mx_internal function get channelFailoverURIs():Object
        {
            return (_channelFailoverURIs);
        }

        mx_internal function get configured():Boolean
        {
            return (_configured);
        }

        public function setCredentials(_arg_1:String, _arg_2:MessageAgent, _arg_3:String=null):void
        {
            _credentials = _arg_1;
            var _local_4:int = _channels.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                if (_channels[_local_5] != null)
                {
                    _channels[_local_5].setCredentials(_credentials, _arg_2, _arg_3);
                };
                _local_5++;
            };
        }

        public function set heartbeatInterval(_arg_1:int):void
        {
            var _local_2:PropertyChangeEvent;
            if (_heartbeatInterval != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "heartbeatInterval", _heartbeatInterval, _arg_1);
                _heartbeatInterval = _arg_1;
                dispatchEvent(_local_2);
                if (((_heartbeatInterval > 0) && (connected)))
                {
                    scheduleHeartbeat();
                };
            };
        }

        protected function messageHandler(_arg_1:MessageEvent):void
        {
            dispatchEvent(_arg_1);
        }

        protected function setConnected(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            if (_connected != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "connected", _connected, _arg_1);
                _connected = _arg_1;
                dispatchEvent(_local_2);
                setAuthenticated((((_arg_1) && (currentChannel)) && (currentChannel.authenticated)), _credentials, false);
                if (!connected)
                {
                    unscheduleHeartbeat();
                }
                else
                {
                    if (heartbeatInterval > 0)
                    {
                        scheduleHeartbeat();
                    };
                };
            };
        }

        public function get currentChannel():Channel
        {
            return (_currentChannel);
        }

        private function disconnectChannel():void
        {
            _connecting = false;
            _currentChannel.removeEventListener(MessageEvent.MESSAGE, messageHandler);
            _currentChannel.disconnect(this);
        }

        public function get channels():Array
        {
            return (_channels);
        }

        public function set initialDestinationId(_arg_1:String):void
        {
            _initialDestinationId = _arg_1;
        }

        protected function faultPendingSends(_arg_1:ChannelEvent):void
        {
            var _local_2:PendingSend;
            var _local_3:IMessage;
            var _local_4:ErrorMessage;
            var _local_5:ChannelFaultEvent;
            while (_pendingSends.length > 0)
            {
                _local_2 = (_pendingSends.shift() as PendingSend);
                _local_3 = _local_2.message;
                delete _pendingMessages[_local_3];
                _local_4 = new ErrorMessage();
                _local_4.correlationId = _local_3.messageId;
                _local_4.headers[ErrorMessage.RETRYABLE_HINT_HEADER] = true;
                _local_4.faultCode = "Client.Error.MessageSend";
                _local_4.faultString = resourceManager.getString("messaging", "sendFailed");
                if ((_arg_1 is ChannelFaultEvent))
                {
                    _local_5 = (_arg_1 as ChannelFaultEvent);
                    _local_4.faultDetail = ((((_local_5.faultCode + " ") + _local_5.faultString) + " ") + _local_5.faultDetail);
                    if (_local_5.faultCode == "Channel.Authentication.Error")
                    {
                        _local_4.faultCode = _local_5.faultCode;
                    };
                }
                else
                {
                    _local_4.faultDetail = resourceManager.getString("messaging", "cannotConnectToDestination");
                };
                _local_4.rootCause = _arg_1;
                _local_2.agent.fault(_local_4, _local_3);
            };
        }

        public function channelDisconnectHandler(_arg_1:ChannelEvent):void
        {
            _connecting = false;
            setConnected(false);
            if ((((_shouldBeConnected) && (!(_arg_1.reconnecting))) && (!(_arg_1.rejected))))
            {
                if (((_shouldHunt) && (hunt())))
                {
                    _arg_1.reconnecting = true;
                    dispatchEvent(_arg_1);
                    if ((_currentChannel is NetConnectionChannel))
                    {
                        if (_reconnectTimer == null)
                        {
                            _reconnectTimer = new Timer(1, 1);
                            _reconnectTimer.addEventListener(TimerEvent.TIMER, reconnectChannel);
                            _reconnectTimer.start();
                        };
                    }
                    else
                    {
                        connectChannel();
                    };
                }
                else
                {
                    dispatchEvent(_arg_1);
                    faultPendingSends(_arg_1);
                };
            }
            else
            {
                dispatchEvent(_arg_1);
                if (_arg_1.rejected)
                {
                    faultPendingSends(_arg_1);
                };
            };
            _shouldHunt = true;
        }

        public function removeChannel(_arg_1:Channel):void
        {
            var _local_3:String;
            if (configured)
            {
                _local_3 = resourceManager.getString("messaging", "cannotRemoveWhenConfigured");
                throw (new IllegalOperationError(_local_3));
            };
            var _local_2:int = _channels.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _channels.splice(_local_2, 1);
                if (((!(_currentChannel == null)) && (_currentChannel == _arg_1)))
                {
                    if (connected)
                    {
                        _shouldHunt = false;
                        disconnectChannel();
                    };
                    _currentChannel = null;
                    _currentChannelIndex = -1;
                };
            };
        }

        public function get heartbeatInterval():int
        {
            return (_heartbeatInterval);
        }

        public function channelConnectHandler(_arg_1:ChannelEvent):void
        {
            var _local_3:PendingSend;
            var _local_4:CommandMessage;
            var _local_5:AcknowledgeMessage;
            _connecting = false;
            _connected = true;
            _currentChannelIndex = -1;
            while (_pendingSends.length > 0)
            {
                _local_3 = PendingSend(_pendingSends.shift());
                delete _pendingMessages[_local_3.message];
                _local_4 = (_local_3.message as CommandMessage);
                if (_local_4 != null)
                {
                    if (_local_4.operation == CommandMessage.TRIGGER_CONNECT_OPERATION)
                    {
                        _local_5 = new AcknowledgeMessage();
                        _local_5.clientId = _local_3.agent.clientId;
                        _local_5.correlationId = _local_4.messageId;
                        _local_3.agent.acknowledge(_local_5, _local_4);
                        continue;
                    };
                    if ((((!(_local_3.agent.configRequested)) && (_local_3.agent.needsConfig)) && (_local_4.operation == CommandMessage.CLIENT_PING_OPERATION)))
                    {
                        _local_4.headers[CommandMessage.NEEDS_CONFIG_HEADER] = true;
                        _local_3.agent.configRequested = true;
                    };
                };
                send(_local_3.agent, _local_3.message);
            };
            if (_hunting)
            {
                _arg_1.reconnecting = true;
                _hunting = false;
            };
            dispatchEvent(_arg_1);
            var _local_2:PropertyChangeEvent = PropertyChangeEvent.createUpdateEvent(this, "connected", false, true);
            dispatchEvent(_local_2);
        }

        public function get initialDestinationId():String
        {
            return (_initialDestinationId);
        }

        public function connect(_arg_1:MessageAgent):void
        {
            if (((!(_arg_1 == null)) && (_messageAgents.indexOf(_arg_1) == -1)))
            {
                _shouldBeConnected = true;
                _messageAgents.push(_arg_1);
                _arg_1.internalSetChannelSet(this);
                addEventListener(ChannelEvent.CONNECT, _arg_1.channelConnectHandler);
                addEventListener(ChannelEvent.DISCONNECT, _arg_1.channelDisconnectHandler);
                addEventListener(ChannelFaultEvent.FAULT, _arg_1.channelFaultHandler);
                if (((connected) && (!(_arg_1.needsConfig))))
                {
                    _arg_1.channelConnectHandler(ChannelEvent.createEvent(ChannelEvent.CONNECT, _currentChannel, false, false, connected));
                };
            };
        }

        public function channelFaultHandler(_arg_1:ChannelFaultEvent):void
        {
            if (_arg_1.channel.connected)
            {
                dispatchEvent(_arg_1);
            }
            else
            {
                _connecting = false;
                setConnected(false);
                if ((((_shouldBeConnected) && (!(_arg_1.reconnecting))) && (!(_arg_1.rejected))))
                {
                    if (hunt())
                    {
                        _arg_1.reconnecting = true;
                        dispatchEvent(_arg_1);
                        if ((_currentChannel is NetConnectionChannel))
                        {
                            if (_reconnectTimer == null)
                            {
                                _reconnectTimer = new Timer(1, 1);
                                _reconnectTimer.addEventListener(TimerEvent.TIMER, reconnectChannel);
                                _reconnectTimer.start();
                            };
                        }
                        else
                        {
                            connectChannel();
                        };
                    }
                    else
                    {
                        dispatchEvent(_arg_1);
                        faultPendingSends(_arg_1);
                    };
                }
                else
                {
                    dispatchEvent(_arg_1);
                    if (_arg_1.rejected)
                    {
                        faultPendingSends(_arg_1);
                    };
                };
            };
        }

        mx_internal function setAuthenticated(_arg_1:Boolean, _arg_2:String, _arg_3:Boolean=true):void
        {
            var _local_4:PropertyChangeEvent;
            var _local_5:MessageAgent;
            var _local_6:int;
            if (_authenticated != _arg_1)
            {
                _local_4 = PropertyChangeEvent.createUpdateEvent(this, "authenticated", _authenticated, _arg_1);
                _authenticated = _arg_1;
                if (_arg_3)
                {
                    _local_6 = 0;
                    while (_local_6 < _messageAgents.length)
                    {
                        _local_5 = MessageAgent(_messageAgents[_local_6]);
                        _local_5.setAuthenticated(_arg_1, _arg_2);
                        _local_6++;
                    };
                };
                dispatchEvent(_local_4);
            };
        }

        protected function sendHeartbeatHandler(_arg_1:TimerEvent):void
        {
            unscheduleHeartbeat();
            if (currentChannel != null)
            {
                sendHeartbeat();
                scheduleHeartbeat();
            };
        }

        private function dispatchRPCEvent(_arg_1:AbstractEvent):void
        {
            _arg_1.callTokenResponders();
            dispatchEvent(_arg_1);
        }

        mx_internal function authenticationSuccess(_arg_1:AuthenticationAgent, _arg_2:AsyncToken, _arg_3:AcknowledgeMessage):void
        {
            var _local_8:int;
            var _local_9:int;
            var _local_4:CommandMessage = CommandMessage(_arg_2.message);
            var _local_5:* = (_local_4.operation == CommandMessage.LOGIN_OPERATION);
            var _local_6:String = ((_local_5) ? String(_local_4.body) : null);
            if (_local_5)
            {
                _credentials = _local_6;
                _local_8 = _messageAgents.length;
                _local_9 = 0;
                while (_local_9 < _local_8)
                {
                    _messageAgents[_local_9].internalSetCredentials(_local_6);
                    _local_9++;
                };
                _local_8 = _channels.length;
                _local_9 = 0;
                while (_local_9 < _local_8)
                {
                    if (_channels[_local_9] != null)
                    {
                        _channels[_local_9].internalSetCredentials(_local_6);
                    };
                    _local_9++;
                };
                _arg_1.state = AuthenticationAgent.LOGGED_IN_STATE;
                currentChannel.setAuthenticated(true);
            }
            else
            {
                _arg_1.state = AuthenticationAgent.SHUTDOWN_STATE;
                _authAgent = null;
                disconnect(_arg_1);
                currentChannel.setAuthenticated(false);
            };
            var _local_7:ResultEvent = ResultEvent.createEvent(_arg_3.body, _arg_2, _arg_3);
            dispatchRPCEvent(_local_7);
        }

        public function disconnectAll():void
        {
            disconnect(null);
        }

        public function get messageAgents():Array
        {
            return (_messageAgents);
        }

        mx_internal function set channelFailoverURIs(_arg_1:Object):void
        {
            var _local_4:Channel;
            _channelFailoverURIs = _arg_1;
            var _local_2:int = _channels.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = _channels[_local_3];
                if (_local_4 == null) break;
                if (_channelFailoverURIs[_local_4.id] != null)
                {
                    _local_4.failoverURIs = _channelFailoverURIs[_local_4.id];
                };
                _local_3++;
            };
        }

        mx_internal function authenticationFailure(_arg_1:AuthenticationAgent, _arg_2:AsyncToken, _arg_3:ErrorMessage):void
        {
            var _local_4:MessageFaultEvent = MessageFaultEvent.createEvent(_arg_3);
            var _local_5:FaultEvent = FaultEvent.createEventFromMessageFault(_local_4, _arg_2);
            _arg_1.state = AuthenticationAgent.SHUTDOWN_STATE;
            _authAgent = null;
            disconnect(_arg_1);
            dispatchRPCEvent(_local_5);
        }

        override public function toString():String
        {
            var _local_1:* = "[ChannelSet ";
            var _local_2:uint;
            while (_local_2 < _channels.length)
            {
                if (_channels[_local_2] != null)
                {
                    _local_1 = (_local_1 + (_channels[_local_2].id + " "));
                };
                _local_2++;
            };
            return (_local_1 + "]");
        }


    }
}//package mx.messaging

import mx.messaging.MessageAgent;
import mx.logging.Log;
import mx.messaging.ChannelSet;
import mx.rpc.AsyncToken;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.messages.IMessage;
import mx.messaging.events.ChannelEvent;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.MessageResponder;
import mx.collections.ArrayCollection;
import mx.core.mx_internal; 

use namespace mx_internal;

class AuthenticationAgent extends MessageAgent 
{

    public static const LOGGED_OUT_STATE:int = 0;
    public static const LOGGING_IN_STATE:int = 1;
    public static const LOGGED_IN_STATE:int = 2;
    public static const LOGGING_OUT_STATE:int = 3;
    public static const SHUTDOWN_STATE:int = 4;

    /*private*/ var _state:int = 0;
    /*private*/ var tokens:Object = {};

    public function AuthenticationAgent(_arg_1:ChannelSet)
    {
        _log = Log.getLogger("ChannelSet.AuthenticationAgent");
        _agentType = "authentication agent";
        this.channelSet = _arg_1;
    }

    public function get state():int
    {
        return (_state);
    }

    public function registerToken(_arg_1:AsyncToken):void
    {
        tokens[_arg_1.message.messageId] = _arg_1;
    }

    public function set state(_arg_1:int):void
    {
        _state = _arg_1;
        if (_arg_1 == SHUTDOWN_STATE)
        {
            tokens = null;
        };
    }

    override public function acknowledge(_arg_1:AcknowledgeMessage, _arg_2:IMessage):void
    {
        var _local_4:AsyncToken;
        if (state == SHUTDOWN_STATE)
        {
            return;
        };
        var _local_3:Boolean = _arg_1.headers[AcknowledgeMessage.ERROR_HINT_HEADER];
        super.acknowledge(_arg_1, _arg_2);
        if (!_local_3)
        {
            _local_4 = tokens[_arg_2.messageId];
            delete tokens[_arg_2.messageId];
            channelSet.authenticationSuccess(this, _local_4, (_arg_1 as AcknowledgeMessage));
        };
    }

    override public function fault(_arg_1:ErrorMessage, _arg_2:IMessage):void
    {
        var _local_4:AcknowledgeMessage;
        if (state == SHUTDOWN_STATE)
        {
            return;
        };
        if (((_arg_1.rootCause is ChannelEvent) && ((_arg_1.rootCause as ChannelEvent).type == ChannelEvent.DISCONNECT)))
        {
            _local_4 = new AcknowledgeMessage();
            _local_4.clientId = clientId;
            _local_4.correlationId = _arg_2.messageId;
            acknowledge(_local_4, _arg_2);
            return;
        };
        super.fault(_arg_1, _arg_2);
        var _local_3:AsyncToken = tokens[_arg_2.messageId];
        delete tokens[_arg_2.messageId];
        channelSet.authenticationFailure(this, _local_3, (_arg_1 as ErrorMessage));
    }


}

class PendingSend 
{

    public var agent:MessageAgent;
    public var message:IMessage;

    public function PendingSend(_arg_1:MessageAgent, _arg_2:IMessage)
    {
        this.agent = _arg_1;
        this.message = _arg_2;
    }

}

class ClusterMessageResponder extends MessageResponder 
{

    /*private*/ var _channelSet:ChannelSet;

    public function ClusterMessageResponder(_arg_1:IMessage, _arg_2:ChannelSet)
    {
        super(null, _arg_1);
        _channelSet = _arg_2;
    }

    override protected function resultHandler(_arg_1:IMessage):void
    {
        var _local_2:Object;
        var _local_3:Array;
        var _local_4:int;
        var _local_5:int;
        var _local_6:Object;
        var _local_7:Object;
        if (((!(_arg_1.body == null)) && ((_arg_1.body is Array) || (_arg_1.body is ArrayCollection))))
        {
            _local_2 = {};
            _local_3 = ((_arg_1.body is Array) ? (_arg_1.body as Array) : (_arg_1.body as ArrayCollection).toArray());
            _local_4 = _local_3.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = _local_3[_local_5];
                for (_local_7 in _local_6)
                {
                    if (_local_2[_local_7] == null)
                    {
                        _local_2[_local_7] = [];
                    };
                    _local_2[_local_7].push(_local_6[_local_7]);
                };
                _local_5++;
            };
            _channelSet.channelFailoverURIs = _local_2;
        };
    }


}


