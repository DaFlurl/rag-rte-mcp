// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.FlexMouseEvent

package mx.events
{
    import flash.events.MouseEvent;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class FlexMouseEvent extends MouseEvent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const MOUSE_DOWN_OUTSIDE:String = "mouseDownOutside";
        public static const MOUSE_WHEEL_OUTSIDE:String = "mouseWheelOutside";

        public function FlexMouseEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Number=0, _arg_5:Number=0, _arg_6:InteractiveObject=null, _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:Boolean=false, _arg_10:Boolean=false, _arg_11:int=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function clone():Event
        {
            return (new FlexMouseEvent(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta));
        }


    }
}//package mx.events

