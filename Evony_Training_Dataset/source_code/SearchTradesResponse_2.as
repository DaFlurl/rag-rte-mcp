package com.evony.common.module.trade
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class SearchTradesResponse extends BaseBean
   {
      public var buyersArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var sellersArray:ArrayCollection;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function SearchTradesResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         this.buyersArray = new ArrayCollection();
         this.sellersArray = new ArrayCollection();
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
         if(param2.buyers)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.buyers.length)
            {
               _loc6_ = new MarketTradeBean(param2.buyers[_loc5_]);
               this.buyersArray.addItem(_loc6_);
               _loc5_++;
            }
         }
         if(param2.sellers)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.sellers.length)
            {
               _loc7_ = new MarketTradeBean(param2.sellers[_loc5_]);
               this.sellersArray.addItem(_loc7_);
               _loc5_++;
            }
         }
      }
      
      public function setBuyers(param1:MarketTradeBean, param2:int) : void
      {
         this.buyersArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- SearchTradesResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.buyersArray.length)
         {
            _loc3_ += this.getBuyers(_loc2_).toDebugString(param1 + "buyers[" + _loc2_ + "].");
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.sellersArray.length)
         {
            _loc3_ += this.getSellers(_loc2_).toDebugString(param1 + "sellers[" + _loc2_ + "].");
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function copyTo(param1:SearchTradesResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.buyersArray,param1.buyersArray);
         CommonUtil.arrayCopy(this.sellersArray,param1.sellersArray);
      }
      
      public function setSellers(param1:MarketTradeBean, param2:int) : void
      {
         this.sellersArray[param2] = param1;
      }
      
      public function getBuyers(param1:int) : MarketTradeBean
      {
         return this.buyersArray[param1] as MarketTradeBean;
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
      
      public function getSellers(param1:int) : MarketTradeBean
      {
         return this.sellersArray[param1] as MarketTradeBean;
      }
   }
}

