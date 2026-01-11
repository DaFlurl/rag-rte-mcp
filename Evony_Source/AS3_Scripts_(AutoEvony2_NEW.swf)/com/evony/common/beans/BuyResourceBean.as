// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.BuyResourceBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class BuyResourceBean implements IEventDispatcher 
    {

        private var _678500047forIron:int;
        private var _678592313forFood:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _504430457woodRemain:int;
        private var _449807254foodRemain:int;
        private var _450629916forStone:int;
        private var _1881641644ironRemain:int;
        private var _252311759stoneRemain:int;
        private var _678085866forWood:int;

        public function BuyResourceBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.foodRemain != null)
                {
                    this.foodRemain = _arg_1.foodRemain;
                };
                if (_arg_1.forFood != null)
                {
                    this.forFood = _arg_1.forFood;
                };
                if (_arg_1.forIron != null)
                {
                    this.forIron = _arg_1.forIron;
                };
                if (_arg_1.forStone != null)
                {
                    this.forStone = _arg_1.forStone;
                };
                if (_arg_1.forWood != null)
                {
                    this.forWood = _arg_1.forWood;
                };
                if (_arg_1.ironRemain != null)
                {
                    this.ironRemain = _arg_1.ironRemain;
                };
                if (_arg_1.stoneRemain != null)
                {
                    this.stoneRemain = _arg_1.stoneRemain;
                };
                if (_arg_1.woodRemain != null)
                {
                    this.woodRemain = _arg_1.woodRemain;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get woodRemain():int
        {
            return (this._504430457woodRemain);
        }

        public function set woodRemain(_arg_1:int):void
        {
            var _local_2:Object = this._504430457woodRemain;
            if (_local_2 !== _arg_1)
            {
                this._504430457woodRemain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "woodRemain", _local_2, _arg_1));
            };
        }

        public function set forWood(_arg_1:int):void
        {
            var _local_2:Object = this._678085866forWood;
            if (_local_2 !== _arg_1)
            {
                this._678085866forWood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forWood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get forFood():int
        {
            return (this._678592313forFood);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((((_arg_1 + "foodRemain = ") + this.foodRemain) + "\n") + (((_arg_1 + "forFood = ") + this.forFood) + "\n")) + (((_arg_1 + "forIron = ") + this.forIron) + "\n")) + (((_arg_1 + "forStone = ") + this.forStone) + "\n")) + (((_arg_1 + "forWood = ") + this.forWood) + "\n")) + (((_arg_1 + "ironRemain = ") + this.ironRemain) + "\n")) + (((_arg_1 + "stoneRemain = ") + this.stoneRemain) + "\n")) + (((_arg_1 + "woodRemain = ") + this.woodRemain) + "\n"));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set forFood(_arg_1:int):void
        {
            var _local_2:Object = this._678592313forFood;
            if (_local_2 !== _arg_1)
            {
                this._678592313forFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forFood", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get forIron():int
        {
            return (this._678500047forIron);
        }

        public function set foodRemain(_arg_1:int):void
        {
            var _local_2:Object = this._449807254foodRemain;
            if (_local_2 !== _arg_1)
            {
                this._449807254foodRemain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodRemain", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get forWood():int
        {
            return (this._678085866forWood);
        }

        public function copyTo(_arg_1:BuyResourceBean):void
        {
            _arg_1.foodRemain = this.foodRemain;
            _arg_1.forFood = this.forFood;
            _arg_1.forIron = this.forIron;
            _arg_1.forStone = this.forStone;
            _arg_1.forWood = this.forWood;
            _arg_1.ironRemain = this.ironRemain;
            _arg_1.stoneRemain = this.stoneRemain;
            _arg_1.woodRemain = this.woodRemain;
        }

        public function toObject():Object
        {
            return ({
                "foodRemain":this.foodRemain,
                "forFood":this.forFood,
                "forIron":this.forIron,
                "forStone":this.forStone,
                "forWood":this.forWood,
                "ironRemain":this.ironRemain,
                "stoneRemain":this.stoneRemain,
                "woodRemain":this.woodRemain
            });
        }

        [Bindable(event="propertyChange")]
        public function get ironRemain():int
        {
            return (this._1881641644ironRemain);
        }

        [Bindable(event="propertyChange")]
        public function get forStone():int
        {
            return (this._450629916forStone);
        }

        public function set stoneRemain(_arg_1:int):void
        {
            var _local_2:Object = this._252311759stoneRemain;
            if (_local_2 !== _arg_1)
            {
                this._252311759stoneRemain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneRemain", _local_2, _arg_1));
            };
        }

        public function set ironRemain(_arg_1:int):void
        {
            var _local_2:Object = this._1881641644ironRemain;
            if (_local_2 !== _arg_1)
            {
                this._1881641644ironRemain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironRemain", _local_2, _arg_1));
            };
        }

        public function set forIron(_arg_1:int):void
        {
            var _local_2:Object = this._678500047forIron;
            if (_local_2 !== _arg_1)
            {
                this._678500047forIron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forIron", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get foodRemain():int
        {
            return (this._449807254foodRemain);
        }

        [Bindable(event="propertyChange")]
        public function get stoneRemain():int
        {
            return (this._252311759stoneRemain);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set forStone(_arg_1:int):void
        {
            var _local_2:Object = this._450629916forStone;
            if (_local_2 !== _arg_1)
            {
                this._450629916forStone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forStone", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

