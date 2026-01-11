package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class SimpleNpcHeroBean implements IEventDispatcher
   {
      private var _105022396npcid:int;
      
      private var _871991583introduce:String;
      
      private var _3373707name:String;
      
      private var _342531044logourl:String;
      
      private var _1261935347introduce2:String;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function SimpleNpcHeroBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.logourl != null)
            {
               this.logourl = param1.logourl;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.npcid != null)
            {
               this.npcid = param1.npcid;
            }
            if(param1.introduce != null)
            {
               this.introduce = param1.introduce;
            }
            if(param1.introduce2 != null)
            {
               this.introduce2 = param1.introduce2;
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
      
      public function set logourl(param1:String) : void
      {
         var _loc2_:Object = this._342531044logourl;
         if(_loc2_ !== param1)
         {
            this._342531044logourl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logourl",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "logourl = " + this.logourl + "\n";
         _loc2_ += param1 + "name = " + this.name + "\n";
         _loc2_ += param1 + "npcid = " + this.npcid + "\n";
         _loc2_ += param1 + "introduce = " + this.introduce + "\n";
         return _loc2_ + (param1 + "introduce2 = " + this.introduce2 + "\n");
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function copyTo(param1:SimpleNpcHeroBean) : void
      {
         param1.logourl = this.logourl;
         param1.name = this.name;
         param1.npcid = this.npcid;
         param1.introduce = this.introduce;
         param1.introduce2 = this.introduce2;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
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
         _loc1_.logourl = this.logourl;
         _loc1_.name = this.name;
         _loc1_.npcid = this.npcid;
         _loc1_.introduce = this.introduce;
         _loc1_.introduce2 = this.introduce2;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get introduce() : String
      {
         return this._871991583introduce;
      }
      
      [Bindable(event="propertyChange")]
      public function get logourl() : String
      {
         return this._342531044logourl;
      }
      
      public function set introduce2(param1:String) : void
      {
         var _loc2_:Object = this._1261935347introduce2;
         if(_loc2_ !== param1)
         {
            this._1261935347introduce2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"introduce2",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get introduce2() : String
      {
         return this._1261935347introduce2;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set npcid(param1:int) : void
      {
         var _loc2_:Object = this._105022396npcid;
         if(_loc2_ !== param1)
         {
            this._105022396npcid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npcid",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get npcid() : int
      {
         return this._105022396npcid;
      }
      
      public function set introduce(param1:String) : void
      {
         var _loc2_:Object = this._871991583introduce;
         if(_loc2_ !== param1)
         {
            this._871991583introduce = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"introduce",_loc2_,param1));
         }
      }
   }
}

