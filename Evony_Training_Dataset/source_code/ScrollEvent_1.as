// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ScrollEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ScrollEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const SCROLL:String = "scroll";

        public var detail:String;
        public var delta:Number;
        public var position:Number;
        public var direction:String;

        public function ScrollEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:Number=NaN, _arg_6:String=null, _arg_7:Number=NaN)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.detail = _arg_4;
            this.position = _arg_5;
            this.direction = _arg_6;
            this.delta = _arg_7;
        }

        override public function clone():Event
        {
            return (new ScrollEvent(type, bubbles, cancelable, detail, position, direction, delta));
        }


    }
}//package mx.events

