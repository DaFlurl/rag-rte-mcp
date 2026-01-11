package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class SetShowInfro implements IEventDispatcher
   {
      private var _295839282selectshowheroid:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function SetShowInfro(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.selectshowheroid != null)
            {
               this.selectshowheroid = param1.selectshowheroid;
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
         var _loc2_:String = "";
         return _loc2_ + (param1 + "selectshowheroid = " + this.selectshowheroid + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get selectshowheroid() : int
      {
         return this._295839282selectshowheroid;
      }
      
      public function copyTo(param1:SetShowInfro) : void
      {
         param1.selectshowheroid = this.selectshowheroid;
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.selectshowheroid = this.selectshowheroid;
         return _loc1_;
      }
      
      public function set selectshowheroid(param1:int) : void
      {
         var _loc2_:Object = this._295839282selectshowheroid;
         if(_loc2_ !== param1)
         {
            this._295839282selectshowheroid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selectshowheroid",_loc2_,param1));
         }
      }
   }
}

