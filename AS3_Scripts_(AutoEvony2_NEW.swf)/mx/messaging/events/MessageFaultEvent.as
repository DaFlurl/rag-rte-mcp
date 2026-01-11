// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.events.MessageFaultEvent

package mx.messaging.events
{
    import flash.events.Event;
    import mx.messaging.messages.ErrorMessage;

    public class MessageFaultEvent extends Event 
    {

        public static const FAULT:String = "fault";

        public var message:ErrorMessage;

        public function MessageFaultEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:ErrorMessage=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.message = _arg_4;
        }

        public static function createEvent(_arg_1:ErrorMessage):MessageFaultEvent
        {
            return (new MessageFaultEvent(MessageFaultEvent.FAULT, false, false, _arg_1));
        }


        public function get faultString():String
        {
            return (message.faultString);
        }

        public function get faultDetail():String
        {
            return (message.faultDetail);
        }

        public function get rootCause():Object
        {
            return (message.rootCause);
        }

        override public function toString():String
        {
            return (formatToString("MessageFaultEvent", "faultCode", "faultDetail", "faultString", "rootCause", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override public function clone():Event
        {
            return (new MessageFaultEvent(type, bubbles, cancelable, message));
        }

        public function get faultCode():String
        {
            return (message.faultCode);
        }


    }
}//package mx.messaging.events

