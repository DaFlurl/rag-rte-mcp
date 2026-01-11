// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridBase

package mx.controls.dataGridClasses
{
    import mx.controls.listClasses.ListBase;
    import mx.core.IFontContextComponent;
    import flash.display.Shape;
    import flash.utils.Dictionary;
    import mx.controls.listClasses.ListBaseContentHolder;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import mx.controls.listClasses.ListRowInfo;
    import mx.core.IUITextField;
    import flash.events.Event;
    import mx.controls.listClasses.IListItemRenderer;
    import flash.geom.Point;
    import mx.core.SpriteAsset;
    import mx.events.ListEvent;
    import flash.ui.Keyboard;
    import flash.display.Graphics;
    import mx.core.UIComponentGlobals;
    import mx.core.EdgeMetrics;
    import mx.skins.halo.ListDropIndicator;
    import mx.core.IFlexDisplayObject;
    import flash.utils.setInterval;
    import mx.events.DragEvent;
    import mx.collections.CursorBookmark;
    import mx.events.TweenEvent;
    import mx.core.IFlexModuleFactory;
    import mx.core.IInvalidating;
    import mx.controls.listClasses.BaseListData;
    import mx.collections.errors.ItemPendingError;
    import mx.controls.listClasses.ListBaseSeekPending;
    import mx.collections.ItemResponder;
    import mx.core.IFactory;
    import mx.events.ScrollEvent;
    import mx.events.ScrollEventDetail;
    import mx.events.ScrollEventDirection;
    import mx.core.IUIComponent;
    import flash.events.MouseEvent;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.collections.IViewCursor;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridBase extends ListBase implements IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _showHeaders:Boolean = true;
        mx_internal var visibleColumns:Array;
        private var lockedColumnMask:Shape;
        protected var headerMask:Shape;
        protected var freeItemRenderersTable:Dictionary;
        mx_internal var visibleLockedColumns:Array;
        protected var columnMap:Object;
        private var lockedColumnAndRowMask:Shape;
        private var bSelectItem:Boolean = false;
        private var bCtrlKey:Boolean = false;
        private var inSelectItem:Boolean = false;
        private var lockedRowCountChanged:Boolean = false;
        private var lockedColumnHeaderMask:Shape;
        mx_internal var _explicitHeaderHeight:Boolean;
        protected var lockedColumnAndRowContent:DataGridLockedRowContentHolder;
        protected var lockedColumnContent:ListBaseContentHolder;
        mx_internal var columnsInvalid:Boolean = true;
        private var lockedRowMask:Shape;
        protected var header:DataGridHeaderBase;
        mx_internal var _lockedColumnCount:int = 0;
        mx_internal var _lockedRowCount:int = 0;
        protected var lockedColumnHeader:DataGridHeaderBase;
        protected var columnHighlightIndicator:Sprite;
        protected var columnCaretIndicator:Sprite;
        private var lockedColumnCountChanged:Boolean = false;
        protected var lockedRowContent:DataGridLockedRowContentHolder;
        private var lastKey:uint = 0;
        mx_internal var _headerHeight:Number = 22;
        private var bShiftKey:Boolean = false;

        mx_internal var headerClass:Class = DataGridHeader;
        private var indicatorDictionary:Dictionary = new Dictionary(true);

        public function DataGridBase()
        {
            listType = "vertical";
            defaultRowCount = 7;
            columnMap = {};
            freeItemRenderersTable = new Dictionary(false);
        }

        mx_internal function get dataGridLockedColumnAndRows():ListBaseContentHolder
        {
            return (lockedColumnAndRowContent);
        }

        override protected function removeFromRowArrays(_arg_1:int):void
        {
            super.removeFromRowArrays(_arg_1);
            if (lockedColumnCount)
            {
                lockedColumnContent.listItems.splice(_arg_1, 1);
                lockedColumnContent.rowInfo.splice(_arg_1, 1);
            };
        }

        override mx_internal function removeClipMask():void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:DisplayObject;
            super.removeClipMask();
            if (!lockedColumnContent)
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
            var _local_4:Array = lockedColumnContent.listItems[_local_1];
            if (_local_4)
            {
                _local_5 = _local_4.length;
                _local_6 = 0;
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
            };
        }

        private function selectionRemovedListener(_arg_1:Event):void
        {
            if (!lockedColumnCount)
            {
                return;
            };
            var _local_2:Sprite = (indicatorDictionary[_arg_1.target] as Sprite);
            if (_local_2)
            {
                _local_2.parent.removeChild(_local_2);
            };
        }

        override protected function shiftRow(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean):void
        {
            var _local_5:Array;
            var _local_6:IListItemRenderer;
            var _local_7:int;
            super.shiftRow(_arg_1, _arg_2, _arg_3, _arg_4);
            if (lockedColumnCount)
            {
                _local_5 = lockedColumnContent.listItems;
                _arg_3 = _local_5[_arg_1].length;
                _local_7 = 0;
                while (_local_7 < _arg_3)
                {
                    _local_6 = _local_5[_arg_1][_local_7];
                    if (_arg_4)
                    {
                        _local_5[_arg_2][_local_7] = _local_6;
                        rowMap[_local_6.name].rowIndex = _arg_2;
                    }
                    else
                    {
                        rowMap[_local_6.name].rowIndex = _arg_1;
                    };
                    _local_7++;
                };
                if (_arg_4)
                {
                    lockedColumnContent.rowInfo[_arg_2] = lockedColumnContent.rowInfo[_arg_1];
                };
            };
        }

        protected function makeRow(_arg_1:ListBaseContentHolder, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Object, _arg_7:String):Number
        {
            var _local_9:ListBaseContentHolder;
            var _local_10:IListItemRenderer;
            var _local_11:IListItemRenderer;
            var _local_12:DataGridColumn;
            var _local_13:Point;
            var _local_8:Array = _arg_1.listItems;
            if (lockedColumnCount > 0)
            {
                if (_arg_1 == lockedRowContent)
                {
                    _local_9 = lockedColumnAndRowContent;
                }
                else
                {
                    _local_9 = lockedColumnContent;
                };
            }
            else
            {
                _local_9 = null;
            };
            var _local_14:int;
            var _local_15:Number = _arg_3;
            var _local_16:Number = 0;
            while (_local_14 < visibleLockedColumns.length)
            {
                _local_12 = visibleLockedColumns[_local_14];
                _local_10 = setupColumnItemRenderer(_local_12, _local_9, _arg_2, _local_14, _arg_6, _arg_7);
                _local_13 = layoutColumnItemRenderer(_local_12, _local_10, _local_15, _arg_5);
                _local_15 = (_local_15 + _local_13.x);
                _local_14++;
                _local_16 = Math.ceil(Math.max(_local_16, ((variableRowHeight) ? ((_local_13.y + cachedPaddingTop) + cachedPaddingBottom) : rowHeight)));
            };
            if (visibleLockedColumns.length)
            {
                while (_local_9.listItems[_arg_2].length > _local_14)
                {
                    _local_11 = _local_9.listItems[_arg_2].pop();
                    addToFreeItemRenderers(_local_11);
                };
            };
            _local_14 = 0;
            _local_15 = _arg_3;
            while (((_local_15 < _arg_4) && (_local_14 < visibleColumns.length)))
            {
                _local_12 = visibleColumns[_local_14];
                _local_10 = setupColumnItemRenderer(_local_12, _arg_1, _arg_2, _local_14, _arg_6, _arg_7);
                _local_13 = layoutColumnItemRenderer(_local_12, _local_10, _local_15, _arg_5);
                _local_15 = (_local_15 + _local_13.x);
                _local_14++;
                _local_16 = Math.ceil(Math.max(_local_16, ((variableRowHeight) ? ((_local_13.y + cachedPaddingTop) + cachedPaddingBottom) : rowHeight)));
            };
            while (_local_8[_arg_2].length > _local_14)
            {
                _local_11 = _local_8[_arg_2].pop();
                addToFreeItemRenderers(_local_11);
            };
            return (_local_16);
        }

        [Bindable("resize")]
        public function get headerHeight():Number
        {
            return (_headerHeight);
        }

        mx_internal function columnHeaderWordWrap(_arg_1:DataGridColumn):Boolean
        {
            if (_arg_1.headerWordWrap == true)
            {
                return (true);
            };
            if (_arg_1.headerWordWrap == false)
            {
                return (false);
            };
            return (wordWrap);
        }

        override protected function drawHighlightIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:ListBaseContentHolder;
            var _local_9:Sprite;
            super.drawHighlightIndicator(_arg_1, _arg_2, _arg_3, ((unscaledWidth - viewMetrics.left) - viewMetrics.right), _arg_5, _arg_6, _arg_7);
            if (lockedColumnCount)
            {
                if (_arg_7.parent == listContent)
                {
                    _local_8 = lockedColumnContent;
                }
                else
                {
                    _local_8 = lockedColumnAndRowContent;
                };
                _local_9 = _local_8.selectionLayer;
                if (!columnHighlightIndicator)
                {
                    columnHighlightIndicator = new SpriteAsset();
                    _local_8.selectionLayer.addChild(DisplayObject(columnHighlightIndicator));
                }
                else
                {
                    if (columnHighlightIndicator.parent != _local_9)
                    {
                        _local_9.addChild(columnHighlightIndicator);
                    }
                    else
                    {
                        _local_9.setChildIndex(DisplayObject(columnHighlightIndicator), (_local_9.numChildren - 1));
                    };
                };
                super.drawHighlightIndicator(columnHighlightIndicator, _arg_2, _arg_3, _local_8.width, _arg_5, _arg_6, _arg_7);
            };
        }

        override protected function finishKeySelection():void
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
                    caretIndex = Math.min((((verticalScrollPosition + lockedRowCount) + _local_3) - _local_4), (collection.length - 1));
                }
                else
                {
                    caretIndex = Math.min(((((verticalScrollPosition + lockedRowCount) + _local_3) - _local_4) - 1), (collection.length - 1));
                };
            };
            var _local_6:Boolean;
            if (((bSelectItem) && (((caretIndex - verticalScrollPosition) >= 0) || (caretIndex < lockedRowCount))))
            {
                if (((caretIndex - lockedRowCount) - verticalScrollPosition) > Math.max(((_local_3 - _local_4) - 1), 0))
                {
                    if (((lastKey == Keyboard.END) && (maxVerticalScrollPosition > verticalScrollPosition)))
                    {
                        caretIndex = (caretIndex - 1);
                        moveSelectionVertically(lastKey, bShiftKey, bCtrlKey);
                        return;
                    };
                    caretIndex = ((((lockedRowCount + _local_3) - _local_4) - 1) + verticalScrollPosition);
                };
                if (caretIndex < lockedRowCount)
                {
                    _local_5 = lockedRowContent.listItems[caretIndex][0];
                }
                else
                {
                    _local_5 = listItems[(((caretIndex - lockedRowCount) - verticalScrollPosition) + offscreenExtraRowsTop)][0];
                };
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

        override mx_internal function addClipMask(_arg_1:Boolean):void
        {
            var _local_2:Graphics;
            var _local_11:DisplayObject;
            var _local_12:Number;
            if (_arg_1)
            {
                if ((((((((horizontalScrollBar) && (horizontalScrollBar.visible)) || (hasOnlyTextRenderers())) || (!(listContent.bottomOffset == 0))) || (!(listContent.topOffset == 0))) || (!(listContent.leftOffset == 0))) || (!(listContent.rightOffset == 0))))
                {
                    listContent.mask = maskShape;
                    selectionLayer.mask = null;
                    if (!headerMask)
                    {
                        headerMask = new Shape();
                        addChild(headerMask);
                        _local_2 = headerMask.graphics;
                        _local_2.beginFill(0xFFFFFF);
                        _local_2.drawRect(0, 0, 10, 10);
                        _local_2.endFill();
                        headerMask.visible = false;
                    };
                    header.mask = headerMask;
                    header.selectionLayer.mask = null;
                    headerMask.width = maskShape.width;
                    headerMask.height = maskShape.height;
                    headerMask.x = maskShape.x;
                    headerMask.y = maskShape.y;
                    if (((((!(verticalScrollBar == null)) && (verticalScrollBar.visible)) && ((horizontalScrollBar == null) || (!(horizontalScrollBar.visible)))) && (headerVisible)))
                    {
                        headerMask.width = (headerMask.width + verticalScrollBar.getExplicitOrMeasuredWidth());
                    };
                    if (lockedRowContent)
                    {
                        if (!lockedRowMask)
                        {
                            lockedRowMask = new Shape();
                            addChild(lockedRowMask);
                            _local_2 = lockedRowMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedRowMask.visible = false;
                        };
                        lockedRowContent.mask = lockedRowMask;
                        lockedRowContent.selectionLayer.mask = null;
                        lockedRowMask.width = maskShape.width;
                        lockedRowMask.height = maskShape.height;
                        lockedRowMask.x = maskShape.x;
                        lockedRowMask.y = maskShape.y;
                    };
                    if (lockedColumnContent)
                    {
                        if (!lockedColumnMask)
                        {
                            lockedColumnMask = new Shape();
                            addChild(lockedColumnMask);
                            _local_2 = lockedColumnMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedColumnMask.visible = false;
                        };
                        lockedColumnContent.mask = lockedColumnMask;
                        lockedColumnContent.selectionLayer.mask = null;
                        lockedColumnMask.width = maskShape.width;
                        lockedColumnMask.height = maskShape.height;
                        lockedColumnMask.x = maskShape.x;
                        lockedColumnMask.y = maskShape.y;
                    };
                    if (lockedColumnAndRowContent)
                    {
                        if (!lockedColumnAndRowMask)
                        {
                            lockedColumnAndRowMask = new Shape();
                            addChild(lockedColumnAndRowMask);
                            _local_2 = lockedColumnAndRowMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedColumnAndRowMask.visible = false;
                        };
                        lockedColumnAndRowContent.mask = lockedColumnAndRowMask;
                        lockedColumnAndRowContent.selectionLayer.mask = null;
                        lockedColumnAndRowMask.width = maskShape.width;
                        lockedColumnAndRowMask.height = maskShape.height;
                        lockedColumnAndRowMask.x = maskShape.x;
                        lockedColumnAndRowMask.y = maskShape.y;
                    };
                    if (lockedColumnHeader)
                    {
                        if (!lockedColumnHeaderMask)
                        {
                            lockedColumnHeaderMask = new Shape();
                            addChild(lockedColumnHeaderMask);
                            _local_2 = lockedColumnHeaderMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedColumnHeaderMask.visible = false;
                        };
                        lockedColumnHeader.mask = lockedColumnHeaderMask;
                        lockedColumnHeader.selectionLayer.mask = null;
                        lockedColumnHeaderMask.width = maskShape.width;
                        lockedColumnHeaderMask.height = maskShape.height;
                        lockedColumnHeaderMask.x = maskShape.x;
                        lockedColumnHeaderMask.y = maskShape.y;
                    };
                }
                else
                {
                    listContent.mask = null;
                    selectionLayer.mask = maskShape;
                    if (!headerMask)
                    {
                        headerMask = new Shape();
                        addChild(headerMask);
                        _local_2 = headerMask.graphics;
                        _local_2.beginFill(0xFFFFFF);
                        _local_2.drawRect(0, 0, 10, 10);
                        _local_2.endFill();
                        headerMask.visible = false;
                    };
                    header.mask = null;
                    header.selectionLayer.mask = headerMask;
                    headerMask.width = maskShape.width;
                    headerMask.height = maskShape.height;
                    headerMask.x = maskShape.x;
                    headerMask.y = maskShape.y;
                    if (((((!(verticalScrollBar == null)) && (verticalScrollBar.visible)) && ((horizontalScrollBar == null) || (!(horizontalScrollBar.visible)))) && (headerVisible)))
                    {
                        headerMask.width = (headerMask.width + verticalScrollBar.getExplicitOrMeasuredWidth());
                    };
                    if (lockedRowContent)
                    {
                        if (!lockedRowMask)
                        {
                            lockedRowMask = new Shape();
                            addChild(lockedRowMask);
                            _local_2 = lockedRowMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedRowMask.visible = false;
                        };
                        lockedRowContent.mask = null;
                        lockedRowContent.selectionLayer.mask = lockedRowMask;
                        lockedRowMask.width = maskShape.width;
                        lockedRowMask.height = maskShape.height;
                        lockedRowMask.x = maskShape.x;
                        lockedRowMask.y = maskShape.y;
                    };
                    if (lockedColumnContent)
                    {
                        if (!lockedColumnMask)
                        {
                            lockedColumnMask = new Shape();
                            addChild(lockedColumnMask);
                            _local_2 = lockedColumnMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedColumnMask.visible = false;
                        };
                        lockedColumnContent.mask = null;
                        lockedColumnContent.selectionLayer.mask = lockedColumnMask;
                        lockedColumnMask.width = maskShape.width;
                        lockedColumnMask.height = maskShape.height;
                        lockedColumnMask.x = maskShape.x;
                        lockedColumnMask.y = maskShape.y;
                    };
                    if (lockedColumnAndRowContent)
                    {
                        if (!lockedColumnAndRowMask)
                        {
                            lockedColumnAndRowMask = new Shape();
                            addChild(lockedColumnAndRowMask);
                            _local_2 = lockedColumnAndRowMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedColumnAndRowMask.visible = false;
                        };
                        lockedColumnAndRowContent.mask = null;
                        lockedColumnAndRowContent.selectionLayer.mask = lockedColumnAndRowMask;
                        lockedColumnAndRowMask.width = maskShape.width;
                        lockedColumnAndRowMask.height = maskShape.height;
                        lockedColumnAndRowMask.x = maskShape.x;
                        lockedColumnAndRowMask.y = maskShape.y;
                    };
                    if (lockedColumnHeader)
                    {
                        if (!lockedColumnHeaderMask)
                        {
                            lockedColumnHeaderMask = new Shape();
                            addChild(lockedColumnHeaderMask);
                            _local_2 = lockedColumnHeaderMask.graphics;
                            _local_2.beginFill(0xFFFFFF);
                            _local_2.drawRect(0, 0, 10, 10);
                            _local_2.endFill();
                            lockedColumnHeaderMask.visible = false;
                        };
                        lockedColumnHeader.mask = null;
                        lockedColumnHeader.selectionLayer.mask = lockedColumnHeaderMask;
                        lockedColumnHeaderMask.width = maskShape.width;
                        lockedColumnHeaderMask.height = maskShape.height;
                        lockedColumnHeaderMask.x = maskShape.x;
                        lockedColumnHeaderMask.y = maskShape.y;
                    };
                };
            };
            if (listContent.mask)
            {
                return;
            };
            var _local_3:int = (listItems.length - 1);
            var _local_4:ListRowInfo = rowInfo[_local_3];
            var _local_5:Array = listItems[_local_3];
            if ((_local_4.y + _local_4.height) <= listContent.height)
            {
                return;
            };
            var _local_6:int = _local_5.length;
            var _local_7:Number = _local_4.y;
            var _local_8:Number = listContent.width;
            var _local_9:Number = (listContent.height - _local_4.y);
            var _local_10:int;
            while (_local_10 < _local_6)
            {
                _local_11 = _local_5[_local_10];
                _local_12 = (_local_11.y - _local_7);
                if ((_local_11 is IUITextField))
                {
                    _local_11.height = Math.max((_local_9 - _local_12), 0);
                }
                else
                {
                    _local_11.mask = createItemMask(0, (_local_7 + _local_12), _local_8, Math.max((_local_9 - _local_12), 0));
                };
                _local_10++;
            };
            if (lockedColumnContent)
            {
                _local_5 = lockedColumnContent.listItems[_local_3];
                _local_6 = _local_5.length;
                _local_8 = lockedColumnContent.width;
                _local_10 = 0;
                while (_local_10 < _local_6)
                {
                    _local_11 = _local_5[_local_10];
                    _local_12 = (_local_11.y - _local_7);
                    if ((_local_11 is IUITextField))
                    {
                        _local_11.height = Math.max((_local_9 - _local_12), 0);
                    }
                    else
                    {
                        _local_11.mask = createItemMask(0, (_local_7 + _local_12), _local_8, Math.max((_local_9 - _local_12), 0), lockedColumnContent);
                    };
                    _local_10++;
                };
            };
        }

        mx_internal function get headerVisible():Boolean
        {
            return ((showHeaders) && (headerHeight > 0));
        }

        public function set headerHeight(_arg_1:Number):void
        {
            _headerHeight = _arg_1;
            _explicitHeaderHeight = true;
            itemsSizeChanged = true;
            invalidateDisplayList();
        }

        mx_internal function resizeColumn(_arg_1:int, _arg_2:Number):void
        {
        }

        override protected function drawCaretIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:ListBaseContentHolder;
            var _local_9:Sprite;
            super.drawCaretIndicator(_arg_1, _arg_2, _arg_3, ((unscaledWidth - viewMetrics.left) - viewMetrics.right), _arg_5, _arg_6, _arg_7);
            if (lockedColumnCount)
            {
                if (_arg_7.parent == listContent)
                {
                    _local_8 = lockedColumnContent;
                }
                else
                {
                    _local_8 = lockedColumnAndRowContent;
                };
                _local_9 = _local_8.selectionLayer;
                if (!columnCaretIndicator)
                {
                    columnCaretIndicator = new SpriteAsset();
                    _local_8.selectionLayer.addChild(DisplayObject(columnCaretIndicator));
                }
                else
                {
                    if (columnCaretIndicator.parent != _local_9)
                    {
                        _local_9.addChild(columnCaretIndicator);
                    }
                    else
                    {
                        _local_9.setChildIndex(DisplayObject(columnCaretIndicator), (_local_9.numChildren - 1));
                    };
                };
                super.drawCaretIndicator(columnCaretIndicator, _arg_2, _arg_3, _local_8.width, _arg_5, _arg_6, _arg_7);
            };
        }

        mx_internal function get dataGridLockedRows():ListBaseContentHolder
        {
            return (lockedRowContent);
        }

        protected function layoutColumnItemRenderer(_arg_1:DataGridColumn, _arg_2:IListItemRenderer, _arg_3:Number, _arg_4:Number):Point
        {
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            if (_arg_2)
            {
                _arg_2.explicitWidth = (_local_5 = getWidthOfItem(_arg_2, _arg_1));
                UIComponentGlobals.layoutManager.validateClient(_arg_2, true);
                _local_6 = _arg_2.getExplicitOrMeasuredHeight();
                _arg_2.setActualSize(_local_5, ((variableRowHeight) ? _arg_2.getExplicitOrMeasuredHeight() : ((rowHeight - cachedPaddingTop) - cachedPaddingBottom)));
                _arg_2.move(_arg_3, (_arg_4 + cachedPaddingTop));
            };
            return (new Point(_local_5, _local_6));
        }

        override public function showDropFeedback(_arg_1:DragEvent):void
        {
            var _local_3:Class;
            var _local_4:EdgeMetrics;
            var _local_5:int;
            var _local_6:int;
            if (!dropIndicator)
            {
                _local_3 = getStyle("dropIndicatorSkin");
                if (!_local_3)
                {
                    _local_3 = ListDropIndicator;
                };
                dropIndicator = IFlexDisplayObject(new (_local_3)());
                _local_4 = viewMetrics;
                drawFocus(true);
                dropIndicator.x = 2;
                dropIndicator.setActualSize((listContent.width - 4), 4);
                dropIndicator.visible = true;
                listContent.addChild(DisplayObject(dropIndicator));
                if (collection)
                {
                    dragScrollingInterval = setInterval(dragScroll, 15);
                };
            };
            var _local_2:Number = calculateDropIndex(_arg_1);
            if (((lockedRowCount) && (_local_2 < lockedRowCount)))
            {
                if (dropIndicator.parent != lockedRowContent)
                {
                    lockedRowContent.addChild(DisplayObject(dropIndicator));
                };
                dropIndicator.y = (lockedRowContent.listItems[_local_2][0].y - 1);
            }
            else
            {
                _local_5 = listItems.length;
                _local_6 = (((_local_5 > 0) && ((rowInfo[((_local_5 - offscreenExtraRowsBottom) - 1)].y + rowInfo[((_local_5 - offscreenExtraRowsBottom) - 1)].height) > (listContent.heightExcludingOffsets - listContent.topOffset))) ? 1 : 0);
                _local_2 = (_local_2 - (verticalScrollPosition + lockedRowCount));
                if (_local_2 >= _local_5)
                {
                    if (_local_6)
                    {
                        _local_2 = (_local_5 - 1);
                    }
                    else
                    {
                        _local_2 = _local_5;
                    };
                };
                if (_local_2 < 0)
                {
                    _local_2 = 0;
                };
                if (dropIndicator.parent != listContent)
                {
                    listContent.addChild(DisplayObject(dropIndicator));
                };
                dropIndicator.y = calculateDropIndicatorY(_local_5, (_local_2 + offscreenExtraRowsTop));
            };
        }

        mx_internal function columnRendererChanged(_arg_1:DataGridColumn):void
        {
        }

        override protected function selectItem(_arg_1:IListItemRenderer, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean=true):Boolean
        {
            var _local_5:CursorBookmark = iterator.bookmark;
            if (lockedRowCount)
            {
                inSelectItem = true;
                iterator.seek(CursorBookmark.FIRST, 0);
            };
            var _local_6:Boolean = super.selectItem(_arg_1, _arg_2, _arg_3, _arg_4);
            if (lockedRowCount)
            {
                iterator.seek(_local_5, 0);
                inSelectItem = false;
            };
            return (_local_6);
        }

        mx_internal function get dataGridLockedColumns():ListBaseContentHolder
        {
            return (lockedColumnContent);
        }

        override protected function addToRowArrays():void
        {
            super.addToRowArrays();
            if (lockedColumnCount)
            {
                lockedColumnContent.listItems.splice(0, 0, null);
                lockedColumnContent.rowInfo.splice(0, 0, null);
            };
        }

        override public function itemRendererToIndex(_arg_1:IListItemRenderer):int
        {
            var _local_2:int;
            if ((_arg_1.name in rowMap))
            {
                _local_2 = rowMap[_arg_1.name].rowIndex;
                if ((_arg_1.parent is DataGridLockedRowContentHolder))
                {
                    return (_local_2);
                };
                return (((_local_2 + lockedRowCount) + verticalScrollPosition) - offscreenExtraRowsTop);
            };
            return (int.MIN_VALUE);
        }

        override protected function makeRowsAndColumns(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:int, _arg_6:int, _arg_7:Boolean=false, _arg_8:uint=0):Point
        {
            return (makeRows(listContent, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8));
        }

        protected function removeExtraRow(_arg_1:ListBaseContentHolder):void
        {
            var _local_2:IListItemRenderer;
            var _local_5:ListBaseContentHolder;
            var _local_3:Array = _arg_1.listItems;
            var _local_4:Object = _arg_1.rowInfo;
            if (_arg_1 == lockedRowContent)
            {
                _local_5 = lockedColumnAndRowContent;
            }
            else
            {
                _local_5 = lockedColumnContent;
            };
            var _local_6:Array = _local_3.pop();
            _local_4.pop();
            while (_local_6.length)
            {
                _local_2 = _local_6.pop();
                addToFreeItemRenderers(_local_2);
            };
            if (_local_5)
            {
                _local_5.rowInfo.pop();
                _local_6 = _local_5.listItems.pop();
                while (((_local_6) && (_local_6.length)))
                {
                    _local_2 = _local_6.pop();
                    addToFreeItemRenderers(_local_2);
                };
            };
        }

        override mx_internal function selectionTween_updateHandler(_arg_1:TweenEvent):void
        {
            var _local_2:Sprite;
            super.selectionTween_updateHandler(_arg_1);
            if (lockedColumnCount)
            {
                _local_2 = Sprite(_arg_1.target.listener);
                _local_2 = (indicatorDictionary[_local_2] as Sprite);
                _local_2.alpha = Number(_arg_1.value);
            };
        }

        override protected function purgeItemRenderers():void
        {
            var _local_1:Array;
            var _local_2:Array;
            var _local_3:IListItemRenderer;
            if (lockedRowContent)
            {
                _local_1 = lockedRowContent.listItems;
                while (_local_1.length)
                {
                    _local_2 = _local_1.pop();
                    while (_local_2.length)
                    {
                        _local_3 = IListItemRenderer(_local_2.pop());
                        if (_local_3)
                        {
                            lockedRowContent.removeChild(DisplayObject(_local_3));
                            delete lockedRowContent.visibleData[itemToUID(_local_3.data)];
                        };
                    };
                };
            };
            if (lockedColumnContent)
            {
                _local_1 = lockedColumnContent.listItems;
                while (_local_1.length)
                {
                    _local_2 = _local_1.pop();
                    while (_local_2.length)
                    {
                        _local_3 = IListItemRenderer(_local_2.pop());
                        if (_local_3)
                        {
                            lockedColumnContent.removeChild(DisplayObject(_local_3));
                            delete lockedColumnContent.visibleData[itemToUID(_local_3.data)];
                        };
                    };
                };
            };
            if (lockedColumnAndRowContent)
            {
                _local_1 = lockedColumnAndRowContent.listItems;
                while (_local_1.length)
                {
                    _local_2 = _local_1.pop();
                    while (_local_2.length)
                    {
                        _local_3 = IListItemRenderer(_local_2.pop());
                        if (_local_3)
                        {
                            lockedColumnAndRowContent.removeChild(DisplayObject(_local_3));
                            delete lockedColumnAndRowContent.visibleData[itemToUID(_local_3.data)];
                        };
                    };
                };
            };
            super.purgeItemRenderers();
        }

        protected function clearRow(_arg_1:ListBaseContentHolder, _arg_2:int):void
        {
            var _local_4:ListBaseContentHolder;
            var _local_5:IListItemRenderer;
            var _local_3:Array = _arg_1.listItems;
            if (lockedColumnCount > 0)
            {
                if (_arg_1 == lockedRowContent)
                {
                    _local_4 = lockedColumnAndRowContent;
                }
                else
                {
                    _local_4 = lockedColumnContent;
                };
            }
            else
            {
                _local_4 = null;
            };
            while (_local_3[_arg_2].length)
            {
                _local_5 = _local_3[_arg_2].pop();
                addToFreeItemRenderers(_local_5);
            };
            if (_local_4)
            {
                while (_local_4.listItems[_arg_2].length)
                {
                    _local_5 = _local_4.listItems[_arg_2].pop();
                    addToFreeItemRenderers(_local_5);
                };
            };
        }

        override protected function moveIndicatorsVertically(_arg_1:String, _arg_2:Number):void
        {
            super.moveIndicatorsVertically(_arg_1, _arg_2);
            if (lockedColumnCount)
            {
                if (_arg_1)
                {
                    if (selectionIndicators[_arg_1])
                    {
                        Sprite(indicatorDictionary[selectionIndicators[_arg_1]]).y = (Sprite(indicatorDictionary[selectionIndicators[_arg_1]]).y + _arg_2);
                    };
                    if (highlightUID == _arg_1)
                    {
                        columnHighlightIndicator.y = (columnHighlightIndicator.y + _arg_2);
                    };
                    if (caretUID == _arg_1)
                    {
                        columnCaretIndicator.y = (columnCaretIndicator.y + _arg_2);
                    };
                };
            };
        }

        mx_internal function getAllVisibleColumns():Array
        {
            var _local_1:Array = [];
            if (lockedColumnCount)
            {
                _local_1 = _local_1.concat(visibleLockedColumns);
            };
            return (_local_1.concat(visibleColumns));
        }

        override protected function drawSelectionIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:ListBaseContentHolder;
            var _local_9:Sprite;
            var _local_10:Sprite;
            super.drawSelectionIndicator(_arg_1, _arg_2, _arg_3, ((unscaledWidth - viewMetrics.left) - viewMetrics.right), _arg_5, _arg_6, _arg_7);
            if (lockedColumnCount)
            {
                if (_arg_7.parent == listContent)
                {
                    _local_8 = lockedColumnContent;
                }
                else
                {
                    _local_8 = lockedColumnAndRowContent;
                };
                _local_9 = _local_8.selectionLayer;
                _local_10 = (indicatorDictionary[_arg_1] as Sprite);
                if (!_local_10)
                {
                    _local_10 = new SpriteAsset();
                    _local_10.mouseEnabled = false;
                    _local_9.addChild(DisplayObject(_local_10));
                    _arg_1.parent.addEventListener(Event.REMOVED, selectionRemovedListener);
                    indicatorDictionary[_arg_1] = _local_10;
                };
                super.drawSelectionIndicator(_local_10, _arg_2, _arg_3, _local_8.width, _arg_5, _arg_6, _arg_7);
            };
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        override protected function itemRendererToIndices(_arg_1:IListItemRenderer):Point
        {
            if (((!(_arg_1)) || (!(_arg_1.name in rowMap))))
            {
                return (null);
            };
            var _local_2:ListBaseContentHolder = (_arg_1.parent as ListBaseContentHolder);
            var _local_3:Boolean;
            var _local_4:int = rowMap[_arg_1.name].rowIndex;
            var _local_5:int = _local_2.listItems[_local_4].length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                if (_local_2.listItems[_local_4][_local_6] == _arg_1)
                {
                    _local_3 = true;
                    break;
                };
                _local_6++;
            };
            if (!_local_3)
            {
                return (null);
            };
            if (lockedRowContent == _local_2)
            {
                return (new Point(((_local_6 + horizontalScrollPosition) + lockedColumnCount), (_local_4 + offscreenExtraRowsTop)));
            };
            if (lockedColumnAndRowContent == _local_2)
            {
                return (new Point(_local_6, (_local_4 + offscreenExtraRowsTop)));
            };
            if (lockedColumnContent == _local_2)
            {
                return (new Point(_local_6, (((_local_4 + verticalScrollPosition) + lockedRowCount) + offscreenExtraRowsTop)));
            };
            return (new Point(((_local_6 + horizontalScrollPosition) + lockedColumnCount), (((_local_4 + verticalScrollPosition) + lockedRowCount) + offscreenExtraRowsTop)));
        }

        protected function updateRendererDisplayList(_arg_1:IListItemRenderer):void
        {
            var _local_2:IInvalidating;
            if ((_arg_1 is IInvalidating))
            {
                _local_2 = IInvalidating(_arg_1);
                _local_2.invalidateDisplayList();
                _local_2.validateNow();
            };
        }

        override public function indicesToIndex(_arg_1:int, _arg_2:int):int
        {
            if (inSelectItem)
            {
                return (0);
            };
            return (_arg_1);
        }

        override protected function clearIndicators():void
        {
            super.clearIndicators();
            if (((lockedColumnCount) && (lockedColumnContent)))
            {
                while (lockedColumnContent.selectionLayer.numChildren > 0)
                {
                    lockedColumnContent.selectionLayer.removeChildAt(0);
                };
            };
            if (((lockedRowCount) && (lockedRowContent)))
            {
                while (lockedRowContent.selectionLayer.numChildren > 0)
                {
                    lockedRowContent.selectionLayer.removeChildAt(0);
                };
                if (((lockedColumnCount) && (lockedColumnAndRowContent)))
                {
                    while (lockedColumnAndRowContent.selectionLayer.numChildren > 0)
                    {
                        lockedColumnAndRowContent.selectionLayer.removeChildAt(0);
                    };
                };
            };
            if (header)
            {
                header.clearSelectionLayer();
            };
            if (lockedColumnHeader)
            {
                lockedColumnHeader.clearSelectionLayer();
            };
        }

        protected function makeListData(_arg_1:Object, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:DataGridColumn):BaseListData
        {
            if ((_arg_1 is DataGridColumn))
            {
                return (new DataGridListData(((_arg_5.headerText != null) ? _arg_5.headerText : _arg_5.dataField), _arg_5.dataField, _arg_4, _arg_2, this, _arg_3));
            };
            return (new DataGridListData(_arg_5.itemToLabel(_arg_1), _arg_5.dataField, _arg_4, _arg_2, this, _arg_3));
        }

        override protected function drawItem(_arg_1:IListItemRenderer, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false):void
        {
            var _local_7:int;
            var _local_8:IListItemRenderer;
            var _local_9:ListBaseContentHolder;
            if (!_arg_1)
            {
                return;
            };
            super.drawItem(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            var _local_6:int = rowMap[_arg_1.name].rowIndex;
            _local_7 = 0;
            while (_local_7 < visibleColumns.length)
            {
                _local_8 = (_arg_1.parent as ListBaseContentHolder).listItems[_local_6][_local_7];
                updateRendererDisplayList(_local_8);
                _local_7++;
            };
            if (lockedColumnCount)
            {
                if (((_arg_1.parent == listContent) || (_arg_1.parent == lockedColumnContent)))
                {
                    _local_9 = lockedColumnContent;
                }
                else
                {
                    _local_9 = lockedColumnAndRowContent;
                };
                _local_7 = 0;
                while (_local_7 < visibleLockedColumns.length)
                {
                    _local_8 = _local_9.listItems[_local_6][_local_7];
                    updateRendererDisplayList(_local_8);
                    _local_7++;
                };
            };
        }

        override protected function adjustAfterRemove(items:Array, location:int, requiresValueCommit:Boolean):Boolean
        {
            var firstUID:String;
            var i:int;
            var uid:String;
            var adjustIterator:Boolean;
            if ((((lockedRowCount) && (listItems.length)) && (listItems[0].length)))
            {
                if (location <= (lockedRowCount + verticalScrollPosition))
                {
                    adjustIterator = true;
                }
                else
                {
                    firstUID = rowMap[listItems[0][0].name].uid;
                    i = 0;
                    while (i < items.length)
                    {
                        uid = itemToUID(items[i]);
                        if (((uid == firstUID) && (verticalScrollPosition == 0)))
                        {
                            adjustIterator = true;
                            break;
                        };
                        i = (i + 1);
                    };
                };
            };
            var retval:Boolean = super.adjustAfterRemove(items, location, requiresValueCommit);
            if (lockedRowCount)
            {
                if (((((verticalScrollPosition > 0) && (location > lockedRowCount)) && (verticalScrollPosition <= lockedRowCount)) && (verticalScrollPosition == maxVerticalScrollPosition)))
                {
                    super.verticalScrollPosition = (verticalScrollPosition - items.length);
                    adjustIterator = true;
                };
                if (adjustIterator)
                {
                    try
                    {
                        iterator.seek(CursorBookmark.FIRST, (lockedRowCount + verticalScrollPosition));
                        if (!iteratorValid)
                        {
                            iteratorValid = true;
                            lastSeekPending = null;
                        };
                    }
                    catch(e:ItemPendingError)
                    {
                        lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, (lockedRowCount + verticalScrollPosition));
                        e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                        iteratorValid = false;
                    };
                };
            };
            return (retval);
        }

        override protected function clearCaretIndicator(_arg_1:Sprite, _arg_2:IListItemRenderer):void
        {
            super.clearCaretIndicator(_arg_1, _arg_2);
            if (lockedColumnCount)
            {
                if (columnCaretIndicator)
                {
                    Sprite(columnCaretIndicator).graphics.clear();
                };
            };
        }

        public function get lockedRowCount():int
        {
            return (_lockedRowCount);
        }

        mx_internal function get gridColumnMap():Object
        {
            return (columnMap);
        }

        override protected function UIDToItemRenderer(_arg_1:String):IListItemRenderer
        {
            var _local_2:IListItemRenderer = visibleData[_arg_1];
            if (!_local_2)
            {
                if (lockedRowContent)
                {
                    _local_2 = lockedRowContent.visibleData[_arg_1];
                };
            };
            if (!_local_2)
            {
                if (lockedColumnContent)
                {
                    _local_2 = lockedColumnContent.visibleData[_arg_1];
                };
            };
            if (!_local_2)
            {
                if (lockedColumnAndRowContent)
                {
                    _local_2 = lockedColumnAndRowContent.visibleData[_arg_1];
                };
            };
            return (_local_2);
        }

        override protected function destroyRow(_arg_1:int, _arg_2:int):void
        {
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:Object;
            var _local_6:IListItemRenderer;
            var _local_7:String;
            var _local_8:int;
            super.destroyRow(_arg_1, _arg_2);
            if (lockedColumnCount)
            {
                _local_3 = lockedColumnContent.listItems;
                _arg_2 = _local_3[_arg_1].length;
                _local_4 = lockedColumnContent.rowInfo;
                _local_5 = lockedColumnContent.visibleData;
                _local_7 = _local_4[_arg_1].uid;
                removeIndicators(_local_7);
                _local_8 = 0;
                while (_local_8 < _arg_2)
                {
                    _local_6 = _local_3[_arg_1][_local_8];
                    if (_local_6.data)
                    {
                        delete _local_5[_local_7];
                    };
                    addToFreeItemRenderers(_local_6);
                    _local_8++;
                };
            };
        }

        public function createColumnItemRenderer(_arg_1:DataGridColumn, _arg_2:Boolean, _arg_3:Object):IListItemRenderer
        {
            var _local_4:IFactory;
            var _local_5:IListItemRenderer;
            var _local_6:Dictionary;
            var _local_7:*;
            _local_4 = _arg_1.getItemRendererFactory(_arg_2, _arg_3);
            if (!_local_4)
            {
                if (!_arg_3)
                {
                    _local_4 = nullItemRenderer;
                };
                if (!_local_4)
                {
                    _local_4 = itemRenderer;
                };
            };
            if (_local_4 == _arg_1.itemRenderer)
            {
                if (((freeItemRenderersTable[_arg_1]) && (freeItemRenderersTable[_arg_1].length)))
                {
                    _local_5 = freeItemRenderersTable[_arg_1].pop();
                    delete _arg_1.freeItemRenderersByFactory[_local_4][_local_5];
                };
            }
            else
            {
                if (_arg_1.freeItemRenderersByFactory)
                {
                    _local_6 = _arg_1.freeItemRenderersByFactory[_local_4];
                    if (_local_6)
                    {
                        for (_local_7 in _local_6)
                        {
                            _local_5 = IListItemRenderer(_local_7);
                            delete _local_6[_local_7];
                            break;
                        };
                    };
                };
            };
            if (!_local_5)
            {
                _local_5 = _local_4.newInstance();
                if (_local_5)
                {
                    _local_5.styleName = _arg_1;
                    factoryMap[_local_5] = _local_4;
                };
            };
            if (_local_5)
            {
                _local_5.owner = this;
            };
            return (_local_5);
        }

        public function set showHeaders(_arg_1:Boolean):void
        {
            if (_arg_1 == _showHeaders)
            {
                return;
            };
            _showHeaders = _arg_1;
            itemsSizeChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("showHeadersChanged"));
        }

        override protected function addToFreeItemRenderers(_arg_1:IListItemRenderer):void
        {
            var _local_5:DataGridColumn;
            DisplayObject(_arg_1).visible = false;
            delete rowMap[_arg_1.name];
            var _local_2:IFactory = factoryMap[_arg_1];
            var _local_3:String = itemToUID(_arg_1.data);
            var _local_4:Object = ListBaseContentHolder(_arg_1.parent).visibleData;
            if (_local_4[_local_3] == _arg_1)
            {
                delete _local_4[_local_3];
            };
            if (columnMap[_arg_1.name])
            {
                _local_5 = columnMap[_arg_1.name];
                if (_local_2 == _local_5.itemRenderer)
                {
                    if (freeItemRenderersTable[_local_5] == undefined)
                    {
                        freeItemRenderersTable[_local_5] = [];
                    };
                    freeItemRenderersTable[_local_5].push(_arg_1);
                };
                if (!_local_5.freeItemRenderersByFactory)
                {
                    _local_5.freeItemRenderersByFactory = new Dictionary(true);
                };
                if (_local_5.freeItemRenderersByFactory[_local_2] == undefined)
                {
                    _local_5.freeItemRenderersByFactory[_local_2] = new Dictionary(true);
                };
                _local_5.freeItemRenderersByFactory[_local_2][_arg_1] = 1;
                delete columnMap[_arg_1.name];
            };
        }

        override protected function moveSelectionVertically(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
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
                        bSelectItem = true;
                        if (caretIndex >= lockedRowCount)
                        {
                            _local_12 = true;
                        };
                    };
                    break;
                case Keyboard.DOWN:
                    if (caretIndex >= (lockedRowCount - 1))
                    {
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
                    }
                    else
                    {
                        if (caretIndex < (collection.length - 1))
                        {
                            caretIndex++;
                            bSelectItem = true;
                        };
                    };
                    break;
                case Keyboard.PAGE_UP:
                    if (caretIndex > lockedRowCount)
                    {
                        if (((caretIndex > (verticalScrollPosition + lockedRowCount)) && (caretIndex < ((verticalScrollPosition + lockedRowCount) + _local_10))))
                        {
                            caretIndex = (verticalScrollPosition + lockedRowCount);
                        }
                        else
                        {
                            caretIndex = Math.max((caretIndex - Math.max((_local_10 - _local_11), 1)), lockedRowCount);
                            _local_4 = (Math.max(caretIndex, lockedRowCount) - lockedRowCount);
                        };
                        bSelectItem = true;
                    }
                    else
                    {
                        caretIndex = 0;
                        bSelectItem = true;
                    };
                    break;
                case Keyboard.PAGE_DOWN:
                    if (!((caretIndex >= (verticalScrollPosition + lockedRowCount)) && (caretIndex < ((((verticalScrollPosition + lockedRowCount) + _local_10) - _local_11) - 1))))
                    {
                        if ((((caretIndex - lockedRowCount) == verticalScrollPosition) && ((_local_10 - _local_11) <= 1)))
                        {
                            caretIndex++;
                        };
                        _local_4 = Math.min(Math.max((caretIndex - lockedRowCount), 0), maxVerticalScrollPosition);
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
                    if (lockedRowCount >= collection.length)
                    {
                        caretIndex = (collection.length - 1);
                        bSelectItem = true;
                    }
                    else
                    {
                        if (caretIndex < (collection.length - 1))
                        {
                            caretIndex = (collection.length - 1);
                            bSelectItem = true;
                            _local_4 = maxVerticalScrollPosition;
                        };
                    };
                    break;
                case Keyboard.SPACE:
                    _local_12 = true;
                    bSelectItem = true;
                    break;
            };
            if (_local_12)
            {
                if (caretIndex >= (((verticalScrollPosition + lockedRowCount) + _local_10) - _local_11))
                {
                    if ((_local_10 - _local_11) == 0)
                    {
                        _local_4 = Math.min(maxVerticalScrollPosition, Math.max((caretIndex - lockedRowCount), 0));
                    }
                    else
                    {
                        _local_4 = Math.min(maxVerticalScrollPosition, ((((caretIndex - lockedRowCount) - _local_10) + _local_11) + 1));
                    };
                }
                else
                {
                    if (caretIndex < (verticalScrollPosition + lockedRowCount))
                    {
                        _local_4 = Math.max((caretIndex - lockedRowCount), 0);
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

        override protected function set allowItemSizeChangeNotification(_arg_1:Boolean):void
        {
            if (lockedColumnContent)
            {
                lockedColumnContent.allowItemSizeChangeNotification = _arg_1;
            };
            if (lockedRowContent)
            {
                lockedRowContent.allowItemSizeChangeNotification = _arg_1;
            };
            if (lockedColumnAndRowContent)
            {
                lockedColumnAndRowContent.allowItemSizeChangeNotification = _arg_1;
            };
            super.allowItemSizeChangeNotification = _arg_1;
        }

        override protected function clearVisibleData():void
        {
            if (lockedColumnContent)
            {
                lockedColumnContent.visibleData = {};
            };
            if (lockedRowContent)
            {
                lockedRowContent.visibleData = {};
            };
            if (lockedColumnAndRowContent)
            {
                lockedColumnAndRowContent.visibleData = {};
            };
            super.clearVisibleData();
        }

        override protected function moveRowVertically(_arg_1:int, _arg_2:int, _arg_3:Number):void
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:IListItemRenderer;
            var _local_7:int;
            super.moveRowVertically(_arg_1, _arg_2, _arg_3);
            if (lockedColumnCount)
            {
                _local_4 = lockedColumnContent.listItems;
                _arg_2 = _local_4[_arg_1].length;
                _local_5 = lockedColumnContent.rowInfo;
                _local_7 = 0;
                while (_local_7 < _arg_2)
                {
                    _local_6 = _local_4[_arg_1][_local_7];
                    _local_6.move(_local_6.x, (_local_6.y + _arg_3));
                    _local_7++;
                };
            };
        }

        override mx_internal function mouseEventToItemRendererOrEditor(_arg_1:MouseEvent):IListItemRenderer
        {
            var _local_4:ListBaseContentHolder;
            var _local_6:Array;
            var _local_7:Array;
            var _local_8:Point;
            var _local_9:Number;
            var _local_10:int;
            var _local_11:int;
            var _local_12:Number;
            var _local_13:int;
            var _local_14:int;
            var _local_2:Boolean;
            var _local_3:DisplayObject = DisplayObject(_arg_1.target);
            var _local_5:Array = this.visibleColumns;
            if (_arg_1.target == listContent)
            {
                _local_4 = listContent;
            }
            else
            {
                if (_arg_1.target == lockedColumnContent)
                {
                    _local_4 = lockedColumnContent;
                    _local_5 = visibleLockedColumns;
                }
                else
                {
                    if (_arg_1.target == lockedRowContent)
                    {
                        _local_4 = lockedRowContent;
                    }
                    else
                    {
                        if (_arg_1.target == lockedColumnAndRowContent)
                        {
                            _local_4 = lockedColumnAndRowContent;
                            _local_5 = visibleLockedColumns;
                        }
                        else
                        {
                            if (_arg_1.target == highlightIndicator)
                            {
                                _local_4 = (highlightIndicator.parent.parent as ListBaseContentHolder);
                                _local_5 = this.visibleColumns;
                                if (((_local_4 == lockedColumnContent) || (_local_4 == lockedColumnAndRowContent)))
                                {
                                    _local_5 = visibleLockedColumns;
                                };
                                _local_2 = true;
                            }
                            else
                            {
                                if (_arg_1.target == columnHighlightIndicator)
                                {
                                    _local_4 = (columnHighlightIndicator.parent.parent as ListBaseContentHolder);
                                    _local_5 = this.visibleColumns;
                                    if (((_local_4 == lockedColumnContent) || (_local_4 == lockedColumnAndRowContent)))
                                    {
                                        _local_5 = visibleLockedColumns;
                                    };
                                    _local_2 = true;
                                };
                            };
                        };
                    };
                };
            };
            if (((_local_2) || (_local_3 == _local_4)))
            {
                _local_6 = _local_4.listItems;
                _local_7 = _local_4.rowInfo;
                _local_8 = new Point(_arg_1.stageX, _arg_1.stageY);
                _local_8 = _local_4.globalToLocal(_local_8);
                _local_9 = 0;
                _local_10 = _local_6.length;
                _local_11 = 0;
                while (_local_11 < _local_10)
                {
                    if (_local_6[_local_11].length)
                    {
                        if (_local_8.y < (_local_9 + _local_7[_local_11].height))
                        {
                            _local_12 = 0;
                            _local_13 = _local_5.length;
                            _local_14 = 0;
                            while (_local_14 < _local_13)
                            {
                                if (_local_8.x < (_local_12 + _local_5[_local_14].width))
                                {
                                    return (_local_6[_local_11][_local_14]);
                                };
                                _local_12 = (_local_12 + _local_5[_local_14].width);
                                _local_14++;
                            };
                        };
                    };
                    _local_9 = (_local_9 + _local_7[_local_11].height);
                    _local_11++;
                };
            };
            while (((_local_3) && (!(_local_3 == this))))
            {
                if (((((_local_3 is IListItemRenderer) && (_local_3.parent)) && (_local_3.parent.parent == this)) && (_local_3.parent is ListBaseContentHolder)))
                {
                    if (_local_3.visible)
                    {
                        return (IListItemRenderer(_local_3));
                    };
                    break;
                };
                if ((_local_3 is IUIComponent))
                {
                    _local_3 = IUIComponent(_local_3).owner;
                }
                else
                {
                    _local_3 = _local_3.parent;
                };
            };
            return (null);
        }

        mx_internal function getWidthOfItem(_arg_1:IListItemRenderer, _arg_2:DataGridColumn):Number
        {
            return (_arg_2.width);
        }

        override protected function indexToRow(_arg_1:int):int
        {
            if (_arg_1 < lockedRowCount)
            {
                return (-1);
            };
            return (_arg_1 - lockedRowCount);
        }

        mx_internal function get dataGridHeader():DataGridHeaderBase
        {
            return (header);
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        protected function drawVisibleItem(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false):void
        {
            if (visibleData[_arg_1])
            {
                drawItem(visibleData[_arg_1], _arg_2, _arg_3, _arg_4, _arg_5);
            };
            if ((((lockedRowCount) && (lockedRowContent)) && (lockedRowContent.visibleData[_arg_1])))
            {
                drawItem(lockedRowContent.visibleData[_arg_1], _arg_2, _arg_3, _arg_4, _arg_5);
            };
        }

        protected function prepareRowArray(_arg_1:ListBaseContentHolder, _arg_2:int):void
        {
            var _local_4:ListBaseContentHolder;
            var _local_3:Array = _arg_1.listItems;
            if (lockedColumnCount > 0)
            {
                if (_arg_1 == lockedRowContent)
                {
                    _local_4 = lockedColumnAndRowContent;
                }
                else
                {
                    _local_4 = lockedColumnContent;
                };
            }
            else
            {
                _local_4 = null;
            };
            if (!_local_3[_arg_2])
            {
                _local_3[_arg_2] = [];
            };
            if (_local_4)
            {
                if (!_local_4.listItems[_arg_2])
                {
                    _local_4.listItems[_arg_2] = [];
                };
            };
        }

        [Bindable("showHeadersChanged")]
        public function get showHeaders():Boolean
        {
            return (_showHeaders);
        }

        protected function adjustRow(_arg_1:ListBaseContentHolder, _arg_2:int, _arg_3:Number, _arg_4:Number):void
        {
            var _local_6:ListBaseContentHolder;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:IListItemRenderer;
            var _local_5:Array = _arg_1.listItems;
            if (lockedColumnCount > 0)
            {
                if (_arg_1 == lockedRowContent)
                {
                    _local_6 = lockedColumnAndRowContent;
                }
                else
                {
                    _local_6 = lockedColumnContent;
                };
            }
            else
            {
                _local_6 = null;
            };
            if (_local_5[_arg_2])
            {
                if (_local_6)
                {
                    _local_9 = _local_6.listItems[_arg_2].length;
                    _local_8 = 0;
                    while (_local_8 < _local_9)
                    {
                        _local_6.listItems[_arg_2][_local_8].setActualSize(_local_6.listItems[_arg_2][_local_8].width, ((_arg_4 - cachedPaddingTop) - cachedPaddingBottom));
                        _local_8++;
                    };
                };
                _local_9 = _local_5[_arg_2].length;
                _local_8 = 0;
                while (_local_8 < _local_9)
                {
                    _local_5[_arg_2][_local_8].setActualSize(_local_5[_arg_2][_local_8].width, ((_arg_4 - cachedPaddingTop) - cachedPaddingBottom));
                    _local_8++;
                };
            };
            if (cachedVerticalAlign != "top")
            {
                if (cachedVerticalAlign == "bottom")
                {
                    _local_10 = _local_5[_arg_2].length;
                    _local_8 = 0;
                    while (_local_8 < _local_10)
                    {
                        _local_11 = _local_5[_arg_2][_local_8];
                        _local_11.move(_local_11.x, (((_arg_3 + _arg_4) - cachedPaddingBottom) - _local_11.getExplicitOrMeasuredHeight()));
                        _local_8++;
                    };
                    if (_local_6)
                    {
                        _local_9 = _local_6.listItems[_arg_2].length;
                        _local_8 = 0;
                        while (_local_8 < _local_9)
                        {
                            _local_11 = _local_6.listItems[_arg_2][_local_8];
                            _local_11.move(_local_11.x, (((_arg_3 + _arg_4) - cachedPaddingBottom) - _local_11.getExplicitOrMeasuredHeight()));
                            _local_8++;
                        };
                    };
                }
                else
                {
                    _local_10 = _local_5[_arg_2].length;
                    _local_8 = 0;
                    while (_local_8 < _local_10)
                    {
                        _local_11 = _local_5[_arg_2][_local_8];
                        _local_11.move(_local_11.x, ((_arg_3 + cachedPaddingTop) + ((((_arg_4 - cachedPaddingBottom) - cachedPaddingTop) - _local_11.getExplicitOrMeasuredHeight()) / 2)));
                        _local_8++;
                    };
                    if (_local_6)
                    {
                        _local_9 = _local_6.listItems[_arg_2].length;
                        _local_8 = 0;
                        while (_local_8 < _local_9)
                        {
                            _local_11 = _local_6.listItems[_arg_2][_local_8];
                            _local_11.move(_local_11.x, ((_arg_3 + cachedPaddingTop) + ((((_arg_4 - cachedPaddingBottom) - cachedPaddingTop) - _local_11.getExplicitOrMeasuredHeight()) / 2)));
                            _local_8++;
                        };
                    };
                };
            };
        }

        override protected function restoreRowArrays(_arg_1:int):void
        {
            super.restoreRowArrays(_arg_1);
            if (lockedColumnCount)
            {
                lockedColumnContent.listItems.splice(0, _arg_1);
                lockedColumnContent.rowInfo.splice(0, _arg_1);
            };
        }

        protected function setupColumnItemRenderer(_arg_1:DataGridColumn, _arg_2:ListBaseContentHolder, _arg_3:int, _arg_4:int, _arg_5:Object, _arg_6:String):IListItemRenderer
        {
            var _local_8:IListItemRenderer;
            var _local_9:DataGridListData;
            var _local_7:Array = _arg_2.listItems;
            _local_8 = _local_7[_arg_3][_arg_4];
            if ((((!(_local_8)) || (!(itemToUID(_local_8.data) == _arg_6))) || (!(columnMap[_local_8.name] == _arg_1))))
            {
                _local_8 = createColumnItemRenderer(_arg_1, false, _arg_5);
                if (_local_8 == null)
                {
                    return (null);
                };
                if (_local_8.parent != _arg_2)
                {
                    _arg_2.addChild(DisplayObject(_local_8));
                };
                columnMap[_local_8.name] = _arg_1;
                if (_local_7[_arg_3][_arg_4])
                {
                    addToFreeItemRenderers(_local_7[_arg_3][_arg_4]);
                };
                _local_7[_arg_3][_arg_4] = _local_8;
            };
            _local_9 = DataGridListData(makeListData(_arg_5, _arg_6, _arg_3, _arg_1.colNum, _arg_1));
            rowMap[_local_8.name] = _local_9;
            if ((_local_8 is IDropInListItemRenderer))
            {
                IDropInListItemRenderer(_local_8).listData = ((_arg_5) ? _local_9 : null);
            };
            _local_8.data = _arg_5;
            _local_8.visible = true;
            if (((_arg_6) && (_arg_4 == 0)))
            {
                _arg_2.visibleData[_arg_6] = _local_8;
            };
            return (_local_8);
        }

        override protected function adjustAfterAdd(items:Array, location:int):Boolean
        {
            var retval:Boolean = super.adjustAfterAdd(items, location);
            if (lockedRowCount)
            {
                if ((((verticalScrollPosition > 0) && (verticalScrollPosition >= location)) && (location <= lockedRowCount)))
                {
                    if ((verticalScrollPosition + lockedRowCount) >= collection.length)
                    {
                        super.verticalScrollPosition = (verticalScrollPosition - items.length);
                    };
                };
                if ((((((collection.length - items.length) <= lockedRowCount) && (collection.length >= lockedRowCount)) || (location <= lockedRowCount)) || (location == (lockedRowCount + verticalScrollPosition))))
                {
                    try
                    {
                        iterator.seek(CursorBookmark.FIRST, (lockedRowCount + verticalScrollPosition));
                        if (!iteratorValid)
                        {
                            iteratorValid = true;
                            lastSeekPending = null;
                        };
                    }
                    catch(e:ItemPendingError)
                    {
                        lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, (lockedRowCount + verticalScrollPosition));
                        e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                        iteratorValid = false;
                    };
                };
            };
            return (retval);
        }

        protected function calculateRowHeight(_arg_1:Object, _arg_2:Number, _arg_3:Boolean=false):Number
        {
            return (NaN);
        }

        public function set columns(_arg_1:Array):void
        {
        }

        public function get columns():Array
        {
            return (null);
        }

        public function set lockedColumnCount(_arg_1:int):void
        {
            _lockedColumnCount = _arg_1;
            lockedColumnCountChanged = true;
            itemsSizeChanged = true;
            columnsInvalid = true;
            invalidateDisplayList();
        }

        mx_internal function get dataGridLockedColumnHeader():DataGridHeaderBase
        {
            return (lockedColumnHeader);
        }

        protected function makeRows(contentHolder:ListBaseContentHolder, left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean=false, rowsNeeded:uint=0, alwaysCleanup:Boolean=false):Point
        {
            var xx:Number;
            var yy:Number;
            var hh:Number;
            var i:int;
            var j:int;
            var n:int;
            var item:IListItemRenderer;
            var data:Object;
            var uid:String;
            var bSelected:Boolean;
            var bHighlight:Boolean;
            var bCaret:Boolean;
            var colNum:int;
            var rowNum:int;
            var rowsMade:int;
            var listItems:Array = contentHolder.listItems;
            var iterator:IViewCursor = contentHolder.iterator;
            var visibleData:Object = contentHolder.visibleData;
            var rowInfo:Object = contentHolder.rowInfo;
            if ((((!(visibleColumns)) || (visibleColumns.length == 0)) && (lockedColumnCount == 0)))
            {
                while (listItems.length)
                {
                    rowNum = (listItems.length - 1);
                    while (listItems[rowNum].length)
                    {
                        item = listItems[rowNum].pop();
                        addToFreeItemRenderers(item);
                    };
                    listItems.pop();
                };
                contentHolder.visibleData = {};
                return (new Point(0, 0));
            };
            invalidateSizeFlag = true;
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
                data = ((more) ? iterator.current : null);
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
                hh = 0;
                uid = null;
                prepareRowArray(contentHolder, rowNum);
                if (valid)
                {
                    uid = itemToUID(data);
                    hh = makeRow(contentHolder, rowNum, left, right, yy, data, uid);
                }
                else
                {
                    hh = ((rowNum > 1) ? rowInfo[(rowNum - 1)].height : rowHeight);
                };
                if (((valid) && (variableRowHeight)))
                {
                    hh = Math.ceil(calculateRowHeight(data, hh, true));
                };
                if (valid)
                {
                    adjustRow(contentHolder, rowNum, yy, hh);
                }
                else
                {
                    clearRow(contentHolder, rowNum);
                };
                bSelected = (!(selectedData[uid] == null));
                bHighlight = (highlightUID == uid);
                bCaret = (caretUID == uid);
                setRowInfo(contentHolder, rowNum, yy, hh, uid);
                if (valid)
                {
                    drawVisibleItem(uid, bSelected, bHighlight, bCaret);
                };
                if (hh == 0)
                {
                    hh = rowHeight;
                };
                yy = (yy + hh);
                rowNum = (rowNum + 1);
                rowsMade = (rowsMade + 1);
            };
            if (((!(byCount)) || (alwaysCleanup)))
            {
                while (rowNum < listItems.length)
                {
                    removeExtraRow(contentHolder);
                };
            };
            invalidateSizeFlag = false;
            return (new Point(colNum, rowsMade));
        }

        override protected function clearHighlightIndicator(_arg_1:Sprite, _arg_2:IListItemRenderer):void
        {
            super.clearHighlightIndicator(_arg_1, _arg_2);
            if (lockedColumnCount)
            {
                if (columnHighlightIndicator)
                {
                    Sprite(columnHighlightIndicator).graphics.clear();
                };
            };
        }

        mx_internal function columnWordWrap(_arg_1:DataGridColumn):Boolean
        {
            if (_arg_1.wordWrap == true)
            {
                return (true);
            };
            if (_arg_1.wordWrap == false)
            {
                return (false);
            };
            return (wordWrap);
        }

        protected function setRowInfo(_arg_1:ListBaseContentHolder, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:String):void
        {
            var _local_8:ListBaseContentHolder;
            var _local_6:Array = _arg_1.listItems;
            var _local_7:Object = _arg_1.rowInfo;
            if (lockedColumnCount > 0)
            {
                if (_arg_1 == lockedRowContent)
                {
                    _local_8 = lockedColumnAndRowContent;
                }
                else
                {
                    _local_8 = lockedColumnContent;
                };
            }
            else
            {
                _local_8 = null;
            };
            _local_7[_arg_2] = new ListRowInfo(_arg_3, _arg_4, _arg_5);
            if (_local_8)
            {
                _local_8.rowInfo[_arg_2] = _local_7[_arg_2];
            };
        }

        override protected function truncateRowArrays(_arg_1:int):void
        {
            super.truncateRowArrays(_arg_1);
            if (lockedColumnCount)
            {
                lockedColumnContent.listItems.splice(_arg_1);
                lockedColumnContent.rowInfo.splice(_arg_1);
            };
        }

        public function get lockedColumnCount():int
        {
            return (_lockedColumnCount);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:int;
            var _local_4:int;
            if (header)
            {
                header.visibleColumns = visibleColumns;
                header.headerItemsChanged = true;
                header.invalidateSize();
                header.validateNow();
            };
            if (lockedColumnCountChanged)
            {
                lockedColumnCountChanged = false;
                if (lockedColumnCount > 0)
                {
                    if (!lockedColumnContent)
                    {
                        lockedColumnHeader = new headerClass();
                        lockedColumnHeader.styleName = this;
                        addChild(lockedColumnHeader);
                        lockedColumnAndRowContent = new DataGridLockedRowContentHolder(this);
                        lockedColumnAndRowContent.styleName = this;
                        addChild(lockedColumnAndRowContent);
                        lockedColumnContent = new ListBaseContentHolder(this);
                        lockedColumnContent.styleName = this;
                        addChild(lockedColumnContent);
                    };
                    lockedColumnHeader.visible = true;
                    lockedColumnAndRowContent.visible = (lockedRowCount > 0);
                    lockedColumnContent.visible = true;
                }
                else
                {
                    if (lockedColumnContent)
                    {
                        lockedColumnHeader.visible = false;
                        lockedColumnAndRowContent.visible = false;
                        lockedColumnContent.visible = false;
                    };
                };
            };
            if (((lockedRowCountChanged) && (iterator)))
            {
                lockedRowCountChanged = false;
                if (lockedRowCount > 0)
                {
                    if (!lockedRowContent)
                    {
                        lockedRowContent = new DataGridLockedRowContentHolder(this);
                        lockedRowContent.styleName = this;
                        addChild(lockedRowContent);
                    };
                    lockedRowContent.visible = true;
                }
                else
                {
                    if (lockedRowContent)
                    {
                        lockedRowContent.visible = false;
                    };
                };
                if (lockedColumnAndRowContent)
                {
                    lockedColumnAndRowContent.visible = ((lockedRowCount > 0) && (lockedColumnCount > 0));
                };
                seekPositionSafely((lockedRowCount + verticalScrollPosition));
            };
            if (((lockedRowContent) && (lockedColumnAndRowContent)))
            {
                _local_4 = getChildIndex(lockedColumnAndRowContent);
                _local_3 = getChildIndex(lockedRowContent);
                if (_local_4 < _local_3)
                {
                    setChildIndex(lockedRowContent, _local_4);
                };
            };
            if (((lockedColumnContent) && (lockedColumnAndRowContent)))
            {
                _local_4 = getChildIndex(lockedColumnAndRowContent);
                _local_3 = getChildIndex(lockedColumnContent);
                if (_local_4 < _local_3)
                {
                    setChildIndex(lockedColumnContent, _local_4);
                };
            };
            if (((headerVisible) && (lockedColumnHeader)))
            {
                lockedColumnHeader.visibleColumns = visibleLockedColumns;
                lockedColumnHeader.headerItemsChanged = true;
                lockedColumnHeader.invalidateSize();
                lockedColumnHeader.validateNow();
            };
            super.updateDisplayList(_arg_1, _arg_2);
        }

        public function set lockedRowCount(_arg_1:int):void
        {
            _lockedRowCount = _arg_1;
            lockedRowCountChanged = true;
            itemsSizeChanged = true;
            invalidateDisplayList();
        }


    }
}//package mx.controls.dataGridClasses

