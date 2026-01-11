// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.messages.AsyncMessage

package mx.messaging.messages
{
    import flash.utils.ByteArray;
    import mx.utils.RPCUIDUtil;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;

    public class AsyncMessage extends AbstractMessage implements ISmallMessage 
    {

        public static const SUBTOPIC_HEADER:String = "DSSubtopic";
        private static const CORRELATION_ID_FLAG:uint = 1;
        private static const CORRELATION_ID_BYTES_FLAG:uint = 2;

        private var _correlationId:String;
        private var correlationIdBytes:ByteArray;

        public function AsyncMessage(_arg_1:Object=null, _arg_2:Object=null)
        {
            correlationId = "";
            if (_arg_1 != null)
            {
                this.body = _arg_1;
            };
            if (_arg_2 != null)
            {
                this.headers = _arg_2;
            };
        }

        override protected function addDebugAttributes(_arg_1:Object):void
        {
            super.addDebugAttributes(_arg_1);
            _arg_1["correlationId"] = correlationId;
        }

        override public function readExternal(_arg_1:IDataInput):void
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            super.readExternal(_arg_1);
            var _local_2:Array = readFlags(_arg_1);
            var _local_3:uint;
            while (_local_3 < _local_2.length)
            {
                _local_4 = (_local_2[_local_3] as uint);
                _local_5 = 0;
                if (_local_3 == 0)
                {
                    if ((_local_4 & CORRELATION_ID_FLAG) != 0)
                    {
                        correlationId = (_arg_1.readObject() as String);
                    };
                    if ((_local_4 & CORRELATION_ID_BYTES_FLAG) != 0)
                    {
                        correlationIdBytes = (_arg_1.readObject() as ByteArray);
                        correlationId = RPCUIDUtil.fromByteArray(correlationIdBytes);
                    };
                    _local_5 = 2;
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

        public function getSmallMessage():IMessage
        {
            var _local_1:Object = this;
            if (_local_1.constructor == AsyncMessage)
            {
                return (new AsyncMessageExt(this));
            };
            return (null);
        }

        override public function writeExternal(_arg_1:IDataOutput):void
        {
            super.writeExternal(_arg_1);
            if (correlationIdBytes == null)
            {
                correlationIdBytes = RPCUIDUtil.toByteArray(_correlationId);
            };
            var _local_2:uint;
            if (((!(correlationId == null)) && (correlationIdBytes == null)))
            {
                _local_2 = (_local_2 | CORRELATION_ID_FLAG);
            };
            if (correlationIdBytes != null)
            {
                _local_2 = (_local_2 | CORRELATION_ID_BYTES_FLAG);
            };
            _arg_1.writeByte(_local_2);
            if (((!(correlationId == null)) && (correlationIdBytes == null)))
            {
                _arg_1.writeObject(correlationId);
            };
            if (correlationIdBytes != null)
            {
                _arg_1.writeObject(correlationIdBytes);
            };
        }

        public function set correlationId(_arg_1:String):void
        {
            _correlationId = _arg_1;
            correlationIdBytes = null;
        }

        public function get correlationId():String
        {
            return (_correlationId);
        }


    }
}//package mx.messaging.messages

