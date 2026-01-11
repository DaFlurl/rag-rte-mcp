package com.evony.common.module.alliance
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.BettleResultBean;
   
   public class AllianceArmyResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var armyInfoBean:BettleResultBean;
      
      public var ok:int;
      
      public function AllianceArmyResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.armyInfoBean != null)
         {
            this.armyInfoBean = new BettleResultBean(param2.armyInfoBean);
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
         var _loc2_:String = "---- AllianceArmyResponse ----\n";
         if(this.armyInfoBean != null)
         {
            _loc2_ += this.armyInfoBean.toDebugString(param1 + "armyInfoBean.");
         }
         else
         {
            _loc2_ += param1 + "armyInfoBean = null\n";
         }
         return _loc2_ + (param1 + "errorMsg = " + this.errorMsg + "\n" + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n"));
      }
      
      public function copyTo(param1:AllianceArmyResponse) : void
      {
         if(this.armyInfoBean != null)
         {
            this.armyInfoBean.copyTo(param1.armyInfoBean);
         }
         else
         {
            param1.armyInfoBean = null;
         }
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         return {
            "armyInfoBean":this.armyInfoBean.toObject(),
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
   }
}

