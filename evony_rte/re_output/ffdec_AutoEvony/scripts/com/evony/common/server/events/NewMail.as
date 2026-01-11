package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class NewMail extends BaseBean
   {
      
      public var count_inbox:int;
      
      public var count:int;
      
      public var count_system:int;
      
      public function NewMail(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.count != null)
         {
            this.count = param2.count;
         }
         if(param2.count_inbox != null)
         {
            this.count_inbox = param2.count_inbox;
         }
         if(param2.count_system != null)
         {
            this.count_system = param2.count_system;
         }
      }
      
      public function copyTo(param1:NewMail) : void
      {
         param1.count = this.count;
         param1.count_inbox = this.count_inbox;
         param1.count_system = this.count_system;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- NewMail ----\n" + (param1 + "count = " + this.count + "\n") + (param1 + "count_inbox = " + this.count_inbox + "\n") + (param1 + "count_system = " + this.count_system + "\n");
      }
      
      public function toObject() : Object
      {
         return {
            "count":this.count,
            "count_inbox":this.count_inbox,
            "count_system":this.count_system
         };
      }
   }
}

