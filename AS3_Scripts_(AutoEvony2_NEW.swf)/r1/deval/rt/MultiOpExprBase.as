// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.MultiOpExprBase

package r1.deval.rt
{
    import r1.deval.rt.IExpr;

    internal class MultiOpExprBase extends MultiExprBase 
    {

        internal var ops:Array;

        public function MultiOpExprBase(_arg_1:IExpr, _arg_2:Array, _arg_3:Array)
        {
            super(_arg_1, _arg_2);
            this.ops = _arg_3;
        }

        override public function getBoolean():Boolean
        {
            return (Boolean(getNumber()));
        }

        override public function getAny():Object
        {
            return (getNumber());
        }

        override public function getString():String
        {
            return (getNumber().toString());
        }

        override public function addOperand(_arg_1:*, _arg_2:*=null):void
        {
            var _local_4:int;
            var _local_5:Array;
            super.addOperand(_arg_1);
            var _local_3:int = ((_arg_1 is Array) ? (_arg_1 as Array).length : 1);
            if ((_arg_2 is Array))
            {
                _local_5 = (_arg_2 as Array);
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    ops.push(_local_5[_local_4]);
                    _local_4++;
                };
            }
            else
            {
                _local_4 = _local_3;
                while (_local_4 > 0)
                {
                    ops.push(_arg_2);
                    _local_4--;
                };
            };
        }


    }
}//package r1.deval.rt

