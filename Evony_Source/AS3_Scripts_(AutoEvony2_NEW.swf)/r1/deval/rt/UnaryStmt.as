// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.UnaryStmt

package r1.deval.rt
{
    import r1.deval.parser.ParserConsts;

    public class UnaryStmt extends EmptyStmt 
    {

        private var value:IExpr;
        private var type:int;

        public function UnaryStmt(_arg_1:int, _arg_2:*, _arg_3:int)
        {
            super(_arg_3);
            this.type = _arg_1;
            this.value = _arg_2;
        }

        override public function exec():void
        {
            var _local_1:Object;
            var _local_2:Namespace;
            switch (type)
            {
                case ParserConsts.DEFAULT_NS:
                    if (value != null)
                    {
                        _local_2 = (value.getAny() as Namespace);
                        default xml namespace = _local_2;
                    };
                    return;
                case ParserConsts.THROW:
                    _local_1 = value.getAny();
                    if ((_local_1 is Error))
                    {
                        throw (_local_1 as Error);
                    };
                    throw (new Error(_local_1.toString()));
            };
        }


    }
}//package r1.deval.rt

