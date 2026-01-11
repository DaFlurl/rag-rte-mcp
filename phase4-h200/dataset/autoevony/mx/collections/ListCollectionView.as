// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.ListCollectionView

package mx.collections
{
    import flash.utils.Proxy;
    import mx.core.IMXMLObject;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.EventDispatcher;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.events.PropertyChangeEvent;
    import mx.collections.errors.CollectionViewError;
    import flash.events.Event;
    import mx.collections.errors.ItemPendingError;
    import mx.collections.errors.SortError;
    import mx.utils.ObjectUtil;
    import flash.utils.getQualifiedClassName;
    import flash.utils.flash_proxy; 
    import mx.core.mx_internal; 

    use namespace mx_internal;
    use namespace flash.utils.flash_proxy;

    public class ListCollectionView extends Proxy implements ICollectionView, IList, IMXMLObject 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var autoUpdateCounter:int;
        private var _list:IList;
        private var _filterFunction:Function;
        protected var localIndex:Array;
        mx_internal var dispatchResetEvent:Boolean = true;
        private var pendingUpdates:Array;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var eventDispatcher:EventDispatcher;
        private var revision:int;
        private var _sort:Sort;

        public function ListCollectionView(_arg_1:IList=null)
        {
            eventDispatcher = new EventDispatcher(this);
            this.list = _arg_1;
        }

        private function handlePendingUpdates():void
        {
            var _local_1:Array;
            var _local_2:CollectionEvent;
            var _local_3:int;
            var _local_4:CollectionEvent;
            var _local_5:int;
            if (pendingUpdates)
            {
                _local_1 = pendingUpdates;
                pendingUpdates = null;
                _local_3 = 0;
                while (_local_3 < _local_1.length)
                {
                    _local_4 = _local_1[_local_3];
                    if (_local_4.kind == CollectionEventKind.UPDATE)
                    {
                        if (!_local_2)
                        {
                            _local_2 = _local_4;
                        }
                        else
                        {
                            _local_5 = 0;
                            while (_local_5 < _local_4.items.length)
                            {
                                _local_2.items.push(_local_4.items[_local_5]);
                                _local_5++;
                            };
                        };
                    }
                    else
                    {
                        listChangeHandler(_local_4);
                    };
                    _local_3++;
                };
                if (_local_2)
                {
                    listChangeHandler(_local_2);
                };
            };
        }

        private function replaceItemsInView(_arg_1:Array, _arg_2:int, _arg_3:Boolean=true):void
        {
            var _local_4:int;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:PropertyChangeEvent;
            var _local_9:CollectionEvent;
            if (localIndex)
            {
                _local_4 = _arg_1.length;
                _local_5 = [];
                _local_6 = [];
                _local_7 = 0;
                while (_local_7 < _local_4)
                {
                    _local_8 = _arg_1[_local_7];
                    _local_5.push(_local_8.oldValue);
                    _local_6.push(_local_8.newValue);
                    _local_7++;
                };
                removeItemsFromView(_local_5, _arg_2, _arg_3);
                addItemsToView(_local_6, _arg_2, _arg_3);
            }
            else
            {
                _local_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_9.kind = CollectionEventKind.REPLACE;
                _local_9.location = _arg_2;
                _local_9.items = _arg_1;
                dispatchEvent(_local_9);
            };
        }

        private function getFilteredItemIndex(_arg_1:Object):int
        {
            var _local_4:Object;
            var _local_5:int;
            var _local_6:int;
            var _local_2:int = list.getItemIndex(_arg_1);
            if (_local_2 == 0)
            {
                return (0);
            };
            var _local_3:int = (_local_2 - 1);
            while (_local_3 >= 0)
            {
                _local_4 = list.getItemAt(_local_3);
                if (filterFunction(_local_4))
                {
                    _local_5 = localIndex.length;
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        if (localIndex[_local_6] == _local_4)
                        {
                            return (_local_6 + 1);
                        };
                        _local_6++;
                    };
                };
                _local_3--;
            };
            return (0);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (eventDispatcher.willTrigger(_arg_1));
        }

        mx_internal function findItem(_arg_1:Object, _arg_2:String, _arg_3:Boolean=false):int
        {
            var _local_4:String;
            if (!sort)
            {
                _local_4 = resourceManager.getString("collections", "itemNotFound");
                throw (new CollectionViewError(_local_4));
            };
            if (localIndex.length == 0)
            {
                return ((_arg_3) ? 0 : -1);
            };
            return (sort.findItem(localIndex, _arg_1, _arg_2, _arg_3));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            eventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        override flash_proxy function nextName(_arg_1:int):String
        {
            return ((_arg_1 - 1).toString());
        }

        public function removeAll():void
        {
            var _local_2:int;
            var _local_1:int = length;
            if (_local_1 > 0)
            {
                if (localIndex)
                {
                    _local_2 = (_local_1 - 1);
                    while (_local_2 >= 0)
                    {
                        removeItemAt(_local_2);
                        _local_2--;
                    };
                }
                else
                {
                    list.removeAll();
                };
            };
        }

        override flash_proxy function hasProperty(name:*):Boolean
        {
            var n:Number;
            if ((name is QName))
            {
                name = name.localName;
            };
            var index:int = -1;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                };
            }
            catch(e:Error)
            {
            };
            if (index == -1)
            {
                return (false);
            };
            return ((index >= 0) && (index < length));
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

        [Bindable("collectionChange")]
        public function getItemAt(_arg_1:int, _arg_2:int=0):Object
        {
            var _local_3:String;
            if (((_arg_1 < 0) || (_arg_1 >= length)))
            {
                _local_3 = resourceManager.getString("collections", "outOfBounds", [_arg_1]);
                throw (new RangeError(_local_3));
            };
            if (localIndex)
            {
                return (localIndex[_arg_1]);
            };
            if (list)
            {
                return (list.getItemAt(_arg_1, _arg_2));
            };
            return (null);
        }

        private function moveItemInView(_arg_1:Object, _arg_2:Boolean=true, _arg_3:Array=null):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:CollectionEvent;
            if (localIndex)
            {
                _local_4 = -1;
                _local_5 = 0;
                while (_local_5 < localIndex.length)
                {
                    if (localIndex[_local_5] == _arg_1)
                    {
                        _local_4 = _local_5;
                        break;
                    };
                    _local_5++;
                };
                if (_local_4 > -1)
                {
                    localIndex.splice(_local_4, 1);
                };
                _local_6 = addItemsToView([_arg_1], _local_4, false);
                if (_arg_2)
                {
                    _local_7 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _local_7.items.push(_arg_1);
                    if ((((_arg_3) && (_local_6 == _local_4)) && (_local_6 > -1)))
                    {
                        _arg_3.push(_arg_1);
                        return;
                    };
                    if (((_local_6 > -1) && (_local_4 > -1)))
                    {
                        _local_7.kind = CollectionEventKind.MOVE;
                        _local_7.location = _local_6;
                        _local_7.oldLocation = _local_4;
                    }
                    else
                    {
                        if (_local_6 > -1)
                        {
                            _local_7.kind = CollectionEventKind.ADD;
                            _local_7.location = _local_6;
                        }
                        else
                        {
                            if (_local_4 > -1)
                            {
                                _local_7.kind = CollectionEventKind.REMOVE;
                                _local_7.location = _local_4;
                            }
                            else
                            {
                                _arg_2 = false;
                            };
                        };
                    };
                    if (_arg_2)
                    {
                        dispatchEvent(_local_7);
                    };
                };
            };
        }

        public function contains(_arg_1:Object):Boolean
        {
            return (!(getItemIndex(_arg_1) == -1));
        }

        [Bindable("sortChanged")]
        public function get sort():Sort
        {
            return (_sort);
        }

        private function removeItemsFromView(_arg_1:Array, _arg_2:int, _arg_3:Boolean=true):void
        {
            var _local_6:int;
            var _local_7:Object;
            var _local_8:int;
            var _local_9:CollectionEvent;
            var _local_4:Array = ((localIndex) ? [] : _arg_1);
            var _local_5:int = _arg_2;
            if (localIndex)
            {
                _local_6 = 0;
                while (_local_6 < _arg_1.length)
                {
                    _local_7 = _arg_1[_local_6];
                    _local_8 = getItemIndex(_local_7);
                    if (_local_8 > -1)
                    {
                        localIndex.splice(_local_8, 1);
                        _local_4.push(_local_7);
                        _local_5 = _local_8;
                    };
                    _local_6++;
                };
            };
            if (((_arg_3) && (_local_4.length > 0)))
            {
                _local_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_9.kind = CollectionEventKind.REMOVE;
                _local_9.location = (((!(localIndex)) || (_local_4.length == 1)) ? _local_5 : -1);
                _local_9.items = _local_4;
                dispatchEvent(_local_9);
            };
        }

        [Bindable("listChanged")]
        public function get list():IList
        {
            return (_list);
        }

        public function addItemAt(_arg_1:Object, _arg_2:int):void
        {
            var _local_4:String;
            if ((((_arg_2 < 0) || (!(list))) || (_arg_2 > length)))
            {
                _local_4 = resourceManager.getString("collections", "outOfBounds", [_arg_2]);
                throw (new RangeError(_local_4));
            };
            var _local_3:int = _arg_2;
            if (((localIndex) && (sort)))
            {
                _local_3 = list.length;
            }
            else
            {
                if (((localIndex) && (!(filterFunction == null))))
                {
                    if (_local_3 == localIndex.length)
                    {
                        _local_3 = list.length;
                    }
                    else
                    {
                        _local_3 = list.getItemIndex(localIndex[_arg_2]);
                    };
                };
            };
            list.addItemAt(_arg_1, _local_3);
        }

        public function itemUpdated(_arg_1:Object, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):void
        {
            list.itemUpdated(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private function populateLocalIndex():void
        {
            if (list)
            {
                localIndex = list.toArray();
            }
            else
            {
                localIndex = [];
            };
        }

        private function handlePropertyChangeEvents(_arg_1:Array):void
        {
            var _local_3:Array;
            var _local_4:Object;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:PropertyChangeEvent;
            var _local_9:Object;
            var _local_10:Boolean;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:CollectionEvent;
            var _local_2:Array = _arg_1;
            if (((sort) || (!(filterFunction == null))))
            {
                _local_3 = [];
                _local_5 = 0;
                while (_local_5 < _arg_1.length)
                {
                    _local_8 = _arg_1[_local_5];
                    if (_local_8.target)
                    {
                        _local_9 = _local_8.target;
                        _local_10 = (!(_local_8.target == _local_8.source));
                    }
                    else
                    {
                        _local_9 = _local_8.source;
                        _local_10 = false;
                    };
                    _local_11 = 0;
                    while (_local_11 < _local_3.length)
                    {
                        if (_local_3[_local_11].item == _local_9)
                        {
                            _arg_1 = _local_3[_local_11].events;
                            _local_12 = _arg_1.length;
                            _local_13 = 0;
                            while (_local_13 < _local_12)
                            {
                                if (_arg_1[_local_13].property != _local_8.property)
                                {
                                    _arg_1.push(_local_8);
                                    break;
                                };
                                _local_13++;
                            };
                            break;
                        };
                        _local_11++;
                    };
                    if (_local_11 < _local_3.length)
                    {
                        _local_4 = _local_3[_local_11];
                    }
                    else
                    {
                        _local_4 = {
                            "item":_local_9,
                            "move":_local_10,
                            "events":[_local_8]
                        };
                        _local_3.push(_local_4);
                    };
                    _local_4.move = ((((_local_4.move) || (filterFunction)) || (!(_local_8.property))) || ((sort) && (sort.propertyAffectsSort(String(_local_8.property)))));
                    _local_5++;
                };
                _local_2 = [];
                _local_5 = 0;
                while (_local_5 < _local_3.length)
                {
                    _local_4 = _local_3[_local_5];
                    if (_local_4.move)
                    {
                        moveItemInView(_local_4.item, _local_4.item, _local_2);
                    }
                    else
                    {
                        _local_2.push(_local_4.item);
                    };
                    _local_5++;
                };
                _local_6 = [];
                _local_7 = 0;
                while (_local_7 < _local_2.length)
                {
                    _local_14 = 0;
                    while (_local_14 < _local_3.length)
                    {
                        if (_local_2[_local_7] == _local_3[_local_14].item)
                        {
                            _local_6 = _local_6.concat(_local_3[_local_14].events);
                        };
                        _local_14++;
                    };
                    _local_7++;
                };
                _local_2 = _local_6;
            };
            if (_local_2.length > 0)
            {
                _local_15 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_15.kind = CollectionEventKind.UPDATE;
                _local_15.items = _local_2;
                dispatchEvent(_local_15);
            };
        }

        public function set sort(_arg_1:Sort):void
        {
            _sort = _arg_1;
            dispatchEvent(new Event("sortChanged"));
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (getItemAt((_arg_1 - 1)));
        }

        public function setItemAt(_arg_1:Object, _arg_2:int):Object
        {
            var _local_4:String;
            var _local_5:Object;
            if ((((_arg_2 < 0) || (!(list))) || (_arg_2 >= length)))
            {
                _local_4 = resourceManager.getString("collections", "outOfBounds", [_arg_2]);
                throw (new RangeError(_local_4));
            };
            var _local_3:int = _arg_2;
            if (localIndex)
            {
                if (_arg_2 > localIndex.length)
                {
                    _local_3 = list.length;
                }
                else
                {
                    _local_5 = localIndex[_arg_2];
                    _local_3 = list.getItemIndex(_local_5);
                };
            };
            return (list.setItemAt(_arg_1, _local_3));
        }

        mx_internal function getBookmark(index:int):ListCollectionViewBookmark
        {
            var value:Object;
            var message:String;
            if (((index < 0) || (index > length)))
            {
                message = resourceManager.getString("collections", "invalidIndex", [index]);
                throw (new CollectionViewError(message));
            };
            try
            {
                value = getItemAt(index);
            }
            catch(e:Error)
            {
                value = null;
            };
            return (new ListCollectionViewBookmark(value, this, revision, index));
        }

        private function addItemsToView(_arg_1:Array, _arg_2:int, _arg_3:Boolean=true):int
        {
            var _local_7:int;
            var _local_8:int;
            var _local_9:Object;
            var _local_10:String;
            var _local_11:CollectionEvent;
            var _local_4:Array = ((localIndex) ? [] : _arg_1);
            var _local_5:int = _arg_2;
            var _local_6:Boolean = true;
            if (localIndex)
            {
                _local_7 = _arg_2;
                _local_8 = 0;
                while (_local_8 < _arg_1.length)
                {
                    _local_9 = _arg_1[_local_8];
                    if (((filterFunction == null) || (filterFunction(_local_9))))
                    {
                        if (sort)
                        {
                            _local_7 = findItem(_local_9, Sort.ANY_INDEX_MODE, true);
                            if (_local_6)
                            {
                                _local_5 = _local_7;
                                _local_6 = false;
                            };
                        }
                        else
                        {
                            _local_7 = getFilteredItemIndex(_local_9);
                            if (_local_6)
                            {
                                _local_5 = _local_7;
                                _local_6 = false;
                            };
                        };
                        if ((((sort) && (sort.unique)) && (sort.compareFunction(_local_9, localIndex[_local_7]) == 0)))
                        {
                            _local_10 = resourceManager.getString("collections", "incorrectAddition");
                            throw (new CollectionViewError(_local_10));
                        };
                        localIndex.splice(_local_7++, 0, _local_9);
                        _local_4.push(_local_9);
                    }
                    else
                    {
                        _local_5 = -1;
                    };
                    _local_8++;
                };
            };
            if (((localIndex) && (_local_4.length > 1)))
            {
                _local_5 = -1;
            };
            if (((_arg_3) && (_local_4.length > 0)))
            {
                _local_11 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_11.kind = CollectionEventKind.ADD;
                _local_11.location = _local_5;
                _local_11.items = _local_4;
                dispatchEvent(_local_11);
            };
            return (_local_5);
        }

        public function addAll(_arg_1:IList):void
        {
            addAllAt(_arg_1, length);
        }

        public function set list(_arg_1:IList):void
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            if (_list != _arg_1)
            {
                if (_list)
                {
                    _list.removeEventListener(CollectionEvent.COLLECTION_CHANGE, listChangeHandler);
                    _local_2 = (_list.length > 0);
                };
                _list = _arg_1;
                if (_list)
                {
                    _list.addEventListener(CollectionEvent.COLLECTION_CHANGE, listChangeHandler, false, 0, true);
                    _local_3 = (_list.length > 0);
                };
                if (((_local_2) || (_local_3)))
                {
                    reset();
                };
                dispatchEvent(new Event("listChanged"));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            eventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (eventDispatcher.dispatchEvent(_arg_1));
        }

        public function getItemIndex(_arg_1:Object):int
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (sort)
            {
                _local_3 = sort.findItem(localIndex, _arg_1, Sort.FIRST_INDEX_MODE);
                if (_local_3 == -1)
                {
                    return (-1);
                };
                _local_4 = sort.findItem(localIndex, _arg_1, Sort.LAST_INDEX_MODE);
                _local_2 = _local_3;
                while (_local_2 <= _local_4)
                {
                    if (localIndex[_local_2] == _arg_1)
                    {
                        return (_local_2);
                    };
                    _local_2++;
                };
                return (-1);
            };
            if (filterFunction != null)
            {
                _local_5 = localIndex.length;
                _local_2 = 0;
                while (_local_2 < _local_5)
                {
                    if (localIndex[_local_2] == _arg_1)
                    {
                        return (_local_2);
                    };
                    _local_2++;
                };
                return (-1);
            };
            return (list.getItemIndex(_arg_1));
        }

        mx_internal function getLocalItemIndex(_arg_1:Object):int
        {
            var _local_2:int;
            var _local_3:int = localIndex.length;
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                if (localIndex[_local_2] == _arg_1)
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }

        override flash_proxy function getProperty(name:*):*
        {
            var n:Number;
            var message:String;
            if ((name is QName))
            {
                name = name.localName;
            };
            var index:int = -1;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                };
            }
            catch(e:Error)
            {
            };
            if (index == -1)
            {
                message = resourceManager.getString("collections", "unknownProperty", [name]);
                throw (new Error(message));
            };
            return (getItemAt(index));
        }

        public function enableAutoUpdate():void
        {
            if (autoUpdateCounter > 0)
            {
                autoUpdateCounter--;
                if (autoUpdateCounter == 0)
                {
                    handlePendingUpdates();
                };
            };
        }

        mx_internal function reset():void
        {
            var _local_1:CollectionEvent;
            internalRefresh(false);
            if (dispatchResetEvent)
            {
                _local_1 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _local_1.kind = CollectionEventKind.RESET;
                dispatchEvent(_local_1);
            };
        }

        public function toArray():Array
        {
            var _local_1:Array;
            if (localIndex)
            {
                _local_1 = localIndex.concat();
            }
            else
            {
                _local_1 = list.toArray();
            };
            return (_local_1);
        }

        public function removeItemAt(_arg_1:int):Object
        {
            var _local_3:String;
            var _local_4:Object;
            if (((_arg_1 < 0) || (_arg_1 >= length)))
            {
                _local_3 = resourceManager.getString("collections", "outOfBounds", [_arg_1]);
                throw (new RangeError(_local_3));
            };
            var _local_2:int = _arg_1;
            if (localIndex)
            {
                _local_4 = localIndex[_arg_1];
                _local_2 = list.getItemIndex(_local_4);
            };
            return (list.removeItemAt(_local_2));
        }

        override flash_proxy function callProperty(_arg_1:*, ... _args):*
        {
            return (null);
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            refresh();
        }

        override flash_proxy function setProperty(name:*, value:*):void
        {
            var n:Number;
            var message:String;
            if ((name is QName))
            {
                name = name.localName;
            };
            var index:int = -1;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                };
            }
            catch(e:Error)
            {
            };
            if (index == -1)
            {
                message = resourceManager.getString("collections", "unknownProperty", [name]);
                throw (new Error(message));
            };
            setItemAt(value, index);
        }

        public function addItem(_arg_1:Object):void
        {
            addItemAt(_arg_1, length);
        }

        private function internalRefresh(dispatch:Boolean):Boolean
        {
            var tmp:Array;
            var len:int;
            var i:int;
            var item:Object;
            var refreshEvent:CollectionEvent;
            if (((sort) || (!(filterFunction == null))))
            {
                try
                {
                    populateLocalIndex();
                }
                catch(pending:ItemPendingError)
                {
                    pending.addResponder(new ItemResponder(function (_arg_1:Object, _arg_2:Object=null):void
                    {
                        internalRefresh(dispatch);
                    }, function (_arg_1:Object, _arg_2:Object=null):void
                    {
                    }));
                    return (false);
                };
                if (filterFunction != null)
                {
                    tmp = [];
                    len = localIndex.length;
                    i = 0;
                    while (i < len)
                    {
                        item = localIndex[i];
                        if (filterFunction(item))
                        {
                            tmp.push(item);
                        };
                        i = (i + 1);
                    };
                    localIndex = tmp;
                };
                if (sort)
                {
                    sort.sort(localIndex);
                    dispatch = true;
                };
            }
            else
            {
                if (localIndex)
                {
                    localIndex = null;
                };
            };
            revision++;
            pendingUpdates = null;
            if (dispatch)
            {
                refreshEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                refreshEvent.kind = CollectionEventKind.REFRESH;
                dispatchEvent(refreshEvent);
            };
            return (true);
        }

        public function set filterFunction(_arg_1:Function):void
        {
            _filterFunction = _arg_1;
            dispatchEvent(new Event("filterFunctionChanged"));
        }

        mx_internal function getBookmarkIndex(bookmark:CursorBookmark):int
        {
            var bm:ListCollectionViewBookmark;
            var message:String;
            if (((!(bookmark is ListCollectionViewBookmark)) || (!(ListCollectionViewBookmark(bookmark).view == this))))
            {
                message = resourceManager.getString("collections", "bookmarkNotFound");
                throw (new CollectionViewError(message));
            };
            bm = ListCollectionViewBookmark(bookmark);
            if (bm.viewRevision != revision)
            {
                if ((((bm.index < 0) || (bm.index >= length)) || (!(getItemAt(bm.index) == bm.value))))
                {
                    try
                    {
                        bm.index = getItemIndex(bm.value);
                    }
                    catch(e:SortError)
                    {
                        bm.index = getLocalItemIndex(bm.value);
                    };
                };
                bm.viewRevision = revision;
            };
            return (bm.index);
        }

        public function refresh():Boolean
        {
            return (internalRefresh(true));
        }

        [Bindable("filterFunctionChanged")]
        public function get filterFunction():Function
        {
            return (_filterFunction);
        }

        public function createCursor():IViewCursor
        {
            return (new ListCollectionViewCursor(this));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (eventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable("collectionChange")]
        public function get length():int
        {
            if (localIndex)
            {
                return (localIndex.length);
            };
            if (list)
            {
                return (list.length);
            };
            return (0);
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            return ((_arg_1 < length) ? (_arg_1 + 1) : 0);
        }

        public function disableAutoUpdate():void
        {
            autoUpdateCounter++;
        }

        public function toString():String
        {
            if (localIndex)
            {
                return (ObjectUtil.toString(localIndex));
            };
            if (((list) && (Object(list).toString)))
            {
                return (Object(list).toString());
            };
            return (getQualifiedClassName(this));
        }

        private function listChangeHandler(_arg_1:CollectionEvent):void
        {
            if (autoUpdateCounter > 0)
            {
                if (!pendingUpdates)
                {
                    pendingUpdates = [];
                };
                pendingUpdates.push(_arg_1);
            }
            else
            {
                switch (_arg_1.kind)
                {
                    case CollectionEventKind.ADD:
                        addItemsToView(_arg_1.items, _arg_1.location);
                        return;
                    case CollectionEventKind.RESET:
                        reset();
                        return;
                    case CollectionEventKind.REMOVE:
                        removeItemsFromView(_arg_1.items, _arg_1.location);
                        return;
                    case CollectionEventKind.REPLACE:
                        replaceItemsInView(_arg_1.items, _arg_1.location);
                        return;
                    case CollectionEventKind.UPDATE:
                        handlePropertyChangeEvents(_arg_1.items);
                        return;
                    default:
                        dispatchEvent(_arg_1);
                };
            };
        }


    }
}//package mx.collections

