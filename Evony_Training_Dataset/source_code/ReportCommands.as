// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ReportCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.report.ReportListResponse;
    import com.evony.common.module.report.ReportResponse;
    import com.evony.common.module.CommandResponse;
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


        public function receiveReportList(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):ReportListResponse
        {
            this._receiveReportList_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("report.receiveReportList", {
                    "pageNo":_arg_1,
                    "pageSize":_arg_2,
                    "reportType":_arg_3
                });
            };
            return (null);
        }

        public function readOverReport(_arg_1:String, _arg_2:Function=null):ReportResponse
        {
            this._readOverReport_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("report.readOverReport", {"reportIds":_arg_1});
            };
            return (null);
        }

        public function deleteAllReports(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._deleteAllReports_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("report.deleteAllReports", {"reportType":_arg_1});
            };
            return (null);
        }

        public function markAsRead(_arg_1:int, _arg_2:Function=null):ReportResponse
        {
            this._markAsRead_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("report.markAsRead", {"reportId":_arg_1});
            };
            return (null);
        }

        public function shareReport(_arg_1:int, _arg_2:Function=null):ShareReportResponse
        {
            this._shareReport_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("report.shareReport", {"reportId":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function deleteReport(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._deleteReport_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("report.deleteReport", {"idStr":_arg_1});
            };
            return (null);
        }


    }
}//package com.evony.client.action

