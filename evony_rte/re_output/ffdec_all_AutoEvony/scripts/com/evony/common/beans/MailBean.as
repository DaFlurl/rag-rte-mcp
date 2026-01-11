package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class MailBean implements IEventDispatcher
   {
      
      private var _441951604targetId:int;
      
      private var _853090240type_id:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _905962955sender:String;
      
      private var _2103439280receiveTime:String;
      
      private var _1081573102mailid:int;
      
      private var _1879273436playerId:int;
      
      private var _1191572123selected:Boolean;
      
      private var _808719889receiver:String;
      
      private var _1180158496isRead:int;
      
      private var _110371416title:String;
      
      public function MailBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.isRead != null)
            {
               this.isRead = param1.isRead;
            }
            if(param1.mailid != null)
            {
               this.mailid = param1.mailid;
            }
            if(param1.playerId != null)
            {
               this.playerId = param1.playerId;
            }
            if(param1.receiveTime != null)
            {
               this.receiveTime = param1.receiveTime;
            }
            if(param1.receiver != null)
            {
               this.receiver = param1.receiver;
            }
            if(param1.sender != null)
            {
               this.sender = param1.sender;
            }
            if(param1.targetId != null)
            {
               this.targetId = param1.targetId;
            }
            if(param1.title != null)
            {
               this.title = param1.title;
            }
            if(param1.type_id != null)
            {
               this.type_id = param1.type_id;
            }
            if(param1.selected != null)
            {
               this.selected = param1.selected;
            }
         }
      }
      
      public function set type_id(param1:int) : void
      {
         var _loc2_:Object = this._853090240type_id;
         if(_loc2_ !== param1)
         {
            this._853090240type_id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"type_id",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get targetId() : int
      {
         return this._441951604targetId;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get mailid() : int
      {
         return this._1081573102mailid;
      }
      
      public function set targetId(param1:int) : void
      {
         var _loc2_:Object = this._441951604targetId;
         if(_loc2_ !== param1)
         {
            this._441951604targetId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetId",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "isRead":this.isRead,
            "mailid":this.mailid,
            "playerId":this.playerId,
            "receiveTime":this.receiveTime,
            "receiver":this.receiver,
            "sender":this.sender,
            "targetId":this.targetId,
            "title":this.title,
            "type_id":this.type_id,
            "selected":this.selected
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get selected() : Boolean
      {
         return this._1191572123selected;
      }
      
      public function set receiveTime(param1:String) : void
      {
         var _loc2_:Object = this._2103439280receiveTime;
         if(_loc2_ !== param1)
         {
            this._2103439280receiveTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"receiveTime",_loc2_,param1));
         }
      }
      
      public function set mailid(param1:int) : void
      {
         var _loc2_:Object = this._1081573102mailid;
         if(_loc2_ !== param1)
         {
            this._1081573102mailid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mailid",_loc2_,param1));
         }
      }
      
      public function set title(param1:String) : void
      {
         var _loc2_:Object = this._110371416title;
         if(_loc2_ !== param1)
         {
            this._110371416title = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"title",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sender() : String
      {
         return this._905962955sender;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:Object = this._1191572123selected;
         if(_loc2_ !== param1)
         {
            this._1191572123selected = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selected",_loc2_,param1));
         }
      }
      
      public function set playerId(param1:int) : void
      {
         var _loc2_:Object = this._1879273436playerId;
         if(_loc2_ !== param1)
         {
            this._1879273436playerId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerId",_loc2_,param1));
         }
      }
      
      public function set isRead(param1:int) : void
      {
         var _loc2_:Object = this._1180158496isRead;
         if(_loc2_ !== param1)
         {
            this._1180158496isRead = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isRead",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get type_id() : int
      {
         return this._853090240type_id;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "isRead = " + this.isRead + "\n" + (param1 + "mailid = " + this.mailid + "\n") + (param1 + "playerId = " + this.playerId + "\n") + (param1 + "receiveTime = " + this.receiveTime + "\n") + (param1 + "receiver = " + this.receiver + "\n") + (param1 + "sender = " + this.sender + "\n") + (param1 + "targetId = " + this.targetId + "\n") + (param1 + "title = " + this.title + "\n") + (param1 + "type_id = " + this.type_id + "\n") + (param1 + "selected = " + this.selected + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function copyTo(param1:MailBean) : void
      {
         param1.isRead = this.isRead;
         param1.mailid = this.mailid;
         param1.playerId = this.playerId;
         param1.receiveTime = this.receiveTime;
         param1.receiver = this.receiver;
         param1.sender = this.sender;
         param1.targetId = this.targetId;
         param1.title = this.title;
         param1.type_id = this.type_id;
         param1.selected = this.selected;
      }
      
      [Bindable(event="propertyChange")]
      public function get receiveTime() : String
      {
         return this._2103439280receiveTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get title() : String
      {
         return this._110371416title;
      }
      
      [Bindable(event="propertyChange")]
      public function get playerId() : int
      {
         return this._1879273436playerId;
      }
      
      public function set receiver(param1:String) : void
      {
         var _loc2_:Object = this._808719889receiver;
         if(_loc2_ !== param1)
         {
            this._808719889receiver = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"receiver",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isRead() : int
      {
         return this._1180158496isRead;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get receiver() : String
      {
         return this._808719889receiver;
      }
      
      public function set sender(param1:String) : void
      {
         var _loc2_:Object = this._905962955sender;
         if(_loc2_ !== param1)
         {
            this._905962955sender = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sender",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}

