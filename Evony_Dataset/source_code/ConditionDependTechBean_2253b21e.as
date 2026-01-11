// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ConditionDependTechBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class ConditionDependTechBean implements IEventDispatcher 
    {

        private var _102865796level:int;
        private var _540315940curLevel:int;
        private var _1268712945successFlag:Boolean;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ConditionDependTechBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.curLevel != null)
                {
                    this.curLevel = _arg_1.curLevel;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
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
        public function get level():int
        {
            return (this._102865796level);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set curLevel(_arg_1:int):void
        {
            var _local_2:Object = this._540315940curLevel;
            if (_local_2 !== _arg_1)
            {
                this._540315940curLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curLevel", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "curLevel = ") + this.curLevel) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            return (_local_2 + (((_arg_1 + "successFlag = ") + this.successFlag) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set level(_arg_1:int):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
            };
        }

        public function copyTo(_arg_1:ConditionDependTechBean):void
        {
            _arg_1.curLevel = this.curLevel;
            _arg_1.id = this.id;
            _arg_1.level = this.level;
            _arg_1.successFlag = this.successFlag;
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.curLevel = this.curLevel;
            _local_1.id = this.id;
            _local_1.level = this.level;
            _local_1.successFlag = this.successFlag;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
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
        public function get curLevel():int
        {
            return (this._540315940curLevel);
        }

        [Bindable(event="propertyChange")]
        public function get successFlag():Boolean
        {
            return (this._1268712945successFlag);
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


    }
}//package com.evony.common.beans

