// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.DataGridColumnDropIndicator

package mx.skins.halo
{
    import mx.skins.ProgrammaticSkin;
    import flash.display.Graphics;
    import mx.utils.ColorUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridColumnDropIndicator extends ProgrammaticSkin 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Graphics = graphics;
            _local_3.clear();
            _local_3.lineStyle(1, getStyle("rollOverColor"));
            _local_3.moveTo(0, 0);
            _local_3.lineTo(0, _arg_2);
            _local_3.lineStyle(1, ColorUtil.adjustBrightness(getStyle("themeColor"), -75));
            _local_3.moveTo(1, 0);
            _local_3.lineTo(1, _arg_2);
            _local_3.lineStyle(1, getStyle("rollOverColor"));
            _local_3.moveTo(2, 0);
            _local_3.lineTo(2, _arg_2);
        }


    }
}//package mx.skins.halo

