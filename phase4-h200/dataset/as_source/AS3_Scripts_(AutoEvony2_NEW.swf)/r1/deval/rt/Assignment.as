// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.Assignment

package r1.deval.rt
{
    import r1.deval.rt.IStmt;
    import r1.deval.rt.ISettable;
    import r1.deval.rt.IExpr;
    import r1.deval.rt.Env;
    import r1.deval.parser.ParserConsts;
    import r1.deval.rt.*;

    internal class Assignment extends ObjectExprBase implements IStmt 
    {

        protected var op:int;
        protected var left:ISettable;
        private var _next:IStmt;
        private var _lineno:int;
        protected var right:IExpr;

        public function Assignment(_arg_1:ISettable, _arg_2:IExpr, _arg_3:int, _arg_4:int)
        {
            this.left = _arg_1;
            this.right = _arg_2;
            this.op = _arg_3;
            this._lineno = _arg_4;
        }

        public function set next(_arg_1:IStmt):void
        {
            _next = _arg_1;
        }

        public function exec():void
        {
            Env.setReturnValue(getAny());
        }

        public function get lineno():int
        {
            return (_lineno);
        }

        override public function getAny():Object
        {
            var _local_1:Object;
            var _local_4:Object;
            var _local_5:Boolean;
            var _local_6:Boolean;
            switch (op)
            {
                case ParserConsts.ASSIGN:
                    _local_1 = right.getAny();
                    left.setValue(_local_1);
                    return (_local_1);
                case ParserConsts.ASSIGN_ADD:
                    _local_1 = left.getAny();
                    _local_4 = right.getAny();
                    if ((((_local_1 is XML) || (_local_1 is XMLList)) && ((_local_4 is XML) || (_local_4 is XMLList))))
                    {
                        if ((_local_1 is XML))
                        {
                            _local_1 = (new (XMLList)("") + _local_1);
                        };
                        _local_1 = (_local_1 + _local_4);
                    }
                    else
                    {
                        if (((_local_1 is String) || (_local_4 is String)))
                        {
                            _local_1 = (_local_1.toString() + _local_4.toString());
                        }
                        else
                        {
                            _local_1 = (Number(_local_1) + Number(_local_4));
                        };
                    };
                    left.setValue(_local_1);
                    return (_local_1);
                case ParserConsts.ASSIGN_AND:
                case ParserConsts.ASSIGN_OR:
                    _local_5 = left.getBoolean();
                    _local_6 = right.getBoolean();
                    if (op == ParserConsts.ASSIGN_AND)
                    {
                        _local_5 = ((_local_5) && (_local_6));
                    }
                    else
                    {
                        _local_5 = ((_local_5) || (_local_6));
                    };
                    left.setValue(_local_5);
                    return (_local_5);
            };
            var _local_2:Number = left.getNumber();
            var _local_3:Number = right.getNumber();
            switch (op)
            {
                case ParserConsts.ASSIGN_BITOR:
                    _local_2 = (_local_2 | _local_3);
                    break;
                case ParserConsts.ASSIGN_BITXOR:
                    _local_2 = (_local_2 ^ _local_3);
                    break;
                case ParserConsts.ASSIGN_BITAND:
                    _local_2 = (_local_2 & _local_3);
                    break;
                case ParserConsts.ASSIGN_LSH:
                    _local_2 = (_local_2 << _local_3);
                    break;
                case ParserConsts.ASSIGN_RSH:
                    _local_2 = (_local_2 >> _local_3);
                    break;
                case ParserConsts.ASSIGN_URSH:
                    _local_2 = (_local_2 >>> _local_3);
                    break;
                case ParserConsts.ASSIGN_ADD:
                    _local_2 = (_local_2 + _local_3);
                    break;
                case ParserConsts.ASSIGN_SUB:
                    _local_2 = (_local_2 - _local_3);
                    break;
                case ParserConsts.ASSIGN_MUL:
                    _local_2 = (_local_2 * _local_3);
                    break;
                case ParserConsts.ASSIGN_DIV:
                    _local_2 = (_local_2 / _local_3);
                    break;
                case ParserConsts.ASSIGN_MOD:
                    _local_2 = (_local_2 % _local_3);
                    break;
            };
            left.setValue(_local_2);
            return (_local_2);
        }

        public function get next():IStmt
        {
            return (_next);
        }


    }
}//package r1.deval.rt

