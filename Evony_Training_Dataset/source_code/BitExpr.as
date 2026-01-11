// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.BitExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;
    import r1.deval.parser.ParserConsts;
    import r1.deval.rt.*;

    internal class BitExpr extends MultiExprBase 
    {

        internal var op:int;

        public function BitExpr(_arg_1:IExpr, _arg_2:*, _arg_3:int)
        {
            super(_arg_1, _arg_2);
            this.op = _arg_3;
        }

        public function isA(_arg_1:int):Boolean
        {
            return (_arg_1 == this.op);
        }

        override public function getBoolean():Boolean
        {
            return (Boolean(getNumber()));
        }

        override public function getAny():Object
        {
            return (getNumber());
        }

        override public function getString():String
        {
            return (getNumber().toString());
        }

        override public function getNumber():Number
        {
            var _local_1:Number = first.getNumber();
            var _local_2:int;
            while (_local_2 < rest.length)
            {
                if (op == ParserConsts.BITAND)
                {
                    _local_1 = (_local_1 & rest[_local_2].getNumber());
                }
                else
                {
                    if (op == ParserConsts.BITOR)
                    {
                        _local_1 = (_local_1 | rest[_local_2].getNumber());
                    }
                    else
                    {
                        _local_1 = (_local_1 ^ rest[_local_2].getNumber());
                    };
                };
                _local_2++;
            };
            return (_local_1);
        }


    }
}//package r1.deval.rt

