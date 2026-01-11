// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.ItemEumDefine

package com.evony.eum
{
    import flash.xml.XMLNode;
    import flash.xml.XMLDocument;

    public class ItemEumDefine 
    {

        private static var instance:ItemEumDefine = new (ItemEumDefine)();

        private var itemArray:Array = new Array();
        private var packetArray:Array = new Array();
        private var packetArray2:Array = new Array();

        public function ItemEumDefine()
        {
            var _local_3:XMLNode;
            var _local_4:ItemEum;
            super();
            var _local_1:XMLDocument = GetDataXML.instance.getXMLDoc("ItemEumDefine");
            var _local_2:Array = _local_1.lastChild.childNodes;
            for each (_local_3 in _local_2)
            {
                if (_local_3.attributes.id)
                {
                    _local_4 = new ItemEum();
                    _local_4.id = _local_3.attributes.id;
                    _local_4.name = _local_3.attributes.name;
                    _local_4.itemType = _local_3.attributes.itemType;
                    _local_4.dayLimit = _local_3.attributes.dayLimit;
                    _local_4.userLimit = _local_3.attributes.userLimit;
                    _local_4.desc = _local_3.attributes.desc;
                    _local_4.itemDesc = _local_3.attributes.itemDesc;
                    _local_4.iconUrl = _local_3.attributes.iconUrl;
                    _local_4.price = _local_3.attributes.price;
                    _local_4.heroItem = _local_3.attributes.heroItem;
                    _local_4.playerItem = _local_3.attributes.playerItem;
                    itemArray[_local_4.id] = _local_4;
                };
            };
        }

        public static function getItemEum(_arg_1:String):ItemEum
        {
            return (instance.itemArray[_arg_1] as ItemEum);
        }

        public static function getPacketItemEumArray2():Array
        {
            return (instance.packetArray2);
        }

        public static function addPacketItem(_arg_1:String):void
        {
            var _local_3:*;
            var _local_4:*;
            var _local_5:ItemEum;
            var _local_2:XML = new XML(_arg_1);
            for each (_local_3 in _local_2.items.itemEum)
            {
                if (_local_3.@id)
                {
                    _local_5 = new ItemEum();
                    _local_5.id = _local_3.@id;
                    _local_5.name = _local_3.@name;
                    _local_5.itemType = _local_3.@itemType;
                    _local_5.dayLimit = _local_3.@dayLimit;
                    _local_5.userLimit = _local_3.@userLimit;
                    _local_5.desc = _local_3.@desc;
                    _local_5.itemDesc = _local_3.@itemDesc;
                    _local_5.iconUrl = _local_3.@iconUrl;
                    _local_5.price = _local_3.@price;
                    _local_5.heroItem = _local_3.@heroItem;
                    _local_5.playerItem = _local_3.@playerItem;
                    if (_local_5.id == "player.bavarian.brew")
                    {
                        _local_5.desc = "Use this item for 24 hour for a 100% upkeep buff between Sep 27th and Oct 7th.";
                        _local_5.itemDesc = "A gift from your friends during the Evonytoberfest promotion! Use this item to get 24 hours of 100% upkeep in ALL of your cities! The Bavarian Brew must be used between Sep 27th and Oct 7th and is stackable, allowing you to increase the available buff time. On October 8th the buff will expire.";
                    };
                    instance.itemArray[_local_5.id] = _local_5;
                };
            };
            for each (_local_4 in _local_2.special.pack)
            {
                if (_local_4.@id)
                {
                    _local_5 = new ItemEum();
                    _local_5.id = _local_4.@id;
                    instance.packetArray[_local_5.id] = _local_5;
                };
            };
            for each (_local_4 in _local_2.special2.pack)
            {
                if (_local_4.@id)
                {
                    _local_5 = new ItemEum();
                    _local_5.id = _local_4.@id;
                    instance.packetArray2[_local_5.id] = _local_5;
                };
            };
        }

        public static function getItemEumArray():Array
        {
            return (instance.itemArray);
        }

        public static function getPacketItemEumArray():Array
        {
            return (instance.packetArray);
        }


    }
}//package com.evony.eum

