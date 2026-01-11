package com.evony.common.module.common
{
   import com.evony.common.*;
   
   public class GetPackageNumberResponse extends BaseBean
   {
      public var msg:String;
      
      public var packageId:Number;
      
      public var number:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function GetPackageNumberResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.number != null)
         {
            this.number = param2.number;
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
      
      public function copyTo(param1:GetPackageNumberResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.number = this.number;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- GetPackageNumberResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "number = " + this.number + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         return _loc2_ + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.number = this.number;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
   }
}

