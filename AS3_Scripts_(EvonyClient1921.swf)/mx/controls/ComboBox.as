// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.ComboBox

package mx.controls
{
    import mx.core.IDataRenderer;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.effects.Tween;
    import mx.controls.listClasses.ListBase;
    import mx.core.IFactory;
    import mx.core.ClassFactory;
    import flash.events.Event;
    import mx.controls.listClasses.BaseListData;
    import mx.collections.ArrayCollection;
    import flash.text.TextLineMetrics;
    import mx.collections.CursorBookmark;
    import mx.events.ScrollEvent;
    import mx.events.ScrollEventDetail;
    import flash.events.FocusEvent;
    import mx.core.UIComponent;
    import mx.controls.dataGridClasses.DataGridListData;
    import mx.controls.listClasses.ListData;
    import mx.events.FlexEvent;
    import mx.core.EdgeMetrics;
    import mx.core.FlexVersion;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.events.FlexMouseEvent;
    import mx.events.SandboxMouseEvent;
    import mx.managers.PopUpManager;
    import mx.events.DropdownEvent;
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.ScrollPolicy;
    import mx.events.ListEvent;
    import mx.core.UIComponentGlobals;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.events.MouseEvent;
    import mx.events.InterManagerRequest;
    import flash.geom.Point;
    import mx.managers.ISystemManager;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ComboBox extends ComboBase implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static var createAccessibilityImplementation:Function;

        private var _labelField:String = "label";
        private var dropdownBorderStyle:String = "solid";
        private var implicitSelectedIndex:Boolean = false;
        private var _selectedIndexOnDropdown:int = -1;
        private var preferredDropdownWidth:Number;
        private var collectionChanged:Boolean = false;
        private var labelFunctionChanged:Boolean;
        private var selectedItemSet:Boolean;
        private var _dropdownWidth:Number = 100;
        private var inTween:Boolean = false;
        private var _oldIndex:int;
        private var tweenUp:Boolean = false;
        private var tween:Tween = null;
        private var labelFieldChanged:Boolean;
        private var _dropdown:ListBase;
        private var _dropdownFactory:IFactory = new ClassFactory(List);
        private var explicitText:Boolean;
        private var _prompt:String;
        private var _data:Object;
        private var bInKeyDown:Boolean = false;
        private var promptChanged:Boolean = false;
        private var _rowCount:int = 5;
        private var bRemoveDropdown:Boolean = false;
        private var _showingDropdown:Boolean = false;
        private var triggerEvent:Event;
        private var _listData:BaseListData;
        private var _itemRenderer:IFactory;
        private var _labelFunction:Function;

        public function ComboBox()
        {
            dataProvider = new ArrayCollection();
            useFullDropdownSkin = true;
            wrapDownArrowButton = false;
            addEventListener("unload", unloadHandler);
            addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
        }

        override protected function calculatePreferredSizeFromData(_arg_1:int):Object
        {
            var _local_6:TextLineMetrics;
            var _local_8:Object;
            var _local_9:String;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:CursorBookmark = ((iterator) ? iterator.bookmark : null);
            iterator.seek(CursorBookmark.FIRST, 0);
            var _local_5:* = (!(iterator == null));
            var _local_7:int;
            while (_local_7 < _arg_1)
            {
                if (_local_5)
                {
                    _local_8 = ((iterator) ? iterator.current : null);
                }
                else
                {
                    _local_8 = null;
                };
                _local_9 = itemToLabel(_local_8);
                _local_6 = measureText(_local_9);
                _local_2 = Math.max(_local_2, _local_6.width);
                _local_3 = Math.max(_local_3, _local_6.height);
                if (iterator)
                {
                    iterator.moveNext();
                };
                _local_7++;
            };
            if (prompt)
            {
                _local_6 = measureText(prompt);
                _local_2 = Math.max(_local_2, _local_6.width);
                _local_3 = Math.max(_local_3, _local_6.height);
            };
            _local_2 = (_local_2 + (getStyle("paddingLeft") + getStyle("paddingRight")));
            if (iterator)
            {
                iterator.seek(_local_4, 0);
            };
            return ({
                "width":_local_2,
                "height":_local_3
            });
        }

        private function dropdown_scrollHandler(_arg_1:Event):void
        {
            var _local_2:ScrollEvent;
            if ((_arg_1 is ScrollEvent))
            {
                _local_2 = ScrollEvent(_arg_1);
                if (((((_local_2.detail == ScrollEventDetail.THUMB_TRACK) || (_local_2.detail == ScrollEventDetail.THUMB_POSITION)) || (_local_2.detail == ScrollEventDetail.LINE_UP)) || (_local_2.detail == ScrollEventDetail.LINE_DOWN)))
                {
                    dispatchEvent(_local_2);
                };
            };
        }

        public function get dropdown():ListBase
        {
            return (getDropdown());
        }

        public function get selectedLabel():String
        {
            var _local_1:Object = selectedItem;
            return (itemToLabel(_local_1));
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            if (((_showingDropdown) && (_dropdown)))
            {
                if (((!(_arg_1.relatedObject)) || (!(_dropdown.contains(_arg_1.relatedObject)))))
                {
                    close();
                };
            };
            super.focusOutHandler(_arg_1);
        }

        private function destroyDropdown():void
        {
            if (inTween)
            {
                tween.endTween();
            };
            displayDropdown(false, null, false);
        }

        [Bindable("dropdownWidthChanged")]
        public function get dropdownWidth():Number
        {
            return (_dropdownWidth);
        }

        private function unloadHandler(_arg_1:Event):void
        {
            if (inTween)
            {
                UIComponent.resumeBackgroundProcessing();
                inTween = false;
            };
            if (_dropdown)
            {
                _dropdown.parent.removeChild(_dropdown);
            };
        }

        public function open():void
        {
            displayDropdown(true);
        }

        public function set data(_arg_1:Object):void
        {
            var _local_2:*;
            _data = _arg_1;
            if (((_listData) && (_listData is DataGridListData)))
            {
                _local_2 = _data[DataGridListData(_listData).dataField];
            }
            else
            {
                if (((_listData is ListData) && (ListData(_listData).labelField in _data)))
                {
                    _local_2 = _data[ListData(_listData).labelField];
                }
                else
                {
                    _local_2 = _data;
                };
            };
            if (((!(_local_2 === undefined)) && (!(selectedItemSet))))
            {
                selectedItem = _local_2;
                selectedItemSet = false;
            };
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        [Bindable("resize")]
        public function get rowCount():int
        {
            return (Math.max(1, Math.min(collection.length, _rowCount)));
        }

        override protected function textInput_changeHandler(_arg_1:Event):void
        {
            super.textInput_changeHandler(_arg_1);
            dispatchChangeEvent(_arg_1, -1, -2);
        }

        private function dropdown_itemRollOutHandler(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
        }

        override protected function measure():void
        {
            super.measure();
            measuredMinWidth = Math.max(measuredWidth, DEFAULT_MEASURED_MIN_WIDTH);
            var _local_1:Number = (measureText("M").height + 6);
            var _local_2:EdgeMetrics = borderMetrics;
            measuredMinHeight = (measuredHeight = Math.max(((_local_1 + _local_2.top) + _local_2.bottom), DEFAULT_MEASURED_MIN_HEIGHT));
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                measuredMinHeight = (measuredHeight = (measuredHeight + (getStyle("paddingTop") + getStyle("paddingBottom"))));
            };
        }

        private function dropdown_itemRollOverHandler(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
        }

        public function get prompt():String
        {
            return (_prompt);
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:int;
            if (!enabled)
            {
                return;
            };
            if (_arg_1.target == textInput)
            {
                return;
            };
            if (((_arg_1.ctrlKey) && (_arg_1.keyCode == Keyboard.DOWN)))
            {
                displayDropdown(true, _arg_1);
                _arg_1.stopPropagation();
            }
            else
            {
                if (((_arg_1.ctrlKey) && (_arg_1.keyCode == Keyboard.UP)))
                {
                    close(_arg_1);
                    _arg_1.stopPropagation();
                }
                else
                {
                    if (_arg_1.keyCode == Keyboard.ESCAPE)
                    {
                        if (_showingDropdown)
                        {
                            if (_oldIndex != _dropdown.selectedIndex)
                            {
                                selectedIndex = _oldIndex;
                            };
                            displayDropdown(false);
                            _arg_1.stopPropagation();
                        };
                    }
                    else
                    {
                        if (_arg_1.keyCode == Keyboard.ENTER)
                        {
                            if (_showingDropdown)
                            {
                                close();
                                _arg_1.stopPropagation();
                            };
                        }
                        else
                        {
                            if ((((((!(editable)) || (_arg_1.keyCode == Keyboard.UP)) || (_arg_1.keyCode == Keyboard.DOWN)) || (_arg_1.keyCode == Keyboard.PAGE_UP)) || (_arg_1.keyCode == Keyboard.PAGE_DOWN)))
                            {
                                _local_2 = selectedIndex;
                                bInKeyDown = _showingDropdown;
                                dropdown.dispatchEvent(_arg_1.clone());
                                _arg_1.stopPropagation();
                                bInKeyDown = false;
                            };
                        };
                    };
                };
            };
        }

        public function set dropdownWidth(_arg_1:Number):void
        {
            _dropdownWidth = _arg_1;
            preferredDropdownWidth = _arg_1;
            if (_dropdown)
            {
                _dropdown.setActualSize(_arg_1, _dropdown.height);
            };
            dispatchEvent(new Event("dropdownWidthChanged"));
        }

        [Bindable("labelFieldChanged")]
        public function get labelField():String
        {
            return (_labelField);
        }

        public function set dropdownFactory(_arg_1:IFactory):void
        {
            _dropdownFactory = _arg_1;
            dispatchEvent(new Event("dropdownFactoryChanged"));
        }

        [Bindable("collectionChange")]
        override public function set dataProvider(_arg_1:Object):void
        {
            selectionChanged = true;
            super.dataProvider = _arg_1;
            destroyDropdown();
            invalidateProperties();
            invalidateSize();
        }

        mx_internal function get isShowingDropdown():Boolean
        {
            return (_showingDropdown);
        }

        override protected function collectionChangeHandler(_arg_1:Event):void
        {
            var _local_3:CollectionEvent;
            var _local_2:int = selectedIndex;
            super.collectionChangeHandler(_arg_1);
            if ((_arg_1 is CollectionEvent))
            {
                _local_3 = CollectionEvent(_arg_1);
                if (collection.length == 0)
                {
                    if (((!(selectedIndexChanged)) && (!(selectedItemChanged))))
                    {
                        if (super.selectedIndex != -1)
                        {
                            super.selectedIndex = -1;
                        };
                        implicitSelectedIndex = true;
                        invalidateDisplayList();
                    };
                    if (((textInput) && (!(editable))))
                    {
                        textInput.text = "";
                    };
                }
                else
                {
                    if (_local_3.kind == CollectionEventKind.ADD)
                    {
                        if (collection.length == _local_3.items.length)
                        {
                            if (((selectedIndex == -1) && (_prompt == null)))
                            {
                                selectedIndex = 0;
                            };
                        }
                        else
                        {
                            return;
                        };
                    }
                    else
                    {
                        if (_local_3.kind == CollectionEventKind.UPDATE)
                        {
                            if (((_local_3.location == selectedIndex) || (_local_3.items[0].source == selectedItem)))
                            {
                                selectionChanged = true;
                            };
                        }
                        else
                        {
                            if (_local_3.kind == CollectionEventKind.REPLACE)
                            {
                                return;
                            };
                            if (_local_3.kind == CollectionEventKind.RESET)
                            {
                                collectionChanged = true;
                                if (((!(selectedIndexChanged)) && (!(selectedItemChanged))))
                                {
                                    selectedIndex = ((prompt) ? -1 : 0);
                                };
                                invalidateProperties();
                            };
                        };
                    };
                };
                invalidateDisplayList();
                destroyDropdown();
            };
        }

        mx_internal function onTweenEnd(_arg_1:Number):void
        {
            if (_dropdown)
            {
                _dropdown.scrollRect = null;
                inTween = false;
                _dropdown.enabled = true;
                _dropdown.visible = _showingDropdown;
            };
            if (bRemoveDropdown)
            {
                _dropdown.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, dropdown_mouseOutsideHandler);
                _dropdown.removeEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE, dropdown_mouseOutsideHandler);
                _dropdown.removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, dropdown_mouseOutsideHandler);
                _dropdown.removeEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, dropdown_mouseOutsideHandler);
                PopUpManager.removePopUp(_dropdown);
                _dropdown = null;
                bRemoveDropdown = false;
            };
            UIComponent.resumeBackgroundProcessing();
            var _local_2:DropdownEvent = new DropdownEvent(((_showingDropdown) ? DropdownEvent.OPEN : DropdownEvent.CLOSE));
            _local_2.triggerEvent = triggerEvent;
            dispatchEvent(_local_2);
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        private function getDropdown():ListBase
        {
            var _local_2:String;
            var _local_3:CSSStyleDeclaration;
            if (!initialized)
            {
                return (null);
            };
            if (!hasDropdown())
            {
                _local_2 = getStyle("dropDownStyleName");
                if (_local_2 == null)
                {
                    _local_2 = getStyle("dropdownStyleName");
                };
                _dropdown = dropdownFactory.newInstance();
                _dropdown.visible = false;
                _dropdown.focusEnabled = false;
                _dropdown.owner = this;
                if (itemRenderer)
                {
                    _dropdown.itemRenderer = itemRenderer;
                };
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _dropdown.styleName = this;
                };
                if (_local_2)
                {
                    if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                    {
                        _local_3 = StyleManager.getStyleDeclaration(("." + _local_2));
                        if (_local_3)
                        {
                            _dropdown.styleDeclaration = _local_3;
                        };
                    }
                    else
                    {
                        _dropdown.styleName = _local_2;
                    };
                }
                else
                {
                    if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                    {
                        _dropdown.setStyle("cornerRadius", 0);
                    };
                };
                PopUpManager.addPopUp(_dropdown, this);
                _dropdown.setStyle("selectionDuration", 0);
                if ((((FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0) && (dropdownBorderStyle)) && (!(dropdownBorderStyle == ""))))
                {
                    _dropdown.setStyle("borderStyle", dropdownBorderStyle);
                };
                if (!dataProvider)
                {
                    dataProvider = new ArrayCollection();
                };
                _dropdown.dataProvider = dataProvider;
                _dropdown.rowCount = rowCount;
                _dropdown.width = _dropdownWidth;
                _dropdown.selectedIndex = selectedIndex;
                _oldIndex = selectedIndex;
                _dropdown.verticalScrollPolicy = ScrollPolicy.AUTO;
                _dropdown.labelField = _labelField;
                _dropdown.labelFunction = itemToLabel;
                _dropdown.allowDragSelection = true;
                _dropdown.addEventListener("change", dropdown_changeHandler);
                _dropdown.addEventListener(ScrollEvent.SCROLL, dropdown_scrollHandler);
                _dropdown.addEventListener(ListEvent.ITEM_ROLL_OVER, dropdown_itemRollOverHandler);
                _dropdown.addEventListener(ListEvent.ITEM_ROLL_OUT, dropdown_itemRollOutHandler);
                _dropdown.addEventListener(ListEvent.ITEM_CLICK, dropdown_itemClickHandler);
                UIComponentGlobals.layoutManager.validateClient(_dropdown, true);
                _dropdown.setActualSize(_dropdownWidth, _dropdown.getExplicitOrMeasuredHeight());
                _dropdown.validateDisplayList();
                _dropdown.cacheAsBitmap = true;
                systemManager.addEventListener(Event.RESIZE, stage_resizeHandler, false, 0, true);
            };
            var _local_1:Matrix = transform.concatenatedMatrix;
            _dropdown.scaleX = _local_1.a;
            _dropdown.scaleY = _local_1.d;
            return (_dropdown);
        }

        private function stage_resizeHandler(_arg_1:Event):void
        {
            destroyDropdown();
        }

        override protected function downArrowButton_buttonDownHandler(_arg_1:FlexEvent):void
        {
            if (_showingDropdown)
            {
                close(_arg_1);
            }
            else
            {
                displayDropdown(true, _arg_1);
            };
        }

        [Bindable("change")]
        [Bindable("collectionChange")]
        [Bindable("valueCommit")]
        override public function set selectedItem(_arg_1:Object):void
        {
            selectedItemSet = true;
            implicitSelectedIndex = false;
            super.selectedItem = _arg_1;
        }

        override protected function initializeAccessibility():void
        {
            if (ComboBox.createAccessibilityImplementation != null)
            {
                ComboBox.createAccessibilityImplementation(this);
            };
        }

        public function itemToLabel(item:Object, ... rest):String
        {
            if (item == null)
            {
                return ("");
            };
            if (labelFunction != null)
            {
                return (labelFunction(item));
            };
            if (typeof(item) == "object")
            {
                try
                {
                    if (item[labelField] != null)
                    {
                        item = item[labelField];
                    };
                }
                catch(e:Error)
                {
                };
            }
            else
            {
                if (typeof(item) == "xml")
                {
                    try
                    {
                        if (item[labelField].length() != 0)
                        {
                            item = item[labelField];
                        };
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            if (typeof(item) == "string")
            {
                return (String(item));
            };
            try
            {
                return (item.toString());
            }
            catch(e:Error)
            {
            };
            return (" ");
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        mx_internal function onTweenUpdate(_arg_1:Number):void
        {
            if (_dropdown)
            {
                _dropdown.scrollRect = new Rectangle(0, _arg_1, _dropdown.width, _dropdown.height);
            };
        }

        private function removedFromStageHandler(_arg_1:Event):void
        {
            destroyDropdown();
        }

        private function dropdown_mouseOutsideHandler(_arg_1:Event):void
        {
            var _local_2:MouseEvent;
            if ((_arg_1 is MouseEvent))
            {
                _local_2 = MouseEvent(_arg_1);
                if (_local_2.target != _dropdown)
                {
                    return;
                };
                if (!hitTestPoint(_local_2.stageX, _local_2.stageY, true))
                {
                    close(_arg_1);
                };
            }
            else
            {
                if ((_arg_1 is SandboxMouseEvent))
                {
                    close(_arg_1);
                };
            };
        }

        [Bindable("dropdownFactoryChanged")]
        public function get dropdownFactory():IFactory
        {
            return (_dropdownFactory);
        }

        override public function styleChanged(_arg_1:String):void
        {
            destroyDropdown();
            super.styleChanged(_arg_1);
        }

        public function set prompt(_arg_1:String):void
        {
            _prompt = _arg_1;
            promptChanged = true;
            invalidateProperties();
        }

        override protected function commitProperties():void
        {
            explicitText = textChanged;
            super.commitProperties();
            if (collectionChanged)
            {
                if ((((selectedIndex == -1) && (implicitSelectedIndex)) && (_prompt == null)))
                {
                    selectedIndex = 0;
                };
                selectedIndexChanged = true;
                collectionChanged = false;
            };
            if ((((promptChanged) && (!(prompt == null))) && (selectedIndex == -1)))
            {
                promptChanged = false;
                textInput.text = prompt;
            };
        }

        mx_internal function hasDropdown():Boolean
        {
            return (!(_dropdown == null));
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = _arg_1;
        }

        public function set labelField(_arg_1:String):void
        {
            _labelField = _arg_1;
            labelFieldChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("labelFieldChanged"));
        }

        public function set labelFunction(_arg_1:Function):void
        {
            _labelFunction = _arg_1;
            labelFunctionChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("labelFunctionChanged"));
        }

        protected function get dropDownStyleFilters():Object
        {
            return (null);
        }

        public function set rowCount(_arg_1:int):void
        {
            _rowCount = _arg_1;
            if (_dropdown)
            {
                _dropdown.rowCount = _arg_1;
            };
        }

        private function dropdown_changeHandler(_arg_1:Event):void
        {
            var _local_2:int = selectedIndex;
            if (_dropdown)
            {
                selectedIndex = _dropdown.selectedIndex;
            };
            if (!_showingDropdown)
            {
                dispatchChangeEvent(_arg_1, _local_2, selectedIndex);
            }
            else
            {
                if (!bInKeyDown)
                {
                    close();
                };
            };
        }

        private function dropdown_itemClickHandler(_arg_1:ListEvent):void
        {
            if (_showingDropdown)
            {
                close();
            };
        }

        [Bindable("labelFunctionChanged")]
        public function get labelFunction():Function
        {
            return (_labelFunction);
        }

        [Bindable("change")]
        [Bindable("collectionChange")]
        [Bindable("valueCommit")]
        override public function set selectedIndex(_arg_1:int):void
        {
            super.selectedIndex = _arg_1;
            if (_arg_1 >= 0)
            {
                selectionChanged = true;
            };
            implicitSelectedIndex = false;
            invalidateDisplayList();
            if ((((textInput) && (!(textChanged))) && (_arg_1 >= 0)))
            {
                textInput.text = selectedLabel;
            }
            else
            {
                if (((textInput) && (prompt)))
                {
                    textInput.text = prompt;
                };
            };
        }

        private function dispatchChangeEvent(_arg_1:Event, _arg_2:int, _arg_3:int):void
        {
            var _local_4:Event;
            if (_arg_2 != _arg_3)
            {
                _local_4 = ((_arg_1 is ListEvent) ? _arg_1 : new ListEvent("change"));
                dispatchEvent(_local_4);
            };
        }

        private function displayDropdown(_arg_1:Boolean, _arg_2:Event=null, _arg_3:Boolean=true):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Function;
            var _local_11:Rectangle;
            var _local_12:InterManagerRequest;
            var _local_13:int;
            var _local_14:Number;
            if (((!(initialized)) || (_arg_1 == _showingDropdown)))
            {
                return;
            };
            var _local_8:Point = new Point(0, unscaledHeight);
            _local_8 = localToGlobal(_local_8);
            var _local_9:ISystemManager = systemManager.topLevelSystemManager;
            var _local_10:DisplayObject = _local_9.getSandboxRoot();
            if (_local_9 != _local_10)
            {
                _local_12 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "getVisibleApplicationRect");
                _local_10.dispatchEvent(_local_12);
                _local_11 = Rectangle(_local_12.value);
            }
            else
            {
                _local_11 = _local_9.getVisibleApplicationRect();
            };
            if (_arg_1)
            {
                _selectedIndexOnDropdown = selectedIndex;
                getDropdown();
                _dropdown.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, dropdown_mouseOutsideHandler);
                _dropdown.addEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE, dropdown_mouseOutsideHandler);
                _dropdown.addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, dropdown_mouseOutsideHandler);
                _dropdown.addEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, dropdown_mouseOutsideHandler);
                if (_dropdown.parent == null)
                {
                    PopUpManager.addPopUp(_dropdown, this);
                }
                else
                {
                    PopUpManager.bringToFront(_dropdown);
                };
                if ((((_local_8.y + _dropdown.height) > _local_11.bottom) && (_local_8.y > (_local_11.top + _dropdown.height))))
                {
                    _local_8.y = (_local_8.y - (unscaledHeight + _dropdown.height));
                    _local_4 = -(_dropdown.height);
                    tweenUp = true;
                }
                else
                {
                    _local_4 = _dropdown.height;
                    tweenUp = false;
                };
                _local_8 = _dropdown.parent.globalToLocal(_local_8);
                _local_13 = _dropdown.selectedIndex;
                if (_local_13 == -1)
                {
                    _local_13 = 0;
                };
                _local_14 = _dropdown.verticalScrollPosition;
                _local_14 = (_local_13 - 1);
                _local_14 = Math.min(Math.max(_local_14, 0), _dropdown.maxVerticalScrollPosition);
                _dropdown.verticalScrollPosition = _local_14;
                if (((!(_dropdown.x == _local_8.x)) || (!(_dropdown.y == _local_8.y))))
                {
                    _dropdown.move(_local_8.x, _local_8.y);
                };
                _dropdown.scrollRect = new Rectangle(0, _local_4, _dropdown.width, _dropdown.height);
                if (!_dropdown.visible)
                {
                    _dropdown.visible = true;
                };
                bRemoveDropdown = false;
                _showingDropdown = _arg_1;
                _local_6 = getStyle("openDuration");
                _local_5 = 0;
                _local_7 = (getStyle("openEasingFunction") as Function);
            }
            else
            {
                if (_dropdown)
                {
                    _local_5 = ((((_local_8.y + _dropdown.height) > _local_11.bottom) || (tweenUp)) ? -(_dropdown.height) : _dropdown.height);
                    _showingDropdown = _arg_1;
                    _local_4 = 0;
                    _local_6 = getStyle("closeDuration");
                    _local_7 = (getStyle("closeEasingFunction") as Function);
                    _dropdown.resetDragScrolling();
                };
            };
            inTween = true;
            UIComponentGlobals.layoutManager.validateNow();
            UIComponent.suspendBackgroundProcessing();
            if (_dropdown)
            {
                _dropdown.enabled = false;
            };
            _local_6 = Math.max(1, _local_6);
            if (!_arg_3)
            {
                _local_6 = 1;
            };
            tween = new Tween(this, _local_4, _local_5, _local_6);
            if (((!(_local_7 == null)) && (tween)))
            {
                tween.easingFunction = _local_7;
            };
            triggerEvent = _arg_2;
        }

        public function get itemRenderer():IFactory
        {
            return (_itemRenderer);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            if (((_dropdown) && (!(inTween))))
            {
                if (!_showingDropdown)
                {
                    destroyDropdown();
                };
            }
            else
            {
                if (((!(_showingDropdown)) && (inTween)))
                {
                    bRemoveDropdown = true;
                };
            };
            var _local_3:Number = preferredDropdownWidth;
            if (isNaN(_local_3))
            {
                _local_3 = (_dropdownWidth = _arg_1);
            };
            if (labelFieldChanged)
            {
                if (_dropdown)
                {
                    _dropdown.labelField = _labelField;
                };
                selectionChanged = true;
                if (!explicitText)
                {
                    textInput.text = selectedLabel;
                };
                labelFieldChanged = false;
            };
            if (labelFunctionChanged)
            {
                selectionChanged = true;
                if (!explicitText)
                {
                    textInput.text = selectedLabel;
                };
                labelFunctionChanged = false;
            };
            if (selectionChanged)
            {
                if (!textChanged)
                {
                    if (((selectedIndex == -1) && (prompt)))
                    {
                        textInput.text = prompt;
                    }
                    else
                    {
                        if (!explicitText)
                        {
                            textInput.text = selectedLabel;
                        };
                    };
                };
                textInput.invalidateDisplayList();
                textInput.validateNow();
                if (editable)
                {
                    textInput.getTextField().setSelection(0, textInput.text.length);
                    textInput.getTextField().scrollH = 0;
                };
                if (_dropdown)
                {
                    _dropdown.selectedIndex = selectedIndex;
                };
                selectionChanged = false;
            };
            if (((_dropdown) && (!(_dropdown.rowCount == rowCount))))
            {
                _dropdown.rowCount = rowCount;
            };
        }

        public function close(_arg_1:Event=null):void
        {
            if (_showingDropdown)
            {
                if (((_dropdown) && (!(selectedIndex == _dropdown.selectedIndex))))
                {
                    selectedIndex = _dropdown.selectedIndex;
                };
                displayDropdown(false, _arg_1);
                dispatchChangeEvent(new Event("dummy"), _selectedIndexOnDropdown, selectedIndex);
            };
        }

        public function set itemRenderer(_arg_1:IFactory):void
        {
            _itemRenderer = _arg_1;
            if (_dropdown)
            {
                _dropdown.itemRenderer = _arg_1;
            };
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("itemRendererChanged"));
        }

        override public function set showInAutomationHierarchy(_arg_1:Boolean):void
        {
        }


    }
}//package mx.controls

