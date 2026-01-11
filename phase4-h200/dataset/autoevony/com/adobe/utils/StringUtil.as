// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.adobe.utils.StringUtil

package com.adobe.utils
{
    public class StringUtil 
    {


        public static function beginsWith(_arg_1:String, _arg_2:String):Boolean
        {
            return (_arg_2 == _arg_1.substring(0, _arg_2.length));
        }

        public static function trim(_arg_1:String):String
        {
            return (StringUtil.ltrim(StringUtil.rtrim(_arg_1)));
        }

        public static function stringsAreEqual(_arg_1:String, _arg_2:String, _arg_3:Boolean):Boolean
        {
            if (_arg_3)
            {
                return (_arg_1 == _arg_2);
            };
            return (_arg_1.toUpperCase() == _arg_2.toUpperCase());
        }

        public static function replace(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            return (_arg_1.split(_arg_2).join(_arg_3));
        }

        public static function rtrim(_arg_1:String):String
        {
            var _local_2:Number = _arg_1.length;
            var _local_3:Number = _local_2;
            while (_local_3 > 0)
            {
                if (_arg_1.charCodeAt((_local_3 - 1)) > 32)
                {
                    return (_arg_1.substring(0, _local_3));
                };
                _local_3--;
            };
            return ("");
        }

        public static function endsWith(_arg_1:String, _arg_2:String):Boolean
        {
            return (_arg_2 == _arg_1.substring((_arg_1.length - _arg_2.length)));
        }

        public static function stringHasValue(_arg_1:String):Boolean
        {
            return ((!(_arg_1 == null)) && (_arg_1.length > 0));
        }

        public static function remove(_arg_1:String, _arg_2:String):String
        {
            return (StringUtil.replace(_arg_1, _arg_2, ""));
        }

        public static function ltrim(_arg_1:String):String
        {
            var _local_2:Number = _arg_1.length;
            var _local_3:Number = 0;
            while (_local_3 < _local_2)
            {
                if (_arg_1.charCodeAt(_local_3) > 32)
                {
                    return (_arg_1.substring(_local_3));
                };
                _local_3++;
            };
            return ("");
        }


    }
}//package com.adobe.utils

