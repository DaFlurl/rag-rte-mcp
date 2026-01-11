// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.RankCastleBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class RankCastleBean implements IEventDispatcher 
    {

        private var _2023558323population:int;
        private var _3373707name:String;
        private var _98615255grade:String;
        private var _3292052kind:String;
        private var _3492908rank:int;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1806944311alliance:String;

        public function RankCastleBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.alliance != null)
                {
                    this.alliance = _arg_1.alliance;
                };
                if (_arg_1.grade != null)
                {
                    this.grade = _arg_1.grade;
                };
                if (_arg_1.kind != null)
                {
                    this.kind = _arg_1.kind;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.population != null)
                {
                    this.population = _arg_1.population;
                };
                if (_arg_1.rank != null)
                {
                    this.rank = _arg_1.rank;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
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

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((_arg_1 + "alliance = ") + this.alliance) + "\n") + (((_arg_1 + "grade = ") + this.grade) + "\n")) + (((_arg_1 + "kind = ") + this.kind) + "\n")) + (((_arg_1 + "level = ") + this.level) + "\n")) + (((_arg_1 + "name = ") + this.name) + "\n")) + (((_arg_1 + "population = ") + this.population) + "\n")) + (((_arg_1 + "rank = ") + this.rank) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        [Bindable(event="propertyChange")]
        public function get population():int
        {
            return (this._2023558323population);
        }

        public function copyTo(_arg_1:RankCastleBean):void
        {
            _arg_1.alliance = this.alliance;
            _arg_1.grade = this.grade;
            _arg_1.kind = this.kind;
            _arg_1.level = this.level;
            _arg_1.name = this.name;
            _arg_1.population = this.population;
            _arg_1.rank = this.rank;
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
        public function get grade():String
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

        public function set population(_arg_1:int):void
        {
            var _local_2:Object = this._2023558323population;
            if (_local_2 !== _arg_1)
            {
                this._2023558323population = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get kind():String
        {
            return (this._3292052kind);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function toObject():Object
        {
            return ({
                "alliance":this.alliance,
                "grade":this.grade,
                "kind":this.kind,
                "level":this.level,
                "name":this.name,
                "population":this.population,
                "rank":this.rank
            });
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }

        public function set grade(_arg_1:String):void
        {
            var _local_2:Object = this._98615255grade;
            if (_local_2 !== _arg_1)
            {
                this._98615255grade = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "grade", _local_2, _arg_1));
            };
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

        public function set alliance(_arg_1:String):void
        {
            var _local_2:Object = this._1806944311alliance;
            if (_local_2 !== _arg_1)
            {
                this._1806944311alliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get alliance():String
        {
            return (this._1806944311alliance);
        }


    }
}//package com.evony.common.beans

