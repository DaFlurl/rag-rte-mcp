// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.QuestFinished

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class QuestFinished extends BaseBean 
    {

        public var finishedQuest:int;

        public function QuestFinished(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.finishedQuest != null)
            {
                this.finishedQuest = _arg_2.finishedQuest;
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ("---- QuestFinished ----\n" + (((_arg_1 + "finishedQuest = ") + this.finishedQuest) + "\n"));
        }

        public function toObject():Object
        {
            return ({"finishedQuest":this.finishedQuest});
        }

        public function copyTo(_arg_1:QuestFinished):void
        {
            _arg_1.finishedQuest = this.finishedQuest;
        }


    }
}//package com.evony.common.server.events

