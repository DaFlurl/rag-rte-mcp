// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ColonyBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ColonyBean implements IEventDispatcher 
    {

        private var _1607243192endTime:Number;
        private var _1962855648lordName:String;
        private var _892481550status:int;
        private var _554436100relation:int;
        private var _30247582isCanLevy:Boolean;
        private var _1421682026cityName:String;
        private var _747804969position:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _342500292logoUrl:String;
        private var _2129294769startTime:Number;
        private var _3560141time:String;
        private var _35872819castleId:int;
        private var _1276224445prestige:int;
        private var _1606140770allianceName:String;
        private var _1458266657isCanOverview:Boolean;

        public function ColonyBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.allianceName != null)
                {
                    this.allianceName = _arg_1.allianceName;
                };
                if (_arg_1.castleId != null)
                {
                    this.castleId = _arg_1.castleId;
                };
                if (_arg_1.cityName != null)
                {
                    this.cityName = _arg_1.cityName;
                };
                if (_arg_1.endTime != null)
                {
                    this.endTime = _arg_1.endTime;
                };
                if (_arg_1.isCanLevy != null)
                {
                    this.isCanLevy = _arg_1.isCanLevy;
                };
                if (_arg_1.isCanOverview != null)
                {
                    this.isCanOverview = _arg_1.isCanOverview;
                };
                if (_arg_1.logoUrl != null)
                {
                    this.logoUrl = _arg_1.logoUrl;
                };
                if (_arg_1.lordName != null)
                {
                    this.lordName = _arg_1.lordName;
                };
                if (_arg_1.position != null)
                {
                    this.position = _arg_1.position;
                };
                if (_arg_1.prestige != null)
                {
                    this.prestige = _arg_1.prestige;
                };
                if (_arg_1.relation != null)
                {
                    this.relation = _arg_1.relation;
                };
                if (_arg_1.startTime != null)
                {
                    this.startTime = _arg_1.startTime;
                };
                if (_arg_1.status != null)
                {
                    this.status = _arg_1.status;
                };
                if (_arg_1.time != null)
                {
                    this.time = _arg_1.time;
                };
            };
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

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set logoUrl(_arg_1:String):void
        {
            var _local_2:Object = this._342500292logoUrl;
            if (_local_2 !== _arg_1)
            {
                this._342500292logoUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logoUrl", _local_2, _arg_1));
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

        public function toObject():Object
        {
            return ({
                "allianceName":this.allianceName,
                "castleId":this.castleId,
                "cityName":this.cityName,
                "endTime":this.endTime,
                "isCanLevy":this.isCanLevy,
                "isCanOverview":this.isCanOverview,
                "logoUrl":this.logoUrl,
                "lordName":this.lordName,
                "position":this.position,
                ".prestige":this.prestige,
                "relation":this.relation,
                "startTime":this.startTime,
                "status":this.status,
                "time":this.time
            });
        }

        [Bindable(event="propertyChange")]
        public function get cityName():String
        {
            return (this._1421682026cityName);
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
        public function get lordName():String
        {
            return (this._1962855648lordName);
        }

        public function set time(_arg_1:String):void
        {
            var _local_2:Object = this._3560141time;
            if (_local_2 !== _arg_1)
            {
                this._3560141time = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get position():String
        {
            return (this._747804969position);
        }

        public function set cityName(_arg_1:String):void
        {
            var _local_2:Object = this._1421682026cityName;
            if (_local_2 !== _arg_1)
            {
                this._1421682026cityName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get castleId():int
        {
            return (this._35872819castleId);
        }

        public function set isCanOverview(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1458266657isCanOverview;
            if (_local_2 !== _arg_1)
            {
                this._1458266657isCanOverview = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanOverview", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get prestige():int
        {
            return (this._1276224445prestige);
        }

        public function set isCanLevy(_arg_1:Boolean):void
        {
            var _local_2:Object = this._30247582isCanLevy;
            if (_local_2 !== _arg_1)
            {
                this._30247582isCanLevy = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanLevy", _local_2, _arg_1));
            };
        }

        public function set lordName(_arg_1:String):void
        {
            var _local_2:Object = this._1962855648lordName;
            if (_local_2 !== _arg_1)
            {
                this._1962855648lordName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lordName", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((((((((((_arg_1 + "allianceName = ") + this.allianceName) + "\n") + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + (((_arg_1 + "cityName = ") + this.cityName) + "\n")) + (((_arg_1 + "endTime = ") + this.endTime) + "\n")) + (((_arg_1 + "isCanLevy = ") + this.isCanLevy) + "\n")) + (((_arg_1 + "isCanOverview = ") + this.isCanOverview) + "\n")) + (((_arg_1 + "logoUrl = ") + this.logoUrl) + "\n")) + (((_arg_1 + "lordName = ") + this.lordName) + "\n")) + (((_arg_1 + "position = ") + this.position) + "\n")) + (((_arg_1 + "prestige = ") + this.prestige) + "\n")) + (((_arg_1 + "relation = ") + this.relation) + "\n")) + (((_arg_1 + "startTime = ") + this.startTime) + "\n")) + (((_arg_1 + "status = ") + this.status) + "\n")) + (((_arg_1 + "time = ") + this.time) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get logoUrl():String
        {
            return (this._342500292logoUrl);
        }

        [Bindable(event="propertyChange")]
        public function get time():String
        {
            return (this._3560141time);
        }

        [Bindable(event="propertyChange")]
        public function get endTime():Number
        {
            return (this._1607243192endTime);
        }

        public function copyTo(_arg_1:ColonyBean):void
        {
            _arg_1.allianceName = this.allianceName;
            _arg_1.castleId = this.castleId;
            _arg_1.cityName = this.cityName;
            _arg_1.endTime = this.endTime;
            _arg_1.isCanLevy = this.isCanLevy;
            _arg_1.isCanOverview = this.isCanOverview;
            _arg_1.logoUrl = this.logoUrl;
            _arg_1.lordName = this.lordName;
            _arg_1.position = this.position;
            _arg_1.prestige = this.prestige;
            _arg_1.relation = this.relation;
            _arg_1.startTime = this.startTime;
            _arg_1.status = this.status;
            _arg_1.time = this.time;
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

        [Bindable(event="propertyChange")]
        public function get startTime():Number
        {
            return (this._2129294769startTime);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get isCanOverview():Boolean
        {
            return (this._1458266657isCanOverview);
        }

        [Bindable(event="propertyChange")]
        public function get isCanLevy():Boolean
        {
            return (this._30247582isCanLevy);
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

        public function set castleId(_arg_1:int):void
        {
            var _local_2:Object = this._35872819castleId;
            if (_local_2 !== _arg_1)
            {
                this._35872819castleId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceName():String
        {
            return (this._1606140770allianceName);
        }

        [Bindable(event="propertyChange")]
        public function get status():int
        {
            return (this._892481550status);
        }

        public function set relation(_arg_1:int):void
        {
            var _local_2:Object = this._554436100relation;
            if (_local_2 !== _arg_1)
            {
                this._554436100relation = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "relation", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get relation():int
        {
            return (this._554436100relation);
        }


    }
}//package com.evony.common.beans

