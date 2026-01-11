// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.DropdownEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DropdownEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const CLOSE:String = "close";
        public static const OPEN:String = "open";

        public var triggerEvent:Event;

        public function DropdownEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Event=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.triggerEvent = _arg_4;
        }

        override public function clone():Event
        {
            return (new DropdownEvent(type, bubbles, cancelable, triggerEvent));
        }


    }
}//package mx.events

