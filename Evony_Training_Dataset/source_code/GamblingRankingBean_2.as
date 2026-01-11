package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class GamblingRankingBean implements IEventDispatcher
   {
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _260292359isReward:int;
      
      private var _809208522itemsBeansArray:ArrayCollection;
      
      private var _2095657228playerName:String;
      
      private var _3492908rank:int;
      
      private var _94851343count:int;
      
      public function GamblingRankingBean(param1:Object = null)
      {
         var _loc2_:ItemBean = null;
         var _loc3_:int = 0;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.itemsBeansArray = new ArrayCollection();
         super();
         if(param1 != null)
         {
            if(param1.count != null)
            {
               this.count = param1.count;
            }
            if(param1.isReward != null)
            {
               this.isReward = param1.isReward;
            }
            if(param1.playerName != null)
            {
               this.playerName = param1.playerName;
            }
            if(param1.rank != null)
            {
               this.rank = param1.rank;
            }
            if(param1.itemsBeans)
            {
               _loc2_ = null;
               _loc3_ = 0;
               while(_loc3_ < param1.itemsBeans.length)
               {
                  _loc2_ = new ItemBean(param1.itemsBeans[_loc3_]);
                  this.itemsBeansArray.addItem(_loc2_);
                  _loc3_++;
               }
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
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = param1 + "count = " + this.count + "\n" + (param1 + "isReward = " + this.isReward + "\n") + (param1 + "playerName = " + this.playerName + "\n") + (param1 + "rank = " + this.rank + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.itemsBeansArray.length)
         {
            _loc2_ += this.getItemsBeans(_loc3_).toDebugString(param1 + "itemsBeans[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      [Bindable(event="propertyChange")]
      public function get playerName() : String
      {
         return this._2095657228playerName;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get count() : int
      {
         return this._94851343count;
      }
      
      public function copyTo(param1:GamblingRankingBean) : void
      {
         param1.count = this.count;
         param1.isReward = this.isReward;
         param1.playerName = this.playerName;
         param1.rank = this.rank;
         CommonUtil.arrayCopy(this.itemsBeansArray,param1.itemsBeansArray);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set playerName(param1:String) : void
      {
         var _loc2_:Object = this._2095657228playerName;
         if(_loc2_ !== param1)
         {
            this._2095657228playerName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerName",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "count":this.count,
            "isReward":this.isReward,
            "playerName":this.playerName,
            "rank":this.rank
         };
      }
      
      public function set count(param1:int) : void
      {
         var _loc2_:Object = this._94851343count;
         if(_loc2_ !== param1)
         {
            this._94851343count = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"count",_loc2_,param1));
         }
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
      
      public function getItemsBeans(param1:int) : ItemBean
      {
         return this.itemsBeansArray[param1] as ItemBean;
      }
      
      public function setItemsBeans(param1:ItemBean, param2:int) : void
      {
         this.itemsBeansArray[param2] = param1;
      }
      
      public function set isReward(param1:int) : void
      {
         var _loc2_:Object = this._260292359isReward;
         if(_loc2_ !== param1)
         {
            this._260292359isReward = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isReward",_loc2_,param1));
         }
      }
      
      public function set itemsBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._809208522itemsBeansArray;
         if(_loc2_ !== param1)
         {
            this._809208522itemsBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemsBeansArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemsBeansArray() : ArrayCollection
      {
         return this._809208522itemsBeansArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get isReward() : int
      {
         return this._260292359isReward;
      }
      
      [Bindable(event="propertyChange")]
      public function get rank() : int
      {
         return this._3492908rank;
      }
   }
}

