package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class ProduceBean implements IEventDispatcher
   {
      
      private var _424687558costTime:Number;
      
      private var _1607243192endTime:Number;
      
      private var _655172108queueId:int;
      
      private var _109446num:int;
      
      private var _3575610type:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function ProduceBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.costTime != null)
            {
               this.costTime = param1.costTime;
            }
            if(param1.endTime != null)
            {
               this.endTime = param1.endTime;
            }
            if(param1.num != null)
            {
               this.num = param1.num;
            }
            if(param1.queueId != null)
            {
               this.queueId = param1.queueId;
            }
            if(param1.type != null)
            {
               this.type = param1.type;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : int
      {
         return this._3575610type;
      }
      
      [Bindable(event="propertyChange")]
      public function get num() : int
      {
         return this._109446num;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "costTime = " + this.costTime + "\n";
         _loc2_ += param1 + "endTime = " + this.endTime + "\n";
         _loc2_ += param1 + "num = " + this.num + "\n";
         _loc2_ += param1 + "queueId = " + this.queueId + "\n";
         return _loc2_ + (param1 + "type = " + this.type + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set num(param1:int) : void
      {
         var _loc2_:Object = this._109446num;
         if(_loc2_ !== param1)
         {
            this._109446num = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"num",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get queueId() : int
      {
         return this._655172108queueId;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
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
      
      public function set queueId(param1:int) : void
      {
         var _loc2_:Object = this._655172108queueId;
         if(_loc2_ !== param1)
         {
            this._655172108queueId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"queueId",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "costTime":this.costTime,
            "endTime":this.endTime,
            "num":this.num,
            "queueId":this.queueId,
            "type":this.type
         };
      }
      
      public function set costTime(param1:Number) : void
      {
         var _loc2_:Object = this._424687558costTime;
         if(_loc2_ !== param1)
         {
            this._424687558costTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"costTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endTime() : Number
      {
         return this._1607243192endTime;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function copyTo(param1:ProduceBean) : void
      {
         param1.costTime = this.costTime;
         param1.endTime = this.endTime;
         param1.num = this.num;
         param1.queueId = this.queueId;
         param1.type = this.type;
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
      public function get costTime() : Number
      {
         return this._424687558costTime;
      }
   }
}

