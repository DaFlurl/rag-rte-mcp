// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.UnaryExpr

package r1.deval.rt
{
    import r1.deval.parser.ParserConsts;

    public class UnaryExpr implements IExpr 
    {

        internal var op:int;
        internal var base:IExpr;

        public function UnaryExpr(_arg_1:IExpr, _arg_2:int)
        {
            this.base = _arg_1;
            this.op = _arg_2;
        }

        private function incDec(_arg_1:Boolean, _arg_2:Boolean):Number
        {
            var _local_3:ISettable = (base as ISettable);
            if (_local_3 == null)
            {
                throw (new RTError("msg.rt.incdec.on.const"));
            };
            var _local_4:Number = base.getNumber();
            _local_3.setValue((_local_4 + ((_arg_1) ? 1 : -1)));
            return ((_arg_2) ? _local_4 : (_local_4 + ((_arg_1) ? 1 : -1)));
        }

        public function getNumber():Number
        {
            switch (op)
            {
                case ParserConsts.NOT:
                case ParserConsts.DELETE:
                    return (Number(getBoolean()));
                case ParserConsts.BITNOT:
                    return (~(base.getNumber()));
                case ParserConsts.SUB:
                    return (-(base.getNumber()));
                case ParserConsts.INC:
                case ParserConsts.DEC:
                    return (incDec((op == ParserConsts.INC), false));
                case ParserConsts.POSTFIX_INC:
                case ParserConsts.POSTFIX_DEC:
                    return (incDec((op == ParserConsts.POSTFIX_INC), true));
                default:
                    return (0);
            };
        }

        public function getString():String
        {
            switch (op)
            {
                case ParserConsts.NOT:
                case ParserConsts.DELETE:
                    return (getBoolean().toString());
                case ParserConsts.ESCXMLATTR:
                    return (('"' + base.getString()) + '"');
                case ParserConsts.ESCXMLTEXT:
                    return (XML(getAny()).toXMLString());
                case ParserConsts.TYPEOF:
                    return (typeof(base.getAny()));
                case ParserConsts.VOID:
                    return ("");
                default:
                    return (getNumber().toString());
            };
        }

        public function getAny():Object
        {
            var _local_1:String;
            switch (op)
            {
                case ParserConsts.NOT:
                case ParserConsts.DELETE:
                    return (getBoolean());
                case ParserConsts.TYPEOF:
                case ParserConsts.ESCXMLATTR:
                    return (getString());
                case ParserConsts.ESCXMLTEXT:
                    _local_1 = base.getString();
                    if (Util.beginsWith(_local_1, "<>"))
                    {
                        return (new XMLList(_local_1));
                    };
                    return (new XML(_local_1));
                case ParserConsts.VOID:
                    return (null);
                default:
                    return (getNumber());
            };
        }

        public function getBoolean():Boolean
        {
            switch (op)
            {
                case ParserConsts.NOT:
                    return (!(base.getBoolean()));
                case ParserConsts.ESCXMLATTR:
                case ParserConsts.ESCXMLTEXT:
                    return (false);
                case ParserConsts.DELETE:
                    try
                    {
                        return ((base as ISettable).delProp());
                    }
                    catch(e:Error)
                    {
                    };
                    return (false);
                default:
                    return (Boolean(getNumber()));
            };
        }


    }
}//package r1.deval.rt

