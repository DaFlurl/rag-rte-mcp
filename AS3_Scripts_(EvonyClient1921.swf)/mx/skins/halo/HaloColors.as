// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.HaloColors

package mx.skins.halo
{
    import mx.utils.ColorUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HaloColors 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var cache:Object = {};


        public static function getCacheKey(... _args):String
        {
            return (_args.join(","));
        }

        public static function addHaloColors(_arg_1:Object, _arg_2:uint, _arg_3:uint, _arg_4:uint):void
        {
            var _local_5:String = getCacheKey(_arg_2, _arg_3, _arg_4);
            var _local_6:Object = cache[_local_5];
            if (!_local_6)
            {
                _local_6 = (cache[_local_5] = {});
                _local_6.themeColLgt = ColorUtil.adjustBrightness(_arg_2, 100);
                _local_6.themeColDrk1 = ColorUtil.adjustBrightness(_arg_2, -75);
                _local_6.themeColDrk2 = ColorUtil.adjustBrightness(_arg_2, -25);
                _local_6.fillColorBright1 = ColorUtil.adjustBrightness2(_arg_3, 15);
                _local_6.fillColorBright2 = ColorUtil.adjustBrightness2(_arg_4, 15);
                _local_6.fillColorPress1 = ColorUtil.adjustBrightness2(_arg_2, 85);
                _local_6.fillColorPress2 = ColorUtil.adjustBrightness2(_arg_2, 60);
                _local_6.bevelHighlight1 = ColorUtil.adjustBrightness2(_arg_3, 40);
                _local_6.bevelHighlight2 = ColorUtil.adjustBrightness2(_arg_4, 40);
            };
            _arg_1.themeColLgt = _local_6.themeColLgt;
            _arg_1.themeColDrk1 = _local_6.themeColDrk1;
            _arg_1.themeColDrk2 = _local_6.themeColDrk2;
            _arg_1.fillColorBright1 = _local_6.fillColorBright1;
            _arg_1.fillColorBright2 = _local_6.fillColorBright2;
            _arg_1.fillColorPress1 = _local_6.fillColorPress1;
            _arg_1.fillColorPress2 = _local_6.fillColorPress2;
            _arg_1.bevelHighlight1 = _local_6.bevelHighlight1;
            _arg_1.bevelHighlight2 = _local_6.bevelHighlight2;
        }


    }
}//package mx.skins.halo

