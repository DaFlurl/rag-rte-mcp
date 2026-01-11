// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ProduceBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class ProduceBean implements IEventDispatcher 
    {

        private var _424687558costTime:Number;
        private var _1607243192endTime:Number;
        private var _655172108queueId:int;
        private var _109446num:int;
        private var _3575610type:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ProduceBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.costTime != null)
                {
                    this.costTime = _arg_1.costTime;
                };
                if (_arg_1.endTime != null)
                {
                    this.endTime = _arg_1.endTime;
                };
                if (_arg_1.num != null)
                {
                    this.num = _arg_1.num;
                };
                if (_arg_1.queueId != null)
                {
                    this.queueId = _arg_1.queueId;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get type():int
        {
            return (this._3575610type);
        }

        [Bindable(event="propertyChange")]
        public function get num():int
        {
            return (this._109446num);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "costTime = ") + this.costTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "endTime = ") + this.endTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "num = ") + this.num) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "queueId = ") + this.queueId) + "\n"));
            return (_local_2 + (((_arg_1 + "type = ") + this.type) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set num(_arg_1:int):void
        {
            var _local_2:Object = this._109446num;
            if (_local_2 !== _arg_1)
            {
                this._109446num = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "num", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get queueId():int
        {
            return (this._655172108queueId);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
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

        public function set queueId(_arg_1:int):void
        {
            var _local_2:Object = this._655172108queueId;
            if (_local_2 !== _arg_1)
            {
                this._655172108queueId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueId", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.costTime = this.costTime;
            _local_1.endTime = this.endTime;
            _local_1.num = this.num;
            _local_1.queueId = this.queueId;
            _local_1.type = this.type;
            return (_local_1);
        }

        public function set costTime(_arg_1:Number):void
        {
            var _local_2:Object = this._424687558costTime;
            if (_local_2 !== _arg_1)
            {
                this._424687558costTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "costTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get endTime():Number
        {
            return (this._1607243192endTime);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function copyTo(_arg_1:ProduceBean):void
        {
            _arg_1.costTime = this.costTime;
            _arg_1.endTime = this.endTime;
            _arg_1.num = this.num;
            _arg_1.queueId = this.queueId;
            _arg_1.type = this.type;
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

        [Bindable(event="propertyChange")]
        public function get costTime():Number
        {
            return (this._424687558costTime);
        }


    }
}//package com.evony.common.beans

