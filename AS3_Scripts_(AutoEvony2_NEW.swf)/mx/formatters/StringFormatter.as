// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.formatters.StringFormatter

package mx.formatters
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class StringFormatter 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var reqFormat:String;
        private var extractToken:Function;
        private var patternInfo:Array;

        public function StringFormatter(_arg_1:String, _arg_2:String, _arg_3:Function)
        {
            formatPattern(_arg_1, _arg_2);
            extractToken = _arg_3;
        }

        public function formatValue(_arg_1:Object):String
        {
            var _local_2:Object = patternInfo[0];
            var _local_3:String = (reqFormat.substring(0, _local_2.begin) + extractToken(_arg_1, _local_2));
            var _local_4:Object = _local_2;
            var _local_5:int = patternInfo.length;
            var _local_6:int = 1;
            while (_local_6 < _local_5)
            {
                _local_2 = patternInfo[_local_6];
                _local_3 = (_local_3 + (reqFormat.substring(_local_4.end, _local_2.begin) + extractToken(_arg_1, _local_2)));
                _local_4 = _local_2;
                _local_6++;
            };
            if (((_local_4.end > 0) && (!(_local_4.end == reqFormat.length))))
            {
                _local_3 = (_local_3 + reqFormat.substring(_local_4.end));
            };
            return (_local_3);
        }

        private function compareValues(_arg_1:Object, _arg_2:Object):int
        {
            if (_arg_1.begin > _arg_2.begin)
            {
                return (1);
            };
            if (_arg_1.begin < _arg_2.begin)
            {
                return (-1);
            };
            return (0);
        }

        private function formatPattern(_arg_1:String, _arg_2:String):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Array = _arg_2.split(",");
            reqFormat = _arg_1;
            patternInfo = [];
            var _local_7:int = _local_6.length;
            var _local_8:int;
            while (_local_8 < _local_7)
            {
                _local_3 = reqFormat.indexOf(_local_6[_local_8]);
                if (((_local_3 >= 0) && (_local_3 < reqFormat.length)))
                {
                    _local_4 = reqFormat.lastIndexOf(_local_6[_local_8]);
                    _local_4 = ((_local_4 >= 0) ? (_local_4 + 1) : (_local_3 + 1));
                    patternInfo.splice(_local_5, 0, {
                        "token":_local_6[_local_8],
                        "begin":_local_3,
                        "end":_local_4
                    });
                    _local_5++;
                };
                _local_8++;
            };
            patternInfo.sort(compareValues);
        }


    }
}//package mx.formatters

