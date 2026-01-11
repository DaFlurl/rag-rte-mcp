// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.colony.OverviewColonyCastleRespone

package com.evony.common.module.colony
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.CastleBean;

    public class OverviewColonyCastleRespone extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var castleBean:CastleBean;
        public var errorMsg:String;
        public var ok:int;

        public function OverviewColonyCastleRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleBean != null)
            {
                this.castleBean = new CastleBean(_arg_2.castleBean);
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
            return ((((("---- OverviewColonyCastleRespone ----\n" + ((this.castleBean != null) ? this.castleBean.toDebugString((_arg_1 + "castleBean.")) : (_arg_1 + "castleBean = null\n"))) + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function copyTo(_arg_1:OverviewColonyCastleRespone):void
        {
            if (this.castleBean != null)
            {
                this.castleBean.copyTo(_arg_1.castleBean);
            }
            else
            {
                _arg_1.castleBean = null;
            };
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        public function toObject():Object
        {
            return ({
                "castleBean":this.castleBean.toObject(),
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId
            });
        }


    }
}//package com.evony.common.module.colony

