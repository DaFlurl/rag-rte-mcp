// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.SystemManagerProxy

package mx.managers
{
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.core.IFlexModuleFactory;
    import mx.events.SWFBridgeEvent;
    import flash.events.IEventDispatcher;
    import mx.utils.SecurityUtil;
    import mx.core.ISWFBridgeProvider;
    import mx.utils.NameUtil;
    import mx.core.ISWFBridgeGroup;
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;

    use namespace mx_internal;

    public class SystemManagerProxy extends SystemManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _systemManager:ISystemManager;

        public function SystemManagerProxy(_arg_1:ISystemManager)
        {
            _systemManager = _arg_1;
            topLevel = true;
            super.addEventListener(MouseEvent.MOUSE_DOWN, proxyMouseDownHandler, true);
        }

        override public function create(... _args):Object
        {
            return (IFlexModuleFactory(_systemManager).create.apply(this, _args));
        }

        public function get systemManager():ISystemManager
        {
            return (_systemManager);
        }

        override public function activate(_arg_1:IFocusManagerContainer):void
        {
            var _local_3:Boolean;
            var _local_4:SWFBridgeEvent;
            var _local_2:IEventDispatcher = ((_systemManager.swfBridgeGroup) ? _systemManager.swfBridgeGroup.parentBridge : null);
            if (_local_2)
            {
                _local_3 = SecurityUtil.hasMutualTrustBetweenParentAndChild(ISWFBridgeProvider(_systemManager));
                _local_4 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, false, false, {
                    "notifier":_local_2,
                    "window":((_local_3) ? this : NameUtil.displayObjectToString(this))
                });
                _systemManager.getSandboxRoot().dispatchEvent(_local_4);
            };
        }

        override public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            super.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            _systemManager.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function deactivateByProxy(_arg_1:IFocusManagerContainer):void
        {
            if (_arg_1)
            {
                _arg_1.focusManager.deactivate();
            };
        }

        override public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            super.removeEventListener(_arg_1, _arg_2, _arg_3);
            _systemManager.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        override public function get document():Object
        {
            return (findFocusManagerContainer(this));
        }

        public function activateByProxy(_arg_1:IFocusManagerContainer):void
        {
            super.activate(_arg_1);
        }

        override public function removeChildBridge(_arg_1:IEventDispatcher):void
        {
            _systemManager.removeChildBridge(_arg_1);
        }

        override public function get swfBridgeGroup():ISWFBridgeGroup
        {
            return (_systemManager.swfBridgeGroup);
        }

        override public function addChildBridge(_arg_1:IEventDispatcher, _arg_2:DisplayObject):void
        {
            _systemManager.addChildBridge(_arg_1, _arg_2);
        }

        override public function useSWFBridge():Boolean
        {
            return (_systemManager.useSWFBridge());
        }

        override public function get screen():Rectangle
        {
            return (_systemManager.screen);
        }

        override public function set swfBridgeGroup(_arg_1:ISWFBridgeGroup):void
        {
        }

        private function proxyMouseDownHandler(_arg_1:MouseEvent):void
        {
            if (findFocusManagerContainer(this))
            {
                SystemManager(_systemManager).dispatchActivatedWindowEvent(this);
            };
        }

        override public function deactivate(_arg_1:IFocusManagerContainer):void
        {
            var _local_4:Boolean;
            var _local_5:SWFBridgeEvent;
            var _local_2:ISystemManager = _systemManager;
            var _local_3:IEventDispatcher = ((_local_2.swfBridgeGroup) ? _local_2.swfBridgeGroup.parentBridge : null);
            if (_local_3)
            {
                _local_4 = SecurityUtil.hasMutualTrustBetweenParentAndChild(ISWFBridgeProvider(_systemManager));
                _local_5 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, false, false, {
                    "notifier":_local_3,
                    "window":((_local_4) ? this : NameUtil.displayObjectToString(this))
                });
                _systemManager.getSandboxRoot().dispatchEvent(_local_5);
            };
        }

        override public function set document(_arg_1:Object):void
        {
        }

        override public function getVisibleApplicationRect(_arg_1:Rectangle=null):Rectangle
        {
            return (_systemManager.getVisibleApplicationRect(_arg_1));
        }

        override public function getDefinitionByName(_arg_1:String):Object
        {
            return (_systemManager.getDefinitionByName(_arg_1));
        }


    }
}//package mx.managers

