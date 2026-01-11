// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ConditionDependBuildingBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import mx.events.*;
    import flash.events.*;

    public class ConditionDependBuildingBean implements IEventDispatcher 
    {

        private var _540315940curLevel:int;
        private var _1268712945successFlag:Boolean;
        private var _858803723typeId:int;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ConditionDependBuildingBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.curLevel != null)
                {
                    this.curLevel = _arg_1.curLevel;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.typeId != null)
                {
                    this.typeId = _arg_1.typeId;
                };
                if (_arg_1.successFlag != null)
                {
                    this.successFlag = _arg_1.successFlag;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
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
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "curLevel = ") + this.curLevel) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "typeId = ") + this.typeId) + "\n"));
            return (_local_2 + (((_arg_1 + "successFlag = ") + this.successFlag) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
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

        public function copyTo(_arg_1:ConditionDependBuildingBean):void
        {
            _arg_1.curLevel = this.curLevel;
            _arg_1.level = this.level;
            _arg_1.typeId = this.typeId;
            _arg_1.successFlag = this.successFlag;
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.curLevel = this.curLevel;
            _local_1.level = this.level;
            _local_1.typeId = this.typeId;
            _local_1.successFlag = this.successFlag;
            return (_local_1);
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

        public function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }


    }
}//package com.evony.common.beans

