package com.evony.common.module.common
{
   import com.evony.common.BaseBean;
   
   public class ChatResponse extends BaseBean
   {
      public static const ERROR_MISSING_SPEAKER:int = -1;
      
      public static const ERROR_NO_ALLIANCE:int = -2;
      
      public static const ERROR_NO_USER:int = -3;
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function ChatResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
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
      }
      
      public function copyTo(param1:ChatResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ChatResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
   }
}

