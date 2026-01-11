// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.report.ReportResponse

package com.evony.common.module.report
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.ReportBean;
    import com.evony.common.beans.*;

    public class ReportResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var report:ReportBean;
        public var errorMsg:String;
        public var ok:int;

        public function ReportResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
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
            if (_arg_2.report != null)
            {
                this.report = new ReportBean(_arg_2.report);
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- ReportResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            if (report != null)
            {
                _local_2 = (_local_2 + this.report.toDebugString((_arg_1 + "report.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "report = null\n"));
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:ReportResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (report != null)
            {
                this.report.copyTo(_arg_1.report);
            }
            else
            {
                _arg_1.report = null;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.report = this.report.toObject();
            return (_local_1);
        }


    }
}//package com.evony.common.module.report

