package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.TroopBean;
   
   public class TroopUpdate extends BaseBean
   {
      
      public var troop:TroopBean;
      
      public var caslteId:int;
      
      public function TroopUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.caslteId != null)
         {
            this.caslteId = param2.caslteId;
         }
         if(param2.troop != null)
         {
            this.troop = new TroopBean(param2.troop);
         }
      }
      
      public function copyTo(param1:TroopUpdate) : void
      {
         param1.caslteId = this.caslteId;
         if(this.troop != null)
         {
            this.troop.copyTo(param1.troop);
         }
         else
         {
            param1.troop = null;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "caslteId":this.caslteId,
            "troop":this.troop.toObject()
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- TroopUpdate ----\n" + (param1 + "caslteId = " + this.caslteId + "\n") + (this.troop != null ? this.troop.toDebugString(param1 + "troop.") : param1 + "troop = null\n");
      }
   }
}

