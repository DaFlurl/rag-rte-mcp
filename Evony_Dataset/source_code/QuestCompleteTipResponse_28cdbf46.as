// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.QuestCompleteTipResponse

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.QuestBean;

    public class QuestCompleteTipResponse extends BaseBean 
    {

        public var quest:QuestBean;
        public var name:String;
        public var questId:int;

        public function QuestCompleteTipResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.name != null)
            {
                this.name = _arg_2.name;
            };
            if (_arg_2.quest != null)
            {
                this.quest = new QuestBean(_arg_2.quest);
            };
            if (_arg_2.questId != null)
            {
                this.questId = _arg_2.questId;
            };
        }

        public function copyTo(_arg_1:QuestCompleteTipResponse):void
        {
            _arg_1.name = this.name;
            if (this.quest != null)
            {
                this.quest.copyTo(_arg_1.quest);
            }
            else
            {
                _arg_1.quest = null;
            };
            _arg_1.questId = this.questId;
        }

        public function toObject():Object
        {
            return ({
                "name":this.name,
                "quest":this.quest.toObject(),
                "questId":this.questId
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((("---- QuestCompleteTipResponse ----\n" + (((_arg_1 + "name = ") + this.name) + "\n")) + ((this.quest != null) ? this.quest.toDebugString((_arg_1 + "quest.")) : (_arg_1 + "quest = null\n"))) + (((_arg_1 + "questId = ") + this.questId) + "\n"));
        }


    }
}//package com.evony.common.server.events

