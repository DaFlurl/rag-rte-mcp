package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class ConnectionLost extends BaseBean
   {
      
      public static const KICK_BY_SERVER:int = 0;
      
      public static const SERVER_START:int = 1;
      
      public static const SERVER_SHUTDOWN:int = 2;
      
      public static const KICK_BY_OTHER:int = 3;
      
      public static const SERVER_MAINTAIN:int = 4;
      
      public static const ILLEGAL_NAME:int = 5;
      
      public static const LOGIN_FREQUENTLY:int = 6;
      
      public var reasonCode:int;
      
      public var msg:String;
      
      public function ConnectionLost(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.reasonCode != null)
         {
            this.reasonCode = param2.reasonCode;
         }
      }
      
      public function copyTo(param1:ConnectionLost) : void
      {
         param1.msg = this.msg;
         param1.reasonCode = this.reasonCode;
      }
      
      public function toObject() : Object
      {
         return {
            "msg":this.msg,
            "reasonCode":this.reasonCode
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ConnectionLost ----\n" + (param1 + "msg = " + this.msg + "\n") + (param1 + "reasonCode = " + this.reasonCode + "\n");
      }
   }
}

