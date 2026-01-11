// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.TroopBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class TroopBean implements IEventDispatcher 
    {

        private var _1671895235heavyCavalry:int;
        private var _47090712catapult:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1409605757archer:int;
        private var _1821715860lightCavalry:int;
        private var _1914804330ballista:int;
        private var _1062697427militia:int;
        private var _1924105259scouter:int;
        private var _5304340carriage:int;
        private var _43947821peasants:int;
        private var _2135247928batteringRam:int;
        private var _1669530624swordsmen:int;
        private var _570808349pikemen:int;

        public function TroopBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.archer != null)
                {
                    this.archer = _arg_1.archer;
                };
                if (_arg_1.ballista != null)
                {
                    this.ballista = _arg_1.ballista;
                };
                if (_arg_1.batteringRam != null)
                {
                    this.batteringRam = _arg_1.batteringRam;
                };
                if (_arg_1.carriage != null)
                {
                    this.carriage = _arg_1.carriage;
                };
                if (_arg_1.catapult != null)
                {
                    this.catapult = _arg_1.catapult;
                };
                if (_arg_1.heavyCavalry != null)
                {
                    this.heavyCavalry = _arg_1.heavyCavalry;
                };
                if (_arg_1.lightCavalry != null)
                {
                    this.lightCavalry = _arg_1.lightCavalry;
                };
                if (_arg_1.militia != null)
                {
                    this.militia = _arg_1.militia;
                };
                if (_arg_1.peasants != null)
                {
                    this.peasants = _arg_1.peasants;
                };
                if (_arg_1.pikemen != null)
                {
                    this.pikemen = _arg_1.pikemen;
                };
                if (_arg_1.scouter != null)
                {
                    this.scouter = _arg_1.scouter;
                };
                if (_arg_1.swordsmen != null)
                {
                    this.swordsmen = _arg_1.swordsmen;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get swordsmen():int
        {
            return (this._1669530624swordsmen);
        }

        [Bindable(event="propertyChange")]
        public function get archer():int
        {
            return (this._1409605757archer);
        }

        public function set archer(_arg_1:int):void
        {
            var _local_2:Object = this._1409605757archer;
            if (_local_2 !== _arg_1)
            {
                this._1409605757archer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "archer", _local_2, _arg_1));
            };
        }

        public function set swordsmen(_arg_1:int):void
        {
            var _local_2:Object = this._1669530624swordsmen;
            if (_local_2 !== _arg_1)
            {
                this._1669530624swordsmen = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "swordsmen", _local_2, _arg_1));
            };
        }

        public function set heavyCavalry(_arg_1:int):void
        {
            var _local_2:Object = this._1671895235heavyCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1671895235heavyCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heavyCavalry", _local_2, _arg_1));
            };
        }

        public function set batteringRam(_arg_1:int):void
        {
            var _local_2:Object = this._2135247928batteringRam;
            if (_local_2 !== _arg_1)
            {
                this._2135247928batteringRam = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "batteringRam", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get carriage():int
        {
            return (this._5304340carriage);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get ballista():int
        {
            return (this._1914804330ballista);
        }

        public function toObject():Object
        {
            return ({
                "archer":this.archer,
                "ballista":this.ballista,
                "batteringRam":this.batteringRam,
                "carriage":this.carriage,
                "catapult":this.catapult,
                "heavyCavalry":this.heavyCavalry,
                "lightCavalry":this.lightCavalry,
                "militia":this.militia,
                "peasants":this.peasants,
                "pikemen":this.pikemen,
                "scouter":this.scouter,
                "swordsmen":this.swordsmen
            });
        }

        [Bindable(event="propertyChange")]
        public function get lightCavalry():int
        {
            return (this._1821715860lightCavalry);
        }

        [Bindable(event="propertyChange")]
        public function get catapult():int
        {
            return (this._47090712catapult);
        }

        public function set peasants(_arg_1:int):void
        {
            var _local_2:Object = this._43947821peasants;
            if (_local_2 !== _arg_1)
            {
                this._43947821peasants = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "peasants", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get scouter():int
        {
            return (this._1924105259scouter);
        }

        public function set ballista(_arg_1:int):void
        {
            var _local_2:Object = this._1914804330ballista;
            if (_local_2 !== _arg_1)
            {
                this._1914804330ballista = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ballista", _local_2, _arg_1));
            };
        }

        public function set militia(_arg_1:int):void
        {
            var _local_2:Object = this._1062697427militia;
            if (_local_2 !== _arg_1)
            {
                this._1062697427militia = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "militia", _local_2, _arg_1));
            };
        }

        public function set carriage(_arg_1:int):void
        {
            var _local_2:Object = this._5304340carriage;
            if (_local_2 !== _arg_1)
            {
                this._5304340carriage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "carriage", _local_2, _arg_1));
            };
        }

        public function set catapult(_arg_1:int):void
        {
            var _local_2:Object = this._47090712catapult;
            if (_local_2 !== _arg_1)
            {
                this._47090712catapult = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "catapult", _local_2, _arg_1));
            };
        }

        public function set lightCavalry(_arg_1:int):void
        {
            var _local_2:Object = this._1821715860lightCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1821715860lightCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lightCavalry", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heavyCavalry():int
        {
            return (this._1671895235heavyCavalry);
        }

        public function set pikemen(_arg_1:int):void
        {
            var _local_2:Object = this._570808349pikemen;
            if (_local_2 !== _arg_1)
            {
                this._570808349pikemen = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pikemen", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get batteringRam():int
        {
            return (this._2135247928batteringRam);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((((((((_arg_1 + "archer = ") + this.archer) + "\n") + (((_arg_1 + "ballista = ") + this.ballista) + "\n")) + (((_arg_1 + "batteringRam = ") + this.batteringRam) + "\n")) + (((_arg_1 + "carriage = ") + this.carriage) + "\n")) + (((_arg_1 + "catapult = ") + this.catapult) + "\n")) + (((_arg_1 + "heavyCavalry = ") + this.heavyCavalry) + "\n")) + (((_arg_1 + "lightCavalry = ") + this.lightCavalry) + "\n")) + (((_arg_1 + "militia = ") + this.militia) + "\n")) + (((_arg_1 + "peasants = ") + this.peasants) + "\n")) + (((_arg_1 + "pikemen = ") + this.pikemen) + "\n")) + (((_arg_1 + "scouter = ") + this.scouter) + "\n")) + (((_arg_1 + "swordsmen = ") + this.swordsmen) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get peasants():int
        {
            return (this._43947821peasants);
        }

        public function copyTo(_arg_1:TroopBean):void
        {
            _arg_1.archer = this.archer;
            _arg_1.ballista = this.ballista;
            _arg_1.batteringRam = this.batteringRam;
            _arg_1.carriage = this.carriage;
            _arg_1.catapult = this.catapult;
            _arg_1.heavyCavalry = this.heavyCavalry;
            _arg_1.lightCavalry = this.lightCavalry;
            _arg_1.militia = this.militia;
            _arg_1.peasants = this.peasants;
            _arg_1.pikemen = this.pikemen;
            _arg_1.scouter = this.scouter;
            _arg_1.swordsmen = this.swordsmen;
        }

        [Bindable(event="propertyChange")]
        public function get militia():int
        {
            return (this._1062697427militia);
        }

        public function set scouter(_arg_1:int):void
        {
            var _local_2:Object = this._1924105259scouter;
            if (_local_2 !== _arg_1)
            {
                this._1924105259scouter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scouter", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get pikemen():int
        {
            return (this._570808349pikemen);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony.common.beans

