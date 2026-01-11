package com.evony.common.module.shop
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.GamblingItemBean;
   import com.evony.common.beans.ItemBean;
   import mx.collections.ArrayCollection;
   
   public class UseItemResultResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var itemBeansArray:ArrayCollection;
      
      public var gamblingItemsBeansArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function UseItemResultResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc6_:GamblingItemBean = null;
         var _loc7_:ItemBean = null;
         this.gamblingItemsBeansArray = new ArrayCollection();
         this.itemBeansArray = new ArrayCollection();
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
         var _loc5_:int = 0;
         if(param2.gamblingItemsBeans)
         {
            _loc6_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.gamblingItemsBeans.length)
            {
               _loc6_ = new GamblingItemBean(param2.gamblingItemsBeans[_loc5_]);
               this.gamblingItemsBeansArray.addItem(_loc6_);
               _loc5_++;
            }
         }
         if(param2.itemBeans)
         {
            _loc7_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.itemBeans.length)
            {
               _loc7_ = new ItemBean(param2.itemBeans[_loc5_]);
               this.itemBeansArray.addItem(_loc7_);
               _loc5_++;
            }
         }
      }
      
      public function getItemBeans(param1:int) : ItemBean
      {
         return this.itemBeansArray[param1] as ItemBean;
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- UseItemResultResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.gamblingItemsBeansArray.length)
         {
            _loc2_ += this.getGamblingItemsBeans(_loc3_).toDebugString(param1 + "gamblingItemsBeans[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.itemBeansArray.length)
         {
            _loc2_ += this.getItemBeans(_loc3_).toDebugString(param1 + "itemBeans[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function setGamblingItemsBeans(param1:GamblingItemBean, param2:int) : void
      {
         this.gamblingItemsBeansArray[param2] = param1;
      }
      
      public function setItemBeans(param1:ItemBean, param2:int) : void
      {
         this.itemBeansArray[param2] = param1;
      }
      
      public function copyTo(param1:UseItemResultResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.gamblingItemsBeansArray,param1.gamblingItemsBeansArray);
         CommonUtil.arrayCopy(this.itemBeansArray,param1.itemBeansArray);
      }
      
      public function getGamblingItemsBeans(param1:int) : GamblingItemBean
      {
         return this.gamblingItemsBeansArray[param1] as GamblingItemBean;
      }
   }
}

