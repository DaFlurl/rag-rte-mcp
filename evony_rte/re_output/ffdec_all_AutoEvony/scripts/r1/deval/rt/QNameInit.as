package r1.deval.rt
{
   internal class QNameInit extends ObjectExprBase
   {
      
      internal var ns:IExpr;
      
      internal var name:IExpr;
      
      public function QNameInit(param1:IExpr, param2:IExpr)
      {
         super();
         this.ns = param1;
         this.name = param2;
      }
      
      override public function getAny() : Object
      {
         return new QName(ns.getAny() as Namespace,name.getString());
      }
   }
}

