// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Version

package 
{
    public class Version 
    {

        private static const GAMECLIENTVERSION:String = "091103_11";
        private static const ENABLE_TRACE:Boolean = false;
        private static const ENABLE_CONNECTION_TRACE:Boolean = false;
        private static const ENABLE_RESPONSE_TRACE:Boolean = false;
        private static const ENABLE_MAP_TRACE:Boolean = false;
        private static const VERSION:String = "1.60";
        private static const STEP:String = "";
        private static const IS_BETA:Boolean = false;
        private static const MONTH:String = "07";
        private static const DAY:String = "07";
        private static const YEAR:String = "2017";


        public static function isTraceOn():Boolean
        {
            return (ENABLE_TRACE);
        }

        public static function getStep():String
        {
            return (STEP);
        }

        public static function getGameClientVersion():String
        {
            return (GAMECLIENTVERSION);
        }

        public static function isTraceConnectionOn():Boolean
        {
            return (ENABLE_CONNECTION_TRACE);
        }

        public static function getRelease():String
        {
            return ((((MONTH + "/") + DAY) + "/") + YEAR);
        }

        public static function isTraceMapOn():Boolean
        {
            return (ENABLE_MAP_TRACE);
        }

        public static function isTraceResponseOn():Boolean
        {
            return (ENABLE_RESPONSE_TRACE);
        }

        public static function getVersionStr(_arg_1:Boolean=false):String
        {
            return (((("v" + VERSION) + STEP) + ((IS_BETA) ? " (beta)" : "")) + ((_arg_1) ? ((((("  -  " + MONTH) + "/") + DAY) + "/") + YEAR) : ""));
        }

        public static function getVersion():String
        {
            return (VERSION);
        }

        public static function getIsBeta():Boolean
        {
            return (IS_BETA);
        }


    }
}//package 

