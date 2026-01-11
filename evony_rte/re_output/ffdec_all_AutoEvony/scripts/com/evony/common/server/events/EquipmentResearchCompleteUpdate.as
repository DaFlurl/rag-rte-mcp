package com.evony.common.server.events
{
   import com.evony.common.*;
   
   public class EquipmentResearchCompleteUpdate extends BaseBean
   {
      
      public var castleId:int;
      
      public var level:int;
      
      public var typeId:int;
      
      public function EquipmentResearchCompleteUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.level != null)
         {
            this.level = param2.level;
         }
         if(param2.typeId != null)
         {
            this.typeId = param2.typeId;
         }
      }
      
      public function copyTo(param1:EquipmentResearchCompleteUpdate) : void
      {
         param1.castleId = this.castleId;
         param1.level = this.level;
         param1.typeId = this.typeId;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- EquipmentResearchCompleteUpdate ----\n";
         _loc3_ += param1 + "castleId = " + this.castleId + "\n";
         _loc3_ += param1 + "level = " + this.level + "\n";
         return _loc3_ + (param1 + "typeId = " + this.typeId + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.castleId = this.castleId;
         _loc1_.level = this.level;
         _loc1_.typeId = this.typeId;
         return _loc1_;
      }
   }
}

