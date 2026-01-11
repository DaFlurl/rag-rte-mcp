// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.MaskEffect

package mx.effects
{
    import mx.effects.effectClasses.MaskEffectInstance;
    import mx.core.mx_internal;
    import flash.events.EventDispatcher;
    import mx.events.TweenEvent;

    use namespace mx_internal;

    public class MaskEffect extends Effect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var AFFECTED_PROPERTIES:Array = ["visible"];

        public var createMaskFunction:Function;
        public var xFrom:Number;
        public var yFrom:Number;
        public var scaleEasingFunction:Function;
        mx_internal var persistAfterEnd:Boolean = false;
        public var moveEasingFunction:Function;
        public var scaleXFrom:Number;
        public var scaleYFrom:Number;
        public var xTo:Number;
        public var yTo:Number;
        private var _showExplicitlySet:Boolean = false;
        public var scaleXTo:Number;
        public var scaleYTo:Number;
        private var _showTarget:Boolean = true;

        public function MaskEffect(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = MaskEffectInstance;
            hideFocusRing = true;
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            var _local_2:MaskEffectInstance;
            super.initInstance(_arg_1);
            _local_2 = MaskEffectInstance(_arg_1);
            if (_showExplicitlySet)
            {
                _local_2.showTarget = showTarget;
            };
            _local_2.xFrom = xFrom;
            _local_2.yFrom = yFrom;
            _local_2.xTo = xTo;
            _local_2.yTo = yTo;
            _local_2.scaleXFrom = scaleXFrom;
            _local_2.scaleXTo = scaleXTo;
            _local_2.scaleYFrom = scaleYFrom;
            _local_2.scaleYTo = scaleYTo;
            _local_2.moveEasingFunction = moveEasingFunction;
            _local_2.scaleEasingFunction = scaleEasingFunction;
            _local_2.createMaskFunction = createMaskFunction;
            _local_2.mx_internal::persistAfterEnd = mx_internal::persistAfterEnd;
            EventDispatcher(_local_2).addEventListener(TweenEvent.TWEEN_START, tweenEventHandler);
            EventDispatcher(_local_2).addEventListener(TweenEvent.TWEEN_UPDATE, tweenEventHandler);
            EventDispatcher(_local_2).addEventListener(TweenEvent.TWEEN_END, tweenEventHandler);
        }

        protected function tweenEventHandler(_arg_1:TweenEvent):void
        {
            dispatchEvent(_arg_1);
        }

        override public function set hideFocusRing(_arg_1:Boolean):void
        {
            super.hideFocusRing = _arg_1;
        }

        override public function get hideFocusRing():Boolean
        {
            return (super.hideFocusRing);
        }

        public function set showTarget(_arg_1:Boolean):void
        {
            _showTarget = _arg_1;
            _showExplicitlySet = true;
        }

        public function get showTarget():Boolean
        {
            return (_showTarget);
        }

        override public function getAffectedProperties():Array
        {
            return (AFFECTED_PROPERTIES);
        }


    }
}//package mx.effects

