package com.evony.common.module.rank
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class TopVotesPlayersResponse extends BaseBean
   {
      public var errorMsg:String;
      
      public var msg:String;
      
      public var beansArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var ok:int;
      
      public function TopVotesPlayersResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.beansArray = new ArrayCollection();
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
         if(param2.beans)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.beans.length)
            {
               _loc6_ = new PlayerInfoBean(param2.beans[_loc5_]);
               this.beansArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function setBeans(param1:PlayerInfoBean, param2:int) : void
      {
         this.beansArray[param2] = param1;
      }
      
      public function getBeans(param1:int) : PlayerInfoBean
      {
         return this.beansArray[param1] as PlayerInfoBean;
      }
      
      public function copyTo(param1:TopVotesPlayersResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.beansArray,param1.beansArray);
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- TopVotesPlayersResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.beansArray.length)
         {
            _loc3_ += this.getBeans(_loc2_).toDebugString(param1 + "beans[" + _loc2_ + "].");
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
   }
}

