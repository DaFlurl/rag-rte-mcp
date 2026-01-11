package com.evony.common.module.colony
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.TroopBean;
   
   public class ColonialDeployResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var reduceCoolDown:Number;
      
      public var errorMsg:String;
      
      public var troopBean:TroopBean;
      
      public var ok:int;
      
      public function ColonialDeployResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
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
         if(param2.ok != null)
         {
            this.ok = param2.ok;
         }
         if(param2.packageId != null)
         {
            this.packageId = param2.packageId;
         }
         if(param2.reduceCoolDown != null)
         {
            this.reduceCoolDown = param2.reduceCoolDown;
         }
         if(param2.troopBean != null)
         {
            this.troopBean = new TroopBean(param2.troopBean);
         }
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "reduceCoolDown":this.reduceCoolDown,
            "troopBean":this.troopBean.toObject()
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ColonialDeployResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "reduceCoolDown = " + this.reduceCoolDown + "\n") + (this.troopBean != null ? this.troopBean.toDebugString(param1 + "troopBean.") : param1 + "troopBean = null\n");
      }
      
      public function copyTo(param1:ColonialDeployResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.reduceCoolDown = this.reduceCoolDown;
         if(this.troopBean != null)
         {
            this.troopBean.copyTo(param1.troopBean);
         }
         else
         {
            param1.troopBean = null;
         }
      }
   }
}

