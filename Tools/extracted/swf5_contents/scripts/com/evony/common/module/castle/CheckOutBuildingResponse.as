package com.evony.common.module.castle
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   
   public class CheckOutBuildingResponse extends BaseBean
   {
      public var desConditionBean:ConditionBean;
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var conditionBean:ConditionBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function CheckOutBuildingResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.conditionBean != null)
         {
            this.conditionBean = new ConditionBean(param2.conditionBean);
         }
         if(param2.desConditionBean != null)
         {
            this.desConditionBean = new ConditionBean(param2.desConditionBean);
         }
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
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
         var _loc3_:* = "---- CheckOutBuildingResponse ----\n";
         if(this.conditionBean != null)
         {
            _loc3_ += this.conditionBean.toDebugString(param1 + "conditionBean.");
         }
         else
         {
            _loc3_ += param1 + "conditionBean = null\n";
         }
         if(this.desConditionBean != null)
         {
            _loc3_ += this.desConditionBean.toDebugString(param1 + "desConditionBean.");
         }
         else
         {
            _loc3_ += param1 + "desConditionBean = null\n";
         }
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         return _loc3_ + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:CheckOutBuildingResponse) : void
      {
         if(this.conditionBean != null)
         {
            this.conditionBean.copyTo(param1.conditionBean);
         }
         else
         {
            param1.conditionBean = null;
         }
         if(this.desConditionBean != null)
         {
            this.desConditionBean.copyTo(param1.desConditionBean);
         }
         else
         {
            param1.desConditionBean = null;
         }
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.conditionBean = this.conditionBean.toObject();
         _loc1_.desConditionBean = this.desConditionBean.toObject();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
   }
}

