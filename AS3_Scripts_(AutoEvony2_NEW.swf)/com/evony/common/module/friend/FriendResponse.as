// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.friend.FriendResponse

package com.evony.common.module.friend
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.CommonUtil;

    public class FriendResponse extends BaseBean 
    {

        public var msg:String;
        public var blockArrArray:ArrayCollection = new ArrayCollection();
        public var packageId:Number;
        public var friendArrArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function FriendResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_6:PlayerInfoBean;
            var _local_7:PlayerInfoBean;
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
            var _local_5:int;
            if (_arg_2.blockArr)
            {
                _local_6 = null;
                _local_5 = 0;
                while (_local_5 < _arg_2.blockArr.length)
                {
                    _local_6 = new PlayerInfoBean(_arg_2.blockArr[_local_5]);
                    this.blockArrArray.addItem(_local_6);
                    _local_5++;
                };
            };
            if (_arg_2.friendArr)
            {
                _local_7 = null;
                _local_5 = 0;
                while (_local_5 < _arg_2.friendArr.length)
                {
                    _local_7 = new PlayerInfoBean(_arg_2.friendArr[_local_5]);
                    this.friendArrArray.addItem(_local_7);
                    _local_5++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- FriendResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            var _local_3:int;
            while (_local_3 < this.blockArrArray.length)
            {
                _local_2 = (_local_2 + this.getBlockArr(_local_3).toDebugString((((_arg_1 + "blockArr[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.friendArrArray.length)
            {
                _local_2 = (_local_2 + this.getFriendArr(_local_3).toDebugString((((_arg_1 + "friendArr[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getFriendArr(_arg_1:int):PlayerInfoBean
        {
            return (this.friendArrArray[_arg_1] as PlayerInfoBean);
        }

        public function setFriendArr(_arg_1:PlayerInfoBean, _arg_2:int):void
        {
            this.friendArrArray[_arg_2] = _arg_1;
        }

        public function getBlockArr(_arg_1:int):PlayerInfoBean
        {
            return (this.blockArrArray[_arg_1] as PlayerInfoBean);
        }

        public function copyTo(_arg_1:FriendResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.blockArrArray, _arg_1.blockArrArray);
            CommonUtil.arrayCopy(this.friendArrArray, _arg_1.friendArrArray);
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

        public function setBlockArr(_arg_1:PlayerInfoBean, _arg_2:int):void
        {
            this.blockArrArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.friend

