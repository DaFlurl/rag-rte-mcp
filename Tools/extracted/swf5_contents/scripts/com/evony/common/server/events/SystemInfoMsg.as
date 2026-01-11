package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class SystemInfoMsg extends BaseBean
   {
      public var msg:String;
      
      public var tV:Boolean;
      
      public var tVContext:String;
      
      public var noSenderSystemInfo:Boolean;
      
      public var sender:String;
      
      public var alliance:Boolean;
      
      public function SystemInfoMsg(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.sender != null)
         {
            this.sender = param2.sender;
         }
         if(param2.tVContext != null)
         {
            this.tVContext = param2.tVContext;
         }
         if(param2.alliance != null)
         {
            this.alliance = param2.alliance;
         }
         if(param2.noSenderSystemInfo != null)
         {
            this.noSenderSystemInfo = param2.noSenderSystemInfo;
         }
         if(param2.tV != null)
         {
            this.tV = param2.tV;
         }
      }
      
      public function copyTo(param1:SystemInfoMsg) : void
      {
         param1.msg = this.msg;
         param1.sender = this.sender;
         param1.tVContext = this.tVContext;
         param1.alliance = this.alliance;
         param1.noSenderSystemInfo = this.noSenderSystemInfo;
         param1.tV = this.tV;
      }
      
      public function toObject() : Object
      {
         return {
            "msg":this.msg,
            "sender":this.sender,
            "tVContext":this.tVContext,
            "alliance":this.alliance,
            "noSenderSystemInfo":this.noSenderSystemInfo,
            "tV":this.tV
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- SystemInfoMsg ----\n" + (param1 + "msg = " + this.msg + "\n") + (param1 + "sender = " + this.sender + "\n") + (param1 + "tVContext = " + this.tVContext + "\n") + (param1 + "alliance = " + this.alliance + "\n") + (param1 + "noSenderSystemInfo = " + this.noSenderSystemInfo + "\n") + (param1 + "tV = " + this.tV + "\n");
      }
   }
}

