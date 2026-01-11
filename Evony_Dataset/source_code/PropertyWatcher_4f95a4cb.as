// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.PropertyWatcher

package mx.binding
{
    import flash.events.IEventDispatcher;
    import mx.utils.DescribeTypeCache;
    import flash.utils.getQualifiedClassName;
    import mx.core.EventPriority;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PropertyWatcher extends Watcher 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        protected var propertyGetter:Function;
        private var parentObj:Object;
        protected var events:Object;
        private var useRTTI:Boolean;
        private var _propertyName:String;

        public function PropertyWatcher(_arg_1:String, _arg_2:Object, _arg_3:Array, _arg_4:Function=null)
        {
            super(_arg_3);
            _propertyName = _arg_1;
            this.events = _arg_2;
            this.propertyGetter = _arg_4;
            useRTTI = (!(_arg_2));
        }

        private function eventNamesToString():String
        {
            var _local_2:String;
            var _local_1:* = " ";
            for (_local_2 in events)
            {
                _local_1 = (_local_1 + (_local_2 + " "));
            };
            return (_local_1);
        }

        override public function updateParent(_arg_1:Object):void
        {
            var _local_2:String;
            var _local_3:BindabilityInfo;
            if (((parentObj) && (parentObj is IEventDispatcher)))
            {
                for (_local_2 in events)
                {
                    parentObj.removeEventListener(_local_2, eventHandler);
                };
            };
            if ((_arg_1 is Watcher))
            {
                parentObj = _arg_1.value;
            }
            else
            {
                parentObj = _arg_1;
            };
            if (parentObj)
            {
                if (useRTTI)
                {
                    events = {};
                    if ((parentObj is IEventDispatcher))
                    {
                        _local_3 = DescribeTypeCache.describeType(parentObj).bindabilityInfo;
                        events = _local_3.getChangeEvents(_propertyName);
                        if (objectIsEmpty(events))
                        {
                            trace((((("warning: unable to bind to property '" + _propertyName) + "' on class '") + getQualifiedClassName(parentObj)) + "'"));
                        }
                        else
                        {
                            addParentEventListeners();
                        };
                    }
                    else
                    {
                        trace((((("warning: unable to bind to property '" + _propertyName) + "' on class '") + getQualifiedClassName(parentObj)) + "' (class is not an IEventDispatcher)"));
                    };
                }
                else
                {
                    if ((parentObj is IEventDispatcher))
                    {
                        addParentEventListeners();
                    };
                };
            };
            wrapUpdate(updateProperty);
        }

        private function objectIsEmpty(_arg_1:Object):Boolean
        {
            var _local_2:String;
            for (_local_2 in _arg_1)
            {
                return (false);
            };
            return (true);
        }

        override protected function shallowClone():Watcher
        {
            return (new PropertyWatcher(_propertyName, events, listeners, propertyGetter));
        }

        private function traceInfo():String
        {
            return (((((("Watcher(" + getQualifiedClassName(parentObj)) + ".") + _propertyName) + "): events = [") + eventNamesToString()) + ((useRTTI) ? "] (RTTI)" : "]"));
        }

        public function get propertyName():String
        {
            return (_propertyName);
        }

        private function addParentEventListeners():void
        {
            var _local_1:String;
            for (_local_1 in events)
            {
                if (_local_1 != "__NoChangeEvent__")
                {
                    parentObj.addEventListener(_local_1, eventHandler, false, EventPriority.BINDING, true);
                };
            };
        }

        private function updateProperty():void
        {
            if (parentObj)
            {
                if (_propertyName == "this")
                {
                    value = parentObj;
                }
                else
                {
                    if (propertyGetter != null)
                    {
                        value = propertyGetter.apply(parentObj, [_propertyName]);
                    }
                    else
                    {
                        value = parentObj[_propertyName];
                    };
                };
            }
            else
            {
                value = null;
            };
            updateChildren();
        }

        public function eventHandler(_arg_1:Event):void
        {
            var _local_2:Object;
            if ((_arg_1 is PropertyChangeEvent))
            {
                _local_2 = PropertyChangeEvent(_arg_1).property;
                if (_local_2 != _propertyName)
                {
                    return;
                };
            };
            wrapUpdate(updateProperty);
            notifyListeners(events[_arg_1.type]);
        }


    }
}//package mx.binding

