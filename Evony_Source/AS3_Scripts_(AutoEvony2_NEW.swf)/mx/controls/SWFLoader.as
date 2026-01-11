// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.SWFLoader

package mx.controls
{
    import mx.core.UIComponent;
    import mx.core.ISWFLoader;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import flash.events.IEventDispatcher;
    import mx.core.IFlexDisplayObject;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import mx.events.SWFBridgeRequest;
    import flash.geom.Rectangle;
    import mx.managers.ISystemManager;
    import mx.core.IUIComponent;
    import mx.managers.CursorManager;
    import flash.events.HTTPStatusEvent;
    import flash.events.EventDispatcher;
    import mx.events.SWFBridgeEvent;
    import mx.events.InvalidateRequestData;
    import flash.events.ProgressEvent;
    import mx.core.FlexVersion;
    import mx.events.InterManagerRequest;
    import flash.display.Bitmap;
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;
    import mx.core.FlexLoader;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import mx.utils.LoaderUtil;
    import mx.core.Application;
    import flash.system.Capabilities;
    import mx.managers.SystemManagerGlobals;
    import flash.system.SecurityDomain;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import mx.managers.SystemManager;
    import mx.styles.ISimpleStyleClient;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class SWFLoader extends UIComponent implements ISWFLoader 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _loadForCompatibility:Boolean = false;
        private var _loaderContext:LoaderContext;
        private var requestedURL:URLRequest;
        private var _swfBridge:IEventDispatcher;
        private var _bytesTotal:Number = NaN;
        private var useUnloadAndStop:Boolean;
        private var flexContent:Boolean = false;
        private var explicitLoaderContext:Boolean = false;
        private var resizableContent:Boolean = false;
        private var brokenImageBorder:IFlexDisplayObject;
        private var _source:Object;
        private var _maintainAspectRatio:Boolean = true;
        private var mouseShield:Sprite;
        private var contentRequestID:String = null;
        private var _smoothBitmapContent:Boolean = false;
        mx_internal var contentHolder:DisplayObject;
        private var brokenImage:Boolean = false;
        private var _bytesLoaded:Number = NaN;
        private var _autoLoad:Boolean = true;
        private var _showBusyCursor:Boolean = false;
        private var _scaleContent:Boolean = true;
        private var isContentLoaded:Boolean = false;
        private var unloadAndStopGC:Boolean;
        private var smoothBitmapContentChanged:Boolean = false;
        private var _trustContent:Boolean = false;
        private var attemptingChildAppDomain:Boolean = false;
        private var scaleContentChanged:Boolean = false;
        private var contentChanged:Boolean = false;

        public function SWFLoader()
        {
            tabChildren = true;
            tabEnabled = false;
            addEventListener(FlexEvent.INITIALIZE, initializeHandler);
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            addEventListener(MouseEvent.CLICK, clickHandler);
            showInAutomationHierarchy = false;
        }

        public function get contentHeight():Number
        {
            return ((contentHolder) ? contentHolder.height : NaN);
        }

        [Bindable("trustContentChanged")]
        public function get trustContent():Boolean
        {
            return (_trustContent);
        }

        public function set trustContent(_arg_1:Boolean):void
        {
            if (_trustContent != _arg_1)
            {
                _trustContent = _arg_1;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("trustContentChanged"));
            };
        }

        [Bindable("maintainAspectRatioChanged")]
        public function get maintainAspectRatio():Boolean
        {
            return (_maintainAspectRatio);
        }

        private function doScaleContent():void
        {
            var interiorWidth:Number;
            var interiorHeight:Number;
            var contentWidth:Number;
            var contentHeight:Number;
            var x:Number;
            var y:Number;
            var newXScale:Number;
            var newYScale:Number;
            var scale:Number;
            var w:Number;
            var h:Number;
            var holder:Loader;
            var sizeSet:Boolean;
            var lInfo:LoaderInfo;
            if (!isContentLoaded)
            {
                return;
            };
            if (((!(resizableContent)) || ((maintainAspectRatio) && (!(flexContent)))))
            {
                unScaleContent();
                interiorWidth = unscaledWidth;
                interiorHeight = unscaledHeight;
                contentWidth = contentHolderWidth;
                contentHeight = contentHolderHeight;
                x = 0;
                y = 0;
                newXScale = ((contentWidth == 0) ? 1 : (interiorWidth / contentWidth));
                newYScale = ((contentHeight == 0) ? 1 : (interiorHeight / contentHeight));
                if (_maintainAspectRatio)
                {
                    if (newXScale > newYScale)
                    {
                        x = Math.floor(((interiorWidth - (contentWidth * newYScale)) * getHorizontalAlignValue()));
                        scale = newYScale;
                    }
                    else
                    {
                        y = Math.floor(((interiorHeight - (contentHeight * newXScale)) * getVerticalAlignValue()));
                        scale = newXScale;
                    };
                    contentHolder.scaleX = scale;
                    contentHolder.scaleY = scale;
                }
                else
                {
                    contentHolder.scaleX = newXScale;
                    contentHolder.scaleY = newYScale;
                };
                contentHolder.x = x;
                contentHolder.y = y;
            }
            else
            {
                contentHolder.x = 0;
                contentHolder.y = 0;
                w = unscaledWidth;
                h = unscaledHeight;
                if ((contentHolder is Loader))
                {
                    holder = Loader(contentHolder);
                    try
                    {
                        if (getContentSize().x > 0)
                        {
                            sizeSet = false;
                            if (holder.contentLoaderInfo.contentType == "application/x-shockwave-flash")
                            {
                                if (childAllowsParent)
                                {
                                    if ((holder.content is IFlexDisplayObject))
                                    {
                                        IFlexDisplayObject(holder.content).setActualSize(w, h);
                                        sizeSet = true;
                                    };
                                };
                                if (((!(sizeSet)) && (swfBridge)))
                                {
                                    swfBridge.dispatchEvent(new SWFBridgeRequest(SWFBridgeRequest.SET_ACTUAL_SIZE_REQUEST, false, false, null, {
                                        "width":w,
                                        "height":h
                                    }));
                                    sizeSet = true;
                                };
                            };
                            if (!sizeSet)
                            {
                                lInfo = holder.contentLoaderInfo;
                                if (lInfo)
                                {
                                    contentHolder.scaleX = (w / lInfo.width);
                                    contentHolder.scaleY = (h / lInfo.height);
                                }
                                else
                                {
                                    contentHolder.width = w;
                                    contentHolder.height = h;
                                };
                            };
                        }
                        else
                        {
                            if (((childAllowsParent) && (!(holder.content is IFlexDisplayObject))))
                            {
                                contentHolder.width = w;
                                contentHolder.height = h;
                            };
                        };
                    }
                    catch(error:Error)
                    {
                        contentHolder.width = w;
                        contentHolder.height = h;
                    };
                    if (!parentAllowsChild)
                    {
                        contentHolder.scrollRect = new Rectangle(0, 0, (w / contentHolder.scaleX), (h / contentHolder.scaleY));
                    };
                }
                else
                {
                    contentHolder.width = w;
                    contentHolder.height = h;
                };
            };
        }

        private function unScaleContent():void
        {
            contentHolder.scaleX = 1;
            contentHolder.scaleY = 1;
            contentHolder.x = 0;
            contentHolder.y = 0;
        }

        public function set maintainAspectRatio(_arg_1:Boolean):void
        {
            _maintainAspectRatio = _arg_1;
            dispatchEvent(new Event("maintainAspectRatioChanged"));
        }

        override public function regenerateStyleCache(recursive:Boolean):void
        {
            var sm:ISystemManager;
            super.regenerateStyleCache(recursive);
            try
            {
                sm = (content as ISystemManager);
                if (sm != null)
                {
                    Object(sm).regenerateStyleCache(recursive);
                };
            }
            catch(error:Error)
            {
            };
        }

        private function get contentHolderHeight():Number
        {
            var loaderInfo:LoaderInfo;
            var content:IFlexDisplayObject;
            var bridge:IEventDispatcher;
            var request:SWFBridgeRequest;
            var testContent:DisplayObject;
            if ((contentHolder is Loader))
            {
                loaderInfo = Loader(contentHolder).contentLoaderInfo;
            };
            if (loaderInfo)
            {
                if (loaderInfo.contentType == "application/x-shockwave-flash")
                {
                    try
                    {
                        if (systemManager.swfBridgeGroup)
                        {
                            bridge = swfBridge;
                            if (bridge)
                            {
                                request = new SWFBridgeRequest(SWFBridgeRequest.GET_SIZE_REQUEST);
                                bridge.dispatchEvent(request);
                                return (request.data.height);
                            };
                        };
                        content = (Loader(contentHolder).content as IFlexDisplayObject);
                        if (content)
                        {
                            return (content.measuredHeight);
                        };
                    }
                    catch(error:Error)
                    {
                        return (contentHolder.height);
                    };
                }
                else
                {
                    try
                    {
                        testContent = Loader(contentHolder).content;
                    }
                    catch(error:Error)
                    {
                        return (contentHolder.height);
                    };
                };
                return (loaderInfo.height);
            };
            if ((contentHolder is IUIComponent))
            {
                return (IUIComponent(contentHolder).getExplicitOrMeasuredHeight());
            };
            if ((contentHolder is IFlexDisplayObject))
            {
                return (IFlexDisplayObject(contentHolder).measuredHeight);
            };
            return (contentHolder.height);
        }

        [Bindable("loaderContextChanged")]
        public function get loaderContext():LoaderContext
        {
            return (_loaderContext);
        }

        public function set showBusyCursor(_arg_1:Boolean):void
        {
            if (_showBusyCursor != _arg_1)
            {
                _showBusyCursor = _arg_1;
                if (_showBusyCursor)
                {
                    CursorManager.registerToUseBusyCursor(this);
                }
                else
                {
                    CursorManager.unRegisterToUseBusyCursor(this);
                };
            };
        }

        override public function notifyStyleChangeInChildren(styleProp:String, recursive:Boolean):void
        {
            var sm:ISystemManager;
            super.notifyStyleChangeInChildren(styleProp, recursive);
            try
            {
                sm = (content as ISystemManager);
                if (sm != null)
                {
                    Object(sm).notifyStyleChangeInChildren(styleProp, recursive);
                };
            }
            catch(error:Error)
            {
            };
        }

        private function getHorizontalAlignValue():Number
        {
            var _local_1:String = getStyle("horizontalAlign");
            if (_local_1 == "left")
            {
                return (0);
            };
            if (_local_1 == "right")
            {
                return (1);
            };
            return (0.5);
        }

        [Bindable("sourceChanged")]
        public function get source():Object
        {
            return (_source);
        }

        [Bindable("loadForCompatibilityChanged")]
        public function get loadForCompatibility():Boolean
        {
            return (_loadForCompatibility);
        }

        private function contentLoaderInfo_httpStatusEventHandler(_arg_1:HTTPStatusEvent):void
        {
            dispatchEvent(_arg_1);
        }

        [Bindable("autoLoadChanged")]
        public function get autoLoad():Boolean
        {
            return (_autoLoad);
        }

        public function set source(_arg_1:Object):void
        {
            if (_source != _arg_1)
            {
                _source = _arg_1;
                contentChanged = true;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("sourceChanged"));
            };
        }

        [Bindable("smoothBitmapContentChanged")]
        public function get smoothBitmapContent():Boolean
        {
            return (_smoothBitmapContent);
        }

        public function set loaderContext(_arg_1:LoaderContext):void
        {
            _loaderContext = _arg_1;
            explicitLoaderContext = true;
            dispatchEvent(new Event("loaderContextChanged"));
        }

        private function get contentHolderWidth():Number
        {
            var loaderInfo:LoaderInfo;
            var content:IFlexDisplayObject;
            var request:SWFBridgeRequest;
            var testContent:DisplayObject;
            if ((contentHolder is Loader))
            {
                loaderInfo = Loader(contentHolder).contentLoaderInfo;
            };
            if (loaderInfo)
            {
                if (loaderInfo.contentType == "application/x-shockwave-flash")
                {
                    try
                    {
                        if (swfBridge)
                        {
                            request = new SWFBridgeRequest(SWFBridgeRequest.GET_SIZE_REQUEST);
                            swfBridge.dispatchEvent(request);
                            return (request.data.width);
                        };
                        content = (Loader(contentHolder).content as IFlexDisplayObject);
                        if (content)
                        {
                            return (content.measuredWidth);
                        };
                    }
                    catch(error:Error)
                    {
                        return (contentHolder.width);
                    };
                }
                else
                {
                    try
                    {
                        testContent = Loader(contentHolder).content;
                    }
                    catch(error:Error)
                    {
                        return (contentHolder.width);
                    };
                };
                return (loaderInfo.width);
            };
            if ((contentHolder is IUIComponent))
            {
                return (IUIComponent(contentHolder).getExplicitOrMeasuredWidth());
            };
            if ((contentHolder is IFlexDisplayObject))
            {
                return (IFlexDisplayObject(contentHolder).measuredWidth);
            };
            return (contentHolder.width);
        }

        [Bindable("progress")]
        public function get bytesLoaded():Number
        {
            return (_bytesLoaded);
        }

        private function removeInitSystemManagerCompleteListener(_arg_1:LoaderInfo):void
        {
            var _local_2:EventDispatcher;
            if (_arg_1.contentType == "application/x-shockwave-flash")
            {
                _local_2 = _arg_1.sharedEvents;
                _local_2.removeEventListener(SWFBridgeEvent.BRIDGE_NEW_APPLICATION, initSystemManagerCompleteEventHandler);
            };
        }

        public function set loadForCompatibility(_arg_1:Boolean):void
        {
            if (_loadForCompatibility != _arg_1)
            {
                _loadForCompatibility = _arg_1;
                contentChanged = true;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("loadForCompatibilityChanged"));
            };
        }

        override protected function measure():void
        {
            var _local_1:Number;
            var _local_2:Number;
            super.measure();
            if (isContentLoaded)
            {
                _local_1 = contentHolder.scaleX;
                _local_2 = contentHolder.scaleY;
                contentHolder.scaleX = 1;
                contentHolder.scaleY = 1;
                measuredWidth = contentHolderWidth;
                measuredHeight = contentHolderHeight;
                contentHolder.scaleX = _local_1;
                contentHolder.scaleY = _local_2;
            }
            else
            {
                if (((!(_source)) || (_source == "")))
                {
                    measuredWidth = 0;
                    measuredHeight = 0;
                };
            };
        }

        private function contentLoaderInfo_initEventHandler(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
            addInitSystemManagerCompleteListener(LoaderInfo(_arg_1.target).loader.contentLoaderInfo);
        }

        public function set autoLoad(_arg_1:Boolean):void
        {
            if (_autoLoad != _arg_1)
            {
                _autoLoad = _arg_1;
                contentChanged = true;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("autoLoadChanged"));
            };
        }

        private function doScaleLoader():void
        {
            if (!isContentLoaded)
            {
                return;
            };
            unScaleContent();
            var _local_1:Number = unscaledWidth;
            var _local_2:Number = unscaledHeight;
            if ((((contentHolderWidth > _local_1) || (contentHolderHeight > _local_2)) || (!(parentAllowsChild))))
            {
                contentHolder.scrollRect = new Rectangle(0, 0, _local_1, _local_2);
            }
            else
            {
                contentHolder.scrollRect = null;
            };
            contentHolder.x = ((_local_1 - contentHolderWidth) * getHorizontalAlignValue());
            contentHolder.y = ((_local_2 - contentHolderHeight) * getVerticalAlignValue());
        }

        public function get content():DisplayObject
        {
            if ((contentHolder is Loader))
            {
                return (Loader(contentHolder).content);
            };
            return (contentHolder);
        }

        public function unloadAndStop(_arg_1:Boolean=true):void
        {
            useUnloadAndStop = true;
            unloadAndStopGC = _arg_1;
            source = null;
            if (!autoLoad)
            {
                load(null);
            };
        }

        public function set smoothBitmapContent(_arg_1:Boolean):void
        {
            if (_smoothBitmapContent != _arg_1)
            {
                _smoothBitmapContent = _arg_1;
                smoothBitmapContentChanged = true;
                invalidateDisplayList();
            };
            dispatchEvent(new Event("smoothBitmapContentChanged"));
        }

        private function dispatchInvalidateRequest(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:ISystemManager = systemManager;
            if (!_local_4.useSWFBridge())
            {
                return;
            };
            var _local_5:IEventDispatcher = _local_4.swfBridgeGroup.parentBridge;
            var _local_6:uint;
            if (_arg_1)
            {
                _local_6 = (_local_6 | InvalidateRequestData.PROPERTIES);
            };
            if (_arg_2)
            {
                _local_6 = (_local_6 | InvalidateRequestData.SIZE);
            };
            if (_arg_3)
            {
                _local_6 = (_local_6 | InvalidateRequestData.DISPLAY_LIST);
            };
            var _local_7:SWFBridgeRequest = new SWFBridgeRequest(SWFBridgeRequest.INVALIDATE_REQUEST, false, false, _local_5, _local_6);
            _local_5.dispatchEvent(_local_7);
        }

        private function contentLoaderInfo_progressEventHandler(_arg_1:ProgressEvent):void
        {
            _bytesTotal = _arg_1.bytesTotal;
            _bytesLoaded = _arg_1.bytesLoaded;
            dispatchEvent(_arg_1);
        }

        public function getVisibleApplicationRect(_arg_1:Boolean=false):Rectangle
        {
            var _local_2:Rectangle = getVisibleRect();
            if (_arg_1)
            {
                _local_2 = systemManager.getVisibleApplicationRect(_local_2);
            };
            return (_local_2);
        }

        public function get showBusyCursor():Boolean
        {
            return (_showBusyCursor);
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return (0);
            };
            return (super.baselinePosition);
        }

        private function initSystemManagerCompleteEventHandler(_arg_1:Event):void
        {
            var _local_3:ISystemManager;
            var _local_2:Object = Object(_arg_1);
            if (((contentHolder is Loader) && (_local_2.data == Loader(contentHolder).contentLoaderInfo.sharedEvents)))
            {
                _swfBridge = Loader(contentHolder).contentLoaderInfo.sharedEvents;
                _local_3 = systemManager;
                _local_3.addChildBridge(_swfBridge, this);
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
                _swfBridge.addEventListener(SWFBridgeRequest.INVALIDATE_REQUEST, invalidateRequestHandler);
            };
        }

        [Bindable("complete")]
        public function get bytesTotal():Number
        {
            return (_bytesTotal);
        }

        private function getVerticalAlignValue():Number
        {
            var _local_1:String = getStyle("verticalAlign");
            if (_local_1 == "top")
            {
                return (0);
            };
            if (_local_1 == "bottom")
            {
                return (1);
            };
            return (0.5);
        }

        private function contentLoaderInfo_unloadEventHandler(_arg_1:Event):void
        {
            var _local_2:ISystemManager;
            isContentLoaded = false;
            dispatchEvent(_arg_1);
            if (_swfBridge)
            {
                _swfBridge.removeEventListener(SWFBridgeRequest.INVALIDATE_REQUEST, invalidateRequestHandler);
                _local_2 = systemManager;
                _local_2.removeChildBridge(_swfBridge);
                _swfBridge = null;
            };
        }

        mx_internal function contentLoaderInfo_completeEventHandler(_arg_1:Event):void
        {
            if (LoaderInfo(_arg_1.target).loader != contentHolder)
            {
                return;
            };
            dispatchEvent(_arg_1);
            contentLoaded();
            if ((contentHolder is Loader))
            {
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
            };
        }

        public function set scaleContent(_arg_1:Boolean):void
        {
            if (_scaleContent != _arg_1)
            {
                _scaleContent = _arg_1;
                scaleContentChanged = true;
                invalidateDisplayList();
            };
            dispatchEvent(new Event("scaleContentChanged"));
        }

        private function contentLoaderInfo_openEventHandler(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
        }

        private function initializeHandler(_arg_1:FlexEvent):void
        {
            if (contentChanged)
            {
                contentChanged = false;
                if (_autoLoad)
                {
                    load(_source);
                };
            };
        }

        protected function clickHandler(_arg_1:MouseEvent):void
        {
            if (!enabled)
            {
                _arg_1.stopImmediatePropagation();
                return;
            };
        }

        private function addedToStageHandler(_arg_1:Event):void
        {
            systemManager.getSandboxRoot().addEventListener(InterManagerRequest.DRAG_MANAGER_REQUEST, mouseShieldHandler, false, 0, true);
        }

        [Bindable("progress")]
        public function get percentLoaded():Number
        {
            var _local_1:Number = (((isNaN(_bytesTotal)) || (_bytesTotal == 0)) ? 0 : (100 * (_bytesLoaded / _bytesTotal)));
            if (isNaN(_local_1))
            {
                _local_1 = 0;
            };
            return (_local_1);
        }

        private function doSmoothBitmapContent():void
        {
            if ((content is Bitmap))
            {
                (content as Bitmap).smoothing = _smoothBitmapContent;
            };
        }

        public function get swfBridge():IEventDispatcher
        {
            return (_swfBridge);
        }

        private function loadContent(classOrString:Object):void
        {
            var child:DisplayObject;
            var cls:Class;
            var url:String;
            var byteArray:ByteArray;
            var loader:Loader;
            var lc:LoaderContext;
            var rootURL:String;
            var currentDomain:ApplicationDomain;
            var topmostDomain:ApplicationDomain;
            var message:String;
            if ((classOrString is Class))
            {
                cls = Class(classOrString);
            }
            else
            {
                if ((classOrString is String))
                {
                    try
                    {
                        cls = Class(systemManager.getDefinitionByName(String(classOrString)));
                    }
                    catch(e:Error)
                    {
                    };
                    url = String(classOrString);
                }
                else
                {
                    if ((classOrString is ByteArray))
                    {
                        byteArray = ByteArray(classOrString);
                    }
                    else
                    {
                        url = classOrString.toString();
                    };
                };
            };
            if (cls)
            {
                contentHolder = (child = new (cls)());
                addChild(child);
                contentLoaded();
            }
            else
            {
                if ((classOrString is DisplayObject))
                {
                    contentHolder = (child = DisplayObject(classOrString));
                    addChild(child);
                    contentLoaded();
                }
                else
                {
                    if (byteArray)
                    {
                        loader = new FlexLoader();
                        contentHolder = (child = loader);
                        addChild(child);
                        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaderInfo_completeEventHandler);
                        loader.contentLoaderInfo.addEventListener(Event.INIT, contentLoaderInfo_initEventHandler);
                        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, contentLoaderInfo_ioErrorEventHandler);
                        loader.contentLoaderInfo.addEventListener(Event.UNLOAD, contentLoaderInfo_unloadEventHandler);
                        loader.loadBytes(byteArray, loaderContext);
                    }
                    else
                    {
                        if (url)
                        {
                            loader = new FlexLoader();
                            contentHolder = (child = loader);
                            addChild(loader);
                            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaderInfo_completeEventHandler);
                            loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, contentLoaderInfo_httpStatusEventHandler);
                            loader.contentLoaderInfo.addEventListener(Event.INIT, contentLoaderInfo_initEventHandler);
                            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, contentLoaderInfo_ioErrorEventHandler);
                            loader.contentLoaderInfo.addEventListener(Event.OPEN, contentLoaderInfo_openEventHandler);
                            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, contentLoaderInfo_progressEventHandler);
                            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, contentLoaderInfo_securityErrorEventHandler);
                            loader.contentLoaderInfo.addEventListener(Event.UNLOAD, contentLoaderInfo_unloadEventHandler);
                            if ((((Capabilities.isDebugger == true) && (url.indexOf(".jpg") == -1)) && (LoaderUtil.normalizeURL(Application.application.systemManager.loaderInfo).indexOf("debug=true") > -1)))
                            {
                                url = (url + ((url.indexOf("?") > -1) ? "&debug=true" : "?debug=true"));
                            };
                            if (!(((url.indexOf(":") > -1) || (url.indexOf("/") == 0)) || (url.indexOf("\\") == 0)))
                            {
                                if (((!(SystemManagerGlobals.bootstrapLoaderInfoURL == null)) && (!(SystemManagerGlobals.bootstrapLoaderInfoURL == ""))))
                                {
                                    rootURL = SystemManagerGlobals.bootstrapLoaderInfoURL;
                                }
                                else
                                {
                                    if (root)
                                    {
                                        rootURL = LoaderUtil.normalizeURL(root.loaderInfo);
                                    }
                                    else
                                    {
                                        if (systemManager)
                                        {
                                            rootURL = LoaderUtil.normalizeURL(DisplayObject(systemManager).loaderInfo);
                                        };
                                    };
                                };
                                if (rootURL)
                                {
                                    url = LoaderUtil.createAbsoluteURL(rootURL, url);
                                };
                            };
                            requestedURL = new URLRequest(url);
                            lc = loaderContext;
                            if (!lc)
                            {
                                lc = new LoaderContext();
                                _loaderContext = lc;
                                if (loadForCompatibility)
                                {
                                    currentDomain = ApplicationDomain.currentDomain.parentDomain;
                                    topmostDomain = null;
                                    while (currentDomain)
                                    {
                                        topmostDomain = currentDomain;
                                        currentDomain = currentDomain.parentDomain;
                                    };
                                    lc.applicationDomain = new ApplicationDomain(topmostDomain);
                                };
                                if (trustContent)
                                {
                                    lc.securityDomain = SecurityDomain.currentDomain;
                                }
                                else
                                {
                                    if (!loadForCompatibility)
                                    {
                                        attemptingChildAppDomain = true;
                                        lc.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
                                    };
                                };
                            };
                            loader.load(requestedURL, lc);
                        }
                        else
                        {
                            message = resourceManager.getString("controls", "notLoadable", [source]);
                            throw (new Error(message));
                        };
                    };
                };
            };
            invalidateDisplayList();
        }

        public function get contentWidth():Number
        {
            return ((contentHolder) ? contentHolder.width : NaN);
        }

        [Bindable("scaleContentChanged")]
        public function get scaleContent():Boolean
        {
            return (_scaleContent);
        }

        public function get childAllowsParent():Boolean
        {
            if (!isContentLoaded)
            {
                return (false);
            };
            try
            {
                if ((contentHolder is Loader))
                {
                    return (Loader(contentHolder).contentLoaderInfo.childAllowsParent);
                };
            }
            catch(error:Error)
            {
                return (false);
            };
            return (true);
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (contentChanged)
            {
                contentChanged = false;
                if (_autoLoad)
                {
                    load(_source);
                };
            };
        }

        private function contentLoaderInfo_securityErrorEventHandler(_arg_1:SecurityErrorEvent):void
        {
            var _local_2:LoaderContext;
            if (attemptingChildAppDomain)
            {
                attemptingChildAppDomain = false;
                _local_2 = new LoaderContext();
                _loaderContext = _local_2;
                callLater(load);
                return;
            };
            dispatchEvent(_arg_1);
            if ((contentHolder is Loader))
            {
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
            };
        }

        private function sizeShield():void
        {
            if (((mouseShield) && (mouseShield.parent)))
            {
                mouseShield.width = unscaledWidth;
                mouseShield.height = unscaledHeight;
            };
        }

        private function addInitSystemManagerCompleteListener(_arg_1:LoaderInfo):void
        {
            var _local_2:EventDispatcher;
            if (_arg_1.contentType == "application/x-shockwave-flash")
            {
                _local_2 = _arg_1.sharedEvents;
                _local_2.addEventListener(SWFBridgeEvent.BRIDGE_NEW_APPLICATION, initSystemManagerCompleteEventHandler);
            };
        }

        private function invalidateRequestHandler(_arg_1:Event):void
        {
            if ((_arg_1 is SWFBridgeRequest))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            var _local_3:uint = uint(_local_2.data);
            if ((_local_3 & InvalidateRequestData.PROPERTIES))
            {
                invalidateProperties();
            };
            if ((_local_3 & InvalidateRequestData.SIZE))
            {
                invalidateSize();
            };
            if ((_local_3 & InvalidateRequestData.DISPLAY_LIST))
            {
                invalidateDisplayList();
            };
            dispatchInvalidateRequest((!((_local_3 & InvalidateRequestData.PROPERTIES) == 0)), (!((_local_3 & InvalidateRequestData.SIZE) == 0)), (!((_local_3 & InvalidateRequestData.DISPLAY_LIST) == 0)));
        }

        private function contentLoaded():void
        {
            var loaderInfo:LoaderInfo;
            isContentLoaded = true;
            if ((contentHolder is Loader))
            {
                loaderInfo = Loader(contentHolder).contentLoaderInfo;
            };
            resizableContent = false;
            if (loaderInfo)
            {
                if (loaderInfo.contentType == "application/x-shockwave-flash")
                {
                    resizableContent = true;
                };
                if (resizableContent)
                {
                    try
                    {
                        if ((Loader(contentHolder).content is IFlexDisplayObject))
                        {
                            flexContent = true;
                        }
                        else
                        {
                            flexContent = (!(swfBridge == null));
                        };
                    }
                    catch(e:Error)
                    {
                        flexContent = (!(swfBridge == null));
                    };
                };
            };
            try
            {
                if ((((tabChildren) && (contentHolder is Loader)) && ((loaderInfo.contentType == "application/x-shockwave-flash") || (Loader(contentHolder).content is DisplayObjectContainer))))
                {
                    Loader(contentHolder).tabChildren = true;
                    DisplayObjectContainer(Loader(contentHolder).content).tabChildren = true;
                };
            }
            catch(e:Error)
            {
            };
            invalidateSize();
            invalidateDisplayList();
        }

        private function getContentSize():Point
        {
            var _local_3:IEventDispatcher;
            var _local_4:SWFBridgeRequest;
            var _local_1:Point = new Point();
            if (((!(contentHolder)) is Loader))
            {
                return (_local_1);
            };
            var _local_2:Loader = Loader(contentHolder);
            if (_local_2.contentLoaderInfo.childAllowsParent)
            {
                _local_1.x = _local_2.content.width;
                _local_1.y = _local_2.content.height;
            }
            else
            {
                _local_3 = swfBridge;
                if (_local_3)
                {
                    _local_4 = new SWFBridgeRequest(SWFBridgeRequest.GET_SIZE_REQUEST);
                    _local_3.dispatchEvent(_local_4);
                    _local_1.x = _local_4.data.width;
                    _local_1.y = _local_4.data.height;
                };
            };
            if (_local_1.x == 0)
            {
                _local_1.x = _local_2.contentLoaderInfo.width;
            };
            if (_local_1.y == 0)
            {
                _local_1.y = _local_2.contentLoaderInfo.height;
            };
            return (_local_1);
        }

        public function load(url:Object=null):void
        {
            var imageData:Bitmap;
            var request:SWFBridgeEvent;
            if (url)
            {
                _source = url;
            };
            if (contentHolder)
            {
                if (isContentLoaded)
                {
                    if ((contentHolder is Loader))
                    {
                        try
                        {
                            if ((Loader(contentHolder).content is Bitmap))
                            {
                                imageData = Bitmap(Loader(contentHolder).content);
                                if (imageData.bitmapData)
                                {
                                    imageData.bitmapData = null;
                                };
                            };
                        }
                        catch(error:Error)
                        {
                        };
                        if (_swfBridge)
                        {
                            request = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, false, false, _swfBridge);
                            _swfBridge.dispatchEvent(request);
                        };
                        if (((childAllowsParent) && (content == SystemManager.lastSystemManager)))
                        {
                            SystemManager.lastSystemManager = null;
                        };
                        removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
                        if (((useUnloadAndStop) && ("unloadAndStop" in contentHolder)))
                        {
                            var _local_3:* = contentHolder;
                            (_local_3["unloadAndStop"](unloadAndStopGC));
                        }
                        else
                        {
                            Loader(contentHolder).unload();
                        };
                        if (!explicitLoaderContext)
                        {
                            _loaderContext = null;
                        };
                    }
                    else
                    {
                        if ((contentHolder is Bitmap))
                        {
                            imageData = Bitmap(contentHolder);
                            if (imageData.bitmapData)
                            {
                                imageData.bitmapData = null;
                            };
                        };
                    };
                }
                else
                {
                    if ((contentHolder is Loader))
                    {
                        try
                        {
                            Loader(contentHolder).close();
                        }
                        catch(error:Error)
                        {
                        };
                    };
                };
                try
                {
                    if (contentHolder.parent == this)
                    {
                        removeChild(contentHolder);
                    };
                }
                catch(error:Error)
                {
                    try
                    {
                        removeChild(contentHolder);
                    }
                    catch(error1:Error)
                    {
                    };
                };
                contentHolder = null;
            };
            isContentLoaded = false;
            brokenImage = false;
            useUnloadAndStop = false;
            contentChanged = false;
            if (((!(_source)) || (_source == "")))
            {
                return;
            };
            loadContent(_source);
        }

        public function get parentAllowsChild():Boolean
        {
            if (!isContentLoaded)
            {
                return (false);
            };
            try
            {
                if ((contentHolder is Loader))
                {
                    return (Loader(contentHolder).contentLoaderInfo.parentAllowsChild);
                };
            }
            catch(error:Error)
            {
                return (false);
            };
            return (true);
        }

        private function contentLoaderInfo_ioErrorEventHandler(_arg_1:IOErrorEvent):void
        {
            source = getStyle("brokenImageSkin");
            load();
            contentChanged = false;
            brokenImage = true;
            if (hasEventListener(_arg_1.type))
            {
                dispatchEvent(_arg_1);
            };
            if ((contentHolder is Loader))
            {
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Class;
            super.updateDisplayList(_arg_1, _arg_2);
            if (contentChanged)
            {
                contentChanged = false;
                if (_autoLoad)
                {
                    load(_source);
                };
            };
            if (isContentLoaded)
            {
                if (((_scaleContent) && (!(brokenImage))))
                {
                    doScaleContent();
                }
                else
                {
                    doScaleLoader();
                };
                scaleContentChanged = false;
                if (smoothBitmapContentChanged)
                {
                    doSmoothBitmapContent();
                    smoothBitmapContentChanged = false;
                };
            };
            if (((brokenImage) && (!(brokenImageBorder))))
            {
                _local_3 = getStyle("brokenImageBorderSkin");
                if (_local_3)
                {
                    brokenImageBorder = IFlexDisplayObject(new (_local_3)());
                    if ((brokenImageBorder is ISimpleStyleClient))
                    {
                        ISimpleStyleClient(brokenImageBorder).styleName = this;
                    };
                    addChild(DisplayObject(brokenImageBorder));
                };
            }
            else
            {
                if (((!(brokenImage)) && (brokenImageBorder)))
                {
                    removeChild(DisplayObject(brokenImageBorder));
                    brokenImageBorder = null;
                };
            };
            if (brokenImageBorder)
            {
                brokenImageBorder.setActualSize(_arg_1, _arg_2);
            };
            sizeShield();
        }

        private function mouseShieldHandler(_arg_1:Event):void
        {
            if (_arg_1["name"] != "mouseShield")
            {
                return;
            };
            if (((!(isContentLoaded)) || (parentAllowsChild)))
            {
                return;
            };
            if (_arg_1["value"])
            {
                if (!mouseShield)
                {
                    mouseShield = new Sprite();
                    mouseShield.graphics.beginFill(0, 0);
                    mouseShield.graphics.drawRect(0, 0, 100, 100);
                    mouseShield.graphics.endFill();
                };
                if (!mouseShield.parent)
                {
                    addChild(mouseShield);
                };
                sizeShield();
            }
            else
            {
                if (((mouseShield) && (mouseShield.parent)))
                {
                    removeChild(mouseShield);
                };
            };
        }


    }
}//package mx.controls

