// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.commission.CommissionQuestArmyRespone

package com.evony.common.module.commission
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.CommissionQuestArmyRankBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class CommissionQuestArmyRespone extends BaseBean 
    {

        public var armyRankBeanArray:ArrayCollection = new ArrayCollection();
        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public function CommissionQuestArmyRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:CommissionQuestArmyRankBean;
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
            if (_arg_2.armyRankBean)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.armyRankBean.length)
                {
                    _local_6 = new CommissionQuestArmyRankBean(_arg_2.armyRankBean[_local_5]);
                    this.armyRankBeanArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- CommissionQuestArmyRespone ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.armyRankBeanArray.length)
            {
                _local_2 = (_local_2 + this.getArmyRankBean(_local_3).toDebugString((((_arg_1 + "armyRankBean[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getArmyRankBean(_arg_1:int):CommissionQuestArmyRankBean
        {
            return (this.armyRankBeanArray[_arg_1] as CommissionQuestArmyRankBean);
        }

        public function copyTo(_arg_1:CommissionQuestArmyRespone):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.armyRankBeanArray, _arg_1.armyRankBeanArray);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }

        public function setArmyRankBean(_arg_1:CommissionQuestArmyRankBean, _arg_2:int):void
        {
            this.armyRankBeanArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.commission

