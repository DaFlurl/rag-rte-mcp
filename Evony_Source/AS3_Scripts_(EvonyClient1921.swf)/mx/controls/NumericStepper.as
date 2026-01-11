// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.NumericStepper

package mx.controls
{
    import mx.core.UIComponent;
    import mx.core.IDataRenderer;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.managers.IFocusManagerComponent;
    import mx.core.IIMESupport;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.controls.listClasses.BaseListData;
    import mx.managers.IFocusManager;
    import flash.events.FocusEvent;
    import mx.styles.StyleProxy;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import mx.events.NumericStepperEvent;
    import flash.display.DisplayObject;
    import flash.ui.Keyboard;
    import flash.text.TextLineMetrics;
    import mx.core.UITextField;
    import mx.core.FlexVersion;
    import flash.text.TextField;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NumericStepper extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IIMESupport, IListItemRenderer 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var _downArrowStyleFilters:Object = {
            "cornerRadius":"cornerRadius",
            "highlightAlphas":"highlightAlphas",
            "downArrowUpSkin":"downArrowUpSkin",
            "downArrowOverSkin":"downArrowOverSkin",
            "downArrowDownSkin":"downArrowDownSkin",
            "downArrowDisabledSkin":"downArrowDisabledSkin",
            "downArrowSkin":"downArrowSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval"
        };
        private static var _inputFieldStyleFilters:Object = {
            "backgroundAlpha":"backgroundAlpha",
            "backgroundColor":"backgroundColor",
            "backgroundImage":"backgroundImage",
            "backgroundDisabledColor":"backgroundDisabledColor",
            "backgroundSize":"backgroundSize",
            "borderAlpha":"borderAlpha",
            "borderColor":"borderColor",
            "borderSides":"borderSides",
            "borderSkin":"borderSkin",
            "borderStyle":"borderStyle",
            "borderThickness":"borderThickness",
            "dropShadowColor":"dropShadowColor",
            "dropShadowEnabled":"dropShadowEnabled",
            "embedFonts":"embedFonts",
            "focusAlpha":"focusAlpha",
            "focusBlendMode":"focusBlendMode",
            "focusRoundedCorners":"focusRoundedCorners",
            "focusThickness":"focusThickness",
            "paddingLeft":"paddingLeft",
            "paddingRight":"paddingRight",
            "shadowDirection":"shadowDirection",
            "shadowDistance":"shadowDistance",
            "textDecoration":"textDecoration"
        };
        private static var _upArrowStyleFilters:Object = {
            "cornerRadius":"cornerRadius",
            "highlightAlphas":"highlightAlphas",
            "upArrowUpSkin":"upArrowUpSkin",
            "upArrowOverSkin":"upArrowOverSkin",
            "upArrowDownSkin":"upArrowDownSkin",
            "upArrowDisabledSkin":"upArrowDisabledSkin",
            "upArrowSkin":"upArrowSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval"
        };

        private var valueChanged:Boolean = false;
        mx_internal var nextButton:Button;
        private var valueSet:Boolean;
        private var enabledChanged:Boolean = false;
        mx_internal var prevButton:Button;
        private var _maxChars:int = 0;
        private var _stepSize:Number = 1;
        mx_internal var inputField:TextInput;
        private var _value:Number = 0;
        private var lastValue:Number = 0;
        private var _data:Object;
        private var maxCharsChanged:Boolean = false;
        private var _tabIndex:int = -1;
        private var proposedValue:Number = 0;
        private var tabIndexChanged:Boolean = false;
        private var _previousValue:Number = 0;
        private var _nextValue:Number = 0;
        private var _imeMode:String = null;
        private var _listData:BaseListData;
        private var _minimum:Number = 0;
        private var _maximum:Number = 10;

        public function NumericStepper()
        {
            tabChildren = true;
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
            if (inputField)
            {
                inputField.imeMode = _imeMode;
            };
        }

        [Bindable("minimumChanged")]
        public function get minimum():Number
        {
            return (_minimum);
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            var _local_2:IFocusManager = focusManager;
            if (_local_2)
            {
                _local_2.defaultButtonEnabled = true;
            };
            super.focusOutHandler(_arg_1);
            takeValueFromTextField(_arg_1);
        }

        private function checkRange(_arg_1:Number):Boolean
        {
            return ((_arg_1 >= minimum) && (_arg_1 <= maximum));
        }

        override protected function createChildren():void
        {
            super.createChildren();
            if (!inputField)
            {
                inputField = new TextInput();
                inputField.styleName = new StyleProxy(this, inputFieldStyleFilters);
                inputField.focusEnabled = false;
                inputField.restrict = "0-9\\-\\.\\,";
                inputField.maxChars = _maxChars;
                inputField.text = String(_value);
                inputField.parentDrawsFocus = true;
                inputField.imeMode = _imeMode;
                inputField.addEventListener(FocusEvent.FOCUS_IN, inputField_focusInHandler);
                inputField.addEventListener(FocusEvent.FOCUS_OUT, inputField_focusOutHandler);
                inputField.addEventListener(KeyboardEvent.KEY_DOWN, inputField_keyDownHandler);
                inputField.addEventListener(Event.CHANGE, inputField_changeHandler);
                addChild(inputField);
            };
            if (!nextButton)
            {
                nextButton = new Button();
                nextButton.styleName = new StyleProxy(this, upArrowStyleFilters);
                nextButton.upSkinName = "upArrowUpSkin";
                nextButton.overSkinName = "upArrowOverSkin";
                nextButton.downSkinName = "upArrowDownSkin";
                nextButton.disabledSkinName = "upArrowDisabledSkin";
                nextButton.skinName = "upArrowSkin";
                nextButton.upIconName = "";
                nextButton.overIconName = "";
                nextButton.downIconName = "";
                nextButton.disabledIconName = "";
                nextButton.focusEnabled = false;
                nextButton.autoRepeat = true;
                nextButton.addEventListener(MouseEvent.CLICK, buttonClickHandler);
                nextButton.addEventListener(FlexEvent.BUTTON_DOWN, buttonDownHandler);
                addChild(nextButton);
            };
            if (!prevButton)
            {
                prevButton = new Button();
                prevButton.styleName = new StyleProxy(this, downArrowStyleFilters);
                prevButton.upSkinName = "downArrowUpSkin";
                prevButton.overSkinName = "downArrowOverSkin";
                prevButton.downSkinName = "downArrowDownSkin";
                prevButton.disabledSkinName = "downArrowDisabledSkin";
                prevButton.skinName = "downArrowSkin";
                prevButton.upIconName = "";
                prevButton.overIconName = "";
                prevButton.downIconName = "";
                prevButton.disabledIconName = "";
                prevButton.focusEnabled = false;
                prevButton.autoRepeat = true;
                prevButton.addEventListener(MouseEvent.CLICK, buttonClickHandler);
                prevButton.addEventListener(FlexEvent.BUTTON_DOWN, buttonDownHandler);
                addChild(prevButton);
            };
        }

        public function set minimum(_arg_1:Number):void
        {
            _minimum = _arg_1;
            if (!valueChanged)
            {
                this.value = this.value;
                valueSet = false;
            };
            dispatchEvent(new Event("minimumChanged"));
        }

        [Bindable("maximumChanged")]
        public function get maximum():Number
        {
            return (_maximum);
        }

        private function inputField_focusOutHandler(_arg_1:FocusEvent):void
        {
            focusOutHandler(_arg_1);
            dispatchEvent(new FocusEvent(_arg_1.type, false, false, _arg_1.relatedObject, _arg_1.shiftKey, _arg_1.keyCode));
        }

        private function setValue(_arg_1:Number, _arg_2:Boolean=true, _arg_3:Event=null):void
        {
            var _local_5:NumericStepperEvent;
            var _local_4:Number = checkValidValue(_arg_1);
            if (_local_4 == lastValue)
            {
                return;
            };
            lastValue = (_value = _local_4);
            inputField.text = _local_4.toString();
            if (_arg_2)
            {
                _local_5 = new NumericStepperEvent(NumericStepperEvent.CHANGE);
                _local_5.value = _value;
                _local_5.triggerEvent = _arg_3;
                dispatchEvent(_local_5);
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        protected function get downArrowStyleFilters():Object
        {
            return (_downArrowStyleFilters);
        }

        private function takeValueFromTextField(_arg_1:Event=null):void
        {
            var _local_3:Number;
            var _local_2:Number = Number(inputField.text);
            if ((((!(_local_2 == lastValue)) && ((Math.abs((_local_2 - lastValue)) >= 1E-6) || (isNaN(_local_2)))) || (inputField.text == "")))
            {
                _local_3 = checkValidValue(Number(inputField.text));
                inputField.text = _local_3.toString();
                setValue(_local_3, (!(_arg_1 == null)), _arg_1);
            };
        }

        private function inputField_focusInHandler(_arg_1:FocusEvent):void
        {
            focusInHandler(_arg_1);
            dispatchEvent(new FocusEvent(_arg_1.type, false, false, _arg_1.relatedObject, _arg_1.shiftKey, _arg_1.keyCode));
        }

        override public function get tabIndex():int
        {
            return (_tabIndex);
        }

        public function get nextValue():Number
        {
            if (checkRange((value + stepSize)))
            {
                _nextValue = (value + stepSize);
            };
            return (_nextValue);
        }

        public function set maximum(_arg_1:Number):void
        {
            _maximum = _arg_1;
            if (!valueChanged)
            {
                this.value = this.value;
                valueSet = false;
            };
            dispatchEvent(new Event("maximumChanged"));
        }

        override public function get enabled():Boolean
        {
            return (super.enabled);
        }

        override protected function isOurFocus(_arg_1:DisplayObject):Boolean
        {
            return ((_arg_1 == inputField) || (super.isOurFocus(_arg_1)));
        }

        private function buttonPress(_arg_1:Button, _arg_2:Event=null):void
        {
            var _local_3:Number;
            if (enabled)
            {
                takeValueFromTextField();
                _local_3 = lastValue;
                setValue(((_arg_1 == nextButton) ? (lastValue + stepSize) : (lastValue - stepSize)), true, _arg_2);
                if (_local_3 != lastValue)
                {
                    inputField.getTextField().setSelection(0, 0);
                };
            };
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
            if (!valueSet)
            {
                this.value = ((_listData) ? parseFloat(_listData.label) : Number(_data));
                valueSet = false;
            };
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        protected function get upArrowStyleFilters():Object
        {
            return (_upArrowStyleFilters);
        }

        private function inputField_keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            switch (_arg_1.keyCode)
            {
                case Keyboard.DOWN:
                    _local_2 = (value - stepSize);
                    setValue(_local_2, true);
                    break;
                case Keyboard.UP:
                    _local_2 = (stepSize + value);
                    setValue(_local_2, true);
                    break;
                case Keyboard.HOME:
                    inputField.text = minimum.toString();
                    setValue(minimum, true);
                    break;
                case Keyboard.END:
                    inputField.text = maximum.toString();
                    setValue(maximum, true);
                    break;
                case Keyboard.ENTER:
                case Keyboard.TAB:
                    _local_3 = Number(inputField.text);
                    if (((!(_local_3 == lastValue)) && ((Math.abs((_local_3 - lastValue)) >= 1E-6) || (isNaN(_local_3)))))
                    {
                        _local_4 = checkValidValue(Number(inputField.text));
                        inputField.text = _local_4.toString();
                        setValue(_local_4, true);
                    };
                    _arg_1.stopImmediatePropagation();
                    break;
            };
            dispatchEvent(_arg_1);
        }

        override protected function measure():void
        {
            var _local_5:Number;
            var _local_8:Number;
            super.measure();
            var _local_1:Number = ((minimum.toString().length > maximum.toString().length) ? minimum : maximum);
            _local_1 = (_local_1 + stepSize);
            var _local_2:TextLineMetrics = measureText(checkValidValue(_local_1).toString());
            var _local_3:Number = inputField.getExplicitOrMeasuredHeight();
            var _local_4:Number = (prevButton.getExplicitOrMeasuredHeight() + nextButton.getExplicitOrMeasuredHeight());
            _local_5 = Math.max(_local_3, _local_4);
            _local_5 = Math.max(DEFAULT_MEASURED_MIN_HEIGHT, _local_5);
            var _local_6:Number = (_local_2.width + UITextField.TEXT_WIDTH_PADDING);
            var _local_7:Number = Math.max(prevButton.getExplicitOrMeasuredWidth(), nextButton.getExplicitOrMeasuredWidth());
            _local_8 = ((_local_6 + _local_7) + 20);
            _local_8 = Math.max(DEFAULT_MEASURED_MIN_WIDTH, _local_8);
            measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
            measuredMinHeight = DEFAULT_MEASURED_MIN_HEIGHT;
            measuredWidth = _local_8;
            measuredHeight = _local_5;
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            super.focusInHandler(_arg_1);
            var _local_2:IFocusManager = focusManager;
            if (_local_2)
            {
                _local_2.defaultButtonEnabled = false;
            };
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get value():Number
        {
            return ((valueChanged) ? proposedValue : _value);
        }

        protected function get inputFieldStyleFilters():Object
        {
            return (_inputFieldStyleFilters);
        }

        override public function set tabIndex(_arg_1:int):void
        {
            if (_arg_1 == _tabIndex)
            {
                return;
            };
            _tabIndex = _arg_1;
            tabIndexChanged = true;
            invalidateProperties();
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            enabledChanged = true;
            invalidateProperties();
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return ((inputField) ? inputField.baselinePosition : NaN);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return (inputField.y + inputField.baselinePosition);
        }

        override public function setFocus():void
        {
            if (stage)
            {
                stage.focus = TextField(inputField.getTextField());
            };
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            if (!_listData)
            {
                data = this.value;
            };
            return (_data);
        }

        public function set maxChars(_arg_1:int):void
        {
            if (_arg_1 == _maxChars)
            {
                return;
            };
            _maxChars = _arg_1;
            maxCharsChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("maxCharsChanged"));
        }

        private function buttonDownHandler(_arg_1:FlexEvent):void
        {
            buttonPress(Button(_arg_1.currentTarget), _arg_1);
        }

        public function get previousValue():Number
        {
            if (checkRange((_value - stepSize)))
            {
                _previousValue = (value - stepSize);
            };
            return (_previousValue);
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (maxCharsChanged)
            {
                maxCharsChanged = false;
                inputField.maxChars = _maxChars;
            };
            if (valueChanged)
            {
                valueChanged = false;
                setValue(((isNaN(proposedValue)) ? 0 : proposedValue), false);
            };
            if (enabledChanged)
            {
                enabledChanged = false;
                prevButton.enabled = enabled;
                nextButton.enabled = enabled;
                inputField.enabled = enabled;
            };
            if (tabIndexChanged)
            {
                inputField.tabIndex = _tabIndex;
                tabIndexChanged = false;
            };
        }

        private function inputField_changeHandler(_arg_1:Event):void
        {
            _arg_1.stopImmediatePropagation();
            var _local_2:Number = Number(inputField.text);
            if ((((!(_local_2 == value)) && ((Math.abs((_local_2 - value)) >= 1E-6) || (isNaN(_local_2)))) || (inputField.text == "")))
            {
                _value = checkValidValue(_local_2);
            };
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = _arg_1;
        }

        [Bindable("maxCharsChanged")]
        public function get maxChars():int
        {
            return (_maxChars);
        }

        public function set stepSize(_arg_1:Number):void
        {
            _stepSize = _arg_1;
            if (!valueChanged)
            {
                this.value = this.value;
                valueSet = false;
            };
            dispatchEvent(new Event("stepSizeChanged"));
        }

        public function set value(_arg_1:Number):void
        {
            valueSet = true;
            proposedValue = _arg_1;
            valueChanged = true;
            invalidateProperties();
            invalidateSize();
        }

        [Bindable("stepSizeChanged")]
        public function get stepSize():Number
        {
            return (_stepSize);
        }

        private function buttonClickHandler(_arg_1:MouseEvent):void
        {
            inputField.setFocus();
            inputField.getTextField().setSelection(0, 0);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = nextButton.getExplicitOrMeasuredWidth();
            var _local_4:Number = Math.round((_arg_2 / 2));
            var _local_5:Number = (_arg_2 - _local_4);
            nextButton.x = (_arg_1 - _local_3);
            nextButton.y = 0;
            nextButton.setActualSize(_local_3, _local_5);
            prevButton.x = (_arg_1 - _local_3);
            prevButton.y = (_arg_2 - _local_4);
            prevButton.setActualSize(_local_3, _local_4);
            inputField.setActualSize((_arg_1 - _local_3), _arg_2);
        }

        private function checkValidValue(_arg_1:Number):Number
        {
            var _local_4:Number;
            if (isNaN(_arg_1))
            {
                return (this.value);
            };
            var _local_2:Number = (stepSize * Math.round((_arg_1 / stepSize)));
            var _local_3:Array = new String((1 + stepSize)).split(".");
            if (_local_3.length == 2)
            {
                _local_4 = Math.pow(10, _local_3[1].length);
                _local_2 = (Math.round((_local_2 * _local_4)) / _local_4);
            };
            if (_local_2 > maximum)
            {
                return (maximum);
            };
            if (_local_2 < minimum)
            {
                return (minimum);
            };
            return (_local_2);
        }


    }
}//package mx.controls

