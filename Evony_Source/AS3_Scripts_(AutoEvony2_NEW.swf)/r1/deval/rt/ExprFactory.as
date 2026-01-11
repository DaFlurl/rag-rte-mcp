// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ExprFactory

package r1.deval.rt
{
    import r1.deval.parser.ParserConsts;

    public class ExprFactory extends ParserConsts 
    {


        public function createVarExpr(_arg_1:String, _arg_2:IExpr=null, _arg_3:IExpr=null):IExpr
        {
            return (createExprList(_arg_3, new VarExpr(_arg_1, _arg_2)));
        }

        public function createXMLAttrExpr(_arg_1:IExpr):IExpr
        {
            return (new UnaryExpr(_arg_1, ESCXMLATTR));
        }

        public function createAndOrExpr(_arg_1:IExpr, _arg_2:*, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean=false):IExpr
        {
            if (((_arg_1 is AndOrExpr) && (AndOrExpr(_arg_1).isA(_arg_3, _arg_4, _arg_5))))
            {
                AndOrExpr(_arg_1).addOperand(_arg_2);
                return (_arg_1);
            };
            return (new AndOrExpr(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
        }

        public function createAccessor(_arg_1:IExpr, _arg_2:*, _arg_3:IExpr=null, _arg_4:Boolean=false, _arg_5:Boolean=false):IExpr
        {
            var _local_6:* = _arg_2;
            if ((_local_6 is Constant))
            {
                _local_6 = (_local_6 as Constant).getAny();
            };
            if ((((_arg_3 == null) && (!(_arg_4))) && (!(_arg_5))))
            {
                return (new Accessor(_arg_1, _local_6));
            };
            return (new XMLAccessor(_arg_1, _local_6, _arg_3, false, _arg_4, _arg_5));
        }

        public function createEqRelExpr(_arg_1:IExpr, _arg_2:IExpr, _arg_3:int):IExpr
        {
            if ((_arg_1 is EqRelExpr))
            {
                EqRelExpr(_arg_1).addOperand(_arg_2, _arg_3);
                return (_arg_1);
            };
            return (new EqRelExpr(_arg_1, [_arg_2], [_arg_3]));
        }

        public function createUnaryExpr(_arg_1:IExpr, _arg_2:int):IExpr
        {
            if (_arg_2 == ADD)
            {
                return (_arg_1);
            };
            if (_arg_2 == SUB)
            {
                if ((_arg_1 is Constant))
                {
                    if (_arg_1 == Constant.ONE)
                    {
                        return (Constant.MINUSONE);
                    };
                    if ((_arg_1.getAny() is Number))
                    {
                        return (new Constant(-(_arg_1.getNumber())));
                    };
                };
            };
            return (new UnaryExpr(_arg_1, _arg_2));
        }

        public function createAssignment(_arg_1:ISettable, _arg_2:IExpr, _arg_3:int, _arg_4:int):IExpr
        {
            return (new Assignment(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function createDotQuery(_arg_1:IExpr, _arg_2:IExpr):IExpr
        {
            return (new XMLAccessor(_arg_1, _arg_2, null, true));
        }

        public function createObjectInit(_arg_1:Object, _arg_2:Boolean=false, _arg_3:Array=null):IExpr
        {
            return ((_arg_2) ? new Constant(_arg_1) : new ObjectInit(_arg_1, _arg_3));
        }

        public function createBitExpr(_arg_1:IExpr, _arg_2:*, _arg_3:int):IExpr
        {
            if (((_arg_1 is BitExpr) && (BitExpr(_arg_1).isA(_arg_3))))
            {
                BitExpr(_arg_1).addOperand(_arg_2);
                return (_arg_1);
            };
            return (new BitExpr(_arg_1, _arg_2, _arg_3));
        }

        public function createMulDivModExpr(_arg_1:IExpr, _arg_2:IExpr, _arg_3:int):IExpr
        {
            if ((_arg_1 is MulDivModExpr))
            {
                MulDivModExpr(_arg_1).addOperand(_arg_2, _arg_3);
                return (_arg_1);
            };
            return (new MulDivModExpr(_arg_1, [_arg_2], [_arg_3]));
        }

        public function literal(_arg_1:Object):IExpr
        {
            if ((_arg_1 is Number))
            {
                if (_arg_1 == 0)
                {
                    return (Constant.ZERO);
                };
                if (_arg_1 == 1)
                {
                    return (Constant.ONE);
                };
                if (_arg_1 == -1)
                {
                    return (Constant.MINUSONE);
                };
            }
            else
            {
                if ((_arg_1 is Boolean))
                {
                    return ((_arg_1 == true) ? Constant.TRUE : Constant.FALSE);
                };
                if (_arg_1 == null)
                {
                    return (Constant.NULL);
                };
                if (_arg_1 == "")
                {
                    return (Constant.EMPTY_STRING);
                };
            };
            return (new Constant(_arg_1));
        }

        public function createQNameInit(_arg_1:IExpr, _arg_2:IExpr):IExpr
        {
            if (((_arg_1 is Constant) && (_arg_2 is Constant)))
            {
                return (new Constant(new QName((_arg_1.getAny() as Namespace), _arg_2.getString())));
            };
            return (new QNameInit(_arg_1, _arg_2));
        }

        public function createIsInAsExpr(_arg_1:IExpr, _arg_2:IExpr, _arg_3:int):IExpr
        {
            return (new IsInAsExpr(_arg_1, _arg_2, _arg_3));
        }

        public function thisExpr():IExpr
        {
            return (ThisExpr.INSTANCE);
        }

        public function createCallExpr(_arg_1:IExpr):CallExpr
        {
            return (new CallExpr(false, _arg_1));
        }

        public function createAddSubExpr(_arg_1:IExpr, _arg_2:IExpr, _arg_3:Boolean=true):IExpr
        {
            if (_arg_1 == null)
            {
                return ((_arg_3) ? _arg_2 : createUnaryExpr(_arg_2, SUB));
            };
            if ((_arg_1 is AddSubExpr))
            {
                AddSubExpr(_arg_1).addOperand(_arg_2, _arg_3);
                return (_arg_1);
            };
            return (new AddSubExpr(_arg_1, [_arg_2], [_arg_3]));
        }

        public function regExp(_arg_1:String, _arg_2:String):IExpr
        {
            return (new Constant(new RegExp(_arg_1, _arg_2)));
        }

        public function createNewExpr(_arg_1:IExpr):CallExpr
        {
            return (new CallExpr(true, _arg_1));
        }

        public function createCondExpr(_arg_1:IExpr, _arg_2:IExpr, _arg_3:IExpr):IExpr
        {
            return (new CondExpr(_arg_1, _arg_2, _arg_3));
        }

        public function createShiftExpr(_arg_1:IExpr, _arg_2:IExpr, _arg_3:int):IExpr
        {
            if ((_arg_1 is ShiftExpr))
            {
                ShiftExpr(_arg_1).addOperand(_arg_2, _arg_3);
                return (_arg_1);
            };
            return (new ShiftExpr(_arg_1, [_arg_2], [_arg_3]));
        }

        public function createXMLLiteralExpr(_arg_1:IExpr, _arg_2:IExpr):IExpr
        {
            return (new UnaryExpr(createAddSubExpr(_arg_1, _arg_2), ESCXMLTEXT));
        }

        public function createExprList(_arg_1:IExpr, _arg_2:IExpr):IExpr
        {
            if (_arg_1 == null)
            {
                return (_arg_2);
            };
            if ((_arg_1 is ExprList))
            {
                ExprList(_arg_1).add(_arg_2);
                return (_arg_1);
            };
            return (new ExprList(_arg_1, _arg_2));
        }


    }
}//package r1.deval.rt

