// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.IndexAllianceInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class IndexAllianceInfoBean implements IEventDispatcher 
    {

        private var _3492908rank:int;
        private var _1606004101allianceInfo:String;
        private var _1366188353memberLimit:int;
        private var _190875433creatorName:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1606154441allianceNote:String;
        private var _1358063253memberCount:int;
        private var _1191282484leaderName:String;
        private var _1276224445prestige:int;
        private var _1606140770allianceName:String;

        public function IndexAllianceInfoBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.allianceInfo != null)
                {
                    this.allianceInfo = _arg_1.allianceInfo;
                };
                if (_arg_1.allianceName != null)
                {
                    this.allianceName = _arg_1.allianceName;
                };
                if (_arg_1.allianceNote != null)
                {
                    this.allianceNote = _arg_1.allianceNote;
                };
                if (_arg_1.creatorName != null)
                {
                    this.creatorName = _arg_1.creatorName;
                };
                if (_arg_1.leaderName != null)
                {
                    this.leaderName = _arg_1.leaderName;
                };
                if (_arg_1.memberCount != null)
                {
                    this.memberCount = _arg_1.memberCount;
                };
                if (_arg_1.memberLimit != null)
                {
                    this.memberLimit = _arg_1.memberLimit;
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

        public function set leaderName(_arg_1:String):void
        {
            var _local_2:Object = this._1191282484leaderName;
            if (_local_2 !== _arg_1)
            {
                this._1191282484leaderName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leaderName", _local_2, _arg_1));
            };
        }

        public function set memberLimit(_arg_1:int):void
        {
            var _local_2:Object = this._1366188353memberLimit;
            if (_local_2 !== _arg_1)
            {
                this._1366188353memberLimit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberLimit", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceInfo():String
        {
            return (this._1606004101allianceInfo);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set allianceInfo(_arg_1:String):void
        {
            var _local_2:Object = this._1606004101allianceInfo;
            if (_local_2 !== _arg_1)
            {
                this._1606004101allianceInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInfo", _local_2, _arg_1));
            };
        }

        public function set allianceNote(_arg_1:String):void
        {
            var _local_2:Object = this._1606154441allianceNote;
            if (_local_2 !== _arg_1)
            {
                this._1606154441allianceNote = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceNote", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get memberCount():int
        {
            return (this._1358063253memberCount);
        }

        public function toObject():Object
        {
            return ({
                "allianceInfo":this.allianceInfo,
                "allianceName":this.allianceName,
                "allianceNote":this.allianceNote,
                "creatorName":this.creatorName,
                "leaderName":this.leaderName,
                "memberCount":this.memberCount,
                "memberLimit":this.memberLimit,
                "prestige":this.prestige,
                "rank":this.rank
            });
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

        public function set creatorName(_arg_1:String):void
        {
            var _local_2:Object = this._190875433creatorName;
            if (_local_2 !== _arg_1)
            {
                this._190875433creatorName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "creatorName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get leaderName():String
        {
            return (this._1191282484leaderName);
        }

        [Bindable(event="propertyChange")]
        public function get memberLimit():int
        {
            return (this._1366188353memberLimit);
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

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((((_arg_1 + "allianceInfo = ") + this.allianceInfo) + "\n") + (((_arg_1 + "allianceName = ") + this.allianceName) + "\n")) + (((_arg_1 + "allianceNote = ") + this.allianceNote) + "\n")) + (((_arg_1 + "creatorName = ") + this.creatorName) + "\n")) + (((_arg_1 + "leaderName = ") + this.leaderName) + "\n")) + (((_arg_1 + "memberCount = ") + this.memberCount) + "\n")) + (((_arg_1 + "memberLimit = ") + this.memberLimit) + "\n")) + (((_arg_1 + "prestige = ") + this.prestige) + "\n")) + (((_arg_1 + "rank = ") + this.rank) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:IndexAllianceInfoBean):void
        {
            _arg_1.allianceInfo = this.allianceInfo;
            _arg_1.allianceName = this.allianceName;
            _arg_1.allianceNote = this.allianceNote;
            _arg_1.creatorName = this.creatorName;
            _arg_1.leaderName = this.leaderName;
            _arg_1.memberCount = this.memberCount;
            _arg_1.memberLimit = this.memberLimit;
            _arg_1.prestige = this.prestige;
            _arg_1.rank = this.rank;
        }

        [Bindable(event="propertyChange")]
        public function get creatorName():String
        {
            return (this._190875433creatorName);
        }

        [Bindable(event="propertyChange")]
        public function get allianceNote():String
        {
            return (this._1606154441allianceNote);
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

        [Bindable(event="propertyChange")]
        public function get allianceName():String
        {
            return (this._1606140770allianceName);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

