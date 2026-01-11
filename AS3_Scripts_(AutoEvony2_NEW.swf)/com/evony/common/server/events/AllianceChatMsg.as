// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.AllianceChatMsg

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class AllianceChatMsg extends BaseBean 
    {

        public var msg:String;
        public var fromUser:String;
        public var languageType:int;
        public var ownitemid:int;

        public function AllianceChatMsg(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
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

        public function copyTo(_arg_1:AllianceChatMsg):void
        {
            _arg_1.fromUser = this.fromUser;
            _arg_1.languageType = this.languageType;
            _arg_1.msg = this.msg;
            _arg_1.ownitemid = this.ownitemid;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (((("---- AllianceChatMsg ----\n" + (((_arg_1 + "fromUser = ") + this.fromUser) + "\n")) + (((_arg_1 + "languageType = ") + this.languageType) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ownitemid = ") + this.ownitemid) + "\n"));
        }

        public function toObject():Object
        {
            return ({
                "fromUser":this.fromUser,
                "languageType":this.languageType,
                "msg":this.msg,
                "ownitemid":this.ownitemid
            });
        }


    }
}//package com.evony.common.server.events

