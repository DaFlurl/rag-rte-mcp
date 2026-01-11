// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.report.ReportListResponse

package com.evony.common.module.report
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ReportBean;
    import com.evony.common.CommonUtil;

    public class ReportListResponse extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var pageNo:int;
        public var totalPage:int;
        public var errorMsg:String;
        public var reportsArray:ArrayCollection = new ArrayCollection();
        public var ok:int;

        public function ReportListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:ReportBean;
            var _local_6:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.ok != null)
            {
                this.ok = _arg_2.ok;
            };
            if (_arg_2.packageId != null)
            {
                this.packageId = _arg_2.packageId;
            };
            if (_arg_2.pageNo != null)
            {
                this.pageNo = _arg_2.pageNo;
            };
            if (_arg_2.totalPage != null)
            {
                this.totalPage = _arg_2.totalPage;
            };
            if (_arg_2.reports)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.reports.length)
                {
                    _local_5 = new ReportBean(_arg_2.reports[_local_6]);
                    this.reportsArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function toObject():Object
        {
            return ({
                "ok":this.ok,
                "packageId":this.packageId,
                "msg":this.msg,
                "errorMsg":this.errorMsg,
                "pageNo":this.pageNo,
                "totalPage":this.totalPage,
                "reportsArray":this.reportsArray
            });
        }

        public function getReports(_arg_1:int):ReportBean
        {
            return (this.reportsArray[_arg_1] as ReportBean);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = (((((("---- ReportListResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + (((_arg_1 + "pageNo = ") + this.pageNo) + "\n")) + (((_arg_1 + "totalPage = ") + this.totalPage) + "\n"));
            var _local_3:int;
            while (_local_3 < this.reportsArray.length)
            {
                _local_2 = (_local_2 + this.getReports(_local_3).toDebugString((((_arg_1 + "reportsArray[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:ReportListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.pageNo = this.pageNo;
            _arg_1.totalPage = this.totalPage;
            CommonUtil.arrayCopy(this.reportsArray, _arg_1.reportsArray);
        }

        public function setReports(_arg_1:ReportBean, _arg_2:int):void
        {
            this.reportsArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.report

