// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.xls.Formatter

package com.as3xls.xls
{
    import mx.formatters.NumberBase;
    import mx.formatters.NumberFormatter;
    import mx.formatters.NumberBaseRoundType;
    import mx.formatters.DateFormatter;

    public class Formatter 
    {

        private static const decimal:Object = {
            "0":buildNumberFormatter(8),
            "0.00":buildNumberFormatter(2),
            "#,##0":buildNumberFormatter(0),
            "#,##0.00":buildNumberFormatter(2)
        };
        private static const date:Object = {
            "d\\-mmm":"D-MMM",
            "d\\-mmm\\-yy":"D-MMM-YY",
            "mmm\\-yy":"MMM-YY"
        };
        private static const currency:Object = {
            '"$"#,##0_);\\("$"#,##0\\)':buildNumberFormatter(2),
            '"$"#,##0_);[Red]\\("$"#,##0\\)':buildNumberFormatter(2),
            '"$"#,##0.00_);\\("$"#,##0.00\\)':buildNumberFormatter(2),
            '"$"#,##0.00_);[Red]\\("$"#,##0.00\\)':buildNumberFormatter(2)
        };
        private static const percent:Object = {
            "0%":"0%",
            "0.00%":"0.00%"
        };
        private static const scientific:Object = {
            "0.00E+00":buildNumberFormatter(-1),
            "##0.0E+0":buildNumberFormatter(-1)
        };
        public static const builtInFormats:Array = ["General", "0", "0.00", "#,##0", "#,##0.00", "0%", "0.00%", "0.00E+00", "# ?/?", "# ?/?", "", "", "", "", "", "d\\-mmm\\-yy", "d\\-mmm", "mmm\\-yy", "", "", "", "", "", '"$"#,##0_);\\("$"#,##0\\)', '"$"#,##0_);[Red]\\("$"#,##0\\)', '"$"#,##0.00_);\\("$"#,##0.00\\)', '"$"#,##0.00_);[Red]\\("$"#,##0.00\\)', "", "", "", "##0.0E+0"];
        private static const rounder:NumberBase = new NumberBase();


        private static function buildNumberFormatter(_arg_1:Number):NumberFormatter
        {
            var _local_2:NumberFormatter = new NumberFormatter();
            _local_2.precision = _arg_1;
            _local_2.useThousandsSeparator = false;
            _local_2.rounding = NumberBaseRoundType.NEAREST;
            return (_local_2);
        }

        public static function format(_arg_1:*, _arg_2:String, _arg_3:uint=1):*
        {
            var _local_4:String;
            var _local_5:Date;
            var _local_6:DateFormatter;
            if ((((_arg_2.length == 0) || (_arg_2 == "General")) && (isNaN(Number(_arg_1)) == false)))
            {
                _arg_2 = builtInFormats[1];
            };
            if ((decimal[_arg_2] is NumberFormatter))
            {
                _local_4 = decimal[_arg_2].format(_arg_1);
                if (_local_4.indexOf(".") != -1)
                {
                    while (_local_4.charAt((_local_4.length - 1)) == "0")
                    {
                        _local_4 = _local_4.substr(0, (_local_4.length - 1));
                    };
                };
                return (_local_4);
            };
            if ((percent[_arg_2] is String))
            {
                return (_arg_1);
            };
            if ((date[_arg_2] is String))
            {
                _local_5 = new Date();
                _local_5.hours = 0;
                _local_5.minutes = 0;
                _local_5.seconds = 0;
                _local_5.milliseconds = 0;
                _local_5.fullYear = ((_arg_3 == ExcelFile.BASE1899) ? 1899 : 1904);
                _local_5.month = ((_arg_3 == ExcelFile.BASE1899) ? 11 : 0);
                _local_5.date = ((_arg_3 == ExcelFile.BASE1899) ? 30 : 0);
                _local_5.date = (_local_5.date + (_arg_1 + 1));
                _local_6 = new DateFormatter();
                _local_6.formatString = date[_arg_2];
                return (_local_6.format(_local_5));
            };
            if ((currency[_arg_2] is NumberFormatter))
            {
                return (currency[_arg_2].format(_arg_1));
            };
            return (_arg_1);
        }

        public static function isDate(_arg_1:String):Boolean
        {
            return (date[_arg_1] is String);
        }


    }
}//package com.as3xls.xls

