// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.RankHeroBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class RankHeroBean implements IEventDispatcher 
    {

        private var _3373707name:String;
        private var _1799980989management:int;
        private var _1180455868isHero:int;
        private var _3292052kind:String;
        private var _106858757power:int;
        private var _98615255grade:int;
        private var _3492908rank:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _412944526stratagem:int;

        public function RankHeroBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.grade != null)
                {
                    this.grade = _arg_1.grade;
                };
                if (_arg_1.isHero != null)
                {
                    this.isHero = _arg_1.isHero;
                };
                if (_arg_1.kind != null)
                {
                    this.kind = _arg_1.kind;
                };
                if (_arg_1.management != null)
                {
                    this.management = _arg_1.management;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.power != null)
                {
                    this.power = _arg_1.power;
                };
                if (_arg_1.rank != null)
                {
                    this.rank = _arg_1.rank;
                };
                if (_arg_1.stratagem != null)
                {
                    this.stratagem = _arg_1.stratagem;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get management():int
        {
            return (this._1799980989management);
        }

        [Bindable(event="propertyChange")]
        public function get isHero():int
        {
            return (this._1180455868isHero);
        }

        [Bindable(event="propertyChange")]
        public function get power():int
        {
            return (this._106858757power);
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

        public function set isHero(_arg_1:int):void
        {
            var _local_2:Object = this._1180455868isHero;
            if (_local_2 !== _arg_1)
            {
                this._1180455868isHero = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isHero", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((((_arg_1 + "grade = ") + this.grade) + "\n") + (((_arg_1 + "isHero = ") + this.isHero) + "\n")) + (((_arg_1 + "kind = ") + this.kind) + "\n")) + (((_arg_1 + "management = ") + this.management) + "\n")) + (((_arg_1 + "name = ") + this.name) + "\n")) + (((_arg_1 + "power = ") + this.power) + "\n")) + (((_arg_1 + "rank = ") + this.rank) + "\n")) + (((_arg_1 + "stratagem = ") + this.stratagem) + "\n"));
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
        public function get name():String
        {
            return (this._3373707name);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:RankHeroBean):void
        {
            _arg_1.grade = this.grade;
            _arg_1.isHero = this.isHero;
            _arg_1.kind = this.kind;
            _arg_1.management = this.management;
            _arg_1.name = this.name;
            _arg_1.power = this.power;
            _arg_1.rank = this.rank;
            _arg_1.stratagem = this.stratagem;
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
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
        public function get grade():int
        {
            return (this._98615255grade);
        }

        public function set rank(_arg_1:int):void
        {
            var _local_2:Object = this._3492908rank;
            if (_local_2 !== _arg_1)
            {
                this._3492908rank = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rank", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function toObject():Object
        {
            return ({
                "grade":this.grade,
                "isHero":this.isHero,
                "kind":this.kind,
                "management":this.management,
                "name":this.name,
                "power":this.power,
                "rank":this.rank,
                "stratagem":this.stratagem
            });
        }

        [Bindable(event="propertyChange")]
        public function get kind():String
        {
            return (this._3292052kind);
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

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }

        public function set grade(_arg_1:int):void
        {
            var _local_2:Object = this._98615255grade;
            if (_local_2 !== _arg_1)
            {
                this._98615255grade = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "grade", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stratagem():int
        {
            return (this._412944526stratagem);
        }

        public function set kind(_arg_1:String):void
        {
            var _local_2:Object = this._3292052kind;
            if (_local_2 !== _arg_1)
            {
                this._3292052kind = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "kind", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

