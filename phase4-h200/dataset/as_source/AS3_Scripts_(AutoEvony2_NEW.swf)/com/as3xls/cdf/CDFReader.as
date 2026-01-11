// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.cdf.CDFReader

package com.as3xls.cdf
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class CDFReader 
    {

        private var stream:ByteArray;
        private var sectorSize:uint;
        private var sat:Array;
        public var dir:Array;

        public function CDFReader(_arg_1:ByteArray)
        {
            this.stream = _arg_1;
            _arg_1.position = 0;
            _arg_1.endian = Endian.LITTLE_ENDIAN;
            this.loadDocument();
        }

        public static function isCDFFile(_arg_1:ByteArray):Boolean
        {
            var _local_2:Array = [208, 207, 17, 224, 161, 177, 26, 225];
            if (_arg_1.length < _local_2.length)
            {
                return (false);
            };
            var _local_3:uint;
            while (_local_3 < _local_2.length)
            {
                if (_local_2[_local_3] != _arg_1[_local_3])
                {
                    return (false);
                };
                _local_3++;
            };
            return (true);
        }


        private function loadDocument():void
        {
            var _local_16:String;
            var _local_17:uint;
            var _local_18:uint;
            var _local_19:uint;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:uint;
            var _local_1:Number = this.stream.readDouble();
            this.stream.position = (this.stream.position + 16);
            var _local_2:uint = this.stream.readUnsignedShort();
            var _local_3:uint = this.stream.readUnsignedShort();
            var _local_4:uint = this.stream.readUnsignedShort();
            this.sectorSize = Math.pow(2, this.stream.readUnsignedShort());
            var _local_5:uint = Math.pow(2, this.stream.readUnsignedShort());
            this.stream.position = (this.stream.position + 10);
            var _local_6:uint = this.stream.readUnsignedInt();
            var _local_7:int = this.stream.readInt();
            this.stream.position = (this.stream.position + 4);
            var _local_8:uint = this.stream.readUnsignedInt();
            var _local_9:int = this.stream.readInt();
            var _local_10:uint = this.stream.readUnsignedInt();
            var _local_11:int = this.stream.readInt();
            var _local_12:uint = this.stream.readUnsignedInt();
            this.sat = new Array();
            var _local_13:uint;
            while (_local_13 < 109)
            {
                this.stream.position = (76 + (_local_13 * 4));
                this.sat[_local_13] = this.stream.readInt();
                _local_13++;
            };
            var _local_14:ByteArray = new ByteArray();
            _local_14.endian = Endian.LITTLE_ENDIAN;
            _local_13 = 0;
            while (_local_13 < this.sat.length)
            {
                if (this.sat[_local_13] >= 0)
                {
                    this.stream.position = this.sectorOffset(this.sat[_local_13]);
                    this.stream.readBytes(_local_14, (_local_13 * this.sectorSize), this.sectorSize);
                };
                _local_13++;
            };
            this.sat = new Array();
            _local_13 = 0;
            while (_local_13 < (_local_14.length / 4))
            {
                this.sat[_local_13] = _local_14.readInt();
                _local_13++;
            };
            this.dir = new Array();
            var _local_15:ByteArray = this.loadStream(_local_7);
            while (_local_15.bytesAvailable > 0)
            {
                _local_16 = "";
                _local_13 = 0;
                while (_local_13 < 32)
                {
                    _local_16 = (_local_16 + String.fromCharCode(_local_15.readUnsignedByte()));
                    _local_15.position++;
                    _local_13++;
                };
                _local_17 = _local_15.readUnsignedShort();
                _local_16 = _local_16.substr(0, ((_local_17 - 2) / 2));
                _local_18 = _local_15.readUnsignedByte();
                _local_19 = _local_15.readUnsignedByte();
                _local_20 = _local_15.readInt();
                _local_21 = _local_15.readInt();
                _local_22 = _local_15.readInt();
                _local_15.position = (_local_15.position + 16);
                _local_15.position = (_local_15.position + 4);
                _local_15.position = (_local_15.position + 8);
                _local_15.position = (_local_15.position + 8);
                _local_23 = _local_15.readInt();
                _local_24 = _local_15.readUnsignedInt();
                _local_15.position = (_local_15.position + 4);
                if (_local_18 == 2)
                {
                    this.dir.push({
                        "name":_local_16,
                        "secId":_local_23
                    });
                };
            };
        }

        private function loadStream(_arg_1:uint):ByteArray
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.endian = Endian.LITTLE_ENDIAN;
            var _local_3:int = _arg_1;
            var _local_4:uint;
            while (_local_3 != -2)
            {
                this.stream.position = this.sectorOffset(_local_3);
                this.stream.readBytes(_local_2, _local_4, this.sectorSize);
                _local_4 = (_local_4 + this.sectorSize);
                _local_3 = this.sat[_local_3];
            };
            return (_local_2);
        }

        public function loadDirectoryEntry(_arg_1:uint):ByteArray
        {
            return (this.loadStream(this.dir[_arg_1].secId));
        }

        private function sectorOffset(_arg_1:uint):uint
        {
            return (0x0200 + (_arg_1 * this.sectorSize));
        }


    }
}//package com.as3xls.cdf

