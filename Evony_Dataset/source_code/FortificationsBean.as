package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class FortificationsBean implements IEventDispatcher
   {
      private var _3568429trap:int;
      
      private var _1739874176arrowTower:int;
      
      private var _518185888rockfall:int;
      
      private var _226523540rollingLogs:int;
      
      private var _1424430018abatis:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function FortificationsBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.abatis != null)
            {
               this.abatis = param1.abatis;
            }
            if(param1.arrowTower != null)
            {
               this.arrowTower = param1.arrowTower;
            }
            if(param1.rockfall != null)
            {
               this.rockfall = param1.rockfall;
            }
            if(param1.rollingLogs != null)
            {
               this.rollingLogs = param1.rollingLogs;
            }
            if(param1.trap != null)
            {
               this.trap = param1.trap;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get arrowTower() : int
      {
         return this._1739874176arrowTower;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "trap = " + this.trap + "\n" + (param1 + "abatis = " + this.abatis + "\n") + (param1 + "arrowTower = " + this.arrowTower + "\n") + (param1 + "rollingLogs = " + this.rollingLogs + "\n") + (param1 + "rockfall = " + this.rockfall + "\n");
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set arrowTower(param1:int) : void
      {
         var _loc2_:Object = this._1739874176arrowTower;
         if(_loc2_ !== param1)
         {
            this._1739874176arrowTower = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrowTower",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get rollingLogs() : int
      {
         return this._226523540rollingLogs;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function copyTo(param1:FortificationsBean) : void
      {
         param1.abatis = this.abatis;
         param1.arrowTower = this.arrowTower;
         param1.rockfall = this.rockfall;
         param1.rollingLogs = this.rollingLogs;
         param1.trap = this.trap;
      }
      
      public function set rockfall(param1:int) : void
      {
         var _loc2_:Object = this._518185888rockfall;
         if(_loc2_ !== param1)
         {
            this._518185888rockfall = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rockfall",_loc2_,param1));
         }
      }
      
      public function set trap(param1:int) : void
      {
         var _loc2_:Object = this._3568429trap;
         if(_loc2_ !== param1)
         {
            this._3568429trap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"trap",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rockfall() : int
      {
         return this._518185888rockfall;
      }
      
      public function toObject() : Object
      {
         return {
            "trap":this.trap,
            "abatis":this.abatis,
            "arrowTower":this.arrowTower,
            "rollingLogs":this.rollingLogs,
            "rockfall":this.rockfall
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get trap() : int
      {
         return this._3568429trap;
      }
      
      public function set rollingLogs(param1:int) : void
      {
         var _loc2_:Object = this._226523540rollingLogs;
         if(_loc2_ !== param1)
         {
            this._226523540rollingLogs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rollingLogs",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function set abatis(param1:int) : void
      {
         var _loc2_:Object = this._1424430018abatis;
         if(_loc2_ !== param1)
         {
            this._1424430018abatis = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"abatis",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get abatis() : int
      {
         return this._1424430018abatis;
      }
   }
}

