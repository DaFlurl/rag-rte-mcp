// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ApplicationBackground

package mx.skins.halo
{
    import mx.skins.ProgrammaticSkin;
    import flash.display.Graphics;
    import mx.utils.ColorUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ApplicationBackground extends ProgrammaticSkin 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        override public function get measuredWidth():Number
        {
            return (8);
        }

        override public function get measuredHeight():Number
        {
            return (8);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_6:uint;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Graphics = graphics;
            var _local_4:Array = getStyle("backgroundGradientColors");
            var _local_5:Array = getStyle("backgroundGradientAlphas");
            if (!_local_4)
            {
                _local_6 = getStyle("backgroundColor");
                if (isNaN(_local_6))
                {
                    _local_6 = 0xFFFFFF;
                };
                _local_4 = [];
                _local_4[0] = ColorUtil.adjustBrightness(_local_6, 15);
                _local_4[1] = ColorUtil.adjustBrightness(_local_6, -25);
            };
            if (!_local_5)
            {
                _local_5 = [1, 1];
            };
            _local_3.clear();
            drawRoundRect(0, 0, _arg_1, _arg_2, 0, _local_4, _local_5, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
        }


    }
}//package mx.skins.halo

