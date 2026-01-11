// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.FormItem

package mx.containers
{
    import mx.core.Container;
    import mx.containers.utilityClasses.BoxLayout;
    import mx.controls.Label;
    import mx.core.IFlexDisplayObject;
    import mx.core.ScrollPolicy;
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IUIComponent;
    import mx.core.EdgeMetrics;
    import mx.containers.utilityClasses.Flex;
    import mx.controls.FormItemLabel;
    import flash.events.Event;
    import mx.core.FlexVersion;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class FormItem extends Container 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _direction:String = "vertical";
        private var guessedNumColumns:int;
        private var _required:Boolean = false;
        mx_internal var verticalLayoutObject:BoxLayout = new BoxLayout();
        private var labelChanged:Boolean = false;
        private var guessedRowWidth:Number;
        private var labelObj:Label;
        private var numberOfGuesses:int = 0;
        private var indicatorObj:IFlexDisplayObject;
        private var _label:String = "";

        public function FormItem()
        {
            _horizontalScrollPolicy = ScrollPolicy.OFF;
            _verticalScrollPolicy = ScrollPolicy.OFF;
            verticalLayoutObject.target = this;
            verticalLayoutObject.direction = BoxDirection.VERTICAL;
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:CSSStyleDeclaration;
            super.styleChanged(_arg_1);
            var _local_2:Boolean = ((_arg_1 == null) || (_arg_1 == "styleName"));
            if (((_local_2) || (_arg_1 == "labelStyleName")))
            {
                if (labelObj)
                {
                    _local_3 = getStyle("labelStyleName");
                    if (_local_3)
                    {
                        _local_4 = StyleManager.getStyleDeclaration(("." + _local_3));
                        if (_local_4)
                        {
                            labelObj.styleDeclaration = _local_4;
                            labelObj.regenerateStyleCache(true);
                        };
                    };
                };
            };
        }

        mx_internal function getHorizontalAlignValue():Number
        {
            var _local_1:String = getStyle("horizontalAlign");
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

        private function calcNumColumns(_arg_1:Number):int
        {
            var _local_7:IUIComponent;
            var _local_8:Number;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:Number = getStyle("horizontalGap");
            if (direction != FormItemDirection.HORIZONTAL)
            {
                return (1);
            };
            var _local_5:Number = numChildren;
            var _local_6:int;
            while (_local_6 < numChildren)
            {
                _local_7 = IUIComponent(getChildAt(_local_6));
                if (!_local_7.includeInLayout)
                {
                    _local_5--;
                }
                else
                {
                    _local_8 = _local_7.getExplicitOrMeasuredWidth();
                    _local_3 = Math.max(_local_3, _local_8);
                    _local_2 = (_local_2 + _local_8);
                    if (_local_6 > 0)
                    {
                        _local_2 = (_local_2 + _local_4);
                    };
                };
                _local_6++;
            };
            if (((isNaN(_arg_1)) || (_local_2 <= _arg_1)))
            {
                return (_local_5);
            };
            if ((_local_3 * 2) <= _arg_1)
            {
                return (2);
            };
            return (1);
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (labelChanged)
            {
                labelObj.text = label;
                labelObj.validateSize();
                labelChanged = false;
            };
        }

        mx_internal function get labelObject():Object
        {
            return (labelObj);
        }

        private function previousUpdateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_10:int;
            var _local_11:IUIComponent;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_19:Number;
            var _local_20:int;
            var _local_21:Number;
            var _local_22:int;
            var _local_23:Number;
            var _local_24:Number;
            var _local_25:Number;
            var _local_26:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:EdgeMetrics = viewMetricsAndPadding;
            var _local_4:Number = _local_3.left;
            var _local_5:Number = _local_3.top;
            var _local_6:Number = _local_5;
            var _local_7:Number = calculateLabelWidth();
            var _local_8:Number = getStyle("indicatorGap");
            var _local_9:String = getStyle("horizontalAlign");
            if (_local_9 == "right")
            {
                _local_16 = 1;
            }
            else
            {
                if (_local_9 == "center")
                {
                    _local_16 = 0.5;
                }
                else
                {
                    _local_16 = 0;
                };
            };
            var _local_17:int = numChildren;
            if (_local_17 > 0)
            {
                _local_11 = IUIComponent(getChildAt(0));
                _local_12 = _local_11.baselinePosition;
                if (!isNaN(_local_12))
                {
                    _local_6 = (_local_6 + (_local_12 - labelObj.baselinePosition));
                };
            };
            labelObj.setActualSize(_local_7, labelObj.getExplicitOrMeasuredHeight());
            labelObj.move(_local_4, _local_6);
            _local_4 = (_local_4 + _local_7);
            displayIndicator(_local_4, _local_6);
            _local_4 = (_local_4 + _local_8);
            var _local_18:Number = ((_arg_1 - _local_3.right) - _local_4);
            if (_local_18 < 0)
            {
                _local_18 = 0;
            };
            if (direction == FormItemDirection.HORIZONTAL)
            {
                _local_19 = 0;
                _local_20 = calcNumColumns(_local_18);
                _local_22 = 0;
                _local_14 = getStyle("horizontalGap");
                _local_15 = getStyle("verticalGap");
                if (((!(_local_20 == guessedNumColumns)) && (numberOfGuesses == 0)))
                {
                    guessedRowWidth = _local_18;
                    numberOfGuesses = 1;
                    invalidateSize();
                }
                else
                {
                    numberOfGuesses = 0;
                };
                if (_local_20 == _local_17)
                {
                    _local_23 = (height - (_local_5 + _local_3.bottom));
                    _local_24 = Flex.flexChildWidthsProportionally(this, (_local_18 - ((_local_17 - 1) * _local_14)), _local_23);
                    _local_4 = (_local_4 + (_local_24 * _local_16));
                    _local_10 = 0;
                    while (_local_10 < _local_17)
                    {
                        _local_11 = IUIComponent(getChildAt(_local_10));
                        _local_11.move(Math.floor(_local_4), _local_5);
                        _local_4 = (_local_4 + (_local_11.width + _local_14));
                        _local_10++;
                    };
                }
                else
                {
                    _local_10 = 0;
                    while (_local_10 < _local_17)
                    {
                        _local_11 = IUIComponent(getChildAt(_local_10));
                        _local_19 = Math.max(_local_19, _local_11.getExplicitOrMeasuredWidth());
                        _local_10++;
                    };
                    _local_25 = (_local_18 - ((_local_20 * _local_19) + ((_local_20 - 1) * _local_14)));
                    if (_local_25 < 0)
                    {
                        _local_25 = 0;
                    };
                    _local_4 = (_local_4 + (_local_25 * _local_16));
                    _local_21 = _local_4;
                    _local_10 = 0;
                    while (_local_10 < _local_17)
                    {
                        _local_11 = IUIComponent(getChildAt(_local_10));
                        _local_13 = Math.min(_local_19, _local_11.getExplicitOrMeasuredWidth());
                        _local_11.setActualSize(_local_13, _local_11.getExplicitOrMeasuredHeight());
                        _local_11.move(_local_21, _local_5);
                        if (++_local_22 >= _local_20)
                        {
                            _local_21 = _local_4;
                            _local_22 = 0;
                            _local_5 = (_local_5 + (_local_11.height + _local_15));
                        }
                        else
                        {
                            _local_21 = (_local_21 + (_local_19 + _local_14));
                        };
                        _local_10++;
                    };
                };
            }
            else
            {
                _local_15 = getStyle("verticalGap");
                _local_10 = 0;
                while (_local_10 < _local_17)
                {
                    _local_11 = IUIComponent(getChildAt(_local_10));
                    if (!isNaN(_local_11.percentWidth))
                    {
                        _local_13 = Math.floor(((_local_18 * Math.min(_local_11.percentWidth, 100)) / 100));
                    }
                    else
                    {
                        _local_13 = _local_11.getExplicitOrMeasuredWidth();
                        if (isNaN(_local_11.explicitWidth))
                        {
                            if (_local_13 < Math.floor((_local_18 * 0.25)))
                            {
                                _local_13 = Math.floor((_local_18 * 0.25));
                            }
                            else
                            {
                                if (_local_13 < Math.floor((_local_18 * 0.5)))
                                {
                                    _local_13 = Math.floor((_local_18 * 0.5));
                                }
                                else
                                {
                                    if (_local_13 < Math.floor((_local_18 * 0.75)))
                                    {
                                        _local_13 = Math.floor((_local_18 * 0.75));
                                    }
                                    else
                                    {
                                        if (_local_13 < Math.floor(_local_18))
                                        {
                                            _local_13 = Math.floor(_local_18);
                                        };
                                    };
                                };
                            };
                        };
                    };
                    _local_11.setActualSize(_local_13, _local_11.getExplicitOrMeasuredHeight());
                    _local_26 = ((_local_18 - _local_13) * _local_16);
                    _local_11.move((_local_4 + _local_26), _local_5);
                    _local_5 = (_local_5 + _local_11.height);
                    _local_5 = (_local_5 + _local_15);
                    _local_10++;
                };
            };
            _local_6 = _local_3.top;
            if (_local_17 > 0)
            {
                _local_11 = IUIComponent(getChildAt(0));
                _local_12 = _local_11.baselinePosition;
                if (!isNaN(_local_12))
                {
                    _local_6 = (_local_6 + (_local_12 - labelObj.baselinePosition));
                };
            };
            labelObj.move(labelObj.x, _local_6);
        }

        override protected function createChildren():void
        {
            var _local_1:String;
            var _local_2:CSSStyleDeclaration;
            super.createChildren();
            if (!labelObj)
            {
                labelObj = new FormItemLabel();
                _local_1 = getStyle("labelStyleName");
                if (_local_1)
                {
                    _local_2 = StyleManager.getStyleDeclaration(("." + _local_1));
                    if (_local_2)
                    {
                        labelObj.styleDeclaration = _local_2;
                    };
                };
                rawChildren.addChild(labelObj);
                dispatchEvent(new Event("itemLabelChanged"));
            };
        }

        internal function getPreferredLabelWidth():Number
        {
            if (((!(label)) || (label == "")))
            {
                return (0);
            };
            if (isNaN(labelObj.measuredWidth))
            {
                labelObj.validateSize();
            };
            var _local_1:Number = labelObj.measuredWidth;
            if (isNaN(_local_1))
            {
                return (0);
            };
            return (_local_1);
        }

        override protected function measure():void
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                previousMeasure();
                return;
            };
            super.measure();
            if (direction == FormItemDirection.VERTICAL)
            {
                measureVertical();
            }
            else
            {
                measureHorizontal();
            };
        }

        [Bindable("itemLabelChanged")]
        public function get itemLabel():Label
        {
            return (labelObj);
        }

        [Bindable("requiredChanged")]
        public function get required():Boolean
        {
            return (_required);
        }

        private function previousMeasure():void
        {
            var _local_12:Number;
            var _local_13:Number;
            var _local_16:int;
            var _local_17:IUIComponent;
            super.measure();
            var _local_1:int = (guessedNumColumns = calcNumColumns(guessedRowWidth));
            var _local_2:Number = getStyle("horizontalGap");
            var _local_3:Number = getStyle("verticalGap");
            var _local_4:Number = getStyle("indicatorGap");
            var _local_5:int;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            var _local_8:Number = 0;
            var _local_9:Number = 0;
            var _local_10:Number = 0;
            var _local_11:Number = 0;
            _local_12 = 0;
            _local_13 = 0;
            var _local_14:Number = 0;
            var _local_15:int = numChildren;
            if (((direction == FormItemDirection.HORIZONTAL) && (_local_1 < _local_15)))
            {
                _local_16 = 0;
                while (_local_16 < _local_15)
                {
                    _local_17 = IUIComponent(getChildAt(_local_16));
                    _local_14 = Math.max(_local_14, _local_17.getExplicitOrMeasuredWidth());
                    _local_16++;
                };
            };
            _local_16 = 0;
            while (_local_16 < _local_15)
            {
                _local_17 = IUIComponent(getChildAt(_local_16));
                if (_local_5 < _local_1)
                {
                    _local_6 = (_local_6 + ((isNaN(_local_17.percentWidth)) ? _local_17.getExplicitOrMeasuredWidth() : _local_17.minWidth));
                    _local_7 = (_local_7 + ((_local_14 > 0) ? _local_14 : _local_17.getExplicitOrMeasuredWidth()));
                    if (_local_5 > 0)
                    {
                        _local_6 = (_local_6 + _local_2);
                        _local_7 = (_local_7 + _local_2);
                    };
                    _local_8 = Math.max(_local_8, ((isNaN(_local_17.percentHeight)) ? _local_17.getExplicitOrMeasuredHeight() : _local_17.minHeight));
                    _local_9 = Math.max(_local_9, _local_17.getExplicitOrMeasuredHeight());
                };
                if (((++_local_5 >= _local_1) || (_local_16 == (_local_15 - 1))))
                {
                    _local_10 = Math.max(_local_10, _local_6);
                    _local_12 = Math.max(_local_12, _local_7);
                    _local_11 = (_local_11 + _local_8);
                    _local_13 = (_local_13 + _local_9);
                    if (_local_16 > 0)
                    {
                        _local_11 = (_local_11 + _local_3);
                        _local_13 = (_local_13 + _local_3);
                    };
                    _local_5 = 0;
                    _local_6 = 0;
                    _local_7 = 0;
                    _local_8 = 0;
                    _local_9 = 0;
                };
                _local_16++;
            };
            var _local_18:Number = (calculateLabelWidth() + _local_4);
            _local_10 = (_local_10 + _local_18);
            _local_12 = (_local_12 + _local_18);
            if (((!(label == null)) && (!(label == ""))))
            {
                _local_11 = Math.max(_local_11, labelObj.getExplicitOrMeasuredHeight());
                _local_13 = Math.max(_local_13, labelObj.getExplicitOrMeasuredHeight());
            };
            var _local_19:EdgeMetrics = viewMetricsAndPadding;
            _local_11 = (_local_11 + (_local_19.top + _local_19.bottom));
            _local_10 = (_local_10 + (_local_19.left + _local_19.right));
            _local_13 = (_local_13 + (_local_19.top + _local_19.bottom));
            _local_12 = (_local_12 + (_local_19.left + _local_19.right));
            measuredMinWidth = _local_10;
            measuredMinHeight = _local_11;
            measuredWidth = _local_12;
            measuredHeight = _local_13;
        }

        private function measureHorizontal():void
        {
            var _local_10:Number;
            var _local_12:Number;
            var _local_14:int;
            var _local_16:IUIComponent;
            var _local_1:int = (guessedNumColumns = calcNumColumns(guessedRowWidth));
            var _local_2:Number = getStyle("horizontalGap");
            var _local_3:Number = getStyle("verticalGap");
            var _local_4:Number = getStyle("indicatorGap");
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            var _local_8:Number = 0;
            var _local_9:Number = 0;
            _local_10 = 0;
            var _local_11:Number = 0;
            _local_12 = 0;
            var _local_13:Number = 0;
            var _local_15:int;
            if (_local_1 < numChildren)
            {
                _local_14 = 0;
                while (_local_14 < numChildren)
                {
                    _local_16 = IUIComponent(getChildAt(_local_14));
                    if (_local_16.includeInLayout)
                    {
                        _local_13 = Math.max(_local_13, _local_16.getExplicitOrMeasuredWidth());
                    };
                    _local_14++;
                };
            };
            var _local_17:int;
            _local_14 = 0;
            while (_local_14 < numChildren)
            {
                _local_16 = IUIComponent(getChildAt(_local_14));
                if (_local_16.includeInLayout)
                {
                    _local_5 = (_local_5 + ((isNaN(_local_16.percentWidth)) ? _local_16.getExplicitOrMeasuredWidth() : _local_16.minWidth));
                    _local_6 = (_local_6 + ((_local_13 > 0) ? _local_13 : _local_16.getExplicitOrMeasuredWidth()));
                    if (_local_15 > 0)
                    {
                        _local_5 = (_local_5 + _local_2);
                        _local_6 = (_local_6 + _local_2);
                    };
                    _local_7 = Math.max(_local_7, ((isNaN(_local_16.percentHeight)) ? _local_16.getExplicitOrMeasuredHeight() : _local_16.minHeight));
                    _local_8 = Math.max(_local_8, _local_16.getExplicitOrMeasuredHeight());
                    if (((++_local_15 >= _local_1) || (_local_14 == (numChildren - 1))))
                    {
                        _local_9 = Math.max(_local_9, _local_5);
                        _local_11 = Math.max(_local_11, _local_6);
                        _local_10 = (_local_10 + _local_7);
                        _local_12 = (_local_12 + _local_8);
                        if (_local_17 > 0)
                        {
                            _local_10 = (_local_10 + _local_3);
                            _local_12 = (_local_12 + _local_3);
                        };
                        _local_15 = 0;
                        _local_17++;
                        _local_5 = 0;
                        _local_6 = 0;
                        _local_7 = 0;
                        _local_8 = 0;
                    };
                };
                _local_14++;
            };
            var _local_18:Number = (calculateLabelWidth() + _local_4);
            _local_9 = (_local_9 + _local_18);
            _local_11 = (_local_11 + _local_18);
            if (((!(label == null)) && (!(label == ""))))
            {
                _local_10 = Math.max(_local_10, labelObj.getExplicitOrMeasuredHeight());
                _local_12 = Math.max(_local_12, labelObj.getExplicitOrMeasuredHeight());
            };
            var _local_19:EdgeMetrics = viewMetricsAndPadding;
            _local_10 = (_local_10 + (_local_19.top + _local_19.bottom));
            _local_9 = (_local_9 + (_local_19.left + _local_19.right));
            _local_12 = (_local_12 + (_local_19.top + _local_19.bottom));
            _local_11 = (_local_11 + (_local_19.left + _local_19.right));
            measuredMinWidth = _local_9;
            measuredMinHeight = _local_10;
            measuredWidth = _local_11;
            measuredHeight = _local_12;
        }

        public function set required(_arg_1:Boolean):void
        {
            if (_arg_1 != _required)
            {
                _required = _arg_1;
                invalidateDisplayList();
                dispatchEvent(new Event("requiredChanged"));
            };
        }

        private function updateDisplayListVerticalChildren(_arg_1:Number, _arg_2:Number):void
        {
            var _local_5:IUIComponent;
            var _local_3:Number = (calculateLabelWidth() + getStyle("indicatorGap"));
            if (!isNaN(explicitMinWidth))
            {
                _explicitMinWidth = (_explicitMinWidth - _local_3);
            }
            else
            {
                if (!isNaN(measuredMinWidth))
                {
                    measuredMinWidth = (measuredMinWidth - _local_3);
                };
            };
            verticalLayoutObject.updateDisplayList((_arg_1 - _local_3), _arg_2);
            if (!isNaN(explicitMinWidth))
            {
                _explicitMinWidth = (_explicitMinWidth + _local_3);
            }
            else
            {
                if (!isNaN(measuredMinWidth))
                {
                    measuredMinWidth = (measuredMinWidth + _local_3);
                };
            };
            var _local_4:Number = numChildren;
            var _local_6:Number = 0;
            while (_local_6 < _local_4)
            {
                _local_5 = IUIComponent(getChildAt(_local_6));
                _local_5.move((_local_5.x + _local_3), _local_5.y);
                _local_6++;
            };
        }

        private function displayIndicator(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Class;
            if (required)
            {
                if (!indicatorObj)
                {
                    _local_3 = (getStyle("indicatorSkin") as Class);
                    indicatorObj = IFlexDisplayObject(new (_local_3)());
                    rawChildren.addChild(DisplayObject(indicatorObj));
                };
                indicatorObj.x = (_arg_1 + ((getStyle("indicatorGap") - indicatorObj.width) / 2));
                if (labelObj)
                {
                    indicatorObj.y = (_arg_2 + ((labelObj.getExplicitOrMeasuredHeight() - indicatorObj.measuredHeight) / 2));
                };
            }
            else
            {
                if (indicatorObj)
                {
                    rawChildren.removeChild(DisplayObject(indicatorObj));
                    indicatorObj = null;
                };
            };
        }

        override public function set label(_arg_1:String):void
        {
            _label = _arg_1;
            labelChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            if ((parent is Form))
            {
                Form(parent).invalidateLabelWidth();
            };
            dispatchEvent(new Event("labelChanged"));
        }

        private function updateDisplayListHorizontalChildren(_arg_1:Number, _arg_2:Number):void
        {
            var _local_17:int;
            var _local_18:IUIComponent;
            var _local_19:Number;
            var _local_20:Number;
            var _local_27:Number;
            var _local_28:Number;
            var _local_29:Number;
            var _local_30:Number;
            var _local_32:Number;
            var _local_33:Number;
            var _local_34:Number;
            var _local_35:Number;
            var _local_36:Number;
            var _local_37:Number;
            var _local_38:Number;
            var _local_39:Boolean;
            var _local_40:Array;
            var _local_41:Number;
            var _local_42:*;
            var _local_43:*;
            var _local_44:*;
            var _local_3:EdgeMetrics = viewMetricsAndPadding;
            var _local_4:Number = calculateLabelWidth();
            var _local_5:Number = getStyle("indicatorGap");
            var _local_6:Number = getStyle("horizontalGap");
            var _local_7:Number = getStyle("verticalGap");
            var _local_8:Number = getStyle("paddingLeft");
            var _local_9:Number = getStyle("paddingTop");
            var _local_10:Number = getHorizontalAlignValue();
            var _local_11:Number = (((scaleX > 0) && (!(scaleX == 1))) ? (minWidth / Math.abs(scaleX)) : minWidth);
            var _local_12:Number = (((scaleY > 0) && (!(scaleY == 1))) ? (minHeight / Math.abs(scaleY)) : minHeight);
            var _local_13:Number = ((Math.max(_arg_1, _local_11) - _local_3.left) - _local_3.right);
            var _local_14:Number = ((Math.max(_arg_2, _local_12) - _local_3.top) - _local_3.bottom);
            var _local_15:Number = 0;
            var _local_16:Number = ((_local_13 - _local_4) - _local_5);
            if (_local_16 < 0)
            {
                _local_16 = 0;
            };
            var _local_21:int = calcNumColumns(_local_16);
            var _local_22:int;
            if (((!(_local_21 == guessedNumColumns)) && (isNaN(explicitWidth))))
            {
                if (numberOfGuesses < 2)
                {
                    guessedRowWidth = _local_16;
                    numberOfGuesses++;
                    invalidateSize();
                    return;
                };
                _local_21 = guessedNumColumns;
                numberOfGuesses = 0;
            }
            else
            {
                numberOfGuesses = 0;
            };
            var _local_23:Number = ((_local_8 + _local_4) + _local_5);
            var _local_24:Number = _local_9;
            var _local_25:Number = _local_23;
            var _local_26:Number = _local_24;
            var _local_31:int = numChildren;
            _local_17 = 0;
            while (_local_17 < numChildren)
            {
                if (!IUIComponent(getChildAt(_local_17)).includeInLayout)
                {
                    _local_31--;
                };
                _local_17++;
            };
            if (_local_21 == _local_31)
            {
                _local_32 = Flex.flexChildWidthsProportionally(this, (_local_16 - ((_local_31 - 1) * _local_6)), _local_14);
                _local_23 = (_local_23 + (_local_32 * _local_10));
                _local_17 = 0;
                while (_local_17 < numChildren)
                {
                    _local_18 = IUIComponent(getChildAt(_local_17));
                    if (_local_18.includeInLayout)
                    {
                        _local_18.move(Math.floor(_local_23), _local_24);
                        _local_23 = (_local_23 + (_local_18.width + _local_6));
                    };
                    _local_17++;
                };
            }
            else
            {
                _local_17 = 0;
                while (_local_17 < numChildren)
                {
                    _local_18 = IUIComponent(getChildAt(_local_17));
                    if (_local_18.includeInLayout)
                    {
                        _local_27 = _local_18.getExplicitOrMeasuredWidth();
                        _local_29 = _local_18.percentWidth;
                        _local_19 = ((isNaN(_local_29)) ? _local_27 : ((_local_29 * _local_16) / 100));
                        _local_19 = Math.max(_local_18.minWidth, Math.min(_local_18.maxWidth, _local_19));
                        _local_15 = Math.max(_local_15, _local_19);
                    };
                    _local_17++;
                };
                _local_15 = Math.min(_local_15, Math.floor(((_local_16 - ((_local_21 - 1) * _local_6)) / _local_21)));
                _local_33 = (_local_16 - ((_local_21 * _local_15) + ((_local_21 - 1) * _local_6)));
                if (_local_33 < 0)
                {
                    _local_33 = 0;
                };
                _local_23 = (_local_23 + (_local_33 * _local_10));
                _local_34 = 0;
                _local_35 = 0;
                _local_36 = 0;
                _local_37 = _local_14;
                _local_38 = _local_37;
                _local_22 = 0;
                _local_17 = 0;
                while (_local_17 < numChildren)
                {
                    _local_18 = IUIComponent(getChildAt(_local_17));
                    if (!_local_18.includeInLayout)
                    {
                        if (_local_17 == (numChildren - 1))
                        {
                            _local_38 = (_local_38 - _local_35);
                            if (_local_17 != (numChildren - 1))
                            {
                                _local_38 = (_local_38 - _local_7);
                            };
                            if (((_local_35 > 0) && (_local_34 > 0)))
                            {
                                _local_34 = Math.max(0, (_local_34 - ((100 * _local_35) / _local_37)));
                            };
                            _local_36 = (_local_36 + _local_34);
                            _local_35 = 0;
                            _local_34 = 0;
                            _local_22 = 0;
                        };
                    }
                    else
                    {
                        if (!isNaN(_local_18.percentHeight))
                        {
                            _local_34 = Math.max(_local_34, _local_18.percentHeight);
                        }
                        else
                        {
                            _local_35 = Math.max(_local_35, _local_18.getExplicitOrMeasuredHeight());
                        };
                        if (((++_local_22 >= _local_21) || (_local_17 == (numChildren - 1))))
                        {
                            _local_38 = (_local_38 - _local_35);
                            if (_local_17 != (numChildren - 1))
                            {
                                _local_38 = (_local_38 - _local_7);
                            };
                            if (((_local_35 > 0) && (_local_34 > 0)))
                            {
                                _local_34 = Math.max(0, (_local_34 - ((100 * _local_35) / _local_37)));
                            };
                            _local_36 = (_local_36 + _local_34);
                            _local_35 = 0;
                            _local_34 = 0;
                            _local_22 = 0;
                        };
                    };
                    _local_17++;
                };
                _local_39 = false;
                _local_40 = new Array(numChildren);
                _local_17 = 0;
                while (_local_17 < numChildren)
                {
                    _local_40[_local_17] = -1;
                    _local_17++;
                };
                _local_41 = (_local_38 - ((_local_37 * _local_36) / 100));
                if (_local_41 > 0)
                {
                    _local_38 = (_local_38 - _local_41);
                };
                do 
                {
                    _local_39 = true;
                    _local_42 = (_local_38 / _local_36);
                    _local_22 = 0;
                    _local_25 = _local_23;
                    _local_26 = _local_24;
                    _local_43 = 0;
                    _local_17 = 0;
                    while (_local_17 < numChildren)
                    {
                        _local_18 = IUIComponent(getChildAt(_local_17));
                        if (_local_18.includeInLayout)
                        {
                            _local_27 = _local_18.getExplicitOrMeasuredWidth();
                            _local_28 = _local_18.getExplicitOrMeasuredHeight();
                            _local_29 = _local_18.percentWidth;
                            _local_30 = _local_18.percentHeight;
                            _local_19 = Math.min(_local_15, ((isNaN(_local_29)) ? _local_27 : ((_local_29 * _local_16) / 100)));
                            _local_19 = Math.max(_local_18.minWidth, Math.min(_local_18.maxWidth, _local_19));
                            if (_local_40[_local_17] != -1)
                            {
                                _local_20 = _local_40[_local_17];
                            }
                            else
                            {
                                _local_20 = ((isNaN(_local_30)) ? _local_28 : (_local_30 * _local_42));
                                if (_local_20 < _local_18.minHeight)
                                {
                                    _local_20 = _local_18.minHeight;
                                    _local_36 = (_local_36 - _local_18.percentHeight);
                                    _local_38 = (_local_38 - _local_20);
                                    _local_40[_local_17] = _local_20;
                                    _local_39 = false;
                                    break;
                                };
                                if (_local_20 > _local_18.maxHeight)
                                {
                                    _local_20 = _local_18.maxHeight;
                                    _local_36 = (_local_36 - _local_18.percentHeight);
                                    _local_38 = (_local_38 - _local_20);
                                    _local_40[_local_17] = _local_20;
                                    _local_39 = false;
                                    break;
                                };
                            };
                            if (((_local_18.scaleX == 1) && (_local_18.scaleY == 1)))
                            {
                                _local_18.setActualSize(Math.floor(_local_19), Math.floor(_local_20));
                            }
                            else
                            {
                                _local_18.setActualSize(_local_19, _local_20);
                            };
                            _local_44 = ((_local_15 - _local_18.width) * _local_10);
                            _local_18.move(Math.floor((_local_25 + _local_44)), Math.floor(_local_26));
                            _local_43 = Math.max(_local_43, _local_18.height);
                            if (++_local_22 >= _local_21)
                            {
                                _local_25 = _local_23;
                                _local_22 = 0;
                                _local_26 = (_local_26 + (_local_43 + _local_7));
                                _local_43 = 0;
                            }
                            else
                            {
                                _local_25 = (_local_25 + (_local_15 + _local_6));
                            };
                        };
                        _local_17++;
                    };
                } while ((!(_local_39)));
            };
        }

        [Bindable("labelChanged")]
        override public function get label():String
        {
            return (_label);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_7:IUIComponent;
            var _local_8:Number;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                previousUpdateDisplayList(_arg_1, _arg_2);
                return;
            };
            super.updateDisplayList(_arg_1, _arg_2);
            if (direction == FormItemDirection.VERTICAL)
            {
                updateDisplayListVerticalChildren(_arg_1, _arg_2);
            }
            else
            {
                updateDisplayListHorizontalChildren(_arg_1, _arg_2);
            };
            var _local_3:EdgeMetrics = viewMetricsAndPadding;
            var _local_4:Number = _local_3.left;
            var _local_5:Number = _local_3.top;
            var _local_6:Number = calculateLabelWidth();
            if (numChildren > 0)
            {
                _local_7 = IUIComponent(getChildAt(0));
                _local_8 = _local_7.baselinePosition;
                if (!isNaN(_local_8))
                {
                    _local_5 = (_local_5 + (_local_8 - labelObj.baselinePosition));
                };
            };
            labelObj.setActualSize(_local_6, labelObj.getExplicitOrMeasuredHeight());
            labelObj.move(_local_4, _local_5);
            _local_4 = (_local_4 + _local_6);
            displayIndicator(_local_4, _local_5);
        }

        private function calculateLabelWidth():Number
        {
            var _local_1:Number = getStyle("labelWidth");
            if (_local_1 == 0)
            {
                _local_1 = NaN;
            };
            if (((isNaN(_local_1)) && (parent is Form)))
            {
                _local_1 = Form(parent).calculateLabelWidth();
            };
            if (isNaN(_local_1))
            {
                _local_1 = getPreferredLabelWidth();
            };
            return (_local_1);
        }

        private function measureVertical():void
        {
            var _local_2:Number;
            verticalLayoutObject.measure();
            var _local_1:Number = (calculateLabelWidth() + getStyle("indicatorGap"));
            measuredMinWidth = (measuredMinWidth + _local_1);
            measuredWidth = (measuredWidth + _local_1);
            _local_2 = labelObj.getExplicitOrMeasuredHeight();
            measuredMinHeight = Math.max(measuredMinHeight, _local_2);
            measuredHeight = Math.max(measuredHeight, _local_2);
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

