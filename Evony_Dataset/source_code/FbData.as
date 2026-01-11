// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.data.FbData

package com.evony.data
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;

    public class FbData 
    {

        private static var instance:FbData;

        private var fbActionLinkArr:Dictionary;
        private var fbArr:Dictionary;

        public function FbData()
        {
            var _local_6:Object;
            super();
            fbArr = new Dictionary();
            var _local_1:Class = FbData_xmlClass;
            var _local_2:Class = FbData_xmlActionLink;
            var _local_3:ByteArray = (new (_local_1)() as ByteArray);
            var _local_4:XML = XML(_local_3);
            var _local_5:int = _local_4.children().length();
            var _local_7:int;
            fbActionLinkArr = new Dictionary();
            _local_7 = 0;
            while (_local_7 < _local_5)
            {
                _local_6 = new Object();
                _local_6.id = _local_4.child(_local_7).@id.toString();
                _local_6.type = _local_4.child(_local_7).@type.toString();
                _local_6.action_link_type = _local_4.child(_local_7).@action_link_type.toString();
                _local_6.desc = _local_4.child(_local_7).@desc.toString();
                _local_6.contentA = _local_4.child(_local_7).@contentA.toString();
                _local_6.contentB = _local_4.child(_local_7).@contentB.toString();
                _local_6.img = _local_4.child(_local_7).@img.toString();
                if (_local_4.child(_local_7).@title.length != 0)
                {
                    _local_6.title = _local_4.child(_local_7).@title.toString();
                }
                else
                {
                    _local_6.title = "";
                };
                if (_local_4.child(_local_7).@strYesBtnText.length != 0)
                {
                    _local_6.strYesBtnText = _local_4.child(_local_7).@strYesBtnText.toString();
                }
                else
                {
                    _local_6.strYesBtnText = "";
                };
                if (_local_4.child(_local_7).@strNoBtnText.length != 0)
                {
                    _local_6.strNoBtnText = _local_4.child(_local_7).@strNoBtnText.toString();
                }
                else
                {
                    _local_6.strNoBtnText = "";
                };
                fbArr[_local_4.child(_local_7).@id.toString()] = _local_6;
                _local_7++;
            };
            _local_3 = (new (_local_2)() as ByteArray);
            _local_4 = XML(_local_3);
            _local_5 = _local_4.children().length();
            _local_7 = 0;
            while (_local_7 < _local_5)
            {
                _local_6 = new Object();
                _local_6.id = _local_4.child(_local_7).@id.toString();
                _local_6.label = _local_4.child(_local_7).@label.toString();
                fbActionLinkArr[_local_4.child(_local_7).@id.toString()] = _local_6;
                _local_7++;
            };
        }

        public static function getInstance():FbData
        {
            if (instance == null)
            {
                instance = new (FbData)();
            };
            return (instance);
        }


        public function getActionLink(_arg_1:int):Object
        {
            return (this.fbActionLinkArr[_arg_1]);
        }

        public function getValue(_arg_1:int):Object
        {
            return (this.fbArr[_arg_1]);
        }


    }
}//package com.evony.data

