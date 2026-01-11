// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.events.FaultEvent

package mx.rpc.events
{
    import mx.rpc.Fault;
    import mx.messaging.messages.AbstractMessage;
    import mx.rpc.AsyncToken;
    import mx.messaging.messages.IMessage;
    import mx.messaging.events.MessageFaultEvent;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class FaultEvent extends AbstractEvent 
    {

        public static const FAULT:String = "fault";

        private var _fault:Fault;
        private var _headers:Object;
        private var _statusCode:int;

        public function FaultEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=true, _arg_4:Fault=null, _arg_5:AsyncToken=null, _arg_6:IMessage=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6);
            if (((!(_arg_6 == null)) && (!(_arg_6.headers == null))))
            {
                _statusCode = (_arg_6.headers[AbstractMessage.STATUS_CODE_HEADER] as int);
            };
            _fault = _arg_4;
        }

        public static function createEventFromMessageFault(_arg_1:MessageFaultEvent, _arg_2:AsyncToken=null):FaultEvent
        {
            var _local_3:Fault = new Fault(_arg_1.faultCode, _arg_1.faultString, _arg_1.faultDetail);
            _local_3.rootCause = _arg_1.rootCause;
            return (new FaultEvent(FaultEvent.FAULT, false, true, _local_3, _arg_2, _arg_1.message));
        }

        public static function createEvent(_arg_1:Fault, _arg_2:AsyncToken=null, _arg_3:IMessage=null):FaultEvent
        {
            return (new FaultEvent(FaultEvent.FAULT, false, true, _arg_1, _arg_2, _arg_3));
        }


        public function get fault():Fault
        {
            return (_fault);
        }

        public function set headers(_arg_1:Object):void
        {
            _headers = _arg_1;
        }

        override mx_internal function callTokenResponders():void
        {
            if (token != null)
            {
                token.applyFault(this);
            };
        }

        public function get headers():Object
        {
            return (_headers);
        }

        override public function toString():String
        {
            return (formatToString("FaultEvent", "fault", "messageId", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override public function clone():Event
        {
            return (new FaultEvent(type, bubbles, cancelable, fault, token, message));
        }

        public function get statusCode():int
        {
            return (_statusCode);
        }


    }
}//package mx.rpc.events

