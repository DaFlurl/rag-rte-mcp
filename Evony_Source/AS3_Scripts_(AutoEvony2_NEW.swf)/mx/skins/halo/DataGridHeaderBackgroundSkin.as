// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.DataGridHeaderBackgroundSkin

package mx.skins.halo
{
    import mx.skins.ProgrammaticSkin;
    import flash.display.Graphics;
    import mx.styles.StyleManager;
    import flash.geom.Matrix;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridHeaderBackgroundSkin extends ProgrammaticSkin 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Graphics = graphics;
            _local_3.clear();
            var _local_4:Array = getStyle("headerColors");
            StyleManager.getColorNames(_local_4);
            var _local_5:Matrix = new Matrix();
            _local_5.createGradientBox(_arg_1, (_arg_2 + 1), (Math.PI / 2), 0, 0);
            _local_4 = [_local_4[0], _local_4[0], _local_4[1]];
            var _local_6:Array = [0, 60, 0xFF];
            var _local_7:Array = [1, 1, 1];
            _local_3.beginGradientFill(GradientType.LINEAR, _local_4, _local_7, _local_6, _local_5);
            _local_3.lineStyle(0, 0, 0);
            _local_3.moveTo(0, 0);
            _local_3.lineTo(_arg_1, 0);
            _local_3.lineTo(_arg_1, (_arg_2 - 0.5));
            _local_3.lineStyle(0, getStyle("borderColor"), 100);
            _local_3.lineTo(0, (_arg_2 - 0.5));
            _local_3.lineStyle(0, 0, 0);
            _local_3.endFill();
        }


    }
}//package mx.skins.halo

