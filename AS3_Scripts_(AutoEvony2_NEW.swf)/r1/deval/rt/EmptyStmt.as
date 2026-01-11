// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.EmptyStmt

package r1.deval.rt
{
    import r1.deval.rt.IStmt;

    internal class EmptyStmt implements IStmt 
    {

        protected var _lineno:int;

        public function EmptyStmt(_arg_1:int)
        {
            _lineno = _arg_1;
        }

        public function exec():void
        {
        }

        public function get lineno():int
        {
            return (_lineno);
        }


    }
}//package r1.deval.rt

