// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ReportBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ReportBean implements IEventDispatcher 
    {

        private var _110371416title:String;
        private var _1316782738startPos:String;
        private var _3575610type:int;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1414939017armyType:int;
        private var _1191572123selected:Boolean;
        private var _951530617content:String;
        private var _1180158496isRead:int;
        private var _3015911back:Boolean;
        private var _1407259064attack:Boolean;
        private var _31415431eventTime:String;
        private var _815590653targetPos:String;

        public function ReportBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.armyType != null)
                {
                    this.armyType = _arg_1.armyType;
                };
                if (_arg_1.content != null)
                {
                    this.content = _arg_1.content;
                };
                if (_arg_1.eventTime != null)
                {
                    this.eventTime = _arg_1.eventTime;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.isRead != null)
                {
                    this.isRead = _arg_1.isRead;
                };
                if (_arg_1.startPos != null)
                {
                    this.startPos = _arg_1.startPos;
                };
                if (_arg_1.targetPos != null)
                {
                    this.targetPos = _arg_1.targetPos;
                };
                if (_arg_1.title != null)
                {
                    this.title = _arg_1.title;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
                if (_arg_1.attack != null)
                {
                    this.attack = _arg_1.attack;
                };
                if (_arg_1.back != null)
                {
                    this.back = _arg_1.back;
                };
                if (_arg_1.selected != null)
                {
                    this.selected = _arg_1.selected;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get eventTime():String
        {
            return (this._31415431eventTime);
        }

        [Bindable(event="propertyChange")]
        public function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
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

        public function set eventTime(_arg_1:String):void
        {
            var _local_2:Object = this._31415431eventTime;
            if (_local_2 !== _arg_1)
            {
                this._31415431eventTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eventTime", _local_2, _arg_1));
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

        public function set attack(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1407259064attack;
            if (_local_2 !== _arg_1)
            {
                this._1407259064attack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attack", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            return ({
                "armyType":this.armyType,
                "content":this.content,
                "eventTime":this.eventTime,
                "id":this.id,
                "isRead":this.isRead,
                "startPos":this.startPos,
                "targetPos":this.targetPos,
                "title":this.title,
                "type":this.type,
                "attack":this.attack,
                "back":this.back,
                "selected":this.selected
            });
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        [Bindable(event="propertyChange")]
        public function get selected():Boolean
        {
            return (this._1191572123selected);
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

        public function set title(_arg_1:String):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
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
        public function get attack():Boolean
        {
            return (this._1407259064attack);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((((((((_arg_1 + "armyType = ") + this.armyType) + "\n") + (((_arg_1 + "content = ") + this.content) + "\n")) + (((_arg_1 + "eventTime = ") + this.eventTime) + "\n")) + (((_arg_1 + "id = ") + this.id) + "\n")) + (((_arg_1 + "isRead = ") + this.isRead) + "\n")) + (((_arg_1 + "startPos = ") + this.startPos) + "\n")) + (((_arg_1 + "targetPos = ") + this.targetPos) + "\n")) + (((_arg_1 + "title = ") + this.title) + "\n")) + (((_arg_1 + "type = ") + this.type) + "\n")) + (((_arg_1 + "attack = ") + this.attack) + "\n")) + (((_arg_1 + "back = ") + this.back) + "\n")) + (((_arg_1 + "selected = ") + this.selected) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set back(_arg_1:Boolean):void
        {
            var _local_2:Object = this._3015911back;
            if (_local_2 !== _arg_1)
            {
                this._3015911back = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "back", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:ReportBean):void
        {
            _arg_1.armyType = this.armyType;
            _arg_1.content = this.content;
            _arg_1.eventTime = this.eventTime;
            _arg_1.id = this.id;
            _arg_1.isRead = this.isRead;
            _arg_1.startPos = this.startPos;
            _arg_1.targetPos = this.targetPos;
            _arg_1.title = this.title;
            _arg_1.type = this.type;
            _arg_1.attack = this.attack;
            _arg_1.back = this.back;
            _arg_1.selected = this.selected;
        }

        [Bindable(event="propertyChange")]
        public function get title():String
        {
            return (this._110371416title);
        }

        [Bindable(event="propertyChange")]
        public function get isRead():int
        {
            return (this._1180158496isRead);
        }

        public function set armyType(_arg_1:int):void
        {
            var _local_2:Object = this._1414939017armyType;
            if (_local_2 !== _arg_1)
            {
                this._1414939017armyType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyType", _local_2, _arg_1));
            };
        }

        public function set content(_arg_1:String):void
        {
            var _local_2:Object = this._951530617content;
            if (_local_2 !== _arg_1)
            {
                this._951530617content = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "content", _local_2, _arg_1));
            };
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
        public function get armyType():int
        {
            return (this._1414939017armyType);
        }

        [Bindable(event="propertyChange")]
        public function get content():String
        {
            return (this._951530617content);
        }

        [Bindable(event="propertyChange")]
        public function get back():Boolean
        {
            return (this._3015911back);
        }


    }
}//package com.evony.common.beans

