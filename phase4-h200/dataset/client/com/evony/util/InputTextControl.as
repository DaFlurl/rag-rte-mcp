// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.InputTextControl

package com.evony.util
{
    import flash.events.Event;

    public class InputTextControl 
    {


        public static function splitNum(_arg_1:String):String
        {
            var _local_5:String;
            var _local_6:String;
            if (_arg_1 == "")
            {
                return ("0");
            };
            var _local_2:int = _arg_1.indexOf(".");
            var _local_3:int = _arg_1.lastIndexOf(".");
            var _local_4:String = new String();
            if (_local_2 == -1)
            {
                if (_arg_1.length > 3)
                {
                    _local_4 = _arg_1.substring(0, 3);
                }
                else
                {
                    _local_4 = _arg_1;
                };
            }
            else
            {
                _arg_1 = deletePoint(_arg_1);
                _local_5 = _arg_1.substring(0, _local_2);
                if (_local_5.length > 3)
                {
                    _local_5 = _arg_1.substring(0, 3);
                };
                _local_6 = _arg_1.substring(_local_2);
                if (_local_6.length > 4)
                {
                    _local_6 = _arg_1.substring(_local_2, (_local_2 + 4));
                };
                _local_4 = (_local_5 + _local_6);
            };
            return (_local_4);
        }

        private static function deletePoint(_arg_1:String):String
        {
            var _local_2:String = _arg_1;
            var _local_3:int = _arg_1.indexOf(".");
            var _local_4:int = _arg_1.lastIndexOf(".");
            if (_local_3 != _local_4)
            {
                _local_2 = (_arg_1.substr(0, _local_4) + _arg_1.substr((_local_4 + 1)));
            };
            return (_local_2);
        }

        public static function textChange(_arg_1:Event):void
        {
            var _local_2:String = _arg_1.currentTarget.text;
            var _local_3:int;
            while (_local_3 < _local_2.length)
            {
                if ((((_local_2.charAt(_local_3) == '"') || (_local_2.charAt(_local_3) == "'")) || (_local_2.charAt(_local_3) == "\\")))
                {
                    _local_2 = _local_2.substr(0, _local_3);
                };
                _arg_1.currentTarget.text = _local_2;
                _local_3++;
            };
        }


    }
}//package com.evony.util

