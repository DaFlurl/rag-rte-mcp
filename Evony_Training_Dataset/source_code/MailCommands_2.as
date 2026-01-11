package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.mail.MailListResponse;
   import com.evony.common.module.mail.MailResponse;
   import com.evony.common.module.mail.TVResponse;
   
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
      
      public function MailCommands()
      {
         super();
      }
      
      public function deleteMail(param1:String, param2:Function = null) : CommandResponse
      {
         this._deleteMail_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.deleteMail",{"str_mailid":param1});
         }
         return null;
      }
      
      public function getAllTVMsg(param1:Function = null) : TVResponse
      {
         this._getAllTVMsg_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.getAllTVMsg",{});
         }
         return null;
      }
      
      public function sendMail(param1:String, param2:String, param3:String, param4:Function = null) : CommandResponse
      {
         this._sendMail_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.sendMail",{
               "username":param1,
               "title":param2,
               "content":param3
            });
         }
         return null;
      }
      
      public function reportBug(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._reportBug_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.reportBug",{
               "subject":param1,
               "content":param2
            });
         }
         return null;
      }
      
      public function readMail(param1:int, param2:Function = null) : MailResponse
      {
         this._readMail_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.readMail",{"mailId":param1});
         }
         return null;
      }
      
      public function readOverMailList(param1:String, param2:Function = null) : MailResponse
      {
         this._readOverMailList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.readOverMailList",{"mailIds":param1});
         }
         return null;
      }
      
      public function reportPlayer(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._reportPlayer_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.reportPlayer",{
               "subject":param1,
               "content":param2
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function receiveMailList(param1:int, param2:int, param3:int, param4:Function = null) : MailListResponse
      {
         this._receiveMailList_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("mail.receiveMailList",{
               "pageNo":param1,
               "type":param2,
               "pageSize":param3
            });
         }
         return null;
      }
   }
}

