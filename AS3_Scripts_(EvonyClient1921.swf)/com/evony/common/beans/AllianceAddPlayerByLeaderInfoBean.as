// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AllianceAddPlayerByLeaderInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class AllianceAddPlayerByLeaderInfoBean implements IEventDispatcher 
    {

        private var _1358063253memberCount:int;
        private var _1276224445prestige:int;
        private var _1606140770allianceName:String;
        private var _3492908rank:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function AllianceAddPlayerByLeaderInfoBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.allianceName != null)
                {
                    this.allianceName = _arg_1.allianceName;
                };
                if (_arg_1.memberCount != null)
                {
                    this.memberCount = _arg_1.memberCount;
                };
                if (_arg_1.prestige != null)
                {
                    this.prestige = _arg_1.prestige;
                };
                if (_arg_1.rank != null)
                {
                    this.rank = _arg_1.rank;
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

        public function set allianceName(_arg_1:String):void
        {
            var _local_2:Object = this._1606140770allianceName;
            if (_local_2 !== _arg_1)
            {
                this._1606140770allianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceName", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "allianceName = ") + this.allianceName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "memberCount = ") + this.memberCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "prestige = ") + this.prestige) + "\n"));
            return (_local_2 + (((_arg_1 + "rank = ") + this.rank) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function copyTo(_arg_1:AllianceAddPlayerByLeaderInfoBean):void
        {
            _arg_1.allianceName = this.allianceName;
            _arg_1.memberCount = this.memberCount;
            _arg_1.prestige = this.prestige;
            _arg_1.rank = this.rank;
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
            _local_1.allianceName = this.allianceName;
            _local_1.memberCount = this.memberCount;
            _local_1.prestige = this.prestige;
            _local_1.rank = this.rank;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get memberCount():int
        {
            return (this._1358063253memberCount);
        }

        [Bindable(event="propertyChange")]
        public function get allianceName():String
        {
            return (this._1606140770allianceName);
        }

        public function set memberCount(_arg_1:int):void
        {
            var _local_2:Object = this._1358063253memberCount;
            if (_local_2 !== _arg_1)
            {
                this._1358063253memberCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }


    }
}//package com.evony.common.beans

