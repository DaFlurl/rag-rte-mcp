// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.Button

package mx.controls
{
    import mx.core.UIComponent;
    import mx.core.IDataRenderer;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.managers.IFocusManagerComponent;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.IFontContextComponent;
    import mx.core.IButton;
    import mx.core.UITextField;
    import flash.utils.Timer;
    import mx.core.IFlexDisplayObject;
    import mx.controls.listClasses.BaseListData;
    import mx.core.IUITextField;
    import flash.events.MouseEvent;
    import mx.core.EdgeMetrics;
    import flash.text.TextLineMetrics;
    import flash.display.DisplayObject;
    import mx.core.IStateClient;
    import mx.core.IProgrammaticSkin;
    import mx.styles.ISimpleStyleClient;
    import mx.core.IInvalidating;
    import mx.core.IUIComponent;
    import mx.core.FlexVersion;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.events.TimerEvent;
    import flash.events.FocusEvent;
    import mx.controls.dataGridClasses.DataGridListData;
    import mx.core.IFlexModuleFactory;
    import mx.events.MoveEvent;
    import mx.core.IFlexAsset;
    import mx.core.IBorder;
    import mx.events.SandboxMouseEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import mx.core.IRectangularBorder;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Button extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IListItemRenderer, IFontContextComponent, IButton 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var createAccessibilityImplementation:Function;
        mx_internal static var TEXT_WIDTH_PADDING:Number = (UITextField.TEXT_WIDTH_PADDING + 1);//6

        mx_internal var _emphasized:Boolean = false;
        mx_internal var extraSpacing:Number = 20;
        public var selectedField:String = null;
        private var labelChanged:Boolean = false;
        private var skinMeasuredWidth:Number;
        mx_internal var checkedDefaultSkin:Boolean = false;
        private var autoRepeatTimer:Timer;
        mx_internal var disabledIconName:String = "disabledIcon";
        mx_internal var disabledSkinName:String = "disabledSkin";
        mx_internal var checkedDefaultIcon:Boolean = false;
        public var stickyHighlighting:Boolean = false;
        private var enabledChanged:Boolean = false;
        mx_internal var selectedUpIconName:String = "selectedUpIcon";
        mx_internal var selectedUpSkinName:String = "selectedUpSkin";
        mx_internal var upIconName:String = "upIcon";
        mx_internal var upSkinName:String = "upSkin";
        mx_internal var centerContent:Boolean = true;
        mx_internal var buttonOffset:Number = 0;
        private var skinMeasuredHeight:Number;
        private var oldUnscaledWidth:Number;
        mx_internal var downIconName:String = "downIcon";
        mx_internal var _labelPlacement:String = "right";
        mx_internal var downSkinName:String = "downSkin";
        mx_internal var _toggle:Boolean = false;
        private var _phase:String = "up";
        private var toolTipSet:Boolean = false;
        private var _data:Object;
        mx_internal var currentIcon:IFlexDisplayObject;
        mx_internal var currentSkin:IFlexDisplayObject;
        mx_internal var overIconName:String = "overIcon";
        mx_internal var selectedDownIconName:String = "selectedDownIcon";
        mx_internal var overSkinName:String = "overSkin";
        mx_internal var iconName:String = "icon";
        mx_internal var skinName:String = "skin";
        mx_internal var selectedDownSkinName:String = "selectedDownSkin";
        private var selectedSet:Boolean;
        private var _autoRepeat:Boolean = false;
        private var styleChangedFlag:Boolean = true;
        mx_internal var selectedOverIconName:String = "selectedOverIcon";
        private var _listData:BaseListData;
        mx_internal var selectedOverSkinName:String = "selectedOverSkin";
        protected var textField:IUITextField;
        private var labelSet:Boolean;
        mx_internal var defaultIconUsesStates:Boolean = false;
        mx_internal var defaultSkinUsesStates:Boolean = false;
        mx_internal var toggleChanged:Boolean = false;
        private var emphasizedChanged:Boolean = false;
        private var _label:String = "";
        mx_internal var _selected:Boolean = false;
        mx_internal var selectedDisabledIconName:String = "selectedDisabledIcon";
        mx_internal var selectedDisabledSkinName:String = "selectedDisabledSkin";

        private var skins:Array = [];
        private var icons:Array = [];

        public function Button()
        {
            mouseChildren = false;
            addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            addEventListener(MouseEvent.CLICK, clickHandler);
        }

        private function previousVersion_measure():void
        {
            var bm:EdgeMetrics;
            var lineMetrics:TextLineMetrics;
            var paddingLeft:Number;
            var paddingRight:Number;
            var paddingTop:Number;
            var paddingBottom:Number;
            var horizontalGap:Number;
            super.measure();
            var textWidth:Number = 0;
            var textHeight:Number = 0;
            if (label)
            {
                lineMetrics = measureText(label);
                textWidth = lineMetrics.width;
                textHeight = lineMetrics.height;
                paddingLeft = getStyle("paddingLeft");
                paddingRight = getStyle("paddingRight");
                paddingTop = getStyle("paddingTop");
                paddingBottom = getStyle("paddingBottom");
                textWidth = (textWidth + ((paddingLeft + paddingRight) + getStyle("textIndent")));
                textHeight = (textHeight + (paddingTop + paddingBottom));
            };
            try
            {
                bm = currentSkin["borderMetrics"];
            }
            catch(e:Error)
            {
                bm = new EdgeMetrics(3, 3, 3, 3);
            };
            var tempCurrentIcon:IFlexDisplayObject = getCurrentIcon();
            var iconWidth:Number = ((tempCurrentIcon) ? tempCurrentIcon.width : 0);
            var iconHeight:Number = ((tempCurrentIcon) ? tempCurrentIcon.height : 0);
            var w:Number = 0;
            var h:Number = 0;
            if (((labelPlacement == ButtonLabelPlacement.LEFT) || (labelPlacement == ButtonLabelPlacement.RIGHT)))
            {
                w = (textWidth + iconWidth);
                if (iconWidth != 0)
                {
                    horizontalGap = getStyle("horizontalGap");
                    w = (w + (horizontalGap - 2));
                };
                h = Math.max(textHeight, (iconHeight + 6));
            }
            else
            {
                w = Math.max(textWidth, iconWidth);
                h = (textHeight + iconHeight);
                if (iconHeight != 0)
                {
                    h = (h + getStyle("verticalGap"));
                };
            };
            if (bm)
            {
                w = (w + (bm.left + bm.right));
                h = (h + (bm.top + bm.bottom));
            };
            if (((label) && (!(label.length == 0))))
            {
                w = (w + extraSpacing);
            }
            else
            {
                w = (w + 6);
            };
            if (((currentSkin) && ((isNaN(skinMeasuredWidth)) || (isNaN(skinMeasuredHeight)))))
            {
                skinMeasuredWidth = currentSkin.measuredWidth;
                skinMeasuredHeight = currentSkin.measuredHeight;
            };
            if (!isNaN(skinMeasuredWidth))
            {
                w = Math.max(skinMeasuredWidth, w);
            };
            if (!isNaN(skinMeasuredHeight))
            {
                h = Math.max(skinMeasuredHeight, h);
            };
            measuredMinWidth = (measuredWidth = w);
            measuredMinHeight = (measuredHeight = h);
        }

        [Bindable("labelChanged")]
        public function get label():String
        {
            return (_label);
        }

        mx_internal function getCurrentIconName():String
        {
            var _local_1:String;
            if (!enabled)
            {
                _local_1 = ((selected) ? selectedDisabledIconName : disabledIconName);
            }
            else
            {
                if (phase == ButtonPhase.UP)
                {
                    _local_1 = ((selected) ? selectedUpIconName : upIconName);
                }
                else
                {
                    if (phase == ButtonPhase.OVER)
                    {
                        _local_1 = ((selected) ? selectedOverIconName : overIconName);
                    }
                    else
                    {
                        if (phase == ButtonPhase.DOWN)
                        {
                            _local_1 = ((selected) ? selectedDownIconName : downIconName);
                        };
                    };
                };
            };
            return (_local_1);
        }

        protected function mouseUpHandler(_arg_1:MouseEvent):void
        {
            if (!enabled)
            {
                return;
            };
            phase = ButtonPhase.OVER;
            buttonReleased();
            if (!toggle)
            {
                _arg_1.updateAfterEvent();
            };
        }

        override protected function adjustFocusRect(_arg_1:DisplayObject=null):void
        {
            super.adjustFocusRect(((currentSkin) ? this : DisplayObject(currentIcon)));
        }

        mx_internal function set phase(_arg_1:String):void
        {
            _phase = _arg_1;
            invalidateSize();
            invalidateDisplayList();
        }

        mx_internal function viewIconForPhase(_arg_1:String):IFlexDisplayObject
        {
            var _local_3:IFlexDisplayObject;
            var _local_4:Boolean;
            var _local_5:String;
            var _local_2:Class = Class(getStyle(_arg_1));
            if (!_local_2)
            {
                _local_2 = Class(getStyle(iconName));
                if (defaultIconUsesStates)
                {
                    _arg_1 = iconName;
                };
                if (((!(checkedDefaultIcon)) && (_local_2)))
                {
                    _local_3 = IFlexDisplayObject(new (_local_2)());
                    if (((!(_local_3 is IProgrammaticSkin)) && (_local_3 is IStateClient)))
                    {
                        defaultIconUsesStates = true;
                        _arg_1 = iconName;
                    };
                    if (_local_3)
                    {
                        checkedDefaultIcon = true;
                    };
                };
            };
            _local_3 = IFlexDisplayObject(getChildByName(_arg_1));
            if (_local_3 == null)
            {
                if (_local_2 != null)
                {
                    _local_3 = IFlexDisplayObject(new (_local_2)());
                    _local_3.name = _arg_1;
                    if ((_local_3 is ISimpleStyleClient))
                    {
                        ISimpleStyleClient(_local_3).styleName = this;
                    };
                    addChild(DisplayObject(_local_3));
                    _local_4 = false;
                    if ((_local_3 is IInvalidating))
                    {
                        IInvalidating(_local_3).validateNow();
                        _local_4 = true;
                    }
                    else
                    {
                        if ((_local_3 is IProgrammaticSkin))
                        {
                            IProgrammaticSkin(_local_3).validateDisplayList();
                            _local_4 = true;
                        };
                    };
                    if (((_local_3) && (_local_3 is IUIComponent)))
                    {
                        IUIComponent(_local_3).enabled = enabled;
                    };
                    if (_local_4)
                    {
                        _local_3.setActualSize(_local_3.measuredWidth, _local_3.measuredHeight);
                    };
                    icons.push(_local_3);
                };
            };
            if (currentIcon != null)
            {
                currentIcon.visible = false;
            };
            currentIcon = _local_3;
            if (((defaultIconUsesStates) && (currentIcon is IStateClient)))
            {
                _local_5 = "";
                if (!enabled)
                {
                    _local_5 = ((selected) ? "selectedDisabled" : "disabled");
                }
                else
                {
                    if (phase == ButtonPhase.UP)
                    {
                        _local_5 = ((selected) ? "selectedUp" : "up");
                    }
                    else
                    {
                        if (phase == ButtonPhase.OVER)
                        {
                            _local_5 = ((selected) ? "selectedOver" : "over");
                        }
                        else
                        {
                            if (phase == ButtonPhase.DOWN)
                            {
                                _local_5 = ((selected) ? "selectedDown" : "down");
                            };
                        };
                    };
                };
                IStateClient(currentIcon).currentState = _local_5;
            };
            if (currentIcon != null)
            {
                currentIcon.visible = true;
            };
            return (_local_3);
        }

        mx_internal function viewSkinForPhase(_arg_1:String, _arg_2:String):void
        {
            var _local_4:IFlexDisplayObject;
            var _local_5:Number;
            var _local_6:ISimpleStyleClient;
            var _local_3:Class = Class(getStyle(_arg_1));
            if (!_local_3)
            {
                _local_3 = Class(getStyle(skinName));
                if (defaultSkinUsesStates)
                {
                    _arg_1 = skinName;
                };
                if (((!(checkedDefaultSkin)) && (_local_3)))
                {
                    _local_4 = IFlexDisplayObject(new (_local_3)());
                    if (((!(_local_4 is IProgrammaticSkin)) && (_local_4 is IStateClient)))
                    {
                        defaultSkinUsesStates = true;
                        _arg_1 = skinName;
                    };
                    if (_local_4)
                    {
                        checkedDefaultSkin = true;
                    };
                };
            };
            _local_4 = IFlexDisplayObject(getChildByName(_arg_1));
            if (!_local_4)
            {
                if (_local_3)
                {
                    _local_4 = IFlexDisplayObject(new (_local_3)());
                    _local_4.name = _arg_1;
                    _local_6 = (_local_4 as ISimpleStyleClient);
                    if (_local_6)
                    {
                        _local_6.styleName = this;
                    };
                    addChild(DisplayObject(_local_4));
                    _local_4.setActualSize(unscaledWidth, unscaledHeight);
                    if (((_local_4 is IInvalidating) && (initialized)))
                    {
                        IInvalidating(_local_4).validateNow();
                    }
                    else
                    {
                        if (((_local_4 is IProgrammaticSkin) && (initialized)))
                        {
                            IProgrammaticSkin(_local_4).validateDisplayList();
                        };
                    };
                    skins.push(_local_4);
                };
            };
            if (currentSkin)
            {
                currentSkin.visible = false;
            };
            currentSkin = _local_4;
            if (((defaultSkinUsesStates) && (currentSkin is IStateClient)))
            {
                IStateClient(currentSkin).currentState = _arg_2;
            };
            if (currentSkin)
            {
                currentSkin.visible = true;
            };
            if (enabled)
            {
                if (phase == ButtonPhase.OVER)
                {
                    _local_5 = textField.getStyle("textRollOverColor");
                }
                else
                {
                    if (phase == ButtonPhase.DOWN)
                    {
                        _local_5 = textField.getStyle("textSelectedColor");
                    }
                    else
                    {
                        _local_5 = textField.getStyle("color");
                    };
                };
                textField.setColor(_local_5);
            };
        }

        mx_internal function getTextField():IUITextField
        {
            return (textField);
        }

        protected function rollOverHandler(_arg_1:MouseEvent):void
        {
            if (phase == ButtonPhase.UP)
            {
                if (_arg_1.buttonDown)
                {
                    return;
                };
                phase = ButtonPhase.OVER;
                _arg_1.updateAfterEvent();
            }
            else
            {
                if (phase == ButtonPhase.OVER)
                {
                    phase = ButtonPhase.DOWN;
                    _arg_1.updateAfterEvent();
                    if (autoRepeatTimer)
                    {
                        autoRepeatTimer.start();
                    };
                };
            };
        }

        override protected function createChildren():void
        {
            super.createChildren();
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.styleName = this;
                addChild(DisplayObject(textField));
            };
        }

        mx_internal function setSelected(_arg_1:Boolean, _arg_2:Boolean=false):void
        {
            if (_selected != _arg_1)
            {
                _selected = _arg_1;
                invalidateDisplayList();
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    if (toggle)
                    {
                        dispatchEvent(new Event(Event.CHANGE));
                    };
                }
                else
                {
                    if (((toggle) && (!(_arg_2))))
                    {
                        dispatchEvent(new Event(Event.CHANGE));
                    };
                };
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            };
        }

        private function autoRepeatTimer_timerDelayHandler(_arg_1:Event):void
        {
            if (!enabled)
            {
                return;
            };
            dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
            if (autoRepeat)
            {
                autoRepeatTimer.reset();
                autoRepeatTimer.removeEventListener(TimerEvent.TIMER, autoRepeatTimer_timerDelayHandler);
                autoRepeatTimer.delay = getStyle("repeatInterval");
                autoRepeatTimer.addEventListener(TimerEvent.TIMER, autoRepeatTimer_timerHandler);
                autoRepeatTimer.start();
            };
        }

        public function get autoRepeat():Boolean
        {
            return (_autoRepeat);
        }

        public function set selected(_arg_1:Boolean):void
        {
            selectedSet = true;
            setSelected(_arg_1, true);
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            super.focusOutHandler(_arg_1);
            if (phase != ButtonPhase.UP)
            {
                phase = ButtonPhase.UP;
            };
        }

        [Bindable("labelPlacementChanged")]
        public function get labelPlacement():String
        {
            return (_labelPlacement);
        }

        public function set autoRepeat(_arg_1:Boolean):void
        {
            _autoRepeat = _arg_1;
            if (_arg_1)
            {
                autoRepeatTimer = new Timer(1);
            }
            else
            {
                autoRepeatTimer = null;
            };
        }

        mx_internal function changeIcons():void
        {
            var _local_1:int = icons.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                removeChild(icons[_local_2]);
                _local_2++;
            };
            icons = [];
            checkedDefaultIcon = false;
            defaultIconUsesStates = false;
        }

        public function set data(_arg_1:Object):void
        {
            var _local_2:*;
            var _local_3:*;
            _data = _arg_1;
            if ((((_listData) && (_listData is DataGridListData)) && (!(DataGridListData(_listData).dataField == null))))
            {
                _local_2 = _data[DataGridListData(_listData).dataField];
                _local_3 = "";
            }
            else
            {
                if (_listData)
                {
                    if (selectedField)
                    {
                        _local_2 = _data[selectedField];
                    };
                    _local_3 = _listData.label;
                }
                else
                {
                    _local_2 = _data;
                };
            };
            if (((!(_local_2 === undefined)) && (!(selectedSet))))
            {
                selected = (_local_2 as Boolean);
                selectedSet = false;
            };
            if (((!(_local_3 === undefined)) && (!(labelSet))))
            {
                label = _local_3;
                labelSet = false;
            };
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        mx_internal function getCurrentIcon():IFlexDisplayObject
        {
            var _local_1:String = getCurrentIconName();
            if (!_local_1)
            {
                return (null);
            };
            return (viewIconForPhase(_local_1));
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        public function get emphasized():Boolean
        {
            return (_emphasized);
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        mx_internal function layoutContents(_arg_1:Number, _arg_2:Number, _arg_3:Boolean):void
        {
            var _local_20:TextLineMetrics;
            var _local_28:MoveEvent;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                previousVersion_layoutContents(_arg_1, _arg_2, _arg_3);
                return;
            };
            var _local_4:Number = 0;
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            var _local_8:Number = 0;
            var _local_9:Number = 0;
            var _local_10:Number = 0;
            var _local_11:Number = 0;
            var _local_12:Number = 0;
            var _local_13:Number = 0;
            var _local_14:Number = getStyle("paddingLeft");
            var _local_15:Number = getStyle("paddingRight");
            var _local_16:Number = getStyle("paddingTop");
            var _local_17:Number = getStyle("paddingBottom");
            var _local_18:Number = 0;
            var _local_19:Number = 0;
            if (label)
            {
                _local_20 = measureText(label);
                _local_18 = (_local_20.width + TEXT_WIDTH_PADDING);
                _local_19 = (_local_20.height + UITextField.TEXT_HEIGHT_PADDING);
            }
            else
            {
                _local_20 = measureText("Wj");
                _local_19 = (_local_20.height + UITextField.TEXT_HEIGHT_PADDING);
            };
            var _local_21:Number = ((_arg_3) ? buttonOffset : 0);
            var _local_22:String = getStyle("textAlign");
            var _local_23:Number = _arg_1;
            var _local_24:Number = _arg_2;
            var _local_25:EdgeMetrics = ((((currentSkin) && (currentSkin is IBorder)) && (!(currentSkin is IFlexAsset))) ? IBorder(currentSkin).borderMetrics : null);
            if (_local_25)
            {
                _local_23 = (_local_23 - (_local_25.left + _local_25.right));
                _local_24 = (_local_24 - (_local_25.top + _local_25.bottom));
            };
            if (currentIcon)
            {
                _local_8 = currentIcon.width;
                _local_9 = currentIcon.height;
            };
            if (((labelPlacement == ButtonLabelPlacement.LEFT) || (labelPlacement == ButtonLabelPlacement.RIGHT)))
            {
                _local_12 = getStyle("horizontalGap");
                if (((_local_8 == 0) || (_local_18 == 0)))
                {
                    _local_12 = 0;
                };
                if (_local_18 > 0)
                {
                    textField.width = (_local_4 = Math.max(Math.min(((((_local_23 - _local_8) - _local_12) - _local_14) - _local_15), _local_18), 0));
                }
                else
                {
                    textField.width = (_local_4 = 0);
                };
                textField.height = (_local_5 = Math.min(_local_24, _local_19));
                if (_local_22 == "left")
                {
                    _local_6 = (_local_6 + _local_14);
                }
                else
                {
                    if (_local_22 == "right")
                    {
                        _local_6 = (_local_6 + ((((_local_23 - _local_4) - _local_8) - _local_12) - _local_15));
                    }
                    else
                    {
                        _local_6 = (_local_6 + (((((((_local_23 - _local_4) - _local_8) - _local_12) - _local_14) - _local_15) / 2) + _local_14));
                    };
                };
                if (labelPlacement == ButtonLabelPlacement.RIGHT)
                {
                    _local_6 = (_local_6 + (_local_8 + _local_12));
                    _local_10 = (_local_6 - (_local_8 + _local_12));
                }
                else
                {
                    _local_10 = ((_local_6 + _local_4) + _local_12);
                };
                _local_11 = (((((_local_24 - _local_9) - _local_16) - _local_17) / 2) + _local_16);
                _local_7 = (((((_local_24 - _local_5) - _local_16) - _local_17) / 2) + _local_16);
            }
            else
            {
                _local_13 = getStyle("verticalGap");
                if (((_local_9 == 0) || (label == "")))
                {
                    _local_13 = 0;
                };
                if (_local_18 > 0)
                {
                    textField.width = (_local_4 = Math.max(((_local_23 - _local_14) - _local_15), 0));
                    textField.height = (_local_5 = Math.min(((((_local_24 - _local_9) - _local_16) - _local_17) - _local_13), _local_19));
                }
                else
                {
                    textField.width = (_local_4 = 0);
                    textField.height = (_local_5 = 0);
                };
                _local_6 = _local_14;
                if (_local_22 == "left")
                {
                    _local_10 = (_local_10 + _local_14);
                }
                else
                {
                    if (_local_22 == "right")
                    {
                        _local_10 = (_local_10 + Math.max(((_local_23 - _local_8) - _local_15), _local_14));
                    }
                    else
                    {
                        _local_10 = (_local_10 + (((((_local_23 - _local_8) - _local_14) - _local_15) / 2) + _local_14));
                    };
                };
                if (labelPlacement == ButtonLabelPlacement.TOP)
                {
                    _local_7 = (_local_7 + (((((((_local_24 - _local_5) - _local_9) - _local_16) - _local_17) - _local_13) / 2) + _local_16));
                    _local_11 = (_local_11 + ((_local_7 + _local_5) + _local_13));
                }
                else
                {
                    _local_11 = (_local_11 + (((((((_local_24 - _local_5) - _local_9) - _local_16) - _local_17) - _local_13) / 2) + _local_16));
                    _local_7 = (_local_7 + ((_local_11 + _local_9) + _local_13));
                };
            };
            var _local_26:Number = _local_21;
            var _local_27:Number = _local_21;
            if (_local_25)
            {
                _local_26 = (_local_26 + _local_25.left);
                _local_27 = (_local_27 + _local_25.top);
            };
            textField.x = Math.round((_local_6 + _local_26));
            textField.y = Math.round((_local_7 + _local_27));
            if (currentIcon)
            {
                _local_10 = (_local_10 + _local_26);
                _local_11 = (_local_11 + _local_27);
                _local_28 = new MoveEvent(MoveEvent.MOVE);
                _local_28.oldX = currentIcon.x;
                _local_28.oldY = currentIcon.y;
                currentIcon.x = Math.round(_local_10);
                currentIcon.y = Math.round(_local_11);
                currentIcon.dispatchEvent(_local_28);
            };
            if (currentSkin)
            {
                setChildIndex(DisplayObject(currentSkin), (numChildren - 1));
            };
            if (currentIcon)
            {
                setChildIndex(DisplayObject(currentIcon), (numChildren - 1));
            };
            if (textField)
            {
                setChildIndex(DisplayObject(textField), (numChildren - 1));
            };
        }

        protected function mouseDownHandler(_arg_1:MouseEvent):void
        {
            if (!enabled)
            {
                return;
            };
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            buttonPressed();
            _arg_1.updateAfterEvent();
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (!enabled)
            {
                return;
            };
            if (_arg_1.keyCode == Keyboard.SPACE)
            {
                buttonPressed();
            };
        }

        protected function rollOutHandler(_arg_1:MouseEvent):void
        {
            if (phase == ButtonPhase.OVER)
            {
                phase = ButtonPhase.UP;
                _arg_1.updateAfterEvent();
            }
            else
            {
                if (((phase == ButtonPhase.DOWN) && (!(stickyHighlighting))))
                {
                    phase = ButtonPhase.OVER;
                    _arg_1.updateAfterEvent();
                    if (autoRepeatTimer)
                    {
                        autoRepeatTimer.stop();
                    };
                };
            };
        }

        mx_internal function get phase():String
        {
            return (_phase);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            if (super.enabled == _arg_1)
            {
                return;
            };
            super.enabled = _arg_1;
            enabledChanged = true;
            invalidateProperties();
            invalidateDisplayList();
        }

        override protected function measure():void
        {
            var _local_9:TextLineMetrics;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                previousVersion_measure();
                return;
            };
            super.measure();
            var _local_1:Number = 0;
            var _local_2:Number = 0;
            if (label)
            {
                _local_9 = measureText(label);
                _local_1 = (_local_9.width + TEXT_WIDTH_PADDING);
                _local_2 = (_local_9.height + UITextField.TEXT_HEIGHT_PADDING);
            };
            var _local_3:IFlexDisplayObject = getCurrentIcon();
            var _local_4:Number = ((_local_3) ? _local_3.width : 0);
            var _local_5:Number = ((_local_3) ? _local_3.height : 0);
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            if (((labelPlacement == ButtonLabelPlacement.LEFT) || (labelPlacement == ButtonLabelPlacement.RIGHT)))
            {
                _local_6 = (_local_1 + _local_4);
                if (((_local_1) && (_local_4)))
                {
                    _local_6 = (_local_6 + getStyle("horizontalGap"));
                };
                _local_7 = Math.max(_local_2, _local_5);
            }
            else
            {
                _local_6 = Math.max(_local_1, _local_4);
                _local_7 = (_local_2 + _local_5);
                if (((_local_2) && (_local_5)))
                {
                    _local_7 = (_local_7 + getStyle("verticalGap"));
                };
            };
            if (((_local_1) || (_local_4)))
            {
                _local_6 = (_local_6 + (getStyle("paddingLeft") + getStyle("paddingRight")));
                _local_7 = (_local_7 + (getStyle("paddingTop") + getStyle("paddingBottom")));
            };
            var _local_8:EdgeMetrics = ((((currentSkin) && (currentSkin is IBorder)) && (!(currentSkin is IFlexAsset))) ? IBorder(currentSkin).borderMetrics : null);
            if (_local_8)
            {
                _local_6 = (_local_6 + (_local_8.left + _local_8.right));
                _local_7 = (_local_7 + (_local_8.top + _local_8.bottom));
            };
            if (((currentSkin) && ((isNaN(skinMeasuredWidth)) || (isNaN(skinMeasuredHeight)))))
            {
                skinMeasuredWidth = currentSkin.measuredWidth;
                skinMeasuredHeight = currentSkin.measuredHeight;
            };
            if (!isNaN(skinMeasuredWidth))
            {
                _local_6 = Math.max(skinMeasuredWidth, _local_6);
            };
            if (!isNaN(skinMeasuredHeight))
            {
                _local_7 = Math.max(skinMeasuredHeight, _local_7);
            };
            measuredMinWidth = (measuredWidth = _local_6);
            measuredMinHeight = (measuredHeight = _local_7);
        }

        [Bindable("toggleChanged")]
        public function get toggle():Boolean
        {
            return (_toggle);
        }

        mx_internal function buttonReleased():void
        {
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            if (autoRepeatTimer)
            {
                autoRepeatTimer.removeEventListener(TimerEvent.TIMER, autoRepeatTimer_timerDelayHandler);
                autoRepeatTimer.removeEventListener(TimerEvent.TIMER, autoRepeatTimer_timerHandler);
                autoRepeatTimer.reset();
            };
        }

        mx_internal function buttonPressed():void
        {
            phase = ButtonPhase.DOWN;
            dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
            if (autoRepeat)
            {
                autoRepeatTimer.delay = getStyle("repeatDelay");
                autoRepeatTimer.addEventListener(TimerEvent.TIMER, autoRepeatTimer_timerDelayHandler);
                autoRepeatTimer.start();
            };
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            if (!enabled)
            {
                return;
            };
            if (_arg_1.keyCode == Keyboard.SPACE)
            {
                buttonReleased();
                if (phase == ButtonPhase.DOWN)
                {
                    dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                };
                phase = ButtonPhase.UP;
            };
        }

        [Bindable("click")]
        [Bindable("valueCommit")]
        public function get selected():Boolean
        {
            return (_selected);
        }

        public function set labelPlacement(_arg_1:String):void
        {
            _labelPlacement = _arg_1;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("labelPlacementChanged"));
        }

        protected function clickHandler(_arg_1:MouseEvent):void
        {
            if (!enabled)
            {
                _arg_1.stopImmediatePropagation();
                return;
            };
            if (toggle)
            {
                setSelected((!(selected)));
                _arg_1.updateAfterEvent();
            };
        }

        override protected function initializeAccessibility():void
        {
            if (Button.createAccessibilityImplementation != null)
            {
                Button.createAccessibilityImplementation(this);
            };
        }

        public function set toggle(_arg_1:Boolean):void
        {
            _toggle = _arg_1;
            toggleChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            dispatchEvent(new Event("toggleChanged"));
        }

        override public function get baselinePosition():Number
        {
            var _local_1:String;
            var _local_2:TextLineMetrics;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _local_1 = label;
                if (!_local_1)
                {
                    _local_1 = "Wj";
                };
                validateNow();
                if (((!(label)) && ((labelPlacement == ButtonLabelPlacement.TOP) || (labelPlacement == ButtonLabelPlacement.BOTTOM))))
                {
                    _local_2 = measureText(_local_1);
                    return (((measuredHeight - _local_2.height) / 2) + _local_2.ascent);
                };
                return (textField.y + measureText(_local_1).ascent);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return (textField.y + textField.baselinePosition);
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        mx_internal function viewSkin():void
        {
            var _local_1:String;
            var _local_2:String;
            if (!enabled)
            {
                _local_1 = ((selected) ? selectedDisabledSkinName : disabledSkinName);
                _local_2 = ((selected) ? "selectedDisabled" : "disabled");
            }
            else
            {
                if (phase == ButtonPhase.UP)
                {
                    _local_1 = ((selected) ? selectedUpSkinName : upSkinName);
                    _local_2 = ((selected) ? "selectedUp" : "up");
                }
                else
                {
                    if (phase == ButtonPhase.OVER)
                    {
                        _local_1 = ((selected) ? selectedOverSkinName : overSkinName);
                        _local_2 = ((selected) ? "selectedOver" : "over");
                    }
                    else
                    {
                        if (phase == ButtonPhase.DOWN)
                        {
                            _local_1 = ((selected) ? selectedDownSkinName : downSkinName);
                            _local_2 = ((selected) ? "selectedDown" : "down");
                        };
                    };
                };
            };
            viewSkinForPhase(_local_1, _local_2);
        }

        override public function styleChanged(_arg_1:String):void
        {
            styleChangedFlag = true;
            super.styleChanged(_arg_1);
            if (((!(_arg_1)) || (_arg_1 == "styleName")))
            {
                changeSkins();
                changeIcons();
                if (initialized)
                {
                    viewSkin();
                    viewIcon();
                };
            }
            else
            {
                if (_arg_1.toLowerCase().indexOf("skin") != -1)
                {
                    changeSkins();
                }
                else
                {
                    if (_arg_1.toLowerCase().indexOf("icon") != -1)
                    {
                        changeIcons();
                        invalidateSize();
                    };
                };
            };
        }

        public function set emphasized(_arg_1:Boolean):void
        {
            _emphasized = _arg_1;
            emphasizedChanged = true;
            invalidateDisplayList();
        }

        mx_internal function viewIcon():void
        {
            var _local_1:String = getCurrentIconName();
            viewIconForPhase(_local_1);
        }

        override public function set toolTip(_arg_1:String):void
        {
            super.toolTip = _arg_1;
            if (_arg_1)
            {
                toolTipSet = true;
            }
            else
            {
                toolTipSet = false;
                invalidateDisplayList();
            };
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (((hasFontContextChanged()) && (!(textField == null))))
            {
                removeChild(DisplayObject(textField));
                textField = null;
            };
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.styleName = this;
                addChild(DisplayObject(textField));
                enabledChanged = true;
                toggleChanged = true;
            };
            if (!initialized)
            {
                viewSkin();
                viewIcon();
            };
            if (enabledChanged)
            {
                textField.enabled = enabled;
                if (((currentIcon) && (currentIcon is IUIComponent)))
                {
                    IUIComponent(currentIcon).enabled = enabled;
                };
                enabledChanged = false;
            };
            if (toggleChanged)
            {
                if (!toggle)
                {
                    selected = false;
                };
                toggleChanged = false;
            };
        }

        mx_internal function changeSkins():void
        {
            var _local_1:int = skins.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                removeChild(skins[_local_2]);
                _local_2++;
            };
            skins = [];
            skinMeasuredWidth = NaN;
            skinMeasuredHeight = NaN;
            checkedDefaultSkin = false;
            defaultSkinUsesStates = false;
            if (((initialized) && (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)))
            {
                viewSkin();
                invalidateSize();
            };
        }

        private function autoRepeatTimer_timerHandler(_arg_1:Event):void
        {
            if (!enabled)
            {
                return;
            };
            dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
        }

        private function previousVersion_layoutContents(_arg_1:Number, _arg_2:Number, _arg_3:Boolean):void
        {
            var _local_20:TextLineMetrics;
            var _local_28:Number;
            var _local_29:MoveEvent;
            var _local_4:Number = 0;
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            var _local_8:Number = 0;
            var _local_9:Number = 0;
            var _local_10:Number = 0;
            var _local_11:Number = 0;
            var _local_12:Number = 2;
            var _local_13:Number = 2;
            var _local_14:Number = getStyle("paddingLeft");
            var _local_15:Number = getStyle("paddingRight");
            var _local_16:Number = getStyle("paddingTop");
            var _local_17:Number = getStyle("paddingBottom");
            var _local_18:Number = 0;
            var _local_19:Number = 0;
            if (label)
            {
                _local_20 = measureText(label);
                if (_local_20.width > 0)
                {
                    _local_18 = (((_local_14 + _local_15) + getStyle("textIndent")) + _local_20.width);
                };
                _local_19 = _local_20.height;
            }
            else
            {
                _local_20 = measureText("Wj");
                _local_19 = _local_20.height;
            };
            var _local_21:Number = ((_arg_3) ? buttonOffset : 0);
            var _local_22:String = getStyle("textAlign");
            var _local_23:EdgeMetrics = (((currentSkin) && (currentSkin is IRectangularBorder)) ? IRectangularBorder(currentSkin).borderMetrics : null);
            var _local_24:Number = _arg_1;
            var _local_25:Number = ((_arg_2 - _local_16) - _local_17);
            if (_local_23)
            {
                _local_24 = (_local_24 - (_local_23.left + _local_23.right));
                _local_25 = (_local_25 - (_local_23.top + _local_23.bottom));
            };
            if (currentIcon)
            {
                _local_8 = currentIcon.width;
                _local_9 = currentIcon.height;
            };
            if (((labelPlacement == ButtonLabelPlacement.LEFT) || (labelPlacement == ButtonLabelPlacement.RIGHT)))
            {
                _local_12 = getStyle("horizontalGap");
                if (((_local_8 == 0) || (_local_18 == 0)))
                {
                    _local_12 = 0;
                };
                if (_local_18 > 0)
                {
                    textField.width = (_local_4 = Math.max(((((_local_24 - _local_8) - _local_12) - _local_14) - _local_15), 0));
                }
                else
                {
                    textField.width = (_local_4 = 0);
                };
                textField.height = (_local_5 = Math.min((_local_25 + 2), (_local_19 + UITextField.TEXT_HEIGHT_PADDING)));
                if (labelPlacement == ButtonLabelPlacement.RIGHT)
                {
                    _local_6 = (_local_8 + _local_12);
                    if (centerContent)
                    {
                        if (_local_22 == "left")
                        {
                            _local_6 = (_local_6 + _local_14);
                        }
                        else
                        {
                            if (_local_22 == "right")
                            {
                                _local_6 = (_local_6 + ((((_local_24 - _local_4) - _local_8) - _local_12) - _local_14));
                            }
                            else
                            {
                                _local_28 = ((((_local_24 - _local_4) - _local_8) - _local_12) / 2);
                                _local_6 = (_local_6 + Math.max(_local_28, _local_14));
                            };
                        };
                    };
                    _local_10 = (_local_6 - (_local_8 + _local_12));
                    if (!centerContent)
                    {
                        _local_6 = (_local_6 + _local_14);
                    };
                }
                else
                {
                    _local_6 = ((((_local_24 - _local_4) - _local_8) - _local_12) - _local_15);
                    if (centerContent)
                    {
                        if (_local_22 == "left")
                        {
                            _local_6 = 2;
                        }
                        else
                        {
                            if (_local_22 == "right")
                            {
                                _local_6--;
                            }
                            else
                            {
                                if (_local_6 > 0)
                                {
                                    _local_6 = (_local_6 / 2);
                                };
                            };
                        };
                    };
                    _local_10 = ((_local_6 + _local_4) + _local_12);
                };
                _local_11 = (_local_7 = 0);
                if (centerContent)
                {
                    _local_11 = (Math.round(((_local_25 - _local_9) / 2)) + _local_16);
                    _local_7 = (Math.round(((_local_25 - _local_5) / 2)) + _local_16);
                }
                else
                {
                    _local_7 = (_local_7 + (Math.max(0, ((_local_25 - _local_5) / 2)) + _local_16));
                    _local_11 = (_local_11 + (Math.max(0, (((_local_25 - _local_9) / 2) - 1)) + _local_16));
                };
            }
            else
            {
                _local_13 = getStyle("verticalGap");
                if (((_local_9 == 0) || (_local_19 == 0)))
                {
                    _local_13 = 0;
                };
                if (_local_18 > 0)
                {
                    textField.width = (_local_4 = Math.min(_local_24, (_local_18 + UITextField.TEXT_WIDTH_PADDING)));
                    textField.height = (_local_5 = Math.min(((_local_25 - _local_9) + 1), (_local_19 + 5)));
                }
                else
                {
                    textField.width = (_local_4 = 0);
                    textField.height = (_local_5 = 0);
                };
                _local_6 = ((_local_24 - _local_4) / 2);
                _local_10 = ((_local_24 - _local_8) / 2);
                if (labelPlacement == ButtonLabelPlacement.TOP)
                {
                    _local_7 = (((_local_25 - _local_5) - _local_9) - _local_13);
                    if (((centerContent) && (_local_7 > 0)))
                    {
                        _local_7 = (_local_7 / 2);
                    };
                    _local_7 = (_local_7 + _local_16);
                    _local_11 = (((_local_7 + _local_5) + _local_13) - 3);
                }
                else
                {
                    _local_7 = ((_local_9 + _local_13) + _local_16);
                    if (centerContent)
                    {
                        _local_7 = (_local_7 + (((((_local_25 - _local_5) - _local_9) - _local_13) / 2) + 1));
                    };
                    _local_11 = (((_local_7 - _local_9) - _local_13) + 3);
                };
            };
            var _local_26:Number = _local_21;
            var _local_27:Number = _local_21;
            if (_local_23)
            {
                _local_26 = (_local_26 + _local_23.left);
                _local_27 = (_local_27 + _local_23.top);
            };
            textField.x = (_local_6 + _local_26);
            textField.y = (_local_7 + _local_27);
            if (currentIcon)
            {
                _local_10 = (_local_10 + _local_26);
                _local_11 = (_local_11 + _local_27);
                _local_29 = new MoveEvent(MoveEvent.MOVE);
                _local_29.oldX = currentIcon.x;
                _local_29.oldY = currentIcon.y;
                currentIcon.x = Math.round(_local_10);
                currentIcon.y = Math.round(_local_11);
                currentIcon.dispatchEvent(_local_29);
            };
            if (currentSkin)
            {
                setChildIndex(DisplayObject(currentSkin), (numChildren - 1));
            };
            if (currentIcon)
            {
                setChildIndex(DisplayObject(currentIcon), (numChildren - 1));
            };
            if (textField)
            {
                setChildIndex(DisplayObject(textField), (numChildren - 1));
            };
        }

        private function systemManager_mouseUpHandler(_arg_1:MouseEvent):void
        {
            if (contains(DisplayObject(_arg_1.target)))
            {
                return;
            };
            phase = ButtonPhase.UP;
            buttonReleased();
            _arg_1.updateAfterEvent();
        }

        public function set label(_arg_1:String):void
        {
            labelSet = true;
            if (_label != _arg_1)
            {
                _label = _arg_1;
                labelChanged = true;
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("labelChanged"));
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_5:IFlexDisplayObject;
            var _local_6:Boolean;
            super.updateDisplayList(_arg_1, _arg_2);
            if (emphasizedChanged)
            {
                changeSkins();
                emphasizedChanged = false;
            };
            var _local_3:int = skins.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = IFlexDisplayObject(skins[_local_4]);
                _local_5.setActualSize(_arg_1, _arg_2);
                _local_4++;
            };
            viewSkin();
            viewIcon();
            layoutContents(_arg_1, _arg_2, (phase == ButtonPhase.DOWN));
            if (((((oldUnscaledWidth > _arg_1) || (!(textField.text == label))) || (labelChanged)) || (styleChangedFlag)))
            {
                textField.text = label;
                _local_6 = textField.truncateToFit();
                if (!toolTipSet)
                {
                    if (_local_6)
                    {
                        super.toolTip = label;
                    }
                    else
                    {
                        super.toolTip = null;
                    };
                };
                styleChangedFlag = false;
                labelChanged = false;
            };
            oldUnscaledWidth = _arg_1;
        }

        private function stage_mouseLeaveHandler(_arg_1:Event):void
        {
            phase = ButtonPhase.UP;
            buttonReleased();
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = _arg_1;
        }


    }
}//package mx.controls

