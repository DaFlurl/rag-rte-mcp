// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.FortProduceListBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class FortProduceListBean implements IEventDispatcher 
    {

        private var _bindingEventDispatcher:EventDispatcher;
        private var _1371991915conditionBean:ConditionBean;
        private var _858803723typeId:int;
        private var _676059661permition:Boolean;

        public function FortProduceListBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
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
                if (_arg_1.permition != null)
                {
                    this.permition = _arg_1.permition;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((this.conditionBean != null) ? this.conditionBean.toDebugString((_arg_1 + "conditionBean.")) : (_arg_1 + "conditionBean = null\n")) + (((_arg_1 + "typeId = ") + this.typeId) + "\n")) + (((_arg_1 + "permition = ") + this.permition) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:FortProduceListBean):void
        {
            if (this.conditionBean != null)
            {
                this.conditionBean.copyTo(_arg_1.conditionBean);
            }
            else
            {
                _arg_1.conditionBean = null;
            };
            _arg_1.typeId = this.typeId;
            _arg_1.permition = this.permition;
        }

        [Bindable(event="propertyChange")]
        public function get permition():Boolean
        {
            return (this._676059661permition);
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

        public function set permition(_arg_1:Boolean):void
        {
            var _local_2:Object = this._676059661permition;
            if (_local_2 !== _arg_1)
            {
                this._676059661permition = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "permition", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            return ({
                "conditionBean":this.conditionBean.toObject(),
                "typeId":this.typeId,
                "permition":this.permition
            });
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

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }


    }
}//package com.evony.common.beans

