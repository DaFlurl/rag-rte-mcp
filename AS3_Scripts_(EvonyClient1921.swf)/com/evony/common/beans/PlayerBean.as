// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.PlayerBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.collections.ArrayCollection;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.CommonUtil;
    import com.evony.common.paramBeans.*;

    public class PlayerBean implements IEventDispatcher 
    {

        private var _165283771isSetSecurityCode:Boolean;
        private var _811312386redCount:int;
        private var _2100063033isReceiveIncomingAttack:Boolean;
        private var _1329771231autoFurlough:Boolean;
        private var _167675003mapSizeX:int;
        private var _989948789gameSpeed:int;
        private var _2041542881newReportCount_army:int;
        private var _29843496newMailCount:int;
        private var _1331910750digiId:String;
        private var _1123696564newReportCount_other:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1484814694gamblingItemIndex:int;
        private var _1070931784emailAddress:String;
        private var _1438363703autoHeal:Boolean;
        private var _2026418520newMaileCount_inbox:int;
        private var _1902496333newMaileCount_system:int;
        private var _784915076returnReport:Boolean;
        private var _230483579newReportCount:int;
        private var _1081550341tutorialStepId:int;
        private var _1651231951changedFace:Boolean;
        private var _1503629328furlough:Boolean;
        private var _1887518356furloughDay:int;
        private var _1440789421disconnectvotes:Number;
        private var _1432206175finishedQuestCount:int;
        private var _1971832828effortPoint:int;
        private var _167675004mapSizeY:int;
        private var _1120501702newReportCount_scout:int;
        private var _248723404currentDateTime:String;
        private var _1524843188freshMan:Boolean;
        private var _2054170777isEvonyMember:Boolean;
        private var _601235430currentTime:Number;
        private var _1115058732headline:String;
        private var _1119145312newReportCount_trade:int;
        private var _2095520559playerInfo:PlayerInfoBean;

        private var _1461815869blockBeansArray:ArrayCollection = new ArrayCollection();
        private var _2032248903buffsArray:ArrayCollection = new ArrayCollection();
        private var _675024588castleSignBeanArray:ArrayCollection = new ArrayCollection();
        private var _902435682castlesArray:ArrayCollection = new ArrayCollection();
        private var _376568900declaredWarBeansArray:ArrayCollection = new ArrayCollection();
        private var _1378032427enemyArmysArray:ArrayCollection = new ArrayCollection();
        private var _1503909044equipmentsArray:ArrayCollection = new ArrayCollection();
        private var _704639681friendArmysArray:ArrayCollection = new ArrayCollection();
        private var _1918704276friendBeansArray:ArrayCollection = new ArrayCollection();
        private var _874955648gemstoneinposArray:ArrayCollection = new ArrayCollection();
        private var _1425640839itemsArray:ArrayCollection = new ArrayCollection();
        private var _117401885packageBeanArray:ArrayCollection = new ArrayCollection();
        private var _1981766659randomEventsArray:ArrayCollection = new ArrayCollection();
        private var _1102495504saleItemBeansArray:ArrayCollection = new ArrayCollection();
        private var _925069225saleTypeBeansArray:ArrayCollection = new ArrayCollection();
        private var _859583983selfArmysArray:ArrayCollection = new ArrayCollection();
        private var _1970419386setshowinfroArray:ArrayCollection = new ArrayCollection();
        private var _196779434troopConfigBeansArray:ArrayCollection = new ArrayCollection();

        public function PlayerBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:PlayerInfoBean;
            var _local_4:BuffBean;
            var _local_5:CastleSignInfoBean;
            var _local_6:CastleBean;
            var _local_7:PlayerDeclaredWarBean;
            var _local_8:ArmyBean;
            var _local_9:EquipmenttechBean;
            var _local_10:ArmyBean;
            var _local_11:PlayerInfoBean;
            var _local_12:GemStoneInPosBean;
            var _local_13:ItemBean;
            var _local_14:PackageBean;
            var _local_15:RandomEventBean;
            var _local_16:SaleItemBean;
            var _local_17:SaleTypeBean;
            var _local_18:ArmyBean;
            var _local_19:SetShowInfro;
            var _local_20:TroopConfigBean;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.changedFace != null)
                {
                    this.changedFace = _arg_1.changedFace;
                };
                if (_arg_1.currentDateTime != null)
                {
                    this.currentDateTime = _arg_1.currentDateTime;
                };
                if (_arg_1.currentTime != null)
                {
                    this.currentTime = _arg_1.currentTime;
                };
                if (_arg_1.digiId != null)
                {
                    this.digiId = _arg_1.digiId;
                };
                if (_arg_1.disconnectvotes != null)
                {
                    this.disconnectvotes = _arg_1.disconnectvotes;
                };
                if (_arg_1.effortPoint != null)
                {
                    this.effortPoint = _arg_1.effortPoint;
                };
                if (_arg_1.emailAddress != null)
                {
                    this.emailAddress = _arg_1.emailAddress;
                };
                if (_arg_1.finishedQuestCount != null)
                {
                    this.finishedQuestCount = _arg_1.finishedQuestCount;
                };
                if (_arg_1.freshMan != null)
                {
                    this.freshMan = _arg_1.freshMan;
                };
                if (_arg_1.furloughDay != null)
                {
                    this.furloughDay = _arg_1.furloughDay;
                };
                if (_arg_1.gamblingItemIndex != null)
                {
                    this.gamblingItemIndex = _arg_1.gamblingItemIndex;
                };
                if (_arg_1.gameSpeed != null)
                {
                    this.gameSpeed = _arg_1.gameSpeed;
                };
                if (_arg_1.headline != null)
                {
                    this.headline = _arg_1.headline;
                };
                if (_arg_1.isEvonyMember != null)
                {
                    this.isEvonyMember = _arg_1.isEvonyMember;
                };
                if (_arg_1.isReceiveIncomingAttack != null)
                {
                    this.isReceiveIncomingAttack = _arg_1.isReceiveIncomingAttack;
                };
                if (_arg_1.isSetSecurityCode != null)
                {
                    this.isSetSecurityCode = _arg_1.isSetSecurityCode;
                };
                if (_arg_1.mapSizeX != null)
                {
                    this.mapSizeX = _arg_1.mapSizeX;
                };
                if (_arg_1.mapSizeY != null)
                {
                    this.mapSizeY = _arg_1.mapSizeY;
                };
                if (_arg_1.newMailCount != null)
                {
                    this.newMailCount = _arg_1.newMailCount;
                };
                if (_arg_1.newMaileCount_inbox != null)
                {
                    this.newMaileCount_inbox = _arg_1.newMaileCount_inbox;
                };
                if (_arg_1.newMaileCount_system != null)
                {
                    this.newMaileCount_system = _arg_1.newMaileCount_system;
                };
                if (_arg_1.newReportCount != null)
                {
                    this.newReportCount = _arg_1.newReportCount;
                };
                if (_arg_1.newReportCount_army != null)
                {
                    this.newReportCount_army = _arg_1.newReportCount_army;
                };
                if (_arg_1.newReportCount_other != null)
                {
                    this.newReportCount_other = _arg_1.newReportCount_other;
                };
                if (_arg_1.newReportCount_scout != null)
                {
                    this.newReportCount_scout = _arg_1.newReportCount_scout;
                };
                if (_arg_1.newReportCount_trade != null)
                {
                    this.newReportCount_trade = _arg_1.newReportCount_trade;
                };
                if (_arg_1.playerInfo != null)
                {
                    this.playerInfo = new PlayerInfoBean(_arg_1.playerInfo);
                };
                if (_arg_1.redCount != null)
                {
                    this.redCount = _arg_1.redCount;
                };
                if (_arg_1.tutorialStepId != null)
                {
                    this.tutorialStepId = _arg_1.tutorialStepId;
                };
                if (_arg_1.autoFurlough != null)
                {
                    this.autoFurlough = _arg_1.autoFurlough;
                };
                if (_arg_1.autoHeal != null)
                {
                    this.autoHeal = _arg_1.autoHeal;
                };
                if (_arg_1.furlough != null)
                {
                    this.furlough = _arg_1.furlough;
                };
                if (_arg_1.returnReport != null)
                {
                    this.returnReport = _arg_1.returnReport;
                };
                if (_arg_1.blockBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.blockBeans.length)
                    {
                        _local_3 = new PlayerInfoBean(_arg_1.blockBeans[_local_2]);
                        this.blockBeansArray.addItem(_local_3);
                        _local_2++;
                    };
                };
                if (_arg_1.buffs)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.buffs.length)
                    {
                        _local_4 = new BuffBean(_arg_1.buffs[_local_2]);
                        this.buffsArray.addItem(_local_4);
                        _local_2++;
                    };
                };
                if (_arg_1.castleSignBean)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.castleSignBean.length)
                    {
                        _local_5 = new CastleSignInfoBean(_arg_1.castleSignBean[_local_2]);
                        this.castleSignBeanArray.addItem(_local_5);
                        _local_2++;
                    };
                };
                if (_arg_1.castles)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.castles.length)
                    {
                        _local_6 = new CastleBean(_arg_1.castles[_local_2]);
                        this.castlesArray.addItem(_local_6);
                        _local_2++;
                    };
                };
                if (_arg_1.declaredWarBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.declaredWarBeans.length)
                    {
                        _local_7 = new PlayerDeclaredWarBean(_arg_1.declaredWarBeans[_local_2]);
                        this.declaredWarBeansArray.addItem(_local_7);
                        _local_2++;
                    };
                };
                if (_arg_1.enemyArmys)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.enemyArmys.length)
                    {
                        _local_8 = new ArmyBean(_arg_1.enemyArmys[_local_2]);
                        this.enemyArmysArray.addItem(_local_8);
                        _local_2++;
                    };
                };
                if (_arg_1.equipments)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.equipments.length)
                    {
                        _local_9 = new EquipmenttechBean(_arg_1.equipments[_local_2]);
                        this.equipmentsArray.addItem(_local_9);
                        _local_2++;
                    };
                };
                if (_arg_1.friendArmys)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.friendArmys.length)
                    {
                        _local_10 = new ArmyBean(_arg_1.friendArmys[_local_2]);
                        this.friendArmysArray.addItem(_local_10);
                        _local_2++;
                    };
                };
                if (_arg_1.friendBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.friendBeans.length)
                    {
                        _local_11 = new PlayerInfoBean(_arg_1.friendBeans[_local_2]);
                        this.friendBeansArray.addItem(_local_11);
                        _local_2++;
                    };
                };
                if (_arg_1.gemstoneinpos)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.gemstoneinpos.length)
                    {
                        _local_12 = new GemStoneInPosBean(_arg_1.gemstoneinpos[_local_2]);
                        this.gemstoneinposArray.addItem(_local_12);
                        _local_2++;
                    };
                };
                if (_arg_1.items)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.items.length)
                    {
                        _local_13 = new ItemBean(_arg_1.items[_local_2]);
                        this.itemsArray.addItem(_local_13);
                        _local_2++;
                    };
                };
                if (_arg_1.packageBean)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.packageBean.length)
                    {
                        _local_14 = new PackageBean(_arg_1.packageBean[_local_2]);
                        this.packageBeanArray.addItem(_local_14);
                        _local_2++;
                    };
                };
                if (_arg_1.randomEvents)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.randomEvents.length)
                    {
                        _local_15 = new RandomEventBean(_arg_1.randomEvents[_local_2]);
                        this.randomEventsArray.addItem(_local_15);
                        _local_2++;
                    };
                };
                if (_arg_1.saleItemBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.saleItemBeans.length)
                    {
                        _local_16 = new SaleItemBean(_arg_1.saleItemBeans[_local_2]);
                        this.saleItemBeansArray.addItem(_local_16);
                        _local_2++;
                    };
                };
                if (_arg_1.saleTypeBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.saleTypeBeans.length)
                    {
                        _local_17 = new SaleTypeBean(_arg_1.saleTypeBeans[_local_2]);
                        this.saleTypeBeansArray.addItem(_local_17);
                        _local_2++;
                    };
                };
                if (_arg_1.selfArmys)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.selfArmys.length)
                    {
                        _local_18 = new ArmyBean(_arg_1.selfArmys[_local_2]);
                        this.selfArmysArray.addItem(_local_18);
                        _local_2++;
                    };
                };
                if (_arg_1.setshowinfro)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.setshowinfro.length)
                    {
                        _local_19 = new SetShowInfro(_arg_1.setshowinfro[_local_2]);
                        this.setshowinfroArray.addItem(_local_19);
                        _local_2++;
                    };
                };
                if (_arg_1.troopConfigBeans)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.troopConfigBeans.length)
                    {
                        _local_20 = new TroopConfigBean(_arg_1.troopConfigBeans[_local_2]);
                        this.troopConfigBeansArray.addItem(_local_20);
                        _local_2++;
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get effortPoint():int
        {
            return (this._1971832828effortPoint);
        }

        [Bindable(event="propertyChange")]
        public function get tutorialStepId():int
        {
            return (this._1081550341tutorialStepId);
        }

        public function set effortPoint(_arg_1:int):void
        {
            var _local_2:Object = this._1971832828effortPoint;
            if (_local_2 !== _arg_1)
            {
                this._1971832828effortPoint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effortPoint", _local_2, _arg_1));
            };
        }

        public function getItems(_arg_1:int):ItemBean
        {
            return (this.itemsArray[_arg_1] as ItemBean);
        }

        [Bindable(event="propertyChange")]
        public function get furlough():Boolean
        {
            return (this._1503629328furlough);
        }

        public function set tutorialStepId(_arg_1:int):void
        {
            var _local_2:Object = this._1081550341tutorialStepId;
            if (_local_2 !== _arg_1)
            {
                this._1081550341tutorialStepId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tutorialStepId", _local_2, _arg_1));
            };
        }

        public function set furlough(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1503629328furlough;
            if (_local_2 !== _arg_1)
            {
                this._1503629328furlough = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "furlough", _local_2, _arg_1));
            };
        }

        public function getBlockBeans(_arg_1:int):PlayerInfoBean
        {
            return (this.blockBeansArray[_arg_1] as PlayerInfoBean);
        }

        public function getRandomEvents(_arg_1:int):RandomEventBean
        {
            return (this.randomEventsArray[_arg_1] as RandomEventBean);
        }

        [Bindable(event="propertyChange")]
        public function get autoHeal():Boolean
        {
            return (this._1438363703autoHeal);
        }

        [Bindable(event="propertyChange")]
        public function get newReportCount_scout():int
        {
            return (this._1120501702newReportCount_scout);
        }

        public function setBlockBeans(_arg_1:PlayerInfoBean, _arg_2:int):void
        {
            this.blockBeansArray[_arg_2] = _arg_1;
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get declaredWarBeansArray():ArrayCollection
        {
            return (this._376568900declaredWarBeansArray);
        }

        public function getCastles(_arg_1:int):CastleBean
        {
            return (this.castlesArray[_arg_1] as CastleBean);
        }

        public function setSelfArmys(_arg_1:ArmyBean, _arg_2:int):void
        {
            this.selfArmysArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get isSetSecurityCode():Boolean
        {
            return (this._165283771isSetSecurityCode);
        }

        [Bindable(event="propertyChange")]
        public function get newReportCount_other():int
        {
            return (this._1123696564newReportCount_other);
        }

        [Bindable(event="propertyChange")]
        public function get currentDateTime():String
        {
            return (this._248723404currentDateTime);
        }

        [Bindable(event="propertyChange")]
        public function get saleTypeBeansArray():ArrayCollection
        {
            return (this._925069225saleTypeBeansArray);
        }

        public function set enemyArmysArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1378032427enemyArmysArray;
            if (_local_2 !== _arg_1)
            {
                this._1378032427enemyArmysArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyArmysArray", _local_2, _arg_1));
            };
        }

        public function setSetshowinfro(_arg_1:SetShowInfro, _arg_2:int):void
        {
            this.setshowinfroArray[_arg_2] = _arg_1;
        }

        public function set changedFace(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1651231951changedFace;
            if (_local_2 !== _arg_1)
            {
                this._1651231951changedFace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changedFace", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newMaileCount_system():int
        {
            return (this._1902496333newMaileCount_system);
        }

        public function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        public function set autoHeal(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1438363703autoHeal;
            if (_local_2 !== _arg_1)
            {
                this._1438363703autoHeal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoHeal", _local_2, _arg_1));
            };
        }

        public function setTroopConfigBeans(_arg_1:TroopConfigBean, _arg_2:int):void
        {
            this.troopConfigBeansArray[_arg_2] = _arg_1;
        }

        public function set newReportCount_scout(_arg_1:int):void
        {
            var _local_2:Object = this._1120501702newReportCount_scout;
            if (_local_2 !== _arg_1)
            {
                this._1120501702newReportCount_scout = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount_scout", _local_2, _arg_1));
            };
        }

        public function set currentDateTime(_arg_1:String):void
        {
            var _local_2:Object = this._248723404currentDateTime;
            if (_local_2 !== _arg_1)
            {
                this._248723404currentDateTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentDateTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemsArray():ArrayCollection
        {
            return (this._1425640839itemsArray);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get mapSizeY():int
        {
            return (this._167675004mapSizeY);
        }

        [Bindable(event="propertyChange")]
        public function get mapSizeX():int
        {
            return (this._167675003mapSizeX);
        }

        [Bindable(event="propertyChange")]
        public function get returnReport():Boolean
        {
            return (this._784915076returnReport);
        }

        public function setItems(_arg_1:ItemBean, _arg_2:int):void
        {
            this.itemsArray[_arg_2] = _arg_1;
        }

        public function set declaredWarBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._376568900declaredWarBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._376568900declaredWarBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declaredWarBeansArray", _local_2, _arg_1));
            };
        }

        public function set isSetSecurityCode(_arg_1:Boolean):void
        {
            var _local_2:Object = this._165283771isSetSecurityCode;
            if (_local_2 !== _arg_1)
            {
                this._165283771isSetSecurityCode = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isSetSecurityCode", _local_2, _arg_1));
            };
        }

        public function getDeclaredWarBeans(_arg_1:int):PlayerDeclaredWarBean
        {
            return (this.declaredWarBeansArray[_arg_1] as PlayerDeclaredWarBean);
        }

        [Bindable(event="propertyChange")]
        public function get friendBeansArray():ArrayCollection
        {
            return (this._1918704276friendBeansArray);
        }

        public function set castleSignBeanArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._675024588castleSignBeanArray;
            if (_local_2 !== _arg_1)
            {
                this._675024588castleSignBeanArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleSignBeanArray", _local_2, _arg_1));
            };
        }

        public function set freshMan(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1524843188freshMan;
            if (_local_2 !== _arg_1)
            {
                this._1524843188freshMan = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "freshMan", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isEvonyMember():Boolean
        {
            return (this._2054170777isEvonyMember);
        }

        [Bindable(event="propertyChange")]
        public function get newReportCount():int
        {
            return (this._230483579newReportCount);
        }

        public function set newReportCount_other(_arg_1:int):void
        {
            var _local_2:Object = this._1123696564newReportCount_other;
            if (_local_2 !== _arg_1)
            {
                this._1123696564newReportCount_other = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount_other", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newReportCount_trade():int
        {
            return (this._1119145312newReportCount_trade);
        }

        [Bindable(event="propertyChange")]
        public function get gamblingItemIndex():int
        {
            return (this._1484814694gamblingItemIndex);
        }

        public function getEquipments(_arg_1:int):EquipmenttechBean
        {
            return (this.equipmentsArray[_arg_1] as EquipmenttechBean);
        }

        public function getGemstoneinpos(_arg_1:int):GemStoneInPosBean
        {
            return (this.gemstoneinposArray[_arg_1] as GemStoneInPosBean);
        }

        public function setEquipments(_arg_1:EquipmenttechBean, _arg_2:int):void
        {
            this.equipmentsArray[_arg_2] = _arg_1;
        }

        public function set newMaileCount_system(_arg_1:int):void
        {
            var _local_2:Object = this._1902496333newMaileCount_system;
            if (_local_2 !== _arg_1)
            {
                this._1902496333newMaileCount_system = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newMaileCount_system", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get castlesArray():ArrayCollection
        {
            return (this._902435682castlesArray);
        }

        [Bindable(event="propertyChange")]
        public function get newMaileCount_inbox():int
        {
            return (this._2026418520newMaileCount_inbox);
        }

        public function set saleTypeBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._925069225saleTypeBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._925069225saleTypeBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saleTypeBeansArray", _local_2, _arg_1));
            };
        }

        public function setFriendArmys(_arg_1:ArmyBean, _arg_2:int):void
        {
            this.friendArmysArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get setshowinfroArray():ArrayCollection
        {
            return (this._1970419386setshowinfroArray);
        }

        [Bindable(event="propertyChange")]
        public function get equipmentsArray():ArrayCollection
        {
            return (this._1503909044equipmentsArray);
        }

        [Bindable(event="propertyChange")]
        public function get emailAddress():String
        {
            return (this._1070931784emailAddress);
        }

        [Bindable(event="propertyChange")]
        public function get friendArmysArray():ArrayCollection
        {
            return (this._704639681friendArmysArray);
        }

        public function set finishedQuestCount(_arg_1:int):void
        {
            var _local_2:Object = this._1432206175finishedQuestCount;
            if (_local_2 !== _arg_1)
            {
                this._1432206175finishedQuestCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "finishedQuestCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isReceiveIncomingAttack():Boolean
        {
            return (this._2100063033isReceiveIncomingAttack);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "changedFace = ") + this.changedFace) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "currentDateTime = ") + this.currentDateTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "currentTime = ") + this.currentTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "digiId = ") + this.digiId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "disconnectvotes = ") + this.disconnectvotes) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "effortPoint = ") + this.effortPoint) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "emailAddress = ") + this.emailAddress) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "finishedQuestCount = ") + this.finishedQuestCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "freshMan = ") + this.freshMan) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "furloughDay = ") + this.furloughDay) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "gamblingItemIndex = ") + this.gamblingItemIndex) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "gameSpeed = ") + this.gameSpeed) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "headline = ") + this.headline) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isEvonyMember = ") + this.isEvonyMember) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isReceiveIncomingAttack = ") + this.isReceiveIncomingAttack) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isSetSecurityCode = ") + this.isSetSecurityCode) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "mapSizeX = ") + this.mapSizeX) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "mapSizeY = ") + this.mapSizeY) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newMailCount = ") + this.newMailCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newMaileCount_inbox = ") + this.newMaileCount_inbox) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newMaileCount_system = ") + this.newMaileCount_system) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newReportCount = ") + this.newReportCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newReportCount_army = ") + this.newReportCount_army) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newReportCount_other = ") + this.newReportCount_other) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newReportCount_scout = ") + this.newReportCount_scout) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "newReportCount_trade = ") + this.newReportCount_trade) + "\n"));
            if (playerInfo != null)
            {
                _local_2 = (_local_2 + this.playerInfo.toDebugString((_arg_1 + "playerInfo.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "playerInfo = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "redCount = ") + this.redCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "tutorialStepId = ") + this.tutorialStepId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "autoFurlough = ") + this.autoFurlough) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "autoHeal = ") + this.autoHeal) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "furlough = ") + this.furlough) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "returnReport = ") + this.returnReport) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.blockBeansArray.length)
            {
                _local_2 = (_local_2 + this.getBlockBeans(_local_3).toDebugString((((_arg_1 + "blockBeans[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.buffsArray.length)
            {
                _local_2 = (_local_2 + this.getBuffs(_local_3).toDebugString((((_arg_1 + "buffs[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.castleSignBeanArray.length)
            {
                _local_2 = (_local_2 + this.getCastleSignBean(_local_3).toDebugString((((_arg_1 + "castleSignBean[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.castlesArray.length)
            {
                _local_2 = (_local_2 + this.getCastles(_local_3).toDebugString((((_arg_1 + "castles[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.declaredWarBeansArray.length)
            {
                _local_2 = (_local_2 + this.getDeclaredWarBeans(_local_3).toDebugString((((_arg_1 + "declaredWarBeans[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.enemyArmysArray.length)
            {
                _local_2 = (_local_2 + this.getEnemyArmys(_local_3).toDebugString((((_arg_1 + "enemyArmys[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.equipmentsArray.length)
            {
                _local_2 = (_local_2 + this.getEquipments(_local_3).toDebugString((((_arg_1 + "equipments[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.friendArmysArray.length)
            {
                _local_2 = (_local_2 + this.getFriendArmys(_local_3).toDebugString((((_arg_1 + "friendArmys[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.friendBeansArray.length)
            {
                _local_2 = (_local_2 + this.getFriendBeans(_local_3).toDebugString((((_arg_1 + "friendBeans[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.gemstoneinposArray.length)
            {
                _local_2 = (_local_2 + this.getGemstoneinpos(_local_3).toDebugString((((_arg_1 + "gemstoneinpos[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.itemsArray.length)
            {
                _local_2 = (_local_2 + this.getItems(_local_3).toDebugString((((_arg_1 + "items[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.packageBeanArray.length)
            {
                _local_2 = (_local_2 + this.getPackageBean(_local_3).toDebugString((((_arg_1 + "packageBean[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.randomEventsArray.length)
            {
                _local_2 = (_local_2 + this.getRandomEvents(_local_3).toDebugString((((_arg_1 + "randomEvents[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.saleItemBeansArray.length)
            {
                _local_2 = (_local_2 + this.getSaleItemBeans(_local_3).toDebugString((((_arg_1 + "saleItemBeans[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.saleTypeBeansArray.length)
            {
                _local_2 = (_local_2 + this.getSaleTypeBeans(_local_3).toDebugString((((_arg_1 + "saleTypeBeans[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.selfArmysArray.length)
            {
                _local_2 = (_local_2 + this.getSelfArmys(_local_3).toDebugString((((_arg_1 + "selfArmys[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.setshowinfroArray.length)
            {
                _local_2 = (_local_2 + this.getSetshowinfro(_local_3).toDebugString((((_arg_1 + "setshowinfro[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.troopConfigBeansArray.length)
            {
                _local_2 = (_local_2 + this.getTroopConfigBeans(_local_3).toDebugString((((_arg_1 + "troopConfigBeans[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getBuffs(_arg_1:int):BuffBean
        {
            return (this.buffsArray[_arg_1] as BuffBean);
        }

        public function copyTo(_arg_1:PlayerBean):void
        {
            _arg_1.changedFace = this.changedFace;
            _arg_1.currentDateTime = this.currentDateTime;
            _arg_1.currentTime = this.currentTime;
            _arg_1.digiId = this.digiId;
            _arg_1.disconnectvotes = this.disconnectvotes;
            _arg_1.effortPoint = this.effortPoint;
            _arg_1.emailAddress = this.emailAddress;
            _arg_1.finishedQuestCount = this.finishedQuestCount;
            _arg_1.freshMan = this.freshMan;
            _arg_1.furloughDay = this.furloughDay;
            _arg_1.gamblingItemIndex = this.gamblingItemIndex;
            _arg_1.gameSpeed = this.gameSpeed;
            _arg_1.headline = this.headline;
            _arg_1.isEvonyMember = this.isEvonyMember;
            _arg_1.isReceiveIncomingAttack = this.isReceiveIncomingAttack;
            _arg_1.isSetSecurityCode = this.isSetSecurityCode;
            _arg_1.mapSizeX = this.mapSizeX;
            _arg_1.mapSizeY = this.mapSizeY;
            _arg_1.newMailCount = this.newMailCount;
            _arg_1.newMaileCount_inbox = this.newMaileCount_inbox;
            _arg_1.newMaileCount_system = this.newMaileCount_system;
            _arg_1.newReportCount = this.newReportCount;
            _arg_1.newReportCount_army = this.newReportCount_army;
            _arg_1.newReportCount_other = this.newReportCount_other;
            _arg_1.newReportCount_scout = this.newReportCount_scout;
            _arg_1.newReportCount_trade = this.newReportCount_trade;
            if (playerInfo != null)
            {
                this.playerInfo.copyTo(_arg_1.playerInfo);
            }
            else
            {
                _arg_1.playerInfo = null;
            };
            _arg_1.redCount = this.redCount;
            _arg_1.tutorialStepId = this.tutorialStepId;
            _arg_1.autoFurlough = this.autoFurlough;
            _arg_1.autoHeal = this.autoHeal;
            _arg_1.furlough = this.furlough;
            _arg_1.returnReport = this.returnReport;
            CommonUtil.arrayCopy(this.blockBeansArray, _arg_1.blockBeansArray);
            CommonUtil.arrayCopy(this.buffsArray, _arg_1.buffsArray);
            CommonUtil.arrayCopy(this.castleSignBeanArray, _arg_1.castleSignBeanArray);
            CommonUtil.arrayCopy(this.castlesArray, _arg_1.castlesArray);
            CommonUtil.arrayCopy(this.declaredWarBeansArray, _arg_1.declaredWarBeansArray);
            CommonUtil.arrayCopy(this.enemyArmysArray, _arg_1.enemyArmysArray);
            CommonUtil.arrayCopy(this.equipmentsArray, _arg_1.equipmentsArray);
            CommonUtil.arrayCopy(this.friendArmysArray, _arg_1.friendArmysArray);
            CommonUtil.arrayCopy(this.friendBeansArray, _arg_1.friendBeansArray);
            CommonUtil.arrayCopy(this.gemstoneinposArray, _arg_1.gemstoneinposArray);
            CommonUtil.arrayCopy(this.itemsArray, _arg_1.itemsArray);
            CommonUtil.arrayCopy(this.packageBeanArray, _arg_1.packageBeanArray);
            CommonUtil.arrayCopy(this.randomEventsArray, _arg_1.randomEventsArray);
            CommonUtil.arrayCopy(this.saleItemBeansArray, _arg_1.saleItemBeansArray);
            CommonUtil.arrayCopy(this.saleTypeBeansArray, _arg_1.saleTypeBeansArray);
            CommonUtil.arrayCopy(this.selfArmysArray, _arg_1.selfArmysArray);
            CommonUtil.arrayCopy(this.setshowinfroArray, _arg_1.setshowinfroArray);
            CommonUtil.arrayCopy(this.troopConfigBeansArray, _arg_1.troopConfigBeansArray);
        }

        public function set furloughDay(_arg_1:int):void
        {
            var _local_2:Object = this._1887518356furloughDay;
            if (_local_2 !== _arg_1)
            {
                this._1887518356furloughDay = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "furloughDay", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get autoFurlough():Boolean
        {
            return (this._1329771231autoFurlough);
        }

        [Bindable(event="propertyChange")]
        public function get newReportCount_army():int
        {
            return (this._2041542881newReportCount_army);
        }

        [Bindable(event="propertyChange")]
        public function get packageBeanArray():ArrayCollection
        {
            return (this._117401885packageBeanArray);
        }

        public function set gameSpeed(_arg_1:int):void
        {
            var _local_2:Object = this._989948789gameSpeed;
            if (_local_2 !== _arg_1)
            {
                this._989948789gameSpeed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gameSpeed", _local_2, _arg_1));
            };
        }

        public function set itemsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1425640839itemsArray;
            if (_local_2 !== _arg_1)
            {
                this._1425640839itemsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemsArray", _local_2, _arg_1));
            };
        }

        public function set newReportCount(_arg_1:int):void
        {
            var _local_2:Object = this._230483579newReportCount;
            if (_local_2 !== _arg_1)
            {
                this._230483579newReportCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount", _local_2, _arg_1));
            };
        }

        public function set mapSizeY(_arg_1:int):void
        {
            var _local_2:Object = this._167675004mapSizeY;
            if (_local_2 !== _arg_1)
            {
                this._167675004mapSizeY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapSizeY", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get redCount():int
        {
            return (this._811312386redCount);
        }

        public function set gemstoneinposArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._874955648gemstoneinposArray;
            if (_local_2 !== _arg_1)
            {
                this._874955648gemstoneinposArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gemstoneinposArray", _local_2, _arg_1));
            };
        }

        public function setFriendBeans(_arg_1:PlayerInfoBean, _arg_2:int):void
        {
            this.friendBeansArray[_arg_2] = _arg_1;
        }

        public function set mapSizeX(_arg_1:int):void
        {
            var _local_2:Object = this._167675003mapSizeX;
            if (_local_2 !== _arg_1)
            {
                this._167675003mapSizeX = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapSizeX", _local_2, _arg_1));
            };
        }

        public function set returnReport(_arg_1:Boolean):void
        {
            var _local_2:Object = this._784915076returnReport;
            if (_local_2 !== _arg_1)
            {
                this._784915076returnReport = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "returnReport", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get saleItemBeansArray():ArrayCollection
        {
            return (this._1102495504saleItemBeansArray);
        }

        public function setGemstoneinpos(_arg_1:GemStoneInPosBean, _arg_2:int):void
        {
            this.gemstoneinposArray[_arg_2] = _arg_1;
        }

        public function getCastleSignBean(_arg_1:int):CastleSignInfoBean
        {
            return (this.castleSignBeanArray[_arg_1] as CastleSignInfoBean);
        }

        public function set friendBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1918704276friendBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._1918704276friendBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendBeansArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get enemyArmysArray():ArrayCollection
        {
            return (this._1378032427enemyArmysArray);
        }

        [Bindable(event="propertyChange")]
        public function get changedFace():Boolean
        {
            return (this._1651231951changedFace);
        }

        public function getSaleItemBeans(_arg_1:int):SaleItemBean
        {
            return (this.saleItemBeansArray[_arg_1] as SaleItemBean);
        }

        public function setCastleSignBean(_arg_1:CastleSignInfoBean, _arg_2:int):void
        {
            this.castleSignBeanArray[_arg_2] = _arg_1;
        }

        public function set isEvonyMember(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2054170777isEvonyMember;
            if (_local_2 !== _arg_1)
            {
                this._2054170777isEvonyMember = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isEvonyMember", _local_2, _arg_1));
            };
        }

        public function set gamblingItemIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1484814694gamblingItemIndex;
            if (_local_2 !== _arg_1)
            {
                this._1484814694gamblingItemIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gamblingItemIndex", _local_2, _arg_1));
            };
        }

        public function set castlesArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._902435682castlesArray;
            if (_local_2 !== _arg_1)
            {
                this._902435682castlesArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castlesArray", _local_2, _arg_1));
            };
        }

        public function setBuffs(_arg_1:BuffBean, _arg_2:int):void
        {
            this.buffsArray[_arg_2] = _arg_1;
        }

        public function getFriendArmys(_arg_1:int):ArmyBean
        {
            return (this.friendArmysArray[_arg_1] as ArmyBean);
        }

        [Bindable(event="propertyChange")]
        public function get castleSignBeanArray():ArrayCollection
        {
            return (this._675024588castleSignBeanArray);
        }

        public function set digiId(_arg_1:String):void
        {
            var _local_2:Object = this._1331910750digiId;
            if (_local_2 !== _arg_1)
            {
                this._1331910750digiId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "digiId", _local_2, _arg_1));
            };
        }

        public function setRandomEvents(_arg_1:RandomEventBean, _arg_2:int):void
        {
            this.randomEventsArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get freshMan():Boolean
        {
            return (this._1524843188freshMan);
        }

        public function set newMaileCount_inbox(_arg_1:int):void
        {
            var _local_2:Object = this._2026418520newMaileCount_inbox;
            if (_local_2 !== _arg_1)
            {
                this._2026418520newMaileCount_inbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newMaileCount_inbox", _local_2, _arg_1));
            };
        }

        public function getSetshowinfro(_arg_1:int):SetShowInfro
        {
            return (this.setshowinfroArray[_arg_1] as SetShowInfro);
        }

        public function set newReportCount_trade(_arg_1:int):void
        {
            var _local_2:Object = this._1119145312newReportCount_trade;
            if (_local_2 !== _arg_1)
            {
                this._1119145312newReportCount_trade = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount_trade", _local_2, _arg_1));
            };
        }

        public function setPackageBean(_arg_1:PackageBean, _arg_2:int):void
        {
            this.packageBeanArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get finishedQuestCount():int
        {
            return (this._1432206175finishedQuestCount);
        }

        public function set disconnectvotes(_arg_1:Number):void
        {
            var _local_2:Object = this._1440789421disconnectvotes;
            if (_local_2 !== _arg_1)
            {
                this._1440789421disconnectvotes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "disconnectvotes", _local_2, _arg_1));
            };
        }

        public function set troopConfigBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._196779434troopConfigBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._196779434troopConfigBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopConfigBeansArray", _local_2, _arg_1));
            };
        }

        public function getTroopConfigBeans(_arg_1:int):TroopConfigBean
        {
            return (this.troopConfigBeansArray[_arg_1] as TroopConfigBean);
        }

        public function set equipmentsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1503909044equipmentsArray;
            if (_local_2 !== _arg_1)
            {
                this._1503909044equipmentsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipmentsArray", _local_2, _arg_1));
            };
        }

        public function getSaleTypeBeans(_arg_1:int):SaleTypeBean
        {
            return (this.saleTypeBeansArray[_arg_1] as SaleTypeBean);
        }

        public function set emailAddress(_arg_1:String):void
        {
            var _local_2:Object = this._1070931784emailAddress;
            if (_local_2 !== _arg_1)
            {
                this._1070931784emailAddress = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "emailAddress", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        public function get furloughDay():int
        {
            return (this._1887518356furloughDay);
        }

        public function set setshowinfroArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1970419386setshowinfroArray;
            if (_local_2 !== _arg_1)
            {
                this._1970419386setshowinfroArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "setshowinfroArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get gameSpeed():int
        {
            return (this._989948789gameSpeed);
        }

        [Bindable(event="propertyChange")]
        public function get gemstoneinposArray():ArrayCollection
        {
            return (this._874955648gemstoneinposArray);
        }

        public function set friendArmysArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._704639681friendArmysArray;
            if (_local_2 !== _arg_1)
            {
                this._704639681friendArmysArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendArmysArray", _local_2, _arg_1));
            };
        }

        public function set blockBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1461815869blockBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._1461815869blockBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "blockBeansArray", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set isReceiveIncomingAttack(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2100063033isReceiveIncomingAttack;
            if (_local_2 !== _arg_1)
            {
                this._2100063033isReceiveIncomingAttack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isReceiveIncomingAttack", _local_2, _arg_1));
            };
        }

        public function getFriendBeans(_arg_1:int):PlayerInfoBean
        {
            return (this.friendBeansArray[_arg_1] as PlayerInfoBean);
        }

        public function setDeclaredWarBeans(_arg_1:PlayerDeclaredWarBean, _arg_2:int):void
        {
            this.declaredWarBeansArray[_arg_2] = _arg_1;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.changedFace = this.changedFace;
            _local_1.currentDateTime = this.currentDateTime;
            _local_1.currentTime = this.currentTime;
            _local_1.digiId = this.digiId;
            _local_1.disconnectvotes = this.disconnectvotes;
            _local_1.effortPoint = this.effortPoint;
            _local_1.emailAddress = this.emailAddress;
            _local_1.finishedQuestCount = this.finishedQuestCount;
            _local_1.freshMan = this.freshMan;
            _local_1.furloughDay = this.furloughDay;
            _local_1.gamblingItemIndex = this.gamblingItemIndex;
            _local_1.gameSpeed = this.gameSpeed;
            _local_1.headline = this.headline;
            _local_1.isEvonyMember = this.isEvonyMember;
            _local_1.isReceiveIncomingAttack = this.isReceiveIncomingAttack;
            _local_1.isSetSecurityCode = this.isSetSecurityCode;
            _local_1.mapSizeX = this.mapSizeX;
            _local_1.mapSizeY = this.mapSizeY;
            _local_1.newMailCount = this.newMailCount;
            _local_1.newMaileCount_inbox = this.newMaileCount_inbox;
            _local_1.newMaileCount_system = this.newMaileCount_system;
            _local_1.newReportCount = this.newReportCount;
            _local_1.newReportCount_army = this.newReportCount_army;
            _local_1.newReportCount_other = this.newReportCount_other;
            _local_1.newReportCount_scout = this.newReportCount_scout;
            _local_1.newReportCount_trade = this.newReportCount_trade;
            _local_1.playerInfo = this.playerInfo.toObject();
            _local_1.redCount = this.redCount;
            _local_1.tutorialStepId = this.tutorialStepId;
            _local_1.autoFurlough = this.autoFurlough;
            _local_1.autoHeal = this.autoHeal;
            _local_1.furlough = this.furlough;
            _local_1.returnReport = this.returnReport;
            return (_local_1);
        }

        public function setSaleItemBeans(_arg_1:SaleItemBean, _arg_2:int):void
        {
            this.saleItemBeansArray[_arg_2] = _arg_1;
        }

        public function set headline(_arg_1:String):void
        {
            var _local_2:Object = this._1115058732headline;
            if (_local_2 !== _arg_1)
            {
                this._1115058732headline = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "headline", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get digiId():String
        {
            return (this._1331910750digiId);
        }

        [Bindable(event="propertyChange")]
        public function get troopConfigBeansArray():ArrayCollection
        {
            return (this._196779434troopConfigBeansArray);
        }

        [Bindable(event="propertyChange")]
        public function get disconnectvotes():Number
        {
            return (this._1440789421disconnectvotes);
        }

        public function set newMailCount(_arg_1:int):void
        {
            var _local_2:Object = this._29843496newMailCount;
            if (_local_2 !== _arg_1)
            {
                this._29843496newMailCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newMailCount", _local_2, _arg_1));
            };
        }

        public function setCastles(_arg_1:CastleBean, _arg_2:int):void
        {
            this.castlesArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get buffsArray():ArrayCollection
        {
            return (this._2032248903buffsArray);
        }

        public function set newReportCount_army(_arg_1:int):void
        {
            var _local_2:Object = this._2041542881newReportCount_army;
            if (_local_2 !== _arg_1)
            {
                this._2041542881newReportCount_army = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount_army", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get blockBeansArray():ArrayCollection
        {
            return (this._1461815869blockBeansArray);
        }

        public function getEnemyArmys(_arg_1:int):ArmyBean
        {
            return (this.enemyArmysArray[_arg_1] as ArmyBean);
        }

        public function set autoFurlough(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1329771231autoFurlough;
            if (_local_2 !== _arg_1)
            {
                this._1329771231autoFurlough = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoFurlough", _local_2, _arg_1));
            };
        }

        public function set packageBeanArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._117401885packageBeanArray;
            if (_local_2 !== _arg_1)
            {
                this._117401885packageBeanArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "packageBeanArray", _local_2, _arg_1));
            };
        }

        public function set currentTime(_arg_1:Number):void
        {
            var _local_2:Object = this._601235430currentTime;
            if (_local_2 !== _arg_1)
            {
                this._601235430currentTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentTime", _local_2, _arg_1));
            };
        }

        public function getSelfArmys(_arg_1:int):ArmyBean
        {
            return (this.selfArmysArray[_arg_1] as ArmyBean);
        }

        public function setEnemyArmys(_arg_1:ArmyBean, _arg_2:int):void
        {
            this.enemyArmysArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get newMailCount():int
        {
            return (this._29843496newMailCount);
        }

        [Bindable(event="propertyChange")]
        public function get headline():String
        {
            return (this._1115058732headline);
        }

        public function setSaleTypeBeans(_arg_1:SaleTypeBean, _arg_2:int):void
        {
            this.saleTypeBeansArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get currentTime():Number
        {
            return (this._601235430currentTime);
        }

        public function getPackageBean(_arg_1:int):PackageBean
        {
            return (this.packageBeanArray[_arg_1] as PackageBean);
        }

        public function set selfArmysArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._859583983selfArmysArray;
            if (_local_2 !== _arg_1)
            {
                this._859583983selfArmysArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selfArmysArray", _local_2, _arg_1));
            };
        }

        public function set saleItemBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1102495504saleItemBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._1102495504saleItemBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saleItemBeansArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get selfArmysArray():ArrayCollection
        {
            return (this._859583983selfArmysArray);
        }

        public function set randomEventsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1981766659randomEventsArray;
            if (_local_2 !== _arg_1)
            {
                this._1981766659randomEventsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "randomEventsArray", _local_2, _arg_1));
            };
        }

        public function set redCount(_arg_1:int):void
        {
            var _local_2:Object = this._811312386redCount;
            if (_local_2 !== _arg_1)
            {
                this._811312386redCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "redCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get randomEventsArray():ArrayCollection
        {
            return (this._1981766659randomEventsArray);
        }


    }
}//package com.evony.common.beans

