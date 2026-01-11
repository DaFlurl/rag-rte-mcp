package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class CommissionQuestBean implements IEventDispatcher
   {
      
      private var _600408483isFinish:Boolean;
      
      private var _908959235isMyIssue:Boolean;
      
      private var _3373707name:String;
      
      private var _3575610type:int;
      
      private var _1313911455timeout:Number;
      
      private var _747804969position:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1355171569isAccepted:Boolean;
      
      private var _934326481reward:int;
      
      private var _1606289880endtime:String;
      
      private var _3355id:int;
      
      private var _880905839target:String;
      
      private var _531131054playerCount:int;
      
      public function CommissionQuestBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.endtime != null)
            {
               this.endtime = param1.endtime;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.isAccepted != null)
            {
               this.isAccepted = param1.isAccepted;
            }
            if(param1.isFinish != null)
            {
               this.isFinish = param1.isFinish;
            }
            if(param1.isMyIssue != null)
            {
               this.isMyIssue = param1.isMyIssue;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.playerCount != null)
            {
               this.playerCount = param1.playerCount;
            }
            if(param1.position != null)
            {
               this.position = param1.position;
            }
            if(param1.reward != null)
            {
               this.reward = param1.reward;
            }
            if(param1.target != null)
            {
               this.target = param1.target;
            }
            if(param1.timeout != null)
            {
               this.timeout = param1.timeout;
            }
            if(param1.type != null)
            {
               this.type = param1.type;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isMyIssue() : Boolean
      {
         return this._908959235isMyIssue;
      }
      
      public function set isMyIssue(param1:Boolean) : void
      {
         var _loc2_:Object = this._908959235isMyIssue;
         if(_loc2_ !== param1)
         {
            this._908959235isMyIssue = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isMyIssue",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get target() : String
      {
         return this._880905839target;
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
         var _loc1_:Object = new Object();
         _loc1_.endtime = this.endtime;
         _loc1_.id = this.id;
         _loc1_.isAccepted = this.isAccepted;
         _loc1_.isFinish = this.isFinish;
         _loc1_.isMyIssue = this.isMyIssue;
         _loc1_.name = this.name;
         _loc1_.playerCount = this.playerCount;
         _loc1_.position = this.position;
         _loc1_.reward = this.reward;
         _loc1_.target = this.target;
         _loc1_.timeout = this.timeout;
         _loc1_.type = this.type;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set target(param1:String) : void
      {
         var _loc2_:Object = this._880905839target;
         if(_loc2_ !== param1)
         {
            this._880905839target = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"target",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endtime() : String
      {
         return this._1606289880endtime;
      }
      
      [Bindable(event="propertyChange")]
      public function get position() : String
      {
         return this._747804969position;
      }
      
      [Bindable(event="propertyChange")]
      public function get playerCount() : int
      {
         return this._531131054playerCount;
      }
      
      [Bindable(event="propertyChange")]
      public function get reward() : int
      {
         return this._934326481reward;
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
      
      public function set isFinish(param1:Boolean) : void
      {
         var _loc2_:Object = this._600408483isFinish;
         if(_loc2_ !== param1)
         {
            this._600408483isFinish = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isFinish",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : int
      {
         return this._3575610type;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "endtime = " + this.endtime + "\n";
         _loc2_ += param1 + "id = " + this.id + "\n";
         _loc2_ += param1 + "isAccepted = " + this.isAccepted + "\n";
         _loc2_ += param1 + "isFinish = " + this.isFinish + "\n";
         _loc2_ += param1 + "isMyIssue = " + this.isMyIssue + "\n";
         _loc2_ += param1 + "name = " + this.name + "\n";
         _loc2_ += param1 + "playerCount = " + this.playerCount + "\n";
         _loc2_ += param1 + "position = " + this.position + "\n";
         _loc2_ += param1 + "reward = " + this.reward + "\n";
         _loc2_ += param1 + "target = " + this.target + "\n";
         _loc2_ += param1 + "timeout = " + this.timeout + "\n";
         return _loc2_ + (param1 + "type = " + this.type + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:CommissionQuestBean) : void
      {
         param1.endtime = this.endtime;
         param1.id = this.id;
         param1.isAccepted = this.isAccepted;
         param1.isFinish = this.isFinish;
         param1.isMyIssue = this.isMyIssue;
         param1.name = this.name;
         param1.playerCount = this.playerCount;
         param1.position = this.position;
         param1.reward = this.reward;
         param1.target = this.target;
         param1.timeout = this.timeout;
         param1.type = this.type;
      }
      
      public function set timeout(param1:Number) : void
      {
         var _loc2_:Object = this._1313911455timeout;
         if(_loc2_ !== param1)
         {
            this._1313911455timeout = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"timeout",_loc2_,param1));
         }
      }
      
      public function set position(param1:String) : void
      {
         var _loc2_:Object = this._747804969position;
         if(_loc2_ !== param1)
         {
            this._747804969position = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"position",_loc2_,param1));
         }
      }
      
      public function set endtime(param1:String) : void
      {
         var _loc2_:Object = this._1606289880endtime;
         if(_loc2_ !== param1)
         {
            this._1606289880endtime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endtime",_loc2_,param1));
         }
      }
      
      public function set playerCount(param1:int) : void
      {
         var _loc2_:Object = this._531131054playerCount;
         if(_loc2_ !== param1)
         {
            this._531131054playerCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerCount",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isFinish() : Boolean
      {
         return this._600408483isFinish;
      }
      
      public function set reward(param1:int) : void
      {
         var _loc2_:Object = this._934326481reward;
         if(_loc2_ !== param1)
         {
            this._934326481reward = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reward",_loc2_,param1));
         }
      }
      
      public function set isAccepted(param1:Boolean) : void
      {
         var _loc2_:Object = this._1355171569isAccepted;
         if(_loc2_ !== param1)
         {
            this._1355171569isAccepted = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isAccepted",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get timeout() : Number
      {
         return this._1313911455timeout;
      }
      
      [Bindable(event="propertyChange")]
      public function get isAccepted() : Boolean
      {
         return this._1355171569isAccepted;
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
   }
}

