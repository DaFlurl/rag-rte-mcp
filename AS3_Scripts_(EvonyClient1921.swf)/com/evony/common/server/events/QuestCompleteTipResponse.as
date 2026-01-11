// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.QuestCompleteTipResponse

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.QuestBean;
    import com.evony.common.beans.*;

    public class QuestCompleteTipResponse extends BaseBean 
    {

        public var quest:QuestBean;
        public var name:String;
        public var questId:int;

        public function QuestCompleteTipResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
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
            if (quest != null)
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
            var _local_1:Object = new Object();
            _local_1.name = this.name;
            _local_1.quest = this.quest.toObject();
            _local_1.questId = this.questId;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- QuestCompleteTipResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            if (quest != null)
            {
                _local_2 = (_local_2 + this.quest.toDebugString((_arg_1 + "quest.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "quest = null\n"));
            };
            return (_local_2 + (((_arg_1 + "questId = ") + this.questId) + "\n"));
        }


    }
}//package com.evony.common.server.events

