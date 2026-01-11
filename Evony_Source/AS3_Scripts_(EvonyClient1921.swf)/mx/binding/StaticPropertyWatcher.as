// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.StaticPropertyWatcher

package mx.binding
{
    import flash.events.IEventDispatcher;
    import mx.core.EventPriority;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class StaticPropertyWatcher extends Watcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var propertyGetter:Function;
        private var parentObj:Class;
        protected var events:Object;
        private var _propertyName:String;

        public function StaticPropertyWatcher(_arg_1:String, _arg_2:Object, _arg_3:Array, _arg_4:Function=null)
        {
            super(_arg_3);
            _propertyName = _arg_1;
            this.events = _arg_2;
            this.propertyGetter = _arg_4;
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
            var _local_3:IEventDispatcher;
            parentObj = Class(_arg_1);
            if (parentObj["staticEventDispatcher"] != null)
            {
                for (_local_2 in events)
                {
                    if (_local_2 != "__NoChangeEvent__")
                    {
                        _local_3 = parentObj["staticEventDispatcher"];
                        _local_3.addEventListener(_local_2, eventHandler, false, EventPriority.BINDING, true);
                    };
                };
            };
            wrapUpdate(updateProperty);
        }

        private function updateProperty():void
        {
            if (parentObj)
            {
                if (propertyGetter != null)
                {
                    value = propertyGetter.apply(parentObj, [_propertyName]);
                }
                else
                {
                    value = parentObj[_propertyName];
                };
            }
            else
            {
                value = null;
            };
            updateChildren();
        }

        override protected function shallowClone():Watcher
        {
            return (new StaticPropertyWatcher(_propertyName, events, listeners, propertyGetter));
        }

        private function traceInfo():String
        {
            return (((((("StaticPropertyWatcher(" + parentObj) + ".") + _propertyName) + "): events = [") + eventNamesToString()) + "]");
        }

        public function get propertyName():String
        {
            return (_propertyName);
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

