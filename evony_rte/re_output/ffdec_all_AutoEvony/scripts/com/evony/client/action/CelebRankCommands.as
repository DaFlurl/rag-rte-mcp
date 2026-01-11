package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.celeb.CelebResponse;
   
   public class CelebRankCommands
   {
      
      public var _findPlayerByStar_callback:Function;
      
      public var _findPlayerByPrestige_callback:Function;
      
      private var sender:Sender;
      
      public var _findAllianceByPrestige_callback:Function;
      
      public var _findPlayerByTitle_callback:Function;
      
      public function CelebRankCommands()
      {
         super();
      }
      
      public function findPlayerByStar(param1:int, param2:Function = null) : CelebResponse
      {
         this._findPlayerByStar_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("celeb.findPlayerByStar",{"starlv":param1});
         }
         return null;
      }
      
      public function findPlayerByTitle(param1:String, param2:Function = null) : CelebResponse
      {
         this._findPlayerByTitle_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("celeb.findPlayerByTitle",{"title":param1});
         }
         return null;
      }
      
      public function findPlayerByPrestige(param1:String, param2:Function = null) : CelebResponse
      {
         this._findPlayerByPrestige_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("celeb.findPlayerByPrestige",{"prestige":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function findAllianceByPrestige(param1:String, param2:Function = null) : CelebResponse
      {
         this._findAllianceByPrestige_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("celeb.findAllianceByPrestige",{"prestige":param1});
         }
         return null;
      }
   }
}

