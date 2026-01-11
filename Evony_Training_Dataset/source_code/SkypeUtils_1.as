package com.skype
{
   import autoevony.common.Utils;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   internal class SkypeUtils
   {
      public function SkypeUtils()
      {
         super();
      }
      
      internal static function getMac256Hash(param1:String) : String
      {
         var challenge:String = param1;
         var int32ToHexString:Function = function(param1:int):String
         {
            var _loc2_:String = "0123456789abcdef";
            var _loc3_:String = "";
            var _loc4_:int = 0;
            while(_loc4_ < 4)
            {
               _loc3_ += _loc2_.charAt(param1 >> _loc4_ * 8 + 4 & 0x0F);
               _loc3_ += _loc2_.charAt(param1 >> _loc4_ * 8 & 0x0F);
               _loc4_++;
            }
            return _loc3_;
         };
         var int64Xor:Function = function(param1:Number, param2:Number):Number
         {
            var _loc8_:int = 0;
            var _loc3_:String = param1.toString(2);
            var _loc4_:String = param2.toString(2);
            var _loc5_:String = "";
            var _loc6_:* = "";
            var _loc7_:int = Math.abs(_loc3_.length - _loc4_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc6_ += "0";
               _loc8_++;
            }
            if(_loc3_.length < _loc4_.length)
            {
               _loc3_ = _loc6_ += _loc3_;
            }
            else if(_loc4_.length < _loc3_.length)
            {
               _loc4_ = _loc6_ += _loc4_;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc5_ += _loc3_.charAt(_loc8_) == _loc4_.charAt(_loc8_) ? "0" : "1";
               _loc8_++;
            }
            return parseInt(_loc5_,2);
         };
         var multiplymod:Function = function(param1:uint, param2:uint, param3:uint):uint
         {
            var _loc4_:uint = uint(int(param1 / 65536));
            var _loc5_:uint = param1 % 65536;
            var _loc6_:uint = uint(int(param2 / 65536));
            var _loc7_:uint = param2 % 65536;
            return (_loc4_ * _loc6_ * 65536 % param3 * 65536 % param3 + _loc4_ * 65536 * _loc7_ + _loc6_ * 65536 * _loc5_ + _loc5_ * _loc7_) % param3;
         };
         var cS64:Function = function(param1:Array, param2:Array):Array
         {
            var _loc3_:uint = 2147483647;
            var _loc4_:uint = uint(param2[0] & _loc3_);
            var _loc5_:uint = uint(param2[1] & _loc3_);
            var _loc6_:uint = uint(param2[2] & _loc3_);
            var _loc7_:uint = uint(param2[3] & _loc3_);
            var _loc8_:uint = 242854337;
            var _loc9_:uint = 0;
            var _loc10_:uint = 0;
            var _loc11_:uint = 0;
            var _loc12_:uint = 0;
            var _loc13_:int = 0;
            while(_loc13_ < int(param1.length / 2))
            {
               _loc10_ = parseInt(param1[_loc9_]);
               _loc9_ += 1;
               _loc10_ = uint(multiplymod(_loc8_,_loc10_,_loc3_));
               _loc11_ += _loc10_;
               _loc11_ = uint(multiplymod(_loc4_,_loc11_,_loc3_));
               _loc11_ = _loc11_ + _loc5_;
               _loc11_ = _loc11_ % _loc3_;
               _loc12_ += _loc11_;
               _loc11_ += parseInt(param1[_loc9_]);
               _loc9_ += 1;
               _loc11_ = uint(multiplymod(_loc6_,_loc11_,_loc3_));
               _loc11_ = _loc11_ + _loc7_;
               _loc11_ = _loc11_ % _loc3_;
               _loc12_ += _loc11_;
               _loc13_++;
            }
            _loc11_ += _loc5_;
            _loc11_ = _loc11_ % _loc3_;
            _loc12_ += _loc7_;
            _loc12_ = _loc12_ % _loc3_;
            return new Array(_loc11_,_loc12_);
         };
         var hash:Function = function(param1:ByteArray):ByteArray
         {
            var _loc5_:int = 0;
            var _loc2_:int = int(param1.length);
            var _loc3_:String = param1.endian;
            param1.endian = Endian.BIG_ENDIAN;
            var _loc4_:int = _loc2_ * 8;
            while(param1.length % 4 != 0)
            {
               param1[param1.length] = 0;
            }
            param1.position = 0;
            var _loc6_:Array = new Array();
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc6_.push(param1.readUnsignedInt());
               _loc5_ += 4;
            }
            var _loc7_:Array = core(_loc6_,_loc4_);
            var _loc8_:ByteArray = new ByteArray();
            var _loc9_:int = 8;
            _loc5_ = 0;
            while(_loc5_ < _loc9_)
            {
               _loc8_.writeUnsignedInt(_loc7_[_loc5_]);
               _loc5_++;
            }
            param1.length = _loc2_;
            param1.endian = _loc3_;
            return _loc8_;
         };
         var core:Function = function(param1:Array, param2:int):Array
         {
            var _loc6_:uint = 0;
            var _loc7_:uint = 0;
            var _loc8_:uint = 0;
            var _loc9_:uint = 0;
            var _loc10_:uint = 0;
            var _loc11_:uint = 0;
            var _loc12_:uint = 0;
            var _loc13_:uint = 0;
            var _loc14_:int = 0;
            var _loc15_:int = 0;
            var _loc16_:int = 0;
            var _loc17_:int = 0;
            var _loc18_:int = 0;
            var _loc19_:int = 0;
            var _loc20_:int = 0;
            var _loc21_:int = 0;
            var _loc22_:* = 0;
            var _loc23_:* = 0;
            var _loc24_:int = 0;
            var _loc25_:int = 0;
            var _loc27_:int = 0;
            var _loc3_:Array = [1116352408,1899447441,3049323471,3921009573,961987163,1508970993,2453635748,2870763221,3624381080,310598401,607225278,1426881987,1925078388,2162078206,2614888103,3248222580,3835390401,4022224774,264347078,604807628,770255983,1249150122,1555081692,1996064986,2554220882,2821834349,2952996808,3210313671,3336571891,3584528711,113926993,338241895,666307205,773529912,1294757372,1396182291,1695183700,1986661051,2177026350,2456956037,2730485921,2820302411,3259730800,3345764771,3516065817,3600352804,4094571909,275423344,430227734,506948616,659060556,883997877,958139571,1322822218,1537002063,1747873779,1955562222,2024104815,2227730452,2361852424,2428436474,2756734187,3204031479,3329325298];
            var _loc4_:Array = new Array(1779033703,3144134277,1013904242,2773480762,1359893119,2600822924,528734635,1541459225);
            param1[param2 >> 5] |= 128 << 24 - param2 % 32;
            param1[(param2 + 64 >> 9 << 4) + 15] = param2;
            var _loc5_:Array = new Array();
            _loc6_ = uint(_loc4_[0]);
            _loc7_ = uint(_loc4_[1]);
            _loc8_ = uint(_loc4_[2]);
            _loc9_ = uint(_loc4_[3]);
            _loc10_ = uint(_loc4_[4]);
            _loc11_ = uint(_loc4_[5]);
            _loc12_ = uint(_loc4_[6]);
            _loc13_ = uint(_loc4_[7]);
            var _loc26_:int = 0;
            while(_loc26_ < param1.length)
            {
               _loc14_ = int(_loc6_);
               _loc15_ = int(_loc7_);
               _loc16_ = int(_loc8_);
               _loc17_ = int(_loc9_);
               _loc18_ = int(_loc10_);
               _loc19_ = int(_loc11_);
               _loc20_ = int(_loc12_);
               _loc21_ = int(_loc13_);
               _loc27_ = 0;
               while(_loc27_ < 64)
               {
                  if(_loc27_ < 16)
                  {
                     _loc5_[_loc27_] = param1[_loc26_ + _loc27_] | 0;
                  }
                  else
                  {
                     _loc22_ = rrol(_loc5_[_loc27_ - 15],7) ^ rrol(_loc5_[_loc27_ - 15],18) ^ _loc5_[_loc27_ - 15] >>> 3;
                     _loc23_ = rrol(_loc5_[_loc27_ - 2],17) ^ rrol(_loc5_[_loc27_ - 2],19) ^ _loc5_[_loc27_ - 2] >>> 10;
                     _loc5_[_loc27_] = _loc5_[_loc27_ - 16] + _loc22_ + _loc5_[_loc27_ - 7] + _loc23_;
                  }
                  _loc24_ = (rrol(_loc6_,2) ^ rrol(_loc6_,13) ^ rrol(_loc6_,22)) + (_loc6_ & _loc7_ ^ _loc6_ & _loc8_ ^ _loc7_ & _loc8_);
                  _loc25_ = _loc13_ + (rrol(_loc10_,6) ^ rrol(_loc10_,11) ^ rrol(_loc10_,25)) + (_loc10_ & _loc11_ ^ _loc12_ & ~_loc10_) + _loc3_[_loc27_] + _loc5_[_loc27_];
                  _loc13_ = uint(_loc12_);
                  _loc12_ = uint(_loc11_);
                  _loc11_ = uint(_loc10_);
                  _loc10_ = uint(_loc9_ + _loc25_);
                  _loc9_ = uint(_loc8_);
                  _loc8_ = uint(_loc7_);
                  _loc7_ = uint(_loc6_);
                  _loc6_ = uint(_loc25_ + _loc24_);
                  _loc27_++;
               }
               _loc6_ += _loc14_;
               _loc7_ += _loc15_;
               _loc8_ += _loc16_;
               _loc9_ += _loc17_;
               _loc10_ += _loc18_;
               _loc11_ += _loc19_;
               _loc12_ += _loc20_;
               _loc13_ += _loc21_;
               _loc26_ += 16;
            }
            return new Array(_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_);
         };
         var rrol:Function = function(param1:int, param2:int):int
         {
            return param1 << 32 - param2 | param1 >>> param2;
         };
         var HexfromArray:Function = function(param1:ByteArray):String
         {
            var _loc2_:String = "";
            var _loc3_:int = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ += ("0" + param1[_loc3_].toString(16)).substr(-2,2);
               _loc3_++;
            }
            return _loc2_;
         };
         var HextoString:Function = function(param1:String):String
         {
            var _loc2_:ByteArray = HextoArray(param1);
            return _loc2_.readUTFBytes(_loc2_.length);
         };
         var HexfromString:Function = function(param1:String):String
         {
            var _loc2_:ByteArray = new ByteArray();
            _loc2_.writeUTFBytes(param1);
            return HexfromArray(_loc2_);
         };
         var HextoArray:Function = function(param1:String):ByteArray
         {
            param1 = param1.replace(/\s|:/gm,"");
            var _loc2_:ByteArray = new ByteArray();
            if((param1.length & 1) == 1)
            {
               param1 = "0" + param1;
            }
            var _loc3_:int = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_[_loc3_ / 2] = parseInt(param1.substr(_loc3_,2),16);
               _loc3_ += 2;
            }
            return _loc2_;
         };
         var sha256hashfrombytearray:Function = function(param1:ByteArray):String
         {
            var _loc2_:String = HexfromArray(param1);
            var _loc3_:ByteArray = HextoArray(_loc2_);
            var _loc4_:ByteArray = hash(_loc3_);
            return HexfromArray(_loc4_);
         };
         var _getMac256Hash:Function = function(param1:String):String
         {
            var _loc4_:int = 0;
            var _loc7_:int = 0;
            var _loc11_:int = 0;
            var _loc2_:* = param1 + "msmsgs@msnmsgr.com";
            var _loc3_:int = 8 - _loc2_.length % 8;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ += "0";
               _loc4_++;
            }
            var _loc5_:int = int(_loc2_.length / 4);
            var _loc6_:Array = new Array();
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_.splice(_loc4_,0,0);
               _loc7_ = 0;
               while(_loc7_ < 4)
               {
                  _loc6_[_loc4_] += _loc2_.charCodeAt(4 * _loc4_ + _loc7_) * Math.pow(256,_loc7_);
                  _loc7_++;
               }
               _loc4_++;
            }
            var _loc8_:Array = new Array(0,0,0,0);
            var _loc9_:ByteArray = new ByteArray();
            _loc9_.writeUTFBytes(param1 + "Q1P7W2E4J9R8U3S5");
            var _loc10_:String = sha256hashfrombytearray(_loc9_).toUpperCase();
            _loc4_ = 0;
            while(_loc4_ < _loc8_.length)
            {
               _loc8_[_loc4_] = 0;
               _loc7_ = 0;
               while(_loc7_ < 4)
               {
                  _loc11_ = 8 * _loc4_ + _loc7_ * 2;
                  _loc8_[_loc4_] += parseInt(_loc10_.substring(_loc11_,_loc11_ + 2),16) * Math.pow(256,_loc7_);
                  _loc7_++;
               }
               _loc4_++;
            }
            var _loc12_:Array = cS64(_loc6_,_loc8_);
            var _loc13_:Array = new Array(_loc12_[0],_loc12_[1],_loc12_[0],_loc12_[1]);
            var _loc14_:Array = new Array(int64Xor(_loc8_[0],_loc13_[0]),int64Xor(_loc8_[1],_loc13_[1]),int64Xor(_loc8_[2],_loc13_[2]),int64Xor(_loc8_[3],_loc13_[3]));
            var _loc15_:Array = new Array(int32ToHexString(_loc14_[0]),int32ToHexString(_loc14_[1]),int32ToHexString(_loc14_[2]),int32ToHexString(_loc14_[3]));
            return _loc15_.join("");
         };
         return _getMac256Hash(challenge);
      }
      
      internal static function getCookie(param1:String, param2:String) : String
      {
         var _loc4_:String = null;
         var _loc3_:Array = param2.split(";");
         for each(_loc4_ in _loc3_)
         {
            _loc4_ = Utils.trim(_loc4_);
            if(_loc4_.indexOf(param1 + "=") == 0)
            {
               return _loc4_.substr(param1.length + 1);
            }
         }
         return null;
      }
      
      internal static function processText(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = param1.replace(/\\n/g,"\n").replace(/\\r/g,"\r");
         var _loc3_:int = 0;
         var _loc5_:String = "";
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_.charAt(_loc3_) == "*")
            {
               _loc4_ = int(_loc2_.indexOf("*",_loc3_ + 1));
               if(_loc4_ != -1)
               {
                  _loc5_ += "<b raw_pre=\"*\" raw_post=\"*\">" + processText(_loc2_.substring(_loc3_ + 1,_loc4_)) + "</b>";
                  _loc3_ = _loc4_ + 1;
                  continue;
               }
            }
            if(_loc2_.charAt(_loc3_) == "_")
            {
               _loc4_ = int(_loc2_.indexOf("_",_loc3_ + 1));
               if(_loc4_ != -1)
               {
                  _loc5_ += "<i raw_pre=\"_\" raw_post=\"_\">" + processText(_loc2_.substring(_loc3_ + 1,_loc4_)) + "</i>";
                  _loc3_ = _loc4_ + 1;
                  continue;
               }
            }
            if(_loc2_.charAt(_loc3_) == "~")
            {
               _loc4_ = int(_loc2_.indexOf("~",_loc3_ + 1));
               if(_loc4_ != -1)
               {
                  _loc5_ += "<s raw_pre=\"~\" raw_post=\"~\">" + processText(_loc2_.substring(_loc3_ + 1,_loc4_)) + "</s>";
                  _loc3_ = _loc4_ + 1;
                  continue;
               }
            }
            _loc5_ += _loc2_.charAt(_loc3_);
            _loc3_ += 1;
         }
         return _loc5_;
      }
      
      internal static function logMsg(param1:String) : void
      {
         trace(param1);
      }
      
      internal static function logErrMsg(param1:String) : void
      {
         trace(param1);
      }
   }
}

