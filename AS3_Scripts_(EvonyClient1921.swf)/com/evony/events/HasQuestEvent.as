// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.HasQuestEvent

package com.evony.events
{
    import flash.events.Event;

    public class HasQuestEvent extends Event 
    {

        public static const HAS_QUEST:String = "hasQuest";

        public var isHasQuest:Boolean = false;
        public var jobDone:int;

        public function HasQuestEvent(_arg_1:String, _arg_2:Boolean, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            isHasQuest = _arg_2;
            jobDone = _arg_3;
        }

    }
}//package com.evony.events

