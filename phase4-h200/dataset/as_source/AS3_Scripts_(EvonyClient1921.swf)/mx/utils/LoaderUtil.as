// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.LoaderUtil

package mx.utils
{
    import mx.core.mx_internal;
    import flash.display.LoaderInfo;

    use namespace mx_internal;

    public class LoaderUtil 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static var urlFilters:Array = [{
            "searchString":"/[[DYNAMIC]]/",
            "filterFunction":dynamicURLFilter
        }, {
            "searchString":"/[[IMPORT]]/",
            "filterFunction":importURLFilter
        }];


        private static function importURLFilter(_arg_1:String, _arg_2:int):String
        {
            var _local_3:int = _arg_1.indexOf("://");
            return (_arg_1.substring(0, (_local_3 + 3)) + _arg_1.substring((_arg_2 + 12)));
        }

        public static function normalizeURL(_arg_1:LoaderInfo):String
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:Function;
            var _local_2:String = _arg_1.url;
            var _local_6:uint = LoaderUtil.mx_internal::urlFilters.length;
            var _local_7:uint;
            while (_local_7 < _local_6)
            {
                _local_4 = LoaderUtil.mx_internal::urlFilters[_local_7].searchString;
                if ((_local_3 = _local_2.indexOf(_local_4)) != -1)
                {
                    _local_5 = LoaderUtil.mx_internal::urlFilters[_local_7].filterFunction;
                    _local_2 = _local_5(_local_2, _local_3);
                };
                _local_7++;
            };
            return (_local_2);
        }

        public static function createAbsoluteURL(_arg_1:String, _arg_2:String):String
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:String = _arg_2;
            if (((_arg_1) && (!(((_arg_2.indexOf(":") > -1) || (_arg_2.indexOf("/") == 0)) || (_arg_2.indexOf("\\") == 0)))))
            {
                if ((_local_4 = _arg_1.indexOf("?")) != -1)
                {
                    _arg_1 = _arg_1.substring(0, _local_4);
                };
                if ((_local_4 = _arg_1.indexOf("#")) != -1)
                {
                    _arg_1 = _arg_1.substring(0, _local_4);
                };
                _local_5 = Math.max(_arg_1.lastIndexOf("\\"), _arg_1.lastIndexOf("/"));
                if (_arg_2.indexOf("./") == 0)
                {
                    _arg_2 = _arg_2.substring(2);
                }
                else
                {
                    while (_arg_2.indexOf("../") == 0)
                    {
                        _arg_2 = _arg_2.substring(3);
                        _local_5 = Math.max(_arg_1.lastIndexOf("\\", (_local_5 - 1)), _arg_1.lastIndexOf("/", (_local_5 - 1)));
                    };
                };
                if (_local_5 != -1)
                {
                    _local_3 = (_arg_1.substr(0, (_local_5 + 1)) + _arg_2);
                };
            };
            return (_local_3);
        }

        private static function dynamicURLFilter(_arg_1:String, _arg_2:int):String
        {
            return (_arg_1.substring(0, _arg_2));
        }


    }
}//package mx.utils

