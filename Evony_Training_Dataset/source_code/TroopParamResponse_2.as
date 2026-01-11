package com.evony.common.module.army
{
   import com.evony.common.BaseBean;
   
   public class TroopParamResponse extends BaseBean
   {
      public var msg:String;
      
      public var driveSkillParam:int;
      
      public var packageId:Number;
      
      public var loadSkillParam:int;
      
      public var errorMsg:String;
      
      public var transportStationParam:int;
      
      public var ok:int;
      
      public var marchSkillParam:int;
      
      public function TroopParamResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.ok != null)
         {
            this.ok = param2.ok;
         }
         if(param2.packageId != null)
         {
            this.packageId = param2.packageId;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.driveSkillParam != null)
         {
            this.driveSkillParam = param2.driveSkillParam;
         }
         if(param2.loadSkillParam != null)
         {
            this.loadSkillParam = param2.loadSkillParam;
         }
         if(param2.transportStationParam != null)
         {
            this.transportStationParam = param2.transportStationParam;
         }
         if(param2.marchSkillParam != null)
         {
            this.marchSkillParam = param2.marchSkillParam;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "driveSkillParam":this.driveSkillParam,
            "errorMsg":this.errorMsg,
            "loadSkillParam":this.loadSkillParam,
            "marchSkillParam":this.marchSkillParam,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "transportStationParam":this.transportStationParam
         };
      }
      
      public function copyTo(param1:TroopParamResponse) : void
      {
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.msg = this.msg;
         param1.errorMsg = this.errorMsg;
         param1.driveSkillParam = this.driveSkillParam;
         param1.loadSkillParam = this.loadSkillParam;
         param1.transportStationParam = this.transportStationParam;
         param1.marchSkillParam = this.marchSkillParam;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- TroopParamResponse ----\n" + (param1 + "driveSkillParam = " + this.driveSkillParam + "\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "loadSkillParam = " + this.loadSkillParam + "\n") + (param1 + "marchSkillParam = " + this.marchSkillParam + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "transportStationParam = " + this.transportStationParam + "\n");
      }
   }
}

