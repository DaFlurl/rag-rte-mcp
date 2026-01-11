// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ImportStmt

package r1.deval.rt
{
    import flash.system.ApplicationDomain;

    public class ImportStmt extends EmptyStmt 
    {

        private var classes:Array;

        public function ImportStmt(_arg_1:Array, _arg_2:int)
        {
            super(_arg_2);
            this.classes = _arg_1;
        }

        override public function exec():void
        {
            var cls:String;
            var x:* = undefined;
            var ad:ApplicationDomain = ApplicationDomain.currentDomain;
            for each (cls in classes)
            {
                try
                {
                    x = ad.getDefinition(cls);
                    if (((!(x == null)) && (x is Class)))
                    {
                        Env.importClass((x as Class), cls);
                    }
                    else
                    {
                        throw (new RTError("msg.rt.no.class"));
                    };
                }
                catch(e:Error)
                {
                    throw (new RTError("msg.rt.no.class"));
                };
            };
        }


    }
}//package r1.deval.rt

