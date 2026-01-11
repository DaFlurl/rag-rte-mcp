// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.channels.NetConnectionChannel

package mx.messaging.channels
{
    import flash.net.NetConnection;
    import flash.net.ObjectEncoding;
    import mx.logging.Log;
    import mx.messaging.messages.MessagePerformanceUtils;
    import mx.messaging.events.MessageEvent;
    import mx.messaging.messages.IMessage;
    import mx.messaging.messages.MessagePerformanceInfo;
    import mx.messaging.messages.ISmallMessage;
    import mx.messaging.MessageResponder;
    import mx.messaging.MessageAgent;
    import flash.events.SecurityErrorEvent;
    import mx.messaging.events.ChannelFaultEvent;
    import flash.events.ErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.AsyncErrorEvent;
    import mx.netmon.NetworkMonitor;
    import mx.messaging.config.LoaderConfig;
    import flash.events.TimerEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NetConnectionChannel extends PollingChannel 
    {

        mx_internal var _appendToURL:String;
        protected var _nc:NetConnection;

        public function NetConnectionChannel(_arg_1:String=null, _arg_2:String=null)
        {
            super(_arg_1, _arg_2);
            _nc = new NetConnection();
            _nc.objectEncoding = ObjectEncoding.AMF3;
            _nc.client = this;
        }

        public function AppendToGatewayUrl(_arg_1:String):void
        {
            if ((((!(_arg_1 == null)) && (!(_arg_1 == ""))) && (!(_arg_1 == _appendToURL))))
            {
                if (Log.isDebug())
                {
                    _log.debug("'{0}' channel will disconnect and reconnect with with its session identifier '{1}' appended to its endpoint url \n", id, _arg_1);
                };
                _appendToURL = _arg_1;
            };
        }

        public function receive(msg:IMessage, ... rest):void
        {
            var mpiutil:MessagePerformanceUtils;
            if (Log.isDebug())
            {
                _log.debug("'{0}' channel got message\n{1}\n", id, msg.toString());
                if (this.mpiEnabled)
                {
                    try
                    {
                        mpiutil = new MessagePerformanceUtils(msg);
                        _log.debug(mpiutil.prettyPrint());
                    }
                    catch(e:Error)
                    {
                        _log.debug(("Could not get message performance information for: " + msg.toString()));
                    };
                };
            };
            dispatchEvent(MessageEvent.createEvent(MessageEvent.MESSAGE, msg));
        }

        override protected function internalSend(_arg_1:MessageResponder):void
        {
            var _local_3:MessagePerformanceInfo;
            var _local_4:IMessage;
            setFlexClientIdOnMessage(_arg_1.message);
            if (mpiEnabled)
            {
                _local_3 = new MessagePerformanceInfo();
                if (recordMessageTimes)
                {
                    _local_3.sendTime = new Date().getTime();
                };
                _arg_1.message.headers[MessagePerformanceUtils.MPI_HEADER_IN] = _local_3;
            };
            var _local_2:IMessage = _arg_1.message;
            if (((useSmallMessages) && (_local_2 is ISmallMessage)))
            {
                _local_4 = ISmallMessage(_local_2).getSmallMessage();
                if (_local_4 != null)
                {
                    _local_2 = _local_4;
                };
            };
            _nc.call(null, _arg_1, _local_2);
        }

        override protected function getDefaultMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage):MessageResponder
        {
            return (new NetConnectionMessageResponder(_arg_1, _arg_2, this));
        }

        protected function securityErrorHandler(_arg_1:SecurityErrorEvent):void
        {
            defaultErrorHandler("Channel.Security.Error", _arg_1);
        }

        private function defaultErrorHandler(_arg_1:String, _arg_2:ErrorEvent):void
        {
            var _local_3:ChannelFaultEvent = ChannelFaultEvent.createEvent(this, false, _arg_1, "error", (((_arg_2.text + " url: '") + endpoint) + "'"));
            _local_3.rootCause = _arg_2;
            if (_connecting)
            {
                connectFailed(_local_3);
            }
            else
            {
                dispatchEvent(_local_3);
            };
        }

        override public function get useSmallMessages():Boolean
        {
            return (((super.useSmallMessages) && (!(_nc == null))) && (_nc.objectEncoding >= ObjectEncoding.AMF3));
        }

        override protected function internalConnect():void
        {
            var url:String;
            var i:int;
            var temp:String;
            var j:int;
            var redirectedUrl:String;
            super.internalConnect();
            url = endpoint;
            if (_appendToURL != null)
            {
                i = url.indexOf("wsrp-url=");
                if (i != -1)
                {
                    temp = url.substr((i + 9), url.length);
                    j = temp.indexOf("&");
                    if (j != -1)
                    {
                        temp = temp.substr(0, j);
                    };
                    url = url.replace(temp, (temp + _appendToURL));
                }
                else
                {
                    url = (url + _appendToURL);
                };
            };
            if ((((!(_nc.uri == null)) && (_nc.uri.length > 0)) && (_nc.connected)))
            {
                _nc.removeEventListener(NetStatusEvent.NET_STATUS, statusHandler);
                _nc.close();
            };
            _nc.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
            _nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            _nc.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            _nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            try
            {
                if (NetworkMonitor.isMonitoring())
                {
                    redirectedUrl = NetworkMonitor.adjustNetConnectionURL(LoaderConfig.url, url);
                    if (redirectedUrl != null)
                    {
                        url = redirectedUrl;
                    };
                };
                _nc.connect(url);
            }
            catch(e:Error)
            {
                e.message = (e.message + (("  url: '" + url) + "'"));
                throw (e);
            };
        }

        protected function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            defaultErrorHandler("Channel.IO.Error", _arg_1);
        }

        protected function statusHandler(_arg_1:NetStatusEvent):void
        {
        }

        override protected function internalDisconnect(_arg_1:Boolean=false):void
        {
            super.internalDisconnect(_arg_1);
            shutdownNetConnection();
            disconnectSuccess(_arg_1);
        }

        override protected function connectTimeoutHandler(_arg_1:TimerEvent):void
        {
            shutdownNetConnection();
            super.connectTimeoutHandler(_arg_1);
        }

        public function get netConnection():NetConnection
        {
            return (_nc);
        }

        protected function shutdownNetConnection():void
        {
            _nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            _nc.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            _nc.removeEventListener(NetStatusEvent.NET_STATUS, statusHandler);
            _nc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            _nc.close();
        }

        protected function asyncErrorHandler(_arg_1:AsyncErrorEvent):void
        {
            defaultErrorHandler("Channel.Async.Error", _arg_1);
        }


    }
}//package mx.messaging.channels

