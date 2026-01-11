// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.events.MessageAckEvent

package mx.messaging.events
{
    import mx.messaging.messages.IMessage;
    import mx.messaging.messages.AcknowledgeMessage;
    import flash.events.Event;

    public class MessageAckEvent extends MessageEvent 
    {

        public static const ACKNOWLEDGE:String = "acknowledge";

        public var correlation:IMessage;

        public function MessageAckEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:AcknowledgeMessage=null, _arg_5:IMessage=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.correlation = _arg_5;
        }

        public static function createEvent(_arg_1:AcknowledgeMessage=null, _arg_2:IMessage=null):MessageAckEvent
        {
            return (new MessageAckEvent(MessageAckEvent.ACKNOWLEDGE, false, false, _arg_1, _arg_2));
        }


        public function get acknowledgeMessage():AcknowledgeMessage
        {
            return (message as AcknowledgeMessage);
        }

        public function get correlationId():String
        {
            if (correlation != null)
            {
                return (correlation.messageId);
            };
            return (null);
        }

        override public function clone():Event
        {
            return (new MessageAckEvent(type, bubbles, cancelable, (message as AcknowledgeMessage), correlation));
        }

        override public function toString():String
        {
            return (formatToString("MessageAckEvent", "messageId", "correlationId", "type", "bubbles", "cancelable", "eventPhase"));
        }


    }
}//package mx.messaging.events

