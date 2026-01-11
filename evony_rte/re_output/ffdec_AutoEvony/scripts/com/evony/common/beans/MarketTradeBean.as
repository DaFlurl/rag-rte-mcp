package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class MarketTradeBean implements IEventDispatcher
   {
      
      private var _1413853096amount:int;
      
      private var _106934601price:Number;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function MarketTradeBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.amount != null)
            {
               this.amount = param1.amount;
            }
            if(param1.price != null)
            {
               this.price = param1.price;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toObject() : Object
      {
         return {
            "amount":this.amount,
            "price":this.price
         };
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get price() : Number
      {
         return this._106934601price;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:MarketTradeBean) : void
      {
         param1.amount = this.amount;
         param1.price = this.price;
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
      
      public function set amount(param1:int) : void
      {
         var _loc2_:Object = this._1413853096amount;
         if(_loc2_ !== param1)
         {
            this._1413853096amount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"amount",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "amount = " + this.amount + "\n" + (param1 + "price = " + this.price + "\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get amount() : int
      {
         return this._1413853096amount;
      }
   }
}

