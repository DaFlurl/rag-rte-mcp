// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.SystemManager

package mx.managers
{
    import flash.display.MovieClip;
    import mx.core.IChildList;
    import mx.core.IFlexDisplayObject;
    import mx.core.IFlexModuleFactory;
    import mx.core.ISWFBridgeProvider;
    import mx.core.mx_internal;
    import flash.utils.Dictionary;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.display.Sprite;
    import mx.preloaders.Preloader;
    import mx.core.ISWFBridgeGroup;
    import flash.utils.Timer;
    import flash.geom.Rectangle;
    import mx.managers.systemClasses.EventProxy;
    import mx.core.IUIComponent;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    import mx.resources.ResourceBundle;
    import flash.system.ApplicationDomain;
    import flash.utils.getQualifiedClassName;
    import flash.display.DisplayObject;
    import mx.managers.systemClasses.RemotePopUp;
    import mx.events.EventListenerRequest;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObjectContainer;
    import flash.display.InteractiveObject;
    import mx.styles.IStyleClient;
    import mx.styles.ISimpleStyleClient;
    import mx.events.FlexEvent;
    import flash.events.TimerEvent;
    import mx.events.InterManagerRequest;
    import mx.core.Singleton;
    import flash.geom.Point;
    import mx.events.SWFBridgeRequest;
    import mx.core.ISWFLoader;
    import mx.events.SWFBridgeEvent;
    import mx.core.SWFBridgeGroup;
    import mx.core.IRawChildrenContainer;
    import flash.display.Loader;
    import flash.events.MouseEvent;
    import mx.events.SandboxMouseEvent;
    import mx.utils.EventUtil;
    import mx.core.EventPriority;
    import mx.utils.SecurityUtil;
    import mx.utils.NameUtil;
    import mx.events.FlexChangeEvent;
    import mx.events.RSLEvent;
    import mx.core.TextFieldFactory;
    import mx.managers.systemClasses.PlaceholderData;
    import flash.display.LoaderInfo;
    import flash.display.Graphics;
    import flash.text.Font;
    import flash.text.TextFormat;
    import mx.resources.ResourceManager;
    import mx.resources.IResourceManager;
    import mx.events.InvalidateRequestData;
    import mx.styles.StyleManager;
    import mx.core.IInvalidating;
    import mx.core.EmbeddedFontRegistry;
    import mx.core.RSLItem;
    import mx.preloaders.DownloadProgressBar;
    import mx.utils.LoaderUtil;
    import mx.core.FlexSprite;
    import mx.messaging.config.LoaderConfig;

    use namespace mx_internal;

    public class SystemManager extends MovieClip implements IChildList, IFlexDisplayObject, IFlexModuleFactory, ISystemManager, ISWFBridgeProvider 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static const IDLE_THRESHOLD:Number = 1000;
        private static const IDLE_INTERVAL:Number = 100;
        mx_internal static var allSystemManagers:Dictionary = new Dictionary(true);
        mx_internal static var lastSystemManager:SystemManager;

        private var _stage:Stage;
        mx_internal var nestLevel:int = 0;
        private var currentSandboxEvent:Event;
        private var mouseCatcher:Sprite;
        private var _height:Number;
        private var preloader:Preloader;
        private var lastFrame:int;
        private var _document:Object;
        private var _rawChildren:SystemRawChildrenList;
        private var _topLevelSystemManager:ISystemManager;
        private var _toolTipIndex:int = 0;
        private var _bridgeToFocusManager:Dictionary;
        private var _explicitHeight:Number;
        private var idToPlaceholder:Object;
        private var _swfBridgeGroup:ISWFBridgeGroup;
        private var _toolTipChildren:SystemChildrenList;
        private var form:Object;
        private var _width:Number;
        private var initialized:Boolean = false;
        private var _focusPane:Sprite;
        private var _fontList:Object = null;
        private var isStageRoot:Boolean = true;
        private var _popUpChildren:SystemChildrenList;
        private var _topMostIndex:int = 0;
        private var nextFrameTimer:Timer = null;
        mx_internal var topLevel:Boolean = true;
        private var _cursorIndex:int = 0;
        private var isBootstrapRoot:Boolean = false;
        mx_internal var _mouseY:*;
        private var _numModalWindows:int = 0;
        mx_internal var _mouseX:*;
        private var _screen:Rectangle;
        mx_internal var idleCounter:int = 0;
        private var _cursorChildren:SystemChildrenList;
        private var _noTopMostIndex:int = 0;
        private var _applicationIndex:int = 1;
        private var isDispatchingResizeEvent:Boolean;
        private var idleTimer:Timer;
        private var doneExecutingInitCallbacks:Boolean = false;
        private var _explicitWidth:Number;
        private var eventProxy:EventProxy;
        mx_internal var topLevelWindow:IUIComponent;

        private var initCallbackFunctions:Array = [];
        private var forms:Array = [];
        private var weakReferenceProxies:Dictionary = new Dictionary(true);
        private var strongReferenceProxies:Dictionary = new Dictionary(false);

        public function SystemManager()
        {
            if (stage)
            {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                stage.align = StageAlign.TOP_LEFT;
            };
            if (((SystemManagerGlobals.topLevelSystemManagers.length > 0) && (!(stage))))
            {
                topLevel = false;
            };
            if (!stage)
            {
                isStageRoot = false;
            };
            if (topLevel)
            {
                SystemManagerGlobals.topLevelSystemManagers.push(this);
            };
            lastSystemManager = this;
            var _local_1:Array = info()["compiledLocales"];
            ResourceBundle.locale = (((!(_local_1 == null)) && (_local_1.length > 0)) ? _local_1[0] : "en_US");
            executeCallbacks();
            stop();
            if (((topLevel) && (!(currentFrame == 1))))
            {
                throw (new Error((("The SystemManager constructor was called when the currentFrame was at " + currentFrame) + " Please add this SWF to bug 129782.")));
            };
            if (((root) && (root.loaderInfo)))
            {
                root.loaderInfo.addEventListener(Event.INIT, initHandler);
            };
        }

        public static function getSWFRoot(object:Object):DisplayObject
        {
            var p:* = undefined;
            var sm:ISystemManager;
            var domain:ApplicationDomain;
            var cls:Class;
            var className:String = getQualifiedClassName(object);
            for (p in allSystemManagers)
            {
                sm = (p as ISystemManager);
                domain = sm.loaderInfo.applicationDomain;
                try
                {
                    cls = Class(domain.getDefinition(className));
                    if ((object is cls))
                    {
                        return (sm as DisplayObject);
                    };
                }
                catch(e:Error)
                {
                };
            };
            return (null);
        }

        private static function areRemotePopUpsEqual(_arg_1:Object, _arg_2:Object):Boolean
        {
            if (!(_arg_1 is RemotePopUp))
            {
                return (false);
            };
            if (!(_arg_2 is RemotePopUp))
            {
                return (false);
            };
            var _local_3:RemotePopUp = RemotePopUp(_arg_1);
            var _local_4:RemotePopUp = RemotePopUp(_arg_2);
            if ((((_local_3.window == _local_4.window) && (_local_3.bridge)) && (_local_4.bridge)))
            {
                return (true);
            };
            return (false);
        }

        private static function getChildListIndex(childList:IChildList, f:Object):int
        {
            var index:int = -1;
            try
            {
                index = childList.getChildIndex(DisplayObject(f));
            }
            catch(e:ArgumentError)
            {
            };
            return (index);
        }

        mx_internal static function registerInitCallback(_arg_1:Function):void
        {
            if (((!(allSystemManagers)) || (!(lastSystemManager))))
            {
                return;
            };
            var _local_2:SystemManager = lastSystemManager;
            if (_local_2.doneExecutingInitCallbacks)
            {
                (_arg_1(_local_2));
            }
            else
            {
                _local_2.initCallbackFunctions.push(_arg_1);
            };
        }

        private static function isRemotePopUp(_arg_1:Object):Boolean
        {
            return (!(_arg_1 is IFocusManagerContainer));
        }


        private function removeEventListenerFromSandboxes(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:IEventDispatcher=null):void
        {
            var _local_8:int;
            if (!swfBridgeGroup)
            {
                return;
            };
            var _local_5:EventListenerRequest = new EventListenerRequest(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, false, false, _arg_1, _arg_3);
            var _local_6:IEventDispatcher = swfBridgeGroup.parentBridge;
            if (((_local_6) && (!(_local_6 == _arg_4))))
            {
                _local_6.removeEventListener(_arg_1, _arg_2, _arg_3);
            };
            var _local_7:Array = swfBridgeGroup.getChildBridges();
            while (_local_8 < _local_7.length)
            {
                if (_local_7[_local_8] != _arg_4)
                {
                    IEventDispatcher(_local_7[_local_8]).removeEventListener(_arg_1, _arg_2, _arg_3);
                };
                _local_8++;
            };
            dispatchEventFromSWFBridges(_local_5, _arg_4);
        }

        mx_internal function addingChild(_arg_1:DisplayObject):void
        {
            var _local_4:DisplayObjectContainer;
            var _local_2:int = 1;
            if (((!(topLevel)) && (parent)))
            {
                _local_4 = parent.parent;
                while (_local_4)
                {
                    if ((_local_4 is ILayoutManagerClient))
                    {
                        _local_2 = (ILayoutManagerClient(_local_4).nestLevel + 1);
                        break;
                    };
                    _local_4 = _local_4.parent;
                };
            };
            nestLevel = _local_2;
            if ((_arg_1 is IUIComponent))
            {
                IUIComponent(_arg_1).systemManager = this;
            };
            var _local_3:Class = Class(getDefinitionByName("mx.core.UIComponent"));
            if (((_arg_1 is IUIComponent) && (!(IUIComponent(_arg_1).document))))
            {
                IUIComponent(_arg_1).document = document;
            };
            if ((_arg_1 is ILayoutManagerClient))
            {
                ILayoutManagerClient(_arg_1).nestLevel = (nestLevel + 1);
            };
            if ((_arg_1 is InteractiveObject))
            {
                if (doubleClickEnabled)
                {
                    InteractiveObject(_arg_1).doubleClickEnabled = true;
                };
            };
            if ((_arg_1 is IUIComponent))
            {
                IUIComponent(_arg_1).parentChanged(this);
            };
            if ((_arg_1 is IStyleClient))
            {
                IStyleClient(_arg_1).regenerateStyleCache(true);
            };
            if ((_arg_1 is ISimpleStyleClient))
            {
                ISimpleStyleClient(_arg_1).styleChanged(null);
            };
            if ((_arg_1 is IStyleClient))
            {
                IStyleClient(_arg_1).notifyStyleChangeInChildren(null, true);
            };
            if (((_local_3) && (_arg_1 is _local_3)))
            {
                _local_3(_arg_1).initThemeColor();
            };
            if (((_local_3) && (_arg_1 is _local_3)))
            {
                _local_3(_arg_1).stylesInitialized();
            };
        }

        private function dispatchEventToOtherSystemManagers(_arg_1:Event):void
        {
            SystemManagerGlobals.dispatchingEventToOtherSystemManagers = true;
            var _local_2:Array = SystemManagerGlobals.topLevelSystemManagers;
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (_local_2[_local_4] != this)
                {
                    _local_2[_local_4].dispatchEvent(_arg_1);
                };
                _local_4++;
            };
            SystemManagerGlobals.dispatchingEventToOtherSystemManagers = false;
        }

        private function idleTimer_timerHandler(_arg_1:TimerEvent):void
        {
            idleCounter++;
            if ((idleCounter * IDLE_INTERVAL) > IDLE_THRESHOLD)
            {
                dispatchEvent(new FlexEvent(FlexEvent.IDLE));
            };
        }

        private function initManagerHandler(event:Event):void
        {
            if (!SystemManagerGlobals.dispatchingEventToOtherSystemManagers)
            {
                dispatchEventToOtherSystemManagers(event);
            };
            if ((event is InterManagerRequest))
            {
                return;
            };
            var name:String = event["name"];
            try
            {
                Singleton.getInstance(name);
            }
            catch(e:Error)
            {
            };
        }

        mx_internal function rawChildren_getObjectsUnderPoint(_arg_1:Point):Array
        {
            return (super.getObjectsUnderPoint(_arg_1));
        }

        public function get preloadedRSLs():Dictionary
        {
            return (null);
        }

        private function getSizeRequestHandler(_arg_1:Event):void
        {
            var _local_2:Object = Object(_arg_1);
            _local_2.data = {
                "width":measuredWidth,
                "height":measuredHeight
            };
        }

        private function beforeUnloadHandler(_arg_1:Event):void
        {
            var _local_2:DisplayObject;
            if (((topLevel) && (stage)))
            {
                _local_2 = getSandboxRoot();
                if (_local_2 != this)
                {
                    _local_2.removeEventListener(Event.RESIZE, Stage_resizeHandler);
                };
            };
            removeParentBridgeListeners();
            dispatchEvent(_arg_1);
        }

        public function getExplicitOrMeasuredHeight():Number
        {
            return ((isNaN(explicitHeight)) ? measuredHeight : explicitHeight);
        }

        private function getVisibleRectRequestHandler(_arg_1:Event):void
        {
            var _local_5:Rectangle;
            var _local_7:Point;
            var _local_8:IEventDispatcher;
            if ((_arg_1 is SWFBridgeRequest))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            var _local_3:Rectangle = Rectangle(_local_2.data);
            var _local_4:DisplayObject = DisplayObject(swfBridgeGroup.getChildBridgeProvider(_local_2.requestor));
            var _local_6:Boolean = true;
            if (!DisplayObjectContainer(document).contains(_local_4))
            {
                _local_6 = false;
            };
            if ((_local_4 is ISWFLoader))
            {
                _local_5 = ISWFLoader(_local_4).getVisibleApplicationRect();
            }
            else
            {
                _local_5 = _local_4.getBounds(this);
                _local_7 = localToGlobal(_local_5.topLeft);
                _local_5.x = _local_7.x;
                _local_5.y = _local_7.y;
            };
            _local_3 = _local_3.intersection(_local_5);
            _local_2.data = _local_3;
            if (((_local_6) && (useSWFBridge())))
            {
                _local_8 = swfBridgeGroup.parentBridge;
                _local_2.requestor = _local_8;
                _local_8.dispatchEvent(_local_2);
            };
            Object(_arg_1).data = _local_2.data;
        }

        mx_internal function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_6:IStyleClient;
            var _local_3:Boolean;
            var _local_4:int = rawChildren.numChildren;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = (rawChildren.getChildAt(_local_5) as IStyleClient);
                if (_local_6)
                {
                    _local_6.styleChanged(_arg_1);
                    _local_6.notifyStyleChangeInChildren(_arg_1, _arg_2);
                };
                if (isTopLevelWindow(DisplayObject(_local_6)))
                {
                    _local_3 = true;
                };
                _local_4 = rawChildren.numChildren;
                _local_5++;
            };
            if (((!(_local_3)) && (topLevelWindow is IStyleClient)))
            {
                IStyleClient(topLevelWindow).styleChanged(_arg_1);
                IStyleClient(topLevelWindow).notifyStyleChangeInChildren(_arg_1, _arg_2);
            };
        }

        private function addEventListenerToOtherSystemManagers(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            var _local_6:Array = SystemManagerGlobals.topLevelSystemManagers;
            if (_local_6.length < 2)
            {
                return;
            };
            SystemManagerGlobals.changingListenersInOtherSystemManagers = true;
            var _local_7:int = _local_6.length;
            var _local_8:int;
            while (_local_8 < _local_7)
            {
                if (_local_6[_local_8] != this)
                {
                    _local_6[_local_8].addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                };
                _local_8++;
            };
            SystemManagerGlobals.changingListenersInOtherSystemManagers = false;
        }

        private function initHandler(event:Event):void
        {
            var bridgeEvent:SWFBridgeEvent;
            if (!isStageRoot)
            {
                if (root.loaderInfo.parentAllowsChild)
                {
                    try
                    {
                        if (((!(parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot", false, true)))) || (!(root.loaderInfo.sharedEvents.hasEventListener(SWFBridgeEvent.BRIDGE_NEW_APPLICATION)))))
                        {
                            isBootstrapRoot = true;
                        };
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            allSystemManagers[this] = this.loaderInfo.url;
            root.loaderInfo.removeEventListener(Event.INIT, initHandler);
            if (useSWFBridge())
            {
                swfBridgeGroup = new SWFBridgeGroup(this);
                swfBridgeGroup.parentBridge = loaderInfo.sharedEvents;
                addParentBridgeListeners();
                bridgeEvent = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_NEW_APPLICATION);
                bridgeEvent.data = swfBridgeGroup.parentBridge;
                swfBridgeGroup.parentBridge.dispatchEvent(bridgeEvent);
                addEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
                root.loaderInfo.addEventListener(Event.UNLOAD, unloadHandler, false, 0, true);
            };
            var sbRoot:DisplayObject = getSandboxRoot();
            sbRoot.addEventListener(InterManagerRequest.INIT_MANAGER_REQUEST, initManagerHandler, false, 0, true);
            if (sbRoot == this)
            {
                addEventListener(InterManagerRequest.SYSTEM_MANAGER_REQUEST, systemManagerHandler);
                addEventListener(InterManagerRequest.DRAG_MANAGER_REQUEST, multiWindowRedispatcher);
                addEventListener("dispatchDragEvent", multiWindowRedispatcher);
                addEventListener(SWFBridgeRequest.ADD_POP_UP_REQUEST, addPopupRequestHandler);
                addEventListener(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, removePopupRequestHandler);
                addEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
                addEventListener(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, removePlaceholderPopupRequestHandler);
                addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, activateFormSandboxEventHandler);
                addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, deactivateFormSandboxEventHandler);
                addEventListener(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST, hideMouseCursorRequestHandler);
                addEventListener(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST, showMouseCursorRequestHandler);
                addEventListener(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST, resetMouseCursorRequestHandler);
            };
            var docFrame:int = ((totalFrames == 1) ? 0 : 1);
            addEventListener(Event.ENTER_FRAME, docFrameListener);
            initialize();
        }

        mx_internal function findFocusManagerContainer(_arg_1:SystemManagerProxy):IFocusManagerContainer
        {
            var _local_5:DisplayObject;
            var _local_2:IChildList = _arg_1.rawChildren;
            var _local_3:int = _local_2.numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = _local_2.getChildAt(_local_4);
                if ((_local_5 is IFocusManagerContainer))
                {
                    return (IFocusManagerContainer(_local_5));
                };
                _local_4++;
            };
            return (null);
        }

        private function addPlaceholderPopupRequestHandler(_arg_1:Event):void
        {
            var _local_3:RemotePopUp;
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (((!(_arg_1.target == this)) && (_arg_1 is SWFBridgeRequest)))
            {
                return;
            };
            if (!forwardPlaceholderRequest(_local_2, true))
            {
                _local_3 = new RemotePopUp(_local_2.data.placeHolderId, _local_2.requestor);
                forms.push(_local_3);
            };
        }

        override public function contains(_arg_1:DisplayObject):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:DisplayObject;
            if (super.contains(_arg_1))
            {
                if (_arg_1.parent == this)
                {
                    _local_2 = super.getChildIndex(_arg_1);
                    if (_local_2 < noTopMostIndex)
                    {
                        return (true);
                    };
                }
                else
                {
                    _local_3 = 0;
                    while (_local_3 < noTopMostIndex)
                    {
                        _local_4 = super.getChildAt(_local_3);
                        if ((_local_4 is IRawChildrenContainer))
                        {
                            if (IRawChildrenContainer(_local_4).rawChildren.contains(_arg_1))
                            {
                                return (true);
                            };
                        };
                        if ((_local_4 is DisplayObjectContainer))
                        {
                            if (DisplayObjectContainer(_local_4).contains(_arg_1))
                            {
                                return (true);
                            };
                        };
                        _local_3++;
                    };
                };
            };
            return (false);
        }

        private function modalWindowRequestHandler(_arg_1:Event):void
        {
            if ((_arg_1 is SWFBridgeRequest))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (!preProcessModalWindowRequest(_local_2, getSandboxRoot()))
            {
                return;
            };
            Singleton.getInstance("mx.managers::IPopUpManager");
            dispatchEvent(_local_2);
        }

        private function activateApplicationSandboxEventHandler(_arg_1:Event):void
        {
            if (!isTopLevelRoot())
            {
                swfBridgeGroup.parentBridge.dispatchEvent(_arg_1);
                return;
            };
            activateForm(document);
        }

        public function getDefinitionByName(_arg_1:String):Object
        {
            var _local_3:Object;
            var _local_2:ApplicationDomain = (((!(topLevel)) && (parent is Loader)) ? Loader(parent).contentLoaderInfo.applicationDomain : (info()["currentDomain"] as ApplicationDomain));
            if (_local_2.hasDefinition(_arg_1))
            {
                _local_3 = _local_2.getDefinition(_arg_1);
            };
            return (_local_3);
        }

        public function removeChildFromSandboxRoot(_arg_1:String, _arg_2:DisplayObject):void
        {
            var _local_3:InterManagerRequest;
            if (getSandboxRoot() == this)
            {
                this[_arg_1].removeChild(_arg_2);
            }
            else
            {
                removingChild(_arg_2);
                _local_3 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
                _local_3.name = (_arg_1 + ".removeChild");
                _local_3.value = _arg_2;
                getSandboxRoot().dispatchEvent(_local_3);
                childRemoved(_arg_2);
            };
        }

        private function removeEventListenerFromOtherSystemManagers(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            var _local_4:Array = SystemManagerGlobals.topLevelSystemManagers;
            if (_local_4.length < 2)
            {
                return;
            };
            SystemManagerGlobals.changingListenersInOtherSystemManagers = true;
            var _local_5:int = _local_4.length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                if (_local_4[_local_6] != this)
                {
                    _local_4[_local_6].removeEventListener(_arg_1, _arg_2, _arg_3);
                };
                _local_6++;
            };
            SystemManagerGlobals.changingListenersInOtherSystemManagers = false;
        }

        public function get embeddedFontList():Object
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:Object;
            if (_fontList == null)
            {
                _fontList = {};
                _local_1 = info()["fonts"];
                for (_local_2 in _local_1)
                {
                    _fontList[_local_2] = _local_1[_local_2];
                };
                if (((!(topLevel)) && (_topLevelSystemManager)))
                {
                    _local_3 = _topLevelSystemManager.embeddedFontList;
                    for (_local_2 in _local_3)
                    {
                        _fontList[_local_2] = _local_3[_local_2];
                    };
                };
            };
            return (_fontList);
        }

        mx_internal function set cursorIndex(_arg_1:int):void
        {
            var _local_2:int = (_arg_1 - _cursorIndex);
            _cursorIndex = _arg_1;
        }

        mx_internal function addChildBridgeListeners(_arg_1:IEventDispatcher):void
        {
            if (((!(topLevel)) && (topLevelSystemManager)))
            {
                SystemManager(topLevelSystemManager).addChildBridgeListeners(_arg_1);
                return;
            };
            _arg_1.addEventListener(SWFBridgeRequest.ADD_POP_UP_REQUEST, addPopupRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, removePopupRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, removePlaceholderPopupRequestHandler);
            _arg_1.addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, activateFormSandboxEventHandler);
            _arg_1.addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, deactivateFormSandboxEventHandler);
            _arg_1.addEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_ACTIVATE, activateApplicationSandboxEventHandler);
            _arg_1.addEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler, false, 0, true);
            _arg_1.addEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler, false, 0, true);
            _arg_1.addEventListener(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.GET_VISIBLE_RECT_REQUEST, getVisibleRectRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST, hideMouseCursorRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST, showMouseCursorRequestHandler);
            _arg_1.addEventListener(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST, resetMouseCursorRequestHandler);
        }

        public function set document(_arg_1:Object):void
        {
            _document = _arg_1;
        }

        override public function getChildAt(_arg_1:int):DisplayObject
        {
            return (super.getChildAt((applicationIndex + _arg_1)));
        }

        public function get rawChildren():IChildList
        {
            if (!_rawChildren)
            {
                _rawChildren = new SystemRawChildrenList(this);
            };
            return (_rawChildren);
        }

        private function findLastActiveForm(_arg_1:Object):Object
        {
            var _local_2:int = forms.length;
            var _local_3:int = (forms.length - 1);
            while (_local_3 >= 0)
            {
                if (((!(forms[_local_3] == _arg_1)) && (canActivatePopUp(forms[_local_3]))))
                {
                    return (forms[_local_3]);
                };
                _local_3--;
            };
            return (null);
        }

        private function multiWindowRedispatcher(_arg_1:Event):void
        {
            if (!SystemManagerGlobals.dispatchingEventToOtherSystemManagers)
            {
                dispatchEventToOtherSystemManagers(_arg_1);
            };
        }

        public function deployMouseShields(_arg_1:Boolean):void
        {
            var _local_2:InterManagerRequest = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST, false, false, "mouseShield", _arg_1);
            getSandboxRoot().dispatchEvent(_local_2);
        }

        override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            var actualType:String;
            if (((type == FlexEvent.RENDER) || (type == FlexEvent.ENTER_FRAME)))
            {
                if (type == FlexEvent.RENDER)
                {
                    type = Event.RENDER;
                }
                else
                {
                    type = Event.ENTER_FRAME;
                };
                try
                {
                    if (stage)
                    {
                        stage.addEventListener(type, listener, useCapture, priority, useWeakReference);
                    }
                    else
                    {
                        super.addEventListener(type, listener, useCapture, priority, useWeakReference);
                    };
                }
                catch(error:SecurityError)
                {
                    super.addEventListener(type, listener, useCapture, priority, useWeakReference);
                };
                if (((stage) && (type == Event.RENDER)))
                {
                    stage.invalidate();
                };
                return;
            };
            if ((((((type == MouseEvent.MOUSE_MOVE) || (type == MouseEvent.MOUSE_UP)) || (type == MouseEvent.MOUSE_DOWN)) || (type == Event.ACTIVATE)) || (type == Event.DEACTIVATE)))
            {
                try
                {
                    if (stage)
                    {
                        stage.addEventListener(type, stageEventHandler, false, 0, true);
                    };
                }
                catch(error:SecurityError)
                {
                };
            };
            if (type == SandboxMouseEvent.MOUSE_UP_SOMEWHERE)
            {
                try
                {
                    if (stage)
                    {
                        stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);
                    }
                    else
                    {
                        super.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);
                    };
                }
                catch(error:SecurityError)
                {
                    super.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);
                };
            };
            if (((hasSWFBridges()) || (SystemManagerGlobals.topLevelSystemManagers.length > 1)))
            {
                if (!eventProxy)
                {
                    eventProxy = new EventProxy(this);
                };
                actualType = EventUtil.sandboxMouseEventMap[type];
                if (actualType)
                {
                    if (isTopLevelRoot())
                    {
                        stage.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, (EventPriority.CURSOR_MANAGEMENT + 1), true);
                        addEventListenerToSandboxes(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, resetMouseCursorTracking, true, (EventPriority.CURSOR_MANAGEMENT + 1), true);
                    }
                    else
                    {
                        super.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, (EventPriority.CURSOR_MANAGEMENT + 1), true);
                    };
                    addEventListenerToSandboxes(type, sandboxMouseListener, useCapture, priority, useWeakReference);
                    if (!SystemManagerGlobals.changingListenersInOtherSystemManagers)
                    {
                        addEventListenerToOtherSystemManagers(type, otherSystemManagerMouseListener, useCapture, priority, useWeakReference);
                    };
                    if (getSandboxRoot() == this)
                    {
                        super.addEventListener(actualType, eventProxy.marshalListener, useCapture, priority, useWeakReference);
                        if (actualType == MouseEvent.MOUSE_UP)
                        {
                            try
                            {
                                if (stage)
                                {
                                    stage.addEventListener(Event.MOUSE_LEAVE, eventProxy.marshalListener, useCapture, priority, useWeakReference);
                                }
                                else
                                {
                                    super.addEventListener(Event.MOUSE_LEAVE, eventProxy.marshalListener, useCapture, priority, useWeakReference);
                                };
                            }
                            catch(e:SecurityError)
                            {
                                super.addEventListener(Event.MOUSE_LEAVE, eventProxy.marshalListener, useCapture, priority, useWeakReference);
                            };
                        };
                    };
                    super.addEventListener(type, listener, false, priority, useWeakReference);
                    return;
                };
            };
            if (((type == FlexEvent.IDLE) && (!(idleTimer))))
            {
                idleTimer = new Timer(IDLE_INTERVAL);
                idleTimer.addEventListener(TimerEvent.TIMER, idleTimer_timerHandler);
                idleTimer.start();
                addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
                addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            };
            super.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        private function activateForm(_arg_1:Object):void
        {
            var _local_2:IFocusManagerContainer;
            if (form)
            {
                if (((!(form == _arg_1)) && (forms.length > 1)))
                {
                    if (isRemotePopUp(form))
                    {
                        if (!areRemotePopUpsEqual(form, _arg_1))
                        {
                            deactivateRemotePopUp(form);
                        };
                    }
                    else
                    {
                        _local_2 = IFocusManagerContainer(form);
                        _local_2.focusManager.deactivate();
                    };
                };
            };
            form = _arg_1;
            if (isRemotePopUp(_arg_1))
            {
                activateRemotePopUp(_arg_1);
            }
            else
            {
                if (_arg_1.focusManager)
                {
                    _arg_1.focusManager.activate();
                };
            };
            updateLastActiveForm();
        }

        public function removeFocusManager(_arg_1:IFocusManagerContainer):void
        {
            var _local_2:int = forms.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (forms[_local_3] == _arg_1)
                {
                    if (form == _arg_1)
                    {
                        deactivate(_arg_1);
                    };
                    dispatchDeactivatedWindowEvent(DisplayObject(_arg_1));
                    forms.splice(_local_3, 1);
                    return;
                };
                _local_3++;
            };
        }

        private function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            idleCounter = 0;
        }

        private function getSandboxScreen():Rectangle
        {
            var _local_2:Rectangle;
            var _local_3:DisplayObject;
            var _local_4:InterManagerRequest;
            var _local_1:DisplayObject = getSandboxRoot();
            if (_local_1 == this)
            {
                _local_2 = new Rectangle(0, 0, width, height);
            }
            else
            {
                if (_local_1 == topLevelSystemManager)
                {
                    _local_3 = DisplayObject(topLevelSystemManager);
                    _local_2 = new Rectangle(0, 0, _local_3.width, _local_3.height);
                }
                else
                {
                    _local_4 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "screen");
                    _local_1.dispatchEvent(_local_4);
                    _local_2 = Rectangle(_local_4.value);
                };
            };
            return (_local_2);
        }

        public function get focusPane():Sprite
        {
            return (_focusPane);
        }

        override public function get mouseX():Number
        {
            if (_mouseX === undefined)
            {
                return (super.mouseX);
            };
            return (_mouseX);
        }

        private function mouseDownHandler(_arg_1:MouseEvent):void
        {
            var _local_3:int;
            var _local_4:DisplayObject;
            var _local_5:Boolean;
            var _local_6:int;
            var _local_7:Object;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:IChildList;
            var _local_12:DisplayObject;
            var _local_13:Boolean;
            var _local_14:int;
            idleCounter = 0;
            var _local_2:IEventDispatcher = getSWFBridgeOfDisplayObject((_arg_1.target as DisplayObject));
            if (((_local_2) && (bridgeToFocusManager[_local_2] == document.focusManager)))
            {
                if (isTopLevelRoot())
                {
                    activateForm(document);
                }
                else
                {
                    dispatchActivatedApplicationEvent();
                };
                return;
            };
            if (numModalWindows == 0)
            {
                if (((!(isTopLevelRoot())) || (forms.length > 1)))
                {
                    _local_3 = forms.length;
                    _local_4 = DisplayObject(_arg_1.target);
                    _local_5 = document.rawChildren.contains(_local_4);
                    while (_local_4)
                    {
                        _local_6 = 0;
                        while (_local_6 < _local_3)
                        {
                            _local_7 = ((isRemotePopUp(forms[_local_6])) ? forms[_local_6].window : forms[_local_6]);
                            if (_local_7 == _local_4)
                            {
                                _local_8 = 0;
                                if ((((!(_local_4 == form)) && (_local_4 is IFocusManagerContainer)) || ((!(isTopLevelRoot())) && (_local_4 == form))))
                                {
                                    if (isTopLevelRoot())
                                    {
                                        activate(IFocusManagerContainer(_local_4));
                                    };
                                    if (_local_4 == document)
                                    {
                                        dispatchActivatedApplicationEvent();
                                    }
                                    else
                                    {
                                        if ((_local_4 is DisplayObject))
                                        {
                                            dispatchActivatedWindowEvent(DisplayObject(_local_4));
                                        };
                                    };
                                };
                                if (popUpChildren.contains(_local_4))
                                {
                                    _local_11 = popUpChildren;
                                }
                                else
                                {
                                    _local_11 = this;
                                };
                                _local_9 = _local_11.getChildIndex(_local_4);
                                _local_10 = _local_9;
                                _local_3 = forms.length;
                                _local_8 = 0;
                                for (;_local_8 < _local_3;_local_8++)
                                {
                                    _local_13 = isRemotePopUp(forms[_local_8]);
                                    if (_local_13)
                                    {
                                        if ((forms[_local_8].window is String)) continue;
                                        _local_12 = forms[_local_8].window;
                                    }
                                    else
                                    {
                                        _local_12 = forms[_local_8];
                                    };
                                    if (_local_13)
                                    {
                                        _local_14 = getChildListIndex(_local_11, _local_12);
                                        if (_local_14 > _local_9)
                                        {
                                            _local_10 = Math.max(_local_14, _local_10);
                                        };
                                    }
                                    else
                                    {
                                        if (_local_11.contains(_local_12))
                                        {
                                            if (_local_11.getChildIndex(_local_12) > _local_9)
                                            {
                                                _local_10 = Math.max(_local_11.getChildIndex(_local_12), _local_10);
                                            };
                                        };
                                    };
                                };
                                if (((_local_10 > _local_9) && (!(_local_5))))
                                {
                                    _local_11.setChildIndex(_local_4, _local_10);
                                };
                                return;
                            };
                            _local_6++;
                        };
                        _local_4 = _local_4.parent;
                    };
                }
                else
                {
                    dispatchActivatedApplicationEvent();
                };
            };
        }

        public function allowInsecureDomain(... _args):void
        {
        }

        private function removePopupRequestHandler(_arg_1:Event):void
        {
            var _local_3:SWFBridgeRequest;
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (((swfBridgeGroup.parentBridge) && (SecurityUtil.hasMutualTrustBetweenParentAndChild(this))))
            {
                _local_2.requestor = swfBridgeGroup.parentBridge;
                getSandboxRoot().dispatchEvent(_local_2);
                return;
            };
            if (popUpChildren.contains(_local_2.data.window))
            {
                popUpChildren.removeChild(_local_2.data.window);
            }
            else
            {
                removeChild(DisplayObject(_local_2.data.window));
            };
            if (_local_2.data.modal)
            {
                numModalWindows--;
            };
            removeRemotePopUp(new RemotePopUp(_local_2.data.window, _local_2.requestor));
            if (((!(isTopLevelRoot())) && (swfBridgeGroup)))
            {
                _local_3 = new SWFBridgeRequest(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, false, false, _local_2.requestor, {"placeHolderId":NameUtil.displayObjectToString(_local_2.data.window)});
                dispatchEvent(_local_3);
            };
        }

        public function addChildBridge(_arg_1:IEventDispatcher, _arg_2:DisplayObject):void
        {
            var _local_3:IFocusManager;
            var _local_4:DisplayObject = _arg_2;
            while (_local_4)
            {
                if ((_local_4 is IFocusManagerContainer))
                {
                    _local_3 = IFocusManagerContainer(_local_4).focusManager;
                    break;
                };
                _local_4 = _local_4.parent;
            };
            if (!_local_3)
            {
                return;
            };
            if (!swfBridgeGroup)
            {
                swfBridgeGroup = new SWFBridgeGroup(this);
            };
            swfBridgeGroup.addChildBridge(_arg_1, ISWFBridgeProvider(_arg_2));
            _local_3.addSWFBridge(_arg_1, _arg_2);
            if (!bridgeToFocusManager)
            {
                bridgeToFocusManager = new Dictionary();
            };
            bridgeToFocusManager[_arg_1] = _local_3;
            addChildBridgeListeners(_arg_1);
            dispatchEvent(new FlexChangeEvent(FlexChangeEvent.ADD_CHILD_BRIDGE, false, false, _arg_1));
        }

        public function get screen():Rectangle
        {
            if (!_screen)
            {
                Stage_resizeHandler();
            };
            if (!isStageRoot)
            {
                Stage_resizeHandler();
            };
            return (_screen);
        }

        private function resetMouseCursorRequestHandler(_arg_1:Event):void
        {
            var _local_3:IEventDispatcher;
            if (((!(isTopLevelRoot())) && (_arg_1 is SWFBridgeRequest)))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (!isTopLevelRoot())
            {
                _local_3 = swfBridgeGroup.parentBridge;
                _local_2.requestor = _local_3;
                _local_3.dispatchEvent(_local_2);
            }
            else
            {
                if (eventProxy)
                {
                    SystemManagerGlobals.showMouseCursor = true;
                };
            };
        }

        private function preloader_rslCompleteHandler(_arg_1:RSLEvent):void
        {
            if (_arg_1.loaderInfo)
            {
                preloadedRSLs[_arg_1.loaderInfo] = _arg_1.url.url;
            };
        }

        mx_internal function set topMostIndex(_arg_1:int):void
        {
            var _local_2:int = (_arg_1 - _topMostIndex);
            _topMostIndex = _arg_1;
            toolTipIndex = (toolTipIndex + _local_2);
        }

        mx_internal function docFrameHandler(_arg_1:Event=null):void
        {
            var _local_3:TextFieldFactory;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Class;
            Singleton.registerClass("mx.managers::IBrowserManager", Class(getDefinitionByName("mx.managers::BrowserManagerImpl")));
            Singleton.registerClass("mx.managers::ICursorManager", Class(getDefinitionByName("mx.managers::CursorManagerImpl")));
            Singleton.registerClass("mx.managers::IHistoryManager", Class(getDefinitionByName("mx.managers::HistoryManagerImpl")));
            Singleton.registerClass("mx.managers::ILayoutManager", Class(getDefinitionByName("mx.managers::LayoutManager")));
            Singleton.registerClass("mx.managers::IPopUpManager", Class(getDefinitionByName("mx.managers::PopUpManagerImpl")));
            Singleton.registerClass("mx.managers::IToolTipManager2", Class(getDefinitionByName("mx.managers::ToolTipManagerImpl")));
            var _local_2:Class;
            _local_2 = Class(getDefinitionByName("mx.managers::NativeDragManagerImpl"));
            if (_local_2 == null)
            {
                _local_2 = Class(getDefinitionByName("mx.managers::DragManagerImpl"));
            };
            Singleton.registerClass("mx.managers::IDragManager", _local_2);
            Singleton.registerClass("mx.core::ITextFieldFactory", Class(getDefinitionByName("mx.core::TextFieldFactory")));
            executeCallbacks();
            doneExecutingInitCallbacks = true;
            var _local_4:Array = info()["mixins"];
            if (((_local_4) && (_local_4.length > 0)))
            {
                _local_5 = _local_4.length;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_7 = Class(getDefinitionByName(_local_4[_local_6]));
                    var _local_8:* = _local_7;
                    (_local_8["init"](this));
                    _local_6++;
                };
            };
            installCompiledResourceBundles();
            initializeTopLevelWindow(null);
            deferredNextFrame();
        }

        public function get explicitHeight():Number
        {
            return (_explicitHeight);
        }

        public function get preloaderBackgroundSize():String
        {
            return (info()["backgroundSize"]);
        }

        public function isTopLevel():Boolean
        {
            return (topLevel);
        }

        override public function get mouseY():Number
        {
            if (_mouseY === undefined)
            {
                return (super.mouseY);
            };
            return (_mouseY);
        }

        public function getExplicitOrMeasuredWidth():Number
        {
            return ((isNaN(explicitWidth)) ? measuredWidth : explicitWidth);
        }

        public function deactivate(_arg_1:IFocusManagerContainer):void
        {
            deactivateForm(Object(_arg_1));
        }

        private function preProcessModalWindowRequest(_arg_1:SWFBridgeRequest, _arg_2:DisplayObject):Boolean
        {
            var _local_3:IEventDispatcher;
            var _local_4:ISWFLoader;
            var _local_5:Rectangle;
            if (_arg_1.data.skip)
            {
                _arg_1.data.skip = false;
                if (useSWFBridge())
                {
                    _local_3 = swfBridgeGroup.parentBridge;
                    _arg_1.requestor = _local_3;
                    _local_3.dispatchEvent(_arg_1);
                };
                return (false);
            };
            if (this != _arg_2)
            {
                if (((_arg_1.type == SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST) || (_arg_1.type == SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST)))
                {
                    _local_4 = (swfBridgeGroup.getChildBridgeProvider(_arg_1.requestor) as ISWFLoader);
                    if (_local_4)
                    {
                        _local_5 = ISWFLoader(_local_4).getVisibleApplicationRect();
                        _arg_1.data.excludeRect = _local_5;
                        if (!DisplayObjectContainer(document).contains(DisplayObject(_local_4)))
                        {
                            _arg_1.data.useExclude = false;
                        };
                    };
                };
                _local_3 = swfBridgeGroup.parentBridge;
                _arg_1.requestor = _local_3;
                if (_arg_1.type == SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST)
                {
                    _arg_2.dispatchEvent(_arg_1);
                }
                else
                {
                    _local_3.dispatchEvent(_arg_1);
                };
                return (false);
            };
            _arg_1.data.skip = false;
            return (true);
        }

        private function resetMouseCursorTracking(_arg_1:Event):void
        {
            var _local_2:SWFBridgeRequest;
            var _local_3:IEventDispatcher;
            if (isTopLevelRoot())
            {
                SystemManagerGlobals.showMouseCursor = true;
            }
            else
            {
                if (swfBridgeGroup.parentBridge)
                {
                    _local_2 = new SWFBridgeRequest(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST);
                    _local_3 = swfBridgeGroup.parentBridge;
                    _local_2.requestor = _local_3;
                    _local_3.dispatchEvent(_local_2);
                };
            };
        }

        mx_internal function addParentBridgeListeners():void
        {
            if (((!(topLevel)) && (topLevelSystemManager)))
            {
                SystemManager(topLevelSystemManager).addParentBridgeListeners();
                return;
            };
            var _local_1:IEventDispatcher = swfBridgeGroup.parentBridge;
            _local_1.addEventListener(SWFBridgeRequest.SET_ACTUAL_SIZE_REQUEST, setActualSizeRequestHandler);
            _local_1.addEventListener(SWFBridgeRequest.GET_SIZE_REQUEST, getSizeRequestHandler);
            _local_1.addEventListener(SWFBridgeRequest.ACTIVATE_POP_UP_REQUEST, activateRequestHandler);
            _local_1.addEventListener(SWFBridgeRequest.DEACTIVATE_POP_UP_REQUEST, deactivateRequestHandler);
            _local_1.addEventListener(SWFBridgeRequest.IS_BRIDGE_CHILD_REQUEST, isBridgeChildHandler);
            _local_1.addEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _local_1.addEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _local_1.addEventListener(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, canActivateHandler);
            _local_1.addEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, beforeUnloadHandler);
        }

        public function get swfBridgeGroup():ISWFBridgeGroup
        {
            if (topLevel)
            {
                return (_swfBridgeGroup);
            };
            if (topLevelSystemManager)
            {
                return (topLevelSystemManager.swfBridgeGroup);
            };
            return (null);
        }

        override public function getChildByName(_arg_1:String):DisplayObject
        {
            return (super.getChildByName(_arg_1));
        }

        public function get measuredWidth():Number
        {
            return ((topLevelWindow) ? topLevelWindow.getExplicitOrMeasuredWidth() : loaderInfo.width);
        }

        public function removeChildBridge(_arg_1:IEventDispatcher):void
        {
            dispatchEvent(new FlexChangeEvent(FlexChangeEvent.REMOVE_CHILD_BRIDGE, false, false, _arg_1));
            var _local_2:IFocusManager = IFocusManager(bridgeToFocusManager[_arg_1]);
            _local_2.removeSWFBridge(_arg_1);
            swfBridgeGroup.removeChildBridge(_arg_1);
            delete bridgeToFocusManager[_arg_1];
            removeChildBridgeListeners(_arg_1);
        }

        mx_internal function removeChildBridgeListeners(_arg_1:IEventDispatcher):void
        {
            if (((!(topLevel)) && (topLevelSystemManager)))
            {
                SystemManager(topLevelSystemManager).removeChildBridgeListeners(_arg_1);
                return;
            };
            _arg_1.removeEventListener(SWFBridgeRequest.ADD_POP_UP_REQUEST, addPopupRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, removePopupRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, removePlaceholderPopupRequestHandler);
            _arg_1.removeEventListener(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, activateFormSandboxEventHandler);
            _arg_1.removeEventListener(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, deactivateFormSandboxEventHandler);
            _arg_1.removeEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_ACTIVATE, activateApplicationSandboxEventHandler);
            _arg_1.removeEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _arg_1.removeEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.GET_VISIBLE_RECT_REQUEST, getVisibleRectRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST, hideMouseCursorRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST, showMouseCursorRequestHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST, resetMouseCursorRequestHandler);
        }

        override public function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            noTopMostIndex++;
            var _local_3:DisplayObjectContainer = _arg_1.parent;
            if (_local_3)
            {
                _local_3.removeChild(_arg_1);
            };
            return (rawChildren_addChildAt(_arg_1, (applicationIndex + _arg_2)));
        }

        private function Stage_resizeHandler(event:Event=null):void
        {
            var m:Number;
            var n:Number;
            var sandboxScreen:Rectangle;
            if (isDispatchingResizeEvent)
            {
                return;
            };
            var w:Number = 0;
            var h:Number = 0;
            try
            {
                m = loaderInfo.width;
                n = loaderInfo.height;
            }
            catch(error:Error)
            {
                if (!_screen)
                {
                    _screen = new Rectangle();
                };
                return;
            };
            var align:String = StageAlign.TOP_LEFT;
            try
            {
                if (stage)
                {
                    w = stage.stageWidth;
                    h = stage.stageHeight;
                    align = stage.align;
                };
            }
            catch(error:SecurityError)
            {
                sandboxScreen = getSandboxScreen();
                w = sandboxScreen.width;
                h = sandboxScreen.height;
            };
            var x:Number = ((m - w) / 2);
            var y:Number = ((n - h) / 2);
            if (align == StageAlign.TOP)
            {
                y = 0;
            }
            else
            {
                if (align == StageAlign.BOTTOM)
                {
                    y = (n - h);
                }
                else
                {
                    if (align == StageAlign.LEFT)
                    {
                        x = 0;
                    }
                    else
                    {
                        if (align == StageAlign.RIGHT)
                        {
                            x = (m - w);
                        }
                        else
                        {
                            if (((align == StageAlign.TOP_LEFT) || (align == "LT")))
                            {
                                y = 0;
                                x = 0;
                            }
                            else
                            {
                                if (align == StageAlign.TOP_RIGHT)
                                {
                                    y = 0;
                                    x = (m - w);
                                }
                                else
                                {
                                    if (align == StageAlign.BOTTOM_LEFT)
                                    {
                                        y = (n - h);
                                        x = 0;
                                    }
                                    else
                                    {
                                        if (align == StageAlign.BOTTOM_RIGHT)
                                        {
                                            y = (n - h);
                                            x = (m - w);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (!_screen)
            {
                _screen = new Rectangle();
            };
            _screen.x = x;
            _screen.y = y;
            _screen.width = w;
            _screen.height = h;
            if (isStageRoot)
            {
                _width = stage.stageWidth;
                _height = stage.stageHeight;
            };
            if (event)
            {
                resizeMouseCatcher();
                isDispatchingResizeEvent = true;
                dispatchEvent(event);
                isDispatchingResizeEvent = false;
            };
        }

        public function get swfBridge():IEventDispatcher
        {
            if (swfBridgeGroup)
            {
                return (swfBridgeGroup.parentBridge);
            };
            return (null);
        }

        private function findRemotePopUp(_arg_1:Object, _arg_2:IEventDispatcher):RemotePopUp
        {
            var _local_5:RemotePopUp;
            var _local_3:int = forms.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (isRemotePopUp(forms[_local_4]))
                {
                    _local_5 = RemotePopUp(forms[_local_4]);
                    if (((_local_5.window == _arg_1) && (_local_5.bridge == _arg_2)))
                    {
                        return (_local_5);
                    };
                };
                _local_4++;
            };
            return (null);
        }

        public function info():Object
        {
            return ({});
        }

        mx_internal function get toolTipIndex():int
        {
            return (_toolTipIndex);
        }

        public function setActualSize(_arg_1:Number, _arg_2:Number):void
        {
            if (isStageRoot)
            {
                return;
            };
            _width = _arg_1;
            _height = _arg_2;
            if (mouseCatcher)
            {
                mouseCatcher.width = _arg_1;
                mouseCatcher.height = _arg_2;
            };
            dispatchEvent(new Event(Event.RESIZE));
        }

        private function removePlaceholderPopupRequestHandler(_arg_1:Event):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (!forwardPlaceholderRequest(_local_2, false))
            {
                _local_3 = forms.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    if (isRemotePopUp(forms[_local_4]))
                    {
                        if (((forms[_local_4].window == _local_2.data.placeHolderId) && (forms[_local_4].bridge == _local_2.requestor)))
                        {
                            forms.splice(_local_4, 1);
                            return;
                        };
                    };
                    _local_4++;
                };
            };
        }

        public function set focusPane(_arg_1:Sprite):void
        {
            if (_arg_1)
            {
                addChild(_arg_1);
                _arg_1.x = 0;
                _arg_1.y = 0;
                _arg_1.scrollRect = null;
                _focusPane = _arg_1;
            }
            else
            {
                removeChild(_focusPane);
                _focusPane = null;
            };
        }

        mx_internal function removeParentBridgeListeners():void
        {
            if (((!(topLevel)) && (topLevelSystemManager)))
            {
                SystemManager(topLevelSystemManager).removeParentBridgeListeners();
                return;
            };
            var _local_1:IEventDispatcher = swfBridgeGroup.parentBridge;
            _local_1.removeEventListener(SWFBridgeRequest.SET_ACTUAL_SIZE_REQUEST, setActualSizeRequestHandler);
            _local_1.removeEventListener(SWFBridgeRequest.GET_SIZE_REQUEST, getSizeRequestHandler);
            _local_1.removeEventListener(SWFBridgeRequest.ACTIVATE_POP_UP_REQUEST, activateRequestHandler);
            _local_1.removeEventListener(SWFBridgeRequest.DEACTIVATE_POP_UP_REQUEST, deactivateRequestHandler);
            _local_1.removeEventListener(SWFBridgeRequest.IS_BRIDGE_CHILD_REQUEST, isBridgeChildHandler);
            _local_1.removeEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _local_1.removeEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _local_1.removeEventListener(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, canActivateHandler);
            _local_1.removeEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, beforeUnloadHandler);
        }

        override public function get parent():DisplayObjectContainer
        {
            try
            {
                return (super.parent);
            }
            catch(e:SecurityError)
            {
            };
            return (null);
        }

        private function eventListenerRequestHandler(_arg_1:Event):void
        {
            var _local_2:String;
            if ((_arg_1 is EventListenerRequest))
            {
                return;
            };
            var _local_3:EventListenerRequest = EventListenerRequest.marshal(_arg_1);
            if (_arg_1.type == EventListenerRequest.ADD_EVENT_LISTENER_REQUEST)
            {
                if (!eventProxy)
                {
                    eventProxy = new EventProxy(this);
                };
                _local_2 = EventUtil.sandboxMouseEventMap[_local_3.eventType];
                if (_local_2)
                {
                    if (isTopLevelRoot())
                    {
                        stage.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, (EventPriority.CURSOR_MANAGEMENT + 1), true);
                    }
                    else
                    {
                        super.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, (EventPriority.CURSOR_MANAGEMENT + 1), true);
                    };
                    addEventListenerToSandboxes(_local_3.eventType, sandboxMouseListener, true, _local_3.priority, _local_3.useWeakReference, (_arg_1.target as IEventDispatcher));
                    addEventListenerToOtherSystemManagers(_local_3.eventType, otherSystemManagerMouseListener, true, _local_3.priority, _local_3.useWeakReference);
                    if (getSandboxRoot() == this)
                    {
                        if (((isTopLevelRoot()) && ((_local_2 == MouseEvent.MOUSE_UP) || (_local_2 == MouseEvent.MOUSE_MOVE))))
                        {
                            stage.addEventListener(_local_2, eventProxy.marshalListener, false, _local_3.priority, _local_3.useWeakReference);
                        };
                        super.addEventListener(_local_2, eventProxy.marshalListener, true, _local_3.priority, _local_3.useWeakReference);
                    };
                };
            }
            else
            {
                if (_arg_1.type == EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST)
                {
                    _local_2 = EventUtil.sandboxMouseEventMap[_local_3.eventType];
                    if (_local_2)
                    {
                        removeEventListenerFromOtherSystemManagers(_local_3.eventType, otherSystemManagerMouseListener, true);
                        removeEventListenerFromSandboxes(_local_3.eventType, sandboxMouseListener, true, (_arg_1.target as IEventDispatcher));
                        if (getSandboxRoot() == this)
                        {
                            if (((isTopLevelRoot()) && ((_local_2 == MouseEvent.MOUSE_UP) || (_local_2 == MouseEvent.MOUSE_MOVE))))
                            {
                                stage.removeEventListener(_local_2, eventProxy.marshalListener);
                            };
                            super.removeEventListener(_local_2, eventProxy.marshalListener, true);
                        };
                    };
                };
            };
        }

        mx_internal function set applicationIndex(_arg_1:int):void
        {
            _applicationIndex = _arg_1;
        }

        private function showMouseCursorRequestHandler(_arg_1:Event):void
        {
            var _local_3:IEventDispatcher;
            if (((!(isTopLevelRoot())) && (_arg_1 is SWFBridgeRequest)))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (!isTopLevelRoot())
            {
                _local_3 = swfBridgeGroup.parentBridge;
                _local_2.requestor = _local_3;
                _local_3.dispatchEvent(_local_2);
                Object(_arg_1).data = _local_2.data;
            }
            else
            {
                if (eventProxy)
                {
                    Object(_arg_1).data = SystemManagerGlobals.showMouseCursor;
                };
            };
        }

        public function get childAllowsParent():Boolean
        {
            try
            {
                return (loaderInfo.childAllowsParent);
            }
            catch(error:Error)
            {
            };
            return (false);
        }

        public function dispatchEventFromSWFBridges(_arg_1:Event, _arg_2:IEventDispatcher=null, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            var _local_5:Event;
            if (_arg_4)
            {
                dispatchEventToOtherSystemManagers(_arg_1);
            };
            if (!swfBridgeGroup)
            {
                return;
            };
            _local_5 = _arg_1.clone();
            if (_arg_3)
            {
                currentSandboxEvent = _local_5;
            };
            var _local_6:IEventDispatcher = swfBridgeGroup.parentBridge;
            if (((_local_6) && (!(_local_6 == _arg_2))))
            {
                if ((_local_5 is SWFBridgeRequest))
                {
                    SWFBridgeRequest(_local_5).requestor = _local_6;
                };
                _local_6.dispatchEvent(_local_5);
            };
            var _local_7:Array = swfBridgeGroup.getChildBridges();
            var _local_8:int;
            while (_local_8 < _local_7.length)
            {
                if (_local_7[_local_8] != _arg_2)
                {
                    _local_5 = _arg_1.clone();
                    if (_arg_3)
                    {
                        currentSandboxEvent = _local_5;
                    };
                    if ((_local_5 is SWFBridgeRequest))
                    {
                        SWFBridgeRequest(_local_5).requestor = IEventDispatcher(_local_7[_local_8]);
                    };
                    IEventDispatcher(_local_7[_local_8]).dispatchEvent(_local_5);
                };
                _local_8++;
            };
            currentSandboxEvent = null;
        }

        private function setActualSizeRequestHandler(_arg_1:Event):void
        {
            var _local_2:Object = Object(_arg_1);
            setActualSize(_local_2.data.width, _local_2.data.height);
        }

        private function executeCallbacks():void
        {
            var _local_1:Function;
            if (((!(parent)) && (parentAllowsChild)))
            {
                return;
            };
            while (initCallbackFunctions.length > 0)
            {
                _local_1 = initCallbackFunctions.shift();
                (_local_1(this));
            };
        }

        private function addPlaceholderId(_arg_1:String, _arg_2:String, _arg_3:IEventDispatcher, _arg_4:Object):void
        {
            if (!_arg_3)
            {
                throw (new Error());
            };
            if (!idToPlaceholder)
            {
                idToPlaceholder = [];
            };
            idToPlaceholder[_arg_1] = new PlaceholderData(_arg_2, _arg_3, _arg_4);
        }

        private function canActivateHandler(_arg_1:Event):void
        {
            var _local_3:SWFBridgeRequest;
            var _local_6:PlaceholderData;
            var _local_7:RemotePopUp;
            var _local_8:SystemManagerProxy;
            var _local_9:IFocusManagerContainer;
            var _local_10:IEventDispatcher;
            var _local_2:Object = Object(_arg_1);
            var _local_4:Object = _local_2.data;
            var _local_5:String;
            if ((_local_2.data is String))
            {
                _local_6 = idToPlaceholder[_local_2.data];
                _local_4 = _local_6.data;
                _local_5 = _local_6.id;
                if (_local_5 == null)
                {
                    _local_7 = findRemotePopUp(_local_4, _local_6.bridge);
                    if (_local_7)
                    {
                        _local_3 = new SWFBridgeRequest(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, false, false, IEventDispatcher(_local_7.bridge), _local_7.window);
                        if (_local_7.bridge)
                        {
                            _local_7.bridge.dispatchEvent(_local_3);
                            _local_2.data = _local_3.data;
                        };
                        return;
                    };
                };
            };
            if ((_local_4 is SystemManagerProxy))
            {
                _local_8 = SystemManagerProxy(_local_4);
                _local_9 = findFocusManagerContainer(_local_8);
                _local_2.data = (((_local_8) && (_local_9)) && (canActivateLocalComponent(_local_9)));
            }
            else
            {
                if ((_local_4 is IFocusManagerContainer))
                {
                    _local_2.data = canActivateLocalComponent(_local_4);
                }
                else
                {
                    if ((_local_4 is IEventDispatcher))
                    {
                        _local_10 = IEventDispatcher(_local_4);
                        _local_3 = new SWFBridgeRequest(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, false, false, _local_10, _local_5);
                        if (_local_10)
                        {
                            _local_10.dispatchEvent(_local_3);
                            _local_2.data = _local_3.data;
                        };
                    }
                    else
                    {
                        throw (new Error());
                    };
                };
            };
        }

        private function docFrameListener(_arg_1:Event):void
        {
            if (currentFrame == 2)
            {
                removeEventListener(Event.ENTER_FRAME, docFrameListener);
                if (totalFrames > 2)
                {
                    addEventListener(Event.ENTER_FRAME, extraFrameListener);
                };
                docFrameHandler();
            };
        }

        public function get popUpChildren():IChildList
        {
            if (!topLevel)
            {
                return (_topLevelSystemManager.popUpChildren);
            };
            if (!_popUpChildren)
            {
                _popUpChildren = new SystemChildrenList(this, new QName(mx_internal, "noTopMostIndex"), new QName(mx_internal, "topMostIndex"));
            };
            return (_popUpChildren);
        }

        private function addEventListenerToSandboxes(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false, _arg_6:IEventDispatcher=null):void
        {
            var _local_10:int;
            var _local_11:IEventDispatcher;
            if (!swfBridgeGroup)
            {
                return;
            };
            var _local_7:EventListenerRequest = new EventListenerRequest(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, false, false, _arg_1, _arg_3, _arg_4, _arg_5);
            var _local_8:IEventDispatcher = swfBridgeGroup.parentBridge;
            if (((_local_8) && (!(_local_8 == _arg_6))))
            {
                _local_8.addEventListener(_arg_1, _arg_2, false, _arg_4, _arg_5);
            };
            var _local_9:Array = swfBridgeGroup.getChildBridges();
            while (_local_10 < _local_9.length)
            {
                _local_11 = IEventDispatcher(_local_9[_local_10]);
                if (_local_11 != _arg_6)
                {
                    _local_11.addEventListener(_arg_1, _arg_2, false, _arg_4, _arg_5);
                };
                _local_10++;
            };
            dispatchEventFromSWFBridges(_local_7, _arg_6);
        }

        private function forwardFormEvent(_arg_1:SWFBridgeEvent):Boolean
        {
            var _local_3:DisplayObject;
            if (isTopLevelRoot())
            {
                return (false);
            };
            var _local_2:IEventDispatcher = swfBridgeGroup.parentBridge;
            if (_local_2)
            {
                _local_3 = getSandboxRoot();
                _arg_1.data.notifier = _local_2;
                if (_local_3 == this)
                {
                    if (!(_arg_1.data.window is String))
                    {
                        _arg_1.data.window = NameUtil.displayObjectToString(DisplayObject(_arg_1.data.window));
                    }
                    else
                    {
                        _arg_1.data.window = ((NameUtil.displayObjectToString(DisplayObject(this)) + ".") + _arg_1.data.window);
                    };
                    _local_2.dispatchEvent(_arg_1);
                }
                else
                {
                    if ((_arg_1.data.window is String))
                    {
                        _arg_1.data.window = ((NameUtil.displayObjectToString(DisplayObject(this)) + ".") + _arg_1.data.window);
                    };
                    _local_3.dispatchEvent(_arg_1);
                };
            };
            return (true);
        }

        public function set explicitHeight(_arg_1:Number):void
        {
            _explicitHeight = _arg_1;
        }

        override public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            noTopMostIndex--;
            return (rawChildren_removeChild(_arg_1));
        }

        mx_internal function rawChildren_removeChild(_arg_1:DisplayObject):DisplayObject
        {
            removingChild(_arg_1);
            super.removeChild(_arg_1);
            childRemoved(_arg_1);
            return (_arg_1);
        }

        final mx_internal function get $numChildren():int
        {
            return (super.numChildren);
        }

        public function get toolTipChildren():IChildList
        {
            if (!topLevel)
            {
                return (_topLevelSystemManager.toolTipChildren);
            };
            if (!_toolTipChildren)
            {
                _toolTipChildren = new SystemChildrenList(this, new QName(mx_internal, "topMostIndex"), new QName(mx_internal, "toolTipIndex"));
            };
            return (_toolTipChildren);
        }

        public function create(... _args):Object
        {
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            var _local_2:String = info()["mainClassName"];
            if (_local_2 == null)
            {
                _local_4 = loaderInfo.loaderURL;
                _local_5 = _local_4.lastIndexOf(".");
                _local_6 = _local_4.lastIndexOf("/");
                _local_2 = _local_4.substring((_local_6 + 1), _local_5);
            };
            var _local_3:Class = Class(getDefinitionByName(_local_2));
            return ((_local_3) ? new (_local_3)() : null);
        }

        override public function get stage():Stage
        {
            var _local_2:DisplayObject;
            if (_stage)
            {
                return (_stage);
            };
            var _local_1:Stage = super.stage;
            if (_local_1)
            {
                _stage = _local_1;
                return (_local_1);
            };
            if (((!(topLevel)) && (_topLevelSystemManager)))
            {
                _stage = _topLevelSystemManager.stage;
                return (_stage);
            };
            if (((!(isStageRoot)) && (topLevel)))
            {
                _local_2 = getTopLevelRoot();
                if (_local_2)
                {
                    _stage = _local_2.stage;
                    return (_stage);
                };
            };
            return (null);
        }

        override public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:int = numChildren;
            if (_arg_1.parent == this)
            {
                _local_2--;
            };
            return (addChildAt(_arg_1, _local_2));
        }

        private function removeRemotePopUp(_arg_1:RemotePopUp):void
        {
            var _local_2:int = forms.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (isRemotePopUp(forms[_local_3]))
                {
                    if (((forms[_local_3].window == _arg_1.window) && (forms[_local_3].bridge == _arg_1.bridge)))
                    {
                        if (forms[_local_3] == _arg_1)
                        {
                            deactivateForm(_arg_1);
                        };
                        forms.splice(_local_3, 1);
                        return;
                    };
                };
                _local_3++;
            };
        }

        private function deactivateRemotePopUp(_arg_1:Object):void
        {
            var _local_2:SWFBridgeRequest = new SWFBridgeRequest(SWFBridgeRequest.DEACTIVATE_POP_UP_REQUEST, false, false, _arg_1.bridge, _arg_1.window);
            var _local_3:Object = _arg_1.bridge;
            if (_local_3)
            {
                _local_3.dispatchEvent(_local_2);
            };
        }

        override public function getChildIndex(_arg_1:DisplayObject):int
        {
            return (super.getChildIndex(_arg_1) - applicationIndex);
        }

        mx_internal function rawChildren_getChildIndex(_arg_1:DisplayObject):int
        {
            return (super.getChildIndex(_arg_1));
        }

        public function activate(_arg_1:IFocusManagerContainer):void
        {
            activateForm(_arg_1);
        }

        public function getSandboxRoot():DisplayObject
        {
            var parent:DisplayObject;
            var lastParent:DisplayObject;
            var loader:Loader;
            var loaderInfo:LoaderInfo;
            var sm:ISystemManager = this;
            try
            {
                if (sm.topLevelSystemManager)
                {
                    sm = sm.topLevelSystemManager;
                };
                parent = DisplayObject(sm).parent;
                if ((parent is Stage))
                {
                    return (DisplayObject(sm));
                };
                if (((parent) && (!(parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot", false, true))))))
                {
                    return (this);
                };
                lastParent = this;
                while (parent)
                {
                    if ((parent is Stage))
                    {
                        return (lastParent);
                    };
                    if (!parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot", false, true)))
                    {
                        return (lastParent);
                    };
                    if ((parent is Loader))
                    {
                        loader = Loader(parent);
                        loaderInfo = loader.contentLoaderInfo;
                        if (!loaderInfo.childAllowsParent)
                        {
                            return (loaderInfo.content);
                        };
                    };
                    if (parent.hasEventListener(InterManagerRequest.SYSTEM_MANAGER_REQUEST))
                    {
                        lastParent = parent;
                    };
                    parent = parent.parent;
                };
            }
            catch(error:Error)
            {
            };
            return ((lastParent != null) ? lastParent : DisplayObject(sm));
        }

        private function deferredNextFrame():void
        {
            if ((currentFrame + 1) > totalFrames)
            {
                return;
            };
            if ((currentFrame + 1) <= framesLoaded)
            {
                nextFrame();
            }
            else
            {
                nextFrameTimer = new Timer(100);
                nextFrameTimer.addEventListener(TimerEvent.TIMER, nextFrameTimerHandler);
                nextFrameTimer.start();
            };
        }

        mx_internal function get cursorIndex():int
        {
            return (_cursorIndex);
        }

        mx_internal function rawChildren_contains(_arg_1:DisplayObject):Boolean
        {
            return (super.contains(_arg_1));
        }

        override public function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            super.setChildIndex(_arg_1, (applicationIndex + _arg_2));
        }

        public function get document():Object
        {
            return (_document);
        }

        private function resizeMouseCatcher():void
        {
            var g:Graphics;
            var s:Rectangle;
            if (mouseCatcher)
            {
                try
                {
                    g = mouseCatcher.graphics;
                    s = screen;
                    g.clear();
                    g.beginFill(0, 0);
                    g.drawRect(0, 0, s.width, s.height);
                    g.endFill();
                }
                catch(e:SecurityError)
                {
                };
            };
        }

        private function extraFrameListener(_arg_1:Event):void
        {
            if (lastFrame == currentFrame)
            {
                return;
            };
            lastFrame = currentFrame;
            if ((currentFrame + 1) > totalFrames)
            {
                removeEventListener(Event.ENTER_FRAME, extraFrameListener);
            };
            extraFrameHandler();
        }

        private function addPopupRequestHandler(_arg_1:Event):void
        {
            var _local_3:Boolean;
            var _local_4:IChildList;
            var _local_6:ISWFBridgeProvider;
            var _local_7:SWFBridgeRequest;
            if (((!(_arg_1.target == this)) && (_arg_1 is SWFBridgeRequest)))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (_arg_1.target != this)
            {
                _local_6 = swfBridgeGroup.getChildBridgeProvider(IEventDispatcher(_arg_1.target));
                if (!SecurityUtil.hasMutualTrustBetweenParentAndChild(_local_6))
                {
                    return;
                };
            };
            if (((swfBridgeGroup.parentBridge) && (SecurityUtil.hasMutualTrustBetweenParentAndChild(this))))
            {
                _local_2.requestor = swfBridgeGroup.parentBridge;
                getSandboxRoot().dispatchEvent(_local_2);
                return;
            };
            if (((!(_local_2.data.childList)) || (_local_2.data.childList == PopUpManagerChildList.PARENT)))
            {
                _local_3 = ((_local_2.data.parent) && (popUpChildren.contains(_local_2.data.parent)));
            }
            else
            {
                _local_3 = (_local_2.data.childList == PopUpManagerChildList.POPUP);
            };
            _local_4 = ((_local_3) ? popUpChildren : this);
            _local_4.addChild(DisplayObject(_local_2.data.window));
            if (_local_2.data.modal)
            {
                numModalWindows++;
            };
            var _local_5:RemotePopUp = new RemotePopUp(_local_2.data.window, _local_2.requestor);
            forms.push(_local_5);
            if (((!(isTopLevelRoot())) && (swfBridgeGroup)))
            {
                _local_7 = new SWFBridgeRequest(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, false, false, _local_2.requestor, {"window":_local_2.data.window});
                _local_7.data.placeHolderId = NameUtil.displayObjectToString(DisplayObject(_local_2.data.window));
                dispatchEvent(_local_7);
            };
        }

        override public function get height():Number
        {
            return (_height);
        }

        mx_internal function rawChildren_getChildAt(_arg_1:int):DisplayObject
        {
            return (super.getChildAt(_arg_1));
        }

        private function systemManagerHandler(_arg_1:Event):void
        {
            if (_arg_1["name"] == "sameSandbox")
            {
                _arg_1["value"] = (currentSandboxEvent == _arg_1["value"]);
                return;
            };
            if (_arg_1["name"] == "hasSWFBridges")
            {
                _arg_1["value"] = hasSWFBridges();
                return;
            };
            if ((_arg_1 is InterManagerRequest))
            {
                return;
            };
            var _local_2:String = _arg_1["name"];
            switch (_local_2)
            {
                case "popUpChildren.addChild":
                    popUpChildren.addChild(_arg_1["value"]);
                    return;
                case "popUpChildren.removeChild":
                    popUpChildren.removeChild(_arg_1["value"]);
                    return;
                case "cursorChildren.addChild":
                    cursorChildren.addChild(_arg_1["value"]);
                    return;
                case "cursorChildren.removeChild":
                    cursorChildren.removeChild(_arg_1["value"]);
                    return;
                case "toolTipChildren.addChild":
                    toolTipChildren.addChild(_arg_1["value"]);
                    return;
                case "toolTipChildren.removeChild":
                    toolTipChildren.removeChild(_arg_1["value"]);
                    return;
                case "screen":
                    _arg_1["value"] = screen;
                    return;
                case "application":
                    _arg_1["value"] = application;
                    return;
                case "isTopLevelRoot":
                    _arg_1["value"] = isTopLevelRoot();
                    return;
                case "getVisibleApplicationRect":
                    _arg_1["value"] = getVisibleApplicationRect();
                    return;
                case "bringToFront":
                    if (_arg_1["value"].topMost)
                    {
                        popUpChildren.setChildIndex(DisplayObject(_arg_1["value"].popUp), (popUpChildren.numChildren - 1));
                    }
                    else
                    {
                        setChildIndex(DisplayObject(_arg_1["value"].popUp), (numChildren - 1));
                    };
                    return;
            };
        }

        private function activateRemotePopUp(_arg_1:Object):void
        {
            var _local_2:SWFBridgeRequest = new SWFBridgeRequest(SWFBridgeRequest.ACTIVATE_POP_UP_REQUEST, false, false, _arg_1.bridge, _arg_1.window);
            var _local_3:Object = _arg_1.bridge;
            if (_local_3)
            {
                _local_3.dispatchEvent(_local_2);
            };
        }

        mx_internal function set noTopMostIndex(_arg_1:int):void
        {
            var _local_2:int = (_arg_1 - _noTopMostIndex);
            _noTopMostIndex = _arg_1;
            topMostIndex = (topMostIndex + _local_2);
        }

        override public function getObjectsUnderPoint(_arg_1:Point):Array
        {
            var _local_5:DisplayObject;
            var _local_6:Array;
            var _local_2:Array = [];
            var _local_3:int = topMostIndex;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = super.getChildAt(_local_4);
                if ((_local_5 is DisplayObjectContainer))
                {
                    _local_6 = DisplayObjectContainer(_local_5).getObjectsUnderPoint(_arg_1);
                    if (_local_6)
                    {
                        _local_2 = _local_2.concat(_local_6);
                    };
                };
                _local_4++;
            };
            return (_local_2);
        }

        mx_internal function get topMostIndex():int
        {
            return (_topMostIndex);
        }

        mx_internal function regenerateStyleCache(_arg_1:Boolean):void
        {
            var _local_5:IStyleClient;
            var _local_2:Boolean;
            var _local_3:int = rawChildren.numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = (rawChildren.getChildAt(_local_4) as IStyleClient);
                if (_local_5)
                {
                    _local_5.regenerateStyleCache(_arg_1);
                };
                if (isTopLevelWindow(DisplayObject(_local_5)))
                {
                    _local_2 = true;
                };
                _local_3 = rawChildren.numChildren;
                _local_4++;
            };
            if (((!(_local_2)) && (topLevelWindow is IStyleClient)))
            {
                IStyleClient(topLevelWindow).regenerateStyleCache(_arg_1);
            };
        }

        public function addFocusManager(_arg_1:IFocusManagerContainer):void
        {
            forms.push(_arg_1);
        }

        private function deactivateFormSandboxEventHandler(_arg_1:Event):void
        {
            if ((_arg_1 is SWFBridgeRequest))
            {
                return;
            };
            var _local_2:SWFBridgeEvent = SWFBridgeEvent.marshal(_arg_1);
            if (!forwardFormEvent(_local_2))
            {
                if ((((isRemotePopUp(form)) && (RemotePopUp(form).window == _local_2.data.window)) && (RemotePopUp(form).bridge == _local_2.data.notifier)))
                {
                    deactivateForm(form);
                };
            };
        }

        public function set swfBridgeGroup(_arg_1:ISWFBridgeGroup):void
        {
            if (topLevel)
            {
                _swfBridgeGroup = _arg_1;
            }
            else
            {
                if (topLevelSystemManager)
                {
                    SystemManager(topLevelSystemManager).swfBridgeGroup = _arg_1;
                };
            };
        }

        mx_internal function rawChildren_setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            super.setChildIndex(_arg_1, _arg_2);
        }

        private function mouseUpHandler(_arg_1:MouseEvent):void
        {
            idleCounter = 0;
        }

        mx_internal function childAdded(_arg_1:DisplayObject):void
        {
            _arg_1.dispatchEvent(new FlexEvent(FlexEvent.ADD));
            if ((_arg_1 is IUIComponent))
            {
                IUIComponent(_arg_1).initialize();
            };
        }

        public function isFontFaceEmbedded(_arg_1:TextFormat):Boolean
        {
            var _local_6:Font;
            var _local_7:String;
            var _local_2:String = _arg_1.font;
            var _local_3:Array = Font.enumerateFonts();
            var _local_4:int;
            while (_local_4 < _local_3.length)
            {
                _local_6 = Font(_local_3[_local_4]);
                if (_local_6.fontName == _local_2)
                {
                    _local_7 = "regular";
                    if (((_arg_1.bold) && (_arg_1.italic)))
                    {
                        _local_7 = "boldItalic";
                    }
                    else
                    {
                        if (_arg_1.bold)
                        {
                            _local_7 = "bold";
                        }
                        else
                        {
                            if (_arg_1.italic)
                            {
                                _local_7 = "italic";
                            };
                        };
                    };
                    if (_local_6.fontStyle == _local_7)
                    {
                        return (true);
                    };
                };
                _local_4++;
            };
            if ((((!(_local_2)) || (!(embeddedFontList))) || (!(embeddedFontList[_local_2]))))
            {
                return (false);
            };
            var _local_5:Object = embeddedFontList[_local_2];
            return (!((((_arg_1.bold) && (!(_local_5.bold))) || ((_arg_1.italic) && (!(_local_5.italic)))) || (((!(_arg_1.bold)) && (!(_arg_1.italic))) && (!(_local_5.regular)))));
        }

        private function forwardPlaceholderRequest(_arg_1:SWFBridgeRequest, _arg_2:Boolean):Boolean
        {
            if (isTopLevelRoot())
            {
                return (false);
            };
            var _local_3:Object;
            var _local_4:String;
            if (_arg_1.data.window)
            {
                _local_3 = _arg_1.data.window;
                _arg_1.data.window = null;
            }
            else
            {
                _local_3 = _arg_1.requestor;
                _local_4 = _arg_1.data.placeHolderId;
                _arg_1.data.placeHolderId = ((NameUtil.displayObjectToString(this) + ".") + _arg_1.data.placeHolderId);
            };
            if (_arg_2)
            {
                addPlaceholderId(_arg_1.data.placeHolderId, _local_4, _arg_1.requestor, _local_3);
            }
            else
            {
                removePlaceholderId(_arg_1.data.placeHolderId);
            };
            var _local_5:DisplayObject = getSandboxRoot();
            var _local_6:IEventDispatcher = swfBridgeGroup.parentBridge;
            _arg_1.requestor = _local_6;
            if (_local_5 == this)
            {
                _local_6.dispatchEvent(_arg_1);
            }
            else
            {
                _local_5.dispatchEvent(_arg_1);
            };
            return (true);
        }

        public function getTopLevelRoot():DisplayObject
        {
            var sm:ISystemManager;
            var parent:DisplayObject;
            var lastParent:DisplayObject;
            try
            {
                sm = this;
                if (sm.topLevelSystemManager)
                {
                    sm = sm.topLevelSystemManager;
                };
                parent = DisplayObject(sm).parent;
                lastParent = parent;
                while (parent)
                {
                    if ((parent is Stage))
                    {
                        return (lastParent);
                    };
                    lastParent = parent;
                    parent = parent.parent;
                };
            }
            catch(error:SecurityError)
            {
            };
            return (null);
        }

        override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            var actualType:String;
            if (((type == FlexEvent.RENDER) || (type == FlexEvent.ENTER_FRAME)))
            {
                if (type == FlexEvent.RENDER)
                {
                    type = Event.RENDER;
                }
                else
                {
                    type = Event.ENTER_FRAME;
                };
                try
                {
                    if (stage)
                    {
                        stage.removeEventListener(type, listener, useCapture);
                    };
                }
                catch(error:SecurityError)
                {
                };
                super.removeEventListener(type, listener, useCapture);
                return;
            };
            if (((hasSWFBridges()) || (SystemManagerGlobals.topLevelSystemManagers.length > 1)))
            {
                actualType = EventUtil.sandboxMouseEventMap[type];
                if (actualType)
                {
                    if (((getSandboxRoot() == this) && (eventProxy)))
                    {
                        super.removeEventListener(actualType, eventProxy.marshalListener, useCapture);
                        if (actualType == MouseEvent.MOUSE_UP)
                        {
                            try
                            {
                                if (stage)
                                {
                                    stage.removeEventListener(Event.MOUSE_LEAVE, eventProxy.marshalListener, useCapture);
                                };
                            }
                            catch(e:SecurityError)
                            {
                            };
                            super.removeEventListener(Event.MOUSE_LEAVE, eventProxy.marshalListener, useCapture);
                        };
                    };
                    if (!SystemManagerGlobals.changingListenersInOtherSystemManagers)
                    {
                        removeEventListenerFromOtherSystemManagers(type, otherSystemManagerMouseListener, useCapture);
                    };
                    removeEventListenerFromSandboxes(type, sandboxMouseListener, useCapture);
                    super.removeEventListener(type, listener, false);
                    return;
                };
            };
            if (type == FlexEvent.IDLE)
            {
                super.removeEventListener(type, listener, useCapture);
                if (((!(hasEventListener(FlexEvent.IDLE))) && (idleTimer)))
                {
                    idleTimer.stop();
                    idleTimer = null;
                    removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
                    removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                };
            }
            else
            {
                super.removeEventListener(type, listener, useCapture);
            };
            if ((((((type == MouseEvent.MOUSE_MOVE) || (type == MouseEvent.MOUSE_UP)) || (type == MouseEvent.MOUSE_DOWN)) || (type == Event.ACTIVATE)) || (type == Event.DEACTIVATE)))
            {
                if (!hasEventListener(type))
                {
                    try
                    {
                        if (stage)
                        {
                            stage.removeEventListener(type, stageEventHandler, false);
                        };
                    }
                    catch(error:SecurityError)
                    {
                    };
                };
            };
            if (type == SandboxMouseEvent.MOUSE_UP_SOMEWHERE)
            {
                if (!hasEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE))
                {
                    try
                    {
                        if (stage)
                        {
                            stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
                        };
                    }
                    catch(error:SecurityError)
                    {
                    };
                    super.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
                };
            };
        }

        private function extraFrameHandler(_arg_1:Event=null):void
        {
            var _local_3:Class;
            var _local_2:Object = info()["frames"];
            if (((_local_2) && (_local_2[currentLabel])))
            {
                _local_3 = Class(getDefinitionByName(_local_2[currentLabel]));
                var _local_4:* = _local_3;
                (_local_4["frame"](this));
            };
            deferredNextFrame();
        }

        public function isTopLevelRoot():Boolean
        {
            return ((isStageRoot) || (isBootstrapRoot));
        }

        public function get application():IUIComponent
        {
            return (IUIComponent(_document));
        }

        override public function removeChildAt(_arg_1:int):DisplayObject
        {
            noTopMostIndex--;
            return (rawChildren_removeChildAt((applicationIndex + _arg_1)));
        }

        mx_internal function rawChildren_removeChildAt(_arg_1:int):DisplayObject
        {
            var _local_2:DisplayObject = super.getChildAt(_arg_1);
            removingChild(_local_2);
            super.removeChildAt(_arg_1);
            childRemoved(_local_2);
            return (_local_2);
        }

        private function getSWFBridgeOfDisplayObject(_arg_1:DisplayObject):IEventDispatcher
        {
            var _local_2:SWFBridgeRequest;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:int;
            var _local_6:IEventDispatcher;
            var _local_7:ISWFBridgeProvider;
            if (swfBridgeGroup)
            {
                _local_2 = new SWFBridgeRequest(SWFBridgeRequest.IS_BRIDGE_CHILD_REQUEST, false, false, null, _arg_1);
                _local_3 = swfBridgeGroup.getChildBridges();
                _local_4 = _local_3.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_6 = IEventDispatcher(_local_3[_local_5]);
                    _local_7 = swfBridgeGroup.getChildBridgeProvider(_local_6);
                    if (SecurityUtil.hasMutualTrustBetweenParentAndChild(_local_7))
                    {
                        _local_6.dispatchEvent(_local_2);
                        if (_local_2.data == true)
                        {
                            return (_local_6);
                        };
                        _local_2.data = _arg_1;
                    };
                    _local_5++;
                };
            };
            return (null);
        }

        private function deactivateRequestHandler(_arg_1:Event):void
        {
            var _local_5:PlaceholderData;
            var _local_6:RemotePopUp;
            var _local_7:SystemManagerProxy;
            var _local_8:IFocusManagerContainer;
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            var _local_3:Object = _local_2.data;
            var _local_4:String;
            if ((_local_2.data is String))
            {
                _local_5 = idToPlaceholder[_local_2.data];
                _local_3 = _local_5.data;
                _local_4 = _local_5.id;
                if (_local_4 == null)
                {
                    _local_6 = findRemotePopUp(_local_3, _local_5.bridge);
                    if (_local_6)
                    {
                        deactivateRemotePopUp(_local_6);
                        return;
                    };
                };
            };
            if ((_local_3 is SystemManagerProxy))
            {
                _local_7 = SystemManagerProxy(_local_3);
                _local_8 = findFocusManagerContainer(_local_7);
                if (((_local_7) && (_local_8)))
                {
                    _local_7.deactivateByProxy(_local_8);
                };
            }
            else
            {
                if ((_local_3 is IFocusManagerContainer))
                {
                    IFocusManagerContainer(_local_3).focusManager.deactivate();
                }
                else
                {
                    if ((_local_3 is IEventDispatcher))
                    {
                        _local_2.data = _local_4;
                        _local_2.requestor = IEventDispatcher(_local_3);
                        IEventDispatcher(_local_3).dispatchEvent(_local_2);
                        return;
                    };
                    throw (new Error());
                };
            };
        }

        private function installCompiledResourceBundles():void
        {
            var _local_1:Object = this.info();
            var _local_2:ApplicationDomain = (((!(topLevel)) && (parent is Loader)) ? Loader(parent).contentLoaderInfo.applicationDomain : _local_1["currentDomain"]);
            var _local_3:Array = _local_1["compiledLocales"];
            var _local_4:Array = _local_1["compiledResourceBundleNames"];
            var _local_5:IResourceManager = ResourceManager.getInstance();
            _local_5.installCompiledResourceBundles(_local_2, _local_3, _local_4);
            if (!_local_5.localeChain)
            {
                _local_5.initializeLocaleChain(_local_3);
            };
        }

        private function deactivateForm(_arg_1:Object):void
        {
            if (form)
            {
                if (((form == _arg_1) && (forms.length > 1)))
                {
                    if (isRemotePopUp(form))
                    {
                        deactivateRemotePopUp(form);
                    }
                    else
                    {
                        form.focusManager.deactivate();
                    };
                    form = findLastActiveForm(_arg_1);
                    if (form)
                    {
                        if (isRemotePopUp(form))
                        {
                            activateRemotePopUp(form);
                        }
                        else
                        {
                            form.focusManager.activate();
                        };
                    };
                };
            };
        }

        private function unloadHandler(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
        }

        mx_internal function removingChild(_arg_1:DisplayObject):void
        {
            _arg_1.dispatchEvent(new FlexEvent(FlexEvent.REMOVE));
        }

        mx_internal function get applicationIndex():int
        {
            return (_applicationIndex);
        }

        mx_internal function set toolTipIndex(_arg_1:int):void
        {
            var _local_2:int = (_arg_1 - _toolTipIndex);
            _toolTipIndex = _arg_1;
            cursorIndex = (cursorIndex + _local_2);
        }

        private function hasSWFBridges():Boolean
        {
            if (swfBridgeGroup)
            {
                return (true);
            };
            return (false);
        }

        private function updateLastActiveForm():void
        {
            var _local_1:int = forms.length;
            if (_local_1 < 2)
            {
                return;
            };
            var _local_2:int = -1;
            var _local_3:int;
            while (_local_3 < _local_1)
            {
                if (areFormsEqual(form, forms[_local_3]))
                {
                    _local_2 = _local_3;
                    break;
                };
                _local_3++;
            };
            if (_local_2 >= 0)
            {
                forms.splice(_local_2, 1);
                forms.push(form);
            };
        }

        mx_internal function set bridgeToFocusManager(_arg_1:Dictionary):void
        {
            if (topLevel)
            {
                _bridgeToFocusManager = _arg_1;
            }
            else
            {
                if (topLevelSystemManager)
                {
                    SystemManager(topLevelSystemManager).bridgeToFocusManager = _arg_1;
                };
            };
        }

        public function get cursorChildren():IChildList
        {
            if (!topLevel)
            {
                return (_topLevelSystemManager.cursorChildren);
            };
            if (!_cursorChildren)
            {
                _cursorChildren = new SystemChildrenList(this, new QName(mx_internal, "toolTipIndex"), new QName(mx_internal, "cursorIndex"));
            };
            return (_cursorChildren);
        }

        private function sandboxMouseListener(_arg_1:Event):void
        {
            if ((_arg_1 is SandboxMouseEvent))
            {
                return;
            };
            var _local_2:Event = SandboxMouseEvent.marshal(_arg_1);
            dispatchEventFromSWFBridges(_local_2, (_arg_1.target as IEventDispatcher));
            var _local_3:InterManagerRequest = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
            _local_3.name = "sameSandbox";
            _local_3.value = _arg_1;
            getSandboxRoot().dispatchEvent(_local_3);
            if (!_local_3.value)
            {
                dispatchEvent(_local_2);
            };
        }

        public function get preloaderBackgroundImage():Object
        {
            return (info()["backgroundImage"]);
        }

        public function set numModalWindows(_arg_1:int):void
        {
            _numModalWindows = _arg_1;
        }

        public function get preloaderBackgroundAlpha():Number
        {
            return (info()["backgroundAlpha"]);
        }

        mx_internal function rawChildren_getChildByName(_arg_1:String):DisplayObject
        {
            return (super.getChildByName(_arg_1));
        }

        private function dispatchInvalidateRequest():void
        {
            var _local_1:IEventDispatcher = swfBridgeGroup.parentBridge;
            var _local_2:SWFBridgeRequest = new SWFBridgeRequest(SWFBridgeRequest.INVALIDATE_REQUEST, false, false, _local_1, (InvalidateRequestData.SIZE | InvalidateRequestData.DISPLAY_LIST));
            _local_1.dispatchEvent(_local_2);
        }

        public function allowDomain(... _args):void
        {
        }

        public function get preloaderBackgroundColor():uint
        {
            var _local_1:* = info()["backgroundColor"];
            if (_local_1 == undefined)
            {
                return (StyleManager.NOT_A_COLOR);
            };
            return (StyleManager.getColorName(_local_1));
        }

        public function getVisibleApplicationRect(_arg_1:Rectangle=null):Rectangle
        {
            var _local_2:Rectangle;
            var _local_3:Point;
            var _local_4:IEventDispatcher;
            var _local_5:SWFBridgeRequest;
            if (!_arg_1)
            {
                _arg_1 = getBounds(DisplayObject(this));
                _local_2 = screen;
                _local_3 = new Point(Math.max(0, _arg_1.x), Math.max(0, _arg_1.y));
                _local_3 = localToGlobal(_local_3);
                _arg_1.x = _local_3.x;
                _arg_1.y = _local_3.y;
                _arg_1.width = _local_2.width;
                _arg_1.height = _local_2.height;
            };
            if (useSWFBridge())
            {
                _local_4 = swfBridgeGroup.parentBridge;
                _local_5 = new SWFBridgeRequest(SWFBridgeRequest.GET_VISIBLE_RECT_REQUEST, false, false, _local_4, _arg_1);
                _local_4.dispatchEvent(_local_5);
                _arg_1 = Rectangle(_local_5.data);
            };
            return (_arg_1);
        }

        public function get topLevelSystemManager():ISystemManager
        {
            if (topLevel)
            {
                return (this);
            };
            return (_topLevelSystemManager);
        }

        private function appCreationCompleteHandler(_arg_1:FlexEvent):void
        {
            var _local_2:DisplayObjectContainer;
            if (((!(topLevel)) && (parent)))
            {
                _local_2 = parent.parent;
                while (_local_2)
                {
                    if ((_local_2 is IInvalidating))
                    {
                        IInvalidating(_local_2).invalidateSize();
                        IInvalidating(_local_2).invalidateDisplayList();
                        return;
                    };
                    _local_2 = _local_2.parent;
                };
            };
            if (((topLevel) && (useSWFBridge())))
            {
                dispatchInvalidateRequest();
            };
        }

        public function addChildToSandboxRoot(_arg_1:String, _arg_2:DisplayObject):void
        {
            var _local_3:InterManagerRequest;
            if (getSandboxRoot() == this)
            {
                this[_arg_1].addChild(_arg_2);
            }
            else
            {
                addingChild(_arg_2);
                _local_3 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
                _local_3.name = (_arg_1 + ".addChild");
                _local_3.value = _arg_2;
                getSandboxRoot().dispatchEvent(_local_3);
                childAdded(_arg_2);
            };
        }

        private function dispatchDeactivatedWindowEvent(_arg_1:DisplayObject):void
        {
            var _local_3:DisplayObject;
            var _local_4:Boolean;
            var _local_5:SWFBridgeEvent;
            var _local_2:IEventDispatcher = ((swfBridgeGroup) ? swfBridgeGroup.parentBridge : null);
            if (_local_2)
            {
                _local_3 = getSandboxRoot();
                _local_4 = (!(_local_3 == this));
                _local_5 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, false, false, {
                    "notifier":_local_2,
                    "window":((_local_4) ? _arg_1 : NameUtil.displayObjectToString(_arg_1))
                });
                if (_local_4)
                {
                    _local_3.dispatchEvent(_local_5);
                }
                else
                {
                    _local_2.dispatchEvent(_local_5);
                };
            };
        }

        private function isBridgeChildHandler(_arg_1:Event):void
        {
            if ((_arg_1 is SWFBridgeRequest))
            {
                return;
            };
            var _local_2:Object = Object(_arg_1);
            _local_2.data = ((_local_2.data) && (rawChildren.contains((_local_2.data as DisplayObject))));
        }

        public function get measuredHeight():Number
        {
            return ((topLevelWindow) ? topLevelWindow.getExplicitOrMeasuredHeight() : loaderInfo.height);
        }

        private function activateRequestHandler(_arg_1:Event):void
        {
            var _local_5:PlaceholderData;
            var _local_6:RemotePopUp;
            var _local_7:SystemManagerProxy;
            var _local_8:IFocusManagerContainer;
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            var _local_3:Object = _local_2.data;
            var _local_4:String;
            if ((_local_2.data is String))
            {
                _local_5 = idToPlaceholder[_local_2.data];
                _local_3 = _local_5.data;
                _local_4 = _local_5.id;
                if (_local_4 == null)
                {
                    _local_6 = findRemotePopUp(_local_3, _local_5.bridge);
                    if (_local_6)
                    {
                        activateRemotePopUp(_local_6);
                        return;
                    };
                };
            };
            if ((_local_3 is SystemManagerProxy))
            {
                _local_7 = SystemManagerProxy(_local_3);
                _local_8 = findFocusManagerContainer(_local_7);
                if (((_local_7) && (_local_8)))
                {
                    _local_7.activateByProxy(_local_8);
                };
            }
            else
            {
                if ((_local_3 is IFocusManagerContainer))
                {
                    IFocusManagerContainer(_local_3).focusManager.activate();
                }
                else
                {
                    if ((_local_3 is IEventDispatcher))
                    {
                        _local_2.data = _local_4;
                        _local_2.requestor = IEventDispatcher(_local_3);
                        IEventDispatcher(_local_3).dispatchEvent(_local_2);
                    }
                    else
                    {
                        throw (new Error());
                    };
                };
            };
        }

        mx_internal function rawChildren_addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            addingChild(_arg_1);
            super.addChildAt(_arg_1, _arg_2);
            childAdded(_arg_1);
            return (_arg_1);
        }

        mx_internal function initialize():void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_9:EmbeddedFontRegistry;
            var _local_13:String;
            var _local_14:Class;
            var _local_15:Object;
            var _local_16:RSLItem;
            if (isStageRoot)
            {
                _width = stage.stageWidth;
                _height = stage.stageHeight;
            }
            else
            {
                _width = loaderInfo.width;
                _height = loaderInfo.height;
            };
            preloader = new Preloader();
            preloader.addEventListener(FlexEvent.INIT_PROGRESS, preloader_initProgressHandler);
            preloader.addEventListener(FlexEvent.PRELOADER_DONE, preloader_preloaderDoneHandler);
            preloader.addEventListener(RSLEvent.RSL_COMPLETE, preloader_rslCompleteHandler);
            if (!_popUpChildren)
            {
                _popUpChildren = new SystemChildrenList(this, new QName(mx_internal, "noTopMostIndex"), new QName(mx_internal, "topMostIndex"));
            };
            _popUpChildren.addChild(preloader);
            var _local_1:Array = info()["rsls"];
            var _local_2:Array = info()["cdRsls"];
            var _local_3:Boolean = true;
            if (info()["usePreloader"] != undefined)
            {
                _local_3 = info()["usePreloader"];
            };
            var _local_4:Class = (info()["preloader"] as Class);
            if (((_local_3) && (!(_local_4))))
            {
                _local_4 = DownloadProgressBar;
            };
            var _local_5:Array = [];
            if (((_local_2) && (_local_2.length > 0)))
            {
                _local_13 = LoaderUtil.normalizeURL(this.loaderInfo);
                _local_14 = Class(getDefinitionByName("mx.core::CrossDomainRSLItem"));
                _local_6 = _local_2.length;
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    _local_15 = new _local_14(_local_2[_local_7]["rsls"], _local_2[_local_7]["policyFiles"], _local_2[_local_7]["digests"], _local_2[_local_7]["types"], _local_2[_local_7]["isSigned"], _local_13, this);
                    _local_5.push(_local_15);
                    _local_7++;
                };
            };
            if (((!(_local_1 == null)) && (_local_1.length > 0)))
            {
                if (_local_13 == null)
                {
                    _local_13 = LoaderUtil.normalizeURL(this.loaderInfo);
                };
                _local_6 = _local_1.length;
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    _local_16 = new RSLItem(_local_1[_local_7].url, _local_13, this);
                    _local_5.push(_local_16);
                    _local_7++;
                };
            };
            Singleton.registerClass("mx.resources::IResourceManager", Class(getDefinitionByName("mx.resources::ResourceManagerImpl")));
            var _local_8:IResourceManager = ResourceManager.getInstance();
            Singleton.registerClass("mx.core::IEmbeddedFontRegistry", Class(getDefinitionByName("mx.core::EmbeddedFontRegistry")));
            Singleton.registerClass("mx.styles::IStyleManager", Class(getDefinitionByName("mx.styles::StyleManagerImpl")));
            Singleton.registerClass("mx.styles::IStyleManager2", Class(getDefinitionByName("mx.styles::StyleManagerImpl")));
            var _local_10:String = loaderInfo.parameters["localeChain"];
            if (((!(_local_10 == null)) && (!(_local_10 == ""))))
            {
                _local_8.localeChain = _local_10.split(",");
            };
            var _local_11:String = loaderInfo.parameters["resourceModuleURLs"];
            var _local_12:Array = ((_local_11) ? _local_11.split(",") : null);
            preloader.initialize(_local_3, _local_4, preloaderBackgroundColor, preloaderBackgroundAlpha, preloaderBackgroundImage, preloaderBackgroundSize, ((isStageRoot) ? stage.stageWidth : loaderInfo.width), ((isStageRoot) ? stage.stageHeight : loaderInfo.height), null, null, _local_5, _local_12);
        }

        public function useSWFBridge():Boolean
        {
            if (isStageRoot)
            {
                return (false);
            };
            if (((!(topLevel)) && (topLevelSystemManager)))
            {
                return (topLevelSystemManager.useSWFBridge());
            };
            var sbRoot:DisplayObject = getSandboxRoot();
            if (((topLevel) && (!(sbRoot == this))))
            {
                return (true);
            };
            if (sbRoot == this)
            {
                try
                {
                    root.loaderInfo.parentAllowsChild;
                    if (((parentAllowsChild) && (childAllowsParent)))
                    {
                        try
                        {
                            if (!parent.dispatchEvent(new Event("mx.managers.SystemManager.isStageRoot", false, true)))
                            {
                                return (true);
                            };
                        }
                        catch(e:Error)
                        {
                        };
                    }
                    else
                    {
                        return (true);
                    };
                }
                catch(e1:Error)
                {
                    return (false);
                };
            };
            return (false);
        }

        mx_internal function childRemoved(_arg_1:DisplayObject):void
        {
            if ((_arg_1 is IUIComponent))
            {
                IUIComponent(_arg_1).parentChanged(null);
            };
        }

        final mx_internal function $removeChildAt(_arg_1:int):DisplayObject
        {
            return (super.removeChildAt(_arg_1));
        }

        private function canActivatePopUp(_arg_1:Object):Boolean
        {
            var _local_2:RemotePopUp;
            var _local_3:SWFBridgeRequest;
            if (isRemotePopUp(_arg_1))
            {
                _local_2 = RemotePopUp(_arg_1);
                _local_3 = new SWFBridgeRequest(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, false, false, null, _local_2.window);
                IEventDispatcher(_local_2.bridge).dispatchEvent(_local_3);
                return (_local_3.data);
            };
            if (canActivateLocalComponent(_arg_1))
            {
                return (true);
            };
            return (false);
        }

        mx_internal function get noTopMostIndex():int
        {
            return (_noTopMostIndex);
        }

        override public function get numChildren():int
        {
            return (noTopMostIndex - applicationIndex);
        }

        private function canActivateLocalComponent(_arg_1:Object):Boolean
        {
            if (((((_arg_1 is Sprite) && (_arg_1 is IUIComponent)) && (Sprite(_arg_1).visible)) && (IUIComponent(_arg_1).enabled)))
            {
                return (true);
            };
            return (false);
        }

        private function preloader_preloaderDoneHandler(_arg_1:Event):void
        {
            var _local_2:IUIComponent = topLevelWindow;
            preloader.removeEventListener(FlexEvent.PRELOADER_DONE, preloader_preloaderDoneHandler);
            preloader.removeEventListener(RSLEvent.RSL_COMPLETE, preloader_rslCompleteHandler);
            _popUpChildren.removeChild(preloader);
            preloader = null;
            mouseCatcher = new FlexSprite();
            mouseCatcher.name = "mouseCatcher";
            noTopMostIndex++;
            super.addChildAt(mouseCatcher, 0);
            resizeMouseCatcher();
            if (!topLevel)
            {
                mouseCatcher.visible = false;
                mask = mouseCatcher;
            };
            noTopMostIndex++;
            super.addChildAt(DisplayObject(_local_2), 1);
            _local_2.dispatchEvent(new FlexEvent(FlexEvent.APPLICATION_COMPLETE));
            dispatchEvent(new FlexEvent(FlexEvent.APPLICATION_COMPLETE));
        }

        private function initializeTopLevelWindow(_arg_1:Event):void
        {
            var _local_2:IUIComponent;
            var _local_3:DisplayObjectContainer;
            var _local_4:ISystemManager;
            var _local_5:DisplayObject;
            initialized = true;
            if (((!(parent)) && (parentAllowsChild)))
            {
                return;
            };
            if (!topLevel)
            {
                if (!parent)
                {
                    return;
                };
                _local_3 = parent.parent;
                if (!_local_3)
                {
                    return;
                };
                while (_local_3)
                {
                    if ((_local_3 is IUIComponent))
                    {
                        _local_4 = IUIComponent(_local_3).systemManager;
                        if (((_local_4) && (!(_local_4.isTopLevel()))))
                        {
                            _local_4 = _local_4.topLevelSystemManager;
                        };
                        _topLevelSystemManager = _local_4;
                        break;
                    };
                    _local_3 = _local_3.parent;
                };
            };
            if (((isTopLevelRoot()) || (getSandboxRoot() == this)))
            {
                addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, true);
            };
            if (((isTopLevelRoot()) && (stage)))
            {
                stage.addEventListener(Event.RESIZE, Stage_resizeHandler, false, 0, true);
            }
            else
            {
                if (((topLevel) && (stage)))
                {
                    _local_5 = getSandboxRoot();
                    if (_local_5 != this)
                    {
                        _local_5.addEventListener(Event.RESIZE, Stage_resizeHandler, false, 0, true);
                    };
                };
            };
            document = (_local_2 = (topLevelWindow = IUIComponent(create())));
            if (document)
            {
                IEventDispatcher(_local_2).addEventListener(FlexEvent.CREATION_COMPLETE, appCreationCompleteHandler);
                if (!LoaderConfig._url)
                {
                    LoaderConfig._url = loaderInfo.url;
                    LoaderConfig._parameters = loaderInfo.parameters;
                    LoaderConfig._swfVersion = loaderInfo.swfVersion;
                };
                if (((isStageRoot) && (stage)))
                {
                    _width = stage.stageWidth;
                    _height = stage.stageHeight;
                    IFlexDisplayObject(_local_2).setActualSize(_width, _height);
                }
                else
                {
                    IFlexDisplayObject(_local_2).setActualSize(loaderInfo.width, loaderInfo.height);
                };
                if (preloader)
                {
                    preloader.registerApplication(_local_2);
                };
                addingChild(DisplayObject(_local_2));
                childAdded(DisplayObject(_local_2));
            }
            else
            {
                document = this;
            };
        }

        final mx_internal function $addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            return (super.addChildAt(_arg_1, _arg_2));
        }

        private function stageEventHandler(_arg_1:Event):void
        {
            if (((_arg_1.target is Stage) && (mouseCatcher)))
            {
                mouseCatcher.dispatchEvent(_arg_1);
            };
        }

        private function nextFrameTimerHandler(_arg_1:TimerEvent):void
        {
            if ((currentFrame + 1) <= framesLoaded)
            {
                nextFrame();
                nextFrameTimer.removeEventListener(TimerEvent.TIMER, nextFrameTimerHandler);
                nextFrameTimer.reset();
            };
        }

        mx_internal function get bridgeToFocusManager():Dictionary
        {
            if (topLevel)
            {
                return (_bridgeToFocusManager);
            };
            if (topLevelSystemManager)
            {
                return (SystemManager(topLevelSystemManager).bridgeToFocusManager);
            };
            return (null);
        }

        public function get numModalWindows():int
        {
            return (_numModalWindows);
        }

        private function areFormsEqual(_arg_1:Object, _arg_2:Object):Boolean
        {
            if (_arg_1 == _arg_2)
            {
                return (true);
            };
            if (((_arg_1 is RemotePopUp) && (_arg_2 is RemotePopUp)))
            {
                return (areRemotePopUpsEqual(_arg_1, _arg_2));
            };
            return (false);
        }

        public function isTopLevelWindow(_arg_1:DisplayObject):Boolean
        {
            return ((_arg_1 is IUIComponent) && (IUIComponent(_arg_1) == topLevelWindow));
        }

        private function removePlaceholderId(_arg_1:String):void
        {
            delete idToPlaceholder[_arg_1];
        }

        mx_internal function dispatchActivatedWindowEvent(_arg_1:DisplayObject):void
        {
            var _local_3:DisplayObject;
            var _local_4:Boolean;
            var _local_5:SWFBridgeEvent;
            var _local_2:IEventDispatcher = ((swfBridgeGroup) ? swfBridgeGroup.parentBridge : null);
            if (_local_2)
            {
                _local_3 = getSandboxRoot();
                _local_4 = (!(_local_3 == this));
                _local_5 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, false, false, {
                    "notifier":_local_2,
                    "window":((_local_4) ? _arg_1 : NameUtil.displayObjectToString(_arg_1))
                });
                if (_local_4)
                {
                    _local_3.dispatchEvent(_local_5);
                }
                else
                {
                    _local_2.dispatchEvent(_local_5);
                };
            };
        }

        override public function get width():Number
        {
            return (_width);
        }

        private function dispatchActivatedApplicationEvent():void
        {
            var _local_2:SWFBridgeEvent;
            var _local_1:IEventDispatcher = ((swfBridgeGroup) ? swfBridgeGroup.parentBridge : null);
            if (_local_1)
            {
                _local_2 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_APPLICATION_ACTIVATE, false, false);
                _local_1.dispatchEvent(_local_2);
            };
        }

        private function otherSystemManagerMouseListener(_arg_1:SandboxMouseEvent):void
        {
            if (SystemManagerGlobals.dispatchingEventToOtherSystemManagers)
            {
                return;
            };
            dispatchEventFromSWFBridges(_arg_1);
            var _local_2:InterManagerRequest = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
            _local_2.name = "sameSandbox";
            _local_2.value = _arg_1;
            getSandboxRoot().dispatchEvent(_local_2);
            if (!_local_2.value)
            {
                dispatchEvent(_arg_1);
            };
        }

        private function hideMouseCursorRequestHandler(_arg_1:Event):void
        {
            var _local_3:IEventDispatcher;
            if (((!(isTopLevelRoot())) && (_arg_1 is SWFBridgeRequest)))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (!isTopLevelRoot())
            {
                _local_3 = swfBridgeGroup.parentBridge;
                _local_2.requestor = _local_3;
                _local_3.dispatchEvent(_local_2);
            }
            else
            {
                if (eventProxy)
                {
                    SystemManagerGlobals.showMouseCursor = false;
                };
            };
        }

        private function getTopLevelSystemManager(_arg_1:DisplayObject):ISystemManager
        {
            var _local_3:ISystemManager;
            var _local_2:DisplayObjectContainer = DisplayObjectContainer(_arg_1.root);
            if ((((!(_local_2)) || (_local_2 is Stage)) && (_arg_1 is IUIComponent)))
            {
                _local_2 = DisplayObjectContainer(IUIComponent(_arg_1).systemManager);
            };
            if ((_local_2 is ISystemManager))
            {
                _local_3 = ISystemManager(_local_2);
                if (!_local_3.isTopLevel())
                {
                    _local_3 = _local_3.topLevelSystemManager;
                };
            };
            return (_local_3);
        }

        public function isDisplayObjectInABridgedApplication(_arg_1:DisplayObject):Boolean
        {
            return (!(getSWFBridgeOfDisplayObject(_arg_1) == null));
        }

        public function move(_arg_1:Number, _arg_2:Number):void
        {
        }

        public function set explicitWidth(_arg_1:Number):void
        {
            _explicitWidth = _arg_1;
        }

        public function get parentAllowsChild():Boolean
        {
            try
            {
                return (loaderInfo.parentAllowsChild);
            }
            catch(error:Error)
            {
            };
            return (false);
        }

        private function preloader_initProgressHandler(_arg_1:Event):void
        {
            preloader.removeEventListener(FlexEvent.INIT_PROGRESS, preloader_initProgressHandler);
            deferredNextFrame();
        }

        private function mouseLeaveHandler(_arg_1:Event):void
        {
            dispatchEvent(new SandboxMouseEvent(SandboxMouseEvent.MOUSE_UP_SOMEWHERE));
        }

        public function get explicitWidth():Number
        {
            return (_explicitWidth);
        }

        private function activateFormSandboxEventHandler(_arg_1:Event):void
        {
            var _local_2:SWFBridgeEvent = SWFBridgeEvent.marshal(_arg_1);
            if (!forwardFormEvent(_local_2))
            {
                activateForm(new RemotePopUp(_local_2.data.window, _local_2.data.notifier));
            };
        }

        mx_internal function rawChildren_addChild(_arg_1:DisplayObject):DisplayObject
        {
            addingChild(_arg_1);
            super.addChild(_arg_1);
            childAdded(_arg_1);
            return (_arg_1);
        }


    }
}//package mx.managers

