// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.TransingTradeBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class TransingTradeBean implements IEventDispatcher 
    {

        private var _1413853096amount:int;
        private var _1607243192endTime:Number;
        private var _384566343resourceName:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _106934601price:Number;
        private var _110549828total:int;
        private var _3355id:int;
        private var _1096575994resType:int;

        public function TransingTradeBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.amount != null)
                {
                    this.amount = _arg_1.amount;
                };
                if (_arg_1.endTime != null)
                {
                    this.endTime = _arg_1.endTime;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.price != null)
                {
                    this.price = _arg_1.price;
                };
                if (_arg_1.resType != null)
                {
                    this.resType = _arg_1.resType;
                };
                if (_arg_1.resourceName != null)
                {
                    this.resourceName = _arg_1.resourceName;
                };
                if (_arg_1.total != null)
                {
                    this.total = _arg_1.total;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get resType():int
        {
            return (this._1096575994resType);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get endTime():Number
        {
            return (this._1607243192endTime);
        }

        [Bindable(event="propertyChange")]
        public function get price():Number
        {
            return (this._106934601price);
        }

        [Bindable(event="propertyChange")]
        public function get total():int
        {
            return (this._110549828total);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:TransingTradeBean):void
        {
            _arg_1.amount = this.amount;
            _arg_1.endTime = this.endTime;
            _arg_1.id = this.id;
            _arg_1.price = this.price;
            _arg_1.resType = this.resType;
            _arg_1.resourceName = this.resourceName;
            _arg_1.total = this.total;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set price(_arg_1:Number):void
        {
            var _local_2:Object = this._106934601price;
            if (_local_2 !== _arg_1)
            {
                this._106934601price = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "price", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set endTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1607243192endTime;
            if (_local_2 !== _arg_1)
            {
                this._1607243192endTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endTime", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "amount = ") + this.amount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "endTime = ") + this.endTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "price = ") + this.price) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "resType = ") + this.resType) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "resourceName = ") + this.resourceName) + "\n"));
            return (_local_2 + (((_arg_1 + "total = ") + this.total) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.amount = this.amount;
            _local_1.endTime = this.endTime;
            _local_1.id = this.id;
            _local_1.price = this.price;
            _local_1.resType = this.resType;
            _local_1.resourceName = this.resourceName;
            _local_1.total = this.total;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        [Bindable(event="propertyChange")]
        public function get amount():int
        {
            return (this._1413853096amount);
        }

        public function set total(_arg_1:int):void
        {
            var _local_2:Object = this._110549828total;
            if (_local_2 !== _arg_1)
            {
                this._110549828total = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "total", _local_2, _arg_1));
            };
        }

        public function set amount(_arg_1:int):void
        {
            var _local_2:Object = this._1413853096amount;
            if (_local_2 !== _arg_1)
            {
                this._1413853096amount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amount", _local_2, _arg_1));
            };
        }

        public function set resourceName(_arg_1:String):void
        {
            var _local_2:Object = this._384566343resourceName;
            if (_local_2 !== _arg_1)
            {
                this._384566343resourceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceName", _local_2, _arg_1));
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
        public function get resourceName():String
        {
            return (this._384566343resourceName);
        }

        public function set resType(_arg_1:int):void
        {
            var _local_2:Object = this._1096575994resType;
            if (_local_2 !== _arg_1)
            {
                this._1096575994resType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resType", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

