// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.castle.AvailableBuilingListResponse

package com.evony.common.module.castle
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.AvailableBuildingListBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class AvailableBuilingListResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var builingListArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function AvailableBuilingListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:AvailableBuildingListBean;
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
            if (_arg_2.builingList)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.builingList.length)
                {
                    _local_6 = new AvailableBuildingListBean(_arg_2.builingList[_local_5]);
                    this.builingListArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- AvailableBuilingListResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.builingListArray.length)
            {
                _local_2 = (_local_2 + this.getBuilingList(_local_3).toDebugString((((_arg_1 + "builingList[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:AvailableBuilingListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.builingListArray, _arg_1.builingListArray);
        }

        public function getBuilingList(_arg_1:int):AvailableBuildingListBean
        {
            return (this.builingListArray[_arg_1] as AvailableBuildingListBean);
        }

        public function setBuilingList(_arg_1:AvailableBuildingListBean, _arg_2:int):void
        {
            this.builingListArray[_arg_2] = _arg_1;
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


    }
}//package com.evony.common.module.castle

