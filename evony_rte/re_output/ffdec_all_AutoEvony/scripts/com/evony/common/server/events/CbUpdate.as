package com.evony.common.server.events
{
   import com.evony.common.*;
   
   public class CbUpdate extends BaseBean
   {
      
      public var tp:int;
      
      public var text:String;
      
      public function CbUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.text != null)
         {
            this.text = param2.text;
         }
         if(param2.tp != null)
         {
            this.tp = param2.tp;
         }
      }
      
      public function copyTo(param1:CbUpdate) : void
      {
         param1.text = this.text;
         param1.tp = this.tp;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- CbUpdate ----\n";
         _loc3_ += param1 + "text = " + this.text + "\n";
         return _loc3_ + (param1 + "tp = " + this.tp + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.text = this.text;
         _loc1_.tp = this.tp;
         return _loc1_;
      }
   }
}

