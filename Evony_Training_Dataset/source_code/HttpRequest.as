// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.HttpRequest

package org.httpclient
{
    import com.adobe.net.URIEncodingBitmap;
    import mx.utils.Base64Encoder;
    import flash.utils.ByteArray;
    import com.adobe.net.URI;
    import flash.net.URLVariables;
    import flash.errors.IllegalOperationError;
    import org.httpclient.http.multipart.Multipart;

    public class HttpRequest 
    {

        public static const kUriPathEscapeBitmap:URIEncodingBitmap = new URIEncodingBitmap(" %?#");
        public static const kUriQueryEscapeBitmap:URIEncodingBitmap = new URIEncodingBitmap(" {}%=|:?#/@+\\");

        protected var _method:String;
        protected var _body:*;
        protected var _header:HttpHeader;

        public function HttpRequest(_arg_1:String, _arg_2:HttpHeader=null, _arg_3:*=null)
        {
            this._method = _arg_1;
            this._body = _arg_3;
            this._header = _arg_2;
            if (!this._header)
            {
                this._header = new HttpHeader();
            };
            this.loadDefaultHeaders();
        }

        public function getHeader(_arg_1:URI, _arg_2:URI=null, _arg_3:String=null):ByteArray
        {
            var _local_9:String;
            var _local_11:RegExp;
            var _local_12:String;
            var _local_13:String;
            var _local_14:Base64Encoder;
            _arg_1.forceEscape();
            var _local_4:ByteArray = new ByteArray();
            var _local_5:String = _arg_1.path;
            if (!_local_5)
            {
                _local_5 = "/";
            }
            else
            {
                _local_5 = URI.fastEscapeChars(_local_5, kUriPathEscapeBitmap);
            };
            var _local_6:Object = _arg_1.getQueryByMap();
            var _local_7:URLVariables;
            var _local_8:Array = new Array();
            for (_local_9 in _local_6)
            {
                _local_7 = new URLVariables();
                _local_7[_local_9] = _local_6[_local_9];
                _local_8.push(_local_7.toString());
            };
            if (_local_8.length > 0)
            {
                _local_5 = (_local_5 + ("?" + _local_8.join("&")));
            };
            var _local_10:String = _arg_1.authority;
            if (_arg_1.port)
            {
                _local_10 = (_local_10 + (":" + _arg_1.port));
            };
            if (!_arg_3)
            {
                _arg_3 = "1.1";
            };
            if (_arg_2)
            {
                _local_11 = /\?.*$/;
                _local_12 = (_arg_1.toString().replace(_local_11, "?") + _local_8.join("&"));
                _local_4.writeUTFBytes((((((this.method + " ") + _local_12) + " HTTP/") + _arg_3) + "\r\n"));
            }
            else
            {
                _local_4.writeUTFBytes((((((this.method + " ") + _local_5) + " HTTP/") + _arg_3) + "\r\n"));
            };
            _local_4.writeUTFBytes((("Host: " + _local_10) + "\r\n"));
            if ((((_arg_2) && (_arg_2.username)) && (_arg_2.password)))
            {
                _local_13 = ((_arg_2.username + ":") + _arg_2.password);
                _local_14 = new Base64Encoder();
                _local_14.encode(_local_13);
                this.addHeader("Proxy-Authorization", ("Basic " + _local_14.toString()));
            };
            if (!this.header.isEmpty)
            {
                _local_4.writeUTFBytes(this.header.content);
            };
            _local_4.writeUTFBytes("\r\n");
            _local_4.position = 0;
            return (_local_4);
        }

        public function set body(_arg_1:*):void
        {
            this._body = _arg_1;
            this._header.replace("Content-Length", this._body.length);
        }

        public function set contentType(_arg_1:String):void
        {
            this._header.replace("Content-Type", _arg_1);
        }

        public function get method():String
        {
            return (this._method);
        }

        public function get body():*
        {
            return (this._body);
        }

        public function setMultipart(_arg_1:Multipart):void
        {
            if (this._body)
            {
                throw (new IllegalOperationError("The body content was already set; You can only set using either setMultipart, setFormData or body="));
            };
            this._header.replace("Content-Type", ("multipart/form-data; boundary=" + Multipart.BOUNDARY));
            this._header.replace("Content-Length", String(_arg_1.length));
            this._body = _arg_1;
        }

        protected function loadDefaultHeaders():void
        {
            this.addHeader("Connection", "close");
        }

        public function get header():HttpHeader
        {
            return (this._header);
        }

        public function addHeader(_arg_1:String, _arg_2:String):void
        {
            this._header.add(_arg_1, _arg_2);
        }

        public function setFormData(params:Array, sep:String="&"):void
        {
            if (this._body)
            {
                throw (new IllegalOperationError("The body content was already set; You can only set using either setMultipart, setFormData or body="));
            };
            this._header.replace("Content-Type", "application/x-www-form-urlencoded");
            this._body = new ByteArray();
            this._body.writeUTFBytes(params.map(function (_arg_1:*, _arg_2:int, _arg_3:Array):String
            {
                return ((encodeURIComponent(_arg_1.name) + "=") + encodeURIComponent(_arg_1.value));
            }).join(sep));
            this._body.position = 0;
            this._header.replace("Content-Length", this._body.length);
        }

        public function get hasRequestBody():Boolean
        {
            throw (new Error("Must use a request subclass with this method defined."));
        }

        public function toString():String
        {
            return ((((("method: " + this._method) + ", header: ") + this._header) + ", body: ") + this._body);
        }

        public function get hasResponseBody():Boolean
        {
            throw (new Error("Must use a request subclass with this method defined."));
        }


    }
}//package org.httpclient

