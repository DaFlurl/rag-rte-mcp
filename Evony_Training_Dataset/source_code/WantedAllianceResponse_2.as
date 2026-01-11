package com.evony.common.module.alliance
{
   import com.evony.common.BaseBean;
   
   public class WantedAllianceResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var allianceName:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function WantedAllianceResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.allianceName != null)
         {
            this.allianceName = param2.allianceName;
         }
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
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- WantedAllianceResponse ----\n" + (param1 + "allianceName = " + this.allianceName + "\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:WantedAllianceResponse) : void
      {
         param1.allianceName = this.allianceName;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         return {
            "allianceName":this.allianceName,
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
   }
}

