// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.CommissionQuestArmyRankBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import mx.events.*;
    import flash.events.*;

    public class CommissionQuestArmyRankBean implements IEventDispatcher 
    {

        private var _3492908rank:int;
        private var _85567126experience:Number;
        private var _1879273436playerId:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function CommissionQuestArmyRankBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.experience != null)
                {
                    this.experience = _arg_1.experience;
                };
                if (_arg_1.playerId != null)
                {
                    this.playerId = _arg_1.playerId;
                };
                if (_arg_1.rank != null)
                {
                    this.rank = _arg_1.rank;
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
            var _local_2:* = "";
            _local_2 = (_local_2 + (((_arg_1 + "experience = ") + this.experience) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "playerId = ") + this.playerId) + "\n"));
            return (_local_2 + (((_arg_1 + "rank = ") + this.rank) + "\n"));
        }

        public function copyTo(_arg_1:CommissionQuestArmyRankBean):void
        {
            _arg_1.experience = this.experience;
            _arg_1.playerId = this.playerId;
            _arg_1.rank = this.rank;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set rank(_arg_1:int):void
        {
            var _local_2:Object = this._3492908rank;
            if (_local_2 !== _arg_1)
            {
                this._3492908rank = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rank", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.experience = this.experience;
            _local_1.playerId = this.playerId;
            _local_1.rank = this.rank;
            return (_local_1);
        }

        public function set experience(_arg_1:Number):void
        {
            var _local_2:Object = this._85567126experience;
            if (_local_2 !== _arg_1)
            {
                this._85567126experience = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "experience", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get playerId():int
        {
            return (this._1879273436playerId);
        }

        [Bindable(event="propertyChange")]
        public function get experience():Number
        {
            return (this._85567126experience);
        }

        [Bindable(event="propertyChange")]
        public function get rank():int
        {
            return (this._3492908rank);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set playerId(_arg_1:int):void
        {
            var _local_2:Object = this._1879273436playerId;
            if (_local_2 !== _arg_1)
            {
                this._1879273436playerId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerId", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

