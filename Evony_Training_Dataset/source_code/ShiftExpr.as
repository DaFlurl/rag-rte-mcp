// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ShiftExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;
    import r1.deval.parser.ParserConsts;

    internal class ShiftExpr extends MultiOpExprBase 
    {

        public function ShiftExpr(_arg_1:IExpr, _arg_2:*, _arg_3:*)
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
                    case ParserConsts.LSH:
                        _local_1 = (_local_1 << _local_3);
                        break;
                    case ParserConsts.RSH:
                        _local_1 = (_local_1 >> _local_3);
                        break;
                    case ParserConsts.URSH:
                        _local_1 = (_local_1 >>> _local_3);
                };
                _local_2++;
            };
            return (_local_1);
        }


    }
}//package r1.deval.rt

