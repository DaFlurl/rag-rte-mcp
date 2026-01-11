// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.AsyncToken

package mx.rpc
{
    import flash.events.EventDispatcher;
    import mx.messaging.messages.IMessage;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.events.FaultEvent;
    import mx.events.PropertyChangeEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public dynamic class AsyncToken extends EventDispatcher 
    {

        private var _message:IMessage;
        private var _responders:Array;
        private var _result:Object;

        public function AsyncToken(_arg_1:IMessage=null)
        {
            _message = _arg_1;
        }

        public function addResponder(_arg_1:IResponder):void
        {
            if (_responders == null)
            {
                _responders = [];
            };
            _responders.push(_arg_1);
        }

        mx_internal function setMessage(_arg_1:IMessage):void
        {
            _message = _arg_1;
        }

        public function get message():IMessage
        {
            return (_message);
        }

        mx_internal function applyResult(_arg_1:ResultEvent):void
        {
            var _local_2:uint;
            var _local_3:IResponder;
            setResult(_arg_1.result);
            if (_responders != null)
            {
                _local_2 = 0;
                while (_local_2 < _responders.length)
                {
                    _local_3 = _responders[_local_2];
                    if (_local_3 != null)
                    {
                        _local_3.result(_arg_1);
                    };
                    _local_2++;
                };
            };
        }

        public function hasResponder():Boolean
        {
            return ((!(_responders == null)) && (_responders.length > 0));
        }

        public function get responders():Array
        {
            return (_responders);
        }

        mx_internal function applyFault(_arg_1:FaultEvent):void
        {
            var _local_2:uint;
            var _local_3:IResponder;
            if (_responders != null)
            {
                _local_2 = 0;
                while (_local_2 < _responders.length)
                {
                    _local_3 = _responders[_local_2];
                    if (_local_3 != null)
                    {
                        _local_3.fault(_arg_1);
                    };
                    _local_2++;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get result():Object
        {
            return (_result);
        }

        mx_internal function setResult(_arg_1:Object):void
        {
            var _local_2:PropertyChangeEvent;
            if (_result !== _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "result", _result, _arg_1);
                _result = _arg_1;
                dispatchEvent(_local_2);
            };
        }


    }
}//package mx.rpc

