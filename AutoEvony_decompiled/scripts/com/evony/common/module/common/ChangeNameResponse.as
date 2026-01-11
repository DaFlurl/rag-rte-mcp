package com.evony.common.module.common
{
   import com.evony.common.*;
   
   public class ChangeNameResponse extends BaseBean
   {
      
      public var errorMsg:String;
      
      public var nowName:String;
      
      public var msg:String;
      
      public var changeType:int;
      
      public var packageId:Number;
      
      public var ok:int;
      
      public function ChangeNameResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.changeType != null)
         {
            this.changeType = param2.changeType;
         }
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.nowName != null)
         {
            this.nowName = param2.nowName;
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
      
      public function copyTo(param1:ChangeNameResponse) : void
      {
         param1.changeType = this.changeType;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.nowName = this.nowName;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- ChangeNameResponse ----\n";
         _loc3_ += param1 + "changeType = " + this.changeType + "\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "nowName = " + this.nowName + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         return _loc3_ + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.changeType = this.changeType;
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.nowName = this.nowName;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
   }
}

