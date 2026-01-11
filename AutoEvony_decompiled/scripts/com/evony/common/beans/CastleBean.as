package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class CastleBean implements IEventDispatcher
   {
      
      private var _1225376224herosArray:ArrayCollection;
      
      private var _309360144colonyBeansArray:ArrayCollection;
      
      private var _452521375powerlevel:int;
      
      private var _1458231286tradesArray:ArrayCollection;
      
      private var _3355id:int;
      
      private var _2032248903buffsArray:ArrayCollection;
      
      private var _696323609zoneId:int;
      
      private var _233906701fortification:FortificationsBean;
      
      private var _1293148908mercenaryBeansArray:ArrayCollection;
      
      private var _1097354357logUrl:String;
      
      private var _45571131goOutForBattle:Boolean;
      
      private var _110634834troop:TroopBean;
      
      private var _892481550status:int;
      
      private var _2059290973buildingQueuesArray:ArrayCollection;
      
      private var _3226745icon:int;
      
      private var _3373707name:String;
      
      private var _341064690resource:CastleResourceBean;
      
      private var _1236765024allowAlliance:Boolean;
      
      private var _328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY:int;
      
      private var _861252683fieldId:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _208690213colonization:int;
      
      private var _1632439642buildingsArray:ArrayCollection;
      
      private var _1228099360fieldsArray:ArrayCollection;
      
      private var _116645134hasEnemy:Boolean;
      
      private var _637336720transingTradesArray:ArrayCollection;
      
      private var _419054649canChangeIcon:Boolean;
      
      private var _1775742881strTroop:TroopStrBean;
      
      public function CastleBean(param1:Object = null)
      {
         var _loc2_:int = 0;
         var _loc3_:BuffBean = null;
         var _loc4_:BuildingQueueBean = null;
         var _loc5_:BuildingBean = null;
         var _loc6_:ColonyBean = null;
         var _loc7_:FieldBean = null;
         var _loc8_:HeroBean = null;
         var _loc9_:MercenaryBean = null;
         var _loc10_:TradeBean = null;
         var _loc11_:TransingTradeBean = null;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         this.buffsArray = new ArrayCollection();
         this.buildingQueuesArray = new ArrayCollection();
         this.buildingsArray = new ArrayCollection();
         this.colonyBeansArray = new ArrayCollection();
         this.fieldsArray = new ArrayCollection();
         this.herosArray = new ArrayCollection();
         this.mercenaryBeansArray = new ArrayCollection();
         this.tradesArray = new ArrayCollection();
         this.transingTradesArray = new ArrayCollection();
         if(param1 != null)
         {
            if(param1.colonization != null)
            {
               this.colonization = param1.colonization;
            }
            if(param1.fieldId != null)
            {
               this.fieldId = param1.fieldId;
            }
            if(param1.fortification != null)
            {
               this.fortification = new FortificationsBean(param1.fortification);
            }
            if(param1.icon != null)
            {
               this.icon = param1.icon;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.logUrl != null)
            {
               this.logUrl = param1.logUrl;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.powerlevel != null)
            {
               this.powerlevel = param1.powerlevel;
            }
            if(param1.resource != null)
            {
               this.resource = new CastleResourceBean(param1.resource);
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
            if(param1.strTroop != null)
            {
               this.strTroop = new TroopStrBean(param1.strTroop);
            }
            if(param1.troop != null)
            {
               this.troop = new TroopBean(param1.troop);
            }
            if(param1.usePACIFY_SUCCOUR_OR_PACIFY_PRAY != null)
            {
               this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY = param1.usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
            }
            if(param1.zoneId != null)
            {
               this.zoneId = param1.zoneId;
            }
            if(param1.allowAlliance != null)
            {
               this.allowAlliance = param1.allowAlliance;
            }
            if(param1.canChangeIcon != null)
            {
               this.canChangeIcon = param1.canChangeIcon;
            }
            if(param1.goOutForBattle != null)
            {
               this.goOutForBattle = param1.goOutForBattle;
            }
            if(param1.hasEnemy != null)
            {
               this.hasEnemy = param1.hasEnemy;
            }
            _loc2_ = 0;
            if(param1.buffs)
            {
               _loc3_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.buffs.length)
               {
                  _loc3_ = new BuffBean(param1.buffs[_loc2_]);
                  this.buffsArray.addItem(_loc3_);
                  _loc2_++;
               }
            }
            if(param1.buildingQueues)
            {
               _loc4_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.buildingQueues.length)
               {
                  _loc4_ = new BuildingQueueBean(param1.buildingQueues[_loc2_]);
                  this.buildingQueuesArray.addItem(_loc4_);
                  _loc2_++;
               }
            }
            if(param1.buildings)
            {
               _loc5_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.buildings.length)
               {
                  _loc5_ = new BuildingBean(param1.buildings[_loc2_]);
                  this.buildingsArray.addItem(_loc5_);
                  _loc2_++;
               }
            }
            if(param1.colonyBeans)
            {
               _loc6_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.colonyBeans.length)
               {
                  _loc6_ = new ColonyBean(param1.colonyBeans[_loc2_]);
                  this.colonyBeansArray.addItem(_loc6_);
                  _loc2_++;
               }
            }
            if(param1.fields)
            {
               _loc7_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.fields.length)
               {
                  _loc7_ = new FieldBean(param1.fields[_loc2_]);
                  this.fieldsArray.addItem(_loc7_);
                  _loc2_++;
               }
            }
            if(param1.heros)
            {
               _loc8_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.heros.length)
               {
                  _loc8_ = new HeroBean(param1.heros[_loc2_]);
                  this.herosArray.addItem(_loc8_);
                  _loc2_++;
               }
            }
            if(param1.mercenaryBeans)
            {
               _loc9_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.mercenaryBeans.length)
               {
                  _loc9_ = new MercenaryBean(param1.mercenaryBeans[_loc2_]);
                  this.mercenaryBeansArray.addItem(_loc9_);
                  _loc2_++;
               }
            }
            if(param1.trades)
            {
               _loc10_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.trades.length)
               {
                  _loc10_ = new TradeBean(param1.trades[_loc2_]);
                  this.tradesArray.addItem(_loc10_);
                  _loc2_++;
               }
            }
            if(param1.transingTrades)
            {
               _loc11_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.transingTrades.length)
               {
                  _loc11_ = new TransingTradeBean(param1.transingTrades[_loc2_]);
                  this.transingTradesArray.addItem(_loc11_);
                  _loc2_++;
               }
            }
         }
      }
      
      public function set transingTradesArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._637336720transingTradesArray;
         if(_loc2_ !== param1)
         {
            this._637336720transingTradesArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"transingTradesArray",_loc2_,param1));
         }
      }
      
      public function getHeros(param1:int) : HeroBean
      {
         return this.herosArray[param1] as HeroBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get hasEnemy() : Boolean
      {
         return this._116645134hasEnemy;
      }
      
      public function set tradesArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1458231286tradesArray;
         if(_loc2_ !== param1)
         {
            this._1458231286tradesArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tradesArray",_loc2_,param1));
         }
      }
      
      public function set logUrl(param1:String) : void
      {
         var _loc2_:Object = this._1097354357logUrl;
         if(_loc2_ !== param1)
         {
            this._1097354357logUrl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logUrl",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tradesArray() : ArrayCollection
      {
         return this._1458231286tradesArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      [Bindable(event="propertyChange")]
      public function get fieldsArray() : ArrayCollection
      {
         return this._1228099360fieldsArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get resource() : CastleResourceBean
      {
         return this._341064690resource;
      }
      
      [Bindable(event="propertyChange")]
      public function get herosArray() : ArrayCollection
      {
         return this._1225376224herosArray;
      }
      
      public function set hasEnemy(param1:Boolean) : void
      {
         var _loc2_:Object = this._116645134hasEnemy;
         if(_loc2_ !== param1)
         {
            this._116645134hasEnemy = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hasEnemy",_loc2_,param1));
         }
      }
      
      public function setColonyBeans(param1:ColonyBean, param2:int) : void
      {
         this.colonyBeansArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get colonization() : int
      {
         return this._208690213colonization;
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
      
      public function set name(param1:String) : void
      {
         var _loc2_:Object = this._3373707name;
         if(_loc2_ !== param1)
         {
            this._3373707name = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"name",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canChangeIcon() : Boolean
      {
         return this._419054649canChangeIcon;
      }
      
      [Bindable(event="propertyChange")]
      public function get goOutForBattle() : Boolean
      {
         return this._45571131goOutForBattle;
      }
      
      public function setBuffs(param1:BuffBean, param2:int) : void
      {
         this.buffsArray[param2] = param1;
      }
      
      public function set allowAlliance(param1:Boolean) : void
      {
         var _loc2_:Object = this._1236765024allowAlliance;
         if(_loc2_ !== param1)
         {
            this._1236765024allowAlliance = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allowAlliance",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get usePACIFY_SUCCOUR_OR_PACIFY_PRAY() : int
      {
         return this._328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
      }
      
      public function set usePACIFY_SUCCOUR_OR_PACIFY_PRAY(param1:int) : void
      {
         var _loc2_:Object = this._328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
         if(_loc2_ !== param1)
         {
            this._328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"usePACIFY_SUCCOUR_OR_PACIFY_PRAY",_loc2_,param1));
         }
      }
      
      public function set powerlevel(param1:int) : void
      {
         var _loc2_:Object = this._452521375powerlevel;
         if(_loc2_ !== param1)
         {
            this._452521375powerlevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"powerlevel",_loc2_,param1));
         }
      }
      
      private function toObjArrayHelper(param1:ArrayCollection) : ArrayCollection
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            _loc2_ = new ArrayCollection();
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(param1.getItemAt(_loc3_) != null && param1.getItemAt(_loc3_).toObject != undefined)
               {
                  _loc2_.addItem(param1.getItemAt(_loc3_).toObject());
               }
               else
               {
                  _loc2_.addItem(param1.getItemAt(_loc3_));
               }
               _loc3_++;
            }
            return _loc2_;
         }
         return null;
      }
      
      public function getBuildingQueues(param1:int) : BuildingQueueBean
      {
         return this.buildingQueuesArray[param1] as BuildingQueueBean;
      }
      
      public function set buildingQueuesArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._2059290973buildingQueuesArray;
         if(_loc2_ !== param1)
         {
            this._2059290973buildingQueuesArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buildingQueuesArray",_loc2_,param1));
         }
      }
      
      public function set fieldsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1228099360fieldsArray;
         if(_loc2_ !== param1)
         {
            this._1228099360fieldsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fieldsArray",_loc2_,param1));
         }
      }
      
      public function set colonization(param1:int) : void
      {
         var _loc2_:Object = this._208690213colonization;
         if(_loc2_ !== param1)
         {
            this._208690213colonization = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonization",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get troop() : TroopBean
      {
         return this._110634834troop;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set resource(param1:CastleResourceBean) : void
      {
         var _loc2_:Object = this._341064690resource;
         if(_loc2_ !== param1)
         {
            this._341064690resource = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resource",_loc2_,param1));
         }
      }
      
      public function setBuildingQueues(param1:BuildingQueueBean, param2:int) : void
      {
         this.buildingQueuesArray[param2] = param1;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get buildingsArray() : ArrayCollection
      {
         return this._1632439642buildingsArray;
      }
      
      public function getTransingTrades(param1:int) : TransingTradeBean
      {
         return this.transingTradesArray[param1] as TransingTradeBean;
      }
      
      public function set herosArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1225376224herosArray;
         if(_loc2_ !== param1)
         {
            this._1225376224herosArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"herosArray",_loc2_,param1));
         }
      }
      
      public function getMercenaryBeans(param1:int) : MercenaryBean
      {
         return this.mercenaryBeansArray[param1] as MercenaryBean;
      }
      
      public function set strTroop(param1:TroopStrBean) : void
      {
         var _loc2_:Object = this._1775742881strTroop;
         if(_loc2_ !== param1)
         {
            this._1775742881strTroop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"strTroop",_loc2_,param1));
         }
      }
      
      public function setTransingTrades(param1:TransingTradeBean, param2:int) : void
      {
         this.transingTradesArray[param2] = param1;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function setMercenaryBeans(param1:MercenaryBean, param2:int) : void
      {
         this.mercenaryBeansArray[param2] = param1;
      }
      
      public function set fieldId(param1:int) : void
      {
         var _loc2_:Object = this._861252683fieldId;
         if(_loc2_ !== param1)
         {
            this._861252683fieldId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fieldId",_loc2_,param1));
         }
      }
      
      public function set buffsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._2032248903buffsArray;
         if(_loc2_ !== param1)
         {
            this._2032248903buffsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buffsArray",_loc2_,param1));
         }
      }
      
      public function setHeros(param1:HeroBean, param2:int) : void
      {
         this.herosArray[param2] = param1;
      }
      
      public function set canChangeIcon(param1:Boolean) : void
      {
         var _loc2_:Object = this._419054649canChangeIcon;
         if(_loc2_ !== param1)
         {
            this._419054649canChangeIcon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canChangeIcon",_loc2_,param1));
         }
      }
      
      public function set goOutForBattle(param1:Boolean) : void
      {
         var _loc2_:Object = this._45571131goOutForBattle;
         if(_loc2_ !== param1)
         {
            this._45571131goOutForBattle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goOutForBattle",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get icon() : int
      {
         return this._3226745icon;
      }
      
      public function getTrades(param1:int) : TradeBean
      {
         return this.tradesArray[param1] as TradeBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get transingTradesArray() : ArrayCollection
      {
         return this._637336720transingTradesArray;
      }
      
      public function getBuildings(param1:int) : BuildingBean
      {
         return this.buildingsArray[param1] as BuildingBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get logUrl() : String
      {
         return this._1097354357logUrl;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function setTrades(param1:TradeBean, param2:int) : void
      {
         this.tradesArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function toObject() : Object
      {
         return {
            "allowAlliance":this.allowAlliance,
            "buffsArray":this.toObjArrayHelper(this.buffsArray),
            "buildingQueuesArray":this.toObjArrayHelper(this.buildingQueuesArray),
            "buildingsArray":this.toObjArrayHelper(this.buildingsArray),
            "canChangeIcon":this.canChangeIcon,
            "colonization":this.colonization,
            "colonyBeansArray":this.toObjArrayHelper(this.colonyBeansArray),
            "fieldId":this.fieldId,
            "fieldsArray":this.toObjArrayHelper(this.fieldsArray),
            "fortification":(this.fortification == null ? null : this.fortification.toObject()),
            "goOutForBattle":this.goOutForBattle,
            "hasEnemy":this.hasEnemy,
            "herosArray":this.toObjArrayHelper(this.herosArray),
            "icon":this.icon,
            "id":this.id,
            "logUrl":this.logUrl,
            "mercenaryBeansArray":this.toObjArrayHelper(this.mercenaryBeansArray),
            "name":this.name,
            "powerlevel":this.powerlevel,
            "resource":(this.resource == null ? null : this.resource.toObject()),
            "status":this.status,
            "strTroop":(this.strTroop == null ? null : this.strTroop.toObject()),
            "tradesArray":this.toObjArrayHelper(this.tradesArray),
            "transingTradesArray":this.toObjArrayHelper(this.transingTradesArray),
            "troop":(this.troop == null ? null : this.troop.toObject()),
            "usePACIFY_SUCCOUR_OR_PACIFY_PRAY":this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY,
            "zoneId":this.zoneId
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get powerlevel() : int
      {
         return this._452521375powerlevel;
      }
      
      [Bindable(event="propertyChange")]
      public function get allowAlliance() : Boolean
      {
         return this._1236765024allowAlliance;
      }
      
      [Bindable(event="propertyChange")]
      public function get buildingQueuesArray() : ArrayCollection
      {
         return this._2059290973buildingQueuesArray;
      }
      
      public function set troop(param1:TroopBean) : void
      {
         var _loc2_:Object = this._110634834troop;
         if(_loc2_ !== param1)
         {
            this._110634834troop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troop",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get strTroop() : TroopStrBean
      {
         return this._1775742881strTroop;
      }
      
      public function getFields(param1:int) : FieldBean
      {
         return this.fieldsArray[param1] as FieldBean;
      }
      
      public function getColonyBeans(param1:int) : ColonyBean
      {
         return this.colonyBeansArray[param1] as ColonyBean;
      }
      
      public function set buildingsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1632439642buildingsArray;
         if(_loc2_ !== param1)
         {
            this._1632439642buildingsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buildingsArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fieldId() : int
      {
         return this._861252683fieldId;
      }
      
      [Bindable(event="propertyChange")]
      public function get buffsArray() : ArrayCollection
      {
         return this._2032248903buffsArray;
      }
      
      public function setFields(param1:FieldBean, param2:int) : void
      {
         this.fieldsArray[param2] = param1;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = param1 + "colonization = " + this.colonization + "\n" + (param1 + "fieldId = " + this.fieldId + "\n") + (this.fortification != null ? this.fortification.toDebugString(param1 + "fortification.") : param1 + "fortification = null\n") + (param1 + "icon = " + this.icon + "\n") + (param1 + "id = " + this.id + "\n") + (param1 + "logUrl = " + this.logUrl + "\n") + (param1 + "name = " + this.name + "\n") + (param1 + "powerlevel = " + this.powerlevel + "\n") + (this.resource != null ? this.resource.toDebugString(param1 + "resource.") : param1 + "resource = null\n") + (param1 + "status = " + this.status + "\n") + (this.strTroop != null ? this.strTroop.toDebugString(param1 + "strTroop.") : param1 + "strTroop = null\n") + (this.troop != null ? this.troop.toDebugString(param1 + "troop.") : param1 + "troop = null\n") + (param1 + "usePACIFY_SUCCOUR_OR_PACIFY_PRAY = " + this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY + "\n") + (param1 + "zoneId = " + this.zoneId + "\n") + (param1 + "allowAlliance = " + this
         .allowAlliance + "\n") + (param1 + "canChangeIcon = " + this.canChangeIcon + "\n") + (param1 + "goOutForBattle = " + this.goOutForBattle + "\n") + (param1 + "hasEnemy = " + this.hasEnemy + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.buffsArray.length)
         {
            _loc2_ += this.getBuffs(_loc3_).toDebugString(param1 + "buffsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.buildingQueuesArray.length)
         {
            _loc2_ += this.getBuildingQueues(_loc3_).toDebugString(param1 + "buildingQueuesArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.buildingsArray.length)
         {
            _loc2_ += this.getBuildings(_loc3_).toDebugString(param1 + "buildingsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.colonyBeansArray.length)
         {
            _loc2_ += this.getColonyBeans(_loc3_).toDebugString(param1 + "colonyBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.fieldsArray.length)
         {
            _loc2_ += this.getFields(_loc3_).toDebugString(param1 + "fieldsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.herosArray.length)
         {
            _loc2_ += this.getHeros(_loc3_).toDebugString(param1 + "herosArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.mercenaryBeansArray.length)
         {
            _loc2_ += this.getMercenaryBeans(_loc3_).toDebugString(param1 + "mercenaryBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.tradesArray.length)
         {
            _loc2_ += this.getTrades(_loc3_).toDebugString(param1 + "tradesArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.transingTradesArray.length)
         {
            _loc2_ += this.getTransingTrades(_loc3_).toDebugString(param1 + "transingTradesArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBuffs(param1:int) : BuffBean
      {
         return this.buffsArray[param1] as BuffBean;
      }
      
      public function set zoneId(param1:int) : void
      {
         var _loc2_:Object = this._696323609zoneId;
         if(_loc2_ !== param1)
         {
            this._696323609zoneId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zoneId",_loc2_,param1));
         }
      }
      
      public function copyTo(param1:CastleBean) : void
      {
         param1.colonization = this.colonization;
         param1.fieldId = this.fieldId;
         if(this.fortification != null)
         {
            this.fortification.copyTo(param1.fortification);
         }
         else
         {
            param1.fortification = null;
         }
         param1.icon = this.icon;
         param1.id = this.id;
         param1.logUrl = this.logUrl;
         param1.name = this.name;
         param1.powerlevel = this.powerlevel;
         if(this.resource != null)
         {
            this.resource.copyTo(param1.resource);
         }
         else
         {
            param1.resource = null;
         }
         param1.status = this.status;
         if(this.strTroop != null)
         {
            this.strTroop.copyTo(param1.strTroop);
         }
         else
         {
            param1.strTroop = null;
         }
         if(this.troop != null)
         {
            this.troop.copyTo(param1.troop);
         }
         else
         {
            param1.troop = null;
         }
         param1.usePACIFY_SUCCOUR_OR_PACIFY_PRAY = this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
         param1.zoneId = this.zoneId;
         param1.allowAlliance = this.allowAlliance;
         param1.canChangeIcon = this.canChangeIcon;
         param1.goOutForBattle = this.goOutForBattle;
         param1.hasEnemy = this.hasEnemy;
         CommonUtil.arrayCopy(this.buffsArray,param1.buffsArray);
         CommonUtil.arrayCopy(this.buildingQueuesArray,param1.buildingQueuesArray);
         CommonUtil.arrayCopy(this.buildingsArray,param1.buildingsArray);
         CommonUtil.arrayCopy(this.colonyBeansArray,param1.colonyBeansArray);
         CommonUtil.arrayCopy(this.fieldsArray,param1.fieldsArray);
         CommonUtil.arrayCopy(this.herosArray,param1.herosArray);
         CommonUtil.arrayCopy(this.mercenaryBeansArray,param1.mercenaryBeansArray);
         CommonUtil.arrayCopy(this.tradesArray,param1.tradesArray);
         CommonUtil.arrayCopy(this.transingTradesArray,param1.transingTradesArray);
      }
      
      public function set mercenaryBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1293148908mercenaryBeansArray;
         if(_loc2_ !== param1)
         {
            this._1293148908mercenaryBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mercenaryBeansArray",_loc2_,param1));
         }
      }
      
      public function set colonyBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._309360144colonyBeansArray;
         if(_loc2_ !== param1)
         {
            this._309360144colonyBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonyBeansArray",_loc2_,param1));
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
      
      public function set fortification(param1:FortificationsBean) : void
      {
         var _loc2_:Object = this._233906701fortification;
         if(_loc2_ !== param1)
         {
            this._233906701fortification = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fortification",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get zoneId() : int
      {
         return this._696323609zoneId;
      }
      
      [Bindable(event="propertyChange")]
      public function get colonyBeansArray() : ArrayCollection
      {
         return this._309360144colonyBeansArray;
      }
      
      public function set icon(param1:int) : void
      {
         var _loc2_:Object = this._3226745icon;
         if(_loc2_ !== param1)
         {
            this._3226745icon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"icon",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fortification() : FortificationsBean
      {
         return this._233906701fortification;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      [Bindable(event="propertyChange")]
      public function get mercenaryBeansArray() : ArrayCollection
      {
         return this._1293148908mercenaryBeansArray;
      }
      
      public function setBuildings(param1:BuildingBean, param2:int) : void
      {
         this.buildingsArray[param2] = param1;
      }
   }
}

