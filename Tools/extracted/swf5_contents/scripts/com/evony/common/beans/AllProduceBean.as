package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class AllProduceBean implements IEventDispatcher
   {
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _267085529allProduceQueueArray:ArrayCollection;
      
      private var _1381039140positionId:int;
      
      public function AllProduceBean(param1:Object = null)
      {
         var _loc2_:ProduceBean = null;
         var _loc3_:int = 0;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.allProduceQueueArray = new ArrayCollection();
         super();
         if(param1 != null)
         {
            if(param1.positionId != null)
            {
               this.positionId = param1.positionId;
            }
            if(param1.allProduceQueue)
            {
               _loc2_ = null;
               _loc3_ = 0;
               while(_loc3_ < param1.allProduceQueue.length)
               {
                  _loc2_ = new ProduceBean(param1.allProduceQueue[_loc3_]);
                  this.allProduceQueueArray.addItem(_loc2_);
                  _loc3_++;
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
      
      public function set positionId(param1:int) : void
      {
         var _loc2_:Object = this._1381039140positionId;
         if(_loc2_ !== param1)
         {
            this._1381039140positionId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"positionId",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = param1 + "positionId = " + this.positionId + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.allProduceQueueArray.length)
         {
            _loc2_ += this.getAllProduceQueue(_loc3_).toDebugString(param1 + "allProduceQueue[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function set allProduceQueueArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._267085529allProduceQueueArray;
         if(_loc2_ !== param1)
         {
            this._267085529allProduceQueueArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allProduceQueueArray",_loc2_,param1));
         }
      }
      
      public function setAllProduceQueue(param1:ProduceBean, param2:int) : void
      {
         this.allProduceQueueArray[param2] = param1;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:AllProduceBean) : void
      {
         param1.positionId = this.positionId;
         CommonUtil.arrayCopy(this.allProduceQueueArray,param1.allProduceQueueArray);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function toObject() : Object
      {
         return {"positionId":this.positionId};
      }
      
      public function getAllProduceQueue(param1:int) : ProduceBean
      {
         return this.allProduceQueueArray[param1] as ProduceBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get positionId() : int
      {
         return this._1381039140positionId;
      }
      
      [Bindable(event="propertyChange")]
      public function get allProduceQueueArray() : ArrayCollection
      {
         return this._267085529allProduceQueueArray;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}

