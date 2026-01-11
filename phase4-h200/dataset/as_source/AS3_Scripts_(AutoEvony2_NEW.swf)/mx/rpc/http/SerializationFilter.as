// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.http.SerializationFilter

package mx.rpc.http
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class SerializationFilter 
    {

        mx_internal static var filterForResultFormatTable:Object = new Object();


        public static function registerFilterForResultFormat(_arg_1:String, _arg_2:SerializationFilter):SerializationFilter
        {
            var _local_3:SerializationFilter = filterForResultFormatTable[_arg_1];
            filterForResultFormatTable[_arg_1] = _arg_2;
            return (_local_3);
        }


        public function getRequestContentType(_arg_1:AbstractOperation, _arg_2:Object, _arg_3:String):String
        {
            return (_arg_3);
        }

        public function serializeBody(_arg_1:AbstractOperation, _arg_2:Object):Object
        {
            return (_arg_2);
        }

        public function serializeParameters(_arg_1:AbstractOperation, _arg_2:Array):Object
        {
            var _local_3:Array = _arg_1.argumentNames;
            if (((_arg_2 == null) || (_arg_2.length == 0)))
            {
                return (_arg_2);
            };
            if (((_local_3 == null) || (!(_arg_2.length == _local_3.length))))
            {
                throw (new ArgumentError((((("HTTPMultiService operation called with " + ((_local_3 == null) ? 0 : _local_3.length)) + " argumentNames and ") + _arg_2.length) + " number of parameters.  When argumentNames is specified, it must match the number of arguments passed to the invocation")));
            };
            var _local_4:Object = new Object();
            var _local_5:int;
            while (_local_5 < _local_3.length)
            {
                _local_4[_local_3[_local_5]] = _arg_2[_local_5];
                _local_5++;
            };
            return (_local_4);
        }

        public function deserializeResult(_arg_1:AbstractOperation, _arg_2:Object):Object
        {
            return (_arg_2);
        }

        public function serializeURL(_arg_1:AbstractOperation, _arg_2:Object, _arg_3:String):String
        {
            return (_arg_3);
        }


    }
}//package mx.rpc.http

