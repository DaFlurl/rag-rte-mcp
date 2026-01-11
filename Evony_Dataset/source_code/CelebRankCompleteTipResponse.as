package com.evony.common.server.events
{
   import com.evony.common.*;
   
   public class CelebRankCompleteTipResponse extends BaseBean
   {
      public var name:String;
      
      public var rank:int;
      
      public function CelebRankCompleteTipResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.name != null)
         {
            this.name = param2.name;
         }
         if(param2.rank != null)
         {
            this.rank = param2.rank;
         }
      }
      
      public function copyTo(param1:CelebRankCompleteTipResponse) : void
      {
         param1.name = this.name;
         param1.rank = this.rank;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- CelebRankCompleteTipResponse ----\n";
         _loc3_ += param1 + "name = " + this.name + "\n";
         return _loc3_ + (param1 + "rank = " + this.rank + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.name = this.name;
         _loc1_.rank = this.rank;
         return _loc1_;
      }
   }
}

