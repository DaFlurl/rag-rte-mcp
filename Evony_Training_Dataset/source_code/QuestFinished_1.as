// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.QuestFinished

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class QuestFinished extends BaseBean 
    {

        public var finishedQuest:int;

        public function QuestFinished(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.finishedQuest != null)
            {
                this.finishedQuest = _arg_2.finishedQuest;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.finishedQuest = this.finishedQuest;
            return (_local_1);
        }

        public function copyTo(_arg_1:QuestFinished):void
        {
            _arg_1.finishedQuest = this.finishedQuest;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- QuestFinished ----\n";
            return (_local_2 + (((_arg_1 + "finishedQuest = ") + this.finishedQuest) + "\n"));
        }


    }
}//package com.evony.common.server.events

