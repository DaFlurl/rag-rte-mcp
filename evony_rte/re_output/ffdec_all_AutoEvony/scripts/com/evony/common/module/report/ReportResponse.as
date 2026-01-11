package com.evony.common.module.report
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.ReportBean;
   
   public class ReportResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var report:ReportBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function ReportResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
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
         if(param2.report != null)
         {
            this.report = new ReportBean(param2.report);
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ReportResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (this.report != null ? this.report.toDebugString(param1 + "report.") : param1 + "report = null\n");
      }
      
      public function copyTo(param1:ReportResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         if(this.report != null)
         {
            this.report.copyTo(param1.report);
         }
         else
         {
            param1.report = null;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "ok":this.ok,
            "packageId":this.packageId,
            "msg":this.msg,
            "errorMsg":this.errorMsg,
            "report":this.report.toObject()
         };
      }
   }
}

