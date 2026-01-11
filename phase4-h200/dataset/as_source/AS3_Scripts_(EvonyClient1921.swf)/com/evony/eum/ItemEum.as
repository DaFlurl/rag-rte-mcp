// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.ItemEum

package com.evony.eum
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ItemEum implements IEventDispatcher 
    {

        private var _321656496userLimit:int;
        private var _3373707name:String;
        private var _106934601price:int;
        private var _1177037892itemDesc:String;
        private var _1177533677itemType:String;
        private var _619236819heroItem:Boolean = false;
        private var _3355id:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _2095526292playerItem:Boolean = false;
        private var _1638765110iconUrl:String;
        private var _1913436543dayLimit:int;
        private var _3079825desc:String;

        public function ItemEum()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public function set itemDesc(_arg_1:String):void
        {
            var _local_2:Object = this._1177037892itemDesc;
            if (_local_2 !== _arg_1)
            {
                this._1177037892itemDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemDesc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get desc():String
        {
            return (this._3079825desc);
        }

        public function set price(_arg_1:int):void
        {
            var _local_2:Object = this._106934601price;
            if (_local_2 !== _arg_1)
            {
                this._106934601price = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "price", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get playerItem():Boolean
        {
            return (this._2095526292playerItem);
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
        public function get id():String
        {
            return (this._3355id);
        }

        public function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroItem():Boolean
        {
            return (this._619236819heroItem);
        }

        public function set playerItem(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2095526292playerItem;
            if (_local_2 !== _arg_1)
            {
                this._2095526292playerItem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerItem", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get userLimit():int
        {
            return (this._321656496userLimit);
        }

        public function set id(_arg_1:String):void
        {
            var _local_2:Object = this._3355id;
            if (_local_2 !== _arg_1)
            {
                this._3355id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iconUrl():String
        {
            return (this._1638765110iconUrl);
        }

        [Bindable(event="propertyChange")]
        public function get itemDesc():String
        {
            return (this._1177037892itemDesc);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get price():int
        {
            return (this._106934601price);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set userLimit(_arg_1:int):void
        {
            var _local_2:Object = this._321656496userLimit;
            if (_local_2 !== _arg_1)
            {
                this._321656496userLimit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userLimit", _local_2, _arg_1));
            };
        }

        public function set itemType(_arg_1:String):void
        {
            var _local_2:Object = this._1177533677itemType;
            if (_local_2 !== _arg_1)
            {
                this._1177533677itemType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemType", _local_2, _arg_1));
            };
        }

        public function set heroItem(_arg_1:Boolean):void
        {
            var _local_2:Object = this._619236819heroItem;
            if (_local_2 !== _arg_1)
            {
                this._619236819heroItem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroItem", _local_2, _arg_1));
            };
        }

        public function set iconUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1638765110iconUrl;
            if (_local_2 !== _arg_1)
            {
                this._1638765110iconUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemType():String
        {
            return (this._1177533677itemType);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set dayLimit(_arg_1:int):void
        {
            var _local_2:Object = this._1913436543dayLimit;
            if (_local_2 !== _arg_1)
            {
                this._1913436543dayLimit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dayLimit", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get dayLimit():int
        {
            return (this._1913436543dayLimit);
        }


    }
}//package com.evony.eum

