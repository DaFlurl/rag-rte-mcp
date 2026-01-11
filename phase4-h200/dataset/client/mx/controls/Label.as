// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.Label

package mx.controls
{
    import mx.core.UIComponent;
    import mx.core.IDataRenderer;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.IFontContextComponent;
    import mx.controls.listClasses.BaseListData;
    import mx.core.IUITextField;
    import flash.text.StyleSheet;
    import flash.events.Event;
    import flash.text.TextLineMetrics;
    import mx.core.FlexVersion;
    import flash.geom.Rectangle;
    import mx.core.UITextField;
    import mx.events.FlexEvent;
    import mx.core.IFlexModuleFactory;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Label extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _selectable:Boolean = false;
        private var _text:String = "";
        private var _data:Object;
        mx_internal var htmlTextChanged:Boolean = false;
        private var _tabIndex:int = -1;
        private var styleSheetChanged:Boolean = false;
        private var explicitHTMLText:String = null;
        private var _textWidth:Number;
        private var enabledChanged:Boolean = false;
        private var condenseWhiteChanged:Boolean = false;
        private var _listData:BaseListData;
        protected var textField:IUITextField;
        private var _htmlText:String = "";
        private var _condenseWhite:Boolean = false;
        private var _textHeight:Number;
        private var _styleSheet:StyleSheet;
        mx_internal var textChanged:Boolean = false;
        public var truncateToFit:Boolean = true;
        private var textSet:Boolean;
        private var selectableChanged:Boolean;
        private var toolTipSet:Boolean = false;

        public function Label()
        {
            tabChildren = true;
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            if (_arg_1 == enabled)
            {
                return;
            };
            super.enabled = _arg_1;
            enabledChanged = true;
            invalidateProperties();
        }

        private function textField_textFieldStyleChangeHandler(_arg_1:Event):void
        {
            textFieldChanged(true);
        }

        override public function get baselinePosition():Number
        {
            var _local_1:String;
            var _local_2:TextLineMetrics;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (!textField)
                {
                    return (NaN);
                };
                validateNow();
                _local_1 = ((isHTML) ? explicitHTMLText : text);
                if (_local_1 == "")
                {
                    _local_1 = " ";
                };
                _local_2 = ((isHTML) ? measureHTMLText(_local_1) : measureText(_local_1));
                return (textField.y + _local_2.ascent);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return (textField.y + textField.baselinePosition);
        }

        private function textField_textModifiedHandler(_arg_1:Event):void
        {
            textFieldChanged(false);
        }

        public function set condenseWhite(_arg_1:Boolean):void
        {
            if (_arg_1 == _condenseWhite)
            {
                return;
            };
            _condenseWhite = _arg_1;
            condenseWhiteChanged = true;
            if (isHTML)
            {
                htmlTextChanged = true;
            };
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("condenseWhiteChanged"));
        }

        public function get textWidth():Number
        {
            return (_textWidth);
        }

        override protected function createChildren():void
        {
            super.createChildren();
            if (!textField)
            {
                createTextField(-1);
            };
        }

        mx_internal function getTextField():IUITextField
        {
            return (textField);
        }

        private function measureTextFieldBounds(_arg_1:String):Rectangle
        {
            var _local_2:TextLineMetrics = ((isHTML) ? measureHTMLText(_arg_1) : measureText(_arg_1));
            return (new Rectangle(0, 0, (_local_2.width + UITextField.TEXT_WIDTH_PADDING), (_local_2.height + UITextField.TEXT_HEIGHT_PADDING)));
        }

        mx_internal function getMinimumText(_arg_1:String):String
        {
            if (((!(_arg_1)) || (_arg_1.length < 2)))
            {
                _arg_1 = "Wj";
            };
            return (_arg_1);
        }

        private function textFieldChanged(_arg_1:Boolean):void
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            if (!_arg_1)
            {
                _local_2 = (!(_text == textField.text));
                _text = textField.text;
            };
            _local_3 = (!(_htmlText == textField.htmlText));
            _htmlText = textField.htmlText;
            if (_local_2)
            {
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            };
            if (_local_3)
            {
                dispatchEvent(new Event("htmlTextChanged"));
            };
            _textWidth = textField.textWidth;
            _textHeight = textField.textHeight;
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        [Bindable("valueCommit")]
        public function get text():String
        {
            return (_text);
        }

        public function get textHeight():Number
        {
            return (_textHeight);
        }

        public function get styleSheet():StyleSheet
        {
            return (_styleSheet);
        }

        public function set selectable(_arg_1:Boolean):void
        {
            if (_arg_1 == selectable)
            {
                return;
            };
            _selectable = _arg_1;
            selectableChanged = true;
            invalidateProperties();
        }

        override public function get tabIndex():int
        {
            return (_tabIndex);
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        mx_internal function removeTextField():void
        {
            if (textField)
            {
                textField.removeEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.removeEventListener("textInsert", textField_textModifiedHandler);
                textField.removeEventListener("textReplace", textField_textModifiedHandler);
                removeChild(DisplayObject(textField));
                textField = null;
            };
        }

        override public function set toolTip(_arg_1:String):void
        {
            super.toolTip = _arg_1;
            toolTipSet = (!(_arg_1 == null));
        }

        mx_internal function createTextField(_arg_1:int):void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.enabled = enabled;
                textField.ignorePadding = true;
                textField.selectable = selectable;
                textField.styleName = this;
                textField.addEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.addEventListener("textInsert", textField_textModifiedHandler);
                textField.addEventListener("textReplace", textField_textModifiedHandler);
                if (_arg_1 == -1)
                {
                    addChild(DisplayObject(textField));
                }
                else
                {
                    addChildAt(DisplayObject(textField), _arg_1);
                };
            };
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (((hasFontContextChanged()) && (!(textField == null))))
            {
                removeTextField();
                condenseWhiteChanged = true;
                enabledChanged = true;
                selectableChanged = true;
                textChanged = true;
            };
            if (!textField)
            {
                createTextField(-1);
            };
            if (condenseWhiteChanged)
            {
                textField.condenseWhite = _condenseWhite;
                condenseWhiteChanged = false;
            };
            textField.tabIndex = tabIndex;
            if (enabledChanged)
            {
                textField.enabled = enabled;
                enabledChanged = false;
            };
            if (selectableChanged)
            {
                textField.selectable = _selectable;
                selectableChanged = false;
            };
            if (styleSheetChanged)
            {
                textField.styleSheet = _styleSheet;
                styleSheetChanged = false;
            };
            if (((textChanged) || (htmlTextChanged)))
            {
                if (isHTML)
                {
                    textField.htmlText = explicitHTMLText;
                }
                else
                {
                    textField.text = _text;
                };
                textFieldChanged(false);
                textChanged = false;
                htmlTextChanged = false;
            };
        }

        [Bindable("condenseWhiteChanged")]
        public function get condenseWhite():Boolean
        {
            return (_condenseWhite);
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = _arg_1;
        }

        private function get isHTML():Boolean
        {
            return (!(explicitHTMLText == null));
        }

        public function get selectable():Boolean
        {
            return (_selectable);
        }

        public function set text(_arg_1:String):void
        {
            textSet = true;
            if (!_arg_1)
            {
                _arg_1 = "";
            };
            if (((!(isHTML)) && (_arg_1 == _text)))
            {
                return;
            };
            _text = _arg_1;
            textChanged = true;
            _htmlText = null;
            explicitHTMLText = null;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        public function set data(_arg_1:Object):void
        {
            var _local_2:*;
            _data = _arg_1;
            if (_listData)
            {
                _local_2 = _listData.label;
            }
            else
            {
                if (_data != null)
                {
                    if ((_data is String))
                    {
                        _local_2 = String(_data);
                    }
                    else
                    {
                        _local_2 = _data.toString();
                    };
                };
            };
            if (((!(_local_2 === undefined)) && (!(textSet))))
            {
                text = _local_2;
                textSet = false;
            };
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        override protected function measure():void
        {
            super.measure();
            var _local_1:String = ((isHTML) ? explicitHTMLText : text);
            _local_1 = getMinimumText(_local_1);
            var _local_2:Rectangle = measureTextFieldBounds(_local_1);
            measuredMinWidth = (measuredWidth = ((_local_2.width + getStyle("paddingLeft")) + getStyle("paddingRight")));
            measuredMinHeight = (measuredHeight = ((_local_2.height + getStyle("paddingTop")) + getStyle("paddingBottom")));
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        public function set styleSheet(_arg_1:StyleSheet):void
        {
            _styleSheet = _arg_1;
            styleSheetChanged = true;
            htmlTextChanged = true;
            invalidateProperties();
        }

        public function set htmlText(_arg_1:String):void
        {
            textSet = true;
            if (!_arg_1)
            {
                _arg_1 = "";
            };
            if (((isHTML) && (_arg_1 == explicitHTMLText)))
            {
                return;
            };
            _htmlText = _arg_1;
            htmlTextChanged = true;
            _text = null;
            explicitHTMLText = _arg_1;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("htmlTextChanged"));
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_9:Boolean;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = getStyle("paddingLeft");
            var _local_4:Number = getStyle("paddingTop");
            var _local_5:Number = getStyle("paddingRight");
            var _local_6:Number = getStyle("paddingBottom");
            textField.setActualSize(((_arg_1 - _local_3) - _local_5), ((_arg_2 - _local_4) - _local_6));
            textField.x = _local_3;
            textField.y = _local_4;
            var _local_7:String = ((isHTML) ? explicitHTMLText : text);
            var _local_8:Rectangle = measureTextFieldBounds(_local_7);
            if (truncateToFit)
            {
                if (isHTML)
                {
                    _local_9 = (_local_8.width > textField.width);
                }
                else
                {
                    textField.text = _text;
                    _local_9 = textField.truncateToFit();
                };
                if (!toolTipSet)
                {
                    super.toolTip = ((_local_9) ? text : null);
                };
            };
        }

        [Bindable("htmlTextChanged")]
        public function get htmlText():String
        {
            return (_htmlText);
        }

        public function getLineMetrics(_arg_1:int):TextLineMetrics
        {
            return ((textField) ? textField.getLineMetrics(_arg_1) : null);
        }

        override public function set tabIndex(_arg_1:int):void
        {
            _tabIndex = _arg_1;
            invalidateProperties();
        }


    }
}//package mx.controls

