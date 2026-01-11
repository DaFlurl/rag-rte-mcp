// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.utilityClasses.BoxLayout

package mx.containers.utilityClasses
{
    import mx.containers.BoxDirection;
    import mx.core.IUIComponent;
    import mx.core.Container;
    import mx.core.EdgeMetrics;
    import mx.controls.scrollClasses.ScrollBar;
    import mx.core.ScrollPolicy;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BoxLayout extends Layout 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var direction:String = "vertical";


        private function isVertical():Boolean
        {
            return (!(direction == BoxDirection.HORIZONTAL));
        }

        mx_internal function getHorizontalAlignValue():Number
        {
            var _local_1:String = target.getStyle("horizontalAlign");
            if (_local_1 == "center")
            {
                return (0.5);
            };
            if (_local_1 == "right")
            {
                return (1);
            };
            return (0);
        }

        override public function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_16:Number;
            var _local_17:int;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:int;
            var _local_22:IUIComponent;
            var _local_23:IUIComponent;
            var _local_24:Number;
            var _local_25:Number;
            var _local_26:Number;
            var _local_27:Number;
            var _local_3:Container = super.target;
            var _local_4:int = _local_3.numChildren;
            if (_local_4 == 0)
            {
                return;
            };
            var _local_5:EdgeMetrics = _local_3.viewMetricsAndPadding;
            var _local_6:Number = _local_3.getStyle("paddingLeft");
            var _local_7:Number = _local_3.getStyle("paddingTop");
            var _local_8:Number = getHorizontalAlignValue();
            var _local_9:Number = getVerticalAlignValue();
            var _local_10:Number = (((_local_3.scaleX > 0) && (!(_local_3.scaleX == 1))) ? (_local_3.minWidth / Math.abs(_local_3.scaleX)) : _local_3.minWidth);
            var _local_11:Number = (((_local_3.scaleY > 0) && (!(_local_3.scaleY == 1))) ? (_local_3.minHeight / Math.abs(_local_3.scaleY)) : _local_3.minHeight);
            var _local_12:Number = ((Math.max(_arg_1, _local_10) - _local_5.right) - _local_5.left);
            var _local_13:Number = ((Math.max(_arg_2, _local_11) - _local_5.bottom) - _local_5.top);
            var _local_14:ScrollBar = _local_3.horizontalScrollBar;
            var _local_15:ScrollBar = _local_3.verticalScrollBar;
            if (_local_4 == 1)
            {
                _local_23 = IUIComponent(_local_3.getChildAt(0));
                _local_24 = _local_23.percentWidth;
                _local_25 = _local_23.percentHeight;
                if (_local_24)
                {
                    _local_26 = Math.max(_local_23.minWidth, Math.min(_local_23.maxWidth, ((_local_24 >= 100) ? _local_12 : ((_local_12 * _local_24) / 100))));
                }
                else
                {
                    _local_26 = _local_23.getExplicitOrMeasuredWidth();
                };
                if (_local_25)
                {
                    _local_27 = Math.max(_local_23.minHeight, Math.min(_local_23.maxHeight, ((_local_25 >= 100) ? _local_13 : ((_local_13 * _local_25) / 100))));
                }
                else
                {
                    _local_27 = _local_23.getExplicitOrMeasuredHeight();
                };
                if (((_local_23.scaleX == 1) && (_local_23.scaleY == 1)))
                {
                    _local_23.setActualSize(Math.floor(_local_26), Math.floor(_local_27));
                }
                else
                {
                    _local_23.setActualSize(_local_26, _local_27);
                };
                if (((!(_local_15 == null)) && (_local_3.verticalScrollPolicy == ScrollPolicy.AUTO)))
                {
                    _local_12 = (_local_12 + _local_15.minWidth);
                };
                if (((!(_local_14 == null)) && (_local_3.horizontalScrollPolicy == ScrollPolicy.AUTO)))
                {
                    _local_13 = (_local_13 + _local_14.minHeight);
                };
                _local_20 = (((_local_12 - _local_23.width) * _local_8) + _local_6);
                _local_19 = (((_local_13 - _local_23.height) * _local_9) + _local_7);
                _local_23.move(Math.floor(_local_20), Math.floor(_local_19));
            }
            else
            {
                if (isVertical())
                {
                    _local_16 = _local_3.getStyle("verticalGap");
                    _local_17 = _local_4;
                    _local_21 = 0;
                    while (_local_21 < _local_4)
                    {
                        if (!IUIComponent(_local_3.getChildAt(_local_21)).includeInLayout)
                        {
                            _local_17--;
                        };
                        _local_21++;
                    };
                    _local_18 = Flex.flexChildHeightsProportionally(_local_3, (_local_13 - ((_local_17 - 1) * _local_16)), _local_12);
                    if (((!(_local_14 == null)) && (_local_3.horizontalScrollPolicy == ScrollPolicy.AUTO)))
                    {
                        _local_18 = (_local_18 + _local_14.minHeight);
                    };
                    if (((!(_local_15 == null)) && (_local_3.verticalScrollPolicy == ScrollPolicy.AUTO)))
                    {
                        _local_12 = (_local_12 + _local_15.minWidth);
                    };
                    _local_19 = (_local_7 + (_local_18 * _local_9));
                    _local_21 = 0;
                    while (_local_21 < _local_4)
                    {
                        _local_22 = IUIComponent(_local_3.getChildAt(_local_21));
                        _local_20 = (((_local_12 - _local_22.width) * _local_8) + _local_6);
                        _local_22.move(Math.floor(_local_20), Math.floor(_local_19));
                        if (_local_22.includeInLayout)
                        {
                            _local_19 = (_local_19 + (_local_22.height + _local_16));
                        };
                        _local_21++;
                    };
                }
                else
                {
                    _local_16 = _local_3.getStyle("horizontalGap");
                    _local_17 = _local_4;
                    _local_21 = 0;
                    while (_local_21 < _local_4)
                    {
                        if (!IUIComponent(_local_3.getChildAt(_local_21)).includeInLayout)
                        {
                            _local_17--;
                        };
                        _local_21++;
                    };
                    _local_18 = Flex.flexChildWidthsProportionally(_local_3, (_local_12 - ((_local_17 - 1) * _local_16)), _local_13);
                    if (((!(_local_14 == null)) && (_local_3.horizontalScrollPolicy == ScrollPolicy.AUTO)))
                    {
                        _local_13 = (_local_13 + _local_14.minHeight);
                    };
                    if (((!(_local_15 == null)) && (_local_3.verticalScrollPolicy == ScrollPolicy.AUTO)))
                    {
                        _local_18 = (_local_18 + _local_15.minWidth);
                    };
                    _local_20 = (_local_6 + (_local_18 * _local_8));
                    _local_21 = 0;
                    while (_local_21 < _local_4)
                    {
                        _local_22 = IUIComponent(_local_3.getChildAt(_local_21));
                        _local_19 = (((_local_13 - _local_22.height) * _local_9) + _local_7);
                        _local_22.move(Math.floor(_local_20), Math.floor(_local_19));
                        if (_local_22.includeInLayout)
                        {
                            _local_20 = (_local_20 + (_local_22.width + _local_16));
                        };
                        _local_21++;
                    };
                };
            };
        }

        mx_internal function getVerticalAlignValue():Number
        {
            var _local_1:String = target.getStyle("verticalAlign");
            if (_local_1 == "middle")
            {
                return (0.5);
            };
            if (_local_1 == "bottom")
            {
                return (1);
            };
            return (0);
        }

        mx_internal function heightPadding(_arg_1:Number):Number
        {
            var _local_2:EdgeMetrics = target.viewMetricsAndPadding;
            var _local_3:Number = (_local_2.top + _local_2.bottom);
            if (((_arg_1 > 1) && (isVertical())))
            {
                _local_3 = (_local_3 + (target.getStyle("verticalGap") * (_arg_1 - 1)));
            };
            return (_local_3);
        }

        mx_internal function widthPadding(_arg_1:Number):Number
        {
            var _local_2:EdgeMetrics = target.viewMetricsAndPadding;
            var _local_3:Number = (_local_2.left + _local_2.right);
            if (((_arg_1 > 1) && (isVertical() == false)))
            {
                _local_3 = (_local_3 + (target.getStyle("horizontalGap") * (_arg_1 - 1)));
            };
            return (_local_3);
        }

        override public function measure():void
        {
            var _local_1:Container;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:IUIComponent;
            var _local_13:Number;
            var _local_14:Number;
            _local_1 = super.target;
            var _local_2:Boolean = isVertical();
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:int = _local_1.numChildren;
            var _local_8:int = _local_7;
            var _local_9:int;
            while (_local_9 < _local_7)
            {
                _local_12 = IUIComponent(_local_1.getChildAt(_local_9));
                if (!_local_12.includeInLayout)
                {
                    _local_8--;
                }
                else
                {
                    _local_13 = _local_12.getExplicitOrMeasuredWidth();
                    _local_14 = _local_12.getExplicitOrMeasuredHeight();
                    if (_local_2)
                    {
                        _local_3 = Math.max(((isNaN(_local_12.percentWidth)) ? _local_13 : _local_12.minWidth), _local_3);
                        _local_5 = Math.max(_local_13, _local_5);
                        _local_4 = (_local_4 + ((isNaN(_local_12.percentHeight)) ? _local_14 : _local_12.minHeight));
                        _local_6 = (_local_6 + _local_14);
                    }
                    else
                    {
                        _local_3 = (_local_3 + ((isNaN(_local_12.percentWidth)) ? _local_13 : _local_12.minWidth));
                        _local_5 = (_local_5 + _local_13);
                        _local_4 = Math.max(((isNaN(_local_12.percentHeight)) ? _local_14 : _local_12.minHeight), _local_4);
                        _local_6 = Math.max(_local_14, _local_6);
                    };
                };
                _local_9++;
            };
            _local_10 = widthPadding(_local_8);
            _local_11 = heightPadding(_local_8);
            _local_1.measuredMinWidth = (_local_3 + _local_10);
            _local_1.measuredMinHeight = (_local_4 + _local_11);
            _local_1.measuredWidth = (_local_5 + _local_10);
            _local_1.measuredHeight = (_local_6 + _local_11);
        }


    }
}//package mx.containers.utilityClasses

