package org.httpclient
{
   public class HttpResponse
   {
      
      private var _message:String;
      
      private var _header:HttpHeader;
      
      private var _version:String;
      
      private var _code:String;
      
      public function HttpResponse(param1:String, param2:String, param3:String, param4:HttpHeader)
      {
         super();
         this._version = param1;
         this._code = param2;
         this._message = param3;
         this._header = param4;
      }
      
      public function get isSuccess() : Boolean
      {
         return this._code.search(/\A2\d\d/) != -1;
      }
      
      public function get isInformation() : Boolean
      {
         return this._code.search(/\A1\d\d/) != -1;
      }
      
      public function toString() : String
      {
         return "version: " + this._version + ", code: " + this._code + ", message: " + this._message + "\nheader:\n" + this._header + "\n--\n";
      }
      
      public function get contentLength() : Number
      {
         var _loc1_:String = this._header.getValue("Content-Length");
         if(!_loc1_)
         {
            return -1;
         }
         return parseInt(_loc1_);
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function get isRedirection() : Boolean
      {
         return this._code.search(/\A3\d\d/) != -1;
      }
      
      public function get isServerError() : Boolean
      {
         return this._code.search(/\A5\d\d/) != -1;
      }
      
      public function get isClientError() : Boolean
      {
         return this._code.search(/\A4\d\d/) != -1;
      }
      
      public function get code() : String
      {
         return this._code;
      }
      
      public function get isChunked() : Boolean
      {
         return this._header.contains("Transfer-Encoding","Chunked");
      }
      
      public function get header() : HttpHeader
      {
         return this._header;
      }
      
      public function get version() : String
      {
         return this._version;
      }
   }
}

