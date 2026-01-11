package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class UnitAlliance implements IEventDispatcher
   {
      private var _913519701aPrestigeCount:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1358063253memberCount:int;
      
      private var _1191282484leaderName:String;
      
      private var _99462250honor:int;
      
      private var _1606140770allianceName:String;
      
      private var _3492908rank:int;
      
      public function UnitAlliance(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.aPrestigeCount != null)
            {
               this.aPrestigeCount = param1.aPrestigeCount;
            }
            if(param1.allianceName != null)
            {
               this.allianceName = param1.allianceName;
            }
            if(param1.honor != null)
            {
               this.honor = param1.honor;
            }
            if(param1.leaderName != null)
            {
               this.leaderName = param1.leaderName;
            }
            if(param1.memberCount != null)
            {
               this.memberCount = param1.memberCount;
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
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "aPrestigeCount = " + this.aPrestigeCount + "\n" + (param1 + "allianceName = " + this.allianceName + "\n") + (param1 + "honor = " + this.honor + "\n") + (param1 + "leaderName = " + this.leaderName + "\n") + (param1 + "memberCount = " + this.memberCount + "\n") + (param1 + "rank = " + this.rank + "\n");
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
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:UnitAlliance) : void
      {
         param1.aPrestigeCount = this.aPrestigeCount;
         param1.allianceName = this.allianceName;
         param1.honor = this.honor;
         param1.leaderName = this.leaderName;
         param1.memberCount = this.memberCount;
         param1.rank = this.rank;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set honor(param1:int) : void
      {
         var _loc2_:Object = this._99462250honor;
         if(_loc2_ !== param1)
         {
            this._99462250honor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"honor",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get memberCount() : int
      {
         return this._1358063253memberCount;
      }
      
      public function set aPrestigeCount(param1:int) : void
      {
         var _loc2_:Object = this._913519701aPrestigeCount;
         if(_loc2_ !== param1)
         {
            this._913519701aPrestigeCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"aPrestigeCount",_loc2_,param1));
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
            "aPrestigeCount":this.aPrestigeCount,
            "allianceName":this.allianceName,
            "honor":this.honor,
            "leaderName":this.leaderName,
            "memberCount":this.memberCount,
            "rank":this.rank
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceName() : String
      {
         return this._1606140770allianceName;
      }
      
      [Bindable(event="propertyChange")]
      public function get honor() : int
      {
         return this._99462250honor;
      }
      
      [Bindable(event="propertyChange")]
      public function get aPrestigeCount() : int
      {
         return this._913519701aPrestigeCount;
      }
      
      [Bindable(event="propertyChange")]
      public function get rank() : int
      {
         return this._3492908rank;
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
      public function get leaderName() : String
      {
         return this._1191282484leaderName;
      }
      
      public function set leaderName(param1:String) : void
      {
         var _loc2_:Object = this._1191282484leaderName;
         if(_loc2_ !== param1)
         {
            this._1191282484leaderName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"leaderName",_loc2_,param1));
         }
      }
   }
}

