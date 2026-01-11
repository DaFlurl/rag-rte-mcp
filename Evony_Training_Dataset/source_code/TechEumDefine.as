// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.TechEumDefine

package com.evony.eum
{
    import flash.xml.XMLNode;
    import flash.xml.XMLDocument;
    import com.evony.common.beans.AvailableResearchListBean;

    public class TechEumDefine 
    {

        private static var instance:TechEumDefine = new (TechEumDefine)();

        private var map:Object = new Object();
        private var map2:Object = new Object();

        public function TechEumDefine()
        {
            var _local_3:XMLNode;
            var _local_4:TechEum;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:XMLNode;
            var _local_8:XMLNode;
            super();
            var _local_1:XMLDocument = GetDataXML.instance.getXMLDoc("TechEumDefine");
            var _local_2:Array = _local_1.lastChild.childNodes;
            for each (_local_3 in _local_2)
            {
                _local_4 = new TechEum();
                if (_local_3.attributes.typeId)
                {
                    _local_4.typeId = _local_3.attributes.typeId;
                    _local_4.name = _local_3.attributes.name;
                    _local_4.desc = _local_3.attributes.desc;
                    _local_4.wikiDesc = _local_3.attributes.wikiDesc;
                };
                if (_local_3.hasChildNodes())
                {
                    _local_5 = _local_3.firstChild.nextSibling.childNodes;
                    _local_6 = _local_3.lastChild.previousSibling.childNodes;
                    for each (_local_7 in _local_5)
                    {
                        if (_local_7.attributes.level)
                        {
                            _local_4.addUpLevelDesc(new UpLevelDesc(_local_7.attributes.level, _local_7.attributes.upLevelDesc));
                        };
                    };
                    for each (_local_8 in _local_6)
                    {
                        if (_local_8.attributes.level)
                        {
                            _local_4.addLevelData(new TechLevelData(_local_8.attributes.level, _local_8.attributes.food, _local_8.attributes.wood, _local_8.attributes.iron, _local_8.attributes.stone, _local_8.attributes.gold, _local_8.attributes.time, _local_8.attributes.effect));
                        };
                    };
                    map[_local_4.typeId] = _local_4;
                };
            };
        }

        public static function getTime(_arg_1:AvailableResearchListBean):Number
        {
            var _local_2:TechEum = (instance.map[_arg_1.typeId] as TechEum);
            if (_local_2 == null)
            {
                return (0);
            };
            return (_local_2.getLevelData(_arg_1.level).time);
        }

        public static function getTechEumByClassName(_arg_1:String):TechEum
        {
            return (instance.map2[_arg_1] as TechEum);
        }

        public static function getTechEumByType(_arg_1:int):TechEum
        {
            return (instance.map[_arg_1] as TechEum);
        }


    }
}//package com.evony.eum

