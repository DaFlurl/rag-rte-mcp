// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.MapCastleBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class MapCastleBean implements IEventDispatcher 
    {

        private var _1682641376declaredWarStatus:int;
        private var _1695158553colonialStatus:int;
        private var _554436100relation:int;
        private var _99462250honor:int;
        private var _3575610type:int;
        private var _1207284347canColonize:Boolean;
        private var _1167077297colonialRelation:int;
        private var _1503629328furlough:Boolean;
        private var _3355id:int;
        private var _946919841declaredWarStartTime:Number;
        private var _422968703powerLevel:int;
        private var _848059479zoneName:String;
        private var _109281npc:Boolean;
        private var _1387001311suzerain:String;
        private var _266666762userName:String;
        private var _2131389939changeface:int;
        private var _114043281castleIcon:int;
        private var _738630737ownerPlayerId:int;
        private var _3373707name:String;
        private var _1299492445playerLogoUrl:String;
        private var _98100801canOccupy:Boolean;
        private var _1524843188freshMan:Boolean;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _138006258canScout:Boolean;
        private var _3145580flag:String;
        private var _549540504canLoot:Boolean;
        private var _109757585state:int;
        private var _35872819castleId:int;
        private var _1276224445prestige:int;
        private var _136649544canTrans:Boolean;
        private var _549739384canSend:Boolean;
        private var _1606140770allianceName:String;
        private var _244224418canDeclaredWar:Boolean;

        public function MapCastleBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.allianceName != null)
                {
                    this.allianceName = _arg_1.allianceName;
                };
                if (_arg_1.castleIcon != null)
                {
                    this.castleIcon = _arg_1.castleIcon;
                };
                if (_arg_1.castleId != null)
                {
                    this.castleId = _arg_1.castleId;
                };
                if (_arg_1.changeface != null)
                {
                    this.changeface = _arg_1.changeface;
                };
                if (_arg_1.colonialRelation != null)
                {
                    this.colonialRelation = _arg_1.colonialRelation;
                };
                if (_arg_1.colonialStatus != null)
                {
                    this.colonialStatus = _arg_1.colonialStatus;
                };
                if (_arg_1.declaredWarStartTime != null)
                {
                    this.declaredWarStartTime = _arg_1.declaredWarStartTime;
                };
                if (_arg_1.declaredWarStatus != null)
                {
                    this.declaredWarStatus = _arg_1.declaredWarStatus;
                };
                if (_arg_1.flag != null)
                {
                    this.flag = _arg_1.flag;
                };
                if (_arg_1.honor != null)
                {
                    this.honor = _arg_1.honor;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.ownerPlayerId != null)
                {
                    this.ownerPlayerId = _arg_1.ownerPlayerId;
                };
                if (_arg_1.playerLogoUrl != null)
                {
                    this.playerLogoUrl = _arg_1.playerLogoUrl;
                };
                if (_arg_1.powerLevel != null)
                {
                    this.powerLevel = _arg_1.powerLevel;
                };
                if (_arg_1.prestige != null)
                {
                    this.prestige = _arg_1.prestige;
                };
                if (_arg_1.relation != null)
                {
                    this.relation = _arg_1.relation;
                };
                if (_arg_1.state != null)
                {
                    this.state = _arg_1.state;
                };
                if (_arg_1.suzerain != null)
                {
                    this.suzerain = _arg_1.suzerain;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
                if (_arg_1.userName != null)
                {
                    this.userName = _arg_1.userName;
                };
                if (_arg_1.zoneName != null)
                {
                    this.zoneName = _arg_1.zoneName;
                };
                if (_arg_1.canColonize != null)
                {
                    this.canColonize = _arg_1.canColonize;
                };
                if (_arg_1.canDeclaredWar != null)
                {
                    this.canDeclaredWar = _arg_1.canDeclaredWar;
                };
                if (_arg_1.canLoot != null)
                {
                    this.canLoot = _arg_1.canLoot;
                };
                if (_arg_1.canOccupy != null)
                {
                    this.canOccupy = _arg_1.canOccupy;
                };
                if (_arg_1.canScout != null)
                {
                    this.canScout = _arg_1.canScout;
                };
                if (_arg_1.canSend != null)
                {
                    this.canSend = _arg_1.canSend;
                };
                if (_arg_1.canTrans != null)
                {
                    this.canTrans = _arg_1.canTrans;
                };
                if (_arg_1.freshMan != null)
                {
                    this.freshMan = _arg_1.freshMan;
                };
                if (_arg_1.furlough != null)
                {
                    this.furlough = _arg_1.furlough;
                };
                if (_arg_1.npc != null)
                {
                    this.npc = _arg_1.npc;
                };
            };
        }

        public function set canColonize(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1207284347canColonize;
            if (_local_2 !== _arg_1)
            {
                this._1207284347canColonize = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canColonize", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get canScout():Boolean
        {
            return (this._138006258canScout);
        }

        [Bindable(event="propertyChange")]
        public function get furlough():Boolean
        {
            return (this._1503629328furlough);
        }

        public function set changeface(_arg_1:int):void
        {
            var _local_2:Object = this._2131389939changeface;
            if (_local_2 !== _arg_1)
            {
                this._2131389939changeface = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changeface", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        [Bindable(event="propertyChange")]
        public function get suzerain():String
        {
            return (this._1387001311suzerain);
        }

        public function set castleIcon(_arg_1:int):void
        {
            var _local_2:Object = this._114043281castleIcon;
            if (_local_2 !== _arg_1)
            {
                this._114043281castleIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get changeface():int
        {
            return (this._2131389939changeface);
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

        public function set state(_arg_1:int):void
        {
            var _local_2:Object = this._109757585state;
            if (_local_2 !== _arg_1)
            {
                this._109757585state = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "state", _local_2, _arg_1));
            };
        }

        public function set canScout(_arg_1:Boolean):void
        {
            var _local_2:Object = this._138006258canScout;
            if (_local_2 !== _arg_1)
            {
                this._138006258canScout = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canScout", _local_2, _arg_1));
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

        public function set canLoot(_arg_1:Boolean):void
        {
            var _local_2:Object = this._549540504canLoot;
            if (_local_2 !== _arg_1)
            {
                this._549540504canLoot = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canLoot", _local_2, _arg_1));
            };
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

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get type():int
        {
            return (this._3575610type);
        }

        public function set declaredWarStartTime(_arg_1:Number):void
        {
            var _local_2:Object = this._946919841declaredWarStartTime;
            if (_local_2 !== _arg_1)
            {
                this._946919841declaredWarStartTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declaredWarStartTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get prestige():int
        {
            return (this._1276224445prestige);
        }

        public function set playerLogoUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1299492445playerLogoUrl;
            if (_local_2 !== _arg_1)
            {
                this._1299492445playerLogoUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerLogoUrl", _local_2, _arg_1));
            };
        }

        public function set suzerain(_arg_1:String):void
        {
            var _local_2:Object = this._1387001311suzerain;
            if (_local_2 !== _arg_1)
            {
                this._1387001311suzerain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "suzerain", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get castleId():int
        {
            return (this._35872819castleId);
        }

        [Bindable(event="propertyChange")]
        public function get freshMan():Boolean
        {
            return (this._1524843188freshMan);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get zoneName():String
        {
            return (this._848059479zoneName);
        }

        public function set ownerPlayerId(_arg_1:int):void
        {
            var _local_2:Object = this._738630737ownerPlayerId;
            if (_local_2 !== _arg_1)
            {
                this._738630737ownerPlayerId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ownerPlayerId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get canDeclaredWar():Boolean
        {
            return (this._244224418canDeclaredWar);
        }

        [Bindable(event="propertyChange")]
        public function get allianceName():String
        {
            return (this._1606140770allianceName);
        }

        [Bindable(event="propertyChange")]
        public function get honor():int
        {
            return (this._99462250honor);
        }

        [Bindable(event="propertyChange")]
        public function get flag():String
        {
            return (this._3145580flag);
        }

        public function set castleId(_arg_1:int):void
        {
            var _local_2:Object = this._35872819castleId;
            if (_local_2 !== _arg_1)
            {
                this._35872819castleId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleId", _local_2, _arg_1));
            };
        }

        public function set canTrans(_arg_1:Boolean):void
        {
            var _local_2:Object = this._136649544canTrans;
            if (_local_2 !== _arg_1)
            {
                this._136649544canTrans = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canTrans", _local_2, _arg_1));
            };
        }

        public function set colonialRelation(_arg_1:int):void
        {
            var _local_2:Object = this._1167077297colonialRelation;
            if (_local_2 !== _arg_1)
            {
                this._1167077297colonialRelation = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonialRelation", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get canSend():Boolean
        {
            return (this._549739384canSend);
        }

        public function set canOccupy(_arg_1:Boolean):void
        {
            var _local_2:Object = this._98100801canOccupy;
            if (_local_2 !== _arg_1)
            {
                this._98100801canOccupy = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canOccupy", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get powerLevel():int
        {
            return (this._422968703powerLevel);
        }

        public function set type(_arg_1:int):void
        {
            var _local_2:Object = this._3575610type;
            if (_local_2 !== _arg_1)
            {
                this._3575610type = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get canColonize():Boolean
        {
            return (this._1207284347canColonize);
        }

        public function set prestige(_arg_1:int):void
        {
            var _local_2:Object = this._1276224445prestige;
            if (_local_2 !== _arg_1)
            {
                this._1276224445prestige = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get castleIcon():int
        {
            return (this._114043281castleIcon);
        }

        [Bindable(event="propertyChange")]
        public function get state():int
        {
            return (this._109757585state);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.allianceName = this.allianceName;
            _local_1.castleIcon = this.castleIcon;
            _local_1.castleId = this.castleId;
            _local_1.changeface = this.changeface;
            _local_1.colonialRelation = this.colonialRelation;
            _local_1.colonialStatus = this.colonialStatus;
            _local_1.declaredWarStartTime = this.declaredWarStartTime;
            _local_1.declaredWarStatus = this.declaredWarStatus;
            _local_1.flag = this.flag;
            _local_1.honor = this.honor;
            _local_1.id = this.id;
            _local_1.name = this.name;
            _local_1.ownerPlayerId = this.ownerPlayerId;
            _local_1.playerLogoUrl = this.playerLogoUrl;
            _local_1.powerLevel = this.powerLevel;
            _local_1.prestige = this.prestige;
            _local_1.relation = this.relation;
            _local_1.state = this.state;
            _local_1.suzerain = this.suzerain;
            _local_1.type = this.type;
            _local_1.userName = this.userName;
            _local_1.zoneName = this.zoneName;
            _local_1.canColonize = this.canColonize;
            _local_1.canDeclaredWar = this.canDeclaredWar;
            _local_1.canLoot = this.canLoot;
            _local_1.canOccupy = this.canOccupy;
            _local_1.canScout = this.canScout;
            _local_1.canSend = this.canSend;
            _local_1.canTrans = this.canTrans;
            _local_1.freshMan = this.freshMan;
            _local_1.furlough = this.furlough;
            _local_1.npc = this.npc;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get canLoot():Boolean
        {
            return (this._549540504canLoot);
        }

        [Bindable(event="propertyChange")]
        public function get declaredWarStartTime():Number
        {
            return (this._946919841declaredWarStartTime);
        }

        [Bindable(event="propertyChange")]
        public function get playerLogoUrl():String
        {
            return (this._1299492445playerLogoUrl);
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

        public function set zoneName(_arg_1:String):void
        {
            var _local_2:Object = this._848059479zoneName;
            if (_local_2 !== _arg_1)
            {
                this._848059479zoneName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoneName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get ownerPlayerId():int
        {
            return (this._738630737ownerPlayerId);
        }

        [Bindable(event="propertyChange")]
        public function get colonialRelation():int
        {
            return (this._1167077297colonialRelation);
        }

        [Bindable(event="propertyChange")]
        public function get canTrans():Boolean
        {
            return (this._136649544canTrans);
        }

        public function set canDeclaredWar(_arg_1:Boolean):void
        {
            var _local_2:Object = this._244224418canDeclaredWar;
            if (_local_2 !== _arg_1)
            {
                this._244224418canDeclaredWar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canDeclaredWar", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get canOccupy():Boolean
        {
            return (this._98100801canOccupy);
        }

        public function set declaredWarStatus(_arg_1:int):void
        {
            var _local_2:Object = this._1682641376declaredWarStatus;
            if (_local_2 !== _arg_1)
            {
                this._1682641376declaredWarStatus = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declaredWarStatus", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "allianceName = ") + this.allianceName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "castleIcon = ") + this.castleIcon) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "changeface = ") + this.changeface) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "colonialRelation = ") + this.colonialRelation) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "colonialStatus = ") + this.colonialStatus) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "declaredWarStartTime = ") + this.declaredWarStartTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "declaredWarStatus = ") + this.declaredWarStatus) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "flag = ") + this.flag) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "honor = ") + this.honor) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ownerPlayerId = ") + this.ownerPlayerId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "playerLogoUrl = ") + this.playerLogoUrl) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "powerLevel = ") + this.powerLevel) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "prestige = ") + this.prestige) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "relation = ") + this.relation) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "state = ") + this.state) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "suzerain = ") + this.suzerain) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "type = ") + this.type) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "userName = ") + this.userName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "zoneName = ") + this.zoneName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canColonize = ") + this.canColonize) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canDeclaredWar = ") + this.canDeclaredWar) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canLoot = ") + this.canLoot) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canOccupy = ") + this.canOccupy) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canScout = ") + this.canScout) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canSend = ") + this.canSend) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "canTrans = ") + this.canTrans) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "freshMan = ") + this.freshMan) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "furlough = ") + this.furlough) + "\n"));
            return (_local_2 + (((_arg_1 + "npc = ") + this.npc) + "\n"));
        }

        public function set allianceName(_arg_1:String):void
        {
            var _local_2:Object = this._1606140770allianceName;
            if (_local_2 !== _arg_1)
            {
                this._1606140770allianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceName", _local_2, _arg_1));
            };
        }

        public function set colonialStatus(_arg_1:int):void
        {
            var _local_2:Object = this._1695158553colonialStatus;
            if (_local_2 !== _arg_1)
            {
                this._1695158553colonialStatus = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonialStatus", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:MapCastleBean):void
        {
            _arg_1.allianceName = this.allianceName;
            _arg_1.castleIcon = this.castleIcon;
            _arg_1.castleId = this.castleId;
            _arg_1.changeface = this.changeface;
            _arg_1.colonialRelation = this.colonialRelation;
            _arg_1.colonialStatus = this.colonialStatus;
            _arg_1.declaredWarStartTime = this.declaredWarStartTime;
            _arg_1.declaredWarStatus = this.declaredWarStatus;
            _arg_1.flag = this.flag;
            _arg_1.honor = this.honor;
            _arg_1.id = this.id;
            _arg_1.name = this.name;
            _arg_1.ownerPlayerId = this.ownerPlayerId;
            _arg_1.playerLogoUrl = this.playerLogoUrl;
            _arg_1.powerLevel = this.powerLevel;
            _arg_1.prestige = this.prestige;
            _arg_1.relation = this.relation;
            _arg_1.state = this.state;
            _arg_1.suzerain = this.suzerain;
            _arg_1.type = this.type;
            _arg_1.userName = this.userName;
            _arg_1.zoneName = this.zoneName;
            _arg_1.canColonize = this.canColonize;
            _arg_1.canDeclaredWar = this.canDeclaredWar;
            _arg_1.canLoot = this.canLoot;
            _arg_1.canOccupy = this.canOccupy;
            _arg_1.canScout = this.canScout;
            _arg_1.canSend = this.canSend;
            _arg_1.canTrans = this.canTrans;
            _arg_1.freshMan = this.freshMan;
            _arg_1.furlough = this.furlough;
            _arg_1.npc = this.npc;
        }

        public function set npc(_arg_1:Boolean):void
        {
            var _local_2:Object = this._109281npc;
            if (_local_2 !== _arg_1)
            {
                this._109281npc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npc", _local_2, _arg_1));
            };
        }

        public function set honor(_arg_1:int):void
        {
            var _local_2:Object = this._99462250honor;
            if (_local_2 !== _arg_1)
            {
                this._99462250honor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "honor", _local_2, _arg_1));
            };
        }

        public function set flag(_arg_1:String):void
        {
            var _local_2:Object = this._3145580flag;
            if (_local_2 !== _arg_1)
            {
                this._3145580flag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get declaredWarStatus():int
        {
            return (this._1682641376declaredWarStatus);
        }

        public function set userName(_arg_1:String):void
        {
            var _local_2:Object = this._266666762userName;
            if (_local_2 !== _arg_1)
            {
                this._266666762userName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonialStatus():int
        {
            return (this._1695158553colonialStatus);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set canSend(_arg_1:Boolean):void
        {
            var _local_2:Object = this._549739384canSend;
            if (_local_2 !== _arg_1)
            {
                this._549739384canSend = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canSend", _local_2, _arg_1));
            };
        }

        public function set relation(_arg_1:int):void
        {
            var _local_2:Object = this._554436100relation;
            if (_local_2 !== _arg_1)
            {
                this._554436100relation = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "relation", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get npc():Boolean
        {
            return (this._109281npc);
        }

        [Bindable(event="propertyChange")]
        public function get relation():int
        {
            return (this._554436100relation);
        }

        [Bindable(event="propertyChange")]
        public function get userName():String
        {
            return (this._266666762userName);
        }

        public function set powerLevel(_arg_1:int):void
        {
            var _local_2:Object = this._422968703powerLevel;
            if (_local_2 !== _arg_1)
            {
                this._422968703powerLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "powerLevel", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

