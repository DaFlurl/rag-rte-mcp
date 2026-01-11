// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.TileBase

package mx.controls.listClasses
{
    import flash.utils.Dictionary;
    import mx.core.ClassFactory;
    import mx.core.IFactory;
    import mx.collections.ItemWrapper;
    import mx.core.UIComponentGlobals;
    import flash.events.Event;
    import mx.events.ScrollEvent;
    import flash.ui.Keyboard;
    import mx.events.ScrollEventDetail;
    import mx.events.ScrollEventDirection;
    import mx.collections.CursorBookmark;
    import mx.collections.errors.ItemPendingError;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import mx.core.FlexSprite;
    import mx.styles.StyleManager;
    import mx.events.ListEvent;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    import mx.core.EdgeMetrics;
    import mx.skins.halo.ListDropIndicator;
    import mx.core.IFlexDisplayObject;
    import flash.utils.setInterval;
    import mx.events.DragEvent;
    import mx.controls.scrollClasses.ScrollBar;
    import mx.collections.ItemResponder;
    import mx.collections.ModifiedCollectionView;
    import flash.display.Shape;
    import mx.core.FlexShape;
    import flash.display.Graphics;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TileBase extends ListBase 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _direction:String = "horizontal";
        private var lastRowCount:int = 0;
        private var _maxRows:int = 0;
        private var bSelectItem:Boolean = false;
        private var bCtrlKey:Boolean = false;
        private var lastColumnCount:int = 0;
        private var lastKey:uint = 0;
        private var _maxColumns:int = 0;
        protected var measuringObjects:Dictionary;
        private var bShiftKey:Boolean = false;

        public function TileBase()
        {
            itemRenderer = new ClassFactory(TileListItemRenderer);
            setRowHeight(50);
            setColumnWidth(50);
        }

        override public function measureWidthOfItems(_arg_1:int=-1, _arg_2:int=0):Number
        {
            var _local_3:IListItemRenderer;
            var _local_4:Number;
            var _local_5:ListData;
            var _local_7:Object;
            var _local_8:Object;
            var _local_9:IFactory;
            var _local_6:Boolean;
            if (((collection) && (collection.length)))
            {
                _local_7 = iterator.current;
                _local_8 = ((_local_7 is ItemWrapper) ? _local_7.data : _local_7);
                if (!measuringObjects)
                {
                    measuringObjects = new Dictionary(true);
                };
                _local_9 = getItemRendererFactory(_local_8);
                _local_3 = measuringObjects[_local_9];
                if (!_local_3)
                {
                    _local_3 = getMeasuringRenderer(_local_8);
                    _local_6 = true;
                };
                _local_5 = ListData(makeListData(_local_8, uid, 0, 0));
                if ((_local_3 is IDropInListItemRenderer))
                {
                    IDropInListItemRenderer(_local_3).listData = ((_local_8) ? _local_5 : null);
                };
                _local_3.data = _local_8;
                UIComponentGlobals.layoutManager.validateClient(_local_3, true);
                _local_4 = _local_3.getExplicitOrMeasuredWidth();
                if (_local_6)
                {
                    _local_3.setActualSize(_local_4, _local_3.getExplicitOrMeasuredHeight());
                    _local_6 = false;
                };
            };
            if (((isNaN(_local_4)) || (_local_4 == 0)))
            {
                _local_4 = 50;
            };
            return (_local_4 * _arg_2);
        }

        override public function indexToItemRenderer(_arg_1:int):IListItemRenderer
        {
            var _local_2:int = indexToRow(_arg_1);
            if (((_local_2 < verticalScrollPosition) || (_local_2 >= (verticalScrollPosition + rowCount))))
            {
                return (null);
            };
            var _local_3:int = indexToColumn(_arg_1);
            if (((_local_3 < horizontalScrollPosition) || (_local_3 >= (horizontalScrollPosition + columnCount))))
            {
                return (null);
            };
            return (listItems[(_local_2 - verticalScrollPosition)][(_local_3 - horizontalScrollPosition)]);
        }

        public function set direction(_arg_1:String):void
        {
            _direction = _arg_1;
            itemsSizeChanged = true;
            offscreenExtraRowsOrColumnsChanged = true;
            if (listContent)
            {
                if (direction == TileBaseDirection.HORIZONTAL)
                {
                    listContent.leftOffset = (listContent.rightOffset = 0);
                    offscreenExtraColumnsLeft = (offscreenExtraColumnsRight = 0);
                }
                else
                {
                    listContent.topOffset = (listContent.bottomOffset = 0);
                    offscreenExtraRowsTop = (offscreenExtraRowsBottom = 0);
                };
            };
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("directionChanged"));
        }

        [Bindable("directionChanged")]
        public function get direction():String
        {
            return (_direction);
        }

        override mx_internal function reconstructDataFromListItems():Array
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:IListItemRenderer;
            var _local_5:Object;
            if (((direction == TileBaseDirection.HORIZONTAL) || (!(listItems))))
            {
                return (super.reconstructDataFromListItems());
            };
            var _local_1:Array = [];
            if (listItems.length > 0)
            {
                _local_2 = 0;
                while (_local_2 < listItems[0].length)
                {
                    _local_3 = 0;
                    while (_local_3 < listItems.length)
                    {
                        if (((listItems[_local_3]) && (listItems[_local_3].length > _local_2)))
                        {
                            _local_4 = (listItems[_local_3][_local_2] as IListItemRenderer);
                            if (_local_4)
                            {
                                _local_5 = _local_4.data;
                                _local_1.push(_local_5);
                            };
                        };
                        _local_3++;
                    };
                    _local_2++;
                };
            };
            return (_local_1);
        }

        override protected function moveSelectionHorizontally(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:IListItemRenderer;
            var _local_7:String;
            var _local_8:int;
            var _local_9:Boolean;
            var _local_10:int;
            var _local_11:int;
            var _local_16:ScrollEvent;
            var _local_12:int = ((listItems[0].length - offscreenExtraColumnsLeft) - offscreenExtraColumnsRight);
            var _local_13:int = (((maxColumns > 0) && (!(direction == TileBaseDirection.VERTICAL))) ? maxColumns : _local_12);
            var _local_14:int = ((displayingPartialRow()) ? 1 : 0);
            var _local_15:int = ((displayingPartialColumn()) ? 1 : 0);
            if (!collection)
            {
                return;
            };
            showCaret = true;
            switch (_arg_1)
            {
                case Keyboard.LEFT:
                    if (caretIndex > 0)
                    {
                        if (direction == TileBaseDirection.HORIZONTAL)
                        {
                            caretIndex--;
                        }
                        else
                        {
                            _local_10 = indexToRow(caretIndex);
                            _local_11 = indexToColumn(caretIndex);
                            if (_local_11 == 0)
                            {
                                _local_10--;
                                _local_11 = lastColumnInRow(_local_10);
                            }
                            else
                            {
                                _local_11--;
                            };
                            caretIndex = Math.min(indicesToIndex(_local_10, _local_11), (collection.length - 1));
                        };
                        _local_10 = indexToRow(caretIndex);
                        _local_11 = indexToColumn(caretIndex);
                        if (direction == TileBaseDirection.HORIZONTAL)
                        {
                            if (_local_10 < verticalScrollPosition)
                            {
                                _local_4 = (verticalScrollPosition - 1);
                            }
                            else
                            {
                                if (_local_10 > ((verticalScrollPosition + rowCount) - _local_14))
                                {
                                    _local_4 = maxVerticalScrollPosition;
                                };
                            };
                        }
                        else
                        {
                            if (_local_11 < horizontalScrollPosition)
                            {
                                _local_5 = (horizontalScrollPosition - 1);
                            }
                            else
                            {
                                if (_local_11 > (((horizontalScrollPosition + _local_12) - 1) - _local_15))
                                {
                                    _local_5 = maxHorizontalScrollPosition;
                                };
                            };
                        };
                    };
                    break;
                case Keyboard.RIGHT:
                    if (caretIndex < (collection.length - 1))
                    {
                        if (((direction == TileBaseDirection.HORIZONTAL) || (caretIndex == -1)))
                        {
                            caretIndex++;
                        }
                        else
                        {
                            _local_10 = indexToRow(caretIndex);
                            _local_11 = indexToColumn(caretIndex);
                            if (_local_11 == lastColumnInRow(_local_10))
                            {
                                _local_11 = 0;
                                _local_10++;
                            }
                            else
                            {
                                _local_11++;
                            };
                            caretIndex = Math.min(indicesToIndex(_local_10, _local_11), (collection.length - 1));
                        };
                        _local_10 = indexToRow(caretIndex);
                        _local_11 = indexToColumn(caretIndex);
                        if (direction == TileBaseDirection.HORIZONTAL)
                        {
                            if (((_local_10 >= ((verticalScrollPosition + rowCount) - _local_14)) && (verticalScrollPosition < maxVerticalScrollPosition)))
                            {
                                _local_4 = (verticalScrollPosition + 1);
                            };
                            if (_local_10 < verticalScrollPosition)
                            {
                                _local_4 = _local_10;
                            };
                        }
                        else
                        {
                            if (((_local_11 >= ((horizontalScrollPosition + _local_12) - _local_15)) && (horizontalScrollPosition < maxHorizontalScrollPosition)))
                            {
                                _local_5 = (horizontalScrollPosition + 1);
                            };
                            if (_local_11 < horizontalScrollPosition)
                            {
                                _local_5 = _local_11;
                            };
                        };
                    };
                    break;
                case Keyboard.PAGE_UP:
                    if (caretIndex < 0)
                    {
                        caretIndex = scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition);
                    };
                    _local_10 = indexToRow(caretIndex);
                    _local_11 = indexToColumn(caretIndex);
                    if (_local_11 > 0)
                    {
                        _local_5 = (_local_11 = Math.max((horizontalScrollPosition - (_local_12 - _local_15)), 0));
                        caretIndex = indicesToIndex(_local_10, _local_11);
                    };
                    break;
                case Keyboard.PAGE_DOWN:
                    if (caretIndex < 0)
                    {
                        caretIndex = scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition);
                    };
                    _local_10 = indexToRow(caretIndex);
                    _local_11 = indexToColumn(caretIndex);
                    if (_local_11 < maxHorizontalScrollPosition)
                    {
                        _local_11 = Math.min(((horizontalScrollPosition + _local_12) - _local_15), indexToColumn((collection.length - 1)));
                        if (_local_11 > horizontalScrollPosition)
                        {
                            _local_5 = Math.min(_local_11, maxHorizontalScrollPosition);
                        };
                        caretIndex = indicesToIndex(_local_10, _local_11);
                    };
                    break;
                case Keyboard.HOME:
                    if (collection.length)
                    {
                        caretIndex = 0;
                        _local_5 = 0;
                        _local_4 = 0;
                    };
                    break;
                case Keyboard.END:
                    if (caretIndex < collection.length)
                    {
                        caretIndex = (collection.length - 1);
                        _local_5 = maxHorizontalScrollPosition;
                        _local_4 = maxVerticalScrollPosition;
                    };
                    break;
            };
            if (!isNaN(_local_4))
            {
                if (_local_4 != verticalScrollPosition)
                {
                    _local_16 = new ScrollEvent(ScrollEvent.SCROLL);
                    _local_16.detail = ScrollEventDetail.THUMB_POSITION;
                    _local_16.direction = ScrollEventDirection.VERTICAL;
                    _local_16.delta = (_local_4 - verticalScrollPosition);
                    _local_16.position = _local_4;
                    verticalScrollPosition = _local_4;
                    dispatchEvent(_local_16);
                };
            };
            if (iteratorValid)
            {
                if (!isNaN(_local_5))
                {
                    if (_local_5 != horizontalScrollPosition)
                    {
                        _local_16 = new ScrollEvent(ScrollEvent.SCROLL);
                        _local_16.detail = ScrollEventDetail.THUMB_POSITION;
                        _local_16.direction = ScrollEventDirection.HORIZONTAL;
                        _local_16.delta = (_local_5 - horizontalScrollPosition);
                        _local_16.position = _local_5;
                        horizontalScrollPosition = _local_5;
                        dispatchEvent(_local_16);
                    };
                };
            };
            if (!iteratorValid)
            {
                keySelectionPending = true;
                return;
            };
            bShiftKey = _arg_2;
            bCtrlKey = _arg_3;
            lastKey = _arg_1;
            finishKeySelection();
        }

        override mx_internal function removeClipMask():void
        {
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (itemsNeedMeasurement)
            {
                itemsNeedMeasurement = false;
                if (isNaN(explicitRowHeight))
                {
                    setRowHeight(measureHeightOfItems(0, 1));
                };
                if (isNaN(explicitColumnWidth))
                {
                    setColumnWidth(measureWidthOfItems(0, 1));
                };
            };
        }

        override public function scrollToIndex(index:int):Boolean
        {
            var newVPos:int;
            var newHPos:int;
            var firstIndex:int = scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition);
            var numItemsVisible:int = (((listItems.length - offscreenExtraRowsTop) - offscreenExtraRowsBottom) * ((listItems[0].length - offscreenExtraColumnsLeft) - offscreenExtraColumnsRight));
            if (((index >= (firstIndex + numItemsVisible)) || (index < firstIndex)))
            {
                newVPos = Math.min(indexToRow(index), maxVerticalScrollPosition);
                newHPos = Math.min(indexToColumn(index), maxHorizontalScrollPosition);
                try
                {
                    iterator.seek(CursorBookmark.FIRST, scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition));
                    super.horizontalScrollPosition = newHPos;
                    super.verticalScrollPosition = newVPos;
                }
                catch(e:ItemPendingError)
                {
                };
                return (true);
            };
            return (false);
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
                if (!_arg_1)
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
                if ((((freeItemRenderers) && (freeItemRenderers.length)) && (freeItemRenderersByFactory[_local_2])))
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

        protected function drawTileBackgrounds():void
        {
            var _local_2:Array;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:IListItemRenderer;
            var _local_10:int;
            var _local_11:DisplayObject;
            var _local_1:Sprite = Sprite(listContent.getChildByName("tileBGs"));
            if (!_local_1)
            {
                _local_1 = new FlexSprite();
                _local_1.mouseEnabled = false;
                _local_1.name = "tileBGs";
                listContent.addChildAt(_local_1, 0);
            };
            _local_2 = getStyle("alternatingItemColors");
            if (((!(_local_2)) || (_local_2.length == 0)))
            {
                while (_local_1.numChildren > _local_5)
                {
                    _local_1.removeChildAt((_local_1.numChildren - 1));
                };
                return;
            };
            StyleManager.getColorNames(_local_2);
            var _local_3:int;
            var _local_4:int;
            while (_local_4 < rowCount)
            {
                _local_6 = 0;
                while (_local_6 < columnCount)
                {
                    _local_7 = ((_local_4 < (rowCount - 1)) ? rowHeight : Math.min(rowHeight, (listContent.height - ((rowCount - 1) * rowHeight))));
                    _local_8 = ((_local_6 < (columnCount - 1)) ? columnWidth : Math.min(columnWidth, (listContent.width - ((columnCount - 1) * columnWidth))));
                    _local_9 = ((listItems[_local_4]) ? listItems[_local_4][_local_6] : null);
                    _local_10 = (((verticalScrollPosition + _local_4) * columnCount) + (horizontalScrollPosition + _local_6));
                    _local_11 = drawTileBackground(_local_1, _local_4, _local_6, _local_8, _local_7, _local_2[(_local_10 % _local_2.length)], _local_9);
                    _local_11.y = (_local_4 * rowHeight);
                    _local_11.x = (_local_6 * columnWidth);
                    _local_6++;
                };
                _local_4++;
            };
            _local_5 = (rowCount * columnCount);
            while (_local_1.numChildren > _local_5)
            {
                _local_1.removeChildAt((_local_1.numChildren - 1));
            };
        }

        private function displayingPartialRow():Boolean
        {
            var _local_2:IListItemRenderer;
            var _local_1:Array = listItems[((listItems.length - 1) - offscreenExtraRowsBottom)];
            if (((_local_1) && (_local_1.length > 0)))
            {
                _local_2 = _local_1[0];
                if (((!(_local_2)) || ((_local_2.y + _local_2.height) > (listContent.heightExcludingOffsets - listContent.topOffset))))
                {
                    return (true);
                };
            };
            return (false);
        }

        override protected function createChildren():void
        {
            super.createChildren();
            listContent.mask = maskShape;
        }

        override mx_internal function addClipMask(_arg_1:Boolean):void
        {
        }

        override protected function finishKeySelection():void
        {
            var _local_1:String;
            var _local_3:int;
            var _local_4:int;
            var _local_5:IListItemRenderer;
            var _local_6:ListEvent;
            var _local_2:Boolean;
            if (caretIndex < 0)
            {
                return;
            };
            _local_3 = indexToRow(caretIndex);
            _local_4 = indexToColumn(caretIndex);
            _local_5 = listItems[((_local_3 - verticalScrollPosition) + offscreenExtraRowsTop)][((_local_4 - horizontalScrollPosition) + offscreenExtraColumnsLeft)];
            if (!bCtrlKey)
            {
                selectItem(_local_5, bShiftKey, bCtrlKey);
                _local_2 = true;
            };
            if (bCtrlKey)
            {
                _local_1 = itemToUID(_local_5.data);
                drawItem(visibleData[_local_1], (!(selectedData[_local_1] == null)), false, true);
            };
            if (_local_2)
            {
                _local_6 = new ListEvent(ListEvent.CHANGE);
                _local_6.itemRenderer = _local_5;
                _local_6.rowIndex = _local_3;
                _local_6.columnIndex = _local_4;
                dispatchEvent(_local_6);
            };
        }

        override protected function scrollPositionToIndex(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            if (iterator)
            {
                if (direction == TileBaseDirection.HORIZONTAL)
                {
                    _local_3 = ((_arg_2 * columnCount) + _arg_1);
                }
                else
                {
                    _local_3 = ((_arg_1 * rowCount) + _arg_2);
                };
                return (_local_3);
            };
            return (-1);
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:int;
            var _local_4:int;
            if (!iteratorValid)
            {
                return;
            };
            if (!collection)
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
                    if (direction == TileBaseDirection.VERTICAL)
                    {
                        moveSelectionHorizontally(_arg_1.keyCode, _arg_1.shiftKey, _arg_1.ctrlKey);
                    }
                    else
                    {
                        moveSelectionVertically(_arg_1.keyCode, _arg_1.shiftKey, _arg_1.ctrlKey);
                    };
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.SPACE:
                    if (caretIndex < 0) break;
                    _local_3 = indexToRow(caretIndex);
                    _local_4 = indexToColumn(caretIndex);
                    _local_2 = listItems[(_local_3 - verticalScrollPosition)][(_local_4 - horizontalScrollPosition)];
                    selectItem(_local_2, _arg_1.shiftKey, _arg_1.ctrlKey);
                    return;
                default:
                    if (findKey(_arg_1.keyCode))
                    {
                        _arg_1.stopPropagation();
                    };
            };
        }

        override protected function indexToColumn(_arg_1:int):int
        {
            var _local_3:int;
            if (direction == TileBaseDirection.VERTICAL)
            {
                _local_3 = ((maxRows > 0) ? maxRows : rowCount);
                return (Math.floor((_arg_1 / _local_3)));
            };
            var _local_2:int = ((maxColumns > 0) ? maxColumns : columnCount);
            return (_arg_1 % _local_2);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            if (((explicitColumnCount > 0) && (isNaN(explicitColumnWidth))))
            {
                setColumnWidth(Math.floor((((width - viewMetrics.left) - viewMetrics.right) / explicitColumnCount)));
            };
            if (((explicitRowCount > 0) && (isNaN(explicitRowHeight))))
            {
                setRowHeight(Math.floor((((height - viewMetrics.top) - viewMetrics.bottom) / explicitRowCount)));
            };
            super.updateDisplayList(_arg_1, _arg_2);
            drawTileBackgrounds();
        }

        override protected function scrollHorizontally(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Number;
            var _local_7:String;
            var _local_8:int;
            var _local_9:Number;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:IListItemRenderer;
            var _local_23:int;
            var _local_24:int;
            var _local_25:Point;
            var _local_26:int;
            var _local_27:IListItemRenderer;
            var _local_28:int;
            var _local_29:int;
            if (_arg_2 == 0)
            {
                return;
            };
            removeClipMask();
            var _local_10:int = offscreenExtraColumnsRight;
            var _local_11:int = offscreenExtraColumnsLeft;
            var _local_12:int = int((offscreenExtraColumns / 2));
            var _local_13:int = int((offscreenExtraColumns / 2));
            if (_arg_3)
            {
                offscreenExtraColumnsLeft = Math.min(_local_12, (offscreenExtraColumnsLeft + _arg_2));
                _local_14 = (_arg_2 - (offscreenExtraColumnsLeft - _local_11));
                _local_15 = _local_14;
            }
            else
            {
                _local_20 = ((((((offscreenExtraColumnsRight == 0) && (listItems[0])) && (listItems[0].length > 0)) && (listItems[0][(listItems[0].length - 1)])) && ((listItems[0][(listItems[0].length - 1)].x + columnWidth) < (listContent.widthExcludingOffsets - listContent.leftOffset))) ? 1 : 0);
                offscreenExtraColumnsLeft = Math.min(_local_12, _arg_1);
                offscreenExtraColumnsRight = Math.min(((offscreenExtraColumnsRight + _arg_2) - _local_20), _local_13);
                _local_14 = (_arg_2 - (_local_11 - offscreenExtraColumnsLeft));
                _local_16 = (((offscreenExtraColumnsLeft - _local_11) + _local_20) + (offscreenExtraColumnsRight - _local_10));
                _local_15 = ((_arg_2 - (offscreenExtraColumnsRight - _local_10)) - _local_20);
            };
            var _local_17:int = listItems[0].length;
            var _local_18:int;
            while (_local_18 < _local_15)
            {
                _local_21 = 0;
                while (_local_21 < rowCount)
                {
                    _local_22 = ((_arg_3) ? listItems[_local_21][_local_18] : listItems[_local_21][((_local_17 - _local_18) - 1)]);
                    if (_local_22)
                    {
                        delete visibleData[rowMap[_local_22.name].uid];
                        removeIndicators(rowMap[_local_22.name].uid);
                        addToFreeItemRenderers(_local_22);
                        delete rowMap[_local_22.name];
                        if (_arg_3)
                        {
                            listItems[_local_21][_local_18] = null;
                        }
                        else
                        {
                            listItems[_local_21][((_local_17 - _local_18) - 1)] = null;
                        };
                    };
                    _local_21++;
                };
                _local_18++;
            };
            if (_arg_3)
            {
                _local_9 = (_local_14 * columnWidth);
                _local_6 = 0;
                _local_18 = _local_14;
                while (_local_18 < _local_17)
                {
                    _local_21 = 0;
                    while (_local_21 < rowCount)
                    {
                        _local_27 = listItems[_local_21][_local_18];
                        if (_local_27)
                        {
                            _local_22 = _local_27;
                            _local_22.x = (_local_22.x - _local_9);
                            _local_7 = rowMap[_local_22.name].uid;
                            listItems[_local_21][(_local_18 - _local_14)] = _local_22;
                            rowMap[_local_22.name].columnIndex = (rowMap[_local_22.name].columnIndex - _local_14);
                            moveIndicatorsHorizontally(_local_7, -(_local_9));
                        }
                        else
                        {
                            listItems[_local_21][(_local_18 - _local_14)] = null;
                        };
                        _local_21++;
                    };
                    _local_6 = (_local_6 + columnWidth);
                    _local_18++;
                };
                _local_18 = 0;
                while (_local_18 < _local_14)
                {
                    _local_21 = 0;
                    while (_local_21 < rowCount)
                    {
                        listItems[_local_21][((_local_17 - _local_18) - 1)] = null;
                        _local_21++;
                    };
                    _local_18++;
                };
                _local_8 = indicesToIndex(verticalScrollPosition, (((horizontalScrollPosition + _local_17) - offscreenExtraColumnsLeft) - _local_14));
                seekPositionSafely(_local_8);
                _local_23 = (_arg_2 + (_local_13 - _local_10));
                _local_24 = ((listItems.length) ? (listItems[0].length - _local_14) : 0);
                allowRendererStealingDuringLayout = false;
                _local_25 = makeRowsAndColumns(_local_6, 0, listContent.width, listContent.height, (_local_17 - _local_14), 0, true, _local_23);
                allowRendererStealingDuringLayout = true;
                _local_26 = (listItems[0].length - (_local_24 + _local_25.x));
                if (_local_26)
                {
                    _local_18 = 0;
                    while (_local_18 < listItems.length)
                    {
                        _local_21 = 0;
                        while (_local_21 < _local_26)
                        {
                            listItems[_local_18].pop();
                            _local_21++;
                        };
                        _local_18++;
                    };
                };
                _local_8 = indicesToIndex(verticalScrollPosition, (horizontalScrollPosition - offscreenExtraColumnsLeft));
                seekPositionSafely(_local_8);
                offscreenExtraColumnsRight = Math.max(0, (_local_13 - ((_local_25.x < _arg_2) ? (_local_23 - _local_25.x) : 0)));
            }
            else
            {
                if (_local_16 < 0)
                {
                    _local_29 = (listItems[0].length + _local_16);
                    _local_21 = 0;
                    while (_local_21 < rowCount)
                    {
                        while (listItems[_local_21].length > _local_29)
                        {
                            listItems[_local_21].pop();
                        };
                        _local_21++;
                    };
                };
                _local_9 = (_local_14 * columnWidth);
                if (_local_14)
                {
                    _local_6 = _local_9;
                };
                _local_28 = (_local_17 + _local_16);
                _local_18 = ((_local_28 - _local_14) - 1);
                while (_local_18 >= 0)
                {
                    _local_21 = 0;
                    while (_local_21 < rowCount)
                    {
                        _local_22 = listItems[_local_21][_local_18];
                        if (_local_22)
                        {
                            _local_22.x = (_local_22.x + _local_9);
                            _local_7 = rowMap[_local_22.name].uid;
                            listItems[_local_21][(_local_18 + _local_14)] = _local_22;
                            rowMap[_local_22.name].columnIndex = (rowMap[_local_22.name].columnIndex + _local_14);
                            moveIndicatorsHorizontally(_local_7, _local_9);
                        }
                        else
                        {
                            listItems[_local_21][(_local_18 + _local_14)] = null;
                        };
                        _local_21++;
                    };
                    _local_18--;
                };
                _local_18 = 0;
                while (_local_18 < _local_14)
                {
                    _local_21 = 0;
                    while (_local_21 < rowCount)
                    {
                        listItems[_local_21][_local_18] = null;
                        _local_21++;
                    };
                    _local_18++;
                };
                _local_8 = indicesToIndex(verticalScrollPosition, (horizontalScrollPosition - offscreenExtraColumnsLeft));
                seekPositionSafely(_local_8);
                allowRendererStealingDuringLayout = false;
                makeRowsAndColumns(0, 0, _local_6, listContent.height, 0, 0, true, _local_14);
                allowRendererStealingDuringLayout = true;
                seekPositionSafely(_local_8);
            };
            var _local_19:Number = listContent.widthExcludingOffsets;
            listContent.leftOffset = (-(columnWidth) * offscreenExtraColumnsLeft);
            listContent.rightOffset = ((offscreenExtraColumnsRight) ? (((listItems[0][(listItems[0].length - 1)].x + listItems[0][(listItems[0].length - 1)].width) + listContent.leftOffset) - _local_19) : 0);
            adjustListContent();
            addClipMask(false);
        }

        override mx_internal function adjustOffscreenRowsAndColumns():void
        {
            if (direction == TileBaseDirection.VERTICAL)
            {
                offscreenExtraRows = 0;
                offscreenExtraColumns = offscreenExtraRowsOrColumns;
            }
            else
            {
                offscreenExtraColumns = 0;
                offscreenExtraRows = offscreenExtraRowsOrColumns;
            };
        }

        override protected function moveSelectionVertically(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:IListItemRenderer;
            var _local_7:String;
            var _local_8:int;
            var _local_9:Boolean;
            var _local_11:int;
            var _local_12:int;
            var _local_17:ScrollEvent;
            var _local_10:Boolean;
            var _local_13:int = ((listItems.length - offscreenExtraRowsTop) - offscreenExtraRowsBottom);
            var _local_14:int = (((maxRows > 0) && (!(direction == TileBaseDirection.HORIZONTAL))) ? maxRows : _local_13);
            var _local_15:int = ((displayingPartialRow()) ? 1 : 0);
            var _local_16:int = ((displayingPartialColumn()) ? 1 : 0);
            if (!collection)
            {
                return;
            };
            showCaret = true;
            switch (_arg_1)
            {
                case Keyboard.UP:
                    if (caretIndex > 0)
                    {
                        if (direction == TileBaseDirection.VERTICAL)
                        {
                            caretIndex--;
                        }
                        else
                        {
                            _local_11 = indexToRow(caretIndex);
                            _local_12 = indexToColumn(caretIndex);
                            if (_local_11 == 0)
                            {
                                _local_12--;
                                _local_11 = lastRowInColumn(_local_12);
                            }
                            else
                            {
                                _local_11--;
                            };
                            caretIndex = Math.min(indicesToIndex(_local_11, _local_12), (collection.length - 1));
                        };
                        _local_11 = indexToRow(caretIndex);
                        _local_12 = indexToColumn(caretIndex);
                        if (_local_11 < verticalScrollPosition)
                        {
                            _local_4 = (verticalScrollPosition - 1);
                        };
                        if (_local_11 > ((verticalScrollPosition + _local_13) - _local_15))
                        {
                            _local_4 = maxVerticalScrollPosition;
                        };
                        if (_local_12 < horizontalScrollPosition)
                        {
                            _local_5 = (horizontalScrollPosition - 1);
                        };
                    };
                    break;
                case Keyboard.DOWN:
                    if (caretIndex < (collection.length - 1))
                    {
                        if (((direction == TileBaseDirection.VERTICAL) || (caretIndex == -1)))
                        {
                            caretIndex++;
                        }
                        else
                        {
                            _local_11 = indexToRow(caretIndex);
                            _local_12 = indexToColumn(caretIndex);
                            if (_local_11 == lastRowInColumn(_local_12))
                            {
                                _local_11 = 0;
                                _local_12++;
                            }
                            else
                            {
                                _local_11++;
                            };
                            caretIndex = Math.min(indicesToIndex(_local_11, _local_12), (collection.length - 1));
                        };
                        _local_11 = indexToRow(caretIndex);
                        _local_12 = indexToColumn(caretIndex);
                        if (((_local_11 >= ((verticalScrollPosition + _local_13) - _local_15)) && (verticalScrollPosition < maxVerticalScrollPosition)))
                        {
                            _local_4 = (verticalScrollPosition + 1);
                        };
                        if (_local_11 < verticalScrollPosition)
                        {
                            _local_4 = _local_11;
                        };
                        if (_local_12 > ((horizontalScrollPosition + columnCount) - 1))
                        {
                            _local_5 = (horizontalScrollPosition + 1);
                        };
                    };
                    break;
                case Keyboard.PAGE_UP:
                    if (caretIndex < 0)
                    {
                        caretIndex = scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition);
                    };
                    _local_11 = indexToRow(caretIndex);
                    _local_12 = indexToColumn(caretIndex);
                    if (verticalScrollPosition > 0)
                    {
                        if (_local_11 == verticalScrollPosition)
                        {
                            _local_4 = (_local_11 = Math.max((verticalScrollPosition - (_local_13 - _local_15)), 0));
                        }
                        else
                        {
                            _local_11 = verticalScrollPosition;
                        };
                        caretIndex = indicesToIndex(_local_11, _local_12);
                        break;
                    };
                case Keyboard.HOME:
                    if (collection.length)
                    {
                        caretIndex = 0;
                        _local_4 = 0;
                        _local_5 = 0;
                    };
                    break;
                case Keyboard.PAGE_DOWN:
                    if (caretIndex < 0)
                    {
                        caretIndex = scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition);
                    };
                    _local_11 = indexToRow(caretIndex);
                    _local_12 = indexToColumn(caretIndex);
                    if (_local_11 < maxVerticalScrollPosition)
                    {
                        if (_local_11 == (verticalScrollPosition + (_local_13 - _local_15)))
                        {
                            _local_4 = Math.min(((verticalScrollPosition + _local_13) - _local_15), maxVerticalScrollPosition);
                            _local_11 = (verticalScrollPosition + _local_13);
                        }
                        else
                        {
                            _local_11 = Math.min(((verticalScrollPosition + _local_13) - _local_15), indexToRow((collection.length - 1)));
                            if (_local_11 == ((verticalScrollPosition + _local_13) - _local_15))
                            {
                                _local_4 = Math.min(((verticalScrollPosition + _local_13) - _local_15), maxVerticalScrollPosition);
                            };
                        };
                        caretIndex = Math.min(indicesToIndex(_local_11, _local_12), (collection.length - 1));
                        break;
                    };
                case Keyboard.END:
                    if (caretIndex < collection.length)
                    {
                        caretIndex = (collection.length - 1);
                        _local_4 = maxVerticalScrollPosition;
                        _local_5 = maxHorizontalScrollPosition;
                    };
                    break;
            };
            if (!isNaN(_local_4))
            {
                if (_local_4 != verticalScrollPosition)
                {
                    _local_17 = new ScrollEvent(ScrollEvent.SCROLL);
                    _local_17.detail = ScrollEventDetail.THUMB_POSITION;
                    _local_17.direction = ScrollEventDirection.VERTICAL;
                    _local_17.delta = (_local_4 - verticalScrollPosition);
                    _local_17.position = _local_4;
                    verticalScrollPosition = _local_4;
                    dispatchEvent(_local_17);
                };
            };
            if (iteratorValid)
            {
                if (!isNaN(_local_5))
                {
                    if (_local_5 != horizontalScrollPosition)
                    {
                        _local_17 = new ScrollEvent(ScrollEvent.SCROLL);
                        _local_17.detail = ScrollEventDetail.THUMB_POSITION;
                        _local_17.direction = ScrollEventDirection.HORIZONTAL;
                        _local_17.delta = (_local_5 - horizontalScrollPosition);
                        _local_17.position = _local_5;
                        horizontalScrollPosition = _local_5;
                        dispatchEvent(_local_17);
                    };
                };
            };
            if (!iteratorValid)
            {
                keySelectionPending = true;
                return;
            };
            bShiftKey = _arg_2;
            bCtrlKey = _arg_3;
            lastKey = _arg_1;
            finishKeySelection();
        }

        override protected function scrollVertically(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Number;
            var _local_7:String;
            var _local_8:int;
            var _local_9:Number;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:IListItemRenderer;
            var _local_24:int;
            var _local_25:Point;
            var _local_26:int;
            removeClipMask();
            var _local_10:int = offscreenExtraRowsBottom;
            var _local_11:int = offscreenExtraRowsTop;
            var _local_12:int = int((offscreenExtraRows / 2));
            var _local_13:int = int((offscreenExtraRows / 2));
            if (_arg_3)
            {
                offscreenExtraRowsTop = Math.min(_local_12, (offscreenExtraRowsTop + _arg_2));
                _local_14 = (_arg_2 - (offscreenExtraRowsTop - _local_11));
                _local_15 = _local_14;
            }
            else
            {
                _local_21 = (((((offscreenExtraRowsBottom == 0) && (listItems.length)) && (listItems[(listItems.length - 1)][0])) && ((listItems[(listItems.length - 1)][0].y + rowHeight) < (listContent.heightExcludingOffsets - listContent.topOffset))) ? 1 : 0);
                offscreenExtraRowsTop = Math.min(_local_12, _arg_1);
                offscreenExtraRowsBottom = Math.min(((offscreenExtraRowsBottom + _arg_2) - _local_21), _local_13);
                _local_14 = (_arg_2 - (_local_11 - offscreenExtraRowsTop));
                _local_16 = (((offscreenExtraRowsTop - _local_11) + _local_21) + (offscreenExtraRowsBottom - _local_10));
                _local_15 = ((_arg_2 - (offscreenExtraRowsBottom - _local_10)) - _local_21);
            };
            var _local_17:int = listItems.length;
            var _local_18:int;
            while (_local_18 < _local_15)
            {
                _local_5 = ((_arg_3) ? listItems[_local_18].length : listItems[((_local_17 - _local_18) - 1)].length);
                _local_22 = 0;
                while (((_local_22 < columnCount) && (_local_22 < _local_5)))
                {
                    _local_23 = ((_arg_3) ? listItems[_local_18][_local_22] : listItems[((_local_17 - _local_18) - 1)][_local_22]);
                    if (_local_23)
                    {
                        delete visibleData[rowMap[_local_23.name].uid];
                        removeIndicators(rowMap[_local_23.name].uid);
                        addToFreeItemRenderers(_local_23);
                        delete rowMap[_local_23.name];
                        if (_arg_3)
                        {
                            listItems[_local_18][_local_22] = null;
                        }
                        else
                        {
                            listItems[((_local_17 - _local_18) - 1)][_local_22] = null;
                        };
                    };
                    _local_22++;
                };
                _local_18++;
            };
            var _local_19:int = listItems.length;
            if (_arg_3)
            {
                _local_9 = (_local_14 * rowHeight);
                _local_6 = 0;
                _local_18 = _local_14;
                while (_local_18 < _local_19)
                {
                    _local_5 = listItems[_local_18].length;
                    _local_22 = 0;
                    while (((_local_22 < columnCount) && (_local_22 < _local_5)))
                    {
                        _local_23 = listItems[_local_18][_local_22];
                        listItems[(_local_18 - _local_14)][_local_22] = _local_23;
                        if (_local_23)
                        {
                            _local_23.y = (_local_23.y - _local_9);
                            rowMap[_local_23.name].rowIndex = (rowMap[_local_23.name].rowIndex - _local_14);
                            moveIndicatorsVertically(rowMap[_local_23.name].uid, -(_local_9));
                        };
                        _local_22++;
                    };
                    if (_local_5 < columnCount)
                    {
                        _local_22 = _local_5;
                        while (_local_22 < columnCount)
                        {
                            listItems[(_local_18 - _local_14)][_local_22] = null;
                            _local_22++;
                        };
                    };
                    rowInfo[(_local_18 - _local_14)] = rowInfo[_local_18];
                    rowInfo[(_local_18 - _local_14)].y = (rowInfo[(_local_18 - _local_14)].y - _local_9);
                    _local_6 = (rowInfo[(_local_18 - _local_14)].y + rowHeight);
                    _local_18++;
                };
                listItems.splice(((_local_19 - _local_14) - 1), _local_14);
                rowInfo.splice(((_local_19 - _local_14) - 1), _local_14);
                _local_8 = indicesToIndex((((verticalScrollPosition - offscreenExtraRowsTop) + _local_19) - _local_14), horizontalScrollPosition);
                seekPositionSafely(_local_8);
                _local_24 = (_arg_2 + (_local_13 - _local_10));
                _local_25 = makeRowsAndColumns(0, _local_6, listContent.width, (_local_6 + (_arg_2 * rowHeight)), 0, (_local_19 - _local_14), true, _local_24);
                _local_26 = (_local_24 - _local_25.y);
                while (_local_26--)
                {
                    listItems.pop();
                    rowInfo.pop();
                };
                _local_8 = indicesToIndex((verticalScrollPosition - offscreenExtraRowsTop), horizontalScrollPosition);
                seekPositionSafely(_local_8);
                offscreenExtraRowsBottom = Math.max(0, (_local_13 - ((_local_25.y < _arg_2) ? (_local_24 - _local_25.y) : 0)));
            }
            else
            {
                if (_local_16 < 0)
                {
                    listItems.splice((listItems.length + _local_16), -(_local_16));
                    rowInfo.splice((rowInfo.length + _local_16), -(_local_16));
                }
                else
                {
                    if (_local_16 > 0)
                    {
                        _local_18 = 0;
                        while (_local_18 < _local_16)
                        {
                            listItems[(_local_19 + _local_18)] = [];
                            _local_18++;
                        };
                    };
                };
                _local_9 = (_local_14 * rowHeight);
                _local_6 = rowInfo[_local_14].y;
                _local_18 = ((listItems.length - 1) - _local_14);
                while (_local_18 >= 0)
                {
                    _local_5 = listItems[_local_18].length;
                    _local_22 = 0;
                    while (((_local_22 < columnCount) && (_local_22 < _local_5)))
                    {
                        _local_23 = listItems[_local_18][_local_22];
                        if (_local_23)
                        {
                            _local_23.y = (_local_23.y + _local_9);
                            rowMap[_local_23.name].rowIndex = (rowMap[_local_23.name].rowIndex + _local_14);
                            _local_7 = rowMap[_local_23.name].uid;
                            listItems[(_local_18 + _local_14)][_local_22] = _local_23;
                            moveIndicatorsVertically(_local_7, _local_9);
                        }
                        else
                        {
                            listItems[(_local_18 + _local_14)][_local_22] = null;
                        };
                        _local_22++;
                    };
                    rowInfo[(_local_18 + _local_14)] = rowInfo[_local_18];
                    rowInfo[(_local_18 + _local_14)].y = (rowInfo[(_local_18 + _local_14)].y + _local_9);
                    _local_18--;
                };
                _local_18 = 0;
                while (_local_18 < _local_14)
                {
                    _local_22 = 0;
                    while (_local_22 < columnCount)
                    {
                        listItems[_local_18][_local_22] = null;
                        _local_22++;
                    };
                    _local_18++;
                };
                _local_8 = indicesToIndex((verticalScrollPosition - offscreenExtraRowsTop), horizontalScrollPosition);
                seekPositionSafely(_local_8);
                allowRendererStealingDuringLayout = false;
                _local_25 = makeRowsAndColumns(0, 0, listContent.width, _local_6, 0, 0, true, _local_14);
                allowRendererStealingDuringLayout = true;
                seekPositionSafely(_local_8);
            };
            var _local_20:Number = listContent.heightExcludingOffsets;
            listContent.topOffset = (-(rowHeight) * offscreenExtraRowsTop);
            listContent.bottomOffset = ((offscreenExtraRowsBottom) ? (((rowInfo[(rowInfo.length - 1)].y + rowHeight) + listContent.topOffset) - _local_20) : 0);
            adjustListContent();
            addClipMask(false);
        }

        override public function showDropFeedback(_arg_1:DragEvent):void
        {
            var _local_7:Class;
            var _local_8:EdgeMetrics;
            if (!dropIndicator)
            {
                _local_7 = getStyle("dropIndicatorSkin");
                if (!_local_7)
                {
                    _local_7 = ListDropIndicator;
                };
                dropIndicator = IFlexDisplayObject(new (_local_7)());
                _local_8 = viewMetrics;
                drawFocus(true);
                dropIndicator.x = 2;
                if (direction == TileBaseDirection.HORIZONTAL)
                {
                    dropIndicator.setActualSize((rowHeight - 4), 4);
                    DisplayObject(dropIndicator).rotation = 90;
                }
                else
                {
                    dropIndicator.setActualSize((columnWidth - 4), 4);
                };
                dropIndicator.visible = true;
                listContent.addChild(DisplayObject(dropIndicator));
                if (collection)
                {
                    dragScrollingInterval = setInterval(dragScroll, 15);
                };
            };
            var _local_2:int = calculateDropIndex(_arg_1);
            var _local_3:int = indexToRow(_local_2);
            var _local_4:int = indexToColumn(_local_2);
            _local_3 = (_local_3 - (verticalScrollPosition - offscreenExtraRowsTop));
            _local_4 = (_local_4 - (horizontalScrollPosition - offscreenExtraColumnsLeft));
            var _local_5:Number = listItems.length;
            if (_local_3 >= _local_5)
            {
                _local_3 = (_local_5 - 1);
            };
            var _local_6:Number = ((_local_5) ? listItems[0].length : 0);
            if (_local_4 > _local_6)
            {
                _local_4 = _local_6;
            };
            dropIndicator.x = ((((_local_6) && (listItems[_local_3].length)) && (listItems[_local_3][_local_4])) ? listItems[_local_3][_local_4].x : (_local_4 * columnWidth));
            dropIndicator.y = ((((_local_5) && (listItems[_local_3].length)) && (listItems[_local_3][0])) ? listItems[_local_3][0].y : (_local_3 * rowHeight));
        }

        public function set maxColumns(_arg_1:int):void
        {
            if (_maxColumns != _arg_1)
            {
                _maxColumns = _arg_1;
                invalidateSize();
                invalidateDisplayList();
            };
        }

        override protected function configureScrollBars():void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_1:int = listItems.length;
            if (_local_1 == 0)
            {
                return;
            };
            var _local_2:int = listItems[0].length;
            if (_local_2 == 0)
            {
                return;
            };
            if (((_local_1 > 1) && ((((_local_1 - offscreenExtraRowsTop) - offscreenExtraRowsBottom) * rowHeight) > listContent.heightExcludingOffsets)))
            {
                _local_1--;
            };
            _local_1 = (_local_1 - (offscreenExtraRowsTop + offscreenExtraRowsBottom));
            if (((_local_2 > 1) && ((((_local_2 - offscreenExtraColumnsLeft) - offscreenExtraColumnsRight) * columnWidth) > listContent.widthExcludingOffsets)))
            {
                _local_2--;
            };
            _local_2 = (_local_2 - (offscreenExtraColumnsLeft + offscreenExtraColumnsRight));
            var _local_3:Object = horizontalScrollBar;
            var _local_4:Object = verticalScrollBar;
            if (direction == TileBaseDirection.VERTICAL)
            {
                if (((iteratorValid) && (horizontalScrollPosition > 0)))
                {
                    _local_8 = 0;
                    while (((_local_2 > 0) && (listItems[0][((_local_2 + offscreenExtraColumnsLeft) - 1)] == null)))
                    {
                        _local_2--;
                        _local_8++;
                    };
                    _local_9 = int(Math.floor((listContent.widthExcludingOffsets / columnWidth)));
                    _local_10 = Math.max(0, (_local_9 - (_local_2 + _local_8)));
                    if (((_local_8) || (_local_10)))
                    {
                        _local_11 = 0;
                        while (_local_11 < listItems.length)
                        {
                            while (listItems[_local_11].length > (_local_2 + offscreenExtraColumnsLeft))
                            {
                                (listItems[_local_11] as Array).pop();
                            };
                            _local_11++;
                        };
                        if (!runningDataEffect)
                        {
                            horizontalScrollPosition = Math.max(0, (horizontalScrollPosition - (_local_8 + _local_10)));
                            _local_7 = scrollPositionToIndex(Math.max(0, (horizontalScrollPosition - offscreenExtraColumnsLeft)), verticalScrollPosition);
                            seekPositionSafely(_local_7);
                            updateList();
                        };
                        return;
                    };
                };
                if (!iteratorValid)
                {
                    _local_1 = int(Math.floor((listContent.heightExcludingOffsets / rowHeight)));
                };
                _local_5 = ((maxRows > 0) ? maxRows : _local_1);
                _local_6 = int(((collection) ? int(Math.ceil((collection.length / _local_5))) : _local_2));
            }
            else
            {
                if (((iteratorValid) && (verticalScrollPosition > 0)))
                {
                    _local_12 = 0;
                    while (((_local_1 > 0) && ((listItems[((_local_1 + offscreenExtraRowsTop) - 1)] == null) || (listItems[((_local_1 + offscreenExtraRowsTop) - 1)][0] == null))))
                    {
                        _local_1--;
                        _local_12++;
                    };
                    if (_local_12)
                    {
                        while (listItems.length > (_local_1 + offscreenExtraRowsTop))
                        {
                            listItems.pop();
                            rowInfo.pop();
                        };
                        if (!runningDataEffect)
                        {
                            verticalScrollPosition = Math.max(0, (verticalScrollPosition - _local_12));
                            _local_7 = scrollPositionToIndex(horizontalScrollPosition, Math.max(0, (verticalScrollPosition - offscreenExtraRowsTop)));
                            seekPositionSafely(_local_7);
                            updateList();
                        };
                        return;
                    };
                };
                if (!iteratorValid)
                {
                    _local_2 = int(Math.floor((listContent.widthExcludingOffsets / columnWidth)));
                };
                _local_6 = ((maxColumns > 0) ? maxColumns : _local_2);
                _local_5 = int(((collection) ? int(Math.ceil((collection.length / _local_6))) : _local_1));
            };
            maxHorizontalScrollPosition = Math.max(0, (_local_6 - _local_2));
            maxVerticalScrollPosition = Math.max(0, (_local_5 - _local_1));
            setScrollBarProperties(_local_6, _local_2, _local_5, _local_1);
        }

        override protected function indexToRow(_arg_1:int):int
        {
            var _local_3:int;
            if (direction == TileBaseDirection.VERTICAL)
            {
                _local_3 = ((maxRows > 0) ? maxRows : rowCount);
                return (_arg_1 % _local_3);
            };
            var _local_2:int = ((maxColumns > 0) ? maxColumns : columnCount);
            return (Math.floor((_arg_1 / _local_2)));
        }

        private function displayingPartialColumn():Boolean
        {
            var _local_1:IListItemRenderer;
            if (((listItems[0]) && (listItems[0].length > 0)))
            {
                _local_1 = listItems[0][((listItems[0].length - 1) - offscreenExtraColumnsRight)];
                if (((_local_1) && ((_local_1.x + _local_1.width) > (listContent.widthExcludingOffsets - listContent.leftOffset))))
                {
                    return (true);
                };
            };
            return (false);
        }

        override protected function scrollHandler(event:Event):void
        {
            var scrollBar:ScrollBar;
            var pos:Number;
            var delta:int;
            var startIndex:int;
            var o:EdgeMetrics;
            var bookmark:CursorBookmark;
            if ((event is ScrollEvent))
            {
                if (((!(liveScrolling)) && (ScrollEvent(event).detail == ScrollEventDetail.THUMB_TRACK)))
                {
                    return;
                };
                scrollBar = ScrollBar(event.target);
                pos = scrollBar.scrollPosition;
                if (scrollBar == verticalScrollBar)
                {
                    delta = (pos - verticalScrollPosition);
                    super.scrollHandler(event);
                    if (((Math.abs(delta) >= listItems.length) || (!(iteratorValid))))
                    {
                        startIndex = indicesToIndex(pos, horizontalScrollPosition);
                        try
                        {
                            iterator.seek(CursorBookmark.FIRST, startIndex);
                            if (!iteratorValid)
                            {
                                iteratorValid = true;
                                lastSeekPending = null;
                            };
                        }
                        catch(e:ItemPendingError)
                        {
                            lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, startIndex);
                            e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                            iteratorValid = false;
                        };
                        bookmark = iterator.bookmark;
                        clearIndicators();
                        clearVisibleData();
                        makeRowsAndColumns(0, 0, listContent.width, listContent.height, 0, 0);
                        iterator.seek(bookmark, 0);
                        drawRowBackgrounds();
                    }
                    else
                    {
                        if (delta != 0)
                        {
                            scrollVertically(pos, Math.abs(delta), (delta > 0));
                        };
                    };
                }
                else
                {
                    delta = (pos - horizontalScrollPosition);
                    super.scrollHandler(event);
                    if (((Math.abs(delta) >= listItems[0].length) || (!(iteratorValid))))
                    {
                        startIndex = indicesToIndex(verticalScrollPosition, pos);
                        try
                        {
                            iterator.seek(CursorBookmark.FIRST, startIndex);
                            if (!iteratorValid)
                            {
                                iteratorValid = true;
                                lastSeekPending = null;
                            };
                        }
                        catch(e:ItemPendingError)
                        {
                            lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST, startIndex);
                            e.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                            iteratorValid = false;
                        };
                        bookmark = iterator.bookmark;
                        clearIndicators();
                        clearVisibleData();
                        makeRowsAndColumns(0, 0, listContent.width, listContent.height, 0, 0);
                        iterator.seek(bookmark, 0);
                        drawRowBackgrounds();
                    }
                    else
                    {
                        if (delta != 0)
                        {
                            scrollHorizontally(pos, Math.abs(delta), (delta > 0));
                        };
                    };
                };
            };
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

        override public function itemRendererToIndex(_arg_1:IListItemRenderer):int
        {
            var _local_2:String;
            var _local_5:int;
            var _local_6:int;
            if (runningDataEffect)
            {
                _local_2 = itemToUID(dataItemWrappersByRenderer[_arg_1]);
            }
            else
            {
                _local_2 = itemToUID(_arg_1.data);
            };
            var _local_3:int = listItems.length;
            var _local_4:int;
            while (_local_4 < listItems.length)
            {
                _local_5 = listItems[_local_4].length;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    if (((listItems[_local_4][_local_6]) && (rowMap[listItems[_local_4][_local_6].name].uid == _local_2)))
                    {
                        if (direction == TileBaseDirection.VERTICAL)
                        {
                            return ((((_local_6 + horizontalScrollPosition) - offscreenExtraColumnsLeft) * Math.max(maxRows, rowCount)) + _local_4);
                        };
                        return ((((_local_4 + verticalScrollPosition) - offscreenExtraRowsTop) * Math.max(maxColumns, columnCount)) + _local_6);
                    };
                    _local_6++;
                };
                _local_4++;
            };
            return (-1);
        }

        override public function measureHeightOfItems(_arg_1:int=-1, _arg_2:int=0):Number
        {
            var _local_3:Number;
            var _local_7:Object;
            var _local_8:Object;
            var _local_9:IFactory;
            var _local_10:IListItemRenderer;
            var _local_4:Boolean;
            if (((collection) && (collection.length)))
            {
                _local_7 = iterator.current;
                _local_8 = ((_local_7 is ItemWrapper) ? _local_7.data : _local_7);
                _local_9 = getItemRendererFactory(_local_8);
                _local_10 = measuringObjects[_local_9];
                if (_local_10 == null)
                {
                    _local_10 = getMeasuringRenderer(_local_8);
                    _local_4 = true;
                };
                setupRendererFromData(_local_10, _local_8);
                _local_3 = _local_10.getExplicitOrMeasuredHeight();
                if (_local_4)
                {
                    _local_10.setActualSize(_local_10.getExplicitOrMeasuredWidth(), _local_3);
                    _local_4 = false;
                };
            };
            if (((isNaN(_local_3)) || (_local_3 == 0)))
            {
                _local_3 = 50;
            };
            var _local_5:Number = getStyle("paddingTop");
            var _local_6:Number = getStyle("paddingBottom");
            _local_3 = (_local_3 + (_local_5 + _local_6));
            return (_local_3 * _arg_2);
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

        private function getPreparedItemRenderer(_arg_1:int, _arg_2:int, _arg_3:Object, _arg_4:Object, _arg_5:String):IListItemRenderer
        {
            var _local_7:IListItemRenderer;
            var _local_8:ListData;
            var _local_9:ListData;
            var _local_6:IListItemRenderer = listItems[_arg_1][_arg_2];
            if (_local_6)
            {
                if (((runningDataEffect) ? (!(dataItemWrappersByRenderer[_local_6] == _arg_3)) : (!(_local_6.data == _arg_4))))
                {
                    addToFreeItemRenderers(_local_6);
                }
                else
                {
                    _local_7 = _local_6;
                };
            };
            if (!_local_7)
            {
                if (allowRendererStealingDuringLayout)
                {
                    _local_7 = visibleData[_arg_5];
                    if (((!(_local_7)) && (!(_arg_3 == _arg_4))))
                    {
                        _local_7 = visibleData[itemToUID(_arg_4)];
                    };
                };
                if (_local_7)
                {
                    _local_9 = ListData(rowMap[_local_7.name]);
                    if (_local_9)
                    {
                        if ((((direction == TileBaseDirection.HORIZONTAL) && ((_local_9.rowIndex > _arg_1) || ((_local_9.rowIndex == _arg_1) && (_local_9.columnIndex > _arg_2)))) || ((direction == TileBaseDirection.VERTICAL) && ((_local_9.columnIndex > _arg_2) || ((_local_9.columnIndex == _arg_2) && (_local_9.rowIndex > _arg_1))))))
                        {
                            listItems[_local_9.rowIndex][_local_9.columnIndex] = null;
                        }
                        else
                        {
                            _local_7 = null;
                        };
                    };
                };
                if (!_local_7)
                {
                    _local_7 = getReservedOrFreeItemRenderer(_arg_3);
                    if (((_local_7) && (!(isRendererUnconstrained(_local_7)))))
                    {
                        _local_7.x = 0;
                        _local_7.y = 0;
                    };
                };
                if (!_local_7)
                {
                    _local_7 = createItemRenderer(_arg_4);
                };
                _local_7.owner = this;
                _local_7.styleName = listContent;
            };
            if (!_local_7.parent)
            {
                listContent.addChild(DisplayObject(_local_7));
            };
            _local_8 = ListData(makeListData(_arg_4, _arg_5, _arg_1, _arg_2));
            rowMap[_local_7.name] = _local_8;
            if ((_local_7 is IDropInListItemRenderer))
            {
                IDropInListItemRenderer(_local_7).listData = ((_arg_4) ? _local_8 : null);
            };
            _local_7.data = _arg_4;
            if (_arg_3 != _arg_4)
            {
                dataItemWrappersByRenderer[_local_7] = _arg_3;
            };
            _local_7.visible = true;
            if (_arg_5)
            {
                visibleData[_arg_5] = _local_7;
            };
            listItems[_arg_1][_arg_2] = _local_7;
            UIComponentGlobals.layoutManager.validateClient(_local_7, true);
            return (_local_7);
        }

        private function placeAndDrawItemRenderer(_arg_1:IListItemRenderer, _arg_2:Number, _arg_3:Number, _arg_4:String):void
        {
            var _local_8:Number;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:Boolean;
            _local_8 = _arg_1.getExplicitOrMeasuredHeight();
            if (((!(_arg_1.width == columnWidth)) || (!(_local_8 == ((rowHeight - cachedPaddingTop) - cachedPaddingBottom)))))
            {
                _arg_1.setActualSize(columnWidth, ((rowHeight - cachedPaddingTop) - cachedPaddingBottom));
            };
            if (!isRendererUnconstrained(_arg_1))
            {
                _arg_1.move(_arg_2, (_arg_3 + cachedPaddingTop));
            };
            _local_5 = (!(selectedData[_arg_4] == null));
            if (runningDataEffect)
            {
                _local_5 = ((_local_5) || (!(selectedData[itemToUID(_arg_1.data)] == null)));
                _local_5 = (((_local_5) && (!(getRendererSemanticValue(_arg_1, ModifiedCollectionView.REPLACEMENT)))) && (!(getRendererSemanticValue(_arg_1, ModifiedCollectionView.ADDED))));
            };
            _local_6 = (highlightUID == _arg_4);
            _local_7 = (caretUID == _arg_4);
            if (_arg_4)
            {
                drawItem(_arg_1, _local_5, _local_6, _local_7);
            };
        }

        override protected function makeRowsAndColumns(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:int, _arg_6:int, _arg_7:Boolean=false, _arg_8:uint=0):Point
        {
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Object;
            var _local_16:Object;
            var _local_17:String;
            var _local_18:IListItemRenderer;
            var _local_19:IListItemRenderer;
            var _local_20:Boolean;
            var _local_21:Boolean;
            var _local_22:int;
            var _local_23:Number;
            var _local_24:int;
            var _local_25:int;
            var _local_29:Array;
            var _local_26:Boolean;
            var _local_27:Boolean;
            var _local_28:Boolean;
            if (((columnWidth == 0) || (rowHeight == 0)))
            {
                return (null);
            };
            invalidateSizeFlag = true;
            allowItemSizeChangeNotification = false;
            if (direction == TileBaseDirection.VERTICAL)
            {
                _local_9 = ((maxRows > 0) ? maxRows : int(Math.max(Math.floor((listContent.heightExcludingOffsets / rowHeight)), 1)));
                _local_10 = int(Math.max(Math.ceil((listContent.widthExcludingOffsets / columnWidth)), 1));
                setRowCount(_local_9);
                setColumnCount(_local_10);
                _local_11 = _arg_5;
                _local_13 = _arg_1;
                _local_25 = (_local_11 - 1);
                _local_20 = (((!(iterator == null)) && (!(iterator.afterLast))) && (iteratorValid));
                while ((((_arg_7) && (_arg_8--)) || ((!(_arg_7)) && (_local_11 < (_local_10 + _arg_5)))))
                {
                    _local_12 = _arg_6;
                    _local_14 = _arg_2;
                    while (_local_12 < _local_9)
                    {
                        _local_21 = _local_20;
                        _local_15 = ((_local_20) ? iterator.current : null);
                        _local_16 = ((_local_15 is ItemWrapper) ? _local_15.data : _local_15);
                        _local_20 = moveNextSafely(_local_20);
                        if (!listItems[_local_12])
                        {
                            listItems[_local_12] = [];
                        };
                        if (((_local_21) && (_local_14 < _arg_4)))
                        {
                            _local_17 = itemToUID(_local_15);
                            rowInfo[_local_12] = new ListRowInfo(_local_14, rowHeight, _local_17);
                            _local_19 = getPreparedItemRenderer(_local_12, _local_11, _local_15, _local_16, _local_17);
                            placeAndDrawItemRenderer(_local_19, _local_13, _local_14, _local_17);
                            _local_25 = Math.max(_local_11, _local_25);
                        }
                        else
                        {
                            _local_18 = listItems[_local_12][_local_11];
                            if (_local_18)
                            {
                                addToFreeItemRenderers(_local_18);
                                listItems[_local_12][_local_11] = null;
                            };
                            rowInfo[_local_12] = new ListRowInfo(_local_14, rowHeight, _local_17);
                        };
                        _local_14 = (_local_14 + rowHeight);
                        _local_12++;
                    };
                    _local_11++;
                    if (_arg_6)
                    {
                        _local_22 = 0;
                        while (_local_22 < _arg_6)
                        {
                            _local_20 = moveNextSafely(_local_20);
                            _local_22++;
                        };
                    };
                    _local_13 = (_local_13 + columnWidth);
                };
            }
            else
            {
                _local_10 = ((maxColumns > 0) ? maxColumns : int(Math.max(Math.floor((listContent.widthExcludingOffsets / columnWidth)), 1)));
                _local_9 = int(Math.max(Math.ceil((listContent.heightExcludingOffsets / rowHeight)), 1));
                setColumnCount(_local_10);
                setRowCount(_local_9);
                _local_12 = _arg_6;
                _local_14 = _arg_2;
                _local_20 = (((!(iterator == null)) && (!(iterator.afterLast))) && (iteratorValid));
                _local_24 = (_local_12 - 1);
                while ((((_arg_7) && (_arg_8--)) || ((!(_arg_7)) && (_local_12 < (_local_9 + _arg_6)))))
                {
                    _local_11 = _arg_5;
                    _local_13 = _arg_1;
                    rowInfo[_local_12] = null;
                    while (_local_11 < _local_10)
                    {
                        _local_21 = _local_20;
                        _local_15 = ((_local_20) ? iterator.current : null);
                        _local_16 = ((_local_15 is ItemWrapper) ? _local_15.data : _local_15);
                        _local_20 = moveNextSafely(_local_20);
                        if (!listItems[_local_12])
                        {
                            listItems[_local_12] = [];
                        };
                        if (((_local_21) && (_local_13 < _arg_3)))
                        {
                            _local_17 = itemToUID(_local_15);
                            if (!rowInfo[_local_12])
                            {
                                rowInfo[_local_12] = new ListRowInfo(_local_14, rowHeight, _local_17);
                            };
                            _local_19 = getPreparedItemRenderer(_local_12, _local_11, _local_15, _local_16, _local_17);
                            placeAndDrawItemRenderer(_local_19, _local_13, _local_14, _local_17);
                            _local_24 = _local_12;
                        }
                        else
                        {
                            if (!rowInfo[_local_12])
                            {
                                rowInfo[_local_12] = new ListRowInfo(_local_14, rowHeight, _local_17);
                            };
                            _local_18 = listItems[_local_12][_local_11];
                            if (_local_18)
                            {
                                addToFreeItemRenderers(_local_18);
                                listItems[_local_12][_local_11] = null;
                            };
                        };
                        _local_13 = (_local_13 + columnWidth);
                        _local_11++;
                    };
                    _local_12++;
                    if (_arg_5)
                    {
                        _local_22 = 0;
                        while (_local_22 < _arg_5)
                        {
                            _local_20 = moveNextSafely(_local_20);
                            _local_22++;
                        };
                    };
                    _local_14 = (_local_14 + rowHeight);
                };
            };
            if (!_arg_7)
            {
                while (listItems.length > (_local_9 + offscreenExtraRowsTop))
                {
                    _local_29 = listItems.pop();
                    rowInfo.pop();
                    _local_22 = 0;
                    while (_local_22 < _local_29.length)
                    {
                        _local_18 = _local_29[_local_22];
                        if (_local_18)
                        {
                            addToFreeItemRenderers(_local_18);
                        };
                        _local_22++;
                    };
                };
                if (((listItems.length) && (listItems[0].length > (_local_10 + offscreenExtraColumnsLeft))))
                {
                    _local_22 = 0;
                    while (_local_22 < (_local_9 + offscreenExtraRowsTop))
                    {
                        _local_29 = listItems[_local_22];
                        while (_local_29.length > (_local_10 + offscreenExtraColumnsLeft))
                        {
                            _local_18 = _local_29.pop();
                            if (_local_18)
                            {
                                addToFreeItemRenderers(_local_18);
                            };
                        };
                        _local_22++;
                    };
                };
            };
            allowItemSizeChangeNotification = true;
            invalidateSizeFlag = false;
            return (new Point(((_local_25 - _arg_5) + 1), ((_local_24 - _arg_6) + 1)));
        }

        private function lastColumnInRow(_arg_1:int):int
        {
            var _local_2:int = ((maxRows > 0) ? maxRows : rowCount);
            var _local_3:int = int(Math.floor(((collection.length - 1) / _local_2)));
            if (indicesToIndex(_arg_1, _local_3) >= collection.length)
            {
                _local_3--;
            };
            return (_local_3);
        }

        override protected function get dragImageOffsets():Point
        {
            var _local_4:String;
            var _local_1:Point = new Point(0x2000, 0x2000);
            var _local_2:Boolean;
            var _local_3:int = listItems.length;
            for (_local_4 in visibleData)
            {
                if (selectedData[_local_4])
                {
                    _local_1.x = Math.min(_local_1.x, visibleData[_local_4].x);
                    _local_1.y = Math.min(_local_1.y, visibleData[_local_4].y);
                    _local_2 = true;
                };
            };
            if (_local_2)
            {
                return (_local_1);
            };
            return (new Point(0, 0));
        }

        public function get maxColumns():int
        {
            return (_maxColumns);
        }

        public function set maxRows(_arg_1:int):void
        {
            if (_maxRows != _arg_1)
            {
                _maxRows = _arg_1;
                invalidateSize();
                invalidateDisplayList();
            };
        }

        public function get maxRows():int
        {
            return (_maxRows);
        }

        private function moveNextSafely(more:Boolean):Boolean
        {
            if (((iterator) && (more)))
            {
                try
                {
                    more = iterator.moveNext();
                }
                catch(e1:ItemPendingError)
                {
                    lastSeekPending = new ListBaseSeekPending(CursorBookmark.CURRENT, 0);
                    e1.addResponder(new ItemResponder(seekPendingResultHandler, seekPendingFailureHandler, lastSeekPending));
                    more = false;
                    iteratorValid = false;
                };
            };
            return (more);
        }

        private function lastRowInColumn(_arg_1:int):int
        {
            var _local_2:int = ((maxColumns > 0) ? maxColumns : columnCount);
            var _local_3:int = int(Math.floor(((collection.length - 1) / _local_2)));
            if ((_arg_1 * _local_3) > collection.length)
            {
                _local_3--;
            };
            return (_local_3);
        }

        protected function drawTileBackground(_arg_1:Sprite, _arg_2:int, _arg_3:int, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):DisplayObject
        {
            var _local_9:Shape;
            var _local_8:int = ((_arg_2 * columnCount) + _arg_3);
            if (_local_8 < _arg_1.numChildren)
            {
                _local_9 = Shape(_arg_1.getChildAt(_local_8));
            }
            else
            {
                _local_9 = new FlexShape();
                _local_9.name = "tileBackground";
                _arg_1.addChild(_local_9);
            };
            var _local_10:Graphics = _local_9.graphics;
            _local_10.clear();
            _local_10.beginFill(_arg_6, getStyle("backgroundAlpha"));
            _local_10.drawRect(0, 0, _arg_4, _arg_5);
            _local_10.endFill();
            return (_local_9);
        }

        override public function calculateDropIndex(_arg_1:DragEvent=null):int
        {
            var _local_2:IListItemRenderer;
            var _local_3:Point;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            if (_arg_1)
            {
                _local_3 = new Point(_arg_1.localX, _arg_1.localY);
                _local_3 = DisplayObject(_arg_1.target).localToGlobal(_local_3);
                _local_3 = listContent.globalToLocal(_local_3);
                _local_4 = listItems.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    if (((rowInfo[_local_5].y <= _local_3.y) && (_local_3.y < (rowInfo[_local_5].y + rowInfo[_local_5].height))))
                    {
                        _local_6 = listItems[_local_5].length;
                        _local_7 = 0;
                        while (_local_7 < _local_6)
                        {
                            if ((((listItems[_local_5][_local_7]) && (listItems[_local_5][_local_7].x <= _local_3.x)) && (_local_3.x < (listItems[_local_5][_local_7].x + listItems[_local_5][_local_7].width))))
                            {
                                _local_2 = listItems[_local_5][_local_7];
                                if (!DisplayObject(_local_2).visible)
                                {
                                    _local_2 = null;
                                };
                                break;
                            };
                            _local_7++;
                        };
                        break;
                    };
                    _local_5++;
                };
                if (_local_2)
                {
                    lastDropIndex = itemRendererToIndex(_local_2);
                }
                else
                {
                    lastDropIndex = ((collection) ? collection.length : 0);
                };
            };
            return (lastDropIndex);
        }

        override public function set itemRenderer(_arg_1:IFactory):void
        {
            super.itemRenderer = _arg_1;
            purgeMeasuringRenderers();
        }

        mx_internal function setupRendererFromData(_arg_1:IListItemRenderer, _arg_2:Object):void
        {
            var _local_3:ListData = ListData(makeListData(_arg_2, itemToUID(_arg_2), 0, 0));
            if ((_arg_1 is IDropInListItemRenderer))
            {
                IDropInListItemRenderer(_arg_1).listData = ((_arg_2) ? _local_3 : null);
            };
            _arg_1.data = _arg_2;
            UIComponentGlobals.layoutManager.validateClient(_arg_1, true);
        }

        protected function makeListData(_arg_1:Object, _arg_2:String, _arg_3:int, _arg_4:int):BaseListData
        {
            return (new ListData(itemToLabel(_arg_1), itemToIcon(_arg_1), labelField, _arg_2, this, _arg_3, _arg_4));
        }

        override public function indicesToIndex(_arg_1:int, _arg_2:int):int
        {
            var _local_4:int;
            if (direction == TileBaseDirection.VERTICAL)
            {
                _local_4 = ((maxRows > 0) ? maxRows : rowCount);
                return ((_arg_2 * _local_4) + _arg_1);
            };
            var _local_3:int = ((maxColumns > 0) ? maxColumns : columnCount);
            return ((_arg_1 * _local_3) + _arg_2);
        }

        override protected function adjustListContent(_arg_1:Number=-1, _arg_2:Number=-1):void
        {
            var _local_3:Boolean;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_8:int;
            var _local_9:int;
            super.adjustListContent(_arg_1, _arg_2);
            if (!collection)
            {
                return;
            };
            var _local_7:int = collection.length;
            if (direction == TileBaseDirection.VERTICAL)
            {
                _local_5 = ((maxRows > 0) ? maxRows : int(Math.max(Math.floor((listContent.heightExcludingOffsets / rowHeight)), 1)));
                _local_6 = int(Math.max(Math.ceil((listContent.widthExcludingOffsets / columnWidth)), 1));
                if (_local_5 != lastRowCount)
                {
                    _local_3 = (!((listContent.widthExcludingOffsets / columnWidth) == Math.ceil((listContent.widthExcludingOffsets / columnWidth))));
                    _local_8 = Math.max((Math.ceil((_local_7 / _local_5)) - _local_6), 0);
                    if (_local_3)
                    {
                        _local_8++;
                    };
                    if (horizontalScrollPosition > _local_8)
                    {
                        $horizontalScrollPosition = _local_8;
                    };
                    setRowCount(_local_5);
                    setColumnCount(_local_6);
                    _local_4 = scrollPositionToIndex(Math.max(0, (horizontalScrollPosition - offscreenExtraColumnsLeft)), verticalScrollPosition);
                    seekPositionSafely(_local_4);
                };
                lastRowCount = _local_5;
            }
            else
            {
                _local_6 = ((maxColumns > 0) ? maxColumns : int(Math.max(Math.floor((listContent.widthExcludingOffsets / columnWidth)), 1)));
                _local_5 = int(Math.max(Math.ceil((listContent.heightExcludingOffsets / rowHeight)), 1));
                if (_local_6 != lastColumnCount)
                {
                    _local_3 = (!((listContent.heightExcludingOffsets / rowHeight) == Math.ceil((listContent.heightExcludingOffsets / rowHeight))));
                    _local_9 = Math.max((Math.ceil((_local_7 / _local_6)) - _local_5), 0);
                    if (_local_3)
                    {
                        _local_9++;
                    };
                    if (verticalScrollPosition > _local_9)
                    {
                        $verticalScrollPosition = _local_9;
                    };
                    setRowCount(_local_5);
                    setColumnCount(_local_6);
                    _local_4 = scrollPositionToIndex(horizontalScrollPosition, Math.max(0, (verticalScrollPosition - offscreenExtraRowsTop)));
                    seekPositionSafely(_local_4);
                };
                lastColumnCount = _local_6;
            };
        }

        override protected function collectionChangeHandler(_arg_1:Event):void
        {
            var _local_2:CollectionEvent;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            if ((_arg_1 is CollectionEvent))
            {
                _local_2 = CollectionEvent(_arg_1);
                if (((_local_2.location == 0) || (_local_2.kind == CollectionEventKind.REFRESH)))
                {
                    itemsNeedMeasurement = true;
                    invalidateProperties();
                };
                if (_local_2.kind == CollectionEventKind.REMOVE)
                {
                    _local_3 = indicesToIndex(verticalScrollPosition, horizontalScrollPosition);
                    if (_local_2.location < _local_3)
                    {
                        _local_3 = (_local_3 - _local_2.items.length);
                        super.collectionChangeHandler(_arg_1);
                        _local_4 = 0;
                        _local_5 = 0;
                        if (direction == TileBaseDirection.HORIZONTAL)
                        {
                            super.verticalScrollPosition = indexToRow(_local_3);
                            _local_4 = int(Math.min((offscreenExtraRows / 2), verticalScrollPosition));
                        }
                        else
                        {
                            super.horizontalScrollPosition = indexToColumn(_local_3);
                            _local_5 = int(Math.min((offscreenExtraColumns / 2), horizontalScrollPosition));
                        };
                        _local_6 = scrollPositionToIndex((horizontalScrollPosition - _local_5), (verticalScrollPosition - _local_4));
                        seekPositionSafely(_local_6);
                        return;
                    };
                };
            };
            super.collectionChangeHandler(_arg_1);
        }


    }
}//package mx.controls.listClasses

