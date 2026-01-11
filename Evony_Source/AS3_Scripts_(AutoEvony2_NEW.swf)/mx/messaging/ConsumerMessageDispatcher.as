// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.ConsumerMessageDispatcher

package mx.messaging
{
    import flash.utils.Dictionary;
    import mx.messaging.events.MessageEvent;
    import mx.logging.Log;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ConsumerMessageDispatcher 
    {

        private static var _instance:ConsumerMessageDispatcher;

        private const _consumers:Object = {};
        private const _channelSetRefCounts:Dictionary = new Dictionary();
        private const _consumerDuplicateMessageBarrier:Object = {};


        public static function getInstance():ConsumerMessageDispatcher
        {
            if (!_instance)
            {
                _instance = new (ConsumerMessageDispatcher)();
            };
            return (_instance);
        }


        public function registerSubscription(_arg_1:AbstractConsumer):void
        {
            _consumers[_arg_1.clientId] = _arg_1;
            if (_channelSetRefCounts[_arg_1.channelSet] == null)
            {
                _arg_1.channelSet.addEventListener(MessageEvent.MESSAGE, messageHandler);
                _channelSetRefCounts[_arg_1.channelSet] = 1;
            }
            else
            {
                _channelSetRefCounts[_arg_1.channelSet]++;
            };
        }

        private function messageHandler(_arg_1:MessageEvent):void
        {
            var _local_3:int;
            var _local_4:ChannelSet;
            var _local_5:Array;
            var _local_2:AbstractConsumer = _consumers[_arg_1.message.clientId];
            if (_local_2 == null)
            {
                if (Log.isDebug())
                {
                    Log.getLogger("mx.messaging.Consumer").debug("'{0}' received pushed message for consumer but no longer subscribed: {1}", _arg_1.message.clientId, _arg_1.message);
                };
                return;
            };
            if (_arg_1.target.currentChannel.channelSets.length > 1)
            {
                _local_3 = 0;
                for each (_local_4 in _arg_1.target.currentChannel.channelSets)
                {
                    if (_channelSetRefCounts[_local_4] != null)
                    {
                        _local_3++;
                    };
                };
                if (_local_3 > 1)
                {
                    if (_consumerDuplicateMessageBarrier[_local_2.id] == null)
                    {
                        _consumerDuplicateMessageBarrier[_local_2.id] = [_arg_1.messageId, _local_3];
                        _local_2.messageHandler(_arg_1);
                    };
                    _local_5 = _consumerDuplicateMessageBarrier[_local_2.id];
                    if (_local_5[0] == _arg_1.messageId)
                    {
                        if (--_local_5[1] == 0)
                        {
                            delete _consumerDuplicateMessageBarrier[_local_2.id];
                        };
                    };
                    return;
                };
            };
            _local_2.messageHandler(_arg_1);
        }

        public function unregisterSubscription(_arg_1:AbstractConsumer):void
        {
            delete _consumers[_arg_1.clientId];
            var _local_2:int = _channelSetRefCounts[_arg_1.channelSet];
            if (--_local_2 == 0)
            {
                _arg_1.channelSet.removeEventListener(MessageEvent.MESSAGE, messageHandler);
                delete _channelSetRefCounts[_arg_1.channelSet];
                if (_consumerDuplicateMessageBarrier[_arg_1.id] != null)
                {
                    delete _consumerDuplicateMessageBarrier[_arg_1.id];
                };
            }
            else
            {
                _channelSetRefCounts[_arg_1.channelSet] = _local_2;
            };
        }

        public function isChannelUsedForSubscriptions(_arg_1:Channel):Boolean
        {
            var _local_2:Array = _arg_1.channelSets;
            var _local_3:ChannelSet;
            var _local_4:int = _local_2.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_3 = _local_2[_local_5];
                if (((!(_channelSetRefCounts[_local_3] == null)) && (_local_3.currentChannel == _arg_1)))
                {
                    return (true);
                };
                _local_5++;
            };
            return (false);
        }


    }
}//package mx.messaging

