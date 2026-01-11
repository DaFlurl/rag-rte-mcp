// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ResourceProduceDataBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ResourceProduceDataBean implements IEventDispatcher 
    {

        private var _1308753897armyPercentage:Number;
        private var _313448791commenceRate:int;
        private var _2043715731productionCapacity:int;
        private var _858802731typeid:int;
        private var _849060507totalOutput:int;
        private var _2028158848cimeliaPercentage:int;
        private var _401632820heroPercentage:int;
        private var _859635508fieldPercentage:int;
        private var _1261923249commenceDemands:int;
        private var _795443933maxLabour:int;
        private var _1141868451naturalPercentage:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _940015921basicOutput:int;
        private var _488102284technologicalPercentage:int;

        public function ResourceProduceDataBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.armyPercentage != null)
                {
                    this.armyPercentage = _arg_1.armyPercentage;
                };
                if (_arg_1.basicOutput != null)
                {
                    this.basicOutput = _arg_1.basicOutput;
                };
                if (_arg_1.cimeliaPercentage != null)
                {
                    this.cimeliaPercentage = _arg_1.cimeliaPercentage;
                };
                if (_arg_1.commenceDemands != null)
                {
                    this.commenceDemands = _arg_1.commenceDemands;
                };
                if (_arg_1.commenceRate != null)
                {
                    this.commenceRate = _arg_1.commenceRate;
                };
                if (_arg_1.fieldPercentage != null)
                {
                    this.fieldPercentage = _arg_1.fieldPercentage;
                };
                if (_arg_1.heroPercentage != null)
                {
                    this.heroPercentage = _arg_1.heroPercentage;
                };
                if (_arg_1.maxLabour != null)
                {
                    this.maxLabour = _arg_1.maxLabour;
                };
                if (_arg_1.naturalPercentage != null)
                {
                    this.naturalPercentage = _arg_1.naturalPercentage;
                };
                if (_arg_1.productionCapacity != null)
                {
                    this.productionCapacity = _arg_1.productionCapacity;
                };
                if (_arg_1.technologicalPercentage != null)
                {
                    this.technologicalPercentage = _arg_1.technologicalPercentage;
                };
                if (_arg_1.totalOutput != null)
                {
                    this.totalOutput = _arg_1.totalOutput;
                };
                if (_arg_1.typeid != null)
                {
                    this.typeid = _arg_1.typeid;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get cimeliaPercentage():int
        {
            return (this._2028158848cimeliaPercentage);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set cimeliaPercentage(_arg_1:int):void
        {
            var _local_2:Object = this._2028158848cimeliaPercentage;
            if (_local_2 !== _arg_1)
            {
                this._2028158848cimeliaPercentage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cimeliaPercentage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get productionCapacity():int
        {
            return (this._2043715731productionCapacity);
        }

        [Bindable(event="propertyChange")]
        public function get armyPercentage():Number
        {
            return (this._1308753897armyPercentage);
        }

        public function toObject():Object
        {
            return ({
                "armyPercentage":this.armyPercentage,
                "basicOutput":this.basicOutput,
                "cimeliaPercentage":this.cimeliaPercentage,
                "commenceDemands":this.commenceDemands,
                "commenceRate":this.commenceRate,
                "fieldPercentage":this.fieldPercentage,
                "heroPercentage":this.heroPercentage,
                "maxLabour":this.maxLabour,
                "naturalPercentage":this.naturalPercentage,
                "productionCapacity":this.productionCapacity,
                "technologicalPercentage":this.technologicalPercentage,
                "totalOutput":this.totalOutput,
                "typeid":this.typeid
            });
        }

        [Bindable(event="propertyChange")]
        public function get technologicalPercentage():int
        {
            return (this._488102284technologicalPercentage);
        }

        public function set basicOutput(_arg_1:int):void
        {
            var _local_2:Object = this._940015921basicOutput;
            if (_local_2 !== _arg_1)
            {
                this._940015921basicOutput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "basicOutput", _local_2, _arg_1));
            };
        }

        public function set technologicalPercentage(_arg_1:int):void
        {
            var _local_2:Object = this._488102284technologicalPercentage;
            if (_local_2 !== _arg_1)
            {
                this._488102284technologicalPercentage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "technologicalPercentage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get maxLabour():int
        {
            return (this._795443933maxLabour);
        }

        public function set productionCapacity(_arg_1:int):void
        {
            var _local_2:Object = this._2043715731productionCapacity;
            if (_local_2 !== _arg_1)
            {
                this._2043715731productionCapacity = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productionCapacity", _local_2, _arg_1));
            };
        }

        public function set armyPercentage(_arg_1:Number):void
        {
            var _local_2:Object = this._1308753897armyPercentage;
            if (_local_2 !== _arg_1)
            {
                this._1308753897armyPercentage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyPercentage", _local_2, _arg_1));
            };
        }

        public function set typeid(_arg_1:int):void
        {
            var _local_2:Object = this._858802731typeid;
            if (_local_2 !== _arg_1)
            {
                this._858802731typeid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeid", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get fieldPercentage():int
        {
            return (this._859635508fieldPercentage);
        }

        public function set commenceRate(_arg_1:int):void
        {
            var _local_2:Object = this._313448791commenceRate;
            if (_local_2 !== _arg_1)
            {
                this._313448791commenceRate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commenceRate", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get commenceDemands():int
        {
            return (this._1261923249commenceDemands);
        }

        [Bindable(event="propertyChange")]
        public function get heroPercentage():int
        {
            return (this._401632820heroPercentage);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get naturalPercentage():int
        {
            return (this._1141868451naturalPercentage);
        }

        public function set maxLabour(_arg_1:int):void
        {
            var _local_2:Object = this._795443933maxLabour;
            if (_local_2 !== _arg_1)
            {
                this._795443933maxLabour = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxLabour", _local_2, _arg_1));
            };
        }

        public function set totalOutput(_arg_1:int):void
        {
            var _local_2:Object = this._849060507totalOutput;
            if (_local_2 !== _arg_1)
            {
                this._849060507totalOutput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalOutput", _local_2, _arg_1));
            };
        }

        public function set naturalPercentage(_arg_1:int):void
        {
            var _local_2:Object = this._1141868451naturalPercentage;
            if (_local_2 !== _arg_1)
            {
                this._1141868451naturalPercentage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "naturalPercentage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get basicOutput():int
        {
            return (this._940015921basicOutput);
        }

        public function copyTo(_arg_1:ResourceProduceDataBean):void
        {
            _arg_1.armyPercentage = this.armyPercentage;
            _arg_1.basicOutput = this.basicOutput;
            _arg_1.cimeliaPercentage = this.cimeliaPercentage;
            _arg_1.commenceDemands = this.commenceDemands;
            _arg_1.commenceRate = this.commenceRate;
            _arg_1.fieldPercentage = this.fieldPercentage;
            _arg_1.heroPercentage = this.heroPercentage;
            _arg_1.maxLabour = this.maxLabour;
            _arg_1.naturalPercentage = this.naturalPercentage;
            _arg_1.productionCapacity = this.productionCapacity;
            _arg_1.technologicalPercentage = this.technologicalPercentage;
            _arg_1.totalOutput = this.totalOutput;
            _arg_1.typeid = this.typeid;
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get typeid():int
        {
            return (this._858802731typeid);
        }

        [Bindable(event="propertyChange")]
        public function get commenceRate():int
        {
            return (this._313448791commenceRate);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((((((((_arg_1 + "armyPercentage = ") + this.armyPercentage) + "\n") + (((_arg_1 + "basicOutput = ") + this.basicOutput) + "\n")) + (((_arg_1 + "cimeliaPercentage = ") + this.cimeliaPercentage) + "\n")) + (((_arg_1 + "commenceDemands = ") + this.commenceDemands) + "\n")) + (((_arg_1 + "commenceRate = ") + this.commenceRate) + "\n")) + (((_arg_1 + "fieldPercentage = ") + this.fieldPercentage) + "\n")) + (((_arg_1 + "heroPercentage = ") + this.heroPercentage) + "\n")) + (((_arg_1 + "maxLabour = ") + this.maxLabour) + "\n")) + (((_arg_1 + "naturalPercentage = ") + this.naturalPercentage) + "\n")) + (((_arg_1 + "productionCapacity = ") + this.productionCapacity) + "\n")) + (((_arg_1 + "technologicalPercentage = ") + this.technologicalPercentage) + "\n")) + (((_arg_1 + "totalOutput = ") + this.totalOutput) + "\n")) + (((_arg_1 + "typeid = ") + this.typeid) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set commenceDemands(_arg_1:int):void
        {
            var _local_2:Object = this._1261923249commenceDemands;
            if (_local_2 !== _arg_1)
            {
                this._1261923249commenceDemands = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commenceDemands", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get totalOutput():int
        {
            return (this._849060507totalOutput);
        }

        public function set heroPercentage(_arg_1:int):void
        {
            var _local_2:Object = this._401632820heroPercentage;
            if (_local_2 !== _arg_1)
            {
                this._401632820heroPercentage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPercentage", _local_2, _arg_1));
            };
        }

        public function set fieldPercentage(_arg_1:int):void
        {
            var _local_2:Object = this._859635508fieldPercentage;
            if (_local_2 !== _arg_1)
            {
                this._859635508fieldPercentage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldPercentage", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

