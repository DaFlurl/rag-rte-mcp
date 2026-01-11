// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.LinkButtonSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.core.EdgeMetrics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class LinkButtonSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = getStyle("cornerRadius");
            var _local_4:uint = getStyle("rollOverColor");
            var _local_5:uint = getStyle("selectionColor");
            graphics.clear();
            switch (name)
            {
                case "upSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_3, 0, 0);
                    return;
                case "overSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_3, _local_4, 1);
                    return;
                case "downSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_3, _local_5, 1);
                    return;
                case "disabledSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_3, 0, 0);
                    return;
            };
        }

        override public function get borderMetrics():EdgeMetrics
        {
            return (EdgeMetrics.EMPTY);
        }


    }
}//package mx.skins.halo

