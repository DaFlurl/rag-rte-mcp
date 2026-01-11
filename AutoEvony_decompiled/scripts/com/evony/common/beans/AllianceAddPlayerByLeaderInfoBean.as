package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class AllianceAddPlayerByLeaderInfoBean implements IEventDispatcher
   {
      
      private var _1358063253memberCount:int;
      
      private var _1276224445prestige:int;
      
      private var _1606140770allianceName:String;
      
      private var _3492908rank:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function AllianceAddPlayerByLeaderInfoBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.allianceName != null)
            {
               this.allianceName = param1.allianceName;
            }
            if(param1.memberCount != null)
            {
               this.memberCount = param1.memberCount;
            }
            if(param1.prestige != null)
            {
               this.prestige = param1.prestige;
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
      
      [Bindable(event="propertyChange")]
      public function get prestige() : int
      {
         return this._1276224445prestige;
      }
      
      public function set allianceName(param1:String) : void
      {
         var _loc2_:Object = this._1606140770allianceName;
         if(_loc2_ !== param1)
         {
            this._1606140770allianceName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceName",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "allianceName = " + this.allianceName + "\n" + (param1 + "memberCount = " + this.memberCount + "\n") + (param1 + "prestige = " + this.prestige + "\n") + (param1 + "rank = " + this.rank + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function copyTo(param1:AllianceAddPlayerByLeaderInfoBean) : void
      {
         param1.allianceName = this.allianceName;
         param1.memberCount = this.memberCount;
         param1.prestige = this.prestige;
         param1.rank = this.rank;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set prestige(param1:int) : void
      {
         var _loc2_:Object = this._1276224445prestige;
         if(_loc2_ !== param1)
         {
            this._1276224445prestige = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prestige",_loc2_,param1));
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
      
      public function toObject() : Object
      {
         return {
            "allianceName":this.allianceName,
            "memberCount":this.memberCount,
            "prestige":this.prestige,
            "rank":this.rank
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get memberCount() : int
      {
         return this._1358063253memberCount;
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceName() : String
      {
         return this._1606140770allianceName;
      }
      
      public function set memberCount(param1:int) : void
      {
         var _loc2_:Object = this._1358063253memberCount;
         if(_loc2_ !== param1)
         {
            this._1358063253memberCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"memberCount",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rank() : int
      {
         return this._3492908rank;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
   }
}

