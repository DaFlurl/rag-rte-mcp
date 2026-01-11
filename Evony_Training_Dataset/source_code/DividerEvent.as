// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.DividerEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DividerEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const DIVIDER_DRAG:String = "dividerDrag";
        public static const DIVIDER_PRESS:String = "dividerPress";
        public static const DIVIDER_RELEASE:String = "dividerRelease";

        public var delta:Number;
        public var dividerIndex:int;

        public function DividerEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:int=-1, _arg_5:Number=NaN)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.dividerIndex = _arg_4;
            this.delta = _arg_5;
        }

        override public function clone():Event
        {
            return (new DividerEvent(type, bubbles, cancelable, dividerIndex, delta));
        }


    }
}//package mx.events

