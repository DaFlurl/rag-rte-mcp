// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.CastleSignInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import mx.events.*;
    import flash.events.*;

    public class CastleSignInfoBean implements IEventDispatcher 
    {

        private var _120x:int;
        private var _3373707name:String;
        private var _121y:int;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function CastleSignInfoBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.x != null)
                {
                    this.x = _arg_1.x;
                };
                if (_arg_1.y != null)
                {
                    this.y = _arg_1.y;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "x = ") + this.x) + "\n"));
            return (_local_2 + (((_arg_1 + "y = ") + this.y) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function copyTo(_arg_1:CastleSignInfoBean):void
        {
            _arg_1.id = this.id;
            _arg_1.name = this.name;
            _arg_1.x = this.x;
            _arg_1.y = this.y;
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
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
            _local_1.id = this.id;
            _local_1.name = this.name;
            _local_1.x = this.x;
            _local_1.y = this.y;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function set x(_arg_1:int):void
        {
            var _local_2:Object = this._120x;
            if (_local_2 !== _arg_1)
            {
                this._120x = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "x", _local_2, _arg_1));
            };
        }

        public function set y(_arg_1:int):void
        {
            var _local_2:Object = this._121y;
            if (_local_2 !== _arg_1)
            {
                this._121y = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "y", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get x():int
        {
            return (this._120x);
        }

        [Bindable(event="propertyChange")]
        public function get y():int
        {
            return (this._121y);
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


    }
}//package com.evony.common.beans

