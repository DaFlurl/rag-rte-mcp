// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.messages.CommandMessage

package mx.messaging.messages
{
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;

    public class CommandMessage extends AsyncMessage 
    {

        public static const SUBSCRIBE_OPERATION:uint = 0;
        public static const UNSUBSCRIBE_OPERATION:uint = 1;
        public static const POLL_OPERATION:uint = 2;
        public static const CLIENT_SYNC_OPERATION:uint = 4;
        public static const CLIENT_PING_OPERATION:uint = 5;
        public static const CLUSTER_REQUEST_OPERATION:uint = 7;
        public static const LOGIN_OPERATION:uint = 8;
        public static const LOGOUT_OPERATION:uint = 9;
        public static const MESSAGING_VERSION:String = "DSMessagingVersion";
        public static const SUBSCRIPTION_INVALIDATE_OPERATION:uint = 10;
        public static const MULTI_SUBSCRIBE_OPERATION:uint = 11;
        public static const DISCONNECT_OPERATION:uint = 12;
        public static const TRIGGER_CONNECT_OPERATION:uint = 13;
        public static const UNKNOWN_OPERATION:uint = 10000;
        public static const AUTHENTICATION_MESSAGE_REF_TYPE:String = "flex.messaging.messages.AuthenticationMessage";
        public static const SELECTOR_HEADER:String = "DSSelector";
        public static const PRESERVE_DURABLE_HEADER:String = "DSPreserveDurable";
        public static const NEEDS_CONFIG_HEADER:String = "DSNeedsConfig";
        public static const ADD_SUBSCRIPTIONS:String = "DSAddSub";
        public static const REMOVE_SUBSCRIPTIONS:String = "DSRemSub";
        public static const SUBTOPIC_SEPARATOR:String = "_;_";
        public static const POLL_WAIT_HEADER:String = "DSPollWait";
        public static const NO_OP_POLL_HEADER:String = "DSNoOpPoll";
        public static const CREDENTIALS_CHARSET_HEADER:String = "DSCredentialsCharset";
        public static const MAX_FREQUENCY_HEADER:String = "DSMaxFrequency";
        public static const HEARTBEAT_HEADER:String = "DS<3";
        private static const OPERATION_FLAG:uint = 1;
        private static var operationTexts:Object = null;

        public var operation:uint;

        public function CommandMessage()
        {
            operation = UNKNOWN_OPERATION;
        }

        public static function getOperationAsString(_arg_1:uint):String
        {
            if (operationTexts == null)
            {
                operationTexts = {};
                operationTexts[SUBSCRIBE_OPERATION] = "subscribe";
                operationTexts[UNSUBSCRIBE_OPERATION] = "unsubscribe";
                operationTexts[POLL_OPERATION] = "poll";
                operationTexts[CLIENT_SYNC_OPERATION] = "client sync";
                operationTexts[CLIENT_PING_OPERATION] = "client ping";
                operationTexts[CLUSTER_REQUEST_OPERATION] = "cluster request";
                operationTexts[LOGIN_OPERATION] = "login";
                operationTexts[LOGOUT_OPERATION] = "logout";
                operationTexts[SUBSCRIPTION_INVALIDATE_OPERATION] = "subscription invalidate";
                operationTexts[MULTI_SUBSCRIBE_OPERATION] = "multi-subscribe";
                operationTexts[DISCONNECT_OPERATION] = "disconnect";
                operationTexts[TRIGGER_CONNECT_OPERATION] = "trigger connect";
                operationTexts[UNKNOWN_OPERATION] = "unknown";
            };
            var _local_2:* = operationTexts[_arg_1];
            return ((_local_2 == undefined) ? _arg_1.toString() : String(_local_2));
        }


        override public function readExternal(_arg_1:IDataInput):void
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            super.readExternal(_arg_1);
            var _local_2:Array = readFlags(_arg_1);
            var _local_3:uint;
            while (_local_3 < _local_2.length)
            {
                _local_4 = (_local_2[_local_3] as uint);
                _local_5 = 0;
                if (_local_3 == 0)
                {
                    if ((_local_4 & OPERATION_FLAG) != 0)
                    {
                        operation = (_arg_1.readObject() as uint);
                    };
                    _local_5 = 1;
                };
                if ((_local_4 >> _local_5) != 0)
                {
                    _local_6 = _local_5;
                    while (_local_6 < 6)
                    {
                        if (((_local_4 >> _local_6) & 0x01) != 0)
                        {
                            _arg_1.readObject();
                        };
                        _local_6++;
                    };
                };
                _local_3++;
            };
        }

        override protected function addDebugAttributes(_arg_1:Object):void
        {
            super.addDebugAttributes(_arg_1);
            _arg_1["operation"] = getOperationAsString(operation);
        }

        override public function writeExternal(_arg_1:IDataOutput):void
        {
            super.writeExternal(_arg_1);
            var _local_2:uint;
            if (operation != 0)
            {
                _local_2 = (_local_2 | OPERATION_FLAG);
            };
            _arg_1.writeByte(_local_2);
            if (operation != 0)
            {
                _arg_1.writeObject(operation);
            };
        }

        override public function toString():String
        {
            return (getDebugString());
        }

        override public function getSmallMessage():IMessage
        {
            if (operation == POLL_OPERATION)
            {
                return (new CommandMessageExt(this));
            };
            return (null);
        }


    }
}//package mx.messaging.messages

