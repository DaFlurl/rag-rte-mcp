// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.MailCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.mail.TVResponse;
    import com.evony.common.module.mail.MailResponse;
    import com.evony.common.module.mail.MailListResponse;

    public class MailCommands 
    {

        public var _receiveMailList_callback:Function;
        public var _reportPlayer_callback:Function;
        public var _readMail_callback:Function;
        public var _deleteMail_callback:Function;
        public var _readOverMailList_callback:Function;
        public var _reportBug_callback:Function;
        public var _getAllTVMsg_callback:Function;
        private var sender:Sender;
        public var _sendMail_callback:Function;


        public function deleteMail(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._deleteMail_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.deleteMail", {"str_mailid":_arg_1});
            };
            return (null);
        }

        public function getAllTVMsg(_arg_1:Function=null):TVResponse
        {
            this._getAllTVMsg_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.getAllTVMsg", {});
            };
            return (null);
        }

        public function sendMail(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._sendMail_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.sendMail", {
                    "username":_arg_1,
                    "title":_arg_2,
                    "content":_arg_3
                });
            };
            return (null);
        }

        public function reportBug(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._reportBug_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.reportBug", {
                    "subject":_arg_1,
                    "content":_arg_2
                });
            };
            return (null);
        }

        public function readMail(_arg_1:int, _arg_2:Function=null):MailResponse
        {
            this._readMail_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.readMail", {"mailId":_arg_1});
            };
            return (null);
        }

        public function readOverMailList(_arg_1:String, _arg_2:Function=null):MailResponse
        {
            this._readOverMailList_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.readOverMailList", {"mailIds":_arg_1});
            };
            return (null);
        }

        public function reportPlayer(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._reportPlayer_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.reportPlayer", {
                    "subject":_arg_1,
                    "content":_arg_2
                });
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function receiveMailList(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):MailListResponse
        {
            this._receiveMailList_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("mail.receiveMailList", {
                    "pageNo":_arg_1,
                    "type":_arg_2,
                    "pageSize":_arg_3
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

