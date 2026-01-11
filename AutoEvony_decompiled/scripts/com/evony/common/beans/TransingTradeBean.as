package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class TransingTradeBean implements IEventDispatcher
   {
      
      private var _3355id:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1607243192endTime:Number;
      
      private var _384566343resourceName:String;
      
      private var _106934601price:Number;
      
      private var _110549828total:int;
      
      private var _1413853096amount:int;
      
      private var _1096575994resType:int;
      
      public function TransingTradeBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.amount != null)
            {
               this.amount = param1.amount;
            }
            if(param1.endTime != null)
            {
               this.endTime = param1.endTime;
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
            if(param1.total != null)
            {
               this.total = param1.total;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get endTime() : Number
      {
         return this._1607243192endTime;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "amount = " + this.amount + "\n" + (param1 + "endTime = " + this.endTime + "\n") + (param1 + "id = " + this.id + "\n") + (param1 + "price = " + this.price + "\n") + (param1 + "resType = " + this.resType + "\n") + (param1 + "resourceName = " + this.resourceName + "\n") + (param1 + "total = " + this.total + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get total() : int
      {
         return this._110549828total;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:TransingTradeBean) : void
      {
         param1.amount = this.amount;
         param1.endTime = this.endTime;
         param1.id = this.id;
         param1.price = this.price;
         param1.resType = this.resType;
         param1.resourceName = this.resourceName;
         param1.total = this.total;
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
      
      public function set endTime(param1:Number) : void
      {
         var _loc2_:Object = this._1607243192endTime;
         if(_loc2_ !== param1)
         {
            this._1607243192endTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get amount() : int
      {
         return this._1413853096amount;
      }
      
      public function toObject() : Object
      {
         return {
            "amount":this.amount,
            "endTime":this.endTime,
            "id":this.id,
            "price":this.price,
            "resType":this.resType,
            "resourceName":this.resourceName,
            "total":this.total
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      [Bindable(event="propertyChange")]
      public function get resType() : int
      {
         return this._1096575994resType;
      }
      
      public function set total(param1:int) : void
      {
         var _loc2_:Object = this._110549828total;
         if(_loc2_ !== param1)
         {
            this._110549828total = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"total",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get price() : Number
      {
         return this._106934601price;
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
      
      public function set resourceName(param1:String) : void
      {
         var _loc2_:Object = this._384566343resourceName;
         if(_loc2_ !== param1)
         {
            this._384566343resourceName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resourceName",_loc2_,param1));
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
      
      public function set resType(param1:int) : void
      {
         var _loc2_:Object = this._1096575994resType;
         if(_loc2_ !== param1)
         {
            this._1096575994resType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resType",_loc2_,param1));
         }
      }
   }
}

