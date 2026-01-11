package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class SaleTypeBean implements IEventDispatcher
   {
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _100526016items:String;
      
      private var _676507419typeName:String;
      
      public function SaleTypeBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.items != null)
            {
               this.items = param1.items;
            }
            if(param1.typeName != null)
            {
               this.typeName = param1.typeName;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get items() : String
      {
         return this._100526016items;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get typeName() : String
      {
         return this._676507419typeName;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set items(param1:String) : void
      {
         var _loc2_:Object = this._100526016items;
         if(_loc2_ !== param1)
         {
            this._100526016items = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"items",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "items = " + this.items + "\n";
         return _loc2_ + (param1 + "typeName = " + this.typeName + "\n");
      }
      
      public function set typeName(param1:String) : void
      {
         var _loc2_:Object = this._676507419typeName;
         if(_loc2_ !== param1)
         {
            this._676507419typeName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"typeName",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function copyTo(param1:SaleTypeBean) : void
      {
         param1.items = this.items;
         param1.typeName = this.typeName;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.items = this.items;
         _loc1_.typeName = this.typeName;
         return _loc1_;
      }
   }
}

