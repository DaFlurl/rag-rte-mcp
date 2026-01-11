package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class NpcHeroBean implements IEventDispatcher
   {
      
      public static const CATCH_STATUS:int = 1;
      
      public static const GENERAL_NPC_HERO:int = 0;
      
      public static const HIRED_STATUS:int = 2;
      
      public static const FREE_STATUS:int = 0;
      
      private var _1000157193hireQuestId:int;
      
      private var _412944526stratagem:int;
      
      private var _105022396npcid:int;
      
      private var _871991583introduce:String;
      
      private var _3575610type:int;
      
      private var _1799980989management:int;
      
      private var _1782850756questType:int;
      
      private var _113766sex:int;
      
      private var _1200507606ability:int;
      
      private var _106858757power:int;
      
      private var _1551386992logoimage:String;
      
      private var _1180601999wisdom_base:int;
      
      private var _97427706field:int;
      
      private var _318758630leadership_Added:int;
      
      private var _737297702power_Added:int;
      
      private var _1384944173stratagem_Added:int;
      
      private var _2055722679bravery_base:int;
      
      private var _505236964management_Added:int;
      
      private var _987485392province:String;
      
      private var _3887zi:String;
      
      private var _892481550status:int;
      
      private var _702030434catchQuestId:int;
      
      private var _1272455898affairs_base:int;
      
      private var _3373707name:String;
      
      private var _115792uid:int;
      
      private var _1599491379taskitemid:String;
      
      private var _102865796level:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _3135069face:int;
      
      private var _1192391365leadership:int;
      
      private var _358728774loyalty:int;
      
      public function NpcHeroBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.ability != null)
            {
               this.ability = param1.ability;
            }
            if(param1.affairs_base != null)
            {
               this.affairs_base = param1.affairs_base;
            }
            if(param1.bravery_base != null)
            {
               this.bravery_base = param1.bravery_base;
            }
            if(param1.catchQuestId != null)
            {
               this.catchQuestId = param1.catchQuestId;
            }
            if(param1.face != null)
            {
               this.face = param1.face;
            }
            if(param1.field != null)
            {
               this.field = param1.field;
            }
            if(param1.hireQuestId != null)
            {
               this.hireQuestId = param1.hireQuestId;
            }
            if(param1.introduce != null)
            {
               this.introduce = param1.introduce;
            }
            if(param1.leadership != null)
            {
               this.leadership = param1.leadership;
            }
            if(param1.leadership_Added != null)
            {
               this.leadership_Added = param1.leadership_Added;
            }
            if(param1.level != null)
            {
               this.level = param1.level;
            }
            if(param1.loyalty != null)
            {
               this.loyalty = param1.loyalty;
            }
            if(param1.management != null)
            {
               this.management = param1.management;
            }
            if(param1.management_Added != null)
            {
               this.management_Added = param1.management_Added;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.npcid != null)
            {
               this.npcid = param1.npcid;
            }
            if(param1.power != null)
            {
               this.power = param1.power;
            }
            if(param1.power_Added != null)
            {
               this.power_Added = param1.power_Added;
            }
            if(param1.province != null)
            {
               this.province = param1.province;
            }
            if(param1.questType != null)
            {
               this.questType = param1.questType;
            }
            if(param1.sex != null)
            {
               this.sex = param1.sex;
            }
            if(param1.status != null)
            {
               this.status = param1.status;
            }
            if(param1.stratagem != null)
            {
               this.stratagem = param1.stratagem;
            }
            if(param1.stratagem_Added != null)
            {
               this.stratagem_Added = param1.stratagem_Added;
            }
            if(param1.type != null)
            {
               this.type = param1.type;
            }
            if(param1.uid != null)
            {
               this.uid = param1.uid;
            }
            if(param1.wisdom_base != null)
            {
               this.wisdom_base = param1.wisdom_base;
            }
            if(param1.zi != null)
            {
               this.zi = param1.zi;
            }
            if(param1.logoimage != null)
            {
               this.logoimage = param1.logoimage;
            }
            if(param1.taskitemid != null)
            {
               this.taskitemid = param1.taskitemid;
            }
         }
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
      
      [Bindable(event="propertyChange")]
      public function get hireQuestId() : int
      {
         return this._1000157193hireQuestId;
      }
      
      [Bindable(event="propertyChange")]
      public function get power() : int
      {
         return this._106858757power;
      }
      
      public function set hireQuestId(param1:int) : void
      {
         var _loc2_:Object = this._1000157193hireQuestId;
         if(_loc2_ !== param1)
         {
            this._1000157193hireQuestId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hireQuestId",_loc2_,param1));
         }
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
      
      public function set level(param1:int) : void
      {
         var _loc2_:Object = this._102865796level;
         if(_loc2_ !== param1)
         {
            this._102865796level = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"level",_loc2_,param1));
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
      
      public function set wisdom_base(param1:int) : void
      {
         var _loc2_:Object = this._1180601999wisdom_base;
         if(_loc2_ !== param1)
         {
            this._1180601999wisdom_base = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wisdom_base",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get introduce() : String
      {
         return this._871991583introduce;
      }
      
      [Bindable(event="propertyChange")]
      public function get power_Added() : int
      {
         return this._737297702power_Added;
      }
      
      public function set logoimage(param1:String) : void
      {
         var _loc2_:Object = this._1551386992logoimage;
         if(_loc2_ !== param1)
         {
            this._1551386992logoimage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoimage",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get affairs_base() : int
      {
         return this._1272455898affairs_base;
      }
      
      [Bindable(event="propertyChange")]
      public function get ability() : int
      {
         return this._1200507606ability;
      }
      
      [Bindable(event="propertyChange")]
      public function get questType() : int
      {
         return this._1782850756questType;
      }
      
      [Bindable(event="propertyChange")]
      public function get province() : String
      {
         return this._987485392province;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get management() : int
      {
         return this._1799980989management;
      }
      
      public function set introduce(param1:String) : void
      {
         var _loc2_:Object = this._871991583introduce;
         if(_loc2_ !== param1)
         {
            this._871991583introduce = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"introduce",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get zi() : String
      {
         return this._3887zi;
      }
      
      [Bindable(event="propertyChange")]
      public function get bravery_base() : int
      {
         return this._2055722679bravery_base;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get taskitemid() : String
      {
         return this._1599491379taskitemid;
      }
      
      public function set power_Added(param1:int) : void
      {
         var _loc2_:Object = this._737297702power_Added;
         if(_loc2_ !== param1)
         {
            this._737297702power_Added = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"power_Added",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loyalty() : int
      {
         return this._358728774loyalty;
      }
      
      [Bindable(event="propertyChange")]
      public function get uid() : int
      {
         return this._115792uid;
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : int
      {
         return this._3575610type;
      }
      
      public function set affairs_base(param1:int) : void
      {
         var _loc2_:Object = this._1272455898affairs_base;
         if(_loc2_ !== param1)
         {
            this._1272455898affairs_base = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"affairs_base",_loc2_,param1));
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
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get face() : int
      {
         return this._3135069face;
      }
      
      [Bindable(event="propertyChange")]
      public function get catchQuestId() : int
      {
         return this._702030434catchQuestId;
      }
      
      public function set zi(param1:String) : void
      {
         var _loc2_:Object = this._3887zi;
         if(_loc2_ !== param1)
         {
            this._3887zi = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zi",_loc2_,param1));
         }
      }
      
      public function set province(param1:String) : void
      {
         var _loc2_:Object = this._987485392province;
         if(_loc2_ !== param1)
         {
            this._987485392province = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"province",_loc2_,param1));
         }
      }
      
      public function set taskitemid(param1:String) : void
      {
         var _loc2_:Object = this._1599491379taskitemid;
         if(_loc2_ !== param1)
         {
            this._1599491379taskitemid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"taskitemid",_loc2_,param1));
         }
      }
      
      public function set type(param1:int) : void
      {
         var _loc2_:Object = this._3575610type;
         if(_loc2_ !== param1)
         {
            this._3575610type = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"type",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sex() : int
      {
         return this._113766sex;
      }
      
      public function set questType(param1:int) : void
      {
         var _loc2_:Object = this._1782850756questType;
         if(_loc2_ !== param1)
         {
            this._1782850756questType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"questType",_loc2_,param1));
         }
      }
      
      public function set npcid(param1:int) : void
      {
         var _loc2_:Object = this._105022396npcid;
         if(_loc2_ !== param1)
         {
            this._105022396npcid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npcid",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stratagem() : int
      {
         return this._412944526stratagem;
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
      
      public function set leadership(param1:int) : void
      {
         var _loc2_:Object = this._1192391365leadership;
         if(_loc2_ !== param1)
         {
            this._1192391365leadership = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"leadership",_loc2_,param1));
         }
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
      
      [Bindable(event="propertyChange")]
      public function get wisdom_base() : int
      {
         return this._1180601999wisdom_base;
      }
      
      [Bindable(event="propertyChange")]
      public function get logoimage() : String
      {
         return this._1551386992logoimage;
      }
      
      public function set bravery_base(param1:int) : void
      {
         var _loc2_:Object = this._2055722679bravery_base;
         if(_loc2_ !== param1)
         {
            this._2055722679bravery_base = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bravery_base",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "ability":this.ability,
            "affairs_base":this.affairs_base,
            "bravery_base":this.bravery_base,
            "catchQuestId":this.catchQuestId,
            "face":this.face,
            "field":this.field,
            "hireQuestId":this.hireQuestId,
            "introduce":this.introduce,
            "leadership":this.leadership,
            "leadership_Added":this.leadership_Added,
            "level":this.level,
            "loyalty":this.loyalty,
            "management":this.management,
            "management_Added":this.management_Added,
            "name":this.name,
            "npcid":this.npcid,
            "power":this.power,
            "power_Added":this.power_Added,
            "province":this.province,
            "questType":this.questType,
            "sex":this.sex,
            "status":this.status,
            "stratagem":this.stratagem,
            "stratagem_Added":this.stratagem_Added,
            "type":this.type,
            "uid":this.uid,
            "wisdom_base":this.wisdom_base,
            "zi":this.zi,
            "logoimage":this.logoimage,
            "taskitemid":this.taskitemid
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get level() : int
      {
         return this._102865796level;
      }
      
      public function set uid(param1:int) : void
      {
         var _loc2_:Object = this._115792uid;
         if(_loc2_ !== param1)
         {
            this._115792uid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"uid",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function set stratagem_Added(param1:int) : void
      {
         var _loc2_:Object = this._1384944173stratagem_Added;
         if(_loc2_ !== param1)
         {
            this._1384944173stratagem_Added = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stratagem_Added",_loc2_,param1));
         }
      }
      
      public function set face(param1:int) : void
      {
         var _loc2_:Object = this._3135069face;
         if(_loc2_ !== param1)
         {
            this._3135069face = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"face",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get npcid() : int
      {
         return this._105022396npcid;
      }
      
      public function set catchQuestId(param1:int) : void
      {
         var _loc2_:Object = this._702030434catchQuestId;
         if(_loc2_ !== param1)
         {
            this._702030434catchQuestId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"catchQuestId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get leadership() : int
      {
         return this._1192391365leadership;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "ability = " + this.ability + "\n" + (param1 + "affairs_base = " + this.affairs_base + "\n") + (param1 + "bravery_base = " + this.bravery_base + "\n") + (param1 + "catchQuestId = " + this.catchQuestId + "\n") + (param1 + "face = " + this.face + "\n") + (param1 + "field = " + this.field + "\n") + (param1 + "hireQuestId = " + this.hireQuestId + "\n") + (param1 + "introduce = " + this.introduce + "\n") + (param1 + "leadership = " + this.leadership + "\n") + (param1 + "leadership_Added = " + this.leadership_Added + "\n") + (param1 + "level = " + this.level + "\n") + (param1 + "loyalty = " + this.loyalty + "\n") + (param1 + "management = " + this.management + "\n") + (param1 + "management_Added = " + this.management_Added + "\n") + (param1 + "name = " + this.name + "\n") + (param1 + "npcid = " + this.npcid + "\n") + (param1 + "power = " + this.power + "\n") + (param1 + "power_Added = " + this.power_Added + "\n") + (param1 + "province = " + this.province + "\n") + (param1 + "questType = " + this
         .questType + "\n") + (param1 + "sex = " + this.sex + "\n") + (param1 + "status = " + this.status + "\n") + (param1 + "stratagem = " + this.stratagem + "\n") + (param1 + "stratagem_Added = " + this.stratagem_Added + "\n") + (param1 + "type = " + this.type + "\n") + (param1 + "uid = " + this.uid + "\n") + (param1 + "wisdom_base = " + this.wisdom_base + "\n") + (param1 + "zi = " + this.zi + "\n") + (param1 + "logoimage = " + this.logoimage + "\n") + (param1 + "taskitemid = " + this.taskitemid + "\n");
      }
      
      public function set leadership_Added(param1:int) : void
      {
         var _loc2_:Object = this._318758630leadership_Added;
         if(_loc2_ !== param1)
         {
            this._318758630leadership_Added = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"leadership_Added",_loc2_,param1));
         }
      }
      
      public function copyTo(param1:NpcHeroBean) : void
      {
         param1.ability = this.ability;
         param1.affairs_base = this.affairs_base;
         param1.bravery_base = this.bravery_base;
         param1.catchQuestId = this.catchQuestId;
         param1.face = this.face;
         param1.field = this.field;
         param1.hireQuestId = this.hireQuestId;
         param1.introduce = this.introduce;
         param1.leadership = this.leadership;
         param1.leadership_Added = this.leadership_Added;
         param1.level = this.level;
         param1.loyalty = this.loyalty;
         param1.management = this.management;
         param1.management_Added = this.management_Added;
         param1.name = this.name;
         param1.npcid = this.npcid;
         param1.power = this.power;
         param1.power_Added = this.power_Added;
         param1.province = this.province;
         param1.questType = this.questType;
         param1.sex = this.sex;
         param1.status = this.status;
         param1.stratagem = this.stratagem;
         param1.stratagem_Added = this.stratagem_Added;
         param1.type = this.type;
         param1.uid = this.uid;
         param1.wisdom_base = this.wisdom_base;
         param1.zi = this.zi;
         param1.logoimage = this.logoimage;
         param1.taskitemid = this.taskitemid;
      }
      
      [Bindable(event="propertyChange")]
      public function get stratagem_Added() : int
      {
         return this._1384944173stratagem_Added;
      }
      
      public function set management_Added(param1:int) : void
      {
         var _loc2_:Object = this._505236964management_Added;
         if(_loc2_ !== param1)
         {
            this._505236964management_Added = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"management_Added",_loc2_,param1));
         }
      }
      
      public function set sex(param1:int) : void
      {
         var _loc2_:Object = this._113766sex;
         if(_loc2_ !== param1)
         {
            this._113766sex = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sex",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get management_Added() : int
      {
         return this._505236964management_Added;
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
      
      [Bindable(event="propertyChange")]
      public function get leadership_Added() : int
      {
         return this._318758630leadership_Added;
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : int
      {
         return this._892481550status;
      }
      
      public function set field(param1:int) : void
      {
         var _loc2_:Object = this._97427706field;
         if(_loc2_ !== param1)
         {
            this._97427706field = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"field",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get field() : int
      {
         return this._97427706field;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}

