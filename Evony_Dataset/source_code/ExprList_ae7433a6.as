// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ExprList

package r1.deval.rt
{
    public class ExprList implements IExpr 
    {

        internal var exprs:Array = [];

        public function ExprList(_arg_1:IExpr, _arg_2:IExpr)
        {
            if (_arg_1 != null)
            {
                exprs.push(_arg_1);
            };
            if (_arg_2 != null)
            {
                exprs.push(_arg_2);
            };
        }

        public function add(_arg_1:IExpr):void
        {
            exprs.push(_arg_1);
        }

        public function getNumber():Number
        {
            return (Number(getAny()));
        }

        public function reduce():IExpr
        {
            if (exprs.length == 1)
            {
                return (exprs[0] as IExpr);
            };
            return (this);
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

        public function getBoolean():Boolean
        {
            return (Boolean(getAny()));
        }

        public function getAny():Object
        {
            var _local_1:int;
            while (_local_1 < (exprs.length - 1))
            {
                (exprs[_local_1] as IExpr).getAny();
                _local_1++;
            };
            return ((exprs[(exprs.length - 1)] as IExpr).getAny());
        }


    }
}//package r1.deval.rt

