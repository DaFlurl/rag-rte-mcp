package com.evony.net.client
{
   import flash.events.*;
   
   public class GameClientEvent extends Event
   {
      
      public static const ON_CONNECTION:String = "gameClient.onConnection";
      
      public static const ON_CONNECTION_LOST:String = "gameClient.onConnectionLost";
      
      public static const ON_EXTENSION_RESPONSE:String = "gameClient.onExtensionResponse";
      
      public static const ON_ERROR:String = "gameClient.onError";
      
      public var data:Object;
      
      public var cmd:String;
      
      public function GameClientEvent(param1:String, param2:Object = null)
      {
         super(param1);
         if(param2)
         {
            if(param2.data)
            {
               this.data = param2.data;
            }
            if(param2.cmd)
            {
               this.cmd = param2.cmd;
            }
            if(Version.isTraceOn())
            {
               trace("dispatch Event:" + this.cmd);
            }
         }
      }
   }
}

