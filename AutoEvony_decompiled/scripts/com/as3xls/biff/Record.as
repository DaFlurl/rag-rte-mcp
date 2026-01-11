package com.as3xls.biff
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class Record
   {
      
      private var _type:uint;
      
      private var _data:ByteArray;
      
      public function Record(param1:uint, param2:ByteArray = null)
      {
         super();
         this._type = param1;
         this._data = param2 == null ? new ByteArray() : param2;
         this._data.endian = Endian.LITTLE_ENDIAN;
      }
      
      public function set type(param1:uint) : void
      {
         this._type = param1;
      }
      
      public function get length() : uint
      {
         return this._data.length;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function get data() : ByteArray
      {
         return this._data;
      }
      
      public function readUnicodeStr16() : String
      {
         var _loc1_:uint = this._data.readUnsignedShort();
         var _loc2_:uint = uint(this._data.readByte());
         var _loc3_:* = (_loc2_ & 1) == 0;
         var _loc4_:* = (_loc2_ & 4) == 4;
         var _loc5_:* = (_loc2_ & 8) == 8;
         if(!_loc3_)
         {
            _loc1_ *= 2;
         }
         _loc1_ = _loc1_ > this._data.bytesAvailable ? this._data.bytesAvailable : _loc1_;
         return this._data.readUTFBytes(_loc1_);
      }
   }
}

