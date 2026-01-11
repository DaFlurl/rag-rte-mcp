// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.MulDivModExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;
    import r1.deval.parser.ParserConsts;

    internal class MulDivModExpr extends MultiOpExprBase 
    {

        public function MulDivModExpr(_arg_1:IExpr, _arg_2:Array, _arg_3:Array)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function getNumber():Number
        {
            var _local_3:Number;
            var _local_1:Number = first.getNumber();
            var _local_2:int;
            while (_local_2 < rest.length)
            {
                _local_3 = (rest[_local_2] as IExpr).getNumber();
                switch (ops[_local_2])
                {
                    case ParserConsts.MUL:
                        _local_1 = (_local_1 * _local_3);
                        break;
                    case ParserConsts.DIV:
                        _local_1 = (_local_1 / _local_3);
                        break;
                    case ParserConsts.MOD:
                        _local_1 = (_local_1 % _local_3);
                };
                _local_2++;
            };
            return (_local_1);
        }


    }
}//package r1.deval.rt

