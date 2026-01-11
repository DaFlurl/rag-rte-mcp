package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.gamblingranking.GamblingRankingRespone;
   import com.evony.common.module.gamblingranking.GamblingRankingRewardRespone;
   
   public class GamblingRankingCommands
   {
      
      private var sender:Sender;
      
      public var _getGamblingRankingReward_callback:Function;
      
      public var _getGamblingRankingYesterday_callback:Function;
      
      public var _getGamblingRankingToday_callback:Function;
      
      public function GamblingRankingCommands()
      {
         super();
      }
      
      public function getGamblingRankingToday(param1:int, param2:int, param3:Function = null) : GamblingRankingRespone
      {
         this._getGamblingRankingToday_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamblingranking.getGamblingRankingToday",{
               "pageNo":param1,
               "pageSize":param2
            });
         }
         return null;
      }
      
      public function getGamblingRankingYesterday(param1:int, param2:int, param3:Function = null) : GamblingRankingRespone
      {
         this._getGamblingRankingYesterday_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamblingranking.getGamblingRankingYesterday",{
               "pageNo":param1,
               "pageSize":param2
            });
         }
         return null;
      }
      
      public function getGamblingRankingReward(param1:Function = null) : GamblingRankingRewardRespone
      {
         this._getGamblingRankingReward_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("gamblingranking.getGamblingRankingReward",{});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
   }
}

