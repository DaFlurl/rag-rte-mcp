// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.EffortListBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class EffortListBean implements IEventDispatcher 
    {

        private var _275227512effortListInfo:String;
        private var _873324063effortTypeid:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function EffortListBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.effortListInfo != null)
                {
                    this.effortListInfo = _arg_1.effortListInfo;
                };
                if (_arg_1.effortTypeid != null)
                {
                    this.effortTypeid = _arg_1.effortTypeid;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get effortTypeid():int
        {
            return (this._873324063effortTypeid);
        }

        public function set effortTypeid(_arg_1:int):void
        {
            var _local_2:Object = this._873324063effortTypeid;
            if (_local_2 !== _arg_1)
            {
                this._873324063effortTypeid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effortTypeid", _local_2, _arg_1));
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

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "effortListInfo = ") + this.effortListInfo) + "\n"));
            return (_local_2 + (((_arg_1 + "effortTypeid = ") + this.effortTypeid) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:EffortListBean):void
        {
            _arg_1.effortListInfo = this.effortListInfo;
            _arg_1.effortTypeid = this.effortTypeid;
        }

        public function set effortListInfo(_arg_1:String):void
        {
            var _local_2:Object = this._275227512effortListInfo;
            if (_local_2 !== _arg_1)
            {
                this._275227512effortListInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effortListInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get effortListInfo():String
        {
            return (this._275227512effortListInfo);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.effortListInfo = this.effortListInfo;
            _local_1.effortTypeid = this.effortTypeid;
            return (_local_1);
        }


    }
}//package com.evony.common.beans

