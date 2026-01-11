// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ConditionDependItemBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class ConditionDependItemBean implements IEventDispatcher 
    {

        private var _109446num:int;
        private var _1349154522curNum:int;
        private var _1268712945successFlag:Boolean;
        private var _3355id:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ConditionDependItemBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.curNum != null)
                {
                    this.curNum = _arg_1.curNum;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.num != null)
                {
                    this.num = _arg_1.num;
                };
                if (_arg_1.successFlag != null)
                {
                    this.successFlag = _arg_1.successFlag;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
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
            _local_2 = (_local_2 + (((_arg_1 + "curNum = ") + this.curNum) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "num = ") + this.num) + "\n"));
            return (_local_2 + (((_arg_1 + "successFlag = ") + this.successFlag) + "\n"));
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

        [Bindable(event="propertyChange")]
        public function get successFlag():Boolean
        {
            return (this._1268712945successFlag);
        }

        public function copyTo(_arg_1:ConditionDependItemBean):void
        {
            _arg_1.curNum = this.curNum;
            _arg_1.id = this.id;
            _arg_1.num = this.num;
            _arg_1.successFlag = this.successFlag;
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

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.curNum = this.curNum;
            _local_1.id = this.id;
            _local_1.num = this.num;
            _local_1.successFlag = this.successFlag;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():String
        {
            return (this._3355id);
        }

        public function set successFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1268712945successFlag;
            if (_local_2 !== _arg_1)
            {
                this._1268712945successFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "successFlag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get curNum():int
        {
            return (this._1349154522curNum);
        }

        public function set id(_arg_1:String):void
        {
            var _local_2:Object = this._3355id;
            if (_local_2 !== _arg_1)
            {
                this._3355id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

