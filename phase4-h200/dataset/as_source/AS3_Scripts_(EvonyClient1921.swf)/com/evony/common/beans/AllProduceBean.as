// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AllProduceBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.collections.ArrayCollection;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.CommonUtil;
    import com.evony.common.paramBeans.*;

    public class AllProduceBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _267085529allProduceQueueArray:ArrayCollection = new ArrayCollection();
        private var _1381039140positionId:int;

        public function AllProduceBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:ProduceBean;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.positionId != null)
                {
                    this.positionId = _arg_1.positionId;
                };
                if (_arg_1.allProduceQueue)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.allProduceQueue.length)
                    {
                        _local_3 = new ProduceBean(_arg_1.allProduceQueue[_local_2]);
                        this.allProduceQueueArray.addItem(_local_3);
                        _local_2++;
                    };
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set positionId(_arg_1:int):void
        {
            var _local_2:Object = this._1381039140positionId;
            if (_local_2 !== _arg_1)
            {
                this._1381039140positionId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "positionId", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "positionId = ") + this.positionId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.allProduceQueueArray.length)
            {
                _local_2 = (_local_2 + this.getAllProduceQueue(_local_3).toDebugString((((_arg_1 + "allProduceQueue[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function set allProduceQueueArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._267085529allProduceQueueArray;
            if (_local_2 !== _arg_1)
            {
                this._267085529allProduceQueueArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allProduceQueueArray", _local_2, _arg_1));
            };
        }

        public function setAllProduceQueue(_arg_1:ProduceBean, _arg_2:int):void
        {
            this.allProduceQueueArray[_arg_2] = _arg_1;
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:AllProduceBean):void
        {
            _arg_1.positionId = this.positionId;
            CommonUtil.arrayCopy(this.allProduceQueueArray, _arg_1.allProduceQueueArray);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.positionId = this.positionId;
            return (_local_1);
        }

        public function getAllProduceQueue(_arg_1:int):ProduceBean
        {
            return (this.allProduceQueueArray[_arg_1] as ProduceBean);
        }

        [Bindable(event="propertyChange")]
        public function get positionId():int
        {
            return (this._1381039140positionId);
        }

        [Bindable(event="propertyChange")]
        public function get allProduceQueueArray():ArrayCollection
        {
            return (this._267085529allProduceQueueArray);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

