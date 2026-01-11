// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.XMLListAdapter

package mx.collections
{
    import flash.events.EventDispatcher;
    import mx.utils.IXMLNotifiable;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.events.CollectionEvent;
    import mx.events.PropertyChangeEvent;
    import mx.events.CollectionEventKind;
    import mx.events.PropertyChangeEventKind;
    import mx.utils.XMLNotifier;
    import flash.utils.getQualifiedClassName;
    import mx.utils.UIDUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class XMLListAdapter extends EventDispatcher implements IList, IXMLNotifiable 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var uidCounter:int = 0;
        private var _dispatchEvents:int = 0;
        private var _busy:int = 0;
        private var seedUID:String;
        private var _source:XMLList;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function XMLListAdapter(_arg_1:XMLList=null)
        {
            disableEvents();
            this.source = _arg_1;
            enableEvents();
        }

        public function setItemAt(_arg_1:Object, _arg_2:int):Object
        {
            var _local_4:String;
            var _local_5:CollectionEvent;
            var _local_6:PropertyChangeEvent;
            if (((_arg_2 < 0) || (_arg_2 >= length)))
            {
                _local_4 = resourceManager.getString("collections", "outOfBounds", [_arg_2]);
                throw (new RangeError(_local_4));
            };
            var _local_3:Object = source[_arg_2];
            source[_arg_2] = _arg_1;
            stopTrackUpdates(_local_3);
            startTrackUpdates(_arg_1, (seedUID + uidCounter.toString()));
            uidCounter++;
            if (_dispatchEvents == 0)
            {
                _local_5 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_5.kind = CollectionEventKind.REPLACE;
                _local_6 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _local_6.kind = PropertyChangeEventKind.UPDATE;
                _local_6.oldValue = _local_3;
                _local_6.newValue = _arg_1;
                _local_5.location = _arg_2;
                _local_5.items.push(_local_6);
                dispatchEvent(_local_5);
            };
            return (_local_3);
        }

        protected function startTrackUpdates(_arg_1:Object, _arg_2:String):void
        {
            XMLNotifier.getInstance().watchXML(_arg_1, this, _arg_2);
        }

        public function removeAll():void
        {
            var _local_1:int;
            var _local_2:CollectionEvent;
            if (length > 0)
            {
                _local_1 = (length - 1);
                while (_local_1 >= 0)
                {
                    stopTrackUpdates(source[_local_1]);
                    delete source[_local_1];
                    _local_1--;
                };
                if (_dispatchEvents == 0)
                {
                    _local_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _local_2.kind = CollectionEventKind.RESET;
                    dispatchEvent(_local_2);
                };
            };
        }

        protected function itemUpdateHandler(_arg_1:PropertyChangeEvent):void
        {
            var _local_2:CollectionEvent;
            if (_dispatchEvents == 0)
            {
                _local_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_2.kind = CollectionEventKind.UPDATE;
                _local_2.items.push(_arg_1);
                dispatchEvent(_local_2);
            };
        }

        public function getItemIndex(_arg_1:Object):int
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:Object;
            if (((_arg_1 is XML) && (source.contains(XML(_arg_1)))))
            {
                _local_2 = length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = source[_local_3];
                    if (_local_4 === _arg_1)
                    {
                        return (_local_3);
                    };
                    _local_3++;
                };
            };
            return (-1);
        }

        public function removeItemAt(_arg_1:int):Object
        {
            var _local_3:String;
            var _local_4:CollectionEvent;
            if (((_arg_1 < 0) || (_arg_1 >= length)))
            {
                _local_3 = resourceManager.getString("collections", "outOfBounds", [_arg_1]);
                throw (new RangeError(_local_3));
            };
            setBusy();
            var _local_2:Object = source[_arg_1];
            delete source[_arg_1];
            stopTrackUpdates(_local_2);
            if (_dispatchEvents == 0)
            {
                _local_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_4.kind = CollectionEventKind.REMOVE;
                _local_4.location = _arg_1;
                _local_4.items.push(_local_2);
                dispatchEvent(_local_4);
            };
            clearBusy();
            return (_local_2);
        }

        public function addItem(_arg_1:Object):void
        {
            addItemAt(_arg_1, length);
        }

        public function get source():XMLList
        {
            return (_source);
        }

        public function toArray():Array
        {
            var _local_1:XMLList = source;
            var _local_2:int = _local_1.length();
            var _local_3:Array = [];
            var _local_4:int;
            while (_local_4 < _local_2)
            {
                _local_3[_local_4] = _local_1[_local_4];
                _local_4++;
            };
            return (_local_3);
        }

        protected function disableEvents():void
        {
            _dispatchEvents--;
        }

        public function xmlNotification(_arg_1:Object, _arg_2:String, _arg_3:Object, _arg_4:Object, _arg_5:Object):void
        {
            var _local_6:String;
            var _local_7:Object;
            var _local_8:Object;
            var _local_9:*;
            var _local_10:*;
            if (_arg_1 === _arg_3)
            {
                switch (_arg_2)
                {
                    case "attributeAdded":
                        _local_6 = ("@" + String(_arg_4));
                        _local_8 = _arg_5;
                        break;
                    case "attributeChanged":
                        _local_6 = ("@" + String(_arg_4));
                        _local_7 = _arg_5;
                        _local_8 = _arg_3[_local_6];
                        break;
                    case "attributeRemoved":
                        _local_6 = ("@" + String(_arg_4));
                        _local_7 = _arg_5;
                        break;
                    case "nodeAdded":
                        _local_6 = _arg_4.localName();
                        _local_8 = _arg_4;
                        break;
                    case "nodeChanged":
                        _local_6 = _arg_4.localName();
                        _local_7 = _arg_5;
                        _local_8 = _arg_4;
                        break;
                    case "nodeRemoved":
                        _local_6 = _arg_4.localName();
                        _local_7 = _arg_4;
                        break;
                    case "textSet":
                        _local_6 = String(_arg_4);
                        _local_8 = String(_arg_3[_local_6]);
                        _local_7 = _arg_5;
                        break;
                };
            }
            else
            {
                if (_arg_2 == "textSet")
                {
                    _local_9 = _arg_3.parent();
                    if (_local_9 != undefined)
                    {
                        _local_10 = _local_9.parent();
                        if (_local_10 === _arg_1)
                        {
                            _local_6 = _local_9.name().toString();
                            _local_8 = _arg_4;
                            _local_7 = _arg_5;
                        };
                    };
                };
            };
            itemUpdated(_arg_1, _local_6, _local_7, _local_8);
        }

        public function addItemAt(_arg_1:Object, _arg_2:int):void
        {
            var _local_3:String;
            var _local_4:CollectionEvent;
            if (((_arg_2 < 0) || (_arg_2 > length)))
            {
                _local_3 = resourceManager.getString("collections", "outOfBounds", [_arg_2]);
                throw (new RangeError(_local_3));
            };
            if (((!(_arg_1 is XML)) && (!((_arg_1 is XMLList) && (_arg_1.length() == 1)))))
            {
                _local_3 = resourceManager.getString("collections", "invalidType");
                throw (new Error(_local_3));
            };
            setBusy();
            if (_arg_2 == 0)
            {
                source[0] = ((length > 0) ? (_arg_1 + source[0]) : _arg_1);
            }
            else
            {
                source[(_arg_2 - 1)] = (source[(_arg_2 - 1)] + _arg_1);
            };
            startTrackUpdates(_arg_1, (seedUID + uidCounter.toString()));
            uidCounter++;
            if (_dispatchEvents == 0)
            {
                _local_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_4.kind = CollectionEventKind.ADD;
                _local_4.items.push(_arg_1);
                _local_4.location = _arg_2;
                dispatchEvent(_local_4);
            };
            clearBusy();
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

        override public function toString():String
        {
            if (source)
            {
                return (source.toString());
            };
            return (getQualifiedClassName(this));
        }

        public function get length():int
        {
            return (source.length());
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

        protected function stopTrackUpdates(_arg_1:Object):void
        {
            XMLNotifier.getInstance().unwatchXML(_arg_1, this);
        }

        private function clearBusy():void
        {
            _busy++;
            if (_busy > 0)
            {
                _busy = 0;
            };
        }

        public function set source(_arg_1:XMLList):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:CollectionEvent;
            if (((_source) && (_source.length())))
            {
                _local_3 = _source.length();
                _local_2 = 0;
                while (_local_2 < _local_3)
                {
                    stopTrackUpdates(_source[_local_2]);
                    _local_2++;
                };
            };
            _source = ((_arg_1) ? _arg_1 : XMLList(new (XMLList)("")));
            seedUID = UIDUtil.createUID();
            uidCounter = 0;
            _local_3 = _source.length();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                startTrackUpdates(_source[_local_2], (seedUID + uidCounter.toString()));
                uidCounter++;
                _local_2++;
            };
            if (_dispatchEvents == 0)
            {
                _local_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_4.kind = CollectionEventKind.RESET;
                dispatchEvent(_local_4);
            };
        }

        public function busy():Boolean
        {
            return (!(_busy == 0));
        }

        private function setBusy():void
        {
            _busy--;
        }

        protected function enableEvents():void
        {
            _dispatchEvents++;
            if (_dispatchEvents > 0)
            {
                _dispatchEvents = 0;
            };
        }


    }
}//package mx.collections

