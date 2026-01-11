package com.evony.common.module.common
{
   import com.evony.common.*;
   
   public class GetRelationshipRespone extends BaseBean
   {
      
      public var msg:String;
      
      public var declaredWarStatus:int;
      
      public var packageId:Number;
      
      public var freshman:Boolean;
      
      public var allianceRelation:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var canDeclaredWar:Boolean;
      
      public function GetRelationshipRespone(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.allianceRelation != null)
         {
            this.allianceRelation = param2.allianceRelation;
         }
         if(param2.declaredWarStatus != null)
         {
            this.declaredWarStatus = param2.declaredWarStatus;
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
         if(param2.canDeclaredWar != null)
         {
            this.canDeclaredWar = param2.canDeclaredWar;
         }
         if(param2.freshman != null)
         {
            this.freshman = param2.freshman;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- GetRelationshipRespone ----\n";
         _loc3_ += param1 + "allianceRelation = " + this.allianceRelation + "\n";
         _loc3_ += param1 + "declaredWarStatus = " + this.declaredWarStatus + "\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc3_ += param1 + "canDeclaredWar = " + this.canDeclaredWar + "\n";
         return _loc3_ + (param1 + "freshman = " + this.freshman + "\n");
      }
      
      public function copyTo(param1:GetRelationshipRespone) : void
      {
         param1.allianceRelation = this.allianceRelation;
         param1.declaredWarStatus = this.declaredWarStatus;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.canDeclaredWar = this.canDeclaredWar;
         param1.freshman = this.freshman;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.allianceRelation = this.allianceRelation;
         _loc1_.declaredWarStatus = this.declaredWarStatus;
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.canDeclaredWar = this.canDeclaredWar;
         _loc1_.freshman = this.freshman;
         return _loc1_;
      }
   }
}

