package com.as3xls.xls
{
   import mx.formatters.DateFormatter;
   import mx.formatters.NumberBase;
   import mx.formatters.NumberBaseRoundType;
   import mx.formatters.NumberFormatter;
   
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
         "\"$\"#,##0_);\\(\"$\"#,##0\\)":buildNumberFormatter(2),
         "\"$\"#,##0_);[Red]\\(\"$\"#,##0\\)":buildNumberFormatter(2),
         "\"$\"#,##0.00_);\\(\"$\"#,##0.00\\)":buildNumberFormatter(2),
         "\"$\"#,##0.00_);[Red]\\(\"$\"#,##0.00\\)":buildNumberFormatter(2)
      };
      
      private static const percent:Object = {
         "0%":"0%",
         "0.00%":"0.00%"
      };
      
      private static const scientific:Object = {
         "0.00E+00":buildNumberFormatter(-1),
         "##0.0E+0":buildNumberFormatter(-1)
      };
      
      public static const builtInFormats:Array = ["General","0","0.00","#,##0","#,##0.00","0%","0.00%","0.00E+00","# ?/?","# ?/?","","","","","","d\\-mmm\\-yy","d\\-mmm","mmm\\-yy","","","","","","\"$\"#,##0_);\\(\"$\"#,##0\\)","\"$\"#,##0_);[Red]\\(\"$\"#,##0\\)","\"$\"#,##0.00_);\\(\"$\"#,##0.00\\)","\"$\"#,##0.00_);[Red]\\(\"$\"#,##0.00\\)","","","","##0.0E+0"];
      
      private static const rounder:NumberBase = new NumberBase();
      
      public function Formatter()
      {
         super();
      }
      
      private static function buildNumberFormatter(param1:Number) : NumberFormatter
      {
         var _loc2_:NumberFormatter = new NumberFormatter();
         _loc2_.precision = param1;
         _loc2_.useThousandsSeparator = false;
         _loc2_.rounding = NumberBaseRoundType.NEAREST;
         return _loc2_;
      }
      
      public static function format(param1:*, param2:String, param3:uint = 1) : *
      {
         var _loc4_:String = null;
         var _loc5_:Date = null;
         var _loc6_:DateFormatter = null;
         if((param2.length == 0 || param2 == "General") && isNaN(Number(param1)) == false)
         {
            param2 = builtInFormats[1];
         }
         if(decimal[param2] is NumberFormatter)
         {
            _loc4_ = decimal[param2].format(param1);
            if(_loc4_.indexOf(".") != -1)
            {
               while(_loc4_.charAt(_loc4_.length - 1) == "0")
               {
                  _loc4_ = _loc4_.substr(0,_loc4_.length - 1);
               }
            }
            return _loc4_;
         }
         if(percent[param2] is String)
         {
            return param1;
         }
         if(date[param2] is String)
         {
            _loc5_ = new Date();
            _loc5_.hours = 0;
            _loc5_.minutes = 0;
            _loc5_.seconds = 0;
            _loc5_.milliseconds = 0;
            _loc5_.fullYear = param3 == ExcelFile.BASE1899 ? 1899 : 1904;
            _loc5_.month = param3 == ExcelFile.BASE1899 ? 11 : 0;
            _loc5_.date = param3 == ExcelFile.BASE1899 ? 30 : 0;
            _loc5_.date += param1 + 1;
            _loc6_ = new DateFormatter();
            _loc6_.formatString = date[param2];
            return _loc6_.format(_loc5_);
         }
         if(currency[param2] is NumberFormatter)
         {
            return currency[param2].format(param1);
         }
         return param1;
      }
      
      public static function isDate(param1:String) : Boolean
      {
         return date[param1] is String;
      }
   }
}

