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
      
      public function ChannelChatMsg(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.channel != null)
         {
            this.channel = param2.channel;
         }
         if(param2.fromUser != null)
         {
            this.fromUser = param2.fromUser;
         }
         if(param2.languageType != null)
         {
            this.languageType = param2.languageType;
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
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- ChannelChatMsg ----\n";
         _loc2_ += param1 + "channel = " + this.channel + "\n";
         _loc2_ += param1 + "fromUser = " + this.fromUser + "\n";
         _loc2_ += param1 + "languageType = " + this.languageType + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         return _loc2_ + (param1 + "ownitemid = " + this.ownitemid + "\n");
      }
      
      public function copyTo(param1:ChannelChatMsg) : void
      {
         param1.channel = this.channel;
         param1.fromUser = this.fromUser;
         param1.languageType = this.languageType;
         param1.msg = this.msg;
         param1.ownitemid = this.ownitemid;
      }
      
      public function toObject() : Object
      {
         return {
            "channel":this.channel,
            "fromUser":this.fromUser,
            "languageType":this.languageType,
            "msg":this.msg,
            "ownitemid":this.ownitemid
         };
      }
   }
}

