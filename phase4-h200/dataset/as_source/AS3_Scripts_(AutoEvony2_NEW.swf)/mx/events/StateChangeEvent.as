// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.StateChangeEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class StateChangeEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const CURRENT_STATE_CHANGE:String = "currentStateChange";
        public static const CURRENT_STATE_CHANGING:String = "currentStateChanging";

        public var newState:String;
        public var oldState:String;

        public function StateChangeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:String=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.oldState = _arg_4;
            this.newState = _arg_5;
        }

        override public function clone():Event
        {
            return (new StateChangeEvent(type, bubbles, cancelable, oldState, newState));
        }


    }
}//package mx.events

