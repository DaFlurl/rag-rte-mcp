package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.visit.GetAllVisitorCommentsResponse;
   import com.evony.common.module.visit.GetHelpedPlayersResponse;
   
   public class VisitCommands
   {
      public var _helpIncreaseProduction_callback:Function;
      
      public var _markCommentAsRead_callback:Function;
      
      public var _getAllVisitorComments_callback:Function;
      
      public var _deleteComment_callback:Function;
      
      public var _getHelpedPlayers_callback:Function;
      
      private var sender:Sender;
      
      public var _getVisitorComments_callback:Function;
      
      public var _visitorComment_callback:Function;
      
      public function VisitCommands()
      {
         super();
      }
      
      public function visitorComment(param1:String, param2:Function = null) : CommandResponse
      {
         this._visitorComment_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("visit.visitorComment",{"comment":param1});
         }
         return null;
      }
      
      public function getHelpedPlayers(param1:Function = null) : GetHelpedPlayersResponse
      {
         this._getHelpedPlayers_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("visit.getHelpedPlayers",{});
         }
         return null;
      }
      
      public function deleteComment(param1:int, param2:Function = null) : CommandResponse
      {
         this._deleteComment_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("visit.deleteComment",{"id":param1});
         }
         return null;
      }
      
      public function getVisitorComments(param1:String, param2:int, param3:int, param4:Function = null) : GetAllVisitorCommentsResponse
      {
         this._getVisitorComments_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("visit.getVisitorComments",{
               "visitorId":param1,
               "pageNo":param2,
               "pageSize":param3
            });
         }
         return null;
      }
      
      public function getAllVisitorComments(param1:int, param2:int, param3:Function = null) : GetAllVisitorCommentsResponse
      {
         this._getAllVisitorComments_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("visit.getAllVisitorComments",{
               "pageNo":param1,
               "pageSize":param2
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function markCommentAsRead(param1:int, param2:Function = null) : CommandResponse
      {
         this._markCommentAsRead_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("visit.markCommentAsRead",{"id":param1});
         }
         return null;
      }
      
      public function helpIncreaseProduction(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._helpIncreaseProduction_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("visit.helpIncreaseProduction",{
               "fromServer":param1,
               "fromPlayer":param2
            });
         }
         return null;
      }
   }
}

