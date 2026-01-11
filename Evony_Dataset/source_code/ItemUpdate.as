package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.ItemBean;
   import mx.collections.ArrayCollection;
   
   public class ItemUpdate extends BaseBean
   {
      public var itemsArray:ArrayCollection;
      
      public function ItemUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:ItemBean = null;
         var _loc6_:int = 0;
         this.itemsArray = new ArrayCollection();
         super(param1,param3,param4);
         if(param2.items)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.items.length)
            {
               _loc5_ = new ItemBean(param2.items[_loc6_]);
               this.itemsArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function copyTo(param1:ItemUpdate) : void
      {
         CommonUtil.arrayCopy(this.itemsArray,param1.itemsArray);
      }
      
      public function toObject() : Object
      {
         return {};
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- ItemUpdate ----\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.itemsArray.length)
         {
            _loc2_ += this.getItems(_loc3_).toDebugString(param1 + "items[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getItems(param1:int) : ItemBean
      {
         return this.itemsArray[param1] as ItemBean;
      }
      
      public function setItems(param1:ItemBean, param2:int) : void
      {
         this.itemsArray[param2] = param1;
      }
   }
}

