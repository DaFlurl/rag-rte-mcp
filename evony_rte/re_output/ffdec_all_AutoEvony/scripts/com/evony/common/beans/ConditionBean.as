package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class ConditionBean implements IEventDispatcher
   {
      
      private var _109770853stone:int;
      
      private var _3178592gold:int;
      
      private var _3241160iron:int;
      
      private var _895975549destructTime:Number;
      
      private var _1425640839itemsArray:ArrayCollection;
      
      private var _1578480708techsArray:ArrayCollection;
      
      private var _3655341wood:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _2023558323population:int;
      
      private var _3148894food:int;
      
      private var _1632439642buildingsArray:ArrayCollection;
      
      private var _3560141time:Number;
      
      public function ConditionBean(param1:Object = null)
      {
         var _loc2_:int = 0;
         var _loc3_:ConditionDependBuildingBean = null;
         var _loc4_:ConditionDependItemBean = null;
         var _loc5_:ConditionDependTechBean = null;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         this.buildingsArray = new ArrayCollection();
         this.itemsArray = new ArrayCollection();
         this.techsArray = new ArrayCollection();
         if(param1 != null)
         {
            if(param1.destructTime != null)
            {
               this.destructTime = param1.destructTime;
            }
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
            if(param1.population != null)
            {
               this.population = param1.population;
            }
            if(param1.stone != null)
            {
               this.stone = param1.stone;
            }
            if(param1.time != null)
            {
               this.time = param1.time;
            }
            if(param1.wood != null)
            {
               this.wood = param1.wood;
            }
            _loc2_ = 0;
            if(param1.buildings)
            {
               _loc3_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.buildings.length)
               {
                  _loc3_ = new ConditionDependBuildingBean(param1.buildings[_loc2_]);
                  this.buildingsArray.addItem(_loc3_);
                  _loc2_++;
               }
            }
            if(param1.items)
            {
               _loc4_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.items.length)
               {
                  _loc4_ = new ConditionDependItemBean(param1.items[_loc2_]);
                  this.itemsArray.addItem(_loc4_);
                  _loc2_++;
               }
            }
            if(param1.techs)
            {
               _loc5_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.techs.length)
               {
                  _loc5_ = new ConditionDependTechBean(param1.techs[_loc2_]);
                  this.techsArray.addItem(_loc5_);
                  _loc2_++;
               }
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get destructTime() : Number
      {
         return this._895975549destructTime;
      }
      
      public function set destructTime(param1:Number) : void
      {
         var _loc2_:Object = this._895975549destructTime;
         if(_loc2_ !== param1)
         {
            this._895975549destructTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"destructTime",_loc2_,param1));
         }
      }
      
      public function getBuildings(param1:int) : ConditionDependBuildingBean
      {
         return this.buildingsArray[param1] as ConditionDependBuildingBean;
      }
      
      public function getItems(param1:int) : ConditionDependItemBean
      {
         return this.itemsArray[param1] as ConditionDependItemBean;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set iron(param1:int) : void
      {
         var _loc2_:Object = this._3241160iron;
         if(_loc2_ !== param1)
         {
            this._3241160iron = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iron",_loc2_,param1));
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
      
      public function toObject() : Object
      {
         return {
            "destructTime":this.destructTime,
            "food":this.food,
            "gold":this.gold,
            "iron":this.iron,
            "population":this.population,
            "stone":this.stone,
            "time":this.time,
            "wood":this.wood
         };
      }
      
      public function set time(param1:Number) : void
      {
         var _loc2_:Object = this._3560141time;
         if(_loc2_ !== param1)
         {
            this._3560141time = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"time",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wood() : int
      {
         return this._3655341wood;
      }
      
      public function set buildingsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1632439642buildingsArray;
         if(_loc2_ !== param1)
         {
            this._1632439642buildingsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buildingsArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get techsArray() : ArrayCollection
      {
         return this._1578480708techsArray;
      }
      
      public function set food(param1:int) : void
      {
         var _loc2_:Object = this._3148894food;
         if(_loc2_ !== param1)
         {
            this._3148894food = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"food",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iron() : int
      {
         return this._3241160iron;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = param1 + "destructTime = " + this.destructTime + "\n" + (param1 + "food = " + this.food + "\n") + (param1 + "gold = " + this.gold + "\n") + (param1 + "iron = " + this.iron + "\n") + (param1 + "population = " + this.population + "\n") + (param1 + "stone = " + this.stone + "\n") + (param1 + "time = " + this.time + "\n") + (param1 + "wood = " + this.wood + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.buildingsArray.length)
         {
            _loc2_ += this.getBuildings(_loc3_).toDebugString(param1 + "buildingsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.itemsArray.length)
         {
            _loc2_ += this.getItems(_loc3_).toDebugString(param1 + "itemsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.techsArray.length)
         {
            _loc2_ += this.getTechs(_loc3_).toDebugString(param1 + "techsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function set stone(param1:int) : void
      {
         var _loc2_:Object = this._109770853stone;
         if(_loc2_ !== param1)
         {
            this._109770853stone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stone",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get population() : int
      {
         return this._2023558323population;
      }
      
      public function set gold(param1:int) : void
      {
         var _loc2_:Object = this._3178592gold;
         if(_loc2_ !== param1)
         {
            this._3178592gold = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gold",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get buildingsArray() : ArrayCollection
      {
         return this._1632439642buildingsArray;
      }
      
      public function setTechs(param1:ConditionDependTechBean, param2:int) : void
      {
         this.techsArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get time() : Number
      {
         return this._3560141time;
      }
      
      [Bindable(event="propertyChange")]
      public function get food() : int
      {
         return this._3148894food;
      }
      
      public function copyTo(param1:ConditionBean) : void
      {
         param1.destructTime = this.destructTime;
         param1.food = this.food;
         param1.gold = this.gold;
         param1.iron = this.iron;
         param1.population = this.population;
         param1.stone = this.stone;
         param1.time = this.time;
         param1.wood = this.wood;
         CommonUtil.arrayCopy(this.buildingsArray,param1.buildingsArray);
         CommonUtil.arrayCopy(this.itemsArray,param1.itemsArray);
         CommonUtil.arrayCopy(this.techsArray,param1.techsArray);
      }
      
      public function set wood(param1:int) : void
      {
         var _loc2_:Object = this._3655341wood;
         if(_loc2_ !== param1)
         {
            this._3655341wood = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wood",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stone() : int
      {
         return this._109770853stone;
      }
      
      [Bindable(event="propertyChange")]
      public function get gold() : int
      {
         return this._3178592gold;
      }
      
      public function getTechs(param1:int) : ConditionDependTechBean
      {
         return this.techsArray[param1] as ConditionDependTechBean;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set itemsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1425640839itemsArray;
         if(_loc2_ !== param1)
         {
            this._1425640839itemsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemsArray",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set techsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1578480708techsArray;
         if(_loc2_ !== param1)
         {
            this._1578480708techsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"techsArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemsArray() : ArrayCollection
      {
         return this._1425640839itemsArray;
      }
      
      public function setBuildings(param1:ConditionDependBuildingBean, param2:int) : void
      {
         this.buildingsArray[param2] = param1;
      }
      
      public function setItems(param1:ConditionDependItemBean, param2:int) : void
      {
         this.itemsArray[param2] = param1;
      }
   }
}

