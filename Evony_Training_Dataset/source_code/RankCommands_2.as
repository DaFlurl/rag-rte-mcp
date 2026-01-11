package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.rank.RankAllianceResponse;
   import com.evony.common.module.rank.RankCastleResponse;
   import com.evony.common.module.rank.RankHeroResponse;
   import com.evony.common.module.rank.RankPlayerResponse;
   import com.evony.common.module.rank.RankPlayerVotesResponse;
   import com.evony.common.module.rank.TopVotesPlayersResponse;
   
   public class RankCommands
   {
      public var _getPlayerRank_callback:Function;
      
      public var _getHeroRank_callback:Function;
      
      public var _getCastleRank_callback:Function;
      
      public var _getAllianceRank_callback:Function;
      
      private var sender:Sender;
      
      public var _getVoteRank_callback:Function;
      
      public var _getTopVotesPlayer_callback:Function;
      
      public function RankCommands()
      {
         super();
      }
      
      public function getPlayerRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankPlayerResponse
      {
         this._getPlayerRank_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("rank.getPlayerRank",{
               "key":param1,
               "pageNo":param2,
               "pageSize":param3,
               "sortType":param4
            });
         }
         return null;
      }
      
      public function getTopVotesPlayer(param1:Function = null) : TopVotesPlayersResponse
      {
         this._getTopVotesPlayer_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("rank.getTopVotesPlayer",new Object());
         }
         return null;
      }
      
      public function getVoteRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankPlayerVotesResponse
      {
         this._getVoteRank_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("rank.getVoteRank",{
               "key":param1,
               "pageNo":param2,
               "pageSize":param3,
               "sortType":param4
            });
         }
         return null;
      }
      
      public function getAllianceRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankAllianceResponse
      {
         this._getAllianceRank_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("rank.getAllianceRank",{
               "key":param1,
               "pageNo":param2,
               "pageSize":param3,
               "sortType":param4
            });
         }
         return null;
      }
      
      public function getCastleRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankCastleResponse
      {
         this._getCastleRank_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("rank.getCastleRank",{
               "key":param1,
               "pageNo":param2,
               "pageSize":param3,
               "sortType":param4
            });
         }
         return null;
      }
      
      public function getHeroRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankHeroResponse
      {
         this._getHeroRank_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("rank.getHeroRank",{
               "key":param1,
               "pageNo":param2,
               "pageSize":param3,
               "sortType":param4
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

