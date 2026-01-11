// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.FieldBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.collections.ArrayCollection;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.CommonUtil;

    public class FieldBean implements IEventDispatcher 
    {

        private var _3355id:int;
        private var _109757601statu:int;
        private var _3373707name:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3575610type:int;
        private var _1710868093armysArray:ArrayCollection;
        private var _102865796level:int;

        public function FieldBean(_arg_1:Object=null)
        {
            var _local_2:ArmyBean;
            var _local_3:int;
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this.armysArray = new ArrayCollection();
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.name != null)
                {
                    this.name = _arg_1.name;
                };
                if (_arg_1.statu != null)
                {
                    this.statu = _arg_1.statu;
                };
                if (_arg_1.type != null)
                {
                    this.type = _arg_1.type;
                };
                if (_arg_1.armys)
                {
                    _local_2 = null;
                    _local_3 = 0;
                    while (_local_3 < _arg_1.armys.length)
                    {
                        _local_2 = new ArmyBean(_arg_1.armys[_local_3]);
                        this.armysArray.addItem(_local_2);
                        _local_3++;
                    };
                };
            };
        }

        public function getArmys(_arg_1:int):ArmyBean
        {
            return (this.armysArray[_arg_1] as ArmyBean);
        }

        public function set statu(_arg_1:int):void
        {
            var _local_2:Object = this._109757601statu;
            if (_local_2 !== _arg_1)
            {
                this._109757601statu = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statu", _local_2, _arg_1));
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
        public function get level():int
        {
            return (this._102865796level);
        }

        public function set armysArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1710868093armysArray;
            if (_local_2 !== _arg_1)
            {
                this._1710868093armysArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armysArray", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = (((((((_arg_1 + "id = ") + this.id) + "\n") + (((_arg_1 + "level = ") + this.level) + "\n")) + (((_arg_1 + "name = ") + this.name) + "\n")) + (((_arg_1 + "statu = ") + this.statu) + "\n")) + (((_arg_1 + "type = ") + this.type) + "\n"));
            var _local_3:int;
            while (_local_3 < this.armysArray.length)
            {
                _local_2 = (_local_2 + this.getArmys(_local_3).toDebugString((((_arg_1 + "armys[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get armysArray():ArrayCollection
        {
            return (this._1710868093armysArray);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
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

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get type():int
        {
            return (this._3575610type);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
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
            return ({
                "id":this.id,
                "level":this.level,
                "name":this.name,
                "statu":this.statu,
                "type":this.type
            });
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function copyTo(_arg_1:FieldBean):void
        {
            _arg_1.id = this.id;
            _arg_1.level = this.level;
            _arg_1.name = this.name;
            _arg_1.statu = this.statu;
            _arg_1.type = this.type;
            CommonUtil.arrayCopy(this.armysArray, _arg_1.armysArray);
        }

        [Bindable(event="propertyChange")]
        public function get statu():int
        {
            return (this._109757601statu);
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

        public function setArmys(_arg_1:ArmyBean, _arg_2:int):void
        {
            this.armysArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.beans

