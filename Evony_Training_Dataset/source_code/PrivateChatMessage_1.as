// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.PrivateChatMessage

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class PrivateChatMessage extends BaseBean 
    {

        public static const NORMAL_CHAT:int = 0;
        public static const GM_CHAT:int = 1;

        public var msg:String;
        public var chatType:int;
        public var fromUser:String;
        public var ownitemid:int;

        public function PrivateChatMessage(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.chatType != null)
            {
                this.chatType = _arg_2.chatType;
            };
            if (_arg_2.fromUser != null)
            {
                this.fromUser = _arg_2.fromUser;
            };
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.ownitemid != null)
            {
                this.ownitemid = _arg_2.ownitemid;
            };
        }

        public function copyTo(_arg_1:PrivateChatMessage):void
        {
            _arg_1.chatType = this.chatType;
            _arg_1.fromUser = this.fromUser;
            _arg_1.msg = this.msg;
            _arg_1.ownitemid = this.ownitemid;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- PrivateChatMessage ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "chatType = ") + this.chatType) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "fromUser = ") + this.fromUser) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            return (_local_2 + (((_arg_1 + "ownitemid = ") + this.ownitemid) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.chatType = this.chatType;
            _local_1.fromUser = this.fromUser;
            _local_1.msg = this.msg;
            _local_1.ownitemid = this.ownitemid;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

