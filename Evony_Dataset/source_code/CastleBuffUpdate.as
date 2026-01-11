package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.BuffBean;
   
   public class CastleBuffUpdate extends BaseBean
   {
      public var updateType:int;
      
      public var buffBean:BuffBean;
      
      public var castleid:int;
      
      public function CastleBuffUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.buffBean != null)
         {
            this.buffBean = new BuffBean(param2.buffBean);
         }
         if(param2.castleid != null)
         {
            this.castleid = param2.castleid;
         }
         if(param2.updateType != null)
         {
            this.updateType = param2.updateType;
         }
      }
      
      public function copyTo(param1:CastleBuffUpdate) : void
      {
         if(this.buffBean == null)
         {
            param1.buffBean = null;
         }
         else
         {
            this.buffBean.copyTo(param1.buffBean);
         }
         param1.castleid = this.castleid;
         param1.updateType = this.updateType;
      }
      
      public function toObject() : Object
      {
         return {
            "buffBean":this.buffBean.toObject(),
            "castleid":this.castleid,
            "updateType":this.updateType
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- CastleBuffUpdate ----\n" + (this.buffBean == null ? param1 + "buffBean = null\n" : this.buffBean.toDebugString(param1 + "buffBean.")) + (param1 + "castleid = " + this.castleid + "\n") + (param1 + "updateType = " + this.updateType + "\n");
      }
   }
}

