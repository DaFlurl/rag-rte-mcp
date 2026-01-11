// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ReportCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.report.ReportResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.report.ReportListResponse;
    import com.evony.common.module.report.ShareReportResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class ReportCommands 
    {

        public var _deleteReport_callback:Function;
        public var _readOverReport_callback:Function;
        public var _receiveReportList_callback:Function;
        public var _markAsRead_callback:Function;
        private var sender:Sender;
        public var _shareReport_callback:Function;
        public var _deleteAllReports_callback:Function;


        public function markAsRead(_arg_1:int, _arg_2:Function=null):ReportResponse
        {
            this._markAsRead_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.reportId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("report.markAsRead", _local_3);
            };
            return (null);
        }

        public function readOverReport(_arg_1:String, _arg_2:Function=null):ReportResponse
        {
            this._readOverReport_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.reportIds = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("report.readOverReport", _local_3);
            };
            return (null);
        }

        public function deleteAllReports(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._deleteAllReports_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.reportType = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("report.deleteAllReports", _local_3);
            };
            return (null);
        }

        public function receiveReportList(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):ReportListResponse
        {
            this._receiveReportList_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.pageNo = _arg_1;
            _local_5.pageSize = _arg_2;
            _local_5.reportType = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("report.receiveReportList", _local_5);
            };
            return (null);
        }

        public function shareReport(_arg_1:int, _arg_2:Function=null):ShareReportResponse
        {
            this._shareReport_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.reportId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("report.shareReport", _local_3);
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
            var _local_3:Object = new Object();
            _local_3.idStr = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("report.deleteReport", _local_3);
            };
            return (null);
        }


    }
}//package com.evony.client.action

