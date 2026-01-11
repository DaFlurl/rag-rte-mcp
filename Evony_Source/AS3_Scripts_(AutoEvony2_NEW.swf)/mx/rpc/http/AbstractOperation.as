// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.http.AbstractOperation

package mx.rpc.http
{
    import mx.rpc.AbstractOperation;
    import mx.messaging.ChannelSet;
    import mx.logging.ILogger;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.logging.Log;
    import mx.rpc.mxml.Concurrency;
    import mx.rpc.AbstractService;
    import mx.collections.ArrayCollection;
    import mx.messaging.channels.DirectHTTPChannel;
    import mx.managers.CursorManager;
    import mx.messaging.messages.AsyncMessage;
    import mx.rpc.AsyncToken;
    import mx.messaging.events.MessageEvent;
    import mx.messaging.config.LoaderConfig;
    import mx.utils.StringUtil;
    import mx.rpc.Fault;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.xml.SimpleXMLEncoder;
    import flash.xml.XMLDocument;
    import mx.rpc.AsyncDispatcher;
    import mx.utils.URLUtil;
    import flash.xml.XMLNode;
    import mx.utils.ObjectUtil;
    import mx.messaging.messages.HTTPRequestMessage;
    import mx.netmon.NetworkMonitor;
    import mx.rpc.xml.SimpleXMLDecoder;
    import flash.utils.getQualifiedClassName;
    import mx.utils.ObjectProxy;
    import mx.messaging.messages.IMessage;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AbstractOperation extends mx.rpc.AbstractOperation 
    {

        mx_internal static const RESULT_FORMAT_E4X:String = "e4x";
        mx_internal static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
        mx_internal static const RESULT_FORMAT_OBJECT:String = "object";
        mx_internal static const RESULT_FORMAT_ARRAY:String = "array";
        mx_internal static const RESULT_FORMAT_TEXT:String = "text";
        mx_internal static const RESULT_FORMAT_XML:String = "xml";
        mx_internal static const CONTENT_TYPE_XML:String = "application/xml";
        mx_internal static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
        private static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
        private static const ERROR_DECODING:String = "Client.CouldNotDecode";
        private static const ERROR_ENCODING:String = "Client.CouldNotEncode";
        private static var _directChannelSet:ChannelSet;

        private var _method:String = "GET";
        mx_internal var _log:ILogger;
        private var _useProxy:Boolean = false;
        public var serializationFilter:SerializationFilter;
        public var argumentNames:Array;
        public var xmlEncode:Function;
        public var request:Object = {};
        private var _contentType:String = "application/x-www-form-urlencoded";
        public var headers:Object = {};
        private var _url:String;
        private var _showBusyCursor:Boolean = false;
        mx_internal var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _resultFormat:String = "object";
        private var _concurrency:String;
        public var xmlDecode:Function;
        mx_internal var _rootURL:String;

        public function AbstractOperation(_arg_1:AbstractService=null, _arg_2:String=null)
        {
            super(_arg_1, _arg_2);
            _log = Log.getLogger("mx.rpc.http.HTTPService");
            concurrency = Concurrency.MULTIPLE;
        }

        private function decodeArray(_arg_1:Object):Object
        {
            var _local_2:Array;
            if ((_arg_1 is Array))
            {
                _local_2 = (_arg_1 as Array);
            }
            else
            {
                if ((_arg_1 is ArrayCollection))
                {
                    return (_arg_1);
                };
                _local_2 = [];
                _local_2.push(_arg_1);
            };
            if (makeObjectsBindable)
            {
                return (new ArrayCollection(_local_2));
            };
            return (_local_2);
        }

        public function get concurrency():String
        {
            return (_concurrency);
        }

        public function set showBusyCursor(_arg_1:Boolean):void
        {
            _showBusyCursor = _arg_1;
        }

        public function get showBusyCursor():Boolean
        {
            return (_showBusyCursor);
        }

        private function getDirectChannelSet():ChannelSet
        {
            var _local_1:ChannelSet;
            if (_directChannelSet == null)
            {
                _local_1 = new ChannelSet();
                _local_1.addChannel(new DirectHTTPChannel("direct_http_channel"));
                _directChannelSet = _local_1;
            };
            return (_directChannelSet);
        }

        public function set concurrency(_arg_1:String):void
        {
            _concurrency = _arg_1;
        }

        public function get useProxy():Boolean
        {
            return (_useProxy);
        }

        override mx_internal function preHandle(_arg_1:MessageEvent):AsyncToken
        {
            if (showBusyCursor)
            {
                CursorManager.removeBusyCursor();
            };
            var _local_2:Boolean = activeCalls.wasLastCall(AsyncMessage(_arg_1.message).correlationId);
            var _local_3:AsyncToken = super.preHandle(_arg_1);
            if (((Concurrency.LAST == concurrency) && (!(_local_2))))
            {
                return (null);
            };
            return (_local_3);
        }

        public function get rootURL():String
        {
            if (_rootURL == null)
            {
                _rootURL = LoaderConfig.url;
            };
            return (_rootURL);
        }

        public function set contentType(_arg_1:String):void
        {
            _contentType = _arg_1;
        }

        public function set method(_arg_1:String):void
        {
            _method = _arg_1;
        }

        private function decodeParameterString(_arg_1:String):Object
        {
            var _local_6:String;
            var _local_7:int;
            var _local_8:String;
            var _local_9:String;
            var _local_2:String = StringUtil.trim(_arg_1);
            var _local_3:Array = _local_2.split("&");
            var _local_4:Object = {};
            var _local_5:int;
            while (_local_5 < _local_3.length)
            {
                _local_6 = _local_3[_local_5];
                _local_7 = _local_6.indexOf("=");
                if (_local_7 != -1)
                {
                    _local_8 = _local_6.substr(0, _local_7);
                    _local_8 = _local_8.split("+").join(" ");
                    _local_8 = unescape(_local_8);
                    _local_9 = _local_6.substr((_local_7 + 1));
                    _local_9 = _local_9.split("+").join(" ");
                    _local_9 = unescape(_local_9);
                    _local_4[_local_8] = _local_9;
                };
                _local_5++;
            };
            return (_local_4);
        }

        public function set useProxy(_arg_1:Boolean):void
        {
            var _local_2:ChannelSet;
            if (_arg_1 != _useProxy)
            {
                _useProxy = _arg_1;
                _local_2 = getDirectChannelSet();
                if (!useProxy)
                {
                    if (_local_2 != asyncRequest.channelSet)
                    {
                        asyncRequest.channelSet = _local_2;
                    };
                }
                else
                {
                    if (asyncRequest.channelSet == _local_2)
                    {
                        asyncRequest.channelSet = null;
                    };
                };
            };
        }

        protected function getHeaders():Object
        {
            return (headers);
        }

        public function sendBody(_arg_1:Object):AsyncToken
        {
            var _local_3:Object;
            var _local_4:AsyncToken;
            var _local_5:Fault;
            var _local_6:FaultEvent;
            var _local_7:String;
            var _local_11:String;
            var _local_12:Object;
            var _local_13:SimpleXMLEncoder;
            var _local_14:XMLDocument;
            var _local_15:Array;
            var _local_16:int;
            var _local_17:Object;
            var _local_18:Object;
            var _local_19:*;
            var _local_20:ChannelSet;
            var _local_2:SerializationFilter = getSerializationFilter();
            if (((Concurrency.SINGLE == concurrency) && (activeCalls.hasActiveCalls())))
            {
                _local_4 = new AsyncToken(null);
                _local_11 = resourceManager.getString("rpc", "pendingCallExists");
                _local_5 = new Fault("ConcurrencyError", _local_11);
                _local_6 = FaultEvent.createEvent(_local_5, _local_4);
                new AsyncDispatcher(dispatchRpcEvent, [_local_6], 10);
                return (_local_4);
            };
            var _local_8:String = contentType;
            var _local_9:String = url;
            if (((_local_9) && (!(_local_9 == ""))))
            {
                _local_9 = URLUtil.getFullURL(rootURL, _local_9);
            };
            if (_local_2 != null)
            {
                _local_8 = _local_2.getRequestContentType(this, _arg_1, _local_8);
                _local_9 = _local_2.serializeURL(this, _arg_1, _local_9);
                _arg_1 = _local_2.serializeBody(this, _arg_1);
            };
            if (_local_8 == CONTENT_TYPE_XML)
            {
                if (((_arg_1 is String) && (xmlEncode == null)))
                {
                    _local_3 = (_arg_1 as String);
                }
                else
                {
                    if (((!(_arg_1 is XMLNode)) && (!(_arg_1 is XML))))
                    {
                        if (xmlEncode != null)
                        {
                            _local_12 = xmlEncode(_arg_1);
                            if (null == _local_12)
                            {
                                _local_4 = new AsyncToken(null);
                                _local_7 = resourceManager.getString("rpc", "xmlEncodeReturnNull");
                                _local_5 = new Fault(ERROR_ENCODING, _local_7);
                                _local_6 = FaultEvent.createEvent(_local_5, _local_4);
                                new AsyncDispatcher(dispatchRpcEvent, [_local_6], 10);
                                return (_local_4);
                            };
                            if (!(_local_12 is XMLNode))
                            {
                                _local_4 = new AsyncToken(null);
                                _local_7 = resourceManager.getString("rpc", "xmlEncodeReturnNoXMLNode");
                                _local_5 = new Fault(ERROR_ENCODING, _local_7);
                                _local_6 = FaultEvent.createEvent(_local_5, _local_4);
                                new AsyncDispatcher(dispatchRpcEvent, [_local_6], 10);
                                return (_local_4);
                            };
                            _local_3 = XMLNode(_local_12).toString();
                        }
                        else
                        {
                            _local_13 = new SimpleXMLEncoder(null);
                            _local_14 = new XMLDocument();
                            _local_15 = _local_13.encodeValue(_arg_1, new QName(null, "encoded"), new XMLNode(1, "top")).childNodes.concat();
                            _local_16 = 0;
                            while (_local_16 < _local_15.length)
                            {
                                _local_14.appendChild(_local_15[_local_16]);
                                _local_16++;
                            };
                            _local_3 = _local_14.toString();
                        };
                    }
                    else
                    {
                        _local_3 = XML(_arg_1).toXMLString();
                    };
                };
            }
            else
            {
                if (_local_8 == CONTENT_TYPE_FORM)
                {
                    _local_3 = {};
                    if (typeof(_arg_1) == "object")
                    {
                        _local_18 = ObjectUtil.getClassInfo(_arg_1);
                        for each (_local_19 in _local_18.properties)
                        {
                            _local_17 = _arg_1[_local_19];
                            if (_local_17 != null)
                            {
                                if ((_local_17 is Array))
                                {
                                    _local_3[_local_19] = _local_17;
                                }
                                else
                                {
                                    _local_3[_local_19] = _local_17.toString();
                                };
                            };
                        };
                    }
                    else
                    {
                        _local_3 = _arg_1;
                    };
                }
                else
                {
                    _local_3 = _arg_1;
                };
            };
            var _local_10:HTTPRequestMessage = new HTTPRequestMessage();
            if (useProxy)
            {
                if (((_local_9) && (!(_local_9 == ""))))
                {
                    _local_10.url = _local_9;
                };
                if (NetworkMonitor.isMonitoring())
                {
                    _local_10.recordHeaders = true;
                };
            }
            else
            {
                if (!_local_9)
                {
                    _local_4 = new AsyncToken(null);
                    _local_7 = resourceManager.getString("rpc", "urlNotSpecified");
                    _local_5 = new Fault(ERROR_URL_REQUIRED, _local_7);
                    _local_6 = FaultEvent.createEvent(_local_5, _local_4);
                    new AsyncDispatcher(dispatchRpcEvent, [_local_6], 10);
                    return (_local_4);
                };
                if (!useProxy)
                {
                    _local_20 = getDirectChannelSet();
                    if (_local_20 != asyncRequest.channelSet)
                    {
                        asyncRequest.channelSet = _local_20;
                    };
                };
                if (NetworkMonitor.isMonitoring())
                {
                    _local_10.recordHeaders = true;
                };
                _local_10.url = _local_9;
            };
            _local_10.contentType = _local_8;
            _local_10.method = method.toUpperCase();
            if (((_local_8 == CONTENT_TYPE_XML) && (_local_10.method == HTTPRequestMessage.GET_METHOD)))
            {
                _local_10.method = HTTPRequestMessage.POST_METHOD;
            };
            _local_10.body = _local_3;
            _local_10.httpHeaders = getHeaders();
            return (invoke(_local_10));
        }

        protected function getSerializationFilter():SerializationFilter
        {
            return (serializationFilter);
        }

        public function get contentType():String
        {
            return (_contentType);
        }

        public function set url(_arg_1:String):void
        {
            _url = _arg_1;
        }

        public function get method():String
        {
            return (_method);
        }

        public function set resultFormat(_arg_1:String):void
        {
            var _local_2:SerializationFilter;
            var _local_3:String;
            switch (_arg_1)
            {
                case RESULT_FORMAT_OBJECT:
                case RESULT_FORMAT_ARRAY:
                case RESULT_FORMAT_XML:
                case RESULT_FORMAT_E4X:
                case RESULT_FORMAT_TEXT:
                case RESULT_FORMAT_FLASHVARS:
                    break;
                default:
                    if (((!(_arg_1 == null)) && ((_local_2 = SerializationFilter.filterForResultFormatTable[_arg_1]) == null)))
                    {
                        _local_3 = resourceManager.getString("rpc", "invalidResultFormat", [_arg_1, RESULT_FORMAT_OBJECT, RESULT_FORMAT_ARRAY, RESULT_FORMAT_XML, RESULT_FORMAT_E4X, RESULT_FORMAT_TEXT, RESULT_FORMAT_FLASHVARS]);
                        throw (new ArgumentError(_local_3));
                    };
                    serializationFilter = _local_2;
            };
            _resultFormat = _arg_1;
        }

        public function set rootURL(_arg_1:String):void
        {
            _rootURL = _arg_1;
        }

        override mx_internal function processResult(message:IMessage, token:AsyncToken):Boolean
        {
            var tmp:Object;
            var fault:Fault;
            var decoded:Object;
            var msg:String;
            var fault1:Fault;
            var decoder:SimpleXMLDecoder;
            var fault2:Fault;
            var fault3:Fault;
            var body:Object = message.body;
            _log.info("Decoding HTTPService response");
            _log.debug("Processing HTTPService response message:\n{0}", message);
            var filter:SerializationFilter = getSerializationFilter();
            if (filter != null)
            {
                body = filter.deserializeResult(this, body);
            };
            if (((body == null) || (((!(body == null)) && (body is String)) && (StringUtil.trim(String(body)) == ""))))
            {
                _result = body;
                return (true);
            };
            if ((body is String))
            {
                if ((((resultFormat == RESULT_FORMAT_XML) || (resultFormat == RESULT_FORMAT_OBJECT)) || (resultFormat == RESULT_FORMAT_ARRAY)))
                {
                    tmp = new XMLDocument();
                    XMLDocument(tmp).ignoreWhite = true;
                    try
                    {
                        XMLDocument(tmp).parseXML(String(body));
                    }
                    catch(parseError:Error)
                    {
                        fault = new Fault(ERROR_DECODING, parseError.message);
                        dispatchRpcEvent(FaultEvent.createEvent(fault, token, message));
                        return (false);
                    };
                    if (((resultFormat == RESULT_FORMAT_OBJECT) || (resultFormat == RESULT_FORMAT_ARRAY)))
                    {
                        if (xmlDecode != null)
                        {
                            decoded = xmlDecode(tmp);
                            if (decoded == null)
                            {
                                msg = resourceManager.getString("rpc", "xmlDecodeReturnNull");
                                fault1 = new Fault(ERROR_DECODING, msg);
                                dispatchRpcEvent(FaultEvent.createEvent(fault1, token, message));
                            };
                        }
                        else
                        {
                            decoder = new SimpleXMLDecoder(makeObjectsBindable);
                            decoded = decoder.decodeXML(XMLNode(tmp));
                            if (decoded == null)
                            {
                                msg = resourceManager.getString("rpc", "defaultDecoderFailed");
                                fault2 = new Fault(ERROR_DECODING, msg);
                                dispatchRpcEvent(FaultEvent.createEvent(fault2, token, message));
                            };
                        };
                        if (decoded == null)
                        {
                            return (false);
                        };
                        if (((makeObjectsBindable) && (getQualifiedClassName(decoded) == "Object")))
                        {
                            decoded = new ObjectProxy(decoded);
                        }
                        else
                        {
                            decoded = decoded;
                        };
                        if (resultFormat == RESULT_FORMAT_ARRAY)
                        {
                            decoded = decodeArray(decoded);
                        };
                        _result = decoded;
                    }
                    else
                    {
                        if (tmp.childNodes.length == 1)
                        {
                            tmp = tmp.firstChild;
                        };
                        _result = tmp;
                    };
                }
                else
                {
                    if (resultFormat == RESULT_FORMAT_E4X)
                    {
                        try
                        {
                            _result = new XML(String(body));
                        }
                        catch(error:Error)
                        {
                            fault3 = new Fault(ERROR_DECODING, error.message);
                            dispatchRpcEvent(FaultEvent.createEvent(fault3, token, message));
                            return (false);
                        };
                    }
                    else
                    {
                        if (resultFormat == RESULT_FORMAT_FLASHVARS)
                        {
                            _result = decodeParameterString(String(body));
                        }
                        else
                        {
                            _result = body;
                        };
                    };
                };
            }
            else
            {
                if (resultFormat == RESULT_FORMAT_ARRAY)
                {
                    body = decodeArray(body);
                };
                _result = body;
            };
            return (true);
        }

        public function get url():String
        {
            return (_url);
        }

        public function get resultFormat():String
        {
            return (_resultFormat);
        }

        override mx_internal function invoke(_arg_1:IMessage, _arg_2:AsyncToken=null):AsyncToken
        {
            if (showBusyCursor)
            {
                CursorManager.setBusyCursor();
            };
            return (super.invoke(_arg_1, _arg_2));
        }

        override public function cancel(_arg_1:String=null):AsyncToken
        {
            if (showBusyCursor)
            {
                CursorManager.removeBusyCursor();
            };
            return (super.cancel(_arg_1));
        }


    }
}//package mx.rpc.http

