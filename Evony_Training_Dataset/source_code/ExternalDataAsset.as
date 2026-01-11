// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.utilities.external.ExternalDataAsset

package com.degrafa.utilities.external
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.core.IDegrafaObject;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.display.Loader;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class ExternalDataAsset extends DegrafaObject implements IDegrafaObject 
    {

        public static const STATUS_WAITING:String = "itemWaiting";
        public static const STATUS_REQUESTED:String = "itemRequested";
        public static const STATUS_STARTED:String = "itemLoadStarted";
        public static const STATUS_PROGRESS:String = "itemLoadProgress";
        public static const STATUS_INITIALIZING:String = "itemInitializing";
        public static const STATUS_READY:String = "itemReady";
        public static const STATUS_IDENTIFIED:String = "itemIdentified";
        public static const STATUS_LOAD_ERROR:String = "itemLoadError";
        public static const STATUS_SECURITY_ERROR:String = "itemSecurityError";
        public static const STATUS_DATA_ERROR:String = "itemDataError";
        public static const TYPE_UNKNOWN:String = "unknown";
        public static const TYPE_SWF:String = "application/x-shockwave-flash";
        public static const TYPE_IMAGE_JPEG:String = "image/jpeg";
        public static const TYPE_IMAGE_PNG:String = "image/png";
        public static const TYPE_IMAGE_GIF:String = "image/gif";
        public static var requestBitmapDataAccess:LoaderContext = new LoaderContext(true);
        private static var _uniqueInstances:Dictionary = new Dictionary();

        protected var dataType:Class;
        protected var _data:Object;
        private var _externalSize:Boolean = false;
        private var _status:String;
        private var _loadingLocation:LoadingLocation;
        private var _bytesTotalExternal:Number = NaN;
        private var _mimeType:String;
        protected var _url:String;
        private var _loader:Object;

        public function ExternalDataAsset(_arg_1:String=null, _arg_2:Number=NaN, _arg_3:Class=null)
        {
            if (_arg_1 != null)
            {
                _url = _arg_1;
            };
            _loader = new (_arg_3)();
            _mimeType = ExternalDataAsset.TYPE_UNKNOWN;
            _status = ExternalDataAsset.STATUS_WAITING;
            if (!isNaN(_arg_2))
            {
                _bytesTotalExternal = Math.floor(_arg_2);
                _externalSize = true;
            };
        }

        protected static function getUniqueInstance(_arg_1:String=null, _arg_2:LoadingLocation=null, _arg_3:Class=null):ExternalDataAsset
        {
            if (!_uniqueInstances[_arg_3])
            {
                _uniqueInstances[_arg_3] = new Dictionary();
            };
            if ((((_arg_1) && (_uniqueInstances[_arg_3][_arg_1])) && (_uniqueInstances[_arg_3][_arg_1].loadingLocation === _arg_2)))
            {
                return (_uniqueInstances[_arg_3][_arg_1]);
            };
            _uniqueInstances[_arg_3][_arg_1] = new _arg_3(_arg_1);
            if (_arg_2)
            {
                _uniqueInstances[_arg_3][_arg_1].loadingLocation = _arg_2;
            };
            return (_uniqueInstances[_arg_3][_arg_1]);
        }


        public function get content():Object
        {
            if (_status == ExternalDataAsset.STATUS_READY)
            {
                return (_data as dataType);
            };
            if (_status == ExternalDataAsset.STATUS_WAITING)
            {
                load();
            };
            return (false);
        }

        protected function reset():Boolean
        {
            if (!((_status == ExternalDataAsset.STATUS_WAITING) || (_status == ExternalDataAsset.STATUS_READY)))
            {
                removeListeners();
                _loader.close();
            };
            var _local_1:* = (!(_status == ExternalDataAsset.STATUS_WAITING));
            _status = ExternalDataAsset.STATUS_WAITING;
            _bytesTotalExternal = NaN;
            _mimeType = ExternalDataAsset.TYPE_UNKNOWN;
            return (_local_1);
        }

        private function onSecurityError(_arg_1:Event):void
        {
            _status = ExternalDataAsset.STATUS_SECURITY_ERROR;
            removeListeners();
            dispatchEvent(new Event(ExternalDataAsset.STATUS_SECURITY_ERROR));
        }

        protected function cleanUp():void
        {
        }

        private function onLoadInit(_arg_1:Event):void
        {
            checkContentType();
            _status = ExternalDataAsset.STATUS_INITIALIZING;
            checkContentType();
            dispatchEvent(new Event(ExternalDataAsset.STATUS_INITIALIZING));
        }

        public function get bytesLoaded():Number
        {
            if (!((_status == ExternalDataAsset.STATUS_WAITING) || (_status == ExternalDataAsset.STATUS_REQUESTED)))
            {
                return (_loader.contentLoaderInfo.bytesLoaded);
            };
            return (0);
        }

        public function get loadingLocation():LoadingLocation
        {
            return (_loadingLocation);
        }

        private function removeListeners():void
        {
            var target:Object;
            if ((_loader is URLLoader))
            {
                target = (_loader as URLLoader);
            }
            else
            {
                if ((_loader is Loader))
                {
                    target = (_loader as Loader).contentLoaderInfo;
                };
            };
            if (hasEventListener(Event.OPEN))
            {
                var _local_2:* = target;
                with (_local_2)
                {
                    removeEventListener(Event.OPEN, onLoadStart);
                    removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
                    removeEventListener(Event.COMPLETE, onLoadComplete);
                    removeEventListener(Event.INIT, onLoadInit);
                    removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
                };
                if ((target is URLLoader))
                {
                    (target as URLLoader).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                };
            };
        }

        private function addListeners():void
        {
            var target:Object;
            if ((_loader is URLLoader))
            {
                target = (_loader as URLLoader);
            }
            else
            {
                if ((_loader is Loader))
                {
                    target = (_loader as Loader).contentLoaderInfo;
                };
            };
            if (!target.hasEventListener(Event.OPEN))
            {
                var _local_2:* = target;
                with (_local_2)
                {
                    addEventListener(Event.OPEN, onLoadStart);
                    addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
                    addEventListener(Event.COMPLETE, onLoadComplete);
                    addEventListener(Event.INIT, onLoadInit);
                    addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
                };
                if ((target is URLLoader))
                {
                    (target as URLLoader).addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                };
            };
        }

        public function set url(_arg_1:String):void
        {
            if (_url != _arg_1)
            {
                _url = _arg_1;
                if (reset())
                {
                    load();
                };
            };
        }

        public function load():void
        {
            var _local_1:String;
            if (_url.length)
            {
                addListeners();
                if (_loadingLocation)
                {
                    if (!_loadingLocation.requestedPolicyFile)
                    {
                        _loadingLocation.requestPolicyFile();
                    };
                    _local_1 = (_loadingLocation.basePath + _url);
                }
                else
                {
                    _local_1 = _url;
                };
                if ((_loader is Loader))
                {
                    (_loader as Loader).load(new URLRequest(_local_1), requestBitmapDataAccess);
                }
                else
                {
                    (_loader as URLLoader).load(new URLRequest(_local_1));
                };
                _status = ExternalDataAsset.STATUS_REQUESTED;
                dispatchEvent(new Event(ExternalDataAsset.STATUS_REQUESTED));
            };
        }

        public function get bytesTotal():Number
        {
            if (!((_status == ExternalDataAsset.STATUS_WAITING) || (_status == ExternalDataAsset.STATUS_REQUESTED)))
            {
                return (_loader.contentLoaderInfo.bytesTotal);
            };
            return (_bytesTotalExternal);
        }

        public function set loadingLocation(_arg_1:LoadingLocation):void
        {
            if (_arg_1)
            {
                _loadingLocation = _arg_1;
            };
        }

        private function onLoadError(_arg_1:IOErrorEvent):void
        {
            _status = ExternalDataAsset.STATUS_LOAD_ERROR;
            dispatchEvent(new Event(ExternalDataAsset.STATUS_LOAD_ERROR));
            removeListeners();
        }

        private function checkContentType():void
        {
            if ((_loader is URLLoader))
            {
                return;
            };
            if (((_mimeType == ExternalDataAsset.TYPE_UNKNOWN) && (!(_loader.contentLoaderInfo.contentType == null))))
            {
                _mimeType = _loader.contentLoaderInfo.contentType;
                dispatchEvent(new Event(ExternalDataAsset.STATUS_IDENTIFIED));
            };
        }

        public function get url():String
        {
            return (_url);
        }

        protected function processLoad(_arg_1:Object):String
        {
            return (ExternalDataAsset.STATUS_READY);
        }

        private function onLoadProgress(_arg_1:ProgressEvent):void
        {
            checkContentType();
            _status = ExternalDataAsset.STATUS_PROGRESS;
            dispatchEvent(new ProgressEvent(ExternalDataAsset.STATUS_PROGRESS, false, false, _arg_1.bytesLoaded, _arg_1.bytesTotal));
        }

        private function onLoadStart(_arg_1:Event):void
        {
            _status = ExternalDataAsset.STATUS_STARTED;
            checkContentType();
            dispatchEvent(new Event(ExternalDataAsset.STATUS_STARTED));
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            checkContentType();
            _status = processLoad(_loader);
            switch (_status)
            {
                case ExternalDataAsset.STATUS_READY:
                    dispatchEvent(new Event(ExternalDataAsset.STATUS_READY));
                    cleanUp();
                    removeListeners();
                    return;
                case ExternalDataAsset.STATUS_SECURITY_ERROR:
                    removeListeners();
                    dispatchEvent(new Event(ExternalDataAsset.STATUS_SECURITY_ERROR));
                    return;
            };
        }


    }
}//package com.degrafa.utilities.external

