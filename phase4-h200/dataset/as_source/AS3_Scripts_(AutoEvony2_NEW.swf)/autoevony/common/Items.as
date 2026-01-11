// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.Items

package autoevony.common
{
    import flash.xml.XMLNode;
    import com.evony.eum.GetDataXML;
    import flash.xml.XMLDocument;
    import com.evony.eum.ItemEum;
    import com.evony.common.constants.CommonConstants;

    public class Items 
    {

        public static var externalItemNames:Object = null;


        private static function getCommonTypeFromId(_arg_1:String, _arg_2:String):String
        {
            switch (_arg_1)
            {
                case "consume.move.1":
                case "player.more.castle.1.a":
                case "player.more.castle.1.c":
                case "player.move.castle.1.b":
                    return ("Teleporters");
                case "player.box.present.money.69":
                case "player.box.present.money.70":
                case "player.box.present.money.71":
                case "player.box.present.money.72":
                case "player.box.present.money.73":
                case "player.box.present.money.74":
                case "player.box.present.money.75":
                case "player.box.present.money.76":
                case "player.box.present.money.77":
                case "player.box.present.money.77.2":
                case "player.box.present.money.141":
                case "player.box.present.money.142":
                case "player.box.present.money.143":
                case "player.box.present.money.99":
                    return ("Angel/Devil");
                case "player.box.equipment.tech.1":
                case "player.box.equipment.tech.2":
                case "player.box.equipment.tech.3":
                case "player.box.equipment.tech.4":
                case "player.box.equipment.tech.5":
                case "equipment.tech.upgrade.book1":
                    return ("Materials");
                case "player.box.special.1":
                case "player.box.special.2":
                case "player.box.special.3":
                    return ("Medal");
                case "player.box.troop.1":
                case "player.box.troop.a":
                case "player.box.troop.b":
                case "player.box.troop.c":
                case "player.box.troop.d":
                case "player.grank.ballista.a":
                case "player.grank.batteringRam.a":
                case "player.grank.batteringRam.b":
                case "player.grank.batteringRam.c":
                case "player.grank.catapult.a":
                case "player.grank.catapult.b":
                case "player.grank.catapult.c":
                case "player.grank.catapult.d":
                case "player.box.fbgift.troop.grand":
                case "player.box.fbgift.troop.greater":
                case "player.box.fbgift.troop.lesser":
                case "player.box.fbgift.troop.major":
                case "player.box.fbgift.troop.medium":
                case "player.box.fbgift.troop.minor":
                case "player.box.fbgift.troop.normal":
                case "player.box.fbgift.troop.royal":
                case "player.box.fbgift.troop.super":
                case "player.box.fbgift.troop.superior":
                case "player.box.randomevent.troop.cavalry.lesser":
                case "player.box.randomevent.troop.cavalry.medium":
                case "player.box.randomevent.troop.pikeman.lesser":
                case "player.box.randomevent.troop.pikeman.medium":
                case "player.box.randomevent.troop.swordsman.lesser":
                case "player.box.randomevent.troop.swordsman.medium":
                case "player.box.randomevent.troop.warrior.lesser":
                case "player.box.randomevent.troop.warrior.medium":
                    return ("Troops");
                case "player.box.fbgift.farming":
                case "player.box.fbgift.lumbering":
                case "player.box.fbgift.mining":
                    return ("Produce");
                case "player.box.romanbuildingkit":
                case "player.box.toolbarbonus1.greater":
                case "player.box.toolbarbonus1.lesser":
                case "player.box.toolbarbonus1.medium":
                case "player.box.toolbarbonus1.superior":
                case "player.box.toolbarbonus2.greater":
                case "player.box.toolbarbonus2.lesser":
                case "player.box.toolbarbonus2.medium":
                case "player.box.toolbarbonus2.superior":
                case "player.box.visit.greater.1":
                case "player.box.visit.greater.2":
                case "player.box.visit.lesser.1":
                case "player.box.visit.lesser.2":
                case "player.box.visit.major":
                case "player.box.visit.medium.1":
                case "player.box.visit.medium.2":
                case "player.box.visit.minor.1":
                case "player.box.visit.minor.2":
                case "player.item.resources":
                case "player.reward.bonus.food":
                case "player.reward.bonus.gold":
                case "player.reward.bonus.iron":
                case "player.reward.bonus.stone":
                case "player.reward.bonus.wood":
                case "player.box.resource.1":
                case "player.box.online.bonus.1":
                case "player.box.online.bonus.2":
                case "player.box.online.bonus.3":
                case "player.box.gambling.food":
                case "player.box.gambling.food.1000000":
                case "player.box.gambling.food.10000000":
                case "player.box.gambling.gold":
                case "player.box.gambling.gold.1000000":
                case "player.box.gambling.gold.10000000":
                case "player.box.gambling.iron":
                case "player.box.gambling.iron.1000000":
                case "player.box.gambling.iron.10000000":
                case "player.box.gambling.stone":
                case "player.box.gambling.stone.1000000":
                case "player.box.gambling.stone.10000000":
                case "player.box.gambling.wood":
                case "player.box.gambling.wood.1000000":
                case "player.box.gambling.wood.10000000":
                case "player.box.fbgift.food.grand":
                case "player.box.fbgift.food.greater":
                case "player.box.fbgift.food.lesser":
                case "player.box.fbgift.food.major":
                case "player.box.fbgift.food.medium":
                case "player.box.fbgift.food.minor":
                case "player.box.fbgift.food.normal":
                case "player.box.fbgift.food.royal":
                case "player.box.fbgift.food.super":
                case "player.box.fbgift.food.superior":
                case "player.box.fbgift.gold.grand":
                case "player.box.fbgift.gold.greater":
                case "player.box.fbgift.gold.lesser":
                case "player.box.fbgift.gold.major":
                case "player.box.fbgift.gold.medium":
                case "player.box.fbgift.gold.minor":
                case "player.box.fbgift.gold.normal":
                case "player.box.fbgift.gold.royal":
                case "player.box.fbgift.gold.super":
                case "player.box.fbgift.gold.superior":
                case "player.box.fbgift.iron.grand":
                case "player.box.fbgift.iron.greater":
                case "player.box.fbgift.iron.lesser":
                case "player.box.fbgift.iron.major":
                case "player.box.fbgift.iron.medium":
                case "player.box.fbgift.iron.minor":
                case "player.box.fbgift.iron.normal":
                case "player.box.fbgift.iron.royal":
                case "player.box.fbgift.iron.super":
                case "player.box.fbgift.iron.superior":
                case "player.box.fbgift.stone.grand":
                case "player.box.fbgift.stone.greater":
                case "player.box.fbgift.stone.lesser":
                case "player.box.fbgift.stone.major":
                case "player.box.fbgift.stone.medium":
                case "player.box.fbgift.stone.minor":
                case "player.box.fbgift.stone.normal":
                case "player.box.fbgift.stone.royal":
                case "player.box.fbgift.stone.super":
                case "player.box.fbgift.stone.superior":
                case "player.box.fbgift.wood.grand":
                case "player.box.fbgift.wood.greater":
                case "player.box.fbgift.wood.lesser":
                case "player.box.fbgift.wood.major":
                case "player.box.fbgift.wood.medium":
                case "player.box.fbgift.wood.minor":
                case "player.box.fbgift.wood.normal":
                case "player.box.fbgift.wood.royal":
                case "player.box.fbgift.wood.super":
                case "player.box.fbgift.wood.superior":
                    return ("Resource");
                default:
                    return (_arg_2);
            };
        }

        private static function initExternalItemNames():void
        {
            var _local_5:XMLNode;
            var _local_1:XMLDocument = GetDataXML.instance.getXMLDoc("ItemEumDefine");
            var _local_2:Object = new Object();
            externalItemNames = new Object();
            var _local_3:String;
            var _local_4:ItemEum;
            for each (_local_5 in _local_1.firstChild.nextSibling.childNodes)
            {
                if (!((_local_5.attributes.id == undefined) || (_local_5.attributes.name == undefined)))
                {
                    _local_3 = Utils.trim(_local_5.attributes.name).split(" ").join("_");
                    if (_local_2[_local_3] == undefined)
                    {
                        _local_2[_local_3] = 0;
                    }
                    else
                    {
                        _local_2[_local_3]++;
                        _local_3 = (_local_3 + _local_2[_local_3]);
                    };
                    _local_4 = new ItemEum();
                    _local_4.id = Utils.trim(_local_5.attributes.id);
                    _local_4.name = _local_3;
                    _local_4.itemType = Utils.trim(_local_5.attributes.itemType);
                    _local_4.dayLimit = _local_5.attributes.dayLimit;
                    _local_4.userLimit = _local_5.attributes.userLimit;
                    _local_4.desc = Utils.trim(_local_5.attributes.desc);
                    _local_4.itemDesc = Utils.trim(_local_5.attributes.itemDesc);
                    _local_4.iconUrl = Utils.trim(_local_5.attributes.iconUrl);
                    _local_4.price = _local_5.attributes.price;
                    _local_4.heroItem = ((_local_5.attributes.heroItem == undefined) ? false : Utils.trim(_local_5.attributes.heroItem));
                    _local_4.playerItem = ((_local_5.attributes.playerItem == undefined) ? false : Utils.trim(_local_5.attributes.playerItem));
                    externalItemNames[_local_4.id] = _local_4;
                };
            };
        }

        public static function getItemId(_arg_1:String):String
        {
            var _local_2:ItemEum;
            if (externalItemNames == null)
            {
                initExternalItemNames();
            };
            _arg_1 = _arg_1.toLowerCase().replace(/\’/g, "'");
            if (_arg_1 == "amulet5")
            {
                _arg_1 = "aries_amulet";
            };
            for each (_local_2 in externalItemNames)
            {
                if (_local_2.name.toLowerCase().replace(/\’/g, "'") == _arg_1)
                {
                    return (_local_2.id);
                };
            };
            if (_arg_1.indexOf(".") != -1)
            {
                return (_arg_1);
            };
            return (null);
        }

        public static function getItemEumById(_arg_1:String):ItemEum
        {
            if (externalItemNames == null)
            {
                initExternalItemNames();
            };
            if (externalItemNames[_arg_1] == undefined)
            {
                return (null);
            };
            return (externalItemNames[_arg_1] as ItemEum);
        }

        public static function getCommonType(_arg_1:String, _arg_2:String=null):String
        {
            if (_arg_1 != null)
            {
                switch (_arg_1)
                {
                    case CommonConstants.ITEM_TYPE_TREASURE:
                        if (_arg_2 == null)
                        {
                            return ("Items");
                        };
                        return (getCommonTypeFromId(_arg_2, "Items"));
                    case CommonConstants.ITEM_TYPE_SPEEDUP:
                        return ("Speed Up");
                    case CommonConstants.ITEM_TYPE_RESOURCE:
                        return ("Produce");
                    case CommonConstants.ITEM_TYPE_PACKET:
                        if (_arg_2 == null)
                        {
                            return ("Chest");
                        };
                        return (getCommonTypeFromId(_arg_2, "Chest"));
                    case CommonConstants.ITEM_TYPE_MEDAL:
                        return ("Medal");
                    case CommonConstants.ITEM_TYPE_TASK:
                        return ("Quests");
                    case CommonConstants.ITEM_TYPE_MATERIALS:
                        return ("Materials");
                    case CommonConstants.ITEM_TYPE_TRICK:
                        return ("Stratagem");
                    case "天使/恶魔":
                        return ("Angel/Devil");
                    case "军队":
                        return ("Troops");
                    case "资源":
                        return ("Resource");
                    default:
                        if (_arg_2 == null)
                        {
                            return ("Items");
                        };
                        return (getCommonTypeFromId(_arg_2, "Items"));
                };
            };
            return (null);
        }

        public static function getItemName(_arg_1:String):String
        {
            if (externalItemNames == null)
            {
                initExternalItemNames();
            };
            if (externalItemNames[_arg_1] == undefined)
            {
                return (_arg_1);
            };
            return ((externalItemNames[_arg_1] as ItemEum).name);
        }

        public static function addPacketItem(_arg_1:String):String
        {
            var _local_8:*;
            if (externalItemNames == null)
            {
                initExternalItemNames();
            };
            var _local_2:* = "";
            var _local_3:* = "";
            var _local_4:int;
            var _local_5:ItemEum;
            var _local_6:ItemEum;
            var _local_7:XML = new XML(_arg_1);
            for each (_local_8 in _local_7.items.itemEum)
            {
                if (_local_8.@id != undefined)
                {
                    if ((_local_6 = getItemEumById(Utils.trim(_local_8.@id))) != null)
                    {
                        _local_5 = new ItemEum();
                        _local_5.id = _local_6.id;
                        _local_5.name = (((((_local_6.name == null) || (_local_6.name == "")) || (_local_6.name == _local_6.id)) && (!(_local_8.@name == undefined))) ? Utils.trim(_local_8.@name).split(" ").join("_") : _local_6.name);
                        _local_5.itemType = ((((((!(_local_8.@itemType == undefined)) && (!(_local_8.@itemType == ""))) && (!(_local_8.@itemType == " "))) && (!(_local_8.@itemType == "?"))) && (!(_local_8.@itemType == "??"))) ? Utils.trim(_local_8.@itemType) : _local_6.itemType);
                        _local_5.dayLimit = ((_local_8.@dayLimit != undefined) ? int(_local_8.@dayLimit) : _local_6.dayLimit);
                        _local_5.userLimit = ((_local_8.@userLimit != undefined) ? int(_local_8.@userLimit) : _local_6.userLimit);
                        _local_5.desc = ((((!(_local_8.@desc == undefined)) && (!(_local_8.@desc == ""))) && (!(_local_8.@desc == " "))) ? Utils.trim(_local_8.@desc) : _local_6.desc);
                        _local_5.itemDesc = ((((!(_local_8.@itemDesc == undefined)) && (!(_local_8.@itemDesc == ""))) && (!(_local_8.@itemDesc == " "))) ? Utils.trim(_local_8.@itemDesc) : _local_6.itemDesc);
                        _local_5.iconUrl = ((_local_8.@iconUrl != undefined) ? Utils.trim(_local_8.@iconUrl) : _local_6.iconUrl);
                        _local_5.price = ((_local_8.@price != undefined) ? int(_local_8.@price) : _local_6.price);
                        _local_5.heroItem = ((_local_8.@heroItem == undefined) ? _local_6.heroItem : Utils.trim(_local_8.@heroItem));
                        _local_5.playerItem = ((_local_8.@playerItem == undefined) ? _local_6.playerItem : Utils.trim(_local_8.@playerItem));
                    }
                    else
                    {
                        _local_5 = new ItemEum();
                        _local_5.id = Utils.trim(_local_8.@id);
                        if (_local_8.@name != undefined)
                        {
                            _local_2 = Utils.trim(Utils.trim(_local_8.@name).split(" ").join("_"));
                            _local_6 = getItemEumByName(_local_2);
                            _local_5.name = (_local_2 + ((_local_6 == null) ? "" : ("_" + new Date().fullYear)));
                        }
                        else
                        {
                            _local_5.name = Utils.trim(_local_8.@id);
                        };
                        _local_5.itemType = Utils.trim(_local_8.@itemType);
                        _local_5.dayLimit = _local_8.@dayLimit;
                        _local_5.userLimit = _local_8.@userLimit;
                        _local_5.desc = Utils.trim(_local_8.@desc);
                        _local_5.itemDesc = Utils.trim(_local_8.@itemDesc);
                        _local_5.iconUrl = Utils.trim(_local_8.@iconUrl);
                        _local_5.price = _local_8.@price;
                        _local_5.heroItem = ((_local_8.@heroItem == undefined) ? false : Utils.trim(_local_8.@heroItem));
                        _local_5.playerItem = ((_local_8.@playerItem == undefined) ? false : Utils.trim(_local_8.@playerItem));
                    };
                    if (_local_5.id == "player.bavarian.brew")
                    {
                        _local_5.desc = "Use this item for 24 hour for a 100% upkeep buff between Sep 27th and Oct 7th.";
                        _local_5.itemDesc = "A gift from your friends during the Evonytoberfest promotion! Use this item to get 24 hours of 100% upkeep in ALL of your cities! The Bavarian Brew must be used between Sep 27th and Oct 7th and is stackable, allowing you to increase the available buff time. On October 8th the buff will expire.";
                    };
                    _local_3 = (_local_3 + (((((("\n" + ++_local_4) + ":  <b>") + _local_5.name) + "</b>  price: <b>") + _local_5.price) + "</b>"));
                    externalItemNames[_local_5.id] = _local_5;
                };
            };
            return (((_local_3 != "") ? (("Received item detail updates for " + _local_4) + " items:") : "") + _local_3);
        }

        public static function getItemEumByName(_arg_1:String):ItemEum
        {
            var _local_2:ItemEum;
            if (externalItemNames == null)
            {
                initExternalItemNames();
            };
            _arg_1 = _arg_1.toLowerCase().replace(/\’/g, "'");
            if (_arg_1 == "amulet5")
            {
                _arg_1 = "aries_amulet";
            };
            for each (_local_2 in externalItemNames)
            {
                if (_local_2.name.toLowerCase().replace(/\’/g, "'") == _arg_1)
                {
                    return (_local_2);
                };
            };
            if (_arg_1.indexOf(".") != -1)
            {
                _local_2 = new ItemEum();
                _local_2.id = _arg_1;
                _local_2.name = _arg_1;
                _local_2.itemType = "";
                _local_2.dayLimit = -1;
                _local_2.userLimit = -1;
                _local_2.desc = "";
                _local_2.itemDesc = "";
                _local_2.iconUrl = "";
                _local_2.price = 0;
                _local_2.heroItem = false;
                _local_2.playerItem = true;
                return (_local_2);
            };
            return (null);
        }


    }
}//package autoevony.common

