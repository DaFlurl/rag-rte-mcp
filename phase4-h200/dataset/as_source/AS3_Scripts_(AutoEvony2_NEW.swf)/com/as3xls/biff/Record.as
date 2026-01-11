// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.biff.Record

package com.as3xls.biff
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class Record 
    {

        private var _type:uint;
        private var _data:ByteArray;

        public function Record(_arg_1:uint, _arg_2:ByteArray=null)
        {
            this._type = _arg_1;
            this._data = ((_arg_2 == null) ? new ByteArray() : _arg_2);
            this._data.endian = Endian.LITTLE_ENDIAN;
        }

        public function set type(_arg_1:uint):void
        {
            this._type = _arg_1;
        }

        public function get length():uint
        {
            return (this._data.length);
        }

        public function get type():uint
        {
            return (this._type);
        }

        public function get data():ByteArray
        {
            return (this._data);
        }

        public function readUnicodeStr16():String
        {
            var _local_1:uint = this._data.readUnsignedShort();
            var _local_2:uint = this._data.readByte();
            var _local_3:* = ((_local_2 & 0x01) == 0);
            var _local_4:* = ((_local_2 & 0x04) == 4);
            var _local_5:* = ((_local_2 & 0x08) == 8);
            if (!_local_3)
            {
                _local_1 = (_local_1 * 2);
            };
            _local_1 = ((_local_1 > this._data.bytesAvailable) ? this._data.bytesAvailable : _local_1);
            var _local_6:String = this._data.readUTFBytes(_local_1);
            return (_local_6);
        }


    }
}//package com.as3xls.biff

