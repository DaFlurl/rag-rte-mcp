// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.FortificationEum

package com.evony.eum
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class FortificationEum implements IEventDispatcher 
    {

        private var _109770853stone:int;
        private var _3373707name:String;
        private var _1544916048defence:int;
        private var _3241160iron:int;
        private var _109637894space:int;
        private var _108280125range:int;
        private var _3655341wood:int;
        private var _100893exp:int;
        private var _2131644941repairRate:int;
        private var _3148894food:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3321596life:int;
        private var _3560141time:int;
        private var _1407259064attack:int;
        private var _858803723typeId:int;
        private var _1197946271wikiDesc:String;
        private var _3079825desc:String;

        public function FortificationEum()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
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

        [Bindable(event="propertyChange")]
        public function get space():int
        {
            return (this._109637894space);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function set space(_arg_1:int):void
        {
            var _local_2:Object = this._109637894space;
            if (_local_2 !== _arg_1)
            {
                this._109637894space = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "space", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get repairRate():int
        {
            return (this._2131644941repairRate);
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

        [Bindable(event="propertyChange")]
        public function get desc():String
        {
            return (this._3079825desc);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
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

        public function set time(_arg_1:int):void
        {
            var _local_2:Object = this._3560141time;
            if (_local_2 !== _arg_1)
            {
                this._3560141time = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get exp():int
        {
            return (this._100893exp);
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

        public function set repairRate(_arg_1:int):void
        {
            var _local_2:Object = this._2131644941repairRate;
            if (_local_2 !== _arg_1)
            {
                this._2131644941repairRate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "repairRate", _local_2, _arg_1));
            };
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

        [Bindable(event="propertyChange")]
        public function get wood():int
        {
            return (this._3655341wood);
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

        public function set exp(_arg_1:int):void
        {
            var _local_2:Object = this._100893exp;
            if (_local_2 !== _arg_1)
            {
                this._100893exp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exp", _local_2, _arg_1));
            };
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
        public function get range():int
        {
            return (this._108280125range);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get iron():int
        {
            return (this._3241160iron);
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

        [Bindable(event="propertyChange")]
        public function get time():int
        {
            return (this._3560141time);
        }

        [Bindable(event="propertyChange")]
        public function get attack():int
        {
            return (this._1407259064attack);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
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
        public function get defence():int
        {
            return (this._1544916048defence);
        }

        [Bindable(event="propertyChange")]
        public function get wikiDesc():String
        {
            return (this._1197946271wikiDesc);
        }

        [Bindable(event="propertyChange")]
        public function get food():int
        {
            return (this._3148894food);
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

        [Bindable(event="propertyChange")]
        public function get stone():int
        {
            return (this._109770853stone);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
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

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }


    }
}//package com.evony.eum

