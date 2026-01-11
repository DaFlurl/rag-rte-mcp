// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.BuildingBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class BuildingBean implements IEventDispatcher 
    {

        private var _1796717668appearance:int;
        private var _1607243192endTime:Number;
        private var _892481550status:int;
        private var _3373707name:String;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3198785help:int;
        private var _2129294769startTime:Number;
        private var _858803723typeId:int;
        private var _1381039140positionId:int;

        public function BuildingBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.appearance != null)
                {
                    this.appearance = _arg_1.appearance;
                };
                if (_arg_1.endTime != null)
                {
                    this.endTime = _arg_1.endTime;
                };
                if (_arg_1.help != null)
                {
                    this.help = _arg_1.help;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.positionId != null)
                {
                    this.positionId = _arg_1.positionId;
                };
                if (_arg_1.startTime != null)
                {
                    this.startTime = _arg_1.startTime;
                };
                if (_arg_1.status != null)
                {
                    this.status = _arg_1.status;
                };
                if (_arg_1.typeId != null)
                {
                    this.typeId = _arg_1.typeId;
                };
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set help(_arg_1:int):void
        {
            var _local_2:Object = this._3198785help;
            if (_local_2 !== _arg_1)
            {
                this._3198785help = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "help", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function set level(_arg_1:int):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
            };
        }

        public function set endTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1607243192endTime;
            if (_local_2 !== _arg_1)
            {
                this._1607243192endTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
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

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.appearance = this.appearance;
            _local_1.endTime = this.endTime;
            _local_1.help = this.help;
            _local_1.level = this.level;
            _local_1.name = this.name;
            _local_1.positionId = this.positionId;
            _local_1.startTime = this.startTime;
            _local_1.status = this.status;
            _local_1.typeId = this.typeId;
            return (_local_1);
        }

        public function set startTime(_arg_1:Number):void
        {
            var _local_2:Object = this._2129294769startTime;
            if (_local_2 !== _arg_1)
            {
                this._2129294769startTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get positionId():int
        {
            return (this._1381039140positionId);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get help():int
        {
            return (this._3198785help);
        }

        [Bindable(event="propertyChange")]
        public function get endTime():Number
        {
            return (this._1607243192endTime);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "appearance = ") + this.appearance) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "endTime = ") + this.endTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "help = ") + this.help) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "positionId = ") + this.positionId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "startTime = ") + this.startTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
            return (_local_2 + (((_arg_1 + "typeId = ") + this.typeId) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set appearance(_arg_1:int):void
        {
            var _local_2:Object = this._1796717668appearance;
            if (_local_2 !== _arg_1)
            {
                this._1796717668appearance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "appearance", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:BuildingBean):void
        {
            _arg_1.appearance = this.appearance;
            _arg_1.endTime = this.endTime;
            _arg_1.help = this.help;
            _arg_1.level = this.level;
            _arg_1.name = this.name;
            _arg_1.positionId = this.positionId;
            _arg_1.startTime = this.startTime;
            _arg_1.status = this.status;
            _arg_1.typeId = this.typeId;
        }

        [Bindable(event="propertyChange")]
        public function get startTime():Number
        {
            return (this._2129294769startTime);
        }

        public function set positionId(_arg_1:int):void
        {
            var _local_2:Object = this._1381039140positionId;
            if (_local_2 !== _arg_1)
            {
                this._1381039140positionId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "positionId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get appearance():int
        {
            return (this._1796717668appearance);
        }

        public function set status(_arg_1:int):void
        {
            var _local_2:Object = this._892481550status;
            if (_local_2 !== _arg_1)
            {
                this._892481550status = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _local_2, _arg_1));
            };
        }

        public function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get status():int
        {
            return (this._892481550status);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }


    }
}//package com.evony.common.beans

