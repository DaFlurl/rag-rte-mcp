package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class TVmsgBean implements IEventDispatcher
   {
      
      private var _108417msg:String;
      
      private var _3560141time:Number;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function TVmsgBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.msg != null)
            {
               this.msg = param1.msg;
            }
            if(param1.time != null)
            {
               this.time = param1.time;
            }
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get msg() : String
      {
         return this._108417msg;
      }
      
      public function set msg(param1:String) : void
      {
         var _loc2_:Object = this._108417msg;
         if(_loc2_ !== param1)
         {
            this._108417msg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"msg",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
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
      
      public function copyTo(param1:TVmsgBean) : void
      {
         param1.msg = this.msg;
         param1.time = this.time;
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
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         return _loc2_ + (param1 + "time = " + this.time + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.msg = this.msg;
         _loc1_.time = this.time;
         return _loc1_;
      }
   }
}

