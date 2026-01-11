// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.castle.CheckOutBuildingResponse

package com.evony.common.module.castle
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.ConditionBean;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class CheckOutBuildingResponse extends BaseBean 
    {

        public var desConditionBean:ConditionBean;
        public var msg:String;
        public var packageId:Number;
        public var conditionBean:ConditionBean;
        public var errorMsg:String;
        public var ok:int;

        public function CheckOutBuildingResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.conditionBean != null)
            {
                this.conditionBean = new ConditionBean(_arg_2.conditionBean);
            };
            if (_arg_2.desConditionBean != null)
            {
                this.desConditionBean = new ConditionBean(_arg_2.desConditionBean);
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
            var _local_3:* = "---- CheckOutBuildingResponse ----\n";
            if (this.conditionBean != null)
            {
                _local_3 = (_local_3 + this.conditionBean.toDebugString((_arg_1 + "conditionBean.")));
            }
            else
            {
                _local_3 = (_local_3 + (_arg_1 + "conditionBean = null\n"));
            };
            if (this.desConditionBean != null)
            {
                _local_3 = (_local_3 + this.desConditionBean.toDebugString((_arg_1 + "desConditionBean.")));
            }
            else
            {
                _local_3 = (_local_3 + (_arg_1 + "desConditionBean = null\n"));
            };
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            return (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function copyTo(_arg_1:CheckOutBuildingResponse):void
        {
            if (this.conditionBean != null)
            {
                this.conditionBean.copyTo(_arg_1.conditionBean);
            }
            else
            {
                _arg_1.conditionBean = null;
            };
            if (this.desConditionBean != null)
            {
                this.desConditionBean.copyTo(_arg_1.desConditionBean);
            }
            else
            {
                _arg_1.desConditionBean = null;
            };
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.conditionBean = this.conditionBean.toObject();
            _local_1.desConditionBean = this.desConditionBean.toObject();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }


    }
}//package com.evony.common.module.castle

