// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.EquipTechEumDefine

package com.evony.eum
{
    import flash.utils.Dictionary;

    public class EquipTechEumDefine 
    {

        private static var instance:EquipTechEumDefine = new (EquipTechEumDefine)();

        private var equipWikiArr:Dictionary;
        private var equipTechArr2:Dictionary;
        private var equipTechArr:Dictionary;

        public function EquipTechEumDefine()
        {
            var _local_3:XML;
            var _local_4:String;
            var _local_5:Object;
            var _local_6:XMLList;
            var _local_7:XML;
            var _local_8:EquipTechEum;
            var _local_9:XMLList;
            var _local_10:XML;
            var _local_11:Object;
            var _local_12:XMLList;
            var _local_13:XML;
            var _local_14:Object;
            var _local_15:XMLList;
            var _local_16:XML;
            var _local_17:Object;
            super();
            equipTechArr = new Dictionary();
            equipWikiArr = new Dictionary();
            var _local_1:XML = new XML(GetDataXML.instance.getXMLDoc("EquipTechEumDefine"));
            var _local_2:XMLList = _local_1.*;
            for each (_local_3 in _local_2)
            {
                _local_4 = _local_3.@type;
                _local_5 = new Object();
                _local_5.name = _local_3.@name.toString();
                _local_5.wikiDesc = _local_3.@wikides.toString();
                equipWikiArr[int(_local_4)] = _local_5;
                _local_6 = _local_3.*;
                for each (_local_7 in _local_6)
                {
                    _local_8 = new EquipTechEum();
                    _local_8.tid = ((_local_4 + "_") + _local_7.@lv);
                    _local_8.iconURL = _local_7.@icon;
                    _local_8.name = _local_7.@name;
                    _local_8.desc = _local_7.@des;
                    if (_local_7.hasOwnProperty("buildlist"))
                    {
                        _local_9 = _local_7.buildlist.*;
                        for each (_local_10 in _local_9)
                        {
                            _local_11 = new Object();
                            _local_11.name = _local_10.@name.toString();
                            _local_11.typeId = _local_10.@type.toString();
                            _local_11.lev = _local_10.@lv.toString();
                            _local_8.buildArr.push(_local_11);
                        };
                    };
                    if (_local_7.hasOwnProperty("itemlist"))
                    {
                        _local_12 = _local_7.itemlist.*;
                        for each (_local_13 in _local_12)
                        {
                            _local_14 = new Object();
                            _local_14.name = _local_13.@name.toString();
                            _local_14.id = _local_13.@type.toString();
                            _local_14.num = _local_13.@count.toString();
                            _local_8.itemArr.push(_local_14);
                        };
                    };
                    if (_local_7.hasOwnProperty("upgradeitem"))
                    {
                        _local_15 = _local_7.upgradeitem.*;
                        for each (_local_16 in _local_15)
                        {
                            _local_17 = new Object();
                            _local_17.name = _local_16.@name.toString();
                            _local_17.id = _local_16.@type.toString();
                            _local_17.num = _local_16.@count.toString();
                            _local_8.treasureArr.push(_local_17);
                        };
                    };
                    equipTechArr[_local_8.tid] = _local_8;
                };
            };
        }

        public static function getEquipTechWiki(_arg_1:int):Object
        {
            return (instance.equipWikiArr[_arg_1] as Object);
        }

        public static function getEquipTechEum(_arg_1:String):EquipTechEum
        {
            return (instance.equipTechArr[_arg_1] as EquipTechEum);
        }


    }
}//package com.evony.eum

