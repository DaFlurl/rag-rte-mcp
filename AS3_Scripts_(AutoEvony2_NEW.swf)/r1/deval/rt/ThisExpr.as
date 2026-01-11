// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ThisExpr

package r1.deval.rt
{
    import r1.deval.rt.Env;

    internal class ThisExpr extends ObjectExprBase 
    {

        internal static const INSTANCE:ThisExpr = new (ThisExpr)();


        override public function getAny():Object
        {
            return (Env.getThis());
        }


    }
}//package r1.deval.rt

