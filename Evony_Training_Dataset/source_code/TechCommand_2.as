package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.castle.CoinsNeedResponse;
   import com.evony.common.module.tech.AvailableResearchListResponse;
   import com.evony.common.module.tech.ResearchResponse;
   
   public class TechCommand
   {
      public var _getCoinsNeed_callback:Function;
      
      public var _speedUpResearch_callback:Function;
      
      public var _research_callback:Function;
      
      public var _cancelResearch_callback:Function;
      
      private var sender:Sender;
      
      public var _getResearchList_callback:Function;
      
      public function TechCommand()
      {
         super();
      }
      
      public function research(param1:int, param2:int, param3:Function = null) : ResearchResponse
      {
         this._research_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("tech.research",{
               "castleId":param1,
               "techId":param2
            });
         }
         return null;
      }
      
      public function getCoinsNeed(param1:int, param2:Function = null) : CoinsNeedResponse
      {
         this._getCoinsNeed_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("tech.getCoinsNeed",{"castleId":param1});
         }
         return null;
      }
      
      public function getResearchList(param1:int, param2:Function = null) : AvailableResearchListResponse
      {
         this._getResearchList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("tech.getResearchList",{"castleId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function cancelResearch(param1:int, param2:Function = null) : CommandResponse
      {
         this._cancelResearch_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("tech.cancelResearch",{"castleId":param1});
         }
         return null;
      }
      
      public function speedUpResearch(param1:int, param2:String, param3:Function = null) : ResearchResponse
      {
         this._speedUpResearch_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("tech.speedUpResearch",{
               "castleId":param1,
               "itemId":param2
            });
         }
         return null;
      }
   }
}

