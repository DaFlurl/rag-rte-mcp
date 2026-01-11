// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.codec.JPEGEncoder

package mx.graphics.codec
{
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class JPEGEncoder implements IImageEncoder 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static const CONTENT_TYPE:String = "image/jpeg";

        private var YDC_HT:Array;
        private var YAC_HT:Array;
        private var bytenew:int = 0;
        private var byteout:ByteArray;
        private var UVAC_HT:Array;
        private var UVDC_HT:Array;
        private var bytepos:int = 7;

        private const std_dc_luminance_nrcodes:Array = [0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0];
        private const std_dc_luminance_values:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
        private const std_dc_chrominance_nrcodes:Array = [0, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0];
        private const std_dc_chrominance_values:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
        private const std_ac_luminance_nrcodes:Array = [0, 0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 125];
        private const std_ac_luminance_values:Array = [1, 2, 3, 0, 4, 17, 5, 18, 33, 49, 65, 6, 19, 81, 97, 7, 34, 113, 20, 50, 129, 145, 161, 8, 35, 66, 177, 193, 21, 82, 209, 240, 36, 51, 98, 114, 130, 9, 10, 22, 23, 24, 25, 26, 37, 38, 39, 40, 41, 42, 52, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250];
        private const std_ac_chrominance_nrcodes:Array = [0, 0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 119];
        private const std_ac_chrominance_values:Array = [0, 1, 2, 3, 17, 4, 5, 33, 49, 6, 18, 65, 81, 7, 97, 113, 19, 34, 50, 129, 8, 20, 66, 145, 161, 177, 193, 9, 35, 51, 82, 240, 21, 98, 114, 209, 10, 22, 36, 52, 225, 37, 241, 23, 24, 25, 26, 38, 39, 40, 41, 42, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 130, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 226, 227, 228, 229, 230, 231, 232, 233, 234, 242, 243, 244, 245, 246, 247, 248, 249, 250];
        private const ZigZag:Array = [0, 1, 5, 6, 14, 15, 27, 28, 2, 4, 7, 13, 16, 26, 29, 42, 3, 8, 12, 17, 25, 30, 41, 43, 9, 11, 18, 24, 31, 40, 44, 53, 10, 19, 23, 32, 39, 45, 52, 54, 20, 22, 33, 38, 46, 51, 55, 60, 21, 34, 37, 47, 50, 56, 59, 61, 35, 36, 48, 49, 57, 58, 62, 63];
        private var category:Array = new Array(0xFFFF);
        private var bitcode:Array = new Array(0xFFFF);
        private var YTable:Array = new Array(64);
        private var UVTable:Array = new Array(64);
        private var fdtbl_Y:Array = new Array(64);
        private var fdtbl_UV:Array = new Array(64);
        private var DU:Array = new Array(64);
        private var YDU:Array = new Array(64);
        private var UDU:Array = new Array(64);
        private var VDU:Array = new Array(64);

        public function JPEGEncoder(_arg_1:Number=50)
        {
            if (_arg_1 <= 0)
            {
                _arg_1 = 1;
            };
            if (_arg_1 > 100)
            {
                _arg_1 = 100;
            };
            var _local_2:int;
            if (_arg_1 < 50)
            {
                _local_2 = int(int((5000 / _arg_1)));
            }
            else
            {
                _local_2 = int((200 - (_arg_1 * 2)));
            };
            initHuffmanTbl();
            initCategoryNumber();
            initQuantTables(_local_2);
        }

        private function initHuffmanTbl():void
        {
            YDC_HT = computeHuffmanTbl(std_dc_luminance_nrcodes, std_dc_luminance_values);
            UVDC_HT = computeHuffmanTbl(std_dc_chrominance_nrcodes, std_dc_chrominance_values);
            YAC_HT = computeHuffmanTbl(std_ac_luminance_nrcodes, std_ac_luminance_values);
            UVAC_HT = computeHuffmanTbl(std_ac_chrominance_nrcodes, std_ac_chrominance_values);
        }

        private function RGB2YUV(_arg_1:BitmapData, _arg_2:ByteArray, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):void
        {
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:uint;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_7:int;
            var _local_8:int;
            while (_local_8 < 8)
            {
                _local_9 = (_arg_4 + _local_8);
                if (_local_9 >= _arg_6)
                {
                    _local_9 = (_arg_6 - 1);
                };
                _local_10 = 0;
                while (_local_10 < 8)
                {
                    _local_11 = (_arg_3 + _local_10);
                    if (_local_11 >= _arg_5)
                    {
                        _local_11 = (_arg_5 - 1);
                    };
                    if (_arg_1)
                    {
                        _local_12 = _arg_1.getPixel32(_local_11, _local_9);
                    }
                    else
                    {
                        _arg_2.position = (4 * ((_local_9 * _arg_5) + _local_11));
                        _local_12 = _arg_2.readUnsignedInt();
                    };
                    _local_13 = Number(((_local_12 >> 16) & 0xFF));
                    _local_14 = Number(((_local_12 >> 8) & 0xFF));
                    _local_15 = Number((_local_12 & 0xFF));
                    YDU[_local_7] = ((((0.299 * _local_13) + (0.587 * _local_14)) + (0.114 * _local_15)) - 128);
                    UDU[_local_7] = (((-0.16874 * _local_13) - (0.33126 * _local_14)) + (0.5 * _local_15));
                    VDU[_local_7] = (((0.5 * _local_13) - (0.41869 * _local_14)) - (0.08131 * _local_15));
                    _local_7++;
                    _local_10++;
                };
                _local_8++;
            };
        }

        private function writeWord(_arg_1:int):void
        {
            writeByte(((_arg_1 >> 8) & 0xFF));
            writeByte((_arg_1 & 0xFF));
        }

        private function writeByte(_arg_1:int):void
        {
            byteout.writeByte(_arg_1);
        }

        private function writeBits(_arg_1:BitString):void
        {
            var _local_2:int = _arg_1.val;
            var _local_3:int = (_arg_1.len - 1);
            while (_local_3 >= 0)
            {
                if ((_local_2 & uint((1 << _local_3))))
                {
                    bytenew = (bytenew | uint((1 << bytepos)));
                };
                _local_3--;
                bytepos--;
                if (bytepos < 0)
                {
                    if (bytenew == 0xFF)
                    {
                        writeByte(0xFF);
                        writeByte(0);
                    }
                    else
                    {
                        writeByte(bytenew);
                    };
                    bytepos = 7;
                    bytenew = 0;
                };
            };
        }

        public function encode(_arg_1:BitmapData):ByteArray
        {
            return (internalEncode(_arg_1, _arg_1.width, _arg_1.height, _arg_1.transparent));
        }

        private function initCategoryNumber():void
        {
            var _local_1:int;
            var _local_2:int = 1;
            var _local_3:int = 2;
            var _local_4:int = 1;
            while (_local_4 <= 15)
            {
                _local_1 = _local_2;
                while (_local_1 < _local_3)
                {
                    category[(32767 + _local_1)] = _local_4;
                    bitcode[(32767 + _local_1)] = new BitString();
                    bitcode[(32767 + _local_1)].len = _local_4;
                    bitcode[(32767 + _local_1)].val = _local_1;
                    _local_1++;
                };
                _local_1 = -(_local_3 - 1);
                while (_local_1 <= -(_local_2))
                {
                    category[(32767 + _local_1)] = _local_4;
                    bitcode[(32767 + _local_1)] = new BitString();
                    bitcode[(32767 + _local_1)].len = _local_4;
                    bitcode[(32767 + _local_1)].val = ((_local_3 - 1) + _local_1);
                    _local_1++;
                };
                _local_2 = (_local_2 << 1);
                _local_3 = (_local_3 << 1);
                _local_4++;
            };
        }

        private function writeDQT():void
        {
            var _local_1:int;
            writeWord(65499);
            writeWord(132);
            writeByte(0);
            _local_1 = 0;
            while (_local_1 < 64)
            {
                writeByte(YTable[_local_1]);
                _local_1++;
            };
            writeByte(1);
            _local_1 = 0;
            while (_local_1 < 64)
            {
                writeByte(UVTable[_local_1]);
                _local_1++;
            };
        }

        private function writeDHT():void
        {
            var _local_1:int;
            writeWord(65476);
            writeWord(418);
            writeByte(0);
            _local_1 = 0;
            while (_local_1 < 16)
            {
                writeByte(std_dc_luminance_nrcodes[(_local_1 + 1)]);
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 <= 11)
            {
                writeByte(std_dc_luminance_values[_local_1]);
                _local_1++;
            };
            writeByte(16);
            _local_1 = 0;
            while (_local_1 < 16)
            {
                writeByte(std_ac_luminance_nrcodes[(_local_1 + 1)]);
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 <= 161)
            {
                writeByte(std_ac_luminance_values[_local_1]);
                _local_1++;
            };
            writeByte(1);
            _local_1 = 0;
            while (_local_1 < 16)
            {
                writeByte(std_dc_chrominance_nrcodes[(_local_1 + 1)]);
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 <= 11)
            {
                writeByte(std_dc_chrominance_values[_local_1]);
                _local_1++;
            };
            writeByte(17);
            _local_1 = 0;
            while (_local_1 < 16)
            {
                writeByte(std_ac_chrominance_nrcodes[(_local_1 + 1)]);
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 <= 161)
            {
                writeByte(std_ac_chrominance_values[_local_1]);
                _local_1++;
            };
        }

        private function writeAPP0():void
        {
            writeWord(65504);
            writeWord(16);
            writeByte(74);
            writeByte(70);
            writeByte(73);
            writeByte(70);
            writeByte(0);
            writeByte(1);
            writeByte(1);
            writeByte(0);
            writeWord(1);
            writeWord(1);
            writeByte(0);
            writeByte(0);
        }

        private function writeSOS():void
        {
            writeWord(65498);
            writeWord(12);
            writeByte(3);
            writeByte(1);
            writeByte(0);
            writeByte(2);
            writeByte(17);
            writeByte(3);
            writeByte(17);
            writeByte(0);
            writeByte(63);
            writeByte(0);
        }

        private function internalEncode(_arg_1:Object, _arg_2:int, _arg_3:int, _arg_4:Boolean=true):ByteArray
        {
            var _local_11:int;
            var _local_12:BitString;
            var _local_5:BitmapData = (_arg_1 as BitmapData);
            var _local_6:ByteArray = (_arg_1 as ByteArray);
            byteout = new ByteArray();
            bytenew = 0;
            bytepos = 7;
            writeWord(65496);
            writeAPP0();
            writeDQT();
            writeSOF0(_arg_2, _arg_3);
            writeDHT();
            writeSOS();
            var _local_7:Number = 0;
            var _local_8:Number = 0;
            var _local_9:Number = 0;
            bytenew = 0;
            bytepos = 7;
            var _local_10:int;
            while (_local_10 < _arg_3)
            {
                _local_11 = 0;
                while (_local_11 < _arg_2)
                {
                    RGB2YUV(_local_5, _local_6, _local_11, _local_10, _arg_2, _arg_3);
                    _local_7 = processDU(YDU, fdtbl_Y, _local_7, YDC_HT, YAC_HT);
                    _local_8 = processDU(UDU, fdtbl_UV, _local_8, UVDC_HT, UVAC_HT);
                    _local_9 = processDU(VDU, fdtbl_UV, _local_9, UVDC_HT, UVAC_HT);
                    _local_11 = (_local_11 + 8);
                };
                _local_10 = (_local_10 + 8);
            };
            if (bytepos >= 0)
            {
                _local_12 = new BitString();
                _local_12.len = (bytepos + 1);
                _local_12.val = ((1 << (bytepos + 1)) - 1);
                writeBits(_local_12);
            };
            writeWord(65497);
            return (byteout);
        }

        private function processDU(_arg_1:Array, _arg_2:Array, _arg_3:Number, _arg_4:Array, _arg_5:Array):Number
        {
            var _local_8:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_6:BitString = _arg_5[0];
            var _local_7:BitString = _arg_5[240];
            var _local_9:Array = fDCTQuant(_arg_1, _arg_2);
            _local_8 = 0;
            while (_local_8 < 64)
            {
                DU[ZigZag[_local_8]] = _local_9[_local_8];
                _local_8++;
            };
            var _local_10:int = (DU[0] - _arg_3);
            _arg_3 = DU[0];
            if (_local_10 == 0)
            {
                writeBits(_arg_4[0]);
            }
            else
            {
                writeBits(_arg_4[category[(32767 + _local_10)]]);
                writeBits(bitcode[(32767 + _local_10)]);
            };
            var _local_11:int = 63;
            while (((_local_11 > 0) && (DU[_local_11] == 0)))
            {
                _local_11--;
            };
            if (_local_11 == 0)
            {
                writeBits(_local_6);
                return (_arg_3);
            };
            _local_8 = 1;
            while (_local_8 <= _local_11)
            {
                _local_12 = _local_8;
                while (((DU[_local_8] == 0) && (_local_8 <= _local_11)))
                {
                    _local_8++;
                };
                _local_13 = (_local_8 - _local_12);
                if (_local_13 >= 16)
                {
                    _local_14 = 1;
                    while (_local_14 <= (_local_13 / 16))
                    {
                        writeBits(_local_7);
                        _local_14++;
                    };
                    _local_13 = int((_local_13 & 0x0F));
                };
                writeBits(_arg_5[((_local_13 * 16) + category[(32767 + DU[_local_8])])]);
                writeBits(bitcode[(32767 + DU[_local_8])]);
                _local_8++;
            };
            if (_local_11 != 63)
            {
                writeBits(_local_6);
            };
            return (_arg_3);
        }

        public function encodeByteArray(_arg_1:ByteArray, _arg_2:int, _arg_3:int, _arg_4:Boolean=true):ByteArray
        {
            return (internalEncode(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        private function initQuantTables(_arg_1:int):void
        {
            var _local_3:Number;
            var _local_8:int;
            var _local_2:int;
            var _local_4:Array = [16, 11, 10, 16, 24, 40, 51, 61, 12, 12, 14, 19, 26, 58, 60, 55, 14, 13, 16, 24, 40, 57, 69, 56, 14, 17, 22, 29, 51, 87, 80, 62, 18, 22, 37, 56, 68, 109, 103, 77, 24, 35, 55, 64, 81, 104, 113, 92, 49, 64, 78, 87, 103, 121, 120, 101, 72, 92, 95, 98, 112, 100, 103, 99];
            _local_2 = 0;
            while (_local_2 < 64)
            {
                _local_3 = Math.floor((((_local_4[_local_2] * _arg_1) + 50) / 100));
                if (_local_3 < 1)
                {
                    _local_3 = 1;
                }
                else
                {
                    if (_local_3 > 0xFF)
                    {
                        _local_3 = 0xFF;
                    };
                };
                YTable[ZigZag[_local_2]] = _local_3;
                _local_2++;
            };
            var _local_5:Array = [17, 18, 24, 47, 99, 99, 99, 99, 18, 21, 26, 66, 99, 99, 99, 99, 24, 26, 56, 99, 99, 99, 99, 99, 47, 66, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99];
            _local_2 = 0;
            while (_local_2 < 64)
            {
                _local_3 = Math.floor((((_local_5[_local_2] * _arg_1) + 50) / 100));
                if (_local_3 < 1)
                {
                    _local_3 = 1;
                }
                else
                {
                    if (_local_3 > 0xFF)
                    {
                        _local_3 = 0xFF;
                    };
                };
                UVTable[ZigZag[_local_2]] = _local_3;
                _local_2++;
            };
            var _local_6:Array = [1, 1.387039845, 1.306562965, 1.175875602, 1, 0.785694958, 0.5411961, 0.275899379];
            _local_2 = 0;
            var _local_7:int;
            while (_local_7 < 8)
            {
                _local_8 = 0;
                while (_local_8 < 8)
                {
                    fdtbl_Y[_local_2] = (1 / (((YTable[ZigZag[_local_2]] * _local_6[_local_7]) * _local_6[_local_8]) * 8));
                    fdtbl_UV[_local_2] = (1 / (((UVTable[ZigZag[_local_2]] * _local_6[_local_7]) * _local_6[_local_8]) * 8));
                    _local_2++;
                    _local_8++;
                };
                _local_7++;
            };
        }

        public function get contentType():String
        {
            return (CONTENT_TYPE);
        }

        private function writeSOF0(_arg_1:int, _arg_2:int):void
        {
            writeWord(65472);
            writeWord(17);
            writeByte(8);
            writeWord(_arg_2);
            writeWord(_arg_1);
            writeByte(3);
            writeByte(1);
            writeByte(17);
            writeByte(0);
            writeByte(2);
            writeByte(17);
            writeByte(1);
            writeByte(3);
            writeByte(17);
            writeByte(1);
        }

        private function computeHuffmanTbl(_arg_1:Array, _arg_2:Array):Array
        {
            var _local_7:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Array = [];
            var _local_6:int = 1;
            while (_local_6 <= 16)
            {
                _local_7 = 1;
                while (_local_7 <= _arg_1[_local_6])
                {
                    _local_5[_arg_2[_local_4]] = new BitString();
                    _local_5[_arg_2[_local_4]].val = _local_3;
                    _local_5[_arg_2[_local_4]].len = _local_6;
                    _local_4++;
                    _local_3++;
                    _local_7++;
                };
                _local_3 = (_local_3 * 2);
                _local_6++;
            };
            return (_local_5);
        }

        private function fDCTQuant(_arg_1:Array, _arg_2:Array):Array
        {
            var _local_4:int;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:Number;
            var _local_3:int;
            _local_4 = 0;
            while (_local_4 < 8)
            {
                _local_5 = (_arg_1[(_local_3 + 0)] + _arg_1[(_local_3 + 7)]);
                _local_6 = (_arg_1[(_local_3 + 0)] - _arg_1[(_local_3 + 7)]);
                _local_7 = (_arg_1[(_local_3 + 1)] + _arg_1[(_local_3 + 6)]);
                _local_8 = (_arg_1[(_local_3 + 1)] - _arg_1[(_local_3 + 6)]);
                _local_9 = (_arg_1[(_local_3 + 2)] + _arg_1[(_local_3 + 5)]);
                _local_10 = (_arg_1[(_local_3 + 2)] - _arg_1[(_local_3 + 5)]);
                _local_11 = (_arg_1[(_local_3 + 3)] + _arg_1[(_local_3 + 4)]);
                _local_12 = (_arg_1[(_local_3 + 3)] - _arg_1[(_local_3 + 4)]);
                _local_13 = (_local_5 + _local_11);
                _local_14 = (_local_5 - _local_11);
                _local_15 = (_local_7 + _local_9);
                _local_16 = (_local_7 - _local_9);
                _arg_1[(_local_3 + 0)] = (_local_13 + _local_15);
                _arg_1[(_local_3 + 4)] = (_local_13 - _local_15);
                _local_17 = ((_local_16 + _local_14) * 0.707106781);
                _arg_1[(_local_3 + 2)] = (_local_14 + _local_17);
                _arg_1[(_local_3 + 6)] = (_local_14 - _local_17);
                _local_13 = (_local_12 + _local_10);
                _local_15 = (_local_10 + _local_8);
                _local_16 = (_local_8 + _local_6);
                _local_18 = ((_local_13 - _local_16) * 0.382683433);
                _local_19 = ((0.5411961 * _local_13) + _local_18);
                _local_20 = ((1.306562965 * _local_16) + _local_18);
                _local_21 = (_local_15 * 0.707106781);
                _local_22 = (_local_6 + _local_21);
                _local_23 = (_local_6 - _local_21);
                _arg_1[(_local_3 + 5)] = (_local_23 + _local_19);
                _arg_1[(_local_3 + 3)] = (_local_23 - _local_19);
                _arg_1[(_local_3 + 1)] = (_local_22 + _local_20);
                _arg_1[(_local_3 + 7)] = (_local_22 - _local_20);
                _local_3 = (_local_3 + 8);
                _local_4++;
            };
            _local_3 = 0;
            _local_4 = 0;
            while (_local_4 < 8)
            {
                _local_5 = (_arg_1[(_local_3 + 0)] + _arg_1[(_local_3 + 56)]);
                _local_6 = (_arg_1[(_local_3 + 0)] - _arg_1[(_local_3 + 56)]);
                _local_7 = (_arg_1[(_local_3 + 8)] + _arg_1[(_local_3 + 48)]);
                _local_8 = (_arg_1[(_local_3 + 8)] - _arg_1[(_local_3 + 48)]);
                _local_9 = (_arg_1[(_local_3 + 16)] + _arg_1[(_local_3 + 40)]);
                _local_10 = (_arg_1[(_local_3 + 16)] - _arg_1[(_local_3 + 40)]);
                _local_11 = (_arg_1[(_local_3 + 24)] + _arg_1[(_local_3 + 32)]);
                _local_12 = (_arg_1[(_local_3 + 24)] - _arg_1[(_local_3 + 32)]);
                _local_13 = (_local_5 + _local_11);
                _local_14 = (_local_5 - _local_11);
                _local_15 = (_local_7 + _local_9);
                _local_16 = (_local_7 - _local_9);
                _arg_1[(_local_3 + 0)] = (_local_13 + _local_15);
                _arg_1[(_local_3 + 32)] = (_local_13 - _local_15);
                _local_17 = ((_local_16 + _local_14) * 0.707106781);
                _arg_1[(_local_3 + 16)] = (_local_14 + _local_17);
                _arg_1[(_local_3 + 48)] = (_local_14 - _local_17);
                _local_13 = (_local_12 + _local_10);
                _local_15 = (_local_10 + _local_8);
                _local_16 = (_local_8 + _local_6);
                _local_18 = ((_local_13 - _local_16) * 0.382683433);
                _local_19 = ((0.5411961 * _local_13) + _local_18);
                _local_20 = ((1.306562965 * _local_16) + _local_18);
                _local_21 = (_local_15 * 0.707106781);
                _local_22 = (_local_6 + _local_21);
                _local_23 = (_local_6 - _local_21);
                _arg_1[(_local_3 + 40)] = (_local_23 + _local_19);
                _arg_1[(_local_3 + 24)] = (_local_23 - _local_19);
                _arg_1[(_local_3 + 8)] = (_local_22 + _local_20);
                _arg_1[(_local_3 + 56)] = (_local_22 - _local_20);
                _local_3++;
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < 64)
            {
                _arg_1[_local_4] = Math.round((_arg_1[_local_4] * _arg_2[_local_4]));
                _local_4++;
            };
            return (_arg_1);
        }


    }
}//package mx.graphics.codec

class BitString 
{

    public var val:int = 0;
    public var len:int = 0;


}


