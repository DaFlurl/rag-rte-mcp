// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceInviteOnClientBeanResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.AllianceAddPlayerByLeaderInfoBean;
    import com.evony.common.CommonUtil;

    public class AllianceInviteOnClientBeanResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var allianceAddPlayerByLeaderInfoBeanListArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function AllianceInviteOnClientBeanResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:AllianceAddPlayerByLeaderInfoBean;
            var _local_6:int;
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
            if (_arg_2.allianceAddPlayerByLeaderInfoBeanList)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.allianceAddPlayerByLeaderInfoBeanList.length)
                {
                    _local_5 = new AllianceAddPlayerByLeaderInfoBean(_arg_2.allianceAddPlayerByLeaderInfoBeanList[_local_6]);
                    this.allianceAddPlayerByLeaderInfoBeanListArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function setAllianceAddPlayerByLeaderInfoBeanList(_arg_1:AllianceAddPlayerByLeaderInfoBean, _arg_2:int):void
        {
            this.allianceAddPlayerByLeaderInfoBeanListArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = (((("---- AllianceInviteOnClientBeanResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            var _local_3:int;
            while (_local_3 < this.allianceAddPlayerByLeaderInfoBeanListArray.length)
            {
                _local_2 = (_local_2 + this.getAllianceAddPlayerByLeaderInfoBeanList(_local_3).toDebugString((((_arg_1 + "allianceAddPlayerByLeaderInfoBeanList[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getAllianceAddPlayerByLeaderInfoBeanList(_arg_1:int):AllianceAddPlayerByLeaderInfoBean
        {
            return (this.allianceAddPlayerByLeaderInfoBeanListArray[_arg_1] as AllianceAddPlayerByLeaderInfoBean);
        }

        public function copyTo(_arg_1:AllianceInviteOnClientBeanResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.allianceAddPlayerByLeaderInfoBeanListArray, _arg_1.allianceAddPlayerByLeaderInfoBeanListArray);
        }

        public function toObject():Object
        {
            return ({
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId
            });
        }


    }
}//package com.evony.common.module.alliance

