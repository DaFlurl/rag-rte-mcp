package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class StoreBean implements IEventDispatcher
   {
      private var _358052900storePercent:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _2016783856magnitude:int;
      
      private var _292680141warehourseCapacity:int;
      
      private var _1096322212resLimt:int;
      
      private var _172472894unstorage:int;
      
      private var _1795184074storeTypeId:int;
      
      private var _1884274053storage:int;
      
      public function StoreBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.magnitude != null)
            {
               this.magnitude = param1.magnitude;
            }
            if(param1.resLimt != null)
            {
               this.resLimt = param1.resLimt;
            }
            if(param1.storage != null)
            {
               this.storage = param1.storage;
            }
            if(param1.storePercent != null)
            {
               this.storePercent = param1.storePercent;
            }
            if(param1.storeTypeId != null)
            {
               this.storeTypeId = param1.storeTypeId;
            }
            if(param1.unstorage != null)
            {
               this.unstorage = param1.unstorage;
            }
            if(param1.warehourseCapacity != null)
            {
               this.warehourseCapacity = param1.warehourseCapacity;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get unstorage() : int
      {
         return this._172472894unstorage;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set unstorage(param1:int) : void
      {
         var _loc2_:Object = this._172472894unstorage;
         if(_loc2_ !== param1)
         {
            this._172472894unstorage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"unstorage",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set storePercent(param1:int) : void
      {
         var _loc2_:Object = this._358052900storePercent;
         if(_loc2_ !== param1)
         {
            this._358052900storePercent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"storePercent",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "magnitude = " + this.magnitude + "\n";
         _loc2_ += param1 + "resLimt = " + this.resLimt + "\n";
         _loc2_ += param1 + "storage = " + this.storage + "\n";
         _loc2_ += param1 + "storePercent = " + this.storePercent + "\n";
         _loc2_ += param1 + "storeTypeId = " + this.storeTypeId + "\n";
         _loc2_ += param1 + "unstorage = " + this.unstorage + "\n";
         return _loc2_ + (param1 + "warehourseCapacity = " + this.warehourseCapacity + "\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get warehourseCapacity() : int
      {
         return this._292680141warehourseCapacity;
      }
      
      public function set resLimt(param1:int) : void
      {
         var _loc2_:Object = this._1096322212resLimt;
         if(_loc2_ !== param1)
         {
            this._1096322212resLimt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resLimt",_loc2_,param1));
         }
      }
      
      public function copyTo(param1:StoreBean) : void
      {
         param1.magnitude = this.magnitude;
         param1.resLimt = this.resLimt;
         param1.storage = this.storage;
         param1.storePercent = this.storePercent;
         param1.storeTypeId = this.storeTypeId;
         param1.unstorage = this.unstorage;
         param1.warehourseCapacity = this.warehourseCapacity;
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
      public function get magnitude() : int
      {
         return this._2016783856magnitude;
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.magnitude = this.magnitude;
         _loc1_.resLimt = this.resLimt;
         _loc1_.storage = this.storage;
         _loc1_.storePercent = this.storePercent;
         _loc1_.storeTypeId = this.storeTypeId;
         _loc1_.unstorage = this.unstorage;
         _loc1_.warehourseCapacity = this.warehourseCapacity;
         return _loc1_;
      }
      
      public function set magnitude(param1:int) : void
      {
         var _loc2_:Object = this._2016783856magnitude;
         if(_loc2_ !== param1)
         {
            this._2016783856magnitude = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"magnitude",_loc2_,param1));
         }
      }
      
      public function set warehourseCapacity(param1:int) : void
      {
         var _loc2_:Object = this._292680141warehourseCapacity;
         if(_loc2_ !== param1)
         {
            this._292680141warehourseCapacity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"warehourseCapacity",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get storePercent() : int
      {
         return this._358052900storePercent;
      }
      
      [Bindable(event="propertyChange")]
      public function get resLimt() : int
      {
         return this._1096322212resLimt;
      }
      
      public function set storeTypeId(param1:int) : void
      {
         var _loc2_:Object = this._1795184074storeTypeId;
         if(_loc2_ !== param1)
         {
            this._1795184074storeTypeId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"storeTypeId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get storeTypeId() : int
      {
         return this._1795184074storeTypeId;
      }
      
      [Bindable(event="propertyChange")]
      public function get storage() : int
      {
         return this._1884274053storage;
      }
      
      public function set storage(param1:int) : void
      {
         var _loc2_:Object = this._1884274053storage;
         if(_loc2_ !== param1)
         {
            this._1884274053storage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"storage",_loc2_,param1));
         }
      }
   }
}

