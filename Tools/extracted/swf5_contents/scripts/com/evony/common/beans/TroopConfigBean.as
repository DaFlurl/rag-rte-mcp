package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class TroopConfigBean implements IEventDispatcher
   {
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _391817972orderList:String;
      
      private var _3560141time:Number;
      
      private var _110634834troop:TroopBean;
      
      public function TroopConfigBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.name != null)
            {
               this.orderList = param1.name;
            }
            if(param1.time != null)
            {
               this.time = param1.time;
            }
            if(param1.troop != null)
            {
               this.troop = new TroopBean(param1.troop);
            }
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "name = " + this.orderList + "\n" + (param1 + "time = " + this.time + "\n") + (this.troop != null ? this.troop.toDebugString(param1 + "troop.") : param1 + "troop = null\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get orderList() : String
      {
         return this._391817972orderList;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function copyTo(param1:TroopConfigBean) : void
      {
         param1.orderList = this.orderList;
         param1.time = this.time;
         if(this.troop != null)
         {
            this.troop.copyTo(param1.troop);
         }
         else
         {
            param1.troop = null;
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get troop() : TroopBean
      {
         return this._110634834troop;
      }
      
      [Bindable(event="propertyChange")]
      public function get time() : Number
      {
         return this._3560141time;
      }
      
      public function set orderList(param1:String) : void
      {
         var _loc2_:Object = this._391817972orderList;
         if(_loc2_ !== param1)
         {
            this._391817972orderList = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"orderList",_loc2_,param1));
         }
      }
      
      public function set time(param1:Number) : void
      {
         var _loc2_:Object = this._3560141time;
         if(_loc2_ !== param1)
         {
            this._3560141time = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"time",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function toObject() : Object
      {
         return {
            "name":this.orderList,
            "time":this.time,
            "troop":this.troop.toObject()
         };
      }
      
      public function set troop(param1:TroopBean) : void
      {
         var _loc2_:Object = this._110634834troop;
         if(_loc2_ !== param1)
         {
            this._110634834troop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troop",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}

