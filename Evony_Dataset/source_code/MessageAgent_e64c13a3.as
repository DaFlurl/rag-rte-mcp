// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.MessageAgent

package mx.messaging
{
    import flash.events.EventDispatcher;
    import mx.core.IMXMLObject;
    import mx.logging.ILogger;
    import mx.messaging.events.ChannelEvent;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.utils.UIDUtil;
    import mx.messaging.config.ServerConfig;
    import mx.messaging.messages.CommandMessage;
    import mx.messaging.messages.IMessage;
    import mx.events.PropertyChangeEvent;
    import mx.logging.Log;
    import mx.messaging.messages.MessagePerformanceUtils;
    import mx.messaging.config.ConfigMap;
    import mx.messaging.events.MessageAckEvent;
    import mx.messaging.messages.AcknowledgeMessage;
    import mx.messaging.messages.ErrorMessage;
    import mx.messaging.events.MessageFaultEvent;
    import mx.utils.Base64Encoder;
    import mx.netmon.NetworkMonitor;
    import mx.messaging.events.MessageEvent;
    import mx.messaging.events.ChannelFaultEvent;
    import mx.messaging.messages.AbstractMessage;
    import mx.messaging.errors.InvalidDestinationError;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class MessageAgent extends EventDispatcher implements IMXMLObject 
    {

        mx_internal static const AUTO_CONFIGURED_CHANNELSET:int = 0;
        mx_internal static const MANUALLY_ASSIGNED_CHANNELSET:int = 1;

        private var _needsConfig:Boolean;
        protected var _disconnectBarrier:Boolean;
        protected var _log:ILogger;
        private var _connected:Boolean = false;
        private var _clientId:String;
        private var _sendRemoteCredentials:Boolean;
        private var _authenticated:Boolean;
        protected var _ignoreFault:Boolean = false;
        protected var _credentials:String;
        private var _channelSetMode:int = 0;
        mx_internal var configRequested:Boolean = false;
        private var _pendingConnectEvent:ChannelEvent;
        protected var _credentialsCharset:String;
        private var _remoteCredentials:String = "";
        private var _destination:String = "";
        protected var _agentType:String = "mx.messaging.MessageAgent";
        private var _requestTimeout:int = -1;
        private var _remoteCredentialsCharset:String;
        private var _clientIdWaitQueue:Array;
        private var _channelSet:ChannelSet;

        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _id:String = UIDUtil.createUID();


        [Bindable(event="propertyChange")]
        public function get connected():Boolean
        {
            return (_connected);
        }

        [Bindable(event="propertyChange")]
        public function get destination():String
        {
            return (_destination);
        }

        protected function initChannelSet(_arg_1:IMessage):void
        {
            if (_channelSet == null)
            {
                _channelSetMode = AUTO_CONFIGURED_CHANNELSET;
                internalSetChannelSet(ServerConfig.getChannelSet(destination));
            };
            if ((((_channelSet.connected) && (needsConfig)) && (!(configRequested))))
            {
                _arg_1.headers[CommandMessage.NEEDS_CONFIG_HEADER] = true;
                configRequested = true;
            };
            _channelSet.connect(this);
            if (_credentials != null)
            {
                channelSet.setCredentials(_credentials, this, _credentialsCharset);
            };
        }

        mx_internal function set needsConfig(value:Boolean):void
        {
            var cs:ChannelSet;
            if (_needsConfig == value)
            {
                return;
            };
            _needsConfig = value;
            if (_needsConfig)
            {
                cs = channelSet;
                try
                {
                    disconnect();
                }
                finally
                {
                    internalSetChannelSet(cs);
                };
            };
        }

        public function logout():void
        {
            _credentials = null;
            if (channelSet)
            {
                channelSet.logout(this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get id():String
        {
            return (_id);
        }

        public function set destination(_arg_1:String):void
        {
            var _local_2:PropertyChangeEvent;
            if (((_arg_1 == null) || (_arg_1.length == 0)))
            {
                return;
            };
            if (_destination != _arg_1)
            {
                if (((_channelSetMode == AUTO_CONFIGURED_CHANNELSET) && (!(channelSet == null))))
                {
                    channelSet.disconnect(this);
                    channelSet = null;
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "destination", _destination, _arg_1);
                _destination = _arg_1;
                dispatchEvent(_local_2);
                if (Log.isInfo())
                {
                    _log.info("'{0}' {2} set destination to '{1}'.", id, _destination, _agentType);
                };
            };
        }

        mx_internal function get channelSetMode():int
        {
            return (_channelSetMode);
        }

        public function acknowledge(ackMsg:AcknowledgeMessage, msg:IMessage):void
        {
            var mpiutil:MessagePerformanceUtils;
            if (Log.isInfo())
            {
                _log.info("'{0}' {2} acknowledge of '{1}'.", id, msg.messageId, _agentType);
            };
            if (((((Log.isDebug()) && (!(channelSet == null))) && (!(channelSet.currentChannel == null))) && (channelSet.currentChannel.mpiEnabled)))
            {
                try
                {
                    mpiutil = new MessagePerformanceUtils(ackMsg);
                    _log.debug(mpiutil.prettyPrint());
                }
                catch(e:Error)
                {
                    _log.debug(("Could not get message performance information for: " + msg.toString()));
                };
            };
            if (configRequested)
            {
                configRequested = false;
                ServerConfig.updateServerConfigData((ackMsg.body as ConfigMap));
                needsConfig = false;
                if (_pendingConnectEvent)
                {
                    channelConnectHandler(_pendingConnectEvent);
                };
                _pendingConnectEvent = null;
            };
            if (clientId == null)
            {
                if (ackMsg.clientId != null)
                {
                    setClientId(ackMsg.clientId);
                }
                else
                {
                    flushClientIdWaitQueue();
                };
            };
            dispatchEvent(MessageAckEvent.createEvent(ackMsg, msg));
            monitorRpcMessage(ackMsg, msg);
        }

        mx_internal function internalSetChannelSet(_arg_1:ChannelSet):void
        {
            var _local_2:PropertyChangeEvent;
            if (_channelSet != _arg_1)
            {
                if (_channelSet != null)
                {
                    _channelSet.disconnect(this);
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "channelSet", _channelSet, _arg_1);
                _channelSet = _arg_1;
                if (_channelSet != null)
                {
                    if (_credentials)
                    {
                        _channelSet.setCredentials(_credentials, this, _credentialsCharset);
                    };
                    _channelSet.connect(this);
                };
                dispatchEvent(_local_2);
            };
        }

        public function fault(_arg_1:ErrorMessage, _arg_2:IMessage):void
        {
            if (Log.isError())
            {
                _log.error("'{0}' {2} fault for '{1}'.", id, _arg_2.messageId, _agentType);
            };
            _ignoreFault = false;
            configRequested = false;
            if (_arg_1.headers[ErrorMessage.RETRYABLE_HINT_HEADER])
            {
                delete _arg_1.headers[ErrorMessage.RETRYABLE_HINT_HEADER];
            };
            if (clientId == null)
            {
                if (_arg_1.clientId != null)
                {
                    setClientId(_arg_1.clientId);
                }
                else
                {
                    flushClientIdWaitQueue();
                };
            };
            dispatchEvent(MessageFaultEvent.createEvent(_arg_1));
            monitorRpcMessage(_arg_1, _arg_2);
            if (((((_arg_1.faultCode == "Client.Authentication") && (authenticated)) && (!(channelSet == null))) && (!(channelSet.currentChannel == null))))
            {
                channelSet.currentChannel.setAuthenticated(false);
                if (channelSet.currentChannel.loginAfterDisconnect)
                {
                    reAuthorize(_arg_2);
                    _ignoreFault = true;
                };
            };
        }

        public function set requestTimeout(_arg_1:int):void
        {
            var _local_2:PropertyChangeEvent;
            if (_requestTimeout != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "requestTimeout", _requestTimeout, _arg_1);
                _requestTimeout = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        public function disconnect():void
        {
            if (!_disconnectBarrier)
            {
                _clientIdWaitQueue = null;
                if (connected)
                {
                    _disconnectBarrier = true;
                };
                if (_channelSetMode == AUTO_CONFIGURED_CHANNELSET)
                {
                    internalSetChannelSet(null);
                }
                else
                {
                    if (_channelSet != null)
                    {
                        _channelSet.disconnect(this);
                    };
                };
            };
        }

        public function set id(_arg_1:String):void
        {
            var _local_2:PropertyChangeEvent;
            if (_id != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "id", _id, _arg_1);
                _id = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        public function set channelSet(_arg_1:ChannelSet):void
        {
            internalSetChannelSet(_arg_1);
            _channelSetMode = MANUALLY_ASSIGNED_CHANNELSET;
        }

        [Bindable(event="propertyChange")]
        public function get clientId():String
        {
            return (_clientId);
        }

        protected function setConnected(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            if (_connected != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "connected", _connected, _arg_1);
                _connected = _arg_1;
                dispatchEvent(_local_2);
                setAuthenticated((((_arg_1) && (channelSet)) && (channelSet.authenticated)), _credentials);
            };
        }

        mx_internal function setClientId(_arg_1:String):void
        {
            var _local_2:PropertyChangeEvent;
            if (_clientId != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "clientId", _clientId, _arg_1);
                _clientId = _arg_1;
                flushClientIdWaitQueue();
                dispatchEvent(_local_2);
            };
        }

        public function setCredentials(_arg_1:String, _arg_2:String, _arg_3:String=null):void
        {
            var _local_4:String;
            var _local_5:Base64Encoder;
            if (((_arg_1 == null) && (_arg_2 == null)))
            {
                _credentials = null;
                _credentialsCharset = null;
            }
            else
            {
                _local_4 = ((_arg_1 + ":") + _arg_2);
                _local_5 = new Base64Encoder();
                if (_arg_3 == Base64Encoder.CHARSET_UTF_8)
                {
                    _local_5.encodeUTFBytes(_local_4);
                }
                else
                {
                    _local_5.encode(_local_4);
                };
                _credentials = _local_5.drain();
                _credentialsCharset = _arg_3;
            };
            if (channelSet != null)
            {
                channelSet.setCredentials(_credentials, this, _credentialsCharset);
            };
        }

        public function channelDisconnectHandler(_arg_1:ChannelEvent):void
        {
            if (Log.isWarn())
            {
                _log.warn("'{0}' {1} channel disconnected.", id, _agentType);
            };
            setConnected(false);
            if (_remoteCredentials != null)
            {
                _sendRemoteCredentials = true;
            };
            dispatchEvent(_arg_1);
        }

        public function setRemoteCredentials(_arg_1:String, _arg_2:String, _arg_3:String=null):void
        {
            var _local_4:String;
            var _local_5:Base64Encoder;
            if (((_arg_1 == null) && (_arg_2 == null)))
            {
                _remoteCredentials = "";
                _remoteCredentialsCharset = null;
            }
            else
            {
                _local_4 = ((_arg_1 + ":") + _arg_2);
                _local_5 = new Base64Encoder();
                if (_arg_3 == Base64Encoder.CHARSET_UTF_8)
                {
                    _local_5.encodeUTFBytes(_local_4);
                }
                else
                {
                    _local_5.encode(_local_4);
                };
                _remoteCredentials = _local_5.drain();
                _remoteCredentialsCharset = _arg_3;
            };
            _sendRemoteCredentials = true;
        }

        mx_internal function get needsConfig():Boolean
        {
            return (_needsConfig);
        }

        public function hasPendingRequestForMessage(_arg_1:IMessage):Boolean
        {
            return (false);
        }

        [Bindable(event="propertyChange")]
        public function get authenticated():Boolean
        {
            return (_authenticated);
        }

        [Bindable(event="propertyChange")]
        public function get requestTimeout():int
        {
            return (_requestTimeout);
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            this.id = _arg_2;
        }

        mx_internal function getNetmonId():String
        {
            return (null);
        }

        final protected function flushClientIdWaitQueue():void
        {
            var _local_1:Array;
            if (_clientIdWaitQueue != null)
            {
                if (clientId != null)
                {
                    while (_clientIdWaitQueue.length > 0)
                    {
                        internalSend((_clientIdWaitQueue.shift() as IMessage));
                    };
                };
                if (clientId == null)
                {
                    if (_clientIdWaitQueue.length > 0)
                    {
                        _local_1 = _clientIdWaitQueue;
                        _clientIdWaitQueue = null;
                        internalSend((_local_1.shift() as IMessage));
                        _clientIdWaitQueue = _local_1;
                    }
                    else
                    {
                        _clientIdWaitQueue = null;
                    };
                };
            };
        }

        private function monitorRpcMessage(_arg_1:IMessage, _arg_2:IMessage):void
        {
            if (NetworkMonitor.isMonitoring())
            {
                if ((_arg_1 is ErrorMessage))
                {
                    NetworkMonitor.monitorFault(_arg_2, MessageFaultEvent.createEvent(ErrorMessage(_arg_1)));
                }
                else
                {
                    if ((_arg_1 is AcknowledgeMessage))
                    {
                        NetworkMonitor.monitorResult(_arg_1, MessageEvent.createEvent(MessageEvent.RESULT, _arg_2));
                    }
                    else
                    {
                        NetworkMonitor.monitorInvocation(getNetmonId(), _arg_1, this);
                    };
                };
            };
        }

        final protected function assertCredentials(_arg_1:String):void
        {
            var _local_2:ErrorMessage;
            if (((!(_credentials == null)) && (!(_credentials == _arg_1))))
            {
                _local_2 = new ErrorMessage();
                _local_2.faultCode = "Client.Authentication.Error";
                _local_2.faultString = "Credentials specified do not match those used on underlying connection.";
                _local_2.faultDetail = "Channel was authenticated with a different set of credentials than those used for this agent.";
                dispatchEvent(MessageFaultEvent.createEvent(_local_2));
            };
        }

        [Bindable(event="propertyChange")]
        public function get channelSet():ChannelSet
        {
            return (_channelSet);
        }

        public function channelConnectHandler(_arg_1:ChannelEvent):void
        {
            _disconnectBarrier = false;
            if (needsConfig)
            {
                if (Log.isInfo())
                {
                    _log.info("'{0}' {1} waiting for configuration information.", id, _agentType);
                };
                _pendingConnectEvent = _arg_1;
            }
            else
            {
                if (Log.isInfo())
                {
                    _log.info("'{0}' {1} connected.", id, _agentType);
                };
                setConnected(true);
                dispatchEvent(_arg_1);
            };
        }

        mx_internal function internalSetCredentials(_arg_1:String):void
        {
            _credentials = _arg_1;
        }

        public function channelFaultHandler(_arg_1:ChannelFaultEvent):void
        {
            if (Log.isWarn())
            {
                _log.warn("'{0}' {1} channel faulted with {2} {3}", id, _agentType, _arg_1.faultCode, _arg_1.faultDetail);
            };
            if (!_arg_1.channel.connected)
            {
                setConnected(false);
                if (_remoteCredentials != null)
                {
                    _sendRemoteCredentials = true;
                };
            };
            dispatchEvent(_arg_1);
        }

        protected function internalSend(_arg_1:IMessage, _arg_2:Boolean=true):void
        {
            var _local_3:String;
            if ((((_arg_1.clientId == null) && (_arg_2)) && (clientId == null)))
            {
                if (_clientIdWaitQueue == null)
                {
                    _clientIdWaitQueue = [];
                }
                else
                {
                    _clientIdWaitQueue.push(_arg_1);
                    return;
                };
            };
            if (_arg_1.clientId == null)
            {
                _arg_1.clientId = clientId;
            };
            if (requestTimeout > 0)
            {
                _arg_1.headers[AbstractMessage.REQUEST_TIMEOUT_HEADER] = requestTimeout;
            };
            if (_sendRemoteCredentials)
            {
                if (!((_arg_1 is CommandMessage) && (CommandMessage(_arg_1).operation == CommandMessage.TRIGGER_CONNECT_OPERATION)))
                {
                    _arg_1.headers[AbstractMessage.REMOTE_CREDENTIALS_HEADER] = _remoteCredentials;
                    _arg_1.headers[AbstractMessage.REMOTE_CREDENTIALS_CHARSET_HEADER] = _remoteCredentialsCharset;
                    _sendRemoteCredentials = false;
                };
            };
            if (channelSet != null)
            {
                if (((!(connected)) && (_channelSetMode == MANUALLY_ASSIGNED_CHANNELSET)))
                {
                    _channelSet.connect(this);
                };
                if ((((channelSet.connected) && (needsConfig)) && (!(configRequested))))
                {
                    _arg_1.headers[CommandMessage.NEEDS_CONFIG_HEADER] = true;
                    configRequested = true;
                };
                channelSet.send(this, _arg_1);
                monitorRpcMessage(_arg_1, _arg_1);
            }
            else
            {
                if (((!(destination == null)) && (destination.length > 0)))
                {
                    initChannelSet(_arg_1);
                    if (channelSet != null)
                    {
                        channelSet.send(this, _arg_1);
                        monitorRpcMessage(_arg_1, _arg_1);
                    };
                }
                else
                {
                    _local_3 = resourceManager.getString("messaging", "destinationNotSet");
                    throw (new InvalidDestinationError(_local_3));
                };
            };
        }

        mx_internal function setAuthenticated(_arg_1:Boolean, _arg_2:String):void
        {
            var _local_3:PropertyChangeEvent;
            if (_authenticated != _arg_1)
            {
                _local_3 = PropertyChangeEvent.createUpdateEvent(this, "authenticated", _authenticated, _arg_1);
                _authenticated = _arg_1;
                dispatchEvent(_local_3);
                if (_arg_1)
                {
                    assertCredentials(_arg_2);
                };
            };
        }

        protected function reAuthorize(_arg_1:IMessage):void
        {
            disconnect();
            internalSend(_arg_1);
        }


    }
}//package mx.messaging

