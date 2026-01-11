// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.DragSource

package mx.core
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DragSource 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var dataHolder:Object = {};
        private var formatHandlers:Object = {};
        private var _formats:Array = [];


        public function hasFormat(_arg_1:String):Boolean
        {
            var _local_2:int = _formats.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (_formats[_local_3] == _arg_1)
                {
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }

        public function addData(_arg_1:Object, _arg_2:String):void
        {
            _formats.push(_arg_2);
            dataHolder[_arg_2] = _arg_1;
        }

        public function dataForFormat(_arg_1:String):Object
        {
            var _local_2:Object = dataHolder[_arg_1];
            if (_local_2)
            {
                return (_local_2);
            };
            if (formatHandlers[_arg_1])
            {
                return (formatHandlers[_arg_1]());
            };
            return (null);
        }

        public function addHandler(_arg_1:Function, _arg_2:String):void
        {
            _formats.push(_arg_2);
            formatHandlers[_arg_2] = _arg_1;
        }

        public function get formats():Array
        {
            return (_formats);
        }


    }
}//package mx.core

