// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ScrollTrackSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.styles.StyleManager;
    import mx.utils.ColorUtil;
    import mx.core.FlexVersion;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ScrollTrackSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        override public function get measuredWidth():Number
        {
            return (16);
        }

        override public function get measuredHeight():Number
        {
            return (1);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Array = getStyle("trackColors");
            StyleManager.getColorNames(_local_3);
            var _local_4:uint = ColorUtil.adjustBrightness2(getStyle("borderColor"), -20);
            var _local_5:uint = ColorUtil.adjustBrightness2(_local_4, -30);
            graphics.clear();
            var _local_6:Number = 1;
            if (((name == "trackDisabledSkin") && (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)))
            {
                _local_6 = 0.2;
            };
            drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_4, _local_5], _local_6, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                "x":1,
                "y":1,
                "w":(_arg_1 - 2),
                "h":(_arg_2 - 2),
                "r":0
            });
            drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_3, _local_6, horizontalGradientMatrix(1, 1, ((_arg_1 / 3) * 2), (_arg_2 - 2)));
        }


    }
}//package mx.skins.halo

