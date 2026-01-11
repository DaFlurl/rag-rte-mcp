// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.ResourceLoader

package com.evony.util
{
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import flash.display.Loader;
    import flash.utils.getTimer;
    import flash.events.TimerEvent;
    import mx.core.Application;
    import mx.utils.LoaderUtil;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import mx.controls.Alert;
    import flash.events.Event;
    import flash.display.Bitmap;
    import flash.events.SecurityErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;

    public class ResourceLoader 
    {

        public static const LOAD_BACKGROUND:int = 0;
        public static const LOAD_BACKGROUND_DEMAND:int = 1;
        public static const LOAD_DEMAND:int = 2;
        public static var onDemandProgressFunc:Function = null;
        public static var onDemandBackgroundProgressFunc:Function = null;
        public static var onBackgroundProgressFunc:Function = null;
        private static var maxCocurrentNum:int = 4;
        private static var loadingFileList:Array = new Array();
        private static var loadedFileList:Dictionary = new Dictionary();
        private static var monitorTimer:Timer = null;
        private static var numStarted:int = 0;
        private static var _lastIdleStartTime:Number = 0;

        public var loadType:int = 0;
        public var started:Boolean = false;
        private var loader:Loader = null;
        public var rawUrl:String = "";
        private var _lastProgressTime:int = 0;
        private var bPendingStop:Boolean = false;

        public var callbacklist:Array = new Array();
        private var _startTime:int = getTimer();


        private static function stopAllBackgroundLoader():void
        {
            var _local_1:ResourceLoader;
            for each (_local_1 in loadingFileList)
            {
                if (((_local_1.started) && (_local_1.loadType == LOAD_BACKGROUND)))
                {
                    numStarted--;
                    _local_1.stop();
                };
            };
        }

        private static function insertLoadingList(_arg_1:ResourceLoader):void
        {
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < (loadingFileList.length - 1))
            {
                if (_arg_1.loadType == loadingFileList[_local_3].loadType) break;
                _local_2++;
                _local_3++;
            };
            loadingFileList.splice(_local_2, 0, _arg_1);
        }

        public static function getLoaded(_arg_1:String):ResourceLoader
        {
            return (loadedFileList[_arg_1]);
        }

        private static function startDemandBackgroundTask():void
        {
            var _local_2:ResourceLoader;
            var _local_1:int;
            while (((_local_1 < loadingFileList.length) && (numStarted < maxCocurrentNum)))
            {
                _local_2 = loadingFileList[_local_1];
                if (_local_2.loadType == LOAD_BACKGROUND_DEMAND)
                {
                    if (!_local_2.started)
                    {
                        _local_2.start();
                        numStarted++;
                    };
                };
                _local_1++;
            };
        }

        private static function getLoading(_arg_1:String):ResourceLoader
        {
            var _local_2:ResourceLoader;
            for each (_local_2 in loadingFileList)
            {
                if (_local_2.rawUrl == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        private static function adjustPosInLoadingList(_arg_1:ResourceLoader):void
        {
            var _local_2:int = loadingFileList.indexOf(_arg_1);
            var _local_3:int;
            while (_local_3 < loadingFileList.length)
            {
                if (_arg_1.loadType >= loadingFileList[_local_3].loadType) break;
                _local_3++;
            };
            if (_local_3 < _local_2)
            {
                loadingFileList.splice(_local_2, 1);
                loadingFileList.splice(_local_3, 0, _arg_1);
            };
        }

        public static function loadResource(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            var _local_7:Object;
            var _local_8:Object;
            var _local_9:int;
            if (monitorTimer == null)
            {
                monitorTimer = new Timer(4000);
                monitorTimer.addEventListener(TimerEvent.TIMER, onTimerCheckState);
                monitorTimer.start();
            };
            var _local_5:ResourceLoader = getLoaded(_arg_1);
            if (_local_5 != null)
            {
                _local_7 = _local_5.getSymbol(_arg_2);
                if (_arg_3 != null)
                {
                    (_arg_3(_local_7));
                };
                return;
            };
            _local_5 = getLoading(_arg_1);
            if (_local_5 != null)
            {
                _local_8 = new Object();
                _local_8.callback = _arg_3;
                _local_8.symbol = _arg_2;
                _local_5.callbacklist.push(_local_8);
                _local_9 = _local_5.loadType;
                _local_5.loadType = _arg_4;
                if (_local_9 != _arg_4)
                {
                    Object(Application.application).traceErrorMessage(((_local_5.rawUrl + " typechange to ") + _arg_4));
                };
                adjustPosInLoadingList(_local_5);
                if (_arg_4 == LOAD_DEMAND)
                {
                    stopAllDemandBackgroundLoader();
                    stopAllBackgroundLoader();
                    startDemandTask();
                }
                else
                {
                    if (_arg_4 == LOAD_BACKGROUND_DEMAND)
                    {
                        stopAllBackgroundLoader();
                        startDemandTask();
                        if (!hasDemandLoader())
                        {
                            startDemandBackgroundTask();
                        };
                    };
                };
                return;
            };
            _local_5 = new (ResourceLoader)();
            var _local_6:Object = new Object();
            _local_6.callback = _arg_3;
            _local_6.symbol = _arg_2;
            _local_5.loadType = _arg_4;
            _local_5.rawUrl = _arg_1;
            _local_5.callbacklist.push(_local_6);
            insertLoadingList(_local_5);
            if (_arg_4 == LOAD_DEMAND)
            {
                stopAllBackgroundLoader();
                stopAllDemandBackgroundLoader();
                startDemandTask();
            }
            else
            {
                if (!hasDemandLoader())
                {
                    if (hasBackGroundDemandLoader())
                    {
                        stopAllBackgroundLoader();
                        startDemandBackgroundTask();
                    }
                    else
                    {
                        startBackgroundTask();
                    };
                };
            };
        }

        public static function getNormalUrl(_arg_1:String):String
        {
            var _local_2:String;
            if (Application.application.root)
            {
                _local_2 = LoaderUtil.normalizeURL(Application.application.root.loaderInfo);
            };
            if (_local_2)
            {
                _arg_1 = LoaderUtil.createAbsoluteURL(_local_2, _arg_1);
            };
            return (_arg_1);
        }

        public static function startLoadTaskList():void
        {
            if (!hasDemandLoader())
            {
                if (!hasBackGroundDemandLoader())
                {
                    startBackgroundTask();
                }
                else
                {
                    stopAllBackgroundLoader();
                    startDemandBackgroundTask();
                };
            }
            else
            {
                stopAllDemandBackgroundLoader();
                stopAllBackgroundLoader();
                startDemandTask();
            };
        }

        private static function startBackgroundTask():void
        {
            var _local_2:ResourceLoader;
            var _local_1:int;
            while (((_local_1 < loadingFileList.length) && (numStarted < maxCocurrentNum)))
            {
                _local_2 = loadingFileList[_local_1];
                if (!_local_2.started)
                {
                    _local_2.start();
                    numStarted++;
                };
                _local_1++;
            };
        }

        public static function doCenterToParent(_arg_1:DisplayObject):void
        {
            var _local_2:Point = new Point();
            _local_2.x = (_arg_1.parent.width / 2);
            _local_2.y = (_arg_1.parent.height / 2);
            var _local_3:Point = new Point((_arg_1.x + (_arg_1.width / 2)), (_arg_1.y + (_arg_1.height / 2)));
            var _local_4:Number = (_local_2.x - _local_3.x);
            var _local_5:Number = (_local_2.y - _local_3.y);
            _arg_1.x = Math.round((_arg_1.x + _local_4));
            _arg_1.y = Math.round((_arg_1.y + _local_5));
        }

        public static function doIdlePreLoad():void
        {
            var _local_3:AnimationInfo;
            var _local_4:ResourceLoader;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < EvonyAnimation.TYPE_MAX)
            {
                _local_3 = EvonyAnimation.getAniInfoById(_local_2);
                if (_local_3 != null)
                {
                    _local_4 = getLoading(_local_3.file);
                    if (_local_4 == null)
                    {
                        _local_4 = getLoaded(_local_3.file);
                        if (_local_4 == null)
                        {
                            EvonyAnimation.preload(_local_3.id);
                            if (++_local_1 >= 3)
                            {
                                return;
                            };
                        };
                    };
                };
                _local_2++;
            };
        }

        private static function stopAllDemandBackgroundLoader():void
        {
            var _local_1:ResourceLoader;
            for each (_local_1 in loadingFileList)
            {
                if (((_local_1.started) && (_local_1.loadType == LOAD_BACKGROUND_DEMAND)))
                {
                    numStarted--;
                    _local_1.stop();
                };
            };
        }

        private static function hasBackGroundDemandLoader():Boolean
        {
            var _local_1:ResourceLoader;
            for each (_local_1 in loadingFileList)
            {
                if (_local_1.loadType == LOAD_BACKGROUND_DEMAND)
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function onTimerCheckState(_arg_1:TimerEvent):void
        {
            if (loadingFileList.length > 0)
            {
                _lastIdleStartTime = 0;
                startLoadTaskList();
            }
            else
            {
                if (_lastIdleStartTime != 0)
                {
                    if ((getTimer() - _lastIdleStartTime) > 50000)
                    {
                        doIdlePreLoad();
                        _lastIdleStartTime = 0;
                    };
                }
                else
                {
                    _lastIdleStartTime = getTimer();
                };
            };
        }

        public static function traverseMovieClip(_arg_1:Object, _arg_2:int, _arg_3:Function):int
        {
            var _local_4:int;
            var _local_5:Object;
            if ((_arg_1 is DisplayObjectContainer))
            {
                _local_4 = 0;
                while (_local_4 < _arg_1.numChildren)
                {
                    _local_5 = _arg_1.getChildAt(_local_4);
                    if ((_local_5 is DisplayObjectContainer))
                    {
                        _arg_2 = traverseMovieClip(_local_5, _arg_2, _arg_3);
                    };
                    _local_4++;
                };
            };
            if ((_arg_1 is MovieClip))
            {
                _arg_2 = _arg_3(MovieClip(_arg_1), _arg_2);
            };
            return (_arg_2);
        }

        public static function stopAllLoader(_arg_1:ResourceLoader):void
        {
            var _local_2:ResourceLoader;
            for each (_local_2 in loadingFileList)
            {
                if (((_local_2.started) && (!(_local_2 == _arg_1))))
                {
                    numStarted--;
                    _local_2.stop();
                };
            };
        }

        private static function getStartedNumber():int
        {
            var _local_2:ResourceLoader;
            var _local_1:int;
            for each (_local_2 in loadingFileList)
            {
                if (_local_2.started)
                {
                    _local_1++;
                };
            };
            return (_local_1);
        }

        private static function hasDemandLoader():Boolean
        {
            var _local_1:ResourceLoader;
            for each (_local_1 in loadingFileList)
            {
                if (_local_1.loadType == LOAD_DEMAND)
                {
                    return (true);
                };
            };
            return (false);
        }

        private static function startDemandTask():void
        {
            var _local_2:ResourceLoader;
            var _local_1:int;
            while (((_local_1 < loadingFileList.length) && (numStarted < maxCocurrentNum)))
            {
                _local_2 = loadingFileList[_local_1];
                if (((_local_2.loadType == LOAD_DEMAND) && (!(_local_2.started))))
                {
                    _local_2.start();
                    numStarted++;
                };
                _local_1++;
            };
        }


        public function getClass(sym:String):Class
        {
            var cl:Class;
            var ldr:Loader = this.loader;
            try
            {
                cl = (ldr.contentLoaderInfo.applicationDomain.getDefinition(sym) as Class);
                return (cl);
            }
            catch(err:Error)
            {
                Alert.show(err.getStackTrace(), ((((err.message + " url: ") + this.rawUrl) + " symbol:") + sym));
            };
            return (null);
        }

        private function handleLoaderInit(_arg_1:Event):void
        {
            var _local_5:Object;
            var _local_6:Function;
            var _local_8:Object;
            numStarted--;
            var _local_2:ResourceLoader = this;
            var _local_3:Function = getProgressFunc();
            if (_local_3 != null)
            {
                (_local_3(this.rawUrl, 100, 100));
            };
            var _local_4:String = _local_2.rawUrl;
            Object(Application.application).traceErrorMessage((_local_2.rawUrl + " handleLoaderInit()!"));
            loadedFileList[_local_4] = _local_2;
            for each (_local_5 in _local_2.callbacklist)
            {
                _local_3 = _local_5.callback;
                if (_local_3 != null)
                {
                    _local_8 = _local_2.getSymbol(_local_5.symbol);
                    (_local_3(_local_8));
                };
            };
            _local_6 = _local_2.getProgressFunc();
            if (_local_6 != null)
            {
                (_local_6(_local_2.rawUrl, _local_2.loader.contentLoaderInfo.bytesTotal, _local_2.loader.contentLoaderInfo.bytesTotal));
            };
            _local_2.destroy();
            var _local_7:int = loadingFileList.indexOf(_local_2);
            loadingFileList.splice(_local_7, 1);
            startLoadTaskList();
        }

        private function stop():void
        {
            var progressFunc:Function;
            var ldr:Loader;
            if (this.loader != null)
            {
                Object(Application.application).traceErrorMessage((this.rawUrl + " stop()!"));
                try
                {
                    started = false;
                    progressFunc = getProgressFunc();
                    if (progressFunc != null)
                    {
                        (progressFunc(this.rawUrl, 1, 1));
                    };
                    ldr = this.loader;
                    this.removeListners();
                    this.loader = null;
                    ldr.close();
                }
                catch(err:Error)
                {
                    Object(Application.application).traceErrorMessage(err.getStackTrace());
                };
            };
        }

        public function destroy():void
        {
            this.callbacklist = [];
            this.removeListners();
        }

        private function getSymbol(sym:String):Object
        {
            var cl:Class;
            var ldr:Loader = this.loader;
            if (((!(ldr.contentLoaderInfo.content == null)) && (ldr.contentLoaderInfo.bytesLoaded == ldr.contentLoaderInfo.bytesTotal)))
            {
                if (((!(sym == null)) && (!(sym == ""))))
                {
                    try
                    {
                        cl = (ldr.contentLoaderInfo.applicationDomain.getDefinition(sym) as Class);
                        if ((((sym.indexOf(".png") == (sym.length - 4)) || (sym.indexOf(".jpg") == (sym.length - 4))) || (sym.indexOf(".gif") == (sym.length - 4))))
                        {
                            return (new Bitmap(new (cl)(0, 0)));
                        };
                        return (new (cl)());
                    }
                    catch(err:Error)
                    {
                        Alert.show(err.getStackTrace(), ((((err.message + " url: ") + this.rawUrl) + " symbol:") + sym));
                    };
                }
                else
                {
                    if ((ldr.contentLoaderInfo.content is Bitmap))
                    {
                        return (new Bitmap(Bitmap(ldr.contentLoaderInfo.content).bitmapData));
                    };
                    return (ldr.contentLoaderInfo.content);
                };
            };
            return (null);
        }

        private function getProgressFunc():Function
        {
            if (this.loadType == LOAD_BACKGROUND_DEMAND)
            {
                return (ResourceLoader.onDemandBackgroundProgressFunc);
            };
            if (this.loadType == LOAD_DEMAND)
            {
                return (ResourceLoader.onDemandProgressFunc);
            };
            return (ResourceLoader.onBackgroundProgressFunc);
        }

        private function onSecurityError(_arg_1:SecurityErrorEvent):void
        {
            var _local_2:* = "http://macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html";
            Alert.show((((((((("Loading file failed:" + this.rawUrl) + "\n") + _arg_1.toString()) + "\n-----------------------------------\nAdd current path to:\n") + "C:\\Users\\yourname\\AppData\\Roaming\\Macromedia\\Flash Player\\#Security\\FlashPlayerTrust\\flexbuilder.cfg\n") + "C:\\Users\\yourname\\AppData\\Roaming\\Macromedia\\Flash Player\\#Security\\FlashPlayerTrust\\flexbuilder.fbr") + "\n-----------------------------------\nSee also:\n") + _local_2), "SecurityErrorEvent");
        }

        private function addListeners():void
        {
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.loader.contentLoaderInfo.addEventListener(Event.INIT, this.handleLoaderInit);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIoError);
            this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        public function start():void
        {
            var _local_1:URLRequest;
            if (started)
            {
                return;
            };
            started = true;
            if (loader == null)
            {
                _startTime = getTimer();
                this.loader = new Loader();
                this.addListeners();
                _local_1 = new URLRequest(getNormalUrl(this.rawUrl));
                this.loader.load(_local_1);
            };
        }

        private function onIoError(_arg_1:IOErrorEvent):void
        {
            Alert.show((("Files not exist: " + this.rawUrl) + "\nPlease check\n"), "IoError");
        }

        private function onProgress(_arg_1:ProgressEvent):void
        {
            var _local_2:Function = getProgressFunc();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:int = getCostTime();
            if (((this.loadType == LOAD_DEMAND) && (_local_3 < 1000)))
            {
                return;
            };
            if ((getTimer() - _lastProgressTime) >= 50)
            {
                _lastProgressTime = getTimer();
                (_local_2(this.rawUrl, _arg_1.bytesLoaded, _arg_1.bytesTotal));
            };
        }

        public function getCostTime():int
        {
            if (!started)
            {
                return (0);
            };
            return (getTimer() - _startTime);
        }

        private function removeListners():void
        {
            this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.loader.contentLoaderInfo.removeEventListener(Event.INIT, this.handleLoaderInit);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIoError);
            this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }


    }
}//package com.evony.util

