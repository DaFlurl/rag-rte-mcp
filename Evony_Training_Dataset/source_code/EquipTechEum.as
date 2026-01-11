// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.EquipTechEum

package com.evony.eum
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class EquipTechEum implements IEventDispatcher 
    {

        private var _3373707name:String;
        private var _114831tid:String;
        private var _3079825desc:String;
        private var _1638764086iconURL:String;
        private var _bindingEventDispatcher:EventDispatcher;

        private var _1430684397buildArr:Array = [];
        private var _2116176462itemArr:Array = [];
        private var _1389351630treasureArr:Array = [];

        public function EquipTechEum():void
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
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

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get tid():String
        {
            return (this._114831tid);
        }

        [Bindable(event="propertyChange")]
        public function get desc():String
        {
            return (this._3079825desc);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        [Bindable(event="propertyChange")]
        public function get buildArr():Array
        {
            return (this._1430684397buildArr);
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

        public function set tid(_arg_1:String):void
        {
            var _local_2:Object = this._114831tid;
            if (_local_2 !== _arg_1)
            {
                this._114831tid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tid", _local_2, _arg_1));
            };
        }

        public function set treasureArr(_arg_1:Array):void
        {
            var _local_2:Object = this._1389351630treasureArr;
            if (_local_2 !== _arg_1)
            {
                this._1389351630treasureArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "treasureArr", _local_2, _arg_1));
            };
        }

        public function set buildArr(_arg_1:Array):void
        {
            var _local_2:Object = this._1430684397buildArr;
            if (_local_2 !== _arg_1)
            {
                this._1430684397buildArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildArr", _local_2, _arg_1));
            };
        }

        public function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        public function set iconURL(_arg_1:String):void
        {
            var _local_2:Object = this._1638764086iconURL;
            if (_local_2 !== _arg_1)
            {
                this._1638764086iconURL = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconURL", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemArr():Array
        {
            return (this._2116176462itemArr);
        }

        [Bindable(event="propertyChange")]
        public function get treasureArr():Array
        {
            return (this._1389351630treasureArr);
        }

        [Bindable(event="propertyChange")]
        public function get iconURL():String
        {
            return (this._1638764086iconURL);
        }

        public function set itemArr(_arg_1:Array):void
        {
            var _local_2:Object = this._2116176462itemArr;
            if (_local_2 !== _arg_1)
            {
                this._2116176462itemArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemArr", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.eum

