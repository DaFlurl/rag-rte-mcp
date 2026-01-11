package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class BuildingQueueBean implements IEventDispatcher
   {
      private var _3355id:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1739445269queueType:int;
      
      private var _3373707name:String;
      
      private var _892481550status:int;
      
      private var _858803723typeId:int;
      
      private var _1381039140positionId:int;
      
      private var _102865796level:int;
      
      private var _424687558costTime:Number;
      
      public function BuildingQueueBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.costTime != null)
            {
               this.costTime = param1.costTime;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.level != null)
            {
               this.level = param1.level;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.positionId != null)
            {
               this.positionId = param1.positionId;
            }
            if(param1.queueType != null)
            {
               this.queueType = param1.queueType;
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
            if(param1.typeId != null)
            {
               this.typeId = param1.typeId;
            }
         }
      }
      
      public function set costTime(param1:Number) : void
      {
         var _loc2_:Object = this._424687558costTime;
         if(_loc2_ !== param1)
         {
            this._424687558costTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"costTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set level(param1:int) : void
      {
         var _loc2_:Object = this._102865796level;
         if(_loc2_ !== param1)
         {
            this._102865796level = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"level",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "costTime = " + this.costTime + "\n";
         _loc2_ += param1 + "id = " + this.id + "\n";
         _loc2_ += param1 + "level = " + this.level + "\n";
         _loc2_ += param1 + "name = " + this.name + "\n";
         _loc2_ += param1 + "positionId = " + this.positionId + "\n";
         _loc2_ += param1 + "queueType = " + this.queueType + "\n";
         _loc2_ += param1 + "status = " + this.status + "\n";
         return _loc2_ + (param1 + "typeId = " + this.typeId + "\n");
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
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get typeId() : int
      {
         return this._858803723typeId;
      }
      
      public function set positionId(param1:int) : void
      {
         var _loc2_:Object = this._1381039140positionId;
         if(_loc2_ !== param1)
         {
            this._1381039140positionId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"positionId",_loc2_,param1));
         }
      }
      
      public function copyTo(param1:BuildingQueueBean) : void
      {
         param1.costTime = this.costTime;
         param1.id = this.id;
         param1.level = this.level;
         param1.name = this.name;
         param1.positionId = this.positionId;
         param1.queueType = this.queueType;
         param1.status = this.status;
         param1.typeId = this.typeId;
      }
      
      [Bindable(event="propertyChange")]
      public function get costTime() : Number
      {
         return this._424687558costTime;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set queueType(param1:int) : void
      {
         var _loc2_:Object = this._1739445269queueType;
         if(_loc2_ !== param1)
         {
            this._1739445269queueType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"queueType",_loc2_,param1));
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.costTime = this.costTime;
         _loc1_.id = this.id;
         _loc1_.level = this.level;
         _loc1_.name = this.name;
         _loc1_.positionId = this.positionId;
         _loc1_.queueType = this.queueType;
         _loc1_.status = this.status;
         _loc1_.typeId = this.typeId;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
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
      public function get queueType() : int
      {
         return this._1739445269queueType;
      }
      
      public function set typeId(param1:int) : void
      {
         var _loc2_:Object = this._858803723typeId;
         if(_loc2_ !== param1)
         {
            this._858803723typeId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"typeId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      public function set id(param1:int) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get positionId() : int
      {
         return this._1381039140positionId;
      }
   }
}

