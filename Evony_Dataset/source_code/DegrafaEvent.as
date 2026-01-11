// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.events.DegrafaEvent

package com.degrafa.events
{
    import flash.events.Event;

    public class DegrafaEvent extends Event 
    {

        public static const PRE_RENDER:String = "preRender";
        public static const RENDER:String = "render";

        public function DegrafaEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false):void
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}//package com.degrafa.events

