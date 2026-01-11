// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.DataGrid

package mx.controls
{
    import mx.controls.dataGridClasses.DataGridBase;
    import mx.core.IIMESupport;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.controls.dataGridClasses.DataGridColumn;
    import flash.display.DisplayObject;
    import mx.controls.listClasses.ListBaseContentHolder;
    import mx.core.IFlexDisplayObject;
    import flash.display.Sprite;
    import mx.events.DataGridEvent;
    import mx.core.EventPriority;
    import flash.events.MouseEvent;
    import mx.core.UIComponent;
    import flash.events.KeyboardEvent;
    import mx.events.SandboxMouseEvent;
    import flash.events.Event;
    import flash.geom.Point;
    import mx.controls.dataGridClasses.DataGridListData;
    import mx.managers.IFocusManager;
    import mx.events.DataGridEventReason;
    import flash.utils.describeType;
    import mx.core.IPropertyChangeNotifier;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.managers.IFocusManagerComponent;
    import mx.collections.CursorBookmark;
    import mx.collections.errors.ItemPendingError;
    import mx.controls.dataGridClasses.DataGridHeader;
    import mx.core.IUIComponent;
    import flash.events.FocusEvent;
    import mx.collections.ICollectionView;
    import mx.collections.Sort;
    import mx.collections.SortField;
    import mx.styles.ISimpleStyleClient;
    import mx.core.ScrollPolicy;
    import mx.controls.listClasses.ListBaseSeekPending;
    import mx.collections.ItemResponder;
    import mx.utils.ObjectUtil;
    import mx.controls.scrollClasses.ScrollBar;
    import mx.skins.halo.ListDropIndicator;
    import mx.events.DragEvent;
    import mx.core.IInvalidating;
    import flash.ui.Keyboard;
    import mx.controls.listClasses.ListRowInfo;
    import mx.core.IFactory;
    import flash.utils.Dictionary;
    import mx.core.EdgeMetrics;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.controls.dataGridClasses.DataGridDragProxy;
    import mx.core.FlexVersion;
    import mx.core.IRectangularBorder;
    import mx.core.UIComponentGlobals;
    import mx.core.FlexSprite;
    import mx.styles.StyleManager;
    import flash.display.Graphics;
    import flash.display.Shape;
    import mx.core.FlexShape;
    import mx.events.ScrollEvent;
    import mx.events.ScrollEventDetail;
    import mx.events.ListEvent;
    import flash.display.DisplayObjectContainer;
    import mx.core.IFlexModuleFactory;
    import mx.utils.StringUtil;
    import mx.core.ContextualClassFactory;
    import mx.controls.dataGridClasses.DataGridItemRenderer;
    import mx.events.IndexChangedEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGrid extends DataGridBase implements IIMESupport 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var createAccessibilityImplementation:Function;

        private var lastItemDown:IListItemRenderer;
        public var itemEditorInstance:IListItemRenderer;
        private var displayableColumns:Array;
        private var displayWidth:Number;
        mx_internal var resizingColumn:DataGridColumn;
        private var dontEdit:Boolean = false;
        mx_internal var movingColumn:DataGridColumn;
        private var generatedColumns:Boolean = true;
        private var lastEditedItemPosition:*;
        private var _headerWordWrapPresent:Boolean = false;
        public var editable:Boolean = false;
        private var losingFocus:Boolean = false;
        private var lastItemFocused:DisplayObject;
        private var _originalHeaderHeight:Number = 0;
        private var _minColumnWidth:Number;
        mx_internal var sortDirection:String;
        private var manualSort:Boolean;
        private var bEditedItemPositionChanged:Boolean = false;
        private var sortColumn:DataGridColumn;
        private var actualContentHolder:ListBaseContentHolder;
        private var _columns:Array;
        private var inEndEdit:Boolean = false;
        private var lockedColumnWidth:Number = 0;
        public var resizableColumns:Boolean = true;
        private var _originalExplicitHeaderHeight:Boolean = false;
        private var minColumnWidthInvalid:Boolean = false;
        private var _editedItemPosition:Object;
        private var _imeMode:String = null;
        private var actualRowIndex:int;
        private var _proposedEditedItemPosition:*;
        private var itemEditorPositionChanged:Boolean = false;
        mx_internal var sortIndex:int = -1;
        private var skipHeaderUpdate:Boolean = false;
        mx_internal var lastSortIndex:int = -1;
        private var actualColIndex:int;
        mx_internal var lockedColumnDropIndicator:IFlexDisplayObject;
        public var sortableColumns:Boolean = true;
        private var collectionUpdatesDisabled:Boolean = false;
        private var _draggableColumns:Boolean = true;
        private var _focusPane:Sprite;

        public function DataGrid()
        {
            _columns = [];
            setRowHeight(20);
            addEventListener(DataGridEvent.ITEM_EDIT_BEGINNING, itemEditorItemEditBeginningHandler, false, EventPriority.DEFAULT_HANDLER);
            addEventListener(DataGridEvent.ITEM_EDIT_BEGIN, itemEditorItemEditBeginHandler, false, EventPriority.DEFAULT_HANDLER);
            addEventListener(DataGridEvent.ITEM_EDIT_END, itemEditorItemEditEndHandler, false, EventPriority.DEFAULT_HANDLER);
            addEventListener(DataGridEvent.HEADER_RELEASE, headerReleaseHandler, false, EventPriority.DEFAULT_HANDLER);
            addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        }

        mx_internal function _drawHeaderBackground(_arg_1:UIComponent):void
        {
            drawHeaderBackground(_arg_1);
        }

        override public function measureWidthOfItems(_arg_1:int=-1, _arg_2:int=0):Number
        {
            var _local_3:Number = 0;
            var _local_4:int = ((columns) ? columns.length : 0);
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                if (columns[_local_5].visible)
                {
                    _local_3 = (_local_3 + columns[_local_5].width);
                };
                _local_5++;
            };
            return (_local_3);
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

        public function destroyItemEditor():void
        {
            var _local_1:DataGridEvent;
            if (itemEditorInstance)
            {
                DisplayObject(itemEditorInstance).removeEventListener(KeyboardEvent.KEY_DOWN, editorKeyDownHandler);
                systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_DOWN, editorMouseDownHandler, true);
                systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, editorMouseDownHandler);
                systemManager.removeEventListener(Event.RESIZE, editorStageResizeHandler, true);
                _local_1 = new DataGridEvent(DataGridEvent.ITEM_FOCUS_OUT);
                _local_1.columnIndex = _editedItemPosition.columnIndex;
                _local_1.rowIndex = _editedItemPosition.rowIndex;
                _local_1.itemRenderer = itemEditorInstance;
                dispatchEvent(_local_1);
                if (!_columns[_editedItemPosition.columnIndex].rendererIsEditor)
                {
                    if (((itemEditorInstance) && (itemEditorInstance is UIComponent)))
                    {
                        UIComponent(itemEditorInstance).drawFocus(false);
                    };
                    actualContentHolder.removeChild(DisplayObject(itemEditorInstance));
                    editedItemRenderer.visible = true;
                };
                itemEditorInstance = null;
                _editedItemPosition = null;
            };
        }

        override protected function mouseUpHandler(_arg_1:MouseEvent):void
        {
            var _local_2:DataGridEvent;
            var _local_3:IListItemRenderer;
            var _local_4:Sprite;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Point;
            _local_3 = mouseEventToItemRenderer(_arg_1);
            super.mouseUpHandler(_arg_1);
            if ((((_local_3) && (!(_local_3 == itemEditorInstance))) && ((lastItemDown == _local_3) || (itemRendererContains(lastItemDown, lastItemFocused)))))
            {
                if (lastItemDown != _local_3)
                {
                    _local_3 = lastItemDown;
                };
                lastItemFocused = null;
                _local_7 = itemRendererToIndices(_local_3);
                if (((((_local_7) && (_local_7.y >= 0)) && (editable)) && (!(dontEdit))))
                {
                    if (displayableColumns[_local_7.x].editable)
                    {
                        beginningEdit(displayableColumns[_local_7.x].colNum, _local_7.y, _local_3);
                    }
                    else
                    {
                        lastEditedItemPosition = {
                            "columnIndex":displayableColumns[_local_7.x].colNum,
                            "rowIndex":_local_7.y
                        };
                    };
                };
            }
            else
            {
                if (((lastItemDown) && (!(lastItemDown == itemEditorInstance))))
                {
                    _local_7 = itemRendererToIndices(lastItemDown);
                    if (((((_local_7) && (_local_7.y >= 0)) && (editable)) && (!(dontEdit))))
                    {
                        if (displayableColumns[_local_7.x].editable)
                        {
                            beginningEdit(displayableColumns[_local_7.x].colNum, _local_7.y, lastItemDown);
                        }
                        else
                        {
                            lastEditedItemPosition = {
                                "columnIndex":displayableColumns[_local_7.x].colNum,
                                "rowIndex":_local_7.y
                            };
                        };
                    };
                };
            };
            lastItemDown = null;
        }

        private function itemEditorItemEditEndHandler(_arg_1:DataGridEvent):void
        {
            var _local_2:Boolean;
            var _local_3:Object;
            var _local_4:String;
            var _local_5:Object;
            var _local_6:String;
            var _local_7:XML;
            var _local_8:DataGridListData;
            var _local_9:IFocusManager;
            if (!_arg_1.isDefaultPrevented())
            {
                _local_2 = false;
                if (_arg_1.reason == DataGridEventReason.NEW_COLUMN)
                {
                    if (!collectionUpdatesDisabled)
                    {
                        collection.disableAutoUpdate();
                        collectionUpdatesDisabled = true;
                    };
                }
                else
                {
                    if (collectionUpdatesDisabled)
                    {
                        collection.enableAutoUpdate();
                        collectionUpdatesDisabled = false;
                    };
                };
                if (((itemEditorInstance) && (!(_arg_1.reason == DataGridEventReason.CANCELLED))))
                {
                    _local_3 = itemEditorInstance[_columns[_arg_1.columnIndex].editorDataField];
                    _local_4 = _columns[_arg_1.columnIndex].dataField;
                    _local_5 = _arg_1.itemRenderer.data;
                    _local_6 = "";
                    for each (_local_7 in describeType(_local_5).variable)
                    {
                        if (_local_4 == _local_7.@name.toString())
                        {
                            _local_6 = _local_7.@type.toString();
                            break;
                        };
                    };
                    if (_local_6 == "String")
                    {
                        if (!(_local_3 is String))
                        {
                            _local_3 = _local_3.toString();
                        };
                    }
                    else
                    {
                        if (_local_6 == "uint")
                        {
                            if (!(_local_3 is uint))
                            {
                                _local_3 = uint(_local_3);
                            };
                        }
                        else
                        {
                            if (_local_6 == "int")
                            {
                                if (!(_local_3 is int))
                                {
                                    _local_3 = int(_local_3);
                                };
                            }
                            else
                            {
                                if (_local_6 == "Number")
                                {
                                    if (!(_local_3 is int))
                                    {
                                        _local_3 = Number(_local_3);
                                    };
                                };
                            };
                        };
                    };
                    if (((!(_local_4 == null)) && (!(getCurrentDataValue(_local_5, _local_4) === _local_3))))
                    {
                        _local_2 = setNewValue(_local_5, _local_4, _local_3, _arg_1.columnIndex);
                    };
                    if (((_local_2) && (!((_local_5 is IPropertyChangeNotifier) || (_local_5 is XML)))))
                    {
                        collection.itemUpdated(_local_5, _local_4);
                    };
                    if ((_arg_1.itemRenderer is IDropInListItemRenderer))
                    {
                        _local_8 = DataGridListData(IDropInListItemRenderer(_arg_1.itemRenderer).listData);
                        _local_8.label = _columns[_arg_1.columnIndex].itemToLabel(_local_5);
                        IDropInListItemRenderer(_arg_1.itemRenderer).listData = _local_8;
                    };
                    _arg_1.itemRenderer.data = _local_5;
                };
            }
            else
            {
                if (_arg_1.reason != DataGridEventReason.OTHER)
                {
                    if (((itemEditorInstance) && (_editedItemPosition)))
                    {
                        if (selectedIndex != _editedItemPosition.rowIndex)
                        {
                            selectedIndex = _editedItemPosition.rowIndex;
                        };
                        _local_9 = focusManager;
                        if ((itemEditorInstance is IFocusManagerComponent))
                        {
                            _local_9.setFocus(IFocusManagerComponent(itemEditorInstance));
                        };
                    };
                };
            };
            if (((_arg_1.reason == DataGridEventReason.OTHER) || (!(_arg_1.isDefaultPrevented()))))
            {
                destroyItemEditor();
            };
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
        }

        mx_internal function measureHeightOfItemsUptoMaxHeight(index:int=-1, count:int=0, maxHeight:Number=-1):Number
        {
            var item:IListItemRenderer;
            var c:DataGridColumn;
            var n:int;
            var j:int;
            var data:Object;
            if (!columns.length)
            {
                return (rowHeight * count);
            };
            var h:Number = 0;
            var ch:Number = 0;
            var paddingTop:Number = getStyle("paddingTop");
            var paddingBottom:Number = getStyle("paddingBottom");
            var lockedCount:int = lockedRowCount;
            if ((((headerVisible) && (count > 0)) && (index == -1)))
            {
                h = calculateHeaderHeight();
                if (((!(maxHeight == -1)) && (h > maxHeight)))
                {
                    setRowCount(0);
                    return (0);
                };
                count = (count - 1);
                index = 0;
            };
            var bookmark:CursorBookmark = ((iterator) ? iterator.bookmark : null);
            var bMore:Boolean = (!(iterator == null));
            if (((!(index == -1)) && (iterator)))
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, index);
                }
                catch(e:ItemPendingError)
                {
                    bMore = false;
                };
            };
            if (lockedCount > 0)
            {
                try
                {
                    collectionIterator.seek(CursorBookmark.FIRST, 0);
                }
                catch(e:ItemPendingError)
                {
                    bMore = false;
                };
            };
            var i:int;
            while (i < count)
            {
                if (bMore)
                {
                    data = ((lockedCount > 0) ? collectionIterator.current : iterator.current);
                    ch = 0;
                    n = columns.length;
                    j = 0;
                    while (j < n)
                    {
                        c = columns[j];
                        if (c.visible)
                        {
                            item = c.getMeasuringRenderer(false, data);
                            if (DisplayObject(item).parent == null)
                            {
                                listContent.addChild(DisplayObject(item));
                            };
                            setupRendererFromData(c, item, data);
                            ch = Math.max(ch, ((variableRowHeight) ? ((item.getExplicitOrMeasuredHeight() + paddingBottom) + paddingTop) : rowHeight));
                        };
                        j = (j + 1);
                    };
                };
                if (((!(maxHeight == -1)) && (((h + ch) > maxHeight) || (!(bMore)))))
                {
                    try
                    {
                        if (iterator)
                        {
                            iterator.seek(bookmark, 0);
                        };
                    }
                    catch(e:ItemPendingError)
                    {
                    };
                    count = ((headerVisible) ? (i + 1) : i);
                    setRowCount(count);
                    return (h);
                };
                h = (h + ch);
                if (iterator)
                {
                    try
                    {
                        bMore = iterator.moveNext();
                        if (lockedCount > 0)
                        {
                            collectionIterator.moveNext();
                            lockedCount = (lockedCount - 1);
                        };
                    }
                    catch(e:ItemPendingError)
                    {
                        bMore = false;
                    };
                };
                i = (i + 1);
            };
            if (iterator)
            {
                try
                {
                    iterator.seek(bookmark, 0);
                }
                catch(e:ItemPendingError)
                {
                };
            };
            return (h);
        }

        mx_internal function get sortArrow():IFlexDisplayObject
        {
            return (DataGridHeader(header).sortArrow);
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            var _local_2:DisplayObject;
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
                _local_2 = DisplayObject(_arg_1.relatedObject);
                while (((_local_2) && (!(_local_2 == this))))
                {
                    if ((((_local_2 is IListItemRenderer) && (_local_2.parent.parent == this)) && (_local_2.parent is ListBaseContentHolder)))
                    {
                        if (_local_2.visible)
                        {
                            return;
                        };
                    };
                    if ((_local_2 is IUIComponent))
                    {
                        _local_2 = IUIComponent(_local_2).owner;
                    }
                    else
                    {
                        _local_2 = _local_2.parent;
                    };
                };
                endEdit(DataGridEventReason.OTHER);
                removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
                removeEventListener(MouseEvent.MOUSE_DOWN, mouseFocusChangeHandler);
            };
        }

        private function itemEditorItemEditBeginningHandler(_arg_1:DataGridEvent):void
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

        override protected function createChildren():void
        {
            super.createChildren();
            if (!header)
            {
                header = new headerClass();
                header.styleName = this;
                addChild(header);
            };
        }

        mx_internal function _clearSeparators():void
        {
            clearSeparators();
        }

        public function set draggableColumns(_arg_1:Boolean):void
        {
            _draggableColumns = _arg_1;
        }

        private function updateSortIndexAndDirection():void
        {
            if (!sortableColumns)
            {
                lastSortIndex = sortIndex;
                sortIndex = -1;
                if (lastSortIndex != sortIndex)
                {
                    invalidateDisplayList();
                };
                return;
            };
            if (!dataProvider)
            {
                return;
            };
            var _local_1:ICollectionView = ICollectionView(dataProvider);
            var _local_2:Sort = _local_1.sort;
            if (!_local_2)
            {
                sortIndex = (lastSortIndex = -1);
                return;
            };
            var _local_3:Array = _local_2.fields;
            if (!_local_3)
            {
                return;
            };
            if (_local_3.length != 1)
            {
                lastSortIndex = sortIndex;
                sortIndex = -1;
                if (lastSortIndex != sortIndex)
                {
                    invalidateDisplayList();
                };
                return;
            };
            var _local_4:SortField = _local_3[0];
            var _local_5:int = _columns.length;
            sortIndex = -1;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                if (_columns[_local_6].dataField == _local_4.name)
                {
                    sortIndex = ((_columns[_local_6].sortable) ? _local_6 : -1);
                    sortDirection = ((_local_4.descending) ? "DESC" : "ASC");
                    return;
                };
                _local_6++;
            };
        }

        protected function isComplexColumn(_arg_1:String):Boolean
        {
            return (!(_arg_1.indexOf(".") == -1));
        }

        [Bindable("itemFocusIn")]
        public function get editedItemPosition():Object
        {
            if (_editedItemPosition)
            {
                return ({
                    "rowIndex":_editedItemPosition.rowIndex,
                    "columnIndex":_editedItemPosition.columnIndex
                });
            };
            return (_editedItemPosition);
        }

        private function drawVerticalSeparator(_arg_1:Sprite, _arg_2:int, _arg_3:uint, _arg_4:Number, _arg_5:Boolean=false):void
        {
            var _local_10:IFlexDisplayObject;
            var _local_11:IFlexDisplayObject;
            var _local_12:IFlexDisplayObject;
            var _local_13:IFlexDisplayObject;
            var _local_14:Class;
            var _local_15:ISimpleStyleClient;
            var _local_16:Number;
            var _local_6:String = ("vSeparator" + _arg_2);
            var _local_7:String = ("vLockedSeparator" + _arg_2);
            var _local_8:String = ((_arg_5) ? _local_7 : _local_6);
            var _local_9:String = ((_arg_5) ? "verticalLockedSeparatorSkin" : "verticalSeparatorSkin");
            _local_10 = IFlexDisplayObject(_arg_1.getChildByName(_local_6));
            _local_11 = IFlexDisplayObject(_arg_1.getChildByName(_local_7));
            _local_13 = ((_arg_5) ? _local_11 : _local_10);
            _local_12 = ((_arg_5) ? _local_10 : _local_11);
            if (_local_12)
            {
                _arg_1.removeChild(DisplayObject(_local_12));
            };
            if (!_local_13)
            {
                _local_14 = Class(getStyle(_local_9));
                if (_local_14)
                {
                    _local_13 = IFlexDisplayObject(new (_local_14)());
                    _local_13.name = _local_8;
                    _local_15 = (_local_13 as ISimpleStyleClient);
                    if (_local_15)
                    {
                        _local_15.styleName = this;
                    };
                    _arg_1.addChild(DisplayObject(_local_13));
                };
            };
            if (_local_13)
            {
                _local_16 = ((isNaN(_local_13.measuredWidth)) ? 1 : _local_13.measuredWidth);
                _local_13.setActualSize(_local_16, _arg_1.parent.parent.height);
                _local_13.move((_arg_4 - Math.round((_local_16 / 2))), 0);
            }
            else
            {
                drawVerticalLine(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        override public function set headerHeight(_arg_1:Number):void
        {
            super.headerHeight = _arg_1;
            _originalHeaderHeight = ((isNaN(_arg_1)) ? 22 : _arg_1);
            _originalExplicitHeaderHeight = (!(isNaN(_arg_1)));
        }

        private function headerReleaseHandler(_arg_1:DataGridEvent):void
        {
            if (!_arg_1.isDefaultPrevented())
            {
                manualSort = true;
                sortByColumn(_arg_1.columnIndex);
                manualSort = false;
            };
        }

        override mx_internal function resizeColumn(_arg_1:int, _arg_2:Number):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:DataGridColumn;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            if ((((!(visibleColumns)) || (visibleColumns.length == 0)) && ((!(visibleLockedColumns)) || (visibleLockedColumns.length == 0))))
            {
                _columns[_arg_1].setWidth(_arg_2);
                _columns[_arg_1].preferredWidth = _arg_2;
                return;
            };
            if (_arg_2 < _columns[_arg_1].minWidth)
            {
                _arg_2 = _columns[_arg_1].minWidth;
            };
            if (((_horizontalScrollPolicy == ScrollPolicy.ON) || (_horizontalScrollPolicy == ScrollPolicy.AUTO)))
            {
                _columns[_arg_1].setWidth(_arg_2);
                _columns[_arg_1].explicitWidth = _arg_2;
                _columns[_arg_1].preferredWidth = _arg_2;
                columnsInvalid = true;
            }
            else
            {
                _local_3 = _columns.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    if (_arg_1 == _columns[_local_4].colNum) break;
                    _local_4++;
                };
                if (_local_4 >= (_columns.length - 1))
                {
                    return;
                };
                _arg_1 = _local_4;
                _local_5 = 0;
                _local_4 = (_arg_1 + 1);
                while (_local_4 < _local_3)
                {
                    if (_columns[_local_4].visible)
                    {
                        if (_columns[_local_4].resizable)
                        {
                            _local_5 = (_local_5 + _columns[_local_4].width);
                        };
                    };
                    _local_4++;
                };
                _local_8 = ((_columns[_arg_1].width - _arg_2) + _local_5);
                if (_local_5)
                {
                    _columns[_arg_1].setWidth(_arg_2);
                    _columns[_arg_1].explicitWidth = _arg_2;
                };
                _local_9 = 0;
                _local_4 = (_arg_1 + 1);
                while (_local_4 < _local_3)
                {
                    if (_columns[_local_4].visible)
                    {
                        if (_columns[_local_4].resizable)
                        {
                            _local_7 = Math.floor(((_columns[_local_4].width * _local_8) / _local_5));
                            if (_local_7 < _columns[_local_4].minWidth)
                            {
                                _local_7 = _columns[_local_4].minWidth;
                            };
                            _columns[_local_4].setWidth(_local_7);
                            _local_9 = (_local_9 + _columns[_local_4].width);
                            _local_6 = _columns[_local_4];
                        };
                    };
                    _local_4++;
                };
                if (_local_9 > _local_8)
                {
                    _local_7 = ((_columns[_arg_1].width - _local_9) + _local_8);
                    if (_local_7 < _columns[_arg_1].minWidth)
                    {
                        _local_7 = _columns[_arg_1].minWidth;
                    };
                    _columns[_arg_1].setWidth(_local_7);
                }
                else
                {
                    if (_local_6)
                    {
                        _local_6.setWidth(((_local_6.width - _local_9) + _local_8));
                    };
                };
            };
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        private function generateCols():void
        {
            var col:DataGridColumn;
            var newCols:Array;
            var cols:Array;
            var info:Object;
            var itmObj:Object;
            var p:String;
            var n:int;
            var colName:Object;
            var i:int;
            if (collection.length > 0)
            {
                newCols = [];
                if (dataProvider)
                {
                    try
                    {
                        iterator.seek(CursorBookmark.FIRST);
                        if (!iteratorValid)
                        {
                            iteratorValid = true;
                            lastSeekPending = null;
                        };
                    }
                    catch(e:ItemPendingError)
                    {
                        lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, 0);
                        e.addResponder(new ItemResponder(generateColumnsPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                        iteratorValid = false;
                        return;
                    };
                    info = ObjectUtil.getClassInfo(iterator.current, ["uid", "mx_internal_uid"]);
                    if (info)
                    {
                        cols = info.properties;
                    };
                };
                if (!cols)
                {
                    itmObj = iterator.current;
                    for (p in itmObj)
                    {
                        if (p != "uid")
                        {
                            col = new DataGridColumn();
                            col.dataField = p;
                            newCols.push(col);
                        };
                    };
                }
                else
                {
                    n = cols.length;
                    i = 0;
                    while (i < n)
                    {
                        colName = cols[i];
                        if ((colName is QName))
                        {
                            colName = QName(colName).localName;
                        };
                        col = new DataGridColumn();
                        col.dataField = String(colName);
                        newCols.push(col);
                        i = (i + 1);
                    };
                };
                columns = newCols;
                generatedColumns = true;
            };
        }

        override protected function drawRowBackgrounds():void
        {
            drawRowGraphics(listContent);
        }

        mx_internal function get vScrollBar():ScrollBar
        {
            return (verticalScrollBar);
        }

        override public function showDropFeedback(_arg_1:DragEvent):void
        {
            var _local_2:Class;
            super.showDropFeedback(_arg_1);
            if (lockedColumnCount > 0)
            {
                if (!lockedColumnDropIndicator)
                {
                    _local_2 = getStyle("dropIndicatorSkin");
                    if (!_local_2)
                    {
                        _local_2 = ListDropIndicator;
                    };
                    lockedColumnDropIndicator = IFlexDisplayObject(new (_local_2)());
                    lockedColumnDropIndicator.x = 2;
                    lockedColumnDropIndicator.setActualSize((lockedColumnContent.width - 2), 4);
                    lockedColumnDropIndicator.visible = true;
                };
                if (dropIndicator.parent == listContent)
                {
                    lockedColumnContent.addChild(DisplayObject(lockedColumnDropIndicator));
                }
                else
                {
                    lockedColumnAndRowContent.addChild(DisplayObject(lockedColumnDropIndicator));
                };
                lockedColumnDropIndicator.y = dropIndicator.y;
            };
        }

        override protected function scrollPositionToIndex(_arg_1:int, _arg_2:int):int
        {
            return ((iterator) ? (_arg_2 + lockedRowCount) : -1);
        }

        protected function setNewValue(_arg_1:Object, _arg_2:String, _arg_3:Object, _arg_4:int):Boolean
        {
            var _local_5:Array;
            var _local_6:String;
            var _local_7:Object;
            if (!isComplexColumn(_arg_2))
            {
                _arg_1[_arg_2] = _arg_3;
            }
            else
            {
                _local_5 = _arg_2.split(".");
                _local_6 = _local_5.pop();
                _local_7 = deriveComplexFieldReference(_arg_1, _local_5);
                _local_7[_local_6] = _arg_3;
            };
            return (true);
        }

        private function drawHorizontalSeparator(_arg_1:Sprite, _arg_2:int, _arg_3:uint, _arg_4:Number, _arg_5:Boolean=false):void
        {
            var _local_10:IFlexDisplayObject;
            var _local_11:IFlexDisplayObject;
            var _local_12:IFlexDisplayObject;
            var _local_13:IFlexDisplayObject;
            var _local_14:Class;
            var _local_15:ISimpleStyleClient;
            var _local_16:Number;
            var _local_6:String = ("hSeparator" + _arg_2);
            var _local_7:String = ("hLockedSeparator" + _arg_2);
            var _local_8:String = ((_arg_5) ? _local_7 : _local_6);
            var _local_9:String = ((_arg_5) ? "horizontalLockedSeparatorSkin" : "horizontalSeparatorSkin");
            _local_10 = IFlexDisplayObject(_arg_1.getChildByName(_local_6));
            _local_11 = IFlexDisplayObject(_arg_1.getChildByName(_local_7));
            _local_13 = ((_arg_5) ? _local_11 : _local_10);
            _local_12 = ((_arg_5) ? _local_10 : _local_11);
            if (_local_12)
            {
                _arg_1.removeChild(DisplayObject(_local_12));
            };
            if (!_local_13)
            {
                _local_14 = Class(getStyle(_local_9));
                if (_local_14)
                {
                    _local_13 = IFlexDisplayObject(new (_local_14)());
                    _local_13.name = _local_8;
                    _local_15 = (_local_13 as ISimpleStyleClient);
                    if (_local_15)
                    {
                        _local_15.styleName = this;
                    };
                    _arg_1.addChild(DisplayObject(_local_13));
                };
            };
            if (_local_13)
            {
                _local_16 = ((isNaN(_local_13.measuredHeight)) ? 1 : _local_13.measuredHeight);
                _local_13.setActualSize((displayWidth - lockedColumnWidth), _local_16);
                _local_13.move(0, _arg_4);
            }
            else
            {
                drawHorizontalLine(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        private function itemEditorItemEditBeginHandler(_arg_1:DataGridEvent):void
        {
            var _local_2:IFocusManager;
            if (root)
            {
                systemManager.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
            };
            if (((!(_arg_1.isDefaultPrevented())) && (!(actualContentHolder.listItems[actualRowIndex][actualColIndex].data == null))))
            {
                createItemEditor(_arg_1.columnIndex, _arg_1.rowIndex);
                if (((editedItemRenderer is IDropInListItemRenderer) && (itemEditorInstance is IDropInListItemRenderer)))
                {
                    IDropInListItemRenderer(itemEditorInstance).listData = IDropInListItemRenderer(editedItemRenderer).listData;
                };
                if (!columns[_arg_1.columnIndex].rendererIsEditor)
                {
                    itemEditorInstance.data = editedItemRenderer.data;
                };
                if ((itemEditorInstance is IInvalidating))
                {
                    IInvalidating(itemEditorInstance).validateNow();
                };
                if ((itemEditorInstance is IIMESupport))
                {
                    IIMESupport(itemEditorInstance).imeMode = ((columns[_arg_1.columnIndex].imeMode == null) ? _imeMode : columns[_arg_1.columnIndex].imeMode);
                };
                _local_2 = focusManager;
                if ((itemEditorInstance is IFocusManagerComponent))
                {
                    _local_2.setFocus(IFocusManagerComponent(itemEditorInstance));
                };
                _local_2.defaultButtonEnabled = false;
                _arg_1 = new DataGridEvent(DataGridEvent.ITEM_FOCUS_IN);
                _arg_1.columnIndex = _editedItemPosition.columnIndex;
                _arg_1.rowIndex = _editedItemPosition.rowIndex;
                _arg_1.itemRenderer = itemEditorInstance;
                dispatchEvent(_arg_1);
            };
        }

        private function setEditedItemPosition(_arg_1:Object):void
        {
            bEditedItemPositionChanged = true;
            _proposedEditedItemPosition = _arg_1;
            invalidateDisplayList();
        }

        private function keyFocusChangeHandler(_arg_1:FocusEvent):void
        {
            if ((((_arg_1.keyCode == Keyboard.TAB) && (!(_arg_1.isDefaultPrevented()))) && (findNextItemRenderer(_arg_1.shiftKey))))
            {
                _arg_1.preventDefault();
            };
        }

        override public function set horizontalScrollPolicy(_arg_1:String):void
        {
            super.horizontalScrollPolicy = _arg_1;
            columnsInvalid = true;
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        public function set editedItemPosition(_arg_1:Object):void
        {
            if (!_arg_1)
            {
                setEditedItemPosition(null);
                return;
            };
            var _local_2:Object = {
                "rowIndex":_arg_1.rowIndex,
                "columnIndex":_arg_1.columnIndex
            };
            setEditedItemPosition(_local_2);
        }

        override public function measureHeightOfItems(_arg_1:int=-1, _arg_2:int=0):Number
        {
            return (measureHeightOfItemsUptoMaxHeight(_arg_1, _arg_2));
        }

        override protected function makeRowsAndColumns(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:int, _arg_6:int, _arg_7:Boolean=false, _arg_8:uint=0):Point
        {
            var _local_10:DataGridColumn;
            var _local_11:IListItemRenderer;
            var _local_12:ListRowInfo;
            var _local_13:Sprite;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            allowItemSizeChangeNotification = false;
            var _local_9:Point = super.makeRowsAndColumns(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
            if (itemEditorInstance)
            {
                actualContentHolder.setChildIndex(DisplayObject(itemEditorInstance), (actualContentHolder.numChildren - 1));
                if (((lockedColumnCount) && (editedItemPosition.columnIndex <= visibleLockedColumns[(lockedColumnCount - 1)].colNum)))
                {
                    _local_10 = visibleLockedColumns[actualColIndex];
                }
                else
                {
                    _local_10 = visibleColumns[actualColIndex];
                };
                _local_11 = actualContentHolder.listItems[actualRowIndex][actualColIndex];
                _local_12 = actualContentHolder.rowInfo[actualRowIndex];
                if (((_local_11) && (!(_local_10.rendererIsEditor))))
                {
                    _local_14 = _local_10.editorXOffset;
                    _local_15 = _local_10.editorYOffset;
                    _local_16 = _local_10.editorWidthOffset;
                    _local_17 = _local_10.editorHeightOffset;
                    itemEditorInstance.move((_local_11.x + _local_14), (_local_12.y + _local_15));
                    itemEditorInstance.setActualSize(Math.min((_local_10.width + _local_16), (actualContentHolder.width - itemEditorInstance.x)), Math.min((_local_12.height + _local_17), (actualContentHolder.height - itemEditorInstance.y)));
                    _local_11.visible = false;
                };
                _local_13 = Sprite(actualContentHolder.getChildByName("lines"));
                if (_local_13)
                {
                    actualContentHolder.setChildIndex(_local_13, (actualContentHolder.numChildren - 1));
                };
            };
            allowItemSizeChangeNotification = variableRowHeight;
            return (_local_9);
        }

        private function scrollToEditedItem(_arg_1:int, _arg_2:int):void
        {
            var _local_8:int;
            actualContentHolder = listContent;
            var _local_3:Array = actualContentHolder.listItems;
            var _local_4:int = (((verticalScrollPosition + _local_3.length) - 1) + lockedRowCount);
            var _local_5:int = (((rowInfo[(_local_3.length - 1)].y + rowInfo[(_local_3.length - 1)].height) > listContent.height) ? 1 : 0);
            if (_arg_1 > lockedRowCount)
            {
                if (_arg_1 < (verticalScrollPosition + lockedRowCount))
                {
                    verticalScrollPosition = (_arg_1 - lockedRowCount);
                }
                else
                {
                    while (((_arg_1 > _local_4) || (((_arg_1 == _local_4) && (_arg_1 > (verticalScrollPosition + lockedRowCount))) && (_local_5))))
                    {
                        if (verticalScrollPosition == maxVerticalScrollPosition) break;
                        verticalScrollPosition = Math.min((verticalScrollPosition + ((_arg_1 > _local_4) ? (_arg_1 - _local_4) : _local_5)), maxVerticalScrollPosition);
                        _local_4 = (((verticalScrollPosition + _local_3.length) - 1) + lockedRowCount);
                        _local_5 = (((rowInfo[(_local_3.length - 1)].y + rowInfo[(_local_3.length - 1)].height) > listContent.height) ? 1 : 0);
                    };
                };
                actualRowIndex = ((_arg_1 - verticalScrollPosition) - lockedRowCount);
            }
            else
            {
                if (_arg_1 == lockedRowCount)
                {
                    verticalScrollPosition = 0;
                    actualRowIndex = (_arg_1 - lockedRowCount);
                }
                else
                {
                    if (lockedRowCount)
                    {
                        actualContentHolder = lockedRowContent;
                    };
                    actualRowIndex = _arg_1;
                };
            };
            _local_3 = actualContentHolder.listItems;
            var _local_6:uint = (((_local_3) && (_local_3[0])) ? _local_3[0].length : visibleColumns.length);
            var _local_7:int = (((horizontalScrollPosition + _local_6) - 1) + lockedColumnCount);
            if (_arg_2 > lockedColumnCount)
            {
                _local_8 = (((_local_3[0][(_local_6 - 1)].x + _local_3[0][(_local_6 - 1)].width) > listContent.width) ? 1 : 0);
                if (_arg_2 < (horizontalScrollPosition + lockedColumnCount))
                {
                    horizontalScrollPosition = (_arg_2 - lockedColumnCount);
                }
                else
                {
                    while (((_arg_2 > _local_7) || (((_arg_2 == _local_7) && (_arg_2 > (horizontalScrollPosition + lockedColumnCount))) && (_local_8))))
                    {
                        if (horizontalScrollPosition == maxHorizontalScrollPosition) break;
                        horizontalScrollPosition = Math.min((horizontalScrollPosition + ((_arg_2 > _local_7) ? (_arg_2 - _local_7) : _local_8)), maxHorizontalScrollPosition);
                        _local_6 = (((_local_3) && (_local_3[0])) ? _local_3[0].length : visibleColumns.length);
                        _local_7 = (((horizontalScrollPosition + _local_6) - 1) + lockedColumnCount);
                        _local_8 = (((_local_3[0][(_local_6 - 1)].x + _local_3[0][(_local_6 - 1)].width) > listContent.width) ? 1 : 0);
                    };
                };
                actualColIndex = ((_arg_2 - horizontalScrollPosition) - lockedColumnCount);
            }
            else
            {
                if (_arg_2 == lockedColumnCount)
                {
                    horizontalScrollPosition = 0;
                    actualColIndex = (_arg_2 - lockedColumnCount);
                }
                else
                {
                    if (lockedColumnCount)
                    {
                        if (actualContentHolder == lockedRowContent)
                        {
                            actualContentHolder = lockedColumnAndRowContent;
                        }
                        else
                        {
                            actualContentHolder = lockedColumnContent;
                        };
                    };
                    actualColIndex = _arg_2;
                };
            };
        }

        private function sortByColumn(_arg_1:int):void
        {
            var _local_4:Sort;
            var _local_5:SortField;
            var _local_6:String;
            var _local_7:Array;
            var _local_8:int;
            var _local_2:DataGridColumn = columns[_arg_1];
            var _local_3:Boolean = _local_2.sortDescending;
            if (_local_2.sortable)
            {
                _local_4 = collection.sort;
                if (_local_4)
                {
                    _local_4.compareFunction = null;
                    _local_7 = _local_4.fields;
                    if (_local_7)
                    {
                        _local_8 = 0;
                        while (_local_8 < _local_7.length)
                        {
                            if (_local_7[_local_8].name == _local_2.dataField)
                            {
                                _local_5 = _local_7[_local_8];
                                _local_3 = (!(_local_5.descending));
                                break;
                            };
                            _local_8++;
                        };
                    };
                }
                else
                {
                    _local_4 = new Sort();
                };
                if (!_local_5)
                {
                    _local_5 = new SortField(_local_2.dataField);
                };
                _local_2.sortDescending = _local_3;
                _local_6 = ((_local_3) ? "DESC" : "ASC");
                sortDirection = _local_6;
                lastSortIndex = sortIndex;
                sortIndex = _arg_1;
                sortColumn = _local_2;
                _local_5.name = _local_2.dataField;
                if (_local_2.sortCompareFunction != null)
                {
                    _local_5.compareFunction = _local_2.sortCompareFunction;
                }
                else
                {
                    _local_5.compareFunction = null;
                };
                _local_5.descending = _local_3;
                _local_4.fields = [_local_5];
            };
            collection.sort = _local_4;
            collection.refresh();
        }

        override mx_internal function columnRendererChanged(_arg_1:DataGridColumn):void
        {
            var _local_2:DisplayObject;
            var _local_4:*;
            var _local_5:Array;
            var _local_6:IFactory;
            var _local_7:Dictionary;
            var _local_8:*;
            var _local_3:Dictionary = _arg_1.measuringObjects;
            if (_local_3)
            {
                for (_local_4 in _local_3)
                {
                    _local_6 = IFactory(_local_4);
                    _local_2 = _arg_1.measuringObjects[_local_6];
                    if (_local_2)
                    {
                        _local_2.parent.removeChild(_local_2);
                        _arg_1.measuringObjects[_local_6] = null;
                    };
                    if (((_arg_1.freeItemRenderersByFactory) && (_arg_1.freeItemRenderersByFactory[_local_6])))
                    {
                        _local_7 = _arg_1.freeItemRenderersByFactory[_local_6];
                        for (_local_8 in _local_7)
                        {
                            _local_2 = DisplayObject(_local_8);
                            _local_2.parent.removeChild(_local_2);
                        };
                        _arg_1.freeItemRenderersByFactory[_local_6] = new Dictionary(true);
                    };
                };
                _local_5 = (freeItemRenderersTable[_arg_1] as Array);
                if (_local_5)
                {
                    while (_local_5.length)
                    {
                        _local_2 = _local_5.pop();
                    };
                };
            };
            _local_2 = (_arg_1.cachedHeaderRenderer as DisplayObject);
            if (((_local_2) && (_local_2.parent)))
            {
                _local_2.parent.removeChild(_local_2);
            };
            _arg_1.cachedHeaderRenderer = null;
            rendererChanged = true;
            invalidateDisplayList();
        }

        override public function invalidateDisplayList():void
        {
            super.invalidateDisplayList();
            if (header)
            {
                header.headerItemsChanged = true;
                header.invalidateSize();
                header.invalidateDisplayList();
            };
            if (lockedColumnHeader)
            {
                lockedColumnHeader.headerItemsChanged = true;
                lockedColumnHeader.invalidateSize();
                lockedColumnHeader.invalidateDisplayList();
            };
        }

        private function findNextEnterItemRenderer(_arg_1:KeyboardEvent):void
        {
            if (_proposedEditedItemPosition !== undefined)
            {
                return;
            };
            _editedItemPosition = lastEditedItemPosition;
            if (!_editedItemPosition)
            {
                return;
            };
            var _local_2:int = _editedItemPosition.rowIndex;
            var _local_3:int = _editedItemPosition.columnIndex;
            var _local_4:int = (_editedItemPosition.rowIndex + ((_arg_1.shiftKey) ? -1 : 1));
            if (((_local_4 < collection.length) && (_local_4 >= 0)))
            {
                _local_2 = _local_4;
            };
            beginningEdit(_local_3, _local_2);
        }

        override public function set verticalScrollPosition(_arg_1:Number):void
        {
            skipHeaderUpdate = true;
            var _local_2:Number = super.verticalScrollPosition;
            super.verticalScrollPosition = _arg_1;
            if (_local_2 != _arg_1)
            {
                if (lockedColumnContent)
                {
                    drawRowGraphics(lockedColumnContent);
                };
            };
            skipHeaderUpdate = false;
        }

        override public function get columnCount():int
        {
            if (_columns)
            {
                return (_columns.length);
            };
            return (0);
        }

        protected function deriveComplexFieldReference(_arg_1:Object, _arg_2:Array):Object
        {
            var _local_4:int;
            var _local_3:Object = _arg_1;
            if (_arg_2)
            {
                _local_4 = 0;
                while (_local_4 < _arg_2.length)
                {
                    _local_3 = _local_3[_arg_2[_local_4]];
                    _local_4++;
                };
            };
            return (_local_3);
        }

        override public function calculateDropIndex(_arg_1:DragEvent=null):int
        {
            var _local_2:IListItemRenderer;
            var _local_3:IListItemRenderer;
            var _local_4:Point;
            var _local_5:int;
            var _local_6:int;
            if (_arg_1)
            {
                _local_4 = new Point(_arg_1.localX, _arg_1.localY);
                _local_4 = DisplayObject(_arg_1.target).localToGlobal(_local_4);
                _local_4 = listContent.globalToLocal(_local_4);
                _local_5 = listItems.length;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    if (listItems[_local_6][0])
                    {
                        _local_3 = listItems[_local_6][0];
                    };
                    if (((rowInfo[_local_6].y <= _local_4.y) && (_local_4.y < (rowInfo[_local_6].y + rowInfo[_local_6].height))))
                    {
                        _local_2 = listItems[_local_6][0];
                        break;
                    };
                    _local_6++;
                };
                if (((!(_local_2)) && (lockedRowContent)))
                {
                    _local_4 = listContent.localToGlobal(_local_4);
                    _local_4 = lockedRowContent.globalToLocal(_local_4);
                    _local_5 = lockedRowContent.listItems.length;
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        if (((lockedRowContent.rowInfo[_local_6].y <= _local_4.y) && (_local_4.y < (lockedRowContent.rowInfo[_local_6].y + lockedRowContent.rowInfo[_local_6].height))))
                        {
                            _local_2 = lockedRowContent.listItems[_local_6][0];
                            break;
                        };
                        _local_6++;
                    };
                };
                if (_local_2)
                {
                    lastDropIndex = itemRendererToIndex(_local_2);
                }
                else
                {
                    if (_local_3)
                    {
                        lastDropIndex = (itemRendererToIndex(_local_3) + 1);
                    }
                    else
                    {
                        lastDropIndex = ((collection) ? collection.length : 0);
                    };
                };
            };
            return (lastDropIndex);
        }

        override protected function measure():void
        {
            var _local_1:EdgeMetrics;
            super.measure();
            if (explicitRowCount != -1)
            {
                measuredHeight = (measuredHeight + headerHeight);
                measuredMinHeight = (measuredMinHeight + headerHeight);
            };
            _local_1 = viewMetrics;
            var _local_2:int = columns.length;
            if (_local_2 == 0)
            {
                measuredWidth = DEFAULT_MEASURED_WIDTH;
                measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
                return;
            };
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:int;
            while (_local_5 < _local_2)
            {
                if (columns[_local_5].visible)
                {
                    _local_3 = (_local_3 + columns[_local_5].preferredWidth);
                    if (isNaN(_minColumnWidth))
                    {
                        _local_4 = (_local_4 + columns[_local_5].minWidth);
                    };
                };
                _local_5++;
            };
            if (!isNaN(_minColumnWidth))
            {
                _local_4 = (_local_2 * _minColumnWidth);
            };
            measuredWidth = ((_local_3 + _local_1.left) + _local_1.right);
            measuredMinWidth = ((_local_4 + _local_1.left) + _local_1.right);
            if ((((verticalScrollPolicy == ScrollPolicy.AUTO) && (verticalScrollBar)) && (verticalScrollBar.visible)))
            {
                measuredWidth = (measuredWidth - verticalScrollBar.minWidth);
                measuredMinWidth = (measuredMinWidth - verticalScrollBar.minWidth);
            };
            if ((((horizontalScrollPolicy == ScrollPolicy.AUTO) && (horizontalScrollBar)) && (horizontalScrollBar.visible)))
            {
                measuredHeight = (measuredHeight - horizontalScrollBar.minHeight);
                measuredMinHeight = (measuredMinHeight - horizontalScrollBar.minHeight);
            };
        }

        private function lockedRowSeekPendingResultHandler(data:Object, info:ListBaseSeekPending):void
        {
            try
            {
                lockedRowContent.iterator.seek(CursorBookmark.FIRST);
            }
            catch(e:ItemPendingError)
            {
                e.addResponder(new ItemResponder(lockedRowSeekPendingResultHandler, seekPendingFailureHandler, null));
            };
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        override protected function mouseDownHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Sprite;
            var _local_5:Point;
            var _local_6:Boolean;
            _local_2 = mouseEventToItemRenderer(_arg_1);
            lastItemDown = null;
            var _local_4:Boolean = itemRendererContains(itemEditorInstance, DisplayObject(_arg_1.target));
            if (!_local_4)
            {
                if (_local_2)
                {
                    lastItemDown = _local_2;
                    _local_5 = itemRendererToIndices(_local_2);
                    _local_6 = true;
                    if (itemEditorInstance)
                    {
                        if (displayableColumns[_local_5.x].editable == false)
                        {
                            _local_6 = endEdit(DataGridEventReason.OTHER);
                        }
                        else
                        {
                            if (editedItemPosition)
                            {
                                _local_6 = endEdit(((editedItemPosition.rowIndex == _local_5.y) ? DataGridEventReason.NEW_COLUMN : DataGridEventReason.NEW_ROW));
                            }
                            else
                            {
                                _local_6 = false;
                            };
                        };
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
                        endEdit(DataGridEventReason.OTHER);
                    };
                };
                super.mouseDownHandler(_arg_1);
                if (_local_2)
                {
                    if (displayableColumns[_local_5.x].rendererIsEditor)
                    {
                        resetDragScrolling();
                    };
                };
            }
            else
            {
                resetDragScrolling();
            };
        }

        public function get minColumnWidth():Number
        {
            return (_minColumnWidth);
        }

        private function findNextItemRenderer(_arg_1:Boolean):Boolean
        {
            var _local_7:String;
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
            var _local_4:Boolean;
            var _local_5:int = ((_arg_1) ? -1 : 1);
            var _local_6:int = (collection.length - 1);
            while ((!(_local_4)))
            {
                _local_3 = (_local_3 + _local_5);
                if (((_local_3 >= _columns.length) || (_local_3 < 0)))
                {
                    _local_3 = ((_local_3 < 0) ? (_columns.length - 1) : 0);
                    _local_2 = (_local_2 + _local_5);
                    if (((_local_2 > _local_6) || (_local_2 < 0)))
                    {
                        if (endEdit(DataGridEventReason.NEW_ROW))
                        {
                            setEditedItemPosition(null);
                            losingFocus = true;
                            setFocus();
                            return (false);
                        };
                        return (true);
                    };
                };
                if (((_columns[_local_3].editable) && (_columns[_local_3].visible)))
                {
                    _local_4 = true;
                    _local_7 = ((_local_2 == _editedItemPosition.rowIndex) ? DataGridEventReason.NEW_COLUMN : DataGridEventReason.NEW_ROW);
                    if (((!(itemEditorInstance)) || (endEdit(_local_7))))
                    {
                        beginningEdit(_local_3, _local_2);
                    };
                };
            };
            return (_local_4);
        }

        protected function clearSeparators():void
        {
            DataGridHeader(header)._clearSeparators();
            if (lockedColumnHeader)
            {
                DataGridHeader(lockedColumnHeader)._clearSeparators();
            };
        }

        override protected function mouseEventToItemRenderer(_arg_1:MouseEvent):IListItemRenderer
        {
            var _local_2:IListItemRenderer;
            _local_2 = super.mouseEventToItemRenderer(_arg_1);
            return ((_local_2 == itemEditorInstance) ? null : _local_2);
        }

        private function deactivateHandler(_arg_1:Event):void
        {
            if (itemEditorInstance)
            {
                endEdit(DataGridEventReason.OTHER);
                losingFocus = true;
                setFocus();
            };
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            var _local_2:DataGridEvent;
            var _local_3:Boolean;
            if (losingFocus)
            {
                losingFocus = false;
                return;
            };
            if (editable)
            {
                addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
                addEventListener(MouseEvent.MOUSE_DOWN, mouseFocusChangeHandler);
            };
            if (_arg_1.target != this)
            {
                if (((itemEditorInstance) && (itemRendererContains(itemEditorInstance, DisplayObject(_arg_1.target)))))
                {
                    return;
                };
                lastItemFocused = DisplayObject(_arg_1.target);
                return;
            };
            lastItemFocused = null;
            super.focusInHandler(_arg_1);
            if (((editable) && (!(isPressed))))
            {
                _editedItemPosition = lastEditedItemPosition;
                _local_3 = false;
                if (!_editedItemPosition)
                {
                    _editedItemPosition = {
                        "rowIndex":0,
                        "columnIndex":0
                    };
                };
                while (_editedItemPosition.columnIndex != _columns.length)
                {
                    if (((_columns[_editedItemPosition.columnIndex].editable) && (_columns[_editedItemPosition.columnIndex].visible)))
                    {
                        _local_3 = true;
                        break;
                    };
                    _editedItemPosition.columnIndex++;
                };
                if (_local_3)
                {
                    beginningEdit(_editedItemPosition.columnIndex, _editedItemPosition.rowIndex);
                };
            };
        }

        override public function set dataProvider(_arg_1:Object):void
        {
            if (itemEditorInstance)
            {
                endEdit(DataGridEventReason.OTHER);
            };
            lastEditedItemPosition = null;
            super.dataProvider = _arg_1;
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (((itemEditorInstance) || (!(_arg_1.target == _arg_1.currentTarget))))
            {
                return;
            };
            if (_arg_1.keyCode != Keyboard.SPACE)
            {
                super.keyDownHandler(_arg_1);
            }
            else
            {
                if (caretIndex != -1)
                {
                    moveSelectionVertically(_arg_1.keyCode, _arg_1.shiftKey, _arg_1.ctrlKey);
                };
            };
        }

        protected function drawLinesAndColumnBackgrounds():void
        {
            drawLinesAndColumnGraphics(listContent, visibleColumns, {});
        }

        public function createItemEditor(_arg_1:int, _arg_2:int):void
        {
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:IFactory;
            if (displayableColumns.length != _columns.length)
            {
                _local_7 = 0;
                while (_local_7 < displayableColumns.length)
                {
                    if (displayableColumns[_local_7].colNum >= _arg_1)
                    {
                        _arg_1 = _local_7;
                        break;
                    };
                    _local_7++;
                };
                if (_local_7 == displayableColumns.length)
                {
                    _arg_1 = 0;
                };
            };
            var _local_3:DataGridColumn = displayableColumns[_arg_1];
            if (_arg_2 >= lockedRowCount)
            {
                _arg_2 = (_arg_2 - (verticalScrollPosition + lockedRowCount));
            };
            if (_arg_1 >= lockedColumnCount)
            {
                _arg_1 = (_arg_1 - (horizontalScrollPosition + lockedColumnCount));
            };
            var _local_4:IListItemRenderer = actualContentHolder.listItems[_arg_2][_arg_1];
            var _local_5:ListRowInfo = actualContentHolder.rowInfo[_arg_2];
            if (!_local_3.rendererIsEditor)
            {
                _local_8 = 0;
                _local_9 = -2;
                _local_10 = 0;
                _local_11 = 4;
                if (!itemEditorInstance)
                {
                    _local_12 = _local_3.itemEditor;
                    _local_8 = _local_3.editorXOffset;
                    _local_9 = _local_3.editorYOffset;
                    _local_10 = _local_3.editorWidthOffset;
                    _local_11 = _local_3.editorHeightOffset;
                    itemEditorInstance = _local_12.newInstance();
                    itemEditorInstance.owner = this;
                    itemEditorInstance.styleName = _local_3;
                    actualContentHolder.addChild(DisplayObject(itemEditorInstance));
                };
                actualContentHolder.setChildIndex(DisplayObject(itemEditorInstance), (actualContentHolder.numChildren - 1));
                itemEditorInstance.visible = true;
                itemEditorInstance.move((_local_4.x + _local_8), (_local_5.y + _local_9));
                itemEditorInstance.setActualSize(Math.min((_local_3.width + _local_10), ((actualContentHolder.width - 1) - itemEditorInstance.x)), Math.min((_local_5.height + _local_11), (actualContentHolder.height - itemEditorInstance.y)));
                DisplayObject(itemEditorInstance).addEventListener(FocusEvent.FOCUS_OUT, itemEditorFocusOutHandler);
                _local_4.visible = false;
            }
            else
            {
                itemEditorInstance = _local_4;
            };
            DisplayObject(itemEditorInstance).addEventListener(KeyboardEvent.KEY_DOWN, editorKeyDownHandler);
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_DOWN, editorMouseDownHandler, true, 0, true);
            systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, editorMouseDownHandler, false, 0, true);
            systemManager.addEventListener(Event.RESIZE, editorStageResizeHandler, true, 0, true);
            var _local_6:DataGridEvent = new DataGridEvent(DataGridEvent.ITEM_EDITOR_CREATE, false, true, _arg_1, null, _arg_2);
            dispatchEvent(_local_6);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            if (header)
            {
                header.enabled = _arg_1;
            };
            if (itemEditorInstance)
            {
                endEdit(DataGridEventReason.OTHER);
            };
            invalidateDisplayList();
        }

        override protected function collectionChangeHandler(_arg_1:Event):void
        {
            var _local_2:Object;
            var _local_3:CollectionEvent;
            var _local_4:CollectionEvent;
            if ((_arg_1 is CollectionEvent))
            {
                _local_3 = CollectionEvent(_arg_1);
                if (_local_3.kind == CollectionEventKind.RESET)
                {
                    if (itemEditorInstance)
                    {
                        endEdit(DataGridEventReason.CANCELLED);
                    };
                    setEditedItemPosition(null);
                    if (generatedColumns)
                    {
                        generateCols();
                    }
                    else
                    {
                        columnsInvalid = true;
                    };
                    updateSortIndexAndDirection();
                    if (lockedRowContent)
                    {
                        lockedRowContent.iterator = collection.createCursor();
                    };
                    if (lockedColumnAndRowContent)
                    {
                        lockedColumnAndRowContent.iterator = collection.createCursor();
                    };
                }
                else
                {
                    if (((_local_3.kind == CollectionEventKind.REFRESH) && (!(manualSort))))
                    {
                        updateSortIndexAndDirection();
                    }
                    else
                    {
                        if (_local_3.kind == CollectionEventKind.ADD)
                        {
                            if (editedItemPosition)
                            {
                                if (_local_3.location <= editedItemPosition.rowIndex)
                                {
                                    _local_2 = editedItemPosition;
                                    if (inEndEdit)
                                    {
                                        _editedItemPosition = {
                                            "columnIndex":editedItemPosition.columnIndex,
                                            "rowIndex":Math.max(0, (editedItemPosition.rowIndex + _local_3.items.length))
                                        };
                                    }
                                    else
                                    {
                                        if (itemEditorInstance)
                                        {
                                            _editedItemPosition = {
                                                "columnIndex":editedItemPosition.columnIndex,
                                                "rowIndex":Math.max(0, (editedItemPosition.rowIndex + _local_3.items.length))
                                            };
                                            itemEditorPositionChanged = true;
                                            lastEditedItemPosition = _editedItemPosition;
                                        }
                                        else
                                        {
                                            setEditedItemPosition({
                                                "columnIndex":_local_2.columnIndex,
                                                "rowIndex":Math.max(0, (_local_2.rowIndex + _local_3.items.length))
                                            });
                                        };
                                    };
                                };
                            };
                        }
                        else
                        {
                            if (_local_3.kind == CollectionEventKind.REMOVE)
                            {
                                if (editedItemPosition)
                                {
                                    if (collection.length == 0)
                                    {
                                        if (itemEditorInstance)
                                        {
                                            endEdit(DataGridEventReason.CANCELLED);
                                        };
                                        setEditedItemPosition(null);
                                    }
                                    else
                                    {
                                        if (_local_3.location <= editedItemPosition.rowIndex)
                                        {
                                            _local_2 = editedItemPosition;
                                            if (((_local_3.location == editedItemPosition.rowIndex) && (itemEditorInstance)))
                                            {
                                                endEdit(DataGridEventReason.CANCELLED);
                                            };
                                            if (inEndEdit)
                                            {
                                                _editedItemPosition = {
                                                    "columnIndex":editedItemPosition.columnIndex,
                                                    "rowIndex":Math.max(0, (editedItemPosition.rowIndex - _local_3.items.length))
                                                };
                                            }
                                            else
                                            {
                                                if (itemEditorInstance)
                                                {
                                                    _editedItemPosition = {
                                                        "columnIndex":editedItemPosition.columnIndex,
                                                        "rowIndex":Math.max(0, (editedItemPosition.rowIndex - _local_3.items.length))
                                                    };
                                                    itemEditorPositionChanged = true;
                                                    lastEditedItemPosition = _editedItemPosition;
                                                }
                                                else
                                                {
                                                    setEditedItemPosition({
                                                        "columnIndex":_local_2.columnIndex,
                                                        "rowIndex":Math.max(0, (_local_2.rowIndex - _local_3.items.length))
                                                    });
                                                };
                                            };
                                        };
                                    };
                                };
                            }
                            else
                            {
                                if (_local_3.kind == CollectionEventKind.REPLACE)
                                {
                                    if (editedItemPosition)
                                    {
                                        if (((_local_3.location == editedItemPosition.rowIndex) && (itemEditorInstance)))
                                        {
                                            endEdit(DataGridEventReason.CANCELLED);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            super.collectionChangeHandler(_arg_1);
            if ((_arg_1 is CollectionEvent))
            {
                _local_4 = CollectionEvent(_arg_1);
                if (_local_4.kind == CollectionEventKind.ADD)
                {
                    if (collection.length == 1)
                    {
                        if (generatedColumns)
                        {
                            generateCols();
                        };
                    };
                }
                else
                {
                    if (_local_4.kind == CollectionEventKind.REFRESH)
                    {
                        if (((lockedRowCount) && (lockedRowContent)))
                        {
                            lockedRowContent.iterator.seek(CursorBookmark.FIRST, 0);
                        };
                    };
                };
            };
        }

        override protected function get dragImage():IUIComponent
        {
            var _local_1:DataGridDragProxy = new DataGridDragProxy();
            _local_1.owner = this;
            _local_1.moduleFactory = moduleFactory;
            return (_local_1);
        }

        public function get draggableColumns():Boolean
        {
            return (_draggableColumns);
        }

        protected function drawSeparators():void
        {
            DataGridHeader(header)._drawSeparators();
            if (lockedColumnHeader)
            {
                DataGridHeader(lockedColumnHeader)._drawSeparators();
            };
        }

        override protected function scrollVertically(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            super.scrollVertically(_arg_1, _arg_2, _arg_3);
            if (getStyle("horizontalGridLines"))
            {
                drawLinesAndColumnGraphics(listContent, visibleColumns, {});
                if (lockedColumnCount)
                {
                    drawLinesAndColumnGraphics(lockedColumnContent, visibleLockedColumns, {"right":1});
                };
            };
        }

        override public function get baselinePosition():Number
        {
            var _local_2:Number;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _local_2 = 0;
                if (((border) && (border is IRectangularBorder)))
                {
                    _local_2 = IRectangularBorder(border).borderMetrics.top;
                };
                return (_local_2 + measureText(" ").ascent);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            if (!showHeaders)
            {
                return (super.baselinePosition);
            };
            var _local_1:IUIComponent = DataGridHeader(header).rendererArray[0];
            if (!_local_1)
            {
                return (super.baselinePosition);
            };
            return ((header.y + _local_1.y) + _local_1.baselinePosition);
        }

        private function displayingPartialRow():Boolean
        {
            var _local_1:int = ((listItems.length - 1) - offscreenExtraRowsBottom);
            if ((rowInfo[_local_1].y + rowInfo[_local_1].height) > (listContent.heightExcludingOffsets - listContent.topOffset))
            {
                return (true);
            };
            return (false);
        }

        mx_internal function calculateHeaderHeight():Number
        {
            var _local_1:IListItemRenderer;
            var _local_2:DataGridColumn;
            var _local_3:DataGridListData;
            var _local_5:int;
            var _local_6:int;
            if (!columns.length)
            {
                return (rowHeight);
            };
            if (!listContent)
            {
                return (rowHeight);
            };
            var _local_4:Number = 0;
            var _local_7:Number = getStyle("paddingTop");
            var _local_8:Number = getStyle("paddingBottom");
            if (showHeaders)
            {
                _local_4 = 0;
                _local_5 = columns.length;
                if (_headerWordWrapPresent)
                {
                    _headerHeight = _originalHeaderHeight;
                    _explicitHeaderHeight = _originalExplicitHeaderHeight;
                };
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_2 = columns[_local_6];
                    if (_local_2.visible)
                    {
                        _local_1 = _local_2.cachedHeaderRenderer;
                        if (!_local_1)
                        {
                            _local_1 = createColumnItemRenderer(_local_2, true, _local_2);
                            _local_1.styleName = _local_2;
                            _local_2.cachedHeaderRenderer = _local_1;
                        };
                        if (DisplayObject(_local_1).parent == null)
                        {
                            listContent.addChild(DisplayObject(_local_1));
                            _local_1.visible = false;
                        };
                        _local_3 = DataGridListData(makeListData(_local_2, uid, 0, _local_2.colNum, _local_2));
                        rowMap[_local_1.name] = _local_3;
                        if ((_local_1 is IDropInListItemRenderer))
                        {
                            IDropInListItemRenderer(_local_1).listData = _local_3;
                        };
                        _local_1.data = _local_2;
                        _local_1.explicitWidth = _local_2.width;
                        UIComponentGlobals.layoutManager.validateClient(_local_1, true);
                        _local_4 = Math.max(_local_4, ((_explicitHeaderHeight) ? headerHeight : ((_local_1.getExplicitOrMeasuredHeight() + _local_8) + _local_7)));
                        if (columnHeaderWordWrap(_local_2))
                        {
                            _headerWordWrapPresent = true;
                        };
                    };
                    _local_6++;
                };
                if (_headerWordWrapPresent)
                {
                    _originalHeaderHeight = _headerHeight;
                    _originalExplicitHeaderHeight = _explicitHeaderHeight;
                    _headerHeight = _local_4;
                    _explicitHeaderHeight = true;
                };
            };
            return (_local_4);
        }

        private function calculateColumnSizes():void
        {
            var _local_1:Number;
            var _local_2:int;
            var _local_3:int;
            var _local_5:DataGridColumn;
            var _local_6:Number;
            var _local_7:DataGridColumn;
            var _local_8:Number;
            var _local_9:int;
            var _local_10:int;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_4:Number = 0;
            if (columns.length == 0)
            {
                visibleColumns = [];
                visibleLockedColumns = [];
                lockedColumnWidth = 0;
                columnsInvalid = false;
                return;
            };
            if (columnsInvalid)
            {
                columnsInvalid = false;
                visibleColumns = [];
                visibleLockedColumns = [];
                lockedColumnWidth = 0;
                if (minColumnWidthInvalid)
                {
                    _local_2 = columns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        columns[_local_3].minWidth = minColumnWidth;
                        _local_3++;
                    };
                    minColumnWidthInvalid = false;
                };
                displayableColumns = null;
                _local_2 = _columns.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (((displayableColumns) && (_columns[_local_3].visible)))
                    {
                        displayableColumns.push(_columns[_local_3]);
                    }
                    else
                    {
                        if (((!(displayableColumns)) && (!(_columns[_local_3].visible))))
                        {
                            displayableColumns = new Array(_local_3);
                            _local_9 = 0;
                            while (_local_9 < _local_3)
                            {
                                displayableColumns[_local_9] = _columns[_local_9];
                                _local_9++;
                            };
                        };
                    };
                    _local_3++;
                };
                if (!displayableColumns)
                {
                    displayableColumns = _columns;
                };
                if (horizontalScrollPolicy == ScrollPolicy.OFF)
                {
                    _local_2 = displayableColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _local_5 = displayableColumns[_local_3];
                        if (_local_3 < lockedColumnCount)
                        {
                            visibleLockedColumns.push(_local_5);
                        }
                        else
                        {
                            visibleColumns.push(_local_5);
                        };
                        _local_3++;
                    };
                }
                else
                {
                    _local_2 = displayableColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        if (!((_local_3 >= lockedColumnCount) && (_local_3 < (lockedColumnCount + horizontalScrollPosition))))
                        {
                            _local_5 = displayableColumns[_local_3];
                            if (_local_5.preferredWidth < _local_5.minWidth)
                            {
                                _local_5.preferredWidth = _local_5.minWidth;
                            };
                            if (_local_4 < displayWidth)
                            {
                                if (_local_3 < lockedColumnCount)
                                {
                                    lockedColumnWidth = (lockedColumnWidth + Math.max(((isNaN(_local_5.explicitWidth)) ? _local_5.preferredWidth : _local_5.explicitWidth), _local_5.minWidth));
                                    visibleLockedColumns.push(_local_5);
                                }
                                else
                                {
                                    visibleColumns.push(_local_5);
                                };
                                _local_4 = (_local_4 + Math.max(((isNaN(_local_5.explicitWidth)) ? _local_5.preferredWidth : _local_5.explicitWidth), _local_5.minWidth));
                                if (_local_5.width != _local_5.preferredWidth)
                                {
                                    _local_5.setWidth(_local_5.preferredWidth);
                                };
                            }
                            else
                            {
                                if (visibleColumns.length == 0)
                                {
                                    visibleColumns.push(displayableColumns[0]);
                                };
                                break;
                            };
                        };
                        _local_3++;
                    };
                };
            };
            if (horizontalScrollPolicy == ScrollPolicy.OFF)
            {
                _local_10 = 0;
                _local_11 = 0;
                _local_2 = visibleColumns.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (((visibleColumns[_local_3].resizable) && (!(visibleColumns[_local_3].newlyVisible))))
                    {
                        if (!isNaN(visibleColumns[_local_3].explicitWidth))
                        {
                            _local_11 = (_local_11 + visibleColumns[_local_3].width);
                        }
                        else
                        {
                            _local_10++;
                            _local_11 = (_local_11 + visibleColumns[_local_3].minWidth);
                        };
                    }
                    else
                    {
                        _local_11 = (_local_11 + visibleColumns[_local_3].width);
                    };
                    _local_4 = (_local_4 + visibleColumns[_local_3].width);
                    _local_3++;
                };
                _local_2 = visibleLockedColumns.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (((visibleLockedColumns[_local_3].resizable) && (!(visibleLockedColumns[_local_3].newlyVisible))))
                    {
                        if (!isNaN(visibleLockedColumns[_local_3].explicitWidth))
                        {
                            _local_11 = (_local_11 + visibleLockedColumns[_local_3].width);
                        }
                        else
                        {
                            _local_10++;
                            _local_11 = (_local_11 + visibleLockedColumns[_local_3].minWidth);
                        };
                    }
                    else
                    {
                        _local_11 = (_local_11 + visibleLockedColumns[_local_3].width);
                    };
                    _local_4 = (_local_4 + visibleLockedColumns[_local_3].width);
                    _local_3++;
                };
                _local_13 = displayWidth;
                if (((displayWidth > _local_11) && (_local_10)))
                {
                    _local_2 = visibleLockedColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        if ((((visibleLockedColumns[_local_3].resizable) && (!(visibleLockedColumns[_local_3].newlyVisible))) && (isNaN(visibleLockedColumns[_local_3].explicitWidth))))
                        {
                            _local_7 = visibleLockedColumns[_local_3];
                            if (_local_4 > displayWidth)
                            {
                                _local_12 = ((_local_7.width - _local_7.minWidth) / (_local_4 - _local_11));
                            }
                            else
                            {
                                _local_12 = (_local_7.width / _local_4);
                            };
                            _local_8 = (_local_7.width - ((_local_4 - displayWidth) * _local_12));
                            _local_14 = visibleLockedColumns[_local_3].minWidth;
                            visibleLockedColumns[_local_3].setWidth(((_local_8 > _local_14) ? _local_8 : _local_14));
                        };
                        _local_13 = (_local_13 - visibleLockedColumns[_local_3].width);
                        visibleLockedColumns[_local_3].newlyVisible = false;
                        _local_3++;
                    };
                    _local_2 = visibleColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        if ((((visibleColumns[_local_3].resizable) && (!(visibleColumns[_local_3].newlyVisible))) && (isNaN(visibleColumns[_local_3].explicitWidth))))
                        {
                            _local_7 = visibleColumns[_local_3];
                            if (_local_4 > displayWidth)
                            {
                                _local_12 = ((_local_7.width - _local_7.minWidth) / (_local_4 - _local_11));
                            }
                            else
                            {
                                _local_12 = (_local_7.width / _local_4);
                            };
                            _local_8 = (_local_7.width - ((_local_4 - displayWidth) * _local_12));
                            _local_14 = visibleColumns[_local_3].minWidth;
                            visibleColumns[_local_3].setWidth(((_local_8 > _local_14) ? _local_8 : _local_14));
                        };
                        _local_13 = (_local_13 - visibleColumns[_local_3].width);
                        visibleColumns[_local_3].newlyVisible = false;
                        _local_3++;
                    };
                    if (((_local_13) && (_local_7)))
                    {
                        _local_7.setWidth((_local_7.width + _local_13));
                    };
                }
                else
                {
                    _local_2 = visibleLockedColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _local_7 = visibleLockedColumns[_local_3];
                        _local_12 = (_local_7.width / _local_4);
                        _local_8 = (displayWidth * _local_12);
                        _local_7.setWidth(_local_8);
                        _local_7.explicitWidth = NaN;
                        _local_13 = (_local_13 - _local_8);
                        _local_3++;
                    };
                    _local_2 = visibleColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _local_7 = visibleColumns[_local_3];
                        _local_12 = (_local_7.width / _local_4);
                        _local_8 = (displayWidth * _local_12);
                        _local_7.setWidth(_local_8);
                        _local_7.explicitWidth = NaN;
                        _local_13 = (_local_13 - _local_8);
                        _local_3++;
                    };
                    if (((_local_13) && (_local_7)))
                    {
                        _local_7.setWidth((_local_7.width + _local_13));
                    };
                };
            }
            else
            {
                _local_4 = 0;
                _local_2 = visibleColumns.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (_local_4 > (displayWidth - lockedColumnWidth))
                    {
                        visibleColumns.splice(_local_3);
                        break;
                    };
                    _local_4 = (_local_4 + ((isNaN(visibleColumns[_local_3].explicitWidth)) ? visibleColumns[_local_3].preferredWidth : visibleColumns[_local_3].explicitWidth));
                    _local_3++;
                };
                if (visibleColumns.length == 0)
                {
                    return;
                };
                _local_3 = (visibleColumns[(visibleColumns.length - 1)].colNum + 1);
                if (((_local_4 < (displayWidth - lockedColumnWidth)) && (_local_3 < displayableColumns.length)))
                {
                    _local_2 = displayableColumns.length;
                    while (((_local_3 < _local_2) && (_local_4 < (displayWidth - lockedColumnWidth))))
                    {
                        _local_5 = displayableColumns[_local_3];
                        visibleColumns.push(_local_5);
                        _local_4 = (_local_4 + ((isNaN(_local_5.explicitWidth)) ? _local_5.preferredWidth : _local_5.explicitWidth));
                        _local_3++;
                    };
                }
                else
                {
                    if (((_local_4 < (displayWidth - lockedColumnWidth)) && (horizontalScrollPosition > 0)))
                    {
                        while (((_local_4 < (displayWidth - lockedColumnWidth)) && (horizontalScrollPosition > 0)))
                        {
                            _local_5 = displayableColumns[((lockedColumnCount + horizontalScrollPosition) - 1)];
                            _local_6 = ((isNaN(_local_5.explicitWidth)) ? _local_5.preferredWidth : _local_5.explicitWidth);
                            if (_local_6 < ((displayWidth - lockedColumnWidth) - _local_4))
                            {
                                visibleColumns.splice(0, 0, _local_5);
                                super.horizontalScrollPosition--;
                                _local_4 = (_local_4 + _local_6);
                            }
                            else
                            {
                                break;
                            };
                        };
                    };
                };
                _local_7 = visibleColumns[(visibleColumns.length - 1)];
                _local_6 = ((isNaN(_local_7.explicitWidth)) ? _local_7.preferredWidth : _local_7.explicitWidth);
                _local_8 = (((_local_6 + displayWidth) - lockedColumnWidth) - _local_4);
                if (((((_local_7 == displayableColumns[(displayableColumns.length - 1)]) && (_local_7.resizable)) && (_local_8 >= _local_7.minWidth)) && (_local_8 > _local_6)))
                {
                    _local_7.setWidth(_local_8);
                    maxHorizontalScrollPosition = (displayableColumns.length - visibleColumns.length);
                }
                else
                {
                    if (((visibleColumns.length == 1) && (_local_7 == displayableColumns[(displayableColumns.length - 1)])))
                    {
                        maxHorizontalScrollPosition = (displayableColumns.length - visibleColumns.length);
                    }
                    else
                    {
                        maxHorizontalScrollPosition = ((displayableColumns.length - visibleColumns.length) + 1);
                    };
                };
            };
            lockedColumnWidth = 0;
            if (visibleLockedColumns.length)
            {
                _local_2 = visibleLockedColumns.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_5 = visibleLockedColumns[_local_3];
                    lockedColumnWidth = (lockedColumnWidth + _local_5.width);
                    _local_3++;
                };
            };
        }

        private function beginningEdit(_arg_1:int, _arg_2:int, _arg_3:IListItemRenderer=null):void
        {
            var _local_4:DataGridEvent = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGINNING, false, true);
            _local_4.columnIndex = _arg_1;
            _local_4.dataField = _columns[_arg_1].dataField;
            _local_4.rowIndex = _arg_2;
            _local_4.itemRenderer = _arg_3;
            if (!dispatchEvent(_local_4))
            {
                lastEditedItemPosition = {
                    "columnIndex":_arg_1,
                    "rowIndex":_arg_2
                };
            };
        }

        protected function drawRowGraphics(_arg_1:ListBaseContentHolder):void
        {
            var _local_3:Array;
            var _local_7:int;
            var _local_2:Sprite = Sprite(_arg_1.getChildByName("rowBGs"));
            if (!_local_2)
            {
                _local_2 = new FlexSprite();
                _local_2.mouseEnabled = false;
                _local_2.name = "rowBGs";
                _arg_1.addChildAt(_local_2, 0);
            };
            _local_3 = getStyle("alternatingItemColors");
            if (((!(_local_3)) || (_local_3.length == 0)))
            {
                while (_local_2.numChildren > _local_7)
                {
                    _local_2.removeChildAt((_local_2.numChildren - 1));
                };
                return;
            };
            StyleManager.getColorNames(_local_3);
            var _local_4:int;
            var _local_5:int;
            var _local_6:int = verticalScrollPosition;
            _local_7 = _arg_1.listItems.length;
            while (_local_4 < _local_7)
            {
                drawRowBackground(_local_2, _local_5++, _arg_1.rowInfo[_local_4].y, _arg_1.rowInfo[_local_4].height, _local_3[(_local_6 % _local_3.length)], _local_6);
                _local_4++;
                _local_6++;
            };
            while (_local_2.numChildren > _local_5)
            {
                _local_2.removeChildAt((_local_2.numChildren - 1));
            };
        }

        protected function drawHorizontalLine(_arg_1:Sprite, _arg_2:int, _arg_3:uint, _arg_4:Number):void
        {
            var _local_5:ListBaseContentHolder = (_arg_1.parent.parent as ListBaseContentHolder);
            var _local_6:Graphics = _arg_1.graphics;
            _local_6.lineStyle(1, _arg_3);
            _local_6.moveTo(0, _arg_4);
            _local_6.lineTo(_local_5.width, _arg_4);
        }

        override protected function initializeAccessibility():void
        {
            if (DataGrid.createAccessibilityImplementation != null)
            {
                DataGrid.createAccessibilityImplementation(this);
            };
        }

        private function endEdit(_arg_1:String):Boolean
        {
            if (!editedItemRenderer)
            {
                return (true);
            };
            inEndEdit = true;
            var _local_2:DataGridEvent = new DataGridEvent(DataGridEvent.ITEM_EDIT_END, false, true);
            _local_2.columnIndex = editedItemPosition.columnIndex;
            _local_2.dataField = _columns[editedItemPosition.columnIndex].dataField;
            _local_2.rowIndex = editedItemPosition.rowIndex;
            _local_2.itemRenderer = editedItemRenderer;
            _local_2.reason = _arg_1;
            dispatchEvent(_local_2);
            dontEdit = (!(itemEditorInstance == null));
            if (((!(dontEdit)) && (_arg_1 == DataGridEventReason.CANCELLED)))
            {
                losingFocus = true;
                setFocus();
            };
            inEndEdit = false;
            return (!(_local_2.isDefaultPrevented()));
        }

        private function editorKeyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ESCAPE)
            {
                endEdit(DataGridEventReason.CANCELLED);
            }
            else
            {
                if (((_arg_1.ctrlKey) && (_arg_1.charCode == 46)))
                {
                    endEdit(DataGridEventReason.CANCELLED);
                }
                else
                {
                    if (((_arg_1.charCode == Keyboard.ENTER) && (!(_arg_1.keyCode == 229))))
                    {
                        if (!_editedItemPosition)
                        {
                            return;
                        };
                        if (columns[_editedItemPosition.columnIndex].editorUsesEnterKey)
                        {
                            return;
                        };
                        if (((endEdit(DataGridEventReason.NEW_ROW)) && (!(dontEdit))))
                        {
                            findNextEnterItemRenderer(_arg_1);
                        };
                    };
                };
            };
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
                endEdit(DataGridEventReason.OTHER);
            };
        }

        override public function itemToLabel(_arg_1:Object):String
        {
            return (displayableColumns[((sortIndex == -1) ? 0 : sortIndex)].itemToLabel(_arg_1));
        }

        mx_internal function _drawSeparators():void
        {
            drawSeparators();
        }

        override protected function configureScrollBars():void
        {
            var _local_9:int;
            var _local_10:int;
            if (columnsInvalid)
            {
                return;
            };
            if (!displayableColumns)
            {
                return;
            };
            var _local_1:Array = this.listItems;
            if (((((visibleColumns) && (!(visibleColumns.length))) && (visibleLockedColumns)) && (visibleLockedColumns.length)))
            {
                _local_1 = lockedColumnContent.listItems;
            };
            var _local_2:Object = horizontalScrollBar;
            var _local_3:Object = verticalScrollBar;
            var _local_4:int = _local_1.length;
            if (_local_4 == 0)
            {
                if (((_local_2) || (_local_3)))
                {
                    if (listContent.height)
                    {
                        setScrollBarProperties(0, 0, 0, 0);
                    };
                };
                return;
            };
            if (((_local_4 > 1) && (displayingPartialRow())))
            {
                _local_4--;
            };
            var _local_5:int = verticalScrollPosition;
            var _local_6:int;
            while (((_local_4) && (_local_1[(_local_4 - 1)].length == 0)))
            {
                if (((collection) && ((_local_4 + _local_5) >= (collection.length - lockedRowCount))))
                {
                    _local_4--;
                    _local_6++;
                }
                else
                {
                    break;
                };
            };
            if (((verticalScrollPosition > 0) && (_local_6 > 0)))
            {
                if (adjustVerticalScrollPositionDownward(Math.max(_local_4, 1)))
                {
                    return;
                };
            };
            _local_4 = (_local_4 - (offscreenExtraRowsTop + offscreenExtraRowsBottom));
            var _local_7:Boolean = ((collection) && (collection.length > 0));
            var _local_8:int = (((_local_7) && (_local_4 > 0)) ? listItems[0].length : visibleColumns.length);
            if (((((_local_7) && (_local_4 > 0)) && (_local_8 > 1)) && ((listItems[0][(_local_8 - 1)].x + visibleColumns[(_local_8 - 1)].width) > ((displayWidth - listContent.x) + viewMetrics.left))))
            {
                _local_8--;
            }
            else
            {
                if (((_local_8 > 1) && (!(_local_7))))
                {
                    _local_9 = 0;
                    _local_10 = 0;
                    while (_local_10 < visibleColumns.length)
                    {
                        _local_9 = (_local_9 + visibleColumns[_local_10].width);
                        _local_10++;
                    };
                    if (_local_9 > ((displayWidth - listContent.x) + viewMetrics.left))
                    {
                        _local_8--;
                    };
                };
            };
            setScrollBarProperties((displayableColumns.length - lockedColumnCount), Math.max(_local_8, 1), ((collection) ? (collection.length - lockedRowCount) : 0), Math.max(_local_4, 1));
            if (((((!(verticalScrollBar)) || (!(verticalScrollBar.visible))) && (collection)) && ((collection.length - lockedRowCount) > _local_4)))
            {
                maxVerticalScrollPosition = ((collection.length - lockedRowCount) - _local_4);
            };
            if ((((!(horizontalScrollBar)) || (!(horizontalScrollBar.visible))) && ((displayableColumns.length - lockedColumnCount) > (_local_8 - lockedColumnCount))))
            {
                maxHorizontalScrollPosition = ((displayableColumns.length - lockedColumnCount) - _local_8);
            };
        }

        override public function set horizontalScrollPosition(_arg_1:Number):void
        {
            var _local_3:CursorBookmark;
            var _local_4:CursorBookmark;
            if (((!(initialized)) || (listItems.length == 0)))
            {
                super.horizontalScrollPosition = _arg_1;
                return;
            };
            var _local_2:int = super.horizontalScrollPosition;
            super.horizontalScrollPosition = _arg_1;
            scrollAreaChanged = true;
            columnsInvalid = true;
            calculateColumnSizes();
            if (itemsSizeChanged)
            {
                return;
            };
            if (_local_2 != _arg_1)
            {
                removeClipMask();
                if (iterator)
                {
                    _local_3 = iterator.bookmark;
                };
                clearIndicators();
                clearVisibleData();
                makeRowsAndColumns(0, 0, listContent.width, listContent.height, 0, 0);
                if (lockedRowCount)
                {
                    _local_4 = lockedRowContent.iterator.bookmark;
                    makeRows(lockedRowContent, 0, 0, unscaledWidth, unscaledHeight, 0, 0, true, lockedRowCount);
                    if (iteratorValid)
                    {
                        lockedRowContent.iterator.seek(_local_4, 0);
                    };
                };
                if (((headerVisible) && (header)))
                {
                    header.visibleColumns = visibleColumns;
                    header.headerItemsChanged = true;
                    header.invalidateSize();
                    header.validateNow();
                };
                if (((iterator) && (_local_3)))
                {
                    iterator.seek(_local_3, 0);
                };
                invalidateDisplayList();
                addClipMask(false);
            };
        }

        protected function drawColumnBackground(_arg_1:Sprite, _arg_2:int, _arg_3:uint, _arg_4:DataGridColumn):void
        {
            var _local_5:Shape;
            _local_5 = Shape(_arg_1.getChildByName(_arg_2.toString()));
            if (!_local_5)
            {
                _local_5 = new FlexShape();
                _arg_1.addChild(_local_5);
                _local_5.name = _arg_2.toString();
            };
            var _local_6:Graphics = _local_5.graphics;
            _local_6.clear();
            _local_6.beginFill(_arg_3);
            var _local_7:Object = rowInfo[(listItems.length - 1)];
            var _local_8:DataGridHeader = ((_arg_1.parent == lockedColumnContent) ? DataGridHeader(lockedColumnHeader) : DataGridHeader(header));
            var _local_9:Number = _local_8.rendererArray[_arg_2].x;
            var _local_10:Number = rowInfo[0].y;
            var _local_11:Number = Math.min((_local_7.y + _local_7.height), (listContent.height - _local_10));
            _local_6.drawRect(_local_9, _local_10, _local_8.visibleColumns[_arg_2].width, (listContent.height - _local_10));
            _local_6.endFill();
        }

        override public function set columns(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:DataGridColumn;
            var _local_5:DisplayObject;
            _local_2 = _columns.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                columnRendererChanged(_columns[_local_3]);
                _local_3++;
            };
            freeItemRenderersTable = new Dictionary(false);
            columnMap = {};
            _columns = _arg_1.slice(0);
            columnsInvalid = true;
            generatedColumns = false;
            _local_2 = _arg_1.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = _columns[_local_3];
                _local_4.owner = this;
                _local_4.colNum = _local_3;
                if (_local_4.cachedHeaderRenderer)
                {
                    _local_5 = (_local_4.cachedHeaderRenderer as DisplayObject);
                    if (_local_5.parent)
                    {
                        _local_5.parent.removeChild(_local_5);
                    };
                    _local_4.cachedHeaderRenderer = null;
                };
                _local_3++;
            };
            updateSortIndexAndDirection();
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("columnsChanged"));
        }

        override protected function mouseWheelHandler(_arg_1:MouseEvent):void
        {
            if (itemEditorInstance)
            {
                endEdit(DataGridEventReason.OTHER);
            };
            super.mouseWheelHandler(_arg_1);
        }

        public function get editedItemRenderer():IListItemRenderer
        {
            if (!itemEditorInstance)
            {
                return (null);
            };
            return (actualContentHolder.listItems[actualRowIndex][actualColIndex]);
        }

        public function set minColumnWidth(_arg_1:Number):void
        {
            _minColumnWidth = _arg_1;
            minColumnWidthInvalid = true;
            itemsSizeChanged = true;
            columnsInvalid = true;
            invalidateDisplayList();
        }

        override public function set focusPane(_arg_1:Sprite):void
        {
            super.focusPane = _arg_1;
            if (((!(_arg_1)) && (_focusPane)))
            {
                _focusPane.mask = null;
            };
            _focusPane = _arg_1;
        }

        override mx_internal function get rendererArray():Array
        {
            var _local_1:Array = listItems.slice();
            var _local_2:Array = DataGridHeader(header).rendererArray;
            _local_1.unshift(_local_2);
            return (_local_1);
        }

        override protected function commitProperties():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Object;
            var _local_4:IListItemRenderer;
            var _local_5:DataGridColumn;
            var _local_6:Number;
            var _local_7:int;
            var _local_8:int;
            super.commitProperties();
            if (itemsNeedMeasurement)
            {
                itemsNeedMeasurement = false;
                if (isNaN(explicitRowHeight))
                {
                    if (((iterator) && (columns.length > 0)))
                    {
                        visibleColumns = columns;
                        columnsInvalid = true;
                        _local_1 = getStyle("paddingTop");
                        _local_2 = getStyle("paddingBottom");
                        _local_3 = iterator.current;
                        _local_6 = 0;
                        _local_7 = columns.length;
                        _local_8 = 0;
                        while (_local_8 < _local_7)
                        {
                            _local_5 = columns[_local_8];
                            if (_local_5.visible)
                            {
                                _local_4 = _local_5.getMeasuringRenderer(false, _local_3);
                                if (DisplayObject(_local_4).parent == null)
                                {
                                    listContent.addChild(DisplayObject(_local_4));
                                };
                                setupRendererFromData(_local_5, _local_4, _local_3);
                                _local_6 = Math.max(_local_6, ((_local_4.getExplicitOrMeasuredHeight() + _local_2) + _local_1));
                            };
                            _local_8++;
                        };
                        setRowHeight(Math.max(_local_6, 20));
                    }
                    else
                    {
                        setRowHeight(20);
                    };
                };
            };
        }

        protected function drawRowBackground(_arg_1:Sprite, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:uint, _arg_6:int):void
        {
            var _local_8:Shape;
            var _local_7:ListBaseContentHolder = ListBaseContentHolder(_arg_1.parent);
            if (_arg_2 < _arg_1.numChildren)
            {
                _local_8 = Shape(_arg_1.getChildAt(_arg_2));
            }
            else
            {
                _local_8 = new FlexShape();
                _local_8.name = "background";
                _arg_1.addChild(_local_8);
            };
            _local_8.y = _arg_3;
            _arg_4 = Math.min(_arg_4, (_local_7.height - _arg_3));
            var _local_9:Graphics = _local_8.graphics;
            _local_9.clear();
            _local_9.beginFill(_arg_5, getStyle("backgroundAlpha"));
            _local_9.drawRect(0, 0, _local_7.width, _arg_4);
            _local_9.endFill();
        }

        private function adjustVerticalScrollPositionDownward(rowCount:int):Boolean
        {
            var item:IListItemRenderer;
            var c:DataGridColumn;
            var n:int;
            var j:int;
            var bMore:Boolean;
            var data:Object;
            var bookmark:CursorBookmark = iterator.bookmark;
            var h:Number = 0;
            var ch:Number = 0;
            var paddingTop:Number = getStyle("paddingTop");
            var paddingBottom:Number = getStyle("paddingBottom");
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
                    bMore = iterator.movePrevious();
                };
            }
            catch(e:ItemPendingError)
            {
                bMore = false;
            };
            if (!bMore)
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
            while (((h > 0) && (bMore)))
            {
                if (bMore)
                {
                    data = iterator.current;
                    ch = 0;
                    n = columns.length;
                    j = 0;
                    while (j < n)
                    {
                        c = columns[j];
                        if (c.visible)
                        {
                            if (variableRowHeight)
                            {
                                item = c.getMeasuringRenderer(false, data);
                                if (DisplayObject(item).parent == null)
                                {
                                    listContent.addChild(DisplayObject(item));
                                };
                                setupRendererFromData(c, item, data);
                            };
                            ch = Math.max(ch, ((variableRowHeight) ? ((item.getExplicitOrMeasuredHeight() + paddingBottom) + paddingTop) : rowHeight));
                        };
                        j = (j + 1);
                    };
                };
                h = (h - ch);
                try
                {
                    bMore = iterator.movePrevious();
                    numRows = (numRows + 1);
                }
                catch(e:ItemPendingError)
                {
                    bMore = false;
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

        override protected function calculateRowHeight(_arg_1:Object, _arg_2:Number, _arg_3:Boolean=false):Number
        {
            var _local_4:IListItemRenderer;
            var _local_5:DataGridColumn;
            var _local_7:int;
            var _local_6:int = columns.length;
            var _local_8:int;
            var _local_9:int = visibleLockedColumns.length;
            if (((_arg_3) && (visibleColumns.length == _columns.length)))
            {
                return (_arg_2);
            };
            var _local_10:Number = getStyle("paddingTop");
            var _local_11:Number = getStyle("paddingBottom");
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                if ((((_arg_3) && (_local_8 < _local_9)) && (visibleLockedColumns[_local_8].colNum == columns[_local_7].colNum)))
                {
                    _local_8++;
                }
                else
                {
                    if ((((_arg_3) && ((_local_8 - _local_9) < visibleColumns.length)) && (visibleColumns[(_local_8 - _local_9)].colNum == columns[_local_7].colNum)))
                    {
                        _local_8++;
                    }
                    else
                    {
                        _local_5 = columns[_local_7];
                        if (_local_5.visible)
                        {
                            _local_4 = _local_5.getMeasuringRenderer(false, _arg_1);
                            if (DisplayObject(_local_4).parent == null)
                            {
                                listContent.addChild(DisplayObject(_local_4));
                            };
                            setupRendererFromData(_local_5, _local_4, _arg_1);
                            _arg_2 = Math.max(_arg_2, ((_local_4.getExplicitOrMeasuredHeight() + _local_11) + _local_10));
                        };
                    };
                };
                _local_7++;
            };
            return (_arg_2);
        }

        [Bindable("columnsChanged")]
        override public function get columns():Array
        {
            return (_columns.slice(0));
        }

        override protected function scrollHandler(_arg_1:Event):void
        {
            var _local_2:ScrollBar;
            var _local_3:Number;
            if (((_arg_1.target == verticalScrollBar) || (_arg_1.target == horizontalScrollBar)))
            {
                if ((_arg_1 is ScrollEvent))
                {
                    if (((!(liveScrolling)) && (ScrollEvent(_arg_1).detail == ScrollEventDetail.THUMB_TRACK)))
                    {
                        return;
                    };
                    if (itemEditorInstance)
                    {
                        endEdit(DataGridEventReason.OTHER);
                    };
                    _local_2 = ScrollBar(_arg_1.target);
                    _local_3 = _local_2.scrollPosition;
                    if (_local_2 == verticalScrollBar)
                    {
                        verticalScrollPosition = _local_3;
                    }
                    else
                    {
                        if (_local_2 == horizontalScrollBar)
                        {
                            horizontalScrollPosition = _local_3;
                        };
                    };
                    super.scrollHandler(_arg_1);
                };
            };
        }

        public function isItemEditable(_arg_1:Object):Boolean
        {
            if (!editable)
            {
                return (false);
            };
            if (!_arg_1)
            {
                return (false);
            };
            return (true);
        }

        mx_internal function _placeSortArrow():void
        {
            placeSortArrow();
        }

        protected function drawLinesAndColumnGraphics(_arg_1:ListBaseContentHolder, _arg_2:Array, _arg_3:Object):void
        {
            var _local_8:uint;
            var _local_9:int;
            var _local_13:Number;
            var _local_14:Sprite;
            var _local_15:int;
            var _local_16:Number;
            var _local_17:DataGridColumn;
            var _local_18:Object;
            var _local_19:Shape;
            var _local_20:Graphics;
            var _local_21:DisplayObject;
            var _local_4:Sprite = Sprite(_arg_1.getChildByName("lines"));
            if (!_local_4)
            {
                _local_4 = new UIComponent();
                _local_4.name = "lines";
                _local_4.cacheAsBitmap = true;
                _local_4.mouseEnabled = false;
                _arg_1.addChild(_local_4);
            };
            _arg_1.setChildIndex(_local_4, (_arg_1.numChildren - 1));
            var _local_5:Array = _arg_1.rowInfo;
            _local_4.graphics.clear();
            var _local_6:Sprite = Sprite(_local_4.getChildByName("body"));
            if (!_local_6)
            {
                _local_6 = new UIComponent();
                _local_6.name = "body";
                _local_6.mouseEnabled = false;
                _local_4.addChild(_local_6);
            };
            _local_6.graphics.clear();
            while (_local_6.numChildren)
            {
                _local_6.removeChildAt(0);
            };
            var _local_7:Number = (unscaledHeight - 1);
            var _local_10:uint = ((_arg_2) ? _arg_2.length : 0);
            var _local_11:uint = _arg_1.listItems.length;
            _local_8 = getStyle("horizontalGridLineColor");
            if (getStyle("horizontalGridLines"))
            {
                _local_9 = 0;
                while (_local_9 < _local_11)
                {
                    _local_13 = (_local_5[_local_9].y + _local_5[_local_9].height);
                    if (_local_13 < _arg_1.height)
                    {
                        drawHorizontalSeparator(_local_6, _local_9, _local_8, _local_13);
                    };
                    _local_9++;
                };
            };
            if (_arg_3.top)
            {
                drawHorizontalSeparator(_local_6, _local_9++, 0, _local_5[0].y, true);
            };
            if (((_arg_3.bottom) && (_local_11 > 0)))
            {
                drawHorizontalSeparator(_local_6, _local_9++, 0, (_local_5[(_local_11 - 1)].y + _local_5[(_local_11 - 1)].height), true);
            };
            var _local_12:Boolean = getStyle("verticalGridLines");
            _local_8 = getStyle("verticalGridLineColor");
            if (_local_10)
            {
                _local_14 = Sprite(_arg_1.getChildByName("colBGs"));
                _local_15 = -1;
                _local_16 = 0;
                _local_9 = 0;
                while (_local_9 < _local_10)
                {
                    if (((_local_12) && (_local_9 < (_local_10 - 1))))
                    {
                        drawVerticalSeparator(_local_6, _local_9, _local_8, (_local_16 + _arg_2[_local_9].width));
                    };
                    _local_17 = _arg_2[_local_9];
                    if (enabled)
                    {
                        _local_18 = _local_17.getStyle("backgroundColor");
                    }
                    else
                    {
                        _local_18 = _local_17.getStyle("backgroundDisabledColor");
                    };
                    if (((!(_local_18 === null)) && (!(isNaN(Number(_local_18))))))
                    {
                        if (!_local_14)
                        {
                            _local_14 = new FlexSprite();
                            _local_14.mouseEnabled = false;
                            _local_14.name = "colBGs";
                            _arg_1.addChildAt(_local_14, (_arg_1.getChildIndex(_arg_1.getChildByName("rowBGs")) + 1));
                        };
                        drawColumnBackground(_local_14, _local_9, Number(_local_18), _local_17);
                        _local_15 = _local_9;
                    }
                    else
                    {
                        if (_local_14)
                        {
                            _local_19 = Shape(_local_14.getChildByName(_local_9.toString()));
                            if (_local_19)
                            {
                                _local_20 = _local_19.graphics;
                                _local_20.clear();
                                _local_14.removeChild(_local_19);
                            };
                        };
                    };
                    _local_16 = (_local_16 + _arg_2[_local_9].width);
                    _local_9++;
                };
                if (((_local_14) && (_local_14.numChildren)))
                {
                    while (_local_14.numChildren)
                    {
                        _local_21 = _local_14.getChildAt((_local_14.numChildren - 1));
                        if (parseInt(_local_21.name) > _local_15)
                        {
                            _local_14.removeChild(_local_21);
                        }
                        else
                        {
                            break;
                        };
                    };
                };
            };
            if ((((_arg_3.right) && (_arg_2)) && (_arg_2.length)))
            {
                if (((_arg_1.listItems.length) && (_arg_1.listItems[0].length)))
                {
                    drawVerticalSeparator(_local_6, _local_9++, 0, (_arg_1.listItems[0][(_local_10 - 1)].x + _arg_2[(_local_10 - 1)].width), true);
                }
                else
                {
                    _local_16 = 0;
                    _local_9 = 0;
                    while (_local_9 < _local_10)
                    {
                        _local_16 = (_local_16 + _arg_2[_local_9].width);
                        _local_9++;
                    };
                    drawVerticalSeparator(_local_6, _local_9++, 0, _local_16, true);
                };
            };
            if (_arg_3.left)
            {
                drawVerticalSeparator(_local_6, _local_9++, 0, 0, true);
            };
        }

        protected function placeSortArrow():void
        {
            DataGridHeader(header)._placeSortArrow();
            if (lockedColumnHeader)
            {
                DataGridHeader(lockedColumnHeader)._placeSortArrow();
            };
        }

        private function commitEditedItemPosition(_arg_1:Object):void
        {
            var _local_7:String;
            var _local_8:int;
            var _local_9:ListEvent;
            if (((!(enabled)) || (!(editable))))
            {
                return;
            };
            if (((!(collection)) || (collection.length == 0)))
            {
                return;
            };
            if ((((((itemEditorInstance) && (_arg_1)) && (itemEditorInstance is IFocusManagerComponent)) && (_editedItemPosition.rowIndex == _arg_1.rowIndex)) && (_editedItemPosition.columnIndex == _arg_1.columnIndex)))
            {
                IFocusManagerComponent(itemEditorInstance).setFocus();
                return;
            };
            if (itemEditorInstance)
            {
                if (!_arg_1)
                {
                    _local_7 = DataGridEventReason.OTHER;
                }
                else
                {
                    _local_7 = (((!(editedItemPosition)) || (_arg_1.rowIndex == editedItemPosition.rowIndex)) ? DataGridEventReason.NEW_COLUMN : DataGridEventReason.NEW_ROW);
                };
                if (((!(endEdit(_local_7))) && (!(_local_7 == DataGridEventReason.OTHER))))
                {
                    return;
                };
            };
            _editedItemPosition = _arg_1;
            if (!_arg_1)
            {
                return;
            };
            if (dontEdit)
            {
                return;
            };
            var _local_2:int = _arg_1.rowIndex;
            var _local_3:int = _arg_1.columnIndex;
            if (displayableColumns.length != _columns.length)
            {
                _local_8 = 0;
                while (_local_8 < displayableColumns.length)
                {
                    if (displayableColumns[_local_8].colNum >= _local_3)
                    {
                        _local_3 = _local_8;
                        break;
                    };
                    _local_8++;
                };
                if (_local_8 == displayableColumns.length)
                {
                    _local_3 = 0;
                };
            };
            var _local_4:Boolean;
            if (selectedIndex != _arg_1.rowIndex)
            {
                commitSelectedIndex(_arg_1.rowIndex);
                _local_4 = true;
            };
            scrollToEditedItem(_local_2, _local_3);
            var _local_5:IListItemRenderer = actualContentHolder.listItems[actualRowIndex][actualColIndex];
            if (!_local_5)
            {
                commitEditedItemPosition(null);
                return;
            };
            if (!isItemEditable(_local_5.data))
            {
                commitEditedItemPosition(null);
                return;
            };
            if (_local_4)
            {
                _local_9 = new ListEvent(ListEvent.CHANGE);
                _local_9.columnIndex = _arg_1.columnIndex;
                _local_9.rowIndex = _arg_1.rowIndex;
                _local_9.itemRenderer = _local_5;
                dispatchEvent(_local_9);
            };
            var _local_6:DataGridEvent = new DataGridEvent(DataGridEvent.ITEM_EDIT_BEGIN, false, true);
            _local_6.columnIndex = displayableColumns[_local_3].colNum;
            _local_6.rowIndex = _editedItemPosition.rowIndex;
            _local_6.itemRenderer = _local_5;
            dispatchEvent(_local_6);
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

        protected function getCurrentDataValue(_arg_1:Object, _arg_2:String):String
        {
            if (!isComplexColumn(_arg_2))
            {
                return (_arg_1[_arg_2]);
            };
            var _local_3:Array = _arg_2.split(".");
            var _local_4:Object = deriveComplexFieldReference(_arg_1, _local_3);
            return (String(_local_4));
        }

        private function editorStageResizeHandler(_arg_1:Event):void
        {
            if (((_arg_1.target is DisplayObjectContainer) && (DisplayObjectContainer(_arg_1.target).contains(this))))
            {
                endEdit(DataGridEventReason.OTHER);
            };
        }

        private function generateColumnsPendingResultHandler(_arg_1:Object, _arg_2:ListBaseSeekPending):void
        {
            if (columns.length == 0)
            {
                generateCols();
            };
            seekPendingResultHandler(_arg_1, _arg_2);
        }

        protected function drawVerticalLine(_arg_1:Sprite, _arg_2:int, _arg_3:uint, _arg_4:Number):void
        {
            var _local_5:ListBaseContentHolder = (_arg_1.parent.parent as ListBaseContentHolder);
            var _local_6:Graphics = _arg_1.graphics;
            _local_6.lineStyle(1, _arg_3, 100);
            _local_6.moveTo(_arg_4, ((headerVisible) ? 0 : 1));
            _local_6.lineTo(_arg_4, _local_5.height);
        }

        private function editorMouseDownHandler(_arg_1:Event):void
        {
            if (((_arg_1 is MouseEvent) && (owns(DisplayObject(_arg_1.target)))))
            {
                return;
            };
            endEdit(DataGridEventReason.OTHER);
            losingFocus = true;
            setFocus();
        }

        override protected function adjustListContent(unscaledWidth:Number=-1, unscaledHeight:Number=-1):void
        {
            var ww:Number;
            var lcx:Number;
            var lcy:Number;
            var hcx:Number;
            var pt:Point;
            var hh:Number = 0;
            if (headerVisible)
            {
                if (lockedColumnCount > 0)
                {
                    lockedColumnHeader.visible = true;
                    hcx = (viewMetrics.left + Math.min(DataGridHeader(lockedColumnHeader).leftOffset, 0));
                    lockedColumnHeader.move(hcx, viewMetrics.top);
                    hh = lockedColumnHeader.getExplicitOrMeasuredHeight();
                    lockedColumnHeader.setActualSize((lockedColumnWidth + 1), hh);
                    DataGridHeader(lockedColumnHeader).needRightSeparator = true;
                    DataGridHeader(lockedColumnHeader).needRightSeparatorEvents = true;
                };
                header.visible = true;
                hcx = ((viewMetrics.left + lockedColumnWidth) + Math.min(DataGridHeader(header).leftOffset, 0));
                header.move(hcx, viewMetrics.top);
                if ((((((!(verticalScrollBar == null)) && (verticalScrollBar.visible)) && ((horizontalScrollBar == null) || (!(horizontalScrollBar.visible)))) && (headerVisible)) && (roomForScrollBar(verticalScrollBar, unscaledWidth, (unscaledHeight - header.height)))))
                {
                    ww = ((Math.max(0, DataGridHeader(header).rightOffset) - hcx) - borderMetrics.right);
                }
                else
                {
                    ww = ((Math.max(0, DataGridHeader(header).rightOffset) - hcx) - viewMetrics.right);
                };
                hh = header.getExplicitOrMeasuredHeight();
                header.setActualSize((unscaledWidth + ww), hh);
                if (!skipHeaderUpdate)
                {
                    header.headerItemsChanged = true;
                    header.invalidateDisplayList();
                };
            }
            else
            {
                header.visible = false;
                if (lockedColumnCount > 0)
                {
                    lockedColumnHeader.visible = false;
                };
            };
            if ((((lockedRowCount > 0) && (lockedRowContent)) && (lockedRowContent.iterator)))
            {
                try
                {
                    lockedRowContent.iterator.seek(CursorBookmark.FIRST);
                    pt = makeRows(lockedRowContent, 0, 0, unscaledWidth, unscaledHeight, 0, 0, true, lockedRowCount, true);
                    if (lockedColumnCount > 0)
                    {
                        lcx = (viewMetrics.left + Math.min(lockedColumnAndRowContent.leftOffset, 0));
                        lcy = ((viewMetrics.top + Math.min(lockedColumnAndRowContent.topOffset, 0)) + Math.ceil(hh));
                        lockedColumnAndRowContent.move(lcx, lcy);
                        lockedColumnAndRowContent.setActualSize(lockedColumnWidth, lockedColumnAndRowContent.getExplicitOrMeasuredHeight());
                    };
                    lcx = ((viewMetrics.left + lockedColumnWidth) + Math.min(lockedRowContent.leftOffset, 0));
                    lcy = ((viewMetrics.top + Math.min(lockedRowContent.topOffset, 0)) + Math.ceil(hh));
                    lockedRowContent.move(lcx, lcy);
                    ww = ((Math.max(0, lockedRowContent.rightOffset) - lcx) - viewMetrics.right);
                    lockedRowContent.setActualSize((unscaledWidth + ww), lockedRowContent.getExplicitOrMeasuredHeight());
                    hh = (hh + lockedRowContent.getExplicitOrMeasuredHeight());
                }
                catch(e:ItemPendingError)
                {
                    e.addResponder(new ItemResponder(lockedRowSeekPendingResultHandler, seekPendingFailureHandler, null));
                };
            };
            if (lockedColumnCount > 0)
            {
                lcx = (viewMetrics.left + Math.min(lockedColumnContent.leftOffset, 0));
                lcy = ((viewMetrics.top + Math.min(lockedColumnContent.topOffset, 0)) + Math.ceil(hh));
                lockedColumnContent.move(lcx, lcy);
                ww = ((lockedColumnWidth + lockedColumnContent.rightOffset) - lockedColumnContent.leftOffset);
                lockedColumnContent.setActualSize(ww, (((unscaledHeight + Math.max(0, lockedColumnContent.bottomOffset)) - lcy) - viewMetrics.bottom));
            };
            lcx = ((viewMetrics.left + lockedColumnWidth) + Math.min(listContent.leftOffset, 0));
            lcy = ((viewMetrics.top + Math.min(listContent.topOffset, 0)) + Math.ceil(hh));
            listContent.move(lcx, lcy);
            ww = ((Math.max(0, listContent.rightOffset) - lcx) - viewMetrics.right);
            hh = ((Math.max(0, listContent.bottomOffset) - lcy) - viewMetrics.bottom);
            listContent.setActualSize(Math.max(0, (unscaledWidth + ww)), Math.max(0, (unscaledHeight + hh)));
        }

        mx_internal function setupRendererFromData(_arg_1:DataGridColumn, _arg_2:IListItemRenderer, _arg_3:Object):void
        {
            var _local_4:DataGridListData = DataGridListData(makeListData(_arg_3, itemToUID(_arg_3), 0, _arg_1.colNum, _arg_1));
            if ((_arg_2 is IDropInListItemRenderer))
            {
                IDropInListItemRenderer(_arg_2).listData = ((_arg_3) ? _local_4 : null);
            };
            _arg_2.data = _arg_3;
            _arg_2.explicitWidth = getWidthOfItem(_arg_2, _arg_1);
            UIComponentGlobals.layoutManager.validateClient(_arg_2, true);
        }

        override public function get itemRenderer():IFactory
        {
            var _local_1:String;
            var _local_2:String;
            var _local_3:String;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:IFlexModuleFactory;
            if (super.itemRenderer == null)
            {
                _local_1 = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
                _local_2 = getStyle("fontWeight");
                _local_3 = getStyle("fontStyle");
                _local_4 = (_local_2 == "bold");
                _local_5 = (_local_3 == "italic");
                _local_6 = getFontContext(_local_1, _local_4, _local_5);
                super.itemRenderer = new ContextualClassFactory(DataGridItemRenderer, _local_6);
            };
            return (super.itemRenderer);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Number;
            var _local_4:EdgeMetrics;
            if (displayWidth != ((_arg_1 - viewMetrics.right) - viewMetrics.left))
            {
                displayWidth = ((_arg_1 - viewMetrics.right) - viewMetrics.left);
                columnsInvalid = true;
            };
            calculateColumnSizes();
            if (itemEditorPositionChanged)
            {
                itemEditorPositionChanged = false;
                if (!lastItemDown)
                {
                    scrollToEditedItem(editedItemPosition.rowIndex, editedItemPosition.colIndex);
                };
            };
            super.updateDisplayList(_arg_1, _arg_2);
            if (((collection) && (collection.length)))
            {
                setRowCount(listItems.length);
                if (listItems.length)
                {
                    setColumnCount(listItems[0].length);
                }
                else
                {
                    setColumnCount(0);
                };
            };
            if (((((!(verticalScrollBar == null)) && (verticalScrollBar.visible)) && ((horizontalScrollBar == null) || (!(horizontalScrollBar.visible)))) && (headerVisible)))
            {
                _local_3 = header.height;
                _local_4 = borderMetrics;
                if (roomForScrollBar(verticalScrollBar, ((_arg_1 - _local_4.left) - _local_4.right), (((_arg_2 - _local_3) - _local_4.top) - _local_4.bottom)))
                {
                    verticalScrollBar.move(verticalScrollBar.x, (viewMetrics.top + _local_3));
                    verticalScrollBar.setActualSize(verticalScrollBar.width, (((_arg_2 - viewMetrics.top) - viewMetrics.bottom) - _local_3));
                    verticalScrollBar.visible = true;
                    headerMask.width = (headerMask.width + verticalScrollBar.getExplicitOrMeasuredWidth());
                    if (!DataGridHeader(header).needRightSeparator)
                    {
                        header.invalidateDisplayList();
                        DataGridHeader(header).needRightSeparator = true;
                    };
                }
                else
                {
                    if (DataGridHeader(header).needRightSeparator)
                    {
                        header.invalidateDisplayList();
                        DataGridHeader(header).needRightSeparator = false;
                    };
                };
            }
            else
            {
                if (DataGridHeader(header).needRightSeparator)
                {
                    header.invalidateDisplayList();
                    DataGridHeader(header).needRightSeparator = false;
                };
            };
            if (bEditedItemPositionChanged)
            {
                bEditedItemPositionChanged = false;
                if (!lastItemDown)
                {
                    commitEditedItemPosition(_proposedEditedItemPosition);
                };
                _proposedEditedItemPosition = undefined;
                itemsSizeChanged = false;
            };
            drawRowBackgrounds();
            drawLinesAndColumnBackgrounds();
            if (((lockedRowCount) && (lockedRowContent)))
            {
                drawRowGraphics(lockedRowContent);
                drawLinesAndColumnGraphics(lockedRowContent, visibleColumns, {"bottom":1});
                if (lockedColumnCount)
                {
                    drawRowGraphics(lockedColumnAndRowContent);
                    drawLinesAndColumnGraphics(lockedColumnAndRowContent, visibleLockedColumns, {
                        "right":1,
                        "bottom":1
                    });
                };
            };
            if (lockedColumnCount)
            {
                drawRowGraphics(lockedColumnContent);
                drawLinesAndColumnGraphics(lockedColumnContent, visibleLockedColumns, {"right":1});
            };
        }

        mx_internal function shiftColumns(_arg_1:int, _arg_2:int, _arg_3:Event=null):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:IndexChangedEvent;
            var _local_7:int;
            var _local_8:DataGridColumn;
            if (((_arg_2 >= 0) && (!(_arg_1 == _arg_2))))
            {
                _local_4 = ((_arg_1 < _arg_2) ? 1 : -1);
                _local_5 = _arg_1;
                while (_local_5 != _arg_2)
                {
                    _local_7 = (_local_5 + _local_4);
                    _local_8 = _columns[_local_5];
                    _columns[_local_5] = _columns[_local_7];
                    _columns[_local_7] = _local_8;
                    _columns[_local_5].colNum = _local_5;
                    _columns[_local_7].colNum = _local_7;
                    _local_5 = (_local_5 + _local_4);
                };
                if (sortIndex == _arg_1)
                {
                    sortIndex = (sortIndex + (_arg_2 - _arg_1));
                }
                else
                {
                    if ((((_arg_1 < sortIndex) && (sortIndex <= _arg_2)) || ((_arg_2 <= sortIndex) && (sortIndex < _arg_1))))
                    {
                        sortIndex = (sortIndex - _local_4);
                    };
                };
                if (lastSortIndex == _arg_1)
                {
                    lastSortIndex = (lastSortIndex + (_arg_2 - _arg_1));
                }
                else
                {
                    if ((((_arg_1 < lastSortIndex) && (lastSortIndex <= _arg_2)) || ((_arg_2 <= lastSortIndex) && (lastSortIndex < _arg_1))))
                    {
                        lastSortIndex = (lastSortIndex - _local_4);
                    };
                };
                columnsInvalid = true;
                itemsSizeChanged = true;
                invalidateDisplayList();
                if (lockedColumnHeader)
                {
                    lockedColumnHeader.invalidateDisplayList();
                };
                _local_6 = new IndexChangedEvent(IndexChangedEvent.HEADER_SHIFT);
                _local_6.oldIndex = _arg_1;
                _local_6.newIndex = _arg_2;
                _local_6.triggerEvent = _arg_3;
                dispatchEvent(_local_6);
            };
        }

        override public function hideDropFeedback(_arg_1:DragEvent):void
        {
            super.hideDropFeedback(_arg_1);
            if (lockedColumnDropIndicator)
            {
                DisplayObject(lockedColumnDropIndicator).parent.removeChild(DisplayObject(lockedColumnDropIndicator));
                lockedColumnDropIndicator = null;
            };
        }

        override protected function dragStartHandler(_arg_1:DragEvent):void
        {
            if (collectionUpdatesDisabled)
            {
                collection.enableAutoUpdate();
                collectionUpdatesDisabled = false;
            };
            super.dragStartHandler(_arg_1);
        }

        protected function drawHeaderBackground(_arg_1:UIComponent):void
        {
            DataGridHeader(_arg_1.parent)._drawHeaderBackground(_arg_1);
        }


    }
}//package mx.controls

