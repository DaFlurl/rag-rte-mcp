package org.httpclient.events
{
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class HttpDataEvent extends Event
   {
      public static const DATA:String = "httpData";
      
      private var _bytes:ByteArray;
      
      public function HttpDataEvent(param1:ByteArray, param2:String = "httpData", param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this._bytes = param1;
      }
      
      public function readUTFBytes() : String
      {
         return this._bytes.readUTFBytes(this._bytes.length);
      }
      
      public function get bytes() : ByteArray
      {
         return this._bytes;
      }
   }
}

