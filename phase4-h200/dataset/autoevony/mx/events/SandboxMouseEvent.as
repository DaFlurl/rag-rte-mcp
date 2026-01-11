// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.SandboxMouseEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class SandboxMouseEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const CLICK_SOMEWHERE:String = "clickSomewhere";
        public static const DOUBLE_CLICK_SOMEWHERE:String = "coubleClickSomewhere";
        public static const MOUSE_DOWN_SOMEWHERE:String = "mouseDownSomewhere";
        public static const MOUSE_MOVE_SOMEWHERE:String = "mouseMoveSomewhere";
        public static const MOUSE_UP_SOMEWHERE:String = "mouseUpSomewhere";
        public static const MOUSE_WHEEL_SOMEWHERE:String = "mouseWheelSomewhere";

        public var buttonDown:Boolean;
        public var altKey:Boolean;
        public var ctrlKey:Boolean;
        public var shiftKey:Boolean;

        public function SandboxMouseEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.ctrlKey = _arg_4;
            this.altKey = _arg_5;
            this.shiftKey = _arg_6;
            this.buttonDown = _arg_7;
        }

        public static function marshal(_arg_1:Event):SandboxMouseEvent
        {
            var _local_2:Object = _arg_1;
            return (new SandboxMouseEvent(_local_2.type, _local_2.bubbles, _local_2.cancelable, _local_2.ctrlKey, _local_2.altKey, _local_2.shiftKey, _local_2.buttonDown));
        }


        override public function clone():Event
        {
            return (new SandboxMouseEvent(type, bubbles, cancelable, ctrlKey, altKey, shiftKey, buttonDown));
        }


    }
}//package mx.events

