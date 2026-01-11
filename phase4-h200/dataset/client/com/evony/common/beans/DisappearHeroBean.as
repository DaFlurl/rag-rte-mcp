// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.DisappearHeroBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class DisappearHeroBean implements IEventDispatcher 
    {

        private var _3355id:String;
        private var _3373707name:String;
        private var _1799980989management:int;
        private var _106858757power:int;
        private var _102865796level:int;
        private var _1417925547disppeartime:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _412944526stratagem:int;

        public function DisappearHeroBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.disppeartime != null)
                {
                    this.disppeartime = _arg_1.disppeartime;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.management != null)
                {
                    this.management = _arg_1.management;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.power != null)
                {
                    this.power = _arg_1.power;
                };
                if (_arg_1.stratagem != null)
                {
                    this.stratagem = _arg_1.stratagem;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get management():int
        {
            return (this._1799980989management);
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
        }

        [Bindable(event="propertyChange")]
        public function get power():int
        {
            return (this._106858757power);
        }

        public function set management(_arg_1:int):void
        {
            var _local_2:Object = this._1799980989management;
            if (_local_2 !== _arg_1)
            {
                this._1799980989management = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "management", _local_2, _arg_1));
            };
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

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "disppeartime = ") + this.disppeartime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "level = ") + this.level) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "management = ") + this.management) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "power = ") + this.power) + "\n"));
            return (_local_2 + (((_arg_1 + "stratagem = ") + this.stratagem) + "\n"));
        }

        public function set power(_arg_1:int):void
        {
            var _local_2:Object = this._106858757power;
            if (_local_2 !== _arg_1)
            {
                this._106858757power = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "power", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:DisappearHeroBean):void
        {
            _arg_1.disppeartime = this.disppeartime;
            _arg_1.id = this.id;
            _arg_1.level = this.level;
            _arg_1.management = this.management;
            _arg_1.name = this.name;
            _arg_1.power = this.power;
            _arg_1.stratagem = this.stratagem;
        }

        [Bindable(event="propertyChange")]
        public function get stratagem():int
        {
            return (this._412944526stratagem);
        }

        [Bindable(event="propertyChange")]
        public function get disppeartime():String
        {
            return (this._1417925547disppeartime);
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

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.disppeartime = this.disppeartime;
            _local_1.id = this.id;
            _local_1.level = this.level;
            _local_1.management = this.management;
            _local_1.name = this.name;
            _local_1.power = this.power;
            _local_1.stratagem = this.stratagem;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():String
        {
            return (this._3355id);
        }

        public function set stratagem(_arg_1:int):void
        {
            var _local_2:Object = this._412944526stratagem;
            if (_local_2 !== _arg_1)
            {
                this._412944526stratagem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagem", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set disppeartime(_arg_1:String):void
        {
            var _local_2:Object = this._1417925547disppeartime;
            if (_local_2 !== _arg_1)
            {
                this._1417925547disppeartime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "disppeartime", _local_2, _arg_1));
            };
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

