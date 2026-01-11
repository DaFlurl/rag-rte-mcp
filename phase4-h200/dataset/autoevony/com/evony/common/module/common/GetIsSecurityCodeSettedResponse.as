// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.common.GetIsSecurityCodeSettedResponse

package com.evony.common.module.common
{
    import com.evony.common.BaseBean;
    import com.evony.common.*;

    public class GetIsSecurityCodeSettedResponse extends BaseBean 
    {

        public var msg:String;
        public var isSetSecurityCode:Boolean;
        public var packageId:Number;
        public var errorMsg:String;
        public var ok:int;

        public function GetIsSecurityCodeSettedResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.isSetSecurityCode != null)
            {
                this.isSetSecurityCode = _arg_2.isSetSecurityCode;
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

        public function copyTo(_arg_1:GetIsSecurityCodeSettedResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.isSetSecurityCode = this.isSetSecurityCode;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- GetIsSecurityCodeSettedResponse ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "isSetSecurityCode = ") + this.isSetSecurityCode) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            return (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.isSetSecurityCode = this.isSetSecurityCode;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }


    }
}//package com.evony.common.module.common

