package org.httpclient.io
{
   import flash.utils.ByteArray;
   
   public class HttpRequestBuffer
   {
      private static const BLOCK_SIZE:uint = 16 * 1024;
      
      private var _body:*;
      
      private var _bytesSent:uint = 0;
      
      public function HttpRequestBuffer(param1:*)
      {
         super();
         this._body = param1;
      }
      
      public function read() : ByteArray
      {
         var _loc2_:uint = 0;
         var _loc1_:ByteArray = new ByteArray();
         if(this._body.bytesAvailable > 0)
         {
            _loc2_ = Math.min(BLOCK_SIZE,this._body.bytesAvailable);
            this._body.readBytes(_loc1_,0,_loc2_);
            _loc1_.position = 0;
            this._bytesSent += _loc1_.length;
         }
         return _loc1_;
      }
      
      public function get bytesSent() : uint
      {
         return this._bytesSent;
      }
      
      public function get hasData() : Boolean
      {
         if(!this._body)
         {
            return false;
         }
         return this._bytesSent < this._body.length;
      }
   }
}

