package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.PlayerBean;
   
   public class UnregisteredCreatePlayerResponse extends BaseBean
   {
      
      public static const CREATE_RESULT_NAME_DUP:int = -1;
      
      public static const CREATE_RESULT_ZONE_FULL:int = -2;
      
      public static const CREATE_RESULT_HAVE_CREATED:int = -3;
      
      public var player:PlayerBean;
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function UnregisteredCreatePlayerResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
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
         if(param2.player != null)
         {
            this.player = new PlayerBean(param2.player);
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- UnregisteredCreatePlayerResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (this.player != null ? this.player.toDebugString(param1 + "player.") : param1 + "player = null\n");
      }
      
      public function copyTo(param1:UnregisteredCreatePlayerResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         if(this.player != null)
         {
            this.player.copyTo(param1.player);
         }
         else
         {
            param1.player = null;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "player":this.player.toObject()
         };
      }
   }
}

