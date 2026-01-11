// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CommissionQuestCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.commission.CommissionQuestRespone;
    import com.evony.common.paramBeans.NewArmyParam;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.commission.CommissionQuestArmyRespone;
    import com.evony.common.module.commission.CommissionQuestArmyInfoRespone;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class CommissionQuestCommands 
    {

        public var _issueCommissionQuest_callback:Function;
        public var _getMyCommissionQuest_callback:Function;
        public var _acceptCommissionQuest_callback:Function;
        public var _getMyAcceptedCommissionQuest_callback:Function;
        public var _getCommissionQuestArmyInfo_callback:Function;
        public var _declineCommissionQuest_callback:Function;
        private var sender:Sender;
        public var _getAllCommissionQuest_callback:Function;
        public var _addCommissionQuestArmy_callback:Function;
        public var _getCommissionQuestArmyRanking_callback:Function;


        public function getAllCommissionQuest(_arg_1:Function=null):CommissionQuestRespone
        {
            this._getAllCommissionQuest_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("commission.getAllCommissionQuest", _local_2);
            };
            return (null);
        }

        public function acceptCommissionQuest(_arg_1:int, _arg_2:int, _arg_3:NewArmyParam, _arg_4:Function=null):CommandResponse
        {
            this._acceptCommissionQuest_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.questId = _arg_2;
            _local_5.newArmyBean = _arg_3.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("commission.acceptCommissionQuest", _local_5);
            };
            return (null);
        }

        public function addCommissionQuestArmy(_arg_1:int, _arg_2:int, _arg_3:NewArmyParam, _arg_4:Function=null):CommandResponse
        {
            this._addCommissionQuestArmy_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.questId = _arg_2;
            _local_5.newArmyBean = _arg_3.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("commission.addCommissionQuestArmy", _local_5);
            };
            return (null);
        }

        public function getMyAcceptedCommissionQuest(_arg_1:Function=null):CommissionQuestRespone
        {
            this._getMyAcceptedCommissionQuest_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("commission.getMyAcceptedCommissionQuest", _local_2);
            };
            return (null);
        }

        public function getCommissionQuestArmyRanking(_arg_1:int, _arg_2:Function=null):CommissionQuestArmyRespone
        {
            this._getCommissionQuestArmyRanking_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.questId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("commission.getCommissionQuestArmyRanking", _local_3);
            };
            return (null);
        }

        public function getCommissionQuestArmyInfo(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommissionQuestArmyInfoRespone
        {
            this._getCommissionQuestArmyInfo_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.questId = _arg_1;
            _local_4.playerId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("commission.getCommissionQuestArmyInfo", _local_4);
            };
            return (null);
        }

        public function issueCommissionQuest(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._issueCommissionQuest_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.type = _arg_2;
            _local_7.targetX = _arg_3;
            _local_7.targetY = _arg_4;
            _local_7.reward = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("commission.issueCommissionQuest", _local_7);
            };
            return (null);
        }

        public function declineCommissionQuest(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._declineCommissionQuest_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.questId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("commission.declineCommissionQuest", _local_3);
            };
            return (null);
        }

        public function getMyCommissionQuest(_arg_1:Function=null):CommissionQuestRespone
        {
            this._getMyCommissionQuest_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("commission.getMyCommissionQuest", _local_2);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

