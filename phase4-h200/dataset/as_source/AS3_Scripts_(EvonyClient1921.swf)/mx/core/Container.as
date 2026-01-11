// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.Container

package mx.core
{
    import mx.managers.IFocusManagerContainer;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.controls.scrollClasses.ScrollBar;
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.InteractiveObject;
    import mx.styles.ISimpleStyleClient;
    import mx.styles.IStyleClient;
    import flash.display.DisplayObject;
    import mx.managers.ILayoutManagerClient;
    import flash.events.MouseEvent;
    import mx.managers.IFocusManager;
    import flash.display.Graphics;
    import mx.controls.HScrollBar;
    import mx.events.ScrollEvent;
    import flash.events.KeyboardEvent;
    import mx.controls.VScrollBar;
    import flash.text.TextField;
    import mx.events.ScrollEventDirection;
    import mx.events.ScrollEventDetail;
    import flash.ui.Keyboard;
    import mx.managers.ISystemManager;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.FlexEvent;
    import flash.text.TextLineMetrics;
    import mx.binding.BindingManager;
    import mx.styles.StyleProtoChain;
    import mx.events.IndexChangedEvent;
    import mx.events.ChildExistenceChangedEvent;
    import mx.graphics.RoundedRectangle;
    import flash.utils.getDefinitionByName;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import mx.styles.StyleManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Container extends UIComponent implements IContainer, IDataRenderer, IFocusManagerContainer, IListItemRenderer, IRawChildrenContainer 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static const MULTIPLE_PROPERTIES:String = "<MULTIPLE>";

        private var forceLayout:Boolean = false;
        private var _numChildrenCreated:int = -1;
        private var _horizontalLineScrollSize:Number = 5;
        mx_internal var border:IFlexDisplayObject;
        protected var actualCreationPolicy:String;
        private var _viewMetricsAndPadding:EdgeMetrics;
        private var _creatingContentPane:Boolean = false;
        private var _childRepeaters:Array;
        private var scrollableWidth:Number = 0;
        private var _childDescriptors:Array;
        private var _rawChildren:ContainerRawChildrenList;
        private var _data:Object;
        private var _verticalPageScrollSize:Number = 0;
        private var _viewMetrics:EdgeMetrics;
        private var _verticalScrollBar:ScrollBar;
        private var scrollPropertiesChanged:Boolean = false;
        private var changedStyles:String = null;
        private var scrollPositionChanged:Boolean = true;
        private var _defaultButton:IFlexDisplayObject;
        private var mouseEventReferenceCount:int = 0;
        private var _focusPane:Sprite;
        protected var whiteBox:Shape;
        private var _forceClippingCount:int;
        private var _horizontalPageScrollSize:Number = 0;
        private var _creationPolicy:String;
        private var _creationIndex:int = -1;
        private var _clipContent:Boolean = true;
        private var _verticalScrollPosition:Number = 0;
        private var _autoLayout:Boolean = true;
        private var _icon:Class = null;
        mx_internal var doingLayout:Boolean = false;
        private var _horizontalScrollBar:ScrollBar;
        private var numChildrenBefore:int;
        private var viewableHeight:Number = 0;
        private var viewableWidth:Number = 0;
        mx_internal var contentPane:Sprite = null;
        private var _createdComponents:Array;
        private var _firstChildIndex:int = 0;
        private var scrollableHeight:Number = 0;
        private var _verticalLineScrollSize:Number = 5;
        private var _horizontalScrollPosition:Number = 0;
        mx_internal var _horizontalScrollPolicy:String = "auto";
        private var verticalScrollPositionPending:Number;
        mx_internal var _verticalScrollPolicy:String = "auto";
        private var horizontalScrollPositionPending:Number;
        mx_internal var _numChildren:int = 0;
        private var recursionFlag:Boolean = true;
        private var _label:String = "";
        mx_internal var blocker:Sprite;

        public function Container()
        {
            tabChildren = true;
            tabEnabled = false;
            showInAutomationHierarchy = false;
        }

        public function set verticalScrollPolicy(_arg_1:String):void
        {
            if (_verticalScrollPolicy != _arg_1)
            {
                _verticalScrollPolicy = _arg_1;
                invalidateDisplayList();
                dispatchEvent(new Event("verticalScrollPolicyChanged"));
            };
        }

        private function createContentPaneAndScrollbarsIfNeeded():Boolean
        {
            var _local_1:Rectangle;
            var _local_2:Boolean;
            if (_clipContent)
            {
                _local_1 = getScrollableRect();
                _local_2 = createScrollbarsIfNeeded(_local_1);
                if (border)
                {
                    updateBackgroundImageRect();
                };
                return (_local_2);
            };
            _local_2 = createOrDestroyScrollbars(false, false, false);
            _local_1 = getScrollableRect();
            scrollableWidth = _local_1.right;
            scrollableHeight = _local_1.bottom;
            if (((_local_2) && (border)))
            {
                updateBackgroundImageRect();
            };
            return (_local_2);
        }

        override protected function initializationComplete():void
        {
        }

        mx_internal function rawChildren_getObjectsUnderPoint(_arg_1:Point):Array
        {
            return (super.getObjectsUnderPoint(_arg_1));
        }

        public function set creatingContentPane(_arg_1:Boolean):void
        {
            _creatingContentPane = _arg_1;
        }

        public function set clipContent(_arg_1:Boolean):void
        {
            if (_clipContent != _arg_1)
            {
                _clipContent = _arg_1;
                invalidateDisplayList();
            };
        }

        protected function scrollChildren():void
        {
            if (!contentPane)
            {
                return;
            };
            var _local_1:EdgeMetrics = viewMetrics;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:Number = ((unscaledWidth - _local_1.left) - _local_1.right);
            var _local_5:Number = ((unscaledHeight - _local_1.top) - _local_1.bottom);
            if (_clipContent)
            {
                _local_2 = (_local_2 + _horizontalScrollPosition);
                if (horizontalScrollBar)
                {
                    _local_4 = viewableWidth;
                };
                _local_3 = (_local_3 + _verticalScrollPosition);
                if (verticalScrollBar)
                {
                    _local_5 = viewableHeight;
                };
            }
            else
            {
                _local_4 = scrollableWidth;
                _local_5 = scrollableHeight;
            };
            var _local_6:Rectangle = getScrollableRect();
            if ((((((((_local_2 == 0) && (_local_3 == 0)) && (_local_4 >= _local_6.right)) && (_local_5 >= _local_6.bottom)) && (_local_6.left >= 0)) && (_local_6.top >= 0)) && (_forceClippingCount <= 0)))
            {
                contentPane.scrollRect = null;
                contentPane.opaqueBackground = null;
                contentPane.cacheAsBitmap = false;
            }
            else
            {
                contentPane.scrollRect = new Rectangle(_local_2, _local_3, _local_4, _local_5);
            };
            if (focusPane)
            {
                focusPane.scrollRect = contentPane.scrollRect;
            };
            if ((((border) && (border is IRectangularBorder)) && (IRectangularBorder(border).hasBackgroundImage)))
            {
                IRectangularBorder(border).layoutBackgroundImage();
            };
        }

        override public function set doubleClickEnabled(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:InteractiveObject;
            super.doubleClickEnabled = _arg_1;
            if (contentPane)
            {
                _local_2 = contentPane.numChildren;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = (contentPane.getChildAt(_local_3) as InteractiveObject);
                    if (_local_4)
                    {
                        _local_4.doubleClickEnabled = _arg_1;
                    };
                    _local_3++;
                };
            };
        }

        override public function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_5:ISimpleStyleClient;
            var _local_3:int = super.numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if ((((contentPane) || (_local_4 < _firstChildIndex)) || (_local_4 >= (_firstChildIndex + _numChildren))))
                {
                    _local_5 = (super.getChildAt(_local_4) as ISimpleStyleClient);
                    if (_local_5)
                    {
                        _local_5.styleChanged(_arg_1);
                        if ((_local_5 is IStyleClient))
                        {
                            IStyleClient(_local_5).notifyStyleChangeInChildren(_arg_1, _arg_2);
                        };
                    };
                };
                _local_4++;
            };
            if (_arg_2)
            {
                changedStyles = (((!(changedStyles == null)) || (_arg_1 == null)) ? MULTIPLE_PROPERTIES : _arg_1);
                invalidateProperties();
            };
        }

        mx_internal function get createdComponents():Array
        {
            return (_createdComponents);
        }

        public function get childDescriptors():Array
        {
            return (_childDescriptors);
        }

        override public function get contentMouseY():Number
        {
            if (contentPane)
            {
                return (contentPane.mouseY);
            };
            return (super.contentMouseY);
        }

        mx_internal function get childRepeaters():Array
        {
            return (_childRepeaters);
        }

        override public function contains(_arg_1:DisplayObject):Boolean
        {
            if (contentPane)
            {
                return (contentPane.contains(_arg_1));
            };
            return (super.contains(_arg_1));
        }

        override public function get contentMouseX():Number
        {
            if (contentPane)
            {
                return (contentPane.mouseX);
            };
            return (super.contentMouseX);
        }

        mx_internal function set createdComponents(_arg_1:Array):void
        {
            _createdComponents = _arg_1;
        }

        public function get horizontalScrollBar():ScrollBar
        {
            return (_horizontalScrollBar);
        }

        override public function validateSize(_arg_1:Boolean=false):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:DisplayObject;
            if (((autoLayout == false) && (forceLayout == false)))
            {
                if (_arg_1)
                {
                    _local_2 = super.numChildren;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _local_4 = super.getChildAt(_local_3);
                        if ((_local_4 is ILayoutManagerClient))
                        {
                            ILayoutManagerClient(_local_4).validateSize(true);
                        };
                        _local_3++;
                    };
                };
                adjustSizesForScaleChanges();
            }
            else
            {
                super.validateSize(_arg_1);
            };
        }

        public function get rawChildren():IChildList
        {
            if (!_rawChildren)
            {
                _rawChildren = new ContainerRawChildrenList(this);
            };
            return (_rawChildren);
        }

        override public function getChildAt(_arg_1:int):DisplayObject
        {
            if (contentPane)
            {
                return (contentPane.getChildAt(_arg_1));
            };
            return (super.getChildAt((_firstChildIndex + _arg_1)));
        }

        override protected function attachOverlay():void
        {
            rawChildren_addChild(overlay);
        }

        override public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            super.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            if (((((((((_arg_1 == MouseEvent.CLICK) || (_arg_1 == MouseEvent.DOUBLE_CLICK)) || (_arg_1 == MouseEvent.MOUSE_DOWN)) || (_arg_1 == MouseEvent.MOUSE_MOVE)) || (_arg_1 == MouseEvent.MOUSE_OVER)) || (_arg_1 == MouseEvent.MOUSE_OUT)) || (_arg_1 == MouseEvent.MOUSE_UP)) || (_arg_1 == MouseEvent.MOUSE_WHEEL)))
            {
                if (((mouseEventReferenceCount < 2147483647) && (mouseEventReferenceCount++ == 0)))
                {
                    setStyle("mouseShield", true);
                    setStyle("mouseShieldChildren", true);
                };
            };
        }

        override public function localToContent(_arg_1:Point):Point
        {
            if (!contentPane)
            {
                return (_arg_1);
            };
            _arg_1 = localToGlobal(_arg_1);
            return (globalToContent(_arg_1));
        }

        public function executeChildBindings(_arg_1:Boolean):void
        {
            var _local_4:IUIComponent;
            var _local_2:int = numChildren;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = IUIComponent(getChildAt(_local_3));
                if ((_local_4 is IDeferredInstantiationUIComponent))
                {
                    IDeferredInstantiationUIComponent(_local_4).executeBindings(_arg_1);
                };
                _local_3++;
            };
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
                    border.name = "border";
                    if ((border is IUIComponent))
                    {
                        IUIComponent(border).enabled = enabled;
                    };
                    if ((border is ISimpleStyleClient))
                    {
                        ISimpleStyleClient(border).styleName = this;
                    };
                    rawChildren.addChildAt(DisplayObject(border), 0);
                    invalidateDisplayList();
                };
            };
        }

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        public function get verticalScrollPosition():Number
        {
            if (!isNaN(verticalScrollPositionPending))
            {
                return (verticalScrollPositionPending);
            };
            return (_verticalScrollPosition);
        }

        [Bindable("scroll")]
        [Bindable("viewChanged")]
        public function get horizontalScrollPosition():Number
        {
            if (!isNaN(horizontalScrollPositionPending))
            {
                return (horizontalScrollPositionPending);
            };
            return (_horizontalScrollPosition);
        }

        protected function layoutChrome(_arg_1:Number, _arg_2:Number):void
        {
            if (border)
            {
                updateBackgroundImageRect();
                border.move(0, 0);
                border.setActualSize(_arg_1, _arg_2);
            };
        }

        mx_internal function set childRepeaters(_arg_1:Array):void
        {
            _childRepeaters = _arg_1;
        }

        override public function get focusPane():Sprite
        {
            return (_focusPane);
        }

        public function set creationIndex(_arg_1:int):void
        {
            _creationIndex = _arg_1;
        }

        public function get viewMetrics():EdgeMetrics
        {
            var _local_1:EdgeMetrics = borderMetrics;
            var _local_2:Boolean = ((!(verticalScrollBar == null)) && ((doingLayout) || (verticalScrollPolicy == ScrollPolicy.ON)));
            var _local_3:Boolean = ((!(horizontalScrollBar == null)) && ((doingLayout) || (horizontalScrollPolicy == ScrollPolicy.ON)));
            if (((!(_local_2)) && (!(_local_3))))
            {
                return (_local_1);
            };
            if (!_viewMetrics)
            {
                _viewMetrics = _local_1.clone();
            }
            else
            {
                _viewMetrics.left = _local_1.left;
                _viewMetrics.right = _local_1.right;
                _viewMetrics.top = _local_1.top;
                _viewMetrics.bottom = _local_1.bottom;
            };
            if (_local_2)
            {
                _viewMetrics.right = (_viewMetrics.right + verticalScrollBar.minWidth);
            };
            if (_local_3)
            {
                _viewMetrics.bottom = (_viewMetrics.bottom + horizontalScrollBar.minHeight);
            };
            return (_viewMetrics);
        }

        public function set verticalScrollBar(_arg_1:ScrollBar):void
        {
            _verticalScrollBar = _arg_1;
        }

        public function set verticalScrollPosition(_arg_1:Number):void
        {
            if (_verticalScrollPosition == _arg_1)
            {
                return;
            };
            _verticalScrollPosition = _arg_1;
            scrollPositionChanged = true;
            if (!initialized)
            {
                verticalScrollPositionPending = _arg_1;
            };
            invalidateDisplayList();
            dispatchEvent(new Event("viewChanged"));
        }

        mx_internal function $addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            super.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        private function createOrDestroyScrollbars(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):Boolean
        {
            var _local_5:IFocusManager;
            var _local_6:String;
            var _local_7:String;
            var _local_8:Graphics;
            var _local_4:Boolean;
            if ((((_arg_1) || (_arg_2)) || (_arg_3)))
            {
                createContentPane();
            };
            if (_arg_1)
            {
                if (!horizontalScrollBar)
                {
                    horizontalScrollBar = new HScrollBar();
                    horizontalScrollBar.name = "horizontalScrollBar";
                    _local_6 = getStyle("horizontalScrollBarStyleName");
                    if (((_local_6) && (horizontalScrollBar is ISimpleStyleClient)))
                    {
                        ISimpleStyleClient(horizontalScrollBar).styleName = _local_6;
                    };
                    rawChildren.addChild(DisplayObject(horizontalScrollBar));
                    horizontalScrollBar.lineScrollSize = horizontalLineScrollSize;
                    horizontalScrollBar.pageScrollSize = horizontalPageScrollSize;
                    horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, horizontalScrollBar_scrollHandler);
                    horizontalScrollBar.enabled = enabled;
                    if ((horizontalScrollBar is IInvalidating))
                    {
                        IInvalidating(horizontalScrollBar).validateNow();
                    };
                    invalidateDisplayList();
                    invalidateViewMetricsAndPadding();
                    _local_4 = true;
                    if (!verticalScrollBar)
                    {
                        addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    };
                };
            }
            else
            {
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.removeEventListener(ScrollEvent.SCROLL, horizontalScrollBar_scrollHandler);
                    rawChildren.removeChild(DisplayObject(horizontalScrollBar));
                    horizontalScrollBar = null;
                    viewableWidth = (scrollableWidth = 0);
                    if (_horizontalScrollPosition != 0)
                    {
                        _horizontalScrollPosition = 0;
                        scrollPositionChanged = true;
                    };
                    invalidateDisplayList();
                    invalidateViewMetricsAndPadding();
                    _local_4 = true;
                    _local_5 = focusManager;
                    if (((!(verticalScrollBar)) && ((!(_local_5)) || (!(_local_5.getFocus() == this)))))
                    {
                        removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    };
                };
            };
            if (_arg_2)
            {
                if (!verticalScrollBar)
                {
                    verticalScrollBar = new VScrollBar();
                    verticalScrollBar.name = "verticalScrollBar";
                    _local_7 = getStyle("verticalScrollBarStyleName");
                    if (((_local_7) && (verticalScrollBar is ISimpleStyleClient)))
                    {
                        ISimpleStyleClient(verticalScrollBar).styleName = _local_7;
                    };
                    rawChildren.addChild(DisplayObject(verticalScrollBar));
                    verticalScrollBar.lineScrollSize = verticalLineScrollSize;
                    verticalScrollBar.pageScrollSize = verticalPageScrollSize;
                    verticalScrollBar.addEventListener(ScrollEvent.SCROLL, verticalScrollBar_scrollHandler);
                    verticalScrollBar.enabled = enabled;
                    if ((verticalScrollBar is IInvalidating))
                    {
                        IInvalidating(verticalScrollBar).validateNow();
                    };
                    invalidateDisplayList();
                    invalidateViewMetricsAndPadding();
                    _local_4 = true;
                    if (!horizontalScrollBar)
                    {
                        addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    };
                    addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
                };
            }
            else
            {
                if (verticalScrollBar)
                {
                    verticalScrollBar.removeEventListener(ScrollEvent.SCROLL, verticalScrollBar_scrollHandler);
                    rawChildren.removeChild(DisplayObject(verticalScrollBar));
                    verticalScrollBar = null;
                    viewableHeight = (scrollableHeight = 0);
                    if (_verticalScrollPosition != 0)
                    {
                        _verticalScrollPosition = 0;
                        scrollPositionChanged = true;
                    };
                    invalidateDisplayList();
                    invalidateViewMetricsAndPadding();
                    _local_4 = true;
                    _local_5 = focusManager;
                    if (((!(horizontalScrollBar)) && ((!(_local_5)) || (!(_local_5.getFocus() == this)))))
                    {
                        removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    };
                    removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
                };
            };
            if (((horizontalScrollBar) && (verticalScrollBar)))
            {
                if (!whiteBox)
                {
                    whiteBox = new FlexShape();
                    whiteBox.name = "whiteBox";
                    _local_8 = whiteBox.graphics;
                    _local_8.beginFill(0xFFFFFF);
                    _local_8.drawRect(0, 0, verticalScrollBar.minWidth, horizontalScrollBar.minHeight);
                    _local_8.endFill();
                    rawChildren.addChild(whiteBox);
                };
            }
            else
            {
                if (whiteBox)
                {
                    rawChildren.removeChild(whiteBox);
                    whiteBox = null;
                };
            };
            return (_local_4);
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_3:String;
            var _local_4:Number;
            var _local_2:Object = getFocus();
            if ((_local_2 is TextField))
            {
                return;
            };
            if (verticalScrollBar)
            {
                _local_3 = ScrollEventDirection.VERTICAL;
                _local_4 = verticalScrollPosition;
                switch (_arg_1.keyCode)
                {
                    case Keyboard.DOWN:
                        verticalScrollPosition = (verticalScrollPosition + verticalLineScrollSize);
                        dispatchScrollEvent(_local_3, _local_4, verticalScrollPosition, ScrollEventDetail.LINE_DOWN);
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.UP:
                        verticalScrollPosition = (verticalScrollPosition - verticalLineScrollSize);
                        dispatchScrollEvent(_local_3, _local_4, verticalScrollPosition, ScrollEventDetail.LINE_UP);
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.PAGE_UP:
                        verticalScrollPosition = (verticalScrollPosition - verticalPageScrollSize);
                        dispatchScrollEvent(_local_3, _local_4, verticalScrollPosition, ScrollEventDetail.PAGE_UP);
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.PAGE_DOWN:
                        verticalScrollPosition = (verticalScrollPosition + verticalPageScrollSize);
                        dispatchScrollEvent(_local_3, _local_4, verticalScrollPosition, ScrollEventDetail.PAGE_DOWN);
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.HOME:
                        verticalScrollPosition = verticalScrollBar.minScrollPosition;
                        dispatchScrollEvent(_local_3, _local_4, verticalScrollPosition, ScrollEventDetail.AT_TOP);
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.END:
                        verticalScrollPosition = verticalScrollBar.maxScrollPosition;
                        dispatchScrollEvent(_local_3, _local_4, verticalScrollPosition, ScrollEventDetail.AT_BOTTOM);
                        _arg_1.stopPropagation();
                        break;
                };
            };
            if (horizontalScrollBar)
            {
                _local_3 = ScrollEventDirection.HORIZONTAL;
                _local_4 = horizontalScrollPosition;
                switch (_arg_1.keyCode)
                {
                    case Keyboard.LEFT:
                        horizontalScrollPosition = (horizontalScrollPosition - horizontalLineScrollSize);
                        dispatchScrollEvent(_local_3, _local_4, horizontalScrollPosition, ScrollEventDetail.LINE_LEFT);
                        _arg_1.stopPropagation();
                        return;
                    case Keyboard.RIGHT:
                        horizontalScrollPosition = (horizontalScrollPosition + horizontalLineScrollSize);
                        dispatchScrollEvent(_local_3, _local_4, horizontalScrollPosition, ScrollEventDetail.LINE_RIGHT);
                        _arg_1.stopPropagation();
                        return;
                };
            };
        }

        [Bindable("iconChanged")]
        public function get icon():Class
        {
            return (_icon);
        }

        private function createOrDestroyBlocker():void
        {
            var _local_1:DisplayObject;
            var _local_2:ISystemManager;
            if (enabled)
            {
                if (blocker)
                {
                    rawChildren.removeChild(blocker);
                    blocker = null;
                };
            }
            else
            {
                if (!blocker)
                {
                    blocker = new FlexSprite();
                    blocker.name = "blocker";
                    blocker.mouseEnabled = true;
                    rawChildren.addChild(blocker);
                    blocker.addEventListener(MouseEvent.CLICK, blocker_clickHandler);
                    _local_1 = ((focusManager) ? DisplayObject(focusManager.getFocus()) : null);
                    while (_local_1)
                    {
                        if (_local_1 == this)
                        {
                            _local_2 = systemManager;
                            if (((_local_2) && (_local_2.stage)))
                            {
                                _local_2.stage.focus = null;
                            };
                            return;
                        };
                        _local_1 = _local_1.parent;
                    };
                };
            };
        }

        private function horizontalScrollBar_scrollHandler(_arg_1:Event):void
        {
            var _local_2:Number;
            if ((_arg_1 is ScrollEvent))
            {
                _local_2 = horizontalScrollPosition;
                horizontalScrollPosition = horizontalScrollBar.scrollPosition;
                dispatchScrollEvent(ScrollEventDirection.HORIZONTAL, _local_2, horizontalScrollPosition, ScrollEvent(_arg_1).detail);
            };
        }

        public function createComponentFromDescriptor(_arg_1:ComponentDescriptor, _arg_2:Boolean):IFlexDisplayObject
        {
            var _local_7:String;
            var _local_10:IRepeaterClient;
            var _local_11:IStyleClient;
            var _local_12:String;
            var _local_13:String;
            var _local_3:UIComponentDescriptor = UIComponentDescriptor(_arg_1);
            var _local_4:Object = _local_3.properties;
            if (((((!(numChildrenBefore == 0)) || (!(numChildrenCreated == -1))) && (_local_3.instanceIndices == null)) && (hasChildMatchingDescriptor(_local_3))))
            {
                return (null);
            };
            UIComponentGlobals.layoutManager.usePhasedInstantiation = true;
            var _local_5:Class = _local_3.type;
            var _local_6:IDeferredInstantiationUIComponent = new (_local_5)();
            _local_6.id = _local_3.id;
            if (((_local_6.id) && (!(_local_6.id == ""))))
            {
                _local_6.name = _local_6.id;
            };
            _local_6.descriptor = _local_3;
            if (((_local_4.childDescriptors) && (_local_6 is Container)))
            {
                Container(_local_6)._childDescriptors = _local_4.childDescriptors;
                delete _local_4.childDescriptors;
            };
            for (_local_7 in _local_4)
            {
                _local_6[_local_7] = _local_4[_local_7];
            };
            if ((_local_6 is Container))
            {
                Container(_local_6).recursionFlag = _arg_2;
            };
            if (_local_3.instanceIndices)
            {
                if ((_local_6 is IRepeaterClient))
                {
                    _local_10 = IRepeaterClient(_local_6);
                    _local_10.instanceIndices = _local_3.instanceIndices;
                    _local_10.repeaters = _local_3.repeaters;
                    _local_10.repeaterIndices = _local_3.repeaterIndices;
                };
            };
            if ((_local_6 is IStyleClient))
            {
                _local_11 = IStyleClient(_local_6);
                if (_local_3.stylesFactory != null)
                {
                    if (!_local_11.styleDeclaration)
                    {
                        _local_11.styleDeclaration = new CSSStyleDeclaration();
                    };
                    _local_11.styleDeclaration.factory = _local_3.stylesFactory;
                };
            };
            var _local_8:Object = _local_3.events;
            if (_local_8)
            {
                for (_local_12 in _local_8)
                {
                    _local_13 = _local_8[_local_12];
                    _local_6.addEventListener(_local_12, _local_3.document[_local_13]);
                };
            };
            var _local_9:Array = _local_3.effects;
            if (_local_9)
            {
                _local_6.registerEffects(_local_9);
            };
            if ((_local_6 is IRepeaterClient))
            {
                IRepeaterClient(_local_6).initializeRepeaterArrays(this);
            };
            _local_6.createReferenceOnParentDocument(IFlexDisplayObject(_local_3.document));
            if (!_local_6.document)
            {
                _local_6.document = _local_3.document;
            };
            if ((_local_6 is IRepeater))
            {
                if (!childRepeaters)
                {
                    childRepeaters = [];
                };
                childRepeaters.push(_local_6);
                _local_6.executeBindings();
                IRepeater(_local_6).initializeRepeater(this, _arg_2);
            }
            else
            {
                addChild(DisplayObject(_local_6));
                _local_6.executeBindings();
                if (((creationPolicy == ContainerCreationPolicy.QUEUED) || (creationPolicy == ContainerCreationPolicy.NONE)))
                {
                    _local_6.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
                };
            };
            return (_local_6);
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
            invalidateProperties();
        }

        public function set horizontalScrollBar(_arg_1:ScrollBar):void
        {
            _horizontalScrollBar = _arg_1;
        }

        mx_internal function get usePadding():Boolean
        {
            return (true);
        }

        override public function get baselinePosition():Number
        {
            var _local_2:IUIComponent;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (((getStyle("verticalAlign") == "top") && (numChildren > 0)))
                {
                    _local_2 = (getChildAt(0) as IUIComponent);
                    if (_local_2)
                    {
                        return (_local_2.y + _local_2.baselinePosition);
                    };
                };
                return (super.baselinePosition);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            var _local_1:TextLineMetrics = measureText("Wj");
            if (height < (((2 * viewMetrics.top) + 4) + _local_1.ascent))
            {
                return (int((height + ((_local_1.ascent - height) / 2))));
            };
            return ((viewMetrics.top + 2) + _local_1.ascent);
        }

        override public function getChildByName(_arg_1:String):DisplayObject
        {
            var _local_2:DisplayObject;
            var _local_3:int;
            if (contentPane)
            {
                return (contentPane.getChildByName(_arg_1));
            };
            _local_2 = super.getChildByName(_arg_1);
            if (!_local_2)
            {
                return (null);
            };
            _local_3 = (super.getChildIndex(_local_2) - _firstChildIndex);
            if (((_local_3 < 0) || (_local_3 >= _numChildren)))
            {
                return (null);
            };
            return (_local_2);
        }

        [Bindable("verticalLineScrollSizeChanged")]
        public function get verticalLineScrollSize():Number
        {
            return (_verticalLineScrollSize);
        }

        [Bindable("horizontalScrollPolicyChanged")]
        public function get horizontalScrollPolicy():String
        {
            return (_horizontalScrollPolicy);
        }

        mx_internal function $removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            super.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function get maxVerticalScrollPosition():Number
        {
            return ((verticalScrollBar) ? verticalScrollBar.maxScrollPosition : Math.max((scrollableHeight - viewableHeight), 0));
        }

        public function set horizontalScrollPosition(_arg_1:Number):void
        {
            if (_horizontalScrollPosition == _arg_1)
            {
                return;
            };
            _horizontalScrollPosition = _arg_1;
            scrollPositionChanged = true;
            if (!initialized)
            {
                horizontalScrollPositionPending = _arg_1;
            };
            invalidateDisplayList();
            dispatchEvent(new Event("viewChanged"));
        }

        mx_internal function invalidateViewMetricsAndPadding():void
        {
            _viewMetricsAndPadding = null;
        }

        [Bindable("horizontalLineScrollSizeChanged")]
        public function get horizontalLineScrollSize():Number
        {
            return (_horizontalLineScrollSize);
        }

        override public function set focusPane(_arg_1:Sprite):void
        {
            var _local_2:Boolean = invalidateSizeFlag;
            var _local_3:Boolean = invalidateDisplayListFlag;
            invalidateSizeFlag = true;
            invalidateDisplayListFlag = true;
            if (_arg_1)
            {
                rawChildren.addChild(_arg_1);
                _arg_1.x = 0;
                _arg_1.y = 0;
                _arg_1.scrollRect = null;
                _focusPane = _arg_1;
            }
            else
            {
                rawChildren.removeChild(_focusPane);
                _focusPane = null;
            };
            if (((_arg_1) && (contentPane)))
            {
                _arg_1.x = contentPane.x;
                _arg_1.y = contentPane.y;
                _arg_1.scrollRect = contentPane.scrollRect;
            };
            invalidateSizeFlag = _local_2;
            invalidateDisplayListFlag = _local_3;
        }

        private function updateBackgroundImageRect():void
        {
            var _local_1:IRectangularBorder = (border as IRectangularBorder);
            if (!_local_1)
            {
                return;
            };
            if (((viewableWidth == 0) && (viewableHeight == 0)))
            {
                _local_1.backgroundImageBounds = null;
                return;
            };
            var _local_2:EdgeMetrics = viewMetrics;
            var _local_3:Number = ((viewableWidth) ? viewableWidth : ((unscaledWidth - _local_2.left) - _local_2.right));
            var _local_4:Number = ((viewableHeight) ? viewableHeight : ((unscaledHeight - _local_2.top) - _local_2.bottom));
            if (getStyle("backgroundAttachment") == "fixed")
            {
                _local_1.backgroundImageBounds = new Rectangle(_local_2.left, _local_2.top, _local_3, _local_4);
            }
            else
            {
                _local_1.backgroundImageBounds = new Rectangle(_local_2.left, _local_2.top, Math.max(scrollableWidth, _local_3), Math.max(scrollableHeight, _local_4));
            };
        }

        private function blocker_clickHandler(_arg_1:Event):void
        {
            _arg_1.stopPropagation();
        }

        private function mouseWheelHandler(_arg_1:MouseEvent):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:Number;
            var _local_5:Number;
            if (verticalScrollBar)
            {
                _arg_1.stopPropagation();
                _local_2 = ((_arg_1.delta <= 0) ? 1 : -1);
                _local_3 = ((verticalScrollBar) ? verticalScrollBar.lineScrollSize : 1);
                _local_4 = Math.max(Math.abs(_arg_1.delta), _local_3);
                _local_5 = verticalScrollPosition;
                verticalScrollPosition = (verticalScrollPosition + ((3 * _local_4) * _local_2));
                dispatchScrollEvent(ScrollEventDirection.VERTICAL, _local_5, verticalScrollPosition, ((_arg_1.delta <= 0) ? ScrollEventDetail.LINE_UP : ScrollEventDetail.LINE_DOWN));
            };
        }

        public function get defaultButton():IFlexDisplayObject
        {
            return (_defaultButton);
        }

        mx_internal function createContentPane():void
        {
            var _local_3:int;
            var _local_5:IUIComponent;
            if (contentPane)
            {
                return;
            };
            creatingContentPane = true;
            var _local_1:int = numChildren;
            var _local_2:Sprite = new FlexSprite();
            _local_2.name = "contentPane";
            _local_2.tabChildren = true;
            if (border)
            {
                _local_3 = (rawChildren.getChildIndex(DisplayObject(border)) + 1);
                if (((border is IRectangularBorder) && (IRectangularBorder(border).hasBackgroundImage)))
                {
                    _local_3++;
                };
            }
            else
            {
                _local_3 = 0;
            };
            rawChildren.addChildAt(_local_2, _local_3);
            var _local_4:int;
            while (_local_4 < _local_1)
            {
                _local_5 = IUIComponent(super.getChildAt(_firstChildIndex));
                _local_2.addChild(DisplayObject(_local_5));
                _local_5.parentChanged(_local_2);
                _numChildren--;
                _local_4++;
            };
            contentPane = _local_2;
            creatingContentPane = false;
            contentPane.visible = true;
        }

        public function set verticalPageScrollSize(_arg_1:Number):void
        {
            scrollPropertiesChanged = true;
            _verticalPageScrollSize = _arg_1;
            invalidateDisplayList();
            dispatchEvent(new Event("verticalPageScrollSizeChanged"));
        }

        mx_internal function setDocumentDescriptor(_arg_1:UIComponentDescriptor):void
        {
            var _local_2:String;
            if (processedDescriptors)
            {
                return;
            };
            if (((_documentDescriptor) && (_documentDescriptor.properties.childDescriptors)))
            {
                if (_arg_1.properties.childDescriptors)
                {
                    _local_2 = resourceManager.getString("core", "multipleChildSets_ClassAndSubclass");
                    throw (new Error(_local_2));
                };
            }
            else
            {
                _documentDescriptor = _arg_1;
                _documentDescriptor.document = this;
            };
        }

        private function verticalScrollBar_scrollHandler(_arg_1:Event):void
        {
            var _local_2:Number;
            if ((_arg_1 is ScrollEvent))
            {
                _local_2 = verticalScrollPosition;
                verticalScrollPosition = verticalScrollBar.scrollPosition;
                dispatchScrollEvent(ScrollEventDirection.VERTICAL, _local_2, verticalScrollPosition, ScrollEvent(_arg_1).detail);
            };
        }

        public function get creationPolicy():String
        {
            return (_creationPolicy);
        }

        public function set icon(_arg_1:Class):void
        {
            _icon = _arg_1;
            dispatchEvent(new Event("iconChanged"));
        }

        private function dispatchScrollEvent(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:String):void
        {
            var _local_5:ScrollEvent = new ScrollEvent(ScrollEvent.SCROLL);
            _local_5.direction = _arg_1;
            _local_5.position = _arg_3;
            _local_5.delta = (_arg_3 - _arg_2);
            _local_5.detail = _arg_4;
            dispatchEvent(_local_5);
        }

        [Bindable("labelChanged")]
        public function get label():String
        {
            return (_label);
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

        private function creationCompleteHandler(_arg_1:FlexEvent):void
        {
            numChildrenCreated--;
            if (numChildrenCreated <= 0)
            {
                dispatchEvent(new FlexEvent("childrenCreationComplete"));
            };
        }

        override public function contentToLocal(_arg_1:Point):Point
        {
            if (!contentPane)
            {
                return (_arg_1);
            };
            _arg_1 = contentToGlobal(_arg_1);
            return (globalToLocal(_arg_1));
        }

        override public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:int;
            var _local_3:int;
            if (((_arg_1 is IDeferredInstantiationUIComponent) && (IDeferredInstantiationUIComponent(_arg_1).descriptor)))
            {
                if (createdComponents)
                {
                    _local_2 = createdComponents.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        if (createdComponents[_local_3] === _arg_1)
                        {
                            createdComponents.splice(_local_3, 1);
                        };
                        _local_3++;
                    };
                };
            };
            removingChild(_arg_1);
            if (((_arg_1 is UIComponent) && (UIComponent(_arg_1).isDocument)))
            {
                BindingManager.setEnabled(_arg_1, false);
            };
            if (contentPane)
            {
                contentPane.removeChild(_arg_1);
            }
            else
            {
                $removeChild(_arg_1);
            };
            childRemoved(_arg_1);
            return (_arg_1);
        }

        final mx_internal function get $numChildren():int
        {
            return (super.numChildren);
        }

        mx_internal function get numRepeaters():int
        {
            return ((childRepeaters) ? childRepeaters.length : 0);
        }

        mx_internal function set numChildrenCreated(_arg_1:int):void
        {
            _numChildrenCreated = _arg_1;
        }

        public function get creatingContentPane():Boolean
        {
            return (_creatingContentPane);
        }

        public function get clipContent():Boolean
        {
            return (_clipContent);
        }

        mx_internal function rawChildren_getChildIndex(_arg_1:DisplayObject):int
        {
            return (super.getChildIndex(_arg_1));
        }

        override public function regenerateStyleCache(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:DisplayObject;
            super.regenerateStyleCache(_arg_1);
            if (contentPane)
            {
                _local_2 = contentPane.numChildren;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = getChildAt(_local_3);
                    if (((_arg_1) && (_local_4 is UIComponent)))
                    {
                        if (UIComponent(_local_4).inheritingStyles != UIComponent.STYLE_UNINITIALIZED)
                        {
                            UIComponent(_local_4).regenerateStyleCache(_arg_1);
                        };
                    }
                    else
                    {
                        if (((_local_4 is IUITextField) && (IUITextField(_local_4).inheritingStyles)))
                        {
                            StyleProtoChain.initTextField(IUITextField(_local_4));
                        };
                    };
                    _local_3++;
                };
            };
        }

        override public function getChildIndex(_arg_1:DisplayObject):int
        {
            var _local_2:int;
            if (contentPane)
            {
                return (contentPane.getChildIndex(_arg_1));
            };
            return (super.getChildIndex(_arg_1) - _firstChildIndex);
        }

        mx_internal function rawChildren_contains(_arg_1:DisplayObject):Boolean
        {
            return (super.contains(_arg_1));
        }

        mx_internal function getScrollableRect():Rectangle
        {
            var _local_9:DisplayObject;
            var _local_1:Number = 0;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:int = numChildren;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_9 = getChildAt(_local_6);
                if (!((_local_9 is IUIComponent) && (!(IUIComponent(_local_9).includeInLayout))))
                {
                    _local_1 = Math.min(_local_1, _local_9.x);
                    _local_2 = Math.min(_local_2, _local_9.y);
                    if (!isNaN(_local_9.width))
                    {
                        _local_3 = Math.max(_local_3, (_local_9.x + _local_9.width));
                    };
                    if (!isNaN(_local_9.height))
                    {
                        _local_4 = Math.max(_local_4, (_local_9.y + _local_9.height));
                    };
                };
                _local_6++;
            };
            var _local_7:EdgeMetrics = viewMetrics;
            var _local_8:Rectangle = new Rectangle();
            _local_8.left = _local_1;
            _local_8.top = _local_2;
            _local_8.right = _local_3;
            _local_8.bottom = _local_4;
            if (usePadding)
            {
                _local_8.right = (_local_8.right + getStyle("paddingRight"));
                _local_8.bottom = (_local_8.bottom + getStyle("paddingBottom"));
            };
            return (_local_8);
        }

        override protected function createChildren():void
        {
            var _local_1:Application;
            super.createChildren();
            createBorder();
            createOrDestroyScrollbars((horizontalScrollPolicy == ScrollPolicy.ON), (verticalScrollPolicy == ScrollPolicy.ON), ((horizontalScrollPolicy == ScrollPolicy.ON) || (verticalScrollPolicy == ScrollPolicy.ON)));
            if (creationPolicy != null)
            {
                actualCreationPolicy = creationPolicy;
            }
            else
            {
                if ((parent is Container))
                {
                    if (Container(parent).actualCreationPolicy == ContainerCreationPolicy.QUEUED)
                    {
                        actualCreationPolicy = ContainerCreationPolicy.AUTO;
                    }
                    else
                    {
                        actualCreationPolicy = Container(parent).actualCreationPolicy;
                    };
                };
            };
            if (actualCreationPolicy == ContainerCreationPolicy.NONE)
            {
                actualCreationPolicy = ContainerCreationPolicy.AUTO;
            }
            else
            {
                if (actualCreationPolicy == ContainerCreationPolicy.QUEUED)
                {
                    _local_1 = ((parentApplication) ? Application(parentApplication) : Application(Application.application));
                    _local_1.addToCreationQueue(this, creationIndex, null, this);
                }
                else
                {
                    if (recursionFlag)
                    {
                        createComponentsFromDescriptors();
                    };
                };
            };
            if (autoLayout == false)
            {
                forceLayout = true;
            };
            UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler, false, 0, true);
        }

        override public function executeBindings(_arg_1:Boolean=false):void
        {
            var _local_2:Object = (((descriptor) && (descriptor.document)) ? descriptor.document : parentDocument);
            BindingManager.executeBindings(_local_2, id, this);
            if (_arg_1)
            {
                executeChildBindings(_arg_1);
            };
        }

        override public function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:int = _local_3;
            var _local_5:int = _arg_2;
            if (contentPane)
            {
                contentPane.setChildIndex(_arg_1, _arg_2);
                if (((_autoLayout) || (forceLayout)))
                {
                    invalidateDisplayList();
                };
            }
            else
            {
                _local_3 = super.getChildIndex(_arg_1);
                _arg_2 = (_arg_2 + _firstChildIndex);
                if (_arg_2 == _local_3)
                {
                    return;
                };
                super.setChildIndex(_arg_1, _arg_2);
                invalidateDisplayList();
                _local_4 = (_local_3 - _firstChildIndex);
                _local_5 = (_arg_2 - _firstChildIndex);
            };
            var _local_6:IndexChangedEvent = new IndexChangedEvent(IndexChangedEvent.CHILD_INDEX_CHANGE);
            _local_6.relatedObject = _arg_1;
            _local_6.oldIndex = _local_4;
            _local_6.newIndex = _local_5;
            dispatchEvent(_local_6);
            dispatchEvent(new Event("childrenChanged"));
        }

        override public function globalToContent(_arg_1:Point):Point
        {
            if (contentPane)
            {
                return (contentPane.globalToLocal(_arg_1));
            };
            return (globalToLocal(_arg_1));
        }

        mx_internal function rawChildren_removeChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:int = rawChildren_getChildIndex(_arg_1);
            return (rawChildren_removeChildAt(_local_2));
        }

        mx_internal function rawChildren_setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            var _local_3:int = super.getChildIndex(_arg_1);
            super.setChildIndex(_arg_1, _arg_2);
            if (((_local_3 < _firstChildIndex) && (_arg_2 >= _firstChildIndex)))
            {
                _firstChildIndex--;
            }
            else
            {
                if (((_local_3 >= _firstChildIndex) && (_arg_2 <= _firstChildIndex)))
                {
                    _firstChildIndex++;
                };
            };
            dispatchEvent(new Event("childrenChanged"));
        }

        public function set verticalLineScrollSize(_arg_1:Number):void
        {
            scrollPropertiesChanged = true;
            _verticalLineScrollSize = _arg_1;
            invalidateDisplayList();
            dispatchEvent(new Event("verticalLineScrollSizeChanged"));
        }

        mx_internal function rawChildren_getChildAt(_arg_1:int):DisplayObject
        {
            return (super.getChildAt(_arg_1));
        }

        public function get creationIndex():int
        {
            return (_creationIndex);
        }

        public function get verticalScrollBar():ScrollBar
        {
            return (_verticalScrollBar);
        }

        public function get viewMetricsAndPadding():EdgeMetrics
        {
            if ((((_viewMetricsAndPadding) && ((!(horizontalScrollBar)) || (horizontalScrollPolicy == ScrollPolicy.ON))) && ((!(verticalScrollBar)) || (verticalScrollPolicy == ScrollPolicy.ON))))
            {
                return (_viewMetricsAndPadding);
            };
            if (!_viewMetricsAndPadding)
            {
                _viewMetricsAndPadding = new EdgeMetrics();
            };
            var _local_1:EdgeMetrics = _viewMetricsAndPadding;
            var _local_2:EdgeMetrics = viewMetrics;
            _local_1.left = (_local_2.left + getStyle("paddingLeft"));
            _local_1.right = (_local_2.right + getStyle("paddingRight"));
            _local_1.top = (_local_2.top + getStyle("paddingTop"));
            _local_1.bottom = (_local_2.bottom + getStyle("paddingBottom"));
            return (_local_1);
        }

        override public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            return (addChildAt(_arg_1, numChildren));
        }

        public function set horizontalPageScrollSize(_arg_1:Number):void
        {
            scrollPropertiesChanged = true;
            _horizontalPageScrollSize = _arg_1;
            invalidateDisplayList();
            dispatchEvent(new Event("horizontalPageScrollSizeChanged"));
        }

        override mx_internal function childAdded(_arg_1:DisplayObject):void
        {
            dispatchEvent(new Event("childrenChanged"));
            var _local_2:ChildExistenceChangedEvent = new ChildExistenceChangedEvent(ChildExistenceChangedEvent.CHILD_ADD);
            _local_2.relatedObject = _arg_1;
            dispatchEvent(_local_2);
            _arg_1.dispatchEvent(new FlexEvent(FlexEvent.ADD));
            super.childAdded(_arg_1);
        }

        public function set horizontalScrollPolicy(_arg_1:String):void
        {
            if (_horizontalScrollPolicy != _arg_1)
            {
                _horizontalScrollPolicy = _arg_1;
                invalidateDisplayList();
                dispatchEvent(new Event("horizontalScrollPolicyChanged"));
            };
        }

        private function layoutCompleteHandler(_arg_1:FlexEvent):void
        {
            UIComponentGlobals.layoutManager.removeEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler);
            forceLayout = false;
            var _local_2:Boolean;
            if (!isNaN(horizontalScrollPositionPending))
            {
                if (horizontalScrollPositionPending < 0)
                {
                    horizontalScrollPositionPending = 0;
                }
                else
                {
                    if (horizontalScrollPositionPending > maxHorizontalScrollPosition)
                    {
                        horizontalScrollPositionPending = maxHorizontalScrollPosition;
                    };
                };
                if (((horizontalScrollBar) && (!(horizontalScrollBar.scrollPosition == horizontalScrollPositionPending))))
                {
                    _horizontalScrollPosition = horizontalScrollPositionPending;
                    horizontalScrollBar.scrollPosition = horizontalScrollPositionPending;
                    _local_2 = true;
                };
                horizontalScrollPositionPending = NaN;
            };
            if (!isNaN(verticalScrollPositionPending))
            {
                if (verticalScrollPositionPending < 0)
                {
                    verticalScrollPositionPending = 0;
                }
                else
                {
                    if (verticalScrollPositionPending > maxVerticalScrollPosition)
                    {
                        verticalScrollPositionPending = maxVerticalScrollPosition;
                    };
                };
                if (((verticalScrollBar) && (!(verticalScrollBar.scrollPosition == verticalScrollPositionPending))))
                {
                    _verticalScrollPosition = verticalScrollPositionPending;
                    verticalScrollBar.scrollPosition = verticalScrollPositionPending;
                    _local_2 = true;
                };
                verticalScrollPositionPending = NaN;
            };
            if (_local_2)
            {
                scrollChildren();
            };
        }

        public function createComponentsFromDescriptors(_arg_1:Boolean=true):void
        {
            var _local_4:IFlexDisplayObject;
            numChildrenBefore = numChildren;
            createdComponents = [];
            var _local_2:int = ((childDescriptors) ? childDescriptors.length : 0);
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = createComponentFromDescriptor(childDescriptors[_local_3], _arg_1);
                createdComponents.push(_local_4);
                _local_3++;
            };
            if (((creationPolicy == ContainerCreationPolicy.QUEUED) || (creationPolicy == ContainerCreationPolicy.NONE)))
            {
                UIComponentGlobals.layoutManager.usePhasedInstantiation = false;
            };
            numChildrenCreated = (numChildren - numChildrenBefore);
            processedDescriptors = true;
        }

        override mx_internal function fillOverlay(_arg_1:UIComponent, _arg_2:uint, _arg_3:RoundedRectangle=null):void
        {
            var _local_4:EdgeMetrics = viewMetrics;
            var _local_5:Number = 0;
            if (!_arg_3)
            {
                _arg_3 = new RoundedRectangle(_local_4.left, _local_4.top, ((unscaledWidth - _local_4.right) - _local_4.left), ((unscaledHeight - _local_4.bottom) - _local_4.top), _local_5);
            };
            if ((((((isNaN(_arg_3.x)) || (isNaN(_arg_3.y))) || (isNaN(_arg_3.width))) || (isNaN(_arg_3.height))) || (isNaN(_arg_3.cornerRadius))))
            {
                return;
            };
            var _local_6:Graphics = _arg_1.graphics;
            _local_6.clear();
            _local_6.beginFill(_arg_2);
            _local_6.drawRoundRect(_arg_3.x, _arg_3.y, _arg_3.width, _arg_3.height, (_arg_3.cornerRadius * 2), (_arg_3.cornerRadius * 2));
            _local_6.endFill();
        }

        override public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            super.removeEventListener(_arg_1, _arg_2, _arg_3);
            if (((((((((_arg_1 == MouseEvent.CLICK) || (_arg_1 == MouseEvent.DOUBLE_CLICK)) || (_arg_1 == MouseEvent.MOUSE_DOWN)) || (_arg_1 == MouseEvent.MOUSE_MOVE)) || (_arg_1 == MouseEvent.MOUSE_OVER)) || (_arg_1 == MouseEvent.MOUSE_OUT)) || (_arg_1 == MouseEvent.MOUSE_UP)) || (_arg_1 == MouseEvent.MOUSE_WHEEL)))
            {
                if (((mouseEventReferenceCount > 0) && (--mouseEventReferenceCount == 0)))
                {
                    setStyle("mouseShield", false);
                    setStyle("mouseShieldChildren", false);
                };
            };
        }

        mx_internal function rawChildren_removeChildAt(_arg_1:int):DisplayObject
        {
            var _local_2:DisplayObject = super.getChildAt(_arg_1);
            super.removingChild(_local_2);
            $removeChildAt(_arg_1);
            super.childRemoved(_local_2);
            if (((_firstChildIndex < _arg_1) && (_arg_1 < (_firstChildIndex + _numChildren))))
            {
                _numChildren--;
            }
            else
            {
                if (((_numChildren == 0) || (_arg_1 < _firstChildIndex)))
                {
                    _firstChildIndex--;
                };
            };
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("childrenChanged"));
            return (_local_2);
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            invalidateDisplayList();
        }

        override public function removeChildAt(_arg_1:int):DisplayObject
        {
            return (removeChild(getChildAt(_arg_1)));
        }

        private function isBorderNeeded():Boolean
        {
            var c:Class = getStyle("borderSkin");
            try
            {
                if (c != getDefinitionByName("mx.skins.halo::HaloBorder"))
                {
                    return (true);
                };
            }
            catch(e:Error)
            {
                return (true);
            };
            var v:Object = getStyle("borderStyle");
            if (v)
            {
                if (((!(v == "none")) || ((v == "none") && (getStyle("mouseShield")))))
                {
                    return (true);
                };
            };
            v = getStyle("backgroundColor");
            if (((!(v === null)) && (!(v === ""))))
            {
                return (true);
            };
            v = getStyle("backgroundImage");
            return ((!(v == null)) && (!(v == "")));
        }

        public function set autoLayout(_arg_1:Boolean):void
        {
            var _local_2:IInvalidating;
            _autoLayout = _arg_1;
            if (_arg_1)
            {
                invalidateSize();
                invalidateDisplayList();
                _local_2 = (parent as IInvalidating);
                if (_local_2)
                {
                    _local_2.invalidateSize();
                    _local_2.invalidateDisplayList();
                };
            };
        }

        [Bindable("verticalPageScrollSizeChanged")]
        public function get verticalPageScrollSize():Number
        {
            return (_verticalPageScrollSize);
        }

        [Bindable("childrenChanged")]
        public function getChildren():Array
        {
            var _local_1:Array = [];
            var _local_2:int = numChildren;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_1.push(getChildAt(_local_3));
                _local_3++;
            };
            return (_local_1);
        }

        override public function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            var _local_3:DisplayObjectContainer = _arg_1.parent;
            if (((_local_3) && (!(_local_3 is Loader))))
            {
                if (_local_3 == this)
                {
                    _arg_2 = ((_arg_2 == numChildren) ? (_arg_2 - 1) : _arg_2);
                };
                _local_3.removeChild(_arg_1);
            };
            addingChild(_arg_1);
            if (contentPane)
            {
                contentPane.addChildAt(_arg_1, _arg_2);
            }
            else
            {
                $addChildAt(_arg_1, (_firstChildIndex + _arg_2));
            };
            childAdded(_arg_1);
            if (((_arg_1 is UIComponent) && (UIComponent(_arg_1).isDocument)))
            {
                BindingManager.setEnabled(_arg_1, true);
            };
            return (_arg_1);
        }

        private function createScrollbarsIfNeeded(_arg_1:Rectangle):Boolean
        {
            var _local_2:Number = _arg_1.right;
            var _local_3:Number = _arg_1.bottom;
            var _local_4:Number = unscaledWidth;
            var _local_5:Number = unscaledHeight;
            var _local_6:Boolean = ((_arg_1.left < 0) || (_arg_1.top < 0));
            var _local_7:EdgeMetrics = viewMetrics;
            if (scaleX != 1)
            {
                _local_4 = (_local_4 + (1 / Math.abs(scaleX)));
            };
            if (scaleY != 1)
            {
                _local_5 = (_local_5 + (1 / Math.abs(scaleY)));
            };
            _local_4 = Math.floor(_local_4);
            _local_5 = Math.floor(_local_5);
            _local_2 = Math.floor(_local_2);
            _local_3 = Math.floor(_local_3);
            if (((horizontalScrollBar) && (!(horizontalScrollPolicy == ScrollPolicy.ON))))
            {
                _local_5 = (_local_5 - horizontalScrollBar.minHeight);
            };
            if (((verticalScrollBar) && (!(verticalScrollPolicy == ScrollPolicy.ON))))
            {
                _local_4 = (_local_4 - verticalScrollBar.minWidth);
            };
            _local_4 = (_local_4 - (_local_7.left + _local_7.right));
            _local_5 = (_local_5 - (_local_7.top + _local_7.bottom));
            var _local_8:* = (horizontalScrollPolicy == ScrollPolicy.ON);
            var _local_9:* = (verticalScrollPolicy == ScrollPolicy.ON);
            var _local_10:Boolean = ((((((_local_8) || (_local_9)) || (_local_6)) || (!(overlay == null))) || (_local_7.left > 0)) || (_local_7.top > 0));
            if (_local_4 < _local_2)
            {
                _local_10 = true;
                if ((((horizontalScrollPolicy == ScrollPolicy.AUTO) && (((unscaledHeight - _local_7.top) - _local_7.bottom) >= 18)) && (((unscaledWidth - _local_7.left) - _local_7.right) >= 32)))
                {
                    _local_8 = true;
                };
            };
            if (_local_5 < _local_3)
            {
                _local_10 = true;
                if ((((verticalScrollPolicy == ScrollPolicy.AUTO) && (((unscaledWidth - _local_7.left) - _local_7.right) >= 18)) && (((unscaledHeight - _local_7.top) - _local_7.bottom) >= 32)))
                {
                    _local_9 = true;
                };
            };
            if (((((((((_local_8) && (_local_9)) && (horizontalScrollPolicy == ScrollPolicy.AUTO)) && (verticalScrollPolicy == ScrollPolicy.AUTO)) && (horizontalScrollBar)) && (verticalScrollBar)) && ((_local_4 + verticalScrollBar.minWidth) >= _local_2)) && ((_local_5 + horizontalScrollBar.minHeight) >= _local_3)))
            {
                _local_8 = (_local_9 = false);
            }
            else
            {
                if ((((((_local_8) && (!(_local_9))) && (verticalScrollBar)) && (horizontalScrollPolicy == ScrollPolicy.AUTO)) && ((_local_4 + verticalScrollBar.minWidth) >= _local_2)))
                {
                    _local_8 = false;
                };
            };
            var _local_11:Boolean = createOrDestroyScrollbars(_local_8, _local_9, _local_10);
            if ((((!(scrollableWidth == _local_2)) || (!(viewableWidth == _local_4))) || (_local_11)))
            {
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.setScrollProperties(_local_4, 0, (_local_2 - _local_4), horizontalPageScrollSize);
                    scrollPositionChanged = true;
                };
                viewableWidth = _local_4;
                scrollableWidth = _local_2;
            };
            if ((((!(scrollableHeight == _local_3)) || (!(viewableHeight == _local_5))) || (_local_11)))
            {
                if (verticalScrollBar)
                {
                    verticalScrollBar.setScrollProperties(_local_5, 0, (_local_3 - _local_5), verticalPageScrollSize);
                    scrollPositionChanged = true;
                };
                viewableHeight = _local_5;
                scrollableHeight = _local_3;
            };
            return (_local_11);
        }

        override mx_internal function removingChild(_arg_1:DisplayObject):void
        {
            super.removingChild(_arg_1);
            _arg_1.dispatchEvent(new FlexEvent(FlexEvent.REMOVE));
            var _local_2:ChildExistenceChangedEvent = new ChildExistenceChangedEvent(ChildExistenceChangedEvent.CHILD_REMOVE);
            _local_2.relatedObject = _arg_1;
            dispatchEvent(_local_2);
        }

        mx_internal function get numChildrenCreated():int
        {
            return (_numChildrenCreated);
        }

        private function hasChildMatchingDescriptor(_arg_1:UIComponentDescriptor):Boolean
        {
            var _local_4:int;
            var _local_5:IUIComponent;
            var _local_2:String = _arg_1.id;
            if ((((!(_local_2 == null)) && (_local_2 in document)) && (document[_local_2] == null)))
            {
                return (false);
            };
            var _local_3:int = numChildren;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = IUIComponent(getChildAt(_local_4));
                if (((_local_5 is IDeferredInstantiationUIComponent) && (IDeferredInstantiationUIComponent(_local_5).descriptor == _arg_1)))
                {
                    return (true);
                };
                _local_4++;
            };
            if (childRepeaters)
            {
                _local_3 = childRepeaters.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    if (IDeferredInstantiationUIComponent(childRepeaters[_local_4]).descriptor == _arg_1)
                    {
                        return (true);
                    };
                    _local_4++;
                };
            };
            return (false);
        }

        mx_internal function rawChildren_getChildByName(_arg_1:String):DisplayObject
        {
            return (super.getChildByName(_arg_1));
        }

        override public function validateDisplayList():void
        {
            var _local_1:EdgeMetrics;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Object;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            if (((_autoLayout) || (forceLayout)))
            {
                doingLayout = true;
                super.validateDisplayList();
                doingLayout = false;
            }
            else
            {
                layoutChrome(unscaledWidth, unscaledHeight);
            };
            invalidateDisplayListFlag = true;
            if (createContentPaneAndScrollbarsIfNeeded())
            {
                if (((_autoLayout) || (forceLayout)))
                {
                    doingLayout = true;
                    super.validateDisplayList();
                    doingLayout = false;
                };
                createContentPaneAndScrollbarsIfNeeded();
            };
            if (clampScrollPositions())
            {
                scrollChildren();
            };
            if (contentPane)
            {
                _local_1 = viewMetrics;
                if (overlay)
                {
                    overlay.x = 0;
                    overlay.y = 0;
                    overlay.width = unscaledWidth;
                    overlay.height = unscaledHeight;
                };
                if (((horizontalScrollBar) || (verticalScrollBar)))
                {
                    if (((verticalScrollBar) && (verticalScrollPolicy == ScrollPolicy.ON)))
                    {
                        _local_1.right = (_local_1.right - verticalScrollBar.minWidth);
                    };
                    if (((horizontalScrollBar) && (horizontalScrollPolicy == ScrollPolicy.ON)))
                    {
                        _local_1.bottom = (_local_1.bottom - horizontalScrollBar.minHeight);
                    };
                    if (horizontalScrollBar)
                    {
                        _local_2 = ((unscaledWidth - _local_1.left) - _local_1.right);
                        if (verticalScrollBar)
                        {
                            _local_2 = (_local_2 - verticalScrollBar.minWidth);
                        };
                        horizontalScrollBar.setActualSize(_local_2, horizontalScrollBar.minHeight);
                        horizontalScrollBar.move(_local_1.left, ((unscaledHeight - _local_1.bottom) - horizontalScrollBar.minHeight));
                    };
                    if (verticalScrollBar)
                    {
                        _local_3 = ((unscaledHeight - _local_1.top) - _local_1.bottom);
                        if (horizontalScrollBar)
                        {
                            _local_3 = (_local_3 - horizontalScrollBar.minHeight);
                        };
                        verticalScrollBar.setActualSize(verticalScrollBar.minWidth, _local_3);
                        verticalScrollBar.move(((unscaledWidth - _local_1.right) - verticalScrollBar.minWidth), _local_1.top);
                    };
                    if (whiteBox)
                    {
                        whiteBox.x = verticalScrollBar.x;
                        whiteBox.y = horizontalScrollBar.y;
                    };
                };
                contentPane.x = _local_1.left;
                contentPane.y = _local_1.top;
                if (focusPane)
                {
                    focusPane.x = _local_1.left;
                    focusPane.y = _local_1.top;
                };
                scrollChildren();
            };
            invalidateDisplayListFlag = false;
            if (blocker)
            {
                _local_1 = viewMetrics;
                _local_4 = ((enabled) ? null : getStyle("backgroundDisabledColor"));
                if (((_local_4 === null) || (isNaN(Number(_local_4)))))
                {
                    _local_4 = getStyle("backgroundColor");
                };
                if (((_local_4 === null) || (isNaN(Number(_local_4)))))
                {
                    _local_4 = 0xFFFFFF;
                };
                _local_5 = getStyle("disabledOverlayAlpha");
                if (isNaN(_local_5))
                {
                    _local_5 = 0.6;
                };
                blocker.x = _local_1.left;
                blocker.y = _local_1.top;
                _local_6 = (unscaledWidth - (_local_1.left + _local_1.right));
                _local_7 = (unscaledHeight - (_local_1.top + _local_1.bottom));
                blocker.graphics.clear();
                blocker.graphics.beginFill(uint(_local_4), _local_5);
                blocker.graphics.drawRect(0, 0, _local_6, _local_7);
                blocker.graphics.endFill();
                rawChildren.setChildIndex(blocker, (rawChildren.numChildren - 1));
            };
        }

        public function set horizontalLineScrollSize(_arg_1:Number):void
        {
            scrollPropertiesChanged = true;
            _horizontalLineScrollSize = _arg_1;
            invalidateDisplayList();
            dispatchEvent(new Event("horizontalLineScrollSizeChanged"));
        }

        mx_internal function rawChildren_addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            if (((_firstChildIndex < _arg_2) && (_arg_2 < ((_firstChildIndex + _numChildren) + 1))))
            {
                _numChildren++;
            }
            else
            {
                if (_arg_2 <= _firstChildIndex)
                {
                    _firstChildIndex++;
                };
            };
            super.addingChild(_arg_1);
            $addChildAt(_arg_1, _arg_2);
            super.childAdded(_arg_1);
            dispatchEvent(new Event("childrenChanged"));
            return (_arg_1);
        }

        override public function initialize():void
        {
            var _local_1:*;
            var _local_2:String;
            if ((((isDocument) && (documentDescriptor)) && (!(processedDescriptors))))
            {
                _local_1 = documentDescriptor.properties;
                if (((_local_1) && (_local_1.childDescriptors)))
                {
                    if (_childDescriptors)
                    {
                        _local_2 = resourceManager.getString("core", "multipleChildSets_ClassAndInstance");
                        throw (new Error(_local_2));
                    };
                    _childDescriptors = _local_1.childDescriptors;
                };
            };
            super.initialize();
        }

        mx_internal function set forceClipping(_arg_1:Boolean):void
        {
            if (_clipContent)
            {
                if (_arg_1)
                {
                    _forceClippingCount++;
                }
                else
                {
                    _forceClippingCount--;
                };
                createContentPane();
                scrollChildren();
            };
        }

        public function removeAllChildren():void
        {
            while (numChildren > 0)
            {
                removeChildAt(0);
            };
        }

        override public function contentToGlobal(_arg_1:Point):Point
        {
            if (contentPane)
            {
                return (contentPane.localToGlobal(_arg_1));
            };
            return (localToGlobal(_arg_1));
        }

        [Bindable("horizontalPageScrollSizeChanged")]
        public function get horizontalPageScrollSize():Number
        {
            return (_horizontalPageScrollSize);
        }

        override mx_internal function childRemoved(_arg_1:DisplayObject):void
        {
            super.childRemoved(_arg_1);
            invalidateSize();
            invalidateDisplayList();
            if (!contentPane)
            {
                _numChildren--;
                if (_numChildren == 0)
                {
                    _firstChildIndex = super.numChildren;
                };
            };
            if (((contentPane) && (!(autoLayout))))
            {
                forceLayout = true;
                UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler, false, 0, true);
            };
            dispatchEvent(new Event("childrenChanged"));
        }

        public function set defaultButton(_arg_1:IFlexDisplayObject):void
        {
            _defaultButton = _arg_1;
            ContainerGlobals.focusedContainer = null;
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        override public function get numChildren():int
        {
            return ((contentPane) ? contentPane.numChildren : _numChildren);
        }

        public function get autoLayout():Boolean
        {
            return (_autoLayout);
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_2:Boolean = ((_arg_1 == null) || (_arg_1 == "styleName"));
            if (((_local_2) || (StyleManager.isSizeInvalidatingStyle(_arg_1))))
            {
                invalidateDisplayList();
            };
            if (((_local_2) || (_arg_1 == "borderSkin")))
            {
                if (border)
                {
                    rawChildren.removeChild(DisplayObject(border));
                    border = null;
                    createBorder();
                };
            };
            if (((((((_local_2) || (_arg_1 == "borderStyle")) || (_arg_1 == "backgroundColor")) || (_arg_1 == "backgroundImage")) || (_arg_1 == "mouseShield")) || (_arg_1 == "mouseShieldChildren")))
            {
                createBorder();
            };
            super.styleChanged(_arg_1);
            if (((_local_2) || (StyleManager.isSizeInvalidatingStyle(_arg_1))))
            {
                invalidateViewMetricsAndPadding();
            };
            if (((_local_2) || (_arg_1 == "horizontalScrollBarStyleName")))
            {
                if (((horizontalScrollBar) && (horizontalScrollBar is ISimpleStyleClient)))
                {
                    _local_3 = getStyle("horizontalScrollBarStyleName");
                    ISimpleStyleClient(horizontalScrollBar).styleName = _local_3;
                };
            };
            if (((_local_2) || (_arg_1 == "verticalScrollBarStyleName")))
            {
                if (((verticalScrollBar) && (verticalScrollBar is ISimpleStyleClient)))
                {
                    _local_4 = getStyle("verticalScrollBarStyleName");
                    ISimpleStyleClient(verticalScrollBar).styleName = _local_4;
                };
            };
        }

        override protected function commitProperties():void
        {
            var _local_1:String;
            super.commitProperties();
            if (changedStyles)
            {
                _local_1 = ((changedStyles == MULTIPLE_PROPERTIES) ? null : changedStyles);
                super.notifyStyleChangeInChildren(_local_1, true);
                changedStyles = null;
            };
            createOrDestroyBlocker();
        }

        override public function finishPrint(_arg_1:Object, _arg_2:IFlexDisplayObject):void
        {
            if (_arg_1)
            {
                contentPane.scrollRect = Rectangle(_arg_1);
            };
            super.finishPrint(_arg_1, _arg_2);
        }

        public function get maxHorizontalScrollPosition():Number
        {
            return ((horizontalScrollBar) ? horizontalScrollBar.maxScrollPosition : Math.max((scrollableWidth - viewableWidth), 0));
        }

        public function set creationPolicy(_arg_1:String):void
        {
            _creationPolicy = _arg_1;
            setActualCreationPolicies(_arg_1);
        }

        public function set label(_arg_1:String):void
        {
            _label = _arg_1;
            dispatchEvent(new Event("labelChanged"));
        }

        private function clampScrollPositions():Boolean
        {
            var _local_1:Boolean;
            if (_horizontalScrollPosition < 0)
            {
                _horizontalScrollPosition = 0;
                _local_1 = true;
            }
            else
            {
                if (_horizontalScrollPosition > maxHorizontalScrollPosition)
                {
                    _horizontalScrollPosition = maxHorizontalScrollPosition;
                    _local_1 = true;
                };
            };
            if (((horizontalScrollBar) && (!(horizontalScrollBar.scrollPosition == _horizontalScrollPosition))))
            {
                horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
            };
            if (_verticalScrollPosition < 0)
            {
                _verticalScrollPosition = 0;
                _local_1 = true;
            }
            else
            {
                if (_verticalScrollPosition > maxVerticalScrollPosition)
                {
                    _verticalScrollPosition = maxVerticalScrollPosition;
                    _local_1 = true;
                };
            };
            if (((verticalScrollBar) && (!(verticalScrollBar.scrollPosition == _verticalScrollPosition))))
            {
                verticalScrollBar.scrollPosition = _verticalScrollPosition;
            };
            return (_local_1);
        }

        override public function prepareToPrint(_arg_1:IFlexDisplayObject):Object
        {
            var _local_2:Rectangle = (((contentPane) && (contentPane.scrollRect)) ? contentPane.scrollRect : null);
            if (_local_2)
            {
                contentPane.scrollRect = null;
            };
            super.prepareToPrint(_arg_1);
            return (_local_2);
        }

        mx_internal function get firstChildIndex():int
        {
            return (_firstChildIndex);
        }

        mx_internal function rawChildren_addChild(_arg_1:DisplayObject):DisplayObject
        {
            if (_numChildren == 0)
            {
                _firstChildIndex++;
            };
            super.addingChild(_arg_1);
            $addChild(_arg_1);
            super.childAdded(_arg_1);
            dispatchEvent(new Event("childrenChanged"));
            return (_arg_1);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Object;
            var _local_4:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            layoutChrome(_arg_1, _arg_2);
            if (scrollPositionChanged)
            {
                clampScrollPositions();
                scrollChildren();
                scrollPositionChanged = false;
            };
            if (scrollPropertiesChanged)
            {
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.lineScrollSize = horizontalLineScrollSize;
                    horizontalScrollBar.pageScrollSize = horizontalPageScrollSize;
                };
                if (verticalScrollBar)
                {
                    verticalScrollBar.lineScrollSize = verticalLineScrollSize;
                    verticalScrollBar.pageScrollSize = verticalPageScrollSize;
                };
                scrollPropertiesChanged = false;
            };
            if (((contentPane) && (contentPane.scrollRect)))
            {
                _local_3 = ((enabled) ? null : getStyle("backgroundDisabledColor"));
                if (((_local_3 === null) || (isNaN(Number(_local_3)))))
                {
                    _local_3 = getStyle("backgroundColor");
                };
                _local_4 = getStyle("backgroundAlpha");
                if (((((!(_clipContent)) || (isNaN(Number(_local_3)))) || (_local_3 === "")) || ((!((horizontalScrollBar) || (verticalScrollBar))) && (!(cacheAsBitmap)))))
                {
                    _local_3 = null;
                }
                else
                {
                    if (((getStyle("backgroundImage")) || (getStyle("background"))))
                    {
                        _local_3 = null;
                    }
                    else
                    {
                        if (_local_4 != 1)
                        {
                            _local_3 = null;
                        };
                    };
                };
                contentPane.opaqueBackground = _local_3;
                contentPane.cacheAsBitmap = (!(_local_3 == null));
            };
        }

        override mx_internal function addingChild(_arg_1:DisplayObject):void
        {
            var _local_2:IUIComponent = IUIComponent(_arg_1);
            super.addingChild(_arg_1);
            invalidateSize();
            invalidateDisplayList();
            if (!contentPane)
            {
                if (_numChildren == 0)
                {
                    _firstChildIndex = super.numChildren;
                };
                _numChildren++;
            };
            if (((contentPane) && (!(autoLayout))))
            {
                forceLayout = true;
                UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler, false, 0, true);
            };
        }

        mx_internal function setActualCreationPolicies(_arg_1:String):void
        {
            var _local_5:IFlexDisplayObject;
            var _local_6:Container;
            actualCreationPolicy = _arg_1;
            var _local_2:String = _arg_1;
            if (_arg_1 == ContainerCreationPolicy.QUEUED)
            {
                _local_2 = ContainerCreationPolicy.AUTO;
            };
            var _local_3:int = numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = IFlexDisplayObject(getChildAt(_local_4));
                if ((_local_5 is Container))
                {
                    _local_6 = Container(_local_5);
                    if (_local_6.creationPolicy == null)
                    {
                        _local_6.setActualCreationPolicies(_local_2);
                    };
                };
                _local_4++;
            };
        }


    }
}//package mx.core

