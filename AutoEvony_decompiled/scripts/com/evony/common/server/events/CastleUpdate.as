package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.CastleBean;
   
   public class CastleUpdate extends BaseBean
   {
      
      public var castleBean:CastleBean;
      
      public var updateType:int;
      
      public function CastleUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleBean != null)
         {
            this.castleBean = new CastleBean(param2.castleBean);
         }
         if(param2.updateType != null)
         {
            this.updateType = param2.updateType;
         }
      }
      
      public function copyTo(param1:CastleUpdate) : void
      {
         if(this.castleBean != null)
         {
            this.castleBean.copyTo(param1.castleBean);
         }
         else
         {
            param1.castleBean = null;
         }
         param1.updateType = this.updateType;
      }
      
      public function toObject() : Object
      {
         return {
            "castleBean":this.castleBean.toObject(),
            "updateType":this.updateType
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- CastleUpdate ----\n" + (this.castleBean != null ? this.castleBean.toDebugString(param1 + "castleBean.") : param1 + "castleBean = null\n") + (param1 + "updateType = " + this.updateType + "\n");
      }
   }
}

