// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.ChangeSizeEvent

package com.evony.events
{
    import flash.events.Event;

    public class ChangeSizeEvent extends Event 
    {

        public static const SIZE_CHANGE_EVENT:String = "sizeChangeEvent";

        private var _sizeNum:int;

        public function ChangeSizeEvent(_arg_1:String, _arg_2:int=0, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _sizeNum = _arg_2;
        }

        public function get sizeNum():int
        {
            return (_sizeNum);
        }


    }
}//package com.evony.events

