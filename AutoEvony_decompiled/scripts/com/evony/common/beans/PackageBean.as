package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class PackageBean implements IEventDispatcher
   {
      
      public static const PACKAGE_TYPE_SERIAL:int = 1;
      
      public static const PACKAGE_TYPE_NORMAL:int = 3;
      
      public static const PACKAGE_TYPE_SCORES:int = 2;
      
      private var _892481550status:int;
      
      private var _3575610type:int;
      
      private var _1049685640itemListArray:ArrayCollection;
      
      private var _3355id:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _162030183isUseNow:int;
      
      private var _2063817998provideTime:Number;
      
      private var _1530923192claimedTime:String;
      
      private var _907766751scores:int;
      
      private var _391026675maxMedal:int;
      
      private var _1385169979minMedal:int;
      
      private var _3079825desc:String;
      
      private var _908759025packageName:String;
      
      private var _92515438expiredTime:Number;
      
      public function PackageBean(param1:Object = null)
      {
         var _loc2_:ItemBean = null;
         var _loc3_:int = 0;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.itemListArray = new ArrayCollection();
         super();
         if(param1 != null)
         {
            if(param1.claimedTime != null)
            {
               this.claimedTime = param1.claimedTime;
            }
            if(param1.desc != null)
            {
               this.desc = param1.desc;
            }
            if(param1.expiredTime != null)
            {
               this.expiredTime = param1.expiredTime;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.isUseNow != null)
            {
               this.isUseNow = param1.isUseNow;
            }
            if(param1.maxMedal != null)
            {
               this.maxMedal = param1.maxMedal;
            }
            if(param1.minMedal != null)
            {
               this.minMedal = param1.minMedal;
            }
            if(param1.packageName != null)
            {
               this.packageName = param1.packageName;
            }
            if(param1.provideTime != null)
            {
               this.provideTime = param1.provideTime;
            }
            if(param1.scores != null)
            {
               this.scores = param1.scores;
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
            if(param1.type != null)
            {
               this.type = param1.type;
            }
            if(param1.itemList)
            {
               _loc2_ = null;
               _loc3_ = 0;
               while(_loc3_ < param1.itemList.length)
               {
                  _loc2_ = new ItemBean(param1.itemList[_loc3_]);
                  this.itemListArray.addItem(_loc2_);
                  _loc3_++;
               }
            }
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get itemListArray() : ArrayCollection
      {
         return this._1049685640itemListArray;
      }
      
      public function set minMedal(param1:int) : void
      {
         var _loc2_:Object = this._1385169979minMedal;
         if(_loc2_ !== param1)
         {
            this._1385169979minMedal = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"minMedal",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get desc() : String
      {
         return this._3079825desc;
      }
      
      [Bindable(event="propertyChange")]
      public function get expiredTime() : Number
      {
         return this._92515438expiredTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get provideTime() : Number
      {
         return this._2063817998provideTime;
      }
      
      public function set itemListArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1049685640itemListArray;
         if(_loc2_ !== param1)
         {
            this._1049685640itemListArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemListArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isUseNow() : int
      {
         return this._162030183isUseNow;
      }
      
      public function toObject() : Object
      {
         return {
            "claimedTime":this.claimedTime,
            "desc":this.desc,
            "expiredTime":this.expiredTime,
            "id":this.id,
            "isUseNow":this.isUseNow,
            "maxMedal":this.maxMedal,
            "minMedal":this.minMedal,
            "packageName":this.packageName,
            "provideTime":this.provideTime,
            "scores":this.scores,
            "status":this.status,
            "type":this.type
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function set provideTime(param1:Number) : void
      {
         var _loc2_:Object = this._2063817998provideTime;
         if(_loc2_ !== param1)
         {
            this._2063817998provideTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"provideTime",_loc2_,param1));
         }
      }
      
      public function set claimedTime(param1:String) : void
      {
         var _loc2_:Object = this._1530923192claimedTime;
         if(_loc2_ !== param1)
         {
            this._1530923192claimedTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claimedTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scores() : int
      {
         return this._907766751scores;
      }
      
      public function set desc(param1:String) : void
      {
         var _loc2_:Object = this._3079825desc;
         if(_loc2_ !== param1)
         {
            this._3079825desc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"desc",_loc2_,param1));
         }
      }
      
      public function set expiredTime(param1:Number) : void
      {
         var _loc2_:Object = this._92515438expiredTime;
         if(_loc2_ !== param1)
         {
            this._92515438expiredTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"expiredTime",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set isUseNow(param1:int) : void
      {
         var _loc2_:Object = this._162030183isUseNow;
         if(_loc2_ !== param1)
         {
            this._162030183isUseNow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isUseNow",_loc2_,param1));
         }
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
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : int
      {
         return this._3575610type;
      }
      
      public function set scores(param1:int) : void
      {
         var _loc2_:Object = this._907766751scores;
         if(_loc2_ !== param1)
         {
            this._907766751scores = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scores",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get minMedal() : int
      {
         return this._1385169979minMedal;
      }
      
      public function getItemList(param1:int) : ItemBean
      {
         return this.itemListArray[param1] as ItemBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get claimedTime() : String
      {
         return this._1530923192claimedTime;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = param1 + "claimedTime = " + this.claimedTime + "\n" + (param1 + "desc = " + this.desc + "\n") + (param1 + "expiredTime = " + this.expiredTime + "\n") + (param1 + "id = " + this.id + "\n") + (param1 + "isUseNow = " + this.isUseNow + "\n") + (param1 + "maxMedal = " + this.maxMedal + "\n") + (param1 + "minMedal = " + this.minMedal + "\n") + (param1 + "packageName = " + this.packageName + "\n") + (param1 + "provideTime = " + this.provideTime + "\n") + (param1 + "scores = " + this.scores + "\n") + (param1 + "status = " + this.status + "\n") + (param1 + "type = " + this.type + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.itemListArray.length)
         {
            _loc2_ += this.getItemList(_loc3_).toDebugString(param1 + "itemList[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function copyTo(param1:PackageBean) : void
      {
         param1.claimedTime = this.claimedTime;
         param1.desc = this.desc;
         param1.expiredTime = this.expiredTime;
         param1.id = this.id;
         param1.isUseNow = this.isUseNow;
         param1.maxMedal = this.maxMedal;
         param1.minMedal = this.minMedal;
         param1.packageName = this.packageName;
         param1.provideTime = this.provideTime;
         param1.scores = this.scores;
         param1.status = this.status;
         param1.type = this.type;
         CommonUtil.arrayCopy(this.itemListArray,param1.itemListArray);
      }
      
      public function setItemList(param1:ItemBean, param2:int) : void
      {
         this.itemListArray[param2] = param1;
      }
      
      public function set packageName(param1:String) : void
      {
         var _loc2_:Object = this._908759025packageName;
         if(_loc2_ !== param1)
         {
            this._908759025packageName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"packageName",_loc2_,param1));
         }
      }
      
      public function set status(param1:int) : void
      {
         var _loc2_:Object = this._892481550status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
         }
      }
      
      public function set maxMedal(param1:int) : void
      {
         var _loc2_:Object = this._391026675maxMedal;
         if(_loc2_ !== param1)
         {
            this._391026675maxMedal = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maxMedal",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get packageName() : String
      {
         return this._908759025packageName;
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      [Bindable(event="propertyChange")]
      public function get maxMedal() : int
      {
         return this._391026675maxMedal;
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

