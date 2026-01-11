package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   
   public class VoteToPlayerCommands
   {
      public var _voteToPlayerByName_callback:Function;
      
      private var sender:Sender;
      
      public var _voteToPlayerById_callback:Function;
      
      public function VoteToPlayerCommands()
      {
         super();
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function voteToPlayerById(param1:int, param2:Function = null) : CommandResponse
      {
         this._voteToPlayerById_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("vote.voteToPlayerById",{"playerId":param1});
         }
         return null;
      }
      
      public function voteToPlayerByName(param1:String, param2:Function = null) : CommandResponse
      {
         this._voteToPlayerByName_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("vote.voteToPlayerByName",{"name":param1});
         }
         return null;
      }
   }
}

