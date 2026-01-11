package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.HeroBean;
   
   public class HeroUpdate extends BaseBean
   {
      public var updateType:int;
      
      public var castleId:int;
      
      public var hero:HeroBean;
      
      public function HeroUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.hero != null)
         {
            this.hero = new HeroBean(param2.hero);
         }
         if(param2.updateType != null)
         {
            this.updateType = param2.updateType;
         }
      }
      
      public function copyTo(param1:HeroUpdate) : void
      {
         param1.castleId = this.castleId;
         if(this.hero != null)
         {
            this.hero.copyTo(param1.hero);
         }
         else
         {
            param1.hero = null;
         }
         param1.updateType = this.updateType;
      }
      
      public function toObject() : Object
      {
         return {
            "castleId":this.castleId,
            "hero":this.hero.toObject(),
            "updateType":this.updateType
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- HeroUpdate ----\n" + (param1 + "castleId = " + this.castleId + "\n") + (this.hero != null ? this.hero.toDebugString(param1 + "hero.") : param1 + "hero = null\n") + (param1 + "updateType = " + this.updateType + "\n");
      }
   }
}

