// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.GridRow

package mx.containers
{
    import mx.containers.gridClasses.GridColumnInfo;
    import mx.containers.gridClasses.GridRowInfo;
    import mx.core.EdgeMetrics;
    import mx.containers.utilityClasses.Flex;
    import mx.core.ScrollPolicy;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class GridRow extends HBox 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        internal var rowIndex:int = 0;
        internal var columnWidths:Array;
        internal var rowHeights:Array;
        internal var numGridItems:int;

        public function GridRow()
        {
            super.clipContent = false;
        }

        override public function getStyle(_arg_1:String):*
        {
            return (((_arg_1 == "horizontalGap") && (parent)) ? Grid(parent).getStyle("horizontalGap") : super.getStyle(_arg_1));
        }

        override public function invalidateDisplayList():void
        {
            super.invalidateDisplayList();
            if (parent)
            {
                Grid(parent).invalidateDisplayList();
            };
        }

        override public function get clipContent():Boolean
        {
            return (false);
        }

        override public function set horizontalScrollPolicy(_arg_1:String):void
        {
        }

        override public function set clipContent(_arg_1:Boolean):void
        {
        }

        internal function doRowLayout(_arg_1:Number, _arg_2:Number):void
        {
            var _local_8:GridItem;
            var _local_9:int;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:int;
            var _local_14:GridColumnInfo;
            var _local_15:Number;
            var _local_16:int;
            var _local_17:GridRowInfo;
            var _local_18:Number;
            var _local_19:Number;
            layoutChrome(_arg_1, _arg_2);
            var _local_3:Number = numChildren;
            if (_local_3 == 0)
            {
                return;
            };
            var _local_4:Boolean = invalidateSizeFlag;
            var _local_5:Boolean = invalidateDisplayListFlag;
            invalidateSizeFlag = true;
            invalidateDisplayListFlag = true;
            if ((((((((((((parent.getChildIndex(this) == 0) || (isNaN(columnWidths[0].x))) || (!(columnWidths.minWidth == minWidth))) || (!(columnWidths.maxWidth == maxWidth))) || (!(columnWidths.preferredWidth == getExplicitOrMeasuredWidth()))) || (!(columnWidths.percentWidth == percentWidth))) || (!(columnWidths.width == _arg_1))) || (!(columnWidths.paddingLeft == getStyle("paddingLeft")))) || (!(columnWidths.paddingRight == getStyle("paddingRight")))) || (!(columnWidths.horizontalAlign == getStyle("horizontalAlign")))) || (!(columnWidths.borderStyle == getStyle("borderStyle")))))
            {
                calculateColumnWidths();
                columnWidths.minWidth = minWidth;
                columnWidths.maxWidth = maxWidth;
                columnWidths.preferredWidth = getExplicitOrMeasuredWidth();
                columnWidths.percentWidth = percentWidth;
                columnWidths.width = _arg_1;
                columnWidths.paddingLeft = getStyle("paddingLeft");
                columnWidths.paddingRight = getStyle("paddingRight");
                columnWidths.horizontalAlign = getStyle("horizontalAlign");
                columnWidths.borderStyle = getStyle("borderStyle");
            };
            var _local_6:EdgeMetrics = viewMetricsAndPadding;
            var _local_7:int;
            while (_local_7 < _local_3)
            {
                _local_8 = GridItem(getChildAt(_local_7));
                _local_9 = _local_8.colIndex;
                _local_10 = columnWidths[_local_9].x;
                _local_11 = _local_6.top;
                _local_12 = _local_8.percentHeight;
                _local_13 = Math.min((_local_9 + _local_8.colSpan), columnWidths.length);
                _local_14 = columnWidths[(_local_13 - 1)];
                _local_15 = ((_local_14.x + _local_14.width) - _local_10);
                _local_16 = Math.min((rowIndex + _local_8.rowSpan), rowHeights.length);
                _local_17 = rowHeights[(_local_16 - 1)];
                _local_18 = ((((_local_17.y + _local_17.height) - rowHeights[rowIndex].y) - _local_6.top) - _local_6.bottom);
                _local_19 = (_local_15 - _local_8.maxWidth);
                if (_local_19 > 0)
                {
                    _local_10 = (_local_10 + (_local_19 * layoutObject.getHorizontalAlignValue()));
                    _local_15 = (_local_15 - _local_19);
                };
                _local_19 = (_local_18 - _local_8.maxHeight);
                if (((_local_12) && (_local_12 < 100)))
                {
                    _local_19 = Math.max(_local_19, (_local_18 * (100 - _local_12)));
                };
                if (_local_19 > 0)
                {
                    _local_11 = (_local_19 * layoutObject.getVerticalAlignValue());
                    _local_18 = (_local_18 - _local_19);
                };
                _local_15 = Math.ceil(_local_15);
                _local_18 = Math.ceil(_local_18);
                _local_8.move(_local_10, _local_11);
                _local_8.setActualSize(_local_15, _local_18);
                _local_7++;
            };
            invalidateSizeFlag = _local_4;
            invalidateDisplayListFlag = _local_5;
        }

        private function calculateColumnWidths():void
        {
            var _local_5:Number;
            var _local_6:GridColumnInfo;
            var _local_7:Number;
            var _local_8:int;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:int;
            var _local_1:EdgeMetrics = viewMetricsAndPadding;
            var _local_2:Number = getStyle("horizontalGap");
            var _local_3:int = columnWidths.length;
            var _local_4:Number = (((unscaledWidth - _local_1.left) - _local_1.right) - ((_local_3 - 1) * _local_2));
            var _local_9:Number = 0;
            var _local_10:Array = [];
            _local_5 = _local_4;
            _local_8 = 0;
            while (_local_8 < _local_3)
            {
                _local_6 = columnWidths[_local_8];
                _local_11 = _local_6.percent;
                if (_local_11)
                {
                    _local_9 = (_local_9 + _local_11);
                    _local_10.push(_local_6);
                }
                else
                {
                    _local_12 = (_local_6.width = _local_6.preferred);
                    _local_5 = (_local_5 - _local_12);
                };
                _local_8++;
            };
            if (_local_9)
            {
                _local_5 = Flex.flexChildrenProportionally(_local_4, _local_5, _local_9, _local_10);
                _local_13 = _local_10.length;
                _local_8 = 0;
                while (_local_8 < _local_13)
                {
                    _local_6 = _local_10[_local_8];
                    _local_6.width = _local_6.size;
                    _local_8++;
                };
            };
            _local_7 = (_local_1.left + (_local_5 * layoutObject.getHorizontalAlignValue()));
            _local_8 = 0;
            while (_local_8 < _local_3)
            {
                _local_6 = columnWidths[_local_8];
                _local_6.x = _local_7;
                _local_7 = (_local_7 + (_local_6.width + _local_2));
                _local_8++;
            };
        }

        override public function get horizontalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        override public function invalidateSize():void
        {
            super.invalidateSize();
            if (parent)
            {
                Grid(parent).invalidateSize();
            };
        }

        internal function updateRowMeasurements():void
        {
            var _local_6:Number;
            var _local_8:GridColumnInfo;
            var _local_1:Number = columnWidths.length;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:int;
            while (_local_4 < _local_1)
            {
                _local_8 = columnWidths[_local_4];
                _local_2 = (_local_2 + _local_8.min);
                _local_3 = (_local_3 + _local_8.preferred);
                _local_4++;
            };
            var _local_5:Number = layoutObject.widthPadding(_local_1);
            _local_6 = layoutObject.heightPadding(0);
            var _local_7:GridRowInfo = rowHeights[rowIndex];
            measuredMinWidth = (_local_2 + _local_5);
            measuredMinHeight = (_local_7.min + _local_6);
            measuredWidth = (_local_3 + _local_5);
            measuredHeight = (_local_7.preferred + _local_6);
        }

        override public function set verticalScrollPolicy(_arg_1:String):void
        {
        }

        override public function get verticalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
        }

        override public function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            super.setChildIndex(_arg_1, _arg_2);
            Grid(parent).invalidateSize();
            Grid(parent).invalidateDisplayList();
        }


    }
}//package mx.containers

