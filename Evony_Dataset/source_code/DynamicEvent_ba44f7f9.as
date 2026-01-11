// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.DynamicEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public dynamic class DynamicEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function DynamicEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function clone():Event
        {
            var _local_2:String;
            var _local_1:DynamicEvent = new DynamicEvent(type, bubbles, cancelable);
            for (_local_2 in this)
            {
                _local_1[_local_2] = this[_local_2];
            };
            return (_local_1);
        }


    }
}//package mx.events

