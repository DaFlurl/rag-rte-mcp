package com.as3xls.xls.formula
{
   import com.as3xls.biff.BIFFVersion;
   import com.as3xls.xls.Sheet;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class Formula
   {
      
      private var _alwaysRecalculate:Boolean;
      
      private var _tokens:ByteArray;
      
      private var dirty:Boolean;
      
      public var myRow:uint;
      
      private var sharedFormulaRow:uint;
      
      private var _sheet:Sheet;
      
      private var biffVer:uint;
      
      private var _formula:String;
      
      public var myCol:uint;
      
      private var isSharedFormula:Boolean;
      
      private var _result:*;
      
      private var sharedFormulaCol:uint;
      
      public function Formula(param1:uint, param2:uint, param3:ByteArray, param4:uint, param5:Sheet)
      {
         super();
         this.myRow = param1;
         this.myCol = param2;
         this._result = this.result;
         this._tokens = param3;
         this._tokens.endian = Endian.LITTLE_ENDIAN;
         this.biffVer = param4;
         this._sheet = param5;
         this._formula = "";
         this.isSharedFormula = false;
         this.dirty = true;
      }
      
      public function updateHumanReadable() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         this._tokens.position = 0;
         var _loc12_:Array = new Array();
         var _loc13_:Array = new Array();
         while(this._tokens.bytesAvailable > 0)
         {
            _loc1_ = this._tokens.readUnsignedByte();
            loop5:
            switch(_loc1_)
            {
               case Tokens.tExp:
                  _loc8_ = int(this._tokens.readUnsignedShort());
                  _loc9_ = this.biffVer == BIFFVersion.BIFF2 ? int(this._tokens.readUnsignedByte()) : int(this._tokens.readUnsignedShort());
                  this.sharedFormulaRow = _loc8_;
                  this.sharedFormulaCol = _loc9_;
                  if(this._sheet.getCell(_loc8_,_loc9_).sharedTokens == null)
                  {
                     return;
                  }
                  this._tokens = this._sheet.getCell(_loc8_,_loc9_).sharedTokens;
                  this.updateHumanReadable();
                  return;
                  break;
               case Tokens.tBool:
                  _loc2_ = this._tokens.readUnsignedByte() == 1;
                  _loc12_.push(_loc2_.toString().toUpperCase());
                  break;
               case Tokens.tNum:
                  _loc12_.push(this._tokens.readDouble());
                  break;
               case Tokens.tInt:
                  _loc12_.push(this._tokens.readUnsignedShort());
                  break;
               case Tokens.tStr:
                  _loc14_ = this._tokens.readUnsignedByte();
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     ++this._tokens.position;
                  }
                  _loc12_.push("\"" + this._tokens.readUTFBytes(_loc14_) + "\"");
                  break;
               case Tokens.tUplus:
                  _loc12_.push("+" + _loc12_.pop());
                  break;
               case Tokens.tUminus:
                  _loc12_.push("-" + _loc12_.pop());
                  break;
               case Tokens.tPercent:
                  _loc12_.push(_loc12_.pop() + "%");
                  break;
               case Tokens.tAdd:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "+" + _loc2_);
                  break;
               case Tokens.tSub:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "-" + _loc2_);
                  break;
               case Tokens.tMul:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "*" + _loc2_);
                  break;
               case Tokens.tDiv:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "/" + _loc2_);
                  break;
               case Tokens.tPower:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "^" + _loc2_);
                  break;
               case Tokens.tConcat:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push("\"" + _loc3_ + "\"" + "&" + "\"" + _loc2_ + "\"");
                  break;
               case Tokens.tParen:
                  _loc12_.push("(" + _loc12_.pop() + ")");
                  break;
               case Tokens.tLT:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "<" + _loc2_);
                  break;
               case Tokens.tLE:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "<=" + _loc2_);
                  break;
               case Tokens.tEQ:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "=" + _loc2_);
                  break;
               case Tokens.tGE:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + ">=" + _loc2_);
                  break;
               case Tokens.tGT:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + ">" + _loc2_);
                  break;
               case Tokens.tNE:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + "!=" + _loc2_);
                  break;
               case Tokens.tFuncR:
               case Tokens.tFuncV:
               case Tokens.tFuncA:
                  _loc4_ = this.biffVer <= BIFFVersion.BIFF3 ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort();
                  _loc7_ = new Array();
                  _loc6_ = uint(Functions.numArgs[_loc4_]);
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_)
                  {
                     _loc7_.push(_loc12_.pop());
                     _loc5_++;
                  }
                  _loc12_.push(Functions.names[_loc4_] + "(" + _loc7_.join(",") + ")");
                  break;
               case Tokens.tFuncVarR:
               case Tokens.tFuncVarV:
               case Tokens.tFuncVarA:
                  if(this.biffVer <= BIFFVersion.BIFF3)
                  {
                     _loc6_ = this._tokens.readUnsignedByte();
                     _loc4_ = this._tokens.readUnsignedByte();
                  }
                  else
                  {
                     _loc6_ = uint(this._tokens.readUnsignedByte() & 0x7F);
                     _loc4_ = uint(this._tokens.readUnsignedShort() & 0x7FFF);
                  }
                  _loc7_ = new Array();
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_)
                  {
                     _loc7_.push(_loc12_.pop());
                     _loc5_++;
                  }
                  _loc12_.push(Functions.names[_loc4_] + "(" + _loc7_.reverse().join(",") + ")");
                  break;
               case Tokens.tFuncCER:
               case Tokens.tFuncCEV:
               case Tokens.tFuncCEA:
                  _loc6_ = this._tokens.readUnsignedByte();
                  _loc4_ = this._tokens.readUnsignedByte();
                  _loc7_ = new Array();
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_)
                  {
                     _loc7_.push(_loc12_.pop());
                     _loc5_++;
                  }
                  _loc12_.push(Functions.names[_loc4_] + "(" + _loc7_.reverse().join(",") + ")");
                  break;
               case Tokens.tRefNR:
               case Tokens.tRefNV:
               case Tokens.tRefNA:
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     _loc8_ = this._tokens.readShort();
                     _loc9_ = this._tokens.readByte();
                     _loc17_ = this._tokens.readUnsignedByte();
                     if((_loc17_ & 0x80) != 0)
                     {
                        _loc8_ = this.myRow + _loc8_;
                     }
                     if((_loc17_ & 0x40) != 0)
                     {
                        _loc9_ = this.myCol + _loc9_;
                     }
                  }
                  else
                  {
                     _loc8_ = this._tokens.readShort() + 1;
                     _loc9_ = this._tokens.readByte();
                     if(_loc8_ & 32768 != 0)
                     {
                        _loc9_ = this.myCol + _loc9_;
                     }
                     if(_loc8_ & 16384 != 0)
                     {
                        _loc8_ = this.myRow + _loc8_;
                     }
                     _loc8_ &= 16383;
                  }
                  if(this.biffVer == BIFFVersion.BIFF5)
                  {
                     _loc8_--;
                  }
                  _loc12_.push(String.fromCharCode(_loc9_ + 65) + (_loc8_ + 1));
                  break;
               case Tokens.tRefR:
               case Tokens.tRefV:
               case Tokens.tRefA:
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     _loc8_ = int(this._tokens.readUnsignedShort());
                     _loc9_ = this._tokens.readUnsignedShort() & 0xFF;
                  }
                  else
                  {
                     _loc8_ = this._tokens.readShort() & 0x3FFF;
                     _loc9_ = this._tokens.readByte();
                  }
                  _loc12_.push(String.fromCharCode(_loc9_ + 65) + (_loc8_ + 1));
                  break;
               case Tokens.tAreaR:
               case Tokens.tAreaV:
               case Tokens.tAreaA:
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     _loc8_ = int(this._tokens.readUnsignedShort());
                     _loc10_ = int(this._tokens.readUnsignedShort());
                     _loc9_ = this._tokens.readUnsignedShort() & 0xFF;
                     _loc11_ = this._tokens.readUnsignedShort() & 0xFF;
                  }
                  else
                  {
                     _loc8_ = this._tokens.readUnsignedShort() & 0x3FFF;
                     _loc10_ = this._tokens.readUnsignedShort() & 0x3FFF;
                     _loc9_ = int(this._tokens.readUnsignedByte());
                     _loc11_ = int(this._tokens.readUnsignedByte());
                  }
                  _loc12_.push(String.fromCharCode(_loc9_ + 65) + (_loc8_ + 1) + ":" + String.fromCharCode(_loc11_ + 65) + (_loc10_ + 1));
                  break;
               case Tokens.tAttr:
                  _loc15_ = this._tokens.readUnsignedByte();
                  switch(_loc15_)
                  {
                     case 2:
                        _loc16_ = this.biffVer == BIFFVersion.BIFF2 ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort();
                        break loop5;
                     case 8:
                        _loc16_ = this.biffVer == BIFFVersion.BIFF2 ? uint(this._tokens.readUnsignedByte() + 1) : uint(this._tokens.readUnsignedShort() + 1);
                        break loop5;
                     case 16:
                        this._tokens.position += this.biffVer == BIFFVersion.BIFF2 ? 1 : 2;
                        _loc12_.push("SUM(" + _loc12_.pop() + ")");
                        break loop5;
                     case 64:
                        this._tokens.position += this.biffVer == BIFFVersion.BIFF2 ? 1 : 2;
                        break loop5;
                     default:
                        break loop5;
                  }
                  break;
               default:
                  _loc13_.push(_loc1_);
            }
         }
         if(_loc13_.length > 0)
         {
            throw new Error("Unknown formula tokens: " + _loc13_.join(", "));
         }
         this._formula = "=" + _loc12_.pop();
         this.dirty = false;
      }
      
      public function updateResult() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Array = null;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         if(this._tokens == null)
         {
            return;
         }
         this._tokens.position = 0;
         var _loc12_:Array = new Array();
         var _loc13_:Array = new Array();
         while(this._tokens.bytesAvailable > 0)
         {
            _loc1_ = this._tokens.readUnsignedByte();
            loop7:
            switch(_loc1_)
            {
               case Tokens.tExp:
                  _loc8_ = this._tokens.readUnsignedShort();
                  _loc9_ = this.biffVer == BIFFVersion.BIFF2 ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort();
                  this.sharedFormulaRow = _loc8_;
                  this.sharedFormulaCol = _loc9_;
                  if(this._sheet.getCell(_loc8_,_loc9_).sharedTokens == null)
                  {
                     return;
                  }
                  this._tokens = this._sheet.getCell(_loc8_,_loc9_).sharedTokens;
                  this.updateResult();
                  return;
                  break;
               case Tokens.tBool:
                  _loc12_.push(this._tokens.readUnsignedByte() == 1);
                  break;
               case Tokens.tNum:
                  _loc12_.push(this._tokens.readDouble());
                  break;
               case Tokens.tInt:
                  _loc12_.push(this._tokens.readUnsignedShort());
                  break;
               case Tokens.tStr:
                  _loc14_ = this._tokens.readUnsignedByte();
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     ++this._tokens.position;
                  }
                  _loc12_.push(this._tokens.readUTFBytes(_loc14_));
                  break;
               case Tokens.tUplus:
                  _loc12_.push(_loc12_.pop());
                  break;
               case Tokens.tUminus:
                  _loc12_.push(_loc12_.pop() * -1);
                  break;
               case Tokens.tPercent:
                  _loc12_.push(_loc12_.pop() / 100);
                  break;
               case Tokens.tAdd:
                  _loc12_.push(_loc12_.pop() + _loc12_.pop());
                  break;
               case Tokens.tSub:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ - _loc2_);
                  break;
               case Tokens.tMul:
                  _loc12_.push(_loc12_.pop() * _loc12_.pop());
                  break;
               case Tokens.tDiv:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ / _loc2_);
                  break;
               case Tokens.tPower:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(Math.pow(_loc3_,_loc2_));
                  break;
               case Tokens.tLT:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ < _loc2_);
                  break;
               case Tokens.tLE:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ <= _loc2_);
                  break;
               case Tokens.tEQ:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ == _loc2_);
                  break;
               case Tokens.tGE:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ >= _loc2_);
                  break;
               case Tokens.tGT:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ > _loc2_);
                  break;
               case Tokens.tNE:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ != _loc2_);
                  break;
               case Tokens.tConcat:
                  _loc2_ = _loc12_.pop();
                  _loc3_ = _loc12_.pop();
                  _loc12_.push(_loc3_ + _loc2_);
                  break;
               case Tokens.tParen:
                  break;
               case Tokens.tFuncR:
               case Tokens.tFuncV:
               case Tokens.tFuncA:
                  _loc4_ = this.biffVer <= BIFFVersion.BIFF3 ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort();
                  _loc6_ = uint(Functions.numArgs[_loc4_]);
                  _loc7_ = new Array();
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_)
                  {
                     _loc7_.push(_loc12_.pop());
                     _loc5_++;
                  }
                  _loc7_.push(_loc4_);
                  _loc12_.push(this.builtInFunction.apply(this,_loc7_.reverse()));
                  break;
               case Tokens.tFuncVarR:
               case Tokens.tFuncVarV:
               case Tokens.tFuncVarA:
                  if(this.biffVer <= BIFFVersion.BIFF3)
                  {
                     _loc6_ = this._tokens.readUnsignedByte();
                     _loc4_ = this._tokens.readUnsignedByte();
                  }
                  else
                  {
                     _loc6_ = uint(this._tokens.readUnsignedByte() & 0x7F);
                     _loc4_ = uint(this._tokens.readUnsignedShort() & 0x7FFF);
                  }
                  _loc7_ = new Array();
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_)
                  {
                     _loc7_.push(_loc12_.pop());
                     _loc5_++;
                  }
                  _loc7_.push(_loc4_);
                  _loc12_.push(this.builtInFunction.apply(this,_loc7_.reverse()));
                  break;
               case Tokens.tFuncCER:
               case Tokens.tFuncCEV:
               case Tokens.tFuncCEA:
                  _loc6_ = this._tokens.readUnsignedByte();
                  _loc4_ = this._tokens.readUnsignedByte();
                  _loc7_ = new Array();
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_)
                  {
                     _loc7_.push(_loc12_.pop());
                     _loc5_++;
                  }
                  _loc7_.push(_loc4_);
                  _loc12_.push(this.builtInFunction.apply(this,_loc7_.reverse()));
                  break;
               case Tokens.tRefNR:
               case Tokens.tRefNV:
               case Tokens.tRefNA:
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     _loc8_ = uint(this._tokens.readShort());
                     _loc9_ = uint(this._tokens.readByte());
                     _loc18_ = this._tokens.readUnsignedByte();
                     if((_loc18_ & 0x80) != 0)
                     {
                        _loc8_ = this.myRow + _loc8_;
                     }
                     if((_loc18_ & 0x40) != 0)
                     {
                        _loc9_ = this.myCol + _loc9_;
                     }
                  }
                  else
                  {
                     _loc8_ = uint(this._tokens.readShort() + 1);
                     _loc9_ = uint(this._tokens.readByte());
                     if(_loc8_ & 32768 != 0)
                     {
                        _loc9_ = this.myCol + _loc9_;
                     }
                     if(_loc8_ & 16384 != 0)
                     {
                        _loc8_ = this.myRow + _loc8_;
                     }
                     _loc8_ &= 16383;
                  }
                  if(this.biffVer == BIFFVersion.BIFF5)
                  {
                     _loc8_--;
                  }
                  _loc12_.push(this._sheet.getCell(_loc8_,_loc9_).value);
                  break;
               case Tokens.tRefR:
               case Tokens.tRefV:
               case Tokens.tRefA:
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     _loc8_ = this._tokens.readUnsignedShort();
                     _loc9_ = uint(this._tokens.readUnsignedShort() & 0xFF);
                  }
                  else
                  {
                     _loc8_ = uint(this._tokens.readShort() & 0x3FFF);
                     _loc9_ = uint(this._tokens.readByte());
                  }
                  _loc12_.push(this._sheet.getCell(_loc8_,_loc9_).value);
                  break;
               case Tokens.tAreaR:
               case Tokens.tAreaV:
               case Tokens.tAreaA:
                  if(this.biffVer == BIFFVersion.BIFF8)
                  {
                     _loc8_ = this._tokens.readUnsignedShort();
                     _loc10_ = this._tokens.readUnsignedShort();
                     _loc9_ = uint(this._tokens.readUnsignedShort() & 0xFF);
                     _loc11_ = uint(this._tokens.readUnsignedShort() & 0xFF);
                  }
                  else
                  {
                     _loc8_ = uint(this._tokens.readUnsignedShort() & 0x3FFF);
                     _loc10_ = uint(this._tokens.readUnsignedShort() & 0x3FFF);
                     _loc9_ = this._tokens.readUnsignedByte();
                     _loc11_ = this._tokens.readUnsignedByte();
                  }
                  _loc15_ = new Array();
                  _loc19_ = _loc8_;
                  while(_loc19_ <= _loc10_)
                  {
                     _loc15_[_loc19_ - _loc8_] = new Array();
                     _loc20_ = _loc9_;
                     while(_loc20_ <= _loc11_)
                     {
                        _loc15_[_loc19_ - _loc8_][_loc20_ - _loc9_] = this._sheet.getCell(_loc19_,_loc20_).value;
                        _loc20_++;
                     }
                     _loc19_++;
                  }
                  _loc12_.push(_loc15_);
                  break;
               case Tokens.tAttr:
                  _loc16_ = this._tokens.readUnsignedByte();
                  switch(_loc16_)
                  {
                     case 2:
                        _loc17_ = this.biffVer == BIFFVersion.BIFF2 ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort();
                        if(_loc12_.pop() == false)
                        {
                           this._tokens.position += _loc17_;
                        }
                        break loop7;
                     case 8:
                        _loc17_ = this.biffVer == BIFFVersion.BIFF2 ? uint(this._tokens.readUnsignedByte() + 1) : uint(this._tokens.readUnsignedShort() + 1);
                        this._tokens.position += _loc17_;
                        break loop7;
                     case 16:
                        this._tokens.position += this.biffVer == BIFFVersion.BIFF2 ? 1 : 2;
                        _loc12_.push(this.builtInSum(this.convertToArray(_loc12_.pop())));
                        break loop7;
                     case 64:
                        this._tokens.position += this.biffVer == BIFFVersion.BIFF2 ? 1 : 2;
                        break loop7;
                     default:
                        break loop7;
                  }
                  break;
               default:
                  _loc13_.push(_loc1_);
            }
         }
         if(_loc13_.length > 0)
         {
            throw new Error("Unknown formula tokens: " + _loc13_.join(", "));
         }
         this._result = _loc12_.pop();
      }
      
      private function builtInSum(param1:Array) : Number
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = Number(param1[_loc3_]);
            _loc2_ += _loc4_;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get result() : *
      {
         this.updateResult();
         return this._result;
      }
      
      public function get formula() : String
      {
         if(this.dirty)
         {
            this.updateHumanReadable();
         }
         return this._formula;
      }
      
      private function convertToArray(param1:*) : Array
      {
         var _loc3_:uint = 0;
         var _loc2_:Array = new Array();
         if(param1 is Array)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ = _loc2_.concat(this.convertToArray(param1[_loc3_]));
               _loc3_++;
            }
         }
         else
         {
            _loc2_ = [param1];
         }
         return _loc2_;
      }
      
      public function set result(param1:*) : void
      {
         this._result = param1;
      }
      
      private function builtInFunction(param1:uint, ... rest) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         switch(param1)
         {
            case 0:
               return this.convertToArray(rest).length;
            case 1:
               return Boolean(rest[0]) ? rest[1] : rest[2];
            case 4:
               _loc3_ = 0;
               _loc4_ = this.convertToArray(rest);
               _loc11_ = 0;
               while(_loc11_ < _loc4_.length)
               {
                  _loc3_ += _loc4_[_loc11_];
                  _loc11_++;
               }
               return _loc3_;
            case 5:
               _loc4_ = this.convertToArray(rest);
               return this.builtInSum(_loc4_) / _loc4_.length;
            case 6:
               return Math.min.apply(null,this.convertToArray(rest));
            case 7:
               return Math.max.apply(null,this.convertToArray(rest));
            case 15:
               return Math.sin(rest[0]);
            case 16:
               return Math.cos(rest[0]);
            case 17:
               return Math.tan(rest[0]);
            case 18:
               return Math.atan(rest[0]);
            case 19:
               return Math.PI;
            case 20:
               return Math.sqrt(rest[0]);
            case 21:
               return Math.exp(rest[0]);
            case 22:
               return Math.log(rest[0]) / Math.LOG10E;
            case 23:
               return Math.log(rest[0]);
            case 24:
               return Math.abs(rest[0]);
            case 25:
               return Math.round(rest[0]);
            case 30:
               _loc6_ = String(rest[0]);
               _loc7_ = Number(rest[1]);
               _loc3_ = "";
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc3_ += _loc6_;
                  _loc5_++;
               }
               return _loc3_;
            case 31:
               return String(rest[0]).substr(Number(rest[1]),Number(rest[2]));
            case 32:
               return String(rest[0]).length;
            case 34:
               return true;
            case 35:
               return false;
            case 36:
               _loc5_ = 0;
               while(_loc5_ < rest.length)
               {
                  if(Boolean(rest[_loc5_]) == false)
                  {
                     return false;
                  }
                  _loc5_++;
               }
               return true;
            case 37:
               _loc5_ = 0;
               while(_loc5_ < rest.length)
               {
                  if(Boolean(rest[_loc5_]) == true)
                  {
                     return true;
                  }
                  _loc5_++;
               }
               return false;
            case 38:
               return !Boolean(rest[0]);
            case 39:
               return Number(rest[0]) % Number(rest[1]);
            case 56:
               _loc8_ = Number(rest[0]);
               _loc9_ = Number(rest[1]);
               _loc10_ = Number(rest[2]);
               return -_loc10_ * ((Math.pow(1 + _loc8_,_loc9_) - 1) / _loc8_) / Math.pow(1 + _loc8_,_loc9_);
            case 63:
               return Math.random();
            case 97:
               return Math.atan2(Number(rest[0]),Number(rest[1]));
            case 98:
               return Math.asin(Number(rest[0]));
            case 99:
               return Math.acos(Number(rest[0]));
            case 109:
               return Math.log(rest[0]);
            case 111:
               return String.fromCharCode(rest[0]);
            case 112:
               return String(rest[0]).toLowerCase();
            case 113:
               return String(rest[0]).toUpperCase();
            case 115:
               return String(rest[0]).substr(0,Number(rest[1]));
            case 116:
               return String(rest[0]).substr(String(rest[0]).length - Number(rest[1]),Number(rest[1]));
            default:
               throw new Error("Unsupported function: " + param1);
         }
      }
   }
}

