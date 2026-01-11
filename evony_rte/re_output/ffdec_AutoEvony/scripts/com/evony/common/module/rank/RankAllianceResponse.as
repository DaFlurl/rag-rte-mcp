package com.evony.common.module.rank
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.RankAllianceBean;
   import mx.collections.ArrayCollection;
   
   public class RankAllianceResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var pageNo:int;
      
      public var totalPage:int;
      
      public var beansArray:ArrayCollection;
      
      public var pageSize:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function RankAllianceResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:RankAllianceBean = null;
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
               _loc5_ = new RankAllianceBean(param2.beans[_loc6_]);
               this.beansArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setBeans(param1:RankAllianceBean, param2:int) : void
      {
         this.beansArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- RankAllianceResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "pageNo = " + this.pageNo + "\n") + (param1 + "pageSize = " + this.pageSize + "\n") + (param1 + "totalPage = " + this.totalPage + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.beansArray.length)
         {
            _loc2_ += this.getBeans(_loc3_).toDebugString(param1 + "beans[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBeans(param1:int) : RankAllianceBean
      {
         return this.beansArray[param1] as RankAllianceBean;
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "pageNo":this.pageNo,
            "pageSize":this.pageSize,
            "totalPage":this.totalPage
         };
      }
      
      public function copyTo(param1:RankAllianceResponse) : void
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

