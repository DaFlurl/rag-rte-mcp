// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.EquipmenttechBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class EquipmenttechBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _3466lv:int;
        private var _1565328703equipmenttechid:int;

        public function EquipmenttechBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.equipmenttechid != null)
                {
                    this.equipmenttechid = _arg_1.equipmenttechid;
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
            _local_2 = (_local_2 + (((_arg_1 + "equipmenttechid = ") + this.equipmenttechid) + "\n"));
            return (_local_2 + (((_arg_1 + "lv = ") + this.lv) + "\n"));
        }

        [Bindable(event="propertyChange")]
        public function get lv():int
        {
            return (this._3466lv);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:EquipmenttechBean):void
        {
            _arg_1.equipmenttechid = this.equipmenttechid;
            _arg_1.lv = this.lv;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.equipmenttechid = this.equipmenttechid;
            _local_1.lv = this.lv;
            return (_local_1);
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

        public function set equipmenttechid(_arg_1:int):void
        {
            var _local_2:Object = this._1565328703equipmenttechid;
            if (_local_2 !== _arg_1)
            {
                this._1565328703equipmenttechid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipmenttechid", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get equipmenttechid():int
        {
            return (this._1565328703equipmenttechid);
        }


    }
}//package com.evony.common.beans

