// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AllianceEvent

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.events.*;
    import flash.events.*;

    public class AllianceEvent implements IEventDispatcher 
    {

        private var _3560141time:Number;
        private var _31228997eventName:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function AllianceEvent(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.eventName != null)
                {
                    this.eventName = _arg_1.eventName;
                };
                if (_arg_1.time != null)
                {
                    this.time = _arg_1.time;
                };
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.eventName = this.eventName;
            _local_1.time = this.time;
            return (_local_1);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get eventName():String
        {
            return (this._31228997eventName);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set eventName(_arg_1:String):void
        {
            var _local_2:Object = this._31228997eventName;
            if (_local_2 !== _arg_1)
            {
                this._31228997eventName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eventName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get time():Number
        {
            return (this._3560141time);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:AllianceEvent):void
        {
            _arg_1.eventName = this.eventName;
            _arg_1.time = this.time;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "eventName = ") + this.eventName) + "\n"));
            return (_local_2 + (((_arg_1 + "time = ") + this.time) + "\n"));
        }

        public function set time(_arg_1:Number):void
        {
            var _local_2:Object = this._3560141time;
            if (_local_2 !== _arg_1)
            {
                this._3560141time = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

