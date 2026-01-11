package com.evony.common.module.visit
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class GetHelpedPlayersResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var ok:int;
      
      public var playersArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var errorMsg:String;
      
      public function GetHelpedPlayersResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.playersArray = new ArrayCollection();
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
         if(param2.players)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.players.length)
            {
               _loc6_ = new GetHelpedPlayerBean(param2.players[_loc5_]);
               this.playersArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function setPlayers(param1:GetHelpedPlayerBean, param2:int) : void
      {
         this.playersArray[param2] = param1;
      }
      
      public function copyTo(param1:GetHelpedPlayersResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.playersArray,param1.playersArray);
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- GetHelpedPlayersResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.playersArray.length)
         {
            _loc3_ += this.getPlayers(_loc2_).toDebugString(param1 + "players[" + _loc2_ + "].");
            _loc2_++;
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
         return _loc1_;
      }
      
      public function getPlayers(param1:int) : GetHelpedPlayerBean
      {
         return this.playersArray[param1] as GetHelpedPlayerBean;
      }
   }
}

