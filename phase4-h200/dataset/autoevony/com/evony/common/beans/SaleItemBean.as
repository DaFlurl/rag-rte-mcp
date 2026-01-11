// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.SaleItemBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.events.*;
    import flash.events.*;

    public class SaleItemBean implements IEventDispatcher 
    {

        private var _100526016items:String;
        private var _1936082977saleType:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function SaleItemBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.items != null)
                {
                    this.items = _arg_1.items;
                };
                if (_arg_1.saleType != null)
                {
                    this.saleType = _arg_1.saleType;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get items():String
        {
            return (this._100526016items);
        }

        [Bindable(event="propertyChange")]
        public function get saleType():int
        {
            return (this._1936082977saleType);
        }

        public function set saleType(_arg_1:int):void
        {
            var _local_2:Object = this._1936082977saleType;
            if (_local_2 !== _arg_1)
            {
                this._1936082977saleType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saleType", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set items(_arg_1:String):void
        {
            var _local_2:Object = this._100526016items;
            if (_local_2 !== _arg_1)
            {
                this._100526016items = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "items", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "items = ") + this.items) + "\n"));
            return (_local_2 + (((_arg_1 + "saleType = ") + this.saleType) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:SaleItemBean):void
        {
            _arg_1.items = this.items;
            _arg_1.saleType = this.saleType;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.items = this.items;
            _local_1.saleType = this.saleType;
            return (_local_1);
        }


    }
}//package com.evony.common.beans

