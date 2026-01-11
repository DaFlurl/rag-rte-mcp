package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class FieldBean implements IEventDispatcher
   {
      
      private var _3355id:int;
      
      private var _109757601statu:int;
      
      private var _3373707name:String;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _3575610type:int;
      
      private var _1710868093armysArray:ArrayCollection;
      
      private var _102865796level:int;
      
      public function FieldBean(param1:Object = null)
      {
         var _loc2_:ArmyBean = null;
         var _loc3_:int = 0;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.armysArray = new ArrayCollection();
         super();
         if(param1 != null)
         {
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.level != null)
            {
               this.level = param1.level;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.statu != null)
            {
               this.statu = param1.statu;
            }
            if(param1.type != null)
            {
               this.type = param1.type;
            }
            if(param1.armys)
            {
               _loc2_ = null;
               _loc3_ = 0;
               while(_loc3_ < param1.armys.length)
               {
                  _loc2_ = new ArmyBean(param1.armys[_loc3_]);
                  this.armysArray.addItem(_loc2_);
                  _loc3_++;
               }
            }
         }
      }
      
      public function getArmys(param1:int) : ArmyBean
      {
         return this.armysArray[param1] as ArmyBean;
      }
      
      public function set statu(param1:int) : void
      {
         var _loc2_:Object = this._109757601statu;
         if(_loc2_ !== param1)
         {
            this._109757601statu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statu",_loc2_,param1));
         }
      }
      
      public function set type(param1:int) : void
      {
         var _loc2_:Object = this._3575610type;
         if(_loc2_ !== param1)
         {
            this._3575610type = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"type",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
      }
      
      public function set armysArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1710868093armysArray;
         if(_loc2_ !== param1)
         {
            this._1710868093armysArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"armysArray",_loc2_,param1));
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = param1 + "id = " + this.id + "\n" + (param1 + "level = " + this.level + "\n") + (param1 + "name = " + this.name + "\n") + (param1 + "statu = " + this.statu + "\n") + (param1 + "type = " + this.type + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.armysArray.length)
         {
            _loc2_ += this.getArmys(_loc3_).toDebugString(param1 + "armys[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      [Bindable(event="propertyChange")]
      public function get armysArray() : ArrayCollection
      {
         return this._1710868093armysArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
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
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : int
      {
         return this._3575610type;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
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
            "id":this.id,
            "level":this.level,
            "name":this.name,
            "statu":this.statu,
            "type":this.type
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function copyTo(param1:FieldBean) : void
      {
         param1.id = this.id;
         param1.level = this.level;
         param1.name = this.name;
         param1.statu = this.statu;
         param1.type = this.type;
         CommonUtil.arrayCopy(this.armysArray,param1.armysArray);
      }
      
      [Bindable(event="propertyChange")]
      public function get statu() : int
      {
         return this._109757601statu;
      }
      
      public function set id(param1:int) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      public function setArmys(param1:ArmyBean, param2:int) : void
      {
         this.armysArray[param2] = param1;
      }
   }
}

