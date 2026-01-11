// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.PlayerInfoResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class PlayerInfoResponse extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var playerInfo:PlayerInfoBean;
        public var errorMsg:String;
        public var ok:int;

        public function PlayerInfoResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
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
            if (_arg_2.playerInfo != null)
            {
                this.playerInfo = new PlayerInfoBean(_arg_2.playerInfo);
            };
        }

        public function copyTo(_arg_1:PlayerInfoResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (this.playerInfo != null)
            {
                this.playerInfo.copyTo(_arg_1.playerInfo);
            }
            else
            {
                _arg_1.playerInfo = null;
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- PlayerInfoResponse ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            if (this.playerInfo != null)
            {
                _local_3 = (_local_3 + this.playerInfo.toDebugString((_arg_1 + "playerInfo.")));
            }
            else
            {
                _local_3 = (_local_3 + (_arg_1 + "playerInfo = null\n"));
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
            _local_1.playerInfo = this.playerInfo.toObject();
            return (_local_1);
        }


    }
}//package com.evony.common.module.alliance

