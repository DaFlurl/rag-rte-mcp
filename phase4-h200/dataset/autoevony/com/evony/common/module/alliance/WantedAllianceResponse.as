// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.WantedAllianceResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;

    public class WantedAllianceResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var allianceName:String;
        public var errorMsg:String;
        public var ok:int;

        public function WantedAllianceResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.allianceName != null)
            {
                this.allianceName = _arg_2.allianceName;
            };
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
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((((("---- WantedAllianceResponse ----\n" + (((_arg_1 + "allianceName = ") + this.allianceName) + "\n")) + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function copyTo(_arg_1:WantedAllianceResponse):void
        {
            _arg_1.allianceName = this.allianceName;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        public function toObject():Object
        {
            return ({
                "allianceName":this.allianceName,
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId
            });
        }


    }
}//package com.evony.common.module.alliance

