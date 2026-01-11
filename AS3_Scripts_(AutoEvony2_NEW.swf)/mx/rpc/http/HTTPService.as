// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.http.HTTPService

package mx.rpc.http
{
    import mx.rpc.AbstractInvoker;
    import mx.utils.URLUtil;
    import mx.messaging.config.LoaderConfig;
    import mx.rpc.AsyncToken;
    import mx.messaging.ChannelSet;
    import mx.rpc.AsyncRequest;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HTTPService extends AbstractInvoker 
    {

        public static const RESULT_FORMAT_E4X:String = "e4x";
        public static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
        public static const RESULT_FORMAT_OBJECT:String = "object";
        public static const RESULT_FORMAT_ARRAY:String = "array";
        public static const RESULT_FORMAT_TEXT:String = "text";
        public static const RESULT_FORMAT_XML:String = "xml";
        public static const CONTENT_TYPE_XML:String = "application/xml";
        public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
        public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
        public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
        public static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
        public static const ERROR_DECODING:String = "Client.CouldNotDecode";
        public static const ERROR_ENCODING:String = "Client.CouldNotEncode";

        mx_internal var operation:AbstractOperation;

        public function HTTPService(_arg_1:String=null, _arg_2:String=null)
        {
            operation = new HTTPOperation(this);
            operation.makeObjectsBindable = true;
            operation._rootURL = _arg_1;
            if (_arg_2 == null)
            {
                if (URLUtil.isHttpsURL(LoaderConfig.url))
                {
                    asyncRequest.destination = DEFAULT_DESTINATION_HTTPS;
                }
                else
                {
                    asyncRequest.destination = DEFAULT_DESTINATION_HTTP;
                };
            }
            else
            {
                asyncRequest.destination = _arg_2;
                useProxy = true;
            };
        }

        public function setCredentials(_arg_1:String, _arg_2:String, _arg_3:String=null):void
        {
            asyncRequest.setCredentials(_arg_1, _arg_2, _arg_3);
        }

        public function set method(_arg_1:String):void
        {
            operation.method = _arg_1;
        }

        public function logout():void
        {
            asyncRequest.logout();
        }

        public function get headers():Object
        {
            return (operation.headers);
        }

        public function get serializationFilter():SerializationFilter
        {
            return (operation.serializationFilter);
        }

        override public function cancel(_arg_1:String=null):AsyncToken
        {
            return (operation.cancel(_arg_1));
        }

        override public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            operation.removeEventListener(_arg_1, _arg_2, _arg_3);
            super.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set headers(_arg_1:Object):void
        {
            operation.headers = _arg_1;
        }

        override public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            operation.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            super.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function get request():Object
        {
            return (operation.request);
        }

        public function set serializationFilter(_arg_1:SerializationFilter):void
        {
            operation.serializationFilter = _arg_1;
        }

        public function get requestTimeout():int
        {
            return (asyncRequest.requestTimeout);
        }

        public function get contentType():String
        {
            return (operation.contentType);
        }

        public function get destination():String
        {
            return (asyncRequest.destination);
        }

        public function send(_arg_1:Object=null):AsyncToken
        {
            if (_arg_1 == null)
            {
                _arg_1 = request;
            };
            return (operation.sendBody(_arg_1));
        }

        public function set showBusyCursor(_arg_1:Boolean):void
        {
            operation.showBusyCursor = _arg_1;
        }

        public function set xmlDecode(_arg_1:Function):void
        {
            operation.xmlDecode = _arg_1;
        }

        public function get concurrency():String
        {
            return (operation.concurrency);
        }

        public function get showBusyCursor():Boolean
        {
            return (operation.showBusyCursor);
        }

        public function set destination(_arg_1:String):void
        {
            useProxy = true;
            asyncRequest.destination = _arg_1;
        }

        public function set useProxy(_arg_1:Boolean):void
        {
            operation.useProxy = _arg_1;
        }

        public function set request(_arg_1:Object):void
        {
            operation.request = _arg_1;
        }

        public function get channelSet():ChannelSet
        {
            return (asyncRequest.channelSet);
        }

        public function get method():String
        {
            return (operation.method);
        }

        [Bindable("resultForBinding")]
        override public function get lastResult():Object
        {
            return (operation.lastResult);
        }

        public function disconnect():void
        {
            asyncRequest.disconnect();
        }

        public function set requestTimeout(_arg_1:int):void
        {
            if (asyncRequest.requestTimeout != _arg_1)
            {
                asyncRequest.requestTimeout = _arg_1;
            };
        }

        public function set url(_arg_1:String):void
        {
            operation.url = _arg_1;
        }

        override mx_internal function set asyncRequest(_arg_1:AsyncRequest):void
        {
            operation.asyncRequest = _arg_1;
        }

        public function set resultFormat(_arg_1:String):void
        {
            operation.resultFormat = _arg_1;
        }

        public function set rootURL(_arg_1:String):void
        {
            operation.rootURL = _arg_1;
        }

        public function get xmlDecode():Function
        {
            return (operation.xmlDecode);
        }

        public function set concurrency(_arg_1:String):void
        {
            operation.concurrency = _arg_1;
        }

        public function get useProxy():Boolean
        {
            return (operation.useProxy);
        }

        public function get url():String
        {
            return (operation.url);
        }

        public function get xmlEncode():Function
        {
            return (operation.xmlEncode);
        }

        public function set xmlEncode(_arg_1:Function):void
        {
            operation.xmlEncode = _arg_1;
        }

        override mx_internal function get asyncRequest():AsyncRequest
        {
            return (operation.asyncRequest);
        }

        public function get resultFormat():String
        {
            return (operation.resultFormat);
        }

        public function set contentType(_arg_1:String):void
        {
            operation.contentType = _arg_1;
        }

        public function setRemoteCredentials(_arg_1:String, _arg_2:String, _arg_3:String=null):void
        {
            asyncRequest.setRemoteCredentials(_arg_1, _arg_2, _arg_3);
        }

        override public function clearResult(_arg_1:Boolean=true):void
        {
            operation.clearResult(_arg_1);
        }

        override public function set makeObjectsBindable(_arg_1:Boolean):void
        {
            operation.makeObjectsBindable = _arg_1;
        }

        public function get rootURL():String
        {
            return (operation.rootURL);
        }

        override public function get makeObjectsBindable():Boolean
        {
            return (operation.makeObjectsBindable);
        }

        public function set channelSet(_arg_1:ChannelSet):void
        {
            useProxy = true;
            asyncRequest.channelSet = _arg_1;
        }


    }
}//package mx.rpc.http

import mx.rpc.http.AbstractOperation;
import mx.rpc.http.HTTPService;
import mx.rpc.AbstractService;
import mx.rpc.events.AbstractEvent;
import mx.core.mx_internal; 

use namespace mx_internal;

class HTTPOperation extends AbstractOperation 
{

    /*private*/ var _httpService:HTTPService;

    public function HTTPOperation(_arg_1:HTTPService, _arg_2:String=null)
    {
        super(null, _arg_2);
        this._httpService = _arg_1;
    }

    override public function get service():AbstractService
    {
        _log.warn("Attempted access to HTTPOperation.service. To get the containing HTTPService instance, use HTTPOperation.httpService");
        return (null);
    }

    public function get httpService():HTTPService
    {
        return (_httpService);
    }

    override mx_internal function dispatchRpcEvent(_arg_1:AbstractEvent):void
    {
        if (hasEventListener(_arg_1.type))
        {
            _arg_1.callTokenResponders();
            if (!_arg_1.isDefaultPrevented())
            {
                dispatchEvent(_arg_1);
            };
        }
        else
        {
            if (httpService != null)
            {
                httpService.dispatchRpcEvent(_arg_1);
            }
            else
            {
                _arg_1.callTokenResponders();
            };
        };
    }


}


