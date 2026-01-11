// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.TroopTypeObj

package view.module.trainningField
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.common.constants.TFConstants;

    public class TroopTypeObj implements IEventDispatcher 
    {

        private var _3373707name:String;
        private var _1750993556_loseAmount:int;
        private var _1465911607_fightAmount:int;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function TroopTypeObj()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
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

        public function get fightAmount():int
        {
            return (this._fightAmount);
        }

        [Bindable(event="propertyChange")]
        public function get _fightAmount():int
        {
            return (this._1465911607_fightAmount);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function get loseAmount():int
        {
            return (this._loseAmount);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
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

        [Bindable(event="propertyChange")]
        public function set fightAmount(_arg_1:int):void
        {
            var _local_2:Object = this.fightAmount;
            if (_local_2 !== _arg_1)
            {
                this._843868024fightAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fightAmount", _local_2, _arg_1));
            };
        }

        public function set _loseAmount(_arg_1:int):void
        {
            var _local_2:Object = this._1750993556_loseAmount;
            if (_local_2 !== _arg_1)
            {
                this._1750993556_loseAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_loseAmount", _local_2, _arg_1));
            };
        }

        public function set _fightAmount(_arg_1:int):void
        {
            var _local_2:Object = this._1465911607_fightAmount;
            if (_local_2 !== _arg_1)
            {
                this._1465911607_fightAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_fightAmount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set loseAmount(_arg_1:int):void
        {
            var _local_2:Object = this.loseAmount;
            if (_local_2 !== _arg_1)
            {
                this._1455661005loseAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loseAmount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        private function set _1455661005loseAmount(_arg_1:int):void
        {
            this._loseAmount = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this.typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        private function set _858803723typeId(_arg_1:int):void
        {
            this.id = _arg_1;
            switch (_arg_1)
            {
                case TFConstants.T_ARCHER:
                    this.name = Lang.msg("弓箭手");
                    return;
                case TFConstants.T_BALLISTA:
                    this.name = Lang.msg("车弩");
                    return;
                case TFConstants.T_BATTERINGRAM:
                    this.name = Lang.msg("冲车");
                    return;
                case TFConstants.T_CARRIAGE:
                    this.name = Lang.msg("辎重车");
                    return;
                case TFConstants.T_CATAPULT:
                    this.name = Lang.msg("投石车");
                    return;
                case TFConstants.T_HEAVYCAVALRY:
                    this.name = Lang.msg("铁骑兵");
                    return;
                case TFConstants.T_LIGHTCAVALRY:
                    this.name = Lang.msg("轻骑兵");
                    return;
                case TFConstants.T_MILITIA:
                    this.name = Lang.msg("义兵");
                    return;
                case TFConstants.T_PEASANTS:
                    this.name = Lang.msg("民夫");
                    return;
                case TFConstants.T_PIKEMAN:
                    this.name = Lang.msg("枪兵");
                    return;
                case TFConstants.T_SCOUTER:
                    this.name = Lang.msg("斥候");
                    return;
                case TFConstants.T_SWORDSMEN:
                    this.name = Lang.msg("刀盾兵");
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get _loseAmount():int
        {
            return (this._1750993556_loseAmount);
        }

        private function set _843868024fightAmount(_arg_1:int):void
        {
            this._fightAmount = _arg_1;
        }

        public function get typeId():int
        {
            return (this.id);
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


    }
}//package view.module.trainningField

