// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.SaleTypeBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class SaleTypeBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _100526016items:String;
        private var _676507419typeName:String;

        public function SaleTypeBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.items != null)
                {
                    this.items = _arg_1.items;
                };
                if (_arg_1.typeName != null)
                {
                    this.typeName = _arg_1.typeName;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get items():String
        {
            return (this._100526016items);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get typeName():String
        {
            return (this._676507419typeName);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
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
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "items = ") + this.items) + "\n"));
            return (_local_2 + (((_arg_1 + "typeName = ") + this.typeName) + "\n"));
        }

        public function set typeName(_arg_1:String):void
        {
            var _local_2:Object = this._676507419typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:SaleTypeBean):void
        {
            _arg_1.items = this.items;
            _arg_1.typeName = this.typeName;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.items = this.items;
            _local_1.typeName = this.typeName;
            return (_local_1);
        }


    }
}//package com.evony.common.beans

