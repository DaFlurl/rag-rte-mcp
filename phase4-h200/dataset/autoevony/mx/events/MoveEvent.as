// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.MoveEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class MoveEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const MOVE:String = "move";

        public var oldX:Number;
        public var oldY:Number;

        public function MoveEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Number=NaN, _arg_5:Number=NaN)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.oldX = _arg_4;
            this.oldY = _arg_5;
        }

        override public function clone():Event
        {
            return (new MoveEvent(type, bubbles, cancelable, oldX, oldY));
        }


    }
}//package mx.events

