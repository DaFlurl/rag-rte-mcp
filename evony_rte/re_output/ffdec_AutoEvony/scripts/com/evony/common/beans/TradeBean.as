package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class TradeBean implements IEventDispatcher
   {
      
      private var _384566343resourceName:String;
      
      private var _106934601price:Number;
      
      private var _1413853096amount:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _3355id:int;
      
      private var _752919230tradeType:int;
      
      private var _1302723991tradeTypeName:String;
      
      private var _147397053dealedAmount:int;
      
      private var _428497913dealedTotal:Number;
      
      private var _1096575994resType:int;
      
      public function TradeBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.amount != null)
            {
               this.amount = param1.amount;
            }
            if(param1.dealedAmount != null)
            {
               this.dealedAmount = param1.dealedAmount;
            }
            if(param1.dealedTotal != null)
            {
               this.dealedTotal = param1.dealedTotal;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.price != null)
            {
               this.price = param1.price;
            }
            if(param1.resType != null)
            {
               this.resType = param1.resType;
            }
            if(param1.resourceName != null)
            {
               this.resourceName = param1.resourceName;
            }
            if(param1.tradeType != null)
            {
               this.tradeType = param1.tradeType;
            }
            if(param1.tradeTypeName != null)
            {
               this.tradeTypeName = param1.tradeTypeName;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dealedTotal() : Number
      {
         return this._428497913dealedTotal;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set dealedAmount(param1:int) : void
      {
         var _loc2_:Object = this._147397053dealedAmount;
         if(_loc2_ !== param1)
         {
            this._147397053dealedAmount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dealedAmount",_loc2_,param1));
         }
      }
      
      public function set price(param1:Number) : void
      {
         var _loc2_:Object = this._106934601price;
         if(_loc2_ !== param1)
         {
            this._106934601price = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"price",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toObject() : Object
      {
         return {
            "amount":this.amount,
            "dealedAmount":this.dealedAmount,
            "dealedTotal":this.dealedTotal,
            "id":this.id,
            "price":this.price,
            "resType":this.resType,
            "resourceName":this.resourceName,
            "tradeType":this.tradeType,
            "tradeTypeName":this.tradeTypeName
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function set amount(param1:int) : void
      {
         var _loc2_:Object = this._1413853096amount;
         if(_loc2_ !== param1)
         {
            this._1413853096amount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"amount",_loc2_,param1));
         }
      }
      
      public function set id(param1:int) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get resourceName() : String
      {
         return this._384566343resourceName;
      }
      
      [Bindable(event="propertyChange")]
      public function get tradeType() : int
      {
         return this._752919230tradeType;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get dealedAmount() : int
      {
         return this._147397053dealedAmount;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "amount = " + this.amount + "\n" + (param1 + "dealedAmount = " + this.dealedAmount + "\n") + (param1 + "dealedTotal = " + this.dealedTotal + "\n") + (param1 + "id = " + this.id + "\n") + (param1 + "price = " + this.price + "\n") + (param1 + "resType = " + this.resType + "\n") + (param1 + "resourceName = " + this.resourceName + "\n") + (param1 + "tradeType = " + this.tradeType + "\n") + (param1 + "tradeTypeName = " + this.tradeTypeName + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function copyTo(param1:TradeBean) : void
      {
         param1.amount = this.amount;
         param1.dealedAmount = this.dealedAmount;
         param1.dealedTotal = this.dealedTotal;
         param1.id = this.id;
         param1.price = this.price;
         param1.resType = this.resType;
         param1.resourceName = this.resourceName;
         param1.tradeType = this.tradeType;
         param1.tradeTypeName = this.tradeTypeName;
      }
      
      public function set tradeTypeName(param1:String) : void
      {
         var _loc2_:Object = this._1302723991tradeTypeName;
         if(_loc2_ !== param1)
         {
            this._1302723991tradeTypeName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tradeTypeName",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get price() : Number
      {
         return this._106934601price;
      }
      
      [Bindable(event="propertyChange")]
      public function get amount() : int
      {
         return this._1413853096amount;
      }
      
      [Bindable(event="propertyChange")]
      public function get tradeTypeName() : String
      {
         return this._1302723991tradeTypeName;
      }
      
      public function set resourceName(param1:String) : void
      {
         var _loc2_:Object = this._384566343resourceName;
         if(_loc2_ !== param1)
         {
            this._384566343resourceName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resourceName",_loc2_,param1));
         }
      }
      
      public function set dealedTotal(param1:Number) : void
      {
         var _loc2_:Object = this._428497913dealedTotal;
         if(_loc2_ !== param1)
         {
            this._428497913dealedTotal = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dealedTotal",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get resType() : int
      {
         return this._1096575994resType;
      }
      
      public function set resType(param1:int) : void
      {
         var _loc2_:Object = this._1096575994resType;
         if(_loc2_ !== param1)
         {
            this._1096575994resType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resType",_loc2_,param1));
         }
      }
      
      public function set tradeType(param1:int) : void
      {
         var _loc2_:Object = this._752919230tradeType;
         if(_loc2_ !== param1)
         {
            this._752919230tradeType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tradeType",_loc2_,param1));
         }
      }
   }
}

