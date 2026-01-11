// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.Consumer

package mx.messaging
{
    import mx.messaging.messages.AsyncMessage;
    import mx.messaging.messages.CommandMessage;
    import mx.messaging.messages.IMessage;
    import mx.events.PropertyChangeEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Consumer extends AbstractConsumer 
    {

        private var _selector:String = "";
        private var _subtopic:String = "";

        public function Consumer(_arg_1:String="flex.messaging.messages.AsyncMessage")
        {
        }

        public function set subtopic(_arg_1:String):void
        {
            var _local_2:Boolean;
            if (subtopic != _arg_1)
            {
                _local_2 = false;
                if (subscribed)
                {
                    unsubscribe();
                    _local_2 = true;
                };
                _subtopic = _arg_1;
                if (_local_2)
                {
                    subscribe();
                };
            };
        }

        override protected function internalSend(_arg_1:IMessage, _arg_2:Boolean=true):void
        {
            if (subtopic.length > 0)
            {
                _arg_1.headers[AsyncMessage.SUBTOPIC_HEADER] = subtopic;
            };
            if (_selector.length > 0)
            {
                _arg_1.headers[CommandMessage.SELECTOR_HEADER] = _selector;
            };
            super.internalSend(_arg_1, _arg_2);
        }

        public function set selector(_arg_1:String):void
        {
            var _local_2:PropertyChangeEvent;
            var _local_3:Boolean;
            if (_selector !== _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "selector", _selector, _arg_1);
                _local_3 = false;
                if (subscribed)
                {
                    unsubscribe();
                    _local_3 = true;
                };
                _selector = _arg_1;
                if (_local_3)
                {
                    subscribe(clientId);
                };
                dispatchEvent(_local_2);
            };
        }

        [Bindable(event="propertyChange")]
        public function get subtopic():String
        {
            return (_subtopic);
        }

        [Bindable(event="propertyChange")]
        public function get selector():String
        {
            return (_selector);
        }


    }
}//package mx.messaging

