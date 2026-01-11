// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AvailableBuildingListBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class AvailableBuildingListBean implements IEventDispatcher 
    {

        private var _1371991915conditionBean:ConditionBean;
        private var _858803723typeId:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function AvailableBuildingListBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.conditionBean != null)
                {
                    this.conditionBean = new ConditionBean(_arg_1.conditionBean);
                };
                if (_arg_1.typeId != null)
                {
                    this.typeId = _arg_1.typeId;
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
            if (conditionBean != null)
            {
                _local_2 = (_local_2 + this.conditionBean.toDebugString((_arg_1 + "conditionBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "conditionBean = null\n"));
            };
            return (_local_2 + (((_arg_1 + "typeId = ") + this.typeId) + "\n"));
        }

        public function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get conditionBean():ConditionBean
        {
            return (this._1371991915conditionBean);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:AvailableBuildingListBean):void
        {
            if (conditionBean != null)
            {
                this.conditionBean.copyTo(_arg_1.conditionBean);
            }
            else
            {
                _arg_1.conditionBean = null;
            };
            _arg_1.typeId = this.typeId;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }

        public function set conditionBean(_arg_1:ConditionBean):void
        {
            var _local_2:Object = this._1371991915conditionBean;
            if (_local_2 !== _arg_1)
            {
                this._1371991915conditionBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "conditionBean", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.conditionBean = this.conditionBean.toObject();
            _local_1.typeId = this.typeId;
            return (_local_1);
        }


    }
}//package com.evony.common.beans

