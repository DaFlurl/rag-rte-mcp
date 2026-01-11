// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.preloaders.Preloader

package mx.preloaders
{
    import flash.display.Sprite;
    import mx.core.mx_internal;
    import flash.events.IEventDispatcher;
    import flash.utils.Timer;
    import mx.core.RSLListLoader;
    import flash.display.LoaderInfo;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import mx.core.RSLItem;
    import mx.events.RSLEvent;
    import flash.events.ErrorEvent;
    import mx.core.ResourceModuleRSLItem;
    import flash.events.TimerEvent;
    import flash.display.DisplayObject;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;

    use namespace mx_internal;

    public class Preloader extends Sprite 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var app:IEventDispatcher = null;
        private var showDisplay:Boolean;
        private var timer:Timer;
        private var rslDone:Boolean = false;
        private var displayClass:IPreloaderDisplay = null;
        private var rslListLoader:RSLListLoader;


        private function getByteValues():Object
        {
            var _local_1:LoaderInfo = root.loaderInfo;
            var _local_2:int = _local_1.bytesLoaded;
            var _local_3:int = _local_1.bytesTotal;
            var _local_4:int = ((rslListLoader) ? rslListLoader.getItemCount() : 0);
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_2 = (_local_2 + rslListLoader.getItem(_local_5).loaded);
                _local_3 = (_local_3 + rslListLoader.getItem(_local_5).total);
                _local_5++;
            };
            return ({
                "loaded":_local_2,
                "total":_local_3
            });
        }

        private function appProgressHandler(_arg_1:Event):void
        {
            dispatchEvent(new FlexEvent(FlexEvent.INIT_PROGRESS));
        }

        private function dispatchAppEndEvent(_arg_1:Object=null):void
        {
            dispatchEvent(new FlexEvent(FlexEvent.INIT_COMPLETE));
            if (!showDisplay)
            {
                displayClassCompleteHandler(null);
            };
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
        }

        private function appCreationCompleteHandler(_arg_1:FlexEvent):void
        {
            dispatchAppEndEvent();
        }

        mx_internal function rslErrorHandler(_arg_1:ErrorEvent):void
        {
            var _local_2:int = rslListLoader.getIndex();
            var _local_3:RSLItem = rslListLoader.getItem(_local_2);
            var _local_4:RSLEvent = new RSLEvent(RSLEvent.RSL_ERROR);
            _local_4.bytesLoaded = 0;
            _local_4.bytesTotal = 0;
            _local_4.rslIndex = _local_2;
            _local_4.rslTotal = rslListLoader.getItemCount();
            _local_4.url = _local_3.urlRequest;
            _local_4.errorText = decodeURI(_arg_1.text);
            dispatchEvent(_local_4);
        }

        public function initialize(_arg_1:Boolean, _arg_2:Class, _arg_3:uint, _arg_4:Number, _arg_5:Object, _arg_6:String, _arg_7:Number, _arg_8:Number, _arg_9:Array=null, _arg_10:Array=null, _arg_11:Array=null, _arg_12:Array=null):void
        {
            var _local_13:int;
            var _local_14:int;
            var _local_15:RSLItem;
            var _local_16:ResourceModuleRSLItem;
            if ((((!(_arg_9 == null)) || (!(_arg_10 == null))) && (!(_arg_11 == null))))
            {
                throw (new Error("RSLs may only be specified by using libs and sizes or rslList, not both."));
            };
            root.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            if (((_arg_9) && (_arg_9.length > 0)))
            {
                if (_arg_11 == null)
                {
                    _arg_11 = [];
                };
                _local_13 = _arg_9.length;
                _local_14 = 0;
                while (_local_14 < _local_13)
                {
                    _local_15 = new RSLItem(_arg_9[_local_14]);
                    _arg_11.push(_local_15);
                    _local_14++;
                };
            };
            if (((_arg_12) && (_arg_12.length > 0)))
            {
                _local_13 = _arg_12.length;
                _local_14 = 0;
                while (_local_14 < _local_13)
                {
                    _local_16 = new ResourceModuleRSLItem(_arg_12[_local_14]);
                    _arg_11.push(_local_16);
                    _local_14++;
                };
            };
            rslListLoader = new RSLListLoader(_arg_11);
            this.showDisplay = _arg_1;
            timer = new Timer(10);
            timer.addEventListener(TimerEvent.TIMER, timerHandler);
            timer.start();
            if (_arg_1)
            {
                displayClass = new (_arg_2)();
                displayClass.addEventListener(Event.COMPLETE, displayClassCompleteHandler);
                addChild(DisplayObject(displayClass));
                displayClass.backgroundColor = _arg_3;
                displayClass.backgroundAlpha = _arg_4;
                displayClass.backgroundImage = _arg_5;
                displayClass.backgroundSize = _arg_6;
                displayClass.stageWidth = _arg_7;
                displayClass.stageHeight = _arg_8;
                displayClass.initialize();
                displayClass.preloader = this;
            };
            if (rslListLoader.getItemCount() > 0)
            {
                rslListLoader.load(mx_internal::rslProgressHandler, mx_internal::rslCompleteHandler, mx_internal::rslErrorHandler, mx_internal::rslErrorHandler, mx_internal::rslErrorHandler);
            }
            else
            {
                rslDone = true;
            };
        }

        mx_internal function rslProgressHandler(_arg_1:ProgressEvent):void
        {
            var _local_2:int = rslListLoader.getIndex();
            var _local_3:RSLItem = rslListLoader.getItem(_local_2);
            var _local_4:RSLEvent = new RSLEvent(RSLEvent.RSL_PROGRESS);
            _local_4.bytesLoaded = _arg_1.bytesLoaded;
            _local_4.bytesTotal = _arg_1.bytesTotal;
            _local_4.rslIndex = _local_2;
            _local_4.rslTotal = rslListLoader.getItemCount();
            _local_4.url = _local_3.urlRequest;
            dispatchEvent(_local_4);
        }

        public function registerApplication(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener("validatePropertiesComplete", appProgressHandler);
            _arg_1.addEventListener("validateSizeComplete", appProgressHandler);
            _arg_1.addEventListener("validateDisplayListComplete", appProgressHandler);
            _arg_1.addEventListener(FlexEvent.CREATION_COMPLETE, appCreationCompleteHandler);
            this.app = _arg_1;
        }

        mx_internal function rslCompleteHandler(_arg_1:Event):void
        {
            var _local_2:int = rslListLoader.getIndex();
            var _local_3:RSLItem = rslListLoader.getItem(_local_2);
            var _local_4:RSLEvent = new RSLEvent(RSLEvent.RSL_COMPLETE);
            _local_4.bytesLoaded = _local_3.total;
            _local_4.bytesTotal = _local_3.total;
            _local_4.loaderInfo = (_arg_1.target as LoaderInfo);
            _local_4.rslIndex = _local_2;
            _local_4.rslTotal = rslListLoader.getItemCount();
            _local_4.url = _local_3.urlRequest;
            dispatchEvent(_local_4);
            rslDone = ((_local_2 + 1) == _local_4.rslTotal);
        }

        private function timerHandler(_arg_1:TimerEvent):void
        {
            if (!root)
            {
                return;
            };
            var _local_2:Object = getByteValues();
            var _local_3:int = _local_2.loaded;
            var _local_4:int = _local_2.total;
            dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _local_3, _local_4));
            if (((rslDone) && ((((_local_3 >= _local_4) && (_local_4 > 0)) || ((_local_4 == 0) && (_local_3 > 0))) || (((root is MovieClip) && (MovieClip(root).totalFrames > 2)) && (MovieClip(root).framesLoaded >= 2)))))
            {
                timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                timer.reset();
                dispatchEvent(new Event(Event.COMPLETE));
                dispatchEvent(new FlexEvent(FlexEvent.INIT_PROGRESS));
            };
        }

        private function displayClassCompleteHandler(_arg_1:Event):void
        {
            if (displayClass)
            {
                displayClass.removeEventListener(Event.COMPLETE, displayClassCompleteHandler);
            };
            if (root)
            {
                root.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            };
            if (app)
            {
                app.removeEventListener("validatePropertiesComplete", appProgressHandler);
                app.removeEventListener("validateSizeComplete", appProgressHandler);
                app.removeEventListener("validateDisplayListComplete", appProgressHandler);
                app.removeEventListener(FlexEvent.CREATION_COMPLETE, appCreationCompleteHandler);
                app = null;
            };
            dispatchEvent(new FlexEvent(FlexEvent.PRELOADER_DONE));
        }


    }
}//package mx.preloaders

