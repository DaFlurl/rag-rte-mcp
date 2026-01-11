// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.biff.BIFFReader

package com.as3xls.biff
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class BIFFReader 
    {

        private var stream:ByteArray;
        private var _tags:Array;

        public function BIFFReader(_arg_1:ByteArray)
        {
            this.stream = _arg_1;
            _arg_1.endian = Endian.LITTLE_ENDIAN;
            _arg_1.position = 0;
        }

        public function readTag():Record
        {
            if (this.stream.bytesAvailable < 4)
            {
                return (null);
            };
            var _local_1:uint = this.stream.readUnsignedShort();
            var _local_2:uint = this.stream.readUnsignedShort();
            if (this.stream.bytesAvailable < _local_2)
            {
                return (null);
            };
            var _local_3:ByteArray = new ByteArray();
            _local_3.endian = Endian.LITTLE_ENDIAN;
            if (_local_2 > 0)
            {
                this.stream.readBytes(_local_3, 0, _local_2);
            };
            return (new Record(_local_1, _local_3));
        }


    }
}//package com.as3xls.biff

