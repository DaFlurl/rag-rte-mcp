// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.TroopEum

package com.evony.eum
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class TroopEum implements IEventDispatcher 
    {

        private var _109770853stone:int;
        private var _3373707name:String;
        private var _1544916048defence:int;
        private var _3241160iron:int;
        private var _3327206load:int;
        private var _109641799speed:int;
        private var _108280125range:int;
        private var _3655341wood:int;
        private var _2023558323population:int;
        private var _618148268troopType:int;
        private var _3321596life:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1054836655foodRequest:int;
        private var _3148894food:int;
        private var _3560141time:int;
        private var _1407259064attack:int;
        private var _858803723typeId:int;
        private var _1197946271wikiDesc:String;
        private var _3079825desc:String;

        public function TroopEum()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }

        public function set attack(_arg_1:int):void
        {
            var _local_2:Object = this._1407259064attack;
            if (_local_2 !== _arg_1)
            {
                this._1407259064attack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get desc():String
        {
            return (this._3079825desc);
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

        public function set speed(_arg_1:int):void
        {
            var _local_2:Object = this._109641799speed;
            if (_local_2 !== _arg_1)
            {
                this._109641799speed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "speed", _local_2, _arg_1));
            };
        }

        public function set iron(_arg_1:int):void
        {
            var _local_2:Object = this._3241160iron;
            if (_local_2 !== _arg_1)
            {
                this._3241160iron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iron", _local_2, _arg_1));
            };
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

        public function set time(_arg_1:int):void
        {
            var _local_2:Object = this._3560141time;
            if (_local_2 !== _arg_1)
            {
                this._3560141time = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _local_2, _arg_1));
            };
        }

        public function set foodRequest(_arg_1:int):void
        {
            var _local_2:Object = this._1054836655foodRequest;
            if (_local_2 !== _arg_1)
            {
                this._1054836655foodRequest = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodRequest", _local_2, _arg_1));
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
        public function get troopType():int
        {
            return (this._618148268troopType);
        }

        [Bindable(event="propertyChange")]
        public function get wood():int
        {
            return (this._3655341wood);
        }

        public function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set food(_arg_1:int):void
        {
            var _local_2:Object = this._3148894food;
            if (_local_2 !== _arg_1)
            {
                this._3148894food = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "food", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get range():int
        {
            return (this._108280125range);
        }

        public function set wikiDesc(_arg_1:String):void
        {
            var _local_2:Object = this._1197946271wikiDesc;
            if (_local_2 !== _arg_1)
            {
                this._1197946271wikiDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wikiDesc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get attack():int
        {
            return (this._1407259064attack);
        }

        public function set stone(_arg_1:int):void
        {
            var _local_2:Object = this._109770853stone;
            if (_local_2 !== _arg_1)
            {
                this._109770853stone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stone", _local_2, _arg_1));
            };
        }

        public function set load(_arg_1:int):void
        {
            var _local_2:Object = this._3327206load;
            if (_local_2 !== _arg_1)
            {
                this._3327206load = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "load", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get time():int
        {
            return (this._3560141time);
        }

        [Bindable(event="propertyChange")]
        public function get speed():int
        {
            return (this._109641799speed);
        }

        [Bindable(event="propertyChange")]
        public function get foodRequest():int
        {
            return (this._1054836655foodRequest);
        }

        [Bindable(event="propertyChange")]
        public function get population():int
        {
            return (this._2023558323population);
        }

        [Bindable(event="propertyChange")]
        public function get defence():int
        {
            return (this._1544916048defence);
        }

        public function set troopType(_arg_1:int):void
        {
            var _local_2:Object = this._618148268troopType;
            if (_local_2 !== _arg_1)
            {
                this._618148268troopType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopType", _local_2, _arg_1));
            };
        }

        public function set wood(_arg_1:int):void
        {
            var _local_2:Object = this._3655341wood;
            if (_local_2 !== _arg_1)
            {
                this._3655341wood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get wikiDesc():String
        {
            return (this._1197946271wikiDesc);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get food():int
        {
            return (this._3148894food);
        }

        [Bindable(event="propertyChange")]
        public function get load():int
        {
            return (this._3327206load);
        }

        [Bindable(event="propertyChange")]
        public function get iron():int
        {
            return (this._3241160iron);
        }

        [Bindable(event="propertyChange")]
        public function get stone():int
        {
            return (this._109770853stone);
        }

        public function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set life(_arg_1:int):void
        {
            var _local_2:Object = this._3321596life;
            if (_local_2 !== _arg_1)
            {
                this._3321596life = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "life", _local_2, _arg_1));
            };
        }

        public function set range(_arg_1:int):void
        {
            var _local_2:Object = this._108280125range;
            if (_local_2 !== _arg_1)
            {
                this._108280125range = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "range", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get life():int
        {
            return (this._3321596life);
        }


    }
}//package com.evony.eum

