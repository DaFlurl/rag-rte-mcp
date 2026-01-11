// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.CastleResourceBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class CastleResourceBean implements IEventDispatcher 
    {

        private var _3178592gold:Number;
        private var _1197906146colonyIron:Number;
        private var _1403061077complaint:int;
        private var _636575436taxIncome:int;
        private var _3655341wood:ResourceInfoBean;
        private var _1007641795troopCostFood:Number;
        private var _1167488739herosSalary:int;
        private var _1099040721maxPopulation:int;
        private var _1418848857texRate:int;
        private var _694674963supplyFood:Number;
        private var _2140939619buildPeople:int;
        private var _1510320245colonyStone:Number;
        private var _109770853stone:ResourceInfoBean;
        private var _1198320327colonyWood:Number;
        private var _1197843578colonyGold:Number;
        private var _3241160iron:ResourceInfoBean;
        private var _216564141curPopulation:int;
        private var _359111346populationDirection:int;
        private var _1197813880colonyFood:Number;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3148894food:ResourceInfoBean;
        private var _1854767153support:int;
        private var _996698880workPeople:int;

        public function CastleResourceBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.buildPeople != null)
                {
                    this.buildPeople = _arg_1.buildPeople;
                };
                if (_arg_1.colonyFood != null)
                {
                    this.colonyFood = _arg_1.colonyFood;
                };
                if (_arg_1.colonyGold != null)
                {
                    this.colonyGold = _arg_1.colonyGold;
                };
                if (_arg_1.colonyIron != null)
                {
                    this.colonyIron = _arg_1.colonyIron;
                };
                if (_arg_1.colonyStone != null)
                {
                    this.colonyStone = _arg_1.colonyStone;
                };
                if (_arg_1.colonyWood != null)
                {
                    this.colonyWood = _arg_1.colonyWood;
                };
                if (_arg_1.complaint != null)
                {
                    this.complaint = _arg_1.complaint;
                };
                if (_arg_1.curPopulation != null)
                {
                    this.curPopulation = _arg_1.curPopulation;
                };
                if (_arg_1.food != null)
                {
                    this.food = new ResourceInfoBean(_arg_1.food);
                };
                if (_arg_1.gold != null)
                {
                    this.gold = _arg_1.gold;
                };
                if (_arg_1.herosSalary != null)
                {
                    this.herosSalary = _arg_1.herosSalary;
                };
                if (_arg_1.iron != null)
                {
                    this.iron = new ResourceInfoBean(_arg_1.iron);
                };
                if (_arg_1.maxPopulation != null)
                {
                    this.maxPopulation = _arg_1.maxPopulation;
                };
                if (_arg_1.populationDirection != null)
                {
                    this.populationDirection = _arg_1.populationDirection;
                };
                if (_arg_1.stone != null)
                {
                    this.stone = new ResourceInfoBean(_arg_1.stone);
                };
                if (_arg_1.supplyFood != null)
                {
                    this.supplyFood = _arg_1.supplyFood;
                };
                if (_arg_1.support != null)
                {
                    this.support = _arg_1.support;
                };
                if (_arg_1.taxIncome != null)
                {
                    this.taxIncome = _arg_1.taxIncome;
                };
                if (_arg_1.texRate != null)
                {
                    this.texRate = _arg_1.texRate;
                };
                if (_arg_1.troopCostFood != null)
                {
                    this.troopCostFood = _arg_1.troopCostFood;
                };
                if (_arg_1.wood != null)
                {
                    this.wood = new ResourceInfoBean(_arg_1.wood);
                };
                if (_arg_1.workPeople != null)
                {
                    this.workPeople = _arg_1.workPeople;
                };
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get workPeople():int
        {
            return (this._996698880workPeople);
        }

        public function set colonyStone(_arg_1:Number):void
        {
            var _local_2:Object = this._1510320245colonyStone;
            if (_local_2 !== _arg_1)
            {
                this._1510320245colonyStone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyStone", _local_2, _arg_1));
            };
        }

        public function set workPeople(_arg_1:int):void
        {
            var _local_2:Object = this._996698880workPeople;
            if (_local_2 !== _arg_1)
            {
                this._996698880workPeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "workPeople", _local_2, _arg_1));
            };
        }

        public function set buildPeople(_arg_1:int):void
        {
            var _local_2:Object = this._2140939619buildPeople;
            if (_local_2 !== _arg_1)
            {
                this._2140939619buildPeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildPeople", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get troopCostFood():Number
        {
            return (this._1007641795troopCostFood);
        }

        [Bindable(event="propertyChange")]
        public function get taxIncome():int
        {
            return (this._636575436taxIncome);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set texRate(_arg_1:int):void
        {
            var _local_2:Object = this._1418848857texRate;
            if (_local_2 !== _arg_1)
            {
                this._1418848857texRate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "texRate", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set complaint(_arg_1:int):void
        {
            var _local_2:Object = this._1403061077complaint;
            if (_local_2 !== _arg_1)
            {
                this._1403061077complaint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "complaint", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get food():ResourceInfoBean
        {
            return (this._3148894food);
        }

        [Bindable(event="propertyChange")]
        public function get gold():Number
        {
            return (this._3178592gold);
        }

        public function set curPopulation(_arg_1:int):void
        {
            var _local_2:Object = this._216564141curPopulation;
            if (_local_2 !== _arg_1)
            {
                this._216564141curPopulation = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPopulation", _local_2, _arg_1));
            };
        }

        public function set populationDirection(_arg_1:int):void
        {
            var _local_2:Object = this._359111346populationDirection;
            if (_local_2 !== _arg_1)
            {
                this._359111346populationDirection = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "populationDirection", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stone():ResourceInfoBean
        {
            return (this._109770853stone);
        }

        public function set taxIncome(_arg_1:int):void
        {
            var _local_2:Object = this._636575436taxIncome;
            if (_local_2 !== _arg_1)
            {
                this._636575436taxIncome = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taxIncome", _local_2, _arg_1));
            };
        }

        public function set wood(_arg_1:ResourceInfoBean):void
        {
            var _local_2:Object = this._3655341wood;
            if (_local_2 !== _arg_1)
            {
                this._3655341wood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonyFood():Number
        {
            return (this._1197813880colonyFood);
        }

        public function set troopCostFood(_arg_1:Number):void
        {
            var _local_2:Object = this._1007641795troopCostFood;
            if (_local_2 !== _arg_1)
            {
                this._1007641795troopCostFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopCostFood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonyGold():Number
        {
            return (this._1197843578colonyGold);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set colonyWood(_arg_1:Number):void
        {
            var _local_2:Object = this._1198320327colonyWood;
            if (_local_2 !== _arg_1)
            {
                this._1198320327colonyWood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyWood", _local_2, _arg_1));
            };
        }

        public function set iron(_arg_1:ResourceInfoBean):void
        {
            var _local_2:Object = this._3241160iron;
            if (_local_2 !== _arg_1)
            {
                this._3241160iron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iron", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonyStone():Number
        {
            return (this._1510320245colonyStone);
        }

        public function set support(_arg_1:int):void
        {
            var _local_2:Object = this._1854767153support;
            if (_local_2 !== _arg_1)
            {
                this._1854767153support = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "support", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.buildPeople = this.buildPeople;
            _local_1.colonyFood = this.colonyFood;
            _local_1.colonyGold = this.colonyGold;
            _local_1.colonyIron = this.colonyIron;
            _local_1.colonyStone = this.colonyStone;
            _local_1.colonyWood = this.colonyWood;
            _local_1.complaint = this.complaint;
            _local_1.curPopulation = this.curPopulation;
            _local_1.food = this.food.toObject();
            _local_1.gold = this.gold;
            _local_1.herosSalary = this.herosSalary;
            _local_1.iron = this.iron.toObject();
            _local_1.maxPopulation = this.maxPopulation;
            _local_1.populationDirection = this.populationDirection;
            _local_1.stone = this.stone.toObject();
            _local_1.supplyFood = this.supplyFood;
            _local_1.support = this.support;
            _local_1.taxIncome = this.taxIncome;
            _local_1.texRate = this.texRate;
            _local_1.troopCostFood = this.troopCostFood;
            _local_1.wood = this.wood.toObject();
            _local_1.workPeople = this.workPeople;
            return (_local_1);
        }

        public function set maxPopulation(_arg_1:int):void
        {
            var _local_2:Object = this._1099040721maxPopulation;
            if (_local_2 !== _arg_1)
            {
                this._1099040721maxPopulation = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxPopulation", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get texRate():int
        {
            return (this._1418848857texRate);
        }

        [Bindable(event="propertyChange")]
        public function get buildPeople():int
        {
            return (this._2140939619buildPeople);
        }

        [Bindable(event="propertyChange")]
        public function get curPopulation():int
        {
            return (this._216564141curPopulation);
        }

        [Bindable(event="propertyChange")]
        public function get complaint():int
        {
            return (this._1403061077complaint);
        }

        [Bindable(event="propertyChange")]
        public function get populationDirection():int
        {
            return (this._359111346populationDirection);
        }

        [Bindable(event="propertyChange")]
        public function get wood():ResourceInfoBean
        {
            return (this._3655341wood);
        }

        public function set gold(_arg_1:Number):void
        {
            var _local_2:Object = this._3178592gold;
            if (_local_2 !== _arg_1)
            {
                this._3178592gold = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gold", _local_2, _arg_1));
            };
        }

        public function set food(_arg_1:ResourceInfoBean):void
        {
            var _local_2:Object = this._3148894food;
            if (_local_2 !== _arg_1)
            {
                this._3148894food = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "food", _local_2, _arg_1));
            };
        }

        public function set colonyIron(_arg_1:Number):void
        {
            var _local_2:Object = this._1197906146colonyIron;
            if (_local_2 !== _arg_1)
            {
                this._1197906146colonyIron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyIron", _local_2, _arg_1));
            };
        }

        public function set herosSalary(_arg_1:int):void
        {
            var _local_2:Object = this._1167488739herosSalary;
            if (_local_2 !== _arg_1)
            {
                this._1167488739herosSalary = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "herosSalary", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonyWood():Number
        {
            return (this._1198320327colonyWood);
        }

        [Bindable(event="propertyChange")]
        public function get iron():ResourceInfoBean
        {
            return (this._3241160iron);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "buildPeople = ") + this.buildPeople) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "colonyFood = ") + this.colonyFood) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "colonyGold = ") + this.colonyGold) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "colonyIron = ") + this.colonyIron) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "colonyStone = ") + this.colonyStone) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "colonyWood = ") + this.colonyWood) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "complaint = ") + this.complaint) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "curPopulation = ") + this.curPopulation) + "\n"));
            if (food != null)
            {
                _local_2 = (_local_2 + this.food.toDebugString((_arg_1 + "food.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "food = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "gold = ") + this.gold) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "herosSalary = ") + this.herosSalary) + "\n"));
            if (iron != null)
            {
                _local_2 = (_local_2 + this.iron.toDebugString((_arg_1 + "iron.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "iron = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "maxPopulation = ") + this.maxPopulation) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "populationDirection = ") + this.populationDirection) + "\n"));
            if (stone != null)
            {
                _local_2 = (_local_2 + this.stone.toDebugString((_arg_1 + "stone.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "stone = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "supplyFood = ") + this.supplyFood) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "support = ") + this.support) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "taxIncome = ") + this.taxIncome) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "texRate = ") + this.texRate) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "troopCostFood = ") + this.troopCostFood) + "\n"));
            if (wood != null)
            {
                _local_2 = (_local_2 + this.wood.toDebugString((_arg_1 + "wood.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "wood = null\n"));
            };
            return (_local_2 + (((_arg_1 + "workPeople = ") + this.workPeople) + "\n"));
        }

        public function set stone(_arg_1:ResourceInfoBean):void
        {
            var _local_2:Object = this._109770853stone;
            if (_local_2 !== _arg_1)
            {
                this._109770853stone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stone", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get support():int
        {
            return (this._1854767153support);
        }

        [Bindable(event="propertyChange")]
        public function get maxPopulation():int
        {
            return (this._1099040721maxPopulation);
        }

        public function copyTo(_arg_1:CastleResourceBean):void
        {
            _arg_1.buildPeople = this.buildPeople;
            _arg_1.colonyFood = this.colonyFood;
            _arg_1.colonyGold = this.colonyGold;
            _arg_1.colonyIron = this.colonyIron;
            _arg_1.colonyStone = this.colonyStone;
            _arg_1.colonyWood = this.colonyWood;
            _arg_1.complaint = this.complaint;
            _arg_1.curPopulation = this.curPopulation;
            if (food != null)
            {
                this.food.copyTo(_arg_1.food);
            }
            else
            {
                _arg_1.food = null;
            };
            _arg_1.gold = this.gold;
            _arg_1.herosSalary = this.herosSalary;
            if (iron != null)
            {
                this.iron.copyTo(_arg_1.iron);
            }
            else
            {
                _arg_1.iron = null;
            };
            _arg_1.maxPopulation = this.maxPopulation;
            _arg_1.populationDirection = this.populationDirection;
            if (stone != null)
            {
                this.stone.copyTo(_arg_1.stone);
            }
            else
            {
                _arg_1.stone = null;
            };
            _arg_1.supplyFood = this.supplyFood;
            _arg_1.support = this.support;
            _arg_1.taxIncome = this.taxIncome;
            _arg_1.texRate = this.texRate;
            _arg_1.troopCostFood = this.troopCostFood;
            if (wood != null)
            {
                this.wood.copyTo(_arg_1.wood);
            }
            else
            {
                _arg_1.wood = null;
            };
            _arg_1.workPeople = this.workPeople;
        }

        public function set supplyFood(_arg_1:Number):void
        {
            var _local_2:Object = this._694674963supplyFood;
            if (_local_2 !== _arg_1)
            {
                this._694674963supplyFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "supplyFood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonyIron():Number
        {
            return (this._1197906146colonyIron);
        }

        [Bindable(event="propertyChange")]
        public function get herosSalary():int
        {
            return (this._1167488739herosSalary);
        }

        [Bindable(event="propertyChange")]
        public function get supplyFood():Number
        {
            return (this._694674963supplyFood);
        }

        public function set colonyFood(_arg_1:Number):void
        {
            var _local_2:Object = this._1197813880colonyFood;
            if (_local_2 !== _arg_1)
            {
                this._1197813880colonyFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyFood", _local_2, _arg_1));
            };
        }

        public function set colonyGold(_arg_1:Number):void
        {
            var _local_2:Object = this._1197843578colonyGold;
            if (_local_2 !== _arg_1)
            {
                this._1197843578colonyGold = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyGold", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

