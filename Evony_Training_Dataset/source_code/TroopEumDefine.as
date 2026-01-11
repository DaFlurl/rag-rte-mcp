// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.TroopEumDefine

package com.evony.eum
{
    import flash.xml.XMLNode;
    import flash.xml.XMLDocument;

    public class TroopEumDefine 
    {

        private static var instance:TroopEumDefine = new (TroopEumDefine)();

        private var data:Object = new Object();

        public function TroopEumDefine()
        {
            var _local_3:XMLNode;
            var _local_4:TroopEum;
            super();
            var _local_1:XMLDocument = GetDataXML.instance.getXMLDoc("TroopEumDefine");
            var _local_2:Array = _local_1.lastChild.childNodes;
            for each (_local_3 in _local_2)
            {
                if (_local_3.attributes.typeId)
                {
                    _local_4 = new TroopEum();
                    _local_4.life = _local_3.attributes.life;
                    _local_4.attack = _local_3.attributes.attack;
                    _local_4.defence = _local_3.attributes.defence;
                    _local_4.range = _local_3.attributes.range;
                    _local_4.speed = _local_3.attributes.speed;
                    _local_4.load = _local_3.attributes.load;
                    _local_4.food = _local_3.attributes.food;
                    _local_4.wood = _local_3.attributes.wood;
                    _local_4.stone = _local_3.attributes.stone;
                    _local_4.iron = _local_3.attributes.iron;
                    _local_4.foodRequest = _local_3.attributes.foodRequest;
                    _local_4.time = _local_3.attributes.time;
                    _local_4.population = _local_3.attributes.population;
                    _local_4.name = _local_3.attributes.name;
                    _local_4.desc = _local_3.attributes.desc;
                    _local_4.wikiDesc = _local_3.attributes.wikiDesc;
                    _local_4.typeId = _local_3.attributes.typeId;
                    this.data[_local_4.typeId] = _local_4;
                };
            };
        }

        public static function getTroopEumByType(_arg_1:int):TroopEum
        {
            return (instance.data[_arg_1] as TroopEum);
        }


    }
}//package com.evony.eum

