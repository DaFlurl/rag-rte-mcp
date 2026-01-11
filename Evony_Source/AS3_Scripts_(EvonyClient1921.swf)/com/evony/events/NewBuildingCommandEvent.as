// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.NewBuildingCommandEvent

package com.evony.events
{
    import flash.events.Event;

    public class NewBuildingCommandEvent extends Event 
    {

        public static const EVENT_NAME:String = "NewBuildingCommandEvent";

        public var isCanBuildHelp:Boolean = false;
        public var buildingType:int;

        public function NewBuildingCommandEvent(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(EVENT_NAME, _arg_3, _arg_4);
            this.buildingType = _arg_1;
            this.isCanBuildHelp = _arg_2;
        }

    }
}//package com.evony.events

