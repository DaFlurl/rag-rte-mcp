// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.io.HttpRequestBuffer

package org.httpclient.io
{
    import flash.utils.ByteArray;

    public class HttpRequestBuffer 
    {

        private static const BLOCK_SIZE:uint = (16 * 0x0400);//0x4000

        private var _body:*;
        private var _bytesSent:uint = 0;

        public function HttpRequestBuffer(_arg_1:*)
        {
            this._body = _arg_1;
        }

        public function read():ByteArray
        {
            var _local_2:uint;
            var _local_1:ByteArray = new ByteArray();
            if (this._body.bytesAvailable > 0)
            {
                _local_2 = Math.min(BLOCK_SIZE, this._body.bytesAvailable);
                this._body.readBytes(_local_1, 0, _local_2);
                _local_1.position = 0;
                this._bytesSent = (this._bytesSent + _local_1.length);
            };
            return (_local_1);
        }

        public function get bytesSent():uint
        {
            return (this._bytesSent);
        }

        public function get hasData():Boolean
        {
            if (!this._body)
            {
                return (false);
            };
            return (this._bytesSent < this._body.length);
        }


    }
}//package org.httpclient.io

