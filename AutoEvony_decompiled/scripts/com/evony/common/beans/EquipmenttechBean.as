package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class EquipmenttechBean implements IEventDispatcher
   {
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _3466lv:int;
      
      private var _1565328703equipmenttechid:int;
      
      public function EquipmenttechBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.equipmenttechid != null)
            {
               this.equipmenttechid = param1.equipmenttechid;
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
         return param1 + "equipmenttechid = " + this.equipmenttechid + "\n" + (param1 + "lv = " + this.lv + "\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get lv() : int
      {
         return this._3466lv;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:EquipmenttechBean) : void
      {
         param1.equipmenttechid = this.equipmenttechid;
         param1.lv = this.lv;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function toObject() : Object
      {
         return {
            "equipmenttechid":this.equipmenttechid,
            "lv":this.lv
         };
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
      
      public function set equipmenttechid(param1:int) : void
      {
         var _loc2_:Object = this._1565328703equipmenttechid;
         if(_loc2_ !== param1)
         {
            this._1565328703equipmenttechid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"equipmenttechid",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get equipmenttechid() : int
      {
         return this._1565328703equipmenttechid;
      }
   }
}

