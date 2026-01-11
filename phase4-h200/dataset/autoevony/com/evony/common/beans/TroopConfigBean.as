// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.TroopConfigBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class TroopConfigBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _391817972orderList:String;
        private var _3560141time:Number;
        private var _110634834troop:TroopBean;

        public function TroopConfigBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.name != null)
                {
                    this.orderList = _arg_1.name;
                };
                if (_arg_1.time != null)
                {
                    this.time = _arg_1.time;
                };
                if (_arg_1.troop != null)
                {
                    this.troop = new TroopBean(_arg_1.troop);
                };
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((_arg_1 + "name = ") + this.orderList) + "\n") + (((_arg_1 + "time = ") + this.time) + "\n")) + ((this.troop != null) ? this.troop.toDebugString((_arg_1 + "troop.")) : (_arg_1 + "troop = null\n")));
        }

        [Bindable(event="propertyChange")]
        public function get orderList():String
        {
            return (this._391817972orderList);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:TroopConfigBean):void
        {
            _arg_1.orderList = this.orderList;
            _arg_1.time = this.time;
            if (this.troop != null)
            {
                this.troop.copyTo(_arg_1.troop);
            }
            else
            {
                _arg_1.troop = null;
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get troop():TroopBean
        {
            return (this._110634834troop);
        }

        [Bindable(event="propertyChange")]
        public function get time():Number
        {
            return (this._3560141time);
        }

        public function set orderList(_arg_1:String):void
        {
            var _local_2:Object = this._391817972orderList;
            if (_local_2 !== _arg_1)
            {
                this._391817972orderList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "orderList", _local_2, _arg_1));
            };
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
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function toObject():Object
        {
            return ({
                "name":this.orderList,
                "time":this.time,
                "troop":this.troop.toObject()
            });
        }

        public function set troop(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._110634834troop;
            if (_local_2 !== _arg_1)
            {
                this._110634834troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

