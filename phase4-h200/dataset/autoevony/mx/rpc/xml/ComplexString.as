// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.xml.ComplexString

package mx.rpc.xml
{
    import mx.rpc.xml.SimpleXMLDecoder;

    internal dynamic class ComplexString 
    {

        public var value:String;

        public function ComplexString(_arg_1:String)
        {
            value = _arg_1;
        }

        public function valueOf():Object
        {
            return (SimpleXMLDecoder.simpleType(value));
        }

        public function toString():String
        {
            return (value);
        }


    }
}//package mx.rpc.xml

