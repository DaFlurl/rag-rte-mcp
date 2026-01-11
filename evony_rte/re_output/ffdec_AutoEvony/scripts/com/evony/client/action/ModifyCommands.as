package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.gamemaster.CreateHeroResponse;
   
   public class ModifyCommands
   {
      
      public var _removeHero_callback:Function;
      
      public var _removeBuilding_callback:Function;
      
      private var sender:Sender;
      
      public var _removeItem_callback:Function;
      
      public var _setResources_callback:Function;
      
      public var _addItems_callback:Function;
      
      public var _addHero_callback:Function;
      
      public var _addBuilding_callback:Function;
      
      public var _setTechnology_callback:Function;
      
      public function ModifyCommands()
      {
         super();
      }
      
      public function setTechnology(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._setTechnology_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.setTechnology",{
               "technologyType":param1,
               "level":param2
            });
         }
         return null;
      }
      
      public function removeBuilding(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._removeBuilding_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.removeBuilding",{
               "castleId":param1,
               "position":param2
            });
         }
         return null;
      }
      
      public function removeHero(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._removeHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.removeHero",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function addItems(param1:String, param2:int, param3:Function = null) : CommandResponse
      {
         this._addItems_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.addItems",{
               "type":param1,
               "amount":param2
            });
         }
         return null;
      }
      
      public function setResources(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Function = null) : CommandResponse
      {
         this._setResources_callback = param8;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.setResources",{
               "castleId":param1,
               "wood":param2,
               "iron":param3,
               "stone":param4,
               "food":param5,
               "gold":param6,
               "population":param7
            });
         }
         return null;
      }
      
      public function addBuilding(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : CommandResponse
      {
         this._addBuilding_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.addBuilding",{
               "castleId":param1,
               "buildingType":param2,
               "position":param3,
               "level":param4
            });
         }
         return null;
      }
      
      public function removeItem(param1:String, param2:Function = null) : CommandResponse
      {
         this._removeItem_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.removeItem",{"type":param1});
         }
         return null;
      }
      
      public function addHero(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Function = null) : CreateHeroResponse
      {
         this._addHero_callback = param11;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamemaster.addHero",{
               "castleId":param1,
               "name":param2,
               "level":param3,
               "experience":param4,
               "loyalty":param5,
               "status":param6,
               "management":param7,
               "power":param8,
               "stratagem":param9,
               "remain":param10
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

