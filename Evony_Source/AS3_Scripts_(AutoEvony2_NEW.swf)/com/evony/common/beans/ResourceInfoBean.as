// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ResourceInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ResourceInfoBean implements IEventDispatcher 
    {

        private var _996698880workPeople:int;
        private var _1913146946increaseRate:Number;
        private var _2133060262storeRercent:int;
        private var _107876max:int;
        private var _1413853096amount:Number;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ResourceInfoBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.amount != null)
                {
                    this.amount = _arg_1.amount;
                };
                if (_arg_1.increaseRate != null)
                {
                    this.increaseRate = _arg_1.increaseRate;
                };
                if (_arg_1.max != null)
                {
                    this.max = _arg_1.max;
                };
                if (_arg_1.storeRercent != null)
                {
                    this.storeRercent = _arg_1.storeRercent;
                };
                if (_arg_1.workPeople != null)
                {
                    this.workPeople = _arg_1.workPeople;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get workPeople():int
        {
            return (this._996698880workPeople);
        }

        [Bindable(event="propertyChange")]
        public function get increaseRate():Number
        {
            return (this._1913146946increaseRate);
        }

        public function set increaseRate(_arg_1:Number):void
        {
            var _local_2:Object = this._1913146946increaseRate;
            if (_local_2 !== _arg_1)
            {
                this._1913146946increaseRate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "increaseRate", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set workPeople(_arg_1:int):void
        {
            var _local_2:Object = this._996698880workPeople;
            if (_local_2 !== _arg_1)
            {
                this._996698880workPeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "workPeople", _local_2, _arg_1));
            };
        }

        public function set max(_arg_1:int):void
        {
            var _local_2:Object = this._107876max;
            if (_local_2 !== _arg_1)
            {
                this._107876max = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "max", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((_arg_1 + "amount = ") + this.amount) + "\n") + (((_arg_1 + "increaseRate = ") + this.increaseRate) + "\n")) + (((_arg_1 + "max = ") + this.max) + "\n")) + (((_arg_1 + "storeRercent = ") + this.storeRercent) + "\n")) + (((_arg_1 + "workPeople = ") + this.workPeople) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:ResourceInfoBean):void
        {
            _arg_1.amount = this.amount;
            _arg_1.increaseRate = this.increaseRate;
            _arg_1.max = this.max;
            _arg_1.storeRercent = this.storeRercent;
            _arg_1.workPeople = this.workPeople;
        }

        [Bindable(event="propertyChange")]
        public function get amount():Number
        {
            return (this._1413853096amount);
        }

        public function toObject():Object
        {
            return ({
                "amount":this.amount,
                "increaseRate":this.increaseRate,
                "max":this.max,
                "storeRercent":this.storeRercent,
                "workPeople":this.workPeople
            });
        }

        public function set storeRercent(_arg_1:int):void
        {
            var _local_2:Object = this._2133060262storeRercent;
            if (_local_2 !== _arg_1)
            {
                this._2133060262storeRercent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storeRercent", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get max():int
        {
            return (this._107876max);
        }

        public function set amount(_arg_1:Number):void
        {
            var _local_2:Object = this._1413853096amount;
            if (_local_2 !== _arg_1)
            {
                this._1413853096amount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amount", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get storeRercent():int
        {
            return (this._2133060262storeRercent);
        }


    }
}//package com.evony.common.beans

