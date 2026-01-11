// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.questWizard.GuideData

package view.questWizard
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;

    public class GuideData 
    {

        private static var instance:GuideData;

        private var Gtext:Dictionary;
        private var GIDArr:Dictionary;

        public function GuideData()
        {
            var _local_5:Object;
            super();
            GIDArr = new Dictionary();
            var _local_1:Class = GuideData_xmlClass;
            var _local_2:ByteArray = (new (_local_1)() as ByteArray);
            var _local_3:XML = XML(_local_2);
            var _local_4:int = _local_3.children().length();
            var _local_6:int;
            _local_6 = 0;
            while (_local_6 < _local_4)
            {
                _local_5 = new Object();
                _local_5.id = _local_3.child(_local_6).@id.toString();
                _local_5.title = _local_3.child(_local_6).@title.toString();
                _local_5.otitle = _local_3.child(_local_6).@otitle.toString();
                if (_local_3.child(_local_6).@title.length != 0)
                {
                    _local_5.title = _local_3.child(_local_6).@title.toString();
                }
                else
                {
                    _local_5.title = "";
                };
                GIDArr[_local_3.child(_local_6).@id.toString()] = _local_5;
                _local_6++;
            };
        }

        public static function getInstance():GuideData
        {
            if (instance == null)
            {
                instance = new (GuideData)();
            };
            return (instance);
        }


        public function getValue(_arg_1:int):Object
        {
            return (this.GIDArr[_arg_1]);
        }


    }
}//package view.questWizard

