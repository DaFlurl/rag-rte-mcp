// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.GemStoneLvInfroBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import mx.collections.ArrayCollection;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import com.evony.common.CommonUtil;
    import mx.events.PropertyChangeEvent;
    import mx.events.*;
    import flash.events.*;
    import mx.collections.*;
    import com.evony.common.*;

    public class GemStoneLvInfroBean implements IEventDispatcher 
    {

        private var _353643255gemstoneidsArray:ArrayCollection;
        private var _3466lv:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function GemStoneLvInfroBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:GemStoneBean;
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this.gemstoneidsArray = new ArrayCollection();
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.lv != null)
                {
                    this.lv = _arg_1.lv;
                };
                if (_arg_1.gemstoneids)
                {
                    _local_2 = 0;
                    _local_3 = null;
                    while (_local_2 < _arg_1.gemstoneids.length)
                    {
                        _local_3 = new GemStoneBean(_arg_1.gemstoneids[_local_2]);
                        this.gemstoneidsArray.addItem(_local_3);
                        _local_2++;
                    };
                };
            };
        }

        public function setGemstoneids(_arg_1:GemStoneBean, _arg_2:int):void
        {
            this.gemstoneidsArray[_arg_2] = _arg_1;
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "lv = ") + this.lv) + "\n"));
            var _local_3:int;
            while (_local_3 < this.gemstoneidsArray.length)
            {
                _local_2 = (_local_2 + this.getGemstoneids(_local_3).toDebugString((((_arg_1 + "gemstoneids[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:GemStoneLvInfroBean):void
        {
            _arg_1.lv = this.lv;
            CommonUtil.arrayCopy(this.gemstoneidsArray, _arg_1.gemstoneidsArray);
        }

        [Bindable(event="propertyChange")]
        public function get lv():int
        {
            return (this._3466lv);
        }

        public function getGemstoneids(_arg_1:int):GemStoneBean
        {
            return (this.gemstoneidsArray[_arg_1] as GemStoneBean);
        }

        public function set lv(_arg_1:int):void
        {
            var _local_2:Object = this._3466lv;
            if (_local_2 !== _arg_1)
            {
                this._3466lv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lv", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.lv = this.lv;
            return (_local_1);
        }

        public function set gemstoneidsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._353643255gemstoneidsArray;
            if (_local_2 !== _arg_1)
            {
                this._353643255gemstoneidsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gemstoneidsArray", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get gemstoneidsArray():ArrayCollection
        {
            return (this._353643255gemstoneidsArray);
        }


    }
}//package com.evony.common.beans

