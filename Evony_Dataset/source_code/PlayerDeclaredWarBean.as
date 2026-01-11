package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class PlayerDeclaredWarBean implements IEventDispatcher
   {
      private var _1607243192endTime:Number;
      
      private var _892481550status:int;
      
      private var _2129294769startTime:Number;
      
      private var _2095657228playerName:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function PlayerDeclaredWarBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.playerName != null)
            {
               this.playerName = param1.playerName;
            }
            if(param1.startTime != null)
            {
               this.startTime = param1.startTime;
            }
            if(param1.endTime != null)
            {
               this.endTime = param1.endTime;
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "endTime = " + this.endTime + "\n" + (param1 + "playerName = " + this.playerName + "\n") + (param1 + "startTime = " + this.startTime + "\n") + (param1 + "status = " + this.status + "\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get playerName() : String
      {
         return this._2095657228playerName;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get startTime() : Number
      {
         return this._2129294769startTime;
      }
      
      public function copyTo(param1:PlayerDeclaredWarBean) : void
      {
         param1.endTime = this.endTime;
         param1.playerName = this.playerName;
         param1.startTime = this.startTime;
         param1.status = this.status;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get endTime() : Number
      {
         return this._1607243192endTime;
      }
      
      public function set playerName(param1:String) : void
      {
         var _loc2_:Object = this._2095657228playerName;
         if(_loc2_ !== param1)
         {
            this._2095657228playerName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerName",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "endTime":this.endTime,
            "playerName":this.playerName,
            "startTime":this.startTime,
            "status":this.status
         };
      }
      
      public function set startTime(param1:Number) : void
      {
         var _loc2_:Object = this._2129294769startTime;
         if(_loc2_ !== param1)
         {
            this._2129294769startTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startTime",_loc2_,param1));
         }
      }
      
      public function set endTime(param1:Number) : void
      {
         var _loc2_:Object = this._1607243192endTime;
         if(_loc2_ !== param1)
         {
            this._1607243192endTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endTime",_loc2_,param1));
         }
      }
      
      public function set status(param1:int) : void
      {
         var _loc2_:Object = this._892481550status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}

