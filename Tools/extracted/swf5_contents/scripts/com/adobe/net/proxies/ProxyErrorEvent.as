package com.adobe.net.proxies
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class ProxyErrorEvent extends IOErrorEvent
   {
      public function ProxyErrorEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function toString() : String
      {
         return formatToString("ProxyErrorEvent","type","bubbles","cancelable","eventPhase");
      }
      
      override public function clone() : Event
      {
         return new ProxyErrorEvent(type,bubbles,cancelable);
      }
   }
}

