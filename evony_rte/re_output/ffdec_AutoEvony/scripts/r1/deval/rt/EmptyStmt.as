package r1.deval.rt
{
   internal class EmptyStmt implements IStmt
   {
      
      protected var _lineno:int;
      
      public function EmptyStmt(param1:int)
      {
         super();
         _lineno = param1;
      }
      
      public function exec() : void
      {
      }
      
      public function get lineno() : int
      {
         return _lineno;
      }
   }
}

