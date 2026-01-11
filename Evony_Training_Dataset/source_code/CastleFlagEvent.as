// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.CastleFlagEvent

package com.evony.events
{
    import flash.events.Event;

    public class CastleFlagEvent extends Event 
    {

        public static const EVENT_NAME:String = "CastleFlagEvent";

        public var castleRoleName:String;
        public var statues:int;

        public function CastleFlagEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(EVENT_NAME, _arg_3, _arg_4);
            this.castleRoleName = _arg_1;
            this.statues = _arg_2;
        }

    }
}//package com.evony.events

