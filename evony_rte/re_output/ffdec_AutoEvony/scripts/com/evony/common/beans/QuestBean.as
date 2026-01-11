package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class QuestBean implements IEventDispatcher
   {
      
      private var _1081415738manual:String;
      
      private var _600408483isFinish:Boolean;
      
      private var _3373707name:String;
      
      private var _351608024version:int;
      
      private var _1179387200islast:Boolean;
      
      private var _655126941questId:int;
      
      private var _1180608678isCard:Boolean;
      
      private var _328471159targetsArray:ArrayCollection;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _93223517award:String;
      
      private var _1724546052description:String;
      
      private var _989204668recommend:Boolean;
      
      public function QuestBean(param1:Object = null)
      {
         var _loc2_:QuestTargetBean = null;
         var _loc3_:int = 0;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.targetsArray = new ArrayCollection();
         super();
         if(param1 != null)
         {
            if(param1.award != null)
            {
               this.award = param1.award;
            }
            if(param1.description != null)
            {
               this.description = param1.description;
            }
            if(param1.manual != null)
            {
               this.manual = param1.manual;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.questId != null)
            {
               this.questId = param1.questId;
            }
            if(param1.version != null)
            {
               this.version = param1.version;
            }
            if(param1.isCard != null)
            {
               this.isCard = param1.isCard;
            }
            if(param1.isFinish != null)
            {
               this.isFinish = param1.isFinish;
            }
            if(param1.islast != null)
            {
               this.islast = param1.islast;
            }
            if(param1.recommend != null)
            {
               this.recommend = param1.recommend;
            }
            if(param1.targets)
            {
               _loc2_ = null;
               _loc3_ = 0;
               while(_loc3_ < param1.targets.length)
               {
                  _loc2_ = new QuestTargetBean(param1.targets[_loc3_]);
                  this.targetsArray.addItem(_loc2_);
                  _loc3_++;
               }
            }
         }
      }
      
      public function set islast(param1:Boolean) : void
      {
         var _loc2_:Object = this._1179387200islast;
         if(_loc2_ !== param1)
         {
            this._1179387200islast = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"islast",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function set manual(param1:String) : void
      {
         var _loc2_:Object = this._1081415738manual;
         if(_loc2_ !== param1)
         {
            this._1081415738manual = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"manual",_loc2_,param1));
         }
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:Object = this._3373707name;
         if(_loc2_ !== param1)
         {
            this._3373707name = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"name",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "award":this.award,
            "description":this.description,
            "manual":this.manual,
            "name":this.name,
            "questId":this.questId,
            "version":this.version,
            "isCard":this.isCard,
            "isFinish":this.isFinish,
            "islast":this.islast,
            "recommend":this.recommend
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get questId() : int
      {
         return this._655126941questId;
      }
      
      public function set version(param1:int) : void
      {
         var _loc2_:Object = this._351608024version;
         if(_loc2_ !== param1)
         {
            this._351608024version = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"version",_loc2_,param1));
         }
      }
      
      public function set isCard(param1:Boolean) : void
      {
         var _loc2_:Object = this._1180608678isCard;
         if(_loc2_ !== param1)
         {
            this._1180608678isCard = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isCard",_loc2_,param1));
         }
      }
      
      public function set questId(param1:int) : void
      {
         var _loc2_:Object = this._655126941questId;
         if(_loc2_ !== param1)
         {
            this._655126941questId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"questId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get recommend() : Boolean
      {
         return this._989204668recommend;
      }
      
      public function setTargets(param1:QuestTargetBean, param2:int) : void
      {
         this.targetsArray[param2] = param1;
      }
      
      public function set award(param1:String) : void
      {
         var _loc2_:Object = this._93223517award;
         if(_loc2_ !== param1)
         {
            this._93223517award = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"award",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get manual() : String
      {
         return this._1081415738manual;
      }
      
      [Bindable(event="propertyChange")]
      public function get islast() : Boolean
      {
         return this._1179387200islast;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = param1 + "award = " + this.award + "\n" + (param1 + "description = " + this.description + "\n") + (param1 + "manual = " + this.manual + "\n") + (param1 + "name = " + this.name + "\n") + (param1 + "questId = " + this.questId + "\n") + (param1 + "version = " + this.version + "\n") + (param1 + "isCard = " + this.isCard + "\n") + (param1 + "isFinish = " + this.isFinish + "\n") + (param1 + "islast = " + this.islast + "\n") + (param1 + "recommend = " + this.recommend + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.targetsArray.length)
         {
            _loc2_ += this.getTargets(_loc3_).toDebugString(param1 + "targets[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTargets(param1:int) : QuestTargetBean
      {
         return this.targetsArray[param1] as QuestTargetBean;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function copyTo(param1:QuestBean) : void
      {
         param1.award = this.award;
         param1.description = this.description;
         param1.manual = this.manual;
         param1.name = this.name;
         param1.questId = this.questId;
         param1.version = this.version;
         param1.isCard = this.isCard;
         param1.isFinish = this.isFinish;
         param1.islast = this.islast;
         param1.recommend = this.recommend;
         CommonUtil.arrayCopy(this.targetsArray,param1.targetsArray);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set isFinish(param1:Boolean) : void
      {
         var _loc2_:Object = this._600408483isFinish;
         if(_loc2_ !== param1)
         {
            this._600408483isFinish = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isFinish",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get version() : int
      {
         return this._351608024version;
      }
      
      [Bindable(event="propertyChange")]
      public function get isCard() : Boolean
      {
         return this._1180608678isCard;
      }
      
      [Bindable(event="propertyChange")]
      public function get isFinish() : Boolean
      {
         return this._600408483isFinish;
      }
      
      [Bindable(event="propertyChange")]
      public function get award() : String
      {
         return this._93223517award;
      }
      
      public function set targetsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._328471159targetsArray;
         if(_loc2_ !== param1)
         {
            this._328471159targetsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetsArray",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get targetsArray() : ArrayCollection
      {
         return this._328471159targetsArray;
      }
      
      public function set description(param1:String) : void
      {
         var _loc2_:Object = this._1724546052description;
         if(_loc2_ !== param1)
         {
            this._1724546052description = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"description",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get description() : String
      {
         return this._1724546052description;
      }
      
      public function set recommend(param1:Boolean) : void
      {
         var _loc2_:Object = this._989204668recommend;
         if(_loc2_ !== param1)
         {
            this._989204668recommend = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"recommend",_loc2_,param1));
         }
      }
   }
}

