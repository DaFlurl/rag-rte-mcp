// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.InputTextFilter

package com.evony.util
{
    import mx.utils.StringUtil;

    public class InputTextFilter 
    {


        public static function isChinese(_arg_1:String):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _arg_1 = StringUtil.trim(_arg_1);
            var _local_2:RegExp = /^[Α-￥]+$/;
            var _local_3:Object = _local_2.exec(_arg_1);
            if (_local_3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function specialCharFilter(_arg_1:String):Boolean
        {
            var _local_2:Boolean;
            var _local_3:* = "\" '";
            var _local_4:Array = _arg_1.split("");
            var _local_5:int;
            while (_local_5 < _local_4.length)
            {
                if (_local_3.indexOf(_local_4[_local_5]) > -1)
                {
                    _local_2 = true;
                    break;
                };
                _local_5++;
            };
            return (_local_2);
        }


    }
}//package com.evony.util

