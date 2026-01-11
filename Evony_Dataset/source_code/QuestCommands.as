package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.quest.EffortListResponse;
   import com.evony.common.module.quest.QuestListResponse;
   import com.evony.common.module.quest.QuestRewardRespone;
   import com.evony.common.module.quest.QuestTypeResponse;
   
   public class QuestCommands
   {
      public var _award_callback:Function;
      
      public var _getAwardItems_callback:Function;
      
      public var _donate_callback:Function;
      
      public var _AllowRegister_callback:Function;
      
      public var _accept_callback:Function;
      
      public var _awardPacket_callback:Function;
      
      public var _getQuestType_callback:Function;
      
      public var _getEffortList_callback:Function;
      
      public var _getEffortListByTargeTypeid_callback:Function;
      
      private var sender:Sender;
      
      public var _getQuestList_callback:Function;
      
      public var _abandon_callback:Function;
      
      public function QuestCommands()
      {
         super();
      }
      
      public function abandon(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._abandon_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.abandon",{
               "questid":param1,
               "castleid":param2
            });
         }
         return null;
      }
      
      public function awardPacket(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._awardPacket_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.awardPacket",{
               "castleId":param1,
               "questId":param2,
               "key":param3
            });
         }
         return null;
      }
      
      public function AllowRegister(param1:Function = null) : CommandResponse
      {
         this._AllowRegister_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.AllowRegister",{});
         }
         return null;
      }
      
      public function accept(param1:int, param2:int, param3:Function = null) : QuestListResponse
      {
         this._accept_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.accept",{
               "ncpid":param1,
               "castleid":param2
            });
         }
         return null;
      }
      
      public function getQuestType(param1:int, param2:int, param3:Function = null) : QuestTypeResponse
      {
         this._getQuestType_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.getQuestType",{
               "castleId":param1,
               "type":param2
            });
         }
         return null;
      }
      
      public function getAwardItems(param1:int, param2:Function = null) : QuestRewardRespone
      {
         this._getAwardItems_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.getAwardItems",{"questId":param1});
         }
         return null;
      }
      
      public function getEffortList(param1:int, param2:Function = null) : EffortListResponse
      {
         this._getEffortList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.getEffortList",{"castleId":param1});
         }
         return null;
      }
      
      public function getEffortListByTargeTypeid(param1:int, param2:int, param3:Function = null) : QuestListResponse
      {
         this._getEffortListByTargeTypeid_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.getEffortListByTargeTypeid",{
               "castleId":param1,
               "TargeTypeid":param2
            });
         }
         return null;
      }
      
      public function donate(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._donate_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.donate",{
               "questid":param1,
               "castleid":param2
            });
         }
         return null;
      }
      
      public function getQuestList(param1:int, param2:int, param3:Function = null) : QuestListResponse
      {
         this._getQuestList_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.getQuestList",{
               "castleId":param1,
               "typeId":param2
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function award(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._award_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("quest.award",{
               "castleId":param1,
               "questId":param2
            });
         }
         return null;
      }
   }
}

