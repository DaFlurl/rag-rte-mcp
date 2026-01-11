// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.xls.formula.Formula

package com.as3xls.xls.formula
{
    import flash.utils.ByteArray;
    import com.as3xls.xls.Sheet;
    import flash.utils.Endian;
    import com.as3xls.biff.BIFFVersion;

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

        public function Formula(_arg_1:uint, _arg_2:uint, _arg_3:ByteArray, _arg_4:uint, _arg_5:Sheet)
        {
            this.myRow = _arg_1;
            this.myCol = _arg_2;
            this._result = this.result;
            this._tokens = _arg_3;
            this._tokens.endian = Endian.LITTLE_ENDIAN;
            this.biffVer = _arg_4;
            this._sheet = _arg_5;
            this._formula = "";
            this.isSharedFormula = false;
            this.dirty = true;
        }

        public function updateHumanReadable():void
        {
            var _local_1:uint;
            var _local_2:*;
            var _local_3:*;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:Array;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_14:uint;
            var _local_15:uint;
            var _local_16:uint;
            var _local_17:uint;
            this._tokens.position = 0;
            var _local_12:Array = new Array();
            var _local_13:Array = new Array();
            while (this._tokens.bytesAvailable > 0)
            {
                _local_1 = this._tokens.readUnsignedByte();
                switch (_local_1)
                {
                    case Tokens.tExp:
                        _local_8 = this._tokens.readUnsignedShort();
                        _local_9 = ((this.biffVer == BIFFVersion.BIFF2) ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort());
                        this.sharedFormulaRow = _local_8;
                        this.sharedFormulaCol = _local_9;
                        if (this._sheet.getCell(_local_8, _local_9).sharedTokens == null)
                        {
                            return;
                        };
                        this._tokens = this._sheet.getCell(_local_8, _local_9).sharedTokens;
                        this.updateHumanReadable();
                        return;
                    case Tokens.tBool:
                        _local_2 = (this._tokens.readUnsignedByte() == 1);
                        _local_12.push(_local_2.toString().toUpperCase());
                        break;
                    case Tokens.tNum:
                        _local_12.push(this._tokens.readDouble());
                        break;
                    case Tokens.tInt:
                        _local_12.push(this._tokens.readUnsignedShort());
                        break;
                    case Tokens.tStr:
                        _local_14 = this._tokens.readUnsignedByte();
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            this._tokens.position++;
                        };
                        _local_12.push((('"' + this._tokens.readUTFBytes(_local_14)) + '"'));
                        break;
                    case Tokens.tUplus:
                        _local_12.push(("+" + _local_12.pop()));
                        break;
                    case Tokens.tUminus:
                        _local_12.push(("-" + _local_12.pop()));
                        break;
                    case Tokens.tPercent:
                        _local_12.push((_local_12.pop() + "%"));
                        break;
                    case Tokens.tAdd:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "+") + _local_2));
                        break;
                    case Tokens.tSub:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "-") + _local_2));
                        break;
                    case Tokens.tMul:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "*") + _local_2));
                        break;
                    case Tokens.tDiv:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "/") + _local_2));
                        break;
                    case Tokens.tPower:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "^") + _local_2));
                        break;
                    case Tokens.tConcat:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((((((('"' + _local_3) + '"') + "&") + '"') + _local_2) + '"'));
                        break;
                    case Tokens.tParen:
                        _local_12.push((("(" + _local_12.pop()) + ")"));
                        break;
                    case Tokens.tLT:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "<") + _local_2));
                        break;
                    case Tokens.tLE:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "<=") + _local_2));
                        break;
                    case Tokens.tEQ:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "=") + _local_2));
                        break;
                    case Tokens.tGE:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + ">=") + _local_2));
                        break;
                    case Tokens.tGT:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + ">") + _local_2));
                        break;
                    case Tokens.tNE:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(((_local_3 + "!=") + _local_2));
                        break;
                    case Tokens.tFuncR:
                    case Tokens.tFuncV:
                    case Tokens.tFuncA:
                        _local_4 = ((this.biffVer <= BIFFVersion.BIFF3) ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort());
                        _local_7 = new Array();
                        _local_6 = Functions.numArgs[_local_4];
                        _local_5 = 0;
                        while (_local_5 < _local_6)
                        {
                            _local_7.push(_local_12.pop());
                            _local_5++;
                        };
                        _local_12.push((((Functions.names[_local_4] + "(") + _local_7.join(",")) + ")"));
                        break;
                    case Tokens.tFuncVarR:
                    case Tokens.tFuncVarV:
                    case Tokens.tFuncVarA:
                        if (this.biffVer <= BIFFVersion.BIFF3)
                        {
                            _local_6 = this._tokens.readUnsignedByte();
                            _local_4 = this._tokens.readUnsignedByte();
                        }
                        else
                        {
                            _local_6 = (this._tokens.readUnsignedByte() & 0x7F);
                            _local_4 = (this._tokens.readUnsignedShort() & 0x7FFF);
                        };
                        _local_7 = new Array();
                        _local_5 = 0;
                        while (_local_5 < _local_6)
                        {
                            _local_7.push(_local_12.pop());
                            _local_5++;
                        };
                        _local_12.push((((Functions.names[_local_4] + "(") + _local_7.reverse().join(",")) + ")"));
                        break;
                    case Tokens.tFuncCER:
                    case Tokens.tFuncCEV:
                    case Tokens.tFuncCEA:
                        _local_6 = this._tokens.readUnsignedByte();
                        _local_4 = this._tokens.readUnsignedByte();
                        _local_7 = new Array();
                        _local_5 = 0;
                        while (_local_5 < _local_6)
                        {
                            _local_7.push(_local_12.pop());
                            _local_5++;
                        };
                        _local_12.push((((Functions.names[_local_4] + "(") + _local_7.reverse().join(",")) + ")"));
                        break;
                    case Tokens.tRefNR:
                    case Tokens.tRefNV:
                    case Tokens.tRefNA:
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            _local_8 = this._tokens.readShort();
                            _local_9 = this._tokens.readByte();
                            _local_17 = this._tokens.readUnsignedByte();
                            if ((_local_17 & 0x80) != 0)
                            {
                                _local_8 = (this.myRow + _local_8);
                            };
                            if ((_local_17 & 0x40) != 0)
                            {
                                _local_9 = (this.myCol + _local_9);
                            };
                        }
                        else
                        {
                            _local_8 = (this._tokens.readShort() + 1);
                            _local_9 = this._tokens.readByte();
                            if ((_local_8 & (!(0x8000 == 0))))
                            {
                                _local_9 = (this.myCol + _local_9);
                            };
                            if ((_local_8 & (!(0x4000 == 0))))
                            {
                                _local_8 = (this.myRow + _local_8);
                            };
                            _local_8 = (_local_8 & 0x3FFF);
                        };
                        if (this.biffVer == BIFFVersion.BIFF5)
                        {
                            _local_8--;
                        };
                        _local_12.push((String.fromCharCode((_local_9 + 65)) + (_local_8 + 1)));
                        break;
                    case Tokens.tRefR:
                    case Tokens.tRefV:
                    case Tokens.tRefA:
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            _local_8 = this._tokens.readUnsignedShort();
                            _local_9 = (this._tokens.readUnsignedShort() & 0xFF);
                        }
                        else
                        {
                            _local_8 = (this._tokens.readShort() & 0x3FFF);
                            _local_9 = this._tokens.readByte();
                        };
                        _local_12.push((String.fromCharCode((_local_9 + 65)) + (_local_8 + 1)));
                        break;
                    case Tokens.tAreaR:
                    case Tokens.tAreaV:
                    case Tokens.tAreaA:
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            _local_8 = this._tokens.readUnsignedShort();
                            _local_10 = this._tokens.readUnsignedShort();
                            _local_9 = (this._tokens.readUnsignedShort() & 0xFF);
                            _local_11 = (this._tokens.readUnsignedShort() & 0xFF);
                        }
                        else
                        {
                            _local_8 = (this._tokens.readUnsignedShort() & 0x3FFF);
                            _local_10 = (this._tokens.readUnsignedShort() & 0x3FFF);
                            _local_9 = this._tokens.readUnsignedByte();
                            _local_11 = this._tokens.readUnsignedByte();
                        };
                        _local_12.push(((((String.fromCharCode((_local_9 + 65)) + (_local_8 + 1)) + ":") + String.fromCharCode((_local_11 + 65))) + (_local_10 + 1)));
                        break;
                    case Tokens.tAttr:
                        _local_15 = this._tokens.readUnsignedByte();
                        switch (_local_15)
                        {
                            case 2:
                                _local_16 = ((this.biffVer == BIFFVersion.BIFF2) ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort());
                                break;
                            case 8:
                                _local_16 = ((this.biffVer == BIFFVersion.BIFF2) ? (this._tokens.readUnsignedByte() + 1) : (this._tokens.readUnsignedShort() + 1));
                                break;
                            case 16:
                                this._tokens.position = (this._tokens.position + ((this.biffVer == BIFFVersion.BIFF2) ? 1 : 2));
                                _local_12.push((("SUM(" + _local_12.pop()) + ")"));
                                break;
                            case 64:
                                this._tokens.position = (this._tokens.position + ((this.biffVer == BIFFVersion.BIFF2) ? 1 : 2));
                                break;
                        };
                        break;
                    default:
                        _local_13.push(_local_1);
                };
            };
            if (_local_13.length > 0)
            {
                throw (new Error(("Unknown formula tokens: " + _local_13.join(", "))));
            };
            this._formula = ("=" + _local_12.pop());
            this.dirty = false;
        }

        public function updateResult():void
        {
            var _local_1:uint;
            var _local_2:*;
            var _local_3:*;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:Array;
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:uint;
            var _local_11:uint;
            var _local_14:uint;
            var _local_15:Array;
            var _local_16:uint;
            var _local_17:uint;
            var _local_18:uint;
            var _local_19:uint;
            var _local_20:uint;
            if (this._tokens == null)
            {
                return;
            };
            this._tokens.position = 0;
            var _local_12:Array = new Array();
            var _local_13:Array = new Array();
            while (this._tokens.bytesAvailable > 0)
            {
                _local_1 = this._tokens.readUnsignedByte();
                switch (_local_1)
                {
                    case Tokens.tExp:
                        _local_8 = this._tokens.readUnsignedShort();
                        _local_9 = ((this.biffVer == BIFFVersion.BIFF2) ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort());
                        this.sharedFormulaRow = _local_8;
                        this.sharedFormulaCol = _local_9;
                        if (this._sheet.getCell(_local_8, _local_9).sharedTokens == null)
                        {
                            return;
                        };
                        this._tokens = this._sheet.getCell(_local_8, _local_9).sharedTokens;
                        this.updateResult();
                        return;
                    case Tokens.tBool:
                        _local_12.push((this._tokens.readUnsignedByte() == 1));
                        break;
                    case Tokens.tNum:
                        _local_12.push(this._tokens.readDouble());
                        break;
                    case Tokens.tInt:
                        _local_12.push(this._tokens.readUnsignedShort());
                        break;
                    case Tokens.tStr:
                        _local_14 = this._tokens.readUnsignedByte();
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            this._tokens.position++;
                        };
                        _local_12.push(this._tokens.readUTFBytes(_local_14));
                        break;
                    case Tokens.tUplus:
                        _local_12.push(_local_12.pop());
                        break;
                    case Tokens.tUminus:
                        _local_12.push((_local_12.pop() * -1));
                        break;
                    case Tokens.tPercent:
                        _local_12.push((_local_12.pop() / 100));
                        break;
                    case Tokens.tAdd:
                        _local_12.push((_local_12.pop() + _local_12.pop()));
                        break;
                    case Tokens.tSub:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 - _local_2));
                        break;
                    case Tokens.tMul:
                        _local_12.push((_local_12.pop() * _local_12.pop()));
                        break;
                    case Tokens.tDiv:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 / _local_2));
                        break;
                    case Tokens.tPower:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push(Math.pow(_local_3, _local_2));
                        break;
                    case Tokens.tLT:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 < _local_2));
                        break;
                    case Tokens.tLE:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 <= _local_2));
                        break;
                    case Tokens.tEQ:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 == _local_2));
                        break;
                    case Tokens.tGE:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 >= _local_2));
                        break;
                    case Tokens.tGT:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 > _local_2));
                        break;
                    case Tokens.tNE:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((!(_local_3 == _local_2)));
                        break;
                    case Tokens.tConcat:
                        _local_2 = _local_12.pop();
                        _local_3 = _local_12.pop();
                        _local_12.push((_local_3 + _local_2));
                        break;
                    case Tokens.tParen:
                        break;
                    case Tokens.tFuncR:
                    case Tokens.tFuncV:
                    case Tokens.tFuncA:
                        _local_4 = ((this.biffVer <= BIFFVersion.BIFF3) ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort());
                        _local_6 = Functions.numArgs[_local_4];
                        _local_7 = new Array();
                        _local_5 = 0;
                        while (_local_5 < _local_6)
                        {
                            _local_7.push(_local_12.pop());
                            _local_5++;
                        };
                        _local_7.push(_local_4);
                        _local_12.push(this.builtInFunction.apply(this, _local_7.reverse()));
                        break;
                    case Tokens.tFuncVarR:
                    case Tokens.tFuncVarV:
                    case Tokens.tFuncVarA:
                        if (this.biffVer <= BIFFVersion.BIFF3)
                        {
                            _local_6 = this._tokens.readUnsignedByte();
                            _local_4 = this._tokens.readUnsignedByte();
                        }
                        else
                        {
                            _local_6 = (this._tokens.readUnsignedByte() & 0x7F);
                            _local_4 = (this._tokens.readUnsignedShort() & 0x7FFF);
                        };
                        _local_7 = new Array();
                        _local_5 = 0;
                        while (_local_5 < _local_6)
                        {
                            _local_7.push(_local_12.pop());
                            _local_5++;
                        };
                        _local_7.push(_local_4);
                        _local_12.push(this.builtInFunction.apply(this, _local_7.reverse()));
                        break;
                    case Tokens.tFuncCER:
                    case Tokens.tFuncCEV:
                    case Tokens.tFuncCEA:
                        _local_6 = this._tokens.readUnsignedByte();
                        _local_4 = this._tokens.readUnsignedByte();
                        _local_7 = new Array();
                        _local_5 = 0;
                        while (_local_5 < _local_6)
                        {
                            _local_7.push(_local_12.pop());
                            _local_5++;
                        };
                        _local_7.push(_local_4);
                        _local_12.push(this.builtInFunction.apply(this, _local_7.reverse()));
                        break;
                    case Tokens.tRefNR:
                    case Tokens.tRefNV:
                    case Tokens.tRefNA:
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            _local_8 = this._tokens.readShort();
                            _local_9 = this._tokens.readByte();
                            _local_18 = this._tokens.readUnsignedByte();
                            if ((_local_18 & 0x80) != 0)
                            {
                                _local_8 = (this.myRow + _local_8);
                            };
                            if ((_local_18 & 0x40) != 0)
                            {
                                _local_9 = (this.myCol + _local_9);
                            };
                        }
                        else
                        {
                            _local_8 = (this._tokens.readShort() + 1);
                            _local_9 = this._tokens.readByte();
                            if ((_local_8 & (!(0x8000 == 0))))
                            {
                                _local_9 = (this.myCol + _local_9);
                            };
                            if ((_local_8 & (!(0x4000 == 0))))
                            {
                                _local_8 = (this.myRow + _local_8);
                            };
                            _local_8 = (_local_8 & 0x3FFF);
                        };
                        if (this.biffVer == BIFFVersion.BIFF5)
                        {
                            _local_8--;
                        };
                        _local_12.push(this._sheet.getCell(_local_8, _local_9).value);
                        break;
                    case Tokens.tRefR:
                    case Tokens.tRefV:
                    case Tokens.tRefA:
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            _local_8 = this._tokens.readUnsignedShort();
                            _local_9 = (this._tokens.readUnsignedShort() & 0xFF);
                        }
                        else
                        {
                            _local_8 = (this._tokens.readShort() & 0x3FFF);
                            _local_9 = this._tokens.readByte();
                        };
                        _local_12.push(this._sheet.getCell(_local_8, _local_9).value);
                        break;
                    case Tokens.tAreaR:
                    case Tokens.tAreaV:
                    case Tokens.tAreaA:
                        if (this.biffVer == BIFFVersion.BIFF8)
                        {
                            _local_8 = this._tokens.readUnsignedShort();
                            _local_10 = this._tokens.readUnsignedShort();
                            _local_9 = (this._tokens.readUnsignedShort() & 0xFF);
                            _local_11 = (this._tokens.readUnsignedShort() & 0xFF);
                        }
                        else
                        {
                            _local_8 = (this._tokens.readUnsignedShort() & 0x3FFF);
                            _local_10 = (this._tokens.readUnsignedShort() & 0x3FFF);
                            _local_9 = this._tokens.readUnsignedByte();
                            _local_11 = this._tokens.readUnsignedByte();
                        };
                        _local_15 = new Array();
                        _local_19 = _local_8;
                        while (_local_19 <= _local_10)
                        {
                            _local_15[(_local_19 - _local_8)] = new Array();
                            _local_20 = _local_9;
                            while (_local_20 <= _local_11)
                            {
                                _local_15[(_local_19 - _local_8)][(_local_20 - _local_9)] = this._sheet.getCell(_local_19, _local_20).value;
                                _local_20++;
                            };
                            _local_19++;
                        };
                        _local_12.push(_local_15);
                        break;
                    case Tokens.tAttr:
                        _local_16 = this._tokens.readUnsignedByte();
                        switch (_local_16)
                        {
                            case 2:
                                _local_17 = ((this.biffVer == BIFFVersion.BIFF2) ? this._tokens.readUnsignedByte() : this._tokens.readUnsignedShort());
                                if (_local_12.pop() == false)
                                {
                                    this._tokens.position = (this._tokens.position + _local_17);
                                };
                                break;
                            case 8:
                                _local_17 = ((this.biffVer == BIFFVersion.BIFF2) ? (this._tokens.readUnsignedByte() + 1) : (this._tokens.readUnsignedShort() + 1));
                                this._tokens.position = (this._tokens.position + _local_17);
                                break;
                            case 16:
                                this._tokens.position = (this._tokens.position + ((this.biffVer == BIFFVersion.BIFF2) ? 1 : 2));
                                _local_12.push(this.builtInSum(this.convertToArray(_local_12.pop())));
                                break;
                            case 64:
                                this._tokens.position = (this._tokens.position + ((this.biffVer == BIFFVersion.BIFF2) ? 1 : 2));
                                break;
                        };
                        break;
                    default:
                        _local_13.push(_local_1);
                };
            };
            if (_local_13.length > 0)
            {
                throw (new Error(("Unknown formula tokens: " + _local_13.join(", "))));
            };
            this._result = _local_12.pop();
        }

        private function builtInSum(_arg_1:Array):Number
        {
            var _local_4:Number;
            var _local_2:Number = 0;
            var _local_3:uint;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = Number(_arg_1[_local_3]);
                _local_2 = (_local_2 + _local_4);
                _local_3++;
            };
            return (_local_2);
        }

        public function get result():*
        {
            this.updateResult();
            return (this._result);
        }

        public function get formula():String
        {
            if (this.dirty)
            {
                this.updateHumanReadable();
            };
            return (this._formula);
        }

        private function convertToArray(_arg_1:*):Array
        {
            var _local_3:uint;
            var _local_2:Array = new Array();
            if ((_arg_1 is Array))
            {
                _local_3 = 0;
                while (_local_3 < _arg_1.length)
                {
                    _local_2 = _local_2.concat(this.convertToArray(_arg_1[_local_3]));
                    _local_3++;
                };
            }
            else
            {
                _local_2 = [_arg_1];
            };
            return (_local_2);
        }

        public function set result(_arg_1:*):void
        {
            this._result = _arg_1;
        }

        private function builtInFunction(_arg_1:uint, ... _args):*
        {
            var _local_3:*;
            var _local_4:Array;
            var _local_5:Number;
            var _local_6:String;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:uint;
            switch (_arg_1)
            {
                case 0:
                    return (this.convertToArray(_args).length);
                case 1:
                    return ((Boolean(_args[0])) ? _args[1] : _args[2]);
                case 4:
                    _local_3 = 0;
                    _local_4 = this.convertToArray(_args);
                    _local_11 = 0;
                    while (_local_11 < _local_4.length)
                    {
                        _local_3 = (_local_3 + _local_4[_local_11]);
                        _local_11++;
                    };
                    return (_local_3);
                case 5:
                    _local_4 = this.convertToArray(_args);
                    return (this.builtInSum(_local_4) / _local_4.length);
                case 6:
                    return (Math.min.apply(null, this.convertToArray(_args)));
                case 7:
                    return (Math.max.apply(null, this.convertToArray(_args)));
                case 15:
                    return (Math.sin(_args[0]));
                case 16:
                    return (Math.cos(_args[0]));
                case 17:
                    return (Math.tan(_args[0]));
                case 18:
                    return (Math.atan(_args[0]));
                case 19:
                    return (Math.PI);
                case 20:
                    return (Math.sqrt(_args[0]));
                case 21:
                    return (Math.exp(_args[0]));
                case 22:
                    return (Math.log(_args[0]) / Math.LOG10E);
                case 23:
                    return (Math.log(_args[0]));
                case 24:
                    return (Math.abs(_args[0]));
                case 25:
                    return (Math.round(_args[0]));
                case 30:
                    _local_6 = String(_args[0]);
                    _local_7 = Number(_args[1]);
                    _local_3 = "";
                    _local_5 = 0;
                    while (_local_5 < _local_7)
                    {
                        _local_3 = (_local_3 + _local_6);
                        _local_5++;
                    };
                    return (_local_3);
                case 31:
                    return (String(_args[0]).substr(Number(_args[1]), Number(_args[2])));
                case 32:
                    return (String(_args[0]).length);
                case 34:
                    return (true);
                case 35:
                    return (false);
                case 36:
                    _local_5 = 0;
                    while (_local_5 < _args.length)
                    {
                        if (Boolean(_args[_local_5]) == false)
                        {
                            return (false);
                        };
                        _local_5++;
                    };
                    return (true);
                case 37:
                    _local_5 = 0;
                    while (_local_5 < _args.length)
                    {
                        if (Boolean(_args[_local_5]) == true)
                        {
                            return (true);
                        };
                        _local_5++;
                    };
                    return (false);
                case 38:
                    return (!(Boolean(_args[0])));
                case 39:
                    return (Number(_args[0]) % Number(_args[1]));
                case 56:
                    _local_8 = Number(_args[0]);
                    _local_9 = Number(_args[1]);
                    _local_10 = Number(_args[2]);
                    return ((-(_local_10) * ((Math.pow((1 + _local_8), _local_9) - 1) / _local_8)) / Math.pow((1 + _local_8), _local_9));
                case 63:
                    return (Math.random());
                case 97:
                    return (Math.atan2(Number(_args[0]), Number(_args[1])));
                case 98:
                    return (Math.asin(Number(_args[0])));
                case 99:
                    return (Math.acos(Number(_args[0])));
                case 109:
                    return (Math.log(_args[0]));
                case 111:
                    return (String.fromCharCode(_args[0]));
                case 112:
                    return (String(_args[0]).toLowerCase());
                case 113:
                    return (String(_args[0]).toUpperCase());
                case 115:
                    return (String(_args[0]).substr(0, Number(_args[1])));
                case 116:
                    return (String(_args[0]).substr((String(_args[0]).length - Number(_args[1])), Number(_args[1])));
                default:
                    throw (new Error(("Unsupported function: " + _arg_1)));
            };
        }


    }
}//package com.as3xls.xls.formula

