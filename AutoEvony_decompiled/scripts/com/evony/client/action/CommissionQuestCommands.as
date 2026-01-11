package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.commission.CommissionQuestArmyInfoRespone;
   import com.evony.common.module.commission.CommissionQuestArmyRespone;
   import com.evony.common.module.commission.CommissionQuestRespone;
   import com.evony.common.paramBeans.NewArmyParam;
   
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
      
      public function CommissionQuestCommands()
      {
         super();
      }
      
      public function getAllCommissionQuest(param1:Function = null) : CommissionQuestRespone
      {
         this._getAllCommissionQuest_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.getAllCommissionQuest",{});
         }
         return null;
      }
      
      public function getMyAcceptedCommissionQuest(param1:Function = null) : CommissionQuestRespone
      {
         this._getMyAcceptedCommissionQuest_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.getMyAcceptedCommissionQuest",{});
         }
         return null;
      }
      
      public function acceptCommissionQuest(param1:int, param2:int, param3:NewArmyParam, param4:Function = null) : CommandResponse
      {
         this._acceptCommissionQuest_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.acceptCommissionQuest",{
               "castleId":param1,
               "questId":param2,
               "newArmyBean":param3.toObject()
            });
         }
         return null;
      }
      
      public function addCommissionQuestArmy(param1:int, param2:int, param3:NewArmyParam, param4:Function = null) : CommandResponse
      {
         this._addCommissionQuestArmy_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.addCommissionQuestArmy",{
               "castleId":param1,
               "questId":param2,
               "newArmyBean":param3.toObject()
            });
         }
         return null;
      }
      
      public function getCommissionQuestArmyRanking(param1:int, param2:Function = null) : CommissionQuestArmyRespone
      {
         this._getCommissionQuestArmyRanking_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.getCommissionQuestArmyRanking",{"questId":param1});
         }
         return null;
      }
      
      public function getCommissionQuestArmyInfo(param1:int, param2:int, param3:Function = null) : CommissionQuestArmyInfoRespone
      {
         this._getCommissionQuestArmyInfo_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.getCommissionQuestArmyInfo",{
               "questId":param1,
               "playerId":param2
            });
         }
         return null;
      }
      
      public function issueCommissionQuest(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
      {
         this._issueCommissionQuest_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.issueCommissionQuest",{
               "castleId":param1,
               "type":param2,
               "targetX":param3,
               "targetY":param4,
               "reward":param5
            });
         }
         return null;
      }
      
      public function declineCommissionQuest(param1:int, param2:Function = null) : CommandResponse
      {
         this._declineCommissionQuest_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.declineCommissionQuest",{"questId":param1});
         }
         return null;
      }
      
      public function getMyCommissionQuest(param1:Function = null) : CommissionQuestRespone
      {
         this._getMyCommissionQuest_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("commission.getMyCommissionQuest",{});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

