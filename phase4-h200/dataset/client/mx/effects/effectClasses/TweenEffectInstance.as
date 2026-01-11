// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.TweenEffectInstance

package mx.effects.effectClasses
{
    import mx.effects.EffectInstance;
    import mx.effects.Tween;
    import mx.events.TweenEvent;
    import mx.core.UIComponentGlobals;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TweenEffectInstance extends EffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _seekTime:Number = 0;
        public var easingFunction:Function;
        public var tween:Tween;
        mx_internal var needToLayout:Boolean = false;

        public function TweenEffectInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function stop():void
        {
            super.stop();
            if (tween)
            {
                tween.stop();
            };
        }

        mx_internal function applyTweenStartValues():void
        {
            if (duration > 0)
            {
                onTweenUpdate(tween.getCurrentValue(0));
            };
        }

        override public function get playheadTime():Number
        {
            if (tween)
            {
                return (tween.playheadTime + super.playheadTime);
            };
            return (0);
        }

        protected function createTween(_arg_1:Object, _arg_2:Object, _arg_3:Object, _arg_4:Number=-1, _arg_5:Number=-1):Tween
        {
            var _local_6:Tween = new Tween(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            _local_6.addEventListener(TweenEvent.TWEEN_START, tweenEventHandler);
            _local_6.addEventListener(TweenEvent.TWEEN_UPDATE, tweenEventHandler);
            _local_6.addEventListener(TweenEvent.TWEEN_END, tweenEventHandler);
            if (easingFunction != null)
            {
                _local_6.easingFunction = easingFunction;
            };
            if (_seekTime > 0)
            {
                _local_6.seek(_seekTime);
            };
            _local_6.playReversed = playReversed;
            return (_local_6);
        }

        private function tweenEventHandler(_arg_1:TweenEvent):void
        {
            dispatchEvent(_arg_1);
        }

        override public function end():void
        {
            stopRepeat = true;
            if (delayTimer)
            {
                delayTimer.reset();
            };
            if (tween)
            {
                tween.endTween();
                tween = null;
            };
        }

        override public function reverse():void
        {
            super.reverse();
            if (tween)
            {
                tween.reverse();
            };
            super.playReversed = (!(playReversed));
        }

        override mx_internal function set playReversed(_arg_1:Boolean):void
        {
            super.playReversed = _arg_1;
            if (tween)
            {
                tween.playReversed = _arg_1;
            };
        }

        override public function resume():void
        {
            super.resume();
            if (tween)
            {
                tween.resume();
            };
        }

        public function onTweenEnd(_arg_1:Object):void
        {
            onTweenUpdate(_arg_1);
            tween = null;
            if (needToLayout)
            {
                UIComponentGlobals.layoutManager.validateNow();
            };
            finishRepeat();
        }

        public function onTweenUpdate(_arg_1:Object):void
        {
        }

        override public function pause():void
        {
            super.pause();
            if (tween)
            {
                tween.pause();
            };
        }

        public function seek(_arg_1:Number):void
        {
            if (tween)
            {
                tween.seek(_arg_1);
            }
            else
            {
                _seekTime = _arg_1;
            };
        }


    }
}//package mx.effects.effectClasses

