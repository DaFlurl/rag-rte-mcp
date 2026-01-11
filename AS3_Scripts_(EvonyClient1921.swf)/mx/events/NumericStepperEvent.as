// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.NumericStepperEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NumericStepperEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const CHANGE:String = "change";

        public var value:Number;
        public var triggerEvent:Event;

        public function NumericStepperEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Number=NaN, _arg_5:Event=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.value = _arg_4;
            this.triggerEvent = _arg_5;
        }

        override public function clone():Event
        {
            return (new NumericStepperEvent(type, bubbles, cancelable, value));
        }


    }
}//package mx.events

