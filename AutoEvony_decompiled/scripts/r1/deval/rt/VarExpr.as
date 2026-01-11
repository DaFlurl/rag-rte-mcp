package r1.deval.rt
{
   internal class VarExpr extends ObjectExprBase
   {
      
      internal var init:IExpr;
      
      internal var name:String;
      
      public function VarExpr(param1:String, param2:IExpr = null)
      {
         super();
         this.name = param1;
         this.init = param2;
      }
      
      override public function getAny() : Object
      {
         var _loc1_:Object = init == null ? null : init.getAny();
         Env.setProperty(name,_loc1_);
         return _loc1_;
      }
   }
}

