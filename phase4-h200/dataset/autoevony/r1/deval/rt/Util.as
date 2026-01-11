// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.Util

package r1.deval.rt
{
    public class Util 
    {


        public static function beginsWith(_arg_1:String, _arg_2:String):Boolean
        {
            return (_arg_2 == _arg_1.substring(0, _arg_2.length));
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

        public static function endsWith(_arg_1:String, _arg_2:String):Boolean
        {
            return (_arg_2 == _arg_1.substring((_arg_1.length - _arg_2.length)));
        }


    }
}//package r1.deval.rt

