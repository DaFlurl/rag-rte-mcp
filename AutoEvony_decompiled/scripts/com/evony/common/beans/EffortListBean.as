package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class EffortListBean implements IEventDispatcher
   {
      
      private var _275227512effortListInfo:String;
      
      private var _873324063effortTypeid:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function EffortListBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.effortListInfo != null)
            {
               this.effortListInfo = param1.effortListInfo;
            }
            if(param1.effortTypeid != null)
            {
               this.effortTypeid = param1.effortTypeid;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get effortTypeid() : int
      {
         return this._873324063effortTypeid;
      }
      
      public function set effortTypeid(param1:int) : void
      {
         var _loc2_:Object = this._873324063effortTypeid;
         if(_loc2_ !== param1)
         {
            this._873324063effortTypeid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effortTypeid",_loc2_,param1));
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
         return param1 + "effortListInfo = " + this.effortListInfo + "\n" + (param1 + "effortTypeid = " + this.effortTypeid + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set effortListInfo(param1:String) : void
      {
         var _loc2_:Object = this._275227512effortListInfo;
         if(_loc2_ !== param1)
         {
            this._275227512effortListInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effortListInfo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get effortListInfo() : String
      {
         return this._275227512effortListInfo;
      }
      
      public function toObject() : Object
      {
         return {
            "effortListInfo":this.effortListInfo,
            "effortTypeid":this.effortTypeid
         };
      }
      
      public function copyTo(param1:EffortListBean) : void
      {
         param1.effortListInfo = this.effortListInfo;
         param1.effortTypeid = this.effortTypeid;
      }
   }
}

