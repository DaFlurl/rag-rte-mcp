// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.ColorUtil

package mx.utils
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ColorUtil 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        public static function adjustBrightness2(_arg_1:uint, _arg_2:Number):uint
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            if (_arg_2 == 0)
            {
                return (_arg_1);
            };
            if (_arg_2 < 0)
            {
                _arg_2 = ((100 + _arg_2) / 100);
                _local_3 = (((_arg_1 >> 16) & 0xFF) * _arg_2);
                _local_4 = (((_arg_1 >> 8) & 0xFF) * _arg_2);
                _local_5 = ((_arg_1 & 0xFF) * _arg_2);
            }
            else
            {
                _arg_2 = (_arg_2 / 100);
                _local_3 = ((_arg_1 >> 16) & 0xFF);
                _local_4 = ((_arg_1 >> 8) & 0xFF);
                _local_5 = (_arg_1 & 0xFF);
                _local_3 = (_local_3 + ((0xFF - _local_3) * _arg_2));
                _local_4 = (_local_4 + ((0xFF - _local_4) * _arg_2));
                _local_5 = (_local_5 + ((0xFF - _local_5) * _arg_2));
                _local_3 = Math.min(_local_3, 0xFF);
                _local_4 = Math.min(_local_4, 0xFF);
                _local_5 = Math.min(_local_5, 0xFF);
            };
            return (((_local_3 << 16) | (_local_4 << 8)) | _local_5);
        }

        public static function rgbMultiply(_arg_1:uint, _arg_2:uint):uint
        {
            var _local_3:Number = ((_arg_1 >> 16) & 0xFF);
            var _local_4:Number = ((_arg_1 >> 8) & 0xFF);
            var _local_5:Number = (_arg_1 & 0xFF);
            var _local_6:Number = ((_arg_2 >> 16) & 0xFF);
            var _local_7:Number = ((_arg_2 >> 8) & 0xFF);
            var _local_8:Number = (_arg_2 & 0xFF);
            return (((((_local_3 * _local_6) / 0xFF) << 16) | (((_local_4 * _local_7) / 0xFF) << 8)) | ((_local_5 * _local_8) / 0xFF));
        }

        public static function adjustBrightness(_arg_1:uint, _arg_2:Number):uint
        {
            var _local_3:Number = Math.max(Math.min((((_arg_1 >> 16) & 0xFF) + _arg_2), 0xFF), 0);
            var _local_4:Number = Math.max(Math.min((((_arg_1 >> 8) & 0xFF) + _arg_2), 0xFF), 0);
            var _local_5:Number = Math.max(Math.min(((_arg_1 & 0xFF) + _arg_2), 0xFF), 0);
            return (((_local_3 << 16) | (_local_4 << 8)) | _local_5);
        }


    }
}//package mx.utils

