// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.List

package mx.controls
{
    import mx.controls.listClasses.ListBase;
    import mx.core.IIMESupport;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.IFactory;
    import mx.core.ClassFactory;
    import flash.utils.Dictionary;
    import mx.controls.listClasses.ListItemRenderer;
    import mx.core.ScrollPolicy;
    import mx.events.ListEvent;
    import mx.core.EventPriority;
    import mx.collections.CursorBookmark;
    import mx.collections.errors.ItemPendingError;
    import flash.events.KeyboardEvent;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.display.Sprite;
    import flash.geom.Point;
    import mx.collections.IList;
    import mx.controls.listClasses.BaseListData;
    import mx.managers.IFocusManager;
    import mx.core.IPropertyChangeNotifier;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.events.ListEventReason;
    import mx.managers.IFocusManagerComponent;
    import flash.events.FocusEvent;
    import mx.core.FlexSprite;
    import mx.styles.StyleManager;
    import flash.events.Event;
    import flash.ui.Keyboard;
    import mx.core.IInvalidating;
    import mx.controls.listClasses.ListRowInfo;
    import mx.collections.ItemWrapper;
    import mx.core.UIComponentGlobals;
    import mx.collections.ModifiedCollectionView;
    import mx.controls.listClasses.ListBaseSeekPending;
    import mx.collections.ItemResponder;
    import mx.core.EdgeMetrics;
    import mx.controls.listClasses.ListData;
    import mx.events.SandboxMouseEvent;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.core.FlexVersion;
    import mx.controls.scrollClasses.ScrollBar;
    import mx.events.ScrollEvent;
    import mx.events.ScrollEventDetail;
    import flash.display.Shape;
    import mx.core.FlexShape;
    import flash.display.Graphics;
    import mx.core.UIComponent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class List extends ListBase implements IIMESupport 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var createAccessibilityImplementation:Function;

        public var editorXOffset:Number = 0;
        public var itemEditorInstance:IListItemRenderer;
        public var rendererIsEditor:Boolean = false;
        private var dontEdit:Boolean = false;
        public var editorYOffset:Number = 0;
        public var editorWidthOffset:Number = 0;
        private var lastEditedItemPosition:*;
        public var itemEditor:IFactory = new ClassFactory(TextInput);
        public var editable:Boolean = false;
        private var losingFocus:Boolean = false;
        public var editorUsesEnterKey:Boolean = false;
        public var editorDataField:String = "text";
        private var bEditedItemPositionChanged:Boolean = false;
        mx_internal var _lockedRowCount:int = 0;
        private var inEndEdit:Boolean = false;
        public var editorHeightOffset:Number = 0;
        private var _editedItemPosition:Object;
        private var _imeMode:String;
        private var actualRowIndex:int;
        private var _proposedEditedItemPosition:*;
        private var actualColIndex:int = 0;
        protected var measuringObjects:Dictionary;

        public function List()
        {
            listType = "vertical";
            bColumnScrolling = false;
            itemRenderer = new ClassFactory(ListItemRenderer);
            _horizontalScrollPolicy = ScrollPolicy.OFF;
            _verticalScrollPolicy = ScrollPolicy.AUTO;
            defaultColumnCount = 1;
            defaultRowCount = 7;
            addEventListener(ListEvent.ITEM_EDIT_BEGINNING, itemEditorItemEditBeginningHandler, false, EventPriority.DEFAULT_HANDLER);
            addEventListener(ListEvent.ITEM_EDIT_BEGIN, itemEditorItemEditBeginHandler, false, EventPriority.DEFAULT_HANDLER);
            addEventListener(ListEvent.ITEM_EDIT_END, itemEditorItemEditEndHandler, false, EventPriority.DEFAULT_HANDLER);
        }

        override public function measureWidthOfItems(index:int=-1, count:int=0):Number
        {
            var item:IListItemRenderer;
            var rw:Number;
            var data:Object;
            var factory:IFactory;
            if (count == 0)
            {
                count = ((collection) ? collection.length : 0);
            };
            if (((collection) && (collection.length == 0)))
            {
                count = 0;
            };
            var w:Number = 0;
            var bookmark:CursorBookmark = ((iterator) ? iterator.bookmark : null);
            if (((!(index == -1)) && (iterator)))
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, index);
                }
                catch(e:ItemPendingError)
                {
                    return (0);
                };
            };
            var more:Boolean = (!(iterator == null));
            var i:int;
            while (i < count)
            {
                if (more)
                {
                    data = iterator.current;
                    factory = getItemRendererFactory(data);
                    item = measuringObjects[factory];
                    if (!item)
                    {
                        item = getMeasuringRenderer(data);
                    };
                    item.explicitWidth = NaN;
                    setupRendererFromData(item, data);
                    rw = item.measuredWidth;
                    w = Math.max(w, rw);
                };
                if (more)
                {
                    try
                    {
                        more = iterator.moveNext();
                    }
                    catch(e:ItemPendingError)
                    {
                        more = false;
                    };
                };
                i = (i + 1);
            };
            if (iterator)
            {
                iterator.seek(bookmark, 0);
            };
            if (w == 0)
            {
                if (explicitWidth)
                {
                    return (explicitWidth);
                };
                return (DEFAULT_MEASURED_WIDTH);
            };
            var paddingLeft:Number = getStyle("paddingLeft");
            var paddingRight:Number = getStyle("paddingRight");
            w = (w + (paddingLeft + paddingRight));
            return (w);
        }

        private function findNextEnterItemRenderer(_arg_1:KeyboardEvent):void
        {
            if (_proposedEditedItemPosition !== undefined)
            {
                return;
            };
            _editedItemPosition = lastEditedItemPosition;
            var _local_2:int = _editedItemPosition.rowIndex;
            var _local_3:int = _editedItemPosition.columnIndex;
            var _local_4:int = (_editedItemPosition.rowIndex + ((_arg_1.shiftKey) ? -1 : 1));
            if (((_local_4 < collection.length) && (_local_4 >= 0)))
            {
                _local_2 = _local_4;
            };
            var _local_5:ListEvent = new ListEvent(ListEvent.ITEM_EDIT_BEGINNING, false, true);
            _local_5.rowIndex = _local_2;
            _local_5.columnIndex = 0;
            dispatchEvent(_local_5);
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        private function mouseFocusChangeHandler(_arg_1:MouseEvent):void
        {
            if ((((itemEditorInstance) && (!(_arg_1.isDefaultPrevented()))) && (itemRendererContains(itemEditorInstance, DisplayObject(_arg_1.target)))))
            {
                _arg_1.preventDefault();
            };
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
        }

        override protected function mouseUpHandler(_arg_1:MouseEvent):void
        {
            var _local_2:ListEvent;
            var _local_3:IListItemRenderer;
            var _local_4:Sprite;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Point;
            _local_3 = mouseEventToItemRenderer(_arg_1);
            super.mouseUpHandler(_arg_1);
            if ((((_local_3) && (_local_3.data)) && (!(_local_3 == itemEditorInstance))))
            {
                _local_7 = itemRendererToIndices(_local_3);
                if (((editable) && (!(dontEdit))))
                {
                    _local_2 = new ListEvent(ListEvent.ITEM_EDIT_BEGINNING, false, true);
                    _local_2.rowIndex = _local_7.y;
                    _local_2.columnIndex = 0;
                    _local_2.itemRenderer = _local_3;
                    dispatchEvent(_local_2);
                };
            };
        }

        private function itemEditorItemEditEndHandler(event:ListEvent):void
        {
            var bChanged:Boolean;
            var bFieldChanged:Boolean;
            var newData:Object;
            var data:Object;
            var editCollection:IList;
            var listData:BaseListData;
            var fm:IFocusManager;
            if (!event.isDefaultPrevented())
            {
                bChanged = false;
                bFieldChanged = false;
                newData = itemEditorInstance[editorDataField];
                data = event.itemRenderer.data;
                if ((data is String))
                {
                    if (!(newData is String))
                    {
                        newData = newData.toString();
                    };
                }
                else
                {
                    if ((data is uint))
                    {
                        if (!(newData is uint))
                        {
                            newData = uint(newData);
                        };
                    }
                    else
                    {
                        if ((data is int))
                        {
                            if (!(newData is int))
                            {
                                newData = int(newData);
                            };
                        }
                        else
                        {
                            if ((data is Number))
                            {
                                if (!(newData is int))
                                {
                                    newData = Number(newData);
                                };
                            }
                            else
                            {
                                bFieldChanged = true;
                                try
                                {
                                    data[labelField] = newData;
                                    if (!(data is IPropertyChangeNotifier))
                                    {
                                        if (actualCollection)
                                        {
                                            actualCollection.itemUpdated(data, labelField);
                                        }
                                        else
                                        {
                                            collection.itemUpdated(data, labelField);
                                        };
                                    };
                                }
                                catch(e:Error)
                                {
                                    trace("attempt to write to", labelField, "failed.  You may need a custom ITEM_EDIT_END handler");
                                };
                            };
                        };
                    };
                };
                if (!bFieldChanged)
                {
                    if (data !== newData)
                    {
                        bChanged = true;
                        data = newData;
                    };
                    if (bChanged)
                    {
                        editCollection = ((actualCollection) ? (actualCollection as IList) : (collection as IList));
                        if (editCollection)
                        {
                            IList(editCollection).setItemAt(data, event.rowIndex);
                        }
                        else
                        {
                            trace("attempt to update collection failed.  You may need a custom ITEM_EDIT_END handler");
                        };
                    };
                };
                if ((event.itemRenderer is IDropInListItemRenderer))
                {
                    listData = BaseListData(IDropInListItemRenderer(event.itemRenderer).listData);
                    listData.label = itemToLabel(data);
                    IDropInListItemRenderer(event.itemRenderer).listData = listData;
                };
                delete visibleData[itemToUID(event.itemRenderer.data)];
                event.itemRenderer.data = data;
                visibleData[itemToUID(data)] = event.itemRenderer;
            }
            else
            {
                if (event.reason != ListEventReason.OTHER)
                {
                    if (((itemEditorInstance) && (_editedItemPosition)))
                    {
                        if (selectedIndex != _editedItemPosition.rowIndex)
                        {
                            selectedIndex = _editedItemPosition.rowIndex;
                        };
                        fm = focusManager;
                        if ((itemEditorInstance is IFocusManagerComponent))
                        {
                            fm.setFocus(IFocusManagerComponent(itemEditorInstance));
                        };
                    };
                };
            };
            if (((event.reason == ListEventReason.OTHER) || (!(event.isDefaultPrevented()))))
            {
                destroyItemEditor();
            };
        }

        private function itemEditorItemEditBeginningHandler(_arg_1:ListEvent):void
        {
            if (!_arg_1.isDefaultPrevented())
            {
                setEditedItemPosition({
                    "columnIndex":_arg_1.columnIndex,
                    "rowIndex":_arg_1.rowIndex
                });
            }
            else
            {
                if (!itemEditorInstance)
                {
                    _editedItemPosition = null;
                    editable = false;
                    setFocus();
                    editable = true;
                };
            };
        }

        override public function createItemRenderer(_arg_1:Object):IListItemRenderer
        {
            var _local_2:IFactory;
            var _local_3:IListItemRenderer;
            var _local_4:Dictionary;
            var _local_5:*;
            _local_2 = getItemRendererFactory(_arg_1);
            if (!_local_2)
            {
                if (_arg_1 == null)
                {
                    _local_2 = nullItemRenderer;
                };
                if (!_local_2)
                {
                    _local_2 = itemRenderer;
                };
            };
            if (_local_2 == itemRenderer)
            {
                if (((freeItemRenderers) && (freeItemRenderers.length)))
                {
                    _local_3 = freeItemRenderers.pop();
                    delete freeItemRenderersByFactory[_local_2][_local_3];
                };
            }
            else
            {
                if (freeItemRenderersByFactory)
                {
                    _local_4 = freeItemRenderersByFactory[_local_2];
                    if (_local_4)
                    {
                        for (_local_5 in _local_4)
                        {
                            _local_3 = IListItemRenderer(_local_5);
                            delete _local_4[_local_5];
                            break;
                        };
                    };
                };
            };
            if (!_local_3)
            {
                _local_3 = _local_2.newInstance();
                _local_3.styleName = this;
                factoryMap[_local_3] = _local_2;
            };
            _local_3.owner = this;
            return (_local_3);
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            if (_arg_1.target == this)
            {
                super.focusOutHandler(_arg_1);
            };
            if (((_arg_1.relatedObject == this) && (itemRendererContains(itemEditorInstance, DisplayObject(_arg_1.target)))))
            {
                return;
            };
            if (((_arg_1.relatedObject == null) && (itemRendererContains(editedItemRenderer, DisplayObject(_arg_1.target)))))
            {
                return;
            };
            if (((_arg_1.relatedObject == null) && (itemRendererContains(itemEditorInstance, DisplayObject(_arg_1.target)))))
            {
                return;
            };
            if (((itemEditorInstance) && ((!(_arg_1.relatedObject)) || (!(itemRendererContains(itemEditorInstance, _arg_1.relatedObject))))))
            {
                endEdit(ListEventReason.OTHER);
                removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
                removeEventListener(MouseEvent.MOUSE_DOWN, mouseFocusChangeHandler);
            };
        }

        override protected function scrollHorizontally(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:int = listItems.length;
            var _local_5:Number = getStyle("paddingLeft");
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                if (listItems[_local_6].length)
                {
                    listItems[_local_6][0].x = (-(_arg_1) + _local_5);
                };
                _local_6++;
            };
        }

        override protected function drawHighlightIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            super.drawHighlightIndicator(_arg_1, 0, _arg_3, ((unscaledWidth - viewMetrics.left) - viewMetrics.right), _arg_5, _arg_6, _arg_7);
        }

        [Bindable("itemFocusIn")]
        public function get editedItemPosition():Object
        {
            if (_editedItemPosition)
            {
                return ({
                    "rowIndex":_editedItemPosition.rowIndex,
                    "columnIndex":0
                });
            };
            return (_editedItemPosition);
        }

        private function setEditedItemPosition(_arg_1:Object):void
        {
            bEditedItemPositionChanged = true;
            _proposedEditedItemPosition = _arg_1;
            invalidateDisplayList();
        }

        override protected function drawRowBackgrounds():void
        {
            var _local_2:Array;
            var _local_6:int;
            var _local_1:Sprite = Sprite(listContent.getChildByName("rowBGs"));
            if (!_local_1)
            {
                _local_1 = new FlexSprite();
                _local_1.mouseEnabled = false;
                _local_1.name = "rowBGs";
                listContent.addChildAt(_local_1, 0);
            };
            _local_2 = getStyle("alternatingItemColors");
            if (((!(_local_2)) || (_local_2.length == 0)))
            {
                while (_local_1.numChildren > _local_6)
                {
                    _local_1.removeChildAt((_local_1.numChildren - 1));
                };
                return;
            };
            StyleManager.getColorNames(_local_2);
            var _local_3:int;
            var _local_4:int = verticalScrollPosition;
            var _local_5:int;
            _local_6 = listItems.length;
            while (_local_3 < _local_6)
            {
                drawRowBackground(_local_1, _local_5++, rowInfo[_local_3].y, rowInfo[_local_3].height, _local_2[(_local_4 % _local_2.length)], _local_4);
                _local_3++;
                _local_4++;
            };
            while (_local_1.numChildren > _local_6)
            {
                _local_1.removeChildAt((_local_1.numChildren - 1));
            };
        }

        override protected function drawCaretIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            super.drawCaretIndicator(_arg_1, 0, _arg_3, ((unscaledWidth - viewMetrics.left) - viewMetrics.right), _arg_5, _arg_6, _arg_7);
        }

        private function deactivateHandler(_arg_1:Event):void
        {
            if (itemEditorInstance)
            {
                endEdit(ListEventReason.OTHER);
                losingFocus = true;
                setFocus();
            };
        }

        protected function layoutEditor(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            itemEditorInstance.move(_arg_1, _arg_2);
            itemEditorInstance.setActualSize(_arg_3, _arg_4);
        }

        private function editorKeyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ESCAPE)
            {
                endEdit(ListEventReason.CANCELLED);
            }
            else
            {
                if (((_arg_1.ctrlKey) && (_arg_1.charCode == 46)))
                {
                    endEdit(ListEventReason.CANCELLED);
                }
                else
                {
                    if (((_arg_1.charCode == Keyboard.ENTER) && (!(_arg_1.keyCode == 229))))
                    {
                        if (editorUsesEnterKey)
                        {
                            return;
                        };
                        if (endEdit(ListEventReason.NEW_ROW))
                        {
                            if (!dontEdit)
                            {
                                findNextEnterItemRenderer(_arg_1);
                            };
                        };
                    };
                };
            };
        }

        private function itemEditorItemEditBeginHandler(_arg_1:ListEvent):void
        {
            var _local_2:IFocusManager;
            if (root)
            {
                systemManager.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
            };
            if (((!(_arg_1.isDefaultPrevented())) && (!(listItems[actualRowIndex][actualColIndex].data == null))))
            {
                createItemEditor(_arg_1.columnIndex, _arg_1.rowIndex);
                if (((editedItemRenderer is IDropInListItemRenderer) && (itemEditorInstance is IDropInListItemRenderer)))
                {
                    IDropInListItemRenderer(itemEditorInstance).listData = IDropInListItemRenderer(editedItemRenderer).listData;
                };
                if (!rendererIsEditor)
                {
                    itemEditorInstance.data = editedItemRenderer.data;
                };
                if ((itemEditorInstance is IInvalidating))
                {
                    IInvalidating(itemEditorInstance).validateNow();
                };
                if ((itemEditorInstance is IIMESupport))
                {
                    IIMESupport(itemEditorInstance).imeMode = imeMode;
                };
                _local_2 = focusManager;
                if ((itemEditorInstance is IFocusManagerComponent))
                {
                    _local_2.setFocus(IFocusManagerComponent(itemEditorInstance));
                };
                _local_2.defaultButtonEnabled = false;
                _arg_1 = new ListEvent(ListEvent.ITEM_FOCUS_IN);
                _arg_1.rowIndex = _editedItemPosition.rowIndex;
                _arg_1.itemRenderer = itemEditorInstance;
                dispatchEvent(_arg_1);
            };
        }

        private function editingTemporarilyPrevented(_arg_1:Object):Boolean
        {
            var _local_2:int;
            var _local_3:IListItemRenderer;
            if (((runningDataEffect) && (_arg_1)))
            {
                _local_2 = ((_arg_1.rowIndex - verticalScrollPosition) + offscreenExtraRowsTop);
                if (((_local_2 < 0) || (_local_2 >= listItems.length)))
                {
                    return (false);
                };
                _local_3 = listItems[_local_2][0];
                if (((_local_3) && ((getRendererSemanticValue(_local_3, "replaced")) || (getRendererSemanticValue(_local_3, "removed")))))
                {
                    return (true);
                };
            };
            return (false);
        }

        override public function measureHeightOfItems(index:int=-1, count:int=0):Number
        {
            var data:Object;
            var item:IListItemRenderer;
            if (count == 0)
            {
                count = ((collection) ? collection.length : 0);
            };
            var paddingTop:Number = getStyle("paddingTop");
            var paddingBottom:Number = getStyle("paddingBottom");
            var ww:Number = 200;
            if (listContent.width)
            {
                ww = listContent.width;
            };
            var h:Number = 0;
            var bookmark:CursorBookmark = ((iterator) ? iterator.bookmark : null);
            if (((!(index == -1)) && (iterator)))
            {
                iterator.seek(CursorBookmark.FIRST, index);
            };
            var rh:Number = rowHeight;
            var more:Boolean = (!(iterator == null));
            var i:int;
            while (i < count)
            {
                if (more)
                {
                    rh = rowHeight;
                    data = iterator.current;
                    item = getMeasuringRenderer(data);
                    item.explicitWidth = ww;
                    setupRendererFromData(item, data);
                    if (variableRowHeight)
                    {
                        rh = ((item.getExplicitOrMeasuredHeight() + paddingTop) + paddingBottom);
                    };
                };
                h = (h + rh);
                if (more)
                {
                    try
                    {
                        more = iterator.moveNext();
                    }
                    catch(e:ItemPendingError)
                    {
                        more = false;
                    };
                };
                i = (i + 1);
            };
            if (iterator)
            {
                iterator.seek(bookmark, 0);
            };
            return (h);
        }

        mx_internal function callSetupRendererFromData(_arg_1:IListItemRenderer, _arg_2:Object):void
        {
            setupRendererFromData(_arg_1, _arg_2);
        }

        override protected function drawSelectionIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            super.drawSelectionIndicator(_arg_1, 0, _arg_3, ((unscaledWidth - viewMetrics.left) - viewMetrics.right), _arg_5, _arg_6, _arg_7);
        }

        private function keyFocusChangeHandler(_arg_1:FocusEvent):void
        {
            if ((((_arg_1.keyCode == Keyboard.TAB) && (!(_arg_1.isDefaultPrevented()))) && (findNextItemRenderer(_arg_1.shiftKey))))
            {
                _arg_1.preventDefault();
            };
        }

        public function set editedItemPosition(_arg_1:Object):void
        {
            var _local_2:Object = {
                "rowIndex":_arg_1.rowIndex,
                "columnIndex":0
            };
            setEditedItemPosition(_local_2);
        }

        override protected function makeRowsAndColumns(left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean=false, rowsNeeded:uint=0):Point
        {
            var yy:Number;
            var hh:Number;
            var i:int;
            var j:int;
            var item:IListItemRenderer;
            var oldItem:IListItemRenderer;
            var rowData:BaseListData;
            var data:Object;
            var wrappedData:Object;
            var uid:String;
            var rh:Number;
            var ld:BaseListData;
            var rr:Array;
            //var rowInfo:ListRowInfo;
            var dx:Number;
            var dy:Number;
            var dw:Number;
            var dh:Number;
            listContent.allowItemSizeChangeNotification = false;
            var paddingLeft:Number = getStyle("paddingLeft");
            var paddingRight:Number = getStyle("paddingRight");
            var xx:Number = ((left + paddingLeft) - horizontalScrollPosition);
            var ww:Number = ((right - paddingLeft) - paddingRight);
            var bSelected:Boolean;
            var bHighlight:Boolean;
            var bCaret:Boolean;
            var colNum:int;
            var rowNum:int = lockedRowCount;
            var rowsMade:int;
            var more:Boolean = true;
            var valid:Boolean = true;
            yy = top;
            rowNum = firstRow;
            more = (((!(iterator == null)) && (!(iterator.afterLast))) && (iteratorValid));
            while ((((!(byCount)) && (yy < bottom)) || ((byCount) && (rowsNeeded > 0))))
            {
                if (byCount)
                {
                    rowsNeeded--;
                };
                valid = more;
                wrappedData = ((more) ? iterator.current : null);
                data = ((wrappedData is ItemWrapper) ? wrappedData.data : wrappedData);
                uid = null;
                if (!listItems[rowNum])
                {
                    listItems[rowNum] = [];
                };
                if (valid)
                {
                    item = listItems[rowNum][colNum];
                    uid = itemToUID(wrappedData);
                    if (((!(item)) || (((runningDataEffect) && (dataItemWrappersByRenderer[item])) ? (!(dataItemWrappersByRenderer[item] == wrappedData)) : (!(item.data == data)))))
                    {
                        if (allowRendererStealingDuringLayout)
                        {
                            item = visibleData[uid];
                            if (((!(item)) && (!(wrappedData == data))))
                            {
                                item = visibleData[itemToUID(data)];
                            };
                        };
                        if (item)
                        {
                            ld = BaseListData(rowMap[item.name]);
                            if (((ld) && (ld.rowIndex > rowNum)))
                            {
                                listItems[ld.rowIndex] = [];
                            }
                            else
                            {
                                item = null;
                            };
                        };
                        if (!item)
                        {
                            item = getReservedOrFreeItemRenderer(wrappedData);
                        };
                        if (!item)
                        {
                            item = createItemRenderer(data);
                            item.owner = this;
                            item.styleName = listContent;
                            listContent.addChild(DisplayObject(item));
                        };
                        oldItem = listItems[rowNum][colNum];
                        if (oldItem)
                        {
                            addToFreeItemRenderers(oldItem);
                        };
                        listItems[rowNum][colNum] = item;
                    };
                    rowData = makeListData(data, uid, rowNum);
                    rowMap[item.name] = rowData;
                    if ((item is IDropInListItemRenderer))
                    {
                        if (data != null)
                        {
                            IDropInListItemRenderer(item).listData = rowData;
                        }
                        else
                        {
                            IDropInListItemRenderer(item).listData = null;
                        };
                    };
                    item.data = data;
                    item.enabled = enabled;
                    item.visible = true;
                    if (uid != null)
                    {
                        visibleData[uid] = item;
                    };
                    if (wrappedData != data)
                    {
                        dataItemWrappersByRenderer[item] = wrappedData;
                    };
                    item.explicitWidth = ww;
                    if (((item is IInvalidating) && ((wordWrapChanged) || (variableRowHeight))))
                    {
                        IInvalidating(item).invalidateSize();
                    };
                    UIComponentGlobals.layoutManager.validateClient(item, true);
                    hh = Math.ceil(((variableRowHeight) ? ((item.getExplicitOrMeasuredHeight() + cachedPaddingTop) + cachedPaddingBottom) : rowHeight));
                    rh = item.getExplicitOrMeasuredHeight();
                    item.setActualSize(ww, ((variableRowHeight) ? rh : ((rowHeight - cachedPaddingTop) - cachedPaddingBottom)));
                    item.move(xx, (yy + cachedPaddingTop));
                }
                else
                {
                    hh = ((rowNum > 0) ? rowInfo[(rowNum - 1)].height : rowHeight);
                    if (hh == 0)
                    {
                        hh = rowHeight;
                    };
                    oldItem = listItems[rowNum][colNum];
                    if (oldItem)
                    {
                        addToFreeItemRenderers(oldItem);
                        listItems[rowNum].splice(colNum, 1);
                    };
                };
                bSelected = (!(selectedData[uid] == null));
                if (wrappedData != data)
                {
                    bSelected = ((bSelected) || (selectedData[itemToUID(data)]));
                    bSelected = (((bSelected) && (!(getRendererSemanticValue(item, ModifiedCollectionView.REPLACEMENT)))) && (!(getRendererSemanticValue(item, ModifiedCollectionView.ADDED))));
                };
                bHighlight = (highlightUID == uid);
                bCaret = (caretUID == uid);
                rowInfo[rowNum] = new ListRowInfo(yy, hh, uid, data);
                if (valid)
                {
                    drawItem(item, bSelected, bHighlight, bCaret);
                };
                yy = (yy + hh);
                rowNum = (rowNum + 1);
                rowsMade = (rowsMade + 1);
                if (((iterator) && (more)))
                {
                    try
                    {
                        more = iterator.moveNext();
                    }
                    catch(e:ItemPendingError)
                    {
                        lastSeekPending = new ListBaseSeekPending(CursorBookmark.CURRENT, 0);
                        e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                        more = false;
                        iteratorValid = false;
                    };
                };
            };
            if (!byCount)
            {
                while (rowNum < listItems.length)
                {
                    rr = listItems.pop();
                    rowInfo.pop();
                    while (rr.length)
                    {
                        item = rr.pop();
                        addToFreeItemRenderers(item);
                    };
                };
            };
            if (itemEditorInstance)
            {
                listContent.setChildIndex(DisplayObject(itemEditorInstance), (listContent.numChildren - 1));
                item = listItems[actualRowIndex][actualColIndex];
                var rowInfo:ListRowInfo = rowInfo[actualRowIndex];
                if (((item) && (!(rendererIsEditor))))
                {
                    dx = editorXOffset;
                    dy = editorYOffset;
                    dw = editorWidthOffset;
                    dh = editorHeightOffset;
                    layoutEditor((item.x + dx), (rowInfo.y + dy), Math.min((item.width + dw), ((listContent.width - listContent.x) - itemEditorInstance.x)), Math.min((rowInfo.height + dh), ((listContent.height - listContent.y) - itemEditorInstance.y)));
                };
            };
            listContent.allowItemSizeChangeNotification = variableRowHeight;
            return (new Point(colNum, rowsMade));
        }

        override protected function measure():void
        {
            super.measure();
            var _local_1:EdgeMetrics = viewMetrics;
            measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
            if (((((initialized) && (variableRowHeight)) && (explicitRowCount < 1)) && (isNaN(explicitRowHeight))))
            {
                measuredHeight = height;
            };
        }

        private function findNextItemRenderer(_arg_1:Boolean):Boolean
        {
            if (!lastEditedItemPosition)
            {
                return (false);
            };
            if (_proposedEditedItemPosition !== undefined)
            {
                return (true);
            };
            _editedItemPosition = lastEditedItemPosition;
            var _local_2:int = _editedItemPosition.rowIndex;
            var _local_3:int = _editedItemPosition.columnIndex;
            var _local_4:int = (_editedItemPosition.rowIndex + ((_arg_1) ? -1 : 1));
            if (((_local_4 < collection.length) && (_local_4 >= 0)))
            {
                _local_2 = _local_4;
            }
            else
            {
                setEditedItemPosition(null);
                losingFocus = true;
                setFocus();
                return (false);
            };
            var _local_5:ListEvent = new ListEvent(ListEvent.ITEM_EDIT_BEGINNING, false, true);
            _local_5.rowIndex = _local_2;
            _local_5.columnIndex = _local_3;
            dispatchEvent(_local_5);
            return (true);
        }

        override protected function mouseDownHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Sprite;
            var _local_5:Point;
            var _local_6:Boolean;
            _local_2 = mouseEventToItemRenderer(_arg_1);
            var _local_4:Boolean = itemRendererContains(itemEditorInstance, DisplayObject(_arg_1.target));
            if (!_local_4)
            {
                if (((_local_2) && (_local_2.data)))
                {
                    _local_5 = itemRendererToIndices(_local_2);
                    _local_6 = true;
                    if (itemEditorInstance)
                    {
                        _local_6 = endEdit(ListEventReason.NEW_ROW);
                    };
                    if (!_local_6)
                    {
                        return;
                    };
                }
                else
                {
                    if (itemEditorInstance)
                    {
                        endEdit(ListEventReason.OTHER);
                    };
                };
                super.mouseDownHandler(_arg_1);
            };
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (itemEditorInstance)
            {
                return;
            };
            super.keyDownHandler(_arg_1);
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            var _local_2:Boolean;
            if (_arg_1.target != this)
            {
                return;
            };
            if (losingFocus)
            {
                losingFocus = false;
                return;
            };
            super.focusInHandler(_arg_1);
            if (((editable) && (!(isPressed))))
            {
                _editedItemPosition = lastEditedItemPosition;
                _local_2 = (!(editedItemPosition == null));
                if (!_editedItemPosition)
                {
                    _editedItemPosition = {
                        "rowIndex":0,
                        "columnIndex":0
                    };
                    _local_2 = ((listItems.length) && (listItems[0].length > 0));
                };
                if (_local_2)
                {
                    setEditedItemPosition(_editedItemPosition);
                };
            };
            if (editable)
            {
                addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
                addEventListener(MouseEvent.MOUSE_DOWN, mouseFocusChangeHandler);
            };
        }

        override protected function mouseEventToItemRenderer(_arg_1:MouseEvent):IListItemRenderer
        {
            var _local_2:IListItemRenderer = super.mouseEventToItemRenderer(_arg_1);
            return ((_local_2 == itemEditorInstance) ? null : _local_2);
        }

        protected function makeListData(_arg_1:Object, _arg_2:String, _arg_3:int):BaseListData
        {
            return (new ListData(itemToLabel(_arg_1), itemToIcon(_arg_1), labelField, _arg_2, this, _arg_3));
        }

        public function createItemEditor(_arg_1:int, _arg_2:int):void
        {
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            _arg_1 = 0;
            if (_arg_2 > lockedRowCount)
            {
                _arg_2 = (_arg_2 - verticalScrollPosition);
            };
            var _local_3:IListItemRenderer = listItems[_arg_2][_arg_1];
            var _local_4:ListRowInfo = rowInfo[_arg_2];
            if (!rendererIsEditor)
            {
                _local_5 = 0;
                _local_6 = -2;
                _local_7 = 0;
                _local_8 = 4;
                if (!itemEditorInstance)
                {
                    _local_5 = editorXOffset;
                    _local_6 = editorYOffset;
                    _local_7 = editorWidthOffset;
                    _local_8 = editorHeightOffset;
                    itemEditorInstance = itemEditor.newInstance();
                    itemEditorInstance.owner = this;
                    itemEditorInstance.styleName = this;
                    listContent.addChild(DisplayObject(itemEditorInstance));
                };
                listContent.setChildIndex(DisplayObject(itemEditorInstance), (listContent.numChildren - 1));
                itemEditorInstance.visible = true;
                layoutEditor((_local_3.x + _local_5), (_local_4.y + _local_6), Math.min((_local_3.width + _local_7), ((listContent.width - listContent.x) - itemEditorInstance.x)), Math.min((_local_4.height + _local_8), ((listContent.height - listContent.y) - itemEditorInstance.y)));
                DisplayObject(itemEditorInstance).addEventListener("focusOut", itemEditorFocusOutHandler);
            }
            else
            {
                itemEditorInstance = _local_3;
            };
            DisplayObject(itemEditorInstance).addEventListener(KeyboardEvent.KEY_DOWN, editorKeyDownHandler);
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_DOWN, editorMouseDownHandler, true, 0, true);
            systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, editorMouseDownHandler, false, 0, true);
        }

        public function get lockedRowCount():int
        {
            return (_lockedRowCount);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            if (itemEditorInstance)
            {
                endEdit(ListEventReason.OTHER);
            };
            invalidateDisplayList();
        }

        protected function endEdit(_arg_1:String):Boolean
        {
            if (!editedItemRenderer)
            {
                return (true);
            };
            inEndEdit = true;
            var _local_2:ListEvent = new ListEvent(ListEvent.ITEM_EDIT_END, false, true);
            _local_2.rowIndex = editedItemPosition.rowIndex;
            _local_2.itemRenderer = editedItemRenderer;
            _local_2.reason = _arg_1;
            dispatchEvent(_local_2);
            dontEdit = (!(itemEditorInstance == null));
            if (((!(dontEdit)) && (_arg_1 == ListEventReason.CANCELLED)))
            {
                losingFocus = true;
                setFocus();
            };
            inEndEdit = false;
            return (!(_local_2.isDefaultPrevented()));
        }

        override protected function collectionChangeHandler(_arg_1:Event):void
        {
            var _local_2:CollectionEvent;
            if ((_arg_1 is CollectionEvent))
            {
                _local_2 = CollectionEvent(_arg_1);
                if (_local_2.kind == CollectionEventKind.REMOVE)
                {
                    if (editedItemPosition)
                    {
                        if (collection.length == 0)
                        {
                            if (itemEditorInstance)
                            {
                                endEdit(ListEventReason.CANCELLED);
                            };
                            setEditedItemPosition(null);
                        }
                        else
                        {
                            if (_local_2.location <= editedItemPosition.rowIndex)
                            {
                                if (inEndEdit)
                                {
                                    _editedItemPosition = {
                                        "columnIndex":editedItemPosition.columnIndex,
                                        "rowIndex":Math.max(0, (editedItemPosition.rowIndex - _local_2.items.length))
                                    };
                                }
                                else
                                {
                                    setEditedItemPosition({
                                        "columnIndex":editedItemPosition.columnIndex,
                                        "rowIndex":Math.max(0, (editedItemPosition.rowIndex - _local_2.items.length))
                                    });
                                };
                            };
                        };
                    };
                };
            };
            super.collectionChangeHandler(_arg_1);
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (((listItems.length) && (listItems[0].length)))
                {
                    return ((borderMetrics.top + cachedPaddingTop) + listItems[0][0].baselinePosition);
                };
                return (NaN);
            };
            return (super.baselinePosition);
        }

        private function itemEditorFocusOutHandler(_arg_1:FocusEvent):void
        {
            if (((_arg_1.relatedObject) && (contains(_arg_1.relatedObject))))
            {
                return;
            };
            if (!_arg_1.relatedObject)
            {
                return;
            };
            if (itemEditorInstance)
            {
                endEdit(ListEventReason.OTHER);
            };
        }

        override public function set dataProvider(_arg_1:Object):void
        {
            if (itemEditorInstance)
            {
                endEdit(ListEventReason.OTHER);
            };
            super.dataProvider = _arg_1;
        }

        override protected function initializeAccessibility():void
        {
            if (createAccessibilityImplementation != null)
            {
                createAccessibilityImplementation(this);
            };
        }

        override protected function configureScrollBars():void
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_1:int = listItems.length;
            if (_local_1 == 0)
            {
                return;
            };
            var _local_4:int = listItems.length;
            while (((_local_1 > 1) && ((rowInfo[(_local_4 - 1)].y + rowInfo[(_local_4 - 1)].height) > (listContent.height - listContent.bottomOffset))))
            {
                _local_1--;
                _local_4--;
            };
            var _local_5:int = ((verticalScrollPosition - lockedRowCount) - 1);
            var _local_6:int;
            while (((_local_1) && (listItems[(_local_1 - 1)].length == 0)))
            {
                if (((collection) && ((_local_1 + _local_5) >= collection.length)))
                {
                    _local_1--;
                    _local_6++;
                }
                else
                {
                    break;
                };
            };
            if ((((verticalScrollPosition > 0) && (_local_6 > 0)) && (!(runningDataEffect))))
            {
                if (adjustVerticalScrollPositionDownward(Math.max(_local_1, 1)))
                {
                    return;
                };
            };
            if (listContent.topOffset)
            {
                _local_2 = Math.abs(listContent.topOffset);
                _local_3 = 0;
                while ((rowInfo[_local_3].y + rowInfo[_local_3].height) <= _local_2)
                {
                    _local_1--;
                    if (++_local_3 == _local_1) break;
                };
            };
            var _local_7:int = listItems[0].length;
            var _local_8:Object = horizontalScrollBar;
            var _local_9:Object = verticalScrollBar;
            var _local_10:int = Math.round(unscaledWidth);
            var _local_11:int = ((collection) ? (collection.length - lockedRowCount) : 0);
            var _local_12:int = (_local_1 - lockedRowCount);
            setScrollBarProperties(((isNaN(_maxHorizontalScrollPosition)) ? Math.round(listContent.width) : Math.round((_maxHorizontalScrollPosition + _local_10))), _local_10, _local_11, _local_12);
            maxVerticalScrollPosition = Math.max((_local_11 - _local_12), 0);
        }

        override protected function mouseWheelHandler(_arg_1:MouseEvent):void
        {
            if (itemEditorInstance)
            {
                endEdit(ListEventReason.OTHER);
            };
            super.mouseWheelHandler(_arg_1);
        }

        override public function set maxHorizontalScrollPosition(_arg_1:Number):void
        {
            super.maxHorizontalScrollPosition = _arg_1;
            scrollAreaChanged = true;
            invalidateDisplayList();
        }

        override protected function scrollHandler(event:Event):void
        {
            var scrollBar:ScrollBar;
            var pos:Number;
            var delta:int;
            var o:EdgeMetrics;
            var bookmark:CursorBookmark;
            if ((event is ScrollEvent))
            {
                if (itemEditorInstance)
                {
                    endEdit(ListEventReason.OTHER);
                };
                if (((!(liveScrolling)) && (ScrollEvent(event).detail == ScrollEventDetail.THUMB_TRACK)))
                {
                    return;
                };
                scrollBar = ScrollBar(event.target);
                pos = scrollBar.scrollPosition;
                removeClipMask();
                if (scrollBar == verticalScrollBar)
                {
                    delta = (pos - verticalScrollPosition);
                    super.scrollHandler(event);
                    if (((Math.abs(delta) >= (listItems.length - lockedRowCount)) || (!(iteratorValid))))
                    {
                        try
                        {
                            if (!iteratorValid)
                            {
                                iterator.seek(CursorBookmark.FIRST, pos);
                            }
                            else
                            {
                                iterator.seek(CursorBookmark.CURRENT, delta);
                            };
                            if (!iteratorValid)
                            {
                                iteratorValid = true;
                                lastSeekPending = null;
                            };
                        }
                        catch(e:ItemPendingError)
                        {
                            lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, pos);
                            e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                            iteratorValid = false;
                        };
                        bookmark = iterator.bookmark;
                        clearIndicators();
                        clearVisibleData();
                        makeRowsAndColumns(0, 0, listContent.width, listContent.height, 0, 0);
                        iterator.seek(bookmark, 0);
                    }
                    else
                    {
                        if (delta != 0)
                        {
                            scrollVertically(pos, Math.abs(delta), Boolean((delta > 0)));
                        };
                    };
                    if (variableRowHeight)
                    {
                        configureScrollBars();
                    };
                    drawRowBackgrounds();
                }
                else
                {
                    delta = (pos - _horizontalScrollPosition);
                    super.scrollHandler(event);
                    scrollHorizontally(pos, Math.abs(delta), Boolean((delta > 0)));
                };
                addClipMask(false);
            };
        }

        public function get editedItemRenderer():IListItemRenderer
        {
            if (!itemEditorInstance)
            {
                return (null);
            };
            return (listItems[actualRowIndex][actualColIndex]);
        }

        private function commitEditedItemPosition(_arg_1:Object):void
        {
            var _local_10:String;
            if (((!(enabled)) || (!(editable))))
            {
                return;
            };
            if (((((itemEditorInstance) && (_arg_1)) && (itemEditorInstance is IFocusManagerComponent)) && (_editedItemPosition.rowIndex == _arg_1.rowIndex)))
            {
                IFocusManagerComponent(itemEditorInstance).setFocus();
                return;
            };
            if (itemEditorInstance)
            {
                if (!_arg_1)
                {
                    _local_10 = ListEventReason.OTHER;
                }
                else
                {
                    _local_10 = ListEventReason.NEW_ROW;
                };
                if (((!(endEdit(_local_10))) && (!(_local_10 == ListEventReason.OTHER))))
                {
                    return;
                };
            };
            _editedItemPosition = _arg_1;
            if (((!(_arg_1)) || (dontEdit)))
            {
                return;
            };
            var _local_2:int = _arg_1.rowIndex;
            var _local_3:int = _arg_1.columnIndex;
            if (selectedIndex != _arg_1.rowIndex)
            {
                commitSelectedIndex(_arg_1.rowIndex);
            };
            var _local_4:int = lockedRowCount;
            var _local_5:int = ((((verticalScrollPosition + listItems.length) - offscreenExtraRowsTop) - offscreenExtraRowsBottom) - 1);
            var _local_6:int = (((rowInfo[((listItems.length - offscreenExtraRowsBottom) - 1)].y + rowInfo[((listItems.length - offscreenExtraRowsBottom) - 1)].height) > listContent.height) ? 1 : 0);
            if (_local_2 > _local_4)
            {
                if (_local_2 < (verticalScrollPosition + _local_4))
                {
                    verticalScrollPosition = (_local_2 - _local_4);
                }
                else
                {
                    while (((_local_2 > _local_5) || (((_local_2 == _local_5) && (_local_2 > (verticalScrollPosition + _local_4))) && (_local_6))))
                    {
                        if (verticalScrollPosition == maxVerticalScrollPosition) break;
                        verticalScrollPosition = Math.min((verticalScrollPosition + ((_local_2 > _local_5) ? (_local_2 - _local_5) : _local_6)), maxVerticalScrollPosition);
                        _local_5 = ((((verticalScrollPosition + listItems.length) - offscreenExtraRowsTop) - offscreenExtraRowsBottom) - 1);
                        _local_6 = (((rowInfo[((listItems.length - offscreenExtraRowsBottom) - 1)].y + rowInfo[((listItems.length - offscreenExtraRowsBottom) - 1)].height) > listContent.height) ? 1 : 0);
                    };
                };
                actualRowIndex = (_local_2 - verticalScrollPosition);
            }
            else
            {
                if (_local_2 == _local_4)
                {
                    verticalScrollPosition = 0;
                };
                actualRowIndex = _local_2;
            };
            var _local_7:EdgeMetrics = borderMetrics;
            actualColIndex = _local_3;
            var _local_8:IListItemRenderer = listItems[actualRowIndex][actualColIndex];
            if (!_local_8)
            {
                commitEditedItemPosition(null);
                return;
            };
            if (!isItemEditable(_local_8.data))
            {
                commitEditedItemPosition(null);
                return;
            };
            var _local_9:ListEvent = new ListEvent(ListEvent.ITEM_EDIT_BEGIN, false, true);
            _local_9.rowIndex = _editedItemPosition.rowIndex;
            _local_9.itemRenderer = _local_8;
            dispatchEvent(_local_9);
            lastEditedItemPosition = _editedItemPosition;
            if (bEditedItemPositionChanged)
            {
                bEditedItemPositionChanged = false;
                commitEditedItemPosition(_proposedEditedItemPosition);
                _proposedEditedItemPosition = undefined;
            };
            if (!itemEditorInstance)
            {
                commitEditedItemPosition(null);
            };
        }

        protected function drawRowBackground(_arg_1:Sprite, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:uint, _arg_6:int):void
        {
            var _local_7:Shape;
            if (_arg_2 < _arg_1.numChildren)
            {
                _local_7 = Shape(_arg_1.getChildAt(_arg_2));
            }
            else
            {
                _local_7 = new FlexShape();
                _local_7.name = "rowBackground";
                _arg_1.addChild(_local_7);
            };
            _arg_4 = Math.min(rowInfo[_arg_2].height, (listContent.height - rowInfo[_arg_2].y));
            _local_7.y = rowInfo[_arg_2].y;
            var _local_8:Graphics = _local_7.graphics;
            _local_8.clear();
            _local_8.beginFill(_arg_5, getStyle("backgroundAlpha"));
            _local_8.drawRect(0, 0, listContent.width, _arg_4);
            _local_8.endFill();
        }

        override protected function commitProperties():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:IListItemRenderer;
            var _local_4:Number;
            var _local_5:int;
            super.commitProperties();
            if (itemsNeedMeasurement)
            {
                itemsNeedMeasurement = false;
                if (isNaN(explicitRowHeight))
                {
                    if (iterator)
                    {
                        _local_1 = getStyle("paddingTop");
                        _local_2 = getStyle("paddingBottom");
                        _local_3 = getMeasuringRenderer(iterator.current);
                        _local_4 = 200;
                        if (listContent.width)
                        {
                            _local_4 = listContent.width;
                        };
                        _local_3.explicitWidth = _local_4;
                        setupRendererFromData(_local_3, iterator.current);
                        _local_5 = ((_local_3.getExplicitOrMeasuredHeight() + _local_1) + _local_2);
                        setRowHeight(Math.max(_local_5, 20));
                    }
                    else
                    {
                        setRowHeight(20);
                    };
                };
                if (isNaN(explicitColumnWidth))
                {
                    setColumnWidth(measureWidthOfItems(0, ((explicitRowCount < 1) ? defaultRowCount : explicitRowCount)));
                };
            };
        }

        mx_internal function getMeasuringRenderer(_arg_1:Object):IListItemRenderer
        {
            var _local_2:IListItemRenderer;
            if (!measuringObjects)
            {
                measuringObjects = new Dictionary(true);
            };
            var _local_3:IFactory = getItemRendererFactory(_arg_1);
            _local_2 = measuringObjects[_local_3];
            if (!_local_2)
            {
                _local_2 = createItemRenderer(_arg_1);
                _local_2.owner = this;
                _local_2.name = "hiddenItem";
                _local_2.visible = false;
                _local_2.styleName = listContent;
                listContent.addChild(DisplayObject(_local_2));
                measuringObjects[_local_3] = _local_2;
            };
            return (_local_2);
        }

        mx_internal function purgeMeasuringRenderers():void
        {
            var _local_1:IListItemRenderer;
            for each (_local_1 in measuringObjects)
            {
                if (_local_1.parent)
                {
                    _local_1.parent.removeChild(DisplayObject(_local_1));
                };
            };
            if (!measuringObjects)
            {
                measuringObjects = new Dictionary(true);
            };
        }

        private function adjustVerticalScrollPositionDownward(rowCount:int):Boolean
        {
            var n:int;
            var j:int;
            var more:Boolean;
            var data:Object;
            var bookmark:CursorBookmark = iterator.bookmark;
            var h:Number = 0;
            var ch:Number = 0;
            var paddingTop:Number = getStyle("paddingTop");
            var paddingBottom:Number = getStyle("paddingBottom");
            var paddingLeft:Number = getStyle("paddingLeft");
            var paddingRight:Number = getStyle("paddingRight");
            h = (rowInfo[(rowCount - 1)].y + rowInfo[(rowCount - 1)].height);
            h = ((listContent.heightExcludingOffsets - listContent.topOffset) - h);
            var numRows:int;
            try
            {
                if (iterator.afterLast)
                {
                    iterator.seek(CursorBookmark.LAST, 0);
                }
                else
                {
                    more = iterator.movePrevious();
                };
            }
            catch(e:ItemPendingError)
            {
                more = false;
            };
            if (!more)
            {
                super.verticalScrollPosition = 0;
                try
                {
                    iterator.seek(CursorBookmark.FIRST, 0);
                    if (!iteratorValid)
                    {
                        iteratorValid = true;
                        lastSeekPending = null;
                    };
                }
                catch(e:ItemPendingError)
                {
                    lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, 0);
                    e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                    iteratorValid = false;
                    invalidateList();
                    return (true);
                };
                updateList();
                return (true);
            };
            var item:IListItemRenderer = getMeasuringRenderer(iterator.current);
            item.explicitWidth = ((listContent.width - paddingLeft) - paddingRight);
            while (((h > 0) && (more)))
            {
                if (more)
                {
                    data = iterator.current;
                    setupRendererFromData(item, data);
                    ch = ((variableRowHeight) ? ((item.getExplicitOrMeasuredHeight() + paddingBottom) + paddingTop) : rowHeight);
                };
                h = (h - ch);
                try
                {
                    more = iterator.movePrevious();
                    numRows = (numRows + 1);
                }
                catch(e:ItemPendingError)
                {
                    more = false;
                };
            };
            if (h < 0)
            {
                numRows = (numRows - 1);
            };
            iterator.seek(bookmark, 0);
            verticalScrollPosition = Math.max(0, (verticalScrollPosition - numRows));
            if (((numRows > 0) && (!(variableRowHeight))))
            {
                configureScrollBars();
            };
            return (numRows > 0);
        }

        public function isItemEditable(_arg_1:Object):Boolean
        {
            if (!editable)
            {
                return (false);
            };
            if (_arg_1 == null)
            {
                return (false);
            };
            return (true);
        }

        override protected function adjustListContent(_arg_1:Number=-1, _arg_2:Number=-1):void
        {
            var _local_3:Number = (viewMetrics.left + Math.max(listContent.leftOffset, 0));
            var _local_4:Number = (viewMetrics.top + listContent.topOffset);
            listContent.move(_local_3, _local_4);
            var _local_5:Number = ((Math.max(0, listContent.rightOffset) - _local_3) - viewMetrics.right);
            var _local_6:Number = ((Math.max(0, listContent.bottomOffset) - _local_4) - viewMetrics.bottom);
            var _local_7:Number = (_arg_1 + _local_5);
            if (((horizontalScrollPolicy == ScrollPolicy.ON) || ((horizontalScrollPolicy == ScrollPolicy.AUTO) && (!(isNaN(_maxHorizontalScrollPosition))))))
            {
                if (isNaN(_maxHorizontalScrollPosition))
                {
                    _local_7 = (_local_7 * 2);
                }
                else
                {
                    _local_7 = (_local_7 + _maxHorizontalScrollPosition);
                };
            };
            listContent.setActualSize(_local_7, (_arg_2 + _local_6));
        }

        private function editorMouseDownHandler(_arg_1:Event):void
        {
            if (((_arg_1 is MouseEvent) && (itemRendererContains(itemEditorInstance, DisplayObject(_arg_1.target)))))
            {
                return;
            };
            endEdit(ListEventReason.OTHER);
        }

        override public function set itemRenderer(_arg_1:IFactory):void
        {
            super.itemRenderer = _arg_1;
            purgeMeasuringRenderers();
        }

        mx_internal function setupRendererFromData(_arg_1:IListItemRenderer, _arg_2:Object):void
        {
            var _local_3:Object = ((_arg_2 is ItemWrapper) ? _arg_2.data : _arg_2);
            if ((_arg_1 is IDropInListItemRenderer))
            {
                if (_local_3 != null)
                {
                    IDropInListItemRenderer(_arg_1).listData = makeListData(_local_3, itemToUID(_arg_2), 0);
                }
                else
                {
                    IDropInListItemRenderer(_arg_1).listData = null;
                };
            };
            _arg_1.data = _local_3;
            if ((_arg_1 is IInvalidating))
            {
                IInvalidating(_arg_1).invalidateSize();
            };
            UIComponentGlobals.layoutManager.validateClient(_arg_1, true);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            setRowCount(listItems.length);
            if (((bEditedItemPositionChanged) && (!(editingTemporarilyPrevented(_proposedEditedItemPosition)))))
            {
                bEditedItemPositionChanged = false;
                commitEditedItemPosition(_proposedEditedItemPosition);
                _proposedEditedItemPosition = undefined;
            };
            drawRowBackgrounds();
        }

        public function destroyItemEditor():void
        {
            var _local_1:ListEvent;
            if (itemEditorInstance)
            {
                DisplayObject(itemEditorInstance).removeEventListener(KeyboardEvent.KEY_DOWN, editorKeyDownHandler);
                systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_DOWN, editorMouseDownHandler, true);
                systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, editorMouseDownHandler);
                _local_1 = new ListEvent(ListEvent.ITEM_FOCUS_OUT);
                _local_1.rowIndex = _editedItemPosition.rowIndex;
                _local_1.itemRenderer = editedItemRenderer;
                dispatchEvent(_local_1);
                if (!rendererIsEditor)
                {
                    if (((itemEditorInstance) && (itemEditorInstance is UIComponent)))
                    {
                        UIComponent(itemEditorInstance).drawFocus(false);
                    };
                    listContent.removeChild(DisplayObject(itemEditorInstance));
                };
                itemEditorInstance = null;
                _editedItemPosition = null;
            };
        }

        mx_internal function callMakeListData(_arg_1:Object, _arg_2:String, _arg_3:int):BaseListData
        {
            return (makeListData(_arg_1, _arg_2, _arg_3));
        }

        public function set lockedRowCount(_arg_1:int):void
        {
            _lockedRowCount = _arg_1;
            invalidateDisplayList();
        }


    }
}//package mx.controls

