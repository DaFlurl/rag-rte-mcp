// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.city.StoreListResponse

package com.evony.common.module.city
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.StoreBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class StoreListResponse extends BaseBean 
    {

        public var packageId:Number;
        public var ok:int;
        public var msg:String;
        public var totalCap:int;
        public var storeBeansArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;

        public function StoreListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:StoreBean;
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
            if (_arg_2.totalCap != null)
            {
                this.totalCap = _arg_2.totalCap;
            };
            if (_arg_2.storeBeans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.storeBeans.length)
                {
                    _local_6 = new StoreBean(_arg_2.storeBeans[_local_5]);
                    this.storeBeansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function setStoreBeans(_arg_1:StoreBean, _arg_2:int):void
        {
            this.storeBeansArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- StoreListResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "totalCap = ") + this.totalCap) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.storeBeansArray.length)
            {
                _local_2 = (_local_2 + this.getStoreBeans(_local_3).toDebugString((((_arg_1 + "storeBeans[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:StoreListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.totalCap = this.totalCap;
            CommonUtil.arrayCopy(this.storeBeansArray, _arg_1.storeBeansArray);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.totalCap = this.totalCap;
            return (_local_1);
        }

        public function getStoreBeans(_arg_1:int):StoreBean
        {
            return (this.storeBeansArray[_arg_1] as StoreBean);
        }


    }
}//package com.evony.common.module.city

