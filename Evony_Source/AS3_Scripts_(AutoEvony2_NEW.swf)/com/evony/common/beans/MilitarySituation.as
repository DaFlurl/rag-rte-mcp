// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.MilitarySituation

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class MilitarySituation implements IEventDispatcher 
    {

        private var _1316782738startPos:String;
        private var _1833139858otherAllianceName:String;
        private var _3575610type:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3355id:int;
        private var _3560141time:String;
        private var _1407259064attack:Boolean;
        private var _31228997eventName:String;
        private var _179745070xml_data:String;
        private var _815590653targetPos:String;

        public function MilitarySituation(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.eventName != null)
                {
                    this.eventName = _arg_1.eventName;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.otherAllianceName != null)
                {
                    this.otherAllianceName = _arg_1.otherAllianceName;
                };
                if (_arg_1.startPos != null)
                {
                    this.startPos = _arg_1.startPos;
                };
                if (_arg_1.targetPos != null)
                {
                    this.targetPos = _arg_1.targetPos;
                };
                if (_arg_1.time != null)
                {
                    this.time = _arg_1.time;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
                if (_arg_1.xml_data != null)
                {
                    this.xml_data = _arg_1.xml_data;
                };
                if (_arg_1.attack != null)
                {
                    this.attack = _arg_1.attack;
                };
            };
        }

        public function set eventName(_arg_1:String):void
        {
            var _local_2:Object = this._31228997eventName;
            if (_local_2 !== _arg_1)
            {
                this._31228997eventName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eventName", _local_2, _arg_1));
            };
        }

        public function set targetPos(_arg_1:String):void
        {
            var _local_2:Object = this._815590653targetPos;
            if (_local_2 !== _arg_1)
            {
                this._815590653targetPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPos", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get startPos():String
        {
            return (this._1316782738startPos);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
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
        public function get otherAllianceName():String
        {
            return (this._1833139858otherAllianceName);
        }

        public function toObject():Object
        {
            return ({
                "eventName":this.eventName,
                "id":this.id,
                "otherAllianceName":this.otherAllianceName,
                "startPos":this.startPos,
                "targetPos":this.targetPos,
                "time":this.time,
                "type":this.type,
                "xml_data":this.xml_data,
                "attack":this.attack
            });
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function set attack(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1407259064attack;
            if (_local_2 !== _arg_1)
            {
                this._1407259064attack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attack", _local_2, _arg_1));
            };
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

        public function set xml_data(_arg_1:String):void
        {
            var _local_2:Object = this._179745070xml_data;
            if (_local_2 !== _arg_1)
            {
                this._179745070xml_data = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xml_data", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        public function set startPos(_arg_1:String):void
        {
            var _local_2:Object = this._1316782738startPos;
            if (_local_2 !== _arg_1)
            {
                this._1316782738startPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startPos", _local_2, _arg_1));
            };
        }

        public function set otherAllianceName(_arg_1:String):void
        {
            var _local_2:Object = this._1833139858otherAllianceName;
            if (_local_2 !== _arg_1)
            {
                this._1833139858otherAllianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "otherAllianceName", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        public function get type():int
        {
            return (this._3575610type);
        }

        [Bindable(event="propertyChange")]
        public function get eventName():String
        {
            return (this._31228997eventName);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get attack():Boolean
        {
            return (this._1407259064attack);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((((_arg_1 + "eventName = ") + this.eventName) + "\n") + (((_arg_1 + "id = ") + this.id) + "\n")) + (((_arg_1 + "otherAllianceName = ") + this.otherAllianceName) + "\n")) + (((_arg_1 + "startPos = ") + this.startPos) + "\n")) + (((_arg_1 + "targetPos = ") + this.targetPos) + "\n")) + (((_arg_1 + "time = ") + this.time) + "\n")) + (((_arg_1 + "type = ") + this.type) + "\n")) + (((_arg_1 + "xml_data = ") + this.xml_data) + "\n")) + (((_arg_1 + "attack = ") + this.attack) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get time():String
        {
            return (this._3560141time);
        }

        public function copyTo(_arg_1:MilitarySituation):void
        {
            _arg_1.eventName = this.eventName;
            _arg_1.id = this.id;
            _arg_1.otherAllianceName = this.otherAllianceName;
            _arg_1.startPos = this.startPos;
            _arg_1.targetPos = this.targetPos;
            _arg_1.time = this.time;
            _arg_1.type = this.type;
            _arg_1.xml_data = this.xml_data;
            _arg_1.attack = this.attack;
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get xml_data():String
        {
            return (this._179745070xml_data);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

