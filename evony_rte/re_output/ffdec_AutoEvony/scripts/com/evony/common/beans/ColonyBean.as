package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class ColonyBean implements IEventDispatcher
   {
      
      private var _1607243192endTime:Number;
      
      private var _1962855648lordName:String;
      
      private var _892481550status:int;
      
      private var _554436100relation:int;
      
      private var _30247582isCanLevy:Boolean;
      
      private var _1421682026cityName:String;
      
      private var _747804969position:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _342500292logoUrl:String;
      
      private var _2129294769startTime:Number;
      
      private var _3560141time:String;
      
      private var _35872819castleId:int;
      
      private var _1276224445prestige:int;
      
      private var _1606140770allianceName:String;
      
      private var _1458266657isCanOverview:Boolean;
      
      public function ColonyBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.allianceName != null)
            {
               this.allianceName = param1.allianceName;
            }
            if(param1.castleId != null)
            {
               this.castleId = param1.castleId;
            }
            if(param1.cityName != null)
            {
               this.cityName = param1.cityName;
            }
            if(param1.endTime != null)
            {
               this.endTime = param1.endTime;
            }
            if(param1.isCanLevy != null)
            {
               this.isCanLevy = param1.isCanLevy;
            }
            if(param1.isCanOverview != null)
            {
               this.isCanOverview = param1.isCanOverview;
            }
            if(param1.logoUrl != null)
            {
               this.logoUrl = param1.logoUrl;
            }
            if(param1.lordName != null)
            {
               this.lordName = param1.lordName;
            }
            if(param1.position != null)
            {
               this.position = param1.position;
            }
            if(param1.prestige != null)
            {
               this.prestige = param1.prestige;
            }
            if(param1.relation != null)
            {
               this.relation = param1.relation;
            }
            if(param1.startTime != null)
            {
               this.startTime = param1.startTime;
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
            if(param1.time != null)
            {
               this.time = param1.time;
            }
         }
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
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set logoUrl(param1:String) : void
      {
         var _loc2_:Object = this._342500292logoUrl;
         if(_loc2_ !== param1)
         {
            this._342500292logoUrl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoUrl",_loc2_,param1));
         }
      }
      
      public function set endTime(param1:Number) : void
      {
         var _loc2_:Object = this._1607243192endTime;
         if(_loc2_ !== param1)
         {
            this._1607243192endTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endTime",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "allianceName":this.allianceName,
            "castleId":this.castleId,
            "cityName":this.cityName,
            "endTime":this.endTime,
            "isCanLevy":this.isCanLevy,
            "isCanOverview":this.isCanOverview,
            "logoUrl":this.logoUrl,
            "lordName":this.lordName,
            "position":this.position,
            ".prestige":this.prestige,
            "relation":this.relation,
            "startTime":this.startTime,
            "status":this.status,
            "time":this.time
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get cityName() : String
      {
         return this._1421682026cityName;
      }
      
      public function set startTime(param1:Number) : void
      {
         var _loc2_:Object = this._2129294769startTime;
         if(_loc2_ !== param1)
         {
            this._2129294769startTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lordName() : String
      {
         return this._1962855648lordName;
      }
      
      public function set time(param1:String) : void
      {
         var _loc2_:Object = this._3560141time;
         if(_loc2_ !== param1)
         {
            this._3560141time = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"time",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get position() : String
      {
         return this._747804969position;
      }
      
      public function set cityName(param1:String) : void
      {
         var _loc2_:Object = this._1421682026cityName;
         if(_loc2_ !== param1)
         {
            this._1421682026cityName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cityName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get castleId() : int
      {
         return this._35872819castleId;
      }
      
      public function set isCanOverview(param1:Boolean) : void
      {
         var _loc2_:Object = this._1458266657isCanOverview;
         if(_loc2_ !== param1)
         {
            this._1458266657isCanOverview = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isCanOverview",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get prestige() : int
      {
         return this._1276224445prestige;
      }
      
      public function set isCanLevy(param1:Boolean) : void
      {
         var _loc2_:Object = this._30247582isCanLevy;
         if(_loc2_ !== param1)
         {
            this._30247582isCanLevy = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isCanLevy",_loc2_,param1));
         }
      }
      
      public function set lordName(param1:String) : void
      {
         var _loc2_:Object = this._1962855648lordName;
         if(_loc2_ !== param1)
         {
            this._1962855648lordName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lordName",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "allianceName = " + this.allianceName + "\n" + (param1 + "castleId = " + this.castleId + "\n") + (param1 + "cityName = " + this.cityName + "\n") + (param1 + "endTime = " + this.endTime + "\n") + (param1 + "isCanLevy = " + this.isCanLevy + "\n") + (param1 + "isCanOverview = " + this.isCanOverview + "\n") + (param1 + "logoUrl = " + this.logoUrl + "\n") + (param1 + "lordName = " + this.lordName + "\n") + (param1 + "position = " + this.position + "\n") + (param1 + "prestige = " + this.prestige + "\n") + (param1 + "relation = " + this.relation + "\n") + (param1 + "startTime = " + this.startTime + "\n") + (param1 + "status = " + this.status + "\n") + (param1 + "time = " + this.time + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get logoUrl() : String
      {
         return this._342500292logoUrl;
      }
      
      [Bindable(event="propertyChange")]
      public function get time() : String
      {
         return this._3560141time;
      }
      
      [Bindable(event="propertyChange")]
      public function get endTime() : Number
      {
         return this._1607243192endTime;
      }
      
      public function copyTo(param1:ColonyBean) : void
      {
         param1.allianceName = this.allianceName;
         param1.castleId = this.castleId;
         param1.cityName = this.cityName;
         param1.endTime = this.endTime;
         param1.isCanLevy = this.isCanLevy;
         param1.isCanOverview = this.isCanOverview;
         param1.logoUrl = this.logoUrl;
         param1.lordName = this.lordName;
         param1.position = this.position;
         param1.prestige = this.prestige;
         param1.relation = this.relation;
         param1.startTime = this.startTime;
         param1.status = this.status;
         param1.time = this.time;
      }
      
      public function set position(param1:String) : void
      {
         var _loc2_:Object = this._747804969position;
         if(_loc2_ !== param1)
         {
            this._747804969position = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"position",_loc2_,param1));
         }
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
      
      [Bindable(event="propertyChange")]
      public function get startTime() : Number
      {
         return this._2129294769startTime;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get isCanOverview() : Boolean
      {
         return this._1458266657isCanOverview;
      }
      
      [Bindable(event="propertyChange")]
      public function get isCanLevy() : Boolean
      {
         return this._30247582isCanLevy;
      }
      
      public function set status(param1:int) : void
      {
         var _loc2_:Object = this._892481550status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
         }
      }
      
      public function set castleId(param1:int) : void
      {
         var _loc2_:Object = this._35872819castleId;
         if(_loc2_ !== param1)
         {
            this._35872819castleId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceName() : String
      {
         return this._1606140770allianceName;
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      public function set relation(param1:int) : void
      {
         var _loc2_:Object = this._554436100relation;
         if(_loc2_ !== param1)
         {
            this._554436100relation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"relation",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get relation() : int
      {
         return this._554436100relation;
      }
   }
}

