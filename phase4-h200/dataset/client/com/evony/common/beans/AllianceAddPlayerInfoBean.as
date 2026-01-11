// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AllianceAddPlayerInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class AllianceAddPlayerInfoBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _109757585state:String;
        private var _1198082422inviteTime:Number;
        private var _1276224445prestige:int;
        private var _266666762userName:String;
        private var _187927486invitePerson:String;
        private var _3492908rank:int;

        public function AllianceAddPlayerInfoBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.invitePerson != null)
                {
                    this.invitePerson = _arg_1.invitePerson;
                };
                if (_arg_1.inviteTime != null)
                {
                    this.inviteTime = _arg_1.inviteTime;
                };
                if (_arg_1.prestige != null)
                {
                    this.prestige = _arg_1.prestige;
                };
                if (_arg_1.rank != null)
                {
                    this.rank = _arg_1.rank;
                };
                if (_arg_1.state != null)
                {
                    this.state = _arg_1.state;
                };
                if (_arg_1.userName != null)
                {
                    this.userName = _arg_1.userName;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get prestige():int
        {
            return (this._1276224445prestige);
        }

        public function set userName(_arg_1:String):void
        {
            var _local_2:Object = this._266666762userName;
            if (_local_2 !== _arg_1)
            {
                this._266666762userName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userName", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "invitePerson = ") + this.invitePerson) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "inviteTime = ") + this.inviteTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "prestige = ") + this.prestige) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "rank = ") + this.rank) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "state = ") + this.state) + "\n"));
            return (_local_2 + (((_arg_1 + "userName = ") + this.userName) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function copyTo(_arg_1:AllianceAddPlayerInfoBean):void
        {
            _arg_1.invitePerson = this.invitePerson;
            _arg_1.inviteTime = this.inviteTime;
            _arg_1.prestige = this.prestige;
            _arg_1.rank = this.rank;
            _arg_1.state = this.state;
            _arg_1.userName = this.userName;
        }

        [Bindable(event="propertyChange")]
        public function get state():String
        {
            return (this._109757585state);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set prestige(_arg_1:int):void
        {
            var _local_2:Object = this._1276224445prestige;
            if (_local_2 !== _arg_1)
            {
                this._1276224445prestige = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set rank(_arg_1:int):void
        {
            var _local_2:Object = this._3492908rank;
            if (_local_2 !== _arg_1)
            {
                this._3492908rank = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rank", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.invitePerson = this.invitePerson;
            _local_1.inviteTime = this.inviteTime;
            _local_1.prestige = this.prestige;
            _local_1.rank = this.rank;
            _local_1.state = this.state;
            _local_1.userName = this.userName;
            return (_local_1);
        }

        public function set state(_arg_1:String):void
        {
            var _local_2:Object = this._109757585state;
            if (_local_2 !== _arg_1)
            {
                this._109757585state = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "state", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }

        [Bindable(event="propertyChange")]
        public function get inviteTime():Number
        {
            return (this._1198082422inviteTime);
        }

        public function set inviteTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1198082422inviteTime;
            if (_local_2 !== _arg_1)
            {
                this._1198082422inviteTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteTime", _local_2, _arg_1));
            };
        }

        public function set invitePerson(_arg_1:String):void
        {
            var _local_2:Object = this._187927486invitePerson;
            if (_local_2 !== _arg_1)
            {
                this._187927486invitePerson = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "invitePerson", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get userName():String
        {
            return (this._266666762userName);
        }

        [Bindable(event="propertyChange")]
        public function get invitePerson():String
        {
            return (this._187927486invitePerson);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }


    }
}//package com.evony.common.beans

