// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.events.MessageEvent

package mx.messaging.events
{
    import flash.events.Event;
    import mx.messaging.messages.IMessage;

    public class MessageEvent extends Event 
    {

        public static const MESSAGE:String = "message";
        public static const RESULT:String = "result";

        public var message:IMessage;

        public function MessageEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:IMessage=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.message = _arg_4;
        }

        public static function createEvent(_arg_1:String, _arg_2:IMessage):MessageEvent
        {
            return (new MessageEvent(_arg_1, false, false, _arg_2));
        }


        public function get messageId():String
        {
            if (message != null)
            {
                return (message.messageId);
            };
            return (null);
        }

        override public function toString():String
        {
            return (formatToString("MessageEvent", "messageId", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override public function clone():Event
        {
            return (new MessageEvent(type, bubbles, cancelable, message));
        }


    }
}//package mx.messaging.events

