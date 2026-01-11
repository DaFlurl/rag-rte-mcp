// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.TradeBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class TradeBean implements IEventDispatcher 
    {

        private var _384566343resourceName:String;
        private var _106934601price:Number;
        private var _1413853096amount:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3355id:int;
        private var _752919230tradeType:int;
        private var _1302723991tradeTypeName:String;
        private var _147397053dealedAmount:int;
        private var _428497913dealedTotal:Number;
        private var _1096575994resType:int;

        public function TradeBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.amount != null)
                {
                    this.amount = _arg_1.amount;
                };
                if (_arg_1.dealedAmount != null)
                {
                    this.dealedAmount = _arg_1.dealedAmount;
                };
                if (_arg_1.dealedTotal != null)
                {
                    this.dealedTotal = _arg_1.dealedTotal;
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
                if (_arg_1.tradeType != null)
                {
                    this.tradeType = _arg_1.tradeType;
                };
                if (_arg_1.tradeTypeName != null)
                {
                    this.tradeTypeName = _arg_1.tradeTypeName;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get dealedTotal():Number
        {
            return (this._428497913dealedTotal);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set dealedAmount(_arg_1:int):void
        {
            var _local_2:Object = this._147397053dealedAmount;
            if (_local_2 !== _arg_1)
            {
                this._147397053dealedAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dealedAmount", _local_2, _arg_1));
            };
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
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toObject():Object
        {
            return ({
                "amount":this.amount,
                "dealedAmount":this.dealedAmount,
                "dealedTotal":this.dealedTotal,
                "id":this.id,
                "price":this.price,
                "resType":this.resType,
                "resourceName":this.resourceName,
                "tradeType":this.tradeType,
                "tradeTypeName":this.tradeTypeName
            });
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
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

        [Bindable(event="propertyChange")]
        public function get tradeType():int
        {
            return (this._752919230tradeType);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get dealedAmount():int
        {
            return (this._147397053dealedAmount);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((((_arg_1 + "amount = ") + this.amount) + "\n") + (((_arg_1 + "dealedAmount = ") + this.dealedAmount) + "\n")) + (((_arg_1 + "dealedTotal = ") + this.dealedTotal) + "\n")) + (((_arg_1 + "id = ") + this.id) + "\n")) + (((_arg_1 + "price = ") + this.price) + "\n")) + (((_arg_1 + "resType = ") + this.resType) + "\n")) + (((_arg_1 + "resourceName = ") + this.resourceName) + "\n")) + (((_arg_1 + "tradeType = ") + this.tradeType) + "\n")) + (((_arg_1 + "tradeTypeName = ") + this.tradeTypeName) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function copyTo(_arg_1:TradeBean):void
        {
            _arg_1.amount = this.amount;
            _arg_1.dealedAmount = this.dealedAmount;
            _arg_1.dealedTotal = this.dealedTotal;
            _arg_1.id = this.id;
            _arg_1.price = this.price;
            _arg_1.resType = this.resType;
            _arg_1.resourceName = this.resourceName;
            _arg_1.tradeType = this.tradeType;
            _arg_1.tradeTypeName = this.tradeTypeName;
        }

        public function set tradeTypeName(_arg_1:String):void
        {
            var _local_2:Object = this._1302723991tradeTypeName;
            if (_local_2 !== _arg_1)
            {
                this._1302723991tradeTypeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradeTypeName", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get price():Number
        {
            return (this._106934601price);
        }

        [Bindable(event="propertyChange")]
        public function get amount():int
        {
            return (this._1413853096amount);
        }

        [Bindable(event="propertyChange")]
        public function get tradeTypeName():String
        {
            return (this._1302723991tradeTypeName);
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

        public function set dealedTotal(_arg_1:Number):void
        {
            var _local_2:Object = this._428497913dealedTotal;
            if (_local_2 !== _arg_1)
            {
                this._428497913dealedTotal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dealedTotal", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get resType():int
        {
            return (this._1096575994resType);
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

        public function set tradeType(_arg_1:int):void
        {
            var _local_2:Object = this._752919230tradeType;
            if (_local_2 !== _arg_1)
            {
                this._752919230tradeType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradeType", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

