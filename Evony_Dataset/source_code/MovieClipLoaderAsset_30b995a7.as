// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.MovieClipLoaderAsset

package mx.core
{
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class MovieClipLoaderAsset extends MovieClipAsset implements IFlexAsset, IFlexDisplayObject 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        protected var initialHeight:Number = 0;
        private var loader:Loader = null;
        private var initialized:Boolean = false;
        protected var initialWidth:Number = 0;
        private var requestedHeight:Number;
        private var requestedWidth:Number;

        public function MovieClipLoaderAsset()
        {
            var _local_1:LoaderContext = new LoaderContext();
            _local_1.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            if (("allowLoadBytesCodeExecution" in _local_1))
            {
                _local_1["allowLoadBytesCodeExecution"] = true;
            };
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.loadBytes(movieClipData, _local_1);
            addChild(loader);
        }

        override public function get width():Number
        {
            if (!initialized)
            {
                return (initialWidth);
            };
            return (super.width);
        }

        override public function set width(_arg_1:Number):void
        {
            if (!initialized)
            {
                requestedWidth = _arg_1;
            }
            else
            {
                loader.width = _arg_1;
            };
        }

        override public function get measuredHeight():Number
        {
            return (initialHeight);
        }

        private function completeHandler(_arg_1:Event):void
        {
            initialized = true;
            initialWidth = loader.width;
            initialHeight = loader.height;
            if (!isNaN(requestedWidth))
            {
                loader.width = requestedWidth;
            };
            if (!isNaN(requestedHeight))
            {
                loader.height = requestedHeight;
            };
            dispatchEvent(_arg_1);
        }

        override public function set height(_arg_1:Number):void
        {
            if (!initialized)
            {
                requestedHeight = _arg_1;
            }
            else
            {
                loader.height = _arg_1;
            };
        }

        override public function get measuredWidth():Number
        {
            return (initialWidth);
        }

        override public function get height():Number
        {
            if (!initialized)
            {
                return (initialHeight);
            };
            return (super.height);
        }

        public function get movieClipData():ByteArray
        {
            return (null);
        }


    }
}//package mx.core

