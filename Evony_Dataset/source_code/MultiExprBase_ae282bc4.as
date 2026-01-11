// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.MultiExprBase

package r1.deval.rt
{
    import r1.deval.rt.IExpr;

    internal class MultiExprBase implements IExpr 
    {

        internal var first:IExpr;
        internal var rest:Array;

        public function MultiExprBase(_arg_1:IExpr, _arg_2:*)
        {
            this.first = _arg_1;
            this.rest = ((_arg_2 is Array) ? (_arg_2 as Array) : [_arg_2]);
        }

        public function getNumber():Number
        {
            throw (new Error("UNIMPLEMENTED"));
        }

        public function getString():String
        {
            throw (new Error("UNIMPLEMENTED"));
        }

        public function addOperand(_arg_1:*, _arg_2:*=null):void
        {
            var _local_3:IExpr;
            if ((_arg_1 is IExpr))
            {
                rest.push(_arg_1);
            }
            else
            {
                if ((_arg_1 is Array))
                {
                    for each (_local_3 in (_arg_1 as Array))
                    {
                        rest.push(_local_3);
                    };
                };
            };
        }

        public function getBoolean():Boolean
        {
            throw (new Error("UNIMPLEMENTED"));
        }

        public function getAny():Object
        {
            throw (new Error("UNIMPLEMENTED"));
        }


    }
}//package r1.deval.rt

