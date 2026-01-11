// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.tech.ResearchResponse

package com.evony.common.module.tech
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.AvailableResearchListBean;

    public class ResearchResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var tech:AvailableResearchListBean;
        public var errorMsg:String;
        public var ok:int;

        public function ResearchResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
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
            if (_arg_2.tech != null)
            {
                this.tech = new AvailableResearchListBean(_arg_2.tech);
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((((("---- ResearchResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + ((this.tech != null) ? this.tech.toDebugString((_arg_1 + "tech.")) : (_arg_1 + "tech = null\n")));
        }

        public function copyTo(_arg_1:ResearchResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (this.tech != null)
            {
                this.tech.copyTo(_arg_1.tech);
            }
            else
            {
                _arg_1.tech = null;
            };
        }

        public function toObject():Object
        {
            return ({
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId,
                "tech":this.tech.toObject()
            });
        }


    }
}//package com.evony.common.module.tech

