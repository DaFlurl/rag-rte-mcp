package com.evony.common.module.city
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class StoreListResponse extends BaseBean
   {
      public var msg:String;
      
      public var packageId:Number;
      
      public var totalCap:int;
      
      public var storeBeansArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function StoreListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.storeBeansArray = new ArrayCollection();
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
         if(param2.totalCap != null)
         {
            this.totalCap = param2.totalCap;
         }
         if(param2.storeBeans)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.storeBeans.length)
            {
               _loc6_ = new StoreBean(param2.storeBeans[_loc5_]);
               this.storeBeansArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function setStoreBeans(param1:StoreBean, param2:int) : void
      {
         this.storeBeansArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- StoreListResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc3_ += param1 + "totalCap = " + this.totalCap + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.storeBeansArray.length)
         {
            _loc3_ += this.getStoreBeans(_loc2_).toDebugString(param1 + "storeBeans[" + _loc2_ + "].");
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function copyTo(param1:StoreListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.totalCap = this.totalCap;
         CommonUtil.arrayCopy(this.storeBeansArray,param1.storeBeansArray);
      }
      
      public function getStoreBeans(param1:int) : StoreBean
      {
         return this.storeBeansArray[param1] as StoreBean;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.totalCap = this.totalCap;
         return _loc1_;
      }
   }
}

