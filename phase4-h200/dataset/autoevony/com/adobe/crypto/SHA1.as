// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.adobe.crypto.SHA1

package com.adobe.crypto
{
    import flash.utils.ByteArray;
    import com.adobe.utils.IntUtil;
    import mx.utils.Base64Encoder;

    public class SHA1 
    {

        public static var digest:ByteArray;


        private static function createBlocksFromByteArray(_arg_1:ByteArray):Array
        {
            var _local_2:int = _arg_1.position;
            _arg_1.position = 0;
            var _local_3:Array = new Array();
            var _local_4:int = (_arg_1.length * 8);
            var _local_5:* = 0xFF;
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                _local_3[(_local_6 >> 5)] = (_local_3[(_local_6 >> 5)] | ((_arg_1.readByte() & _local_5) << (24 - (_local_6 % 32))));
                _local_6 = (_local_6 + 8);
            };
            _local_3[(_local_4 >> 5)] = (_local_3[(_local_4 >> 5)] | (128 << (24 - (_local_4 % 32))));
            _local_3[((((_local_4 + 64) >> 9) << 4) + 15)] = _local_4;
            _arg_1.position = _local_2;
            return (_local_3);
        }

        private static function hashBlocks(_arg_1:Array):ByteArray
        {
            var _local_9:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_2:* = 1732584193;
            var _local_3:int = 4023233417;
            var _local_4:int = 2562383102;
            var _local_5:* = 271733878;
            var _local_6:int = 3285377520;
            var _local_7:int = _arg_1.length;
            var _local_8:Array = new Array(80);
            var _local_10:int;
            while (_local_10 < _local_7)
            {
                _local_12 = _local_2;
                _local_13 = _local_3;
                _local_14 = _local_4;
                _local_15 = _local_5;
                _local_16 = _local_6;
                _local_17 = 0;
                while (_local_17 < 20)
                {
                    if (_local_17 < 16)
                    {
                        _local_8[_local_17] = _arg_1[(_local_10 + _local_17)];
                    }
                    else
                    {
                        _local_9 = (((_local_8[(_local_17 - 3)] ^ _local_8[(_local_17 - 8)]) ^ _local_8[(_local_17 - 14)]) ^ _local_8[(_local_17 - 16)]);
                        _local_8[_local_17] = ((_local_9 << 1) | (_local_9 >>> 31));
                    };
                    _local_9 = ((((((_local_12 << 5) | (_local_12 >>> 27)) + ((_local_13 & _local_14) | ((~(_local_13)) & _local_15))) + _local_16) + int(_local_8[_local_17])) + 1518500249);
                    _local_16 = _local_15;
                    _local_15 = _local_14;
                    _local_14 = ((_local_13 << 30) | (_local_13 >>> 2));
                    _local_13 = _local_12;
                    _local_12 = _local_9;
                    _local_17++;
                };
                while (_local_17 < 40)
                {
                    _local_9 = (((_local_8[(_local_17 - 3)] ^ _local_8[(_local_17 - 8)]) ^ _local_8[(_local_17 - 14)]) ^ _local_8[(_local_17 - 16)]);
                    _local_8[_local_17] = ((_local_9 << 1) | (_local_9 >>> 31));
                    _local_9 = ((((((_local_12 << 5) | (_local_12 >>> 27)) + ((_local_13 ^ _local_14) ^ _local_15)) + _local_16) + int(_local_8[_local_17])) + 1859775393);
                    _local_16 = _local_15;
                    _local_15 = _local_14;
                    _local_14 = ((_local_13 << 30) | (_local_13 >>> 2));
                    _local_13 = _local_12;
                    _local_12 = _local_9;
                    _local_17++;
                };
                while (_local_17 < 60)
                {
                    _local_9 = (((_local_8[(_local_17 - 3)] ^ _local_8[(_local_17 - 8)]) ^ _local_8[(_local_17 - 14)]) ^ _local_8[(_local_17 - 16)]);
                    _local_8[_local_17] = ((_local_9 << 1) | (_local_9 >>> 31));
                    _local_9 = ((((((_local_12 << 5) | (_local_12 >>> 27)) + (((_local_13 & _local_14) | (_local_13 & _local_15)) | (_local_14 & _local_15))) + _local_16) + int(_local_8[_local_17])) + 2400959708);
                    _local_16 = _local_15;
                    _local_15 = _local_14;
                    _local_14 = ((_local_13 << 30) | (_local_13 >>> 2));
                    _local_13 = _local_12;
                    _local_12 = _local_9;
                    _local_17++;
                };
                while (_local_17 < 80)
                {
                    _local_9 = (((_local_8[(_local_17 - 3)] ^ _local_8[(_local_17 - 8)]) ^ _local_8[(_local_17 - 14)]) ^ _local_8[(_local_17 - 16)]);
                    _local_8[_local_17] = ((_local_9 << 1) | (_local_9 >>> 31));
                    _local_9 = ((((((_local_12 << 5) | (_local_12 >>> 27)) + ((_local_13 ^ _local_14) ^ _local_15)) + _local_16) + int(_local_8[_local_17])) + 3395469782);
                    _local_16 = _local_15;
                    _local_15 = _local_14;
                    _local_14 = ((_local_13 << 30) | (_local_13 >>> 2));
                    _local_13 = _local_12;
                    _local_12 = _local_9;
                    _local_17++;
                };
                _local_2 = (_local_2 + _local_12);
                _local_3 = (_local_3 + _local_13);
                _local_4 = (_local_4 + _local_14);
                _local_5 = (_local_5 + _local_15);
                _local_6 = (_local_6 + _local_16);
                _local_10 = (_local_10 + 16);
            };
            var _local_11:ByteArray = new ByteArray();
            _local_11.writeInt(_local_2);
            _local_11.writeInt(_local_3);
            _local_11.writeInt(_local_4);
            _local_11.writeInt(_local_5);
            _local_11.writeInt(_local_6);
            _local_11.position = 0;
            digest = new ByteArray();
            digest.writeBytes(_local_11);
            digest.position = 0;
            return (_local_11);
        }

        private static function createBlocksFromString(_arg_1:String):Array
        {
            var _local_2:Array = new Array();
            var _local_3:int = (_arg_1.length * 8);
            var _local_4:* = 0xFF;
            var _local_5:int;
            while (_local_5 < _local_3)
            {
                _local_2[(_local_5 >> 5)] = (_local_2[(_local_5 >> 5)] | ((_arg_1.charCodeAt((_local_5 / 8)) & _local_4) << (24 - (_local_5 % 32))));
                _local_5 = (_local_5 + 8);
            };
            _local_2[(_local_3 >> 5)] = (_local_2[(_local_3 >> 5)] | (128 << (24 - (_local_3 % 32))));
            _local_2[((((_local_3 + 64) >> 9) << 4) + 15)] = _local_3;
            return (_local_2);
        }

        public static function hashBytes(_arg_1:ByteArray):String
        {
            var _local_2:Array = SHA1.createBlocksFromByteArray(_arg_1);
            var _local_3:ByteArray = hashBlocks(_local_2);
            return ((((IntUtil.toHex(_local_3.readInt(), true) + IntUtil.toHex(_local_3.readInt(), true)) + IntUtil.toHex(_local_3.readInt(), true)) + IntUtil.toHex(_local_3.readInt(), true)) + IntUtil.toHex(_local_3.readInt(), true));
        }

        public static function hash(_arg_1:String):String
        {
            var _local_2:Array = createBlocksFromString(_arg_1);
            var _local_3:ByteArray = hashBlocks(_local_2);
            return ((((IntUtil.toHex(_local_3.readInt(), true) + IntUtil.toHex(_local_3.readInt(), true)) + IntUtil.toHex(_local_3.readInt(), true)) + IntUtil.toHex(_local_3.readInt(), true)) + IntUtil.toHex(_local_3.readInt(), true));
        }

        public static function hashToBase64(_arg_1:String):String
        {
            var _local_7:uint;
            var _local_2:Array = SHA1.createBlocksFromString(_arg_1);
            var _local_3:ByteArray = hashBlocks(_local_2);
            var _local_4:* = "";
            _local_3.position = 0;
            var _local_5:int;
            while (_local_5 < _local_3.length)
            {
                _local_7 = _local_3.readUnsignedByte();
                _local_4 = (_local_4 + String.fromCharCode(_local_7));
                _local_5++;
            };
            var _local_6:Base64Encoder = new Base64Encoder();
            _local_6.encode(_local_4);
            return (_local_6.flush());
        }


    }
}//package com.adobe.crypto

