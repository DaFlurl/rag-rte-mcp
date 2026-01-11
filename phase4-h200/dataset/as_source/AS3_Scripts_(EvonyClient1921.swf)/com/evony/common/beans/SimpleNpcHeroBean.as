// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.SimpleNpcHeroBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class SimpleNpcHeroBean implements IEventDispatcher 
    {

        private var _105022396npcid:int;
        private var _871991583introduce:String;
        private var _3373707name:String;
        private var _342531044logourl:String;
        private var _1261935347introduce2:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function SimpleNpcHeroBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.logourl != null)
                {
                    this.logourl = _arg_1.logourl;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.npcid != null)
                {
                    this.npcid = _arg_1.npcid;
                };
                if (_arg_1.introduce != null)
                {
                    this.introduce = _arg_1.introduce;
                };
                if (_arg_1.introduce2 != null)
                {
                    this.introduce2 = _arg_1.introduce2;
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

        public function set logourl(_arg_1:String):void
        {
            var _local_2:Object = this._342531044logourl;
            if (_local_2 !== _arg_1)
            {
                this._342531044logourl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logourl", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "logourl = ") + this.logourl) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "npcid = ") + this.npcid) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "introduce = ") + this.introduce) + "\n"));
            return (_local_2 + (((_arg_1 + "introduce2 = ") + this.introduce2) + "\n"));
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function copyTo(_arg_1:SimpleNpcHeroBean):void
        {
            _arg_1.logourl = this.logourl;
            _arg_1.name = this.name;
            _arg_1.npcid = this.npcid;
            _arg_1.introduce = this.introduce;
            _arg_1.introduce2 = this.introduce2;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
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

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.logourl = this.logourl;
            _local_1.name = this.name;
            _local_1.npcid = this.npcid;
            _local_1.introduce = this.introduce;
            _local_1.introduce2 = this.introduce2;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get introduce():String
        {
            return (this._871991583introduce);
        }

        [Bindable(event="propertyChange")]
        public function get logourl():String
        {
            return (this._342531044logourl);
        }

        public function set introduce2(_arg_1:String):void
        {
            var _local_2:Object = this._1261935347introduce2;
            if (_local_2 !== _arg_1)
            {
                this._1261935347introduce2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "introduce2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get introduce2():String
        {
            return (this._1261935347introduce2);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set npcid(_arg_1:int):void
        {
            var _local_2:Object = this._105022396npcid;
            if (_local_2 !== _arg_1)
            {
                this._105022396npcid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npcid", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get npcid():int
        {
            return (this._105022396npcid);
        }

        public function set introduce(_arg_1:String):void
        {
            var _local_2:Object = this._871991583introduce;
            if (_local_2 !== _arg_1)
            {
                this._871991583introduce = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "introduce", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

