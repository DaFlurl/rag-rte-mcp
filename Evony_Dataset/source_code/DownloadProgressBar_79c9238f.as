// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.preloaders.DownloadProgressBar

package mx.preloaders
{
    import flash.display.Sprite;
    import mx.core.mx_internal;
    import flash.text.TextField;
    import flash.geom.Rectangle;
    import mx.graphics.RoundedRectangle;
    import flash.text.TextFormat;
    import flash.utils.getTimer;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.utils.getDefinitionByName;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.system.ApplicationDomain;
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import mx.events.RSLEvent;
    import mx.events.FlexEvent;
    import flash.display.Graphics;
    import flash.geom.Matrix;
    import flash.display.GradientType;
    import mx.graphics.RectangularDropShadow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.LoaderInfo;

    use namespace mx_internal;

    public class DownloadProgressBar extends Sprite implements IPreloaderDisplay 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var _initializingLabel:String = "Initializing";

        protected var MINIMUM_DISPLAY_TIME:uint = 0;
        private var _stageHeight:Number = 375;
        private var _stageWidth:Number = 500;
        private var _percentObj:TextField;
        private var _downloadingLabel:String = "Loading";
        private var _showProgressBar:Boolean = true;
        private var _yOffset:Number = 20;
        private var _initProgressCount:uint = 0;
        private var _barSprite:Sprite;
        private var _visible:Boolean = false;
        private var _showingDisplay:Boolean = false;
        private var _backgroundSize:String = "";
        private var _initProgressTotal:uint = 12;
        private var _startedInit:Boolean = false;
        private var _showLabel:Boolean = true;
        private var _value:Number = 0;
        private var _backgroundImage:Object;
        private var _backgroundAlpha:Number = 1;
        private var _backgroundColor:uint;
        private var _startedLoading:Boolean = false;
        private var _showPercentage:Boolean = false;
        private var _barFrameSprite:Sprite;
        protected var DOWNLOAD_PERCENTAGE:uint = 60;
        private var _displayStartCount:uint = 0;
        private var _labelObj:TextField;
        private var _maximum:Number = 0;
        private var _displayTime:int;
        private var _label:String = "";
        private var _preloader:Sprite;
        private var _xOffset:Number = 20;
        private var _startTime:int;

        private var _labelRect:Rectangle = labelRect;
        private var _percentRect:Rectangle = percentRect;
        private var _borderRect:RoundedRectangle = borderRect;
        private var _barFrameRect:RoundedRectangle = barFrameRect;
        private var _barRect:RoundedRectangle = barRect;


        public static function get initializingLabel():String
        {
            return (_initializingLabel);
        }

        public static function set initializingLabel(_arg_1:String):void
        {
            _initializingLabel = _arg_1;
        }


        protected function getPercentLoaded(_arg_1:Number, _arg_2:Number):Number
        {
            var _local_3:Number;
            if (((((_arg_1 == 0) || (_arg_2 == 0)) || (isNaN(_arg_2))) || (isNaN(_arg_1))))
            {
                return (0);
            };
            _local_3 = ((100 * _arg_1) / _arg_2);
            if (((isNaN(_local_3)) || (_local_3 <= 0)))
            {
                return (0);
            };
            if (_local_3 > 99)
            {
                return (99);
            };
            return (Math.round(_local_3));
        }

        protected function get labelFormat():TextFormat
        {
            var _local_1:TextFormat = new TextFormat();
            _local_1.color = 0x333333;
            _local_1.font = "Verdana";
            _local_1.size = 10;
            return (_local_1);
        }

        private function calcScale():void
        {
            var _local_1:Number;
            if (((stageWidth < 160) || (stageHeight < 120)))
            {
                scaleX = 1;
                scaleY = 1;
            }
            else
            {
                if (((stageWidth < 240) || (stageHeight < 150)))
                {
                    createChildren();
                    _local_1 = Math.min((stageWidth / 240), (stageHeight / 150));
                    scaleX = _local_1;
                    scaleY = _local_1;
                }
                else
                {
                    createChildren();
                };
            };
        }

        protected function get percentRect():Rectangle
        {
            return (new Rectangle(108, 4, 34, 16));
        }

        protected function set showLabel(_arg_1:Boolean):void
        {
            _showLabel = _arg_1;
            draw();
        }

        private function calcBackgroundSize():Number
        {
            var _local_2:int;
            var _local_1:Number = NaN;
            if (backgroundSize)
            {
                _local_2 = backgroundSize.indexOf("%");
                if (_local_2 != -1)
                {
                    _local_1 = Number(backgroundSize.substr(0, _local_2));
                };
            };
            return (_local_1);
        }

        private function show():void
        {
            _showingDisplay = true;
            calcScale();
            draw();
            _displayTime = getTimer();
        }

        private function loadBackgroundImage(classOrString:Object):void
        {
            var cls:Class;
            var newStyleObj:DisplayObject;
            var loader:Loader;
            var loaderContext:LoaderContext;
            if (((classOrString) && (classOrString as Class)))
            {
                cls = Class(classOrString);
                initBackgroundImage(new (cls)());
            }
            else
            {
                if (((classOrString) && (classOrString is String)))
                {
                    try
                    {
                        cls = Class(getDefinitionByName(String(classOrString)));
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
                        loader = new Loader();
                        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
                        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
                        loaderContext = new LoaderContext();
                        loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
                        loader.load(new URLRequest(String(classOrString)), loaderContext);
                    };
                };
            };
        }

        protected function set showPercentage(_arg_1:Boolean):void
        {
            _showPercentage = _arg_1;
            draw();
        }

        protected function get barFrameRect():RoundedRectangle
        {
            return (new RoundedRectangle(14, 40, 154, 4));
        }

        private function loader_ioErrorHandler(_arg_1:IOErrorEvent):void
        {
        }

        protected function rslErrorHandler(_arg_1:RSLEvent):void
        {
            _preloader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
            _preloader.removeEventListener(Event.COMPLETE, completeHandler);
            _preloader.removeEventListener(RSLEvent.RSL_PROGRESS, rslProgressHandler);
            _preloader.removeEventListener(RSLEvent.RSL_COMPLETE, rslCompleteHandler);
            _preloader.removeEventListener(RSLEvent.RSL_ERROR, rslErrorHandler);
            _preloader.removeEventListener(FlexEvent.INIT_PROGRESS, initProgressHandler);
            _preloader.removeEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
            if (!_showingDisplay)
            {
                show();
                _showingDisplay = true;
            };
            label = ((("RSL Error " + (_arg_1.rslIndex + 1)) + " of ") + _arg_1.rslTotal);
            var _local_2:ErrorField = new ErrorField(this);
            _local_2.show(_arg_1.errorText);
        }

        protected function rslCompleteHandler(_arg_1:RSLEvent):void
        {
            label = ((("Loaded library " + _arg_1.rslIndex) + " of ") + _arg_1.rslTotal);
        }

        protected function get borderRect():RoundedRectangle
        {
            return (new RoundedRectangle(0, 0, 182, 60, 4));
        }

        protected function showDisplayForDownloading(_arg_1:int, _arg_2:ProgressEvent):Boolean
        {
            return ((_arg_1 > 700) && (_arg_2.bytesLoaded < (_arg_2.bytesTotal / 2)));
        }

        protected function createChildren():void
        {
            var _local_2:TextField;
            var _local_3:TextField;
            var _local_1:Graphics = graphics;
            if (backgroundColor != 0xFFFFFFFF)
            {
                _local_1.beginFill(backgroundColor, backgroundAlpha);
                _local_1.drawRect(0, 0, stageWidth, stageHeight);
            };
            if (backgroundImage != null)
            {
                loadBackgroundImage(backgroundImage);
            };
            _barFrameSprite = new Sprite();
            _barSprite = new Sprite();
            addChild(_barFrameSprite);
            addChild(_barSprite);
            _local_1.beginFill(0xCCCCCC, 0.4);
            _local_1.drawRoundRect(calcX(_borderRect.x), calcY(_borderRect.y), _borderRect.width, _borderRect.height, (_borderRect.cornerRadius * 2), (_borderRect.cornerRadius * 2));
            _local_1.drawRoundRect(calcX((_borderRect.x + 1)), calcY((_borderRect.y + 1)), (_borderRect.width - 2), (_borderRect.height - 2), (_borderRect.cornerRadius - (1 * 2)), (_borderRect.cornerRadius - (1 * 2)));
            _local_1.endFill();
            _local_1.beginFill(0xCCCCCC, 0.4);
            _local_1.drawRoundRect(calcX((_borderRect.x + 1)), calcY((_borderRect.y + 1)), (_borderRect.width - 2), (_borderRect.height - 2), (_borderRect.cornerRadius - (1 * 2)), (_borderRect.cornerRadius - (1 * 2)));
            _local_1.endFill();
            var _local_4:Graphics = _barFrameSprite.graphics;
            var _local_5:Matrix = new Matrix();
            _local_5.createGradientBox(_barFrameRect.width, _barFrameRect.height, (Math.PI / 2), calcX(_barFrameRect.x), calcY(_barFrameRect.y));
            _local_4.beginGradientFill(GradientType.LINEAR, [6054502, 11909306], [1, 1], [0, 0xFF], _local_5);
            _local_4.drawRoundRect(calcX(_barFrameRect.x), calcY(_barFrameRect.y), _barFrameRect.width, _barFrameRect.height, (_barFrameRect.cornerRadius * 2), (_barFrameRect.cornerRadius * 2));
            _local_4.drawRoundRect(calcX((_barFrameRect.x + 1)), calcY((_barFrameRect.y + 1)), (_barFrameRect.width - 2), (_barFrameRect.height - 2), (_barFrameRect.cornerRadius * 2), (_barFrameRect.cornerRadius * 2));
            _local_4.endFill();
            _labelObj = new TextField();
            _labelObj.x = calcX(_labelRect.x);
            _labelObj.y = calcY(_labelRect.y);
            _labelObj.width = _labelRect.width;
            _labelObj.height = _labelRect.height;
            _labelObj.selectable = false;
            _labelObj.defaultTextFormat = labelFormat;
            addChild(_labelObj);
            _percentObj = new TextField();
            _percentObj.x = calcX(_percentRect.x);
            _percentObj.y = calcY(_percentRect.y);
            _percentObj.width = _percentRect.width;
            _percentObj.height = _percentRect.height;
            _percentObj.selectable = false;
            _percentObj.defaultTextFormat = percentFormat;
            addChild(_percentObj);
            var _local_6:RectangularDropShadow = new RectangularDropShadow();
            _local_6.color = 0;
            _local_6.angle = 90;
            _local_6.alpha = 0.6;
            _local_6.distance = 2;
            _local_6.tlRadius = (_local_6.trRadius = (_local_6.blRadius = (_local_6.brRadius = _borderRect.cornerRadius)));
            _local_6.drawShadow(_local_1, calcX(_borderRect.x), calcY(_borderRect.y), _borderRect.width, _borderRect.height);
            _local_1.lineStyle(1, 0xFFFFFF, 0.3);
            _local_1.moveTo((calcX(_borderRect.x) + _borderRect.cornerRadius), calcY(_borderRect.y));
            _local_1.lineTo(((calcX(_borderRect.x) - _borderRect.cornerRadius) + _borderRect.width), calcY(_borderRect.y));
        }

        private function draw():void
        {
            var _local_1:Number;
            if (_startedLoading)
            {
                if (!_startedInit)
                {
                    _local_1 = Math.round(((getPercentLoaded(_value, _maximum) * DOWNLOAD_PERCENTAGE) / 100));
                }
                else
                {
                    _local_1 = Math.round((((getPercentLoaded(_value, _maximum) * (100 - DOWNLOAD_PERCENTAGE)) / 100) + DOWNLOAD_PERCENTAGE));
                };
            }
            else
            {
                _local_1 = getPercentLoaded(_value, _maximum);
            };
            if (_labelObj)
            {
                _labelObj.text = _label;
            };
            if (_percentObj)
            {
                if (!_showPercentage)
                {
                    _percentObj.visible = false;
                    _percentObj.text = "";
                }
                else
                {
                    _percentObj.text = (String(_local_1) + "%");
                };
            };
            if (((_barSprite) && (_barFrameSprite)))
            {
                if (!_showProgressBar)
                {
                    _barSprite.visible = false;
                    _barFrameSprite.visible = false;
                }
                else
                {
                    drawProgressBar(_local_1);
                };
            };
        }

        private function timerHandler(_arg_1:Event=null):void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function hide():void
        {
        }

        public function get backgroundSize():String
        {
            return (_backgroundSize);
        }

        protected function center(_arg_1:Number, _arg_2:Number):void
        {
            _xOffset = Math.floor(((_arg_1 - _borderRect.width) / 2));
            _yOffset = Math.floor(((_arg_2 - _borderRect.height) / 2));
        }

        protected function progressHandler(_arg_1:ProgressEvent):void
        {
            var _local_2:uint = _arg_1.bytesLoaded;
            var _local_3:uint = _arg_1.bytesTotal;
            var _local_4:int = (getTimer() - _startTime);
            if (((_showingDisplay) || (showDisplayForDownloading(_local_4, _arg_1))))
            {
                if (!_startedLoading)
                {
                    show();
                    label = downloadingLabel;
                    _startedLoading = true;
                };
                setProgress(_arg_1.bytesLoaded, _arg_1.bytesTotal);
            };
        }

        protected function initProgressHandler(_arg_1:Event):void
        {
            var _local_3:Number;
            var _local_2:int = (getTimer() - _startTime);
            _initProgressCount++;
            if (((!(_showingDisplay)) && (showDisplayForInit(_local_2, _initProgressCount))))
            {
                _displayStartCount = _initProgressCount;
                show();
            }
            else
            {
                if (_showingDisplay)
                {
                    if (!_startedInit)
                    {
                        _startedInit = true;
                        label = initializingLabel;
                    };
                    _local_3 = ((100 * _initProgressCount) / (_initProgressTotal - _displayStartCount));
                    setProgress(_local_3, 100);
                };
            };
        }

        protected function set downloadingLabel(_arg_1:String):void
        {
            _downloadingLabel = _arg_1;
        }

        public function get stageWidth():Number
        {
            return (_stageWidth);
        }

        protected function get showPercentage():Boolean
        {
            return (_showPercentage);
        }

        override public function get visible():Boolean
        {
            return (_visible);
        }

        public function set stageHeight(_arg_1:Number):void
        {
            _stageHeight = _arg_1;
        }

        public function initialize():void
        {
            _startTime = getTimer();
            center(stageWidth, stageHeight);
        }

        protected function rslProgressHandler(_arg_1:RSLEvent):void
        {
        }

        protected function get barRect():RoundedRectangle
        {
            return (new RoundedRectangle(14, 39, 154, 6, 0));
        }

        protected function get percentFormat():TextFormat
        {
            var _local_1:TextFormat = new TextFormat();
            _local_1.align = "right";
            _local_1.color = 0;
            _local_1.font = "Verdana";
            _local_1.size = 10;
            return (_local_1);
        }

        public function set backgroundImage(_arg_1:Object):void
        {
            _backgroundImage = _arg_1;
        }

        private function calcX(_arg_1:Number):Number
        {
            return (_arg_1 + _xOffset);
        }

        private function calcY(_arg_1:Number):Number
        {
            return (_arg_1 + _yOffset);
        }

        public function set backgroundAlpha(_arg_1:Number):void
        {
            _backgroundAlpha = _arg_1;
        }

        private function initCompleteHandler(_arg_1:Event):void
        {
            var _local_3:Timer;
            var _local_2:int = (getTimer() - _displayTime);
            if (((_showingDisplay) && (_local_2 < MINIMUM_DISPLAY_TIME)))
            {
                _local_3 = new Timer((MINIMUM_DISPLAY_TIME - _local_2), 1);
                _local_3.addEventListener(TimerEvent.TIMER, timerHandler);
                _local_3.start();
            }
            else
            {
                timerHandler();
            };
        }

        public function set backgroundColor(_arg_1:uint):void
        {
            _backgroundColor = _arg_1;
        }

        private function initBackgroundImage(_arg_1:DisplayObject):void
        {
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            addChildAt(_arg_1, 0);
            var _local_2:Number = _arg_1.width;
            var _local_3:Number = _arg_1.height;
            var _local_4:Number = calcBackgroundSize();
            if (isNaN(_local_4))
            {
                _local_7 = 1;
                _local_8 = 1;
            }
            else
            {
                _local_9 = (_local_4 * 0.01);
                _local_7 = ((_local_9 * stageWidth) / _local_2);
                _local_8 = ((_local_9 * stageHeight) / _local_3);
            };
            _arg_1.scaleX = _local_7;
            _arg_1.scaleY = _local_8;
            var _local_5:Number = Math.round((0.5 * (stageWidth - (_local_2 * _local_7))));
            var _local_6:Number = Math.round((0.5 * (stageHeight - (_local_3 * _local_8))));
            _arg_1.x = _local_5;
            _arg_1.y = _local_6;
            if (!isNaN(backgroundAlpha))
            {
                _arg_1.alpha = backgroundAlpha;
            };
        }

        public function set backgroundSize(_arg_1:String):void
        {
            _backgroundSize = _arg_1;
        }

        protected function showDisplayForInit(_arg_1:int, _arg_2:int):Boolean
        {
            return ((_arg_1 > 300) && (_arg_2 == 2));
        }

        protected function get downloadingLabel():String
        {
            return (_downloadingLabel);
        }

        private function loader_completeHandler(_arg_1:Event):void
        {
            var _local_2:DisplayObject = DisplayObject(LoaderInfo(_arg_1.target).loader);
            initBackgroundImage(_local_2);
        }

        protected function setProgress(_arg_1:Number, _arg_2:Number):void
        {
            if (((((!(isNaN(_arg_1))) && (!(isNaN(_arg_2)))) && (_arg_1 >= 0)) && (_arg_2 > 0)))
            {
                _value = Number(_arg_1);
                _maximum = Number(_arg_2);
                draw();
            };
        }

        public function get stageHeight():Number
        {
            return (_stageHeight);
        }

        public function get backgroundImage():Object
        {
            return (_backgroundImage);
        }

        public function get backgroundAlpha():Number
        {
            if (!isNaN(_backgroundAlpha))
            {
                return (_backgroundAlpha);
            };
            return (1);
        }

        private function drawProgressBar(_arg_1:Number):void
        {
            var _local_11:Number;
            var _local_2:Graphics = _barSprite.graphics;
            _local_2.clear();
            var _local_3:Array = [0xFFFFFF, 0xFFFFFF];
            var _local_4:Array = [0, 0xFF];
            var _local_5:Matrix = new Matrix();
            var _local_6:Number = ((_barRect.width * _arg_1) / 100);
            var _local_7:Number = (_local_6 / 2);
            var _local_8:Number = (_barRect.height - 4);
            var _local_9:Number = calcX(_barRect.x);
            var _local_10:Number = (calcY(_barRect.y) + 2);
            _local_5.createGradientBox(_local_7, _local_8, 0, _local_9, _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.39, 0.85], _local_4, _local_5);
            _local_2.drawRect(_local_9, _local_10, _local_7, _local_8);
            _local_5.createGradientBox(_local_7, _local_8, 0, (_local_9 + _local_7), _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.85, 1], _local_4, _local_5);
            _local_2.drawRect((_local_9 + _local_7), _local_10, _local_7, _local_8);
            _local_7 = (_local_6 / 3);
            _local_8 = _barRect.height;
            _local_10 = calcY(_barRect.y);
            _local_11 = ((_local_10 + _local_8) - 1);
            _local_5.createGradientBox(_local_7, _local_8, 0, _local_9, _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.05, 0.15], _local_4, _local_5);
            _local_2.drawRect(_local_9, _local_10, _local_7, 1);
            _local_2.drawRect(_local_9, _local_11, _local_7, 1);
            _local_5.createGradientBox(_local_7, _local_8, 0, (_local_9 + _local_7), _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.15, 0.25], _local_4, _local_5);
            _local_2.drawRect((_local_9 + _local_7), _local_10, _local_7, 1);
            _local_2.drawRect((_local_9 + _local_7), _local_11, _local_7, 1);
            _local_5.createGradientBox(_local_7, _local_8, 0, (_local_9 + (_local_7 * 2)), _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.25, 0.1], _local_4, _local_5);
            _local_2.drawRect((_local_9 + (_local_7 * 2)), _local_10, _local_7, 1);
            _local_2.drawRect((_local_9 + (_local_7 * 2)), _local_11, _local_7, 1);
            _local_7 = (_local_6 / 3);
            _local_8 = _barRect.height;
            _local_10 = (calcY(_barRect.y) + 1);
            _local_11 = ((calcY(_barRect.y) + _local_8) - 2);
            _local_5.createGradientBox(_local_7, _local_8, 0, _local_9, _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.15, 0.3], _local_4, _local_5);
            _local_2.drawRect(_local_9, _local_10, _local_7, 1);
            _local_2.drawRect(_local_9, _local_11, _local_7, 1);
            _local_5.createGradientBox(_local_7, _local_8, 0, (_local_9 + _local_7), _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.3, 0.4], _local_4, _local_5);
            _local_2.drawRect((_local_9 + _local_7), _local_10, _local_7, 1);
            _local_2.drawRect((_local_9 + _local_7), _local_11, _local_7, 1);
            _local_5.createGradientBox(_local_7, _local_8, 0, (_local_9 + (_local_7 * 2)), _local_10);
            _local_2.beginGradientFill(GradientType.LINEAR, _local_3, [0.4, 0.25], _local_4, _local_5);
            _local_2.drawRect((_local_9 + (_local_7 * 2)), _local_10, _local_7, 1);
            _local_2.drawRect((_local_9 + (_local_7 * 2)), _local_11, _local_7, 1);
        }

        public function get backgroundColor():uint
        {
            return (_backgroundColor);
        }

        public function set stageWidth(_arg_1:Number):void
        {
            _stageWidth = _arg_1;
        }

        protected function completeHandler(_arg_1:Event):void
        {
        }

        protected function set label(_arg_1:String):void
        {
            if (!(_arg_1 is Function))
            {
                _label = _arg_1;
            };
            draw();
        }

        public function set preloader(_arg_1:Sprite):void
        {
            _preloader = _arg_1;
            _arg_1.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            _arg_1.addEventListener(Event.COMPLETE, completeHandler);
            _arg_1.addEventListener(RSLEvent.RSL_PROGRESS, rslProgressHandler);
            _arg_1.addEventListener(RSLEvent.RSL_COMPLETE, rslCompleteHandler);
            _arg_1.addEventListener(RSLEvent.RSL_ERROR, rslErrorHandler);
            _arg_1.addEventListener(FlexEvent.INIT_PROGRESS, initProgressHandler);
            _arg_1.addEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
        }

        protected function get label():String
        {
            return (_label);
        }

        protected function get labelRect():Rectangle
        {
            return (new Rectangle(14, 17, 100, 16));
        }

        override public function set visible(_arg_1:Boolean):void
        {
            if (((!(_visible)) && (_arg_1)))
            {
                show();
            }
            else
            {
                if (((_visible) && (!(_arg_1))))
                {
                    hide();
                };
            };
            _visible = _arg_1;
        }

        protected function get showLabel():Boolean
        {
            return (_showLabel);
        }


    }
}//package mx.preloaders

