// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.states.State

package mx.states
{
    import flash.events.EventDispatcher;
    import mx.events.FlexEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class State extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var basedOn:String;
        private var initialized:Boolean = false;
        public var overrides:Array = [];
        public var name:String;


        mx_internal function initialize():void
        {
            var _local_1:int;
            if (!initialized)
            {
                initialized = true;
                _local_1 = 0;
                while (_local_1 < overrides.length)
                {
                    IOverride(overrides[_local_1]).initialize();
                    _local_1++;
                };
            };
        }

        mx_internal function dispatchExitState():void
        {
            dispatchEvent(new FlexEvent(FlexEvent.EXIT_STATE));
        }

        mx_internal function dispatchEnterState():void
        {
            dispatchEvent(new FlexEvent(FlexEvent.ENTER_STATE));
        }


    }
}//package mx.states

