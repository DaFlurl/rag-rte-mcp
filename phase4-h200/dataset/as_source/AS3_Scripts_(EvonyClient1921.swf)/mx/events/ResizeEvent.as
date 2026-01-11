// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ResizeEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ResizeEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const RESIZE:String = "resize";

        public var oldHeight:Number;
        public var oldWidth:Number;

        public function ResizeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Number=NaN, _arg_5:Number=NaN)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.oldWidth = _arg_4;
            this.oldHeight = _arg_5;
        }

        override public function clone():Event
        {
            return (new ResizeEvent(type, bubbles, cancelable, oldWidth, oldHeight));
        }


    }
}//package mx.events

