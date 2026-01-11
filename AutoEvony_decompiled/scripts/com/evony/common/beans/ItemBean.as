package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class ItemBean implements IEventDispatcher
   {
      
      private var _3355id:String;
      
      private var _3373707name:String;
      
      private var _382106123maxCount:int;
      
      private var _1394090531minCount:int;
      
      private var _94851343count:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function ItemBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.count != null)
            {
               this.count = param1.count;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.maxCount != null)
            {
               this.maxCount = param1.maxCount;
            }
            if(param1.minCount != null)
            {
               this.minCount = param1.minCount;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
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
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "count = " + this.count + "\n" + (param1 + "id = " + this.id + "\n") + (param1 + "maxCount = " + this.maxCount + "\n") + (param1 + "minCount = " + this.minCount + "\n") + (param1 + "name = " + this.name + "\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get count() : int
      {
         return this._94851343count;
      }
      
      public function copyTo(param1:ItemBean) : void
      {
         param1.count = this.count;
         param1.id = this.id;
         param1.maxCount = this.maxCount;
         param1.minCount = this.minCount;
         param1.name = this.name;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get maxCount() : int
      {
         return this._382106123maxCount;
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:Object = this._3373707name;
         if(_loc2_ !== param1)
         {
            this._3373707name = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"name",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "count":this.count,
            "id":this.id,
            "maxCount":this.maxCount,
            "minCount":this.minCount,
            "name":this.name
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : String
      {
         return this._3355id;
      }
      
      [Bindable(event="propertyChange")]
      public function get minCount() : int
      {
         return this._1394090531minCount;
      }
      
      public function set count(param1:int) : void
      {
         var _loc2_:Object = this._94851343count;
         if(_loc2_ !== param1)
         {
            this._94851343count = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"count",_loc2_,param1));
         }
      }
      
      public function set id(param1:String) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      public function set maxCount(param1:int) : void
      {
         var _loc2_:Object = this._382106123maxCount;
         if(_loc2_ !== param1)
         {
            this._382106123maxCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maxCount",_loc2_,param1));
         }
      }
      
      public function set minCount(param1:int) : void
      {
         var _loc2_:Object = this._1394090531minCount;
         if(_loc2_ !== param1)
         {
            this._1394090531minCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"minCount",_loc2_,param1));
         }
      }
   }
}

