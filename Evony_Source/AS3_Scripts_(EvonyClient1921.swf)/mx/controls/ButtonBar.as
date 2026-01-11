// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.ButtonBar

package mx.controls
{
    import mx.managers.IFocusManagerComponent;
    import flash.events.Event;
    import mx.core.ClassFactory;
    import mx.controls.buttonBarClasses.ButtonBarButton;
    import mx.events.ChildExistenceChangedEvent;
    import mx.core.EdgeMetrics;
    import flash.events.EventPhase;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import mx.containers.BoxDirection;
    import mx.core.IUIComponent;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import mx.core.IFlexDisplayObject;
    import mx.styles.StyleManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ButtonBar extends NavBar implements IFocusManagerComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        mx_internal var simulatedClickTriggerEvent:Event = null;
        mx_internal var focusedIndex:int = 0;
        private var directionChanged:Boolean = false;
        mx_internal var buttonWidthProp:String = "buttonWidth";
        private var oldUnscaledHeight:Number;
        mx_internal var buttonStyleNameProp:String = "buttonStyleName";
        mx_internal var lastButtonStyleNameProp:String = "lastButtonStyleName";
        private var recalcButtonWidths:Boolean = false;
        private var oldUnscaledWidth:Number;
        private var recalcButtonHeights:Boolean = false;
        mx_internal var buttonHeightProp:String = "buttonHeight";
        mx_internal var firstButtonStyleNameProp:String = "firstButtonStyleName";

        public function ButtonBar()
        {
            tabEnabled = true;
            navItemFactory = new ClassFactory(ButtonBarButton);
            addEventListener("scaleXChanged", scaleChangedHandler);
            addEventListener("scaleYChanged", scaleChangedHandler);
            addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);
        }

        override public function get borderMetrics():EdgeMetrics
        {
            return (EdgeMetrics.EMPTY);
        }

        protected function resetButtonHeights():void
        {
            var _local_2:Button;
            var _local_1:int;
            while (_local_1 < numChildren)
            {
                _local_2 = (getChildAt(_local_1) as Button);
                if (_local_2)
                {
                    _local_2.explicitHeight = NaN;
                    _local_2.minHeight = NaN;
                    _local_2.maxHeight = NaN;
                };
                _local_1++;
            };
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:Button;
            if (_arg_1.eventPhase != EventPhase.AT_TARGET)
            {
                return;
            };
            switch (_arg_1.keyCode)
            {
                case Keyboard.SPACE:
                    if (focusedIndex != -1)
                    {
                        _local_2 = Button(getChildAt(focusedIndex));
                        _local_2.dispatchEvent(_arg_1);
                    };
                    _arg_1.stopPropagation();
                    return;
            };
        }

        mx_internal function nextIndex(_arg_1:int):int
        {
            var _local_2:int = numChildren;
            if (_local_2 == 0)
            {
                return (-1);
            };
            return ((_arg_1 == (_local_2 - 1)) ? 0 : (_arg_1 + 1));
        }

        private function calcFullWidth():Number
        {
            var _local_6:Number;
            var _local_8:Number;
            var _local_1:int = numChildren;
            var _local_2:Number = 0;
            if (_local_1 == 0)
            {
                return (0);
            };
            if (_local_1 > 1)
            {
                _local_2 = getStyle("horizontalGap");
            };
            var _local_3:* = (direction == BoxDirection.HORIZONTAL);
            var _local_4:Number = getStyle(buttonWidthProp);
            var _local_5:IUIComponent = IUIComponent(getChildAt(0));
            if (_local_4)
            {
                _local_6 = ((isNaN(_local_5.explicitWidth)) ? _local_4 : _local_5.explicitWidth);
            }
            else
            {
                _local_6 = _local_5.getExplicitOrMeasuredWidth();
            };
            var _local_7:int = 1;
            while (_local_7 < _local_1)
            {
                _local_5 = IUIComponent(getChildAt(_local_7));
                if (_local_4)
                {
                    _local_8 = ((isNaN(_local_5.explicitWidth)) ? _local_4 : _local_5.explicitWidth);
                }
                else
                {
                    _local_8 = _local_5.getExplicitOrMeasuredWidth();
                };
                if (_local_3)
                {
                    _local_6 = (_local_6 + (_local_2 + _local_8));
                }
                else
                {
                    _local_6 = Math.max(_local_6, _local_8);
                };
                _local_7++;
            };
            return (_local_6);
        }

        override protected function clickHandler(_arg_1:MouseEvent):void
        {
            if (simulatedClickTriggerEvent == null)
            {
                focusedIndex = getChildIndex(DisplayObject(_arg_1.currentTarget));
                drawButtonFocus(focusedIndex, true);
            };
            super.clickHandler(_arg_1);
        }

        override protected function createNavItem(_arg_1:String, _arg_2:Class=null):IFlexDisplayObject
        {
            var _local_3:Button = Button(navItemFactory.newInstance());
            _local_3.focusEnabled = false;
            _local_3.label = _arg_1;
            _local_3.setStyle("icon", _arg_2);
            _local_3.addEventListener(MouseEvent.CLICK, clickHandler);
            addChild(_local_3);
            recalcButtonWidths = (recalcButtonHeights = true);
            return (_local_3);
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_2:Boolean = ((_arg_1 == null) || (_arg_1 == "styleName"));
            super.styleChanged(_arg_1);
            if (((((_local_2) || (_arg_1 == buttonStyleNameProp)) || (_arg_1 == firstButtonStyleNameProp)) || (_arg_1 == lastButtonStyleNameProp)))
            {
                resetNavItems();
            }
            else
            {
                if (_arg_1 == buttonWidthProp)
                {
                    recalcButtonWidths = true;
                }
                else
                {
                    if (_arg_1 == buttonHeightProp)
                    {
                        recalcButtonHeights = true;
                    }
                    else
                    {
                        if (((StyleManager.isInheritingStyle(_arg_1)) && (StyleManager.isSizeInvalidatingStyle(_arg_1))))
                        {
                            recalcButtonWidths = (recalcButtonHeights = true);
                        };
                    };
                };
            };
        }

        protected function resetButtonWidths():void
        {
            var _local_2:Button;
            var _local_1:int;
            while (_local_1 < numChildren)
            {
                _local_2 = (getChildAt(_local_1) as Button);
                if (_local_2)
                {
                    _local_2.explicitWidth = NaN;
                    _local_2.minWidth = NaN;
                    _local_2.maxWidth = NaN;
                };
                _local_1++;
            };
        }

        override protected function commitProperties():void
        {
            var _local_1:int;
            var _local_2:int;
            super.commitProperties();
            if (directionChanged)
            {
                directionChanged = false;
                _local_1 = numChildren;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    Button(getChildAt(_local_2)).changeSkins();
                    _local_2++;
                };
            };
            if (recalcButtonHeights)
            {
                resetButtonHeights();
            };
            if (recalcButtonWidths)
            {
                resetButtonWidths();
            };
        }

        private function calcFullHeight():Number
        {
            var _local_2:Number;
            var _local_6:Number;
            var _local_8:Number;
            var _local_1:int = numChildren;
            if (_local_1 == 0)
            {
                return (0);
            };
            if (_local_1 > 1)
            {
                _local_2 = getStyle("verticalGap");
            };
            var _local_3:* = (direction == BoxDirection.VERTICAL);
            var _local_4:Number = getStyle(buttonHeightProp);
            var _local_5:IUIComponent = IUIComponent(getChildAt(0));
            if (_local_4)
            {
                _local_6 = ((isNaN(_local_5.explicitHeight)) ? _local_4 : _local_5.explicitHeight);
            }
            else
            {
                _local_6 = _local_5.getExplicitOrMeasuredHeight();
            };
            var _local_7:int = 1;
            while (_local_7 < _local_1)
            {
                _local_5 = IUIComponent(getChildAt(_local_7));
                if (_local_4)
                {
                    _local_8 = ((isNaN(_local_5.explicitHeight)) ? _local_4 : _local_5.explicitHeight);
                }
                else
                {
                    _local_8 = _local_5.getExplicitOrMeasuredHeight();
                };
                if (_local_3)
                {
                    _local_6 = (_local_6 + (_local_2 + _local_8));
                }
                else
                {
                    _local_6 = Math.max(_local_6, _local_8);
                };
                _local_7++;
            };
            return (_local_6);
        }

        override protected function resetNavItems():void
        {
            var _local_4:Button;
            var _local_1:String = getStyle(buttonStyleNameProp);
            var _local_2:String = getStyle(firstButtonStyleNameProp);
            var _local_3:String = getStyle(lastButtonStyleNameProp);
            if (!_local_1)
            {
                _local_1 = "ButtonBarButton";
            };
            if (!_local_2)
            {
                _local_2 = _local_1;
            };
            if (!_local_3)
            {
                _local_3 = _local_1;
            };
            var _local_5:int = numChildren;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_4 = Button(getChildAt(_local_6));
                if (_local_6 == 0)
                {
                    _local_4.styleName = _local_2;
                }
                else
                {
                    if (_local_6 == (_local_5 - 1))
                    {
                        _local_4.styleName = _local_3;
                    }
                    else
                    {
                        _local_4.styleName = _local_1;
                    };
                };
                _local_4.changeSkins();
                _local_4.invalidateDisplayList();
                _local_6++;
            };
            recalcButtonWidths = (recalcButtonHeights = true);
            invalidateDisplayList();
        }

        override public function get viewMetrics():EdgeMetrics
        {
            return (EdgeMetrics.EMPTY);
        }

        mx_internal function prevIndex(_arg_1:int):int
        {
            var _local_2:int = numChildren;
            return ((_arg_1 == 0) ? (_local_2 - 1) : (_arg_1 - 1));
        }

        private function scaleChangedHandler(_arg_1:Event):void
        {
            resetButtonHeights();
            resetButtonWidths();
        }

        mx_internal function drawButtonFocus(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:Button;
            if (((numChildren > 0) && (_arg_1 < numChildren)))
            {
                _local_3 = Button(getChildAt(_arg_1));
                _local_3.drawFocus(((_arg_2) && (focusManager.showFocusIndicator)));
                if (_arg_2)
                {
                    dispatchEvent(new Event("focusDraw"));
                };
                if (((!(_arg_2)) && (!(_local_3.phase == ButtonPhase.UP))))
                {
                    _local_3.phase = ButtonPhase.UP;
                };
            };
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:Button;
            if (_arg_1.eventPhase != EventPhase.AT_TARGET)
            {
                return;
            };
            switch (_arg_1.keyCode)
            {
                case Keyboard.DOWN:
                case Keyboard.RIGHT:
                    focusManager.showFocusIndicator = true;
                    drawButtonFocus(focusedIndex, false);
                    focusedIndex = nextIndex(focusedIndex);
                    if (focusedIndex != -1)
                    {
                        drawButtonFocus(focusedIndex, true);
                    };
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.UP:
                case Keyboard.LEFT:
                    focusManager.showFocusIndicator = true;
                    drawButtonFocus(focusedIndex, false);
                    focusedIndex = prevIndex(focusedIndex);
                    if (focusedIndex != -1)
                    {
                        drawButtonFocus(focusedIndex, true);
                    };
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.SPACE:
                    if (focusedIndex != -1)
                    {
                        _local_2 = Button(getChildAt(focusedIndex));
                        _local_2.dispatchEvent(_arg_1);
                    };
                    _arg_1.stopPropagation();
                    return;
            };
        }

        override protected function measure():void
        {
            var _local_1:EdgeMetrics;
            super.measure();
            _local_1 = viewMetricsAndPadding;
            measuredWidth = ((calcFullWidth() + _local_1.left) + _local_1.right);
            measuredHeight = ((calcFullHeight() + _local_1.top) + _local_1.bottom);
            if (getStyle(buttonWidthProp))
            {
                measuredMinWidth = measuredWidth;
            };
            if (getStyle(buttonHeightProp))
            {
                measuredMinHeight = measuredHeight;
            };
        }

        private function childRemoveHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            var _local_8:Button;
            var _local_2:DisplayObject = _arg_1.relatedObject;
            var _local_3:int = getChildIndex(_local_2);
            var _local_4:int = numChildren;
            if (_local_4 < 2)
            {
                return;
            };
            var _local_5:String = getStyle(buttonStyleNameProp);
            var _local_6:String = getStyle(firstButtonStyleNameProp);
            var _local_7:String = getStyle(lastButtonStyleNameProp);
            if (!_local_5)
            {
                _local_5 = "buttonBarButtonStyle";
            };
            if (!_local_6)
            {
                _local_6 = _local_5;
            };
            if (!_local_7)
            {
                _local_7 = _local_5;
            };
            if (((_local_3 == 0) || (_local_3 == (_local_4 - 1))))
            {
                _local_8 = Button(getChildAt(((_local_3 == (_local_4 - 1)) ? (_local_4 - 2) : 0)));
                _local_8.styleName = ((_local_3 == 0) ? _local_6 : _local_7);
                _local_8.changeSkins();
                _local_8.invalidateDisplayList();
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Boolean;
            var _local_16:int;
            var _local_17:Button;
            var _local_18:Number;
            var _local_19:int;
            var _local_20:int;
            var _local_21:Number;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:Number;
            _local_3 = (direction == BoxDirection.HORIZONTAL);
            var _local_4:* = (!(_local_3));
            var _local_5:Number = getStyle(buttonWidthProp);
            var _local_6:Number = getStyle(buttonHeightProp);
            var _local_7:Number = _local_6;
            var _local_8:EdgeMetrics = viewMetricsAndPadding;
            var _local_9:int = numChildren;
            var _local_10:Number = getStyle("horizontalGap");
            var _local_11:Number = getStyle("verticalGap");
            var _local_12:Number = (((_local_3) && (numChildren > 0)) ? (_local_10 * (_local_9 - 1)) : 0);
            var _local_13:Number = (((_local_4) && (numChildren > 0)) ? (_local_11 * (_local_9 - 1)) : 0);
            var _local_14:Number = (((_arg_1 - _local_8.left) - _local_8.right) - _local_12);
            var _local_15:Number = (((_arg_2 - _local_8.top) - _local_8.bottom) - _local_13);
            if (((!(_local_14)) || (!(_local_15))))
            {
                return;
            };
            if (border)
            {
                border.visible = false;
            };
            if (_arg_1 != oldUnscaledWidth)
            {
                recalcButtonWidths = true;
                oldUnscaledWidth = _arg_1;
            };
            if (_arg_2 != oldUnscaledHeight)
            {
                recalcButtonHeights = true;
                oldUnscaledHeight = _arg_2;
            };
            if (recalcButtonWidths)
            {
                recalcButtonWidths = false;
                if (((isNaN(_local_5)) && (_local_4)))
                {
                    _local_5 = _local_14;
                };
                _local_18 = (_local_14 - (calcFullWidth() - _local_12));
                _local_19 = int(((_local_9 > 0) ? int((_local_14 / _local_9)) : 0));
                _local_20 = 0;
                _local_21 = 0;
                _local_22 = 0;
                if (((!(_local_18 == 0)) && (_local_3)))
                {
                    _local_16 = 0;
                    while (_local_16 < _local_9)
                    {
                        _local_17 = Button(getChildAt(_local_16));
                        if (isNaN(_local_17.explicitWidth))
                        {
                            _local_23 = _local_17.measuredWidth;
                            _local_21 = (_local_21 + _local_23);
                            if (_local_23 > _local_19)
                            {
                                _local_20++;
                            }
                            else
                            {
                                _local_22 = (_local_22 + _local_23);
                            };
                        };
                        _local_16++;
                    };
                }
                else
                {
                    _local_21 = _local_14;
                };
                _local_16 = 0;
                while (_local_16 < _local_9)
                {
                    _local_17 = Button(getChildAt(_local_16));
                    if (isNaN(_local_17.explicitWidth))
                    {
                        _local_17.minWidth = 0;
                        if (!isNaN(_local_5))
                        {
                            _local_17.minWidth = (_local_17.maxWidth = _local_5);
                            _local_17.percentWidth = ((_local_5 / Math.min(_local_14, _local_21)) * 100);
                        }
                        else
                        {
                            if (_local_18 < 0)
                            {
                                _local_24 = _local_17.measuredWidth;
                                if (_local_24 > _local_19)
                                {
                                    _local_24 = int(((_local_14 - _local_22) / _local_20));
                                };
                                _local_17.percentWidth = ((Number(_local_24) / _local_14) * 100);
                            }
                            else
                            {
                                if (_local_18 > 0)
                                {
                                    _local_17.percentWidth = ((_local_17.measuredWidth / _local_21) * 100);
                                }
                                else
                                {
                                    _local_17.percentWidth = NaN;
                                };
                            };
                        };
                        if (_local_4)
                        {
                            _local_17.percentWidth = 100;
                        };
                    };
                    _local_16++;
                };
            };
            if (recalcButtonHeights)
            {
                recalcButtonHeights = false;
                if (((isNaN(_local_7)) && (_local_3)))
                {
                    _local_7 = _local_15;
                };
                _local_18 = (_local_15 - (calcFullHeight() - _local_13));
                _local_25 = 0;
                if (((!(_local_18 == 0)) && (_local_4)))
                {
                    _local_16 = 0;
                    while (_local_16 < _local_9)
                    {
                        _local_17 = Button(getChildAt(_local_16));
                        if (isNaN(_local_17.explicitHeight))
                        {
                            _local_25 = (_local_25 + _local_17.measuredHeight);
                        };
                        _local_16++;
                    };
                };
                _local_16 = 0;
                while (_local_16 < _local_9)
                {
                    _local_17 = Button(getChildAt(_local_16));
                    if (isNaN(_local_17.explicitHeight))
                    {
                        _local_17.minHeight = 0;
                        if (!isNaN(_local_7))
                        {
                            _local_17.minHeight = _local_7;
                            _local_17.percentHeight = ((_local_7 / Math.min(_local_25, _local_15)) * 100);
                        };
                        if (!isNaN(_local_6))
                        {
                            _local_17.maxHeight = _local_6;
                        };
                        if (_local_3)
                        {
                            _local_17.percentHeight = 100;
                        }
                        else
                        {
                            if (_local_18 < 0)
                            {
                                _local_17.percentHeight = ((_local_17.measuredHeight / _local_25) * 100);
                            }
                            else
                            {
                                if (_local_18 > 0)
                                {
                                    _local_17.percentHeight = ((_local_17.measuredHeight / _local_25) * 100);
                                }
                                else
                                {
                                    _local_17.percentHeight = NaN;
                                };
                            };
                        };
                    };
                    _local_16++;
                };
            };
            super.updateDisplayList(_arg_1, _arg_2);
        }

        override public function drawFocus(_arg_1:Boolean):void
        {
            drawButtonFocus(focusedIndex, _arg_1);
        }

        [Bindable("directionChanged")]
        override public function set direction(_arg_1:String):void
        {
            if (((initialized) && (!(_arg_1 == direction))))
            {
                directionChanged = true;
                invalidateProperties();
            };
            super.direction = _arg_1;
        }


    }
}//package mx.controls

