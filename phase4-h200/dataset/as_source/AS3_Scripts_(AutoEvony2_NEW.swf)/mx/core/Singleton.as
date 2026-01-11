// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.Singleton

package mx.core
{
    public class Singleton 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var classMap:Object = {};


        public static function registerClass(_arg_1:String, _arg_2:Class):void
        {
            var _local_3:Class = classMap[_arg_1];
            if (!_local_3)
            {
                classMap[_arg_1] = _arg_2;
            };
        }

        public static function getClass(_arg_1:String):Class
        {
            return (classMap[_arg_1]);
        }

        public static function getInstance(_arg_1:String):Object
        {
            var _local_2:Class = classMap[_arg_1];
            if (!_local_2)
            {
                throw (new Error((("No class registered for interface '" + _arg_1) + "'.")));
            };
            return (_local_2["getInstance"]());
        }


    }
}//package mx.core

