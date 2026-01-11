package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class GemStoneBean implements IEventDispatcher
   {
      
      private var _1826952687gemstoneid:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function GemStoneBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.gemstoneid != null)
            {
               this.gemstoneid = param1.gemstoneid;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function set gemstoneid(param1:String) : void
      {
         var _loc2_:Object = this._1826952687gemstoneid;
         if(_loc2_ !== param1)
         {
            this._1826952687gemstoneid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gemstoneid",_loc2_,param1));
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
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "gemstoneid = " + this.gemstoneid + "\n";
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function copyTo(param1:GemStoneBean) : void
      {
         param1.gemstoneid = this.gemstoneid;
      }
      
      [Bindable(event="propertyChange")]
      public function get gemstoneid() : String
      {
         return this._1826952687gemstoneid;
      }
      
      public function toObject() : Object
      {
         return {"gemstoneid":this.gemstoneid};
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
   }
}

