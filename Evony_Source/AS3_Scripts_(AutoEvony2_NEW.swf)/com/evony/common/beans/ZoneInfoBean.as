// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ZoneInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ZoneInfoBean implements IEventDispatcher 
    {

        private var _531131054playerCount:int;
        private var _764803337castleCount:int;
        private var _3373707name:String;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3493088rate:int;

        public function ZoneInfoBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.castleCount != null)
                {
                    this.castleCount = _arg_1.castleCount;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.playerCount != null)
                {
                    this.playerCount = _arg_1.playerCount;
                };
                if (_arg_1.rate != null)
                {
                    this.rate = _arg_1.rate;
                };
            };
        }

        public function set rate(_arg_1:int):void
        {
            var _local_2:Object = this._3493088rate;
            if (_local_2 !== _arg_1)
            {
                this._3493088rate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rate", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "castleCount = ") + this.castleCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "playerCount = ") + this.playerCount) + "\n"));
            return (_local_2 + (((_arg_1 + "rate = ") + this.rate) + "\n"));
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:ZoneInfoBean):void
        {
            _arg_1.castleCount = this.castleCount;
            _arg_1.id = this.id;
            _arg_1.name = this.name;
            _arg_1.playerCount = this.playerCount;
            _arg_1.rate = this.rate;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
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

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.castleCount = this.castleCount;
            _local_1.id = this.id;
            _local_1.name = this.name;
            _local_1.playerCount = this.playerCount;
            _local_1.rate = this.rate;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function set playerCount(_arg_1:int):void
        {
            var _local_2:Object = this._531131054playerCount;
            if (_local_2 !== _arg_1)
            {
                this._531131054playerCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get rate():int
        {
            return (this._3493088rate);
        }

        [Bindable(event="propertyChange")]
        public function get playerCount():int
        {
            return (this._531131054playerCount);
        }

        public function set castleCount(_arg_1:int):void
        {
            var _local_2:Object = this._764803337castleCount;
            if (_local_2 !== _arg_1)
            {
                this._764803337castleCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleCount", _local_2, _arg_1));
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
        public function get castleCount():int
        {
            return (this._764803337castleCount);
        }


    }
}//package com.evony.common.beans

