package com.evony.common.module.report
{
   import com.evony.common.BaseBean;
   
   public class ShareReportResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var reportId:int;
      
      public var errorMsg:String;
      
      public var reportUrl:String;
      
      public var ok:int;
      
      public function ShareReportResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
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
         if(param2.reportId != null)
         {
            this.reportId = param2.reportId;
         }
         if(param2.reportUrl != null)
         {
            this.reportUrl = param2.reportUrl;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ShareReportResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "reportId = " + this.reportId + "\n") + (param1 + "reportUrl = " + this.reportUrl + "\n");
      }
      
      public function copyTo(param1:ShareReportResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.reportId = this.reportId;
         param1.reportUrl = this.reportUrl;
      }
      
      public function toObject() : Object
      {
         return {
            "ok":this.ok,
            "packageId":this.packageId,
            "msg":this.msg,
            "errorMsg":this.errorMsg,
            "reportId":this.reportId,
            "reportUrl":this.reportUrl
         };
      }
   }
}

