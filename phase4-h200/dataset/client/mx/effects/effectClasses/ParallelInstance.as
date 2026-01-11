// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.ParallelInstance

package mx.effects.effectClasses
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import mx.effects.EffectInstance;
    import mx.core.UIComponent;
    import mx.effects.IEffectInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ParallelInstance extends CompositeEffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var timer:Timer;
        private var isReversed:Boolean = false;
        private var replayEffectQueue:Array;
        private var doneEffectQueue:Array;

        public function ParallelInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function stop():void
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:int;
            stopTimer();
            if (activeEffectQueue)
            {
                _local_1 = activeEffectQueue.concat();
                activeEffectQueue = null;
                _local_2 = _local_1.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (_local_1[_local_3])
                    {
                        _local_1[_local_3].stop();
                    };
                    _local_3++;
                };
            };
            super.stop();
        }

        private function startTimer():void
        {
            if (!timer)
            {
                timer = new Timer(10);
                timer.addEventListener(TimerEvent.TIMER, timerHandler);
            };
            timer.start();
        }

        override mx_internal function get durationWithoutRepeat():Number
        {
            var _local_4:Array;
            var _local_1:Number = 0;
            var _local_2:int = childSets.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = childSets[_local_3];
                _local_1 = Math.max(_local_4[0].actualDuration, _local_1);
                _local_3++;
            };
            return (_local_1);
        }

        private function timerHandler(_arg_1:TimerEvent):void
        {
            var _local_5:EffectInstance;
            var _local_2:Number = (durationWithoutRepeat - playheadTime);
            var _local_3:int = replayEffectQueue.length;
            if (_local_3 == 0)
            {
                stopTimer();
                return;
            };
            var _local_4:int = (_local_3 - 1);
            while (_local_4 >= 0)
            {
                _local_5 = replayEffectQueue[_local_4];
                if (_local_2 <= _local_5.actualDuration)
                {
                    activeEffectQueue.push(_local_5);
                    replayEffectQueue.splice(_local_4, 1);
                    _local_5.playReversed = playReversed;
                    _local_5.startEffect();
                };
                _local_4--;
            };
        }

        private function stopTimer():void
        {
            if (timer)
            {
                timer.reset();
            };
        }

        override public function addChildSet(_arg_1:Array):void
        {
            var _local_2:CompositeEffectInstance;
            super.addChildSet(_arg_1);
            if (_arg_1.length > 0)
            {
                _local_2 = (_arg_1[0] as CompositeEffectInstance);
                if (((_arg_1[0] is RotateInstance) || ((!(_local_2 == null)) && (_local_2.hasRotateInstance()))))
                {
                    childSets.pop();
                    childSets.unshift(_arg_1);
                };
            };
        }

        override public function reverse():void
        {
            var _local_1:int;
            var _local_2:int;
            super.reverse();
            if (isReversed)
            {
                _local_1 = activeEffectQueue.length;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    activeEffectQueue[_local_2].reverse();
                    _local_2++;
                };
                stopTimer();
            }
            else
            {
                replayEffectQueue = doneEffectQueue.splice(0);
                _local_1 = activeEffectQueue.length;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    activeEffectQueue[_local_2].reverse();
                    _local_2++;
                };
                startTimer();
            };
            isReversed = (!(isReversed));
        }

        override public function end():void
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:int;
            endEffectCalled = true;
            stopTimer();
            if (activeEffectQueue)
            {
                _local_1 = activeEffectQueue.concat();
                activeEffectQueue = null;
                _local_2 = _local_1.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    if (_local_1[_local_3])
                    {
                        _local_1[_local_3].end();
                    };
                    _local_3++;
                };
            };
            super.end();
        }

        override protected function onEffectEnd(_arg_1:IEffectInstance):void
        {
            if (Object(_arg_1).suspendBackgroundProcessing)
            {
                UIComponent.resumeBackgroundProcessing();
            };
            if (((endEffectCalled) || (activeEffectQueue == null)))
            {
                return;
            };
            var _local_2:int = activeEffectQueue.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (_arg_1 == activeEffectQueue[_local_3])
                {
                    doneEffectQueue.push(_arg_1);
                    activeEffectQueue.splice(_local_3, 1);
                    break;
                };
                _local_3++;
            };
            if (_local_2 == 1)
            {
                finishRepeat();
            };
        }

        override public function resume():void
        {
            super.resume();
            var _local_1:int = activeEffectQueue.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                activeEffectQueue[_local_2].resume();
                _local_2++;
            };
        }

        override public function play():void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:int;
            var _local_7:EffectInstance;
            var _local_8:Array;
            doneEffectQueue = [];
            activeEffectQueue = [];
            replayEffectQueue = [];
            var _local_1:Boolean;
            super.play();
            _local_2 = childSets.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = childSets[_local_3];
                _local_5 = _local_4.length;
                _local_6 = 0;
                while (((_local_6 < _local_5) && (!(activeEffectQueue == null))))
                {
                    _local_7 = _local_4[_local_6];
                    if (((playReversed) && (_local_7.actualDuration < durationWithoutRepeat)))
                    {
                        replayEffectQueue.push(_local_7);
                        startTimer();
                    }
                    else
                    {
                        _local_7.playReversed = playReversed;
                        activeEffectQueue.push(_local_7);
                    };
                    if (_local_7.suspendBackgroundProcessing)
                    {
                        UIComponent.suspendBackgroundProcessing();
                    };
                    _local_6++;
                };
                _local_3++;
            };
            if (activeEffectQueue.length > 0)
            {
                _local_8 = activeEffectQueue.slice(0);
                _local_3 = 0;
                while (_local_3 < _local_8.length)
                {
                    _local_8[_local_3].startEffect();
                    _local_3++;
                };
            };
        }

        override public function pause():void
        {
            super.pause();
            var _local_1:int = activeEffectQueue.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                activeEffectQueue[_local_2].pause();
                _local_2++;
            };
        }


    }
}//package mx.effects.effectClasses

