package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class AllianceChatMsg extends BaseBean
   {
      public var msg:String;
      
      public var fromUser:String;
      
      public var languageType:int;
      
      public var ownitemid:int;
      
      public function AllianceChatMsg(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
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
      
      public function copyTo(param1:AllianceChatMsg) : void
      {
         param1.fromUser = this.fromUser;
         param1.languageType = this.languageType;
         param1.msg = this.msg;
         param1.ownitemid = this.ownitemid;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- AllianceChatMsg ----\n" + (param1 + "fromUser = " + this.fromUser + "\n") + (param1 + "languageType = " + this.languageType + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ownitemid = " + this.ownitemid + "\n");
      }
      
      public function toObject() : Object
      {
         return {
            "fromUser":this.fromUser,
            "languageType":this.languageType,
            "msg":this.msg,
            "ownitemid":this.ownitemid
         };
      }
   }
}

