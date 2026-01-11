package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class BuyResourceBean implements IEventDispatcher
   {
      
      private var _678500047forIron:int;
      
      private var _678592313forFood:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _504430457woodRemain:int;
      
      private var _449807254foodRemain:int;
      
      private var _450629916forStone:int;
      
      private var _1881641644ironRemain:int;
      
      private var _252311759stoneRemain:int;
      
      private var _678085866forWood:int;
      
      public function BuyResourceBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.foodRemain != null)
            {
               this.foodRemain = param1.foodRemain;
            }
            if(param1.forFood != null)
            {
               this.forFood = param1.forFood;
            }
            if(param1.forIron != null)
            {
               this.forIron = param1.forIron;
            }
            if(param1.forStone != null)
            {
               this.forStone = param1.forStone;
            }
            if(param1.forWood != null)
            {
               this.forWood = param1.forWood;
            }
            if(param1.ironRemain != null)
            {
               this.ironRemain = param1.ironRemain;
            }
            if(param1.stoneRemain != null)
            {
               this.stoneRemain = param1.stoneRemain;
            }
            if(param1.woodRemain != null)
            {
               this.woodRemain = param1.woodRemain;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get woodRemain() : int
      {
         return this._504430457woodRemain;
      }
      
      public function set woodRemain(param1:int) : void
      {
         var _loc2_:Object = this._504430457woodRemain;
         if(_loc2_ !== param1)
         {
            this._504430457woodRemain = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"woodRemain",_loc2_,param1));
         }
      }
      
      public function set forWood(param1:int) : void
      {
         var _loc2_:Object = this._678085866forWood;
         if(_loc2_ !== param1)
         {
            this._678085866forWood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"forWood",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get forFood() : int
      {
         return this._678592313forFood;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "foodRemain = " + this.foodRemain + "\n" + (param1 + "forFood = " + this.forFood + "\n") + (param1 + "forIron = " + this.forIron + "\n") + (param1 + "forStone = " + this.forStone + "\n") + (param1 + "forWood = " + this.forWood + "\n") + (param1 + "ironRemain = " + this.ironRemain + "\n") + (param1 + "stoneRemain = " + this.stoneRemain + "\n") + (param1 + "woodRemain = " + this.woodRemain + "\n");
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set forFood(param1:int) : void
      {
         var _loc2_:Object = this._678592313forFood;
         if(_loc2_ !== param1)
         {
            this._678592313forFood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"forFood",_loc2_,param1));
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get forIron() : int
      {
         return this._678500047forIron;
      }
      
      public function set foodRemain(param1:int) : void
      {
         var _loc2_:Object = this._449807254foodRemain;
         if(_loc2_ !== param1)
         {
            this._449807254foodRemain = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"foodRemain",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get forWood() : int
      {
         return this._678085866forWood;
      }
      
      public function copyTo(param1:BuyResourceBean) : void
      {
         param1.foodRemain = this.foodRemain;
         param1.forFood = this.forFood;
         param1.forIron = this.forIron;
         param1.forStone = this.forStone;
         param1.forWood = this.forWood;
         param1.ironRemain = this.ironRemain;
         param1.stoneRemain = this.stoneRemain;
         param1.woodRemain = this.woodRemain;
      }
      
      public function toObject() : Object
      {
         return {
            "foodRemain":this.foodRemain,
            "forFood":this.forFood,
            "forIron":this.forIron,
            "forStone":this.forStone,
            "forWood":this.forWood,
            "ironRemain":this.ironRemain,
            "stoneRemain":this.stoneRemain,
            "woodRemain":this.woodRemain
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get ironRemain() : int
      {
         return this._1881641644ironRemain;
      }
      
      [Bindable(event="propertyChange")]
      public function get forStone() : int
      {
         return this._450629916forStone;
      }
      
      public function set stoneRemain(param1:int) : void
      {
         var _loc2_:Object = this._252311759stoneRemain;
         if(_loc2_ !== param1)
         {
            this._252311759stoneRemain = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stoneRemain",_loc2_,param1));
         }
      }
      
      public function set ironRemain(param1:int) : void
      {
         var _loc2_:Object = this._1881641644ironRemain;
         if(_loc2_ !== param1)
         {
            this._1881641644ironRemain = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ironRemain",_loc2_,param1));
         }
      }
      
      public function set forIron(param1:int) : void
      {
         var _loc2_:Object = this._678500047forIron;
         if(_loc2_ !== param1)
         {
            this._678500047forIron = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"forIron",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get foodRemain() : int
      {
         return this._449807254foodRemain;
      }
      
      [Bindable(event="propertyChange")]
      public function get stoneRemain() : int
      {
         return this._252311759stoneRemain;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set forStone(param1:int) : void
      {
         var _loc2_:Object = this._450629916forStone;
         if(_loc2_ !== param1)
         {
            this._450629916forStone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"forStone",_loc2_,param1));
         }
      }
   }
}

