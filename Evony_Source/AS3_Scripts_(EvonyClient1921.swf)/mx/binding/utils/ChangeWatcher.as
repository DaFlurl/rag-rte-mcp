// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.utils.ChangeWatcher

package mx.binding.utils
{
    import flash.events.IEventDispatcher;
    import mx.utils.DescribeTypeCache;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.core.EventPriority;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ChangeWatcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var commitOnly:Boolean;
        private var host:Object;
        private var handler:Function;
        private var getter:Function;
        private var name:String;
        private var events:Object;
        private var next:ChangeWatcher;

        public function ChangeWatcher(_arg_1:Object, _arg_2:Function, _arg_3:Boolean=false, _arg_4:ChangeWatcher=null)
        {
            host = null;
            name = ((_arg_1 is String) ? (_arg_1 as String) : _arg_1.name);
            getter = ((_arg_1 is String) ? null : _arg_1.getter);
            this.handler = _arg_2;
            this.commitOnly = _arg_3;
            this.next = _arg_4;
            events = {};
        }

        private static function isEmpty(_arg_1:Object):Boolean
        {
            var _local_2:String;
            for (_local_2 in _arg_1)
            {
                return (false);
            };
            return (true);
        }

        public static function getEvents(_arg_1:Object, _arg_2:String, _arg_3:Boolean=false):Object
        {
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:String;
            if ((_arg_1 is IEventDispatcher))
            {
                _local_4 = DescribeTypeCache.describeType(_arg_1).bindabilityInfo.getChangeEvents(_arg_2);
                if (_arg_3)
                {
                    _local_5 = {};
                    for (_local_6 in _local_4)
                    {
                        if (_local_4[_local_6])
                        {
                            _local_5[_local_6] = true;
                        };
                    };
                    return (_local_5);
                };
                return (_local_4);
            };
            return ({});
        }

        public static function watch(_arg_1:Object, _arg_2:Object, _arg_3:Function, _arg_4:Boolean=false):ChangeWatcher
        {
            var _local_5:ChangeWatcher;
            if (!(_arg_2 is Array))
            {
                _arg_2 = [_arg_2];
            };
            if (_arg_2.length > 0)
            {
                _local_5 = new ChangeWatcher(_arg_2[0], _arg_3, _arg_4, watch(null, _arg_2.slice(1), _arg_3, _arg_4));
                _local_5.reset(_arg_1);
                return (_local_5);
            };
            return (null);
        }

        public static function canWatch(_arg_1:Object, _arg_2:String, _arg_3:Boolean=false):Boolean
        {
            return (!(isEmpty(getEvents(_arg_1, _arg_2, _arg_3))));
        }


        private function getHostPropertyValue():Object
        {
            return ((host == null) ? null : ((getter != null) ? getter(host) : host[name]));
        }

        public function isWatching():Boolean
        {
            return ((!(isEmpty(events))) && ((next == null) || (next.isWatching())));
        }

        public function unwatch():void
        {
            reset(null);
        }

        private function wrapHandler(_arg_1:Event):void
        {
            if (next)
            {
                next.reset(getHostPropertyValue());
            };
            if ((_arg_1 is PropertyChangeEvent))
            {
                if ((_arg_1 as PropertyChangeEvent).property == name)
                {
                    handler((_arg_1 as PropertyChangeEvent));
                };
            }
            else
            {
                handler(_arg_1);
            };
        }

        public function setHandler(_arg_1:Function):void
        {
            this.handler = _arg_1;
            if (next)
            {
                next.setHandler(_arg_1);
            };
        }

        public function getValue():Object
        {
            return ((host == null) ? null : ((next == null) ? getHostPropertyValue() : next.getValue()));
        }

        public function reset(_arg_1:Object):void
        {
            var _local_2:String;
            if (host != null)
            {
                for (_local_2 in events)
                {
                    host.removeEventListener(_local_2, wrapHandler);
                };
                events = {};
            };
            host = _arg_1;
            if (host != null)
            {
                events = getEvents(host, name, commitOnly);
                for (_local_2 in events)
                {
                    host.addEventListener(_local_2, wrapHandler, false, EventPriority.BINDING, false);
                };
            };
            if (next)
            {
                next.reset(getHostPropertyValue());
            };
        }


    }
}//package mx.binding.utils

