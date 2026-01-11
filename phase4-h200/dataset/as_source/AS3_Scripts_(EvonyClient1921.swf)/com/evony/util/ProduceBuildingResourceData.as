// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.ProduceBuildingResourceData

package com.evony.util
{
    import flash.events.IEventDispatcher;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ConditionBean;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import com.evony.Context;
    import com.evony.common.beans.CastleResourceBean;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;

    public class ProduceBuildingResourceData implements IEventDispatcher 
    {

        private var _391131953dataArray:ArrayCollection;
        private var conditionBean:ConditionBean;
        private var _bindingEventDispatcher:EventDispatcher;

        private var foodBean:ProduceBuildingResourceDataUnit = new ProduceBuildingResourceDataUnit();
        private var woodBean:ProduceBuildingResourceDataUnit = new ProduceBuildingResourceDataUnit();
        private var ironBean:ProduceBuildingResourceDataUnit = new ProduceBuildingResourceDataUnit();
        private var stoneBean:ProduceBuildingResourceDataUnit = new ProduceBuildingResourceDataUnit();

        public function ProduceBuildingResourceData(_arg_1:ConditionBean)
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            this.conditionBean = _arg_1;
            this.initDataArray();
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function reCalcDataArray(_arg_1:int):void
        {
            if (_arg_1 == 0)
            {
                _arg_1 = 1;
            };
            this.foodBean.needAmount = (_arg_1 * conditionBean.food);
            this.woodBean.needAmount = (_arg_1 * conditionBean.wood);
            this.stoneBean.needAmount = (_arg_1 * conditionBean.stone);
            this.ironBean.needAmount = (_arg_1 * conditionBean.iron);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get dataArray():ArrayCollection
        {
            return (this._391131953dataArray);
        }

        public function calcMaxProduce():int
        {
            var _local_1:int = conditionBean.food;
            var _local_2:int = conditionBean.wood;
            var _local_3:int = conditionBean.stone;
            var _local_4:int = conditionBean.iron;
            var _local_5:CastleResourceBean = Context.getInstance().getCurCastle().resource;
            var _local_6:Number = Number.MAX_VALUE;
            if (_local_1 > 0)
            {
                _local_6 = Math.min(_local_6, ((_local_5.food.amount - (((_local_5.food.amount / 20) < 10000) ? (_local_5.food.amount / 20) : 10000)) / _local_1));
            };
            if (_local_2 > 0)
            {
                _local_6 = Math.min(_local_6, ((_local_5.wood.amount - (((_local_5.wood.amount / 20) < 10000) ? (_local_5.wood.amount / 20) : 10000)) / _local_2));
            };
            if (_local_3 > 0)
            {
                _local_6 = Math.min(_local_6, ((_local_5.stone.amount - (((_local_5.stone.amount / 20) < 10000) ? (_local_5.stone.amount / 20) : 10000)) / _local_3));
            };
            if (_local_4 > 0)
            {
                _local_6 = Math.min(_local_6, ((_local_5.iron.amount - (((_local_5.iron.amount / 20) < 10000) ? (_local_5.iron.amount / 20) : 10000)) / _local_4));
            };
            return (_local_6);
        }

        public function set dataArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._391131953dataArray;
            if (_local_2 !== _arg_1)
            {
                this._391131953dataArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataArray", _local_2, _arg_1));
            };
        }

        private function initDataArray():void
        {
            var _local_1:CastleResourceBean = Context.getInstance().getCurCastle().resource;
            dataArray = new ArrayCollection();
            if (conditionBean == null)
            {
                return;
            };
            if (conditionBean.food > 0)
            {
                foodBean.typeName = Lang.msg("消耗粮食");
                foodBean.currentAmount = Math.floor(_local_1.food.amount);
                dataArray.addItem(foodBean);
            };
            if (conditionBean.wood > 0)
            {
                woodBean.typeName = Lang.msg("消耗木材");
                woodBean.currentAmount = Math.floor(_local_1.wood.amount);
                dataArray.addItem(woodBean);
            };
            if (conditionBean.stone > 0)
            {
                stoneBean.typeName = Lang.msg("消耗石料");
                stoneBean.currentAmount = Math.floor(_local_1.stone.amount);
                dataArray.addItem(stoneBean);
            };
            if (conditionBean.iron > 0)
            {
                ironBean.typeName = Lang.msg("消耗铁锭");
                ironBean.currentAmount = Math.floor(_local_1.iron.amount);
                dataArray.addItem(ironBean);
            };
        }

        public function reCalcDataArrayForDisband(_arg_1:int):void
        {
            if (_arg_1 == 0)
            {
                _arg_1 = 1;
            };
            this.foodBean.needAmount = int(((_arg_1 * conditionBean.food) * 0.3));
            this.woodBean.needAmount = int(((_arg_1 * conditionBean.wood) * 0.3));
            this.stoneBean.needAmount = int(((_arg_1 * conditionBean.stone) * 0.3));
            this.ironBean.needAmount = int(((_arg_1 * conditionBean.iron) * 0.3));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.util

