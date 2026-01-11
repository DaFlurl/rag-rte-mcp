// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.SetShowInfro

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class SetShowInfro implements IEventDispatcher 
    {

        private var _295839282selectshowheroid:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function SetShowInfro(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.selectshowheroid != null)
                {
                    this.selectshowheroid = _arg_1.selectshowheroid;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
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
            return (_local_2 + (((_arg_1 + "selectshowheroid = ") + this.selectshowheroid) + "\n"));
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
        public function get selectshowheroid():int
        {
            return (this._295839282selectshowheroid);
        }

        public function copyTo(_arg_1:SetShowInfro):void
        {
            _arg_1.selectshowheroid = this.selectshowheroid;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.selectshowheroid = this.selectshowheroid;
            return (_local_1);
        }

        public function set selectshowheroid(_arg_1:int):void
        {
            var _local_2:Object = this._295839282selectshowheroid;
            if (_local_2 !== _arg_1)
            {
                this._295839282selectshowheroid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectshowheroid", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

