package com.evony.common.module.rank
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.RankHeroBean;
   import mx.collections.ArrayCollection;
   
   public class RankHeroResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var pageNo:int;
      
      public var totalPage:int;
      
      public var beansArray:ArrayCollection;
      
      public var pageSize:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function RankHeroResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:RankHeroBean = null;
         var _loc6_:int = 0;
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
         if(param2.totalPage != null)
         {
            this.totalPage = param2.totalPage;
         }
         if(param2.beans)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.beans.length)
            {
               _loc5_ = new RankHeroBean(param2.beans[_loc6_]);
               this.beansArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setBeans(param1:RankHeroBean, param2:int) : void
      {
         this.beansArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- RankHeroResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         _loc2_ += param1 + "pageNo = " + this.pageNo + "\n";
         _loc2_ += param1 + "pageSize = " + this.pageSize + "\n";
         _loc2_ += param1 + "totalPage = " + this.totalPage + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.beansArray.length)
         {
            _loc2_ += this.getBeans(_loc3_).toDebugString(param1 + "beansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBeans(param1:int) : RankHeroBean
      {
         return this.beansArray[param1] as RankHeroBean;
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.pageNo = this.pageNo;
         _loc1_.pageSize = this.pageSize;
         _loc1_.totalPage = this.totalPage;
         return _loc1_;
      }
      
      public function copyTo(param1:RankHeroResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.pageNo = this.pageNo;
         param1.pageSize = this.pageSize;
         param1.totalPage = this.totalPage;
         CommonUtil.arrayCopy(this.beansArray,param1.beansArray);
      }
   }
}

