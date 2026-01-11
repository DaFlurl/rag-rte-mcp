// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.GamblingRankingBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.collections.ArrayCollection;
    import flash.events.Event;
    import com.evony.common.CommonUtil;
    import mx.events.PropertyChangeEvent;

    public class GamblingRankingBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _260292359isReward:int;
        private var _809208522itemsBeansArray:ArrayCollection;
        private var _2095657228playerName:String;
        private var _3492908rank:int;
        private var _94851343count:int;

        public function GamblingRankingBean(_arg_1:Object=null)
        {
            var _local_2:ItemBean;
            var _local_3:int;
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this.itemsBeansArray = new ArrayCollection();
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.count != null)
                {
                    this.count = _arg_1.count;
                };
                if (_arg_1.isReward != null)
                {
                    this.isReward = _arg_1.isReward;
                };
                if (_arg_1.playerName != null)
                {
                    this.playerName = _arg_1.playerName;
                };
                if (_arg_1.rank != null)
                {
                    this.rank = _arg_1.rank;
                };
                if (_arg_1.itemsBeans)
                {
                    _local_2 = null;
                    _local_3 = 0;
                    while (_local_3 < _arg_1.itemsBeans.length)
                    {
                        _local_2 = new ItemBean(_arg_1.itemsBeans[_local_3]);
                        this.itemsBeansArray.addItem(_local_2);
                        _local_3++;
                    };
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
            var _local_2:String = ((((((_arg_1 + "count = ") + this.count) + "\n") + (((_arg_1 + "isReward = ") + this.isReward) + "\n")) + (((_arg_1 + "playerName = ") + this.playerName) + "\n")) + (((_arg_1 + "rank = ") + this.rank) + "\n"));
            var _local_3:int;
            while (_local_3 < this.itemsBeansArray.length)
            {
                _local_2 = (_local_2 + this.getItemsBeans(_local_3).toDebugString((((_arg_1 + "itemsBeans[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get playerName():String
        {
            return (this._2095657228playerName);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get count():int
        {
            return (this._94851343count);
        }

        public function copyTo(_arg_1:GamblingRankingBean):void
        {
            _arg_1.count = this.count;
            _arg_1.isReward = this.isReward;
            _arg_1.playerName = this.playerName;
            _arg_1.rank = this.rank;
            CommonUtil.arrayCopy(this.itemsBeansArray, _arg_1.itemsBeansArray);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
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
                "count":this.count,
                "isReward":this.isReward,
                "playerName":this.playerName,
                "rank":this.rank
            });
        }

        public function set count(_arg_1:int):void
        {
            var _local_2:Object = this._94851343count;
            if (_local_2 !== _arg_1)
            {
                this._94851343count = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "count", _local_2, _arg_1));
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

        public function getItemsBeans(_arg_1:int):ItemBean
        {
            return (this.itemsBeansArray[_arg_1] as ItemBean);
        }

        public function setItemsBeans(_arg_1:ItemBean, _arg_2:int):void
        {
            this.itemsBeansArray[_arg_2] = _arg_1;
        }

        public function set isReward(_arg_1:int):void
        {
            var _local_2:Object = this._260292359isReward;
            if (_local_2 !== _arg_1)
            {
                this._260292359isReward = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isReward", _local_2, _arg_1));
            };
        }

        public function set itemsBeansArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._809208522itemsBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._809208522itemsBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemsBeansArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemsBeansArray():ArrayCollection
        {
            return (this._809208522itemsBeansArray);
        }

        [Bindable(event="propertyChange")]
        public function get isReward():int
        {
            return (this._260292359isReward);
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }


    }
}//package com.evony.common.beans

