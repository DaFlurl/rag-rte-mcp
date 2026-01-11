// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.Watcher

package mx.binding
{
    import mx.collections.errors.ItemPendingError;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Watcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        protected var children:Array;
        public var value:Object;
        protected var cloneIndex:int;
        protected var listeners:Array;

        public function Watcher(_arg_1:Array=null)
        {
            this.listeners = _arg_1;
        }

        public function removeChildren(_arg_1:int):void
        {
            children.splice(_arg_1);
        }

        public function updateChildren():void
        {
            var _local_1:int;
            var _local_2:int;
            if (children)
            {
                _local_1 = children.length;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    children[_local_2].updateParent(this);
                    _local_2++;
                };
            };
        }

        protected function shallowClone():Watcher
        {
            return (new Watcher());
        }

        protected function wrapUpdate(wrappedFunction:Function):void
        {
            try
            {
                wrappedFunction.apply(this);
            }
            catch(itemPendingError:ItemPendingError)
            {
                value = null;
            }
            catch(rangeError:RangeError)
            {
                value = null;
            }
            catch(error:Error)
            {
                if ((((((!(error.errorID == 1006)) && (!(error.errorID == 1009))) && (!(error.errorID == 1010))) && (!(error.errorID == 1055))) && (!(error.errorID == 1069))))
                {
                    throw (error);
                };
            };
        }

        private function valueChanged(_arg_1:Object):Boolean
        {
            if (((_arg_1 == null) && (value == null)))
            {
                return (false);
            };
            var _local_2:* = typeof(value);
            if (_local_2 == "string")
            {
                if (((_arg_1 == null) && (value == "")))
                {
                    return (false);
                };
                return (!(_arg_1 == value));
            };
            if (_local_2 == "number")
            {
                if (((_arg_1 == null) && (value == 0)))
                {
                    return (false);
                };
                return (!(_arg_1 == value));
            };
            if (_local_2 == "boolean")
            {
                if (((_arg_1 == null) && (value == false)))
                {
                    return (false);
                };
                return (!(_arg_1 == value));
            };
            return (true);
        }

        public function notifyListeners(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            if (listeners)
            {
                _local_2 = listeners.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    listeners[_local_3].watcherFired(_arg_1, cloneIndex);
                    _local_3++;
                };
            };
        }

        protected function deepClone(_arg_1:int):Watcher
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:Watcher;
            var _local_2:Watcher = shallowClone();
            _local_2.cloneIndex = _arg_1;
            if (listeners)
            {
                _local_2.listeners = listeners.concat();
            };
            if (children)
            {
                _local_3 = children.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_5 = children[_local_4].deepClone(_arg_1);
                    _local_2.addChild(_local_5);
                    _local_4++;
                };
            };
            return (_local_2);
        }

        public function updateParent(_arg_1:Object):void
        {
        }

        public function addChild(_arg_1:Watcher):void
        {
            if (!children)
            {
                children = [_arg_1];
            }
            else
            {
                children.push(_arg_1);
            };
            _arg_1.updateParent(this);
        }


    }
}//package mx.binding

