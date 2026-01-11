// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.TitleBackground

package mx.skins.halo
{
    import mx.skins.ProgrammaticSkin;
    import mx.styles.StyleManager;
    import mx.utils.ColorUtil;
    import flash.display.Graphics;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TitleBackground extends ProgrammaticSkin 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = getStyle("borderAlpha");
            var _local_4:Number = getStyle("cornerRadius");
            var _local_5:Array = getStyle("highlightAlphas");
            var _local_6:Array = getStyle("headerColors");
            var _local_7:* = (!(_local_6 == null));
            StyleManager.getColorNames(_local_6);
            var _local_8:Number = ColorUtil.adjustBrightness2(((_local_6) ? _local_6[1] : 0xFFFFFF), -20);
            var _local_9:Graphics = graphics;
            _local_9.clear();
            if (_arg_2 < 3)
            {
                return;
            };
            if (_local_7)
            {
                _local_9.lineStyle(0, _local_8, _local_3);
                _local_9.moveTo(0, _arg_2);
                _local_9.lineTo(_arg_1, _arg_2);
                _local_9.lineStyle(0, 0, 0);
                drawRoundRect(0, 0, _arg_1, _arg_2, {
                    "tl":_local_4,
                    "tr":_local_4,
                    "bl":0,
                    "br":0
                }, _local_6, _local_3, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                drawRoundRect(0, 0, _arg_1, (_arg_2 / 2), {
                    "tl":_local_4,
                    "tr":_local_4,
                    "bl":0,
                    "br":0
                }, [0xFFFFFF, 0xFFFFFF], _local_5, verticalGradientMatrix(0, 0, _arg_1, (_arg_2 / 2)));
                drawRoundRect(0, 0, _arg_1, _arg_2, {
                    "tl":_local_4,
                    "tr":_local_4,
                    "bl":0,
                    "br":0
                }, 0xFFFFFF, _local_5[0], null, GradientType.LINEAR, null, {
                    "x":0,
                    "y":1,
                    "w":_arg_1,
                    "h":(_arg_2 - 1),
                    "r":{
                        "tl":_local_4,
                        "tr":_local_4,
                        "bl":0,
                        "br":0
                    }
                });
            };
        }


    }
}//package mx.skins.halo

