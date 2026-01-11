// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.data.NewArmyEventData

package com.evony.data
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class NewArmyEventData implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _100474199isNpc:Boolean;
        private var _120x:int;
        private var _1383259878missionType:int;
        private var _121y:int;

        public function NewArmyEventData()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set missionType(_arg_1:int):void
        {
            var _local_2:Object = this._1383259878missionType;
            if (_local_2 !== _arg_1)
            {
                this._1383259878missionType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "missionType", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get isNpc():Boolean
        {
            return (this._100474199isNpc);
        }

        [Bindable(event="propertyChange")]
        public function get missionType():int
        {
            return (this._1383259878missionType);
        }

        public function set isNpc(_arg_1:Boolean):void
        {
            var _local_2:Object = this._100474199isNpc;
            if (_local_2 !== _arg_1)
            {
                this._100474199isNpc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isNpc", _local_2, _arg_1));
            };
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

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.data

