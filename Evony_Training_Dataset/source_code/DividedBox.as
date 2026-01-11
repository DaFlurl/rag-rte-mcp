// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.DividedBox

package mx.containers
{
    import mx.containers.dividedBoxClasses.BoxDivider;
    import mx.core.UIComponent;
    import mx.events.ChildExistenceChangedEvent;
    import mx.styles.StyleManager;
    import flash.events.Event;
    import mx.core.IFlexDisplayObject;
    import mx.managers.CursorManager;
    import mx.core.EdgeMetrics;
    import mx.core.IUIComponent;
    import mx.events.DividerEvent;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import mx.managers.CursorManagerPriority;
    import flash.geom.Point;
    import mx.core.IInvalidating;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DividedBox extends Box 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static const PROXY_DIVIDER_INDEX:int = 999;
        private static var classInitialized:Boolean = false;

        private var postLayoutChanges:Array;
        private var minDelta:Number;
        private var layoutStyleChanged:Boolean = false;
        private var dbPreferredHeight:Number;
        private var dbMinWidth:Number;
        private var maxDelta:Number;
        private var activeDividerStartPosition:Number;
        mx_internal var activeDivider:BoxDivider;
        private var dbMinHeight:Number;
        private var dividerLayer:UIComponent = null;
        private var dragStartPosition:Number;
        public var liveDragging:Boolean = false;
        private var oldChildSizes:Array;
        protected var dividerClass:Class = BoxDivider;
        private var dbPreferredWidth:Number;
        private var dragDelta:Number;
        private var activeDividerIndex:int = -1;
        private var _resizeToContent:Boolean = false;
        private var numLayoutChildren:int = 0;
        private var cursorID:int = 0;
        private var dontCoalesceDividers:Boolean;

        public function DividedBox()
        {
            if (!classInitialized)
            {
                initializeClass();
                classInitialized = true;
            };
            addEventListener(ChildExistenceChangedEvent.CHILD_ADD, childAddHandler);
            addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);
            showInAutomationHierarchy = true;
        }

        private static function initializeClass():void
        {
            StyleManager.registerSizeInvalidatingStyle("dividerAffordance");
            StyleManager.registerSizeInvalidatingStyle("dividerThickness");
        }


        public function set resizeToContent(_arg_1:Boolean):void
        {
            if (_arg_1 != _resizeToContent)
            {
                _resizeToContent = _arg_1;
                if (_arg_1)
                {
                    invalidateSize();
                };
            };
        }

        private function child_includeInLayoutChangedHandler(_arg_1:Event):void
        {
            var _local_2:UIComponent = UIComponent(_arg_1.target);
            if (((_local_2.includeInLayout) && (++numLayoutChildren > 1)))
            {
                createDivider((numLayoutChildren - 2));
            }
            else
            {
                if (((!(_local_2.includeInLayout)) && (--numLayoutChildren > 0)))
                {
                    dividerLayer.removeChild(getDividerAt((numLayoutChildren - 1)));
                };
            };
            dbMinWidth = NaN;
            dbMinHeight = NaN;
            dbPreferredWidth = NaN;
            dbPreferredHeight = NaN;
            invalidateSize();
        }

        private function createDivider(_arg_1:int):BoxDivider
        {
            if (!dividerLayer)
            {
                dividerLayer = UIComponent(rawChildren.addChild(new UIComponent()));
            };
            var _local_2:BoxDivider = BoxDivider(new dividerClass());
            dividerLayer.addChild(_local_2);
            if (_arg_1 == PROXY_DIVIDER_INDEX)
            {
                rawChildren.setChildIndex(dividerLayer, (rawChildren.numChildren - 1));
            };
            var _local_3:IFlexDisplayObject = ((_arg_1 == PROXY_DIVIDER_INDEX) ? getDividerAt(activeDividerIndex) : this);
            _local_2.styleName = _local_3;
            _local_2.owner = this;
            return (_local_2);
        }

        public function moveDivider(_arg_1:int, _arg_2:Number):void
        {
            if (((_arg_1 < 0) || (_arg_1 >= numDividers)))
            {
                return;
            };
            if (activeDividerIndex >= 0)
            {
                return;
            };
            activeDividerIndex = _arg_1;
            cacheChildSizes();
            computeMinAndMaxDelta();
            dragDelta = limitDelta(_arg_2);
            adjustChildSizes();
            invalidateSize();
            invalidateDisplayList();
            resetDividerTracking();
        }

        mx_internal function restoreCursor():void
        {
            if (cursorID != CursorManager.NO_CURSOR)
            {
                cursorManager.removeCursor(cursorID);
                cursorID = CursorManager.NO_CURSOR;
            };
        }

        private function layoutDivider(_arg_1:int, _arg_2:Number, _arg_3:Number, _arg_4:IUIComponent, _arg_5:IUIComponent):void
        {
            var _local_12:Number;
            var _local_13:Number;
            var _local_6:BoxDivider = BoxDivider(getDividerAt(_arg_1));
            var _local_7:EdgeMetrics = viewMetrics;
            var _local_8:Number = getStyle("verticalGap");
            var _local_9:Number = getStyle("horizontalGap");
            var _local_10:Number = _local_6.getStyle("dividerThickness");
            var _local_11:Number = _local_6.getStyle("dividerAffordance");
            if (isVertical())
            {
                _local_12 = _local_11;
                if (_local_12 < _local_10)
                {
                    _local_12 = _local_10;
                };
                if (_local_12 > _local_8)
                {
                    _local_12 = _local_8;
                };
                _local_6.setActualSize(((_arg_2 - _local_7.left) - _local_7.right), _local_12);
                _local_6.move(_local_7.left, Math.round(((((_arg_4.y + _arg_4.height) + _arg_5.y) - _local_12) / 2)));
            }
            else
            {
                _local_13 = _local_11;
                if (_local_13 < _local_10)
                {
                    _local_13 = _local_10;
                };
                if (_local_13 > _local_9)
                {
                    _local_13 = _local_9;
                };
                _local_6.setActualSize(_local_13, ((_arg_3 - _local_7.top) - _local_7.bottom));
                _local_6.move(Math.round(((((_arg_4.x + _arg_4.width) + _arg_5.x) - _local_13) / 2)), _local_7.top);
            };
            _local_6.invalidateDisplayList();
        }

        private function computeMinAndMaxDelta():void
        {
            computeAllowableMovement(activeDividerIndex);
        }

        mx_internal function stopDividerDrag(_arg_1:BoxDivider, _arg_2:MouseEvent):void
        {
            if (_arg_2)
            {
                dragDelta = limitDelta((getMousePosition(_arg_2) - dragStartPosition));
            };
            var _local_3:DividerEvent = new DividerEvent(DividerEvent.DIVIDER_RELEASE);
            _local_3.dividerIndex = activeDividerIndex;
            _local_3.delta = dragDelta;
            dispatchEvent(_local_3);
            if (!liveDragging)
            {
                if (dragDelta == 0)
                {
                    getDividerAt(activeDividerIndex).state = DividerState.OVER;
                };
                if (activeDivider)
                {
                    dividerLayer.removeChild(activeDivider);
                };
                activeDivider = null;
                adjustChildSizes();
                invalidateSize();
                invalidateDisplayList();
            };
            resetDividerTracking();
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            systemManager.deployMouseShields(false);
        }

        private function postLayoutAdjustment():void
        {
            var _local_3:Object;
            var _local_1:int = postLayoutChanges.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = postLayoutChanges[_local_2];
                if (_local_3.percentWidth !== undefined)
                {
                    _local_3.child.percentWidth = _local_3.percentWidth;
                };
                if (_local_3.percentHeight !== undefined)
                {
                    _local_3.child.percentHeight = _local_3.percentHeight;
                };
                if (_local_3.explicitWidth !== undefined)
                {
                    _local_3.child.explicitWidth = _local_3.explicitWidth;
                };
                if (_local_3.explicitHeight !== undefined)
                {
                    _local_3.child.explicitHeight = _local_3.explicitHeight;
                };
                _local_2++;
            };
            postLayoutChanges = null;
        }

        public function get numDividers():int
        {
            if (dividerLayer)
            {
                if (((!(liveDragging)) && (activeDivider)))
                {
                    return (dividerLayer.numChildren - 1);
                };
                return (dividerLayer.numChildren);
            };
            return (0);
        }

        private function resetDividerTracking():void
        {
            activeDivider = null;
            activeDividerIndex = -1;
            activeDividerStartPosition = NaN;
            dragStartPosition = NaN;
            dragDelta = NaN;
            oldChildSizes = null;
            minDelta = NaN;
            maxDelta = NaN;
        }

        private function childAddHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            var _local_2:DisplayObject = _arg_1.relatedObject;
            _local_2.addEventListener("includeInLayoutChanged", child_includeInLayoutChangedHandler);
            if (!IUIComponent(_local_2).includeInLayout)
            {
                return;
            };
            numLayoutChildren++;
            if (numLayoutChildren > 1)
            {
                createDivider((numLayoutChildren - 2));
            };
            dbMinWidth = NaN;
            dbMinHeight = NaN;
            dbPreferredWidth = NaN;
            dbPreferredHeight = NaN;
        }

        mx_internal function changeCursor(_arg_1:BoxDivider):void
        {
            var _local_2:Class;
            if (cursorID == CursorManager.NO_CURSOR)
            {
                _local_2 = ((isVertical()) ? (getStyle("verticalDividerCursor") as Class) : (getStyle("horizontalDividerCursor") as Class));
                cursorID = cursorManager.setCursor(_local_2, CursorManagerPriority.HIGH, 0, 0);
            };
        }

        private function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            dragDelta = limitDelta((getMousePosition(_arg_1) - dragStartPosition));
            var _local_2:DividerEvent = new DividerEvent(DividerEvent.DIVIDER_DRAG);
            _local_2.dividerIndex = activeDividerIndex;
            _local_2.delta = dragDelta;
            dispatchEvent(_local_2);
            if (liveDragging)
            {
                adjustChildSizes();
                invalidateDisplayList();
                updateDisplayList(unscaledWidth, unscaledHeight);
            }
            else
            {
                if (isVertical())
                {
                    activeDivider.move(0, (activeDividerStartPosition + dragDelta));
                }
                else
                {
                    activeDivider.move((activeDividerStartPosition + dragDelta), 0);
                };
            };
        }

        public function get resizeToContent():Boolean
        {
            return (_resizeToContent);
        }

        mx_internal function startDividerDrag(_arg_1:BoxDivider, _arg_2:MouseEvent):void
        {
            if (activeDividerIndex >= 0)
            {
                return;
            };
            activeDividerIndex = getDividerIndex(_arg_1);
            var _local_3:DividerEvent = new DividerEvent(DividerEvent.DIVIDER_PRESS);
            _local_3.dividerIndex = activeDividerIndex;
            dispatchEvent(_local_3);
            if (liveDragging)
            {
                activeDivider = _arg_1;
            }
            else
            {
                activeDivider = createDivider(PROXY_DIVIDER_INDEX);
                activeDivider.visible = false;
                activeDivider.state = DividerState.DOWN;
                activeDivider.setActualSize(_arg_1.width, _arg_1.height);
                activeDivider.move(_arg_1.x, _arg_1.y);
                activeDivider.visible = true;
                _arg_1.state = DividerState.UP;
            };
            if (isVertical())
            {
                activeDividerStartPosition = activeDivider.y;
            }
            else
            {
                activeDividerStartPosition = activeDivider.x;
            };
            dragStartPosition = getMousePosition(_arg_2);
            dragDelta = 0;
            cacheChildSizes();
            adjustChildSizes();
            computeMinAndMaxDelta();
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            systemManager.deployMouseShields(true);
        }

        mx_internal function getDividerIndex(_arg_1:BoxDivider):int
        {
            var _local_2:int = numChildren;
            var _local_3:int;
            while (_local_3 < (_local_2 - 1))
            {
                if (getDividerAt(_local_3) == _arg_1)
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (-1);
        }

        private function cacheSizes():void
        {
            var _local_5:IUIComponent;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            oldChildSizes = [];
            var _local_1:Boolean = isVertical();
            var _local_2:Number = Number.MAX_VALUE;
            var _local_3:int = numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = IUIComponent(getChildAt(_local_4));
                if (_local_5.includeInLayout)
                {
                    _local_6 = ((_local_1) ? _local_5.height : _local_5.width);
                    _local_7 = ((_local_1) ? _local_5.maxHeight : _local_5.maxWidth);
                    _local_8 = ((_local_1) ? _local_5.explicitMinHeight : _local_5.explicitMinWidth);
                    _local_9 = ((isNaN(_local_8)) ? 0 : _local_8);
                    _local_10 = Math.max(0, (_local_6 - _local_9));
                    _local_11 = Math.max(0, (_local_7 - _local_6));
                    if (((_local_6 > 0) && (_local_6 < _local_2)))
                    {
                        _local_2 = _local_6;
                    };
                    oldChildSizes.push(new ChildSizeInfo(_local_6, _local_9, _local_7, _local_10, _local_11));
                };
                _local_4++;
            };
            oldChildSizes.push(new ChildSizeInfo(((_local_2 == Number.MAX_VALUE) ? 1 : _local_2)));
        }

        private function limitDelta(_arg_1:Number):Number
        {
            if (_arg_1 < minDelta)
            {
                _arg_1 = minDelta;
            }
            else
            {
                if (_arg_1 > maxDelta)
                {
                    _arg_1 = maxDelta;
                };
            };
            return (Math.round(_arg_1));
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:int;
            super.styleChanged(_arg_1);
            if (dividerLayer)
            {
                _local_2 = dividerLayer.numChildren;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    getDividerAt(_local_3).styleChanged(_arg_1);
                    _local_3++;
                };
            };
            if (StyleManager.isSizeInvalidatingStyle(_arg_1))
            {
                layoutStyleChanged = true;
            };
        }

        private function getMousePosition(_arg_1:MouseEvent):Number
        {
            var _local_2:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            _local_2 = globalToLocal(_local_2);
            return ((isVertical()) ? _local_2.y : _local_2.x);
        }

        private function adjustChildSizes():void
        {
            distributeDelta();
        }

        override protected function measure():void
        {
            var _local_10:IUIComponent;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Boolean;
            var _local_16:Boolean;
            var _local_17:Number;
            var _local_18:Number;
            super.measure();
            if ((((!(isNaN(dbPreferredWidth))) && (!(_resizeToContent))) && (!(layoutStyleChanged))))
            {
                measuredMinWidth = dbMinWidth;
                measuredMinHeight = dbMinHeight;
                measuredWidth = dbPreferredWidth;
                measuredHeight = dbPreferredHeight;
                return;
            };
            layoutStyleChanged = false;
            var _local_1:Boolean = this.isVertical();
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:Number = 0;
            var _local_6:int = numChildren;
            var _local_7:int;
            while (_local_7 < _local_6)
            {
                _local_10 = IUIComponent(getChildAt(_local_7));
                if (_local_10.includeInLayout)
                {
                    _local_11 = _local_10.getExplicitOrMeasuredWidth();
                    _local_12 = _local_10.getExplicitOrMeasuredHeight();
                    _local_13 = _local_10.minWidth;
                    _local_14 = _local_10.minHeight;
                    _local_15 = (!(isNaN(_local_10.percentWidth)));
                    _local_16 = (!(isNaN(_local_10.percentHeight)));
                    _local_17 = Math.min(_local_11, _local_13);
                    _local_18 = Math.min(_local_12, _local_14);
                    if (_local_1)
                    {
                        _local_2 = Math.max(((_local_15) ? _local_13 : _local_11), _local_2);
                        _local_4 = Math.max(_local_11, _local_4);
                        _local_3 = (_local_3 + ((_local_16) ? _local_18 : _local_12));
                        _local_5 = (_local_5 + _local_12);
                    }
                    else
                    {
                        _local_2 = (_local_2 + ((_local_15) ? _local_17 : _local_11));
                        _local_4 = (_local_4 + _local_11);
                        _local_3 = Math.max(((_local_16) ? _local_14 : _local_12), _local_3);
                        _local_5 = Math.max(_local_12, _local_5);
                    };
                };
                _local_7++;
            };
            var _local_8:Number = layoutObject.widthPadding(numLayoutChildren);
            var _local_9:Number = layoutObject.heightPadding(numLayoutChildren);
            measuredMinWidth = (dbMinWidth = (_local_2 + _local_8));
            measuredMinHeight = (dbMinHeight = (_local_3 + _local_9));
            measuredWidth = (dbPreferredWidth = (_local_4 + _local_8));
            measuredHeight = (dbPreferredHeight = (_local_5 + _local_9));
        }

        private function childRemoveHandler(_arg_1:ChildExistenceChangedEvent):void
        {
            var _local_2:DisplayObject = _arg_1.relatedObject;
            _local_2.removeEventListener("includeInLayoutChanged", child_includeInLayoutChangedHandler);
            if (!IUIComponent(_local_2).includeInLayout)
            {
                return;
            };
            numLayoutChildren--;
            if (numLayoutChildren > 0)
            {
                dividerLayer.removeChild(getDividerAt((numLayoutChildren - 1)));
            };
            dbMinWidth = NaN;
            dbMinHeight = NaN;
            dbPreferredWidth = NaN;
            dbPreferredHeight = NaN;
            invalidateSize();
        }

        override protected function scrollChildren():void
        {
            super.scrollChildren();
            if (((contentPane) && (dividerLayer)))
            {
                dividerLayer.scrollRect = contentPane.scrollRect;
            };
        }

        public function getDividerAt(_arg_1:int):BoxDivider
        {
            return (BoxDivider(dividerLayer.getChildAt(_arg_1)));
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_8:IUIComponent;
            if (((!(liveDragging)) && (activeDivider)))
            {
                _local_3 = numChildren;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_8 = IUIComponent(getChildAt(_local_4));
                    if (_local_8.includeInLayout)
                    {
                        _local_8.measuredMinWidth = 0;
                        _local_8.measuredMinHeight = 0;
                    };
                    _local_4++;
                };
                return;
            };
            preLayoutAdjustment();
            super.updateDisplayList(_arg_1, _arg_2);
            postLayoutAdjustment();
            if (!dividerLayer)
            {
                return;
            };
            var _local_5:EdgeMetrics = viewMetrics;
            dividerLayer.x = _local_5.left;
            dividerLayer.y = _local_5.top;
            var _local_6:IUIComponent;
            var _local_7:int;
            _local_3 = numChildren;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_8 = UIComponent(getChildAt(_local_4));
                if (_local_8.includeInLayout)
                {
                    if (_local_6)
                    {
                        layoutDivider(_local_7, _arg_1, _arg_2, _local_6, _local_8);
                        _local_7++;
                    };
                    _local_6 = _local_8;
                };
                _local_4++;
            };
        }

        private function cacheChildSizes():void
        {
            oldChildSizes = [];
            cacheSizes();
        }

        private function distributeDelta():void
        {
            var _local_5:int;
            var _local_6:ChildSizeInfo;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:IUIComponent;
            var _local_10:Number;
            if (!dragDelta)
            {
                return;
            };
            var _local_1:Boolean = isVertical();
            var _local_2:int = numLayoutChildren;
            var _local_3:int = activeDividerIndex;
            var _local_4:Number = (oldChildSizes[_local_2].size - Math.abs(dragDelta));
            if (((_local_4 <= 0) || (isNaN(_local_4))))
            {
                _local_4 = 1;
            };
            var _local_11:int = -1;
            var _local_12:int = -1;
            while (_local_12 < activeDividerIndex)
            {
                if (UIComponent(getChildAt(++_local_11)).includeInLayout)
                {
                    _local_12++;
                };
            };
            var _local_13:int = _local_11;
            var _local_14:Number = dragDelta;
            _local_5 = _local_3;
            while (_local_5 >= 0)
            {
                _local_6 = ChildSizeInfo(oldChildSizes[_local_5]);
                _local_7 = ((_local_14 < 0) ? -(Math.min(-(_local_14), _local_6.deltaMin)) : Math.min(_local_14, _local_6.deltaMax));
                _local_8 = (_local_6.size + _local_7);
                _local_14 = (_local_14 - _local_7);
                do 
                {
                    _local_9 = IUIComponent(getChildAt(_local_13--));
                } while ((!(_local_9.includeInLayout)));
                _local_10 = ((_local_8 / _local_4) * 100);
                if (_local_1)
                {
                    _local_9.percentHeight = _local_10;
                }
                else
                {
                    _local_9.percentWidth = _local_10;
                };
                if ((_local_9 is IInvalidating))
                {
                    IInvalidating(_local_9).invalidateSize();
                };
                _local_5--;
            };
            _local_13 = (_local_11 + 1);
            _local_14 = dragDelta;
            _local_5 = (_local_3 + 1);
            while (_local_5 < _local_2)
            {
                _local_6 = ChildSizeInfo(oldChildSizes[_local_5]);
                _local_7 = ((_local_14 < 0) ? Math.min(-(_local_14), _local_6.deltaMax) : -(Math.min(_local_14, _local_6.deltaMin)));
                _local_8 = (_local_6.size + _local_7);
                _local_14 = (_local_14 + _local_7);
                do 
                {
                    _local_9 = IUIComponent(getChildAt(_local_13++));
                } while ((!(_local_9.includeInLayout)));
                _local_10 = ((_local_8 / _local_4) * 100);
                if (_local_1)
                {
                    _local_9.percentHeight = _local_10;
                }
                else
                {
                    _local_9.percentWidth = _local_10;
                };
                if ((_local_9 is IInvalidating))
                {
                    IInvalidating(_local_9).invalidateSize();
                };
                _local_5++;
            };
        }

        private function preLayoutAdjustment():void
        {
            var _local_5:int;
            var _local_6:IUIComponent;
            var _local_7:Number;
            var _local_8:Object;
            var _local_9:Number;
            var _local_1:Boolean = isVertical();
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:int = numChildren;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = IUIComponent(getChildAt(_local_5));
                if (_local_6.includeInLayout)
                {
                    _local_6.measuredMinWidth = 0;
                    _local_6.measuredMinHeight = 0;
                    _local_7 = ((_local_1) ? _local_6.percentHeight : _local_6.percentWidth);
                    if (!isNaN(_local_7))
                    {
                        _local_2 = (_local_2 + _local_7);
                        _local_3++;
                    };
                };
                _local_5++;
            };
            postLayoutChanges = [];
            if (((_local_2 == 0) && (_local_3 == 0)))
            {
                _local_5 = (_local_4 - 1);
                while (_local_5 >= 0)
                {
                    _local_6 = UIComponent(getChildAt(_local_5));
                    if (_local_6.includeInLayout)
                    {
                        _local_8 = {"child":_local_6};
                        if (_local_1)
                        {
                            if (_local_6.explicitHeight)
                            {
                                _local_8.explicitHeight = _local_6.explicitHeight;
                            }
                            else
                            {
                                _local_8.percentHeight = NaN;
                            };
                            _local_6.percentHeight = 100;
                        }
                        else
                        {
                            if (_local_6.explicitWidth)
                            {
                                _local_8.explicitWidth = _local_6.explicitWidth;
                            }
                            else
                            {
                                if (_local_6.percentWidth)
                                {
                                    _local_8.percentWidth = NaN;
                                };
                            };
                            _local_6.percentWidth = 100;
                        };
                        postLayoutChanges.push(_local_8);
                        break;
                    };
                    _local_5--;
                };
            }
            else
            {
                if (_local_2 < 100)
                {
                    _local_9 = Math.ceil(((100 - _local_2) / _local_3));
                    _local_5 = 0;
                    while (_local_5 < _local_4)
                    {
                        _local_6 = IUIComponent(getChildAt(_local_5));
                        if (_local_6.includeInLayout)
                        {
                            _local_8 = {"child":_local_6};
                            if (_local_1)
                            {
                                _local_7 = _local_6.percentHeight;
                                if (!isNaN(_local_7))
                                {
                                    _local_8.percentHeight = _local_6.percentHeight;
                                    postLayoutChanges.push(_local_8);
                                    _local_6.percentHeight = ((_local_7 + _local_9) * unscaledHeight);
                                };
                            }
                            else
                            {
                                _local_7 = _local_6.percentWidth;
                                if (!isNaN(_local_7))
                                {
                                    _local_8.percentWidth = _local_6.percentWidth;
                                    postLayoutChanges.push(_local_8);
                                    _local_6.percentWidth = ((_local_7 + _local_9) * unscaledWidth);
                                };
                            };
                        };
                        _local_5++;
                    };
                };
            };
        }

        private function computeAllowableMovement(_arg_1:int):void
        {
            var _local_7:int;
            var _local_8:ChildSizeInfo;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:Number = 0;
            var _local_6:int = numLayoutChildren;
            if (_arg_1 < 0)
            {
                return;
            };
            _local_7 = _arg_1;
            while (_local_7 >= 0)
            {
                _local_8 = ChildSizeInfo(oldChildSizes[_local_7]);
                _local_2 = (_local_2 + (((dontCoalesceDividers) && (_local_2)) ? 0 : _local_8.deltaMin));
                _local_3 = (_local_3 + (((dontCoalesceDividers) && (_local_3)) ? 0 : _local_8.deltaMax));
                _local_7--;
            };
            _local_7 = (_arg_1 + 1);
            while (_local_7 < _local_6)
            {
                _local_8 = ChildSizeInfo(oldChildSizes[_local_7]);
                _local_4 = (_local_4 + (((dontCoalesceDividers) && (_local_4)) ? 0 : _local_8.deltaMin));
                _local_5 = (_local_5 + (((dontCoalesceDividers) && (_local_5)) ? 0 : _local_8.deltaMax));
                _local_7++;
            };
            var _local_9:Number = Math.min(_local_2, _local_5);
            var _local_10:Number = Math.min(_local_4, _local_3);
            minDelta = -(_local_9);
            maxDelta = _local_10;
        }

        override public function set direction(_arg_1:String):void
        {
            var _local_2:int;
            if (super.direction != _arg_1)
            {
                super.direction = _arg_1;
                if (dividerLayer)
                {
                    _local_2 = 0;
                    while (_local_2 < dividerLayer.numChildren)
                    {
                        getDividerAt(_local_2).invalidateDisplayList();
                        _local_2++;
                    };
                };
            };
        }


    }
}//package mx.containers

class ChildSizeInfo 
{

    public var size:Number;
    public var min:Number;
    public var max:Number;
    public var deltaMin:Number;
    public var deltaMax:Number;

    public function ChildSizeInfo(_arg_1:Number, _arg_2:Number=0, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0)
    {
        this.size = _arg_1;
        this.min = _arg_2;
        this.max = _arg_3;
        this.deltaMin = _arg_4;
        this.deltaMax = _arg_5;
    }

}


