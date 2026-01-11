// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.ActiveCalls

package mx.rpc
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ActiveCalls 
    {

        private var callOrder:Array;
        private var calls:Object;

        public function ActiveCalls()
        {
            calls = {};
            callOrder = [];
        }

        public function removeCall(_arg_1:String):AsyncToken
        {
            var _local_2:AsyncToken = calls[_arg_1];
            if (_local_2 != null)
            {
                delete calls[_arg_1];
                callOrder.splice(callOrder.lastIndexOf(_arg_1), 1);
            };
            return (_local_2);
        }

        public function cancelLast():AsyncToken
        {
            if (callOrder.length > 0)
            {
                return (removeCall((callOrder[(callOrder.length - 1)] as String)));
            };
            return (null);
        }

        public function hasActiveCalls():Boolean
        {
            return (callOrder.length > 0);
        }

        public function wasLastCall(_arg_1:String):Boolean
        {
            if (callOrder.length > 0)
            {
                return (callOrder[(callOrder.length - 1)] == _arg_1);
            };
            return (false);
        }

        public function getAllMessages():Array
        {
            var _local_2:String;
            var _local_1:Array = [];
            for (_local_2 in calls)
            {
                _local_1.push(calls[_local_2]);
            };
            return (_local_1);
        }

        public function addCall(_arg_1:String, _arg_2:AsyncToken):void
        {
            calls[_arg_1] = _arg_2;
            callOrder.push(_arg_1);
        }


    }
}//package mx.rpc

