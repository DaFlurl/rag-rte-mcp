// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.EventListenerRequest

package mx.events
{
    import mx.core.mx_internal;
    import flash.events.Event;

    use namespace mx_internal;

    public class EventListenerRequest extends SWFBridgeRequest 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const ADD_EVENT_LISTENER_REQUEST:String = "addEventListenerRequest";
        public static const REMOVE_EVENT_LISTENER_REQUEST:String = "removeEventListenerRequest";

        private var _priority:int;
        private var _useWeakReference:Boolean;
        private var _eventType:String;
        private var _useCapture:Boolean;

        public function EventListenerRequest(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=true, _arg_4:String=null, _arg_5:Boolean=false, _arg_6:int=0, _arg_7:Boolean=false)
        {
            super(_arg_1, false, false);
            _eventType = _arg_4;
            _useCapture = _arg_5;
            _priority = _arg_6;
            _useWeakReference = _arg_7;
        }

        public static function marshal(_arg_1:Event):EventListenerRequest
        {
            var _local_2:Object = _arg_1;
            return (new EventListenerRequest(_local_2.type, _local_2.bubbles, _local_2.cancelable, _local_2.eventType, _local_2.useCapture, _local_2.priority, _local_2.useWeakReference));
        }


        public function get priority():int
        {
            return (_priority);
        }

        public function get useWeakReference():Boolean
        {
            return (_useWeakReference);
        }

        public function get eventType():String
        {
            return (_eventType);
        }

        override public function clone():Event
        {
            return (new EventListenerRequest(type, bubbles, cancelable, eventType, useCapture, priority, useWeakReference));
        }

        public function get useCapture():Boolean
        {
            return (_useCapture);
        }


    }
}//package mx.events

