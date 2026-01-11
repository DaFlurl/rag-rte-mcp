// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.DescribeTypeCacheRecord

package mx.utils
{
    import flash.utils.Proxy;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public dynamic class DescribeTypeCacheRecord extends Proxy 
    {

        public var typeDescription:XML;
        public var typeName:String;
        private var cache:Object = {};


        override flash_proxy function getProperty(_arg_1:*):*
        {
            var _local_2:* = cache[_arg_1];
            if (_local_2 === undefined)
            {
                _local_2 = DescribeTypeCache.extractValue(_arg_1, this);
                cache[_arg_1] = _local_2;
            };
            return (_local_2);
        }

        override flash_proxy function hasProperty(_arg_1:*):Boolean
        {
            if ((_arg_1 in cache))
            {
                return (true);
            };
            var _local_2:* = DescribeTypeCache.extractValue(_arg_1, this);
            if (_local_2 === undefined)
            {
                return (false);
            };
            cache[_arg_1] = _local_2;
            return (true);
        }


    }
}//package mx.utils

