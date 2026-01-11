package com.evony.common.module.mail
{
   import com.evony.common.*;
   
   public class MailResponse extends BaseBean
   {
      public var msg:String;
      
      public var type_id:int;
      
      public var packageId:Number;
      
      public var targetId:int;
      
      public var content:String;
      
      public var mailid:int;
      
      public var title:String;
      
      public var errorMsg:String;
      
      public var playerId:int;
      
      public var receiveTime:String;
      
      public var ok:int;
      
      public var isRead:int;
      
      public var sender:String;
      
      public var receiver:String;
      
      public function MailResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.content != null)
         {
            this.content = param2.content;
         }
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.isRead != null)
         {
            this.isRead = param2.isRead;
         }
         if(param2.mailid != null)
         {
            this.mailid = param2.mailid;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.ok != null)
         {
            this.ok = param2.ok;
         }
         if(param2.packageId != null)
         {
            this.packageId = param2.packageId;
         }
         if(param2.playerId != null)
         {
            this.playerId = param2.playerId;
         }
         if(param2.receiveTime != null)
         {
            this.receiveTime = param2.receiveTime;
         }
         if(param2.receiver != null)
         {
            this.receiver = param2.receiver;
         }
         if(param2.sender != null)
         {
            this.sender = param2.sender;
         }
         if(param2.targetId != null)
         {
            this.targetId = param2.targetId;
         }
         if(param2.title != null)
         {
            this.title = param2.title;
         }
         if(param2.type_id != null)
         {
            this.type_id = param2.type_id;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- MailResponse ----\n";
         _loc3_ += param1 + "content = " + this.content + "\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "isRead = " + this.isRead + "\n";
         _loc3_ += param1 + "mailid = " + this.mailid + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc3_ += param1 + "playerId = " + this.playerId + "\n";
         _loc3_ += param1 + "receiveTime = " + this.receiveTime + "\n";
         _loc3_ += param1 + "receiver = " + this.receiver + "\n";
         _loc3_ += param1 + "sender = " + this.sender + "\n";
         _loc3_ += param1 + "targetId = " + this.targetId + "\n";
         _loc3_ += param1 + "title = " + this.title + "\n";
         return _loc3_ + (param1 + "type_id = " + this.type_id + "\n");
      }
      
      public function copyTo(param1:MailResponse) : void
      {
         param1.content = this.content;
         param1.errorMsg = this.errorMsg;
         param1.isRead = this.isRead;
         param1.mailid = this.mailid;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.playerId = this.playerId;
         param1.receiveTime = this.receiveTime;
         param1.receiver = this.receiver;
         param1.sender = this.sender;
         param1.targetId = this.targetId;
         param1.title = this.title;
         param1.type_id = this.type_id;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.content = this.content;
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.isRead = this.isRead;
         _loc1_.mailid = this.mailid;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.playerId = this.playerId;
         _loc1_.receiveTime = this.receiveTime;
         _loc1_.receiver = this.receiver;
         _loc1_.sender = this.sender;
         _loc1_.targetId = this.targetId;
         _loc1_.title = this.title;
         _loc1_.type_id = this.type_id;
         return _loc1_;
      }
   }
}

