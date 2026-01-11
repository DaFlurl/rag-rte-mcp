package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class AvailableBuildingListBean implements IEventDispatcher
   {
      
      private var _1371991915conditionBean:ConditionBean;
      
      private var _858803723typeId:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function AvailableBuildingListBean(param1:Object = null)
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
         return (this.conditionBean != null ? this.conditionBean.toDebugString(param1 + "conditionBean.") : param1 + "conditionBean = null\n") + (param1 + "typeId = " + this.typeId + "\n");
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
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:AvailableBuildingListBean) : void
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
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get typeId() : int
      {
         return this._858803723typeId;
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
      
      public function toObject() : Object
      {
         return {
            "conditionBean":this.conditionBean.toObject(),
            "typeId":this.typeId
         };
      }
   }
}

