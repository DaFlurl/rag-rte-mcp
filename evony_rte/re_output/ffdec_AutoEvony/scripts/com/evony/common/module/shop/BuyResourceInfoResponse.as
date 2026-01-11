package com.evony.common.module.shop
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.BuyResourceBean;
   
   public class BuyResourceInfoResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var buyResourceBean:BuyResourceBean;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function BuyResourceInfoResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.buyResourceBean != null)
         {
            this.buyResourceBean = new BuyResourceBean(param2.buyResourceBean);
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
         return "---- BuyResourceInfoResponse ----\n" + (this.buyResourceBean != null ? this.buyResourceBean.toDebugString(param1 + "buyResourceBean.") : param1 + "buyResourceBean = null\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:BuyResourceInfoResponse) : void
      {
         if(this.buyResourceBean != null)
         {
            this.buyResourceBean.copyTo(param1.buyResourceBean);
         }
         else
         {
            param1.buyResourceBean = null;
         }
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         return {
            "buyResourceBean":this.buyResourceBean.toObject(),
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
   }
}

