// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.Base64Encoder

package mx.utils
{
    import flash.utils.ByteArray;

    public class Base64Encoder 
    {

        public static const CHARSET_UTF_8:String = "UTF-8";
        public static var newLine:int = 10;
        public static const MAX_BUFFER_SIZE:uint = 32767;
        private static const ESCAPE_CHAR_CODE:Number = 61;
        private static const ALPHABET_CHAR_CODES:Array = [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 43, 47];

        private var _line:uint;
        private var _count:uint;
        private var _buffers:Array;
        public var insertNewLines:Boolean = true;
        private var _work:Array = [0, 0, 0];

        public function Base64Encoder()
        {
            reset();
        }

        public function flush():String
        {
            if (_count > 0)
            {
                encodeBlock();
            };
            var _local_1:String = drain();
            reset();
            return (_local_1);
        }

        public function toString():String
        {
            return (flush());
        }

        public function reset():void
        {
            _buffers = [];
            _buffers.push([]);
            _count = 0;
            _line = 0;
            _work[0] = 0;
            _work[1] = 0;
            _work[2] = 0;
        }

        public function encodeBytes(_arg_1:ByteArray, _arg_2:uint=0, _arg_3:uint=0):void
        {
            if (_arg_3 == 0)
            {
                _arg_3 = _arg_1.length;
            };
            var _local_4:uint = _arg_1.position;
            _arg_1.position = _arg_2;
            var _local_5:uint = _arg_2;
            var _local_6:uint = (_arg_2 + _arg_3);
            if (_local_6 > _arg_1.length)
            {
                _local_6 = _arg_1.length;
            };
            while (_local_5 < _local_6)
            {
                _work[_count] = _arg_1[_local_5];
                _count++;
                if (((_count == _work.length) || ((_local_6 - _local_5) == 1)))
                {
                    encodeBlock();
                    _count = 0;
                    _work[0] = 0;
                    _work[1] = 0;
                    _work[2] = 0;
                };
                _local_5++;
            };
            _arg_1.position = _local_4;
        }

        public function encode(_arg_1:String, _arg_2:uint=0, _arg_3:uint=0):void
        {
            if (_arg_3 == 0)
            {
                _arg_3 = _arg_1.length;
            };
            var _local_4:uint = _arg_2;
            var _local_5:uint = (_arg_2 + _arg_3);
            if (_local_5 > _arg_1.length)
            {
                _local_5 = _arg_1.length;
            };
            while (_local_4 < _local_5)
            {
                _work[_count] = _arg_1.charCodeAt(_local_4);
                _count++;
                if (((_count == _work.length) || ((_local_5 - _local_4) == 1)))
                {
                    encodeBlock();
                    _count = 0;
                    _work[0] = 0;
                    _work[1] = 0;
                    _work[2] = 0;
                };
                _local_4++;
            };
        }

        private function encodeBlock():void
        {
            var _local_1:Array = (_buffers[(_buffers.length - 1)] as Array);
            if (_local_1.length >= MAX_BUFFER_SIZE)
            {
                _local_1 = [];
                _buffers.push(_local_1);
            };
            _local_1.push(ALPHABET_CHAR_CODES[((_work[0] & 0xFF) >> 2)]);
            _local_1.push(ALPHABET_CHAR_CODES[(((_work[0] & 0x03) << 4) | ((_work[1] & 0xF0) >> 4))]);
            if (_count > 1)
            {
                _local_1.push(ALPHABET_CHAR_CODES[(((_work[1] & 0x0F) << 2) | ((_work[2] & 0xC0) >> 6))]);
            }
            else
            {
                _local_1.push(ESCAPE_CHAR_CODE);
            };
            if (_count > 2)
            {
                _local_1.push(ALPHABET_CHAR_CODES[(_work[2] & 0x3F)]);
            }
            else
            {
                _local_1.push(ESCAPE_CHAR_CODE);
            };
            if (insertNewLines)
            {
                if ((_line = (_line + 4)) == 76)
                {
                    _local_1.push(newLine);
                    _line = 0;
                };
            };
        }

        public function encodeUTFBytes(_arg_1:String):void
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeUTFBytes(_arg_1);
            _local_2.position = 0;
            encodeBytes(_local_2);
        }

        public function drain():String
        {
            var _local_3:Array;
            var _local_1:* = "";
            var _local_2:uint;
            while (_local_2 < _buffers.length)
            {
                _local_3 = (_buffers[_local_2] as Array);
                _local_1 = (_local_1 + String.fromCharCode.apply(null, _local_3));
                _local_2++;
            };
            _buffers = [];
            _buffers.push([]);
            return (_local_1);
        }


    }
}//package mx.utils

