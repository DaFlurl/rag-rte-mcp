// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.MapResetPointEvent

package com.evony.events
{
    import flash.events.Event;

    public class MapResetPointEvent extends Event 
    {

        public static const MAP_RESET:String = "mapReset";

        private var eventId:String = "";
        private var dataObj:Object = new Object();

        public function MapResetPointEvent(_arg_1:String, _arg_2:Object)
        {
            super(_arg_1);
            this.dataObj = _arg_2;
        }

        public function getData():Object
        {
            return (this.dataObj);
        }

        public function getEventId():String
        {
            return (this.eventId);
        }


    }
}//package com.evony.events

