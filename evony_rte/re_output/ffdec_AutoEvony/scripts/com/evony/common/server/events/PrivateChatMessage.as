package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class PrivateChatMessage extends BaseBean
   {
      
      public static const NORMAL_CHAT:int = 0;
      
      public static const GM_CHAT:int = 1;
      
      public var msg:String;
      
      public var fromUser:String;
      
      public var chatType:int;
      
      public var ownitemid:int;
      
      public function PrivateChatMessage(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.chatType != null)
         {
            this.chatType = param2.chatType;
         }
         if(param2.fromUser != null)
         {
            this.fromUser = param2.fromUser;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.ownitemid != null)
         {
            this.ownitemid = param2.ownitemid;
         }
      }
      
      public function copyTo(param1:PrivateChatMessage) : void
      {
         param1.chatType = this.chatType;
         param1.fromUser = this.fromUser;
         param1.msg = this.msg;
         param1.ownitemid = this.ownitemid;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- PrivateChatMessage ----\n" + (param1 + "chatType = " + this.chatType + "\n") + (param1 + "fromUser = " + this.fromUser + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ownitemid = " + this.ownitemid + "\n");
      }
      
      public function toObject() : Object
      {
         return {
            "chatType":this.chatType,
            "fromUser":this.fromUser,
            "msg":this.msg,
            "ownitemid":this.ownitemid
         };
      }
   }
}

