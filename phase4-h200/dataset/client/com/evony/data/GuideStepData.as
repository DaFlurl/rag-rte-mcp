// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.data.GuideStepData

package com.evony.data
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;

    public class GuideStepData 
    {

        private static var instance:GuideStepData;

        private var guideArr:Dictionary;

        public function GuideStepData()
        {
            var _local_5:Object;
            super();
            guideArr = new Dictionary();
            var _local_1:Class = GuideStepData_xmlClass;
            var _local_2:ByteArray = (new (_local_1)() as ByteArray);
            var _local_3:XML = XML(_local_2);
            var _local_4:int = _local_3.children().length();
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                _local_5 = new Object();
                _local_5.step = _local_3.child(_local_6).@step.toString();
                _local_5.desc = _local_3.child(_local_6).@dec.toString();
                _local_5.textUrl = _local_3.child(_local_6).@textUrl.toString();
                _local_5.mp3Url = _local_3.child(_local_6).@mp3Url.toString();
                guideArr[int(_local_5.step)] = _local_5;
                _local_6++;
            };
        }

        public static function getInstance():GuideStepData
        {
            if (instance == null)
            {
                instance = new (GuideStepData)();
            };
            return (instance);
        }


        public function getValue(_arg_1:int):String
        {
            return (instance.guideArr[_arg_1].desc);
        }

        public function getGuideInfo(_arg_1:int):Object
        {
            return (instance.guideArr[_arg_1]);
        }


    }
}//package com.evony.data

