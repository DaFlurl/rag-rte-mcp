package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.troop.ProduceQueueResponse;
   import com.evony.common.module.troop.TroopProduceListResponse;
   
   public class TroopCommands
   {
      public var _getTroopProduceList_callback:Function;
      
      public var _produceTroop_callback:Function;
      
      public var _accTroopProduce_callback:Function;
      
      private var sender:Sender;
      
      public var _disbandTroop_callback:Function;
      
      public var _checkIdleBarrack_callback:Function;
      
      public var _getProduceQueue_callback:Function;
      
      public var _cancelTroopProduce_callback:Function;
      
      public function TroopCommands()
      {
         super();
      }
      
      public function getProduceQueue(param1:int, param2:Function = null) : ProduceQueueResponse
      {
         this._getProduceQueue_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("troop.getProduceQueue",{"castleId":param1});
         }
         return null;
      }
      
      public function getTroopProduceList(param1:int, param2:int, param3:Function = null) : TroopProduceListResponse
      {
         this._getTroopProduceList_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("troop.getTroopProduceList",{
               "castleId":param1,
               "positionId":param2
            });
         }
         return null;
      }
      
      public function cancelTroopProduce(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
      {
         this._cancelTroopProduce_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("troop.cancelTroopProduce",{
               "castleId":param1,
               "positionId":param2,
               "queueId":param3
            });
         }
         return null;
      }
      
      public function checkIdleBarrack(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._checkIdleBarrack_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("troop.checkIdleBarrack",{
               "castleId":param1,
               "troopType":param2
            });
         }
         return null;
      }
      
      public function disbandTroop(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
      {
         this._disbandTroop_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("troop.disbandTroop",{
               "castleId":param1,
               "troopType":param2,
               "num":param3
            });
         }
         return null;
      }
      
      public function produceTroop(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Function = null) : CommandResponse
      {
         this._produceTroop_callback = param7;
         if(this.sender != null)
         {
            this.sender.sendMessage("troop.produceTroop",{
               "castleId":param1,
               "positionId":param2,
               "troopType":param3,
               "num":param4,
               "isShare":param5,
               "toIdle":param6
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function accTroopProduce(param1:int, param2:int, param3:int, param4:String, param5:Function = null) : CommandResponse
      {
         this._accTroopProduce_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("troop.accTroopProduce",{
               "castleId":param1,
               "positionId":param2,
               "queueId":param3,
               "itemId":param4
            });
         }
         return null;
      }
   }
}

