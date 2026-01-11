// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.Application

package mx.core
{
    import flash.ui.ContextMenuItem;
    import mx.managers.ILayoutManager;
    import mx.containers.utilityClasses.ApplicationLayout;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import mx.managers.FocusManager;
    import mx.managers.ISystemManager;
    import flash.system.Capabilities;
    import flash.utils.setInterval;
    import flash.external.ExternalInterface;
    import mx.events.FlexEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.effects.EffectManager;
    import flash.display.InteractiveObject;
    import flash.ui.ContextMenu;
    import flash.events.ContextMenuEvent;
    import mx.styles.IStyleClient;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Application extends LayoutContainer 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static var useProgressiveLayout:Boolean = false;

        public var preloader:Object;
        public var pageTitle:String;
        private var resizeWidth:Boolean = true;
        private var _applicationViewMetrics:EdgeMetrics;
        mx_internal var _parameters:Object;
        private var processingCreationQueue:Boolean = false;
        private var resizeHandlerAdded:Boolean = false;
        public var scriptRecursionLimit:int;
        private var preloadObj:Object;
        public var usePreloader:Boolean;
        mx_internal var _url:String;
        private var _viewSourceURL:String;
        public var resetHistory:Boolean = true;
        public var historyManagementEnabled:Boolean = true;
        public var scriptTimeLimit:Number;
        public var frameRate:Number;
        private var creationQueue:Array = [];
        private var resizeHeight:Boolean = true;
        public var controlBar:IUIComponent;
        private var viewSourceCMI:ContextMenuItem;

        public function Application()
        {
            name = "application";
            UIComponentGlobals.layoutManager = ILayoutManager(Singleton.getInstance("mx.managers::ILayoutManager"));
            UIComponentGlobals.layoutManager.usePhasedInstantiation = true;
            if (!ApplicationGlobals.application)
            {
                ApplicationGlobals.application = this;
            };
            super();
            layoutObject = new ApplicationLayout();
            layoutObject.target = this;
            boxLayoutClass = ApplicationLayout;
            showInAutomationHierarchy = true;
        }

        public static function get application():Object
        {
            return (ApplicationGlobals.application);
        }


        public function set viewSourceURL(_arg_1:String):void
        {
            _viewSourceURL = _arg_1;
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            if (controlBar)
            {
                controlBar.enabled = _arg_1;
            };
        }

        override public function prepareToPrint(_arg_1:IFlexDisplayObject):Object
        {
            var _local_2:Object = {};
            if (_arg_1 == this)
            {
                _local_2.width = width;
                _local_2.height = height;
                _local_2.verticalScrollPosition = verticalScrollPosition;
                _local_2.horizontalScrollPosition = horizontalScrollPosition;
                _local_2.horizontalScrollBarVisible = (!(horizontalScrollBar == null));
                _local_2.verticalScrollBarVisible = (!(verticalScrollBar == null));
                _local_2.whiteBoxVisible = (!(whiteBox == null));
                setActualSize(measuredWidth, measuredHeight);
                horizontalScrollPosition = 0;
                verticalScrollPosition = 0;
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.visible = false;
                };
                if (verticalScrollBar)
                {
                    verticalScrollBar.visible = false;
                };
                if (whiteBox)
                {
                    whiteBox.visible = false;
                };
                updateDisplayList(unscaledWidth, unscaledHeight);
            };
            _local_2.scrollRect = super.prepareToPrint(_arg_1);
            return (_local_2);
        }

        override protected function measure():void
        {
            var _local_2:Number;
            super.measure();
            var _local_1:EdgeMetrics = borderMetrics;
            if (((controlBar) && (controlBar.includeInLayout)))
            {
                _local_2 = ((controlBar.getExplicitOrMeasuredWidth() + _local_1.left) + _local_1.right);
                measuredWidth = Math.max(measuredWidth, _local_2);
                measuredMinWidth = Math.max(measuredMinWidth, _local_2);
            };
        }

        override public function getChildIndex(_arg_1:DisplayObject):int
        {
            if (((controlBar) && (_arg_1 == controlBar)))
            {
                return (-1);
            };
            return (super.getChildIndex(_arg_1));
        }

        private function resizeHandler(_arg_1:Event):void
        {
            var _local_2:Number;
            var _local_3:Number;
            if (resizeWidth)
            {
                if (isNaN(percentWidth))
                {
                    _local_2 = DisplayObject(systemManager).width;
                }
                else
                {
                    super.percentWidth = Math.max(percentWidth, 0);
                    super.percentWidth = Math.min(percentWidth, 100);
                    _local_2 = ((percentWidth * screen.width) / 100);
                };
                if (!isNaN(explicitMaxWidth))
                {
                    _local_2 = Math.min(_local_2, explicitMaxWidth);
                };
                if (!isNaN(explicitMinWidth))
                {
                    _local_2 = Math.max(_local_2, explicitMinWidth);
                };
            }
            else
            {
                _local_2 = width;
            };
            if (resizeHeight)
            {
                if (isNaN(percentHeight))
                {
                    _local_3 = DisplayObject(systemManager).height;
                }
                else
                {
                    super.percentHeight = Math.max(percentHeight, 0);
                    super.percentHeight = Math.min(percentHeight, 100);
                    _local_3 = ((percentHeight * screen.height) / 100);
                };
                if (!isNaN(explicitMaxHeight))
                {
                    _local_3 = Math.min(_local_3, explicitMaxHeight);
                };
                if (!isNaN(explicitMinHeight))
                {
                    _local_3 = Math.max(_local_3, explicitMinHeight);
                };
            }
            else
            {
                _local_3 = height;
            };
            if (((!(_local_2 == width)) || (!(_local_3 == height))))
            {
                invalidateProperties();
                invalidateSize();
            };
            setActualSize(_local_2, _local_3);
            invalidateDisplayList();
        }

        private function initManagers(_arg_1:ISystemManager):void
        {
            if (_arg_1.isTopLevel())
            {
                focusManager = new FocusManager(this);
                _arg_1.activate(this);
            };
        }

        override public function initialize():void
        {
            var _local_2:Object;
            var _local_1:ISystemManager = systemManager;
            _url = _local_1.loaderInfo.url;
            _parameters = _local_1.loaderInfo.parameters;
            initManagers(_local_1);
            _descriptor = null;
            if (documentDescriptor)
            {
                creationPolicy = documentDescriptor.properties.creationPolicy;
                if (((creationPolicy == null) || (creationPolicy.length == 0)))
                {
                    creationPolicy = ContainerCreationPolicy.AUTO;
                };
                _local_2 = documentDescriptor.properties;
                if (_local_2.width != null)
                {
                    width = _local_2.width;
                    delete _local_2.width;
                };
                if (_local_2.height != null)
                {
                    height = _local_2.height;
                    delete _local_2.height;
                };
                documentDescriptor.events = null;
            };
            initContextMenu();
            super.initialize();
            addEventListener(Event.ADDED, addedHandler);
            if (((_local_1.isTopLevelRoot()) && (Capabilities.isDebugger == true)))
            {
                setInterval(debugTickler, 1500);
            };
        }

        override public function set percentHeight(_arg_1:Number):void
        {
            super.percentHeight = _arg_1;
            invalidateDisplayList();
        }

        override public function set percentWidth(_arg_1:Number):void
        {
            super.percentWidth = _arg_1;
            invalidateDisplayList();
        }

        override public function get id():String
        {
            if ((((!(super.id)) && (this == Application.application)) && (ExternalInterface.available)))
            {
                return (ExternalInterface.objectID);
            };
            return (super.id);
        }

        override mx_internal function setUnscaledWidth(_arg_1:Number):void
        {
            invalidateProperties();
            super.setUnscaledWidth(_arg_1);
        }

        private function doNextQueueItem(_arg_1:FlexEvent=null):void
        {
            processingCreationQueue = true;
            Application.useProgressiveLayout = true;
            callLater(processNextQueueItem);
        }

        private function addedHandler(_arg_1:Event):void
        {
            if (((_arg_1.target == this) && (creationQueue.length > 0)))
            {
                doNextQueueItem();
            };
        }

        public function get viewSourceURL():String
        {
            return (_viewSourceURL);
        }

        override mx_internal function get usePadding():Boolean
        {
            return (!(layout == ContainerLayout.ABSOLUTE));
        }

        override mx_internal function setUnscaledHeight(_arg_1:Number):void
        {
            invalidateProperties();
            super.setUnscaledHeight(_arg_1);
        }

        private function debugTickler():void
        {
            var _local_1:int;
        }

        override public function styleChanged(_arg_1:String):void
        {
            super.styleChanged(_arg_1);
            if (((_arg_1 == "backgroundColor") && (getStyle("backgroundImage") == getStyle("defaultBackgroundImage"))))
            {
                clearStyle("backgroundImage");
            };
        }

        override protected function layoutChrome(_arg_1:Number, _arg_2:Number):void
        {
            super.layoutChrome(_arg_1, _arg_2);
            if (!doingLayout)
            {
                createBorder();
            };
            var _local_3:EdgeMetrics = borderMetrics;
            var _local_4:Number = getStyle("borderThickness");
            var _local_5:EdgeMetrics = new EdgeMetrics();
            _local_5.left = (_local_3.left - _local_4);
            _local_5.top = (_local_3.top - _local_4);
            _local_5.right = (_local_3.right - _local_4);
            _local_5.bottom = (_local_3.bottom - _local_4);
            if (((controlBar) && (controlBar.includeInLayout)))
            {
                if ((controlBar is IInvalidating))
                {
                    IInvalidating(controlBar).invalidateDisplayList();
                };
                controlBar.setActualSize((width - (_local_5.left + _local_5.right)), controlBar.getExplicitOrMeasuredHeight());
                controlBar.move(_local_5.left, _local_5.top);
            };
        }

        protected function menuItemSelectHandler(_arg_1:Event):void
        {
            navigateToURL(new URLRequest(_viewSourceURL), "_blank");
        }

        private function printCreationQueue():void
        {
            var _local_4:Object;
            var _local_1:* = "";
            var _local_2:Number = creationQueue.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = creationQueue[_local_3];
                _local_1 = (_local_1 + (((((" [" + _local_3) + "] ") + _local_4.id) + " ") + _local_4.index));
                _local_3++;
            };
        }

        override protected function resourcesChanged():void
        {
            super.resourcesChanged();
            if (viewSourceCMI)
            {
                viewSourceCMI.caption = resourceManager.getString("core", "viewSource");
            };
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            resizeWidth = isNaN(explicitWidth);
            resizeHeight = isNaN(explicitHeight);
            if (((resizeWidth) || (resizeHeight)))
            {
                resizeHandler(new Event(Event.RESIZE));
                if (!resizeHandlerAdded)
                {
                    systemManager.addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
                    resizeHandlerAdded = true;
                };
            }
            else
            {
                if (resizeHandlerAdded)
                {
                    systemManager.removeEventListener(Event.RESIZE, resizeHandler);
                    resizeHandlerAdded = false;
                };
            };
        }

        override public function set toolTip(_arg_1:String):void
        {
        }

        public function addToCreationQueue(_arg_1:Object, _arg_2:int=-1, _arg_3:Function=null, _arg_4:IFlexDisplayObject=null):void
        {
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_12:int;
            var _local_5:int = creationQueue.length;
            var _local_6:Object = {};
            var _local_7:Boolean;
            _local_6.id = _arg_1;
            _local_6.parent = _arg_4;
            _local_6.callbackFunc = _arg_3;
            _local_6.index = _arg_2;
            var _local_11:int;
            while (_local_11 < _local_5)
            {
                _local_9 = creationQueue[_local_11].index;
                _local_10 = ((creationQueue[_local_11].parent) ? creationQueue[_local_11].parent.nestLevel : 0);
                if (_local_6.index != -1)
                {
                    if (((_local_9 == -1) || (_local_6.index < _local_9)))
                    {
                        _local_8 = _local_11;
                        _local_7 = true;
                        break;
                    };
                }
                else
                {
                    _local_12 = ((_local_6.parent) ? _local_6.parent.nestLevel : 0);
                    if (((_local_9 == -1) && (_local_10 < _local_12)))
                    {
                        _local_8 = _local_11;
                        _local_7 = true;
                        break;
                    };
                };
                _local_11++;
            };
            if (!_local_7)
            {
                creationQueue.push(_local_6);
                _local_7 = true;
            }
            else
            {
                creationQueue.splice(_local_8, 0, _local_6);
            };
            if (((initialized) && (!(processingCreationQueue))))
            {
                doNextQueueItem();
            };
        }

        override mx_internal function initThemeColor():Boolean
        {
            var _local_2:Object;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:CSSStyleDeclaration;
            var _local_1:Boolean = super.initThemeColor();
            if (!_local_1)
            {
                _local_5 = StyleManager.getStyleDeclaration("global");
                if (_local_5)
                {
                    _local_2 = _local_5.getStyle("themeColor");
                    _local_3 = _local_5.getStyle("rollOverColor");
                    _local_4 = _local_5.getStyle("selectionColor");
                };
                if ((((_local_2) && (isNaN(_local_3))) && (isNaN(_local_4))))
                {
                    setThemeColor(_local_2);
                };
                _local_1 = true;
            };
            return (_local_1);
        }

        mx_internal function dockControlBar(controlBar:IUIComponent, dock:Boolean):void
        {
            if (dock)
            {
                try
                {
                    removeChild(DisplayObject(controlBar));
                }
                catch(e:Error)
                {
                    return;
                };
                rawChildren.addChildAt(DisplayObject(controlBar), firstChildIndex);
                setControlBar(controlBar);
            }
            else
            {
                try
                {
                    rawChildren.removeChild(DisplayObject(controlBar));
                }
                catch(e:Error)
                {
                    return;
                };
                setControlBar(null);
                addChildAt(DisplayObject(controlBar), 0);
            };
        }

        override public function get viewMetrics():EdgeMetrics
        {
            if (!_applicationViewMetrics)
            {
                _applicationViewMetrics = new EdgeMetrics();
            };
            var _local_1:EdgeMetrics = _applicationViewMetrics;
            var _local_2:EdgeMetrics = super.viewMetrics;
            var _local_3:Number = getStyle("borderThickness");
            _local_1.left = _local_2.left;
            _local_1.top = _local_2.top;
            _local_1.right = _local_2.right;
            _local_1.bottom = _local_2.bottom;
            if (((controlBar) && (controlBar.includeInLayout)))
            {
                _local_1.top = (_local_1.top - _local_3);
                _local_1.top = (_local_1.top + Math.max(controlBar.getExplicitOrMeasuredHeight(), _local_3));
            };
            return (_local_1);
        }

        override public function finishPrint(_arg_1:Object, _arg_2:IFlexDisplayObject):void
        {
            if (_arg_2 == this)
            {
                setActualSize(_arg_1.width, _arg_1.height);
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.visible = _arg_1.horizontalScrollBarVisible;
                };
                if (verticalScrollBar)
                {
                    verticalScrollBar.visible = _arg_1.verticalScrollBarVisible;
                };
                if (whiteBox)
                {
                    whiteBox.visible = _arg_1.whiteBoxVisible;
                };
                horizontalScrollPosition = _arg_1.horizontalScrollPosition;
                verticalScrollPosition = _arg_1.verticalScrollPosition;
                updateDisplayList(unscaledWidth, unscaledHeight);
            };
            super.finishPrint(_arg_1.scrollRect, _arg_2);
        }

        private function processNextQueueItem():void
        {
            var queueItem:Object;
            var nextChild:IUIComponent;
            if (EffectManager.effectsPlaying.length > 0)
            {
                callLater(processNextQueueItem);
            }
            else
            {
                if (creationQueue.length > 0)
                {
                    queueItem = creationQueue.shift();
                    try
                    {
                        nextChild = ((queueItem.id is String) ? document[queueItem.id] : queueItem.id);
                        if ((nextChild is Container))
                        {
                            Container(nextChild).createComponentsFromDescriptors(true);
                        };
                        if (((nextChild is Container) && (Container(nextChild).creationPolicy == ContainerCreationPolicy.QUEUED)))
                        {
                            doNextQueueItem();
                        }
                        else
                        {
                            nextChild.addEventListener("childrenCreationComplete", doNextQueueItem);
                        };
                    }
                    catch(e:Error)
                    {
                        processNextQueueItem();
                    };
                }
                else
                {
                    processingCreationQueue = false;
                    Application.useProgressiveLayout = false;
                };
            };
        }

        override public function set label(_arg_1:String):void
        {
        }

        public function get parameters():Object
        {
            return (_parameters);
        }

        public function get url():String
        {
            return (_url);
        }

        private function initContextMenu():void
        {
            var _local_2:String;
            if (flexContextMenu != null)
            {
                if ((systemManager is InteractiveObject))
                {
                    InteractiveObject(systemManager).contextMenu = contextMenu;
                };
                return;
            };
            var _local_1:ContextMenu = new ContextMenu();
            _local_1.hideBuiltInItems();
            _local_1.builtInItems.print = true;
            if (_viewSourceURL)
            {
                _local_2 = resourceManager.getString("core", "viewSource");
                viewSourceCMI = new ContextMenuItem(_local_2, true);
                viewSourceCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
                _local_1.customItems.push(viewSourceCMI);
            };
            contextMenu = _local_1;
            if ((systemManager is InteractiveObject))
            {
                InteractiveObject(systemManager).contextMenu = _local_1;
            };
        }

        override public function set icon(_arg_1:Class):void
        {
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            createBorder();
        }

        private function setControlBar(_arg_1:IUIComponent):void
        {
            if (_arg_1 == controlBar)
            {
                return;
            };
            if (((controlBar) && (controlBar is IStyleClient)))
            {
                IStyleClient(controlBar).clearStyle("cornerRadius");
                IStyleClient(controlBar).clearStyle("docked");
            };
            controlBar = _arg_1;
            if (((controlBar) && (controlBar is IStyleClient)))
            {
                IStyleClient(controlBar).setStyle("cornerRadius", 0);
                IStyleClient(controlBar).setStyle("docked", true);
            };
            invalidateSize();
            invalidateDisplayList();
            invalidateViewMetricsAndPadding();
        }

        override public function set tabIndex(_arg_1:int):void
        {
        }


    }
}//package mx.core

