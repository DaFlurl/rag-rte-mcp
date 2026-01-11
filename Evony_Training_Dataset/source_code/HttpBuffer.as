// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.io.HttpBuffer

package org.httpclient.io
{
    import flash.utils.ByteArray;
    import com.adobe.utils.StringUtil;
    import org.httpclient.Log;

    public class HttpBuffer 
    {

        protected var _data:ByteArray = new ByteArray();
        protected var _chunkLength:uint = 0;
        protected var _cursor:uint = 0;


        public function truncate():void
        {
            var _local_1:ByteArray = new ByteArray();
            if (this._data.bytesAvailable)
            {
                this._data.readBytes(_local_1);
            };
            this._data = _local_1;
            this._cursor = 0;
        }

        public function readLine(_arg_1:Boolean=false):String
        {
            var _local_6:int;
            if (this._data.bytesAvailable == 0)
            {
                return (null);
            };
            var _local_2:uint = this._data.position;
            var _local_3:ByteArray = new ByteArray();
            var _local_4:Boolean;
            while (this._data.bytesAvailable > 0)
            {
                _local_6 = this._data.readByte();
                _local_3.writeByte(_local_6);
                if (_local_6 == 10)
                {
                    _local_4 = true;
                    break;
                };
            };
            var _local_5:String;
            if (_local_4)
            {
                _local_3.position = 0;
                _local_5 = _local_3.readUTFBytes(_local_3.length);
                this._cursor = this._data.position;
                return ((_arg_1) ? StringUtil.rtrim(_local_5) : _local_5);
            };
            this._data.position = this._cursor;
            return (null);
        }

        public function read(_arg_1:ByteArray):void
        {
            this._data.readBytes(_arg_1);
            this._cursor = this._data.position;
        }

        public function readAvailable():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            this.read(_local_1);
            _local_1.position = 0;
            return (_local_1);
        }

        public function readChunks(_arg_1:Function):Boolean
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:String;
            var _local_5:Number;
            var _local_6:ByteArray;
            while (this._data.bytesAvailable > 0)
            {
                if (this._chunkLength == 0)
                {
                    _local_2 = this.readLine();
                    if (!_local_2)
                    {
                        throw (new Error("No data available"));
                    };
                    _local_3 = _local_2.match(/\A([0-9a-fA-F]+).*/);
                    if (!_local_3)
                    {
                        throw (new Error(("Invalid chunk; trying to find chunk length at line: " + _local_2)));
                    };
                    _local_4 = _local_3[1];
                    _local_5 = parseInt(_local_4, 16);
                    Log.debug(("Chunk size: " + _local_5));
                    if (_local_5 <= 0)
                    {
                        return (true);
                    };
                    this._chunkLength = _local_5;
                };
                if (this._data.bytesAvailable >= (this._chunkLength + 2))
                {
                    _local_6 = new ByteArray();
                    this._data.readBytes(_local_6, 0, this._chunkLength);
                    Log.debug(("Read chunk size: " + this._chunkLength));
                    this._data.position = (this._data.position + 2);
                    this._cursor = this._data.position;
                    this._chunkLength = 0;
                    (_arg_1(_local_6));
                }
                else
                {
                    this.truncate();
                    return (false);
                };
            };
            return (false);
        }

        public function get bytesAvailable():uint
        {
            return (this._data.bytesAvailable);
        }

        public function write(_arg_1:ByteArray):void
        {
            this._data.position = this._data.length;
            this._data.writeBytes(_arg_1);
            this._data.position = this._cursor;
        }


    }
}//package org.httpclient.io

