// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.EqRelExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;
    import r1.deval.parser.ParserConsts;

    internal class EqRelExpr extends MultiOpExprBase 
    {

        public function EqRelExpr(_arg_1:IExpr, _arg_2:*, _arg_3:*)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function getNumber():Number
        {
            return (Number(getBoolean()));
        }

        override public function getString():String
        {
            return (getBoolean().toString());
        }

        override public function getBoolean():Boolean
        {
            var _local_4:int;
            var _local_5:Object;
            var _local_6:Number;
            var _local_7:Number;
            var _local_1:IExpr = first;
            var _local_2:Object = _local_1.getAny();
            var _local_3:int;
            while (_local_3 < rest.length)
            {
                _local_4 = (ops[_local_3] as int);
                _local_5 = (rest[_local_3] as IExpr).getAny();
                if (((_local_2 is Number) || (_local_5 is Number)))
                {
                    _local_6 = Number(_local_2);
                    _local_7 = Number(_local_5);
                    switch (_local_4)
                    {
                        case ParserConsts.EQ:
                        case ParserConsts.SHEQ:
                            if (_local_6 != _local_7)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.NE:
                        case ParserConsts.SHNE:
                            if (_local_6 == _local_7)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.LE:
                            if (_local_6 > _local_7)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.LT:
                            if (_local_6 >= _local_7)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.GE:
                            if (_local_6 < _local_7)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.GT:
                            if (_local_6 <= _local_7)
                            {
                                return (false);
                            };
                            break;
                    };
                }
                else
                {
                    switch (_local_4)
                    {
                        case ParserConsts.EQ:
                            if (_local_2 != _local_5)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.NE:
                            if (_local_2 == _local_5)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.SHEQ:
                            if (_local_2 !== _local_5)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.SHNE:
                            if (_local_2 === _local_5)
                            {
                                return (false);
                            };
                            break;
                        case ParserConsts.LE:
                        case ParserConsts.LT:
                        case ParserConsts.GE:
                        case ParserConsts.GT:
                            return (false);
                    };
                };
                _local_2 = _local_5;
                _local_3++;
            };
            return (true);
        }

        override public function getAny():Object
        {
            return (getBoolean());
        }


    }
}//package r1.deval.rt

