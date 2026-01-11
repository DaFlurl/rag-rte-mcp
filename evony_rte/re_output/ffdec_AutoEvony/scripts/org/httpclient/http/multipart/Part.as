package org.httpclient.http.multipart
{
   import flash.utils.ByteArray;
   
   public class Part
   {
      
      private var _contentDispositionExtras:Array;
      
      private var _name:String;
      
      private var _header:ByteArray;
      
      private var _payload:*;
      
      private var _contentType:String;
      
      private var _footer:ByteArray;
      
      private var _contentTransferEncoding:String;
      
      public function Part(param1:String, param2:*, param3:String = null, param4:Array = null, param5:String = null)
      {
         var _loc6_:ByteArray = null;
         super();
         if(param2 is String)
         {
            _loc6_ = new ByteArray();
            _loc6_.writeUTFBytes(param2);
            _loc6_.position = 0;
            param2 = _loc6_;
         }
         this._name = param1;
         this._payload = param2;
         this._contentType = param3;
         this._contentDispositionExtras = param4;
         this._contentTransferEncoding = param5;
         this._header = this.header();
         this._footer = this.footer();
      }
      
      protected function footer() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeUTFBytes("\r\n");
         _loc1_.position = 0;
         return _loc1_;
      }
      
      private function get nextBytes() : *
      {
         if(this._header.bytesAvailable > 0)
         {
            return this._header;
         }
         if(this._payload.bytesAvailable > 0)
         {
            return this._payload;
         }
         if(this._footer.bytesAvailable > 0)
         {
            return this._footer;
         }
         throw Error("Nothing left for part");
      }
      
      public function get length() : uint
      {
         return this._payload.length + this._header.length + this._footer.length;
      }
      
      public function get bytesAvailable() : uint
      {
         return this.nextBytes.bytesAvailable;
      }
      
      public function close() : void
      {
         if(!(this._payload is ByteArray))
         {
            this._payload.close();
         }
      }
      
      public function readBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         if(this.nextBytes.bytesAvailable > 0)
         {
            param3 = Math.min(param3,this.nextBytes.bytesAvailable);
            this.nextBytes.readBytes(param1,param2,param3);
         }
      }
      
      protected function header() : ByteArray
      {
         var bytes:ByteArray = null;
         bytes = new ByteArray();
         bytes.writeUTFBytes("--" + Multipart.BOUNDARY + "\r\n");
         bytes.writeUTFBytes("Content-Disposition: form-data; ");
         if(this._name)
         {
            bytes.writeUTFBytes("name=\"" + this._name + "\"");
         }
         if(this._contentDispositionExtras)
         {
            this._contentDispositionExtras.forEach(function(param1:*, param2:int, param3:Array):void
            {
               bytes.writeUTFBytes("; " + param1.name + "=\"" + param1.value + "\"");
            });
         }
         bytes.writeUTFBytes("\r\n");
         if(this._contentType)
         {
            bytes.writeUTFBytes("Content-Type: " + this._contentType + "\r\n");
         }
         if(this._contentTransferEncoding)
         {
            bytes.writeUTFBytes("Content-Transfer-Encoding: " + this._contentTransferEncoding + "\r\n");
         }
         bytes.writeUTFBytes("\r\n");
         bytes.position = 0;
         return bytes;
      }
   }
}

