// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.QuestBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import mx.collections.ArrayCollection;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.CommonUtil;

    public class QuestBean implements IEventDispatcher 
    {

        private var _1081415738manual:String;
        private var _600408483isFinish:Boolean;
        private var _3373707name:String;
        private var _351608024version:int;
        private var _1179387200islast:Boolean;
        private var _655126941questId:int;
        private var _1180608678isCard:Boolean;
        private var _328471159targetsArray:ArrayCollection;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _93223517award:String;
        private var _1724546052description:String;
        private var _989204668recommend:Boolean;

        public function QuestBean(_arg_1:Object=null)
        {
            var _local_2:QuestTargetBean;
            var _local_3:int;
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this.targetsArray = new ArrayCollection();
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.award != null)
                {
                    this.award = _arg_1.award;
                };
                if (_arg_1.description != null)
                {
                    this.description = _arg_1.description;
                };
                if (_arg_1.manual != null)
                {
                    this.manual = _arg_1.manual;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.questId != null)
                {
                    this.questId = _arg_1.questId;
                };
                if (_arg_1.version != null)
                {
                    this.version = _arg_1.version;
                };
                if (_arg_1.isCard != null)
                {
                    this.isCard = _arg_1.isCard;
                };
                if (_arg_1.isFinish != null)
                {
                    this.isFinish = _arg_1.isFinish;
                };
                if (_arg_1.islast != null)
                {
                    this.islast = _arg_1.islast;
                };
                if (_arg_1.recommend != null)
                {
                    this.recommend = _arg_1.recommend;
                };
                if (_arg_1.targets)
                {
                    _local_2 = null;
                    _local_3 = 0;
                    while (_local_3 < _arg_1.targets.length)
                    {
                        _local_2 = new QuestTargetBean(_arg_1.targets[_local_3]);
                        this.targetsArray.addItem(_local_2);
                        _local_3++;
                    };
                };
            };
        }

        public function set islast(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1179387200islast;
            if (_local_2 !== _arg_1)
            {
                this._1179387200islast = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "islast", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function set manual(_arg_1:String):void
        {
            var _local_2:Object = this._1081415738manual;
            if (_local_2 !== _arg_1)
            {
                this._1081415738manual = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "manual", _local_2, _arg_1));
            };
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
            return ({
                "award":this.award,
                "description":this.description,
                "manual":this.manual,
                "name":this.name,
                "questId":this.questId,
                "version":this.version,
                "isCard":this.isCard,
                "isFinish":this.isFinish,
                "islast":this.islast,
                "recommend":this.recommend
            });
        }

        [Bindable(event="propertyChange")]
        public function get questId():int
        {
            return (this._655126941questId);
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

        public function set isCard(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180608678isCard;
            if (_local_2 !== _arg_1)
            {
                this._1180608678isCard = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCard", _local_2, _arg_1));
            };
        }

        public function set questId(_arg_1:int):void
        {
            var _local_2:Object = this._655126941questId;
            if (_local_2 !== _arg_1)
            {
                this._655126941questId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get recommend():Boolean
        {
            return (this._989204668recommend);
        }

        public function setTargets(_arg_1:QuestTargetBean, _arg_2:int):void
        {
            this.targetsArray[_arg_2] = _arg_1;
        }

        public function set award(_arg_1:String):void
        {
            var _local_2:Object = this._93223517award;
            if (_local_2 !== _arg_1)
            {
                this._93223517award = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "award", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get manual():String
        {
            return (this._1081415738manual);
        }

        [Bindable(event="propertyChange")]
        public function get islast():Boolean
        {
            return (this._1179387200islast);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = ((((((((((((_arg_1 + "award = ") + this.award) + "\n") + (((_arg_1 + "description = ") + this.description) + "\n")) + (((_arg_1 + "manual = ") + this.manual) + "\n")) + (((_arg_1 + "name = ") + this.name) + "\n")) + (((_arg_1 + "questId = ") + this.questId) + "\n")) + (((_arg_1 + "version = ") + this.version) + "\n")) + (((_arg_1 + "isCard = ") + this.isCard) + "\n")) + (((_arg_1 + "isFinish = ") + this.isFinish) + "\n")) + (((_arg_1 + "islast = ") + this.islast) + "\n")) + (((_arg_1 + "recommend = ") + this.recommend) + "\n"));
            var _local_3:int;
            while (_local_3 < this.targetsArray.length)
            {
                _local_2 = (_local_2 + this.getTargets(_local_3).toDebugString((((_arg_1 + "targets[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getTargets(_arg_1:int):QuestTargetBean
        {
            return (this.targetsArray[_arg_1] as QuestTargetBean);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:QuestBean):void
        {
            _arg_1.award = this.award;
            _arg_1.description = this.description;
            _arg_1.manual = this.manual;
            _arg_1.name = this.name;
            _arg_1.questId = this.questId;
            _arg_1.version = this.version;
            _arg_1.isCard = this.isCard;
            _arg_1.isFinish = this.isFinish;
            _arg_1.islast = this.islast;
            _arg_1.recommend = this.recommend;
            CommonUtil.arrayCopy(this.targetsArray, _arg_1.targetsArray);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
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
        public function get version():int
        {
            return (this._351608024version);
        }

        [Bindable(event="propertyChange")]
        public function get isCard():Boolean
        {
            return (this._1180608678isCard);
        }

        [Bindable(event="propertyChange")]
        public function get isFinish():Boolean
        {
            return (this._600408483isFinish);
        }

        [Bindable(event="propertyChange")]
        public function get award():String
        {
            return (this._93223517award);
        }

        public function set targetsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._328471159targetsArray;
            if (_local_2 !== _arg_1)
            {
                this._328471159targetsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetsArray", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get targetsArray():ArrayCollection
        {
            return (this._328471159targetsArray);
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

        [Bindable(event="propertyChange")]
        public function get description():String
        {
            return (this._1724546052description);
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


    }
}//package com.evony.common.beans

