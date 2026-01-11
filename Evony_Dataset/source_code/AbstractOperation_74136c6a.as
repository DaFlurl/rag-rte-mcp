// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.AbstractOperation

package mx.rpc
{
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.rpc.events.AbstractEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AbstractOperation extends AbstractInvoker 
    {

        mx_internal var _service:AbstractService;
        private var _name:String;
        public var properties:Object;
        public var arguments:Object;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function AbstractOperation(_arg_1:AbstractService=null, _arg_2:String=null)
        {
            _service = _arg_1;
            _name = _arg_2;
            this.arguments = {};
        }

        public function send(... _args):AsyncToken
        {
            return (null);
        }

        public function get name():String
        {
            return (_name);
        }

        override mx_internal function dispatchRpcEvent(_arg_1:AbstractEvent):void
        {
            _arg_1.callTokenResponders();
            if (!_arg_1.isDefaultPrevented())
            {
                if (hasEventListener(_arg_1.type))
                {
                    dispatchEvent(_arg_1);
                }
                else
                {
                    if (_service != null)
                    {
                        _service.dispatchEvent(_arg_1);
                    };
                };
            };
        }

        mx_internal function setService(_arg_1:AbstractService):void
        {
            var _local_2:String;
            if (!_service)
            {
                _service = _arg_1;
            }
            else
            {
                _local_2 = resourceManager.getString("rpc", "cannotResetService");
                throw (new Error(_local_2));
            };
        }

        public function get service():AbstractService
        {
            return (_service);
        }

        public function set name(_arg_1:String):void
        {
            var _local_2:String;
            if (!_name)
            {
                _name = _arg_1;
            }
            else
            {
                _local_2 = resourceManager.getString("rpc", "cannotResetOperationName");
                throw (new Error(_local_2));
            };
        }


    }
}//package mx.rpc

