// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.BadWordCollection

package com.evony
{
    import com.evony.util.UIUtil;

    public class BadWordCollection 
    {

        public static var instance:BadWordCollection = new (BadWordCollection)();

        private var badWordArr:Array = [];

        public function BadWordCollection()
        {
            UIUtil.loadFile("badWord.txt", onLoadCompleter);
        }

        public function getBadWords():Array
        {
            return (badWordArr);
        }

        public function isBadWord(_arg_1:String):Boolean
        {
            var _local_3:int;
            var _local_2:Boolean;
            if (badWordArr.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < badWordArr.length)
                {
                    if (_arg_1 == badWordArr[_local_3])
                    {
                        _local_2 = true;
                        break;
                    };
                    _local_3++;
                };
            };
            return (_local_2);
        }

        private function onLoadCompleter(_arg_1:String):void
        {
            badWordArr = _arg_1.split("\r\n");
        }


    }
}//package com.evony

