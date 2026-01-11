// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.D

package r1.deval
{
    import r1.deval.rt.Env;
    import r1.deval.rt.FunctionDef;
    import r1.deval.parser.BaseParser;
    import r1.deval.rt.Block;

    public class D 
    {

        public static const OVERRIDE_GLOBAL_IGNORE:int = 0;
        public static const OVERRIDE_GLOBAL_OVERRIDE:int = 1;
        public static const OVERRIDE_GLOBAL_WARN:int = 2;
        public static const OVERRIDE_GLOBAL_ERROR:int = 3;
        private static var _useCache:Boolean = true;
        private static var _programLimit:int = 0x0200;
        private static var _cache:Object = {};


        public static function display(_arg_1:String):void
        {
            Env.display(_arg_1);
        }

        public static function setOutput(_arg_1:Function):void
        {
            Env.outputFunction = _arg_1;
        }

        public static function collectUserFunctions(_arg_1:Object):Object
        {
            var _local_3:String;
            var _local_4:Object;
            var _local_2:Object = {};
            for each (_local_3 in _arg_1)
            {
                _local_4 = _arg_1[_local_4];
                if ((_local_4 is FunctionDef))
                {
                    _local_2[_local_3] = _local_4;
                };
            };
            return (_local_2);
        }

        public static function useCache(_arg_1:Boolean=true, _arg_2:int=-1):void
        {
            _useCache = _arg_1;
            if (_arg_2 > 0)
            {
                _programLimit = _arg_2;
            };
        }

        public static function setTextControlOutput(host:Object, prop:String="text", limit:int=0x0800):void
        {
            setOutput(function (_arg_1:String):void
            {
                var _local_2:String = host[prop];
                if (_local_2 == "")
                {
                    _local_2 = _arg_1;
                }
                else
                {
                    if (_local_2.length >= limit)
                    {
                        _local_2 = _local_2.substring((_local_2.length - limit));
                    };
                    _local_2 = ((_local_2 + "\n") + _arg_1);
                };
                host[prop] = _local_2;
            });
        }

        public static function parseProgram(_arg_1:String):Object
        {
            return (new BaseParser().parseProgram(_arg_1));
        }

        public static function importClass(_arg_1:Class):void
        {
            Env.importClass(_arg_1);
        }

        public static function eval(_arg_1:*, _arg_2:Object=null, _arg_3:Object=null):Object
        {
            var _local_4:String;
            var _local_5:FunctionDef;
            if (((_arg_1 == null) || (_arg_1 == "")))
            {
                return (null);
            };
            if ((_arg_1 is String))
            {
                _local_4 = String(_arg_1);
                if (((_useCache) && (_local_4.length <= _programLimit)))
                {
                    _arg_1 = _cache[_local_4];
                    if (_arg_1 == null)
                    {
                        _cache[_local_4] = (_arg_1 = parseProgram(_local_4));
                    };
                }
                else
                {
                    _arg_1 = parseProgram(_local_4);
                };
            };
            if ((_arg_1 is Array))
            {
                if (_arg_2 == null)
                {
                    _arg_2 = {};
                };
                for each (_local_5 in _arg_1[1])
                {
                    _arg_2[_local_5.name] = _local_5;
                };
                _arg_1 = _arg_1[0];
            };
            return (Env.run((_arg_1 as Block), _arg_3, _arg_2));
        }

        public static function importFunction(_arg_1:String, _arg_2:Function):void
        {
            Env.importFunction(_arg_1, _arg_2);
        }

        public static function evalToNumber(_arg_1:*, _arg_2:Object=null, _arg_3:Object=null):Number
        {
            return (Number(eval(_arg_1, _arg_2, _arg_3)));
        }

        public static function setOverrideGlobalOption(_arg_1:int):void
        {
            Env.setOverrideGlobalOption(_arg_1);
        }

        public static function parseFunctions(_arg_1:String):Object
        {
            var _local_4:FunctionDef;
            var _local_2:Object = {};
            var _local_3:Object = parseProgram(_arg_1);
            if ((_local_3 is Array))
            {
                for each (_local_4 in _local_3[1])
                {
                    _local_2[_local_4.name] = _local_4;
                };
            };
            return (_local_2);
        }

        public static function evalToString(_arg_1:*, _arg_2:Object=null, _arg_3:Object=null):String
        {
            return (eval(_arg_1, _arg_2, _arg_3) as String);
        }

        public static function evalToBoolean(_arg_1:*, _arg_2:Object=null, _arg_3:Object=null):Boolean
        {
            return (Boolean(eval(_arg_1, _arg_2, _arg_3)));
        }

        public static function evalToInt(_arg_1:*, _arg_2:Object=null, _arg_3:Object=null):int
        {
            return (int(eval(_arg_1, _arg_2, _arg_3)));
        }

        public static function importStaticMethods(_arg_1:Class, _arg_2:*=null):void
        {
            Env.importStaticMethods(_arg_1, _arg_2);
        }


    }
}//package r1.deval

