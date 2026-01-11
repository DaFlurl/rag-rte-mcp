// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.HttpSocket

package org.httpclient
{
    import org.httpclient.io.HttpResponseBuffer;
    import flash.events.EventDispatcher;
    import com.adobe.net.URI;
    import org.httpclient.io.HttpRequestBuffer;
    import org.httpclient.events.HttpErrorEvent;
    import flash.events.IOErrorEvent;
    import org.httpclient.events.HttpRequestEvent;
    import org.httpclient.events.HttpDataEvent;
    import flash.utils.ByteArray;
    import flash.net.SecureSocket;
    import flash.net.Socket;
    import flash.events.Event;
    import flash.events.SecurityErrorEvent;
    import flash.events.ProgressEvent;
    import org.httpclient.events.HttpStatusEvent;
    import flash.errors.EOFError;
    import org.httpclient.events.HttpResponseEvent;
    import org.httpclient.events.*;

    public class HttpSocket 
    {

        public static const DEFAULT_HTTP_PORT:uint = 80;
        public static const DEFAULT_HTTPS_PORT:uint = 443;
        public static const HTTP_VERSION:String = "1.1";

        private var _timer:HttpTimer;
        private var _responseBuffer:HttpResponseBuffer;
        private var _closed:Boolean;
        private var _dispatcher:EventDispatcher;
        private var _socket:*;
        private var _onConnect:Function;
        private var _proxy:URI;
        private var _requestBuffer:HttpRequestBuffer;

        public function HttpSocket(_arg_1:EventDispatcher, _arg_2:Number=60000, _arg_3:URI=null)
        {
            this._dispatcher = _arg_1;
            this._timer = new HttpTimer(_arg_2, this.onTimeout);
            this._proxy = _arg_3;
        }

        private function onTimeout(_arg_1:Number):void
        {
            this._dispatcher.dispatchEvent(new HttpErrorEvent(HttpErrorEvent.TIMEOUT_ERROR, false, false, "Timeout", 0));
            this.close();
        }

        private function onIOError(_arg_1:IOErrorEvent):void
        {
            if (this._closed)
            {
                return;
            };
            this.close();
            this._dispatcher.dispatchEvent(_arg_1.clone());
        }

        private function onRequestComplete(_arg_1:HttpRequest, _arg_2:String):void
        {
            this._dispatcher.dispatchEvent(new HttpRequestEvent(_arg_1, _arg_2));
        }

        private function onResponseData(_arg_1:ByteArray):void
        {
            this._dispatcher.dispatchEvent(new HttpDataEvent(_arg_1));
        }

        protected function createSocket(_arg_1:Boolean=false):void
        {
            if (((_arg_1) && (!(this._proxy))))
            {
                this._socket = new SecureSocket();
            }
            else
            {
                this._socket = new Socket();
            };
            this._socket.addEventListener(Event.CONNECT, this.onConnect);
            this._socket.addEventListener(Event.CLOSE, this.onClose);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
        }

        private function onSecurityError(_arg_1:SecurityErrorEvent):void
        {
            if (this._closed)
            {
                return;
            };
            this.close();
            this._dispatcher.dispatchEvent(_arg_1.clone());
        }

        public function request(uri:URI, request:HttpRequest):void
        {
            var onConnect:Function = function (_arg_1:Event):void
            {
                _dispatcher.dispatchEvent(new HttpRequestEvent(internal::request, null, HttpRequestEvent.CONNECT));
                if (((uri.scheme == "https") && (_proxy)))
                {
                    connectProxy(uri, internal::request);
                }
                else
                {
                    sendRequest(uri, internal::request);
                };
            };
            this.connect(uri, onConnect);
        }

        private function onResponseComplete(_arg_1:HttpResponse):void
        {
            Log.debug("Response complete");
            this.close();
            this.onComplete(_arg_1);
        }

        private function onConnect(_arg_1:Event):void
        {
            if (this._onConnect != null)
            {
                this._onConnect(_arg_1);
            };
        }

        protected function sendRequest(_arg_1:URI, _arg_2:HttpRequest):void
        {
            var _local_4:ByteArray;
            this._responseBuffer = new HttpResponseBuffer(_arg_2.hasResponseBody, this.onResponseHeader, this.onResponseData, this.onResponseComplete);
            Log.debug((((("Request URI: " + _arg_1) + " (") + _arg_2.method) + ")"));
            var _local_3:ByteArray = _arg_2.getHeader(_arg_1, this._proxy, HTTP_VERSION);
            Log.debug(("Header:\n" + _local_3.readUTFBytes(_local_3.length)));
            _local_3.position = 0;
            this._socket.writeBytes(_local_3);
            this._socket.flush();
            this._timer.reset();
            if (_arg_2.hasRequestBody)
            {
                this._requestBuffer = new HttpRequestBuffer(_arg_2.body);
                Log.debug("Sending request data");
                while (this._requestBuffer.hasData)
                {
                    _local_4 = this._requestBuffer.read();
                    if (_local_4.length > 0)
                    {
                        this._socket.writeBytes(_local_4);
                        this._timer.reset();
                        this._socket.flush();
                    };
                };
            };
            Log.debug("Send request done");
            _local_3.position = 0;
            this.onRequestComplete(_arg_2, _local_3.readUTFBytes(_local_3.length));
        }

        private function onClose(_arg_1:Event):void
        {
            var _local_2:HttpResponse;
            this._dispatcher.dispatchEvent(_arg_1.clone());
            if (this._responseBuffer)
            {
                _local_2 = this._responseBuffer.header;
                if ((((_local_2) && (_local_2.contentLength == -1)) && (!(_local_2.isChunked))))
                {
                    this.onComplete(_local_2);
                };
            };
        }

        protected function connect(_arg_1:URI, _arg_2:Function=null):void
        {
            this._onConnect = _arg_2;
            var _local_3:* = (_arg_1.scheme == "https");
            this.createSocket(_local_3);
            this._timer.start();
            var _local_4:int = ((this._proxy) ? Number(this._proxy.port) : Number(_arg_1.port));
            if (!_local_4)
            {
                _local_4 = this.getDefaultPort(_local_3);
            };
            var _local_5:String = ((this._proxy) ? this._proxy.authority : _arg_1.authority);
            Log.debug(((("Connecting: host: " + _local_5) + ", port: ") + _local_4));
            this._socket.connect(_local_5, _local_4);
        }

        protected function connectProxy(uri:URI, request:HttpRequest):void
        {
            var proxyResponse:HttpResponse;
            var onProxyHeader:Function = function (_arg_1:HttpResponse):void
            {
                proxyResponse = _arg_1;
            };
            var onProxyData:Function = function (_arg_1:ByteArray):void
            {
            };
            var onProxyComplete:Function = function (_arg_1:Number):void
            {
                var _local_2:SecureSocket;
                _timer.stop();
                if (proxyResponse.isSuccess)
                {
                    _local_2 = new SecureSocket();
                    _local_2.connect(uri.authority, 443);
                    _socket = _local_2;
                    _socket.addEventListener(Event.CONNECT, onConnect);
                    _socket.addEventListener(Event.CLOSE, onClose);
                    _socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
                    _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                    _socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
                    sendRequest(uri, internal::request);
                }
                else
                {
                    _dispatcher.dispatchEvent(new HttpErrorEvent(HttpErrorEvent.ERROR, false, false, "CONNECT method failed", 1));
                };
            };
            this._responseBuffer = new HttpResponseBuffer(false, onProxyHeader, onProxyData, onProxyComplete);
            var bytes:ByteArray = new ByteArray();
            bytes.writeUTFBytes((((((("CONNECT " + uri.authority) + ":") + ((uri.port) ? uri.port : DEFAULT_HTTPS_PORT)) + " HTTP/") + HTTP_VERSION) + "\r\n\r\n"));
            bytes.position = 0;
            this._socket.writeBytes(bytes);
            this._socket.flush();
            this._timer.reset();
            Log.debug("Send CONNECT done");
        }

        public function getDefaultPort(_arg_1:Boolean=false):uint
        {
            if (_arg_1)
            {
                return (DEFAULT_HTTPS_PORT);
            };
            return (DEFAULT_HTTP_PORT);
        }

        private function onResponseHeader(_arg_1:HttpResponse):void
        {
            Log.debug(("Response: " + _arg_1.code));
            this._dispatcher.dispatchEvent(new HttpStatusEvent(_arg_1));
        }

        public function close():void
        {
            if (this._closed)
            {
                return;
            };
            this._closed = true;
            Log.debug("Called close");
            this._timer.stop();
            if (((this._socket) && (this._socket.connected)))
            {
                this._socket.close();
                this._socket = null;
            };
            this._dispatcher.dispatchEvent(new Event(Event.CLOSE));
        }

        private function onSocketData(event:ProgressEvent):void
        {
            var bytes:ByteArray;
            while ((((this._socket) && (this._socket.connected)) && (this._socket.bytesAvailable)))
            {
                this._timer.reset();
                try
                {
                    bytes = new ByteArray();
                    this._socket.readBytes(bytes, 0, this._socket.bytesAvailable);
                    bytes.position = 0;
                    this._responseBuffer.writeBytes(bytes);
                }
                catch(e:EOFError)
                {
                    Log.debug("EOF");
                    _dispatcher.dispatchEvent(new HttpErrorEvent(HttpErrorEvent.ERROR, false, false, "EOF", 1));
                    return;
                };
            };
        }

        private function onComplete(_arg_1:HttpResponse):void
        {
            this._timer.stop();
            this._dispatcher.dispatchEvent(new HttpResponseEvent(_arg_1));
        }


    }
}//package org.httpclient

