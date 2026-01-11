package com.evony.common.module.gamblingranking
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class GamblingRankingRespone extends BaseBean
   {
      public var msg:String;
      
      public var gamblingRankingBeansArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var totalPage:int;
      
      public var pageNo:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function GamblingRankingRespone(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.gamblingRankingBeansArray = new ArrayCollection();
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
         if(param2.totalPage != null)
         {
            this.totalPage = param2.totalPage;
         }
         if(param2.gamblingRankingBeans)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.gamblingRankingBeans.length)
            {
               _loc6_ = new GamblingRankingBean(param2.gamblingRankingBeans[_loc5_]);
               this.gamblingRankingBeansArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- GamblingRankingRespone ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc3_ += param1 + "pageNo = " + this.pageNo + "\n";
         _loc3_ += param1 + "totalPage = " + this.totalPage + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.gamblingRankingBeansArray.length)
         {
            _loc3_ += this.getGamblingRankingBeans(_loc2_).toDebugString(param1 + "gamblingRankingBeans[" + _loc2_ + "].");
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function getGamblingRankingBeans(param1:int) : GamblingRankingBean
      {
         return this.gamblingRankingBeansArray[param1] as GamblingRankingBean;
      }
      
      public function copyTo(param1:GamblingRankingRespone) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.pageNo = this.pageNo;
         param1.totalPage = this.totalPage;
         CommonUtil.arrayCopy(this.gamblingRankingBeansArray,param1.gamblingRankingBeansArray);
      }
      
      public function setGamblingRankingBeans(param1:GamblingRankingBean, param2:int) : void
      {
         this.gamblingRankingBeansArray[param2] = param1;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.pageNo = this.pageNo;
         _loc1_.totalPage = this.totalPage;
         return _loc1_;
      }
   }
}

