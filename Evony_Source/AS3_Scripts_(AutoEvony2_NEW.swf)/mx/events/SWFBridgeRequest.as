// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.SWFBridgeRequest

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal;
    import flash.events.IEventDispatcher;

    use namespace mx_internal;

    public class SWFBridgeRequest extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const ACTIVATE_POP_UP_REQUEST:String = "activatePopUpRequest";
        public static const CAN_ACTIVATE_POP_UP_REQUEST:String = "canActivateRequestPopUpRequest";
        public static const DEACTIVATE_POP_UP_REQUEST:String = "deactivatePopUpRequest";
        public static const GET_VISIBLE_RECT_REQUEST:String = "getVisibleRectRequest";
        public static const IS_BRIDGE_CHILD_REQUEST:String = "isBridgeChildRequest";
        public static const INVALIDATE_REQUEST:String = "invalidateRequest";
        public static const HIDE_MOUSE_CURSOR_REQUEST:String = "hideMouseCursorRequest";
        public static const SHOW_MOUSE_CURSOR_REQUEST:String = "showMouseCursorRequest";
        public static const RESET_MOUSE_CURSOR_REQUEST:String = "resetMouseCursorRequest";
        public static const ACTIVATE_FOCUS_REQUEST:String = "activateFocusRequest";
        public static const DEACTIVATE_FOCUS_REQUEST:String = "deactivateFocusRequest";
        public static const MOVE_FOCUS_REQUEST:String = "moveFocusRequest";
        public static const CREATE_MODAL_WINDOW_REQUEST:String = "createModalWindowRequest";
        public static const SHOW_MODAL_WINDOW_REQUEST:String = "showModalWindowRequest";
        public static const HIDE_MODAL_WINDOW_REQUEST:String = "hideModalWindowRequest";
        public static const ADD_POP_UP_REQUEST:String = "addPopUpRequest";
        public static const REMOVE_POP_UP_REQUEST:String = "removePopUpRequest";
        public static const ADD_POP_UP_PLACE_HOLDER_REQUEST:String = "addPopUpPlaceHolderRequest";
        public static const REMOVE_POP_UP_PLACE_HOLDER_REQUEST:String = "removePopUpPlaceHolderRequest";
        public static const GET_SIZE_REQUEST:String = "getSizeRequest";
        public static const SET_ACTUAL_SIZE_REQUEST:String = "setActualSizeRequest";
        public static const SET_SHOW_FOCUS_INDICATOR_REQUEST:String = "setShowFocusIndicatorRequest";

        public var requestor:IEventDispatcher;
        public var data:Object;

        public function SWFBridgeRequest(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:IEventDispatcher=null, _arg_5:Object=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.requestor = _arg_4;
            this.data = _arg_5;
        }

        public static function marshal(_arg_1:Event):SWFBridgeRequest
        {
            var _local_2:Object = _arg_1;
            return (new SWFBridgeRequest(_local_2.type, _local_2.bubbles, _local_2.cancelable, _local_2.requestor, _local_2.data));
        }


        override public function clone():Event
        {
            return (new SWFBridgeRequest(type, bubbles, cancelable, requestor, data));
        }


    }
}//package mx.events

