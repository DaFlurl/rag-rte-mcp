// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.mail.MailResponse

package com.evony.common.module.mail
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class MailResponse extends BaseBean 
    {

        public var msg:String;
        public var type_id:int;
        public var packageId:Number;
        public var targetId:int;
        public var receiveTime:String;
        public var content:String;
        public var mailid:int;
        public var errorMsg:String;
        public var playerId:int;
        public var title:String;
        public var isRead:int;
        public var ok:int;
        public var receiver:String;
        public var sender:String;

        public function MailResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.content != null)
            {
                this.content = _arg_2.content;
            };
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.isRead != null)
            {
                this.isRead = _arg_2.isRead;
            };
            if (_arg_2.mailid != null)
            {
                this.mailid = _arg_2.mailid;
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
            if (_arg_2.playerId != null)
            {
                this.playerId = _arg_2.playerId;
            };
            if (_arg_2.receiveTime != null)
            {
                this.receiveTime = _arg_2.receiveTime;
            };
            if (_arg_2.receiver != null)
            {
                this.receiver = _arg_2.receiver;
            };
            if (_arg_2.sender != null)
            {
                this.sender = _arg_2.sender;
            };
            if (_arg_2.targetId != null)
            {
                this.targetId = _arg_2.targetId;
            };
            if (_arg_2.title != null)
            {
                this.title = _arg_2.title;
            };
            if (_arg_2.type_id != null)
            {
                this.type_id = _arg_2.type_id;
            };
        }

        public function copyTo(_arg_1:MailResponse):void
        {
            _arg_1.content = this.content;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.isRead = this.isRead;
            _arg_1.mailid = this.mailid;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.playerId = this.playerId;
            _arg_1.receiveTime = this.receiveTime;
            _arg_1.receiver = this.receiver;
            _arg_1.sender = this.sender;
            _arg_1.targetId = this.targetId;
            _arg_1.title = this.title;
            _arg_1.type_id = this.type_id;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.content = this.content;
            _local_1.errorMsg = this.errorMsg;
            _local_1.isRead = this.isRead;
            _local_1.mailid = this.mailid;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.playerId = this.playerId;
            _local_1.receiveTime = this.receiveTime;
            _local_1.receiver = this.receiver;
            _local_1.sender = this.sender;
            _local_1.targetId = this.targetId;
            _local_1.title = this.title;
            _local_1.type_id = this.type_id;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- MailResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "content = ") + this.content) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isRead = ") + this.isRead) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "mailid = ") + this.mailid) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "playerId = ") + this.playerId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "receiveTime = ") + this.receiveTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "receiver = ") + this.receiver) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "sender = ") + this.sender) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "targetId = ") + this.targetId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "title = ") + this.title) + "\n"));
            return (_local_2 + (((_arg_1 + "type_id = ") + this.type_id) + "\n"));
        }


    }
}//package com.evony.common.module.mail

