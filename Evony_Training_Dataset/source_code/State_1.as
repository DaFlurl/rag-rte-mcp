// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.states.State

package com.degrafa.states
{
    import flash.events.EventDispatcher;
    import mx.events.FlexEvent;

    public class State extends EventDispatcher 
    {

        public var overrides:Array = [];
        public var name:String;
        public var basedOn:String;
        private var initialized:Boolean = false;
        public var stateManager:StateManager;


        public function initialize():void
        {
            var _local_1:int;
            if (!initialized)
            {
                initialized = true;
                _local_1 = 0;
                while (_local_1 < overrides.length)
                {
                    overrides[_local_1].initialize();
                    _local_1++;
                };
            };
        }

        public function dispatchExitState():void
        {
            dispatchEvent(new FlexEvent(FlexEvent.EXIT_STATE));
        }

        public function dispatchEnterState():void
        {
            dispatchEvent(new FlexEvent(FlexEvent.ENTER_STATE));
        }


    }
}//package com.degrafa.states

