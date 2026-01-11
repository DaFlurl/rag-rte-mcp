// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.GuideStepChangeEvent

package com.evony.events
{
    import flash.events.Event;

    public class GuideStepChangeEvent extends Event 
    {

        public static const NAME:String = "guideStepChangeEvent";

        public var currentStep:int;

        public function GuideStepChangeEvent(_arg_1:int, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_2, _arg_3, _arg_4);
            this.currentStep = _arg_1;
        }

    }
}//package com.evony.events

