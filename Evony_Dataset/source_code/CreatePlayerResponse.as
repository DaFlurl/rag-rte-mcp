package com.evony.common.module.common
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   
   public class CreatePlayerResponse extends BaseBean
   {
      public static const CREATE_RESULT_HAVE_CREATED:int = -3;
      
      public static const CREATE_RESULT_ZONE_FULL:int = -2;
      
      public static const CREATE_RESULT_NAME_DUP:int = -1;
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var player:PlayerBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function CreatePlayerResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
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
         if(param2.player != null)
         {
            this.player = new PlayerBean(param2.player);
         }
      }
      
      public function copyTo(param1:CreatePlayerResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         if(this.player != null)
         {
            this.player.copyTo(param1.player);
         }
         else
         {
            param1.player = null;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- CreatePlayerResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         if(this.player != null)
         {
            _loc3_ += this.player.toDebugString(param1 + "player.");
         }
         else
         {
            _loc3_ += param1 + "player = null\n";
         }
         return _loc3_;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.player = this.player.toObject();
         return _loc1_;
      }
   }
}

