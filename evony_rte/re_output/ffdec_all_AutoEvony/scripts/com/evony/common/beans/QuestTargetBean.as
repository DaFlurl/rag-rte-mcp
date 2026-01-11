package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class QuestTargetBean implements IEventDispatcher
   {
      
      private var _3373707name:String;
      
      private var _673660814finished:Boolean;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function QuestTargetBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.finished != null)
            {
               this.finished = param1.finished;
            }
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set finished(param1:Boolean) : void
      {
         var _loc2_:Object = this._673660814finished;
         if(_loc2_ !== param1)
         {
            this._673660814finished = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"finished",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "name = " + this.name + "\n";
         return _loc2_ + (param1 + "finished = " + this.finished + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
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
      
      public function copyTo(param1:QuestTargetBean) : void
      {
         param1.name = this.name;
         param1.finished = this.finished;
      }
      
      [Bindable(event="propertyChange")]
      public function get finished() : Boolean
      {
         return this._673660814finished;
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
         var _loc1_:Object = new Object();
         _loc1_.name = this.name;
         _loc1_.finished = this.finished;
         return _loc1_;
      }
   }
}

