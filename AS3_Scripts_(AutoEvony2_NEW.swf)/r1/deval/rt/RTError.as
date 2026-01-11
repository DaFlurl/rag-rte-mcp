// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.RTError

package r1.deval.rt
{
    import r1.deval.parser.ParseError;

    public class RTError extends Error 
    {

        private var _param1:String;
        private var _param2:String;
        private var _lineno:int;

        public function RTError(_arg_1:String, _arg_2:String=null, _arg_3:String=null)
        {
            super(ParseError.processMessage(_arg_1));
            _param1 = _arg_2;
            _param2 = _arg_3;
        }

        public function set lineno(_arg_1:int):void
        {
            _lineno = _arg_1;
        }

        public function get lineno():int
        {
            return (_lineno);
        }

        public function toString():String
        {
            var _local_1:String = ("Runtime Error: " + super.message);
            if (_lineno > 0)
            {
                _local_1 = (_local_1 + ((" [line:" + _lineno) + "]"));
            };
            return (_local_1);
        }


    }
}//package r1.deval.rt

