package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class CastleResourceBean implements IEventDispatcher
   {
      private var _3178592gold:Number;
      
      private var _1197906146colonyIron:Number;
      
      private var _1403061077complaint:int;
      
      private var _636575436taxIncome:int;
      
      private var _3655341wood:ResourceInfoBean;
      
      private var _1007641795troopCostFood:Number;
      
      private var _1167488739herosSalary:int;
      
      private var _1099040721maxPopulation:int;
      
      private var _1418848857texRate:int;
      
      private var _694674963supplyFood:Number;
      
      private var _2140939619buildPeople:int;
      
      private var _1510320245colonyStone:Number;
      
      private var _1198320327colonyWood:Number;
      
      private var _109770853stone:ResourceInfoBean;
      
      private var _1197843578colonyGold:Number;
      
      private var _3241160iron:ResourceInfoBean;
      
      private var _359111346populationDirection:int;
      
      private var _216564141curPopulation:int;
      
      private var _1197813880colonyFood:Number;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _3148894food:ResourceInfoBean;
      
      private var _1854767153support:int;
      
      private var _996698880workPeople:int;
      
      public function CastleResourceBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.buildPeople != null)
            {
               this.buildPeople = param1.buildPeople;
            }
            if(param1.colonyFood != null)
            {
               this.colonyFood = param1.colonyFood;
            }
            if(param1.colonyGold != null)
            {
               this.colonyGold = param1.colonyGold;
            }
            if(param1.colonyIron != null)
            {
               this.colonyIron = param1.colonyIron;
            }
            if(param1.colonyStone != null)
            {
               this.colonyStone = param1.colonyStone;
            }
            if(param1.colonyWood != null)
            {
               this.colonyWood = param1.colonyWood;
            }
            if(param1.complaint != null)
            {
               this.complaint = param1.complaint;
            }
            if(param1.curPopulation != null)
            {
               this.curPopulation = param1.curPopulation;
            }
            if(param1.food != null)
            {
               this.food = new ResourceInfoBean(param1.food);
            }
            if(param1.gold != null)
            {
               this.gold = param1.gold;
            }
            if(param1.herosSalary != null)
            {
               this.herosSalary = param1.herosSalary;
            }
            if(param1.iron != null)
            {
               this.iron = new ResourceInfoBean(param1.iron);
            }
            if(param1.maxPopulation != null)
            {
               this.maxPopulation = param1.maxPopulation;
            }
            if(param1.populationDirection != null)
            {
               this.populationDirection = param1.populationDirection;
            }
            if(param1.stone != null)
            {
               this.stone = new ResourceInfoBean(param1.stone);
            }
            if(param1.supplyFood != null)
            {
               this.supplyFood = param1.supplyFood;
            }
            if(param1.support != null)
            {
               this.support = param1.support;
            }
            if(param1.taxIncome != null)
            {
               this.taxIncome = param1.taxIncome;
            }
            if(param1.texRate != null)
            {
               this.texRate = param1.texRate;
            }
            if(param1.troopCostFood != null)
            {
               this.troopCostFood = param1.troopCostFood;
            }
            if(param1.wood != null)
            {
               this.wood = new ResourceInfoBean(param1.wood);
            }
            if(param1.workPeople != null)
            {
               this.workPeople = param1.workPeople;
            }
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get workPeople() : int
      {
         return this._996698880workPeople;
      }
      
      public function set colonyStone(param1:Number) : void
      {
         var _loc2_:Object = this._1510320245colonyStone;
         if(_loc2_ !== param1)
         {
            this._1510320245colonyStone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonyStone",_loc2_,param1));
         }
      }
      
      public function set workPeople(param1:int) : void
      {
         var _loc2_:Object = this._996698880workPeople;
         if(_loc2_ !== param1)
         {
            this._996698880workPeople = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workPeople",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get taxIncome() : int
      {
         return this._636575436taxIncome;
      }
      
      [Bindable(event="propertyChange")]
      public function get troopCostFood() : Number
      {
         return this._1007641795troopCostFood;
      }
      
      public function set buildPeople(param1:int) : void
      {
         var _loc2_:Object = this._2140939619buildPeople;
         if(_loc2_ !== param1)
         {
            this._2140939619buildPeople = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buildPeople",_loc2_,param1));
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set texRate(param1:int) : void
      {
         var _loc2_:Object = this._1418848857texRate;
         if(_loc2_ !== param1)
         {
            this._1418848857texRate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"texRate",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set complaint(param1:int) : void
      {
         var _loc2_:Object = this._1403061077complaint;
         if(_loc2_ !== param1)
         {
            this._1403061077complaint = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"complaint",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get food() : ResourceInfoBean
      {
         return this._3148894food;
      }
      
      [Bindable(event="propertyChange")]
      public function get gold() : Number
      {
         return this._3178592gold;
      }
      
      public function set wood(param1:ResourceInfoBean) : void
      {
         var _loc2_:Object = this._3655341wood;
         if(_loc2_ !== param1)
         {
            this._3655341wood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wood",_loc2_,param1));
         }
      }
      
      public function set populationDirection(param1:int) : void
      {
         var _loc2_:Object = this._359111346populationDirection;
         if(_loc2_ !== param1)
         {
            this._359111346populationDirection = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"populationDirection",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stone() : ResourceInfoBean
      {
         return this._109770853stone;
      }
      
      public function set taxIncome(param1:int) : void
      {
         var _loc2_:Object = this._636575436taxIncome;
         if(_loc2_ !== param1)
         {
            this._636575436taxIncome = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"taxIncome",_loc2_,param1));
         }
      }
      
      public function set curPopulation(param1:int) : void
      {
         var _loc2_:Object = this._216564141curPopulation;
         if(_loc2_ !== param1)
         {
            this._216564141curPopulation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"curPopulation",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get colonyFood() : Number
      {
         return this._1197813880colonyFood;
      }
      
      [Bindable(event="propertyChange")]
      public function get colonyGold() : Number
      {
         return this._1197843578colonyGold;
      }
      
      public function set troopCostFood(param1:Number) : void
      {
         var _loc2_:Object = this._1007641795troopCostFood;
         if(_loc2_ !== param1)
         {
            this._1007641795troopCostFood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troopCostFood",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get colonyStone() : Number
      {
         return this._1510320245colonyStone;
      }
      
      public function set colonyWood(param1:Number) : void
      {
         var _loc2_:Object = this._1198320327colonyWood;
         if(_loc2_ !== param1)
         {
            this._1198320327colonyWood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonyWood",_loc2_,param1));
         }
      }
      
      public function set iron(param1:ResourceInfoBean) : void
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
            "buildPeople":this.buildPeople,
            "colonyFood":this.colonyFood,
            "colonyGold":this.colonyGold,
            "colonyIron":this.colonyIron,
            "colonyStone":this.colonyStone,
            "colonyWood":this.colonyWood,
            "complaint":this.complaint,
            "curPopulation":this.curPopulation,
            "food":this.food.toObject(),
            "gold":this.gold,
            "herosSalary":this.herosSalary,
            "iron":this.iron.toObject(),
            "maxPopulation":this.maxPopulation,
            "populationDirection":this.populationDirection,
            "stone":this.stone.toObject(),
            "supplyFood":this.supplyFood,
            "support":this.support,
            "taxIncome":this.taxIncome,
            "texRate":this.texRate,
            "troopCostFood":this.troopCostFood,
            "wood":this.wood.toObject(),
            "workPeople":this.workPeople
         };
      }
      
      public function set support(param1:int) : void
      {
         var _loc2_:Object = this._1854767153support;
         if(_loc2_ !== param1)
         {
            this._1854767153support = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"support",_loc2_,param1));
         }
      }
      
      public function set maxPopulation(param1:int) : void
      {
         var _loc2_:Object = this._1099040721maxPopulation;
         if(_loc2_ !== param1)
         {
            this._1099040721maxPopulation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maxPopulation",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get texRate() : int
      {
         return this._1418848857texRate;
      }
      
      [Bindable(event="propertyChange")]
      public function get buildPeople() : int
      {
         return this._2140939619buildPeople;
      }
      
      [Bindable(event="propertyChange")]
      public function get wood() : ResourceInfoBean
      {
         return this._3655341wood;
      }
      
      [Bindable(event="propertyChange")]
      public function get complaint() : int
      {
         return this._1403061077complaint;
      }
      
      [Bindable(event="propertyChange")]
      public function get populationDirection() : int
      {
         return this._359111346populationDirection;
      }
      
      public function set food(param1:ResourceInfoBean) : void
      {
         var _loc2_:Object = this._3148894food;
         if(_loc2_ !== param1)
         {
            this._3148894food = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"food",_loc2_,param1));
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
      
      public function set colonyIron(param1:Number) : void
      {
         var _loc2_:Object = this._1197906146colonyIron;
         if(_loc2_ !== param1)
         {
            this._1197906146colonyIron = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonyIron",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get curPopulation() : int
      {
         return this._216564141curPopulation;
      }
      
      public function set herosSalary(param1:int) : void
      {
         var _loc2_:Object = this._1167488739herosSalary;
         if(_loc2_ !== param1)
         {
            this._1167488739herosSalary = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"herosSalary",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get colonyWood() : Number
      {
         return this._1198320327colonyWood;
      }
      
      [Bindable(event="propertyChange")]
      public function get iron() : ResourceInfoBean
      {
         return this._3241160iron;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "buildPeople = " + this.buildPeople + "\n" + (param1 + "colonyFood = " + this.colonyFood + "\n") + (param1 + "colonyGold = " + this.colonyGold + "\n") + (param1 + "colonyIron = " + this.colonyIron + "\n") + (param1 + "colonyStone = " + this.colonyStone + "\n") + (param1 + "colonyWood = " + this.colonyWood + "\n") + (param1 + "complaint = " + this.complaint + "\n") + (param1 + "curPopulation = " + this.curPopulation + "\n") + (this.food != null ? this.food.toDebugString(param1 + "food.") : param1 + "food = null\n") + (param1 + "gold = " + this.gold + "\n") + (param1 + "herosSalary = " + this.herosSalary + "\n") + (this.iron != null ? this.iron.toDebugString(param1 + "iron.") : param1 + "iron = null\n") + (param1 + "maxPopulation = " + this.maxPopulation + "\n") + (param1 + "populationDirection = " + this.populationDirection + "\n") + (this.stone != null ? this.stone.toDebugString(param1 + "stone.") : param1 + "stone = null\n") + (param1 + "supplyFood = " + this.supplyFood + "\n") + (param1 + "support = " + this
         .support + "\n") + (param1 + "taxIncome = " + this.taxIncome + "\n") + (param1 + "texRate = " + this.texRate + "\n") + (param1 + "troopCostFood = " + this.troopCostFood + "\n") + (this.wood != null ? this.wood.toDebugString(param1 + "wood.") : param1 + "wood = null\n") + (param1 + "workPeople = " + this.workPeople + "\n");
      }
      
      public function set stone(param1:ResourceInfoBean) : void
      {
         var _loc2_:Object = this._109770853stone;
         if(_loc2_ !== param1)
         {
            this._109770853stone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stone",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get support() : int
      {
         return this._1854767153support;
      }
      
      [Bindable(event="propertyChange")]
      public function get maxPopulation() : int
      {
         return this._1099040721maxPopulation;
      }
      
      public function copyTo(param1:CastleResourceBean) : void
      {
         param1.buildPeople = this.buildPeople;
         param1.colonyFood = this.colonyFood;
         param1.colonyGold = this.colonyGold;
         param1.colonyIron = this.colonyIron;
         param1.colonyStone = this.colonyStone;
         param1.colonyWood = this.colonyWood;
         param1.complaint = this.complaint;
         param1.curPopulation = this.curPopulation;
         if(this.food != null)
         {
            this.food.copyTo(param1.food);
         }
         else
         {
            param1.food = null;
         }
         param1.gold = this.gold;
         param1.herosSalary = this.herosSalary;
         if(this.iron != null)
         {
            this.iron.copyTo(param1.iron);
         }
         else
         {
            param1.iron = null;
         }
         param1.maxPopulation = this.maxPopulation;
         param1.populationDirection = this.populationDirection;
         if(this.stone != null)
         {
            this.stone.copyTo(param1.stone);
         }
         else
         {
            param1.stone = null;
         }
         param1.supplyFood = this.supplyFood;
         param1.support = this.support;
         param1.taxIncome = this.taxIncome;
         param1.texRate = this.texRate;
         param1.troopCostFood = this.troopCostFood;
         if(this.wood != null)
         {
            this.wood.copyTo(param1.wood);
         }
         else
         {
            param1.wood = null;
         }
         param1.workPeople = this.workPeople;
      }
      
      public function set supplyFood(param1:Number) : void
      {
         var _loc2_:Object = this._694674963supplyFood;
         if(_loc2_ !== param1)
         {
            this._694674963supplyFood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"supplyFood",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get colonyIron() : Number
      {
         return this._1197906146colonyIron;
      }
      
      [Bindable(event="propertyChange")]
      public function get herosSalary() : int
      {
         return this._1167488739herosSalary;
      }
      
      [Bindable(event="propertyChange")]
      public function get supplyFood() : Number
      {
         return this._694674963supplyFood;
      }
      
      public function set colonyFood(param1:Number) : void
      {
         var _loc2_:Object = this._1197813880colonyFood;
         if(_loc2_ !== param1)
         {
            this._1197813880colonyFood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonyFood",_loc2_,param1));
         }
      }
      
      public function set colonyGold(param1:Number) : void
      {
         var _loc2_:Object = this._1197843578colonyGold;
         if(_loc2_ !== param1)
         {
            this._1197843578colonyGold = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonyGold",_loc2_,param1));
         }
      }
   }
}

