package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class EquipmentBean implements IEventDispatcher
   {
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _124815621addAttribute:int;
      
      private var _3466lv:int;
      
      private var _811315194heroPos:int;
      
      private var _1188050137euipmenttechStarLv:int;
      
      private var _2008330532equipmenttech:int;
      
      private var _1512209195addAttributeType:int;
      
      public function EquipmentBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.addAttribute != null)
            {
               this.addAttribute = param1.addAttribute;
            }
            if(param1.addAttributeType != null)
            {
               this.addAttributeType = param1.addAttributeType;
            }
            if(param1.equipmenttech != null)
            {
               this.equipmenttech = param1.equipmenttech;
            }
            if(param1.euipmenttechStarLv != null)
            {
               this.euipmenttechStarLv = param1.euipmenttechStarLv;
            }
            if(param1.heroPos != null)
            {
               this.heroPos = param1.heroPos;
            }
            if(param1.lv != null)
            {
               this.lv = param1.lv;
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
         return param1 + "addAttribute = " + this.addAttribute + "\n" + (param1 + "addAttributeType = " + this.addAttributeType + "\n") + (param1 + "equipmenttech = " + this.equipmenttech + "\n") + (param1 + "euipmenttechStarLv = " + this.euipmenttechStarLv + "\n") + (param1 + "heroPos = " + this.heroPos + "\n") + (param1 + "lv = " + this.lv + "\n");
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set euipmenttechStarLv(param1:int) : void
      {
         var _loc2_:Object = this._1188050137euipmenttechStarLv;
         if(_loc2_ !== param1)
         {
            this._1188050137euipmenttechStarLv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"euipmenttechStarLv",_loc2_,param1));
         }
      }
      
      public function set equipmenttech(param1:int) : void
      {
         var _loc2_:Object = this._2008330532equipmenttech;
         if(_loc2_ !== param1)
         {
            this._2008330532equipmenttech = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"equipmenttech",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lv() : int
      {
         return this._3466lv;
      }
      
      public function set lv(param1:int) : void
      {
         var _loc2_:Object = this._3466lv;
         if(_loc2_ !== param1)
         {
            this._3466lv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lv",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get addAttributeType() : int
      {
         return this._1512209195addAttributeType;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function toObject() : Object
      {
         return {
            "addAttribute":this.addAttribute,
            "addAttributeType":this.addAttributeType,
            "equipmenttech":this.equipmenttech,
            "euipmenttechStarLv":this.euipmenttechStarLv,
            "heroPos":this.heroPos,
            "lv":this.lv
         };
      }
      
      public function copyTo(param1:EquipmentBean) : void
      {
         param1.addAttribute = this.addAttribute;
         param1.addAttributeType = this.addAttributeType;
         param1.equipmenttech = this.equipmenttech;
         param1.euipmenttechStarLv = this.euipmenttechStarLv;
         param1.heroPos = this.heroPos;
         param1.lv = this.lv;
      }
      
      [Bindable(event="propertyChange")]
      public function get equipmenttech() : int
      {
         return this._2008330532equipmenttech;
      }
      
      [Bindable(event="propertyChange")]
      public function get euipmenttechStarLv() : int
      {
         return this._1188050137euipmenttechStarLv;
      }
      
      public function set addAttributeType(param1:int) : void
      {
         var _loc2_:Object = this._1512209195addAttributeType;
         if(_loc2_ !== param1)
         {
            this._1512209195addAttributeType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"addAttributeType",_loc2_,param1));
         }
      }
      
      public function set heroPos(param1:int) : void
      {
         var _loc2_:Object = this._811315194heroPos;
         if(_loc2_ !== param1)
         {
            this._811315194heroPos = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heroPos",_loc2_,param1));
         }
      }
      
      public function set addAttribute(param1:int) : void
      {
         var _loc2_:Object = this._124815621addAttribute;
         if(_loc2_ !== param1)
         {
            this._124815621addAttribute = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"addAttribute",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heroPos() : int
      {
         return this._811315194heroPos;
      }
      
      [Bindable(event="propertyChange")]
      public function get addAttribute() : int
      {
         return this._124815621addAttribute;
      }
   }
}

