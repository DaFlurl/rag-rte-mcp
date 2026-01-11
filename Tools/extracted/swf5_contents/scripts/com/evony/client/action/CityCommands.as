package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.city.StoreListResponse;
   
   public class CityCommands
   {
      public var _advMoveCastle_callback:Function;
      
      public var _modifyCastleName_callback:Function;
      
      public var _WarMoveCastle_callback:Function;
      
      public var _modifyUserName_callback:Function;
      
      public var _modifyCastleIcon_callback:Function;
      
      public var _getStoreList_callback:Function;
      
      public var _modifyFlag_callback:Function;
      
      public var _giveupCastle_callback:Function;
      
      public var _moveCastle_callback:Function;
      
      public var _modifyStorePercent_callback:Function;
      
      public var _uniteAdvMoveCastle_callback:Function;
      
      public var _constructCastle_callback:Function;
      
      internal var sender:Sender;
      
      public var _setStopWarState_callback:Function;
      
      public function CityCommands()
      {
         super();
      }
      
      public function giveupCastle(param1:String, param2:int, param3:Function = null) : CommandResponse
      {
         this._giveupCastle_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.giveupCastle",{
               "password":param1,
               "castleId":param2
            });
         }
         return null;
      }
      
      public function modifyStorePercent(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
      {
         this._modifyStorePercent_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.modifyStorePercent",{
               "castleId":param1,
               "foodrate":param2,
               "woodrate":param3,
               "stonerate":param4,
               "ironrate":param5
            });
         }
         return null;
      }
      
      public function modifyFlag(param1:String, param2:Function = null) : CommandResponse
      {
         this._modifyFlag_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.modifyFlag",{"newFlag":param1});
         }
         return null;
      }
      
      public function WarMoveCastle(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._WarMoveCastle_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.WarMoveCastle",{
               "castleId":param1,
               "targetId":param2
            });
         }
         return null;
      }
      
      public function modifyUserName(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._modifyUserName_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.modifyUserName",{
               "userName":param1,
               "itemId":param2
            });
         }
         return null;
      }
      
      public function uniteAdvMoveCastle(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._uniteAdvMoveCastle_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.uniteAdvMoveCastle",{
               "castleId":param1,
               "targetId":param2
            });
         }
         return null;
      }
      
      public function getStoreList(param1:int, param2:Function = null) : StoreListResponse
      {
         this._getStoreList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.getStoreList",{"castleId":param1});
         }
         return null;
      }
      
      public function modifyCastleIcon(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._modifyCastleIcon_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.modifyCastleIcon",{
               "castleId":param1,
               "icon":param2
            });
         }
         return null;
      }
      
      public function setStopWarState(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._setStopWarState_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.setStopWarState",{
               "ItemId":param1,
               "passWord":param2
            });
         }
         return null;
      }
      
      public function constructCastle(param1:int, param2:int, param3:Boolean, param4:Function = null) : CommandResponse
      {
         this._constructCastle_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.constructCastle",{
               "castleId":param1,
               "fieldId":param2,
               "isTroopBack":param3
            });
         }
         return null;
      }
      
      public function moveCastle(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._moveCastle_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.moveCastle",{
               "castleId":param1,
               "zoneId":param2
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function advMoveCastle(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._advMoveCastle_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.advMoveCastle",{
               "castleId":param1,
               "targetId":param2
            });
         }
         return null;
      }
      
      public function modifyCastleName(param1:int, param2:String, param3:String, param4:Function = null) : CommandResponse
      {
         this._modifyCastleName_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("city.modifyCastleName",{
               "castleId":param1,
               "name":param2,
               "logUrl":param3
            });
         }
         return null;
      }
   }
}

