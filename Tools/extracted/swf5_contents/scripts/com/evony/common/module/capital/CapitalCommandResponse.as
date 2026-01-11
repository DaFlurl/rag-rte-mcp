package com.evony.common.module.capital
{
   import com.evony.common.*;
   
   public class CapitalCommandResponse extends BaseBean
   {
      public var errorMsg:String;
      
      public var packageId:Number;
      
      public var targetFieldId:int;
      
      public var castleId:int;
      
      public var armyType:String;
      
      public var amount:int;
      
      public var msg:String;
      
      public var ok:int;
      
      public function CapitalCommandResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.amount != null)
         {
            this.amount = param2.amount;
         }
         if(param2.armyType != null)
         {
            this.armyType = param2.armyType;
         }
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.ok != null)
         {
            this.ok = param2.ok;
         }
         if(param2.packageId != null)
         {
            this.packageId = param2.packageId;
         }
         if(param2.targetFieldId != null)
         {
            this.targetFieldId = param2.targetFieldId;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- CapitalCommandResponse ----\n";
         _loc2_ += param1 + "amount = " + this.amount + "\n";
         _loc2_ += param1 + "armyType = " + this.armyType + "\n";
         _loc2_ += param1 + "castleId = " + this.castleId + "\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         return _loc2_ + (param1 + "targetFieldId = " + this.targetFieldId + "\n");
      }
      
      public function copyTo(param1:CapitalCommandResponse) : void
      {
         param1.amount = this.amount;
         param1.armyType = this.armyType;
         param1.castleId = this.castleId;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.targetFieldId = this.targetFieldId;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.amount = this.amount;
         _loc1_.armyType = this.armyType;
         _loc1_.castleId = this.castleId;
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.targetFieldId = this.targetFieldId;
         return _loc1_;
      }
   }
}

