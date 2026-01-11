// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.GemStoneInPosBean

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

    public class GemStoneInPosBean implements IEventDispatcher 
    {

        private var _1694971109infroArray:ArrayCollection;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _111188pos:int;

        public function GemStoneInPosBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:GemStoneLvInfroBean;
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this.infroArray = new ArrayCollection();
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.pos != null)
                {
                    this.pos = _arg_1.pos;
                };
                if (_arg_1.infro)
                {
                    _local_2 = 0;
                    _local_3 = null;
                    while (_local_2 < _arg_1.infro.length)
                    {
                        _local_3 = new GemStoneLvInfroBean(_arg_1.infro[_local_2]);
                        this.infroArray.addItem(_local_3);
                        _local_2++;
                    };
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "pos = ") + this.pos) + "\n"));
            var _local_3:int;
            while (_local_3 < this.infroArray.length)
            {
                _local_2 = (_local_2 + this.getInfro(_local_3).toDebugString((((_arg_1 + "infro[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function copyTo(_arg_1:GemStoneInPosBean):void
        {
            _arg_1.pos = this.pos;
            CommonUtil.arrayCopy(this.infroArray, _arg_1.infroArray);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.pos = this.pos;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get pos():int
        {
            return (this._111188pos);
        }

        public function setInfro(_arg_1:GemStoneLvInfroBean, _arg_2:int):void
        {
            this.infroArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get infroArray():ArrayCollection
        {
            return (this._1694971109infroArray);
        }

        public function getInfro(_arg_1:int):GemStoneLvInfroBean
        {
            return (this.infroArray[_arg_1] as GemStoneLvInfroBean);
        }

        public function set pos(_arg_1:int):void
        {
            var _local_2:Object = this._111188pos;
            if (_local_2 !== _arg_1)
            {
                this._111188pos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pos", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set infroArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1694971109infroArray;
            if (_local_2 !== _arg_1)
            {
                this._1694971109infroArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infroArray", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

