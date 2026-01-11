// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.http.multipart.Part

package org.httpclient.http.multipart
{
    import flash.utils.ByteArray;

    public class Part 
    {

        private var _contentDispositionExtras:Array;
        private var _name:String;
        private var _header:ByteArray;
        private var _payload:*;
        private var _contentType:String;
        private var _footer:ByteArray;
        private var _contentTransferEncoding:String;

        public function Part(_arg_1:String, _arg_2:*, _arg_3:String=null, _arg_4:Array=null, _arg_5:String=null)
        {
            var _local_6:ByteArray;
            super();
            if ((_arg_2 is String))
            {
                _local_6 = new ByteArray();
                _local_6.writeUTFBytes(_arg_2);
                _local_6.position = 0;
                _arg_2 = _local_6;
            };
            this._name = _arg_1;
            this._payload = _arg_2;
            this._contentType = _arg_3;
            this._contentDispositionExtras = _arg_4;
            this._contentTransferEncoding = _arg_5;
            this._header = this.header();
            this._footer = this.footer();
        }

        protected function footer():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _local_1.writeUTFBytes("\r\n");
            _local_1.position = 0;
            return (_local_1);
        }

        private function get nextBytes():*
        {
            if (this._header.bytesAvailable > 0)
            {
                return (this._header);
            };
            if (this._payload.bytesAvailable > 0)
            {
                return (this._payload);
            };
            if (this._footer.bytesAvailable > 0)
            {
                return (this._footer);
            };
            throw (Error("Nothing left for part"));
        }

        public function get length():uint
        {
            return ((this._payload.length + this._header.length) + this._footer.length);
        }

        public function get bytesAvailable():uint
        {
            return (this.nextBytes.bytesAvailable);
        }

        public function close():void
        {
            if (!(this._payload is ByteArray))
            {
                this._payload.close();
            };
        }

        public function readBytes(_arg_1:ByteArray, _arg_2:uint=0, _arg_3:uint=0):void
        {
            if (this.nextBytes.bytesAvailable > 0)
            {
                _arg_3 = Math.min(_arg_3, this.nextBytes.bytesAvailable);
                this.nextBytes.readBytes(_arg_1, _arg_2, _arg_3);
            };
        }

        protected function header():ByteArray
        {
            var bytes:ByteArray;
            bytes = new ByteArray();
            bytes.writeUTFBytes((("--" + Multipart.BOUNDARY) + "\r\n"));
            bytes.writeUTFBytes("Content-Disposition: form-data; ");
            if (this._name)
            {
                bytes.writeUTFBytes((('name="' + this._name) + '"'));
            };
            if (this._contentDispositionExtras)
            {
                this._contentDispositionExtras.forEach(function (_arg_1:*, _arg_2:int, _arg_3:Array):void
                {
                    bytes.writeUTFBytes((((("; " + _arg_1.name) + '="') + _arg_1.value) + '"'));
                });
            };
            bytes.writeUTFBytes("\r\n");
            if (this._contentType)
            {
                bytes.writeUTFBytes((("Content-Type: " + this._contentType) + "\r\n"));
            };
            if (this._contentTransferEncoding)
            {
                bytes.writeUTFBytes((("Content-Transfer-Encoding: " + this._contentTransferEncoding) + "\r\n"));
            };
            bytes.writeUTFBytes("\r\n");
            bytes.position = 0;
            return (bytes);
        }


    }
}//package org.httpclient.http.multipart

