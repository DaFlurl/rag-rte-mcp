// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.MailBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class MailBean implements IEventDispatcher 
    {

        private var _441951604targetId:int;
        private var _853090240type_id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _905962955sender:String;
        private var _2103439280receiveTime:String;
        private var _1081573102mailid:int;
        private var _1879273436playerId:int;
        private var _1191572123selected:Boolean;
        private var _1180158496isRead:int;
        private var _808719889receiver:String;
        private var _110371416title:String;

        public function MailBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.isRead != null)
                {
                    this.isRead = _arg_1.isRead;
                };
                if (_arg_1.mailid != null)
                {
                    this.mailid = _arg_1.mailid;
                };
                if (_arg_1.playerId != null)
                {
                    this.playerId = _arg_1.playerId;
                };
                if (_arg_1.receiveTime != null)
                {
                    this.receiveTime = _arg_1.receiveTime;
                };
                if (_arg_1.receiver != null)
                {
                    this.receiver = _arg_1.receiver;
                };
                if (_arg_1.sender != null)
                {
                    this.sender = _arg_1.sender;
                };
                if (_arg_1.targetId != null)
                {
                    this.targetId = _arg_1.targetId;
                };
                if (_arg_1.title != null)
                {
                    this.title = _arg_1.title;
                };
                if (_arg_1.type_id != null)
                {
                    this.type_id = _arg_1.type_id;
                };
                if (_arg_1.selected != null)
                {
                    this.selected = _arg_1.selected;
                };
            };
        }

        public function set type_id(_arg_1:int):void
        {
            var _local_2:Object = this._853090240type_id;
            if (_local_2 !== _arg_1)
            {
                this._853090240type_id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type_id", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get targetId():int
        {
            return (this._441951604targetId);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get mailid():int
        {
            return (this._1081573102mailid);
        }

        public function set targetId(_arg_1:int):void
        {
            var _local_2:Object = this._441951604targetId;
            if (_local_2 !== _arg_1)
            {
                this._441951604targetId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetId", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.isRead = this.isRead;
            _local_1.mailid = this.mailid;
            _local_1.playerId = this.playerId;
            _local_1.receiveTime = this.receiveTime;
            _local_1.receiver = this.receiver;
            _local_1.sender = this.sender;
            _local_1.targetId = this.targetId;
            _local_1.title = this.title;
            _local_1.type_id = this.type_id;
            _local_1.selected = this.selected;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get selected():Boolean
        {
            return (this._1191572123selected);
        }

        public function set receiveTime(_arg_1:String):void
        {
            var _local_2:Object = this._2103439280receiveTime;
            if (_local_2 !== _arg_1)
            {
                this._2103439280receiveTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiveTime", _local_2, _arg_1));
            };
        }

        public function set mailid(_arg_1:int):void
        {
            var _local_2:Object = this._1081573102mailid;
            if (_local_2 !== _arg_1)
            {
                this._1081573102mailid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailid", _local_2, _arg_1));
            };
        }

        public function set title(_arg_1:String):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sender():String
        {
            return (this._905962955sender);
        }

        public function set selected(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1191572123selected;
            if (_local_2 !== _arg_1)
            {
                this._1191572123selected = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selected", _local_2, _arg_1));
            };
        }

        public function set playerId(_arg_1:int):void
        {
            var _local_2:Object = this._1879273436playerId;
            if (_local_2 !== _arg_1)
            {
                this._1879273436playerId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerId", _local_2, _arg_1));
            };
        }

        public function set isRead(_arg_1:int):void
        {
            var _local_2:Object = this._1180158496isRead;
            if (_local_2 !== _arg_1)
            {
                this._1180158496isRead = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isRead", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get type_id():int
        {
            return (this._853090240type_id);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "isRead = ") + this.isRead) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "mailid = ") + this.mailid) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "playerId = ") + this.playerId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "receiveTime = ") + this.receiveTime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "receiver = ") + this.receiver) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "sender = ") + this.sender) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "targetId = ") + this.targetId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "title = ") + this.title) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "type_id = ") + this.type_id) + "\n"));
            return (_local_2 + (((_arg_1 + "selected = ") + this.selected) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function copyTo(_arg_1:MailBean):void
        {
            _arg_1.isRead = this.isRead;
            _arg_1.mailid = this.mailid;
            _arg_1.playerId = this.playerId;
            _arg_1.receiveTime = this.receiveTime;
            _arg_1.receiver = this.receiver;
            _arg_1.sender = this.sender;
            _arg_1.targetId = this.targetId;
            _arg_1.title = this.title;
            _arg_1.type_id = this.type_id;
            _arg_1.selected = this.selected;
        }

        [Bindable(event="propertyChange")]
        public function get receiveTime():String
        {
            return (this._2103439280receiveTime);
        }

        [Bindable(event="propertyChange")]
        public function get title():String
        {
            return (this._110371416title);
        }

        [Bindable(event="propertyChange")]
        public function get playerId():int
        {
            return (this._1879273436playerId);
        }

        public function set receiver(_arg_1:String):void
        {
            var _local_2:Object = this._808719889receiver;
            if (_local_2 !== _arg_1)
            {
                this._808719889receiver = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiver", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isRead():int
        {
            return (this._1180158496isRead);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get receiver():String
        {
            return (this._808719889receiver);
        }

        public function set sender(_arg_1:String):void
        {
            var _local_2:Object = this._905962955sender;
            if (_local_2 !== _arg_1)
            {
                this._905962955sender = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sender", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

