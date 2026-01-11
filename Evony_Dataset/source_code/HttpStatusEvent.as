package org.httpclient.events
{
   import flash.events.Event;
   import org.httpclient.HttpHeader;
   import org.httpclient.HttpResponse;
   
   public class HttpStatusEvent extends Event
   {
      public static const STATUS:String = "httpStatus";
      
      private var _response:HttpResponse;
      
      public function HttpStatusEvent(param1:HttpResponse, param2:String = "httpStatus", param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this._response = param1;
      }
      
      public function get response() : HttpResponse
      {
         return this._response;
      }
      
      public function get code() : String
      {
         return this._response.code;
      }
      
      public function get header() : HttpHeader
      {
         return this._response.header;
      }
   }
}

