// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.FlexVersion

package mx.core
{
    import mx.resources.ResourceManager;

    public class FlexVersion 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const CURRENT_VERSION:uint = 0x3000000;
        public static const VERSION_3_0:uint = 0x3000000;
        public static const VERSION_2_0_1:uint = 33554433;
        public static const VERSION_2_0:uint = 0x2000000;
        public static const VERSION_ALREADY_SET:String = "versionAlreadySet";
        public static const VERSION_ALREADY_READ:String = "versionAlreadyRead";
        private static var _compatibilityErrorFunction:Function;
        private static var _compatibilityVersion:uint = CURRENT_VERSION;//0x3000000
        private static var compatibilityVersionChanged:Boolean = false;
        private static var compatibilityVersionRead:Boolean = false;


        mx_internal static function changeCompatibilityVersionString(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split(".");
            var _local_3:uint = parseInt(_local_2[0]);
            var _local_4:uint = parseInt(_local_2[1]);
            var _local_5:uint = parseInt(_local_2[2]);
            _compatibilityVersion = (((_local_3 << 24) + (_local_4 << 16)) + _local_5);
        }

        public static function set compatibilityVersion(_arg_1:uint):void
        {
            var _local_2:String;
            if (_arg_1 == _compatibilityVersion)
            {
                return;
            };
            if (compatibilityVersionChanged)
            {
                if (compatibilityErrorFunction == null)
                {
                    _local_2 = ResourceManager.getInstance().getString("core", VERSION_ALREADY_SET);
                    throw (new Error(_local_2));
                };
                compatibilityErrorFunction(_arg_1, VERSION_ALREADY_SET);
            };
            if (compatibilityVersionRead)
            {
                if (compatibilityErrorFunction == null)
                {
                    _local_2 = ResourceManager.getInstance().getString("core", VERSION_ALREADY_READ);
                    throw (new Error(_local_2));
                };
                compatibilityErrorFunction(_arg_1, VERSION_ALREADY_READ);
            };
            _compatibilityVersion = _arg_1;
            compatibilityVersionChanged = true;
        }

        public static function get compatibilityVersion():uint
        {
            compatibilityVersionRead = true;
            return (_compatibilityVersion);
        }

        public static function set compatibilityErrorFunction(_arg_1:Function):void
        {
            _compatibilityErrorFunction = _arg_1;
        }

        public static function set compatibilityVersionString(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split(".");
            var _local_3:uint = parseInt(_local_2[0]);
            var _local_4:uint = parseInt(_local_2[1]);
            var _local_5:uint = parseInt(_local_2[2]);
            compatibilityVersion = (((_local_3 << 24) + (_local_4 << 16)) + _local_5);
        }

        public static function get compatibilityErrorFunction():Function
        {
            return (_compatibilityErrorFunction);
        }

        public static function get compatibilityVersionString():String
        {
            var _local_1:uint = ((compatibilityVersion >> 24) & 0xFF);
            var _local_2:uint = ((compatibilityVersion >> 16) & 0xFF);
            var _local_3:uint = (compatibilityVersion & 0xFFFF);
            return ((((_local_1.toString() + ".") + _local_2.toString()) + ".") + _local_3.toString());
        }


    }
}//package mx.core

