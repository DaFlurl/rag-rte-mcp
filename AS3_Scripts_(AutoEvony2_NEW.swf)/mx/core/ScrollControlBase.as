// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ScrollControlBase

package mx.core
{
    import mx.controls.ToolTip;
    import flash.display.Shape;
    import mx.controls.scrollClasses.ScrollBar;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import mx.events.ScrollEvent;
    import mx.controls.HScrollBar;
    import flash.display.Graphics;
    import mx.controls.VScrollBar;
    import mx.styles.ISimpleStyleClient;
    import mx.events.ScrollEventDirection;
    import flash.geom.Point;
    import mx.events.ScrollEventDetail;
    import mx.managers.ToolTipManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ScrollControlBase extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var numberOfRows:Number = 0;
        private var _scrollTipFunction:Function;
        private var scrollTip:ToolTip;
        public var showScrollTips:Boolean = false;
        private var numberOfCols:Number = 0;
        protected var maskShape:Shape;
        private var oldTTMEnabled:Boolean;
        mx_internal var _maxHorizontalScrollPosition:Number;
        protected var border:IFlexDisplayObject;
        private var _viewMetrics:EdgeMetrics;
        mx_internal var _maxVerticalScrollPosition:Number;
        protected var verticalScrollBar:ScrollBar;
        mx_internal var _horizontalScrollPosition:Number = 0;
        private var propsInited:Boolean;
        protected var horizontalScrollBar:ScrollBar;
        mx_internal var _horizontalScrollPolicy:String = "off";
        mx_internal var _verticalScrollPosition:Number = 0;
        private var scrollThumbMidPoint:Number;
        mx_internal var _verticalScrollPolicy:String = "auto";
        protected var scrollAreaChanged:Boolean;
        private var viewableColumns:Number;
        public var liveScrolling:Boolean = true;
        private var viewableRows:Number;
        private var invLayout:Boolean;

        public function ScrollControlBase()
        {
            _viewMetrics = EdgeMetrics.EMPTY;
            addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            if (horizontalScrollBar)
            {
                horizontalScrollBar.enabled = _arg_1;
            };
            if (verticalScrollBar)
            {
                verticalScrollBar.enabled = _arg_1;
            };
        }

        [Bindable("scrollTipFunctionChanged")]
        public function get scrollTipFunction():Function
        {
            return (_scrollTipFunction);
        }

        public function set scrollTipFunction(_arg_1:Function):void
        {
            _scrollTipFunction = _arg_1;
            dispatchEvent(new Event("scrollTipFunctionChanged"));
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            layoutChrome(_arg_1, _arg_2);
            var _local_3:Number = _arg_1;
            var _local_4:Number = _arg_2;
            invLayout = false;
            var _local_5:EdgeMetrics = (_viewMetrics = viewMetrics);
            if (((horizontalScrollBar) && (horizontalScrollBar.visible)))
            {
                horizontalScrollBar.setActualSize(((_local_3 - _local_5.left) - _local_5.right), horizontalScrollBar.minHeight);
                horizontalScrollBar.move(_local_5.left, (_local_4 - _local_5.bottom));
                horizontalScrollBar.enabled = enabled;
            };
            if (((verticalScrollBar) && (verticalScrollBar.visible)))
            {
                verticalScrollBar.setActualSize(verticalScrollBar.minWidth, ((_local_4 - _local_5.top) - _local_5.bottom));
                verticalScrollBar.move((_local_3 - _local_5.right), _local_5.top);
                verticalScrollBar.enabled = enabled;
            };
            var _local_6:DisplayObject = maskShape;
            var _local_7:Number = ((_local_3 - _local_5.left) - _local_5.right);
            var _local_8:Number = ((_local_4 - _local_5.top) - _local_5.bottom);
            _local_6.width = ((_local_7 < 0) ? 0 : _local_7);
            _local_6.height = ((_local_8 < 0) ? 0 : _local_8);
            _local_6.x = _local_5.left;
            _local_6.y = _local_5.top;
        }

        protected function setScrollBarProperties(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_7:Boolean;
            var _local_5:String = this.horizontalScrollPolicy;
            var _local_6:String = this.verticalScrollPolicy;
            scrollAreaChanged = false;
            if (((_local_5 == ScrollPolicy.ON) || (((_arg_2 < _arg_1) && (_arg_1 > 0)) && (_local_5 == ScrollPolicy.AUTO))))
            {
                if (!horizontalScrollBar)
                {
                    createHScrollBar(false);
                    horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                    horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                    horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
                };
                _local_7 = roomForScrollBar(horizontalScrollBar, unscaledWidth, unscaledHeight);
                if (_local_7 != horizontalScrollBar.visible)
                {
                    horizontalScrollBar.visible = _local_7;
                    scrollAreaChanged = true;
                };
                if ((((horizontalScrollBar) && (horizontalScrollBar.visible)) && (((!(numberOfCols == _arg_1)) || (!(viewableColumns == _arg_2))) || (scrollAreaChanged))))
                {
                    horizontalScrollBar.setScrollProperties(_arg_2, 0, (_arg_1 - _arg_2));
                    if (horizontalScrollBar.scrollPosition != _horizontalScrollPosition)
                    {
                        horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
                    };
                    viewableColumns = _arg_2;
                    numberOfCols = _arg_1;
                };
            }
            else
            {
                if (((((_local_5 == ScrollPolicy.AUTO) || (_local_5 == ScrollPolicy.OFF)) && (horizontalScrollBar)) && (horizontalScrollBar.visible)))
                {
                    horizontalScrollPosition = 0;
                    horizontalScrollBar.setScrollProperties(_arg_2, 0, 0);
                    horizontalScrollBar.visible = false;
                    viewableColumns = NaN;
                    scrollAreaChanged = true;
                };
            };
            if (((_local_6 == ScrollPolicy.ON) || (((_arg_4 < _arg_3) && (_arg_3 > 0)) && (_local_6 == ScrollPolicy.AUTO))))
            {
                if (!verticalScrollBar)
                {
                    createVScrollBar(false);
                    verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                    verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                    verticalScrollBar.scrollPosition = _verticalScrollPosition;
                };
                _local_7 = roomForScrollBar(verticalScrollBar, unscaledWidth, unscaledHeight);
                if (_local_7 != verticalScrollBar.visible)
                {
                    verticalScrollBar.visible = _local_7;
                    scrollAreaChanged = true;
                };
                if ((((verticalScrollBar) && (verticalScrollBar.visible)) && (((!(numberOfRows == _arg_3)) || (!(viewableRows == _arg_4))) || (scrollAreaChanged))))
                {
                    verticalScrollBar.setScrollProperties(_arg_4, 0, (_arg_3 - _arg_4));
                    if (verticalScrollBar.scrollPosition != _verticalScrollPosition)
                    {
                        verticalScrollBar.scrollPosition = _verticalScrollPosition;
                    };
                    viewableRows = _arg_4;
                    numberOfRows = _arg_3;
                };
            }
            else
            {
                if (((((_local_6 == ScrollPolicy.AUTO) || (_local_6 == ScrollPolicy.OFF)) && (verticalScrollBar)) && (verticalScrollBar.visible)))
                {
                    verticalScrollPosition = 0;
                    verticalScrollBar.setScrollProperties(_arg_4, 0, 0);
                    verticalScrollBar.visible = false;
                    viewableRows = NaN;
                    scrollAreaChanged = true;
                };
            };
            if (scrollAreaChanged)
            {
                updateDisplayList(unscaledWidth, unscaledHeight);
            };
        }

        private function createHScrollBar(_arg_1:Boolean):ScrollBar
        {
            horizontalScrollBar = new HScrollBar();
            horizontalScrollBar.visible = _arg_1;
            horizontalScrollBar.enabled = enabled;
            var _local_2:String = getStyle("horizontalScrollBarStyleName");
            horizontalScrollBar.styleName = _local_2;
            addChild(horizontalScrollBar);
            horizontalScrollBar.validateNow();
            return (horizontalScrollBar);
        }

        [Bindable("horizontalScrollPolicyChanged")]
        public function get horizontalScrollPolicy():String
        {
            return (_horizontalScrollPolicy);
        }

        [Bindable("maxVerticalScrollPositionChanged")]
        public function get maxVerticalScrollPosition():Number
        {
            if (!isNaN(_maxVerticalScrollPosition))
            {
                return (_maxVerticalScrollPosition);
            };
            return ((verticalScrollBar) ? verticalScrollBar.maxScrollPosition : 0);
        }

        public function set horizontalScrollPosition(_arg_1:Number):void
        {
            _horizontalScrollPosition = _arg_1;
            if (horizontalScrollBar)
            {
                horizontalScrollBar.scrollPosition = _arg_1;
            };
            dispatchEvent(new Event("viewChanged"));
        }

        protected function roomForScrollBar(_arg_1:ScrollBar, _arg_2:Number, _arg_3:Number):Boolean
        {
            var _local_4:EdgeMetrics = borderMetrics;
            return ((_arg_2 >= ((_arg_1.minWidth + _local_4.left) + _local_4.right)) && (_arg_3 >= ((_arg_1.minHeight + _local_4.top) + _local_4.bottom)));
        }

        public function set maxHorizontalScrollPosition(_arg_1:Number):void
        {
            _maxHorizontalScrollPosition = _arg_1;
            dispatchEvent(new Event("maxHorizontalScrollPositionChanged"));
        }

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        public function get verticalScrollPosition():Number
        {
            return (_verticalScrollPosition);
        }

        public function set horizontalScrollPolicy(_arg_1:String):void
        {
            var _local_2:String = _arg_1.toLowerCase();
            if (_horizontalScrollPolicy != _local_2)
            {
                _horizontalScrollPolicy = _local_2;
                invalidateDisplayList();
                dispatchEvent(new Event("horizontalScrollPolicyChanged"));
            };
        }

        override protected function createChildren():void
        {
            var _local_1:Graphics;
            super.createChildren();
            createBorder();
            if (!maskShape)
            {
                maskShape = new FlexShape();
                maskShape.name = "mask";
                _local_1 = maskShape.graphics;
                _local_1.beginFill(0xFFFFFF);
                _local_1.drawRect(0, 0, 10, 10);
                _local_1.endFill();
                addChild(maskShape);
            };
            maskShape.visible = false;
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_2:Boolean = ((_arg_1 == null) || (_arg_1 == "styleName"));
            super.styleChanged(_arg_1);
            if (((_local_2) || (_arg_1 == "horizontalScrollBarStyleName")))
            {
                if (horizontalScrollBar)
                {
                    _local_3 = getStyle("horizontalScrollBarStyleName");
                    horizontalScrollBar.styleName = _local_3;
                };
            };
            if (((_local_2) || (_arg_1 == "verticalScrollBarStyleName")))
            {
                if (verticalScrollBar)
                {
                    _local_4 = getStyle("verticalScrollBarStyleName");
                    verticalScrollBar.styleName = _local_4;
                };
            };
            if (((_local_2) || (_arg_1 == "borderSkin")))
            {
                if (border)
                {
                    removeChild(DisplayObject(border));
                    border = null;
                    createBorder();
                };
            };
        }

        private function createVScrollBar(_arg_1:Boolean):ScrollBar
        {
            verticalScrollBar = new VScrollBar();
            verticalScrollBar.visible = _arg_1;
            verticalScrollBar.enabled = enabled;
            var _local_2:String = getStyle("verticalScrollBarStyleName");
            verticalScrollBar.styleName = _local_2;
            addChild(verticalScrollBar);
            return (verticalScrollBar);
        }

        mx_internal function get scroll_verticalScrollBar():ScrollBar
        {
            return (verticalScrollBar);
        }

        protected function createBorder():void
        {
            var _local_1:Class;
            if (((!(border)) && (isBorderNeeded())))
            {
                _local_1 = getStyle("borderSkin");
                if (_local_1 != null)
                {
                    border = new (_local_1)();
                    if ((border is IUIComponent))
                    {
                        IUIComponent(border).enabled = enabled;
                    };
                    if ((border is ISimpleStyleClient))
                    {
                        ISimpleStyleClient(border).styleName = this;
                    };
                    addChildAt(DisplayObject(border), 0);
                    invalidateDisplayList();
                };
            };
        }

        mx_internal function get scroll_horizontalScrollBar():ScrollBar
        {
            return (horizontalScrollBar);
        }

        protected function layoutChrome(_arg_1:Number, _arg_2:Number):void
        {
            if (border)
            {
                border.move(0, 0);
                border.setActualSize(_arg_1, _arg_2);
            };
        }

        protected function scrollHandler(_arg_1:Event):void
        {
            var _local_2:ScrollBar;
            var _local_3:Number;
            var _local_4:QName;
            if ((_arg_1 is ScrollEvent))
            {
                _local_2 = ScrollBar(_arg_1.target);
                _local_3 = _local_2.scrollPosition;
                if (_local_2 == verticalScrollBar)
                {
                    _local_4 = new QName(mx_internal, "_verticalScrollPosition");
                }
                else
                {
                    if (_local_2 == horizontalScrollBar)
                    {
                        _local_4 = new QName(mx_internal, "_horizontalScrollPosition");
                    };
                };
                dispatchEvent(_arg_1);
                if (_local_4)
                {
                    this[_local_4] = _local_3;
                };
            };
        }

        protected function mouseWheelHandler(_arg_1:MouseEvent):void
        {
            var _local_2:int;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:ScrollEvent;
            if (((verticalScrollBar) && (verticalScrollBar.visible)))
            {
                _arg_1.stopPropagation();
                _local_2 = ((_arg_1.delta <= 0) ? 1 : -1);
                _local_3 = Math.max(Math.abs(_arg_1.delta), verticalScrollBar.lineScrollSize);
                _local_4 = verticalScrollPosition;
                verticalScrollPosition = (verticalScrollPosition + ((3 * _local_3) * _local_2));
                _local_5 = new ScrollEvent(ScrollEvent.SCROLL);
                _local_5.direction = ScrollEventDirection.VERTICAL;
                _local_5.position = verticalScrollPosition;
                _local_5.delta = (verticalScrollPosition - _local_4);
                dispatchEvent(_local_5);
            };
        }

        private function scrollTipHandler(_arg_1:Event):void
        {
            var _local_2:ScrollBar;
            var _local_3:Boolean;
            var _local_4:String;
            var _local_5:Number;
            var _local_6:String;
            var _local_7:Point;
            if ((_arg_1 is ScrollEvent))
            {
                if (!showScrollTips)
                {
                    return;
                };
                if (ScrollEvent(_arg_1).detail == ScrollEventDetail.THUMB_POSITION)
                {
                    if (scrollTip)
                    {
                        systemManager.topLevelSystemManager.removeChildFromSandboxRoot("toolTipChildren", (scrollTip as DisplayObject));
                        scrollTip = null;
                        ToolTipManager.enabled = oldTTMEnabled;
                    };
                }
                else
                {
                    if (ScrollEvent(_arg_1).detail == ScrollEventDetail.THUMB_TRACK)
                    {
                        _local_2 = ScrollBar(_arg_1.target);
                        _local_3 = (_local_2 == verticalScrollBar);
                        _local_4 = ((_local_3) ? "vertical" : "horizontal");
                        _local_5 = _local_2.scrollPosition;
                        if (!scrollTip)
                        {
                            scrollTip = new ToolTip();
                            systemManager.topLevelSystemManager.addChildToSandboxRoot("toolTipChildren", (scrollTip as DisplayObject));
                            scrollThumbMidPoint = (_local_2.scrollThumb.height / 2);
                            oldTTMEnabled = ToolTipManager.enabled;
                            ToolTipManager.enabled = false;
                        };
                        _local_6 = _local_5.toString();
                        if (_scrollTipFunction != null)
                        {
                            _local_6 = _scrollTipFunction(_local_4, _local_5);
                        };
                        if (_local_6 == "")
                        {
                            scrollTip.visible = false;
                        }
                        else
                        {
                            scrollTip.text = _local_6;
                            ToolTipManager.sizeTip(scrollTip);
                            _local_7 = new Point();
                            if (_local_3)
                            {
                                _local_7.x = (-3 - scrollTip.width);
                                _local_7.y = ((_local_2.scrollThumb.y + scrollThumbMidPoint) - (scrollTip.height / 2));
                            }
                            else
                            {
                                _local_7.x = (-3 - scrollTip.height);
                                _local_7.y = ((_local_2.scrollThumb.y + scrollThumbMidPoint) - (scrollTip.width / 2));
                            };
                            _local_7 = _local_2.localToGlobal(_local_7);
                            scrollTip.move(_local_7.x, _local_7.y);
                            scrollTip.visible = true;
                        };
                    };
                };
            };
        }

        public function set verticalScrollPosition(_arg_1:Number):void
        {
            _verticalScrollPosition = _arg_1;
            if (verticalScrollBar)
            {
                verticalScrollBar.scrollPosition = _arg_1;
            };
            dispatchEvent(new Event("viewChanged"));
        }

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        public function get horizontalScrollPosition():Number
        {
            return (_horizontalScrollPosition);
        }

        private function isBorderNeeded():Boolean
        {
            var _local_1:Object = getStyle("borderStyle");
            if (_local_1)
            {
                if (((!(_local_1 == "none")) || ((_local_1 == "none") && (getStyle("mouseShield")))))
                {
                    return (true);
                };
            };
            _local_1 = getStyle("backgroundColor");
            if (((!(_local_1 === null)) && (!(_local_1 === ""))))
            {
                return (true);
            };
            _local_1 = getStyle("backgroundImage");
            return ((!(_local_1 == null)) && (!(_local_1 == "")));
        }

        [Bindable("maxHorizontalScrollPositionChanged")]
        public function get maxHorizontalScrollPosition():Number
        {
            if (!isNaN(_maxHorizontalScrollPosition))
            {
                return (_maxHorizontalScrollPosition);
            };
            return ((horizontalScrollBar) ? horizontalScrollBar.maxScrollPosition : 0);
        }

        public function set maxVerticalScrollPosition(_arg_1:Number):void
        {
            _maxVerticalScrollPosition = _arg_1;
            dispatchEvent(new Event("maxVerticalScrollPositionChanged"));
        }

        public function set verticalScrollPolicy(_arg_1:String):void
        {
            var _local_2:String = _arg_1.toLowerCase();
            if (_verticalScrollPolicy != _local_2)
            {
                _verticalScrollPolicy = _local_2;
                invalidateDisplayList();
                dispatchEvent(new Event("verticalScrollPolicyChanged"));
            };
        }

        public function get viewMetrics():EdgeMetrics
        {
            _viewMetrics = borderMetrics.clone();
            if (((!(horizontalScrollBar)) && (horizontalScrollPolicy == ScrollPolicy.ON)))
            {
                createHScrollBar(true);
                horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
                invalidateDisplayList();
            };
            if (((!(verticalScrollBar)) && (verticalScrollPolicy == ScrollPolicy.ON)))
            {
                createVScrollBar(true);
                verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                verticalScrollBar.scrollPosition = _verticalScrollPosition;
                invalidateDisplayList();
            };
            if (((verticalScrollBar) && (verticalScrollBar.visible)))
            {
                _viewMetrics.right = (_viewMetrics.right + verticalScrollBar.minWidth);
            };
            if (((horizontalScrollBar) && (horizontalScrollBar.visible)))
            {
                _viewMetrics.bottom = (_viewMetrics.bottom + horizontalScrollBar.minHeight);
            };
            return (_viewMetrics);
        }

        [Bindable("verticalScrollPolicyChanged")]
        public function get verticalScrollPolicy():String
        {
            return (_verticalScrollPolicy);
        }

        public function get borderMetrics():EdgeMetrics
        {
            return (((border) && (border is IRectangularBorder)) ? IRectangularBorder(border).borderMetrics : EdgeMetrics.EMPTY);
        }


    }
}//package mx.core

