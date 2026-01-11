package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class AllianceAddPlayerInfoBean implements IEventDispatcher
   {
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _109757585state:String;
      
      private var _1198082422inviteTime:Number;
      
      private var _1276224445prestige:int;
      
      private var _266666762userName:String;
      
      private var _187927486invitePerson:String;
      
      private var _3492908rank:int;
      
      public function AllianceAddPlayerInfoBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.invitePerson != null)
            {
               this.invitePerson = param1.invitePerson;
            }
            if(param1.inviteTime != null)
            {
               this.inviteTime = param1.inviteTime;
            }
            if(param1.prestige != null)
            {
               this.prestige = param1.prestige;
            }
            if(param1.rank != null)
            {
               this.rank = param1.rank;
            }
            if(param1.state != null)
            {
               this.state = param1.state;
            }
            if(param1.userName != null)
            {
               this.userName = param1.userName;
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
      
      [Bindable(event="propertyChange")]
      public function get rank() : int
      {
         return this._3492908rank;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "invitePerson = " + this.invitePerson + "\n" + (param1 + "inviteTime = " + this.inviteTime + "\n") + (param1 + "prestige = " + this.prestige + "\n") + (param1 + "rank = " + this.rank + "\n") + (param1 + "state = " + this.state + "\n") + (param1 + "userName = " + this.userName + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function copyTo(param1:AllianceAddPlayerInfoBean) : void
      {
         param1.invitePerson = this.invitePerson;
         param1.inviteTime = this.inviteTime;
         param1.prestige = this.prestige;
         param1.rank = this.rank;
         param1.state = this.state;
         param1.userName = this.userName;
      }
      
      [Bindable(event="propertyChange")]
      public function get state() : String
      {
         return this._109757585state;
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
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
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
            "invitePerson":this.invitePerson,
            "inviteTime":this.inviteTime,
            "prestige":this.prestige,
            "rank":this.rank,
            "state":this.state,
            "userName":this.userName
         };
      }
      
      public function set state(param1:String) : void
      {
         var _loc2_:Object = this._109757585state;
         if(_loc2_ !== param1)
         {
            this._109757585state = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"state",_loc2_,param1));
         }
      }
      
      public function set userName(param1:String) : void
      {
         var _loc2_:Object = this._266666762userName;
         if(_loc2_ !== param1)
         {
            this._266666762userName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"userName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get userName() : String
      {
         return this._266666762userName;
      }
      
      public function set inviteTime(param1:Number) : void
      {
         var _loc2_:Object = this._1198082422inviteTime;
         if(_loc2_ !== param1)
         {
            this._1198082422inviteTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inviteTime",_loc2_,param1));
         }
      }
      
      public function set invitePerson(param1:String) : void
      {
         var _loc2_:Object = this._187927486invitePerson;
         if(_loc2_ !== param1)
         {
            this._187927486invitePerson = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"invitePerson",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get inviteTime() : Number
      {
         return this._1198082422inviteTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get invitePerson() : String
      {
         return this._187927486invitePerson;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
   }
}

