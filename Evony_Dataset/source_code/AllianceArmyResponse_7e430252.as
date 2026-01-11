// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceArmyResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.BettleResultBean;

    public class AllianceArmyResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var armyInfoBean:BettleResultBean;
        public var ok:int;

        public function AllianceArmyResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.armyInfoBean != null)
            {
                this.armyInfoBean = new BettleResultBean(_arg_2.armyInfoBean);
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
            var _local_2:* = "---- AllianceArmyResponse ----\n";
            if (this.armyInfoBean != null)
            {
                _local_2 = (_local_2 + this.armyInfoBean.toDebugString((_arg_1 + "armyInfoBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "armyInfoBean = null\n"));
            };
            return (_local_2 + ((((((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n") + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")));
        }

        public function copyTo(_arg_1:AllianceArmyResponse):void
        {
            if (this.armyInfoBean != null)
            {
                this.armyInfoBean.copyTo(_arg_1.armyInfoBean);
            }
            else
            {
                _arg_1.armyInfoBean = null;
            };
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        public function toObject():Object
        {
            return ({
                "armyInfoBean":this.armyInfoBean.toObject(),
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId
            });
        }


    }
}//package com.evony.common.module.alliance

