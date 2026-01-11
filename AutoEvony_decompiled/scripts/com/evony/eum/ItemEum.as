package com.evony.eum
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class ItemEum implements IEventDispatcher
   {
      
      private var _321656496userLimit:int;
      
      private var _3373707name:String;
      
      private var _106934601price:int;
      
      private var _1177037892itemDesc:String;
      
      private var _1177533677itemType:String;
      
      private var _619236819heroItem:Boolean = false;
      
      private var _3355id:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _2095526292playerItem:Boolean = false;
      
      private var _1638765110iconUrl:String;
      
      private var _1913436543dayLimit:int;
      
      private var _3079825desc:String;
      
      public function ItemEum()
      {
         super();
      }
      
      public function set itemDesc(param1:String) : void
      {
         var _loc2_:Object = this._1177037892itemDesc;
         if(_loc2_ !== param1)
         {
            this._1177037892itemDesc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemDesc",_loc2_,param1));
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
      public function get desc() : String
      {
         return this._3079825desc;
      }
      
      public function set price(param1:int) : void
      {
         var _loc2_:Object = this._106934601price;
         if(_loc2_ !== param1)
         {
            this._106934601price = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"price",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playerItem() : Boolean
      {
         return this._2095526292playerItem;
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
            "name":this.name,
            "itemType":this.itemType,
            "dayLimit":this.dayLimit,
            "userLimit":this.userLimit,
            "desc":this.desc,
            "itemDesc":this.itemDesc,
            "iconUrl":this.iconUrl,
            "price":this.price,
            "heroItem":this.heroItem,
            "playerItem":this.playerItem
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : String
      {
         return this._3355id;
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
      
      [Bindable(event="propertyChange")]
      public function get heroItem() : Boolean
      {
         return this._619236819heroItem;
      }
      
      public function set playerItem(param1:Boolean) : void
      {
         var _loc2_:Object = this._2095526292playerItem;
         if(_loc2_ !== param1)
         {
            this._2095526292playerItem = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerItem",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get userLimit() : int
      {
         return this._321656496userLimit;
      }
      
      public function set id(param1:String) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconUrl() : String
      {
         return this._1638765110iconUrl;
      }
      
      [Bindable(event="propertyChange")]
      public function get itemDesc() : String
      {
         return this._1177037892itemDesc;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "id = " + this.id + "\n" + (param1 + "name = " + this.name + "\n") + (param1 + "itemType = " + this.itemType + "\n") + (param1 + "dayLimit = " + this.dayLimit + "\n") + (param1 + "userLimit = " + this.userLimit + "\n") + (param1 + "desc = " + this.desc + "\n") + (param1 + "itemDesc = " + this.itemDesc + "\n") + (param1 + "iconUrl = " + this.iconUrl + "\n") + (param1 + "price = " + this.price + "\n") + (param1 + "heroItem = " + this.heroItem + "\n") + (param1 + "playerItem = " + this.playerItem + "\n");
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get price() : int
      {
         return this._106934601price;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set userLimit(param1:int) : void
      {
         var _loc2_:Object = this._321656496userLimit;
         if(_loc2_ !== param1)
         {
            this._321656496userLimit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"userLimit",_loc2_,param1));
         }
      }
      
      public function set itemType(param1:String) : void
      {
         var _loc2_:Object = this._1177533677itemType;
         if(_loc2_ !== param1)
         {
            this._1177533677itemType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemType",_loc2_,param1));
         }
      }
      
      public function set heroItem(param1:Boolean) : void
      {
         var _loc2_:Object = this._619236819heroItem;
         if(_loc2_ !== param1)
         {
            this._619236819heroItem = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heroItem",_loc2_,param1));
         }
      }
      
      public function set iconUrl(param1:String) : void
      {
         var _loc2_:Object = this._1638765110iconUrl;
         if(_loc2_ !== param1)
         {
            this._1638765110iconUrl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconUrl",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemType() : String
      {
         return this._1177533677itemType;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set dayLimit(param1:int) : void
      {
         var _loc2_:Object = this._1913436543dayLimit;
         if(_loc2_ !== param1)
         {
            this._1913436543dayLimit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dayLimit",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dayLimit() : int
      {
         return this._1913436543dayLimit;
      }
   }
}

