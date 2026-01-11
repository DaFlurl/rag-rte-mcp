// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.QNameInit

package r1.deval.rt
{
    import r1.deval.rt.IExpr;

    internal class QNameInit extends ObjectExprBase 
    {

        internal var ns:IExpr;
        internal var name:IExpr;

        public function QNameInit(_arg_1:IExpr, _arg_2:IExpr)
        {
            this.ns = _arg_1;
            this.name = _arg_2;
        }

        override public function getAny():Object
        {
            return (new QName((ns.getAny() as Namespace), name.getString()));
        }


    }
}//package r1.deval.rt

