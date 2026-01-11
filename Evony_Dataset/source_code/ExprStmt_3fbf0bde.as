// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ExprStmt

package r1.deval.rt
{
    public class ExprStmt extends EmptyStmt 
    {

        internal var _expr:IExpr;

        public function ExprStmt(_arg_1:IExpr, _arg_2:int)
        {
            super(_arg_2);
            this._expr = _arg_1;
        }

        override public function exec():void
        {
            Env.setReturnValue(_expr.getAny());
        }

        public function get expr():IExpr
        {
            return (this._expr);
        }

        public function toString():String
        {
            return (String(_expr));
        }


    }
}//package r1.deval.rt

