// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.collections.DegrafaCollection

package com.degrafa.core.collections
{
    import com.degrafa.core.DegrafaObject;
    import flash.utils.getQualifiedClassName;
    import com.degrafa.core.IDegrafaObject;
    import mx.events.PropertyChangeEvent;

    public class DegrafaCollection extends DegrafaObject 
    {

        private var _items:Array = [];
        protected var _cursor:DegrafaCursor;
        private var _enableTypeChecking:Boolean = true;
        private var type:Class;

        public function DegrafaCollection(_arg_1:Class, _arg_2:Array=null, _arg_3:Boolean=false, _arg_4:Boolean=true)
        {
            this.type = _arg_1;
            _enableTypeChecking = _arg_4;
            suppressEventProcessing = _arg_3;
            if (_arg_2)
            {
                items = _arg_2;
            };
        }

        public function get items():Array
        {
            return (_items);
        }

        public function get cursor():DegrafaCursor
        {
            if (!_cursor)
            {
                _cursor = new DegrafaCursor(items);
            };
            return (_cursor);
        }

        public function reverse():Array
        {
            var _local_1:Array = _items;
            items = items.reverse();
            initChange("items", _local_1, _items, this);
            return (items);
        }

        private function checkValidTypes(_arg_1:Array):void
        {
            var _local_2:Object;
            if (_enableTypeChecking)
            {
                for each (_local_2 in _arg_1)
                {
                    if (((!(_local_2)) is type))
                    {
                        throw (new TypeError(((getQualifiedClassName(_local_2) + " is not a valid ") + getQualifiedClassName(type))));
                    };
                };
            };
        }

        public function set items(_arg_1:Array):void
        {
            var _local_2:Array;
            checkValidTypes(_arg_1);
            if (_arg_1 != _items)
            {
                if (((enableEvents) && (hasEventManager)))
                {
                    removeListeners();
                };
                _local_2 = _items;
                _items = _arg_1;
                if (((enableEvents) && (hasEventManager)))
                {
                    initChange("items", _local_2, _items, this);
                };
            };
            addListeners();
        }

        public function indexOf(_arg_1:*, _arg_2:int=0):int
        {
            return (items.indexOf(_arg_1, _arg_2));
        }

        public function unshift(... _args):uint
        {
            checkValidTypes(_args);
            var _local_2:Array = _items;
            var _local_3:int;
            var _local_4:int = _args.length;
            while (_local_3 < _local_4)
            {
                addListener(_args[_local_3]);
                items.unshift(_args[_local_3]);
                _local_3++;
            };
            initChange("items", _local_2, _items, this);
            return (items.length);
        }

        public function pop():*
        {
            removeListener(items[(items.length - 1)]);
            var _local_1:Array = _items;
            var _local_2:* = items.pop();
            initChange("items", _local_1, _items, this);
            return (_local_2);
        }

        public function slice(_arg_1:int=0, _arg_2:int=0xFFFFFF):Array
        {
            return (items.slice(_arg_1, _arg_2));
        }

        public function lastIndexOf(_arg_1:*, _arg_2:int=2147483647):int
        {
            return (items.lastIndexOf(_arg_1, _arg_2));
        }

        public function concat(... _args):Array
        {
            var _local_2:Array = _items;
            checkValidTypes(_args);
            var _local_3:int;
            var _local_4:int = _args.length;
            while (_local_3 < _local_4)
            {
                addListener(_args[_local_3]);
                _local_3++;
            };
            _items = items.concat(_args);
            initChange("items", _local_2, _items, this);
            return (_items);
        }

        protected function _addItem(_arg_1:*):*
        {
            addListener(_arg_1);
            concat(_arg_1);
            return (_arg_1);
        }

        protected function _removeItem(_arg_1:*):*
        {
            var _local_2:int = indexOf(_arg_1, 0);
            _removeItemAt(_local_2);
            return (null);
        }

        public function get enableTypeChecking():Boolean
        {
            return (_enableTypeChecking);
        }

        public function removeListener(_arg_1:*):void
        {
            if ((_arg_1 is IDegrafaObject))
            {
                IDegrafaObject(_arg_1).parent = null;
                IDegrafaObject(_arg_1).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
            };
        }

        public function push(... _args):uint
        {
            var _local_2:Array = _items;
            checkValidTypes(_args);
            var _local_3:int;
            var _local_4:int = _args.length;
            while (_local_3 < _local_4)
            {
                addListener(_args[_local_3]);
                items.push(_args[_local_3]);
                _local_3++;
            };
            initChange("items", _local_2, _items, this);
            return (items.length);
        }

        public function removeListeners():void
        {
            var _local_1:Object;
            for each (_local_1 in items)
            {
                if ((_local_1 is IDegrafaObject))
                {
                    IDegrafaObject(_local_1).parent = null;
                    IDegrafaObject(_local_1).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                };
            };
        }

        protected function _setItemIndex(_arg_1:*, _arg_2:Number):Boolean
        {
            var _local_3:Array = items.splice(items.indexOf(_arg_1), 1);
            items.splice(_arg_2, 0, _local_3[0]);
            return (true);
        }

        protected function _getItemAt(_arg_1:Number):*
        {
            return (items[_arg_1]);
        }

        public function addListeners():void
        {
            var _local_1:Object;
            if (enableEvents)
            {
                for each (_local_1 in items)
                {
                    if ((_local_1 is IDegrafaObject))
                    {
                        IDegrafaObject(_local_1).parent = this.parent;
                        if (IDegrafaObject(_local_1).enableEvents)
                        {
                            IDegrafaObject(_local_1).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                        };
                    };
                };
            };
        }

        public function every(_arg_1:Function, _arg_2:*=null):Boolean
        {
            return (items.every(_arg_1, _arg_2));
        }

        public function map(_arg_1:Function, _arg_2:*=null):Array
        {
            return (items.map(_arg_1, _arg_2));
        }

        public function shift():*
        {
            removeListener(items[0]);
            var _local_1:Array = _items;
            var _local_2:* = items.shift();
            initChange("items", _local_1, _items, this);
            return (_local_2);
        }

        public function propertyChangeHandler(_arg_1:PropertyChangeEvent):void
        {
            if (!suppressEventProcessing)
            {
                dispatchEvent(_arg_1);
            };
        }

        protected function _getItemIndex(_arg_1:*):int
        {
            return (indexOf(_arg_1, 0));
        }

        protected function _removeItemAt(_arg_1:Number):*
        {
            removeListener(items[_arg_1]);
            return (splice(_arg_1, 1)[1]);
        }

        public function forEach(_arg_1:Function, _arg_2:*=null):void
        {
            items.forEach(_arg_1, _arg_2);
        }

        public function sort(... _args):Array
        {
            return (items.sort(_args));
        }

        public function set enableTypeChecking(_arg_1:Boolean):void
        {
            _enableTypeChecking = _arg_1;
        }

        protected function _addItemAt(_arg_1:Object, _arg_2:Number):*
        {
            addListener(_arg_1);
            splice(_arg_2, 0, _arg_1);
            return (_arg_1);
        }

        public function join(_arg_1:*):String
        {
            return (items.join(_arg_1));
        }

        public function addListener(_arg_1:*):void
        {
            if ((_arg_1 is IDegrafaObject))
            {
                IDegrafaObject(_arg_1).parent = this.parent;
                if (enableEvents)
                {
                    if (IDegrafaObject(_arg_1).enableEvents)
                    {
                        IDegrafaObject(_arg_1).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                    };
                };
            };
        }

        public function filter(_arg_1:Function, _arg_2:*=null):Array
        {
            return (items.filter(_arg_1, _arg_2));
        }

        public function some(_arg_1:Function, _arg_2:*=null):Boolean
        {
            return (items.some(_arg_1, _arg_2));
        }

        public function splice(_arg_1:int, _arg_2:uint, ... _args):Array
        {
            var _local_7:Array;
            checkValidTypes(_args);
            var _local_4:int;
            var _local_5:int = _args.length;
            while (_local_4 < _local_5)
            {
                addListener(_args[_local_4]);
                _local_4++;
            };
            var _local_6:Array = _items;
            if (_args.length == 1)
            {
                _local_7 = _items.splice(_arg_1, _arg_2, _args[0]);
            }
            else
            {
                if (_args.length > 1)
                {
                    _local_7 = _items.splice(_arg_1, _arg_2, _args);
                }
                else
                {
                    _local_7 = _items.splice(_arg_1, _arg_2);
                };
            };
            if (_local_7)
            {
                _local_5 = _local_7.length;
                _local_4 = 0;
                while (_local_4 < _local_5)
                {
                    removeListener(_local_7[_local_4]);
                    _local_4++;
                };
            };
            initChange("items", _local_6, _items, this);
            return (_local_7);
        }

        public function sortOn(_arg_1:Object, _arg_2:Object=null):Array
        {
            return (items.sortOn(_arg_1, _arg_2));
        }


    }
}//package com.degrafa.core.collections

