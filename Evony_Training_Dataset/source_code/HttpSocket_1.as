package org.httpclient
{
   import com.adobe.net.URI;
   import flash.errors.EOFError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.SecureSocket;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import org.httpclient.events.*;
   import org.httpclient.io.HttpRequestBuffer;
   import org.httpclient.io.HttpResponseBuffer;
   
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
      
      public function HttpSocket(param1:EventDispatcher, param2:Number = 60000, param3:URI = null)
      {
         super();
         this._dispatcher = param1;
         this._timer = new HttpTimer(param2,this.onTimeout);
         this._proxy = param3;
      }
      
      private function onTimeout(param1:Number) : void
      {
         this._dispatcher.dispatchEvent(new HttpErrorEvent(HttpErrorEvent.TIMEOUT_ERROR,false,false,"Timeout",0));
         this.close();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         if(this._closed)
         {
            return;
         }
         this.close();
         this._dispatcher.dispatchEvent(param1.clone());
      }
      
      private function onRequestComplete(param1:HttpRequest, param2:String) : void
      {
         this._dispatcher.dispatchEvent(new HttpRequestEvent(param1,param2));
      }
      
      private function onResponseData(param1:ByteArray) : void
      {
         this._dispatcher.dispatchEvent(new HttpDataEvent(param1));
      }
      
      protected function createSocket(param1:Boolean = false) : void
      {
         if(param1 && !this._proxy)
         {
            this._socket = new SecureSocket();
         }
         else
         {
            this._socket = new Socket();
         }
         this._socket.addEventListener(Event.CONNECT,this.onConnect);
         this._socket.addEventListener(Event.CLOSE,this.onClose);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this._closed)
         {
            return;
         }
         this.close();
         this._dispatcher.dispatchEvent(param1.clone());
      }
      
      public function request(param1:URI, param2:HttpRequest) : void
      {
         var uri:URI = param1;
         var request:HttpRequest = param2;
         var onConnect:Function = function(param1:Event):void
         {
            _dispatcher.dispatchEvent(new HttpRequestEvent(request,null,HttpRequestEvent.CONNECT));
            if(uri.scheme == "https" && Boolean(_proxy))
            {
               connectProxy(uri,request);
            }
            else
            {
               sendRequest(uri,request);
            }
         };
         this.connect(uri,onConnect);
      }
      
      private function onResponseComplete(param1:HttpResponse) : void
      {
         Log.debug("Response complete");
         this.close();
         this.onComplete(param1);
      }
      
      private function onConnect(param1:Event) : void
      {
         if(this._onConnect != null)
         {
            this._onConnect(param1);
         }
      }
      
      protected function sendRequest(param1:URI, param2:HttpRequest) : void
      {
         var _loc4_:ByteArray = null;
         this._responseBuffer = new HttpResponseBuffer(param2.hasResponseBody,this.onResponseHeader,this.onResponseData,this.onResponseComplete);
         Log.debug("Request URI: " + param1 + " (" + param2.method + ")");
         var _loc3_:ByteArray = param2.getHeader(param1,this._proxy,HTTP_VERSION);
         Log.debug("Header:\n" + _loc3_.readUTFBytes(_loc3_.length));
         _loc3_.position = 0;
         this._socket.writeBytes(_loc3_);
         this._socket.flush();
         this._timer.reset();
         if(param2.hasRequestBody)
         {
            this._requestBuffer = new HttpRequestBuffer(param2.body);
            Log.debug("Sending request data");
            while(this._requestBuffer.hasData)
            {
               _loc4_ = this._requestBuffer.read();
               if(_loc4_.length > 0)
               {
                  this._socket.writeBytes(_loc4_);
                  this._timer.reset();
                  this._socket.flush();
               }
            }
         }
         Log.debug("Send request done");
         _loc3_.position = 0;
         this.onRequestComplete(param2,_loc3_.readUTFBytes(_loc3_.length));
      }
      
      private function onClose(param1:Event) : void
      {
         var _loc2_:HttpResponse = null;
         this._dispatcher.dispatchEvent(param1.clone());
         if(this._responseBuffer)
         {
            _loc2_ = this._responseBuffer.header;
            if(_loc2_ && _loc2_.contentLength == -1 && !_loc2_.isChunked)
            {
               this.onComplete(_loc2_);
            }
         }
      }
      
      protected function connect(param1:URI, param2:Function = null) : void
      {
         this._onConnect = param2;
         var _loc3_:* = param1.scheme == "https";
         this.createSocket(_loc3_);
         this._timer.start();
         var _loc4_:int = !!this._proxy ? int(Number(this._proxy.port)) : int(Number(param1.port));
         if(!_loc4_)
         {
            _loc4_ = int(this.getDefaultPort(_loc3_));
         }
         var _loc5_:String = !!this._proxy ? this._proxy.authority : param1.authority;
         Log.debug("Connecting: host: " + _loc5_ + ", port: " + _loc4_);
         this._socket.connect(_loc5_,_loc4_);
      }
      
      protected function connectProxy(param1:URI, param2:HttpRequest) : void
      {
         var bytes:ByteArray;
         var proxyResponse:HttpResponse = null;
         var uri:URI = param1;
         var request:HttpRequest = param2;
         var onProxyHeader:Function = function(param1:HttpResponse):void
         {
            proxyResponse = param1;
         };
         var onProxyData:Function = function(param1:ByteArray):void
         {
         };
         var onProxyComplete:Function = function(param1:Number):void
         {
            var _loc2_:SecureSocket = null;
            _timer.stop();
            if(proxyResponse.isSuccess)
            {
               _loc2_ = new SecureSocket();
               _loc2_.connect(uri.authority,443);
               _socket = _loc2_;
               _socket.addEventListener(Event.CONNECT,onConnect);
               _socket.addEventListener(Event.CLOSE,onClose);
               _socket.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
               _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
               _socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
               sendRequest(uri,request);
            }
            else
            {
               _dispatcher.dispatchEvent(new HttpErrorEvent(HttpErrorEvent.ERROR,false,false,"CONNECT method failed",1));
            }
         };
         this._responseBuffer = new HttpResponseBuffer(false,onProxyHeader,onProxyData,onProxyComplete);
         bytes = new ByteArray();
         bytes.writeUTFBytes("CONNECT " + uri.authority + ":" + (!!uri.port ? uri.port : DEFAULT_HTTPS_PORT) + " HTTP/" + HTTP_VERSION + "\r\n\r\n");
         bytes.position = 0;
         this._socket.writeBytes(bytes);
         this._socket.flush();
         this._timer.reset();
         Log.debug("Send CONNECT done");
      }
      
      public function getDefaultPort(param1:Boolean = false) : uint
      {
         if(param1)
         {
            return DEFAULT_HTTPS_PORT;
         }
         return DEFAULT_HTTP_PORT;
      }
      
      private function onResponseHeader(param1:HttpResponse) : void
      {
         Log.debug("Response: " + param1.code);
         this._dispatcher.dispatchEvent(new HttpStatusEvent(param1));
      }
      
      public function close() : void
      {
         if(this._closed)
         {
            return;
         }
         this._closed = true;
         Log.debug("Called close");
         this._timer.stop();
         if(this._socket && Boolean(this._socket.connected))
         {
            this._socket.close();
            this._socket = null;
         }
         this._dispatcher.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function onSocketData(param1:ProgressEvent) : void
      {
         var bytes:ByteArray = null;
         var event:ProgressEvent = param1;
         while(this._socket && Boolean(this._socket.connected) && Boolean(this._socket.bytesAvailable))
         {
            this._timer.reset();
            try
            {
               bytes = new ByteArray();
               this._socket.readBytes(bytes,0,this._socket.bytesAvailable);
               bytes.position = 0;
               this._responseBuffer.writeBytes(bytes);
            }
            catch(e:EOFError)
            {
               Log.debug("EOF");
               _dispatcher.dispatchEvent(new HttpErrorEvent(HttpErrorEvent.ERROR,false,false,"EOF",1));
               break;
            }
         }
      }
      
      private function onComplete(param1:HttpResponse) : void
      {
         this._timer.stop();
         this._dispatcher.dispatchEvent(new HttpResponseEvent(param1));
      }
   }
}

