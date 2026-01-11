package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class AvailableResearchListBean implements IEventDispatcher
   {
      private var _1607243192endTime:Number;
      
      private var _1999144890upgradeing:Boolean;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1371991915conditionBean:ConditionBean;
      
      private var _499553710enhancedstarlv:int;
      
      private var _102865796level:int;
      
      private var _3198785help:int;
      
      private var _2129294769startTime:Number;
      
      private var _35872819castleId:Number;
      
      private var _858803723typeId:int;
      
      private var _1780023352avalevel:int;
      
      private var _676059661permition:Boolean;
      
      public function AvailableResearchListBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.avalevel != null)
            {
               this.avalevel = param1.avalevel;
            }
            if(param1.castleId != null)
            {
               this.castleId = param1.castleId;
            }
            if(param1.conditionBean != null)
            {
               this.conditionBean = new ConditionBean(param1.conditionBean);
            }
            if(param1.endTime != null)
            {
               this.endTime = param1.endTime;
            }
            if(param1.enhancedstarlv != null)
            {
               this.enhancedstarlv = param1.enhancedstarlv;
            }
            if(param1.help != null)
            {
               this.help = param1.help;
            }
            if(param1.level != null)
            {
               this.level = param1.level;
            }
            if(param1.startTime != null)
            {
               this.startTime = param1.startTime;
            }
            if(param1.typeId != null)
            {
               this.typeId = param1.typeId;
            }
            if(param1.permition != null)
            {
               this.permition = param1.permition;
            }
            if(param1.upgradeing != null)
            {
               this.upgradeing = param1.upgradeing;
            }
         }
      }
      
      public function set help(param1:int) : void
      {
         var _loc2_:Object = this._3198785help;
         if(_loc2_ !== param1)
         {
            this._3198785help = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"help",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
      }
      
      public function set upgradeing(param1:Boolean) : void
      {
         var _loc2_:Object = this._1999144890upgradeing;
         if(_loc2_ !== param1)
         {
            this._1999144890upgradeing = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"upgradeing",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get permition() : Boolean
      {
         return this._676059661permition;
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
      
      public function set level(param1:int) : void
      {
         var _loc2_:Object = this._102865796level;
         if(_loc2_ !== param1)
         {
            this._102865796level = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"level",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "avalevel":this.avalevel,
            "castleId":this.castleId,
            "conditionBean":this.conditionBean.toObject(),
            "endTime":this.endTime,
            "enhancedstarlv":this.enhancedstarlv,
            "help":this.help,
            "level":this.level,
            "startTime":this.startTime,
            "typeId":this.typeId,
            "permition":this.permition,
            "upgradeing":this.upgradeing
         };
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
      
      public function set permition(param1:Boolean) : void
      {
         var _loc2_:Object = this._676059661permition;
         if(_loc2_ !== param1)
         {
            this._676059661permition = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"permition",_loc2_,param1));
         }
      }
      
      public function set enhancedstarlv(param1:int) : void
      {
         var _loc2_:Object = this._499553710enhancedstarlv;
         if(_loc2_ !== param1)
         {
            this._499553710enhancedstarlv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"enhancedstarlv",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get avalevel() : int
      {
         return this._1780023352avalevel;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get help() : int
      {
         return this._3198785help;
      }
      
      [Bindable(event="propertyChange")]
      public function get upgradeing() : Boolean
      {
         return this._1999144890upgradeing;
      }
      
      [Bindable(event="propertyChange")]
      public function get endTime() : Number
      {
         return this._1607243192endTime;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "avalevel = " + this.avalevel + "\n" + (param1 + "castleId = " + this.castleId + "\n") + (this.conditionBean != null ? this.conditionBean.toDebugString(param1 + "conditionBean.") : param1 + "conditionBean = null\n") + (param1 + "endTime = " + this.endTime + "\n") + (param1 + "enhancedstarlv = " + this.enhancedstarlv + "\n") + (param1 + "help = " + this.help + "\n") + (param1 + "level = " + this.level + "\n") + (param1 + "startTime = " + this.startTime + "\n") + (param1 + "typeId = " + this.typeId + "\n") + (param1 + "permition = " + this.permition + "\n") + (param1 + "upgradeing = " + this.upgradeing + "\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get castleId() : Number
      {
         return this._35872819castleId;
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
      
      public function copyTo(param1:AvailableResearchListBean) : void
      {
         param1.avalevel = this.avalevel;
         param1.castleId = this.castleId;
         if(this.conditionBean != null)
         {
            this.conditionBean.copyTo(param1.conditionBean);
         }
         else
         {
            param1.conditionBean = null;
         }
         param1.endTime = this.endTime;
         param1.enhancedstarlv = this.enhancedstarlv;
         param1.help = this.help;
         param1.level = this.level;
         param1.startTime = this.startTime;
         param1.typeId = this.typeId;
         param1.permition = this.permition;
         param1.upgradeing = this.upgradeing;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get enhancedstarlv() : int
      {
         return this._499553710enhancedstarlv;
      }
      
      public function set conditionBean(param1:ConditionBean) : void
      {
         var _loc2_:Object = this._1371991915conditionBean;
         if(_loc2_ !== param1)
         {
            this._1371991915conditionBean = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"conditionBean",_loc2_,param1));
         }
      }
      
      public function set typeId(param1:int) : void
      {
         var _loc2_:Object = this._858803723typeId;
         if(_loc2_ !== param1)
         {
            this._858803723typeId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"typeId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get conditionBean() : ConditionBean
      {
         return this._1371991915conditionBean;
      }
      
      public function set castleId(param1:Number) : void
      {
         var _loc2_:Object = this._35872819castleId;
         if(_loc2_ !== param1)
         {
            this._35872819castleId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleId",_loc2_,param1));
         }
      }
      
      public function set avalevel(param1:int) : void
      {
         var _loc2_:Object = this._1780023352avalevel;
         if(_loc2_ !== param1)
         {
            this._1780023352avalevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"avalevel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get typeId() : int
      {
         return this._858803723typeId;
      }
   }
}

