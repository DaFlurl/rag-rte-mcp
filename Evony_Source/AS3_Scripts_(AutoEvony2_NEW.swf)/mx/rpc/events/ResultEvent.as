// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.events.ResultEvent

package mx.rpc.events
{
    import mx.messaging.messages.AbstractMessage;
    import mx.rpc.AsyncToken;
    import mx.messaging.messages.IMessage;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ResultEvent extends AbstractEvent 
    {

        public static const RESULT:String = "result";

        private var _headers:Object;
        private var _result:Object;
        private var _statusCode:int;

        public function ResultEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=true, _arg_4:Object=null, _arg_5:AsyncToken=null, _arg_6:IMessage=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6);
            if (((!(_arg_6 == null)) && (!(_arg_6.headers == null))))
            {
                _statusCode = (_arg_6.headers[AbstractMessage.STATUS_CODE_HEADER] as int);
            };
            _result = _arg_4;
        }

        public static function createEvent(_arg_1:Object=null, _arg_2:AsyncToken=null, _arg_3:IMessage=null):ResultEvent
        {
            return (new ResultEvent(ResultEvent.RESULT, false, true, _arg_1, _arg_2, _arg_3));
        }


        override public function clone():Event
        {
            return (new ResultEvent(type, bubbles, cancelable, result, token, message));
        }

        public function get headers():Object
        {
            return (_headers);
        }

        override public function toString():String
        {
            return (formatToString("ResultEvent", "messageId", "type", "bubbles", "cancelable", "eventPhase"));
        }

        override mx_internal function callTokenResponders():void
        {
            if (token != null)
            {
                token.applyResult(this);
            };
        }

        public function get statusCode():int
        {
            return (_statusCode);
        }

        public function set headers(_arg_1:Object):void
        {
            _headers = _arg_1;
        }

        public function get result():Object
        {
            return (_result);
        }

        mx_internal function setResult(_arg_1:Object):void
        {
            _result = _arg_1;
        }


    }
}//package mx.rpc.events

