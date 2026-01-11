package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.army.ArmyPracticeResponse;
   import com.evony.common.module.army.StayAllianceReponse;
   import com.evony.common.module.army.TroopParamResponse;
   import com.evony.common.paramBeans.NewArmyParam;
   
   public class ArmyCommands
   {
      public var _callBackArmy_callback:Function;
      
      internal var sender:Sender;
      
      public var _getInjuredTroop_callback:Function;
      
      public var _newArmy_callback:Function;
      
      public var _getFleeTroop_callback:Function;
      
      public var _getTroopParam_callback:Function;
      
      public var _setArmyGoOut_callback:Function;
      
      public var _disbandFleeTroop_callback:Function;
      
      public var _disbandInjuredTroop_callback:Function;
      
      public var _exerciseArmy_callback:Function;
      
      public var _setAllowAllianceArmy_callback:Function;
      
      public var _getStayAllianceArmys_callback:Function;
      
      public var _cureInjuredTroop_callback:Function;
      
      public var _recruitFleeTroop_callback:Function;
      
      public var _id:String = "ArmyCommands";
      
      public function ArmyCommands()
      {
         super();
      }
      
      public function getStayAllianceArmys(param1:int, param2:Function = null) : StayAllianceReponse
      {
         this._getStayAllianceArmys_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.getStayAllianceArmys",{"castleId":param1});
         }
         return null;
      }
      
      public function disbandFleeTroop(param1:int, param2:Function = null) : CommandResponse
      {
         this._disbandFleeTroop_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.disbandFleeTroop",{"castleId":param1});
         }
         return null;
      }
      
      public function recruitFleeTroop(param1:int, param2:Function = null) : CommandResponse
      {
         this._recruitFleeTroop_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.recruitFleeTroop",{"castleId":param1});
         }
         return null;
      }
      
      public function getTroopParam(param1:int, param2:Function = null) : TroopParamResponse
      {
         this._getTroopParam_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.getTroopParam",{"castleId":param1});
         }
         return null;
      }
      
      public function exerciseArmy(param1:int, param2:TroopBean, param3:TroopBean, param4:Function = null) : ArmyPracticeResponse
      {
         this._exerciseArmy_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.exerciseArmy",{
               "castleId":param1,
               "troopParamAttack":param2,
               "troopParamDefend":param3
            });
         }
         return null;
      }
      
      public function getFleeTroop(param1:int, param2:Function = null) : CommandResponse
      {
         this._getFleeTroop_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.getFleeTroop",{"castleId":param1});
         }
         return null;
      }
      
      public function disbandInjuredTroop(param1:int, param2:Function = null) : CommandResponse
      {
         this._disbandInjuredTroop_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.disbandInjuredTroop",{"castleId":param1});
         }
         return null;
      }
      
      public function newArmy(param1:int, param2:NewArmyParam, param3:Function = null) : CommandResponse
      {
         this._newArmy_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.newArmy",{
               "castleId":param1,
               "newArmyBean":param2
            });
         }
         return null;
      }
      
      public function setAllowAllianceArmy(param1:int, param2:Boolean, param3:Function = null) : CommandResponse
      {
         this._setAllowAllianceArmy_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.setAllowAllianceArmy",{
               "castleId":param1,
               "isAllow":param2
            });
         }
         return null;
      }
      
      public function getInjuredTroop(param1:int, param2:Function = null) : CommandResponse
      {
         this._getInjuredTroop_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.getInjuredTroop",{"castleId":param1});
         }
         return null;
      }
      
      public function callBackArmy(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._callBackArmy_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.callBackArmy",{
               "castleId":param1,
               "armyId":param2
            });
         }
         return null;
      }
      
      public function setArmyGoOut(param1:int, param2:Boolean, param3:Function = null) : CommandResponse
      {
         this._setArmyGoOut_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.setArmyGoOut",{
               "castleId":param1,
               "isArmyGoOut":param2
            });
         }
         return null;
      }
      
      public function cureInjuredTroop(param1:int, param2:Function = null) : CommandResponse
      {
         this._cureInjuredTroop_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("army.cureInjuredTroop",{"castleId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

