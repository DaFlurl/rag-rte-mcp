// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ObjectExprBase

package r1.deval.rt
{
    import r1.deval.rt.IExpr;
    import r1.deval.rt.*;

    internal class ObjectExprBase implements IExpr 
    {


        public function getNumber():Number
        {
            return (Number(getAny()));
        }

        public function getBoolean():Boolean
        {
            return (Boolean(getAny()));
        }

        public function getAny():Object
        {
            throw (new Error("UNIMPLEMENTED"));
        }

        public function getString():String
        {
            var _local_1:Object = getAny();
            if (_local_1 == null)
            {
                return (null);
            };
            return (_local_1.toString());
        }


    }
}//package r1.deval.rt

