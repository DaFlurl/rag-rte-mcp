package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class BuildingBean implements IEventDispatcher
   {
      
      private var _1796717668appearance:int;
      
      private var _1607243192endTime:Number;
      
      private var _892481550status:int;
      
      private var _3373707name:String;
      
      private var _102865796level:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _3198785help:int;
      
      private var _2129294769startTime:Number;
      
      private var _858803723typeId:int;
      
      private var _1381039140positionId:int;
      
      public function BuildingBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.appearance != null)
            {
               this.appearance = param1.appearance;
            }
            if(param1.endTime != null)
            {
               this.endTime = param1.endTime;
            }
            if(param1.help != null)
            {
               this.help = param1.help;
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
            if(param1.startTime != null)
            {
               this.startTime = param1.startTime;
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
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set help(param1:int) : void
      {
         var _loc2_:Object = this._3198785help;
         if(_loc2_ !== param1)
         {
            this._3198785help = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"help",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
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
      
      public function set endTime(param1:Number) : void
      {
         var _loc2_:Object = this._1607243192endTime;
         if(_loc2_ !== param1)
         {
            this._1607243192endTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
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
         _loc1_.appearance = this.appearance;
         _loc1_.endTime = this.endTime;
         _loc1_.help = this.help;
         _loc1_.level = this.level;
         _loc1_.name = this.name;
         _loc1_.positionId = this.positionId;
         _loc1_.startTime = this.startTime;
         _loc1_.status = this.status;
         _loc1_.typeId = this.typeId;
         return _loc1_;
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
      
      [Bindable(event="propertyChange")]
      public function get positionId() : int
      {
         return this._1381039140positionId;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get help() : int
      {
         return this._3198785help;
      }
      
      public function set appearance(param1:int) : void
      {
         var _loc2_:Object = this._1796717668appearance;
         if(_loc2_ !== param1)
         {
            this._1796717668appearance = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"appearance",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "appearance = " + this.appearance + "\n";
         _loc2_ += param1 + "endTime = " + this.endTime + "\n";
         _loc2_ += param1 + "help = " + this.help + "\n";
         _loc2_ += param1 + "level = " + this.level + "\n";
         _loc2_ += param1 + "name = " + this.name + "\n";
         _loc2_ += param1 + "positionId = " + this.positionId + "\n";
         _loc2_ += param1 + "startTime = " + this.startTime + "\n";
         _loc2_ += param1 + "status = " + this.status + "\n";
         return _loc2_ + (param1 + "typeId = " + this.typeId + "\n");
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
      
      public function copyTo(param1:BuildingBean) : void
      {
         param1.appearance = this.appearance;
         param1.endTime = this.endTime;
         param1.help = this.help;
         param1.level = this.level;
         param1.name = this.name;
         param1.positionId = this.positionId;
         param1.startTime = this.startTime;
         param1.status = this.status;
         param1.typeId = this.typeId;
      }
      
      [Bindable(event="propertyChange")]
      public function get startTime() : Number
      {
         return this._2129294769startTime;
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
      
      [Bindable(event="propertyChange")]
      public function get appearance() : int
      {
         return this._1796717668appearance;
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
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get typeId() : int
      {
         return this._858803723typeId;
      }
   }
}

