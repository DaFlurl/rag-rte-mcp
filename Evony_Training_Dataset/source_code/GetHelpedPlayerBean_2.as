package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class GetHelpedPlayerBean implements IEventDispatcher
   {
      private var _2095387960playerFBID:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function GetHelpedPlayerBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.playerFBID != null)
            {
               this.playerFBID = param1.playerFBID;
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
         var _loc2_:String = "";
         return _loc2_ + (param1 + "playerFBID = " + this.playerFBID + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function copyTo(param1:GetHelpedPlayerBean) : void
      {
         param1.playerFBID = this.playerFBID;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set playerFBID(param1:String) : void
      {
         var _loc2_:Object = this._2095387960playerFBID;
         if(_loc2_ !== param1)
         {
            this._2095387960playerFBID = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerFBID",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playerFBID() : String
      {
         return this._2095387960playerFBID;
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.playerFBID = this.playerFBID;
         return _loc1_;
      }
   }
}

