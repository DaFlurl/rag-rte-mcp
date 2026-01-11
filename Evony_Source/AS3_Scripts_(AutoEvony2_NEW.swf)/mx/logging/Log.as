// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.logging.Log

package mx.logging
{
    import mx.resources.IResourceManager;
    import mx.logging.errors.InvalidCategoryError;
    import mx.resources.ResourceManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Log 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var NONE:int = int.MAX_VALUE;//2147483647
        private static var _targetLevel:int = NONE;
        private static var _loggers:Array;
        private static var _targets:Array = [];
        private static var _resourceManager:IResourceManager;


        private static function categoryMatchInFilterList(_arg_1:String, _arg_2:Array):Boolean
        {
            var _local_4:String;
            var _local_3:Boolean;
            var _local_5:int = -1;
            var _local_6:uint;
            while (_local_6 < _arg_2.length)
            {
                _local_4 = _arg_2[_local_6];
                _local_5 = _local_4.indexOf("*");
                if (_local_5 == 0)
                {
                    return (true);
                };
                _local_5 = ((_local_5 < 0) ? _local_5 = _arg_1.length : (_local_5 - 1));
                if (_arg_1.substring(0, _local_5) == _local_4.substring(0, _local_5))
                {
                    return (true);
                };
                _local_6++;
            };
            return (false);
        }

        public static function flush():void
        {
            _loggers = [];
            _targets = [];
            _targetLevel = NONE;
        }

        public static function isDebug():Boolean
        {
            return ((_targetLevel <= LogEventLevel.DEBUG) ? true : false);
        }

        public static function getLogger(_arg_1:String):ILogger
        {
            var _local_3:ILoggingTarget;
            checkCategory(_arg_1);
            if (!_loggers)
            {
                _loggers = [];
            };
            var _local_2:ILogger = _loggers[_arg_1];
            if (_local_2 == null)
            {
                _local_2 = new LogLogger(_arg_1);
                _loggers[_arg_1] = _local_2;
            };
            var _local_4:int;
            while (_local_4 < _targets.length)
            {
                _local_3 = ILoggingTarget(_targets[_local_4]);
                if (categoryMatchInFilterList(_arg_1, _local_3.filters))
                {
                    _local_3.addLogger(_local_2);
                };
                _local_4++;
            };
            return (_local_2);
        }

        public static function isWarn():Boolean
        {
            return ((_targetLevel <= LogEventLevel.WARN) ? true : false);
        }

        public static function addTarget(_arg_1:ILoggingTarget):void
        {
            var _local_2:Array;
            var _local_3:ILogger;
            var _local_4:String;
            var _local_5:String;
            if (_arg_1)
            {
                _local_2 = _arg_1.filters;
                for (_local_4 in _loggers)
                {
                    if (categoryMatchInFilterList(_local_4, _local_2))
                    {
                        _arg_1.addLogger(ILogger(_loggers[_local_4]));
                    };
                };
                _targets.push(_arg_1);
                if (_targetLevel == NONE)
                {
                    _targetLevel = _arg_1.level;
                }
                else
                {
                    if (_arg_1.level < _targetLevel)
                    {
                        _targetLevel = _arg_1.level;
                    };
                };
            }
            else
            {
                _local_5 = resourceManager.getString("logging", "invalidTarget");
                throw (new ArgumentError(_local_5));
            };
        }

        public static function hasIllegalCharacters(_arg_1:String):Boolean
        {
            return ((!((_arg_1.search(/[\[\]\~\$\^\&\\(\)\{\}\+\?\/=`!@#%,:;'"<>\s]/) == -1))));
        }

        private static function checkCategory(_arg_1:String):void
        {
            var _local_2:String;
            if (((_arg_1 == null) || (_arg_1.length == 0)))
            {
                _local_2 = resourceManager.getString("logging", "invalidLen");
                throw (new InvalidCategoryError(_local_2));
            };
            if (((hasIllegalCharacters(_arg_1)) || (!(_arg_1.indexOf("*") == -1))))
            {
                _local_2 = resourceManager.getString("logging", "invalidChars");
                throw (new InvalidCategoryError(_local_2));
            };
        }

        private static function resetTargetLevel():void
        {
            var _local_1:int = NONE;
            var _local_2:int;
            while (_local_2 < _targets.length)
            {
                if (((_local_1 == NONE) || (_targets[_local_2].level < _local_1)))
                {
                    _local_1 = _targets[_local_2].level;
                };
                _local_2++;
            };
            _targetLevel = _local_1;
        }

        public static function removeTarget(_arg_1:ILoggingTarget):void
        {
            var _local_2:Array;
            var _local_3:ILogger;
            var _local_4:String;
            var _local_5:int;
            var _local_6:String;
            if (_arg_1)
            {
                _local_2 = _arg_1.filters;
                for (_local_4 in _loggers)
                {
                    if (categoryMatchInFilterList(_local_4, _local_2))
                    {
                        _arg_1.removeLogger(ILogger(_loggers[_local_4]));
                    };
                };
                _local_5 = 0;
                while (_local_5 < _targets.length)
                {
                    if (_arg_1 == _targets[_local_5])
                    {
                        _targets.splice(_local_5, 1);
                        _local_5--;
                    };
                    _local_5++;
                };
                resetTargetLevel();
            }
            else
            {
                _local_6 = resourceManager.getString("logging", "invalidTarget");
                throw (new ArgumentError(_local_6));
            };
        }

        public static function isInfo():Boolean
        {
            return ((_targetLevel <= LogEventLevel.INFO) ? true : false);
        }

        public static function isFatal():Boolean
        {
            return ((_targetLevel <= LogEventLevel.FATAL) ? true : false);
        }

        public static function isError():Boolean
        {
            return ((_targetLevel <= LogEventLevel.ERROR) ? true : false);
        }

        private static function get resourceManager():IResourceManager
        {
            if (!_resourceManager)
            {
                _resourceManager = ResourceManager.getInstance();
            };
            return (_resourceManager);
        }


    }
}//package mx.logging

