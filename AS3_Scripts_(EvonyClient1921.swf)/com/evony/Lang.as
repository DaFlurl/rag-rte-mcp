// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.Lang

package com.evony
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import mx.utils.StringUtil;

    public class Lang 
    {

        private static var instance:Lang = new (Lang)();

        private var dic:Dictionary;

        public function Lang()
        {
            var _local_1:Class = Lang_xmlClass;
            var _local_2:ByteArray = (new (_local_1)() as ByteArray);
            var _local_3:XML = XML(_local_2);
            dic = new Dictionary();
            this.analyzeXML(_local_3);
        }

        public static function msg(_arg_1:String, ... _args):String
        {
            var _local_3:String = _arg_1;
            if (MsgDispacther.getInstance().useEnglish)
            {
                _local_3 = instance.getValue(_arg_1);
            };
            if (((!(_args == null)) && (_args.length > 0)))
            {
                return (StringUtil.substitute(_local_3, _args));
            };
            return (_local_3);
        }


        private function getValue(_arg_1:String):String
        {
            if (dic[_arg_1] == null)
            {
                return (("!!!!! 需要翻译[" + _arg_1) + "]");
            };
            return (String(dic[_arg_1]));
        }

        private function analyzeXML(_arg_1:XML):void
        {
            var _local_4:*;
            var _local_5:int;
            var _local_6:*;
            var _local_2:int = _arg_1.child("*").length();
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (((_arg_1.child(_local_3).attribute("key") == "") || (_arg_1.child(_local_3).attribute("key") == undefined)))
                {
                    analyzeXML(XML(_arg_1.child(_local_3)));
                }
                else
                {
                    _local_4 = _arg_1.child(_local_3).attribute("key");
                    _local_5 = 2;
                    if (GameConfig.instance.strLanguage == "English")
                    {
                        _local_5 = 2;
                    }
                    else
                    {
                        if (GameConfig.instance.strLanguage == "French")
                        {
                            _local_5 = 1;
                        };
                    };
                    _local_6 = XML(_arg_1.child(_local_3)).child(_local_5);
                    this.put(_local_4, _local_6, dic);
                };
                _local_3++;
            };
        }

        private function put(_arg_1:String, _arg_2:String, _arg_3:Dictionary):void
        {
            if (_arg_3[_arg_1])
            {
                trace(("重复 key=" + _arg_1));
            };
            _arg_3[_arg_1] = _arg_2;
        }


    }
}//package com.evony

