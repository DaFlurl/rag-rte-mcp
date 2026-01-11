// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.CallExpr

package r1.deval.rt
{
    public class CallExpr extends ObjectExprBase 
    {

        private var newOp:Boolean;
        private var expr:IExpr;
        private var params:Array = [];

        public function CallExpr(_arg_1:Boolean, _arg_2:IExpr)
        {
            this.expr = _arg_2;
            this.newOp = _arg_1;
        }

        private static function newInstance(_arg_1:Class, _arg_2:Array):Object
        {
            switch (_arg_2.length)
            {
                case 0:
                    return (new (_arg_1)());
                case 1:
                    return (new _arg_1(_arg_2[0]));
                case 2:
                    return (new _arg_1(_arg_2[0], _arg_2[1]));
                case 3:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2]));
                case 4:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3]));
                case 5:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4]));
                case 6:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5]));
                case 7:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6]));
                case 8:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7]));
                case 9:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8]));
                case 10:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9]));
                case 11:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10]));
                case 12:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11]));
                case 13:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12]));
                case 14:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12], _arg_2[13]));
                case 15:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12], _arg_2[13], _arg_2[14]));
                case 16:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12], _arg_2[13], _arg_2[14], _arg_2[15]));
                case 17:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12], _arg_2[13], _arg_2[14], _arg_2[15], _arg_2[16]));
                case 18:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12], _arg_2[13], _arg_2[14], _arg_2[15], _arg_2[16], _arg_2[17]));
                case 19:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12], _arg_2[13], _arg_2[14], _arg_2[15], _arg_2[16], _arg_2[17], _arg_2[18]));
                case 20:
                    return (new _arg_1(_arg_2[0], _arg_2[1], _arg_2[2], _arg_2[3], _arg_2[4], _arg_2[5], _arg_2[6], _arg_2[7], _arg_2[8], _arg_2[9], _arg_2[10], _arg_2[11], _arg_2[12], _arg_2[13], _arg_2[14], _arg_2[15], _arg_2[16], _arg_2[17], _arg_2[18], _arg_2[19]));
            };
            throw (new Error("Number of parameters exceeds limit of 20."));
        }


        public function addParam(_arg_1:IExpr):void
        {
            params.push(_arg_1);
        }

        override public function getAny():Object
        {
            var _local_1:*;
            var _local_2:*;
            var _local_4:Accessor;
            var _local_5:Array;
            var _local_3:Array = [];
            for each (_local_2 in params)
            {
                if ((_local_2 is IExpr))
                {
                    _local_2 = (_local_2 as IExpr).getAny();
                };
                _local_3.push(_local_2);
            };
            if (newOp)
            {
                _local_1 = expr.getAny();
                if (!_local_1)
                {
                    throw (new RTError("msg.rt.no.class"));
                };
                if (!(_local_1 is Class))
                {
                    throw (new RTError("msg.rt.not.class"));
                };
                return (newInstance((_local_1 as Class), _local_3));
            };
            if ((expr is Accessor))
            {
                _local_4 = (expr as Accessor);
                _local_5 = [null, null, false];
                _local_4.resolveMethod(_local_5);
                _local_2 = _local_5[0];
                _local_1 = _local_5[1];
                if (_local_5[2])
                {
                    _local_3.unshift(_local_2);
                    _local_2 = null;
                };
            }
            else
            {
                _local_2 = null;
                _local_1 = expr.getAny();
            };
            if (_local_1 != null)
            {
                if ((_local_1 is Function))
                {
                    return ((_local_1 as Function).apply(_local_2, _local_3));
                };
                if ((_local_1 is Class))
                {
                    if (_local_3.length <= 0)
                    {
                        return (null);
                    };
                    return (_local_3[0] as (_local_1 as Class));
                };
                if ((_local_1 is FunctionDef))
                {
                    return ((_local_1 as FunctionDef).run(_local_3));
                };
            };
            throw (new RTError("msg.rt.no.function"));
        }


    }
}//package r1.deval.rt

