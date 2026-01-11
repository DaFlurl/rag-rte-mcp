// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.BaseBean

package com.evony.common
{
    import flash.events.Event;

    public class BaseBean extends Event 
    {

        public function BaseBean(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ("");
        }


    }
}//package com.evony.common

