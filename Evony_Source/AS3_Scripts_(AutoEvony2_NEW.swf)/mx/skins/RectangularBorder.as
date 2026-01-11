// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.RectangularBorder

package mx.skins
{
    import mx.core.IRectangularBorder;
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.Event;
    import flash.display.Graphics;
    import mx.core.IContainer;
    import mx.core.EdgeMetrics;
    import flash.display.Shape;
    import mx.core.IChildList;
    import mx.core.IRawChildrenContainer;
    import flash.display.Loader;
    import mx.styles.ISimpleStyleClient;
    import mx.core.FlexShape;
    import flash.display.LoaderInfo;
    import flash.system.LoaderContext;
    import flash.utils.getDefinitionByName;
    import mx.core.FlexLoader;
    import flash.events.IOErrorEvent;
    import flash.events.ErrorEvent;
    import flash.system.ApplicationDomain;
    import flash.net.URLRequest;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RectangularBorder extends Border implements IRectangularBorder 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var backgroundImage:DisplayObject;
        private var backgroundImageHeight:Number;
        private var _backgroundImageBounds:Rectangle;
        private var backgroundImageStyle:Object;
        private var backgroundImageWidth:Number;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function RectangularBorder()
        {
            addEventListener(Event.REMOVED, removedHandler);
        }

        public function layoutBackgroundImage():void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_14:Number;
            var _local_15:Graphics;
            var _local_1:DisplayObject = parent;
            var _local_2:EdgeMetrics = ((_local_1 is IContainer) ? IContainer(_local_1).viewMetrics : borderMetrics);
            var _local_3:* = (!(getStyle("backgroundAttachment") == "fixed"));
            if (_backgroundImageBounds)
            {
                _local_4 = _backgroundImageBounds.width;
                _local_5 = _backgroundImageBounds.height;
            }
            else
            {
                _local_4 = ((width - _local_2.left) - _local_2.right);
                _local_5 = ((height - _local_2.top) - _local_2.bottom);
            };
            var _local_6:Number = getBackgroundSize();
            if (isNaN(_local_6))
            {
                _local_7 = 1;
                _local_8 = 1;
            }
            else
            {
                _local_14 = (_local_6 * 0.01);
                _local_7 = ((_local_14 * _local_4) / backgroundImageWidth);
                _local_8 = ((_local_14 * _local_5) / backgroundImageHeight);
            };
            backgroundImage.scaleX = _local_7;
            backgroundImage.scaleY = _local_8;
            var _local_9:Number = Math.round((0.5 * (_local_4 - (backgroundImageWidth * _local_7))));
            var _local_10:Number = Math.round((0.5 * (_local_5 - (backgroundImageHeight * _local_8))));
            backgroundImage.x = _local_2.left;
            backgroundImage.y = _local_2.top;
            var _local_11:Shape = Shape(backgroundImage.mask);
            _local_11.x = _local_2.left;
            _local_11.y = _local_2.top;
            if (((_local_3) && (_local_1 is IContainer)))
            {
                _local_9 = (_local_9 - IContainer(_local_1).horizontalScrollPosition);
                _local_10 = (_local_10 - IContainer(_local_1).verticalScrollPosition);
            };
            backgroundImage.alpha = getStyle("backgroundAlpha");
            backgroundImage.x = (backgroundImage.x + _local_9);
            backgroundImage.y = (backgroundImage.y + _local_10);
            var _local_12:Number = ((width - _local_2.left) - _local_2.right);
            var _local_13:Number = ((height - _local_2.top) - _local_2.bottom);
            if (((!(_local_11.width == _local_12)) || (!(_local_11.height == _local_13))))
            {
                _local_15 = _local_11.graphics;
                _local_15.clear();
                _local_15.beginFill(0xFFFFFF);
                _local_15.drawRect(0, 0, _local_12, _local_13);
                _local_15.endFill();
            };
        }

        public function set backgroundImageBounds(_arg_1:Rectangle):void
        {
            if ((((_backgroundImageBounds) && (_arg_1)) && (_backgroundImageBounds.equals(_arg_1))))
            {
                return;
            };
            _backgroundImageBounds = _arg_1;
            invalidateDisplayList();
        }

        private function getBackgroundSize():Number
        {
            var _local_3:int;
            var _local_1:Number = NaN;
            var _local_2:Object = getStyle("backgroundSize");
            if (((_local_2) && (_local_2 is String)))
            {
                _local_3 = _local_2.indexOf("%");
                if (_local_3 != -1)
                {
                    _local_1 = Number(_local_2.substr(0, _local_3));
                };
            };
            return (_local_1);
        }

        private function removedHandler(_arg_1:Event):void
        {
            var _local_2:IChildList;
            if (backgroundImage)
            {
                _local_2 = ((parent is IRawChildrenContainer) ? IRawChildrenContainer(parent).rawChildren : IChildList(parent));
                _local_2.removeChild(backgroundImage.mask);
                _local_2.removeChild(backgroundImage);
                backgroundImage = null;
            };
        }

        private function initBackgroundImage(_arg_1:DisplayObject):void
        {
            backgroundImage = _arg_1;
            if ((_arg_1 is Loader))
            {
                backgroundImageWidth = Loader(_arg_1).contentLoaderInfo.width;
                backgroundImageHeight = Loader(_arg_1).contentLoaderInfo.height;
            }
            else
            {
                backgroundImageWidth = backgroundImage.width;
                backgroundImageHeight = backgroundImage.height;
                if ((_arg_1 is ISimpleStyleClient))
                {
                    ISimpleStyleClient(_arg_1).styleName = styleName;
                };
            };
            var _local_2:IChildList = ((parent is IRawChildrenContainer) ? IRawChildrenContainer(parent).rawChildren : IChildList(parent));
            var _local_3:Shape = new FlexShape();
            _local_3.name = "backgroundMask";
            _local_3.x = 0;
            _local_3.y = 0;
            _local_2.addChild(_local_3);
            var _local_4:int = _local_2.getChildIndex(this);
            _local_2.addChildAt(backgroundImage, (_local_4 + 1));
            backgroundImage.mask = _local_3;
        }

        public function get backgroundImageBounds():Rectangle
        {
            return (_backgroundImageBounds);
        }

        public function get hasBackgroundImage():Boolean
        {
            return (!(backgroundImage == null));
        }

        private function completeEventHandler(_arg_1:Event):void
        {
            if (!parent)
            {
                return;
            };
            var _local_2:DisplayObject = DisplayObject(LoaderInfo(_arg_1.target).loader);
            initBackgroundImage(_local_2);
            layoutBackgroundImage();
            dispatchEvent(_arg_1.clone());
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            var cls:Class;
            var newStyleObj:DisplayObject;
            var loader:Loader;
            var loaderContext:LoaderContext;
            var message:String;
            if (!parent)
            {
                return;
            };
            var newStyle:Object = getStyle("backgroundImage");
            if (newStyle != backgroundImageStyle)
            {
                removedHandler(null);
                backgroundImageStyle = newStyle;
                if (((newStyle) && (newStyle as Class)))
                {
                    cls = Class(newStyle);
                    initBackgroundImage(new (cls)());
                }
                else
                {
                    if (((newStyle) && (newStyle is String)))
                    {
                        try
                        {
                            cls = Class(getDefinitionByName(String(newStyle)));
                        }
                        catch(e:Error)
                        {
                        };
                        if (cls)
                        {
                            newStyleObj = new (cls)();
                            initBackgroundImage(newStyleObj);
                        }
                        else
                        {
                            loader = new FlexLoader();
                            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeEventHandler);
                            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorEventHandler);
                            loader.contentLoaderInfo.addEventListener(ErrorEvent.ERROR, errorEventHandler);
                            loaderContext = new LoaderContext();
                            loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
                            loader.load(new URLRequest(String(newStyle)), loaderContext);
                        };
                    }
                    else
                    {
                        if (newStyle)
                        {
                            message = resourceManager.getString("skins", "notLoaded", [newStyle]);
                            throw (new Error(message));
                        };
                    };
                };
            };
            if (backgroundImage)
            {
                layoutBackgroundImage();
            };
        }

        private function errorEventHandler(_arg_1:Event):void
        {
        }


    }
}//package mx.skins

