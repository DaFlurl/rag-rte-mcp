// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListBase

package mx.controls.listClasses
{
    import mx.core.ScrollControlBase;
    import mx.core.IDataRenderer;
    import mx.managers.IFocusManagerComponent;
    import mx.effects.IEffectTargetHost;
    import mx.collections.IViewCursor;
    import mx.effects.IEffect;
    import flash.utils.Dictionary;
    import mx.collections.ModifiedCollectionView;
    import flash.display.Sprite;
    import mx.collections.CursorBookmark;
    import mx.core.IFactory;
    import mx.collections.ICollectionView;
    import flash.geom.Point;
    import mx.events.DragEvent;
    import mx.core.IFlexDisplayObject;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import mx.events.MoveEvent;
    import flash.display.Graphics;
    import mx.collections.errors.ItemPendingError;
    import mx.collections.ItemResponder;
    import flash.display.DisplayObject;
    import mx.managers.DragManager;
    import mx.events.ListEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import mx.core.IUIComponent;
    import mx.utils.ObjectUtil;
    import mx.core.IUID;
    import mx.utils.UIDUtil;
    import mx.events.ScrollEvent;
    import mx.events.ScrollEventDirection;
    import mx.events.EffectEvent;
    import mx.effects.Tween;
    import mx.events.TweenEvent;
    import flash.utils.clearInterval;
    import flash.utils.setInterval;
    import mx.events.ScrollEventDetail;
    import mx.events.FlexEvent;
    import mx.core.EdgeMetrics;
    import mx.core.ScrollPolicy;
    import mx.managers.ISystemManager;
    import mx.core.IUITextField;
    import flash.display.Shape;
    import mx.core.FlexShape;
    import flash.display.DisplayObjectContainer;
    import mx.collections.IList;
    import mx.events.CollectionEvent;
    import mx.events.SandboxMouseEvent;
    import mx.core.SpriteAsset;
    import mx.core.IInvalidating;
    import mx.core.FlexVersion;
    import mx.core.EventPriority;
    import mx.styles.StyleProxy;
    import mx.skins.halo.ListDropIndicator;
    import mx.controls.dataGridClasses.DataGridListData;
    import mx.events.CollectionEventKind;
    import mx.collections.errors.CursorError;
    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.collections.XMLListCollection;
    import mx.collections.ItemWrapper;
    import mx.styles.StyleManager;
    import mx.core.DragSource;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListBase extends ScrollControlBase implements IDataRenderer, IFocusManagerComponent, IListItemRenderer, IDropInListItemRenderer, IEffectTargetHost 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static const DRAG_THRESHOLD:int = 4;
        mx_internal static var createAccessibilityImplementation:Function;
        private static var _listContentStyleFilters:Object = null;

        private var _labelField:String = "label";
        mx_internal var bSelectionChanged:Boolean = false;
        protected var offscreenExtraColumnsLeft:int = 0;
        protected var caretItemRenderer:IListItemRenderer;
        protected var actualIterator:IViewCursor;
        protected var iteratorValid:Boolean = true;
        private var bSelectItem:Boolean = false;
        private var _allowMultipleSelection:Boolean = false;
        protected var cachedItemsChangeEffect:IEffect = null;
        private var lastSelectionData:ListBaseSelectionData;
        protected var iterator:IViewCursor;
        protected var rendererChanged:Boolean = false;
        protected var freeItemRenderersByFactory:Dictionary;
        private var columnWidthChanged:Boolean = false;
        protected var explicitColumnCount:int = -1;
        private var _data:Object;
        private var bSelectedItemsChanged:Boolean = false;
        private var selectionDataArray:Array;
        protected var defaultRowCount:int = 4;
        private var _rowCount:int = -1;
        protected var offscreenExtraRowsTop:int = 0;
        private var _dataTipField:String = "label";
        private var cachedPaddingTopInvalid:Boolean = true;
        private var _labelFunction:Function;
        mx_internal var listType:String = "grid";
        private var cachedPaddingBottomInvalid:Boolean = true;
        protected var runningDataEffect:Boolean = false;
        protected var runDataEffectNextUpdate:Boolean = false;
        private var bShiftKey:Boolean = false;
        private var columnCountChanged:Boolean = true;
        mx_internal var _selectedIndex:int = -1;
        mx_internal var collectionIterator:IViewCursor;
        protected var lastDropIndex:int;
        private var bCtrlKey:Boolean = false;
        private var oldUnscaledHeight:Number;
        protected var explicitColumnWidth:Number;
        private var _dataTipFunction:Function;
        private var _iconFunction:Function;
        protected var itemsNeedMeasurement:Boolean = true;
        protected var offscreenExtraRowsBottom:int = 0;
        protected var modifiedCollectionView:ModifiedCollectionView;
        private var _columnCount:int = -1;
        private var rowCountChanged:Boolean = true;
        protected var wordWrapChanged:Boolean = false;
        protected var explicitRowCount:int = -1;
        protected var offscreenExtraRows:int = 0;
        private var _dragEnabled:Boolean = false;
        private var bSortItemPending:Boolean = false;
        protected var caretIndicator:Sprite;
        protected var caretUID:String;
        protected var caretBookmark:CursorBookmark;
        public var allowDragSelection:Boolean = false;
        mx_internal var allowRendererStealingDuringLayout:Boolean = true;
        private var _selectable:Boolean = true;
        protected var listContent:ListBaseContentHolder;
        private var _showDataTips:Boolean = false;
        private var _variableRowHeight:Boolean = false;
        private var cachedVerticalAlignInvalid:Boolean = true;
        private var _dragMoveEnabled:Boolean = false;
        private var _rowHeight:Number;
        private var _selectedItem:Object;
        public var menuSelectionMode:Boolean = false;
        mx_internal var cachedPaddingTop:Number;
        private var _selectedIndices:Array;
        private var _columnWidth:Number;
        protected var defaultColumnCount:int = 4;
        private var rendererTrackingSuspended:Boolean = false;
        private var oldUnscaledWidth:Number;
        private var _nullItemRenderer:IFactory;
        mx_internal var bColumnScrolling:Boolean = true;
        protected var showCaret:Boolean;
        private var firstSelectionData:ListBaseSelectionData;
        private var mouseDownItem:IListItemRenderer;
        protected var collection:ICollectionView;
        protected var offscreenExtraRowsOrColumnsChanged:Boolean = false;
        private var _offscreenExtraRowsOrColumns:int = 0;
        private var _iconField:String = "icon";
        protected var dataEffectCompleted:Boolean = false;
        private var bSelectedItemChanged:Boolean = false;
        private var _listData:BaseListData;
        mx_internal var bSelectOnRelease:Boolean;
        protected var actualCollection:ICollectionView;
        mx_internal var lastHighlightItemRenderer:IListItemRenderer;
        private var _itemRenderer:IFactory;
        mx_internal var itemMaskFreeList:Array;
        protected var keySelectionPending:Boolean = false;
        private var mouseDownPoint:Point;
        protected var highlightUID:String;
        mx_internal var dragScrollingInterval:int = 0;
        protected var anchorBookmark:CursorBookmark;
        protected var caretIndex:int = -1;
        protected var offscreenExtraColumnsRight:int = 0;
        private var _selectedItemsCompareFunction:Function;
        private var approximate:Boolean = false;
        protected var anchorIndex:int = -1;
        private var firstSelectedItem:Object;
        protected var selectionLayer:Sprite;
        mx_internal var bSelectedIndexChanged:Boolean = false;
        mx_internal var cachedVerticalAlign:String;
        private var lastHighlightItemIndices:Point;
        mx_internal var lastHighlightItemRendererAtIndices:IListItemRenderer;
        protected var lastSeekPending:ListBaseSeekPending;
        private var bSelectedIndicesChanged:Boolean = false;
        private var proposedSelectedItemIndexes:Dictionary;
        private var _dropEnabled:Boolean = false;
        protected var itemsSizeChanged:Boolean = false;
        mx_internal var isPressed:Boolean = false;
        mx_internal var cachedPaddingBottom:Number;
        protected var highlightIndicator:Sprite;
        private var verticalScrollPositionPending:Number;
        protected var explicitRowHeight:Number;
        protected var highlightItemRenderer:IListItemRenderer;
        private var rowHeightChanged:Boolean = false;
        mx_internal var lastDragEvent:DragEvent;
        private var _wordWrap:Boolean = false;
        private var horizontalScrollPositionPending:Number;
        mx_internal var dropIndicator:IFlexDisplayObject;
        private var _selectedItems:Array;
        protected var offscreenExtraColumns:int = 0;
        private var lastKey:uint = 0;
        protected var factoryMap:Dictionary;

        private var IS_ITEM_STYLE:Object = {
            "alternatingItemColors":true,
            "backgroundColor":true,
            "backgroundDisabledColor":true,
            "color":true,
            "rollOverColor":true,
            "selectionColor":true,
            "selectionDisabledColor":true,
            "styleName":true,
            "textColor":true,
            "textRollOverColor":true,
            "textSelectedColor":true
        };
        protected var rowMap:Object = {};
        protected var freeItemRenderers:Array = [];
        protected var reservedItemRenderers:Object = {};
        protected var unconstrainedRenderers:Dictionary = new Dictionary();
        protected var dataItemWrappersByRenderer:Dictionary = new Dictionary(true);
        protected var selectedData:Object = {};
        protected var selectionIndicators:Object = {};
        protected var selectionTweens:Object = {};
        private var trackedRenderers:Array = [];

        public function ListBase()
        {
            tabEnabled = true;
            factoryMap = new Dictionary(true);
            addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            addEventListener(MouseEvent.CLICK, mouseClickHandler);
            addEventListener(MouseEvent.DOUBLE_CLICK, mouseDoubleClickHandler);
            invalidateProperties();
        }

        [Bindable("iconFieldChanged")]
        public function get iconField():String
        {
            return (_iconField);
        }

        public function set iconField(_arg_1:String):void
        {
            _iconField = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("iconFieldChanged"));
        }

        mx_internal function getItemUID(_arg_1:Object):String
        {
            return (itemToUID(_arg_1));
        }

        public function measureWidthOfItems(_arg_1:int=-1, _arg_2:int=0):Number
        {
            return (NaN);
        }

        private function terminateSelectionTracking():void
        {
            var _local_2:IListItemRenderer;
            var _local_1:int;
            while (_local_1 < trackedRenderers.length)
            {
                _local_2 = (trackedRenderers[_local_1] as IListItemRenderer);
                _local_2.removeEventListener(MoveEvent.MOVE, rendererMoveHandler);
                _local_1++;
            };
            trackedRenderers = [];
        }

        public function get columnWidth():Number
        {
            return (_columnWidth);
        }

        public function createItemRenderer(_arg_1:Object):IListItemRenderer
        {
            return (null);
        }

        protected function clearSelected(_arg_1:Boolean=false):void
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_4:IListItemRenderer;
            for (_local_2 in selectedData)
            {
                _local_3 = selectedData[_local_2].data;
                removeSelectionData(_local_2);
                _local_4 = UIDToItemRenderer(itemToUID(_local_3));
                if (_local_4)
                {
                    drawItem(_local_4, false, (_local_2 == highlightUID), false, _arg_1);
                };
            };
            clearSelectionData();
            _selectedIndex = -1;
            _selectedItem = null;
            caretIndex = -1;
            anchorIndex = -1;
            caretBookmark = null;
            anchorBookmark = null;
        }

        protected function addToRowArrays():void
        {
            listItems.splice(0, 0, null);
            rowInfo.splice(0, 0, null);
        }

        public function get nullItemRenderer():IFactory
        {
            return (_nullItemRenderer);
        }

        [Bindable("showDataTipsChanged")]
        public function get showDataTips():Boolean
        {
            return (_showDataTips);
        }

        public function set columnWidth(_arg_1:Number):void
        {
            explicitColumnWidth = _arg_1;
            if (_columnWidth != _arg_1)
            {
                setColumnWidth(_arg_1);
                invalidateSize();
                itemsSizeChanged = true;
                invalidateDisplayList();
                dispatchEvent(new Event("columnWidthChanged"));
            };
        }

        protected function scrollHorizontally(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
        }

        protected function drawHighlightIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:Graphics = Sprite(_arg_1).graphics;
            _local_8.clear();
            _local_8.beginFill(_arg_6);
            _local_8.drawRect(0, 0, _arg_4, _arg_5);
            _local_8.endFill();
            _arg_1.x = _arg_2;
            _arg_1.y = _arg_3;
        }

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        override public function get verticalScrollPosition():Number
        {
            if (!isNaN(verticalScrollPositionPending))
            {
                return (verticalScrollPositionPending);
            };
            return (super.verticalScrollPosition);
        }

        protected function drawCaretIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:Graphics = Sprite(_arg_1).graphics;
            _local_8.clear();
            _local_8.lineStyle(1, _arg_6, 1);
            _local_8.drawRect(0, 0, (_arg_4 - 1), (_arg_5 - 1));
            _arg_1.x = _arg_2;
            _arg_1.y = _arg_3;
        }

        private function makeAdditionalRows(rowIndex:int):void
        {
            var cursorPos:CursorBookmark;
            if (iterator)
            {
                cursorPos = iterator.bookmark;
                try
                {
                    iterator.seek(CursorBookmark.CURRENT, listItems.length);
                }
                catch(e:ItemPendingError)
                {
                    lastSeekPending = new ListBaseSeekPending(CursorBookmark.CURRENT, listItems.length);
                    e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                    iteratorValid = false;
                };
            };
            var curY:Number = (rowInfo[rowIndex].y + rowInfo[rowIndex].height);
            makeRowsAndColumns(0, curY, listContent.width, listContent.height, 0, (rowIndex + 1));
            seekPositionIgnoreError(iterator, cursorPos);
        }

        public function set showDataTips(_arg_1:Boolean):void
        {
            _showDataTips = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("showDataTipsChanged"));
        }

        public function set nullItemRenderer(_arg_1:IFactory):void
        {
            _nullItemRenderer = _arg_1;
            invalidateSize();
            invalidateDisplayList();
            itemsSizeChanged = true;
            rendererChanged = true;
            dispatchEvent(new Event("nullItemRendererChanged"));
        }

        protected function moveIndicatorsHorizontally(_arg_1:String, _arg_2:Number):void
        {
            if (_arg_1 != null)
            {
                if (selectionIndicators[_arg_1])
                {
                    selectionIndicators[_arg_1].x = (selectionIndicators[_arg_1].x + _arg_2);
                };
                if (highlightUID == _arg_1)
                {
                    highlightIndicator.x = (highlightIndicator.x + _arg_2);
                };
                if (caretUID == _arg_1)
                {
                    caretIndicator.x = (caretIndicator.x + _arg_2);
                };
            };
        }

        private function seekPreviousSafely(iterator:IViewCursor, pos:int):Boolean
        {
            try
            {
                iterator.movePrevious();
            }
            catch(e:ItemPendingError)
            {
                lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, pos);
                e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                iteratorValid = false;
            };
            return (iteratorValid);
        }

        public function measureHeightOfItems(_arg_1:int=-1, _arg_2:int=0):Number
        {
            return (NaN);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selectedItem():Object
        {
            return (_selectedItem);
        }

        protected function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Point;
            var _local_3:IListItemRenderer;
            var _local_4:DragEvent;
            var _local_5:BaseListData;
            if (((!(enabled)) || (!(selectable))))
            {
                return;
            };
            _local_2 = new Point(_arg_1.localX, _arg_1.localY);
            _local_2 = DisplayObject(_arg_1.target).localToGlobal(_local_2);
            _local_2 = globalToLocal(_local_2);
            if ((((isPressed) && (mouseDownPoint)) && ((Math.abs((mouseDownPoint.x - _local_2.x)) > DRAG_THRESHOLD) || (Math.abs((mouseDownPoint.y - _local_2.y)) > DRAG_THRESHOLD))))
            {
                if ((((dragEnabled) && (!(DragManager.isDragging))) && (mouseDownPoint)))
                {
                    _local_4 = new DragEvent(DragEvent.DRAG_START);
                    _local_4.dragInitiator = this;
                    _local_4.localX = mouseDownPoint.x;
                    _local_4.localY = mouseDownPoint.y;
                    _local_4.buttonDown = true;
                    dispatchEvent(_local_4);
                };
            };
            _local_3 = mouseEventToItemRenderer(_arg_1);
            if (((_local_3) && (highlightItemRenderer)))
            {
                _local_5 = rowMap[_local_3.name];
                if ((((highlightItemRenderer) && (highlightUID)) && (!(_local_5.uid == highlightUID))))
                {
                    if (!isPressed)
                    {
                        if (((getStyle("useRollOver")) && (!(highlightItemRenderer.data == null))))
                        {
                            clearHighlight(highlightItemRenderer);
                        };
                    };
                };
            }
            else
            {
                if (((!(_local_3)) && (highlightItemRenderer)))
                {
                    if (!isPressed)
                    {
                        if (((getStyle("useRollOver")) && (highlightItemRenderer.data)))
                        {
                            clearHighlight(highlightItemRenderer);
                        };
                    };
                };
            };
            if (((_local_3) && (!(highlightItemRenderer))))
            {
                mouseOverHandler(_arg_1);
            };
        }

        public function get selectable():Boolean
        {
            return (_selectable);
        }

        protected function seekPendingFailureHandler(_arg_1:Object, _arg_2:ListBaseSeekPending):void
        {
        }

        override public function set verticalScrollPosition(_arg_1:Number):void
        {
            var _local_5:int;
            var _local_6:Boolean;
            if ((((listItems.length == 0) || (!(dataProvider))) || (!(isNaN(verticalScrollPositionPending)))))
            {
                verticalScrollPositionPending = _arg_1;
                if (dataProvider)
                {
                    invalidateDisplayList();
                };
                return;
            };
            verticalScrollPositionPending = NaN;
            var _local_2:int = super.verticalScrollPosition;
            super.verticalScrollPosition = _arg_1;
            removeClipMask();
            var _local_3:int = offscreenExtraRowsTop;
            var _local_4:int = offscreenExtraRowsBottom;
            if (_local_2 != _arg_1)
            {
                _local_5 = (_arg_1 - _local_2);
                _local_6 = (_local_5 > 0);
                _local_5 = Math.abs(_local_5);
                if (((_local_5 >= (rowInfo.length - offscreenExtraRows)) || (!(iteratorValid))))
                {
                    clearIndicators();
                    clearVisibleData();
                    makeRowsAndColumnsWithExtraRows(oldUnscaledWidth, oldUnscaledHeight);
                }
                else
                {
                    scrollVertically(_arg_1, _local_5, _local_6);
                    adjustListContent(oldUnscaledWidth, oldUnscaledHeight);
                };
                if (variableRowHeight)
                {
                    configureScrollBars();
                };
                drawRowBackgrounds();
            };
            addClipMask(((!(offscreenExtraRowsTop == _local_3)) || (!(offscreenExtraRowsBottom == _local_4))));
        }

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        override public function get horizontalScrollPosition():Number
        {
            if (!isNaN(horizontalScrollPositionPending))
            {
                return (horizontalScrollPositionPending);
            };
            return (super.horizontalScrollPosition);
        }

        protected function itemRendererToIndices(_arg_1:IListItemRenderer):Point
        {
            if (((!(_arg_1)) || (!(_arg_1.name in rowMap))))
            {
                return (null);
            };
            var _local_2:int = rowMap[_arg_1.name].rowIndex;
            var _local_3:int = listItems[_local_2].length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (listItems[_local_2][_local_4] == _arg_1) break;
                _local_4++;
            };
            return (new Point((_local_4 + horizontalScrollPosition), ((_local_2 + verticalScrollPosition) + offscreenExtraRowsTop)));
        }

        private function reduceRows(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:String;
            while (_arg_1 >= 0)
            {
                if (rowInfo[_arg_1].y >= listContent.height)
                {
                    _local_2 = listItems[_arg_1].length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        addToFreeItemRenderers(listItems[_arg_1][_local_3]);
                        _local_3++;
                    };
                    _local_4 = rowInfo[_arg_1].uid;
                    delete visibleData[_local_4];
                    removeIndicators(_local_4);
                    listItems.pop();
                    rowInfo.pop();
                    _arg_1--;
                }
                else
                {
                    return;
                };
            };
        }

        public function get dragMoveEnabled():Boolean
        {
            return (_dragMoveEnabled);
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Point;
            var _local_4:ListEvent;
            if (!selectable)
            {
                return;
            };
            if (!iteratorValid)
            {
                return;
            };
            if (((!(collection)) || (collection.length == 0)))
            {
                return;
            };
            switch (_arg_1.keyCode)
            {
                case Keyboard.UP:
                case Keyboard.DOWN:
                    moveSelectionVertically(_arg_1.keyCode, _arg_1.shiftKey, _arg_1.ctrlKey);
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.LEFT:
                case Keyboard.RIGHT:
                    moveSelectionHorizontally(_arg_1.keyCode, _arg_1.shiftKey, _arg_1.ctrlKey);
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.END:
                case Keyboard.HOME:
                case Keyboard.PAGE_UP:
                case Keyboard.PAGE_DOWN:
                    moveSelectionVertically(_arg_1.keyCode, _arg_1.shiftKey, _arg_1.ctrlKey);
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.SPACE:
                    if ((((!(caretIndex == -1)) && ((caretIndex - verticalScrollPosition) >= 0)) && ((caretIndex - verticalScrollPosition) < listItems.length)))
                    {
                        _local_2 = listItems[(caretIndex - verticalScrollPosition)][0];
                        if (selectItem(_local_2, _arg_1.shiftKey, _arg_1.ctrlKey))
                        {
                            _local_3 = itemRendererToIndices(_local_2);
                            _local_4 = new ListEvent(ListEvent.CHANGE);
                            if (_local_3)
                            {
                                _local_4.columnIndex = _local_3.x;
                                _local_4.rowIndex = _local_3.y;
                            };
                            _local_4.itemRenderer = _local_2;
                            dispatchEvent(_local_4);
                        };
                    };
                    return;
                default:
                    if (findKey(_arg_1.charCode))
                    {
                        _arg_1.stopPropagation();
                    };
            };
        }

        protected function reKeyVisibleData():void
        {
            var _local_2:Object;
            var _local_1:Object = {};
            for each (_local_2 in visibleData)
            {
                if (_local_2.data)
                {
                    _local_1[itemToUID(_local_2.data)] = _local_2;
                };
            };
            listContent.visibleData = _local_1;
        }

        protected function copySelectedItems(_arg_1:Boolean=true):Array
        {
            var _local_2:Array = [];
            var _local_3:ListBaseSelectionData = firstSelectionData;
            while (_local_3 != null)
            {
                if (_arg_1)
                {
                    _local_2.push(_local_3.data);
                }
                else
                {
                    _local_2.push(_local_3.index);
                };
                _local_3 = _local_3.nextSelectionData;
            };
            return (_local_2);
        }

        public function invalidateList():void
        {
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        protected function moveIndicatorsVertically(_arg_1:String, _arg_2:Number):void
        {
            if (_arg_1 != null)
            {
                if (selectionIndicators[_arg_1])
                {
                    selectionIndicators[_arg_1].y = (selectionIndicators[_arg_1].y + _arg_2);
                };
                if (highlightUID == _arg_1)
                {
                    highlightIndicator.y = (highlightIndicator.y + _arg_2);
                };
                if (caretUID == _arg_1)
                {
                    caretIndicator.y = (caretIndicator.y + _arg_2);
                };
            };
        }

        public function indexToItemRenderer(_arg_1:int):IListItemRenderer
        {
            var _local_2:int = (verticalScrollPosition - offscreenExtraRowsTop);
            if (((_arg_1 < _local_2) || (_arg_1 >= (_local_2 + listItems.length))))
            {
                return (null);
            };
            return (listItems[(_arg_1 - _local_2)][0]);
        }

        protected function get dragImage():IUIComponent
        {
            var _local_1:ListItemDragProxy = new ListItemDragProxy();
            _local_1.owner = this;
            _local_1.moduleFactory = moduleFactory;
            return (_local_1);
        }

        protected function copyItemWithUID(_arg_1:Object):Object
        {
            var _local_2:Object;
            _local_2 = ObjectUtil.copy(_arg_1);
            if ((_local_2 is IUID))
            {
                IUID(_local_2).uid = UIDUtil.createUID();
            }
            else
            {
                if (((_local_2 is Object) && ("mx_internal_uid" in _local_2)))
                {
                    _local_2.mx_internal_uid = UIDUtil.createUID();
                };
            };
            return (_local_2);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selectedIndices():Array
        {
            if (bSelectedIndicesChanged)
            {
                return (_selectedIndices);
            };
            return (copySelectedItems(false));
        }

        public function get variableRowHeight():Boolean
        {
            return (_variableRowHeight);
        }

        protected function mouseDoubleClickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Point;
            var _local_4:ListEvent;
            _local_2 = mouseEventToItemRenderer(_arg_1);
            if (!_local_2)
            {
                return;
            };
            _local_3 = itemRendererToIndices(_local_2);
            if (_local_3)
            {
                _local_4 = new ListEvent(ListEvent.ITEM_DOUBLE_CLICK);
                _local_4.columnIndex = _local_3.x;
                _local_4.rowIndex = _local_3.y;
                _local_4.itemRenderer = _local_2;
                dispatchEvent(_local_4);
            };
        }

        mx_internal function selectionDataPendingResultHandler(_arg_1:Object, _arg_2:ListBaseSelectionDataPending):void
        {
            if (_arg_2.bookmark)
            {
                collectionIterator.seek(_arg_2.bookmark, _arg_2.offset);
            };
            setSelectionDataLoop(_arg_2.items, _arg_2.index, _arg_2.useFind);
        }

        public function set selectedItem(_arg_1:Object):void
        {
            if (((!(collection)) || (collection.length == 0)))
            {
                _selectedItem = _arg_1;
                bSelectedItemChanged = true;
                bSelectionChanged = true;
                invalidateDisplayList();
                return;
            };
            commitSelectedItem(_arg_1);
        }

        private function adjustScrollPosition():void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:int;
            var _local_1:Boolean;
            if (!isNaN(horizontalScrollPositionPending))
            {
                _local_1 = true;
                _local_2 = Math.min(horizontalScrollPositionPending, maxHorizontalScrollPosition);
                horizontalScrollPositionPending = NaN;
                super.horizontalScrollPosition = _local_2;
            };
            if (!isNaN(verticalScrollPositionPending))
            {
                _local_1 = true;
                _local_3 = Math.min(verticalScrollPositionPending, maxVerticalScrollPosition);
                verticalScrollPositionPending = NaN;
                super.verticalScrollPosition = _local_3;
            };
            if (_local_1)
            {
                _local_4 = scrollPositionToIndex(horizontalScrollPosition, (verticalScrollPosition - offscreenExtraRowsTop));
                seekPositionSafely(_local_4);
            };
        }

        protected function itemToUID(_arg_1:Object):String
        {
            if (_arg_1 == null)
            {
                return ("null");
            };
            return (UIDUtil.getUID(_arg_1));
        }

        protected function dragEnterHandler(_arg_1:DragEvent):void
        {
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            lastDragEvent = _arg_1;
            if ((((enabled) && (iteratorValid)) && (_arg_1.dragSource.hasFormat("items"))))
            {
                DragManager.acceptDragDrop(this);
                DragManager.showFeedback(((_arg_1.ctrlKey) ? DragManager.COPY : DragManager.MOVE));
                showDropFeedback(_arg_1);
                return;
            };
            hideDropFeedback(_arg_1);
            DragManager.showFeedback(DragManager.NONE);
        }

        protected function indexToColumn(_arg_1:int):int
        {
            return (0);
        }

        public function set selectable(_arg_1:Boolean):void
        {
            _selectable = _arg_1;
        }

        protected function moveRowVertically(_arg_1:int, _arg_2:int, _arg_3:Number):void
        {
            var _local_4:IListItemRenderer;
            var _local_5:int;
            while (_local_5 < _arg_2)
            {
                _local_4 = listItems[_arg_1][_local_5];
                _local_4.move(_local_4.x, (_local_4.y + _arg_3));
                _local_5++;
            };
            rowInfo[_arg_1].y = (rowInfo[_arg_1].y + _arg_3);
        }

        override public function set horizontalScrollPosition(_arg_1:Number):void
        {
            var _local_3:int;
            var _local_4:Boolean;
            if ((((listItems.length == 0) || (!(dataProvider))) || (!(isNaN(horizontalScrollPositionPending)))))
            {
                horizontalScrollPositionPending = _arg_1;
                if (dataProvider)
                {
                    invalidateDisplayList();
                };
                return;
            };
            horizontalScrollPositionPending = NaN;
            var _local_2:int = super.horizontalScrollPosition;
            super.horizontalScrollPosition = _arg_1;
            removeClipMask();
            if (_local_2 != _arg_1)
            {
                if (itemsSizeChanged)
                {
                    return;
                };
                _local_3 = (_arg_1 - _local_2);
                _local_4 = (_local_3 > 0);
                _local_3 = Math.abs(_local_3);
                if (((bColumnScrolling) && (_local_3 >= columnCount)))
                {
                    clearIndicators();
                    clearVisibleData();
                    makeRowsAndColumnsWithExtraColumns(oldUnscaledWidth, oldUnscaledHeight);
                    drawRowBackgrounds();
                }
                else
                {
                    scrollHorizontally(_arg_1, _local_3, _local_4);
                };
            };
            addClipMask(false);
        }

        public function set dragMoveEnabled(_arg_1:Boolean):void
        {
            _dragMoveEnabled = _arg_1;
        }

        public function isItemHighlighted(_arg_1:Object):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_2:Boolean = ((highlightIndicator) && (!(highlightIndicator.parent.getChildIndex(highlightIndicator) == (highlightIndicator.parent.numChildren - 1))));
            if ((_arg_1 is String))
            {
                return ((_arg_1 == highlightUID) && (!(_local_2)));
            };
            return ((itemToUID(_arg_1) == highlightUID) && (!(_local_2)));
        }

        override protected function mouseWheelHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_4:ScrollEvent;
            if (((verticalScrollBar) && (verticalScrollBar.visible)))
            {
                _arg_1.stopPropagation();
                _local_2 = verticalScrollPosition;
                _local_3 = verticalScrollPosition;
                _local_3 = (_local_3 - (_arg_1.delta * verticalScrollBar.lineScrollSize));
                _local_3 = Math.max(0, Math.min(_local_3, verticalScrollBar.maxScrollPosition));
                verticalScrollPosition = _local_3;
                if (_local_2 != verticalScrollPosition)
                {
                    _local_4 = new ScrollEvent(ScrollEvent.SCROLL);
                    _local_4.direction = ScrollEventDirection.VERTICAL;
                    _local_4.position = verticalScrollPosition;
                    _local_4.delta = (verticalScrollPosition - _local_2);
                    dispatchEvent(_local_4);
                };
            };
        }

        protected function restoreRowArrays(_arg_1:int):void
        {
            rowInfo.splice(0, _arg_1);
            listItems.splice(0, _arg_1);
        }

        public function set labelField(_arg_1:String):void
        {
            _labelField = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("labelFieldChanged"));
        }

        private function seekPositionIgnoreError(iterator:IViewCursor, cursorPos:CursorBookmark):void
        {
            if (iterator)
            {
                try
                {
                    iterator.seek(cursorPos, 0);
                }
                catch(e:ItemPendingError)
                {
                };
            };
        }

        protected function finishDataChangeEffect(_arg_1:EffectEvent):void
        {
            collection = actualCollection;
            actualCollection = null;
            modifiedCollectionView = null;
            listContent.iterator = (iterator = actualIterator);
            runningDataEffect = false;
            unconstrainedRenderers = new Dictionary();
            terminateSelectionTracking();
            reKeyVisibleData();
            var _local_2:int = scrollPositionToIndex((horizontalScrollPosition - offscreenExtraColumnsLeft), (verticalScrollPosition - offscreenExtraRowsTop));
            iterator.seek(CursorBookmark.FIRST, _local_2);
            callLater(cleanupAfterDataChangeEffect);
        }

        public function set offscreenExtraRowsOrColumns(_arg_1:int):void
        {
            _arg_1 = Math.max(_arg_1, 0);
            if ((_arg_1 % 2))
            {
                _arg_1++;
            };
            if (_offscreenExtraRowsOrColumns == _arg_1)
            {
                return;
            };
            _offscreenExtraRowsOrColumns = _arg_1;
            offscreenExtraRowsOrColumnsChanged = true;
            invalidateProperties();
        }

        mx_internal function clearHighlight(_arg_1:IListItemRenderer):void
        {
            var _local_4:ListEvent;
            var _local_2:String = itemToUID(_arg_1.data);
            drawItem(UIDToItemRenderer(_local_2), isItemSelected(_arg_1.data), false, (_local_2 == caretUID));
            var _local_3:Point = itemRendererToIndices(_arg_1);
            if (((_local_3) && (lastHighlightItemIndices)))
            {
                _local_4 = new ListEvent(ListEvent.ITEM_ROLL_OUT);
                _local_4.columnIndex = lastHighlightItemIndices.x;
                _local_4.rowIndex = lastHighlightItemIndices.y;
                _local_4.itemRenderer = lastHighlightItemRendererAtIndices;
                dispatchEvent(_local_4);
                lastHighlightItemIndices = null;
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
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("wordWrapChanged"));
        }

        private function shiftSelectionLoop(incr:Boolean, index:int, stopData:Object, transition:Boolean, placeHolder:CursorBookmark):void
        {
            var data:Object;
            var uid:String;
            try
            {
                do 
                {
                    data = iterator.current;
                    uid = itemToUID(data);
                    insertSelectionDataBefore(uid, new ListBaseSelectionData(data, index, approximate), firstSelectionData);
                    if (UIDToItemRenderer(uid))
                    {
                        drawItem(UIDToItemRenderer(uid), true, (uid == highlightUID), false, transition);
                    };
                    if (data === stopData)
                    {
                        if (UIDToItemRenderer(uid))
                        {
                            drawItem(UIDToItemRenderer(uid), true, (uid == highlightUID), true, transition);
                        };
                        break;
                    };
                    if (incr)
                    {
                        index = (index + 1);
                    }
                    else
                    {
                        index = (index - 1);
                    };
                } while (((incr) ? iterator.moveNext() : iterator.movePrevious()));
            }
            catch(e:ItemPendingError)
            {
                e.addResponder(new ItemResponder(selectionPendingResultHandler, selectionPendingFailureHandler, new ListBaseSelectionPending(incr, index, stopData, transition, placeHolder, CursorBookmark.CURRENT, 0)));
                iteratorValid = false;
            };
            try
            {
                iterator.seek(placeHolder, 0);
                if (!iteratorValid)
                {
                    iteratorValid = true;
                    lastSeekPending = null;
                };
            }
            catch(e2:ItemPendingError)
            {
                lastSeekPending = new ListBaseSeekPending(placeHolder, 0);
                e2.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
            };
        }

        protected function clearHighlightIndicator(_arg_1:Sprite, _arg_2:IListItemRenderer):void
        {
            if (highlightIndicator)
            {
                Sprite(highlightIndicator).graphics.clear();
            };
        }

        protected function truncateRowArrays(_arg_1:int):void
        {
            listItems.splice(_arg_1);
            rowInfo.splice(_arg_1);
        }

        public function get itemRenderer():IFactory
        {
            return (_itemRenderer);
        }

        protected function seekPositionSafely(index:int):Boolean
        {
            try
            {
                iterator.seek(CursorBookmark.FIRST, index);
                if (!iteratorValid)
                {
                    iteratorValid = true;
                    lastSeekPending = null;
                };
            }
            catch(e:ItemPendingError)
            {
                lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, index);
                e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                iteratorValid = false;
            };
            return (iteratorValid);
        }

        mx_internal function set $horizontalScrollPosition(_arg_1:Number):void
        {
            var _local_2:int = super.horizontalScrollPosition;
            if (_local_2 != _arg_1)
            {
                super.horizontalScrollPosition = _arg_1;
            };
        }

        protected function applySelectionEffect(_arg_1:Sprite, _arg_2:String, _arg_3:IListItemRenderer):void
        {
            var _local_5:Function;
            var _local_4:Number = getStyle("selectionDuration");
            if (_local_4 != 0)
            {
                _arg_1.alpha = 0;
                selectionTweens[_arg_2] = new Tween(_arg_1, 0, 1, _local_4, 5);
                selectionTweens[_arg_2].addEventListener(TweenEvent.TWEEN_UPDATE, selectionTween_updateHandler);
                selectionTweens[_arg_2].addEventListener(TweenEvent.TWEEN_END, selectionTween_endHandler);
                selectionTweens[_arg_2].setTweenHandlers(onSelectionTweenUpdate, onSelectionTweenUpdate);
                _local_5 = (getStyle("selectionEasingFunction") as Function);
                if (_local_5 != null)
                {
                    selectionTweens[_arg_2].easingFunction = _local_5;
                };
            };
        }

        override public function set showInAutomationHierarchy(_arg_1:Boolean):void
        {
        }

        protected function removeFromRowArrays(_arg_1:int):void
        {
            listItems.splice(_arg_1, 1);
            rowInfo.splice(_arg_1, 1);
        }

        protected function updateList():void
        {
            removeClipMask();
            var _local_1:CursorBookmark = ((iterator) ? iterator.bookmark : null);
            clearIndicators();
            clearVisibleData();
            if (iterator)
            {
                if ((((offscreenExtraColumns) || (offscreenExtraColumnsLeft)) || (offscreenExtraColumnsRight)))
                {
                    makeRowsAndColumnsWithExtraColumns(unscaledWidth, unscaledHeight);
                }
                else
                {
                    makeRowsAndColumnsWithExtraRows(unscaledWidth, unscaledHeight);
                };
                iterator.seek(_local_1, 0);
            }
            else
            {
                makeRowsAndColumns(0, 0, listContent.width, listContent.height, 0, 0);
            };
            drawRowBackgrounds();
            configureScrollBars();
            addClipMask(true);
        }

        public function set variableRowHeight(_arg_1:Boolean):void
        {
            _variableRowHeight = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("variableRowHeightChanged"));
        }

        protected function isRendererUnconstrained(_arg_1:Object):Boolean
        {
            return (!(unconstrainedRenderers[_arg_1] == null));
        }

        public function set selectedIndices(_arg_1:Array):void
        {
            if (((!(collection)) || (collection.length == 0)))
            {
                _selectedIndices = _arg_1;
                bSelectedIndicesChanged = true;
                bSelectionChanged = true;
                invalidateDisplayList();
                return;
            };
            commitSelectedIndices(_arg_1);
        }

        protected function mouseUpHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Point;
            var _local_4:ListEvent;
            mouseDownPoint = null;
            _local_2 = mouseEventToItemRenderer(_arg_1);
            _local_3 = itemRendererToIndices(_local_2);
            mouseIsUp();
            if (((!(enabled)) || (!(selectable))))
            {
                return;
            };
            if (mouseDownItem)
            {
                _local_4 = new ListEvent(ListEvent.CHANGE);
                _local_4.itemRenderer = mouseDownItem;
                _local_3 = itemRendererToIndices(mouseDownItem);
                if (_local_3)
                {
                    _local_4.columnIndex = _local_3.x;
                    _local_4.rowIndex = _local_3.y;
                };
                dispatchEvent(_local_4);
                mouseDownItem = null;
            };
            if (((!(_local_2)) || (!(hitTestPoint(_arg_1.stageX, _arg_1.stageY)))))
            {
                isPressed = false;
                return;
            };
            if (bSelectOnRelease)
            {
                bSelectOnRelease = false;
                if (selectItem(_local_2, _arg_1.shiftKey, _arg_1.ctrlKey))
                {
                    _local_4 = new ListEvent(ListEvent.CHANGE);
                    _local_4.itemRenderer = _local_2;
                    if (_local_3)
                    {
                        _local_4.columnIndex = _local_3.x;
                        _local_4.rowIndex = _local_3.y;
                    };
                    dispatchEvent(_local_4);
                };
            };
            isPressed = false;
        }

        public function get allowMultipleSelection():Boolean
        {
            return (_allowMultipleSelection);
        }

        public function itemToItemRenderer(_arg_1:Object):IListItemRenderer
        {
            return (UIDToItemRenderer(itemToUID(_arg_1)));
        }

        public function isItemSelected(_arg_1:Object):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            if ((_arg_1 is String))
            {
                return (!(selectedData[_arg_1] == undefined));
            };
            return (!(selectedData[itemToUID(_arg_1)] == undefined));
        }

        protected function dragScroll():void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:ScrollEvent;
            var _local_1:Number = 0;
            if (dragScrollingInterval == 0)
            {
                return;
            };
            var _local_6:Number = 30;
            _local_3 = verticalScrollPosition;
            if (DragManager.isDragging)
            {
                _local_1 = (viewMetrics.top + ((variableRowHeight) ? (getStyle("fontSize") / 4) : rowHeight));
            };
            clearInterval(dragScrollingInterval);
            if (mouseY < _local_1)
            {
                verticalScrollPosition = Math.max(0, (_local_3 - 1));
                if (DragManager.isDragging)
                {
                    _local_2 = 100;
                }
                else
                {
                    _local_4 = Math.min(((0 - mouseY) - 30), 0);
                    _local_2 = ((((0.593 * _local_4) * _local_4) + 1) + _local_6);
                };
                dragScrollingInterval = setInterval(dragScroll, _local_2);
                if (_local_3 != verticalScrollPosition)
                {
                    _local_5 = new ScrollEvent(ScrollEvent.SCROLL);
                    _local_5.detail = ScrollEventDetail.THUMB_POSITION;
                    _local_5.direction = ScrollEventDirection.VERTICAL;
                    _local_5.position = verticalScrollPosition;
                    _local_5.delta = (verticalScrollPosition - _local_3);
                    dispatchEvent(_local_5);
                };
            }
            else
            {
                if (mouseY > (unscaledHeight - _local_1))
                {
                    verticalScrollPosition = Math.min(maxVerticalScrollPosition, (verticalScrollPosition + 1));
                    if (DragManager.isDragging)
                    {
                        _local_2 = 100;
                    }
                    else
                    {
                        _local_4 = Math.min(((mouseY - unscaledHeight) - 30), 0);
                        _local_2 = ((((0.593 * _local_4) * _local_4) + 1) + _local_6);
                    };
                    dragScrollingInterval = setInterval(dragScroll, _local_2);
                    if (_local_3 != verticalScrollPosition)
                    {
                        _local_5 = new ScrollEvent(ScrollEvent.SCROLL);
                        _local_5.detail = ScrollEventDetail.THUMB_POSITION;
                        _local_5.direction = ScrollEventDirection.VERTICAL;
                        _local_5.position = verticalScrollPosition;
                        _local_5.delta = (verticalScrollPosition - _local_3);
                        dispatchEvent(_local_5);
                    };
                }
                else
                {
                    dragScrollingInterval = setInterval(dragScroll, 15);
                };
            };
            if ((((DragManager.isDragging) && (lastDragEvent)) && (!(_local_3 == verticalScrollPosition))))
            {
                dragOverHandler(lastDragEvent);
            };
        }

        protected function moveSelectionHorizontally(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
        }

        private function findStringLoop(str:String, cursorPos:CursorBookmark, i:int, stopIndex:int):Boolean
        {
            var itmStr:String;
            var item:IListItemRenderer;
            var pt:Point;
            var evt:ListEvent;
            var more:Boolean;
            while (i != stopIndex)
            {
                itmStr = itemToLabel(iterator.current);
                itmStr = itmStr.substring(0, str.length);
                if (((str == itmStr) || (str.toUpperCase() == itmStr.toUpperCase())))
                {
                    iterator.seek(cursorPos, 0);
                    scrollToIndex(i);
                    commitSelectedIndex(i);
                    item = indexToItemRenderer(i);
                    pt = itemRendererToIndices(item);
                    evt = new ListEvent(ListEvent.CHANGE);
                    evt.itemRenderer = item;
                    if (pt)
                    {
                        evt.columnIndex = pt.x;
                        evt.rowIndex = pt.y;
                    };
                    dispatchEvent(evt);
                    return (true);
                };
                try
                {
                    more = iterator.moveNext();
                }
                catch(e1:ItemPendingError)
                {
                    e1.addResponder(new ItemResponder(findPendingResultHandler, findPendingFailureHandler, new ListBaseFindPending(str, cursorPos, CursorBookmark.CURRENT, 1, (i + 1), stopIndex)));
                    iteratorValid = false;
                    return (false);
                };
                if (((!(more)) && (!(stopIndex == collection.length))))
                {
                    i = -1;
                    try
                    {
                        iterator.seek(CursorBookmark.FIRST, 0);
                    }
                    catch(e2:ItemPendingError)
                    {
                        e2.addResponder(new ItemResponder(findPendingResultHandler, findPendingFailureHandler, new ListBaseFindPending(str, cursorPos, CursorBookmark.FIRST, 0, 0, stopIndex)));
                        iteratorValid = false;
                        return (false);
                    };
                };
                i = (i + 1);
            };
            iterator.seek(cursorPos, 0);
            iteratorValid = true;
            return (false);
        }

        protected function drawRowBackgrounds():void
        {
        }

        private function selectionIndicesPendingResultHandler(_arg_1:Object, _arg_2:ListBaseSelectionDataPending):void
        {
            if (_arg_2.bookmark)
            {
                iterator.seek(_arg_2.bookmark, _arg_2.offset);
            };
            setSelectionIndicesLoop(_arg_2.index, _arg_2.items, _arg_2.useFind);
        }

        public function itemRendererContains(_arg_1:IListItemRenderer, _arg_2:DisplayObject):Boolean
        {
            if (!_arg_2)
            {
                return (false);
            };
            if (!_arg_1)
            {
                return (false);
            };
            return (_arg_1.owns(_arg_2));
        }

        public function removeDataEffectItem(_arg_1:Object):void
        {
            if (modifiedCollectionView)
            {
                modifiedCollectionView.removeItem(dataItemWrappersByRenderer[_arg_1]);
                iterator.seek(CursorBookmark.CURRENT);
                if (invalidateDisplayListFlag)
                {
                    callLater(invalidateList);
                }
                else
                {
                    invalidateList();
                };
            };
        }

        public function itemRendererToIndex(_arg_1:IListItemRenderer):int
        {
            var _local_2:int;
            if ((_arg_1.name in rowMap))
            {
                _local_2 = rowMap[_arg_1.name].rowIndex;
                return ((_local_2 + verticalScrollPosition) - offscreenExtraRowsTop);
            };
            return (int.MIN_VALUE);
        }

        override public function set horizontalScrollPolicy(_arg_1:String):void
        {
            super.horizontalScrollPolicy = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        public function get dropEnabled():Boolean
        {
            return (_dropEnabled);
        }

        private function setSelectionIndicesLoop(index:int, indices:Array, firstTime:Boolean=false):void
        {
            var data:Object;
            var uid:String;
            while (indices.length)
            {
                if (index != indices[0])
                {
                    try
                    {
                        collectionIterator.seek(CursorBookmark.CURRENT, (indices[0] - index));
                    }
                    catch(e:ItemPendingError)
                    {
                        e.addResponder(new ItemResponder(selectionIndicesPendingResultHandler, selectionIndicesPendingFailureHandler, new ListBaseSelectionDataPending(firstTime, index, indices, CursorBookmark.CURRENT, (indices[0] - index))));
                        return;
                    };
                };
                index = indices[0];
                indices.shift();
                data = collectionIterator.current;
                if (firstTime)
                {
                    _selectedIndex = index;
                    _selectedItem = data;
                    caretIndex = index;
                    caretBookmark = collectionIterator.bookmark;
                    anchorIndex = index;
                    anchorBookmark = collectionIterator.bookmark;
                    firstTime = false;
                };
                uid = itemToUID(data);
                insertSelectionDataAfter(uid, new ListBaseSelectionData(data, index, false), lastSelectionData);
                if (UIDToItemRenderer(uid))
                {
                    drawItem(UIDToItemRenderer(uid), true, (uid == highlightUID), (caretIndex == index));
                };
            };
            if (initialized)
            {
                updateList();
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        override protected function measure():void
        {
            super.measure();
            var _local_1:EdgeMetrics = viewMetrics;
            var _local_2:int = ((explicitColumnCount < 1) ? defaultColumnCount : explicitColumnCount);
            var _local_3:int = ((explicitRowCount < 1) ? defaultRowCount : explicitRowCount);
            if (!isNaN(explicitRowHeight))
            {
                measuredHeight = (((explicitRowHeight * _local_3) + _local_1.top) + _local_1.bottom);
                measuredMinHeight = (((explicitRowHeight * Math.min(_local_3, 2)) + _local_1.top) + _local_1.bottom);
            }
            else
            {
                measuredHeight = (((rowHeight * _local_3) + _local_1.top) + _local_1.bottom);
                measuredMinHeight = (((rowHeight * Math.min(_local_3, 2)) + _local_1.top) + _local_1.bottom);
            };
            if (!isNaN(explicitColumnWidth))
            {
                measuredWidth = (((explicitColumnWidth * _local_2) + _local_1.left) + _local_1.right);
                measuredMinWidth = (((explicitColumnWidth * Math.min(_local_2, 1)) + _local_1.left) + _local_1.right);
            }
            else
            {
                measuredWidth = (((columnWidth * _local_2) + _local_1.left) + _local_1.right);
                measuredMinWidth = (((columnWidth * Math.min(_local_2, 1)) + _local_1.left) + _local_1.right);
            };
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

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        private function removeSelectionData(_arg_1:String):void
        {
            var _local_2:ListBaseSelectionData = selectedData[_arg_1];
            if (firstSelectionData == _local_2)
            {
                firstSelectionData = _local_2.nextSelectionData;
            };
            if (lastSelectionData == _local_2)
            {
                lastSelectionData = _local_2.prevSelectionData;
            };
            if (_local_2.prevSelectionData != null)
            {
                _local_2.prevSelectionData.nextSelectionData = _local_2.nextSelectionData;
            };
            if (_local_2.nextSelectionData != null)
            {
                _local_2.nextSelectionData.prevSelectionData = _local_2.prevSelectionData;
            };
            delete selectedData[_arg_1];
        }

        protected function setRowHeight(_arg_1:Number):void
        {
            _rowHeight = _arg_1;
        }

        public function indicesToIndex(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 * columnCount) + _arg_2);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get value():Object
        {
            var _local_1:Object = selectedItem;
            if (!_local_1)
            {
                return (null);
            };
            if (typeof(_local_1) != "object")
            {
                return (_local_1);
            };
            return ((_local_1.data != null) ? _local_1.data : _local_1.label);
        }

        mx_internal function getRowInfo():Array
        {
            return (rowInfo);
        }

        private function rendererMoveHandler(_arg_1:MoveEvent):void
        {
            var _local_2:IListItemRenderer;
            if (!rendererTrackingSuspended)
            {
                _local_2 = (_arg_1.currentTarget as IListItemRenderer);
                drawItem(_local_2, true);
            };
        }

        protected function calculateDropIndicatorY(_arg_1:Number, _arg_2:int):Number
        {
            var _local_3:int;
            var _local_4:Number = 0;
            if (((((_arg_1) && (_arg_2 < _arg_1)) && (listItems[_arg_2].length)) && (listItems[_arg_2][0])))
            {
                return (listItems[_arg_2][0].y - 1);
            };
            _local_3 = 0;
            while (_local_3 < _arg_1)
            {
                if (listItems[_local_3].length)
                {
                    _local_4 = (_local_4 + rowInfo[_local_3].height);
                }
                else
                {
                    break;
                };
                _local_3++;
            };
            return (_local_4);
        }

        protected function clearCaretIndicator(_arg_1:Sprite, _arg_2:IListItemRenderer):void
        {
            if (caretIndicator)
            {
                Sprite(caretIndicator).graphics.clear();
            };
        }

        override public function validateDisplayList():void
        {
            var _local_1:ISystemManager;
            if (invalidateDisplayListFlag)
            {
                _local_1 = (parent as ISystemManager);
                if (_local_1)
                {
                    if (((_local_1 == systemManager.topLevelSystemManager) && (!(_local_1.document == this))))
                    {
                        setActualSize(getExplicitOrMeasuredWidth(), getExplicitOrMeasuredHeight());
                    };
                };
                if (runDataEffectNextUpdate)
                {
                    runDataEffectNextUpdate = false;
                    runningDataEffect = true;
                    initiateDataChangeEffect(((scaleX == 0) ? 0 : (width / scaleX)), ((scaleY == 0) ? 0 : (height / scaleY)));
                }
                else
                {
                    updateDisplayList(((scaleX == 0) ? 0 : (width / scaleX)), ((scaleY == 0) ? 0 : (height / scaleY)));
                };
                invalidateDisplayListFlag = false;
            };
        }

        mx_internal function getListVisibleData():Object
        {
            return (visibleData);
        }

        public function getRendererSemanticValue(_arg_1:Object, _arg_2:String):Object
        {
            return (modifiedCollectionView.getSemantics(dataItemWrappersByRenderer[_arg_1]) == _arg_2);
        }

        mx_internal function setColumnCount(_arg_1:int):void
        {
            _columnCount = _arg_1;
        }

        mx_internal function hasOnlyTextRenderers():Boolean
        {
            if (listItems.length == 0)
            {
                return (true);
            };
            var _local_1:Array = listItems[(listItems.length - 1)];
            var _local_2:int = _local_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (!(_local_1[_local_3] is IUITextField))
                {
                    return (false);
                };
                _local_3++;
            };
            return (true);
        }

        protected function sumRowHeights(_arg_1:int, _arg_2:int):Number
        {
            var _local_3:Number = 0;
            var _local_4:int = _arg_1;
            while (_local_4 <= _arg_2)
            {
                _local_3 = (_local_3 + rowInfo[_local_4].height);
                _local_4++;
            };
            return (_local_3);
        }

        protected function get rowInfo():Array
        {
            return (listContent.rowInfo);
        }

        private function selectionPendingFailureHandler(_arg_1:Object, _arg_2:ListBaseSelectionPending):void
        {
        }

        mx_internal function convertIndexToColumn(_arg_1:int):int
        {
            return (indexToColumn(_arg_1));
        }

        mx_internal function createItemMask(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:DisplayObjectContainer=null):DisplayObject
        {
            var _local_6:Shape;
            var _local_7:Graphics;
            if (!itemMaskFreeList)
            {
                itemMaskFreeList = [];
            };
            if (itemMaskFreeList.length > 0)
            {
                _local_6 = itemMaskFreeList.pop();
                if (_local_6.width != _arg_3)
                {
                    _local_6.width = _arg_3;
                };
                if (_local_6.height != _arg_4)
                {
                    _local_6.height = _arg_4;
                };
            }
            else
            {
                _local_6 = new FlexShape();
                _local_6.name = "mask";
                _local_7 = _local_6.graphics;
                _local_7.beginFill(0xFFFFFF);
                _local_7.drawRect(0, 0, _arg_3, _arg_4);
                _local_7.endFill();
                _local_6.visible = false;
                if (_arg_5)
                {
                    _arg_5.addChild(_local_6);
                }
                else
                {
                    listContent.addChild(_local_6);
                };
            };
            if (_local_6.x != _arg_1)
            {
                _local_6.x = _arg_1;
            };
            if (_local_6.y != _arg_2)
            {
                _local_6.y = _arg_2;
            };
            return (_local_6);
        }

        mx_internal function convertIndexToRow(_arg_1:int):int
        {
            return (indexToRow(_arg_1));
        }

        protected function get listItems():Array
        {
            return ((listContent) ? listContent.listItems : []);
        }

        override protected function commitProperties():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            super.commitProperties();
            if (((listContent) && (!(listContent.iterator == iterator))))
            {
                listContent.iterator = iterator;
            };
            if (cachedPaddingTopInvalid)
            {
                cachedPaddingTopInvalid = false;
                cachedPaddingTop = getStyle("paddingTop");
                itemsSizeChanged = true;
                invalidateDisplayList();
            };
            if (cachedPaddingBottomInvalid)
            {
                cachedPaddingBottomInvalid = false;
                cachedPaddingBottom = getStyle("paddingBottom");
                itemsSizeChanged = true;
                invalidateDisplayList();
            };
            if (cachedVerticalAlignInvalid)
            {
                cachedVerticalAlignInvalid = false;
                cachedVerticalAlign = getStyle("verticalAlign");
                itemsSizeChanged = true;
                invalidateDisplayList();
            };
            if (columnCountChanged)
            {
                if (_columnCount < 1)
                {
                    _columnCount = defaultColumnCount;
                };
                if ((((!(isNaN(explicitWidth))) && (isNaN(explicitColumnWidth))) && (explicitColumnCount > 0)))
                {
                    setColumnWidth((((explicitWidth - viewMetrics.left) - viewMetrics.right) / columnCount));
                };
                columnCountChanged = false;
            };
            if (rowCountChanged)
            {
                if (_rowCount < 1)
                {
                    _rowCount = defaultRowCount;
                };
                if ((((!(isNaN(explicitHeight))) && (isNaN(explicitRowHeight))) && (explicitRowCount > 0)))
                {
                    setRowHeight((((explicitHeight - viewMetrics.top) - viewMetrics.bottom) / rowCount));
                };
                rowCountChanged = false;
            };
            if (offscreenExtraRowsOrColumnsChanged)
            {
                adjustOffscreenRowsAndColumns();
                if (iterator)
                {
                    _local_1 = int(Math.min((offscreenExtraColumns / 2), horizontalScrollPosition));
                    _local_2 = int(Math.min((offscreenExtraRows / 2), verticalScrollPosition));
                    _local_3 = scrollPositionToIndex((horizontalScrollPosition - _local_1), (verticalScrollPosition - _local_2));
                    seekPositionSafely(_local_3);
                    invalidateList();
                };
                offscreenExtraRowsOrColumnsChanged = false;
            };
        }

        protected function setRowCount(_arg_1:int):void
        {
            _rowCount = _arg_1;
        }

        public function set labelFunction(_arg_1:Function):void
        {
            _labelFunction = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("labelFunctionChanged"));
        }

        protected function adjustAfterAdd(items:Array, location:int):Boolean
        {
            var length:int;
            var requiresValueCommit:Boolean;
            var data:ListBaseSelectionData;
            var placeHolder:CursorBookmark;
            var p:String;
            length = items.length;
            requiresValueCommit = false;
            for (p in selectedData)
            {
                data = selectedData[p];
                if (data.index >= location)
                {
                    data.index = (data.index + length);
                };
            };
            if (_selectedIndex >= location)
            {
                _selectedIndex = (_selectedIndex + length);
                requiresValueCommit = true;
            };
            if (anchorIndex >= location)
            {
                anchorIndex = (anchorIndex + length);
                placeHolder = iterator.bookmark;
                try
                {
                    iterator.seek(CursorBookmark.FIRST, anchorIndex);
                    anchorBookmark = iterator.bookmark;
                }
                catch(e:ItemPendingError)
                {
                    e.addResponder(new ItemResponder(setBookmarkPendingResultHandler, setBookmarkPendingFailureHandler, {
                        "property":"anchorBookmark",
                        "value":anchorIndex
                    }));
                };
                iterator.seek(placeHolder);
            };
            if (caretIndex >= location)
            {
                caretIndex = (caretIndex + length);
                placeHolder = iterator.bookmark;
                try
                {
                    iterator.seek(CursorBookmark.FIRST, caretIndex);
                    caretBookmark = iterator.bookmark;
                }
                catch(e:ItemPendingError)
                {
                    e.addResponder(new ItemResponder(setBookmarkPendingResultHandler, setBookmarkPendingFailureHandler, {
                        "property":"caretBookmark",
                        "value":caretIndex
                    }));
                };
                iterator.seek(placeHolder);
            };
            return (requiresValueCommit);
        }

        private function mouseLeaveHandler(_arg_1:Event):void
        {
            var _local_2:ListEvent;
            var _local_3:Point;
            mouseDownPoint = null;
            mouseIsUp();
            if (((!(enabled)) || (!(selectable))))
            {
                return;
            };
            if (mouseDownItem)
            {
                _local_2 = new ListEvent(ListEvent.CHANGE);
                _local_2.itemRenderer = mouseDownItem;
                _local_3 = itemRendererToIndices(mouseDownItem);
                if (_local_3)
                {
                    _local_2.columnIndex = _local_3.x;
                    _local_2.rowIndex = _local_3.y;
                };
                dispatchEvent(_local_2);
                mouseDownItem = null;
            };
            isPressed = false;
        }

        public function unconstrainRenderer(_arg_1:Object):void
        {
            unconstrainedRenderers[_arg_1] = true;
        }

        mx_internal function getIterator():IViewCursor
        {
            return (iterator);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selectedItems():Array
        {
            return ((bSelectedItemsChanged) ? _selectedItems : copySelectedItems());
        }

        protected function findKey(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
            return (((_local_2 >= 33) && (_local_2 <= 126)) && (findString(String.fromCharCode(_local_2))));
        }

        override public function set verticalScrollPolicy(_arg_1:String):void
        {
            super.verticalScrollPolicy = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        public function set selectedIndex(_arg_1:int):void
        {
            if (((!(collection)) || (collection.length == 0)))
            {
                _selectedIndex = _arg_1;
                bSelectionChanged = true;
                bSelectedIndexChanged = true;
                invalidateDisplayList();
                return;
            };
            commitSelectedIndex(_arg_1);
        }

        public function set itemRenderer(_arg_1:IFactory):void
        {
            _itemRenderer = _arg_1;
            invalidateSize();
            invalidateDisplayList();
            itemsSizeChanged = true;
            rendererChanged = true;
            dispatchEvent(new Event("itemRendererChanged"));
        }

        public function hideDropFeedback(_arg_1:DragEvent):void
        {
            if (dropIndicator)
            {
                DisplayObject(dropIndicator).parent.removeChild(DisplayObject(dropIndicator));
                dropIndicator = null;
                drawFocus(false);
            };
        }

        private function commitSelectedItems(items:Array):void
        {
            var useFind:Boolean;
            var uid:String;
            clearSelected();
            items = items.slice();
            useFind = (!(collection.sort == null));
            try
            {
                collectionIterator.seek(CursorBookmark.FIRST, 0);
            }
            catch(e:ItemPendingError)
            {
                e.addResponder(new ItemResponder(selectionDataPendingResultHandler, selectionDataPendingFailureHandler, new ListBaseSelectionDataPending(useFind, 0, items, null, 0)));
                return;
            };
            var n:int = items.length;
            selectionDataArray = new Array(n);
            firstSelectedItem = ((n) ? items[0] : null);
            proposedSelectedItemIndexes = new Dictionary();
            var i:int;
            while (i < n)
            {
                uid = itemToUID(items[i]);
                proposedSelectedItemIndexes[uid] = i;
                i = (i + 1);
            };
            setSelectionDataLoop(items, 0, useFind);
        }

        public function set dataTipField(_arg_1:String):void
        {
            _dataTipField = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("dataTipFieldChanged"));
        }

        private function makeRowsAndColumnsWithExtraColumns(_arg_1:Number, _arg_2:Number):void
        {
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_3:int = int((offscreenExtraColumns / 2));
            var _local_4:int = int((offscreenExtraColumns / 2));
            if (horizontalScrollPosition > (collection.length - columnCount))
            {
                super.horizontalScrollPosition = Math.max(0, (collection.length - columnCount));
            };
            offscreenExtraColumnsLeft = Math.min(_local_3, horizontalScrollPosition);
            var _local_5:int = scrollPositionToIndex((horizontalScrollPosition - offscreenExtraColumnsLeft), verticalScrollPosition);
            seekPositionSafely(_local_5);
            var _local_6:CursorBookmark = iterator.bookmark;
            if (offscreenExtraColumnsLeft > 0)
            {
                makeRowsAndColumns(0, 0, 0, listContent.height, 0, 0, true, offscreenExtraColumnsLeft);
            };
            var _local_7:Number = ((offscreenExtraColumnsLeft) ? (listItems[0][(offscreenExtraColumnsLeft - 1)].x + columnWidth) : 0);
            var _local_8:Point = makeRowsAndColumns(_local_7, 0, (_local_7 + listContent.widthExcludingOffsets), listContent.height, offscreenExtraColumnsLeft, 0);
            if (((_local_4 > 0) && (!(iterator.afterLast))))
            {
                if (((offscreenExtraColumnsLeft + _local_8.x) - 1) < 0)
                {
                    _local_7 = 0;
                }
                else
                {
                    _local_7 = (listItems[0][((offscreenExtraColumnsLeft + _local_8.x) - 1)].x + columnWidth);
                };
                _local_10 = listItems[0].length;
                _local_8 = makeRowsAndColumns(_local_7, 0, _local_7, listContent.height, (offscreenExtraColumnsLeft + _local_8.x), 0, true, _local_4);
                if (_local_8.x < _local_4)
                {
                    _local_11 = (listItems[0].length - (_local_10 + _local_8.x));
                    if (_local_11)
                    {
                        _local_12 = 0;
                        while (_local_12 < listItems.length)
                        {
                            _local_13 = 0;
                            while (_local_13 < _local_11)
                            {
                                listItems[_local_12].pop();
                                _local_13++;
                            };
                            _local_12++;
                        };
                    };
                };
                offscreenExtraColumnsRight = _local_8.x;
            }
            else
            {
                offscreenExtraColumnsRight = 0;
            };
            var _local_9:Number = listContent.widthExcludingOffsets;
            listContent.leftOffset = (-(offscreenExtraColumnsLeft) * columnWidth);
            listContent.rightOffset = ((offscreenExtraColumnsRight > 0) ? (((listItems[0][(listItems[0].length - 1)].x + columnWidth) - _local_9) + listContent.leftOffset) : 0);
            iterator.seek(_local_6, 0);
            adjustListContent(_arg_1, _arg_2);
        }

        protected function dragOverHandler(_arg_1:DragEvent):void
        {
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            lastDragEvent = _arg_1;
            if ((((enabled) && (iteratorValid)) && (_arg_1.dragSource.hasFormat("items"))))
            {
                DragManager.showFeedback(((_arg_1.ctrlKey) ? DragManager.COPY : DragManager.MOVE));
                showDropFeedback(_arg_1);
                return;
            };
            hideDropFeedback(_arg_1);
            DragManager.showFeedback(DragManager.NONE);
        }

        private function adjustSelectionSettings(_arg_1:Boolean):void
        {
            if (bSelectionChanged)
            {
                bSelectionChanged = false;
                if (((bSelectedIndicesChanged) && ((_arg_1) || (_selectedIndices == null))))
                {
                    bSelectedIndicesChanged = false;
                    bSelectedIndexChanged = false;
                    commitSelectedIndices(_selectedIndices);
                };
                if (((bSelectedItemChanged) && ((_arg_1) || (_selectedItem == null))))
                {
                    bSelectedItemChanged = false;
                    bSelectedIndexChanged = false;
                    commitSelectedItem(_selectedItem);
                };
                if (((bSelectedItemsChanged) && ((_arg_1) || (_selectedItems == null))))
                {
                    bSelectedItemsChanged = false;
                    bSelectedIndexChanged = false;
                    commitSelectedItems(_selectedItems);
                };
                if (((bSelectedIndexChanged) && ((_arg_1) || (_selectedIndex == -1))))
                {
                    commitSelectedIndex(_selectedIndex);
                    bSelectedIndexChanged = false;
                };
            };
        }

        private function clearSelectionData():void
        {
            selectedData = {};
            firstSelectionData = null;
            lastSelectionData = null;
        }

        protected function shiftRow(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean):void
        {
            var _local_5:IListItemRenderer;
            var _local_6:int;
            while (_local_6 < _arg_3)
            {
                _local_5 = listItems[_arg_1][_local_6];
                if (_arg_4)
                {
                    listItems[_arg_2][_local_6] = _local_5;
                    rowMap[_local_5.name].rowIndex = _arg_2;
                }
                else
                {
                    rowMap[_local_5.name].rowIndex = _arg_1;
                };
                _local_6++;
            };
            if (_arg_4)
            {
                rowInfo[_arg_2] = rowInfo[_arg_1];
            };
        }

        mx_internal function selectionTween_endHandler(_arg_1:TweenEvent):void
        {
            selectionTween_updateHandler(_arg_1);
        }

        mx_internal function resetDragScrolling():void
        {
            if (dragScrollingInterval != 0)
            {
                clearInterval(dragScrollingInterval);
                dragScrollingInterval = 0;
            };
        }

        protected function mouseOverHandler(_arg_1:MouseEvent):void
        {
            var _local_2:ListEvent;
            var _local_3:IListItemRenderer;
            var _local_4:Point;
            var _local_5:String;
            var _local_6:String;
            var _local_7:BaseListData;
            if (((!(enabled)) || (!(selectable))))
            {
                return;
            };
            if (((!(dragScrollingInterval == 0)) && (!(_arg_1.buttonDown))))
            {
                mouseIsUp();
            };
            isPressed = _arg_1.buttonDown;
            _local_3 = mouseEventToItemRenderer(_arg_1);
            _local_4 = itemRendererToIndices(_local_3);
            if (!_local_3)
            {
                return;
            };
            _local_5 = itemToUID(_local_3.data);
            if (((!(isPressed)) || (allowDragSelection)))
            {
                if (_arg_1.relatedObject)
                {
                    if (((lastHighlightItemRenderer) && (highlightUID)))
                    {
                        _local_7 = rowMap[_local_3.name];
                        _local_6 = _local_7.uid;
                    };
                    if ((((itemRendererContains(_local_3, _arg_1.relatedObject)) || (_local_5 == _local_6)) || (_arg_1.relatedObject == highlightIndicator)))
                    {
                        return;
                    };
                };
                if (((getStyle("useRollOver")) && (!(_local_3.data == null))))
                {
                    if (allowDragSelection)
                    {
                        bSelectOnRelease = true;
                    };
                    drawItem(UIDToItemRenderer(_local_5), isItemSelected(_local_3.data), true, (_local_5 == caretUID));
                    if (_local_4)
                    {
                        _local_2 = new ListEvent(ListEvent.ITEM_ROLL_OVER);
                        _local_2.columnIndex = _local_4.x;
                        _local_2.rowIndex = _local_4.y;
                        _local_2.itemRenderer = _local_3;
                        dispatchEvent(_local_2);
                        lastHighlightItemIndices = _local_4;
                        lastHighlightItemRendererAtIndices = _local_3;
                    };
                };
            }
            else
            {
                if (DragManager.isDragging)
                {
                    return;
                };
                if ((((!(dragScrollingInterval == 0)) && (allowDragSelection)) || (menuSelectionMode)))
                {
                    if (selectItem(_local_3, _arg_1.shiftKey, _arg_1.ctrlKey))
                    {
                        _local_2 = new ListEvent(ListEvent.CHANGE);
                        _local_2.itemRenderer = _local_3;
                        if (_local_4)
                        {
                            _local_2.columnIndex = _local_4.x;
                            _local_2.rowIndex = _local_4.y;
                        };
                        dispatchEvent(_local_2);
                    };
                };
            };
        }

        protected function mouseClickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Point;
            var _local_4:ListEvent;
            _local_2 = mouseEventToItemRenderer(_arg_1);
            if (!_local_2)
            {
                return;
            };
            _local_3 = itemRendererToIndices(_local_2);
            if (_local_3)
            {
                _local_4 = new ListEvent(ListEvent.ITEM_CLICK);
                _local_4.columnIndex = _local_3.x;
                _local_4.rowIndex = _local_3.y;
                _local_4.itemRenderer = _local_2;
                dispatchEvent(_local_4);
            };
        }

        private function selectionIndicesPendingFailureHandler(_arg_1:Object, _arg_2:ListBaseSelectionDataPending):void
        {
        }

        protected function finishKeySelection():void
        {
            var _local_1:String;
            var _local_5:IListItemRenderer;
            var _local_7:Point;
            var _local_8:ListEvent;
            var _local_2:int = listItems.length;
            var _local_3:int = ((listItems.length - offscreenExtraRowsTop) - offscreenExtraRowsBottom);
            var _local_4:int = (((rowInfo[((_local_2 - offscreenExtraRowsBottom) - 1)].y + rowInfo[((_local_2 - offscreenExtraRowsBottom) - 1)].height) > (listContent.heightExcludingOffsets - listContent.topOffset)) ? 1 : 0);
            if (lastKey == Keyboard.PAGE_DOWN)
            {
                if ((_local_3 - _local_4) == 0)
                {
                    caretIndex = Math.min(((verticalScrollPosition + _local_3) - _local_4), (collection.length - 1));
                }
                else
                {
                    caretIndex = Math.min((((verticalScrollPosition + _local_3) - _local_4) - 1), (collection.length - 1));
                };
            };
            var _local_6:Boolean;
            if (((bSelectItem) && ((caretIndex - verticalScrollPosition) >= 0)))
            {
                if ((caretIndex - verticalScrollPosition) > Math.max(((_local_3 - _local_4) - 1), 0))
                {
                    if (((lastKey == Keyboard.END) && (maxVerticalScrollPosition > verticalScrollPosition)))
                    {
                        caretIndex = (caretIndex - 1);
                        moveSelectionVertically(lastKey, bShiftKey, bCtrlKey);
                        return;
                    };
                    caretIndex = (((_local_3 - _local_4) - 1) + verticalScrollPosition);
                };
                _local_5 = listItems[((caretIndex - verticalScrollPosition) + offscreenExtraRowsTop)][0];
                if (_local_5)
                {
                    _local_1 = itemToUID(_local_5.data);
                    _local_5 = UIDToItemRenderer(_local_1);
                    if (((!(bCtrlKey)) || (lastKey == Keyboard.SPACE)))
                    {
                        selectItem(_local_5, bShiftKey, bCtrlKey);
                        _local_6 = true;
                    };
                    if (bCtrlKey)
                    {
                        drawItem(_local_5, (!(selectedData[_local_1] == null)), (_local_1 == highlightUID), true);
                    };
                };
            };
            if (_local_6)
            {
                _local_7 = itemRendererToIndices(_local_5);
                _local_8 = new ListEvent(ListEvent.CHANGE);
                if (_local_7)
                {
                    _local_8.columnIndex = _local_7.x;
                    _local_8.rowIndex = _local_7.y;
                };
                _local_8.itemRenderer = _local_5;
                dispatchEvent(_local_8);
            };
        }

        private function selectionDataPendingFailureHandler(_arg_1:Object, _arg_2:ListBaseSelectionDataPending):void
        {
        }

        mx_internal function addClipMask(_arg_1:Boolean):void
        {
            var _local_10:DisplayObject;
            var _local_11:Number;
            if (_arg_1)
            {
                if (((((((((horizontalScrollBar) && (horizontalScrollBar.visible)) || (hasOnlyTextRenderers())) || (runningDataEffect)) || (!(listContent.bottomOffset == 0))) || (!(listContent.topOffset == 0))) || (!(listContent.leftOffset == 0))) || (!(listContent.rightOffset == 0))))
                {
                    listContent.mask = maskShape;
                    selectionLayer.mask = null;
                }
                else
                {
                    listContent.mask = null;
                    selectionLayer.mask = maskShape;
                };
            };
            if (listContent.mask)
            {
                return;
            };
            var _local_2:int = (listItems.length - 1);
            var _local_3:ListRowInfo = rowInfo[_local_2];
            var _local_4:Array = listItems[_local_2];
            if ((_local_3.y + _local_3.height) <= listContent.height)
            {
                return;
            };
            var _local_5:int = _local_4.length;
            var _local_6:Number = _local_3.y;
            var _local_7:Number = listContent.width;
            var _local_8:Number = (listContent.height - _local_3.y);
            var _local_9:int;
            while (_local_9 < _local_5)
            {
                _local_10 = _local_4[_local_9];
                _local_11 = (_local_10.y - _local_6);
                if ((_local_10 is IUITextField))
                {
                    _local_10.height = (_local_8 - _local_11);
                }
                else
                {
                    _local_10.mask = createItemMask(0, (_local_6 + _local_11), _local_7, (_local_8 - _local_11));
                };
                _local_9++;
            };
        }

        public function set allowMultipleSelection(_arg_1:Boolean):void
        {
            _allowMultipleSelection = _arg_1;
        }

        protected function scrollVertically(pos:int, deltaPos:int, scrollUp:Boolean):void
        {
            var i:int;
            var j:int;
            var numRows:int;
            var numCols:int;
            var uid:String;
            var curY:Number;
            var cursorPos:CursorBookmark;
            var discardRows:int;
            var desiredoffscreenExtraRowsTop:int;
            var newoffscreenExtraRowsTop:int;
            var offscreenExtraRowsBottomToMake:int;
            var newTopOffset:Number;
            var fillHeight:Number;
            var pt:Point;
            var rowIdx:int;
            var modDeltaPos:int;
            var desiredPrefixItems:int;
            var actual:Point;
            var row:Array;
            var rowData:Object;
            var desiredSuffixItems:int;
            var newOffscreenRows:int;
            var visibleAreaBottomY:int;
            var rowCount:int = rowInfo.length;
            var columnCount:int = listItems[0].length;
            var moveBlockDistance:Number = 0;
            var listContentVisibleHeight:Number = listContent.heightExcludingOffsets;
            if (scrollUp)
            {
                discardRows = deltaPos;
                desiredoffscreenExtraRowsTop = int((offscreenExtraRows / 2));
                newoffscreenExtraRowsTop = Math.min(desiredoffscreenExtraRowsTop, (offscreenExtraRowsTop + deltaPos));
                if (offscreenExtraRowsTop < desiredoffscreenExtraRowsTop)
                {
                    discardRows = Math.max(0, (deltaPos - (desiredoffscreenExtraRowsTop - offscreenExtraRowsTop)));
                };
                moveBlockDistance = sumRowHeights(0, (discardRows - 1));
                i = 0;
                while (i < discardRows)
                {
                    if (!seekNextSafely(iterator, pos))
                    {
                        return;
                    };
                    i = (i + 1);
                };
                i = 0;
                while (i < rowCount)
                {
                    numCols = listItems[i].length;
                    if (i < discardRows)
                    {
                        destroyRow(i, numCols);
                    }
                    else
                    {
                        if (discardRows > 0)
                        {
                            moveRowVertically(i, numCols, -(moveBlockDistance));
                            moveIndicatorsVertically(rowInfo[i].uid, -(moveBlockDistance));
                            shiftRow(i, (i - discardRows), numCols, true);
                            if (listItems[i].length == 0)
                            {
                                listItems[(i - discardRows)].splice(0);
                            };
                        };
                    };
                    i = (i + 1);
                };
                if (discardRows)
                {
                    truncateRowArrays((rowCount - discardRows));
                };
                curY = (rowInfo[((rowCount - discardRows) - 1)].y + rowInfo[((rowCount - discardRows) - 1)].height);
                cursorPos = iterator.bookmark;
                try
                {
                    iterator.seek(CursorBookmark.CURRENT, (rowCount - discardRows));
                    if (!iteratorValid)
                    {
                        iteratorValid = true;
                        lastSeekPending = null;
                    };
                }
                catch(e1:ItemPendingError)
                {
                    lastSeekPending = new ListBaseSeekPending(cursorPos, 0);
                    e1.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                    iteratorValid = false;
                };
                offscreenExtraRowsBottomToMake = int((offscreenExtraRows / 2));
                newTopOffset = 0;
                i = 0;
                while (i < newoffscreenExtraRowsTop)
                {
                    newTopOffset = (newTopOffset - rowInfo[i].height);
                    i = (i + 1);
                };
                fillHeight = (listContentVisibleHeight - (curY + newTopOffset));
                if (fillHeight > 0)
                {
                    pt = makeRowsAndColumns(0, curY, listContent.width, (curY + fillHeight), 0, (rowCount - discardRows));
                    rowCount = (rowCount + pt.y);
                }
                else
                {
                    rowIdx = ((rowCount - discardRows) - 1);
                    fillHeight = (fillHeight + rowInfo[rowIdx--].height);
                    while (fillHeight < 0)
                    {
                        offscreenExtraRowsBottomToMake = (offscreenExtraRowsBottomToMake - 1);
                        fillHeight = (fillHeight + rowInfo[rowIdx--].height);
                    };
                };
                if (offscreenExtraRowsBottomToMake > 0)
                {
                    if (pt)
                    {
                        curY = (rowInfo[((rowCount - discardRows) - 1)].y + rowInfo[((rowCount - discardRows) - 1)].height);
                    };
                    pt = makeRowsAndColumns(0, curY, listContent.width, listContent.height, 0, (rowCount - discardRows), true, offscreenExtraRowsBottomToMake);
                }
                else
                {
                    pt = new Point(0, 0);
                };
                try
                {
                    iterator.seek(cursorPos, 0);
                }
                catch(e2:ItemPendingError)
                {
                    lastSeekPending = new ListBaseSeekPending(cursorPos, 0);
                    e2.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                    iteratorValid = false;
                };
                offscreenExtraRowsTop = newoffscreenExtraRowsTop;
                offscreenExtraRowsBottom = (((offscreenExtraRows / 2) - offscreenExtraRowsBottomToMake) + pt.y);
            }
            else
            {
                curY = 0;
                modDeltaPos = deltaPos;
                desiredPrefixItems = int((offscreenExtraRows / 2));
                if (pos < desiredPrefixItems)
                {
                    modDeltaPos = (modDeltaPos - (desiredPrefixItems - pos));
                };
                i = 0;
                while (i < modDeltaPos)
                {
                    addToRowArrays();
                    i = (i + 1);
                };
                actual = new Point(0, 0);
                if (modDeltaPos > 0)
                {
                    try
                    {
                        iterator.seek(CursorBookmark.CURRENT, -(modDeltaPos));
                        if (!iteratorValid)
                        {
                            iteratorValid = true;
                            lastSeekPending = null;
                        };
                    }
                    catch(e3:ItemPendingError)
                    {
                        lastSeekPending = new ListBaseSeekPending(CursorBookmark.CURRENT, -(modDeltaPos));
                        e3.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                        iteratorValid = false;
                    };
                    cursorPos = iterator.bookmark;
                    allowRendererStealingDuringLayout = false;
                    actual = makeRowsAndColumns(0, curY, listContent.width, listContent.height, 0, 0, true, modDeltaPos);
                    allowRendererStealingDuringLayout = true;
                    try
                    {
                        iterator.seek(cursorPos, 0);
                    }
                    catch(e4:ItemPendingError)
                    {
                        lastSeekPending = new ListBaseSeekPending(cursorPos, 0);
                        e4.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                        iteratorValid = false;
                    };
                };
                if (((actual.y == 0) && (modDeltaPos > 0)))
                {
                    verticalScrollPosition = 0;
                    restoreRowArrays(modDeltaPos);
                };
                moveBlockDistance = sumRowHeights(0, (actual.y - 1));
                desiredSuffixItems = int((offscreenExtraRows / 2));
                newOffscreenRows = 0;
                visibleAreaBottomY = (listContentVisibleHeight + sumRowHeights(0, (Math.min(desiredPrefixItems, pos) - 1)));
                i = actual.y;
                while (i < listItems.length)
                {
                    row = listItems[i];
                    rowData = rowInfo[i];
                    moveRowVertically(i, listItems[i].length, moveBlockDistance);
                    if (rowData.y >= visibleAreaBottomY)
                    {
                        newOffscreenRows = (newOffscreenRows + 1);
                        if (newOffscreenRows > desiredSuffixItems)
                        {
                            destroyRow(i, listItems[i].length);
                            removeFromRowArrays(i);
                            i = (i - 1);
                        }
                        else
                        {
                            shiftRow(i, (i + deltaPos), listItems[i].length, false);
                            moveIndicatorsVertically(rowInfo[i].uid, moveBlockDistance);
                        };
                    }
                    else
                    {
                        shiftRow(i, (i + deltaPos), listItems[i].length, false);
                        moveIndicatorsVertically(rowInfo[i].uid, moveBlockDistance);
                    };
                    i = (i + 1);
                };
                rowCount = listItems.length;
                offscreenExtraRowsTop = Math.min(desiredPrefixItems, pos);
                offscreenExtraRowsBottom = Math.min(newOffscreenRows, desiredSuffixItems);
            };
            listContent.topOffset = -(sumRowHeights(0, (offscreenExtraRowsTop - 1)));
            listContent.bottomOffset = (((rowInfo[(rowInfo.length - 1)].y + rowInfo[(rowInfo.length - 1)].height) + listContent.topOffset) - listContentVisibleHeight);
            adjustListContent(oldUnscaledWidth, oldUnscaledHeight);
            addClipMask(true);
        }

        protected function selectItem(item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean=true):Boolean
        {
            var placeHolder:CursorBookmark;
            var index:int;
            var numSelected:int;
            var curSelectionData:ListBaseSelectionData;
            var oldAnchorBookmark:CursorBookmark;
            var oldAnchorIndex:int;
            var incr:Boolean;
            if (((!(item)) || (!(isItemSelectable(item.data)))))
            {
                return (false);
            };
            var selectionChange:Boolean;
            placeHolder = iterator.bookmark;
            index = itemRendererToIndex(item);
            var uid:String = itemToUID(item.data);
            if (((!(allowMultipleSelection)) || ((!(shiftKey)) && (!(ctrlKey)))))
            {
                numSelected = 0;
                if (allowMultipleSelection)
                {
                    curSelectionData = firstSelectionData;
                    if (curSelectionData != null)
                    {
                        numSelected = (numSelected + 1);
                        if (curSelectionData.nextSelectionData)
                        {
                            numSelected = (numSelected + 1);
                        };
                    };
                };
                if (((ctrlKey) && (selectedData[uid])))
                {
                    selectionChange = true;
                    clearSelected(transition);
                }
                else
                {
                    if ((((!(_selectedIndex == index)) || (bSelectedIndexChanged)) || ((allowMultipleSelection) && (!(numSelected == 1)))))
                    {
                        selectionChange = true;
                        clearSelected(transition);
                        insertSelectionDataBefore(uid, new ListBaseSelectionData(item.data, index, approximate), firstSelectionData);
                        drawItem(UIDToItemRenderer(uid), true, (uid == highlightUID), true, transition);
                        _selectedIndex = index;
                        _selectedItem = item.data;
                        iterator.seek(CursorBookmark.CURRENT, (_selectedIndex - indicesToIndex((verticalScrollPosition - offscreenExtraRowsTop), (horizontalScrollPosition - offscreenExtraColumnsLeft))));
                        caretIndex = _selectedIndex;
                        caretBookmark = iterator.bookmark;
                        anchorIndex = _selectedIndex;
                        anchorBookmark = iterator.bookmark;
                        iterator.seek(placeHolder, 0);
                    };
                };
            }
            else
            {
                if (((shiftKey) && (allowMultipleSelection)))
                {
                    if (anchorBookmark)
                    {
                        oldAnchorBookmark = anchorBookmark;
                        oldAnchorIndex = anchorIndex;
                        incr = (anchorIndex < index);
                        clearSelected(false);
                        caretIndex = index;
                        caretBookmark = iterator.bookmark;
                        anchorIndex = oldAnchorIndex;
                        anchorBookmark = oldAnchorBookmark;
                        _selectedIndex = index;
                        _selectedItem = item.data;
                        try
                        {
                            iterator.seek(anchorBookmark, 0);
                        }
                        catch(e:ItemPendingError)
                        {
                            e.addResponder(new ItemResponder(selectionPendingResultHandler, selectionPendingFailureHandler, new ListBaseSelectionPending(incr, index, item.data, transition, placeHolder, CursorBookmark.CURRENT, 0)));
                            iteratorValid = false;
                        };
                        shiftSelectionLoop(incr, anchorIndex, item.data, transition, placeHolder);
                    };
                    selectionChange = true;
                }
                else
                {
                    if (((ctrlKey) && (allowMultipleSelection)))
                    {
                        if (selectedData[uid])
                        {
                            removeSelectionData(uid);
                            drawItem(UIDToItemRenderer(uid), false, (uid == highlightUID), true, transition);
                            if (item.data == selectedItem)
                            {
                                calculateSelectedIndexAndItem();
                            };
                        }
                        else
                        {
                            insertSelectionDataBefore(uid, new ListBaseSelectionData(item.data, index, approximate), firstSelectionData);
                            drawItem(UIDToItemRenderer(uid), true, (uid == highlightUID), true, transition);
                            _selectedIndex = index;
                            _selectedItem = item.data;
                        };
                        iterator.seek(CursorBookmark.CURRENT, (index - indicesToIndex(verticalScrollPosition, horizontalScrollPosition)));
                        caretIndex = index;
                        caretBookmark = iterator.bookmark;
                        anchorIndex = index;
                        anchorBookmark = iterator.bookmark;
                        iterator.seek(placeHolder, 0);
                        selectionChange = true;
                    };
                };
            };
            return (selectionChange);
        }

        mx_internal function selectionTween_updateHandler(_arg_1:TweenEvent):void
        {
            Sprite(_arg_1.target.listener).alpha = Number(_arg_1.value);
        }

        protected function prepareDataEffect(_arg_1:CollectionEvent):void
        {
            var _local_2:Object;
            var _local_3:Class;
            var _local_4:int;
            var _local_5:int;
            if (!cachedItemsChangeEffect)
            {
                _local_2 = getStyle("itemsChangeEffect");
                _local_3 = (_local_2 as Class);
                if (_local_3)
                {
                    _local_2 = new (_local_3)();
                };
                cachedItemsChangeEffect = (_local_2 as IEffect);
            };
            if (runningDataEffect)
            {
                collection = actualCollection;
                listContent.iterator = (iterator = actualIterator);
                cachedItemsChangeEffect.end();
                modifiedCollectionView = null;
            };
            if (((cachedItemsChangeEffect) && (iteratorValid)))
            {
                _local_4 = iterator.bookmark.getViewIndex();
                _local_5 = ((_local_4 + (rowCount * columnCount)) - 1);
                if (((!(modifiedCollectionView)) && (collection is IList)))
                {
                    modifiedCollectionView = new ModifiedCollectionView(ICollectionView(collection));
                };
                if (modifiedCollectionView)
                {
                    modifiedCollectionView.processCollectionEvent(_arg_1, _local_4, _local_5);
                    runDataEffectNextUpdate = true;
                    if (invalidateDisplayListFlag)
                    {
                        callLater(invalidateList);
                    }
                    else
                    {
                        invalidateList();
                    };
                };
            };
        }

        protected function drawSelectionIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:Graphics = Sprite(_arg_1).graphics;
            _local_8.clear();
            _local_8.beginFill(_arg_6);
            _local_8.drawRect(0, 0, _arg_4, _arg_5);
            _local_8.endFill();
            _arg_1.x = _arg_2;
            _arg_1.y = _arg_3;
        }

        mx_internal function setColumnWidth(_arg_1:Number):void
        {
            _columnWidth = _arg_1;
        }

        protected function makeRowsAndColumns(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:int, _arg_6:int, _arg_7:Boolean=false, _arg_8:uint=0):Point
        {
            return (new Point(0, 0));
        }

        public function isItemVisible(_arg_1:Object):Boolean
        {
            return (!(itemToItemRenderer(_arg_1) == null));
        }

        mx_internal function commitSelectedIndices(indices:Array):void
        {
            clearSelected();
            try
            {
                collectionIterator.seek(CursorBookmark.FIRST, 0);
            }
            catch(e:ItemPendingError)
            {
                e.addResponder(new ItemResponder(selectionIndicesPendingResultHandler, selectionIndicesPendingFailureHandler, new ListBaseSelectionDataPending(true, 0, indices, CursorBookmark.FIRST, 0)));
                return;
            };
            setSelectionIndicesLoop(0, indices, true);
        }

        public function calculateDropIndex(_arg_1:DragEvent=null):int
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

        protected function mouseDownHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Point;
            if (((!(enabled)) || (!(selectable))))
            {
                return;
            };
            if (runningDataEffect)
            {
                cachedItemsChangeEffect.end();
                dataEffectCompleted = true;
                itemsSizeChanged = true;
                invalidateList();
                dataItemWrappersByRenderer = new Dictionary();
                validateDisplayList();
            };
            isPressed = true;
            _local_2 = mouseEventToItemRenderer(_arg_1);
            if (!_local_2)
            {
                return;
            };
            bSelectOnRelease = false;
            _local_3 = new Point(_arg_1.localX, _arg_1.localY);
            _local_3 = DisplayObject(_arg_1.target).localToGlobal(_local_3);
            mouseDownPoint = globalToLocal(_local_3);
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true, 0, true);
            systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseLeaveHandler, false, 0, true);
            if (!dragEnabled)
            {
                dragScrollingInterval = setInterval(dragScroll, 15);
            };
            if (((dragEnabled) && (selectedData[rowMap[_local_2.name].uid])))
            {
                bSelectOnRelease = true;
            }
            else
            {
                if (selectItem(_local_2, _arg_1.shiftKey, _arg_1.ctrlKey))
                {
                    mouseDownItem = _local_2;
                };
            };
        }

        [Bindable("labelFieldChanged")]
        public function get labelField():String
        {
            return (_labelField);
        }

        private function onSelectionTweenUpdate(_arg_1:Number):void
        {
        }

        public function set selectedItemsCompareFunction(_arg_1:Function):void
        {
            _selectedItemsCompareFunction = _arg_1;
            dispatchEvent(new Event("selectedItemsCompareFunctionChanged"));
        }

        protected function clearIndicators():void
        {
            var _local_1:String;
            for (_local_1 in selectionTweens)
            {
                removeIndicators(_local_1);
            };
            while (selectionLayer.numChildren > 0)
            {
                selectionLayer.removeChildAt(0);
            };
            selectionTweens = {};
            selectionIndicators = {};
            highlightIndicator = null;
            highlightUID = null;
            caretIndicator = null;
            caretUID = null;
        }

        public function get offscreenExtraRowsOrColumns():int
        {
            return (_offscreenExtraRowsOrColumns);
        }

        public function get wordWrap():Boolean
        {
            return (_wordWrap);
        }

        protected function drawItem(_arg_1:IListItemRenderer, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false):void
        {
            var _local_6:Sprite;
            var _local_7:Graphics;
            var _local_12:Number;
            if (!_arg_1)
            {
                return;
            };
            var _local_8:ListBaseContentHolder = (DisplayObject(_arg_1).parent as ListBaseContentHolder);
            if (!_local_8)
            {
                return;
            };
            var _local_9:Array = _local_8.rowInfo;
            var _local_10:Sprite = _local_8.selectionLayer;
            var _local_11:BaseListData = rowMap[_arg_1.name];
            if (!_local_11)
            {
                return;
            };
            if (((_arg_3) && ((!(highlightItemRenderer)) || (!(highlightUID == _local_11.uid)))))
            {
                if (!highlightIndicator)
                {
                    _local_6 = new SpriteAsset();
                    _local_10.addChild(DisplayObject(_local_6));
                    highlightIndicator = _local_6;
                }
                else
                {
                    if (highlightIndicator.parent != _local_10)
                    {
                        _local_10.addChild(highlightIndicator);
                    }
                    else
                    {
                        _local_10.setChildIndex(DisplayObject(highlightIndicator), (_local_10.numChildren - 1));
                    };
                };
                _local_6 = highlightIndicator;
                drawHighlightIndicator(_local_6, _arg_1.x, _local_9[_local_11.rowIndex].y, _arg_1.width, _local_9[_local_11.rowIndex].height, getStyle("rollOverColor"), _arg_1);
                lastHighlightItemRenderer = (highlightItemRenderer = _arg_1);
                highlightUID = _local_11.uid;
            }
            else
            {
                if ((((!(_arg_3)) && (highlightItemRenderer)) && ((_local_11) && (highlightUID == _local_11.uid))))
                {
                    clearHighlightIndicator(highlightIndicator, _arg_1);
                    highlightItemRenderer = null;
                    highlightUID = null;
                };
            };
            if (_arg_2)
            {
                _local_12 = ((runningDataEffect) ? (_arg_1.y - cachedPaddingTop) : _local_9[_local_11.rowIndex].y);
                if (!selectionIndicators[_local_11.uid])
                {
                    _local_6 = new SpriteAsset();
                    _local_6.mouseEnabled = false;
                    _local_10.addChild(DisplayObject(_local_6));
                    selectionIndicators[_local_11.uid] = _local_6;
                    drawSelectionIndicator(_local_6, _arg_1.x, _local_12, _arg_1.width, _local_9[_local_11.rowIndex].height, ((enabled) ? getStyle("selectionColor") : getStyle("selectionDisabledColor")), _arg_1);
                    if (_arg_5)
                    {
                        applySelectionEffect(_local_6, _local_11.uid, _arg_1);
                    };
                }
                else
                {
                    _local_6 = selectionIndicators[_local_11.uid];
                    drawSelectionIndicator(_local_6, _arg_1.x, _local_12, _arg_1.width, _local_9[_local_11.rowIndex].height, ((enabled) ? getStyle("selectionColor") : getStyle("selectionDisabledColor")), _arg_1);
                };
            }
            else
            {
                if (!_arg_2)
                {
                    if (((_local_11) && (selectionIndicators[_local_11.uid])))
                    {
                        if (selectionTweens[_local_11.uid])
                        {
                            selectionTweens[_local_11.uid].removeEventListener(TweenEvent.TWEEN_UPDATE, selectionTween_updateHandler);
                            selectionTweens[_local_11.uid].removeEventListener(TweenEvent.TWEEN_END, selectionTween_endHandler);
                            if (selectionIndicators[_local_11.uid].alpha < 1)
                            {
                                Tween.removeTween(selectionTweens[_local_11.uid]);
                            };
                            delete selectionTweens[_local_11.uid];
                        };
                        _local_10.removeChild(selectionIndicators[_local_11.uid]);
                        delete selectionIndicators[_local_11.uid];
                    };
                };
            };
            if (_arg_4)
            {
                if (showCaret)
                {
                    if (!caretIndicator)
                    {
                        _local_6 = new SpriteAsset();
                        _local_6.mouseEnabled = false;
                        _local_10.addChild(DisplayObject(_local_6));
                        caretIndicator = _local_6;
                    }
                    else
                    {
                        if (caretIndicator.parent != _local_10)
                        {
                            _local_10.addChild(caretIndicator);
                        }
                        else
                        {
                            _local_10.setChildIndex(DisplayObject(caretIndicator), (_local_10.numChildren - 1));
                        };
                    };
                    _local_6 = caretIndicator;
                    drawCaretIndicator(_local_6, _arg_1.x, _local_9[_local_11.rowIndex].y, _arg_1.width, _local_9[_local_11.rowIndex].height, getStyle("selectionColor"), _arg_1);
                    caretItemRenderer = _arg_1;
                    caretUID = _local_11.uid;
                };
            }
            else
            {
                if ((((!(_arg_4)) && (caretItemRenderer)) && (caretUID == _local_11.uid)))
                {
                    clearCaretIndicator(caretIndicator, _arg_1);
                    caretItemRenderer = null;
                    caretUID = "";
                };
            };
            if ((_arg_1 is IFlexDisplayObject))
            {
                if ((_arg_1 is IInvalidating))
                {
                    IInvalidating(_arg_1).invalidateDisplayList();
                    IInvalidating(_arg_1).validateNow();
                };
            }
            else
            {
                if ((_arg_1 is IUITextField))
                {
                    IUITextField(_arg_1).validateNow();
                };
            };
        }

        private function strictEqualityCompareFunction(_arg_1:Object, _arg_2:Object):Boolean
        {
            return (_arg_1 === _arg_2);
        }

        protected function dragExitHandler(_arg_1:DragEvent):void
        {
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            lastDragEvent = null;
            hideDropFeedback(_arg_1);
            resetDragScrolling();
            DragManager.showFeedback(DragManager.NONE);
        }

        protected function adjustAfterRemove(items:Array, location:int, emitEvent:Boolean):Boolean
        {
            var data:ListBaseSelectionData;
            var requiresValueCommit:Boolean;
            var i:int;
            var length:int;
            var placeHolder:CursorBookmark;
            var s:String;
            requiresValueCommit = emitEvent;
            i = 0;
            length = items.length;
            for (s in selectedData)
            {
                i = (i + 1);
                data = selectedData[s];
                if (data.index > location)
                {
                    data.index = (data.index - length);
                };
            };
            if (_selectedIndex > location)
            {
                _selectedIndex = (_selectedIndex - length);
                requiresValueCommit = true;
            };
            if (((i > 0) && (_selectedIndex == -1)))
            {
                _selectedIndex = data.index;
                _selectedItem = data.data;
                requiresValueCommit = true;
            };
            if (i == 0)
            {
                _selectedIndex = -1;
                bSelectionChanged = true;
                bSelectedIndexChanged = true;
                invalidateDisplayList();
            };
            if (anchorIndex > location)
            {
                anchorIndex = (anchorIndex - length);
                placeHolder = iterator.bookmark;
                try
                {
                    iterator.seek(CursorBookmark.FIRST, anchorIndex);
                    anchorBookmark = iterator.bookmark;
                }
                catch(e:ItemPendingError)
                {
                    e.addResponder(new ItemResponder(setBookmarkPendingResultHandler, setBookmarkPendingFailureHandler, {
                        "property":"anchorBookmark",
                        "value":anchorIndex
                    }));
                };
                iterator.seek(placeHolder);
            };
            if (caretIndex > location)
            {
                caretIndex = (caretIndex - length);
                placeHolder = iterator.bookmark;
                try
                {
                    iterator.seek(CursorBookmark.FIRST, caretIndex);
                    caretBookmark = iterator.bookmark;
                }
                catch(e:ItemPendingError)
                {
                    e.addResponder(new ItemResponder(setBookmarkPendingResultHandler, setBookmarkPendingFailureHandler, {
                        "property":"caretBookmark",
                        "value":caretIndex
                    }));
                };
                iterator.seek(placeHolder);
            };
            return (requiresValueCommit);
        }

        public function itemToIcon(data:Object):Class
        {
            var iconClass:Class;
            var icon:* = undefined;
            if (data == null)
            {
                return (null);
            };
            if (iconFunction != null)
            {
                return (iconFunction(data));
            };
            if ((data is XML))
            {
                try
                {
                    if (data[iconField].length() != 0)
                    {
                        icon = String(data[iconField]);
                        if (icon != null)
                        {
                            iconClass = Class(systemManager.getDefinitionByName(icon));
                            if (iconClass)
                            {
                                return (iconClass);
                            };
                            return (document[icon]);
                        };
                    };
                }
                catch(e:Error)
                {
                };
            }
            else
            {
                if ((data is Object))
                {
                    try
                    {
                        if (data[iconField] != null)
                        {
                            if ((data[iconField] is Class))
                            {
                                return (data[iconField]);
                            };
                            if ((data[iconField] is String))
                            {
                                iconClass = Class(systemManager.getDefinitionByName(data[iconField]));
                                if (iconClass)
                                {
                                    return (iconClass);
                                };
                                return (document[data[iconField]]);
                            };
                        };
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            return (null);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            var _local_2:IFlexDisplayObject = (border as IFlexDisplayObject);
            if (_local_2)
            {
                if ((_local_2 is IUIComponent))
                {
                    IUIComponent(_local_2).enabled = _arg_1;
                };
                if ((_local_2 is IInvalidating))
                {
                    IInvalidating(_local_2).invalidateDisplayList();
                };
            };
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return (super.baselinePosition);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            var _local_1:* = (dataProvider == null);
            var _local_2:Boolean = ((!(dataProvider == null)) && (dataProvider.length == 0));
            var _local_3:Object = dataProvider;
            if (((_local_1) || (_local_2)))
            {
                dataProvider = [null];
                validateNow();
            };
            if (((!(listItems)) || (listItems.length == 0)))
            {
                return (super.baselinePosition);
            };
            var _local_4:IUIComponent = (listItems[0][0] as IUIComponent);
            if (!_local_4)
            {
                return (super.baselinePosition);
            };
            var _local_5:ListBaseContentHolder = ListBaseContentHolder(_local_4.parent);
            var _local_6:Number = ((_local_5.y + _local_4.y) + _local_4.baselinePosition);
            if (((_local_1) || (_local_2)))
            {
                dataProvider = _local_3;
                validateNow();
            };
            return (_local_6);
        }

        public function addDataEffectItem(_arg_1:Object):void
        {
            if (modifiedCollectionView)
            {
                modifiedCollectionView.addItem(dataItemWrappersByRenderer[_arg_1]);
            };
            if (iterator.afterLast)
            {
                iterator.seek(CursorBookmark.FIRST);
            }
            else
            {
                iterator.seek(CursorBookmark.CURRENT);
            };
            if (invalidateDisplayListFlag)
            {
                callLater(invalidateList);
            }
            else
            {
                invalidateList();
            };
        }

        private function makeRowsAndColumnsWithExtraRows(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:ListRowInfo;
            var _local_4:ListRowInfo;
            var _local_5:ListRowInfo;
            var _local_6:int;
            var _local_7:Point;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_8:int = int((offscreenExtraRows / 2));
            var _local_9:int = int((offscreenExtraRows / 2));
            offscreenExtraRowsTop = Math.min(_local_8, verticalScrollPosition);
            var _local_10:int = scrollPositionToIndex(horizontalScrollPosition, (verticalScrollPosition - offscreenExtraRowsTop));
            seekPositionSafely(_local_10);
            var _local_11:CursorBookmark = iterator.bookmark;
            if (offscreenExtraRowsTop > 0)
            {
                makeRowsAndColumns(0, 0, listContent.width, listContent.height, 0, 0, true, offscreenExtraRowsTop);
            };
            var _local_12:Number = ((offscreenExtraRowsTop) ? (rowInfo[(offscreenExtraRowsTop - 1)].y + rowHeight) : 0);
            _local_7 = makeRowsAndColumns(0, _local_12, listContent.width, (_local_12 + listContent.heightExcludingOffsets), 0, offscreenExtraRowsTop);
            if (((_local_9 > 0) && (!(iterator.afterLast))))
            {
                if (((offscreenExtraRowsTop + _local_7.y) - 1) < 0)
                {
                    _local_12 = 0;
                }
                else
                {
                    _local_12 = (rowInfo[((offscreenExtraRowsTop + _local_7.y) - 1)].y + rowInfo[((offscreenExtraRowsTop + _local_7.y) - 1)].height);
                };
                _local_14 = listItems.length;
                _local_7 = makeRowsAndColumns(0, _local_12, listContent.width, _local_12, 0, (offscreenExtraRowsTop + _local_7.y), true, _local_9);
                if (_local_7.y == _local_9)
                {
                    while ((((_local_7.y > 0) && (listItems[(listItems.length - 1)])) && (listItems[(listItems.length - 1)].length == 0)))
                    {
                        _local_7.y--;
                        listItems.pop();
                        rowInfo.pop();
                    };
                }
                else
                {
                    if (_local_7.y < _local_9)
                    {
                        _local_15 = (listItems.length - (_local_14 + _local_7.y));
                        if (_local_15)
                        {
                            _local_16 = 0;
                            while (_local_16 < _local_15)
                            {
                                listItems.pop();
                                rowInfo.pop();
                                _local_16++;
                            };
                        };
                    };
                };
                offscreenExtraRowsBottom = _local_7.y;
            }
            else
            {
                offscreenExtraRowsBottom = 0;
            };
            var _local_13:Number = listContent.heightExcludingOffsets;
            listContent.topOffset = (-(offscreenExtraRowsTop) * rowHeight);
            listContent.bottomOffset = ((offscreenExtraRowsBottom > 0) ? (((listItems[(listItems.length - 1)][0].y + rowHeight) - _local_13) + listContent.topOffset) : 0);
            if (iteratorValid)
            {
                iterator.seek(_local_11, 0);
            };
            adjustListContent(_arg_1, _arg_2);
        }

        mx_internal function indicesToItemRenderer(_arg_1:int, _arg_2:int):IListItemRenderer
        {
            return (listItems[_arg_1][_arg_2]);
        }

        mx_internal function getItemRendererForMouseEvent(_arg_1:MouseEvent):IListItemRenderer
        {
            return (mouseEventToItemRenderer(_arg_1));
        }

        mx_internal function set $verticalScrollPosition(_arg_1:Number):void
        {
            var _local_2:int = super.verticalScrollPosition;
            if (_local_2 != _arg_1)
            {
                super.verticalScrollPosition = _arg_1;
            };
        }

        protected function mouseOutHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            if (((!(enabled)) || (!(selectable))))
            {
                return;
            };
            isPressed = _arg_1.buttonDown;
            _local_2 = mouseEventToItemRenderer(_arg_1);
            if (!_local_2)
            {
                return;
            };
            if (!isPressed)
            {
                if (((((itemRendererContains(_local_2, _arg_1.relatedObject)) || (_arg_1.relatedObject == listContent)) || (_arg_1.relatedObject == highlightIndicator)) || (!(highlightItemRenderer))))
                {
                    return;
                };
                if (((getStyle("useRollOver")) && (!(_local_2.data == null))))
                {
                    clearHighlight(_local_2);
                };
            };
        }

        public function set dropEnabled(_arg_1:Boolean):void
        {
            if (((_dropEnabled) && (!(_arg_1))))
            {
                removeEventListener(DragEvent.DRAG_ENTER, dragEnterHandler, false);
                removeEventListener(DragEvent.DRAG_EXIT, dragExitHandler, false);
                removeEventListener(DragEvent.DRAG_OVER, dragOverHandler, false);
                removeEventListener(DragEvent.DRAG_DROP, dragDropHandler, false);
            };
            _dropEnabled = _arg_1;
            if (_arg_1)
            {
                addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler, false, EventPriority.DEFAULT_HANDLER);
                addEventListener(DragEvent.DRAG_EXIT, dragExitHandler, false, EventPriority.DEFAULT_HANDLER);
                addEventListener(DragEvent.DRAG_OVER, dragOverHandler, false, EventPriority.DEFAULT_HANDLER);
                addEventListener(DragEvent.DRAG_DROP, dragDropHandler, false, EventPriority.DEFAULT_HANDLER);
            };
        }

        protected function get listContentStyleFilters():Object
        {
            return (_listContentStyleFilters);
        }

        public function itemToLabel(data:Object):String
        {
            if (data == null)
            {
                return (" ");
            };
            if (labelFunction != null)
            {
                return (labelFunction(data));
            };
            if ((data is XML))
            {
                try
                {
                    if (data[labelField].length() != 0)
                    {
                        data = data[labelField];
                    };
                }
                catch(e:Error)
                {
                };
            }
            else
            {
                if ((data is Object))
                {
                    try
                    {
                        if (data[labelField] != null)
                        {
                            data = data[labelField];
                        };
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            if ((data is String))
            {
                return (String(data));
            };
            try
            {
                return (data.toString());
            }
            catch(e:Error)
            {
            };
            return (" ");
        }

        public function set rowCount(_arg_1:int):void
        {
            explicitRowCount = _arg_1;
            if (_rowCount != _arg_1)
            {
                setRowCount(_arg_1);
                rowCountChanged = true;
                invalidateProperties();
                invalidateSize();
                itemsSizeChanged = true;
                invalidateDisplayList();
                dispatchEvent(new Event("rowCountChanged"));
            };
        }

        public function set columnCount(_arg_1:int):void
        {
            explicitColumnCount = _arg_1;
            if (_columnCount != _arg_1)
            {
                setColumnCount(_arg_1);
                columnCountChanged = true;
                invalidateProperties();
                invalidateSize();
                itemsSizeChanged = true;
                invalidateDisplayList();
                dispatchEvent(new Event("columnCountChanged"));
            };
        }

        private function partialPurgeItemRenderers():void
        {
            var _local_1:*;
            var _local_2:String;
            var _local_3:DisplayObject;
            var _local_4:Dictionary;
            var _local_5:*;
            dataEffectCompleted = false;
            while (freeItemRenderers.length)
            {
                _local_3 = DisplayObject(freeItemRenderers.pop());
                if (_local_3.parent)
                {
                    listContent.removeChild(_local_3);
                };
            };
            for (_local_1 in freeItemRenderersByFactory)
            {
                _local_4 = freeItemRenderersByFactory[_local_1];
                for (_local_5 in _local_4)
                {
                    _local_3 = DisplayObject(_local_5);
                    delete _local_4[_local_5];
                    if (_local_3.parent)
                    {
                        listContent.removeChild(_local_3);
                    };
                };
            };
            for (_local_2 in reservedItemRenderers)
            {
                _local_3 = DisplayObject(reservedItemRenderers[_local_2]);
                if (_local_3.parent)
                {
                    listContent.removeChild(_local_3);
                };
            };
            reservedItemRenderers = {};
            rowMap = {};
            clearVisibleData();
        }

        protected function seekPendingResultHandler(data:Object, info:ListBaseSeekPending):void
        {
            if (info != lastSeekPending)
            {
                return;
            };
            lastSeekPending = null;
            iteratorValid = true;
            try
            {
                iterator.seek(info.bookmark, info.offset);
            }
            catch(e:ItemPendingError)
            {
                lastSeekPending = new ListBaseSeekPending(info.bookmark, info.offset);
                e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                iteratorValid = false;
            };
            if (bSortItemPending)
            {
                bSortItemPending = false;
                adjustAfterSort();
            };
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        mx_internal function mouseEventToItemRendererOrEditor(_arg_1:MouseEvent):IListItemRenderer
        {
            var _local_3:Point;
            var _local_4:Number;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_2:DisplayObject = DisplayObject(_arg_1.target);
            if (_local_2 == listContent)
            {
                _local_3 = new Point(_arg_1.stageX, _arg_1.stageY);
                _local_3 = listContent.globalToLocal(_local_3);
                _local_4 = 0;
                _local_5 = listItems.length;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    if (listItems[_local_6].length)
                    {
                        if (_local_3.y < (_local_4 + rowInfo[_local_6].height))
                        {
                            _local_7 = listItems[_local_6].length;
                            if (_local_7 == 1)
                            {
                                return (listItems[_local_6][0]);
                            };
                            _local_8 = int(Math.floor((_local_3.x / columnWidth)));
                            return (listItems[_local_6][_local_8]);
                        };
                    };
                    _local_4 = (_local_4 + rowInfo[_local_6].height);
                    _local_6++;
                };
            }
            else
            {
                if (_local_2 == highlightIndicator)
                {
                    return (lastHighlightItemRenderer);
                };
            };
            while (((_local_2) && (!(_local_2 == this))))
            {
                if (((_local_2 is IListItemRenderer) && (_local_2.parent == listContent)))
                {
                    if (_local_2.visible)
                    {
                        return (IListItemRenderer(_local_2));
                    };
                    break;
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
            return (null);
        }

        protected function configureScrollBars():void
        {
        }

        protected function clearVisibleData():void
        {
            listContent.visibleData = {};
        }

        private function insertSelectionDataAfter(_arg_1:String, _arg_2:ListBaseSelectionData, _arg_3:ListBaseSelectionData):void
        {
            if (_arg_3 == null)
            {
                firstSelectionData = (lastSelectionData = _arg_2);
            }
            else
            {
                if (_arg_3 == lastSelectionData)
                {
                    lastSelectionData = _arg_2;
                };
                _arg_2.prevSelectionData = _arg_3;
                _arg_2.nextSelectionData = _arg_3.nextSelectionData;
                _arg_3.nextSelectionData = _arg_2;
            };
            selectedData[_arg_1] = _arg_2;
        }

        protected function moveSelectionVertically(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:Number;
            var _local_5:IListItemRenderer;
            var _local_6:String;
            var _local_7:int;
            var _local_13:ScrollEvent;
            var _local_8:Boolean;
            showCaret = true;
            var _local_9:int = listItems.length;
            var _local_10:int = ((listItems.length - offscreenExtraRowsTop) - offscreenExtraRowsBottom);
            var _local_11:int = (((rowInfo[((_local_9 - offscreenExtraRowsBottom) - 1)].y + rowInfo[((_local_9 - offscreenExtraRowsBottom) - 1)].height) > (listContent.heightExcludingOffsets - listContent.topOffset)) ? 1 : 0);
            var _local_12:Boolean;
            bSelectItem = false;
            switch (_arg_1)
            {
                case Keyboard.UP:
                    if (caretIndex > 0)
                    {
                        caretIndex--;
                        _local_12 = true;
                        bSelectItem = true;
                    };
                    break;
                case Keyboard.DOWN:
                    if (caretIndex < (collection.length - 1))
                    {
                        caretIndex++;
                        _local_12 = true;
                        bSelectItem = true;
                    }
                    else
                    {
                        if (((caretIndex == (collection.length - 1)) && (_local_11)))
                        {
                            if (verticalScrollPosition < maxVerticalScrollPosition)
                            {
                                _local_4 = (verticalScrollPosition + 1);
                            };
                        };
                    };
                    break;
                case Keyboard.PAGE_UP:
                    if (((caretIndex > verticalScrollPosition) && (caretIndex < (verticalScrollPosition + _local_10))))
                    {
                        caretIndex = verticalScrollPosition;
                    }
                    else
                    {
                        caretIndex = Math.max((caretIndex - Math.max((_local_10 - _local_11), 1)), 0);
                        _local_4 = Math.max(caretIndex, 0);
                    };
                    bSelectItem = true;
                    break;
                case Keyboard.PAGE_DOWN:
                    if (!((caretIndex >= verticalScrollPosition) && (caretIndex < (((verticalScrollPosition + _local_10) - _local_11) - 1))))
                    {
                        if (((caretIndex == verticalScrollPosition) && ((_local_10 - _local_11) <= 1)))
                        {
                            caretIndex++;
                        };
                        _local_4 = Math.max(Math.min(caretIndex, maxVerticalScrollPosition), 0);
                    };
                    bSelectItem = true;
                    break;
                case Keyboard.HOME:
                    if (caretIndex > 0)
                    {
                        caretIndex = 0;
                        bSelectItem = true;
                        _local_4 = 0;
                    };
                    break;
                case Keyboard.END:
                    if (caretIndex < (collection.length - 1))
                    {
                        caretIndex = (collection.length - 1);
                        bSelectItem = true;
                        _local_4 = maxVerticalScrollPosition;
                    };
                    break;
            };
            if (_local_12)
            {
                if (caretIndex >= ((verticalScrollPosition + _local_10) - _local_11))
                {
                    if ((_local_10 - _local_11) == 0)
                    {
                        _local_4 = Math.min(maxVerticalScrollPosition, caretIndex);
                    }
                    else
                    {
                        _local_4 = Math.min(maxVerticalScrollPosition, (((caretIndex - _local_10) + _local_11) + 1));
                    };
                }
                else
                {
                    if (caretIndex < verticalScrollPosition)
                    {
                        _local_4 = Math.max(caretIndex, 0);
                    };
                };
            };
            if (!isNaN(_local_4))
            {
                if (verticalScrollPosition != _local_4)
                {
                    _local_13 = new ScrollEvent(ScrollEvent.SCROLL);
                    _local_13.detail = ScrollEventDetail.THUMB_POSITION;
                    _local_13.direction = ScrollEventDirection.VERTICAL;
                    _local_13.delta = (_local_4 - verticalScrollPosition);
                    _local_13.position = _local_4;
                    verticalScrollPosition = _local_4;
                    dispatchEvent(_local_13);
                };
                if (!iteratorValid)
                {
                    keySelectionPending = true;
                    return;
                };
            };
            bShiftKey = _arg_2;
            bCtrlKey = _arg_3;
            lastKey = _arg_1;
            finishKeySelection();
        }

        protected function getReservedOrFreeItemRenderer(_arg_1:Object):IListItemRenderer
        {
            var _local_2:IListItemRenderer;
            var _local_3:String;
            var _local_4:IFactory;
            var _local_5:Dictionary;
            var _local_6:*;
            if (runningDataEffect)
            {
                _local_2 = IListItemRenderer(reservedItemRenderers[(_local_3 = itemToUID(_arg_1))]);
            };
            if (_local_2)
            {
                delete reservedItemRenderers[_local_3];
            }
            else
            {
                _local_4 = getItemRendererFactory(_arg_1);
                if (freeItemRenderersByFactory)
                {
                    if (_local_4 == itemRenderer)
                    {
                        if (freeItemRenderers.length)
                        {
                            _local_2 = freeItemRenderers.pop();
                            delete freeItemRenderersByFactory[_local_4][_local_2];
                        };
                    }
                    else
                    {
                        _local_5 = freeItemRenderersByFactory[_local_4];
                        if (_local_5)
                        {
                            for (_local_6 in _local_5)
                            {
                                _local_2 = _local_6;
                                delete freeItemRenderersByFactory[_local_4][_local_2];
                                break;
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }

        protected function addDragData(_arg_1:Object):void
        {
            _arg_1.addHandler(copySelectedItems, "items");
        }

        private function adjustAfterSort():void
        {
            var p:String;
            var index:int;
            var newVerticalScrollPosition:int;
            var newHorizontalScrollPosition:int;
            var pos:int;
            var data:ListBaseSelectionData;
            var i:int;
            for (p in selectedData)
            {
                i = (i + 1);
            };
            index = ((anchorBookmark) ? anchorBookmark.getViewIndex() : -1);
            if (index >= 0)
            {
                if (i == 1)
                {
                    _selectedIndex = (anchorIndex = (caretIndex = index));
                    data = selectedData[p];
                    data.index = index;
                };
                newVerticalScrollPosition = indexToRow(index);
                if (newVerticalScrollPosition == -1)
                {
                    return;
                };
                newVerticalScrollPosition = Math.min(maxVerticalScrollPosition, newVerticalScrollPosition);
                newHorizontalScrollPosition = indexToColumn(index);
                if (newHorizontalScrollPosition == -1)
                {
                    return;
                };
                newHorizontalScrollPosition = Math.min(maxHorizontalScrollPosition, newHorizontalScrollPosition);
                pos = scrollPositionToIndex(newHorizontalScrollPosition, newVerticalScrollPosition);
                try
                {
                    iterator.seek(CursorBookmark.CURRENT, (pos - index));
                    if (!iteratorValid)
                    {
                        iteratorValid = true;
                        lastSeekPending = null;
                    };
                }
                catch(e:ItemPendingError)
                {
                    lastSeekPending = new ListBaseSeekPending(CursorBookmark.CURRENT, (pos - index));
                    e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                    iteratorValid = false;
                    return;
                };
                super.verticalScrollPosition = newVerticalScrollPosition;
                if (listType != "vertical")
                {
                    super.horizontalScrollPosition = newHorizontalScrollPosition;
                };
            }
            else
            {
                try
                {
                    index = scrollPositionToIndex(horizontalScrollPosition, (verticalScrollPosition - offscreenExtraRowsTop));
                    iterator.seek(CursorBookmark.FIRST, index);
                    if (!iteratorValid)
                    {
                        iteratorValid = true;
                        lastSeekPending = null;
                    };
                }
                catch(e:ItemPendingError)
                {
                    lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, index);
                    e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                    iteratorValid = false;
                    return;
                };
            };
            if (i > 1)
            {
                commitSelectedItems(selectedItems);
            };
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = _arg_1;
        }

        private function initiateSelectionTracking(_arg_1:Array):void
        {
            var _local_3:IListItemRenderer;
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = (_arg_1[_local_2] as IListItemRenderer);
                if (selectedData[itemToUID(_local_3.data)])
                {
                    _local_3.addEventListener(MoveEvent.MOVE, rendererMoveHandler);
                    trackedRenderers.push(_local_3);
                };
                _local_2++;
            };
        }

        private function setSelectionDataLoop(items:Array, index:int, useFind:Boolean=true):void
        {
            var uid:String;
            var item:Object;
            var bookmark:CursorBookmark;
            var compareFunction:Function;
            var selectionData:ListBaseSelectionData;
            var lastSelectionData:ListBaseSelectionData;
            var len:int;
            var data:Object;
            var i:int;
            if (useFind)
            {
                while (items.length)
                {
                    item = items.pop();
                    uid = itemToUID(item);
                    try
                    {
                        collectionIterator.findAny(item);
                    }
                    catch(e1:ItemPendingError)
                    {
                        items.push(item);
                        e1.addResponder(new ItemResponder(selectionDataPendingResultHandler, selectionDataPendingFailureHandler, new ListBaseSelectionDataPending(useFind, 0, items, null, 0)));
                        return;
                    };
                    bookmark = collectionIterator.bookmark;
                    index = bookmark.getViewIndex();
                    if (index >= 0)
                    {
                        insertSelectionDataBefore(uid, new ListBaseSelectionData(item, index, true), firstSelectionData);
                    }
                    else
                    {
                        try
                        {
                            collectionIterator.seek(CursorBookmark.FIRST, 0);
                        }
                        catch(e2:ItemPendingError)
                        {
                            e2.addResponder(new ItemResponder(selectionDataPendingResultHandler, selectionDataPendingFailureHandler, new ListBaseSelectionDataPending(false, 0, items, CursorBookmark.FIRST, 0)));
                            return;
                        };
                        setSelectionDataLoop(items, 0, false);
                        return;
                    };
                    if (items.length == 0)
                    {
                        _selectedIndex = index;
                        _selectedItem = item;
                        caretIndex = index;
                        caretBookmark = collectionIterator.bookmark;
                        anchorIndex = index;
                        anchorBookmark = collectionIterator.bookmark;
                    };
                };
            }
            else
            {
                compareFunction = selectedItemsCompareFunction;
                if (compareFunction == null)
                {
                    compareFunction = strictEqualityCompareFunction;
                };
                while (((items.length) && (!(collectionIterator.afterLast))))
                {
                    len = items.length;
                    data = collectionIterator.current;
                    i = 0;
                    while (i < len)
                    {
                        item = items[i];
                        if (compareFunction(data, item))
                        {
                            uid = itemToUID(data);
                            selectionDataArray[proposedSelectedItemIndexes[uid]] = new ListBaseSelectionData(data, index, false);
                            items.splice(i, 1);
                            if (item === firstSelectedItem)
                            {
                                _selectedIndex = index;
                                _selectedItem = data;
                                caretIndex = index;
                                caretBookmark = collectionIterator.bookmark;
                                anchorIndex = index;
                                anchorBookmark = collectionIterator.bookmark;
                            };
                            break;
                        };
                        i = (i + 1);
                    };
                    try
                    {
                        collectionIterator.moveNext();
                        index = (index + 1);
                    }
                    catch(e2:ItemPendingError)
                    {
                        e2.addResponder(new ItemResponder(selectionDataPendingResultHandler, selectionDataPendingFailureHandler, new ListBaseSelectionDataPending(false, index, items, CursorBookmark.FIRST, index)));
                        return;
                    };
                };
                len = selectionDataArray.length;
                lastSelectionData = firstSelectionData;
                if (len)
                {
                    selectionData = selectionDataArray[0];
                    if (selectionData)
                    {
                        uid = itemToUID(selectionData.data);
                        insertSelectionDataBefore(uid, selectionData, firstSelectionData);
                        lastSelectionData = selectionData;
                    };
                };
                i = 1;
                while (i < len)
                {
                    selectionData = selectionDataArray[i];
                    if (selectionData)
                    {
                        uid = itemToUID(selectionData.data);
                        insertSelectionDataAfter(uid, selectionData, lastSelectionData);
                        lastSelectionData = selectionData;
                    };
                    i = (i + 1);
                };
                selectionDataArray = null;
                proposedSelectedItemIndexes = null;
                firstSelectedItem = null;
            };
            if (initialized)
            {
                updateList();
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        public function set dragEnabled(_arg_1:Boolean):void
        {
            if (((_dragEnabled) && (!(_arg_1))))
            {
                removeEventListener(DragEvent.DRAG_START, dragStartHandler, false);
                removeEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler, false);
            };
            _dragEnabled = _arg_1;
            if (_arg_1)
            {
                addEventListener(DragEvent.DRAG_START, dragStartHandler, false, EventPriority.DEFAULT_HANDLER);
                addEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler, false, EventPriority.DEFAULT_HANDLER);
            };
        }

        mx_internal function getListContentHolder():ListBaseContentHolder
        {
            return (listContent);
        }

        public function set iconFunction(_arg_1:Function):void
        {
            _iconFunction = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("iconFunctionChanged"));
        }

        protected function initiateDataChangeEffect(_arg_1:Number, _arg_2:Number):void
        {
            var _local_9:Array;
            var _local_10:int;
            var _local_11:Object;
            actualCollection = collection;
            actualIterator = iterator;
            collection = modifiedCollectionView;
            modifiedCollectionView.showPreservedState = true;
            listContent.iterator = (iterator = collection.createCursor());
            var _local_3:int = scrollPositionToIndex((horizontalScrollPosition - offscreenExtraColumnsLeft), (verticalScrollPosition - offscreenExtraRowsTop));
            iterator.seek(CursorBookmark.FIRST, _local_3);
            updateDisplayList(_arg_1, _arg_2);
            var _local_4:Array = [];
            var _local_5:Dictionary = new Dictionary(true);
            var _local_6:int;
            while (_local_6 < listItems.length)
            {
                _local_9 = listItems[_local_6];
                if (((_local_9) && (_local_9.length > 0)))
                {
                    _local_10 = 0;
                    while (_local_10 < _local_9.length)
                    {
                        _local_11 = _local_9[_local_10];
                        if (_local_11)
                        {
                            _local_4.push(_local_11);
                            _local_5[_local_11] = true;
                        };
                        _local_10++;
                    };
                };
                _local_6++;
            };
            cachedItemsChangeEffect.targets = _local_4;
            if (cachedItemsChangeEffect.effectTargetHost != this)
            {
                cachedItemsChangeEffect.effectTargetHost = this;
            };
            cachedItemsChangeEffect.captureStartValues();
            modifiedCollectionView.showPreservedState = false;
            iterator.seek(CursorBookmark.FIRST, _local_3);
            itemsSizeChanged = true;
            updateDisplayList(_arg_1, _arg_2);
            var _local_7:Array = [];
            var _local_8:Array = cachedItemsChangeEffect.targets;
            _local_6 = 0;
            while (_local_6 < listItems.length)
            {
                _local_9 = listItems[_local_6];
                if (((_local_9) && (_local_9.length > 0)))
                {
                    _local_10 = 0;
                    while (_local_10 < _local_9.length)
                    {
                        _local_11 = _local_9[_local_10];
                        if (((_local_11) && (!(_local_5[_local_11]))))
                        {
                            _local_8.push(_local_11);
                            _local_7.push(_local_11);
                        };
                        _local_10++;
                    };
                };
                _local_6++;
            };
            if (_local_7.length > 0)
            {
                cachedItemsChangeEffect.targets = _local_8;
                cachedItemsChangeEffect.captureMoreStartValues(_local_7);
            };
            cachedItemsChangeEffect.captureEndValues();
            modifiedCollectionView.showPreservedState = true;
            iterator.seek(CursorBookmark.FIRST, _local_3);
            itemsSizeChanged = true;
            updateDisplayList(_arg_1, _arg_2);
            initiateSelectionTracking(_local_8);
            cachedItemsChangeEffect.addEventListener(EffectEvent.EFFECT_END, finishDataChangeEffect);
            cachedItemsChangeEffect.play();
        }

        [Bindable("labelFunctionChanged")]
        public function get labelFunction():Function
        {
            return (_labelFunction);
        }

        [Bindable("dataTipFieldChanged")]
        public function get dataTipField():String
        {
            return (_dataTipField);
        }

        protected function adjustListContent(_arg_1:Number=-1, _arg_2:Number=-1):void
        {
            if (_arg_2 < 0)
            {
                _arg_2 = oldUnscaledHeight;
                _arg_1 = oldUnscaledWidth;
            };
            var _local_3:Number = (viewMetrics.left + listContent.leftOffset);
            var _local_4:Number = (viewMetrics.top + listContent.topOffset);
            listContent.move(_local_3, _local_4);
            var _local_5:Number = ((Math.max(0, listContent.rightOffset) - _local_3) - viewMetrics.right);
            var _local_6:Number = ((Math.max(0, listContent.bottomOffset) - _local_4) - viewMetrics.bottom);
            listContent.setActualSize((_arg_1 + _local_5), (_arg_2 + _local_6));
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selectedIndex():int
        {
            return (_selectedIndex);
        }

        mx_internal function setBookmarkPendingFailureHandler(_arg_1:Object, _arg_2:Object):void
        {
        }

        private function insertSelectionDataBefore(_arg_1:String, _arg_2:ListBaseSelectionData, _arg_3:ListBaseSelectionData):void
        {
            if (_arg_3 == null)
            {
                firstSelectionData = (lastSelectionData = _arg_2);
            }
            else
            {
                if (_arg_3 == firstSelectionData)
                {
                    firstSelectionData = _arg_2;
                };
                _arg_2.nextSelectionData = _arg_3;
                _arg_2.prevSelectionData = _arg_3.prevSelectionData;
                _arg_3.prevSelectionData = _arg_2;
            };
            selectedData[_arg_1] = _arg_2;
        }

        mx_internal function getCaretIndex():int
        {
            return (caretIndex);
        }

        mx_internal function removeClipMask():void
        {
            var _local_7:DisplayObject;
            if (((listContent) && (listContent.mask)))
            {
                return;
            };
            var _local_1:int = (listItems.length - 1);
            if (_local_1 < 0)
            {
                return;
            };
            var _local_2:Number = rowInfo[_local_1].height;
            var _local_3:ListRowInfo = rowInfo[_local_1];
            var _local_4:Array = listItems[_local_1];
            var _local_5:int = _local_4.length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_7 = _local_4[_local_6];
                if ((_local_7 is IUITextField))
                {
                    if (_local_7.height != (_local_2 - (_local_7.y - _local_3.y)))
                    {
                        _local_7.height = (_local_2 - (_local_7.y - _local_3.y));
                    };
                }
                else
                {
                    if (((_local_7) && (_local_7.mask)))
                    {
                        itemMaskFreeList.push(_local_7.mask);
                        _local_7.mask = null;
                    };
                };
                _local_6++;
            };
        }

        mx_internal function reconstructDataFromListItems():Array
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:IListItemRenderer;
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:int;
            if (!listItems)
            {
                return ([]);
            };
            _local_1 = [];
            _local_2 = 0;
            while (_local_2 < listItems.length)
            {
                if (listItems[_local_2])
                {
                    _local_3 = (listItems[_local_2][0] as IListItemRenderer);
                    if (_local_3)
                    {
                        _local_4 = _local_3.data;
                        _local_1.push(_local_4);
                        _local_6 = 0;
                        while (_local_6 < listItems[_local_2].length)
                        {
                            _local_3 = (listItems[_local_2][_local_6] as IListItemRenderer);
                            if (_local_3)
                            {
                                _local_5 = _local_3.data;
                                if (_local_5 != _local_4)
                                {
                                    _local_1.push(_local_5);
                                };
                            };
                            _local_6++;
                        };
                    };
                };
                _local_2++;
            };
            return (_local_1);
        }

        public function set dataTipFunction(_arg_1:Function):void
        {
            _dataTipFunction = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("dataTipFunctionChanged"));
        }

        private function calculateSelectedIndexAndItem():void
        {
            var _local_2:String;
            var _local_1:int;
            for (_local_2 in selectedData)
            {
                _local_1 = 1;
                break;
            };
            if (!_local_1)
            {
                _selectedIndex = -1;
                _selectedItem = null;
                return;
            };
            _selectedIndex = selectedData[_local_2].index;
            _selectedItem = selectedData[_local_2].data;
        }

        protected function scrollPositionToIndex(_arg_1:int, _arg_2:int):int
        {
            return ((iterator) ? _arg_2 : -1);
        }

        override protected function createChildren():void
        {
            super.createChildren();
            if (!listContent)
            {
                listContent = new ListBaseContentHolder(this);
                listContent.styleName = new StyleProxy(this, listContentStyleFilters);
                addChild(listContent);
            };
            if (!selectionLayer)
            {
                selectionLayer = listContent.selectionLayer;
            };
        }

        public function findString(str:String):Boolean
        {
            var cursorPos:CursorBookmark;
            var bMovedNext:Boolean;
            if (((!(collection)) || (collection.length == 0)))
            {
                return (false);
            };
            cursorPos = iterator.bookmark;
            var stopIndex:int = selectedIndex;
            var i:int = (stopIndex + 1);
            if (selectedIndex == -1)
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, 0);
                }
                catch(e1:ItemPendingError)
                {
                    e1.addResponder(new ItemResponder(findPendingResultHandler, findPendingFailureHandler, new ListBaseFindPending(str, cursorPos, CursorBookmark.FIRST, 0, 0, collection.length)));
                    iteratorValid = false;
                    return (false);
                };
                stopIndex = collection.length;
                i = 0;
            }
            else
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, stopIndex);
                }
                catch(e2:ItemPendingError)
                {
                    if (anchorIndex == (collection.length - 1))
                    {
                        e2.addResponder(new ItemResponder(findPendingResultHandler, findPendingFailureHandler, new ListBaseFindPending(str, cursorPos, CursorBookmark.FIRST, 0, 0, collection.length)));
                    }
                    else
                    {
                        e2.addResponder(new ItemResponder(findPendingResultHandler, findPendingFailureHandler, new ListBaseFindPending(str, cursorPos, anchorBookmark, 1, (anchorIndex + 1), anchorIndex)));
                    };
                    iteratorValid = false;
                    return (false);
                };
                bMovedNext = false;
                try
                {
                    bMovedNext = iterator.moveNext();
                }
                catch(e3:ItemPendingError)
                {
                    e3.addResponder(new ItemResponder(findPendingResultHandler, findPendingFailureHandler, new ListBaseFindPending(str, cursorPos, anchorBookmark, 1, (anchorIndex + 1), anchorIndex)));
                    iteratorValid = false;
                    return (false);
                };
                if (!bMovedNext)
                {
                    try
                    {
                        iterator.seek(CursorBookmark.FIRST, 0);
                    }
                    catch(e4:ItemPendingError)
                    {
                        e4.addResponder(new ItemResponder(findPendingResultHandler, findPendingFailureHandler, new ListBaseFindPending(str, cursorPos, CursorBookmark.FIRST, 0, 0, collection.length)));
                        iteratorValid = false;
                        return (false);
                    };
                    stopIndex = collection.length;
                    i = 0;
                };
            };
            return (findStringLoop(str, cursorPos, i, stopIndex));
        }

        private function commitSelectedItem(_arg_1:Object, _arg_2:Boolean=true):void
        {
            if (_arg_2)
            {
                clearSelected();
            };
            if (_arg_1 != null)
            {
                commitSelectedItems([_arg_1]);
            };
        }

        [Bindable("selectedItemsCompareFunctionChanged")]
        public function get selectedItemsCompareFunction():Function
        {
            return (_selectedItemsCompareFunction);
        }

        mx_internal function commitSelectedIndex(value:int):void
        {
            var bookmark:CursorBookmark;
            var len:int;
            var data:Object;
            var selectedBookmark:CursorBookmark;
            var uid:String;
            if (value != -1)
            {
                value = Math.min(value, (collection.length - 1));
                bookmark = iterator.bookmark;
                len = (value - scrollPositionToIndex((horizontalScrollPosition - offscreenExtraColumnsLeft), (verticalScrollPosition - offscreenExtraRowsTop)));
                try
                {
                    iterator.seek(CursorBookmark.CURRENT, len);
                }
                catch(e:ItemPendingError)
                {
                    iterator.seek(bookmark, 0);
                    bSelectedIndexChanged = true;
                    _selectedIndex = value;
                    return;
                };
                data = iterator.current;
                selectedBookmark = iterator.bookmark;
                uid = itemToUID(data);
                iterator.seek(bookmark, 0);
                if (!selectedData[uid])
                {
                    if (((listContent) && (UIDToItemRenderer(uid))))
                    {
                        selectItem(UIDToItemRenderer(uid), false, false);
                    }
                    else
                    {
                        clearSelected();
                        insertSelectionDataBefore(uid, new ListBaseSelectionData(data, value, approximate), firstSelectionData);
                        _selectedIndex = value;
                        caretIndex = value;
                        caretBookmark = selectedBookmark;
                        anchorIndex = value;
                        anchorBookmark = selectedBookmark;
                        _selectedItem = data;
                    };
                };
            }
            else
            {
                clearSelected();
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        protected function get visibleData():Object
        {
            return (listContent.visibleData);
        }

        public function set rowHeight(_arg_1:Number):void
        {
            explicitRowHeight = _arg_1;
            if (_rowHeight != _arg_1)
            {
                setRowHeight(_arg_1);
                invalidateSize();
                itemsSizeChanged = true;
                invalidateDisplayList();
                dispatchEvent(new Event("rowHeightChanged"));
            };
        }

        private function seekNextSafely(iterator:IViewCursor, pos:int):Boolean
        {
            try
            {
                iterator.moveNext();
            }
            catch(e:ItemPendingError)
            {
                lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, pos);
                e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                iteratorValid = false;
            };
            return (iteratorValid);
        }

        public function showDropFeedback(_arg_1:DragEvent):void
        {
            var _local_6:Class;
            var _local_7:EdgeMetrics;
            if (!dropIndicator)
            {
                _local_6 = getStyle("dropIndicatorSkin");
                if (!_local_6)
                {
                    _local_6 = ListDropIndicator;
                };
                dropIndicator = IFlexDisplayObject(new (_local_6)());
                _local_7 = viewMetrics;
                drawFocus(true);
                dropIndicator.x = 2;
                dropIndicator.setActualSize((listContent.width - 4), 4);
                dropIndicator.visible = true;
                listContent.addChild(DisplayObject(dropIndicator));
                if (collection)
                {
                    if (dragScrollingInterval == 0)
                    {
                        dragScrollingInterval = setInterval(dragScroll, 15);
                    };
                };
            };
            var _local_2:int = listItems.length;
            var _local_3:int = (((rowInfo[((_local_2 - offscreenExtraRowsBottom) - 1)].y + rowInfo[((_local_2 - offscreenExtraRowsBottom) - 1)].height) > (listContent.heightExcludingOffsets - listContent.topOffset)) ? 1 : 0);
            var _local_4:Number = calculateDropIndex(_arg_1);
            _local_4 = (_local_4 - verticalScrollPosition);
            var _local_5:Number = listItems.length;
            if (_local_4 >= _local_5)
            {
                if (_local_3)
                {
                    _local_4 = (_local_5 - 1);
                }
                else
                {
                    _local_4 = _local_5;
                };
            };
            if (_local_4 < 0)
            {
                _local_4 = 0;
            };
            dropIndicator.y = calculateDropIndicatorY(_local_5, (_local_4 + offscreenExtraRowsTop));
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
            if (((_listData) && (_listData is DataGridListData)))
            {
                selectedItem = _data[DataGridListData(_listData).dataField];
            }
            else
            {
                if (((_listData is ListData) && (ListData(_listData).labelField in _data)))
                {
                    selectedItem = _data[ListData(_listData).labelField];
                }
                else
                {
                    selectedItem = _data;
                };
            };
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        public function get rowCount():int
        {
            return (_rowCount);
        }

        mx_internal function get rendererArray():Array
        {
            return (listItems);
        }

        public function get columnCount():int
        {
            return (_columnCount);
        }

        protected function purgeItemRenderers():void
        {
            var _local_1:*;
            var _local_2:Array;
            var _local_3:IListItemRenderer;
            var _local_4:DisplayObject;
            var _local_5:Dictionary;
            var _local_6:*;
            rendererChanged = false;
            while (listItems.length)
            {
                _local_2 = listItems.pop();
                while (_local_2.length)
                {
                    _local_3 = IListItemRenderer(_local_2.pop());
                    if (_local_3)
                    {
                        listContent.removeChild(DisplayObject(_local_3));
                        if (dataItemWrappersByRenderer[_local_3])
                        {
                            delete visibleData[itemToUID(dataItemWrappersByRenderer[_local_3])];
                        }
                        else
                        {
                            delete visibleData[itemToUID(_local_3.data)];
                        };
                    };
                };
            };
            while (freeItemRenderers.length)
            {
                _local_4 = DisplayObject(freeItemRenderers.pop());
                if (_local_4.parent)
                {
                    listContent.removeChild(_local_4);
                };
            };
            for (_local_1 in freeItemRenderersByFactory)
            {
                _local_5 = freeItemRenderersByFactory[_local_1];
                for (_local_6 in _local_5)
                {
                    _local_4 = DisplayObject(_local_6);
                    delete _local_5[_local_6];
                    if (_local_4.parent)
                    {
                        listContent.removeChild(_local_4);
                    };
                };
            };
            rowMap = {};
            listContent.rowInfo = [];
        }

        protected function mouseEventToItemRenderer(_arg_1:MouseEvent):IListItemRenderer
        {
            return (mouseEventToItemRendererOrEditor(_arg_1));
        }

        protected function UIDToItemRenderer(_arg_1:String):IListItemRenderer
        {
            if (!listContent)
            {
                return (null);
            };
            return (visibleData[_arg_1]);
        }

        public function get dragEnabled():Boolean
        {
            return (_dragEnabled);
        }

        private function findPendingResultHandler(_arg_1:Object, _arg_2:ListBaseFindPending):void
        {
            iterator.seek(_arg_2.bookmark, _arg_2.offset);
            findStringLoop(_arg_2.searchString, _arg_2.startingBookmark, _arg_2.currentIndex, _arg_2.stopIndex);
        }

        protected function set allowItemSizeChangeNotification(_arg_1:Boolean):void
        {
            listContent.allowItemSizeChangeNotification = _arg_1;
        }

        [Bindable("iconFunctionChanged")]
        public function get iconFunction():Function
        {
            return (_iconFunction);
        }

        protected function collectionChangeHandler(event:Event):void
        {
            var len:int;
            var index:int;
            var i:int;
            var data:ListBaseSelectionData;
            var p:String;
            var selectedUID:String;
            var ce:CollectionEvent;
            var emitEvent:Boolean;
            var oldUID:String;
            var sd:ListBaseSelectionData;
            var requiresValueCommit:Boolean;
            var firstUID:String;
            var uid:String;
            var deletedItems:Array;
            var fakeRemove:CollectionEvent;
            if ((event is CollectionEvent))
            {
                ce = CollectionEvent(event);
                if (ce.kind == CollectionEventKind.ADD)
                {
                    prepareDataEffect(ce);
                    if (((ce.location == 0) && (verticalScrollPosition == 0)))
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
                            e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                            iteratorValid = false;
                        };
                    }
                    else
                    {
                        if (((listType == "vertical") && (verticalScrollPosition >= ce.location)))
                        {
                            super.verticalScrollPosition = (super.verticalScrollPosition + ce.items.length);
                        };
                    };
                    emitEvent = adjustAfterAdd(ce.items, ce.location);
                    if (emitEvent)
                    {
                        dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                    };
                }
                else
                {
                    if (ce.kind == CollectionEventKind.REPLACE)
                    {
                        selectedUID = ((selectedItem) ? itemToUID(selectedItem) : null);
                        len = ce.items.length;
                        i = 0;
                        while (i < len)
                        {
                            oldUID = itemToUID(ce.items[i].oldValue);
                            sd = selectedData[oldUID];
                            if (sd)
                            {
                                sd.data = ce.items[i].newValue;
                                delete selectedData[oldUID];
                                selectedData[itemToUID(sd.data)] = sd;
                                if (selectedUID == oldUID)
                                {
                                    _selectedItem = sd.data;
                                    dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                                };
                            };
                            i = (i + 1);
                        };
                        prepareDataEffect(ce);
                    }
                    else
                    {
                        if (ce.kind == CollectionEventKind.REMOVE)
                        {
                            prepareDataEffect(ce);
                            requiresValueCommit = false;
                            if (((listItems.length) && (listItems[0].length)))
                            {
                                firstUID = rowMap[listItems[0][0].name].uid;
                                selectedUID = ((selectedItem) ? itemToUID(selectedItem) : null);
                                i = 0;
                                while (i < ce.items.length)
                                {
                                    uid = itemToUID(ce.items[i]);
                                    if (((uid == firstUID) && (verticalScrollPosition == 0)))
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
                                        catch(e1:ItemPendingError)
                                        {
                                            lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, 0);
                                            e1.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                                            iteratorValid = false;
                                        };
                                    };
                                    if (selectedData[uid])
                                    {
                                        removeSelectionData(uid);
                                    };
                                    if (selectedUID == uid)
                                    {
                                        _selectedItem = null;
                                        _selectedIndex = -1;
                                        requiresValueCommit = true;
                                    };
                                    removeIndicators(uid);
                                    i = (i + 1);
                                };
                                if (((listType == "vertical") && (verticalScrollPosition >= ce.location)))
                                {
                                    if (verticalScrollPosition > ce.location)
                                    {
                                        super.verticalScrollPosition = (verticalScrollPosition - Math.min(ce.items.length, (verticalScrollPosition - ce.location)));
                                    }
                                    else
                                    {
                                        if (verticalScrollPosition >= collection.length)
                                        {
                                            super.verticalScrollPosition = Math.max((collection.length - 1), 0);
                                        };
                                    };
                                    try
                                    {
                                        offscreenExtraRowsTop = Math.min(offscreenExtraRowsTop, verticalScrollPosition);
                                        index = scrollPositionToIndex(horizontalScrollPosition, (verticalScrollPosition - offscreenExtraRowsTop));
                                        iterator.seek(CursorBookmark.FIRST, index);
                                        if (!iteratorValid)
                                        {
                                            iteratorValid = true;
                                            lastSeekPending = null;
                                        };
                                    }
                                    catch(e2:ItemPendingError)
                                    {
                                        lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, index);
                                        e2.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                                        iteratorValid = false;
                                    };
                                };
                                emitEvent = adjustAfterRemove(ce.items, ce.location, requiresValueCommit);
                                if (emitEvent)
                                {
                                    dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                                };
                            };
                        }
                        else
                        {
                            if (ce.kind == CollectionEventKind.MOVE)
                            {
                                if (ce.oldLocation < ce.location)
                                {
                                    for (p in selectedData)
                                    {
                                        data = selectedData[p];
                                        if (((data.index > ce.oldLocation) && (data.index < ce.location)))
                                        {
                                            data.index--;
                                        }
                                        else
                                        {
                                            if (data.index == ce.oldLocation)
                                            {
                                                data.index = ce.location;
                                            };
                                        };
                                    };
                                    if (((_selectedIndex > ce.oldLocation) && (_selectedIndex < ce.location)))
                                    {
                                        _selectedIndex--;
                                    }
                                    else
                                    {
                                        if (_selectedIndex == ce.oldLocation)
                                        {
                                            _selectedIndex = ce.location;
                                        };
                                    };
                                }
                                else
                                {
                                    if (ce.location < ce.oldLocation)
                                    {
                                        for (p in selectedData)
                                        {
                                            data = selectedData[p];
                                            if (((data.index > ce.location) && (data.index < ce.oldLocation)))
                                            {
                                                data.index++;
                                            }
                                            else
                                            {
                                                if (data.index == ce.oldLocation)
                                                {
                                                    data.index = ce.location;
                                                };
                                            };
                                        };
                                        if (((_selectedIndex > ce.location) && (_selectedIndex < ce.oldLocation)))
                                        {
                                            _selectedIndex++;
                                        }
                                        else
                                        {
                                            if (_selectedIndex == ce.oldLocation)
                                            {
                                                _selectedIndex = ce.location;
                                            };
                                        };
                                    };
                                };
                                if (ce.oldLocation == verticalScrollPosition)
                                {
                                    if (ce.location > maxVerticalScrollPosition)
                                    {
                                        iterator.seek(CursorBookmark.CURRENT, (maxVerticalScrollPosition - ce.location));
                                    };
                                    super.verticalScrollPosition = Math.min(ce.location, maxVerticalScrollPosition);
                                }
                                else
                                {
                                    if (((ce.location >= verticalScrollPosition) && (ce.oldLocation < verticalScrollPosition)))
                                    {
                                        seekNextSafely(iterator, verticalScrollPosition);
                                    }
                                    else
                                    {
                                        if (((ce.location <= verticalScrollPosition) && (ce.oldLocation > verticalScrollPosition)))
                                        {
                                            seekPreviousSafely(iterator, verticalScrollPosition);
                                        };
                                    };
                                };
                            }
                            else
                            {
                                if (ce.kind == CollectionEventKind.REFRESH)
                                {
                                    if (anchorBookmark)
                                    {
                                        try
                                        {
                                            iterator.seek(anchorBookmark, 0);
                                            if (!iteratorValid)
                                            {
                                                iteratorValid = true;
                                                lastSeekPending = null;
                                            };
                                        }
                                        catch(e:ItemPendingError)
                                        {
                                            bSortItemPending = true;
                                            lastSeekPending = new ListBaseSeekPending(anchorBookmark, 0);
                                            e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                                            iteratorValid = false;
                                        }
                                        catch(cursorError:CursorError)
                                        {
                                            clearSelected();
                                        };
                                        adjustAfterSort();
                                    }
                                    else
                                    {
                                        try
                                        {
                                            index = scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition);
                                            iterator.seek(CursorBookmark.FIRST, index);
                                            if (!iteratorValid)
                                            {
                                                iteratorValid = true;
                                                lastSeekPending = null;
                                            };
                                        }
                                        catch(e:ItemPendingError)
                                        {
                                            bSortItemPending = true;
                                            lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, index);
                                            e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                                            iteratorValid = false;
                                        };
                                    };
                                }
                                else
                                {
                                    if (ce.kind == CollectionEventKind.RESET)
                                    {
                                        if (((collection.length == 0) || ((runningDataEffect) && (actualCollection.length == 0))))
                                        {
                                            deletedItems = reconstructDataFromListItems();
                                            if (deletedItems.length)
                                            {
                                                fakeRemove = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                                                fakeRemove.kind = CollectionEventKind.REMOVE;
                                                fakeRemove.items = deletedItems;
                                                fakeRemove.location = 0;
                                                prepareDataEffect(fakeRemove);
                                            };
                                        };
                                        try
                                        {
                                            iterator.seek(CursorBookmark.FIRST);
                                            if (!iteratorValid)
                                            {
                                                iteratorValid = true;
                                                lastSeekPending = null;
                                            };
                                            collectionIterator.seek(CursorBookmark.FIRST);
                                        }
                                        catch(e:ItemPendingError)
                                        {
                                            lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, 0);
                                            e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                                            iteratorValid = false;
                                        };
                                        if (((((bSelectedIndexChanged) || (bSelectedItemChanged)) || (bSelectedIndicesChanged)) || (bSelectedItemsChanged)))
                                        {
                                            bSelectionChanged = true;
                                        }
                                        else
                                        {
                                            commitSelectedIndex(-1);
                                        };
                                        if (isNaN(verticalScrollPositionPending))
                                        {
                                            verticalScrollPositionPending = 0;
                                            super.verticalScrollPosition = 0;
                                        };
                                        if (isNaN(horizontalScrollPositionPending))
                                        {
                                            horizontalScrollPositionPending = 0;
                                            super.horizontalScrollPosition = 0;
                                        };
                                        invalidateSize();
                                    }
                                    else
                                    {
                                        if (ce.kind == CollectionEventKind.UPDATE)
                                        {
                                            selectedUID = ((selectedItem) ? itemToUID(selectedItem) : null);
                                            len = ce.items.length;
                                            i = 0;
                                            while (i < len)
                                            {
                                                if (ce.items[i].property == "uid")
                                                {
                                                    oldUID = ce.items[i].oldValue;
                                                    sd = selectedData[oldUID];
                                                    if (sd)
                                                    {
                                                        sd.data = ce.items[i].target;
                                                        delete selectedData[oldUID];
                                                        selectedData[ce.items[i].newValue] = sd;
                                                        if (selectedUID == oldUID)
                                                        {
                                                            _selectedItem = sd.data;
                                                            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                                                        };
                                                    };
                                                };
                                                i = (i + 1);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        public function set dataProvider(_arg_1:Object):void
        {
            var _local_3:XMLList;
            var _local_4:Array;
            if (collection)
            {
                collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
            };
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
                            if ((_arg_1 is XML))
                            {
                                _local_3 = new XMLList();
                                _local_3 = (_local_3 + _arg_1);
                                collection = new XMLListCollection(_local_3);
                            }
                            else
                            {
                                _local_4 = [];
                                if (_arg_1 != null)
                                {
                                    _local_4.push(_arg_1);
                                };
                                collection = new ArrayCollection(_local_4);
                            };
                        };
                    };
                };
            };
            iterator = collection.createCursor();
            collectionIterator = collection.createCursor();
            collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);
            clearSelectionData();
            var _local_2:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _local_2.kind = CollectionEventKind.RESET;
            collectionChangeHandler(_local_2);
            dispatchEvent(_local_2);
            itemsNeedMeasurement = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
        }

        protected function destroyRow(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IListItemRenderer;
            var _local_4:String = rowInfo[_arg_1].uid;
            removeIndicators(_local_4);
            var _local_5:int;
            while (_local_5 < _arg_2)
            {
                _local_3 = listItems[_arg_1][_local_5];
                if (_local_3.data)
                {
                    delete visibleData[_local_4];
                };
                addToFreeItemRenderers(_local_3);
                _local_5++;
            };
        }

        protected function dragDropHandler(_arg_1:DragEvent):void
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int;
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            hideDropFeedback(_arg_1);
            lastDragEvent = null;
            resetDragScrolling();
            if (((enabled) && (_arg_1.dragSource.hasFormat("items"))))
            {
                if (!dataProvider)
                {
                    dataProvider = [];
                };
                _local_2 = (_arg_1.dragSource.dataForFormat("items") as Array);
                _local_3 = calculateDropIndex(_arg_1);
                if (((_arg_1.action == DragManager.MOVE) && (dragMoveEnabled)))
                {
                    if (_arg_1.dragInitiator == this)
                    {
                        _local_4 = selectedIndices;
                        _local_4.sort(Array.NUMERIC);
                        _local_5 = (_local_4.length - 1);
                        while (_local_5 >= 0)
                        {
                            collectionIterator.seek(CursorBookmark.FIRST, _local_4[_local_5]);
                            if (_local_4[_local_5] < _local_3)
                            {
                                _local_3--;
                            };
                            collectionIterator.remove();
                            _local_5--;
                        };
                        clearSelected(false);
                    };
                };
                collectionIterator.seek(CursorBookmark.FIRST, _local_3);
                _local_5 = (_local_2.length - 1);
                while (_local_5 >= 0)
                {
                    if (_arg_1.action == DragManager.COPY)
                    {
                        collectionIterator.insert(copyItemWithUID(_local_2[_local_5]));
                    }
                    else
                    {
                        if (_arg_1.action == DragManager.MOVE)
                        {
                            collectionIterator.insert(_local_2[_local_5]);
                        };
                    };
                    _local_5--;
                };
            };
            lastDragEvent = null;
        }

        [Bindable("dataTipFunctionChanged")]
        public function get dataTipFunction():Function
        {
            return (_dataTipFunction);
        }

        public function scrollToIndex(_arg_1:int):Boolean
        {
            var _local_2:int;
            if (((_arg_1 >= ((verticalScrollPosition + listItems.length) - offscreenExtraRowsBottom)) || (_arg_1 < verticalScrollPosition)))
            {
                _local_2 = Math.min(_arg_1, maxVerticalScrollPosition);
                verticalScrollPosition = _local_2;
                return (true);
            };
            return (false);
        }

        protected function addToFreeItemRenderers(_arg_1:IListItemRenderer):void
        {
            DisplayObject(_arg_1).visible = false;
            var _local_2:IFactory = factoryMap[_arg_1];
            var _local_3:ItemWrapper = dataItemWrappersByRenderer[_arg_1];
            var _local_4:String = ((_local_3) ? itemToUID(_local_3) : itemToUID(_arg_1.data));
            if (visibleData[_local_4] == _arg_1)
            {
                delete visibleData[_local_4];
            };
            if (_local_3)
            {
                reservedItemRenderers[itemToUID(_local_3)] = _arg_1;
            }
            else
            {
                if (!freeItemRenderersByFactory)
                {
                    freeItemRenderersByFactory = new Dictionary(true);
                };
                if (freeItemRenderersByFactory[_local_2] == undefined)
                {
                    freeItemRenderersByFactory[_local_2] = new Dictionary(true);
                };
                freeItemRenderersByFactory[_local_2][_arg_1] = 1;
                if (_local_2 == itemRenderer)
                {
                    freeItemRenderers.push(_arg_1);
                };
            };
            delete rowMap[_arg_1.name];
        }

        override protected function initializeAccessibility():void
        {
            if (ListBase.createAccessibilityImplementation != null)
            {
                ListBase.createAccessibilityImplementation(this);
            };
        }

        public function isItemSelectable(_arg_1:Object):Boolean
        {
            if (!selectable)
            {
                return (false);
            };
            if (_arg_1 == null)
            {
                return (false);
            };
            return (true);
        }

        private function findPendingFailureHandler(_arg_1:Object, _arg_2:ListBaseFindPending):void
        {
        }

        public function get rowHeight():Number
        {
            return (_rowHeight);
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        mx_internal function adjustOffscreenRowsAndColumns():void
        {
            offscreenExtraColumns = 0;
            offscreenExtraRows = offscreenExtraRowsOrColumns;
        }

        protected function indexToRow(_arg_1:int):int
        {
            return (_arg_1);
        }

        protected function get dragImageOffsets():Point
        {
            var _local_1:Point = new Point();
            var _local_2:int = listItems.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (selectedData[rowInfo[_local_3].uid])
                {
                    _local_1.x = listItems[_local_3][0].x;
                    _local_1.y = listItems[_local_3][0].y;
                };
                _local_3++;
            };
            return (_local_1);
        }

        [Bindable("collectionChange")]
        public function get dataProvider():Object
        {
            if (actualCollection)
            {
                return (actualCollection);
            };
            return (collection);
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (IS_ITEM_STYLE[_arg_1])
            {
                itemsSizeChanged = true;
                invalidateDisplayList();
            }
            else
            {
                if (_arg_1 == "paddingTop")
                {
                    cachedPaddingTopInvalid = true;
                    invalidateProperties();
                }
                else
                {
                    if (_arg_1 == "paddingBottom")
                    {
                        cachedPaddingBottomInvalid = true;
                        invalidateProperties();
                    }
                    else
                    {
                        if (_arg_1 == "verticalAlign")
                        {
                            cachedVerticalAlignInvalid = true;
                            invalidateProperties();
                        }
                        else
                        {
                            if (_arg_1 == "itemsChangeEffect")
                            {
                                cachedItemsChangeEffect = null;
                            }
                            else
                            {
                                if (((listContent) && (listItems)))
                                {
                                    _local_2 = listItems.length;
                                    _local_3 = 0;
                                    while (_local_3 < _local_2)
                                    {
                                        _local_4 = listItems[_local_3].length;
                                        _local_5 = 0;
                                        while (_local_5 < _local_4)
                                        {
                                            if (listItems[_local_3][_local_5])
                                            {
                                                listItems[_local_3][_local_5].styleChanged(_arg_1);
                                            };
                                            _local_5++;
                                        };
                                        _local_3++;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            super.styleChanged(_arg_1);
            if (invalidateSizeFlag)
            {
                itemsNeedMeasurement = true;
                invalidateProperties();
            };
            if (StyleManager.isSizeInvalidatingStyle(_arg_1))
            {
                scrollAreaChanged = true;
            };
        }

        private function selectionPendingResultHandler(_arg_1:Object, _arg_2:ListBaseSelectionPending):void
        {
            iterator.seek(_arg_2.bookmark, _arg_2.offset);
            shiftSelectionLoop(_arg_2.incrementing, _arg_2.index, _arg_2.stopData, _arg_2.transition, _arg_2.placeHolder);
        }

        public function set selectedItems(_arg_1:Array):void
        {
            if (((!(collection)) || (collection.length == 0)))
            {
                _selectedItems = _arg_1;
                bSelectedItemsChanged = true;
                bSelectionChanged = true;
                invalidateDisplayList();
                return;
            };
            commitSelectedItems(_arg_1);
        }

        public function itemToDataTip(data:Object):String
        {
            if (data == null)
            {
                return (" ");
            };
            if (dataTipFunction != null)
            {
                return (dataTipFunction(data));
            };
            if ((data is XML))
            {
                try
                {
                    if (data[dataTipField].length() != 0)
                    {
                        data = data[dataTipField];
                    };
                }
                catch(e:Error)
                {
                };
            }
            else
            {
                if ((data is Object))
                {
                    try
                    {
                        if (data[dataTipField] != null)
                        {
                            data = data[dataTipField];
                        }
                        else
                        {
                            if (data.label != null)
                            {
                                data = data.label;
                            };
                        };
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            if ((data is String))
            {
                return (String(data));
            };
            try
            {
                return (data.toString());
            }
            catch(e:Error)
            {
            };
            return (" ");
        }

        protected function dragStartHandler(_arg_1:DragEvent):void
        {
            var _local_2:DragSource;
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            _local_2 = new DragSource();
            addDragData(_local_2);
            DragManager.doDrag(this, _local_2, _arg_1, dragImage, 0, 0, 0.5, dragMoveEnabled);
        }

        private function cleanupAfterDataChangeEffect():void
        {
            if (((runningDataEffect) || (runDataEffectNextUpdate)))
            {
                return;
            };
            var _local_1:int = scrollPositionToIndex((horizontalScrollPosition - offscreenExtraColumnsLeft), (verticalScrollPosition - offscreenExtraRowsTop));
            iterator.seek(CursorBookmark.FIRST, _local_1);
            dataEffectCompleted = true;
            itemsSizeChanged = true;
            invalidateList();
            dataItemWrappersByRenderer = new Dictionary();
        }

        mx_internal function setBookmarkPendingResultHandler(data:Object, info:Object):void
        {
            var placeHolder:CursorBookmark;
            placeHolder = iterator.bookmark;
            try
            {
                iterator.seek(CursorBookmark.FIRST, info.value);
                this[info.property] = iterator.bookmark;
            }
            catch(e:ItemPendingError)
            {
                e.addResponder(new ItemResponder(setBookmarkPendingResultHandler, setBookmarkPendingFailureHandler, info));
            };
            iterator.seek(placeHolder);
        }

        protected function removeIndicators(_arg_1:String):void
        {
            if (selectionTweens[_arg_1])
            {
                selectionTweens[_arg_1].removeEventListener(TweenEvent.TWEEN_UPDATE, selectionTween_updateHandler);
                selectionTweens[_arg_1].removeEventListener(TweenEvent.TWEEN_END, selectionTween_endHandler);
                if (selectionIndicators[_arg_1].alpha < 1)
                {
                    Tween.removeTween(selectionTweens[_arg_1]);
                };
                delete selectionTweens[_arg_1];
            };
            if (selectionIndicators[_arg_1])
            {
                selectionIndicators[_arg_1].parent.removeChild(selectionIndicators[_arg_1]);
                selectionIndicators[_arg_1] = null;
            };
            if (_arg_1 == highlightUID)
            {
                highlightItemRenderer = null;
                highlightUID = null;
                clearHighlightIndicator(highlightIndicator, UIDToItemRenderer(_arg_1));
            };
            if (_arg_1 == caretUID)
            {
                caretItemRenderer = null;
                caretUID = null;
                clearCaretIndicator(caretIndicator, UIDToItemRenderer(_arg_1));
            };
        }

        private function mouseIsUp():void
        {
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseLeaveHandler);
            if (((!(dragEnabled)) && (!(dragScrollingInterval == 0))))
            {
                clearInterval(dragScrollingInterval);
                dragScrollingInterval = 0;
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:CursorBookmark;
            var _local_6:int;
            super.updateDisplayList(_arg_1, _arg_2);
            if ((((((oldUnscaledWidth == _arg_1) && (oldUnscaledHeight == _arg_2)) && (!(itemsSizeChanged))) && (!(bSelectionChanged))) && (!(scrollAreaChanged))))
            {
                return;
            };
            if (oldUnscaledWidth != _arg_1)
            {
                itemsSizeChanged = true;
            };
            removeClipMask();
            var _local_4:Graphics = selectionLayer.graphics;
            _local_4.clear();
            if (((listContent.width > 0) && (listContent.height > 0)))
            {
                _local_4.beginFill(0x808080, 0);
                _local_4.drawRect(0, 0, listContent.width, listContent.height);
                _local_4.endFill();
            };
            if (rendererChanged)
            {
                purgeItemRenderers();
            }
            else
            {
                if (dataEffectCompleted)
                {
                    partialPurgeItemRenderers();
                };
            };
            adjustListContent(_arg_1, _arg_2);
            var _local_5:Boolean = ((collection) && (collection.length > 0));
            if (_local_5)
            {
                adjustScrollPosition();
            };
            if (((((((oldUnscaledWidth == _arg_1) && (!(scrollAreaChanged))) && (!(itemsSizeChanged))) && (listItems.length > 0)) && (iterator)) && (columnCount == 1)))
            {
                _local_6 = (listItems.length - 1);
                if (oldUnscaledHeight > _arg_2)
                {
                    reduceRows(_local_6);
                }
                else
                {
                    makeAdditionalRows(_local_6);
                };
            }
            else
            {
                if (iterator)
                {
                    _local_3 = iterator.bookmark;
                };
                clearIndicators();
                rendererTrackingSuspended = true;
                if (iterator)
                {
                    if ((((offscreenExtraColumns) || (offscreenExtraColumnsLeft)) || (offscreenExtraColumnsRight)))
                    {
                        makeRowsAndColumnsWithExtraColumns(_arg_1, _arg_2);
                    }
                    else
                    {
                        makeRowsAndColumnsWithExtraRows(_arg_1, _arg_2);
                    };
                }
                else
                {
                    makeRowsAndColumns(0, 0, listContent.width, listContent.height, 0, 0);
                };
                rendererTrackingSuspended = false;
                seekPositionIgnoreError(iterator, _local_3);
            };
            oldUnscaledWidth = _arg_1;
            oldUnscaledHeight = _arg_2;
            configureScrollBars();
            addClipMask(true);
            itemsSizeChanged = false;
            wordWrapChanged = false;
            adjustSelectionSettings(_local_5);
            if (((keySelectionPending) && (iteratorValid)))
            {
                keySelectionPending = false;
                finishKeySelection();
            };
        }

        protected function dragCompleteHandler(_arg_1:DragEvent):void
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:int;
            isPressed = false;
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            if (((_arg_1.action == DragManager.MOVE) && (dragMoveEnabled)))
            {
                if (_arg_1.relatedObject != this)
                {
                    _local_2 = selectedIndices;
                    _local_2.sort(Array.NUMERIC);
                    _local_3 = _local_2.length;
                    _local_4 = (_local_3 - 1);
                    while (_local_4 >= 0)
                    {
                        collectionIterator.seek(CursorBookmark.FIRST, _local_2[_local_4]);
                        collectionIterator.remove();
                        _local_4--;
                    };
                    clearSelected(false);
                };
            };
            lastDragEvent = null;
            resetDragScrolling();
        }

        public function getItemRendererFactory(_arg_1:Object):IFactory
        {
            if (_arg_1 == null)
            {
                return (nullItemRenderer);
            };
            return (itemRenderer);
        }


    }
}//package mx.controls.listClasses

