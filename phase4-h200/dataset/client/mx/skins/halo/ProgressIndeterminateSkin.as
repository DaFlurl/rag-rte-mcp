// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ProgressIndeterminateSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.styles.StyleManager;
    import mx.utils.ColorUtil;
    import flash.display.Graphics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ProgressIndeterminateSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        override public function get measuredWidth():Number
        {
            return (195);
        }

        override public function get measuredHeight():Number
        {
            return (6);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:* = getStyle("barColor");
            var _local_4:uint = ((StyleManager.isValidStyleValue(_local_3)) ? _local_3 : getStyle("themeColor"));
            var _local_5:Number = ColorUtil.adjustBrightness2(_local_4, 60);
            var _local_6:Number = getStyle("indeterminateMoveInterval");
            if (((isNaN(_local_6)) || (_local_6 == 0)))
            {
                _local_6 = 28;
            };
            var _local_7:Graphics = graphics;
            _local_7.clear();
            var _local_8:int;
            while (_local_8 < _arg_1)
            {
                _local_7.beginFill(_local_5, 0.8);
                _local_7.moveTo(_local_8, 1);
                _local_7.lineTo(Math.min((_local_8 + 14), _arg_1), 1);
                _local_7.lineTo(Math.min((_local_8 + 10), _arg_1), (_arg_2 - 1));
                _local_7.lineTo(Math.max((_local_8 - 4), 0), (_arg_2 - 1));
                _local_7.lineTo(_local_8, 1);
                _local_7.endFill();
                _local_8 = (_local_8 + _local_6);
            };
        }


    }
}//package mx.skins.halo

