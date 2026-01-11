// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.NpcHeroBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class NpcHeroBean implements IEventDispatcher 
    {

        public static const FREE_STATUS:int = 0;
        public static const CATCH_STATUS:int = 1;
        public static const HIRED_STATUS:int = 2;
        public static const GENERAL_NPC_HERO:int = 0;

        private var _105022396npcid:int;
        private var _871991583introduce:String;
        private var _3575610type:int;
        private var _1799980989management:int;
        private var _1782850756questType:int;
        private var _113766sex:int;
        private var _1200507606ability:int;
        private var _106858757power:int;
        private var _1180601999wisdom_base:int;
        private var _1551386992logoimage:String;
        private var _97427706field:int;
        private var _318758630leadership_Added:int;
        private var _737297702power_Added:int;
        private var _1384944173stratagem_Added:int;
        private var _2055722679bravery_base:int;
        private var _505236964management_Added:int;
        private var _987485392province:String;
        private var _3887zi:String;
        private var _1272455898affairs_base:int;
        private var _892481550status:int;
        private var _702030434catchQuestId:int;
        private var _3373707name:String;
        private var _115792uid:int;
        private var _1599491379taskitemid:String;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3135069face:int;
        private var _1192391365leadership:int;
        private var _358728774loyalty:int;
        private var _1000157193hireQuestId:int;
        private var _412944526stratagem:int;

        public function NpcHeroBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.ability != null)
                {
                    this.ability = _arg_1.ability;
                };
                if (_arg_1.affairs_base != null)
                {
                    this.affairs_base = _arg_1.affairs_base;
                };
                if (_arg_1.bravery_base != null)
                {
                    this.bravery_base = _arg_1.bravery_base;
                };
                if (_arg_1.catchQuestId != null)
                {
                    this.catchQuestId = _arg_1.catchQuestId;
                };
                if (_arg_1.face != null)
                {
                    this.face = _arg_1.face;
                };
                if (_arg_1.field != null)
                {
                    this.field = _arg_1.field;
                };
                if (_arg_1.hireQuestId != null)
                {
                    this.hireQuestId = _arg_1.hireQuestId;
                };
                if (_arg_1.introduce != null)
                {
                    this.introduce = _arg_1.introduce;
                };
                if (_arg_1.leadership != null)
                {
                    this.leadership = _arg_1.leadership;
                };
                if (_arg_1.leadership_Added != null)
                {
                    this.leadership_Added = _arg_1.leadership_Added;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.loyalty != null)
                {
                    this.loyalty = _arg_1.loyalty;
                };
                if (_arg_1.management != null)
                {
                    this.management = _arg_1.management;
                };
                if (_arg_1.management_Added != null)
                {
                    this.management_Added = _arg_1.management_Added;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.npcid != null)
                {
                    this.npcid = _arg_1.npcid;
                };
                if (_arg_1.power != null)
                {
                    this.power = _arg_1.power;
                };
                if (_arg_1.power_Added != null)
                {
                    this.power_Added = _arg_1.power_Added;
                };
                if (_arg_1.province != null)
                {
                    this.province = _arg_1.province;
                };
                if (_arg_1.questType != null)
                {
                    this.questType = _arg_1.questType;
                };
                if (_arg_1.sex != null)
                {
                    this.sex = _arg_1.sex;
                };
                if (_arg_1.status != null)
                {
                    this.status = _arg_1.status;
                };
                if (_arg_1.stratagem != null)
                {
                    this.stratagem = _arg_1.stratagem;
                };
                if (_arg_1.stratagem_Added != null)
                {
                    this.stratagem_Added = _arg_1.stratagem_Added;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
                if (_arg_1.uid != null)
                {
                    this.uid = _arg_1.uid;
                };
                if (_arg_1.wisdom_base != null)
                {
                    this.wisdom_base = _arg_1.wisdom_base;
                };
                if (_arg_1.zi != null)
                {
                    this.zi = _arg_1.zi;
                };
                if (_arg_1.logoimage != null)
                {
                    this.logoimage = _arg_1.logoimage;
                };
                if (_arg_1.taskitemid != null)
                {
                    this.taskitemid = _arg_1.taskitemid;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get field():int
        {
            return (this._97427706field);
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

        [Bindable(event="propertyChange")]
        public function get hireQuestId():int
        {
            return (this._1000157193hireQuestId);
        }

        [Bindable(event="propertyChange")]
        public function get power():int
        {
            return (this._106858757power);
        }

        public function set hireQuestId(_arg_1:int):void
        {
            var _local_2:Object = this._1000157193hireQuestId;
            if (_local_2 !== _arg_1)
            {
                this._1000157193hireQuestId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hireQuestId", _local_2, _arg_1));
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

        public function set level(_arg_1:int):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
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

        public function set stratagem(_arg_1:int):void
        {
            var _local_2:Object = this._412944526stratagem;
            if (_local_2 !== _arg_1)
            {
                this._412944526stratagem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagem", _local_2, _arg_1));
            };
        }

        public function set wisdom_base(_arg_1:int):void
        {
            var _local_2:Object = this._1180601999wisdom_base;
            if (_local_2 !== _arg_1)
            {
                this._1180601999wisdom_base = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wisdom_base", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get introduce():String
        {
            return (this._871991583introduce);
        }

        [Bindable(event="propertyChange")]
        public function get affairs_base():int
        {
            return (this._1272455898affairs_base);
        }

        public function set logoimage(_arg_1:String):void
        {
            var _local_2:Object = this._1551386992logoimage;
            if (_local_2 !== _arg_1)
            {
                this._1551386992logoimage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logoimage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get power_Added():int
        {
            return (this._737297702power_Added);
        }

        [Bindable(event="propertyChange")]
        public function get ability():int
        {
            return (this._1200507606ability);
        }

        [Bindable(event="propertyChange")]
        public function get questType():int
        {
            return (this._1782850756questType);
        }

        [Bindable(event="propertyChange")]
        public function get province():String
        {
            return (this._987485392province);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get management():int
        {
            return (this._1799980989management);
        }

        public function set introduce(_arg_1:String):void
        {
            var _local_2:Object = this._871991583introduce;
            if (_local_2 !== _arg_1)
            {
                this._871991583introduce = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "introduce", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get bravery_base():int
        {
            return (this._2055722679bravery_base);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get taskitemid():String
        {
            return (this._1599491379taskitemid);
        }

        public function set affairs_base(_arg_1:int):void
        {
            var _local_2:Object = this._1272455898affairs_base;
            if (_local_2 !== _arg_1)
            {
                this._1272455898affairs_base = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "affairs_base", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get loyalty():int
        {
            return (this._358728774loyalty);
        }

        [Bindable(event="propertyChange")]
        public function get uid():int
        {
            return (this._115792uid);
        }

        [Bindable(event="propertyChange")]
        public function get zi():String
        {
            return (this._3887zi);
        }

        [Bindable(event="propertyChange")]
        public function get type():int
        {
            return (this._3575610type);
        }

        public function set power_Added(_arg_1:int):void
        {
            var _local_2:Object = this._737297702power_Added;
            if (_local_2 !== _arg_1)
            {
                this._737297702power_Added = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "power_Added", _local_2, _arg_1));
            };
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

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get face():int
        {
            return (this._3135069face);
        }

        [Bindable(event="propertyChange")]
        public function get catchQuestId():int
        {
            return (this._702030434catchQuestId);
        }

        public function set zi(_arg_1:String):void
        {
            var _local_2:Object = this._3887zi;
            if (_local_2 !== _arg_1)
            {
                this._3887zi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zi", _local_2, _arg_1));
            };
        }

        public function set province(_arg_1:String):void
        {
            var _local_2:Object = this._987485392province;
            if (_local_2 !== _arg_1)
            {
                this._987485392province = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "province", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sex():int
        {
            return (this._113766sex);
        }

        public function set taskitemid(_arg_1:String):void
        {
            var _local_2:Object = this._1599491379taskitemid;
            if (_local_2 !== _arg_1)
            {
                this._1599491379taskitemid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taskitemid", _local_2, _arg_1));
            };
        }

        public function set npcid(_arg_1:int):void
        {
            var _local_2:Object = this._105022396npcid;
            if (_local_2 !== _arg_1)
            {
                this._105022396npcid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npcid", _local_2, _arg_1));
            };
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

        public function set questType(_arg_1:int):void
        {
            var _local_2:Object = this._1782850756questType;
            if (_local_2 !== _arg_1)
            {
                this._1782850756questType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questType", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stratagem():int
        {
            return (this._412944526stratagem);
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

        public function set leadership(_arg_1:int):void
        {
            var _local_2:Object = this._1192391365leadership;
            if (_local_2 !== _arg_1)
            {
                this._1192391365leadership = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leadership", _local_2, _arg_1));
            };
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

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get wisdom_base():int
        {
            return (this._1180601999wisdom_base);
        }

        [Bindable(event="propertyChange")]
        public function get logoimage():String
        {
            return (this._1551386992logoimage);
        }

        public function set bravery_base(_arg_1:int):void
        {
            var _local_2:Object = this._2055722679bravery_base;
            if (_local_2 !== _arg_1)
            {
                this._2055722679bravery_base = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bravery_base", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.ability = this.ability;
            _local_1.affairs_base = this.affairs_base;
            _local_1.bravery_base = this.bravery_base;
            _local_1.catchQuestId = this.catchQuestId;
            _local_1.face = this.face;
            _local_1.field = this.field;
            _local_1.hireQuestId = this.hireQuestId;
            _local_1.introduce = this.introduce;
            _local_1.leadership = this.leadership;
            _local_1.leadership_Added = this.leadership_Added;
            _local_1.level = this.level;
            _local_1.loyalty = this.loyalty;
            _local_1.management = this.management;
            _local_1.management_Added = this.management_Added;
            _local_1.name = this.name;
            _local_1.npcid = this.npcid;
            _local_1.power = this.power;
            _local_1.power_Added = this.power_Added;
            _local_1.province = this.province;
            _local_1.questType = this.questType;
            _local_1.sex = this.sex;
            _local_1.status = this.status;
            _local_1.stratagem = this.stratagem;
            _local_1.stratagem_Added = this.stratagem_Added;
            _local_1.type = this.type;
            _local_1.uid = this.uid;
            _local_1.wisdom_base = this.wisdom_base;
            _local_1.zi = this.zi;
            _local_1.logoimage = this.logoimage;
            _local_1.taskitemid = this.taskitemid;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
        }

        public function set uid(_arg_1:int):void
        {
            var _local_2:Object = this._115792uid;
            if (_local_2 !== _arg_1)
            {
                this._115792uid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "uid", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function set stratagem_Added(_arg_1:int):void
        {
            var _local_2:Object = this._1384944173stratagem_Added;
            if (_local_2 !== _arg_1)
            {
                this._1384944173stratagem_Added = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagem_Added", _local_2, _arg_1));
            };
        }

        public function set face(_arg_1:int):void
        {
            var _local_2:Object = this._3135069face;
            if (_local_2 !== _arg_1)
            {
                this._3135069face = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "face", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get npcid():int
        {
            return (this._105022396npcid);
        }

        public function set catchQuestId(_arg_1:int):void
        {
            var _local_2:Object = this._702030434catchQuestId;
            if (_local_2 !== _arg_1)
            {
                this._702030434catchQuestId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "catchQuestId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get leadership():int
        {
            return (this._1192391365leadership);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "ability = ") + this.ability) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "affairs_base = ") + this.affairs_base) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "bravery_base = ") + this.bravery_base) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "catchQuestId = ") + this.catchQuestId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "face = ") + this.face) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "field = ") + this.field) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "hireQuestId = ") + this.hireQuestId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "introduce = ") + this.introduce) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "leadership = ") + this.leadership) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "leadership_Added = ") + this.leadership_Added) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "loyalty = ") + this.loyalty) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "management = ") + this.management) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "management_Added = ") + this.management_Added) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "npcid = ") + this.npcid) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "power = ") + this.power) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "power_Added = ") + this.power_Added) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "province = ") + this.province) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "questType = ") + this.questType) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "sex = ") + this.sex) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stratagem = ") + this.stratagem) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stratagem_Added = ") + this.stratagem_Added) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "type = ") + this.type) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "uid = ") + this.uid) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "wisdom_base = ") + this.wisdom_base) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "zi = ") + this.zi) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "logoimage = ") + this.logoimage) + "\n"));
            return (_local_2 + (((_arg_1 + "taskitemid = ") + this.taskitemid) + "\n"));
        }

        public function set leadership_Added(_arg_1:int):void
        {
            var _local_2:Object = this._318758630leadership_Added;
            if (_local_2 !== _arg_1)
            {
                this._318758630leadership_Added = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leadership_Added", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:NpcHeroBean):void
        {
            _arg_1.ability = this.ability;
            _arg_1.affairs_base = this.affairs_base;
            _arg_1.bravery_base = this.bravery_base;
            _arg_1.catchQuestId = this.catchQuestId;
            _arg_1.face = this.face;
            _arg_1.field = this.field;
            _arg_1.hireQuestId = this.hireQuestId;
            _arg_1.introduce = this.introduce;
            _arg_1.leadership = this.leadership;
            _arg_1.leadership_Added = this.leadership_Added;
            _arg_1.level = this.level;
            _arg_1.loyalty = this.loyalty;
            _arg_1.management = this.management;
            _arg_1.management_Added = this.management_Added;
            _arg_1.name = this.name;
            _arg_1.npcid = this.npcid;
            _arg_1.power = this.power;
            _arg_1.power_Added = this.power_Added;
            _arg_1.province = this.province;
            _arg_1.questType = this.questType;
            _arg_1.sex = this.sex;
            _arg_1.status = this.status;
            _arg_1.stratagem = this.stratagem;
            _arg_1.stratagem_Added = this.stratagem_Added;
            _arg_1.type = this.type;
            _arg_1.uid = this.uid;
            _arg_1.wisdom_base = this.wisdom_base;
            _arg_1.zi = this.zi;
            _arg_1.logoimage = this.logoimage;
            _arg_1.taskitemid = this.taskitemid;
        }

        public function set sex(_arg_1:int):void
        {
            var _local_2:Object = this._113766sex;
            if (_local_2 !== _arg_1)
            {
                this._113766sex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sex", _local_2, _arg_1));
            };
        }

        public function set management_Added(_arg_1:int):void
        {
            var _local_2:Object = this._505236964management_Added;
            if (_local_2 !== _arg_1)
            {
                this._505236964management_Added = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "management_Added", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stratagem_Added():int
        {
            return (this._1384944173stratagem_Added);
        }

        [Bindable(event="propertyChange")]
        public function get management_Added():int
        {
            return (this._505236964management_Added);
        }

        [Bindable(event="propertyChange")]
        public function get leadership_Added():int
        {
            return (this._318758630leadership_Added);
        }

        [Bindable(event="propertyChange")]
        public function get status():int
        {
            return (this._892481550status);
        }

        public function set field(_arg_1:int):void
        {
            var _local_2:Object = this._97427706field;
            if (_local_2 !== _arg_1)
            {
                this._97427706field = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "field", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

