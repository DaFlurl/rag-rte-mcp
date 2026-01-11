package org.httpclient.events
{
   import flash.events.Event;
   import org.httpclient.HttpResponse;
   
   public class HttpResponseEvent extends Event
   {
      public static const COMPLETE:String = "responseComplete";
      
      private var _response:HttpResponse;
      
      public function HttpResponseEvent(param1:HttpResponse, param2:String = "responseComplete", param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this._response = param1;
      }
      
      public function get response() : HttpResponse
      {
         return this._response;
      }
   }
}

