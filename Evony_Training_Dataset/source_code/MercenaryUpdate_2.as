package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.MercenaryBean;
   
   public class MercenaryUpdate extends BaseBean
   {
      public var castleId:int;
      
      public var mercenaryBean:MercenaryBean;
      
      public function MercenaryUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.mercenaryBean != null)
         {
            this.mercenaryBean = new MercenaryBean(param2.mercenaryBean);
         }
      }
      
      public function copyTo(param1:MercenaryUpdate) : void
      {
         param1.castleId = this.castleId;
         if(this.mercenaryBean != null)
         {
            this.mercenaryBean.copyTo(param1.mercenaryBean);
         }
         else
         {
            param1.mercenaryBean = null;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "castleId":this.castleId,
            "mercenaryBean":this.mercenaryBean.toObject()
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- MercenaryUpdate ----\n" + (param1 + "castleId = " + this.castleId + "\n") + (this.mercenaryBean != null ? this.mercenaryBean.toDebugString(param1 + "mercenaryBean.") : param1 + "mercenaryBean = null\n");
      }
   }
}

