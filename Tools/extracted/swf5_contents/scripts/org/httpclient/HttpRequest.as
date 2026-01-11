package org.httpclient
{
   import com.adobe.net.URI;
   import com.adobe.net.URIEncodingBitmap;
   import flash.errors.IllegalOperationError;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   import org.httpclient.http.multipart.Multipart;
   
   public class HttpRequest
   {
      public static const kUriPathEscapeBitmap:URIEncodingBitmap = new URIEncodingBitmap(" %?#");
      
      public static const kUriQueryEscapeBitmap:URIEncodingBitmap = new URIEncodingBitmap(" {}%=|:?#/@+\\");
      
      protected var _method:String;
      
      protected var _body:*;
      
      protected var _header:HttpHeader;
      
      public function HttpRequest(param1:String, param2:HttpHeader = null, param3:* = null)
      {
         super();
         this._method = param1;
         this._body = param3;
         this._header = param2;
         if(!this._header)
         {
            this._header = new HttpHeader();
         }
         this.loadDefaultHeaders();
      }
      
      public function getHeader(param1:URI, param2:URI = null, param3:String = null) : ByteArray
      {
         var _loc9_:String = null;
         var _loc11_:RegExp = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Base64Encoder = null;
         param1.forceEscape();
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:String = param1.path;
         if(!_loc5_)
         {
            _loc5_ = "/";
         }
         else
         {
            _loc5_ = URI.fastEscapeChars(_loc5_,kUriPathEscapeBitmap);
         }
         var _loc6_:Object = param1.getQueryByMap();
         var _loc7_:URLVariables = null;
         var _loc8_:Array = new Array();
         for(_loc9_ in _loc6_)
         {
            _loc7_ = new URLVariables();
            _loc7_[_loc9_] = _loc6_[_loc9_];
            _loc8_.push(_loc7_.toString());
         }
         if(_loc8_.length > 0)
         {
            _loc5_ += "?" + _loc8_.join("&");
         }
         var _loc10_:String = param1.authority;
         if(param1.port)
         {
            _loc10_ += ":" + param1.port;
         }
         if(!param3)
         {
            param3 = "1.1";
         }
         if(param2)
         {
            _loc11_ = /\?.*$/;
            _loc12_ = param1.toString().replace(_loc11_,"?") + _loc8_.join("&");
            _loc4_.writeUTFBytes(this.method + " " + _loc12_ + " HTTP/" + param3 + "\r\n");
         }
         else
         {
            _loc4_.writeUTFBytes(this.method + " " + _loc5_ + " HTTP/" + param3 + "\r\n");
         }
         _loc4_.writeUTFBytes("Host: " + _loc10_ + "\r\n");
         if(param2 && param2.username && Boolean(param2.password))
         {
            _loc13_ = param2.username + ":" + param2.password;
            _loc14_ = new Base64Encoder();
            _loc14_.encode(_loc13_);
            this.addHeader("Proxy-Authorization","Basic " + _loc14_.toString());
         }
         if(!this.header.isEmpty)
         {
            _loc4_.writeUTFBytes(this.header.content);
         }
         _loc4_.writeUTFBytes("\r\n");
         _loc4_.position = 0;
         return _loc4_;
      }
      
      public function set body(param1:*) : void
      {
         this._body = param1;
         this._header.replace("Content-Length",this._body.length);
      }
      
      public function set contentType(param1:String) : void
      {
         this._header.replace("Content-Type",param1);
      }
      
      public function get method() : String
      {
         return this._method;
      }
      
      public function get body() : *
      {
         return this._body;
      }
      
      public function setMultipart(param1:Multipart) : void
      {
         if(this._body)
         {
            throw new IllegalOperationError("The body content was already set; You can only set using either setMultipart, setFormData or body=");
         }
         this._header.replace("Content-Type","multipart/form-data; boundary=" + Multipart.BOUNDARY);
         this._header.replace("Content-Length",String(param1.length));
         this._body = param1;
      }
      
      protected function loadDefaultHeaders() : void
      {
         this.addHeader("Connection","close");
      }
      
      public function get header() : HttpHeader
      {
         return this._header;
      }
      
      public function addHeader(param1:String, param2:String) : void
      {
         this._header.add(param1,param2);
      }
      
      public function setFormData(param1:Array, param2:String = "&") : void
      {
         var params:Array = param1;
         var sep:String = param2;
         if(this._body)
         {
            throw new IllegalOperationError("The body content was already set; You can only set using either setMultipart, setFormData or body=");
         }
         this._header.replace("Content-Type","application/x-www-form-urlencoded");
         this._body = new ByteArray();
         this._body.writeUTFBytes(params.map(function(param1:*, param2:int, param3:Array):String
         {
            return encodeURIComponent(param1.name) + "=" + encodeURIComponent(param1.value);
         }).join(sep));
         this._body.position = 0;
         this._header.replace("Content-Length",this._body.length);
      }
      
      public function get hasRequestBody() : Boolean
      {
         throw new Error("Must use a request subclass with this method defined.");
      }
      
      public function toString() : String
      {
         return "method: " + this._method + ", header: " + this._header + ", body: " + this._body;
      }
      
      public function get hasResponseBody() : Boolean
      {
         throw new Error("Must use a request subclass with this method defined.");
      }
   }
}

