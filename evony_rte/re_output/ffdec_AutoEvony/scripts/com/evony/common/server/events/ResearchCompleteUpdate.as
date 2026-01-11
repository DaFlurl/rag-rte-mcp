package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class ResearchCompleteUpdate extends BaseBean
   {
      
      public var castleId:int;
      
      public var level:int;
      
      public var typeId:int;
      
      public function ResearchCompleteUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
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
      
      public function copyTo(param1:ResearchCompleteUpdate) : void
      {
         param1.castleId = this.castleId;
         param1.level = this.level;
         param1.typeId = this.typeId;
      }
      
      public function toObject() : Object
      {
         return {
            "castleId":this.castleId,
            "level":this.level,
            "typeId":this.typeId
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ResearchCompleteUpdate ----\n" + (param1 + "castleId = " + this.castleId + "\n") + (param1 + "level = " + this.level + "\n") + (param1 + "typeId = " + this.typeId + "\n");
      }
   }
}

