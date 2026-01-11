// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceUserAddResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.AllianceAddPlayerByUserInfoBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class AllianceUserAddResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var allianceAddPlayerByUserInfoBeanListArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function AllianceUserAddResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:AllianceAddPlayerByUserInfoBean;
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
            if (_arg_2.allianceAddPlayerByUserInfoBeanList)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.allianceAddPlayerByUserInfoBeanList.length)
                {
                    _local_6 = new AllianceAddPlayerByUserInfoBean(_arg_2.allianceAddPlayerByUserInfoBeanList[_local_5]);
                    this.allianceAddPlayerByUserInfoBeanListArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function setAllianceAddPlayerByUserInfoBeanList(_arg_1:AllianceAddPlayerByUserInfoBean, _arg_2:int):void
        {
            this.allianceAddPlayerByUserInfoBeanListArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- AllianceUserAddResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.allianceAddPlayerByUserInfoBeanListArray.length)
            {
                _local_2 = (_local_2 + this.getAllianceAddPlayerByUserInfoBeanList(_local_3).toDebugString((((_arg_1 + "allianceAddPlayerByUserInfoBeanList[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
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

        public function copyTo(_arg_1:AllianceUserAddResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.allianceAddPlayerByUserInfoBeanListArray, _arg_1.allianceAddPlayerByUserInfoBeanListArray);
        }

        public function getAllianceAddPlayerByUserInfoBeanList(_arg_1:int):AllianceAddPlayerByUserInfoBean
        {
            return (this.allianceAddPlayerByUserInfoBeanListArray[_arg_1] as AllianceAddPlayerByUserInfoBean);
        }


    }
}//package com.evony.common.module.alliance

