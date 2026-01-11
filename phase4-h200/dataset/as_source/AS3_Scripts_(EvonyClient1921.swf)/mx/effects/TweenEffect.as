// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.TweenEffect

package mx.effects
{
    import mx.effects.effectClasses.TweenEffectInstance;
    import mx.events.TweenEvent;
    import flash.events.EventDispatcher;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TweenEffect extends Effect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var easingFunction:Function = null;

        public function TweenEffect(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = TweenEffectInstance;
        }

        protected function tweenEventHandler(_arg_1:TweenEvent):void
        {
            dispatchEvent(_arg_1);
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            super.initInstance(_arg_1);
            TweenEffectInstance(_arg_1).easingFunction = easingFunction;
            EventDispatcher(_arg_1).addEventListener(TweenEvent.TWEEN_START, tweenEventHandler);
            EventDispatcher(_arg_1).addEventListener(TweenEvent.TWEEN_UPDATE, tweenEventHandler);
            EventDispatcher(_arg_1).addEventListener(TweenEvent.TWEEN_END, tweenEventHandler);
        }


    }
}//package mx.effects

