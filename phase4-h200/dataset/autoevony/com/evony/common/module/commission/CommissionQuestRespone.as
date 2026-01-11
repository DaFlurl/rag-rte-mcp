// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.commission.CommissionQuestRespone

package com.evony.common.module.commission
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.CommissionQuestBean;
    import com.evony.common.CommonUtil;
    import mx.collections.*;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class CommissionQuestRespone extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var commissionQuestBeanArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function CommissionQuestRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            var _local_6:* = null;
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
            if (_arg_2.commissionQuestBean)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.commissionQuestBean.length)
                {
                    _local_6 = new CommissionQuestBean(_arg_2.commissionQuestBean[_local_5]);
                    this.commissionQuestBeanArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function setCommissionQuestBean(_arg_1:CommissionQuestBean, _arg_2:int):void
        {
            this.commissionQuestBeanArray[_arg_2] = _arg_1;
        }

        public function copyTo(_arg_1:CommissionQuestRespone):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.commissionQuestBeanArray, _arg_1.commissionQuestBeanArray);
        }

        public function getCommissionQuestBean(_arg_1:int):CommissionQuestBean
        {
            return (this.commissionQuestBeanArray[_arg_1] as CommissionQuestBean);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- CommissionQuestRespone ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = 0;
            while (_local_2 < this.commissionQuestBeanArray.length)
            {
                _local_3 = (_local_3 + this.getCommissionQuestBean(_local_2).toDebugString((((_arg_1 + "commissionQuestBean[") + _local_2) + "].")));
                _local_2++;
            };
            return (_local_3);
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }


    }
}//package com.evony.common.module.commission

