package com.evony.common.module.gemstone
{
   import com.evony.common.BaseBean;
   
   public class GemstoneRespone extends BaseBean
   {
      public var errorMsg:String;
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var enhancedstarlv:int;
      
      public var ok:int;
      
      public var equipmenttechid:int;
      
      public function GemstoneRespone(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.enhancedstarlv != null)
         {
            this.enhancedstarlv = param2.enhancedstarlv;
         }
         if(param2.equipmenttechid != null)
         {
            this.equipmenttechid = param2.equipmenttechid;
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
         return "---- GemstoneRespone ----\n" + (param1 + "enhancedstarlv = " + this.enhancedstarlv + "\n") + (param1 + "equipmenttechid = " + this.equipmenttechid + "\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function copyTo(param1:GemstoneRespone) : void
      {
         param1.enhancedstarlv = this.enhancedstarlv;
         param1.equipmenttechid = this.equipmenttechid;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
      
      public function toObject() : Object
      {
         return {
            "enhancedstarlv":this.enhancedstarlv,
            "equipmenttechid":this.equipmenttechid,
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
   }
}

