// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.QuestTargetBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class QuestTargetBean implements IEventDispatcher 
    {

        private var _3373707name:String;
        private var _673660814finished:Boolean;
        private var _bindingEventDispatcher:EventDispatcher;

        public function QuestTargetBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.finished != null)
                {
                    this.finished = _arg_1.finished;
                };
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set finished(_arg_1:Boolean):void
        {
            var _local_2:Object = this._673660814finished;
            if (_local_2 !== _arg_1)
            {
                this._673660814finished = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "finished", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            return (_local_2 + (((_arg_1 + "finished = ") + this.finished) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get finished():Boolean
        {
            return (this._673660814finished);
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

        public function copyTo(_arg_1:QuestTargetBean):void
        {
            _arg_1.name = this.name;
            _arg_1.finished = this.finished;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.name = this.name;
            _local_1.finished = this.finished;
            return (_local_1);
        }


    }
}//package com.evony.common.beans

