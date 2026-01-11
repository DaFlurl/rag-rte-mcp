package com.as3xls.cdf
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class CDFReader
   {
      private var stream:ByteArray;
      
      private var sectorSize:uint;
      
      private var sat:Array;
      
      public var dir:Array;
      
      public function CDFReader(param1:ByteArray)
      {
         super();
         this.stream = param1;
         param1.position = 0;
         param1.endian = Endian.LITTLE_ENDIAN;
         this.loadDocument();
      }
      
      public static function isCDFFile(param1:ByteArray) : Boolean
      {
         var _loc2_:Array = [208,207,17,224,161,177,26,225];
         if(param1.length < _loc2_.length)
         {
            return false;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] != param1[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function loadDocument() : void
      {
         var _loc16_:String = null;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:uint = 0;
         var _loc1_:Number = this.stream.readDouble();
         this.stream.position += 16;
         var _loc2_:uint = this.stream.readUnsignedShort();
         var _loc3_:uint = this.stream.readUnsignedShort();
         var _loc4_:uint = this.stream.readUnsignedShort();
         this.sectorSize = Math.pow(2,this.stream.readUnsignedShort());
         var _loc5_:uint = Math.pow(2,this.stream.readUnsignedShort());
         this.stream.position += 10;
         var _loc6_:uint = this.stream.readUnsignedInt();
         var _loc7_:int = this.stream.readInt();
         this.stream.position += 4;
         var _loc8_:uint = this.stream.readUnsignedInt();
         var _loc9_:int = this.stream.readInt();
         var _loc10_:uint = this.stream.readUnsignedInt();
         var _loc11_:int = this.stream.readInt();
         var _loc12_:uint = this.stream.readUnsignedInt();
         this.sat = new Array();
         var _loc13_:uint = 0;
         while(_loc13_ < 109)
         {
            this.stream.position = 76 + _loc13_ * 4;
            this.sat[_loc13_] = this.stream.readInt();
            _loc13_++;
         }
         var _loc14_:ByteArray = new ByteArray();
         _loc14_.endian = Endian.LITTLE_ENDIAN;
         _loc13_ = 0;
         while(_loc13_ < this.sat.length)
         {
            if(this.sat[_loc13_] >= 0)
            {
               this.stream.position = this.sectorOffset(this.sat[_loc13_]);
               this.stream.readBytes(_loc14_,_loc13_ * this.sectorSize,this.sectorSize);
            }
            _loc13_++;
         }
         this.sat = new Array();
         _loc13_ = 0;
         while(_loc13_ < _loc14_.length / 4)
         {
            this.sat[_loc13_] = _loc14_.readInt();
            _loc13_++;
         }
         this.dir = new Array();
         var _loc15_:ByteArray = this.loadStream(_loc7_);
         while(_loc15_.bytesAvailable > 0)
         {
            _loc16_ = "";
            _loc13_ = 0;
            while(_loc13_ < 32)
            {
               _loc16_ += String.fromCharCode(_loc15_.readUnsignedByte());
               ++_loc15_.position;
               _loc13_++;
            }
            _loc17_ = _loc15_.readUnsignedShort();
            _loc16_ = _loc16_.substr(0,(_loc17_ - 2) / 2);
            _loc18_ = _loc15_.readUnsignedByte();
            _loc19_ = _loc15_.readUnsignedByte();
            _loc20_ = _loc15_.readInt();
            _loc21_ = _loc15_.readInt();
            _loc22_ = _loc15_.readInt();
            _loc15_.position += 16;
            _loc15_.position += 4;
            _loc15_.position += 8;
            _loc15_.position += 8;
            _loc23_ = _loc15_.readInt();
            _loc24_ = _loc15_.readUnsignedInt();
            _loc15_.position += 4;
            if(_loc18_ == 2)
            {
               this.dir.push({
                  "name":_loc16_,
                  "secId":_loc23_
               });
            }
         }
      }
      
      private function loadStream(param1:uint) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         var _loc3_:int = int(param1);
         var _loc4_:uint = 0;
         while(_loc3_ != -2)
         {
            this.stream.position = this.sectorOffset(_loc3_);
            this.stream.readBytes(_loc2_,_loc4_,this.sectorSize);
            _loc4_ += this.sectorSize;
            _loc3_ = int(this.sat[_loc3_]);
         }
         return _loc2_;
      }
      
      public function loadDirectoryEntry(param1:uint) : ByteArray
      {
         return this.loadStream(this.dir[param1].secId);
      }
      
      private function sectorOffset(param1:uint) : uint
      {
         return 512 + param1 * this.sectorSize;
      }
   }
}

