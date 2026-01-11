// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.IsInAsExpr

package r1.deval.rt
{
    import r1.deval.parser.ParserConsts;
    import flash.system.ApplicationDomain;

    public class IsInAsExpr extends UnaryExpr 
    {

        private static const IS_OBJECT:int = -1;
        private static const IS_ARRAY:int = -2;
        private static const IS_NUMBER:int = -3;
        private static const IS_INT:int = -4;
        private static const IS_UINT:int = -5;
        private static const IS_STRING:int = -6;
        private static const IS_DATE:int = -7;
        private static const IS_BOOLEAN:int = -8;

        private var type:*;
        private var id:int;

        public function IsInAsExpr(_arg_1:IExpr, _arg_2:*, _arg_3:int)
        {
            var _local_4:String;
            super(_arg_1, _arg_3);
            this.type = (_arg_2 as IExpr);
            id = IS_OBJECT;
            if ((_arg_2 is String))
            {
                _local_4 = String(_arg_2).toLowerCase();
                if (_local_4 == "int")
                {
                    id = IS_INT;
                }
                else
                {
                    if (_local_4 == "uint")
                    {
                        id = IS_UINT;
                    }
                    else
                    {
                        if (_local_4 == "number")
                        {
                            id = IS_NUMBER;
                        }
                        else
                        {
                            if (_local_4 == "string")
                            {
                                id = IS_STRING;
                            }
                            else
                            {
                                if (_local_4 == "boolean")
                                {
                                    id = IS_BOOLEAN;
                                }
                                else
                                {
                                    if (_local_4 == "date")
                                    {
                                        id = IS_DATE;
                                    }
                                    else
                                    {
                                        if (_local_4 == "array")
                                        {
                                            id = IS_ARRAY;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        override public function getNumber():Number
        {
            return (Number(getBoolean()));
        }

        public function getInParts():Array
        {
            if (op != ParserConsts.IN)
            {
                return (null);
            };
            return ([base, type]);
        }

        override public function getString():String
        {
            return (getBoolean().toString());
        }

        override public function getBoolean():Boolean
        {
            var clzName:String;
            var clz:Class;
            var x:Object;
            if (op == ParserConsts.AS)
            {
                return (Boolean(getAny()));
            };
            var o:Object = base.getAny();
            if (op == ParserConsts.IN)
            {
                try
                {
                    return (o in (type as IExpr).getAny());
                }
                catch(e:Error)
                {
                    return (false);
                };
            };
            if (id == IS_OBJECT)
            {
                clz = null;
                if ((type is String))
                {
                    clzName = (type as String);
                }
                else
                {
                    try
                    {
                        x = (type as IExpr).getAny();
                        if ((x is Class))
                        {
                            clz = (x as Class);
                        }
                        else
                        {
                            clzName = x.toString();
                        };
                    }
                    catch(e:Error)
                    {
                        return (false);
                    };
                };
                if (clz == null)
                {
                    try
                    {
                        clz = (ApplicationDomain.currentDomain.getDefinition(clzName) as Class);
                    }
                    catch(e:Error)
                    {
                        return (false);
                    };
                };
                if (op == ParserConsts.IS)
                {
                    return (o is clz);
                };
                return (o instanceof clz);
            };
            switch (id)
            {
                case IS_INT:
                    return (o is int);
                case IS_UINT:
                    return (o is uint);
                case IS_NUMBER:
                    return (o is Number);
                case IS_BOOLEAN:
                    return (o is Boolean);
                case IS_STRING:
                    return (o is String);
                case IS_DATE:
                    return (o is Date);
                case IS_ARRAY:
                    return (o is Array);
            };
            return (false);
        }

        override public function getAny():Object
        {
            var o:Object;
            var clzName:String;
            var x:Object;
            if (op != ParserConsts.AS)
            {
                return (getBoolean());
            };
            o = base.getAny();
            switch (id)
            {
                case IS_INT:
                    return (o as int);
                case IS_UINT:
                    return (o as uint);
                case IS_NUMBER:
                    return (o as Number);
                case IS_BOOLEAN:
                    return (o as Boolean);
                case IS_STRING:
                    return (o as String);
                case IS_DATE:
                    return (o as Date);
                case IS_ARRAY:
                    return (o as Array);
            };
            var clz:Class;
            if ((type is String))
            {
                clzName = (type as String);
            }
            else
            {
                try
                {
                    x = (type as IExpr).getAny();
                    if ((x is Class))
                    {
                        clz = (x as Class);
                    }
                    else
                    {
                        clzName = x.toString();
                    };
                }
                catch(e:Error)
                {
                    return (o);
                };
            };
            if (clz == null)
            {
                try
                {
                    clz = (ApplicationDomain.currentDomain.getDefinition(clzName) as Class);
                }
                catch(e:Error)
                {
                    return (o);
                };
            };
            return (o as clz);
        }


    }
}//package r1.deval.rt

