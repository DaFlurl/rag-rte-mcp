package com.evony.common.module.colony
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.CastleBean;
   
   public class OverviewColonyCastleRespone extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var castleBean:CastleBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function OverviewColonyCastleRespone(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleBean != null)
         {
            this.castleBean = new CastleBean(param2.castleBean);
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
         return "---- OverviewColonyCastleRespone ----\n" + (this.castleBean != null ? this.castleBean.toDebugString(param1 + "castleBean.") : param1 + "castleBean = null\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:OverviewColonyCastleRespone) : void
      {
         if(this.castleBean != null)
         {
            this.castleBean.copyTo(param1.castleBean);
         }
         else
         {
            param1.castleBean = null;
         }
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         return {
            "castleBean":this.castleBean.toObject(),
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
   }
}

