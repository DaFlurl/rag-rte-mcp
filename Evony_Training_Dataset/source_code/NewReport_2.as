package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class NewReport extends BaseBean
   {
      public var other_count:int;
      
      public var scout_cout:int;
      
      public var army_count:int;
      
      public var count:int;
      
      public var trade_count:int;
      
      public function NewReport(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.army_count != null)
         {
            this.army_count = param2.army_count;
         }
         if(param2.count != null)
         {
            this.count = param2.count;
         }
         if(param2.other_count != null)
         {
            this.other_count = param2.other_count;
         }
         if(param2.scout_cout != null)
         {
            this.scout_cout = param2.scout_cout;
         }
         if(param2.trade_count != null)
         {
            this.trade_count = param2.trade_count;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "army_count":this.army_count,
            "count":this.count,
            "other_count":this.other_count,
            "scout_cout":this.scout_cout,
            "trade_count":this.trade_count
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- NewReport ----\n" + (param1 + "army_count = " + this.army_count + "\n") + (param1 + "count = " + this.count + "\n") + (param1 + "other_count = " + this.other_count + "\n") + (param1 + "scout_cout = " + this.scout_cout + "\n") + (param1 + "trade_count = " + this.trade_count + "\n");
      }
      
      public function copyTo(param1:NewReport) : void
      {
         param1.army_count = this.army_count;
         param1.count = this.count;
         param1.other_count = this.other_count;
         param1.scout_cout = this.scout_cout;
         param1.trade_count = this.trade_count;
      }
   }
}

