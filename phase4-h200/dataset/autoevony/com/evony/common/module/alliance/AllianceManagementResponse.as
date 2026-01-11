// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceManagementResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;

    public class AllianceManagementResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var waitIntoAllianceName:String;
        public var errorMsg:String;
        public var ok:int;

        public function AllianceManagementResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
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
            if (_arg_2.waitIntoAllianceName != null)
            {
                this.waitIntoAllianceName = _arg_2.waitIntoAllianceName;
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((((("---- AllianceManagementResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + (((_arg_1 + "waitIntoAllianceName = ") + this.waitIntoAllianceName) + "\n"));
        }

        public function toObject():Object
        {
            return ({
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId,
                "waitIntoAllianceName":this.waitIntoAllianceName
            });
        }

        public function copyTo(_arg_1:AllianceManagementResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.waitIntoAllianceName = this.waitIntoAllianceName;
        }


    }
}//package com.evony.common.module.alliance

