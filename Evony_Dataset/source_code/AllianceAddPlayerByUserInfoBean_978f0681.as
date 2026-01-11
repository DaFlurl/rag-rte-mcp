// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AllianceAddPlayerByUserInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class AllianceAddPlayerByUserInfoBean implements IEventDispatcher 
    {

        private var _764803337castleCount:int;
        private var _1198082422inviteTime:Number;
        private var _1276224445prestige:int;
        private var _266666762userName:String;
        private var _3492908rank:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function AllianceAddPlayerByUserInfoBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.castleCount != null)
                {
                    this.castleCount = _arg_1.castleCount;
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
                if (_arg_1.userName != null)
                {
                    this.userName = _arg_1.userName;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get prestige():int
        {
            return (this._1276224445prestige);
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((_arg_1 + "castleCount = ") + this.castleCount) + "\n") + (((_arg_1 + "inviteTime = ") + this.inviteTime) + "\n")) + (((_arg_1 + "prestige = ") + this.prestige) + "\n")) + (((_arg_1 + "rank = ") + this.rank) + "\n")) + (((_arg_1 + "userName = ") + this.userName) + "\n"));
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

        public function set inviteTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1198082422inviteTime;
            if (_local_2 !== _arg_1)
            {
                this._1198082422inviteTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteTime", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:AllianceAddPlayerByUserInfoBean):void
        {
            _arg_1.castleCount = this.castleCount;
            _arg_1.inviteTime = this.inviteTime;
            _arg_1.prestige = this.prestige;
            _arg_1.rank = this.rank;
            _arg_1.userName = this.userName;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
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
            return ({
                "castleCount":this.castleCount,
                "inviteTime":this.inviteTime,
                "prestige":this.prestige,
                "rank":this.rank,
                "userName":this.userName
            });
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

        public function set castleCount(_arg_1:int):void
        {
            var _local_2:Object = this._764803337castleCount;
            if (_local_2 !== _arg_1)
            {
                this._764803337castleCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get inviteTime():Number
        {
            return (this._1198082422inviteTime);
        }

        [Bindable(event="propertyChange")]
        public function get castleCount():int
        {
            return (this._764803337castleCount);
        }

        [Bindable(event="propertyChange")]
        public function get userName():String
        {
            return (this._266666762userName);
        }


    }
}//package com.evony.common.beans

