package com.evony.common.module.alliance
{
   import com.evony.common.BaseBean;
   
   public class AllianceInfoResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var allinaceInfo:String;
      
      public var creator:String;
      
      public var leader:String;
      
      public var prestigeCount:int;
      
      public var memberCount:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var ranking:int;
      
      public function AllianceInfoResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.allinaceInfo != null)
         {
            this.allinaceInfo = param2.allinaceInfo;
         }
         if(param2.creator != null)
         {
            this.creator = param2.creator;
         }
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.leader != null)
         {
            this.leader = param2.leader;
         }
         if(param2.memberCount != null)
         {
            this.memberCount = param2.memberCount;
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
         if(param2.prestigeCount != null)
         {
            this.prestigeCount = param2.prestigeCount;
         }
         if(param2.ranking != null)
         {
            this.ranking = param2.ranking;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "allinaceInfo":this.allinaceInfo,
            "creator":this.creator,
            "errorMsg":this.errorMsg,
            "leader":this.leader,
            "memberCount":this.memberCount,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "prestigeCount":this.prestigeCount,
            "ranking":this.ranking
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- AllianceInfoResponse ----\n" + (param1 + "allinaceInfo = " + this.allinaceInfo + "\n") + (param1 + "creator = " + this.creator + "\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "leader = " + this.leader + "\n") + (param1 + "memberCount = " + this.memberCount + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "prestigeCount = " + this.prestigeCount + "\n") + (param1 + "ranking = " + this.ranking + "\n");
      }
      
      public function copyTo(param1:AllianceInfoResponse) : void
      {
         param1.allinaceInfo = this.allinaceInfo;
         param1.creator = this.creator;
         param1.errorMsg = this.errorMsg;
         param1.leader = this.leader;
         param1.memberCount = this.memberCount;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.prestigeCount = this.prestigeCount;
         param1.ranking = this.ranking;
      }
   }
}

