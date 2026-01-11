// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.ArrayUtil

package mx.utils
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ArrayUtil 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        public static function getItemIndex(_arg_1:Object, _arg_2:Array):int
        {
            var _local_3:int = _arg_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (_arg_2[_local_4] === _arg_1)
                {
                    return (_local_4);
                };
                _local_4++;
            };
            return (-1);
        }

        public static function toArray(_arg_1:Object):Array
        {
            if (!_arg_1)
            {
                return ([]);
            };
            if ((_arg_1 is Array))
            {
                return (_arg_1 as Array);
            };
            return ([_arg_1]);
        }


    }
}//package mx.utils

