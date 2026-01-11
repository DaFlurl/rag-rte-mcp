// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.ChannelChatMsg

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class ChannelChatMsg extends BaseBean 
    {

        public var msg:String;
        public var channel:String;
        public var languageType:int;
        public var ownitemid:int;
        public var fromUser:String;

        public function ChannelChatMsg(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.channel != null)
            {
                this.channel = _arg_2.channel;
            };
            if (_arg_2.fromUser != null)
            {
                this.fromUser = _arg_2.fromUser;
            };
            if (_arg_2.languageType != null)
            {
                this.languageType = _arg_2.languageType;
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

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- ChannelChatMsg ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "channel = ") + this.channel) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "fromUser = ") + this.fromUser) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "languageType = ") + this.languageType) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            return (_local_2 + (((_arg_1 + "ownitemid = ") + this.ownitemid) + "\n"));
        }

        public function copyTo(_arg_1:ChannelChatMsg):void
        {
            _arg_1.channel = this.channel;
            _arg_1.fromUser = this.fromUser;
            _arg_1.languageType = this.languageType;
            _arg_1.msg = this.msg;
            _arg_1.ownitemid = this.ownitemid;
        }

        public function toObject():Object
        {
            return ({
                "channel":this.channel,
                "fromUser":this.fromUser,
                "languageType":this.languageType,
                "msg":this.msg,
                "ownitemid":this.ownitemid
            });
        }


    }
}//package com.evony.common.server.events

