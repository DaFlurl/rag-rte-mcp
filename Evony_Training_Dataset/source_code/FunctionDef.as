// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.FunctionDef

package r1.deval.rt
{
    public class FunctionDef implements IExpr 
    {

        private var head:Block;
        private var params:Array;
        public var name:String;
        private var tail:EndBlock;

        public function FunctionDef(_arg_1:String, _arg_2:Array, _arg_3:Block, _arg_4:EndBlock)
        {
            this.name = ((_arg_1 == null) ? "_anonymous_" : _arg_1);
            this.params = _arg_2;
            this.head = _arg_3;
            this.tail = _arg_4;
        }

        public function optimize():void
        {
            if (head != null)
            {
                head.optimize();
            };
        }

        public function getString():String
        {
            throw (new RTError("msg.rt.eval.function.to.value"));
        }

        public function getBoolean():Boolean
        {
            throw (new RTError("msg.rt.eval.function.to.value"));
        }

        public function run(paramVals:Array):Object
        {
            var paramsLen:int = ((params == null) ? 0 : params.length);
            var len:int = ((paramVals == null) ? 0 : paramVals.length);
            if (len > paramsLen)
            {
                len = paramsLen;
            };
            var context:Object = {};
            var idx:int;
            while (idx < len)
            {
                context[params[idx]] = paramVals[idx];
                idx = (idx + 1);
            };
            try
            {
                Env.pushObject(context);
                Env.setReturnValue(null);
                head.run(tail);
                var _local_3:* = Env.getReturnValue();
                return (_local_3);
            }
            finally
            {
                Env.popObject();
            };
            return (null);
        }

        public function dump(_arg_1:Object):void
        {
            var _local_2:* = (('\n<Function name="' + name) + '" params="');
            var _local_3:int = ((params == null) ? 0 : params.length);
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (_local_4 > 0)
                {
                    _local_2 = (_local_2 + ",");
                };
                _local_2 = (_local_2 + params[_local_4]);
                _local_4++;
            };
            trace((_local_2 + '">'));
            head.dump(_arg_1, 1);
            trace("\n</Function>");
        }

        public function getAny():Object
        {
            return (this);
        }

        public function getNumber():Number
        {
            throw (new RTError("msg.rt.eval.function.to.value"));
        }


    }
}//package r1.deval.rt

