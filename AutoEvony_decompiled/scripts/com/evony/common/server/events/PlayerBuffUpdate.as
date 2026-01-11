package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.BuffBean;
   
   public class PlayerBuffUpdate extends BaseBean
   {
      
      public var updateType:int;
      
      public var buffBean:BuffBean;
      
      public function PlayerBuffUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.buffBean != null)
         {
            this.buffBean = new BuffBean(param2.buffBean);
         }
         if(param2.updateType != null)
         {
            this.updateType = param2.updateType;
         }
      }
      
      public function copyTo(param1:PlayerBuffUpdate) : void
      {
         if(this.buffBean != null)
         {
            this.buffBean.copyTo(param1.buffBean);
         }
         else
         {
            param1.buffBean = null;
         }
         param1.updateType = this.updateType;
      }
      
      public function toObject() : Object
      {
         return {
            "buffBean":this.buffBean.toObject(),
            "updateType":this.updateType
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- PlayerBuffUpdate ----\n" + (this.buffBean != null ? this.buffBean.toDebugString(param1 + "buffBean.") : param1 + "buffBean = null\n") + (param1 + "updateType = " + this.updateType + "\n");
      }
   }
}

