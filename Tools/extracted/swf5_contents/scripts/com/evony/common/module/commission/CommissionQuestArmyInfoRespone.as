package com.evony.common.module.commission
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   
   public class CommissionQuestArmyInfoRespone extends BaseBean
   {
      public var msg:String;
      
      public var packageId:Number;
      
      public var armyBean:ArmyBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function CommissionQuestArmyInfoRespone(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.armyBean != null)
         {
            this.armyBean = new ArmyBean(param2.armyBean);
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
         var _loc3_:* = "---- CommissionQuestArmyInfoRespone ----\n";
         if(this.armyBean != null)
         {
            _loc3_ += this.armyBean.toDebugString(param1 + "armyBean.");
         }
         else
         {
            _loc3_ += param1 + "armyBean = null\n";
         }
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         return _loc3_ + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:CommissionQuestArmyInfoRespone) : void
      {
         if(this.armyBean != null)
         {
            this.armyBean.copyTo(param1.armyBean);
         }
         else
         {
            param1.armyBean = null;
         }
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.armyBean = this.armyBean.toObject();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
   }
}

