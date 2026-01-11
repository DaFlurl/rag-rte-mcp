package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class QuestFinished extends BaseBean
   {
      
      public var finishedQuest:int;
      
      public function QuestFinished(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.finishedQuest != null)
         {
            this.finishedQuest = param2.finishedQuest;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- QuestFinished ----\n" + (param1 + "finishedQuest = " + this.finishedQuest + "\n");
      }
      
      public function toObject() : Object
      {
         return {"finishedQuest":this.finishedQuest};
      }
      
      public function copyTo(param1:QuestFinished) : void
      {
         param1.finishedQuest = this.finishedQuest;
      }
   }
}

