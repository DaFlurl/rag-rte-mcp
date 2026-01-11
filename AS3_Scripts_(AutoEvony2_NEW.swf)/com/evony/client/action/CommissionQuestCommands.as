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

    public class CommissionQuestCommands 
    {

        public var _issueCommissionQuest_callback:Function;
        public var _getMyCommissionQuest_callback:Function;
        public var _acceptCommissionQuest_callback:Function;
        public var _getMyAcceptedCommissionQuest_callback:Function;
        public var _getCommissionQuestArmyInfo_callback:Function;
        public var _declineCommissionQuest_callback:Function;
        public var _addCommissionQuestArmy_callback:Function;
        private var sender:Sender;
        public var _getAllCommissionQuest_callback:Function;
        public var _getCommissionQuestArmyRanking_callback:Function;


        public function getAllCommissionQuest(_arg_1:Function=null):CommissionQuestRespone
        {
            this._getAllCommissionQuest_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.getAllCommissionQuest", {});
            };
            return (null);
        }

        public function getMyAcceptedCommissionQuest(_arg_1:Function=null):CommissionQuestRespone
        {
            this._getMyAcceptedCommissionQuest_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.getMyAcceptedCommissionQuest", {});
            };
            return (null);
        }

        public function acceptCommissionQuest(_arg_1:int, _arg_2:int, _arg_3:NewArmyParam, _arg_4:Function=null):CommandResponse
        {
            this._acceptCommissionQuest_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.acceptCommissionQuest", {
                    "castleId":_arg_1,
                    "questId":_arg_2,
                    "newArmyBean":_arg_3.toObject()
                });
            };
            return (null);
        }

        public function addCommissionQuestArmy(_arg_1:int, _arg_2:int, _arg_3:NewArmyParam, _arg_4:Function=null):CommandResponse
        {
            this._addCommissionQuestArmy_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.addCommissionQuestArmy", {
                    "castleId":_arg_1,
                    "questId":_arg_2,
                    "newArmyBean":_arg_3.toObject()
                });
            };
            return (null);
        }

        public function getCommissionQuestArmyRanking(_arg_1:int, _arg_2:Function=null):CommissionQuestArmyRespone
        {
            this._getCommissionQuestArmyRanking_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.getCommissionQuestArmyRanking", {"questId":_arg_1});
            };
            return (null);
        }

        public function getCommissionQuestArmyInfo(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommissionQuestArmyInfoRespone
        {
            this._getCommissionQuestArmyInfo_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.getCommissionQuestArmyInfo", {
                    "questId":_arg_1,
                    "playerId":_arg_2
                });
            };
            return (null);
        }

        public function issueCommissionQuest(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._issueCommissionQuest_callback = _arg_6;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.issueCommissionQuest", {
                    "castleId":_arg_1,
                    "type":_arg_2,
                    "targetX":_arg_3,
                    "targetY":_arg_4,
                    "reward":_arg_5
                });
            };
            return (null);
        }

        public function declineCommissionQuest(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._declineCommissionQuest_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.declineCommissionQuest", {"questId":_arg_1});
            };
            return (null);
        }

        public function getMyCommissionQuest(_arg_1:Function=null):CommissionQuestRespone
        {
            this._getMyCommissionQuest_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("commission.getMyCommissionQuest", {});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

