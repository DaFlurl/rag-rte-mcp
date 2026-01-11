// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.logging.LogLogger

package mx.logging
{
    import flash.events.EventDispatcher;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class LogLogger extends EventDispatcher implements ILogger 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _category:String;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function LogLogger(_arg_1:String)
        {
            _category = _arg_1;
        }

        public function log(_arg_1:int, _arg_2:String, ... _args):void
        {
            var _local_4:String;
            var _local_5:int;
            if (_arg_1 < LogEventLevel.DEBUG)
            {
                _local_4 = resourceManager.getString("logging", "levelLimit");
                throw (new ArgumentError(_local_4));
            };
            if (hasEventListener(LogEvent.LOG))
            {
                _local_5 = 0;
                while (_local_5 < _args.length)
                {
                    _arg_2 = _arg_2.replace(new RegExp((("\\{" + _local_5) + "\\}"), "g"), _args[_local_5]);
                    _local_5++;
                };
                dispatchEvent(new LogEvent(_arg_2, _arg_1));
            };
        }

        public function error(_arg_1:String, ... _args):void
        {
            var _local_3:int;
            if (hasEventListener(LogEvent.LOG))
            {
                _local_3 = 0;
                while (_local_3 < _args.length)
                {
                    _arg_1 = _arg_1.replace(new RegExp((("\\{" + _local_3) + "\\}"), "g"), _args[_local_3]);
                    _local_3++;
                };
                dispatchEvent(new LogEvent(_arg_1, LogEventLevel.ERROR));
            };
        }

        public function warn(_arg_1:String, ... _args):void
        {
            var _local_3:int;
            if (hasEventListener(LogEvent.LOG))
            {
                _local_3 = 0;
                while (_local_3 < _args.length)
                {
                    _arg_1 = _arg_1.replace(new RegExp((("\\{" + _local_3) + "\\}"), "g"), _args[_local_3]);
                    _local_3++;
                };
                dispatchEvent(new LogEvent(_arg_1, LogEventLevel.WARN));
            };
        }

        public function get category():String
        {
            return (_category);
        }

        public function info(_arg_1:String, ... _args):void
        {
            var _local_3:int;
            if (hasEventListener(LogEvent.LOG))
            {
                _local_3 = 0;
                while (_local_3 < _args.length)
                {
                    _arg_1 = _arg_1.replace(new RegExp((("\\{" + _local_3) + "\\}"), "g"), _args[_local_3]);
                    _local_3++;
                };
                dispatchEvent(new LogEvent(_arg_1, LogEventLevel.INFO));
            };
        }

        public function debug(_arg_1:String, ... _args):void
        {
            var _local_3:int;
            if (hasEventListener(LogEvent.LOG))
            {
                _local_3 = 0;
                while (_local_3 < _args.length)
                {
                    _arg_1 = _arg_1.replace(new RegExp((("\\{" + _local_3) + "\\}"), "g"), _args[_local_3]);
                    _local_3++;
                };
                dispatchEvent(new LogEvent(_arg_1, LogEventLevel.DEBUG));
            };
        }

        public function fatal(_arg_1:String, ... _args):void
        {
            var _local_3:int;
            if (hasEventListener(LogEvent.LOG))
            {
                _local_3 = 0;
                while (_local_3 < _args.length)
                {
                    _arg_1 = _arg_1.replace(new RegExp((("\\{" + _local_3) + "\\}"), "g"), _args[_local_3]);
                    _local_3++;
                };
                dispatchEvent(new LogEvent(_arg_1, LogEventLevel.FATAL));
            };
        }


    }
}//package mx.logging

