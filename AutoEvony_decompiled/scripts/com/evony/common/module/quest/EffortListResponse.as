package com.evony.common.module.quest
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class EffortListResponse extends BaseBean
   {
      
      public var errorMsg:String;
      
      public var msg:String;
      
      public var ok:int;
      
      public var effortpoint:String;
      
      public var effortcomplete:String;
      
      public var packageId:Number;
      
      public var effortlistbeanArray:ArrayCollection;
      
      public function EffortListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.effortlistbeanArray = new ArrayCollection();
         super(param1,param3,param4);
         if(param2.effortcomplete != null)
         {
            this.effortcomplete = param2.effortcomplete;
         }
         if(param2.effortpoint != null)
         {
            this.effortpoint = param2.effortpoint;
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
         if(param2.effortlistbean)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.effortlistbean.length)
            {
               _loc6_ = new EffortListBean(param2.effortlistbean[_loc5_]);
               this.effortlistbeanArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- EffortListResponse ----\n";
         _loc3_ += param1 + "effortcomplete = " + this.effortcomplete + "\n";
         _loc3_ += param1 + "effortpoint = " + this.effortpoint + "\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.effortlistbeanArray.length)
         {
            _loc3_ += this.getEffortlistbean(_loc2_).toDebugString(param1 + "effortlistbean[" + _loc2_ + "].");
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function getEffortlistbean(param1:int) : EffortListBean
      {
         return this.effortlistbeanArray[param1] as EffortListBean;
      }
      
      public function copyTo(param1:EffortListResponse) : void
      {
         param1.effortcomplete = this.effortcomplete;
         param1.effortpoint = this.effortpoint;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.effortlistbeanArray,param1.effortlistbeanArray);
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.effortcomplete = this.effortcomplete;
         _loc1_.effortpoint = this.effortpoint;
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
      
      public function setEffortlistbean(param1:EffortListBean, param2:int) : void
      {
         this.effortlistbeanArray[param2] = param1;
      }
   }
}

