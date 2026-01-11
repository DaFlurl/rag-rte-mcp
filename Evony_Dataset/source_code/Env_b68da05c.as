// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.Env

package r1.deval.rt
{
    import r1.deval.D;
    import flash.utils.describeType;
    import flash.utils.*;

    public class Env 
    {

        public static var INFINITE_LOOP_LIMIT:Number = 100000;
        private static var stack:Array = [];
        private static var _curEnv:Env;
        private static var _overrideGlobalOption:int = D.OVERRIDE_GLOBAL_OVERRIDE;//1
        private static const _global:Object = {
            "decodeURI":decodeURI,
            "decodeURIComponent":decodeURIComponent,
            "encodeURI":encodeURI,
            "encodeURIComponent":encodeURIComponent,
            "escape":escape,
            "isFinite":isFinite,
            "isNaN":isNaN,
            "isXMLName":isXMLName,
            "parseFloat":parseFloat,
            "parseInt":parseInt,
            "trace":trace,
            "unescape":unescape,
            "printf":printf,
            "importFunction":importFunction,
            "importStaticMethods":importStaticMethods,
            "Array":Array,
            "Boolean":Boolean,
            "int":int,
            "Number":Number,
            "Object":Object,
            "String":String,
            "uint":uint,
            "XML":XML,
            "XMLList":XMLList,
            "Date":Date,
            "Math":Math,
            "RegExp":RegExp,
            "QName":QName,
            "Namespace":Namespace,
            "Error":Error,
            "Class":Class
        };
        public static var outputFunction:Function = trace;
        private static const __errors:Object = {
            "msg.no.paren.parms":"missing ( before function parameters.",
            "msg.misplaced.case":"misplaced case",
            "msg.no.colon.prop":"missing : in object property definition",
            "msg.no.brace.switch":"missing { in switch",
            "msg.bad.continue":"incorrect use of continue",
            "msg.illegal.character":"illegal character",
            "msg.reserved.id":"identifier is a reserved word",
            "msg.bad.break.continue":"incorrect use of break or continue",
            "msg.unreachable.code":"unreachable code",
            "msg.bad.prop":"invalid property id",
            "msg.no.name.after.dot":"missing name after . operator",
            "msg.no.paren":"missing ) in parenthetical",
            "msg.misplaced.right.brace":"misplaced }",
            "msg.unreachable.stmts.in.switch":"unreachable code in switch statement",
            "msg.XML.bad.form":"illegally formed XML syntax",
            "msg.dup.label":"duplicatet label",
            "msg.no.semi.stmt":"missing ; before statement",
            "msg.class.not.supported":"class not supported",
            "msg.no.colon.cond":"missing : in conditional expression",
            "msg.bad.number.base":"incorrect number base",
            "msg.missing.exponent":"missing exponent",
            "msg.case.no.colon":"missing : after case expression",
            "msg.no.name.after.xmlAttr":"missing name after .@",
            "msg.no.brace.prop":"missing } after property list",
            "msg.unterminated.re.lit":"unterminated regular expression literal",
            "msg.invalid.escape":"invalid Unicode escape sequence",
            "msg.unterminated.comment":"unterminated comment",
            "msg.invalid.re.flag":"invalid flag after regular expression",
            "msg.caught.nfe":"number format error",
            "msg.not.assignable":"not assignable",
            "msg.unexpected.eof":"Unexpected end of file",
            "msg.no.brace.body":"missing '{' before function body",
            "msg.undef.label":"undefined labe",
            "msg.function.expr.not.supported":"function expression is not supported",
            "msg.missing.function.name":"missing function name",
            "msg.syntax":"syntax error",
            "msg.unterminated.string.lit":"unterminated string literal",
            "msg.no.bracket.arg":"missing ] after element list",
            "msg.bad.namespace":"not a valid default namespace statement. Syntax is: default xml namespace : EXPRESSION;",
            "msg.no.bracket.index":"missing ] in index expression",
            "msg.no.name.after.coloncolon":"missing name after ::",
            "msg.no.paren.for":"missing ( after for",
            "msg.no.paren.after.parms":"missing ) after formal parameters"
        };

        private var thisObject_getters:Object;
        private var scopeChain:Array;
        private var context:Object;
        private var thisObject_setters:Object;
        private var thisObject:Object;
        private var result:Object;

        public function Env(_arg_1:Object, _arg_2:Object)
        {
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:String;
            super();
            this.thisObject = _arg_1;
            this.context = _arg_2;
            this.scopeChain = [_arg_2];
            thisObject_setters = {};
            thisObject_getters = {};
            if (_arg_1)
            {
                this.scopeChain.push(_arg_1);
                if (_arg_1.prototype != null)
                {
                    this.scopeChain.push(_arg_1.prototype);
                };
                _local_3 = describeType(_arg_1);
                for each (_local_4 in _local_3.accessor)
                {
                    _local_5 = _local_4.@access;
                    if (_local_5 == "readwrite")
                    {
                        thisObject_setters[_local_4.@name] = (thisObject_getters[_local_4.@name] = true);
                    }
                    else
                    {
                        if (_local_5 == "readonly")
                        {
                            thisObject_getters[_local_4.@name] = true;
                        }
                        else
                        {
                            if (_local_5 == "writeonly")
                            {
                                thisObject_setters[_local_4.@name] = true;
                            };
                        };
                    };
                };
            }
            else
            {
                thisObject_setters = thisObject_getters;
            };
            this.scopeChain.push(_global);
        }

        public static function getClass(_arg_1:String):Class
        {
            var _local_2:* = _global[_arg_1];
            if (_local_2 == null)
            {
                return (null);
            };
            if ((_local_2 is Class))
            {
                return (_local_2 as Class);
            };
            if ((_local_2 is Array))
            {
                _local_2 = (_local_2 as Array)[0];
                if ((_local_2 is Class))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function getProperty(_arg_1:*):Object
        {
            return (_curEnv.internal::getProperty(_arg_1));
        }

        public static function isInDocQuery():Boolean
        {
            var _local_1:* = _curEnv.scopeChain[0];
            return ((_local_1 is XML) || (_local_1 is XMLList));
        }

        public static function reportWarning(... _args):void
        {
            outputFunction(("[D:warn ] " + getMessage.apply(null, _args)));
        }

        public static function display(_arg_1:String):void
        {
            outputFunction(_arg_1);
        }

        public static function run(prgm:Block, thisObj:Object=null, context:Object=null):Object
        {
            var env:Env = new Env(thisObj, ((context != null) ? context : {}));
            if (prgm)
            {
                try
                {
                    pushEnv(env);
                    prgm.run();
                    var _local_5:* = env.returnValue;
                    return (_local_5);
                }
                finally
                {
                    popEnv();
                };
            };
            return (null);
        }

        public static function importClass(_arg_1:Class, _arg_2:String=null):void
        {
            if (_arg_2 == null)
            {
                _arg_2 = describeType(_arg_1).@name;
            };
            var _local_3:Array = _arg_2.split(/\./g);
            _arg_2 = _local_3[(_local_3.length - 1)];
            importGlobal(_arg_2, _arg_1);
        }

        public static function getThis():Object
        {
            return (_curEnv.thisObject);
        }

        public static function setProperty(_arg_1:*, _arg_2:Object):void
        {
            _curEnv.internal::setProperty(_arg_1, _arg_2);
        }

        public static function printf(... _args):void
        {
            display(getMessageAsIs.apply(null, _args));
        }

        private static function popEnv():void
        {
            stack.pop();
            if (stack.length > 0)
            {
                _curEnv = stack[(stack.length - 1)];
            }
            else
            {
                _curEnv = null;
            };
        }

        public static function importFunction(_arg_1:String, _arg_2:Function):void
        {
            importGlobal(_arg_1, _arg_2);
        }

        public static function setReturnValue(_arg_1:Object):void
        {
            _curEnv.returnValue = _arg_1;
        }

        public static function getMessage(... _args):String
        {
            if (_args.length > 0)
            {
                _args[0] = idToMessage(_args[0]);
            };
            return (getMessageAsIs.apply(null, _args));
        }

        public static function setOverrideGlobalOption(_arg_1:int):void
        {
            _overrideGlobalOption = _arg_1;
        }

        private static function importGlobal(_arg_1:String, _arg_2:*):void
        {
            if (_overrideGlobalOption != D.OVERRIDE_GLOBAL_OVERRIDE)
            {
                if (_global[_arg_1])
                {
                    switch (_overrideGlobalOption)
                    {
                        case D.OVERRIDE_GLOBAL_WARN:
                            reportWarning("msg.override.global.name", _arg_1);
                            break;
                        case D.OVERRIDE_GLOBAL_ERROR:
                            throw (new RTError("msg.override.global.name", _arg_1));
                    };
                };
            };
            _global[_arg_1] = _arg_2;
        }

        public static function getReturnValue():Object
        {
            return (_curEnv.returnValue);
        }

        public static function getMessageAsIs(... _args):String
        {
            switch (_args.length)
            {
                case 0:
                    return ("");
                case 1:
                    return (String(_args[0]));
            };
            return (Util.substitute.apply(null, _args));
        }

        public static function popObject():*
        {
            return (_curEnv.internal::popObject());
        }

        private static function idToMessage(_arg_1:String):String
        {
            var _local_2:String = (__errors[_arg_1] as String);
            return ((_local_2 == null) ? _arg_1 : _local_2);
        }

        private static function pushEnv(_arg_1:Env):void
        {
            stack.push((_curEnv = _arg_1));
        }

        public static function reportError(... _args):void
        {
            outputFunction(("[D:error] " + getMessage.apply(null, _args)));
        }

        public static function debug(... _args):void
        {
            outputFunction(("[D:debug] " + getMessage.apply(null, _args)));
        }

        public static function pushObject(_arg_1:*):void
        {
            _curEnv.internal::pushObject(_arg_1);
        }

        public static function peekObject():*
        {
            return (_curEnv.scopeChain[0]);
        }

        public static function importStaticMethods(_arg_1:Class, _arg_2:*=null):void
        {
            var _local_4:XML;
            var _local_5:String;
            var _local_3:XML = describeType(_arg_1);
            for each (_local_4 in _local_3.method)
            {
                _local_5 = _local_4.@name;
                if (_arg_2)
                {
                    if ((_arg_2 is RegExp))
                    {
                        if (!_local_5.match((_arg_2 as RegExp)))
                        {
                            _local_5 = null;
                        };
                    }
                    else
                    {
                        if ((_arg_2 is Array))
                        {
                            if ((_arg_2 as Array).indexOf(_local_5) < 0)
                            {
                                _local_5 = null;
                            };
                        }
                        else
                        {
                            if (_local_5 != _arg_2)
                            {
                                _local_5 = null;
                            };
                        };
                    };
                };
                if (_local_5)
                {
                    importFunction(_local_5, _arg_1[_local_5]);
                };
            };
        }


        internal function set returnValue(_arg_1:Object):void
        {
            result = _arg_1;
        }

        internal function get returnValue():Object
        {
            return (result);
        }

        internal function getProperty(_arg_1:*):Object
        {
            var _local_2:*;
            for each (_local_2 in scopeChain)
            {
                if (_local_2.hasOwnProperty(_arg_1))
                {
                    return (_local_2[_arg_1]);
                };
            };
            if (((!(thisObject == null)) && (thisObject_getters[_arg_1])))
            {
                return (thisObject[_arg_1]);
            };
            return (null);
        }

        internal function popObject():*
        {
            return (scopeChain.shift());
        }

        internal function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_3:*;
            for each (_local_3 in scopeChain)
            {
                if (_local_3.hasOwnProperty(_arg_1))
                {
                    _local_3[_arg_1] = _arg_2;
                    return;
                };
            };
            if (((!(thisObject == null)) && (thisObject_setters[_arg_1])))
            {
                thisObject[_arg_1] = _arg_2;
            }
            else
            {
                context[_arg_1] = _arg_2;
            };
        }

        internal function pushObject(_arg_1:*):void
        {
            scopeChain.unshift(_arg_1);
        }


    }
}//package r1.deval.rt

