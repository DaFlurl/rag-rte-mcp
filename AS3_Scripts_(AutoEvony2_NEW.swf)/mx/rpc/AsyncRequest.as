// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.AsyncRequest

package mx.rpc
{
    import mx.messaging.Producer;
    import mx.messaging.messages.IMessage;
    import mx.messaging.events.MessageFaultEvent;
    import mx.messaging.messages.ErrorMessage;
    import mx.messaging.messages.AcknowledgeMessage;
    import mx.messaging.events.MessageEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AsyncRequest extends Producer 
    {

        private var _pendingRequests:Object = {};


        override public function hasPendingRequestForMessage(_arg_1:IMessage):Boolean
        {
            var _local_2:String = _arg_1.messageId;
            return (_pendingRequests[_local_2]);
        }

        override public function fault(_arg_1:ErrorMessage, _arg_2:IMessage):void
        {
            super.fault(_arg_1, _arg_2);
            if (_ignoreFault)
            {
                return;
            };
            var _local_3:String = _arg_2.messageId;
            var _local_4:IResponder = IResponder(_pendingRequests[_local_3]);
            if (_local_4)
            {
                delete _pendingRequests[_local_3];
                _local_4.fault(MessageFaultEvent.createEvent(_arg_1));
            };
        }

        public function invoke(_arg_1:IMessage, _arg_2:IResponder):void
        {
            _pendingRequests[_arg_1.messageId] = _arg_2;
            send(_arg_1);
        }

        override public function acknowledge(_arg_1:AcknowledgeMessage, _arg_2:IMessage):void
        {
            var _local_4:String;
            var _local_5:IResponder;
            var _local_3:Boolean = _arg_1.headers[AcknowledgeMessage.ERROR_HINT_HEADER];
            super.acknowledge(_arg_1, _arg_2);
            if (!_local_3)
            {
                _local_4 = _arg_1.correlationId;
                _local_5 = IResponder(_pendingRequests[_local_4]);
                if (_local_5)
                {
                    delete _pendingRequests[_local_4];
                    _local_5.result(MessageEvent.createEvent(MessageEvent.RESULT, _arg_1));
                };
            };
        }


    }
}//package mx.rpc

