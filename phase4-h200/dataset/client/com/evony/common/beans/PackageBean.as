// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.PackageBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import mx.collections.ArrayCollection;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.CommonUtil;
    import com.evony.common.paramBeans.*;

    public class PackageBean implements IEventDispatcher 
    {

        public static const PACKAGE_TYPE_SERIAL:int = 1;
        public static const PACKAGE_TYPE_SCORES:int = 2;
        public static const PACKAGE_TYPE_NORMAL:int = 3;

        private var _892481550status:int;
        private var _3575610type:int;
        private var _1049685640itemListArray:ArrayCollection = new ArrayCollection();
        private var _2063817998provideTime:Number;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3355id:int;
        private var _162030183isUseNow:int;
        private var _1530923192claimedTime:String;
        private var _907766751scores:int;
        private var _391026675maxMedal:int;
        private var _1385169979minMedal:int;
        private var _3079825desc:String;
        private var _908759025packageName:String;
        private var _92515438expiredTime:Number;

        public function PackageBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:ItemBean;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.claimedTime != null)
                {
                    this.claimedTime = _arg_1.claimedTime;
                };
                if (_arg_1.desc != null)
                {
                    this.desc = _arg_1.desc;
                };
                if (_arg_1.expiredTime != null)
                {
                    this.expiredTime = _arg_1.expiredTime;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.isUseNow != null)
                {
                    this.isUseNow = _arg_1.isUseNow;
                };
                if (_arg_1.maxMedal != null)
                {
                    this.maxMedal = _arg_1.maxMedal;
                };
                if (_arg_1.minMedal != null)
                {
                    this.minMedal = _arg_1.minMedal;
                };
                if (_arg_1.packageName != null)
                {
                    this.packageName = _arg_1.packageName;
                };
                if (_arg_1.provideTime != null)
                {
                    this.provideTime = _arg_1.provideTime;
                };
                if (_arg_1.scores != null)
                {
                    this.scores = _arg_1.scores;
                };
                if (_arg_1.status != null)
                {
                    this.status = _arg_1.status;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
                if (_arg_1.itemList)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.itemList.length)
                    {
                        _local_3 = new ItemBean(_arg_1.itemList[_local_2]);
                        this.itemListArray.addItem(_local_3);
                        _local_2++;
                    };
                };
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get itemListArray():ArrayCollection
        {
            return (this._1049685640itemListArray);
        }

        public function set minMedal(_arg_1:int):void
        {
            var _local_2:Object = this._1385169979minMedal;
            if (_local_2 !== _arg_1)
            {
                this._1385169979minMedal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minMedal", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get desc():String
        {
            return (this._3079825desc);
        }

        [Bindable(event="propertyChange")]
        public function get expiredTime():Number
        {
            return (this._92515438expiredTime);
        }

        [Bindable(event="propertyChange")]
        public function get provideTime():Number
        {
            return (this._2063817998provideTime);
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

        public function set claimedTime(_arg_1:String):void
        {
            var _local_2:Object = this._1530923192claimedTime;
            if (_local_2 !== _arg_1)
            {
                this._1530923192claimedTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "claimedTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isUseNow():int
        {
            return (this._162030183isUseNow);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.claimedTime = this.claimedTime;
            _local_1.desc = this.desc;
            _local_1.expiredTime = this.expiredTime;
            _local_1.id = this.id;
            _local_1.isUseNow = this.isUseNow;
            _local_1.maxMedal = this.maxMedal;
            _local_1.minMedal = this.minMedal;
            _local_1.packageName = this.packageName;
            _local_1.provideTime = this.provideTime;
            _local_1.scores = this.scores;
            _local_1.status = this.status;
            _local_1.type = this.type;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function set provideTime(_arg_1:Number):void
        {
            var _local_2:Object = this._2063817998provideTime;
            if (_local_2 !== _arg_1)
            {
                this._2063817998provideTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "provideTime", _local_2, _arg_1));
            };
        }

        public function set itemListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1049685640itemListArray;
            if (_local_2 !== _arg_1)
            {
                this._1049685640itemListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemListArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get scores():int
        {
            return (this._907766751scores);
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

        public function set expiredTime(_arg_1:Number):void
        {
            var _local_2:Object = this._92515438expiredTime;
            if (_local_2 !== _arg_1)
            {
                this._92515438expiredTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "expiredTime", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set isUseNow(_arg_1:int):void
        {
            var _local_2:Object = this._162030183isUseNow;
            if (_local_2 !== _arg_1)
            {
                this._162030183isUseNow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isUseNow", _local_2, _arg_1));
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
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set scores(_arg_1:int):void
        {
            var _local_2:Object = this._907766751scores;
            if (_local_2 !== _arg_1)
            {
                this._907766751scores = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scores", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get minMedal():int
        {
            return (this._1385169979minMedal);
        }

        public function getItemList(_arg_1:int):ItemBean
        {
            return (this.itemListArray[_arg_1] as ItemBean);
        }

        [Bindable(event="propertyChange")]
        public function get claimedTime():String
        {
            return (this._1530923192claimedTime);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "claimedTime = ") + this.claimedTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "desc = ") + this.desc) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "expiredTime = ") + this.expiredTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "isUseNow = ") + this.isUseNow) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "maxMedal = ") + this.maxMedal) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "minMedal = ") + this.minMedal) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageName = ") + this.packageName) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "provideTime = ") + this.provideTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "scores = ") + this.scores) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "status = ") + this.status) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "type = ") + this.type) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.itemListArray.length)
            {
                _local_2 = (_local_2 + this.getItemList(_local_3).toDebugString((((_arg_1 + "itemList[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:PackageBean):void
        {
            _arg_1.claimedTime = this.claimedTime;
            _arg_1.desc = this.desc;
            _arg_1.expiredTime = this.expiredTime;
            _arg_1.id = this.id;
            _arg_1.isUseNow = this.isUseNow;
            _arg_1.maxMedal = this.maxMedal;
            _arg_1.minMedal = this.minMedal;
            _arg_1.packageName = this.packageName;
            _arg_1.provideTime = this.provideTime;
            _arg_1.scores = this.scores;
            _arg_1.status = this.status;
            _arg_1.type = this.type;
            CommonUtil.arrayCopy(this.itemListArray, _arg_1.itemListArray);
        }

        [Bindable(event="propertyChange")]
        public function get type():int
        {
            return (this._3575610type);
        }

        public function setItemList(_arg_1:ItemBean, _arg_2:int):void
        {
            this.itemListArray[_arg_2] = _arg_1;
        }

        public function set packageName(_arg_1:String):void
        {
            var _local_2:Object = this._908759025packageName;
            if (_local_2 !== _arg_1)
            {
                this._908759025packageName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "packageName", _local_2, _arg_1));
            };
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

        public function set maxMedal(_arg_1:int):void
        {
            var _local_2:Object = this._391026675maxMedal;
            if (_local_2 !== _arg_1)
            {
                this._391026675maxMedal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxMedal", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get packageName():String
        {
            return (this._908759025packageName);
        }

        [Bindable(event="propertyChange")]
        public function get status():int
        {
            return (this._892481550status);
        }

        [Bindable(event="propertyChange")]
        public function get maxMedal():int
        {
            return (this._391026675maxMedal);
        }


    }
}//package com.evony.common.beans

