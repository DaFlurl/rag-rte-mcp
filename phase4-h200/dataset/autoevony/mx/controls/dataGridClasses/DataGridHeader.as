// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridHeader

package mx.controls.dataGridClasses
{
    import mx.controls.listClasses.IListItemRenderer;
    import mx.controls.DataGrid;
    import mx.core.IFlexDisplayObject;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import mx.events.DataGridEvent;
    import flash.display.Sprite;
    import mx.core.UIComponent;
    import flash.geom.Rectangle;
    import mx.styles.ISimpleStyleClient;
    import mx.core.UIComponentGlobals;
    import flash.display.Graphics;
    import mx.events.SandboxMouseEvent;
    import flash.events.Event;
    import mx.core.EdgeMetrics;
    import flash.display.Shape;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.core.FlexSprite;
    import mx.skins.halo.DataGridColumnDropIndicator;
    import mx.managers.CursorManagerPriority;
    import mx.core.FlexVersion;
    import mx.styles.StyleManager;
    import flash.geom.Matrix;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridHeader extends DataGridHeaderBase 
    {

        private var headerBGSkinChanged:Boolean = false;
        private var lastItemDown:IListItemRenderer;
        protected var dataGrid:DataGrid;
        private var resizeGraphic:IFlexDisplayObject;
        protected var cachedPaddingBottom:Number = 0;
        private var headerSepSkinChanged:Boolean = false;
        mx_internal var columnDropIndicator:IFlexDisplayObject;
        private var separators:Array;
        protected var headerItems:Array = [];
        private var startX:Number;
        mx_internal var sortArrow:IFlexDisplayObject;
        private var dropColumnIndex:int = -1;
        private var allowItemSizeChangeNotification:Boolean = true;
        public var bottomOffset:Number = 0;
        private var lastPt:Point;
        private var resizeCursorID:int = 0;
        protected var cachedPaddingTop:Number = 0;
        public var topOffset:Number = 0;
        private var minX:Number;
        public var rightOffset:Number = 0;
        protected var cachedHeaderHeight:Number = 0;
        public var needRightSeparatorEvents:Boolean = false;
        public var needRightSeparator:Boolean = false;
        private var separatorAffordance:Number = 3;
        public var leftOffset:Number = 0;

        public function DataGridHeader()
        {
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            if (sortArrow)
            {
                removeChild(DisplayObject(sortArrow));
                sortArrow = null;
                placeSortArrow();
            };
        }

        protected function mouseUpHandler(_arg_1:MouseEvent):void
        {
            var _local_2:DataGridEvent;
            var _local_3:IListItemRenderer;
            var _local_4:Sprite;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Point;
            _local_4 = Sprite(getChildByName("sortArrowHitArea"));
            if (_arg_1.target == _local_4)
            {
                _local_5 = visibleColumns.length;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    if (visibleColumns[_local_6].colNum == dataGrid.sortIndex)
                    {
                        _local_3 = headerItems[_local_6];
                        break;
                    };
                    _local_6++;
                };
            }
            else
            {
                _local_6 = 0;
                while (_local_6 < separators.length)
                {
                    if (((_arg_1.target == separators[_local_6]) && (visibleColumns[_local_6].resizable)))
                    {
                        return;
                    };
                    _local_6++;
                };
                _local_7 = new Point(_arg_1.stageX, _arg_1.stageY);
                _local_7 = globalToLocal(_local_7);
                _local_6 = 0;
                while (_local_6 < headerItems.length)
                {
                    if ((headerItems[_local_6].x + headerItems[_local_6].width) >= _local_7.x)
                    {
                        _local_3 = headerItems[_local_6];
                        break;
                    };
                    _local_6++;
                };
                if (_local_6 >= headerItems.length)
                {
                    return;
                };
            };
            if (((((dataGrid.enabled) && ((dataGrid.sortableColumns) || (dataGrid.draggableColumns))) && (dataGrid.dataProvider)) && (dataGrid.headerVisible)))
            {
                if (_local_3 == lastItemDown)
                {
                    if (((dataGrid.sortableColumns) && (visibleColumns[_local_6].sortable)))
                    {
                        lastItemDown = null;
                        _local_2 = new DataGridEvent(DataGridEvent.HEADER_RELEASE, false, true);
                        _local_2.columnIndex = visibleColumns[_local_6].colNum;
                        _local_2.dataField = visibleColumns[_local_6].dataField;
                        _local_2.itemRenderer = _local_3;
                        dataGrid.dispatchEvent(_local_2);
                    };
                };
            };
        }

        protected function drawSeparators():void
        {
            var _local_4:UIComponent;
            var _local_5:IFlexDisplayObject;
            var _local_6:Array;
            var _local_7:Class;
            if (!separators)
            {
                separators = [];
            };
            var _local_1:UIComponent = UIComponent(getChildByName("lines"));
            if (!_local_1)
            {
                _local_1 = new UIComponent();
                _local_1.name = "lines";
                addChild(_local_1);
            }
            else
            {
                setChildIndex(_local_1, (numChildren - 1));
            };
            _local_1.scrollRect = new Rectangle(0, 0, unscaledWidth, (unscaledHeight + 1));
            if (headerSepSkinChanged)
            {
                headerSepSkinChanged = false;
                clearSeparators();
            };
            var _local_2:int = ((visibleColumns) ? visibleColumns.length : 0);
            if (((!(needRightSeparator)) && (_local_2 > 0)))
            {
                _local_2--;
            };
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (_local_3 < _local_1.numChildren)
                {
                    _local_4 = UIComponent(_local_1.getChildAt(_local_3));
                    _local_5 = IFlexDisplayObject(_local_4.getChildAt(0));
                }
                else
                {
                    _local_7 = getStyle("headerSeparatorSkin");
                    _local_5 = new (_local_7)();
                    if ((_local_5 is ISimpleStyleClient))
                    {
                        ISimpleStyleClient(_local_5).styleName = this;
                    };
                    _local_4 = new UIComponent();
                    _local_4.addChild(DisplayObject(_local_5));
                    _local_1.addChild(_local_4);
                    UIComponentGlobals.layoutManager.validateClient(_local_4, true);
                    separators.push(_local_4);
                };
                if (!((_local_3 == (visibleColumns.length - 1)) && (!(needRightSeparatorEvents))))
                {
                    DisplayObject(_local_4).addEventListener(MouseEvent.MOUSE_OVER, columnResizeMouseOverHandler);
                    DisplayObject(_local_4).addEventListener(MouseEvent.MOUSE_OUT, columnResizeMouseOutHandler);
                    DisplayObject(_local_4).addEventListener(MouseEvent.MOUSE_DOWN, columnResizeMouseDownHandler);
                }
                else
                {
                    if (((_local_3 == (visibleColumns.length - 1)) && (!(needRightSeparatorEvents))))
                    {
                        DisplayObject(_local_4).removeEventListener(MouseEvent.MOUSE_OVER, columnResizeMouseOverHandler);
                        DisplayObject(_local_4).removeEventListener(MouseEvent.MOUSE_OUT, columnResizeMouseOutHandler);
                        DisplayObject(_local_4).removeEventListener(MouseEvent.MOUSE_DOWN, columnResizeMouseDownHandler);
                    };
                };
                _local_6 = visibleColumns;
                if (!(((_local_6) && (_local_6.length > 0)) || (dataGrid.headerVisible)))
                {
                    _local_4.visible = false;
                }
                else
                {
                    _local_4.visible = true;
                    _local_4.x = ((headerItems[_local_3].x + visibleColumns[_local_3].width) - Math.round((_local_5.measuredWidth / 2)));
                    if (_local_3 > 0)
                    {
                        _local_4.x = Math.max(_local_4.x, (separators[(_local_3 - 1)].x + Math.round((_local_5.measuredWidth / 2))));
                    };
                    _local_4.y = 0;
                    _local_5.setActualSize(_local_5.measuredWidth, Math.ceil(cachedHeaderHeight));
                    _local_4.graphics.clear();
                    _local_4.graphics.beginFill(0xFFFFFF, 0);
                    _local_4.graphics.drawRect(-(separatorAffordance), 0, (_local_5.measuredWidth + separatorAffordance), cachedHeaderHeight);
                    _local_4.graphics.endFill();
                    _local_4.mouseEnabled = true;
                };
                _local_3++;
            };
            while (_local_1.numChildren > _local_2)
            {
                _local_1.removeChildAt((_local_1.numChildren - 1));
                separators.pop();
            };
            UIComponentGlobals.layoutManager.validateClient(_local_1, true);
        }

        private function columnResizeMouseOutHandler(_arg_1:MouseEvent):void
        {
            if (((!(enabled)) || (!(dataGrid.resizableColumns))))
            {
                return;
            };
            var _local_2:DisplayObject = DisplayObject(_arg_1.target);
            var _local_3:int = _local_2.parent.getChildIndex(_local_2);
            if (!visibleColumns[_local_3].resizable)
            {
                return;
            };
            cursorManager.removeCursor(resizeCursorID);
        }

        override protected function createChildren():void
        {
            dataGrid = (parent as DataGrid);
            selectionLayer = new UIComponent();
            addChild(selectionLayer);
        }

        mx_internal function _clearSeparators():void
        {
            clearSeparators();
        }

        protected function drawHeaderIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:Graphics = _arg_1.graphics;
            _local_8.clear();
            _local_8.beginFill(_arg_6);
            _local_8.drawRect(0, 0, _arg_4, _arg_5);
            _local_8.endFill();
            _arg_1.x = _arg_2;
            _arg_1.y = _arg_3;
        }

        protected function mouseOutHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Point;
            var _local_6:Sprite;
            if (((resizeGraphic) || (dataGrid.movingColumn)))
            {
                return;
            };
            if ((((dataGrid.enabled) && (dataGrid.sortableColumns)) && (dataGrid.headerVisible)))
            {
                _local_6 = Sprite(getChildByName("sortArrowHitArea"));
                if (_arg_1.target == _local_6)
                {
                    _local_4 = visibleColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_4)
                    {
                        if (visibleColumns[_local_3].colNum == dataGrid.sortIndex)
                        {
                            _local_2 = headerItems[_local_3];
                            break;
                        };
                        _local_3++;
                    };
                    if (_local_3 >= visibleColumns.length)
                    {
                        return;
                    };
                }
                else
                {
                    _local_3 = 0;
                    while (_local_3 < separators.length)
                    {
                        if (((_arg_1.target == separators[_local_3]) && (visibleColumns[_local_3].resizable)))
                        {
                            return;
                        };
                        _local_3++;
                    };
                    _local_5 = new Point(_arg_1.stageX, _arg_1.stageY);
                    _local_5 = globalToLocal(_local_5);
                    _local_3 = 0;
                    while (_local_3 < headerItems.length)
                    {
                        if ((headerItems[_local_3].x + headerItems[_local_3].width) >= _local_5.x)
                        {
                            _local_2 = headerItems[_local_3];
                            break;
                        };
                        _local_3++;
                    };
                    if (_local_3 >= headerItems.length)
                    {
                        _local_3 = (headerItems.length - 1);
                    };
                };
                if (((visibleColumns.length > 0) && (visibleColumns[_local_3].sortable)))
                {
                    _local_6 = Sprite(selectionLayer.getChildByName("headerSelection"));
                    if (_local_6)
                    {
                        selectionLayer.removeChild(_local_6);
                    };
                };
            };
            if (_arg_1.buttonDown)
            {
                lastItemDown = _local_2;
            }
            else
            {
                lastItemDown = null;
            };
        }

        private function drawHeaderBackgroundSkin(_arg_1:IFlexDisplayObject):void
        {
            _arg_1.setActualSize(unscaledWidth, Math.ceil(cachedHeaderHeight));
        }

        mx_internal function getSeparators():Array
        {
            return (separators);
        }

        private function get resizingColumn():DataGridColumn
        {
            return (dataGrid.resizingColumn);
        }

        private function columnResizeMouseDownHandler(_arg_1:MouseEvent):void
        {
            if (((!(enabled)) || (!(dataGrid.resizableColumns))))
            {
                return;
            };
            var _local_2:DisplayObject = DisplayObject(_arg_1.target);
            var _local_3:int = _local_2.parent.getChildIndex(_local_2);
            if (!visibleColumns[_local_3].resizable)
            {
                return;
            };
            startX = (DisplayObject(_arg_1.target).x + x);
            lastPt = new Point(_arg_1.stageX, _arg_1.stageY);
            lastPt = dataGrid.globalToLocal(lastPt);
            var _local_4:int = separators.length;
            var _local_5:int;
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                if (separators[_local_6] == _arg_1.target)
                {
                    resizingColumn = visibleColumns[_local_6];
                    _local_5 = _local_6;
                }
                else
                {
                    separators[_local_6].mouseEnabled = false;
                };
                _local_6++;
            };
            if (!resizingColumn)
            {
                return;
            };
            minX = ((headerItems[_local_5].x + x) + resizingColumn.minWidth);
            var _local_7:DisplayObject = systemManager.getSandboxRoot();
            _local_7.addEventListener(MouseEvent.MOUSE_MOVE, columnResizingHandler, true);
            _local_7.addEventListener(MouseEvent.MOUSE_UP, columnResizeMouseUpHandler, true);
            _local_7.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, columnResizeMouseUpHandler);
            systemManager.deployMouseShields(true);
            var _local_8:Class = getStyle("columnResizeSkin");
            resizeGraphic = new (_local_8)();
            if ((resizeGraphic is Sprite))
            {
                Sprite(resizeGraphic).mouseEnabled = false;
            };
            dataGrid.addChild(DisplayObject(resizeGraphic));
            resizeGraphic.move((DisplayObject(_arg_1.target).x + x), 0);
            resizeGraphic.setActualSize(resizeGraphic.measuredWidth, (dataGrid.height / dataGrid.scaleY));
        }

        private function columnDraggingMouseUpHandler(_arg_1:Event):void
        {
            if (!dataGrid.movingColumn)
            {
                return;
            };
            var _local_2:int = dataGrid.movingColumn.colNum;
            var _local_3:Array = dataGrid.getAllVisibleColumns();
            if (dropColumnIndex >= 0)
            {
                if (dropColumnIndex >= _local_3.length)
                {
                    dropColumnIndex = (_local_3.length - 1);
                }
                else
                {
                    if (_local_2 < _local_3[dropColumnIndex].colNum)
                    {
                        dropColumnIndex--;
                    };
                };
                dropColumnIndex = _local_3[dropColumnIndex].colNum;
            };
            dataGrid.shiftColumns(_local_2, dropColumnIndex, (_arg_1 as MouseEvent));
            var _local_4:DisplayObject = systemManager.getSandboxRoot();
            _local_4.removeEventListener(MouseEvent.MOUSE_MOVE, columnDraggingMouseMoveHandler, true);
            _local_4.removeEventListener(MouseEvent.MOUSE_UP, columnDraggingMouseUpHandler, true);
            _local_4.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, columnDraggingMouseUpHandler);
            systemManager.deployMouseShields(false);
            var _local_5:Sprite = Sprite(dataGrid.getChildByName("columnDragSelectionLayer"));
            if (!_local_5)
            {
                startX = NaN;
                dataGrid.movingColumn = null;
                dropColumnIndex = -1;
                return;
            };
            var _local_6:IListItemRenderer = IListItemRenderer(getChildByName("headerDragProxy"));
            if (_local_6)
            {
                _local_5.removeChild(DisplayObject(_local_6));
            };
            var _local_7:Sprite = Sprite(_local_5.getChildByName("headerSelection"));
            if (_local_7)
            {
                _local_5.removeChild(_local_7);
            };
            if (columnDropIndicator)
            {
                columnDropIndicator.visible = false;
            };
            _local_7 = Sprite(dataGrid.getChildByName("columnDragOverlay"));
            if (_local_7)
            {
                dataGrid.removeChild(_local_7);
            };
            dataGrid.removeChild(_local_5);
            startX = NaN;
            dataGrid.movingColumn = null;
            dropColumnIndex = -1;
            invalidateDisplayList();
        }

        mx_internal function _drawSeparators():void
        {
            drawSeparators();
        }

        private function columnDraggingMouseMoveHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_4:Sprite;
            var _local_7:Sprite;
            var _local_12:Number;
            var _local_13:EdgeMetrics;
            var _local_14:IListItemRenderer;
            var _local_15:DataGridListData;
            var _local_16:Class;
            var _local_17:Shape;
            if (!_arg_1.buttonDown)
            {
                columnDraggingMouseUpHandler(_arg_1);
                return;
            };
            var _local_3:DataGridColumn = dataGrid.movingColumn;
            var _local_5:int;
            var _local_6:int = headerItems.length;
            if (isNaN(startX))
            {
                startX = _arg_1.stageX;
                lastItemDown = null;
                _local_13 = dataGrid.viewMetrics;
                _local_7 = new UIComponent();
                _local_7.name = "columnDragSelectionLayer";
                _local_7.alpha = 0.6;
                dataGrid.addChild(_local_7);
                _local_7.x = _local_13.left;
                _local_7.y = _local_13.top;
                _local_14 = dataGrid.createColumnItemRenderer(_local_3, true, _local_3);
                _local_14.name = "headerDragProxy";
                _local_15 = new DataGridListData(((_local_3.headerText != null) ? _local_3.headerText : _local_3.dataField), _local_3.dataField, _local_3.colNum, uid, dataGrid, 0);
                if ((_local_14 is IDropInListItemRenderer))
                {
                    IDropInListItemRenderer(_local_14).listData = _local_15;
                };
                _local_7.addChild(DisplayObject(_local_14));
                _local_14.data = _local_3;
                _local_14.styleName = getStyle("headerDragProxyStyleName");
                UIComponentGlobals.layoutManager.validateClient(_local_14, true);
                _local_14.setActualSize(_local_3.width, ((dataGrid._explicitHeaderHeight) ? dataGrid.headerHeight : _local_14.getExplicitOrMeasuredHeight()));
                _local_5 = 0;
                while (_local_5 < _local_6)
                {
                    _local_2 = headerItems[_local_5];
                    if (_local_2.data == dataGrid.movingColumn) break;
                    _local_5++;
                };
                _local_14.move((_local_2.x + x), _local_2.y);
                _local_4 = new FlexSprite();
                _local_4.name = "columnDragOverlay";
                _local_4.alpha = 0.6;
                dataGrid.addChild(_local_4);
                if (_local_3.width > 0)
                {
                    drawColumnDragOverlay(_local_4, (_local_2.x + x), 0, _local_3.width, (((dataGrid.height / dataGrid.scaleY) - _local_13.bottom) - _local_4.y), getStyle("disabledColor"), _local_2);
                };
                _local_4 = Sprite(selectionLayer.getChildByName("headerSelection"));
                if (_local_4)
                {
                    _local_4.width = dataGrid.movingColumn.width;
                    _local_7.addChild(_local_4);
                    _local_4.x = (_local_4.x + x);
                };
                _local_7.scrollRect = new Rectangle(0, 0, (dataGrid.width / dataGrid.scaleX), unscaledHeight);
                return;
            };
            var _local_8:Number = (_arg_1.stageX - startX);
            _local_7 = Sprite(dataGrid.getChildByName("columnDragSelectionLayer"));
            _local_4 = Sprite(_local_7.getChildByName("headerSelection"));
            if (_local_4)
            {
                _local_4.x = (_local_4.x + _local_8);
            };
            _local_2 = IListItemRenderer(_local_7.getChildByName("headerDragProxy"));
            if (_local_2)
            {
                _local_2.move((_local_2.x + _local_8), _local_2.y);
            };
            startX = (startX + _local_8);
            var _local_9:Array = dataGrid.getAllVisibleColumns();
            var _local_10:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            _local_10 = dataGrid.globalToLocal(_local_10);
            lastPt = _local_10;
            _local_6 = _local_9.length;
            var _local_11:Number = dataGrid.viewMetrics.left;
            _local_5 = 0;
            while (_local_5 < _local_6)
            {
                _local_12 = _local_9[_local_5].width;
                if (_local_10.x < (_local_11 + _local_12))
                {
                    if (_local_10.x > (_local_11 + (_local_12 / 2)))
                    {
                        _local_5++;
                        _local_11 = (_local_11 + _local_12);
                    };
                    if (dropColumnIndex != _local_5)
                    {
                        dropColumnIndex = _local_5;
                        if (!columnDropIndicator)
                        {
                            _local_16 = getStyle("columnDropIndicatorSkin");
                            if (!_local_16)
                            {
                                _local_16 = DataGridColumnDropIndicator;
                            };
                            columnDropIndicator = IFlexDisplayObject(new (_local_16)());
                            if ((columnDropIndicator is ISimpleStyleClient))
                            {
                                ISimpleStyleClient(columnDropIndicator).styleName = this;
                            };
                            dataGrid.addChild(DisplayObject(columnDropIndicator));
                            _local_17 = new Shape();
                            _local_17.graphics.beginFill(0xFFFFFF);
                            _local_17.graphics.drawRect(0, 0, 10, 10);
                            _local_17.graphics.endFill();
                            dataGrid.addChild(_local_17);
                            columnDropIndicator.mask = _local_17;
                        };
                        dataGrid.setChildIndex(DisplayObject(columnDropIndicator), (dataGrid.numChildren - 1));
                        columnDropIndicator.visible = true;
                        _local_17 = (columnDropIndicator.mask as Shape);
                        _local_17.x = dataGrid.viewMetrics.left;
                        _local_17.y = dataGrid.viewMetrics.top;
                        _local_17.width = (((dataGrid.width / dataGrid.scaleX) - _local_17.x) - dataGrid.viewMetrics.right);
                        _local_17.height = (((dataGrid.height / dataGrid.scaleY) - _local_17.x) - dataGrid.viewMetrics.bottom);
                        columnDropIndicator.x = (_local_11 - columnDropIndicator.width);
                        columnDropIndicator.y = 0;
                        columnDropIndicator.setActualSize(3, (dataGrid.height / dataGrid.scaleY));
                    };
                    return;
                };
                _local_11 = (_local_11 + _local_12);
                _local_5++;
            };
        }

        private function columnResizeMouseOverHandler(_arg_1:MouseEvent):void
        {
            if (((!(enabled)) || (!(dataGrid.resizableColumns))))
            {
                return;
            };
            var _local_2:DisplayObject = DisplayObject(_arg_1.target);
            var _local_3:int = _local_2.parent.getChildIndex(_local_2);
            if (!visibleColumns[_local_3].resizable)
            {
                return;
            };
            var _local_4:Class = getStyle("stretchCursor");
            resizeCursorID = cursorManager.setCursor(_local_4, CursorManagerPriority.HIGH, 0, 0);
        }

        override public function styleChanged(_arg_1:String):void
        {
            super.styleChanged(_arg_1);
            if (_arg_1 == "headerBackgroundSkin")
            {
                headerBGSkinChanged = true;
            }
            else
            {
                if (_arg_1 == "headerSeparatorSkin")
                {
                    headerSepSkinChanged = true;
                };
            };
        }

        protected function placeSortArrow():void
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_4:int;
            var _local_8:Class;
            var _local_9:Graphics;
            var _local_10:int;
            var _local_1:Sprite = Sprite(getChildByName("sortArrowHitArea"));
            if (((dataGrid.sortIndex == -1) && (dataGrid.lastSortIndex == -1)))
            {
                if (sortArrow)
                {
                    sortArrow.visible = false;
                };
                if (_local_1)
                {
                    _local_1.visible = false;
                };
                return;
            };
            if (!dataGrid.headerVisible)
            {
                if (sortArrow)
                {
                    sortArrow.visible = false;
                };
                if (_local_1)
                {
                    _local_1.visible = false;
                };
                return;
            };
            if (!sortArrow)
            {
                _local_8 = getStyle("sortArrowSkin");
                sortArrow = new (_local_8)();
                DisplayObject(sortArrow).name = ((enabled) ? "sortArrow" : "sortArrowDisabled");
                if ((sortArrow is ISimpleStyleClient))
                {
                    ISimpleStyleClient(sortArrow).styleName = this;
                };
                addChild(DisplayObject(sortArrow));
            };
            var _local_5:Boolean;
            if (((headerItems) && (headerItems.length)))
            {
                _local_3 = headerItems.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    if (visibleColumns[_local_4].colNum == dataGrid.sortIndex)
                    {
                        _local_2 = (headerItems[_local_4].x + visibleColumns[_local_4].width);
                        headerItems[_local_4].setActualSize(((visibleColumns[_local_4].width - sortArrow.measuredWidth) - 8), headerItems[_local_4].height);
                        if (!isNaN(headerItems[_local_4].explicitWidth))
                        {
                            headerItems[_local_4].explicitWidth = headerItems[_local_4].width;
                        };
                        UIComponentGlobals.layoutManager.validateClient(headerItems[_local_4], true);
                        if (!_local_1)
                        {
                            _local_1 = new FlexSprite();
                            _local_1.name = "sortArrowHitArea";
                            addChild(_local_1);
                        }
                        else
                        {
                            _local_1.visible = true;
                        };
                        _local_1.x = (headerItems[_local_4].x + headerItems[_local_4].width);
                        _local_1.y = headerItems[_local_4].y;
                        _local_9 = _local_1.graphics;
                        _local_9.clear();
                        _local_9.beginFill(0, 0);
                        _local_9.drawRect(0, 0, (sortArrow.measuredWidth + 8), headerItems[_local_4].height);
                        _local_9.endFill();
                        _local_5 = true;
                        break;
                    };
                    _local_4++;
                };
            };
            if (isNaN(_local_2))
            {
                sortArrow.visible = false;
            }
            else
            {
                sortArrow.visible = true;
            };
            if ((((visibleColumns.length) && (dataGrid.lastSortIndex >= 0)) && (!(dataGrid.lastSortIndex == dataGrid.sortIndex))))
            {
                if (((visibleColumns[0].colNum <= dataGrid.lastSortIndex) && (dataGrid.lastSortIndex <= visibleColumns[(visibleColumns.length - 1)].colNum)))
                {
                    _local_3 = headerItems.length;
                    _local_10 = 0;
                    while (_local_10 < _local_3)
                    {
                        if (visibleColumns[_local_10].colNum == dataGrid.lastSortIndex)
                        {
                            headerItems[_local_10].setActualSize(visibleColumns[_local_10].width, headerItems[_local_10].height);
                            UIComponentGlobals.layoutManager.validateClient(headerItems[_local_10], true);
                            break;
                        };
                        _local_10++;
                    };
                };
            };
            var _local_6:* = (dataGrid.sortDirection == "ASC");
            sortArrow.width = sortArrow.measuredWidth;
            sortArrow.height = sortArrow.measuredHeight;
            DisplayObject(sortArrow).scaleY = ((_local_6) ? -1 : 1);
            sortArrow.x = ((_local_2 - sortArrow.measuredWidth) - 8);
            var _local_7:Number = cachedHeaderHeight;
            sortArrow.y = (((_local_7 - sortArrow.measuredHeight) / 2) + ((_local_6) ? sortArrow.measuredHeight : 0));
            if (((_local_5) && (sortArrow.x < headerItems[_local_4].x)))
            {
                sortArrow.visible = false;
            };
            if (((!(sortArrow.visible)) && (_local_1)))
            {
                _local_1.visible = false;
            };
        }

        protected function drawSelectionIndicator(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:Graphics = _arg_1.graphics;
            _local_8.clear();
            _local_8.beginFill(_arg_6);
            _local_8.drawRect(0, 0, _arg_4, _arg_5);
            _local_8.endFill();
            _arg_1.x = _arg_2;
            _arg_1.y = _arg_3;
        }

        private function set resizingColumn(_arg_1:DataGridColumn):void
        {
            dataGrid.resizingColumn = _arg_1;
        }

        override mx_internal function clearSelectionLayer():void
        {
            while (selectionLayer.numChildren > 0)
            {
                selectionLayer.removeChildAt(0);
            };
        }

        private function columnResizeMouseUpHandler(_arg_1:Event):void
        {
            var _local_6:Point;
            if (((!(enabled)) || (!(dataGrid.resizableColumns))))
            {
                return;
            };
            lastItemDown = null;
            var _local_2:DisplayObject = systemManager.getSandboxRoot();
            _local_2.removeEventListener(MouseEvent.MOUSE_MOVE, columnResizingHandler, true);
            _local_2.removeEventListener(MouseEvent.MOUSE_UP, columnResizeMouseUpHandler, true);
            _local_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, columnResizeMouseUpHandler);
            systemManager.deployMouseShields(false);
            dataGrid.removeChild(DisplayObject(resizeGraphic));
            resizeGraphic = null;
            cursorManager.removeCursor(resizeCursorID);
            var _local_3:DataGridColumn = resizingColumn;
            resizingColumn = null;
            var _local_4:int = ((dataGrid.vScrollBar) ? dataGrid.vScrollBar.width : 0);
            var _local_5:MouseEvent = (_arg_1 as MouseEvent);
            if (_local_5)
            {
                _local_6 = new Point(_local_5.stageX, _local_5.stageY);
                _local_6 = dataGrid.globalToLocal(_local_6);
            }
            else
            {
                _local_6 = lastPt;
            };
            var _local_7:Number = (Math.min(Math.max(minX, _local_6.x), (((dataGrid.width / dataGrid.scaleX) - separators[0].width) - _local_4)) - startX);
            dataGrid.resizeColumn(_local_3.colNum, Math.floor((_local_3.width + _local_7)));
            invalidateDisplayList();
            var _local_8:DataGridEvent = new DataGridEvent(DataGridEvent.COLUMN_STRETCH);
            _local_8.columnIndex = _local_3.colNum;
            _local_8.dataField = _local_3.dataField;
            _local_8.localX = _local_6.x;
            dataGrid.dispatchEvent(_local_8);
        }

        protected function clearSeparators():void
        {
            if (!separators)
            {
                return;
            };
            var _local_1:Sprite = Sprite(getChildByName("lines"));
            while (_local_1.numChildren)
            {
                _local_1.removeChildAt((_local_1.numChildren - 1));
                separators.pop();
            };
        }

        mx_internal function get rendererArray():Array
        {
            return (headerItems);
        }

        override protected function measure():void
        {
            super.measure();
            var _local_1:Number = dataGrid.calculateHeaderHeight();
            cachedHeaderHeight = ((dataGrid._explicitHeaderHeight) ? dataGrid.headerHeight : _local_1);
            cachedPaddingBottom = getStyle("paddingBottom");
            cachedPaddingTop = getStyle("paddingTop");
            measuredHeight = cachedHeaderHeight;
        }

        protected function drawColumnDragOverlay(_arg_1:Sprite, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:uint, _arg_7:IListItemRenderer):void
        {
            var _local_8:Graphics = _arg_1.graphics;
            _local_8.clear();
            _local_8.beginFill(_arg_6);
            _local_8.drawRect(0, 0, _arg_4, _arg_5);
            _local_8.endFill();
            _arg_1.x = _arg_2;
            _arg_1.y = _arg_3;
        }

        mx_internal function _placeSortArrow():void
        {
            placeSortArrow();
        }

        mx_internal function _drawHeaderBackground(_arg_1:UIComponent):void
        {
            drawHeaderBackground(_arg_1);
        }

        private function columnResizingHandler(_arg_1:MouseEvent):void
        {
            if (!MouseEvent(_arg_1).buttonDown)
            {
                columnResizeMouseUpHandler(_arg_1);
                return;
            };
            var _local_2:int = ((dataGrid.vScrollBar) ? dataGrid.vScrollBar.width : 0);
            var _local_3:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            _local_3 = dataGrid.globalToLocal(_local_3);
            lastPt = _local_3;
            resizeGraphic.move(Math.min(Math.max(minX, _local_3.x), (((dataGrid.width / dataGrid.scaleX) - separators[0].width) - _local_2)), 0);
        }

        override public function invalidateSize():void
        {
            if (allowItemSizeChangeNotification)
            {
                super.invalidateSize();
            };
        }

        protected function mouseOverHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Point;
            var _local_6:Sprite;
            if (((resizingColumn) || (dataGrid.movingColumn)))
            {
                return;
            };
            if ((((dataGrid.enabled) && (dataGrid.sortableColumns)) && (dataGrid.headerVisible)))
            {
                _local_6 = Sprite(getChildByName("sortArrowHitArea"));
                if (_arg_1.target == _local_6)
                {
                    _local_4 = visibleColumns.length;
                    _local_3 = 0;
                    while (_local_3 < _local_4)
                    {
                        if (visibleColumns[_local_3].colNum == dataGrid.sortIndex)
                        {
                            _local_2 = headerItems[_local_3];
                            break;
                        };
                        _local_3++;
                    };
                }
                else
                {
                    _local_3 = 0;
                    while (_local_3 < separators.length)
                    {
                        if (((_arg_1.target == separators[_local_3]) && (visibleColumns[_local_3].resizable)))
                        {
                            return;
                        };
                        _local_3++;
                    };
                    _local_5 = new Point(_arg_1.stageX, _arg_1.stageY);
                    _local_5 = globalToLocal(_local_5);
                    _local_3 = 0;
                    while (_local_3 < headerItems.length)
                    {
                        if ((headerItems[_local_3].x + headerItems[_local_3].width) >= _local_5.x)
                        {
                            _local_2 = headerItems[_local_3];
                            break;
                        };
                        _local_3++;
                    };
                    if (_local_3 >= headerItems.length)
                    {
                        return;
                    };
                };
                _local_6 = Sprite(getChildByName("sortArrowHitArea"));
                if (visibleColumns[_local_3].sortable)
                {
                    _local_6 = Sprite(selectionLayer.getChildByName("headerSelection"));
                    if (!_local_6)
                    {
                        _local_6 = new FlexSprite();
                        _local_6.name = "headerSelection";
                        _local_6.mouseEnabled = false;
                        selectionLayer.addChild(_local_6);
                    };
                    drawHeaderIndicator(_local_6, _local_2.x, 0, visibleColumns[_local_3].width, (cachedHeaderHeight - 0.5), getStyle("rollOverColor"), _local_2);
                };
            };
            if (_arg_1.buttonDown)
            {
                lastItemDown = _local_2;
            }
            else
            {
                lastItemDown = null;
            };
        }

        protected function mouseDownHandler(_arg_1:MouseEvent):void
        {
            var _local_2:IListItemRenderer;
            var _local_3:Sprite;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Point;
            var _local_7:DisplayObject;
            _local_3 = Sprite(getChildByName("sortArrowHitArea"));
            if (_arg_1.target == _local_3)
            {
                _local_5 = visibleColumns.length;
                _local_4 = 0;
                while (_local_4 < _local_5)
                {
                    if (visibleColumns[_local_4].colNum == dataGrid.sortIndex)
                    {
                        _local_2 = headerItems[_local_4];
                        break;
                    };
                    _local_4++;
                };
            }
            else
            {
                _local_4 = 0;
                while (_local_4 < separators.length)
                {
                    if (((_arg_1.target == separators[_local_4]) && (visibleColumns[_local_4].resizable)))
                    {
                        return;
                    };
                    _local_4++;
                };
                _local_6 = new Point(_arg_1.stageX, _arg_1.stageY);
                _local_6 = globalToLocal(_local_6);
                _local_4 = 0;
                while (_local_4 < headerItems.length)
                {
                    if ((headerItems[_local_4].x + headerItems[_local_4].width) >= _local_6.x)
                    {
                        _local_2 = headerItems[_local_4];
                        break;
                    };
                    _local_4++;
                };
                if (_local_4 >= headerItems.length)
                {
                    return;
                };
            };
            if ((((dataGrid.enabled) && ((dataGrid.sortableColumns) || (dataGrid.draggableColumns))) && (dataGrid.headerVisible)))
            {
                if (((dataGrid.sortableColumns) && (visibleColumns[_local_4].sortable)))
                {
                    lastItemDown = _local_2;
                    _local_3 = Sprite(selectionLayer.getChildByName("headerSelection"));
                    if (!_local_3)
                    {
                        _local_3 = new FlexSprite();
                        _local_3.name = "headerSelection";
                        selectionLayer.addChild(_local_3);
                    };
                    drawSelectionIndicator(_local_3, _local_2.x, 0, visibleColumns[_local_4].width, (cachedHeaderHeight - 0.5), getStyle("selectionColor"), _local_2);
                };
                if (((dataGrid.draggableColumns) && (visibleColumns[_local_4].draggable)))
                {
                    startX = NaN;
                    _local_7 = systemManager.getSandboxRoot();
                    _local_7.addEventListener(MouseEvent.MOUSE_MOVE, columnDraggingMouseMoveHandler, true);
                    _local_7.addEventListener(MouseEvent.MOUSE_UP, columnDraggingMouseUpHandler, true);
                    _local_7.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, columnDraggingMouseUpHandler);
                    systemManager.deployMouseShields(true);
                    dataGrid.movingColumn = visibleColumns[_local_4];
                };
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:int;
            var _local_11:DataGridListData;
            var _local_12:IListItemRenderer;
            var _local_13:IListItemRenderer;
            var _local_14:Object;
            var _local_15:String;
            var _local_16:DataGridColumn;
            var _local_17:Number;
            var _local_18:Array;
            var _local_19:int;
            var _local_20:Class;
            var _local_21:IFlexDisplayObject;
            allowItemSizeChangeNotification = false;
            var _local_3:Array = visibleColumns;
            if (((headerItemsChanged) && (((_local_3) && (_local_3.length > 0)) || (dataGrid.headerVisible))))
            {
                headerItemsChanged = false;
                _local_5 = 0;
                _local_6 = 0;
                _local_7 = 0;
                _local_8 = 0;
                _local_10 = 0;
                _local_17 = 0;
                _local_18 = headerItems.slice();
                while (((_local_3) && (_local_10 < _local_3.length)))
                {
                    _local_16 = _local_3[_local_10];
                    _local_12 = _local_16.cachedHeaderRenderer;
                    if (!_local_12)
                    {
                        _local_12 = dataGrid.createColumnItemRenderer(_local_16, true, _local_16);
                        _local_12.styleName = _local_16;
                        _local_16.cachedHeaderRenderer = _local_12;
                    };
                    _local_11 = new DataGridListData(((_local_16.headerText != null) ? _local_16.headerText : _local_16.dataField), _local_16.dataField, _local_10, _local_15, dataGrid, 0);
                    if ((_local_12 is IDropInListItemRenderer))
                    {
                        IDropInListItemRenderer(_local_12).listData = _local_11;
                    };
                    _local_12.data = _local_16;
                    _local_12.visible = true;
                    if (_local_12.parent != this)
                    {
                        addChild(DisplayObject(_local_12));
                    };
                    headerItems[_local_10] = _local_12;
                    _local_12.explicitWidth = (_local_8 = _local_16.width);
                    UIComponentGlobals.layoutManager.validateClient(_local_12, true);
                    _local_9 = _local_12.getExplicitOrMeasuredHeight();
                    _local_12.setActualSize(_local_8, ((dataGrid._explicitHeaderHeight) ? ((cachedHeaderHeight - cachedPaddingTop) - cachedPaddingBottom) : _local_9));
                    _local_12.move(_local_5, (_local_6 + cachedPaddingTop));
                    _local_5 = (_local_5 + _local_8);
                    _local_10++;
                    _local_7 = Math.ceil(Math.max(_local_7, ((dataGrid._explicitHeaderHeight) ? cachedHeaderHeight : ((_local_9 + cachedPaddingBottom) + cachedPaddingTop))));
                    _local_17 = Math.max(_local_17, ((dataGrid._explicitHeaderHeight) ? ((cachedHeaderHeight - cachedPaddingTop) - cachedPaddingBottom) : _local_9));
                };
                _local_19 = 0;
                while (_local_19 < headerItems.length)
                {
                    headerItems[_local_19].setActualSize(headerItems[_local_19].width, _local_17);
                    _local_19++;
                };
                _local_19 = 0;
                while (_local_19 < _local_18.length)
                {
                    _local_12 = _local_18[_local_19];
                    if (((_local_12) && (headerItems.indexOf(_local_12) == -1)))
                    {
                        if (_local_12.parent == this)
                        {
                            removeChild(DisplayObject(_local_12));
                        };
                    };
                    _local_19++;
                };
                while (headerItems.length > _local_10)
                {
                    _local_13 = headerItems.pop();
                    if (_local_13.parent == this)
                    {
                        if (headerItems.indexOf(_local_13) == -1)
                        {
                            removeChild(DisplayObject(_local_13));
                        };
                    };
                };
            };
            var _local_4:UIComponent = UIComponent(getChildByName("headerBG"));
            if (headerBGSkinChanged)
            {
                headerBGSkinChanged = false;
                if (_local_4)
                {
                    removeChild(_local_4);
                };
                _local_4 = null;
            };
            if (!_local_4)
            {
                _local_4 = new UIComponent();
                _local_4.name = "headerBG";
                addChildAt(DisplayObject(_local_4), 0);
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    _local_20 = getStyle("headerBackgroundSkin");
                    _local_21 = new (_local_20)();
                    if ((_local_21 is ISimpleStyleClient))
                    {
                        ISimpleStyleClient(_local_21).styleName = this;
                    };
                    _local_4.addChild(DisplayObject(_local_21));
                };
            };
            if (dataGrid.headerVisible)
            {
                _local_4.visible = true;
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    dataGrid._drawHeaderBackground(_local_4);
                }
                else
                {
                    drawHeaderBackgroundSkin(IFlexDisplayObject(_local_4.getChildAt(0)));
                };
                dataGrid._drawSeparators();
            }
            else
            {
                _local_4.visible = false;
                dataGrid._clearSeparators();
            };
            dataGrid._placeSortArrow();
            allowItemSizeChangeNotification = true;
        }

        protected function drawHeaderBackground(_arg_1:UIComponent):void
        {
            var _local_2:Number = width;
            var _local_3:Number = cachedHeaderHeight;
            var _local_4:Graphics = _arg_1.graphics;
            _local_4.clear();
            var _local_5:Array = getStyle("headerColors");
            StyleManager.getColorNames(_local_5);
            var _local_6:Matrix = new Matrix();
            _local_6.createGradientBox(_local_2, (_local_3 + 1), (Math.PI / 2), 0, 0);
            _local_5 = [_local_5[0], _local_5[0], _local_5[1]];
            var _local_7:Array = [0, 60, 0xFF];
            var _local_8:Array = [1, 1, 1];
            _local_4.beginGradientFill(GradientType.LINEAR, _local_5, _local_8, _local_7, _local_6);
            _local_4.lineStyle(0, 0, 0);
            _local_4.moveTo(0, 0);
            _local_4.lineTo(_local_2, 0);
            _local_4.lineTo(_local_2, (_local_3 - 0.5));
            _local_4.lineStyle(0, getStyle("borderColor"), 100);
            _local_4.lineTo(0, (_local_3 - 0.5));
            _local_4.lineStyle(0, 0, 0);
            _local_4.endFill();
        }


    }
}//package mx.controls.dataGridClasses

