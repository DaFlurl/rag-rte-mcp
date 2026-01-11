// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.FortificationsBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class FortificationsBean implements IEventDispatcher 
    {

        private var _3568429trap:int;
        private var _1739874176arrowTower:int;
        private var _518185888rockfall:int;
        private var _226523540rollingLogs:int;
        private var _1424430018abatis:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function FortificationsBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.abatis != null)
                {
                    this.abatis = _arg_1.abatis;
                };
                if (_arg_1.arrowTower != null)
                {
                    this.arrowTower = _arg_1.arrowTower;
                };
                if (_arg_1.rockfall != null)
                {
                    this.rockfall = _arg_1.rockfall;
                };
                if (_arg_1.rollingLogs != null)
                {
                    this.rollingLogs = _arg_1.rollingLogs;
                };
                if (_arg_1.trap != null)
                {
                    this.trap = _arg_1.trap;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get arrowTower():int
        {
            return (this._1739874176arrowTower);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "abatis = ") + this.abatis) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "arrowTower = ") + this.arrowTower) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "rockfall = ") + this.rockfall) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "rollingLogs = ") + this.rollingLogs) + "\n"));
            return (_local_2 + (((_arg_1 + "trap = ") + this.trap) + "\n"));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set rockfall(_arg_1:int):void
        {
            var _local_2:Object = this._518185888rockfall;
            if (_local_2 !== _arg_1)
            {
                this._518185888rockfall = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rockfall", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get rollingLogs():int
        {
            return (this._226523540rollingLogs);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function copyTo(_arg_1:FortificationsBean):void
        {
            _arg_1.abatis = this.abatis;
            _arg_1.arrowTower = this.arrowTower;
            _arg_1.rockfall = this.rockfall;
            _arg_1.rollingLogs = this.rollingLogs;
            _arg_1.trap = this.trap;
        }

        public function set arrowTower(_arg_1:int):void
        {
            var _local_2:Object = this._1739874176arrowTower;
            if (_local_2 !== _arg_1)
            {
                this._1739874176arrowTower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "arrowTower", _local_2, _arg_1));
            };
        }

        public function set trap(_arg_1:int):void
        {
            var _local_2:Object = this._3568429trap;
            if (_local_2 !== _arg_1)
            {
                this._3568429trap = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "trap", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get rockfall():int
        {
            return (this._518185888rockfall);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.abatis = this.abatis;
            _local_1.arrowTower = this.arrowTower;
            _local_1.rockfall = this.rockfall;
            _local_1.rollingLogs = this.rollingLogs;
            _local_1.trap = this.trap;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get trap():int
        {
            return (this._3568429trap);
        }

        public function set rollingLogs(_arg_1:int):void
        {
            var _local_2:Object = this._226523540rollingLogs;
            if (_local_2 !== _arg_1)
            {
                this._226523540rollingLogs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rollingLogs", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set abatis(_arg_1:int):void
        {
            var _local_2:Object = this._1424430018abatis;
            if (_local_2 !== _arg_1)
            {
                this._1424430018abatis = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "abatis", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get abatis():int
        {
            return (this._1424430018abatis);
        }


    }
}//package com.evony.common.beans

