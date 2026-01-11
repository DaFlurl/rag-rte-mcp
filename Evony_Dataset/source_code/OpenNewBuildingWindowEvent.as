// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.OpenNewBuildingWindowEvent

package com.evony.events
{
    public class OpenNewBuildingWindowEvent extends WindowChangeEvent 
    {

        private var space:int;

        public function OpenNewBuildingWindowEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this.space = _arg_2;
        }

        public function getSpace():int
        {
            return (this.space);
        }


    }
}//package com.evony.events

