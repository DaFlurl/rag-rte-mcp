// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.HeroListBean

package view.module.playerInfo
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class HeroListBean implements IEventDispatcher 
    {

        private var _3355id:int;
        private var _3373707name:String;
        private var _1901043637location:String;
        private var _1191572123selected:Boolean = false;
        private var _547400545politics:int;
        private var _1407259064attack:int;
        private var _797998783intelligence:int;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function HeroListBean()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set politics(_arg_1:int):void
        {
            var _local_2:Object = this._547400545politics;
            if (_local_2 !== _arg_1)
            {
                this._547400545politics = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "politics", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set level(_arg_1:int):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
            };
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
        public function get attack():int
        {
            return (this._1407259064attack);
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function set attack(_arg_1:int):void
        {
            var _local_2:Object = this._1407259064attack;
            if (_local_2 !== _arg_1)
            {
                this._1407259064attack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get politics():int
        {
            return (this._547400545politics);
        }

        [Bindable(event="propertyChange")]
        public function get selected():Boolean
        {
            return (this._1191572123selected);
        }

        public function set location(_arg_1:String):void
        {
            var _local_2:Object = this._1901043637location;
            if (_local_2 !== _arg_1)
            {
                this._1901043637location = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "location", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get location():String
        {
            return (this._1901043637location);
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

        public function set selected(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1191572123selected;
            if (_local_2 !== _arg_1)
            {
                this._1191572123selected = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selected", _local_2, _arg_1));
            };
        }

        public function set intelligence(_arg_1:int):void
        {
            var _local_2:Object = this._797998783intelligence;
            if (_local_2 !== _arg_1)
            {
                this._797998783intelligence = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "intelligence", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get intelligence():int
        {
            return (this._797998783intelligence);
        }


    }
}//package view.module.playerInfo

