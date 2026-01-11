// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ResourceBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class ResourceBean implements IEventDispatcher 
    {

        private var _3655341wood:Number;
        private var _109770853stone:Number;
        private var _3148894food:Number;
        private var _3178592gold:Number;
        private var _3241160iron:Number;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ResourceBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.food != null)
                {
                    this.food = _arg_1.food;
                };
                if (_arg_1.gold != null)
                {
                    this.gold = _arg_1.gold;
                };
                if (_arg_1.iron != null)
                {
                    this.iron = _arg_1.iron;
                };
                if (_arg_1.stone != null)
                {
                    this.stone = _arg_1.stone;
                };
                if (_arg_1.wood != null)
                {
                    this.wood = _arg_1.wood;
                };
            };
        }

        public function set gold(_arg_1:Number):void
        {
            var _local_2:Object = this._3178592gold;
            if (_local_2 !== _arg_1)
            {
                this._3178592gold = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gold", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "food = ") + this.food) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "gold = ") + this.gold) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "iron = ") + this.iron) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stone = ") + this.stone) + "\n"));
            return (_local_2 + (((_arg_1 + "wood = ") + this.wood) + "\n"));
        }

        public function set stone(_arg_1:Number):void
        {
            var _local_2:Object = this._109770853stone;
            if (_local_2 !== _arg_1)
            {
                this._109770853stone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stone", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get iron():Number
        {
            return (this._3241160iron);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set wood(_arg_1:Number):void
        {
            var _local_2:Object = this._3655341wood;
            if (_local_2 !== _arg_1)
            {
                this._3655341wood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get food():Number
        {
            return (this._3148894food);
        }

        public function set iron(_arg_1:Number):void
        {
            var _local_2:Object = this._3241160iron;
            if (_local_2 !== _arg_1)
            {
                this._3241160iron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iron", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.food = this.food;
            _local_1.gold = this.gold;
            _local_1.iron = this.iron;
            _local_1.stone = this.stone;
            _local_1.wood = this.wood;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get stone():Number
        {
            return (this._109770853stone);
        }

        public function copyTo(_arg_1:ResourceBean):void
        {
            _arg_1.food = this.food;
            _arg_1.gold = this.gold;
            _arg_1.iron = this.iron;
            _arg_1.stone = this.stone;
            _arg_1.wood = this.wood;
        }

        [Bindable(event="propertyChange")]
        public function get wood():Number
        {
            return (this._3655341wood);
        }

        [Bindable(event="propertyChange")]
        public function get gold():Number
        {
            return (this._3178592gold);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set food(_arg_1:Number):void
        {
            var _local_2:Object = this._3148894food;
            if (_local_2 !== _arg_1)
            {
                this._3148894food = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "food", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

