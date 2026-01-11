package com.evony.common.module.field
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.MapCastleBean;
   
   public class OtherFieldInfoResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var bean:MapCastleBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function OtherFieldInfoResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.bean != null)
         {
            this.bean = new MapCastleBean(param2.bean);
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
         return "---- OtherFieldInfoResponse ----\n" + (this.bean != null ? this.bean.toDebugString(param1 + "bean.") : param1 + "bean = null\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:OtherFieldInfoResponse) : void
      {
         if(this.bean != null)
         {
            this.bean.copyTo(param1.bean);
         }
         else
         {
            param1.bean = null;
         }
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         return {
            "bean":this.bean.toObject(),
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
   }
}

