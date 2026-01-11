// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.PlayerDeclaredWarBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class PlayerDeclaredWarBean implements IEventDispatcher 
    {

        private var _1607243192endTime:Number;
        private var _892481550status:int;
        private var _2129294769startTime:Number;
        private var _2095657228playerName:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function PlayerDeclaredWarBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.endTime != null)
                {
                    this.endTime = _arg_1.endTime;
                };
                if (_arg_1.playerName != null)
                {
                    this.playerName = _arg_1.playerName;
                };
                if (_arg_1.startTime != null)
                {
                    this.startTime = _arg_1.startTime;
                };
                if (_arg_1.status != null)
                {
                    this.status = _arg_1.status;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "endTime = ") + this.endTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "playerName = ") + this.playerName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "startTime = ") + this.startTime) + "\n"));
            return (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
        }

        [Bindable(event="propertyChange")]
        public function get playerName():String
        {
            return (this._2095657228playerName);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get endTime():Number
        {
            return (this._1607243192endTime);
        }

        public function copyTo(_arg_1:PlayerDeclaredWarBean):void
        {
            _arg_1.endTime = this.endTime;
            _arg_1.playerName = this.playerName;
            _arg_1.startTime = this.startTime;
            _arg_1.status = this.status;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get startTime():Number
        {
            return (this._2129294769startTime);
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

        public function set playerName(_arg_1:String):void
        {
            var _local_2:Object = this._2095657228playerName;
            if (_local_2 !== _arg_1)
            {
                this._2095657228playerName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerName", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.endTime = this.endTime;
            _local_1.playerName = this.playerName;
            _local_1.startTime = this.startTime;
            _local_1.status = this.status;
            return (_local_1);
        }

        public function set startTime(_arg_1:Number):void
        {
            var _local_2:Object = this._2129294769startTime;
            if (_local_2 !== _arg_1)
            {
                this._2129294769startTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startTime", _local_2, _arg_1));
            };
        }

        public function set status(_arg_1:int):void
        {
            var _local_2:Object = this._892481550status;
            if (_local_2 !== _arg_1)
            {
                this._892481550status = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get status():int
        {
            return (this._892481550status);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

