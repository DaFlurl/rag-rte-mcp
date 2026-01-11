// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.RankAllianceBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class RankAllianceBean implements IEventDispatcher 
    {

        private var _3373707name:String;
        private var _1077769574member:int;
        private var _99462250honor:Number;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3076014date:String;
        private var _1724546052description:String;
        private var _1276224445prestige:Number;
        private var _2095657228playerName:String;
        private var _477166943createrName:String;
        private var _3053931city:int;
        private var _3492908rank:int;

        public function RankAllianceBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.city != null)
                {
                    this.city = _arg_1.city;
                };
                if (_arg_1.createrName != null)
                {
                    this.createrName = _arg_1.createrName;
                };
                if (_arg_1.date != null)
                {
                    this.date = _arg_1.date;
                };
                if (_arg_1.description != null)
                {
                    this.description = _arg_1.description;
                };
                if (_arg_1.honor != null)
                {
                    this.honor = _arg_1.honor;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.member != null)
                {
                    this.member = _arg_1.member;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.playerName != null)
                {
                    this.playerName = _arg_1.playerName;
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

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set prestige(_arg_1:Number):void
        {
            var _local_2:Object = this._1276224445prestige;
            if (_local_2 !== _arg_1)
            {
                this._1276224445prestige = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _local_2, _arg_1));
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
        public function get playerName():String
        {
            return (this._2095657228playerName);
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

        public function set playerName(_arg_1:String):void
        {
            var _local_2:Object = this._2095657228playerName;
            if (_local_2 !== _arg_1)
            {
                this._2095657228playerName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerName", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            return ({
                "city":this.city,
                "createrName":this.createrName,
                "date":this.date,
                "description":this.description,
                "honor":this.honor,
                "id":this.id,
                "member":this.member,
                "name":this.name,
                "playerName":this.playerName,
                "prestige":this.prestige,
                "rank":this.rank
            });
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        [Bindable(event="propertyChange")]
        public function get member():int
        {
            return (this._1077769574member);
        }

        [Bindable(event="propertyChange")]
        public function get createrName():String
        {
            return (this._477166943createrName);
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }

        [Bindable(event="propertyChange")]
        public function get date():String
        {
            return (this._3076014date);
        }

        public function set member(_arg_1:int):void
        {
            var _local_2:Object = this._1077769574member;
            if (_local_2 !== _arg_1)
            {
                this._1077769574member = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "member", _local_2, _arg_1));
            };
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

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set createrName(_arg_1:String):void
        {
            var _local_2:Object = this._477166943createrName;
            if (_local_2 !== _arg_1)
            {
                this._477166943createrName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "createrName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get prestige():Number
        {
            return (this._1276224445prestige);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((((((_arg_1 + "city = ") + this.city) + "\n") + (((_arg_1 + "createrName = ") + this.createrName) + "\n")) + (((_arg_1 + "date = ") + this.date) + "\n")) + (((_arg_1 + "description = ") + this.description) + "\n")) + (((_arg_1 + "honor = ") + this.honor) + "\n")) + (((_arg_1 + "id = ") + this.id) + "\n")) + (((_arg_1 + "member = ") + this.member) + "\n")) + (((_arg_1 + "name = ") + this.name) + "\n")) + (((_arg_1 + "playerName = ") + this.playerName) + "\n")) + (((_arg_1 + "prestige = ") + this.prestige) + "\n")) + (((_arg_1 + "rank = ") + this.rank) + "\n"));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set honor(_arg_1:Number):void
        {
            var _local_2:Object = this._99462250honor;
            if (_local_2 !== _arg_1)
            {
                this._99462250honor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "honor", _local_2, _arg_1));
            };
        }

        public function set city(_arg_1:int):void
        {
            var _local_2:Object = this._3053931city;
            if (_local_2 !== _arg_1)
            {
                this._3053931city = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "city", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:RankAllianceBean):void
        {
            _arg_1.city = this.city;
            _arg_1.createrName = this.createrName;
            _arg_1.date = this.date;
            _arg_1.description = this.description;
            _arg_1.honor = this.honor;
            _arg_1.id = this.id;
            _arg_1.member = this.member;
            _arg_1.name = this.name;
            _arg_1.playerName = this.playerName;
            _arg_1.prestige = this.prestige;
            _arg_1.rank = this.rank;
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

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set date(_arg_1:String):void
        {
            var _local_2:Object = this._3076014date;
            if (_local_2 !== _arg_1)
            {
                this._3076014date = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "date", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get honor():Number
        {
            return (this._99462250honor);
        }

        [Bindable(event="propertyChange")]
        public function get city():int
        {
            return (this._3053931city);
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


    }
}//package com.evony.common.beans

