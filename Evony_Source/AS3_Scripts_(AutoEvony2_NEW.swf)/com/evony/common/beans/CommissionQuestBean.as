// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.CommissionQuestBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.events.*;
    import flash.events.*;

    public class CommissionQuestBean implements IEventDispatcher 
    {

        private var _600408483isFinish:Boolean;
        private var _908959235isMyIssue:Boolean;
        private var _3373707name:String;
        private var _3575610type:int;
        private var _1313911455timeout:Number;
        private var _747804969position:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1355171569isAccepted:Boolean;
        private var _934326481reward:int;
        private var _1606289880endtime:String;
        private var _3355id:int;
        private var _880905839target:String;
        private var _531131054playerCount:int;

        public function CommissionQuestBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.endtime != null)
                {
                    this.endtime = _arg_1.endtime;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.isAccepted != null)
                {
                    this.isAccepted = _arg_1.isAccepted;
                };
                if (_arg_1.isFinish != null)
                {
                    this.isFinish = _arg_1.isFinish;
                };
                if (_arg_1.isMyIssue != null)
                {
                    this.isMyIssue = _arg_1.isMyIssue;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.playerCount != null)
                {
                    this.playerCount = _arg_1.playerCount;
                };
                if (_arg_1.position != null)
                {
                    this.position = _arg_1.position;
                };
                if (_arg_1.reward != null)
                {
                    this.reward = _arg_1.reward;
                };
                if (_arg_1.target != null)
                {
                    this.target = _arg_1.target;
                };
                if (_arg_1.timeout != null)
                {
                    this.timeout = _arg_1.timeout;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get isMyIssue():Boolean
        {
            return (this._908959235isMyIssue);
        }

        public function set isMyIssue(_arg_1:Boolean):void
        {
            var _local_2:Object = this._908959235isMyIssue;
            if (_local_2 !== _arg_1)
            {
                this._908959235isMyIssue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isMyIssue", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get target():String
        {
            return (this._880905839target);
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
            _local_1.endtime = this.endtime;
            _local_1.id = this.id;
            _local_1.isAccepted = this.isAccepted;
            _local_1.isFinish = this.isFinish;
            _local_1.isMyIssue = this.isMyIssue;
            _local_1.name = this.name;
            _local_1.playerCount = this.playerCount;
            _local_1.position = this.position;
            _local_1.reward = this.reward;
            _local_1.target = this.target;
            _local_1.timeout = this.timeout;
            _local_1.type = this.type;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set target(_arg_1:String):void
        {
            var _local_2:Object = this._880905839target;
            if (_local_2 !== _arg_1)
            {
                this._880905839target = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "target", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get endtime():String
        {
            return (this._1606289880endtime);
        }

        [Bindable(event="propertyChange")]
        public function get position():String
        {
            return (this._747804969position);
        }

        [Bindable(event="propertyChange")]
        public function get playerCount():int
        {
            return (this._531131054playerCount);
        }

        [Bindable(event="propertyChange")]
        public function get reward():int
        {
            return (this._934326481reward);
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
        public function get type():int
        {
            return (this._3575610type);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "endtime = ") + this.endtime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isAccepted = ") + this.isAccepted) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isFinish = ") + this.isFinish) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isMyIssue = ") + this.isMyIssue) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "playerCount = ") + this.playerCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "position = ") + this.position) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "reward = ") + this.reward) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "target = ") + this.target) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "timeout = ") + this.timeout) + "\n"));
            return (_local_2 + (((_arg_1 + "type = ") + this.type) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:CommissionQuestBean):void
        {
            _arg_1.endtime = this.endtime;
            _arg_1.id = this.id;
            _arg_1.isAccepted = this.isAccepted;
            _arg_1.isFinish = this.isFinish;
            _arg_1.isMyIssue = this.isMyIssue;
            _arg_1.name = this.name;
            _arg_1.playerCount = this.playerCount;
            _arg_1.position = this.position;
            _arg_1.reward = this.reward;
            _arg_1.target = this.target;
            _arg_1.timeout = this.timeout;
            _arg_1.type = this.type;
        }

        public function set timeout(_arg_1:Number):void
        {
            var _local_2:Object = this._1313911455timeout;
            if (_local_2 !== _arg_1)
            {
                this._1313911455timeout = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "timeout", _local_2, _arg_1));
            };
        }

        public function set position(_arg_1:String):void
        {
            var _local_2:Object = this._747804969position;
            if (_local_2 !== _arg_1)
            {
                this._747804969position = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "position", _local_2, _arg_1));
            };
        }

        public function set endtime(_arg_1:String):void
        {
            var _local_2:Object = this._1606289880endtime;
            if (_local_2 !== _arg_1)
            {
                this._1606289880endtime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endtime", _local_2, _arg_1));
            };
        }

        public function set playerCount(_arg_1:int):void
        {
            var _local_2:Object = this._531131054playerCount;
            if (_local_2 !== _arg_1)
            {
                this._531131054playerCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isFinish():Boolean
        {
            return (this._600408483isFinish);
        }

        public function set reward(_arg_1:int):void
        {
            var _local_2:Object = this._934326481reward;
            if (_local_2 !== _arg_1)
            {
                this._934326481reward = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reward", _local_2, _arg_1));
            };
        }

        public function set isAccepted(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1355171569isAccepted;
            if (_local_2 !== _arg_1)
            {
                this._1355171569isAccepted = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isAccepted", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get timeout():Number
        {
            return (this._1313911455timeout);
        }

        [Bindable(event="propertyChange")]
        public function get isAccepted():Boolean
        {
            return (this._1355171569isAccepted);
        }

        public function set type(_arg_1:int):void
        {
            var _local_2:Object = this._3575610type;
            if (_local_2 !== _arg_1)
            {
                this._3575610type = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

