package com.evony.common.module.army
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   
   public class ArmyPracticeResponse extends BaseBean
   {
      
      public static const ARMY_PRACTICE_RESULT_GUARD_WIN:int = -1;
      
      public static const ARMY_PRACTICE_RESULT_ATTACK_WIN:int = 1;
      
      public var packageId:Number;
      
      public var attackLostTroop:TroopBean;
      
      public var msg:String;
      
      public var round:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var result:int;
      
      public var defendLostTroop:TroopBean;
      
      public function ArmyPracticeResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.attackLostTroop != null)
         {
            this.attackLostTroop = new TroopBean(param2.attackLostTroop);
         }
         if(param2.defendLostTroop != null)
         {
            this.defendLostTroop = new TroopBean(param2.defendLostTroop);
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
         if(param2.result != null)
         {
            this.result = param2.result;
         }
         if(param2.round != null)
         {
            this.round = param2.round;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- ArmyPracticeResponse ----\n";
         if(this.attackLostTroop != null)
         {
            _loc3_ += this.attackLostTroop.toDebugString(param1 + "attackLostTroop.");
         }
         else
         {
            _loc3_ += param1 + "attackLostTroop = null\n";
         }
         if(this.defendLostTroop != null)
         {
            _loc3_ += this.defendLostTroop.toDebugString(param1 + "defendLostTroop.");
         }
         else
         {
            _loc3_ += param1 + "defendLostTroop = null\n";
         }
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc3_ += param1 + "result = " + this.result + "\n";
         return _loc3_ + (param1 + "round = " + this.round + "\n");
      }
      
      public function copyTo(param1:ArmyPracticeResponse) : void
      {
         if(this.attackLostTroop != null)
         {
            this.attackLostTroop.copyTo(param1.attackLostTroop);
         }
         else
         {
            param1.attackLostTroop = null;
         }
         if(this.defendLostTroop != null)
         {
            this.defendLostTroop.copyTo(param1.defendLostTroop);
         }
         else
         {
            param1.defendLostTroop = null;
         }
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.result = this.result;
         param1.round = this.round;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.attackLostTroop = this.attackLostTroop.toObject();
         _loc1_.defendLostTroop = this.defendLostTroop.toObject();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.result = this.result;
         _loc1_.round = this.round;
         return _loc1_;
      }
   }
}

