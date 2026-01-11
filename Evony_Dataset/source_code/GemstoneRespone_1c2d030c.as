// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.gemstone.GemstoneRespone

package com.evony.common.module.gemstone
{
    import com.evony.common.BaseBean;

    public class GemstoneRespone extends BaseBean 
    {

        public var errorMsg:String;
        public var msg:String;
        public var packageId:Number;
        public var enhancedstarlv:int;
        public var ok:int;
        public var equipmenttechid:int;

        public function GemstoneRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.enhancedstarlv != null)
            {
                this.enhancedstarlv = _arg_2.enhancedstarlv;
            };
            if (_arg_2.equipmenttechid != null)
            {
                this.equipmenttechid = _arg_2.equipmenttechid;
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
            return (((((("---- GemstoneRespone ----\n" + (((_arg_1 + "enhancedstarlv = ") + this.enhancedstarlv) + "\n")) + (((_arg_1 + "equipmenttechid = ") + this.equipmenttechid) + "\n")) + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function copyTo(_arg_1:GemstoneRespone):void
        {
            _arg_1.enhancedstarlv = this.enhancedstarlv;
            _arg_1.equipmenttechid = this.equipmenttechid;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        public function toObject():Object
        {
            return ({
                "enhancedstarlv":this.enhancedstarlv,
                "equipmenttechid":this.equipmenttechid,
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId
            });
        }


    }
}//package com.evony.common.module.gemstone

