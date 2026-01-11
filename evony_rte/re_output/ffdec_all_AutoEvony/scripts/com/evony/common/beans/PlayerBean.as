package com.evony.common.beans
{
   import com.evony.common.CommonUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class PlayerBean implements IEventDispatcher
   {
      
      private var _117401885packageBeanArray:ArrayCollection;
      
      private var _1425640839itemsArray:ArrayCollection;
      
      private var _165283771isSetSecurityCode:Boolean;
      
      private var _902435682castlesArray:ArrayCollection;
      
      private var _2032248903buffsArray:ArrayCollection;
      
      private var _811312386redCount:int;
      
      private var _1329771231autoFurlough:Boolean;
      
      private var _2100063033isReceiveIncomingAttack:Boolean;
      
      private var _167675003mapSizeX:int;
      
      private var _989948789gameSpeed:int;
      
      private var _2041542881newReportCount_army:int;
      
      private var _29843496newMailCount:int;
      
      private var _925069225saleTypeBeansArray:ArrayCollection;
      
      private var _704639681friendArmysArray:ArrayCollection;
      
      private var _1123696564newReportCount_other:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _1484814694gamblingItemIndex:int;
      
      private var _1070931784emailAddress:String;
      
      private var _675024588castleSignBeanArray:ArrayCollection;
      
      private var _1438363703autoHeal:Boolean;
      
      private var _2026418520newMaileCount_inbox:int;
      
      private var _1902496333newMaileCount_system:int;
      
      private var _784915076returnReport:Boolean;
      
      private var _230483579newReportCount:int;
      
      private var _1081550341tutorialStepId:int;
      
      private var _1651231951changedFace:Boolean;
      
      private var _376568900declaredWarBeansArray:ArrayCollection;
      
      private var _1503629328furlough:Boolean;
      
      private var _1378032427enemyArmysArray:ArrayCollection;
      
      private var _1503909044equipmentsArray:ArrayCollection;
      
      private var _1887518356furloughDay:int;
      
      private var _1440789421disconnectvotes:Number;
      
      private var _167675004mapSizeY:int;
      
      private var _1432206175finishedQuestCount:int;
      
      private var _1102495504saleItemBeansArray:ArrayCollection;
      
      private var _1971832828effortPoint:int;
      
      private var _1918704276friendBeansArray:ArrayCollection;
      
      private var _1120501702newReportCount_scout:int;
      
      private var _859583983selfArmysArray:ArrayCollection;
      
      private var _874955648gemstoneinposArray:ArrayCollection;
      
      private var _1981766659randomEventsArray:ArrayCollection;
      
      private var _248723404currentDateTime:String;
      
      private var _2054170777isEvonyMember:Boolean;
      
      private var _601235430currentTime:Number;
      
      private var _1115058732headline:String;
      
      private var _196779434troopConfigBeansArray:ArrayCollection;
      
      private var _1970419386setshowinfroArray:ArrayCollection;
      
      private var _1119145312newReportCount_trade:int;
      
      private var _1461815869blockBeansArray:ArrayCollection;
      
      private var _2095520559playerInfo:PlayerInfoBean;
      
      public function PlayerBean(param1:Object = null)
      {
         var _loc2_:int = 0;
         var _loc3_:PlayerInfoBean = null;
         var _loc4_:BuffBean = null;
         var _loc5_:CastleSignInfoBean = null;
         var _loc6_:CastleBean = null;
         var _loc7_:PlayerDeclaredWarBean = null;
         var _loc8_:ArmyBean = null;
         var _loc9_:EquipmenttechBean = null;
         var _loc10_:ArmyBean = null;
         var _loc11_:PlayerInfoBean = null;
         var _loc12_:GemStoneInPosBean = null;
         var _loc13_:ItemBean = null;
         var _loc14_:PackageBean = null;
         var _loc15_:RandomEventBean = null;
         var _loc16_:SaleItemBean = null;
         var _loc17_:SaleTypeBean = null;
         var _loc18_:ArmyBean = null;
         var _loc19_:SetShowInfro = null;
         var _loc20_:TroopConfigBean = null;
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         this.blockBeansArray = new ArrayCollection();
         this.buffsArray = new ArrayCollection();
         this.castleSignBeanArray = new ArrayCollection();
         this.castlesArray = new ArrayCollection();
         this.declaredWarBeansArray = new ArrayCollection();
         this.enemyArmysArray = new ArrayCollection();
         this.equipmentsArray = new ArrayCollection();
         this.friendArmysArray = new ArrayCollection();
         this.friendBeansArray = new ArrayCollection();
         this.gemstoneinposArray = new ArrayCollection();
         this.itemsArray = new ArrayCollection();
         this.packageBeanArray = new ArrayCollection();
         this.randomEventsArray = new ArrayCollection();
         this.saleItemBeansArray = new ArrayCollection();
         this.saleTypeBeansArray = new ArrayCollection();
         this.selfArmysArray = new ArrayCollection();
         this.setshowinfroArray = new ArrayCollection();
         this.troopConfigBeansArray = new ArrayCollection();
         if(param1 != null)
         {
            if(param1.changedFace != null)
            {
               this.changedFace = param1.changedFace;
            }
            if(param1.currentDateTime != null)
            {
               this.currentDateTime = param1.currentDateTime;
            }
            if(param1.currentTime != null)
            {
               this.currentTime = param1.currentTime;
            }
            if(param1.disconnectvotes != null)
            {
               this.disconnectvotes = param1.disconnectvotes;
            }
            if(param1.effortPoint != null)
            {
               this.effortPoint = param1.effortPoint;
            }
            if(param1.emailAddress != null)
            {
               this.emailAddress = param1.emailAddress;
            }
            if(param1.finishedQuestCount != null)
            {
               this.finishedQuestCount = param1.finishedQuestCount;
            }
            if(param1.furloughDay != null)
            {
               this.furloughDay = param1.furloughDay;
            }
            if(param1.gamblingItemIndex != null)
            {
               this.gamblingItemIndex = param1.gamblingItemIndex;
            }
            if(param1.gameSpeed != null)
            {
               this.gameSpeed = param1.gameSpeed;
            }
            if(param1.headline != null)
            {
               this.headline = param1.headline;
            }
            if(param1.isEvonyMember != null)
            {
               this.isEvonyMember = param1.isEvonyMember;
            }
            if(param1.isReceiveIncomingAttack != null)
            {
               this.isReceiveIncomingAttack = param1.isReceiveIncomingAttack;
            }
            if(param1.isSetSecurityCode != null)
            {
               this.isSetSecurityCode = param1.isSetSecurityCode;
            }
            if(param1.mapSizeX != null)
            {
               this.mapSizeX = param1.mapSizeX;
            }
            if(param1.mapSizeY != null)
            {
               this.mapSizeY = param1.mapSizeY;
            }
            if(param1.newMailCount != null)
            {
               this.newMailCount = param1.newMailCount;
            }
            if(param1.newMaileCount_inbox != null)
            {
               this.newMaileCount_inbox = param1.newMaileCount_inbox;
            }
            if(param1.newMaileCount_system != null)
            {
               this.newMaileCount_system = param1.newMaileCount_system;
            }
            if(param1.newReportCount != null)
            {
               this.newReportCount = param1.newReportCount;
            }
            if(param1.newReportCount_army != null)
            {
               this.newReportCount_army = param1.newReportCount_army;
            }
            if(param1.newReportCount_other != null)
            {
               this.newReportCount_other = param1.newReportCount_other;
            }
            if(param1.newReportCount_scout != null)
            {
               this.newReportCount_scout = param1.newReportCount_scout;
            }
            if(param1.newReportCount_trade != null)
            {
               this.newReportCount_trade = param1.newReportCount_trade;
            }
            if(param1.playerInfo != null)
            {
               this.playerInfo = new PlayerInfoBean(param1.playerInfo);
            }
            if(param1.redCount != null)
            {
               this.redCount = param1.redCount;
            }
            if(param1.tutorialStepId != null)
            {
               this.tutorialStepId = param1.tutorialStepId;
            }
            if(param1.autoFurlough != null)
            {
               this.autoFurlough = param1.autoFurlough;
            }
            if(param1.autoHeal != null)
            {
               this.autoHeal = param1.autoHeal;
            }
            if(param1.furlough != null)
            {
               this.furlough = param1.furlough;
            }
            if(param1.returnReport != null)
            {
               this.returnReport = param1.returnReport;
            }
            _loc2_ = 0;
            if(param1.blockBeans)
            {
               _loc3_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.blockBeans.length)
               {
                  _loc3_ = new PlayerInfoBean(param1.blockBeans[_loc2_]);
                  this.blockBeansArray.addItem(_loc3_);
                  _loc2_++;
               }
            }
            if(param1.buffs)
            {
               _loc4_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.buffs.length)
               {
                  _loc4_ = new BuffBean(param1.buffs[_loc2_]);
                  this.buffsArray.addItem(_loc4_);
                  _loc2_++;
               }
            }
            if(param1.castleSignBean)
            {
               _loc5_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.castleSignBean.length)
               {
                  _loc5_ = new CastleSignInfoBean(param1.castleSignBean[_loc2_]);
                  this.castleSignBeanArray.addItem(_loc5_);
                  _loc2_++;
               }
            }
            if(param1.castles)
            {
               _loc6_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.castles.length)
               {
                  _loc6_ = new CastleBean(param1.castles[_loc2_]);
                  this.castlesArray.addItem(_loc6_);
                  _loc2_++;
               }
            }
            if(param1.declaredWarBeans)
            {
               _loc7_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.declaredWarBeans.length)
               {
                  _loc7_ = new PlayerDeclaredWarBean(param1.declaredWarBeans[_loc2_]);
                  this.declaredWarBeansArray.addItem(_loc7_);
                  _loc2_++;
               }
            }
            if(param1.enemyArmys)
            {
               _loc8_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.enemyArmys.length)
               {
                  _loc8_ = new ArmyBean(param1.enemyArmys[_loc2_]);
                  this.enemyArmysArray.addItem(_loc8_);
                  _loc2_++;
               }
            }
            if(param1.equipments)
            {
               _loc9_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.equipments.length)
               {
                  _loc9_ = new EquipmenttechBean(param1.equipments[_loc2_]);
                  this.equipmentsArray.addItem(_loc9_);
                  _loc2_++;
               }
            }
            if(param1.friendArmys)
            {
               _loc10_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.friendArmys.length)
               {
                  _loc10_ = new ArmyBean(param1.friendArmys[_loc2_]);
                  this.friendArmysArray.addItem(_loc10_);
                  _loc2_++;
               }
            }
            if(param1.friendBeans)
            {
               _loc11_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.friendBeans.length)
               {
                  _loc11_ = new PlayerInfoBean(param1.friendBeans[_loc2_]);
                  this.friendBeansArray.addItem(_loc11_);
                  _loc2_++;
               }
            }
            if(param1.gemstoneinpos)
            {
               _loc12_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.gemstoneinpos.length)
               {
                  _loc12_ = new GemStoneInPosBean(param1.gemstoneinpos[_loc2_]);
                  this.gemstoneinposArray.addItem(_loc12_);
                  _loc2_++;
               }
            }
            if(param1.items)
            {
               _loc13_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.items.length)
               {
                  _loc13_ = new ItemBean(param1.items[_loc2_]);
                  this.itemsArray.addItem(_loc13_);
                  _loc2_++;
               }
            }
            if(param1.packageBean)
            {
               _loc14_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.packageBean.length)
               {
                  _loc14_ = new PackageBean(param1.packageBean[_loc2_]);
                  this.packageBeanArray.addItem(_loc14_);
                  _loc2_++;
               }
            }
            if(param1.randomEvents)
            {
               _loc15_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.randomEvents.length)
               {
                  _loc15_ = new RandomEventBean(param1.randomEvents[_loc2_]);
                  this.randomEventsArray.addItem(_loc15_);
                  _loc2_++;
               }
            }
            if(param1.saleItemBeans)
            {
               _loc16_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.saleItemBeans.length)
               {
                  _loc16_ = new SaleItemBean(param1.saleItemBeans[_loc2_]);
                  this.saleItemBeansArray.addItem(_loc16_);
                  _loc2_++;
               }
            }
            if(param1.saleTypeBeans)
            {
               _loc17_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.saleTypeBeans.length)
               {
                  _loc17_ = new SaleTypeBean(param1.saleTypeBeans[_loc2_]);
                  this.saleTypeBeansArray.addItem(_loc17_);
                  _loc2_++;
               }
            }
            if(param1.selfArmys)
            {
               _loc18_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.selfArmys.length)
               {
                  _loc18_ = new ArmyBean(param1.selfArmys[_loc2_]);
                  this.selfArmysArray.addItem(_loc18_);
                  _loc2_++;
               }
            }
            if(param1.setshowinfro)
            {
               _loc19_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.setshowinfro.length)
               {
                  _loc19_ = new SetShowInfro(param1.setshowinfro[_loc2_]);
                  this.setshowinfroArray.addItem(_loc19_);
                  _loc2_++;
               }
            }
            if(param1.troopConfigBeans)
            {
               _loc20_ = null;
               _loc2_ = 0;
               while(_loc2_ < param1.troopConfigBeans.length)
               {
                  _loc20_ = new TroopConfigBean(param1.troopConfigBeans[_loc2_]);
                  this.troopConfigBeansArray.addItem(_loc20_);
                  _loc2_++;
               }
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get effortPoint() : int
      {
         return this._1971832828effortPoint;
      }
      
      [Bindable(event="propertyChange")]
      public function get tutorialStepId() : int
      {
         return this._1081550341tutorialStepId;
      }
      
      public function set effortPoint(param1:int) : void
      {
         var _loc2_:Object = this._1971832828effortPoint;
         if(_loc2_ !== param1)
         {
            this._1971832828effortPoint = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effortPoint",_loc2_,param1));
         }
      }
      
      public function getItems(param1:int) : ItemBean
      {
         return this.itemsArray[param1] as ItemBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get furlough() : Boolean
      {
         return this._1503629328furlough;
      }
      
      public function set tutorialStepId(param1:int) : void
      {
         var _loc2_:Object = this._1081550341tutorialStepId;
         if(_loc2_ !== param1)
         {
            this._1081550341tutorialStepId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tutorialStepId",_loc2_,param1));
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
      
      public function getBlockBeans(param1:int) : PlayerInfoBean
      {
         return this.blockBeansArray[param1] as PlayerInfoBean;
      }
      
      public function getRandomEvents(param1:int) : RandomEventBean
      {
         return this.randomEventsArray[param1] as RandomEventBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get autoHeal() : Boolean
      {
         return this._1438363703autoHeal;
      }
      
      [Bindable(event="propertyChange")]
      public function get newReportCount_scout() : int
      {
         return this._1120501702newReportCount_scout;
      }
      
      public function setBlockBeans(param1:PlayerInfoBean, param2:int) : void
      {
         this.blockBeansArray[param2] = param1;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get declaredWarBeansArray() : ArrayCollection
      {
         return this._376568900declaredWarBeansArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get isSetSecurityCode() : Boolean
      {
         return this._165283771isSetSecurityCode;
      }
      
      public function setSelfArmys(param1:ArmyBean, param2:int) : void
      {
         this.selfArmysArray[param2] = param1;
      }
      
      public function getCastles(param1:int) : CastleBean
      {
         return this.castlesArray[param1] as CastleBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get newMaileCount_system() : int
      {
         return this._1902496333newMaileCount_system;
      }
      
      [Bindable(event="propertyChange")]
      public function get newReportCount_other() : int
      {
         return this._1123696564newReportCount_other;
      }
      
      public function set enemyArmysArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1378032427enemyArmysArray;
         if(_loc2_ !== param1)
         {
            this._1378032427enemyArmysArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"enemyArmysArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get saleTypeBeansArray() : ArrayCollection
      {
         return this._925069225saleTypeBeansArray;
      }
      
      public function setSetshowinfro(param1:SetShowInfro, param2:int) : void
      {
         this.setshowinfroArray[param2] = param1;
      }
      
      public function set changedFace(param1:Boolean) : void
      {
         var _loc2_:Object = this._1651231951changedFace;
         if(_loc2_ !== param1)
         {
            this._1651231951changedFace = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"changedFace",_loc2_,param1));
         }
      }
      
      public function set playerInfo(param1:PlayerInfoBean) : void
      {
         var _loc2_:Object = this._2095520559playerInfo;
         if(_loc2_ !== param1)
         {
            this._2095520559playerInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerInfo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get currentDateTime() : String
      {
         return this._248723404currentDateTime;
      }
      
      public function set autoHeal(param1:Boolean) : void
      {
         var _loc2_:Object = this._1438363703autoHeal;
         if(_loc2_ !== param1)
         {
            this._1438363703autoHeal = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoHeal",_loc2_,param1));
         }
      }
      
      public function setTroopConfigBeans(param1:TroopConfigBean, param2:int) : void
      {
         this.troopConfigBeansArray[param2] = param1;
      }
      
      public function set newReportCount_scout(param1:int) : void
      {
         var _loc2_:Object = this._1120501702newReportCount_scout;
         if(_loc2_ !== param1)
         {
            this._1120501702newReportCount_scout = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newReportCount_scout",_loc2_,param1));
         }
      }
      
      public function set castleSignBeanArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._675024588castleSignBeanArray;
         if(_loc2_ !== param1)
         {
            this._675024588castleSignBeanArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleSignBeanArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemsArray() : ArrayCollection
      {
         return this._1425640839itemsArray;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get mapSizeX() : int
      {
         return this._167675003mapSizeX;
      }
      
      [Bindable(event="propertyChange")]
      public function get mapSizeY() : int
      {
         return this._167675004mapSizeY;
      }
      
      public function setItems(param1:ItemBean, param2:int) : void
      {
         this.itemsArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get newReportCount() : int
      {
         return this._230483579newReportCount;
      }
      
      [Bindable(event="propertyChange")]
      public function get returnReport() : Boolean
      {
         return this._784915076returnReport;
      }
      
      public function set declaredWarBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._376568900declaredWarBeansArray;
         if(_loc2_ !== param1)
         {
            this._376568900declaredWarBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"declaredWarBeansArray",_loc2_,param1));
         }
      }
      
      public function set currentDateTime(param1:String) : void
      {
         var _loc2_:Object = this._248723404currentDateTime;
         if(_loc2_ !== param1)
         {
            this._248723404currentDateTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentDateTime",_loc2_,param1));
         }
      }
      
      public function getDeclaredWarBeans(param1:int) : PlayerDeclaredWarBean
      {
         return this.declaredWarBeansArray[param1] as PlayerDeclaredWarBean;
      }
      
      public function set isSetSecurityCode(param1:Boolean) : void
      {
         var _loc2_:Object = this._165283771isSetSecurityCode;
         if(_loc2_ !== param1)
         {
            this._165283771isSetSecurityCode = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isSetSecurityCode",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get friendBeansArray() : ArrayCollection
      {
         return this._1918704276friendBeansArray;
      }
      
      public function set newReportCount_other(param1:int) : void
      {
         var _loc2_:Object = this._1123696564newReportCount_other;
         if(_loc2_ !== param1)
         {
            this._1123696564newReportCount_other = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newReportCount_other",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isEvonyMember() : Boolean
      {
         return this._2054170777isEvonyMember;
      }
      
      [Bindable(event="propertyChange")]
      public function get newReportCount_trade() : int
      {
         return this._1119145312newReportCount_trade;
      }
      
      [Bindable(event="propertyChange")]
      public function get gamblingItemIndex() : int
      {
         return this._1484814694gamblingItemIndex;
      }
      
      public function getEquipments(param1:int) : EquipmenttechBean
      {
         return this.equipmentsArray[param1] as EquipmenttechBean;
      }
      
      public function getGemstoneinpos(param1:int) : GemStoneInPosBean
      {
         return this.gemstoneinposArray[param1] as GemStoneInPosBean;
      }
      
      public function setEquipments(param1:EquipmenttechBean, param2:int) : void
      {
         this.equipmentsArray[param2] = param1;
      }
      
      public function set newMaileCount_system(param1:int) : void
      {
         var _loc2_:Object = this._1902496333newMaileCount_system;
         if(_loc2_ !== param1)
         {
            this._1902496333newMaileCount_system = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newMaileCount_system",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get castlesArray() : ArrayCollection
      {
         return this._902435682castlesArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get newMaileCount_inbox() : int
      {
         return this._2026418520newMaileCount_inbox;
      }
      
      public function set saleTypeBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._925069225saleTypeBeansArray;
         if(_loc2_ !== param1)
         {
            this._925069225saleTypeBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"saleTypeBeansArray",_loc2_,param1));
         }
      }
      
      public function setFriendArmys(param1:ArmyBean, param2:int) : void
      {
         this.friendArmysArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get setshowinfroArray() : ArrayCollection
      {
         return this._1970419386setshowinfroArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get equipmentsArray() : ArrayCollection
      {
         return this._1503909044equipmentsArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get emailAddress() : String
      {
         return this._1070931784emailAddress;
      }
      
      [Bindable(event="propertyChange")]
      public function get friendArmysArray() : ArrayCollection
      {
         return this._704639681friendArmysArray;
      }
      
      public function set finishedQuestCount(param1:int) : void
      {
         var _loc2_:Object = this._1432206175finishedQuestCount;
         if(_loc2_ !== param1)
         {
            this._1432206175finishedQuestCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"finishedQuestCount",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isReceiveIncomingAttack() : Boolean
      {
         return this._2100063033isReceiveIncomingAttack;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = param1 + "changedFace = " + this.changedFace + "\n" + (param1 + "currentDateTime = " + this.currentDateTime + "\n") + (param1 + "currentTime = " + this.currentTime + "\n") + (param1 + "disconnectvotes = " + this.disconnectvotes + "\n") + (param1 + "effortPoint = " + this.effortPoint + "\n") + (param1 + "emailAddress = " + this.emailAddress + "\n") + (param1 + "finishedQuestCount = " + this.finishedQuestCount + "\n") + (param1 + "furloughDay = " + this.furloughDay + "\n") + (param1 + "gamblingItemIndex = " + this.gamblingItemIndex + "\n") + (param1 + "gameSpeed = " + this.gameSpeed + "\n") + (param1 + "headline = " + this.headline + "\n") + (param1 + "isEvonyMember = " + this.isEvonyMember + "\n") + (param1 + "isReceiveIncomingAttack = " + this.isReceiveIncomingAttack + "\n") + (param1 + "isSetSecurityCode = " + this.isSetSecurityCode + "\n") + (param1 + "mapSizeX = " + this.mapSizeX + "\n") + (param1 + "mapSizeY = " + this.mapSizeY + "\n") + (param1 + "newMailCount = " + this
         .newMailCount + "\n") + (param1 + "newMaileCount_inbox = " + this.newMaileCount_inbox + "\n") + (param1 + "newMaileCount_system = " + this.newMaileCount_system + "\n") + (param1 + "newReportCount = " + this.newReportCount + "\n") + (param1 + "newReportCount_army = " + this.newReportCount_army + "\n") + (param1 + "newReportCount_other = " + this.newReportCount_other + "\n") + (param1 + "newReportCount_scout = " + this.newReportCount_scout + "\n") + (param1 + "newReportCount_trade = " + this.newReportCount_trade + "\n") + (this.playerInfo != null ? this.playerInfo.toDebugString(param1 + "playerInfo.") : param1 + "playerInfo = null\n") + (param1 + "redCount = " + this.redCount + "\n") + (param1 + "tutorialStepId = " + this.tutorialStepId + "\n") + (param1 + "autoFurlough = " + this.autoFurlough + "\n") + (param1 + "autoHeal = " + this.autoHeal + "\n") + (param1 + "furlough = " + this.furlough + "\n") + (param1 + "returnReport = " + this.returnReport + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.blockBeansArray.length)
         {
            _loc2_ += this.getBlockBeans(_loc3_).toDebugString(param1 + "blockBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.buffsArray.length)
         {
            _loc2_ += this.getBuffs(_loc3_).toDebugString(param1 + "buffsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.castleSignBeanArray.length)
         {
            _loc2_ += this.getCastleSignBean(_loc3_).toDebugString(param1 + "castleSignBeanArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.castlesArray.length)
         {
            _loc2_ += this.getCastles(_loc3_).toDebugString(param1 + "castlesArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.declaredWarBeansArray.length)
         {
            _loc2_ += this.getDeclaredWarBeans(_loc3_).toDebugString(param1 + "declaredWarBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.enemyArmysArray.length)
         {
            _loc2_ += this.getEnemyArmys(_loc3_).toDebugString(param1 + "enemyArmysArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.equipmentsArray.length)
         {
            _loc2_ += this.getEquipments(_loc3_).toDebugString(param1 + "equipmentsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.friendArmysArray.length)
         {
            _loc2_ += this.getFriendArmys(_loc3_).toDebugString(param1 + "friendArmysArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.friendBeansArray.length)
         {
            _loc2_ += this.getFriendBeans(_loc3_).toDebugString(param1 + "friendBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.gemstoneinposArray.length)
         {
            _loc2_ += this.getGemstoneinpos(_loc3_).toDebugString(param1 + "gemstoneinposArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.itemsArray.length)
         {
            _loc2_ += this.getItems(_loc3_).toDebugString(param1 + "itemsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.packageBeanArray.length)
         {
            _loc2_ += this.getPackageBean(_loc3_).toDebugString(param1 + "packageBeanArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.randomEventsArray.length)
         {
            _loc2_ += this.getRandomEvents(_loc3_).toDebugString(param1 + "randomEventsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.saleItemBeansArray.length)
         {
            _loc2_ += this.getSaleItemBeans(_loc3_).toDebugString(param1 + "saleItemBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.saleTypeBeansArray.length)
         {
            _loc2_ += this.getSaleTypeBeans(_loc3_).toDebugString(param1 + "saleTypeBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.selfArmysArray.length)
         {
            _loc2_ += this.getSelfArmys(_loc3_).toDebugString(param1 + "selfArmysArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.setshowinfroArray.length)
         {
            _loc2_ += this.getSetshowinfro(_loc3_).toDebugString(param1 + "setshowinfroArray[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.troopConfigBeansArray.length)
         {
            _loc2_ += this.getTroopConfigBeans(_loc3_).toDebugString(param1 + "troopConfigBeansArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBuffs(param1:int) : BuffBean
      {
         return this.buffsArray[param1] as BuffBean;
      }
      
      public function copyTo(param1:PlayerBean) : void
      {
         param1.changedFace = this.changedFace;
         param1.currentDateTime = this.currentDateTime;
         param1.currentTime = this.currentTime;
         param1.disconnectvotes = this.disconnectvotes;
         param1.effortPoint = this.effortPoint;
         param1.emailAddress = this.emailAddress;
         param1.finishedQuestCount = this.finishedQuestCount;
         param1.furloughDay = this.furloughDay;
         param1.gamblingItemIndex = this.gamblingItemIndex;
         param1.gameSpeed = this.gameSpeed;
         param1.headline = this.headline;
         param1.isEvonyMember = this.isEvonyMember;
         param1.isReceiveIncomingAttack = this.isReceiveIncomingAttack;
         param1.isSetSecurityCode = this.isSetSecurityCode;
         param1.mapSizeX = this.mapSizeX;
         param1.mapSizeY = this.mapSizeY;
         param1.newMailCount = this.newMailCount;
         param1.newMaileCount_inbox = this.newMaileCount_inbox;
         param1.newMaileCount_system = this.newMaileCount_system;
         param1.newReportCount = this.newReportCount;
         param1.newReportCount_army = this.newReportCount_army;
         param1.newReportCount_other = this.newReportCount_other;
         param1.newReportCount_scout = this.newReportCount_scout;
         param1.newReportCount_trade = this.newReportCount_trade;
         if(this.playerInfo != null)
         {
            this.playerInfo.copyTo(param1.playerInfo);
         }
         else
         {
            param1.playerInfo = null;
         }
         param1.redCount = this.redCount;
         param1.tutorialStepId = this.tutorialStepId;
         param1.autoFurlough = this.autoFurlough;
         param1.autoHeal = this.autoHeal;
         param1.furlough = this.furlough;
         param1.returnReport = this.returnReport;
         CommonUtil.arrayCopy(this.blockBeansArray,param1.blockBeansArray);
         CommonUtil.arrayCopy(this.buffsArray,param1.buffsArray);
         CommonUtil.arrayCopy(this.castleSignBeanArray,param1.castleSignBeanArray);
         CommonUtil.arrayCopy(this.castlesArray,param1.castlesArray);
         CommonUtil.arrayCopy(this.declaredWarBeansArray,param1.declaredWarBeansArray);
         CommonUtil.arrayCopy(this.enemyArmysArray,param1.enemyArmysArray);
         CommonUtil.arrayCopy(this.equipmentsArray,param1.equipmentsArray);
         CommonUtil.arrayCopy(this.friendArmysArray,param1.friendArmysArray);
         CommonUtil.arrayCopy(this.friendBeansArray,param1.friendBeansArray);
         CommonUtil.arrayCopy(this.gemstoneinposArray,param1.gemstoneinposArray);
         CommonUtil.arrayCopy(this.itemsArray,param1.itemsArray);
         CommonUtil.arrayCopy(this.packageBeanArray,param1.packageBeanArray);
         CommonUtil.arrayCopy(this.randomEventsArray,param1.randomEventsArray);
         CommonUtil.arrayCopy(this.saleItemBeansArray,param1.saleItemBeansArray);
         CommonUtil.arrayCopy(this.saleTypeBeansArray,param1.saleTypeBeansArray);
         CommonUtil.arrayCopy(this.selfArmysArray,param1.selfArmysArray);
         CommonUtil.arrayCopy(this.setshowinfroArray,param1.setshowinfroArray);
         CommonUtil.arrayCopy(this.troopConfigBeansArray,param1.troopConfigBeansArray);
      }
      
      public function set furloughDay(param1:int) : void
      {
         var _loc2_:Object = this._1887518356furloughDay;
         if(_loc2_ !== param1)
         {
            this._1887518356furloughDay = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"furloughDay",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get autoFurlough() : Boolean
      {
         return this._1329771231autoFurlough;
      }
      
      [Bindable(event="propertyChange")]
      public function get newReportCount_army() : int
      {
         return this._2041542881newReportCount_army;
      }
      
      [Bindable(event="propertyChange")]
      public function get packageBeanArray() : ArrayCollection
      {
         return this._117401885packageBeanArray;
      }
      
      public function set gameSpeed(param1:int) : void
      {
         var _loc2_:Object = this._989948789gameSpeed;
         if(_loc2_ !== param1)
         {
            this._989948789gameSpeed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gameSpeed",_loc2_,param1));
         }
      }
      
      public function set itemsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1425640839itemsArray;
         if(_loc2_ !== param1)
         {
            this._1425640839itemsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemsArray",_loc2_,param1));
         }
      }
      
      public function set mapSizeX(param1:int) : void
      {
         var _loc2_:Object = this._167675003mapSizeX;
         if(_loc2_ !== param1)
         {
            this._167675003mapSizeX = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mapSizeX",_loc2_,param1));
         }
      }
      
      public function set mapSizeY(param1:int) : void
      {
         var _loc2_:Object = this._167675004mapSizeY;
         if(_loc2_ !== param1)
         {
            this._167675004mapSizeY = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mapSizeY",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set newReportCount(param1:int) : void
      {
         var _loc2_:Object = this._230483579newReportCount;
         if(_loc2_ !== param1)
         {
            this._230483579newReportCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newReportCount",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get redCount() : int
      {
         return this._811312386redCount;
      }
      
      public function set gemstoneinposArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._874955648gemstoneinposArray;
         if(_loc2_ !== param1)
         {
            this._874955648gemstoneinposArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gemstoneinposArray",_loc2_,param1));
         }
      }
      
      public function setFriendBeans(param1:PlayerInfoBean, param2:int) : void
      {
         this.friendBeansArray[param2] = param1;
      }
      
      public function set returnReport(param1:Boolean) : void
      {
         var _loc2_:Object = this._784915076returnReport;
         if(_loc2_ !== param1)
         {
            this._784915076returnReport = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"returnReport",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get saleItemBeansArray() : ArrayCollection
      {
         return this._1102495504saleItemBeansArray;
      }
      
      public function setGemstoneinpos(param1:GemStoneInPosBean, param2:int) : void
      {
         this.gemstoneinposArray[param2] = param1;
      }
      
      public function getCastleSignBean(param1:int) : CastleSignInfoBean
      {
         return this.castleSignBeanArray[param1] as CastleSignInfoBean;
      }
      
      public function set friendBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1918704276friendBeansArray;
         if(_loc2_ !== param1)
         {
            this._1918704276friendBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"friendBeansArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get enemyArmysArray() : ArrayCollection
      {
         return this._1378032427enemyArmysArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get changedFace() : Boolean
      {
         return this._1651231951changedFace;
      }
      
      public function getSaleItemBeans(param1:int) : SaleItemBean
      {
         return this.saleItemBeansArray[param1] as SaleItemBean;
      }
      
      public function setCastleSignBean(param1:CastleSignInfoBean, param2:int) : void
      {
         this.castleSignBeanArray[param2] = param1;
      }
      
      public function set isEvonyMember(param1:Boolean) : void
      {
         var _loc2_:Object = this._2054170777isEvonyMember;
         if(_loc2_ !== param1)
         {
            this._2054170777isEvonyMember = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isEvonyMember",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get castleSignBeanArray() : ArrayCollection
      {
         return this._675024588castleSignBeanArray;
      }
      
      public function set castlesArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._902435682castlesArray;
         if(_loc2_ !== param1)
         {
            this._902435682castlesArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castlesArray",_loc2_,param1));
         }
      }
      
      public function setBuffs(param1:BuffBean, param2:int) : void
      {
         this.buffsArray[param2] = param1;
      }
      
      public function getFriendArmys(param1:int) : ArmyBean
      {
         return this.friendArmysArray[param1] as ArmyBean;
      }
      
      public function set gamblingItemIndex(param1:int) : void
      {
         var _loc2_:Object = this._1484814694gamblingItemIndex;
         if(_loc2_ !== param1)
         {
            this._1484814694gamblingItemIndex = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gamblingItemIndex",_loc2_,param1));
         }
      }
      
      public function setRandomEvents(param1:RandomEventBean, param2:int) : void
      {
         this.randomEventsArray[param2] = param1;
      }
      
      public function set newReportCount_trade(param1:int) : void
      {
         var _loc2_:Object = this._1119145312newReportCount_trade;
         if(_loc2_ !== param1)
         {
            this._1119145312newReportCount_trade = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newReportCount_trade",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      private function toObjArrayHelper(param1:ArrayCollection) : ArrayCollection
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            _loc2_ = new ArrayCollection();
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(param1.getItemAt(_loc3_) != null && param1.getItemAt(_loc3_).toObject != undefined)
               {
                  _loc2_.addItem(param1.getItemAt(_loc3_).toObject());
               }
               else
               {
                  _loc2_.addItem(param1.getItemAt(_loc3_));
               }
               _loc3_++;
            }
            return _loc2_;
         }
         return null;
      }
      
      public function set newMaileCount_inbox(param1:int) : void
      {
         var _loc2_:Object = this._2026418520newMaileCount_inbox;
         if(_loc2_ !== param1)
         {
            this._2026418520newMaileCount_inbox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newMaileCount_inbox",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playerInfo() : PlayerInfoBean
      {
         return this._2095520559playerInfo;
      }
      
      public function getSetshowinfro(param1:int) : SetShowInfro
      {
         return this.setshowinfroArray[param1] as SetShowInfro;
      }
      
      public function setPackageBean(param1:PackageBean, param2:int) : void
      {
         this.packageBeanArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get finishedQuestCount() : int
      {
         return this._1432206175finishedQuestCount;
      }
      
      public function set disconnectvotes(param1:Number) : void
      {
         var _loc2_:Object = this._1440789421disconnectvotes;
         if(_loc2_ !== param1)
         {
            this._1440789421disconnectvotes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"disconnectvotes",_loc2_,param1));
         }
      }
      
      public function set troopConfigBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._196779434troopConfigBeansArray;
         if(_loc2_ !== param1)
         {
            this._196779434troopConfigBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troopConfigBeansArray",_loc2_,param1));
         }
      }
      
      public function getTroopConfigBeans(param1:int) : TroopConfigBean
      {
         return this.troopConfigBeansArray[param1] as TroopConfigBean;
      }
      
      public function set equipmentsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1503909044equipmentsArray;
         if(_loc2_ !== param1)
         {
            this._1503909044equipmentsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"equipmentsArray",_loc2_,param1));
         }
      }
      
      public function getSaleTypeBeans(param1:int) : SaleTypeBean
      {
         return this.saleTypeBeansArray[param1] as SaleTypeBean;
      }
      
      public function set emailAddress(param1:String) : void
      {
         var _loc2_:Object = this._1070931784emailAddress;
         if(_loc2_ !== param1)
         {
            this._1070931784emailAddress = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"emailAddress",_loc2_,param1));
         }
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
      
      [Bindable(event="propertyChange")]
      public function get furloughDay() : int
      {
         return this._1887518356furloughDay;
      }
      
      public function set setshowinfroArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1970419386setshowinfroArray;
         if(_loc2_ !== param1)
         {
            this._1970419386setshowinfroArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"setshowinfroArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gameSpeed() : int
      {
         return this._989948789gameSpeed;
      }
      
      [Bindable(event="propertyChange")]
      public function get gemstoneinposArray() : ArrayCollection
      {
         return this._874955648gemstoneinposArray;
      }
      
      public function set friendArmysArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._704639681friendArmysArray;
         if(_loc2_ !== param1)
         {
            this._704639681friendArmysArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"friendArmysArray",_loc2_,param1));
         }
      }
      
      public function set blockBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1461815869blockBeansArray;
         if(_loc2_ !== param1)
         {
            this._1461815869blockBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blockBeansArray",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set isReceiveIncomingAttack(param1:Boolean) : void
      {
         var _loc2_:Object = this._2100063033isReceiveIncomingAttack;
         if(_loc2_ !== param1)
         {
            this._2100063033isReceiveIncomingAttack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isReceiveIncomingAttack",_loc2_,param1));
         }
      }
      
      public function getFriendBeans(param1:int) : PlayerInfoBean
      {
         return this.friendBeansArray[param1] as PlayerInfoBean;
      }
      
      public function setDeclaredWarBeans(param1:PlayerDeclaredWarBean, param2:int) : void
      {
         this.declaredWarBeansArray[param2] = param1;
      }
      
      public function toObject() : Object
      {
         return {
            "autoFurlough":this.autoFurlough,
            "autoHeal":this.autoHeal,
            "blockBeansArray":this.toObjArrayHelper(this.blockBeansArray),
            "buffsArray":this.toObjArrayHelper(this.buffsArray),
            "castlesArray":this.toObjArrayHelper(this.castlesArray),
            "castleSignBeanArray":this.toObjArrayHelper(this.castleSignBeanArray),
            "changedFace":this.changedFace,
            "currentDateTime":this.currentDateTime,
            "currentTime":this.currentTime,
            "declaredWarBeansArray":this.toObjArrayHelper(this.declaredWarBeansArray),
            "disconnectvotes":this.disconnectvotes,
            "effortPoint":this.effortPoint,
            "emailAddress":this.emailAddress,
            "enemyArmysArray":this.toObjArrayHelper(this.enemyArmysArray),
            "equipmentsArray":this.toObjArrayHelper(this.equipmentsArray),
            "finishedQuestCount":this.finishedQuestCount,
            "friendArmysArray":this.toObjArrayHelper(this.friendArmysArray),
            "friendBeansArray":this.toObjArrayHelper(this.friendBeansArray),
            "furlough":this.furlough,
            "furloughDay":this.furloughDay,
            "gamblingItemIndex":this.gamblingItemIndex,
            "gameSpeed":this.gameSpeed,
            "gemstoneinposArray":this.toObjArrayHelper(this.gemstoneinposArray),
            "headline":this.headline,
            "isEvonyMember":this.isEvonyMember,
            "isReceiveIncomingAttack":this.isReceiveIncomingAttack,
            "isSetSecurityCode":this.isSetSecurityCode,
            "itemsArray":this.toObjArrayHelper(this.itemsArray),
            "mapSizeX":this.mapSizeX,
            "mapSizeY":this.mapSizeY,
            "newMailCount":this.newMailCount,
            "newMaileCount_inbox":this.newMaileCount_inbox,
            "newMaileCount_system":this.newMaileCount_system,
            "newReportCount":this.newReportCount,
            "newReportCount_army":this.newReportCount_army,
            "newReportCount_other":this.newReportCount_other,
            "newReportCount_scout":this.newReportCount_scout,
            "newReportCount_trade":this.newReportCount_trade,
            "packageBeanArray":this.toObjArrayHelper(this.packageBeanArray),
            "playerInfo":this.playerInfo.toObject(),
            "randomEventsArray":this.toObjArrayHelper(this.randomEventsArray),
            "redCount":this.redCount,
            "returnReport":this.returnReport,
            "saleItemBeansArray":this.toObjArrayHelper(this.saleItemBeansArray),
            "saleTypeBeansArray":this.toObjArrayHelper(this.saleTypeBeansArray),
            "selfArmysArray":this.toObjArrayHelper(this.selfArmysArray),
            "setshowinfroArray":this.toObjArrayHelper(this.setshowinfroArray),
            "troopConfigBeansArray":this.toObjArrayHelper(this.troopConfigBeansArray),
            "tutorialStepId":this.tutorialStepId
         };
      }
      
      public function setSaleItemBeans(param1:SaleItemBean, param2:int) : void
      {
         this.saleItemBeansArray[param2] = param1;
      }
      
      public function set headline(param1:String) : void
      {
         var _loc2_:Object = this._1115058732headline;
         if(_loc2_ !== param1)
         {
            this._1115058732headline = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"headline",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get troopConfigBeansArray() : ArrayCollection
      {
         return this._196779434troopConfigBeansArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get disconnectvotes() : Number
      {
         return this._1440789421disconnectvotes;
      }
      
      public function set newMailCount(param1:int) : void
      {
         var _loc2_:Object = this._29843496newMailCount;
         if(_loc2_ !== param1)
         {
            this._29843496newMailCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newMailCount",_loc2_,param1));
         }
      }
      
      public function setCastles(param1:CastleBean, param2:int) : void
      {
         this.castlesArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get buffsArray() : ArrayCollection
      {
         return this._2032248903buffsArray;
      }
      
      public function set newReportCount_army(param1:int) : void
      {
         var _loc2_:Object = this._2041542881newReportCount_army;
         if(_loc2_ !== param1)
         {
            this._2041542881newReportCount_army = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"newReportCount_army",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get blockBeansArray() : ArrayCollection
      {
         return this._1461815869blockBeansArray;
      }
      
      public function getEnemyArmys(param1:int) : ArmyBean
      {
         return this.enemyArmysArray[param1] as ArmyBean;
      }
      
      public function set autoFurlough(param1:Boolean) : void
      {
         var _loc2_:Object = this._1329771231autoFurlough;
         if(_loc2_ !== param1)
         {
            this._1329771231autoFurlough = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoFurlough",_loc2_,param1));
         }
      }
      
      public function set packageBeanArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._117401885packageBeanArray;
         if(_loc2_ !== param1)
         {
            this._117401885packageBeanArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"packageBeanArray",_loc2_,param1));
         }
      }
      
      public function set currentTime(param1:Number) : void
      {
         var _loc2_:Object = this._601235430currentTime;
         if(_loc2_ !== param1)
         {
            this._601235430currentTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentTime",_loc2_,param1));
         }
      }
      
      public function getSelfArmys(param1:int) : ArmyBean
      {
         return this.selfArmysArray[param1] as ArmyBean;
      }
      
      public function setEnemyArmys(param1:ArmyBean, param2:int) : void
      {
         this.enemyArmysArray[param2] = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get newMailCount() : int
      {
         return this._29843496newMailCount;
      }
      
      [Bindable(event="propertyChange")]
      public function get headline() : String
      {
         return this._1115058732headline;
      }
      
      public function getPackageBean(param1:int) : PackageBean
      {
         return this.packageBeanArray[param1] as PackageBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get currentTime() : Number
      {
         return this._601235430currentTime;
      }
      
      public function setSaleTypeBeans(param1:SaleTypeBean, param2:int) : void
      {
         this.saleTypeBeansArray[param2] = param1;
      }
      
      public function set selfArmysArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._859583983selfArmysArray;
         if(_loc2_ !== param1)
         {
            this._859583983selfArmysArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selfArmysArray",_loc2_,param1));
         }
      }
      
      public function set saleItemBeansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1102495504saleItemBeansArray;
         if(_loc2_ !== param1)
         {
            this._1102495504saleItemBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"saleItemBeansArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get selfArmysArray() : ArrayCollection
      {
         return this._859583983selfArmysArray;
      }
      
      public function set randomEventsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1981766659randomEventsArray;
         if(_loc2_ !== param1)
         {
            this._1981766659randomEventsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"randomEventsArray",_loc2_,param1));
         }
      }
      
      public function set redCount(param1:int) : void
      {
         var _loc2_:Object = this._811312386redCount;
         if(_loc2_ !== param1)
         {
            this._811312386redCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"redCount",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get randomEventsArray() : ArrayCollection
      {
         return this._1981766659randomEventsArray;
      }
   }
}

