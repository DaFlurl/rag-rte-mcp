package org.httpclient.events
{
   import flash.events.ErrorEvent;
   
   public class HttpErrorEvent extends ErrorEvent
   {
      public static const ERROR:String = "httpError";
      
      public static const TIMEOUT_ERROR:String = "httpTimeoutError";
      
      public function HttpErrorEvent(param1:String = "httpError", param2:Boolean = false, param3:Boolean = false, param4:String = "", param5:int = 0)
      {
         super(param1,param2,param3,param4);
      }
   }
}

