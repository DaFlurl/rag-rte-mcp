package com.as3xls.biff
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BIFFWriter
   {
      
      private var _stream:ByteArray;
      
      public function BIFFWriter()
      {
         super();
         this._stream = new ByteArray();
         this._stream.endian = Endian.LITTLE_ENDIAN;
      }
      
      public function get stream() : ByteArray
      {
         return this._stream;
      }
      
      public function writeTag(param1:Record) : void
      {
         this._stream.writeShort(param1.type);
         this._stream.writeShort(param1.length);
         param1.data.position = 0;
         param1.data.readBytes(this._stream,this._stream.position,param1.data.bytesAvailable);
         this._stream.position += param1.data.length;
      }
   }
}

