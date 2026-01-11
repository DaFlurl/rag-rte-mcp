package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.FortificationsBean;
   
   public class FortificationsUpdate extends BaseBean
   {
      public var fortification:FortificationsBean;
      
      public var castleId:int;
      
      public function FortificationsUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.fortification != null)
         {
            this.fortification = new FortificationsBean(param2.fortification);
         }
      }
      
      public function copyTo(param1:FortificationsUpdate) : void
      {
         param1.castleId = this.castleId;
         if(this.fortification != null)
         {
            this.fortification.copyTo(param1.fortification);
         }
         else
         {
            param1.fortification = null;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "castleId":this.castleId,
            "fortification":this.fortification.toObject()
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- FortificationsUpdate ----\n" + (param1 + "castleId = " + this.castleId + "\n") + (this.fortification != null ? this.fortification.toDebugString(param1 + "fortification.") : param1 + "fortification = null\n");
      }
   }
}

