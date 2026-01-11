// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.QuestTypeBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class QuestTypeBean implements IEventDispatcher 
    {

        private var _600408483isFinish:Boolean;
        private var _351608024version:int;
        private var _989204668recommend:Boolean;
        private var _3373707name:String;
        private var _1081572172mainId:int;
        private var _858803723typeId:int;
        private var _1724546052description:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function QuestTypeBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.description != null)
                {
                    this.description = _arg_1.description;
                };
                if (_arg_1.mainId != null)
                {
                    this.mainId = _arg_1.mainId;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.typeId != null)
                {
                    this.typeId = _arg_1.typeId;
                };
                if (_arg_1.version != null)
                {
                    this.version = _arg_1.version;
                };
                if (_arg_1.isFinish != null)
                {
                    this.isFinish = _arg_1.isFinish;
                };
                if (_arg_1.recommend != null)
                {
                    this.recommend = _arg_1.recommend;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get description():String
        {
            return (this._1724546052description);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "description = ") + this.description) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "mainId = ") + this.mainId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "typeId = ") + this.typeId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "version = ") + this.version) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isFinish = ") + this.isFinish) + "\n"));
            return (_local_2 + (((_arg_1 + "recommend = ") + this.recommend) + "\n"));
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

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:QuestTypeBean):void
        {
            _arg_1.description = this.description;
            _arg_1.mainId = this.mainId;
            _arg_1.name = this.name;
            _arg_1.typeId = this.typeId;
            _arg_1.version = this.version;
            _arg_1.isFinish = this.isFinish;
            _arg_1.recommend = this.recommend;
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

        [Bindable(event="propertyChange")]
        public function get version():int
        {
            return (this._351608024version);
        }

        public function toObject():Object
        {
            return ({
                "description":this.description,
                "mainId":this.mainId,
                "name":this.name,
                "typeId":this.typeId,
                "version":this.version,
                "isFinish":this.isFinish,
                "recommend":this.recommend
            });
        }

        [Bindable(event="propertyChange")]
        public function get isFinish():Boolean
        {
            return (this._600408483isFinish);
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

        public function set mainId(_arg_1:int):void
        {
            var _local_2:Object = this._1081572172mainId;
            if (_local_2 !== _arg_1)
            {
                this._1081572172mainId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mainId", _local_2, _arg_1));
            };
        }

        public function set version(_arg_1:int):void
        {
            var _local_2:Object = this._351608024version;
            if (_local_2 !== _arg_1)
            {
                this._351608024version = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "version", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get mainId():int
        {
            return (this._1081572172mainId);
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }

        public function set recommend(_arg_1:Boolean):void
        {
            var _local_2:Object = this._989204668recommend;
            if (_local_2 !== _arg_1)
            {
                this._989204668recommend = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "recommend", _local_2, _arg_1));
            };
        }

        public function set isFinish(_arg_1:Boolean):void
        {
            var _local_2:Object = this._600408483isFinish;
            if (_local_2 !== _arg_1)
            {
                this._600408483isFinish = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isFinish", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get recommend():Boolean
        {
            return (this._989204668recommend);
        }

        public function set description(_arg_1:String):void
        {
            var _local_2:Object = this._1724546052description;
            if (_local_2 !== _arg_1)
            {
                this._1724546052description = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

