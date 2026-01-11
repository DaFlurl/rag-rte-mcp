package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class AllianceEvent implements IEventDispatcher
   {
      private var _3560141time:Number;
      
      private var _31228997eventName:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function AllianceEvent(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.eventName != null)
            {
               this.eventName = param1.eventName;
            }
            if(param1.time != null)
            {
               this.time = param1.time;
            }
         }
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.eventName = this.eventName;
         _loc1_.time = this.time;
         return _loc1_;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get eventName() : String
      {
         return this._31228997eventName;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set eventName(param1:String) : void
      {
         var _loc2_:Object = this._31228997eventName;
         if(_loc2_ !== param1)
         {
            this._31228997eventName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"eventName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get time() : Number
      {
         return this._3560141time;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function copyTo(param1:AllianceEvent) : void
      {
         param1.eventName = this.eventName;
         param1.time = this.time;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "eventName = " + this.eventName + "\n";
         return _loc2_ + (param1 + "time = " + this.time + "\n");
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
   }
}

