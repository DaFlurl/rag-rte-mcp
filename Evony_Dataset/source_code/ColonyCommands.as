package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.colony.ColonialArmyResponse;
   import com.evony.common.module.colony.ColonialCastlesRespone;
   import com.evony.common.module.colony.ColonialDeployResponse;
   import com.evony.common.module.colony.ColonyLevyeRespone;
   import com.evony.common.module.colony.OverviewColonyCastleRespone;
   
   public class ColonyCommands
   {
      public var _uprise_callback:Function;
      
      public var _levyArmy_callback:Function;
      
      public var _abandonColony_callback:Function;
      
      public var _getDeployTroopsInfo_callback:Function;
      
      public var _speedUpAbandonColony_callback:Function;
      
      public var _reduceArmaments_callback:Function;
      
      public var _levyPopulation_callback:Function;
      
      public var _overviewColonialCastle_callback:Function;
      
      public var _setDeployTroops_callback:Function;
      
      public var _levyTaxes_callback:Function;
      
      public var _levyFood_callback:Function;
      
      public var _getColonialArmyInfo_callback:Function;
      
      public var _sowDiscord_callback:Function;
      
      private var sender:Sender;
      
      public var _getColonialCastlesInfo_callback:Function;
      
      public var _getSuzerainColonialCastlesInfo_callback:Function;
      
      public function ColonyCommands()
      {
         super();
      }
      
      public function levyArmy(param1:int, param2:int, param3:Function = null) : ColonyLevyeRespone
      {
         this._levyArmy_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.levyArmy",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function getColonialCastlesInfo(param1:int, param2:Function = null) : ColonialCastlesRespone
      {
         this._getColonialCastlesInfo_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.getColonialCastlesInfo",{"castleId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function overviewColonialCastle(param1:int, param2:int, param3:Function = null) : OverviewColonyCastleRespone
      {
         this._overviewColonialCastle_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.overviewColonialCastle",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function abandonColony(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._abandonColony_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.abandonColony",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function sowDiscord(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._sowDiscord_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.sowDiscord",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function getSuzerainColonialCastlesInfo(param1:int, param2:Function = null) : ColonialCastlesRespone
      {
         this._getSuzerainColonialCastlesInfo_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.getSuzerainColonialCastlesInfo",{"castleId":param1});
         }
         return null;
      }
      
      public function setDeployTroops(param1:int, param2:int, param3:TroopBean, param4:Function = null) : CommandResponse
      {
         this._setDeployTroops_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.setDeployTroops",{
               "castleId":param1,
               "targetCastleId":param2,
               "troopBean":param3.toObject()
            });
         }
         return null;
      }
      
      public function uprise(param1:int, param2:Function = null) : CommandResponse
      {
         this._uprise_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.uprise",{"castleId":param1});
         }
         return null;
      }
      
      public function getColonialArmyInfo(param1:int, param2:int, param3:Function = null) : ColonialArmyResponse
      {
         this._getColonialArmyInfo_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.getColonialArmyInfo",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function levyPopulation(param1:int, param2:int, param3:Function = null) : ColonyLevyeRespone
      {
         this._levyPopulation_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.levyPopulation",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function getDeployTroopsInfo(param1:int, param2:int, param3:Function = null) : ColonialDeployResponse
      {
         this._getDeployTroopsInfo_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.getDeployTroopsInfo",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function reduceArmaments(param1:int, param2:int, param3:Function = null) : ColonyLevyeRespone
      {
         this._reduceArmaments_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.reduceArmaments",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function levyFood(param1:int, param2:int, param3:Function = null) : ColonyLevyeRespone
      {
         this._levyFood_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.levyFood",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
      
      public function speedUpAbandonColony(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._speedUpAbandonColony_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.speedUpAbandonColony",{
               "castleId":param1,
               "targetCastleId":param2,
               "itemId":param3
            });
         }
         return null;
      }
      
      public function levyTaxes(param1:int, param2:int, param3:Function = null) : ColonyLevyeRespone
      {
         this._levyTaxes_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("colony.levyTaxes",{
               "castleId":param1,
               "targetCastleId":param2
            });
         }
         return null;
      }
   }
}

