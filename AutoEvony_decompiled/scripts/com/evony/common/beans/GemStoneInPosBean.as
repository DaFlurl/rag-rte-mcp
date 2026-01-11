package com.evony.common.beans
{
   import com.evony.common.*;
   import flash.events.*;
   import mx.collections.*;
   import mx.events.*;
   
   public class GemStoneInPosBean implements IEventDispatcher
   {
      
      private var _1694971109infroArray:ArrayCollection;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _111188pos:int;
      
      public function GemStoneInPosBean(param1:Object = null)
      {
         var _loc2_:int = 0;
         var _loc3_:GemStoneLvInfroBean = null;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.infroArray = new ArrayCollection();
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.pos != null)
            {
               this.pos = param1.pos;
            }
            if(param1.infro)
            {
               _loc2_ = 0;
               _loc3_ = null;
               while(_loc2_ < param1.infro.length)
               {
                  _loc3_ = new GemStoneLvInfroBean(param1.infro[_loc2_]);
                  this.infroArray.addItem(_loc3_);
                  _loc2_++;
               }
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
         var _loc2_:String = "";
         _loc2_ += param1 + "pos = " + this.pos + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.infroArray.length)
         {
            _loc2_ += this.getInfro(_loc3_).toDebugString(param1 + "infro[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function copyTo(param1:GemStoneInPosBean) : void
      {
         param1.pos = this.pos;
         CommonUtil.arrayCopy(this.infroArray,param1.infroArray);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.pos = this.pos;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get pos() : int
      {
         return this._111188pos;
      }
      
      public function setInfro(param1:GemStoneLvInfroBean, param2:int) : void
      {
         this.infroArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get infroArray() : ArrayCollection
      {
         return this._1694971109infroArray;
      }
      
      public function getInfro(param1:int) : GemStoneLvInfroBean
      {
         return this.infroArray[param1] as GemStoneLvInfroBean;
      }
      
      public function set pos(param1:int) : void
      {
         var _loc2_:Object = this._111188pos;
         if(_loc2_ !== param1)
         {
            this._111188pos = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pos",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set infroArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1694971109infroArray;
         if(_loc2_ !== param1)
         {
            this._1694971109infroArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"infroArray",_loc2_,param1));
         }
      }
   }
}

