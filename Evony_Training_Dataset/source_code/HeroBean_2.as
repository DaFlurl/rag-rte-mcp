package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class HeroBean implements IEventDispatcher
   {
      private var _412944526stratagem:int;
      
      private var _85567126experience:int;
      
      private var _358728774loyalty:int;
      
      private var _1266164532fieldtype:int;
      
      private var _1217743173equipmentbeanArray:ArrayCollection;
      
      private var _1799980989management:int;
      
      private var _100348382infro:String;
      
      private var _1544916048defence:int;
      
      private var _547400545politics:Number;
      
      private var _761536362managementBuffAdded:int;
      
      private var _113766sex:Boolean;
      
      private var _109641799speed:int;
      
      private var _1200507606ability:int;
      
      private var _106858757power:int;
      
      private var _1068386166morale:int;
      
      private var _814364440powerBuffAdded:int;
      
      private var _3355id:int;
      
      private var _2032248903buffsArray:ArrayCollection;
      
      private var _1039282375npc_id:int;
      
      private var _958110004facebook_id:String;
      
      private var _510568485fbFriendName:String;
      
      private var _342500292logoUrl:String;
      
      private var _1627044220remainPoint:int;
      
      private var _1456811858stratagemAdded:int;
      
      private var _471353915maxStrength:int;
      
      private var _797998783intelligence:Number;
      
      private var _814903611leadershipAdded:int;
      
      private var _892481550status:int;
      
      private var _1691501851stratagemBuffAdded:int;
      
      private var _3373707name:String;
      
      private var _102865796level:int;
      
      private var _682371709managementAdded:int;
      
      private var _1999179167upgradeExp:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _412762875powerAdded:int;
      
      private var _1180455868isHero:int;
      
      private var _1192391365leadership:int;
      
      private var _1897344401stamina:int;
      
      private var _1178662002itemId:String;
      
      private var _1407259064attack:Number;
      
      private var _1478417739itemAmount:int;
      
      public function HeroBean(param1:Object = null)
      {
         var _loc2_:int = 0;
         var _loc3_:BuffBean = null;
         var _loc4_:EquipmentBean = null;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         this.buffsArray = new ArrayCollection();
         this.equipmentbeanArray = new ArrayCollection();
         super();
         if(param1 != null)
         {
            if(param1.ability != null)
            {
               this.ability = param1.ability;
            }
            if(param1.attack != null)
            {
               this.attack = param1.attack;
            }
            if(param1.defence != null)
            {
               this.defence = param1.defence;
            }
            if(param1.experience != null)
            {
               this.experience = param1.experience;
            }
            if(param1.facebook_id != null)
            {
               this.facebook_id = param1.facebook_id;
            }
            if(param1.fbFriendName != null)
            {
               this.fbFriendName = param1.fbFriendName;
            }
            if(param1.fieldtype != null)
            {
               this.fieldtype = param1.fieldtype;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.infro != null)
            {
               this.infro = param1.infro;
            }
            if(param1.intelligence != null)
            {
               this.intelligence = param1.intelligence;
            }
            if(param1.isHero != null)
            {
               this.isHero = param1.isHero;
            }
            if(param1.itemAmount != null)
            {
               this.itemAmount = param1.itemAmount;
            }
            if(param1.itemId != null)
            {
               this.itemId = param1.itemId;
            }
            if(param1.leadership != null)
            {
               this.leadership = param1.leadership;
            }
            if(param1.leadershipAdded != null)
            {
               this.leadershipAdded = param1.leadershipAdded;
            }
            if(param1.level != null)
            {
               this.level = param1.level;
            }
            if(param1.logoUrl != null)
            {
               this.logoUrl = param1.logoUrl;
            }
            if(param1.loyalty != null)
            {
               this.loyalty = param1.loyalty;
            }
            if(param1.management != null)
            {
               this.management = param1.management;
            }
            if(param1.managementAdded != null)
            {
               this.managementAdded = param1.managementAdded;
            }
            if(param1.managementBuffAdded != null)
            {
               this.managementBuffAdded = param1.managementBuffAdded;
            }
            if(param1.maxStrength != null)
            {
               this.maxStrength = param1.maxStrength;
            }
            if(param1.morale != null)
            {
               this.morale = param1.morale;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.npc_id != null)
            {
               this.npc_id = param1.npc_id;
            }
            if(param1.politics != null)
            {
               this.politics = param1.politics;
            }
            if(param1.power != null)
            {
               this.power = param1.power;
            }
            if(param1.powerAdded != null)
            {
               this.powerAdded = param1.powerAdded;
            }
            if(param1.powerBuffAdded != null)
            {
               this.powerBuffAdded = param1.powerBuffAdded;
            }
            if(param1.remainPoint != null)
            {
               this.remainPoint = param1.remainPoint;
            }
            if(param1.speed != null)
            {
               this.speed = param1.speed;
            }
            if(param1.stamina != null)
            {
               this.stamina = param1.stamina;
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
            if(param1.stratagem != null)
            {
               this.stratagem = param1.stratagem;
            }
            if(param1.stratagemAdded != null)
            {
               this.stratagemAdded = param1.stratagemAdded;
            }
            if(param1.stratagemBuffAdded != null)
            {
               this.stratagemBuffAdded = param1.stratagemBuffAdded;
            }
            if(param1.upgradeExp != null)
            {
               this.upgradeExp = param1.upgradeExp;
            }
            if(param1.sex != null)
            {
               this.sex = param1.sex;
            }
            _loc2_ = 0;
            if(param1.buffs)
            {
               _loc3_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.buffs.length)
               {
                  _loc3_ = new BuffBean(param1.buffs[_loc2_]);
                  this.buffsArray.addItem(_loc3_);
                  _loc2_++;
               }
            }
            if(param1.equipmentbean)
            {
               _loc4_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.equipmentbean.length)
               {
                  _loc4_ = new EquipmentBean(param1.equipmentbean[_loc2_]);
                  this.equipmentbeanArray.addItem(_loc4_);
                  _loc2_++;
               }
            }
         }
      }
      
      public function set speed(param1:int) : void
      {
         var _loc2_:Object = this._109641799speed;
         if(_loc2_ !== param1)
         {
            this._109641799speed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speed",_loc2_,param1));
         }
      }
      
      public function set remainPoint(param1:int) : void
      {
         var _loc2_:Object = this._1627044220remainPoint;
         if(_loc2_ !== param1)
         {
            this._1627044220remainPoint = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"remainPoint",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get power() : int
      {
         return this._106858757power;
      }
      
      public function set morale(param1:int) : void
      {
         var _loc2_:Object = this._1068386166morale;
         if(_loc2_ !== param1)
         {
            this._1068386166morale = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"morale",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:Object = this._3373707name;
         if(_loc2_ !== param1)
         {
            this._3373707name = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"name",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fbFriendName() : String
      {
         return this._510568485fbFriendName;
      }
      
      [Bindable(event="propertyChange")]
      public function get fieldtype() : int
      {
         return this._1266164532fieldtype;
      }
      
      public function set level(param1:int) : void
      {
         var _loc2_:Object = this._102865796level;
         if(_loc2_ !== param1)
         {
            this._102865796level = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"level",_loc2_,param1));
         }
      }
      
      public function set id(param1:int) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      public function set power(param1:int) : void
      {
         var _loc2_:Object = this._106858757power;
         if(_loc2_ !== param1)
         {
            this._106858757power = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"power",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stratagemBuffAdded() : int
      {
         return this._1691501851stratagemBuffAdded;
      }
      
      public function setBuffs(param1:BuffBean, param2:int) : void
      {
         this.buffsArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get management() : int
      {
         return this._1799980989management;
      }
      
      [Bindable(event="propertyChange")]
      public function get isHero() : int
      {
         return this._1180455868isHero;
      }
      
      public function set stratagemBuffAdded(param1:int) : void
      {
         var _loc2_:Object = this._1691501851stratagemBuffAdded;
         if(_loc2_ !== param1)
         {
            this._1691501851stratagemBuffAdded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stratagemBuffAdded",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speed() : int
      {
         return this._109641799speed;
      }
      
      [Bindable(event="propertyChange")]
      public function get npc_id() : int
      {
         return this._1039282375npc_id;
      }
      
      public function set itemId(param1:String) : void
      {
         var _loc2_:Object = this._1178662002itemId;
         if(_loc2_ !== param1)
         {
            this._1178662002itemId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get leadershipAdded() : int
      {
         return this._814903611leadershipAdded;
      }
      
      [Bindable(event="propertyChange")]
      public function get itemAmount() : int
      {
         return this._1478417739itemAmount;
      }
      
      [Bindable(event="propertyChange")]
      public function get ability() : int
      {
         return this._1200507606ability;
      }
      
      [Bindable(event="propertyChange")]
      public function get attack() : Number
      {
         return this._1407259064attack;
      }
      
      public function set fbFriendName(param1:String) : void
      {
         var _loc2_:Object = this._510568485fbFriendName;
         if(_loc2_ !== param1)
         {
            this._510568485fbFriendName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fbFriendName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loyalty() : int
      {
         return this._358728774loyalty;
      }
      
      [Bindable(event="propertyChange")]
      public function get facebook_id() : String
      {
         return this._958110004facebook_id;
      }
      
      [Bindable(event="propertyChange")]
      public function get defence() : int
      {
         return this._1544916048defence;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get politics() : Number
      {
         return this._547400545politics;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set fieldtype(param1:int) : void
      {
         var _loc2_:Object = this._1266164532fieldtype;
         if(_loc2_ !== param1)
         {
            this._1266164532fieldtype = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fieldtype",_loc2_,param1));
         }
      }
      
      public function set stratagemAdded(param1:int) : void
      {
         var _loc2_:Object = this._1456811858stratagemAdded;
         if(_loc2_ !== param1)
         {
            this._1456811858stratagemAdded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stratagemAdded",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sex() : Boolean
      {
         return this._113766sex;
      }
      
      [Bindable(event="propertyChange")]
      public function get upgradeExp() : int
      {
         return this._1999179167upgradeExp;
      }
      
      [Bindable(event="propertyChange")]
      public function get experience() : int
      {
         return this._85567126experience;
      }
      
      public function set facebook_id(param1:String) : void
      {
         var _loc2_:Object = this._958110004facebook_id;
         if(_loc2_ !== param1)
         {
            this._958110004facebook_id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"facebook_id",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get managementBuffAdded() : int
      {
         return this._761536362managementBuffAdded;
      }
      
      public function set leadershipAdded(param1:int) : void
      {
         var _loc2_:Object = this._814903611leadershipAdded;
         if(_loc2_ !== param1)
         {
            this._814903611leadershipAdded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"leadershipAdded",_loc2_,param1));
         }
      }
      
      public function set intelligence(param1:Number) : void
      {
         var _loc2_:Object = this._797998783intelligence;
         if(_loc2_ !== param1)
         {
            this._797998783intelligence = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"intelligence",_loc2_,param1));
         }
      }
      
      public function set ability(param1:int) : void
      {
         var _loc2_:Object = this._1200507606ability;
         if(_loc2_ !== param1)
         {
            this._1200507606ability = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ability",_loc2_,param1));
         }
      }
      
      public function set management(param1:int) : void
      {
         var _loc2_:Object = this._1799980989management;
         if(_loc2_ !== param1)
         {
            this._1799980989management = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"management",_loc2_,param1));
         }
      }
      
      public function getEquipmentbean(param1:int) : EquipmentBean
      {
         return this.equipmentbeanArray[param1] as EquipmentBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get morale() : int
      {
         return this._1068386166morale;
      }
      
      [Bindable(event="propertyChange")]
      public function get remainPoint() : int
      {
         return this._1627044220remainPoint;
      }
      
      public function set loyalty(param1:int) : void
      {
         var _loc2_:Object = this._358728774loyalty;
         if(_loc2_ !== param1)
         {
            this._358728774loyalty = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loyalty",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set logoUrl(param1:String) : void
      {
         var _loc2_:Object = this._342500292logoUrl;
         if(_loc2_ !== param1)
         {
            this._342500292logoUrl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoUrl",_loc2_,param1));
         }
      }
      
      public function set attack(param1:Number) : void
      {
         var _loc2_:Object = this._1407259064attack;
         if(_loc2_ !== param1)
         {
            this._1407259064attack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"attack",_loc2_,param1));
         }
      }
      
      public function set maxStrength(param1:int) : void
      {
         var _loc2_:Object = this._471353915maxStrength;
         if(_loc2_ !== param1)
         {
            this._471353915maxStrength = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maxStrength",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
      }
      
      public function set buffsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._2032248903buffsArray;
         if(_loc2_ !== param1)
         {
            this._2032248903buffsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buffsArray",_loc2_,param1));
         }
      }
      
      public function set itemAmount(param1:int) : void
      {
         var _loc2_:Object = this._1478417739itemAmount;
         if(_loc2_ !== param1)
         {
            this._1478417739itemAmount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemAmount",_loc2_,param1));
         }
      }
      
      public function set isHero(param1:int) : void
      {
         var _loc2_:Object = this._1180455868isHero;
         if(_loc2_ !== param1)
         {
            this._1180455868isHero = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isHero",_loc2_,param1));
         }
      }
      
      public function set equipmentbeanArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1217743173equipmentbeanArray;
         if(_loc2_ !== param1)
         {
            this._1217743173equipmentbeanArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"equipmentbeanArray",_loc2_,param1));
         }
      }
      
      public function set leadership(param1:int) : void
      {
         var _loc2_:Object = this._1192391365leadership;
         if(_loc2_ !== param1)
         {
            this._1192391365leadership = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"leadership",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "ability":this.ability,
            "attack":this.attack,
            "defence":this.defence,
            "experience":this.experience,
            "facebook_id":this.facebook_id,
            "fbFriendName":this.fbFriendName,
            "fieldtype":this.fieldtype,
            "id":this.id,
            "infro":this.infro,
            "intelligence":this.intelligence,
            "isHero":this.isHero,
            "itemAmount":this.itemAmount,
            "itemId":this.itemId,
            "leadership":this.leadership,
            "leadershipAdded":this.leadershipAdded,
            "level":this.level,
            "logoUrl":this.logoUrl,
            "loyalty":this.loyalty,
            "management":this.management,
            "managementAdded":this.managementAdded,
            "managementBuffAdded":this.managementBuffAdded,
            "maxStrength":this.maxStrength,
            "morale":this.morale,
            "name":this.name,
            "npc_id":this.npc_id,
            "politics":this.politics,
            "power":this.power,
            "powerAdded":this.powerAdded,
            "powerBuffAdded":this.powerBuffAdded,
            "remainPoint":this.remainPoint,
            "speed":this.speed,
            "stamina":this.stamina,
            "status":this.status,
            "stratagem":this.stratagem,
            "stratagemAdded":this.stratagemAdded,
            "stratagemBuffAdded":this.stratagemBuffAdded,
            "upgradeExp":this.upgradeExp,
            "sex":this.sex
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get stamina() : int
      {
         return this._1897344401stamina;
      }
      
      public function set npc_id(param1:int) : void
      {
         var _loc2_:Object = this._1039282375npc_id;
         if(_loc2_ !== param1)
         {
            this._1039282375npc_id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npc_id",_loc2_,param1));
         }
      }
      
      public function set defence(param1:int) : void
      {
         var _loc2_:Object = this._1544916048defence;
         if(_loc2_ !== param1)
         {
            this._1544916048defence = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"defence",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get managementAdded() : int
      {
         return this._682371709managementAdded;
      }
      
      [Bindable(event="propertyChange")]
      public function get stratagem() : int
      {
         return this._412944526stratagem;
      }
      
      [Bindable(event="propertyChange")]
      public function get stratagemAdded() : int
      {
         return this._1456811858stratagemAdded;
      }
      
      [Bindable(event="propertyChange")]
      public function get itemId() : String
      {
         return this._1178662002itemId;
      }
      
      [Bindable(event="propertyChange")]
      public function get equipmentbeanArray() : ArrayCollection
      {
         return this._1217743173equipmentbeanArray;
      }
      
      public function set infro(param1:String) : void
      {
         var _loc2_:Object = this._100348382infro;
         if(_loc2_ !== param1)
         {
            this._100348382infro = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"infro",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get intelligence() : Number
      {
         return this._797998783intelligence;
      }
      
      [Bindable(event="propertyChange")]
      public function get buffsArray() : ArrayCollection
      {
         return this._2032248903buffsArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get logoUrl() : String
      {
         return this._342500292logoUrl;
      }
      
      [Bindable(event="propertyChange")]
      public function get maxStrength() : int
      {
         return this._471353915maxStrength;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "";
         _loc2_ += param1 + "ability = " + this.ability + "\n" + (param1 + "attack = " + this.attack + "\n") + (param1 + "defence = " + this.defence + "\n") + (param1 + "experience = " + this.experience + "\n");
         _loc2_ += param1 + "facebook_id = " + this.facebook_id + "\n" + (param1 + "fbFriendName = " + this.fbFriendName + "\n") + (param1 + "fieldtype = " + this.fieldtype + "\n") + (param1 + "id = " + this.id + "\n");
         _loc2_ += param1 + "infro = " + this.infro + "\n" + (param1 + "intelligence = " + this.intelligence + "\n") + (param1 + "isHero = " + this.isHero + "\n") + (param1 + "itemAmount = " + this.itemAmount + "\n");
         _loc2_ += param1 + "itemId = " + this.itemId + "\n" + (param1 + "leadership = " + this.leadership + "\n") + (param1 + "leadershipAdded = " + this.leadershipAdded + "\n") + (param1 + "level = " + this.level + "\n");
         _loc2_ += param1 + "logoUrl = " + this.logoUrl + "\n" + (param1 + "loyalty = " + this.loyalty + "\n") + (param1 + "management = " + this.management + "\n") + (param1 + "managementAdded = " + this.managementAdded + "\n");
         _loc2_ += param1 + "managementBuffAdded = " + this.managementBuffAdded + "\n" + (param1 + "maxStrength = " + this.maxStrength + "\n") + (param1 + "morale = " + this.morale + "\n") + (param1 + "name = " + this.name + "\n");
         _loc2_ += param1 + "npc_id = " + this.npc_id + "\n" + (param1 + "politics = " + this.politics + "\n") + (param1 + "power = " + this.power + "\n") + (param1 + "powerAdded = " + this.powerAdded + "\n");
         _loc2_ += param1 + "powerBuffAdded = " + this.powerBuffAdded + "\n" + (param1 + "remainPoint = " + this.remainPoint + "\n") + (param1 + "speed = " + this.speed + "\n") + (param1 + "stamina = " + this.stamina + "\n");
         _loc2_ += param1 + "status = " + this.status + "\n" + (param1 + "stratagem = " + this.stratagem + "\n") + (param1 + "stratagemAdded = " + this.stratagemAdded + "\n") + (param1 + "stratagemBuffAdded = " + this.stratagemBuffAdded + "\n");
         _loc2_ += param1 + "upgradeExp = " + this.upgradeExp + "\n" + (param1 + "sex = " + this.sex + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.buffsArray.length)
         {
            _loc2_ += this.getBuffs(_loc3_).toDebugString(param1 + "buffs[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.equipmentbeanArray.length)
         {
            _loc2_ += this.getEquipmentbean(_loc3_).toDebugString(param1 + "equipmentbean[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBuffs(param1:int) : BuffBean
      {
         return this.buffsArray[param1] as BuffBean;
      }
      
      public function set sex(param1:Boolean) : void
      {
         var _loc2_:Object = this._113766sex;
         if(_loc2_ !== param1)
         {
            this._113766sex = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sex",_loc2_,param1));
         }
      }
      
      public function copyTo(param1:HeroBean) : void
      {
         param1.ability = this.ability;
         param1.attack = this.attack;
         param1.defence = this.defence;
         param1.experience = this.experience;
         param1.facebook_id = this.facebook_id;
         param1.fbFriendName = this.fbFriendName;
         param1.fieldtype = this.fieldtype;
         param1.id = this.id;
         param1.infro = this.infro;
         param1.intelligence = this.intelligence;
         param1.isHero = this.isHero;
         param1.itemAmount = this.itemAmount;
         param1.itemId = this.itemId;
         param1.leadership = this.leadership;
         param1.leadershipAdded = this.leadershipAdded;
         param1.level = this.level;
         param1.logoUrl = this.logoUrl;
         param1.loyalty = this.loyalty;
         param1.management = this.management;
         param1.managementAdded = this.managementAdded;
         param1.managementBuffAdded = this.managementBuffAdded;
         param1.maxStrength = this.maxStrength;
         param1.morale = this.morale;
         param1.name = this.name;
         param1.npc_id = this.npc_id;
         param1.politics = this.politics;
         param1.power = this.power;
         param1.powerAdded = this.powerAdded;
         param1.powerBuffAdded = this.powerBuffAdded;
         param1.remainPoint = this.remainPoint;
         param1.speed = this.speed;
         param1.stamina = this.stamina;
         param1.status = this.status;
         param1.stratagem = this.stratagem;
         param1.stratagemAdded = this.stratagemAdded;
         param1.stratagemBuffAdded = this.stratagemBuffAdded;
         param1.upgradeExp = this.upgradeExp;
         param1.sex = this.sex;
         CommonUtil.arrayCopy(this.buffsArray,param1.buffsArray);
         CommonUtil.arrayCopy(this.equipmentbeanArray,param1.equipmentbeanArray);
      }
      
      public function set politics(param1:Number) : void
      {
         var _loc2_:Object = this._547400545politics;
         if(_loc2_ !== param1)
         {
            this._547400545politics = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"politics",_loc2_,param1));
         }
      }
      
      public function set powerBuffAdded(param1:int) : void
      {
         var _loc2_:Object = this._814364440powerBuffAdded;
         if(_loc2_ !== param1)
         {
            this._814364440powerBuffAdded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"powerBuffAdded",_loc2_,param1));
         }
      }
      
      public function set upgradeExp(param1:int) : void
      {
         var _loc2_:Object = this._1999179167upgradeExp;
         if(_loc2_ !== param1)
         {
            this._1999179167upgradeExp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"upgradeExp",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get leadership() : int
      {
         return this._1192391365leadership;
      }
      
      public function set experience(param1:int) : void
      {
         var _loc2_:Object = this._85567126experience;
         if(_loc2_ !== param1)
         {
            this._85567126experience = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"experience",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get infro() : String
      {
         return this._100348382infro;
      }
      
      [Bindable(event="propertyChange")]
      public function get powerBuffAdded() : int
      {
         return this._814364440powerBuffAdded;
      }
      
      public function set status(param1:int) : void
      {
         var _loc2_:Object = this._892481550status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
         }
      }
      
      public function set managementBuffAdded(param1:int) : void
      {
         var _loc2_:Object = this._761536362managementBuffAdded;
         if(_loc2_ !== param1)
         {
            this._761536362managementBuffAdded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"managementBuffAdded",_loc2_,param1));
         }
      }
      
      public function set stamina(param1:int) : void
      {
         var _loc2_:Object = this._1897344401stamina;
         if(_loc2_ !== param1)
         {
            this._1897344401stamina = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stamina",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      public function set stratagem(param1:int) : void
      {
         var _loc2_:Object = this._412944526stratagem;
         if(_loc2_ !== param1)
         {
            this._412944526stratagem = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stratagem",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set powerAdded(param1:int) : void
      {
         var _loc2_:Object = this._412762875powerAdded;
         if(_loc2_ !== param1)
         {
            this._412762875powerAdded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"powerAdded",_loc2_,param1));
         }
      }
      
      public function set managementAdded(param1:int) : void
      {
         var _loc2_:Object = this._682371709managementAdded;
         if(_loc2_ !== param1)
         {
            this._682371709managementAdded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"managementAdded",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get powerAdded() : int
      {
         return this._412762875powerAdded;
      }
      
      public function setEquipmentbean(param1:EquipmentBean, param2:int) : void
      {
         this.equipmentbeanArray[param2] = param1;
      }
   }
}

