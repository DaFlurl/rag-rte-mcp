package com.evony.common.module.common
{
   import com.evony.common.*;
   
   public class GetItemDefResponse extends BaseBean
   {
      public var msg:String;
      
      public var packageId:Number;
      
      public var itemXml:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function GetItemDefResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.itemXml != null)
         {
            this.itemXml = param2.itemXml;
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
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- GetItemDefResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "itemXml = " + this.itemXml + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         return _loc3_ + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:GetItemDefResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.itemXml = this.itemXml;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.itemXml = this.itemXml;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
   }
}

