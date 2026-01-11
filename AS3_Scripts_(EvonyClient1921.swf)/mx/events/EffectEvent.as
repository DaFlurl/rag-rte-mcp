// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.EffectEvent

package mx.events
{
    import flash.events.Event;
    import mx.effects.IEffectInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class EffectEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const EFFECT_END:String = "effectEnd";
        public static const EFFECT_START:String = "effectStart";

        public var effectInstance:IEffectInstance;

        public function EffectEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:IEffectInstance=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.effectInstance = _arg_4;
        }

        override public function clone():Event
        {
            return (new EffectEvent(type, bubbles, cancelable, effectInstance));
        }


    }
}//package mx.events

