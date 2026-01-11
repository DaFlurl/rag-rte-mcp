// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.Producer

package mx.messaging
{
    import mx.logging.Log;
    import mx.messaging.messages.AsyncMessage;
    import mx.messaging.messages.IMessage;
    import mx.messaging.messages.AbstractMessage;
    import mx.events.PropertyChangeEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Producer extends AbstractProducer 
    {

        public static const DEFAULT_PRIORITY:int = 4;

        private var _subtopic:String = "";

        public function Producer()
        {
            _log = Log.getLogger("mx.messaging.Producer");
            _agentType = "producer";
        }

        override protected function internalSend(_arg_1:IMessage, _arg_2:Boolean=true):void
        {
            if (subtopic.length > 0)
            {
                _arg_1.headers[AsyncMessage.SUBTOPIC_HEADER] = subtopic;
            };
            handlePriority(_arg_1);
            super.internalSend(_arg_1, _arg_2);
        }

        private function handlePriority(_arg_1:IMessage):void
        {
            var _local_2:int;
            if (_arg_1.headers[AbstractMessage.PRIORITY_HEADER] != null)
            {
                _local_2 = _arg_1.headers[AbstractMessage.PRIORITY_HEADER];
                if (_local_2 < 0)
                {
                    _arg_1.headers[AbstractMessage.PRIORITY_HEADER] = 0;
                }
                else
                {
                    if (_local_2 > 9)
                    {
                        _arg_1.headers[AbstractMessage.PRIORITY_HEADER] = 9;
                    };
                };
            }
            else
            {
                if (priority > -1)
                {
                    _arg_1.headers[AbstractMessage.PRIORITY_HEADER] = priority;
                };
            };
        }

        public function set subtopic(_arg_1:String):void
        {
            var _local_2:PropertyChangeEvent;
            if (_subtopic != _arg_1)
            {
                if (_arg_1 == null)
                {
                    _arg_1 = "";
                };
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "subtopic", _subtopic, _arg_1);
                _subtopic = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        [Bindable(event="propertyChange")]
        public function get subtopic():String
        {
            return (_subtopic);
        }


    }
}//package mx.messaging

