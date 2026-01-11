// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.CondExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;

    internal class CondExpr implements IExpr 
    {

        private var truePart:IExpr;
        private var cond:IExpr;
        private var falsePart:IExpr;

        public function CondExpr(_arg_1:IExpr, _arg_2:IExpr, _arg_3:IExpr)
        {
            this.cond = _arg_1;
            this.truePart = _arg_2;
            this.falsePart = _arg_3;
        }

        public function getNumber():Number
        {
            return ((cond.getBoolean()) ? truePart.getNumber() : falsePart.getNumber());
        }

        public function getString():String
        {
            return ((cond.getBoolean()) ? truePart.getString() : falsePart.getString());
        }

        public function getBoolean():Boolean
        {
            return ((cond.getBoolean()) ? truePart.getBoolean() : falsePart.getBoolean());
        }

        public function getAny():Object
        {
            return ((cond.getBoolean()) ? truePart.getAny() : falsePart.getAny());
        }


    }
}//package r1.deval.rt

