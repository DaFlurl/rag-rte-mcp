// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.TextArea

package mx.controls
{
    import mx.core.ScrollControlBase;
    import mx.core.IDataRenderer;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.managers.IFocusManagerComponent;
    import mx.core.IIMESupport;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.IFontContextComponent;
    import mx.core.IUITextField;
    import mx.controls.listClasses.BaseListData;
    import flash.text.StyleSheet;
    import flash.accessibility.AccessibilityProperties;
    import mx.core.ScrollPolicy;
    import mx.managers.IFocusManager;
    import flash.system.IMEConversionMode;
    import flash.system.IME;
    import mx.events.FlexEvent;
    import flash.events.FocusEvent;
    import flash.events.TextEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import mx.core.UITextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.display.DisplayObject;
    import mx.core.IFlexModuleFactory;
    import flash.text.TextField;
    import mx.core.IInvalidating;
    import mx.core.FlexVersion;
    import mx.events.ScrollEvent;
    import mx.events.ScrollEventDetail;
    import flash.events.MouseEvent;
    import mx.events.ScrollEventDirection;
    import mx.core.EdgeMetrics;
    import flash.text.TextLineMetrics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TextArea extends ScrollControlBase implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IIMESupport, IListItemRenderer, IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _text:String = "";
        private var _selectable:Boolean = true;
        private var _textWidth:Number;
        private var _restrict:String = null;
        private var htmlTextChanged:Boolean = false;
        private var _maxChars:int = 0;
        private var enabledChanged:Boolean = false;
        private var _condenseWhite:Boolean = false;
        private var accessibilityPropertiesChanged:Boolean = false;
        private var _hScrollPosition:Number;
        private var _textHeight:Number;
        private var displayAsPasswordChanged:Boolean = false;
        private var prevMode:String = "UNKNOWN";
        private var selectableChanged:Boolean = false;
        private var restrictChanged:Boolean = false;
        private var selectionChanged:Boolean = false;
        private var maxCharsChanged:Boolean = false;
        private var _tabIndex:int = -1;
        private var errorCaught:Boolean = false;
        private var _selectionBeginIndex:int = 0;
        private var wordWrapChanged:Boolean = false;
        private var _data:Object;
        private var explicitHTMLText:String = null;
        private var styleSheetChanged:Boolean = false;
        private var tabIndexChanged:Boolean = false;
        private var editableChanged:Boolean = false;
        private var _editable:Boolean = true;
        private var allowScrollEvent:Boolean = true;
        private var _imeMode:String = null;
        private var condenseWhiteChanged:Boolean = false;
        protected var textField:IUITextField;
        private var _listData:BaseListData;
        private var _displayAsPassword:Boolean = false;
        private var _wordWrap:Boolean = true;
        private var _styleSheet:StyleSheet;
        private var textChanged:Boolean = false;
        private var _accessibilityProperties:AccessibilityProperties;
        private var _selectionEndIndex:int = 0;
        private var _htmlText:String = "";
        private var _vScrollPosition:Number;
        private var textSet:Boolean;

        public function TextArea()
        {
            tabChildren = true;
            _horizontalScrollPolicy = ScrollPolicy.AUTO;
            _verticalScrollPolicy = ScrollPolicy.AUTO;
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            var _local_2:IFocusManager = focusManager;
            if (_local_2)
            {
                _local_2.defaultButtonEnabled = true;
            };
            super.focusOutHandler(_arg_1);
            if (((!(_imeMode == null)) && (_editable)))
            {
                if (((!(IME.conversionMode == IMEConversionMode.UNKNOWN)) && (!(prevMode == IMEConversionMode.UNKNOWN))))
                {
                    IME.conversionMode = prevMode;
                };
                IME.enabled = false;
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        mx_internal function getTextField():IUITextField
        {
            return (textField);
        }

        private function textField_textInputHandler(_arg_1:TextEvent):void
        {
            _arg_1.stopImmediatePropagation();
            var _local_2:TextEvent = new TextEvent(TextEvent.TEXT_INPUT, false, true);
            _local_2.text = _arg_1.text;
            dispatchEvent(_local_2);
            if (_local_2.isDefaultPrevented())
            {
                _arg_1.preventDefault();
            };
        }

        override public function get accessibilityProperties():AccessibilityProperties
        {
            return (_accessibilityProperties);
        }

        override protected function createChildren():void
        {
            super.createChildren();
            createTextField(-1);
        }

        private function adjustScrollBars():void
        {
            var _local_1:Number = ((textField.bottomScrollV - textField.scrollV) + 1);
            var _local_2:Number = textField.numLines;
            setScrollBarProperties((textField.width + textField.maxScrollH), textField.width, textField.numLines, _local_1);
        }

        private function textFieldChanged(_arg_1:Boolean, _arg_2:Boolean):void
        {
            var _local_3:Boolean;
            var _local_4:Boolean;
            if (!_arg_1)
            {
                _local_3 = (!(_text == textField.text));
                _text = textField.text;
            };
            _local_4 = (!(_htmlText == textField.htmlText));
            _htmlText = textField.htmlText;
            if (_local_3)
            {
                dispatchEvent(new Event("textChanged"));
                if (_arg_2)
                {
                    dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                };
            };
            if (_local_4)
            {
                dispatchEvent(new Event("htmlTextChanged"));
            };
            _textWidth = textField.textWidth;
            _textHeight = textField.textHeight;
        }

        private function textField_ioErrorHandler(_arg_1:IOErrorEvent):void
        {
        }

        [Bindable("textChanged")]
        [NonCommittingChangeEvent("change")]
        public function get text():String
        {
            return (_text);
        }

        public function get styleSheet():StyleSheet
        {
            return (_styleSheet);
        }

        mx_internal function createTextField(_arg_1:int):void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.autoSize = TextFieldAutoSize.NONE;
                textField.enabled = enabled;
                textField.ignorePadding = true;
                textField.multiline = true;
                textField.selectable = true;
                textField.styleName = this;
                textField.tabEnabled = true;
                textField.type = TextFieldType.INPUT;
                textField.useRichTextClipboard = true;
                textField.wordWrap = true;
                textField.addEventListener(Event.CHANGE, textField_changeHandler);
                textField.addEventListener(Event.SCROLL, textField_scrollHandler);
                textField.addEventListener(IOErrorEvent.IO_ERROR, textField_ioErrorHandler);
                textField.addEventListener(TextEvent.TEXT_INPUT, textField_textInputHandler);
                textField.addEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.addEventListener("textFormatChange", textField_textFormatChangeHandler);
                textField.addEventListener("textInsert", textField_textModifiedHandler);
                textField.addEventListener("textReplace", textField_textModifiedHandler);
                textField.addEventListener("nativeDragDrop", textField_nativeDragDropHandler);
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

        override public function get tabIndex():int
        {
            return (_tabIndex);
        }

        override public function set accessibilityProperties(_arg_1:AccessibilityProperties):void
        {
            if (_arg_1 == _accessibilityProperties)
            {
                return;
            };
            _accessibilityProperties = _arg_1;
            accessibilityPropertiesChanged = true;
            invalidateProperties();
        }

        public function setSelection(_arg_1:int, _arg_2:int):void
        {
            _selectionBeginIndex = _arg_1;
            _selectionEndIndex = _arg_2;
            selectionChanged = true;
            invalidateProperties();
        }

        [Bindable("condenseWhiteChanged")]
        public function get condenseWhite():Boolean
        {
            return (_condenseWhite);
        }

        override protected function isOurFocus(_arg_1:DisplayObject):Boolean
        {
            return ((_arg_1 == textField) || (super.isOurFocus(_arg_1)));
        }

        [Bindable("displayAsPasswordChanged")]
        public function get displayAsPassword():Boolean
        {
            return (_displayAsPassword);
        }

        public function get selectionBeginIndex():int
        {
            return ((textField) ? textField.selectionBeginIndex : _selectionBeginIndex);
        }

        public function get selectable():Boolean
        {
            return (_selectable);
        }

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        override public function set verticalScrollPosition(_arg_1:Number):void
        {
            super.verticalScrollPosition = _arg_1;
            _vScrollPosition = _arg_1;
            if (textField)
            {
                textField.scrollV = (_arg_1 + 1);
                textField.background = false;
            }
            else
            {
                invalidateProperties();
            };
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
            dispatchEvent(new Event("textChanged"));
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

        public function set styleSheet(_arg_1:StyleSheet):void
        {
            _styleSheet = _arg_1;
            styleSheetChanged = true;
            htmlTextChanged = true;
            invalidateProperties();
        }

        override protected function measure():void
        {
            super.measure();
            measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
            measuredWidth = DEFAULT_MEASURED_WIDTH;
            measuredMinHeight = (measuredHeight = (2 * DEFAULT_MEASURED_MIN_HEIGHT));
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        public function get selectionEndIndex():int
        {
            return ((textField) ? textField.selectionEndIndex : _selectionEndIndex);
        }

        [Bindable("editableChanged")]
        public function get editable():Boolean
        {
            return (_editable);
        }

        override protected function focusInHandler(event:FocusEvent):void
        {
            var message:String;
            if (event.target == this)
            {
                systemManager.stage.focus = TextField(textField);
            };
            var fm:IFocusManager = focusManager;
            if (((editable) && (fm)))
            {
                fm.showFocusIndicator = true;
            };
            if (fm)
            {
                fm.defaultButtonEnabled = false;
            };
            super.focusInHandler(event);
            if (((!(_imeMode == null)) && (_editable)))
            {
                IME.enabled = true;
                prevMode = IME.conversionMode;
                try
                {
                    if (((!(errorCaught)) && (!(IME.conversionMode == IMEConversionMode.UNKNOWN))))
                    {
                        IME.conversionMode = _imeMode;
                    };
                    errorCaught = false;
                }
                catch(e:Error)
                {
                    errorCaught = true;
                    message = resourceManager.getString("controls", "unsupportedMode", [_imeMode]);
                    throw (new Error(message));
                };
            };
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        [Bindable("wordWrapChanged")]
        public function get wordWrap():Boolean
        {
            return (_wordWrap);
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

        [Bindable("htmlTextChanged")]
        [NonCommittingChangeEvent("change")]
        public function get htmlText():String
        {
            return (_htmlText);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            if (_arg_1 == enabled)
            {
                return;
            };
            super.enabled = _arg_1;
            enabledChanged = true;
            if (verticalScrollBar)
            {
                verticalScrollBar.enabled = _arg_1;
            };
            if (horizontalScrollBar)
            {
                horizontalScrollBar.enabled = _arg_1;
            };
            invalidateProperties();
            if (((border) && (border is IInvalidating)))
            {
                IInvalidating(border).invalidateDisplayList();
            };
        }

        private function textField_textFieldStyleChangeHandler(_arg_1:Event):void
        {
            textFieldChanged(true, false);
        }

        public function set restrict(_arg_1:String):void
        {
            if (_arg_1 == _restrict)
            {
                return;
            };
            _restrict = _arg_1;
            restrictChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("restrictChanged"));
        }

        private function textField_nativeDragDropHandler(_arg_1:Event):void
        {
            textField_changeHandler(_arg_1);
        }

        override public function get baselinePosition():Number
        {
            var _local_1:String;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _local_1 = text;
                if (((!(_local_1)) || (_local_1 == "")))
                {
                    _local_1 = " ";
                };
                return (viewMetrics.top + measureText(_local_1).ascent);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return (textField.y + textField.baselinePosition);
        }

        private function textField_changeHandler(_arg_1:Event):void
        {
            textFieldChanged(false, false);
            adjustScrollBars();
            textChanged = false;
            htmlTextChanged = false;
            _arg_1.stopImmediatePropagation();
            dispatchEvent(new Event(Event.CHANGE));
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

        public function set displayAsPassword(_arg_1:Boolean):void
        {
            if (_arg_1 == _displayAsPassword)
            {
                return;
            };
            _displayAsPassword = _arg_1;
            displayAsPasswordChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("displayAsPasswordChanged"));
        }

        override public function get horizontalScrollPolicy():String
        {
            return ((height <= 40) ? ScrollPolicy.OFF : _horizontalScrollPolicy);
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        override public function get maxVerticalScrollPosition():Number
        {
            return ((textField) ? (textField.maxScrollV - 1) : 0);
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

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        override public function set horizontalScrollPosition(_arg_1:Number):void
        {
            super.horizontalScrollPosition = _arg_1;
            _hScrollPosition = _arg_1;
            if (textField)
            {
                textField.scrollH = _arg_1;
                textField.background = false;
            }
            else
            {
                invalidateProperties();
            };
        }

        override public function setFocus():void
        {
            var _local_1:int = verticalScrollPosition;
            allowScrollEvent = false;
            textField.setFocus();
            verticalScrollPosition = _local_1;
            allowScrollEvent = true;
        }

        public function set selectionBeginIndex(_arg_1:int):void
        {
            _selectionBeginIndex = _arg_1;
            selectionChanged = true;
            invalidateProperties();
        }

        [Bindable("restrictChanged")]
        public function get restrict():String
        {
            return (_restrict);
        }

        override protected function scrollHandler(_arg_1:Event):void
        {
            if ((_arg_1 is ScrollEvent))
            {
                if (((!(liveScrolling)) && (ScrollEvent(_arg_1).detail == ScrollEventDetail.THUMB_TRACK)))
                {
                    return;
                };
                super.scrollHandler(_arg_1);
                textField.scrollH = horizontalScrollPosition;
                textField.scrollV = (verticalScrollPosition + 1);
                _vScrollPosition = (textField.scrollV - 1);
                _hScrollPosition = textField.scrollH;
            };
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        mx_internal function removeTextField():void
        {
            if (textField)
            {
                textField.removeEventListener(Event.CHANGE, textField_changeHandler);
                textField.removeEventListener(Event.SCROLL, textField_scrollHandler);
                textField.removeEventListener(IOErrorEvent.IO_ERROR, textField_ioErrorHandler);
                textField.removeEventListener(TextEvent.TEXT_INPUT, textField_textInputHandler);
                textField.removeEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.removeEventListener("textFormatChange", textField_textFormatChangeHandler);
                textField.removeEventListener("textInsert", textField_textModifiedHandler);
                textField.removeEventListener("textReplace", textField_textModifiedHandler);
                textField.removeEventListener("nativeDragDrop", textField_nativeDragDropHandler);
                removeChild(DisplayObject(textField));
                textField = null;
            };
        }

        public function set selectionEndIndex(_arg_1:int):void
        {
            _selectionEndIndex = _arg_1;
            selectionChanged = true;
            invalidateProperties();
        }

        public function get textHeight():Number
        {
            return (_textHeight);
        }

        public function set editable(_arg_1:Boolean):void
        {
            if (_arg_1 == _editable)
            {
                return;
            };
            _editable = _arg_1;
            editableChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("editableChanged"));
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (((hasFontContextChanged()) && (!(textField == null))))
            {
                removeTextField();
                createTextField(-1);
                accessibilityPropertiesChanged = true;
                condenseWhiteChanged = true;
                displayAsPasswordChanged = true;
                editableChanged = true;
                enabledChanged = true;
                maxCharsChanged = true;
                restrictChanged = true;
                selectableChanged = true;
                tabIndexChanged = true;
                wordWrapChanged = true;
                textChanged = true;
                selectionChanged = true;
            };
            if (accessibilityPropertiesChanged)
            {
                textField.accessibilityProperties = _accessibilityProperties;
                accessibilityPropertiesChanged = false;
            };
            if (condenseWhiteChanged)
            {
                textField.condenseWhite = _condenseWhite;
                condenseWhiteChanged = false;
            };
            if (displayAsPasswordChanged)
            {
                textField.displayAsPassword = _displayAsPassword;
                displayAsPasswordChanged = false;
            };
            if (editableChanged)
            {
                textField.type = (((_editable) && (enabled)) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
                editableChanged = false;
            };
            if (enabledChanged)
            {
                textField.enabled = enabled;
                enabledChanged = false;
            };
            if (maxCharsChanged)
            {
                textField.maxChars = _maxChars;
                maxCharsChanged = false;
            };
            if (restrictChanged)
            {
                textField.restrict = _restrict;
                restrictChanged = false;
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
            if (tabIndexChanged)
            {
                textField.tabIndex = _tabIndex;
                tabIndexChanged = false;
            };
            if (wordWrapChanged)
            {
                textField.wordWrap = _wordWrap;
                wordWrapChanged = false;
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
                textFieldChanged(false, true);
                textChanged = false;
                htmlTextChanged = false;
            };
            if (selectionChanged)
            {
                textField.setSelection(_selectionBeginIndex, _selectionEndIndex);
                selectionChanged = false;
            };
            if (!isNaN(_hScrollPosition))
            {
                horizontalScrollPosition = _hScrollPosition;
            };
            if (!isNaN(_vScrollPosition))
            {
                verticalScrollPosition = _vScrollPosition;
            };
        }

        private function get isHTML():Boolean
        {
            return (!(explicitHTMLText == null));
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

        override public function get maxHorizontalScrollPosition():Number
        {
            return ((textField) ? textField.maxScrollH : 0);
        }

        override protected function mouseWheelHandler(_arg_1:MouseEvent):void
        {
            _arg_1.stopPropagation();
        }

        private function textField_scrollHandler(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:ScrollEvent;
            if (((initialized) && (allowScrollEvent)))
            {
                _local_2 = (textField.scrollH - horizontalScrollPosition);
                _local_3 = ((textField.scrollV - 1) - verticalScrollPosition);
                horizontalScrollPosition = textField.scrollH;
                verticalScrollPosition = (textField.scrollV - 1);
                if (_local_2)
                {
                    _local_4 = new ScrollEvent(ScrollEvent.SCROLL, false, false, null, horizontalScrollPosition, ScrollEventDirection.HORIZONTAL, _local_2);
                    dispatchEvent(_local_4);
                };
                if (_local_3)
                {
                    _local_4 = new ScrollEvent(ScrollEvent.SCROLL, false, false, null, verticalScrollPosition, ScrollEventDirection.VERTICAL, _local_3);
                    dispatchEvent(_local_4);
                };
            };
        }

        public function set wordWrap(_arg_1:Boolean):void
        {
            if (_arg_1 == _wordWrap)
            {
                return;
            };
            _wordWrap = _arg_1;
            wordWrapChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            dispatchEvent(new Event("wordWrapChanged"));
        }

        private function textField_textModifiedHandler(_arg_1:Event):void
        {
            textFieldChanged(false, true);
        }

        private function textField_textFormatChangeHandler(_arg_1:Event):void
        {
            textFieldChanged(true, false);
        }

        public function set htmlText(_arg_1:String):void
        {
            textSet = true;
            if (!_arg_1)
            {
                _arg_1 = "";
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
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:EdgeMetrics = viewMetrics;
            _local_3.left = (_local_3.left + getStyle("paddingLeft"));
            _local_3.top = (_local_3.top + getStyle("paddingTop"));
            _local_3.right = (_local_3.right + getStyle("paddingRight"));
            _local_3.bottom = (_local_3.bottom + getStyle("paddingBottom"));
            textField.move(_local_3.left, _local_3.top);
            var _local_4:Number = ((_arg_1 - _local_3.left) - _local_3.right);
            var _local_5:Number = ((_arg_2 - _local_3.top) - _local_3.bottom);
            if ((_local_3.top + _local_3.bottom) > 0)
            {
                _local_5++;
            };
            textField.setActualSize(Math.max(4, _local_4), Math.max(4, _local_5));
            if (!initialized)
            {
                callLater(invalidateDisplayList);
            }
            else
            {
                callLater(adjustScrollBars);
            };
            if (isNaN(_hScrollPosition))
            {
                _hScrollPosition = 0;
            };
            if (isNaN(_vScrollPosition))
            {
                _vScrollPosition = 0;
            };
            var _local_6:Number = Math.min(textField.maxScrollH, _hScrollPosition);
            if (_local_6 != textField.scrollH)
            {
                horizontalScrollPosition = _local_6;
            };
            _local_6 = Math.min((textField.maxScrollV - 1), _vScrollPosition);
            if (_local_6 != (textField.scrollV - 1))
            {
                verticalScrollPosition = _local_6;
            };
        }

        public function getLineMetrics(_arg_1:int):TextLineMetrics
        {
            return ((textField) ? textField.getLineMetrics(_arg_1) : null);
        }

        override public function get verticalScrollPolicy():String
        {
            return ((height <= 40) ? ScrollPolicy.OFF : _verticalScrollPolicy);
        }

        public function get length():int
        {
            return ((text != null) ? text.length : -1);
        }


    }
}//package mx.controls

