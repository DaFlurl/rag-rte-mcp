// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.GamblingItemBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class GamblingItemBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _3292052kind:int;
        private var _94851343count:int;
        private var _3355id:String;

        public function GamblingItemBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.count != null)
                {
                    this.count = _arg_1.count;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.kind != null)
                {
                    this.kind = _arg_1.kind;
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
            _local_2 = (_local_2 + (((_arg_1 + "count = ") + this.count) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            return (_local_2 + (((_arg_1 + "kind = ") + this.kind) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get count():int
        {
            return (this._94851343count);
        }

        public function copyTo(_arg_1:GamblingItemBean):void
        {
            _arg_1.count = this.count;
            _arg_1.id = this.id;
            _arg_1.kind = this.kind;
        }

        [Bindable(event="propertyChange")]
        public function get kind():int
        {
            return (this._3292052kind);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.count = this.count;
            _local_1.id = this.id;
            _local_1.kind = this.kind;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():String
        {
            return (this._3355id);
        }

        public function set count(_arg_1:int):void
        {
            var _local_2:Object = this._94851343count;
            if (_local_2 !== _arg_1)
            {
                this._94851343count = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "count", _local_2, _arg_1));
            };
        }

        public function set kind(_arg_1:int):void
        {
            var _local_2:Object = this._3292052kind;
            if (_local_2 !== _arg_1)
            {
                this._3292052kind = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "kind", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set id(_arg_1:String):void
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

