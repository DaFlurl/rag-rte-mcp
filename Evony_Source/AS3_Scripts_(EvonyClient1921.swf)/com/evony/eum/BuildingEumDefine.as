// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.BuildingEumDefine

package com.evony.eum
{
    import flash.xml.XMLNode;
    import flash.xml.XMLDocument;
    import com.evony.common.beans.BuildingBean;

    public class BuildingEumDefine 
    {

        private static var instance:BuildingEumDefine = new (BuildingEumDefine)();

        private var map:Object = new Object();

        public function BuildingEumDefine()
        {
            var _local_3:XMLNode;
            var _local_4:BuildingEum;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:XMLNode;
            var _local_8:XMLNode;
            super();
            var _local_1:XMLDocument = GetDataXML.instance.getXMLDoc("BuildingEumDefine");
            var _local_2:Array = _local_1.lastChild.childNodes;
            for each (_local_3 in _local_2)
            {
                _local_4 = new BuildingEum();
                if (_local_3.attributes.typeId)
                {
                    _local_4.name = _local_3.attributes.name;
                    _local_4.desc = _local_3.attributes.desc;
                    _local_4.wikiDesc = _local_3.attributes.wikiDesc;
                    _local_4.typeId = _local_3.attributes.typeId;
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
                            _local_4.addLevelData(new BuildingLevelData(_local_8.attributes.level, _local_8.attributes.workPeople, _local_8.attributes.limit, _local_8.attributes.produce, _local_8.attributes.food, _local_8.attributes.wood, _local_8.attributes.stone, _local_8.attributes.iron, _local_8.attributes.time, _local_8.attributes.buildPeople));
                        };
                    };
                    map[_local_4.typeId] = _local_4;
                };
            };
        }

        public static function getName(_arg_1:int):String
        {
            var _local_2:BuildingEum = (instance.map[_arg_1] as BuildingEum);
            if (_local_2 == null)
            {
                return (_arg_1 + ":null");
            };
            return (_local_2.name);
        }

        public static function getTime(_arg_1:BuildingBean):Number
        {
            var _local_2:BuildingEum = (instance.map[_arg_1.typeId] as BuildingEum);
            if (_local_2 == null)
            {
                return (0);
            };
            return (_local_2.getLevelData(_arg_1.level).time);
        }

        public static function getBuildingEumByType(_arg_1:int):BuildingEum
        {
            return (instance.map[_arg_1] as BuildingEum);
        }

        public static function getDesc(_arg_1:int):String
        {
            var _local_2:BuildingEum = (instance.map[_arg_1] as BuildingEum);
            if (_local_2 == null)
            {
                return (_arg_1 + ":null");
            };
            return (_local_2.desc);
        }


    }
}//package com.evony.eum

