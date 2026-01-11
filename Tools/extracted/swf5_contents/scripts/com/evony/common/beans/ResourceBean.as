package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class ResourceBean implements IEventDispatcher
   {
      private var _3655341wood:Number = 0;
      
      private var _109770853stone:Number = 0;
      
      private var _3148894food:Number = 0;
      
      private var _3241160iron:Number = 0;
      
      private var _3178592gold:Number = 0;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function ResourceBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.food != null)
            {
               this.food = param1.food;
            }
            if(param1.gold != null)
            {
               this.gold = param1.gold;
            }
            if(param1.iron != null)
            {
               this.iron = param1.iron;
            }
            if(param1.stone != null)
            {
               this.stone = param1.stone;
            }
            if(param1.wood != null)
            {
               this.wood = param1.wood;
            }
         }
      }
      
      public function set gold(param1:Number) : void
      {
         var _loc2_:Object = this._3178592gold;
         if(_loc2_ !== param1)
         {
            this._3178592gold = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gold",_loc2_,param1));
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
         return param1 + "food = " + this.food + "\n" + (param1 + "gold = " + this.gold + "\n") + (param1 + "iron = " + this.iron + "\n") + (param1 + "stone = " + this.stone + "\n") + (param1 + "wood = " + this.wood + "\n");
      }
      
      public function set stone(param1:Number) : void
      {
         var _loc2_:Object = this._109770853stone;
         if(_loc2_ !== param1)
         {
            this._109770853stone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stone",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get iron() : Number
      {
         return this._3241160iron;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function copyTo(param1:ResourceBean) : void
      {
         param1.food = this.food;
         param1.gold = this.gold;
         param1.iron = this.iron;
         param1.stone = this.stone;
         param1.wood = this.wood;
      }
      
      public function set wood(param1:Number) : void
      {
         var _loc2_:Object = this._3655341wood;
         if(_loc2_ !== param1)
         {
            this._3655341wood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wood",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get food() : Number
      {
         return this._3148894food;
      }
      
      public function set iron(param1:Number) : void
      {
         var _loc2_:Object = this._3241160iron;
         if(_loc2_ !== param1)
         {
            this._3241160iron = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iron",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "food":this.food,
            "gold":this.gold,
            "iron":this.iron,
            "stone":this.stone,
            "wood":this.wood
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get stone() : Number
      {
         return this._109770853stone;
      }
      
      [Bindable(event="propertyChange")]
      public function get wood() : Number
      {
         return this._3655341wood;
      }
      
      [Bindable(event="propertyChange")]
      public function get gold() : Number
      {
         return this._3178592gold;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set food(param1:Number) : void
      {
         var _loc2_:Object = this._3148894food;
         if(_loc2_ !== param1)
         {
            this._3148894food = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"food",_loc2_,param1));
         }
      }
   }
}

