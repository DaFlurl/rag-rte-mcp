package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.fortifications.FortProduceListResponse;
   import com.evony.common.module.troop.ProduceQueueResponse;
   
   public class FortificationsCommands
   {
      public var _produceWallProtect_callback:Function;
      
      public var _getProduceQueue_callback:Function;
      
      public var _destructWallProtect_callback:Function;
      
      private var sender:Sender;
      
      public var _accTroopProduce_callback:Function;
      
      public var _getFortificationsProduceList_callback:Function;
      
      public var _cancelFortificationProduce_callback:Function;
      
      public function FortificationsCommands()
      {
         super();
      }
      
      public function getFortificationsProduceList(param1:int, param2:Function = null) : FortProduceListResponse
      {
         this._getFortificationsProduceList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("fortifications.getFortificationsProduceList",{"castleId":param1});
         }
         return null;
      }
      
      public function produceWallProtect(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
      {
         this._produceWallProtect_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("fortifications.produceWallProtect",{
               "castleId":param1,
               "wallProtectType":param2,
               "num":param3
            });
         }
         return null;
      }
      
      public function cancelFortificationProduce(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._cancelFortificationProduce_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("fortifications.cancelFortificationProduce",{
               "castleId":param1,
               "queueId":param2
            });
         }
         return null;
      }
      
      public function destructWallProtect(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
      {
         this._destructWallProtect_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("fortifications.destructWallProtect",{
               "castleId":param1,
               "typeId":param2,
               "num":param3
            });
         }
         return null;
      }
      
      public function accTroopProduce(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._accTroopProduce_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("fortifications.accTroopProduce",{
               "castleId":param1,
               "queueId":param2,
               "itemId":param3
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function getProduceQueue(param1:int, param2:Function = null) : ProduceQueueResponse
      {
         this._getProduceQueue_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("fortifications.getProduceQueue",{"castleId":param1});
         }
         return null;
      }
   }
}

