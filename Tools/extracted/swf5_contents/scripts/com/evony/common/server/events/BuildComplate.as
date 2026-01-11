package com.evony.common.server.events
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   
   public class BuildComplate extends BaseBean
   {
      public var castleId:int;
      
      public var buildingBean:BuildingBean;
      
      public function BuildComplate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.buildingBean != null)
         {
            this.buildingBean = new BuildingBean(param2.buildingBean);
         }
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
      }
      
      public function copyTo(param1:BuildComplate) : void
      {
         if(this.buildingBean != null)
         {
            this.buildingBean.copyTo(param1.buildingBean);
         }
         else
         {
            param1.buildingBean = null;
         }
         param1.castleId = this.castleId;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- BuildComplate ----\n";
         if(this.buildingBean != null)
         {
            _loc3_ += this.buildingBean.toDebugString(param1 + "buildingBean.");
         }
         else
         {
            _loc3_ += param1 + "buildingBean = null\n";
         }
         return _loc3_ + (param1 + "castleId = " + this.castleId + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.buildingBean = this.buildingBean.toObject();
         _loc1_.castleId = this.castleId;
         return _loc1_;
      }
   }
}

