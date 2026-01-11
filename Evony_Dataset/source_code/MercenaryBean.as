package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class MercenaryBean implements IEventDispatcher
   {
      private var _1607243192endTime:Number;
      
      private var _892481550status:int;
      
      private var _2129294769startTime:Number;
      
      private var _35872819castleId:int;
      
      private var _1911605294targetPosName:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function MercenaryBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.castleId != null)
            {
               this.castleId = param1.castleId;
            }
            if(param1.endTime != null)
            {
               this.endTime = param1.endTime;
            }
            if(param1.startTime != null)
            {
               this.startTime = param1.startTime;
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
            if(param1.targetPosName != null)
            {
               this.targetPosName = param1.targetPosName;
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
         return param1 + "castleId = " + this.castleId + "\n" + (param1 + "endTime = " + this.endTime + "\n") + (param1 + "startTime = " + this.startTime + "\n") + (param1 + "status = " + this.status + "\n") + (param1 + "targetPosName = " + this.targetPosName + "\n");
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
      public function get endTime() : Number
      {
         return this._1607243192endTime;
      }
      
      public function copyTo(param1:MercenaryBean) : void
      {
         param1.castleId = this.castleId;
         param1.endTime = this.endTime;
         param1.startTime = this.startTime;
         param1.status = this.status;
         param1.targetPosName = this.targetPosName;
      }
      
      [Bindable(event="propertyChange")]
      public function get startTime() : Number
      {
         return this._2129294769startTime;
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
      
      public function toObject() : Object
      {
         return {
            "castleId":this.castleId,
            "endTime":this.endTime,
            "startTime":this.startTime,
            "status":this.status,
            "targetPosName":this.targetPosName
         };
      }
      
      public function set targetPosName(param1:String) : void
      {
         var _loc2_:Object = this._1911605294targetPosName;
         if(_loc2_ !== param1)
         {
            this._1911605294targetPosName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetPosName",_loc2_,param1));
         }
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
      
      public function set status(param1:int) : void
      {
         var _loc2_:Object = this._892481550status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
         }
      }
      
      public function set castleId(param1:int) : void
      {
         var _loc2_:Object = this._35872819castleId;
         if(_loc2_ !== param1)
         {
            this._35872819castleId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get targetPosName() : String
      {
         return this._1911605294targetPosName;
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      [Bindable(event="propertyChange")]
      public function get castleId() : int
      {
         return this._35872819castleId;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}

