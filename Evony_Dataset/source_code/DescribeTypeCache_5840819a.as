// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.DescribeTypeCache

package mx.utils
{
    import flash.utils.getQualifiedClassName;
    import flash.utils.getDefinitionByName;
    import flash.utils.describeType;
    import mx.binding.BindabilityInfo;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DescribeTypeCache 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var typeCache:Object = {};
        private static var cacheHandlers:Object = {};

        {
            registerCacheHandler("bindabilityInfo", bindabilityInfoHandler);
        }


        public static function describeType(_arg_1:*):DescribeTypeCacheRecord
        {
            var _local_2:String;
            var _local_3:XML;
            var _local_4:DescribeTypeCacheRecord;
            if ((_arg_1 is String))
            {
                _local_2 = _arg_1;
            }
            else
            {
                _local_2 = getQualifiedClassName(_arg_1);
            };
            if ((_local_2 in typeCache))
            {
                return (typeCache[_local_2]);
            };
            if ((_arg_1 is String))
            {
                _arg_1 = getDefinitionByName(_arg_1);
            };
            _local_3 = flash.utils.describeType(_arg_1);
            _local_4 = new DescribeTypeCacheRecord();
            _local_4.typeDescription = _local_3;
            _local_4.typeName = _local_2;
            typeCache[_local_2] = _local_4;
            return (_local_4);
        }

        public static function registerCacheHandler(_arg_1:String, _arg_2:Function):void
        {
            cacheHandlers[_arg_1] = _arg_2;
        }

        internal static function extractValue(_arg_1:String, _arg_2:DescribeTypeCacheRecord):*
        {
            if ((_arg_1 in cacheHandlers))
            {
                return (cacheHandlers[_arg_1](_arg_2));
            };
            return (undefined);
        }

        private static function bindabilityInfoHandler(_arg_1:DescribeTypeCacheRecord):*
        {
            return (new BindabilityInfo(_arg_1.typeDescription));
        }


    }
}//package mx.utils

