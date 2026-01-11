// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.VarExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;
    import r1.deval.rt.Env;

    internal class VarExpr extends ObjectExprBase 
    {

        internal var init:IExpr;
        internal var name:String;

        public function VarExpr(_arg_1:String, _arg_2:IExpr=null)
        {
            this.name = _arg_1;
            this.init = _arg_2;
        }

        override public function getAny():Object
        {
            var _local_1:Object = ((init == null) ? null : init.getAny());
            Env.setProperty(name, _local_1);
            return (_local_1);
        }


    }
}//package r1.deval.rt

