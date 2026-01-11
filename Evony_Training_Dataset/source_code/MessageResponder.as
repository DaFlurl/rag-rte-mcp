// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.MessageResponder

package mx.messaging
{
    import flash.net.Responder;
    import mx.messaging.messages.IMessage;
    import flash.utils.Timer;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.TimerEvent;
    import mx.messaging.messages.ErrorMessage;

    public class MessageResponder extends Responder 
    {

        private var _channel:Channel;
        private var _agent:MessageAgent;
        private var _requestTimedOut:Boolean;
        private var _message:IMessage;
        private var _requestTimer:Timer;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function MessageResponder(_arg_1:MessageAgent, _arg_2:IMessage, _arg_3:Channel=null)
        {
            super(result, status);
            _agent = _arg_1;
            _channel = _arg_3;
            _message = _arg_2;
            _requestTimedOut = false;
        }

        public function get channel():Channel
        {
            return (_channel);
        }

        public function get agent():MessageAgent
        {
            return (_agent);
        }

        protected function requestTimedOut():void
        {
        }

        final public function startRequestTimeout(_arg_1:int):void
        {
            _requestTimer = new Timer((_arg_1 * 1000), 1);
            _requestTimer.addEventListener(TimerEvent.TIMER, timeoutRequest);
            _requestTimer.start();
        }

        public function get message():IMessage
        {
            return (_message);
        }

        final public function result(_arg_1:IMessage):void
        {
            if (!_requestTimedOut)
            {
                if (_requestTimer != null)
                {
                    releaseTimer();
                };
                resultHandler(_arg_1);
            };
        }

        private function releaseTimer():void
        {
            _requestTimer.stop();
            _requestTimer.removeEventListener(TimerEvent.TIMER, timeoutRequest);
            _requestTimer = null;
        }

        public function set message(_arg_1:IMessage):void
        {
            _message = _arg_1;
        }

        protected function createRequestTimeoutErrorMessage():ErrorMessage
        {
            var _local_1:ErrorMessage = new ErrorMessage();
            _local_1.correlationId = message.messageId;
            _local_1.faultCode = "Client.Error.RequestTimeout";
            _local_1.faultString = resourceManager.getString("messaging", "requestTimedOut");
            _local_1.faultDetail = resourceManager.getString("messaging", "requestTimedOut.details");
            return (_local_1);
        }

        private function timeoutRequest(_arg_1:TimerEvent):void
        {
            _requestTimedOut = true;
            releaseTimer();
            requestTimedOut();
        }

        final public function status(_arg_1:IMessage):void
        {
            if (!_requestTimedOut)
            {
                if (_requestTimer != null)
                {
                    releaseTimer();
                };
                statusHandler(_arg_1);
            };
        }

        protected function resultHandler(_arg_1:IMessage):void
        {
        }

        protected function statusHandler(_arg_1:IMessage):void
        {
        }


    }
}//package mx.messaging

