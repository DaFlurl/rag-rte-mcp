// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.CompositeEffectInstance

package mx.effects.effectClasses
{
    import mx.effects.EffectInstance;
    import mx.effects.Tween;
    import flash.events.Event;
    import mx.events.EffectEvent;
    import mx.effects.IEffectInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CompositeEffectInstance extends EffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _playheadTime:Number = 0;
        mx_internal var timerTween:Tween;
        mx_internal var endEffectCalled:Boolean;

        mx_internal var activeEffectQueue:Array = [];
        mx_internal var childSets:Array = [];

        public function CompositeEffectInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function get playheadTime():Number
        {
            return (_playheadTime + super.playheadTime);
        }

        override mx_internal function get actualDuration():Number
        {
            var _local_1:Number = NaN;
            if (repeatCount > 0)
            {
                _local_1 = (((durationWithoutRepeat * repeatCount) + ((repeatDelay * repeatCount) - 1)) + startDelay);
            };
            return (_local_1);
        }

        override public function play():void
        {
            timerTween = new Tween(this, 0, 0, durationWithoutRepeat);
            super.play();
        }

        override public function finishEffect():void
        {
            activeEffectQueue = null;
            super.finishEffect();
        }

        mx_internal function hasRotateInstance():Boolean
        {
            var _local_1:int;
            var _local_2:CompositeEffectInstance;
            if (childSets)
            {
                _local_1 = 0;
                while (_local_1 < childSets.length)
                {
                    if (childSets[_local_1].length > 0)
                    {
                        _local_2 = (childSets[_local_1][0] as CompositeEffectInstance);
                        if (((childSets[_local_1][0] is RotateInstance) || ((_local_2) && (_local_2.hasRotateInstance()))))
                        {
                            return (true);
                        };
                    };
                    _local_1++;
                };
            };
            return (false);
        }

        mx_internal function get durationWithoutRepeat():Number
        {
            return (0);
        }

        override public function initEffect(_arg_1:Event):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_6:int;
            super.initEffect(_arg_1);
            var _local_2:int = childSets.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = childSets[_local_3];
                _local_5 = _local_4.length;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_4[_local_6].initEffect(_arg_1);
                    _local_6++;
                };
                _local_3++;
            };
        }

        override public function stop():void
        {
            super.stop();
            if (timerTween)
            {
                timerTween.stop();
            };
        }

        override public function reverse():void
        {
            super.reverse();
            super.playReversed = (!(playReversed));
            if (timerTween)
            {
                timerTween.reverse();
            };
        }

        public function addChildSet(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1)
            {
                _local_2 = _arg_1.length;
                if (_local_2 > 0)
                {
                    if (!childSets)
                    {
                        childSets = [_arg_1];
                    }
                    else
                    {
                        childSets.push(_arg_1);
                    };
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _arg_1[_local_3].addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                        _arg_1[_local_3].parentCompositeEffectInstance = this;
                        _local_3++;
                    };
                };
            };
        }

        protected function onEffectEnd(_arg_1:IEffectInstance):void
        {
        }

        override mx_internal function playWithNoDuration():void
        {
            super.playWithNoDuration();
            end();
        }

        public function onTweenUpdate(_arg_1:Object):void
        {
            _playheadTime = ((timerTween) ? timerTween.playheadTime : _playheadTime);
        }

        override public function pause():void
        {
            super.pause();
            if (timerTween)
            {
                timerTween.pause();
            };
        }

        mx_internal function effectEndHandler(_arg_1:EffectEvent):void
        {
            onEffectEnd(_arg_1.effectInstance);
        }

        override public function resume():void
        {
            super.resume();
            if (timerTween)
            {
                timerTween.resume();
            };
        }

        public function onTweenEnd(_arg_1:Object):void
        {
            _playheadTime = ((timerTween) ? timerTween.playheadTime : _playheadTime);
        }


    }
}//package mx.effects.effectClasses

