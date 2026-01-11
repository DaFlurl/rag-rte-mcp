package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.QuestBean;
   
   public class QuestCompleteTipResponse extends BaseBean
   {
      public var quest:QuestBean;
      
      public var name:String;
      
      public var questId:int;
      
      public function QuestCompleteTipResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.name != null)
         {
            this.name = param2.name;
         }
         if(param2.quest != null)
         {
            this.quest = new QuestBean(param2.quest);
         }
         if(param2.questId != null)
         {
            this.questId = param2.questId;
         }
      }
      
      public function copyTo(param1:QuestCompleteTipResponse) : void
      {
         param1.name = this.name;
         if(this.quest != null)
         {
            this.quest.copyTo(param1.quest);
         }
         else
         {
            param1.quest = null;
         }
         param1.questId = this.questId;
      }
      
      public function toObject() : Object
      {
         return {
            "name":this.name,
            "quest":this.quest.toObject(),
            "questId":this.questId
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- QuestCompleteTipResponse ----\n" + (param1 + "name = " + this.name + "\n") + (this.quest != null ? this.quest.toDebugString(param1 + "quest.") : param1 + "quest = null\n") + (param1 + "questId = " + this.questId + "\n");
      }
   }
}

