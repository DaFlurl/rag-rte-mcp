// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ProgressTrackSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.styles.StyleManager;
    import mx.utils.ColorUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ProgressTrackSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        override public function get measuredWidth():Number
        {
            return (200);
        }

        override public function get measuredHeight():Number
        {
            return (6);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:uint = getStyle("borderColor");
            var _local_4:Array = (getStyle("trackColors") as Array);
            StyleManager.getColorNames(_local_4);
            var _local_5:Number = ColorUtil.adjustBrightness2(_local_3, -30);
            graphics.clear();
            drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_5, _local_3], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
            drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_4, 1, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
        }


    }
}//package mx.skins.halo

