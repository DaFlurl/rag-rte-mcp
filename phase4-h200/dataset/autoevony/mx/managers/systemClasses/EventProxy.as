// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.systemClasses.EventProxy

package mx.managers.systemClasses
{
    import flash.events.EventDispatcher;
    import mx.managers.ISystemManager;
    import flash.events.MouseEvent;
    import mx.events.SandboxMouseEvent;
    import mx.utils.EventUtil;
    import flash.events.Event;

    public class EventProxy extends EventDispatcher 
    {

        private var systemManager:ISystemManager;

        public function EventProxy(_arg_1:ISystemManager)
        {
            this.systemManager = _arg_1;
        }

        public function marshalListener(_arg_1:Event):void
        {
            var _local_2:MouseEvent;
            var _local_3:SandboxMouseEvent;
            if ((_arg_1 is MouseEvent))
            {
                _local_2 = (_arg_1 as MouseEvent);
                _local_3 = new SandboxMouseEvent(EventUtil.mouseEventMap[_arg_1.type], false, false, _local_2.ctrlKey, _local_2.altKey, _local_2.shiftKey, _local_2.buttonDown);
                systemManager.dispatchEventFromSWFBridges(_local_3, null, true, true);
            }
            else
            {
                if (_arg_1.type == Event.MOUSE_LEAVE)
                {
                    _local_3 = new SandboxMouseEvent(SandboxMouseEvent.MOUSE_UP_SOMEWHERE);
                    systemManager.dispatchEventFromSWFBridges(_local_3, null, true, true);
                    systemManager.dispatchEvent(_local_3);
                };
            };
        }


    }
}//package mx.managers.systemClasses

