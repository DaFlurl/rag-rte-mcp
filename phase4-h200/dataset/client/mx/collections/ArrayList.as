// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.ArrayList

package mx.collections
{
    import flash.events.EventDispatcher;
    import flash.utils.IExternalizable;
    import mx.core.IPropertyChangeNotifier;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.utils.UIDUtil;
    import flash.utils.IDataInput;
    import mx.events.CollectionEvent;
    import mx.events.PropertyChangeEvent;
    import mx.events.CollectionEventKind;
    import mx.utils.ArrayUtil;
    import mx.events.PropertyChangeEventKind;
    import flash.utils.IDataOutput;
    import flash.events.IEventDispatcher;
    import flash.utils.getQualifiedClassName;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ArrayList extends EventDispatcher implements IList, IExternalizable, IPropertyChangeNotifier 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _source:Array;
        private var _dispatchEvents:int = 0;
        private var _uid:String;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function ArrayList(_arg_1:Array=null)
        {
            disableEvents();
            this.source = _arg_1;
            enableEvents();
            _uid = UIDUtil.createUID();
        }

        public function addAll(_arg_1:IList):void
        {
            addAllAt(_arg_1, length);
        }

        public function readExternal(_arg_1:IDataInput):void
        {
            source = _arg_1.readObject();
        }

        private function internalDispatchEvent(_arg_1:String, _arg_2:Object=null, _arg_3:int=-1):void
        {
            var _local_4:CollectionEvent;
            var _local_5:PropertyChangeEvent;
            if (_dispatchEvents == 0)
            {
                if (hasEventListener(CollectionEvent.COLLECTION_CHANGE))
                {
                    _local_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _local_4.kind = _arg_1;
                    _local_4.items.push(_arg_2);
                    _local_4.location = _arg_3;
                    dispatchEvent(_local_4);
                };
                if (((hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE)) && ((_arg_1 == CollectionEventKind.ADD) || (_arg_1 == CollectionEventKind.REMOVE))))
                {
                    _local_5 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    _local_5.property = _arg_3;
                    if (_arg_1 == CollectionEventKind.ADD)
                    {
                        _local_5.newValue = _arg_2;
                    }
                    else
                    {
                        _local_5.oldValue = _arg_2;
                    };
                    dispatchEvent(_local_5);
                };
            };
        }

        public function removeAll():void
        {
            var _local_1:int;
            var _local_2:int;
            if (length > 0)
            {
                _local_1 = length;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    stopTrackUpdates(source[_local_2]);
                    _local_2++;
                };
                source.splice(0, length);
                internalDispatchEvent(CollectionEventKind.RESET);
            };
        }

        public function getItemIndex(_arg_1:Object):int
        {
            return (ArrayUtil.getItemIndex(_arg_1, source));
        }

        public function removeItemAt(_arg_1:int):Object
        {
            var _local_3:String;
            if (((_arg_1 < 0) || (_arg_1 >= length)))
            {
                _local_3 = resourceManager.getString("collections", "outOfBounds", [_arg_1]);
                throw (new RangeError(_local_3));
            };
            var _local_2:Object = source.splice(_arg_1, 1)[0];
            stopTrackUpdates(_local_2);
            internalDispatchEvent(CollectionEventKind.REMOVE, _local_2, _arg_1);
            return (_local_2);
        }

        public function addAllAt(_arg_1:IList, _arg_2:int):void
        {
            var _local_3:int = _arg_1.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                this.addItemAt(_arg_1.getItemAt(_local_4), (_local_4 + _arg_2));
                _local_4++;
            };
        }

        public function itemUpdated(_arg_1:Object, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):void
        {
            var _local_5:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _local_5.kind = PropertyChangeEventKind.UPDATE;
            _local_5.source = _arg_1;
            _local_5.property = _arg_2;
            _local_5.oldValue = _arg_3;
            _local_5.newValue = _arg_4;
            itemUpdateHandler(_local_5);
        }

        public function get uid():String
        {
            return (_uid);
        }

        public function writeExternal(_arg_1:IDataOutput):void
        {
            _arg_1.writeObject(_source);
        }

        public function addItem(_arg_1:Object):void
        {
            addItemAt(_arg_1, length);
        }

        public function toArray():Array
        {
            return (source.concat());
        }

        public function get source():Array
        {
            return (_source);
        }

        public function getItemAt(_arg_1:int, _arg_2:int=0):Object
        {
            var _local_3:String;
            if (((_arg_1 < 0) || (_arg_1 >= length)))
            {
                _local_3 = resourceManager.getString("collections", "outOfBounds", [_arg_1]);
                throw (new RangeError(_local_3));
            };
            return (source[_arg_1]);
        }

        public function set uid(_arg_1:String):void
        {
            _uid = _arg_1;
        }

        public function setItemAt(_arg_1:Object, _arg_2:int):Object
        {
            var _local_4:String;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:PropertyChangeEvent;
            var _local_8:CollectionEvent;
            if (((_arg_2 < 0) || (_arg_2 >= length)))
            {
                _local_4 = resourceManager.getString("collections", "outOfBounds", [_arg_2]);
                throw (new RangeError(_local_4));
            };
            var _local_3:Object = source[_arg_2];
            source[_arg_2] = _arg_1;
            stopTrackUpdates(_local_3);
            startTrackUpdates(_arg_1);
            if (_dispatchEvents == 0)
            {
                _local_5 = hasEventListener(CollectionEvent.COLLECTION_CHANGE);
                _local_6 = hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE);
                if (((_local_5) || (_local_6)))
                {
                    _local_7 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    _local_7.kind = PropertyChangeEventKind.UPDATE;
                    _local_7.oldValue = _local_3;
                    _local_7.newValue = _arg_1;
                    _local_7.property = _arg_2;
                };
                if (_local_5)
                {
                    _local_8 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _local_8.kind = CollectionEventKind.REPLACE;
                    _local_8.location = _arg_2;
                    _local_8.items.push(_local_7);
                    dispatchEvent(_local_8);
                };
                if (_local_6)
                {
                    dispatchEvent(_local_7);
                };
            };
            return (_local_3);
        }

        public function get length():int
        {
            if (source)
            {
                return (source.length);
            };
            return (0);
        }

        private function disableEvents():void
        {
            _dispatchEvents--;
        }

        protected function itemUpdateHandler(_arg_1:PropertyChangeEvent):void
        {
            var _local_2:PropertyChangeEvent;
            var _local_3:uint;
            internalDispatchEvent(CollectionEventKind.UPDATE, _arg_1);
            if (((_dispatchEvents == 0) && (hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))))
            {
                _local_2 = PropertyChangeEvent(_arg_1.clone());
                _local_3 = getItemIndex(_arg_1.target);
                _local_2.property = ((_local_3.toString() + ".") + _arg_1.property);
                dispatchEvent(_local_2);
            };
        }

        public function addItemAt(_arg_1:Object, _arg_2:int):void
        {
            var _local_3:String;
            if (((_arg_2 < 0) || (_arg_2 > length)))
            {
                _local_3 = resourceManager.getString("collections", "outOfBounds", [_arg_2]);
                throw (new RangeError(_local_3));
            };
            source.splice(_arg_2, 0, _arg_1);
            startTrackUpdates(_arg_1);
            internalDispatchEvent(CollectionEventKind.ADD, _arg_1, _arg_2);
        }

        public function removeItem(_arg_1:Object):Boolean
        {
            var _local_2:int = getItemIndex(_arg_1);
            var _local_3:* = (_local_2 >= 0);
            if (_local_3)
            {
                removeItemAt(_local_2);
            };
            return (_local_3);
        }

        protected function stopTrackUpdates(_arg_1:Object):void
        {
            if (((_arg_1) && (_arg_1 is IEventDispatcher)))
            {
                IEventDispatcher(_arg_1).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, itemUpdateHandler);
            };
        }

        protected function startTrackUpdates(_arg_1:Object):void
        {
            if (((_arg_1) && (_arg_1 is IEventDispatcher)))
            {
                IEventDispatcher(_arg_1).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, itemUpdateHandler, false, 0, true);
            };
        }

        override public function toString():String
        {
            if (source)
            {
                return (source.toString());
            };
            return (getQualifiedClassName(this));
        }

        private function enableEvents():void
        {
            _dispatchEvents++;
            if (_dispatchEvents > 0)
            {
                _dispatchEvents = 0;
            };
        }

        public function set source(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:CollectionEvent;
            if (((_source) && (_source.length)))
            {
                _local_3 = _source.length;
                _local_2 = 0;
                while (_local_2 < _local_3)
                {
                    stopTrackUpdates(_source[_local_2]);
                    _local_2++;
                };
            };
            _source = ((_arg_1) ? _arg_1 : []);
            _local_3 = _source.length;
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                startTrackUpdates(_source[_local_2]);
                _local_2++;
            };
            if (_dispatchEvents == 0)
            {
                _local_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_4.kind = CollectionEventKind.RESET;
                dispatchEvent(_local_4);
            };
        }


    }
}//package mx.collections

