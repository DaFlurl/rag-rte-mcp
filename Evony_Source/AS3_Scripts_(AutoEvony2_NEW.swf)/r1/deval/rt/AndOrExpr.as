// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.AndOrExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;

    internal class AndOrExpr extends MultiExprBase 
    {

        private var op:Boolean;
        private var isNot:Boolean;
        private var isXor:Boolean;

        public function AndOrExpr(_arg_1:IExpr, _arg_2:*, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean)
        {
            super(_arg_1, _arg_2);
            this.op = _arg_3;
            this.isNot = _arg_4;
            this.isXor = _arg_5;
        }

        override public function getString():String
        {
            return (getBoolean().toString());
        }

        override public function getBoolean():Boolean
        {
            var _local_1:int;
            var _local_2:Boolean;
            var _local_5:int;
            var _local_6:int;
            var _local_3:int = rest.length;
            var _local_4:Boolean = first.getBoolean();
            if (isXor)
            {
                _local_5 = ((_local_4) ? 1 : 0);
                _local_6 = ((_local_4) ? 0 : 1);
                _local_1 = 0;
                while (_local_1 < _local_3)
                {
                    if (IExpr(rest[_local_1]).getBoolean())
                    {
                        _local_5++;
                    }
                    else
                    {
                        _local_6++;
                    };
                    _local_1++;
                };
                return ((!(_local_5 == ++_local_3)) && (!(_local_6 == _local_3)));
            };
            _local_1 = 0;
            while (_local_1 < _local_3)
            {
                _local_2 = IExpr(rest[_local_1]).getBoolean();
                if (isXor)
                {
                    _local_5 = (_local_5 + ((_local_2) ? 1 : 0));
                }
                else
                {
                    if (op)
                    {
                        _local_4 = ((_local_4) && (_local_2));
                    }
                    else
                    {
                        _local_4 = ((_local_4) || (_local_2));
                    };
                };
                _local_1++;
            };
            return ((isNot) ? (!(_local_4)) : _local_4);
        }

        override public function getAny():Object
        {
            return (getBoolean());
        }

        public function isA(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):Boolean
        {
            if (_arg_3)
            {
                return (this.isXor);
            };
            return ((_arg_1 == this.op) && (_arg_2 == this.isNot));
        }

        override public function getNumber():Number
        {
            return (Number(getBoolean()));
        }


    }
}//package r1.deval.rt

