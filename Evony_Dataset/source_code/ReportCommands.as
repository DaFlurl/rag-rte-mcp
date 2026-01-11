package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.report.ReportListResponse;
   import com.evony.common.module.report.ReportResponse;
   import com.evony.common.module.report.ShareReportResponse;
   
   public class ReportCommands
   {
      private var sender:Sender;
      
      public var _deleteReport_callback:Function;
      
      public var _readOverReport_callback:Function;
      
      public var _receiveReportList_callback:Function;
      
      public var _markAsRead_callback:Function;
      
      public var _shareReport_callback:Function;
      
      public var _deleteAllReports_callback:Function;
      
      public function ReportCommands()
      {
         super();
      }
      
      public function receiveReportList(param1:int, param2:int, param3:int, param4:Function = null) : ReportListResponse
      {
         this._receiveReportList_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("report.receiveReportList",{
               "pageNo":param1,
               "pageSize":param2,
               "reportType":param3
            });
         }
         return null;
      }
      
      public function readOverReport(param1:String, param2:Function = null) : ReportResponse
      {
         this._readOverReport_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("report.readOverReport",{"reportIds":param1});
         }
         return null;
      }
      
      public function deleteAllReports(param1:int, param2:Function = null) : CommandResponse
      {
         this._deleteAllReports_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("report.deleteAllReports",{"reportType":param1});
         }
         return null;
      }
      
      public function markAsRead(param1:int, param2:Function = null) : ReportResponse
      {
         this._markAsRead_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("report.markAsRead",{"reportId":param1});
         }
         return null;
      }
      
      public function shareReport(param1:int, param2:Function = null) : ShareReportResponse
      {
         this._shareReport_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("report.shareReport",{"reportId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function deleteReport(param1:String, param2:Function = null) : CommandResponse
      {
         this._deleteReport_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("report.deleteReport",{"idStr":param1});
         }
         return null;
      }
   }
}

