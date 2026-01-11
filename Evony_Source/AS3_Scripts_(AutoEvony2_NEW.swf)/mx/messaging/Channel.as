// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.Channel

package mx.messaging
{
    import flash.events.EventDispatcher;
    import mx.core.IMXMLObject;
    import mx.collections.ArrayCollection;
    import flash.utils.Timer;
    import mx.logging.ILogger;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.logging.Log;
    import flash.events.TimerEvent;
    import mx.messaging.errors.InvalidChannelError;
    import mx.utils.URLUtil;
    import mx.messaging.config.LoaderConfig;
    import flash.errors.IllegalOperationError;
    import mx.messaging.messages.IMessage;
    import mx.messaging.messages.CommandMessage;
    import mx.messaging.messages.AbstractMessage;
    import mx.messaging.events.ChannelFaultEvent;
    import mx.events.PropertyChangeEvent;
    import mx.messaging.errors.InvalidDestinationError;
    import mx.messaging.events.ChannelEvent;
    import mx.messaging.config.ServerConfig;
    import flash.utils.getDefinitionByName;
    import mx.rpc.AsyncDispatcher;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Channel extends EventDispatcher implements IMXMLObject 
    {

        private static const CLIENT_LOAD_BALANCING:String = "client-load-balancing";
        private static const CONNECT_TIMEOUT_SECONDS:String = "connect-timeout-seconds";
        private static const ENABLE_SMALL_MESSAGES:String = "enable-small-messages";
        private static const FALSE:String = "false";
        private static const RECORD_MESSAGE_TIMES:String = "record-message-times";
        private static const RECORD_MESSAGE_SIZES:String = "record-message-sizes";
        private static const REQUEST_TIMEOUT_SECONDS:String = "request-timeout-seconds";
        private static const SERIALIZATION:String = "serialization";
        private static const TRUE:String = "true";
        public static const SMALL_MESSAGES_FEATURE:String = "small_messages";
        private static const dep:ArrayCollection = null;

        private var _failoverIndex:int;
        private var _ownsWaitGuard:Boolean;
        protected var _recordMessageTimes:Boolean = false;
        private var _reconnecting:Boolean = false;
        private var _reliableReconnectLastTimestamp:Number;
        private var _reliableReconnectAttempts:int;
        private var _authenticated:Boolean = false;
        protected var messagingVersion:Number = 1;
        private var _connectTimeout:int = -1;
        mx_internal var authenticating:Boolean;
        protected var _connecting:Boolean;
        private var _connectTimer:Timer;
        protected var _recordMessageSizes:Boolean = false;
        private var _failoverURIs:Array;
        protected var _log:ILogger;
        private var _connected:Boolean = false;
        private var _smallMessagesSupported:Boolean;
        private var _primaryURI:String;
        public var enableSmallMessages:Boolean = true;
        private var _id:String;
        private var _reliableReconnectBeginTimestamp:Number;
        private var _uri:String;
        protected var _loginAfterDisconnect:Boolean = false;
        private var _isEndpointCalculated:Boolean;
        mx_internal var reliableReconnectDuration:int = -1;
        private var _shouldBeConnected:Boolean;
        private var _previouslyConnected:Boolean;
        private var _requestTimeout:int = -1;
        private var _endpoint:String;
        protected var credentials:String;

        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _channelSets:Array = [];

        public function Channel(_arg_1:String=null, _arg_2:String=null)
        {
            _log = Log.getLogger("mx.messaging.Channel");
            _failoverIndex = -1;
            this.id = _arg_1;
            _primaryURI = _arg_2;
            this.uri = _arg_2;
        }

        private function shuffle(_arg_1:Array):void
        {
            var _local_4:int;
            var _local_5:Object;
            var _local_2:int = _arg_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = int(Math.floor((Math.random() * _local_2)));
                if (_local_4 != _local_3)
                {
                    _local_5 = _arg_1[_local_3];
                    _arg_1[_local_3] = _arg_1[_local_4];
                    _arg_1[_local_4] = _local_5;
                };
                _local_3++;
            };
        }

        [Bindable(event="propertyChange")]
        public function get connected():Boolean
        {
            return (_connected);
        }

        private function shutdownConnectTimer():void
        {
            if (_connectTimer != null)
            {
                _connectTimer.stop();
                _connectTimer.removeEventListener(TimerEvent.TIMER, connectTimeoutHandler);
                _connectTimer = null;
            };
        }

        public function get connectTimeout():int
        {
            return (_connectTimeout);
        }

        public function get id():String
        {
            return (_id);
        }

        private function calculateEndpoint():void
        {
            var _local_3:String;
            if (uri == null)
            {
                _local_3 = resourceManager.getString("messaging", "noURLSpecified");
                throw (new InvalidChannelError(_local_3));
            };
            var _local_1:String = uri;
            var _local_2:String = URLUtil.getProtocol(_local_1);
            if (_local_2.length == 0)
            {
                _local_1 = URLUtil.getFullURL(LoaderConfig.url, _local_1);
            };
            if (!URLUtil.hasUnresolvableTokens())
            {
                _isEndpointCalculated = false;
                return;
            };
            _local_1 = URLUtil.replaceTokens(_local_1);
            _local_2 = URLUtil.getProtocol(_local_1);
            if (_local_2.length > 0)
            {
                _endpoint = URLUtil.replaceProtocol(_local_1, protocol);
            }
            else
            {
                _endpoint = ((protocol + ":") + _local_1);
            };
            _isEndpointCalculated = true;
            if (Log.isInfo())
            {
                _log.info("'{0}' channel endpoint set to {1}", id, _endpoint);
            };
        }

        [Bindable(event="propertyChange")]
        public function get reconnecting():Boolean
        {
            return (_reconnecting);
        }

        public function get useSmallMessages():Boolean
        {
            return ((_smallMessagesSupported) && (enableSmallMessages));
        }

        public function set connectTimeout(_arg_1:int):void
        {
            _connectTimeout = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get authenticated():Boolean
        {
            return (_authenticated);
        }

        protected function getMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage):MessageResponder
        {
            throw (new IllegalOperationError(("Channel subclasses must override " + " getMessageResponder().")));
        }

        public function set failoverURIs(_arg_1:Array):void
        {
            if (_arg_1 != null)
            {
                _failoverURIs = _arg_1;
                _failoverIndex = -1;
            };
        }

        protected function internalDisconnect(_arg_1:Boolean=false):void
        {
        }

        public function setCredentials(_arg_1:String, _arg_2:MessageAgent=null, _arg_3:String=null):void
        {
            var _local_5:CommandMessage;
            var _local_4:* = (!(this.credentials === _arg_1));
            if (((authenticating) && (_local_4)))
            {
                throw (new IllegalOperationError("Credentials cannot be set while authenticating or logging out."));
            };
            if (((authenticated) && (_local_4)))
            {
                throw (new IllegalOperationError("Credentials cannot be set when already authenticated. Logout must be performed before changing credentials."));
            };
            this.credentials = _arg_1;
            if ((((connected) && (_local_4)) && (!(_arg_1 == null))))
            {
                authenticating = true;
                _local_5 = new CommandMessage();
                _local_5.operation = CommandMessage.LOGIN_OPERATION;
                _local_5.body = _arg_1;
                if (_arg_3 != null)
                {
                    _local_5.headers[CommandMessage.CREDENTIALS_CHARSET_HEADER] = _arg_3;
                };
                internalSend(new AuthenticationMessageResponder(_arg_2, _local_5, this, _log));
            };
        }

        public function set id(_arg_1:String):void
        {
            if (_id != _arg_1)
            {
                _id = _arg_1;
            };
        }

        public function get mpiEnabled():Boolean
        {
            return ((_recordMessageSizes) || (_recordMessageTimes));
        }

        protected function applyClientLoadBalancingSettings(_arg_1:XML):void
        {
            var _local_5:XML;
            var _local_2:XMLList = _arg_1[CLIENT_LOAD_BALANCING];
            if (_local_2.length() == 0)
            {
                return;
            };
            var _local_3:int = _local_2.url.length();
            if (_local_3 == 0)
            {
                return;
            };
            var _local_4:Array = new Array();
            for each (_local_5 in _local_2.url)
            {
                _local_4.push(_local_5.toString());
            };
            shuffle(_local_4);
            if (Log.isInfo())
            {
                _log.info("'{0}' channel picked {1} as its main url.", id, _local_4[0]);
            };
            this.url = _local_4[0];
            var _local_6:Array = _local_4.slice(1);
            if (_local_6.length > 0)
            {
                this.failoverURIs = _local_6;
            };
        }

        protected function setFlexClientIdOnMessage(_arg_1:IMessage):void
        {
            var _local_2:String = FlexClient.getInstance().id;
            _arg_1.headers[AbstractMessage.FLEX_CLIENT_ID_HEADER] = ((_local_2 != null) ? _local_2 : FlexClient.NULL_FLEXCLIENT_ID);
        }

        protected function connectTimeoutHandler(_arg_1:TimerEvent):void
        {
            var _local_2:String;
            var _local_3:ChannelFaultEvent;
            shutdownConnectTimer();
            if (!connected)
            {
                _shouldBeConnected = false;
                _local_2 = resourceManager.getString("messaging", "connectTimedOut");
                _local_3 = ChannelFaultEvent.createEvent(this, false, "Channel.Connect.Failed", "error", _local_2);
                connectFailed(_local_3);
            };
        }

        protected function flexClientWaitHandler(_arg_1:PropertyChangeEvent):void
        {
            var _local_2:FlexClient;
            if (_arg_1.property == "waitForFlexClientId")
            {
                _local_2 = (_arg_1.source as FlexClient);
                if (_local_2.waitForFlexClientId == false)
                {
                    _local_2.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, flexClientWaitHandler);
                    _local_2.waitForFlexClientId = true;
                    _ownsWaitGuard = true;
                    internalConnect();
                };
            };
        }

        protected function get shouldBeConnected():Boolean
        {
            return (_shouldBeConnected);
        }

        public function set useSmallMessages(_arg_1:Boolean):void
        {
            _smallMessagesSupported = _arg_1;
        }

        mx_internal function internalSetCredentials(_arg_1:String):void
        {
            this.credentials = _arg_1;
        }

        private function reconnect(_arg_1:TimerEvent=null):void
        {
            internalConnect();
        }

        private function connectCleanup():void
        {
            if (_ownsWaitGuard)
            {
                _ownsWaitGuard = false;
                FlexClient.getInstance().waitForFlexClientId = false;
            };
            _connecting = false;
            setReconnecting(false);
            reliableReconnectCleanup();
        }

        mx_internal function get realtime():Boolean
        {
            return (false);
        }

        protected function internalConnect():void
        {
        }

        public function get url():String
        {
            return (uri);
        }

        public function get recordMessageTimes():Boolean
        {
            return (_recordMessageTimes);
        }

        public function get uri():String
        {
            return (_uri);
        }

        private function initializeRequestTimeout(_arg_1:MessageResponder):void
        {
            var _local_2:IMessage = _arg_1.message;
            if (_local_2.headers[AbstractMessage.REQUEST_TIMEOUT_HEADER] != null)
            {
                _arg_1.startRequestTimeout(_local_2.headers[AbstractMessage.REQUEST_TIMEOUT_HEADER]);
            }
            else
            {
                if (requestTimeout > 0)
                {
                    _arg_1.startRequestTimeout(requestTimeout);
                };
            };
        }

        public function send(_arg_1:MessageAgent, _arg_2:IMessage):void
        {
            var _local_4:String;
            if (_arg_2.destination.length == 0)
            {
                if (_arg_1.destination.length == 0)
                {
                    _local_4 = resourceManager.getString("messaging", "noDestinationSpecified");
                    throw (new InvalidDestinationError(_local_4));
                };
                _arg_2.destination = _arg_1.destination;
            };
            if (Log.isDebug())
            {
                _log.debug("'{0}' channel sending message:\n{1}", id, _arg_2.toString());
            };
            _arg_2.headers[AbstractMessage.ENDPOINT_HEADER] = id;
            var _local_3:MessageResponder = getMessageResponder(_arg_1, _arg_2);
            initializeRequestTimeout(_local_3);
            internalSend(_local_3);
        }

        public function logout(_arg_1:MessageAgent):void
        {
            var _local_2:CommandMessage;
            if (((((connected) && (authenticated)) && (credentials)) || ((authenticating) && (credentials))))
            {
                _local_2 = new CommandMessage();
                _local_2.operation = CommandMessage.LOGOUT_OPERATION;
                internalSend(new AuthenticationMessageResponder(_arg_1, _local_2, this, _log));
                authenticating = true;
            };
            credentials = null;
        }

        public function get endpoint():String
        {
            if (!_isEndpointCalculated)
            {
                calculateEndpoint();
            };
            return (_endpoint);
        }

        public function get protocol():String
        {
            throw (new IllegalOperationError((("Channel subclasses must override " + "the get function for 'protocol' to return the proper protocol ") + "string.")));
        }

        public function get failoverURIs():Array
        {
            return ((_failoverURIs != null) ? _failoverURIs : []);
        }

        final public function disconnect(_arg_1:ChannelSet):void
        {
            if (_ownsWaitGuard)
            {
                _ownsWaitGuard = false;
                FlexClient.getInstance().waitForFlexClientId = false;
            };
            var _local_2:int = ((_arg_1 != null) ? _channelSets.indexOf(_arg_1) : -1);
            if (_local_2 != -1)
            {
                _channelSets.splice(_local_2, 1);
                removeEventListener(ChannelEvent.CONNECT, _arg_1.channelConnectHandler, false);
                removeEventListener(ChannelEvent.DISCONNECT, _arg_1.channelDisconnectHandler, false);
                removeEventListener(ChannelFaultEvent.FAULT, _arg_1.channelFaultHandler, false);
                if (connected)
                {
                    _arg_1.channelDisconnectHandler(ChannelEvent.createEvent(ChannelEvent.DISCONNECT, this, false));
                };
                if (_channelSets.length == 0)
                {
                    _shouldBeConnected = false;
                    if (connected)
                    {
                        internalDisconnect();
                    };
                };
            };
        }

        public function set requestTimeout(_arg_1:int):void
        {
            _requestTimeout = _arg_1;
        }

        private function shouldAttemptFailover():Boolean
        {
            return ((_shouldBeConnected) && (((_previouslyConnected) || (!(reliableReconnectDuration == -1))) || ((!(_failoverURIs == null)) && (_failoverURIs.length > 0))));
        }

        private function setReconnecting(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            if (_reconnecting != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "reconnecting", _reconnecting, _arg_1);
                _reconnecting = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        public function applySettings(_arg_1:XML):void
        {
            var _local_2:XML;
            var _local_3:XMLList;
            if (Log.isInfo())
            {
                _log.info("'{0}' channel settings are:\n{1}", id, _arg_1);
            };
            if (_arg_1.properties.length() != 0)
            {
                _local_2 = _arg_1.properties[0];
                applyClientLoadBalancingSettings(_local_2);
                if (_local_2[CONNECT_TIMEOUT_SECONDS].length() != 0)
                {
                    connectTimeout = _local_2[CONNECT_TIMEOUT_SECONDS].toString();
                };
                if (_local_2[RECORD_MESSAGE_TIMES].length() != 0)
                {
                    _recordMessageTimes = (_local_2[RECORD_MESSAGE_TIMES].toString() == TRUE);
                };
                if (_local_2[RECORD_MESSAGE_SIZES].length() != 0)
                {
                    _recordMessageSizes = (_local_2[RECORD_MESSAGE_SIZES].toString() == TRUE);
                };
                if (_local_2[REQUEST_TIMEOUT_SECONDS].length() != 0)
                {
                    requestTimeout = _local_2[REQUEST_TIMEOUT_SECONDS].toString();
                };
                _local_3 = _local_2[SERIALIZATION];
                if (((!(_local_3.length() == 0)) && (_local_3[ENABLE_SMALL_MESSAGES].toString() == FALSE)))
                {
                    enableSmallMessages = false;
                };
            };
        }

        private function reliableReconnectCleanup():void
        {
            reliableReconnectDuration = -1;
            _reliableReconnectBeginTimestamp = 0;
            _reliableReconnectLastTimestamp = 0;
            _reliableReconnectAttempts = 0;
        }

        protected function connectSuccess():void
        {
            var _local_1:int;
            var _local_2:Array;
            var _local_3:int;
            shutdownConnectTimer();
            if (ServerConfig.fetchedConfig(endpoint))
            {
                _local_1 = 0;
                while (_local_1 < channelSets.length)
                {
                    _local_2 = ChannelSet(channelSets[_local_1]).messageAgents;
                    _local_3 = 0;
                    while (_local_3 < _local_2.length)
                    {
                        _local_2[_local_3].needsConfig = false;
                        _local_3++;
                    };
                    _local_1++;
                };
            };
            setConnected(true);
            _failoverIndex = -1;
            if (Log.isInfo())
            {
                _log.info("'{0}' channel is connected.", id);
            };
            dispatchEvent(ChannelEvent.createEvent(ChannelEvent.CONNECT, this, reconnecting));
            connectCleanup();
        }

        public function get recordMessageSizes():Boolean
        {
            return (_recordMessageSizes);
        }

        protected function setConnected(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            if (_connected != _arg_1)
            {
                if (_connected)
                {
                    _previouslyConnected = true;
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "connected", _connected, _arg_1);
                _connected = _arg_1;
                dispatchEvent(_local_2);
                if (!_arg_1)
                {
                    setAuthenticated(false);
                };
            };
        }

        public function get requestTimeout():int
        {
            return (_requestTimeout);
        }

        protected function connectFailed(_arg_1:ChannelFaultEvent):void
        {
            shutdownConnectTimer();
            setConnected(false);
            if (Log.isError())
            {
                _log.error("'{0}' channel connect failed.", id);
            };
            if (((!(_arg_1.rejected)) && (shouldAttemptFailover())))
            {
                _connecting = true;
                failover();
            }
            else
            {
                connectCleanup();
            };
            if (reconnecting)
            {
                _arg_1.reconnecting = true;
            };
            dispatchEvent(_arg_1);
        }

        public function set uri(_arg_1:String):void
        {
            if (_arg_1 != null)
            {
                _uri = _arg_1;
                calculateEndpoint();
            };
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            this.id = _arg_2;
        }

        public function set url(_arg_1:String):void
        {
            uri = _arg_1;
        }

        protected function disconnectSuccess(_arg_1:Boolean=false):void
        {
            setConnected(false);
            if (Log.isInfo())
            {
                _log.info("'{0}' channel disconnected.", id);
            };
            if (((!(_arg_1)) && (shouldAttemptFailover())))
            {
                _connecting = true;
                failover();
            }
            else
            {
                connectCleanup();
            };
            dispatchEvent(ChannelEvent.createEvent(ChannelEvent.DISCONNECT, this, reconnecting, _arg_1));
        }

        protected function internalSend(_arg_1:MessageResponder):void
        {
        }

        mx_internal function sendInternalMessage(_arg_1:MessageResponder):void
        {
            internalSend(_arg_1);
        }

        final public function connect(_arg_1:ChannelSet):void
        {
            var _local_5:FlexClient;
            var _local_2:Boolean;
            var _local_3:int = _channelSets.length;
            var _local_4:int;
            while (_local_4 < _channelSets.length)
            {
                if (_channelSets[_local_4] == _arg_1)
                {
                    _local_2 = true;
                    break;
                };
                _local_4++;
            };
            _shouldBeConnected = true;
            if (!_local_2)
            {
                _channelSets.push(_arg_1);
                addEventListener(ChannelEvent.CONNECT, _arg_1.channelConnectHandler);
                addEventListener(ChannelEvent.DISCONNECT, _arg_1.channelDisconnectHandler);
                addEventListener(ChannelFaultEvent.FAULT, _arg_1.channelFaultHandler);
            };
            if (connected)
            {
                _arg_1.channelConnectHandler(ChannelEvent.createEvent(ChannelEvent.CONNECT, this, false, false, connected));
            }
            else
            {
                if (!_connecting)
                {
                    _connecting = true;
                    if (connectTimeout > 0)
                    {
                        _connectTimer = new Timer((connectTimeout * 1000), 1);
                        _connectTimer.addEventListener(TimerEvent.TIMER, connectTimeoutHandler);
                        _connectTimer.start();
                    };
                    if (FlexClient.getInstance().id == null)
                    {
                        _local_5 = FlexClient.getInstance();
                        if (!_local_5.waitForFlexClientId)
                        {
                            _local_5.waitForFlexClientId = true;
                            _ownsWaitGuard = true;
                            internalConnect();
                        }
                        else
                        {
                            _local_5.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, flexClientWaitHandler);
                        };
                    }
                    else
                    {
                        internalConnect();
                    };
                };
            };
        }

        private function resetToPrimaryURI():void
        {
            _connecting = false;
            setReconnecting(false);
            uri = _primaryURI;
            _failoverIndex = -1;
        }

        mx_internal function setAuthenticated(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            var _local_3:ChannelSet;
            var _local_4:int;
            if (_arg_1 != _authenticated)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "authenticated", _authenticated, _arg_1);
                _authenticated = _arg_1;
                _local_4 = 0;
                while (_local_4 < _channelSets.length)
                {
                    _local_3 = ChannelSet(_channelSets[_local_4]);
                    _local_3.setAuthenticated(authenticated, credentials);
                    _local_4++;
                };
                dispatchEvent(_local_2);
            };
        }

        protected function handleServerMessagingVersion(_arg_1:Number):void
        {
            useSmallMessages = (_arg_1 >= messagingVersion);
        }

        mx_internal function get loginAfterDisconnect():Boolean
        {
            return (_loginAfterDisconnect);
        }

        private function failover():void
        {
            var acs:Class;
            var duration:int;
            var channelSet:ChannelSet;
            var d:int;
            var remaining:Number;
            var delay:int;
            if (_previouslyConnected)
            {
                _previouslyConnected = false;
                acs = null;
                try
                {
                    acs = (getDefinitionByName("mx.messaging.AdvancedChannelSet") as Class);
                }
                catch(ignore:Error)
                {
                };
                duration = -1;
                if (acs != null)
                {
                    for each (channelSet in channelSets)
                    {
                        if ((channelSet is acs))
                        {
                            d = (channelSet as acs)["reliableReconnectDuration"];
                            if (d > duration)
                            {
                                duration = d;
                            };
                        };
                    };
                };
                if (duration != -1)
                {
                    setReconnecting(true);
                    reliableReconnectDuration = duration;
                    _reliableReconnectBeginTimestamp = new Date().valueOf();
                    new AsyncDispatcher(reconnect, null, 1);
                    return;
                };
            };
            if (reliableReconnectDuration != -1)
            {
                _reliableReconnectLastTimestamp = new Date().valueOf();
                remaining = (reliableReconnectDuration - (_reliableReconnectLastTimestamp - _reliableReconnectBeginTimestamp));
                if (remaining > 0)
                {
                    delay = 1000;
                    (delay << ++_reliableReconnectAttempts);
                    if (delay < remaining)
                    {
                        new AsyncDispatcher(reconnect, null, delay);
                        return;
                    };
                };
                reliableReconnectCleanup();
            };
            _failoverIndex++;
            if ((_failoverIndex + 1) <= failoverURIs.length)
            {
                setReconnecting(true);
                uri = failoverURIs[_failoverIndex];
                if (Log.isInfo())
                {
                    _log.info("'{0}' channel attempting to connect to {1}.", id, endpoint);
                };
                new AsyncDispatcher(reconnect, null, 1);
            }
            else
            {
                if (Log.isInfo())
                {
                    _log.info("'{0}' channel has exhausted failover options and has reset to its primary endpoint.", id);
                };
                resetToPrimaryURI();
            };
        }

        public function get channelSets():Array
        {
            return (_channelSets);
        }

        protected function disconnectFailed(_arg_1:ChannelFaultEvent):void
        {
            _connecting = false;
            setConnected(false);
            if (Log.isError())
            {
                _log.error("'{0}' channel disconnect failed.", id);
            };
            if (reconnecting)
            {
                resetToPrimaryURI();
                _arg_1.reconnecting = false;
            };
            dispatchEvent(_arg_1);
        }


    }
}//package mx.messaging

