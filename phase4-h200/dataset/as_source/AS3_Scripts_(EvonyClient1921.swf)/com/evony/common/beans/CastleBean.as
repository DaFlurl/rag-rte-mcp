// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.CastleBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.collections.ArrayCollection;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.CommonUtil;
    import com.evony.common.paramBeans.*;

    public class CastleBean implements IEventDispatcher 
    {

        private var _452521375powerlevel:int;
        private var _3355id:int;
        private var _696323609zoneId:int;
        private var _233906701fortification:FortificationsBean;
        private var _1097354357logUrl:String;
        private var _45571131goOutForBattle:Boolean;
        private var _3226745icon:int;
        private var _110634834troop:TroopBean;
        private var _892481550status:int;
        private var _3373707name:String;
        private var _341064690resource:CastleResourceBean;
        private var _1236765024allowAlliance:Boolean;
        private var _328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY:int;
        private var _861252683fieldId:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _208690213colonization:int;
        private var _116645134hasEnemy:Boolean;
        private var _1775742881strTroop:TroopStrBean;
        private var _419054649canChangeIcon:Boolean;

        private var _2032248903buffsArray:ArrayCollection = new ArrayCollection();
        private var _2059290973buildingQueuesArray:ArrayCollection = new ArrayCollection();
        private var _1632439642buildingsArray:ArrayCollection = new ArrayCollection();
        private var _309360144colonyBeansArray:ArrayCollection = new ArrayCollection();
        private var _1228099360fieldsArray:ArrayCollection = new ArrayCollection();
        private var _1225376224herosArray:ArrayCollection = new ArrayCollection();
        private var _1293148908mercenaryBeansArray:ArrayCollection = new ArrayCollection();
        private var _1458231286tradesArray:ArrayCollection = new ArrayCollection();
        private var _637336720transingTradesArray:ArrayCollection = new ArrayCollection();

        public function CastleBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:BuffBean;
            var _local_4:BuildingQueueBean;
            var _local_5:BuildingBean;
            var _local_6:ColonyBean;
            var _local_7:FieldBean;
            var _local_8:HeroBean;
            var _local_9:MercenaryBean;
            var _local_10:TradeBean;
            var _local_11:TransingTradeBean;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.colonization != null)
                {
                    this.colonization = _arg_1.colonization;
                };
                if (_arg_1.fieldId != null)
                {
                    this.fieldId = _arg_1.fieldId;
                };
                if (_arg_1.fortification != null)
                {
                    this.fortification = new FortificationsBean(_arg_1.fortification);
                };
                if (_arg_1.icon != null)
                {
                    this.icon = _arg_1.icon;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.logUrl != null)
                {
                    this.logUrl = _arg_1.logUrl;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.powerlevel != null)
                {
                    this.powerlevel = _arg_1.powerlevel;
                };
                if (_arg_1.resource != null)
                {
                    this.resource = new CastleResourceBean(_arg_1.resource);
                };
                if (_arg_1.status != null)
                {
                    this.status = _arg_1.status;
                };
                if (_arg_1.strTroop != null)
                {
                    this.strTroop = new TroopStrBean(_arg_1.strTroop);
                };
                if (_arg_1.troop != null)
                {
                    this.troop = new TroopBean(_arg_1.troop);
                };
                if (_arg_1.usePACIFY_SUCCOUR_OR_PACIFY_PRAY != null)
                {
                    this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY = _arg_1.usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
                };
                if (_arg_1.zoneId != null)
                {
                    this.zoneId = _arg_1.zoneId;
                };
                if (_arg_1.allowAlliance != null)
                {
                    this.allowAlliance = _arg_1.allowAlliance;
                };
                if (_arg_1.canChangeIcon != null)
                {
                    this.canChangeIcon = _arg_1.canChangeIcon;
                };
                if (_arg_1.goOutForBattle != null)
                {
                    this.goOutForBattle = _arg_1.goOutForBattle;
                };
                if (_arg_1.hasEnemy != null)
                {
                    this.hasEnemy = _arg_1.hasEnemy;
                };
                if (_arg_1.buffs)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.buffs.length)
                    {
                        _local_3 = new BuffBean(_arg_1.buffs[_local_2]);
                        this.buffsArray.addItem(_local_3);
                        _local_2++;
                    };
                };
                if (_arg_1.buildingQueues)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.buildingQueues.length)
                    {
                        _local_4 = new BuildingQueueBean(_arg_1.buildingQueues[_local_2]);
                        this.buildingQueuesArray.addItem(_local_4);
                        _local_2++;
                    };
                };
                if (_arg_1.buildings)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.buildings.length)
                    {
                        _local_5 = new BuildingBean(_arg_1.buildings[_local_2]);
                        this.buildingsArray.addItem(_local_5);
                        _local_2++;
                    };
                };
                if (_arg_1.colonyBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.colonyBeans.length)
                    {
                        _local_6 = new ColonyBean(_arg_1.colonyBeans[_local_2]);
                        this.colonyBeansArray.addItem(_local_6);
                        _local_2++;
                    };
                };
                if (_arg_1.fields)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.fields.length)
                    {
                        _local_7 = new FieldBean(_arg_1.fields[_local_2]);
                        this.fieldsArray.addItem(_local_7);
                        _local_2++;
                    };
                };
                if (_arg_1.heros)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.heros.length)
                    {
                        _local_8 = new HeroBean(_arg_1.heros[_local_2]);
                        this.herosArray.addItem(_local_8);
                        _local_2++;
                    };
                };
                if (_arg_1.mercenaryBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.mercenaryBeans.length)
                    {
                        _local_9 = new MercenaryBean(_arg_1.mercenaryBeans[_local_2]);
                        this.mercenaryBeansArray.addItem(_local_9);
                        _local_2++;
                    };
                };
                if (_arg_1.trades)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.trades.length)
                    {
                        _local_10 = new TradeBean(_arg_1.trades[_local_2]);
                        this.tradesArray.addItem(_local_10);
                        _local_2++;
                    };
                };
                if (_arg_1.transingTrades)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.transingTrades.length)
                    {
                        _local_11 = new TransingTradeBean(_arg_1.transingTrades[_local_2]);
                        this.transingTradesArray.addItem(_local_11);
                        _local_2++;
                    };
                };
            };
        }

        public function set transingTradesArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._637336720transingTradesArray;
            if (_local_2 !== _arg_1)
            {
                this._637336720transingTradesArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "transingTradesArray", _local_2, _arg_1));
            };
        }

        public function getHeros(_arg_1:int):HeroBean
        {
            return (this.herosArray[_arg_1] as HeroBean);
        }

        public function set tradesArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1458231286tradesArray;
            if (_local_2 !== _arg_1)
            {
                this._1458231286tradesArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradesArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get usePACIFY_SUCCOUR_OR_PACIFY_PRAY():int
        {
            return (this._328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY);
        }

        [Bindable(event="propertyChange")]
        public function get tradesArray():ArrayCollection
        {
            return (this._1458231286tradesArray);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function set logUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1097354357logUrl;
            if (_local_2 !== _arg_1)
            {
                this._1097354357logUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get fieldsArray():ArrayCollection
        {
            return (this._1228099360fieldsArray);
        }

        [Bindable(event="propertyChange")]
        public function get resource():CastleResourceBean
        {
            return (this._341064690resource);
        }

        public function setColonyBeans(_arg_1:ColonyBean, _arg_2:int):void
        {
            this.colonyBeansArray[_arg_2] = _arg_1;
        }

        public function set resource(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._341064690resource;
            if (_local_2 !== _arg_1)
            {
                this._341064690resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resource", _local_2, _arg_1));
            };
        }

        public function set name(_arg_1:String):void
        {
            var _local_2:Object = this._3373707name;
            if (_local_2 !== _arg_1)
            {
                this._3373707name = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "name", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get herosArray():ArrayCollection
        {
            return (this._1225376224herosArray);
        }

        [Bindable(event="propertyChange")]
        public function get hasEnemy():Boolean
        {
            return (this._116645134hasEnemy);
        }

        [Bindable(event="propertyChange")]
        public function get colonization():int
        {
            return (this._208690213colonization);
        }

        public function set id(_arg_1:int):void
        {
            var _local_2:Object = this._3355id;
            if (_local_2 !== _arg_1)
            {
                this._3355id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get canChangeIcon():Boolean
        {
            return (this._419054649canChangeIcon);
        }

        public function setBuffs(_arg_1:BuffBean, _arg_2:int):void
        {
            this.buffsArray[_arg_2] = _arg_1;
        }

        public function set allowAlliance(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1236765024allowAlliance;
            if (_local_2 !== _arg_1)
            {
                this._1236765024allowAlliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allowAlliance", _local_2, _arg_1));
            };
        }

        public function set usePACIFY_SUCCOUR_OR_PACIFY_PRAY(_arg_1:int):void
        {
            var _local_2:Object = this._328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
            if (_local_2 !== _arg_1)
            {
                this._328168726usePACIFY_SUCCOUR_OR_PACIFY_PRAY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "usePACIFY_SUCCOUR_OR_PACIFY_PRAY", _local_2, _arg_1));
            };
        }

        public function set powerlevel(_arg_1:int):void
        {
            var _local_2:Object = this._452521375powerlevel;
            if (_local_2 !== _arg_1)
            {
                this._452521375powerlevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "powerlevel", _local_2, _arg_1));
            };
        }

        public function set strTroop(_arg_1:TroopStrBean):void
        {
            var _local_2:Object = this._1775742881strTroop;
            if (_local_2 !== _arg_1)
            {
                this._1775742881strTroop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strTroop", _local_2, _arg_1));
            };
        }

        public function getBuildingQueues(_arg_1:int):BuildingQueueBean
        {
            return (this.buildingQueuesArray[_arg_1] as BuildingQueueBean);
        }

        public function set buildingQueuesArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2059290973buildingQueuesArray;
            if (_local_2 !== _arg_1)
            {
                this._2059290973buildingQueuesArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingQueuesArray", _local_2, _arg_1));
            };
        }

        public function set fieldsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1228099360fieldsArray;
            if (_local_2 !== _arg_1)
            {
                this._1228099360fieldsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldsArray", _local_2, _arg_1));
            };
        }

        public function set colonization(_arg_1:int):void
        {
            var _local_2:Object = this._208690213colonization;
            if (_local_2 !== _arg_1)
            {
                this._208690213colonization = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonization", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get troop():TroopBean
        {
            return (this._110634834troop);
        }

        [Bindable(event="propertyChange")]
        public function get goOutForBattle():Boolean
        {
            return (this._45571131goOutForBattle);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set hasEnemy(_arg_1:Boolean):void
        {
            var _local_2:Object = this._116645134hasEnemy;
            if (_local_2 !== _arg_1)
            {
                this._116645134hasEnemy = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasEnemy", _local_2, _arg_1));
            };
        }

        public function setBuildingQueues(_arg_1:BuildingQueueBean, _arg_2:int):void
        {
            this.buildingQueuesArray[_arg_2] = _arg_1;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get buildingsArray():ArrayCollection
        {
            return (this._1632439642buildingsArray);
        }

        public function getTransingTrades(_arg_1:int):TransingTradeBean
        {
            return (this.transingTradesArray[_arg_1] as TransingTradeBean);
        }

        public function set herosArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1225376224herosArray;
            if (_local_2 !== _arg_1)
            {
                this._1225376224herosArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "herosArray", _local_2, _arg_1));
            };
        }

        public function getMercenaryBeans(_arg_1:int):MercenaryBean
        {
            return (this.mercenaryBeansArray[_arg_1] as MercenaryBean);
        }

        public function setTransingTrades(_arg_1:TransingTradeBean, _arg_2:int):void
        {
            this.transingTradesArray[_arg_2] = _arg_1;
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function setMercenaryBeans(_arg_1:MercenaryBean, _arg_2:int):void
        {
            this.mercenaryBeansArray[_arg_2] = _arg_1;
        }

        public function set fieldId(_arg_1:int):void
        {
            var _local_2:Object = this._861252683fieldId;
            if (_local_2 !== _arg_1)
            {
                this._861252683fieldId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldId", _local_2, _arg_1));
            };
        }

        public function set canChangeIcon(_arg_1:Boolean):void
        {
            var _local_2:Object = this._419054649canChangeIcon;
            if (_local_2 !== _arg_1)
            {
                this._419054649canChangeIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canChangeIcon", _local_2, _arg_1));
            };
        }

        public function setHeros(_arg_1:HeroBean, _arg_2:int):void
        {
            this.herosArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get icon():int
        {
            return (this._3226745icon);
        }

        public function set goOutForBattle(_arg_1:Boolean):void
        {
            var _local_2:Object = this._45571131goOutForBattle;
            if (_local_2 !== _arg_1)
            {
                this._45571131goOutForBattle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goOutForBattle", _local_2, _arg_1));
            };
        }

        public function set buffsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2032248903buffsArray;
            if (_local_2 !== _arg_1)
            {
                this._2032248903buffsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buffsArray", _local_2, _arg_1));
            };
        }

        public function getTrades(_arg_1:int):TradeBean
        {
            return (this.tradesArray[_arg_1] as TradeBean);
        }

        [Bindable(event="propertyChange")]
        public function get transingTradesArray():ArrayCollection
        {
            return (this._637336720transingTradesArray);
        }

        public function getBuildings(_arg_1:int):BuildingBean
        {
            return (this.buildingsArray[_arg_1] as BuildingBean);
        }

        [Bindable(event="propertyChange")]
        public function get logUrl():String
        {
            return (this._1097354357logUrl);
        }

        public function setTrades(_arg_1:TradeBean, _arg_2:int):void
        {
            this.tradesArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.colonization = this.colonization;
            _local_1.fieldId = this.fieldId;
            _local_1.fortification = this.fortification.toObject();
            _local_1.icon = this.icon;
            _local_1.id = this.id;
            _local_1.logUrl = this.logUrl;
            _local_1.name = this.name;
            _local_1.powerlevel = this.powerlevel;
            _local_1.resource = this.resource.toObject();
            _local_1.status = this.status;
            _local_1.strTroop = this.strTroop.toObject();
            _local_1.troop = this.troop.toObject();
            _local_1.usePACIFY_SUCCOUR_OR_PACIFY_PRAY = this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
            _local_1.zoneId = this.zoneId;
            _local_1.allowAlliance = this.allowAlliance;
            _local_1.canChangeIcon = this.canChangeIcon;
            _local_1.goOutForBattle = this.goOutForBattle;
            _local_1.hasEnemy = this.hasEnemy;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get powerlevel():int
        {
            return (this._452521375powerlevel);
        }

        [Bindable(event="propertyChange")]
        public function get allowAlliance():Boolean
        {
            return (this._1236765024allowAlliance);
        }

        [Bindable(event="propertyChange")]
        public function get buildingQueuesArray():ArrayCollection
        {
            return (this._2059290973buildingQueuesArray);
        }

        public function set troop(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._110634834troop;
            if (_local_2 !== _arg_1)
            {
                this._110634834troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get strTroop():TroopStrBean
        {
            return (this._1775742881strTroop);
        }

        public function getFields(_arg_1:int):FieldBean
        {
            return (this.fieldsArray[_arg_1] as FieldBean);
        }

        public function getColonyBeans(_arg_1:int):ColonyBean
        {
            return (this.colonyBeansArray[_arg_1] as ColonyBean);
        }

        public function set buildingsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1632439642buildingsArray;
            if (_local_2 !== _arg_1)
            {
                this._1632439642buildingsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingsArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get fieldId():int
        {
            return (this._861252683fieldId);
        }

        [Bindable(event="propertyChange")]
        public function get buffsArray():ArrayCollection
        {
            return (this._2032248903buffsArray);
        }

        public function setFields(_arg_1:FieldBean, _arg_2:int):void
        {
            this.fieldsArray[_arg_2] = _arg_1;
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "colonization = ") + this.colonization) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "fieldId = ") + this.fieldId) + "\n"));
            if (fortification != null)
            {
                _local_2 = (_local_2 + this.fortification.toDebugString((_arg_1 + "fortification.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "fortification = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "icon = ") + this.icon) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "logUrl = ") + this.logUrl) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "powerlevel = ") + this.powerlevel) + "\n"));
            if (resource != null)
            {
                _local_2 = (_local_2 + this.resource.toDebugString((_arg_1 + "resource.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "resource = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
            if (strTroop != null)
            {
                _local_2 = (_local_2 + this.strTroop.toDebugString((_arg_1 + "strTroop.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "strTroop = null\n"));
            };
            if (troop != null)
            {
                _local_2 = (_local_2 + this.troop.toDebugString((_arg_1 + "troop.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "troop = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "usePACIFY_SUCCOUR_OR_PACIFY_PRAY = ") + this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "zoneId = ") + this.zoneId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "allowAlliance = ") + this.allowAlliance) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canChangeIcon = ") + this.canChangeIcon) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "goOutForBattle = ") + this.goOutForBattle) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "hasEnemy = ") + this.hasEnemy) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.buffsArray.length)
            {
                _local_2 = (_local_2 + this.getBuffs(_local_3).toDebugString((((_arg_1 + "buffs[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.buildingQueuesArray.length)
            {
                _local_2 = (_local_2 + this.getBuildingQueues(_local_3).toDebugString((((_arg_1 + "buildingQueues[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.buildingsArray.length)
            {
                _local_2 = (_local_2 + this.getBuildings(_local_3).toDebugString((((_arg_1 + "buildings[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.colonyBeansArray.length)
            {
                _local_2 = (_local_2 + this.getColonyBeans(_local_3).toDebugString((((_arg_1 + "colonyBeans[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.fieldsArray.length)
            {
                _local_2 = (_local_2 + this.getFields(_local_3).toDebugString((((_arg_1 + "fields[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.herosArray.length)
            {
                _local_2 = (_local_2 + this.getHeros(_local_3).toDebugString((((_arg_1 + "heros[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.mercenaryBeansArray.length)
            {
                _local_2 = (_local_2 + this.getMercenaryBeans(_local_3).toDebugString((((_arg_1 + "mercenaryBeans[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.tradesArray.length)
            {
                _local_2 = (_local_2 + this.getTrades(_local_3).toDebugString((((_arg_1 + "trades[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.transingTradesArray.length)
            {
                _local_2 = (_local_2 + this.getTransingTrades(_local_3).toDebugString((((_arg_1 + "transingTrades[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getBuffs(_arg_1:int):BuffBean
        {
            return (this.buffsArray[_arg_1] as BuffBean);
        }

        public function set zoneId(_arg_1:int):void
        {
            var _local_2:Object = this._696323609zoneId;
            if (_local_2 !== _arg_1)
            {
                this._696323609zoneId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoneId", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:CastleBean):void
        {
            _arg_1.colonization = this.colonization;
            _arg_1.fieldId = this.fieldId;
            if (fortification != null)
            {
                this.fortification.copyTo(_arg_1.fortification);
            }
            else
            {
                _arg_1.fortification = null;
            };
            _arg_1.icon = this.icon;
            _arg_1.id = this.id;
            _arg_1.logUrl = this.logUrl;
            _arg_1.name = this.name;
            _arg_1.powerlevel = this.powerlevel;
            if (resource != null)
            {
                this.resource.copyTo(_arg_1.resource);
            }
            else
            {
                _arg_1.resource = null;
            };
            _arg_1.status = this.status;
            if (strTroop != null)
            {
                this.strTroop.copyTo(_arg_1.strTroop);
            }
            else
            {
                _arg_1.strTroop = null;
            };
            if (troop != null)
            {
                this.troop.copyTo(_arg_1.troop);
            }
            else
            {
                _arg_1.troop = null;
            };
            _arg_1.usePACIFY_SUCCOUR_OR_PACIFY_PRAY = this.usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
            _arg_1.zoneId = this.zoneId;
            _arg_1.allowAlliance = this.allowAlliance;
            _arg_1.canChangeIcon = this.canChangeIcon;
            _arg_1.goOutForBattle = this.goOutForBattle;
            _arg_1.hasEnemy = this.hasEnemy;
            CommonUtil.arrayCopy(this.buffsArray, _arg_1.buffsArray);
            CommonUtil.arrayCopy(this.buildingQueuesArray, _arg_1.buildingQueuesArray);
            CommonUtil.arrayCopy(this.buildingsArray, _arg_1.buildingsArray);
            CommonUtil.arrayCopy(this.colonyBeansArray, _arg_1.colonyBeansArray);
            CommonUtil.arrayCopy(this.fieldsArray, _arg_1.fieldsArray);
            CommonUtil.arrayCopy(this.herosArray, _arg_1.herosArray);
            CommonUtil.arrayCopy(this.mercenaryBeansArray, _arg_1.mercenaryBeansArray);
            CommonUtil.arrayCopy(this.tradesArray, _arg_1.tradesArray);
            CommonUtil.arrayCopy(this.transingTradesArray, _arg_1.transingTradesArray);
        }

        public function set mercenaryBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1293148908mercenaryBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._1293148908mercenaryBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mercenaryBeansArray", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set status(_arg_1:int):void
        {
            var _local_2:Object = this._892481550status;
            if (_local_2 !== _arg_1)
            {
                this._892481550status = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _local_2, _arg_1));
            };
        }

        public function set fortification(_arg_1:FortificationsBean):void
        {
            var _local_2:Object = this._233906701fortification;
            if (_local_2 !== _arg_1)
            {
                this._233906701fortification = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortification", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get zoneId():int
        {
            return (this._696323609zoneId);
        }

        [Bindable(event="propertyChange")]
        public function get status():int
        {
            return (this._892481550status);
        }

        [Bindable(event="propertyChange")]
        public function get fortification():FortificationsBean
        {
            return (this._233906701fortification);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get colonyBeansArray():ArrayCollection
        {
            return (this._309360144colonyBeansArray);
        }

        public function set colonyBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._309360144colonyBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._309360144colonyBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBeansArray", _local_2, _arg_1));
            };
        }

        public function set icon(_arg_1:int):void
        {
            var _local_2:Object = this._3226745icon;
            if (_local_2 !== _arg_1)
            {
                this._3226745icon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "icon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get mercenaryBeansArray():ArrayCollection
        {
            return (this._1293148908mercenaryBeansArray);
        }

        public function setBuildings(_arg_1:BuildingBean, _arg_2:int):void
        {
            this.buildingsArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.beans

