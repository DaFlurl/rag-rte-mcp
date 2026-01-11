package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class QuestTypeBean implements IEventDispatcher
   {
      
      private var _600408483isFinish:Boolean;
      
      private var _351608024version:int;
      
      private var _989204668recommend:Boolean;
      
      private var _3373707name:String;
      
      private var _1081572172mainId:int;
      
      private var _858803723typeId:int;
      
      private var _1724546052description:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function QuestTypeBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.description != null)
            {
               this.description = param1.description;
            }
            if(param1.mainId != null)
            {
               this.mainId = param1.mainId;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.typeId != null)
            {
               this.typeId = param1.typeId;
            }
            if(param1.version != null)
            {
               this.version = param1.version;
            }
            if(param1.isFinish != null)
            {
               this.isFinish = param1.isFinish;
            }
            if(param1.recommend != null)
            {
               this.recommend = param1.recommend;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get description() : String
      {
         return this._1724546052description;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "description = " + this.description + "\n";
         _loc2_ += param1 + "mainId = " + this.mainId + "\n";
         _loc2_ += param1 + "name = " + this.name + "\n";
         _loc2_ += param1 + "typeId = " + this.typeId + "\n";
         _loc2_ += param1 + "version = " + this.version + "\n";
         _loc2_ += param1 + "isFinish = " + this.isFinish + "\n";
         return _loc2_ + (param1 + "recommend = " + this.recommend + "\n");
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
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:QuestTypeBean) : void
      {
         param1.description = this.description;
         param1.mainId = this.mainId;
         param1.name = this.name;
         param1.typeId = this.typeId;
         param1.version = this.version;
         param1.isFinish = this.isFinish;
         param1.recommend = this.recommend;
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
      
      [Bindable(event="propertyChange")]
      public function get version() : int
      {
         return this._351608024version;
      }
      
      public function toObject() : Object
      {
         return {
            "description":this.description,
            "mainId":this.mainId,
            "name":this.name,
            "typeId":this.typeId,
            "version":this.version,
            "isFinish":this.isFinish,
            "recommend":this.recommend
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get isFinish() : Boolean
      {
         return this._600408483isFinish;
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
      
      public function set mainId(param1:int) : void
      {
         var _loc2_:Object = this._1081572172mainId;
         if(_loc2_ !== param1)
         {
            this._1081572172mainId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainId",_loc2_,param1));
         }
      }
      
      public function set version(param1:int) : void
      {
         var _loc2_:Object = this._351608024version;
         if(_loc2_ !== param1)
         {
            this._351608024version = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"version",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainId() : int
      {
         return this._1081572172mainId;
      }
      
      [Bindable(event="propertyChange")]
      public function get typeId() : int
      {
         return this._858803723typeId;
      }
      
      public function set recommend(param1:Boolean) : void
      {
         var _loc2_:Object = this._989204668recommend;
         if(_loc2_ !== param1)
         {
            this._989204668recommend = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"recommend",_loc2_,param1));
         }
      }
      
      public function set isFinish(param1:Boolean) : void
      {
         var _loc2_:Object = this._600408483isFinish;
         if(_loc2_ !== param1)
         {
            this._600408483isFinish = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isFinish",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get recommend() : Boolean
      {
         return this._989204668recommend;
      }
      
      public function set description(param1:String) : void
      {
         var _loc2_:Object = this._1724546052description;
         if(_loc2_ !== param1)
         {
            this._1724546052description = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"description",_loc2_,param1));
         }
      }
   }
}