import flash.display.Sprite;
import mx.preloaders.DownloadProgressBar;
import flash.text.TextFormat;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.system.Capabilities;

class ErrorField extends Sprite 
{

    /*private*/ const TEXT_MARGIN_PX:int = 10;
    /*private*/ const MAX_WIDTH_INCHES:int = 6;
    /*private*/ const MIN_WIDTH_INCHES:int = 2;

    /*private*/ var downloadProgressBar:DownloadProgressBar;

    public function ErrorField(_arg_1:DownloadProgressBar)
    {
        this.downloadProgressBar = _arg_1;
    }

    protected function get labelFormat():TextFormat
    {
        var _local_1:TextFormat = new TextFormat();
        _local_1.color = 0;
        _local_1.font = "Verdana";
        _local_1.size = 10;
        return (_local_1);
    }

    public function show(_arg_1:String):void
    {
        if (((_arg_1 == null) || (_arg_1.length == 0)))
        {
            return;
        };
        var _local_2:Number = downloadProgressBar.stageWidth;
        var _local_3:Number = downloadProgressBar.stageHeight;
        var _local_4:TextField = new TextField();
        _local_4.autoSize = TextFieldAutoSize.LEFT;
        _local_4.multiline = true;
        _local_4.wordWrap = true;
        _local_4.background = true;
        _local_4.defaultTextFormat = labelFormat;
        _local_4.text = _arg_1;
        _local_4.width = Math.max((MIN_WIDTH_INCHES * Capabilities.screenDPI), (_local_2 - (TEXT_MARGIN_PX * 2)));
        _local_4.width = Math.min((MAX_WIDTH_INCHES * Capabilities.screenDPI), _local_4.width);
        _local_4.y = Math.max(0, ((_local_3 - TEXT_MARGIN_PX) - _local_4.height));
        _local_4.x = ((_local_2 - _local_4.width) / 2);
        downloadProgressBar.parent.addChild(this);
        this.addChild(_local_4);
    }


}


