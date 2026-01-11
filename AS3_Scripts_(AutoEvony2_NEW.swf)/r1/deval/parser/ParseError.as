// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.parser.ParseError

package r1.deval.parser
{
    import r1.deval.rt.Util;

    public class ParseError extends Error 
    {

        public static const codeBugMessage:String = "PARSING CODE ERROR";

        private var _lineno:int;
        private var _id:String;

        public function ParseError(_arg_1:String, _arg_2:String, _arg_3:int=0)
        {
            super(processMessage(_arg_1));
            this._id = _arg_2;
            this._lineno = _arg_3;
        }

        public static function processMessage(_arg_1:String):String
        {
            if (!_arg_1)
            {
                return (codeBugMessage);
            };
            if (Util.beginsWith(_arg_1, "msg."))
            {
            };
            return (_arg_1);
        }


        public function get lineno():int
        {
            return (_lineno);
        }

        public function get id():String
        {
            return ((_id) ? _id : "");
        }

        public function toString():String
        {
            var _local_1:String = ("Parse Error: " + super.message);
            if (((_lineno <= 0) && (!(_id))))
            {
                return (_local_1);
            };
            if (_lineno > 0)
            {
                _local_1 = (_local_1 + (" [line:" + _lineno));
            };
            if (id)
            {
                _local_1 = (_local_1 + ("/" + id));
            };
            return (_local_1 + "]");
        }


    }
}//package r1.deval.parser

