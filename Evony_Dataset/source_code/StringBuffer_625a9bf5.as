// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.util.StringBuffer

package r1.deval.util
{
    import flash.utils.ByteArray;

    public class StringBuffer 
    {

        private var buf:ByteArray;

        public function StringBuffer(_arg_1:String=null)
        {
            buf = new ByteArray();
            if (_arg_1 != null)
            {
                append(_arg_1);
            };
        }

        public function substr(_arg_1:int=0, _arg_2:int=2147483647):String
        {
            return (toString().substr(_arg_1, _arg_2));
        }

        public function append(_arg_1:*):StringBuffer
        {
            if (_arg_1 != null)
            {
                buf.writeUTFBytes(_arg_1.toString());
            };
            return (this);
        }

        public function get length():int
        {
            return (buf.length);
        }

        public function substring(_arg_1:int=0, _arg_2:int=2147483647):String
        {
            return (toString().substring(_arg_1, _arg_2));
        }

        public function toString():String
        {
            buf.position = 0;
            return (buf.readUTFBytes(buf.bytesAvailable));
        }

        public function clear():void
        {
            buf.length = 0;
        }

        public function println(_arg_1:*=null):void
        {
            if (_arg_1 != null)
            {
                append(_arg_1);
            };
            append("\n");
        }


    }
}//package r1.deval.util

