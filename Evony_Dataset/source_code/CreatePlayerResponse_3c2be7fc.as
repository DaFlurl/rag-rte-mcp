// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.common.CreatePlayerResponse

package com.evony.common.module.common
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.PlayerBean;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class CreatePlayerResponse extends BaseBean 
    {

        public static const CREATE_RESULT_HAVE_CREATED:int = -3;
        public static const CREATE_RESULT_ZONE_FULL:int = -2;
        public static const CREATE_RESULT_NAME_DUP:int = -1;

        public var msg:String;
        public var packageId:Number;
        public var player:PlayerBean;
        public var errorMsg:String;
        public var ok:int;

        public function CreatePlayerResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
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
            if (_arg_2.player != null)
            {
                this.player = new PlayerBean(_arg_2.player);
            };
        }

        public function copyTo(_arg_1:CreatePlayerResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (this.player != null)
            {
                this.player.copyTo(_arg_1.player);
            }
            else
            {
                _arg_1.player = null;
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- CreatePlayerResponse ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            if (this.player != null)
            {
                _local_3 = (_local_3 + this.player.toDebugString((_arg_1 + "player.")));
            }
            else
            {
                _local_3 = (_local_3 + (_arg_1 + "player = null\n"));
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
            _local_1.player = this.player.toObject();
            return (_local_1);
        }


    }
}//package com.evony.common.module.common

