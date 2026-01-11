// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.BuildingQueueBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.events.*;
    import flash.events.*;

    public class BuildingQueueBean implements IEventDispatcher 
    {

        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1739445269queueType:int;
        private var _3373707name:String;
        private var _892481550status:int;
        private var _858803723typeId:int;
        private var _1381039140positionId:int;
        private var _102865796level:int;
        private var _424687558costTime:Number;

        public function BuildingQueueBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.costTime != null)
                {
                    this.costTime = _arg_1.costTime;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
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
                if (_arg_1.queueType != null)
                {
                    this.queueType = _arg_1.queueType;
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

        public function set costTime(_arg_1:Number):void
        {
            var _local_2:Object = this._424687558costTime;
            if (_local_2 !== _arg_1)
            {
                this._424687558costTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "costTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
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

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "costTime = ") + this.costTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "positionId = ") + this.positionId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "queueType = ") + this.queueType) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
            return (_local_2 + (((_arg_1 + "typeId = ") + this.typeId) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
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

        public function copyTo(_arg_1:BuildingQueueBean):void
        {
            _arg_1.costTime = this.costTime;
            _arg_1.id = this.id;
            _arg_1.level = this.level;
            _arg_1.name = this.name;
            _arg_1.positionId = this.positionId;
            _arg_1.queueType = this.queueType;
            _arg_1.status = this.status;
            _arg_1.typeId = this.typeId;
        }

        [Bindable(event="propertyChange")]
        public function get costTime():Number
        {
            return (this._424687558costTime);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set queueType(_arg_1:int):void
        {
            var _local_2:Object = this._1739445269queueType;
            if (_local_2 !== _arg_1)
            {
                this._1739445269queueType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueType", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.costTime = this.costTime;
            _local_1.id = this.id;
            _local_1.level = this.level;
            _local_1.name = this.name;
            _local_1.positionId = this.positionId;
            _local_1.queueType = this.queueType;
            _local_1.status = this.status;
            _local_1.typeId = this.typeId;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
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

        public function set status(_arg_1:int):void
        {
            var _local_2:Object = this._892481550status;
            if (_local_2 !== _arg_1)
            {
                this._892481550status = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get queueType():int
        {
            return (this._1739445269queueType);
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

        public function set id(_arg_1:int):void
        {
            var _local_2:Object = this._3355id;
            if (_local_2 !== _arg_1)
            {
                this._3355id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get positionId():int
        {
            return (this._1381039140positionId);
        }


    }
}//package com.evony.common.beans

