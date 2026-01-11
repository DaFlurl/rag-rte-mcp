// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.Constant

package r1.deval.rt
{
    public class Constant implements IExpr 
    {

        public static const NULL:Constant = new Constant(null);
        public static const TRUE:Constant = new Constant(true);
        public static const FALSE:Constant = new Constant(false);
        public static const ZERO:Constant = new Constant(0);
        public static const ONE:Constant = new Constant(1);
        public static const MINUSONE:Constant = new Constant(-1);
        public static const EMPTY_STRING:Constant = new Constant("");

        internal var value:Object;

        public function Constant(_arg_1:Object)
        {
            this.value = _arg_1;
        }

        public function getString():String
        {
            return ((value == null) ? "null" : value.toString());
        }

        public function getBoolean():Boolean
        {
            return (Boolean(value));
        }

        public function getAny():Object
        {
            return (value);
        }

        public function getNumber():Number
        {
            return ((value == null) ? 0 : Number(value));
        }


    }
}//package r1.deval.rt

