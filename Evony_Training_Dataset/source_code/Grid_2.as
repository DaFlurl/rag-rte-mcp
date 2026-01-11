// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.Grid

package mx.containers
{
    import mx.containers.gridClasses.GridColumnInfo;
    import mx.containers.gridClasses.GridRowInfo;
    import mx.core.EdgeMetrics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Grid extends Box 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var columnWidths:Array;
        private var rowHeights:Array;
        private var needToRemeasure:Boolean = true;


        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_4:int;
            var _local_5:GridRow;
            if (needToRemeasure)
            {
                measure();
            };
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:int;
            var _local_6:Array = [];
            var _local_7:int;
            while (_local_7 < numChildren)
            {
                _local_5 = GridRow(getChildAt(_local_7));
                if (_local_5.includeInLayout)
                {
                    _local_6.push(_local_5);
                    _local_3++;
                };
                _local_7++;
            };
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = _local_6[_local_4];
                rowHeights[_local_4].y = _local_5.y;
                rowHeights[_local_4].height = _local_5.height;
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = _local_6[_local_4];
                _local_5.doRowLayout((_local_5.width * _local_5.scaleX), (_local_5.height * _local_5.scaleY));
                _local_4++;
            };
        }

        private function distributeItemWidth(_arg_1:GridItem, _arg_2:int, _arg_3:Number, _arg_4:Array):void
        {
            var _local_12:int;
            var _local_13:GridColumnInfo;
            var _local_14:Number;
            var _local_15:Number;
            var _local_5:Number = _arg_1.maxWidth;
            var _local_6:Number = _arg_1.getExplicitOrMeasuredWidth();
            var _local_7:Number = _arg_1.minWidth;
            var _local_8:int = _arg_1.colSpan;
            var _local_9:Number = _arg_1.percentWidth;
            var _local_10:Number = 0;
            var _local_11:Boolean;
            _local_12 = _arg_2;
            while (_local_12 < (_arg_2 + _local_8))
            {
                _local_13 = _arg_4[_local_12];
                _local_6 = (_local_6 - _local_13.preferred);
                _local_7 = (_local_7 - _local_13.min);
                _local_10 = (_local_10 + _local_13.flex);
                _local_12++;
            };
            if (_local_8 > 1)
            {
                _local_14 = (_arg_3 * (_local_8 - 1));
                _local_6 = (_local_6 - _local_14);
                _local_7 = (_local_7 - _local_14);
            };
            if (_local_10 == 0)
            {
                _local_10 = _local_8;
                _local_11 = true;
            };
            _local_6 = ((_local_6 > 0) ? Math.ceil((_local_6 / _local_10)) : 0);
            _local_7 = ((_local_7 > 0) ? Math.ceil((_local_7 / _local_10)) : 0);
            _local_12 = _arg_2;
            while (_local_12 < (_arg_2 + _local_8))
            {
                _local_13 = _arg_4[_local_12];
                _local_15 = ((_local_11) ? 1 : _local_13.flex);
                _local_13.preferred = (_local_13.preferred + (_local_6 * _local_15));
                _local_13.min = (_local_13.min + (_local_7 * _local_15));
                if (_local_9)
                {
                    _local_13.percent = Math.max(_local_13.percent, (_local_9 / _local_8));
                };
                _local_12++;
            };
            if (((_local_8 == 1) && (_local_5 < _local_13.max)))
            {
                _local_13.max = _local_5;
            };
        }

        private function distributeItemHeight(_arg_1:GridItem, _arg_2:Number, _arg_3:Number, _arg_4:Array):void
        {
            var _local_11:int;
            var _local_12:GridRowInfo;
            var _local_13:Number;
            var _local_14:Number;
            var _local_5:Number = _arg_1.maxHeight;
            var _local_6:Number = _arg_1.getExplicitOrMeasuredHeight();
            var _local_7:Number = _arg_1.minHeight;
            var _local_8:int = _arg_1.rowSpan;
            var _local_9:Number = 0;
            var _local_10:Boolean;
            _local_11 = _arg_2;
            while (_local_11 < (_arg_2 + _local_8))
            {
                _local_12 = _arg_4[_local_11];
                _local_6 = (_local_6 - _local_12.preferred);
                _local_7 = (_local_7 - _local_12.min);
                _local_9 = (_local_9 + _local_12.flex);
                _local_11++;
            };
            if (_local_8 > 1)
            {
                _local_13 = (_arg_3 * (_local_8 - 1));
                _local_6 = (_local_6 - _local_13);
                _local_7 = (_local_7 - _local_13);
            };
            if (_local_9 == 0)
            {
                _local_9 = _local_8;
                _local_10 = true;
            };
            _local_6 = ((_local_6 > 0) ? Math.ceil((_local_6 / _local_9)) : 0);
            _local_7 = ((_local_7 > 0) ? Math.ceil((_local_7 / _local_9)) : 0);
            _local_11 = _arg_2;
            while (_local_11 < (_arg_2 + _local_8))
            {
                _local_12 = _arg_4[_local_11];
                _local_14 = ((_local_10) ? 1 : _local_12.flex);
                _local_12.preferred = (_local_12.preferred + (_local_6 * _local_14));
                _local_12.min = (_local_12.min + (_local_7 * _local_14));
                _local_11++;
            };
            if (((_local_8 == 1) && (_local_5 < _local_12.max)))
            {
                _local_12.max = _local_5;
            };
        }

        override public function invalidateSize():void
        {
            if (((!(isNaN(explicitWidth))) && (!(isNaN(explicitHeight)))))
            {
                needToRemeasure = true;
            };
            super.invalidateSize();
        }

        override protected function measure():void
        {
            var _local_4:GridRow;
            var _local_5:GridItem;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_12:int;
            var _local_19:Number;
            var _local_22:GridRow;
            var _local_23:EdgeMetrics;
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            var _local_28:*;
            var _local_29:*;
            var _local_30:GridRowInfo;
            var _local_31:GridColumnInfo;
            var _local_32:Number;
            var _local_1:int;
            var _local_2:int;
            var _local_3:Array = [];
            var _local_9:Array = [];
            var _local_10:int;
            while (_local_10 < numChildren)
            {
                _local_4 = GridRow(getChildAt(_local_10));
                if (_local_4.includeInLayout)
                {
                    _local_9.push(_local_4);
                    _local_1++;
                };
                _local_10++;
            };
            _local_6 = 0;
            while (_local_6 < _local_1)
            {
                _local_8 = 0;
                _local_4 = _local_9[_local_6];
                _local_4.numGridItems = _local_4.numChildren;
                _local_4.rowIndex = _local_6;
                _local_7 = 0;
                while (_local_7 < _local_4.numGridItems)
                {
                    if (_local_6 > 0)
                    {
                        _local_25 = _local_3[_local_8];
                        while (((!(isNaN(_local_25))) && (_local_25 >= _local_6)))
                        {
                            _local_25 = _local_3[++_local_8];
                        };
                    };
                    _local_5 = GridItem(_local_4.getChildAt(_local_7));
                    _local_5.colIndex = _local_8;
                    if (_local_5.rowSpan > 1)
                    {
                        _local_26 = ((_local_6 + _local_5.rowSpan) - 1);
                        _local_27 = 0;
                        while (_local_27 < _local_5.colSpan)
                        {
                            _local_3[(_local_8 + _local_27)] = _local_26;
                            _local_27++;
                        };
                    };
                    _local_8 = (_local_8 + _local_5.colSpan);
                    _local_7++;
                };
                if (_local_8 > _local_2)
                {
                    _local_2 = _local_8;
                };
                _local_6++;
            };
            rowHeights = new Array(_local_1);
            columnWidths = new Array(_local_2);
            _local_6 = 0;
            while (_local_6 < _local_1)
            {
                rowHeights[_local_6] = new GridRowInfo();
                _local_6++;
            };
            _local_6 = 0;
            while (_local_6 < _local_2)
            {
                columnWidths[_local_6] = new GridColumnInfo();
                _local_6++;
            };
            var _local_11:int = int.MAX_VALUE;
            var _local_13:int = 1;
            var _local_14:Number = getStyle("horizontalGap");
            var _local_15:Number = getStyle("verticalGap");
            do 
            {
                _local_12 = _local_13;
                _local_13 = _local_11;
                _local_6 = 0;
                while (_local_6 < _local_1)
                {
                    _local_4 = _local_9[_local_6];
                    _local_4.columnWidths = columnWidths;
                    _local_4.rowHeights = rowHeights;
                    _local_7 = 0;
                    while (_local_7 < _local_4.numGridItems)
                    {
                        _local_5 = GridItem(_local_4.getChildAt(_local_7));
                        _local_28 = _local_5.rowSpan;
                        _local_29 = _local_5.colSpan;
                        if (_local_28 == _local_12)
                        {
                            distributeItemHeight(_local_5, _local_6, _local_15, rowHeights);
                        }
                        else
                        {
                            if (((_local_28 > _local_12) && (_local_28 < _local_13)))
                            {
                                _local_13 = _local_28;
                            };
                        };
                        if (_local_29 == _local_12)
                        {
                            distributeItemWidth(_local_5, _local_5.colIndex, _local_14, columnWidths);
                        }
                        else
                        {
                            if (((_local_29 > _local_12) && (_local_29 < _local_13)))
                            {
                                _local_13 = _local_29;
                            };
                        };
                        _local_7++;
                    };
                    _local_6++;
                };
            } while (_local_13 < _local_11);
            var _local_16:Number = 0;
            var _local_17:Number = 0;
            var _local_18:Number = 0;
            _local_19 = 0;
            _local_6 = 0;
            while (_local_6 < _local_1)
            {
                _local_30 = rowHeights[_local_6];
                if (_local_30.min > _local_30.preferred)
                {
                    _local_30.min = _local_30.preferred;
                };
                if (_local_30.max < _local_30.preferred)
                {
                    _local_30.max = _local_30.preferred;
                };
                _local_17 = (_local_17 + _local_30.min);
                _local_19 = (_local_19 + _local_30.preferred);
                _local_6++;
            };
            _local_6 = 0;
            while (_local_6 < _local_2)
            {
                _local_31 = columnWidths[_local_6];
                if (_local_31.min > _local_31.preferred)
                {
                    _local_31.min = _local_31.preferred;
                };
                if (_local_31.max < _local_31.preferred)
                {
                    _local_31.max = _local_31.preferred;
                };
                _local_16 = (_local_16 + _local_31.min);
                _local_18 = (_local_18 + _local_31.preferred);
                _local_6++;
            };
            var _local_20:EdgeMetrics = viewMetricsAndPadding;
            var _local_21:Number = (_local_20.left + _local_20.right);
            var _local_24:Number = 0;
            if (_local_2 > 1)
            {
                _local_21 = (_local_21 + (getStyle("horizontalGap") * (_local_2 - 1)));
            };
            _local_6 = 0;
            while (_local_6 < _local_1)
            {
                _local_22 = _local_9[_local_6];
                _local_23 = _local_22.viewMetricsAndPadding;
                _local_32 = (_local_23.left + _local_23.right);
                if (_local_32 > _local_24)
                {
                    _local_24 = _local_32;
                };
                _local_6++;
            };
            _local_21 = (_local_21 + _local_24);
            _local_16 = (_local_16 + _local_21);
            _local_18 = (_local_18 + _local_21);
            _local_21 = (_local_20.top + _local_20.bottom);
            if (_local_1 > 1)
            {
                _local_21 = (_local_21 + (getStyle("verticalGap") * (_local_1 - 1)));
            };
            _local_6 = 0;
            while (_local_6 < _local_1)
            {
                _local_22 = _local_9[_local_6];
                _local_23 = _local_22.viewMetricsAndPadding;
                _local_21 = (_local_21 + (_local_23.top + _local_23.bottom));
                _local_6++;
            };
            _local_17 = (_local_17 + _local_21);
            _local_19 = (_local_19 + _local_21);
            _local_6 = 0;
            while (_local_6 < _local_1)
            {
                _local_22 = _local_9[_local_6];
                _local_22.updateRowMeasurements();
                _local_6++;
            };
            super.measure();
            measuredMinWidth = Math.max(measuredMinWidth, _local_16);
            measuredMinHeight = Math.max(measuredMinHeight, _local_17);
            measuredWidth = Math.max(measuredWidth, _local_18);
            measuredHeight = Math.max(measuredHeight, _local_19);
            needToRemeasure = false;
        }


    }
}//package mx.containers

