package com.evony.common.beans
{
   import flash.events.*;
   import mx.events.*;
   
   public class VisitorCommentBean implements IEventDispatcher
   {
      
      private var _950398559comment:String;
      
      private var _3496342read:Boolean;
      
      private var _3560141time:String;
      
      private var _1880546825visitorid:String;
      
      private var _3355id:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function VisitorCommentBean(param1:Object = null)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         if(param1 != null)
         {
            if(param1.comment != null)
            {
               this.comment = param1.comment;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.time != null)
            {
               this.time = param1.time;
            }
            if(param1.visitorid != null)
            {
               this.visitorid = param1.visitorid;
            }
            if(param1.read != null)
            {
               this.read = param1.read;
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "comment = " + this.comment + "\n";
         _loc2_ += param1 + "id = " + this.id + "\n";
         _loc2_ += param1 + "time = " + this.time + "\n";
         _loc2_ += param1 + "visitorid = " + this.visitorid + "\n";
         return _loc2_ + (param1 + "read = " + this.read + "\n");
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get time() : String
      {
         return this._3560141time;
      }
      
      public function copyTo(param1:VisitorCommentBean) : void
      {
         param1.comment = this.comment;
         param1.id = this.id;
         param1.time = this.time;
         param1.visitorid = this.visitorid;
         param1.read = this.read;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set visitorid(param1:String) : void
      {
         var _loc2_:Object = this._1880546825visitorid;
         if(_loc2_ !== param1)
         {
            this._1880546825visitorid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"visitorid",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get read() : Boolean
      {
         return this._3496342read;
      }
      
      [Bindable(event="propertyChange")]
      public function get visitorid() : String
      {
         return this._1880546825visitorid;
      }
      
      public function set time(param1:String) : void
      {
         var _loc2_:Object = this._3560141time;
         if(_loc2_ !== param1)
         {
            this._3560141time = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"time",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get comment() : String
      {
         return this._950398559comment;
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.comment = this.comment;
         _loc1_.id = this.id;
         _loc1_.time = this.time;
         _loc1_.visitorid = this.visitorid;
         _loc1_.read = this.read;
         return _loc1_;
      }
      
      public function set read(param1:Boolean) : void
      {
         var _loc2_:Object = this._3496342read;
         if(_loc2_ !== param1)
         {
            this._3496342read = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"read",_loc2_,param1));
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
      
      public function set comment(param1:String) : void
      {
         var _loc2_:Object = this._950398559comment;
         if(_loc2_ !== param1)
         {
            this._950398559comment = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"comment",_loc2_,param1));
         }
      }
   }
}

