// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.VisitorCommentBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import mx.events.*;
    import flash.events.*;

    public class VisitorCommentBean implements IEventDispatcher 
    {

        private var _950398559comment:String;
        private var _3496342read:Boolean;
        private var _3560141time:String;
        private var _1880546825visitorid:String;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function VisitorCommentBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.comment != null)
                {
                    this.comment = _arg_1.comment;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.time != null)
                {
                    this.time = _arg_1.time;
                };
                if (_arg_1.visitorid != null)
                {
                    this.visitorid = _arg_1.visitorid;
                };
                if (_arg_1.read != null)
                {
                    this.read = _arg_1.read;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "comment = ") + this.comment) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "time = ") + this.time) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "visitorid = ") + this.visitorid) + "\n"));
            return (_local_2 + (((_arg_1 + "read = ") + this.read) + "\n"));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get time():String
        {
            return (this._3560141time);
        }

        public function copyTo(_arg_1:VisitorCommentBean):void
        {
            _arg_1.comment = this.comment;
            _arg_1.id = this.id;
            _arg_1.time = this.time;
            _arg_1.visitorid = this.visitorid;
            _arg_1.read = this.read;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set visitorid(_arg_1:String):void
        {
            var _local_2:Object = this._1880546825visitorid;
            if (_local_2 !== _arg_1)
            {
                this._1880546825visitorid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "visitorid", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get read():Boolean
        {
            return (this._3496342read);
        }

        [Bindable(event="propertyChange")]
        public function get visitorid():String
        {
            return (this._1880546825visitorid);
        }

        public function set time(_arg_1:String):void
        {
            var _local_2:Object = this._3560141time;
            if (_local_2 !== _arg_1)
            {
                this._3560141time = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get comment():String
        {
            return (this._950398559comment);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.comment = this.comment;
            _local_1.id = this.id;
            _local_1.time = this.time;
            _local_1.visitorid = this.visitorid;
            _local_1.read = this.read;
            return (_local_1);
        }

        public function set read(_arg_1:Boolean):void
        {
            var _local_2:Object = this._3496342read;
            if (_local_2 !== _arg_1)
            {
                this._3496342read = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "read", _local_2, _arg_1));
            };
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

        public function set comment(_arg_1:String):void
        {
            var _local_2:Object = this._950398559comment;
            if (_local_2 !== _arg_1)
            {
                this._950398559comment = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "comment", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

