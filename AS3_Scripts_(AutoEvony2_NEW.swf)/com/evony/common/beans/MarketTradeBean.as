// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.MarketTradeBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class MarketTradeBean implements IEventDispatcher 
    {

        private var _1413853096amount:int;
        private var _106934601price:Number;
        private var _bindingEventDispatcher:EventDispatcher;

        public function MarketTradeBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.amount != null)
                {
                    this.amount = _arg_1.amount;
                };
                if (_arg_1.price != null)
                {
                    this.price = _arg_1.price;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toObject():Object
        {
            return ({
                "amount":this.amount,
                "price":this.price
            });
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get price():Number
        {
            return (this._106934601price);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:MarketTradeBean):void
        {
            _arg_1.amount = this.amount;
            _arg_1.price = this.price;
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

        public function set amount(_arg_1:int):void
        {
            var _local_2:Object = this._1413853096amount;
            if (_local_2 !== _arg_1)
            {
                this._1413853096amount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amount", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((_arg_1 + "amount = ") + this.amount) + "\n") + (((_arg_1 + "price = ") + this.price) + "\n"));
        }

        [Bindable(event="propertyChange")]
        public function get amount():int
        {
            return (this._1413853096amount);
        }


    }
}//package com.evony.common.beans

