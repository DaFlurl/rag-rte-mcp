// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ToolTipBorder

package mx.skins.halo
{
    import mx.skins.RectangularBorder;
    import mx.core.EdgeMetrics;
    import mx.graphics.RectangularDropShadow;
    import flash.display.Graphics;
    import flash.filters.DropShadowFilter;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ToolTipBorder extends RectangularBorder 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _borderMetrics:EdgeMetrics;
        private var dropShadow:RectangularDropShadow;


        override public function get borderMetrics():EdgeMetrics
        {
            if (_borderMetrics)
            {
                return (_borderMetrics);
            };
            var _local_1:String = getStyle("borderStyle");
            switch (_local_1)
            {
                case "errorTipRight":
                    _borderMetrics = new EdgeMetrics(15, 1, 3, 3);
                    break;
                case "errorTipAbove":
                    _borderMetrics = new EdgeMetrics(3, 1, 3, 15);
                    break;
                case "errorTipBelow":
                    _borderMetrics = new EdgeMetrics(3, 13, 3, 3);
                    break;
                default:
                    _borderMetrics = new EdgeMetrics(3, 1, 3, 3);
            };
            return (_borderMetrics);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:String = getStyle("borderStyle");
            var _local_4:uint = getStyle("backgroundColor");
            var _local_5:Number = getStyle("backgroundAlpha");
            var _local_6:uint = getStyle("borderColor");
            var _local_7:Number = getStyle("cornerRadius");
            var _local_8:uint = getStyle("shadowColor");
            var _local_9:Number = 0.1;
            var _local_10:Graphics = graphics;
            _local_10.clear();
            filters = [];
            switch (_local_3)
            {
                case "none":
                    return;
                case "errorTipRight":
                    drawRoundRect(11, 0, (_arg_1 - 11), (_arg_2 - 2), 3, _local_6, _local_5);
                    _local_10.beginFill(_local_6, _local_5);
                    _local_10.moveTo(11, 7);
                    _local_10.lineTo(0, 13);
                    _local_10.lineTo(11, 19);
                    _local_10.moveTo(11, 7);
                    _local_10.endFill();
                    filters = [new DropShadowFilter(2, 90, 0, 0.4)];
                    return;
                case "errorTipAbove":
                    drawRoundRect(0, 0, _arg_1, (_arg_2 - 13), 3, _local_6, _local_5);
                    _local_10.beginFill(_local_6, _local_5);
                    _local_10.moveTo(9, (_arg_2 - 13));
                    _local_10.lineTo(15, (_arg_2 - 2));
                    _local_10.lineTo(21, (_arg_2 - 13));
                    _local_10.moveTo(9, (_arg_2 - 13));
                    _local_10.endFill();
                    filters = [new DropShadowFilter(2, 90, 0, 0.4)];
                    return;
                case "errorTipBelow":
                    drawRoundRect(0, 11, _arg_1, (_arg_2 - 13), 3, _local_6, _local_5);
                    _local_10.beginFill(_local_6, _local_5);
                    _local_10.moveTo(9, 11);
                    _local_10.lineTo(15, 0);
                    _local_10.lineTo(21, 11);
                    _local_10.moveTo(10, 11);
                    _local_10.endFill();
                    filters = [new DropShadowFilter(2, 90, 0, 0.4)];
                    return;
                default:
                    drawRoundRect(3, 1, (_arg_1 - 6), (_arg_2 - 4), _local_7, _local_4, _local_5);
                    if (!dropShadow)
                    {
                        dropShadow = new RectangularDropShadow();
                    };
                    dropShadow.distance = 3;
                    dropShadow.angle = 90;
                    dropShadow.color = 0;
                    dropShadow.alpha = 0.4;
                    dropShadow.tlRadius = (_local_7 + 2);
                    dropShadow.trRadius = (_local_7 + 2);
                    dropShadow.blRadius = (_local_7 + 2);
                    dropShadow.brRadius = (_local_7 + 2);
                    dropShadow.drawShadow(graphics, 3, 0, (_arg_1 - 6), (_arg_2 - 4));
            };
        }

        override public function styleChanged(_arg_1:String):void
        {
            if ((((_arg_1 == "borderStyle") || (_arg_1 == "styleName")) || (_arg_1 == null)))
            {
                _borderMetrics = null;
            };
            invalidateDisplayList();
        }


    }
}//package mx.skins.halo

