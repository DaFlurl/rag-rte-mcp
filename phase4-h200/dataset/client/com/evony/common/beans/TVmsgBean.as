// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.TVmsgBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class TVmsgBean implements IEventDispatcher 
    {

        private var _3560141time:Number;
        private var _108417msg:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function TVmsgBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.msg != null)
                {
                    this.msg = _arg_1.msg;
                };
                if (_arg_1.time != null)
                {
                    this.time = _arg_1.time;
                };
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get msg():String
        {
            return (this._108417msg);
        }

        public function set msg(_arg_1:String):void
        {
            var _local_2:Object = this._108417msg;
            if (_local_2 !== _arg_1)
            {
                this._108417msg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "msg", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get time():Number
        {
            return (this._3560141time);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:TVmsgBean):void
        {
            _arg_1.msg = this.msg;
            _arg_1.time = this.time;
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

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            return (_local_2 + (((_arg_1 + "time = ") + this.time) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.msg = this.msg;
            _local_1.time = this.time;
            return (_local_1);
        }


    }
}//package com.evony.common.beans

