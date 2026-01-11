package r1.deval.rt
{
   internal class CondExpr implements IExpr
   {
      private var truePart:IExpr;
      
      private var cond:IExpr;
      
      private var falsePart:IExpr;
      
      public function CondExpr(param1:IExpr, param2:IExpr, param3:IExpr)
      {
         super();
         this.cond = param1;
         this.truePart = param2;
         this.falsePart = param3;
      }
      
      public function getNumber() : Number
      {
         return cond.getBoolean() ? truePart.getNumber() : falsePart.getNumber();
      }
      
      public function getString() : String
      {
         return cond.getBoolean() ? truePart.getString() : falsePart.getString();
      }
      
      public function getBoolean() : Boolean
      {
         return cond.getBoolean() ? truePart.getBoolean() : falsePart.getBoolean();
      }
      
      public function getAny() : Object
      {
         return cond.getBoolean() ? truePart.getAny() : falsePart.getAny();
      }
   }
}

