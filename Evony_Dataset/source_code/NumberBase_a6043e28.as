// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.formatters.NumberBase

package mx.formatters
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NumberBase 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var thousandsSeparatorTo:String;
        public var decimalSeparatorTo:String;
        public var isValid:Boolean = false;
        public var thousandsSeparatorFrom:String;
        public var decimalSeparatorFrom:String;

        public function NumberBase(_arg_1:String=".", _arg_2:String=",", _arg_3:String=".", _arg_4:String=",")
        {
            this.decimalSeparatorFrom = _arg_1;
            this.thousandsSeparatorFrom = _arg_2;
            this.decimalSeparatorTo = _arg_3;
            this.thousandsSeparatorTo = _arg_4;
            isValid = true;
        }

        public function formatThousands(_arg_1:String):String
        {
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:Array;
            var _local_12:int;
            var _local_2:Number = Number(_arg_1);
            var _local_3:* = (_local_2 < 0);
            var _local_4:String = Math.abs(_local_2).toString();
            _local_4.toLowerCase();
            var _local_5:int = _local_4.indexOf("e");
            if (_local_5 != -1)
            {
                _local_4 = expandExponents(_local_4);
            };
            var _local_6:Array = _local_4.split(((_local_4.indexOf(decimalSeparatorTo) != -1) ? decimalSeparatorTo : "."));
            var _local_7:int = String(_local_6[0]).length;
            if (_local_7 > 3)
            {
                _local_8 = int(int(Math.floor((_local_7 / 3))));
                if ((_local_7 % 3) == 0)
                {
                    _local_8--;
                };
                _local_9 = _local_7;
                _local_10 = (_local_9 - 3);
                _local_11 = [];
                _local_12 = 0;
                while (_local_12 <= _local_8)
                {
                    _local_11[_local_12] = _local_6[0].slice(_local_10, _local_9);
                    _local_10 = int(Math.max((_local_10 - 3), 0));
                    _local_9 = int(Math.max((_local_9 - 3), 1));
                    _local_12++;
                };
                _local_11.reverse();
                _local_6[0] = _local_11.join(thousandsSeparatorTo);
            };
            _local_4 = _local_6.join(decimalSeparatorTo);
            if (_local_3)
            {
                _local_4 = ("-" + _local_4);
            };
            return (_local_4.toString());
        }

        public function formatDecimal(_arg_1:String):String
        {
            var _local_2:Array = _arg_1.split(".");
            return (_local_2.join(decimalSeparatorTo));
        }

        public function parseNumberString(_arg_1:String):String
        {
            var _local_5:String;
            var _local_6:String;
            var _local_8:String;
            var _local_9:int;
            var _local_10:Number;
            var _local_2:Array = _arg_1.split(decimalSeparatorFrom);
            if (_local_2.length > 2)
            {
                return (null);
            };
            var _local_3:int = _arg_1.length;
            var _local_4:int;
            var _local_7:Boolean;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1.charAt(_local_4);
                _local_4++;
                if (((("0" <= _local_5) && (_local_5 <= "9")) || (_local_5 == decimalSeparatorFrom)))
                {
                    _local_8 = _arg_1.charAt((_local_4 - 2));
                    if (((_local_8 == "-") || (_arg_1.charAt(0) == "-")))
                    {
                        _local_7 = true;
                    };
                    _local_6 = "";
                    _local_9 = --_local_4;
                    while (_local_9 < _local_3)
                    {
                        _local_5 = _arg_1.charAt(_local_4);
                        _local_4++;
                        if ((("0" <= _local_5) && (_local_5 <= "9")))
                        {
                            _local_6 = (_local_6 + _local_5);
                        }
                        else
                        {
                            if (_local_5 == decimalSeparatorFrom)
                            {
                                _local_6 = (_local_6 + ".");
                            }
                            else
                            {
                                if (((!(_local_5 == thousandsSeparatorFrom)) || (_local_4 >= _local_3))) break;
                            };
                        };
                        _local_9++;
                    };
                };
            };
            if (((!(_local_6 == null)) && (!(_arg_1 == ""))))
            {
                _local_10 = Number(_local_6);
                if (_local_10 == 0)
                {
                    return ("0");
                };
            };
            if (_local_6)
            {
                if (_local_6.charAt((_local_6.length - 1)) == ".")
                {
                    if (_local_6.length >= 2)
                    {
                        _local_6 = _local_6.substring(0, (_local_6.length - 1));
                    }
                    else
                    {
                        if (_local_6.length == 1)
                        {
                            _local_6 = "";
                            _local_7 = false;
                        };
                    };
                };
            };
            return ((_local_7) ? ("-" + _local_6) : _local_6);
        }

        public function formatPrecision(_arg_1:String, _arg_2:int):String
        {
            var _local_4:String;
            var _local_5:String;
            if (_arg_2 == -1)
            {
                return (_arg_1);
            };
            var _local_3:Array = _arg_1.split(decimalSeparatorTo);
            _local_3[0] = ((_local_3[0].length == 0) ? "0" : _local_3[0]);
            if (_arg_2 > 0)
            {
                _local_4 = ((_local_3[1]) ? String(_local_3[1]) : "");
                _local_5 = (_local_4 + "000000000000000000000000000000000");
                _arg_1 = ((_local_3[0] + decimalSeparatorTo) + _local_5.substr(0, _arg_2));
            }
            else
            {
                _arg_1 = String(_local_3[0]);
            };
            return (_arg_1.toString());
        }

        public function expandExponents(_arg_1:String):String
        {
            var _local_10:Number;
            var _local_11:Number;
            var _local_2:RegExp = /^([+-])?(\d+).?(\d*)[eE]([-+]?\d+)$/;
            var _local_3:Array = _local_2.exec(_arg_1);
            var _local_4:String = _local_3[1];
            var _local_5:String = _local_3[2];
            var _local_6:String = _local_3[3];
            var _local_7:int = int(_local_3[4]);
            if (!_local_7)
            {
                return ((((_local_4) ? _local_4 : "") + ((_local_5) ? _local_5 : "0")) + ((_local_6) ? ("." + _local_6) : ""));
            };
            var _local_8:String = (_local_5 + _local_6);
            var _local_9:* = (_local_7 < 0);
            if (_local_9)
            {
                _local_10 = ((-1 * (_local_5.length + _local_7)) + 1);
                return (((((_local_4) ? _local_4 : "") + "0.") + new Array(_local_10).join("0")) + _local_8);
            };
            _local_11 = (_local_7 + _local_5.length);
            if (_local_11 >= _local_8.length)
            {
                return ((((_local_4) ? _local_4 : "") + _local_8) + new Array(((_local_11 - _local_8.length) + 1)).join("0"));
            };
            return (((((_local_4) ? _local_4 : "") + _local_8.substr(0, _local_11)) + ".") + _local_8.substr(_local_11));
        }

        public function formatRounding(_arg_1:String, _arg_2:String):String
        {
            var _local_3:Number = Number(_arg_1);
            if (_arg_2 != NumberBaseRoundType.NONE)
            {
                if (_arg_2 == NumberBaseRoundType.UP)
                {
                    _local_3 = Math.ceil(_local_3);
                }
                else
                {
                    if (_arg_2 == NumberBaseRoundType.DOWN)
                    {
                        _local_3 = Math.floor(_local_3);
                    }
                    else
                    {
                        if (_arg_2 == NumberBaseRoundType.NEAREST)
                        {
                            _local_3 = Math.round(_local_3);
                        }
                        else
                        {
                            isValid = false;
                            return ("");
                        };
                    };
                };
            };
            return (_local_3.toString());
        }

        public function formatNegative(_arg_1:String, _arg_2:Boolean):String
        {
            if (_arg_2)
            {
                if (_arg_1.charAt(0) != "-")
                {
                    _arg_1 = ("-" + _arg_1);
                };
            }
            else
            {
                if (!_arg_2)
                {
                    if (_arg_1.charAt(0) == "-")
                    {
                        _arg_1 = _arg_1.substr(1, (_arg_1.length - 1));
                    };
                    _arg_1 = (("(" + _arg_1) + ")");
                }
                else
                {
                    isValid = false;
                    return ("");
                };
            };
            return (_arg_1);
        }

        public function formatRoundingWithPrecision(_arg_1:String, _arg_2:String, _arg_3:int):String
        {
            var _local_4:Number = Number(_arg_1);
            if (_arg_2 == NumberBaseRoundType.NONE)
            {
                if (_arg_3 == -1)
                {
                    return (_local_4.toString());
                };
            }
            else
            {
                if (_arg_3 < 0)
                {
                    _arg_3 = 0;
                };
                _local_4 = (_local_4 * Math.pow(10, _arg_3));
                _local_4 = Number(_local_4.toString());
                if (_arg_2 == NumberBaseRoundType.UP)
                {
                    _local_4 = Math.ceil(_local_4);
                }
                else
                {
                    if (_arg_2 == NumberBaseRoundType.DOWN)
                    {
                        _local_4 = Math.floor(_local_4);
                    }
                    else
                    {
                        if (_arg_2 == NumberBaseRoundType.NEAREST)
                        {
                            _local_4 = Math.round(_local_4);
                        }
                        else
                        {
                            isValid = false;
                            return ("");
                        };
                    };
                };
                _local_4 = (_local_4 / Math.pow(10, _arg_3));
            };
            return (_local_4.toString());
        }


    }
}//package mx.formatters

