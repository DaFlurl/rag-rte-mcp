// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ComponentDescriptor

package mx.core
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ComponentDescriptor 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var events:Object;
        public var type:Class;
        public var document:Object;
        private var _properties:Object;
        public var propertiesFactory:Function;
        public var id:String;

        public function ComponentDescriptor(_arg_1:Object)
        {
            var _local_2:String;
            super();
            for (_local_2 in _arg_1)
            {
                this[_local_2] = _arg_1[_local_2];
            };
        }

        public function toString():String
        {
            return ("ComponentDescriptor_" + id);
        }

        public function invalidateProperties():void
        {
            _properties = null;
        }

        public function get properties():Object
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:int;
            if (_properties)
            {
                return (_properties);
            };
            if (propertiesFactory != null)
            {
                _properties = propertiesFactory.call(document);
            };
            if (_properties)
            {
                _local_1 = _properties.childDescriptors;
                if (_local_1)
                {
                    _local_2 = _local_1.length;
                    _local_3 = 0;
                    while (_local_3 < _local_2)
                    {
                        _local_1[_local_3].document = document;
                        _local_3++;
                    };
                };
            }
            else
            {
                _properties = {};
            };
            return (_properties);
        }


    }
}//package mx.core

