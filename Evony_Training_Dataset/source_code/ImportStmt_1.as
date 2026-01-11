package r1.deval.rt
{
   import flash.system.ApplicationDomain;
   
   public class ImportStmt extends EmptyStmt
   {
      private var classes:Array;
      
      public function ImportStmt(param1:Array, param2:int)
      {
         super(param2);
         this.classes = param1;
      }
      
      override public function exec() : void
      {
         var cls:String = null;
         var x:* = undefined;
         var ad:ApplicationDomain = ApplicationDomain.currentDomain;
         for each(cls in classes)
         {
            try
            {
               x = ad.getDefinition(cls);
               if(!(x != null && x is Class))
               {
                  throw new RTError("msg.rt.no.class");
               }
            }
            catch(e:Error)
            {
               throw new RTError("msg.rt.no.class");
            }
            Env.importClass(x as Class,cls);
         }
      }
   }
}

