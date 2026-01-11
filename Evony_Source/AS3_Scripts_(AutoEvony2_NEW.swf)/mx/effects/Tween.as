// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Tween

package mx.effects
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import mx.core.UIComponentGlobals;
    import mx.events.TweenEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Tween extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var activeTweens:Array = [];
        private static var interval:Number = 10;
        private static var timer:Timer = null;
        mx_internal static var intervalTime:Number = NaN;

        private var started:Boolean = false;
        private var previousUpdateTime:Number;
        public var duration:Number = 3000;
        private var id:int;
        private var arrayMode:Boolean;
        private var _isPlaying:Boolean = true;
        private var startValue:Object;
        public var listener:Object;
        private var userEquation:Function = defaultEasingFunction;
        mx_internal var needToLayout:Boolean = false;
        private var updateFunction:Function;
        private var _doSeek:Boolean = false;
        mx_internal var startTime:Number;
        private var endFunction:Function;
        private var endValue:Object;
        private var _doReverse:Boolean = false;
        private var _playheadTime:Number = 0;
        private var _invertValues:Boolean = false;
        private var maxDelay:Number = 87.5;

        public function Tween(_arg_1:Object, _arg_2:Object, _arg_3:Object, _arg_4:Number=-1, _arg_5:Number=-1, _arg_6:Function=null, _arg_7:Function=null)
        {
            if (!_arg_1)
            {
                return;
            };
            if ((_arg_2 is Array))
            {
                arrayMode = true;
            };
            this.listener = _arg_1;
            this.startValue = _arg_2;
            this.endValue = _arg_3;
            if (((!(isNaN(_arg_4))) && (!(_arg_4 == -1))))
            {
                this.duration = _arg_4;
            };
            if (((!(isNaN(_arg_5))) && (!(_arg_5 == -1))))
            {
                maxDelay = (1000 / _arg_5);
            };
            this.updateFunction = _arg_6;
            this.endFunction = _arg_7;
            if (_arg_4 == 0)
            {
                id = -1;
                endTween();
            }
            else
            {
                Tween.addTween(this);
            };
        }

        mx_internal static function removeTween(_arg_1:Tween):void
        {
            removeTweenAt(_arg_1.id);
        }

        private static function addTween(_arg_1:Tween):void
        {
            _arg_1.id = activeTweens.length;
            activeTweens.push(_arg_1);
            if (!timer)
            {
                timer = new Timer(interval);
                timer.addEventListener(TimerEvent.TIMER, timerHandler);
                timer.start();
            }
            else
            {
                timer.start();
            };
            if (isNaN(intervalTime))
            {
                intervalTime = getTimer();
            };
            _arg_1.startTime = (_arg_1.previousUpdateTime = intervalTime);
        }

        private static function timerHandler(_arg_1:TimerEvent):void
        {
            var _local_6:Tween;
            var _local_2:Boolean;
            var _local_3:Number = intervalTime;
            intervalTime = getTimer();
            var _local_4:int = activeTweens.length;
            var _local_5:int = _local_4;
            while (_local_5 >= 0)
            {
                _local_6 = Tween(activeTweens[_local_5]);
                if (_local_6)
                {
                    _local_6.needToLayout = false;
                    _local_6.doInterval();
                    if (_local_6.needToLayout)
                    {
                        _local_2 = true;
                    };
                };
                _local_5--;
            };
            if (_local_2)
            {
                UIComponentGlobals.layoutManager.validateNow();
            };
            _arg_1.updateAfterEvent();
        }

        private static function removeTweenAt(_arg_1:int):void
        {
            var _local_4:Tween;
            if (((_arg_1 >= activeTweens.length) || (_arg_1 < 0)))
            {
                return;
            };
            activeTweens.splice(_arg_1, 1);
            var _local_2:int = activeTweens.length;
            var _local_3:int = _arg_1;
            while (_local_3 < _local_2)
            {
                _local_4 = Tween(activeTweens[_local_3]);
                _local_4.id--;
                _local_3++;
            };
            if (_local_2 == 0)
            {
                intervalTime = NaN;
                timer.reset();
            };
        }


        mx_internal function get playheadTime():Number
        {
            return (_playheadTime);
        }

        public function stop():void
        {
            if (id >= 0)
            {
                Tween.removeTweenAt(id);
            };
        }

        mx_internal function get playReversed():Boolean
        {
            return (_invertValues);
        }

        mx_internal function set playReversed(_arg_1:Boolean):void
        {
            _invertValues = _arg_1;
        }

        public function resume():void
        {
            _isPlaying = true;
            startTime = (intervalTime - _playheadTime);
            if (_doReverse)
            {
                reverse();
                _doReverse = false;
            };
        }

        public function setTweenHandlers(_arg_1:Function, _arg_2:Function):void
        {
            this.updateFunction = _arg_1;
            this.endFunction = _arg_2;
        }

        private function defaultEasingFunction(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number
        {
            return (((_arg_3 / 2) * (Math.sin((Math.PI * ((_arg_1 / _arg_4) - 0.5))) + 1)) + _arg_2);
        }

        public function set easingFunction(_arg_1:Function):void
        {
            userEquation = _arg_1;
        }

        public function endTween():void
        {
            var _local_1:TweenEvent = new TweenEvent(TweenEvent.TWEEN_END);
            var _local_2:Object = getCurrentValue(duration);
            _local_1.value = _local_2;
            dispatchEvent(_local_1);
            if (endFunction != null)
            {
                endFunction(_local_2);
            }
            else
            {
                listener.onTweenEnd(_local_2);
            };
            if (id >= 0)
            {
                Tween.removeTweenAt(id);
            };
        }

        public function reverse():void
        {
            if (_isPlaying)
            {
                _doReverse = false;
                seek((duration - _playheadTime));
                _invertValues = (!(_invertValues));
            }
            else
            {
                _doReverse = (!(_doReverse));
            };
        }

        mx_internal function getCurrentValue(_arg_1:Number):Object
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:int;
            if (duration == 0)
            {
                return (endValue);
            };
            if (_invertValues)
            {
                _arg_1 = (duration - _arg_1);
            };
            if (arrayMode)
            {
                _local_2 = [];
                _local_3 = startValue.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_2[_local_4] = userEquation(_arg_1, startValue[_local_4], (endValue[_local_4] - startValue[_local_4]), duration);
                    _local_4++;
                };
                return (_local_2);
            };
            return (userEquation(_arg_1, startValue, (Number(endValue) - Number(startValue)), duration));
        }

        mx_internal function doInterval():Boolean
        {
            var _local_2:Number;
            var _local_3:Object;
            var _local_4:TweenEvent;
            var _local_5:TweenEvent;
            var _local_1:Boolean;
            previousUpdateTime = intervalTime;
            if (((_isPlaying) || (_doSeek)))
            {
                _local_2 = (intervalTime - startTime);
                _playheadTime = _local_2;
                _local_3 = getCurrentValue(_local_2);
                if (((_local_2 >= duration) && (!(_doSeek))))
                {
                    endTween();
                    _local_1 = true;
                }
                else
                {
                    if (!started)
                    {
                        _local_5 = new TweenEvent(TweenEvent.TWEEN_START);
                        dispatchEvent(_local_5);
                        started = true;
                    };
                    _local_4 = new TweenEvent(TweenEvent.TWEEN_UPDATE);
                    _local_4.value = _local_3;
                    dispatchEvent(_local_4);
                    if (updateFunction != null)
                    {
                        updateFunction(_local_3);
                    }
                    else
                    {
                        listener.onTweenUpdate(_local_3);
                    };
                };
                _doSeek = false;
            };
            return (_local_1);
        }

        public function pause():void
        {
            _isPlaying = false;
        }

        public function seek(_arg_1:Number):void
        {
            var _local_2:Number = intervalTime;
            previousUpdateTime = _local_2;
            startTime = (_local_2 - _arg_1);
            _doSeek = true;
        }


    }
}//package mx.effects

