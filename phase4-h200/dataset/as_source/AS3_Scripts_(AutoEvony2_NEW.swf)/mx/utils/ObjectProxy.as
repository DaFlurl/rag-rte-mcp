// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.ObjectProxy

package mx.utils
{
    import flash.utils.Proxy;
    import flash.utils.IExternalizable;
    import mx.core.IPropertyChangeNotifier;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import flash.utils.getQualifiedClassName;
    import mx.events.PropertyChangeEventKind;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;
    use namespace object_proxy;

    [Bindable("propertyChange")]
    public dynamic class ObjectProxy extends Proxy implements IExternalizable, IPropertyChangeNotifier 
    {

        private var _id:String;
        protected var notifiers:Object;
        protected var propertyList:Array;
        private var _proxyLevel:int;
        private var _type:QName;
        protected var dispatcher:EventDispatcher;
        protected var proxyClass:Class = ObjectProxy;
        private var _item:Object;

        public function ObjectProxy(_arg_1:Object=null, _arg_2:String=null, _arg_3:int=-1)
        {
            if (!_arg_1)
            {
                _arg_1 = {};
            };
            _item = _arg_1;
            _proxyLevel = _arg_3;
            notifiers = {};
            dispatcher = new EventDispatcher(this);
            if (_arg_2)
            {
                _id = _arg_2;
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (dispatcher.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (dispatcher.hasEventListener(_arg_1));
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_4:IPropertyChangeNotifier;
            var _local_5:PropertyChangeEvent;
            var _local_3:* = _item[_arg_1];
            if (_local_3 !== _arg_2)
            {
                _item[_arg_1] = _arg_2;
                _local_4 = IPropertyChangeNotifier(notifiers[_arg_1]);
                if (_local_4)
                {
                    _local_4.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                    delete notifiers[_arg_1];
                };
                if (dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
                {
                    if ((_arg_1 is QName))
                    {
                        _arg_1 = QName(_arg_1).localName;
                    };
                    _local_5 = PropertyChangeEvent.createUpdateEvent(this, _arg_1.toString(), _local_3, _arg_2);
                    dispatcher.dispatchEvent(_local_5);
                };
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (dispatcher.willTrigger(_arg_1));
        }

        public function readExternal(_arg_1:IDataInput):void
        {
            var _local_2:Object = _arg_1.readObject();
            _item = _local_2;
        }

        public function writeExternal(_arg_1:IDataOutput):void
        {
            _arg_1.writeObject(_item);
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            var _local_2:*;
            if (notifiers[_arg_1.toString()])
            {
                return (notifiers[_arg_1]);
            };
            _local_2 = _item[_arg_1];
            if (_local_2)
            {
                if (((_proxyLevel == 0) || (ObjectUtil.isSimple(_local_2))))
                {
                    return (_local_2);
                };
                _local_2 = getComplexProperty(_arg_1, _local_2);
            };
            return (_local_2);
        }

        override flash_proxy function hasProperty(_arg_1:*):Boolean
        {
            return (_arg_1 in _item);
        }

        public function get uid():String
        {
            if (_id === null)
            {
                _id = UIDUtil.createUID();
            };
            return (_id);
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            if (_arg_1 == 0)
            {
                setupPropertyList();
            };
            if (_arg_1 < propertyList.length)
            {
                return (_arg_1 + 1);
            };
            return (0);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            dispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        override flash_proxy function nextName(_arg_1:int):String
        {
            return (propertyList[(_arg_1 - 1)]);
        }

        public function set uid(_arg_1:String):void
        {
            _id = _arg_1;
        }

        override flash_proxy function callProperty(_arg_1:*, ... _args):*
        {
            return (_item[_arg_1].apply(_item, _args));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            dispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        protected function setupPropertyList():void
        {
            var _local_1:String;
            if (getQualifiedClassName(_item) == "Object")
            {
                propertyList = [];
                for (_local_1 in _item)
                {
                    propertyList.push(_local_1);
                };
            }
            else
            {
                propertyList = ObjectUtil.getClassInfo(_item, null, {
                    "includeReadOnly":true,
                    "uris":["*"]
                }).properties;
            };
        }

        object_proxy function getComplexProperty(_arg_1:*, _arg_2:*):*
        {
            if ((_arg_2 is IPropertyChangeNotifier))
            {
                _arg_2.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                notifiers[_arg_1] = _arg_2;
                return (_arg_2);
            };
            if (getQualifiedClassName(_arg_2) == "Object")
            {
                _arg_2 = new proxyClass(_item[_arg_1], null, ((_proxyLevel > 0) ? (_proxyLevel - 1) : _proxyLevel));
                _arg_2.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                notifiers[_arg_1] = _arg_2;
                return (_arg_2);
            };
            return (_arg_2);
        }

        override flash_proxy function deleteProperty(_arg_1:*):Boolean
        {
            var _local_5:PropertyChangeEvent;
            var _local_2:IPropertyChangeNotifier = IPropertyChangeNotifier(notifiers[_arg_1]);
            if (_local_2)
            {
                _local_2.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                delete notifiers[_arg_1];
            };
            var _local_3:* = _item[_arg_1];
            var _local_4:* = delete _item[_arg_1];
            if (dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
            {
                _local_5 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _local_5.kind = PropertyChangeEventKind.DELETE;
                _local_5.property = _arg_1;
                _local_5.oldValue = _local_3;
                _local_5.source = this;
                dispatcher.dispatchEvent(_local_5);
            };
            return (_local_4);
        }

        object_proxy function get type():QName
        {
            return (_type);
        }

        object_proxy function set type(_arg_1:QName):void
        {
            _type = _arg_1;
        }

        public function propertyChangeHandler(_arg_1:PropertyChangeEvent):void
        {
            dispatcher.dispatchEvent(_arg_1);
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (_item[propertyList[(_arg_1 - 1)]]);
        }

        object_proxy function get object():Object
        {
            return (_item);
        }


    }
}//package mx.utils

