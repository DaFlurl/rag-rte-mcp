// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.BuffBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class BuffBean implements IEventDispatcher 
    {

        private var _1017134268descName:String;
        private var _1607243192endTime:Number;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _858803723typeId:String;

        public function BuffBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.descName != null)
                {
                    this.descName = _arg_1.descName;
                };
                if (_arg_1.endTime != null)
                {
                    this.endTime = _arg_1.endTime;
                };
                if (_arg_1.typeId != null)
                {
                    this.typeId = _arg_1.typeId;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((_arg_1 + "descName = ") + this.descName) + "\n") + (((_arg_1 + "endTime = ") + this.endTime) + "\n")) + (((_arg_1 + "typeId = ") + this.typeId) + "\n"));
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
        public function get endTime():Number
        {
            return (this._1607243192endTime);
        }

        public function copyTo(_arg_1:BuffBean):void
        {
            _arg_1.descName = this.descName;
            _arg_1.endTime = this.endTime;
            _arg_1.typeId = this.typeId;
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

        public function toObject():Object
        {
            return ({
                "descName":this.descName,
                "endTime":this.endTime,
                "typeId":this.typeId
            });
        }

        public function set typeId(_arg_1:String):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get typeId():String
        {
            return (this._858803723typeId);
        }

        public function set descName(_arg_1:String):void
        {
            var _local_2:Object = this._1017134268descName;
            if (_local_2 !== _arg_1)
            {
                this._1017134268descName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "descName", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get descName():String
        {
            return (this._1017134268descName);
        }


    }
}//package com.evony.common.beans

