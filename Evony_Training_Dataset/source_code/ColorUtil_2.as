// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.utils.ColorUtil

package com.degrafa.core.utils
{
    import com.degrafa.paint.palette.PaletteEntry;

    public class ColorUtil 
    {


        private static function resolveColorFromString(_arg_1:String, _arg_2:uint=0):uint
        {
            if (_arg_1.search(",") == 3)
            {
                if (_arg_1.search("%") != -1)
                {
                    return (resolveColorFromRGBPercent((_arg_1 as String)));
                };
                return (resolveColorFromRGB((_arg_1 as String)));
            };
            if (_arg_1.search(",") == 4)
            {
                return (resolveColorFromCMYK((_arg_1 as String)));
            };
            var _local_3:uint;
            if (((String(_arg_1).charAt(0) == "#") || (String(_arg_1).substr(0, 2) == "0x")))
            {
                _arg_1 = _arg_1.replace("#", "");
                if (_arg_1.length == 3)
                {
                    _local_3 = parseColorNotation(_arg_1);
                }
                else
                {
                    _local_3 = parseInt(_arg_1, 16);
                };
            }
            else
            {
                _local_3 = parseInt(String(_arg_1), 10);
            };
            if (((isNaN(_local_3)) || (_local_3 == 0)))
            {
                _local_3 = resolveColorFromKey((_arg_1 as String), _arg_2);
            };
            return (_local_3);
        }

        public static function hexToRgb(_arg_1:Number):Object
        {
            var _local_2:Number = (_arg_1 >> 16);
            var _local_3:Number = (_arg_1 - (_local_2 << 16));
            var _local_4:Number = (_local_3 >> 8);
            var _local_5:Number = (_local_3 - (_local_4 << 8));
            return ({
                "red":_local_2,
                "green":_local_4,
                "blue":_local_5
            });
        }

        public static function resolveColor(_arg_1:Object, _arg_2:uint=0):uint
        {
            if ((_arg_1 is uint))
            {
                if (_arg_1.toString(16).length == 3)
                {
                    return (parseColorNotation(_arg_1.toString(16)));
                };
                return (_arg_1 as uint);
            };
            if ((_arg_1 is String))
            {
                return (resolveColorFromString((_arg_1 as String), _arg_2));
            };
            if ((_arg_1 is PaletteEntry))
            {
                return (resolveColor(PaletteEntry(_arg_1).value, _arg_2));
            };
            return (0);
        }

        public static function resolveColorFromRGBPercent(_arg_1:String):uint
        {
            var _local_2:Array = _arg_1.replace(/%/g, "").split(",");
            return (uint((((int(Math.round(((_local_2[0] / 100) * 0xFF))) << 16) | (int(Math.round(((_local_2[1] / 100) * 0xFF))) << 8)) | int(Math.round(((_local_2[2] / 100) * 0xFF))))));
        }

        public static function parseColorNotation(_arg_1:String):uint
        {
            _arg_1 = _arg_1.replace("#", "");
            _arg_1 = (((((("0x" + _arg_1.charAt(0)) + _arg_1.charAt(0)) + _arg_1.charAt(1)) + _arg_1.charAt(1)) + _arg_1.charAt(2)) + _arg_1.charAt(2));
            return (uint(_arg_1));
        }

        public static function resolveColorFromRGB(_arg_1:String):Number
        {
            var _local_2:Array = _arg_1.split(",");
            return (uint((((int(_local_2[0]) << 16) | (int(_local_2[1]) << 8)) | int(_local_2[2]))));
        }

        public static function resolveColorFromCMYK(_arg_1:String):uint
        {
            var _local_2:Array = _arg_1.split(",");
            var _local_3:int = int(((0xFF * _local_2[0]) / 100));
            var _local_4:int = int(((0xFF * _local_2[1]) / 100));
            var _local_5:int = int(((0xFF * _local_2[2]) / 100));
            var _local_6:int = int(((0xFF * _local_2[3]) / 100));
            var _local_7:int = int(int(decColorToHex(Math.round((((0xFF - _local_3) * (0xFF - _local_6)) / 0xFF)))));
            var _local_8:int = int(int(decColorToHex(Math.round((((0xFF - _local_4) * (0xFF - _local_6)) / 0xFF)))));
            var _local_9:int = int(int(decColorToHex(Math.round((((0xFF - _local_5) * (0xFF - _local_6)) / 0xFF)))));
            return (resolveColorFromRGB(((((_local_7 + ",") + _local_8) + ",") + _local_9)));
        }

        public static function resolveColorFromKey(_arg_1:String, _arg_2:uint=0):uint
        {
            var _local_3:String = _arg_1.toUpperCase();
            if (ColorKeys[_local_3] != null)
            {
                return (uint(ColorKeys[_local_3]));
            };
            return (_arg_2);
        }

        public static function decColorToHex(_arg_1:uint, _arg_2:String="0x"):String
        {
            var _local_3:String = ("00000" + _arg_1.toString(16).toUpperCase()).substr(-6);
            return (_arg_2 + _local_3);
        }


    }
}//package com.degrafa.core.utils

