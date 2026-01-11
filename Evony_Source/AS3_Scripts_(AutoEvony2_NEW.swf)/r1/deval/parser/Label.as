// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.parser.Label

package r1.deval.parser
{
    import r1.deval.rt.IExpr;
    import r1.deval.rt.Block;

    public class Label implements IExpr 
    {

        public var name:String;
        public var block:Block;
        public var postfix:Block;
        public var isSwitch:Boolean;

        public function Label(_arg_1:String, _arg_2:Boolean=false)
        {
            this.name = _arg_1;
            this.isSwitch = _arg_2;
        }

        public function getString():String
        {
            throw (new Error("UNIMPLEMENTED"));
        }

        public function getBoolean():Boolean
        {
            throw (new Error("UNIMPLEMENTED"));
        }

        public function getAny():Object
        {
            throw (new Error("UNIMPLEMENTED"));
        }

        public function getNumber():Number
        {
            throw (new Error("UNIMPLEMENTED"));
        }


    }
}//package r1.deval.parser

