// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.channels.DirectHTTPChannel

package mx.messaging.channels
{
    import mx.messaging.Channel;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.messaging.errors.InvalidChannelError;
    import mx.messaging.errors.ChannelError;
    import mx.messaging.MessageAgent;
    import flash.net.URLRequest;
    import mx.messaging.errors.MessageSerializationError;
    import flash.net.URLLoader;
    import flash.events.ErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import mx.messaging.MessageResponder;
    import mx.messaging.messages.IMessage;
    import flash.events.TimerEvent;
    import flash.net.URLRequestHeader;
    import flash.net.URLVariables;
    import mx.messaging.messages.HTTPRequestMessage;
    import mx.netmon.NetworkMonitor;
    import mx.messaging.config.LoaderConfig;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DirectHTTPChannel extends Channel 
    {

        private static var clientCounter:uint;

        mx_internal var clientId:String;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function DirectHTTPChannel(_arg_1:String, _arg_2:String="")
        {
            var _local_3:String;
            super(_arg_1, _arg_2);
            if (_arg_2.length > 0)
            {
                _local_3 = resourceManager.getString("messaging", "noURIAllowed");
                throw (new InvalidChannelError(_local_3));
            };
            clientId = ("DirectHTTPChannel" + clientCounter++);
        }

        override public function setCredentials(_arg_1:String, _arg_2:MessageAgent=null, _arg_3:String=null):void
        {
            var _local_4:String = resourceManager.getString("messaging", "authenticationNotSupported");
            throw (new ChannelError(_local_4));
        }

        override protected function internalSend(msgResp:MessageResponder):void
        {
            var httpMsgResp:DirectHTTPMessageResponder;
            var urlRequest:URLRequest;
            httpMsgResp = DirectHTTPMessageResponder(msgResp);
            try
            {
                urlRequest = createURLRequest(httpMsgResp.message);
            }
            catch(e:MessageSerializationError)
            {
                httpMsgResp.agent.fault(e.fault, httpMsgResp.message);
                return;
            };
            var urlLoader:URLLoader = httpMsgResp.urlLoader;
            urlLoader.addEventListener(ErrorEvent.ERROR, httpMsgResp.errorHandler);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, httpMsgResp.errorHandler);
            urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, httpMsgResp.securityErrorHandler);
            urlLoader.addEventListener(Event.COMPLETE, httpMsgResp.completeHandler);
            urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpMsgResp.httpStatusHandler);
            urlLoader.load(urlRequest);
        }

        override public function get connected():Boolean
        {
            return (true);
        }

        override mx_internal function get realtime():Boolean
        {
            return (false);
        }

        override protected function internalConnect():void
        {
            connectSuccess();
        }

        override protected function getMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage):MessageResponder
        {
            return (new DirectHTTPMessageResponder(_arg_1, _arg_2, this, new URLLoader()));
        }

        override public function get protocol():String
        {
            return ("http");
        }

        override protected function connectTimeoutHandler(_arg_1:TimerEvent):void
        {
        }

        mx_internal function createURLRequest(_arg_1:IMessage):URLRequest
        {
            var _local_8:Array;
            var _local_9:URLRequestHeader;
            var _local_10:String;
            var _local_11:URLVariables;
            var _local_12:Object;
            var _local_13:String;
            var _local_2:HTTPRequestMessage = HTTPRequestMessage(_arg_1);
            var _local_3:URLRequest = new URLRequest();
            var _local_4:String = _local_2.url;
            var _local_5:String;
            _local_3.contentType = _local_2.contentType;
            var _local_6:Boolean = ((_local_3.contentType == HTTPRequestMessage.CONTENT_TYPE_XML) || (_local_3.contentType == HTTPRequestMessage.CONTENT_TYPE_SOAP_XML));
            var _local_7:Object = _local_2.httpHeaders;
            if (_local_7)
            {
                _local_8 = [];
                for (_local_10 in _local_7)
                {
                    _local_9 = new URLRequestHeader(_local_10, _local_7[_local_10]);
                    _local_8.push(_local_9);
                };
                _local_3.requestHeaders = _local_8;
            };
            if (!_local_6)
            {
                _local_11 = new URLVariables();
                _local_12 = _local_2.body;
                for (_local_13 in _local_12)
                {
                    _local_11[_local_13] = _local_2.body[_local_13];
                };
                _local_5 = _local_11.toString();
            };
            if (((_local_2.method == HTTPRequestMessage.POST_METHOD) || (_local_6)))
            {
                _local_3.method = "POST";
                if (_local_3.contentType == HTTPRequestMessage.CONTENT_TYPE_FORM)
                {
                    _local_3.data = _local_5;
                }
                else
                {
                    if (((!(_local_2.body == null)) && (_local_2.body is XML)))
                    {
                        _local_3.data = XML(_local_2.body).toXMLString();
                    }
                    else
                    {
                        _local_3.data = _local_2.body;
                    };
                };
            }
            else
            {
                if (((_local_5) && (!(_local_5 == ""))))
                {
                    _local_4 = (_local_4 + ((_local_4.indexOf("?") > -1) ? "&" : "?"));
                    _local_4 = (_local_4 + _local_5);
                };
            };
            _local_3.url = _local_4;
            if (NetworkMonitor.isMonitoring())
            {
                NetworkMonitor.adjustURLRequest(_local_3, LoaderConfig.url, _arg_1.messageId);
            };
            return (_local_3);
        }


    }
}//package mx.messaging.channels

