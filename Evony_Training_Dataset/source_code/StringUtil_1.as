// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.StringUtil

package mx.utils
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class StringUtil 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        public static function trim(_arg_1:String):String
        {
            if (_arg_1 == null)
            {
                return ("");
            };
            var _local_2:int;
            while (isWhitespace(_arg_1.charAt(_local_2)))
            {
                _local_2++;
            };
            var _local_3:int = (_arg_1.length - 1);
            while (isWhitespace(_arg_1.charAt(_local_3)))
            {
                _local_3--;
            };
            if (_local_3 >= _local_2)
            {
                return (_arg_1.slice(_local_2, (_local_3 + 1)));
            };
            return ("");
        }

        public static function isWhitespace(_arg_1:String):Boolean
        {
            switch (_arg_1)
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                    return (true);
                default:
                    return (false);
            };
        }

        public static function substitute(_arg_1:String, ... _args):String
        {
            var _local_4:Array;
            if (_arg_1 == null)
            {
                return ("");
            };
            var _local_3:uint = _args.length;
            if (((_local_3 == 1) && (_args[0] is Array)))
            {
                _local_4 = (_args[0] as Array);
                _local_3 = _local_4.length;
            }
            else
            {
                _local_4 = _args;
            };
            var _local_5:int;
            while (_local_5 < _local_3)
            {
                _arg_1 = _arg_1.replace(new RegExp((("\\{" + _local_5) + "\\}"), "g"), _local_4[_local_5]);
                _local_5++;
            };
            return (_arg_1);
        }

        public static function trimArrayElements(_arg_1:String, _arg_2:String):String
        {
            var _local_3:Array;
            var _local_4:int;
            var _local_5:int;
            if (((!(_arg_1 == "")) && (!(_arg_1 == null))))
            {
                _local_3 = _arg_1.split(_arg_2);
                _local_4 = _local_3.length;
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_3[_local_5] = StringUtil.trim(_local_3[_local_5]);
                    _local_5++;
                };
                if (_local_4 > 0)
                {
                    _arg_1 = _local_3.join(_arg_2);
                };
            };
            return (_arg_1);
        }


    }
}//package mx.utils

