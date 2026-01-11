// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.skype.SkypeUtils

package com.skype
{
    import flash.utils.Endian;
    import flash.utils.ByteArray;
    import autoevony.common.Utils;
    import com.skype.*;

    internal class SkypeUtils 
    {


        internal static function getMac256Hash(challenge:String):String
        {
            var int32ToHexString:Function = function (_arg_1:int):String
            {
                var _local_2:* = "0123456789abcdef";
                var _local_3:* = "";
                var _local_4:int;
                while (_local_4 < 4)
                {
                    _local_3 = (_local_3 + _local_2.charAt(((_arg_1 >> ((_local_4 * 8) + 4)) & 0x0F)));
                    _local_3 = (_local_3 + _local_2.charAt(((_arg_1 >> (_local_4 * 8)) & 0x0F)));
                    _local_4++;
                };
                return (_local_3);
            };
            var int64Xor:Function = function (_arg_1:Number, _arg_2:Number):Number
            {
                var _local_8:int;
                var _local_3:String = _arg_1.toString(2);
                var _local_4:String = _arg_2.toString(2);
                var _local_5:* = "";
                var _local_6:* = "";
                var _local_7:int = Math.abs((_local_3.length - _local_4.length));
                _local_8 = 0;
                while (_local_8 < _local_7)
                {
                    _local_6 = (_local_6 + "0");
                    _local_8++;
                };
                if (_local_3.length < _local_4.length)
                {
                    _local_6 = (_local_6 + _local_3);
                    _local_3 = _local_6;
                }
                else
                {
                    if (_local_4.length < _local_3.length)
                    {
                        _local_6 = (_local_6 + _local_4);
                        _local_4 = _local_6;
                    };
                };
                _local_8 = 0;
                while (_local_8 < _local_3.length)
                {
                    _local_5 = (_local_5 + ((_local_3.charAt(_local_8) == _local_4.charAt(_local_8)) ? "0" : "1"));
                    _local_8++;
                };
                return (parseInt(_local_5, 2));
            };
            var multiplymod:Function = function (_arg_1:uint, _arg_2:uint, _arg_3:uint):uint
            {
                var _local_4:uint = uint(int((_arg_1 / 0x10000)));
                var _local_5:uint = (_arg_1 % 0x10000);
                var _local_6:uint = uint(int((_arg_2 / 0x10000)));
                var _local_7:uint = (_arg_2 % 0x10000);
                return (((((((((_local_4 * _local_6) * 0x10000) % _arg_3) * 0x10000) % _arg_3) + ((_local_4 * 0x10000) * _local_7)) + ((_local_6 * 0x10000) * _local_5)) + (_local_5 * _local_7)) % _arg_3);
            };
            var cS64:Function = function (_arg_1:Array, _arg_2:Array):Array
            {
                var _local_3:uint = 2147483647;
                var _local_4:uint = (_arg_2[0] & _local_3);
                var _local_5:uint = (_arg_2[1] & _local_3);
                var _local_6:uint = (_arg_2[2] & _local_3);
                var _local_7:uint = (_arg_2[3] & _local_3);
                var _local_8:uint = 242854337;
                var _local_9:uint;
                var _local_10:uint;
                var _local_11:uint;
                var _local_12:uint;
                var _local_13:int;
                while (_local_13 < int((_arg_1.length / 2)))
                {
                    _local_10 = parseInt(_arg_1[_local_9]);
                    _local_9 = (_local_9 + 1);
                    _local_10 = multiplymod(_local_8, _local_10, _local_3);
                    _local_11 = (_local_11 + _local_10);
                    _local_11 = multiplymod(_local_4, _local_11, _local_3);
                    _local_11 = (_local_11 + _local_5);
                    _local_11 = (_local_11 % _local_3);
                    _local_12 = (_local_12 + _local_11);
                    _local_11 = (_local_11 + parseInt(_arg_1[_local_9]));
                    _local_9 = (_local_9 + 1);
                    _local_11 = multiplymod(_local_6, _local_11, _local_3);
                    _local_11 = (_local_11 + _local_7);
                    _local_11 = (_local_11 % _local_3);
                    _local_12 = (_local_12 + _local_11);
                    _local_13++;
                };
                _local_11 = (_local_11 + _local_5);
                _local_11 = (_local_11 % _local_3);
                _local_12 = (_local_12 + _local_7);
                _local_12 = (_local_12 % _local_3);
                return (new Array(_local_11, _local_12));
            };
            var hash:Function = function (_arg_1:ByteArray):ByteArray
            {
                var _local_5:int;
                var _local_2:int = _arg_1.length;
                var _local_3:String = _arg_1.endian;
                _arg_1.endian = Endian.BIG_ENDIAN;
                var _local_4:int = (_local_2 * 8);
                while ((_arg_1.length % 4) != 0)
                {
                    _arg_1[_arg_1.length] = 0;
                };
                _arg_1.position = 0;
                var _local_6:Array = new Array();
                _local_5 = 0;
                while (_local_5 < _arg_1.length)
                {
                    _local_6.push(_arg_1.readUnsignedInt());
                    _local_5 = (_local_5 + 4);
                };
                var _local_7:Array = core(_local_6, _local_4);
                var _local_8:ByteArray = new ByteArray();
                var _local_9:int = 8;
                _local_5 = 0;
                while (_local_5 < _local_9)
                {
                    _local_8.writeUnsignedInt(_local_7[_local_5]);
                    _local_5++;
                };
                _arg_1.length = _local_2;
                _arg_1.endian = _local_3;
                return (_local_8);
            };
            var core:Function = function (_arg_1:Array, _arg_2:int):Array
            {
                var _local_6:uint;
                var _local_7:uint;
                var _local_8:uint;
                var _local_9:uint;
                var _local_10:uint;
                var _local_11:uint;
                var _local_12:uint;
                var _local_13:uint;
                var _local_14:int;
                var _local_15:int;
                var _local_16:int;
                var _local_17:int;
                var _local_18:int;
                var _local_19:int;
                var _local_20:int;
                var _local_21:int;
                var _local_22:int;
                var _local_23:int;
                var _local_24:int;
                var _local_25:int;
                var _local_27:int;
                var _local_3:Array = [1116352408, 1899447441, 3049323471, 3921009573, 961987163, 1508970993, 2453635748, 2870763221, 3624381080, 310598401, 607225278, 1426881987, 1925078388, 2162078206, 2614888103, 3248222580, 3835390401, 4022224774, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, 2554220882, 2821834349, 2952996808, 3210313671, 3336571891, 3584528711, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, 2177026350, 2456956037, 2730485921, 2820302411, 3259730800, 3345764771, 3516065817, 3600352804, 4094571909, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, 2227730452, 2361852424, 2428436474, 2756734187, 3204031479, 3329325298];
                var _local_4:Array = new Array(1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225);
                _arg_1[(_arg_2 >> 5)] = (_arg_1[(_arg_2 >> 5)] | (128 << (24 - (_arg_2 % 32))));
                _arg_1[((((_arg_2 + 64) >> 9) << 4) + 15)] = _arg_2;
                var _local_5:Array = new Array();
                _local_6 = uint(_local_4[0]);
                _local_7 = uint(_local_4[1]);
                _local_8 = uint(_local_4[2]);
                _local_9 = uint(_local_4[3]);
                _local_10 = uint(_local_4[4]);
                _local_11 = uint(_local_4[5]);
                _local_12 = uint(_local_4[6]);
                _local_13 = uint(_local_4[7]);
                var _local_26:int;
                while (_local_26 < _arg_1.length)
                {
                    _local_14 = _local_6;
                    _local_15 = _local_7;
                    _local_16 = _local_8;
                    _local_17 = _local_9;
                    _local_18 = _local_10;
                    _local_19 = _local_11;
                    _local_20 = _local_12;
                    _local_21 = _local_13;
                    _local_27 = 0;
                    while (_local_27 < 64)
                    {
                        if (_local_27 < 16)
                        {
                            _local_5[_local_27] = (_arg_1[(_local_26 + _local_27)] | 0x00);
                        }
                        else
                        {
                            _local_22 = ((rrol(_local_5[(_local_27 - 15)], 7) ^ rrol(_local_5[(_local_27 - 15)], 18)) ^ (_local_5[(_local_27 - 15)] >>> 3));
                            _local_23 = ((rrol(_local_5[(_local_27 - 2)], 17) ^ rrol(_local_5[(_local_27 - 2)], 19)) ^ (_local_5[(_local_27 - 2)] >>> 10));
                            _local_5[_local_27] = (((_local_5[(_local_27 - 16)] + _local_22) + _local_5[(_local_27 - 7)]) + _local_23);
                        };
                        _local_24 = (((rrol(_local_6, 2) ^ rrol(_local_6, 13)) ^ rrol(_local_6, 22)) + (((_local_6 & _local_7) ^ (_local_6 & _local_8)) ^ (_local_7 & _local_8)));
                        _local_25 = ((((_local_13 + ((rrol(_local_10, 6) ^ rrol(_local_10, 11)) ^ rrol(_local_10, 25))) + ((_local_10 & _local_11) ^ (_local_12 & (~(_local_10))))) + _local_3[_local_27]) + _local_5[_local_27]);
                        _local_13 = uint(_local_12);
                        _local_12 = uint(_local_11);
                        _local_11 = uint(_local_10);
                        _local_10 = uint((_local_9 + _local_25));
                        _local_9 = uint(_local_8);
                        _local_8 = uint(_local_7);
                        _local_7 = uint(_local_6);
                        _local_6 = uint((_local_25 + _local_24));
                        _local_27++;
                    };
                    _local_6 = (_local_6 + _local_14);
                    _local_7 = (_local_7 + _local_15);
                    _local_8 = (_local_8 + _local_16);
                    _local_9 = (_local_9 + _local_17);
                    _local_10 = (_local_10 + _local_18);
                    _local_11 = (_local_11 + _local_19);
                    _local_12 = (_local_12 + _local_20);
                    _local_13 = (_local_13 + _local_21);
                    _local_26 = (_local_26 + 16);
                };
                return (new Array(_local_6, _local_7, _local_8, _local_9, _local_10, _local_11, _local_12, _local_13));
            };
            var rrol:Function = function (_arg_1:int, _arg_2:int):int
            {
                return ((_arg_1 << (32 - _arg_2)) | (_arg_1 >>> _arg_2));
            };
            var HexfromArray:Function = function (_arg_1:ByteArray):String
            {
                var _local_2:* = "";
                var _local_3:int;
                while (_local_3 < _arg_1.length)
                {
                    _local_2 = (_local_2 + ("0" + _arg_1[_local_3].toString(16)).substr(-2, 2));
                    _local_3++;
                };
                return (_local_2);
            };
            var HextoString:Function = function (_arg_1:String):String
            {
                var _local_2:ByteArray = HextoArray(_arg_1);
                return (_local_2.readUTFBytes(_local_2.length));
            };
            var HexfromString:Function = function (_arg_1:String):String
            {
                var _local_2:ByteArray = new ByteArray();
                _local_2.writeUTFBytes(_arg_1);
                return (HexfromArray(_local_2));
            };
            var HextoArray:Function = function (_arg_1:String):ByteArray
            {
                _arg_1 = _arg_1.replace(/\s|:/gm, "");
                var _local_2:ByteArray = new ByteArray();
                if ((_arg_1.length & 0x01) == 1)
                {
                    _arg_1 = ("0" + _arg_1);
                };
                var _local_3:int;
                while (_local_3 < _arg_1.length)
                {
                    _local_2[(_local_3 / 2)] = parseInt(_arg_1.substr(_local_3, 2), 16);
                    _local_3 = (_local_3 + 2);
                };
                return (_local_2);
            };
            var sha256hashfrombytearray:Function = function (_arg_1:ByteArray):String
            {
                var _local_2:String = HexfromArray(_arg_1);
                var _local_3:ByteArray = HextoArray(_local_2);
                var _local_4:ByteArray = hash(_local_3);
                var _local_5:String = HexfromArray(_local_4);
                return (_local_5);
            };
            var _getMac256Hash:Function = function (_arg_1:String):String
            {
                var _local_4:int;
                var _local_7:int;
                var _local_11:int;
                var _local_2:* = (_arg_1 + "msmsgs@msnmsgr.com");
                var _local_3:int = (8 - (_local_2.length % 8));
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_2 = (_local_2 + "0");
                    _local_4++;
                };
                var _local_5:int = int(int((_local_2.length / 4)));
                var _local_6:Array = new Array();
                _local_4 = 0;
                while (_local_4 < _local_5)
                {
                    _local_6.splice(_local_4, 0, 0);
                    _local_7 = 0;
                    while (_local_7 < 4)
                    {
                        _local_6[_local_4] = (_local_6[_local_4] + (_local_2.charCodeAt(((4 * _local_4) + _local_7)) * Math.pow(0x0100, _local_7)));
                        _local_7++;
                    };
                    _local_4++;
                };
                var _local_8:Array = new Array(0, 0, 0, 0);
                var _local_9:ByteArray = new ByteArray();
                _local_9.writeUTFBytes((_arg_1 + "Q1P7W2E4J9R8U3S5"));
                var _local_10:String = sha256hashfrombytearray(_local_9).toUpperCase();
                _local_4 = 0;
                while (_local_4 < _local_8.length)
                {
                    _local_8[_local_4] = 0;
                    _local_7 = 0;
                    while (_local_7 < 4)
                    {
                        _local_11 = ((8 * _local_4) + (_local_7 * 2));
                        _local_8[_local_4] = (_local_8[_local_4] + (parseInt(_local_10.substring(_local_11, (_local_11 + 2)), 16) * Math.pow(0x0100, _local_7)));
                        _local_7++;
                    };
                    _local_4++;
                };
                var _local_12:Array = cS64(_local_6, _local_8);
                var _local_13:Array = new Array(_local_12[0], _local_12[1], _local_12[0], _local_12[1]);
                var _local_14:Array = new Array(int64Xor(_local_8[0], _local_13[0]), int64Xor(_local_8[1], _local_13[1]), int64Xor(_local_8[2], _local_13[2]), int64Xor(_local_8[3], _local_13[3]));
                var _local_15:Array = new Array(int32ToHexString(_local_14[0]), int32ToHexString(_local_14[1]), int32ToHexString(_local_14[2]), int32ToHexString(_local_14[3]));
                return (_local_15.join(""));
            };
            return (_getMac256Hash(challenge));
        }

        internal static function getCookie(_arg_1:String, _arg_2:String):String
        {
            var _local_4:String;
            var _local_3:Array = _arg_2.split(";");
            for each (_local_4 in _local_3)
            {
                _local_4 = Utils.trim(_local_4);
                if (_local_4.indexOf((_arg_1 + "=")) == 0)
                {
                    return (_local_4.substr((_arg_1.length + 1)));
                };
            };
            return (null);
        }

        internal static function processText(_arg_1:String):String
        {
            var _local_4:int;
            var _local_2:String = _arg_1.replace(/\\n/g, "\n").replace(/\\r/g, "\r");
            var _local_3:int;
            var _local_5:* = "";
            while (true)
            {
                if (_local_3 >= _local_2.length)
                {
                    return (_local_5);
                };
                if (_local_2.charAt(_local_3) == "*")
                {
                    _local_4 = _local_2.indexOf("*", (_local_3 + 1));
                    if (_local_4 != -1)
                    {
                        _local_5 = (_local_5 + (('<b raw_pre="*" raw_post="*">' + processText(_local_2.substring((_local_3 + 1), _local_4))) + "</b>"));
                        _local_3 = (_local_4 + 1);
                        continue;
                    };
                };
                if (_local_2.charAt(_local_3) == "_")
                {
                    _local_4 = _local_2.indexOf("_", (_local_3 + 1));
                    if (_local_4 != -1)
                    {
                        _local_5 = (_local_5 + (('<i raw_pre="_" raw_post="_">' + processText(_local_2.substring((_local_3 + 1), _local_4))) + "</i>"));
                        _local_3 = (_local_4 + 1);
                        continue;
                    };
                };
                if (_local_2.charAt(_local_3) == "~")
                {
                    _local_4 = _local_2.indexOf("~", (_local_3 + 1));
                    if (_local_4 != -1)
                    {
                        _local_5 = (_local_5 + (('<s raw_pre="~" raw_post="~">' + processText(_local_2.substring((_local_3 + 1), _local_4))) + "</s>"));
                        _local_3 = (_local_4 + 1);
                        continue;
                    };
                };
                _local_5 = (_local_5 + _local_2.charAt(_local_3));
                _local_3 = (_local_3 + 1);
            };
            return (null); //dead code
        }

        internal static function logMsg(_arg_1:String):void
        {
            trace(_arg_1);
        }

        internal static function logErrMsg(_arg_1:String):void
        {
            trace(_arg_1);
        }


    }
}//package com.skype

