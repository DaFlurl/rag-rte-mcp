// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.adobe.net.URIEncodingBitmap

package com.adobe.net
{
    import flash.utils.ByteArray;

    public class URIEncodingBitmap extends ByteArray 
    {

        public function URIEncodingBitmap(_arg_1:String):void
        {
            var _local_2:int;
            var _local_4:int;
            var _local_5:int;
            super();
            var _local_3:ByteArray = new ByteArray();
            _local_2 = 0;
            while (_local_2 < 16)
            {
                this.writeByte(0);
                _local_2++;
            };
            _local_3.writeUTFBytes(_arg_1);
            _local_3.position = 0;
            while (_local_3.bytesAvailable)
            {
                _local_4 = _local_3.readByte();
                if (_local_4 <= 127)
                {
                    this.position = (_local_4 >> 3);
                    _local_5 = this.readByte();
                    _local_5 = (_local_5 | (1 << (_local_4 & 0x07)));
                    this.position = (_local_4 >> 3);
                    this.writeByte(_local_5);
                };
            };
        }

        public function ShouldEscape(_arg_1:String):int
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeUTFBytes(_arg_1);
            _local_2.position = 0;
            _local_3 = _local_2.readByte();
            if ((_local_3 & 0x80))
            {
                return (0);
            };
            if (((_local_3 < 31) || (_local_3 == 127)))
            {
                return (_local_3);
            };
            this.position = (_local_3 >> 3);
            _local_4 = this.readByte();
            if ((_local_4 & (1 << (_local_3 & 0x07))))
            {
                return (_local_3);
            };
            return (0);
        }


    }
}//package com.adobe.net

