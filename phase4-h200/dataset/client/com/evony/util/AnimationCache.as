// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.AnimationCache

package com.evony.util
{
    import flash.utils.Dictionary;

    public class AnimationCache 
    {

        private static var _instance:AnimationCache = null;

        private var cache_map:Dictionary = new Dictionary();


        public static function singleton():AnimationCache
        {
            if (_instance == null)
            {
                _instance = new (AnimationCache)();
            };
            return (_instance);
        }


        public function putAni(_arg_1:int, _arg_2:Object):void
        {
            if (cache_map[_arg_1] == null)
            {
                cache_map[_arg_1] = new Array();
            };
            var _local_3:Array = cache_map[_arg_1];
            _local_3.push(_arg_2);
        }

        public function getAni(_arg_1:int):Object
        {
            if (cache_map[_arg_1] == null)
            {
                return (null);
            };
            var _local_2:Array = cache_map[_arg_1];
            if (_local_2.length == 0)
            {
                return (null);
            };
            return (_local_2.pop());
        }


    }
}//package com.evony.util

