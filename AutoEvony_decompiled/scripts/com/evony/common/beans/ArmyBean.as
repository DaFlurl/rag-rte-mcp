package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class ArmyBean implements IEventDispatcher
   {
      
      private var _1409292392armyId:int;
      
      private var _1383259878missionType:int;
      
      private var _3292055king:String;
      
      private var _341064690resource:ResourceBean;
      
      private var _995699469startFieldId:int;
      
      private var _1220753771heroid:int;
      
      private var _1911605294targetPosName:String;
      
      private var _962590849direction:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _526788547startPosName:String;
      
      private var _337438527restTime:Number;
      
      private var _1191572123selected:Boolean;
      
      private var _2129294769startTime:Number;
      
      private var _2014132310heroLevel:int;
      
      private var _1134711072reachTime:Number;
      
      private var _1442694372targetFieldId:int;
      
      private var _3198970hero:String;
      
      private var _1806944311alliance:String;
      
      private var _110634834troop:TroopStrBean;
      
      public function ArmyBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.alliance != null)
            {
               this.alliance = param1.alliance;
            }
            if(param1.armyId != null)
            {
               this.armyId = param1.armyId;
            }
            if(param1.direction != null)
            {
               this.direction = param1.direction;
            }
            if(param1.hero != null)
            {
               this.hero = param1.hero;
            }
            if(param1.heroLevel != null)
            {
               this.heroLevel = param1.heroLevel;
            }
            if(param1.heroid != null)
            {
               this.heroid = param1.heroid;
            }
            if(param1.king != null)
            {
               this.king = param1.king;
            }
            if(param1.missionType != null)
            {
               this.missionType = param1.missionType;
            }
            if(param1.reachTime != null)
            {
               this.reachTime = param1.reachTime;
            }
            if(param1.resource != null)
            {
               this.resource = new ResourceBean(param1.resource);
            }
            if(param1.restTime != null)
            {
               this.restTime = param1.restTime;
            }
            if(param1.startFieldId != null)
            {
               this.startFieldId = param1.startFieldId;
            }
            if(param1.startPosName != null)
            {
               this.startPosName = param1.startPosName;
            }
            if(param1.startTime != null)
            {
               this.startTime = param1.startTime;
            }
            if(param1.targetFieldId != null)
            {
               this.targetFieldId = param1.targetFieldId;
            }
            if(param1.targetPosName != null)
            {
               this.targetPosName = param1.targetPosName;
            }
            if(param1.troop != null)
            {
               this.troop = new TroopStrBean(param1.troop);
            }
            if(param1.selected != null)
            {
               this.selected = param1.selected;
            }
         }
      }
      
      public function set startPosName(param1:String) : void
      {
         var _loc2_:Object = this._526788547startPosName;
         if(_loc2_ !== param1)
         {
            this._526788547startPosName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startPosName",_loc2_,param1));
         }
      }
      
      public function set restTime(param1:Number) : void
      {
         var _loc2_:Object = this._337438527restTime;
         if(_loc2_ !== param1)
         {
            this._337438527restTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get direction() : int
      {
         return this._962590849direction;
      }
      
      [Bindable(event="propertyChange")]
      public function get hero() : String
      {
         return this._3198970hero;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get resource() : ResourceBean
      {
         return this._341064690resource;
      }
      
      [Bindable(event="propertyChange")]
      public function get king() : String
      {
         return this._3292055king;
      }
      
      [Bindable(event="propertyChange")]
      public function get armyId() : int
      {
         return this._1409292392armyId;
      }
      
      public function toObject() : Object
      {
         return {
            "alliance":this.alliance,
            "armyId":this.armyId,
            "direction":this.direction,
            "hero":this.hero,
            "heroLevel":this.heroLevel,
            "heroid":this.heroid,
            "king":this.king,
            "missionType":this.missionType,
            "reachTime":this.reachTime,
            "resource":this.resource.toObject(),
            "restTime":this.restTime,
            "startFieldId":this.startFieldId,
            "startPosName":this.startPosName,
            "startTime":this.startTime,
            "targetFieldId":this.targetFieldId,
            "targetPosName":this.targetPosName,
            "troop":this.troop.toObject(),
            "selected":this.selected
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get selected() : Boolean
      {
         return this._1191572123selected;
      }
      
      public function set resource(param1:ResourceBean) : void
      {
         var _loc2_:Object = this._341064690resource;
         if(_loc2_ !== param1)
         {
            this._341064690resource = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resource",_loc2_,param1));
         }
      }
      
      public function set troop(param1:TroopStrBean) : void
      {
         var _loc2_:Object = this._110634834troop;
         if(_loc2_ !== param1)
         {
            this._110634834troop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troop",_loc2_,param1));
         }
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
      public function get heroid() : int
      {
         return this._1220753771heroid;
      }
      
      [Bindable(event="propertyChange")]
      public function get targetPosName() : String
      {
         return this._1911605294targetPosName;
      }
      
      public function set armyId(param1:int) : void
      {
         var _loc2_:Object = this._1409292392armyId;
         if(_loc2_ !== param1)
         {
            this._1409292392armyId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"armyId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heroLevel() : int
      {
         return this._2014132310heroLevel;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:Object = this._1191572123selected;
         if(_loc2_ !== param1)
         {
            this._1191572123selected = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selected",_loc2_,param1));
         }
      }
      
      public function set heroid(param1:int) : void
      {
         var _loc2_:Object = this._1220753771heroid;
         if(_loc2_ !== param1)
         {
            this._1220753771heroid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heroid",_loc2_,param1));
         }
      }
      
      public function set king(param1:String) : void
      {
         var _loc2_:Object = this._3292055king;
         if(_loc2_ !== param1)
         {
            this._3292055king = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"king",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get alliance() : String
      {
         return this._1806944311alliance;
      }
      
      public function set reachTime(param1:Number) : void
      {
         var _loc2_:Object = this._1134711072reachTime;
         if(_loc2_ !== param1)
         {
            this._1134711072reachTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reachTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restTime() : Number
      {
         return this._337438527restTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get startPosName() : String
      {
         return this._526788547startPosName;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function set targetFieldId(param1:int) : void
      {
         var _loc2_:Object = this._1442694372targetFieldId;
         if(_loc2_ !== param1)
         {
            this._1442694372targetFieldId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetFieldId",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "alliance = " + this.alliance + "\n" + (param1 + "armyId = " + this.armyId + "\n") + (param1 + "direction = " + this.direction + "\n") + (param1 + "hero = " + this.hero + "\n") + (param1 + "heroLevel = " + this.heroLevel + "\n") + (param1 + "heroid = " + this.heroid + "\n") + (param1 + "king = " + this.king + "\n") + (param1 + "missionType = " + this.missionType + "\n") + (param1 + "reachTime = " + this.reachTime + "\n") + (this.resource != null ? this.resource.toDebugString(param1 + "resource.") : param1 + "resource = null\n") + (param1 + "restTime = " + this.restTime + "\n") + (param1 + "startFieldId = " + this.startFieldId + "\n") + (param1 + "startPosName = " + this.startPosName + "\n") + (param1 + "startTime = " + this.startTime + "\n") + (param1 + "targetFieldId = " + this.targetFieldId + "\n") + (param1 + "targetPosName = " + this.targetPosName + "\n") + (this.troop != null ? this.troop.toDebugString(param1 + "troop.") : param1 + "troop = null\n") + (param1 + "selected = " + this
         .selected + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set missionType(param1:int) : void
      {
         var _loc2_:Object = this._1383259878missionType;
         if(_loc2_ !== param1)
         {
            this._1383259878missionType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"missionType",_loc2_,param1));
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
      
      [Bindable(event="propertyChange")]
      public function get troop() : TroopStrBean
      {
         return this._110634834troop;
      }
      
      public function copyTo(param1:ArmyBean) : void
      {
         param1.alliance = this.alliance;
         param1.armyId = this.armyId;
         param1.direction = this.direction;
         param1.hero = this.hero;
         param1.heroLevel = this.heroLevel;
         param1.heroid = this.heroid;
         param1.king = this.king;
         param1.missionType = this.missionType;
         param1.reachTime = this.reachTime;
         if(this.resource != null)
         {
            this.resource.copyTo(param1.resource);
         }
         else
         {
            param1.resource = null;
         }
         param1.restTime = this.restTime;
         param1.startFieldId = this.startFieldId;
         param1.startPosName = this.startPosName;
         param1.startTime = this.startTime;
         param1.targetFieldId = this.targetFieldId;
         param1.targetPosName = this.targetPosName;
         if(this.troop != null)
         {
            this.troop.copyTo(param1.troop);
         }
         else
         {
            param1.troop = null;
         }
         param1.selected = this.selected;
      }
      
      public function set targetPosName(param1:String) : void
      {
         var _loc2_:Object = this._1911605294targetPosName;
         if(_loc2_ !== param1)
         {
            this._1911605294targetPosName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetPosName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reachTime() : Number
      {
         return this._1134711072reachTime;
      }
      
      public function set heroLevel(param1:int) : void
      {
         var _loc2_:Object = this._2014132310heroLevel;
         if(_loc2_ !== param1)
         {
            this._2014132310heroLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heroLevel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get targetFieldId() : int
      {
         return this._1442694372targetFieldId;
      }
      
      [Bindable(event="propertyChange")]
      public function get missionType() : int
      {
         return this._1383259878missionType;
      }
      
      public function set startFieldId(param1:int) : void
      {
         var _loc2_:Object = this._995699469startFieldId;
         if(_loc2_ !== param1)
         {
            this._995699469startFieldId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startFieldId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get startFieldId() : int
      {
         return this._995699469startFieldId;
      }
      
      public function set hero(param1:String) : void
      {
         var _loc2_:Object = this._3198970hero;
         if(_loc2_ !== param1)
         {
            this._3198970hero = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hero",_loc2_,param1));
         }
      }
      
      public function set alliance(param1:String) : void
      {
         var _loc2_:Object = this._1806944311alliance;
         if(_loc2_ !== param1)
         {
            this._1806944311alliance = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alliance",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set direction(param1:int) : void
      {
         var _loc2_:Object = this._962590849direction;
         if(_loc2_ !== param1)
         {
            this._962590849direction = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"direction",_loc2_,param1));
         }
      }
   }
}

