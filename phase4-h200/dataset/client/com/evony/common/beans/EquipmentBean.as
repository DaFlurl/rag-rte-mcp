// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.EquipmentBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class EquipmentBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _124815621addAttribute:int;
        private var _3466lv:int;
        private var _811315194heroPos:int;
        private var _1188050137euipmenttechStarLv:int;
        private var _2008330532equipmenttech:int;
        private var _1512209195addAttributeType:int;

        public function EquipmentBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.addAttribute != null)
                {
                    this.addAttribute = _arg_1.addAttribute;
                };
                if (_arg_1.addAttributeType != null)
                {
                    this.addAttributeType = _arg_1.addAttributeType;
                };
                if (_arg_1.equipmenttech != null)
                {
                    this.equipmenttech = _arg_1.equipmenttech;
                };
                if (_arg_1.euipmenttechStarLv != null)
                {
                    this.euipmenttechStarLv = _arg_1.euipmenttechStarLv;
                };
                if (_arg_1.heroPos != null)
                {
                    this.heroPos = _arg_1.heroPos;
                };
                if (_arg_1.lv != null)
                {
                    this.lv = _arg_1.lv;
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

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "addAttribute = ") + this.addAttribute) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "addAttributeType = ") + this.addAttributeType) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "equipmenttech = ") + this.equipmenttech) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "euipmenttechStarLv = ") + this.euipmenttechStarLv) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "heroPos = ") + this.heroPos) + "\n"));
            return (_local_2 + (((_arg_1 + "lv = ") + this.lv) + "\n"));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set euipmenttechStarLv(_arg_1:int):void
        {
            var _local_2:Object = this._1188050137euipmenttechStarLv;
            if (_local_2 !== _arg_1)
            {
                this._1188050137euipmenttechStarLv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "euipmenttechStarLv", _local_2, _arg_1));
            };
        }

        public function set equipmenttech(_arg_1:int):void
        {
            var _local_2:Object = this._2008330532equipmenttech;
            if (_local_2 !== _arg_1)
            {
                this._2008330532equipmenttech = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipmenttech", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get lv():int
        {
            return (this._3466lv);
        }

        [Bindable(event="propertyChange")]
        public function get addAttributeType():int
        {
            return (this._1512209195addAttributeType);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.addAttribute = this.addAttribute;
            _local_1.addAttributeType = this.addAttributeType;
            _local_1.equipmenttech = this.equipmenttech;
            _local_1.euipmenttechStarLv = this.euipmenttechStarLv;
            _local_1.heroPos = this.heroPos;
            _local_1.lv = this.lv;
            return (_local_1);
        }

        public function copyTo(_arg_1:EquipmentBean):void
        {
            _arg_1.addAttribute = this.addAttribute;
            _arg_1.addAttributeType = this.addAttributeType;
            _arg_1.equipmenttech = this.equipmenttech;
            _arg_1.euipmenttechStarLv = this.euipmenttechStarLv;
            _arg_1.heroPos = this.heroPos;
            _arg_1.lv = this.lv;
        }

        public function set lv(_arg_1:int):void
        {
            var _local_2:Object = this._3466lv;
            if (_local_2 !== _arg_1)
            {
                this._3466lv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lv", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get equipmenttech():int
        {
            return (this._2008330532equipmenttech);
        }

        [Bindable(event="propertyChange")]
        public function get euipmenttechStarLv():int
        {
            return (this._1188050137euipmenttechStarLv);
        }

        public function set addAttributeType(_arg_1:int):void
        {
            var _local_2:Object = this._1512209195addAttributeType;
            if (_local_2 !== _arg_1)
            {
                this._1512209195addAttributeType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addAttributeType", _local_2, _arg_1));
            };
        }

        public function set heroPos(_arg_1:int):void
        {
            var _local_2:Object = this._811315194heroPos;
            if (_local_2 !== _arg_1)
            {
                this._811315194heroPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPos", _local_2, _arg_1));
            };
        }

        public function set addAttribute(_arg_1:int):void
        {
            var _local_2:Object = this._124815621addAttribute;
            if (_local_2 !== _arg_1)
            {
                this._124815621addAttribute = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addAttribute", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroPos():int
        {
            return (this._811315194heroPos);
        }

        [Bindable(event="propertyChange")]
        public function get addAttribute():int
        {
            return (this._124815621addAttribute);
        }


    }
}//package com.evony.common.beans

