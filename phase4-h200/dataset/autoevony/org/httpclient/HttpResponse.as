// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.HttpResponse

package org.httpclient
{
    public class HttpResponse 
    {

        private var _message:String;
        private var _header:HttpHeader;
        private var _version:String;
        private var _code:String;

        public function HttpResponse(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:HttpHeader)
        {
            this._version = _arg_1;
            this._code = _arg_2;
            this._message = _arg_3;
            this._header = _arg_4;
        }

        public function get isSuccess():Boolean
        {
            return (!(this._code.search(/\A2\d\d/) == -1));
        }

        public function get isInformation():Boolean
        {
            return (!(this._code.search(/\A1\d\d/) == -1));
        }

        public function toString():String
        {
            return (((((((("version: " + this._version) + ", code: ") + this._code) + ", message: ") + this._message) + "\nheader:\n") + this._header) + "\n--\n");
        }

        public function get contentLength():Number
        {
            var _local_1:String = this._header.getValue("Content-Length");
            if (!_local_1)
            {
                return (-1);
            };
            return (parseInt(_local_1));
        }

        public function get message():String
        {
            return (this._message);
        }

        public function get isRedirection():Boolean
        {
            return (!(this._code.search(/\A3\d\d/) == -1));
        }

        public function get isServerError():Boolean
        {
            return (!(this._code.search(/\A5\d\d/) == -1));
        }

        public function get isClientError():Boolean
        {
            return (!(this._code.search(/\A4\d\d/) == -1));
        }

        public function get code():String
        {
            return (this._code);
        }

        public function get isChunked():Boolean
        {
            return (this._header.contains("Transfer-Encoding", "Chunked"));
        }

        public function get header():HttpHeader
        {
            return (this._header);
        }

        public function get version():String
        {
            return (this._version);
        }


    }
}//package org.httpclient

