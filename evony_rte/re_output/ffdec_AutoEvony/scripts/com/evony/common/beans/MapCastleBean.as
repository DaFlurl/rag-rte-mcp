package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class MapCastleBean implements IEventDispatcher
   {
      
      private var _1682641376declaredWarStatus:int;
      
      private var _554436100relation:int;
      
      private var _1695158553colonialStatus:int;
      
      private var _99462250honor:int;
      
      private var _3575610type:int;
      
      private var _1207284347canColonize:Boolean;
      
      private var _1167077297colonialRelation:int;
      
      private var _1503629328furlough:Boolean;
      
      private var _3355id:int;
      
      private var _109281npc:Boolean;
      
      private var _422968703powerLevel:int;
      
      private var _946919841declaredWarStartTime:Number;
      
      private var _848059479zoneName:String;
      
      private var _1387001311suzerain:String;
      
      private var _266666762userName:String;
      
      private var _114043281castleIcon:int;
      
      private var _738630737ownerPlayerId:int;
      
      private var _3373707name:String;
      
      private var _1299492445playerLogoUrl:String;
      
      private var _98100801canOccupy:Boolean;
      
      private var _1524843188freshMan:Boolean;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _138006258canScout:Boolean;
      
      private var _3145580flag:String;
      
      private var _549540504canLoot:Boolean;
      
      private var _109757585state:int;
      
      private var _35872819castleId:int;
      
      private var _1276224445prestige:int;
      
      private var _136649544canTrans:Boolean;
      
      private var _549739384canSend:Boolean;
      
      private var _1606140770allianceName:String;
      
      private var _244224418canDeclaredWar:Boolean;
      
      public function MapCastleBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.allianceName != null)
            {
               this.allianceName = param1.allianceName;
            }
            if(param1.castleIcon != null)
            {
               this.castleIcon = param1.castleIcon;
            }
            if(param1.castleId != null)
            {
               this.castleId = param1.castleId;
            }
            if(param1.colonialRelation != null)
            {
               this.colonialRelation = param1.colonialRelation;
            }
            if(param1.colonialStatus != null)
            {
               this.colonialStatus = param1.colonialStatus;
            }
            if(param1.declaredWarStartTime != null)
            {
               this.declaredWarStartTime = param1.declaredWarStartTime;
            }
            if(param1.declaredWarStatus != null)
            {
               this.declaredWarStatus = param1.declaredWarStatus;
            }
            if(param1.flag != null)
            {
               this.flag = param1.flag;
            }
            if(param1.honor != null)
            {
               this.honor = param1.honor;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.name != null)
            {
               this.name = param1.name;
            }
            if(param1.ownerPlayerId != null)
            {
               this.ownerPlayerId = param1.ownerPlayerId;
            }
            if(param1.playerLogoUrl != null)
            {
               this.playerLogoUrl = param1.playerLogoUrl;
            }
            if(param1.powerLevel != null)
            {
               this.powerLevel = param1.powerLevel;
            }
            if(param1.prestige != null)
            {
               this.prestige = param1.prestige;
            }
            if(param1.relation != null)
            {
               this.relation = param1.relation;
            }
            if(param1.state != null)
            {
               this.state = param1.state;
            }
            if(param1.suzerain != null)
            {
               this.suzerain = param1.suzerain;
            }
            if(param1.type != null)
            {
               this.type = param1.type;
            }
            if(param1.userName != null)
            {
               this.userName = param1.userName;
            }
            if(param1.zoneName != null)
            {
               this.zoneName = param1.zoneName;
            }
            if(param1.canColonize != null)
            {
               this.canColonize = param1.canColonize;
            }
            if(param1.canDeclaredWar != null)
            {
               this.canDeclaredWar = param1.canDeclaredWar;
            }
            if(param1.canLoot != null)
            {
               this.canLoot = param1.canLoot;
            }
            if(param1.canOccupy != null)
            {
               this.canOccupy = param1.canOccupy;
            }
            if(param1.canScout != null)
            {
               this.canScout = param1.canScout;
            }
            if(param1.canSend != null)
            {
               this.canSend = param1.canSend;
            }
            if(param1.canTrans != null)
            {
               this.canTrans = param1.canTrans;
            }
            if(param1.freshMan != null)
            {
               this.freshMan = param1.freshMan;
            }
            if(param1.furlough != null)
            {
               this.furlough = param1.furlough;
            }
            if(param1.npc != null)
            {
               this.npc = param1.npc;
            }
         }
      }
      
      public function set canColonize(param1:Boolean) : void
      {
         var _loc2_:Object = this._1207284347canColonize;
         if(_loc2_ !== param1)
         {
            this._1207284347canColonize = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canColonize",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canScout() : Boolean
      {
         return this._138006258canScout;
      }
      
      [Bindable(event="propertyChange")]
      public function get furlough() : Boolean
      {
         return this._1503629328furlough;
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      [Bindable(event="propertyChange")]
      public function get suzerain() : String
      {
         return this._1387001311suzerain;
      }
      
      public function set castleIcon(param1:int) : void
      {
         var _loc2_:Object = this._114043281castleIcon;
         if(_loc2_ !== param1)
         {
            this._114043281castleIcon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleIcon",_loc2_,param1));
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
      
      public function set furlough(param1:Boolean) : void
      {
         var _loc2_:Object = this._1503629328furlough;
         if(_loc2_ !== param1)
         {
            this._1503629328furlough = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"furlough",_loc2_,param1));
         }
      }
      
      public function set state(param1:int) : void
      {
         var _loc2_:Object = this._109757585state;
         if(_loc2_ !== param1)
         {
            this._109757585state = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"state",_loc2_,param1));
         }
      }
      
      public function set canScout(param1:Boolean) : void
      {
         var _loc2_:Object = this._138006258canScout;
         if(_loc2_ !== param1)
         {
            this._138006258canScout = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canScout",_loc2_,param1));
         }
      }
      
      public function set canLoot(param1:Boolean) : void
      {
         var _loc2_:Object = this._549540504canLoot;
         if(_loc2_ !== param1)
         {
            this._549540504canLoot = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canLoot",_loc2_,param1));
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
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : int
      {
         return this._3575610type;
      }
      
      public function set declaredWarStartTime(param1:Number) : void
      {
         var _loc2_:Object = this._946919841declaredWarStartTime;
         if(_loc2_ !== param1)
         {
            this._946919841declaredWarStartTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"declaredWarStartTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get prestige() : int
      {
         return this._1276224445prestige;
      }
      
      public function set playerLogoUrl(param1:String) : void
      {
         var _loc2_:Object = this._1299492445playerLogoUrl;
         if(_loc2_ !== param1)
         {
            this._1299492445playerLogoUrl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerLogoUrl",_loc2_,param1));
         }
      }
      
      public function set suzerain(param1:String) : void
      {
         var _loc2_:Object = this._1387001311suzerain;
         if(_loc2_ !== param1)
         {
            this._1387001311suzerain = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"suzerain",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get castleId() : int
      {
         return this._35872819castleId;
      }
      
      [Bindable(event="propertyChange")]
      public function get freshMan() : Boolean
      {
         return this._1524843188freshMan;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get zoneName() : String
      {
         return this._848059479zoneName;
      }
      
      public function set ownerPlayerId(param1:int) : void
      {
         var _loc2_:Object = this._738630737ownerPlayerId;
         if(_loc2_ !== param1)
         {
            this._738630737ownerPlayerId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ownerPlayerId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canDeclaredWar() : Boolean
      {
         return this._244224418canDeclaredWar;
      }
      
      public function set colonialRelation(param1:int) : void
      {
         var _loc2_:Object = this._1167077297colonialRelation;
         if(_loc2_ !== param1)
         {
            this._1167077297colonialRelation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonialRelation",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get honor() : int
      {
         return this._99462250honor;
      }
      
      [Bindable(event="propertyChange")]
      public function get flag() : String
      {
         return this._3145580flag;
      }
      
      public function set castleId(param1:int) : void
      {
         var _loc2_:Object = this._35872819castleId;
         if(_loc2_ !== param1)
         {
            this._35872819castleId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleId",_loc2_,param1));
         }
      }
      
      public function set canTrans(param1:Boolean) : void
      {
         var _loc2_:Object = this._136649544canTrans;
         if(_loc2_ !== param1)
         {
            this._136649544canTrans = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canTrans",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceName() : String
      {
         return this._1606140770allianceName;
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
      public function get canSend() : Boolean
      {
         return this._549739384canSend;
      }
      
      public function set canOccupy(param1:Boolean) : void
      {
         var _loc2_:Object = this._98100801canOccupy;
         if(_loc2_ !== param1)
         {
            this._98100801canOccupy = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canOccupy",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get powerLevel() : int
      {
         return this._422968703powerLevel;
      }
      
      [Bindable(event="propertyChange")]
      public function get canColonize() : Boolean
      {
         return this._1207284347canColonize;
      }
      
      public function set prestige(param1:int) : void
      {
         var _loc2_:Object = this._1276224445prestige;
         if(_loc2_ !== param1)
         {
            this._1276224445prestige = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prestige",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._3373707name;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get castleIcon() : int
      {
         return this._114043281castleIcon;
      }
      
      public function set freshMan(param1:Boolean) : void
      {
         var _loc2_:Object = this._1524843188freshMan;
         if(_loc2_ !== param1)
         {
            this._1524843188freshMan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"freshMan",_loc2_,param1));
         }
      }
      
      public function toObject() : Object
      {
         return {
            "allianceName":this.allianceName,
            "castleIcon":this.castleIcon,
            "castleId":this.castleId,
            "colonialRelation":this.colonialRelation,
            "colonialStatus":this.colonialStatus,
            "declaredWarStartTime":this.declaredWarStartTime,
            "declaredWarStatus":this.declaredWarStatus,
            "flag":this.flag,
            "honor":this.honor,
            "id":this.id,
            "name":this.name,
            "ownerPlayerId":this.ownerPlayerId,
            "playerLogoUrl":this.playerLogoUrl,
            "powerLevel":this.powerLevel,
            "prestige":this.prestige,
            "relation":this.relation,
            "state":this.state,
            "suzerain":this.suzerain,
            "type":this.type,
            "userName":this.userName,
            "zoneName":this.zoneName,
            "canColonize":this.canColonize,
            "canDeclaredWar":this.canDeclaredWar,
            "canLoot":this.canLoot,
            "canOccupy":this.canOccupy,
            "canScout":this.canScout,
            "canSend":this.canSend,
            "canTrans":this.canTrans,
            "freshMan":this.freshMan,
            "furlough":this.furlough,
            "npc":this.npc
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get canLoot() : Boolean
      {
         return this._549540504canLoot;
      }
      
      [Bindable(event="propertyChange")]
      public function get state() : int
      {
         return this._109757585state;
      }
      
      [Bindable(event="propertyChange")]
      public function get declaredWarStartTime() : Number
      {
         return this._946919841declaredWarStartTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get playerLogoUrl() : String
      {
         return this._1299492445playerLogoUrl;
      }
      
      public function set zoneName(param1:String) : void
      {
         var _loc2_:Object = this._848059479zoneName;
         if(_loc2_ !== param1)
         {
            this._848059479zoneName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zoneName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ownerPlayerId() : int
      {
         return this._738630737ownerPlayerId;
      }
      
      [Bindable(event="propertyChange")]
      public function get colonialRelation() : int
      {
         return this._1167077297colonialRelation;
      }
      
      [Bindable(event="propertyChange")]
      public function get canTrans() : Boolean
      {
         return this._136649544canTrans;
      }
      
      public function set canDeclaredWar(param1:Boolean) : void
      {
         var _loc2_:Object = this._244224418canDeclaredWar;
         if(_loc2_ !== param1)
         {
            this._244224418canDeclaredWar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canDeclaredWar",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canOccupy() : Boolean
      {
         return this._98100801canOccupy;
      }
      
      public function set declaredWarStatus(param1:int) : void
      {
         var _loc2_:Object = this._1682641376declaredWarStatus;
         if(_loc2_ !== param1)
         {
            this._1682641376declaredWarStatus = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"declaredWarStatus",_loc2_,param1));
         }
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "allianceName = " + this.allianceName + "\n" + (param1 + "castleIcon = " + this.castleIcon + "\n") + (param1 + "castleId = " + this.castleId + "\n") + (param1 + "colonialRelation = " + this.colonialRelation + "\n") + (param1 + "colonialStatus = " + this.colonialStatus + "\n") + (param1 + "declaredWarStartTime = " + this.declaredWarStartTime + "\n") + (param1 + "declaredWarStatus = " + this.declaredWarStatus + "\n") + (param1 + "flag = " + this.flag + "\n") + (param1 + "honor = " + this.honor + "\n") + (param1 + "id = " + this.id + "\n") + (param1 + "name = " + this.name + "\n") + (param1 + "ownerPlayerId = " + this.ownerPlayerId + "\n") + (param1 + "playerLogoUrl = " + this.playerLogoUrl + "\n") + (param1 + "powerLevel = " + this.powerLevel + "\n") + (param1 + "prestige = " + this.prestige + "\n") + (param1 + "relation = " + this.relation + "\n") + (param1 + "state = " + this.state + "\n") + (param1 + "suzerain = " + this.suzerain + "\n") + (param1 + "type = " + this.type + "\n") + (param1 + "userName = " + this
         .userName + "\n") + (param1 + "zoneName = " + this.zoneName + "\n") + (param1 + "canColonize = " + this.canColonize + "\n") + (param1 + "canDeclaredWar = " + this.canDeclaredWar + "\n") + (param1 + "canLoot = " + this.canLoot + "\n") + (param1 + "canOccupy = " + this.canOccupy + "\n") + (param1 + "canScout = " + this.canScout + "\n") + (param1 + "canSend = " + this.canSend + "\n") + (param1 + "canTrans = " + this.canTrans + "\n") + (param1 + "freshMan = " + this.freshMan + "\n") + (param1 + "furlough = " + this.furlough + "\n") + (param1 + "npc = " + this.npc + "\n");
      }
      
      public function set allianceName(param1:String) : void
      {
         var _loc2_:Object = this._1606140770allianceName;
         if(_loc2_ !== param1)
         {
            this._1606140770allianceName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceName",_loc2_,param1));
         }
      }
      
      public function set colonialStatus(param1:int) : void
      {
         var _loc2_:Object = this._1695158553colonialStatus;
         if(_loc2_ !== param1)
         {
            this._1695158553colonialStatus = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonialStatus",_loc2_,param1));
         }
      }
      
      public function copyTo(param1:MapCastleBean) : void
      {
         param1.allianceName = this.allianceName;
         param1.castleIcon = this.castleIcon;
         param1.castleId = this.castleId;
         param1.colonialRelation = this.colonialRelation;
         param1.colonialStatus = this.colonialStatus;
         param1.declaredWarStartTime = this.declaredWarStartTime;
         param1.declaredWarStatus = this.declaredWarStatus;
         param1.flag = this.flag;
         param1.honor = this.honor;
         param1.id = this.id;
         param1.name = this.name;
         param1.ownerPlayerId = this.ownerPlayerId;
         param1.playerLogoUrl = this.playerLogoUrl;
         param1.powerLevel = this.powerLevel;
         param1.prestige = this.prestige;
         param1.relation = this.relation;
         param1.state = this.state;
         param1.suzerain = this.suzerain;
         param1.type = this.type;
         param1.userName = this.userName;
         param1.zoneName = this.zoneName;
         param1.canColonize = this.canColonize;
         param1.canDeclaredWar = this.canDeclaredWar;
         param1.canLoot = this.canLoot;
         param1.canOccupy = this.canOccupy;
         param1.canScout = this.canScout;
         param1.canSend = this.canSend;
         param1.canTrans = this.canTrans;
         param1.freshMan = this.freshMan;
         param1.furlough = this.furlough;
         param1.npc = this.npc;
      }
      
      public function set npc(param1:Boolean) : void
      {
         var _loc2_:Object = this._109281npc;
         if(_loc2_ !== param1)
         {
            this._109281npc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"npc",_loc2_,param1));
         }
      }
      
      public function set honor(param1:int) : void
      {
         var _loc2_:Object = this._99462250honor;
         if(_loc2_ !== param1)
         {
            this._99462250honor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"honor",_loc2_,param1));
         }
      }
      
      public function set flag(param1:String) : void
      {
         var _loc2_:Object = this._3145580flag;
         if(_loc2_ !== param1)
         {
            this._3145580flag = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"flag",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get declaredWarStatus() : int
      {
         return this._1682641376declaredWarStatus;
      }
      
      [Bindable(event="propertyChange")]
      public function get npc() : Boolean
      {
         return this._109281npc;
      }
      
      public function set userName(param1:String) : void
      {
         var _loc2_:Object = this._266666762userName;
         if(_loc2_ !== param1)
         {
            this._266666762userName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"userName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get colonialStatus() : int
      {
         return this._1695158553colonialStatus;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set canSend(param1:Boolean) : void
      {
         var _loc2_:Object = this._549739384canSend;
         if(_loc2_ !== param1)
         {
            this._549739384canSend = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canSend",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get relation() : int
      {
         return this._554436100relation;
      }
      
      [Bindable(event="propertyChange")]
      public function get userName() : String
      {
         return this._266666762userName;
      }
      
      public function set powerLevel(param1:int) : void
      {
         var _loc2_:Object = this._422968703powerLevel;
         if(_loc2_ !== param1)
         {
            this._422968703powerLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"powerLevel",_loc2_,param1));
         }
      }
      
      public function set relation(param1:int) : void
      {
         var _loc2_:Object = this._554436100relation;
         if(_loc2_ !== param1)
         {
            this._554436100relation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"relation",_loc2_,param1));
         }
      }
   }
}

