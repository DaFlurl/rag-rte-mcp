// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.formatters.NumberFormatter

package mx.formatters
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NumberFormatter extends Formatter 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var roundingOverride:String;
        private var thousandsSeparatorFromOverride:String;
        private var _useNegativeSign:Object;
        private var decimalSeparatorFromOverride:String;
        private var _decimalSeparatorTo:String;
        private var useThousandsSeparatorOverride:Object;
        private var _thousandsSeparatorTo:String;
        private var useNegativeSignOverride:Object;
        private var thousandsSeparatorToOverride:String;
        private var decimalSeparatorToOverride:String;
        private var precisionOverride:Object;
        private var _rounding:String;
        private var _useThousandsSeparator:Object;
        private var _thousandsSeparatorFrom:String;
        private var _decimalSeparatorFrom:String;
        private var _precision:Object;


        public function set precision(_arg_1:Object):void
        {
            precisionOverride = _arg_1;
            _precision = ((_arg_1 != null) ? int(_arg_1) : resourceManager.getInt("formatters", "numberFormatterPrecision"));
        }

        public function get useNegativeSign():Object
        {
            return (_useNegativeSign);
        }

        override protected function resourcesChanged():void
        {
            super.resourcesChanged();
            decimalSeparatorFrom = decimalSeparatorFromOverride;
            decimalSeparatorTo = decimalSeparatorToOverride;
            precision = precisionOverride;
            rounding = roundingOverride;
            thousandsSeparatorFrom = thousandsSeparatorFromOverride;
            thousandsSeparatorTo = thousandsSeparatorToOverride;
            useNegativeSign = useNegativeSignOverride;
            useThousandsSeparator = useThousandsSeparatorOverride;
        }

        public function get rounding():String
        {
            return (_rounding);
        }

        public function set thousandsSeparatorTo(_arg_1:String):void
        {
            thousandsSeparatorToOverride = _arg_1;
            _thousandsSeparatorTo = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("SharedResources", "thousandsSeparatorTo"));
        }

        public function get thousandsSeparatorFrom():String
        {
            return (_thousandsSeparatorFrom);
        }

        public function set decimalSeparatorTo(_arg_1:String):void
        {
            decimalSeparatorToOverride = _arg_1;
            _decimalSeparatorTo = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("SharedResources", "decimalSeparatorTo"));
        }

        public function set useNegativeSign(_arg_1:Object):void
        {
            useNegativeSignOverride = _arg_1;
            _useNegativeSign = ((_arg_1 != null) ? Boolean(_arg_1) : resourceManager.getBoolean("formatters", "useNegativeSign"));
        }

        override public function format(_arg_1:Object):String
        {
            var _local_9:String;
            var _local_10:Number;
            if (error)
            {
                error = null;
            };
            if (((useThousandsSeparator) && ((decimalSeparatorFrom == thousandsSeparatorFrom) || (decimalSeparatorTo == thousandsSeparatorTo))))
            {
                error = defaultInvalidFormatError;
                return ("");
            };
            if (((decimalSeparatorTo == "") || (!(isNaN(Number(decimalSeparatorTo))))))
            {
                error = defaultInvalidFormatError;
                return ("");
            };
            var _local_2:NumberBase = new NumberBase(decimalSeparatorFrom, thousandsSeparatorFrom, decimalSeparatorTo, thousandsSeparatorTo);
            if ((_arg_1 is String))
            {
                _arg_1 = _local_2.parseNumberString(String(_arg_1));
            };
            if (((_arg_1 === null) || (isNaN(Number(_arg_1)))))
            {
                error = defaultInvalidValueError;
                return ("");
            };
            var _local_3:* = (Number(_arg_1) < 0);
            var _local_4:String = _arg_1.toString();
            _local_4.toLowerCase();
            var _local_5:int = _local_4.indexOf("e");
            if (_local_5 != -1)
            {
                _local_4 = _local_2.expandExponents(_local_4);
            };
            var _local_6:Array = _local_4.split(".");
            var _local_7:int = ((_local_6[1]) ? String(_local_6[1]).length : 0);
            if (precision <= _local_7)
            {
                if (rounding != NumberBaseRoundType.NONE)
                {
                    _local_4 = _local_2.formatRoundingWithPrecision(_local_4, rounding, int(precision));
                };
            };
            var _local_8:Number = Number(_local_4);
            if (Math.abs(_local_8) >= 1)
            {
                _local_6 = _local_4.split(".");
                _local_9 = ((useThousandsSeparator) ? _local_2.formatThousands(String(_local_6[0])) : String(_local_6[0]));
                if (((!(_local_6[1] == null)) && (!(_local_6[1] == ""))))
                {
                    _local_4 = ((_local_9 + decimalSeparatorTo) + _local_6[1]);
                }
                else
                {
                    _local_4 = _local_9;
                };
            }
            else
            {
                if (Math.abs(_local_8) > 0)
                {
                    if (_local_4.indexOf("e") != -1)
                    {
                        _local_10 = (Math.abs(_local_8) + 1);
                        _local_4 = _local_10.toString();
                    };
                    _local_4 = (decimalSeparatorTo + _local_4.substring((_local_4.indexOf(".") + 1)));
                };
            };
            _local_4 = _local_2.formatPrecision(_local_4, int(precision));
            if (Number(_local_4) == 0)
            {
                _local_3 = false;
            };
            if (_local_3)
            {
                _local_4 = _local_2.formatNegative(_local_4, useNegativeSign);
            };
            if (!_local_2.isValid)
            {
                error = defaultInvalidFormatError;
                return ("");
            };
            return (_local_4);
        }

        public function get decimalSeparatorFrom():String
        {
            return (_decimalSeparatorFrom);
        }

        public function set rounding(_arg_1:String):void
        {
            roundingOverride = _arg_1;
            _rounding = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("formatters", "rounding"));
        }

        public function get thousandsSeparatorTo():String
        {
            return (_thousandsSeparatorTo);
        }

        public function get decimalSeparatorTo():String
        {
            return (_decimalSeparatorTo);
        }

        public function set thousandsSeparatorFrom(_arg_1:String):void
        {
            thousandsSeparatorFromOverride = _arg_1;
            _thousandsSeparatorFrom = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("SharedResources", "thousandsSeparatorFrom"));
        }

        public function set useThousandsSeparator(_arg_1:Object):void
        {
            useThousandsSeparatorOverride = _arg_1;
            _useThousandsSeparator = ((_arg_1 != null) ? Boolean(_arg_1) : resourceManager.getBoolean("formatters", "useThousandsSeparator"));
        }

        public function get useThousandsSeparator():Object
        {
            return (_useThousandsSeparator);
        }

        public function set decimalSeparatorFrom(_arg_1:String):void
        {
            decimalSeparatorFromOverride = _arg_1;
            _decimalSeparatorFrom = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("SharedResources", "decimalSeparatorFrom"));
        }

        public function get precision():Object
        {
            return (_precision);
        }


    }
}//package mx.formatters

