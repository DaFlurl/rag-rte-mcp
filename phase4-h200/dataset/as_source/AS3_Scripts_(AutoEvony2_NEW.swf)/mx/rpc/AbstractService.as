// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.AbstractService

package mx.rpc
{
    import flash.utils.Proxy;
    import flash.events.IEventDispatcher;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.EventDispatcher;
    import mx.rpc.events.AbstractEvent;
    import flash.events.Event;
    import mx.messaging.ChannelSet;
    import flash.utils.flash_proxy; 
    import mx.core.mx_internal; 

    use namespace mx_internal;
    use namespace flash.utils.flash_proxy;

    [Bindable(event="operationsChange")]
    public dynamic class AbstractService extends Proxy implements IEventDispatcher 
    {

        mx_internal var _operations:Object;
        private var _initialized:Boolean = false;
        mx_internal var _availableChannelIds:Array;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _managers:Array;
        private var nextNameArray:Array;
        private var eventDispatcher:EventDispatcher;
        mx_internal var asyncRequest:AsyncRequest;

        public function AbstractService(_arg_1:String=null)
        {
            eventDispatcher = new EventDispatcher(this);
            asyncRequest = new AsyncRequest();
            if (_arg_1)
            {
                this.destination = _arg_1;
                asyncRequest.destination = _arg_1;
            };
            _operations = {};
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (eventDispatcher.willTrigger(_arg_1));
        }

        public function get destination():String
        {
            return (asyncRequest.destination);
        }

        public function initialize():void
        {
            var _local_1:int;
            var _local_2:Object;
            if (((!(_initialized)) && (!(_managers == null))))
            {
                _local_1 = 0;
                while (_local_1 < _managers.length)
                {
                    _local_2 = _managers[_local_1];
                    if (_local_2.hasOwnProperty("initialize"))
                    {
                        _local_2.initialize();
                    };
                    _local_1++;
                };
                _initialized = true;
            };
        }

        public function logout():void
        {
            asyncRequest.logout();
        }

        public function setRemoteCredentials(_arg_1:String, _arg_2:String, _arg_3:String=null):void
        {
            asyncRequest.setRemoteCredentials(_arg_1, _arg_2, _arg_3);
        }

        mx_internal function hasTokenResponders(_arg_1:Event):Boolean
        {
            var _local_2:AbstractEvent;
            if ((_arg_1 is AbstractEvent))
            {
                _local_2 = (_arg_1 as AbstractEvent);
                if (((!(_local_2.token == null)) && (_local_2.token.hasResponder())))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function disconnect():void
        {
            asyncRequest.disconnect();
        }

        override flash_proxy function nextName(_arg_1:int):String
        {
            return (nextNameArray[(_arg_1 - 1)]);
        }

        public function set destination(_arg_1:String):void
        {
            asyncRequest.destination = _arg_1;
        }

        public function set requestTimeout(_arg_1:int):void
        {
            if (requestTimeout != _arg_1)
            {
                asyncRequest.requestTimeout = _arg_1;
            };
        }

        public function valueOf():Object
        {
            return (this);
        }

        public function getOperation(_arg_1:String):AbstractOperation
        {
            var _local_2:Object = _operations[_arg_1];
            return ((_local_2 is AbstractOperation) ? AbstractOperation(_local_2) : null);
        }

        public function setCredentials(_arg_1:String, _arg_2:String, _arg_3:String=null):void
        {
            asyncRequest.setCredentials(_arg_1, _arg_2, _arg_3);
        }

        public function set channelSet(_arg_1:ChannelSet):void
        {
            if (channelSet != _arg_1)
            {
                asyncRequest.channelSet = _arg_1;
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (eventDispatcher.dispatchEvent(_arg_1));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            eventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            return (getOperation(getLocalName(_arg_1)));
        }

        public function set managers(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:Object;
            if (_managers != null)
            {
                _local_2 = 0;
                while (_local_2 < _managers.length)
                {
                    _local_3 = _managers[_local_2];
                    if (_local_3.hasOwnProperty("service"))
                    {
                        _local_3.service = null;
                    };
                    _local_2++;
                };
            };
            _managers = _arg_1;
            _local_2 = 0;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = _managers[_local_2];
                if (_local_3.hasOwnProperty("service"))
                {
                    _local_3.service = this;
                };
                if (((_initialized) && (_local_3.hasOwnProperty("initialize"))))
                {
                    _local_3.initialize();
                };
                _local_2++;
            };
        }

        public function get requestTimeout():int
        {
            return (asyncRequest.requestTimeout);
        }

        override flash_proxy function callProperty(_arg_1:*, ... _args):*
        {
            return (getOperation(getLocalName(_arg_1)).send.apply(null, _args));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            eventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (_operations[nextNameArray[(_arg_1 - 1)]]);
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_3:String = resourceManager.getString("rpc", "operationsNotAllowedInService", [getLocalName(_arg_1)]);
            throw (new Error(_local_3));
        }

        public function set operations(_arg_1:Object):void
        {
            var _local_2:AbstractOperation;
            var _local_3:String;
            for (_local_3 in _arg_1)
            {
                _local_2 = AbstractOperation(_arg_1[_local_3]);
                _local_2.setService(this);
                if (!_local_2.name)
                {
                    _local_2.name = _local_3;
                };
                _local_2.asyncRequest = asyncRequest;
            };
            _operations = _arg_1;
            dispatchEvent(new Event("operationsChange"));
        }

        public function get channelSet():ChannelSet
        {
            return (asyncRequest.channelSet);
        }

        mx_internal function getLocalName(_arg_1:Object):String
        {
            if ((_arg_1 is QName))
            {
                return (QName(_arg_1).localName);
            };
            return (String(_arg_1));
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            var _local_2:String;
            if (_arg_1 == 0)
            {
                nextNameArray = [];
                for (_local_2 in _operations)
                {
                    nextNameArray.push(_local_2);
                };
            };
            return ((_arg_1 < nextNameArray.length) ? (_arg_1 + 1) : 0);
        }

        public function get managers():Array
        {
            return (_managers);
        }

        public function get operations():Object
        {
            return (_operations);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (eventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package mx.rpc

