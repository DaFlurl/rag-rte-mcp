package org.httpclient.events
{
   import flash.events.Event;
   import org.httpclient.HttpRequest;
   
   public class HttpRequestEvent extends Event
   {
      public static const CONNECT:String = "requestConnect";
      
      public static const COMPLETE:String = "requestComplete";
      
      private var _request:HttpRequest;
      
      private var _header:String;
      
      public function HttpRequestEvent(param1:HttpRequest, param2:String, param3:String = "requestComplete", param4:Boolean = false, param5:Boolean = false)
      {
         super(param3,param4,param5);
         this._request = param1;
         this._header = param2;
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function get request() : HttpRequest
      {
         return this._request;
      }
   }
}

