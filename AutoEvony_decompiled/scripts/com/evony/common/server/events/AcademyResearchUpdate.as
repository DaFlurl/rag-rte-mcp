package com.evony.common.server.events
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   
   public class AcademyResearchUpdate extends BaseBean
   {
      
      public var castleId:int;
      
      public var researchBean:AvailableResearchListBean;
      
      public function AcademyResearchUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.researchBean != null)
         {
            this.researchBean = new AvailableResearchListBean(param2.researchBean);
         }
      }
      
      public function copyTo(param1:AcademyResearchUpdate) : void
      {
         param1.castleId = this.castleId;
         if(this.researchBean != null)
         {
            this.researchBean.copyTo(param1.researchBean);
         }
         else
         {
            param1.researchBean = null;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- AcademyResearchUpdate ----\n";
         _loc3_ += param1 + "castleId = " + this.castleId + "\n";
         if(this.researchBean != null)
         {
            _loc3_ += this.researchBean.toDebugString(param1 + "researchBean.");
         }
         else
         {
            _loc3_ += param1 + "researchBean = null\n";
         }
         return _loc3_;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.castleId = this.castleId;
         _loc1_.researchBean = this.researchBean.toObject();
         return _loc1_;
      }
   }
}

