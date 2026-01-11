// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ObjectInit

package r1.deval.rt
{
    import r1.deval.rt.IExpr;

    internal class ObjectInit extends ObjectExprBase 
    {

        internal var elems:Array;
        internal var objectInit:Object;

        public function ObjectInit(_arg_1:Object, _arg_2:Array)
        {
            objectInit = _arg_1;
            this.elems = _arg_2;
        }

        override public function getAny():Object
        {
            var _local_1:*;
            var _local_3:String;
            var _local_4:Array;
            if ((objectInit is Array))
            {
                _local_4 = [];
                for each (_local_1 in (objectInit as Array))
                {
                    if ((_local_1 is IExpr))
                    {
                        _local_1 = (_local_1 as IExpr).getAny();
                    };
                    _local_4.push(_local_1);
                };
                return (_local_4);
            };
            var _local_2:Object = {};
            for each (_local_3 in elems)
            {
                _local_1 = objectInit[_local_3];
                if ((_local_1 is IExpr))
                {
                    _local_1 = (_local_1 as IExpr).getAny();
                };
                _local_2[_local_3] = _local_1;
            };
            return (_local_2);
        }


    }
}//package r1.deval.rt

