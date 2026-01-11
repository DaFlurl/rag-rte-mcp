// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.UnitAlliance

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class UnitAlliance implements IEventDispatcher 
    {

        private var _913519701aPrestigeCount:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1358063253memberCount:int;
        private var _1191282484leaderName:String;
        private var _99462250honor:int;
        private var _1606140770allianceName:String;
        private var _3492908rank:int;

        public function UnitAlliance(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.aPrestigeCount != null)
                {
                    this.aPrestigeCount = _arg_1.aPrestigeCount;
                };
                if (_arg_1.allianceName != null)
                {
                    this.allianceName = _arg_1.allianceName;
                };
                if (_arg_1.honor != null)
                {
                    this.honor = _arg_1.honor;
                };
                if (_arg_1.leaderName != null)
                {
                    this.leaderName = _arg_1.leaderName;
                };
                if (_arg_1.memberCount != null)
                {
                    this.memberCount = _arg_1.memberCount;
                };
                if (_arg_1.rank != null)
                {
                    this.rank = _arg_1.rank;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((_arg_1 + "aPrestigeCount = ") + this.aPrestigeCount) + "\n") + (((_arg_1 + "allianceName = ") + this.allianceName) + "\n")) + (((_arg_1 + "honor = ") + this.honor) + "\n")) + (((_arg_1 + "leaderName = ") + this.leaderName) + "\n")) + (((_arg_1 + "memberCount = ") + this.memberCount) + "\n")) + (((_arg_1 + "rank = ") + this.rank) + "\n"));
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

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:UnitAlliance):void
        {
            _arg_1.aPrestigeCount = this.aPrestigeCount;
            _arg_1.allianceName = this.allianceName;
            _arg_1.honor = this.honor;
            _arg_1.leaderName = this.leaderName;
            _arg_1.memberCount = this.memberCount;
            _arg_1.rank = this.rank;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set honor(_arg_1:int):void
        {
            var _local_2:Object = this._99462250honor;
            if (_local_2 !== _arg_1)
            {
                this._99462250honor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "honor", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get memberCount():int
        {
            return (this._1358063253memberCount);
        }

        public function set aPrestigeCount(_arg_1:int):void
        {
            var _local_2:Object = this._913519701aPrestigeCount;
            if (_local_2 !== _arg_1)
            {
                this._913519701aPrestigeCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "aPrestigeCount", _local_2, _arg_1));
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
            return ({
                "aPrestigeCount":this.aPrestigeCount,
                "allianceName":this.allianceName,
                "honor":this.honor,
                "leaderName":this.leaderName,
                "memberCount":this.memberCount,
                "rank":this.rank
            });
        }

        [Bindable(event="propertyChange")]
        public function get allianceName():String
        {
            return (this._1606140770allianceName);
        }

        [Bindable(event="propertyChange")]
        public function get honor():int
        {
            return (this._99462250honor);
        }

        [Bindable(event="propertyChange")]
        public function get aPrestigeCount():int
        {
            return (this._913519701aPrestigeCount);
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
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
        public function get leaderName():String
        {
            return (this._1191282484leaderName);
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


    }
}//package com.evony.common.beans

