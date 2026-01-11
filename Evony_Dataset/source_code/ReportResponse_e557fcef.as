// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.report.ReportResponse

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

        public function ReportResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
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
            return ((((("---- ReportResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + ((this.report != null) ? this.report.toDebugString((_arg_1 + "report.")) : (_arg_1 + "report = null\n")));
        }

        public function copyTo(_arg_1:ReportResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (this.report != null)
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
            return ({
                "ok":this.ok,
                "packageId":this.packageId,
                "msg":this.msg,
                "errorMsg":this.errorMsg,
                "report":this.report.toObject()
            });
        }


    }
}//package com.evony.common.module.report

