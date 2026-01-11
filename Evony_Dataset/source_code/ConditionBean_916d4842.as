// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ConditionBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import mx.collections.ArrayCollection;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.CommonUtil;

    public class ConditionBean implements IEventDispatcher 
    {

        private var _109770853stone:int;
        private var _3178592gold:int;
        private var _3241160iron:int;
        private var _895975549destructTime:Number;
        private var _1425640839itemsArray:ArrayCollection;
        private var _1578480708techsArray:ArrayCollection;
        private var _3655341wood:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _2023558323population:int;
        private var _3148894food:int;
        private var _1632439642buildingsArray:ArrayCollection;
        private var _3560141time:Number;

        public function ConditionBean(_arg_1:Object=null)
        {
            var _local_2:int;
            var _local_3:ConditionDependBuildingBean;
            var _local_4:ConditionDependItemBean;
            var _local_5:ConditionDependTechBean;
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            this.buildingsArray = new ArrayCollection();
            this.itemsArray = new ArrayCollection();
            this.techsArray = new ArrayCollection();
            if (_arg_1 != null)
            {
                if (_arg_1.destructTime != null)
                {
                    this.destructTime = _arg_1.destructTime;
                };
                if (_arg_1.food != null)
                {
                    this.food = _arg_1.food;
                };
                if (_arg_1.gold != null)
                {
                    this.gold = _arg_1.gold;
                };
                if (_arg_1.iron != null)
                {
                    this.iron = _arg_1.iron;
                };
                if (_arg_1.population != null)
                {
                    this.population = _arg_1.population;
                };
                if (_arg_1.stone != null)
                {
                    this.stone = _arg_1.stone;
                };
                if (_arg_1.time != null)
                {
                    this.time = _arg_1.time;
                };
                if (_arg_1.wood != null)
                {
                    this.wood = _arg_1.wood;
                };
                _local_2 = 0;
                if (_arg_1.buildings)
                {
                    _local_3 = null;
                    _local_2 = 0;
                    while (_local_2 < _arg_1.buildings.length)
                    {
                        _local_3 = new ConditionDependBuildingBean(_arg_1.buildings[_local_2]);
                        this.buildingsArray.addItem(_local_3);
                        _local_2++;
                    };
                };
                if (_arg_1.items)
                {
                    _local_4 = null;
                    _local_2 = 0;
                    while (_local_2 < _arg_1.items.length)
                    {
                        _local_4 = new ConditionDependItemBean(_arg_1.items[_local_2]);
                        this.itemsArray.addItem(_local_4);
                        _local_2++;
                    };
                };
                if (_arg_1.techs)
                {
                    _local_5 = null;
                    _local_2 = 0;
                    while (_local_2 < _arg_1.techs.length)
                    {
                        _local_5 = new ConditionDependTechBean(_arg_1.techs[_local_2]);
                        this.techsArray.addItem(_local_5);
                        _local_2++;
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get destructTime():Number
        {
            return (this._895975549destructTime);
        }

        public function set destructTime(_arg_1:Number):void
        {
            var _local_2:Object = this._895975549destructTime;
            if (_local_2 !== _arg_1)
            {
                this._895975549destructTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "destructTime", _local_2, _arg_1));
            };
        }

        public function getBuildings(_arg_1:int):ConditionDependBuildingBean
        {
            return (this.buildingsArray[_arg_1] as ConditionDependBuildingBean);
        }

        public function getItems(_arg_1:int):ConditionDependItemBean
        {
            return (this.itemsArray[_arg_1] as ConditionDependItemBean);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set iron(_arg_1:int):void
        {
            var _local_2:Object = this._3241160iron;
            if (_local_2 !== _arg_1)
            {
                this._3241160iron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iron", _local_2, _arg_1));
            };
        }

        public function set population(_arg_1:int):void
        {
            var _local_2:Object = this._2023558323population;
            if (_local_2 !== _arg_1)
            {
                this._2023558323population = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            return ({
                "destructTime":this.destructTime,
                "food":this.food,
                "gold":this.gold,
                "iron":this.iron,
                "population":this.population,
                "stone":this.stone,
                "time":this.time,
                "wood":this.wood
            });
        }

        public function set time(_arg_1:Number):void
        {
            var _local_2:Object = this._3560141time;
            if (_local_2 !== _arg_1)
            {
                this._3560141time = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get wood():int
        {
            return (this._3655341wood);
        }

        public function set buildingsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1632439642buildingsArray;
            if (_local_2 !== _arg_1)
            {
                this._1632439642buildingsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingsArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get techsArray():ArrayCollection
        {
            return (this._1578480708techsArray);
        }

        public function set food(_arg_1:int):void
        {
            var _local_2:Object = this._3148894food;
            if (_local_2 !== _arg_1)
            {
                this._3148894food = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "food", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iron():int
        {
            return (this._3241160iron);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = ((((((((((_arg_1 + "destructTime = ") + this.destructTime) + "\n") + (((_arg_1 + "food = ") + this.food) + "\n")) + (((_arg_1 + "gold = ") + this.gold) + "\n")) + (((_arg_1 + "iron = ") + this.iron) + "\n")) + (((_arg_1 + "population = ") + this.population) + "\n")) + (((_arg_1 + "stone = ") + this.stone) + "\n")) + (((_arg_1 + "time = ") + this.time) + "\n")) + (((_arg_1 + "wood = ") + this.wood) + "\n"));
            var _local_3:int;
            while (_local_3 < this.buildingsArray.length)
            {
                _local_2 = (_local_2 + this.getBuildings(_local_3).toDebugString((((_arg_1 + "buildingsArray[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.itemsArray.length)
            {
                _local_2 = (_local_2 + this.getItems(_local_3).toDebugString((((_arg_1 + "itemsArray[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.techsArray.length)
            {
                _local_2 = (_local_2 + this.getTechs(_local_3).toDebugString((((_arg_1 + "techsArray[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function set stone(_arg_1:int):void
        {
            var _local_2:Object = this._109770853stone;
            if (_local_2 !== _arg_1)
            {
                this._109770853stone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stone", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get population():int
        {
            return (this._2023558323population);
        }

        public function set gold(_arg_1:int):void
        {
            var _local_2:Object = this._3178592gold;
            if (_local_2 !== _arg_1)
            {
                this._3178592gold = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gold", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get buildingsArray():ArrayCollection
        {
            return (this._1632439642buildingsArray);
        }

        public function setTechs(_arg_1:ConditionDependTechBean, _arg_2:int):void
        {
            this.techsArray[_arg_2] = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get time():Number
        {
            return (this._3560141time);
        }

        [Bindable(event="propertyChange")]
        public function get food():int
        {
            return (this._3148894food);
        }

        public function copyTo(_arg_1:ConditionBean):void
        {
            _arg_1.destructTime = this.destructTime;
            _arg_1.food = this.food;
            _arg_1.gold = this.gold;
            _arg_1.iron = this.iron;
            _arg_1.population = this.population;
            _arg_1.stone = this.stone;
            _arg_1.time = this.time;
            _arg_1.wood = this.wood;
            CommonUtil.arrayCopy(this.buildingsArray, _arg_1.buildingsArray);
            CommonUtil.arrayCopy(this.itemsArray, _arg_1.itemsArray);
            CommonUtil.arrayCopy(this.techsArray, _arg_1.techsArray);
        }

        public function set wood(_arg_1:int):void
        {
            var _local_2:Object = this._3655341wood;
            if (_local_2 !== _arg_1)
            {
                this._3655341wood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stone():int
        {
            return (this._109770853stone);
        }

        [Bindable(event="propertyChange")]
        public function get gold():int
        {
            return (this._3178592gold);
        }

        public function getTechs(_arg_1:int):ConditionDependTechBean
        {
            return (this.techsArray[_arg_1] as ConditionDependTechBean);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set itemsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1425640839itemsArray;
            if (_local_2 !== _arg_1)
            {
                this._1425640839itemsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemsArray", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set techsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1578480708techsArray;
            if (_local_2 !== _arg_1)
            {
                this._1578480708techsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techsArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemsArray():ArrayCollection
        {
            return (this._1425640839itemsArray);
        }

        public function setBuildings(_arg_1:ConditionDependBuildingBean, _arg_2:int):void
        {
            this.buildingsArray[_arg_2] = _arg_1;
        }

        public function setItems(_arg_1:ConditionDependItemBean, _arg_2:int):void
        {
            this.itemsArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.beans

