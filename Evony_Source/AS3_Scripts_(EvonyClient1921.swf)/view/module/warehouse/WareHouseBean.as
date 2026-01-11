// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.warehouse.WareHouseBean

package view.module.warehouse
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class WareHouseBean implements IEventDispatcher 
    {

        private var _storePercent:int;
        private var _typeId:int;
        private var _stock:Number;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _storage:Number;
        private var _unStock:Number;
        private var _typeName:String;
        private var _resLimt:Number;
        private var _amount:Number;

        public function WareHouseBean()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public function get storage():Number
        {
            return (this._storage);
        }

        private function set _1884274053storage(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            this._storage = _arg_1;
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        private function set _358052900storePercent(_arg_1:int):void
        {
            this._storePercent = _arg_1;
        }

        public function get stock():Number
        {
            return (this._stock);
        }

        public function get storePercent():int
        {
            return (this._storePercent);
        }

        public function get resLimt():Number
        {
            return (this._resLimt);
        }

        [Bindable(event="propertyChange")]
        public function set stock(_arg_1:Number):void
        {
            var _local_2:Object = this.stock;
            if (_local_2 !== _arg_1)
            {
                this._109770518stock = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stock", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set amount(_arg_1:Number):void
        {
            var _local_2:Object = this.amount;
            if (_local_2 !== _arg_1)
            {
                this._1413853096amount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amount", _local_2, _arg_1));
            };
        }

        private function set _676507419typeName(_arg_1:String):void
        {
            this._typeName = _arg_1;
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function set storePercent(_arg_1:int):void
        {
            var _local_2:Object = this.storePercent;
            if (_local_2 !== _arg_1)
            {
                this._358052900storePercent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storePercent", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function set resLimt(_arg_1:Number):void
        {
            var _local_2:Object = this.resLimt;
            if (_local_2 !== _arg_1)
            {
                this._1096322212resLimt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resLimt", _local_2, _arg_1));
            };
        }

        private function set _1096322212resLimt(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            this._resLimt = _arg_1;
        }

        public function get amount():Number
        {
            return (this._amount);
        }

        [Bindable(event="propertyChange")]
        public function set typeName(_arg_1:String):void
        {
            var _local_2:Object = this.typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        private function set _306827267unStock(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            this._unStock = _arg_1;
        }

        private function set _858803723typeId(_arg_1:int):void
        {
            this._typeId = _arg_1;
        }

        private function set _109770518stock(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            this._stock = _arg_1;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        private function set _1413853096amount(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            this._amount = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this.typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        public function get typeName():String
        {
            return (this._typeName);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function get typeId():int
        {
            return (this._typeId);
        }

        [Bindable(event="propertyChange")]
        public function set storage(_arg_1:Number):void
        {
            var _local_2:Object = this.storage;
            if (_local_2 !== _arg_1)
            {
                this._1884274053storage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set unStock(_arg_1:Number):void
        {
            var _local_2:Object = this.unStock;
            if (_local_2 !== _arg_1)
            {
                this._306827267unStock = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unStock", _local_2, _arg_1));
            };
        }

        public function get unStock():Number
        {
            return (this._unStock);
        }


    }
}//package view.module.warehouse