import mx.messaging.MessageResponder;
import flash.net.URLLoader;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.messaging.MessageAgent;
import mx.messaging.messages.IMessage;
import mx.messaging.channels.DirectHTTPChannel;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.messages.AbstractMessage;
import flash.events.Event;
import flash.events.ErrorEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.events.HTTPStatusEvent;
import mx.messaging.messages.HTTPRequestMessage;
import mx.core.mx_internal; 

use namespace mx_internal;

class DirectHTTPMessageResponder extends MessageResponder 
{

    /*private*/ var clientId:String;
    /*private*/ var lastStatus:int;
    public var urlLoader:URLLoader;
    /*private*/ var resourceManager:IResourceManager = ResourceManager.getInstance();

    public function DirectHTTPMessageResponder(_arg_1:MessageAgent, _arg_2:IMessage, _arg_3:DirectHTTPChannel, _arg_4:URLLoader)
    {
        super(_arg_1, _arg_2, _arg_3);
        this.urlLoader = _arg_4;
        clientId = _arg_3.clientId;
    }

    public function securityErrorHandler(_arg_1:Event):void
    {
        var _local_2:AcknowledgeMessage;
        status(null);
        _local_2 = new AcknowledgeMessage();
        _local_2.clientId = clientId;
        _local_2.correlationId = message.messageId;
        _local_2.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
        agent.acknowledge(_local_2, message);
        var _local_3:ErrorMessage = new ErrorMessage();
        _local_3.clientId = clientId;
        _local_3.correlationId = message.messageId;
        _local_3.faultCode = "Channel.Security.Error";
        _local_3.faultString = resourceManager.getString("messaging", "securityError");
        _local_3.faultDetail = resourceManager.getString("messaging", "securityError.details", [message.destination]);
        _local_3.rootCause = _arg_1;
        _local_3.body = URLLoader(_arg_1.target).data;
        _local_3.headers[AbstractMessage.STATUS_CODE_HEADER] = lastStatus;
        agent.fault(_local_3, message);
    }

    override protected function requestTimedOut():void
    {
        urlLoader.removeEventListener(ErrorEvent.ERROR, errorHandler);
        urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        urlLoader.removeEventListener(Event.COMPLETE, completeHandler);
        urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
        urlLoader.close();
        status(null);
        var _local_1:AcknowledgeMessage = new AcknowledgeMessage();
        _local_1.clientId = clientId;
        _local_1.correlationId = message.messageId;
        _local_1.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
        agent.acknowledge(_local_1, message);
        agent.fault(createRequestTimeoutErrorMessage(), message);
    }

    public function errorHandler(_arg_1:Event):void
    {
        status(null);
        var _local_2:AcknowledgeMessage = new AcknowledgeMessage();
        _local_2.clientId = clientId;
        _local_2.correlationId = message.messageId;
        _local_2.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
        agent.acknowledge(_local_2, message);
        var _local_3:ErrorMessage = new ErrorMessage();
        _local_3.clientId = clientId;
        _local_3.correlationId = message.messageId;
        _local_3.faultCode = "Server.Error.Request";
        _local_3.faultString = resourceManager.getString("messaging", "httpRequestError");
        var _local_4:String = _arg_1.toString();
        if ((message is HTTPRequestMessage))
        {
            _local_4 = (_local_4 + ". URL: ");
            _local_4 = (_local_4 + HTTPRequestMessage(message).url);
        };
        _local_3.faultDetail = resourceManager.getString("messaging", "httpRequestError.details", [_local_4]);
        _local_3.rootCause = _arg_1;
        _local_3.body = URLLoader(_arg_1.target).data;
        _local_3.headers[AbstractMessage.STATUS_CODE_HEADER] = lastStatus;
        agent.fault(_local_3, message);
    }

    public function httpStatusHandler(_arg_1:HTTPStatusEvent):void
    {
        lastStatus = _arg_1.status;
    }

    public function completeHandler(_arg_1:Event):void
    {
        result(null);
        var _local_2:AcknowledgeMessage = new AcknowledgeMessage();
        _local_2.clientId = clientId;
        _local_2.correlationId = message.messageId;
        _local_2.body = URLLoader(_arg_1.target).data;
        _local_2.headers[AbstractMessage.STATUS_CODE_HEADER] = lastStatus;
        agent.acknowledge(_local_2, message);
    }


}


