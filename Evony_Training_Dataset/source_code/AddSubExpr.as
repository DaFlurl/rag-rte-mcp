// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.AddSubExpr

package r1.deval.rt
{
    import r1.deval.rt.IExpr;
    import r1.deval.rt.*;

    internal class AddSubExpr extends MultiOpExprBase 
    {

        public function AddSubExpr(_arg_1:IExpr, _arg_2:Array, _arg_3:Array)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function getNumber():Number
        {
            return (Number(getAny()));
        }

        override public function getString():String
        {
            return (getAny().toString());
        }

        override public function getBoolean():Boolean
        {
            return (Boolean(getAny()));
        }

        override public function getAny():Object
        {
            var _local_3:Number;
            var _local_4:Object;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Array;
            var _local_8:String;
            var _local_9:XMLList;
            var _local_1:Boolean = true;
            var _local_2:int = (ops.length - 1);
            while (_local_2 >= 0)
            {
                if (!ops[_local_2])
                {
                    _local_1 = false;
                    break;
                };
                _local_2--;
            };
            if (_local_1)
            {
                _local_4 = first.getAny();
                _local_5 = ((_local_4 is Number) ? 1 : 0);
                _local_6 = ((_local_4 is XML) ? 1 : 0);
                _local_7 = [_local_4];
                _local_2 = 0;
                while (_local_2 < rest.length)
                {
                    _local_4 = (rest[_local_2] as IExpr).getAny();
                    if ((_local_4 is Number))
                    {
                        _local_5++;
                    }
                    else
                    {
                        if (((_local_4 is XML) || (_local_4 is XMLList)))
                        {
                            _local_6++;
                        };
                    };
                    _local_7.push(_local_4);
                    _local_2++;
                };
                if (_local_6 == (rest.length + 1))
                {
                    _local_9 = new (XMLList)("");
                    for each (_local_4 in _local_7)
                    {
                        _local_9 = (_local_9 + _local_4);
                    };
                    return (_local_9);
                };
                if (_local_5 == (rest.length + 1))
                {
                    _local_3 = 0;
                    for each (_local_4 in _local_7)
                    {
                        _local_3 = (_local_3 + Number(_local_4));
                    };
                    return (_local_3);
                };
                _local_8 = "";
                for each (_local_4 in _local_7)
                {
                    _local_8 = (_local_8 + _local_4);
                };
                return (_local_8);
            };
            _local_3 = first.getNumber();
            _local_2 = 0;
            while (_local_2 < rest.length)
            {
                if (ops[_local_2])
                {
                    _local_3 = (_local_3 + rest[_local_2].getNumber());
                }
                else
                {
                    _local_3 = (_local_3 - rest[_local_2].getNumber());
                };
                _local_2++;
            };
            return (_local_3);
        }


    }
}//package r1.deval.rt

