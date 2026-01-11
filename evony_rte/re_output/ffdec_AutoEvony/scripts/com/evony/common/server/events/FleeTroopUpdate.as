package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.TroopBean;
   
   public class FleeTroopUpdate extends BaseBean
   {
      
      public var troop:TroopBean;
      
      public var castleId:int;
      
      public var goldNeed:int;
      
      public function FleeTroopUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.goldNeed != null)
         {
            this.goldNeed = param2.goldNeed;
         }
         if(param2.troop != null)
         {
            this.troop = new TroopBean(param2.troop);
         }
      }
      
      public function copyTo(param1:FleeTroopUpdate) : void
      {
         param1.castleId = this.castleId;
         param1.goldNeed = this.goldNeed;
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
            "castleId":this.castleId,
            "goldNeed":this.goldNeed,
            "troop":this.troop.toObject()
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- FleeTroopUpdate ----\n" + (param1 + "castleId = " + this.castleId + "\n") + (param1 + "goldNeed = " + this.goldNeed + "\n") + (this.troop != null ? this.troop.toDebugString(param1 + "troop.") : param1 + "troop = null\n");
      }
   }
}

