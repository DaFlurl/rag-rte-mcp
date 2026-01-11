package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.trade.SearchTradesResponse;
   import com.evony.common.module.trade.TradeListResponse;
   import com.evony.common.module.trade.TransingTradeListResponse;
   
   public class TradeCommands
   {
      public var _newTrade_callback:Function;
      
      public var _getMyTradeList_callback:Function;
      
      public var _searchTrades_callback:Function;
      
      public var _getTransingTradeList_callback:Function;
      
      private var sender:Sender;
      
      public var _cancelTrade_callback:Function;
      
      public var _speedUpTrans_callback:Function;
      
      public function TradeCommands()
      {
         super();
      }
      
      public function getMyTradeList(param1:int, param2:Function = null) : TradeListResponse
      {
         this._getMyTradeList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("trade.getMyTradeList",{"castleId":param1});
         }
         return null;
      }
      
      public function newTrade(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Function = null) : CommandResponse
      {
         this._newTrade_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("trade.newTrade",{
               "castleId":param1,
               "resType":param2,
               "tradeType":param3,
               "amount":param4,
               "price":param5
            });
         }
         return null;
      }
      
      public function cancelTrade(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._cancelTrade_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("trade.cancelTrade",{
               "castleId":param1,
               "tradeId":param2
            });
         }
         return null;
      }
      
      public function speedUpTrans(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._speedUpTrans_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("trade.speedUpTrans",{
               "castleId":param1,
               "transingTradeId":param2,
               "itemId":param3
            });
         }
         return null;
      }
      
      public function searchTrades(param1:int, param2:Function = null) : SearchTradesResponse
      {
         this._searchTrades_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("trade.searchTrades",{"resType":param1});
         }
         return null;
      }
      
      public function getTransingTradeList(param1:int, param2:Function = null) : TransingTradeListResponse
      {
         this._getTransingTradeList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("trade.getTransingTradeList",{"castleId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

