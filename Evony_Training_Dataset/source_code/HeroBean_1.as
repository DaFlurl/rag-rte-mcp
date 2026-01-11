// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.HeroBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import mx.collections.ArrayCollection;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.CommonUtil;
    import com.evony.common.paramBeans.*;

    public class HeroBean implements IEventDispatcher 
    {

        private var _412944526stratagem:int;
        private var _85567126experience:Number;
        private var _358728774loyalty:int;
        private var _1266164532fieldtype:int;
        private var _100348382infro:String;
        private var _1544916048defence:int;
        private var _1799980989management:int;
        private var _761536362managementBuffAdded:int;
        private var _547400545politics:Number;
        private var _109641799speed:int;
        private var _1068386166morale:int;
        private var _106858757power:int;
        private var _1200507606ability:int;
        private var _814364440powerBuffAdded:int;
        private var _3355id:int;
        private var _113766sex:Boolean;
        private var _1039282375npc_id:int;
        private var _958110004facebook_id:String;
        private var _1456811858stratagemAdded:int;
        private var _342500292logoUrl:String;
        private var _2032248903buffsArray:ArrayCollection = new ArrayCollection();
        private var _1627044220remainPoint:int;
        private var _471353915maxStrength:int;
        private var _510568485fbFriendName:String;
        private var _797998783intelligence:Number;
        private var _814903611leadershipAdded:int;
        private var _892481550status:int;
        private var _3373707name:String;
        private var _1691501851stratagemBuffAdded:int;
        private var _102865796level:int;
        private var _682371709managementAdded:int;
        private var _1999179167upgradeExp:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1180455868isHero:int;
        private var _412762875powerAdded:int;
        private var _1192391365leadership:int;
        private var _1897344401stamina:int;
        private var _1178662002itemId:String;
        private var _1407259064attack:Number;
        private var _1478417739itemAmount:int;
        private var _1217743173equipmentbeanArray:ArrayCollection = new ArrayCollection();

        public function HeroBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:BuffBean;
            var _local_4:EquipmentBean;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.ability != null)
                {
                    this.ability = _arg_1.ability;
                };
                if (_arg_1.attack != null)
                {
                    this.attack = _arg_1.attack;
                };
                if (_arg_1.defence != null)
                {
                    this.defence = _arg_1.defence;
                };
                if (_arg_1.experience != null)
                {
                    this.experience = _arg_1.experience;
                };
                if (_arg_1.facebook_id != null)
                {
                    this.facebook_id = _arg_1.facebook_id;
                };
                if (_arg_1.fbFriendName != null)
                {
                    this.fbFriendName = _arg_1.fbFriendName;
                };
                if (_arg_1.fieldtype != null)
                {
                    this.fieldtype = _arg_1.fieldtype;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.infro != null)
                {
                    this.infro = _arg_1.infro;
                };
                if (_arg_1.intelligence != null)
                {
                    this.intelligence = _arg_1.intelligence;
                };
                if (_arg_1.isHero != null)
                {
                    this.isHero = _arg_1.isHero;
                };
                if (_arg_1.itemAmount != null)
                {
                    this.itemAmount = _arg_1.itemAmount;
                };
                if (_arg_1.itemId != null)
                {
                    this.itemId = _arg_1.itemId;
                };
                if (_arg_1.leadership != null)
                {
                    this.leadership = _arg_1.leadership;
                };
                if (_arg_1.leadershipAdded != null)
                {
                    this.leadershipAdded = _arg_1.leadershipAdded;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.logoUrl != null)
                {
                    this.logoUrl = _arg_1.logoUrl;
                };
                if (_arg_1.loyalty != null)
                {
                    this.loyalty = _arg_1.loyalty;
                };
                if (_arg_1.management != null)
                {
                    this.management = _arg_1.management;
                };
                if (_arg_1.managementAdded != null)
                {
                    this.managementAdded = _arg_1.managementAdded;
                };
                if (_arg_1.managementBuffAdded != null)
                {
                    this.managementBuffAdded = _arg_1.managementBuffAdded;
                };
                if (_arg_1.maxStrength != null)
                {
                    this.maxStrength = _arg_1.maxStrength;
                };
                if (_arg_1.morale != null)
                {
                    this.morale = _arg_1.morale;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.npc_id != null)
                {
                    this.npc_id = _arg_1.npc_id;
                };
                if (_arg_1.politics != null)
                {
                    this.politics = _arg_1.politics;
                };
                if (_arg_1.power != null)
                {
                    this.power = _arg_1.power;
                };
                if (_arg_1.powerAdded != null)
                {
                    this.powerAdded = _arg_1.powerAdded;
                };
                if (_arg_1.powerBuffAdded != null)
                {
                    this.powerBuffAdded = _arg_1.powerBuffAdded;
                };
                if (_arg_1.remainPoint != null)
                {
                    this.remainPoint = _arg_1.remainPoint;
                };
                if (_arg_1.speed != null)
                {
                    this.speed = _arg_1.speed;
                };
                if (_arg_1.stamina != null)
                {
                    this.stamina = _arg_1.stamina;
                };
                if (_arg_1.status != null)
                {
                    this.status = _arg_1.status;
                };
                if (_arg_1.stratagem != null)
                {
                    this.stratagem = _arg_1.stratagem;
                };
                if (_arg_1.stratagemAdded != null)
                {
                    this.stratagemAdded = _arg_1.stratagemAdded;
                };
                if (_arg_1.stratagemBuffAdded != null)
                {
                    this.stratagemBuffAdded = _arg_1.stratagemBuffAdded;
                };
                if (_arg_1.upgradeExp != null)
                {
                    this.upgradeExp = _arg_1.upgradeExp;
                };
                if (_arg_1.sex != null)
                {
                    this.sex = _arg_1.sex;
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
                if (_arg_1.equipmentbean)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.equipmentbean.length)
                    {
                        _local_4 = new EquipmentBean(_arg_1.equipmentbean[_local_2]);
                        this.equipmentbeanArray.addItem(_local_4);
                        _local_2++;
                    };
                };
            };
        }

        public function set level(_arg_1:int):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get power():int
        {
            return (this._106858757power);
        }

        public function set morale(_arg_1:int):void
        {
            var _local_2:Object = this._1068386166morale;
            if (_local_2 !== _arg_1)
            {
                this._1068386166morale = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "morale", _local_2, _arg_1));
            };
        }

        public function set power(_arg_1:int):void
        {
            var _local_2:Object = this._106858757power;
            if (_local_2 !== _arg_1)
            {
                this._106858757power = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "power", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
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
        public function get fbFriendName():String
        {
            return (this._510568485fbFriendName);
        }

        public function set itemId(_arg_1:String):void
        {
            var _local_2:Object = this._1178662002itemId;
            if (_local_2 !== _arg_1)
            {
                this._1178662002itemId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get facebook_id():String
        {
            return (this._958110004facebook_id);
        }

        public function set remainPoint(_arg_1:int):void
        {
            var _local_2:Object = this._1627044220remainPoint;
            if (_local_2 !== _arg_1)
            {
                this._1627044220remainPoint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainPoint", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        public function get stratagemBuffAdded():int
        {
            return (this._1691501851stratagemBuffAdded);
        }

        public function setBuffs(_arg_1:BuffBean, _arg_2:int):void
        {
            this.buffsArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get fieldtype():int
        {
            return (this._1266164532fieldtype);
        }

        [Bindable(event="propertyChange")]
        public function get isHero():int
        {
            return (this._1180455868isHero);
        }

        public function set stratagemBuffAdded(_arg_1:int):void
        {
            var _local_2:Object = this._1691501851stratagemBuffAdded;
            if (_local_2 !== _arg_1)
            {
                this._1691501851stratagemBuffAdded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagemBuffAdded", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get speed():int
        {
            return (this._109641799speed);
        }

        [Bindable(event="propertyChange")]
        public function get attack():Number
        {
            return (this._1407259064attack);
        }

        public function set fbFriendName(_arg_1:String):void
        {
            var _local_2:Object = this._510568485fbFriendName;
            if (_local_2 !== _arg_1)
            {
                this._510568485fbFriendName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fbFriendName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemAmount():int
        {
            return (this._1478417739itemAmount);
        }

        [Bindable(event="propertyChange")]
        public function get ability():int
        {
            return (this._1200507606ability);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get npc_id():int
        {
            return (this._1039282375npc_id);
        }

        [Bindable(event="propertyChange")]
        public function get management():int
        {
            return (this._1799980989management);
        }

        [Bindable(event="propertyChange")]
        public function get loyalty():int
        {
            return (this._358728774loyalty);
        }

        [Bindable(event="propertyChange")]
        public function get defence():int
        {
            return (this._1544916048defence);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set ability(_arg_1:int):void
        {
            var _local_2:Object = this._1200507606ability;
            if (_local_2 !== _arg_1)
            {
                this._1200507606ability = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ability", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get politics():Number
        {
            return (this._547400545politics);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set fieldtype(_arg_1:int):void
        {
            var _local_2:Object = this._1266164532fieldtype;
            if (_local_2 !== _arg_1)
            {
                this._1266164532fieldtype = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldtype", _local_2, _arg_1));
            };
        }

        public function set stratagemAdded(_arg_1:int):void
        {
            var _local_2:Object = this._1456811858stratagemAdded;
            if (_local_2 !== _arg_1)
            {
                this._1456811858stratagemAdded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagemAdded", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sex():Boolean
        {
            return (this._113766sex);
        }

        public function set facebook_id(_arg_1:String):void
        {
            var _local_2:Object = this._958110004facebook_id;
            if (_local_2 !== _arg_1)
            {
                this._958110004facebook_id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebook_id", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get upgradeExp():int
        {
            return (this._1999179167upgradeExp);
        }

        [Bindable(event="propertyChange")]
        public function get experience():Number
        {
            return (this._85567126experience);
        }

        [Bindable(event="propertyChange")]
        public function get managementBuffAdded():int
        {
            return (this._761536362managementBuffAdded);
        }

        [Bindable(event="propertyChange")]
        public function get leadershipAdded():int
        {
            return (this._814903611leadershipAdded);
        }

        public function set management(_arg_1:int):void
        {
            var _local_2:Object = this._1799980989management;
            if (_local_2 !== _arg_1)
            {
                this._1799980989management = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "management", _local_2, _arg_1));
            };
        }

        public function getEquipmentbean(_arg_1:int):EquipmentBean
        {
            return (this.equipmentbeanArray[_arg_1] as EquipmentBean);
        }

        public function set leadership(_arg_1:int):void
        {
            var _local_2:Object = this._1192391365leadership;
            if (_local_2 !== _arg_1)
            {
                this._1192391365leadership = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leadership", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
        }

        public function set loyalty(_arg_1:int):void
        {
            var _local_2:Object = this._358728774loyalty;
            if (_local_2 !== _arg_1)
            {
                this._358728774loyalty = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loyalty", _local_2, _arg_1));
            };
        }

        public function set intelligence(_arg_1:Number):void
        {
            var _local_2:Object = this._797998783intelligence;
            if (_local_2 !== _arg_1)
            {
                this._797998783intelligence = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "intelligence", _local_2, _arg_1));
            };
        }

        public function set isHero(_arg_1:int):void
        {
            var _local_2:Object = this._1180455868isHero;
            if (_local_2 !== _arg_1)
            {
                this._1180455868isHero = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isHero", _local_2, _arg_1));
            };
        }

        public function set attack(_arg_1:Number):void
        {
            var _local_2:Object = this._1407259064attack;
            if (_local_2 !== _arg_1)
            {
                this._1407259064attack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attack", _local_2, _arg_1));
            };
        }

        public function set maxStrength(_arg_1:int):void
        {
            var _local_2:Object = this._471353915maxStrength;
            if (_local_2 !== _arg_1)
            {
                this._471353915maxStrength = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxStrength", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        [Bindable(event="propertyChange")]
        public function get remainPoint():int
        {
            return (this._1627044220remainPoint);
        }

        public function set npc_id(_arg_1:int):void
        {
            var _local_2:Object = this._1039282375npc_id;
            if (_local_2 !== _arg_1)
            {
                this._1039282375npc_id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npc_id", _local_2, _arg_1));
            };
        }

        public function set itemAmount(_arg_1:int):void
        {
            var _local_2:Object = this._1478417739itemAmount;
            if (_local_2 !== _arg_1)
            {
                this._1478417739itemAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemAmount", _local_2, _arg_1));
            };
        }

        public function set logoUrl(_arg_1:String):void
        {
            var _local_2:Object = this._342500292logoUrl;
            if (_local_2 !== _arg_1)
            {
                this._342500292logoUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logoUrl", _local_2, _arg_1));
            };
        }

        public function set leadershipAdded(_arg_1:int):void
        {
            var _local_2:Object = this._814903611leadershipAdded;
            if (_local_2 !== _arg_1)
            {
                this._814903611leadershipAdded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leadershipAdded", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get morale():int
        {
            return (this._1068386166morale);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.ability = this.ability;
            _local_1.attack = this.attack;
            _local_1.defence = this.defence;
            _local_1.experience = this.experience;
            _local_1.facebook_id = this.facebook_id;
            _local_1.fbFriendName = this.fbFriendName;
            _local_1.fieldtype = this.fieldtype;
            _local_1.id = this.id;
            _local_1.infro = this.infro;
            _local_1.intelligence = this.intelligence;
            _local_1.isHero = this.isHero;
            _local_1.itemAmount = this.itemAmount;
            _local_1.itemId = this.itemId;
            _local_1.leadership = this.leadership;
            _local_1.leadershipAdded = this.leadershipAdded;
            _local_1.level = this.level;
            _local_1.logoUrl = this.logoUrl;
            _local_1.loyalty = this.loyalty;
            _local_1.management = this.management;
            _local_1.managementAdded = this.managementAdded;
            _local_1.managementBuffAdded = this.managementBuffAdded;
            _local_1.maxStrength = this.maxStrength;
            _local_1.morale = this.morale;
            _local_1.name = this.name;
            _local_1.npc_id = this.npc_id;
            _local_1.politics = this.politics;
            _local_1.power = this.power;
            _local_1.powerAdded = this.powerAdded;
            _local_1.powerBuffAdded = this.powerBuffAdded;
            _local_1.remainPoint = this.remainPoint;
            _local_1.speed = this.speed;
            _local_1.stamina = this.stamina;
            _local_1.status = this.status;
            _local_1.stratagem = this.stratagem;
            _local_1.stratagemAdded = this.stratagemAdded;
            _local_1.stratagemBuffAdded = this.stratagemBuffAdded;
            _local_1.upgradeExp = this.upgradeExp;
            _local_1.sex = this.sex;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get itemId():String
        {
            return (this._1178662002itemId);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get managementAdded():int
        {
            return (this._682371709managementAdded);
        }

        public function set defence(_arg_1:int):void
        {
            var _local_2:Object = this._1544916048defence;
            if (_local_2 !== _arg_1)
            {
                this._1544916048defence = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "defence", _local_2, _arg_1));
            };
        }

        public function set equipmentbeanArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1217743173equipmentbeanArray;
            if (_local_2 !== _arg_1)
            {
                this._1217743173equipmentbeanArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipmentbeanArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stratagem():int
        {
            return (this._412944526stratagem);
        }

        [Bindable(event="propertyChange")]
        public function get stratagemAdded():int
        {
            return (this._1456811858stratagemAdded);
        }

        public function set speed(_arg_1:int):void
        {
            var _local_2:Object = this._109641799speed;
            if (_local_2 !== _arg_1)
            {
                this._109641799speed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "speed", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stamina():int
        {
            return (this._1897344401stamina);
        }

        [Bindable(event="propertyChange")]
        public function get equipmentbeanArray():ArrayCollection
        {
            return (this._1217743173equipmentbeanArray);
        }

        public function set infro(_arg_1:String):void
        {
            var _local_2:Object = this._100348382infro;
            if (_local_2 !== _arg_1)
            {
                this._100348382infro = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infro", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get intelligence():Number
        {
            return (this._797998783intelligence);
        }

        [Bindable(event="propertyChange")]
        public function get buffsArray():ArrayCollection
        {
            return (this._2032248903buffsArray);
        }

        [Bindable(event="propertyChange")]
        public function get logoUrl():String
        {
            return (this._342500292logoUrl);
        }

        [Bindable(event="propertyChange")]
        public function get leadership():int
        {
            return (this._1192391365leadership);
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

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "ability = ") + this.ability) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "attack = ") + this.attack) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "defence = ") + this.defence) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "experience = ") + this.experience) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "facebook_id = ") + this.facebook_id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "fbFriendName = ") + this.fbFriendName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "fieldtype = ") + this.fieldtype) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "infro = ") + this.infro) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "intelligence = ") + this.intelligence) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isHero = ") + this.isHero) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "itemAmount = ") + this.itemAmount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "itemId = ") + this.itemId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "leadership = ") + this.leadership) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "leadershipAdded = ") + this.leadershipAdded) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "logoUrl = ") + this.logoUrl) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "loyalty = ") + this.loyalty) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "management = ") + this.management) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "managementAdded = ") + this.managementAdded) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "managementBuffAdded = ") + this.managementBuffAdded) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "maxStrength = ") + this.maxStrength) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "morale = ") + this.morale) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "npc_id = ") + this.npc_id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "politics = ") + this.politics) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "power = ") + this.power) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "powerAdded = ") + this.powerAdded) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "powerBuffAdded = ") + this.powerBuffAdded) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "remainPoint = ") + this.remainPoint) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "speed = ") + this.speed) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stamina = ") + this.stamina) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stratagem = ") + this.stratagem) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stratagemAdded = ") + this.stratagemAdded) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stratagemBuffAdded = ") + this.stratagemBuffAdded) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "upgradeExp = ") + this.upgradeExp) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "sex = ") + this.sex) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.buffsArray.length)
            {
                _local_2 = (_local_2 + this.getBuffs(_local_3).toDebugString((((_arg_1 + "buffs[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.equipmentbeanArray.length)
            {
                _local_2 = (_local_2 + this.getEquipmentbean(_local_3).toDebugString((((_arg_1 + "equipmentbean[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getBuffs(_arg_1:int):BuffBean
        {
            return (this.buffsArray[_arg_1] as BuffBean);
        }

        [Bindable(event="propertyChange")]
        public function get maxStrength():int
        {
            return (this._471353915maxStrength);
        }

        public function copyTo(_arg_1:HeroBean):void
        {
            _arg_1.ability = this.ability;
            _arg_1.attack = this.attack;
            _arg_1.defence = this.defence;
            _arg_1.experience = this.experience;
            _arg_1.facebook_id = this.facebook_id;
            _arg_1.fbFriendName = this.fbFriendName;
            _arg_1.fieldtype = this.fieldtype;
            _arg_1.id = this.id;
            _arg_1.infro = this.infro;
            _arg_1.intelligence = this.intelligence;
            _arg_1.isHero = this.isHero;
            _arg_1.itemAmount = this.itemAmount;
            _arg_1.itemId = this.itemId;
            _arg_1.leadership = this.leadership;
            _arg_1.leadershipAdded = this.leadershipAdded;
            _arg_1.level = this.level;
            _arg_1.logoUrl = this.logoUrl;
            _arg_1.loyalty = this.loyalty;
            _arg_1.management = this.management;
            _arg_1.managementAdded = this.managementAdded;
            _arg_1.managementBuffAdded = this.managementBuffAdded;
            _arg_1.maxStrength = this.maxStrength;
            _arg_1.morale = this.morale;
            _arg_1.name = this.name;
            _arg_1.npc_id = this.npc_id;
            _arg_1.politics = this.politics;
            _arg_1.power = this.power;
            _arg_1.powerAdded = this.powerAdded;
            _arg_1.powerBuffAdded = this.powerBuffAdded;
            _arg_1.remainPoint = this.remainPoint;
            _arg_1.speed = this.speed;
            _arg_1.stamina = this.stamina;
            _arg_1.status = this.status;
            _arg_1.stratagem = this.stratagem;
            _arg_1.stratagemAdded = this.stratagemAdded;
            _arg_1.stratagemBuffAdded = this.stratagemBuffAdded;
            _arg_1.upgradeExp = this.upgradeExp;
            _arg_1.sex = this.sex;
            CommonUtil.arrayCopy(this.buffsArray, _arg_1.buffsArray);
            CommonUtil.arrayCopy(this.equipmentbeanArray, _arg_1.equipmentbeanArray);
        }

        public function set politics(_arg_1:Number):void
        {
            var _local_2:Object = this._547400545politics;
            if (_local_2 !== _arg_1)
            {
                this._547400545politics = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "politics", _local_2, _arg_1));
            };
        }

        public function set sex(_arg_1:Boolean):void
        {
            var _local_2:Object = this._113766sex;
            if (_local_2 !== _arg_1)
            {
                this._113766sex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sex", _local_2, _arg_1));
            };
        }

        public function set experience(_arg_1:Number):void
        {
            var _local_2:Object = this._85567126experience;
            if (_local_2 !== _arg_1)
            {
                this._85567126experience = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "experience", _local_2, _arg_1));
            };
        }

        public function set powerBuffAdded(_arg_1:int):void
        {
            var _local_2:Object = this._814364440powerBuffAdded;
            if (_local_2 !== _arg_1)
            {
                this._814364440powerBuffAdded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "powerBuffAdded", _local_2, _arg_1));
            };
        }

        public function set upgradeExp(_arg_1:int):void
        {
            var _local_2:Object = this._1999179167upgradeExp;
            if (_local_2 !== _arg_1)
            {
                this._1999179167upgradeExp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "upgradeExp", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get infro():String
        {
            return (this._100348382infro);
        }

        [Bindable(event="propertyChange")]
        public function get powerBuffAdded():int
        {
            return (this._814364440powerBuffAdded);
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

        public function set managementBuffAdded(_arg_1:int):void
        {
            var _local_2:Object = this._761536362managementBuffAdded;
            if (_local_2 !== _arg_1)
            {
                this._761536362managementBuffAdded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "managementBuffAdded", _local_2, _arg_1));
            };
        }

        public function set stamina(_arg_1:int):void
        {
            var _local_2:Object = this._1897344401stamina;
            if (_local_2 !== _arg_1)
            {
                this._1897344401stamina = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stamina", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get status():int
        {
            return (this._892481550status);
        }

        public function set stratagem(_arg_1:int):void
        {
            var _local_2:Object = this._412944526stratagem;
            if (_local_2 !== _arg_1)
            {
                this._412944526stratagem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagem", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set powerAdded(_arg_1:int):void
        {
            var _local_2:Object = this._412762875powerAdded;
            if (_local_2 !== _arg_1)
            {
                this._412762875powerAdded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "powerAdded", _local_2, _arg_1));
            };
        }

        public function set managementAdded(_arg_1:int):void
        {
            var _local_2:Object = this._682371709managementAdded;
            if (_local_2 !== _arg_1)
            {
                this._682371709managementAdded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "managementAdded", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get powerAdded():int
        {
            return (this._412762875powerAdded);
        }

        public function setEquipmentbean(_arg_1:EquipmentBean, _arg_2:int):void
        {
            this.equipmentbeanArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.beans

