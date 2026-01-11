// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.biff.BIFFWriter

package com.as3xls.biff
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class BIFFWriter 
    {

        private var _stream:ByteArray;

        public function BIFFWriter()
        {
            this._stream = new ByteArray();
            this._stream.endian = Endian.LITTLE_ENDIAN;
        }

        public function get stream():ByteArray
        {
            return (this._stream);
        }

        public function writeTag(_arg_1:Record):void
        {
            this._stream.writeShort(_arg_1.type);
            this._stream.writeShort(_arg_1.length);
            _arg_1.data.position = 0;
            _arg_1.data.readBytes(this._stream, this._stream.position, _arg_1.data.bytesAvailable);
            this._stream.position = (this._stream.position + _arg_1.data.length);
        }


    }
}//package com.as3xls.biff