import mx.messaging.MessageResponder;
import mx.logging.ILogger;
import mx.messaging.MessageAgent;
import mx.messaging.messages.IMessage;
import mx.messaging.Channel;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.events.ChannelFaultEvent;
import mx.messaging.messages.CommandMessage;
import mx.logging.Log;
import mx.core.mx_internal; 

use namespace mx_internal;

class AuthenticationMessageResponder extends MessageResponder 
{

    /*private*/ var _log:ILogger;

    public function AuthenticationMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage, _arg_3:Channel, _arg_4:ILogger)
    {
        super(_arg_1, _arg_2, _arg_3);
        _log = _arg_4;
    }

    override protected function statusHandler(_arg_1:IMessage):void
    {
        var _local_3:ErrorMessage;
        var _local_4:ChannelFaultEvent;
        var _local_2:CommandMessage = CommandMessage(message);
        if (Log.isDebug())
        {
            _log.debug("{1} failure: {0}", _arg_1.toString(), ((_local_2.operation == CommandMessage.LOGIN_OPERATION) ? "Login" : "Logout"));
        };
        channel.authenticating = false;
        channel.setAuthenticated(false);
        if (((!(agent == null)) && (agent.hasPendingRequestForMessage(message))))
        {
            agent.fault(ErrorMessage(_arg_1), message);
        }
        else
        {
            _local_3 = ErrorMessage(_arg_1);
            _local_4 = ChannelFaultEvent.createEvent(channel, false, "Channel.Authentication.Error", "warn", _local_3.faultString);
            _local_4.rootCause = _local_3;
            channel.dispatchEvent(_local_4);
        };
    }

    override protected function resultHandler(_arg_1:IMessage):void
    {
        var _local_2:CommandMessage = (message as CommandMessage);
        channel.authenticating = false;
        if (_local_2.operation == CommandMessage.LOGIN_OPERATION)
        {
            if (Log.isDebug())
            {
                _log.debug("Login successful");
            };
            channel.setAuthenticated(true);
        }
        else
        {
            if (Log.isDebug())
            {
                _log.debug("Logout successful");
            };
            channel.setAuthenticated(false);
        };
    }


}


