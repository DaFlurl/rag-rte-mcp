package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class NewFinishedQuest extends BaseBean
   {
      public function NewFinishedQuest(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
      }
      
      public function copyTo(param1:NewFinishedQuest) : void
      {
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- NewFinishedQuest ----\n";
      }
      
      public function toObject() : Object
      {
         return {};
      }
   }
}