import mx.messaging.MessageResponder;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.messaging.events.ChannelEvent;
import mx.messaging.events.ChannelFaultEvent;
import mx.messaging.MessageAgent;
import mx.messaging.messages.IMessage;
import mx.messaging.channels.NetConnectionChannel;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.messages.AsyncMessage;
import mx.core.mx_internal; 

use namespace mx_internal;

class NetConnectionMessageResponder extends MessageResponder 
{

    /*private*/ var handled:Boolean;
    /*private*/ var resourceManager:IResourceManager = ResourceManager.getInstance();

    public function NetConnectionMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage, _arg_3:NetConnectionChannel)
    {
        super(_arg_1, _arg_2, _arg_3);
        _arg_3.addEventListener(ChannelEvent.DISCONNECT, channelDisconnectHandler);
        _arg_3.addEventListener(ChannelFaultEvent.FAULT, channelFaultHandler);
    }

    protected function channelFaultHandler(_arg_1:ChannelFaultEvent):void
    {
        if (handled)
        {
            return;
        };
        disconnect();
        var _local_2:ErrorMessage = _arg_1.createErrorMessage();
        _local_2.correlationId = message.messageId;
        if (!_arg_1.channel.connected)
        {
            _local_2.faultCode = ErrorMessage.MESSAGE_DELIVERY_IN_DOUBT;
        };
        _local_2.rootCause = _arg_1;
        agent.fault(_local_2, message);
    }

    /*private*/ function disconnect():void
    {
        handled = true;
        channel.removeEventListener(ChannelEvent.DISCONNECT, channelDisconnectHandler);
        channel.removeEventListener(ChannelFaultEvent.FAULT, channelFaultHandler);
    }

    override protected function requestTimedOut():void
    {
        statusHandler(createRequestTimeoutErrorMessage());
    }

    override protected function statusHandler(_arg_1:IMessage):void
    {
        var _local_2:AcknowledgeMessage;
        var _local_3:ErrorMessage;
        if (handled)
        {
            return;
        };
        disconnect();
        if ((_arg_1 is AsyncMessage))
        {
            if (AsyncMessage(_arg_1).correlationId == message.messageId)
            {
                _local_2 = new AcknowledgeMessage();
                _local_2.correlationId = AsyncMessage(_arg_1).correlationId;
                _local_2.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
                agent.acknowledge(_local_2, message);
                agent.fault((_arg_1 as ErrorMessage), message);
            }
            else
            {
                if ((_arg_1 is ErrorMessage))
                {
                    agent.fault((_arg_1 as ErrorMessage), message);
                }
                else
                {
                    _local_3 = new ErrorMessage();
                    _local_3.faultCode = "Server.Acknowledge.Failed";
                    _local_3.faultString = resourceManager.getString("messaging", "noErrorForMessage");
                    _local_3.faultDetail = resourceManager.getString("messaging", "noErrorForMessage.details", [message.messageId, AsyncMessage(_arg_1).correlationId]);
                    _local_3.correlationId = message.messageId;
                    agent.fault(_local_3, message);
                };
            };
        }
        else
        {
            _local_3 = new ErrorMessage();
            _local_3.faultCode = "Server.Acknowledge.Failed";
            _local_3.faultString = resourceManager.getString("messaging", "noAckMessage");
            _local_3.faultDetail = resourceManager.getString("messaging", "noAckMessage.details", [((_arg_1) ? _arg_1.toString() : "null")]);
            _local_3.correlationId = message.messageId;
            agent.fault(_local_3, message);
        };
    }

    protected function channelDisconnectHandler(_arg_1:ChannelEvent):void
    {
        if (handled)
        {
            return;
        };
        disconnect();
        var _local_2:ErrorMessage = new ErrorMessage();
        _local_2.correlationId = message.messageId;
        _local_2.faultString = resourceManager.getString("messaging", "deliveryInDoubt");
        _local_2.faultDetail = resourceManager.getString("messaging", "deliveryInDoubt.details");
        _local_2.faultCode = ErrorMessage.MESSAGE_DELIVERY_IN_DOUBT;
        _local_2.rootCause = _arg_1;
        agent.fault(_local_2, message);
    }

    override protected function resultHandler(_arg_1:IMessage):void
    {
        var _local_2:ErrorMessage;
        if (handled)
        {
            return;
        };
        disconnect();
        if ((_arg_1 is AsyncMessage))
        {
            if (AsyncMessage(_arg_1).correlationId == message.messageId)
            {
                agent.acknowledge((_arg_1 as AcknowledgeMessage), message);
            }
            else
            {
                _local_2 = new ErrorMessage();
                _local_2.faultCode = "Server.Acknowledge.Failed";
                _local_2.faultString = resourceManager.getString("messaging", "ackFailed");
                _local_2.faultDetail = resourceManager.getString("messaging", "ackFailed.details", [message.messageId, AsyncMessage(_arg_1).correlationId]);
                _local_2.correlationId = message.messageId;
                agent.fault(_local_2, message);
            };
        }
        else
        {
            _local_2 = new ErrorMessage();
            _local_2.faultCode = "Server.Acknowledge.Failed";
            _local_2.faultString = resourceManager.getString("messaging", "noAckMessage");
            _local_2.faultDetail = resourceManager.getString("messaging", "noAckMessage.details", [((_arg_1) ? _arg_1.toString() : "null")]);
            _local_2.correlationId = message.messageId;
            agent.fault(_local_2, message);
        };
    }


}


