// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.FortificationEumDefine

package com.evony.eum
{
    import flash.xml.XMLNode;
    import flash.xml.XMLDocument;

    public class FortificationEumDefine 
    {

        private static var instance:FortificationEumDefine = new (FortificationEumDefine)();

        private var map:Object = new Object();

        public function FortificationEumDefine()
        {
            var _local_3:XMLNode;
            var _local_4:FortificationEum;
            super();
            var _local_1:XMLDocument = GetDataXML.instance.getXMLDoc("FortificationEumDefine");
            var _local_2:Array = _local_1.lastChild.childNodes;
            for each (_local_3 in _local_2)
            {
                if (_local_3.attributes.typeId)
                {
                    _local_4 = new FortificationEum();
                    _local_4.typeId = _local_3.attributes.typeId;
                    _local_4.name = _local_3.attributes.name;
                    _local_4.desc = _local_3.attributes.desc;
                    _local_4.wikiDesc = _local_3.attributes.wikiDesc;
                    _local_4.food = _local_3.attributes.food;
                    _local_4.wood = _local_3.attributes.wood;
                    _local_4.stone = _local_3.attributes.stone;
                    _local_4.iron = _local_3.attributes.iron;
                    _local_4.time = _local_3.attributes.time;
                    _local_4.repairRate = _local_3.attributes.repairRate;
                    _local_4.space = _local_3.attributes.space;
                    _local_4.life = _local_3.attributes.life;
                    _local_4.defence = _local_3.attributes.defence;
                    _local_4.attack = _local_3.attributes.attack;
                    _local_4.range = _local_3.attributes.range;
                    map[_local_4.typeId] = _local_4;
                };
            };
        }

        public static function getFortificationEumByType(_arg_1:int):FortificationEum
        {
            return (instance.map[_arg_1] as FortificationEum);
        }


    }
}//package com.evony.eum

