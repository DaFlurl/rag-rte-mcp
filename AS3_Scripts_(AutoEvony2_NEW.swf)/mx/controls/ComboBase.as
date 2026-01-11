// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.ComboBase

package mx.controls
{
    import mx.core.UIComponent;
    import mx.core.IIMESupport;
    import mx.managers.IFocusManagerComponent;
    import mx.collections.ICollectionView;
    import mx.core.IFlexDisplayObject;
    import mx.collections.IViewCursor;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import mx.managers.IFocusManager;
    import flash.events.FocusEvent;
    import mx.core.FlexVersion;
    import mx.utils.UIDUtil;
    import mx.styles.ISimpleStyleClient;
    import flash.display.DisplayObject;
    import mx.styles.StyleProxy;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import mx.core.EdgeMetrics;
    import mx.core.UITextField;
    import mx.collections.CursorBookmark;
    import mx.collections.ArrayCollection;
    import mx.collections.IList;
    import mx.collections.ListCollectionView;
    import mx.collections.XMLListCollection;
    import mx.core.IRectangularBorder;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ComboBase extends UIComponent implements IIMESupport, IFocusManagerComponent 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var createAccessibilityImplementation:Function;
        private static var _textInputStyleFilters:Object = {
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
            "leading":"leading",
            "paddingLeft":"paddingLeft",
            "paddingRight":"paddingRight",
            "shadowDirection":"shadowDirection",
            "shadowDistance":"shadowDistance",
            "textDecoration":"textDecoration"
        };

        private var _enabled:Boolean = false;
        mx_internal var useFullDropdownSkin:Boolean = false;
        mx_internal var selectedItemChanged:Boolean = false;
        mx_internal var selectionChanged:Boolean = false;
        mx_internal var downArrowButton:Button;
        private var _restrict:String;
        protected var collection:ICollectionView;
        private var _text:String = "";
        mx_internal var border:IFlexDisplayObject;
        private var _selectedItem:Object;
        mx_internal var editableChanged:Boolean = true;
        private var enabledChanged:Boolean = false;
        private var selectedUID:String;
        mx_internal var selectedIndexChanged:Boolean = false;
        mx_internal var oldBorderStyle:String;
        protected var textInput:TextInput;
        private var _editable:Boolean = false;
        mx_internal var collectionIterator:IViewCursor;
        mx_internal var textChanged:Boolean;
        private var _imeMode:String = null;
        protected var iterator:IViewCursor;
        mx_internal var wrapDownArrowButton:Boolean = true;
        private var _selectedIndex:int = -1;

        public function ComboBase()
        {
            tabEnabled = true;
        }

        protected function collectionChangeHandler(_arg_1:Event):void
        {
            var _local_2:Boolean;
            var _local_3:Number;
            var _local_4:Object;
            var _local_5:CollectionEvent;
            var _local_6:int;
            var _local_7:String;
            if ((_arg_1 is CollectionEvent))
            {
                _local_2 = false;
                _local_5 = CollectionEvent(_arg_1);
                if (_local_5.kind == CollectionEventKind.ADD)
                {
                    if (selectedIndex >= _local_5.location)
                    {
                        _selectedIndex++;
                    };
                };
                if (_local_5.kind == CollectionEventKind.REMOVE)
                {
                    _local_6 = 0;
                    while (_local_6 < _local_5.items.length)
                    {
                        _local_7 = itemToUID(_local_5.items[_local_6]);
                        if (selectedUID == _local_7)
                        {
                            selectionChanged = true;
                        };
                        _local_6++;
                    };
                    if (selectionChanged)
                    {
                        if (_selectedIndex >= collection.length)
                        {
                            _selectedIndex = (collection.length - 1);
                        };
                        selectedIndexChanged = true;
                        _local_2 = true;
                        invalidateDisplayList();
                    }
                    else
                    {
                        if (selectedIndex >= _local_5.location)
                        {
                            _selectedIndex--;
                            selectedIndexChanged = true;
                            _local_2 = true;
                            invalidateDisplayList();
                        };
                    };
                };
                if (_local_5.kind == CollectionEventKind.REFRESH)
                {
                    selectedItemChanged = true;
                    _local_2 = true;
                };
                invalidateDisplayList();
                if (_local_2)
                {
                    dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                };
            };
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            _enabled = _arg_1;
            enabledChanged = true;
            invalidateProperties();
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            super.focusOutHandler(_arg_1);
            var _local_2:IFocusManager = focusManager;
            if (_local_2)
            {
                _local_2.defaultButtonEnabled = true;
            };
            if (_editable)
            {
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            };
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return (textInput.y + textInput.baselinePosition);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return (textInput.y + textInput.baselinePosition);
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
            if (textInput)
            {
                textInput.imeMode = _imeMode;
            };
        }

        protected function itemToUID(_arg_1:Object):String
        {
            if (!_arg_1)
            {
                return ("null");
            };
            return (UIDUtil.getUID(_arg_1));
        }

        protected function downArrowButton_buttonDownHandler(_arg_1:FlexEvent):void
        {
        }

        override protected function createChildren():void
        {
            var _local_1:Class;
            var _local_2:Object;
            super.createChildren();
            if (!border)
            {
                _local_1 = getStyle("borderSkin");
                if (_local_1)
                {
                    border = new (_local_1)();
                    if ((border is IFocusManagerComponent))
                    {
                        IFocusManagerComponent(border).focusEnabled = false;
                    };
                    if ((border is ISimpleStyleClient))
                    {
                        ISimpleStyleClient(border).styleName = this;
                    };
                    addChild(DisplayObject(border));
                };
            };
            if (!downArrowButton)
            {
                downArrowButton = new Button();
                downArrowButton.styleName = new StyleProxy(this, arrowButtonStyleFilters);
                downArrowButton.focusEnabled = false;
                addChild(downArrowButton);
                downArrowButton.addEventListener(FlexEvent.BUTTON_DOWN, downArrowButton_buttonDownHandler);
            };
            if (!textInput)
            {
                _local_2 = getStyle("textInputStyleName");
                if (!_local_2)
                {
                    _local_2 = new StyleProxy(this, textInputStyleFilters);
                };
                textInput = new TextInput();
                textInput.editable = _editable;
                editableChanged = true;
                textInput.restrict = "^\x1B";
                textInput.focusEnabled = false;
                textInput.imeMode = _imeMode;
                textInput.styleName = _local_2;
                textInput.addEventListener(Event.CHANGE, textInput_changeHandler);
                textInput.addEventListener(FlexEvent.ENTER, textInput_enterHandler);
                textInput.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
                textInput.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
                textInput.addEventListener(FlexEvent.VALUE_COMMIT, textInput_valueCommitHandler);
                addChild(textInput);
                textInput.move(0, 0);
                textInput.parentDrawsFocus = true;
            };
        }

        public function set selectedItem(_arg_1:Object):void
        {
            setSelectedItem(_arg_1);
        }

        override protected function initializeAccessibility():void
        {
            if (ComboBase.createAccessibilityImplementation != null)
            {
                ComboBase.createAccessibilityImplementation(this);
            };
        }

        private function textInput_enterHandler(_arg_1:FlexEvent):void
        {
            dispatchEvent(_arg_1);
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        protected function calculatePreferredSizeFromData(_arg_1:int):Object
        {
            return (null);
        }

        override public function setFocus():void
        {
            if (((textInput) && (_editable)))
            {
                textInput.setFocus();
            }
            else
            {
                super.setFocus();
            };
        }

        private function textInput_valueCommitHandler(_arg_1:FlexEvent):void
        {
            _text = textInput.text;
            dispatchEvent(_arg_1);
        }

        [Bindable("collectionChange")]
        [Bindable("valueCommit")]
        [NonCommittingChangeEvent("change")]
        public function get text():String
        {
            return (_text);
        }

        [Bindable("collectionChange")]
        public function get dataProvider():Object
        {
            return (collection);
        }

        protected function get arrowButtonStyleFilters():Object
        {
            return (null);
        }

        public function set editable(_arg_1:Boolean):void
        {
            _editable = _arg_1;
            editableChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("editableChanged"));
        }

        override public function styleChanged(_arg_1:String):void
        {
            if (downArrowButton)
            {
                downArrowButton.styleChanged(_arg_1);
            };
            if (textInput)
            {
                textInput.styleChanged(_arg_1);
            };
            if (((border) && (border is ISimpleStyleClient)))
            {
                ISimpleStyleClient(border).styleChanged(_arg_1);
            };
            super.styleChanged(_arg_1);
        }

        [Bindable("restrictChanged")]
        public function get restrict():String
        {
            return (_restrict);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selectedItem():Object
        {
            return (_selectedItem);
        }

        mx_internal function get ComboDownArrowButton():Button
        {
            return (downArrowButton);
        }

        private function setSelectedItem(_arg_1:Object, _arg_2:Boolean=true):void
        {
            if (((!(collection)) || (collection.length == 0)))
            {
                _selectedItem = _arg_1;
                selectedItemChanged = true;
                invalidateDisplayList();
                return;
            };
            var _local_3:Boolean;
            var _local_4:IViewCursor = collection.createCursor();
            var _local_5:int;
            do 
            {
                if (_arg_1 == _local_4.current)
                {
                    _selectedIndex = _local_5;
                    _selectedItem = _arg_1;
                    selectedUID = itemToUID(_arg_1);
                    selectionChanged = true;
                    _local_3 = true;
                    break;
                };
                _local_5++;
            } while (_local_4.moveNext());
            if (!_local_3)
            {
                selectedIndex = -1;
                _selectedItem = null;
                selectedUID = null;
            };
            invalidateDisplayList();
        }

        override protected function commitProperties():void
        {
            var _local_1:Boolean;
            super.commitProperties();
            textInput.restrict = _restrict;
            if (textChanged)
            {
                textInput.text = _text;
                textChanged = false;
            };
            if (enabledChanged)
            {
                textInput.enabled = _enabled;
                editableChanged = true;
                downArrowButton.enabled = _enabled;
                enabledChanged = false;
            };
            if (editableChanged)
            {
                editableChanged = false;
                _local_1 = _editable;
                if (wrapDownArrowButton == false)
                {
                    if (_local_1)
                    {
                        if (oldBorderStyle)
                        {
                            setStyle("borderStyle", oldBorderStyle);
                        };
                    }
                    else
                    {
                        oldBorderStyle = getStyle("borderStyle");
                        setStyle("borderStyle", "comboNonEdit");
                    };
                };
                if (useFullDropdownSkin)
                {
                    downArrowButton.upSkinName = ((_local_1) ? "editableUpSkin" : "upSkin");
                    downArrowButton.overSkinName = ((_local_1) ? "editableOverSkin" : "overSkin");
                    downArrowButton.downSkinName = ((_local_1) ? "editableDownSkin" : "downSkin");
                    downArrowButton.disabledSkinName = ((_local_1) ? "editableDisabledSkin" : "disabledSkin");
                    downArrowButton.changeSkins();
                    downArrowButton.invalidateDisplayList();
                };
                if (textInput)
                {
                    textInput.editable = _local_1;
                    textInput.selectable = _local_1;
                    if (_local_1)
                    {
                        textInput.removeEventListener(MouseEvent.MOUSE_DOWN, textInput_mouseEventHandler);
                        textInput.removeEventListener(MouseEvent.MOUSE_UP, textInput_mouseEventHandler);
                        textInput.removeEventListener(MouseEvent.ROLL_OVER, textInput_mouseEventHandler);
                        textInput.removeEventListener(MouseEvent.ROLL_OUT, textInput_mouseEventHandler);
                        textInput.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    }
                    else
                    {
                        textInput.addEventListener(MouseEvent.MOUSE_DOWN, textInput_mouseEventHandler);
                        textInput.addEventListener(MouseEvent.MOUSE_UP, textInput_mouseEventHandler);
                        textInput.addEventListener(MouseEvent.ROLL_OVER, textInput_mouseEventHandler);
                        textInput.addEventListener(MouseEvent.ROLL_OUT, textInput_mouseEventHandler);
                        textInput.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    };
                };
            };
        }

        protected function get textInputStyleFilters():Object
        {
            return (_textInputStyleFilters);
        }

        public function set text(_arg_1:String):void
        {
            _text = _arg_1;
            textChanged = true;
            invalidateProperties();
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        override protected function isOurFocus(_arg_1:DisplayObject):Boolean
        {
            return ((_arg_1 == textInput) || (super.isOurFocus(_arg_1)));
        }

        [Bindable("editableChanged")]
        public function get editable():Boolean
        {
            return (_editable);
        }

        override protected function measure():void
        {
            var _local_2:Number;
            var _local_3:Object;
            var _local_4:EdgeMetrics;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            super.measure();
            var _local_1:Number = getStyle("arrowButtonWidth");
            _local_2 = downArrowButton.getExplicitOrMeasuredHeight();
            if (((collection) && (collection.length > 0)))
            {
                _local_3 = calculatePreferredSizeFromData(collection.length);
                _local_4 = borderMetrics;
                _local_5 = (((_local_3.width + _local_4.left) + _local_4.right) + 8);
                _local_6 = (((_local_3.height + _local_4.top) + _local_4.bottom) + UITextField.TEXT_HEIGHT_PADDING);
                measuredMinWidth = (measuredWidth = (_local_5 + _local_1));
                measuredMinHeight = (measuredHeight = Math.max(_local_6, _local_2));
            }
            else
            {
                measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
                measuredWidth = DEFAULT_MEASURED_WIDTH;
                measuredMinHeight = DEFAULT_MEASURED_MIN_HEIGHT;
                measuredHeight = DEFAULT_MEASURED_HEIGHT;
            };
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                _local_7 = (getStyle("paddingTop") + getStyle("paddingBottom"));
                measuredMinHeight = (measuredMinHeight + _local_7);
                measuredHeight = (measuredHeight + _local_7);
            };
        }

        protected function textInput_changeHandler(_arg_1:Event):void
        {
            _text = textInput.text;
            if (_selectedIndex != -1)
            {
                _selectedIndex = -1;
                _selectedItem = null;
                selectedUID = null;
            };
        }

        mx_internal function getTextInput():TextInput
        {
            return (textInput);
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            super.focusInHandler(_arg_1);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get value():Object
        {
            if (_editable)
            {
                return (text);
            };
            var _local_1:Object = selectedItem;
            if (((_local_1 == null) || (!(typeof(_local_1) == "object"))))
            {
                return (_local_1);
            };
            return ((_local_1.data != null) ? _local_1.data : _local_1.label);
        }

        private function textInput_mouseEventHandler(_arg_1:Event):void
        {
            downArrowButton.dispatchEvent(_arg_1);
        }

        public function set selectedIndex(_arg_1:int):void
        {
            var _local_2:CursorBookmark;
            var _local_3:int;
            var _local_4:Object;
            var _local_5:String;
            _selectedIndex = _arg_1;
            if (_arg_1 == -1)
            {
                _selectedItem = null;
                selectedUID = null;
            };
            if (((!(collection)) || (collection.length == 0)))
            {
                selectedIndexChanged = true;
            }
            else
            {
                if (_arg_1 != -1)
                {
                    _arg_1 = Math.min(_arg_1, (collection.length - 1));
                    _local_2 = iterator.bookmark;
                    _local_3 = _arg_1;
                    iterator.seek(CursorBookmark.FIRST, _local_3);
                    _local_4 = iterator.current;
                    _local_5 = itemToUID(_local_4);
                    iterator.seek(_local_2, 0);
                    _selectedIndex = _arg_1;
                    _selectedItem = _local_4;
                    selectedUID = _local_5;
                };
            };
            selectionChanged = true;
            invalidateDisplayList();
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        public function set dataProvider(_arg_1:Object):void
        {
            var _local_3:Array;
            if ((_arg_1 is Array))
            {
                collection = new ArrayCollection((_arg_1 as Array));
            }
            else
            {
                if ((_arg_1 is ICollectionView))
                {
                    collection = ICollectionView(_arg_1);
                }
                else
                {
                    if ((_arg_1 is IList))
                    {
                        collection = new ListCollectionView(IList(_arg_1));
                    }
                    else
                    {
                        if ((_arg_1 is XMLList))
                        {
                            collection = new XMLListCollection((_arg_1 as XMLList));
                        }
                        else
                        {
                            _local_3 = [_arg_1];
                            collection = new ArrayCollection(_local_3);
                        };
                    };
                };
            };
            iterator = collection.createCursor();
            collectionIterator = collection.createCursor();
            collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);
            var _local_2:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _local_2.kind = CollectionEventKind.RESET;
            collectionChangeHandler(_local_2);
            dispatchEvent(_local_2);
            invalidateSize();
            invalidateDisplayList();
        }

        protected function get borderMetrics():EdgeMetrics
        {
            if (((border) && (border is IRectangularBorder)))
            {
                return (IRectangularBorder(border).borderMetrics);
            };
            return (EdgeMetrics.EMPTY);
        }

        public function set restrict(_arg_1:String):void
        {
            _restrict = _arg_1;
            invalidateProperties();
            dispatchEvent(new Event("restrictChanged"));
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_7:EdgeMetrics;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = _arg_1;
            var _local_4:Number = _arg_2;
            var _local_5:Number = getStyle("arrowButtonWidth");
            var _local_6:Number = textInput.getExplicitOrMeasuredHeight();
            if (isNaN(_local_5))
            {
                _local_5 = 0;
            };
            if (wrapDownArrowButton)
            {
                _local_7 = borderMetrics;
                _local_8 = ((_local_4 - _local_7.top) - _local_7.bottom);
                downArrowButton.setActualSize(_local_8, _local_8);
                downArrowButton.move(((_local_3 - _local_5) - _local_7.right), _local_7.top);
                border.setActualSize(_local_3, _local_4);
                textInput.setActualSize((_local_3 - _local_5), _local_6);
            }
            else
            {
                if (((!(_editable)) && (useFullDropdownSkin)))
                {
                    _local_9 = getStyle("paddingTop");
                    _local_10 = getStyle("paddingBottom");
                    downArrowButton.move(0, 0);
                    border.setActualSize(_local_3, _local_4);
                    textInput.setActualSize((_local_3 - _local_5), _local_6);
                    textInput.border.visible = false;
                    if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                    {
                        textInput.move(textInput.x, (((((_local_4 - _local_6) - _local_9) - _local_10) / 2) + _local_9));
                    };
                    downArrowButton.setActualSize(_arg_1, _arg_2);
                }
                else
                {
                    downArrowButton.move((_local_3 - _local_5), 0);
                    border.setActualSize((_local_3 - _local_5), _local_4);
                    textInput.setActualSize((_local_3 - _local_5), _local_4);
                    downArrowButton.setActualSize(_local_5, _arg_2);
                    textInput.border.visible = true;
                };
            };
            if (selectedItemChanged)
            {
                selectedItem = selectedItem;
                selectedItemChanged = false;
                selectedIndexChanged = false;
            };
            if (selectedIndexChanged)
            {
                selectedIndex = selectedIndex;
                selectedIndexChanged = false;
            };
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selectedIndex():int
        {
            return (_selectedIndex);
        }


    }
}//package mx.controls

