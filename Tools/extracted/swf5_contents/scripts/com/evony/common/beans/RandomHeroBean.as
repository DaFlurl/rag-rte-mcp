package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class RandomHeroBean implements IEventDispatcher
   {
      private var _2024747164resettime:Number;
      
      private var _1949052249lockstratagem:Boolean;
      
      private var _1799980989management:int;
      
      private var _914405702lockpower:Boolean;
      
      private var _1872044231player_id:int;
      
      private var _106858757power:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1672860384resetcount:int;
      
      private var _2120287150lockmanagement:Boolean;
      
      private var _3355id:Number;
      
      private var _412944526stratagem:int;
      
      public function RandomHeroBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.management != null)
            {
               this.management = param1.management;
            }
            if(param1.player_id != null)
            {
               this.player_id = param1.player_id;
            }
            if(param1.power != null)
            {
               this.power = param1.power;
            }
            if(param1.resetcount != null)
            {
               this.resetcount = param1.resetcount;
            }
            if(param1.resettime != null)
            {
               this.resettime = param1.resettime;
            }
            if(param1.stratagem != null)
            {
               this.stratagem = param1.stratagem;
            }
            if(param1.lockmanagement != null)
            {
               this.lockmanagement = param1.lockmanagement;
            }
            if(param1.lockpower != null)
            {
               this.lockpower = param1.lockpower;
            }
            if(param1.lockstratagem != null)
            {
               this.lockstratagem = param1.lockstratagem;
            }
         }
      }
      
      public function set lockpower(param1:Boolean) : void
      {
         var _loc2_:Object = this._914405702lockpower;
         if(_loc2_ !== param1)
         {
            this._914405702lockpower = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lockpower",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get power() : int
      {
         return this._106858757power;
      }
      
      public function set management(param1:int) : void
      {
         var _loc2_:Object = this._1799980989management;
         if(_loc2_ !== param1)
         {
            this._1799980989management = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"management",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set power(param1:int) : void
      {
         var _loc2_:Object = this._106858757power;
         if(_loc2_ !== param1)
         {
            this._106858757power = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"power",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "id":this.id,
            "management":this.management,
            "player_id":this.player_id,
            "power":this.power,
            "resetcount":this.resetcount,
            "resettime":this.resettime,
            "stratagem":this.stratagem,
            "lockmanagement":this.lockmanagement,
            "lockpower":this.lockpower,
            "lockstratagem":this.lockstratagem
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : Number
      {
         return this._3355id;
      }
      
      [Bindable(event="propertyChange")]
      public function get resettime() : Number
      {
         return this._2024747164resettime;
      }
      
      [Bindable(event="propertyChange")]
      public function get resetcount() : int
      {
         return this._1672860384resetcount;
      }
      
      [Bindable(event="propertyChange")]
      public function get lockstratagem() : Boolean
      {
         return this._1949052249lockstratagem;
      }
      
      [Bindable(event="propertyChange")]
      public function get lockmanagement() : Boolean
      {
         return this._2120287150lockmanagement;
      }
      
      public function set id(param1:Number) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      public function set resettime(param1:Number) : void
      {
         var _loc2_:Object = this._2024747164resettime;
         if(_loc2_ !== param1)
         {
            this._2024747164resettime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resettime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get player_id() : int
      {
         return this._1872044231player_id;
      }
      
      [Bindable(event="propertyChange")]
      public function get lockpower() : Boolean
      {
         return this._914405702lockpower;
      }
      
      [Bindable(event="propertyChange")]
      public function get management() : int
      {
         return this._1799980989management;
      }
      
      public function set resetcount(param1:int) : void
      {
         var _loc2_:Object = this._1672860384resetcount;
         if(_loc2_ !== param1)
         {
            this._1672860384resetcount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resetcount",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "id = " + this.id + "\n" + (param1 + "management = " + this.management + "\n") + (param1 + "player_id = " + this.player_id + "\n") + (param1 + "power = " + this.power + "\n") + (param1 + "resetcount = " + this.resetcount + "\n") + (param1 + "resettime = " + this.resettime + "\n") + (param1 + "stratagem = " + this.stratagem + "\n") + (param1 + "lockmanagement = " + this.lockmanagement + "\n") + (param1 + "lockpower = " + this.lockpower + "\n") + (param1 + "lockstratagem = " + this.lockstratagem + "\n");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set lockstratagem(param1:Boolean) : void
      {
         var _loc2_:Object = this._1949052249lockstratagem;
         if(_loc2_ !== param1)
         {
            this._1949052249lockstratagem = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lockstratagem",_loc2_,param1));
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function copyTo(param1:RandomHeroBean) : void
      {
         param1.id = this.id;
         param1.management = this.management;
         param1.player_id = this.player_id;
         param1.power = this.power;
         param1.resetcount = this.resetcount;
         param1.resettime = this.resettime;
         param1.stratagem = this.stratagem;
         param1.lockmanagement = this.lockmanagement;
         param1.lockpower = this.lockpower;
         param1.lockstratagem = this.lockstratagem;
      }
      
      public function set lockmanagement(param1:Boolean) : void
      {
         var _loc2_:Object = this._2120287150lockmanagement;
         if(_loc2_ !== param1)
         {
            this._2120287150lockmanagement = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lockmanagement",_loc2_,param1));
         }
      }
      
      public function set stratagem(param1:int) : void
      {
         var _loc2_:Object = this._412944526stratagem;
         if(_loc2_ !== param1)
         {
            this._412944526stratagem = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stratagem",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stratagem() : int
      {
         return this._412944526stratagem;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set player_id(param1:int) : void
      {
         var _loc2_:Object = this._1872044231player_id;
         if(_loc2_ !== param1)
         {
            this._1872044231player_id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"player_id",_loc2_,param1));
         }
      }
   }
}

