package com.evony.common.module.rank
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class RankPlayerVotesResponse extends BaseBean
   {
      public var preweekterm:String;
      
      public var msg:String;
      
      public var beansArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var packageId:Number;
      
      public var votestoal:Number;
      
      public var pageNo:int;
      
      public var totalPage:int;
      
      public var pageSize:int;
      
      public var voteendtime:Number;
      
      public function RankPlayerVotesResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
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
         if(param2.pageNo != null)
         {
            this.pageNo = param2.pageNo;
         }
         if(param2.pageSize != null)
         {
            this.pageSize = param2.pageSize;
         }
         if(param2.preweekterm != null)
         {
            this.preweekterm = param2.preweekterm;
         }
         if(param2.totalPage != null)
         {
            this.totalPage = param2.totalPage;
         }
         if(param2.voteendtime != null)
         {
            this.voteendtime = param2.voteendtime;
         }
         if(param2.votestoal != null)
         {
            this.votestoal = param2.votestoal;
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
      
      public function copyTo(param1:RankPlayerVotesResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.pageNo = this.pageNo;
         param1.pageSize = this.pageSize;
         param1.preweekterm = this.preweekterm;
         param1.totalPage = this.totalPage;
         param1.voteendtime = this.voteendtime;
         param1.votestoal = this.votestoal;
         CommonUtil.arrayCopy(this.beansArray,param1.beansArray);
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- RankPlayerVotesResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc3_ += param1 + "pageNo = " + this.pageNo + "\n";
         _loc3_ += param1 + "pageSize = " + this.pageSize + "\n";
         _loc3_ += param1 + "preweekterm = " + this.preweekterm + "\n";
         _loc3_ += param1 + "totalPage = " + this.totalPage + "\n";
         _loc3_ += param1 + "voteendtime = " + this.voteendtime + "\n";
         _loc3_ += param1 + "votestoal = " + this.votestoal + "\n";
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
         _loc1_.pageNo = this.pageNo;
         _loc1_.pageSize = this.pageSize;
         _loc1_.preweekterm = this.preweekterm;
         _loc1_.totalPage = this.totalPage;
         _loc1_.voteendtime = this.voteendtime;
         _loc1_.votestoal = this.votestoal;
         return _loc1_;
      }
   }
}

