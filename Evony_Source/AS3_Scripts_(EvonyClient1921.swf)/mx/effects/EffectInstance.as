// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.EffectInstance

package mx.effects
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.events.Event;
    import mx.effects.effectClasses.PropertyChanges;
    import mx.events.EffectEvent;
    import mx.core.UIComponent;
    import flash.utils.getTimer;
    import flash.events.TimerEvent;
    import flash.utils.getQualifiedClassName;
    import mx.events.FlexEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class EffectInstance extends EventDispatcher implements IEffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _hideFocusRing:Boolean;
        private var delayStartTime:Number = 0;
        mx_internal var stopRepeat:Boolean = false;
        private var playCount:int = 0;
        private var _repeatCount:int = 0;
        private var _suspendBackgroundProcessing:Boolean = false;
        mx_internal var delayTimer:Timer;
        private var _triggerEvent:Event;
        private var _effectTargetHost:IEffectTargetHost;
        mx_internal var parentCompositeEffectInstance:EffectInstance;
        mx_internal var durationExplicitlySet:Boolean = false;
        private var _effect:IEffect;
        private var _target:Object;
        mx_internal var hideOnEffectEnd:Boolean = false;
        private var _startDelay:int = 0;
        private var delayElapsedTime:Number = 0;
        private var _repeatDelay:int = 0;
        private var _propertyChanges:PropertyChanges;
        private var _duration:Number = 500;
        private var _playReversed:Boolean;

        public function EffectInstance(_arg_1:Object)
        {
            this.target = _arg_1;
        }

        public function get playheadTime():Number
        {
            return (((Math.max((playCount - 1), 0) * duration) + (Math.max((playCount - 2), 0) * repeatDelay)) + ((playReversed) ? 0 : startDelay));
        }

        public function get hideFocusRing():Boolean
        {
            return (_hideFocusRing);
        }

        public function stop():void
        {
            if (delayTimer)
            {
                delayTimer.reset();
            };
            stopRepeat = true;
            finishEffect();
        }

        public function finishEffect():void
        {
            playCount = 0;
            dispatchEvent(new EffectEvent(EffectEvent.EFFECT_END, false, false, this));
            if (target)
            {
                target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_END, false, false, this));
            };
            if ((target is UIComponent))
            {
                UIComponent(target).effectFinished(this);
            };
            EffectManager.effectFinished(this);
        }

        public function set hideFocusRing(_arg_1:Boolean):void
        {
            _hideFocusRing = _arg_1;
        }

        public function finishRepeat():void
        {
            if ((((!(stopRepeat)) && (!(playCount == 0))) && ((playCount < repeatCount) || (repeatCount == 0))))
            {
                if (repeatDelay > 0)
                {
                    delayTimer = new Timer(repeatDelay, 1);
                    delayStartTime = getTimer();
                    delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
                    delayTimer.start();
                }
                else
                {
                    play();
                };
            }
            else
            {
                finishEffect();
            };
        }

        mx_internal function get playReversed():Boolean
        {
            return (_playReversed);
        }

        public function set effect(_arg_1:IEffect):void
        {
            _effect = _arg_1;
        }

        public function get className():String
        {
            var _local_1:String = getQualifiedClassName(this);
            var _local_2:int = _local_1.indexOf("::");
            if (_local_2 != -1)
            {
                _local_1 = _local_1.substr((_local_2 + 2));
            };
            return (_local_1);
        }

        public function set duration(_arg_1:Number):void
        {
            durationExplicitlySet = true;
            _duration = _arg_1;
        }

        mx_internal function set playReversed(_arg_1:Boolean):void
        {
            _playReversed = _arg_1;
        }

        public function resume():void
        {
            if ((((delayTimer) && (!(delayTimer.running))) && (!(isNaN(delayElapsedTime)))))
            {
                delayTimer.delay = ((playReversed) ? delayElapsedTime : (delayTimer.delay - delayElapsedTime));
                delayTimer.start();
            };
        }

        public function get propertyChanges():PropertyChanges
        {
            return (_propertyChanges);
        }

        public function set target(_arg_1:Object):void
        {
            _target = _arg_1;
        }

        public function get repeatCount():int
        {
            return (_repeatCount);
        }

        mx_internal function playWithNoDuration():void
        {
            duration = 0;
            repeatCount = 1;
            repeatDelay = 0;
            startDelay = 0;
            startEffect();
        }

        public function get startDelay():int
        {
            return (_startDelay);
        }

        mx_internal function get actualDuration():Number
        {
            var _local_1:Number = NaN;
            if (repeatCount > 0)
            {
                _local_1 = (((duration * repeatCount) + ((repeatDelay * repeatCount) - 1)) + startDelay);
            };
            return (_local_1);
        }

        public function play():void
        {
            playCount++;
            dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START, false, false, this));
            if (target)
            {
                target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START, false, false, this));
            };
        }

        public function get suspendBackgroundProcessing():Boolean
        {
            return (_suspendBackgroundProcessing);
        }

        public function get effectTargetHost():IEffectTargetHost
        {
            return (_effectTargetHost);
        }

        public function set repeatDelay(_arg_1:int):void
        {
            _repeatDelay = _arg_1;
        }

        public function set propertyChanges(_arg_1:PropertyChanges):void
        {
            _propertyChanges = _arg_1;
        }

        mx_internal function eventHandler(_arg_1:Event):void
        {
            if (((_arg_1.type == FlexEvent.SHOW) && (hideOnEffectEnd == true)))
            {
                hideOnEffectEnd = false;
                _arg_1.target.removeEventListener(FlexEvent.SHOW, eventHandler);
            };
        }

        public function set repeatCount(_arg_1:int):void
        {
            _repeatCount = _arg_1;
        }

        private function delayTimerHandler(_arg_1:TimerEvent):void
        {
            delayTimer.reset();
            delayStartTime = NaN;
            delayElapsedTime = NaN;
            play();
        }

        public function set suspendBackgroundProcessing(_arg_1:Boolean):void
        {
            _suspendBackgroundProcessing = _arg_1;
        }

        public function set triggerEvent(_arg_1:Event):void
        {
            _triggerEvent = _arg_1;
        }

        public function set startDelay(_arg_1:int):void
        {
            _startDelay = _arg_1;
        }

        public function get effect():IEffect
        {
            return (_effect);
        }

        public function set effectTargetHost(_arg_1:IEffectTargetHost):void
        {
            _effectTargetHost = _arg_1;
        }

        public function get target():Object
        {
            return (_target);
        }

        public function startEffect():void
        {
            EffectManager.effectStarted(this);
            if ((target is UIComponent))
            {
                UIComponent(target).effectStarted(this);
            };
            if (((startDelay > 0) && (!(playReversed))))
            {
                delayTimer = new Timer(startDelay, 1);
                delayStartTime = getTimer();
                delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
                delayTimer.start();
            }
            else
            {
                play();
            };
        }

        public function get repeatDelay():int
        {
            return (_repeatDelay);
        }

        public function get duration():Number
        {
            if (((!(durationExplicitlySet)) && (parentCompositeEffectInstance)))
            {
                return (parentCompositeEffectInstance.duration);
            };
            return (_duration);
        }

        public function initEffect(_arg_1:Event):void
        {
            triggerEvent = _arg_1;
            switch (_arg_1.type)
            {
                case "resizeStart":
                case "resizeEnd":
                    if (!durationExplicitlySet)
                    {
                        duration = 250;
                    };
                    return;
                case FlexEvent.HIDE:
                    target.setVisible(true, true);
                    hideOnEffectEnd = true;
                    target.addEventListener(FlexEvent.SHOW, eventHandler);
                    return;
            };
        }

        public function get triggerEvent():Event
        {
            return (_triggerEvent);
        }

        public function end():void
        {
            if (delayTimer)
            {
                delayTimer.reset();
            };
            stopRepeat = true;
            finishEffect();
        }

        public function reverse():void
        {
            if (repeatCount > 0)
            {
                playCount = ((repeatCount - playCount) + 1);
            };
        }

        public function pause():void
        {
            if ((((delayTimer) && (delayTimer.running)) && (!(isNaN(delayStartTime)))))
            {
                delayTimer.stop();
                delayElapsedTime = (getTimer() - delayStartTime);
            };
        }


    }
}//package mx.effects