import mx.collections.CursorBookmark;
import mx.collections.ListCollectionView;
import flash.events.EventDispatcher;
import mx.collections.IViewCursor;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.events.CollectionEvent;
import mx.collections.errors.ItemPendingError;
import mx.collections.Sort;
import mx.collections.errors.SortError;
import mx.collections.errors.CursorError;
import mx.events.FlexEvent;
import mx.collections.errors.CollectionViewError;
import mx.events.CollectionEventKind;
import mx.collections.ICollectionView;
import mx.core.mx_internal; 

use namespace mx_internal;

class ListCollectionViewBookmark extends CursorBookmark 
{

    mx_internal var viewRevision:int;
    mx_internal var index:int;
    mx_internal var view:ListCollectionView;

    public function ListCollectionViewBookmark(_arg_1:Object, _arg_2:ListCollectionView, _arg_3:int, _arg_4:int)
    {
        super(_arg_1);
        this.view = _arg_2;
        this.viewRevision = _arg_3;
        this.index = _arg_4;
    }

    override public function getViewIndex():int
    {
        return (view.getBookmarkIndex(this));
    }


}

class ListCollectionViewCursor extends EventDispatcher implements IViewCursor 
{

    /*private*/ static const BEFORE_FIRST_INDEX:int = -1;
    /*private*/ static const AFTER_LAST_INDEX:int = -2;

