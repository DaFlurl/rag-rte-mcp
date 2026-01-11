// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.FlexChangeEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class FlexChangeEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const ADD_CHILD_BRIDGE:String = "addChildBridge";
        public static const REMOVE_CHILD_BRIDGE:String = "removeChildBridge";

        public var data:Object;

        public function FlexChangeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Object=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.data = _arg_4;
        }

        override public function clone():Event
        {
            return (new FlexChangeEvent(type, bubbles, cancelable, data));
        }


    }
}//package mx.events

