// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.validators.NumberValidator

package mx.validators
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class NumberValidator extends Validator 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var decimalSeparatorOverride:String;
        private var thousandsSeparatorOverride:String;
        private var allowNegativeOverride:Object;
        private var invalidFormatCharsErrorOverride:String;
        private var invalidCharErrorOverride:String;
        private var precisionErrorOverride:String;
        private var _allowNegative:Object;
        private var _separationError:String;
        private var _exceedsMaxError:String;
        private var _minValue:Object;
        private var minValueOverride:Object;
        private var _thousandsSeparator:String;
        private var domainOverride:String;
        private var _lowerThanMinError:String;
        private var _integerError:String;
        private var decimalPointCountErrorOverride:String;
        private var _maxValue:Object;
        private var negativeErrorOverride:String;
        private var exceedsMaxErrorOverride:String;
        private var _precisionError:String;
        private var lowerThanMinErrorOverride:String;
        private var maxValueOverride:Object;
        private var integerErrorOverride:String;
        private var _invalidFormatCharsError:String;
        private var _domain:String;
        private var precisionOverride:Object;
        private var _negativeError:String;
        private var _decimalSeparator:String;
        private var _decimalPointCountError:String;
        private var _invalidCharError:String;
        private var separationErrorOverride:String;
        private var _precision:Object;


        public static function validateNumber(_arg_1:NumberValidator, _arg_2:Object, _arg_3:String):Array
        {
            var _local_15:int;
            var _local_16:String;
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:String;
            var _local_24:String;
            var _local_25:int;
            var _local_26:String;
            var _local_27:String;
            var _local_4:Array = [];
            var _local_5:Boolean = _arg_1.allowNegative;
            var _local_6:String = _arg_1.decimalSeparator;
            var _local_7:String = _arg_1.domain;
            var _local_8:Number = Number(_arg_1.maxValue);
            var _local_9:Number = Number(_arg_1.minValue);
            var _local_10:int = int(_arg_1.precision);
            var _local_11:String = _arg_1.thousandsSeparator;
            var _local_12:String = String(_arg_2);
            var _local_13:int = _local_12.length;
            var _local_14:Boolean;
            var _local_17:* = (DECIMAL_DIGITS + "-");
            if ((((((_local_6 == _local_11) || (!(_local_17.indexOf(_local_6) == -1))) || (!(_local_17.indexOf(_local_11) == -1))) || (!(_local_6.length == 1))) || (!(_local_11.length == 1))))
            {
                _local_4.push(new ValidationResult(true, _arg_3, "invalidFormatChar", _arg_1.invalidFormatCharsError));
                return (_local_4);
            };
            var _local_18:String = (((DECIMAL_DIGITS + "-") + _local_6) + _local_11);
            _local_15 = 0;
            while (_local_15 < _local_13)
            {
                _local_16 = _local_12.charAt(_local_15);
                if (_local_18.indexOf(_local_16) == -1)
                {
                    _local_4.push(new ValidationResult(true, _arg_3, "invalidChar", _arg_1.invalidCharError));
                    return (_local_4);
                };
                _local_15++;
            };
            if (_local_12.charAt(0) == "-")
            {
                if (_local_13 == 1)
                {
                    _local_4.push(new ValidationResult(true, _arg_3, "invalidChar", _arg_1.invalidCharError));
                    return (_local_4);
                };
                if (((_local_13 == 2) && (_local_12.charAt(1) == ".")))
                {
                    _local_4.push(new ValidationResult(true, _arg_3, "invalidChar", _arg_1.invalidCharError));
                    return (_local_4);
                };
                if (!_local_5)
                {
                    _local_4.push(new ValidationResult(true, _arg_3, "negative", _arg_1.negativeError));
                    return (_local_4);
                };
                _local_12 = _local_12.substring(1);
                _local_13--;
                _local_14 = true;
            };
            if (_local_12.indexOf(_local_6) != _local_12.lastIndexOf(_local_6))
            {
                _local_4.push(new ValidationResult(true, _arg_3, "decimalPointCount", _arg_1.decimalPointCountError));
                return (_local_4);
            };
            var _local_19:Number = _local_12.indexOf(_local_6);
            if (_local_19 != -1)
            {
                _local_21 = 0;
                if (((_local_15 == 1) && (_local_15 == _local_13)))
                {
                    _local_4.push(new ValidationResult(true, _arg_3, "invalidChar", _arg_1.invalidCharError));
                    return (_local_4);
                };
                _local_15 = (_local_19 + 1);
                while (_local_15 < _local_13)
                {
                    if (DECIMAL_DIGITS.indexOf(_local_12.charAt(_local_15)) == -1)
                    {
                        _local_4.push(new ValidationResult(true, _arg_3, "invalidChar", _arg_1.invalidCharError));
                        return (_local_4);
                    };
                    _local_21++;
                    if (((_local_7 == NumberValidatorDomainType.INT) && (!(_local_12.charAt(_local_15) == "0"))))
                    {
                        _local_4.push(new ValidationResult(true, _arg_3, "integer", _arg_1.integerError));
                        return (_local_4);
                    };
                    if (((!(_local_10 == -1)) && (_local_21 > _local_10)))
                    {
                        _local_4.push(new ValidationResult(true, _arg_3, "precision", _arg_1.precisionError));
                        return (_local_4);
                    };
                    _local_15++;
                };
            };
            if (((DECIMAL_DIGITS.indexOf(_local_12.charAt(0)) == -1) && (!(_local_12.charAt(0) == _local_6))))
            {
                _local_4.push(new ValidationResult(true, _arg_3, "invalidChar", _arg_1.invalidCharError));
                return (_local_4);
            };
            var _local_20:int = ((_local_19 == -1) ? _local_13 : _local_19);
            _local_15 = 1;
            while (_local_15 < _local_20)
            {
                _local_16 = _local_12.charAt(_local_15);
                if (_local_16 == _local_11)
                {
                    if (_local_16 == _local_11)
                    {
                        if ((((((!((_local_20 - _local_15) == 4)) && (!(_local_12.charAt((_local_15 + 4)) == _local_11))) || (DECIMAL_DIGITS.indexOf(_local_12.charAt((_local_15 + 1))) == -1)) || (DECIMAL_DIGITS.indexOf(_local_12.charAt((_local_15 + 2))) == -1)) || (DECIMAL_DIGITS.indexOf(_local_12.charAt((_local_15 + 3))) == -1)))
                        {
                            _local_4.push(new ValidationResult(true, _arg_3, "separation", _arg_1.separationError));
                            return (_local_4);
                        };
                    };
                }
                else
                {
                    if (DECIMAL_DIGITS.indexOf(_local_16) == -1)
                    {
                        _local_4.push(new ValidationResult(true, _arg_3, "invalidChar", _arg_1.invalidCharError));
                        return (_local_4);
                    };
                };
                _local_15++;
            };
            if (((!(isNaN(_local_9))) || (!(isNaN(_local_8)))))
            {
                _local_15 = 0;
                while (_local_15 < _local_20)
                {
                    if (_local_12.charAt(_local_15) == _local_11)
                    {
                        _local_23 = _local_12.substring(0, _local_15);
                        _local_24 = _local_12.substring((_local_15 + 1));
                        _local_12 = (_local_23 + _local_24);
                    };
                    _local_15++;
                };
                if (_arg_1.decimalSeparator != ".")
                {
                    _local_25 = _local_12.indexOf(_arg_1.decimalSeparator);
                    if (_local_25 != -1)
                    {
                        _local_26 = _local_12.substring(0, _local_25);
                        _local_27 = _local_12.substring((_local_25 + 1));
                        _local_12 = ((_local_26 + ".") + _local_27);
                    };
                };
                _local_22 = Number(_local_12);
                if (_local_14)
                {
                    _local_22 = -(_local_22);
                };
                if (((!(isNaN(_local_9))) && (_local_22 < _local_9)))
                {
                    _local_4.push(new ValidationResult(true, _arg_3, "lowerThanMin", _arg_1.lowerThanMinError));
                    return (_local_4);
                };
                if (((!(isNaN(_local_8))) && (_local_22 > _local_8)))
                {
                    _local_4.push(new ValidationResult(true, _arg_3, "exceedsMax", _arg_1.exceedsMaxError));
                    return (_local_4);
                };
            };
            return (_local_4);
        }


        public function set domain(_arg_1:String):void
        {
            domainOverride = _arg_1;
            _domain = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "numberValidatorDomain"));
        }

        public function get precision():Object
        {
            return (_precision);
        }

        public function get thousandsSeparator():String
        {
            return (_thousandsSeparator);
        }

        public function get invalidFormatCharsError():String
        {
            return (_invalidFormatCharsError);
        }

        public function get decimalSeparator():String
        {
            return (_decimalSeparator);
        }

        public function get allowNegative():Object
        {
            return (_allowNegative);
        }

        public function set thousandsSeparator(_arg_1:String):void
        {
            thousandsSeparatorOverride = _arg_1;
            _thousandsSeparator = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "thousandsSeparator"));
        }

        public function get invalidCharError():String
        {
            return (_invalidCharError);
        }

        public function set negativeError(_arg_1:String):void
        {
            negativeErrorOverride = _arg_1;
            _negativeError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "negativeError"));
        }

        public function set decimalSeparator(_arg_1:String):void
        {
            decimalSeparatorOverride = _arg_1;
            _decimalSeparator = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "decimalSeparator"));
        }

        public function get precisionError():String
        {
            return (_precisionError);
        }

        public function set decimalPointCountError(_arg_1:String):void
        {
            decimalPointCountErrorOverride = _arg_1;
            _decimalPointCountError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "decimalPointCountError"));
        }

        public function set invalidCharError(_arg_1:String):void
        {
            invalidCharErrorOverride = _arg_1;
            _invalidCharError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "invalidCharError"));
        }

        public function get lowerThanMinError():String
        {
            return (_lowerThanMinError);
        }

        public function set invalidFormatCharsError(_arg_1:String):void
        {
            invalidFormatCharsErrorOverride = _arg_1;
            _invalidFormatCharsError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "invalidFormatCharsError"));
        }

        public function get minValue():Object
        {
            return (_minValue);
        }

        public function set allowNegative(_arg_1:Object):void
        {
            allowNegativeOverride = _arg_1;
            _allowNegative = ((_arg_1 != null) ? Boolean(_arg_1) : resourceManager.getBoolean("validators", "allowNegative"));
        }

        public function get domain():String
        {
            return (_domain);
        }

        public function set exceedsMaxError(_arg_1:String):void
        {
            exceedsMaxErrorOverride = _arg_1;
            _exceedsMaxError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "exceedsMaxErrorNV"));
        }

        public function get negativeError():String
        {
            return (_negativeError);
        }

        public function get decimalPointCountError():String
        {
            return (_decimalPointCountError);
        }

        public function set maxValue(_arg_1:Object):void
        {
            maxValueOverride = _arg_1;
            _maxValue = ((_arg_1 != null) ? Number(_arg_1) : resourceManager.getNumber("validators", "maxValue"));
        }

        public function set integerError(_arg_1:String):void
        {
            integerErrorOverride = _arg_1;
            _integerError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "integerError"));
        }

        public function set separationError(_arg_1:String):void
        {
            separationErrorOverride = _arg_1;
            _separationError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "separationError"));
        }

        public function get separationError():String
        {
            return (_separationError);
        }

        override protected function doValidation(_arg_1:Object):Array
        {
            var _local_2:Array = super.doValidation(_arg_1);
            var _local_3:String = ((_arg_1) ? String(_arg_1) : "");
            if (((_local_2.length > 0) || ((_local_3.length == 0) && (!(required)))))
            {
                return (_local_2);
            };
            return (NumberValidator.validateNumber(this, _arg_1, null));
        }

        override protected function resourcesChanged():void
        {
            super.resourcesChanged();
            allowNegative = allowNegativeOverride;
            decimalSeparator = decimalSeparatorOverride;
            domain = domainOverride;
            maxValue = maxValueOverride;
            minValue = minValueOverride;
            precision = precisionOverride;
            thousandsSeparator = thousandsSeparatorOverride;
            decimalPointCountError = decimalPointCountErrorOverride;
            exceedsMaxError = exceedsMaxErrorOverride;
            integerError = integerErrorOverride;
            invalidCharError = invalidCharErrorOverride;
            invalidFormatCharsError = invalidFormatCharsErrorOverride;
            lowerThanMinError = lowerThanMinErrorOverride;
            negativeError = negativeErrorOverride;
            precisionError = precisionErrorOverride;
            separationError = separationErrorOverride;
        }

        public function get maxValue():Object
        {
            return (_maxValue);
        }

        public function set lowerThanMinError(_arg_1:String):void
        {
            lowerThanMinErrorOverride = _arg_1;
            _lowerThanMinError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "lowerThanMinError"));
        }

        public function get integerError():String
        {
            return (_integerError);
        }

        public function get exceedsMaxError():String
        {
            return (_exceedsMaxError);
        }

        public function set precisionError(_arg_1:String):void
        {
            precisionErrorOverride = _arg_1;
            _precisionError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "precisionError"));
        }

        public function set precision(_arg_1:Object):void
        {
            precisionOverride = _arg_1;
            _precision = ((_arg_1 != null) ? int(_arg_1) : resourceManager.getInt("validators", "numberValidatorPrecision"));
        }

        public function set minValue(_arg_1:Object):void
        {
            minValueOverride = _arg_1;
            _minValue = ((_arg_1 != null) ? Number(_arg_1) : resourceManager.getNumber("validators", "minValue"));
        }


    }
}//package mx.validators

