// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AllianceQueryBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class AllianceQueryBean implements IEventDispatcher 
    {

        private var _1344718425bulletin:String;
        private var _102976443limit:int;
        private var _3373707name:String;
        private var _1349154522curNum:int;
        private var _190875433creatorName:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1191282484leaderName:String;
        private var _1276224445prestige:int;
        private var _3079825desc:String;
        private var _978111542ranking:int;

        public function AllianceQueryBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.bulletin != null)
                {
                    this.bulletin = _arg_1.bulletin;
                };
                if (_arg_1.creatorName != null)
                {
                    this.creatorName = _arg_1.creatorName;
                };
                if (_arg_1.curNum != null)
                {
                    this.curNum = _arg_1.curNum;
                };
                if (_arg_1.desc != null)
                {
                    this.desc = _arg_1.desc;
                };
                if (_arg_1.leaderName != null)
                {
                    this.leaderName = _arg_1.leaderName;
                };
                if (_arg_1.limit != null)
                {
                    this.limit = _arg_1.limit;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.prestige != null)
                {
                    this.prestige = _arg_1.prestige;
                };
                if (_arg_1.ranking != null)
                {
                    this.ranking = _arg_1.ranking;
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

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
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
            _local_1.bulletin = this.bulletin;
            _local_1.creatorName = this.creatorName;
            _local_1.curNum = this.curNum;
            _local_1.desc = this.desc;
            _local_1.leaderName = this.leaderName;
            _local_1.limit = this.limit;
            _local_1.name = this.name;
            _local_1.prestige = this.prestige;
            _local_1.ranking = this.ranking;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get desc():String
        {
            return (this._3079825desc);
        }

        [Bindable(event="propertyChange")]
        public function get curNum():int
        {
            return (this._1349154522curNum);
        }

        [Bindable(event="propertyChange")]
        public function get bulletin():String
        {
            return (this._1344718425bulletin);
        }

        public function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
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
        public function get ranking():int
        {
            return (this._978111542ranking);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get limit():int
        {
            return (this._102976443limit);
        }

        [Bindable(event="propertyChange")]
        public function get prestige():int
        {
            return (this._1276224445prestige);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "bulletin = ") + this.bulletin) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "creatorName = ") + this.creatorName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "curNum = ") + this.curNum) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "desc = ") + this.desc) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "leaderName = ") + this.leaderName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "limit = ") + this.limit) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "prestige = ") + this.prestige) + "\n"));
            return (_local_2 + (((_arg_1 + "ranking = ") + this.ranking) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set curNum(_arg_1:int):void
        {
            var _local_2:Object = this._1349154522curNum;
            if (_local_2 !== _arg_1)
            {
                this._1349154522curNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curNum", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set bulletin(_arg_1:String):void
        {
            var _local_2:Object = this._1344718425bulletin;
            if (_local_2 !== _arg_1)
            {
                this._1344718425bulletin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bulletin", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:AllianceQueryBean):void
        {
            _arg_1.bulletin = this.bulletin;
            _arg_1.creatorName = this.creatorName;
            _arg_1.curNum = this.curNum;
            _arg_1.desc = this.desc;
            _arg_1.leaderName = this.leaderName;
            _arg_1.limit = this.limit;
            _arg_1.name = this.name;
            _arg_1.prestige = this.prestige;
            _arg_1.ranking = this.ranking;
        }

        [Bindable(event="propertyChange")]
        public function get creatorName():String
        {
            return (this._190875433creatorName);
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

        public function set ranking(_arg_1:int):void
        {
            var _local_2:Object = this._978111542ranking;
            if (_local_2 !== _arg_1)
            {
                this._978111542ranking = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ranking", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set limit(_arg_1:int):void
        {
            var _local_2:Object = this._102976443limit;
            if (_local_2 !== _arg_1)
            {
                this._102976443limit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "limit", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

