package com.evony.common.module.tech
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.AvailableResearchListBean;
   
   public class ResearchResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var tech:AvailableResearchListBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function ResearchResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
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
         if(param2.tech != null)
         {
            this.tech = new AvailableResearchListBean(param2.tech);
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ResearchResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (this.tech != null ? this.tech.toDebugString(param1 + "tech.") : param1 + "tech = null\n");
      }
      
      public function copyTo(param1:ResearchResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         if(this.tech != null)
         {
            this.tech.copyTo(param1.tech);
         }
         else
         {
            param1.tech = null;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "tech":this.tech.toObject()
         };
      }
   }
}

