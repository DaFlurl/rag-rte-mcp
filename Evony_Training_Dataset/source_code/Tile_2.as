// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.Tile

package mx.containers
{
    import mx.core.Container;
    import mx.core.IUIComponent;
    import mx.core.EdgeMetrics;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Tile extends Container 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _direction:String = "horizontal";
        mx_internal var cellWidth:Number;
        mx_internal var cellHeight:Number;
        private var _tileHeight:Number;
        private var _tileWidth:Number;


        override protected function measure():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            super.measure();
            findCellSize();
            _local_3 = cellWidth;
            _local_4 = cellHeight;
            var _local_5:int = numChildren;
            var _local_6:int = _local_5;
            var _local_7:int;
            while (_local_7 < _local_5)
            {
                if (!IUIComponent(getChildAt(_local_7)).includeInLayout)
                {
                    _local_6--;
                };
                _local_7++;
            };
            _local_5 = _local_6;
            if (_local_5 > 0)
            {
                _local_11 = getStyle("horizontalGap");
                _local_12 = getStyle("verticalGap");
                if (direction == TileDirection.HORIZONTAL)
                {
                    _local_15 = (explicitWidth / Math.abs(scaleX));
                    if (!isNaN(_local_15))
                    {
                        _local_13 = Math.floor(((_local_15 + _local_11) / (cellWidth + _local_11)));
                    };
                }
                else
                {
                    _local_16 = (explicitHeight / Math.abs(scaleY));
                    if (!isNaN(_local_16))
                    {
                        _local_13 = Math.floor(((_local_16 + _local_12) / (cellHeight + _local_12)));
                    };
                };
                if (isNaN(_local_13))
                {
                    _local_13 = Math.ceil(Math.sqrt(_local_5));
                };
                if (_local_13 < 1)
                {
                    _local_13 = 1;
                };
                _local_14 = Math.ceil((_local_5 / _local_13));
                if (direction == TileDirection.HORIZONTAL)
                {
                    _local_1 = ((_local_13 * cellWidth) + ((_local_13 - 1) * _local_11));
                    _local_2 = ((_local_14 * cellHeight) + ((_local_14 - 1) * _local_12));
                }
                else
                {
                    _local_1 = ((_local_14 * cellWidth) + ((_local_14 - 1) * _local_11));
                    _local_2 = ((_local_13 * cellHeight) + ((_local_13 - 1) * _local_12));
                };
            }
            else
            {
                _local_1 = _local_3;
                _local_2 = _local_4;
            };
            var _local_8:EdgeMetrics = viewMetricsAndPadding;
            var _local_9:Number = (_local_8.left + _local_8.right);
            var _local_10:Number = (_local_8.top + _local_8.bottom);
            _local_3 = (_local_3 + _local_9);
            _local_1 = (_local_1 + _local_9);
            _local_4 = (_local_4 + _local_10);
            _local_2 = (_local_2 + _local_10);
            measuredMinWidth = Math.ceil(_local_3);
            measuredMinHeight = Math.ceil(_local_4);
            measuredWidth = Math.ceil(_local_1);
            measuredHeight = Math.ceil(_local_2);
        }

        public function set tileHeight(_arg_1:Number):void
        {
            _tileHeight = _arg_1;
            invalidateSize();
        }

        mx_internal function calcHorizontalOffset(_arg_1:Number, _arg_2:String):Number
        {
            var _local_3:Number;
            if (_arg_2 == "left")
            {
                _local_3 = 0;
            }
            else
            {
                if (_arg_2 == "center")
                {
                    _local_3 = ((cellWidth - _arg_1) / 2);
                }
                else
                {
                    if (_arg_2 == "right")
                    {
                        _local_3 = (cellWidth - _arg_1);
                    };
                };
            };
            return (_local_3);
        }

        mx_internal function calcVerticalOffset(_arg_1:Number, _arg_2:String):Number
        {
            var _local_3:Number;
            if (_arg_2 == "top")
            {
                _local_3 = 0;
            }
            else
            {
                if (_arg_2 == "middle")
                {
                    _local_3 = ((cellHeight - _arg_1) / 2);
                }
                else
                {
                    if (_arg_2 == "bottom")
                    {
                        _local_3 = (cellHeight - _arg_1);
                    };
                };
            };
            return (_local_3);
        }

        public function set tileWidth(_arg_1:Number):void
        {
            _tileWidth = _arg_1;
            invalidateSize();
        }

        [Bindable("resize")]
        public function get tileHeight():Number
        {
            return (_tileHeight);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_12:Number;
            var _local_13:Number;
            var _local_15:int;
            var _local_16:IUIComponent;
            var _local_17:Number;
            var _local_18:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            if (((isNaN(cellWidth)) || (isNaN(cellHeight))))
            {
                findCellSize();
            };
            var _local_3:EdgeMetrics = viewMetricsAndPadding;
            var _local_4:Number = getStyle("paddingLeft");
            var _local_5:Number = getStyle("paddingTop");
            var _local_6:Number = getStyle("horizontalGap");
            var _local_7:Number = getStyle("verticalGap");
            var _local_8:String = getStyle("horizontalAlign");
            var _local_9:String = getStyle("verticalAlign");
            var _local_10:Number = _local_4;
            var _local_11:Number = _local_5;
            var _local_14:int = numChildren;
            if (direction == TileDirection.HORIZONTAL)
            {
                _local_17 = (Math.ceil(_arg_1) - _local_3.right);
                _local_15 = 0;
                while (_local_15 < _local_14)
                {
                    _local_16 = IUIComponent(getChildAt(_local_15));
                    if (_local_16.includeInLayout)
                    {
                        if ((_local_10 + cellWidth) > _local_17)
                        {
                            if (_local_10 != _local_4)
                            {
                                _local_11 = (_local_11 + (cellHeight + _local_7));
                                _local_10 = _local_4;
                            };
                        };
                        setChildSize(_local_16);
                        _local_12 = Math.floor(calcHorizontalOffset(_local_16.width, _local_8));
                        _local_13 = Math.floor(calcVerticalOffset(_local_16.height, _local_9));
                        _local_16.move((_local_10 + _local_12), (_local_11 + _local_13));
                        _local_10 = (_local_10 + (cellWidth + _local_6));
                    };
                    _local_15++;
                };
            }
            else
            {
                _local_18 = (Math.ceil(_arg_2) - _local_3.bottom);
                _local_15 = 0;
                while (_local_15 < _local_14)
                {
                    _local_16 = IUIComponent(getChildAt(_local_15));
                    if (_local_16.includeInLayout)
                    {
                        if ((_local_11 + cellHeight) > _local_18)
                        {
                            if (_local_11 != _local_5)
                            {
                                _local_10 = (_local_10 + (cellWidth + _local_6));
                                _local_11 = _local_5;
                            };
                        };
                        setChildSize(_local_16);
                        _local_12 = Math.floor(calcHorizontalOffset(_local_16.width, _local_8));
                        _local_13 = Math.floor(calcVerticalOffset(_local_16.height, _local_9));
                        _local_16.move((_local_10 + _local_12), (_local_11 + _local_13));
                        _local_11 = (_local_11 + (cellHeight + _local_7));
                    };
                    _local_15++;
                };
            };
            cellWidth = NaN;
            cellHeight = NaN;
        }

        [Bindable("resize")]
        public function get tileWidth():Number
        {
            return (_tileWidth);
        }

        private function setChildSize(_arg_1:IUIComponent):void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            if (_arg_1.percentWidth > 0)
            {
                _local_2 = Math.min(cellWidth, ((cellWidth * _arg_1.percentWidth) / 100));
            }
            else
            {
                _local_2 = _arg_1.getExplicitOrMeasuredWidth();
                if (_local_2 > cellWidth)
                {
                    _local_4 = ((isNaN(_arg_1.explicitWidth)) ? 0 : _arg_1.explicitWidth);
                    _local_5 = ((isNaN(_arg_1.explicitMinWidth)) ? 0 : _arg_1.explicitMinWidth);
                    _local_2 = (((_local_4 > cellWidth) || (_local_5 > cellWidth)) ? Math.max(_local_5, _local_4) : cellWidth);
                };
            };
            if (_arg_1.percentHeight > 0)
            {
                _local_3 = Math.min(cellHeight, ((cellHeight * _arg_1.percentHeight) / 100));
            }
            else
            {
                _local_3 = _arg_1.getExplicitOrMeasuredHeight();
                if (_local_3 > cellHeight)
                {
                    _local_4 = ((isNaN(_arg_1.explicitHeight)) ? 0 : _arg_1.explicitHeight);
                    _local_5 = ((isNaN(_arg_1.explicitMinHeight)) ? 0 : _arg_1.explicitMinHeight);
                    _local_3 = (((_local_4 > cellHeight) || (_local_5 > cellHeight)) ? Math.max(_local_5, _local_4) : cellHeight);
                };
            };
            _arg_1.setActualSize(_local_2, _local_3);
        }

        mx_internal function findCellSize():void
        {
            var _local_7:IUIComponent;
            var _local_8:Number;
            var _local_9:Number;
            var _local_1:* = (!(isNaN(tileWidth)));
            var _local_2:* = (!(isNaN(tileHeight)));
            if (((_local_1) && (_local_2)))
            {
                cellWidth = tileWidth;
                cellHeight = tileHeight;
                return;
            };
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:int = numChildren;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_7 = IUIComponent(getChildAt(_local_6));
                if (_local_7.includeInLayout)
                {
                    _local_8 = _local_7.getExplicitOrMeasuredWidth();
                    if (_local_8 > _local_3)
                    {
                        _local_3 = _local_8;
                    };
                    _local_9 = _local_7.getExplicitOrMeasuredHeight();
                    if (_local_9 > _local_4)
                    {
                        _local_4 = _local_9;
                    };
                };
                _local_6++;
            };
            cellWidth = ((_local_1) ? tileWidth : _local_3);
            cellHeight = ((_local_2) ? tileHeight : _local_4);
        }

        public function set direction(_arg_1:String):void
        {
            _direction = _arg_1;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("directionChanged"));
        }

        [Bindable("directionChanged")]
        public function get direction():String
        {
            return (_direction);
        }


    }
}//package mx.containers

