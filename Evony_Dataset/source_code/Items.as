package autoevony.common
{
   import com.evony.common.constants.CommonConstants;
   import com.evony.eum.GetDataXML;
   import com.evony.eum.ItemEum;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   
   public class Items
   {
      public static var externalItemNames:Object = null;
      
      public function Items()
      {
         super();
      }
      
      private static function getCommonTypeFromId(param1:String, param2:String) : String
      {
         switch(param1)
         {
            case "consume.move.1":
            case "player.more.castle.1.a":
            case "player.more.castle.1.c":
            case "player.move.castle.1.b":
               return "Teleporters";
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
               return "Angel/Devil";
            case "player.box.equipment.tech.1":
            case "player.box.equipment.tech.2":
            case "player.box.equipment.tech.3":
            case "player.box.equipment.tech.4":
            case "player.box.equipment.tech.5":
            case "equipment.tech.upgrade.book1":
               return "Materials";
            case "player.box.special.1":
            case "player.box.special.2":
            case "player.box.special.3":
               return "Medal";
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
               return "Troops";
            case "player.box.fbgift.farming":
            case "player.box.fbgift.lumbering":
            case "player.box.fbgift.mining":
               return "Produce";
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
               return "Resource";
            default:
               return param2;
         }
      }
      
      private static function initExternalItemNames() : void
      {
         var _loc5_:XMLNode = null;
         var _loc1_:XMLDocument = GetDataXML.instance.getXMLDoc("ItemEumDefine");
         var _loc2_:Object = new Object();
         externalItemNames = new Object();
         var _loc3_:String = null;
         var _loc4_:ItemEum = null;
         for each(_loc5_ in _loc1_.firstChild.nextSibling.childNodes)
         {
            if(!(_loc5_.attributes.id == undefined || _loc5_.attributes.name == undefined))
            {
               _loc3_ = Utils.trim(_loc5_.attributes.name).split(" ").join("_");
               if(_loc2_[_loc3_] == undefined)
               {
                  _loc2_[_loc3_] = 0;
               }
               else
               {
                  ++_loc2_[_loc3_];
                  _loc3_ += _loc2_[_loc3_];
               }
               _loc4_ = new ItemEum();
               _loc4_.id = Utils.trim(_loc5_.attributes.id);
               _loc4_.name = _loc3_;
               _loc4_.itemType = Utils.trim(_loc5_.attributes.itemType);
               _loc4_.dayLimit = _loc5_.attributes.dayLimit;
               _loc4_.userLimit = _loc5_.attributes.userLimit;
               _loc4_.desc = Utils.trim(_loc5_.attributes.desc);
               _loc4_.itemDesc = Utils.trim(_loc5_.attributes.itemDesc);
               _loc4_.iconUrl = Utils.trim(_loc5_.attributes.iconUrl);
               _loc4_.price = _loc5_.attributes.price;
               _loc4_.heroItem = _loc5_.attributes.heroItem == undefined ? false : Boolean(Utils.trim(_loc5_.attributes.heroItem));
               _loc4_.playerItem = _loc5_.attributes.playerItem == undefined ? false : Boolean(Utils.trim(_loc5_.attributes.playerItem));
               externalItemNames[_loc4_.id] = _loc4_;
            }
         }
      }
      
      public static function getItemId(param1:String) : String
      {
         var _loc2_:ItemEum = null;
         if(externalItemNames == null)
         {
            initExternalItemNames();
         }
         param1 = param1.toLowerCase().replace(/\’/g,"\'");
         if(param1 == "amulet5")
         {
            param1 = "aries_amulet";
         }
         for each(_loc2_ in externalItemNames)
         {
            if(_loc2_.name.toLowerCase().replace(/\’/g,"\'") == param1)
            {
               return _loc2_.id;
            }
         }
         if(param1.indexOf(".") != -1)
         {
            return param1;
         }
         return null;
      }
      
      public static function getItemEumById(param1:String) : ItemEum
      {
         if(externalItemNames == null)
         {
            initExternalItemNames();
         }
         if(externalItemNames[param1] == undefined)
         {
            return null;
         }
         return externalItemNames[param1] as ItemEum;
      }
      
      public static function getCommonType(param1:String, param2:String = null) : String
      {
         if(param1 != null)
         {
            switch(param1)
            {
               case CommonConstants.ITEM_TYPE_TREASURE:
                  if(param2 == null)
                  {
                     return "Items";
                  }
                  return getCommonTypeFromId(param2,"Items");
                  break;
               case CommonConstants.ITEM_TYPE_SPEEDUP:
                  return "Speed Up";
               case CommonConstants.ITEM_TYPE_RESOURCE:
                  return "Produce";
               case CommonConstants.ITEM_TYPE_PACKET:
                  if(param2 == null)
                  {
                     return "Chest";
                  }
                  return getCommonTypeFromId(param2,"Chest");
                  break;
               case CommonConstants.ITEM_TYPE_MEDAL:
                  return "Medal";
               case CommonConstants.ITEM_TYPE_TASK:
                  return "Quests";
               case CommonConstants.ITEM_TYPE_MATERIALS:
                  return "Materials";
               case CommonConstants.ITEM_TYPE_TRICK:
                  return "Stratagem";
               case "天使/恶魔":
                  return "Angel/Devil";
               case "军队":
                  return "Troops";
               case "资源":
                  return "Resource";
               default:
                  if(param2 == null)
                  {
                     return "Items";
                  }
                  return getCommonTypeFromId(param2,"Items");
            }
         }
         else
         {
            return null;
         }
      }
      
      public static function getItemName(param1:String) : String
      {
         if(externalItemNames == null)
         {
            initExternalItemNames();
         }
         if(externalItemNames[param1] == undefined)
         {
            return param1;
         }
         return (externalItemNames[param1] as ItemEum).name;
      }
      
      public static function addPacketItem(param1:String) : String
      {
         var _loc8_:* = undefined;
         if(externalItemNames == null)
         {
            initExternalItemNames();
         }
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:int = 0;
         var _loc5_:ItemEum = null;
         var _loc6_:ItemEum = null;
         var _loc7_:XML = new XML(param1);
         for each(_loc8_ in _loc7_.items.itemEum)
         {
            if(_loc8_.@id != undefined)
            {
               _loc6_ = getItemEumById(Utils.trim(_loc8_.@id));
               if(_loc6_ != null)
               {
                  _loc5_ = new ItemEum();
                  _loc5_.id = _loc6_.id;
                  _loc5_.name = (_loc6_.name == null || _loc6_.name == "" || _loc6_.name == _loc6_.id) && _loc8_.@name != undefined ? Utils.trim(_loc8_.@name).split(" ").join("_") : _loc6_.name;
                  _loc5_.itemType = _loc8_.@itemType != undefined && _loc8_.@itemType != "" && _loc8_.@itemType != " " && _loc8_.@itemType != "?" && _loc8_.@itemType != "??" ? Utils.trim(_loc8_.@itemType) : _loc6_.itemType;
                  _loc5_.dayLimit = _loc8_.@dayLimit != undefined ? int(_loc8_.@dayLimit) : _loc6_.dayLimit;
                  _loc5_.userLimit = _loc8_.@userLimit != undefined ? int(_loc8_.@userLimit) : _loc6_.userLimit;
                  _loc5_.desc = _loc8_.@desc != undefined && _loc8_.@desc != "" && _loc8_.@desc != " " ? Utils.trim(_loc8_.@desc) : _loc6_.desc;
                  _loc5_.itemDesc = _loc8_.@itemDesc != undefined && _loc8_.@itemDesc != "" && _loc8_.@itemDesc != " " ? Utils.trim(_loc8_.@itemDesc) : _loc6_.itemDesc;
                  _loc5_.iconUrl = _loc8_.@iconUrl != undefined ? Utils.trim(_loc8_.@iconUrl) : _loc6_.iconUrl;
                  _loc5_.price = _loc8_.@price != undefined ? int(_loc8_.@price) : _loc6_.price;
                  _loc5_.heroItem = _loc8_.@heroItem == undefined ? _loc6_.heroItem : Boolean(Utils.trim(_loc8_.@heroItem));
                  _loc5_.playerItem = _loc8_.@playerItem == undefined ? _loc6_.playerItem : Boolean(Utils.trim(_loc8_.@playerItem));
               }
               else
               {
                  _loc5_ = new ItemEum();
                  _loc5_.id = Utils.trim(_loc8_.@id);
                  if(_loc8_.@name != undefined)
                  {
                     _loc2_ = Utils.trim(Utils.trim(_loc8_.@name).split(" ").join("_"));
                     _loc6_ = getItemEumByName(_loc2_);
                     _loc5_.name = _loc2_ + (_loc6_ == null ? "" : "_" + new Date().fullYear);
                  }
                  else
                  {
                     _loc5_.name = Utils.trim(_loc8_.@id);
                  }
                  _loc5_.itemType = Utils.trim(_loc8_.@itemType);
                  _loc5_.dayLimit = _loc8_.@dayLimit;
                  _loc5_.userLimit = _loc8_.@userLimit;
                  _loc5_.desc = Utils.trim(_loc8_.@desc);
                  _loc5_.itemDesc = Utils.trim(_loc8_.@itemDesc);
                  _loc5_.iconUrl = Utils.trim(_loc8_.@iconUrl);
                  _loc5_.price = _loc8_.@price;
                  _loc5_.heroItem = _loc8_.@heroItem == undefined ? false : Boolean(Utils.trim(_loc8_.@heroItem));
                  _loc5_.playerItem = _loc8_.@playerItem == undefined ? false : Boolean(Utils.trim(_loc8_.@playerItem));
               }
               if(_loc5_.id == "player.bavarian.brew")
               {
                  _loc5_.desc = "Use this item for 24 hour for a 100% upkeep buff between Sep 27th and Oct 7th.";
                  _loc5_.itemDesc = "A gift from your friends during the Evonytoberfest promotion! Use this item to get 24 hours of 100% upkeep in ALL of your cities! The Bavarian Brew must be used between Sep 27th and Oct 7th and is stackable, allowing you to increase the available buff time. On October 8th the buff will expire.";
               }
               _loc3_ += "\n" + ++_loc4_ + ":  <b>" + _loc5_.name + "</b>  price: <b>" + _loc5_.price + "</b>";
               externalItemNames[_loc5_.id] = _loc5_;
            }
         }
         return (_loc3_ != "" ? "Received item detail updates for " + _loc4_ + " items:" : "") + _loc3_;
      }
      
      public static function getItemEumByName(param1:String) : ItemEum
      {
         var _loc2_:ItemEum = null;
         if(externalItemNames == null)
         {
            initExternalItemNames();
         }
         param1 = param1.toLowerCase().replace(/\’/g,"\'");
         if(param1 == "amulet5")
         {
            param1 = "aries_amulet";
         }
         for each(_loc2_ in externalItemNames)
         {
            if(_loc2_.name.toLowerCase().replace(/\’/g,"\'") == param1)
            {
               return _loc2_;
            }
         }
         if(param1.indexOf(".") != -1)
         {
            _loc2_ = new ItemEum();
            _loc2_.id = param1;
            _loc2_.name = param1;
            _loc2_.itemType = "";
            _loc2_.dayLimit = -1;
            _loc2_.userLimit = -1;
            _loc2_.desc = "";
            _loc2_.itemDesc = "";
            _loc2_.iconUrl = "";
            _loc2_.price = 0;
            _loc2_.heroItem = false;
            _loc2_.playerItem = true;
            return _loc2_;
         }
         return null;
      }
   }
}

