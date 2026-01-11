// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.events.InvokeEvent

package mx.rpc.events
{
    import mx.rpc.AsyncToken;
    import mx.messaging.messages.IMessage;
    import flash.events.Event;

    public class InvokeEvent extends AbstractEvent 
    {

        public static const INVOKE:String = "invoke";

        public function InvokeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:AsyncToken=null, _arg_5:IMessage=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public static function createEvent(_arg_1:AsyncToken=null, _arg_2:IMessage=null):InvokeEvent
        {
            return (new InvokeEvent(InvokeEvent.INVOKE, false, false, _arg_1, _arg_2));
        }


        override public function toString():String
        {
            return (formatToString("InvokeEvent", "messageId", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override public function clone():Event
        {
            return (new InvokeEvent(type, bubbles, cancelable, token, message));
        }


    }
}//package mx.rpc.events

