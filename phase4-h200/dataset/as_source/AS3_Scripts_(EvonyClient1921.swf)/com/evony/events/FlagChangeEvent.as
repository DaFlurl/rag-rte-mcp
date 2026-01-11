// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.FlagChangeEvent

package com.evony.events
{
    import flash.events.Event;

    public class FlagChangeEvent extends Event 
    {

        public static const EVENT_NAME:String = "FlagChangeEvent";

        public var flagStr:String;

        public function FlagChangeEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(EVENT_NAME, _arg_2, _arg_3);
            this.flagStr = _arg_1;
        }

    }
}//package com.evony.events

