// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.InterManagerRequest

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class InterManagerRequest extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const CURSOR_MANAGER_REQUEST:String = "cursorManagerRequest";
        public static const DRAG_MANAGER_REQUEST:String = "dragManagerRequest";
        public static const INIT_MANAGER_REQUEST:String = "initManagerRequest";
        public static const SYSTEM_MANAGER_REQUEST:String = "systemManagerRequest";
        public static const TOOLTIP_MANAGER_REQUEST:String = "tooltipManagerRequest";

        public var value:Object;
        public var name:String;

        public function InterManagerRequest(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:Object=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.name = _arg_4;
            this.value = _arg_5;
        }

        override public function clone():Event
        {
            return (new InterManagerRequest(type, bubbles, cancelable, name, value));
        }


    }
}//package mx.events

