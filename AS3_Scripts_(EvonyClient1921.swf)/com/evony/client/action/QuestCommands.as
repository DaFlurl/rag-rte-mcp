// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.QuestCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.quest.QuestListResponse;
    import com.evony.common.module.quest.QuestTypeResponse;
    import com.evony.common.module.quest.QuestRewardRespone;
    import com.evony.common.module.quest.EffortListResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class QuestCommands 
    {

        public var _award_callback:Function;
        public var _getAwardItems_callback:Function;
        public var _donate_callback:Function;
        public var _AllowRegister_callback:Function;
        public var _accept_callback:Function;
        public var _awardPacket_callback:Function;
        public var _getQuestType_callback:Function;
        public var _getEffortList_callback:Function;
        public var _getEffortListByTargeTypeid_callback:Function;
        public var _abandon_callback:Function;
        public var _getQuestList_callback:Function;
        private var sender:Sender;


        public function abandon(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._abandon_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.questid = _arg_1;
            _local_4.castleid = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.abandon", _local_4);
            };
            return (null);
        }

        public function awardPacket(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._awardPacket_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.questId = _arg_2;
            _local_5.key = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("quest.awardPacket", _local_5);
            };
            return (null);
        }

        public function accept(_arg_1:int, _arg_2:int, _arg_3:Function=null):QuestListResponse
        {
            this._accept_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.ncpid = _arg_1;
            _local_4.castleid = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.accept", _local_4);
            };
            return (null);
        }

        public function getQuestType(_arg_1:int, _arg_2:int, _arg_3:Function=null):QuestTypeResponse
        {
            this._getQuestType_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.type = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.getQuestType", _local_4);
            };
            return (null);
        }

        public function getAwardItems(_arg_1:int, _arg_2:Function=null):QuestRewardRespone
        {
            this._getAwardItems_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.questId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("quest.getAwardItems", _local_3);
            };
            return (null);
        }

        public function getEffortList(_arg_1:int, _arg_2:Function=null):EffortListResponse
        {
            this._getEffortList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("quest.getEffortList", _local_3);
            };
            return (null);
        }

        public function getEffortListByTargeTypeid(_arg_1:int, _arg_2:int, _arg_3:Function=null):QuestListResponse
        {
            this._getEffortListByTargeTypeid_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.TargeTypeid = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.getEffortListByTargeTypeid", _local_4);
            };
            return (null);
        }

        public function donate(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._donate_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.questid = _arg_1;
            _local_4.castleid = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.donate", _local_4);
            };
            return (null);
        }

        public function getQuestList(_arg_1:int, _arg_2:int, _arg_3:Function=null):QuestListResponse
        {
            this._getQuestList_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.typeId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.getQuestList", _local_4);
            };
            return (null);
        }

        public function AllowRegister(_arg_1:Function=null):CommandResponse
        {
            this._AllowRegister_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("quest.AllowRegister", _local_2);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function award(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._award_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.questId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.award", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

