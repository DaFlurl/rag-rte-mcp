// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.Log

package org.httpclient
{
    import flash.utils.getQualifiedClassName;

    public class Log 
    {

        public static const DEBUG:Number = 1;
        public static const INFO:Number = 2;
        public static const WARN:Number = 3;
        public static const ERROR:Number = 4;
        public static const OFF:Number = 5;
        public static var level:Number = INFO;//2


        public static function error(... _args):void
        {
            output(("[ERROR] " + describeArgsToString(_args)));
        }

        private static function output(_arg_1:String):void
        {
            trace(_arg_1);
        }

        public static function describeArgs(args:Array):Array
        {
            return (args.map(function (_arg_1:*, _arg_2:int, _arg_3:Array):*
            {
                return (describe(_arg_1));
            }));
        }

        public static function describe(obj:*):String
        {
            var key:String;
            if (obj == null)
            {
                return ("null");
            };
            if ((obj is String))
            {
                return (obj.toString());
            };
            if ((obj is Number))
            {
                return (obj.toString());
            };
            if ((obj is Function))
            {
                return ("(Function)");
            };
            if ((obj is Array))
            {
                return (("[ " + (obj as Array).map(function (_arg_1:*, _arg_2:int, _arg_3:Array):String
                {
                    return (describe(_arg_1));
                }).join(", ")) + " ]");
            };
            var entries:Array = [];
            for (key in obj)
            {
                if (obj[key] != obj)
                {
                    entries.push(((key + ": ") + obj[key]));
                };
            };
            if (entries.length > 0)
            {
                return (("{" + entries.join(", ")) + "}");
            };
            var className:String = getQualifiedClassName(obj);
            return ((("(" + className) + ") ") + obj.toString());
        }

        public static function describeArgsToString(_arg_1:Array):String
        {
            if (_arg_1.length == 0)
            {
                return ("");
            };
            var _local_2:Array = describeArgs(_arg_1);
            if (_local_2.length == 0)
            {
                return ("");
            };
            return (_local_2.join(", "));
        }

        public static function warn(... _args):void
        {
            if (level > WARN)
            {
                return;
            };
            output(("[WARNING] " + describeArgsToString(_args)));
        }

        public static function debug(... _args):void
        {
            if (level > DEBUG)
            {
                return;
            };
            output(describeArgsToString(_args));
        }


    }
}//package org.httpclient

