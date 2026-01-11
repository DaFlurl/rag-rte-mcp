package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class FortProduceListBean implements IEventDispatcher
   {
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1371991915conditionBean:ConditionBean;
      
      private var _858803723typeId:int;
      
      private var _676059661permition:Boolean;
      
      public function FortProduceListBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.conditionBean != null)
            {
               this.conditionBean = new ConditionBean(param1.conditionBean);
            }
            if(param1.typeId != null)
            {
               this.typeId = param1.typeId;
            }
            if(param1.permition != null)
            {
               this.permition = param1.permition;
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
         return (this.conditionBean != null ? this.conditionBean.toDebugString(param1 + "conditionBean.") : param1 + "conditionBean = null\n") + (param1 + "typeId = " + this.typeId + "\n") + (param1 + "permition = " + this.permition + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:FortProduceListBean) : void
      {
         if(this.conditionBean != null)
         {
            this.conditionBean.copyTo(param1.conditionBean);
         }
         else
         {
            param1.conditionBean = null;
         }
         param1.typeId = this.typeId;
         param1.permition = this.permition;
      }
      
      [Bindable(event="propertyChange")]
      public function get permition() : Boolean
      {
         return this._676059661permition;
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
      
      public function set permition(param1:Boolean) : void
      {
         var _loc2_:Object = this._676059661permition;
         if(_loc2_ !== param1)
         {
            this._676059661permition = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"permition",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "conditionBean":this.conditionBean.toObject(),
            "typeId":this.typeId,
            "permition":this.permition
         };
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
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get typeId() : int
      {
         return this._858803723typeId;
      }
   }
}

