package com.evony.common.module.alliance
{
   import com.evony.common.BaseBean;
   
   public class AlliancePowerLevelResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var level:int;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function AlliancePowerLevelResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.level != null)
         {
            this.level = param2.level;
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
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- AlliancePowerLevelResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "level = " + this.level + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:AlliancePowerLevelResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.level = this.level;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "level":this.level,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
   }
}

