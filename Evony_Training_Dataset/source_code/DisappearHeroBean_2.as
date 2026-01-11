package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class DisappearHeroBean implements IEventDispatcher
   {
      private var _3355id:String;
      
      private var _3373707name:String;
      
      private var _1799980989management:int;
      
      private var _106858757power:int;
      
      private var _1417925547disppeartime:String;
      
      private var _102865796level:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _412944526stratagem:int;
      
      public function DisappearHeroBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.disppeartime != null)
            {
               this.disppeartime = param1.disppeartime;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.level != null)
            {
               this.level = param1.level;
            }
            if(param1.management != null)
            {
               this.management = param1.management;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.power != null)
            {
               this.power = param1.power;
            }
            if(param1.stratagem != null)
            {
               this.stratagem = param1.stratagem;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get management() : int
      {
         return this._1799980989management;
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
      }
      
      [Bindable(event="propertyChange")]
      public function get power() : int
      {
         return this._106858757power;
      }
      
      public function set management(param1:int) : void
      {
         var _loc2_:Object = this._1799980989management;
         if(_loc2_ !== param1)
         {
            this._1799980989management = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"management",_loc2_,param1));
         }
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
         return param1 + "disppeartime = " + this.disppeartime + "\n" + (param1 + "id = " + this.id + "\n") + (param1 + "level = " + this.level + "\n") + (param1 + "management = " + this.management + "\n") + (param1 + "name = " + this.name + "\n") + (param1 + "power = " + this.power + "\n") + (param1 + "stratagem = " + this.stratagem + "\n");
      }
      
      public function set power(param1:int) : void
      {
         var _loc2_:Object = this._106858757power;
         if(_loc2_ !== param1)
         {
            this._106858757power = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"power",_loc2_,param1));
         }
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
      
      public function copyTo(param1:DisappearHeroBean) : void
      {
         param1.disppeartime = this.disppeartime;
         param1.id = this.id;
         param1.level = this.level;
         param1.management = this.management;
         param1.name = this.name;
         param1.power = this.power;
         param1.stratagem = this.stratagem;
      }
      
      [Bindable(event="propertyChange")]
      public function get stratagem() : int
      {
         return this._412944526stratagem;
      }
      
      [Bindable(event="propertyChange")]
      public function get disppeartime() : String
      {
         return this._1417925547disppeartime;
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
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function toObject() : Object
      {
         return {
            "disppeartime":this.disppeartime,
            "id":this.id,
            "level":this.level,
            "management":this.management,
            "name":this.name,
            "power":this.power,
            "stratagem":this.stratagem
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : String
      {
         return this._3355id;
      }
      
      public function set stratagem(param1:int) : void
      {
         var _loc2_:Object = this._412944526stratagem;
         if(_loc2_ !== param1)
         {
            this._412944526stratagem = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stratagem",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set disppeartime(param1:String) : void
      {
         var _loc2_:Object = this._1417925547disppeartime;
         if(_loc2_ !== param1)
         {
            this._1417925547disppeartime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"disppeartime",_loc2_,param1));
         }
      }
      
      public function set id(param1:String) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
   }
}

