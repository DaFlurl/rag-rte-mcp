// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.config.ConfigMap

package mx.messaging.config
{
    import flash.utils.Proxy;
    import mx.utils.object_proxy;
    import flash.utils.flash_proxy; 

    use namespace object_proxy;
    use namespace flash.utils.flash_proxy;

    public dynamic class ConfigMap extends Proxy 
    {

        private var _item:Object;
        object_proxy var propertyList:Array;

        public function ConfigMap(_arg_1:Object=null)
        {
            if (!_arg_1)
            {
                _arg_1 = {};
            };
            _item = _arg_1;
            propertyList = [];
        }

        override flash_proxy function deleteProperty(_arg_1:*):Boolean
        {
            var _local_2:Object = _item[_arg_1];
            var _local_3:* = delete _item[_arg_1];
            var _local_4:int = -1;
            var _local_5:int;
            while (_local_5 < propertyList.length)
            {
                if (propertyList[_local_5] == _arg_1)
                {
                    _local_4 = _local_5;
                    break;
                };
                _local_5++;
            };
            if (_local_4 > -1)
            {
                propertyList.splice(_local_4, 1);
            };
            return (_local_3);
        }

        override flash_proxy function nextName(_arg_1:int):String
        {
            return (propertyList[(_arg_1 - 1)]);
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            var _local_2:Object;
            return (_item[_arg_1]);
        }

        override flash_proxy function hasProperty(_arg_1:*):Boolean
        {
            return (_arg_1 in _item);
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            if (_arg_1 < propertyList.length)
            {
                return (_arg_1 + 1);
            };
            return (0);
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_4:int;
            var _local_3:* = _item[_arg_1];
            if (_local_3 !== _arg_2)
            {
                _item[_arg_1] = _arg_2;
                _local_4 = 0;
                while (_local_4 < propertyList.length)
                {
                    if (propertyList[_local_4] == _arg_1)
                    {
                        return;
                    };
                    _local_4++;
                };
                propertyList.push(_arg_1);
            };
        }

        override flash_proxy function callProperty(_arg_1:*, ... _args):*
        {
            return (_item[_arg_1].apply(_item, _args));
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (_item[propertyList[(_arg_1 - 1)]]);
        }


    }
}//package mx.messaging.config

