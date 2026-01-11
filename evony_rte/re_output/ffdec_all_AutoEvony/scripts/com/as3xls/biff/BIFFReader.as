package com.as3xls.biff
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BIFFReader
   {
      
      private var stream:ByteArray;
      
      private var _tags:Array;
      
      public function BIFFReader(param1:ByteArray)
      {
         super();
         this.stream = param1;
         param1.endian = Endian.LITTLE_ENDIAN;
         param1.position = 0;
      }
      
      public function readTag() : Record
      {
         if(this.stream.bytesAvailable < 4)
         {
            return null;
         }
         var _loc1_:uint = this.stream.readUnsignedShort();
         var _loc2_:uint = this.stream.readUnsignedShort();
         if(this.stream.bytesAvailable < _loc2_)
         {
            return null;
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.endian = Endian.LITTLE_ENDIAN;
         if(_loc2_ > 0)
         {
            this.stream.readBytes(_loc3_,0,_loc2_);
         }
         return new Record(_loc1_,_loc3_);
      }
   }
}

