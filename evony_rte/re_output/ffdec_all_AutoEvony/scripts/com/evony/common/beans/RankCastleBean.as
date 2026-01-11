package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class RankCastleBean implements IEventDispatcher
   {
      
      private var _2023558323population:int;
      
      private var _3373707name:String;
      
      private var _98615255grade:String;
      
      private var _3292052kind:String;
      
      private var _3492908rank:int;
      
      private var _102865796level:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1806944311alliance:String;
      
      public function RankCastleBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.alliance != null)
            {
               this.alliance = param1.alliance;
            }
            if(param1.grade != null)
            {
               this.grade = param1.grade;
            }
            if(param1.kind != null)
            {
               this.kind = param1.kind;
            }
            if(param1.level != null)
            {
               this.level = param1.level;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.population != null)
            {
               this.population = param1.population;
            }
            if(param1.rank != null)
            {
               this.rank = param1.rank;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
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
         return param1 + "alliance = " + this.alliance + "\n" + (param1 + "grade = " + this.grade + "\n") + (param1 + "kind = " + this.kind + "\n") + (param1 + "level = " + this.level + "\n") + (param1 + "name = " + this.name + "\n") + (param1 + "population = " + this.population + "\n") + (param1 + "rank = " + this.rank + "\n");
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
      
      [Bindable(event="propertyChange")]
      public function get population() : int
      {
         return this._2023558323population;
      }
      
      public function copyTo(param1:RankCastleBean) : void
      {
         param1.alliance = this.alliance;
         param1.grade = this.grade;
         param1.kind = this.kind;
         param1.level = this.level;
         param1.name = this.name;
         param1.population = this.population;
         param1.rank = this.rank;
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
      public function get grade() : String
      {
         return this._98615255grade;
      }
      
      public function set rank(param1:int) : void
      {
         var _loc2_:Object = this._3492908rank;
         if(_loc2_ !== param1)
         {
            this._3492908rank = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rank",_loc2_,param1));
         }
      }
      
      public function set population(param1:int) : void
      {
         var _loc2_:Object = this._2023558323population;
         if(_loc2_ !== param1)
         {
            this._2023558323population = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"population",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get kind() : String
      {
         return this._3292052kind;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function toObject() : Object
      {
         return {
            "alliance":this.alliance,
            "grade":this.grade,
            "kind":this.kind,
            "level":this.level,
            "name":this.name,
            "population":this.population,
            "rank":this.rank
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get rank() : int
      {
         return this._3492908rank;
      }
      
      public function set grade(param1:String) : void
      {
         var _loc2_:Object = this._98615255grade;
         if(_loc2_ !== param1)
         {
            this._98615255grade = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"grade",_loc2_,param1));
         }
      }
      
      public function set kind(param1:String) : void
      {
         var _loc2_:Object = this._3292052kind;
         if(_loc2_ !== param1)
         {
            this._3292052kind = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"kind",_loc2_,param1));
         }
      }
      
      public function set alliance(param1:String) : void
      {
         var _loc2_:Object = this._1806944311alliance;
         if(_loc2_ !== param1)
         {
            this._1806944311alliance = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alliance",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get alliance() : String
      {
         return this._1806944311alliance;
      }
   }
}

