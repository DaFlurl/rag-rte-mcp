package r1.deval.rt
{
   internal class ThisExpr extends ObjectExprBase
   {
      internal static const INSTANCE:ThisExpr = new ThisExpr();
      
      public function ThisExpr()
      {
         super();
      }
      
      override public function getAny() : Object
      {
         return Env.getThis();
      }
   }
}

