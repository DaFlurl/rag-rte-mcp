// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.ModifiedCollectionView

package mx.collections
{
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.utils.Dictionary;
    import mx.collections.errors.CollectionViewError;
    import mx.events.PropertyChangeEvent;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ModifiedCollectionView implements ICollectionView 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const REMOVED:String = "removed";
        public static const ADDED:String = "added";
        public static const REPLACED:String = "replaced";
        public static const REPLACEMENT:String = "replacement";

        private var _showPreserved:Boolean = false;
        private var list:ICollectionView;
        private var deltaLength:int = 0;

        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var deltas:Array = [];
        private var removedItems:Dictionary = new Dictionary(true);
        private var addedItems:Dictionary = new Dictionary(true);
        private var replacedItems:Dictionary = new Dictionary(true);
        private var replacementItems:Dictionary = new Dictionary(true);
        private var itemWrappersByIndex:Array = [];
        private var itemWrappersByCollectionMod:Dictionary = new Dictionary(true);

        public function ModifiedCollectionView(_arg_1:ICollectionView)
        {
            this.list = _arg_1;
        }

        mx_internal function getBookmarkIndex(_arg_1:CursorBookmark):int
        {
            var _local_3:String;
            if (((!(_arg_1 is ModifiedCollectionViewBookmark)) || (!(ModifiedCollectionViewBookmark(_arg_1).view == this))))
            {
                _local_3 = resourceManager.getString("collections", "bookmarkNotFound");
                throw (new CollectionViewError(_local_3));
            };
            var _local_2:ModifiedCollectionViewBookmark = ModifiedCollectionViewBookmark(_arg_1);
            return (_local_2.index);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (false);
        }

        private function removeModification(_arg_1:CollectionModification):Boolean
        {
            var _local_2:int;
            while (_local_2 < deltas.length)
            {
                if (deltas[_local_2] == _arg_1)
                {
                    deltas.splice(_local_2, 1);
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }

        mx_internal function getWrappedItemUsingCursor(_arg_1:ModifiedCollectionViewCursor, _arg_2:int):Object
        {
            var _local_6:CollectionModification;
            var _local_9:Object;
            var _local_3:int = _arg_2;
            var _local_4:Object;
            var _local_5:CollectionModification;
            var _local_7:Boolean;
            var _local_8:int;
            while (_local_8 < deltas.length)
            {
                _local_6 = deltas[_local_8];
                if (_local_3 < _local_6.index) break;
                if (_local_6.modificationType == CollectionModification.REPLACE)
                {
                    if ((((_local_3 == _local_6.index) && (_local_6.showOldReplace)) && (_showPreserved)))
                    {
                        _local_5 = _local_6;
                        break;
                    };
                    if (((((_local_3 == (_local_6.index + 1)) && (_local_6.showOldReplace)) && (_local_6.showNewReplace)) && (_showPreserved)))
                    {
                        _local_3--;
                        _local_7 = true;
                        break;
                    };
                    if (((_local_3 == _local_6.index) && (((!(_local_6.showOldReplace)) && (_local_6.showNewReplace)) || (!(_showPreserved)))))
                    {
                        _local_7 = true;
                        break;
                    };
                    _local_3 = (_local_3 - _local_6.modCount);
                }
                else
                {
                    if (isActive(_local_6))
                    {
                        if (((_local_3 == _local_6.index) && (_local_6.isRemove)))
                        {
                            _local_5 = _local_6;
                            break;
                        };
                        if (_local_3 >= _local_6.index)
                        {
                            _local_3 = (_local_3 - _local_6.modCount);
                        };
                    };
                };
                _local_8++;
            };
            if (_local_5)
            {
                _local_4 = _local_5.item;
            }
            else
            {
                _arg_1.internalCursor.seek(CursorBookmark.CURRENT, (_local_3 - _arg_1.internalIndex));
                _local_4 = _arg_1.internalCursor.current;
                _arg_1.internalIndex = _local_3;
            };
            if ((((_local_6) && (_local_3 == _local_6.index)) && (_local_6.modificationType == CollectionModification.ADD)))
            {
                _local_9 = getUniqueItemWrapper(_local_4, _local_6, _local_3);
            }
            else
            {
                _local_9 = getUniqueItemWrapper(_local_4, _local_5, _local_3);
            };
            return (_local_9);
        }

        public function contains(_arg_1:Object):Boolean
        {
            return (false);
        }

        private function integrateReplacedElements(_arg_1:CollectionEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_9:Object;
            var _local_10:Object;
            var _local_11:CollectionModification;
            var _local_12:CollectionModification;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Boolean;
            var _local_7:int = _arg_1.items.length;
            var _local_8:int;
            while (((_local_4 < deltas.length) && (_local_5 < _local_7)))
            {
                _local_9 = PropertyChangeEvent(_arg_1.items[_local_5]).oldValue;
                _local_10 = PropertyChangeEvent(_arg_1.items[_local_5]).newValue;
                _local_11 = CollectionModification(deltas[_local_4]);
                _local_12 = new CollectionModification((_arg_1.location + _local_5), _local_9, CollectionModification.REPLACE);
                if ((((_local_11.isRemove) && (_local_11.index <= _local_12.index)) || ((!(_local_11.isRemove)) && (_local_11.index < _local_12.index))))
                {
                    _local_4++;
                }
                else
                {
                    if ((((_local_11.modificationType == CollectionModification.ADD) || (_local_11.modificationType == CollectionModification.REPLACE)) && (_local_11.index == _local_12.index)))
                    {
                        _local_4++;
                        _local_5++;
                    }
                    else
                    {
                        deltas.splice((_local_4 + _local_5), 0, _local_12);
                        replacedItems[getUniqueItemWrapper(_local_9, _local_12, (_arg_1.location + _local_5))] = _local_12;
                        replacementItems[getUniqueItemWrapper(_local_10, _local_12, (_arg_1.location + _local_5), true)] = _local_12;
                        _local_5++;
                        _local_4++;
                    };
                };
            };
            while (_local_5 < _local_7)
            {
                _local_9 = PropertyChangeEvent(_arg_1.items[_local_5]).oldValue;
                _local_10 = PropertyChangeEvent(_arg_1.items[_local_5]).newValue;
                deltas.push((_local_12 = new CollectionModification((_arg_1.location + _local_5), _local_9, CollectionModification.REPLACE)));
                replacedItems[getUniqueItemWrapper(_local_9, _local_12, (_arg_1.location + _local_5))] = _local_12;
                replacementItems[getUniqueItemWrapper(_local_10, _local_12, (_arg_1.location + _local_5), true)] = _local_12;
                _local_5++;
            };
        }

        mx_internal function getBookmark(_arg_1:ModifiedCollectionViewCursor):ModifiedCollectionViewBookmark
        {
            var _local_4:String;
            var _local_2:int = _arg_1.currentIndex;
            if (((_local_2 < 0) || (_local_2 > length)))
            {
                _local_4 = resourceManager.getString("collections", "invalidIndex", [_local_2]);
                throw (new CollectionViewError(_local_4));
            };
            var _local_3:Object = _arg_1.current;
            return (new ModifiedCollectionViewBookmark(_local_3, this, 0, _local_2, _arg_1.internalCursor.bookmark, _arg_1.internalIndex));
        }

        public function get sort():Sort
        {
            return (null);
        }

        public function itemUpdated(_arg_1:Object, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):void
        {
        }

        public function processCollectionEvent(_arg_1:CollectionEvent, _arg_2:int, _arg_3:int):void
        {
            switch (_arg_1.kind)
            {
                case CollectionEventKind.ADD:
                    integrateAddedElements(_arg_1, _arg_2, _arg_3);
                    return;
                case CollectionEventKind.REMOVE:
                    integrateRemovedElements(_arg_1, _arg_2, _arg_3);
                    return;
                case CollectionEventKind.REPLACE:
                    integrateReplacedElements(_arg_1, _arg_2, _arg_3);
                    return;
            };
        }

        public function get showPreservedState():Boolean
        {
            return (_showPreserved);
        }

        public function getSemantics(_arg_1:ItemWrapper):String
        {
            if (removedItems[_arg_1])
            {
                return (ModifiedCollectionView.REMOVED);
            };
            if (addedItems[_arg_1])
            {
                return (ModifiedCollectionView.ADDED);
            };
            if (replacedItems[_arg_1])
            {
                return (ModifiedCollectionView.REPLACED);
            };
            if (replacementItems[_arg_1])
            {
                return (ModifiedCollectionView.REPLACEMENT);
            };
            return (null);
        }

        private function getUniqueItemWrapper(_arg_1:Object, _arg_2:CollectionModification, _arg_3:int, _arg_4:Boolean=false):Object
        {
            if (((_arg_2) && ((_arg_2.isRemove) || ((_arg_2.modificationType == CollectionModification.REPLACE) && (!(_arg_4))))))
            {
                if (!itemWrappersByCollectionMod[_arg_2])
                {
                    itemWrappersByCollectionMod[_arg_2] = new ItemWrapper(_arg_1);
                };
                return (itemWrappersByCollectionMod[_arg_2]);
            };
            if (((_arg_2) && (_arg_2.modificationType == CollectionModification.ADD)))
            {
                _arg_3 = _arg_2.index;
            };
            if (!itemWrappersByIndex[_arg_3])
            {
                itemWrappersByIndex[_arg_3] = new ItemWrapper(_arg_1);
            };
            return (itemWrappersByIndex[_arg_3]);
        }

        public function enableAutoUpdate():void
        {
        }

        public function set sort(_arg_1:Sort):void
        {
        }

        public function removeItem(_arg_1:ItemWrapper):void
        {
            var _local_2:CollectionModification = (removedItems[_arg_1] as CollectionModification);
            if (!_local_2)
            {
                _local_2 = (replacedItems[_arg_1] as CollectionModification);
                if (_local_2)
                {
                    delete replacedItems[_arg_1];
                    _local_2.stopShowingReplacedValue();
                    deltaLength--;
                    if (_local_2.modCount == 0)
                    {
                        removeModification(_local_2);
                    };
                };
            }
            else
            {
                if (removeModification(_local_2))
                {
                    delete removedItems[_arg_1];
                    deltaLength--;
                };
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
        }

        private function integrateRemovedElements(_arg_1:CollectionEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_9:CollectionModification;
            var _local_10:CollectionModification;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int = _arg_1.items.length;
            var _local_8:int;
            while (((_local_4 < deltas.length) && (_local_5 < _local_7)))
            {
                _local_9 = CollectionModification(deltas[_local_4]);
                _local_10 = new CollectionModification(_arg_1.location, _arg_1.items[_local_5], CollectionModification.REMOVE);
                removedItems[getUniqueItemWrapper(_arg_1.items[_local_5], _local_10, 0)] = _local_10;
                if (_local_8 != 0)
                {
                    _local_9.index = (_local_9.index + _local_8);
                };
                if ((((_local_9.isRemove) && (_local_9.index <= _local_10.index)) || ((!(_local_9.isRemove)) && (_local_9.index < _local_10.index))))
                {
                    _local_4++;
                }
                else
                {
                    if (((!(_local_9.isRemove)) && (_local_9.index == _local_10.index)))
                    {
                        deltas.splice((_local_4 + _local_5), 1);
                    }
                    else
                    {
                        deltas.splice((_local_4 + _local_5), 0, _local_10);
                        _local_4++;
                    };
                    _local_8--;
                    _local_5++;
                };
            };
            while (_local_4 < deltas.length)
            {
                _local_9 = CollectionModification(deltas[_local_4++]);
                _local_9.index = (_local_9.index + _local_8);
            };
            while (_local_5 < _local_7)
            {
                deltas.push((_local_10 = new CollectionModification(_arg_1.location, _arg_1.items[_local_5], CollectionModification.REMOVE)));
                removedItems[getUniqueItemWrapper(_arg_1.items[_local_5], _local_10, 0)] = _local_10;
                _local_5++;
            };
            deltaLength = (deltaLength + (_arg_1.items.length - _local_6));
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (false);
        }

        private function isActive(_arg_1:CollectionModification):Boolean
        {
            return (_showPreserved);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
        }

        public function refresh():Boolean
        {
            return (false);
        }

        public function addItem(_arg_1:ItemWrapper):void
        {
            var _local_2:CollectionModification = (addedItems[_arg_1] as CollectionModification);
            if (!_local_2)
            {
                _local_2 = (replacementItems[_arg_1] as CollectionModification);
                if (_local_2)
                {
                    _local_2.startShowingReplacementValue();
                    deltaLength++;
                    if (_local_2.modCount == 0)
                    {
                        removeModification(_local_2);
                    };
                };
            }
            else
            {
                if (removeModification(_local_2))
                {
                    deltaLength++;
                };
            };
        }

        public function get length():int
        {
            return (list.length + ((_showPreserved) ? deltaLength : 0));
        }

        public function set filterFunction(_arg_1:Function):void
        {
        }

        public function set showPreservedState(_arg_1:Boolean):void
        {
            _showPreserved = _arg_1;
        }

        public function createCursor():IViewCursor
        {
            var _local_1:IViewCursor = list.createCursor();
            var _local_2:Object = _local_1.current;
            return (new ModifiedCollectionViewCursor(this, _local_1, _local_2));
        }

        private function integrateAddedElements(_arg_1:CollectionEvent, _arg_2:int, _arg_3:int):void
        {
            var _local_9:CollectionModification;
            var _local_10:CollectionModification;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Boolean;
            var _local_7:int = _arg_1.items.length;
            var _local_8:int;
            while (((_local_4 < deltas.length) && (_local_5 < _local_7)))
            {
                _local_9 = CollectionModification(deltas[_local_4]);
                _local_10 = new CollectionModification((_arg_1.location + _local_5), null, CollectionModification.ADD);
                addedItems[getUniqueItemWrapper(_arg_1.items[_local_5], _local_10, 0)] = _local_10;
                if ((((_local_9.isRemove) && (_local_9.index <= _local_10.index)) || ((!(_local_9.isRemove)) && (_local_9.index < _local_10.index))))
                {
                    _local_4++;
                }
                else
                {
                    deltas.splice((_local_4 + _local_5), 0, _local_10);
                    _local_8++;
                    _local_5++;
                    _local_4++;
                };
            };
            while (_local_4 < deltas.length)
            {
                _local_9 = CollectionModification(deltas[_local_4++]);
                _local_9.index = (_local_9.index + _local_8);
            };
            while (_local_5 < _local_7)
            {
                deltas.push((_local_10 = new CollectionModification((_arg_1.location + _local_5), null, CollectionModification.ADD)));
                addedItems[getUniqueItemWrapper(_arg_1.items[_local_5], _local_10, 0)] = _local_10;
                _local_5++;
            };
            deltaLength = (deltaLength - _arg_1.items.length);
        }

        public function disableAutoUpdate():void
        {
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (false);
        }

        public function get filterFunction():Function
        {
            return (null);
        }


    }
}//package mx.collections

import mx.collections.CursorBookmark;
import mx.collections.ModifiedCollectionView;
import flash.events.EventDispatcher;
import mx.collections.IViewCursor;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.collections.errors.ItemPendingError;
import mx.collections.errors.CursorError;
import mx.collections.errors.CollectionViewError;
import mx.collections.ICollectionView;
import mx.events.FlexEvent;
import mx.core.mx_internal; 

use namespace mx_internal;

class ModifiedCollectionViewBookmark extends CursorBookmark 
{

    mx_internal var viewRevision:int;
    mx_internal var index:int;
    mx_internal var internalBookmark:CursorBookmark;
    mx_internal var view:ModifiedCollectionView;
    mx_internal var internalIndex:int;

    public function ModifiedCollectionViewBookmark(_arg_1:Object, _arg_2:ModifiedCollectionView, _arg_3:int, _arg_4:int, _arg_5:CursorBookmark, _arg_6:int)
    {
        super(_arg_1);
        this.view = _arg_2;
        this.viewRevision = _arg_3;
        this.index = _arg_4;
        this.internalBookmark = _arg_5;
        this.internalIndex = _arg_6;
    }

    override public function getViewIndex():int
    {
        return (view.getBookmarkIndex(this));
    }


}

class ModifiedCollectionViewCursor extends EventDispatcher implements IViewCursor 
{

    /*private*/ static const BEFORE_FIRST_INDEX:int = -1;
    /*private*/ static const AFTER_LAST_INDEX:int = -2;

    /*private*/ var _view:ModifiedCollectionView;
    /*private*/ var resourceManager:IResourceManager = ResourceManager.getInstance();
    public var internalIndex:int;
    mx_internal var currentIndex:int;
    public var internalCursor:IViewCursor;
    /*private*/ var invalid:Boolean;
    /*private*/ var currentValue:Object;

    public function ModifiedCollectionViewCursor(view:ModifiedCollectionView, cursor:IViewCursor, current:Object)
    {
        super();
        _view = view;
        internalCursor = cursor;
        if (((cursor.beforeFirst) && (!(current))))
        {
            internalIndex = BEFORE_FIRST_INDEX;
        }
        else
        {
            if (((cursor.afterLast) && (!(current))))
            {
                internalIndex = AFTER_LAST_INDEX;
            }
            else
            {
                internalIndex = 0;
            };
        };
        currentIndex = ((view.length > 0) ? 0 : AFTER_LAST_INDEX);
        if (currentIndex == 0)
        {
            try
            {
                setCurrent(current, false);
            }
            catch(e:ItemPendingError)
            {
                currentIndex = BEFORE_FIRST_INDEX;
                setCurrent(null, false);
            };
        };
    }

    public function findAny(_arg_1:Object):Boolean
    {
        return (false);
    }

    public function findFirst(_arg_1:Object):Boolean
    {
        return (false);
    }

    public function seek(bookmark:CursorBookmark, offset:int=0, prefetch:int=0):void
    {
        var message:String;
        var mcvBookmark:ModifiedCollectionViewBookmark;
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
            internalIndex = 0;
            internalCursor.seek(CursorBookmark.FIRST);
        }
        else
        {
            if (bookmark == CursorBookmark.LAST)
            {
                newIndex = (view.length - 1);
                internalCursor.seek(CursorBookmark.LAST);
            }
            else
            {
                if (bookmark != CursorBookmark.CURRENT)
                {
                    try
                    {
                        mcvBookmark = (bookmark as ModifiedCollectionViewBookmark);
                        newIndex = ModifiedCollectionView(view).getBookmarkIndex(bookmark);
                        if (((!(mcvBookmark)) || (newIndex < 0)))
                        {
                            setCurrent(null);
                            message = resourceManager.getString("collections", "bookmarkInvalid");
                            throw (new CursorError(message));
                        };
                        internalIndex = mcvBookmark.internalIndex;
                        internalCursor.seek(mcvBookmark.internalBookmark);
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
                newCurrent = ModifiedCollectionView(view).getWrappedItemUsingCursor(this, newIndex);
                currentIndex = newIndex;
            };
        };
        setCurrent(newCurrent);
    }

    public function insert(_arg_1:Object):void
    {
    }

    [Bindable("cursorUpdate")]
    public function get afterLast():Boolean
    {
        checkValid();
        return ((currentIndex == AFTER_LAST_INDEX) || (view.length == 0));
    }

    public function remove():Object
    {
        return (null);
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
            setCurrent(ModifiedCollectionView(view).getWrappedItemUsingCursor(this, _local_1));
        };
        currentIndex = _local_1;
        return (!(beforeFirst));
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
            setCurrent(ModifiedCollectionView(view).getWrappedItemUsingCursor(this, _local_1));
        };
        currentIndex = _local_1;
        return (!(afterLast));
    }

    public function findLast(_arg_1:Object):Boolean
    {
        return (false);
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
        return (ModifiedCollectionView(view).getBookmark(this));
    }

    [Bindable("cursorUpdate")]
    public function get current():Object
    {
        checkValid();
        return (currentValue);
    }

    /*private*/ function setCurrent(_arg_1:Object, _arg_2:Boolean=true):void
    {
        currentValue = _arg_1;
        if (_arg_2)
        {
            dispatchEvent(new FlexEvent(FlexEvent.CURSOR_UPDATE));
        };
    }


}

class CollectionModification 
{

    public static const REMOVE:String = "remove";
    public static const ADD:String = "add";
    public static const REPLACE:String = "replace";

    public var showOldReplace:Boolean = true;
    /*private*/ var _modCount:int = 0;
    public var showNewReplace:Boolean = false;
    public var index:int;
    public var modificationType:String = null;
    public var item:Object = null;

    public function CollectionModification(_arg_1:int, _arg_2:Object, _arg_3:String)
    {
        this.index = _arg_1;
        this.modificationType = _arg_3;
        if (_arg_3 != CollectionModification.ADD)
        {
            this.item = _arg_2;
        };
        if (_arg_3 == CollectionModification.REMOVE)
        {
            _modCount = 1;
        }
        else
        {
            if (_arg_3 == CollectionModification.ADD)
            {
                _modCount = -1;
            };
        };
    }

    public function startShowingReplacementValue():void
    {
        showNewReplace = true;
        _modCount++;
    }

    public function get modCount():int
    {
        return (_modCount);
    }

    public function get isRemove():Boolean
    {
        return (modificationType == CollectionModification.REMOVE);
    }

    public function stopShowingReplacedValue():void
    {
        showOldReplace = false;
        _modCount--;
    }


}


