package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class CommissionQuestArmyRankBean implements IEventDispatcher
   {
      private var _3492908rank:int;
      
      private var _85567126experience:Number;
      
      private var _1879273436playerId:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function CommissionQuestArmyRankBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.experience != null)
            {
               this.experience = param1.experience;
            }
            if(param1.playerId != null)
            {
               this.playerId = param1.playerId;
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
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "experience = " + this.experience + "\n";
         _loc2_ += param1 + "playerId = " + this.playerId + "\n";
         return _loc2_ + (param1 + "rank = " + this.rank + "\n");
      }
      
      public function copyTo(param1:CommissionQuestArmyRankBean) : void
      {
         param1.experience = this.experience;
         param1.playerId = this.playerId;
         param1.rank = this.rank;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
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
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.experience = this.experience;
         _loc1_.playerId = this.playerId;
         _loc1_.rank = this.rank;
         return _loc1_;
      }
      
      public function set experience(param1:Number) : void
      {
         var _loc2_:Object = this._85567126experience;
         if(_loc2_ !== param1)
         {
            this._85567126experience = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"experience",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get playerId() : int
      {
         return this._1879273436playerId;
      }
      
      [Bindable(event="propertyChange")]
      public function get experience() : Number
      {
         return this._85567126experience;
      }
      
      [Bindable(event="propertyChange")]
      public function get rank() : int
      {
         return this._3492908rank;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set playerId(param1:int) : void
      {
         var _loc2_:Object = this._1879273436playerId;
         if(_loc2_ !== param1)
         {
            this._1879273436playerId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerId",_loc2_,param1));
         }
      }
   }
}