    /*private*/ var _view:ListCollectionView;
    /*private*/ var invalid:Boolean;
    /*private*/ var resourceManager:IResourceManager = ResourceManager.getInstance();
    /*private*/ var currentIndex:int;
    /*private*/ var currentValue:Object;

    public function ListCollectionViewCursor(view:ListCollectionView)
    {
        super();
        _view = view;
        _view.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionEventHandler, false, 0, true);
        currentIndex = ((view.length > 0) ? 0 : AFTER_LAST_INDEX);
        if (currentIndex == 0)
        {
            try
            {
                setCurrent(view.getItemAt(0), false);
            }
            catch(e:ItemPendingError)
            {
                currentIndex = BEFORE_FIRST_INDEX;
                setCurrent(null, false);
            };
        };
    }

    public function findAny(values:Object):Boolean
    {
        var index:int;
        checkValid();
        var lcView:ListCollectionView = ListCollectionView(view);
        try
        {
            index = lcView.findItem(values, Sort.ANY_INDEX_MODE);
        }
        catch(e:SortError)
        {
            throw (new CursorError(e.message));
        };
        if (index > -1)
        {
            currentIndex = index;
            setCurrent(lcView.getItemAt(currentIndex));
        };
        return (index > -1);
    }

    public function remove():Object
    {
        var oldIndex:int;
        var message:String;
        if (((beforeFirst) || (afterLast)))
        {
            message = resourceManager.getString("collections", "invalidRemove");
            throw (new CursorError(message));
        };
        oldIndex = currentIndex;
        currentIndex++;
        if (currentIndex >= view.length)
        {
            currentIndex = AFTER_LAST_INDEX;
            setCurrent(null);
        }
        else
        {
            try
            {
                setCurrent(ListCollectionView(view).getItemAt(currentIndex));
            }
            catch(e:ItemPendingError)
            {
                setCurrent(null, false);
                ListCollectionView(view).removeItemAt(oldIndex);
                throw (e);
            };
        };
        var removed:Object = ListCollectionView(view).removeItemAt(oldIndex);
        return (removed);
    }

    /*private*/ function setCurrent(_arg_1:Object, _arg_2:Boolean=true):void
    {
        currentValue = _arg_1;
        if (_arg_2)
        {
            dispatchEvent(new FlexEvent(FlexEvent.CURSOR_UPDATE));
        };
    }

    public function seek(bookmark:CursorBookmark, offset:int=0, prefetch:int=0):void
    {
        var message:String;
        checkValid();
        if (view.length == 0)
        {
            currentIndex = AFTER_LAST_INDEX;
            setCurrent(null, false);
            return;
        };
        var newIndex:int = currentIndex;
        if (bookmark == CursorBookmark.FIRST)
        {
            newIndex = 0;
        }
        else
        {
            if (bookmark == CursorBookmark.LAST)
            {
                newIndex = (view.length - 1);
            }
            else
            {
                if (bookmark != CursorBookmark.CURRENT)
                {
                    try
                    {
                        newIndex = ListCollectionView(view).getBookmarkIndex(bookmark);
                        if (newIndex < 0)
                        {
                            setCurrent(null);
                            message = resourceManager.getString("collections", "bookmarkInvalid");
                            throw (new CursorError(message));
                        };
                    }
                    catch(bmError:CollectionViewError)
                    {
                        message = resourceManager.getString("collections", "bookmarkInvalid");
                        throw (new CursorError(message));
                    };
                };
            };
        };
        newIndex = (newIndex + offset);
        var newCurrent:Object;
        if (newIndex >= view.length)
        {
            currentIndex = AFTER_LAST_INDEX;
        }
        else
        {
            if (newIndex < 0)
            {
                currentIndex = BEFORE_FIRST_INDEX;
            }
            else
            {
                newCurrent = ListCollectionView(view).getItemAt(newIndex, prefetch);
                currentIndex = newIndex;
            };
        };
        setCurrent(newCurrent);
    }

    public function insert(_arg_1:Object):void
    {
        var _local_2:int;
        var _local_3:String;
        if (afterLast)
        {
            _local_2 = view.length;
        }
        else
        {
            if (beforeFirst)
            {
                if (view.length > 0)
                {
                    _local_3 = resourceManager.getString("collections", "invalidInsert");
                    throw (new CursorError(_local_3));
                };
                _local_2 = 0;
            }
            else
            {
                _local_2 = currentIndex;
            };
        };
        ListCollectionView(view).addItemAt(_arg_1, _local_2);
    }

    [Bindable("cursorUpdate")]
    public function get afterLast():Boolean
    {
        checkValid();
        return ((currentIndex == AFTER_LAST_INDEX) || (view.length == 0));
    }

    /*private*/ function checkValid():void
    {
        var _local_1:String;
        if (invalid)
        {
            _local_1 = resourceManager.getString("collections", "invalidCursor");
            throw (new CursorError(_local_1));
        };
    }

    /*private*/ function collectionEventHandler(event:CollectionEvent):void
    {
        switch (event.kind)
        {
            case CollectionEventKind.ADD:
                if (event.location <= currentIndex)
                {
                    currentIndex = (currentIndex + event.items.length);
                };
                return;
            case CollectionEventKind.REMOVE:
                if (event.location < currentIndex)
                {
                    currentIndex = (currentIndex - event.items.length);
                }
                else
                {
                    if (event.location == currentIndex)
                    {
                        if (currentIndex < view.length)
                        {
                            try
                            {
                                setCurrent(ListCollectionView(view).getItemAt(currentIndex));
                            }
                            catch(error:ItemPendingError)
                            {
                                setCurrent(null, false);
                            };
                        }
                        else
                        {
                            currentIndex = AFTER_LAST_INDEX;
                            setCurrent(null);
                        };
                    };
                };
                return;
            case CollectionEventKind.MOVE:
                if (event.oldLocation == currentIndex)
                {
                    currentIndex = event.location;
                }
                else
                {
                    if (event.oldLocation < currentIndex)
                    {
                        currentIndex = (currentIndex - event.items.length);
                    };
                    if (event.location <= currentIndex)
                    {
                        currentIndex = (currentIndex + event.items.length);
                    };
                };
                return;
            case CollectionEventKind.REFRESH:
                if (!((beforeFirst) || (afterLast)))
                {
                    try
                    {
                        currentIndex = ListCollectionView(view).getItemIndex(currentValue);
                    }
                    catch(e:SortError)
                    {
                        if (ListCollectionView(view).sort)
                        {
                            currentIndex = ListCollectionView(view).getLocalItemIndex(currentValue);
                        };
                    };
                    if (currentIndex == -1)
                    {
                        setCurrent(null);
                    };
                };
                return;
            case CollectionEventKind.REPLACE:
                if (event.location == currentIndex)
                {
                    try
                    {
                        setCurrent(ListCollectionView(view).getItemAt(currentIndex));
                    }
                    catch(error:ItemPendingError)
                    {
                        setCurrent(null, false);
                    };
                };
                return;
            case CollectionEventKind.RESET:
                currentIndex = BEFORE_FIRST_INDEX;
                setCurrent(null);
                return;
        };
    }

    public function moveNext():Boolean
    {
        if (afterLast)
        {
            return (false);
        };
        var _local_1:int = ((beforeFirst) ? 0 : (currentIndex + 1));
        if (_local_1 >= view.length)
        {
            _local_1 = AFTER_LAST_INDEX;
            setCurrent(null);
        }
        else
        {
            setCurrent(ListCollectionView(view).getItemAt(_local_1));
        };
        currentIndex = _local_1;
        return (!(afterLast));
    }

    public function get view():ICollectionView
    {
        checkValid();
        return (_view);
    }

    public function movePrevious():Boolean
    {
        if (beforeFirst)
        {
            return (false);
        };
        var _local_1:int = ((afterLast) ? (view.length - 1) : (currentIndex - 1));
        if (_local_1 == -1)
        {
            _local_1 = BEFORE_FIRST_INDEX;
            setCurrent(null);
        }
        else
        {
            setCurrent(ListCollectionView(view).getItemAt(_local_1));
        };
        currentIndex = _local_1;
        return (!(beforeFirst));
    }

    public function findLast(values:Object):Boolean
    {
        var index:int;
        checkValid();
        var lcView:ListCollectionView = ListCollectionView(view);
        try
        {
            index = lcView.findItem(values, Sort.LAST_INDEX_MODE);
        }
        catch(sortError:SortError)
        {
            throw (new CursorError(sortError.message));
        };
        if (index > -1)
        {
            currentIndex = index;
            setCurrent(lcView.getItemAt(currentIndex));
        };
        return (index > -1);
    }

    [Bindable("cursorUpdate")]
    public function get beforeFirst():Boolean
    {
        checkValid();
        return ((currentIndex == BEFORE_FIRST_INDEX) || (view.length == 0));
    }

    [Bindable("cursorUpdate")]
    public function get bookmark():CursorBookmark
    {
        checkValid();
        if (((view.length == 0) || (beforeFirst)))
        {
            return (CursorBookmark.FIRST);
        };
        if (afterLast)
        {
            return (CursorBookmark.LAST);
        };
        return (ListCollectionView(view).getBookmark(currentIndex));
    }

    public function findFirst(values:Object):Boolean
    {
        var index:int;
        checkValid();
        var lcView:ListCollectionView = ListCollectionView(view);
        try
        {
            index = lcView.findItem(values, Sort.FIRST_INDEX_MODE);
        }
        catch(sortError:SortError)
        {
            throw (new CursorError(sortError.message));
        };
        if (index > -1)
        {
            currentIndex = index;
            setCurrent(lcView.getItemAt(currentIndex));
        };
        return (index > -1);
    }

    [Bindable("cursorUpdate")]
    public function get current():Object
    {
        checkValid();
        return (currentValue);
    }


}


