package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.CastleResourceBean;
   
   public class ResourceUpdate extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var resource:CastleResourceBean;
      
      public var castleId:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function ResourceUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
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
         if(param2.resource != null)
         {
            this.resource = new CastleResourceBean(param2.resource);
         }
      }
      
      public function toObject() : Object
      {
         return {
            "castleId":this.castleId,
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "resource":this.resource.toObject()
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ResourceUpdate ----\n" + (param1 + "castleId = " + this.castleId + "\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (this.resource != null ? this.resource.toDebugString(param1 + "resource.") : param1 + "resource = null\n");
      }
      
      public function copyTo(param1:ResourceUpdate) : void
      {
         param1.castleId = this.castleId;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         if(this.resource != null)
         {
            this.resource.copyTo(param1.resource);
         }
         else
         {
            param1.resource = null;
         }
      }
   }
}

