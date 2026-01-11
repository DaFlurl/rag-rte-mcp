// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.ProduceBuildingResourceDataUnit

package com.evony.util
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class ProduceBuildingResourceDataUnit implements IEventDispatcher 
    {

        private var _1854702450needAmount:Number;
        private var _1721449265currentAmount:Number;
        private var _676507419typeName:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ProduceBuildingResourceDataUnit()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set currentAmount(_arg_1:Number):void
        {
            var _local_2:Object = this._1721449265currentAmount;
            if (_local_2 !== _arg_1)
            {
                this._1721449265currentAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentAmount", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get typeName():String
        {
            return (this._676507419typeName);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set typeName(_arg_1:String):void
        {
            var _local_2:Object = this._676507419typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get needAmount():Number
        {
            return (this._1854702450needAmount);
        }

        [Bindable(event="propertyChange")]
        public function get currentAmount():Number
        {
            return (this._1721449265currentAmount);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set needAmount(_arg_1:Number):void
        {
            var _local_2:Object = this._1854702450needAmount;
            if (_local_2 !== _arg_1)
            {
                this._1854702450needAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needAmount", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.util

