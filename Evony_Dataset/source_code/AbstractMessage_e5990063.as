// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.messages.AbstractMessage

package mx.messaging.messages
{
    import flash.utils.ByteArray;
    import mx.utils.RPCUIDUtil;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import flash.utils.getQualifiedClassName;
    import mx.utils.RPCObjectUtil;
    import mx.utils.RPCStringUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AbstractMessage implements IMessage 
    {

        public static const DESTINATION_CLIENT_ID_HEADER:String = "DSDstClientId";
        public static const ENDPOINT_HEADER:String = "DSEndpoint";
        public static const FLEX_CLIENT_ID_HEADER:String = "DSId";
        public static const PRIORITY_HEADER:String = "DSPriority";
        public static const REMOTE_CREDENTIALS_HEADER:String = "DSRemoteCredentials";
        public static const REMOTE_CREDENTIALS_CHARSET_HEADER:String = "DSRemoteCredentialsCharset";
        public static const REQUEST_TIMEOUT_HEADER:String = "DSRequestTimeout";
        public static const STATUS_CODE_HEADER:String = "DSStatusCode";
        private static const HAS_NEXT_FLAG:uint = 128;
        private static const BODY_FLAG:uint = 1;
        private static const CLIENT_ID_FLAG:uint = 2;
        private static const DESTINATION_FLAG:uint = 4;
        private static const HEADERS_FLAG:uint = 8;
        private static const MESSAGE_ID_FLAG:uint = 16;
        private static const TIMESTAMP_FLAG:uint = 32;
        private static const TIME_TO_LIVE_FLAG:uint = 64;
        private static const CLIENT_ID_BYTES_FLAG:uint = 1;
        private static const MESSAGE_ID_BYTES_FLAG:uint = 2;

        private var _body:Object = {};
        private var _messageId:String;
        private var messageIdBytes:ByteArray;
        private var _timestamp:Number = 0;
        private var _clientId:String;
        private var clientIdBytes:ByteArray;
        private var _headers:Object;
        private var _destination:String = "";
        private var _timeToLive:Number = 0;


        public function set messageId(_arg_1:String):void
        {
            _messageId = _arg_1;
            messageIdBytes = null;
        }

        public function get headers():Object
        {
            if (_headers == null)
            {
                _headers = {};
            };
            return (_headers);
        }

        public function readExternal(_arg_1:IDataInput):void
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_2:Array = readFlags(_arg_1);
            var _local_3:uint;
            while (_local_3 < _local_2.length)
            {
                _local_4 = (_local_2[_local_3] as uint);
                _local_5 = 0;
                if (_local_3 == 0)
                {
                    if ((_local_4 & BODY_FLAG) != 0)
                    {
                        body = _arg_1.readObject();
                    }
                    else
                    {
                        body = null;
                    };
                    if ((_local_4 & CLIENT_ID_FLAG) != 0)
                    {
                        clientId = _arg_1.readObject();
                    };
                    if ((_local_4 & DESTINATION_FLAG) != 0)
                    {
                        destination = (_arg_1.readObject() as String);
                    };
                    if ((_local_4 & HEADERS_FLAG) != 0)
                    {
                        headers = _arg_1.readObject();
                    };
                    if ((_local_4 & MESSAGE_ID_FLAG) != 0)
                    {
                        messageId = (_arg_1.readObject() as String);
                    };
                    if ((_local_4 & TIMESTAMP_FLAG) != 0)
                    {
                        timestamp = (_arg_1.readObject() as Number);
                    };
                    if ((_local_4 & TIME_TO_LIVE_FLAG) != 0)
                    {
                        timeToLive = (_arg_1.readObject() as Number);
                    };
                    _local_5 = 7;
                }
                else
                {
                    if (_local_3 == 1)
                    {
                        if ((_local_4 & CLIENT_ID_BYTES_FLAG) != 0)
                        {
                            clientIdBytes = (_arg_1.readObject() as ByteArray);
                            clientId = RPCUIDUtil.fromByteArray(clientIdBytes);
                        };
                        if ((_local_4 & MESSAGE_ID_BYTES_FLAG) != 0)
                        {
                            messageIdBytes = (_arg_1.readObject() as ByteArray);
                            messageId = RPCUIDUtil.fromByteArray(messageIdBytes);
                        };
                        _local_5 = 2;
                    };
                };
                if ((_local_4 >> _local_5) != 0)
                {
                    _local_6 = _local_5;
                    while (_local_6 < 6)
                    {
                        if (((_local_4 >> _local_6) & 0x01) != 0)
                        {
                            _arg_1.readObject();
                        };
                        _local_6++;
                    };
                };
                _local_3++;
            };
        }

        public function get messageId():String
        {
            if (_messageId == null)
            {
                _messageId = RPCUIDUtil.createUID();
            };
            return (_messageId);
        }

        public function set clientId(_arg_1:String):void
        {
            _clientId = _arg_1;
            clientIdBytes = null;
        }

        public function get destination():String
        {
            return (_destination);
        }

        public function get timestamp():Number
        {
            return (_timestamp);
        }

        protected function readFlags(_arg_1:IDataInput):Array
        {
            var _local_4:uint;
            var _local_2:Boolean = true;
            var _local_3:Array = [];
            while (((_local_2) && (_arg_1.bytesAvailable > 0)))
            {
                _local_4 = _arg_1.readUnsignedByte();
                _local_3.push(_local_4);
                if ((_local_4 & HAS_NEXT_FLAG) != 0)
                {
                    _local_2 = true;
                }
                else
                {
                    _local_2 = false;
                };
            };
            return (_local_3);
        }

        public function set headers(_arg_1:Object):void
        {
            _headers = _arg_1;
        }

        public function get body():Object
        {
            return (_body);
        }

        public function set destination(_arg_1:String):void
        {
            _destination = _arg_1;
        }

        public function set timestamp(_arg_1:Number):void
        {
            _timestamp = _arg_1;
        }

        protected function addDebugAttributes(_arg_1:Object):void
        {
            _arg_1["body"] = body;
            _arg_1["clientId"] = clientId;
            _arg_1["destination"] = destination;
            _arg_1["headers"] = headers;
            _arg_1["messageId"] = messageId;
            _arg_1["timestamp"] = timestamp;
            _arg_1["timeToLive"] = timeToLive;
        }

        public function get timeToLive():Number
        {
            return (_timeToLive);
        }

        public function set body(_arg_1:Object):void
        {
            _body = _arg_1;
        }

        public function get clientId():String
        {
            return (_clientId);
        }

        public function writeExternal(_arg_1:IDataOutput):void
        {
            var _local_2:uint;
            var _local_3:String = messageId;
            if (clientIdBytes == null)
            {
                clientIdBytes = RPCUIDUtil.toByteArray(_clientId);
            };
            if (messageIdBytes == null)
            {
                messageIdBytes = RPCUIDUtil.toByteArray(_messageId);
            };
            if (body != null)
            {
                _local_2 = (_local_2 | BODY_FLAG);
            };
            if (((!(clientId == null)) && (clientIdBytes == null)))
            {
                _local_2 = (_local_2 | CLIENT_ID_FLAG);
            };
            if (destination != null)
            {
                _local_2 = (_local_2 | DESTINATION_FLAG);
            };
            if (headers != null)
            {
                _local_2 = (_local_2 | HEADERS_FLAG);
            };
            if (((!(messageId == null)) && (messageIdBytes == null)))
            {
                _local_2 = (_local_2 | MESSAGE_ID_FLAG);
            };
            if (timestamp != 0)
            {
                _local_2 = (_local_2 | TIMESTAMP_FLAG);
            };
            if (timeToLive != 0)
            {
                _local_2 = (_local_2 | TIME_TO_LIVE_FLAG);
            };
            if (((!(clientIdBytes == null)) || (!(messageIdBytes == null))))
            {
                _local_2 = (_local_2 | HAS_NEXT_FLAG);
            };
            _arg_1.writeByte(_local_2);
            _local_2 = 0;
            if (clientIdBytes != null)
            {
                _local_2 = (_local_2 | CLIENT_ID_BYTES_FLAG);
            };
            if (messageIdBytes != null)
            {
                _local_2 = (_local_2 | MESSAGE_ID_BYTES_FLAG);
            };
            if (_local_2 != 0)
            {
                _arg_1.writeByte(_local_2);
            };
            if (body != null)
            {
                _arg_1.writeObject(body);
            };
            if (((!(clientId == null)) && (clientIdBytes == null)))
            {
                _arg_1.writeObject(clientId);
            };
            if (destination != null)
            {
                _arg_1.writeObject(destination);
            };
            if (headers != null)
            {
                _arg_1.writeObject(headers);
            };
            if (((!(messageId == null)) && (messageIdBytes == null)))
            {
                _arg_1.writeObject(messageId);
            };
            if (timestamp != 0)
            {
                _arg_1.writeObject(timestamp);
            };
            if (timeToLive != 0)
            {
                _arg_1.writeObject(timeToLive);
            };
            if (clientIdBytes != null)
            {
                _arg_1.writeObject(clientIdBytes);
            };
            if (messageIdBytes != null)
            {
                _arg_1.writeObject(messageIdBytes);
            };
        }

        final protected function getDebugString():String
        {
            var _local_4:String;
            var _local_5:uint;
            var _local_6:String;
            var _local_7:String;
            var _local_1:* = (("(" + getQualifiedClassName(this)) + ")");
            var _local_2:Object = {};
            addDebugAttributes(_local_2);
            var _local_3:Array = [];
            for (_local_4 in _local_2)
            {
                _local_3.push(_local_4);
            };
            _local_3.sort();
            _local_5 = 0;
            while (_local_5 < _local_3.length)
            {
                _local_6 = String(_local_3[_local_5]);
                _local_7 = RPCObjectUtil.toString(_local_2[_local_6]);
                _local_1 = (_local_1 + RPCStringUtil.substitute("\n  {0}={1}", _local_6, _local_7));
                _local_5++;
            };
            return (_local_1);
        }

        public function toString():String
        {
            return (RPCObjectUtil.toString(this));
        }

        public function set timeToLive(_arg_1:Number):void
        {
            _timeToLive = _arg_1;
        }


    }
}//package mx.messaging.messages

