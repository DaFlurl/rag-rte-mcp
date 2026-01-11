package org.httpclient.events
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   
   public class HttpListener extends EventDispatcher
   {
      public var onClose:Function = null;
      
      public var onData:Function = null;
      
      public var onConnect:Function = null;
      
      public var onError:Function = null;
      
      public var onStatus:Function = null;
      
      public var onRequest:Function = null;
      
      public var onComplete:Function = null;
      
      public function HttpListener(param1:Object = null)
      {
         super();
         if(param1)
         {
            if(param1["onClose"] != undefined)
            {
               this.onClose = param1.onClose;
            }
            if(param1["onComplete"] != undefined)
            {
               this.onComplete = param1.onComplete;
            }
            if(param1["onConnect"] != undefined)
            {
               this.onConnect = param1.onConnect;
            }
            if(param1["onData"] != undefined)
            {
               this.onData = param1.onData;
            }
            if(param1["onError"] != undefined)
            {
               this.onError = param1.onError;
            }
            if(param1["onStatus"] != undefined)
            {
               this.onStatus = param1.onStatus;
            }
            if(param1["onRequest"] != undefined)
            {
               this.onRequest = param1.onRequest;
            }
         }
      }
      
      public function register(param1:EventDispatcher = null) : HttpListener
      {
         if(param1 == null)
         {
            param1 = this;
         }
         param1.addEventListener(Event.CLOSE,this.onInternalClose);
         param1.addEventListener(HttpResponseEvent.COMPLETE,this.onInternalComplete);
         param1.addEventListener(HttpRequestEvent.CONNECT,this.onInternalConnect);
         param1.addEventListener(HttpDataEvent.DATA,this.onInternalData);
         param1.addEventListener(HttpErrorEvent.ERROR,this.onInternalError);
         param1.addEventListener(HttpErrorEvent.TIMEOUT_ERROR,this.onInternalError);
         param1.addEventListener(HttpStatusEvent.STATUS,this.onInternalStatus);
         param1.addEventListener(HttpRequestEvent.COMPLETE,this.onInternalRequest);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.onInternalError);
         param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onInternalError);
         return this;
      }
      
      protected function onInternalData(param1:HttpDataEvent) : void
      {
         if(this.onData != null)
         {
            this.onData(param1);
         }
      }
      
      protected function onInternalError(param1:ErrorEvent) : void
      {
         if(this.onError != null)
         {
            this.onError(param1);
         }
      }
      
      protected function onInternalConnect(param1:HttpRequestEvent) : void
      {
         if(this.onConnect != null)
         {
            this.onConnect(param1);
         }
      }
      
      protected function onInternalClose(param1:Event) : void
      {
         if(this.onClose != null)
         {
            this.onClose(param1);
         }
      }
      
      protected function onInternalComplete(param1:HttpResponseEvent) : void
      {
         if(this.onComplete != null)
         {
            this.onComplete(param1);
         }
      }
      
      protected function onInternalRequest(param1:HttpRequestEvent) : void
      {
         if(this.onRequest != null)
         {
            this.onRequest(param1);
         }
      }
      
      public function unregister(param1:EventDispatcher = null) : HttpListener
      {
         if(param1 == null)
         {
            param1 = this;
         }
         param1.removeEventListener(Event.CLOSE,this.onInternalClose);
         param1.removeEventListener(HttpResponseEvent.COMPLETE,this.onInternalComplete);
         param1.removeEventListener(HttpRequestEvent.CONNECT,this.onInternalConnect);
         param1.removeEventListener(HttpDataEvent.DATA,this.onInternalData);
         param1.removeEventListener(HttpErrorEvent.ERROR,this.onInternalError);
         param1.removeEventListener(HttpErrorEvent.TIMEOUT_ERROR,this.onInternalError);
         param1.removeEventListener(HttpStatusEvent.STATUS,this.onInternalStatus);
         param1.removeEventListener(HttpRequestEvent.COMPLETE,this.onInternalRequest);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onInternalError);
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onInternalError);
         return this;
      }
      
      protected function onInternalStatus(param1:HttpStatusEvent) : void
      {
         if(this.onStatus != null)
         {
            this.onStatus(param1);
         }
      }
   }
}

