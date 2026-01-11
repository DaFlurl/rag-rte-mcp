package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.FieldBean;
   
   public class CastleFieldUpdate extends BaseBean
   {
      
      public var bean:FieldBean;
      
      public var updateType:int;
      
      public var castleId:int;
      
      public function CastleFieldUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.bean != null)
         {
            this.bean = new FieldBean(param2.bean);
         }
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.updateType != null)
         {
            this.updateType = param2.updateType;
         }
      }
      
      public function toObject() : Object
      {
         return {
            "bean":this.bean.toObject(),
            "castleId":this.castleId,
            "updateType":this.updateType
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- CastleFieldUpdate ----\n";
         if(this.bean != null)
         {
            _loc2_ += this.bean.toDebugString(param1 + "bean.");
         }
         else
         {
            _loc2_ += param1 + "bean = null\n";
         }
         _loc2_ += param1 + "castleId = " + this.castleId + "\n";
         return _loc2_ + (param1 + "updateType = " + this.updateType + "\n");
      }
      
      public function copyTo(param1:CastleFieldUpdate) : void
      {
         if(this.bean != null)
         {
            this.bean.copyTo(param1.bean);
         }
         else
         {
            param1.bean = null;
         }
         param1.castleId = this.castleId;
         param1.updateType = this.updateType;
      }
   }
}

