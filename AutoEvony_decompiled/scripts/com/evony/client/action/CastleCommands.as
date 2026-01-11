package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.castle.AvailableBuilingListResponse;
   import com.evony.common.module.castle.CheckOutBuildingResponse;
   import com.evony.common.module.castle.CoinsNeedResponse;
   
   public class CastleCommands
   {
      
      public var _cancelBuildingQueue_callback:Function;
      
      public var _speedUpBuildCommand_callback:Function;
      
      public var _destructBuilding_callback:Function;
      
      public var _getAvailableBuildingListInside_callback:Function;
      
      public var _newBuilding_callback:Function;
      
      public var _upgradeBuilding_callback:Function;
      
      public var _cancleBuildCommand_callback:Function;
      
      public var _checkOutUpgrade_callback:Function;
      
      internal var sender:Sender;
      
      public var _getAvailableBuildingListOutside_callback:Function;
      
      public var _newBuildingQueue_callback:Function;
      
      public var _speedupBuildingQueue_callback:Function;
      
      public var _getAvailableBuildingBean_callback:Function;
      
      public var _getDestructBuildBean_callback:Function;
      
      public var _UpdateCastleResources_callback:Function;
      
      public var _getCoinsNeed_callback:Function;
      
      public var _getBuildingQueueCoinsNeed_callback:Function;
      
      public var _demolishBuildingQueue_callback:Function;
      
      public function CastleCommands()
      {
         super();
      }
      
      public function getAvailableBuildingListInside(param1:int, param2:Function = null) : AvailableBuilingListResponse
      {
         this._getAvailableBuildingListInside_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.getAvailableBuildingListInside",{"castleId":param1});
         }
         return null;
      }
      
      public function getCoinsNeed(param1:int, param2:int, param3:Function = null) : CoinsNeedResponse
      {
         this._getCoinsNeed_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.getCoinsNeed",{
               "castleId":param1,
               "positionId":param2
            });
         }
         return null;
      }
      
      public function getDestructBuildBean(param1:int, param2:int, param3:Function = null) : AvailableBuilingListResponse
      {
         this._getDestructBuildBean_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.getDestructBuildBean",{
               "castleId":param1,
               "positionId":param2
            });
         }
         return null;
      }
      
      public function checkOutUpgrade(param1:int, param2:int, param3:Function = null) : CheckOutBuildingResponse
      {
         this._checkOutUpgrade_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.checkOutUpgrade",{
               "castleId":param1,
               "positionId":param2
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function speedupBuildingQueue(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._speedupBuildingQueue_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.speedupBuildingQueue",{
               "castleId":param1,
               "queueId":param2,
               "itemId":param3
            });
         }
         return null;
      }
      
      public function getAvailableBuildingListOutside(param1:int, param2:Function = null) : AvailableBuilingListResponse
      {
         this._getAvailableBuildingListOutside_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.getAvailableBuildingListOutside",{"castleId":param1});
         }
         return null;
      }
      
      public function demolishBuildingQueue(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : CommandResponse
      {
         this._demolishBuildingQueue_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.demolishBuildingQueue",{
               "castleId":param1,
               "type":param2,
               "level":param3,
               "positionId":param4
            });
         }
         return null;
      }
      
      public function getAvailableBuildingBean(param1:int, param2:int, param3:Function = null) : AvailableBuilingListResponse
      {
         this._getAvailableBuildingBean_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.getAvailableBuildingBean",{
               "castleId":param1,
               "typeId":param2
            });
         }
         return null;
      }
      
      public function cancelBuildingQueue(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._cancelBuildingQueue_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.cancelBuildingQueue",{
               "castleId":param1,
               "queueId":param2
            });
         }
         return null;
      }
      
      public function speedUpBuildCommand(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._speedUpBuildCommand_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.speedUpBuildCommand",{
               "castleId":param1,
               "positionId":param2,
               "itemId":param3
            });
         }
         return null;
      }
      
      public function cancleBuildCommand(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._cancleBuildCommand_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.cancleBuildCommand",{
               "castleId":param1,
               "positionId":param2
            });
         }
         return null;
      }
      
      public function UpdateCastleResources(param1:int, param2:Function = null) : AvailableBuilingListResponse
      {
         this._UpdateCastleResources_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.UpdateCastleResources",{"castleId":param1});
         }
         return null;
      }
      
      public function upgradeBuilding(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._upgradeBuilding_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.upgradeBuilding",{
               "castleId":param1,
               "positionId":param2
            });
         }
         return null;
      }
      
      public function newBuilding(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
      {
         this._newBuilding_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.newBuilding",{
               "castleId":param1,
               "positionId":param2,
               "buildingType":param3
            });
         }
         return null;
      }
      
      public function getBuildingQueueCoinsNeed(param1:int, param2:int, param3:Function = null) : CoinsNeedResponse
      {
         this._getBuildingQueueCoinsNeed_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.getBuildingQueueCoinsNeed",{
               "castleId":param1,
               "queueId":param2
            });
         }
         return null;
      }
      
      public function destructBuilding(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._destructBuilding_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.destructBuilding",{
               "castleId":param1,
               "positionId":param2
            });
         }
         return null;
      }
      
      public function newBuildingQueue(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : CommandResponse
      {
         this._newBuildingQueue_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("castle.newBuildingQueue",{
               "castleId":param1,
               "type":param2,
               "level":param3,
               "positionId":param4
            });
         }
         return null;
      }
   }
}

