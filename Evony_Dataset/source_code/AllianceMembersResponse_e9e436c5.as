// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceMembersResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.CommonUtil;

    public class AllianceMembersResponse extends BaseBean 
    {

        public var membersArray:ArrayCollection = new ArrayCollection();
        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public function AllianceMembersResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:PlayerInfoBean;
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
            if (_arg_2.members)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.members.length)
                {
                    _local_5 = new PlayerInfoBean(_arg_2.members[_local_6]);
                    this.membersArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function getMembers(_arg_1:int):PlayerInfoBean
        {
            return (this.membersArray[_arg_1] as PlayerInfoBean);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = (((("---- AllianceMembersResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            var _local_3:int;
            while (_local_3 < this.membersArray.length)
            {
                _local_2 = (_local_2 + this.getMembers(_local_3).toDebugString((((_arg_1 + "membersArray[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:AllianceMembersResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.membersArray, _arg_1.membersArray);
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

        public function setMembers(_arg_1:PlayerInfoBean, _arg_2:int):void
        {
            this.membersArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.alliance

