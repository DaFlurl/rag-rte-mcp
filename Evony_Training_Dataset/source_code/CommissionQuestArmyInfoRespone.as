// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.commission.CommissionQuestArmyInfoRespone

package com.evony.common.module.commission
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class CommissionQuestArmyInfoRespone extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var armyBean:ArmyBean;
        public var errorMsg:String;
        public var ok:int;

        public function CommissionQuestArmyInfoRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.armyBean != null)
            {
                this.armyBean = new ArmyBean(_arg_2.armyBean);
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
            var _local_2:* = 0;
            var _local_3:* = "---- CommissionQuestArmyInfoRespone ----\n";
            if (this.armyBean != null)
            {
                _local_3 = (_local_3 + this.armyBean.toDebugString((_arg_1 + "armyBean.")));
            }
            else
            {
                _local_3 = (_local_3 + (_arg_1 + "armyBean = null\n"));
            };
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            return (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function copyTo(_arg_1:CommissionQuestArmyInfoRespone):void
        {
            if (this.armyBean != null)
            {
                this.armyBean.copyTo(_arg_1.armyBean);
            }
            else
            {
                _arg_1.armyBean = null;
            };
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.armyBean = this.armyBean.toObject();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }


    }
}//package com.evony.common.module.commission

