package com.evony.common.beans
{
   import com.evony.common.*;
   import flash.events.*;
   import mx.collections.*;
   import mx.events.*;
   
   public class GemStoneLvInfroBean implements IEventDispatcher
   {
      
      private var _353643255gemstoneidsArray:ArrayCollection;
      
      private var _3466lv:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function GemStoneLvInfroBean(param1:Object = null)
      {
         var _loc2_:int = 0;
         var _loc3_:GemStoneBean = null;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.gemstoneidsArray = new ArrayCollection();
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.lv != null)
            {
               this.lv = param1.lv;
            }
            if(param1.gemstoneids)
            {
               _loc2_ = 0;
               _loc3_ = null;
               while(_loc2_ < param1.gemstoneids.length)
               {
                  _loc3_ = new GemStoneBean(param1.gemstoneids[_loc2_]);
                  this.gemstoneidsArray.addItem(_loc3_);
                  _loc2_++;
               }
            }
         }
      }
      
      public function setGemstoneids(param1:GemStoneBean, param2:int) : void
      {
         this.gemstoneidsArray[param2] = param1;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "lv = " + this.lv + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.gemstoneidsArray.length)
         {
            _loc2_ += this.getGemstoneids(_loc3_).toDebugString(param1 + "gemstoneids[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:GemStoneLvInfroBean) : void
      {
         param1.lv = this.lv;
         CommonUtil.arrayCopy(this.gemstoneidsArray,param1.gemstoneidsArray);
      }
      
      [Bindable(event="propertyChange")]
      public function get lv() : int
      {
         return this._3466lv;
      }
      
      public function getGemstoneids(param1:int) : GemStoneBean
      {
         return this.gemstoneidsArray[param1] as GemStoneBean;
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
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.lv = this.lv;
         return _loc1_;
      }
      
      public function set gemstoneidsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._353643255gemstoneidsArray;
         if(_loc2_ !== param1)
         {
            this._353643255gemstoneidsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gemstoneidsArray",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get gemstoneidsArray() : ArrayCollection
      {
         return this._353643255gemstoneidsArray;
      }
   }
}

