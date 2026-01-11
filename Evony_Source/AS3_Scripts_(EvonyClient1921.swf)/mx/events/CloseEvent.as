// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.CloseEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CloseEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const CLOSE:String = "close";

        public var detail:int;

        public function CloseEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:int=-1)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.detail = _arg_4;
        }

        override public function clone():Event
        {
            return (new CloseEvent(type, bubbles, cancelable, detail));
        }


    }
}//package mx.events

