package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class MilitarySituation implements IEventDispatcher
   {
      
      private var _1316782738startPos:String;
      
      private var _1833139858otherAllianceName:String;
      
      private var _3575610type:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _3355id:int;
      
      private var _3560141time:String;
      
      private var _1407259064attack:Boolean;
      
      private var _31228997eventName:String;
      
      private var _179745070xml_data:String;
      
      private var _815590653targetPos:String;
      
      public function MilitarySituation(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.eventName != null)
            {
               this.eventName = param1.eventName;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.otherAllianceName != null)
            {
               this.otherAllianceName = param1.otherAllianceName;
            }
            if(param1.startPos != null)
            {
               this.startPos = param1.startPos;
            }
            if(param1.targetPos != null)
            {
               this.targetPos = param1.targetPos;
            }
            if(param1.time != null)
            {
               this.time = param1.time;
            }
            if(param1.type != null)
            {
               this.type = param1.type;
            }
            if(param1.xml_data != null)
            {
               this.xml_data = param1.xml_data;
            }
            if(param1.attack != null)
            {
               this.attack = param1.attack;
            }
         }
      }
      
      public function set eventName(param1:String) : void
      {
         var _loc2_:Object = this._31228997eventName;
         if(_loc2_ !== param1)
         {
            this._31228997eventName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"eventName",_loc2_,param1));
         }
      }
      
      public function set targetPos(param1:String) : void
      {
         var _loc2_:Object = this._815590653targetPos;
         if(_loc2_ !== param1)
         {
            this._815590653targetPos = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetPos",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get startPos() : String
      {
         return this._1316782738startPos;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set type(param1:int) : void
      {
         var _loc2_:Object = this._3575610type;
         if(_loc2_ !== param1)
         {
            this._3575610type = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"type",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get otherAllianceName() : String
      {
         return this._1833139858otherAllianceName;
      }
      
      public function toObject() : Object
      {
         return {
            "eventName":this.eventName,
            "id":this.id,
            "otherAllianceName":this.otherAllianceName,
            "startPos":this.startPos,
            "targetPos":this.targetPos,
            "time":this.time,
            "type":this.type,
            "xml_data":this.xml_data,
            "attack":this.attack
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function set attack(param1:Boolean) : void
      {
         var _loc2_:Object = this._1407259064attack;
         if(_loc2_ !== param1)
         {
            this._1407259064attack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"attack",_loc2_,param1));
         }
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
      
      public function set xml_data(param1:String) : void
      {
         var _loc2_:Object = this._179745070xml_data;
         if(_loc2_ !== param1)
         {
            this._179745070xml_data = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"xml_data",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get targetPos() : String
      {
         return this._815590653targetPos;
      }
      
      public function set startPos(param1:String) : void
      {
         var _loc2_:Object = this._1316782738startPos;
         if(_loc2_ !== param1)
         {
            this._1316782738startPos = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startPos",_loc2_,param1));
         }
      }
      
      public function set otherAllianceName(param1:String) : void
      {
         var _loc2_:Object = this._1833139858otherAllianceName;
         if(_loc2_ !== param1)
         {
            this._1833139858otherAllianceName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"otherAllianceName",_loc2_,param1));
         }
      }
      
      public function set id(param1:int) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : int
      {
         return this._3575610type;
      }
      
      [Bindable(event="propertyChange")]
      public function get eventName() : String
      {
         return this._31228997eventName;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get attack() : Boolean
      {
         return this._1407259064attack;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "eventName = " + this.eventName + "\n" + (param1 + "id = " + this.id + "\n") + (param1 + "otherAllianceName = " + this.otherAllianceName + "\n") + (param1 + "startPos = " + this.startPos + "\n") + (param1 + "targetPos = " + this.targetPos + "\n") + (param1 + "time = " + this.time + "\n") + (param1 + "type = " + this.type + "\n") + (param1 + "xml_data = " + this.xml_data + "\n") + (param1 + "attack = " + this.attack + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get time() : String
      {
         return this._3560141time;
      }
      
      public function copyTo(param1:MilitarySituation) : void
      {
         param1.eventName = this.eventName;
         param1.id = this.id;
         param1.otherAllianceName = this.otherAllianceName;
         param1.startPos = this.startPos;
         param1.targetPos = this.targetPos;
         param1.time = this.time;
         param1.type = this.type;
         param1.xml_data = this.xml_data;
         param1.attack = this.attack;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get xml_data() : String
      {
         return this._179745070xml_data;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}

