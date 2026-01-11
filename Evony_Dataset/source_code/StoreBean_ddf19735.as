// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.StoreBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import mx.events.*;
    import flash.events.*;

    public class StoreBean implements IEventDispatcher 
    {

        private var _358052900storePercent:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _2016783856magnitude:int;
        private var _292680141warehourseCapacity:int;
        private var _1096322212resLimt:int;
        private var _172472894unstorage:int;
        private var _1795184074storeTypeId:int;
        private var _1884274053storage:int;

        public function StoreBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.magnitude != null)
                {
                    this.magnitude = _arg_1.magnitude;
                };
                if (_arg_1.resLimt != null)
                {
                    this.resLimt = _arg_1.resLimt;
                };
                if (_arg_1.storage != null)
                {
                    this.storage = _arg_1.storage;
                };
                if (_arg_1.storePercent != null)
                {
                    this.storePercent = _arg_1.storePercent;
                };
                if (_arg_1.storeTypeId != null)
                {
                    this.storeTypeId = _arg_1.storeTypeId;
                };
                if (_arg_1.unstorage != null)
                {
                    this.unstorage = _arg_1.unstorage;
                };
                if (_arg_1.warehourseCapacity != null)
                {
                    this.warehourseCapacity = _arg_1.warehourseCapacity;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get unstorage():int
        {
            return (this._172472894unstorage);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set unstorage(_arg_1:int):void
        {
            var _local_2:Object = this._172472894unstorage;
            if (_local_2 !== _arg_1)
            {
                this._172472894unstorage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unstorage", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set storePercent(_arg_1:int):void
        {
            var _local_2:Object = this._358052900storePercent;
            if (_local_2 !== _arg_1)
            {
                this._358052900storePercent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storePercent", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "magnitude = ") + this.magnitude) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "resLimt = ") + this.resLimt) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "storage = ") + this.storage) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "storePercent = ") + this.storePercent) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "storeTypeId = ") + this.storeTypeId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "unstorage = ") + this.unstorage) + "\n"));
            return (_local_2 + (((_arg_1 + "warehourseCapacity = ") + this.warehourseCapacity) + "\n"));
        }

        [Bindable(event="propertyChange")]
        public function get warehourseCapacity():int
        {
            return (this._292680141warehourseCapacity);
        }

        public function set resLimt(_arg_1:int):void
        {
            var _local_2:Object = this._1096322212resLimt;
            if (_local_2 !== _arg_1)
            {
                this._1096322212resLimt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resLimt", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:StoreBean):void
        {
            _arg_1.magnitude = this.magnitude;
            _arg_1.resLimt = this.resLimt;
            _arg_1.storage = this.storage;
            _arg_1.storePercent = this.storePercent;
            _arg_1.storeTypeId = this.storeTypeId;
            _arg_1.unstorage = this.unstorage;
            _arg_1.warehourseCapacity = this.warehourseCapacity;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get magnitude():int
        {
            return (this._2016783856magnitude);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.magnitude = this.magnitude;
            _local_1.resLimt = this.resLimt;
            _local_1.storage = this.storage;
            _local_1.storePercent = this.storePercent;
            _local_1.storeTypeId = this.storeTypeId;
            _local_1.unstorage = this.unstorage;
            _local_1.warehourseCapacity = this.warehourseCapacity;
            return (_local_1);
        }

        public function set magnitude(_arg_1:int):void
        {
            var _local_2:Object = this._2016783856magnitude;
            if (_local_2 !== _arg_1)
            {
                this._2016783856magnitude = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "magnitude", _local_2, _arg_1));
            };
        }

        public function set warehourseCapacity(_arg_1:int):void
        {
            var _local_2:Object = this._292680141warehourseCapacity;
            if (_local_2 !== _arg_1)
            {
                this._292680141warehourseCapacity = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "warehourseCapacity", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get storePercent():int
        {
            return (this._358052900storePercent);
        }

        [Bindable(event="propertyChange")]
        public function get resLimt():int
        {
            return (this._1096322212resLimt);
        }

        public function set storeTypeId(_arg_1:int):void
        {
            var _local_2:Object = this._1795184074storeTypeId;
            if (_local_2 !== _arg_1)
            {
                this._1795184074storeTypeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storeTypeId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get storeTypeId():int
        {
            return (this._1795184074storeTypeId);
        }

        [Bindable(event="propertyChange")]
        public function get storage():int
        {
            return (this._1884274053storage);
        }

        public function set storage(_arg_1:int):void
        {
            var _local_2:Object = this._1884274053storage;
            if (_local_2 !== _arg_1)
            {
                this._1884274053storage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storage", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

