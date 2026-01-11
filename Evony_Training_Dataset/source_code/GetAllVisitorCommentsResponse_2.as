package com.evony.common.module.visit
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class GetAllVisitorCommentsResponse extends BaseBean
   {
      public var msg:String;
      
      public var total:int;
      
      public var packageId:Number;
      
      public var totalPage:int;
      
      public var commentBeansArray:ArrayCollection;
      
      public var pageNo:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function GetAllVisitorCommentsResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.commentBeansArray = new ArrayCollection();
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
         if(param2.total != null)
         {
            this.total = param2.total;
         }
         if(param2.totalPage != null)
         {
            this.totalPage = param2.totalPage;
         }
         if(param2.commentBeans)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.commentBeans.length)
            {
               _loc6_ = new VisitorCommentBean(param2.commentBeans[_loc5_]);
               this.commentBeansArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function setCommentBeans(param1:VisitorCommentBean, param2:int) : void
      {
         this.commentBeansArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- GetAllVisitorCommentsResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc3_ += param1 + "pageNo = " + this.pageNo + "\n";
         _loc3_ += param1 + "total = " + this.total + "\n";
         _loc3_ += param1 + "totalPage = " + this.totalPage + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.commentBeansArray.length)
         {
            _loc3_ += this.getCommentBeans(_loc2_).toDebugString(param1 + "commentBeans[" + _loc2_ + "].");
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function copyTo(param1:GetAllVisitorCommentsResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.pageNo = this.pageNo;
         param1.total = this.total;
         param1.totalPage = this.totalPage;
         CommonUtil.arrayCopy(this.commentBeansArray,param1.commentBeansArray);
      }
      
      public function getCommentBeans(param1:int) : VisitorCommentBean
      {
         return this.commentBeansArray[param1] as VisitorCommentBean;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.pageNo = this.pageNo;
         _loc1_.total = this.total;
         _loc1_.totalPage = this.totalPage;
         return _loc1_;
      }
   }
}

