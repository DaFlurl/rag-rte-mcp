// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.SWFBridgeEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class SWFBridgeEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const BRIDGE_APPLICATION_ACTIVATE:String = "bridgeApplicationActivate";
        public static const BRIDGE_APPLICATION_UNLOADING:String = "bridgeApplicationUnloading";
        public static const BRIDGE_FOCUS_MANAGER_ACTIVATE:String = "bridgeFocusManagerActivate";
        public static const BRIDGE_NEW_APPLICATION:String = "bridgeNewApplication";
        public static const BRIDGE_WINDOW_ACTIVATE:String = "bridgeWindowActivate";
        public static const BRIDGE_WINDOW_DEACTIVATE:String = "brdigeWindowDeactivate";

        public var data:Object;

        public function SWFBridgeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Object=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.data = _arg_4;
        }

        public static function marshal(_arg_1:Event):SWFBridgeEvent
        {
            var _local_2:Object = _arg_1;
            return (new SWFBridgeEvent(_local_2.type, _local_2.bubbles, _local_2.cancelable, _local_2.data));
        }


        override public function clone():Event
        {
            return (new SWFBridgeEvent(type, bubbles, cancelable, data));
        }


    }
}//package mx.events

