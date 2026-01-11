package com.evony.common.module.gamemaster
{
   import com.evony.common.*;
   
   public class CreateHeroResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var heroId:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function CreateHeroResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.heroId != null)
         {
            this.heroId = param2.heroId;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.ok != null)
         {
            this.ok = param2.ok;
         }
         if(param2.packageId != null)
         {
            this.packageId = param2.packageId;
         }
      }
      
      public function copyTo(param1:CreateHeroResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.heroId = this.heroId;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- CreateHeroResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "heroId = " + this.heroId + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         return _loc3_ + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.heroId = this.heroId;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
   }
}

