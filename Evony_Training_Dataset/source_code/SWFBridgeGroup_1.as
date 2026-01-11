// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.SWFBridgeGroup

package mx.core
{
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import mx.managers.ISystemManager;

    public class SWFBridgeGroup implements ISWFBridgeGroup 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _parentBridge:IEventDispatcher;
        private var _childBridges:Dictionary;
        private var _groupOwner:ISystemManager;

        public function SWFBridgeGroup(_arg_1:ISystemManager)
        {
            _groupOwner = _arg_1;
        }

        public function getChildBridgeProvider(_arg_1:IEventDispatcher):ISWFBridgeProvider
        {
            if (!_childBridges)
            {
                return (null);
            };
            return (ISWFBridgeProvider(_childBridges[_arg_1]));
        }

        public function removeChildBridge(_arg_1:IEventDispatcher):void
        {
            var _local_2:Object;
            if (((!(_childBridges)) || (!(_arg_1))))
            {
                return;
            };
            for (_local_2 in _childBridges)
            {
                if (_local_2 == _arg_1)
                {
                    delete _childBridges[_local_2];
                };
            };
        }

        public function get parentBridge():IEventDispatcher
        {
            return (_parentBridge);
        }

        public function containsBridge(_arg_1:IEventDispatcher):Boolean
        {
            var _local_2:Object;
            if (((parentBridge) && (parentBridge == _arg_1)))
            {
                return (true);
            };
            for (_local_2 in _childBridges)
            {
                if (_arg_1 == _local_2)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function set parentBridge(_arg_1:IEventDispatcher):void
        {
            _parentBridge = _arg_1;
        }

        public function addChildBridge(_arg_1:IEventDispatcher, _arg_2:ISWFBridgeProvider):void
        {
            if (!_childBridges)
            {
                _childBridges = new Dictionary();
            };
            _childBridges[_arg_1] = _arg_2;
        }

        public function getChildBridges():Array
        {
            var _local_2:Object;
            var _local_1:Array = [];
            for (_local_2 in _childBridges)
            {
                _local_1.push(_local_2);
            };
            return (_local_1);
        }


    }
}//package mx.core

