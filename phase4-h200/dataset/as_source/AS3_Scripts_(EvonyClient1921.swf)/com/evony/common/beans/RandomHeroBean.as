// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.RandomHeroBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.paramBeans.*;

    public class RandomHeroBean implements IEventDispatcher 
    {

        private var _2024747164resettime:Number;
        private var _1949052249lockstratagem:Boolean;
        private var _1799980989management:int;
        private var _914405702lockpower:Boolean;
        private var _1872044231player_id:int;
        private var _106858757power:int;
        private var _3355id:Number;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1672860384resetcount:int;
        private var _2120287150lockmanagement:Boolean;
        private var _412944526stratagem:int;

        public function RandomHeroBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.management != null)
                {
                    this.management = _arg_1.management;
                };
                if (_arg_1.player_id != null)
                {
                    this.player_id = _arg_1.player_id;
                };
                if (_arg_1.power != null)
                {
                    this.power = _arg_1.power;
                };
                if (_arg_1.resetcount != null)
                {
                    this.resetcount = _arg_1.resetcount;
                };
                if (_arg_1.resettime != null)
                {
                    this.resettime = _arg_1.resettime;
                };
                if (_arg_1.stratagem != null)
                {
                    this.stratagem = _arg_1.stratagem;
                };
                if (_arg_1.lockmanagement != null)
                {
                    this.lockmanagement = _arg_1.lockmanagement;
                };
                if (_arg_1.lockpower != null)
                {
                    this.lockpower = _arg_1.lockpower;
                };
                if (_arg_1.lockstratagem != null)
                {
                    this.lockstratagem = _arg_1.lockstratagem;
                };
            };
        }

        public function set lockpower(_arg_1:Boolean):void
        {
            var _local_2:Object = this._914405702lockpower;
            if (_local_2 !== _arg_1)
            {
                this._914405702lockpower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lockpower", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get power():int
        {
            return (this._106858757power);
        }

        public function set management(_arg_1:int):void
        {
            var _local_2:Object = this._1799980989management;
            if (_local_2 !== _arg_1)
            {
                this._1799980989management = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "management", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set power(_arg_1:int):void
        {
            var _local_2:Object = this._106858757power;
            if (_local_2 !== _arg_1)
            {
                this._106858757power = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "power", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.id = this.id;
            _local_1.management = this.management;
            _local_1.player_id = this.player_id;
            _local_1.power = this.power;
            _local_1.resetcount = this.resetcount;
            _local_1.resettime = this.resettime;
            _local_1.stratagem = this.stratagem;
            _local_1.lockmanagement = this.lockmanagement;
            _local_1.lockpower = this.lockpower;
            _local_1.lockstratagem = this.lockstratagem;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get id():Number
        {
            return (this._3355id);
        }

        [Bindable(event="propertyChange")]
        public function get resettime():Number
        {
            return (this._2024747164resettime);
        }

        [Bindable(event="propertyChange")]
        public function get resetcount():int
        {
            return (this._1672860384resetcount);
        }

        [Bindable(event="propertyChange")]
        public function get lockstratagem():Boolean
        {
            return (this._1949052249lockstratagem);
        }

        [Bindable(event="propertyChange")]
        public function get lockmanagement():Boolean
        {
            return (this._2120287150lockmanagement);
        }

        public function set id(_arg_1:Number):void
        {
            var _local_2:Object = this._3355id;
            if (_local_2 !== _arg_1)
            {
                this._3355id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _local_2, _arg_1));
            };
        }

        public function set resettime(_arg_1:Number):void
        {
            var _local_2:Object = this._2024747164resettime;
            if (_local_2 !== _arg_1)
            {
                this._2024747164resettime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resettime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get player_id():int
        {
            return (this._1872044231player_id);
        }

        public function set resetcount(_arg_1:int):void
        {
            var _local_2:Object = this._1672860384resetcount;
            if (_local_2 !== _arg_1)
            {
                this._1672860384resetcount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resetcount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get lockpower():Boolean
        {
            return (this._914405702lockpower);
        }

        [Bindable(event="propertyChange")]
        public function get management():int
        {
            return (this._1799980989management);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "id = ") + this.id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "management = ") + this.management) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "player_id = ") + this.player_id) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "power = ") + this.power) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "resetcount = ") + this.resetcount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "resettime = ") + this.resettime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "stratagem = ") + this.stratagem) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "lockmanagement = ") + this.lockmanagement) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "lockpower = ") + this.lockpower) + "\n"));
            return (_local_2 + (((_arg_1 + "lockstratagem = ") + this.lockstratagem) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set lockstratagem(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1949052249lockstratagem;
            if (_local_2 !== _arg_1)
            {
                this._1949052249lockstratagem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lockstratagem", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function copyTo(_arg_1:RandomHeroBean):void
        {
            _arg_1.id = this.id;
            _arg_1.management = this.management;
            _arg_1.player_id = this.player_id;
            _arg_1.power = this.power;
            _arg_1.resetcount = this.resetcount;
            _arg_1.resettime = this.resettime;
            _arg_1.stratagem = this.stratagem;
            _arg_1.lockmanagement = this.lockmanagement;
            _arg_1.lockpower = this.lockpower;
            _arg_1.lockstratagem = this.lockstratagem;
        }

        public function set lockmanagement(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2120287150lockmanagement;
            if (_local_2 !== _arg_1)
            {
                this._2120287150lockmanagement = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lockmanagement", _local_2, _arg_1));
            };
        }

        public function set stratagem(_arg_1:int):void
        {
            var _local_2:Object = this._412944526stratagem;
            if (_local_2 !== _arg_1)
            {
                this._412944526stratagem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagem", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stratagem():int
        {
            return (this._412944526stratagem);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set player_id(_arg_1:int):void
        {
            var _local_2:Object = this._1872044231player_id;
            if (_local_2 !== _arg_1)
            {
                this._1872044231player_id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "player_id", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

