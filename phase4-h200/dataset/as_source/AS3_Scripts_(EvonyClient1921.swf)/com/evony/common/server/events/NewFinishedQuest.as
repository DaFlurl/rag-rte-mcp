// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.NewFinishedQuest

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class NewFinishedQuest extends BaseBean 
    {

        public function NewFinishedQuest(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
        }

        public function copyTo(_arg_1:NewFinishedQuest):void
        {
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            return ("---- NewFinishedQuest ----\n");
        }

        public function toObject():Object
        {
            return (new Object());
        }


    }
}//package com.evony.common.server.events

