package autoevony.management
{
   import autoevony.common.BuildingType;
   import autoevony.common.CityStateCommands;
   import autoevony.common.CityStateConstants;
   import autoevony.common.DataRow;
   import autoevony.common.EstimateResource;
   import autoevony.common.GearType;
   import autoevony.common.Items;
   import autoevony.common.TechType;
   import autoevony.common.Utils;
   import autoevony.event.ScriptLogEvent;
   import autoevony.event.WarLogEvent;
   import autoevony.gui.MainScreen;
   import autoevony.net.Connection;
   import autoevony.player.LoginHelper;
   import autoevony.player.Map;
   import autoevony.player.MasterTimer;
   import autoevony.scripts.CityState;
   import autoevony.scripts.Script;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.AllProduceBean;
   import com.evony.common.beans.ArmyBean;
   import com.evony.common.beans.AvailableBuildingListBean;
   import com.evony.common.beans.AvailableResearchListBean;
   import com.evony.common.beans.BuffBean;
   import com.evony.common.beans.BuildingBean;
   import com.evony.common.beans.CastleBean;
   import com.evony.common.beans.CastleResourceBean;
   import com.evony.common.beans.ColonyBean;
   import com.evony.common.beans.ConditionBean;
   import com.evony.common.beans.ConditionDependBuildingBean;
   import com.evony.common.beans.ConditionDependItemBean;
   import com.evony.common.beans.ConditionDependTechBean;
   import com.evony.common.beans.FieldBean;
   import com.evony.common.beans.FortProduceListBean;
   import com.evony.common.beans.FortificationsBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.ItemBean;
   import com.evony.common.beans.MapCastleBean;
   import com.evony.common.beans.MilitarySituation;
   import com.evony.common.beans.PackageBean;
   import com.evony.common.beans.PlayerBean;
   import com.evony.common.beans.ProduceBean;
   import com.evony.common.beans.QuestBean;
   import com.evony.common.beans.QuestTypeBean;
   import com.evony.common.beans.RandomEventBean;
   import com.evony.common.beans.ReportBean;
   import com.evony.common.beans.ResourceBean;
   import com.evony.common.beans.ResourceInfoBean;
   import com.evony.common.beans.TradeBean;
   import com.evony.common.beans.TransingTradeBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.beans.TroopProduceListBean;
   import com.evony.common.beans.TroopStrBean;
   import com.evony.common.constants.AllianceConstants;
   import com.evony.common.constants.ArmyConstants;
   import com.evony.common.constants.BuildingConstants;
   import com.evony.common.constants.ColonyConstants;
   import com.evony.common.constants.CommonConstants;
   import com.evony.common.constants.EquipmentTech;
   import com.evony.common.constants.ErrorCode;
   import com.evony.common.constants.FieldConstants;
   import com.evony.common.constants.HeroConstants;
   import com.evony.common.constants.ObjConstants;
   import com.evony.common.constants.TFConstants;
   import com.evony.common.constants.TechConstants;
   import com.evony.common.constants.TradeConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.AllianceMembersResponse;
   import com.evony.common.module.alliance.MilitarySituationListResponse;
   import com.evony.common.module.castle.AvailableBuilingListResponse;
   import com.evony.common.module.common.GetPackageListResponse;
   import com.evony.common.module.common.GetPackageResponse;
   import com.evony.common.module.fortifications.FortProduceListResponse;
   import com.evony.common.module.gemstone.GemstoneRespone;
   import com.evony.common.module.hero.HeroListResponse;
   import com.evony.common.module.quest.QuestListResponse;
   import com.evony.common.module.quest.QuestTypeResponse;
   import com.evony.common.module.report.ReportListResponse;
   import com.evony.common.module.report.ReportResponse;
   import com.evony.common.module.shop.UseItemResultResponse;
   import com.evony.common.module.tech.AvailableResearchListResponse;
   import com.evony.common.module.tech.ResearchResponse;
   import com.evony.common.module.trade.SearchTradesResponse;
   import com.evony.common.module.trade.TradeListResponse;
   import com.evony.common.module.trade.TransingTradeListResponse;
   import com.evony.common.module.troop.ProduceQueueResponse;
   import com.evony.common.module.troop.TroopProduceListResponse;
   import com.evony.common.paramBeans.NewArmyParam;
   import com.evony.common.server.events.BuildComplate;
   import com.evony.common.server.events.CastleBuffUpdate;
   import com.evony.common.server.events.CastleUpdate;
   import com.evony.common.server.events.FortificationsUpdate;
   import com.evony.common.server.events.HeroUpdate;
   import com.evony.common.server.events.InjuredTroopUpdate;
   import com.evony.common.server.events.LoginResponse;
   import com.evony.common.server.events.NewReport;
   import com.evony.common.server.events.ResearchCompleteUpdate;
   import com.evony.common.server.events.TradesUpdate;
   import com.evony.common.server.events.TransingTradeUpdate;
   import com.rd.REAddons;
   import com.skype.Skype;
   import com.skype.SkypeResponse;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.utils.Timer;
   import mx.collections.ArrayCollection;
   import mx.collections.Sort;
   
   public class CityManager extends EventDispatcher
   {
      public static const COLR_STD_LOG_MSG:String = "#00006A";
      
      public static const COLR_DBG_LOG_MSG:String = "#156510";
      
      public static const COLR_AWR_LOG_MSG:String = "#E26AE2";
      
      public static const COLR_DEF_LOG_MSG:String = "#FF9933";
      
      public static const COLR_WRN_LOG_MSG:String = "#AA0000";
      
      public static const COLR_ERR_LOG_MSG:String = "#CC0000";
      
      private static const GATE_AUTO:int = 0;
      
      private static const GATE_OPEN:int = 1;
      
      private static const GATE_CLOSE:int = 2;
      
      private static const GATE_SNEAKY:int = 3;
      
      private static const GATE_GTALX:int = 4;
      
      private static const GATE_PEACE:int = 0;
      
      private static const GATE_ATTACK:int = 1;
      
      private static const GATE_SCOUTBOMB:int = 2;
      
      private static const GATE_MIXED:int = 3;
      
      private static const GATE_PAUSED:int = 4;
      
      private static const DISTANCE_NPC:int = 0;
      
      private static const DISTANCE_BUILDNPC:int = 1;
      
      private static const DISTANCE_HUNTING:int = 2;
      
      private static const DISTANCE_VALLEY:int = 3;
      
      private static const DISTANCE_BUILDNPC10:int = 4;
      
      private static var resourceIntNames:Array = new Array("food","wood","stone","iron","gold");
      
      private static var resourceNames:Array = new Array("food","lumber","stone","iron");
      
      private static var troopIntNames:Array = new Array("","","peasants","militia","scouter","pikemen","swordsmen","archer","carriage","lightCavalry","heavyCavalry","ballista","batteringRam","catapult","trap","abatis","arrowTower","rollingLogs","rockfall");
      
      private static var troopExtNames:Array = new Array("","","worker","warrior","scout","pikemen","swordsmen","archer","transport","cavalry","cataphract","ballista","battering ram","catapult","trap","abatis","archer tower","rolling log","trebuchev");
      
      private static var troopPopulations:Array = new Array(0,0,1,1,1,1,1,2,4,3,6,5,10,8);
      
      private static var troopLoads:Array = new Array(0,0,200,20,5,40,30,25,5000,100,80,35,45,75);
      
      private static var troopTimes:Array = new Array(0,0,50,25,100,150,225,350,1000,500,1500,3000,4500,6000,60,120,180,360,600);
      
      private static var troopTypes:Array = new Array(TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_CARRIAGE,TFConstants.T_BALLISTA,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
      
      private static const ANYCOORDINATE:int = 1000000;
      
      private static const MAXTRADESIZE:int = 99999999;
      
      private static const THOUSAND:int = 1000;
      
      private static const requestHelpFullFactor:Number = 0.3;
      
      private static const XNPC_LEVEL:int = 0;
      
      private static const XNPC_LIMIT:int = 1;
      
      private static const XNPC_TROOP:int = 2;
      
      private static const XNPC_RADIUS:int = 3;
      
      private static const XNPC_FREQUENCY:int = 4;
      
      private static const XNPC_HEROLIST:int = 5;
      
      private static const XNPC_NPCLIST:int = 6;
      
      private static var troopProductionUpdateRequested:int = 0;
      
      private static var troopProductionUpdateRequestedTime:Number = 0;
      
      private static var fortificationProductionUpdateRequested:int = 0;
      
      private static var fortificationProductionUpdateRequestedTime:Number = 0;
      
      private static var lastMaintenanceDownTime:Number = -1;
      
      private static var colonyStatusName:Array = new Array("free","attacking","occupied","uprising","abandoned","war anti colony");
      
      private static var varTroopUnits:Array = new Array(TFConstants.T_BALLISTA,TFConstants.T_ARCHER,TFConstants.T_SCOUTER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_CATAPULT,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_HEAVYCAVALRY,TFConstants.T_MILITIA,TFConstants.T_BATTERINGRAM,TFConstants.T_PEASANTS);
      
      private static const GEARING_BONUSES:Array = [0,0.4,0.75,1,1.32,1.74,2.3,3.04,4.01,5.29,6.98,9.22,12.17,16.06,21.2,27.98];
      
      private static const MAXHEROSPEEDBONUS:Number = 2;
      
      private static const FOODFACTOR:Number = 2;
      
      private static var lastMarketLagTimes:Array = new Array(0,0,0);
      
      private static var buildCityFrom:int = -1;
      
      private static var ownArmiesSeen:Object = new Object();
      
      private static var seedMarketInterest:int = 0;
      
      private static var currMarketInterest:int = -1;
      
      private static var estimateMaintenanceDownTime:Number = -1;
      
      private static var lastAntiBattleErrorTime:Date = null;
      
      private static const TITLES:Array = new Array("Civilian","Knight","Baronet","Baron","Viscount","Earl","Marquis","Duke","Furstin","Prinzessin");
      
      private static const POW2:Array = new Array(1,2,4,8,16,32,64,128,256,512,1024,2048);
      
      private static var market_global:ArrayCollection = new ArrayCollection();
      
      private static const SPEEDUP:Array = new Array(1,2,2,2,3,4,4,4,5,5,6);
      
      private static var mainTownCastleId:int = -1;
      
      private static const RALLY_NPC:int = 0;
      
      private static const RALLY_BUILDNPC:int = 1;
      
      private static const RALLY_HUNTING:int = 2;
      
      private static const RALLY_VALLEY:int = 3;
      
      private static const RALLY_KEEPRESOURCE:int = 4;
      
      private static const RALLY_KEEPTROOP:int = 5;
      
      private static const RALLY_REQUESTHELP:int = 6;
      
      private static const RALLY_HIDING:int = 7;
      
      private static const RALLY_RAINBOW:int = 8;
      
      private static var market_internal:Array = null;
      
      private static var lastMarketQueryTime:Date = new Date();
      
      private static var fortificationsTypes:Array = new Array(TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL,TFConstants.F_ARROWTOWER);
      
      private static var npcLocations:Array = new Array();
      
      private static var lastSlowTargetTroops:Object = new Object();
      
      private static var underBPFlag:Boolean = true;
      
      private static var buildCityLocation:int = -1;
      
      private static var HEROFACTOR:Number = 0.998605367071;
      
      private static var playerTimingList:Object = null;
      
      private static var playerTimingListLastSaveTime:Number = 0;
      
      private static var NPCTRANSPORTS:Array = new Array(0,43,71,240,452,798);
      
      private static var seenReports:Array = new Array();
      
      private static var nastFlg:Boolean = false;
      
      private static var nastCNT:int = 0;
      
      private static var matime:int = 0;
      
      private var fieldTargetPlayers:Array = null;
      
      public var tradesArray:ArrayCollection;
      
      private var condGateSettingsRE2:Array = new Array();
      
      private var lastSneakEnemy:ArmyBean = null;
      
      private var lastCounterAmbushTime:Date = null;
      
      private var castleId:int;
      
      private var npcTroopBean:TroopBean = null;
      
      private var wrPlayerIgnoreList:Array = new Array();
      
      private var resourceStamp:Number;
      
      private var innUpdateNeeded:Boolean = true;
      
      private var resourceType:Array = null;
      
      private var npcHeroes:Array = null;
      
      private var keepResourceMinSents:Array;
      
      private var lastEnemyTime:Number = 0;
      
      private var candidateLocalFields:Array = null;
      
      private var condGateSettingsRE:Array = new Array();
      
      private var fieldTargetEnemyAlliances:Array = null;
      
      public var troopProduceQueue:ArrayCollection = null;
      
      private var requestResourceLocalConds:Array;
      
      private var lastRescueTargetTime:Number = -1;
      
      private var rallySettings:Array;
      
      private var sneakFlag:Boolean = true;
      
      private var skypeWarningPolicy:Array = new Array(true,false,false,true);
      
      public var gears:ArrayCollection;
      
      private var loyaltyValue:int = 100;
      
      private var modifiedLoginSchedule:Array = null;
      
      private var honorTroopBean:TroopBean = null;
      
      private var spamTroopBean:TroopBean = null;
      
      private var lastPriorityNPCTargets:Object;
      
      private var slowHuntingPolicy:Array;
      
      private var lastFastTargetLevel:int = -1;
      
      private var noUplevelHeroes:Array = null;
      
      private var lastNewReport:NewReport = null;
      
      private var lastBuildNPCLevels:Object;
      
      private var coloHints:Array;
      
      private var troopListArray:ArrayCollection;
      
      private var promoteCount:int = 0;
      
      private var tradingLimited:Boolean = false;
      
      private var npc10TroopBean:TroopBean = null;
      
      private var keepTroopFieldIds:Array;
      
      private var currentSlowTarget:int = -1;
      
      private var city:CityState;
      
      private var npc10Area:Array = null;
      
      private var npc10List:Array = null;
      
      private var fortificationsRequirements:ArrayCollection;
      
      private var isZeroFoodActive:Boolean = false;
      
      private var loyaltyAttackFieldId:int = -1;
      
      private var lastSlowTargetLevels:Object;
      
      private var lastFlatRollingActivityTime:Number = -1;
      
      private var TROOPPERLEVEL:int = 10000;
      
      private var flatFieldsDetailInfo:ArrayCollection;
      
      private var insideBuildingBeans:ArrayCollection;
      
      private var guardedFortificationsBean:FortificationsBean = null;
      
      private var lastBattleAfterAdvMoveErrorTime:Date = null;
      
      private var priorityNpcSettings:Array;
      
      private var reportPage:int = 1;
      
      private var notSpamHeroes:Array = null;
      
      private var gateSettings:Array = new Array(0,0,0,0,0);
      
      private var extraTroopIntConds:Array;
      
      private var loyaltyAttackNumCav:int = 500;
      
      private var embAllowedPlayers:Array;
      
      private var keepResourceMinResources:Array = new Array();
      
      private var doingComfortRelief:Boolean = false;
      
      private var condGateSettings:Array = new Array();
      
      private var techRequirements:ArrayCollection;
      
      private var cacheEnemyMax:Object;
      
      private var valleyHeroes:Array = null;
      
      private var timeSlot:int = -1;
      
      private var zeroFoodErrorFactor:Number = 1;
      
      private var honorAttackGuard:Boolean = false;
      
      private var tradingSchedule:Array = null;
      
      private var notNpcHeroes:Array = null;
      
      public var enemyValleyArmies:Array;
      
      private var resourceFieldType:int = 1;
      
      private var requestTroopRemoteConds:Array;
      
      private var evacuateTroopOnly:Boolean = false;
      
      private var defaultGateSettings:Array = new Array(0,0,0,0,0);
      
      private var cityCfg:CityConfigs = null;
      
      private var lastSlowTargetFields:Array;
      
      private var fortificationProductionUpdateNeeded:Boolean = true;
      
      private var newLastReportTime:String = null;
      
      public var troopProductionUpdateNeeded:Boolean = true;
      
      private var currentSneakEnemy:ArmyBean = null;
      
      private var lastCapitalTruceErrorTime:Date = null;
      
      private var keepResourceFieldIds:Array;
      
      private var enemyWarningAllianceIgnoreList:Array;
      
      private var huntingType:Array = null;
      
      private var requestTroopLocalConds:Array;
      
      private var vrGateSettingCacheArmyId:int = 0;
      
      private var cacheEnemyMin:Object;
      
      public var transingTradesArray:ArrayCollection;
      
      private var lastDisable:Number = 0;
      
      private var evasionFieldId:int = -1;
      
      private var spamAttackFieldId:int = -1;
      
      public var researches:ArrayCollection = null;
      
      private var advEvasionLastArmyID:int = 0;
      
      private var estResource:EstimateResource;
      
      private var localNPCs:Array = null;
      
      private var advEvasionRules:Array;
      
      private var buildNPCReady:Boolean = true;
      
      private var cityTimingList:Object = null;
      
      private var currRequirements:ArrayCollection;
      
      private var defaultRallySettings:Array;
      
      private var buffTimeUpFactorCache:Number = 1;
      
      private var varAllMembersList:Array;
      
      private var honorAttackFieldId:int = -1;
      
      private var goOutForBattle:Boolean;
      
      public var market:ArrayCollection;
      
      public var enemyColonyArmies:Array;
      
      public var buildings:ArrayCollection;
      
      private var huntingLocation:int = -1;
      
      private var keepTroopTotalFlags:Array;
      
      private var lastSearchHuntingLevel:int = -1;
      
      private var heroStatusStrings:Array;
      
      private var foodHideLoc:int = -1;
      
      private var resourceFieldsDetailInfo:ArrayCollection;
      
      private var specialHeroCount:int = 0;
      
      private var guardedTroopBean:TroopBean = null;
      
      private var resourceMinLimits:Array = null;
      
      private var fieldTargetMinLevel:int = -1;
      
      private var trainingHeroName:String = null;
      
      public var enemyArmies:Array;
      
      private var guardedAttackFieldId:int = -1;
      
      private var trainingHeroNeeded:Boolean = true;
      
      private var candidateResourceFields:Array = null;
      
      private var lastSearchResourceLevel:int = -1;
      
      private var tmpAdvEvadeCache:TroopBean = null;
      
      private var requestResourceRemoteConds:Array;
      
      private var buffCampTimeUpFactorCache:Number = 1;
      
      private var troopRequirements:ArrayCollection;
      
      private var loginSchedule:Array = null;
      
      private var lastFlatRollingLevels:Object;
      
      private var trainingHeroMinStay:int = 0;
      
      public var productionRate:int = -1;
      
      private var keepTroopTroopBeans:Array;
      
      private var castle_captured:Boolean = false;
      
      private var lastGear:int = -1;
      
      private var lastSearchFlatLevel:int = -1;
      
      private var lastReportTime:String = null;
      
      private var quickTimer:Timer;
      
      private var lastTroopTypeProduced:int = -1;
      
      private var buildingRequirements:ArrayCollection;
      
      private var candidateFlatFields:Array = null;
      
      private var fieldTargetPlayersMinLevel:int = -1;
      
      private var valleyTroopBean:TroopBean = null;
      
      private var npc10LimitTroopBean:TroopBean = null;
      
      private var troopRequirement:TroopBean = null;
      
      public var fortificationProduceQueue:ArrayCollection = null;
      
      private var lastSearchHuntingTypeStr:String = "";
      
      private var trainingHeroNextStop:int = -1;
      
      private var maxHonorLost:int = 0;
      
      private var localFieldsDetailInfo:ArrayCollection;
      
      private var tmpAdvEvadeRuleCache:TroopBean = null;
      
      private var npcAvoidList:Array = null;
      
      private var lastNPC10Targets:Object;
      
      private var trainingHeroArrivalTime:Number = 0;
      
      private var NPCBALLISTAS:Array;
      
      private var cacheEnemyExpire:Object;
      
      private var requestHelpFieldIds:Array;
      
      public var fortification:FortificationsBean = null;
      
      private var cityTimingListLastSaveTime:Number = 0;
      
      private var lastNPCTargets:Object;
      
      private var requestHelpWarConds:Array;
      
      private var heroNotIdleError:Boolean = false;
      
      private var furtherInitNeeded:Boolean = true;
      
      private var resourceMaxLimits:Array = null;
      
      private var wartownSchedule:Array = null;
      
      private var skypeWarningReceiverList:Array = new Array();
      
      private var healingGoldRequired:Number = 0;
      
      private var skypeWarreportReceiverList:Array = new Array();
      
      public var localArmies:Array;
      
      private var vrGateSettingCache:Array = null;
      
      private var enemyWarningPlayerIgnoreList:Array;
      
      private var varAllianceListDeny:Array;
      
      private var MAXBUILDINGLEVEL:int = 10;
      
      private var lastAmbushFromAllSideErrorTime:Date = null;
      
      private var lastFastTargetField:int = -1;
      
      private var extraTroopFields:Array;
      
      private var trainingLoopTime:int = -1;
      
      private var keepTroopMinSents:Array;
      
      private var warRallySettings:Array;
      
      private var outsideBuildingBeans:ArrayCollection;
      
      private var spamHeroes:Array = null;
      
      private var lastZeroFoodOp:Number;
      
      private var heroUpdateNeeded:Boolean = true;
      
      private var loyaltyAttackOnly:Boolean = true;
      
      private var embDeniedPlayers:Array;
      
      private var localNPC10s:Array = null;
      
      private var lastPromoteId:int = -1;
      
      private var npc10Heroes:Array = null;
      
      private var npcArea:Array = null;
      
      private var researchUpdateNeeded:Boolean = true;
      
      private var npcList:Array = null;
      
      private var evacuationTown:int = -1;
      
      private var extraTroopExtConds:Array;
      
      private var distanceSettings:Array = new Array(0,0,0,0);
      
      private var fieldTargetPlayersCenter:int = 0;
      
      private var fortificationsRequirement:FortificationsBean = null;
      
      private var timer:Timer;
      
      private var spamCount:int = 0;
      
      private var autoItems:Object;
      
      private var nextSlowScoutCheck:Number = -1;
      
      private var fieldTargetCenter:int = 0;
      
      private var wrAllianceIgnoreList:Array = new Array();
      
      private var wallBuildingBean:AvailableBuildingListBean = null;
      
      private var reservedHeroes:Array = null;
      
      public var innHeroes:ArrayCollection = null;
      
      private var fieldTargetPlayersRadius:Number = -1;
      
      public var friendlyArmies:Array;
      
      private var lastZeroFoodError:Number;
      
      private var fieldTargetRadius:Number = -1;
      
      private var lastResourceFieldLevels:Object;
      
      private var fortificationListArray:ArrayCollection;
      
      private var goalVars:Object;
      
      private var notFastKeepResoHeroes:Array = null;
      
      public function CityManager(param1:CityState, param2:int)
      {
         super();
         this.castleId = param2;
         this.city = param1;
         if(this.castle.buffsArray == null)
         {
            this.castle.buffsArray = new ArrayCollection();
         }
         this.enemyWarningAllianceIgnoreList = new Array();
         this.enemyWarningPlayerIgnoreList = new Array();
         this.advEvasionRules = new Array();
         this.cityCfg = new CityConfigs();
         this.autoItems = new Object();
         this.autoItems["count"] = 0;
         this.NPCBALLISTAS = new Array(0,20,50,180,280,550);
         this.gears = new ArrayCollection();
         this.fortificationListArray = new ArrayCollection();
         this.troopListArray = new ArrayCollection();
         this.insideBuildingBeans = new ArrayCollection();
         this.outsideBuildingBeans = new ArrayCollection();
         this.resourceFieldsDetailInfo = new ArrayCollection();
         this.flatFieldsDetailInfo = new ArrayCollection();
         this.localFieldsDetailInfo = new ArrayCollection();
         this.goalVars = new Object();
         this.buildings = new ArrayCollection();
         var _loc3_:Date = new Date();
         this.resourceStamp = _loc3_.getTime();
         this.enemyValleyArmies = new Array();
         this.enemyColonyArmies = new Array();
         this.enemyArmies = new Array();
         this.localArmies = new Array();
         this.friendlyArmies = new Array();
         this.estResource = new EstimateResource();
         this.tradesArray = new ArrayCollection();
         this.transingTradesArray = new ArrayCollection();
         this.market = market_global;
         this.currRequirements = new ArrayCollection();
         this.techRequirements = new ArrayCollection();
         this.buildingRequirements = new ArrayCollection();
         this.troopRequirements = new ArrayCollection();
         this.fortificationsRequirements = new ArrayCollection();
         this.extraTroopFields = new Array();
         this.extraTroopExtConds = new Array();
         this.extraTroopIntConds = new Array();
         this.slowHuntingPolicy = new Array(0,null,null,null,3);
         this.priorityNpcSettings = new Array();
         this.coloHints = new Array();
         this.defaultRallySettings = new Array(-1,-1,-1,-1,-1,-1,-1,-1,-1);
         this.warRallySettings = new Array(-1,-1,-1,-1,-1,-1,-1,-1,-1);
         this.rallySettings = new Array(-1,-1,-1,-1,-1,-1,-1,-1,-1);
         this.keepTroopFieldIds = new Array();
         this.keepTroopTroopBeans = new Array();
         this.keepTroopMinSents = new Array();
         this.keepTroopTotalFlags = new Array();
         this.requestHelpFieldIds = new Array();
         this.requestTroopLocalConds = new Array();
         this.requestTroopRemoteConds = new Array();
         this.requestResourceLocalConds = new Array();
         this.requestResourceRemoteConds = new Array();
         this.requestHelpWarConds = new Array();
         this.keepResourceFieldIds = new Array();
         this.keepResourceMinSents = new Array();
         if(this.cityTimingList == null)
         {
            this.cityTimingList = SharedObject.getLocal("cityTimingList" + this.castleId).data.now;
         }
         if(this.cityTimingList == null)
         {
            this.cityTimingList = new Object();
         }
         this.deleteCityTiming("warning");
         this.cacheEnemyMin = new Object();
         this.cacheEnemyMax = new Object();
         this.cacheEnemyExpire = new Object();
         this.lastFlatRollingLevels = new Object();
         this.lastBuildNPCLevels = new Object();
         this.lastNPCTargets = new Object();
         this.lastNPC10Targets = new Object();
         this.lastPriorityNPCTargets = new Object();
         this.lastSlowTargetFields = new Array();
         this.lastSlowTargetLevels = new Object();
         this.lastResourceFieldLevels = new Object();
         this.heroStatusStrings = new Array("Idle","Mayor","Defend","March","Captured","Return");
         this.lastZeroFoodOp = Utils.getServerTime();
         this.lastZeroFoodError = Utils.getServerTime();
         this.isZeroFoodActive = false;
         this.MAXBUILDINGLEVEL = this.castle.powerlevel <= 3 && this.castle.powerlevel >= 0 ? 18 - 2 * this.castle.powerlevel : 10;
         this.TROOPPERLEVEL = this.castle.powerlevel <= 3 && this.castle.powerlevel >= 0 ? int(10000 + 20000 / POW2[this.castle.powerlevel]) : 10000;
         this.timeSlot = MasterTimer.getInstance().reserveSlot();
         if(mainTownCastleId == -1)
         {
            this.setMaintownCastleId();
         }
         this.InitCMValues();
         while(this.market.length < 4)
         {
            this.market.addItem(null);
         }
         this.timer = new Timer(4000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.timer.start();
         this.quickTimer = new Timer(1000);
         this.quickTimer.addEventListener(TimerEvent.TIMER,this.quickManager);
         this.quickTimer.start();
         if(playerTimingList == null)
         {
            playerTimingList = SharedObject.getLocal("playerTimingList").data.now;
         }
         if(playerTimingList == null)
         {
            playerTimingList = new Object();
         }
         if(playerTimingList["lastMaintenanceDownTime"] != undefined)
         {
            lastMaintenanceDownTime = playerTimingList["lastMaintenanceDownTime"].getTime();
         }
         var _loc4_:ResponseDispatcher = ResponseDispatcher.getInstance();
         _loc4_.addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE,this.handleReloginResponse);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_INJURED_TROOP_UPDATE,this.injuredTroopHandle);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE,this.researchComplete);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE,this.buildComplete);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE,this.handleFortificationUpdate);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE,this.onCastleUpdate);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_TRADES_UPDATE,this.onTradesUpdate);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_TRANSING_TRADE_UPDATE,this.updateTransingTrades);
         _loc4_.addEventListener(ResponseDispatcher.REPORT_RECEIVE_REPORT_LIST,this.handleReceiveReportList);
         _loc4_.addEventListener(ResponseDispatcher.SERVER_CASTLE_BUFF_UPDATE,this.handleBuffUpdate);
         _loc4_.addEventListener(ResponseDispatcher.REPORT_MARK_AS_READ,this.reportHandler);
         _loc4_.addEventListener(ResponseDispatcher.QUEST_GET_QUEST_TYPE,this.handleGetQuestType);
         _loc4_.addEventListener(ResponseDispatcher.QUEST_GET_QUEST_LIST,this.handleGetQuestList);
         _loc4_.addEventListener(ResponseDispatcher.QUEST_AWARD,this.handleQuestAward);
         this.embAllowedPlayers = new Array();
         this.embDeniedPlayers = new Array();
         this.varAllianceListDeny = new Array();
         this.varAllMembersList = new Array();
      }
      
      private static function armyToMsgString(param1:ArmyBean) : String
      {
         var _loc2_:String = "";
         if(param1.king != null)
         {
            _loc2_ += " <b>lord</b>:" + param1.king;
         }
         if(param1.alliance != null)
         {
            _loc2_ += " <b>of alliance</b>:" + param1.alliance;
         }
         if(param1.startPosName != null)
         {
            _loc2_ += " <b>from</b>:" + param1.startPosName;
         }
         if(param1.startFieldId != -1)
         {
            _loc2_ += "<b>(</b>" + Map.getX(param1.startFieldId) + "," + Map.getY(param1.startFieldId) + "<b>)</b>";
         }
         if(param1.troop != null)
         {
            _loc2_ += " <b>with troops</b>:" + Utils.troopStrBeanToMsgString(param1.troop,true);
         }
         if(param1.reachTime > 0)
         {
            _loc2_ += " <b>arriving in</b> " + Utils.formatEndTime(param1.reachTime) + " <b>@</b> " + Utils.getLogTimeStr(param1.reachTime);
         }
         return _loc2_;
      }
      
      private static function _jc640RE(param1:TroopBean, param2:TroopBean) : Boolean
      {
         var _loc4_:String = null;
         var _loc3_:Object = param2.toObject();
         for(_loc4_ in _loc3_)
         {
            if(!(param2[_loc4_] == 0 || param2[_loc4_] > 0 && param2[_loc4_] <= param1[_loc4_] || param2[_loc4_] < 0 && -1 * param2[_loc4_] > param1[_loc4_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function cleanUpAndFlushAllTimingLists() : void
      {
         var _loc1_:CityState = null;
         cleanUpAndFlushPlayerTimingList();
         for each(_loc1_ in MainScreen.getCities())
         {
            _loc1_.cityManager.cleanUpAndFlushCityTimingList();
         }
      }
      
      public static function setEstMaintDownTime(param1:int) : void
      {
         estimateMaintenanceDownTime = Utils.getServerTime() + 1000 * param1;
      }
      
      private static function _mo116(param1:TroopBean) : Boolean
      {
         return param1.lightCavalry > 0 && param1.archer == 0 && (param1.militia == 0 || param1.pikemen == 0 || param1.swordsmen == 0) && Utils.getTotalTroopCount(param1) == param1.lightCavalry + param1.militia + param1.pikemen + param1.swordsmen;
      }
      
      private static function isNameRoyal(param1:String) : Boolean
      {
         return param1 == "Queen" || param1 == "King";
      }
      
      public static function getTotalAtkTroops(param1:XMLList) : int
      {
         var _loc3_:* = undefined;
         if(param1.length() == 0)
         {
            return 0;
         }
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ += _loc3_.@count;
         }
         return _loc2_;
      }
      
      public static function cleanUpAndFlushPlayerTimingList() : void
      {
         var _loc2_:String = null;
         var _loc1_:Date = new Date();
         for(_loc2_ in playerTimingList)
         {
            if((playerTimingList[_loc2_] as Date).getTime() < _loc1_.getTime() - 8 * 60 * 60 * 1000)
            {
               delete playerTimingList[_loc2_];
            }
         }
         _loc1_.setTime(lastMaintenanceDownTime);
         playerTimingList["lastMaintenanceDownTime"] = _loc1_;
         flushPlayerTimingList(1);
      }
      
      public static function getBuildCityLocation() : int
      {
         return buildCityLocation;
      }
      
      public static function _updateOwnArmiesSeen(param1:ArrayCollection) : void
      {
         var latest:ArmyBean;
         var army:ArmyBean = null;
         var key:String = null;
         var armies:ArrayCollection = param1;
         var now:Number = Number(new Date().getTime());
         var forced:Boolean = false;
         try
         {
            if(playerTimingAllowed("checkArmiesSeen",60))
            {
               forced = true;
            }
            if(forced && playerTimingAllowed("cleanupOwnArmiesSeen",600))
            {
               for(key in ownArmiesSeen)
               {
                  if(ownArmiesSeen[key] < Utils.getServerTime() - 15 * 60 * 1000)
                  {
                     delete ownArmiesSeen[key];
                  }
               }
            }
         }
         catch(e:Error)
         {
            playerTimingAllowed("checkArmiesSeen",60);
         }
         latest = null;
         for each(army in armies)
         {
            if(ownArmiesSeen[army.armyId] == undefined)
            {
               ownArmiesSeen[army.armyId] = now;
               if(latest == null)
               {
                  latest = army;
               }
               else if(latest.startTime < army.startTime)
               {
                  latest = army;
               }
            }
         }
         if(latest != null)
         {
            Utils.setEstimatedServerTime(latest.startTime - 500);
         }
      }
      
      private static function isEnoughTroops(param1:TroopBean, param2:TroopBean) : Boolean
      {
         var _loc4_:String = null;
         var _loc3_:Object = param2.toObject();
         for(_loc4_ in _loc3_)
         {
            if(param2[_loc4_] > param1[_loc4_])
            {
               return false;
            }
         }
         return true;
      }
      
      private static function _lb30(param1:HeroBean) : Boolean
      {
         return Utils.isHeroRoyal(param1) || param1.loyalty >= Math.min(100,1.5 * Math.max(param1.management,param1.stratagem,param1.power));
      }
      
      public static function getMatime() : Number
      {
         return matime != 0 ? Number(Math.random() * matime * 1000) : 0;
      }
      
      private static function _xv999(param1:NewArmyParam, param2:ArmyBean) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         for each(_loc3_ in troopTypes)
         {
            if(String(param1.troops[troopIntNames[_loc3_]]) != param2.troop[troopIntNames[_loc3_]])
            {
               return false;
            }
         }
         if(param1.resource == null || param2.resource == null)
         {
            return param1.resource == param2.resource;
         }
         for each(_loc4_ in resourceIntNames)
         {
            if(param1.resource[_loc4_] != param2.resource[_loc4_])
            {
               return false;
            }
         }
         return true;
      }
      
      private static function playerArmyTimingAllowed(param1:String, param2:int, param3:int, param4:Boolean = false) : Boolean
      {
         var _loc5_:Date = new Date();
         _loc5_.setTime(_loc5_.getTime() + param2 * 1000);
         if(playerTimingList[param1] == undefined || _loc5_.getTime() - (playerTimingList[param1] as Date).getTime() > param3 * THOUSAND)
         {
            if(!param4)
            {
               playerTimingList[param1] = _loc5_;
            }
            return true;
         }
         return false;
      }
      
      private static function _yk699(param1:ResourceInfoBean, param2:Number) : Number
      {
         if(param1.amount > param1.max)
         {
            return param1.amount;
         }
         if(param2 < 0)
         {
            return param1.amount;
         }
         var _loc3_:Number = param1.amount + param1.increaseRate * param2 / 3600;
         if(_loc3_ > param1.max)
         {
            return param1.max;
         }
         if(_loc3_ < 1)
         {
            return 0;
         }
         return _loc3_;
      }
      
      private static function getLayerValue(param1:int) : int
      {
         return param1 > 0 ? 1 : (param1 < 0 ? -1 : 0);
      }
      
      private static function playerTimingAllowed(param1:String, param2:int, param3:Boolean = false) : Boolean
      {
         if(playerTimingList[param1] == undefined || new Date().getTime() - (playerTimingList[param1] as Date).getTime() > param2 * THOUSAND)
         {
            if(!param3)
            {
               playerTimingList[param1] = new Date();
            }
            return true;
         }
         return false;
      }
      
      private static function _cn909(param1:TradeBean) : String
      {
         return resourceNames[param1.resType] + " " + int(param1.amount - param1.dealedAmount) + " at " + param1.price;
      }
      
      public static function resoBeanToString(param1:ResourceBean) : String
      {
         var _loc4_:String = null;
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:Object = param1.toObject();
         var _loc3_:String = "";
         for each(_loc4_ in ["gold","food","wood","stone","iron"])
         {
            if(_loc2_[_loc4_] > 0)
            {
               _loc3_ += _loc4_ + ":" + Utils.formatNum(_loc2_[_loc4_],0) + " ";
            }
         }
         return _loc3_;
      }
      
      private static function _rm985(param1:FortificationsBean, param2:FortificationsBean) : Boolean
      {
         var _loc3_:String = null;
         for(_loc3_ in param2.toObject())
         {
            if(param2[_loc3_] > param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      private static function createLabelTextFor_B_Tab(param1:ConditionBean) : String
      {
         var _loc3_:ConditionDependBuildingBean = null;
         var _loc4_:ConditionDependTechBean = null;
         var _loc5_:ConditionDependItemBean = null;
         var _loc2_:String = "";
         if(param1.gold + param1.food + param1.wood + param1.stone + param1.iron > 0)
         {
            _loc2_ += "Resource: " + (param1.gold > 0 ? "g:" + param1.gold + " " : "") + (param1.food > 0 ? "f:" + param1.food + " " : "") + (param1.wood > 0 ? "w:" + param1.wood + " " : "") + (param1.stone > 0 ? "s:" + param1.stone + " " : "") + (param1.iron > 0 ? "i:" + param1.iron + " " : "") + "\n";
         }
         for each(_loc3_ in param1.buildingsArray)
         {
            _loc2_ += BuildingType.buildingExtNames[_loc3_.typeId] + ":" + _loc3_.level + " ";
         }
         for each(_loc4_ in param1.techsArray)
         {
            _loc2_ += TechType.techExtNames[_loc4_.id] + ":" + _loc4_.level + " ";
         }
         for each(_loc5_ in param1.itemsArray)
         {
            _loc2_ += (_loc2_.length > 0 ? "\n" : "") + Items.getItemName(_loc5_.id) + ":" + _loc5_.num;
         }
         return _loc2_;
      }
      
      public static function _wd318(param1:XMLList) : String
      {
         var _loc6_:* = undefined;
         if(param1.@isAttack != "true")
         {
            return "DEFEND REPORT";
         }
         var _loc2_:int = 0;
         var _loc3_:String = param1.scoutInfo.@heroName.toString() != "" ? param1.scoutInfo.@heroName + ":" + param1.scoutInfo.@heroLevel + ", " : "";
         var _loc4_:String = param1.scoutInfo.@support.toString() == "" ? "" : "loy " + param1.scoutInfo.@support + ", pop " + param1.scoutInfo.@population + ", res " + param1.scoutInfo.@gold + "g " + param1.scoutInfo.resource.food + "f " + param1.scoutInfo.resource.wood + "w " + param1.scoutInfo.resource.stone + "s " + param1.scoutInfo.resource.iron + "i";
         var _loc5_:* = "";
         for each(_loc6_ in param1.scoutInfo.fortifications.fortificationsType)
         {
            _loc2_ = int(_loc6_.@typeId);
            if(_loc5_.length != 0)
            {
               _loc5_ += ", ";
            }
            _loc5_ += Utils.troopAbrNames[_loc2_] + ":" + _loc6_.@count;
         }
         if(_loc5_.length == 0)
         {
            _loc5_ = "NONE";
         }
         var _loc7_:* = "";
         for each(_loc6_ in param1.scoutInfo.troops.troopStrType)
         {
            _loc2_ = int(_loc6_.@typeId);
            if(_loc7_.length != 0)
            {
               _loc7_ += ", ";
            }
            _loc7_ += Utils.troopAbrNames[_loc2_] + ":" + _loc6_.@count;
         }
         if(_loc7_.length == 0)
         {
            _loc7_ = "NONE";
         }
         return _loc3_ + "troop: <b>" + _loc7_ + "</b>, fort: " + _loc5_ + ", " + _loc4_;
      }
      
      private static function flushPlayerTimingList(param1:int = 60) : void
      {
         var _loc2_:SharedObject = null;
         if(new Date().getTime() - playerTimingListLastSaveTime > param1 * THOUSAND)
         {
            _loc2_ = SharedObject.getLocal("playerTimingList");
            _loc2_.data.now = playerTimingList;
            _loc2_.flush();
            if(Version.isTraceOn())
            {
               trace("flushed playerTimingList at " + new Date().toString());
            }
            playerTimingListLastSaveTime = new Date().getTime();
         }
      }
      
      public static function _ix545(param1:XMLList) : String
      {
         var _loc5_:* = undefined;
         if(param1.length() == 0)
         {
            return "<i>NO ATTACKER TROOP INFO</i>";
         }
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:* = "";
         for each(_loc5_ in param1)
         {
            _loc2_ = int(_loc5_.@typeId);
            _loc3_ = _loc5_.@count;
            if(Utils.hasValue(_loc3_))
            {
               if(int(_loc3_) != 0)
               {
                  if(_loc4_.length != 0)
                  {
                     _loc4_ += ",";
                  }
                  _loc4_ += Utils.troopAbrNames[_loc2_] + ":" + _loc3_;
               }
            }
         }
         return _loc4_;
      }
      
      public static function deletePlayerTiming(param1:String) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in playerTimingList)
         {
            if(_loc2_.indexOf(param1) == 0)
            {
               delete playerTimingList[_loc2_];
            }
         }
      }
      
      private function checkIfHaveItem(param1:String) : Boolean
      {
         var _loc2_:ItemBean = null;
         for each(_loc2_ in this.player.itemsArray)
         {
            if(_loc2_.id != null && _loc2_.count > 0 && param1.toLowerCase() == Items.getItemName(_loc2_.id).toLowerCase())
            {
               return true;
            }
         }
         return false;
      }
      
      private function _dj1085() : Boolean
      {
         var _loc5_:AllProduceBean = null;
         var _loc6_:ProduceBean = null;
         var _loc1_:HeroBean = this.getBestIdleAttackHeroByStaminaIncGear(0);
         if(_loc1_ == null)
         {
            return true;
         }
         var _loc2_:Boolean = false;
         var _loc3_:Number = _loc1_ == null ? 0 : Utils.getMaxStatValueByType(_loc1_,"power");
         var _loc4_:int = 0;
         for each(_loc5_ in this.troopProduceQueue)
         {
            for each(_loc6_ in _loc5_.allProduceQueueArray)
            {
               _loc4_ = this._ui319(_loc6_.type,_loc3_);
               if(_loc6_.costTime > 30 * 60 && _loc6_.costTime > 1.5 * (1 + _loc4_) * _loc6_.num && _loc6_.num > 5)
               {
                  this.logErrMsg("Bad troop queue " + _loc5_.positionId + ":" + _loc6_.queueId + ": " + _loc6_.num + " " + troopExtNames[_loc6_.type] + " takes " + Utils.formatTime(_loc6_.costTime) + "/" + Utils.formatTime(_loc4_ * _loc6_.num));
                  _loc2_ = true;
                  CityStateCommands.cancelTroopProduce(this.castleId,_loc5_.positionId,_loc6_.queueId);
                  _loc6_.num = 0;
                  this.troopProductionUpdateNeeded = true;
               }
            }
         }
         if(_loc2_)
         {
            CityStateCommands.dischargeChief(this.castleId,this.onHeroDischargeResponse);
            this.lastPromoteId = -1;
         }
         return _loc2_;
      }
      
      public function _populate_C_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:ColonyBean = null;
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         for each(_loc4_ in this.colonies)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = _loc4_.position.replace(".",",");
            _loc3_.col2 = _loc4_.lordName;
            _loc3_.col3 = Utils.formatInt(_loc4_.prestige);
            _loc3_.col4 = _loc4_.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED ? "suzerain" : (_loc4_.relation == ColonyConstants.COLONY_RELATION_COLONYING ? "colony" : "" + _loc4_.relation);
            _loc3_.col5 = _loc4_.endTime != 0 ? Utils.formatEndTime(_loc4_.endTime) : "";
            _loc3_.col6 = Map.coordStringToFieldId(_loc4_.position);
            _loc3_.label = "CastleId: " + _loc4_.castleId + "\nStatus: " + _loc4_.status + "\nCity name: " + _loc4_.cityName + "\nAlliance: " + _loc4_.allianceName + "\nCan levy/draft: " + (_loc4_.isCanLevy ? "yes" : "no") + "\nCan overview: " + (_loc4_.isCanOverview ? "yes" : "no") + (_loc4_.endTime != 0 ? "\nEnd time: " + Utils.getLogTimeStr(_loc4_.endTime) : "") + (_loc4_.startTime != 0 ? "\nStart time: " + Utils.getLogTimeStr(_loc4_.startTime) : "");
            _loc2_.addItem(_loc3_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      public function _io1033(param1:FortificationsBean) : void
      {
         this.fortificationsRequirements.addItem(param1);
         this.cityCfg.configs[CityConfigs.CFG_FORTIFICATION] = 1;
      }
      
      private function doEstimateResource() : void
      {
         this.estResource.gold = this.resource.gold;
         this.estResource.food = this.resource.food.amount;
         var _loc1_:Number = (Utils.getServerTime() - this.resourceStamp) / 1000;
         var _loc2_:Number = Utils.getServerLagTime() / 1000 + 20;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(this.resource.troopCostFood > this.resource.food.increaseRate)
         {
            this.estResource.food -= (this.resource.troopCostFood - this.resource.food.increaseRate) * (_loc1_ + _loc2_) / 3600;
         }
         if(this.resource.supplyFood < 0)
         {
            this.estResource.food += this.resource.supplyFood * (_loc1_ + _loc2_) / 3600;
         }
         if(this.estResource.food < 0)
         {
            this.estResource.food = 0;
         }
         this.estResource.wood = _yk699(this.resource.wood,_loc1_ - _loc2_);
         this.estResource.stone = _yk699(this.resource.stone,_loc1_ - _loc2_);
         this.estResource.iron = _yk699(this.resource.iron,_loc1_ - _loc2_);
         this.estResource.curPopulation = this.resource.curPopulation;
         this.estResource.workPeople = this.resource.workPeople;
      }
      
      private function upgradeCost(param1:AvailableResearchListBean, param2:Object, param3:Object) : String
      {
         var _loc4_:String = null;
         var _loc5_:ConditionDependItemBean = null;
         if(param1.conditionBean == null)
         {
            return "";
         }
         _loc4_ = "\n\nMaterial cost:\n";
         for each(_loc5_ in param1.conditionBean.itemsArray)
         {
            _loc4_ += "\n" + param3[_loc5_.id] + " - " + _loc5_.num + "/" + param2[_loc5_.id];
         }
         return _loc4_;
      }
      
      private function _gt1139(param1:Array) : Boolean
      {
         if(!isEnoughTroops(this.troop,param1[XNPC_LIMIT]))
         {
            return false;
         }
         if(param1[XNPC_NPCLIST] == null)
         {
            return false;
         }
         if(this.researches == null)
         {
            return false;
         }
         if(this._ty399())
         {
            return false;
         }
         if(this.getCfg(CityConfigs.CFG_HIDING) > 0 && this.enemyArmies.length > 0)
         {
            if(this.getTotalAvailableHeroes() <= 2)
            {
               return false;
            }
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         if(this._cd932 != -1 && this._rr420(-1) >= this._cd932)
         {
            return false;
         }
         var _loc2_:HeroBean = param1[XNPC_HEROLIST] == null ? this._ej801() : this._us376(param1[XNPC_HEROLIST]);
         var _loc3_:Boolean = false;
         if(_loc2_ != null && !playerTimingAllowed("priorityherobusy" + _loc2_.id,15,false))
         {
            _loc2_ = null;
            _loc3_ = true;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
         {
            if(!_loc3_)
            {
               this.logMsg("checking idle hero for priority farming: " + Utils.heroBeanToString(_loc2_));
            }
         }
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc4_:* = param1[XNPC_NPCLIST];
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:MapCastleBean = null;
         var _loc10_:TroopBean = null;
         var _loc11_:NewArmyParam = null;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         while(_loc13_ < _loc4_.length)
         {
            _loc7_ = int(_loc4_[_loc13_]);
            if(this.npcAvoidList == null || this.npcAvoidList.indexOf(_loc7_) == -1)
            {
               if(Map.getLevel(_loc7_) == param1[XNPC_LEVEL])
               {
                  _loc8_ = Map.getType(_loc7_);
                  if(_loc8_ != -1)
                  {
                     if(_loc8_ != FieldConstants.TYPE_NPC)
                     {
                        this.logMsg(Map.fieldIdToString(_loc7_) + " is not, or is no longer, an NPC");
                        _loc4_.splice(_loc13_,1);
                     }
                     else
                     {
                        _loc9_ = Map.getDetailInfo(_loc7_);
                        if(_loc9_ != null)
                        {
                           if(_loc9_.powerLevel == 4)
                           {
                              _loc6_++;
                              _loc10_ = param1[XNPC_TROOP];
                              if(!isEnoughTroops(this.troop,_loc10_))
                              {
                                 if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
                                 {
                                    this.logMsg("Not enough troop for priority farming npc" + param1[XNPC_LEVEL]);
                                 }
                                 return false;
                              }
                              _loc5_++;
                              if(!this._bb1110(_loc7_))
                              {
                                 _loc11_ = new NewArmyParam();
                                 _loc11_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                 _loc11_.heroId = _loc2_.id;
                                 _loc11_.targetPoint = _loc7_;
                                 _loc11_.troops = _loc10_;
                                 _loc11_.resource = new ResourceBean();
                                 _loc12_ = this.getTravelTimeReliefStationAdj(_loc11_) / Utils.getHeroSpeedFactor(_loc2_);
                                 if(!this.isEnoughResourcesToMarch(_loc11_))
                                 {
                                    return false;
                                 }
                                 if(this.isWarTownOn(2 * _loc12_))
                                 {
                                    this.logMsg("wartownpolicy doesn\'t allow sending troops out: priorityfarming");
                                    return false;
                                 }
                                 if(playerArmyTimingAllowed("attack" + _loc7_,_loc12_,param1[XNPC_FREQUENCY] * 60))
                                 {
                                    playerTimingAllowed("priorityherobusy" + _loc2_.id,0);
                                    this.logMsg("PRIORITYFARMING > sending attack to " + Map.fieldIdToString(_loc7_) + " using hero " + Utils.heroBeanToString(_loc2_) + " with " + Utils.troopBeanToString(_loc11_.troops) + " arriving in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc11_) / Utils.getHeroSpeedFactor(_loc2_)),COLR_STD_LOG_MSG);
                                    if(_loc2_.status == HeroConstants.HERO_CHIEF_STATU || _loc2_.id == this.lastPromoteId)
                                    {
                                       this.removeMayor();
                                    }
                                    CityStateCommands.newArmy(this.castleId,_loc11_,this.handleArmyCommandResponse);
                                    this.lastPriorityNPCTargets[_loc7_] = _loc7_;
                                    this.adjEstFoodAfterMarch(_loc11_);
                                    Map.reqMapInfoAndDetail(_loc7_);
                                    return true;
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc13_++;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > number of local npc" + param1[XNPC_LEVEL] + " for priority farming: " + _loc6_ + "/" + _loc4_.length + ", recently farmed: " + _loc5_,COLR_DBG_LOG_MSG);
         }
         return false;
      }
      
      private function doHandleEnemies() : void
      {
         var reachedCount:int = 0;
         var i:int = 0;
         var a:ArmyBean = null;
         var ind:int = 0;
         var interval:int = 0;
         try
         {
            if(this.getCfg(CityConfigs.CFG_GATE) > 0)
            {
               this.doGateDefense();
            }
            if(this.getCfg(CityConfigs.CFG_HIDING) > 0)
            {
               this._ij1069();
            }
            reachedCount = 0;
            i = 0;
            while(i < this.enemyArmies.length)
            {
               if(this.enemyArmies[i].reachTime < Utils.getServerTime())
               {
                  reachedCount++;
               }
               i++;
            }
            if(this.enemyArmies.length == reachedCount || this.enemyArmies.length > 0 && this.enemyArmies[0].reachTime > Utils.getServerTime() + 1800 * 1000 + this.getCfg(CityConfigs.CFG_GATE) * 60)
            {
               this.tradingLimited = false;
               if(this.cityTimingAllowed("idlerecall",5))
               {
                  if(this.getCfg(CityConfigs.CFG_HIDING) > 0)
                  {
                     this._fx1070(null);
                  }
                  if(this.getCfg(CityConfigs.CFG_GATE) > 0)
                  {
                     this._vc796(null);
                  }
               }
            }
            if(this.cityTimingAllowed("recallrunaway",60))
            {
               this.recallStaleEvasionArmies();
               this._np1318();
            }
            if(this.enemyArmies.length > 0)
            {
               a = null;
               ind = -1;
               i = 0;
               while(i < this.enemyArmies.length)
               {
                  a = this.enemyArmies[i];
                  if(a.missionType != ObjConstants.ARMY_MISSION_SUPPRESS && a.missionType != ObjConstants.ARMY_MISSION_SEND)
                  {
                     if(!this.isJunkTroop(a.troop))
                     {
                        ind = i;
                        break;
                     }
                  }
                  i++;
               }
               if(ind != -1)
               {
                  this.doAutoUseTruce(1000,false,false,true,false);
               }
               if(ind != -1 && this.enemyArmies[ind].reachTime - Utils.getServerTime() < 3600 * 1000)
               {
                  this.lastEnemyTime = this.enemyArmies[ind].reachTime;
               }
               if(ind != -1 && this.enemyArmies[ind].reachTime < Utils.getServerTime() + 5 * 60 * 3600)
               {
                  this._reserveEmergencyTimeSlot();
               }
               interval = ind == -1 || this.enemyArmies[ind].reachTime > Utils.getServerTime() + 3600 * 1000 ? 600 : 60;
               if(this.cityTimingAllowed("attack",interval))
               {
                  if(this.cityTimingAllowed("allattacks",300))
                  {
                     this.logMsg("<b>ATTACK > by</b>: " + armyToMsgString(this.enemyArmies[0]) + ", " + this.enemyArmies.length + " waves",COLR_ERR_LOG_MSG);
                     i = 1;
                     while(i < this.enemyArmies.length)
                     {
                        if(this.getCfg(CityConfigs.CFG_LIMITATKWARNINGLOGMSG) == 1 && i > 10 || this.getCfg(CityConfigs.CFG_LIMITATKWARNINGLOGMSG) > 1 && i > this.getCfg(CityConfigs.CFG_LIMITATKWARNINGLOGMSG))
                        {
                           break;
                        }
                        a = this.enemyArmies[i];
                        if(!this.isJunkTroop(a.troop))
                        {
                           this.logMsg("<b>ATTACK > </b>: [" + (i + 1) + "] " + armyToMsgString(a));
                        }
                        i++;
                     }
                  }
                  else
                  {
                     if(ind == -1)
                     {
                        ind = 0;
                     }
                     this.logMsg("<b>ATTACK > by</b>: " + armyToMsgString(this.enemyArmies[ind]) + ", " + this.enemyArmies.length + " waves",COLR_ERR_LOG_MSG);
                  }
               }
            }
            if(this.enemyValleyArmies.length > 0)
            {
               if(this.cityTimingAllowed("valleyAttacks",300))
               {
                  this.logMsg("<b>VALLEY ATTACK ></b> " + Map.fieldIdToCoordinate(this.enemyValleyArmies[0].targetFieldId) + " <b>by</b>: " + armyToMsgString(this.enemyValleyArmies[0]) + ", " + this.enemyValleyArmies.length + " waves",COLR_ERR_LOG_MSG);
               }
            }
            if(this.enemyColonyArmies.length > 0)
            {
               if(this.cityTimingAllowed("colonyAttacks",300))
               {
                  this.logMsg("<b>COLONY ATTACK ></b> " + Map.fieldIdToCoordinate(this.enemyColonyArmies[0].targetFieldId) + " <b>by</b>: " + armyToMsgString(this.enemyColonyArmies[0]) + ", " + this.enemyColonyArmies.length + " waves",COLR_ERR_LOG_MSG);
               }
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: handleEnemyArmies, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      public function isTrainingHeroInCity() : Boolean
      {
         return this.trainingHeroName != null && this.isHeroInTown(this.trainingHeroName) != null;
      }
      
      private function _sf809(param1:Number) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ConditionBean = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         if(!this.cityTimingAllowed("zerofoodtraining",120,true))
         {
            return false;
         }
         _loc2_ = this._lf1047();
         if(_loc2_ == null)
         {
            return false;
         }
         _loc3_ = int(_loc2_[0]);
         _loc4_ = int(_loc2_[1]);
         _loc5_ = int(_loc2_[2]);
         _loc6_ = this._mb759(_loc4_);
         if(_loc6_ == null)
         {
            return false;
         }
         _loc7_ = Math.min(this.getEstFoodAmount(param1) / Math.max(0.1,_loc6_.food),this.resource.wood.amount / Math.max(0.1,_loc6_.wood),this.resource.stone.amount / Math.max(0.1,_loc6_.stone),this.resource.iron.amount / Math.max(0.1,_loc6_.iron));
         _loc8_ = Math.min(_loc5_,0.9 * _loc7_);
         if(_loc8_ == 0)
         {
            return false;
         }
         this.promoteBestAtkHero();
         this.setProductionRate(_loc8_ * troopPopulations[_loc4_]);
         this.logMsg("ZEROFOOD > Train " + _loc8_ + " " + troopExtNames[_loc4_],COLR_STD_LOG_MSG);
         CityStateCommands.produceTroop(this.castleId,_loc3_,_loc4_,_loc8_,true,false,this.zeroFoodResponseHandler);
         this.setProductionRate(0);
         this.cityTimingAllowed("zerofoodtraining",0);
         this.lastZeroFoodOp = Utils.getServerTime();
         return true;
      }
      
      public function _setNotFastKeepResoHeroes(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.notFastKeepResoHeroes = _loc2_;
      }
      
      private function getTroopsToAttackValley(param1:int) : TroopBean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:TroopBean = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(param1 == -1)
         {
            return null;
         }
         if(this.valleyTroopBean != null)
         {
            if(isEnoughTroops(this.troop,this.valleyTroopBean))
            {
               return this.valleyTroopBean;
            }
            return null;
         }
         if(param1 < 1 || param1 > 10)
         {
            return null;
         }
         _loc2_ = new Array(0,1,1,1,1,1,1,1,1,2,2);
         if(this.getMaxRallySlots() < _loc2_[param1])
         {
            return null;
         }
         _loc3_ = new Array(0,50,100,200,400,800,1600,3200,6400,12800,19990);
         _loc4_ = new Array(0,0,0,0,1,1,1,1,1,1,1);
         _loc5_ = new TroopBean();
         _loc6_ = new Array(TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_MILITIA,TFConstants.T_PEASANTS,TFConstants.T_BALLISTA);
         for each(_loc7_ in _loc6_)
         {
            if(!(param1 <= 5 && (_loc7_ == TFConstants.T_BALLISTA || _loc7_ == TFConstants.T_PEASANTS)))
            {
               if(this.troop[troopIntNames[_loc7_]] < _loc4_[param1])
               {
                  return null;
               }
               _loc5_[troopIntNames[_loc7_]] = _loc4_[param1];
            }
         }
         if(this.troop.archer < _loc3_[param1])
         {
            return null;
         }
         _loc5_.archer = _loc3_[param1];
         return _loc5_;
      }
      
      public function _setTradePolicy(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = param1.split(" ");
         if(_loc2_.length % 2 != 0)
         {
            this.logMsg("tradepolicy must contain an even number of time markers",COLR_ERR_LOG_MSG);
            return false;
         }
         _loc3_ = this.tradingSchedule != null ? this.tradingSchedule : new Array();
         _loc4_ = null;
         _loc5_ = 0;
         for each(_loc6_ in _loc2_)
         {
            _loc4_ = _loc6_.split(":");
            if(_loc4_.length != 2 || !Utils.hasValue(_loc4_[0]) || !Utils.hasValue(_loc4_[1]))
            {
               this.logMsg("Invalid time marker, " + _loc6_ + " should be in the form hh:mm",COLR_ERR_LOG_MSG);
               return false;
            }
            _loc5_ = int(_loc4_[0]) * 60 + int(_loc4_[1]);
            _loc3_.push(_loc5_);
         }
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc3_.length)
         {
            _loc8_ = _loc9_ + 1;
            while(_loc8_ < _loc3_.length)
            {
               _loc7_ = Math.abs(_loc3_[_loc9_] - _loc3_[_loc8_]);
               if(_loc7_ < 5 || _loc7_ > 60 * 24 - 5)
               {
                  this.logMsg("All time markers must be at least 5 minutes apart",COLR_ERR_LOG_MSG);
                  return false;
               }
               _loc8_++;
            }
            _loc9_++;
         }
         this.tradingSchedule = _loc3_;
         return true;
      }
      
      public function _oh316(param1:int, param2:int, param3:Boolean) : void
      {
         if(this.loyaltyAttackFieldId != -1)
         {
            this.logMsg("Update loyalty attack on " + Map.fieldIdToString(param1));
         }
         else
         {
            this.logMsg("Start loyalty attack on " + Map.fieldIdToString(param1));
         }
         this.loyaltyAttackFieldId = param1;
         this.loyaltyAttackNumCav = param2;
         this.loyaltyAttackOnly = !param3;
         this.loyaltyValue = 100;
      }
      
      public function _populate_S_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:AvailableResearchListBean = null;
         var _loc5_:CityState = null;
         var _loc6_:CityCondition = null;
         var _loc7_:ConditionBean = null;
         if(this.researches == null)
         {
            param1.removeAll();
            return;
         }
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         _loc4_ = null;
         _loc5_ = null;
         for each(_loc4_ in this.researches)
         {
            if(_loc4_.upgradeing)
            {
               _loc3_ = new DataRow();
               _loc3_.col1 = TechType.techExtNames[_loc4_.typeId] + "(" + TechType.techAbrNames[_loc4_.typeId] + ")";
               if(_loc4_.castleId == this.castleId)
               {
                  _loc3_.col2 = "to lvl " + (_loc4_.level + 1) + " in " + Utils.formatEndTime(_loc4_.endTime);
               }
               else
               {
                  _loc3_.col2 = ((_loc5_ = MainScreen.getCityFromCastleId(_loc4_.castleId)) == null ? "[other]" : _loc5_.castle.name) + ": to lvl " + (_loc4_.level + 1) + " in " + Utils.formatEndTime(_loc4_.endTime);
               }
               _loc2_.addItem(_loc3_);
            }
         }
         _loc6_ = this.futureTechCondition();
         _loc7_ = _loc6_ == null ? null : this.getConditionBeanForUpgradingTo(_loc6_);
         if(_loc6_ != null)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = "Next";
            _loc3_.col2 = TechType.techExtNames[_loc6_.typeId] + "(" + TechType.techAbrNames[_loc6_.typeId] + ")" + ", lvl " + _loc6_.level;
            if(_loc7_ != null)
            {
               _loc3_.label = "Need\ngold: " + _loc7_.gold + "\nfood: " + _loc7_.food + "\nwood: " + _loc7_.wood + "\nstone: " + _loc7_.stone + "\niron: " + _loc7_.iron;
            }
            _loc2_.addItem(_loc3_);
         }
         for each(_loc4_ in this.researches)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = TechType.techExtNames[_loc4_.typeId] + " (" + TechType.techAbrNames[_loc4_.typeId] + ")";
            _loc3_.col2 = _loc4_.avalevel + "/" + _loc4_.level;
            if(_loc4_.upgradeing)
            {
               _loc3_.col2 += ", upgrading " + Utils.formatEndTime(_loc4_.endTime);
            }
            _loc2_.addItem(_loc3_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      public function _yy805() : void
      {
         if(this.spamAttackFieldId != -1)
         {
            this.logMsg("Done with spam attack on " + Map.fieldIdToString(this.spamAttackFieldId) + ", please recall army manually if necessary");
            this.spamAttackFieldId = -1;
         }
         else
         {
            this.logMsg("No current spam attack");
         }
      }
      
      public function bestHeroEnergy() : HeroBean
      {
         var _loc2_:HeroBean = null;
         var _loc1_:HeroBean = null;
         for each(_loc2_ in this._ox998())
         {
            if(!(_loc2_.status != CityStateConstants.HERO_STATUS_IDLE || _loc2_.stamina < 4))
            {
               if(_loc1_ == null || _loc1_.stamina < _loc2_.stamina)
               {
                  _loc1_ = _loc2_;
               }
            }
         }
         return _loc1_;
      }
      
      private function _ys266() : void
      {
         var _loc1_:CityState = null;
         for each(_loc1_ in MainScreen.getCities())
         {
            _loc1_.cityManager._on1315();
         }
      }
      
      public function _yi129(param1:int, param2:TroopBean, param3:int, param4:TroopBean, param5:FortificationsBean) : void
      {
         var _loc7_:String = null;
         if(this.guardedAttackFieldId != -1)
         {
            this.logMsg("Please cancel guarded attack on " + Map.fieldIdToString(this.guardedAttackFieldId) + " first");
            return;
         }
         if(this.researches == null)
         {
            this.logMsg("Please try again in a few minutes, unable to obtain research level yet");
            return;
         }
         var _loc6_:Object = param2.toObject();
         for(_loc7_ in _loc6_)
         {
            if(_loc6_[_loc7_] > this.troop[_loc7_])
            {
               this.logMsg("Not enough troop of type: " + _loc7_);
               return;
            }
         }
         if(param2.scouter + param3 > this.troop.scouter)
         {
            this.logMsg("Not enough scouts");
            return;
         }
         if(this.getUsedRallySlots() + 2 > this.getMaxRallySlots())
         {
            this.logMsg("Not enough space in rally spot");
            return;
         }
         if(Math.max(param3,Utils.getTotalTroopCount(param2)) > this.getRallyDispatchPerArmyLimit(true))
         {
            this.logMsg("Too many troops for rally spot level");
            return;
         }
         var _loc8_:HeroBean = this.getIdleHeroByTypePowerNotMayor(this.bestAttackHero(),4);
         if(_loc8_ == null)
         {
            this.logMsg("No hero is available");
            return;
         }
         var _loc9_:NewArmyParam = new NewArmyParam();
         _loc9_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc9_.troops = param2;
         _loc9_.resource = new ResourceBean();
         _loc9_.heroId = _loc8_.id;
         _loc9_.targetPoint = param1;
         var _loc10_:NewArmyParam = new NewArmyParam();
         _loc10_.missionType = ObjConstants.ARMY_MISSION_SCOUT;
         _loc10_.troops = new TroopBean();
         _loc10_.troops.scouter = param3;
         _loc10_.resource = new ResourceBean();
         _loc10_.targetPoint = param1;
         var _loc11_:HeroBean = null;
         if(param3 >= 1000)
         {
            _loc11_ = this.getIdleHeroByTypePowerNotMayor(_loc8_,4);
            if(_loc11_ == null)
            {
               this.logMsg("No hero to lead the scouts");
               return;
            }
            if(_loc11_.status == HeroConstants.HERO_CHIEF_STATU)
            {
               this.removeMayor();
            }
            _loc10_.heroId = _loc11_.id;
         }
         var _loc12_:Number = this.getBaseTravelTime(this.castle.fieldId,_loc9_.targetPoint,_loc9_.troops) / Utils.getHeroSpeedFactor(_loc8_);
         var _loc13_:Number = this.getBaseTravelTime(this.castle.fieldId,_loc10_.targetPoint,_loc10_.troops);
         if(_loc11_ != null)
         {
            _loc13_ /= Utils.getHeroSpeedFactor(_loc11_);
         }
         _loc10_.restTime = _loc12_ - _loc13_ - Utils.rand(25,35);
         if(_loc12_ == 0 || _loc13_ == 0)
         {
            this.logMsg("Abnormal condition, no attack or scout troops?!?");
            return;
         }
         if(_loc10_.restTime < 0)
         {
            this.logMsg("Scout is unable to arrive early");
            return;
         }
         if(!this.isEnoughResourcesToMarch(_loc9_))
         {
            this.logMsg("Not enough resource to send out attack");
            return;
         }
         this.logMsg("Guarded attack on " + Map.fieldIdToString(param1) + " with hero " + _loc8_.name + " in " + Utils.formatTime(_loc12_));
         CityStateCommands.newArmy(this.castleId,_loc9_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc9_);
         if(!this.isEnoughResourcesToMarch(_loc10_))
         {
            this.logMsg("Problem sending out scout mission, please send and guard the attack manually");
            return;
         }
         CityStateCommands.newArmy(this.castleId,_loc10_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc10_);
         this.guardedTroopBean = param4;
         this.guardedFortificationsBean = param5;
         this.guardedAttackFieldId = param1;
      }
      
      public function _isAttackWarningOn() : Boolean
      {
         var _loc1_:int = this.getCfg(CityConfigs.CFG_ATTACKWARNING);
         return _loc1_ == 1 || _loc1_ == 2;
      }
      
      private function handleReloginResponse(param1:LoginResponse) : void
      {
         if(param1.ok != 1)
         {
            return;
         }
         this._resetLocalFieldsInfo();
         if(this.isMainTown())
         {
            Map.fullResetMap();
            if(estimateMaintenanceDownTime != -1 && estimateMaintenanceDownTime < Utils.getServerTime())
            {
               lastMaintenanceDownTime = estimateMaintenanceDownTime;
            }
         }
         this.InitCMValues();
      }
      
      private function _mp684(param1:int, param2:int) : int
      {
         if(this.lastTroopTypeProduced == -1)
         {
            this.lastTroopTypeProduced = TFConstants.T_ARCHER;
         }
         var _loc3_:HeroBean = this.getBestIdleAttackHeroByStaminaIncGear(0);
         var _loc4_:int = this.getTechLevel(TechConstants.TRAIN_SKILL);
         var _loc5_:Number = _loc3_ == null ? 0 : Utils.getMaxStatValueByType(_loc3_,"power");
         var _loc6_:Number = troopTimes[this.lastTroopTypeProduced] * Math.pow(0.9,_loc4_) * Math.pow(HEROFACTOR,_loc5_);
         if(_loc6_ <= 0)
         {
            _loc6_ = 1;
         }
         var _loc7_:ConditionBean = this._mb759(this.lastTroopTypeProduced);
         if(_loc7_ == null)
         {
            return 0;
         }
         var _loc8_:int = 0;
         var _loc9_:BuildingBean = null;
         var _loc10_:AllProduceBean = null;
         var _loc11_:int = 0;
         var _loc12_:BuildingBean = this.getHighestLevelBarrack();
         var _loc13_:int = 0;
         while(_loc13_ < this.buildings.length)
         {
            _loc9_ = this.buildings[_loc13_];
            if(_loc9_.typeId == BuildingConstants.TYPE_BARRACK)
            {
               _loc10_ = this.getBarrackQueueFromBuildingBean(_loc9_);
               if(_loc10_ != null)
               {
                  _loc11_ = param1 == 2 ? _loc10_.allProduceQueueArray.length : int(Math.max(2,_loc10_.allProduceQueueArray.length));
                  if(Math.min(_loc9_.level,param1) > _loc11_)
                  {
                     if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_POPULATION)
                     {
                        this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") >Estimate: build troop on barrack at " + _loc10_.positionId + " from pos " + _loc11_ + " to " + Math.min(_loc9_.level,param1),COLR_DBG_LOG_MSG);
                     }
                     _loc8_ += Math.min(_loc9_.level,param1) - _loc11_;
                  }
               }
            }
            _loc13_++;
         }
         var _loc14_:Number = Math.min(_loc8_ * param2 / _loc6_,this.estResource.gold / (_loc7_.gold + 1),this.estResource.food / (_loc7_.food + 1),this.estResource.wood / (_loc7_.wood + 1),this.estResource.stone / (_loc7_.stone + 1),this.estResource.iron / (_loc7_.iron + 1));
         return _loc14_ * troopPopulations[this.lastTroopTypeProduced];
      }
      
      private function doAutoUseItemHandler(param1:UseItemResultResponse) : void
      {
         var _loc2_:ItemBean = null;
         if(param1.ok != 1)
         {
            this.logErrMsg("Use item error: " + param1.errorMsg);
            return;
         }
         for each(_loc2_ in param1.itemBeansArray)
         {
            this.logMsg("  Got: " + _loc2_.count + " " + Items.getItemName(_loc2_.id));
         }
      }
      
      private function can_trade() : Boolean
      {
         var _loc1_:Date = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc1_ = new Date();
         _loc1_.setTime(Utils.getServerTime());
         _loc2_ = _loc1_.getHours() * 60 + _loc1_.getMinutes();
         _loc3_ = _loc1_.getHours() * 60 + _loc1_.getMinutes();
         if(this.getCfg(CityConfigs.CFG_TRADING) <= 0)
         {
            return false;
         }
         if(this.tradingSchedule == null)
         {
            return true;
         }
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         while(_loc6_ < this.tradingSchedule.length - 1)
         {
            _loc4_ = int(this.tradingSchedule[_loc6_]);
            _loc5_ = int(this.tradingSchedule[_loc6_ + 1]);
            if(_loc4_ < _loc5_ && _loc4_ <= _loc2_ && _loc2_ <= _loc5_)
            {
               return true;
            }
            if(_loc4_ > _loc5_ && (_loc4_ <= _loc2_ || _loc2_ <= _loc5_))
            {
               return true;
            }
            if(_loc4_ < _loc5_ && _loc4_ <= _loc3_ && _loc3_ <= _loc5_)
            {
               return true;
            }
            if(_loc4_ > _loc5_ && (_loc4_ <= _loc3_ || _loc3_ <= _loc5_))
            {
               return true;
            }
            if(_loc2_ < _loc3_ && _loc2_ <= _loc4_ && _loc4_ <= _loc3_)
            {
               return true;
            }
            if(_loc2_ > _loc3_ && (_loc2_ <= _loc4_ || _loc4_ <= _loc3_))
            {
               return true;
            }
            _loc6_ += 2;
         }
         return false;
      }
      
      private function onUpdateWallQueueResponse(param1:ProduceQueueResponse) : void
      {
         if(fortificationProductionUpdateRequested != this.castleId)
         {
            return;
         }
         if(param1.ok != 1)
         {
            this.logErrMsg("get fortification produce queue error: " + param1.errorMsg);
         }
         else
         {
            this.fortificationProduceQueue = param1.allProduceQueueArray;
            fortificationProductionUpdateRequested = 0;
         }
      }
      
      public function _de531(param1:String) : Boolean
      {
         var _loc6_:* = undefined;
         if(this.npc10List == null)
         {
            this.npc10List = new Array();
         }
         var _loc2_:Array = param1.toLowerCase().split(" ");
         var _loc3_:Boolean = true;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         for each(_loc6_ in _loc2_)
         {
            _loc5_ = Map.coordStringToFieldId(_loc6_);
            if(_loc5_ == -1)
            {
               this.logMsg("Invalid location " + _loc6_);
               _loc3_ = false;
            }
            else if(this.npc10List.indexOf(_loc5_) != -1)
            {
               this.logMsg("Repetitive location " + _loc6_);
               _loc3_ = false;
            }
            else
            {
               this.npc10List.push(_loc5_);
               _loc4_ = true;
            }
         }
         if(!_loc4_)
         {
            this.logMsg("No npc added from " + param1);
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      private function _lf742(param1:int, param2:int) : int
      {
         var _loc3_:int = Map.getLevel(param1);
         var _loc4_:int = Map.getLevel(param2);
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         var _loc5_:Number = Map.fieldDistance(param1,this.castle.fieldId);
         var _loc6_:Number = Map.fieldDistance(param2,this.castle.fieldId);
         if(_loc5_ < _loc6_)
         {
            return -1;
         }
         if(_loc5_ > _loc6_)
         {
            return 1;
         }
         return 0;
      }
      
      private function _mh723(param1:String, param2:int) : HeroBean
      {
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         _loc3_ = null;
         for each(_loc4_ in this.heroes)
         {
            if(!(_loc4_.id == param2 || _loc4_.power < 30))
            {
               if(_loc3_ == null || Utils.isWorstHeroByType(param1,_loc4_,_loc3_))
               {
                  _loc3_ = _loc4_;
               }
            }
         }
         return _loc3_;
      }
      
      private function doKeepTroopResoRequestHelp(param1:Boolean, param2:Boolean) : Boolean
      {
         var troopSent:Boolean = false;
         var task:String = null;
         var func:Function = null;
         var hasRallySlot:Boolean = param1;
         var hasHeroSlot:Boolean = param2;
         if(!hasRallySlot)
         {
            return false;
         }
         troopSent = false;
         task = "keeptroop";
         func = function():void
         {
            if(!troopSent && keepTroopFieldIds.length > 0)
            {
               troopSent = doKeepTroop();
            }
         };
         this.doTask(task,func);
         if(this.getCfg(CityConfigs.CFG_NPC) <= 0 || this.localNPCs != null)
         {
            task = "keepresource";
            func = function():void
            {
               if(!troopSent && keepResourceFieldIds.length > 0)
               {
                  troopSent = doKeepResource();
               }
            };
            this.doTask(task,func);
            task = "requesthelp";
            func = function():void
            {
               if(!troopSent)
               {
                  troopSent = doRequestHelp();
               }
            };
            this.doTask(task,func);
         }
         return troopSent;
      }
      
      public function _is281(param1:String) : Boolean
      {
         if(param1 == "spam")
         {
            return this.spamAttackFieldId != -1;
         }
         if(param1 == "loyalty")
         {
            return this.loyaltyAttackFieldId != -1;
         }
         if(param1 == "honor")
         {
            return this.honorAttackFieldId != -1;
         }
         return false;
      }
      
      private function _rn509(param1:Boolean, param2:Boolean) : Boolean
      {
         if(this.getCfg(CityConfigs.CFG_HUNTING) > 0)
         {
            return this._tc1081(param1,param2);
         }
         if(this.getCfg(CityConfigs.CFG_SLOWHUNTING) > 0)
         {
            return this._op598(param1,param2);
         }
         return false;
      }
      
      private function _tr707(param1:Array) : Array
      {
         var _loc2_:HeroBean = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:HeroBean = null;
         _loc2_ = this.isNextTrainingHeroStop() || this.trainingHeroNeeded ? this.getBestIdleTrainingHero() : null;
         _loc3_ = new Array();
         param1 = this.getAvailableHeroNamesFromHeroListStr(param1);
         for each(_loc4_ in param1)
         {
            for each(_loc5_ in this.heroes)
            {
               if(_loc5_ != _loc2_)
               {
                  if(_loc5_.name.toLowerCase() == _loc4_.toLowerCase())
                  {
                     if(_loc5_.status == HeroConstants.HERO_FREE_STATU)
                     {
                        _loc3_.push(_loc5_);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function processRresourceLimits(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         _loc2_ = param1.split(" ");
         if(_loc2_.length != 4)
         {
            this.logMsg("Invalid policy, need 4 pairs of numbers for food/wood/stone/iron resources",COLR_ERR_LOG_MSG);
            return false;
         }
         _loc3_ = new Array();
         _loc4_ = new Array();
         _loc5_ = null;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc5_ = _loc2_[_loc6_].split(",");
            if(_loc5_.length > 2 || !Utils.isNumeric(_loc5_[0]) || !Utils.isNumeric(_loc5_[_loc5_.length - 1]))
            {
               this.logMsg("Invalid pair of numbers in resourcelimits: " + _loc2_[_loc6_],COLR_ERR_LOG_MSG);
               return false;
            }
            if(_loc5_.length != 1)
            {
               _loc3_[_loc6_] = Utils.removeAbbr(_loc5_[0]);
               _loc4_[_loc6_] = Utils.removeAbbr(_loc5_[1]);
            }
            else
            {
               _loc4_[_loc6_] = Utils.removeAbbr(_loc5_[0]);
               _loc3_[_loc6_] = Math.min(2000000,_loc4_[_loc6_]);
            }
            _loc6_++;
         }
         this.resourceMinLimits = _loc3_;
         this.resourceMaxLimits = _loc4_;
         return true;
      }
      
      public function _qk434(param1:int) : void
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.armyId == param1 && _loc2_.direction != ArmyConstants.ARMY_BACKWARD)
            {
               this.logMsg("Recall own troop with  id: " + _loc2_.armyId,COLR_STD_LOG_MSG);
               CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
            }
         }
         for each(_loc2_ in this.friendlyArmies)
         {
            if(_loc2_.armyId == param1)
            {
               this.logMsg("Recall friendly troop with  id: " + _loc2_.armyId,COLR_STD_LOG_MSG);
               CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
            }
         }
      }
      
      public function _cfg_npcHeroes(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.npcHeroes = _loc2_;
      }
      
      private function getNextValleyHero() : HeroBean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:ArrayCollection = null;
         var _loc3_:Boolean = false;
         var _loc4_:HeroBean = null;
         var _loc5_:HeroBean = null;
         if(this.valleyHeroes != null)
         {
            return this._us376(this.valleyHeroes);
         }
         _loc1_ = null;
         _loc2_ = this.getReservedHeroes();
         _loc2_.addItem(this.bestPoliticHero());
         _loc3_ = false;
         for each(_loc4_ in this.heroes)
         {
            if(_loc4_.stamina >= this.getMinEnergyCfg())
            {
               if(_loc4_.status == HeroConstants.HERO_FREE_STATU)
               {
                  if(_loc4_.id != this.lastPromoteId)
                  {
                     _loc3_ = false;
                     for each(_loc5_ in _loc2_)
                     {
                        if(_loc4_ == _loc5_)
                        {
                           _loc3_ = true;
                           break;
                        }
                     }
                     if(!_loc3_)
                     {
                        if(_loc1_ == null || Utils.isWorstHeroByType("power",_loc4_,_loc1_))
                        {
                           _loc1_ = _loc4_;
                        }
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function _de301(param1:XMLList) : TroopBean
      {
         var _loc2_:TroopBean = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:XML = null;
         _loc2_ = new TroopBean();
         _loc3_ = 0;
         _loc4_ = null;
         for each(_loc5_ in param1)
         {
            _loc3_ = int(_loc5_.@typeId);
            _loc4_ = _loc5_.@count;
            if(!Utils.hasValue(_loc4_))
            {
               return null;
            }
            _loc2_[troopIntNames[_loc3_]] = int(_loc4_);
         }
         return _loc2_;
      }
      
      private function hasFreeCitySlot() : Boolean
      {
         return this.player.castlesArray.length < this.player.playerInfo.titleId + 1;
      }
      
      private function recallArmiesToNpc(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:ArmyBean = null;
         _loc2_ = false;
         for each(_loc3_ in this.selfArmies)
         {
            if(_loc3_.startFieldId == this.castle.fieldId)
            {
               if(!(_loc3_.missionType != ObjConstants.ARMY_MISSION_OCCUPY || _loc3_.direction != ArmyConstants.ARMY_FORWARD))
               {
                  if(_loc3_.targetFieldId != this.evasionFieldId)
                  {
                     if(Map.getType(_loc3_.targetFieldId) == FieldConstants.TYPE_NPC)
                     {
                        if(_loc3_.reachTime >= param1)
                        {
                           _loc2_ = true;
                           CityStateCommands.callBackArmy(this.castleId,_loc3_.armyId);
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function doBuilding() : void
      {
         var _loc1_:CityCondition = null;
         var _loc2_:ConditionBean = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:BuildingBean = null;
         if(!this.isBuildingQueueAvailable())
         {
            return;
         }
         _loc1_ = this._ib515();
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = this.getConditionBeanForUpgradingTo(_loc1_);
         if(!this.cityTimingAllowed("building",15))
         {
            return;
         }
         _loc3_ = 0;
         if(_loc1_.level != 0)
         {
            _loc4_ = null;
            if(_loc1_.level != 1)
            {
               _loc3_ = this._gc116(_loc1_.typeId,_loc1_.level - 1);
               if(_loc3_ == -1000)
               {
                  if(this.currRequirements.getItemIndex(_loc1_) != -1)
                  {
                     this.currRequirements.removeItemAt(this.currRequirements.getItemIndex(_loc1_));
                  }
                  this.doBuilding();
                  return;
               }
               this.logMsg("BUILD > upgrade building " + BuildingType.toString(_loc1_.typeId) + " to level " + _loc1_.level + " at location " + _loc3_,COLR_STD_LOG_MSG);
               this.promoteBestPolHero();
               CityStateCommands.upgradeBuilding(this.castle.id,_loc3_,this.onNewBuildingResponse);
               for each(_loc4_ in resourceIntNames)
               {
                  this.estResource[_loc4_] -= _loc2_[_loc4_];
               }
            }
            else
            {
               _loc3_ = this.getNextAvailablePositionForBuildingType(_loc1_.typeId);
               if(_loc3_ == -1000)
               {
                  if(this.currRequirements.getItemIndex(_loc1_) != -1)
                  {
                     this.currRequirements.removeItemAt(this.currRequirements.getItemIndex(_loc1_));
                  }
                  this.doBuilding();
                  return;
               }
               this.logMsg("BUILD > build new building " + BuildingType.toString(_loc1_.typeId) + " at location " + _loc3_,COLR_STD_LOG_MSG);
               this.promoteBestPolHero();
               CityStateCommands.newBuilding(this.castle.id,_loc3_,_loc1_.typeId,this.onNewBuildingResponse);
               for each(_loc4_ in resourceIntNames)
               {
                  this.estResource[_loc4_] -= _loc2_[_loc4_];
               }
            }
         }
         else
         {
            _loc5_ = this._wl158(_loc1_.typeId);
            if(_loc5_ == null)
            {
               if(this.currRequirements.getItemIndex(_loc1_) != -1)
               {
                  this.currRequirements.removeItemAt(this.currRequirements.getItemIndex(_loc1_));
               }
               this.doBuilding();
               return;
            }
            this.logMsg("BUILD > demolish building " + BuildingType.toString(_loc5_.typeId) + ":" + _loc5_.level + " at location " + _loc5_.positionId,COLR_STD_LOG_MSG);
            this.promoteBestPolHero();
            CityStateCommands.destructBuilding(this.castleId,_loc5_.positionId);
         }
      }
      
      private function _ib515() : CityCondition
      {
         var _loc1_:CityCondition = null;
         var _loc2_:int = 0;
         _loc1_ = null;
         _loc2_ = this.currRequirements.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this.currRequirements[_loc2_];
            if(_loc1_.isBuilding)
            {
               if(this._mo519(_loc1_))
               {
                  this.currRequirements.removeItemAt(_loc2_);
               }
               else if(!this._mi60(_loc1_))
               {
                  if(_loc1_.level == 0)
                  {
                     return _loc1_;
                  }
                  if(this._it985(_loc1_))
                  {
                     if(this._dx690(_loc1_))
                     {
                        return _loc1_;
                     }
                  }
               }
            }
            _loc2_--;
         }
         return null;
      }
      
      public function _markAndUnmarkFlatForNpc(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < npcLocations.length)
         {
            if(param1 == npcLocations[_loc3_])
            {
               break;
            }
            _loc3_++;
         }
         if(_loc3_ == npcLocations.length)
         {
            if(param2)
            {
               this.logMsg("Set npc flag on: " + Map.fieldIdToString(param1));
               npcLocations.push(param1);
            }
            else
            {
               this.logMsg("Field npc flag is off and unchanged: " + Map.fieldIdToString(param1));
            }
         }
         else if(param2)
         {
            this.logMsg("Field npc flag is on and unchanged: " + Map.fieldIdToString(param1));
         }
         else
         {
            this.logMsg("Set npc flag off: " + Map.fieldIdToString(param1));
            npcLocations.splice(_loc3_,1);
         }
      }
      
      public function getResearchInProgress() : AvailableResearchListBean
      {
         var _loc1_:AvailableResearchListBean = null;
         if(this.researches == null)
         {
            return null;
         }
         for each(_loc1_ in this.researches)
         {
            if(_loc1_.castleId == this.castleId && _loc1_.upgradeing)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getIdleHeroByTypePowerNotMayor(param1:HeroBean, param2:int = -1) : HeroBean
      {
         return this.getHeroByTypeFreeNotMayor("power",param1,param2);
      }
      
      public function bestIntelHero() : HeroBean
      {
         return this.getBestHeroByType("stratagem");
      }
      
      public function getTradeSchedule() : Array
      {
         return this.tradingSchedule;
      }
      
      private function _ej801() : HeroBean
      {
         var _loc1_:int = 0;
         var _loc2_:HeroBean = null;
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         var _loc5_:HeroBean = null;
         var _loc6_:int = 0;
         var _loc7_:HeroBean = null;
         var _loc8_:HeroBean = null;
         var _loc9_:HeroBean = null;
         var _loc10_:HeroBean = null;
         var _loc11_:HeroBean = null;
         var _loc12_:HeroBean = null;
         var _loc13_:Array = null;
         var _loc14_:HeroBean = null;
         var _loc15_:AvailableResearchListBean = null;
         if(this.npcHeroes != null)
         {
            return this._us376(this.npcHeroes);
         }
         _loc1_ = this.getCfg(CityConfigs.CFG_HERO);
         _loc2_ = this.bestPoliticHero();
         _loc3_ = this.getCfg(CityConfigs.CFG_RESEARCH) > 0 && this.getCfg(CityConfigs.CFG_HERO) % 10 > 0 ? this.bestIntelHero() : null;
         _loc4_ = this.isNextTrainingHeroStop() || this.trainingHeroNeeded ? this.getBestIdleTrainingHero() : null;
         _loc5_ = this.getWorstRegularHero();
         _loc6_ = this.getCfg(CityConfigs.CFG_FASTHERO);
         if(_loc6_ <= 60)
         {
            _loc6_ = 60;
         }
         _loc7_ = null;
         if(_loc1_ / 10 >= 2)
         {
            _loc7_ = this._as658(_loc2_);
            if(_loc7_ != _loc5_ && _loc7_ != null && !Utils.isHeroMaxLvl(_loc7_) && _loc7_.stamina >= this.getMinEnergyCfg() && _loc7_.management >= _loc6_ && _loc7_ != _loc4_ && _loc7_.status == HeroConstants.HERO_FREE_STATU && _loc7_.id != this.lastPromoteId)
            {
               return _loc7_;
            }
         }
         if(_loc1_ % 10 >= 2)
         {
            _loc7_ = this._jw592(_loc3_);
            if(_loc7_ != _loc5_ && _loc7_ != null && !Utils.isHeroMaxLvl(_loc7_) && _loc7_.stamina >= this.getMinEnergyCfg() && _loc7_.stratagem >= _loc6_ && _loc7_ != _loc4_ && _loc7_.status == HeroConstants.HERO_FREE_STATU && _loc7_.id != this.lastPromoteId)
            {
               return _loc7_;
            }
         }
         _loc8_ = this.getIdleHeroByTypePowerNotMayor(this.getMayor(),0);
         _loc9_ = this._rd325();
         _loc10_ = null;
         if(_loc9_ == _loc8_)
         {
            if(_loc9_ != null && (Utils.isHeroMaxLvl(_loc9_) || _loc9_.status == HeroConstants.HERO_FREE_STATU && _loc9_.stamina < this.getMinEnergyCfg()))
            {
               _loc10_ = _loc9_;
            }
            else if(this.enemyArmies.length != 0 || this.getCfg(CityConfigs.CFG_TRAINING) <= 0)
            {
               _loc10_ = _loc9_;
            }
            else
            {
               _loc10_ = this.getIdleHeroByTypePowerNotMayor(_loc9_,0);
               if(_loc10_ == null)
               {
                  return null;
               }
            }
         }
         else
         {
            _loc10_ = _loc8_;
         }
         if(_loc10_ != null && this.isNextTrainingHeroStop() && _loc10_.name.toLowerCase() == this.trainingHeroName.toLowerCase())
         {
            _loc10_ = this.getIdleHeroByTypePowerNotMayor(_loc10_,0);
            if(_loc10_ == null)
            {
               return null;
            }
         }
         _loc11_ = this.getCfg(CityConfigs.CFG_NOMAYOR) != 3 ? (this.getCfg(CityConfigs.CFG_NOMAYOR) != 2 ? (this.getCfg(CityConfigs.CFG_NOMAYOR) > 0 ? null : this.bestPoliticHero()) : this.bestAttackHero()) : this.bestAttackHero();
         _loc12_ = null;
         if(this.getCfg(CityConfigs.CFG_RESEARCH) > 0)
         {
            _loc15_ = this.getResearchInProgress();
            if(_loc15_ == null || _loc15_.endTime < Utils.getServerTime() + 7200 * 1000)
            {
               _loc12_ = this.bestIntelHero();
            }
         }
         if(this.heroes.length <= 2)
         {
            _loc12_ = null;
         }
         if(this.heroes.length <= 3 && _loc12_ != null)
         {
            _loc10_ = null;
         }
         _loc7_ = null;
         _loc13_ = this.notNpcHeroes == null ? null : this.getAvailableHeroNamesFromHeroListStr(this.notNpcHeroes);
         for each(_loc14_ in this.heroes)
         {
            if(!(_loc14_ == _loc2_ || _loc14_ == _loc5_ || _loc14_ == _loc10_ || _loc14_ == _loc11_ || _loc14_ == _loc12_ || _loc14_ == _loc4_ || _loc14_.id == this.lastPromoteId))
            {
               if(!(_loc14_.stamina < this.getMinEnergyCfg() || _loc14_.status != HeroConstants.HERO_FREE_STATU || _loc14_.id == this.lastPromoteId))
               {
                  if(!(_loc13_ != null && _loc13_.indexOf(_loc14_.name.toLowerCase()) != -1))
                  {
                     if(_loc7_ != null && Utils.isHeroMaxLvl(_loc7_) && !Utils.isHeroMaxLvl(_loc14_))
                     {
                        _loc7_ = _loc14_;
                     }
                     else if(_loc7_ == null || Utils.isWorstHeroByType("power",_loc14_,_loc7_))
                     {
                        _loc7_ = _loc14_;
                     }
                  }
               }
            }
         }
         return _loc7_;
      }
      
      private function _ut946() : Boolean
      {
         if(this.troop == null)
         {
            return false;
         }
         return this.isNextTrainingHeroStop() && this.getBestIdleTrainingHero() != null && this.troop.scouter == 0;
      }
      
      public function get maintenanceTime() : Number
      {
         return estimateMaintenanceDownTime > Utils.getServerTime() ? estimateMaintenanceDownTime : -1;
      }
      
      public function cleanUpAndFlushCityTimingList() : void
      {
         var _loc1_:Date = null;
         var _loc2_:String = null;
         _loc1_ = new Date();
         for(_loc2_ in this.cityTimingList)
         {
            if((this.cityTimingList[_loc2_] as Date).getTime() < _loc1_.getTime() - 8 * 60 * 60 * 1000)
            {
               delete this.cityTimingList[_loc2_];
            }
         }
         this.flushCityTimingList(1);
      }
      
      public function _populate_B_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:DataRow = null;
         var _loc7_:BuildingBean = null;
         var _loc8_:CityCondition = null;
         var _loc9_:ConditionBean = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:String = null;
         _loc2_ = new ArrayCollection();
         _loc3_ = new Object();
         _loc4_ = new Object();
         _loc5_ = new Array();
         _loc6_ = null;
         for each(_loc7_ in this.buildings)
         {
            if(_loc7_.status != 0)
            {
               _loc5_.push(_loc7_);
            }
            if(_loc3_[_loc7_.typeId] == undefined)
            {
               _loc3_[_loc7_.typeId] = "" + _loc7_.level;
               _loc4_[_loc7_.typeId] = new Object();
               _loc4_[_loc7_.typeId][_loc7_.level] = 1;
            }
            else
            {
               _loc3_[_loc7_.typeId] += ", " + _loc7_.level;
               if(_loc4_[_loc7_.typeId][_loc7_.level] == undefined)
               {
                  _loc4_[_loc7_.typeId][_loc7_.level] = 1;
               }
               else
               {
                  _loc4_[_loc7_.typeId][_loc7_.level] += 1;
               }
            }
         }
         for each(_loc7_ in _loc5_)
         {
            _loc6_ = new DataRow();
            _loc6_.col1 = BuildingType.buildingExtNames[_loc7_.typeId];
            if(_loc7_.status != BuildingConstants.STATUS_UPGRADING)
            {
               if(_loc7_.status == BuildingConstants.STATUS_DESTRUCTING)
               {
                  _loc6_.col2 = "Demo to lvl " + (_loc7_.level - 1) + " in " + Utils.formatEndTime(_loc7_.endTime) + ", location: " + _loc7_.positionId;
               }
            }
            else
            {
               _loc6_.col2 = "Up to lvl " + (_loc7_.level + 1) + " in " + Utils.formatEndTime(_loc7_.endTime) + ", location: " + _loc7_.positionId;
            }
            _loc2_.addItem(_loc6_);
         }
         _loc8_ = this.futureBuildingCondition();
         _loc9_ = _loc8_ != null ? this.getConditionBeanForUpgradingTo(_loc8_) : null;
         if(_loc8_ != null)
         {
            _loc6_ = new DataRow();
            _loc6_.col1 = "Next";
            _loc6_.col2 = BuildingType.toString(_loc8_.typeId) + ", lvl " + _loc8_.level;
            if(_loc9_ != null)
            {
               _loc6_.label = "Need:\n" + createLabelTextFor_B_Tab(_loc9_);
            }
            _loc2_.addItem(_loc6_);
         }
         _loc10_ = 0;
         for(_loc11_ in _loc3_)
         {
            _loc10_ = int(_loc11_);
            _loc6_ = new DataRow();
            _loc6_.col1 = BuildingType.buildingExtNames[_loc10_] + " (" + BuildingType.buildingAbrNames[_loc10_] + ")";
            _loc6_.col2 = _loc3_[_loc10_];
            _loc6_.label = "";
            if(_loc3_[_loc10_].length >= 4)
            {
               for(_loc14_ in _loc4_[_loc10_])
               {
                  _loc6_.label += _loc4_[_loc10_][_loc14_] + " lvl" + _loc14_ + "\n";
               }
            }
            else
            {
               _loc9_ = this.getConditionBeanForUpgradingTo(new CityCondition(true,_loc10_,int(_loc3_[_loc10_]) + 1));
               if(_loc9_ != null)
               {
                  _loc6_.label = "To upgrade:\n" + createLabelTextFor_B_Tab(_loc9_);
               }
            }
            _loc2_.addItem(_loc6_);
         }
         _loc12_ = this._al1086(true);
         _loc13_ = this._al1086(false);
         if(_loc12_ + _loc13_ > 0)
         {
            _loc6_ = new DataRow();
            _loc6_.col1 = "Free";
            _loc6_.col2 = _loc12_ + " inside spot(s) and " + _loc13_ + " outside spot(s)";
            _loc2_.addItem(_loc6_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function _ya433() : Boolean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:Number = NaN;
         var _loc3_:FortificationsBean = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this.fortificationsRequirement == null || this.getCfg(CityConfigs.CFG_DUMPING) <= 0 || this.getCfg(CityConfigs.CFG_FORTIFICATION) <= 0 || this.fortificationProduceQueue == null || this.fortificationProduceQueue.length == 0)
         {
            return false;
         }
         if(this.isLastEnemyTimeLessThan1Hr() || !this._sf1146() || !this._isEnoughSlotsOnWall())
         {
            return false;
         }
         _loc1_ = this.bestPoliticHero();
         if(_loc1_ == null || _loc1_.status != HeroConstants.HERO_FREE_STATU && _loc1_.status != HeroConstants.HERO_CHIEF_STATU)
         {
            return false;
         }
         if(this._wa163())
         {
            MasterTimer.getInstance().setNextActiveTime();
            return false;
         }
         _loc2_ = _loc1_ == null ? 0 : Utils.getTotalPointsForHeroAttribute(_loc1_,"management");
         if(this.fortificationProduceQueue[0].allProduceQueueArray.length + 1 >= this.getBuildingLevel(BuildingConstants.TYPE_WALL))
         {
            return false;
         }
         _loc3_ = this.getFortificationsInProduction();
         _loc4_ = new Array(TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL,TFConstants.F_ARROWTOWER);
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc8_ = 0;
         for each(_loc9_ in _loc4_)
         {
            _loc6_ = this._ui319(_loc9_,_loc2_);
            _loc7_ = _loc6_ == 0 ? 100000 : int(this.getCfg(CityConfigs.CFG_DUMPING) * 3600 / _loc6_);
            _loc5_ = Math.min(_loc7_,1.3 * (this.fortificationsRequirement[troopIntNames[_loc9_]] - this.fortification[troopIntNames[_loc9_]] - _loc3_[troopIntNames[_loc9_]]));
            if(_loc5_ > 0)
            {
               while(_loc7_ >= _loc5_)
               {
                  if(this._isEnoughResoToProduceFort(_loc9_,_loc7_) && this._isEnoughSlotsOnWall(_loc7_,_loc9_))
                  {
                     _loc8_ = Math.min(_loc7_,1.3 * (this.fortificationsRequirement[troopIntNames[_loc9_]] - this.fortification[troopIntNames[_loc9_]] - _loc3_[troopIntNames[_loc9_]]));
                     if(_loc8_ > 10)
                     {
                        _loc8_ = int(_loc8_ / 10) * 10;
                     }
                     if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
                     {
                        this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Use spare resources for " + _loc8_ + " " + troopExtNames[_loc9_],COLR_DBG_LOG_MSG);
                     }
                     this.promoteBestPolHero();
                     CityStateCommands.produceWallProtect(this.castleId,_loc9_,_loc8_,this._gv1114);
                     return true;
                  }
                  _loc7_ /= 1.3;
               }
            }
         }
         return false;
      }
      
      public function _fe161(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         if(this.npcAvoidList == null)
         {
            this.npcAvoidList = new Array();
         }
         _loc2_ = param1.toLowerCase().split(" ");
         _loc3_ = true;
         _loc4_ = false;
         _loc5_ = 0;
         for each(_loc6_ in _loc2_)
         {
            _loc5_ = Map.coordStringToFieldId(_loc6_);
            if(_loc5_ == -1)
            {
               this.logMsg("Invalid location " + _loc6_,COLR_STD_LOG_MSG);
               _loc3_ = false;
            }
            else if(this.npcAvoidList.indexOf(_loc5_) != -1)
            {
               this.logMsg("Repetitive location " + _loc6_,COLR_STD_LOG_MSG);
               _loc3_ = false;
            }
            else
            {
               this.npcAvoidList.push(_loc5_);
               _loc4_ = true;
            }
         }
         if(!_loc4_)
         {
            this.logMsg("No npc added from " + param1,COLR_STD_LOG_MSG);
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      private function _vi518(param1:String, param2:int, param3:int) : Boolean
      {
         if(!Utils.hasValue(param1))
         {
            return false;
         }
         return Number(param1) >= param2 && Number(param1) <= param3;
      }
      
      private function _ph1097(param1:Boolean, param2:Boolean) : Boolean
      {
         if(!this.isMarketReady())
         {
            return false;
         }
         if(this.getCfg(CityConfigs.CFG_NPCLIMIT) > 0 && this._kn913(this.getCfg(CityConfigs.CFG_NPCLIMIT)))
         {
            if(this.getCfg(CityConfigs.CFG_TRAINING) > 0)
            {
               return this._mf676(true,param1,param2);
            }
            return false;
         }
         return this._mf676(false,param1,param2);
      }
      
      public function _onResourceUpdate() : void
      {
         this.resourceStamp = Utils.getServerTime();
         if(!this.isActive())
         {
            this.doEstimateResource();
         }
      }
      
      private function validateNpcTargets() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyBean = null;
         _loc1_ = 0;
         for each(_loc2_ in this.localArmies)
         {
            if(this.lastNPCTargets[_loc2_.targetFieldId] != undefined && _loc2_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc2_.direction == ArmyConstants.ARMY_FORWARD)
            {
               _loc1_ = Map.getType(_loc2_.targetFieldId,60);
               if(_loc1_ != -1 && _loc1_ != FieldConstants.TYPE_NPC)
               {
                  this.logMsg("Target npc is no longer a npc, recall troop " + _loc2_.armyId + " toward " + Map.fieldIdToString(_loc2_.targetFieldId));
                  this.recallTroopsToTarget(_loc2_.targetFieldId);
                  delete this.lastNPCTargets[_loc2_.targetFieldId];
               }
            }
         }
      }
      
      private function _ek905(param1:int) : Boolean
      {
         if(param1 == this.lastPromoteId)
         {
            return false;
         }
         this.lastPromoteId = param1;
         if(param1 == -1)
         {
            this.lastGear = -1;
         }
         return true;
      }
      
      public function _sendQuickArmy(param1:NewArmyParam, param2:Boolean, param3:Function, param4:Boolean = false) : Boolean
      {
         var _loc5_:HeroBean = null;
         var _loc6_:Number = NaN;
         if(!this.isEnoughResourcesToMarch(param1))
         {
            return false;
         }
         _loc5_ = this._gu1148(param1.heroId);
         _loc6_ = this.getTravelTimeReliefStationAdj(param1) / Utils.getHeroSpeedFactor(_loc5_);
         playerArmyTimingAllowed("attack" + param1.targetPoint,_loc6_,0);
         this.logMsg((param4 ? "ZEROFOOD" : "QFARM") + " > Quick farm " + Map.fieldIdToString(param1.targetPoint) + " using hero " + Utils.heroBeanToString(_loc5_) + " with " + Utils.troopBeanToString(param1.troops) + " arrival in " + Utils.formatTime(_loc6_),param4 ? "#00006A" : "#000000");
         Map.reqMapInfoAndDetail(param1.targetPoint);
         if(param2)
         {
            CityStateCommands.newArmy(this.castleId,param1,param3);
         }
         else
         {
            ActionFactory.getInstance().getArmyCommands().newArmy(this.castleId,param1,param3);
         }
         this.adjEstFoodAfterMarch(param1);
         return true;
      }
      
      public function getBestAttackHeroATK(param1:int = 100, param2:int = 0) : HeroBean
      {
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         var _loc5_:HeroBean = null;
         _loc3_ = null;
         if(this.trainingHeroNeeded)
         {
            _loc3_ = this.getBestIdleTrainingHero();
         }
         _loc4_ = null;
         for each(_loc5_ in this.heroes)
         {
            if(!(_loc5_.power < _loc5_.management || _loc5_.power < _loc5_.stratagem))
            {
               if(!(_loc3_ != null && _loc5_.id == _loc3_.id))
               {
                  if(_loc5_.status == HeroConstants.HERO_FREE_STATU)
                  {
                     if(!(_loc5_.isHero != 0 || _loc5_.level < param1 || _loc5_.loyalty < param2))
                     {
                        if(!(_loc4_ != null && _loc4_.power >= _loc5_.power))
                        {
                           _loc4_ = _loc5_;
                        }
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      private function _wx919() : FortificationsBean
      {
         var _loc1_:FortificationsBean = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:AllProduceBean = null;
         var _loc5_:ProduceBean = null;
         _loc1_ = new FortificationsBean();
         _loc2_ = NaN;
         _loc3_ = NaN;
         for each(_loc4_ in this.fortificationProduceQueue)
         {
            _loc2_ = -1;
            _loc3_ = Utils.getServerTime();
            for each(_loc5_ in _loc4_.allProduceQueueArray)
            {
               if(_loc2_ == -1)
               {
                  _loc2_ = _loc5_.endTime;
               }
               else
               {
                  _loc2_ += _loc5_.costTime * 1000;
               }
               if(_loc2_ >= _loc3_ + 1000)
               {
                  if(_loc5_.num > 1)
                  {
                     break;
                  }
                  _loc1_[troopIntNames[_loc5_.type]] += _loc5_.num;
               }
            }
         }
         return _loc1_;
      }
      
      private function secondRecall(param1:NewArmyParam) : void
      {
         var fieldId:int = 0;
         var arr:ArrayCollection = null;
         var army:ArmyBean = null;
         var newArmy:NewArmyParam = param1;
         try
         {
            fieldId = this.getFieldIdUsedForHiding();
            if(fieldId == -1)
            {
               return;
            }
            if(!Connection.getInstance().authenticated)
            {
               Utils.callLater(10000,this.secondRecall,[newArmy]);
               return;
            }
            arr = this._vq1155(fieldId);
            for each(army in arr)
            {
               if(!(newArmy == null && !this.cityTimingAllowed("recall" + army.armyId,30)))
               {
                  if(army.missionType == ObjConstants.ARMY_MISSION_SEND)
                  {
                     if(!(army.resource.gold != 2 || army.resource.food + army.resource.stone + army.resource.iron + army.resource.wood != 0))
                     {
                        if(newArmy == null || _xv999(newArmy,army))
                        {
                           CityStateCommands.callBackArmy(this.castleId,army.armyId);
                        }
                     }
                  }
               }
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: stopSneakyEvasion, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      public function getBuffIndexFromTypeId(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.player.buffsArray.length)
         {
            if(this.player.buffsArray[_loc2_].typeId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function _setSkypeWarnPolicy(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(!this.isMainTown())
         {
            this.logMsg("*** WARNING: The skypewarningpolicy goal has no effect if the city is not maintown, ignoring the goal ***",COLR_WRN_LOG_MSG);
            return true;
         }
         if(param1.length > 4)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(isNaN(Number(_loc2_)))
            {
               this.logMsg("*** WARNING: The skypewarningpolicy goal has encountered an invalid type at " + _loc2_ + "  valid options are <b>0</b> (off) or <b>1</b> (on)***",COLR_WRN_LOG_MSG);
               return false;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            this.skypeWarningPolicy[_loc3_] = int(param1[_loc3_]) > 0;
            _loc3_++;
         }
         return true;
      }
      
      private function doTask(param1:String, param2:Function) : void
      {
         var task:String = param1;
         var func:Function = param2;
         try
         {
            func.apply();
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while working on task " + task + ": " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      private function getFortificationsInProduction() : FortificationsBean
      {
         var _loc1_:FortificationsBean = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:AllProduceBean = null;
         var _loc5_:ProduceBean = null;
         _loc1_ = new FortificationsBean();
         _loc2_ = NaN;
         _loc3_ = NaN;
         for each(_loc4_ in this.fortificationProduceQueue)
         {
            _loc2_ = -1;
            _loc3_ = Utils.getServerTime();
            for each(_loc5_ in _loc4_.allProduceQueueArray)
            {
               if(_loc2_ == -1)
               {
                  _loc2_ = _loc5_.endTime;
               }
               else
               {
                  _loc2_ += _loc5_.costTime * 1000;
               }
               if(_loc2_ >= _loc3_ + 1000)
               {
                  _loc1_[troopIntNames[_loc5_.type]] += _loc5_.num;
               }
            }
         }
         return _loc1_;
      }
      
      public function _setEmbPlayersLists(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         _loc2_ = param1.replace(/_/g," ").toLowerCase().split(",");
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.charAt(0) == "!")
            {
               this.embDeniedPlayers.push(_loc3_.substr(1).toLowerCase());
            }
            else
            {
               this.embAllowedPlayers.push(_loc3_.toLowerCase());
            }
         }
      }
      
      public function _pj342(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         _loc2_ = param1.split(",");
         if(_loc2_.length != 5)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            this.NPCBALLISTAS[_loc3_ + 1] = _loc2_[_loc3_];
            _loc3_++;
         }
         return true;
      }
      
      public function _scrFieldAttack(param1:String, param2:int, param3:Number, param4:int) : void
      {
         this.fieldTargetEnemyAlliances = param1.split(",");
         this.fieldTargetCenter = param2;
         this.fieldTargetRadius = param3;
         this.fieldTargetMinLevel = param4;
         this.logMsg("Attack fields of alliances " + param1 + " within " + param3 + " miles of " + Map.fieldIdToCoordString(param2));
      }
      
      public function _getSkypeWarningReceivers() : Array
      {
         return this.skypeWarningReceiverList;
      }
      
      public function _rv270(param1:ResearchResponse) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(param1.ok != 1)
         {
            this.logMsg("research response error: " + param1.errorMsg);
            return;
         }
         _loc2_ = true;
         _loc3_ = 0;
         while(_loc3_ < this.researches.length)
         {
            if(param1.tech.typeId == this.researches[_loc3_].typeId)
            {
               this.researches[_loc3_] = param1.tech;
               _loc2_ = false;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            this.researches.addItem(param1.tech);
         }
      }
      
      public function getBuff(param1:String) : BuffBean
      {
         var _loc2_:BuffBean = null;
         for each(_loc2_ in this.player.buffsArray)
         {
            if(!(_loc2_ == null || _loc2_.endTime < Utils.getServerTime() || _loc2_.typeId != param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function _dp32(param1:String) : Boolean
      {
         var _loc2_:TroopBean = null;
         _loc2_ = Utils.getTroops(param1);
         if(_loc2_ == null)
         {
            this.logMsg("Invalid npc10limit troop: " + param1,COLR_STD_LOG_MSG);
            return false;
         }
         this.npc10LimitTroopBean = _loc2_;
         return true;
      }
      
      private function doZeroFood() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:ArrayCollection = null;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         _loc1_ = this.resourceStamp > this.lastZeroFoodOp ? 2 : 30;
         if(!this.cityTimingAllowed("handleZeroFood",_loc1_))
         {
            return;
         }
         if(!this.cityTimingAllowed("handleZeroFoodOnError",7 * this.zeroFoodErrorFactor))
         {
            return;
         }
         if(this.zeroFoodErrorFactor == 0.1)
         {
            this.zeroFoodErrorFactor = 1;
         }
         if(this.lastZeroFoodError > 0)
         {
            this.lastZeroFoodError = 0;
            this.zeroFoodErrorFactor *= 1.3;
         }
         else
         {
            this.zeroFoodErrorFactor = Math.max(1,this.zeroFoodErrorFactor - 0.3);
         }
         if(this.setFoodHideLoc())
         {
            return;
         }
         if(this.foodHideLoc == -1 && this.cityTimingAllowed("nofoodhideloc",900))
         {
            this.logMsg("ZEROFOOD > No valley for hiding food",COLR_ERR_LOG_MSG);
         }
         if(this.allTroop.carriage < 5000)
         {
            if(this.isZeroFoodActive)
            {
               this.isZeroFoodActive = false;
            }
            if(this.cityTimingAllowed("suspendZeroFood",900))
            {
               this.logMsg("ZEROFOOD > Only " + this.allTroop.carriage + " transporters in this city. Minimum of 5000 required. Food hiding is paused.",COLR_STD_LOG_MSG);
            }
            return;
         }
         _loc2_ = this.localNPCs != null && this.localNPC10s != null;
         if(!_loc2_ && this.cityTimingAllowed("zerofoodsearchnpc",60))
         {
            this.taskSearchLocalNPCs();
         }
         _loc3_ = this.getZeroFoodArmies();
         _loc4_ = _loc3_.length >= 1 && _loc3_[0].direction == ArmyConstants.ARMY_STAY;
         if(this.zeroFoodErrorFactor == 1 && _loc3_.length >= 1 && (_loc4_ || this.cityTimingAllowed("recallfood",1000 + 200 * Math.random())))
         {
            if(!_loc4_ && Utils.getServerTime() - this.player.playerInfo.lastLoginTime < 5 * 60 * 1000)
            {
               return;
            }
            if(this.recallZeroFoodArmies())
            {
               return;
            }
         }
         _loc5_ = this.getEstFoodAmount(this.zeroFoodErrorFactor);
         _loc6_ = this.resource.troopCostFood - Math.min(0,this.resource.supplyFood);
         if(_loc5_ >= Math.max(1,this.getCfg(CityConfigs.CFG_ZEROFOOD)) * _loc6_)
         {
            if(this.isZeroFoodActive)
            {
               this.isZeroFoodActive = false;
            }
            if(this.cityTimingAllowed("suspendZeroFood",900))
            {
               this.logMsg("ZEROFOOD > Enough food for more than " + this.getCfg(CityConfigs.CFG_ZEROFOOD) + " hours. Food hiding is paused.",COLR_STD_LOG_MSG);
            }
            return;
         }
         if(!this.isZeroFoodActive)
         {
            this.isZeroFoodActive = true;
         }
         if(_loc5_ > 0)
         {
            _loc7_ = this.getArmyMovementRestriction();
            if(!MasterTimer.getInstance().canSend(this.timeSlot))
            {
               this.doEstimateResource();
            }
            if(_loc7_ == 0 && this.getCfg(CityConfigs.CFG_VALLEY) > 0 && this.fields.length == 0)
            {
               this.tskAttackResourceField(true,true);
            }
            if(_loc2_ && this._jg190(_loc7_,this.zeroFoodErrorFactor))
            {
               return;
            }
            if(_loc7_ != 2 && this.newZeroFoodArmy(this.zeroFoodErrorFactor))
            {
               return;
            }
            if(_loc2_ && this._xk442(this.zeroFoodErrorFactor))
            {
               return;
            }
         }
         else if(_loc3_.length == 0)
         {
            if(_loc2_)
            {
               this._yq108();
            }
         }
      }
      
      public function _getCurrentConstruction() : BuildingBean
      {
         var _loc1_:BuildingBean = null;
         for each(_loc1_ in this.buildings)
         {
            if(_loc1_.status != 0)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function getHighestLevelBarrack() : BuildingBean
      {
         var _loc1_:int = 0;
         var _loc2_:BuildingBean = null;
         _loc1_ = this.getBuildingLevel(BuildingConstants.TYPE_BARRACK);
         for each(_loc2_ in this.buildings)
         {
            if(_loc2_.typeId == BuildingConstants.TYPE_BARRACK && _loc2_.level >= _loc1_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function _qn996(param1:Number, param2:int, param3:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:TradeBean = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         _loc4_ = 0;
         for each(_loc5_ in this.tradesArray)
         {
            if(_loc5_.resType == param2)
            {
               if(_loc5_.tradeType == TradeConstants.TRADE_TYPE_SELL)
               {
                  this._ps903(_loc5_,param1,param3);
                  return false;
               }
               if(!this.cityTimingAllowed("modify",60))
               {
                  return false;
               }
               _loc4_ = _loc5_.amount - _loc5_.dealedAmount;
               this.logMsg("TRADE > Cancel buy due to sell demand " + resourceNames[_loc5_.resType] + ": " + _loc4_ + "@" + _loc5_.price + ", range: " + this.getHighestBidOffer(_loc5_.resType) + "-" + this._hf650(_loc5_.resType),COLR_STD_LOG_MSG);
               CityStateCommands.cancelTrade(this.castleId,_loc5_.id,this._og999);
               this.estResource.gold += _loc4_ * _loc5_.price;
               return false;
            }
         }
         if(param1 != MAXTRADESIZE)
         {
            param1 = Utils.roundAmount(param1);
         }
         if(param1 <= 10)
         {
            return false;
         }
         if(this.tradesArray.length >= this.getBuildingLevel(BuildingConstants.TYPE_MARKET))
         {
            return false;
         }
         _loc6_ = Math.random() * 0.1 + 0.1;
         _loc7_ = this.getHighestBidOffer(param2) * _loc6_ + this._hf650(param2) * (1 - _loc6_);
         if(param3)
         {
            _loc7_ = this.getHighestBidOffer(param2) * 0.8;
         }
         else if(Math.abs(_loc7_ / this.getHighestBidOffer(param2) - 1) < 0.03)
         {
            _loc7_ = this.getHighestBidOffer(param2);
         }
         _loc7_ = this.getTrimmedMarketPrice(_loc7_);
         if(param1 > MAXTRADESIZE)
         {
            param1 = MAXTRADESIZE;
         }
         if(this.estResource.gold < _loc7_ * param1 * 0.005)
         {
            return false;
         }
         if(this.estResource[resourceIntNames[param2]] < param1)
         {
            return false;
         }
         this.logMsg("TRADE > Sell " + resourceNames[param2] + ": " + param1 + " at " + _loc7_ + ", range: " + this.getHighestBidOffer(param2) + "-" + this._hf650(param2),COLR_STD_LOG_MSG);
         CityStateCommands.newTrade(this.castleId,param2,TradeConstants.TRADE_TYPE_SELL,param1,"" + _loc7_,this._ry570);
         this.estResource[resourceIntNames[param2]] -= param1;
         this.estResource.gold -= 0.005 * _loc7_ * param1;
         return true;
      }
      
      public function isActive() : Boolean
      {
         return MasterTimer.getInstance().canSend(this.timeSlot);
      }
      
      private function getAllTroopsInQueues() : TroopBean
      {
         var _loc1_:TroopBean = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:ProduceBean = null;
         var _loc5_:AllProduceBean = null;
         _loc1_ = new TroopBean();
         _loc2_ = Utils.getServerTime();
         _loc3_ = NaN;
         _loc4_ = null;
         for each(_loc5_ in this.troopProduceQueue)
         {
            _loc3_ = -1;
            for each(_loc4_ in _loc5_.allProduceQueueArray)
            {
               if(_loc3_ == -1)
               {
                  _loc3_ = _loc4_.endTime;
               }
               else
               {
                  _loc3_ += _loc4_.costTime * 1000;
               }
               if(_loc3_ >= _loc2_ + 1000)
               {
                  _loc1_[troopIntNames[_loc4_.type]] += _loc4_.num;
               }
            }
         }
         return _loc1_;
      }
      
      private function _co450(param1:XMLList, param2:TroopBean) : Boolean
      {
         var _loc3_:TroopBean = null;
         var _loc4_:Object = null;
         var _loc5_:* = undefined;
         _loc3_ = this._de301(param1);
         if(_loc3_ == null)
         {
            return true;
         }
         _loc4_ = param2.toObject();
         for(_loc5_ in _loc4_)
         {
            if(param2[_loc5_] != 0)
            {
               if(param2[_loc5_] > 0 && _loc3_[_loc5_] >= param2[_loc5_])
               {
                  return true;
               }
               if(param2[_loc5_] < 0 && _loc3_[_loc5_] <= -param2[_loc5_])
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function _populate_R_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:EstimateResource = null;
         var _loc4_:ResourceBean = null;
         var _loc5_:DataRow = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc2_ = new ArrayCollection();
         _loc3_ = this._as350();
         _loc4_ = this.getIncommingResources();
         _loc5_ = new DataRow();
         _loc5_.col1 = "Gold (g)";
         _loc5_.col2 = Utils.abbrNum(this.resource.gold);
         _loc5_.col3 = Utils.abbrNum(this.resource.taxIncome - this.resource.herosSalary);
         _loc5_.label = "Tax collected: " + Utils.abbrNum(this.resource.taxIncome) + "\nHero salary: " + Utils.abbrNum(this.resource.herosSalary) + "\nColony tributes: " + Utils.abbrNum(this.resource.colonyGold) + "\nNet: " + Utils.abbrNum(this.resource.taxIncome - this.resource.herosSalary);
         if(this.resource.taxIncome - this.resource.herosSalary < 0)
         {
            _loc7_ = -this.resource.gold / (this.resource.taxIncome - this.resource.herosSalary) * 3600;
            _loc5_.col4 = Utils.formatTime(_loc7_);
            _loc5_.label += "\n\nRun out of gold in " + _loc5_.col4;
            if(_loc7_ < 24 * 3600)
            {
               _loc5_.bgColor = 16764108;
            }
         }
         else
         {
            _loc5_.col4 = "";
         }
         _loc5_.col5 = Utils.abbrNum(_loc4_.gold);
         _loc5_.col6 = Utils.abbrNum(_loc3_.gold);
         _loc2_.addItem(_loc5_);
         _loc6_ = Math.max(this.getTroopFoodValue(this.getAllTroopsInCastle()),this.resource.troopCostFood);
         _loc5_ = new DataRow();
         _loc5_.col1 = "Food (f)";
         _loc5_.col2 = Utils.abbrNum(this.getEstFoodAmount(1));
         _loc5_.col3 = Utils.abbrNum(this.resource.food.increaseRate - this.resource.troopCostFood);
         _loc5_.label = "Rate: " + Utils.abbrNum(this.resource.food.increaseRate) + "\nTroop food cost: " + Utils.abbrNum(this.resource.troopCostFood) + "/" + Utils.abbrNum(_loc6_) + "\nSupply food: " + Utils.abbrNum(this.resource.supplyFood) + "\nColony tributes: " + Utils.abbrNum(this.resource.colonyFood) + "\nNet: " + Utils.abbrNum(this.resource.food.increaseRate - this.resource.troopCostFood) + "/" + Utils.abbrNum(this.resource.food.increaseRate - _loc6_) + "\nMax storage: " + Utils.formatNum(this.resource.food.max) + "\nAsk: " + Utils.formatNum(this._ha550(TradeConstants.RES_TYPE_FOOD)) + "@" + this._hf650(TradeConstants.RES_TYPE_FOOD) + "\nBid: " + Utils.formatNum(this.getHighestBidAmount(TradeConstants.RES_TYPE_FOOD)) + "@" + this.getHighestBidOffer(TradeConstants.RES_TYPE_FOOD) + "\nComfort food cost: " + Utils.abbrNum(this.getFoodAmountRequiredForComfort());
         if(this.resource.food.increaseRate - _loc6_ + this.resource.supplyFood < 0)
         {
            _loc8_ = -this.getEstFoodAmount(1) / (this.resource.food.increaseRate - _loc6_ + this.resource.supplyFood) * 3600;
            _loc5_.col4 = Utils.formatTime(_loc8_);
            _loc5_.label += "\n\nRun out of food in " + _loc5_.col4;
            if(_loc8_ < 24 * 3600 * (1 + this.getCfg(CityConfigs.CFG_EXTRAFOOD)))
            {
               _loc5_.bgColor = 16764108;
               _loc5_.label += "\nReserved food requested: " + (1 + this.getCfg(CityConfigs.CFG_EXTRAFOOD)) + " day";
            }
         }
         else
         {
            _loc5_.col4 = "";
         }
         _loc5_.col5 = Utils.abbrNum(_loc4_.food);
         _loc5_.col6 = Utils.abbrNum(_loc3_.food);
         _loc2_.addItem(_loc5_);
         _loc5_ = new DataRow();
         _loc5_.col1 = "Lumber (w)";
         _loc5_.col2 = Utils.abbrNum(this.resource.wood.amount);
         _loc5_.col3 = Utils.abbrNum(this.resource.wood.increaseRate);
         _loc5_.col4 = "";
         _loc5_.label = "Max storage: " + Utils.formatNum(this.resource.wood.max) + "\nColony tributes: " + Utils.abbrNum(this.resource.colonyWood) + "\nAsk: " + Utils.formatNum(this._ha550(TradeConstants.RES_TYPE_WOOD)) + "@" + this._hf650(TradeConstants.RES_TYPE_WOOD) + "\nBid: " + Utils.formatNum(this.getHighestBidAmount(TradeConstants.RES_TYPE_WOOD)) + "@" + this.getHighestBidOffer(TradeConstants.RES_TYPE_WOOD);
         _loc5_.col5 = Utils.abbrNum(_loc4_.wood);
         _loc5_.col6 = Utils.abbrNum(_loc3_.wood);
         _loc2_.addItem(_loc5_);
         _loc5_ = new DataRow();
         _loc5_.col1 = "Stone (s)";
         _loc5_.col2 = Utils.abbrNum(this.resource.stone.amount);
         _loc5_.col3 = Utils.abbrNum(this.resource.stone.increaseRate);
         _loc5_.col4 = "";
         _loc5_.label = "Max storage: " + Utils.formatNum(this.resource.stone.max) + "\nColony tributes: " + Utils.abbrNum(this.resource.colonyStone) + "\nAsk: " + Utils.formatNum(this._ha550(TradeConstants.RES_TYPE_STONE)) + "@" + this._hf650(TradeConstants.RES_TYPE_STONE) + "\nBid: " + Utils.formatNum(this.getHighestBidAmount(TradeConstants.RES_TYPE_STONE)) + "@" + this.getHighestBidOffer(TradeConstants.RES_TYPE_STONE);
         _loc5_.col5 = Utils.abbrNum(_loc4_.stone);
         _loc5_.col6 = Utils.abbrNum(_loc3_.stone);
         _loc2_.addItem(_loc5_);
         _loc5_ = new DataRow();
         _loc5_.col1 = "Iron (i)";
         _loc5_.col2 = Utils.abbrNum(this.resource.iron.amount);
         _loc5_.col3 = Utils.abbrNum(this.resource.iron.increaseRate);
         _loc5_.col4 = "";
         _loc5_.label = "Max storage: " + Utils.formatNum(this.resource.iron.max) + "\nColony tributes: " + Utils.abbrNum(this.resource.colonyIron) + "\nAsk: " + Utils.formatNum(this._ha550(TradeConstants.RES_TYPE_IRON)) + "@" + this._hf650(TradeConstants.RES_TYPE_IRON) + "\nBid: " + Utils.formatNum(this.getHighestBidAmount(TradeConstants.RES_TYPE_IRON)) + "@" + this.getHighestBidOffer(TradeConstants.RES_TYPE_IRON);
         _loc5_.col5 = Utils.abbrNum(_loc4_.iron);
         _loc5_.col6 = Utils.abbrNum(_loc3_.iron);
         _loc2_.addItem(_loc5_);
         _loc5_ = new DataRow();
         _loc5_.col1 = "Population";
         _loc5_.col2 = Utils.formatNum(this.resource.curPopulation);
         _loc5_.col3 = "";
         _loc5_.col4 = "";
         _loc5_.col5 = "";
         _loc5_.label = "Max population: " + Utils.formatNum(this.resource.maxPopulation) + "\nWorkers: " + Utils.formatNum(this.resource.workPeople) + "\nIdle: " + Utils.formatNum(this.resource.curPopulation - this.resource.workPeople);
         _loc5_.col6 = Utils.abbrNum(_loc3_.curPopulation);
         _loc2_.addItem(_loc5_);
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function processMarketHiding(param1:Number) : void
      {
         var totalTradeValue:Number = NaN;
         var transTrade:TransingTradeBean = null;
         var trade:TradeBean = null;
         var resType:int = 0;
         var i:int = 0;
         var price:Number = NaN;
         var amount:Number = NaN;
         var money:Number = param1;
         try
         {
            if(this.getCfg(CityConfigs.CFG_TRADING) <= 0 || this.getCfg(CityConfigs.CFG_MARKETHIDING) <= 0)
            {
               return;
            }
            if(this.tradesArray.length >= this.getBuildingLevel(BuildingConstants.TYPE_MARKET))
            {
               return;
            }
            totalTradeValue = 0;
            for each(transTrade in this.transingTradesArray)
            {
               totalTradeValue += transTrade.amount * transTrade.price;
            }
            for each(trade in this.tradesArray)
            {
               if(trade.tradeType == TradeConstants.TRADE_TYPE_BUY)
               {
                  totalTradeValue += (trade.amount - trade.dealedAmount) * trade.price;
               }
            }
            if(money < totalTradeValue * 0.0001)
            {
               if(this.cityTimingAllowed("toolittlegold",300))
               {
                  this.logMsg("Too little gold left, no attempt to hide gold in market","#CC8822");
               }
               return;
            }
            resType = TradeConstants.RES_TYPE_FOOD;
            i = 0;
            while(i < 4)
            {
               if(market_internal[i] > market_internal[resType])
               {
                  resType = i;
               }
               i++;
            }
            price = this.getTrimmedMarketPrice(this._hf650(resType) * Utils.rand(13,15) / 10);
            if(price <= 0)
            {
               price = 0.001;
            }
            amount = money / price;
            amount = Utils.roundAmount(amount,2);
            if(amount > 10 * MAXTRADESIZE)
            {
               if(this.cityTimingAllowed("toomuchgold",300))
               {
                  this.logMsg("Too much gold in town, no attempt to hide gold in market","#CC8822");
               }
               return;
            }
            if(amount > MAXTRADESIZE)
            {
               amount = MAXTRADESIZE;
            }
            if(this.estResource.gold < price * amount * 1.005)
            {
               return;
            }
            if(!this.cityTimingAllowed("hidegold",2))
            {
               return;
            }
            this.logMsg("Obtain " + resourceNames[resType] + ": " + amount + " at " + price + ", range: " + this.getHighestBidOffer(resType) + "-" + this._hf650(resType),"#CC8822");
            CityStateCommands.newTrade(this.castleId,resType,TradeConstants.TRADE_TYPE_BUY,amount,"" + price,this._ry570);
            this.estResource.gold -= amount * price * 1.005;
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: doSpend, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      private function get rallyHuntingSetting() : int
      {
         return this.rallySettings[RALLY_HUNTING];
      }
      
      private function _ty399() : Boolean
      {
         var _loc1_:MapCastleBean = null;
         if(!underBPFlag)
         {
            return false;
         }
         _loc1_ = Map.getDetail(this.castle.fieldId);
         if(_loc1_ != null && _loc1_.state != 3)
         {
            underBPFlag = false;
         }
         if((Utils.getServerTime() - this.player.playerInfo.createrTime) / 1000 > 7.5 * 24 * 3600 || this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_TOWN_HALL,5) >= 1)
         {
            underBPFlag = false;
         }
         return underBPFlag;
      }
      
      private function isGearAvailable() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.gears.length)
         {
            if(this.gears[_loc1_].avalevel > 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      private function _yw212(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:ArmyBean = null;
         _loc2_ = 0;
         for each(_loc3_ in this.selfArmies)
         {
            if(_loc3_.startFieldId == this.castle.fieldId)
            {
               if(_loc3_.missionType == ObjConstants.ARMY_MISSION_SCOUT && _loc3_.targetFieldId == param1 && _loc3_.direction == ArmyConstants.ARMY_FORWARD)
               {
                  _loc2_++;
               }
            }
         }
         return _loc2_;
      }
      
      public function bestIdleIntelHero(param1:int = -1) : HeroBean
      {
         return this.getBestIdleHeroByTypeAndStamina("stratagem",param1);
      }
      
      private function doBuildNewCity(param1:int, param2:Boolean = false) : Boolean
      {
         var _loc3_:NewArmyParam = null;
         if(this.troop.peasants < 250)
         {
            return false;
         }
         _loc3_ = new NewArmyParam();
         _loc3_.troops = new TroopBean();
         _loc3_.troops.peasants = 250;
         _loc3_.resource = new ResourceBean();
         _loc3_.resource.gold = 10000;
         _loc3_.resource.food = 10000;
         _loc3_.resource.wood = 10000;
         _loc3_.resource.stone = 10000;
         _loc3_.resource.iron = 10000;
         _loc3_.targetPoint = param1;
         _loc3_.backAfterConstruct = true;
         _loc3_.missionType = ObjConstants.ARMY_MISSION_CONSTRUCT;
         if(!this.isEnoughResourcesToMarch(_loc3_))
         {
            return false;
         }
         this.logMsg("Building new city " + (param2 ? "for NPC " : "") + "at " + Map.fieldIdToString(param1),COLR_STD_LOG_MSG);
         CityStateCommands.newArmy(this.castleId,_loc3_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc3_);
         Map.updateDetailInfo(param1);
         return true;
      }
      
      private function doAbandonCastle(param1:CastleBean) : void
      {
         if(!playerTimingAllowed("abandon" + param1.id,1000))
         {
            return;
         }
         this.logMsg("Abandon castle at " + Map.fieldIdToString(param1.fieldId),COLR_STD_LOG_MSG);
         CityStateCommands.giveupCastle(LoginHelper.getInstance().getHashedEvonyPw(),param1.id);
         if(Map.getLevel(param1.fieldId) == 10)
         {
            if(this.localNPC10s != null)
            {
               this.localNPC10s.push(param1.fieldId);
               this.localNPC10s.sort(this.sortByLevelAndDistance);
            }
         }
         else if(this.localNPCs != null)
         {
            this.localNPCs.push(param1.fieldId);
            this.localNPCs.sort(this.sortByLevelAndDistance);
         }
         Map.updateDetailInfo(param1.fieldId);
         Map.updateInfo(param1.fieldId);
         playerTimingAllowed("npcbuilding" + param1.fieldId,24 * 3600);
         this.recallTroopsToTarget(param1.fieldId);
      }
      
      private function _eu607() : Boolean
      {
         var newDate:Date = null;
         var mustOpen:Boolean = false;
         var window:int = 0;
         var evasionEndTime:Number = NaN;
         var evasionDuration:Number = NaN;
         var maxWaves:int = 0;
         var arr:ArrayCollection = null;
         var numWaves:int = 0;
         var other:ArmyBean = null;
         var totalTroop:TroopBean = null;
         var newArmy:NewArmyParam = null;
         var otherBallista:int = 0;
         var criticalBalista:int = 0;
         var maxTroop:int = 0;
         var avoidedHero:HeroBean = null;
         var hero:HeroBean = null;
         var foodConsume:Number = NaN;
         var maxLoad:Number = NaN;
         var goldReserved:Number = NaN;
         var gold:Number = NaN;
         var food:Number = NaN;
         var totalResources:Number = NaN;
         var factor:Number = NaN;
         var stoneReserved:int = 0;
         var extra:Number = NaN;
         var handler:Function = null;
         try
         {
            if(this.enemyArmies.length == 0)
            {
               return false;
            }
            if(this.evasionFieldId == -1)
            {
               return false;
            }
            this.recallStaleEvasionArmies();
            newDate = new Date();
            if(this.lastBattleAfterAdvMoveErrorTime != null && this.lastBattleAfterAdvMoveErrorTime.getTime() + 3600 * 1000 > newDate.getTime())
            {
               return false;
            }
            if(this.isCanCounterAmbush())
            {
               this.doAutoUseAdvByAHiddenPath(true);
               if(this.doSpecialMarketHiding())
               {
                  return false;
               }
               return false;
            }
            mustOpen = this.getLocalBuffByWildCardId("ForceopenclosegateBuff") != null;
            window = Connection.getInstance().paused ? 15 : 3;
            if(this.goOutForBattle && Utils.getTroopBeanFromTroopStrBean(this.enemyArmies[0].troop) != null && this.troop.archer >= 3 * this._uh177(this.enemyArmies[0].reachTime + window * 60 * 1000) && (this.enemyArmies.length < 2 || this.enemyArmies[1].reachTime - this.enemyArmies[0].reachTime > 1000 * Math.max(8,this.getCfg(CityConfigs.CFG_ATTACKGAP))))
            {
               if(!mustOpen)
               {
                  return false;
               }
            }
            evasionEndTime = this._yb134(this.getCfg(CityConfigs.CFG_ATTACKGAP));
            if(evasionEndTime == 0)
            {
               return false;
            }
            evasionDuration = (evasionEndTime - Utils.getServerTime()) / 1000 + 5;
            if(mustOpen)
            {
               evasionDuration += 35 * 60;
            }
            if(Connection.getInstance().paused)
            {
               evasionDuration += 35 * 60;
            }
            maxWaves = this.rallySettings[RALLY_HIDING] == -1 ? 1 : int(this.rallySettings[RALLY_HIDING]);
            arr = this.getLocalHidingArmies(this.evasionFieldId);
            numWaves = arr.length;
            for each(other in arr)
            {
               if(int(other.troop.carriage) < this.troop.carriage)
               {
                  numWaves--;
                  break;
               }
            }
            if(numWaves < maxWaves && this.getLocalArmiesCount() >= this.getMaxRallySlots())
            {
               if(this.cityTimingAllowed("rallyspotevasionproblem",300))
               {
                  this.logMsg("HIDING > UNABLE TO HIDE BECAUSE RALLYSPOT IS FULL!!",COLR_ERR_LOG_MSG);
               }
               return false;
            }
            if(numWaves >= 1)
            {
               if(this.doSpecialMarketHiding())
               {
                  return false;
               }
            }
            totalTroop = this.getAllTroopsInCastle();
            newArmy = new NewArmyParam();
            newArmy.troops = new TroopBean();
            if(this.troop.carriage >= 1)
            {
               newArmy.troops.carriage = this.troop.carriage - 1;
            }
            if(this.troop.ballista > 1)
            {
               newArmy.troops.ballista = this.troop.ballista - 1;
            }
            otherBallista = totalTroop.ballista - this.troop.ballista;
            criticalBalista = Math.max(500,5000 - otherBallista);
            if(newArmy.troops.ballista > criticalBalista)
            {
               newArmy.troops.ballista = criticalBalista;
            }
            maxTroop = this.getRallyDispatchPerArmyLimit(true);
            if(newArmy.troops.ballista > maxTroop)
            {
               newArmy.troops.ballista = maxTroop;
            }
            if(newArmy.troops.carriage > maxTroop - newArmy.troops.ballista)
            {
               newArmy.troops.carriage = maxTroop - newArmy.troops.ballista;
            }
            if(Utils.getTotalTroopCount(newArmy.troops) < 10)
            {
               return false;
            }
            newArmy.targetPoint = this.evasionFieldId;
            newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
            avoidedHero = this.bestIdleAttackHero(0);
            hero = this.getIdleHeroByTypePowerNotMayor(avoidedHero,4);
            if(hero == null)
            {
               if(numWaves < maxWaves && this.cityTimingAllowed("noherowarning",60))
               {
                  this.logMsg("HIDING > No hero to lead hiding troop!!",COLR_ERR_LOG_MSG);
               }
               if(this.doSpecialMarketHiding())
               {
                  return false;
               }
               return false;
            }
            newArmy.heroId = hero.id;
            newArmy.restTime = evasionDuration + 60;
            foodConsume = this.getFoodNeededToMarch(newArmy);
            if(this.resource.troopCostFood > this.resource.food.increaseRate)
            {
               foodConsume += (this.resource.troopCostFood - this.resource.food.increaseRate) / 60;
            }
            foodConsume += 2000;
            this.doEstimateResource();
            if(foodConsume > this.estResource.food)
            {
               if(this.cityTimingAllowed("emergencyfoodwarning",60))
               {
                  this.logMsg("HIDING > Not enough food to send troop out!!",COLR_ERR_LOG_MSG);
               }
               if(this.doSpecialMarketHiding())
               {
                  return false;
               }
               return false;
            }
            maxLoad = this.getMaxTroopLoad(newArmy.troops) - foodConsume;
            if(maxLoad <= 0 || newArmy.troops.carriage < 10)
            {
               return false;
            }
            goldReserved = Math.min(maxLoad,this.estResource.gold,2 * this.resource.maxPopulation);
            gold = this.estResource.gold - goldReserved - this.resource.herosSalary / 60 - 100;
            food = this.estResource.food - foodConsume;
            if(gold < 0)
            {
               gold = 0;
            }
            if(food < 0)
            {
               food = 0;
            }
            totalResources = gold + food + this.estResource.wood + this.estResource.stone + this.estResource.iron;
            factor = maxLoad - goldReserved >= totalResources ? 1 : (maxLoad - goldReserved) / totalResources;
            newArmy.resource = new ResourceBean();
            if(factor < 1 && factor > 0.1 && this.tradesArray.length != 0)
            {
               this.tradingLimited = true;
               this._hd522();
               return false;
            }
            if(factor < 0.001)
            {
               return false;
            }
            factor -= 0.00001;
            newArmy.resource.gold = gold * factor + goldReserved;
            newArmy.resource.food = food * factor;
            newArmy.resource.wood = this.estResource.wood * factor;
            newArmy.resource.stone = this.estResource.stone * factor;
            newArmy.resource.iron = this.estResource.iron * factor;
            stoneReserved = 5000000;
            extra = NaN;
            if(this._hf650(TradeConstants.RES_TYPE_IRON) > 2 * this._hf650(TradeConstants.RES_TYPE_STONE) && newArmy.resource.stone > stoneReserved && newArmy.resource.iron < this.estResource.iron)
            {
               extra = Math.min(this.estResource.iron - newArmy.resource.iron,newArmy.resource.stone - stoneReserved);
               extra = extra > 100 ? extra - 100 : 0;
               newArmy.resource.stone -= extra;
               newArmy.resource.iron += extra;
            }
            if(this._hf650(TradeConstants.RES_TYPE_WOOD) > 2 * this._hf650(TradeConstants.RES_TYPE_STONE) && newArmy.resource.stone > stoneReserved && newArmy.resource.wood < this.estResource.wood)
            {
               extra = Math.min(this.estResource.wood - newArmy.resource.wood,newArmy.resource.stone - stoneReserved);
               extra = extra > 100 ? extra - 100 : 0;
               newArmy.resource.stone -= extra;
               newArmy.resource.wood += extra;
            }
            if(this._hf650(TradeConstants.RES_TYPE_FOOD) > 2 * this._hf650(TradeConstants.RES_TYPE_STONE) && newArmy.resource.stone > stoneReserved && newArmy.resource.food < food)
            {
               extra = Math.min(food - newArmy.resource.food,newArmy.resource.stone - stoneReserved);
               extra = extra > 100000 ? extra - 100000 : 0;
               newArmy.resource.stone -= extra;
               newArmy.resource.food += extra;
            }
            if(this._hf650(TradeConstants.RES_TYPE_IRON) > 2 && newArmy.resource.gold > 10 * goldReserved && newArmy.resource.iron < this.estResource.iron)
            {
               extra = Math.min(this.estResource.iron - newArmy.resource.iron,newArmy.resource.gold - 10 * goldReserved);
               extra = extra > 100 ? extra - 100 : 0;
               newArmy.resource.gold -= extra;
               newArmy.resource.iron += extra;
            }
            if(this._hf650(TradeConstants.RES_TYPE_WOOD) > 2 && newArmy.resource.gold > 10 * goldReserved && newArmy.resource.wood < this.estResource.wood)
            {
               extra = Math.min(this.estResource.wood - newArmy.resource.wood,newArmy.resource.gold - 10 * goldReserved);
               extra = extra > 100 ? extra - 100 : 0;
               newArmy.resource.gold -= extra;
               newArmy.resource.wood += extra;
            }
            if(this._hf650(TradeConstants.RES_TYPE_FOOD) > 2 && newArmy.resource.gold > 10 * goldReserved && newArmy.resource.food < food)
            {
               extra = Math.min(food - newArmy.resource.food,newArmy.resource.gold - 10 * goldReserved);
               extra = extra > 10000 ? extra - 10000 : 0;
               newArmy.resource.gold -= extra;
               newArmy.resource.food += extra;
            }
            Utils.trimDecimalFromResoAmounts(newArmy.resource);
            if(!this.cityTimingAllowed("evasionThrottle",3))
            {
               return false;
            }
            if(!this.isEnoughResourcesToMarch(newArmy))
            {
               if(this.cityTimingAllowed("evasionretrymsg",15))
               {
                  this.logMsg("HIDING > RETRY: bad computation of resource to ship out",COLR_ERR_LOG_MSG);
                  this.logMsg("HIDING > foodConsume: " + foodConsume + " carry: " + resoBeanToString(newArmy.resource) + " est " + this.estResource.food + "/" + this.estResource.wood + "/" + this.estResource.stone + "/" + this.estResource.iron,COLR_DEF_LOG_MSG);
               }
               return false;
            }
            if(hero.status == HeroConstants.HERO_CHIEF_STATU)
            {
               this.removeMayor();
            }
            this.logMsg("HIDING > Sending critical troop/resource to " + Map.fieldIdToString(this.evasionFieldId) + hero.name + ", b:" + newArmy.troops.ballista + " t:" + newArmy.troops.carriage + ", g:" + newArmy.resource.gold + " f:" + newArmy.resource.food + " w:" + newArmy.resource.wood + " s:" + newArmy.resource.stone + " i:" + newArmy.resource.iron + " for " + Utils.formatTime(evasionDuration),COLR_DEF_LOG_MSG);
            handler = function(param1:CommandResponse):void
            {
               handleArmyCommandResponse(param1);
               if(param1.ok == 1)
               {
                  Utils.callLater(evasionDuration * 1000,_fx1070,[newArmy,Utils.getServerTime()]);
               }
            };
            CityStateCommands.newArmy(this.castleId,newArmy,handler);
            MasterTimer.getInstance().reserveEmergencySlot(this.timeSlot);
            this.adjEstFoodAfterMarch(newArmy);
            if(this.cityTimingAllowed("checkevasionfield",300))
            {
               Map.updateInfo(this.evasionFieldId);
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: startEvasion, " + error.message + "\n" + error.getStackTrace(),COLR_ERR_LOG_MSG);
            }
            return false;
         }
         return true;
      }
      
      private function getMinEnergyCfg() : int
      {
         return Math.min(60,Math.max(8,this.getCfg(CityConfigs.CFG_RESERVEDENERGY)));
      }
      
      public function _populate_Q_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ProduceBean = null;
         var _loc7_:AllProduceBean = null;
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         _loc6_ = null;
         for each(_loc7_ in this.troopProduceQueue)
         {
            _loc3_ = new DataRow();
            _loc3_.label = "Barrack" + ++_loc5_ + " @Pos: " + _loc7_.positionId + "\n";
            _loc3_.col0 = _loc5_ + "/" + _loc7_.positionId;
            _loc4_ = 0;
            for each(_loc6_ in _loc7_.allProduceQueueArray)
            {
               _loc3_["col" + ++_loc4_] = Utils.troopAbrNames[_loc6_.type] + ":" + Utils.abbrNum(_loc6_.num);
               _loc3_.label += "\nqId:" + _loc6_.queueId + " - " + Utils.troopAbrNames[_loc6_.type] + ":" + Utils.formatInt(_loc6_.num) + " - qTime:" + Utils.formatTime(_loc6_.costTime);
            }
            _loc2_.addItem(_loc3_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function getCastleBuffIndexFromTypeId(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.castle.buffsArray.length)
         {
            if((this.castle.buffsArray[_loc2_] as BuffBean).typeId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function _populate_A_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:String = null;
         var _loc5_:ArmyBean = null;
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         _loc4_ = null;
         for each(_loc5_ in this.localArmies)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = Utils.MISSION_NAMES[_loc5_.missionType];
            if(_loc5_.missionType == ObjConstants.ARMY_MISSION_TRANS)
            {
               _loc3_.bgColor = 13434828;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_SEND)
            {
               _loc3_.bgColor = 15125759;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_SCOUT)
            {
               _loc3_.bgColor = 16750950;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_CONSTRUCT)
            {
               _loc3_.bgColor = 13540095;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_OCCUPY)
            {
               _loc3_.bgColor = 16758454;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_COLONIZE)
            {
               _loc3_.bgColor = 11682309;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_SUPPRESS)
            {
               _loc3_.bgColor = 11682309;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_ANTI_COLONIAL)
            {
               _loc3_.bgColor = 11682309;
            }
            else if(_loc5_.missionType == ObjConstants.ARMY_MISSION_DEPLOY_TROOPS)
            {
               _loc3_.bgColor = 11682309;
            }
            else
            {
               _loc3_.bgColor = 16777215;
            }
            _loc4_ = "";
            if(_loc5_.direction != ArmyConstants.ARMY_FORWARD)
            {
               if(_loc5_.direction != ArmyConstants.ARMY_BACKWARD)
               {
                  _loc3_.col1 += " at";
                  _loc3_.col4 = _loc5_.armyId;
                  _loc3_.bgColor = 16771755;
               }
               else
               {
                  _loc3_.col1 += " return";
                  _loc3_.col3 = Utils.formatEndTime(_loc5_.reachTime);
                  _loc3_.col4 = -1;
                  _loc3_.bgColor = 13619199;
                  _loc4_ = "\nArrival: " + Utils.getTimeStr(_loc5_.reachTime);
               }
            }
            else
            {
               _loc3_.col3 = Utils.formatEndTime(_loc5_.reachTime);
               _loc3_.col4 = _loc5_.armyId;
               _loc4_ = "\nArrival: " + Utils.getTimeStr(_loc5_.reachTime);
            }
            _loc3_.col2 = _loc5_.targetPosName + " " + Map.fieldIdToString(_loc5_.targetFieldId);
            _loc3_.col5 = _loc5_.armyId;
            _loc3_.col6 = "local";
            _loc3_.label = "Army id: " + _loc5_.armyId + "\n" + _loc3_.col2 + (_loc5_.hero == null ? "" : "\nhero " + _loc5_.hero + " " + _loc5_.heroLevel) + "\n" + Utils.troopStrBeanToMsgString(_loc5_.troop) + "\n" + resoBeanToString(_loc5_.resource) + _loc4_;
            _loc3_.col8 = _loc5_.armyId;
            _loc2_.addItem(_loc3_);
         }
         _loc2_.source.sortOn("col8");
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function _ni200(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         _loc2_ = param1.split(" ");
         if(_loc2_.length == 0)
         {
            this.logMsg("Usage: slowhuntingpolicy frequency [troop1] [troop2] [troop3] [dist3]");
            return false;
         }
         if(!Utils.hasValue(_loc2_[0]))
         {
            this.logMsg("Error slowhuntingpolicy: invalid frequency, must be a number: " + _loc2_[0]);
            return false;
         }
         if(_loc2_.length >= 2 && _loc2_[1] != "none" && Utils.getTroops(_loc2_[1]) == null)
         {
            this.logMsg("Error slowhuntingpolicy: invalid troop against w/p/sw: " + _loc2_[1]);
            return false;
         }
         if(_loc2_.length >= 3 && _loc2_[2] != "none" && Utils.getTroops(_loc2_[2]) == null)
         {
            this.logMsg("Error slowhuntingpolicy: invalid troop against pure archers: " + _loc2_[2]);
            return false;
         }
         if(_loc2_.length >= 4 && _loc2_[3] != "none" && Utils.getTroops(_loc2_[3]) == null)
         {
            this.logMsg("Error slowhuntingpolicy: invalid troop against cav/w/p/sw: " + _loc2_[3]);
            return false;
         }
         if(_loc2_.length >= 5 && !Utils.hasValue(_loc2_[4]))
         {
            this.logMsg("Error slowhuntingpolicy: invalid distance limit for cav/w/p/sw: " + _loc2_[4]);
            return false;
         }
         this.slowHuntingPolicy[0] = int(_loc2_[0]) * 60;
         if(_loc2_.length >= 2)
         {
            this.slowHuntingPolicy[1] = Utils.getTroops(_loc2_[1]);
         }
         if(_loc2_.length >= 3)
         {
            this.slowHuntingPolicy[2] = Utils.getTroops(_loc2_[2]);
         }
         if(_loc2_.length >= 4)
         {
            this.slowHuntingPolicy[3] = Utils.getTroops(_loc2_[3]);
         }
         if(_loc2_.length >= 5)
         {
            this.slowHuntingPolicy[4] = Number(_loc2_[4]);
         }
         return true;
      }
      
      private function processBuildNpc(param1:Boolean, param2:Boolean) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:FieldBean = null;
         var _loc5_:FieldBean = null;
         var _loc6_:int = 0;
         var _loc7_:MapCastleBean = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:CityState = null;
         var _loc12_:HeroBean = null;
         var _loc13_:TroopBean = null;
         var _loc14_:NewArmyParam = null;
         this.buildNPCReady = true;
         if(!this.hasFreeCitySlot())
         {
            return false;
         }
         if(this.distanceSettings[DISTANCE_BUILDNPC] <= 0 || this.distanceSettings[DISTANCE_BUILDNPC10] <= 0)
         {
            return false;
         }
         _loc3_ = this.getCfgBuildNpc();
         this.revalidateBuildnpcArmyTargets();
         _loc4_ = null;
         for each(_loc5_ in this.fields)
         {
            if(!(_loc5_.type != FieldConstants.TYPE_FLAT || !this.levelOkayForBuildnpc(_loc5_.level,_loc3_)))
            {
               if(this.flatOkayForBuildnpc(_loc5_.id,_loc5_.level))
               {
                  if(this.getArmyToTarget(_loc5_.id) == null)
                  {
                     _loc4_ = _loc5_;
                     break;
                  }
               }
            }
         }
         if(param1 && _loc4_ != null)
         {
            if(!this.cityTimingAllowed("npcbuilding_build" + _loc4_.id,3 * 60))
            {
               return false;
            }
            return this.doBuildNewCity(_loc4_.id,true);
         }
         if(this.flatFieldsDetailInfo == null || this.flatFieldsDetailInfo.length == 0)
         {
            return false;
         }
         _loc6_ = 0;
         while(_loc6_ < 5 && _loc6_ < this.flatFieldsDetailInfo.length)
         {
            if(Map.getLevel(this.flatFieldsDetailInfo[_loc6_].id) == -1)
            {
               this.buildNPCReady = false;
            }
            if(Map.getDetail(this.flatFieldsDetailInfo[_loc6_].id) == null)
            {
               this.buildNPCReady = false;
            }
            _loc6_++;
         }
         _loc7_ = Map.getDetail(this.flatFieldsDetailInfo[0].id);
         if(_loc7_ == null)
         {
            return false;
         }
         _loc8_ = Map.getLevel(this.flatFieldsDetailInfo[0].id);
         if(_loc8_ == -1)
         {
            return false;
         }
         if(!param2 || !param1)
         {
            return false;
         }
         _loc9_ = this.getCfg(CityConfigs.CFG_HUNTING) > 0 ? 1 : 0;
         _loc10_ = this.getCountOfLocalArmiesForCaptureFlats();
         if(_loc10_ > 0 && _loc10_ + this.fields.length + _loc9_ >= this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL))
         {
            return false;
         }
         for each(_loc11_ in MainScreen.getCities())
         {
            if(_loc11_.castle.id != this.castleId)
            {
               if(_loc11_.cityManager.getCfg(CityConfigs.CFG_BUILDNPC) > 0)
               {
                  if(Map.fieldDistance(_loc7_.id,_loc11_.castle.fieldId) < Map.fieldDistance(_loc7_.id,this.castle.fieldId))
                  {
                     this.flatFieldsDetailInfo.removeItemAt(0);
                     return false;
                  }
               }
            }
         }
         _loc12_ = this.getNextValleyHero();
         if(_loc12_ == null)
         {
            return false;
         }
         _loc13_ = this.getTroopsToAttackValley(_loc8_);
         if(_loc13_ == null)
         {
            return false;
         }
         if(!this._xm876())
         {
            if(playerTimingAllowed("buildnpcnovalley",300))
            {
               this.logErrMsg("BUILDNPC > Unable to build npc due to lack of valley slot");
            }
            return false;
         }
         _loc14_ = new NewArmyParam();
         _loc14_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc14_.troops = _loc13_;
         _loc14_.resource = new ResourceBean();
         _loc14_.heroId = _loc12_.id;
         _loc14_.targetPoint = _loc7_.id;
         if(!this.isEnoughResourcesToMarch(_loc14_))
         {
            return false;
         }
         this.flatFieldsDetailInfo.removeItemAt(0);
         if(Map.getType(_loc7_.id) != FieldConstants.TYPE_FLAT)
         {
            return false;
         }
         if(_loc7_.userName != null)
         {
            return false;
         }
         if(!playerTimingAllowed("npcbuilding_flat" + _loc7_.id,1800))
         {
            return false;
         }
         if(this.targetHasArmies(_loc7_.id))
         {
            return false;
         }
         npcLocations.push(_loc7_.id);
         this.logMsg("BUILDNPC > Attack flat " + Map.fieldIdToString(_loc7_.id) + " for npc with " + Utils.troopBeanToString(_loc13_) + ", arriving in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc14_) / Utils.getHeroSpeedFactor(_loc12_)),COLR_STD_LOG_MSG);
         CityStateCommands.newArmy(this.castleId,_loc14_,this.handleArmyCommandResponse);
         this.lastBuildNPCLevels[_loc7_.id] = _loc8_;
         this.adjEstFoodAfterMarch(_loc14_);
         Map.updateDetailInfo(_loc7_.id);
         if(this.lastNPCTargets[_loc7_.id] != undefined)
         {
            delete this.lastNPCTargets[_loc7_.id];
         }
         if(this.lastNPC10Targets[_loc7_.id] != undefined)
         {
            delete this.lastNPC10Targets[_loc7_.id];
         }
         if(this.lastPriorityNPCTargets[_loc7_.id] != undefined)
         {
            delete this.lastPriorityNPCTargets[_loc7_.id];
         }
         return true;
      }
      
      public function _nd1071() : void
      {
         if(this.evacuationTown != -1)
         {
            this.logMsg("Evacuation to " + Map.fieldIdToCoordString(this.evacuationTown) + " ended");
            this.evacuationTown = -1;
         }
         else
         {
            this.logMsg("No evacuation to end");
         }
      }
      
      private function _ry570(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("trading error: " + param1.errorMsg);
            MasterTimer.getInstance().setNextActiveTime();
         }
      }
      
      public function _reserveEmergencyTimeSlot(param1:Boolean = false) : void
      {
         MasterTimer.getInstance().reserveEmergencySlot(this.timeSlot,param1);
      }
      
      public function _cfg_notNpcHeroes(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.notNpcHeroes = _loc2_;
      }
      
      private function isTrainingHeroInTown() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:HeroBean = null;
         if(this.trainingHeroName == null)
         {
            return true;
         }
         _loc1_ = this.trainingHeroName.toLowerCase();
         for each(_loc2_ in this.heroes)
         {
            if(_loc2_.name.toLowerCase() == _loc1_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function _isEnoughResoToProduceFort(param1:int, param2:int) : Boolean
      {
         var _loc3_:FortProduceListBean = null;
         for each(_loc3_ in this.fortificationListArray)
         {
            if(_loc3_.typeId == param1)
            {
               if(!this.isConditionsMet(_loc3_.conditionBean))
               {
                  return false;
               }
               if(this.estResource.gold + 1000 < param2 * _loc3_.conditionBean.gold || this.estResource.food + 1000 < param2 * _loc3_.conditionBean.food || this.estResource.wood + 1000 < param2 * _loc3_.conditionBean.wood || this.estResource.stone + 1000 < param2 * _loc3_.conditionBean.stone || this.estResource.iron < param2 * _loc3_.conditionBean.iron)
               {
                  return false;
               }
               return true;
            }
         }
         return false;
      }
      
      public function getCfg(param1:String) : Number
      {
         return this.cityCfg.getCfg(param1);
      }
      
      public function _wb316ALXAI(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:TroopBean = null;
         var _loc4_:FortificationsBean = null;
         var _loc5_:TroopBean = null;
         var _loc6_:Array = null;
         if(this.getCfg(CityConfigs.CFG_ADVEVASION) <= 0)
         {
            this.logMsg("Please set advevasion *only after* setting \'config advevasion:1\'");
            return false;
         }
         _loc2_ = param1.split(" ");
         if(_loc2_.length != 3)
         {
            this.logMsg("Usage:  advevasion troopCond(enemyArmy) fortCond MaxTroops");
            return false;
         }
         _loc3_ = Utils.getTroops(_loc2_[0]);
         if(_loc2_[0] == "none" || _loc3_ == null)
         {
            this.logMsg("Invalid troop condition: " + _loc2_[0]);
            return false;
         }
         _loc4_ = Utils.getFortifications(_loc2_[1]);
         if(_loc2_[1] != "none" && _loc4_ == null)
         {
            this.logMsg("Invalid fortification condition: " + _loc2_[1]);
            return false;
         }
         _loc5_ = Utils.getTroops(_loc2_[2]);
         if(_loc2_[2] == "none" || _loc3_ == null)
         {
            this.logMsg("Invalid troop condition: " + _loc2_[2]);
            return false;
         }
         _loc6_ = new Array(_loc3_,_loc4_,_loc5_);
         this.advEvasionRules.push(_loc6_);
         return true;
      }
      
      private function _pe930(param1:String) : HeroBean
      {
         var _loc2_:HeroBean = null;
         var _loc3_:HeroBean = null;
         _loc2_ = null;
         for each(_loc3_ in this.heroes)
         {
            if(_loc2_ == null || Utils.isWorstHeroByType(param1,_loc3_,_loc2_))
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      private function isLastEnemyTimeLessThan1Hr() : Boolean
      {
         return Math.abs(this.lastEnemyTime - Utils.getServerTime()) < 3600 * 1000;
      }
      
      public function _clearTroopQueues(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AllProduceBean = null;
         for each(_loc3_ in this.troopProduceQueue)
         {
            _loc2_ = _loc3_.allProduceQueueArray.length - 1;
            while(_loc2_ >= param1)
            {
               CityStateCommands.cancelTroopProduce(this.castleId,_loc3_.positionId,_loc3_.getAllProduceQueue(_loc2_).queueId);
               _loc2_--;
            }
         }
         Utils.callLater(5000,this.updateTroopQueue);
      }
      
      private function promoteBestInteHero() : void
      {
         var _loc1_:HeroBean = null;
         _loc1_ = this.bestIdleIntelHero(0);
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.status == CityStateConstants.HERO_STATUS_IDLE || _loc1_.status == CityStateConstants.HERO_STATUS_MAYOR)
         {
            if(this._ek905(_loc1_.id) || _loc1_.status == CityStateConstants.HERO_STATUS_IDLE)
            {
               ++this.promoteCount;
               if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
               {
                  this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Promote to chief: " + Utils.heroBeanToString(_loc1_),COLR_DBG_LOG_MSG);
               }
               if(this.heroNotIdleError)
               {
                  CityStateCommands.dischargeChief(this.castleId);
               }
               this.heroNotIdleError = false;
               CityStateCommands.promoteToChief(this.castleId,_loc1_.id,this.onPromoteToChief);
            }
         }
         if((this._aq355(2) || _loc1_.intelligence == 0) && _loc1_.level >= 10 && this.isGearAvailable())
         {
            if(_loc1_.intelligence == 0)
            {
               this.logMsg("Auto change gear of " + Utils.heroBeanToString(_loc1_) + " to int",COLR_STD_LOG_MSG);
            }
            ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc1_.id,3,this.handleCommandResponse);
         }
      }
      
      private function handleFortificationUpdate(param1:FortificationsUpdate) : void
      {
         if(param1.castleId != this.castleId)
         {
            return;
         }
         this.fortification = param1.fortification;
         this.fortificationProductionUpdateNeeded = true;
      }
      
      private function checkAlliance() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Boolean = false;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(MainScreen.getPlayer().playerInfo.alliance == null || this.varAllianceListDeny.length < 1)
         {
            return;
         }
         if(this.varAllMembersList.length == 0)
         {
            if(playerTimingAllowed("getalliancemembership",15 * 60,false))
            {
               ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this.setAllMembersList);
               playerTimingAllowed("getalliancemembership",15 * 60);
            }
            return;
         }
         _loc1_ = new Object();
         _loc2_ = false;
         for each(_loc3_ in this.varAllianceListDeny)
         {
            for each(_loc4_ in this.varAllMembersList)
            {
               if(_loc1_[_loc4_.id] == undefined)
               {
                  if(_loc4_.userName.toLowerCase() == _loc3_)
                  {
                     if(playerTimingAllowed("EchoEject" + _loc4_.userName,5 * 60))
                     {
                        this.logMsg(">> " + _loc4_.userName + " Is in the alliance (eject)");
                     }
                     ActionFactory.getInstance().getCommonCommands().allianceChat(">> " + _loc4_.userName + " Is in the alliance (eject)",0);
                     _loc1_[_loc4_.id] = 1;
                     ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(_loc4_.userName);
                     _loc2_ = true;
                     break;
                  }
               }
            }
         }
         if(_loc2_)
         {
            this.varAllMembersList = new Array();
            if(playerTimingAllowed("getalliancemembership",5 * 60))
            {
               ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this.setAllMembersList);
            }
         }
      }
      
      private function handleCommandResponse(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("Error: " + param1.errorMsg);
         }
      }
      
      private function sortHeroes(param1:ArrayCollection = null) : void
      {
         var _loc2_:ArrayCollection = null;
         _loc2_ = param1 == null ? this.heroes : param1;
         if(_loc2_.sort == null)
         {
            _loc2_.sort = new Sort();
            _loc2_.sort.compareFunction = Utils.myHeroCompare;
         }
         if(_loc2_.length > 1)
         {
            _loc2_.refresh();
         }
         this.castle.herosArray = new ArrayCollection(_loc2_.toArray());
      }
      
      public function get selfArmies() : ArrayCollection
      {
         return this.player.selfArmysArray;
      }
      
      private function _bl67() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyBean = null;
         var _loc3_:HeroBean = null;
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:MapCastleBean = null;
         var _loc11_:TroopBean = null;
         var _loc12_:NewArmyParam = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         if(this.npc10LimitTroopBean == null)
         {
            return false;
         }
         _loc1_ = 0;
         for each(_loc2_ in this.localArmies)
         {
            if(!(this.lastNPC10Targets[_loc2_.targetFieldId] == undefined || _loc2_.missionType != ObjConstants.ARMY_MISSION_OCCUPY || _loc2_.direction != ArmyConstants.ARMY_FORWARD))
            {
               _loc1_ = Map.getType(_loc2_.targetFieldId,1 * 60);
               if(!(_loc1_ == -1 || _loc1_ == FieldConstants.TYPE_NPC))
               {
                  this.logMsg("Target npc 10 is no longer a npc, recall troop " + _loc2_.armyId + " toward " + Map.fieldIdToString(_loc2_.targetFieldId),COLR_STD_LOG_MSG);
                  CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
               }
            }
         }
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            if(this.recallArmiesToNpc(estimateMaintenanceDownTime - 10 * 1000))
            {
               this.logMsg("Troops to NPC arriving during maintenance have been recalled","#79796A");
               return true;
            }
         }
         if(!isEnoughTroops(this.troop,this.npc10LimitTroopBean))
         {
            return false;
         }
         if(this.localNPC10s == null)
         {
            return false;
         }
         if(this.researches == null)
         {
            return false;
         }
         if(this._ty399())
         {
            return false;
         }
         if(this.enemyArmies.length > 0 && this.enemyArmies[0].reachTime - Utils.getServerTime() < 3600 * 1000)
         {
            return false;
         }
         if(this.getCfg(CityConfigs.CFG_HIDING) > 0 && this.enemyArmies.length > 0)
         {
            if(this.getTotalAvailableHeroes() <= 2)
            {
               return false;
            }
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         if(this._cd932 != -1 && this._rr420(-1) >= this._cd932)
         {
            return false;
         }
         _loc3_ = this.getHeroForNpc10();
         _loc4_ = false;
         if(_loc3_ != null && !playerTimingAllowed("hero10busy" + _loc3_.id,15,false))
         {
            _loc3_ = null;
            _loc4_ = true;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
         {
            if(!_loc4_)
            {
               this.logMsg("checking idle hero for npc10: " + Utils.heroBeanToString(_loc3_),COLR_STD_LOG_MSG);
            }
         }
         if(_loc3_ == null)
         {
            return false;
         }
         _loc5_ = this.npc10List != null ? this.npc10List : this.localNPC10s;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = null;
         _loc11_ = null;
         _loc12_ = null;
         _loc13_ = 0;
         _loc14_ = 0;
         _loc15_ = 0;
         while(_loc15_ < _loc5_.length)
         {
            _loc8_ = int(_loc5_[_loc15_]);
            if(!(this.npcAvoidList != null && this.npcAvoidList.indexOf(_loc8_) != -1))
            {
               if(!(this.npc10Area != null && !Map.isInArea(this.npc10Area[0],this.npc10Area[1],_loc8_)))
               {
                  if(this.npc10List == null)
                  {
                     _loc14_ = Map.getLevel(_loc8_);
                     if(_loc14_ == 10)
                     {
                        _loc9_ = Map.getType(_loc8_);
                        if(_loc9_ != -1)
                        {
                           if(_loc9_ != FieldConstants.TYPE_NPC)
                           {
                              this.logMsg(Map.fieldIdToString(_loc8_) + " is not or is no longer an npc",COLR_STD_LOG_MSG);
                              _loc5_.splice(_loc15_,1);
                           }
                           else
                           {
                              _loc10_ = Map.getDetailInfo(_loc8_);
                              if(_loc10_ != null)
                              {
                                 if(_loc10_.powerLevel == 4)
                                 {
                                    _loc7_++;
                                    _loc11_ = this.getTroopForFarmNpc10();
                                    if(_loc11_ == null)
                                    {
                                       this.logMsg("Not enough troop to attack npc10",COLR_STD_LOG_MSG);
                                       return false;
                                    }
                                    _loc6_++;
                                    if(!this._bb1110(_loc8_))
                                    {
                                       _loc12_ = new NewArmyParam();
                                       _loc12_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                       _loc12_.heroId = _loc3_.id;
                                       _loc12_.targetPoint = _loc8_;
                                       _loc12_.troops = _loc11_;
                                       _loc12_.resource = new ResourceBean();
                                       if(!this.isEnoughResourcesToMarch(_loc12_))
                                       {
                                          return false;
                                       }
                                       if(this.isWarTownOn(2 * this.getTravelTimeReliefStationAdj(_loc12_) / Utils.getHeroSpeedFactor(_loc3_)))
                                       {
                                          this.logMsg("wartownpolicy doesn\'t allow sending troops out: NPC10",COLR_STD_LOG_MSG);
                                          return false;
                                       }
                                       _loc13_ = this.getCfg(CityConfigs.CFG_TRAINING) > 0 ? 1 : 8;
                                       if(playerTimingAllowed("attack" + _loc8_,_loc13_ * 3600))
                                       {
                                          playerTimingAllowed("hero10busy" + _loc3_.id,15);
                                          this.logMsg("attack NPC10 " + Map.fieldIdToString(_loc8_) + " with hero " + Utils.heroBeanToString(_loc3_) + " and " + Utils.troopBeanToString(_loc12_.troops) + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc12_) / Utils.getHeroSpeedFactor(_loc3_)),COLR_STD_LOG_MSG);
                                          if(_loc3_.status == HeroConstants.HERO_CHIEF_STATU || _loc3_.id == this.lastPromoteId)
                                          {
                                             this.removeMayor();
                                          }
                                          CityStateCommands.newArmy(this.castleId,_loc12_,this.handleArmyCommandResponse);
                                          this.lastNPC10Targets[_loc8_] = _loc8_;
                                          this.adjEstFoodAfterMarch(_loc12_);
                                          Map.reqMapInfoAndDetail(_loc8_);
                                          return true;
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     _loc9_ = Map.getType(_loc8_);
                     if(_loc9_ != -1)
                     {
                        if(_loc9_ != FieldConstants.TYPE_NPC)
                        {
                           this.logMsg(Map.fieldIdToString(_loc8_) + " is not or is no longer an npc",COLR_STD_LOG_MSG);
                           _loc5_.splice(_loc15_,1);
                        }
                        else
                        {
                           _loc10_ = Map.getDetailInfo(_loc8_);
                           if(_loc10_ != null)
                           {
                              if(_loc10_.powerLevel == 4)
                              {
                                 _loc7_++;
                                 _loc11_ = this.getTroopForFarmNpc10();
                                 if(_loc11_ == null)
                                 {
                                    this.logMsg("Not enough troop to attack npc10",COLR_STD_LOG_MSG);
                                    return false;
                                 }
                                 _loc6_++;
                                 if(!this._bb1110(_loc8_))
                                 {
                                    _loc12_ = new NewArmyParam();
                                    _loc12_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                    _loc12_.heroId = _loc3_.id;
                                    _loc12_.targetPoint = _loc8_;
                                    _loc12_.troops = _loc11_;
                                    _loc12_.resource = new ResourceBean();
                                    if(!this.isEnoughResourcesToMarch(_loc12_))
                                    {
                                       return false;
                                    }
                                    if(this.isWarTownOn(2 * this.getTravelTimeReliefStationAdj(_loc12_) / Utils.getHeroSpeedFactor(_loc3_)))
                                    {
                                       this.logMsg("wartownpolicy doesn\'t allow sending troops out: NPC10",COLR_STD_LOG_MSG);
                                       return false;
                                    }
                                    _loc13_ = this.getCfg(CityConfigs.CFG_TRAINING) > 0 ? 1 : 8;
                                    if(playerTimingAllowed("attack" + _loc8_,_loc13_ * 3600))
                                    {
                                       playerTimingAllowed("hero10busy" + _loc3_.id,15);
                                       this.logMsg("attack NPC10 " + Map.fieldIdToString(_loc8_) + " with hero " + Utils.heroBeanToString(_loc3_) + " and " + Utils.troopBeanToString(_loc12_.troops) + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc12_) / Utils.getHeroSpeedFactor(_loc3_)));
                                       if(_loc3_.status == HeroConstants.HERO_CHIEF_STATU || _loc3_.id == this.lastPromoteId)
                                       {
                                          this.removeMayor();
                                       }
                                       CityStateCommands.newArmy(this.castleId,_loc12_,this.handleArmyCommandResponse);
                                       this.lastNPC10Targets[_loc8_] = _loc8_;
                                       this.adjEstFoodAfterMarch(_loc12_);
                                       Map.reqMapInfoAndDetail(_loc8_);
                                       return true;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc15_++;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
         {
            this.logMsg("number of local npc10 " + _loc7_ + "/" + _loc5_.length + ", appropriate level/troop: " + _loc6_,COLR_STD_LOG_MSG);
         }
         if(this.npc10List == null && _loc7_ == _loc6_ && this.distanceSettings[DISTANCE_NPC] < 30 && (this.npc10Area == null || Map.fieldDistance(this.castle.fieldId,this.npc10Area[0]) < this.distanceSettings[DISTANCE_NPC] || Map.fieldDistance(this.castle.fieldId,this.npc10Area[1]) < this.distanceSettings[DISTANCE_NPC]))
         {
            if(this.distanceSettings[DISTANCE_NPC] < 4)
            {
               this.distanceSettings[DISTANCE_NPC] = 4;
            }
            this.distanceSettings[DISTANCE_NPC] = int(this.distanceSettings[DISTANCE_NPC] * 1.3);
            this.localNPC10s = null;
         }
         return false;
      }
      
      private function doAutoUseItems() : void
      {
         var _loc1_:ItemBean = null;
         var _loc2_:ItemBean = null;
         var _loc3_:String = null;
         var _loc4_:ItemBean = null;
         _loc1_ = null;
         _loc2_ = null;
         _loc3_ = null;
         for each(_loc4_ in this.player.itemsArray)
         {
            if(!(_loc4_.id == null || _loc4_.count <= 0))
            {
               _loc3_ = Items.getItemName(_loc4_.id);
               if(!(this.autoItems[_loc4_.id.toLowerCase()] == undefined && this.autoItems[_loc3_.toLowerCase()] == undefined))
               {
                  if(_loc3_ == "Truce_Agreement")
                  {
                     _loc2_ = _loc4_;
                  }
                  else if(_loc3_ == "Speech_Text")
                  {
                     _loc1_ = _loc4_;
                  }
                  else if(_loc3_ != "Advance_by_A_Hidden_Path")
                  {
                     if(playerTimingAllowed("autouseitem",10))
                     {
                        this.logMsg("AUTOUSEITEMS > Using item: " + _loc3_,COLR_STD_LOG_MSG);
                        --_loc4_.count;
                        ActionFactory.getInstance().getShopCommands().useGoods(this.castleId,_loc4_.id,1,this.doAutoUseItemHandler);
                     }
                  }
               }
            }
         }
         if(_loc1_ != null && this.resource.support <= this.autoItems["speech_text"][0] && this.cityTimingAllowed("usespeechtext",1200,true))
         {
            if(this.cityTimingAllowed("usespeechtext",1200))
            {
               this.logMsg("<b>AUTOUSEITEMS > <i>Using item Speech Text. Loyalty is at or below " + this.autoItems["Speech_Text".toLocaleLowerCase()][0] + "  [ loyalty = " + this.resource.support + " ]</i></b>",COLR_DEF_LOG_MSG);
               ActionFactory.getInstance().getShopCommands().useCastleGoods(this.castleId,Items.getItemId("Speech_Text"),this.handleCommandResponse);
               --_loc1_.count;
            }
         }
         if(_loc2_ != null && this.resource.support <= this.autoItems["truce_agreement"][0])
         {
            this.doAutoUseTruce(this.resource.support,false,false,false,false);
         }
      }
      
      public function getTroopFoodValue(param1:TroopBean) : Number
      {
         return 1 * param1.peasants + 1 * param1.militia + 2 * param1.scouter + 3 * param1.pikemen + 3 * param1.swordsmen + 4 * param1.archer + 9 * param1.lightCavalry + 17 * param1.heavyCavalry + 5 * param1.carriage + 25 * param1.ballista + 50 * param1.batteringRam + 125 * param1.catapult;
      }
      
      private function _hq910() : TroopBean
      {
         var _loc1_:TroopBean = null;
         if(this.npcTroopBean != null)
         {
            return this.npcTroopBean;
         }
         _loc1_ = new TroopBean();
         _loc1_.ballista = this.NPCBALLISTAS[5];
         _loc1_.carriage = NPCTRANSPORTS[5] / (1 + 0.1 * this.getTechLevel(TechConstants.LOAD_TECH)) + 1;
         return _loc1_;
      }
      
      public function _fr173() : HeroBean
      {
         var _loc1_:String = null;
         var _loc2_:HeroBean = null;
         var _loc3_:ArrayCollection = null;
         var _loc4_:Boolean = false;
         var _loc5_:HeroBean = null;
         var _loc6_:String = null;
         var _loc7_:HeroBean = null;
         if(this.spamHeroes != null)
         {
            return this._pp854(this.spamHeroes);
         }
         _loc1_ = "power";
         _loc2_ = null;
         _loc3_ = this.getReservedHeroes();
         _loc3_.addItem(this.bestPoliticHero());
         for each(_loc5_ in this.heroes)
         {
            if(_loc5_.stamina >= this.getMinEnergyCfg())
            {
               if(_loc5_.status == HeroConstants.HERO_FREE_STATU)
               {
                  if(!(this.trainingHeroName != null && _loc5_.name.toLowerCase() == this.trainingHeroName.toLowerCase()))
                  {
                     _loc4_ = false;
                     if(this.notSpamHeroes != null)
                     {
                        for each(_loc6_ in this.notSpamHeroes)
                        {
                           if(_loc5_.name.toLowerCase() == _loc6_.toLowerCase())
                           {
                              _loc4_ = true;
                           }
                        }
                     }
                     else
                     {
                        if(!_lb30(_loc5_))
                        {
                           continue;
                        }
                        for each(_loc7_ in _loc3_)
                        {
                           if(_loc5_ == _loc7_)
                           {
                              _loc4_ = true;
                           }
                        }
                     }
                     if(!_loc4_)
                     {
                        if(_loc2_ == null || Utils.isWorstHeroByType(_loc1_,_loc2_,_loc5_))
                        {
                           _loc2_ = _loc5_;
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function promoteBestPolHero() : void
      {
         var _loc1_:HeroBean = null;
         _loc1_ = this.bestIdlePoliticsHero(0);
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.status == CityStateConstants.HERO_STATUS_IDLE || _loc1_.status == CityStateConstants.HERO_STATUS_MAYOR)
         {
            if(this._ek905(_loc1_.id) || _loc1_.status == CityStateConstants.HERO_STATUS_IDLE)
            {
               ++this.promoteCount;
               if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
               {
                  this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Promote to chief: " + Utils.heroBeanToString(_loc1_),COLR_DBG_LOG_MSG);
               }
               if(this.heroNotIdleError)
               {
                  CityStateCommands.dischargeChief(this.castleId);
               }
               this.heroNotIdleError = false;
               CityStateCommands.promoteToChief(this.castleId,_loc1_.id,this.onPromoteToChief);
            }
         }
         if((this._aq355(0) || _loc1_.politics == 0) && _loc1_.level >= 10 && this.isGearAvailable())
         {
            if(_loc1_.politics == 0)
            {
               this.logMsg("Auto change gear of " + Utils.heroBeanToString(_loc1_) + " to pol",COLR_STD_LOG_MSG);
            }
            ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc1_.id,1,this.handleCommandResponse);
         }
      }
      
      private function _rf889(param1:TroopStrBean) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in [TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER])
         {
            if(int(param1[troopIntNames[_loc2_]]) > 1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function _ui319(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         _loc3_ = 0;
         if(param1 >= TFConstants.F_TRAP)
         {
            _loc3_ = this.getTechLevel(TechConstants.BUILD_TECH);
         }
         else if(param1 == TFConstants.T_CARRIAGE || param1 >= TFConstants.T_BALLISTA)
         {
            _loc3_ = this.getTechLevel(TechConstants.MAKE_TECH);
         }
         else
         {
            _loc3_ = this.getTechLevel(TechConstants.TRAIN_SKILL);
         }
         _loc4_ = 1 / (Math.pow(0.9,_loc3_) * Math.pow(HEROFACTOR,param2));
         return troopTimes[param1] / _loc4_;
      }
      
      private function delayedInit() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:CastleBean = null;
         if(this.player.buffsArray == null)
         {
            this.player.buffsArray = new ArrayCollection();
         }
         if(this.player.itemsArray == null)
         {
            this.player.itemsArray = new ArrayCollection();
         }
         if(this.isMainTown())
         {
            this._printPlayerBuffs(true);
            this.listMedals();
            if(this.player.castlesArray.length > 1 && MainScreen.buildNpcEnabled)
            {
               for each(_loc6_ in this.player.castlesArray)
               {
                  if(buildCityLocation != _loc6_.fieldId && _loc6_.buildingsArray.length <= 1 && (_loc6_.buildingsArray.length == 0 || _loc6_.buildingsArray[0].name == "Town Hall" && _loc6_.buildingsArray[0].level <= 1) && _loc6_.name == "Flat" && _loc6_.herosArray.length == 0 && (_loc6_.troop.peasants >= 125 && _loc6_.troop.peasants <= 250) && Utils.getTotalTroopCount(_loc6_.troop) - _loc6_.troop.peasants == 0 && _loc6_.resource.food.amount < 10000 && _loc6_.resource.wood.amount < 10000 && _loc6_.resource.stone.amount < 10000 && _loc6_.resource.iron.amount < 10000)
                  {
                     this.logMsg("BUILDNPC > Abandon new castle with no buildings, no heroes, no troops, and less than 15k of each resource for NPC: " + _loc6_.name + " at " + Map.fieldIdToCoordString(_loc6_.fieldId),COLR_STD_LOG_MSG);
                     this.doAbandonCastle(_loc6_);
                  }
               }
            }
         }
         this._resetLocalFieldsInfo();
         CityStateCommands.getResearchList(this.castleId,this.researchListResponseHandler);
         _loc1_ = "Castle " + this.castle.name + " is at (" + Map.getX(this.castle.fieldId) + "," + Map.getY(this.castle.fieldId) + ") in " + Map.getRegionName(this.castle.fieldId);
         _loc2_ = this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_FARM_LAND,1);
         _loc3_ = this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_LUMBER_MILL,1);
         _loc4_ = this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_STONE_MINE,1);
         _loc5_ = this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_IRON_MINE,1);
         if(_loc3_ >= Math.max(_loc2_,_loc4_,_loc5_))
         {
            this.logMsg(_loc1_ + ", and is a Wood City","#225555");
            this.resourceFieldType = FieldConstants.TYPE_FOREST;
         }
         else if(_loc5_ >= Math.max(_loc2_,_loc4_))
         {
            this.logMsg(_loc1_ + ", and is a Iron City","#225555");
            this.resourceFieldType = FieldConstants.TYPE_HILL;
         }
         else if(_loc2_ >= _loc4_)
         {
            this.logMsg(_loc1_ + ", and is a Food City","#225555");
            this.resourceFieldType = FieldConstants.TYPE_LAKE;
         }
         else
         {
            this.logMsg(_loc1_ + ", and is a Stone City","#225555");
            this.resourceFieldType = FieldConstants.TYPE_DESERT;
         }
         this._printLocalBuffs();
         if(!this.player.autoHeal)
         {
            this.logMsg("Set auto heal");
            ActionFactory.getInstance().getCommonCommands().setAutoHeal(true);
         }
      }
      
      private function _ad677() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         _loc1_ = null;
         _loc2_ = null;
         if(this.fortificationProduceQueue != null)
         {
            var _loc6_:int = 0;
            var _loc7_:* = this.fortificationProduceQueue;
            for each(_loc1_ in _loc7_)
            {
               var _loc8_:int = 0;
               var _loc9_:* = _loc1_.allProduceQueueArray;
               for each(_loc2_ in _loc9_)
               {
                  this.logMsg("Abandon: Cancel fortification production " + _loc2_.num + " " + troopExtNames[_loc2_.type],COLR_ERR_LOG_MSG);
                  CityStateCommands.cancelFortificationProduce(this.castleId,_loc2_.queueId);
                  this.fortificationProductionUpdateNeeded = true;
               }
            }
         }
         _loc3_ = new Array(TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL,TFConstants.F_ARROWTOWER);
         _loc4_ = 0;
         for each(_loc4_ in _loc3_)
         {
            if(this.fortification[troopIntNames[_loc4_]] > 0)
            {
               this.logMsg("Abandon: Destroy " + this.fortification[troopIntNames[_loc4_]] + " " + troopExtNames[_loc4_],COLR_ERR_LOG_MSG);
               CityStateCommands.destructWallProtect(this.castleId,_loc4_,this.fortification[troopIntNames[_loc4_]]);
               break;
            }
         }
         if(this.troopProduceQueue != null)
         {
            for each(_loc1_ in this.troopProduceQueue)
            {
               _loc8_ = 0;
               _loc9_ = _loc1_.allProduceQueueArray;
               for each(_loc2_ in _loc9_)
               {
                  this.logMsg("Abandon: Cancel troop production " + _loc2_.num + " " + troopExtNames[_loc2_.type],COLR_ERR_LOG_MSG);
                  CityStateCommands.cancelTroopProduce(this.castleId,_loc1_.positionId,_loc2_.queueId);
                  this.troopProductionUpdateNeeded = true;
               }
            }
         }
         _loc5_ = new Array(TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_ARCHER,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE);
         for each(_loc4_ in _loc5_)
         {
            if(this.troop[troopIntNames[_loc4_]] > 0)
            {
               CityStateCommands.disbandTroop(this.castleId,_loc4_,this.troop[troopIntNames[_loc4_]]);
               this.logMsg("Abandon: Disband " + this.troop[troopIntNames[_loc4_]] + " " + troopExtNames[_loc4_],COLR_ERR_LOG_MSG);
               break;
            }
         }
      }
      
      public function getStarLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.gears.length)
         {
            if(this.gears[_loc2_].typeId == param1)
            {
               return this.gears[_loc2_].enhancedstarlv;
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function isBestHeroByType(param1:String, param2:HeroBean, param3:HeroBean) : Boolean
      {
         if(this.getCfg(CityConfigs.CFG_AUTOGEAR) <= 0)
         {
            return Utils.isBestHeroByType(param1,param2,param3);
         }
         return Utils.isBestHeroByTypeIncGear(param1,param2,param3);
      }
      
      private function updateTransingTrades(param1:TransingTradeUpdate) : void
      {
         var _loc2_:int = 0;
         if(param1.castleId != this.castleId)
         {
            return;
         }
         _loc2_ = 0;
         if(param1.updateType == 0)
         {
            this.transingTradesArray.addItem(param1.bean);
         }
         else if(param1.updateType == 1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.transingTradesArray.length)
            {
               if(this.transingTradesArray[_loc2_].id == param1.bean.id)
               {
                  this.transingTradesArray.removeItemAt(_loc2_);
                  return;
               }
               _loc2_++;
            }
         }
         else if(param1.updateType == 2)
         {
            _loc2_ = 0;
            while(_loc2_ < this.transingTradesArray.length)
            {
               if(this.transingTradesArray[_loc2_].id == param1.bean.id)
               {
                  this.transingTradesArray[_loc2_] = param1.bean;
                  return;
               }
               _loc2_++;
            }
         }
         else
         {
            this.logMsg("Unhandle transingTrade response " + param1.updateType);
         }
      }
      
      public function _clearLastAmbushErrorTime() : void
      {
         this.lastAmbushFromAllSideErrorTime = null;
      }
      
      private function onHeroDischargeResponse(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("hero discharge error: " + param1.errorMsg);
            return;
         }
      }
      
      private function setMaintownCastleId() : void
      {
         mainTownCastleId = this.castle.id;
      }
      
      private function _yb134(param1:int = 60) : Number
      {
         var _loc2_:int = 0;
         if(this.enemyArmies.length == 0)
         {
            return 0;
         }
         if(this.enemyArmies[this.enemyArmies.length - 1].reachTime < Utils.getServerTime())
         {
            return Utils.getServerTime() + 1000;
         }
         if(param1 <= 0)
         {
            param1 = 30;
         }
         if(param1 < 8)
         {
            param1 = 8;
         }
         _loc2_ = 0;
         while(_loc2_ < this.enemyArmies.length - 1)
         {
            if(this.enemyArmies[_loc2_].reachTime >= Utils.getServerTime() - 1000)
            {
               if(this.enemyArmies[_loc2_].reachTime + param1 * 1000 < this.enemyArmies[_loc2_ + 1].reachTime)
               {
                  return this.enemyArmies[_loc2_].reachTime + 1000;
               }
            }
            _loc2_++;
         }
         if(this.enemyArmies[this.enemyArmies.length - 1].reachTime < Utils.getServerTime() - 1000)
         {
            return 0;
         }
         return this.enemyArmies[this.enemyArmies.length - 1].reachTime + 1000;
      }
      
      public function get gateOpen() : Boolean
      {
         return this.goOutForBattle;
      }
      
      private function recallStaleEvasionArmies() : void
      {
         var evasionArmies:ArrayCollection = null;
         var army:ArmyBean = null;
         try
         {
            if(this.evasionFieldId == -1)
            {
               return;
            }
            evasionArmies = this.getLocalArmiesMarchingToLocWithReso(this.evasionFieldId);
            if(!Connection.getInstance().authenticated || Connection.getInstance().paused)
            {
               return;
            }
            if(this.maintenanceTime != -1)
            {
               return;
            }
            if(this.getLocalBuffByWildCardId("ForceopenclosegateBuff") != null && Math.abs(this.lastEnemyTime - Utils.getServerTime()) < 600 * 1000)
            {
               return;
            }
            for each(army in evasionArmies)
            {
               if(army.reachTime - Utils.getServerTime() < 30 * 1000 && this.cityTimingAllowed("recall" + army.armyId,30))
               {
                  this.logMsg("Recall run away evasion troop " + Utils.troopStrBeanToMsgString(army.troop,true));
                  CityStateCommands.callBackArmy(this.castleId,army.armyId);
               }
            }
            if(this.cityTimingAllowed("checkevasionfield",300))
            {
               Map.updateInfo(this.evasionFieldId);
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg("Error while handling: recallRunAwayEvasion, " + error.message + "\n" + error.getStackTrace());
            }
         }
      }
      
      public function _hd522() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:TradeBean = null;
         _loc1_ = false;
         for each(_loc2_ in this.tradesArray)
         {
            this.logMsg("Cancel trade " + resourceNames[_loc2_.resType] + " " + _loc2_.amount + "/" + _loc2_.dealedAmount + "@" + _loc2_.price);
            CityStateCommands.cancelTrade(this.castleId,_loc2_.id,this._og999);
            _loc1_ = true;
         }
         this.tradesArray.removeAll();
         if(_loc1_)
         {
            this.logMsg("All pending trades canceled");
            return;
         }
      }
      
      public function get zeroFoodArmies() : ArrayCollection
      {
         return this.getZeroFoodArmies();
      }
      
      private function deleteCityTiming(param1:String) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.cityTimingList)
         {
            if(_loc2_.indexOf(param1) == 0)
            {
               delete this.cityTimingList[_loc2_];
            }
         }
      }
      
      private function levelOkayForBuildnpc(param1:int, param2:int) : Boolean
      {
         if(param2 == 20)
         {
            return true;
         }
         if(param2 == 21)
         {
            return param1 <= 5;
         }
         if(param2 == 15)
         {
            return param1 == 5 || param1 == 10;
         }
         return param1 == param2;
      }
      
      private function researchListResponseHandler(param1:AvailableResearchListResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logMsg("research list response: " + param1.msg);
            return;
         }
         this.researches = param1.acailableResearchBeansArray;
      }
      
      private function _rd244() : CityCondition
      {
         var _loc1_:CityCondition = null;
         var _loc2_:int = 0;
         _loc1_ = null;
         _loc2_ = this.currRequirements.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this.currRequirements[_loc2_];
            if(!_loc1_.isBuilding)
            {
               if(this._mo519(_loc1_))
               {
                  this.currRequirements.removeItemAt(_loc2_);
               }
               else if(!this._ux814(_loc1_))
               {
                  if(this._it985(_loc1_))
                  {
                     if(this._dx690(_loc1_))
                     {
                        return _loc1_;
                     }
                  }
               }
            }
            _loc2_--;
         }
         return null;
      }
      
      private function _pr914(param1:TransingTradeListResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("get transing trade list response error " + param1.errorMsg);
            return;
         }
         this.transingTradesArray = param1.transingTradesArray;
      }
      
      public function _resetCMVariables() : void
      {
         var _loc1_:int = 0;
         this.buildingRequirements.removeAll();
         this.techRequirements.removeAll();
         this.fortificationsRequirements.removeAll();
         this.troopRequirements.removeAll();
         this.extraTroopFields = new Array();
         this.extraTroopExtConds = new Array();
         this.extraTroopIntConds = new Array();
         this.cityCfg.configs = new Object();
         this.autoItems = new Object();
         this.autoItems["count"] = 0;
         this.NPCBALLISTAS = new Array(0,20,50,170,250,550);
         this.reservedHeroes = null;
         this.notNpcHeroes = null;
         this.notFastKeepResoHeroes = null;
         this.npcHeroes = null;
         this.valleyHeroes = null;
         this.spamHeroes = null;
         this.notSpamHeroes = null;
         this.noUplevelHeroes = null;
         this.npcTroopBean = null;
         this.npcAvoidList = null;
         this.npcList = null;
         this.npcArea = null;
         this.npc10Heroes = null;
         this.npc10TroopBean = null;
         this.npc10List = null;
         this.npc10Area = null;
         this.npc10LimitTroopBean = null;
         this.priorityNpcSettings = new Array();
         this.valleyTroopBean = null;
         this.huntingLocation = -1;
         this.huntingType = null;
         this.resourceType = null;
         this.trainingHeroName = null;
         this.trainingLoopTime = -1;
         this.trainingHeroNextStop = -1;
         this.trainingHeroNeeded = true;
         this.slowHuntingPolicy = new Array(0,null,null,null,3);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this.defaultGateSettings[_loc1_] = GATE_AUTO;
            _loc1_++;
         }
         this.coloHints = new Array();
         this.condGateSettings = new Array();
         _loc1_ = 0;
         while(_loc1_ < this.distanceSettings.length)
         {
            this.distanceSettings[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.defaultRallySettings.length)
         {
            this.rallySettings[_loc1_] = -1;
            this.defaultRallySettings[_loc1_] = -1;
            this.warRallySettings[_loc1_] = -1;
            _loc1_++;
         }
         this.loginSchedule = null;
         this.wartownSchedule = null;
         this.tradingSchedule = null;
         this.resourceMinLimits = null;
         this.resourceMaxLimits = null;
         this.keepTroopFieldIds = new Array();
         this.keepTroopTroopBeans = new Array();
         this.keepTroopMinSents = new Array();
         this.keepTroopTotalFlags = new Array();
         this.keepResourceFieldIds = new Array();
         this.keepResourceMinResources = new Array();
         this.keepResourceMinSents = new Array();
         this.requestHelpFieldIds = new Array();
         this.requestResourceLocalConds = new Array();
         this.requestResourceRemoteConds = new Array();
         this.requestTroopLocalConds = new Array();
         this.requestTroopRemoteConds = new Array();
         this.requestHelpWarConds = new Array();
         this.condGateSettingsRE = new Array();
         this.condGateSettingsRE2 = new Array();
         this.skypeWarningReceiverList = new Array();
         this.skypeWarreportReceiverList = new Array();
         this.skypeWarningPolicy = new Array(true,false,false,true);
         this.wrAllianceIgnoreList = new Array();
         this.wrPlayerIgnoreList = new Array();
         this.enemyWarningAllianceIgnoreList = new Array();
         this.enemyWarningPlayerIgnoreList = new Array();
         this.advEvasionRules = new Array();
         this.advEvasionLastArmyID = 0;
         this.tmpAdvEvadeCache = null;
         this.tmpAdvEvadeRuleCache = null;
         this.vrGateSettingCache = null;
         this.vrGateSettingCacheArmyId = 0;
         this.embAllowedPlayers = new Array();
         this.embDeniedPlayers = new Array();
         this.varAllianceListDeny = new Array();
         this.varAllMembersList = new Array();
      }
      
      private function upgradeNeeds(param1:AvailableResearchListBean, param2:Object, param3:Object, param4:Object) : String
      {
         var _loc5_:* = null;
         var _loc6_:ConditionDependItemBean = null;
         if(param1.conditionBean == null)
         {
            return "";
         }
         _loc5_ = "\n\nRequired materials:";
         for each(_loc6_ in param1.conditionBean.itemsArray)
         {
            _loc5_ += "\n" + param3[_loc6_.id] + " - " + param2[_loc6_.id] + "/" + _loc6_.num;
         }
         _loc5_ += "\n\nRequired buildings:";
         _loc5_ = _loc5_ + ("\nWorkshop level " + param4[BuildingConstants.TYPE_WORKSHOP] + "/" + (param1.level + 1));
         if(param1.typeId == EquipmentTech.WEAPON_TECH || param1.typeId == EquipmentTech.SHIELD_TECH)
         {
            _loc5_ += "\nForge level " + param4[BuildingConstants.TYPE_BLACKSMITH] + "/" + (param1.level + 1);
         }
         else if(param1.typeId == EquipmentTech.MOUNTS_TECH)
         {
            _loc5_ += "\nForge level " + param4[BuildingConstants.TYPE_BLACKSMITH] + "/" + (param1.level + 1) + "\nStable level " + param4[BuildingConstants.TYPE_STABLE] + "/" + (param1.level + 1);
         }
         else if(param1.typeId == EquipmentTech.NECKLACE_TECH || param1.typeId == EquipmentTech.ACCESSORIES_TECH || param1.typeId == EquipmentTech.RING_TECH)
         {
            _loc5_ += "\nMarket level " + param4[BuildingConstants.TYPE_MARKET] + "/" + (param1.level + 1);
         }
         return _loc5_;
      }
      
      private function doAutoUseAdvByAHiddenPath(param1:Boolean) : void
      {
         var _loc2_:String = null;
         var _loc3_:ItemBean = null;
         _loc2_ = "Advance_by_a_Hidden_Path";
         _loc3_ = this.getItemFromName(_loc2_);
         if(_loc3_ == null || _loc3_.count <= 0)
         {
            return;
         }
         if(this.lastCounterAmbushTime != null && this.lastCounterAmbushTime.getTime() + 900 * 1000 > new Date().getTime())
         {
            return;
         }
         if(this.autoItems[_loc2_.toLowerCase()] == undefined)
         {
            return;
         }
         if(param1)
         {
            this.lastCounterAmbushTime = new Date();
            this.logMsg("AUTOUSEITEM > " + _loc2_ + " for defense!",COLR_DEF_LOG_MSG);
            ActionFactory.getInstance().getShopCommands().useTrickItem(this.castle.fieldId,0,Items.getItemId(_loc2_),this.useAdvByHiddenPathHandler);
         }
         else if(this.autoItems[_loc2_.toLowerCase()] == 1)
         {
            this.lastCounterAmbushTime = new Date();
            this.logMsg("AUTOUSEITEM > " + _loc2_ + " to counter ambush!",COLR_DEF_LOG_MSG);
            ActionFactory.getInstance().getShopCommands().useTrickItem(this.castle.fieldId,0,Items.getItemId(_loc2_),this.useAdvByHiddenPathHandler);
         }
      }
      
      private function getFieldIdFromCoordStr(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = int(param1.indexOf("("));
         _loc3_ = int(param1.indexOf(","));
         _loc4_ = int(param1.indexOf(")"));
         if(_loc2_ == -1 || _loc3_ == -1 || _loc4_ == -1)
         {
            return -1;
         }
         _loc5_ = int(param1.substring(_loc2_ + 1,_loc3_));
         _loc6_ = int(param1.substring(_loc3_ + 1,_loc4_));
         return Map.getFieldId(_loc5_,_loc6_);
      }
      
      public function _setGatePolicy(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(this.getCfg(CityConfigs.CFG_GATE) <= 0)
         {
            this.logMsg("Please set gatepolicy *after* setting gate config",COLR_STD_LOG_MSG);
            return false;
         }
         _loc2_ = param1.split(" ");
         if(_loc2_.length != 4 && _loc2_.length != 5)
         {
            this.logMsg("Usage: gatepolicy gate1 gate2 gate3 gate4 [gate5]",COLR_STD_LOG_MSG);
            return false;
         }
         if(_loc2_.length == 4)
         {
            _loc2_.push("0");
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(!this._vi518(_loc2_[_loc3_],0,4))
            {
               this.logMsg("Invalid gate value, expecting integer from 0 to 3, get: " + _loc2_[_loc3_],COLR_STD_LOG_MSG);
               return false;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            this.defaultGateSettings[_loc3_] = int(_loc2_[_loc3_]);
            _loc3_++;
         }
         this.vrGateSettingCache = null;
         this.vrGateSettingCacheArmyId = 0;
         this.doGateDefense();
         return true;
      }
      
      private function getAvailableRallyMaxHidingSlots() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ArrayCollection = null;
         if(this.getCfg(CityConfigs.CFG_HIDING) <= 0)
         {
            return 0;
         }
         _loc1_ = this.rallySettings[RALLY_HIDING] == -1 ? 1 : int(this.rallySettings[RALLY_HIDING]);
         if(this.evasionFieldId == -1)
         {
            return _loc1_;
         }
         _loc2_ = this.getLocalHidingArmies(this.evasionFieldId);
         if(_loc2_.length >= _loc1_)
         {
            return 0;
         }
         return _loc1_ - _loc2_.length;
      }
      
      private function doRequestHelpRI() : Boolean
      {
         var _loc4_:CityState = null;
         var _loc5_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc1_:Array = new Array();
         var _loc2_:CityManager = null;
         var _loc3_:int = 0;
         for each(_loc4_ in MainScreen.getCities())
         {
            _loc2_ = _loc4_.cityManager;
            _loc20_ = 0;
            while(_loc20_ < _loc2_.requestHelpFieldIds.length)
            {
               _loc3_ = int(_loc2_.requestHelpFieldIds[_loc20_]);
               if(_loc3_ == ANYCOORDINATE || _loc3_ == this.castle.fieldId)
               {
                  if(_loc1_.indexOf(_loc2_.castle.fieldId) == -1)
                  {
                     _loc1_.push(_loc2_.castle.fieldId);
                  }
               }
               _loc20_++;
            }
         }
         _loc5_ = this.rallySettings[RALLY_REQUESTHELP] == -1 ? 2 : int(this.rallySettings[RALLY_REQUESTHELP]);
         if(this._de1078(_loc1_,ObjConstants.ARMY_MISSION_SEND) >= _loc5_)
         {
            return false;
         }
         var _loc6_:Array = new Array(TFConstants.T_ARCHER,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_SCOUTER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_MILITIA,TFConstants.T_PEASANTS,TFConstants.T_CARRIAGE,TFConstants.T_BALLISTA,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
         var _loc7_:int = this.getRallyDispatchPerArmyLimit(true);
         var _loc8_:Array = Utils.randOrder(MainScreen.getCities().length);
         var _loc9_:Boolean = false;
         var _loc10_:TroopBean = null;
         var _loc11_:TroopBean = null;
         var _loc12_:TroopBean = null;
         var _loc13_:NewArmyParam = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Boolean = false;
         var _loc17_:int = 0;
         var _loc18_:String = null;
         var _loc19_:int = 0;
         loop2:
         for(; _loc19_ < _loc8_.length; _loc19_++)
         {
            _loc2_ = MainScreen.getCities()[_loc8_[_loc19_]].cityManager;
            if(this != _loc2_)
            {
               _loc20_ = 0;
               while(true)
               {
                  if(_loc20_ >= _loc2_.requestHelpFieldIds.length)
                  {
                     continue loop2;
                  }
                  _loc9_ = Boolean(_loc2_.requestHelpWarConds[_loc20_]);
                  if(!((_loc9_) && !_loc2_.isLastEnemyTimeLessThan1Hr()))
                  {
                     if(!(_loc9_ && this.isLastEnemyTimeLessThan1Hr()))
                     {
                        if(_loc2_.getLocalBuffByWildCardId("ForceopenclosegateBuff") == null)
                        {
                           _loc3_ = int(_loc2_.requestHelpFieldIds[_loc20_]);
                           _loc10_ = _loc2_.requestTroopLocalConds[_loc20_];
                           _loc11_ = _loc2_.requestTroopRemoteConds[_loc20_];
                           if(_loc3_ == ANYCOORDINATE || _loc3_ == this.castle.fieldId)
                           {
                              _loc12_ = _loc2_.getAllTroopsInCastle();
                              _loc13_ = new NewArmyParam();
                              _loc13_.missionType = ObjConstants.ARMY_MISSION_SEND;
                              _loc13_.troops = new TroopBean();
                              _loc13_.resource = new ResourceBean();
                              _loc13_.targetPoint = _loc2_.castle.fieldId;
                              _loc14_ = _loc7_;
                              _loc15_ = 0;
                              _loc16_ = false;
                              for each(_loc21_ in _loc6_)
                              {
                                 if(_loc14_ == 0)
                                 {
                                    break;
                                 }
                                 _loc18_ = troopIntNames[_loc21_];
                                 if(!(_loc12_[_loc18_] >= _loc10_[_loc18_] || this.troop[_loc18_] <= _loc11_[_loc18_]))
                                 {
                                    _loc17_ = Math.min(_loc14_,_loc10_[_loc18_] - _loc12_[_loc18_],this.troop[_loc18_] - _loc11_[_loc18_]);
                                    if(_loc17_ >= requestHelpFullFactor * _loc10_[_loc18_])
                                    {
                                       _loc16_ = true;
                                    }
                                    _loc13_.troops[_loc18_] = _loc17_;
                                    _loc14_ -= _loc17_;
                                    _loc15_ += _loc17_;
                                 }
                              }
                              if(_loc15_ >= requestHelpFullFactor * _loc7_)
                              {
                                 _loc16_ = true;
                              }
                              if(_loc16_ && _loc15_ > 0 && _loc15_ <= _loc7_)
                              {
                                 _loc13_.resource.food = Math.min(this.getMaxTroopLoad(_loc13_.troops) * 0.9,this.getTroopFoodValue(_loc13_.troops) * 5);
                                 Utils.trimDecimalFromResoAmounts(_loc13_.resource);
                                 if(this.isEnoughResourcesToMarch(_loc13_))
                                 {
                                    if(playerTimingAllowed("troophelp" + _loc2_.castle.fieldId,1 * 60))
                                    {
                                       break;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
                  _loc20_++;
               }
               this.logMsg("REQUESTHELP > Moving troops to help " + _loc2_.castle.name + ": " + Utils.troopBeanToString(_loc13_.troops) + ", arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc13_)),COLR_STD_LOG_MSG);
               CityStateCommands.newArmy(this.castleId,_loc13_,this.handleArmyCommandResponse);
               this.adjEstFoodAfterMarch(_loc13_);
               return true;
            }
         }
         return false;
      }
      
      private function isResoBeanEmtpy(param1:ResourceBean) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         return param1.gold == 0 && param1.food == 0 && param1.wood == 0 && param1.stone == 0 && param1.iron == 0;
      }
      
      private function _uc804() : Boolean
      {
         var _loc1_:Connection = null;
         if(this.loginSchedule == null)
         {
            return false;
         }
         if(!playerTimingAllowed("handleloginschedule",37))
         {
            return false;
         }
         if(playerTimingAllowed("modifyloginschedule",24 * 3600))
         {
            this._ti267(this.loginSchedule);
         }
         _loc1_ = Connection.getInstance();
         if(this._fg739())
         {
            if(MainScreen.getInstance().unpauseTimerIsRunning)
            {
               if(playerTimingAllowed("loginscheduleinterrupted",300))
               {
                  this.logMsg("SchedulePolicy > Interrupted by relogin/pause timer");
               }
               return false;
            }
            if(!_loc1_.authenticated)
            {
               this.logMsg("SchedulePolicy > Connect to server");
               _loc1_.reconnectTimer.delay = 30000;
               _loc1_.reconnectTimer.start();
            }
            _loc1_.paused = false;
         }
         else
         {
            if(_loc1_.authenticated)
            {
               this.logMsg("SchedulePolicy > Disconnect from server");
               _loc1_.reconnectTimer.stop();
               _loc1_.disconnect();
               playerTimingAllowed("loginscheduledisc",0);
            }
            else if(playerTimingAllowed("loginscheduledisc",1800))
            {
               this.logMsg("SchedulePolicy > Offline time");
            }
            _loc1_.paused = true;
         }
         return false;
      }
      
      public function _setEmptyCondGateSettings() : Array
      {
         this.condGateSettings = new Array();
         return this.condGateSettings;
      }
      
      private function zeroFoodNewArmyHandler(param1:Object) : void
      {
         var handler:Function = null;
         var response:Object = param1;
         if(response.ok != 1)
         {
            handler = function(param1:Object):void
            {
               this.zeroFoodErrorFactor = 0.1;
               this.newZeroFoodArmy(1);
            };
            this.logErrMsg("ZEROFOOD > army command response error " + response.ok + ": " + response.errorMsg);
            this.lastZeroFoodError = Utils.getServerTime();
            CityStateCommands.modifyTaxRate(this.castleId,this.resource.texRate,handler);
            return;
         }
      }
      
      public function _wb316(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(this.getCfg(CityConfigs.CFG_GATE) <= 0)
         {
            this.logMsg("Please set condgatepolicy *after* setting gate config");
            return false;
         }
         _loc2_ = param1.split(" ");
         if(_loc2_.length != 6 && _loc2_.length != 7)
         {
            this.logMsg("Usage: condgatepolicy troopCond fortCond gate1 gate2 gate3 gate4 [gate5]");
            return false;
         }
         if(_loc2_.length == 6)
         {
            _loc2_.push("0");
         }
         _loc3_ = Utils.getTroops(_loc2_[0]);
         if(_loc2_[0] != "none" && _loc3_ == null)
         {
            this.logMsg("Invalid troop condition: " + _loc2_[0]);
            return false;
         }
         _loc4_ = Utils.getFortifications(_loc2_[1]);
         if(_loc2_[1] != "none" && _loc4_ == null)
         {
            this.logMsg("Invalid fortification condition: " + _loc2_[1]);
            return false;
         }
         _loc5_ = 2;
         while(_loc5_ < 7)
         {
            if(!this._vi518(_loc2_[_loc5_],0,4))
            {
               this.logMsg("Invalid gate value, expecting integer from 0 to 3, get: " + _loc2_[_loc5_]);
               return false;
            }
            _loc5_++;
         }
         _loc6_ = new Array(_loc3_,_loc4_,new Array(int(_loc2_[2]),int(_loc2_[3]),int(_loc2_[4]),int(_loc2_[5]),int(_loc2_[6])));
         this.condGateSettings.push(_loc6_);
         this.vrGateSettingCache = null;
         this.vrGateSettingCacheArmyId = 0;
         return true;
      }
      
      public function _mi1194(param1:int) : void
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.localArmies)
         {
            if((param1 == -1 || _loc2_.targetFieldId == param1) && _loc2_.direction != ArmyConstants.ARMY_BACKWARD)
            {
               this.logMsg("Recall troop to " + Map.fieldIdToString(_loc2_.targetFieldId) + ", id: " + _loc2_.armyId);
               CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
            }
         }
      }
      
      public function isJunkTroop(param1:TroopStrBean) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = Utils.getTotalTroopCount(Utils.getTroopBeanFromTroopStrBean(param1));
         return _loc2_ <= this.getCfg(CityConfigs.CFG_JUNKWAVE) && _loc2_ > 0;
      }
      
      private function getTotalWallSlotsUsed() : int
      {
         var _loc1_:FortificationsBean = null;
         _loc1_ = this.getFortificationsInProduction();
         return this.fortification.trap + _loc1_.trap + 2 * (this.fortification.abatis + _loc1_.abatis) + 3 * (this.fortification.arrowTower + _loc1_.arrowTower) + 4 * (this.fortification.rollingLogs + _loc1_.rollingLogs) + 5 * (this.fortification.rockfall + _loc1_.rockfall);
      }
      
      public function isEnoughResourcesToMarch(param1:NewArmyParam) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in resourceIntNames)
         {
            if(this.estResource[_loc2_] < param1.resource[_loc2_])
            {
               return false;
            }
         }
         return this.estResource.food >= param1.resource.food + this.getFoodNeededToMarch(param1,true);
      }
      
      private function doSearchForUnoccupiedFlatFields() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MapCastleBean = null;
         var _loc3_:int = 0;
         if(this.getCfg(CityConfigs.CFG_BUILDNPC) <= 0)
         {
            return;
         }
         if(this.candidateFlatFields == null || this.candidateFlatFields.length == 0)
         {
            return;
         }
         _loc1_ = 100;
         if(this.flatFieldsDetailInfo != null && this.flatFieldsDetailInfo.length >= _loc1_)
         {
            return;
         }
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < this.candidateFlatFields.length)
         {
            _loc2_ = Map.getDetail(this.candidateFlatFields[_loc3_]);
            if(_loc2_ == null)
            {
               return;
            }
            if(_loc2_.userName == null)
            {
               this.flatFieldsDetailInfo.addItem(_loc2_);
            }
            this.candidateFlatFields.splice(_loc3_,1);
            _loc3_--;
            if(this.flatFieldsDetailInfo.length >= _loc1_)
            {
               return;
            }
            _loc3_++;
         }
      }
      
      private function getHeroForNpc10() : HeroBean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:HeroBean = null;
         if(this.npc10Heroes != null)
         {
            return this._us376(this.npc10Heroes);
         }
         _loc1_ = this.trainingHeroNeeded ? this.getBestIdleTrainingHero() : null;
         _loc2_ = this.bestAttackHero();
         if(_loc2_ == null)
         {
            return null;
         }
         if(_loc1_ == _loc2_)
         {
            return null;
         }
         if(_loc2_.stamina < this.getMinEnergyCfg())
         {
            return null;
         }
         if(_loc2_.status == HeroConstants.HERO_FREE_STATU && _loc2_.id != this.lastPromoteId)
         {
            return _loc2_;
         }
         return null;
      }
      
      private function doJunkHero() : void
      {
         var _loc1_:ArrayCollection = null;
         var _loc2_:ArrayCollection = null;
         var _loc3_:Boolean = false;
         var _loc4_:HeroBean = null;
         var _loc5_:HeroBean = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.getCfg(CityConfigs.CFG_HERO) < 10 || this.getCfg(CityConfigs.CFG_JUNKHERO) < 1)
         {
            return;
         }
         if(this.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) - this.getAdjFHReservedValue() > this.heroes.length + (this.trainingHeroName != null && !isNameRoyal(this.trainingHeroName) && !this.isTrainingHeroInTown() ? 1 : 0) - this.specialHeroCount)
         {
            return;
         }
         _loc1_ = this.getReservedHeroes();
         _loc2_ = new ArrayCollection();
         _loc3_ = false;
         _loc4_ = null;
         for each(_loc5_ in this.heroes)
         {
            _loc3_ = false;
            for each(_loc4_ in _loc1_)
            {
               if(_loc5_.id == _loc4_.id)
               {
                  _loc3_ = true;
               }
            }
            if(!_loc3_)
            {
               _loc2_.addItem(_loc5_);
            }
         }
         _loc6_ = 0;
         _loc7_ = 80;
         for each(_loc5_ in _loc2_)
         {
            if(!(_loc5_.ability > 0 || _loc5_.isHero > 0))
            {
               if(!(_loc5_.stamina >= this.getMinEnergyCfg() + 4 || _loc5_.status != HeroConstants.HERO_FREE_STATU))
               {
                  if(!(_loc5_.power - _loc5_.level + _loc5_.remainPoint >= _loc7_ || _loc5_.stratagem - _loc5_.level + _loc5_.remainPoint >= _loc7_ || _loc5_.management - _loc5_.level + _loc5_.remainPoint >= _loc7_))
                  {
                     _loc6_ = 0;
                     for each(_loc4_ in _loc2_)
                     {
                        if(Utils.isBestHeroByType("power",_loc5_,_loc4_))
                        {
                           _loc6_++;
                        }
                     }
                     if(_loc6_ < this.getCfg(CityConfigs.CFG_JUNKHERO))
                     {
                        this.logMsg("JUNKHERO > firing junk hero with low energy " + Utils.heroBeanToString(_loc5_),COLR_STD_LOG_MSG);
                        CityStateCommands.fireHero(this.castleId,_loc5_.id,this.onFireHeroResponse);
                     }
                  }
               }
            }
         }
      }
      
      public function _setWrIgnoreList(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(!this.isMainTown())
         {
            this.logMsg("*** WARNING: The warreportignorelist goal has no effect if the city is not maintown, ignoring the goal ***",COLR_WRN_LOG_MSG);
            return true;
         }
         _loc2_ = Utils.trim(param1).split(",");
         if(_loc2_.length > 0)
         {
            _loc3_ = null;
            for each(_loc4_ in _loc2_)
            {
               _loc3_ = _loc4_.split(":");
               if(_loc3_[0].substr(0,1) == "a")
               {
                  this.wrAllianceIgnoreList.push(_loc3_[1]);
               }
               else
               {
                  if(_loc3_[0].substr(0,1) != "p")
                  {
                     this.logMsg("*** ERROR: The warreportignorelist goal has encountered an invalid type of " + _loc3_[0] + " or is formatted incorrectly. Valid types are <b>a</b>roup or <b>p</b>layer ***",COLR_ERR_LOG_MSG);
                     this.skypeWarreportReceiverList = new Array();
                     return false;
                  }
                  this.wrPlayerIgnoreList.push(_loc3_[1]);
               }
            }
            if(this.wrAllianceIgnoreList.length == 0 && this.wrPlayerIgnoreList.length == 0)
            {
               this.logMsg("*** ERROR: The warreportignorelist goal has no discernible list of players/alliances or is formatted incorrectly ***",COLR_ERR_LOG_MSG);
               return false;
            }
            return true;
         }
         this.logMsg("*** WARNING: The warreportignorelist goal has no list of players/alliances, ignoring the goal ***",COLR_WRN_LOG_MSG);
         return true;
      }
      
      private function _xn1058() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:MapCastleBean = null;
         var _loc4_:int = 0;
         var _loc5_:ArmyBean = null;
         _loc1_ = NaN;
         _loc2_ = NaN;
         _loc3_ = null;
         _loc4_ = 0;
         for each(_loc5_ in this.localArmies)
         {
            if(this.lastResourceFieldLevels[_loc5_.targetFieldId] != undefined && _loc5_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc5_.direction == ArmyConstants.ARMY_FORWARD)
            {
               _loc1_ = _loc5_.reachTime - Utils.getServerTime();
               _loc2_ = Math.max(30,Math.min(15 * 60,_loc1_ / 1000 * 0.8));
               _loc3_ = Map.getDetail(_loc5_.targetFieldId,_loc2_);
               _loc4_ = Map.getLevel(_loc5_.targetFieldId,_loc2_);
               if(_loc4_ != -1 && _loc4_ != this.lastResourceFieldLevels[_loc5_.targetFieldId] || _loc3_ != null && _loc3_.userName != null)
               {
                  this.logMsg("VALLEY > Local target field changed, recall troop " + _loc5_.armyId + " toward " + Map.fieldIdToString(_loc5_.targetFieldId),COLR_STD_LOG_MSG);
                  CityStateCommands.callBackArmy(this.castle.id,_loc5_.armyId);
                  delete this.lastResourceFieldLevels[_loc5_.targetFieldId];
               }
            }
         }
      }
      
      private function _yq761(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("hero add point error: " + param1.errorMsg);
            return;
         }
      }
      
      private function futureTechCondition() : CityCondition
      {
         var _loc1_:AvailableResearchListBean = null;
         var _loc2_:CityCondition = null;
         var _loc3_:Number = NaN;
         var _loc4_:CityCondition = null;
         var _loc5_:ConditionBean = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         _loc1_ = this.getResearchInProgress();
         if(_loc1_ != null && _loc1_.endTime - Utils.getServerTime() > 3 * 3600 * 1000)
         {
            return null;
         }
         _loc2_ = null;
         _loc3_ = 100000000;
         _loc4_ = null;
         _loc5_ = null;
         _loc6_ = 0;
         _loc7_ = this.currRequirements.length - 1;
         while(_loc7_ >= 0)
         {
            _loc4_ = this.currRequirements[_loc7_];
            if(!_loc4_.isBuilding)
            {
               if(!this._ux814(_loc4_))
               {
                  if(this._mo519(_loc4_))
                  {
                     this.currRequirements.removeItemAt(_loc7_);
                  }
                  else if(this._it985(_loc4_))
                  {
                     _loc5_ = this.getConditionBeanForUpgradingTo(_loc4_);
                     if(_loc5_ != null)
                     {
                        _loc6_ = Math.max(_loc5_.food,_loc5_.gold,_loc5_.wood,_loc5_.stone,_loc5_.iron);
                        if(_loc6_ < _loc3_)
                        {
                           _loc3_ = _loc6_;
                           _loc2_ = _loc4_;
                        }
                     }
                  }
               }
            }
            _loc7_--;
         }
         return _loc2_;
      }
      
      private function _fx1070(param1:NewArmyParam, param2:Number = -1) : void
      {
         var armies:ArrayCollection = null;
         var mustOpen:Boolean = false;
         var found:Boolean = false;
         var t:TroopBean = null;
         var army:ArmyBean = null;
         var evasionEndTime:Number = NaN;
         var maxTravelTime:int = 0;
         var newArmy:NewArmyParam = param1;
         var startTime:Number = param2;
         try
         {
            if(this.evasionFieldId == -1)
            {
               return;
            }
            armies = this.getLocalArmiesMarchingToLocWithReso(this.evasionFieldId);
            if(armies.length <= 0)
            {
               return;
            }
            if(!Connection.getInstance().authenticated || Connection.getInstance().paused)
            {
               Utils.callLater(10000,this._fx1070,[newArmy,startTime]);
               return;
            }
            if(this.maintenanceTime != -1)
            {
               return;
            }
            if(this.getLocalBuffByWildCardId("ForceopenclosegateBuff") != null && Math.abs(this.lastEnemyTime - Utils.getServerTime()) < 600 * 1000)
            {
               return;
            }
            if(newArmy != null)
            {
               evasionEndTime = this._yb134(this.getCfg(CityConfigs.CFG_ATTACKGAP));
               if(evasionEndTime != 0 && evasionEndTime - Utils.getServerTime() > -3000 && evasionEndTime - Utils.getServerTime() < 5000)
               {
                  maxTravelTime = this.getTravelTimeReliefStationAdj(newArmy) / MAXHEROSPEEDBONUS * this.getArmySpeedChangeBuffsFactor();
                  if(startTime != -1 && Utils.getServerTime() < startTime + maxTravelTime * 1000 - 60 * 1000)
                  {
                     Utils.callLater(5000,this._fx1070,[newArmy,startTime]);
                     return;
                  }
               }
            }
            mustOpen = this.getLocalBuffByWildCardId("ForceopenclosegateBuff") != null;
            if(mustOpen && Utils.getTotalTroopCount(this.troop) < 200000)
            {
               return;
            }
            found = false;
            t = null;
            for each(army in armies)
            {
               t = Utils.getTroopBeanFromTroopStrBean(army.troop);
               if(Utils.getTotalTroopCount(t) == t.carriage + t.ballista)
               {
                  if(!(newArmy == null && !this.cityTimingAllowed("recall" + army.armyId,30)))
                  {
                     if(!(newArmy == null && Math.abs(army.startTime + army.reachTime - 2 * Utils.getServerTime()) < 20 * 1000))
                     {
                        if(newArmy == null || _xv999(newArmy,army) && Math.abs(army.startTime - startTime) < 1000 * this.getCfg(CityConfigs.CFG_HIDING) || army.startTime < Utils.getServerTime() + 1000 * this.getCfg(CityConfigs.CFG_HIDING) + 300000)
                        {
                           this.logMsg("Recall evasion troop " + Utils.troopStrBeanToMsgString(army.troop,true),COLR_STD_LOG_MSG);
                           CityStateCommands.callBackArmy(this.castleId,army.armyId);
                           found = true;
                        }
                     }
                  }
               }
            }
            if(this.cityTimingAllowed("checkevasionfield",300))
            {
               Map.updateInfo(this.evasionFieldId);
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: stopEvasion, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      public function _handleStarLevelResponse(param1:GemstoneRespone) : void
      {
         var _loc2_:int = 0;
         if(param1.ok != 1)
         {
            this.logMsg("star update response error: " + param1.errorMsg);
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this.gears.length)
         {
            if(param1.equipmenttechid == this.gears[_loc2_].typeId)
            {
               this.gears[_loc2_].enhancedstarlv = param1.enhancedstarlv;
               break;
            }
            _loc2_++;
         }
      }
      
      public function getProductionRate() : int
      {
         return this.productionRate;
      }
      
      public function get allTroop() : TroopBean
      {
         return this.getAllTroopsInCastle();
      }
      
      private function _cj1106() : Boolean
      {
         return this.estResource.food > 25000 && this.estResource.wood > 30000 && this.estResource.iron > 18000;
      }
      
      public function _ap1008(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.valleyHeroes = _loc2_;
      }
      
      private function setProductionRate(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.resource.food.workPeople + this.resource.wood.workPeople + this.resource.stone.workPeople + this.resource.iron.workPeople;
         if(_loc2_ <= 0)
         {
            return;
         }
         if(this.productionRate == -1)
         {
            this.productionRate = this.estResource.workPeople * 100 / _loc2_;
         }
         param1 = Math.min(param1,this.estResource.curPopulation - this._as536());
         _loc3_ = this.productionRate;
         if(param1 > 0)
         {
            this.productionRate = (this.estResource.curPopulation - param1) * 100 / _loc2_;
            this.productionRate = int(this.productionRate / 5) * 5;
            if(this.productionRate < 0)
            {
               this.productionRate = 0;
            }
            if(this.productionRate > 100)
            {
               this.productionRate = 100;
            }
         }
         else
         {
            this.productionRate = 100;
         }
         if(_loc3_ != this.productionRate)
         {
            this.logMsg("set production rate: " + this.productionRate,COLR_STD_LOG_MSG);
            CityStateCommands.modifyCommenceRate(this.castleId,this.productionRate,this.productionRate,this.productionRate,this.productionRate);
            this.estResource.workPeople = _loc2_ * this.productionRate / 100;
         }
      }
      
      private function _mo1252() : void
      {
         var _loc1_:CityState = null;
         for each(_loc1_ in MainScreen.getCities())
         {
            _loc1_.cityManager._we267();
         }
      }
      
      private function _ka930() : Array
      {
         var _loc2_:Array = null;
         var _loc4_:HeroBean = null;
         var _loc6_:HeroBean = null;
         var _loc7_:HeroBean = null;
         var _loc8_:Number = NaN;
         var _loc9_:HeroBean = null;
         var _loc10_:HeroBean = null;
         var _loc11_:HeroBean = null;
         var _loc12_:HeroBean = null;
         var _loc13_:HeroBean = null;
         var _loc14_:Array = null;
         var _loc15_:HeroBean = null;
         var _loc16_:AvailableResearchListBean = null;
         if(this.npcHeroes != null)
         {
            return this._tr707(this.npcHeroes);
         }
         var _loc1_:String = "power";
         _loc2_ = new Array();
         var _loc3_:Number = this.getCfg(CityConfigs.CFG_HERO);
         _loc4_ = this.bestPoliticHero();
         var _loc5_:HeroBean = this.getCfg(CityConfigs.CFG_RESEARCH) > 0 && this.getCfg(CityConfigs.CFG_HERO) % 10 > 0 ? this.bestIntelHero() : null;
         _loc6_ = this.isNextTrainingHeroStop() || this.trainingHeroNeeded ? this.getBestIdleTrainingHero() : null;
         _loc7_ = this.getWorstRegularHero();
         _loc8_ = this.getCfg(CityConfigs.CFG_FASTHERO);
         if(_loc8_ <= 60)
         {
            _loc8_ = 60;
         }
         _loc9_ = this.getIdleHeroByTypePowerNotMayor(this.getMayor());
         _loc10_ = this._rd325();
         _loc11_ = null;
         if(_loc10_ == _loc9_)
         {
            if(_loc10_ != null && (Utils.isHeroMaxLvl(_loc10_) || _loc10_.status == HeroConstants.HERO_FREE_STATU && _loc10_.stamina < this.getMinEnergyCfg()))
            {
               _loc11_ = _loc10_;
            }
            else
            {
               _loc11_ = this.getIdleHeroByTypePowerNotMayor(_loc10_);
               if(_loc11_ == null)
               {
                  return null;
               }
            }
         }
         else
         {
            _loc11_ = _loc9_;
         }
         if(_loc11_ != null && this.isNextTrainingHeroStop() && _loc11_.name.toLowerCase() == this.trainingHeroName.toLowerCase())
         {
            _loc11_ = this.getIdleHeroByTypePowerNotMayor(_loc11_);
            if(_loc11_ == null)
            {
               return null;
            }
         }
         _loc12_ = this.bestPoliticHero();
         _loc13_ = null;
         if(this.getCfg(CityConfigs.CFG_RESEARCH) > 0)
         {
            _loc16_ = this.getResearchInProgress();
            if(_loc16_ == null || _loc16_.endTime < Utils.getServerTime() + 7200 * 1000)
            {
               _loc13_ = this.bestIntelHero();
            }
         }
         _loc14_ = this.notNpcHeroes == null ? null : this.getAvailableHeroNamesFromHeroListStr(this.notNpcHeroes);
         for each(_loc15_ in this.heroes)
         {
            if(!(_loc15_ == _loc4_ || _loc15_ == _loc7_ || _loc15_ == _loc11_ || _loc15_ == _loc12_ || _loc15_ == _loc13_ || _loc15_ == _loc6_ || _loc15_.id == this.lastPromoteId))
            {
               if(_loc15_.stamina >= this.getMinEnergyCfg())
               {
                  if(_loc15_.status == HeroConstants.HERO_FREE_STATU)
                  {
                     if(!(_loc14_ != null && _loc14_.indexOf(_loc15_.name.toLowerCase()) != -1))
                     {
                        _loc2_.push(_loc15_);
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function procedureToQueueTroops() : Boolean
      {
         var _loc9_:AllProduceBean = null;
         var _loc10_:AllProduceBean = null;
         var _loc17_:TroopBean = null;
         var _loc18_:ConditionBean = null;
         var _loc19_:String = null;
         var _loc30_:Array = null;
         var _loc31_:int = 0;
         var _loc32_:Array = null;
         if(this.researches == null)
         {
            return false;
         }
         if(this.troopProduceQueue == null)
         {
            return false;
         }
         if(this.troopRequirement == null)
         {
            return false;
         }
         var _loc1_:Boolean = this._bf968();
         var _loc2_:Boolean = this._cj1106();
         if(!this.isLastEnemyTimeLessThan1Hr() && !this._td369() && !_loc1_)
         {
            if(this.getCfg(CityConfigs.CFG_DEBUG) > 0 && this.cityTimingAllowed("resourcefortroop",300))
            {
               this.logMsg("Not enough resource for troop production");
            }
            return false;
         }
         var _loc3_:ProduceBean = null;
         var _loc4_:BuildingBean = this.getHighestLevelBarrack();
         var _loc5_:TroopBean = new TroopBean();
         var _loc6_:TroopBean = this.getAllTroopsInCastle();
         var _loc7_:Number = Utils.getServerTime();
         var _loc8_:Number = -1;
         for each(_loc9_ in this.troopProduceQueue)
         {
            _loc8_ = -1;
            for each(_loc3_ in _loc9_.allProduceQueueArray)
            {
               if(_loc8_ != -1)
               {
                  _loc8_ += _loc3_.costTime * 1000;
               }
               else
               {
                  _loc8_ = _loc3_.endTime;
               }
               if(_loc8_ >= _loc7_ + 1000)
               {
                  _loc6_[troopIntNames[_loc3_.type]] += _loc3_.num;
               }
            }
         }
         _loc10_ = null;
         if(_loc4_ != null)
         {
            _loc10_ = this.getBarrackQueueFromBuildingBean(_loc4_);
            if(_loc10_ != null)
            {
               _loc8_ = -1;
               for each(_loc3_ in _loc10_.allProduceQueueArray)
               {
                  if(_loc8_ != -1)
                  {
                     _loc8_ += _loc3_.costTime * 1000;
                  }
                  else
                  {
                     _loc8_ = _loc3_.endTime;
                  }
                  if(_loc8_ >= _loc7_ + 1000)
                  {
                     if(_loc3_.num > 1)
                     {
                        break;
                     }
                     _loc5_[troopIntNames[_loc3_.type]] += _loc3_.num;
                  }
               }
            }
         }
         var _loc11_:Boolean = false;
         var _loc12_:Array = new Array(TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CATAPULT,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER);
         var _loc13_:Array = new Array(TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE);
         var _loc14_:Array = _loc1_ ? _loc12_ : _loc13_;
         var _loc15_:int = 0;
         var _loc16_:TroopBean = new TroopBean();
         for each(_loc17_ in this.troopRequirements)
         {
            for each(_loc15_ in _loc12_)
            {
               _loc16_[troopIntNames[_loc15_]] = Math.max(_loc16_[troopIntNames[_loc15_]],_loc17_[troopIntNames[_loc15_]]);
            }
            if(_loc17_ == this.troopRequirement)
            {
               break;
            }
         }
         _loc18_ = null;
         _loc19_ = null;
         if(this.enemyArmies.length > 0 && this.enemyArmies[0].reachTime - Utils.getServerTime() < 3600 * 1000 && !this.isJunkTroop(this.enemyArmies[0].troop) && _loc4_ != null && _loc10_ != null)
         {
            _loc31_ = _loc4_.level - _loc10_.allProduceQueueArray.length;
            _loc32_ = new Array(TFConstants.T_MILITIA,TFConstants.T_PEASANTS,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_CARRIAGE,TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CATAPULT);
            for each(_loc15_ in _loc32_)
            {
               _loc18_ = this._mb759(_loc15_);
               if(_loc18_ != null)
               {
                  if(this.troop[troopIntNames[_loc15_]] + _loc5_[troopIntNames[_loc15_]] == 0 && _loc16_[troopIntNames[_loc15_]] > 0 && this._cx1101(_loc15_,_loc4_.level,1))
                  {
                     if(!_loc11_)
                     {
                        _loc11_ = true;
                        if(_loc10_ != null)
                        {
                           _loc31_ += this._ej311(_loc10_,_loc15_);
                        }
                        if(this.estResource.curPopulation - this.estResource.workPeople < 50)
                        {
                           this.setProductionRate(this.estResource.curPopulation);
                        }
                        this.promoteBestAtkHero();
                     }
                     if(_loc31_ <= 0)
                     {
                        break;
                     }
                     CityStateCommands.produceTroop(this.castleId,_loc4_.positionId,_loc15_,1,false,false,this._ap1065);
                     for each(_loc19_ in resourceIntNames)
                     {
                        this.estResource[_loc19_] -= _loc18_[_loc19_] * 1;
                     }
                     this.estResource.curPopulation -= troopPopulations[_loc15_];
                     _loc31_--;
                     break;
                  }
               }
            }
            if(_loc11_)
            {
               if(!this.cityTimingAllowed("fillAllowed",30))
               {
                  return true;
               }
               while(_loc31_ > 0 && this._cx1101(_loc15_,_loc4_.level,1))
               {
                  _loc15_ = this.troop.militia == 0 && _loc16_.militia > 0 ? TFConstants.T_MILITIA : (this.troop.peasants == 0 && _loc16_.peasants > 0 ? TFConstants.T_PEASANTS : (this.troop.swordsmen == 0 && _loc16_.swordsmen > 0 ? TFConstants.T_SWORDSMEN : (this.troop.pikemen == 0 && _loc16_.pikemen > 0 ? TFConstants.T_PIKEMAN : -1)));
                  if(_loc15_ == -1)
                  {
                     return true;
                  }
                  _loc18_ = this._mb759(_loc15_);
                  _loc16_[troopIntNames[_loc15_]] = 0;
                  _loc31_--;
                  CityStateCommands.produceTroop(this.castleId,_loc4_.positionId,_loc15_,1,false,false,this._ap1065);
                  for each(_loc19_ in resourceIntNames)
                  {
                     this.estResource[_loc19_] -= _loc18_[_loc19_] * 1;
                  }
                  this.estResource.curPopulation -= troopPopulations[_loc15_];
               }
               return true;
            }
         }
         var _loc20_:int = this._mp684(2,this.getCfg(CityConfigs.CFG_DUMPINGMAX) >= 1 ? 3600 : 900);
         if(_loc20_ == 0)
         {
            return false;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_POPULATION)
         {
            this.logMsg("est population: " + this.estResource.curPopulation + ", est worker: " + this.estResource.workPeople);
         }
         var _loc21_:BuildingBean = null;
         var _loc22_:AllProduceBean = null;
         var _loc23_:int = 0;
         var _loc24_:HeroBean = this.getBestIdleAttackHeroByStaminaIncGear(0);
         var _loc25_:int = _loc24_ != null ? int(Utils.getMaxStatValueByType(_loc24_,"power")) : 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         for each(_loc15_ in _loc14_)
         {
            if(_loc6_[troopIntNames[_loc15_]] < this.troopRequirement[troopIntNames[_loc15_]])
            {
               _loc18_ = this._mb759(_loc15_);
               if(_loc18_ != null)
               {
                  _loc26_ = this._ui319(_loc15_,_loc25_);
                  if(_loc26_ <= 0)
                  {
                     _loc26_ = 1;
                  }
                  _loc28_ = 900 / _loc26_;
                  _loc28_ = int(_loc28_ / 5) * 5;
                  if(_loc28_ < 5)
                  {
                     _loc28_ = 5;
                  }
                  _loc23_ = 0;
                  while(this._cx1101(_loc15_,10,_loc23_ + 10) && this.estResource.workPeople + troopPopulations[_loc15_] * (_loc23_ + 10) <= this.estResource.curPopulation)
                  {
                     _loc23_ += 10;
                  }
                  _loc23_ = Math.min(_loc23_,this.troopRequirement[troopIntNames[_loc15_]] - _loc6_[troopIntNames[_loc15_]] + 4);
                  _loc23_ = int(_loc23_ / 5) * 5;
                  if(_loc23_ > _loc28_)
                  {
                     _loc29_ = 0;
                     _loc27_ = 0;
                     while(_loc27_ < this.buildings.length)
                     {
                        _loc21_ = this.buildings[_loc27_];
                        if(_loc21_.typeId == BuildingConstants.TYPE_BARRACK)
                        {
                           if(this._wb445(_loc18_,_loc21_.level))
                           {
                              _loc22_ = this.getBarrackQueueFromBuildingBean(_loc21_);
                              if(_loc22_ != null)
                              {
                                 if(_loc22_.allProduceQueueArray.length <= 0)
                                 {
                                    _loc29_++;
                                 }
                              }
                           }
                        }
                        _loc27_++;
                     }
                     if(_loc29_ != 0)
                     {
                        if(_loc23_ > _loc29_ * _loc28_)
                        {
                           _loc23_ = _loc29_ * _loc28_;
                        }
                        this.promoteBestAtkHero();
                        if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
                        {
                           this.logMsg("Produce " + _loc23_ + " " + troopExtNames[_loc15_] + " on " + _loc29_ + " free barracks");
                        }
                        CityStateCommands.produceTroop(this.castleId,_loc4_.positionId,_loc15_,_loc23_,true,true,this._ap1065);
                        for each(_loc19_ in resourceIntNames)
                        {
                           this.estResource[_loc19_] -= _loc18_[_loc19_] * _loc23_;
                        }
                        this.estResource.curPopulation -= troopPopulations[_loc15_] * _loc23_;
                        _loc6_[troopIntNames[_loc15_]] += _loc23_;
                        this.lastTroopTypeProduced = _loc15_;
                        return true;
                     }
                  }
               }
            }
         }
         _loc30_ = Utils.randOrder(this.buildings.length);
         _loc27_ = 0;
         while(_loc27_ < _loc30_.length)
         {
            _loc21_ = this.buildings[_loc30_[_loc27_]];
            if(_loc21_.typeId == BuildingConstants.TYPE_BARRACK)
            {
               _loc22_ = this.getBarrackQueueFromBuildingBean(_loc21_);
               if(!(_loc22_ == null || _loc22_.allProduceQueueArray.length >= _loc21_.level || _loc22_.allProduceQueueArray.length >= 2))
               {
                  for each(_loc15_ in _loc14_)
                  {
                     _loc18_ = this._mb759(_loc15_);
                     if(_loc18_ != null)
                     {
                        if(_loc6_[troopIntNames[_loc15_]] < this.troopRequirement[troopIntNames[_loc15_]])
                        {
                           if(_loc15_ != TFConstants.T_BALLISTA)
                           {
                              if(!_loc1_)
                              {
                                 continue;
                              }
                           }
                           else if(!_loc2_)
                           {
                              continue;
                           }
                           _loc26_ = this._ui319(_loc15_,_loc25_);
                           if(_loc26_ <= 0)
                           {
                              _loc26_ = 1;
                           }
                           _loc23_ = 900 / _loc26_;
                           _loc23_ = int(_loc23_ / 5) * 5;
                           if(_loc23_ < 5)
                           {
                              _loc23_ = 5;
                           }
                           if(this._cx1101(_loc15_,_loc21_.level,_loc23_))
                           {
                              this.promoteBestAtkHero();
                              if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
                              {
                                 this.logMsg("Produce " + _loc23_ + " " + troopExtNames[_loc15_] + " on barrack at " + _loc21_.positionId,"#169736");
                              }
                              CityStateCommands.produceTroop(this.castleId,_loc21_.positionId,_loc15_,_loc23_,false,false,this._ap1065);
                              _loc6_[troopIntNames[_loc15_]] += _loc23_;
                              for each(_loc19_ in resourceIntNames)
                              {
                                 this.estResource[_loc19_] -= _loc18_[_loc19_] * _loc23_;
                              }
                              this.estResource.curPopulation -= troopPopulations[_loc15_] * _loc23_;
                              this.lastTroopTypeProduced = _loc15_;
                              return true;
                           }
                        }
                     }
                  }
               }
            }
            _loc27_++;
         }
         return false;
      }
      
      private function setOutsideBuildingBeans(param1:AvailableBuilingListResponse) : void
      {
         if(param1.ok == 1)
         {
            this.outsideBuildingBeans = param1.builingListArray;
         }
      }
      
      public function _readGoals(param1:String) : void
      {
         var script:Script;
         var isMaintown:Boolean;
         var i:int;
         var str:String;
         var good:Boolean;
         var args:Array = null;
         var varTmpOldtrainingHeroName:String = null;
         var field:int = 0;
         var extCond:TroopBean = null;
         var intCond:TroopBean = null;
         var t:TroopBean = null;
         var fr:FortificationsBean = null;
         var count:int = 0;
         var key:String = null;
         var goals:String = param1;
         var lines:Array = goals.split(/\r|\n/);
         this.goalVars = new Object();
         try
         {
            lines = this.preProcessGoals(lines);
         }
         catch(error:Error)
         {
            logErrMsg("Program bug preprocessing goal :( Please change your goal and try again");
            logErrMsg(error.message);
            return;
         }
         if(lines == null)
         {
            this.logErrMsg("Goal preprocessing error, please check all include/set/condgoal lines");
            return;
         }
         good = true;
         this._resetCMVariables();
         this.cityCfg.deleteAllCfgs();
         script = this.city._getScript();
         args = null;
         str = null;
         i = 0;
         for(; i < lines.length; i++)
         {
            str = Utils.trim(lines[i]);
            if(str.length == 0)
            {
               continue;
            }
            if(str.indexOf("#") == 0 || str.indexOf("//") == 0)
            {
               continue;
            }
            if(str == "exit")
            {
               this.logErrMsg("Goal lines after \'exit\' are ignored!!!");
               break;
            }
            args = script.lineElementsToArray(str);
            switch(args[0])
            {
               case "npclist":
                  args.splice(0,1);
                  if(!this._jg731(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "npcavoidlist":
                  args.splice(0,1);
                  if(!this._fe161(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "slowhuntingpolicy":
                  args.splice(0,1);
                  if(!this._ni200(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "maintown":
                  this.setMaintownCastleId();
                  MainScreen.setMaintPolicy(-1,-1);
                  break;
               case "npc10list":
                  args.splice(0,1);
                  if(!this._de531(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "npcarea":
                  args.splice(0,1);
                  if(!this._yi1020(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "npc10area":
                  args.splice(0,1);
                  if(!this._xe429(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "skypewarningpolicy":
                  args.splice(0,1);
                  if(!this._setSkypeWarnPolicy(args))
                  {
                     good = false;
                  }
                  break;
               case "skypewarningreceivers":
                  args.splice(0,1);
                  if(!this._setSkypeWarnReceivers(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "skypewarreportreceivers":
                  args.splice(0,1);
                  if(!this._setSkypeWrReceivers(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "warreportignorelist":
                  args.splice(0,1);
                  if(!this._setWrIgnoreList(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "enemywarningignorelist":
                  args.splice(0,1);
                  if(!this._setEnemyWarningIgnoreLists(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "condgatepolicy":
                  args.splice(0,1);
                  if(!this._wb316(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "condgatepolicyalx":
                  args.splice(0,1);
                  if(!this._wb316ALX(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "condgatepolicyalx2":
                  args.splice(0,1);
                  if(!this._wb316ALX2(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "advevasion":
                  args.splice(0,1);
                  if(!this._wb316ALXAI(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "notfastkeepresoheroes":
                  args.splice(0,1);
                  this._setNotFastKeepResoHeroes(args.join(" "));
                  break;
               case "gatepolicy":
                  args.splice(0,1);
                  if(!this._setGatePolicy(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "maintpolicy":
                  if(this.isMainTown())
                  {
                     if(args.length != 3 || !Utils.hasValue(args[1]) || !Utils.hasValue(args[2]) || Number(args[1]) > Number(args[2]))
                     {
                        this.logErrMsg("bad values for maintpolicy, expect \'maintpolicy minMinutes maxMinutes\'");
                        good = false;
                     }
                     else
                     {
                        MainScreen.setMaintPolicy(Number(args[1]),Number(args[2]));
                     }
                  }
                  else
                  {
                     this.logErrMsg("not maintown, maintpolicy is ignored");
                     good = false;
                  }
                  break;
               case "resourcelimits":
                  args.splice(0,1);
                  if(!this.processRresourceLimits(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "traininglooptime":
                  if(Utils.hasValue(args[1]))
                  {
                     this.trainingLoopTime = Number(args[1]);
                  }
                  else
                  {
                     this.logMsg("Error: argument for traininglooptime \'" + args[1] + "\' must be a number");
                  }
                  break;
               case "keeptroop":
               case "keeptroops":
                  args.splice(0,1);
                  if(!this.processKeeptroopGoals(args.join(" "),true))
                  {
                     good = false;
                  }
                  break;
               case "keeptotaltroop":
               case "keeptotaltroops":
                  args.splice(0,1);
                  if(!this.processKeeptroopGoals(args.join(" "),true,true))
                  {
                     good = false;
                  }
                  break;
               case "requesthelp":
                  args.splice(0,1);
                  if(!this.processRequestHelpGoals(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "keepresource":
               case "keepresources":
                  args.splice(0,1);
                  if(!this.processKeepResourceGoal(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "distancepolicy":
                  args.splice(0,1);
                  if(!this._le27(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "loginpolicy":
               case "schedulepolicy":
                  args.splice(0,1);
                  if(!this._setSchedulePolicy(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "wartownpolicy":
                  args.splice(0,1);
                  if(!this._setWartownPolicy(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "tradepolicy":
                  args.splice(0,1);
                  if(!this._setTradePolicy(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "extratroop":
                  if(args.length == 4)
                  {
                     field = Map.coordStringToFieldId(args[1]);
                     extCond = Utils.getTroops(args[2]);
                     intCond = Utils.getTroops(args[3]);
                     if(field == -1 || extCond == null || intCond == null)
                     {
                        this.logMsg("Invalid field or troop condition in " + str);
                        good = false;
                     }
                     else
                     {
                        this.extraTroopFields.push(field);
                        this.extraTroopExtConds.push(extCond);
                        this.extraTroopIntConds.push(intCond);
                     }
                  }
                  else
                  {
                     this.logMsg("Invalid extratroop string: " + str + ", need 3 params");
                     good = false;
                  }
                  break;
               case "priorityfarming":
                  args.splice(0,1);
                  if(!this._cfg_priorityFarming(args.join(" ")))
                  {
                     good = false;
                  }
                  break;
               case "traininghero":
                  varTmpOldtrainingHeroName = this.trainingHeroName;
                  this.trainingHeroName = args[1];
                  this.trainingHeroMinStay = args.length >= 3 ? int(args[2]) : 0;
                  this.logMsg("Training hero: " + this.trainingHeroName + ", minimum staying time: " + this.trainingHeroMinStay + "s");
                  this.trainingHeroNeeded = true;
                  this.CMCalculateHeroPath();
                  break;
               default:
                  if(args.length == 2)
                  {
                     switch(args[0])
                     {
                        case "config":
                           if(!this._setConfig(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "autouseitems":
                           if(!this._setAutoUseItems(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "build":
                           if(!this._vu1098(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "research":
                           if(!this._tj1139(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "rallymax":
                           if(!this._setRallyMax(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "warrallymax":
                           if(!this._uj48(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "ballsused":
                           if(!this._pj342(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "troop":
                           t = Utils.getTroops(args[1]);
                           if(t == null)
                           {
                              this.logMsg("Invalid troop string: " + args[1]);
                              good = false;
                           }
                           else
                           {
                              this._addTroopGoal(t);
                           }
                           break;
                        case "fortification":
                           fr = Utils.getFortifications(args[1]);
                           if(fr == null)
                           {
                              this.logMsg("Invalid fortifications string: " + args[1]);
                              good = false;
                           }
                           else
                           {
                              this._io1033(fr);
                           }
                           break;
                        case "npctroop":
                        case "npctroops":
                           if(!this._setNpcTroopCond(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "npcheroes":
                           this._cfg_npcHeroes(args[1]);
                           break;
                        case "valleyheroes":
                           this._ap1008(args[1]);
                           break;
                        case "reservedheroes":
                           this._mo666(args[1]);
                           break;
                        case "notnpcheroes":
                           this._cfg_notNpcHeroes(args[1]);
                           break;
                        case "spamheroes":
                           this._setSpamHeroes(args[1]);
                           break;
                        case "notspamheroes":
                           this.setSpamHeroes(args[1]);
                           break;
                        case "nouplevelheroes":
                           this._cfg_noUplevelHeroes(args[1]);
                           break;
                        case "valleytroop":
                        case "valleytroops":
                           if(!this._setValleyTroops(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "npc10troop":
                        case "npc10troops":
                           if(!this._uo1113(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "npc10heroes":
                           this._cfg_npc10Heroes(args[1]);
                           break;
                        case "npc10limit":
                           this._dp32(args[1]);
                           break;
                        case "npcfarmingmax":
                           if(!this._jh385(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "huntingpos":
                           if(!this._vw697(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "huntingmax":
                           if(!this._cv994(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "huntingtype":
                           if(!this._bx341(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "valleytype":
                           if(!this._ty888(args[1]))
                           {
                              good = false;
                           }
                           break;
                        case "nexttrainingpos":
                           this._on498(args[1]);
                           break;
                        case "embassyallowplayers":
                           this._setEmbPlayersLists(args[1]);
                           break;
                        case "allblacklist":
                           this._setAllBlackList(args[1]);
                           break;
                        case "enemyallianceignorelist":
                           if(this.enemyWarningAllianceIgnoreList.length <= 0)
                           {
                              args[1] = (args[1] as String).split(" ").join("");
                              if(args[1].length > 0)
                              {
                                 this.enemyWarningAllianceIgnoreList = args[1].split(",");
                              }
                              else
                              {
                                 good = false;
                                 this.logErrMsg("Invalid line:  " + args[0] + " " + args[1]);
                              }
                           }
                           break;
                        default:
                           good = false;
                           this.logMsg("Error: " + args[0] + " must be among: npclist, npcavoidlist, slowhuntingpolicy, maintown, npc10list, npcarea, npc10area, condgatepolicy, advevasion, notfastkeepresoheroes, gatepolicy, maintpolicy, resourcelimits, traininglooptime, keeptroop(s), keeptotaltroop(s), requesthelp, keepresource(s), distancepolicy, schedulepolicy, wartownpolicy, tradepolicy, extratroop, priorityfarming, traininghero, config, autouseitems, build, research, rallymax, warrallymax, ballsused, troop, fortification, npctroop(s), npcheroes, valleyheroes, reservedheroes, notnpcheroes, spamheroes, notspamheroes, nouplevelheroes, valleytroop(s), npc10troop(s), npc10heroes, npc10limit, npcfarmingmax, huntingpos, huntingmax, huntingtype, valleytype, nexttrainingpos, matime, embassyallowplayers, enemyallianceignorelist");
                     }
                  }
                  else
                  {
                     good = false;
                     this.logErrMsg("Invalid line: " + str + ", " + args[0] + " is not a valid goal or it can only accept one parameter");
                  }
                  break;
            }
         }
         if(this.trainingHeroName != null && !Utils.isNameKingOrQueen(this.trainingHeroName) && !this.isTrainingHeroInTown() && this.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) == this.heroes.length - this.specialHeroCount)
         {
            this.logErrMsg("Warning: training hero is not in town and there is no space available in FEASTING HALL");
         }
         if(this.trainingHeroName != null && this.getCfg(CityConfigs.CFG_DUMPING) <= 0)
         {
            this.logErrMsg("Warning: training hero is not useful when dumping option is off, setting config dumping to 1");
            this.cityCfg.configs[CityConfigs.CFG_DUMPING] = 1;
         }
         if(this.huntingLocation != -1 && this.huntingType != null)
         {
            this.logErrMsg("Warning: both huntingpos and huntingtype are specified, huntingpos is ignored");
            this.huntingLocation = -1;
         }
         if(this.getCfg(CityConfigs.CFG_SLOWHUNTING) > 0)
         {
            if(Boolean(this.getCfg(CityConfigs.CFG_HUNTING)) || Boolean(this.getCfg(CityConfigs.CFG_BUILDNPC)))
            {
               this.logErrMsg("config slowhunting should not be on when hunting or buildnpc is on");
               this.cityCfg.configs[CityConfigs.CFG_SLOWHUNTING] = 0;
            }
         }
         if(this.cityCfg.configs[CityConfigs.CFG_ABANDON] > 0)
         {
            count = 0;
            for each(key in this.cityCfg.configs)
            {
               count++;
            }
            if(count != 1)
            {
               this.logErrMsg("<b>ABANDON should be used alone without any other config setting: ABANDON disabled</b>");
               this.cityCfg.configs[CityConfigs.CFG_ABANDON] = 0;
            }
            else
            {
               this.logMsg("Preparing town for abandonment.  Lower loyalty to 0 and destroy defenses!!!");
            }
         }
         isMaintown = this.isMainTown();
         if([0,1,10,11,12,20,21,22].indexOf(this.getCfg(CityConfigs.CFG_HERO)) == -1)
         {
            this.logMsg("WARNING: invalid hero option, hero option disabled");
            this.cityCfg.configs[CityConfigs.CFG_HERO] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_FASTHERO) > 0 && this.getCfg(CityConfigs.CFG_HERO) <= 1)
         {
            this.logErrMsg("WARNING: do not use " + CityConfigs.CFG_FASTHERO + " with incorrect hero option!!!");
            this.cityCfg.configs[CityConfigs.CFG_FASTHERO] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_FASTHERO) > 40 && this.getCfg(CityConfigs.CFG_JUNKHERO) > 0)
         {
            this.logErrMsg("WARNING: using both " + CityConfigs.CFG_FASTHERO + " and " + CityConfigs.CFG_JUNKHERO + " option is not recommended");
         }
         if(this.getCfg(CityConfigs.CFG_ALLOWDISABLESECCODE) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_ALLOWDISABLESECCODE + " should only be on town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_ALLOWDISABLESECCODE] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_NOAUTOCLAIMGIFTS) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_NOAUTOCLAIMGIFTS + " should only be on town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_NOAUTOCLAIMGIFTS] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_NOAUTOQUEST) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_NOAUTOQUEST + " should only be on town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_NOAUTOQUEST] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_WARREPORT) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_WARREPORT + " should only be on town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_WARREPORT] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEWARREPORT) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEWARREPORT + " should only be on town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_SKYPEWARREPORT] = 0;
            this.skypeWarreportReceiverList = new Array();
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEWARREPORT) > 0 && this.skypeWarreportReceiverList.length == 0)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEWARREPORT + " can only be enabled if Skype recipients have been specified using skypewarreportreceivers, option disabled");
            this.cityCfg.configs[CityConfigs.CFG_SKYPEWARREPORT] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEWARREPORT) > 0 && (LoginHelper.getInstance().skypeUn.length == 0 || LoginHelper.getInstance().skypePw.length == 0))
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEWARREPORT + " is enabled without proper Skype login info entered in the login screen, either run the logintoskype script command or restart and enter info at login screen");
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEJUNKWARREPORT) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEJUNKWARREPORT + " should only be on town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_SKYPEJUNKWARREPORT] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEJUNKWARREPORT) > 0 && this.getCfg(CityConfigs.CFG_SKYPEWARREPORT) <= 0)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEJUNKWARREPORT + " can only be enabled along with " + CityConfigs.CFG_SKYPEWARREPORT + ", option disabled");
            this.cityCfg.configs[CityConfigs.CFG_SKYPEJUNKWARREPORT] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_NOREPORTS) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_NOREPORTS + " should only be on town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_NOREPORTS] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_ATTACKWARNING) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: audio " + CityConfigs.CFG_ATTACKWARNING + " only works in town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_ATTACKWARNING] = 0;
         }
         if((this.getCfg(CityConfigs.CFG_ATTACKWARNING) > 3 || this.getCfg(CityConfigs.CFG_ATTACKWARNING) < 0) && isMaintown)
         {
            this.logErrMsg("WARNING: audio " + CityConfigs.CFG_ATTACKWARNING + " set to invalid value of " + this.getCfg(CityConfigs.CFG_ATTACKWARNING) + ", resetting value to 1");
            this.cityCfg.configs[CityConfigs.CFG_ATTACKWARNING] = 1;
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEWARNING) > 0 && !isMaintown)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEWARNING + " only works in town declared with \'maintown\', option disabled");
            this.cityCfg.configs[CityConfigs.CFG_SKYPEWARNING] = 0;
            this.skypeWarningReceiverList = new Array();
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEWARNING) > 0 && this.skypeWarningReceiverList.length == 0)
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEWARNING + " can only be enabled if Skype recipients have been specified using skypewarningreceivers, option disabled");
            this.cityCfg.configs[CityConfigs.CFG_SKYPEWARNING] = 0;
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEWARNING) > 0 && this.getCfg(CityConfigs.CFG_SKYPEWARNING) < 30)
         {
            this.logMsg("ATTENTION: " + CityConfigs.CFG_SKYPEWARNING + " repeat frequency of " + this.getCfg(CityConfigs.CFG_SKYPEWARNING) + " seconds is too small, resetting to minimum value of 30");
            this.cityCfg.configs[CityConfigs.CFG_SKYPEWARNING] = 30;
         }
         if(this.getCfg(CityConfigs.CFG_SKYPEWARNING) > 0 && (LoginHelper.getInstance().skypeUn.length == 0 || LoginHelper.getInstance().skypePw.length == 0))
         {
            this.logErrMsg("WARNING: " + CityConfigs.CFG_SKYPEWARNING + " is enabled without proper Skype login info entered in the login screen, either run the logintoskype script command or restart and enter info at login screen");
         }
         if(this.getCfg(CityConfigs.CFG_EMAILWARNING) > 0)
         {
            if(isMaintown)
            {
               if(this.cityCfg.configs[CityConfigs.CFG_EMAILWARNING] < 15)
               {
                  this.logErrMsg("WARNING: " + CityConfigs.CFG_EMAILWARNING + " interval is too small, adjust value to 15 minutes");
                  this.cityCfg.configs[CityConfigs.CFG_EMAILWARNING] = 15;
               }
            }
            else
            {
               this.logErrMsg("WARNING: " + CityConfigs.CFG_EMAILWARNING + " works only on town declared with \'maintown\', option disabled");
               this.cityCfg.configs[CityConfigs.CFG_EMAILWARNING] = 0;
            }
         }
         if(this.getCfg(CityConfigs.CFG_RELOGIN) > 0)
         {
            if(isMaintown)
            {
               if(this.cityCfg.configs[CityConfigs.CFG_RELOGIN] < 10)
               {
                  this.logErrMsg("WARNING: relogin time too small, adjust value to 10 minutes");
                  this.cityCfg.configs[CityConfigs.CFG_RELOGIN] = 10;
               }
            }
            else
            {
               this.logErrMsg("WARNING: relogin setting works only on town declared with \'maintown\', option disabled");
               this.cityCfg.configs[CityConfigs.CFG_RELOGIN] = 0;
            }
         }
         if(this.getCfg(CityConfigs.CFG_TRADING) > 0 && this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_MARKET,1) == 0)
         {
            this.logErrMsg("WARNING: trading is on with NO MARKET IN TOWN");
         }
         if(this.getCfg(CityConfigs.CFG_HIDING) > 0 && this.getCfg(CityConfigs.CFG_GATE) > 0 && this.getCfg(CityConfigs.CFG_GATE) <= this.getCfg(CityConfigs.CFG_HIDING))
         {
            this.logErrMsg("resource hiding is best done after gate control time");
         }
         if(this.getCfg(CityConfigs.CFG_HERO) > 1 && this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_TAVERN,1) == 0)
         {
            this.logErrMsg("WARNING: hero selection is on with NO INN in this town");
         }
         if(this.getCfg(CityConfigs.CFG_NPC) < 0 || this.getCfg(CityConfigs.CFG_NPC) > 5)
         {
            this.cityCfg.configs[CityConfigs.CFG_NPC] = 0;
            this.logErrMsg("WARNING: invalid npc option, not in 1-5 range, npc option disabled");
         }
         if(this.getCfg(CityConfigs.CFG_EXTRAFOOD) < -1)
         {
            this.cityCfg.configs[CityConfigs.CFG_EXTRAFOOD] = 0;
            this.logErrMsg("WARNING: extrafood may take negative value, but not below -1. Setting value to default instead.");
         }
         if(this.getCfg(CityConfigs.CFG_JUNKHERO) > 0 && this.getCfg(CityConfigs.CFG_HERO) < 10)
         {
            this.cityCfg.configs[CityConfigs.CFG_JUNKHERO] = 0;
            this.logErrMsg("WARNING: junk hero config is valid only when hero config is 10 or higher");
         }
         if(this.getCfg(CityConfigs.CFG_ENEMYWARNING) > 20)
         {
            this.logErrMsg("WARNING: enemy warning radius of " + this.getCfg(CityConfigs.CFG_ENEMYWARNING) + " is too large [20 max], resetting option to 5");
            this.cityCfg.configs[CityConfigs.CFG_ENEMYWARNING] = 5;
         }
         if(this.getCfg(CityConfigs.CFG_RESERVEDENERGY) > 0 && this.getCfg(CityConfigs.CFG_RESERVEDENERGY) < 8)
         {
            this.logErrMsg("WARNING: reserved energy " + this.getCfg(CityConfigs.CFG_RESERVEDENERGY) + " is too low. Resetting to default value 8.");
            this.cityCfg.configs[CityConfigs.CFG_RESERVEDENERGY] = 8;
         }
         else if(this.getCfg(CityConfigs.CFG_RESERVEDENERGY) > 60)
         {
            this.logErrMsg("WARNING: reserved energy " + this.getCfg(CityConfigs.CFG_RESERVEDENERGY) + " is too high. Resetting to default max value 60.");
            this.cityCfg.configs[CityConfigs.CFG_RESERVEDENERGY] = 60;
         }
         if(this.getCfg(CityConfigs.CFG_FLATROLLING) > 0)
         {
            if(this.getCfg(CityConfigs.CFG_VALLEY) > 0)
            {
               this.logErrMsg("WARNING: cannot have both configs " + CityConfigs.CFG_VALLEY + " and " + CityConfigs.CFG_FLATROLLING);
               this.cityCfg.configs[CityConfigs.CFG_FLATROLLING] = 0;
            }
            else if(this.getCfg(CityConfigs.CFG_BUILDNPC) <= 0)
            {
               this.logErrMsg("WARNING: cannot have config " + CityConfigs.CFG_VALLEY + " without " + CityConfigs.CFG_BUILDNPC);
               this.cityCfg.configs[CityConfigs.CFG_FLATROLLING] = 0;
            }
            else if(this.getCfg(CityConfigs.CFG_SLOWHUNTING) > 0)
            {
               this.logErrMsg("WARNING: cannot have both configs " + CityConfigs.CFG_VALLEY + " and " + CityConfigs.CFG_SLOWHUNTING);
               this.cityCfg.configs[CityConfigs.CFG_FLATROLLING] = 0;
            }
         }
         if(this.getCfg(CityConfigs.CFG_FLATROLLING) > 10)
         {
            this.logErrMsg("WARNING: flat rolling radius " + this.getCfg(CityConfigs.CFG_FLATROLLING) + " is too large");
            this.cityCfg.configs[CityConfigs.CFG_FLATROLLING] = 10;
         }
         this._gs965();
         if(good)
         {
            this.vrGateSettingCache = null;
            this.vrGateSettingCacheArmyId = 0;
            this.logMsg("Goals successfully set");
         }
         else
         {
            this.logErrMsg("ERROR IN GOALS, please check!!!");
         }
         this.doGateDefense();
         this._reserveEmergencyTimeSlot();
      }
      
      private function _je83() : String
      {
         return this.sneakFlag ? "on" : "off";
      }
      
      public function _le27(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         _loc2_ = param1.split(" ");
         if(_loc2_.length != 4 && _loc2_.length != 5)
         {
            this.logMsg("SETGOALERROR > Distance policy needs 4-5 integers from 1 to 30 for npc, buildnpc, hunting, valley",COLR_ERR_LOG_MSG);
            return false;
         }
         if(_loc2_.length == 4)
         {
            _loc2_.push(0);
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(_loc2_[_loc3_] != 0 && !this._vi518(_loc2_[_loc3_],1,30))
            {
               this.logMsg("SETGOALERROR > Invalid policy, expecting 0 or an integer from 1 to 30, get: " + _loc2_[_loc3_],COLR_ERR_LOG_MSG);
               return false;
            }
            _loc3_++;
         }
         if(this.distanceSettings[DISTANCE_NPC] != int(_loc2_[DISTANCE_NPC]))
         {
            this.distanceSettings[DISTANCE_NPC] = int(_loc2_[DISTANCE_NPC]);
            this.localNPCs = null;
            this.localNPC10s = null;
         }
         if(this.distanceSettings[DISTANCE_BUILDNPC] != int(_loc2_[DISTANCE_BUILDNPC]))
         {
            this.distanceSettings[DISTANCE_BUILDNPC] = int(_loc2_[DISTANCE_BUILDNPC]);
            this.flatFieldsDetailInfo = new ArrayCollection();
            this.candidateFlatFields = null;
         }
         if(this.distanceSettings[DISTANCE_BUILDNPC10] != int(_loc2_[DISTANCE_BUILDNPC10]))
         {
            this.distanceSettings[DISTANCE_BUILDNPC10] = int(_loc2_[DISTANCE_BUILDNPC10]);
            this.flatFieldsDetailInfo = new ArrayCollection();
            this.candidateFlatFields = null;
         }
         if(this.distanceSettings[DISTANCE_HUNTING] != int(_loc2_[DISTANCE_HUNTING]))
         {
            this.distanceSettings[DISTANCE_HUNTING] = int(_loc2_[DISTANCE_HUNTING]);
            this.localFieldsDetailInfo = new ArrayCollection();
            this.candidateLocalFields = null;
         }
         if(this.distanceSettings[DISTANCE_VALLEY] != int(_loc2_[DISTANCE_VALLEY]))
         {
            this.distanceSettings[DISTANCE_VALLEY] = int(_loc2_[DISTANCE_VALLEY]);
            this.resourceFieldsDetailInfo = new ArrayCollection();
            this.candidateResourceFields = null;
         }
         return true;
      }
      
      private function _de1078(param1:Array, param2:int = -1) : int
      {
         var _loc3_:int = 0;
         var _loc4_:ArmyBean = null;
         _loc3_ = 0;
         for each(_loc4_ in this.selfArmies)
         {
            if(!(param2 != -1 && _loc4_.missionType != param2))
            {
               if(_loc4_.startFieldId == this.castle.fieldId && param1.indexOf(_loc4_.targetFieldId) != -1)
               {
                  _loc3_++;
               }
            }
         }
         return _loc3_;
      }
      
      public function _resetLocalFieldsInfo() : void
      {
         this.resourceFieldsDetailInfo.removeAll();
         this.flatFieldsDetailInfo.removeAll();
         this.localFieldsDetailInfo.removeAll();
         this.evasionFieldId = -1;
         this.localNPCs = null;
         this.localNPC10s = null;
         this.candidateResourceFields = null;
         this.candidateLocalFields = null;
         this.candidateFlatFields = null;
         if(this.isMainTown())
         {
            lastSlowTargetTroops = new Array();
         }
      }
      
      private function doDumping() : Boolean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:TroopBean = null;
         var _loc7_:BuildingBean = null;
         var _loc8_:AllProduceBean = null;
         var _loc9_:AllProduceBean = null;
         var _loc10_:ConditionBean = null;
         var _loc11_:String = null;
         var _loc12_:Boolean = false;
         var _loc13_:Array = null;
         var _loc14_:int = 0;
         var _loc15_:Array = null;
         var _loc16_:Number = NaN;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Number = NaN;
         var _loc23_:int = 0;
         var _loc24_:BuildingBean = null;
         var _loc25_:AllProduceBean = null;
         var _loc26_:Number = NaN;
         var _loc27_:ProduceBean = null;
         var _loc28_:Array = null;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         if(this.researches == null || this.troopRequirement == null || this.getCfg(CityConfigs.CFG_DUMPING) <= 0 || this.troopProduceQueue == null || this.getCfg(CityConfigs.CFG_TROOP) <= 0)
         {
            return false;
         }
         _loc1_ = this.getBestIdleTrainingHero();
         if(_loc1_ == null)
         {
            return false;
         }
         if((this.getCfg(CityConfigs.CFG_ZEROFOOD) == 0 || !this.isZeroFoodActive) && this._dj1085())
         {
            MasterTimer.getInstance().setNextActiveTime();
            return false;
         }
         _loc2_ = this._mp684(10,3 * 3600 * this.getCfg(CityConfigs.CFG_DUMPING));
         if(_loc2_ == 0)
         {
            return false;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_POPULATION)
         {
            this.logMsg("est population: " + this.estResource.curPopulation + ", est worker: " + this.estResource.workPeople);
         }
         _loc3_ = Utils.getMaxStatValueByType(_loc1_,"power");
         _loc4_ = this.estResource.curPopulation - this.estResource.workPeople;
         _loc5_ = 1;
         if(_loc2_ > _loc4_ && _loc4_ >= 100)
         {
            _loc5_ = _loc4_ / _loc2_;
         }
         _loc6_ = this.getAllTroopsInCastle();
         _loc7_ = this.getHighestLevelBarrack();
         _loc8_ = _loc7_ != null ? this.getBarrackQueueFromBuildingBean(_loc7_) : null;
         for each(_loc9_ in this.troopProduceQueue)
         {
            for each(_loc27_ in _loc9_.allProduceQueueArray)
            {
               _loc6_[troopIntNames[_loc27_.type]] += _loc27_.num;
            }
         }
         _loc10_ = null;
         _loc11_ = null;
         _loc12_ = false;
         _loc13_ = new Array();
         _loc14_ = 0;
         if(this.isLastEnemyTimeLessThan1Hr() && _loc7_ != null && _loc8_ != null && _loc8_.allProduceQueueArray.length < _loc7_.level && this.cityTimingAllowed("fillReservedAllowed",15))
         {
            _loc13_[_loc7_.positionId] = Math.max(2,_loc8_.allProduceQueueArray.length);
            _loc28_ = new Array(TFConstants.T_MILITIA,TFConstants.T_PEASANTS,TFConstants.T_SCOUTER,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_CARRIAGE,TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CATAPULT);
            _loc29_ = 0;
            _loc30_ = 0;
            _loc31_ = 0;
            for each(_loc14_ in _loc28_)
            {
               if(_loc13_[_loc7_.positionId] >= _loc7_.level)
               {
                  break;
               }
               if(this._ui319(_loc14_,_loc3_) != 0)
               {
                  _loc30_ = 10 / this._ui319(_loc14_,_loc3_);
                  if(_loc30_ < 1)
                  {
                     _loc30_ = 1;
                  }
                  _loc10_ = this._mb759(_loc14_);
                  if(_loc10_ != null)
                  {
                     _loc31_ = int(_loc13_[_loc7_.positionId]);
                     while(_loc31_ < _loc7_.level)
                     {
                        if(this.troopRequirement[troopIntNames[_loc14_]] < _loc6_[troopIntNames[_loc14_]] && this._cx1101(_loc14_,_loc7_.level,_loc30_))
                        {
                           if(!_loc12_)
                           {
                              _loc12_ = true;
                              this.promoteBestAtkHero();
                           }
                           CityStateCommands.produceTroop(this.castleId,_loc7_.positionId,_loc14_,_loc30_,false,false,this._ap1065);
                           for each(_loc11_ in resourceIntNames)
                           {
                              this.estResource[_loc11_] -= _loc10_[_loc11_] * _loc30_;
                           }
                           this.estResource.curPopulation -= troopPopulations[_loc14_] * _loc30_;
                           _loc6_[troopIntNames[_loc14_]] += _loc30_;
                           _loc13_[_loc7_.positionId] += 1;
                           _loc29_++;
                        }
                        _loc31_++;
                     }
                  }
               }
            }
            if(_loc12_)
            {
               if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
               {
                  this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Fill " + _loc29_ + " positions on reserved barrack at " + _loc7_.positionId,COLR_DBG_LOG_MSG);
               }
               return true;
            }
         }
         _loc15_ = new Array(TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
         _loc16_ = NaN;
         _loc17_ = 0;
         _loc18_ = 0;
         _loc19_ = 0;
         _loc20_ = 0;
         _loc21_ = 0;
         _loc22_ = NaN;
         _loc23_ = 0;
         _loc24_ = null;
         _loc25_ = null;
         _loc26_ = NaN;
         for each(_loc14_ in _loc15_)
         {
            if(_loc6_[troopIntNames[_loc14_]] < this.troopRequirement[troopIntNames[_loc14_]])
            {
               _loc16_ = -_loc6_[troopIntNames[_loc14_]] + this.troopRequirement[troopIntNames[_loc14_]];
               _loc10_ = this._mb759(_loc14_);
               if(_loc10_ != null)
               {
                  _loc17_ = this._ui319(_loc14_,_loc3_);
                  _loc18_ = _loc17_ != 0 ? int(this.getCfg(CityConfigs.CFG_DUMPING) * 3 * 3600 / _loc17_ * _loc5_) : 100000;
                  _loc18_ = int(_loc18_ / 10) * 10;
                  if(_loc18_ < 10)
                  {
                     _loc18_ = 10;
                  }
                  _loc19_ = 0;
                  while(this._cx1101(_loc14_,10,_loc19_ + 10) && this.estResource.workPeople + troopPopulations[_loc14_] * (_loc19_ + 10) <= this.estResource.curPopulation)
                  {
                     _loc19_ += 10;
                  }
                  _loc20_ = 0;
                  _loc21_ = -1;
                  _loc22_ = -1;
                  _loc23_ = 0;
                  while(_loc23_ < this.buildings.length)
                  {
                     _loc24_ = this.buildings[_loc23_];
                     if(_loc24_.typeId == BuildingConstants.TYPE_BARRACK)
                     {
                        _loc25_ = this.getBarrackQueueFromBuildingBean(_loc24_);
                        if(_loc25_ != null)
                        {
                           if(_loc13_[_loc24_.positionId] == undefined)
                           {
                              _loc13_[_loc24_.positionId] = Math.max(2,_loc25_.allProduceQueueArray.length);
                           }
                           if(_loc13_[_loc24_.positionId] < _loc24_.level)
                           {
                              if(this._wb445(_loc10_,_loc24_.level))
                              {
                                 ++_loc13_[_loc24_.positionId];
                                 _loc20_++;
                                 _loc26_ = Utils.getTotalQueueEndTime(_loc25_);
                                 if(_loc21_ == -1 || _loc22_ > _loc26_)
                                 {
                                    _loc21_ = _loc24_.positionId;
                                    _loc22_ = _loc26_;
                                 }
                              }
                           }
                        }
                     }
                     _loc23_++;
                  }
                  if(_loc20_ != 0)
                  {
                     if(_loc19_ > _loc20_ * 10)
                     {
                        if(_loc19_ * (_loc17_ + 1) / _loc20_ >= 600)
                        {
                           if(_loc19_ > _loc20_ * _loc18_)
                           {
                              _loc19_ = _loc20_ * _loc18_;
                           }
                           if(_loc19_ > 2 * _loc16_)
                           {
                              _loc19_ = 2 * _loc16_;
                           }
                           if(!_loc12_)
                           {
                              _loc12_ = true;
                              this.promoteBestAtkHero();
                           }
                           if(_loc17_ != 0)
                           {
                              this.logMsg("DUMPING > Use spare resource for " + _loc19_ + " " + troopExtNames[_loc14_] + " on " + _loc20_ + " barracks",COLR_STD_LOG_MSG);
                              CityStateCommands.produceTroop(this.castle.id,_loc7_.positionId,_loc14_,_loc19_,true,false,this._ap1065);
                           }
                           else
                           {
                              this.logMsg("DUMPING > Use spare resource for instant " + _loc19_ + " " + troopExtNames[_loc14_] + " on barrack " + _loc21_,COLR_STD_LOG_MSG);
                              CityStateCommands.produceTroop(this.castle.id,_loc21_,_loc14_,_loc19_,false,false,this._ap1065);
                           }
                           for each(_loc11_ in resourceIntNames)
                           {
                              this.estResource[_loc11_] -= _loc10_[_loc11_] * _loc19_;
                           }
                           this.estResource.curPopulation -= troopPopulations[_loc14_] * _loc19_;
                           _loc4_ -= troopPopulations[_loc14_] * _loc19_;
                           _loc6_[troopIntNames[_loc14_]] += _loc19_;
                           this.lastTroopTypeProduced = _loc14_;
                           if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_POPULATION)
                           {
                              this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > after: est population: " + this.estResource.curPopulation + ", est worker: " + this.estResource.workPeople + ", est idle: " + _loc4_,COLR_DBG_LOG_MSG);
                           }
                           return true;
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      private function onPromoteToChief(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            if(param1.ok == -80)
            {
               this.heroNotIdleError = true;
            }
            this.logErrMsg("set mayor error " + param1.ok + ": " + param1.errorMsg);
            return;
         }
      }
      
      private function isResearchAtLevel(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         if(this.researches == null)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < this.researches.length)
         {
            if(this.researches[_loc3_].typeId == param1 && this.researches[_loc3_].level >= param2 && this.researches[_loc3_].avalevel >= param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function _setSkypeWarnReceivers(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         if(!this.isMainTown())
         {
            this.logMsg("*** WARNING: The skypewarningreceivers goal has no effect if the city is not maintown, ignoring the goal ***",COLR_WRN_LOG_MSG);
            return true;
         }
         _loc2_ = Utils.trim(param1).split(",");
         if(_loc2_.length > 0)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.substr(0,2).toLowerCase() == "g:" && _loc3_.substr(2) != "")
               {
                  this.skypeWarningReceiverList.push({
                     "isGroup":true,
                     "id":_loc3_.substr(2)
                  });
               }
               else if(_loc3_.substr(0,6).toLowerCase() == "group:" && _loc3_.substr(6) != "")
               {
                  this.skypeWarningReceiverList.push({
                     "isGroup":true,
                     "id":_loc3_.substr(6)
                  });
               }
               else if(_loc3_.substr(0,2).toLowerCase() == "p:" && _loc3_.substr(2) != "")
               {
                  this.skypeWarningReceiverList.push({
                     "isGroup":false,
                     "id":_loc3_.substr(2)
                  });
               }
               else
               {
                  if(!(_loc3_.substr(0,8).toLowerCase() == "private:" && _loc3_.substr(8) != ""))
                  {
                     this.logMsg("*** ERROR: The skypewarningreceivers goal has encountered an invalid type or missing user/group ID at " + _loc3_ + " or is formatted incorrectly. Valid types are <b>g</b>roup or <b>p</b>rivate ***",COLR_ERR_LOG_MSG);
                     this.skypeWarningReceiverList = new Array();
                     return false;
                  }
                  this.skypeWarningReceiverList.push({
                     "isGroup":false,
                     "id":_loc3_.substr(8)
                  });
               }
            }
            if(this.skypeWarningReceiverList.length == 0)
            {
               this.logMsg("*** ERROR: The skypewarningreceivers goal has no discernible list of user/group IDs or is formatted incorrectly ***",COLR_ERR_LOG_MSG);
               return false;
            }
            return true;
         }
         this.logMsg("*** WARNING: The skypewarningreceivers goal has no list of user/group IDs, ignoring the goal ***",COLR_WRN_LOG_MSG);
         return true;
      }
      
      public function _xe429(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(" ");
         if(_loc2_.length != 2 || Map.coordStringToFieldId(_loc2_[0]) == -1 || Map.coordStringToFieldId(_loc2_[1]) == -1)
         {
            this.logMsg("Invalid npc10area " + param1 + ", need 2 points to specify an area");
            return false;
         }
         this.npc10Area = new Array(Map.coordStringToFieldId(_loc2_[0]),Map.coordStringToFieldId(_loc2_[1]));
         return true;
      }
      
      public function _vw697(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = Map.coordStringToFieldId(param1);
         if(_loc2_ == -1)
         {
            return false;
         }
         this.huntingLocation = _loc2_;
         return true;
      }
      
      private function _db715(param1:TradeBean, param2:int, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this.market[param1.resType] == null)
         {
            return;
         }
         _loc4_ = param1.amount - param1.dealedAmount;
         if(!param3 && param1.price >= this.getHighestBidOffer(param1.resType) && param2 < _loc4_ * 2)
         {
            return;
         }
         _loc5_ = Math.random() * 0.1 + 0.1;
         _loc6_ = this.getTrimmedMarketPrice(this._hf650(param1.resType) * _loc5_ + this.getHighestBidOffer(param1.resType) * (1 - _loc5_));
         if(param3 || this._hf650(param1.resType) < 1.05 * this.getHighestBidOffer(param1.resType))
         {
            _loc6_ = this._hf650(param1.resType);
         }
         var _loc7_:Number = Math.min(_loc4_ + param2,(this.estResource.gold + _loc4_ * param1.price) / 1.005 / _loc6_);
         if(!param3 && _loc6_ > param1.price * 1.2 && !this.cityTimingAllowed("priceswing",300))
         {
            return;
         }
         if(!this.cityTimingAllowed("modify",60))
         {
            return;
         }
         this.logMsg("TRADE > Cancel buy " + resourceNames[param1.resType] + ": " + _loc4_ + "@" + param1.price + ", range: " + this.getHighestBidOffer(param1.resType) + "-" + this._hf650(param1.resType),COLR_STD_LOG_MSG);
         CityStateCommands.cancelTrade(this.castleId,param1.id,this._og999);
         this.estResource.gold += _loc4_ * param1.price;
      }
      
      public function getUsedRallySlots() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyBean = null;
         _loc1_ = 0;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.startFieldId == this.castle.fieldId)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function _onHeroUpdate(param1:HeroUpdate) : void
      {
         var _loc2_:CastleBean = null;
         var _loc3_:int = 0;
         if(param1.castleId != this.castleId)
         {
            return;
         }
         Utils.formatHeroName(param1.hero);
         _loc2_ = this.castle;
         _loc3_ = 0;
         if(param1.updateType == CommonConstants.UPDATE_TYPE_UPDATE)
         {
            if(Version.isTraceOn())
            {
               trace("update hero stat: " + Utils.heroBeanToString(param1.hero));
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.herosArray.length)
            {
               if(_loc2_.herosArray[_loc3_].id == param1.hero.id)
               {
                  _loc2_.herosArray.setItemAt(param1.hero,_loc3_);
                  return;
               }
               _loc3_++;
            }
            if(param1.hero.status == HeroConstants.HERO_FREE_STATU && this.trainingHeroName != null && param1.hero.name.toLowerCase() == this.trainingHeroName.toLowerCase())
            {
               this.trainingHeroNeeded = true;
               this._reserveEmergencyTimeSlot();
            }
         }
         else if(param1.updateType == CommonConstants.UPDATE_TYPE_ADD)
         {
            if(Version.isTraceOn())
            {
               trace("add hero: " + Utils.heroBeanToString(param1.hero));
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.herosArray.length)
            {
               if(_loc2_.herosArray[_loc3_].id == param1.hero.id)
               {
                  this.logMsg("ABNORMAL hero addition, hero exists " + Utils.heroBeanToString(_loc2_.herosArray[_loc3_]),"#660000");
                  return;
               }
               _loc3_++;
            }
            _loc2_.herosArray.addItem(param1.hero);
            if(this.getCfg(CityConfigs.CFG_NOCAPTURE) > 0 && param1.hero.status == HeroConstants.HERO_SEIZED_STATU && !(param1.hero.ability > 0 || param1.hero.isHero > 0))
            {
               this.logMsg("Auto release captured hero " + Utils.heroBeanToString(param1.hero),"#660000");
               CityStateCommands.releaseHero(this.castleId,param1.hero.id);
            }
            if(this._isTraininghero(param1.hero.name))
            {
               this.trainingHeroNeeded = true;
               this.trainingHeroArrivalTime = Utils.getServerTime();
               this._reserveEmergencyTimeSlot();
            }
         }
         else if(param1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
         {
            if(Version.isTraceOn())
            {
               trace("remove hero: " + Utils.heroBeanToString(param1.hero));
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.herosArray.length)
            {
               if(_loc2_.herosArray[_loc3_].id == param1.hero.id)
               {
                  _loc2_.herosArray.removeItemAt(_loc3_);
                  this.heroUpdateNeeded = true;
                  return;
               }
               _loc3_++;
            }
         }
         else
         {
            this.logMsg("ignore hero update " + param1.updateType + " for hero " + Utils.heroBeanToString(param1.hero));
         }
         this.heroUpdateNeeded = true;
      }
      
      public function getBuildingsCountByTypeAndLvl(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.buildings.length)
         {
            if(this.buildings[_loc4_].typeId == param1 && this.buildings[_loc4_].level >= param2)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function updateTroopQueue() : void
      {
         if(troopProductionUpdateRequested > 0 && new Date().getTime() - troopProductionUpdateRequestedTime < 30000)
         {
            Utils.callLater(1000,this.updateTroopQueue);
            return;
         }
         troopProductionUpdateRequested = this.castleId;
         troopProductionUpdateRequestedTime = new Date().getTime();
         CityStateCommands.getUpdatedTroopProduceQueue(this.castleId,this.onUpdateTroopQueueResponse);
      }
      
      private function getMainScreenLastActiveTime() : Number
      {
         return MainScreen.lastActive;
      }
      
      public function getArmySpeedChangeBuffsFactor() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         if(!this.cityTimingAllowed("updateBuffTimeUpFactor",10))
         {
            return this.buffTimeUpFactorCache;
         }
         _loc1_ = 1;
         if(this.getLocalBuffByWildCardId("IncArmyActionTimeBuff","1") != null)
         {
            _loc2_ = this.getLocalBuffByWildCardId("IncArmyActionTimeBuff","2") != null ? (this.getLocalBuffByWildCardId("IncArmyActionTimeBuff","3") != null ? 3 : 2) : 1;
            _loc1_ *= 1 + 0.2001 * _loc2_;
         }
         if(this.getBuffByWildCardId("ReduceArmyActionBuff","1") != null)
         {
            if(this.getBuffByWildCardId("ReduceArmyActionBuff","2") != null)
            {
               _loc1_ *= 1 - 0.9078;
            }
            else
            {
               _loc1_ *= 1 - 0.5763;
            }
         }
         if(this.getBuffByWildCardId("EasterPVPBuff") != null)
         {
            _loc1_ *= 1 - 0.014;
         }
         return this.buffTimeUpFactorCache = _loc1_;
      }
      
      public function _getSpamHero(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         if(this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) < 1)
         {
            this.logMsg("You cannot hire a hero until your Inn is at least level 1.",COLR_ERR_LOG_MSG);
            return;
         }
         _loc2_ = this.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION);
         if(_loc2_ < 1)
         {
            this.logMsg("You cannot hire a hero until your Feasting Hall is at least level 1.",COLR_ERR_LOG_MSG);
            return;
         }
         if(this.heroes.length - this.specialHeroCount >= _loc2_)
         {
            this.logMsg("Your feasting hall is full. No space available to hire new .hero",COLR_ERR_LOG_MSG);
            return;
         }
         if(param1 != "power" && param1 != "management" && param1 != "stratagem")
         {
            this.logMsg("Invalid attribute: " + param1 + ", valid attributes are power, management, and stratagem",COLR_ERR_LOG_MSG);
            return;
         }
         _loc3_ = null;
         if(this.innHeroes != null)
         {
            for each(_loc4_ in this.innHeroes)
            {
               if(_loc3_ == null || _loc3_[param1] < _loc4_[param1])
               {
                  _loc3_ = _loc4_;
               }
            }
         }
         if(_loc3_ != null)
         {
            this.logMsg("Attempt to hire: " + Utils.heroBeanToString(_loc3_));
            CityStateCommands.hireHero(this.castleId,_loc3_.name,this.onHireHeroResponse);
            this.heroUpdateNeeded = true;
            this.innHeroes.removeItemAt(this.innHeroes.getItemIndex(_loc3_));
            this.innUpdateNeeded = true;
         }
         else
         {
            this.logMsg("Failed to get list of heroes from the inn",COLR_ERR_LOG_MSG);
            this.innUpdateNeeded = true;
         }
      }
      
      private function getValleyArmyCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyBean = null;
         _loc1_ = 0;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.startFieldId == this.castle.fieldId)
            {
               if(this._bv514(Map.getType(_loc2_.targetFieldId)))
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      private function doNewReport() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Boolean = false;
         if(this.lastNewReport == null)
         {
            return;
         }
         if(!this.cityTimingAllowed("servernewreport",3))
         {
            return;
         }
         if(this.getCfg(CityConfigs.CFG_NOREPORTS) == 1)
         {
            return;
         }
         if(this.getCfg(CityConfigs.CFG_NOREPORTS) == 2)
         {
            if(this.lastDisable + 300 * 1000 > Utils.getServerTime())
            {
               return;
            }
            _loc1_ = Math.max(1,this._getMarketLag());
            _loc2_ = this.player.enemyArmysArray.length > 10 && this.player.enemyArmysArray[5].reachTime < Utils.getServerTime() + 60 * 1000 * _loc1_;
            _loc2_ ||= this.player.enemyArmysArray.length > 10 && this.player.enemyArmysArray[0].reachTime - this.player.enemyArmysArray[0].startTime <= 4 && this.player.enemyArmysArray[1].reachTime - this.player.enemyArmysArray[1].startTime <= 4;
            if(_loc2_ && this.honorAttackFieldId == -1 && this.loyaltyAttackFieldId == -1 && this.guardedAttackFieldId == -1)
            {
               if(this.cityTimingAllowed("servernewreport_disable",600))
               {
                  this.logMsg("Disable handling of reports due to heavy attacks and/or lag");
               }
               this.lastDisable = Utils.getServerTime();
               return;
            }
         }
         if(this.lastNewReport.army_count > 0)
         {
            if(!playerTimingAllowed("getarmyreportlist",2))
            {
               return;
            }
            ActionFactory.getInstance().getReportCommands().receiveReportList(1,5,ObjConstants.REPORT_TYPE_ARMY);
            this.lastNewReport.army_count = 0;
            return;
         }
         if(this.lastNewReport.scout_cout > 0)
         {
            if(!playerTimingAllowed("getscoutreportlist",10))
            {
               return;
            }
            ActionFactory.getInstance().getReportCommands().receiveReportList(1,5,ObjConstants.REPORT_TYPE_SCOUT);
            this.lastNewReport.scout_cout = 0;
            return;
         }
         if(this.lastNewReport.trade_count > 0)
         {
            if(!playerTimingAllowed("gettradereportlist",10))
            {
               return;
            }
            ActionFactory.getInstance().getReportCommands().receiveReportList(1,5,ObjConstants.REPORT_TYPE_TRADE);
            this.lastNewReport.trade_count = 0;
            return;
         }
         if(this.lastNewReport.other_count > 0)
         {
            if(!playerTimingAllowed("getotherreportlist",10))
            {
               return;
            }
            ActionFactory.getInstance().getReportCommands().receiveReportList(1,5,ObjConstants.REPORT_TYPE_OTHER);
            this.lastNewReport.other_count = 0;
            return;
         }
         this.lastNewReport = null;
      }
      
      private function setFortificationListArray(param1:FortProduceListResponse) : void
      {
         if(param1.ok != 1)
         {
            return;
         }
         this.fortificationListArray = param1.fortListArray;
      }
      
      private function doValleyAttack() : Boolean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MapCastleBean = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:NewArmyParam = null;
         if(this.fieldTargetEnemyAlliances == null || this.getUsedRallySlots() >= this.getMaxRallySlots() || this.troop.scouter == 0 || this.estResource.food < 100)
         {
            return false;
         }
         if(this.fields.length > 0)
         {
            this.logMsg("Abandon valley: " + Map.fieldIdToString(this.fields[0].id));
            CityStateCommands.giveUpField(this.fields[0].id);
         }
         _loc1_ = this._fr173();
         if(_loc1_ == null)
         {
            return false;
         }
         _loc2_ = 8 * 3600;
         _loc3_ = Math.pow(int(this.fieldTargetRadius) * 2 + 1,2);
         _loc4_ = null;
         _loc5_ = -1;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         while(_loc9_ <= _loc3_)
         {
            _loc6_ = this._ne789(this.fieldTargetCenter,_loc9_);
            if(Map.fieldDistance(_loc6_,this.fieldTargetCenter) <= this.fieldTargetRadius)
            {
               _loc7_ = Map.getLevel(_loc6_);
               if(_loc7_ == -1)
               {
                  return false;
               }
               if(_loc7_ >= this.fieldTargetMinLevel)
               {
                  _loc8_ = Map.getType(_loc6_);
                  if(!(_loc8_ == FieldConstants.TYPE_CASTLE || _loc8_ == FieldConstants.TYPE_NPC))
                  {
                     if(this.cityTimingAllowed("fieldattack" + _loc6_,_loc2_,true))
                     {
                        _loc4_ = Map.getDetail(_loc6_);
                        if(_loc4_ == null)
                        {
                           return false;
                        }
                        if(_loc4_.allianceName != null)
                        {
                           if(this.fieldTargetEnemyAlliances.indexOf(_loc4_.allianceName) != -1)
                           {
                              _loc5_ = _loc6_;
                              break;
                           }
                        }
                     }
                  }
               }
            }
            _loc9_++;
         }
         if(_loc5_ == -1)
         {
            return false;
         }
         _loc10_ = new NewArmyParam();
         _loc10_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc10_.troops = new TroopBean();
         _loc10_.troops.scouter = this.troop.scouter >= 100 ? 10 : 1;
         _loc10_.resource = new ResourceBean();
         _loc10_.heroId = _loc1_.id;
         _loc10_.targetPoint = _loc5_;
         if(!this.isEnoughResourcesToMarch(_loc10_))
         {
            return false;
         }
         if(!this.cityTimingAllowed("fieldattack" + _loc5_,_loc2_))
         {
            return false;
         }
         if(_loc1_.loyalty < 100 && this.estResource.gold > 1000 * _loc1_.level && this.cityTimingAllowed("reward" + _loc1_.id,900))
         {
            CityStateCommands.awardGold(this.castleId,_loc1_.id);
         }
         Map.updateDetailInfo(_loc5_);
         this.logMsg("Attack enemy field at " + Map.fieldIdToString(_loc5_) + " by " + _loc4_.userName + ", " + _loc4_.allianceName + " with hero " + _loc1_.name + " in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc10_) / Utils.getHeroSpeedFactor(_loc1_)));
         if(MasterTimer.getInstance().canSend(this.timeSlot))
         {
            CityStateCommands.newArmy(this.castleId,_loc10_,this.handleArmyCommandResponse);
         }
         else
         {
            CityStateCommands.newArmy(this.castleId,_loc10_);
         }
         this.adjEstFoodAfterMarch(_loc10_);
         return true;
      }
      
      private function taskSearchLocalNPCs() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MapCastleBean = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc1_ = false;
         for each(_loc2_ in this.priorityNpcSettings)
         {
            if(_loc2_[XNPC_NPCLIST] == null)
            {
               _loc1_ = true;
            }
         }
         if(!playerTimingAllowed("rescannpcs",3600,true) && this.localNPCs != null && this.localNPC10s != null && !_loc1_)
         {
            return;
         }
         if(this.distanceSettings[DISTANCE_NPC] <= 0)
         {
            this.distanceSettings[DISTANCE_NPC] = 10;
         }
         _loc3_ = Number(this.distanceSettings[DISTANCE_NPC]);
         for each(_loc2_ in this.priorityNpcSettings)
         {
            _loc3_ = Math.max(_loc3_,_loc2_[XNPC_RADIUS]);
         }
         _loc4_ = Map.getX(this.castle.fieldId);
         _loc5_ = Map.getY(this.castle.fieldId);
         if(!Map.isMapReady(_loc4_,_loc5_,_loc3_))
         {
            return;
         }
         playerTimingAllowed("rescannpcs",3600);
         this.localNPCs = new Array();
         this.localNPC10s = new Array();
         for each(_loc2_ in this.priorityNpcSettings)
         {
            _loc2_[XNPC_NPCLIST] = new Array();
         }
         _loc6_ = null;
         _loc7_ = NaN;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = _loc4_ - _loc3_;
         while(_loc10_ <= _loc4_ + _loc3_)
         {
            _loc11_ = _loc5_ - _loc3_;
            while(_loc11_ <= _loc5_ + _loc3_)
            {
               if((_loc10_ - _loc4_) * (_loc10_ - _loc4_) + (_loc11_ - _loc5_) * (_loc11_ - _loc5_) <= _loc3_ * _loc3_)
               {
                  _loc8_ = Map.getFieldId(_loc10_,_loc11_);
                  if(Map.getType(_loc8_) == FieldConstants.TYPE_NPC)
                  {
                     _loc6_ = Map.getDetailInfo(_loc8_);
                     if(_loc6_ != null && _loc6_.powerLevel == 4)
                     {
                        _loc7_ = Map.fieldDistance(_loc8_,this.castle.fieldId);
                        _loc9_ = Map.getLevel(_loc8_);
                        if(_loc9_ <= 5 && _loc7_ <= this.distanceSettings[DISTANCE_NPC])
                        {
                           this.localNPCs.push(_loc8_);
                        }
                        if(_loc9_ == 10 && _loc7_ <= this.distanceSettings[DISTANCE_NPC])
                        {
                           this.localNPC10s.push(_loc8_);
                        }
                        for each(_loc2_ in this.priorityNpcSettings)
                        {
                           if(_loc9_ == _loc2_[XNPC_LEVEL] && _loc7_ <= _loc2_[XNPC_RADIUS])
                           {
                              _loc2_[XNPC_NPCLIST].push(_loc8_);
                           }
                        }
                     }
                  }
               }
               _loc11_++;
            }
            _loc10_++;
         }
         this.localNPCs.sort(this.sortByLevelAndDistance);
         if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") >*** Found " + this.localNPCs.length + " LVL 1-5 NPC\'s within " + _loc3_ + " miles ***",COLR_DBG_LOG_MSG);
         }
         this.localNPC10s.sort(this.sortByLevelAndDistance);
         if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") >*** Found " + this.localNPC10s.length + " LVL10 NPC\'s within " + _loc3_ + " miles ***",COLR_DBG_LOG_MSG);
         }
         for each(_loc2_ in this.priorityNpcSettings)
         {
            _loc2_[XNPC_NPCLIST].sort(this.sortByLevelAndDistance);
            if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") >*** Found " + _loc2_[XNPC_NPCLIST].length + " LVL" + _loc2_[XNPC_LEVEL] + " for priority farming within " + _loc2_[XNPC_RADIUS] + " miles ***",COLR_DBG_LOG_MSG);
            }
         }
      }
      
      private function _ig672(param1:ArmyBean) : void
      {
         var _loc10_:int = 0;
         var _loc11_:String = null;
         if(param1.missionType == ObjConstants.ARMY_MISSION_SUPPRESS)
         {
            return;
         }
         if(this.cityTimingAllowed("cleanupCacheEnemy",600))
         {
            for(_loc11_ in this.cacheEnemyExpire)
            {
               if(this.cacheEnemyExpire[_loc11_] < Utils.getServerTime() - 5000)
               {
                  delete this.cacheEnemyMin[_loc11_];
                  delete this.cacheEnemyMax[_loc11_];
                  delete this.cacheEnemyExpire[_loc11_];
               }
            }
         }
         var _loc2_:TroopBean = Utils.getTroopBeanFromTroopStrBean(param1.troop);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = Utils.getTotalTroopCount(_loc2_);
         if(_loc3_ <= 0)
         {
            return;
         }
         if(this.cacheEnemyMin[param1.armyId] == undefined || this.cacheEnemyMax[param1.armyId] == undefined)
         {
            this.cacheEnemyMax[param1.armyId] = _loc3_;
            this.cacheEnemyMin[param1.armyId] = _loc3_;
            this.cacheEnemyExpire[param1.armyId] = param1.reachTime;
         }
         if(_loc3_ == this.cacheEnemyMin[param1.armyId] && _loc3_ == this.cacheEnemyMax[param1.armyId])
         {
            if(this.cityTimingAllowed("fake" + param1.startFieldId,300,true))
            {
               return;
            }
         }
         else
         {
            this.cityTimingAllowed("fake" + param1.startFieldId,0);
         }
         if(_loc3_ > 2 * this.cacheEnemyMin[param1.armyId] || _loc3_ < this.cacheEnemyMax[param1.armyId] / 2)
         {
            this.cacheEnemyMax[param1.armyId] = _loc3_;
            this.cacheEnemyMin[param1.armyId] = _loc3_;
            this.cacheEnemyExpire[param1.armyId] = param1.reachTime;
            delete this.cityTimingList["fake" + param1.startFieldId];
            this.logErrMsg("Bad fake server information for army " + param1.armyId + ": " + Utils.troopBeanToString(_loc2_));
            return;
         }
         if(this.cityTimingAllowed("stratagem" + param1.armyId,300))
         {
            this.logErrMsg("Discover fake enemy army " + param1.armyId + (param1.startFieldId == -1 ? "" : " " + Map.fieldIdToString(param1.startFieldId)) + ": " + Utils.troopBeanToString(_loc2_));
         }
         this.cacheEnemyMin[param1.armyId] = Math.min(this.cacheEnemyMin[param1.armyId],_loc3_);
         this.cacheEnemyMax[param1.armyId] = Math.max(this.cacheEnemyMax[param1.armyId],_loc3_);
         var _loc4_:MapCastleBean = Map.getDetail(param1.startFieldId);
         var _loc5_:int = _loc4_ != null ? _loc4_.powerLevel : 0;
         var _loc6_:int = _loc5_ <= 3 && _loc5_ >= 0 ? int(100000 + 200000 / POW2[_loc5_]) : 160000;
         _loc6_ = _loc6_ * 1.25 * 1.25;
         var _loc7_:Boolean = true;
         if(this.cacheEnemyMax[param1.armyId] * 10 > _loc6_)
         {
            _loc7_ = false;
         }
         var _loc8_:Boolean = false;
         if(!_loc7_ && _loc3_ > _loc6_)
         {
            _loc8_ = true;
         }
         var _loc9_:int = _loc7_ ? int(20 * this.cacheEnemyMin[param1.armyId]) : (_loc8_ ? int(this.cacheEnemyMin[param1.armyId] / 5) : _loc3_);
         if(_loc9_ > _loc6_)
         {
            _loc9_ = _loc6_;
         }
         for each(_loc10_ in troopTypes)
         {
            param1.troop[troopIntNames[_loc10_]] = String(Math.round(_loc2_[troopIntNames[_loc10_]] * _loc9_ / _loc3_));
         }
      }
      
      private function getConditionBeanForUpgradingTo(param1:CityCondition) : ConditionBean
      {
         var _loc2_:AvailableBuildingListBean = null;
         var _loc3_:ConditionBean = null;
         var _loc4_:AvailableResearchListBean = null;
         _loc2_ = null;
         _loc3_ = null;
         if(param1.isBuilding)
         {
            if(param1.level == 1)
            {
               for each(_loc2_ in this.insideBuildingBeans)
               {
                  if(_loc2_.typeId == param1.typeId)
                  {
                     _loc3_ = _loc2_.conditionBean;
                  }
               }
               if(this.wallBuildingBean != null && this.wallBuildingBean.typeId == param1.typeId)
               {
                  _loc3_ = this.wallBuildingBean.conditionBean;
               }
               for each(_loc2_ in this.outsideBuildingBeans)
               {
                  if(_loc2_.typeId == param1.typeId)
                  {
                     _loc3_ = _loc2_.conditionBean;
                  }
               }
            }
            else if(BuildingManager.getInstance().getCachedUpgradeCondition(param1.typeId,param1.level - 1) == null)
            {
               _loc3_ = null;
            }
            else
            {
               _loc3_ = BuildingManager.getInstance().getCachedUpgradeCondition(param1.typeId,param1.level - 1);
            }
         }
         else
         {
            for each(_loc4_ in this.researches)
            {
               if(_loc4_.typeId == param1.typeId && _loc4_.level == param1.level - 1)
               {
                  _loc3_ = _loc4_.conditionBean;
               }
            }
         }
         return _loc3_;
      }
      
      public function _cv994(param1:String) : Boolean
      {
         return this._setRallyMax("hunting:" + param1);
      }
      
      private function doHeroHireAndFire(param1:HeroBean) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:HeroBean = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:ArrayCollection = null;
         var _loc10_:HeroBean = null;
         var _loc11_:HeroBean = null;
         var _loc12_:HeroBean = null;
         var _loc13_:HeroBean = null;
         var _loc14_:HeroBean = null;
         _loc2_ = this.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION);
         if(_loc2_ == 0)
         {
            return false;
         }
         _loc3_ = this.trainingHeroName != null && !isNameRoyal(this.trainingHeroName) && !this.isTrainingHeroInTown() ? 1 : 0;
         _loc3_ = Math.max(_loc3_,this.getAdjFHReservedValue());
         _loc4_ = this.getCfg(CityConfigs.CFG_HERO) <= 1 ? 0 : int(this.getCfg(CityConfigs.CFG_FASTHERO));
         if(this.estResource.gold < 1000 * param1.level)
         {
            return false;
         }
         if(this.heroes.length - this.specialHeroCount < _loc2_ - _loc3_)
         {
            if(param1.power >= this.getCfg(CityConfigs.CFG_HEROMINATTACK) || _loc4_ > 0)
            {
               this.logMsg("hiring new hero " + Utils.heroBeanToString(param1),COLR_STD_LOG_MSG);
               CityStateCommands.hireHero(this.castleId,param1.name,this.onHireHeroResponse);
               this.estResource.gold -= 1000 * param1.level;
               this.innUpdateNeeded = true;
               if(param1.name.toLocaleLowerCase() == "king")
               {
                  REAddons.getInstance().renameKing(this);
               }
               this.heroUpdateNeeded = true;
               return true;
            }
         }
         if(this.heroes.length - this.specialHeroCount > _loc2_ - _loc3_)
         {
            return false;
         }
         _loc5_ = this.getWorstRegularHero();
         if(_loc5_ != null && (_loc5_.power - _loc5_.level + _loc5_.remainPoint >= 80 || _loc5_.stratagem - _loc5_.level + _loc5_.remainPoint >= 80 || _loc5_.management - _loc5_.level + _loc5_.remainPoint >= 80))
         {
            return false;
         }
         _loc6_ = false;
         _loc7_ = int(this.getCfg(CityConfigs.CFG_HERO));
         if(_loc4_ > 0)
         {
            if(_loc7_ >= 10)
            {
               if(_loc7_ >= 20)
               {
                  _loc12_ = this._as658(this.bestPoliticHero());
                  if(_loc12_ != null && _loc12_.management < 100 && _loc12_.management - _loc12_.level + _loc12_.remainPoint < _loc4_)
                  {
                     _loc6_ = true;
                  }
               }
            }
            if(_loc7_ % 10 >= 1)
            {
               _loc13_ = this.bestIntelHero();
               if(_loc13_ != null && _loc13_.stratagem < 100 && _loc13_.stratagem - _loc13_.level + _loc13_.remainPoint < _loc4_)
               {
                  _loc6_ = true;
               }
               if(_loc7_ % 10 >= 2)
               {
                  _loc14_ = this._jw592(_loc13_);
                  if(_loc14_ != null && _loc14_.stratagem < 100 && _loc14_.stratagem - _loc14_.level + _loc14_.remainPoint < _loc4_)
                  {
                     _loc6_ = true;
                  }
               }
            }
         }
         if(_loc4_ == 0)
         {
            _loc4_ = 10;
         }
         _loc8_ = _loc5_ != null ? _loc4_ >= 10 && _loc5_.power < 120 && _loc5_.power - _loc5_.level + _loc5_.remainPoint < _loc4_ || _loc4_ < 10 && _loc5_.level < _loc4_ * 10 : false;
         if(_loc5_ != null && (_loc6_ || _loc8_) && this.estResource.gold > 1000000)
         {
            if(_loc5_.status != HeroConstants.HERO_CHIEF_STATU && _loc5_.status != HeroConstants.HERO_FREE_STATU)
            {
               return false;
            }
            if(_loc5_.status == HeroConstants.HERO_CHIEF_STATU)
            {
               this.removeMayor();
            }
            if(!playerTimingAllowed("fastherofire" + _loc5_.id,10))
            {
               return false;
            }
            this.logMsg("FASTHERO > firing hero " + Utils.heroBeanToString(_loc5_) + " for space, hiring " + Utils.heroBeanToString(param1) + " to update inn",COLR_STD_LOG_MSG);
            CityStateCommands.fireHero(this.castleId,_loc5_.id,this.onFireHeroResponse);
            CityStateCommands.hireHero(this.castleId,param1.name,this.onHireHeroResponse);
            if(param1.name.toLocaleLowerCase() == "king")
            {
               REAddons.getInstance().renameKing(this);
            }
            this.estResource.gold -= 1000 * param1.level;
            this.innUpdateNeeded = true;
            return true;
         }
         if(param1.power < this.getCfg(CityConfigs.CFG_HEROMINATTACK))
         {
            return false;
         }
         _loc9_ = new ArrayCollection();
         _loc10_ = null;
         for each(_loc10_ in this.heroes)
         {
            _loc9_.addItem(_loc10_);
         }
         this.heroes.addItem(param1);
         _loc11_ = this.getWorstHeroExcludingReservedHeroes();
         this.heroes.removeAll();
         for each(_loc10_ in _loc9_)
         {
            this.heroes.addItem(_loc10_);
         }
         if(_loc11_ == param1)
         {
            return false;
         }
         if(_loc11_ == null)
         {
            return false;
         }
         if(_loc11_.power - _loc11_.level + _loc11_.remainPoint >= 75 || _loc11_.stratagem - _loc11_.level + _loc11_.remainPoint >= 75 || _loc11_.management - _loc11_.level + _loc11_.remainPoint >= 75)
         {
            return false;
         }
         if(_loc11_.status != HeroConstants.HERO_CHIEF_STATU && _loc11_.status != HeroConstants.HERO_FREE_STATU)
         {
            return false;
         }
         if(_loc11_.level > param1.level && (_loc4_ < 10 || _loc11_.power - param1.power >= 20 * (_loc11_.level - param1.level)))
         {
            return false;
         }
         if(_loc11_.status == HeroConstants.HERO_CHIEF_STATU)
         {
            this.removeMayor();
         }
         this.logMsg("HERO > firing hero " + Utils.heroBeanToString(_loc11_) + " to hire " + Utils.heroBeanToString(param1),COLR_STD_LOG_MSG);
         CityStateCommands.fireHero(this.castleId,_loc11_.id,this.onFireHeroResponse);
         CityStateCommands.hireHero(this.castleId,param1.name,this.onHireHeroResponse);
         this.estResource.gold -= 1000 * param1.level;
         this.innUpdateNeeded = true;
         if(param1.name.toLocaleLowerCase() == "king")
         {
            REAddons.getInstance().renameKing(this);
         }
         return true;
      }
      
      private function handleGetQuestType(param1:QuestTypeResponse) : void
      {
         var _loc2_:int = 0;
         var _loc3_:QuestTypeBean = null;
         if(CityState.scriptQuestActive || !MasterTimer.getInstance().canReceive(this.timeSlot))
         {
            return;
         }
         if(param1.ok != 1)
         {
            this.logErrMsg("quest type response error " + param1.errorMsg);
            return;
         }
         _loc2_ = this.getCfg(CityConfigs.CFG_NOAUTOQUEST) > 0 ? 900 : 3;
         if(!playerTimingAllowed("questresponse",_loc2_))
         {
            return;
         }
         for each(_loc3_ in param1.typesArray)
         {
            if(_loc3_.isFinish)
            {
               if(_loc3_.description != "Promotion")
               {
                  this.logMsg("Quest type " + _loc3_.description + " is available",COLR_STD_LOG_MSG);
                  if(this.getCfg(CityConfigs.CFG_NOAUTOQUEST) <= 1)
                  {
                     ActionFactory.getInstance().getQuestCommands().getQuestList(this.castleId,_loc3_.typeId);
                  }
               }
            }
         }
      }
      
      private function _kn913(param1:int = 1) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.estResource.food < param1 * this.workOutAvailableFood())
         {
            return false;
         }
         _loc2_ = this.estResource.food - this.workOutAvailableFood();
         _loc3_ = this.estResource.gold + this.estResource.wood * this.getHighestBidOffer(TradeConstants.RES_TYPE_WOOD) + _loc2_ * this.getHighestBidOffer(TradeConstants.RES_TYPE_FOOD) + this.estResource.stone * this.getHighestBidOffer(TradeConstants.RES_TYPE_STONE) + this.estResource.iron * this.getHighestBidOffer(TradeConstants.RES_TYPE_IRON);
         _loc4_ = 350 * this._hf650(TradeConstants.RES_TYPE_WOOD) + 200 * this._hf650(TradeConstants.RES_TYPE_IRON);
         return this._bf968() && this._sf1146() && _loc3_ > (500 + this.fortification.arrowTower) * _loc4_ / 2 * param1;
      }
      
      public function _ji428() : void
      {
         if(this.keepTroopFieldIds.length == 0)
         {
            this.logMsg("KEEPTROOP > keeptroop is not on");
         }
         else
         {
            this.keepTroopFieldIds = new Array();
            this.keepTroopTroopBeans = new Array();
            this.keepTroopMinSents = new Array();
            this.keepTroopTotalFlags = new Array();
            this.logMsg("KEEPTROOP > turn off keep troop");
         }
      }
      
      public function get player() : PlayerBean
      {
         return MainScreen.getPlayer();
      }
      
      private function getTotalAvailableHeroes() : int
      {
         var _loc2_:HeroBean = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.heroes)
         {
            if(_loc2_.status == HeroConstants.HERO_FREE_STATU)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function _ij1069() : void
      {
         var mustOpen:Boolean = false;
         var army:ArmyBean = null;
         var i:int = 0;
         var EVASIONTIME:int = 0;
         try
         {
            if(this.getCfg(CityConfigs.CFG_HIDING) <= 0)
            {
               return;
            }
            mustOpen = this.getLocalBuffByWildCardId("ForceopenclosegateBuff") != null;
            army = null;
            i = 0;
            while(i < this.enemyArmies.length)
            {
               army = this.enemyArmies[i];
               if(Utils.getTroopBeanFromTroopStrBean(army.troop) == null)
               {
                  break;
               }
               if(army.missionType != ObjConstants.ARMY_MISSION_SUPPRESS && !this.isJunkTroop(army.troop) && !this.isNakedScouts(army.troop))
               {
                  break;
               }
               i++;
            }
            if(i == this.enemyArmies.length)
            {
               return;
            }
            EVASIONTIME = 60 * this.getCfg(CityConfigs.CFG_HIDING);
            if(mustOpen || Connection.getInstance().paused || army.reachTime > 0 && army.reachTime - Utils.getServerTime() < EVASIONTIME * 1000 && !this.goOutForBattle)
            {
               this._eu607();
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: handleHiding, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      private function _ap1065(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > troop produce error: " + param1.errorMsg,COLR_DBG_LOG_MSG);
            }
            MasterTimer.getInstance().setNextActiveTime();
         }
         else
         {
            this.troopProductionUpdateNeeded = true;
         }
      }
      
      public function doMailNotification() : void
      {
         if(this.player.newMailCount > 0)
         {
            if(!playerTimingAllowed("mailnotification",this.player.newMaileCount_inbox > 0 ? 300 : 900))
            {
               return;
            }
            this.logMsg("<i>NEW MAILS: " + this.player.newMaileCount_inbox + " inbox, " + this.player.newMaileCount_system + " system</i>","#79796A");
         }
      }
      
      public function _vf712(param1:int, param2:TroopBean, param3:FortificationsBean) : void
      {
         this.logMsg("Set guard on " + Map.fieldIdToString(param1));
         this.guardedTroopBean = param2;
         this.guardedFortificationsBean = param3;
         this.guardedAttackFieldId = param1;
      }
      
      private function _yq108() : Boolean
      {
         var _loc1_:ResourceBean = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!this.cityTimingAllowed("handleZeroFoodQuickBuy",300))
         {
            return false;
         }
         if(!this.isMarketReady() || this.getCfg(CityConfigs.CFG_TRADING) <= 0)
         {
            return false;
         }
         if(this.tradesArray.length >= this.getBuildingLevel(BuildingConstants.TYPE_MARKET))
         {
            return false;
         }
         if(this.resource.food.amount > 10000000)
         {
            return false;
         }
         _loc1_ = this.getIncommingResources();
         if(_loc1_.food > 50000)
         {
            return false;
         }
         _loc2_ = 0;
         _loc3_ = this.getTrimmedMarketPrice(this._hf650(_loc2_) * 1.2);
         _loc4_ = 60000;
         _loc5_ = _loc4_ * _loc3_ * 1.005;
         if(this.resource.gold < _loc5_)
         {
            return false;
         }
         if(this.resource.gold > 4 * _loc5_)
         {
            if(this.resource.gold > 200 * _loc5_)
            {
               _loc4_ = 50 * _loc4_;
            }
            else
            {
               _loc4_ = this.resource.gold / 4 / _loc5_ * _loc4_;
            }
         }
         this.logMsg("ZEROFOOD > Buy " + resourceNames[_loc2_] + ": " + Math.floor(_loc4_) + " at " + _loc3_,COLR_STD_LOG_MSG);
         CityStateCommands.newTrade(this.castleId,_loc2_,TradeConstants.TRADE_TYPE_BUY,_loc4_,"" + _loc3_,this.zeroFoodResponseHandler);
         this.lastZeroFoodOp = Utils.getServerTime();
         return true;
      }
      
      private function _as658(param1:HeroBean) : HeroBean
      {
         return this._mh723("management",param1.id);
      }
      
      private function isConditionsMet(param1:ConditionBean) : Boolean
      {
         var _loc2_:ConditionDependBuildingBean = null;
         var _loc3_:ConditionDependTechBean = null;
         var _loc4_:ItemBean = null;
         var _loc5_:ConditionDependItemBean = null;
         for each(_loc2_ in param1.buildingsArray)
         {
            if(this.getBuildingsCountByTypeAndLvl(_loc2_.typeId,_loc2_.level) == 0)
            {
               return false;
            }
         }
         for each(_loc3_ in param1.techsArray)
         {
            if(!this.isResearchAtLevel(_loc3_.id,_loc3_.level))
            {
               return false;
            }
         }
         _loc4_ = null;
         for each(_loc5_ in param1.itemsArray)
         {
            _loc4_ = this.getItemById(_loc5_.id);
            if(_loc4_ == null || _loc4_.count < _loc5_.num)
            {
               return false;
            }
         }
         return true;
      }
      
      public function _uo1113(param1:String) : Boolean
      {
         var _loc2_:TroopBean = null;
         _loc2_ = Utils.getTroops(param1);
         if(_loc2_ == null)
         {
            this.logMsg("Invalid troop: " + param1);
            return false;
         }
         if(Utils.getTotalTroopCount(_loc2_) > this.getRallyDispatchPerArmyLimit())
         {
            this.logMsg("Too many npc10 troops for current rally spot level");
            return false;
         }
         this.npc10TroopBean = _loc2_;
         return true;
      }
      
      public function _handleAdvEvasion() : Boolean
      {
         var newDate:Date = null;
         var firstField:int = 0;
         var evasionEndTime:Number = NaN;
         var evasionDuration:Number = NaN;
         var rsLevel:int = 0;
         var extraSlot:int = 0;
         var maxWaves:int = 0;
         var rainbowTroops:ArrayCollection = null;
         var enemy:ArmyBean = null;
         var nWaves:int = 0;
         var layerSize:int = 0;
         var tr:TroopBean = null;
         var obj:Object = null;
         var aObj:Object = null;
         var army:ArmyBean = null;
         var allTroops:TroopBean = null;
         var archerWave:Boolean = false;
         var newArmy:NewArmyParam = null;
         var tmpAdvEvade:TroopBean = null;
         var tmpAdvEvadeRule:TroopBean = null;
         var eTroopToEvade:TroopBean = null;
         var handler:Function = null;
         var key:String = null;
         var i:int = 0;
         var desiredCata:int = 0;
         var desiredCav:int = 0;
         var desiredPike:int = 0;
         var desiredSword:int = 0;
         var desiredWorker:int = 0;
         var desiredWarrior:int = 0;
         try
         {
            newDate = new Date();
            if(this.lastBattleAfterAdvMoveErrorTime != null && this.lastBattleAfterAdvMoveErrorTime.getTime() + 3600 * 1000 > newDate.getTime())
            {
               return false;
            }
            if(this.lastAmbushFromAllSideErrorTime != null && this.lastAmbushFromAllSideErrorTime.getTime() + 15 * 60 * 1000 > newDate.getTime())
            {
               return false;
            }
            firstField = this.getFieldIdUsedForHiding();
            if(firstField == -1)
            {
               return false;
            }
            evasionEndTime = this._yb134(this.getCfg(CityConfigs.CFG_ATTACKGAP));
            if(evasionEndTime == 0)
            {
               return false;
            }
            evasionDuration = (evasionEndTime - Utils.getServerTime()) / 1000 + 3;
            if(Connection.getInstance().paused)
            {
               evasionDuration += 35 * 60;
            }
            rsLevel = this.getMaxRallySlots();
            extraSlot = this.getAvailableRallyMaxHidingSlots();
            maxWaves = this.rallySettings[RALLY_RAINBOW] != -1 ? int(this.rallySettings[RALLY_RAINBOW]) : 1;
            rainbowTroops = this.getLocalHidingArmies(firstField);
            if(rainbowTroops.length >= maxWaves)
            {
               return true;
            }
            if(this.getUsedRallySlots() + extraSlot >= rsLevel)
            {
               if(this.cityTimingAllowed("rallyspotadvevasionproblem2",300))
               {
                  if(this.getUsedRallySlots() >= rsLevel)
                  {
                     this.logMsg("ADVEVASION > UNABLE TO EVADE RAINBOW BECAUSE RALLYSPOT IS FULL",COLR_ERR_LOG_MSG);
                  }
                  else
                  {
                     this.logMsg("ADVEVASION > UNABLE TO EVADE RAINBOW, remaining rally spot is for resource hiding",COLR_ERR_LOG_MSG);
                  }
               }
               return false;
            }
            if(this.enemyArmies.length == 0)
            {
               return false;
            }
            enemy = this.enemyArmies[0];
            if(enemy.missionType == ObjConstants.ARMY_MISSION_SUPPRESS)
            {
               return false;
            }
            nWaves = this._uk165(evasionEndTime + 4);
            layerSize = Utils.getTotalTroopCount(Utils.getTroopBeanFromTroopStrBean(enemy.troop)) / 100 * nWaves;
            if(layerSize < 100)
            {
               layerSize = 100;
            }
            if(this.getCfg(CityConfigs.CFG_ADVEVASIONMINLAYERSIZE) > 0)
            {
               layerSize = this.getCfg(CityConfigs.CFG_ADVEVASIONMINLAYERSIZE);
               if(this.getCfg(CityConfigs.CFG_ADVEVASIONLAYERMULTI) > 0)
               {
                  layerSize = int(layerSize * nWaves * this.getCfg(CityConfigs.CFG_ADVEVASIONLAYERMULTI));
               }
               else if(this.getCfg(CityConfigs.CFG_ADVEVASIONLAYERMULTI) == 0)
               {
                  layerSize *= nWaves;
               }
            }
            tr = Utils.getTroopBeanFromTroopStrBean(enemy.troop);
            if(tr == null)
            {
               return false;
            }
            obj = this.troop.toObject();
            aObj = null;
            for each(army in rainbowTroops)
            {
               aObj = army.troop.toObject();
               for(key in aObj)
               {
                  obj[key] += int(aObj[key]);
               }
            }
            allTroops = new TroopBean(obj);
            archerWave = tr.archer + tr.ballista + tr.catapult > 0.67 * Utils.getTotalTroopCount(tr);
            newArmy = new NewArmyParam();
            newArmy.troops = new TroopBean();
            tmpAdvEvade = null;
            tmpAdvEvadeRule = null;
            eTroopToEvade = enemy.troop != null ? Utils.getTroopBeanFromTroopStrBean(enemy.troop) : null;
            if(this.getCfg(CityConfigs.CFG_ADVEVASION) > 0)
            {
               if(this.advEvasionLastArmyID != enemy.armyId)
               {
                  this.advEvasionLastArmyID = enemy.armyId;
                  this.tmpAdvEvadeCache = null;
                  this.tmpAdvEvadeRuleCache = null;
                  i = 0;
                  while(eTroopToEvade != null && this.advEvasionRules && i <= this.advEvasionRules.length)
                  {
                     if(this.advEvasionRules[i] && (this.advEvasionRules[i][0] == null || _jc640RE(eTroopToEvade,this.advEvasionRules[i][0])) && (this.advEvasionRules[i][1] == null || _rm985(this.fortification,this.advEvasionRules[i][1])))
                     {
                        this.tmpAdvEvadeCache = tmpAdvEvade = this.advEvasionRules[i][2];
                        this.tmpAdvEvadeRuleCache = tmpAdvEvadeRule = this.advEvasionRules[i][0];
                        break;
                     }
                     i++;
                  }
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION1)
                  {
                     if(tmpAdvEvade)
                     {
                        this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - Found Rule: - " + Utils.troopBeanToString(tmpAdvEvadeRule),COLR_DBG_LOG_MSG);
                     }
                     else
                     {
                        this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - Rule NOT Found!!!",COLR_DBG_LOG_MSG);
                     }
                  }
               }
               else
               {
                  tmpAdvEvade = this.tmpAdvEvadeCache;
                  tmpAdvEvadeRule = this.tmpAdvEvadeRuleCache;
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION1)
                  {
                     if(tmpAdvEvade)
                     {
                        this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - Found Cache Rule: - " + Utils.troopBeanToString(tmpAdvEvadeRule),COLR_DBG_LOG_MSG);
                     }
                     else
                     {
                        this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - Cache Rule NOT Found!!!",COLR_DBG_LOG_MSG);
                     }
                  }
               }
            }
            if(this.troop.heavyCavalry > 0 && tmpAdvEvade && tmpAdvEvade.heavyCavalry != -2)
            {
               desiredCata = this.troop.pikemen > 0 || this.troop.swordsmen > 0 ? 0 : layerSize;
               desiredCata = archerWave ? (allTroops.heavyCavalry > desiredCata ? desiredCata : (allTroops.heavyCavalry > 20 ? 10 : 1)) : 1;
               if(Boolean(tmpAdvEvade) && tmpAdvEvade.heavyCavalry != -1)
               {
                  desiredCata = Math.abs(tmpAdvEvade.heavyCavalry) + (this.getCfg(CityConfigs.CFG_ADVEVASION) > 1 ? Math.floor(Math.round(this.getCfg(CityConfigs.CFG_ADVEVASION))) : 0);
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION2)
                  {
                     this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - desiredCata " + desiredCata,COLR_DBG_LOG_MSG);
                  }
               }
               if(desiredCata > this.troop.heavyCavalry)
               {
                  desiredCata = this.troop.heavyCavalry;
               }
               newArmy.troops.heavyCavalry = Math.min(this.troop.heavyCavalry - desiredCata,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.lightCavalry > 0 && tmpAdvEvade && tmpAdvEvade.lightCavalry != -2)
            {
               desiredCav = archerWave && tr.lightCavalry > 0 ? layerSize : (this.troop.pikemen > 0 || this.troop.swordsmen > 0 ? 0 : layerSize);
               desiredCav = archerWave ? (allTroops.lightCavalry > desiredCav ? desiredCav : (allTroops.lightCavalry > 20 ? 10 : 1)) : 1;
               if(Boolean(tmpAdvEvade) && tmpAdvEvade.lightCavalry != -1)
               {
                  desiredCav = Math.abs(tmpAdvEvade.lightCavalry) + (this.getCfg(CityConfigs.CFG_ADVEVASION) > 1 ? Math.floor(Math.round(this.getCfg(CityConfigs.CFG_ADVEVASION))) : 0);
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION2)
                  {
                     this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - desiredCav " + desiredCav,COLR_DBG_LOG_MSG);
                  }
               }
               if(desiredCav > this.troop.lightCavalry)
               {
                  desiredCav = this.troop.lightCavalry;
               }
               newArmy.troops.lightCavalry = Math.min(this.troop.lightCavalry - desiredCav,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.pikemen > 0 && tmpAdvEvade && tmpAdvEvade.pikemen != -2)
            {
               desiredPike = layerSize;
               desiredPike = allTroops.pikemen > desiredPike ? desiredPike : (allTroops.pikemen > 20 ? 10 : 1);
               if(Boolean(tmpAdvEvade) && tmpAdvEvade.pikemen != -1)
               {
                  desiredPike = Math.abs(tmpAdvEvade.pikemen) + (this.getCfg(CityConfigs.CFG_ADVEVASION) > 1 ? Math.floor(Math.round(this.getCfg(CityConfigs.CFG_ADVEVASION))) : 0);
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION2)
                  {
                     this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - desiredPike " + desiredPike,COLR_DBG_LOG_MSG);
                  }
               }
               if(desiredPike > this.troop.pikemen)
               {
                  desiredPike = this.troop.pikemen;
               }
               newArmy.troops.pikemen = Math.min(this.troop.pikemen - desiredPike,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.swordsmen > 0 && tmpAdvEvade && tmpAdvEvade.swordsmen != -2)
            {
               desiredSword = layerSize;
               desiredSword = allTroops.swordsmen > desiredSword ? desiredSword : (allTroops.swordsmen > 20 ? 10 : 1);
               if(Boolean(tmpAdvEvade) && tmpAdvEvade.swordsmen != -1)
               {
                  desiredSword = Math.abs(tmpAdvEvade.swordsmen) + (this.getCfg(CityConfigs.CFG_ADVEVASION) > 1 ? Math.floor(Math.round(this.getCfg(CityConfigs.CFG_ADVEVASION))) : 0);
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION2)
                  {
                     this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - desiredSword " + desiredSword,COLR_DBG_LOG_MSG);
                  }
               }
               if(desiredSword > this.troop.swordsmen)
               {
                  desiredSword = this.troop.swordsmen;
               }
               newArmy.troops.swordsmen = Math.min(this.troop.swordsmen - desiredSword,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.peasants > 0 && tmpAdvEvade && tmpAdvEvade.peasants != -2)
            {
               desiredWorker = layerSize;
               desiredWorker = allTroops.peasants > desiredWorker ? desiredWorker : (allTroops.peasants > 20 ? 10 : 1);
               if(Boolean(tmpAdvEvade) && tmpAdvEvade.peasants != -1)
               {
                  desiredWorker = Math.abs(tmpAdvEvade.peasants) + (this.getCfg(CityConfigs.CFG_ADVEVASION) > 1 ? Math.floor(Math.round(this.getCfg(CityConfigs.CFG_ADVEVASION))) : 0);
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION2)
                  {
                     this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - desiredWorker " + desiredWorker,COLR_DBG_LOG_MSG);
                  }
               }
               if(desiredWorker > this.troop.peasants)
               {
                  desiredWorker = this.troop.peasants;
               }
               newArmy.troops.peasants = Math.min(this.troop.peasants - desiredWorker,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.militia > 0 && tmpAdvEvade && tmpAdvEvade.militia != -2)
            {
               desiredWarrior = layerSize;
               desiredWarrior = allTroops.militia > desiredWarrior ? desiredWarrior : (allTroops.militia > 20 ? 10 : 1);
               if(Boolean(tmpAdvEvade) && tmpAdvEvade.militia != -1)
               {
                  desiredWarrior = Math.abs(tmpAdvEvade.militia) + (this.getCfg(CityConfigs.CFG_ADVEVASION) > 1 ? Math.floor(Math.round(this.getCfg(CityConfigs.CFG_ADVEVASION))) : 0);
                  if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION2)
                  {
                     this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > ADVEVASION - desiredWarrior " + desiredWarrior,COLR_DBG_LOG_MSG);
                  }
               }
               if(desiredWarrior > this.troop.militia)
               {
                  desiredWarrior = this.troop.militia;
               }
               newArmy.troops.militia = Math.min(this.troop.militia - desiredWarrior,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.scouter > 0 && this.troop.scouter < 50000)
            {
               newArmy.troops.scouter = Math.min(this.troop.scouter,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(Utils.getTotalTroopCount(newArmy.troops) < 10)
            {
               return true;
            }
            newArmy.targetPoint = firstField;
            newArmy.missionType = ObjConstants.ARMY_MISSION_SEND;
            newArmy.restTime = evasionDuration + 600;
            newArmy.resource = new ResourceBean();
            newArmy.resource.gold = 2;
            if(!this.cityTimingAllowed("rainbowAdvEvasionThrottle",3))
            {
               return false;
            }
            if(!this.isEnoughResourcesToMarch(newArmy))
            {
               if(!(this.getCfg(CityConfigs.CFG_ZEROFOOD) > 0 && this.isZeroFoodActive && this.getZeroFoodArmies().length > 0))
               {
                  if(this.cityTimingAllowed("advevasionretrymsg2",120))
                  {
                     this.logMsg("ADVEVASION > NOT ENOUGH RESOURCE TO SEND OUT RAINBOW!!!",COLR_ERR_LOG_MSG);
                  }
                  return false;
               }
               this.recallZeroFoodArmies();
            }
            if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION && Boolean(tmpAdvEvade))
            {
               this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > Using ADVEVASION : - " + this._getRuleStr(tmpAdvEvadeRule) + " leaving " + this._getRuleStr(tmpAdvEvade),COLR_DBG_LOG_MSG);
               if(eTroopToEvade)
               {
                  this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > Using ADVEVASION against : - " + this._getRuleStr(eTroopToEvade),COLR_DBG_LOG_MSG);
               }
               else
               {
                  this.logMsg("ADVEVASIONDBG(" + this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) + ") > Using ADVEVASION against : - unknown",COLR_DBG_LOG_MSG);
               }
            }
            this.logMsg("ADVEVASION > Sending rainbow to " + Map.fieldIdToString(firstField) + " " + Utils.troopBeanToString(newArmy.troops) + " for " + Utils.formatTime(evasionDuration),COLR_DEF_LOG_MSG);
            handler = null;
            handler = function(param1:CommandResponse):void
            {
               if(MasterTimer.getInstance().canSend(timeSlot))
               {
                  handleArmyCommandResponse(param1);
               }
               if(param1.ok == 1)
               {
                  Utils.callLater(evasionDuration * 1000,_vc796,[newArmy]);
                  Utils.callLater(evasionDuration * 1000 + 5,secondRecall,[newArmy]);
               }
            };
            CityStateCommands.newArmy(this.castleId,newArmy,handler);
            MasterTimer.getInstance().reserveEmergencySlot(this.timeSlot);
            this.doEstimateResource();
            this.adjEstFoodAfterMarch(newArmy);
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("advevasionerror",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "ADVEVASION > Error while handling: startAdvancedRainbowEvasion, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
            return false;
         }
         return true;
      }
      
      private function updateBuildingAndResearchReqs() : void
      {
         var _loc1_:CityCondition = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ConditionBean = null;
         var _loc5_:ConditionDependBuildingBean = null;
         var _loc6_:ConditionDependTechBean = null;
         var _loc7_:CityCondition = null;
         var _loc8_:int = 0;
         this.currRequirements = new ArrayCollection();
         _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < this.buildingRequirements.length)
         {
            for each(_loc1_ in this.buildingRequirements[_loc2_])
            {
               this._ka588(_loc1_);
               if(!this._mo519(_loc1_))
               {
                  if(!(_loc1_.isBuilding && this._mi60(_loc1_)))
                  {
                     if(!(!_loc1_.isBuilding && this._ux814(_loc1_)))
                     {
                        this.currRequirements.addItem(_loc1_);
                     }
                  }
               }
            }
            if(this.currRequirements.length != 0)
            {
               break;
            }
            _loc2_++;
         }
         if(this.currRequirements.length == 0 && this.getCfg(CityConfigs.CFG_BUILDING) > 0)
         {
            if(this.cityTimingAllowed("nobuilding",900))
            {
               this.logMsg("NO MORE BUILDING REQUIREMENT",COLR_STD_LOG_MSG);
            }
         }
         _loc3_ = this.currRequirements.length;
         _loc2_ = 0;
         while(_loc2_ < this.techRequirements.length)
         {
            for each(_loc1_ in this.techRequirements[_loc2_])
            {
               if(!this._ux814(_loc1_))
               {
                  if(!this._mo519(_loc1_))
                  {
                     this.currRequirements.addItem(_loc1_);
                  }
               }
            }
            if(this.currRequirements.length != _loc3_)
            {
               break;
            }
            _loc2_++;
         }
         if(this.currRequirements.length == _loc3_ && this.getCfg(CityConfigs.CFG_RESEARCH) > 0)
         {
            if(this.cityTimingAllowed("notech",900))
            {
               this.logMsg("NO MORE TECH REQUIREMENT",COLR_STD_LOG_MSG);
            }
         }
         _loc4_ = null;
         _loc5_ = null;
         _loc6_ = null;
         _loc7_ = null;
         _loc2_ = 0;
         while(_loc2_ < this.currRequirements.length)
         {
            _loc1_ = this.currRequirements[_loc2_];
            if(++_loc2_ > 1000)
            {
               this.errorCaught("updateCurrRequirements, requirement is too long");
               break;
            }
            if(_loc1_.level != 0)
            {
               if(_loc1_.level > 1)
               {
                  _loc7_ = new CityCondition(_loc1_.isBuilding,_loc1_.typeId,_loc1_.level - 1,_loc1_.count);
                  if(!this._mo519(_loc7_))
                  {
                     this.currRequirements.addItem(_loc7_);
                  }
               }
               _loc4_ = this.getConditionBeanForUpgradingTo(_loc1_);
               if(_loc4_ != null)
               {
                  for each(_loc5_ in _loc4_.buildingsArray)
                  {
                     if(!_loc5_.successFlag)
                     {
                        if(this.getBuildingsCountByTypeAndLvl(_loc5_.typeId,_loc5_.level) < 1)
                        {
                           this.currRequirements.addItem(new CityCondition(true,_loc5_.typeId,_loc5_.level));
                        }
                     }
                  }
                  for each(_loc6_ in _loc4_.techsArray)
                  {
                     if(!_loc6_.successFlag)
                     {
                        if(!this.isResearchAtLevel(_loc6_.id,_loc6_.level))
                        {
                           this.currRequirements.addItem(new CityCondition(false,_loc6_.id,_loc6_.level));
                        }
                     }
                  }
               }
            }
         }
         _loc8_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this.currRequirements.length)
         {
            _loc8_ = _loc2_ + 1;
            while(_loc8_ < this.currRequirements.length)
            {
               if((this.currRequirements[_loc2_] as CityCondition)._dj829(this.currRequirements[_loc8_]))
               {
                  this.currRequirements.removeItemAt(_loc2_);
                  _loc2_--;
                  break;
               }
               _loc8_++;
            }
            _loc2_++;
         }
      }
      
      public function _setValleyTroops(param1:String) : Boolean
      {
         var _loc2_:TroopBean = null;
         _loc2_ = Utils.getTroops(param1);
         if(_loc2_ == null)
         {
            this.logMsg("Invalid troop: " + param1);
            return false;
         }
         if(Utils.getTotalTroopCount(_loc2_) > this.getRallyDispatchPerArmyLimit())
         {
            this.logMsg("Too many valley troops for current rally spot level");
            return false;
         }
         this.valleyTroopBean = _loc2_;
         return true;
      }
      
      public function _setBuildNewCityLoc(param1:int) : void
      {
         if(buildCityLocation != -1)
         {
            this.logMsg("A city is scheduled to be built at " + Map.fieldIdToString(buildCityLocation) + ", please try later");
            return;
         }
         this.logMsg("Schedule to build a city at " + Map.fieldIdToString(param1));
         buildCityLocation = param1;
         buildCityFrom = this.castle.fieldId;
         this._wf882();
      }
      
      private function isWarTownOn(param1:int = 0) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:ColonyBean = null;
         var _loc9_:int = 0;
         var _loc10_:Date = null;
         if(this.getCfg(CityConfigs.CFG_SAFEMAINT) > 0 && estimateMaintenanceDownTime > Utils.getServerTime())
         {
            if(Utils.getServerTime() + param1 * 1000 > estimateMaintenanceDownTime - 10 * 1000)
            {
               return true;
            }
         }
         _loc2_ = new Date();
         if(this.getCfg(CityConfigs.CFG_AUTOWARPOL) > 0)
         {
            _loc8_ = null;
            if(this.colonies.length > 0)
            {
               _loc8_ = this.colonies[0];
            }
            if(_loc8_ != null && _loc8_.status != ColonyConstants.COLONY_STATUS_OCCUPIED)
            {
               _loc9_ = Math.min(10,this.getCfg(CityConfigs.CFG_AUTOWARPOL)) * 60 * 1000;
               _loc10_ = new Date(_loc8_.endTime - _loc9_);
               if(_loc2_.time > _loc10_.time)
               {
                  return true;
               }
            }
         }
         if(this.getCfg(CityConfigs.CFG_WARTOWN) <= 0)
         {
            return false;
         }
         if(this.wartownSchedule == null)
         {
            return true;
         }
         _loc2_.setTime(Utils.getServerTime());
         _loc3_ = _loc2_.getHours() * 60 + _loc2_.getMinutes();
         _loc2_.setTime(Utils.getServerTime() + param1 * 1000);
         _loc4_ = _loc2_.getHours() * 60 + _loc2_.getMinutes();
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
         while(_loc7_ < this.wartownSchedule.length - 1)
         {
            _loc5_ = int(this.wartownSchedule[_loc7_]);
            _loc6_ = int(this.wartownSchedule[_loc7_ + 1]);
            if(_loc5_ < _loc6_ && _loc5_ <= _loc3_ && _loc3_ <= _loc6_)
            {
               return true;
            }
            if(_loc5_ > _loc6_ && (_loc5_ <= _loc3_ || _loc3_ <= _loc6_))
            {
               return true;
            }
            if(_loc5_ < _loc6_ && _loc5_ <= _loc4_ && _loc4_ <= _loc6_)
            {
               return true;
            }
            if(_loc5_ > _loc6_ && (_loc5_ <= _loc4_ || _loc4_ <= _loc6_))
            {
               return true;
            }
            if(_loc3_ < _loc4_ && _loc3_ <= _loc5_ && _loc5_ <= _loc4_)
            {
               return true;
            }
            if(_loc3_ > _loc4_ && (_loc3_ <= _loc5_ || _loc5_ <= _loc4_))
            {
               return true;
            }
            _loc7_ += 2;
         }
         return false;
      }
      
      public function _recallIncomingArmies() : void
      {
         var _loc1_:ArmyBean = null;
         for each(_loc1_ in this.friendlyArmies)
         {
            if(_loc1_.direction != ArmyConstants.ARMY_BACKWARD)
            {
               if(_loc1_.targetFieldId == this.castle.fieldId)
               {
                  this.logMsg("Recall friendly troop " + _loc1_.armyId + " from " + _loc1_.startPosName);
                  ActionFactory.getInstance().getArmyCommands().callBackArmy(this.castleId,_loc1_.armyId);
               }
            }
         }
         for each(_loc1_ in this.selfArmies)
         {
            if(_loc1_.direction != ArmyConstants.ARMY_BACKWARD)
            {
               if(_loc1_.targetFieldId == this.castle.fieldId)
               {
                  this.logMsg("Recall own troop " + _loc1_.armyId + " from " + _loc1_.startPosName);
                  ActionFactory.getInstance().getArmyCommands().callBackArmy(this.castleId,_loc1_.armyId);
               }
            }
         }
      }
      
      private function _gb172() : HeroBean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:HeroBean = null;
         _loc1_ = null;
         for each(_loc2_ in this.heroes)
         {
            if(!(_loc2_.status != HeroConstants.HERO_FREE_STATU && _loc2_.status != HeroConstants.HERO_CHIEF_STATU))
            {
               if(_loc1_ == null || Utils.isBestHeroByType("power",_loc2_,_loc1_))
               {
                  _loc1_ = _loc2_;
               }
            }
         }
         return _loc1_;
      }
      
      private function _rd1036(param1:int) : ArrayCollection
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:ArmyBean = null;
         _loc2_ = new ArrayCollection();
         for each(_loc3_ in this.selfArmies)
         {
            if(_loc3_.startFieldId == this.castle.fieldId)
            {
               if(_loc3_.targetFieldId == param1 && _loc3_.direction == ArmyConstants.ARMY_BACKWARD && !this.isResoBeanEmtpy(_loc3_.resource))
               {
                  _loc2_.addItem(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      private function _va266(param1:int, param2:Number) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:ArmyBean = null;
         _loc3_ = false;
         for each(_loc4_ in this.selfArmies)
         {
            if(_loc4_.startFieldId == this.castle.fieldId)
            {
               if(!(_loc4_.missionType != ObjConstants.ARMY_MISSION_OCCUPY || _loc4_.direction != ArmyConstants.ARMY_FORWARD))
               {
                  if(_loc4_.targetFieldId == param1)
                  {
                     if(_loc4_.reachTime >= param2)
                     {
                        _loc3_ = true;
                        CityStateCommands.callBackArmy(this.castleId,_loc4_.armyId);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function _rf293() : Number
      {
         return Math.max(0,1000000 + 3000000 * this._hf650(0) + (10000000 - this.resource.wood.amount) * this._hf650(1) + (10000000 - this.resource.stone.amount) * this._hf650(2) + (10000000 - this.resource.iron.amount) * this._hf650(3));
      }
      
      public function isBuildingAlreadyMaxLevel(param1:BuildingBean) : Boolean
      {
         if(param1.level >= this.MAXBUILDINGLEVEL)
         {
            return true;
         }
         if(!BuildingType.isExteriorBuilding(param1.typeId) && param1.level >= 10)
         {
            return true;
         }
         return false;
      }
      
      private function getTroopForFarmNpc10() : TroopBean
      {
         var _loc1_:TroopBean = null;
         _loc1_ = null;
         if(this.npc10TroopBean != null)
         {
            _loc1_ = this.npc10TroopBean;
         }
         else
         {
            _loc1_ = new TroopBean();
            _loc1_.peasants = 2000;
            _loc1_.militia = 2000;
            _loc1_.scouter = 4000;
            _loc1_.swordsmen = 1;
            _loc1_.pikemen = 1;
            _loc1_.archer = 90098;
            _loc1_.carriage = 1900;
         }
         if(isEnoughTroops(this.troop,_loc1_))
         {
            return _loc1_;
         }
         return null;
      }
      
      private function _vq1155(param1:int) : ArrayCollection
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:ArmyBean = null;
         _loc2_ = new ArrayCollection();
         for each(_loc3_ in this.selfArmies)
         {
            if(_loc3_.startFieldId == this.castle.fieldId)
            {
               if(_loc3_.targetFieldId == param1 && _loc3_.direction == ArmyConstants.ARMY_FORWARD && !this.isResoBeanEmtpy(_loc3_.resource))
               {
                  _loc2_.addItem(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      private function hasBuildingsForGearUpgrade(param1:AvailableResearchListBean, param2:Object) : Boolean
      {
         var _loc3_:* = false;
         _loc3_ = param2[BuildingConstants.TYPE_WORKSHOP] > param1.level;
         if(param1.typeId == EquipmentTech.WEAPON_TECH || param1.typeId == EquipmentTech.SHIELD_TECH)
         {
            return _loc3_ && param2[BuildingConstants.TYPE_BLACKSMITH] > param1.level;
         }
         if(param1.typeId == EquipmentTech.MOUNTS_TECH)
         {
            return param2[BuildingConstants.TYPE_STABLE] > param1.level && param2[BuildingConstants.TYPE_BLACKSMITH] > param1.level;
         }
         if(param1.typeId == EquipmentTech.NECKLACE_TECH || param1.typeId == EquipmentTech.ACCESSORIES_TECH || param1.typeId == EquipmentTech.RING_TECH)
         {
            return _loc3_ && param2[BuildingConstants.TYPE_MARKET] > param1.level;
         }
         return _loc3_;
      }
      
      private function recallZeroFoodArmies() : Boolean
      {
         var _loc1_:ArrayCollection = null;
         var _loc2_:ArmyBean = null;
         if(this.foodHideLoc == -1)
         {
            return false;
         }
         _loc1_ = this.getZeroFoodArmies();
         if(_loc1_.length == 0)
         {
            return false;
         }
         if(Connection.getInstance().paused)
         {
            return false;
         }
         for each(_loc2_ in _loc1_)
         {
            this.logMsg("ZEROFOOD > Recall troop " + Utils.troopStrBeanToMsgString(_loc2_.troop,true) + " carrying f:" + _loc2_.resource.food + " from " + Map.fieldIdToString(_loc2_.targetFieldId),COLR_STD_LOG_MSG);
            this.lastZeroFoodOp = Utils.getServerTime();
            CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
         }
         return true;
      }
      
      public function _getFortRuleStr(param1:FortificationsBean) : String
      {
         if(param1 != null)
         {
            return "tra: " + param1.trap + ", ab: " + param1.abatis + ", at: " + param1.arrowTower + ", r: " + param1.rollingLogs + ", tre: " + param1.rockfall;
         }
         return "none";
      }
      
      private function _cx1101(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:TroopProduceListBean = null;
         for each(_loc4_ in this.troopListArray)
         {
            if(_loc4_.typeId == param1)
            {
               if(!this._wb445(_loc4_.conditionBean,param2))
               {
                  return false;
               }
               if(this.estResource.gold < param3 * _loc4_.conditionBean.gold + 3000 || this.estResource.food < param3 * _loc4_.conditionBean.food + 3000 || this.estResource.wood < param3 * _loc4_.conditionBean.wood + 3000 || this.estResource.stone < param3 * _loc4_.conditionBean.stone + 3000 || this.estResource.iron < param3 * _loc4_.conditionBean.iron + 3000 || this.estResource.curPopulation < param3 * troopPopulations[param1])
               {
                  return false;
               }
               return true;
            }
         }
         return false;
      }
      
      private function _ps872(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:AllProduceBean = null;
         var _loc5_:ProduceBean = null;
         _loc2_ = 0;
         _loc3_ = false;
         for each(_loc4_ in this.fortificationProduceQueue)
         {
            _loc3_ = true;
            for each(_loc5_ in _loc4_.allProduceQueueArray)
            {
               if(_loc5_.type == param1 && _loc5_.num == 1)
               {
                  break;
               }
               if(_loc5_.num > 1 || !_loc3_ && _loc5_.type > param1)
               {
                  CityStateCommands.cancelFortificationProduce(this.castleId,_loc5_.queueId);
                  this.fortificationProductionUpdateNeeded = true;
                  _loc2_++;
               }
               _loc3_ = false;
            }
         }
         return _loc2_;
      }
      
      private function _og999(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("trading error: " + param1.errorMsg);
         }
      }
      
      private function handleBuffUpdate(param1:CastleBuffUpdate) : void
      {
         if(param1.buffBean == null || param1.castleid != this.castleId)
         {
            return;
         }
         var _loc2_:int = this.getCastleBuffIndexFromTypeId(param1.buffBean.typeId);
         var _loc3_:String = "#225555";
         if(param1.updateType != 2)
         {
            if(param1.updateType != 0)
            {
               if(param1.updateType != 1)
               {
                  this.logMsg("CASTLEBUFFUPDATE > ignore local buff update " + param1.updateType + " on " + param1.buffBean.typeId,_loc3_);
               }
               else
               {
                  this.logMsg("CASTLEBUFFUPDATE > Local buff <b>removed</b>: <u>" + param1.buffBean.typeId + "</u>: " + param1.buffBean.descName,_loc3_);
                  if(_loc2_ != -1)
                  {
                     this.castle.buffsArray.removeItemAt(_loc2_);
                  }
               }
            }
            else
            {
               this.logMsg("CASTLEBUFFUPDATE > Local buff <b>added</b>: <u>" + param1.buffBean.typeId + "</u>: " + param1.buffBean.descName + "  <b>remain time</b>: " + Utils.formatTime((param1.buffBean.endTime - Utils.getServerTime()) / 1000),_loc3_);
               if(_loc2_ != -1)
               {
                  this.castle.buffsArray[_loc2_] = param1.buffBean;
               }
               else
               {
                  this.castle.buffsArray.addItem(param1.buffBean);
               }
            }
         }
         else
         {
            this.logMsg("CASTLEBUFFUPDATE > Local buff <b>change</b>: <u>" + param1.buffBean.typeId + "</u>: " + param1.buffBean.descName + "  <b>remain time</b>: " + Utils.formatTime((param1.buffBean.endTime - Utils.getServerTime()) / 1000),_loc3_);
            if(_loc2_ == -1)
            {
               this.castle.buffsArray.addItem(param1.buffBean);
            }
            else
            {
               this.castle.buffsArray[_loc2_] = param1.buffBean;
            }
         }
      }
      
      private function _bv514(param1:int) : Boolean
      {
         return this.resourceType == null && param1 == this.resourceFieldType || this.resourceType != null && this.resourceType.indexOf(param1) != -1;
      }
      
      public function _gs965() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         _loc1_ = "";
         for(_loc2_ in this.cityCfg.configs)
         {
            _loc1_ += _loc2_ + ":" + this.cityCfg.configs[_loc2_] + ", ";
         }
         this.logMsg("Config: " + _loc1_.substring(0,_loc1_.length - 2));
      }
      
      private function get _cd932() : int
      {
         return this.rallySettings[RALLY_NPC];
      }
      
      public function _nv1116(param1:Boolean, param2:String = null, param3:Boolean = false) : void
      {
         if(param3 && this.getCfg(CityConfigs.CFG_GATE) > 0)
         {
            if(param1)
            {
               this.logErrMsg("gate config is on, please control gate with \'gatepolicy 1 1 1 1 1\' instead");
            }
            else
            {
               this.logErrMsg("gate config is on, please control gate with \'gatepolicy 2 2 2 2 2\' instead");
            }
            return;
         }
         if(param1 == this.goOutForBattle)
         {
            return;
         }
         if(!param3 && this.enemyArmies.length == 0 && Connection.getInstance().paused)
         {
            if(!playerTimingAllowed("pausegatedelay",6))
            {
               return;
            }
         }
         if(param2 != null)
         {
            this.logMsg(param2,COLR_STD_LOG_MSG);
         }
         this.goOutForBattle = param1;
         CityStateCommands.setArmyGoOut(this.castleId,param1);
      }
      
      private function _uk165(param1:Number) : int
      {
         var _loc2_:int = 0;
         var _loc3_:ArmyBean = null;
         var _loc4_:int = 0;
         _loc2_ = 0;
         _loc3_ = null;
         _loc4_ = 0;
         while(_loc4_ < this.enemyArmies.length)
         {
            _loc3_ = this.enemyArmies[_loc4_];
            if(_loc3_.reachTime > param1)
            {
               break;
            }
            if(!(_loc4_ > 0 && this.isJunkTroop(_loc3_.troop)))
            {
               if(!this.isNakedScouts(_loc3_.troop))
               {
                  _loc2_++;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function InitCMValues() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:HeroBean = null;
         _loc1_ = null;
         this.buildings.removeAll();
         for each(_loc1_ in this.castle.buildingsArray)
         {
            this.buildings.addItem(_loc1_);
         }
         this.tradesArray = new ArrayCollection();
         this.transingTradesArray = new ArrayCollection();
         for each(_loc1_ in this.castle.tradesArray)
         {
            this.tradesArray.addItem(_loc1_);
         }
         for each(_loc1_ in this.castle.transingTradesArray)
         {
            this.transingTradesArray.addItem(_loc1_);
         }
         this.fortification = this.castle.fortification;
         this.goOutForBattle = this.castle.goOutForBattle;
         for each(_loc2_ in this.castle.herosArray)
         {
            Utils.formatHeroName(_loc2_);
         }
         this.doEstimateResource();
         if(this.isMainTown())
         {
            seedMarketInterest = 0;
            currMarketInterest = -1;
            lastMarketQueryTime = new Date();
         }
         this.furtherInitNeeded = true;
      }
      
      public function _getSelfArmies() : ArrayCollection
      {
         return this.selfArmies;
      }
      
      private function onCastleUpdate(param1:CastleUpdate) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(param1.updateType == CommonConstants.UPDATE_TYPE_ADD)
         {
            if(param1.castleBean.fieldId == buildCityLocation && buildCityFrom == this.castle.fieldId)
            {
               buildCityLocation = -1;
               this.logMsg("City at " + Map.fieldIdToString(param1.castleBean.fieldId) + " has been built",COLR_STD_LOG_MSG);
               CityStateCommands.newBuilding(param1.castleBean.id,14,BuildingConstants.TYPE_HOUSE,this.onNewBuildingResponse);
               Map.updateInfo(param1.castleBean.fieldId);
               return;
            }
            _loc3_ = false;
            for each(_loc4_ in npcLocations)
            {
               if(_loc4_ == param1.castleBean.fieldId)
               {
                  _loc3_ = true;
                  break;
               }
            }
            if(this.getCfg(CityConfigs.CFG_BUILDNPC) <= 0)
            {
               return;
            }
            if(!_loc3_ && buildCityFrom != -1 && buildCityFrom != this.castle.fieldId)
            {
               return;
            }
            if(!playerTimingAllowed("castleupdate" + param1.castleBean.fieldId,300))
            {
               return;
            }
            if(_loc3_ && (param1.castleBean.buildingsArray.length <= 1 && (param1.castleBean.buildingsArray.length == 0 || param1.castleBean.buildingsArray[0].name == "Town Hall" && param1.castleBean.buildingsArray[0].level <= 1) && param1.castleBean.name == "Flat" && param1.castleBean.herosArray.length == 0 && param1.castleBean.resource.gold <= 5000 && param1.castleBean.resource.food.amount <= 5000 && param1.castleBean.resource.wood.amount <= 5000 && param1.castleBean.resource.stone.amount <= 5000 && param1.castleBean.resource.iron.amount <= 5000))
            {
               this.logMsg("BUILDNPC > New castle for NPC on " + Map.fieldIdToString(param1.castleBean.fieldId),COLR_STD_LOG_MSG);
               this.doAbandonCastle(param1.castleBean);
               if(_loc3_)
               {
                  npcLocations.splice(npcLocations.indexOf(_loc4_),1);
               }
            }
            else if(MainScreen.buildNpcEnabled && (param1.castleBean.buildingsArray.length <= 1 && (param1.castleBean.buildingsArray.length == 0 || param1.castleBean.buildingsArray[0].name == "Town Hall" && param1.castleBean.buildingsArray[0].level <= 1) && param1.castleBean.name == "Flat" && param1.castleBean.herosArray.length == 0 && param1.castleBean.resource.gold <= 5000 && param1.castleBean.resource.food.amount <= 5000 && param1.castleBean.resource.wood.amount <= 5000 && param1.castleBean.resource.stone.amount <= 5000 && param1.castleBean.resource.iron.amount <= 5000))
            {
               this.logMsg("BUILDNPC > Abandon new castle for NPC with no buildings, no heroes, and less than 5k of each resource for NPC: " + param1.castleBean.name + " " + Map.fieldIdToString(param1.castleBean.fieldId),COLR_STD_LOG_MSG);
               this.doAbandonCastle(param1.castleBean);
               if(_loc3_)
               {
                  npcLocations.splice(npcLocations.indexOf(_loc4_),1);
               }
            }
            else
            {
               this.logMsg("New castle at " + param1.castleBean.name + " " + Map.fieldIdToString(param1.castleBean.fieldId),COLR_STD_LOG_MSG);
               if(this.isMainTown())
               {
                  Map.updateInfo(param1.castleBean.fieldId);
               }
               if(param1.castleBean.resource.texRate > 0)
               {
                  this.logMsg("  resetting taxrate on new city from " + param1.castleBean.resource.texRate + " to 0",COLR_DEF_LOG_MSG);
                  CityStateCommands.modifyTaxRate(param1.castleBean.id,0,this.setTaxRateResonseHandler);
               }
               if(param1.castleBean.resource.support < 40 || param1.castleBean.resource.complaint > 0)
               {
                  this.logMsg("  low loyalty " + param1.castleBean.resource.support + " or high grievance " + param1.castleBean.resource.complaint,COLR_DEF_LOG_MSG);
                  if(param1.castleBean.resource.food.amount > Math.min(this.player.playerInfo.prestige / 10 * this.player.castlesArray.length * param1.castleBean.usePACIFY_SUCCOUR_OR_PACIFY_PRAY,10000000))
                  {
                     if(param1.castleBean.resource.support <= 8 || param1.castleBean.resource.complaint > 0 && param1.castleBean.resource.complaint <= 5)
                     {
                        this.logMsg("  using comfort pray on new city",COLR_DEF_LOG_MSG);
                        CityStateCommands.pacifyPeople(param1.castleBean.id,CityStateConstants.COMFORT_PRAY);
                     }
                     else if(param1.castleBean.resource.complaint > 5)
                     {
                        this.logMsg("  using comfort disaster relief on new city",COLR_DEF_LOG_MSG);
                        CityStateCommands.pacifyPeople(param1.castleBean.id,CityStateConstants.COMFORT_RELIEF);
                     }
                  }
               }
            }
         }
      }
      
      private function _ne789(param1:int, param2:int) : int
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param2 <= 0)
         {
            return param1;
         }
         _loc3_ = Math.floor((Math.sqrt(param2) + 1) / 2);
         _loc4_ = param2 - (2 * _loc3_ - 1) * (2 * _loc3_ - 1);
         _loc5_ = 0;
         _loc6_ = 0;
         if(_loc4_ < 2 * _loc3_)
         {
            _loc5_ = -_loc3_ + _loc4_;
            _loc6_ = -_loc3_;
         }
         else if(_loc4_ < 4 * _loc3_)
         {
            _loc5_ = _loc3_;
            _loc6_ = -_loc3_ + (_loc4_ - 2 * _loc3_);
         }
         else if(_loc4_ < 6 * _loc3_)
         {
            _loc5_ = _loc3_ - (_loc4_ - 4 * _loc3_);
            _loc6_ = _loc3_;
         }
         else
         {
            _loc5_ = -_loc3_;
            _loc6_ = _loc3_ - (_loc4_ - 6 * _loc3_);
         }
         if(_loc5_ > _loc3_ || _loc5_ < -_loc3_ || _loc6_ > _loc3_ || _loc6_ < -_loc3_)
         {
            this.logErrMsg("Strange computation result: " + _loc5_ + " " + _loc6_ + " for " + param2);
         }
         return Map.getFieldId(Map.getX(param1) + _loc5_,Map.getY(param1) + _loc6_);
      }
      
      public function _isScoutWarningOn() : Boolean
      {
         var _loc1_:int = this.getCfg(CityConfigs.CFG_ATTACKWARNING);
         return _loc1_ == 1 || _loc1_ == 3;
      }
      
      public function bestAttackHero() : HeroBean
      {
         return this.getBestHeroByType("power");
      }
      
      public function _jh385(param1:String) : Boolean
      {
         return this._setRallyMax("npc:" + param1);
      }
      
      private function _vg607(param1:String) : int
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = "The Loyalty of this city is ";
         _loc3_ = ".";
         _loc4_ = int(param1.indexOf(_loc2_));
         if(_loc4_ == -1)
         {
            return -1;
         }
         _loc5_ = int(param1.indexOf(_loc3_,_loc4_));
         if(_loc5_ == -1)
         {
            return -1;
         }
         return int(param1.substring(_loc4_ + _loc2_.length,_loc5_));
      }
      
      private function _qb1032() : void
      {
         var _loc2_:FieldBean = null;
         if(this.fields.length == 0)
         {
            return;
         }
         var _loc1_:int = this.getCfgBuildNpc();
         for each(_loc2_ in this.fields)
         {
            if(_loc2_.id != buildCityLocation)
            {
               if(!(_loc2_.type == FieldConstants.TYPE_FLAT && this.flatOkayForBuildnpc(_loc2_.id,_loc2_.level)))
               {
                  if(_loc2_.type == FieldConstants.TYPE_FLAT && Map.fieldDistance(_loc2_.id,this.castle.fieldId) <= this.getCfg(CityConfigs.CFG_FLATROLLING))
                  {
                     this.logMsg("FLATROLLING > Abandon rolling flat: " + Map.fieldIdToString(_loc2_.id),COLR_STD_LOG_MSG);
                     CityStateCommands.giveUpField(_loc2_.id);
                  }
               }
            }
         }
      }
      
      private function isNextTrainingHeroStop() : Boolean
      {
         return this.trainingHeroName != null && this.trainingHeroNextStop != this.castle.fieldId;
      }
      
      public function _cp1009() : void
      {
         if(this.keepResourceFieldIds.length == 0)
         {
            this.logMsg("keepresource is not on");
         }
         else
         {
            this.keepResourceFieldIds = new Array();
            this.keepResourceMinResources = new Array();
            this.keepResourceMinSents = new Array();
            this.logMsg("turn off keep resource");
         }
      }
      
      public function setHeroUpdateNeeded(param1:Boolean = true) : void
      {
         this.heroUpdateNeeded = param1;
      }
      
      private function getNextOutTime(param1:int) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:AllProduceBean = null;
         var _loc6_:ProduceBean = null;
         _loc2_ = -1;
         _loc3_ = Utils.getServerTime() + 1000;
         _loc4_ = -1;
         for each(_loc5_ in this.troopProduceQueue)
         {
            _loc4_ = -1;
            for each(_loc6_ in _loc5_.allProduceQueueArray)
            {
               if(_loc4_ == -1)
               {
                  _loc4_ = _loc6_.endTime;
               }
               else
               {
                  _loc4_ += _loc6_.costTime * 1000;
               }
               if(_loc4_ >= _loc3_)
               {
                  if(param1 == _loc6_.type)
                  {
                     _loc2_ = _loc2_ == -1 ? _loc4_ : Math.min(_loc2_,_loc4_);
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function _op598(param1:Boolean, param2:Boolean) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:HeroBean = null;
         var _loc5_:int = 0;
         var _loc6_:MapCastleBean = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:TroopBean = null;
         var _loc11_:MapCastleBean = null;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:NewArmyParam = null;
         var _loc16_:TroopBean = null;
         _loc3_ = this.slowHuntingPolicy[0] <= 0 ? 3600 : int(this.slowHuntingPolicy[0]);
         this._mo1252();
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            return true;
         }
         if(this.fields.length < this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL))
         {
            if(this.cityTimingAllowed("slowhuntingnofield",300))
            {
               this.logMsg("SLOWHUNTING > Slow hunting cannot start until this town has " + this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL) + " valleys",COLR_STD_LOG_MSG);
            }
            return false;
         }
         if(this.getMaxRallySlots() <= 2)
         {
            if(this.cityTimingAllowed("slowhuntinglowrally",300))
            {
               this.logMsg("SLOWHUNTING > Slow hunting cannot start until this town has rally level 2 or more",COLR_STD_LOG_MSG);
            }
            return false;
         }
         if(!param1 || !param2)
         {
            return false;
         }
         if(this.rallyHuntingSetting != -1 && this._de1078(this.lastSlowTargetFields) >= this.rallyHuntingSetting)
         {
            return false;
         }
         if(this.enemyArmies.length > 0 && this.enemyArmies[0].reachTime - Utils.getServerTime() < 7200 * 1000)
         {
            return false;
         }
         _loc4_ = this.getNextValleyHero();
         if(_loc4_ == null)
         {
            return false;
         }
         _loc5_ = -1;
         if(this.currentSlowTarget != -1)
         {
            _loc14_ = 0;
            while(_loc14_ < this.localFieldsDetailInfo.length)
            {
               if(this.localFieldsDetailInfo[_loc14_].id == this.currentSlowTarget)
               {
                  _loc5_ = _loc14_;
                  break;
               }
               _loc14_++;
            }
            if(_loc5_ == -1)
            {
               this.currentSlowTarget = -1;
            }
         }
         _loc6_ = null;
         _loc7_ = 0;
         if(this.currentSlowTarget != -1)
         {
            _loc15_ = null;
            if(lastSlowTargetTroops[this.currentSlowTarget] == undefined)
            {
               if(this.nextSlowScoutCheck != -1 && Utils.getServerTime() <= this.nextSlowScoutCheck)
               {
                  return false;
               }
               if(this.nextSlowScoutCheck != -1 && Utils.getServerTime() > this.nextSlowScoutCheck)
               {
                  this.logMsg("SLOWHUNTING > Failure to obtain scout report for: " + Map.fieldIdToString(this.currentSlowTarget) + ", skipping it",COLR_STD_LOG_MSG);
                  this.currentSlowTarget = -1;
                  return false;
               }
               if(this.troop.scouter == 0)
               {
                  if(this._de1078(this.lastSlowTargetFields) == 0 && this.cityTimingAllowed("slowhunting",600))
                  {
                     this.logMsg("SLOWHUNTING > SLOWHUNTING: NO SCOUT IS AVAILABLE TO SCOUT TARGETS",COLR_STD_LOG_MSG);
                  }
                  return false;
               }
               _loc15_ = new NewArmyParam();
               _loc15_.missionType = ObjConstants.ARMY_MISSION_SCOUT;
               _loc15_.targetPoint = this.currentSlowTarget;
               _loc15_.troops = new TroopBean();
               _loc15_.troops.scouter = 1;
               _loc15_.resource = new ResourceBean();
               if(!this.isEnoughResourcesToMarch(_loc15_) || this.isWarTownOn(2 * this.getTravelTimeReliefStationAdj(_loc15_)))
               {
                  return false;
               }
               this.logMsg("SLOWHUNTING > scout local field " + Map.fieldIdToString(this.currentSlowTarget) + " in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc15_)),COLR_STD_LOG_MSG);
               CityStateCommands.newArmy(this.castle.id,_loc15_,this.handleArmyCommandResponse);
               this.adjEstFoodAfterMarch(_loc15_);
               Map.updateDetailInfo(this.currentSlowTarget);
               Map.updateInfo(this.currentSlowTarget);
               this.nextSlowScoutCheck = Utils.getServerTime() + 1000 * this.getTravelTimeReliefStationAdj(_loc15_) + 60 * 1000;
               return true;
            }
            _loc6_ = Map.getDetail(this.currentSlowTarget);
            _loc7_ = Map.getLevel(this.currentSlowTarget);
            if(_loc6_ == null || _loc7_ == -1)
            {
               return false;
            }
            this.localFieldsDetailInfo[_loc5_] = _loc6_;
            if(!_loc6_.canOccupy || _loc6_.state != 1 || _loc6_.userName != null)
            {
               this.logMsg("SLOWHUNTING > CANNOT ATTACK " + Map.fieldIdToString(_loc6_.id),COLR_STD_LOG_MSG);
               this.localFieldsDetailInfo.removeItemAt(_loc5_);
               return false;
            }
            _loc16_ = this._os434(_loc7_,lastSlowTargetTroops[this.currentSlowTarget]);
            if(!(lastSlowTargetTroops[this.currentSlowTarget] != null && Utils.getTotalTroopCount(lastSlowTargetTroops[this.currentSlowTarget]) == 0))
            {
               if(_loc16_ == null || !isEnoughTroops(this.getAllTroopsInCastle(),_loc16_))
               {
                  this.logMsg("SLOWHUNTING > Remove target: " + Map.fieldIdToString(this.currentSlowTarget) + " " + Utils.troopBeanToString(lastSlowTargetTroops[this.currentSlowTarget]),COLR_STD_LOG_MSG);
                  this.currentSlowTarget = -1;
                  this.localFieldsDetailInfo.removeItemAt(_loc5_);
                  return false;
               }
               if(Utils.getTotalTroopCount(_loc16_) > this.getRallyDispatchPerArmyLimit())
               {
                  this.logMsg("SLOWHUNTING > Remove target: " + Map.fieldIdToString(this.currentSlowTarget) + ", rally cannot accommodate " + Utils.troopBeanToMsgString(_loc16_),COLR_STD_LOG_MSG);
                  this.currentSlowTarget = -1;
                  this.localFieldsDetailInfo.removeItemAt(_loc5_);
                  return false;
               }
               if(_mo116(lastSlowTargetTroops[this.currentSlowTarget]) && Map.fieldDistance(this.castle.fieldId,this.currentSlowTarget) > this.slowHuntingPolicy[4])
               {
                  this.logMsg("SLOWHUNTING > Remove target: " + Map.fieldIdToString(this.currentSlowTarget) + ", more than " + this.slowHuntingPolicy[4] + " miles away",COLR_STD_LOG_MSG);
                  this.currentSlowTarget = -1;
                  this.localFieldsDetailInfo.removeItemAt(_loc5_);
                  return false;
               }
               if(!isEnoughTroops(this.troop,_loc16_))
               {
                  if(this._de1078(this.lastSlowTargetFields) == 0 && this.cityTimingAllowed("slowhunting",600))
                  {
                     this.logMsg("SLOWHUNTING > NOT ENOUGH TROOP TO ATTACK " + Map.fieldIdToString(this.currentSlowTarget) + ", need " + Utils.troopBeanToMsgString(_loc16_),COLR_STD_LOG_MSG);
                  }
                  return false;
               }
               _loc15_ = new NewArmyParam();
               _loc15_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
               _loc15_.heroId = _loc4_.id;
               _loc15_.targetPoint = this.currentSlowTarget;
               _loc15_.troops = _loc16_;
               _loc15_.resource = new ResourceBean();
               if(!this.isEnoughResourcesToMarch(_loc15_))
               {
                  return false;
               }
               if(this.isWarTownOn(2 * this.getTravelTimeReliefStationAdj(_loc15_)))
               {
                  return false;
               }
               if(!playerTimingAllowed("attack" + this.currentSlowTarget,8))
               {
                  return false;
               }
               this.logMsg("SLOWHUNTING > attack local field " + Map.fieldIdToString(this.currentSlowTarget) + " with hero " + Utils.heroBeanToString(_loc4_) + " and " + Utils.troopBeanToMsgString(_loc16_) + " " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc15_)),COLR_STD_LOG_MSG);
               CityStateCommands.newArmy(this.castle.id,_loc15_,this.handleArmyCommandResponse);
               if(this.lastSlowTargetFields.indexOf(this.currentSlowTarget) == -1)
               {
                  this.lastSlowTargetFields.push(this.currentSlowTarget);
               }
               this.lastSlowTargetLevels[this.currentSlowTarget] = _loc7_;
               this.adjEstFoodAfterMarch(_loc15_);
               Map.updateDetailInfo(this.currentSlowTarget);
               Map.updateInfo(this.currentSlowTarget);
               this.currentSlowTarget = -1;
               return true;
            }
            this.currentSlowTarget = -1;
         }
         _loc8_ = "";
         _loc9_ = 0;
         while(_loc9_ < this.localFieldsDetailInfo.length)
         {
            _loc8_ += " " + Map.fieldIdToCoordString(this.localFieldsDetailInfo[_loc9_].id);
            _loc9_++;
         }
         _loc10_ = new TroopBean();
         _loc10_.archer = 1;
         _loc11_ = null;
         _loc12_ = NaN;
         _loc13_ = 0;
         _loc5_ = 0;
         while(_loc5_ < this.localFieldsDetailInfo.length)
         {
            _loc11_ = this.localFieldsDetailInfo[_loc5_];
            _loc12_ = this.getBaseTravelTime(this.castle.fieldId,_loc11_.id,_loc10_);
            if(playerArmyTimingAllowed("slowhunting" + _loc11_.id,_loc12_,_loc3_,true))
            {
               _loc6_ = Map.getDetail(_loc11_.id);
               _loc7_ = Map.getLevel(_loc11_.id);
               if(_loc6_ == null || _loc7_ == -1)
               {
                  return false;
               }
               this.localFieldsDetailInfo[_loc5_] = _loc6_;
               if(!_loc6_.canOccupy || _loc6_.state != 1 || _loc6_.userName != null)
               {
                  this.logMsg("SLOWHUNTING > CANNOT SCOUT " + Map.fieldIdToString(_loc6_.id),COLR_STD_LOG_MSG);
                  this.localFieldsDetailInfo.removeItemAt(_loc5_);
                  return false;
               }
               _loc13_ = Map.getType(_loc6_.id);
               if(_loc13_ == -1)
               {
                  return false;
               }
               if(_loc13_ == FieldConstants.TYPE_NPC || _loc13_ == FieldConstants.TYPE_CASTLE)
               {
                  this.logMsg("SLOWHUNTING > Local field is now a npc or castle: " + Map.fieldIdToString(_loc6_.id),COLR_STD_LOG_MSG);
                  this.localFieldsDetailInfo.removeItemAt(_loc5_);
                  return false;
               }
               this.currentSlowTarget = _loc6_.id;
               this.nextSlowScoutCheck = -1;
               if(_loc7_ <= 3)
               {
                  lastSlowTargetTroops[this.currentSlowTarget] = new TroopBean();
                  lastSlowTargetTroops[this.currentSlowTarget].militia = 1;
               }
               else if(lastSlowTargetTroops[this.currentSlowTarget] != undefined)
               {
                  delete lastSlowTargetTroops[this.currentSlowTarget];
               }
               playerArmyTimingAllowed("slowhunting" + this.currentSlowTarget,_loc12_,_loc3_);
               return false;
            }
            _loc5_++;
         }
         if(this.candidateLocalFields != null && this.candidateLocalFields.length == 0 && this.distanceSettings[DISTANCE_HUNTING] < 30)
         {
            if(this.distanceSettings[DISTANCE_HUNTING] < 15)
            {
               this.distanceSettings[DISTANCE_HUNTING] = 15;
            }
            this.distanceSettings[DISTANCE_HUNTING] = int(this.distanceSettings[DISTANCE_HUNTING] * 1.3);
            this.candidateLocalFields = null;
         }
         return false;
      }
      
      public function _mo666(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.reservedHeroes = _loc2_;
         this.logMsg("Overriding default reserved heroes to: " + param1,COLR_STD_LOG_MSG);
      }
      
      private function doTrade() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = false;
         var _loc3_:Number = NaN;
         var _loc4_:ResourceBean = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:TransingTradeBean = null;
         var _loc11_:TradeBean = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Array = null;
         var _loc19_:Array = null;
         var _loc20_:Boolean = false;
         var _loc21_:Number = NaN;
         var _loc22_:Boolean = false;
         var _loc23_:Number = NaN;
         var _loc24_:int = 0;
         var _loc25_:CityCondition = null;
         var _loc26_:CityCondition = null;
         if(!this.isMarketReady())
         {
            return;
         }
         _loc1_ = 0;
         if(market_internal != null)
         {
            if(playerTimingAllowed("updateinternalmarket",15))
            {
               _loc1_ = 0;
               while(_loc1_ < 4)
               {
                  market_internal[_loc1_] = (this._hf650(_loc1_) + this.getHighestBidOffer(_loc1_)) / 2 * 0.004 + market_internal[_loc1_] * 0.996;
                  _loc1_++;
               }
            }
         }
         else
         {
            market_internal = new Array();
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               market_internal[_loc1_] = (this._hf650(_loc1_) + this.getHighestBidOffer(_loc1_)) / 2;
               _loc1_++;
            }
         }
         if(this.getCfg(CityConfigs.CFG_TRADING) <= 0)
         {
            return;
         }
         if(this.tradingLimited)
         {
            return;
         }
         _loc2_ = this.getCfg(CityConfigs.CFG_TRADING) >= 3;
         if(this.getCfg(CityConfigs.CFG_TRADING) >= 2)
         {
            if(!_loc2_ && this.getCfg(CityConfigs.CFG_BUILDING) > 0)
            {
               _loc25_ = this.futureBuildingCondition();
               if(_loc25_ != null && !this._dx690(_loc25_))
               {
                  _loc2_ = true;
               }
            }
            if(!_loc2_ && this.getCfg(CityConfigs.CFG_RESEARCH) > 0)
            {
               _loc26_ = this.futureTechCondition();
               if(_loc26_ != null && !this._dx690(_loc26_))
               {
                  _loc2_ = true;
               }
            }
            if(!_loc2_ && this.estResource.food < this.workOutAvailableFood())
            {
               _loc2_ = true;
            }
            if(!_loc2_ && this.resource.herosSalary > this.resource.curPopulation && this.estResource.gold <= 10 * (this.resource.herosSalary - this.resource.curPopulation))
            {
               _loc2_ = true;
            }
            if(this.tradesArray.length > 0 && (_loc2_ || playerTimingAllowed("reprice",300)))
            {
               _loc1_ = 0;
               while(_loc1_ < 4)
               {
                  this._ik745(0,_loc1_,_loc2_);
                  this._qn996(0,_loc1_,_loc2_);
                  _loc1_++;
               }
               return;
            }
         }
         if(!this.cityTimingAllowed("trade",15))
         {
            return;
         }
         _loc3_ = Math.max(this.resource.food.increaseRate,this.resource.wood.increaseRate,this.resource.stone.increaseRate,this.resource.iron.increaseRate);
         _loc4_ = this._ps301();
         _loc5_ = this.resourceMaxLimits == null ? new Array(Math.max(_loc4_.food,12000000),Math.max(this.resource.wood.max * 2 / 3,12000000),Math.max(this.resource.stone.max * 2 / 3,12000000),Math.max(this.resource.iron.max * 2 / 3,12000000)) : this.resourceMaxLimits;
         _loc6_ = this.resourceMinLimits == null ? new Array(Math.min(_loc5_[0],2000000),Math.min(_loc5_[1],2000000),Math.min(_loc5_[2],2000000),Math.min(_loc5_[2],2000000)) : this.resourceMinLimits;
         _loc7_ = new Array(this.estResource.food,this.estResource.wood,this.estResource.stone,this.estResource.iron);
         _loc8_ = new Array(this.estResource.food - _loc4_.food,this.estResource.wood + this.resource.wood.increaseRate / 4 - _loc4_.wood,this.estResource.stone - _loc4_.stone,this.estResource.iron - _loc4_.iron);
         _loc9_ = new Array(this.estResource.food - _loc4_.food,this.estResource.wood + this.resource.wood.increaseRate / 4 - _loc4_.wood,this.estResource.stone - _loc4_.stone,this.estResource.iron - _loc4_.iron);
         for each(_loc10_ in this.transingTradesArray)
         {
            _loc9_[_loc10_.resType] += _loc10_.amount;
         }
         for each(_loc11_ in this.tradesArray)
         {
            if(_loc11_.tradeType == TradeConstants.TRADE_TYPE_BUY)
            {
               _loc9_[_loc11_.resType] += _loc11_.amount - _loc11_.dealedAmount;
            }
            else if(_loc11_.tradeType == TradeConstants.TRADE_TYPE_SELL)
            {
               _loc9_[_loc11_.resType] += _loc11_.amount - _loc11_.dealedAmount;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(_loc6_[_loc1_] < 0)
            {
               _loc6_[_loc1_] = 0;
            }
            if(_loc5_[_loc1_] < _loc6_[_loc1_])
            {
               _loc5_[_loc1_] = _loc6_[_loc1_];
            }
            if(_loc6_[_loc1_] == 0 && _loc5_[_loc1_] == 0)
            {
               _loc9_[_loc1_] = 0;
               _loc7_[_loc1_] = 0;
               _loc8_[_loc1_] = 0;
            }
            _loc1_++;
         }
         if(this.getCfg(CityConfigs.CFG_ZEROFOOD) > 0 && this.isZeroFoodActive)
         {
            _loc5_[0] = 0;
            _loc6_[0] = 0;
            _loc8_[0] = 0;
            _loc7_[0] = 0;
            _loc9_[0] = 0;
         }
         _loc12_ = this.estResource.gold - _loc4_.gold + _loc9_[0] * market_internal[0] + _loc9_[1] * market_internal[1] + _loc9_[2] * market_internal[2] + _loc9_[3] * market_internal[3];
         if(_loc12_ < 0 && _loc9_[TradeConstants.RES_TYPE_FOOD] > 0)
         {
            if(this.getCfg(CityConfigs.CFG_DEBUG) > 0 && this.cityTimingAllowed("tradenotenoughresource",300))
            {
               this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > TRADE > Trading: Food is ok " + Utils.abbrNum(_loc9_[TradeConstants.RES_TYPE_FOOD]) + ", but there is no extra resource to trade",COLR_DBG_LOG_MSG);
            }
            return;
         }
         _loc13_ = 1.1 * (_loc5_[0] * market_internal[0] + _loc5_[1] * market_internal[1] + _loc5_[2] * market_internal[2] + _loc5_[3] * market_internal[3]);
         _loc14_ = 1.1 * (_loc6_[0] * market_internal[0] + _loc6_[1] * market_internal[1] + _loc6_[2] * market_internal[2] + _loc6_[3] * market_internal[3]);
         _loc15_ = 10000000 * (market_internal[0] + market_internal[1] + market_internal[2] + market_internal[3]);
         _loc17_ = _loc16_ = Math.min(_loc12_ / 11,_loc15_);
         _loc18_ = new Array(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(_loc12_ <= _loc14_)
            {
               _loc18_[_loc1_] = _loc6_[_loc1_] * _loc12_ / _loc14_;
            }
            else if(_loc12_ < _loc13_)
            {
               _loc18_[_loc1_] = _loc6_[_loc1_] + (_loc5_[_loc1_] - _loc6_[_loc1_]) * (_loc12_ - _loc14_) / (_loc13_ - _loc14_);
            }
            else
            {
               _loc18_[_loc1_] = _loc5_[_loc1_];
            }
            if(_loc9_[_loc1_] < _loc18_[_loc1_])
            {
               _loc17_ += (_loc18_[_loc1_] - _loc9_[_loc1_]) * market_internal[_loc1_];
            }
            _loc1_++;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_TRADING)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > TRADE > (Avail) gold: " + Utils.abbrNum(this.estResource.gold - _loc4_.gold) + ", food: " + Utils.abbrNum(_loc9_[0]) + ", lumber: " + Utils.abbrNum(_loc9_[1]) + ", stone: " + Utils.abbrNum(_loc9_[2]) + ", iron: " + Utils.abbrNum(_loc9_[3]) + ", reserved gold: " + Utils.abbrNum(_loc4_.gold) + ", food: " + Utils.abbrNum(_loc4_.food),COLR_DBG_LOG_MSG);
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > TRADE > (Desired) gold: " + Utils.abbrNum(_loc16_) + "/" + Utils.abbrNum(_loc17_) + ", food: " + Utils.abbrNum(_loc18_[0]) + ", lumber: " + Utils.abbrNum(_loc18_[1]) + ", stone: " + Utils.abbrNum(_loc18_[2]) + ", iron: " + Utils.abbrNum(_loc18_[3]),COLR_DBG_LOG_MSG);
         }
         _loc19_ = Utils.randOrder(4);
         _loc20_ = false;
         _loc21_ = NaN;
         _loc22_ = false;
         _loc23_ = NaN;
         _loc24_ = 0;
         while(_loc24_ < 4)
         {
            _loc1_ = int(_loc19_[_loc24_]);
            if(this.getHighestBidOffer(_loc1_) >= 0.0001 && this.estResource.gold - _loc4_.gold < _loc17_ && _loc9_[_loc1_] > Math.min(_loc18_[_loc1_] * 1.1,_loc18_[_loc1_] + 1000000))
            {
               _loc20_ = this.getCfg(CityConfigs.CFG_TRADING) >= 2 && this.estResource.gold < _loc17_ / 2;
               _loc21_ = Math.min(this.estResource.gold / this.getHighestBidOffer(_loc1_) * 100,_loc9_[_loc1_] - _loc18_[_loc1_],10000000);
               _loc21_ = Utils.roundAmount(_loc21_);
               if(this._qn996(_loc21_,_loc1_,_loc2_ || _loc20_))
               {
                  return;
               }
            }
            else if(this.getHighestBidOffer(_loc1_) >= 0.0001 && _loc1_ != TradeConstants.RES_TYPE_FOOD && _loc5_[_loc1_] < 0.9 * this.resource[resourceIntNames[_loc1_]].max && _loc9_[_loc1_] > Math.max(_loc5_[_loc1_] + 1000,this.resource[resourceIntNames[_loc1_]].max * 0.9))
            {
               _loc21_ = Math.min(this.estResource.gold / this.getHighestBidOffer(_loc1_) * 100,_loc9_[_loc1_] - _loc18_[_loc1_],10000000);
               _loc21_ = Utils.roundAmount(_loc21_);
               if(this._qn996(_loc21_,_loc1_,false))
               {
                  return;
               }
            }
            else if(this.estResource.gold - _loc4_.gold > _loc17_ / 2 && _loc18_[_loc1_] > Math.min(_loc9_[_loc1_] * 1.1,_loc9_[_loc1_] + 1000000) && this.estResource.gold > 1000)
            {
               _loc22_ = this.getCfg(CityConfigs.CFG_TRADING) >= 2 && _loc1_ != TradeConstants.RES_TYPE_FOOD && _loc18_[_loc1_] > 3 * Math.min(_loc9_[_loc1_] * 1.2,_loc9_[_loc1_] + 1000000);
               _loc23_ = Math.min((this.estResource.gold - _loc4_.gold) / Math.max(0.0001,this._hf650(_loc1_)) * 0.99,_loc18_[_loc1_] - _loc9_[_loc1_],10000000);
               _loc23_ = Utils.roundAmount(_loc23_);
               if(!_loc22_ && _loc23_ <= Math.max(0,Math.min(1000000,_loc9_[_loc1_] / 20),_loc3_ / 10))
               {
                  if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_TRADING)
                  {
                     this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > TRADE > Trading: buy amount is too small, skipping:" + " " + resourceNames[_loc1_] + " " + Utils.abbrNum(_loc23_),COLR_DBG_LOG_MSG);
                  }
               }
               else
               {
                  if(!_loc2_ && _loc23_ > this._ha550(_loc1_))
                  {
                     _loc23_ = this._ha550(_loc1_);
                  }
                  if(this._ik745(_loc23_,_loc1_,_loc2_ || _loc22_))
                  {
                     return;
                  }
               }
            }
            _loc24_++;
         }
         if(_loc9_[TradeConstants.RES_TYPE_STONE] < _loc5_[TradeConstants.RES_TYPE_STONE] && this.estResource.gold > 2 * _loc17_ + 2 * 10000000 * this._hf650(TradeConstants.RES_TYPE_STONE))
         {
            if(this._ik745(MAXTRADESIZE - 1,TradeConstants.RES_TYPE_STONE,false))
            {
               return;
            }
         }
         else if(_loc9_[TradeConstants.RES_TYPE_FOOD] < _loc5_[TradeConstants.RES_TYPE_FOOD] && this.estResource.gold > 2 * _loc17_ + 2 * 10000000 * this._hf650(TradeConstants.RES_TYPE_FOOD))
         {
            if(this._ik745(MAXTRADESIZE - 1,TradeConstants.RES_TYPE_FOOD,false))
            {
               return;
            }
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_TRADING)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > TRADE > Trading: Nothing to trade",COLR_DBG_LOG_MSG);
         }
      }
      
      public function _ty888(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         _loc2_ = param1.split(",");
         _loc3_ = new Array(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_[_loc4_] = Map.getFieldType(_loc2_[_loc4_]);
            if(_loc3_[_loc4_] == -1)
            {
               this.logMsg("Invalid field type: " + _loc2_[_loc4_] + " in " + param1,COLR_STD_LOG_MSG);
               return false;
            }
            _loc4_++;
         }
         this.resourceType = _loc3_;
         return true;
      }
      
      private function _rm721() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:FortificationsBean = null;
         var _loc3_:FortificationsBean = null;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         if(this.fortificationsRequirement == null || this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_WALL,1) == 0 || this.fortificationProduceQueue == null || this.fortificationProduceQueue.length == 0)
         {
            return false;
         }
         if(!this.isLastEnemyTimeLessThan1Hr() && !this._sf1146())
         {
            return false;
         }
         if(!this._isEnoughSlotsOnWall(1) || this.fortificationProductionUpdateNeeded)
         {
            return false;
         }
         _loc1_ = new Array(TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ARROWTOWER,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL);
         _loc2_ = this.getFortificationsInProduction();
         _loc3_ = this._wx919();
         _loc4_ = 0;
         _loc5_ = false;
         _loc6_ = this.getBuildingLevel(BuildingConstants.TYPE_WALL) - this.fortificationProduceQueue[0].allProduceQueueArray.length;
         if(this.isLastEnemyTimeLessThan1Hr())
         {
            _loc9_ = 0;
            for each(_loc4_ in _loc1_)
            {
               if(this._isEnoughResoToProduceFort(_loc4_,1) && this._isEnoughSlotsOnWall(1,_loc4_) && this.fortification[troopIntNames[_loc4_]] + _loc3_[troopIntNames[_loc4_]] == 0 && this.fortificationsRequirement[troopIntNames[_loc4_]] > 0)
               {
                  if(!_loc5_)
                  {
                     _loc5_ = true;
                     _loc6_ += this._ps872(_loc4_);
                  }
                  if(_loc6_ <= 0)
                  {
                     return false;
                  }
                  this.promoteBestPolHero();
                  _loc9_ = _loc6_ > 4 && this.cityTimingAllowed("multiqueue",30) ? _loc6_ - 2 : 1;
                  while(_loc9_-- > 0)
                  {
                     _loc6_--;
                     this.logMsg("Produce " + 1 + " " + troopExtNames[_loc4_],"#169736");
                     CityStateCommands.produceWallProtect(this.castleId,_loc4_,1,this._gv1114);
                  }
                  break;
               }
            }
         }
         if(_loc5_)
         {
            return true;
         }
         if(this.fortificationProduceQueue[0].allProduceQueueArray.length >= this.getBuildingLevel(BuildingConstants.TYPE_WALL))
         {
            return false;
         }
         if(this.fortificationProduceQueue[0].allProduceQueueArray.length > 1)
         {
            return false;
         }
         _loc7_ = 10;
         _loc8_ = 0;
         for each(_loc4_ in _loc1_)
         {
            _loc8_ = Math.min(_loc7_,this.fortificationsRequirement[troopIntNames[_loc4_]] - this.fortification[troopIntNames[_loc4_]] - _loc2_[troopIntNames[_loc4_]]);
            if(!(_loc8_ <= 0 || !(this._isEnoughResoToProduceFort(_loc4_,_loc8_) && this._isEnoughSlotsOnWall(_loc8_,_loc4_))))
            {
               if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
               {
                  this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Produce " + _loc8_ + " " + troopExtNames[_loc4_],COLR_DBG_LOG_MSG);
               }
               CityStateCommands.produceWallProtect(this.castleId,_loc4_,_loc8_,this._gv1114);
               return true;
            }
         }
         return false;
      }
      
      private function handleUpdateGearsResponse(param1:AvailableResearchListResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logMsg("equipment research list response: " + param1.msg);
            return;
         }
         this.gears = param1.acailableResearchBeansArray;
      }
      
      private function newZeroFoodArmy(param1:Number) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TroopBean = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:ArrayCollection = null;
         var _loc10_:Number = NaN;
         var _loc11_:NewArmyParam = null;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:Number = NaN;
         if(this.foodHideLoc == -1)
         {
            return false;
         }
         _loc2_ = 5;
         _loc3_ = 5000 + 500 * this.getTechLevel(TechConstants.LOAD_TECH);
         _loc4_ = new TroopBean();
         _loc4_.carriage = 1;
         _loc5_ = this.getEstFoodAmount(param1);
         _loc6_ = this.getBaseTravelTime(this.castle.fieldId,this.foodHideLoc,_loc4_);
         if(_loc6_ == 0)
         {
            return false;
         }
         _loc7_ = Math.min(this.getRallyDispatchPerArmyLimit(true),Math.max(this.troop.carriage * 0.9,this.troop.carriage - 1600));
         _loc8_ = 2 * (_loc6_ + 3600 * this.getCampTimeChangeBuffsFactor());
         _loc9_ = this.getZeroFoodArmies();
         if(_loc9_.length > 0)
         {
            if(param1 > 1)
            {
               return false;
            }
            _loc13_ = int(_loc9_[0].troop.carriage);
            if(_loc13_ >= _loc7_)
            {
               return false;
            }
            _loc14_ = _loc13_ * (_loc3_ + _loc2_ * _loc8_ / 3600);
            if(_loc5_ > Math.max(11000,_loc14_ / 50))
            {
               this.recallZeroFoodArmies();
               return true;
            }
            return false;
         }
         if(this.localArmies.length >= this.getMaxRallySlots())
         {
            return false;
         }
         _loc10_ = Math.ceil(_loc5_ / _loc3_);
         if(_loc10_ > _loc7_)
         {
            _loc10_ = _loc7_;
         }
         _loc4_.carriage = _loc10_;
         if(_loc10_ == 0 || _loc5_ < 3000)
         {
            return false;
         }
         _loc11_ = new NewArmyParam();
         _loc11_.missionType = ObjConstants.ARMY_MISSION_SEND;
         _loc11_.troops = _loc4_;
         _loc11_.resource = new ResourceBean();
         _loc11_.targetPoint = this.foodHideLoc;
         _loc11_.restTime = 3600;
         _loc12_ = Math.floor(Math.min(this.getMaxTroopLoad(_loc4_),_loc5_ - this.getFoodNeededToMarch(_loc11_,true)));
         if(_loc12_ < 1)
         {
            return false;
         }
         _loc11_.resource.food = _loc12_;
         this.logMsg("ZEROFOOD > Hide <b>f:</b>" + _loc11_.resource.food + " to " + Map.fieldIdToString(this.foodHideLoc) + " with " + Utils.troopBeanToString(_loc11_.troops) + ", arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc11_)),COLR_STD_LOG_MSG);
         if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
         {
            this.logMsg("Last update amount: " + Utils.formatInt(this.resource.food.amount) + "  Current est amount: " + Utils.formatInt(_loc5_) + "  Hiding amount: " + Utils.formatInt(_loc11_.resource.food) + "  Error factor: " + Utils.formatNum(param1,5),COLR_DBG_LOG_MSG);
         }
         CityStateCommands.newArmy(this.castleId,_loc11_,this.zeroFoodNewArmyHandler);
         this.lastZeroFoodOp = Utils.getServerTime();
         this.cityTimingAllowed("recallfood",0);
         return true;
      }
      
      public function _getSkypeWarningPolicy() : Array
      {
         return this.skypeWarningPolicy;
      }
      
      private function targetHasArmies(param1:int) : Boolean
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.targetFieldId == param1 && _loc2_.direction == ArmyConstants.ARMY_FORWARD)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getArmyTravelTimeReliefStationAndHeroAdjusted(param1:ArmyBean) : Number
      {
         var _loc2_:HeroBean = null;
         var _loc3_:Number = NaN;
         _loc2_ = this._gu1148(param1.heroid);
         _loc3_ = this.getBaseTravelTime(param1.startFieldId,param1.targetFieldId,Utils.getTroopBeanFromTroopStrBean(param1.troop));
         if(Map.getType(param1.targetFieldId) == FieldConstants.TYPE_CASTLE && (param1.missionType == ObjConstants.ARMY_MISSION_SEND || param1.missionType == ObjConstants.ARMY_MISSION_TRANS))
         {
            _loc3_ /= SPEEDUP[this.getBuildingLevel(BuildingConstants.TYPE_TRANSPORT_STATION)];
         }
         if(_loc2_ != null)
         {
            _loc3_ /= 1 + _loc2_.speed / 100;
         }
         return _loc3_;
      }
      
      private function onFireHeroResponse(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("hero discharge error: " + param1.errorMsg);
         }
      }
      
      public function _clearWallQueue(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AllProduceBean = null;
         for each(_loc3_ in this.fortificationProduceQueue)
         {
            _loc2_ = _loc3_.allProduceQueueArray.length - 1;
            while(_loc2_ >= param1)
            {
               CityStateCommands.cancelFortificationProduce(this.castleId,_loc3_.getAllProduceQueue(_loc2_).queueId);
               _loc2_--;
            }
         }
         Utils.callLater(5000,this.updateWallQueue);
      }
      
      private function _sn863(param1:Object = null) : void
      {
         if(this.guardedAttackFieldId == -1)
         {
            return;
         }
         this.logMsg("  end guarded attack to " + Map.fieldIdToString(this.guardedAttackFieldId));
         this._recallLocalArmiesToTarget(this.guardedAttackFieldId);
         this.guardedAttackFieldId = -1;
      }
      
      private function zeroFoodResponseHandler(param1:Object) : void
      {
         if(param1.ok != 1)
         {
            CityStateCommands.modifyTaxRate(this.castle.id,this.resource.texRate);
            this.logErrMsg("ZEROFOOD > response error " + param1.ok + ": " + param1.errorMsg);
            this.lastZeroFoodError = Utils.getServerTime();
         }
      }
      
      private function getLocalHidingArmies(param1:int) : ArrayCollection
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:ArmyBean = null;
         _loc2_ = new ArrayCollection();
         for each(_loc3_ in this.localArmies)
         {
            if(_loc3_.targetFieldId == param1 && !this.isResoBeanEmtpy(_loc3_.resource))
            {
               _loc2_.addItem(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function _hw1066() : void
      {
         var _loc2_:CityState = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in MainScreen.getCities())
         {
            _loc2_.cityManager.validateNpcTargets();
         }
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            if(this.getCfg(CityConfigs.CFG_SAFEMAINT) > 0)
            {
               if(playerTimingAllowed("safemaintnpcrecall",20) && this._yy395(estimateMaintenanceDownTime - 10 * 1000))
               {
                  this.logMsg("Troops to NPC arriving during maintenance have been recalled");
               }
            }
         }
      }
      
      private function byDistanceFromCastle(param1:int, param2:int) : int
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc3_ = Map.fieldDistance(param1,this.castle.fieldId);
         _loc4_ = Map.fieldDistance(param2,this.castle.fieldId);
         return _loc3_ < _loc4_ ? -1 : (_loc3_ > _loc4_ ? 1 : 0);
      }
      
      public function getBuffByWildCardId(param1:String, param2:String = "") : BuffBean
      {
         var _loc5_:BuffBean = null;
         var _loc3_:BuffBean = null;
         var _loc4_:* = param1.indexOf("Cooldown") != -1;
         for each(_loc5_ in this.player.buffsArray)
         {
            if(_loc5_ != null)
            {
               if(!(_loc5_.endTime < Utils.getServerTime() || _loc5_.typeId.indexOf(param1) == -1))
               {
                  if(param2 != "")
                  {
                     if(_loc5_.typeId.substring(_loc5_.typeId.length - param2.length) != param2)
                     {
                        continue;
                     }
                  }
                  if(!(!_loc4_ && _loc5_.typeId.indexOf("Cooldown") > -1 || !(_loc3_ == null || _loc3_.endTime < _loc5_.endTime)))
                  {
                     _loc3_ = _loc5_;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function _ya975() : ConditionBean
      {
         var _loc1_:AvailableResearchListBean = null;
         var _loc2_:ConditionBean = null;
         var _loc3_:Number = NaN;
         var _loc4_:CityCondition = null;
         var _loc5_:ConditionBean = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         _loc1_ = this.getResearchInProgress();
         if(_loc1_ != null && _loc1_.endTime - Utils.getServerTime() > 3 * 3600 * 1000)
         {
            return null;
         }
         _loc2_ = null;
         _loc3_ = 100000000;
         _loc4_ = null;
         _loc5_ = null;
         _loc6_ = 0;
         _loc7_ = this.currRequirements.length - 1;
         while(_loc7_ >= 0)
         {
            _loc4_ = this.currRequirements[_loc7_];
            if(!_loc4_.isBuilding)
            {
               if(!this._ux814(_loc4_))
               {
                  if(this._mo519(_loc4_))
                  {
                     this.currRequirements.removeItemAt(_loc7_);
                  }
                  else if(this._it985(_loc4_))
                  {
                     _loc5_ = this.getConditionBeanForUpgradingTo(_loc4_);
                     if(_loc5_ != null)
                     {
                        _loc6_ = Math.max(_loc5_.food,_loc5_.gold,_loc5_.wood,_loc5_.stone,_loc5_.iron);
                        if(_loc6_ < _loc3_)
                        {
                           _loc3_ = _loc6_;
                           _loc2_ = _loc5_;
                        }
                     }
                  }
               }
            }
            _loc7_--;
         }
         return _loc2_;
      }
      
      private function recallTroopsToTarget(param1:int) : void
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.targetFieldId == param1 && _loc2_.direction == ArmyConstants.ARMY_FORWARD)
            {
               this.logMsg("Recall troop to " + Map.fieldIdToString(param1) + ", id: " + _loc2_.armyId,COLR_STD_LOG_MSG);
               CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
            }
         }
      }
      
      public function _setAllBlackList(param1:String) : void
      {
         this.varAllianceListDeny = param1.replace(/_/g," ").toLowerCase().split(",");
      }
      
      private function _ka588(param1:CityCondition) : Boolean
      {
         var _loc2_:int = 0;
         if(!param1.isBuilding)
         {
            return false;
         }
         _loc2_ = this.getBuildingsCountByTypeAndLvl(param1.typeId,1);
         param1.count = param1.orgCount;
         param1.level = param1.orgLevel;
         if(_loc2_ < param1.count && this.getNextAvailablePositionForBuildingType(param1.typeId) == -1000)
         {
            param1.count = _loc2_;
            return true;
         }
         if(param1.typeId == BuildingConstants.TYPE_TAVERN)
         {
            if(param1.level < this.getBuildingLevel(param1.typeId))
            {
               param1.count = 0;
               param1.level = 0;
               return true;
            }
         }
         return false;
      }
      
      private function getCountOfLocalArmiesForCaptureFlats() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyBean = null;
         _loc1_ = 0;
         for each(_loc2_ in this.localArmies)
         {
            if(Map.getType(_loc2_.targetFieldId) == FieldConstants.TYPE_FLAT)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function hasItemsForGearUpgrade(param1:AvailableResearchListBean, param2:Object) : Boolean
      {
         var _loc3_:ConditionDependItemBean = null;
         if(param1.conditionBean == null)
         {
            return false;
         }
         for each(_loc3_ in param1.conditionBean.itemsArray)
         {
            if(_loc3_.num > param2[_loc3_.id])
            {
               return false;
            }
         }
         return true;
      }
      
      private function getLocalArmiesMarchingToLocWithReso(param1:int) : ArrayCollection
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:ArmyBean = null;
         _loc2_ = new ArrayCollection();
         for each(_loc3_ in this.localArmies)
         {
            if(_loc3_.targetFieldId == param1 && _loc3_.direction != ArmyConstants.ARMY_BACKWARD && !this.isResoBeanEmtpy(_loc3_.resource))
            {
               _loc2_.addItem(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function _we267() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:MapCastleBean = null;
         var _loc4_:int = 0;
         var _loc5_:ArmyBean = null;
         _loc1_ = NaN;
         _loc2_ = NaN;
         _loc3_ = null;
         _loc4_ = 0;
         for each(_loc5_ in this.localArmies)
         {
            if(this.lastSlowTargetLevels[_loc5_.targetFieldId] != undefined && _loc5_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc5_.direction == ArmyConstants.ARMY_FORWARD)
            {
               _loc1_ = _loc5_.reachTime - Utils.getServerTime();
               _loc2_ = Math.max(30,Math.min(15 * 60,_loc1_ / 1000 * 0.8));
               _loc3_ = Map.getDetail(_loc5_.targetFieldId,_loc2_);
               _loc4_ = Map.getLevel(_loc5_.targetFieldId,_loc2_);
               if(_loc4_ != -1 && _loc4_ != this.lastSlowTargetLevels[_loc5_.targetFieldId] || _loc3_ != null && _loc3_.userName != null)
               {
                  this.logMsg("SLOWHUNTING > Local target field changed, recall troop " + _loc5_.armyId + " toward " + Map.fieldIdToString(_loc5_.targetFieldId),COLR_STD_LOG_MSG);
                  CityStateCommands.callBackArmy(this.castleId,_loc5_.armyId);
                  delete this.lastSlowTargetLevels[_loc5_.targetFieldId];
               }
            }
         }
      }
      
      private function setWallBuildingBean(param1:AvailableBuilingListResponse) : void
      {
         if(param1.ok != 1)
         {
            return;
         }
         if(param1.builingListArray.length > 0)
         {
            this.wallBuildingBean = param1.builingListArray[0];
         }
      }
      
      public function _getHeroNameFromMacroName(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.substr(0,1) != "#")
         {
            return param1;
         }
         var _loc2_:HeroBean = null;
         switch(param1)
         {
            case "#absbest":
               _loc2_ = this.bestAttackHero();
               break;
            case "#atk":
               _loc2_ = this.getBestAttackHeroATK(100,0);
               break;
            case "#satk":
               _loc2_ = this.getBestAttackHeroATK(100,100);
               break;
            case "#atk90":
               _loc2_ = this.getBestAttackHeroATK(90,0);
               break;
            case "#satk90":
               _loc2_ = this.getBestAttackHeroATK(90,100);
               break;
            case "#spm":
            case "#spam":
               _loc2_ = this.getSpamHero();
               break;
            case "#absworst":
               _loc2_ = this.getWorstHeroExcludingReservedHeroes();
               break;
            case "#worst":
               _loc2_ = this.getWorstHero(4);
               if(_loc2_ == null)
               {
                  _loc2_ = this.getWorstHeroExcludingReservedHeroes();
               }
               break;
            case "#best":
               _loc2_ = this.getIdleHeroByTypePowerNotMayor(this.getMayor(),4);
               if(_loc2_ == null)
               {
                  _loc2_ = this.bestAttackHero();
               }
               break;
            case "#bestenergy":
               _loc2_ = this.bestHeroEnergy();
               if(_loc2_ == null)
               {
                  _loc2_ = this.getWorstHeroExcludingReservedHeroes();
               }
               break;
            case "#pol":
               _loc2_ = this.bestPoliticHero();
               break;
            case "#pol2":
               _loc2_ = this._as658(this.bestPoliticHero());
               break;
            case "#int":
               _loc2_ = this.bestIntelHero();
               break;
            case "#int2":
               _loc2_ = this._jw592(this.bestIntelHero());
               break;
            case "#hh":
               _loc3_ = this.getListOfHhNamesInTown();
               if(_loc3_ != "")
               {
                  return _loc3_.toLowerCase();
               }
               _loc2_ = null;
               break;
            case "#lh":
               if(Version.isTraceOn())
               {
                  trace("running lh code now");
               }
               _loc4_ = this.getListOfLhNamesInTown();
               if(Version.isTraceOn())
               {
                  trace("found lh names: " + _loc4_.toLowerCase());
               }
               if(_loc4_ != "")
               {
                  return _loc4_.toLowerCase();
               }
               _loc2_ = null;
               break;
            case "#royal":
               return this.player.playerInfo.sex == 0 ? "Queen" : "King";
            default:
               _loc2_ = null;
         }
         if(_loc2_ != null)
         {
            return _loc2_.name.toLowerCase();
         }
         return param1;
      }
      
      private function doSpecialMarketHide(param1:int, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         if(param2 < 100)
         {
            return;
         }
         _loc3_ = this.getTrimmedMarketPrice(this.getHighestBidOffer(param1) / 2);
         param2 = Math.min(param2,this.resource.gold / _loc3_ / 0.005,MAXTRADESIZE);
         CityStateCommands.newTrade(this.castleId,param1,TradeConstants.TRADE_TYPE_SELL,Utils.roundAmount(param2 * 0.8,2),"" + _loc3_);
      }
      
      private function researchComplete(param1:ResearchCompleteUpdate) : void
      {
         var _loc2_:AvailableResearchListBean = null;
         if(this.castleId != param1.castleId)
         {
            return;
         }
         _loc2_ = this.getResearchInProgress();
         if(_loc2_ != null)
         {
            _loc2_.avalevel += 1;
            _loc2_.level += 1;
            _loc2_.upgradeing = false;
            this.logMsg("Research complete: " + TechType.toString(_loc2_.typeId) + ":" + _loc2_.level);
         }
         else
         {
            this.logMsg("Research complete, unable to identify research");
         }
         this.researchUpdateNeeded = true;
         this._reserveEmergencyTimeSlot();
      }
      
      private function flushCityTimingList(param1:int = 60) : void
      {
         var _loc2_:SharedObject = null;
         if(new Date().getTime() - this.cityTimingListLastSaveTime > param1 * THOUSAND)
         {
            _loc2_ = SharedObject.getLocal("cityTimingList" + this.castleId);
            _loc2_.data.now = this.cityTimingList;
            _loc2_.flush();
            if(Version.isTraceOn())
            {
               trace("flushed cityTimingList at " + new Date().toString());
            }
            this.cityTimingListLastSaveTime = new Date().getTime() + Utils.getRandomInt(0,10000);
         }
      }
      
      public function _getCastleId() : int
      {
         return this.castleId;
      }
      
      private function _tt1001(param1:TroopBean) : int
      {
         if(param1 == null)
         {
            return 0;
         }
         if(param1.archer < 0.5 * Utils.getTotalTroopCount(param1))
         {
            return 10;
         }
         return param1.lightCavalry + param1.heavyCavalry + Utils.rand(5,15);
      }
      
      public function onCityIsLost() : void
      {
         this.castle_captured = true;
      }
      
      public function getTroopSpeed(param1:TroopBean) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         if(this.researches == null)
         {
            return 0;
         }
         _loc2_ = 1 + 0.1 * this.getTechLevel(TechConstants.MARCH_SKILL);
         _loc3_ = 1 + 0.05 * this.getTechLevel(TechConstants.DRIVE_SKILL);
         _loc4_ = new Array(TFConstants.T_CATAPULT,TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER);
         _loc5_ = new Array(0,0,180 * _loc2_,200 * _loc2_,3000 * _loc2_,300 * _loc2_,275 * _loc2_,250 * _loc2_,150 * _loc3_,1000 * _loc3_,750 * _loc3_,100 * _loc3_,120 * _loc3_,80 * _loc3_);
         _loc6_ = 10000;
         for each(_loc7_ in _loc4_)
         {
            if(param1[troopIntNames[_loc7_]] > 0 && _loc5_[_loc7_] < _loc6_)
            {
               _loc6_ = Number(_loc5_[_loc7_]);
            }
         }
         if(_loc6_ == 10000)
         {
            return 0;
         }
         return _loc6_;
      }
      
      public function get resource() : CastleResourceBean
      {
         return this.castle.resource;
      }
      
      public function getWorstHeroExcludingReservedHeroes() : HeroBean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:ArrayCollection = null;
         var _loc3_:Boolean = false;
         var _loc5_:HeroBean = null;
         var _loc6_:HeroBean = null;
         _loc1_ = null;
         _loc2_ = this.getReservedHeroes();
         _loc3_ = false;
         var _loc4_:int = this.getCfg(CityConfigs.CFG_HERO) <= 1 ? 0 : int(this.getCfg(CityConfigs.CFG_FASTHERO));
         _loc2_.addItem(this.bestPoliticHero());
         for each(_loc5_ in this.heroes)
         {
            _loc3_ = false;
            if(!(_loc5_.ability > 0 || _loc5_.isHero > 0))
            {
               for each(_loc6_ in _loc2_)
               {
                  if(_loc5_.id == _loc6_.id)
                  {
                     _loc3_ = true;
                     break;
                  }
               }
               if(!_loc3_)
               {
                  if(_loc1_ == null || Utils.isWorstHeroByType("power",_loc1_,_loc5_))
                  {
                     _loc1_ = _loc5_;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public function getCampTimeChangeBuffsFactor() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         if(!this.cityTimingAllowed("updateBuffCampTimeUpFactor",10))
         {
            return this.buffCampTimeUpFactorCache;
         }
         _loc1_ = 1;
         if(this.getLocalBuffByWildCardId("IncArmyActionTimeBuff","1") != null)
         {
            _loc2_ = this.getLocalBuffByWildCardId("IncArmyActionTimeBuff","2") != null ? (this.getLocalBuffByWildCardId("IncArmyActionTimeBuff","3") != null ? 3 : 2) : 1;
            _loc1_ *= 1 + 0.1999 * _loc2_;
         }
         if(this.getBuffByWildCardId("ReduceArmyActionBuff","1") != null)
         {
            if(this.getBuffByWildCardId("ReduceArmyActionBuff","2") == null)
            {
               _loc1_ *= 1 - 0.5775;
            }
            else
            {
               _loc1_ *= 1 - 0.91;
            }
         }
         return this.buffCampTimeUpFactorCache = _loc1_;
      }
      
      public function getLocalBuffByWildCardId(param1:String, param2:String = "") : BuffBean
      {
         var _loc5_:BuffBean = null;
         var _loc3_:BuffBean = null;
         var _loc4_:* = param1.indexOf("Cooldown") > -1;
         for each(_loc5_ in this.castle.buffsArray)
         {
            if(_loc5_ != null)
            {
               if(!(_loc5_.endTime < Utils.getServerTime() || _loc5_.typeId.indexOf(param1) == -1))
               {
                  if(param2 != "")
                  {
                     if(_loc5_.typeId.substring(_loc5_.typeId.length - param2.length) != param2)
                     {
                        continue;
                     }
                  }
                  if(!(!_loc4_ && _loc5_.typeId.indexOf("Cooldown") > -1 || !(_loc3_ == null || _loc3_.endTime < _loc5_.endTime)))
                  {
                     _loc3_ = _loc5_;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function _eh967(param1:AvailableResearchListResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logMsg("research list response: " + param1.msg);
            return;
         }
         this.researches = param1.acailableResearchBeansArray;
      }
      
      private function _os434(param1:int, param2:TroopBean) : TroopBean
      {
         if(param2 == null)
         {
            return null;
         }
         var _loc3_:Array = new Array(0,50,100,200,400,800,1600,3200,6400,12800,20000);
         var _loc4_:TroopBean = new TroopBean();
         var _loc5_:int = Utils.getTotalTroopCount(param2);
         if(param1 >= 4 && _loc5_ == 0)
         {
            return null;
         }
         if(param1 <= 3 || _loc5_ == param2.peasants + param2.militia + param2.pikemen + param2.swordsmen)
         {
            if(this.slowHuntingPolicy[1] != null)
            {
               _loc4_ = this.slowHuntingPolicy[1];
            }
            else
            {
               _loc4_.archer = _loc3_[param1];
            }
         }
         else if(_loc5_ != param2.archer)
         {
            if(!_mo116(param2))
            {
               return null;
            }
            _loc4_ = this.slowHuntingPolicy[3];
         }
         else
         {
            _loc4_ = this.slowHuntingPolicy[2];
         }
         return _loc4_;
      }
      
      private function logErrMsg(param1:String) : void
      {
         dispatchEvent(new ScriptLogEvent("<font color=\'#CC0000\'>(" + (this.castle == null ? "" : this.castle.name) + ") - " + param1.split("<").join("&lt;").split(">").join("&gt;") + "</font>",ScriptLogEvent.MESSAGE,this.city));
      }
      
      private function handleGetQuestList(param1:QuestListResponse) : void
      {
         var _loc2_:QuestBean = null;
         if(CityState.scriptQuestActive || !MasterTimer.getInstance().canReceive(this.timeSlot))
         {
            return;
         }
         if(param1.ok != 1)
         {
            this.logErrMsg("quest list response error " + param1.errorMsg);
            return;
         }
         for each(_loc2_ in param1.questsArray)
         {
            if(_loc2_.isFinish && _loc2_.award.indexOf("Rank") == -1 && _loc2_.award.indexOf("Title") == -1)
            {
               this.logMsg("Quest " + _loc2_.name + " completed successfully. Award: " + _loc2_.award,COLR_STD_LOG_MSG);
               ActionFactory.getInstance().getQuestCommands().award(this.castleId,_loc2_.questId);
            }
         }
      }
      
      private function isNakedScouts(param1:TroopStrBean) : Boolean
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         _loc2_ = param1.toObject();
         for(_loc3_ in _loc2_)
         {
            if(_loc3_ != "scouter")
            {
               if(!Utils.hasValue(_loc2_[_loc3_]))
               {
                  return false;
               }
               if(int(_loc2_[_loc3_]) >= 1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function doRescueTownEmergyGoldSendArmy(param1:CastleBean) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ResourceBean = null;
         var _loc5_:TroopBean = null;
         var _loc6_:NewArmyParam = null;
         var _loc7_:Number = NaN;
         if(param1 == this.castle)
         {
            return false;
         }
         if(this.getLocalArmiesCount() >= this.getMaxRallySlots())
         {
            return false;
         }
         _loc2_ = (param1.resource.herosSalary - param1.resource.taxIncome) / 6;
         _loc3_ = Math.ceil(1 * (_loc2_ + 3000) * 2 / (10 + this.getTechLevel(TechConstants.LOAD_TECH)));
         if(this.estResource.gold < 10 * _loc2_ || this.troop.scouter < _loc3_)
         {
            return false;
         }
         _loc4_ = new ResourceBean();
         _loc4_.gold = _loc2_;
         _loc5_ = new TroopBean();
         _loc5_.scouter = _loc3_;
         if(this.estResource.wood > 1000)
         {
            _loc4_.wood = 500;
         }
         if(this.estResource.stone > 1700)
         {
            _loc4_.stone = 1200;
         }
         if(this.estResource.iron > 650)
         {
            _loc4_.iron = 150;
         }
         if(this.estResource.food > 1650)
         {
            _loc4_.food = 1150;
         }
         if(this.troop.scouter < _loc5_.scouter)
         {
            return false;
         }
         _loc6_ = new NewArmyParam();
         _loc6_.missionType = ObjConstants.ARMY_MISSION_TRANS;
         _loc6_.troops = _loc5_;
         _loc6_.resource = _loc4_;
         _loc6_.targetPoint = param1.fieldId;
         if(!this.isEnoughResourcesToMarch(_loc6_))
         {
            return false;
         }
         _loc7_ = this.getTravelTimeReliefStationAdj(_loc6_);
         if(_loc7_ > 15 * 60)
         {
            return false;
         }
         if(!playerTimingAllowed("eGold" + param1.fieldId,5 * 60))
         {
            return false;
         }
         this.logMsg("RESCUETOWN > Sending emergency gold g:" + _loc4_.gold + " to " + param1.name + " " + Map.fieldIdToString(param1.fieldId) + " with " + _loc5_.scouter + " scouts " + "arriving in " + Utils.formatTime(_loc7_),COLR_DEF_LOG_MSG);
         CityStateCommands.newArmy(this.castle.id,_loc6_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc6_);
         return true;
      }
      
      public function _handleGearCmdResponse(param1:ResearchResponse) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(param1.ok != 1)
         {
            this.logMsg("gear research response error: " + param1.errorMsg);
            return;
         }
         _loc2_ = true;
         _loc3_ = 0;
         while(_loc3_ < this.gears.length)
         {
            if(param1.tech.typeId == this.gears[_loc3_].typeId)
            {
               this.gears[_loc3_] = param1.tech;
               _loc2_ = false;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            this.gears.addItem(param1.tech);
         }
      }
      
      private function getAllTroopsInCastle() : TroopBean
      {
         var _loc1_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:ArmyBean = null;
         if(this.troop == null)
         {
            return new TroopBean();
         }
         _loc1_ = this.troop.toObject();
         var _loc2_:int = this.getFieldIdUsedForHiding();
         _loc3_ = null;
         _loc4_ = null;
         for each(_loc5_ in this.selfArmies)
         {
            if(_loc5_.startFieldId == this.castle.fieldId)
            {
               if(_loc5_.missionType == ObjConstants.ARMY_MISSION_SEND && _loc5_.direction != ArmyConstants.ARMY_BACKWARD && MainScreen.getCityFromFieldId(_loc5_.targetFieldId) != null)
               {
                  continue;
               }
            }
            else
            {
               if(_loc5_.targetFieldId != this.castle.fieldId)
               {
                  continue;
               }
               if(_loc5_.missionType != ObjConstants.ARMY_MISSION_SEND || _loc5_.direction == ArmyConstants.ARMY_BACKWARD)
               {
                  continue;
               }
            }
            _loc3_ = _loc5_.troop.toObject();
            for(_loc4_ in _loc3_)
            {
               _loc1_[_loc4_] += int(_loc3_[_loc4_]);
            }
         }
         return new TroopBean(_loc1_);
      }
      
      public function _dv194() : void
      {
         if(this.guardedAttackFieldId != -1)
         {
            this.logMsg("Cancel guarded attack on " + Map.fieldIdToString(this.guardedAttackFieldId));
            this._recallLocalArmiesToTarget(this.guardedAttackFieldId);
            this.guardedAttackFieldId = -1;
         }
         else
         {
            this.logMsg("No current guarded attack");
         }
      }
      
      public function _isTraininghero(param1:String) : Boolean
      {
         return this.trainingHeroName != null && param1.toLowerCase() == this.trainingHeroName.toLowerCase();
      }
      
      private function promoteBestAtkHero() : void
      {
         var _loc1_:HeroBean = null;
         _loc1_ = this.getBestIdleAttackHeroByStaminaIncGear(0);
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.status == CityStateConstants.HERO_STATUS_IDLE || _loc1_.status == CityStateConstants.HERO_STATUS_MAYOR)
         {
            if(this._ek905(_loc1_.id) || _loc1_.status == CityStateConstants.HERO_STATUS_IDLE)
            {
               ++this.promoteCount;
               if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
               {
                  this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Promote to chief: " + Utils.heroBeanToString(_loc1_),COLR_DBG_LOG_MSG);
               }
               if(this.heroNotIdleError)
               {
                  CityStateCommands.dischargeChief(this.castleId);
               }
               this.heroNotIdleError = false;
               CityStateCommands.promoteToChief(this.castleId,_loc1_.id,this.onPromoteToChief);
            }
         }
         if((this._aq355(1) || _loc1_.attack == 0) && _loc1_.level >= 10 && this.isGearAvailable())
         {
            if(_loc1_.attack == 0)
            {
               this.logMsg("Auto change gear of " + Utils.heroBeanToString(_loc1_) + " to atk",COLR_STD_LOG_MSG);
            }
            ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc1_.id,2,this.handleCommandResponse);
         }
      }
      
      private function _lp530() : Boolean
      {
         var _loc1_:MapCastleBean = null;
         var _loc2_:NewArmyParam = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         if(this.evacuationTown == -1)
         {
            return false;
         }
         if(this.troop.carriage < 100)
         {
            return false;
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         _loc1_ = Map.getDetail(this.evacuationTown);
         if(_loc1_ == null)
         {
            return false;
         }
         if(Map.getType(this.evacuationTown) == -1)
         {
            return false;
         }
         if(_loc1_.userName != this.player.playerInfo.userName || Map.getType(this.evacuationTown) != FieldConstants.TYPE_CASTLE)
         {
            this.logMsg("EVACUATETOWN > Bad destination for evacuation: " + Map.fieldIdToCoordString(this.evacuationTown));
            this.evacuationTown = -1;
            return false;
         }
         _loc2_ = new NewArmyParam();
         _loc2_.missionType = ObjConstants.ARMY_MISSION_TRANS;
         _loc2_.troops = new TroopBean();
         _loc2_.resource = new ResourceBean();
         _loc2_.targetPoint = this.evacuationTown;
         _loc2_.troops.carriage = Math.min(this.getRallyDispatchPerArmyLimit(true),this.troop.carriage);
         _loc3_ = this.getFoodNeededToMarch(_loc2_) + 500000;
         if(this.resource.troopCostFood > this.resource.food.increaseRate)
         {
            _loc3_ += (this.resource.troopCostFood - this.resource.food.increaseRate) / 10;
         }
         _loc4_ = this.getMaxTroopLoad(_loc2_.troops) - _loc3_;
         _loc5_ = 2 * this.resource.maxPopulation + 24 * this.resource.herosSalary;
         if(_loc5_ > this.estResource.gold)
         {
            _loc5_ = this.estResource.gold;
         }
         if(_loc4_ <= 0 || _loc3_ > this.estResource.food)
         {
            return false;
         }
         _loc6_ = NaN;
         _loc7_ = NaN;
         _loc8_ = 4;
         while(_loc8_ >= 0)
         {
            if(_loc4_ == 0)
            {
               break;
            }
            _loc6_ = _loc8_ == 0 ? _loc3_ : (_loc8_ == 4 ? _loc5_ : 0);
            _loc7_ = Math.min(_loc4_,this.estResource[resourceIntNames[_loc8_]] - _loc6_);
            _loc2_.resource[resourceIntNames[_loc8_]] = _loc7_;
            _loc4_ -= _loc7_;
            _loc8_--;
         }
         Utils.trimDecimalFromResoAmounts(_loc2_.resource);
         if(!this.isEnoughResourcesToMarch(_loc2_))
         {
            this.logMsg("EVACUATETOWN > BUG: Not enough resource to evacuate to: " + Map.fieldIdToCoordString(this.evacuationTown));
            this.evacuationTown = -1;
            return false;
         }
         if(_loc4_ > 0)
         {
            _loc2_.missionType = ObjConstants.ARMY_MISSION_SEND;
         }
         this.logMsg("EVACUATETOWN > Evacuate to " + Map.fieldIdToString(this.evacuationTown) + " with " + Utils.troopBeanToString(_loc2_.troops) + ", arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc2_)));
         CityStateCommands.newArmy(this.castleId,_loc2_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc2_);
         if(_loc4_ > 0)
         {
            this.logMsg("EVACUATETOWN > EVACUATION COMPLETED");
            this.evacuationTown = -1;
         }
         return true;
      }
      
      private function doSearchForUnoccupiedResourceFields() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MapCastleBean = null;
         var _loc3_:int = 0;
         if(this.getCfg(CityConfigs.CFG_VALLEY) <= 0)
         {
            return;
         }
         if(this.candidateResourceFields == null || this.candidateResourceFields.length == 0)
         {
            return;
         }
         _loc1_ = 10;
         if(this.resourceFieldsDetailInfo != null && this.resourceFieldsDetailInfo.length >= _loc1_)
         {
            return;
         }
         if(this.cityTimingAllowed("searchresourcefield",300))
         {
            this.logMsg("VALLEY > Searching for unowned valleys for resource production bonus...",COLR_STD_LOG_MSG);
         }
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < this.candidateResourceFields.length)
         {
            _loc2_ = Map.getDetail(this.candidateResourceFields[_loc3_]);
            if(_loc2_ == null)
            {
               return;
            }
            if(_loc2_.userName == null)
            {
               this.resourceFieldsDetailInfo.addItem(_loc2_);
            }
            this.candidateResourceFields.splice(_loc3_,1);
            _loc3_--;
            if(this.resourceFieldsDetailInfo.length >= _loc1_)
            {
               return;
            }
            _loc3_++;
         }
      }
      
      public function getMayor() : HeroBean
      {
         var _loc1_:HeroBean = null;
         for each(_loc1_ in this.heroes)
         {
            if(_loc1_.status == HeroConstants.HERO_CHIEF_STATU)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function bestIdleAttackHero(param1:int = -1) : HeroBean
      {
         return this.getBestIdleHeroByTypeAndStamina("power",param1);
      }
      
      private function _mf676(param1:Boolean, param2:Boolean, param3:Boolean) : Boolean
      {
         var _loc4_:HeroBean = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:HeroBean = null;
         var _loc9_:HeroBean = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:TroopBean = null;
         var _loc16_:NewArmyParam = null;
         var _loc17_:Number = NaN;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         if(this.localNPCs == null)
         {
            return false;
         }
         if(this.researches == null)
         {
            return false;
         }
         if(this._ty399())
         {
            return false;
         }
         this._hw1066();
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            return false;
         }
         if(!param2 || !param3)
         {
            return false;
         }
         if(this._cd932 != -1 && this._rr420(-1) >= this._cd932)
         {
            return false;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > NPC > checking troop to attack npc, ballista: " + this.troop.ballista,COLR_DBG_LOG_MSG);
         }
         _loc4_ = this._ej801();
         _loc5_ = false;
         if(_loc4_ != null && !playerTimingAllowed("hero5busy" + _loc4_.id,15,false))
         {
            _loc4_ = null;
            _loc5_ = true;
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
         {
            if(!_loc5_)
            {
               this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > NPC > checking idle hero: " + Utils.heroBeanToString(_loc4_),COLR_DBG_LOG_MSG);
            }
         }
         if(_loc4_ == null)
         {
            return false;
         }
         _loc6_ = this.getCfg(CityConfigs.CFG_NPC);
         if(this.getTroopForNpcLevel(_loc6_,false) == null)
         {
            if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
            {
               this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > NPC > npc attack: Not enough troop",COLR_DBG_LOG_MSG);
            }
            return false;
         }
         _loc7_ = param1 ? 2 : 8;
         _loc8_ = this.bestAttackHero();
         _loc9_ = this._by706(_loc8_);
         if(this.getCfg(CityConfigs.CFG_TRAINING) > 0 && !Utils.isHeroMaxLvl(_loc4_) && (_loc4_ == _loc8_ || _loc4_ == _loc9_ || Math.max(_loc4_.power,60 + _loc4_.level) < Math.max(_loc4_.management,_loc4_.stratagem)))
         {
            _loc7_ = 1;
         }
         if(param1 && this.getCfg(CityConfigs.CFG_TRAINING) >= 6)
         {
            _loc7_ = this.getCfg(CityConfigs.CFG_TRAINING) / 60;
         }
         _loc10_ = this.npcList == null ? this.localNPCs : this.npcList;
         _loc11_ = 0;
         _loc12_ = 0;
         _loc13_ = 0;
         _loc14_ = false;
         _loc15_ = null;
         _loc16_ = null;
         _loc17_ = NaN;
         var _loc18_:int = 0;
         _loc19_ = 0;
         while(_loc19_ < _loc10_.length)
         {
            _loc12_ = int(_loc10_[_loc19_]);
            if(!(this.npcAvoidList != null && this.npcAvoidList.indexOf(_loc12_) != -1))
            {
               if(!(this.npcArea != null && !Map.isInArea(this.npcArea[0],this.npcArea[1],_loc12_)))
               {
                  if(!(param1 && _loc12_ == this.evasionFieldId))
                  {
                     if(this.npcList != null)
                     {
                        _loc13_ = Map.getType(_loc12_);
                        if(_loc13_ == -1)
                        {
                           return false;
                        }
                        if(_loc13_ == FieldConstants.TYPE_NPC)
                        {
                           _loc14_ = param1 ? (this.getCfg(CityConfigs.CFG_TRAINING) != 2 ? true : false) : true;
                           _loc15_ = this.getTroopForNpcLevel(Map.getLevel(_loc12_),_loc14_);
                           if(_loc15_ != null)
                           {
                              _loc11_++;
                              if(!this._bb1110(_loc12_))
                              {
                                 _loc16_ = new NewArmyParam();
                                 _loc16_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                 _loc16_.heroId = _loc4_.id;
                                 _loc16_.targetPoint = _loc12_;
                                 _loc16_.troops = _loc15_;
                                 _loc16_.resource = new ResourceBean();
                                 _loc17_ = this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_);
                                 if(!this.isEnoughResourcesToMarch(_loc16_))
                                 {
                                    return false;
                                 }
                                 if(this.isWarTownOn(2 * _loc17_))
                                 {
                                    this.logMsg("NPC > wartownpolicy doesn\'t allow sending troops out",COLR_STD_LOG_MSG);
                                    return false;
                                 }
                                 if(param1)
                                 {
                                    if(_loc14_)
                                    {
                                       if(playerArmyTimingAllowed("attack" + _loc12_,_loc17_,_loc7_ * 3600))
                                       {
                                          playerTimingAllowed("hero5busy" + _loc4_.id,0);
                                          if(_loc4_.status == HeroConstants.HERO_CHIEF_STATU || _loc4_.id == this.lastPromoteId)
                                          {
                                             this.removeMayor();
                                          }
                                          this.logMsg("NPC > " + (param1 ? "train at " : "attack NPC ") + Map.fieldIdToString(_loc12_) + " using hero " + Utils.heroBeanToString(_loc4_) + " with " + Utils.troopBeanToString(_loc16_.troops) + " arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_)),COLR_STD_LOG_MSG);
                                          CityStateCommands.newArmy(this.castleId,_loc16_,this.handleArmyCommandResponse);
                                          this.lastNPCTargets[_loc12_] = _loc12_;
                                          this.adjEstFoodAfterMarch(_loc16_);
                                          Map.reqMapInfoAndDetail(_loc12_);
                                          return true;
                                       }
                                    }
                                    else if(playerArmyTimingAllowed("attack" + _loc12_,_loc17_,_loc7_ * 3600,true))
                                    {
                                       if(playerArmyTimingAllowed("training" + _loc12_,_loc17_,_loc7_ * 3600))
                                       {
                                          playerTimingAllowed("hero5busy" + _loc4_.id,0);
                                          if(_loc4_.status == HeroConstants.HERO_CHIEF_STATU || _loc4_.id == this.lastPromoteId)
                                          {
                                             this.removeMayor();
                                          }
                                          this.logMsg("NPC > " + (param1 ? "train at " : "attack NPC ") + Map.fieldIdToString(_loc12_) + " using hero " + Utils.heroBeanToString(_loc4_) + " with " + Utils.troopBeanToString(_loc16_.troops) + " arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_)),COLR_STD_LOG_MSG);
                                          CityStateCommands.newArmy(this.castleId,_loc16_,this.handleArmyCommandResponse);
                                          this.lastNPCTargets[_loc12_] = _loc12_;
                                          this.adjEstFoodAfterMarch(_loc16_);
                                          Map.reqMapInfoAndDetail(_loc12_);
                                          return true;
                                       }
                                    }
                                 }
                                 else if(playerArmyTimingAllowed("attack" + _loc12_,_loc17_,_loc7_ * 3600))
                                 {
                                    playerTimingAllowed("hero5busy" + _loc4_.id,0);
                                    if(_loc4_.status == HeroConstants.HERO_CHIEF_STATU || _loc4_.id == this.lastPromoteId)
                                    {
                                       this.removeMayor();
                                    }
                                    this.logMsg("NPC > " + (param1 ? "train at " : "attack NPC ") + Map.fieldIdToString(_loc12_) + " using hero " + Utils.heroBeanToString(_loc4_) + " with " + Utils.troopBeanToString(_loc16_.troops) + " arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_)),COLR_STD_LOG_MSG);
                                    CityStateCommands.newArmy(this.castleId,_loc16_,this.handleArmyCommandResponse);
                                    this.lastNPCTargets[_loc12_] = _loc12_;
                                    this.adjEstFoodAfterMarch(_loc16_);
                                    Map.reqMapInfoAndDetail(_loc12_);
                                    return true;
                                 }
                              }
                           }
                        }
                        else
                        {
                           this.logMsg("NPC > " + Map.fieldIdToString(_loc12_) + " is not or is no longer a npc",COLR_STD_LOG_MSG);
                           _loc10_.splice(_loc19_,1);
                        }
                     }
                     else
                     {
                        _loc18_ = Map.getLevel(_loc12_);
                        if(_loc18_ >= _loc6_)
                        {
                           _loc13_ = Map.getType(_loc12_);
                           if(_loc13_ == -1)
                           {
                              return false;
                           }
                           if(_loc13_ == FieldConstants.TYPE_NPC)
                           {
                              _loc14_ = param1 ? (this.getCfg(CityConfigs.CFG_TRAINING) != 2 ? true : false) : true;
                              _loc15_ = this.getTroopForNpcLevel(Map.getLevel(_loc12_),_loc14_);
                              if(_loc15_ != null)
                              {
                                 _loc11_++;
                                 if(!this._bb1110(_loc12_))
                                 {
                                    _loc16_ = new NewArmyParam();
                                    _loc16_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                    _loc16_.heroId = _loc4_.id;
                                    _loc16_.targetPoint = _loc12_;
                                    _loc16_.troops = _loc15_;
                                    _loc16_.resource = new ResourceBean();
                                    _loc17_ = this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_);
                                    if(!this.isEnoughResourcesToMarch(_loc16_))
                                    {
                                       return false;
                                    }
                                    if(this.isWarTownOn(2 * _loc17_))
                                    {
                                       this.logMsg("NPC > wartownpolicy doesn\'t allow sending troops out",COLR_STD_LOG_MSG);
                                       return false;
                                    }
                                    if(param1)
                                    {
                                       if(_loc14_)
                                       {
                                          if(playerArmyTimingAllowed("attack" + _loc12_,_loc17_,_loc7_ * 3600))
                                          {
                                             playerTimingAllowed("hero5busy" + _loc4_.id,0);
                                             if(_loc4_.status == HeroConstants.HERO_CHIEF_STATU || _loc4_.id == this.lastPromoteId)
                                             {
                                                this.removeMayor();
                                             }
                                             this.logMsg("NPC > " + (param1 ? "train at " : "attack NPC ") + Map.fieldIdToString(_loc12_) + " using hero " + Utils.heroBeanToString(_loc4_) + " with " + Utils.troopBeanToString(_loc16_.troops) + " arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_)),COLR_STD_LOG_MSG);
                                             CityStateCommands.newArmy(this.castleId,_loc16_,this.handleArmyCommandResponse);
                                             this.lastNPCTargets[_loc12_] = _loc12_;
                                             this.adjEstFoodAfterMarch(_loc16_);
                                             Map.reqMapInfoAndDetail(_loc12_);
                                             return true;
                                          }
                                       }
                                       else if(playerArmyTimingAllowed("attack" + _loc12_,_loc17_,_loc7_ * 3600,true))
                                       {
                                          if(playerArmyTimingAllowed("training" + _loc12_,_loc17_,_loc7_ * 3600))
                                          {
                                             playerTimingAllowed("hero5busy" + _loc4_.id,0);
                                             if(_loc4_.status == HeroConstants.HERO_CHIEF_STATU || _loc4_.id == this.lastPromoteId)
                                             {
                                                this.removeMayor();
                                             }
                                             this.logMsg("NPC > " + (param1 ? "train at " : "attack NPC ") + Map.fieldIdToString(_loc12_) + " using hero " + Utils.heroBeanToString(_loc4_) + " with " + Utils.troopBeanToString(_loc16_.troops) + " arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_)),COLR_STD_LOG_MSG);
                                             CityStateCommands.newArmy(this.castleId,_loc16_,this.handleArmyCommandResponse);
                                             this.lastNPCTargets[_loc12_] = _loc12_;
                                             this.adjEstFoodAfterMarch(_loc16_);
                                             Map.reqMapInfoAndDetail(_loc12_);
                                             return true;
                                          }
                                       }
                                    }
                                    else if(playerArmyTimingAllowed("attack" + _loc12_,_loc17_,_loc7_ * 3600))
                                    {
                                       playerTimingAllowed("hero5busy" + _loc4_.id,0);
                                       if(_loc4_.status == HeroConstants.HERO_CHIEF_STATU || _loc4_.id == this.lastPromoteId)
                                       {
                                          this.removeMayor();
                                       }
                                       this.logMsg("NPC > " + (param1 ? "train at " : "attack NPC ") + Map.fieldIdToString(_loc12_) + " using hero " + Utils.heroBeanToString(_loc4_) + " with " + Utils.troopBeanToString(_loc16_.troops) + " arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc16_) / Utils.getHeroSpeedFactor(_loc4_)),COLR_STD_LOG_MSG);
                                       CityStateCommands.newArmy(this.castleId,_loc16_,this.handleArmyCommandResponse);
                                       this.lastNPCTargets[_loc12_] = _loc12_;
                                       this.adjEstFoodAfterMarch(_loc16_);
                                       Map.reqMapInfoAndDetail(_loc12_);
                                       return true;
                                    }
                                 }
                              }
                           }
                           else
                           {
                              this.logMsg(Map.fieldIdToString(_loc12_) + " is not or is no longer a npc",COLR_STD_LOG_MSG);
                              _loc10_.splice(_loc19_,1);
                           }
                        }
                     }
                  }
               }
            }
            _loc19_++;
         }
         _loc20_ = 0;
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK || this.cityTimingAllowed("nonpctoattack",600))
         {
            this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "NPC > ") + "number of local npc " + _loc20_ + "/" + _loc10_.length + ", appropriate level/troop: " + _loc11_ + ", all have been recently farmed",COLR_DBG_LOG_MSG);
         }
         if(this.npcList == null && _loc20_ == _loc11_ && this.distanceSettings[DISTANCE_NPC] < 30 && (this.npcArea == null || Map.fieldDistance(this.castle.fieldId,this.npcArea[0]) < this.distanceSettings[DISTANCE_NPC] || Map.fieldDistance(this.castle.fieldId,this.npcArea[1]) < this.distanceSettings[DISTANCE_NPC]))
         {
            if(this.distanceSettings[DISTANCE_NPC] < 4)
            {
               this.distanceSettings[DISTANCE_NPC] = 4;
            }
            this.distanceSettings[DISTANCE_NPC] = int(this.distanceSettings[DISTANCE_NPC] * 1.3);
            this.localNPCs = null;
         }
         return false;
      }
      
      private function _uo129() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyBean = null;
         _loc1_ = 0;
         for each(_loc2_ in this.selfArmies)
         {
            _loc1_ = Map.getType(_loc2_.targetFieldId);
            if(_loc2_.startFieldId == this.castle.fieldId)
            {
               if(!(_loc1_ == -1 || _loc1_ == FieldConstants.TYPE_CASTLE))
               {
                  if(_loc2_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc2_.direction == ArmyConstants.ARMY_STAY)
                  {
                     if(this.keepTroopFieldIds.indexOf(_loc2_.targetFieldId) == -1)
                     {
                        this.logMsg("Recalling troop from " + Map.fieldIdToCoordString(_loc2_.targetFieldId),COLR_STD_LOG_MSG);
                        CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId,this._jq490);
                     }
                  }
               }
            }
         }
      }
      
      private function getTravelTimeReliefStationAdj(param1:NewArmyParam) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         _loc2_ = this.getBaseTravelTime(this.castle.fieldId,param1.targetPoint,param1.troops);
         _loc3_ = (MainScreen.getCityFromFieldId(param1.targetPoint) != null || Map.getType(param1.targetPoint) == FieldConstants.TYPE_CASTLE && Map.getDetailInfo(param1.targetPoint,30).allianceName != null && this.player.playerInfo.alliance != null && Map.getDetailInfo(param1.targetPoint,30).allianceName == this.player.playerInfo.alliance) && (param1.missionType == ObjConstants.ARMY_MISSION_SEND || param1.missionType == ObjConstants.ARMY_MISSION_TRANS) ? int(SPEEDUP[this.getBuildingLevel(BuildingConstants.TYPE_TRANSPORT_STATION)]) : 1;
         return _loc2_ / _loc3_ + param1.restTime;
      }
      
      public function getSpamHero() : HeroBean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:HeroBean = null;
         var _loc3_:HeroBean = null;
         _loc1_ = null;
         if(this.trainingHeroNeeded)
         {
            _loc1_ = this.getBestIdleTrainingHero();
         }
         _loc2_ = null;
         for each(_loc3_ in this.heroes)
         {
            if(!(_loc1_ != null && _loc3_.id == _loc1_.id))
            {
               if(_loc3_.status == HeroConstants.HERO_FREE_STATU)
               {
                  if(!(_loc3_.isHero != 0 || _loc3_.level > 70))
                  {
                     if(!(_loc2_ != null && _loc2_.power >= _loc3_.power))
                     {
                        _loc2_ = _loc3_;
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function getBestIdleTrainingHero() : HeroBean
      {
         var _loc1_:HeroBean = null;
         _loc1_ = null;
         if(this.trainingHeroName == null)
         {
            _loc1_ = this.getBestIdleAttackHeroByStaminaIncGear(0);
            if(_loc1_ == null)
            {
               return null;
            }
            if(this.heroes.length <= 3)
            {
               return _loc1_;
            }
            if(Utils.getMaxStatValueByType(_loc1_,"power") == Utils.getMaxStatValueByType(this.bestAttackHero(),"power"))
            {
               return _loc1_;
            }
            return null;
         }
         for each(_loc1_ in this.heroes)
         {
            if(_loc1_.name.toLowerCase() == "king" && _loc1_.isHero == 0)
            {
               REAddons.getInstance().renameKing(this);
            }
            else if(_loc1_.name.toLowerCase() == this.trainingHeroName.toLowerCase())
            {
               if(_loc1_.status == HeroConstants.HERO_CHIEF_STATU || _loc1_.status == HeroConstants.HERO_FREE_STATU)
               {
                  return _loc1_;
               }
               return null;
            }
         }
         return null;
      }
      
      public function getWorstHero(param1:int = -1) : HeroBean
      {
         var _loc2_:HeroBean = null;
         var _loc3_:ArrayCollection = null;
         var _loc4_:Boolean = false;
         var _loc5_:HeroBean = null;
         var _loc6_:HeroBean = null;
         if(param1 == -1)
         {
            param1 = this.getMinEnergyCfg();
         }
         _loc2_ = null;
         _loc3_ = this.getReservedHeroes();
         _loc3_.addItem(this.bestPoliticHero());
         _loc4_ = false;
         for each(_loc5_ in this.heroes)
         {
            if(!(_loc5_.ability > 0 || _loc5_.isHero > 0))
            {
               if(_loc5_.stamina >= param1)
               {
                  if(_loc5_.status == HeroConstants.HERO_FREE_STATU)
                  {
                     _loc4_ = false;
                     for each(_loc6_ in _loc3_)
                     {
                        if(_loc5_ == _loc6_)
                        {
                           _loc4_ = true;
                        }
                     }
                     if(!_loc4_)
                     {
                        if(_loc2_ == null || Utils.isWorstHeroByType("power",_loc2_,_loc5_))
                        {
                           _loc2_ = _loc5_;
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function _setWartownPolicy(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = param1.split(" ");
         if(_loc2_.length % 2 != 0)
         {
            this.logMsg("wartownpolicy must contain an even number of time markers",COLR_ERR_LOG_MSG);
            return false;
         }
         _loc3_ = this.wartownSchedule != null ? this.wartownSchedule : new Array();
         _loc4_ = null;
         _loc5_ = 0;
         for each(_loc6_ in _loc2_)
         {
            _loc4_ = _loc6_.split(":");
            if(_loc4_.length != 2 || !Utils.hasValue(_loc4_[0]) || !Utils.hasValue(_loc4_[1]))
            {
               this.logMsg("Invalid time marker, " + _loc6_ + " should be in the form hh:mm",COLR_ERR_LOG_MSG);
               return false;
            }
            _loc5_ = int(_loc4_[0]) * 60 + int(_loc4_[1]);
            _loc3_.push(_loc5_);
         }
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc3_.length)
         {
            _loc8_ = _loc9_ + 1;
            while(_loc8_ < _loc3_.length)
            {
               _loc7_ = Math.abs(_loc3_[_loc9_] - _loc3_[_loc8_]);
               if(_loc7_ < 5 || _loc7_ > 60 * 24 - 5)
               {
                  this.logMsg("All time markers must be at least 5 minutes apart",COLR_ERR_LOG_MSG);
                  return false;
               }
               _loc8_++;
            }
            _loc9_++;
         }
         this.wartownSchedule = _loc3_;
         return true;
      }
      
      private function onNewBuildingResponse(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("build error: " + param1.errorMsg);
            MasterTimer.getInstance().setNextActiveTime();
         }
      }
      
      private function _cd549(param1:XMLList) : Boolean
      {
         var _loc2_:* = undefined;
         if(param1.length() == 0)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(int(_loc2_.@typeId) != TFConstants.T_MILITIA)
            {
               if(!Utils.hasValue(_loc2_.@count))
               {
                  return false;
               }
               if(int(_loc2_.@count) > 10)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function _cfg_noUplevelHeroes(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.noUplevelHeroes = _loc2_;
      }
      
      public function getGearLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.gears.length)
         {
            if(this.gears[_loc2_].typeId == param1)
            {
               return this.gears[_loc2_].avalevel;
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function _gr492() : void
      {
         var _loc1_:CityState = null;
         for each(_loc1_ in MainScreen.getCities())
         {
            if(_loc1_.cityManager.getCfg(CityConfigs.CFG_FLATROLLING) > 0)
            {
               _loc1_.cityManager._qb1032();
            }
         }
      }
      
      private function _tc497(param1:Array, param2:Number) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:ArmyBean = null;
         _loc3_ = false;
         for each(_loc4_ in this.selfArmies)
         {
            if(!(_loc4_.startFieldId != this.castle.fieldId || _loc4_.direction != ArmyConstants.ARMY_FORWARD || param1.indexOf(_loc4_.targetFieldId) == -1 || _loc4_.reachTime < param2))
            {
               _loc3_ = true;
               CityStateCommands.callBackArmy(this.castleId,_loc4_.armyId);
            }
         }
         return _loc3_;
      }
      
      public function _cf1136(param1:int, param2:TroopBean, param3:int) : void
      {
         if(this.spamAttackFieldId != -1)
         {
            if(this.spamAttackFieldId == param1)
            {
               this.logMsg("Update spam attack on " + Map.fieldIdToString(param1));
               this.spamAttackFieldId = param1;
               this.spamTroopBean = param2;
               this.spamCount = param3;
            }
            else
            {
               this.logMsg("Please cancel spam attack on " + Map.fieldIdToString(this.spamAttackFieldId) + " first");
            }
         }
         else
         {
            this.logMsg("Start spam attack on " + Map.fieldIdToString(param1));
            this.spamAttackFieldId = param1;
            this.spamTroopBean = param2;
            this.spamCount = param3;
         }
      }
      
      public function _getResoGold() : Number
      {
         return this.resource.gold;
      }
      
      private function isCanCounterAmbush() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         _loc1_ = Number(new Date().getTime());
         _loc2_ = this.lastAmbushFromAllSideErrorTime != null && this.lastAmbushFromAllSideErrorTime.getTime() + 900 * 1000 > _loc1_;
         _loc3_ = this.lastCounterAmbushTime != null && this.lastCounterAmbushTime.getTime() + 900 * 1000 > _loc1_;
         return _loc2_ && !_loc3_;
      }
      
      private function doCheckAllianceReports() : void
      {
         if(!this.isMainTown() || this.getCfg(CityConfigs.CFG_WARREPORT) <= 0 && this.getCfg(CityConfigs.CFG_SKYPEWARREPORT) <= 0)
         {
            return;
         }
         if(this.furtherInitNeeded || this.player.playerInfo.alliance == null)
         {
            return;
         }
         if(!playerTimingAllowed("alliancereport",300))
         {
            return;
         }
         this.reportPage = 1;
         if(this.newLastReportTime != null)
         {
            if(this.lastReportTime == null || this.newLastReportTime > this.lastReportTime)
            {
               this.lastReportTime = this.newLastReportTime;
            }
            this.newLastReportTime = null;
         }
         CityStateCommands.getMilitarySituationList(this.reportPage,6,this.militarySituationListHandler);
      }
      
      private function _xa758() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:FieldBean = null;
         if(estimateMaintenanceDownTime > Utils.getServerTime() || this.localFieldsDetailInfo.length == 0 || this.getCfg(CityConfigs.CFG_HUNTING) <= 0)
         {
            return;
         }
         _loc1_ = this.huntingLocation != -1 ? this.huntingLocation : int(this.localFieldsDetailInfo[0].id);
         _loc2_ = false;
         for each(_loc3_ in this.fields)
         {
            if(!(_loc3_.id == buildCityLocation || _loc3_.id != _loc1_))
            {
               if(playerTimingAllowed("abandonfield" + _loc1_,3))
               {
                  this.logMsg("Abandon field: " + Map.fieldIdToString(_loc3_.id),COLR_STD_LOG_MSG);
                  CityStateCommands.giveUpField(_loc3_.id);
               }
               _loc2_ = true;
               break;
            }
         }
         if(!_loc2_ && this.fields.length == this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL))
         {
            if(!this._xm876())
            {
               if(playerTimingAllowed("abandonlocalfielderror",300))
               {
                  this.logErrMsg("Unable to find valley to abandon, conflicting hunting & flatrolling???");
               }
            }
         }
      }
      
      public function _isEnoughSlotsOnWall(param1:int = 10, param2:int = -1) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 5;
         if(param2 >= TFConstants.F_TRAP && param2 <= TFConstants.F_ROCKFALL)
         {
            _loc3_ = param2 - 13;
         }
         _loc4_ = this.getBuildingLevel(BuildingConstants.TYPE_WALL);
         if(_loc4_ * (_loc4_ + 1) / 2 * 1000 - this.getTotalWallSlotsUsed() < _loc3_ * param1)
         {
            return false;
         }
         return true;
      }
      
      public function _getEmailWarning() : int
      {
         return this.getCfg(CityConfigs.CFG_EMAILWARNING);
      }
      
      public function _setAutoUseItems(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         _loc2_ = null;
         _loc3_ = true;
         for each(_loc4_ in param1.toLowerCase().split(","))
         {
            if(_loc4_ != "")
            {
               _loc2_ = _loc4_.split(":");
               if(Items.getItemId(_loc2_[0]) == null)
               {
                  this.logErrMsg("Invalid item name: " + _loc2_[0]);
                  _loc3_ = false;
               }
               else if(_loc2_[0] == "speech_text" || _loc2_[0] == "truce_agreement")
               {
                  if(!this.checkIfHaveItem(_loc2_[0]))
                  {
                     this.logMsg("Attention: No item " + _loc2_[0] + " available",COLR_STD_LOG_MSG);
                  }
                  if(_loc2_.length < 2 || !Utils.hasValue(_loc2_[1]) || int(_loc2_[1]) < 0 || int(_loc2_[1]) > 99)
                  {
                     this.logErrMsg("Missing or invalid loyalty condition for item: " + _loc2_[0] + ", expect " + _loc2_[0] + ":loyalty");
                     _loc3_ = false;
                  }
                  else
                  {
                     _loc2_[1] = int(_loc2_[1]);
                     this.logMsg("Auto use " + _loc2_[0] + " at loyalty " + _loc2_[1],COLR_STD_LOG_MSG);
                     if(_loc2_[0] == "truce_agreement" && _loc2_.length > 2)
                     {
                        if(Utils.hasValue(_loc2_[2]))
                        {
                           _loc2_[2] = int(_loc2_[2]);
                           if(_loc2_[2] < 0 || _loc2_[2] > 4)
                           {
                              this.logErrMsg("Invalid scout/attack condition for item: " + _loc2_[0] + ", expect a number from 1-4 instead of " + _loc2_[2]);
                              _loc3_ = false;
                           }
                           else
                           {
                              _loc5_ = new Array("on loyalty condition only","on successful attack","on any attack","on successful scout","on any scout");
                              if(_loc2_[2] != 0)
                              {
                                 this.logMsg("Auto use truce " + _loc5_[_loc2_[2]],COLR_STD_LOG_MSG);
                              }
                              this.autoItems[_loc2_[0]] = new Array(_loc2_[1],_loc2_[2]);
                              ++this.autoItems["count"];
                           }
                        }
                        else
                        {
                           this.logErrMsg("Invalid scout/attack condition for item: " + _loc2_[0] + ", expect a number from 1-4 instead of " + _loc2_[2]);
                           _loc3_ = false;
                        }
                     }
                     else
                     {
                        this.autoItems[_loc2_[0]] = new Array(_loc2_[1],0);
                        ++this.autoItems["count"];
                     }
                  }
               }
               else
               {
                  this.autoItems[_loc2_[0]] = 1;
                  ++this.autoItems["count"];
               }
            }
         }
         return _loc3_;
      }
      
      private function militarySituationListHandler(param1:MilitarySituationListResponse) : void
      {
         var doWr:Boolean = false;
         var doSk:Boolean = false;
         var doSkJnkFilter:Boolean = false;
         var skJnkLimit:int = 0;
         var endOfNewReports:Boolean = false;
         var report:XML = null;
         var msg:String = null;
         var totalTroopCounts:int = 0;
         var skMsg:String = null;
         var skResp:SkypeResponse = null;
         var ms:MilitarySituation = null;
         var receiver:Object = null;
         var r:MilitarySituationListResponse = param1;
         if(!this.isMainTown())
         {
            return;
         }
         if(r.ok != 1)
         {
            this.logMsg("Military situation list error: " + r.errorMsg);
            return;
         }
         doWr = this.getCfg(CityConfigs.CFG_WARREPORT) > 0;
         doSk = this.getCfg(CityConfigs.CFG_SKYPEWARREPORT) > 0;
         doSkJnkFilter = int(this.getCfg(CityConfigs.CFG_SKYPEJUNKWARREPORT)) > 0;
         skJnkLimit = int(this.getCfg(CityConfigs.CFG_SKYPEJUNKWARREPORT));
         endOfNewReports = false;
         report = null;
         msg = null;
         totalTroopCounts = 0;
         skMsg = "";
         skResp = null;
         for each(ms in r.situationsArray)
         {
            if(this.newLastReportTime == null)
            {
               this.newLastReportTime = ms.time;
            }
            if(this.lastReportTime == null || ms.time <= this.lastReportTime)
            {
               endOfNewReports = true;
               break;
            }
            if(!ms.attack)
            {
               if((ms.otherAllianceName == null || this.wrAllianceIgnoreList.indexOf(ms.otherAllianceName) == -1) && (ms.eventName == null || this.wrPlayerIgnoreList.indexOf(ms.eventName.substring(0,ms.eventName.indexOf("Attack") - 1)) == -1))
               {
                  report = new XML(ms.xml_data);
                  msg = Utils.formatUrl("<b>" + (report.battleReport.defendTroop.@king == null || report.battleReport.defendTroop.@king == "" || report.battleReport.defendTroop.@king == undefined ? "[<i>EmptyName</i>]" : report.battleReport.defendTroop.@king) + "</b> was attacked at <b>" + ms.targetPos + "</b> by <b>" + ms.eventName.substring(0,ms.eventName.indexOf("Attack") - 1) + (ms.otherAllianceName != null ? " of " + ms.otherAllianceName : "") + "</b> from <b>" + ms.startPos + "</b>.   Attacker <b>" + (report.battleReport.@isAttackSuccess == "true" || report.battleReport.@isAttackSuccess == null || report.battleReport.@isAttackSuccess == "" ? "WON" : "LOST") + "</b>: <b>" + _ix545(report.battleReport.attackTroop.troopUnit) + "</b>",report.@reportUrl);
                  if(doWr)
                  {
                     this.logMsg("ALLIANCE WR\'s > " + msg,COLR_AWR_LOG_MSG);
                  }
                  if(doSk)
                  {
                     totalTroopCounts = doSkJnkFilter ? getTotalAtkTroops(report.battleReport.attackTroop.troopUnit) : 0;
                     if(totalTroopCounts <= 0 || totalTroopCounts > skJnkLimit)
                     {
                        skMsg += (skMsg == "" ? "ALLIANCE " + this.player.playerInfo.alliance + " WR\'s > \n" : "\n\n") + msg;
                     }
                  }
               }
            }
         }
         if(skMsg != "")
         {
            for each(receiver in this.skypeWarreportReceiverList)
            {
               try
               {
                  if((skResp = Skype.queueMsg(receiver.id,skMsg,receiver.isGroup)).ok != 1)
                  {
                     if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_WARREPORT || this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NORMAL)
                     {
                        this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > SKYPEWARREPORT: Error sending WarReports to Skype receiver " + receiver.type + ":" + receiver.id + "  " + skResp.errorMsg,COLR_DBG_LOG_MSG);
                     }
                  }
               }
               catch(e:Error)
               {
                  if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_WARREPORT || this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NORMAL)
                  {
                     this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > SKYPEWARREPORT: Error sending WarReports to Skype receiver " + receiver.type + ":" + receiver.id + "  " + e,COLR_DBG_LOG_MSG);
                  }
               }
            }
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_WARREPORT)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > WARREPORT: lastreport: " + this.lastReportTime + ", new: " + this.newLastReportTime + ", page: " + this.reportPage + ", done: " + endOfNewReports,COLR_DBG_LOG_MSG);
         }
         if(!endOfNewReports && this.lastReportTime != null && this.reportPage < 5)
         {
            ++this.reportPage;
            Utils.callLater(10000,CityStateCommands.getMilitarySituationList,[this.reportPage,6,this.militarySituationListHandler]);
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:* = false;
         if(this.castle_captured)
         {
            if(this.timer != null)
            {
               this.timer.stop();
               this.timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
               this.timer = null;
            }
            return;
         }
         if(Connection.getInstance().paused)
         {
            return;
         }
         if(!Connection.getInstance().authenticated)
         {
            return;
         }
         _loc2_ = this.player.castlesArray.length == 1;
         if(MasterTimer.getInstance().canSend(this.timeSlot))
         {
            this._manager();
         }
         else if(MasterTimer.getInstance().canReceive(this.timeSlot))
         {
            _loc2_ = true;
         }
         if(_loc2_ && this.cityTimingAllowed("endPromote",30))
         {
            if(this.getCfg(CityConfigs.CFG_NOMAYOR) < 1)
            {
               this.promoteBestPolHero();
            }
            else if(this.getCfg(CityConfigs.CFG_NOMAYOR) == 1 || this.getCfg(CityConfigs.CFG_NOMAYOR) > 3)
            {
               this.removeMayor();
            }
            else if(this.getCfg(CityConfigs.CFG_NOMAYOR) == 2)
            {
               this.promoteBestAtkHero();
            }
            else if(this.getCfg(CityConfigs.CFG_NOMAYOR) == 3)
            {
               this.promoteBestInteHero();
            }
         }
      }
      
      public function getHeroesByPowerAndStamina(param1:int, param2:int = -1) : ArrayCollection
      {
         var _loc4_:HeroBean = null;
         var _loc3_:ArrayCollection = new ArrayCollection();
         if(param2 == -1)
         {
            param2 = this.getMinEnergyCfg();
         }
         for each(_loc4_ in this.heroes)
         {
            if(_loc4_.stamina >= param2)
            {
               if(!(_loc4_.status != HeroConstants.HERO_FREE_STATU && _loc4_.status != HeroConstants.HERO_CHIEF_STATU))
               {
                  if(param1 >= 0 && Utils.getTotalPointsForHeroAttribute(_loc4_,"power") > param1)
                  {
                     _loc3_.addItem(_loc4_);
                  }
                  if(param1 < 0 && Utils.getTotalPointsForHeroAttribute(_loc4_,"power") < -param1)
                  {
                     _loc3_.addItem(_loc4_);
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function getTownHallLevel() : int
      {
         var _loc1_:int = 10;
         while(_loc1_ >= 1)
         {
            if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_TOWN_HALL,_loc1_) > 0)
            {
               return _loc1_;
            }
            _loc1_--;
         }
         return 0;
      }
      
      private function errorCaught(param1:String) : void
      {
         this.logMsg("Error: " + param1,"#8C008C");
      }
      
      private function getReservedHeroes() : ArrayCollection
      {
         var _loc1_:ArrayCollection = null;
         var _loc2_:HeroBean = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:HeroBean = null;
         var _loc6_:HeroBean = null;
         var _loc7_:HeroBean = null;
         var _loc8_:Array = null;
         var _loc9_:HeroBean = null;
         _loc1_ = new ArrayCollection();
         _loc2_ = null;
         if(this.reservedHeroes != null)
         {
            _loc8_ = this.getAvailableHeroNamesFromHeroListStr(this.reservedHeroes);
            for each(_loc2_ in this.heroes)
            {
               if(_loc2_.ability > 0 || _loc2_.isHero > 0 || _loc8_.indexOf(_loc2_.name.toLowerCase()) != -1)
               {
                  _loc1_.addItem(_loc2_);
               }
            }
            return _loc1_;
         }
         _loc1_.addItem(this.bestAttackHero());
         for each(_loc2_ in this.heroes)
         {
            if(_loc2_.ability > 0 || _loc2_.isHero > 0 || _loc2_.management - _loc2_.level + _loc2_.remainPoint >= 75 || _loc2_.power - _loc2_.level + _loc2_.remainPoint >= 75 || _loc2_.stratagem - _loc2_.level + _loc2_.remainPoint >= 75)
            {
               _loc1_.addItem(_loc2_);
            }
         }
         if(this.trainingHeroNeeded)
         {
            _loc9_ = this.getBestIdleTrainingHero();
            if(_loc9_ != null)
            {
               _loc1_.addItem(_loc9_);
            }
         }
         _loc3_ = this.getCfg(CityConfigs.CFG_HERO);
         if(_loc3_ == 1)
         {
            return _loc1_;
         }
         _loc4_ = this.getCfg(CityConfigs.CFG_FASTHERO);
         if(_loc4_ <= 0)
         {
            _loc4_ = 60;
         }
         _loc5_ = this.bestPoliticHero();
         _loc6_ = this.bestIntelHero();
         if(_loc5_ != null && _loc5_.power >= this.getCfg(CityConfigs.CFG_HEROMINATTACK))
         {
            _loc1_.addItem(_loc5_);
         }
         _loc7_ = null;
         if(int(_loc3_ / 10) >= 2)
         {
            _loc7_ = this._as658(_loc5_);
            if(_loc7_ != null && _loc7_.power >= this.getCfg(CityConfigs.CFG_HEROMINATTACK) && _loc7_.management - _loc7_.level + _loc7_.remainPoint >= _loc4_)
            {
               _loc1_.addItem(_loc7_);
            }
         }
         if(_loc3_ % 10 >= 1 && _loc6_ != null && _loc6_.power >= this.getCfg(CityConfigs.CFG_HEROMINATTACK))
         {
            _loc1_.addItem(_loc6_);
         }
         if(_loc3_ % 10 >= 2)
         {
            _loc7_ = this._jw592(_loc6_);
            if(_loc7_ != null && _loc7_.power >= this.getCfg(CityConfigs.CFG_HEROMINATTACK) && _loc7_.stratagem - _loc7_.level + _loc7_.remainPoint >= _loc4_)
            {
               _loc1_.addItem(_loc7_);
            }
         }
         return _loc1_;
      }
      
      private function setCondGateRules() : void
      {
         var _loc1_:ArmyBean = null;
         var _loc2_:TroopBean = null;
         var _loc3_:int = 0;
         if(this.vrGateSettingCache != null && this.enemyArmies.length > 0 && this.vrGateSettingCacheArmyId == (this.enemyArmies[0] as ArmyBean).armyId)
         {
            this.gateSettings = this.vrGateSettingCache;
            return;
         }
         this.vrGateSettingCacheArmyId = 0;
         _loc1_ = null;
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < this.condGateSettingsRE2.length && this.enemyArmies.length > 0)
         {
            _loc1_ = this.enemyArmies[0];
            _loc2_ = _loc1_.troop == null ? null : Utils.getTroopBeanFromTroopStrBean(_loc1_.troop);
            this.vrGateSettingCacheArmyId = _loc1_.armyId;
            if(_loc2_ == null)
            {
               break;
            }
            if((this.condGateSettingsRE2[_loc3_][0] == null || _jc640RE(_loc2_,this.condGateSettingsRE2[_loc3_][0])) && (this.condGateSettingsRE2[_loc3_][2] == null || _rm985(this.fortification,this.condGateSettingsRE2[_loc3_][2])) && (this.condGateSettingsRE2[_loc3_][1] == null || _jc640RE(this.troop,this.condGateSettingsRE2[_loc3_][1])))
            {
               if(this.getCfg(CityConfigs.CFG_DEBUG) >= CityConfigs.DBG_ADVEVASION1)
               {
                  this.logMsg("Using ALX2 Cond gate: E[" + (this.condGateSettingsRE2[_loc3_][0] == null ? "none" : this._getRuleStr(this.condGateSettingsRE2[_loc3_][0] as TroopBean)) + "] L[" + (this.condGateSettingsRE2[_loc3_][1] == null ? "none" : this._getRuleStr(this.condGateSettingsRE2[_loc3_][1] as TroopBean)) + "] F[" + (this.condGateSettingsRE2[_loc3_][2] == null ? "none" : this._getFortRuleStr(this.condGateSettingsRE2[_loc3_][2] as FortificationsBean)) + "] G[" + (this.condGateSettingsRE2[_loc3_][3] == null ? "none" : this.condGateSettingsRE2[_loc3_][3].toString()) + "]",COLR_DEF_LOG_MSG);
               }
               this.gateSettings = this.condGateSettingsRE2[_loc3_][3];
               this.vrGateSettingCache = this.gateSettings;
               return;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.condGateSettingsRE.length && this.enemyArmies.length > 0)
         {
            _loc1_ = this.enemyArmies[0];
            _loc2_ = _loc1_.troop == null ? null : Utils.getTroopBeanFromTroopStrBean(_loc1_.troop);
            this.vrGateSettingCacheArmyId = _loc1_.armyId;
            if(_loc2_ == null)
            {
               break;
            }
            if((this.condGateSettingsRE[_loc3_][0] == null || isEnoughTroops(_loc2_,this.condGateSettingsRE[_loc3_][0])) && (this.condGateSettingsRE[_loc3_][1] == null || _rm985(this.fortification,this.condGateSettingsRE[_loc3_][1])))
            {
               if(this.getCfg(CityConfigs.CFG_DEBUG) >= CityConfigs.DBG_ADVEVASION1)
               {
                  this.logMsg("Using ALX Cond gate: " + this.condGateSettingsRE[_loc3_].toString(),COLR_DEF_LOG_MSG);
               }
               this.gateSettings = this.condGateSettingsRE[_loc3_][2];
               this.vrGateSettingCache = this.gateSettings;
               return;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.condGateSettings.length)
         {
            if(this.enemyArmies.length > 0)
            {
               _loc1_ = this.enemyArmies[0];
               this.vrGateSettingCacheArmyId = _loc1_.armyId;
            }
            if((this.condGateSettings[_loc3_][0] == null || isEnoughTroops(this.troop,this.condGateSettings[_loc3_][0])) && (this.condGateSettings[_loc3_][1] == null || _rm985(this.fortification,this.condGateSettings[_loc3_][1])))
            {
               this.gateSettings = this.condGateSettings[_loc3_][2];
               this.vrGateSettingCache = this.gateSettings;
               return;
            }
            _loc3_++;
         }
         this.gateSettings = this.defaultGateSettings;
         this.vrGateSettingCache = this.gateSettings;
      }
      
      private function _jw592(param1:HeroBean) : HeroBean
      {
         return this._mh723("stratagem",param1.id);
      }
      
      private function doFindPlayerValley() : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:MapCastleBean = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         if(this.fieldTargetPlayers == null)
         {
            return false;
         }
         var _loc1_:int = 8 * 3600;
         _loc2_ = Math.pow(int(this.fieldTargetPlayersRadius) * 2 + 1,2);
         _loc3_ = null;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = new Object();
         _loc8_ = 0;
         while(_loc8_ <= _loc2_)
         {
            _loc4_ = this._ne789(this.fieldTargetPlayersCenter,_loc8_);
            if(Map.fieldDistance(_loc4_,this.fieldTargetPlayersCenter) <= this.fieldTargetPlayersRadius)
            {
               _loc5_ = Map.getLevel(_loc4_);
               if(_loc5_ == -1)
               {
                  return false;
               }
               if(_loc5_ >= this.fieldTargetPlayersMinLevel)
               {
                  _loc6_ = Map.getType(_loc4_);
                  if(!(_loc6_ == FieldConstants.TYPE_CASTLE || _loc6_ == FieldConstants.TYPE_NPC))
                  {
                     _loc3_ = Map.getDetail(_loc4_);
                     if(_loc3_ == null)
                     {
                        return false;
                     }
                     if(_loc3_.userName != null)
                     {
                        if(this.fieldTargetPlayers.indexOf(_loc3_.userName) != -1)
                        {
                           if(_loc7_[_loc3_.userName] == undefined)
                           {
                              _loc7_[_loc3_.userName] = new Array();
                           }
                           (_loc7_[_loc3_.userName] as Array).push(_loc3_);
                        }
                     }
                  }
               }
            }
            _loc8_++;
         }
         _loc9_ = null;
         _loc10_ = null;
         _loc11_ = null;
         _loc8_ = 0;
         while(_loc8_ < this.fieldTargetPlayers.length)
         {
            _loc9_ = this.fieldTargetPlayers[_loc8_];
            if(_loc7_[_loc9_] != undefined)
            {
               _loc10_ = _loc7_[_loc9_] as Array;
               if(_loc10_.length > 0)
               {
                  _loc11_ = "";
                  for each(_loc3_ in _loc10_)
                  {
                     _loc11_ += " " + Map.getX(_loc3_.id) + "," + Map.getY(_loc3_.id);
                  }
                  this.logMsg(_loc3_.userName + ":" + _loc11_);
               }
            }
            else
            {
               this.logMsg(_loc9_ + ": NONE FOUND");
            }
            _loc8_++;
         }
         this.fieldTargetPlayers = null;
         return true;
      }
      
      private function onTradesUpdate(param1:TradesUpdate) : void
      {
         var _loc2_:int = 0;
         if(param1.castleId != this.castleId)
         {
            return;
         }
         _loc2_ = 0;
         if(param1.updateType == 0)
         {
            this.tradesArray.addItem(param1.tradeBean);
         }
         else if(param1.updateType == 1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.tradesArray.length)
            {
               if(this.tradesArray[_loc2_].id == param1.tradeBean.id)
               {
                  this.tradesArray.removeItemAt(_loc2_);
                  return;
               }
               _loc2_++;
            }
         }
         else if(param1.updateType == 2)
         {
            _loc2_ = 0;
            while(_loc2_ < this.tradesArray.length)
            {
               if(this.tradesArray[_loc2_].id == param1.tradeBean.id)
               {
                  this.tradesArray[_loc2_] = param1.tradeBean;
                  return;
               }
               _loc2_++;
            }
         }
         else
         {
            this.logMsg("Unhandle trade response " + param1.updateType);
         }
      }
      
      public function _uj48(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         _loc2_ = new Array("npc","buildnpc","hunting","valley","keepresource","keeptroop","requesthelp","hiding","rainbow");
         _loc3_ = true;
         _loc4_ = param1.toLowerCase().split(",");
         _loc5_ = null;
         _loc6_ = 0;
         for each(_loc7_ in _loc4_)
         {
            _loc5_ = _loc7_.split(":");
            if(_loc5_.length != 2)
            {
               this.logErrMsg("Invalid warrallymax setting, expecting name:value but getting " + _loc7_);
               _loc3_ = false;
            }
            else if(_loc2_.indexOf(_loc5_[0]) != -1)
            {
               if(Utils.hasValue(_loc5_[1]))
               {
                  _loc6_ = int(_loc2_.indexOf(_loc5_[0]));
                  if(this.warRallySettings[_loc6_] != -1)
                  {
                     this.logMsg("warrallymax value of " + _loc5_[0] + " is changed to " + _loc5_[1] + ", previous value discarded");
                  }
                  this.warRallySettings[_loc6_] = Number(_loc5_[1]);
               }
               else
               {
                  this.logErrMsg("Invalid numeric value of rallymax for " + _loc5_[0] + ": " + _loc5_[1]);
                  _loc3_ = false;
               }
            }
            else
            {
               this.logErrMsg("Invalid rallymax name: " + _loc5_[0] + ", available: " + _loc2_.join(" "));
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      public function getGateSettings() : Array
      {
         return this.gateSettings;
      }
      
      public function get allTroopPlusQueued() : TroopBean
      {
         return this._getAllTroopPlusQueued();
      }
      
      private function doIdleUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:HeroBean = null;
         var _loc3_:RandomEventBean = null;
         var _loc4_:BuildingBean = null;
         var _loc5_:ArmyBean = null;
         var _loc6_:Boolean = false;
         var _loc7_:HeroBean = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:HeroBean = null;
         this.switchRallySettings();
         _loc1_ = 0;
         for each(_loc2_ in this.heroes)
         {
            if(Utils.isHeroRoyal(_loc2_))
            {
               _loc1_++;
            }
         }
         this.specialHeroCount = _loc1_;
         if(this.getCfg(CityConfigs.CFG_NOAUTOQUEST) <= 0)
         {
            if(playerTimingAllowed("quest",10))
            {
               if(this.cityTimingAllowed("quest1",300))
               {
                  ActionFactory.getInstance().getQuestCommands().getQuestType(this.castle.id,1,this.handleGetQuestType);
               }
               else if(this.cityTimingAllowed("quest4",300))
               {
                  ActionFactory.getInstance().getQuestCommands().getQuestType(this.castle.id,4,this.handleGetQuestType);
               }
            }
         }
         if(this.isMainTown() && this.player.randomEventsArray.length > 0 && playerTimingAllowed("randomevent",300))
         {
            for each(_loc3_ in this.player.randomEventsArray)
            {
               if(_loc3_.id == 1)
               {
                  this.player.randomEventsArray.removeItemAt(this.player.randomEventsArray.getItemIndex(_loc3_));
                  ActionFactory.getInstance().getCommonCommands().setEventDone(_loc3_.id,this.handleCommandResponse);
               }
            }
         }
         if(this.isMainTown() && this.getCfg(CityConfigs.CFG_NOAUTOCLAIMGIFTS) <= 0 && playerTimingAllowed("checkandcollectgiftpackages",3600 + int(Math.random() * 9000)))
         {
            ActionFactory.getInstance().getCommonCommands().getPackageList(this.getPackageListHandler);
         }
         if(this.cityTimingAllowed("updatebasicdata",600))
         {
            if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_WALL,1) > 0 && this.fortificationListArray.length == 0)
            {
               ActionFactory.getInstance().getFortificationsCommands().getFortificationsProduceList(this.castleId,this.setFortificationListArray);
            }
            if(this.wallBuildingBean == null)
            {
               ActionFactory.getInstance().getCastleCommands().getAvailableBuildingBean(this.castleId,BuildingConstants.TYPE_WALL,this.setWallBuildingBean);
            }
            if(this.insideBuildingBeans.length == 0)
            {
               ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(this.castleId,this.setInsideBuildingBeans);
            }
            if(this.outsideBuildingBeans.length == 0)
            {
               ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListOutside(this.castleId,this.setOutsideBuildingBeans);
            }
            if(this.troopListArray.length == 0)
            {
               for each(_loc4_ in this.buildings)
               {
                  if(_loc4_.typeId == BuildingConstants.TYPE_BARRACK)
                  {
                     CityStateCommands.getTroopProduceList(this.castleId,_loc4_.positionId,this.setTroopListArray);
                     break;
                  }
               }
            }
         }
         if(this.cityTimingAllowed("refresh",300))
         {
            this.troopProductionUpdateNeeded = true;
            this.fortificationProductionUpdateNeeded = true;
            this.researchUpdateNeeded = true;
            this.heroUpdateNeeded = true;
            this.innUpdateNeeded = true;
         }
         if(this.heroUpdateNeeded)
         {
            this.heroUpdateNeeded = false;
            _loc5_ = null;
            _loc6_ = false;
            for each(_loc2_ in this.heroes)
            {
               if(_loc2_.status == HeroConstants.HERO_GUARD_STATU || _loc2_.status == HeroConstants.HERO_SEND_STATU)
               {
                  _loc6_ = false;
                  for each(_loc5_ in this.localArmies)
                  {
                     if(_loc5_.heroid == _loc2_.id)
                     {
                        _loc6_ = true;
                        break;
                     }
                  }
                  if(!_loc6_)
                  {
                     ActionFactory.getInstance().getHeroCommand().callBackHero(this.castleId,_loc2_.id);
                  }
               }
            }
            _loc7_ = this.getWorstCapturedHero();
            _loc8_ = 80;
            _loc9_ = "#660000";
            if(this.getCfg(CityConfigs.CFG_NOCAPTURE) > 0 && _loc7_ != null && !(_loc7_.ability > 0 || _loc7_.isHero > 0) && !(_loc7_.power - _loc7_.level + _loc7_.remainPoint >= _loc8_ || _loc7_.stratagem - _loc7_.level + _loc7_.remainPoint >= _loc8_ || _loc7_.management - _loc7_.level + _loc7_.remainPoint >= _loc8_))
            {
               this.logMsg("Auto release captured hero " + Utils.heroBeanToString(_loc7_),_loc9_);
               CityStateCommands.releaseHero(this.castleId,_loc7_.id);
            }
            else if(this.getCfg(CityConfigs.CFG_HERO) > 0)
            {
               if(this.trainingHeroName != null && !Utils.isNameKingOrQueen(this.trainingHeroName) && !this.isTrainingHeroInTown() && this.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) == this.heroes.length - this.specialHeroCount && this.cityTimingAllowed("fireherowarning",300))
               {
                  this.logErrMsg("No space in feasting hall for training hero, the worst hero will be fired!");
               }
               _loc10_ = this._ab380();
               if(_loc10_ != null && _loc10_.status == HeroConstants.HERO_SEIZED_STATU && _loc10_.level < 100 && _loc10_.power - _loc10_.level + _loc10_.remainPoint < 70 && !(_loc10_.power - _loc10_.level + _loc10_.remainPoint >= _loc8_ || _loc10_.stratagem - _loc10_.level + _loc10_.remainPoint >= _loc8_ || _loc10_.management - _loc10_.level + _loc10_.remainPoint >= _loc8_) && !(_loc10_.ability > 0 || _loc10_.isHero > 0))
               {
                  this.logMsg("Auto release captured regular hero with low attributes " + Utils.heroBeanToString(_loc10_),_loc9_);
                  CityStateCommands.releaseHero(this.castleId,_loc10_.id);
               }
               else if(this.trainingHeroName != null && !Utils.isNameKingOrQueen(this.trainingHeroName) && !this.isTrainingHeroInTown() && this.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) == this.heroes.length - this.specialHeroCount)
               {
                  if(_loc7_ != null && !(_loc7_.ability > 0 || _loc7_.isHero > 0) && !(_loc7_.power - _loc7_.level + _loc7_.remainPoint >= _loc8_ || _loc7_.stratagem - _loc7_.level + _loc7_.remainPoint >= _loc8_ || _loc7_.management - _loc7_.level + _loc7_.remainPoint >= _loc8_))
                  {
                     this.logMsg("Auto release captured regular hero " + Utils.heroBeanToString(_loc7_) + " to make space for " + this.trainingHeroName,_loc9_);
                     CityStateCommands.releaseHero(this.castle.id,_loc7_.id);
                  }
                  else
                  {
                     _loc10_ = this.getWorstHeroExcludingReservedHeroes();
                     if(_loc10_ != null && (_loc10_.status == HeroConstants.HERO_FREE_STATU || _loc10_.status == HeroConstants.HERO_CHIEF_STATU) && !(_loc10_.ability > 0 || _loc10_.isHero > 0) && !(_loc10_.power - _loc10_.level + _loc10_.remainPoint >= _loc8_ || _loc10_.stratagem - _loc10_.level + _loc10_.remainPoint >= _loc8_ || _loc10_.management - _loc10_.level + _loc10_.remainPoint >= _loc8_))
                     {
                        this.logMsg("Fire regular hero " + Utils.heroBeanToString(_loc10_) + " to make space for " + this.trainingHeroName,_loc9_);
                        if(_loc10_.status == HeroConstants.HERO_CHIEF_STATU)
                        {
                           this.removeMayor();
                        }
                        CityStateCommands.fireHero(this.castleId,_loc10_.id,this.onFireHeroResponse);
                        this.innUpdateNeeded = true;
                     }
                  }
               }
               else if(this.heroes.length - this.specialHeroCount > 0 && this.heroes.length - this.specialHeroCount > this.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) - this.getAdjFHReservedValue())
               {
                  if(_loc7_ != null && !(_loc7_.ability > 0 || _loc7_.isHero > 0) && !(_loc7_.power - _loc7_.level + _loc7_.remainPoint >= _loc8_ || _loc7_.stratagem - _loc7_.level + _loc7_.remainPoint >= _loc8_ || _loc7_.management - _loc7_.level + _loc7_.remainPoint >= _loc8_))
                  {
                     this.logMsg("Auto release captured regular hero " + Utils.heroBeanToString(_loc7_) + " to satisfy feasting hall reserved requirement",_loc9_);
                     CityStateCommands.releaseHero(this.castleId,_loc7_.id);
                  }
                  else
                  {
                     _loc10_ = this.getWorstHeroExcludingReservedHeroes();
                     if(_loc10_ != null && (_loc10_.status == HeroConstants.HERO_FREE_STATU || _loc10_.status == HeroConstants.HERO_CHIEF_STATU) && !(_loc10_.ability > 0 || _loc10_.isHero > 0) && !(_loc10_.power - _loc10_.level + _loc10_.remainPoint >= _loc8_ || _loc10_.stratagem - _loc10_.level + _loc10_.remainPoint >= _loc8_ || _loc10_.management - _loc10_.level + _loc10_.remainPoint >= _loc8_))
                     {
                        this.logMsg("Fire regular hero " + Utils.heroBeanToString(_loc10_) + " to satisfy feasting hall reserved requirement",_loc9_);
                        if(_loc10_.status == HeroConstants.HERO_CHIEF_STATU)
                        {
                           this.removeMayor();
                        }
                        CityStateCommands.fireHero(this.castleId,_loc10_.id,this.onFireHeroResponse);
                        this.innUpdateNeeded = true;
                     }
                  }
               }
               else if(_loc7_ != null)
               {
                  if(this.cityTimingAllowed("capturedheroexists",600))
                  {
                     this.logMsg("<i>CAPTURED HERO IN TOWN: " + Utils.heroBeanToString(_loc7_) + "</i>",_loc9_);
                  }
               }
            }
         }
         if(this.getCfg(CityConfigs.CFG_HERO) > 1 && this.getCfg(CityConfigs.CFG_FASTHERO) > 0 && this.innHeroes != null && this.innHeroes.length > 0 && this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) >= 1)
         {
            this.doHeroHireAndFire(this.innHeroes[0]);
         }
         if(this.getCfg(CityConfigs.CFG_HERO) >= 10 && this.getCfg(CityConfigs.CFG_JUNKHERO) >= 1 && this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) >= 1)
         {
            this.doJunkHero();
         }
      }
      
      private function doRequestHelpTrans() : Boolean
      {
         var _loc4_:CityState = null;
         var _loc5_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:HeroBean = null;
         var _loc1_:Array = new Array();
         var _loc2_:CityManager = null;
         var _loc3_:int = 0;
         for each(_loc4_ in MainScreen.getCities())
         {
            _loc2_ = _loc4_.cityManager;
            _loc25_ = 0;
            while(_loc25_ < _loc2_.requestHelpFieldIds.length)
            {
               _loc3_ = int(_loc2_.requestHelpFieldIds[_loc25_]);
               if(_loc3_ == ANYCOORDINATE || _loc3_ == this.castle.fieldId)
               {
                  if(_loc1_.indexOf(_loc2_.castle.fieldId) == -1)
                  {
                     _loc1_.push(_loc2_.castle.fieldId);
                  }
               }
               _loc25_++;
            }
         }
         _loc5_ = this.rallySettings[RALLY_REQUESTHELP] == -1 ? 2 : int(this.rallySettings[RALLY_REQUESTHELP]);
         if(this._de1078(_loc1_) >= _loc5_)
         {
            return false;
         }
         var _loc6_:Number = 1 + 0.1 * this.getTechLevel(TechConstants.LOAD_TECH);
         var _loc7_:int = this.getRallyDispatchPerArmyLimit(true);
         var _loc8_:Array = Utils.randOrder(MainScreen.getCities().length);
         var _loc9_:Boolean = false;
         var _loc10_:ResourceBean = null;
         var _loc11_:ResourceBean = null;
         var _loc12_:ResourceBean = null;
         var _loc13_:NewArmyParam = null;
         var _loc14_:Number = NaN;
         var _loc15_:Array = new Array(TFConstants.T_SCOUTER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_CARRIAGE);
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         loop2:
         for(; _loc24_ < _loc8_.length; _loc24_++)
         {
            _loc2_ = MainScreen.getCities()[_loc8_[_loc24_]].cityManager;
            if(this != _loc2_)
            {
               _loc25_ = 0;
               while(true)
               {
                  if(_loc25_ >= _loc2_.requestHelpFieldIds.length)
                  {
                     continue loop2;
                  }
                  _loc9_ = Boolean(_loc2_.requestHelpWarConds[_loc25_]);
                  if(!((_loc9_) && !_loc2_.isLastEnemyTimeLessThan1Hr()))
                  {
                     if(!(_loc9_ && this.isLastEnemyTimeLessThan1Hr()))
                     {
                        if(_loc2_.getLocalBuffByWildCardId("ForceopenclosegateBuff") == null)
                        {
                           _loc3_ = int(_loc2_.requestHelpFieldIds[_loc25_]);
                           _loc10_ = _loc2_.requestResourceLocalConds[_loc25_];
                           _loc11_ = _loc2_.requestResourceRemoteConds[_loc25_];
                           if(_loc3_ == ANYCOORDINATE || _loc3_ == this.castle.fieldId)
                           {
                              _loc12_ = _loc2_.getAllResource();
                              _loc13_ = new NewArmyParam();
                              _loc13_.missionType = ObjConstants.ARMY_MISSION_TRANS;
                              if(this.getCfg(CityConfigs.CFG_FASTKEEPRESO) > 0)
                              {
                                 _loc26_ = this.fastestIdleHero();
                                 if(_loc26_ != null)
                                 {
                                    _loc13_.heroId = _loc26_.id;
                                 }
                              }
                              _loc13_.troops = new TroopBean();
                              _loc13_.resource = new ResourceBean();
                              _loc13_.targetPoint = _loc2_.castle.fieldId;
                              _loc14_ = 0;
                              _loc23_ = 0;
                              while(_loc23_ < 5)
                              {
                                 if(_loc12_[resourceIntNames[_loc23_]] < _loc10_[resourceIntNames[_loc23_]])
                                 {
                                    if(this.estResource[resourceIntNames[_loc23_]] >= _loc11_[resourceIntNames[_loc23_]])
                                    {
                                       _loc22_ = Math.min(_loc10_[resourceIntNames[_loc23_]] * 13 / 10 - _loc12_[resourceIntNames[_loc23_]],this.estResource[resourceIntNames[_loc23_]]);
                                       _loc13_.resource[resourceIntNames[_loc23_]] = _loc22_;
                                       _loc14_ += _loc22_;
                                    }
                                 }
                                 _loc23_++;
                              }
                              if(_loc14_ != 0)
                              {
                                 _loc17_ = -1;
                                 _loc18_ = -1;
                                 _loc20_ = -1;
                                 for each(_loc16_ in _loc15_)
                                 {
                                    _loc19_ = Number(this.troop[troopIntNames[_loc16_]]);
                                    if(_loc16_ != TFConstants.T_CARRIAGE)
                                    {
                                       _loc19_ = Math.max(0,_loc19_ - 100);
                                    }
                                    if(_loc19_ > _loc7_)
                                    {
                                       _loc19_ = _loc7_;
                                    }
                                    _loc21_ = _loc19_ * troopLoads[_loc16_] * _loc6_;
                                    if(_loc21_ > _loc14_)
                                    {
                                       _loc18_ = _loc19_;
                                       _loc20_ = _loc21_;
                                       _loc17_ = _loc16_;
                                       break;
                                    }
                                    if(_loc21_ > _loc20_)
                                    {
                                       _loc18_ = _loc19_;
                                       _loc20_ = _loc21_;
                                       _loc17_ = _loc16_;
                                    }
                                 }
                                 if(_loc20_ > _loc14_)
                                 {
                                    _loc18_ = Math.min(_loc18_,Math.ceil(_loc18_ * _loc14_ / _loc20_ * 1.001));
                                    _loc20_ = _loc14_;
                                 }
                                 else if(_loc20_ < _loc14_)
                                 {
                                    _loc23_ = 0;
                                    while(_loc23_ < 5)
                                    {
                                       _loc13_.resource[resourceIntNames[_loc23_]] = Math.floor(_loc13_.resource[resourceIntNames[_loc23_]] * _loc20_ / _loc14_ / 1.001);
                                       _loc23_++;
                                    }
                                 }
                                 if(_loc18_ > 0)
                                 {
                                    _loc13_.troops[troopIntNames[_loc17_]] = _loc18_;
                                    Utils.trimDecimalFromResoAmounts(_loc13_.resource);
                                    if(Utils.getTotalResources(_loc13_.resource) > 0 && this.isEnoughResourcesToMarch(_loc13_))
                                    {
                                       if(playerTimingAllowed("resourcehelp" + _loc2_.castle.fieldId,1 * 60))
                                       {
                                          break;
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
                  _loc25_++;
               }
               this.logMsg("REQUESTHELP > Transporting " + Utils.resourceBeanToString(_loc13_.resource) + " to help " + _loc2_.castle.name + "(" + Map.getX(_loc2_.castle.fieldId) + "," + Map.getY(_loc2_.castle.fieldId) + ")" + (this.getCfg(CityConfigs.CFG_FASTKEEPRESO) > 0 && _loc26_ != null ? " using hero " + _loc26_.name : "") + " with " + Utils.troopBeanToString(_loc13_.troops) + " arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc13_)),COLR_STD_LOG_MSG);
               CityStateCommands.newArmy(this.castleId,_loc13_,this.handleArmyCommandResponse);
               this.adjEstFoodAfterMarch(_loc13_);
               return true;
            }
         }
         return false;
      }
      
      public function _setConfig(param1:String) : Boolean
      {
         return this.cityCfg.setCfg(param1,this.logMsg,this.logErrMsg);
      }
      
      private function getEstFoodAmount(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc2_ = (Utils.getServerTime() - this.resourceStamp) / 1000;
         _loc3_ = Utils.getServerLagTime() / 1000 + 10;
         _loc4_ = this.resource.food.amount;
         _loc5_ = this.resource.troopCostFood - Math.min(0,this.resource.supplyFood);
         if(_loc5_ > 0)
         {
            _loc4_ -= _loc5_ * (_loc2_ + _loc3_) / 3600;
         }
         _loc6_ = 0;
         if(param1 > 1)
         {
            _loc6_ = _loc5_ * (param1 - 1) * 60 / 3600 + _loc4_ * (param1 - 1) / 500;
         }
         return Math.max(_loc4_ - _loc6_,0);
      }
      
      private function _td369() : Boolean
      {
         return this.isResearchAtLevel(TechConstants.THROW_SKILL,6) && this.isResearchAtLevel(TechConstants.MAKE_TECH,5) && this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_BARRACK,9) > 0;
      }
      
      public function _yi1020(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(" ");
         if(_loc2_.length != 2 || Map.coordStringToFieldId(_loc2_[0]) == -1 || Map.coordStringToFieldId(_loc2_[1]) == -1)
         {
            this.logMsg("Invalid npcarea " + param1 + ", need 2 points to specify an area",COLR_STD_LOG_MSG);
            return false;
         }
         this.npcArea = new Array(Map.coordStringToFieldId(_loc2_[0]),Map.coordStringToFieldId(_loc2_[1]));
         return true;
      }
      
      public function setSpamHeroes(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.notSpamHeroes = _loc2_;
      }
      
      private function preProcessGoals(param1:Array) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Script = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         param1 = MainScreen.getInstance()._snippets.getTrimmedSnippetCmdLines(param1);
         if(param1 == null)
         {
            this.logErrMsg("Snippets Error: " + MainScreen.getInstance()._snippets.status.text);
            this.logErrMsg("Goal preprocessing error, please check all include lines");
            return null;
         }
         _loc2_ = new Array();
         _loc3_ = this.city._getScript();
         _loc4_ = null;
         _loc5_ = null;
         _loc6_ = null;
         _loc7_ = false;
         _loc8_ = null;
         _loc9_ = 0;
         _loc10_ = 0;
         while(true)
         {
            if(_loc10_ >= param1.length)
            {
               return _loc2_;
            }
            _loc4_ = Utils.trim(param1[_loc10_]);
            _loc5_ = _loc3_.lineElementsToArray(_loc4_);
            if(_loc5_ == null)
            {
               this.logErrMsg("Error processing line: " + _loc4_);
            }
            else if(_loc5_.length != 0)
            {
               _loc6_ = _loc5_[0].toLowerCase();
               _loc5_.shift();
               _loc5_ = _loc3_.substitute(_loc5_,this.goalVars);
               if(_loc5_ == null)
               {
                  this.logErrMsg("Substituation error on line: " + _loc4_);
               }
               else
               {
                  _loc7_ = false;
                  while(_loc6_ == "condgoal" && !_loc7_)
                  {
                     if(_loc5_.length < 2)
                     {
                        this.logErrMsg("Error processing line " + _loc4_ + ". Usage: condgoal true|false goal param...");
                        _loc7_ = true;
                        break;
                     }
                     if(_loc5_[0] != "true" && _loc5_[0] != "false")
                     {
                        this.logErrMsg("Bad condition in condgoal, expects true or false, gets " + _loc5_[0] + " in " + _loc4_);
                        _loc7_ = true;
                        break;
                     }
                     if(_loc5_[0] == "false")
                     {
                        _loc7_ = true;
                        break;
                     }
                     _loc6_ = _loc5_[1].toLowerCase();
                     _loc5_.splice(0,2);
                  }
                  if(!_loc7_)
                  {
                     if(_loc6_ == "set")
                     {
                        if(_loc5_.length != 2)
                        {
                           this.logErrMsg("Error processing line " + _loc4_ + ". Usage: set varName varValue");
                        }
                        else
                        {
                           this.logMsg("Set goal variable " + _loc5_[0] + " to " + _loc5_[1]);
                           this.goalVars[_loc5_[0]] = _loc5_[1];
                        }
                     }
                     else if(_loc6_ == "include")
                     {
                        _loc8_ = MainScreen.getInstance()._snippets.getTrimmedSnippetCmdLines(["include " + _loc5_.join(" ")]);
                        if(_loc8_ == null)
                        {
                           break;
                        }
                        if(_loc8_.length + param1.length > 10000)
                        {
                           this.logErrMsg("Error processing goal, too large/complex goal");
                           return null;
                        }
                        _loc9_ = int(param1.length - 1);
                        while(_loc9_ > _loc10_)
                        {
                           param1[_loc9_ + _loc8_.length] = param1[_loc9_];
                           _loc9_--;
                        }
                        _loc9_ = 0;
                        while(_loc9_ < _loc8_.length)
                        {
                           param1[_loc10_ + 1 + _loc9_] = _loc8_[_loc9_];
                           _loc9_++;
                        }
                     }
                     else
                     {
                        _loc2_.push(_loc6_ + " " + _loc5_.join(" "));
                     }
                  }
               }
            }
            _loc10_++;
         }
         this.logErrMsg("Goal processing error, please fix line: " + _loc4_ + ". You probably have a bad condgoal somewhere!");
         return null;
      }
      
      public function getBuildingBeanFromTypeId(param1:int) : BuildingBean
      {
         var _loc2_:BuildingBean = null;
         for each(_loc2_ in this.buildings)
         {
            if(_loc2_.typeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function _bx341(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         _loc2_ = param1.split(",");
         _loc3_ = new Array(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_[_loc4_] = Map.getFieldType(_loc2_[_loc4_]);
            if(_loc3_[_loc4_] == -1)
            {
               this.logMsg("Invalid field type: " + _loc2_[_loc4_] + " in " + param1);
               return false;
            }
            _loc4_++;
         }
         this.huntingType = _loc3_;
         if(this.huntingLocation != -1)
         {
            this.logErrMsg("Warning: both huntingpos and huntingtype are specified, huntingpos is ignored");
            this.huntingLocation = -1;
         }
         return true;
      }
      
      public function _setSkypeWrReceivers(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         if(!this.isMainTown())
         {
            this.logMsg("*** WARNING: The skypewarreportreceivers goal has no effect if the city is not maintown, ignoring the goal ***",COLR_WRN_LOG_MSG);
            return true;
         }
         _loc2_ = Utils.trim(param1).split(",");
         if(_loc2_.length > 0)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.substr(0,2).toLowerCase() == "g:" && _loc3_.substr(2) != "")
               {
                  this.skypeWarreportReceiverList.push({
                     "isGroup":true,
                     "id":_loc3_.substr(2)
                  });
               }
               else if(_loc3_.substr(0,6).toLowerCase() == "group:" && _loc3_.substr(6) != "")
               {
                  this.skypeWarreportReceiverList.push({
                     "isGroup":true,
                     "id":_loc3_.substr(6)
                  });
               }
               else if(_loc3_.substr(0,2).toLowerCase() == "p:" && _loc3_.substr(2) != "")
               {
                  this.skypeWarreportReceiverList.push({
                     "isGroup":false,
                     "id":_loc3_.substr(2)
                  });
               }
               else
               {
                  if(!(_loc3_.substr(0,8).toLowerCase() == "private:" && _loc3_.substr(8) != ""))
                  {
                     this.logMsg("*** ERROR: The skypewarreportreceivers goal has encountered an invalid type or missing user/group ID at " + _loc3_ + " or is formatted incorrectly. Valid types are <b>g</b>roup or <b>p</b>rivate ***",COLR_ERR_LOG_MSG);
                     this.skypeWarreportReceiverList = new Array();
                     return false;
                  }
                  this.skypeWarreportReceiverList.push({
                     "isGroup":false,
                     "id":_loc3_.substr(8)
                  });
               }
            }
            if(this.skypeWarreportReceiverList.length == 0)
            {
               this.logMsg("*** ERROR: The skypewarreportreceivers goal has no discernible list of user/group IDs or is formatted incorrectly ***",COLR_ERR_LOG_MSG);
               return false;
            }
            return true;
         }
         this.logMsg("*** WARNING: The skypewarreportreceivers goal has no list of user/group IDs, ignoring the goal ***",COLR_WRN_LOG_MSG);
         return true;
      }
      
      private function _xk442(param1:Number) : Boolean
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!this.isMarketReady() || this.getCfg(CityConfigs.CFG_TRADING) <= 0)
         {
            return false;
         }
         _loc2_ = this.getZeroFoodArmies();
         if(_loc2_.length > 0 && this.resource.gold >= this._rf293() && this.resource.food.amount > 20000000)
         {
            return false;
         }
         if(this.tradesArray.length >= this.getBuildingLevel(BuildingConstants.TYPE_MARKET))
         {
            return false;
         }
         _loc3_ = 0;
         _loc4_ = this.getTrimmedMarketPrice(this.getHighestBidOffer(_loc3_) * 0.8);
         _loc5_ = Math.min(this.getEstFoodAmount(param1),MAXTRADESIZE,this.resource.gold / _loc4_ / 0.005 * 0.9);
         if(_loc5_ != MAXTRADESIZE)
         {
            _loc5_ = Utils.roundAmount(_loc5_);
         }
         if(_loc5_ < Math.max(1000,this.resource.food.amount * 0.2) || _loc2_.length > 0 && _loc5_ >= 10000000)
         {
            return false;
         }
         if(_loc5_ > MAXTRADESIZE)
         {
            _loc5_ = MAXTRADESIZE;
         }
         this.logMsg("ZEROFOOD > Sell " + resourceNames[_loc3_] + ": " + Math.floor(_loc5_) + " at " + _loc4_ + (this.getCfg(CityConfigs.CFG_DEBUG) <= 0 ? "" : ", " + Math.floor(this.resource.food.amount / 1000) + "k/" + Math.floor(_loc5_ / 1000) + "k/" + Utils.abbrNum(param1)),COLR_STD_LOG_MSG);
         CityStateCommands.newTrade(this.castleId,_loc3_,TradeConstants.TRADE_TYPE_SELL,_loc5_,"" + _loc4_,this.zeroFoodResponseHandler);
         this.lastZeroFoodOp = Utils.getServerTime();
         return true;
      }
      
      private function getCfgBuildNpc() : int
      {
         var _loc1_:Number = NaN;
         _loc1_ = this.getCfg(CityConfigs.CFG_BUILDNPC);
         if(_loc1_ == 1)
         {
            return 5;
         }
         return Math.max(_loc1_,0);
      }
      
      private function doRequestHelp() : Boolean
      {
         if(this.getLocalArmiesCount() >= this.getMaxRallySlots())
         {
            return false;
         }
         if(this.doRequestHelpRI())
         {
            return true;
         }
         if(this.doRequestHelpTrans())
         {
            return true;
         }
         return false;
      }
      
      private function _kv1201() : Number
      {
         var _loc1_:int = 0;
         _loc1_ = this.player.playerInfo.prestige / 10 * this.player.castlesArray.length;
         return Math.min(_loc1_ * this.castle.usePACIFY_SUCCOUR_OR_PACIFY_PRAY,10000000);
      }
      
      private function getHeroByTypeFreeNotMayor(param1:String, param2:HeroBean, param3:int = -1) : HeroBean
      {
         var _loc4_:HeroBean = null;
         var _loc5_:HeroBean = null;
         if(param3 == -1)
         {
            param3 = this.getMinEnergyCfg();
         }
         _loc4_ = null;
         for each(_loc5_ in this.heroes)
         {
            if(_loc5_.stamina >= param3)
            {
               if(!(_loc5_.status != HeroConstants.HERO_FREE_STATU && _loc5_.status != HeroConstants.HERO_CHIEF_STATU))
               {
                  if(_loc5_ != param2)
                  {
                     if(_loc4_ == null || Utils.isBestHeroByType(param1,_loc5_,_loc4_))
                     {
                        _loc4_ = _loc5_;
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      private function get castle() : CastleBean
      {
         return this.city.castle;
      }
      
      private function _ww734() : Array
      {
         var _loc1_:HeroBean = null;
         var _loc2_:Array = null;
         var _loc3_:HeroBean = null;
         if(this.npc10Heroes != null)
         {
            return this._tr707(this.npc10Heroes);
         }
         _loc1_ = this.trainingHeroNeeded ? this.getBestIdleTrainingHero() : null;
         _loc2_ = new Array();
         _loc3_ = this.bestAttackHero();
         if(_loc3_ == null)
         {
            return _loc2_;
         }
         if(_loc3_.stamina < this.getMinEnergyCfg())
         {
            return null;
         }
         if(_loc1_ == _loc3_)
         {
            return _loc2_;
         }
         if(_loc3_.status == HeroConstants.HERO_FREE_STATU)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function processKeepResourceGoal(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:ResourceBean = null;
         var _loc6_:Number = NaN;
         _loc3_ = param1.split(" ");
         if(_loc3_.length != 2 && _loc3_.length != 3)
         {
            this.logMsg("Error in keepresource line:  Invalid parameter count: " + _loc3_.length + ", expected keepresource coord resourceCond [minToSend]",COLR_ERR_LOG_MSG);
            return false;
         }
         _loc4_ = Map.coordStringToFieldId(_loc3_[0]);
         _loc5_ = Utils.getEstResoBean(_loc3_[1]);
         _loc6_ = _loc3_.length == 3 ? Utils.removeAbbr(_loc3_[2]) : 5000000;
         if(_loc4_ == -1 || _loc5_ == null || isNaN(_loc6_))
         {
            if(_loc4_ == -1)
            {
               this.logMsg("Error in keepresource line:  Invalid target coordinate",COLR_ERR_LOG_MSG);
            }
            if(_loc5_ == null)
            {
               this.logMsg("Error in keepresource line:  Invalid resource kept",COLR_ERR_LOG_MSG);
            }
            if(isNaN(_loc6_))
            {
               this.logMsg("Error in keepresource line:  Invalid minimum resource to send",COLR_ERR_LOG_MSG);
            }
            return false;
         }
         if(_loc6_ < 10000)
         {
            _loc6_ = 10000;
         }
         this.keepResourceFieldIds.push(_loc4_);
         this.keepResourceMinResources.push(_loc5_);
         this.keepResourceMinSents.push(_loc6_);
         if(param2)
         {
            this.logMsg("Auto move resource to " + Map.fieldIdToCoordString(_loc4_),COLR_STD_LOG_MSG);
         }
         return true;
      }
      
      public function getRallySettings() : Array
      {
         return this.rallySettings;
      }
      
      private function _ha550(param1:int) : Number
      {
         if(this.market[param1] == null || this.market[param1].sellersArray.length == 0)
         {
            return 1000;
         }
         return this.market[param1].sellersArray[this.market[param1].sellersArray.length - 1].amount;
      }
      
      private function quickManager(param1:TimerEvent) : void
      {
         var isTruce:Boolean = false;
         var task:String = null;
         var func:Function = null;
         var newDate:Date = null;
         var e:TimerEvent = param1;
         isTruce = false;
         task = null;
         if(this.castle_captured)
         {
            if(this.quickTimer != null)
            {
               this.quickTimer.stop();
               this.quickTimer.removeEventListener(TimerEvent.TIMER,this.quickManager);
               this.quickTimer = null;
            }
            return;
         }
         try
         {
            if(this._uc804())
            {
               return;
            }
            if(!Connection.getInstance().authenticated)
            {
               return;
            }
            func = null;
            task = "handle enemies";
            func = function():void
            {
               doHandleEnemies();
            };
            this.doTask(task,func);
            if(this.getCfg(CityConfigs.CFG_NOHEALING) <= 0)
            {
               task = "healing troops";
               func = function():void
               {
                  doHealInjuredTroop();
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_ABANDON) <= 0)
            {
               task = "emergency comfort";
               func = function():void
               {
                  doEmergencyComfort();
               };
               this.doTask(task,func);
            }
            else if(this.getCfg(CityConfigs.CFG_ABANDON) == 1)
            {
               task = "lower loyalty";
               func = function():void
               {
                  doLowerLoyalty();
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_ZEROFOOD) > 0)
            {
               task = "zerofood";
               func = function():void
               {
                  doZeroFood();
               };
               this.doTask(task,func);
            }
            task = "updatemarket";
            func = function():void
            {
               updateMarket();
            };
            this.doTask(task,func);
            if(Connection.getInstance().paused)
            {
               return;
            }
            if(this.isCanCounterAmbush())
            {
               if(this.cityTimingAllowed("undoambushed",10))
               {
                  this.doAutoUseAdvByAHiddenPath(false);
               }
            }
            isTruce = this.getBuff("PlayerPeaceBuff") != null;
            newDate = new Date();
            if(!isTruce && !(this.lastBattleAfterAdvMoveErrorTime != null && this.lastBattleAfterAdvMoveErrorTime.getTime() + 3600 * 1000 > newDate.getTime()) && !(lastAntiBattleErrorTime != null && lastAntiBattleErrorTime.getTime() + 3600 * 1000 > newDate.getTime()) && !(this.lastCapitalTruceErrorTime != null && this.lastCapitalTruceErrorTime.getTime() + 3600 * 1000 > newDate.getTime()) && !(this.lastAmbushFromAllSideErrorTime != null && this.lastAmbushFromAllSideErrorTime.getTime() + 15 * 600 * 1000 > newDate.getTime()))
            {
               task = "loyalty attack";
               func = function():void
               {
                  doLoyaltyAttack();
               };
               this.doTask(task,func);
               task = "spam attack";
               func = function():void
               {
                  doSpamAttack();
               };
               this.doTask(task,func);
               task = "honor attack";
               func = function():void
               {
                  doHonorAttack();
               };
               this.doTask(task,func);
               task = "valley attack";
               func = function():void
               {
                  doValleyAttack();
               };
               this.doTask(task,func);
               task = "find player valley";
               func = function():void
               {
                  doFindPlayerValley();
               };
               this.doTask(task,func);
            }
            if(this.isMainTown())
            {
               task = "alliance report";
               func = function():void
               {
                  doCheckAllianceReports();
               };
               this.doTask(task,func);
               task = "mail notification";
               func = function():void
               {
                  doMailNotification();
               };
               this.doTask(task,func);
               task = "new report";
               func = function():void
               {
                  doNewReport();
               };
               this.doTask(task,func);
            }
            if(this.researches == null && playerTimingAllowed("research",6))
            {
               this.researches = new ArrayCollection();
               CityStateCommands.getResearchList(this.castleId,this._eh967);
            }
            if(!MasterTimer.getInstance().canReceive(this.timeSlot) && this.trainingHeroNeeded)
            {
               this._reserveEmergencyTimeSlot();
            }
            if(!MasterTimer.getInstance().canSend(this.timeSlot))
            {
               return;
            }
            task = "update upgrade condition";
            func = function():void
            {
               _uu581();
            };
            this.doTask(task,func);
            task = "search unoccupied resource fields";
            func = function():void
            {
               doSearchForUnoccupiedResourceFields();
            };
            this.doTask(task,func);
            task = "search unoccupied flat fields";
            func = function():void
            {
               doSearchForUnoccupiedFlatFields();
            };
            this.doTask(task,func);
            task = "search unoccupied local fields";
            func = function():void
            {
               doSearchForUnoccupiedLocalFields();
            };
            this.doTask(task,func);
            task = "find evasion field";
            func = function():void
            {
               if(evasionFieldId != -1 && Map.getType(evasionFieldId) != FieldConstants.TYPE_NPC)
               {
                  evasionFieldId = -1;
               }
               if(evasionFieldId == -1)
               {
                  _fa789();
               }
            };
            this.doTask(task,func);
            task = "update inn";
            func = function():void
            {
               if(innUpdateNeeded && MasterTimer.getInstance().canSend(timeSlot))
               {
                  innUpdateNeeded = false;
                  updateInn();
               }
            };
            this.doTask(task,func);
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: " + task + ", " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      public function _wb316ALX(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(this.getCfg(CityConfigs.CFG_GATE) <= 0)
         {
            this.logMsg("Please set condgatepolicyALX *after* setting gate config");
            return false;
         }
         _loc2_ = param1.split(" ");
         if(_loc2_.length != 6 && _loc2_.length != 7)
         {
            this.logMsg("Usage: condgatepolicyALX troopCond (enemy) fortCond gate1 gate2 gate3 gate4 [gate5]");
            return false;
         }
         if(_loc2_.length == 6)
         {
            _loc2_.push("0");
         }
         _loc3_ = Utils.getTroops(_loc2_[0]);
         if(_loc2_[0] != "none" && _loc3_ == null)
         {
            this.logMsg("Invalid troop condition: " + _loc2_[0]);
            return false;
         }
         _loc4_ = Utils.getFortifications(_loc2_[1]);
         if(_loc2_[1] != "none" && _loc4_ == null)
         {
            this.logMsg("Invalid fortification condition: " + _loc2_[1]);
            return false;
         }
         _loc5_ = 2;
         while(_loc5_ < 7)
         {
            if(!this._vi518(_loc2_[_loc5_],0,4))
            {
               this.logMsg("Invalid gate value, expecting integer from 0 to 3, get: " + _loc2_[_loc5_]);
               return false;
            }
            _loc5_++;
         }
         _loc6_ = new Array(_loc3_,_loc4_,new Array(int(_loc2_[2]),int(_loc2_[3]),int(_loc2_[4]),int(_loc2_[5]),int(_loc2_[6])));
         this.condGateSettingsRE.push(_loc6_);
         this.vrGateSettingCache = null;
         this.vrGateSettingCacheArmyId = 0;
         return true;
      }
      
      private function _xm876() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:FieldBean = null;
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            return false;
         }
         _loc1_ = this.getCfg(CityConfigs.CFG_HUNTING) > 0 || buildCityLocation != -1 ? 1 : 0;
         if(this.fields.length + _loc1_ < this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL))
         {
            return true;
         }
         _loc2_ = this._jk900();
         if(_loc2_ == null)
         {
            return false;
         }
         this.logMsg("Abandon valley: " + Map.fieldIdToString(_loc2_.id),COLR_STD_LOG_MSG);
         CityStateCommands.giveUpField(_loc2_.id);
         return true;
      }
      
      private function _bf968(param1:int = 10) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:ResourceBean = null;
         _loc2_ = 10000;
         _loc3_ = this._ps301();
         if(_loc3_.gold + _loc2_ > this.estResource.gold || _loc3_.wood + _loc2_ > this.estResource.wood || _loc3_.stone + _loc2_ > this.estResource.stone || _loc3_.iron + _loc2_ > this.estResource.iron)
         {
            return false;
         }
         return true;
      }
      
      public function getBuildingBeanFromPositionId(param1:int) : BuildingBean
      {
         var _loc2_:BuildingBean = null;
         for each(_loc2_ in this.buildings)
         {
            if(_loc2_.positionId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function _populate_I_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:HeroBean = null;
         if(this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) < 1)
         {
            param1.removeAll();
            return;
         }
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         for each(_loc4_ in this.innHeroes)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = _loc4_.name;
            _loc3_.col2 = _loc4_.management - _loc4_.managementAdded >= Math.max(_loc4_.stratagem - _loc4_.stratagemAdded,_loc4_.power - _loc4_.powerAdded) ? "Pol" : (_loc4_.stratagem - _loc4_.stratagemAdded >= Math.max(_loc4_.management - _loc4_.managementAdded,_loc4_.power - _loc4_.powerAdded) ? "Int" : "Att");
            _loc3_.col3 = _loc4_.level;
            _loc3_.col4 = _loc4_.management + "/" + _loc4_.power + "/" + _loc4_.stratagem;
            _loc3_.col5 = _loc4_.management - _loc4_.managementAdded + "/" + (_loc4_.power - _loc4_.powerAdded) + "/" + (_loc4_.stratagem - _loc4_.stratagemAdded);
            _loc3_.label = _loc4_.name + " (" + _loc4_.level + ")\nStats: " + _loc3_.col4 + "\nBase: " + _loc3_.col5 + "\nDist:: " + _loc4_.managementAdded + "/" + _loc4_.powerAdded + "/" + _loc4_.stratagemAdded + "\n\nCost: g:" + _loc4_.level * 1000;
            _loc2_.addItem(_loc3_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function getAllTroopsInAccount() : TroopBean
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:ArmyBean = null;
         var _loc5_:CityState = null;
         if(this.troop == null)
         {
            return new TroopBean();
         }
         _loc1_ = new TroopBean().toObject();
         _loc2_ = null;
         _loc3_ = null;
         for each(_loc4_ in this.selfArmies)
         {
            if(_loc4_.troop != null)
            {
               _loc2_ = _loc4_.troop.toObject();
               for(_loc3_ in _loc2_)
               {
                  _loc1_[_loc3_] += int(_loc2_[_loc3_]);
               }
            }
         }
         for each(_loc5_ in MainScreen.getCities())
         {
            if(_loc5_.cityManager.troop != null)
            {
               _loc2_ = _loc5_.cityManager.troop.toObject();
               for(_loc3_ in _loc2_)
               {
                  _loc1_[_loc3_] += int(_loc2_[_loc3_]);
               }
            }
         }
         return new TroopBean(_loc1_);
      }
      
      public function _cfg_priorityFarming(param1:String) : Boolean
      {
         var _loc2_:Array = param1.split(" ");
         var _loc3_:Array = new Array(5);
         if(_loc2_.length < 3)
         {
            this.logMsg("Usage: priorityfarming level trooplimit farmingtroop [radius] [frequency] [herolist]");
            return false;
         }
         if(!Utils.hasValue(_loc2_[0]))
         {
            this.logMsg("Invalid priorityfarming npc level " + _loc2_[0] + " in setting " + param1);
            return false;
         }
         _loc3_[XNPC_LEVEL] = int(_loc2_[0]);
         if(_loc3_[XNPC_LEVEL] < 1 || _loc3_[XNPC_LEVEL] > 10)
         {
            this.logMsg("Invalid priorityfarming npc level " + _loc2_[0] + " in setting " + param1);
            return false;
         }
         _loc3_[XNPC_LIMIT] = Utils.getTroops(_loc2_[1]);
         if(_loc3_[XNPC_LIMIT] == null)
         {
            this.logMsg("Invalid priorityfarming npc troop limit " + _loc2_[1] + " in setting " + param1);
            return false;
         }
         _loc3_[XNPC_TROOP] = Utils.getTroops(_loc2_[2]);
         if(_loc3_[XNPC_TROOP] == null)
         {
            this.logMsg("Invalid priorityfarming npc troop " + _loc2_[2] + " in setting " + param1);
            return false;
         }
         if(_loc2_.length < 4)
         {
            _loc3_[XNPC_RADIUS] = 10;
         }
         else
         {
            if(!Utils.hasValue(_loc2_[3]))
            {
               this.logMsg("Invalid priorityfarming radius " + _loc2_[3] + " in setting " + param1);
               return false;
            }
            _loc3_[XNPC_RADIUS] = Number(_loc2_[3]);
         }
         if(_loc2_.length < 5)
         {
            _loc3_[XNPC_FREQUENCY] = 480;
         }
         else
         {
            if(!Utils.hasValue(_loc2_[4]))
            {
               this.logMsg("Invalid priorityfarming frequency " + _loc2_[4] + " in setting " + param1);
               return false;
            }
            _loc3_[XNPC_FREQUENCY] = Number(_loc2_[4]);
         }
         var _loc4_:Array = null;
         if(_loc2_.length < 6)
         {
            _loc3_[XNPC_HEROLIST] = null;
         }
         else
         {
            _loc4_ = _loc2_[5].toString().toLowerCase().split(",");
            this.getAvailableHeroNamesFromHeroListStr(_loc4_,true);
            _loc3_[XNPC_HEROLIST] = _loc4_;
         }
         _loc3_[XNPC_NPCLIST] = null;
         this.priorityNpcSettings.push(_loc3_);
         this.logMsg("Priority farming: npc" + _loc3_[XNPC_LEVEL] + " within " + _loc3_[XNPC_RADIUS] + " miles once every " + _loc3_[XNPC_FREQUENCY] + " minutes with " + Utils.troopBeanToString(_loc3_[XNPC_TROOP]) + " when having more than " + Utils.troopBeanToString(_loc3_[XNPC_LIMIT]));
         return true;
      }
      
      public function getMaxTroopLoad(param1:TroopBean) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         _loc2_ = 0;
         _loc3_ = new Array(TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER);
         for each(_loc4_ in _loc3_)
         {
            _loc2_ += param1[troopIntNames[_loc4_]] * troopLoads[_loc4_];
         }
         if(this.researches == null)
         {
            return _loc2_;
         }
         return _loc2_ * (1 + 0.1 * this.getTechLevel(TechConstants.LOAD_TECH));
      }
      
      public function _ls869(param1:int, param2:ResourceBean, param3:ResourceBean) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:NewArmyParam = null;
         var _loc7_:Number = NaN;
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            this.logMsg("Rally Spots filled");
            return false;
         }
         if(param2 == null || param3 == null)
         {
            this.logMsg("Invalid condition and resource value provided");
            return false;
         }
         _loc4_ = this.getTechLevel(TechConstants.LOAD_TECH);
         _loc5_ = (param3.gold + param3.food + param3.wood + param3.stone + param3.iron) / (5000 + 5000 * _loc4_ / 10);
         _loc5_ = int(_loc5_ / 10 + 1) * 10;
         if(_loc5_ > this.troop.carriage)
         {
            return false;
         }
         _loc6_ = new NewArmyParam();
         _loc6_.troops = new TroopBean();
         _loc6_.troops.carriage = _loc5_;
         _loc6_.resource = param3;
         _loc6_.targetPoint = param1;
         _loc6_.missionType = ObjConstants.ARMY_MISSION_TRANS;
         _loc7_ = this.getFoodNeededToMarch(_loc6_);
         if(this.estResource.gold < param2.gold || this.estResource.food < param2.food || this.estResource.wood < param2.wood || this.estResource.stone < param2.stone || this.estResource.iron < param2.iron)
         {
            return false;
         }
         if(this.estResource.gold < param3.gold || this.estResource.food < param3.food + _loc7_ || this.estResource.wood < param3.wood || this.estResource.stone < param3.stone || this.estResource.iron < param3.iron)
         {
            return false;
         }
         if(this.getArmyToTarget(param1))
         {
            return false;
         }
         Utils.trimDecimalFromResoAmounts(_loc6_.resource);
         if(!this.isEnoughResourcesToMarch(_loc6_))
         {
            return false;
         }
         this.logMsg("Dumping resource to " + Map.fieldIdToString(param1) + " t:" + _loc6_.troops.carriage + ", g:" + _loc6_.resource.gold + " w:" + _loc6_.resource.wood + " s:" + _loc6_.resource.stone + " i:" + _loc6_.resource.iron);
         CityStateCommands.newArmy(this.castleId,_loc6_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc6_);
         return true;
      }
      
      public function _clearTroopQueuesByType(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AllProduceBean = null;
         for each(_loc3_ in this.troopProduceQueue)
         {
            _loc2_ = _loc3_.allProduceQueueArray.length - 1;
            while(_loc2_ >= 0)
            {
               if(_loc3_.getAllProduceQueue(_loc2_).type == param1)
               {
                  CityStateCommands.cancelTroopProduce(this.castleId,_loc3_.positionId,_loc3_.getAllProduceQueue(_loc2_).queueId);
               }
               _loc2_--;
            }
         }
         Utils.callLater(5000,this.updateTroopQueue);
      }
      
      public function _tj1139(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Array = null;
         var _loc7_:ArrayCollection = null;
         var _loc8_:String = null;
         _loc2_ = null;
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = true;
         _loc6_ = param1.split(",");
         _loc7_ = new ArrayCollection();
         for each(_loc8_ in _loc6_)
         {
            _loc2_ = _loc8_.split(":");
            if(_loc2_.length != 2)
            {
               this.logMsg("Invalid tech condition: " + _loc8_);
               _loc5_ = false;
            }
            else
            {
               _loc3_ = TechType.fromString(_loc2_[0]);
               if(_loc3_ == -1)
               {
                  this.logMsg("Invalid tech: " + _loc8_);
                  _loc5_ = false;
               }
               else if(!Utils.hasValue(_loc2_[1]))
               {
                  this.logMsg("Invalid research level in " + _loc8_);
                  _loc5_ = false;
               }
               else
               {
                  _loc4_ = int(_loc2_[1]);
                  if(_loc4_ < 0 || _loc4_ > 10)
                  {
                     this.logMsg("Research level not in range [0,10]: " + _loc8_);
                     _loc5_ = false;
                  }
                  else
                  {
                     _loc7_.addItem(new CityCondition(false,_loc3_,_loc4_));
                     this.cityCfg.configs[CityConfigs.CFG_RESEARCH] = 1;
                  }
               }
            }
         }
         this.techRequirements.addItem(_loc7_);
         return _loc5_;
      }
      
      private function _id1003() : Boolean
      {
         var _loc1_:String = null;
         if(this.npc10LimitTroopBean == null || this.trainingHeroName == null)
         {
            return false;
         }
         for each(_loc1_ in this.npc10Heroes)
         {
            if(_loc1_.toLowerCase() == this.trainingHeroName.toLowerCase())
            {
               return true;
            }
         }
         return false;
      }
      
      public function processKeeptroopGoals(param1:String, param2:Boolean = false, param3:Boolean = false) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TroopBean = null;
         var _loc8_:int = 0;
         _loc4_ = param1.split(" ");
         if(_loc4_.length != 2 && _loc4_.length != 3)
         {
            if(param3)
            {
               this.logMsg("SETGOALERROR > Invalid parameters, expect keeptotaltroop coord troopcond [mincount]",COLR_ERR_LOG_MSG);
            }
            else
            {
               this.logMsg("SETGOALERROR > Invalid parameters, expect keeptroop coord troopcond [mincount]",COLR_ERR_LOG_MSG);
            }
            return false;
         }
         _loc5_ = 500;
         _loc6_ = Map.coordStringToFieldId(_loc4_[0]);
         _loc7_ = Utils.getTroops(_loc4_[1]);
         _loc8_ = _loc4_.length == 2 ? _loc5_ : int(Utils.removeAbbr(_loc4_[2]));
         if(_loc6_ == -1)
         {
            this.logMsg("SETGOALERROR > Invalid target coordinate value " + _loc4_[0] + " in keep" + (param3 ? "total " : "") + "troop line",COLR_ERR_LOG_MSG);
            return false;
         }
         if(_loc7_ == null)
         {
            this.logMsg("SETGOALERROR > Invalid " + (param3 ? "total " : "") + "troop kept value",COLR_ERR_LOG_MSG);
            return false;
         }
         if(isNaN(_loc8_) || _loc8_ < 1)
         {
            this.logMsg("SETGOALERROR > Invalid min count value in keep" + (param3 ? "total " : "") + "troop line",COLR_ERR_LOG_MSG);
            return false;
         }
         this.keepTroopFieldIds.push(_loc6_);
         this.keepTroopTroopBeans.push(_loc7_);
         this.keepTroopMinSents.push(_loc8_);
         this.keepTroopTotalFlags.push(param3);
         if(param2)
         {
            this.logMsg("KEEPTROOP > Set move troop to " + Map.fieldIdToCoordString(_loc6_) + ", troop condition " + Utils.troopBeanToString(_loc7_) + ", minimum troop " + _loc8_,COLR_STD_LOG_MSG);
         }
         return true;
      }
      
      private function _al1086(param1:Boolean) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc4_ = 0;
         if(param1)
         {
            _loc2_ = BuildingConstants.BUILDING_INSIDE_MIN;
            while(_loc2_ <= BuildingConstants.BUILDING_INSIDE_MAX)
            {
               if(!this.isBuildingAtPosition(_loc2_))
               {
                  _loc4_++;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = Math.min(BuildingConstants.BUILDING_OUTSIDE_MAX,BuildingConstants.BUILDING_OUTSIDE_MIN + BuildingConstants.BUILDING_OUTSIDE_START_NUM - 1 + BuildingConstants.BUILDING_OUTSIDE_ADDITION * (this.getTownHallLevel() - 1));
            _loc2_ = BuildingConstants.BUILDING_OUTSIDE_MIN;
            while(_loc2_ <= _loc3_)
            {
               if(!this.isBuildingAtPosition(_loc2_))
               {
                  _loc4_++;
               }
               _loc2_++;
            }
         }
         return _loc4_;
      }
      
      public function isValley(param1:int) : Boolean
      {
         var _loc2_:FieldBean = null;
         for each(_loc2_ in this.fields)
         {
            if(_loc2_.id == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getFoodAmountRequiredForComfort() : Number
      {
         return Math.min(this.player.playerInfo.prestige / 10 * this.player.castlesArray.length * this.castle.usePACIFY_SUCCOUR_OR_PACIFY_PRAY,10000000);
      }
      
      private function flatOkayForBuildnpc(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         _loc3_ = this.getCfgBuildNpc();
         if(_loc3_ != 15)
         {
            return this.levelOkayForBuildnpc(param2,_loc3_);
         }
         _loc4_ = Map.fieldDistance(param1,this.castle.fieldId);
         return param2 == 10 && _loc4_ <= this.distanceSettings[DISTANCE_BUILDNPC10] || param2 == 5 && _loc4_ > this.distanceSettings[DISTANCE_BUILDNPC10];
      }
      
      public function _setSchedulePolicy(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = param1.split(" ");
         if(_loc2_.length % 2 != 0)
         {
            this.logMsg("schedulepolicy must contain an even number of time markers",COLR_ERR_LOG_MSG);
            return false;
         }
         _loc3_ = new Array();
         _loc4_ = null;
         _loc5_ = 0;
         _loc6_ = 0;
         for each(_loc7_ in _loc2_)
         {
            _loc4_ = _loc7_.split(":");
            if(_loc4_.length != 2 || !Utils.hasValue(_loc4_[0]) || !Utils.hasValue(_loc4_[1]))
            {
               this.logMsg("Invalid time marker, " + _loc7_ + " should be of the form hh:mm",COLR_ERR_LOG_MSG);
               return false;
            }
            _loc5_ = int(_loc4_[0]) * 60 + int(_loc4_[1]);
            _loc3_.push(_loc5_);
         }
         _loc8_ = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc3_.length)
         {
            _loc8_ = _loc9_ + 1;
            while(_loc8_ < _loc3_.length)
            {
               _loc6_ = Math.abs(_loc3_[_loc9_] - _loc3_[_loc8_]);
               if(_loc6_ < 60 || _loc6_ > 60 * 23)
               {
                  this.logMsg("All time markers must be at least 1 hour apart",COLR_ERR_LOG_MSG);
                  return false;
               }
               _loc8_++;
            }
            _loc9_++;
         }
         this._ti267(_loc3_);
         return true;
      }
      
      public function _doQFarm() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TroopBean = null;
         var _loc4_:HeroBean = null;
         var _loc5_:TroopBean = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:NewArmyParam = null;
         var _loc11_:Array = null;
         var _loc12_:Number = NaN;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         this.taskSearchLocalNPCs();
         this.processAutoGear();
         if(this.getCfg(CityConfigs.CFG_HERO) > 1 && this.getCfg(CityConfigs.CFG_FASTHERO) > 0 && this.innHeroes != null && this.innHeroes.length > 0 && this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) >= 1)
         {
            this.doHeroHireAndFire(this.innHeroes[0]);
         }
         if(this.getCfg(CityConfigs.CFG_HERO) >= 10 && this.getCfg(CityConfigs.CFG_JUNKHERO) >= 1 && this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) >= 1)
         {
            this.doJunkHero();
         }
         if(this.localNPCs == null || this.localNPC10s == null)
         {
            return null;
         }
         _loc1_ = this.getAvailableRallyMaxHidingSlots() + this.getAvailableRallyMaxRainbowSlots();
         _loc2_ = this.getMaxRallySlots() - this.getLocalArmiesCount() - _loc1_;
         if(this._cd932 != -1)
         {
            _loc2_ = Math.min(_loc2_,this._cd932 - this._rr420(-1));
         }
         _loc3_ = new TroopBean();
         this.troop.copyTo(_loc3_);
         _loc4_ = null;
         _loc5_ = null;
         _loc6_ = null;
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = null;
         _loc11_ = new Array();
         _loc12_ = NaN;
         _loc13_ = null;
         for each(_loc15_ in this.priorityNpcSettings)
         {
            _loc5_ = _loc15_[XNPC_TROOP];
            _loc6_ = _loc15_[XNPC_NPCLIST];
            _loc13_ = _loc15_[XNPC_HEROLIST] != null ? this._tr707(_loc15_[XNPC_HEROLIST]) : this._ka930();
            for each(_loc4_ in _loc13_)
            {
               if(_loc4_.stamina >= this.getMinEnergyCfg())
               {
                  if(_loc11_.length >= _loc2_)
                  {
                     break;
                  }
                  if(playerTimingAllowed("qHero" + _loc4_.id,30,true))
                  {
                     if(isEnoughTroops(_loc3_,_loc5_) && isEnoughTroops(_loc3_,_loc15_[XNPC_LIMIT]))
                     {
                        _loc7_ = 0;
                        while(_loc6_ != null && _loc7_ < _loc6_.length)
                        {
                           _loc8_ = int(_loc6_[_loc7_]);
                           if(!(this.npcAvoidList != null && this.npcAvoidList.indexOf(_loc8_) != -1))
                           {
                              if(Map.getType(_loc8_) == FieldConstants.TYPE_NPC)
                              {
                                 _loc10_ = new NewArmyParam();
                                 _loc10_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                 _loc10_.heroId = _loc4_.id;
                                 _loc10_.targetPoint = _loc8_;
                                 _loc10_.troops = _loc5_;
                                 _loc10_.resource = new ResourceBean();
                                 _loc12_ = this.getTravelTimeReliefStationAdj(_loc10_) / Utils.getHeroSpeedFactor(_loc4_);
                                 if(!this.isWarTownOn(2 * _loc12_))
                                 {
                                    if(this.isEnoughResourcesToMarch(_loc10_))
                                    {
                                       if(playerArmyTimingAllowed("attack" + _loc8_,_loc12_,_loc15_[XNPC_FREQUENCY] * 60,true))
                                       {
                                          if(playerTimingAllowed("qLoc" + _loc8_,30))
                                          {
                                             playerTimingAllowed("qHero" + _loc4_.id,0);
                                             for each(_loc9_ in troopTypes)
                                             {
                                                _loc3_[troopIntNames[_loc9_]] -= _loc5_[troopIntNames[_loc9_]];
                                             }
                                             _loc11_.push(_loc10_);
                                             break;
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                           _loc7_++;
                        }
                     }
                  }
               }
            }
         }
         if(this.npc10LimitTroopBean != null)
         {
            _loc5_ = this.getTroopForQFarmNpc10();
            _loc6_ = this.npc10List == null ? this.localNPC10s : this.npc10List;
            _loc14_ = this._ww734();
            for each(_loc4_ in _loc14_)
            {
               if(_loc4_.stamina >= this.getMinEnergyCfg())
               {
                  if(_loc11_.length >= _loc2_)
                  {
                     break;
                  }
                  if(playerTimingAllowed("qHero" + _loc4_.id,30,true))
                  {
                     if(isEnoughTroops(_loc3_,_loc5_) && isEnoughTroops(_loc3_,this.npc10LimitTroopBean))
                     {
                        _loc7_ = 0;
                        while(_loc6_ != null && _loc7_ < _loc6_.length)
                        {
                           _loc8_ = int(_loc6_[_loc7_]);
                           if(!(this.npcAvoidList != null && this.npcAvoidList.indexOf(_loc8_) != -1))
                           {
                              if(!(this.npc10Area != null && !Map.isInArea(this.npc10Area[0],this.npc10Area[1],_loc8_)))
                              {
                                 if(Map.getType(_loc8_) == FieldConstants.TYPE_NPC)
                                 {
                                    _loc10_ = new NewArmyParam();
                                    _loc10_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                    _loc10_.heroId = _loc4_.id;
                                    _loc10_.targetPoint = _loc8_;
                                    _loc10_.troops = _loc5_;
                                    _loc10_.resource = new ResourceBean();
                                    _loc12_ = this.getTravelTimeReliefStationAdj(_loc10_) / Utils.getHeroSpeedFactor(_loc4_);
                                    if(!this.isWarTownOn(2 * _loc12_))
                                    {
                                       if(this.isEnoughResourcesToMarch(_loc10_))
                                       {
                                          if(playerArmyTimingAllowed("attack" + _loc8_,_loc12_,8 * 3600,true))
                                          {
                                             if(playerTimingAllowed("qLoc" + _loc8_,30))
                                             {
                                                playerTimingAllowed("qHero" + _loc4_.id,0);
                                                for each(_loc9_ in troopTypes)
                                                {
                                                   _loc3_[troopIntNames[_loc9_]] -= _loc5_[troopIntNames[_loc9_]];
                                                }
                                                _loc11_.push(_loc10_);
                                                break;
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                           _loc7_++;
                        }
                     }
                  }
               }
            }
         }
         if(this.getCfg(CityConfigs.CFG_NPC) > 0)
         {
            _loc5_ = this._hq910();
            _loc6_ = this.npcList == null ? this.localNPCs : this.npcList;
            _loc14_ = this._ka930();
            for each(_loc4_ in _loc14_)
            {
               if(_loc4_.stamina >= this.getMinEnergyCfg())
               {
                  if(_loc11_.length >= _loc2_)
                  {
                     break;
                  }
                  if(playerTimingAllowed("qHero" + _loc4_.id,30,true))
                  {
                     if(isEnoughTroops(_loc3_,_loc5_))
                     {
                        _loc7_ = 0;
                        while(_loc6_ != null && _loc7_ < _loc6_.length)
                        {
                           _loc8_ = int(_loc6_[_loc7_]);
                           if(!(this.npcAvoidList != null && this.npcAvoidList.indexOf(_loc8_) != -1))
                           {
                              if(!(this.npcArea != null && !Map.isInArea(this.npcArea[0],this.npcArea[1],_loc8_)))
                              {
                                 if(Map.getType(_loc8_) == FieldConstants.TYPE_NPC)
                                 {
                                    if(this.npcList != null)
                                    {
                                       _loc10_ = new NewArmyParam();
                                       _loc10_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                       _loc10_.heroId = _loc4_.id;
                                       _loc10_.targetPoint = _loc8_;
                                       _loc10_.troops = _loc5_;
                                       _loc10_.resource = new ResourceBean();
                                       _loc12_ = this.getTravelTimeReliefStationAdj(_loc10_) / Utils.getHeroSpeedFactor(_loc4_);
                                       if(!this.isWarTownOn(2 * _loc12_))
                                       {
                                          if(this.isEnoughResourcesToMarch(_loc10_))
                                          {
                                             if(playerArmyTimingAllowed("attack" + _loc8_,_loc12_,8 * 3600,true))
                                             {
                                                if(playerTimingAllowed("qLoc" + _loc8_,30))
                                                {
                                                   playerTimingAllowed("qHero" + _loc4_.id,0);
                                                   for each(_loc9_ in troopTypes)
                                                   {
                                                      _loc3_[troopIntNames[_loc9_]] -= _loc5_[troopIntNames[_loc9_]];
                                                   }
                                                   _loc11_.push(_loc10_);
                                                   break;
                                                }
                                             }
                                          }
                                       }
                                    }
                                    else if(Map.getLevel(_loc8_) >= this.getCfg(CityConfigs.CFG_NPC))
                                    {
                                       _loc10_ = new NewArmyParam();
                                       _loc10_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                       _loc10_.heroId = _loc4_.id;
                                       _loc10_.targetPoint = _loc8_;
                                       _loc10_.troops = _loc5_;
                                       _loc10_.resource = new ResourceBean();
                                       _loc12_ = this.getTravelTimeReliefStationAdj(_loc10_) / Utils.getHeroSpeedFactor(_loc4_);
                                       if(!this.isWarTownOn(2 * _loc12_))
                                       {
                                          if(this.isEnoughResourcesToMarch(_loc10_))
                                          {
                                             if(playerArmyTimingAllowed("attack" + _loc8_,_loc12_,8 * 3600,true))
                                             {
                                                if(playerTimingAllowed("qLoc" + _loc8_,30))
                                                {
                                                   playerTimingAllowed("qHero" + _loc4_.id,0);
                                                   for each(_loc9_ in troopTypes)
                                                   {
                                                      _loc3_[troopIntNames[_loc9_]] -= _loc5_[troopIntNames[_loc9_]];
                                                   }
                                                   _loc11_.push(_loc10_);
                                                   break;
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                           _loc7_++;
                        }
                     }
                  }
               }
            }
         }
         return _loc11_;
      }
      
      private function _wi254() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyBean = null;
         _loc1_ = 0;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.startFieldId == this.castle.fieldId)
            {
               if(_loc2_.missionType == ObjConstants.ARMY_MISSION_TRANS)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function _updateFriendArmies(param1:Array) : void
      {
         this.friendlyArmies = param1;
      }
      
      private function futureBuildingCondition() : CityCondition
      {
         var _loc1_:BuildingBean = null;
         var _loc2_:CityCondition = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:CityCondition = null;
         var _loc6_:ConditionBean = null;
         var _loc7_:Number = NaN;
         _loc1_ = this._getCurrentConstruction();
         if(_loc1_ != null && _loc1_.endTime - Utils.getServerTime() > 3 * 3600 * 1000)
         {
            return null;
         }
         _loc2_ = null;
         _loc3_ = 100000000;
         _loc4_ = this.currRequirements.length - 1;
         _loc5_ = null;
         _loc6_ = null;
         _loc7_ = 0;
         while(_loc4_ >= 0)
         {
            _loc5_ = this.currRequirements[_loc4_];
            if(_loc5_.isBuilding)
            {
               if(!this._mi60(_loc5_))
               {
                  if(_loc1_ != null && _loc1_.level + 1 == _loc5_.level && _loc1_.typeId == _loc5_.typeId)
                  {
                     if(this.getBuildingsCountByTypeAndLvl(_loc5_.typeId,_loc5_.level) + 1 < _loc5_.count)
                     {
                        if(this._mo519(_loc5_))
                        {
                           this.currRequirements.removeItemAt(_loc4_);
                        }
                        else if(this._it985(_loc5_))
                        {
                           _loc6_ = this.getConditionBeanForUpgradingTo(_loc5_);
                           if(_loc6_ != null)
                           {
                              _loc7_ = Math.max(_loc6_.food,_loc6_.gold,_loc6_.wood,_loc6_.stone,_loc6_.iron);
                              if(_loc7_ < _loc3_)
                              {
                                 _loc3_ = _loc7_;
                                 _loc2_ = _loc5_;
                              }
                           }
                        }
                     }
                  }
                  else if(this._mo519(_loc5_))
                  {
                     this.currRequirements.removeItemAt(_loc4_);
                  }
                  else if(this._it985(_loc5_))
                  {
                     _loc6_ = this.getConditionBeanForUpgradingTo(_loc5_);
                     if(_loc6_ != null)
                     {
                        _loc7_ = Math.max(_loc6_.food,_loc6_.gold,_loc6_.wood,_loc6_.stone,_loc6_.iron);
                        if(_loc7_ < _loc3_)
                        {
                           _loc3_ = _loc7_;
                           _loc2_ = _loc5_;
                        }
                     }
                  }
               }
            }
            _loc4_--;
         }
         return _loc2_;
      }
      
      private function doSearchForUnoccupiedLocalFields() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MapCastleBean = null;
         var _loc3_:int = 0;
         if(this.getCfg(CityConfigs.CFG_HUNTING) <= 0 && this.getCfg(CityConfigs.CFG_SLOWHUNTING) <= 0)
         {
            return;
         }
         if(this.candidateLocalFields == null || this.candidateLocalFields.length == 0)
         {
            return;
         }
         _loc1_ = this.getCfg(CityConfigs.CFG_SLOWHUNTING) > 0 ? 20 : 10;
         if(this.localFieldsDetailInfo != null && this.localFieldsDetailInfo.length > _loc1_)
         {
            return;
         }
         if(this.cityTimingAllowed("searchresourcefield",600))
         {
            this.logMsg("Searching for unoccupied valleys for hunting...",COLR_STD_LOG_MSG);
         }
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < this.candidateLocalFields.length)
         {
            _loc2_ = Map.getDetail(this.candidateLocalFields[_loc3_]);
            if(_loc2_ == null)
            {
               return;
            }
            if(_loc2_.userName == null || _loc2_.userName == this.player.playerInfo.userName && this.getCfg(CityConfigs.CFG_HUNTING) > 0)
            {
               this.localFieldsDetailInfo.addItem(_loc2_);
            }
            this.candidateLocalFields.splice(_loc3_,1);
            _loc3_--;
            if(this.localFieldsDetailInfo.length >= _loc1_)
            {
               return;
            }
            _loc3_++;
         }
      }
      
      private function doHeroManagement() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:Object = null;
         var _loc8_:HeroBean = null;
         var _loc9_:ItemBean = null;
         _loc1_ = false;
         _loc2_ = false;
         _loc3_ = false;
         _loc4_ = null;
         _loc5_ = null;
         var _loc6_:HeroBean = this.getWorstRegularHero();
         _loc7_ = null;
         for each(_loc8_ in this.heroes)
         {
            if(!(_loc8_.status != HeroConstants.HERO_FREE_STATU && _loc8_.status != HeroConstants.HERO_CHIEF_STATU))
            {
               if(!Utils.isHeroRoyal(_loc8_) && _loc8_.loyalty < 100)
               {
                  if(this.getCfg(CityConfigs.CFG_AUTOMEDAL) <= 0)
                  {
                     if(this.estResource.gold >= _loc8_.level * 1000)
                     {
                        if(this.cityTimingAllowed("reward" + _loc8_.id,900))
                        {
                           this.logMsg("HERO > reward hero using " + _loc8_.level * 100 + " gold: " + Utils.heroBeanToString(_loc8_),COLR_STD_LOG_MSG);
                           CityStateCommands.awardGold(this.castleId,_loc8_.id);
                           this.estResource.gold -= _loc8_.level * 100;
                           _loc1_ = true;
                        }
                     }
                     else if(this.cityTimingAllowed("rewardGoldError" + _loc8_.id,300))
                     {
                        this.logMsg("HERO WARNING > not enough gold, unable to reward hero using " + _loc8_.level * 100 + " gold: " + Utils.heroBeanToString(_loc8_),COLR_WRN_LOG_MSG);
                     }
                  }
                  else
                  {
                     if(_loc7_ == null)
                     {
                        _loc7_ = new Object();
                        for each(_loc9_ in this.player.itemsArray)
                        {
                           if(_loc9_.id != null && _loc9_.id.indexOf("hero.loyalty.") == 0)
                           {
                              _loc7_[_loc9_.id] = _loc9_.count;
                           }
                        }
                     }
                     if(_loc8_.loyalty <= 40 && _loc7_["hero.loyalty.9"] > 0)
                     {
                        _loc5_ = "hero.loyalty.9";
                     }
                     else if(_loc8_.loyalty <= 50 && _loc7_["hero.loyalty.8"] > 0)
                     {
                        _loc5_ = "hero.loyalty.8";
                     }
                     else if(_loc8_.loyalty <= 60 && _loc7_["hero.loyalty.7"] > 0)
                     {
                        _loc5_ = "hero.loyalty.7";
                     }
                     else if(_loc8_.loyalty <= 70 && _loc7_["hero.loyalty.6"] > 0)
                     {
                        _loc5_ = "hero.loyalty.6";
                     }
                     else if(_loc8_.loyalty <= 75 && _loc7_["hero.loyalty.5"] > 0)
                     {
                        _loc5_ = "hero.loyalty.5";
                     }
                     else if(_loc8_.loyalty <= 80 && _loc7_["hero.loyalty.4"] > 0)
                     {
                        _loc5_ = "hero.loyalty.4";
                     }
                     else if(_loc8_.loyalty <= 85 && _loc7_["hero.loyalty.3"] > 0)
                     {
                        _loc5_ = "hero.loyalty.3";
                     }
                     else if(_loc8_.loyalty <= 90 && _loc7_["hero.loyalty.2"] > 0)
                     {
                        _loc5_ = "hero.loyalty.2";
                     }
                     else if(_loc8_.loyalty <= 95 && _loc7_["hero.loyalty.1"] > 0)
                     {
                        _loc5_ = "hero.loyalty.1";
                     }
                     else
                     {
                        _loc5_ = null;
                     }
                     if(_loc5_ != null)
                     {
                        if(this.cityTimingAllowed("reward" + _loc8_.id,900))
                        {
                           --_loc7_[_loc5_];
                           this.logMsg("AUTOMEDAL > reward hero using " + Items.getItemName(_loc5_) + ": " + Utils.heroBeanToString(_loc8_),COLR_STD_LOG_MSG);
                           ActionFactory.getInstance().getHeroCommand().useItem(this.castleId,_loc8_.id,_loc5_);
                           _loc1_ = true;
                        }
                     }
                     else if(this.estResource.gold >= _loc8_.level * 1000)
                     {
                        if(this.cityTimingAllowed("reward" + _loc8_.id,900))
                        {
                           this.logMsg("AUTOMEDAL > missing appropriate medals, reward hero using " + _loc8_.level * 100 + " gold: " + Utils.heroBeanToString(_loc8_),COLR_STD_LOG_MSG);
                           CityStateCommands.awardGold(this.castleId,_loc8_.id);
                           this.estResource.gold -= _loc8_.level * 100;
                           _loc1_ = true;
                        }
                     }
                     else if(this.cityTimingAllowed("rewardMedalError" + _loc8_.id,300))
                     {
                        this.logMsg("HERO WARNING > not enough medals or gold, unable to reward hero: " + Utils.heroBeanToString(_loc8_),COLR_WRN_LOG_MSG);
                     }
                  }
               }
               if(this.noUplevelHeroes != null)
               {
                  if(this.noUplevelHeroes[0] == "any")
                  {
                     continue;
                  }
                  _loc3_ = false;
                  for each(_loc4_ in this.getAvailableHeroNamesFromHeroListStr(this.noUplevelHeroes))
                  {
                     if(_loc8_.name.toLowerCase() == _loc4_.toLowerCase())
                     {
                        _loc3_ = true;
                        break;
                     }
                  }
                  if(_loc3_)
                  {
                     continue;
                  }
               }
               while(_loc8_.experience >= 150 * _loc8_.level * _loc8_.level && !Utils.isHeroMaxLvl(_loc8_) && !(_loc8_.isHero == 4 && _loc8_.level >= 99 && _loc8_.level + Utils.getUnappliedLevels(_loc8_) < 120))
               {
                  _loc8_.experience -= 150 * _loc8_.level * _loc8_.level;
                  ++_loc8_.level;
                  this.logMsg("uplevel hero: " + Utils.heroBeanToString(_loc8_),COLR_STD_LOG_MSG);
                  CityStateCommands.levelUp(this.castleId,_loc8_.id);
                  _loc1_ = true;
               }
               if(_loc1_)
               {
                  return _loc1_;
               }
            }
         }
         _loc1_ = false;
         for each(_loc8_ in this.heroes)
         {
            if(!(_loc8_.status != CityStateConstants.HERO_STATUS_IDLE && _loc8_.status != CityStateConstants.HERO_STATUS_MAYOR))
            {
               _loc2_ = _loc8_.attack + _loc8_.intelligence + _loc8_.politics == 0 && _loc8_.level >= 10 && this.isGearAvailable() && playerTimingAllowed("herospecialty" + _loc8_.id,10 * 3600);
               if(_loc2_ || _loc8_.remainPoint > 0)
               {
                  if(_loc8_.management >= _loc8_.power && _loc8_.management >= _loc8_.stratagem)
                  {
                     this.logMsg("assign point for politics hero: " + Utils.heroBeanToString(_loc8_),"#7A1595");
                     if(_loc8_.remainPoint > 0)
                     {
                        CityStateCommands.addPoint2(this.castleId,_loc8_.id,_loc8_.remainPoint,0,0,this._yq761);
                     }
                     _loc8_.management += _loc8_.remainPoint;
                     _loc8_.remainPoint = 0;
                     if(_loc2_)
                     {
                        ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc8_.id,1,this.handleCommandResponse);
                     }
                     _loc1_ = true;
                  }
                  else if(_loc8_.stratagem >= _loc8_.power && _loc8_.stratagem >= _loc8_.management)
                  {
                     this.logMsg("assign point for intel hero: " + Utils.heroBeanToString(_loc8_),"#7A1595");
                     if(_loc8_.remainPoint > 0)
                     {
                        CityStateCommands.addPoint2(this.castleId,_loc8_.id,0,0,_loc8_.remainPoint,this._yq761);
                     }
                     _loc8_.stratagem += _loc8_.remainPoint;
                     _loc8_.remainPoint = 0;
                     if(_loc2_)
                     {
                        ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc8_.id,3,this.handleCommandResponse);
                     }
                     _loc1_ = true;
                  }
                  else
                  {
                     this.logMsg("assign point for attack hero: " + Utils.heroBeanToString(_loc8_),"#7A1595");
                     if(_loc8_.remainPoint > 0)
                     {
                        CityStateCommands.addPoint2(this.castleId,_loc8_.id,0,_loc8_.remainPoint,0,this._yq761);
                     }
                     _loc8_.power += _loc8_.remainPoint;
                     _loc8_.remainPoint = 0;
                     if(_loc2_)
                     {
                        ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc8_.id,2,this.handleCommandResponse);
                     }
                     _loc1_ = true;
                  }
               }
               if(_loc1_)
               {
                  return _loc1_;
               }
            }
         }
         return _loc1_;
      }
      
      public function _clearWallQueueByType(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AllProduceBean = null;
         for each(_loc3_ in this.fortificationProduceQueue)
         {
            _loc2_ = _loc3_.allProduceQueueArray.length - 1;
            while(_loc2_ >= 0)
            {
               if(_loc3_.getAllProduceQueue(_loc2_).type == param1)
               {
                  CityStateCommands.cancelFortificationProduce(this.castleId,_loc3_.getAllProduceQueue(_loc2_).queueId);
               }
               _loc2_--;
            }
         }
         Utils.callLater(5000,this.updateWallQueue);
      }
      
      private function getListOfHhNamesInTown() : String
      {
         var _loc2_:HeroBean = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.heroes)
         {
            if(_loc2_.isHero == 1)
            {
               _loc1_ += (_loc1_ != "" ? ";" : "") + _loc2_.name;
            }
         }
         return _loc1_;
      }
      
      private function taskSearchResourceFields() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(this.distanceSettings[DISTANCE_VALLEY] <= 0)
         {
            this.distanceSettings[DISTANCE_VALLEY] = 15;
         }
         _loc1_ = int(this.distanceSettings[DISTANCE_VALLEY]);
         _loc2_ = Map.getX(this.castle.fieldId);
         _loc3_ = Map.getY(this.castle.fieldId);
         if(this.getCfg(CityConfigs.CFG_VALLEY) <= 0)
         {
            return;
         }
         if(!Map.isMapReady(_loc2_,_loc3_,_loc1_))
         {
            return;
         }
         _loc4_ = playerTimingAllowed("rescanresourcefields",3600);
         if(!_loc4_ && this.candidateResourceFields != null)
         {
            if(this.lastSearchResourceLevel == this.getCfg(CityConfigs.CFG_VALLEY))
            {
               return;
            }
         }
         this.lastSearchResourceLevel = this.getCfg(CityConfigs.CFG_VALLEY);
         _loc5_ = this.getCfg(CityConfigs.CFG_VALLEY);
         _loc6_ = new Array();
         _loc7_ = _loc2_ - _loc1_;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = 0;
         _loc11_ = 0;
         while(_loc7_ <= _loc2_ + _loc1_)
         {
            _loc8_ = _loc3_ - _loc1_;
            while(_loc8_ <= _loc3_ + _loc1_)
            {
               if((_loc7_ - _loc2_) * (_loc7_ - _loc2_) + (_loc8_ - _loc3_) * (_loc8_ - _loc3_) <= _loc1_ * _loc1_)
               {
                  _loc9_ = Map.getFieldId(_loc7_,_loc8_);
                  _loc10_ = Map.getType(_loc9_);
                  _loc11_ = Map.getLevel(_loc9_);
                  if(this.fields.length < this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL) && this._bv514(_loc10_) && _loc11_ == _loc5_)
                  {
                     if(Version.isTraceOn())
                     {
                        trace("Resource field: " + Map.fieldIdToString(_loc9_));
                     }
                     _loc6_.push(_loc9_);
                  }
               }
               _loc8_++;
            }
            _loc7_++;
         }
         _loc6_.sort(this._lf742);
         this.resourceFieldsDetailInfo.removeAll();
         this.candidateResourceFields = _loc6_;
      }
      
      private function _rd325() : HeroBean
      {
         return this._pe930("power");
      }
      
      public function getTransingTrades() : ArrayCollection
      {
         return this.transingTradesArray;
      }
      
      public function _cleanup() : void
      {
         this.castle_captured = true;
         if(this.timeSlot != -1)
         {
            MasterTimer.getInstance().deleteSlot(this.timeSlot);
            this.timeSlot = -1;
         }
         var _loc1_:ResponseDispatcher = ResponseDispatcher.getInstance();
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE,this.handleReloginResponse);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_INJURED_TROOP_UPDATE,this.injuredTroopHandle);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE,this.researchComplete);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE,this.buildComplete);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE,this.handleFortificationUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE,this.onCastleUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_TRADES_UPDATE,this.onTradesUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_TRANSING_TRADE_UPDATE,this.updateTransingTrades);
         _loc1_.removeEventListener(ResponseDispatcher.REPORT_RECEIVE_REPORT_LIST,this.handleReceiveReportList);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_CASTLE_BUFF_UPDATE,this.handleBuffUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.REPORT_MARK_AS_READ,this.reportHandler);
         _loc1_.removeEventListener(ResponseDispatcher.QUEST_GET_QUEST_TYPE,this.handleGetQuestType);
         _loc1_.removeEventListener(ResponseDispatcher.QUEST_GET_QUEST_LIST,this.handleGetQuestList);
         _loc1_.removeEventListener(ResponseDispatcher.QUEST_AWARD,this.handleQuestAward);
      }
      
      private function _tc1081(param1:Boolean, param2:Boolean) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:HeroBean = null;
         var _loc6_:MapCastleBean = null;
         var _loc7_:int = 0;
         var _loc8_:TroopBean = null;
         var _loc9_:NewArmyParam = null;
         var _loc10_:Number = NaN;
         this._ys266();
         this._xa758();
         if(this.localFieldsDetailInfo.length == 0)
         {
            if(this.candidateLocalFields != null && this.candidateLocalFields.length == 0 && this.distanceSettings[DISTANCE_HUNTING] < 30)
            {
               if(this.distanceSettings[DISTANCE_HUNTING] < 4)
               {
                  this.distanceSettings[DISTANCE_HUNTING] = 4;
               }
               this.distanceSettings[DISTANCE_HUNTING] = int(this.distanceSettings[DISTANCE_HUNTING] * 1.3);
               this.candidateLocalFields = null;
            }
            return false;
         }
         _loc3_ = this.huntingLocation == -1 ? int(this.localFieldsDetailInfo[0].id) : this.huntingLocation;
         if(this.rallyHuntingSetting != -1 && this._lb710(_loc3_) >= this.rallyHuntingSetting)
         {
            return false;
         }
         _loc4_ = Map.getLevel(_loc3_);
         if(_loc4_ == -1)
         {
            return false;
         }
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            if(this._va266(_loc3_,estimateMaintenanceDownTime - 10 * 1000))
            {
               this.logMsg("HUNTING > Hunting troops arriving during maintenance has been recalled",COLR_STD_LOG_MSG);
            }
            return true;
         }
         this.lastFastTargetLevel = _loc4_;
         this.lastFastTargetField = _loc3_;
         if(!param1 || !param2)
         {
            return false;
         }
         if(this.enemyArmies.length > 0 && this.enemyArmies[0].reachTime - Utils.getServerTime() < 7200 * 1000)
         {
            return false;
         }
         _loc5_ = this.getNextValleyHero();
         if(_loc5_ == null)
         {
            return false;
         }
         _loc6_ = Map.getDetail(_loc3_);
         if(_loc6_ == null)
         {
            return false;
         }
         if(_loc6_.userName == this.player.playerInfo.userName)
         {
            this.logMsg("HUNTING > Abandon field: " + Map.fieldIdToString(_loc3_),COLR_STD_LOG_MSG);
            CityStateCommands.giveUpField(_loc3_);
            Map.updateDetailInfo(_loc3_);
            return false;
         }
         if(!_loc6_.canOccupy || _loc6_.state != 1 && _loc6_.state != 4 || _loc6_.userName != null)
         {
            this.logMsg("HUNTING > CANNOT ATTACK " + Map.fieldIdToString(_loc3_),COLR_STD_LOG_MSG);
            if(_loc3_ == this.localFieldsDetailInfo[0])
            {
               this.localFieldsDetailInfo.removeItemAt(0);
            }
            return false;
         }
         _loc7_ = Map.getType(_loc3_);
         if(_loc7_ == -1)
         {
            return false;
         }
         if(_loc7_ == FieldConstants.TYPE_NPC || _loc7_ == FieldConstants.TYPE_CASTLE)
         {
            this.logMsg("HUNTING > Local field is now a npc or castle: " + Map.fieldIdToString(_loc3_),COLR_STD_LOG_MSG);
            if(_loc3_ == this.localFieldsDetailInfo[0])
            {
               this.localFieldsDetailInfo.removeItemAt(0);
            }
            return false;
         }
         _loc8_ = this.getTroopsToAttackValley(_loc4_);
         if(_loc8_ == null)
         {
            if(this._lb710(_loc3_) == 0 && this.cityTimingAllowed("hunting",600))
            {
               this.logMsg("HUNTING > NOT ENOUGH TROOP TO ATTACK LOCAL FIELD " + Map.fieldIdToString(_loc3_),COLR_STD_LOG_MSG);
            }
            return false;
         }
         _loc9_ = new NewArmyParam();
         _loc9_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc9_.heroId = _loc5_.id;
         _loc9_.targetPoint = _loc3_;
         _loc9_.troops = _loc8_;
         _loc9_.resource = new ResourceBean();
         _loc10_ = this.getTravelTimeReliefStationAdj(_loc9_) / Utils.getHeroSpeedFactor(_loc5_);
         if(!this.isEnoughResourcesToMarch(_loc9_))
         {
            return false;
         }
         if(this.isWarTownOn(2 * _loc10_))
         {
            return false;
         }
         if(!playerArmyTimingAllowed("attack" + _loc3_,_loc10_,8))
         {
            return false;
         }
         this.logMsg("HUNTING > attack local field " + Map.fieldIdToString(_loc3_) + " with hero " + Utils.heroBeanToString(_loc5_) + " and " + Utils.troopBeanToString(_loc8_) + " " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc9_) / Utils.getHeroSpeedFactor(_loc5_)),COLR_STD_LOG_MSG);
         CityStateCommands.newArmy(this.castle.id,_loc9_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc9_);
         Map.updateDetailInfo(_loc3_);
         Map.updateInfo(_loc3_);
         return true;
      }
      
      private function doGateDefense() : void
      {
         var conn:Connection = null;
         var friendlyTroop:TroopBean = null;
         var GATETIME:int = 0;
         var setting:int = 0;
         var enemyArmyBean:ArmyBean = null;
         var tr:TroopBean = null;
         var defendCount:int = 0;
         var enemyCount:int = 0;
         var evaded:Boolean = false;
         var sb:int = 0;
         var at:int = 0;
         var window:int = 0;
         var allEnemyCount:int = 0;
         try
         {
            if(this.getCfg(CityConfigs.CFG_GATE) <= 0)
            {
               return;
            }
            conn = Connection.getInstance();
            if(!conn.authenticated)
            {
               return;
            }
            this.setCondGateRules();
            friendlyTroop = this.getTotalTroopsInEmbassyArmies();
            GATETIME = 60 * this.getCfg(CityConfigs.CFG_GATE);
            if(this.enemyArmies.length == 0 || this.enemyArmies[0].reachTime == 0 || this.enemyArmies[0].reachTime > 0 && this.enemyArmies[0].reachTime - Utils.getServerTime() > GATETIME * 1000)
            {
               setting = int(this.gateSettings[GATE_PEACE]);
               if(conn.paused)
               {
                  setting = int(this.gateSettings[GATE_PAUSED]);
                  if(setting != GATE_AUTO)
                  {
                     if(setting == GATE_GTALX)
                     {
                        if(this.colonies.length > 0 && (this.colonies[0] as ColonyBean).relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED && (this.colonies[0] as ColonyBean).status == 1)
                        {
                           setting = GATE_OPEN;
                        }
                        else
                        {
                           setting = GATE_CLOSE;
                        }
                     }
                  }
                  else if(this.enemyArmies.length > 0)
                  {
                     setting = int(this.gateSettings[GATE_MIXED]);
                     if(setting == GATE_AUTO)
                     {
                        if(this.troop.archer + friendlyTroop.archer < 250000 || this.fortification.arrowTower == 0)
                        {
                           setting = GATE_CLOSE;
                        }
                        else
                        {
                           setting = GATE_OPEN;
                        }
                     }
                  }
                  else
                  {
                     setting = int(this.gateSettings[GATE_PEACE]);
                  }
               }
               if(setting == GATE_CLOSE || setting == GATE_SNEAKY)
               {
                  this._nv1116(false,"Close gate according to gate policy");
               }
               else if(setting == GATE_OPEN)
               {
                  this._nv1116(true,"Open gate according to gate policy");
               }
               else if(this.troop.scouter + friendlyTroop.scouter < 100000)
               {
                  this._nv1116(false,"Auto close gate to protect scouts");
               }
               else
               {
                  this._nv1116(true,"Auto open gate to prevent scouting");
               }
               return;
            }
            if(this.enemyArmies.length > 0 && this.enemyArmies[0].reachTime > 0 && this.enemyArmies[0].reachTime - Utils.getServerTime() < GATETIME * 1000)
            {
               if(this.getCfg(CityConfigs.CFG_NOHEALING) <= 0)
               {
                  this.doHealInjuredTroop(true);
               }
               enemyArmyBean = this.enemyArmies[0];
               if(enemyArmyBean.missionType == ObjConstants.ARMY_MISSION_SUPPRESS)
               {
                  return;
               }
               tr = enemyArmyBean.troop == null ? null : Utils.getTroopBeanFromTroopStrBean(enemyArmyBean.troop);
               if(tr == null)
               {
                  return;
               }
               defendCount = this.troop.archer + friendlyTroop.archer;
               enemyCount = Utils.getTotalTroopCount(tr) + 3 * tr.ballista + tr.batteringRam + 4 * tr.catapult;
               evaded = false;
               sb = this._xy1114(this.enemyArmies[0].reachTime + 2000);
               at = this._uk165(this.enemyArmies[0].reachTime + 2000);
               window = Connection.getInstance().paused ? 15 : 3;
               allEnemyCount = this._uh177(this.enemyArmies[0].reachTime + window * 60 * 1000);
               if(this.gateSettings[GATE_ATTACK] != GATE_CLOSE || this.gateSettings[GATE_MIXED] != GATE_CLOSE)
               {
                  if(defendCount < enemyCount || defendCount < allEnemyCount || allEnemyCount >= 270000)
                  {
                     evaded = this._handleEvasion();
                  }
               }
               if(sb > 0 && at > 0)
               {
                  if(this.gateSettings[GATE_MIXED] == GATE_CLOSE || this.gateSettings[GATE_MIXED] == GATE_SNEAKY)
                  {
                     this._nv1116(false,"mixed attacks, close gate according to gate policy");
                  }
                  else if(this.gateSettings[GATE_MIXED] == GATE_OPEN)
                  {
                     this._nv1116(true,"mixed attacks, open gate according to gate policy");
                     if(!evaded)
                     {
                        this._handleEvasion();
                     }
                  }
                  else if(this.troop.archer + friendlyTroop.archer < 250000)
                  {
                     this._nv1116(false,"mixed attacks, auto close gate");
                  }
                  else
                  {
                     this._nv1116(true,"mixed attack, auto open gate");
                     if(!evaded)
                     {
                        this._handleEvasion();
                     }
                  }
               }
               else if(sb > 0)
               {
                  if(this.gateSettings[GATE_SCOUTBOMB] == GATE_CLOSE)
                  {
                     this._nv1116(false,"scout bomb, close gate according to gate policy");
                  }
                  else if(this.gateSettings[GATE_SCOUTBOMB] == GATE_OPEN)
                  {
                     this._nv1116(true,"scout bomb, open gate according to gate policy");
                  }
                  else if(sb <= 3 && this.gateSettings[GATE_SCOUTBOMB] == GATE_SNEAKY)
                  {
                     if(this.troop.archer + friendlyTroop.archer < 200000 || enemyArmyBean.heroLevel > 57)
                     {
                        this._nv1116(false,"scout bomb, close gate");
                     }
                     else if(sb > 1 && this.troop.archer + friendlyTroop.archer < 200000 || this.enemyArmies[1].heroLevel > 57)
                     {
                        this._nv1116(false,"scout bomb, close gate");
                     }
                     else if(sb > 2 && this.troop.archer + friendlyTroop.archer < 200000 || this.enemyArmies[2].heroLevel > 57)
                     {
                        this._nv1116(false,"scout bomb, close gate");
                     }
                     else
                     {
                        this._nv1116(true,"scout bomb with crappy hero, open gate");
                     }
                  }
                  else
                  {
                     this._nv1116(false,"scout bomb, auto close gate");
                  }
               }
               else if(at)
               {
                  if(this.gateSettings[GATE_ATTACK] == GATE_CLOSE)
                  {
                     this._nv1116(false,"regular attack, close gate according to gate policy");
                  }
                  else if(this.gateSettings[GATE_ATTACK] == GATE_OPEN)
                  {
                     if(!evaded)
                     {
                        this._handleEvasion();
                     }
                     this._nv1116(true,"regular attack, open gate according to gate policy");
                  }
                  else if(this.gateSettings[GATE_ATTACK] == GATE_SNEAKY)
                  {
                     if(this._ay1045())
                     {
                        if(!evaded && !this._handleEvasion())
                        {
                           this._nv1116(false,"regular attack, unable to evade rainbow for sneak defense");
                        }
                        else
                        {
                           this._nv1116(true,"regular attack, auto open gate to fight");
                        }
                     }
                     else
                     {
                        this._nv1116(false,"regular attack, sneak " + this._je83() + ", auto close gate to preserve troops");
                     }
                  }
                  else if(enemyCount > 0 && this.troop.archer + friendlyTroop.archer + 2.5 * this.fortification.arrowTower > 1.2 * enemyCount)
                  {
                     if(!evaded)
                     {
                        this._handleEvasion();
                     }
                     this._nv1116(true,"regular attack, auto open gate to fight");
                  }
                  else
                  {
                     this._nv1116(false,"regular attack, auto close gate to preserve troops");
                  }
               }
               if(this._rt822(this.enemyArmies[0].reachTime + 120000) && this.estResource.gold > 1000000)
               {
                  this.processMarketHiding(this.estResource.gold - 10000);
               }
               else if(!this.goOutForBattle && this.estResource.food < 1000000 && this.estResource.gold > 1000000)
               {
                  this.processMarketHiding(this.estResource.gold - 1000);
               }
               return;
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: handleGateControl, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      public function _cfg_npc10Heroes(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.npc10Heroes = _loc2_;
      }
      
      private function _qk175() : Boolean
      {
         var _loc2_:ArmyBean = null;
         var _loc3_:Array = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.selfArmies)
         {
            if(this.lastPriorityNPCTargets[_loc2_.targetFieldId] != undefined && _loc2_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc2_.direction == ArmyConstants.ARMY_FORWARD)
            {
               _loc1_ = Map.getType(_loc2_.targetFieldId,10 * 60);
               if(!(_loc1_ == -1 || _loc1_ == FieldConstants.TYPE_NPC))
               {
                  this.logMsg("Target priority farming is no longer a npc, recall troop " + _loc2_.armyId + " toward " + Map.fieldIdToString(_loc2_.targetFieldId),COLR_STD_LOG_MSG);
                  CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
               }
            }
         }
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            if(this.getCfg(CityConfigs.CFG_SAFEMAINT) > 0)
            {
               if(this.recallArmiesToNpc(estimateMaintenanceDownTime - 10 * 1000))
               {
                  this.logMsg("Troops to NPC arriving during maintenance have been recalled","#79796A");
               }
            }
            return true;
         }
         for each(_loc3_ in this.priorityNpcSettings)
         {
            if(this._gt1139(_loc3_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getBuildingLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:BuildingBean = null;
         _loc2_ = 0;
         for each(_loc3_ in this.buildings)
         {
            if(_loc3_.typeId == param1)
            {
               _loc2_ = Math.max(_loc2_,_loc3_.level);
            }
         }
         return _loc2_;
      }
      
      public function updateGears() : void
      {
         if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_WORKSHOP,1) > 0)
         {
            ActionFactory.getInstance().getEquipmenttechCommands().getResearchList(this.castleId,this.handleUpdateGearsResponse);
         }
      }
      
      private function sortByLevelAndDistance(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc3_ = Map.getLevel(param1);
         _loc4_ = Map.getLevel(param2);
         if(_loc3_ == -1 || _loc4_ == -1)
         {
            return -1;
         }
         _loc5_ = Map.fieldDistance(param1,this.castle.fieldId) / POW2[_loc3_];
         _loc6_ = Map.fieldDistance(param2,this.castle.fieldId) / POW2[_loc4_];
         if(_loc5_ < _loc6_)
         {
            return -1;
         }
         if(_loc5_ > _loc6_)
         {
            return 1;
         }
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public function _jg731(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         if(this.npcList == null)
         {
            this.npcList = new Array();
         }
         _loc2_ = true;
         _loc3_ = false;
         _loc4_ = 0;
         for each(_loc5_ in param1.toLowerCase().split(" "))
         {
            _loc4_ = Map.coordStringToFieldId(_loc5_);
            if(_loc4_ == -1)
            {
               this.logMsg("Invalid location " + _loc5_);
               _loc2_ = false;
            }
            else if(this.npcList.indexOf(_loc4_) != -1)
            {
               this.logMsg("Repetitive location " + _loc5_);
               _loc2_ = false;
            }
            else
            {
               this.npcList.push(_loc4_);
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            this.logMsg("No npc added from " + param1);
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function CMCalculateHeroPath(param1:Boolean = true) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:CityState = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         if(this.trainingHeroName == null)
         {
            return;
         }
         _loc2_ = new Array();
         _loc3_ = new Array();
         _loc4_ = new Array();
         _loc5_ = null;
         for each(_loc5_ in MainScreen.getCities())
         {
            if(_loc5_.cityManager.trainingHeroName != null)
            {
               if(_loc5_.cityManager.trainingHeroName.toLowerCase() == this.trainingHeroName.toLowerCase())
               {
                  _loc2_.push(_loc5_.cityManager.castle.fieldId);
               }
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc3_[_loc6_] = (_loc6_ + 1) % _loc2_.length;
            _loc4_[_loc6_] = (_loc6_ - 1 + _loc2_.length) % _loc2_.length;
            _loc6_++;
         }
         if(_loc2_.length >= 4)
         {
            _loc8_ = false;
            _loc9_ = 0;
            _loc10_ = 0;
            _loc11_ = 0;
            _loc12_ = 0;
            while(_loc9_ < 100 && !_loc8_)
            {
               _loc8_ = true;
               _loc10_ = 0;
               while(_loc10_ < _loc2_.length)
               {
                  _loc11_ = _loc10_ + 1;
                  while(_loc11_ < _loc2_.length)
                  {
                     if(!(_loc11_ == _loc3_[_loc10_] || _loc11_ == _loc4_[_loc10_]))
                     {
                        if(Map.fieldDistance(_loc2_[_loc10_],_loc2_[_loc3_[_loc10_]]) + Map.fieldDistance(_loc2_[_loc11_],_loc2_[_loc3_[_loc11_]]) > 0.01 + Map.fieldDistance(_loc2_[_loc10_],_loc2_[_loc11_]) + Map.fieldDistance(_loc2_[_loc3_[_loc10_]],_loc2_[_loc3_[_loc11_]]))
                        {
                           _loc8_ = false;
                           _loc12_ = int(_loc3_[_loc11_]);
                           _loc6_ = int(_loc3_[_loc10_]);
                           while(_loc6_ != _loc11_)
                           {
                              _loc4_[_loc6_] = _loc3_[_loc6_];
                              _loc6_ = int(_loc3_[_loc6_]);
                           }
                           _loc6_ = int(_loc3_[_loc10_]);
                           while(_loc6_ != _loc11_)
                           {
                              _loc3_[_loc4_[_loc6_]] = _loc6_;
                              _loc6_ = int(_loc4_[_loc6_]);
                           }
                           _loc4_[_loc12_] = _loc3_[_loc10_];
                           _loc3_[_loc3_[_loc10_]] = _loc12_;
                           _loc3_[_loc10_] = _loc11_;
                           _loc4_[_loc11_] = _loc10_;
                        }
                     }
                     _loc11_++;
                  }
                  _loc10_++;
               }
               _loc9_++;
            }
            _loc13_ = 0;
            while(_loc13_ < _loc2_.length)
            {
               if(_loc4_[_loc3_[_loc13_]] != _loc13_)
               {
                  this.logErrMsg("hero path computation error, bad pointers");
               }
               _loc13_++;
            }
            _loc14_ = false;
            _loc15_ = 0;
            _loc13_ = 0;
            while(_loc13_ < _loc2_.length - 1)
            {
               _loc15_ = int(_loc3_[_loc15_]);
               if(_loc15_ == 0)
               {
                  this.logErrMsg("hero path computation error, premature return");
                  _loc14_ = true;
               }
               _loc13_++;
            }
            if(_loc3_[_loc15_] != 0)
            {
               this.logErrMsg("hero path computation error, incomplete loop");
               _loc14_ = true;
            }
            if(_loc14_)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc2_.length)
               {
                  _loc3_[_loc6_] = (_loc6_ + 1) % _loc2_.length;
                  _loc4_[_loc6_] = (_loc6_ - 1 + _loc2_.length) % _loc2_.length;
                  _loc6_++;
               }
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc5_ = MainScreen.getCityFromFieldId(_loc2_[_loc6_]);
            _loc5_.cityManager.trainingHeroNextStop = _loc2_[_loc3_[_loc6_]];
            _loc6_++;
         }
         _loc7_ = this.trainingHeroNextStop;
         if(param1 && _loc7_ != -1 && _loc7_ != this.trainingHeroNextStop)
         {
            _loc5_ = MainScreen.getCityFromFieldId(_loc7_);
            if(_loc5_ != null)
            {
               _loc5_.cityManager.CMCalculateHeroPath(false);
            }
         }
      }
      
      public function updateResearch() : void
      {
         if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_ACADEMY,1) > 0)
         {
            CityStateCommands.getResearchList(this.castleId,this.researchListResponseHandler);
         }
      }
      
      public function _populate_H_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:int = 0;
         var _loc4_:DataRow = null;
         var _loc5_:Boolean = false;
         var _loc6_:ArmyBean = null;
         var _loc7_:int = 0;
         var _loc8_:HeroBean = null;
         _loc2_ = new ArrayCollection();
         _loc3_ = this.getCfg(CityConfigs.CFG_FASTHERO);
         _loc4_ = null;
         _loc5_ = false;
         _loc6_ = null;
         _loc7_ = 0;
         for each(_loc8_ in this.heroes)
         {
            _loc5_ = _loc8_.politics == _loc8_.intelligence && _loc8_.politics == _loc8_.attack;
            _loc4_ = new DataRow();
            _loc4_.col1 = _loc8_.name;
            _loc4_.col2 = this.heroStatusStrings[_loc8_.status];
            _loc4_.col8 = _loc8_.level;
            if(!_loc5_ && _loc8_.politics >= Math.max(_loc8_.intelligence,_loc8_.attack) || _loc5_ && _loc8_.management >= Math.max(_loc8_.stratagem,_loc8_.power))
            {
               _loc4_.col3 = "Pol " + Utils.roundToHundredths(Utils.getTotalPointsForHeroAttribute(_loc8_,"management"));
               _loc4_.col4 = _loc8_.management - (_loc8_.isHero != 4 ? _loc8_.level : _loc8_.level * 2) + _loc8_.remainPoint;
            }
            else if(!_loc5_ && _loc8_.intelligence >= Math.max(_loc8_.politics,_loc8_.attack) || _loc5_ && _loc8_.stratagem >= Math.max(_loc8_.management,_loc8_.power))
            {
               _loc4_.col3 = "Int " + Utils.roundToHundredths(Utils.getTotalPointsForHeroAttribute(_loc8_,"stratagem"));
               _loc4_.col4 = _loc8_.stratagem - (_loc8_.isHero != 4 ? _loc8_.level : _loc8_.level * 2) + _loc8_.remainPoint;
            }
            else
            {
               _loc4_.col3 = "Atk " + Utils.roundToHundredths(Utils.getTotalPointsForHeroAttribute(_loc8_,"power"));
               _loc4_.col4 = _loc8_.power - (_loc8_.isHero != 4 ? _loc8_.level : _loc8_.level * 2) + _loc8_.remainPoint;
            }
            _loc4_.col5 = _loc8_.stamina;
            if(_loc3_ > 0 && _loc3_ < 10)
            {
               _loc4_.col4 = "L" + _loc8_.level;
            }
            _loc4_.label = "Hero id: " + _loc8_.id + "\n" + _loc8_.name + " " + _loc8_.management + "/" + _loc8_.power + "/" + _loc8_.stratagem + "\ngear bonus: " + Math.round(_loc8_.politics * 100000) / 100000 + "/" + Math.round(_loc8_.attack * 100000) / 100000 + "/" + Math.round(_loc8_.intelligence * 100000) / 100000 + "\nleadership: " + _loc8_.leadership + "\nlevel: " + _loc8_.level + (_loc8_.remainPoint > 0 ? "-" + _loc8_.remainPoint : "") + "\nspeed: " + _loc8_.speed + "\nenergy: " + _loc8_.stamina + "\nloyalty " + _loc8_.loyalty + "\nexperience: " + Utils.formatNum(_loc8_.experience,0) + "/" + Utils.formatNum(_loc8_.upgradeExp,0);
            _loc7_ = Utils.getUnappliedLevels(_loc8_);
            if(_loc7_ > 0)
            {
               _loc4_.label = _loc4_.label + " (+L" + _loc7_ + ")";
            }
            if(_loc8_.itemId != null)
            {
               if(_loc8_.status != HeroConstants.HERO_SEIZED_STATU)
               {
                  _loc4_.label = _loc4_.label + "\nHero transfer needs: " + _loc8_.itemAmount + " " + Items.getItemName(_loc8_.itemId);
               }
               else
               {
                  _loc4_.label = _loc4_.label + "\nPersuade with: " + _loc8_.itemAmount + " " + Items.getItemName(_loc8_.itemId);
               }
            }
            _loc6_ = this.getHeroesArmy(_loc8_);
            if(_loc6_ != null)
            {
               _loc4_.label += "\n" + Utils.armyToString(_loc6_);
            }
            _loc4_.col6 = _loc8_.status == HeroConstants.HERO_GUARD_STATU || _loc8_.status == HeroConstants.HERO_SEND_STATU ? _loc8_.id : -1;
            _loc4_.col7 = _loc8_.id;
            _loc4_.col9 = _loc8_.status == HeroConstants.HERO_FREE_STATU && _loc8_.isHero == 0 ? _loc8_.id : -1;
            if(_loc8_.status == HeroConstants.HERO_CHIEF_STATU)
            {
               _loc4_.bgColor = 16773085;
            }
            else if(_loc8_.status == HeroConstants.HERO_GUARD_STATU)
            {
               _loc4_.bgColor = 16771755;
            }
            else if(_loc8_.status == HeroConstants.HERO_SEND_STATU)
            {
               _loc4_.bgColor = 16367037;
            }
            else if(_loc8_.status == HeroConstants.HERO_SEIZED_STATU)
            {
               _loc4_.bgColor = 16646095;
            }
            else if(_loc8_.status == HeroConstants.HERO_BACK_STATU)
            {
               _loc4_.bgColor = 13619199;
            }
            else if(_loc8_.status == HeroConstants.HERO_FREE_STATU)
            {
               _loc4_.bgColor = 16777215;
            }
            else if(_loc8_.status == HeroConstants.HERO_FLEE_STATU)
            {
               _loc4_.bgColor = 16777011;
            }
            else if(_loc8_.status == HeroConstants.HERO_FLEE_STATU_OTHER)
            {
               _loc4_.bgColor = 12434937;
            }
            else
            {
               _loc4_.bgColor = 12434937;
            }
            _loc2_.addItem(_loc4_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function postUpdate() : void
      {
         var _loc2_:ArmyBean = null;
         if(this.troopProductionUpdateNeeded)
         {
            this.updateTroopQueue();
            this.troopProductionUpdateNeeded = false;
         }
         if(this.fortificationProductionUpdateNeeded)
         {
            this.updateWallQueue();
            this.fortificationProductionUpdateNeeded = false;
         }
         if(this.researchUpdateNeeded || this.researches == null)
         {
            this.researchUpdateNeeded = false;
            this.updateResearch();
            this.updateGears();
         }
         if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_EMBASSY,1) > 0)
         {
            if(this.getCfg(CityConfigs.CFG_EMBOPEN) == 0 || this.getCfg(CityConfigs.CFG_EMBOPEN) > 1)
            {
               if(!this.castle.allowAlliance)
               {
                  this.castle.allowAlliance = true;
                  this.logMsg("Allow alliance troop","#2B602D");
                  CityStateCommands.setAllowAllianceArmy(this.castleId,true);
               }
            }
            else if(this.castle.allowAlliance)
            {
               this.castle.allowAlliance = false;
               this.logMsg("Deny alliance troop","#2B602D");
               CityStateCommands.setAllowAllianceArmy(this.castleId,false);
            }
            if(this.getCfg(CityConfigs.CFG_EMBOPEN) > 1)
            {
               if(this.friendlyArmies != null && this.friendlyArmies.length > 0)
               {
                  for each(_loc2_ in this.friendlyArmies)
                  {
                     if(_loc2_.targetFieldId == this.castle.fieldId && _loc2_.missionType == ObjConstants.ARMY_MISSION_SEND && _loc2_.direction == ArmyConstants.ARMY_STAY)
                     {
                        if(this.embAllowedPlayers.indexOf(_loc2_.king.toLowerCase()) == -1 || this.embDeniedPlayers.indexOf(_loc2_.king.toLowerCase()) > -1)
                        {
                           this.logMsg(_loc2_.king + " is not allowed in embassy, sending troops home","#2B602D");
                           ActionFactory.getInstance().getArmyCommands().callBackArmy(this.castleId,_loc2_.armyId);
                        }
                     }
                  }
               }
            }
         }
         var _loc1_:String = this.getCfg(CityConfigs.CFG_EXTRAFOOD) > 0 ? " Please consider removing config extrafood!" : "";
         if(this.resource.troopCostFood > 2000000 && this.resource.food.amount < 24 * (this.resource.troopCostFood - this.resource.food.increaseRate) * (1 + this.getCfg(CityConfigs.CFG_EXTRAFOOD)) && !(this.getCfg(CityConfigs.CFG_ZEROFOOD) > 0 && this.isZeroFoodActive))
         {
            if(this.cityTimingAllowed("foodwarning",1200))
            {
               this.logMsg("<i>FOOD IS LOW, UNDER " + (1 + this.getCfg(CityConfigs.CFG_EXTRAFOOD)) + " DAY LEFT, nonessential tasks are disabled automatically." + _loc1_ + "</i>",COLR_WRN_LOG_MSG);
            }
         }
         else if(this.resource.troopCostFood > 2000000 && this.resource.food.amount < 24 * (this.resource.troopCostFood - this.resource.food.increaseRate) * (2 + this.getCfg(CityConfigs.CFG_EXTRAFOOD)) && !(this.getCfg(CityConfigs.CFG_ZEROFOOD) > 0 && this.isZeroFoodActive))
         {
            if(this.cityTimingAllowed("foodwarning",1200))
            {
               this.logMsg("<i>FOOD IS LOW, UNDER " + (2 + this.getCfg(CityConfigs.CFG_EXTRAFOOD)) + " DAYS LEFT." + _loc1_ + "</i>",COLR_WRN_LOG_MSG);
            }
         }
         if(!this.trainingHeroNeeded && this.cityTimingAllowed("checkmayor",30))
         {
            if(this.promoteCount == 0)
            {
               if(this.getCfg(CityConfigs.CFG_NOMAYOR) < 1)
               {
                  this.promoteBestPolHero();
               }
               else if(this.getCfg(CityConfigs.CFG_NOMAYOR) == 1 || this.getCfg(CityConfigs.CFG_NOMAYOR) > 3)
               {
                  this.removeMayor();
               }
               else if(this.getCfg(CityConfigs.CFG_NOMAYOR) == 2)
               {
                  this.promoteBestAtkHero();
               }
               else if(this.getCfg(CityConfigs.CFG_NOMAYOR) == 3)
               {
                  this.promoteBestInteHero();
               }
            }
         }
      }
      
      private function getNextAvailablePositionForBuildingType(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         if(param1 == BuildingConstants.TYPE_WALL)
         {
            return BuildingConstants.POSITION_WALL;
         }
         if(param1 == BuildingConstants.TYPE_TOWN_HALL)
         {
            return BuildingConstants.POSITION_TOWN_HALL;
         }
         if(BuildingType.isExteriorBuilding(param1))
         {
            _loc3_ = Math.min(BuildingConstants.BUILDING_OUTSIDE_MAX,BuildingConstants.BUILDING_OUTSIDE_MIN + BuildingConstants.BUILDING_OUTSIDE_START_NUM - 1 + BuildingConstants.BUILDING_OUTSIDE_ADDITION * (this.getTownHallLevel() - 1));
            _loc2_ = BuildingConstants.BUILDING_OUTSIDE_MIN;
            while(_loc2_ <= _loc3_)
            {
               if(!this.isBuildingAtPosition(_loc2_))
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = BuildingConstants.BUILDING_INSIDE_MIN;
            while(_loc2_ <= BuildingConstants.BUILDING_INSIDE_MAX)
            {
               if(!this.isBuildingAtPosition(_loc2_))
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         return -1000;
      }
      
      public function get troopSpeedUp() : int
      {
         return SPEEDUP[this.getBuildingLevel(BuildingConstants.TYPE_TRANSPORT_STATION)];
      }
      
      public function _ox998() : ArrayCollection
      {
         return this.heroes;
      }
      
      public function _populate_X_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:TradeBean = null;
         var _loc5_:TransingTradeBean = null;
         if(this.getBuildingLevel(BuildingConstants.TYPE_MARKET) < 1)
         {
            param1.removeAll();
            return;
         }
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         for each(_loc4_ in this.tradesArray)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = _loc4_.tradeType == TradeConstants.TRADE_TYPE_SELL ? "Sell" : "Buy";
            _loc3_.col2 = resourceNames[_loc4_.resType];
            _loc3_.col3 = Utils.abbrNum(_loc4_.amount - _loc4_.dealedAmount) + "@" + _loc4_.price;
            _loc3_.col4 = "";
            _loc3_.label = "id: " + _loc4_.id;
            _loc2_.addItem(_loc3_);
         }
         for each(_loc5_ in this.transingTradesArray)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = "Shipped";
            _loc3_.col2 = resourceNames[_loc5_.resType];
            _loc3_.col3 = Utils.abbrNum(_loc5_.amount) + "@" + _loc5_.price;
            _loc3_.col4 = Utils.formatEndTime(_loc5_.endTime);
            _loc3_.label = "id: " + _loc5_.id;
            _loc2_.addItem(_loc3_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      public function _updateEnemyArmies(param1:ArrayCollection) : void
      {
         var _loc6_:ArmyBean = null;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         var _loc5_:Number = Utils.getServerTime() - 15 * 60 * 1000;
         for each(_loc6_ in param1)
         {
            if(!(_loc6_.missionType == ObjConstants.ARMY_MISSION_SEND || _loc6_.reachTime != 0 && _loc6_.reachTime < _loc5_))
            {
               if(_loc6_.targetFieldId == this.castle.fieldId)
               {
                  if(_loc6_.missionType == ObjConstants.ARMY_MISSION_SUPPRESS && _loc6_.reachTime == 0 && this.colonies.length > 0)
                  {
                     if(this.colonies[0].relation == 2 && this.colonies[0].endTime > 0)
                     {
                        _loc6_.reachTime = this.colonies[0].endTime;
                     }
                  }
                  _loc2_.push(_loc6_);
                  this._ig672(_loc6_);
               }
               else if(this.isValley(_loc6_.targetFieldId))
               {
                  _loc3_.push(_loc6_);
               }
               else if(this.isColony(_loc6_.targetFieldId))
               {
                  _loc4_.push(_loc6_);
               }
            }
         }
         _loc2_.sort(Utils.sortByReachTime);
         _loc3_.sort(Utils.sortByReachTime);
         _loc4_.sort(Utils.sortByReachTime);
         this.enemyArmies = _loc2_;
         this.enemyValleyArmies = _loc3_;
         this.enemyColonyArmies = _loc4_;
         this.heroUpdateNeeded = true;
      }
      
      public function logMsg(param1:String, param2:String = "#000000") : void
      {
         dispatchEvent(new ScriptLogEvent("<font color=\'#ff0000\'>(" + (this.castle == null ? "" : this.castle.name) + ")</font> - <font color=\'" + param2 + "\'>" + param1 + "</font>",ScriptLogEvent.MESSAGE,this.city));
      }
      
      private function _bb1110(param1:int) : Boolean
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.targetFieldId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function _ow667(param1:int) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = NaN;
         _loc3_ = NaN;
         for each(_loc4_ in this.fortificationProduceQueue)
         {
            _loc2_ = -1;
            _loc3_ = Utils.getServerTime();
            for each(_loc5_ in _loc4_.allProduceQueueArray)
            {
               if(_loc2_ == -1)
               {
                  _loc2_ = Number(_loc5_.endTime);
               }
               else
               {
                  _loc2_ += _loc5_.costTime * 1000;
               }
               if(_loc2_ >= _loc3_ + 1000)
               {
                  if(param1 == _loc5_.type)
                  {
                     return _loc2_;
                  }
               }
            }
         }
         return -1;
      }
      
      public function _printPlayerBuffs(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:BuffBean = null;
         _loc2_ = "";
         _loc3_ = false;
         for each(_loc4_ in this.player.buffsArray)
         {
            if(_loc4_ != null)
            {
               if(param1 && _loc4_.typeId == "RemovingSecurityCodeBuff")
               {
                  _loc3_ = true;
               }
               _loc2_ += (_loc2_ != "" ? "\n" : "") + "<u>" + _loc4_.typeId + "</u>: <i>" + _loc4_.descName + "</i>  <b>remain time</b>: " + Utils.formatTime((_loc4_.endTime - Utils.getServerTime()) / 1000);
            }
         }
         if(_loc2_ != "")
         {
            this.logMsg("<b>Current Player Buffs</b>:\n" + _loc2_,"#225555");
         }
         else
         {
            this.logMsg("<i>No Player Buffs</i>","#225555");
         }
         if(_loc3_ && MainScreen.getMainTownCityState().cityManager.getCfg(CityConfigs.CFG_ALLOWDISABLESECCODE) <= 0)
         {
            this.logMsg("Detected an attempt to remove security code. Cancelling code removal now.","#AA0000");
            ActionFactory.getInstance().getSecurityCommands().cancelRemovingSecurityCodeProcess(this.onCancelRemoveResponse);
         }
      }
      
      private function zeroFoodManager(param1:int) : void
      {
         var task:String = null;
         var func:Function = null;
         var troopSent:Boolean = false;
         var extraSlot:int = 0;
         var hasRallySlot:Boolean = false;
         var availHeroCount:int = 0;
         var hasHeroSlot:Boolean = false;
         var restriction:int = param1;
         task = "none";
         func = null;
         try
         {
            task = "estimate resource";
            func = function():void
            {
               doEstimateResource();
            };
            this.doTask(task,func);
            if(this.getCfg(CityConfigs.CFG_COMFORT) > 0)
            {
               task = "handle comfort";
               func = function():void
               {
                  doComfort();
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_BUILDING) > 0 || this.getCfg(CityConfigs.CFG_RESEARCH) > 0)
            {
               task = "update building and research requirement";
               func = function():void
               {
                  updateBuildingAndResearchReqs();
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_BUILDING) > 0)
            {
               task = "handle building";
               func = function():void
               {
                  doBuilding();
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_RESEARCH) > 0)
            {
               task = "handle research";
               func = function():void
               {
                  doResearch();
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_FORTIFICATION) > 0)
            {
               task = "update fortification requirement";
               func = function():void
               {
                  _mj464();
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_FORTIFICATION) > 0)
            {
               func = function():void
               {
                  if(!fortificationProductionUpdateNeeded && _ya433())
                  {
                     fortificationProductionUpdateNeeded = true;
                  }
               };
               this.doTask(task,func);
            }
            if(restriction == 2)
            {
               return;
            }
            troopSent = this.isWarTownOn();
            extraSlot = this.getAvailableRallyMaxHidingSlots() + this.getAvailableRallyMaxRainbowSlots();
            hasRallySlot = this.getLocalArmiesCount() + extraSlot < this.getMaxRallySlots();
            availHeroCount = this.getTotalAvailableHeroes() + (this.getMayor() == null ? 0 : 1);
            hasHeroSlot = availHeroCount >= this.getAvailableRallyMaxHidingSlots() + 1;
            task = "build npc";
            func = function():void
            {
               if(!troopSent && getCfg(CityConfigs.CFG_BUILDNPC) > 0)
               {
                  troopSent = processBuildNpc(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "attack resource field";
            func = function():void
            {
               if(!troopSent && getCfg(CityConfigs.CFG_VALLEY) > 0)
               {
                  troopSent = tskAttackResourceField(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "rescuetown";
            func = function():void
            {
               if(!troopSent)
               {
                  troopSent = doRescueTownComfortReso();
               }
            };
            this.doTask(task,func);
            task = "keeptroop";
            func = function():void
            {
               if(!troopSent && keepTroopFieldIds.length > 0)
               {
                  troopSent = doKeepTroop();
               }
            };
            this.doTask(task,func);
            if(this.getCfg(CityConfigs.CFG_NPC) <= 0 || this.localNPCs != null)
            {
               task = "requesthelp";
               func = function():void
               {
                  if(!troopSent)
                  {
                     troopSent = doRequestHelp();
                  }
               };
               this.doTask(task,func);
               task = "keepresource";
               func = function():void
               {
                  if(!troopSent && keepResourceFieldIds.length > 0)
                  {
                     troopSent = doKeepResource();
                  }
               };
               this.doTask(task,func);
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logErrMsg("Error while quickly working on " + task + ": " + error.message + "\n" + error.getStackTrace());
            }
         }
      }
      
      private function _ab380() : HeroBean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:HeroBean = null;
         _loc1_ = null;
         for each(_loc2_ in this.heroes)
         {
            if(!(_loc2_.ability > 0 || _loc2_.isHero > 0))
            {
               if(!(_loc2_.status != HeroConstants.HERO_SEIZED_STATU && (_loc2_.power < _loc2_.stratagem || _loc2_.power < _loc2_.management)))
               {
                  if(_loc1_ == null || Utils.isWorstHeroByType("power",_loc1_,_loc2_))
                  {
                     _loc1_ = _loc2_;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function doEmergencyComfort() : Boolean
      {
         if(this.resource.support >= 25 || this.resource.support + this.resource.complaint < 95)
         {
            return false;
         }
         if(this.resource.food.amount > this.getFoodAmountRequiredForComfort() && this.cityTimingAllowed("comfort",150))
         {
            if(this.resource.support <= 8 || this.resource.complaint <= 5)
            {
               this.logMsg(" >>> Do Emergency comfort Praying","#FFAA33");
               CityStateCommands.pacifyPeople(this.castleId,CityStateConstants.COMFORT_PRAY);
            }
            else
            {
               this.logMsg(" >>> Do Emergency comfort Disaster Relief","#FFAA33");
               CityStateCommands.pacifyPeople(this.castleId,CityStateConstants.COMFORT_RELIEF);
            }
            return true;
         }
         return false;
      }
      
      private function _np1318() : void
      {
         var fieldId:int = 0;
         var armies:ArrayCollection = null;
         var army:ArmyBean = null;
         try
         {
            fieldId = this.getFieldIdUsedForHiding();
            if(fieldId == -1)
            {
               return;
            }
            if(!Connection.getInstance().authenticated || Connection.getInstance().paused)
            {
               return;
            }
            if(this.maintenanceTime != -1)
            {
               return;
            }
            if(this.getLocalBuffByWildCardId("ForceopenclosegateBuff") != null && Math.abs(this.lastEnemyTime - Utils.getServerTime()) < 600 * 1000)
            {
               return;
            }
            armies = this.getLocalArmiesMarchingToLocWithReso(fieldId);
            for each(army in armies)
            {
               if(!(army.missionType != ObjConstants.ARMY_MISSION_SEND || (army.resource.gold != 2 || army.resource.stone + army.resource.iron + army.resource.wood != 0)))
               {
                  if(army.reachTime - Utils.getServerTime() < (this.getArmyTravelTimeReliefStationAndHeroAdjusted(army) - 30) * 1000 && this.cityTimingAllowed("recall" + army.armyId,30))
                  {
                     this.logMsg("Recall run away rainbow evasion troop " + Utils.troopStrBeanToMsgString(army.troop,true));
                     CityStateCommands.callBackArmy(this.castleId,army.armyId);
                  }
               }
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg("Error while handling: recallRunAwaySneakyEvasion, " + error.message + "\n" + error.getStackTrace());
            }
         }
      }
      
      private function _ci858(param1:Boolean, param2:Boolean) : Boolean
      {
         var _loc3_:MapCastleBean = null;
         var _loc4_:int = 0;
         var _loc5_:ArmyBean = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:MapCastleBean = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:HeroBean = null;
         var _loc16_:TroopBean = null;
         var _loc17_:NewArmyParam = null;
         if(this.maintenanceTime != -1)
         {
            this._gr492();
            return false;
         }
         _loc3_ = null;
         _loc4_ = 0;
         for each(_loc5_ in this.selfArmies)
         {
            if(this.lastFlatRollingLevels[_loc5_.targetFieldId] != undefined && _loc5_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc5_.direction == ArmyConstants.ARMY_FORWARD)
            {
               _loc3_ = Map.getDetail(_loc5_.targetFieldId,10 * 60);
               _loc4_ = Map.getLevel(_loc5_.targetFieldId,10 * 60);
               if(_loc4_ == -1)
               {
                  return false;
               }
               if(_loc4_ != -1 && _loc4_ != this.lastFlatRollingLevels[_loc5_.targetFieldId] || _loc3_ != null && _loc3_.userName != null && _loc3_.userName != this.player.playerInfo.userName)
               {
                  this.logMsg("Target field for flat rolling changed, recall troop " + _loc5_.armyId + " toward " + Map.fieldIdToString(_loc5_.targetFieldId));
                  CityStateCommands.callBackArmy(this.castleId,_loc5_.armyId);
                  delete this.lastFlatRollingLevels[_loc5_.targetFieldId];
               }
            }
         }
         _loc6_ = 0;
         _loc7_ = Math.pow(int(this.getCfg(CityConfigs.CFG_FLATROLLING)) * 2 + 1,2);
         _loc8_ = null;
         _loc9_ = -1;
         _loc10_ = 0;
         _loc11_ = 0;
         _loc12_ = 0;
         while(_loc12_ <= _loc7_)
         {
            _loc10_ = this._ne789(this.castle.fieldId,_loc12_);
            if(Map.fieldDistance(_loc10_,this.castle.fieldId) <= this.getCfg(CityConfigs.CFG_FLATROLLING))
            {
               _loc11_ = Map.getType(_loc10_);
               if(_loc11_ == -1)
               {
                  return false;
               }
               if(_loc11_ == FieldConstants.TYPE_FLAT)
               {
                  _loc8_ = Map.getDetail(_loc10_);
                  if(_loc8_ != null)
                  {
                     if(_loc8_.userName == null)
                     {
                        if(this._lb710(_loc10_) <= 0)
                        {
                           _loc9_ = _loc10_;
                           break;
                        }
                     }
                  }
                  else
                  {
                     _loc6_++;
                     if(_loc6_ > 10)
                     {
                        break;
                     }
                  }
               }
            }
            _loc12_++;
         }
         if(!param1 || !param2)
         {
            return false;
         }
         if(_loc9_ == -1)
         {
            return false;
         }
         this.lastFlatRollingActivityTime = Utils.getServerTime();
         _loc13_ = this.rallySettings[RALLY_BUILDNPC] == -1 ? 10 : int(this.rallySettings[RALLY_BUILDNPC]);
         if(this.getCountOfLocalArmiesForCaptureFlats() >= _loc13_)
         {
            return false;
         }
         _loc14_ = this.getCfg(CityConfigs.CFG_HUNTING) > 0 ? 1 : 0;
         if(this.getCountOfLocalArmiesForCaptureFlats() + this.fields.length + _loc14_ >= this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL))
         {
            if(!this._xm876())
            {
               if(this.cityTimingAllowed("noslot",600))
               {
                  this.logMsg("No more empty valley slots to roll flats");
               }
               return false;
            }
         }
         _loc15_ = this.getNextValleyHero();
         if(_loc15_ == null)
         {
            return false;
         }
         _loc16_ = this.getTroopsToAttackValley(Map.getLevel(_loc9_));
         if(_loc16_ == null)
         {
            return false;
         }
         _loc17_ = new NewArmyParam();
         _loc17_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc17_.troops = _loc16_;
         _loc17_.resource = new ResourceBean();
         _loc17_.heroId = _loc15_.id;
         _loc17_.targetPoint = _loc9_;
         if(!this.isEnoughResourcesToMarch(_loc17_))
         {
            return false;
         }
         if(!playerTimingAllowed("attackflat" + _loc9_,600))
         {
            return false;
         }
         this.logMsg("Attack flat " + Map.fieldIdToString(_loc9_) + " for flatrolling with " + Utils.troopBeanToString(_loc16_) + ", arriving in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc17_)));
         CityStateCommands.newArmy(this.castleId,_loc17_,this.handleArmyCommandResponse);
         this.lastFlatRollingLevels[_loc9_] = Map.getLevel(_loc9_);
         this.adjEstFoodAfterMarch(_loc17_);
         Map.updateDetailInfo(_loc9_);
         return true;
      }
      
      private function doSpecialMarketHiding() : Boolean
      {
         var maxPrice:Number = NaN;
         var evasionEndTime:Number = NaN;
         var hoursUntilEvasionEnds:Number = NaN;
         try
         {
            if(!this.cityTimingAllowed("specialmarkethiding",5))
            {
               return false;
            }
            if(this.tradesArray.length >= this.getBuildingLevel(BuildingConstants.TYPE_MARKET))
            {
               return false;
            }
            if(this.getCfg(CityConfigs.CFG_HIDING) <= 0 || this.getCfg(CityConfigs.CFG_TRADING) <= 0 || this.getCfg(CityConfigs.CFG_MARKETHIDING) <= 0)
            {
               return false;
            }
            maxPrice = Math.max(this._hf650(TradeConstants.RES_TYPE_WOOD),this._hf650(TradeConstants.RES_TYPE_IRON),this._hf650(TradeConstants.RES_TYPE_FOOD),this._hf650(TradeConstants.RES_TYPE_STONE));
            if(this.resource.wood.amount + this.resource.food.amount + this.resource.stone.amount + this.resource.iron.amount + this.resource.gold / maxPrice > 5000000)
            {
               return false;
            }
            evasionEndTime = this._yb134(this.getCfg(CityConfigs.CFG_ATTACKGAP));
            hoursUntilEvasionEnds = Math.max(0,evasionEndTime - Utils.getServerTime()) / 3600000;
            this.doSpecialMarketHide(TradeConstants.RES_TYPE_FOOD,this.resource.food.amount - Math.max(0,this.resource.troopCostFood) * hoursUntilEvasionEnds);
            this.doSpecialMarketHide(TradeConstants.RES_TYPE_WOOD,this.resource.wood.amount);
            this.doSpecialMarketHide(TradeConstants.RES_TYPE_STONE,this.resource.stone.amount);
            this.doSpecialMarketHide(TradeConstants.RES_TYPE_IRON,this.resource.iron.amount);
            if(this.resource.gold / this._hf650(TradeConstants.RES_TYPE_FOOD) / 1.3 > 100)
            {
               CityStateCommands.newTrade(this.castleId,TradeConstants.RES_TYPE_FOOD,TradeConstants.TRADE_TYPE_BUY,Math.min(MAXTRADESIZE,Utils.roundAmount(this.resource.gold / this._hf650(TradeConstants.RES_TYPE_FOOD) / 1.5)),"" + this.getTrimmedMarketPrice(this._hf650(TradeConstants.RES_TYPE_FOOD) * 1.3));
            }
            return true;
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg("Error while handling: specialMarketHiding, " + error.message + "\n" + error.getStackTrace());
            }
         }
         return false;
      }
      
      private function getWorstRegularHero() : HeroBean
      {
         var _loc1_:Number = NaN;
         var _loc2_:HeroBean = null;
         var _loc3_:ArrayCollection = null;
         var _loc4_:Boolean = false;
         var _loc5_:HeroBean = null;
         var _loc6_:HeroBean = null;
         _loc1_ = this.getCfg(CityConfigs.CFG_HERO) <= 1 ? 10 : this.getCfg(CityConfigs.CFG_FASTHERO);
         _loc2_ = null;
         _loc3_ = this.getReservedHeroes();
         _loc3_.addItem(this.bestPoliticHero());
         _loc4_ = false;
         _loc5_ = null;
         for each(_loc6_ in this.heroes)
         {
            _loc4_ = false;
            if(!(_loc6_.ability > 0 || _loc6_.isHero > 0))
            {
               for each(_loc5_ in _loc3_)
               {
                  if(_loc6_ == _loc5_)
                  {
                     _loc4_ = true;
                     break;
                  }
               }
               if(!_loc4_)
               {
                  if(_loc1_ >= 10 && _loc6_.power < 120 && _loc6_.power - _loc6_.level + _loc6_.remainPoint < _loc1_ || _loc1_ < 10 && _loc6_.level < _loc1_ * 10)
                  {
                     if(_loc2_ == null || _loc1_ >= 10 && Utils.isWorstHeroByType("power",_loc2_,_loc6_) || _loc1_ < 10 && _loc2_.level > _loc6_.level)
                     {
                        _loc2_ = _loc6_;
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function doRescueTownEmergencyGold() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:CityManager = null;
         var _loc3_:int = 0;
         if(this.resource.gold < 5000)
         {
            return false;
         }
         _loc1_ = Utils.randOrder(MainScreen.getCities().length);
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = (MainScreen.getCities()[_loc1_[_loc3_]] as CityState).cityManager;
            if(this != _loc2_ && _loc2_.getCfg(CityConfigs.CFG_NORESCUE) < 1 && _loc2_.getCfg(CityConfigs.CFG_ABANDON) < 1)
            {
               if(_loc2_.resource.gold == 0 && _loc2_.resource.herosSalary > _loc2_.resource.taxIncome)
               {
                  if(this.doRescueTownEmergyGoldSendArmy(_loc2_.castle))
                  {
                     return true;
                  }
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function set player(param1:PlayerBean) : void
      {
         MainScreen.setPlayer(param1);
      }
      
      private function buildComplete(param1:BuildComplate) : void
      {
         var _loc2_:int = 0;
         if(param1.castleId != this.castleId)
         {
            return;
         }
         if(param1.buildingBean.status == 0)
         {
            this.logMsg("BUILD > Complete building " + param1.buildingBean.name + ":" + param1.buildingBean.level + " at location " + param1.buildingBean.positionId,COLR_STD_LOG_MSG);
            if(param1.buildingBean.typeId == BuildingConstants.TYPE_TOWN_HALL)
            {
               this.resourceFieldsDetailInfo = new ArrayCollection();
               this.candidateResourceFields = null;
            }
         }
         this._reserveEmergencyTimeSlot();
         _loc2_ = 0;
         while(_loc2_ < this.buildings.length)
         {
            if(this.buildings[_loc2_].positionId == param1.buildingBean.positionId)
            {
               if(param1.buildingBean.level == 0 && param1.buildingBean.status == 0)
               {
                  this.buildings.removeItemAt(_loc2_);
               }
               else
               {
                  this.buildings[_loc2_] = param1.buildingBean;
               }
               return;
            }
            _loc2_++;
         }
         this.buildings.addItem(param1.buildingBean);
      }
      
      private function setTaxRateResonseHandler(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("Taxation response error: " + param1.errorMsg);
         }
      }
      
      private function getTotalTroopCountFromDefReport(param1:XMLList) : int
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         _loc2_ = 0;
         var _loc3_:int = 0;
         _loc4_ = null;
         for each(_loc5_ in param1)
         {
            _loc3_ = int(_loc5_.@typeId);
            _loc4_ = _loc5_.@count;
            if(!Utils.hasValue(_loc4_))
            {
               return -1;
            }
            _loc2_ += int(_loc4_);
         }
         return _loc2_;
      }
      
      public function _ow687() : FortificationsBean
      {
         var _loc1_:FortificationsBean = null;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = new FortificationsBean(this.fortification);
         for each(_loc2_ in this.fortificationProduceQueue)
         {
            for each(_loc3_ in _loc2_.allProduceQueueArray)
            {
               _loc1_[troopIntNames[_loc3_.type]] += _loc3_.num;
            }
         }
         return _loc1_;
      }
      
      private function _ej311(param1:AllProduceBean, param2:int) : int
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:ProduceBean = null;
         if(param1 == null)
         {
            return 0;
         }
         var _loc3_:FortificationsBean = new FortificationsBean();
         _loc4_ = true;
         _loc5_ = 0;
         for each(_loc6_ in param1.allProduceQueueArray)
         {
            if(_loc6_.type == param2 && _loc6_.num == 1)
            {
               break;
            }
            if(_loc6_.num > 1 || !_loc4_ && troopTimes[_loc6_.type] > troopTimes[param2])
            {
               CityStateCommands.cancelTroopProduce(this.castleId,param1.positionId,_loc6_.queueId);
               _loc5_++;
            }
            _loc4_ = false;
         }
         return _loc5_;
      }
      
      public function _nk320() : void
      {
         if(buildCityLocation == -1)
         {
            this.logMsg("No city is currently scheduled to be built");
            return;
         }
         this._recallLocalArmiesToTarget(buildCityLocation);
         buildCityLocation = -1;
      }
      
      private function doHonorAttack() : void
      {
         var _loc1_:MapCastleBean = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:HeroBean = null;
         var _loc5_:NewArmyParam = null;
         if(this.honorAttackFieldId == -1)
         {
            return;
         }
         if(!playerTimingAllowed("honorattack",4))
         {
            return;
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return;
         }
         _loc1_ = Map.getDetail(this.honorAttackFieldId);
         if(_loc1_ == null)
         {
            return;
         }
         if(!_loc1_.canOccupy || _loc1_.state != 1 && _loc1_.state != 4)
         {
            this.logMsg("CANNOT HONOR ATTACK ON " + Map.fieldIdToString(this.honorAttackFieldId));
            this._pi862();
            return;
         }
         _loc2_ = Map.getType(this.honorAttackFieldId);
         if(_loc2_ == -1)
         {
            return;
         }
         if(_loc2_ != FieldConstants.TYPE_CASTLE)
         {
            this.logMsg("Honor attack target is not a castle: " + Map.fieldIdToString(this.honorAttackFieldId));
            this._pi862();
            return;
         }
         if(Utils.getTotalTroopCount(this.honorTroopBean) > this.getRallyDispatchPerArmyLimit(true))
         {
            this.logMsg("TOO MANY TROOPS USED IN HONOR ATTACK ON " + Map.fieldIdToString(this.honorAttackFieldId));
            this._pi862();
            return;
         }
         for each(_loc3_ in troopTypes)
         {
            if(this.troop[troopIntNames[_loc3_]] < this.honorTroopBean[troopIntNames[_loc3_]])
            {
               return;
            }
         }
         _loc4_ = this._fr173();
         if(_loc4_ == null)
         {
            return;
         }
         _loc5_ = new NewArmyParam();
         _loc5_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc5_.troops = this.honorTroopBean;
         _loc5_.resource = new ResourceBean();
         _loc5_.heroId = _loc4_.id;
         _loc5_.targetPoint = this.honorAttackFieldId;
         if(!this.isEnoughResourcesToMarch(_loc5_))
         {
            return;
         }
         if(!this.cityTimingAllowed("honorattack",5))
         {
            return;
         }
         this.logMsg("Honor attack on " + Map.fieldIdToString(this.honorAttackFieldId) + " with hero " + _loc4_.name + " and " + Utils.troopBeanToString(this.honorTroopBean) + " " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc5_) / Utils.getHeroSpeedFactor(_loc4_)));
         if(MasterTimer.getInstance().canSend(this.timeSlot))
         {
            CityStateCommands.newArmy(this.castleId,_loc5_,this.handleArmyCommandResponse);
         }
         else
         {
            CityStateCommands.newArmy(this.castleId,_loc5_);
         }
         this.adjEstFoodAfterMarch(_loc5_);
         Map.updateDetailInfo(this.honorAttackFieldId);
         if(playerTimingAllowed("updatefield" + this.honorAttackFieldId,300))
         {
            Map.updateInfo(this.honorAttackFieldId);
         }
      }
      
      private function getTroopForNpcLevel(param1:int, param2:Boolean) : TroopBean
      {
         var _loc3_:TroopBean = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = new TroopBean();
         if(this.npcTroopBean != null)
         {
            this.npcTroopBean.copyTo(_loc3_);
            if(!param2)
            {
               _loc3_.carriage = 0;
            }
            if(isEnoughTroops(this.troop,_loc3_))
            {
               return _loc3_;
            }
            return null;
         }
         if(param1 <= 0 || param1 > 5)
         {
            return null;
         }
         _loc4_ = this.getTechLevel(TechConstants.THROW_SKILL);
         _loc5_ = this.getTechLevel(TechConstants.DRIVE_SKILL);
         _loc6_ = this.getTechLevel(TechConstants.COMBAT_SKILL);
         if(param1 == 5 && (_loc4_ <= 7 || _loc4_ == 8 && _loc5_ >= 7 || _loc4_ == 9 && _loc5_ >= 5 && _loc5_ <= 7))
         {
            if(playerTimingAllowed("npcunsafe0",1000))
            {
               this.logMsg("<i>UNSAFE HBR/ARCHERY LEVEL COMBINATION FOR NPC FARMING LEVEL 5!</i>",COLR_STD_LOG_MSG);
            }
            return null;
         }
         if(param1 == 4 && _loc4_ <= 6)
         {
            if(playerTimingAllowed("npcunsafe1",1000))
            {
               this.logMsg("<i>UNSAFE ARCHERY LEVEL FOR NPC FARMING LEVEL 4!</i>",COLR_STD_LOG_MSG);
            }
            return null;
         }
         if(_loc6_ < param1 + 2)
         {
            if(playerTimingAllowed("npcunsafe2",1000))
            {
               this.logMsg("<i>UNSAFE MILITARY TRADITION LEVEL FOR NPC FARMING!</i>",COLR_STD_LOG_MSG);
            }
            return null;
         }
         _loc3_.ballista = this.NPCBALLISTAS[param1];
         if(param2)
         {
            _loc3_.carriage = NPCTRANSPORTS[param1] / (1 + 0.1 * this.getTechLevel(TechConstants.LOAD_TECH)) + 1;
         }
         if(this.troop.ballista < _loc3_.ballista || this.troop.carriage < _loc3_.carriage)
         {
            return null;
         }
         return _loc3_;
      }
      
      private function _pp854(param1:Array) : HeroBean
      {
         var _loc2_:HeroBean = null;
         var _loc3_:HeroBean = null;
         var _loc4_:String = null;
         _loc2_ = this.trainingHeroNeeded || this.isNextTrainingHeroStop() ? this.getBestIdleTrainingHero() : null;
         for each(_loc3_ in this.heroes)
         {
            if(!(_loc3_.stamina < this.getMinEnergyCfg() || _loc3_.status != HeroConstants.HERO_FREE_STATU && _loc3_.status != HeroConstants.HERO_CHIEF_STATU))
            {
               if(!(!_lb30(_loc3_) || _loc3_ == _loc2_))
               {
                  for each(_loc4_ in param1)
                  {
                     if(_loc3_.name.toLowerCase() == _loc4_.toLowerCase())
                     {
                        if(_loc3_.status == HeroConstants.HERO_CHIEF_STATU || _loc3_.id == this.lastPromoteId)
                        {
                           this.removeMayor();
                        }
                        return _loc3_;
                     }
                  }
               }
            }
         }
         return null;
      }
      
      private function _ux814(param1:CityCondition) : Boolean
      {
         var _loc2_:AvailableResearchListBean = null;
         if(param1.isBuilding)
         {
            return false;
         }
         for each(_loc2_ in this.researches)
         {
            if(_loc2_.upgradeing && _loc2_.typeId == param1.typeId && (_loc2_.level + 1 >= param1.level || _loc2_.castleId != this.castleId))
            {
               return true;
            }
         }
         return false;
      }
      
      private function getLocalArmiesCount() : int
      {
         return this.localArmies.length;
      }
      
      private function _bt822() : ConditionBean
      {
         var _loc1_:BuildingBean = null;
         var _loc2_:CityCondition = null;
         var _loc3_:ConditionBean = null;
         var _loc4_:ConditionBean = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         _loc1_ = this._getCurrentConstruction();
         if(_loc1_ != null && _loc1_.endTime - Utils.getServerTime() > 3 * 3600 * 1000)
         {
            return null;
         }
         _loc2_ = null;
         _loc3_ = null;
         _loc4_ = null;
         _loc5_ = 0;
         _loc6_ = 100000000;
         _loc7_ = this.currRequirements.length - 1;
         while(_loc7_ >= 0)
         {
            _loc2_ = this.currRequirements[_loc7_];
            if(_loc2_.isBuilding)
            {
               if(!this._mi60(_loc2_))
               {
                  if(_loc1_ == null)
                  {
                     if(this._mo519(_loc2_))
                     {
                        this.currRequirements.removeItemAt(_loc7_);
                     }
                     else
                     {
                        if(_loc2_.level == 0)
                        {
                           return new ConditionBean();
                        }
                        if(this._it985(_loc2_))
                        {
                           _loc3_ = this.getConditionBeanForUpgradingTo(_loc2_);
                           if(_loc3_ != null)
                           {
                              _loc5_ = Math.max(_loc3_.food,_loc3_.gold,_loc3_.wood,_loc3_.stone,_loc3_.iron);
                              if(_loc5_ < _loc6_)
                              {
                                 _loc6_ = _loc5_;
                                 _loc4_ = _loc3_;
                              }
                           }
                        }
                     }
                  }
                  else if(!(_loc1_.level + 1 == _loc2_.level && _loc1_.typeId == _loc2_.typeId && this.getBuildingsCountByTypeAndLvl(_loc2_.typeId,_loc2_.level) + 1 >= _loc2_.count))
                  {
                     if(!(_loc2_.level == 0 && _loc1_.typeId == _loc2_.typeId))
                     {
                        if(this._mo519(_loc2_))
                        {
                           this.currRequirements.removeItemAt(_loc7_);
                        }
                        else
                        {
                           if(_loc2_.level == 0)
                           {
                              return new ConditionBean();
                           }
                           if(this._it985(_loc2_))
                           {
                              _loc3_ = this.getConditionBeanForUpgradingTo(_loc2_);
                              if(_loc3_ != null)
                              {
                                 _loc5_ = Math.max(_loc3_.food,_loc3_.gold,_loc3_.wood,_loc3_.stone,_loc3_.iron);
                                 if(_loc5_ < _loc6_)
                                 {
                                    _loc6_ = _loc5_;
                                    _loc4_ = _loc3_;
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc7_--;
         }
         return _loc4_;
      }
      
      public function bestPoliticHero() : HeroBean
      {
         return this.getBestHeroByType("management");
      }
      
      private function revalidateBuildnpcArmyTargets() : void
      {
         var _loc1_:CityState = null;
         for each(_loc1_ in MainScreen.getCities())
         {
            _loc1_.cityManager._revalidateBuildnpcArmyTargets();
         }
      }
      
      private function _revalidateBuildnpcArmyTargets() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:MapCastleBean = null;
         var _loc5_:ArmyBean = null;
         _loc1_ = NaN;
         _loc2_ = NaN;
         _loc3_ = 0;
         _loc4_ = null;
         for each(_loc5_ in this.localArmies)
         {
            if(this.lastBuildNPCLevels[_loc5_.targetFieldId] != undefined && _loc5_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc5_.direction == ArmyConstants.ARMY_FORWARD)
            {
               _loc1_ = _loc5_.reachTime - Utils.getServerTime();
               _loc2_ = Math.max(30,Math.min(15 * 60,_loc1_ / 1000 * 0.8));
               _loc4_ = Map.getDetail(_loc5_.targetFieldId,_loc2_);
               _loc3_ = Map.getLevel(_loc5_.targetFieldId,_loc2_);
               if(_loc3_ != -1 && _loc3_ != this.lastBuildNPCLevels[_loc5_.targetFieldId] || _loc4_ != null && _loc4_.userName != null && _loc4_.userName != this.player.playerInfo.userName)
               {
                  this.logMsg("BUILDNPC > Target field for buildnpc changed, recall troop " + _loc5_.armyId + " toward " + Map.fieldIdToString(_loc5_.targetFieldId));
                  CityStateCommands.callBackArmy(this.castleId,_loc5_.armyId);
                  delete this.lastBuildNPCLevels[_loc5_.targetFieldId];
               }
            }
         }
      }
      
      private function doSpamAttack() : void
      {
         var _loc3_:int = 0;
         var _loc4_:HeroBean = null;
         if(this.spamAttackFieldId == -1)
         {
            return;
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return;
         }
         if(this.spamCount <= 0)
         {
            this.logMsg("DONE WITH SPAM ATTACK ON " + Map.fieldIdToString(this.spamAttackFieldId));
            this._yy805();
            return;
         }
         var _loc1_:MapCastleBean = Map.getDetail(this.spamAttackFieldId);
         if(_loc1_ == null)
         {
            return;
         }
         if(!_loc1_.canOccupy || _loc1_.state != 1 && _loc1_.state != 4)
         {
            this.logMsg("CANNOT SPAM ATTACK ON " + Map.fieldIdToString(this.spamAttackFieldId));
            this._yy805();
            return;
         }
         if(Utils.getTotalTroopCount(this.spamTroopBean) > this.getRallyDispatchPerArmyLimit(true))
         {
            this.logMsg("TOO MANY TROOPS USED IN SPAM ATTACK ON " + Map.fieldIdToString(this.spamAttackFieldId));
            this._yy805();
            return;
         }
         var _loc2_:String = null;
         for each(_loc3_ in troopTypes)
         {
            _loc2_ = troopIntNames[_loc3_];
            if(this.troop[_loc2_] < this.spamTroopBean[_loc2_])
            {
               return;
            }
         }
         _loc4_ = this._fr173();
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:NewArmyParam = new NewArmyParam();
         _loc5_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc5_.troops = this.spamTroopBean;
         _loc5_.resource = new ResourceBean();
         _loc5_.heroId = _loc4_.id;
         _loc5_.targetPoint = this.spamAttackFieldId;
         if(!this.isEnoughResourcesToMarch(_loc5_))
         {
            return;
         }
         if(!this.cityTimingAllowed("spamattack",5))
         {
            return;
         }
         this.logMsg("Spam attack on " + Map.fieldIdToString(this.spamAttackFieldId) + " with hero " + _loc4_.name + " and " + Utils.troopBeanToString(this.spamTroopBean) + " " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc5_) / Utils.getHeroSpeedFactor(_loc4_)));
         if(MasterTimer.getInstance().canSend(this.timeSlot))
         {
            CityStateCommands.newArmy(this.castleId,_loc5_,this.handleArmyCommandResponse);
         }
         else
         {
            CityStateCommands.newArmy(this.castleId,_loc5_);
         }
         this.adjEstFoodAfterMarch(_loc5_);
         Map.updateDetailInfo(this.spamAttackFieldId);
         --this.spamCount;
      }
      
      private function handleReceiveReportList(param1:ReportListResponse) : void
      {
         var _loc2_:* = undefined;
         if(!this.isMainTown())
         {
            return;
         }
         if(param1.ok != 1)
         {
            this.logMsg("receive report list error: " + param1.msg);
            return;
         }
         if(playerTimingAllowed("cleanSeenReport",3600))
         {
            seenReports = new Array();
         }
         if(param1.reportsArray.length == 0)
         {
            return;
         }
         for each(_loc2_ in param1.reportsArray)
         {
            if(seenReports[_loc2_.id] == undefined)
            {
               seenReports[_loc2_.id] = Utils.getServerTime();
               if(_loc2_.title.search("Trading report") > -1 || _loc2_.title.search("Attackers Returned") > -1 || _loc2_.title.search("Scout Returned") > -1 || _loc2_.armyType == 1 || _loc2_.title.search("Troops Arrived") > -1)
               {
                  ActionFactory.getInstance().getReportCommands().deleteReport("" + _loc2_.id);
               }
               else if(_loc2_.isRead == 0)
               {
                  if(true || _loc2_.title == "Scout Reports" || _loc2_.title == "Attack Reports")
                  {
                     if(_loc2_.targetPos.search("Barbarian") > -1 || _loc2_.targetPos.search("Grassland") > -1 || _loc2_.targetPos.search("Desert") > -1 || _loc2_.targetPos.search("Flat") > -1 || _loc2_.targetPos.search("Lake") > -1 || _loc2_.targetPos.search("Hill") > -1 || _loc2_.targetPos.search("Forest") > -1 || _loc2_.targetPos.search("Swamp") > -1)
                     {
                        if(playerTimingAllowed("readreport",2))
                        {
                           ActionFactory.getInstance().getReportCommands().markAsRead(_loc2_.id);
                        }
                        else
                        {
                           delete seenReports[_loc2_.id];
                        }
                     }
                     else
                     {
                        ActionFactory.getInstance().getReportCommands().markAsRead(_loc2_.id);
                     }
                  }
               }
            }
         }
      }
      
      private function switchRallySettings() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         _loc1_ = this.isLastEnemyTimeLessThan1Hr();
         _loc2_ = 0;
         while(_loc2_ < this.rallySettings.length)
         {
            if(this.warRallySettings[_loc2_] == -1 || !_loc1_)
            {
               this.rallySettings[_loc2_] = this.defaultRallySettings[_loc2_];
            }
            else
            {
               this.rallySettings[_loc2_] = this.warRallySettings[_loc2_];
            }
            _loc2_++;
         }
      }
      
      private function _us376(param1:Array) : HeroBean
      {
         var _loc2_:HeroBean = null;
         var _loc3_:String = null;
         var _loc4_:HeroBean = null;
         _loc2_ = this.trainingHeroNeeded ? this.getBestIdleTrainingHero() : null;
         param1 = this.getAvailableHeroNamesFromHeroListStr(param1);
         for each(_loc3_ in param1)
         {
            for each(_loc4_ in this.heroes)
            {
               if(!(_loc4_ == _loc2_ || _loc4_.stamina < this.getMinEnergyCfg() || _loc4_.name.toLowerCase() != _loc3_.toLowerCase()))
               {
                  if(_loc4_.status != HeroConstants.HERO_FREE_STATU && _loc4_.status != HeroConstants.HERO_CHIEF_STATU)
                  {
                     break;
                  }
                  if(!(_loc4_.status == HeroConstants.HERO_CHIEF_STATU || _loc4_.id == this.lastPromoteId))
                  {
                     return _loc4_;
                  }
                  if(this.cityTimingAllowed("removeforidle" + _loc4_.id,300))
                  {
                     this.removeMayor();
                     return _loc4_;
                  }
               }
            }
         }
         return null;
      }
      
      private function doZeroFoodQFarm(param1:int = 10) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         _loc2_ = this._doQFarm();
         if(_loc2_ == null)
         {
            if(this.cityTimingAllowed("failzerofoodquickfarm",300))
            {
               this.logMsg("ZEROFOOD > Map is not ready, cannot farm yet!",COLR_ERR_LOG_MSG);
            }
            return false;
         }
         if(_loc2_.length == 0)
         {
            return false;
         }
         _loc3_ = false;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length && _loc4_ < param1)
         {
            if(!this._sendQuickArmy(_loc2_[_loc4_],false,null,true))
            {
               break;
            }
            _loc3_ = true;
            _loc4_++;
         }
         if(!_loc3_)
         {
            return false;
         }
         this.lastZeroFoodOp = Utils.getServerTime();
         return true;
      }
      
      private function _rt822(param1:Number) : Boolean
      {
         var _loc2_:ArmyBean = null;
         var _loc3_:int = 0;
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < this.enemyArmies.length)
         {
            _loc2_ = this.enemyArmies[_loc3_];
            if(_loc2_.reachTime > param1)
            {
               return false;
            }
            if(!this.isJunkTroop(_loc2_.troop))
            {
               if(Utils.hasValue(_loc2_.troop.carriage) && int(_loc2_.troop.carriage) > 200)
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      private function setAllMembersList(param1:AllianceMembersResponse) : void
      {
         var _loc2_:* = undefined;
         this.varAllMembersList = new Array();
         if(param1.ok != 1)
         {
            return;
         }
         for each(_loc2_ in param1.membersArray)
         {
            this.varAllMembersList.push(_loc2_);
         }
      }
      
      public function _vu1098(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Array = null;
         var _loc8_:ArrayCollection = null;
         var _loc9_:String = null;
         _loc2_ = null;
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = true;
         _loc7_ = param1.split(",");
         _loc8_ = new ArrayCollection();
         for each(_loc9_ in _loc7_)
         {
            _loc2_ = _loc9_.split(":");
            if(_loc2_.length < 2)
            {
               this.logMsg("Invalid building condition: " + _loc9_);
               _loc6_ = false;
            }
            else
            {
               _loc3_ = BuildingType.fromString(_loc2_[0]);
               if(_loc3_ == -1)
               {
                  this.logMsg("Invalid building: " + _loc9_);
                  _loc6_ = false;
               }
               else if(!Utils.hasValue(_loc2_[1]))
               {
                  this.logMsg("Invalid building level in " + _loc9_);
                  _loc6_ = false;
               }
               else
               {
                  _loc4_ = int(_loc2_[1]);
                  if(_loc4_ < 0 || _loc4_ > this.MAXBUILDINGLEVEL)
                  {
                     this.logMsg("Invalid level: " + _loc9_);
                     _loc6_ = false;
                  }
                  else if(_loc4_ > 10 && !BuildingType.isExteriorBuilding(_loc3_))
                  {
                     this.logMsg("Invalid level for inside building: " + _loc9_);
                     _loc6_ = false;
                  }
                  else if(_loc2_[2] != undefined && !Utils.hasValue(_loc2_[2]))
                  {
                     this.logMsg("Invalid building count in " + _loc9_);
                     _loc6_ = false;
                  }
                  else
                  {
                     _loc5_ = _loc2_[2] == undefined ? 1 : int(_loc2_[2]);
                     if(_loc5_ < 0)
                     {
                        _loc5_ = 1;
                     }
                     _loc8_.addItem(new CityCondition(true,_loc3_,_loc4_,_loc5_));
                     this.cityCfg.configs[CityConfigs.CFG_BUILDING] = 1;
                  }
               }
            }
         }
         this.buildingRequirements.addItem(_loc8_);
         return _loc6_;
      }
      
      private function _fa789() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:ArmyBean = null;
         if(this.evasionFieldId != -1)
         {
            return;
         }
         _loc1_ = 5;
         _loc2_ = Map.getX(this.castle.fieldId);
         _loc3_ = Map.getY(this.castle.fieldId);
         if(!Map.isMapReady(_loc2_,_loc3_,_loc1_))
         {
            return;
         }
         _loc4_ = new Array();
         _loc5_ = 0;
         _loc6_ = _loc2_ - _loc1_;
         while(_loc6_ <= _loc2_ + _loc1_)
         {
            _loc7_ = _loc3_ - _loc1_;
            while(_loc7_ <= _loc3_ + _loc1_)
            {
               if((_loc6_ - _loc2_) * (_loc6_ - _loc2_) + (_loc7_ - _loc3_) * (_loc7_ - _loc3_) <= _loc1_ * _loc1_)
               {
                  _loc5_ = Map.getFieldId(_loc6_,_loc7_);
                  if(Map.getType(_loc5_) == FieldConstants.TYPE_NPC && Map.getLevel(_loc5_) <= 5)
                  {
                     _loc4_.push(_loc5_);
                  }
               }
               _loc7_++;
            }
            _loc6_++;
         }
         _loc4_.sort(this.byDistanceFromCastle);
         if(_loc4_.length > 0)
         {
            this.evasionFieldId = _loc4_[0];
            _loc8_ = this.getArmyToTarget(this.evasionFieldId);
            if(_loc8_ != null)
            {
               CityStateCommands.callBackArmy(this.castleId,_loc8_.armyId);
            }
         }
      }
      
      private function adjEstFoodAfterMarch(param1:NewArmyParam) : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         for each(_loc2_ in resourceIntNames)
         {
            this.estResource[_loc2_] -= param1.resource[_loc2_];
         }
         _loc3_ = this.getFoodNeededToMarch(param1,true);
         this.estResource.food -= _loc3_;
         this.resource.food.amount -= _loc3_;
      }
      
      public function _ok1059() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:TransingTradeBean = null;
         var _loc3_:TradeBean = null;
         _loc1_ = new Array(this.resource.food.amount,this.resource.wood.amount,this.resource.stone.amount,this.resource.iron.amount);
         for each(_loc2_ in this.transingTradesArray)
         {
            _loc1_[_loc2_.resType] += _loc2_.amount;
         }
         for each(_loc3_ in this.tradesArray)
         {
            if(_loc3_.tradeType == TradeConstants.TRADE_TYPE_BUY)
            {
               _loc1_[_loc3_.resType] += _loc3_.amount - _loc3_.dealedAmount;
            }
         }
         return _loc1_;
      }
      
      private function handleArmyCommandResponse(param1:CommandResponse) : void
      {
         if(param1.ok == 1)
         {
            this.lastBattleAfterAdvMoveErrorTime = null;
            this.lastAmbushFromAllSideErrorTime = null;
         }
         else
         {
            if(param1.ok == ErrorCode.CANT_BATTLE_AFTER_ADV_MOVE)
            {
               this.lastBattleAfterAdvMoveErrorTime = new Date();
            }
            if(param1.ok == ErrorCode.STILL_ANTI_BATTLE)
            {
               lastAntiBattleErrorTime = new Date();
            }
            if(param1.ok == ErrorCode.CANT_BATTLE_WHEN_CAPITAL_TRUCE)
            {
               this.lastCapitalTruceErrorTime = new Date();
            }
            if(param1.ok == ErrorCode.TRICK_INFRO_CANNOT_NEW_ARMY)
            {
               this.lastAmbushFromAllSideErrorTime = new Date();
            }
            this.logErrMsg("army command response error " + param1.ok + ": " + param1.errorMsg);
            MasterTimer.getInstance().setNextActiveTime();
         }
      }
      
      public function _recallLocalArmiesToTarget(param1:int) : void
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.localArmies)
         {
            if(!(_loc2_.targetFieldId != param1 || _loc2_.direction == ArmyConstants.ARMY_BACKWARD))
            {
               this.logMsg("Recall troop to " + Map.fieldIdToString(param1) + ", id: " + _loc2_.armyId,COLR_STD_LOG_MSG);
               CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
            }
         }
      }
      
      private function _wb445(param1:ConditionBean, param2:int) : Boolean
      {
         var _loc3_:ConditionDependBuildingBean = null;
         var _loc4_:ConditionDependTechBean = null;
         for each(_loc3_ in param1.buildingsArray)
         {
            if(_loc3_.typeId == BuildingConstants.TYPE_BARRACK)
            {
               if(_loc3_.level > param2)
               {
                  return false;
               }
            }
            else if(!_loc3_.successFlag)
            {
               if(this.getBuildingsCountByTypeAndLvl(_loc3_.typeId,_loc3_.level) == 0)
               {
                  return false;
               }
            }
         }
         for each(_loc4_ in param1.techsArray)
         {
            if(!_loc4_.successFlag)
            {
               if(!this.isResearchAtLevel(_loc4_.id,_loc4_.level))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function doAutoUseTruce(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:String = null;
         var _loc7_:ItemBean = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc6_ = "truce_agreement";
         _loc7_ = this.getItemFromName(_loc6_);
         if(_loc7_ == null || _loc7_.count < 1)
         {
            return;
         }
         if(!playerTimingAllowed("usetruce",300,true))
         {
            return;
         }
         if(this.autoItems[_loc6_] == undefined)
         {
            return;
         }
         _loc8_ = -1;
         _loc8_ = this.getBuffIndexFromTypeId("PlayerPeaceBuff");
         if(_loc8_ != -1 && Utils.getServerTime() < this.player.buffsArray[_loc8_].endTime)
         {
            return;
         }
         _loc8_ = this.getBuffIndexFromTypeId("PlayerPeaceCoolDownBuff");
         if(_loc8_ != -1 && Utils.getServerTime() < this.player.buffsArray[_loc8_].endTime)
         {
            if(playerTimingAllowed("trucecooldown",600))
            {
               this.logMsg("<i>Truce: cooldown for " + Utils.formatTime((this.player.buffsArray[_loc8_].endTime - Utils.getServerTime()) / 1000) + " hours</i>","#CC8822");
            }
            return;
         }
         _loc9_ = "";
         _loc10_ = int(this.autoItems[_loc6_][0]);
         _loc11_ = int(this.autoItems[_loc6_][1]);
         if(param1 <= _loc10_)
         {
            _loc9_ = "loyalty " + param1;
         }
         else if(_loc11_ == 1 && param5)
         {
            _loc9_ = "successful enemy attack";
         }
         else if(_loc11_ == 2 && param4)
         {
            _loc9_ = "incoming enemy attack";
         }
         else if(_loc11_ == 3 && param3)
         {
            _loc9_ = "successful enemy scout";
         }
         else
         {
            if(!(_loc11_ == 4 && param2))
            {
               return;
            }
            _loc9_ = "enemy scout";
         }
         if(playerTimingAllowed("usetruce",300))
         {
            this.logMsg("<b>AUTOUSEITEMS > <i>Using item Truce Agreement on " + _loc9_ + "</i></b>","#CC8822");
            ActionFactory.getInstance().getCityCommands().setStopWarState(Items.getItemId(_loc6_),LoginHelper.getInstance().getHashedEvonyPw(),this.handleCommandResponse);
            --_loc7_.count;
         }
      }
      
      public function _populate_G_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:AvailableResearchListBean = null;
         if(this.gears == null)
         {
            param1.removeAll();
            return;
         }
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         _loc4_ = {
            "equipment.tech.upgrade.1":this.city.getItem("equipment.tech.upgrade.1").count,
            "equipment.tech.upgrade.2":this.city.getItem("equipment.tech.upgrade.2").count,
            "equipment.tech.upgrade.3":this.city.getItem("equipment.tech.upgrade.3").count,
            "equipment.tech.upgrade.4":this.city.getItem("equipment.tech.upgrade.4").count,
            "equipment.tech.upgrade.5":this.city.getItem("equipment.tech.upgrade.5").count,
            "equipment.tech.upgrade.book1":this.city.getItem("equipment.tech.upgrade.book1").count
         };
         _loc5_ = {
            "equipment.tech.upgrade.1":Items.getItemName("equipment.tech.upgrade.1").split("_").join(" "),
            "equipment.tech.upgrade.2":Items.getItemName("equipment.tech.upgrade.2").split("_").join(" "),
            "equipment.tech.upgrade.3":Items.getItemName("equipment.tech.upgrade.3").split("_").join(" "),
            "equipment.tech.upgrade.4":Items.getItemName("equipment.tech.upgrade.4").split("_").join(" "),
            "equipment.tech.upgrade.5":Items.getItemName("equipment.tech.upgrade.5").split("_").join(" "),
            "equipment.tech.upgrade.book1":Items.getItemName("equipment.tech.upgrade.book1").split("_").join(" ")
         };
         _loc6_ = new Object();
         _loc6_["" + BuildingConstants.TYPE_WORKSHOP] = this.getBuildingLevel(BuildingConstants.TYPE_WORKSHOP);
         _loc6_["" + BuildingConstants.TYPE_BLACKSMITH] = this.getBuildingLevel(BuildingConstants.TYPE_BLACKSMITH);
         _loc6_["" + BuildingConstants.TYPE_STABLE] = this.getBuildingLevel(BuildingConstants.TYPE_STABLE);
         _loc6_["" + BuildingConstants.TYPE_MARKET] = this.getBuildingLevel(BuildingConstants.TYPE_MARKET);
         for each(_loc7_ in this.gears)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = GearType.toNameString(_loc7_.typeId) + "  (" + GearType.toAbbrString(_loc7_.typeId) + ")";
            _loc3_.col2 = _loc7_.avalevel + "/" + _loc7_.level;
            _loc3_.col3 = _loc7_.typeId != EquipmentTech.MOUNTS_TECH ? "" + _loc7_.enhancedstarlv : "";
            _loc3_.col4 = _loc7_.typeId != EquipmentTech.MOUNTS_TECH ? "+" + Utils.fixNumber((_loc7_.avalevel + GEARING_BONUSES[_loc7_.enhancedstarlv]) * (_loc7_.typeId == EquipmentTech.RING_TECH || _loc7_.typeId == EquipmentTech.ACCESSORIES_TECH ? 2 : 1)) : "";
            _loc3_.col5 = _loc7_.upgradeing ? Utils.formatEndTime(_loc7_.endTime) : "";
            _loc3_.col6 = _loc7_.typeId;
            _loc3_.col7 = _loc7_.level < 10;
            _loc3_.col8 = !_loc7_.upgradeing && _loc7_.level < 10 && this.hasItemsForGearUpgrade(_loc7_,_loc4_) && this.hasBuildingsForGearUpgrade(_loc7_,_loc6_);
            _loc3_.col9 = !!_loc3_.col8 ? "Click to upgrade " + GearType.toNameString(_loc7_.typeId) + this.upgradeCost(_loc7_,_loc4_,_loc5_) : (_loc7_.upgradeing ? GearType.toNameString(_loc7_.typeId) + " is on upgrade cooldown.\nNext upgrade requirements will be" + this.upgradeNeeds(_loc7_,_loc4_,_loc5_,_loc6_) : "Requirements for upgrading " + GearType.toNameString(_loc7_.typeId) + " not met" + this.upgradeNeeds(_loc7_,_loc4_,_loc5_,_loc6_));
            _loc2_.addItem(_loc3_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function _jp343(param1:Boolean, param2:Boolean) : Boolean
      {
         if(!this.isMarketReady() || this._kn913(1))
         {
            return false;
         }
         return this._mf676(false,param1,param2);
      }
      
      private function setInsideBuildingBeans(param1:AvailableBuilingListResponse) : void
      {
         if(param1.ok == 1)
         {
            this.insideBuildingBeans = param1.builingListArray;
         }
      }
      
      private function _ps903(param1:TradeBean, param2:int, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this.market[param1.resType] == null)
         {
            return;
         }
         _loc4_ = param1.amount - param1.dealedAmount;
         if(!param3 && param1.price <= this._hf650(param1.resType) && param2 < _loc4_ * 2)
         {
            return;
         }
         _loc5_ = Math.random() * 0.1 + 0.1;
         _loc6_ = this.getTrimmedMarketPrice(this.getHighestBidOffer(param1.resType) * _loc5_ + this._hf650(param1.resType) * (1 - _loc5_));
         if(param3 || this._hf650(param1.resType) < 1.05 * this.getHighestBidOffer(param1.resType))
         {
            _loc6_ = this.getHighestBidOffer(param1.resType);
         }
         if(this.estResource.gold < 0.005 * _loc6_ * (_loc4_ + param2))
         {
            return;
         }
         if(!param3 && _loc6_ < param1.price * 0.8 && !this.cityTimingAllowed("priceswing",300))
         {
            return;
         }
         if(!this.cityTimingAllowed("modify",60))
         {
            return;
         }
         this.logMsg("TRADE > Cancel sell " + resourceNames[param1.resType] + ": " + _loc4_ + "@" + param1.price + ", range: " + this.getHighestBidOffer(param1.resType) + "-" + this._hf650(param1.resType),COLR_STD_LOG_MSG);
         CityStateCommands.cancelTrade(this.castleId,param1.id,this._og999);
         this.estResource[resourceIntNames[param1.resType]] += _loc4_;
      }
      
      private function _jk900() : FieldBean
      {
         var _loc1_:FieldBean = null;
         var _loc2_:int = 0;
         var _loc3_:FieldBean = null;
         if(this.fields.length == 0)
         {
            return null;
         }
         _loc1_ = null;
         _loc2_ = this.getCfgBuildNpc();
         for each(_loc3_ in this.fields)
         {
            if(_loc3_.id != buildCityLocation)
            {
               if(!(_loc3_.type == FieldConstants.TYPE_FLAT && this.flatOkayForBuildnpc(_loc3_.id,_loc3_.level)))
               {
                  if(!(_loc3_.type == FieldConstants.TYPE_FLAT && Map.fieldDistance(_loc3_.id,this.castle.fieldId) <= this.getCfg(CityConfigs.CFG_FLATROLLING)))
                  {
                     if(!(_loc3_.type == FieldConstants.TYPE_FLAT && this.levelOkayForBuildnpc(_loc3_.level,_loc2_)))
                     {
                        if(_loc1_ == null)
                        {
                           _loc1_ = _loc3_;
                        }
                        else if(this._bv514(_loc3_.type))
                        {
                           if(this._bv514(_loc1_.type))
                           {
                              if(_loc3_.level < _loc1_.level)
                              {
                                 _loc1_ = _loc3_;
                              }
                           }
                        }
                        else if(this._bv514(_loc1_.type))
                        {
                           _loc1_ = _loc3_;
                        }
                        else if(_loc3_.level < _loc1_.level)
                        {
                           _loc1_ = _loc3_;
                        }
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function _lk746(param1:XMLList) : Boolean
      {
         var _loc2_:XML = null;
         if(param1.length() == 0)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(int(_loc2_.@typeId) != TFConstants.T_SCOUTER)
            {
               if(!Utils.hasValue(_loc2_.@count))
               {
                  return false;
               }
               if(int(_loc2_.@count) > 0)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function _printLocalBuffs() : void
      {
         var _loc1_:String = null;
         var _loc2_:BuffBean = null;
         _loc1_ = "";
         for each(_loc2_ in this.castle.buffsArray)
         {
            if(_loc2_ != null)
            {
               _loc1_ += (_loc1_ != "" ? "\n" : "") + "<u>" + _loc2_.typeId + "</u>: <i>" + _loc2_.descName + "</i>  <b>remain time</b>: " + Utils.formatTime((_loc2_.endTime - Utils.getServerTime()) / 1000);
            }
         }
         if(_loc1_ != "")
         {
            this.logMsg("<b>Current Castle Buffs</b>:\n" + _loc1_,"#225555");
         }
         else
         {
            this.logMsg("<i>No Castle Buffs</i>","#225555");
         }
      }
      
      private function getTroopForQFarmNpc10() : TroopBean
      {
         var _loc1_:TroopBean = null;
         if(this.npc10TroopBean != null)
         {
            return this.npc10TroopBean;
         }
         _loc1_ = new TroopBean();
         _loc1_.peasants = 2000;
         _loc1_.militia = 2000;
         _loc1_.scouter = 4000;
         _loc1_.swordsmen = 1;
         _loc1_.pikemen = 1;
         _loc1_.archer = 90098;
         _loc1_.carriage = 1900;
         return _loc1_;
      }
      
      public function get heroes() : ArrayCollection
      {
         return this.castle.herosArray;
      }
      
      public function getTROOPPERLEVEL() : int
      {
         return this.TROOPPERLEVEL;
      }
      
      private function _cj980(param1:TradeListResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("get trade list response error " + param1.errorMsg);
            return;
         }
         this.tradesArray = param1.tradesArray;
      }
      
      public function _setEnemyWarningIgnoreLists(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         _loc2_ = Utils.trim(param1).split(",");
         if(_loc2_.length > 0)
         {
            _loc3_ = null;
            for each(_loc4_ in _loc2_)
            {
               _loc3_ = _loc4_.split(":");
               if(_loc3_[0].substr(0,1) == "a")
               {
                  this.enemyWarningAllianceIgnoreList.push(_loc3_[1]);
               }
               else
               {
                  if(_loc3_[0].substr(0,1) != "p")
                  {
                     this.logMsg("*** ERROR: The warreportignorelist goal has encountered an invalid type of " + _loc3_[0] + " or is formatted incorrectly. Valid types are <b>a</b>roup or <b>p</b>layer ***",COLR_ERR_LOG_MSG);
                     this.skypeWarreportReceiverList = new Array();
                     return false;
                  }
                  this.enemyWarningPlayerIgnoreList.push(_loc3_[1]);
               }
            }
            if(this.enemyWarningAllianceIgnoreList.length == 0 && this.enemyWarningPlayerIgnoreList.length == 0)
            {
               this.logMsg("*** ERROR: The warreportignorelist goal has no discernible list of players/alliances or is formatted incorrectly ***",COLR_ERR_LOG_MSG);
               return false;
            }
            return true;
         }
         this.logMsg("*** WARNING: The warreportignorelist goal has no list of players/alliances, ignoring the goal ***",COLR_WRN_LOG_MSG);
         return true;
      }
      
      private function doLowerLoyalty() : void
      {
         var _loc1_:int = 0;
         if(this.resource.support >= 20 && this.cityTimingAllowed("levy",905))
         {
            this.logMsg("ABANDON > Lower loyalty: Levy food to lower loyalty",COLR_ERR_LOG_MSG);
            CityStateCommands.taxation(this.castleId,2);
         }
         _loc1_ = 100 - int((this.resource.support + 9) / 20) * 20 - this.resource.complaint;
         if(this.resource.texRate != _loc1_ && this.cityTimingAllowed("taxrate",3))
         {
            this.logMsg("ABANDON > Lower loyalty: set tax rate to " + _loc1_,COLR_ERR_LOG_MSG);
            CityStateCommands.modifyTaxRate(this.castleId,_loc1_);
         }
      }
      
      private function _mj464() : void
      {
         var _loc1_:Array = null;
         var _loc2_:FortificationsBean = null;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(this.fortificationsRequirements.length == 0)
         {
            return;
         }
         if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_WALL,1) == 0)
         {
            return;
         }
         if(this.fortificationProduceQueue == null)
         {
            return;
         }
         if(this.fortificationProduceQueue.length == 0)
         {
            return;
         }
         _loc1_ = new Array(TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL,TFConstants.F_ARROWTOWER);
         _loc2_ = this.getFortificationsInProduction();
         for each(_loc3_ in this.fortificationsRequirements)
         {
            _loc4_ = 0;
            for each(_loc4_ in _loc1_)
            {
               if(this._isEnoughResoToProduceFort(_loc4_,0))
               {
                  if(this.fortification[troopIntNames[_loc4_]] + _loc2_[troopIntNames[_loc4_]] < _loc3_[troopIntNames[_loc4_]])
                  {
                     this.fortificationsRequirement = _loc3_;
                     return;
                  }
               }
            }
         }
         this.fortificationsRequirement = null;
      }
      
      private function _ay1045() : Boolean
      {
         var _loc1_:ArmyBean = null;
         _loc1_ = null;
         if(this.currentSneakEnemy == null || this.currentSneakEnemy.armyId != _loc1_.armyId)
         {
            this.lastSneakEnemy = this.currentSneakEnemy;
            this.currentSneakEnemy = _loc1_;
         }
         if(this.enemyArmies.length == 0)
         {
            return false;
         }
         _loc1_ = this.enemyArmies[0];
         if(this.lastSneakEnemy != null && this.lastSneakEnemy.armyId != _loc1_.armyId && _loc1_.reachTime - this.lastSneakEnemy.reachTime < 1500)
         {
            return false;
         }
         if(this.cityTimingAllowed("changeSneakFlag",30))
         {
            this.sneakFlag = Math.random() > 0.2;
         }
         if(!this.sneakFlag)
         {
            return false;
         }
         return this._le1009();
      }
      
      private function getBestIdleHeroByTypeAndStamina(param1:String, param2:int = -1) : HeroBean
      {
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         if(param2 == -1)
         {
            param2 = this.getMinEnergyCfg();
         }
         _loc3_ = null;
         for each(_loc4_ in this.heroes)
         {
            if(_loc4_.stamina >= param2)
            {
               if(!(_loc4_.status != HeroConstants.HERO_FREE_STATU && _loc4_.status != HeroConstants.HERO_CHIEF_STATU))
               {
                  if(_loc3_ == null || this.isBestHeroByType(param1,_loc4_,_loc3_))
                  {
                     _loc3_ = _loc4_;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function _mi60(param1:CityCondition) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BuildingBean = null;
         var _loc6_:int = 0;
         if(!param1.isBuilding)
         {
            return false;
         }
         _loc2_ = 0;
         _loc3_ = 0;
         _loc4_ = 0;
         for each(_loc5_ in this.buildings)
         {
            if(_loc5_.typeId == param1.typeId)
            {
               _loc4_ = _loc5_.status != BuildingConstants.STATUS_UPGRADING ? (_loc5_.status != BuildingConstants.STATUS_DESTRUCTING ? _loc5_.level : _loc5_.level - 1) : _loc5_.level + 1;
               if(_loc4_ != _loc5_.level)
               {
                  _loc2_++;
               }
               if(param1.level == 0)
               {
                  if(_loc4_ > 0)
                  {
                     _loc3_++;
                  }
               }
               else if(_loc4_ >= param1.level)
               {
                  _loc3_++;
               }
            }
         }
         _loc6_ = this.getBuildingsCountByTypeAndLvl(param1.typeId,1);
         if(param1.level == 0)
         {
            return _loc6_ == _loc2_ || _loc3_ <= param1.count;
         }
         if(_loc3_ >= param1.count)
         {
            return true;
         }
         if(_loc6_ < param1.count && this.getNextAvailablePositionForBuildingType(param1.typeId) != -1000)
         {
            return false;
         }
         if(_loc6_ != _loc2_)
         {
            return false;
         }
         return true;
      }
      
      private function getHighestBidOffer(param1:int) : Number
      {
         if(this.market[param1] == null || this.market[param1].buyersArray.length == 0)
         {
            return 0.01;
         }
         return this.market[param1].buyersArray[0].price;
      }
      
      private function _rr420(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:ArmyBean = null;
         _loc2_ = 0;
         for each(_loc3_ in this.selfArmies)
         {
            if(_loc3_.startFieldId == this.castle.fieldId)
            {
               if(!(param1 != -1 && Map.getLevel(_loc3_.targetFieldId) != param1))
               {
                  if(Map.getType(_loc3_.targetFieldId) == FieldConstants.TYPE_NPC)
                  {
                     _loc2_++;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function setTroopListArray(param1:TroopProduceListResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("troop produce list error: " + param1.errorMsg);
            return;
         }
         if(this.troopListArray.length == 0)
         {
            this.troopListArray = param1.troopListArray;
         }
      }
      
      private function _fa571() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:FieldBean = null;
         if(this.distanceSettings[DISTANCE_HUNTING] <= 0)
         {
            this.distanceSettings[DISTANCE_HUNTING] = 10;
         }
         if(this.distanceSettings[DISTANCE_BUILDNPC] <= 0)
         {
            this.distanceSettings[DISTANCE_BUILDNPC] = 10;
         }
         if(this.distanceSettings[DISTANCE_BUILDNPC10] <= 0)
         {
            this.distanceSettings[DISTANCE_BUILDNPC10] = 3;
         }
         _loc1_ = Map.getX(this.castle.fieldId);
         _loc2_ = Map.getY(this.castle.fieldId);
         if(!Map.isMapReady(_loc1_,_loc2_,_loc8_))
         {
            return;
         }
         _loc3_ = int(this.distanceSettings[DISTANCE_HUNTING]);
         _loc4_ = int(this.distanceSettings[DISTANCE_BUILDNPC]);
         _loc5_ = int(this.distanceSettings[DISTANCE_BUILDNPC10]);
         _loc6_ = Math.min(_loc4_,_loc5_);
         _loc7_ = Math.max(_loc4_,_loc5_);
         _loc8_ = Math.max(_loc3_,_loc7_);
         _loc9_ = Math.max(this.getCfg(CityConfigs.CFG_HUNTING),this.getCfg(CityConfigs.CFG_SLOWHUNTING));
         _loc10_ = this.huntingType == null ? "" : this.huntingType.join(" ");
         if(!playerTimingAllowed("rescanfields",3600) && this.candidateFlatFields != null && this.candidateLocalFields != null)
         {
            if(this.lastSearchHuntingLevel == _loc9_ && this.lastSearchHuntingTypeStr == _loc10_ && this.lastSearchFlatLevel == this.getCfg(CityConfigs.CFG_BUILDNPC))
            {
               return;
            }
         }
         this.lastSearchHuntingLevel = _loc9_;
         this.lastSearchFlatLevel = this.getCfg(CityConfigs.CFG_BUILDNPC);
         this.lastSearchHuntingTypeStr = _loc10_;
         this.candidateLocalFields = new Array();
         this.candidateFlatFields = new Array();
         this.localFieldsDetailInfo.removeAll();
         this.flatFieldsDetailInfo.removeAll();
         _loc11_ = 0;
         _loc12_ = 0;
         if(this.lastSearchHuntingLevel <= 0)
         {
            _loc12_ = 0;
            _loc11_ = 0;
         }
         else if(this.lastSearchHuntingLevel == 1)
         {
            _loc11_ = 2;
            _loc12_ = 3;
         }
         else if(this.lastSearchHuntingLevel == 2)
         {
            _loc11_ = 4;
            _loc12_ = 6;
         }
         else if(this.lastSearchHuntingLevel == 3)
         {
            _loc11_ = 7;
            _loc12_ = 9;
         }
         else if(this.lastSearchHuntingLevel == 4)
         {
            _loc11_ = 9;
            _loc12_ = 10;
         }
         else
         {
            _loc11_ = 10;
            _loc12_ = 10;
         }
         _loc13_ = this.getCfgBuildNpc();
         _loc14_ = 0;
         _loc15_ = 0;
         _loc16_ = 0;
         _loc17_ = 0;
         _loc18_ = 0;
         _loc19_ = _loc1_ - _loc8_;
         while(_loc19_ <= _loc1_ + _loc8_)
         {
            _loc14_ = _loc2_ - _loc8_;
            while(_loc14_ <= _loc2_ + _loc8_)
            {
               _loc15_ = Map.getFieldId(_loc19_,_loc14_);
               _loc16_ = Map.getType(_loc15_);
               _loc17_ = Map.getLevel(_loc15_);
               _loc18_ = (_loc19_ - _loc1_) * (_loc19_ - _loc1_) + (_loc14_ - _loc2_) * (_loc14_ - _loc2_);
               if(_loc18_ <= _loc7_ * _loc7_)
               {
                  if(this.levelOkayForBuildnpc(_loc17_,_loc13_) && _loc16_ == FieldConstants.TYPE_FLAT)
                  {
                     if(_loc13_ == 15)
                     {
                        if(_loc17_ == 10 && _loc18_ <= _loc6_ * _loc6_)
                        {
                           this.candidateFlatFields.push(_loc15_);
                        }
                        else if(_loc17_ == 5 && _loc18_ > _loc6_ * _loc6_)
                        {
                           this.candidateFlatFields.push(_loc15_);
                        }
                     }
                     else
                     {
                        this.candidateFlatFields.push(_loc15_);
                     }
                  }
               }
               if((_loc19_ - _loc1_) * (_loc19_ - _loc1_) + (_loc14_ - _loc2_) * (_loc14_ - _loc2_) <= _loc3_ * _loc3_)
               {
                  if(_loc17_ >= _loc11_ && _loc17_ <= _loc12_ && _loc16_ <= FieldConstants.TYPE_FLAT)
                  {
                     if(this.huntingType == null || this.huntingType.indexOf(_loc16_) != -1)
                     {
                        this.candidateLocalFields.push(_loc15_);
                     }
                  }
               }
               _loc14_++;
            }
            _loc19_++;
         }
         for each(_loc20_ in this.fields)
         {
            if(_loc20_.level >= _loc11_ && _loc20_.level <= _loc12_ && _loc20_.type == _loc16_)
            {
               this.candidateLocalFields.push(_loc20_.id);
            }
         }
         this.candidateLocalFields.sort(this.sortByLevelAndDistance);
         this.candidateFlatFields.sort(this.byDistanceFromCastle);
         this.currentSlowTarget = -1;
         if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > *** Found " + this.candidateFlatFields.length + " FLATS for BUILDNPC:" + _loc13_ + " within " + _loc4_ + " miles ***",COLR_DBG_LOG_MSG);
         }
      }
      
      private function _bs524() : Boolean
      {
         var _loc1_:NewArmyParam = null;
         var _loc2_:CityState = null;
         if(this.troop.scouter < 2)
         {
            return false;
         }
         _loc1_ = null;
         for each(_loc2_ in MainScreen.getCities())
         {
            if(_loc2_.cityManager._ut946())
            {
               if(this.getUsedRallySlots() >= this.getMaxRallySlots())
               {
                  return false;
               }
               _loc1_ = new NewArmyParam();
               _loc1_.missionType = ObjConstants.ARMY_MISSION_SEND;
               _loc1_.targetPoint = _loc2_.castle.fieldId;
               _loc1_.troops = new TroopBean();
               _loc1_.troops.scouter = 1;
               _loc1_.resource = new ResourceBean();
               if(!this.isEnoughResourcesToMarch(_loc1_))
               {
                  return false;
               }
               if(playerTimingAllowed("rescuehero" + _loc2_.castle.fieldId,5 * 60))
               {
                  this.logMsg("Rescue training hero at " + _loc2_.castle.name + " " + Map.fieldIdToCoordString(_loc2_.castle.fieldId) + " by sending s:1, arriving in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc1_)),COLR_STD_LOG_MSG);
                  CityStateCommands.newArmy(this.castleId,_loc1_,this.handleArmyCommandResponse);
                  return true;
               }
            }
         }
         return false;
      }
      
      private function _uu581() : void
      {
         var _loc1_:BuildingBean = null;
         if(this.getCfg(CityConfigs.CFG_BUILDING) <= 0)
         {
            return;
         }
         if(BuildingManager.getInstance().isLastUpgradeTimeLessThan5min())
         {
            return;
         }
         for each(_loc1_ in this.buildings)
         {
            if(!(_loc1_.status != 0 || _loc1_.level == 0))
            {
               if(!this.isBuildingAlreadyMaxLevel(_loc1_))
               {
                  if(BuildingManager.getInstance().getCachedUpgradeCondition(_loc1_.typeId,_loc1_.level) == null)
                  {
                     BuildingManager.getInstance().checkOutUpgrade(this.castleId,_loc1_);
                  }
               }
            }
         }
      }
      
      public function _scrEndFieldAttack() : void
      {
         this.logMsg("End attacking enemy fields");
         this.fieldTargetEnemyAlliances = null;
      }
      
      private function _re1134() : Boolean
      {
         var _loc1_:MapCastleBean = null;
         var _loc2_:NewArmyParam = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.evacuationTown == -1)
         {
            return false;
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         _loc1_ = Map.getDetail(this.evacuationTown);
         if(_loc1_ == null)
         {
            return false;
         }
         if(Map.getType(this.evacuationTown) == -1)
         {
            return false;
         }
         if(_loc1_.userName != this.player.playerInfo.userName || Map.getType(this.evacuationTown) != FieldConstants.TYPE_CASTLE)
         {
            this.logMsg("Bad destination for evacuation: " + Map.fieldIdToCoordString(this.evacuationTown));
            this.evacuationTown = -1;
            return false;
         }
         _loc2_ = new NewArmyParam();
         _loc2_.missionType = ObjConstants.ARMY_MISSION_SEND;
         _loc2_.troops = new TroopBean();
         _loc2_.resource = new ResourceBean();
         _loc2_.targetPoint = this.evacuationTown;
         _loc3_ = this.getRallyDispatchPerArmyLimit(true);
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
         for each(_loc8_ in [TFConstants.T_SCOUTER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_MILITIA,TFConstants.T_PEASANTS,TFConstants.T_CARRIAGE,TFConstants.T_BALLISTA,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT])
         {
            if(_loc3_ == 0)
            {
               break;
            }
            _loc5_ = _loc8_ == TFConstants.T_SCOUTER ? 10 : (_loc8_ == TFConstants.T_CARRIAGE ? this.getRallyDispatchPerArmyLimit(true) : 0);
            _loc6_ = Math.max(0,this.troop[troopIntNames[_loc8_]] - _loc5_);
            _loc7_ = Math.min(_loc3_,_loc6_);
            _loc2_.troops[troopIntNames[_loc8_]] = _loc7_;
            _loc3_ -= _loc7_;
            _loc4_ += _loc7_;
         }
         if(_loc4_ == 0)
         {
            return false;
         }
         if(!this.isEnoughResourcesToMarch(_loc2_))
         {
            this.logMsg("Not enough resource to evacuate to: " + Map.fieldIdToCoordString(this.evacuationTown));
            this.evacuationTown = -1;
            return false;
         }
         this.logMsg("Evacuate to " + Map.fieldIdToString(this.evacuationTown) + " with " + Utils.troopBeanToString(_loc2_.troops) + ", arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc2_)));
         CityStateCommands.newArmy(this.castleId,_loc2_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc2_);
         return true;
      }
      
      public function isBuildingQueueAvailable() : Boolean
      {
         var _loc1_:* = false;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:BuildingBean = null;
         _loc1_ = Utils.getServerTime() - this.player.playerInfo.createrTime < 72 * 3600 * 1000;
         _loc2_ = this.getBuffIndexFromTypeId("DoubleBuildQueueBuff");
         _loc3_ = _loc2_ != -1 && Utils.getServerTime() < this.player.buffsArray[_loc2_].endTime;
         if(!_loc1_ && !_loc3_)
         {
            return this._getCurrentConstruction() == null;
         }
         _loc4_ = 0;
         for each(_loc5_ in this.buildings)
         {
            if(_loc5_.status != 0)
            {
               _loc4_++;
            }
         }
         return _loc4_ < 2;
      }
      
      private function getWorstCapturedHero() : HeroBean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:HeroBean = null;
         _loc1_ = null;
         for each(_loc2_ in this.heroes)
         {
            if(!(_loc2_.ability > 0 || _loc2_.isHero > 0))
            {
               if(_loc2_.status == HeroConstants.HERO_SEIZED_STATU)
               {
                  if(_loc1_ == null || Utils.isWorstHeroByType("power",_loc1_,_loc2_))
                  {
                     _loc1_ = _loc2_;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function _uh177(param1:Number) : int
      {
         var _loc2_:int = 0;
         var _loc3_:ArmyBean = null;
         var _loc4_:TroopBean = null;
         var _loc5_:int = 0;
         _loc2_ = 0;
         _loc3_ = null;
         _loc4_ = null;
         _loc5_ = 0;
         while(_loc5_ < this.enemyArmies.length)
         {
            _loc3_ = this.enemyArmies[_loc5_];
            if(_loc3_.reachTime > param1)
            {
               break;
            }
            _loc4_ = Utils.getTroopBeanFromTroopStrBean(_loc3_.troop);
            if(_loc4_ != null)
            {
               _loc2_ += Utils.getTotalTroopCount(_loc4_) + 3 * _loc4_.ballista + 4 * _loc4_.catapult;
            }
            else
            {
               _loc2_ += 125000;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function updateInn() : void
      {
         if(this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) > 0)
         {
            CityStateCommands.getHerosListFromTavern(this.castleId,this._updateInnHandler);
         }
      }
      
      private function _lb710(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:ArmyBean = null;
         _loc2_ = 0;
         for each(_loc3_ in this.selfArmies)
         {
            if(_loc3_.startFieldId == this.castle.fieldId && param1 == _loc3_.targetFieldId)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function _mb759(param1:int) : ConditionBean
      {
         var _loc2_:TroopProduceListBean = null;
         for each(_loc2_ in this.troopListArray)
         {
            if(_loc2_.typeId == param1)
            {
               return _loc2_.conditionBean;
            }
         }
         return null;
      }
      
      private function cityTimingAllowed(param1:String, param2:int, param3:Boolean = false) : Boolean
      {
         if(this.cityTimingList[param1] == undefined || new Date().getTime() - (this.cityTimingList[param1] as Date).getTime() > param2 * THOUSAND)
         {
            if(!param3)
            {
               this.cityTimingList[param1] = new Date();
            }
            return true;
         }
         return false;
      }
      
      public function _manager() : void
      {
         var task:String = null;
         var func:Function = null;
         var troopSent:Boolean = false;
         var ready:Boolean = false;
         var restriction:int = 0;
         var isTruce:Boolean = false;
         var extraSlot:int = 0;
         var transferPriority:Boolean = false;
         var hasRallySlot:Boolean = false;
         var availHeroCount:int = 0;
         var hasHeroSlot:Boolean = false;
         task = "none";
         func = null;
         this.promoteCount = 0;
         try
         {
            task = "delayInit";
            func = function():void
            {
               if(furtherInitNeeded)
               {
                  delayedInit();
                  furtherInitNeeded = false;
               }
            };
            this.doTask(task,func);
            task = "estimate resource";
            func = function():void
            {
               doEstimateResource();
            };
            this.doTask(task,func);
            task = "idle update";
            func = function():void
            {
               doIdleUpdate();
            };
            this.doTask(task,func);
            task = "enemy warning";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_ENEMYWARNING) > 0)
               {
                  doEnemyWarning();
               }
            };
            this.doTask(task,func);
            task = "handle trading";
            func = function():void
            {
               doTrade();
            };
            this.doTask(task,func);
            task = "update building and research requirement";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_BUILDING) > 0 || getCfg(CityConfigs.CFG_RESEARCH) > 0)
               {
                  updateBuildingAndResearchReqs();
               }
            };
            this.doTask(task,func);
            task = "handle building";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_BUILDING) > 0)
               {
                  doBuilding();
               }
            };
            this.doTask(task,func);
            task = "handle research";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_RESEARCH) > 0)
               {
                  doResearch();
               }
            };
            this.doTask(task,func);
            task = "handle comfort";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_COMFORT) > 0)
               {
                  doComfort();
               }
            };
            this.doTask(task,func);
            task = "manage heroes";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_HERO) > 0)
               {
                  doHeroManagement();
               }
            };
            this.doTask(task,func);
            task = "autogear";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_AUTOGEAR) > 0 && isGearAvailable())
               {
                  processAutoGear();
               }
            };
            this.doTask(task,func);
            if(this.getCfg(CityConfigs.CFG_FORTIFICATION) > 0)
            {
               task = "update fortification requirement";
               func = function():void
               {
                  _mj464();
               };
               this.doTask(task,func);
               task = "fortification production";
               func = function():void
               {
                  if(_rm721())
                  {
                     fortificationProductionUpdateNeeded = true;
                  }
               };
               this.doTask(task,func);
            }
            if(this.getCfg(CityConfigs.CFG_TROOP) > 0 && this.researches != null)
            {
               task = "update troop requirement";
               func = function():void
               {
                  updateTroopRequirements();
               };
               this.doTask(task,func);
               task = "adjust idle population";
               func = function():void
               {
                  var _loc1_:int = 0;
                  _loc1_ = 0;
                  if(troopRequirement != null)
                  {
                     if(getCfg(CityConfigs.CFG_TROOP) > 0)
                     {
                        _loc1_ += _mp684(2,900);
                     }
                     if(getCfg(CityConfigs.CFG_DUMPING) > 0 && getBestIdleTrainingHero() != null)
                     {
                        _loc1_ += _mp684(10,3 * 3600 * getCfg(CityConfigs.CFG_DUMPING));
                     }
                  }
                  if(_loc1_ != 0)
                  {
                     _loc1_ += resource.maxPopulation / 100;
                  }
                  if(_loc1_ < 50 && enemyArmies.length > 0 && enemyArmies[0].reachTime - Utils.getServerTime() < 3600 * 1000 && !isJunkTroop(enemyArmies[0].troop))
                  {
                     _loc1_ = 50;
                  }
                  setProductionRate(_loc1_);
               };
               this.doTask(task,func);
            }
            troopSent = false;
            ready = this.isMarketReady() || this.isMarketGovRestricted();
            this.trainingHeroNeeded = false;
            if(this.getCfg(CityConfigs.CFG_TROOP) > 0 && this.troopRequirement != null)
            {
               task = "troop production";
               func = function():void
               {
                  if(procedureToQueueTroops())
                  {
                     troopProductionUpdateNeeded = true;
                     if(trainingHeroName != null && getBestIdleTrainingHero() != null)
                     {
                        trainingHeroNeeded = true;
                     }
                  }
               };
               this.doTask(task,func);
            }
            task = "auto useitem";
            func = function():void
            {
               doAutoUseItems();
            };
            this.doTask(task,func);
            if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_POPULATION)
            {
               this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > About To Check Dumping " + (this.isMarketReady() || this.isMarketGovRestricted() ? "true" : "false") + " " + (this._kn913(1) ? "true" : "false"),COLR_DBG_LOG_MSG);
            }
            if(this.getCfg(CityConfigs.CFG_DUMPING) > 0 && (this.isMarketReady() || this.isMarketGovRestricted()) && this._kn913(1))
            {
               if(this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_POPULATION)
               {
                  this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Do Dumping",COLR_DBG_LOG_MSG);
               }
               task = "dump resource";
               func = function():void
               {
                  if(getCfg(CityConfigs.CFG_FORTIFICATION) > 0)
                  {
                     if(_ya433())
                     {
                        fortificationProductionUpdateNeeded = true;
                     }
                  }
                  if(getCfg(CityConfigs.CFG_TROOP) > 0 && troopRequirement != null)
                  {
                     if(doDumping())
                     {
                        troopProductionUpdateNeeded = true;
                        if(trainingHeroName != null && getBestIdleTrainingHero() != null)
                        {
                           trainingHeroNeeded = true;
                           troopSent = true;
                        }
                     }
                  }
               };
               this.doTask(task,func);
            }
            task = "search npcs";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_NPC) > 0 || npc10LimitTroopBean != null || priorityNpcSettings.length > 0)
               {
                  taskSearchLocalNPCs();
               }
            };
            this.doTask(task,func);
            task = "search resource field";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_VALLEY) > 0)
               {
                  taskSearchResourceFields();
               }
            };
            this.doTask(task,func);
            task = "search local field";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_HUNTING) > 0 || getCfg(CityConfigs.CFG_SLOWHUNTING) > 0 || getCfg(CityConfigs.CFG_BUILDNPC) > 0)
               {
                  _fa571();
               }
            };
            this.doTask(task,func);
            task = "return army";
            func = function():void
            {
               if(getCfg(CityConfigs.CFG_VALLEY) > 0 || getCfg(CityConfigs.CFG_HUNTING) > 0 || getCfg(CityConfigs.CFG_SLOWHUNTING) > 0 || getCfg(CityConfigs.CFG_BUILDNPC) > 0 || buildCityLocation != -1 || getCfg(CityConfigs.CFG_FLATROLLING) > 0)
               {
                  _uo129();
               }
            };
            this.doTask(task,func);
            restriction = this.getArmyMovementRestriction();
            isTruce = restriction == 1;
            if(restriction == 2)
            {
               troopSent = true;
            }
            if(this.getCfg(CityConfigs.CFG_ABANDON) == 1)
            {
               task = "abandon town";
               func = function():void
               {
                  _ad677();
               };
               this.doTask(task,func);
            }
            task = "evacuate troop";
            func = function():void
            {
               if(!troopSent && evacuationTown != -1)
               {
                  troopSent = _re1134();
               }
            };
            this.doTask(task,func);
            task = "evacuate resource";
            func = function():void
            {
               if(!troopSent && evacuationTown != -1 && !evacuateTroopOnly)
               {
                  troopSent = _lp530();
               }
            };
            this.doTask(task,func);
            task = "move training hero";
            func = function():void
            {
               if(!troopSent && isNextTrainingHeroStop())
               {
                  troopSent = moveTrainingHero();
               }
            };
            this.doTask(task,func);
            task = "emergencygold";
            func = function():void
            {
               if(!troopSent)
               {
                  troopSent = doRescueTownEmergencyGold();
               }
            };
            this.doTask(task,func);
            task = "rescuetown";
            func = function():void
            {
               if(!troopSent)
               {
                  troopSent = doRescueTownComfortReso();
               }
            };
            this.doTask(task,func);
            task = "rescuehero";
            func = function():void
            {
               if(!troopSent)
               {
                  troopSent = _bs524();
               }
            };
            this.doTask(task,func);
            if(this.fields.length == 0 && !this._ty399() && this.cityTimingAllowed("nofield",600))
            {
               this.logMsg("<i>Valleys are optional but recommended for defense.</i>","#79796A");
            }
            if(this.getCfg(CityConfigs.CFG_WARTOWN) > 0 && this.cityTimingAllowed("wartown",300))
            {
               this.logMsg("<i>War town setting is on</i>",COLR_ERR_LOG_MSG);
            }
            extraSlot = this.getAvailableRallyMaxHidingSlots() + this.getAvailableRallyMaxRainbowSlots();
            transferPriority = this.getLocalArmiesCount() + extraSlot > this.getMaxRallySlots() - 2;
            if(this.getUsedRallySlots() + extraSlot >= this.getMaxRallySlots())
            {
               troopSent = true;
            }
            hasRallySlot = this.getLocalArmiesCount() + extraSlot < this.getMaxRallySlots();
            availHeroCount = this.getTotalAvailableHeroes() + (this.getMayor() != null ? 1 : 0);
            hasHeroSlot = availHeroCount >= this.getAvailableRallyMaxHidingSlots() + 1;
            if(this.isWarTownOn())
            {
               task = "attack resource field for rainbow evacuation";
               func = function():void
               {
                  if(!troopSent && getCfg(CityConfigs.CFG_VALLEY) > 0 && fields.length == 0)
                  {
                     tskAttackResourceField(hasRallySlot,hasHeroSlot);
                  }
               };
               this.doTask(task,func);
               troopSent = true;
            }
            task = "pretransfer";
            if(transferPriority)
            {
               if(!troopSent)
               {
                  troopSent = this.doKeepTroopResoRequestHelp(hasRallySlot,hasHeroSlot);
               }
            }
            task = "build city";
            func = function():void
            {
               if(!troopSent && buildCityLocation != -1 && castle.fieldId == buildCityFrom)
               {
                  troopSent = _wf882();
               }
            };
            this.doTask(task,func);
            task = "build npc";
            func = function():void
            {
               if(!troopSent && getCfg(CityConfigs.CFG_BUILDNPC) > 0)
               {
                  troopSent = processBuildNpc(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "flat rolling";
            func = function():void
            {
               if(!troopSent && getCfg(CityConfigs.CFG_FLATROLLING) > 0)
               {
                  troopSent = _ci858(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "priority npc farming";
            func = function():void
            {
               if(buildNPCReady && !isTruce && !troopSent && hasHeroSlot)
               {
                  troopSent = _qk175();
               }
            };
            this.doTask(task,func);
            task = "attack npc 10";
            func = function():void
            {
               if(buildNPCReady && !isTruce && !troopSent && hasHeroSlot)
               {
                  troopSent = _bl67();
               }
            };
            this.doTask(task,func);
            task = "attack npc for resource";
            func = function():void
            {
               if(buildNPCReady && !isTruce && ready && !troopSent && getCfg(CityConfigs.CFG_NPC) > 0)
               {
                  troopSent = _jp343(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "attack resource field";
            func = function():void
            {
               if(!troopSent && hasHeroSlot && getCfg(CityConfigs.CFG_VALLEY) > 0)
               {
                  troopSent = tskAttackResourceField(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "attack local field";
            func = function():void
            {
               if(!troopSent && (getCfg(CityConfigs.CFG_HUNTING) > 0 || getCfg(CityConfigs.CFG_SLOWHUNTING)))
               {
                  troopSent = _rn509(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "attack npc for training/resource";
            func = function():void
            {
               if(buildNPCReady && !isTruce && !troopSent && getCfg(CityConfigs.CFG_NPC) > 0)
               {
                  troopSent = _ph1097(hasRallySlot,hasHeroSlot);
               }
            };
            this.doTask(task,func);
            task = "posttransfer";
            if(!transferPriority)
            {
               if(!troopSent)
               {
                  troopSent = this.doKeepTroopResoRequestHelp(hasRallySlot,hasHeroSlot);
               }
            }
            task = "post update";
            func = function():void
            {
               postUpdate();
            };
            this.doTask(task,func);
            task = "Check Alliance";
            func = function():void
            {
               if(varAllianceListDeny.length > 0)
               {
                  checkAlliance();
               }
            };
            this.doTask(task,func);
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Manager error while working on " + task + ": " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      private function updateMarket() : void
      {
         var _loc1_:Number = NaN;
         if(!this.isMainTown())
         {
            return;
         }
         if(Connection.getInstance().paused || this.isMarketGovRestricted())
         {
            lastMarketQueryTime = new Date();
            return;
         }
         if(currMarketInterest != -1)
         {
            _loc1_ = new Date().getTime() - lastMarketQueryTime.getTime();
            if(_loc1_ >= 60000)
            {
               if(_loc1_ > 300000)
               {
                  MasterTimer.getInstance().setNextActiveTime(300);
                  CityStateCommands.searchTrades(currMarketInterest,this.searchTradesHandler);
                  lastMarketQueryTime = new Date();
               }
               else
               {
                  MasterTimer.getInstance().setNextActiveTime();
               }
            }
            if(_loc1_ >= 60000)
            {
               if(playerTimingAllowed("recordExtraLagTime",60))
               {
                  lastMarketLagTimes.push(_loc1_ / 1000);
                  while(lastMarketLagTimes.length > 5)
                  {
                     lastMarketLagTimes.shift();
                  }
               }
            }
            return;
         }
         if(seedMarketInterest == 3 && !playerTimingAllowed("marketupdate",60))
         {
            return;
         }
         lastMarketQueryTime = new Date();
         seedMarketInterest = (seedMarketInterest + 1) % 4;
         currMarketInterest = seedMarketInterest;
         CityStateCommands.searchTrades(currMarketInterest,this.searchTradesHandler);
      }
      
      private function moveTrainingHero() : Boolean
      {
         var _loc1_:HeroBean = null;
         var _loc2_:CityManager = null;
         var _loc3_:CityState = null;
         var _loc4_:NewArmyParam = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:HeroBean = null;
         var _loc8_:CityManager = null;
         if(this.trainingHeroName == null || this.trainingHeroNeeded)
         {
            return false;
         }
         if(this.trainingHeroName != null && this.trainingHeroNextStop == -1)
         {
            this.CMCalculateHeroPath();
         }
         if(this.trainingHeroNextStop == this.castle.fieldId)
         {
            return false;
         }
         if(this.researches == null)
         {
            return false;
         }
         _loc1_ = this.getBestIdleTrainingHero();
         if(_loc1_ == null)
         {
            return false;
         }
         if(_loc1_.stamina < this.getMinEnergyCfg())
         {
            return false;
         }
         if(this.trainingHeroArrivalTime + this.trainingHeroMinStay * 1000 > Utils.getServerTime())
         {
            return false;
         }
         if(_loc1_.status != HeroConstants.HERO_CHIEF_STATU && _loc1_.status != HeroConstants.HERO_FREE_STATU)
         {
            return false;
         }
         if(this._dj1085())
         {
            this.trainingHeroNeeded = true;
            return false;
         }
         if(this.troop.scouter == 0)
         {
            return false;
         }
         if(this.getLocalArmiesCount() >= this.getMaxRallySlots())
         {
            return false;
         }
         _loc2_ = this;
         _loc3_ = null;
         while(true)
         {
            _loc3_ = MainScreen.getCityFromFieldId(_loc2_.trainingHeroNextStop);
            if(_loc3_ == null)
            {
               break;
            }
            _loc8_ = _loc3_.cityManager;
            if(_loc8_ == this)
            {
               return false;
            }
            if(_loc8_.trainingHeroNextStop == -1)
            {
               this.logMsg("TRAININGHERO > <i>Dead end for training hero at " + _loc8_.castle.name + "</i>",COLR_ERR_LOG_MSG);
               this.CMCalculateHeroPath();
               return false;
            }
            if(!Utils.isNameKingOrQueen(this.trainingHeroName) && _loc8_.heroes.length - _loc8_.specialHeroCount == _loc8_.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION))
            {
               this.logMsg("TRAININGHERO > <i>skip town " + _loc3_.castle.name + " due to full feasting hall</i>",COLR_ERR_LOG_MSG);
               _loc2_ = _loc8_;
            }
            else if(_loc8_.resource.support < 20 || _loc8_.resource.complaint > 60)
            {
               this.logMsg("TRAININGHERO > <i>skip town " + _loc3_.castle.name + " due to low loyalty or high grievance</i>",COLR_ERR_LOG_MSG);
               _loc2_ = _loc8_;
            }
            else if(_loc8_.getLocalBuffByWildCardId("ForceopenclosegateBuff") != null)
            {
               this.logMsg("TRAININGHERO > <i>skip town " + _loc3_.castle.name + " due to broken gate</i>",COLR_ERR_LOG_MSG);
               _loc2_ = _loc8_;
            }
            else
            {
               if(_loc2_.trainingHeroNextStop == this.castle.fieldId)
               {
                  return false;
               }
               _loc4_ = new NewArmyParam();
               _loc4_.missionType = ObjConstants.ARMY_MISSION_SEND;
               _loc4_.heroId = _loc1_.id;
               _loc4_.targetPoint = _loc2_.trainingHeroNextStop;
               _loc4_.troops = new TroopBean();
               _loc4_.troops.scouter = 1;
               _loc4_.resource = new ResourceBean();
               if(!this.isEnoughResourcesToMarch(_loc4_))
               {
                  this.logMsg("TRAININGHERO > <i>Not enough resource to move training hero</i>",COLR_ERR_LOG_MSG);
                  return false;
               }
               if(this.trainingLoopTime != -1 && !this._id1003() && this.cityTimingAllowed("badtrainingloop",300))
               {
                  this.logMsg("TRAININGHERO > <i>traininglooptime value is ignored -- traininghero does not stop here to uplevel</i>",COLR_ERR_LOG_MSG);
               }
               _loc5_ = this.trainingLoopTime == -1 ? 7200 : this.trainingLoopTime;
               _loc6_ = this._id1003() ? _loc5_ : 20;
               if(!playerTimingAllowed("movetraininghero",_loc6_))
               {
                  return false;
               }
               this.logMsg("TRAININGHERO > Move training hero to " + _loc3_.castle.name + " " + Map.fieldIdToCoordString(this.trainingHeroNextStop) + ", arriving in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc4_) / Utils.getHeroSpeedFactor(_loc1_)),COLR_STD_LOG_MSG);
               _loc7_ = this.bestIdlePoliticsHero(0);
               if(_loc7_ != null && _loc7_ != _loc1_)
               {
                  this.promoteBestPolHero();
               }
               else
               {
                  this.removeMayor();
               }
               CityStateCommands.newArmy(this.castleId,_loc4_,this.handleArmyCommandResponse);
               return true;
            }
         }
         this.logMsg("TRAININGHERO > <i>Invalid value of hero next stop for town " + _loc2_.castle.name + "</i>",COLR_ERR_LOG_MSG);
         this.CMCalculateHeroPath();
         return false;
      }
      
      private function onCancelRemoveResponse(param1:CommandResponse) : void
      {
         var _loc2_:String = null;
         _loc2_ = "";
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            _loc2_ = "An error occured while attempting to cancel the security code removal process:  " + param1.errorMsg;
         }
         else
         {
            _loc2_ = "The security code removal process has been cancelled sucessfully.";
         }
         this.logMsg(_loc2_,"#AA0000");
      }
      
      private function useAdvByHiddenPathHandler(param1:Object) : void
      {
         if(param1.ok != 1)
         {
            this.logMsg("Error received while auto using Advance_by_a_Hidden_Path - response: " + param1.errorMsg,COLR_WRN_LOG_MSG);
         }
         else
         {
            this._clearLastAmbushErrorTime();
            this.logMsg("Successfully applied Advance_by_a_Hidden_Path to the city.",COLR_DEF_LOG_MSG);
         }
      }
      
      private function _le1009() : Boolean
      {
         var _loc1_:ArmyBean = null;
         var _loc2_:TroopBean = null;
         var _loc3_:TroopBean = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:HeroBean = null;
         var _loc7_:int = 0;
         if(this.enemyArmies.length == 0)
         {
            return false;
         }
         _loc1_ = this.enemyArmies[0];
         _loc2_ = Utils.getTroopBeanFromTroopStrBean(_loc1_.troop);
         if(_loc2_ == null)
         {
            return false;
         }
         if(this.enemyArmies.length > 1 && this.enemyArmies[1].reachTime - _loc1_.reachTime < 1500)
         {
            return false;
         }
         _loc3_ = this.getTotalTroopsInEmbassyArmies();
         _loc4_ = Utils.getTotalTroopCount(_loc2_);
         if(_loc2_.lightCavalry + _loc2_.heavyCavalry > 0.7 * (_loc4_ - _loc2_.scouter - _loc2_.carriage))
         {
            if((this.troop.archer + _loc3_.archer + 2.5 * this.fortification.arrowTower) * (1 + _loc7_ / 150) / 3.6 < _loc4_ + 2 * _loc2_.heavyCavalry)
            {
               return false;
            }
            return this.fortification.trap + this.fortification.abatis + this.fortification.rockfall + this.troop.lightCavalry > 0 && getLayerValue(this.troop.pikemen) + getLayerValue(this.troop.swordsmen) + getLayerValue(this.troop.peasants) + getLayerValue(this.troop.militia) + getLayerValue(this.troop.heavyCavalry) >= 2;
         }
         _loc5_ = _loc4_ + 4 * _loc2_.ballista + 5 * _loc2_.catapult + _loc2_.batteringRam;
         _loc6_ = this._gb172();
         _loc7_ = _loc6_ == null ? 0 : _loc6_.power;
         if(this.troop.archer + _loc3_.archer < 4.5 * _loc5_ / (1 + _loc7_ / 100))
         {
            return false;
         }
         if(this.fortification.trap == 0 && this.fortification.rockfall == 0 && (this.fortification.abatis == 0 || _loc2_.lightCavalry + _loc2_.heavyCavalry == 0))
         {
            return false;
         }
         return this.troop.pikemen > 0 && this.troop.swordsmen > 0;
      }
      
      private function _lf1047() : Array
      {
         var _loc1_:HeroBean = null;
         var _loc2_:Number = NaN;
         var _loc4_:TroopBean = null;
         var _loc5_:AllProduceBean = null;
         var _loc6_:ConditionBean = null;
         var _loc7_:Array = null;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:BuildingBean = null;
         var _loc17_:AllProduceBean = null;
         var _loc18_:int = 0;
         var _loc19_:ProduceBean = null;
         if(this.researches == null || this.troopRequirement == null || this.troopProduceQueue == null || this.getCfg(CityConfigs.CFG_TROOP) <= 0)
         {
            return null;
         }
         _loc1_ = this.getBestIdleAttackHeroByStaminaIncGear(0);
         if(_loc1_ == null)
         {
            return null;
         }
         _loc2_ = Utils.getMaxStatValueByType(_loc1_,"power");
         var _loc3_:int = this.estResource.curPopulation;
         _loc4_ = this.getAllTroopsInCastle();
         for each(_loc5_ in this.troopProduceQueue)
         {
            for each(_loc19_ in _loc5_.allProduceQueueArray)
            {
               _loc4_[troopIntNames[_loc19_.type]] += _loc19_.num;
            }
         }
         _loc6_ = null;
         _loc7_ = new Array(TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
         _loc8_ = NaN;
         _loc9_ = 0;
         _loc10_ = NaN;
         _loc11_ = 0;
         _loc12_ = 0;
         _loc13_ = 0;
         _loc14_ = 0;
         _loc15_ = 0;
         _loc16_ = null;
         _loc17_ = null;
         for each(_loc18_ in _loc7_)
         {
            if(_loc4_[troopIntNames[_loc18_]] < this.troopRequirement[troopIntNames[_loc18_]])
            {
               _loc8_ = -_loc4_[troopIntNames[_loc18_]] + this.troopRequirement[troopIntNames[_loc18_]];
               _loc6_ = this._mb759(_loc18_);
               if(_loc6_ != null)
               {
                  _loc9_ = this._ui319(_loc18_,_loc2_);
                  _loc10_ = Math.max(0.3,this.getCfg(CityConfigs.CFG_DUMPING));
                  _loc11_ = _loc9_ != 0 ? int(_loc10_ * 3 * 3600 / _loc9_) : 100000;
                  _loc11_ = int(_loc11_ / 10) * 10;
                  if(_loc11_ < 10)
                  {
                     _loc11_ = 10;
                  }
                  _loc12_ = 0;
                  while(this.estResource.workPeople + troopPopulations[_loc18_] * (_loc12_ + 10) <= this.estResource.curPopulation)
                  {
                     _loc12_ += 10;
                  }
                  _loc13_ = 0;
                  _loc14_ = -1;
                  _loc15_ = 0;
                  while(_loc15_ < this.buildings.length)
                  {
                     _loc16_ = this.buildings[_loc15_];
                     if(_loc16_.typeId == BuildingConstants.TYPE_BARRACK)
                     {
                        _loc17_ = this.getBarrackQueueFromBuildingBean(_loc16_);
                        if(_loc17_ != null)
                        {
                           if(_loc17_.allProduceQueueArray.length < _loc16_.level)
                           {
                              if(this._wb445(_loc6_,_loc16_.level))
                              {
                                 _loc13_++;
                                 _loc14_ = _loc16_.positionId;
                              }
                           }
                        }
                     }
                     _loc15_++;
                  }
                  if(_loc13_ != 0)
                  {
                     if(_loc12_ > _loc13_ * 10)
                     {
                        if(_loc12_ * (_loc9_ + 1) / _loc13_ >= 600)
                        {
                           if(_loc12_ > _loc13_ * _loc11_)
                           {
                              _loc12_ = _loc13_ * _loc11_;
                           }
                           if(_loc12_ > 2 * _loc8_)
                           {
                              _loc12_ = 2 * _loc8_;
                           }
                           return new Array(_loc14_,_loc18_,_loc12_);
                        }
                     }
                  }
               }
            }
         }
         return null;
      }
      
      private function _yy395(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:CityState = null;
         _loc2_ = false;
         for each(_loc3_ in MainScreen.getCities())
         {
            if(_loc3_.cityManager.getCfg(CityConfigs.CFG_SAFEMAINT) > 0)
            {
               if(_loc3_.cityManager.recallArmiesToNpc(param1))
               {
                  _loc2_ = true;
               }
            }
         }
         return _loc2_;
      }
      
      private function doKeepTroop() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:TroopBean = null;
         var _loc3_:TroopBean = null;
         var _loc4_:TroopBean = null;
         var _loc5_:NewArmyParam = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(this.keepTroopFieldIds.length == 0)
         {
            return false;
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         _loc1_ = this.rallySettings[RALLY_KEEPTROOP] == -1 ? 2 : int(this.rallySettings[RALLY_KEEPTROOP]);
         if(this._de1078(this.keepTroopFieldIds,ObjConstants.ARMY_MISSION_SEND) >= _loc1_)
         {
            return false;
         }
         _loc2_ = this.getAllTroopsInCastle();
         _loc3_ = null;
         _loc4_ = null;
         _loc5_ = null;
         _loc12_ = this.getRallyDispatchPerArmyLimit(true);
         _loc13_ = 0;
         while(true)
         {
            if(_loc13_ >= this.keepTroopFieldIds.length)
            {
               return false;
            }
            _loc6_ = int(this.keepTroopFieldIds[_loc13_]);
            _loc3_ = this.keepTroopTroopBeans[_loc13_];
            _loc7_ = int(this.keepTroopMinSents[_loc13_]);
            if(MainScreen.getCityFromFieldId(_loc6_) == null && MainScreen.getCityFromValleyFieldId(_loc6_) == null)
            {
               this.logMsg("KEEPTROOP > Bad destination for keeptroop: " + Map.fieldIdToCoordString(_loc6_),COLR_ERR_LOG_MSG);
               this.keepTroopFieldIds.splice(_loc13_,1);
               this.keepTroopTroopBeans.splice(_loc13_,1);
               this.keepTroopMinSents.splice(_loc13_,1);
               this.keepTroopTotalFlags.splice(_loc13_,1);
               return false;
            }
            _loc4_ = !!this.keepTroopTotalFlags[_loc13_] ? _loc2_ : this.troop;
            _loc5_ = new NewArmyParam();
            _loc5_.missionType = ObjConstants.ARMY_MISSION_SEND;
            _loc5_.troops = new TroopBean();
            _loc5_.resource = new ResourceBean();
            _loc5_.targetPoint = _loc6_;
            _loc8_ = _loc12_;
            _loc9_ = 0;
            for each(_loc11_ in troopTypes)
            {
               if(_loc8_ == 0)
               {
                  break;
               }
               if(_loc3_[troopIntNames[_loc11_]] != 0)
               {
                  if(_loc3_[troopIntNames[_loc11_]] < _loc4_[troopIntNames[_loc11_]])
                  {
                     _loc10_ = Math.min(_loc8_,this.troop[troopIntNames[_loc11_]],_loc4_[troopIntNames[_loc11_]] - _loc3_[troopIntNames[_loc11_]]);
                     _loc5_.troops[troopIntNames[_loc11_]] = _loc10_;
                     _loc8_ -= _loc10_;
                     _loc9_ += _loc10_;
                  }
               }
            }
            if(_loc9_ >= _loc7_)
            {
               if(this.isEnoughResourcesToMarch(_loc5_))
               {
                  break;
               }
               if(this.cityTimingAllowed("keeptrooperror",900) && !this.isZeroFoodActive)
               {
                  this.logMsg("KEEPTROOP > Not enough resource to move troop to " + Map.fieldIdToCoordString(_loc6_),COLR_ERR_LOG_MSG);
               }
            }
            _loc13_++;
         }
         if(!this.cityTimingAllowed("keeptroop",60))
         {
            return false;
         }
         this.logMsg("KEEPTROOP > Moving " + Utils.troopBeanToString(_loc5_.troops) + " to " + Map.fieldIdToString(_loc6_) + ", arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc5_)),COLR_STD_LOG_MSG);
         CityStateCommands.newArmy(this.castleId,_loc5_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc5_);
         return true;
      }
      
      public function _populate_F_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:Array = null;
         var _loc4_:FortificationsBean = null;
         var _loc5_:DataRow = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         _loc2_ = new ArrayCollection();
         _loc3_ = new Array(TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ARROWTOWER,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL);
         _loc4_ = this.getFortificationsInProduction();
         _loc5_ = null;
         _loc6_ = NaN;
         for each(_loc7_ in _loc3_)
         {
            _loc5_ = new DataRow();
            _loc5_.col1 = troopExtNames[_loc7_] + " (" + Utils.troopAbrNames[_loc7_] + ")";
            _loc5_.col2 = Utils.abbrNum(this.fortification[troopIntNames[_loc7_]]);
            _loc5_.col3 = Utils.abbrNum(_loc4_[troopIntNames[_loc7_]]);
            _loc5_.label = "Count: " + this.fortification[troopIntNames[_loc7_]];
            if(_loc4_[troopIntNames[_loc7_]] > 0)
            {
               _loc6_ = this._ow667(_loc7_);
               if(_loc6_ >= 0)
               {
                  _loc5_.label = _loc5_.label + "\nNext available: " + Utils.getTimeStr(_loc6_) + "\n" + "in " + Utils.formatEndTime(_loc6_);
               }
            }
            _loc2_.addItem(_loc5_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function getArmyMovementRestriction() : int
      {
         var _loc1_:Number = NaN;
         _loc1_ = Number(new Date().getTime());
         if(this.lastBattleAfterAdvMoveErrorTime != null && this.lastBattleAfterAdvMoveErrorTime.getTime() + 3600 * 1000 > _loc1_)
         {
            if(this.cityTimingAllowed("advteleportrestriction",600))
            {
               this.logMsg("<i>NOTE: confine troops due to advanced teleport usage</i>",COLR_WRN_LOG_MSG);
            }
            return 2;
         }
         if(this.isCanCounterAmbush())
         {
            if(playerTimingAllowed("ambushrestriction",600))
            {
               this.logMsg("<i>NOTE: confine troops due to ambush from all sides</i>",COLR_WRN_LOG_MSG);
            }
            if(this.cityTimingAllowed("undoambushed",600))
            {
               this.doAutoUseAdvByAHiddenPath(false);
            }
            return 2;
         }
         if(this.getBuff("CapitalTruceBuff") != null || this.lastCapitalTruceErrorTime != null && this.lastCapitalTruceErrorTime.getTime() + 3600 * 1000 > _loc1_)
         {
            if(playerTimingAllowed("trucerestriction",600))
            {
               this.logMsg("<i>NOTE: confine troops due to new capital truce</i>",COLR_WRN_LOG_MSG);
            }
            return 2;
         }
         if(this.isCanCounterAmbush())
         {
            if(playerTimingAllowed("ambushrestriction",600))
            {
               this.logMsg("<i>NOTE: confine troops due to ambush from all sides</i>",COLR_WRN_LOG_MSG);
            }
            if(this.cityTimingAllowed("undoambushed",10))
            {
               this.doAutoUseAdvByAHiddenPath(false);
            }
            return 2;
         }
         if(this.getBuff("PlayerPeaceBuff") != null || lastAntiBattleErrorTime != null && lastAntiBattleErrorTime.getTime() + 3600 * 1000 > _loc1_)
         {
            if(playerTimingAllowed("trucerestriction",600))
            {
               this.logMsg("<i>NOTE: confine troops due to truce</i>",COLR_WRN_LOG_MSG);
            }
            return 1;
         }
         return 0;
      }
      
      private function getAvailableRallyMaxRainbowSlots() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ArrayCollection = null;
         if(this.getCfg(CityConfigs.CFG_GATE) <= 0)
         {
            return 0;
         }
         _loc1_ = this.rallySettings[RALLY_RAINBOW] == -1 ? 1 : int(this.rallySettings[RALLY_RAINBOW]);
         _loc2_ = this.getFieldIdUsedForHiding();
         if(_loc2_ == -1)
         {
            return _loc1_;
         }
         _loc3_ = this.getLocalHidingArmies(_loc2_);
         if(_loc3_.length >= _loc1_)
         {
            return 0;
         }
         return _loc1_ - _loc3_.length;
      }
      
      private function _hf650(param1:int) : Number
      {
         if(this.market[param1] == null || this.market[param1].sellersArray.length == 0)
         {
            return 9999;
         }
         return this.market[param1].sellersArray[this.market[param1].sellersArray.length - 1].price;
      }
      
      public function listMedals() : void
      {
         var _loc2_:ItemBean = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.player.itemsArray)
         {
            if(_loc2_.id != null)
            {
               if(String(_loc2_.id).indexOf("hero.loyalty.") == 0)
               {
                  _loc1_ += (_loc1_ != "" ? ", " : "") + _loc2_.count + " " + Items.getItemName(_loc2_.id);
               }
            }
         }
         if(_loc1_ != "")
         {
            this.logMsg("Medals: " + _loc1_);
         }
         else
         {
            this.logMsg("No medals");
         }
      }
      
      private function _sf1146() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:ResourceBean = null;
         if(!this._ty399() && this.fortification.arrowTower < 3000)
         {
            return this.estResource.food > 2000 && this.estResource.wood > 20000 && this.estResource.stone > 10000 && this.estResource.iron > 5000;
         }
         _loc1_ = 30000;
         _loc2_ = this._ps301();
         if(_loc2_.gold + _loc1_ > this.estResource.gold || _loc2_.food + _loc1_ > this.estResource.food || _loc2_.wood + _loc1_ > this.estResource.wood || _loc2_.stone + _loc1_ > this.estResource.stone || _loc2_.iron + _loc1_ > this.estResource.iron)
         {
            return false;
         }
         return true;
      }
      
      private function getPackageListHandler(param1:GetPackageListResponse) : void
      {
         var ids:Array = null;
         var pkg:PackageBean = null;
         var i:int = 0;
         var handler:Function = null;
         var claimPkg:Function = null;
         var r:GetPackageListResponse = param1;
         if(r.ok != CommandResponse.OK_DEFAULT)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Error received while requesting list of available packages: " + r.errorMsg,COLR_DBG_LOG_MSG);
            return;
         }
         if(r.packagesArray == null || r.packagesArray.length == 0)
         {
            return;
         }
         ids = new Array();
         for each(pkg in r.packagesArray)
         {
            if(pkg.status == ObjConstants.PACKAGE_STATUS_AVAIBLE)
            {
               ids.push(pkg.id);
            }
         }
         if(ids.length == 0)
         {
            return;
         }
         this.logMsg("AUTOCLAIMGIFTS > Now claiming " + ids.length + " packages...",COLR_STD_LOG_MSG);
         i = 0;
         handler = function(param1:GetPackageResponse):void
         {
            ++i;
            if(param1.ok == GetPackageResponse.ERROR_PACKAGE_EXPIRED && getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               logMsg("DEBUG(" + getCfg(CityConfigs.CFG_DEBUG) + ") > ERROR while claiming package " + i + " with id: " + ids[i] + ": " + param1.errorMsg,COLR_DBG_LOG_MSG);
            }
            else if(param1.ok == GetPackageResponse.ERROR_PACKAGE_NOT_EXISTS && getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               logMsg("DEBUG(" + getCfg(CityConfigs.CFG_DEBUG) + ") > ERROR while claiming package " + i + " with id: " + ids[i] + ": " + param1.errorMsg,COLR_DBG_LOG_MSG);
            }
            else if(param1.ok == GetPackageResponse.ERROR_REQUIRMENT_NOT_MET && getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               logMsg("DEBUG(" + getCfg(CityConfigs.CFG_DEBUG) + ") > ERROR while claiming package " + i + " with id: " + ids[i] + ": " + param1.errorMsg,COLR_DBG_LOG_MSG);
            }
            else
            {
               logMsg("AUTOCLAIMGIFTS > Claimed package " + i + " with id: " + ids[i],COLR_STD_LOG_MSG);
            }
            if(i < ids.length)
            {
               Utils.callLater(50,claimPkg);
            }
            else
            {
               logMsg("AUTOCLAIMGIFTS > Completed auto claiming " + ids.length + " packages.",COLR_STD_LOG_MSG);
               ActionFactory.getInstance().getCommonCommands().getPackageNumber(MainScreen.getInstance().setBoxNum);
            }
         };
         claimPkg = function(param1:TimerEvent = null):void
         {
            ActionFactory.getInstance().getCommonCommands().getPackage(ids[i],"",handler);
         };
         Utils.callLater(50,claimPkg);
      }
      
      public function get lastMaintenance() : Number
      {
         return lastMaintenanceDownTime;
      }
      
      private function setFoodHideLoc() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = this.fields.length != 0 ? int(this.fields[0].id) : -1;
         if(_loc1_ == this.foodHideLoc)
         {
            return false;
         }
         if(_loc1_ != this.foodHideLoc && this.foodHideLoc != -1)
         {
            this.recallZeroFoodArmies();
         }
         this.foodHideLoc = _loc1_;
         return true;
      }
      
      public function getFoodNeededToMarch(param1:NewArmyParam, param2:Boolean = false) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         _loc3_ = param1.restTime > 0 ? param1.restTime : 0;
         _loc4_ = 1;
         _loc5_ = 1;
         _loc6_ = 0;
         if(Map.getType(param1.targetPoint) == FieldConstants.TYPE_CASTLE && (param1.missionType == ObjConstants.ARMY_MISSION_SEND || param1.missionType == ObjConstants.ARMY_MISSION_TRANS))
         {
            _loc6_ = 0;
            while(_loc6_ < this.buildings.length)
            {
               if(this.buildings[_loc6_].typeId == BuildingConstants.TYPE_TRANSPORT_STATION)
               {
                  _loc4_ = int(SPEEDUP[this.buildings[_loc6_].level]);
                  break;
               }
               _loc6_++;
            }
         }
         if(param1.heroId > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < this.heroes.length)
            {
               if(this.heroes[_loc6_].id == param1.heroId)
               {
                  _loc5_ = Utils.getHeroSpeedFactor(this.heroes[_loc6_]);
                  break;
               }
               _loc6_++;
            }
         }
         _loc7_ = this.getTroopFoodValue(param1.troops) * 2 * (this.getBaseTravelTime(this.castle.fieldId,param1.targetPoint,param1.troops) / _loc4_ / _loc5_ + _loc3_ * this.getCampTimeChangeBuffsFactor()) / 3600;
         return param2 ? Math.round(_loc7_) : _loc7_;
      }
      
      private function _wl158(param1:int) : BuildingBean
      {
         var _loc2_:BuildingBean = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = null;
         _loc3_ = 20;
         _loc4_ = 0;
         while(_loc4_ < this.buildings.length)
         {
            if(this.buildings[_loc4_].status == 0)
            {
               if(this.buildings[_loc4_].typeId == param1 && this.buildings[_loc4_].level < _loc3_)
               {
                  _loc2_ = this.buildings[_loc4_];
                  _loc3_ = _loc2_.level;
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function _cityStillHasGoodHeroes() : Boolean
      {
         var _loc1_:HeroBean = null;
         for each(_loc1_ in this.heroes)
         {
            if(_loc1_.ability > 0 || _loc1_.isHero > 0 || _loc1_.power + _loc1_.remainPoint - _loc1_.level > 80 || _loc1_.management + _loc1_.remainPoint - _loc1_.level > 80 || _loc1_.stratagem + _loc1_.remainPoint - _loc1_.level > 80)
            {
               return true;
            }
         }
         return false;
      }
      
      public function warLogMsg(param1:String, param2:String = "#000000") : void
      {
         this.logMsg(param1,param2);
         dispatchEvent(new WarLogEvent("<font color=\'#ff0000\'>(" + this.castle.name + ")</font> - <font color=\'" + param2 + "\'>" + param1 + "</font>"));
      }
      
      public function updateWallQueue() : void
      {
         if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_WALL,1) == 0)
         {
            return;
         }
         if(fortificationProductionUpdateRequested > 0 && new Date().getTime() - fortificationProductionUpdateRequestedTime < 30000)
         {
            Utils.callLater(1000,this.updateWallQueue);
            return;
         }
         fortificationProductionUpdateRequested = this.castleId;
         fortificationProductionUpdateRequestedTime = new Date().getTime();
         ActionFactory.getInstance().getFortificationsCommands().getFortificationsProduceList(this.castleId,this.setFortificationListArray);
         ActionFactory.getInstance().getFortificationsCommands().getProduceQueue(this.castleId,this.onUpdateWallQueueResponse);
      }
      
      public function _populate_V_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:DataRow = null;
         var _loc4_:FieldBean = null;
         _loc2_ = new ArrayCollection();
         _loc3_ = null;
         for each(_loc4_ in this.fields)
         {
            _loc3_ = new DataRow();
            _loc3_.col1 = Map.fieldIdToCoordString(_loc4_.id);
            _loc3_.col2 = _loc4_.name;
            _loc3_.col3 = _loc4_.level;
            _loc3_.col4 = int(Map.fieldDistance(this.castle.fieldId,_loc4_.id) * 100) / 100;
            _loc3_.col5 = _loc4_.id;
            _loc2_.addItem(_loc3_);
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function _jq490(param1:Object) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("army call back error: " + param1.msg);
            return;
         }
      }
      
      public function _jt504(param1:int, param2:TroopBean, param3:TroopBean) : Boolean
      {
         var _loc4_:TroopBean = null;
         var _loc5_:NewArmyParam = null;
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         if(param2 == null || param3 == null)
         {
            this.logMsg("Invalid condtion and resource value provided");
            return false;
         }
         _loc4_ = this.getAllTroopsInCastle();
         if(!isEnoughTroops(_loc4_,param2))
         {
            return false;
         }
         if(!isEnoughTroops(_loc4_,param3))
         {
            return false;
         }
         _loc5_ = new NewArmyParam();
         _loc5_.troops = param3;
         _loc5_.resource = new ResourceBean();
         _loc5_.targetPoint = param1;
         _loc5_.missionType = ObjConstants.ARMY_MISSION_SEND;
         if(!this.isEnoughResourcesToMarch(_loc5_))
         {
            return false;
         }
         this.logMsg("  dumping troop to " + Map.fieldIdToString(param1) + " " + Utils.troopBeanToString(param3));
         CityStateCommands.newArmy(this.castleId,_loc5_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc5_);
         return true;
      }
      
      private function getZeroFoodArmies() : ArrayCollection
      {
         var _loc1_:ArrayCollection = null;
         var _loc2_:TroopBean = null;
         var _loc3_:ArmyBean = null;
         _loc1_ = new ArrayCollection();
         _loc2_ = null;
         if(this.foodHideLoc == -1)
         {
            return _loc1_;
         }
         for each(_loc3_ in this.localArmies)
         {
            if(!(_loc3_.targetFieldId != this.foodHideLoc || _loc3_.missionType != ObjConstants.ARMY_MISSION_SEND || _loc3_.direction == ArmyConstants.ARMY_BACKWARD || _loc3_.resource == null))
            {
               if(!(_loc3_.resource.food == 0 || _loc3_.resource.gold > 0 || _loc3_.resource.wood > 0 || _loc3_.resource.stone > 0 || _loc3_.resource.iron > 0))
               {
                  _loc2_ = Utils.getTroopBeanFromTroopStrBean(_loc3_.troop);
                  if(_loc2_.carriage == Utils.getTotalTroopCount(_loc2_))
                  {
                     _loc1_.addItem(_loc3_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function tskAttackResourceField(param1:Boolean, param2:Boolean) : Boolean
      {
         var _loc3_:HeroBean = null;
         var _loc4_:int = 0;
         var _loc5_:MapCastleBean = null;
         var _loc6_:int = 0;
         var _loc7_:TroopBean = null;
         var _loc8_:NewArmyParam = null;
         var _loc9_:* = undefined;
         this._xn1058();
         if(this.enemyArmies.length > 0 && this.enemyArmies[0].reachTime - Utils.getServerTime() < 7200 * 1000)
         {
            return false;
         }
         if(this.lastFlatRollingActivityTime > Utils.getServerTime() - 30 * 60 * 1000)
         {
            return false;
         }
         if(!this._te955())
         {
            return false;
         }
         if(this.resourceFieldsDetailInfo.length == 0)
         {
            if(this.candidateResourceFields != null && this.candidateResourceFields.length == 0 && this.distanceSettings[DISTANCE_VALLEY] < 30)
            {
               if(this.distanceSettings[DISTANCE_VALLEY] < 4)
               {
                  this.distanceSettings[DISTANCE_VALLEY] = 4;
               }
               this.distanceSettings[DISTANCE_VALLEY] = int(this.distanceSettings[DISTANCE_VALLEY] * 1.3);
               this.candidateResourceFields = null;
            }
            return false;
         }
         if(!param1 || !param2)
         {
            return false;
         }
         _loc3_ = this.getNextValleyHero();
         if(_loc3_ == null)
         {
            return false;
         }
         _loc4_ = this.rallySettings[RALLY_VALLEY] == -1 ? 1 : int(this.rallySettings[RALLY_VALLEY]);
         if(this.getValleyArmyCount() >= _loc4_)
         {
            return false;
         }
         _loc5_ = null;
         _loc6_ = 0;
         _loc7_ = null;
         _loc8_ = null;
         for each(_loc9_ in this.resourceFieldsDetailInfo)
         {
            if(!this.isValley(_loc9_.id))
            {
               if(!this._bb1110(_loc9_.id))
               {
                  _loc5_ = Map.getDetail(_loc9_.id);
                  if(_loc5_ != null)
                  {
                     if(_loc5_.userName != this.player.playerInfo.userName)
                     {
                        if(!_loc5_.canOccupy || _loc5_.state != 1 && _loc5_.state != 4 || _loc5_.userName != null)
                        {
                           this.logMsg("VALLEY > CANNOT ATTACK " + Map.fieldIdToString(_loc9_.id),COLR_STD_LOG_MSG);
                           this.resourceFieldsDetailInfo.removeItemAt(this.resourceFieldsDetailInfo.getItemIndex(_loc9_));
                        }
                        else
                        {
                           _loc6_ = Map.getLevel(_loc9_.id);
                           if(_loc6_ != -1)
                           {
                              _loc7_ = this.getTroopsToAttackValley(_loc6_);
                              if(_loc7_ != null)
                              {
                                 _loc8_ = new NewArmyParam();
                                 _loc8_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
                                 _loc8_.heroId = _loc3_.id;
                                 _loc8_.targetPoint = _loc9_.id;
                                 _loc8_.troops = _loc7_;
                                 _loc8_.resource = new ResourceBean();
                                 if(!this.isEnoughResourcesToMarch(_loc8_))
                                 {
                                    return false;
                                 }
                                 if(this.isWarTownOn(2 * this.getTravelTimeReliefStationAdj(_loc8_) / Utils.getHeroSpeedFactor(_loc3_)))
                                 {
                                    return false;
                                 }
                                 this.logMsg("VALLEY > attack field " + Map.fieldIdToString(_loc9_.id) + " for resource with hero " + _loc3_.name + " and " + _loc7_.archer + " archers, " + _loc7_.militia + " militia " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc8_) / Utils.getHeroSpeedFactor(_loc3_)),COLR_STD_LOG_MSG);
                                 CityStateCommands.newArmy(this.castle.id,_loc8_,this.handleArmyCommandResponse);
                                 this.lastResourceFieldLevels[_loc9_.id] = _loc6_;
                                 this.adjEstFoodAfterMarch(_loc8_);
                                 Map.updateDetailInfo(_loc9_.id);
                                 return true;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public function get fields() : ArrayCollection
      {
         return this.castle.fieldsArray;
      }
      
      private function isHeroInTown(param1:String) : HeroBean
      {
         var _loc2_:HeroBean = null;
         param1 = param1.toLowerCase();
         for each(_loc2_ in this.heroes)
         {
            if(_loc2_.name.toLowerCase() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function _wa163() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:HeroBean = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc1_ = false;
         _loc2_ = this.bestIdlePoliticsHero(0);
         _loc3_ = _loc2_ == null ? 0 : int(Utils.getTotalPointsForHeroAttribute(_loc2_,"management"));
         _loc4_ = 0;
         if(_loc2_ == null)
         {
            return true;
         }
         for each(_loc5_ in this.fortificationProduceQueue)
         {
            for each(_loc6_ in _loc5_.allProduceQueueArray)
            {
               _loc4_ = this._ui319(_loc6_.type,_loc3_);
               if(_loc6_.costTime > 30 * 60 && _loc6_.costTime > 1.5 * (1 + _loc4_) * _loc6_.num && _loc6_.num > 5)
               {
                  this.logErrMsg("Bad fortification queue " + _loc6_.queueId + ": " + _loc6_.num + " " + troopExtNames[_loc6_.type] + " takes " + Utils.formatTime(_loc6_.costTime) + "/" + Utils.formatTime(_loc4_ * _loc6_.num));
                  _loc1_ = true;
                  CityStateCommands.cancelFortificationProduce(this.castleId,_loc6_.queueId);
                  _loc6_.num = 0;
                  this.fortificationProductionUpdateNeeded = true;
               }
            }
         }
         if(_loc1_)
         {
            CityStateCommands.dischargeChief(this.castleId,this.onHeroDischargeResponse);
            this.lastPromoteId = -1;
         }
         return _loc1_;
      }
      
      private function doComfort() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!(this.isMarketReady() || this.isMarketGovRestricted()))
         {
            return;
         }
         _loc1_ = "#C8A44E";
         _loc2_ = false;
         _loc3_ = this.getCfg(CityConfigs.CFG_MINTAXRATE) - this.resource.complaint < 0 ? 0 : int(this.getCfg(CityConfigs.CFG_MINTAXRATE) - this.resource.complaint);
         if(this.resource.complaint > 0 || this.resource.support <= 8)
         {
            if(this.estResource.food >= this.getFoodAmountRequiredForComfort())
            {
               if((this.resource.support <= 8 || this.resource.complaint > 0 && this.resource.complaint <= 5) && this.cityTimingAllowed("comfort",910))
               {
                  this.logMsg("COMFORT > Do comfort Pray",_loc1_);
                  CityStateCommands.pacifyPeople(this.castleId,CityStateConstants.COMFORT_PRAY);
               }
               else if((this.resource.complaint > 5 || !this.isLastEnemyTimeLessThan1Hr()) && this.cityTimingAllowed("comfort",910))
               {
                  this.logMsg("COMFORT > Do comfort Disaster Relief",_loc1_);
                  CityStateCommands.pacifyPeople(this.castleId,CityStateConstants.COMFORT_RELIEF);
               }
            }
            else if(this.resource.support == 15 && this.isLastEnemyTimeLessThan1Hr())
            {
               _loc4_ = 100 - this.resource.complaint - this.resource.support;
               if(this.resource.texRate == _loc4_)
               {
                  _loc2_ = true;
               }
               if(_loc4_ >= 0 && this.resource.texRate != _loc4_)
               {
                  _loc2_ = true;
                  if(this.cityTimingAllowed("taxrateforloyalty15",60))
                  {
                     this.logMsg("Set tax rate to " + _loc4_ + "%",_loc1_);
                     this.resource.texRate = _loc4_;
                     CityStateCommands.modifyTaxRate(this.castleId,_loc4_,this.setTaxRateResonseHandler);
                  }
               }
            }
         }
         if(!_loc2_)
         {
            if(this.getCfg(CityConfigs.CFG_MINTAXRATE) > 0 && this.resource.texRate < _loc3_)
            {
               this.logMsg("Set tax rate to " + _loc3_ + "%",_loc1_);
               this.resource.texRate = _loc3_;
               CityStateCommands.modifyTaxRate(this.castleId,_loc3_,this.setTaxRateResonseHandler);
            }
            else if((this.estResource.gold > 1000000 || this.resource.taxIncome < this.resource.herosSalary) && this.resource.texRate != _loc3_)
            {
               this.logMsg("Set tax rate to " + _loc3_ + "%",_loc1_);
               this.resource.texRate = _loc3_;
               CityStateCommands.modifyTaxRate(this.castleId,_loc3_,this.setTaxRateResonseHandler);
            }
         }
         if(this.resource.complaint == 0 && this.getCfg(CityConfigs.CFG_COMFORT) >= 4 && this.resource.curPopulation < this.resource.maxPopulation * (1 - this.resource.texRate / 100) * 0.95 && this.estResource.food >= 50 * this.resource.maxPopulation && this.cityTimingAllowed("comfort",905))
         {
            this.logMsg("Do comfort to raise population",_loc1_);
            CityStateCommands.pacifyPeople(this.castleId,CityStateConstants.COMFORT_POPULATION_RAISE);
            this.estResource.food -= this.resource.maxPopulation * 5;
         }
      }
      
      private function _gc116(param1:int, param2:int) : int
      {
         var _loc3_:BuildingBean = null;
         for each(_loc3_ in this.buildings)
         {
            if(_loc3_.status == 0)
            {
               if(_loc3_.typeId == param1 && _loc3_.level == param2)
               {
                  return _loc3_.positionId;
               }
            }
         }
         return -1000;
      }
      
      private function getIncommingResources() : ResourceBean
      {
         var _loc1_:ResourceBean = null;
         var _loc2_:TransingTradeBean = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:ArmyBean = null;
         _loc1_ = new ResourceBean();
         for each(_loc2_ in this.transingTradesArray)
         {
            _loc1_[resourceIntNames[_loc2_.resType]] += _loc2_.amount;
         }
         _loc3_ = null;
         _loc4_ = null;
         for each(_loc5_ in this.selfArmies)
         {
            if(_loc5_.startFieldId != this.castle.fieldId)
            {
               if(_loc5_.targetFieldId != this.castle.fieldId)
               {
                  continue;
               }
               if(_loc5_.missionType != ObjConstants.ARMY_MISSION_SEND && _loc5_.missionType != ObjConstants.ARMY_MISSION_TRANS || _loc5_.direction == ArmyConstants.ARMY_BACKWARD)
               {
                  continue;
               }
            }
            else if((_loc5_.missionType == ObjConstants.ARMY_MISSION_SEND || _loc5_.missionType == ObjConstants.ARMY_MISSION_TRANS) && _loc5_.direction != ArmyConstants.ARMY_BACKWARD && _loc5_.targetFieldId != this.evasionFieldId)
            {
               continue;
            }
            if(_loc5_.resource != null)
            {
               _loc3_ = _loc5_.resource.toObject();
               for(_loc4_ in _loc3_)
               {
                  _loc1_[_loc4_] += int(_loc3_[_loc4_]);
               }
            }
         }
         for each(_loc5_ in this.friendlyArmies)
         {
            if(_loc5_.direction == ArmyConstants.ARMY_STAY)
            {
               if(_loc5_.resource != null)
               {
                  _loc3_ = _loc5_.resource.toObject();
                  for(_loc4_ in _loc3_)
                  {
                     _loc1_[_loc4_] += int(_loc3_[_loc4_]);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function getBestHeroByType(param1:String) : HeroBean
      {
         var _loc2_:HeroBean = null;
         var _loc3_:HeroBean = null;
         _loc2_ = null;
         for each(_loc3_ in this.heroes)
         {
            if(_loc2_ == null || Utils.isBestHeroByType(param1,_loc3_,_loc2_))
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      public function getMaxRallySlots() : int
      {
         return Math.min(this.getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD),10);
      }
      
      public function toDebugString() : String
      {
         return "fields: gateOpen maintenanceTime troopSpeedUp buildings researches gears fields fortification heroes resource troop selfArmies enemyArmies friendlyArmies innHeroes tradesArray transingTradesArray market troopProduceQueue fortificationProduceQueue, methods: isActive() getMayor() getBuildingLevel(int) getTechLevel(int) getGearLevel(int) getStarLevel(int) bestPoliticsHero() bestIdlePoliticsHero() bestIntelHero() bestIdleIntelHero() bestAttackHero() bestIdleAttackHero() updateWallQueue() updateTroopQueue() updateInn() updateGears() updateResearch() getTroopSpeed(TroopBean)";
      }
      
      public function isColony(param1:int) : Boolean
      {
         var _loc3_:ColonyBean = null;
         var _loc2_:String = Map.getX(param1) + "." + Map.getY(param1);
         for each(_loc3_ in this.colonies)
         {
            if(_loc3_.position == _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function _vc796(param1:NewArmyParam) : void
      {
         var fieldId:int = 0;
         var arr:ArrayCollection = null;
         var army:ArmyBean = null;
         var newArmy:NewArmyParam = param1;
         try
         {
            fieldId = this.getFieldIdUsedForHiding();
            if(fieldId == -1)
            {
               return;
            }
            if(!Connection.getInstance().authenticated)
            {
               Utils.callLater(10000,this._vc796,[newArmy]);
               return;
            }
            arr = this._vq1155(fieldId);
            for each(army in arr)
            {
               if(!(newArmy == null && !this.cityTimingAllowed("recall" + army.armyId,30)))
               {
                  if(army.missionType == ObjConstants.ARMY_MISSION_SEND)
                  {
                     if(!(army.resource.gold != 2 || army.resource.food + army.resource.stone + army.resource.iron + army.resource.wood != 0))
                     {
                        if(newArmy == null || _xv999(newArmy,army))
                        {
                           this.logMsg("Recall rainbow evasion troop " + Utils.troopStrBeanToMsgString(army.troop,true),COLR_DEF_LOG_MSG);
                           CityStateCommands.callBackArmy(this.castleId,army.armyId);
                        }
                     }
                  }
               }
            }
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("error",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "Error while handling: stopSneakyEvasion, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
         }
      }
      
      private function _qy287(param1:int) : ArmyBean
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.startFieldId == this.castle.fieldId)
            {
               if(_loc2_.targetFieldId == param1 && !this.isResoBeanEmtpy(_loc2_.resource))
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function _setSpamHeroes(param1:String) : void
      {
         var _loc2_:Array = null;
         _loc2_ = param1.toLowerCase().split(",");
         this.getAvailableHeroNamesFromHeroListStr(_loc2_,true);
         this.spamHeroes = _loc2_;
      }
      
      private function _gv1114(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("fortification produce wall protect error: " + param1.errorMsg);
            this.fortificationProductionUpdateNeeded = true;
            if(MasterTimer.getInstance().canReceive(this.timeSlot))
            {
               MasterTimer.getInstance().setNextActiveTime();
            }
         }
         else
         {
            this.fortificationProductionUpdateNeeded = true;
         }
      }
      
      private function doKeepResource() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ResourceBean = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:MapCastleBean = null;
         var _loc8_:NewArmyParam = null;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc16_:Array = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:HeroBean = null;
         if(this.keepResourceFieldIds.length == 0)
         {
            return false;
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         if(this._de1078(this.keepResourceFieldIds,ObjConstants.ARMY_MISSION_TRANS) >= (this.rallySettings[RALLY_KEEPRESOURCE] != -1 ? this.rallySettings[RALLY_KEEPRESOURCE] : 1))
         {
            return false;
         }
         _loc1_ = 1 + 0.1 * this.getTechLevel(TechConstants.LOAD_TECH);
         _loc2_ = this.getRallyDispatchPerArmyLimit(true);
         _loc3_ = 0;
         _loc4_ = null;
         _loc5_ = NaN;
         _loc6_ = 0;
         _loc7_ = null;
         _loc8_ = null;
         _loc9_ = NaN;
         _loc10_ = 0;
         _loc11_ = 0;
         _loc12_ = NaN;
         _loc13_ = NaN;
         _loc14_ = NaN;
         _loc16_ = new Array(TFConstants.T_SCOUTER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_CARRIAGE);
         _loc17_ = 0;
         _loc18_ = 0;
         while(true)
         {
            if(_loc18_ >= this.keepResourceFieldIds.length)
            {
               return false;
            }
            _loc3_ = int(this.keepResourceFieldIds[_loc18_]);
            _loc4_ = this.keepResourceMinResources[_loc18_];
            _loc5_ = Number(this.keepResourceMinSents[_loc18_]);
            _loc7_ = Map.getDetail(_loc3_);
            if(_loc7_ != null && Map.getType(_loc3_) != -1)
            {
               if(!_loc7_.canTrans || Map.getType(_loc3_) != FieldConstants.TYPE_CASTLE)
               {
                  this.logMsg("KEEPRESOURCE > Bad destination for keepresource: " + Map.fieldIdToCoordString(_loc3_),COLR_ERR_LOG_MSG);
                  this.keepResourceFieldIds.splice(_loc18_,1);
                  this.keepResourceMinResources.splice(_loc18_,1);
                  this.keepResourceMinSents.splice(_loc18_,1);
                  return false;
               }
               _loc8_ = new NewArmyParam();
               _loc8_.missionType = ObjConstants.ARMY_MISSION_TRANS;
               if(this.getCfg(CityConfigs.CFG_FASTKEEPRESO) > 0)
               {
                  _loc19_ = this.fastestIdleHero();
                  if(_loc19_ != null)
                  {
                     _loc8_.heroId = _loc19_.id;
                  }
               }
               _loc8_.troops = new TroopBean();
               _loc8_.resource = new ResourceBean();
               _loc8_.targetPoint = _loc3_;
               _loc9_ = 0;
               _loc17_ = 0;
               while(_loc17_ < 5)
               {
                  if(_loc4_[resourceIntNames[_loc17_]] != 0 && !isNaN(_loc4_[resourceIntNames[_loc17_]]))
                  {
                     if(this.estResource[resourceIntNames[_loc17_]] >= _loc4_[resourceIntNames[_loc17_]])
                     {
                        _loc8_.resource[resourceIntNames[_loc17_]] = this.estResource[resourceIntNames[_loc17_]] - _loc4_[resourceIntNames[_loc17_]];
                        _loc9_ += _loc8_.resource[resourceIntNames[_loc17_]];
                     }
                     if(_loc5_ < 0)
                     {
                        if(_loc6_ < this.resource[resourceIntNames[_loc17_]].max - _loc4_[resourceIntNames[_loc17_]])
                        {
                           _loc6_ = this.resource[resourceIntNames[_loc17_]].max - _loc4_[resourceIntNames[_loc17_]];
                        }
                     }
                  }
                  _loc17_++;
               }
               if(_loc5_ < 0 && _loc6_ >= 0)
               {
                  _loc5_--;
               }
               if(!(_loc9_ < _loc5_ || _loc9_ <= 0))
               {
                  _loc10_ = -1;
                  _loc11_ = -1;
                  _loc12_ = -1;
                  for each(_loc15_ in _loc16_)
                  {
                     _loc13_ = Number(this.troop[troopIntNames[_loc15_]]);
                     if(_loc15_ != TFConstants.T_CARRIAGE)
                     {
                        _loc13_ = Math.max(0,_loc13_ - 100);
                     }
                     if(_loc13_ > _loc2_)
                     {
                        _loc13_ = _loc2_;
                     }
                     _loc14_ = _loc13_ * troopLoads[_loc15_] * _loc1_;
                     if(_loc14_ > _loc9_)
                     {
                        _loc11_ = _loc13_;
                        _loc12_ = _loc14_;
                        _loc10_ = _loc15_;
                        break;
                     }
                     if(_loc14_ > _loc12_)
                     {
                        _loc11_ = _loc13_;
                        _loc12_ = _loc14_;
                        _loc10_ = _loc15_;
                     }
                  }
                  if(_loc12_ > _loc9_)
                  {
                     _loc11_ = Math.min(_loc11_,Math.ceil(_loc11_ * _loc9_ / _loc12_ * 1.001));
                     _loc12_ = _loc9_;
                  }
                  else if(_loc12_ < _loc9_)
                  {
                     _loc17_ = 0;
                     while(_loc17_ < 5)
                     {
                        _loc8_.resource[resourceIntNames[_loc17_]] = Math.floor(_loc8_.resource[resourceIntNames[_loc17_]] * _loc12_ / _loc9_ / 1.001);
                        _loc17_++;
                     }
                  }
                  _loc8_.troops[troopIntNames[_loc10_]] = _loc11_;
                  Utils.trimDecimalFromResoAmounts(_loc8_.resource);
                  if(_loc11_ > 0)
                  {
                     if(this.isEnoughResourcesToMarch(_loc8_))
                     {
                        break;
                     }
                  }
               }
            }
            _loc18_++;
         }
         if(!this.cityTimingAllowed("keepresource",60))
         {
            return false;
         }
         this.logMsg("KEEPRESOURCE > transporting " + Utils.resourceBeanToString(_loc8_.resource) + " to " + Map.fieldIdToString(_loc3_) + (this.getCfg(CityConfigs.CFG_FASTKEEPRESO) > 0 && _loc19_ != null ? " using hero " + _loc19_.name : "") + " with " + Utils.troopBeanToString(_loc8_.troops) + ", arrival in " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc8_)),COLR_STD_LOG_MSG);
         CityStateCommands.newArmy(this.castleId,_loc8_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc8_);
         return true;
      }
      
      public function _getMarketLag() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:Date = null;
         _loc1_ = 0;
         if(currMarketInterest != -1)
         {
            _loc3_ = new Date();
            _loc1_ = (_loc3_.getTime() - lastMarketQueryTime.getTime()) / 1000;
         }
         _loc2_ = 0;
         while(_loc2_ < lastMarketLagTimes.length)
         {
            if(_loc1_ < lastMarketLagTimes[_loc2_])
            {
               _loc1_ = Number(lastMarketLagTimes[_loc2_]);
            }
            _loc2_++;
         }
         if(_loc1_ == 0)
         {
            _loc1_ = Utils.getServerLagTime();
         }
         return _loc1_;
      }
      
      private function handleQuestAward(param1:CommandResponse) : void
      {
         if(CityState.scriptQuestActive || !MasterTimer.getInstance().canReceive(this.timeSlot))
         {
            return;
         }
         if(param1.ok != 1)
         {
            this.logErrMsg("quest award response error " + param1.errorMsg);
         }
      }
      
      private function _ti267(param1:Array, param2:int = 5) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            this.loginSchedule = null;
            return;
         }
         this.loginSchedule = new Array();
         this.modifiedLoginSchedule = new Array();
         _loc3_ = 0;
         for each(_loc4_ in param1)
         {
            this.loginSchedule.push(_loc4_);
            _loc3_ = (_loc4_ + 24 * 60 + Utils.rand(-param2,param2)) % (24 * 60);
            this.modifiedLoginSchedule.push(_loc3_);
         }
      }
      
      private function _aq355(param1:int) : Boolean
      {
         if(param1 == this.lastGear)
         {
            return false;
         }
         this.lastGear = param1;
         return true;
      }
      
      private function _it985(param1:CityCondition) : Boolean
      {
         var _loc2_:ConditionBean = null;
         _loc2_ = this.getConditionBeanForUpgradingTo(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return this.isConditionsMet(_loc2_);
      }
      
      private function getHighestBidAmount(param1:int) : Number
      {
         if(this.market[param1] == null || this.market[param1].buyersArray.length == 0)
         {
            return 1000;
         }
         return this.market[param1].buyersArray[0].amount;
      }
      
      public function bestIdlePoliticsHero(param1:int = -1) : HeroBean
      {
         return this.getBestIdleHeroByTypeAndStamina("management",param1);
      }
      
      public function _setNpcTroopCond(param1:String) : Boolean
      {
         var _loc2_:TroopBean = null;
         _loc2_ = Utils.getTroops(param1);
         if(_loc2_ == null)
         {
            this.logMsg("Invalid troop: " + param1);
            return false;
         }
         if(Utils.getTotalTroopCount(_loc2_) > this.getRallyDispatchPerArmyLimit())
         {
            this.logMsg("WARNING: Too many npc troops for current rally spot level, setting is ignored",COLR_WRN_LOG_MSG);
            return false;
         }
         this.npcTroopBean = _loc2_;
         return true;
      }
      
      public function getItemById(param1:String) : ItemBean
      {
         var _loc2_:ItemBean = null;
         for each(_loc2_ in this.player.itemsArray)
         {
            if(_loc2_.id != null && _loc2_.count > 0 && _loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function _ff608(param1:XMLList, param2:FortificationsBean) : Boolean
      {
         var _loc3_:FortificationsBean = null;
         var _loc4_:Object = null;
         var _loc5_:* = undefined;
         if(param2 == null)
         {
            return false;
         }
         _loc3_ = this._jh1139(param1);
         if(_loc3_ == null)
         {
            return true;
         }
         _loc4_ = param2.toObject();
         for(_loc5_ in _loc4_)
         {
            if(param2[_loc5_] != 0)
            {
               if(param2[_loc5_] > 0 && _loc3_[_loc5_] >= param2[_loc5_])
               {
                  return true;
               }
               if(param2[_loc5_] < 0 && _loc3_[_loc5_] <= -param2[_loc5_])
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get allTroopQueued() : TroopBean
      {
         return this.getAllTroopsInQueues();
      }
      
      private function _as536() : int
      {
         return this.getCfg(CityConfigs.CFG_MAXPRODUCTION) > 0 && this.enemyArmies.length == 0 ? this.resource.food.workPeople + this.resource.wood.workPeople + this.resource.stone.workPeople + this.resource.iron.workPeople : 0;
      }
      
      private function _wf882() : Boolean
      {
         var _loc1_:FieldBean = null;
         var _loc2_:FieldBean = null;
         var _loc3_:int = 0;
         var _loc4_:MapCastleBean = null;
         var _loc5_:HeroBean = null;
         var _loc6_:TroopBean = null;
         var _loc7_:NewArmyParam = null;
         if(!this.hasFreeCitySlot())
         {
            return false;
         }
         if(buildCityLocation == -1)
         {
            return false;
         }
         if(this.getUsedRallySlots() >= this.getMaxRallySlots())
         {
            return false;
         }
         _loc1_ = null;
         for each(_loc2_ in this.fields)
         {
            if(_loc2_.type == FieldConstants.TYPE_FLAT && _loc2_.id == buildCityLocation)
            {
               if(this.getArmyToTarget(_loc2_.id) != null)
               {
                  return false;
               }
               _loc1_ = _loc2_;
               break;
            }
         }
         if(_loc1_ != null)
         {
            return this.doBuildNewCity(_loc1_.id);
         }
         if(this._bb1110(buildCityLocation))
         {
            return false;
         }
         _loc3_ = Map.getType(buildCityLocation);
         if(_loc3_ == -1)
         {
            return false;
         }
         if(_loc3_ != FieldConstants.TYPE_FLAT)
         {
            this.logMsg("Build city error, location " + Map.fieldIdToString(buildCityLocation) + " is not a flat");
            Map.updateInfo(buildCityLocation);
            Map.updateDetailInfo(buildCityLocation);
            buildCityLocation = -1;
            return false;
         }
         _loc4_ = Map.getDetail(buildCityLocation);
         if(_loc4_ == null)
         {
            return false;
         }
         if(!_loc4_.canOccupy || _loc4_.state != 1)
         {
            if(_loc4_.userName != this.player.playerInfo.userName)
            {
               this.logMsg("Build city error, field " + Map.fieldIdToString(buildCityLocation) + " cannot be taken");
               Map.updateInfo(buildCityLocation);
               Map.updateDetailInfo(buildCityLocation);
               buildCityLocation = -1;
               return false;
            }
            return this.doBuildNewCity(_loc4_.id);
         }
         _loc5_ = this.getNextValleyHero();
         if(_loc5_ == null)
         {
            return false;
         }
         _loc6_ = this.getTroopsToAttackValley(Map.getLevel(buildCityLocation));
         if(_loc6_ == null)
         {
            return false;
         }
         _loc7_ = new NewArmyParam();
         _loc7_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc7_.troops = _loc6_;
         _loc7_.resource = new ResourceBean();
         _loc7_.heroId = _loc5_.id;
         _loc7_.targetPoint = _loc4_.id;
         if(!this.isEnoughResourcesToMarch(_loc7_))
         {
            return false;
         }
         this.logMsg("Attack field " + Map.fieldIdToString(_loc4_.id) + " for new city with " + _loc6_.archer + " archers " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc7_) / Utils.getHeroSpeedFactor(_loc5_)));
         CityStateCommands.newArmy(this.castleId,_loc7_,this.handleArmyCommandResponse);
         this.adjEstFoodAfterMarch(_loc7_);
         Map.updateDetailInfo(_loc4_.id);
         return true;
      }
      
      public function _getRuleStr(param1:TroopBean) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _loc2_ = new Array(TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_CARRIAGE,TFConstants.T_BALLISTA,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
         _loc3_ = "";
         for each(_loc4_ in _loc2_)
         {
            if(param1[troopIntNames[_loc4_]] != 0)
            {
               _loc3_ += Utils.troopAbrNames[_loc4_] + ":" + param1[troopIntNames[_loc4_]] + " ";
            }
         }
         return _loc3_;
      }
      
      public function _populate_E_Tab(param1:ArrayCollection, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true, param6:Boolean = true) : void
      {
         var _loc7_:ArrayCollection = null;
         var _loc8_:ArmyBean = null;
         var _loc9_:DataRow = null;
         var _loc10_:String = null;
         _loc7_ = new ArrayCollection();
         _loc8_ = null;
         _loc9_ = null;
         if(param2)
         {
            for each(_loc8_ in this.enemyArmies)
            {
               if(_loc8_.targetFieldId == this.castle.fieldId)
               {
                  _loc9_ = new DataRow();
                  if(_loc8_.missionType != ObjConstants.ARMY_MISSION_OCCUPY)
                  {
                     if(_loc8_.missionType > 0 && _loc8_.missionType < Utils.MISSION_NAMES.length)
                     {
                        _loc9_.col1 = "e-" + Utils.MISSION_NAMES[_loc8_.missionType];
                     }
                     else
                     {
                        _loc9_.col1 = "e-unknown " + _loc8_.missionType;
                     }
                     _loc9_.bgColor = 16638947;
                  }
                  else
                  {
                     _loc9_.col1 = "e-attack";
                     if(!this.isJunkTroop(_loc8_.troop))
                     {
                        if(this.isNakedScouts(_loc8_.troop))
                        {
                           _loc9_.bgColor = 14936829;
                        }
                        else
                        {
                           _loc9_.bgColor = 16638947;
                        }
                     }
                     else
                     {
                        _loc9_.bgColor = 16277260;
                     }
                  }
                  _loc9_.col2 = _loc8_.startFieldId == -1 ? "unknown of " + _loc8_.alliance : _loc8_.startPosName + " " + Map.fieldIdToString(_loc8_.startFieldId);
                  _loc9_.col3 = _loc8_.reachTime > 0 ? Utils.formatEndTime(_loc8_.reachTime) : "--:--";
                  _loc9_.col4 = -1;
                  _loc9_.col5 = _loc8_.armyId;
                  _loc9_.col6 = "enemy";
                  _loc9_.col8 = _loc8_.reachTime;
                  _loc9_.label = "Army id: " + _loc8_.armyId + (_loc8_.king == null ? "" : "\nLord: " + _loc8_.king) + "\nFrom: " + _loc9_.col2 + (_loc8_.alliance == null ? "" : "\nAlliance: " + _loc8_.alliance) + (_loc8_.hero != null ? "\nhero: " + _loc8_.hero + "(" + _loc8_.heroLevel + ")" : "") + (_loc8_.troop == null ? "" : "\n" + Utils.troopStrBeanToMsgString(_loc8_.troop)) + (_loc8_.resource == null ? "" : "\n" + resoBeanToString(_loc8_.resource)) + (_loc8_.reachTime > 0 ? "\nArrival @ " + Utils.getTimeStr(_loc8_.reachTime) + "\nStarted @ " + Utils.getTimeStr(_loc8_.startTime) : "");
                  _loc7_.addItem(_loc9_);
               }
            }
         }
         if(param3)
         {
            for each(_loc8_ in this.enemyValleyArmies)
            {
               _loc9_ = new DataRow();
               if(_loc8_.missionType >= 0 && _loc8_.missionType < Utils.MISSION_NAMES.length)
               {
                  _loc9_.col1 = "v-" + Utils.MISSION_NAMES[_loc8_.missionType];
               }
               else
               {
                  _loc9_.col1 = "v-unknown " + _loc8_.missionType;
               }
               _loc9_.bgColor = 16758454;
               _loc9_.col2 = "to " + Map.fieldIdToCoordinate(_loc8_.targetFieldId) + " from " + (_loc8_.startFieldId == -1 ? "unknown" : Map.fieldIdToCoordinate(_loc8_.startFieldId));
               _loc9_.col3 = _loc8_.reachTime > 0 ? Utils.formatEndTime(_loc8_.reachTime) : "--:--";
               _loc9_.col8 = _loc8_.reachTime;
               _loc9_.col4 = -1;
               _loc9_.col5 = _loc8_.armyId;
               _loc9_.col6 = "enemy";
               _loc9_.col8 = _loc8_.reachTime;
               _loc9_.label = "Army id: " + _loc8_.armyId + (_loc8_.king == null ? "" : "\nLord: " + _loc8_.king) + "\nFrom: " + _loc9_.col2 + (_loc8_.alliance == null ? "" : "\nAlliance: " + _loc8_.alliance) + (_loc8_.hero != null ? "\nhero: " + _loc8_.hero + "(" + _loc8_.heroLevel + ")" : "") + (_loc8_.troop == null ? "" : "\n" + Utils.troopStrBeanToMsgString(_loc8_.troop)) + (_loc8_.resource == null ? "" : "\n" + resoBeanToString(_loc8_.resource)) + (_loc8_.reachTime > 0 ? "\nArrival @ " + Utils.getTimeStr(_loc8_.reachTime) + "\nStarted @ " + Utils.getTimeStr(_loc8_.startTime) : "");
               _loc7_.addItem(_loc9_);
            }
         }
         if(param4)
         {
            for each(_loc8_ in this.enemyColonyArmies)
            {
               _loc9_ = new DataRow();
               if(_loc8_.missionType >= 0 && _loc8_.missionType < Utils.MISSION_NAMES.length)
               {
                  _loc9_.col1 = "c- " + Utils.MISSION_NAMES[_loc8_.missionType];
               }
               else
               {
                  _loc9_.col1 = "c- unknown" + _loc8_.missionType;
               }
               _loc9_.bgColor = 16758454;
               _loc9_.col2 = "to " + Map.fieldIdToCoordinate(_loc8_.targetFieldId) + " from " + (_loc8_.startFieldId == -1 ? "unknown" : Map.fieldIdToCoordinate(_loc8_.startFieldId));
               _loc9_.col3 = _loc8_.reachTime > 0 ? Utils.formatEndTime(_loc8_.reachTime) : "--:--";
               _loc9_.col4 = -1;
               _loc9_.col5 = _loc8_.armyId;
               _loc9_.col6 = "enemy";
               _loc9_.col8 = _loc8_.reachTime;
               _loc9_.label = "Army id: " + _loc8_.armyId + (_loc8_.king == null ? "" : "\nLord: " + _loc8_.king) + "\nFrom: " + _loc9_.col2 + (_loc8_.alliance == null ? "" : "\nAlliance: " + _loc8_.alliance) + (_loc8_.hero != null ? "\nhero: " + _loc8_.hero + "(" + _loc8_.heroLevel + ")" : "") + (_loc8_.troop == null ? "" : "\n" + Utils.troopStrBeanToMsgString(_loc8_.troop)) + (_loc8_.resource == null ? "" : "\n" + resoBeanToString(_loc8_.resource)) + (_loc8_.reachTime > 0 ? "\nArrival @ " + Utils.getTimeStr(_loc8_.reachTime) + "\nStarted @ " + Utils.getTimeStr(_loc8_.startTime) : "");
               _loc7_.addItem(_loc9_);
            }
         }
         if(param5)
         {
            _loc10_ = null;
            for each(_loc8_ in this.friendlyArmies)
            {
               _loc9_ = new DataRow();
               if(_loc8_.missionType != ObjConstants.ARMY_MISSION_SEND)
               {
                  if(_loc8_.missionType != ObjConstants.ARMY_MISSION_TRANS)
                  {
                     _loc9_.col1 = "f-unknown " + _loc8_.missionType;
                  }
                  else
                  {
                     _loc9_.col1 = "f-transport";
                  }
               }
               else
               {
                  _loc9_.col1 = "f-reinforce";
               }
               _loc9_.col2 = _loc8_.startPosName + " " + Map.fieldIdToString(_loc8_.startFieldId);
               _loc10_ = "";
               if(_loc8_.direction != ArmyConstants.ARMY_FORWARD)
               {
                  if(_loc8_.direction != ArmyConstants.ARMY_BACKWARD)
                  {
                     _loc9_.col1 += " from";
                  }
               }
               else
               {
                  _loc9_.col3 = Utils.formatEndTime(_loc8_.reachTime);
                  _loc10_ = "\nArrival: " + Utils.getTimeStr(_loc8_.reachTime);
               }
               if(_loc8_.missionType == ObjConstants.ARMY_MISSION_TRANS)
               {
                  _loc9_.bgColor = 13434828;
               }
               if(_loc8_.missionType == ObjConstants.ARMY_MISSION_SEND)
               {
                  _loc9_.bgColor = 15125759;
               }
               _loc9_.col8 = _loc8_.reachTime;
               _loc9_.col4 = _loc8_.direction == ArmyConstants.ARMY_STAY ? _loc8_.armyId : -1;
               _loc9_.col5 = _loc8_.armyId;
               _loc9_.col6 = "friendly";
               _loc9_.col8 = _loc8_.reachTime;
               _loc9_.label = "Army id: " + _loc8_.armyId + (_loc8_.king == null ? "" : "\nlord: " + _loc8_.king) + "\n" + _loc9_.col2 + (_loc8_.hero != null ? "\nhero: " + _loc8_.hero + " " + _loc8_.heroLevel : "") + "\n" + Utils.troopStrBeanToMsgString(_loc8_.troop) + "\n" + resoBeanToString(_loc8_.resource) + _loc10_;
               _loc7_.addItem(_loc9_);
            }
         }
         if(param6)
         {
            for each(_loc8_ in this.selfArmies)
            {
               if(!(_loc8_.targetFieldId != this.castle.fieldId || _loc8_.direction != ArmyConstants.ARMY_FORWARD))
               {
                  _loc9_ = new DataRow();
                  if(_loc8_.missionType != ObjConstants.ARMY_MISSION_SEND)
                  {
                     if(_loc8_.missionType != ObjConstants.ARMY_MISSION_TRANS)
                     {
                        _loc9_.col1 = "s-unknown " + _loc8_.missionType;
                     }
                     else
                     {
                        _loc9_.col1 = "s-transport";
                     }
                  }
                  else
                  {
                     _loc9_.col1 = "s-reinforce";
                  }
                  if(_loc8_.missionType == ObjConstants.ARMY_MISSION_TRANS)
                  {
                     _loc9_.bgColor = 13434828;
                  }
                  if(_loc8_.missionType == ObjConstants.ARMY_MISSION_SEND)
                  {
                     _loc9_.bgColor = 15125759;
                  }
                  _loc9_.col2 = _loc8_.startPosName + " " + Map.fieldIdToString(_loc8_.startFieldId);
                  _loc9_.col3 = Utils.formatEndTime(_loc8_.reachTime);
                  _loc9_.col4 = _loc8_.armyId;
                  _loc9_.col5 = _loc8_.armyId;
                  _loc9_.col6 = "self";
                  _loc9_.col8 = _loc8_.reachTime;
                  _loc9_.label = "Army id: " + _loc8_.armyId + "\n" + _loc9_.col2 + (_loc8_.hero != null ? "\nhero: " + _loc8_.hero + " " + _loc8_.heroLevel : "") + "\n" + Utils.troopStrBeanToMsgString(_loc8_.troop) + "\n" + resoBeanToString(_loc8_.resource) + "\nArrival: " + Utils.getTimeStr(_loc8_.reachTime);
                  _loc7_.addItem(_loc9_);
               }
            }
         }
         _loc7_.source.sortOn("col8");
         DataRow.copyRowArray(_loc7_,param1);
      }
      
      public function _on498(param1:String) : Boolean
      {
         this.logErrMsg("Warning: input ignored, nexttrainingpos is now computed automatically");
         return true;
      }
      
      public function _doQBuildNpc() : Boolean
      {
         var _loc1_:int = 0;
         var _loc3_:* = false;
         var _loc4_:int = 0;
         var _loc5_:* = false;
         _loc1_ = this.getAvailableRallyMaxHidingSlots() + this.getAvailableRallyMaxRainbowSlots();
         var _loc2_:* = this.getLocalArmiesCount() + _loc1_ > this.getMaxRallySlots() - 2;
         _loc3_ = this.getLocalArmiesCount() + _loc1_ < this.getMaxRallySlots();
         _loc4_ = this.getTotalAvailableHeroes() + (this.getMayor() == null ? 0 : 1);
         _loc5_ = _loc4_ >= this.getAvailableRallyMaxHidingSlots() + 1;
         if(this.getCfg(CityConfigs.CFG_BUILDNPC) > 0 && this.processBuildNpc(_loc3_,_loc5_))
         {
            return true;
         }
         if(this.getCfg(CityConfigs.CFG_FLATROLLING) > 0 && this._ci858(_loc3_,_loc5_))
         {
            return true;
         }
         return false;
      }
      
      public function _findPlayerValleys(param1:String, param2:int, param3:Number, param4:int) : void
      {
         this.fieldTargetPlayers = param1.split(",");
         this.fieldTargetPlayersCenter = param2;
         this.fieldTargetPlayersRadius = param3;
         this.fieldTargetPlayersMinLevel = param4;
         this.logMsg("Find Valleys of players " + param1 + " within " + param3 + " miles of " + Map.fieldIdToCoordString(param2));
      }
      
      private function getBestIdleHeroByTypeAndStaminaIncGear(param1:String, param2:int = -1) : HeroBean
      {
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         if(param2 == -1)
         {
            param2 = this.getMinEnergyCfg();
         }
         _loc3_ = null;
         for each(_loc4_ in this.heroes)
         {
            if(_loc4_.stamina >= param2)
            {
               if(!(_loc4_.status != HeroConstants.HERO_FREE_STATU && _loc4_.status != HeroConstants.HERO_CHIEF_STATU))
               {
                  if(!(_loc3_ != null && !Utils.isBestHeroByTypeIncGear(param1,_loc4_,_loc3_)))
                  {
                     _loc3_ = _loc4_;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function isBuildingAtPosition(param1:int) : Boolean
      {
         var _loc2_:BuildingBean = null;
         for each(_loc2_ in this.buildings)
         {
            if(_loc2_.positionId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isMarketGovRestricted() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         _loc1_ = this.getBuffIndexFromTypeId("KeepNoGetTaxBuf");
         if(_loc1_ != -1 && Utils.getServerTime() < this.player.buffsArray[_loc1_].endTime)
         {
            return true;
         }
         return false;
      }
      
      public function doHealInjuredTroop(param1:Boolean = false) : void
      {
         if(!param1 && this.healingGoldRequired < 2000000 && (!playerTimingAllowed("troophealing",10,true) || !this.cityTimingAllowed("troophealing",300) || !playerTimingAllowed("troophealing",10)))
         {
            return;
         }
         if(this.healingGoldRequired > 0 && this.estResource.gold > this.healingGoldRequired)
         {
            this.logMsg("CURING TROOPS using " + this.healingGoldRequired + " gold",COLR_DEF_LOG_MSG);
            this.healingGoldRequired = 0;
            CityStateCommands.cureInjuredTroop(this.castleId);
            this.estResource.gold -= this.healingGoldRequired;
         }
      }
      
      private function getArmyToTarget(param1:int) : ArmyBean
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.localArmies)
         {
            if(_loc2_.targetFieldId == param1 && _loc2_.direction != ArmyConstants.ARMY_BACKWARD && !this.isResoBeanEmtpy(_loc2_.resource))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get colonies() : ArrayCollection
      {
         return this.castle.colonyBeansArray;
      }
      
      public function _updateInnHandler(param1:HeroListResponse) : void
      {
         var _loc2_:HeroBean = null;
         this.innHeroes = param1.herosArray;
         if(this.getCfg(CityConfigs.CFG_HERO) <= 1)
         {
            return;
         }
         for each(_loc2_ in this.innHeroes)
         {
            if(this.getBuildingLevel(BuildingConstants.TYPE_TAVERN) >= 1 && this.doHeroHireAndFire(_loc2_))
            {
               this.innUpdateNeeded = true;
               this.heroUpdateNeeded = true;
               this.innHeroes.removeItemAt(this.innHeroes.getItemIndex(_loc2_));
               break;
            }
         }
      }
      
      private function getFieldIdUsedForHiding() : int
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:CastleBean = null;
         if(this.fields.length > 0)
         {
            return this.fields[0].id;
         }
         _loc1_ = -1;
         _loc2_ = 100000;
         for each(_loc3_ in this.player.castlesArray)
         {
            if(_loc3_.fieldId != this.castle.fieldId)
            {
               if(Map.fieldDistance(_loc3_.fieldId,this.castle.fieldId) < _loc2_)
               {
                  _loc1_ = _loc3_.fieldId;
                  _loc2_ = Map.fieldDistance(_loc3_.fieldId,this.castle.fieldId);
               }
            }
         }
         return _loc1_;
      }
      
      private function doEnemyWarning() : void
      {
         var rad:int = 0;
         var cX:int = 0;
         var cY:int = 0;
         var mCB:MapCastleBean = null;
         var y:int = 0;
         var fieldId:int = 0;
         var eList:Array = null;
         var x:int = 0;
         var sortOn:Function = null;
         if(this.getCfg(CityConfigs.CFG_ENEMYWARNING) <= 0)
         {
            return;
         }
         rad = this.getCfg(CityConfigs.CFG_ENEMYWARNING);
         if(rad > 20)
         {
            rad = 20;
         }
         cX = Map.getX(this.castle.fieldId);
         cY = Map.getY(this.castle.fieldId);
         if(!Map.isMapReady(cX,cY,rad))
         {
            return;
         }
         mCB = null;
         y = 0;
         fieldId = 0;
         eList = new Array();
         x = cX - rad;
         while(x <= cX + rad)
         {
            y = cY - rad;
            while(y <= cY + rad)
            {
               if((x - cX) * (x - cX) + (y - cY) * (y - cY) <= rad * rad)
               {
                  fieldId = Map.getFieldId(x,y);
                  if(Map.getType(fieldId,12 * 60) == FieldConstants.TYPE_CASTLE)
                  {
                     if((mCB = Map.getDetailInfo(fieldId)) != null && mCB.relation == AllianceConstants.ENEMY_ALLIANCE && this.enemyWarningAllianceIgnoreList.indexOf(mCB.allianceName) == -1 && this.enemyWarningPlayerIgnoreList.indexOf(mCB.userName) == -1)
                     {
                        if(this.cityTimingAllowed("warning" + fieldId,7 * (24 * 60 * 60)))
                        {
                           eList.push(mCB);
                        }
                     }
                  }
               }
               y++;
            }
            x++;
         }
         if(eList.length < 1)
         {
            return;
         }
         sortOn = function(param1:MapCastleBean, param2:MapCastleBean):int
         {
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            _loc3_ = Map.fieldDistance(param1.id,castle.fieldId);
            _loc4_ = Map.fieldDistance(param2.id,castle.fieldId);
            return _loc3_ < _loc4_ ? -1 : (_loc3_ > _loc4_ ? 1 : 0);
         };
         eList.sort(sortOn);
         for each(mCB in eList)
         {
            this.warLogMsg("EnemyWarning > <b>" + mCB.name + Map.fieldIdToCoordString(mCB.id) + "</b> by <b>" + mCB.userName + "</b> of <b>" + mCB.allianceName + "</b> is <b>" + Utils.formatNum(Map.fieldDistance(this.castle.fieldId,mCB.id),2) + "</b> miles away!",COLR_ERR_LOG_MSG);
         }
      }
      
      public function _getReloginWaitCfg() : Number
      {
         return this.getCfg(CityConfigs.CFG_RELOGIN) <= 0 ? 30 : this.getCfg(CityConfigs.CFG_RELOGIN);
      }
      
      public function _wb316ALX2(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:TroopBean = null;
         var _loc4_:TroopBean = null;
         var _loc5_:FortificationsBean = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         if(this.getCfg(CityConfigs.CFG_GATE) <= 0)
         {
            this.logMsg("Please set condgatepolicyALX2 *after* setting gate config");
            return false;
         }
         _loc2_ = param1.split(" ");
         if(_loc2_.length != 7 && _loc2_.length != 8)
         {
            this.logMsg("Usage: condgatepolicyALX2 troopCond(Enemy) troopCond(Local) fortCond gate1 gate2 gate3 gate4 [gate5]");
            return false;
         }
         if(_loc2_.length == 7)
         {
            _loc2_.push("0");
         }
         _loc3_ = Utils.getTroops(_loc2_[0]);
         if(_loc2_[0] != "none" && _loc3_ == null)
         {
            this.logMsg("Invalid troop condition: " + _loc2_[0]);
            return false;
         }
         _loc4_ = Utils.getTroops(_loc2_[1]);
         if(_loc2_[1] != "none" && _loc3_ == null)
         {
            this.logMsg("Invalid troop condition: " + _loc2_[0]);
            return false;
         }
         _loc5_ = Utils.getFortifications(_loc2_[2]);
         if(_loc2_[2] != "none" && _loc5_ == null)
         {
            this.logMsg("Invalid fortification condition: " + _loc2_[2]);
            return false;
         }
         _loc6_ = 3;
         while(_loc6_ < 8)
         {
            if(!this._vi518(_loc2_[_loc6_],0,4))
            {
               this.logMsg("Invalid gate value, expecting integer from 0 to 3, get: " + _loc2_[_loc6_]);
               return false;
            }
            _loc6_++;
         }
         _loc7_ = new Array(_loc3_,_loc4_,_loc5_,new Array(int(_loc2_[3]),int(_loc2_[4]),int(_loc2_[5]),int(_loc2_[6]),int(_loc2_[7])));
         this.condGateSettingsRE2.push(_loc7_);
         this.vrGateSettingCache = null;
         this.vrGateSettingCacheArmyId = 0;
         return true;
      }
      
      private function getAvailableHeroNamesFromHeroListStr(param1:Array, param2:Boolean = false) : Array
      {
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc3_:ArrayCollection = new ArrayCollection();
         var _loc4_:ArrayCollection = new ArrayCollection();
         var _loc5_:Boolean = false;
         var _loc6_:Array = new Array();
         var _loc7_:HeroBean = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         for each(_loc10_ in param1)
         {
            if(Version.isTraceOn())
            {
               trace("heroStr: " + _loc10_);
            }
            if(_loc10_.substr(0,1) == "!")
            {
               _loc8_ = this._getHeroNameFromMacroName(_loc10_.substr(1));
               if(Version.isTraceOn())
               {
                  trace("fromMacro: " + _loc8_);
               }
               if(_loc8_.indexOf(";") > -1)
               {
                  for each(_loc9_ in _loc8_.split(";"))
                  {
                     if(Version.isTraceOn())
                     {
                        trace("heroName" + _loc9_);
                     }
                     _loc4_.addItem(_loc9_);
                     if(param2 && this.isHeroInTown(_loc4_[_loc4_.length - 1]) == null)
                     {
                        this.logErrMsg("Warning: hero " + _loc4_[_loc4_.length - 1] + " is not in this town");
                     }
                  }
               }
               else
               {
                  _loc4_.addItem(_loc8_);
                  if(param2 && this.isHeroInTown(_loc4_[_loc4_.length - 1]) == null)
                  {
                     this.logErrMsg("Warning: hero " + _loc4_[_loc4_.length - 1] + " is not in this town");
                  }
               }
            }
            else if(_loc10_ == "any")
            {
               _loc5_ = true;
            }
            else if(_loc10_.substr(0,4) == "any+" || _loc10_.substr(0,4) == "any-")
            {
               for each(_loc7_ in this.getHeroesByPowerAndStamina(int(_loc10_.substring(3))))
               {
                  _loc3_.addItem(_loc7_.name.toLowerCase());
               }
            }
            else
            {
               _loc8_ = this._getHeroNameFromMacroName(_loc10_);
               if(Version.isTraceOn())
               {
                  trace("fromMacro: " + _loc8_);
               }
               if(_loc8_.indexOf(";") > -1)
               {
                  for each(_loc9_ in _loc8_.split(";"))
                  {
                     if(Version.isTraceOn())
                     {
                        trace("heroName" + _loc9_);
                     }
                     _loc3_.addItem(_loc9_);
                     if(param2 && this.isHeroInTown(_loc3_[_loc3_.length - 1]) == null)
                     {
                        this.logErrMsg("Warning: hero " + _loc3_[_loc3_.length - 1] + " is not in this town");
                     }
                  }
               }
               else
               {
                  _loc3_.addItem(_loc8_);
                  if(param2 && this.isHeroInTown(_loc3_[_loc3_.length - 1]) == null)
                  {
                     this.logErrMsg("Warning: hero " + _loc3_[_loc3_.length - 1] + " is not in this town");
                  }
               }
            }
         }
         if(_loc5_)
         {
            for each(_loc7_ in this.heroes)
            {
               if(!_loc4_.contains(_loc7_.name.toLowerCase()))
               {
                  _loc6_.push(_loc7_.name.toLowerCase());
               }
            }
         }
         else
         {
            for each(_loc11_ in _loc3_)
            {
               if(!_loc4_.contains(_loc11_.toLowerCase()))
               {
                  _loc6_.push(_loc11_.toLowerCase());
               }
            }
         }
         return _loc6_;
      }
      
      public function isMainTown() : Boolean
      {
         if(this.player.castlesArray.length <= 1)
         {
            return true;
         }
         return mainTownCastleId == this.castle.id;
      }
      
      private function updateTroopRequirements() : void
      {
         var _loc1_:TroopBean = null;
         var _loc2_:ProduceBean = null;
         var _loc3_:AllProduceBean = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:ConditionBean = null;
         var _loc8_:TroopBean = null;
         var _loc9_:int = 0;
         var _loc10_:TroopBean = null;
         var _loc11_:TroopBean = null;
         var _loc12_:CityState = null;
         var _loc13_:int = 0;
         if(this.troopRequirements == null || this.troopRequirements.length == 0)
         {
            return;
         }
         if(this.troopProduceQueue == null)
         {
            return;
         }
         if(this.troopListArray == null)
         {
            return;
         }
         _loc1_ = this.getAllTroopsInCastle();
         for each(_loc3_ in this.troopProduceQueue)
         {
            for each(_loc2_ in _loc3_.allProduceQueueArray)
            {
               _loc1_[troopIntNames[_loc2_.type]] += _loc2_.num;
            }
         }
         _loc4_ = new Array(TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER,TFConstants.T_CATAPULT);
         _loc5_ = 0;
         _loc6_ = this.getBuildingLevel(BuildingConstants.TYPE_BARRACK);
         _loc7_ = null;
         for each(_loc8_ in this.troopRequirements)
         {
            for each(_loc5_ in _loc4_)
            {
               _loc7_ = this._mb759(_loc5_);
               if(_loc7_ == null)
               {
                  return;
               }
               if(this._wb445(_loc7_,_loc6_))
               {
                  if(_loc1_[troopIntNames[_loc5_]] < _loc8_[troopIntNames[_loc5_]])
                  {
                     this.troopRequirement = _loc8_;
                     return;
                  }
               }
            }
         }
         this.troopRequirement = null;
         _loc9_ = 0;
         _loc10_ = null;
         _loc11_ = null;
         _loc12_ = null;
         _loc13_ = 0;
         while(_loc13_ < this.extraTroopFields.length)
         {
            _loc9_ = int(this.extraTroopFields[_loc13_]);
            _loc10_ = this.extraTroopExtConds[_loc13_];
            _loc11_ = this.extraTroopIntConds[_loc13_];
            if(_loc9_ != -1 && _loc10_ != null && _loc11_ != null)
            {
               _loc12_ = MainScreen.getCityFromFieldId(_loc9_);
               if(_loc12_ == null)
               {
                  return;
               }
               for each(_loc5_ in _loc4_)
               {
                  if(_loc12_.cityManager.troop[troopIntNames[_loc5_]] < _loc10_[troopIntNames[_loc5_]])
                  {
                     if(_loc1_[troopIntNames[_loc5_]] < _loc11_[troopIntNames[_loc5_]])
                     {
                        this.troopRequirement = new TroopBean();
                        this.troopRequirement[troopIntNames[_loc5_]] = _loc11_[troopIntNames[_loc5_]];
                        return;
                     }
                  }
               }
            }
            _loc13_++;
         }
      }
      
      private function isMarketReady() : Boolean
      {
         var _loc1_:int = 0;
         if(this.isMarketGovRestricted())
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(_loc1_ >= this.market.length || this.market[_loc1_] == null)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function _handleEvasion() : Boolean
      {
         var newDate:Date = null;
         var firstField:int = 0;
         var evasionEndTime:Number = NaN;
         var evasionDuration:Number = NaN;
         var rsLevel:int = 0;
         var extraSlot:int = 0;
         var maxWaves:int = 0;
         var rainbowTroops:ArrayCollection = null;
         var enemy:ArmyBean = null;
         var nWaves:int = 0;
         var layerSize:int = 0;
         var tr:TroopBean = null;
         var obj:Object = null;
         var aObj:Object = null;
         var army:ArmyBean = null;
         var allTroops:TroopBean = null;
         var archerWave:Boolean = false;
         var newArmy:NewArmyParam = null;
         var desiredWorker:int = 0;
         var handler:Function = null;
         var key:String = null;
         var desiredCata:int = 0;
         var desiredCav:int = 0;
         var desiredPike:int = 0;
         var desiredSword:int = 0;
         var desiredWarrior:int = 0;
         if(this.getCfg(CityConfigs.CFG_ADVEVASION) > 0)
         {
            if(this.getCfg(CityConfigs.CFG_ADVEVASIONDBG) >= CityConfigs.DBG_ADVEVASION)
            {
               this.logMsg(" ****  Using AdvEvasion for defense!!!  **** ",COLR_DBG_LOG_MSG);
            }
            return this._handleAdvEvasion();
         }
         if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
         {
            this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " + " EVASION > Using normal bot auto defense",COLR_DBG_LOG_MSG);
         }
         try
         {
            newDate = new Date();
            if(this.lastBattleAfterAdvMoveErrorTime != null && this.lastBattleAfterAdvMoveErrorTime.getTime() + 3600 * 1000 > newDate.getTime())
            {
               return false;
            }
            if(this.lastAmbushFromAllSideErrorTime != null && this.lastAmbushFromAllSideErrorTime.getTime() + 15 * 60 * 1000 > newDate.getTime())
            {
               return false;
            }
            firstField = this.getFieldIdUsedForHiding();
            if(firstField == -1)
            {
               return false;
            }
            evasionEndTime = this._yb134(this.getCfg(CityConfigs.CFG_ATTACKGAP));
            if(evasionEndTime == 0)
            {
               return false;
            }
            evasionDuration = (evasionEndTime - Utils.getServerTime()) / 1000 + 3;
            if(Connection.getInstance().paused)
            {
               evasionDuration += 35 * 60;
            }
            rsLevel = this.getMaxRallySlots();
            extraSlot = this.getAvailableRallyMaxHidingSlots();
            maxWaves = this.rallySettings[RALLY_RAINBOW] != -1 ? int(this.rallySettings[RALLY_RAINBOW]) : 1;
            rainbowTroops = this.getLocalHidingArmies(firstField);
            if(rainbowTroops.length >= maxWaves)
            {
               return true;
            }
            if(this.getUsedRallySlots() + extraSlot >= rsLevel)
            {
               if(this.cityTimingAllowed("rallyspotevasionproblem2",300))
               {
                  if(this.getUsedRallySlots() >= rsLevel)
                  {
                     this.logMsg("EVASION > UNABLE TO EVADE RAINBOW BECAUSE RALLYSPOT IS FULL",COLR_DEF_LOG_MSG);
                  }
                  else
                  {
                     this.logMsg("EVASION > UNABLE TO EVADE RAINBOW, remaining rally spot is for resource hiding",COLR_DEF_LOG_MSG);
                  }
               }
               return false;
            }
            if(this.enemyArmies.length == 0)
            {
               return false;
            }
            enemy = this.enemyArmies[0];
            if(enemy.missionType == ObjConstants.ARMY_MISSION_SUPPRESS)
            {
               return false;
            }
            nWaves = this._uk165(evasionEndTime + 4);
            layerSize = Utils.getTotalTroopCount(Utils.getTroopBeanFromTroopStrBean(enemy.troop)) / 100 * nWaves;
            if(layerSize < 100)
            {
               layerSize = 100;
            }
            tr = Utils.getTroopBeanFromTroopStrBean(enemy.troop);
            if(tr == null)
            {
               return false;
            }
            obj = this.troop.toObject();
            aObj = null;
            for each(army in rainbowTroops)
            {
               aObj = army.troop.toObject();
               for(key in aObj)
               {
                  obj[key] += int(aObj[key]);
               }
            }
            allTroops = new TroopBean(obj);
            archerWave = tr.archer + tr.ballista + tr.catapult > 0.67 * Utils.getTotalTroopCount(tr);
            newArmy = new NewArmyParam();
            newArmy.troops = new TroopBean();
            if(this.troop.heavyCavalry > 0)
            {
               desiredCata = this.troop.pikemen > 0 || this.troop.swordsmen > 0 ? 0 : layerSize;
               desiredCata = archerWave ? (allTroops.heavyCavalry > desiredCata ? desiredCata : (allTroops.heavyCavalry > 20 ? 10 : 1)) : 1;
               if(desiredCata > this.troop.heavyCavalry)
               {
                  desiredCata = this.troop.heavyCavalry;
               }
               newArmy.troops.heavyCavalry = Math.min(this.troop.heavyCavalry - desiredCata,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.lightCavalry > 0)
            {
               desiredCav = archerWave && tr.lightCavalry > 0 ? layerSize : (this.troop.pikemen > 0 || this.troop.swordsmen > 0 ? 0 : layerSize);
               desiredCav = archerWave ? (allTroops.lightCavalry > desiredCav ? desiredCav : (allTroops.lightCavalry > 20 ? 10 : 1)) : 1;
               if(desiredCav > this.troop.lightCavalry)
               {
                  desiredCav = this.troop.lightCavalry;
               }
               newArmy.troops.lightCavalry = Math.min(this.troop.lightCavalry - desiredCav,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.pikemen > 0)
            {
               desiredPike = layerSize;
               desiredPike = allTroops.pikemen > desiredPike ? desiredPike : (allTroops.pikemen > 20 ? 10 : 1);
               if(desiredPike > this.troop.pikemen)
               {
                  desiredPike = this.troop.pikemen;
               }
               newArmy.troops.pikemen = Math.min(this.troop.pikemen - desiredPike,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.swordsmen > 0)
            {
               desiredSword = layerSize;
               desiredSword = allTroops.swordsmen > desiredSword ? desiredSword : (allTroops.swordsmen > 20 ? 10 : 1);
               if(desiredSword > this.troop.swordsmen)
               {
                  desiredSword = this.troop.swordsmen;
               }
               newArmy.troops.swordsmen = Math.min(this.troop.swordsmen - desiredSword,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            desiredWorker = 0;
            if(this.troop.peasants > 0)
            {
               desiredWorker = layerSize;
               desiredWorker = allTroops.peasants > desiredWorker ? desiredWorker : (allTroops.peasants > 20 ? 10 : 1);
               if(desiredWorker > this.troop.peasants)
               {
                  desiredWorker = this.troop.peasants;
               }
               newArmy.troops.peasants = Math.min(this.troop.peasants - desiredWorker,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.militia > 0)
            {
               desiredWarrior = layerSize;
               desiredWarrior = allTroops.militia > desiredWarrior ? desiredWarrior : (allTroops.militia > 20 ? 10 : 1);
               if(desiredWarrior > this.troop.militia)
               {
                  desiredWorker = this.troop.militia;
               }
               newArmy.troops.militia = Math.min(this.troop.militia - desiredWarrior,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(this.troop.scouter > 0 && this.troop.scouter < 50000)
            {
               newArmy.troops.scouter = Math.min(this.troop.scouter,this.getRallyDispatchPerArmyLimit(true) - Utils.getTotalTroopCount(newArmy.troops));
            }
            if(Utils.getTotalTroopCount(newArmy.troops) < 10)
            {
               return true;
            }
            newArmy.targetPoint = firstField;
            newArmy.missionType = ObjConstants.ARMY_MISSION_SEND;
            newArmy.restTime = evasionDuration;
            newArmy.resource = new ResourceBean();
            newArmy.resource.gold = 2;
            if(!this.cityTimingAllowed("rainbowEvasionThrottle",3))
            {
               return false;
            }
            if(!this.isEnoughResourcesToMarch(newArmy))
            {
               if(this.cityTimingAllowed("evasionretrymsg2",120))
               {
                  this.logMsg("EVASION > NOT ENOUGH RESOURCE TO SEND OUT RAINBOW",COLR_DEF_LOG_MSG);
               }
               return false;
            }
            this.logMsg("EVASION > sending rainbow " + Utils.troopBeanToString(newArmy.troops) + " to " + Map.fieldIdToString(firstField) + " for " + Utils.formatTime(evasionDuration),COLR_DEF_LOG_MSG);
            handler = null;
            handler = function(param1:CommandResponse):void
            {
               if(MasterTimer.getInstance().canSend(timeSlot))
               {
                  handleArmyCommandResponse(param1);
               }
               if(param1.ok == 1)
               {
                  Utils.callLater(evasionDuration * 1000,_vc796,[newArmy]);
               }
            };
            CityStateCommands.newArmy(this.castleId,newArmy,handler);
            MasterTimer.getInstance().reserveEmergencySlot(this.timeSlot);
            this.doEstimateResource();
            this.adjEstFoodAfterMarch(newArmy);
         }
         catch(error:Error)
         {
            if(Boolean(this.cityTimingAllowed("evasionerror",60)) || this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg((this.getCfg(CityConfigs.CFG_DEBUG) > 0 ? "DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > " : "") + "EVASION > Error while handling: startRainbowEvasion, " + error.message + "\n" + error.getStackTrace(),COLR_DBG_LOG_MSG);
            }
            return false;
         }
         return true;
      }
      
      public function _ov14(param1:int, param2:Boolean = false) : void
      {
         if(this.evacuationTown != -1 && this.evacuationTown != param1)
         {
            this.logMsg("Please run endevacuate first");
         }
         else
         {
            if(this.evacuationTown == param1)
            {
               this.logMsg("Update evacuation to " + Map.fieldIdToCoordString(param1));
            }
            else
            {
               this.logMsg("Start evacuation to " + Map.fieldIdToCoordString(param1));
            }
            this.evacuationTown = param1;
            Map.updateDetailInfo(param1);
            this.evacuateTroopOnly = param2;
         }
      }
      
      private function _on1315() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:MapCastleBean = null;
         var _loc5_:int = 0;
         var _loc6_:ArmyBean = null;
         if(this.lastFastTargetLevel != -1 && this.lastFastTargetField != -1)
         {
            _loc1_ = -1;
            _loc2_ = NaN;
            _loc3_ = NaN;
            _loc4_ = null;
            _loc5_ = 0;
            for each(_loc6_ in this.localArmies)
            {
               if(_loc6_.targetFieldId == this.lastFastTargetField && _loc6_.missionType == ObjConstants.ARMY_MISSION_OCCUPY && _loc6_.direction == ArmyConstants.ARMY_FORWARD)
               {
                  _loc2_ = _loc6_.reachTime - Utils.getServerTime();
                  _loc3_ = Math.max(30,Math.min(15 * 60,_loc2_ / 1000 * 0.8));
                  _loc4_ = Map.getDetail(_loc6_.targetFieldId,_loc3_);
                  _loc5_ = Map.getLevel(_loc6_.targetFieldId,_loc3_);
                  if(_loc5_ != -1 && _loc5_ != this.lastFastTargetLevel || _loc4_ != null && _loc4_.userName != null && _loc4_.userName != this.player.playerInfo.userName)
                  {
                     this.logMsg("HUNTING > Local target field changed, recall troop " + _loc6_.armyId + " toward " + Map.fieldIdToString(_loc6_.targetFieldId),COLR_STD_LOG_MSG);
                     CityStateCommands.callBackArmy(this.castleId,_loc6_.armyId);
                     _loc1_ = _loc5_;
                  }
               }
            }
            if(_loc1_ != -1)
            {
               this.lastFastTargetLevel = _loc1_;
            }
         }
      }
      
      public function _onFieldUpdate_handleAtkEnemyFieldAndHunting(param1:int) : void
      {
         if(this.fieldTargetEnemyAlliances != null)
         {
            this.logMsg("Abandon enemy field " + Map.fieldIdToString(param1),COLR_STD_LOG_MSG);
            CityStateCommands.giveUpField(param1);
         }
         else if(this.getCfg(CityConfigs.CFG_HUNTING) > 0)
         {
            this._xa758();
         }
      }
      
      private function _mo519(param1:CityCondition) : Boolean
      {
         if(param1.isBuilding)
         {
            if(param1.level == 0)
            {
               return this.getBuildingsCountByTypeAndLvl(param1.typeId,1) <= param1.count;
            }
            return this.getBuildingsCountByTypeAndLvl(param1.typeId,param1.level) >= param1.count;
         }
         return this.isResearchAtLevel(param1.typeId,param1.level);
      }
      
      private function doResearch() : void
      {
         var _loc4_:String = null;
         if(this.getBuildingsCountByTypeAndLvl(BuildingConstants.TYPE_ACADEMY,1) == 0)
         {
            return;
         }
         var _loc1_:AvailableResearchListBean = this.getResearchInProgress();
         if(_loc1_ != null)
         {
            return;
         }
         var _loc2_:CityCondition = this._rd244();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ConditionBean = this.getConditionBeanForUpgradingTo(_loc2_);
         if(!this.cityTimingAllowed("research",10))
         {
            return;
         }
         this.promoteBestInteHero();
         this.logMsg("RESEARCH > research " + TechType.toString(_loc2_.typeId) + " to level " + _loc2_.level,COLR_STD_LOG_MSG);
         CityStateCommands.research(this.castleId,_loc2_.typeId,this._rv270);
         for each(_loc4_ in resourceIntNames)
         {
            this.estResource[_loc4_] -= _loc3_[_loc4_];
         }
      }
      
      public function get troop() : TroopBean
      {
         return this.castle.troop;
      }
      
      public function _updateLocalArmies(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:ArmyBean = null;
         this.heroUpdateNeeded = true;
         _loc2_ = Utils.getServerTime() - 15 * 60 * 1000;
         for each(_loc3_ in param1)
         {
            if(_loc3_.reachTime != 0 && _loc3_.reachTime < _loc2_ && _loc3_.direction != ArmyConstants.ARMY_BACKWARD)
            {
               if(this.cityTimingAllowed("staletroop" + _loc3_.armyId,15 * 60))
               {
                  this.logMsg("Recall stale own army to " + Map.fieldIdToCoordString(_loc3_.targetFieldId),COLR_STD_LOG_MSG);
                  CityStateCommands.callBackArmy(this.castleId,_loc3_.armyId);
               }
            }
         }
         param1.sortOn("armyId");
         this.localArmies = param1;
      }
      
      private function getListOfLhNamesInTown() : String
      {
         var _loc2_:HeroBean = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.heroes)
         {
            if(_loc2_.isHero == 4)
            {
               _loc1_ += (_loc1_ != "" ? ";" : "") + _loc2_.name;
            }
         }
         return _loc1_;
      }
      
      private function workOutAvailableFood() : Number
      {
         var _loc1_:Number = NaN;
         if(this.resource.troopCostFood < -3000000)
         {
            return 600000000;
         }
         _loc1_ = Math.max(this.getTroopFoodValue(this.getAllTroopsInCastle()),this.resource.troopCostFood);
         if(_loc1_ > this.resource.food.increaseRate)
         {
            return 24 * (1 + this.getCfg(CityConfigs.CFG_EXTRAFOOD)) * (_loc1_ - this.resource.food.increaseRate);
         }
         return 0;
      }
      
      public function _pi862() : void
      {
         if(this.honorAttackFieldId != -1)
         {
            this.logMsg("Done with honor attack on " + Map.fieldIdToString(this.honorAttackFieldId) + ", please recall army manually if necessary");
            if(this.honorAttackGuard)
            {
               this._recallLocalArmiesToTarget(this.honorAttackFieldId);
            }
            this.honorAttackFieldId = -1;
         }
         else
         {
            this.logMsg("No current honor attack");
         }
      }
      
      public function _setRallyMax(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         _loc2_ = new Array("npc","buildnpc","hunting","valley","keepresource","keeptroop","requesthelp","hiding","rainbow");
         _loc3_ = true;
         _loc4_ = param1.toLowerCase().split(",");
         _loc5_ = null;
         _loc6_ = 0;
         for each(_loc7_ in _loc4_)
         {
            _loc5_ = _loc7_.split(":");
            if(_loc5_.length != 2)
            {
               this.logErrMsg("Invalid rallymax setting, expecting name:value but getting " + _loc7_);
               _loc3_ = false;
            }
            else if(_loc2_.indexOf(_loc5_[0]) != -1)
            {
               if(Utils.hasValue(_loc5_[1]))
               {
                  _loc6_ = int(_loc2_.indexOf(_loc5_[0]));
                  if(this.defaultRallySettings[_loc6_] != -1)
                  {
                     this.logMsg("rallymax value of " + _loc5_[0] + " is changed to " + _loc5_[1] + ", previous value discarded");
                  }
                  this.defaultRallySettings[_loc6_] = Number(_loc5_[1]);
               }
               else
               {
                  this.logErrMsg("Invalid numeric value of rallymax for " + _loc5_[0] + ": " + _loc5_[1]);
                  _loc3_ = false;
               }
            }
            else
            {
               this.logErrMsg("Invalid rallymax name: " + _loc5_[0] + ", available: " + _loc2_.join(" "));
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function doLoyaltyAttack() : void
      {
         var _loc1_:MapCastleBean = null;
         var _loc2_:int = 0;
         var _loc3_:HeroBean = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:NewArmyParam = null;
         if(this.loyaltyAttackFieldId == -1)
         {
            return;
         }
         if(this.getLocalArmiesCount() >= this.getMaxRallySlots())
         {
            return;
         }
         _loc1_ = Map.getDetail(this.loyaltyAttackFieldId);
         if(_loc1_ == null)
         {
            return;
         }
         if(!_loc1_.canOccupy || _loc1_.state != 1 && _loc1_.state != 4 && (_loc1_.powerLevel > 3 || _loc1_.powerLevel < 0))
         {
            this.logMsg("CANNOT DO LOYALTY ATTACK ON " + Map.fieldIdToString(this.loyaltyAttackFieldId));
            this._le863();
            return;
         }
         _loc2_ = Map.getType(this.loyaltyAttackFieldId);
         if(_loc2_ == -1)
         {
            return;
         }
         if(_loc2_ != FieldConstants.TYPE_CASTLE)
         {
            this.logMsg("Loyalty attack target is not a castle: " + Map.fieldIdToString(this.loyaltyAttackFieldId));
            this._le863();
            return;
         }
         if(this.loyaltyAttackNumCav > this.getRallyDispatchPerArmyLimit(true))
         {
            this.logMsg("TOO MANY TROOPS USED IN LOYALTY ATTACK ON " + Map.fieldIdToString(this.loyaltyAttackFieldId));
            this._le863();
            return;
         }
         if(this.troop.lightCavalry < this.loyaltyAttackNumCav)
         {
            return;
         }
         _loc3_ = this._fr173();
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = 1000;
         _loc5_ = Map.fieldDistance(this.loyaltyAttackFieldId,this.castle.fieldId);
         _loc6_ = _loc5_ * 60000 / _loc4_ / (1 + 0.05 * this.getTechLevel(TechConstants.DRIVE_SKILL));
         _loc7_ = this.getCfg(CityConfigs.CFG_RESPONSE) > 0 ? int(this.getCfg(CityConfigs.CFG_RESPONSE) + 3) : 15;
         _loc8_ = this.loyaltyAttackOnly || this.loyaltyValue >= 10 ? _loc7_ : int(Math.max(30,_loc6_ / 3));
         _loc9_ = new NewArmyParam();
         _loc9_.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
         _loc9_.troops = new TroopBean();
         _loc9_.troops.lightCavalry = this.loyaltyAttackNumCav;
         if(this.troop.scouter > 1)
         {
            _loc9_.troops.scouter = 1;
         }
         _loc9_.resource = new ResourceBean();
         _loc9_.heroId = _loc3_.id;
         _loc9_.targetPoint = this.loyaltyAttackFieldId;
         if(!this.isEnoughResourcesToMarch(_loc9_))
         {
            return;
         }
         if(Utils.getTotalTroopCount(_loc9_.troops) > this.getRallyDispatchPerArmyLimit(true))
         {
            this.logMsg("TOO MANY TROOPS USED IN LOYALTY ATTACK ON " + Map.fieldIdToString(this.loyaltyAttackFieldId));
            this._le863();
            return;
         }
         if(!playerTimingAllowed("loyaltyattack",3,false) || !this.cityTimingAllowed("loyaltyattack",_loc8_))
         {
            return;
         }
         playerTimingAllowed("loyaltyattack",3);
         if(_loc3_.loyalty < 100 && this.estResource.gold > 1000 * _loc3_.level && this.cityTimingAllowed("reward" + _loc3_.id,900))
         {
            CityStateCommands.awardGold(this.castleId,_loc3_.id);
         }
         Map.updateDetailInfo(this.loyaltyAttackFieldId);
         Map.updateInfo(this.loyaltyAttackFieldId);
         this.logMsg("Loyalty attack on " + Map.fieldIdToString(this.loyaltyAttackFieldId) + " with hero " + _loc3_.name + " and " + _loc9_.troops.lightCavalry + " cavalries " + Utils.formatTime(this.getTravelTimeReliefStationAdj(_loc9_) / Utils.getHeroSpeedFactor(_loc3_)));
         if(MasterTimer.getInstance().canSend(this.timeSlot))
         {
            CityStateCommands.newArmy(this.castleId,_loc9_,this.handleArmyCommandResponse);
         }
         else
         {
            CityStateCommands.newArmy(this.castleId,_loc9_);
         }
         this.adjEstFoodAfterMarch(_loc9_);
      }
      
      public function _by1090(param1:int, param2:TroopBean, param3:int, param4:Boolean = false) : void
      {
         if(this.honorAttackFieldId != -1)
         {
            if(this.honorAttackFieldId == param1)
            {
               this.logMsg("Update honor attack on " + Map.fieldIdToString(param1));
               this.honorAttackFieldId = param1;
               this.honorTroopBean = param2;
               this.honorAttackGuard = param4;
               this.maxHonorLost = param3;
            }
            else
            {
               this.logMsg("Please cancel honor attack on " + Map.fieldIdToString(this.honorAttackFieldId) + " first");
            }
         }
         else
         {
            this.logMsg("Start honor attack on " + Map.fieldIdToString(param1));
            this.honorAttackFieldId = param1;
            this.honorTroopBean = param2;
            this.honorAttackGuard = param4;
            this.maxHonorLost = param3;
         }
      }
      
      public function _handleNewReport(param1:NewReport) : void
      {
         this.lastNewReport = param1;
         this.doNewReport();
      }
      
      private function processAutoGear() : void
      {
         var _loc1_:HeroBean = null;
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc4_:HeroBean = null;
         if(!(this.getCfg(CityConfigs.CFG_AUTOGEAR) > 0 && this.isGearAvailable()))
         {
            return;
         }
         _loc1_ = this.getWorstRegularHero();
         _loc2_ = this.getCfg(CityConfigs.CFG_AUTOGEAR) == 2;
         _loc3_ = this.getCfg(CityConfigs.CFG_AUTOGEAR) == 3;
         for each(_loc4_ in this.heroes)
         {
            if(!(_loc4_.level < 10 || _loc4_.status != HeroConstants.HERO_FREE_STATU || _loc4_.id == this.lastPromoteId))
            {
               if(_loc4_ != _loc1_)
               {
                  if(this.cityTimingAllowed("heroautogearchange" + _loc4_.id,60))
                  {
                     if((_loc4_.speed == 0 || _loc4_.politics <= _loc4_.intelligence || _loc4_.politics <= _loc4_.attack) && _loc4_.management >= _loc4_.stratagem && _loc4_.management >= _loc4_.power && !_loc2_ && !_loc3_)
                     {
                        this.logMsg("AUTOGEAR > Changing gear on " + Utils.heroBeanToString(_loc4_) + " to pol",COLR_STD_LOG_MSG);
                        ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc4_.id,1,this.handleCommandResponse);
                     }
                     else if((_loc4_.speed == 0 || _loc4_.intelligence <= _loc4_.politics || _loc4_.intelligence <= _loc4_.attack) && (_loc4_.stratagem > _loc4_.management && _loc4_.stratagem >= _loc4_.power && !_loc2_ || !_loc2_ && _loc3_))
                     {
                        this.logMsg("AUTOGEAR > Changing gear on " + Utils.heroBeanToString(_loc4_) + " to int",COLR_STD_LOG_MSG);
                        ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc4_.id,3,this.handleCommandResponse);
                     }
                     else if((_loc4_.speed == 0 || _loc4_.attack <= _loc4_.intelligence || _loc4_.attack <= _loc4_.politics) && (_loc4_.power > _loc4_.management && _loc4_.power > _loc4_.stratagem && !_loc3_ || _loc2_ && !_loc3_))
                     {
                        this.logMsg("AUTOGEAR > Changing gear on " + Utils.heroBeanToString(_loc4_) + " to atk",COLR_STD_LOG_MSG);
                        ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(_loc4_.id,2,this.handleCommandResponse);
                     }
                  }
               }
            }
         }
      }
      
      private function onHireHeroResponse(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logErrMsg("hero hire error: " + param1.errorMsg);
         }
      }
      
      private function reportHandler(param1:ReportResponse) : void
      {
         var isDefScout:Boolean;
         var report:ReportBean = null;
         var type:String = null;
         var xml:XML = null;
         var startField:int = 0;
         var targetField:int = 0;
         var myTroop:Boolean = false;
         var responseTime:Number = NaN;
         var winItems:String = null;
         var defendKing:String = null;
         var slowScout:Boolean = false;
         var isWar:Boolean = false;
         var attackTroopCount:int = 0;
         var isJunk:Boolean = false;
         var keepJunkArmyReports:Boolean = false;
         var shouldDelete:Boolean = false;
         var isAttackSuccess:String = null;
         var isSeize:String = null;
         var problem:String = null;
         var loyalty:int = 0;
         var scoutHonorValue:String = null;
         var attackScoutCount:int = 0;
         var isJunkScout:Boolean = false;
         var honorStr:String = null;
         var honor:int = 0;
         var isScoutSuccess:String = null;
         var troopsXML:XMLList = null;
         var fortXML:XMLList = null;
         var reportUrl:String = null;
         var response:ReportResponse = param1;
         if(response.ok != 1)
         {
            if(this.isMainTown())
            {
               this.logMsg("Read report/mark as read error: " + response.errorMsg);
            }
            return;
         }
         report = response.report;
         if(report.isRead != 0)
         {
            return;
         }
         type = report.back ? "BACK" : (report.attack ? "ATT" : "DEFENSE");
         xml = new XML(report.content);
         startField = this.getFieldIdFromCoordStr(report.startPos);
         targetField = this.getFieldIdFromCoordStr(report.targetPos);
         myTroop = this.castle.fieldId == startField || this.castle.fieldId == targetField || this.isValley(targetField);
         responseTime = Utils.rand(7,15);
         if(this.getCfg(CityConfigs.CFG_RESPONSE) > 0)
         {
            responseTime = this.getCfg(CityConfigs.CFG_RESPONSE);
         }
         if(xml.policyReport.@detail.toString() != "")
         {
            if(xml.policyReport.@detail.toString().indexOf(" " + this.castle.name + ".",80) > -1)
            {
               this.warLogMsg("Policy: " + xml.policyReport.@detail.toString().replace(").","). "),"#F272F2");
            }
            return;
         }
         if(xml.declaredWarReport.@myself.toString() != "")
         {
            if(this.isMainTown())
            {
               this.warLogMsg(report.startPos + " declares war on " + report.targetPos,COLR_ERR_LOG_MSG);
            }
            return;
         }
         if(report.attack && report.armyType == ObjConstants.ARMY_MISSION_OCCUPY && targetField == this.loyaltyAttackFieldId)
         {
            isAttackSuccess = xml.battleReport.@isAttackSuccess;
            isSeize = xml.battleReport.@isSeize;
            problem = xml.battleReport.@seizeProblem;
            loyalty = this._vg607(problem);
            if(loyalty != -1)
            {
               this.loyaltyValue = loyalty;
            }
            if(isAttackSuccess != "false")
            {
               if(isSeize != "true")
               {
                  if(myTroop)
                  {
                     this.warLogMsg("Attack is successful: " + problem);
                  }
                  if(problem.search("This is the last city") != 0)
                  {
                     if(loyalty != -1 && loyalty <= 7 && this.loyaltyAttackOnly)
                     {
                        Utils.callLater(responseTime * 1000,this._le863);
                     }
                     else if(problem.search("You need further promotion") == 0)
                     {
                        Utils.callLater(responseTime * 1000,this._le863);
                     }
                  }
                  else
                  {
                     Utils.callLater(responseTime * 1000,this._le863);
                  }
               }
               else
               {
                  if(myTroop)
                  {
                     this.warLogMsg("Attack is successful, town captured");
                  }
                  Utils.callLater(responseTime * 1000,this._le863);
               }
            }
            else if(!this._lk746(xml.battleReport.attackTroop.troopUnit) && !this._cd549(xml.battleReport.attackTroop.troopUnit))
            {
               if(myTroop)
               {
                  this.warLogMsg("Attack fails, recalling loyalty attacks in " + responseTime + " seconds...");
               }
               Utils.callLater(responseTime * 1000,this._le863);
            }
         }
         if(!myTroop)
         {
            return;
         }
         if(report.armyType == ObjConstants.ARMY_MISSION_SCOUT)
         {
            scoutHonorValue = xml.scoutReport.battleInfo.@honor;
            attackScoutCount = this.getTotalTroopCountFromDefReport(xml.scoutReport.battleInfo.attackTroop.troopUnit);
            isJunkScout = xml.scoutReport.@isAttack != "true" && xml.scoutReport.battleInfo.@isAttackSuccess == "false" && attackScoutCount > 0 && this.getCfg(CityConfigs.CFG_JUNKSCOUT) > 0 && attackScoutCount < this.getCfg(CityConfigs.CFG_JUNKSCOUT);
            if(MainScreen.getMainTownCityState().cityManager._isScoutWarningOn() && xml.scoutReport.@isAttack != "true" && !isJunkScout)
            {
               if(xml.scoutReport.@isSuccess != "true")
               {
                  MainScreen.attemptedSound.play();
               }
               else
               {
                  MainScreen.scoutedSound.play();
               }
            }
            if(!isJunkScout && scoutHonorValue != "")
            {
               try
               {
                  this.warLogMsg("Scout: Honor " + scoutHonorValue + ", Hero Exp:" + xml.scoutReport.battleInfo.@heroExp + ", attackers: " + xml.scoutReport.battleInfo.attackTroop.troopUnit[0].@count + "/" + xml.scoutReport.battleInfo.attackTroop.troopUnit[0].@lose + ", defenders " + xml.scoutReport.battleInfo.defendTroop.troopUnit[0].@count + "/" + xml.scoutReport.battleInfo.defendTroop.troopUnit[0].@lose);
               }
               catch(error:Error)
               {
                  this.warLogMsg("Scout: Honor " + scoutHonorValue + ", Hero Exp:" + xml.scoutReport.battleInfo.@heroExp);
               }
            }
            if(this.castle.fieldId == targetField && !report.attack)
            {
               this.doAutoUseTruce(1000,true,false,false,false);
            }
            if(xml.scoutReport.@isSuccess == "true")
            {
               if(xml.scoutReport.@isAttack != "true")
               {
                  this.warLogMsg("  <i>Enemy has scouted your town successfully!</i>",COLR_ERR_LOG_MSG);
                  if(this.castle.fieldId == targetField)
                  {
                     this.doAutoUseTruce(1000,true,true,false,false);
                  }
               }
               else if(targetField != this.currentSlowTarget)
               {
                  this.warLogMsg("Scout " + report.targetPos + ": " + _wd318(xml.scoutReport));
               }
               else
               {
                  this.logMsg("Scout " + report.targetPos + ": " + _wd318(xml.scoutReport));
               }
            }
         }
         if(targetField == this.honorAttackFieldId && report.attack && report.armyType == ObjConstants.ARMY_MISSION_OCCUPY)
         {
            honorStr = xml.battleReport.@honor;
            honor = 0;
            if(honorStr != "" && Utils.hasValue(honorStr))
            {
               honor = int(honorStr);
            }
            if(this.maxHonorLost >= 0 && -honor >= this.maxHonorLost)
            {
               this.warLogMsg("Losing honor in attack, honor " + honorStr + ", max lost " + this.maxHonorLost + ", end honor attack");
               this._pi862();
            }
            else if(this.maxHonorLost < 0 && -honor <= this.maxHonorLost + 1)
            {
               this.warLogMsg("Gaining honor in attack, honor " + honorStr + ", max gain " + (this.maxHonorLost - 1) + ", end honor attack");
               this._pi862();
            }
            else
            {
               this.warLogMsg("Honor gain: " + honorStr);
            }
         }
         if(targetField == this.currentSlowTarget && report.attack && report.armyType == ObjConstants.ARMY_MISSION_SCOUT)
         {
            lastSlowTargetTroops[this.currentSlowTarget] = this._de301(xml.scoutReport.scoutInfo.troops.troopStrType);
         }
         if(report.attack && report.armyType == ObjConstants.ARMY_MISSION_OCCUPY && this.guardedAttackFieldId != -1 && targetField == this.guardedAttackFieldId && this._yw212(this.guardedAttackFieldId) == 0)
         {
            this.warLogMsg("Attack on guarded field, end guard");
            this.guardedAttackFieldId = -1;
         }
         if(this.guardedAttackFieldId != -1 && report.attack && report.armyType == ObjConstants.ARMY_MISSION_SCOUT && targetField == this.guardedAttackFieldId)
         {
            isScoutSuccess = xml.scoutReport.@isSuccess;
            troopsXML = xml.scoutReport.scoutInfo.troops.troopStrType;
            fortXML = xml.scoutReport.scoutInfo.fortifications.fortificationsType;
            if(isScoutSuccess != "false")
            {
               if(this._co450(troopsXML,this.guardedTroopBean) || this._ff608(fortXML,this.guardedFortificationsBean))
               {
                  this.warLogMsg("Condition for guarded attack not met, recall attack troop in " + responseTime + "s");
                  Utils.callLater(responseTime * 1000,this._sn863);
               }
            }
            else
            {
               this.warLogMsg("Scouting failed, recall guarded attack troop in " + responseTime + "s");
               Utils.callLater(responseTime * 1000,this._sn863);
            }
         }
         if(report.armyType == ObjConstants.ARMY_MISSION_OCCUPY && !report.attack && xml.battle.@isAttackSuccess == "true")
         {
            if(this.castle.fieldId == targetField)
            {
               this.doAutoUseTruce(1000,false,false,true,true);
            }
         }
         winItems = xml.battleReport.@attackWinnerItems;
         defendKing = xml.battleReport.defendTroop.@king;
         isDefScout = report.armyType == ObjConstants.ARMY_MISSION_SCOUT && this.castle.fieldId == targetField && xml.scoutReport.@isAttack != "true";
         slowScout = report.armyType == ObjConstants.ARMY_MISSION_SCOUT && targetField == this.currentSlowTarget;
         isWar = report.armyType == ObjConstants.ARMY_MISSION_SCOUT && !slowScout || (report.armyType == ObjConstants.ARMY_MISSION_OCCUPY || report.armyType == ObjConstants.ARMY_MISSION_COLONIZE) && (!report.attack || report.attack && (defendKing != "" || xml.battleReport.toString() == ""));
         attackTroopCount = this.getTotalTroopCountFromDefReport(xml.battleReport.attackTroop.troopUnit);
         isJunk = xml.battleReport.@isAttackSuccess == "false" && (report.armyType == ObjConstants.ARMY_MISSION_OCCUPY || report.armyType == ObjConstants.ARMY_MISSION_COLONIZE) && attackTroopCount > 0 && attackTroopCount < this.getCfg(CityConfigs.CFG_JUNKWAVE);
         keepJunkArmyReports = this.getCfg(CityConfigs.CFG_KEEPJUNKARMYREPORTS) > 0;
         shouldDelete = true;
         if(isWar)
         {
            shouldDelete = true;
         }
         if(!report.attack)
         {
            shouldDelete = false;
         }
         if(report.title.search("Attack Reports") == -1 && !slowScout)
         {
            shouldDelete = false;
         }
         if((this.getCfg(CityConfigs.CFG_HUNTING) > 0 || this.getCfg(CityConfigs.CFG_SLOWHUNTING) > 0 || this.getCfg(CityConfigs.CFG_KEEPREPORTS) == 2) && winItems != "")
         {
            shouldDelete = false;
         }
         if(report.attack && defendKing != "")
         {
            shouldDelete = false;
         }
         if(Boolean(report.targetPos.search("Barbarian")) && this.getCfg(CityConfigs.CFG_DEBUG) == CityConfigs.DBG_NPCATTACK)
         {
            shouldDelete = false;
         }
         if(this.getCfg(CityConfigs.CFG_KEEPREPORTS) == 2 && report.targetPos.search("Barbarian") != -1 && this._tx683(xml.battleReport.attackTroop.troopUnit))
         {
            shouldDelete = false;
         }
         if(this.getCfg(CityConfigs.CFG_KEEPREPORTS) == 1)
         {
            shouldDelete = false;
         }
         if(this.getCfg(CityConfigs.CFG_KEEPREPORTS) != 1 && report.title.search("Attackers Returned") > -1 || report.title.search("New city building team") > -1)
         {
            ActionFactory.getInstance().getReportCommands().deleteReport("" + report.id);
         }
         else if(report.attack && (isJunk && !keepJunkArmyReports || shouldDelete))
         {
            ActionFactory.getInstance().getReportCommands().deleteReport("" + report.id);
            if(!(isJunk && !keepJunkArmyReports))
            {
               this.logMsg(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos,"#006666");
            }
         }
         else if(!report.attack && (isJunk && !keepJunkArmyReports || isJunkScout && this.getCfg(CityConfigs.CFG_KEEPJUNKSCOUTREPORTS) < 1))
         {
            ActionFactory.getInstance().getReportCommands().deleteReport("" + report.id);
         }
         else
         {
            reportUrl = xml.@reportUrl;
            if(isWar)
            {
               if(reportUrl == null || reportUrl == "")
               {
                  if(!(isJunk && !keepJunkArmyReports))
                  {
                     this.warLogMsg(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos);
                  }
               }
               else if(!(isJunk && !keepJunkArmyReports))
               {
                  this.warLogMsg(Utils.formatUrl(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos,reportUrl));
               }
               if(report.armyType == ObjConstants.ARMY_MISSION_OCCUPY || report.armyType == ObjConstants.ARMY_MISSION_COLONIZE)
               {
                  if(!(isJunk && !keepJunkArmyReports))
                  {
                     this.warLogMsg("  " + Utils.armyReportToString(xml.battleReport));
                  }
               }
            }
            else
            {
               if(reportUrl == null || reportUrl == "")
               {
                  if(!(isJunk && !keepJunkArmyReports))
                  {
                     this.logMsg(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos);
                  }
               }
               else if(!(isJunk && !keepJunkArmyReports))
               {
                  this.logMsg(Utils.formatUrl(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos,reportUrl));
               }
               if(report.armyType == ObjConstants.ARMY_MISSION_OCCUPY || report.armyType == ObjConstants.ARMY_MISSION_COLONIZE)
               {
                  if(!(isJunk && !keepJunkArmyReports))
                  {
                     this.logMsg("  " + Utils.armyReportToString(xml.battleReport));
                  }
               }
            }
         }
      }
      
      private function _fg739() : Boolean
      {
         var _loc1_:Date = null;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this.modifiedLoginSchedule == null)
         {
            return true;
         }
         _loc1_ = new Date();
         _loc1_.setTime(Utils.getServerTime());
         _loc2_ = _loc1_.getHours() * 60 + _loc1_.getMinutes();
         _loc3_ = 0;
         while(_loc3_ < this.modifiedLoginSchedule.length - 1)
         {
            if(this.modifiedLoginSchedule[_loc3_] < this.modifiedLoginSchedule[_loc3_ + 1] && this.modifiedLoginSchedule[_loc3_] <= _loc2_ && _loc2_ <= this.modifiedLoginSchedule[_loc3_ + 1])
            {
               return true;
            }
            if(this.modifiedLoginSchedule[_loc3_] > this.modifiedLoginSchedule[_loc3_ + 1] && (this.modifiedLoginSchedule[_loc3_] <= _loc2_ || _loc2_ <= this.modifiedLoginSchedule[_loc3_ + 1]))
            {
               return true;
            }
            _loc3_ += 2;
         }
         return false;
      }
      
      private function _te955() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:FieldBean = null;
         if(estimateMaintenanceDownTime > Utils.getServerTime())
         {
            return false;
         }
         _loc1_ = this.getCfg(CityConfigs.CFG_HUNTING) > 0 ? 1 : 0;
         _loc2_ = this.getCfg(CityConfigs.CFG_BUILDNPC) > 0 || buildCityLocation != -1 ? 1 : 0;
         if(this.fields.length + Math.max(_loc1_,_loc2_) < this.getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL))
         {
            return true;
         }
         _loc3_ = this._jk900();
         if(_loc3_ == null)
         {
            return false;
         }
         if(!this._bv514(_loc3_.type) || _loc3_.level < this.getCfg(CityConfigs.CFG_VALLEY))
         {
            this.logMsg("Abandon field: " + Map.fieldIdToString(_loc3_.id),COLR_STD_LOG_MSG);
            CityStateCommands.giveUpField(_loc3_.id);
            return true;
         }
         return false;
      }
      
      private function doRescueTownNewArmy(param1:CityManager, param2:Number = 0) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:NewArmyParam = null;
         var _loc7_:Array = null;
         var _loc8_:TroopBean = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         if(this.isCanCounterAmbush())
         {
            return -1;
         }
         _loc3_ = 1 + 0.1 * this.getTechLevel(TechConstants.LOAD_TECH);
         _loc4_ = this.getRallyDispatchPerArmyLimit(true);
         if(this == param1 || this.resource.support < 15)
         {
            return -1;
         }
         _loc5_ = this.resource.complaint > 0 ? this.getFoodAmountRequiredForComfort() : 0;
         _loc6_ = new NewArmyParam();
         _loc6_.missionType = ObjConstants.ARMY_MISSION_TRANS;
         _loc6_.resource = new ResourceBean();
         _loc6_.targetPoint = param1.castle.fieldId;
         _loc7_ = new Array(TFConstants.T_SCOUTER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_CARRIAGE);
         _loc8_ = param1.getAllTroopsInCastle();
         _loc9_ = this.getTroopFoodValue(_loc8_);
         _loc10_ = Math.max(_loc9_,param1.resource.troopCostFood);
         _loc11_ = NaN;
         _loc12_ = NaN;
         _loc13_ = NaN;
         _loc14_ = NaN;
         _loc15_ = NaN;
         _loc16_ = NaN;
         _loc17_ = NaN;
         _loc18_ = 0;
         for each(_loc19_ in _loc7_)
         {
            _loc6_.troops = new TroopBean();
            _loc6_.troops[troopIntNames[_loc19_]] = 1;
            _loc11_ = this.getTravelTimeReliefStationAdj(_loc6_) * this.getArmySpeedChangeBuffsFactor();
            _loc12_ = Math.max(_loc11_,(param2 - Utils.getServerTime()) / 1000,(param1.lastRescueTargetTime - Utils.getServerTime()) / 1000 + 15 * 60);
            _loc13_ = troopLoads[_loc19_] * _loc3_;
            _loc14_ = this.getFoodNeededToMarch(_loc6_,true) + _loc13_;
            _loc15_ = (this.player.playerInfo.prestige + 100000) / 10 * this.player.castlesArray.length * (Math.ceil(_loc12_ / 15 / 60) + param1.castle.usePACIFY_SUCCOUR_OR_PACIFY_PRAY);
            if(_loc15_ > 10000000)
            {
               _loc15_ = 10000000;
            }
            _loc15_ = int(_loc15_ + _loc10_ / 10) + 1;
            _loc16_ = Number(this.troop[troopIntNames[_loc19_]]);
            if(_loc19_ != TFConstants.T_CARRIAGE)
            {
               _loc16_ = Math.max(0,_loc16_ - 100);
            }
            _loc17_ = Math.ceil(_loc15_ / _loc13_);
            if(!(_loc17_ > Math.floor(_loc16_) || _loc17_ > _loc4_))
            {
               if(_loc17_ * _loc14_ + _loc5_ <= this.resource.food.amount)
               {
                  _loc6_.restTime = _loc12_ - _loc11_;
                  if(!this.isEnoughResourcesToMarch(_loc6_))
                  {
                     return -1;
                  }
                  _loc6_.restTime = 0;
                  if(param2 == 0)
                  {
                     return _loc11_;
                  }
                  _loc18_ = (param2 - Utils.getServerTime()) / 1000;
                  if(_loc18_ > _loc11_)
                  {
                     _loc6_.restTime = _loc18_ - _loc11_;
                     _loc11_ = _loc18_;
                  }
                  _loc6_.troops[troopIntNames[_loc19_]] = _loc17_;
                  _loc6_.resource.food = _loc15_;
                  this.logMsg("RESCUETOWN > rescuing " + param1.castle.name + " " + Map.fieldIdToString(param1.castle.fieldId) + " by sending f:" + _loc6_.resource.food + " with " + Utils.troopBeanToString(_loc6_.troops) + " arriving in " + Utils.formatTime(_loc11_ + _loc6_.restTime),COLR_DEF_LOG_MSG);
                  CityStateCommands.newArmy(this.castleId,_loc6_,this.handleArmyCommandResponse);
                  this.adjEstFoodAfterMarch(_loc6_);
                  return _loc11_;
               }
            }
         }
         return -1;
      }
      
      private function _ps301() : ResourceBean
      {
         var _loc1_:ResourceBean = new ResourceBean();
         if(this.resource.complaint > 0 || this.resource.support <= 40)
         {
            _loc1_.food += this._kv1201();
         }
         var _loc2_:Number = Math.max(this.getTroopFoodValue(this.getAllTroopsInCastle()),this.resource.troopCostFood);
         if(this.healingGoldRequired > 0)
         {
            _loc1_.gold += this.healingGoldRequired;
         }
         if(this.resource.herosSalary > this.resource.taxIncome)
         {
            _loc1_.gold += this.resource.herosSalary - this.resource.taxIncome;
         }
         if(_loc2_ > this.resource.food.increaseRate)
         {
            _loc1_.food += _loc2_ - this.resource.food.increaseRate;
         }
         if(this.resource.complaint >= 50)
         {
            return _loc1_;
         }
         var _loc3_:ConditionBean = this._bt822();
         if(_loc3_ != null)
         {
            _loc1_.gold += _loc3_.gold;
            _loc1_.food += _loc3_.food;
            _loc1_.wood += _loc3_.wood;
            _loc1_.stone += _loc3_.stone;
            _loc1_.iron += _loc3_.iron;
         }
         var _loc4_:ConditionBean = this._ya975();
         if(_loc4_ != null)
         {
            _loc1_.gold += _loc4_.gold;
            _loc1_.food += _loc4_.food;
            _loc1_.wood += _loc4_.wood;
            _loc1_.stone += _loc4_.stone;
            _loc1_.iron += _loc4_.iron;
         }
         if(buildCityLocation != -1)
         {
            _loc1_.gold += 10000;
            _loc1_.food += 10000;
            _loc1_.wood += 10000;
            _loc1_.stone += 10000;
            _loc1_.iron += 10000;
         }
         if(this.getCfg(CityConfigs.CFG_ZEROFOOD) > 0 && this.isZeroFoodActive && this.resource.food.amount < 60000)
         {
            _loc1_.gold += 60000 * this._hf650(0) * 1.3;
         }
         _loc1_.food += this.workOutAvailableFood();
         if(this.resource.herosSalary > this.resource.curPopulation)
         {
            _loc1_.gold += 23 * (this.resource.herosSalary - this.resource.curPopulation);
         }
         return _loc1_;
      }
      
      public function _populate_T_Tab(param1:ArrayCollection) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:TroopBean = null;
         var _loc4_:TroopBean = null;
         var _loc5_:TroopBean = null;
         var _loc6_:TroopBean = null;
         var _loc7_:DataRow = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:* = false;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         var _loc14_:int = 0;
         var _loc15_:String = null;
         _loc2_ = new ArrayCollection();
         _loc3_ = this.getAllTroopsInAccount();
         _loc4_ = this.getAllTroopsInCastle();
         _loc5_ = this.getAllTroopsInQueues();
         _loc6_ = this.getTotalTroopsInEmbassyArmies();
         this.updateTroopRequirements();
         _loc7_ = null;
         _loc8_ = NaN;
         _loc9_ = NaN;
         _loc10_ = false;
         _loc11_ = 0;
         _loc12_ = -1;
         _loc13_ = new Array(TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_CARRIAGE,TFConstants.T_BALLISTA,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
         for each(_loc14_ in _loc13_)
         {
            _loc11_ = this.troop[troopIntNames[_loc14_]] * Utils.TROOP_EXP_VALUES[_loc14_];
            _loc10_ = Math.floor(_loc11_ / 2147483647) % 2 == 0;
            _loc7_ = new DataRow();
            _loc7_.col1 = (_loc10_ ? "" : "*") + troopExtNames[_loc14_] + " (" + Utils.troopAbrNames[_loc14_] + ")";
            _loc7_.col2 = Utils.abbrNum(this.troop[troopIntNames[_loc14_]]);
            _loc7_.col3 = Utils.abbrNum(_loc4_[troopIntNames[_loc14_]]);
            _loc7_.col8 = Utils.abbrNum(_loc3_[troopIntNames[_loc14_]]);
            _loc7_.col4 = Utils.abbrNum(_loc5_[troopIntNames[_loc14_]]);
            _loc7_.col7 = Utils.abbrNum(_loc6_[troopIntNames[_loc14_]]);
            _loc7_.bgColor = 16777215;
            if(this.troopRequirement != null)
            {
               _loc7_.col5 = Utils.abbrNum(this.troopRequirement[troopIntNames[_loc14_]]);
               _loc8_ = this.troopRequirement[troopIntNames[_loc14_]] - (_loc4_[troopIntNames[_loc14_]] + _loc5_[troopIntNames[_loc14_]]);
               if(_loc8_ < 0)
               {
                  _loc8_ = 0;
               }
               _loc7_.col6 = Utils.abbrNum(_loc8_);
               if(_loc8_ > 0)
               {
                  _loc7_.bgColor = 16764108;
               }
               else if(_loc5_[troopIntNames[_loc14_]] > 0)
               {
                  _loc7_.bgColor = 16777164;
               }
               else if(this.troopRequirement[troopIntNames[_loc14_]] > 0)
               {
                  _loc7_.bgColor = 13434828;
               }
            }
            else
            {
               _loc7_.col5 = "";
               _loc7_.col6 = "";
               if(_loc5_[troopIntNames[_loc14_]] > 0)
               {
                  _loc7_.bgColor = 16777164;
               }
            }
            _loc7_.label = "Avail: " + Utils.formatNum(this.troop[troopIntNames[_loc14_]]) + "\nTotal: " + Utils.formatNum(_loc4_[troopIntNames[_loc14_]]) + (!_loc10_ ? "*\n(undraftable)\n-" + Utils.formatNum(Math.floor(_loc11_ % 2147483647 / Utils.TROOP_EXP_VALUES[_loc14_]) + 1) + "  +" + Utils.formatNum(Math.floor((2147483647 - _loc11_ % 2147483647) / Utils.TROOP_EXP_VALUES[_loc14_])) : (_loc10_ && this.troop[troopIntNames[_loc14_]] != 0 ? "\n(draftable) " + Math.round(_loc11_ % 2147483647 * 100 / 2147483647 * 1000) / 1000 + "%\n-" + Utils.formatNum(this.troop[troopIntNames[_loc14_]] - Math.floor(_loc11_ % 2147483647 / Utils.TROOP_EXP_VALUES[_loc14_]) != 0 ? Math.floor(_loc11_ % 2147483647 / Utils.TROOP_EXP_VALUES[_loc14_]) + 1 : 0) + "  +" + Utils.formatNum(Math.floor((2147483647 - _loc11_ % 2147483647) / Utils.TROOP_EXP_VALUES[_loc14_])) : ""));
            if(_loc5_[troopIntNames[_loc14_]] > 0)
            {
               _loc9_ = this.getNextOutTime(_loc14_);
               if(_loc9_ >= 0)
               {
                  _loc7_.label = _loc7_.label + "\n\nQueued: " + Utils.formatNum(_loc5_[troopIntNames[_loc14_]]) + "\nNext out: @" + Utils.getTimeStr(_loc9_) + "\n" + "in " + Utils.formatEndTime(_loc9_);
               }
            }
            _loc2_.addItem(_loc7_);
            if(_loc10_ && (_loc12_ == -1 || _loc11_ % 2147483647 > this.troop[troopIntNames[_loc12_]] * Utils.TROOP_EXP_VALUES[_loc12_] % 2147483647))
            {
               _loc12_ = _loc14_;
            }
         }
         if(_loc12_ != -1)
         {
            _loc2_[_loc13_.indexOf(_loc12_)].col1 = "!" + _loc2_[_loc13_.indexOf(_loc12_)].col1;
            _loc15_ = "Capital Draft: -" + Utils.formatNum(this.troop[troopIntNames[_loc12_]] / 20,0) + "\nCapital Disarm: -" + Utils.formatNum(this.troop[troopIntNames[_loc12_]] / 10,0) + "\nColony Draft: -" + Utils.formatNum(this.troop[troopIntNames[_loc12_]] / 10,0);
            if(String(_loc2_[_loc13_.indexOf(_loc12_)].label).indexOf("\n\nQueued: ") != -1)
            {
               _loc2_[_loc13_.indexOf(_loc12_)].label = String(_loc2_[_loc13_.indexOf(_loc12_)].label).split("\n\n").join("\n\n" + _loc15_ + "\n\n");
            }
            else
            {
               _loc2_[_loc13_.indexOf(_loc12_)].label = _loc2_[_loc13_.indexOf(_loc12_)].label + "\n\n" + _loc15_;
            }
         }
         DataRow.copyRowArray(_loc2_,param1);
      }
      
      private function _ik745(param1:Number, param2:int, param3:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:TradeBean = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         _loc4_ = 0;
         for each(_loc5_ in this.tradesArray)
         {
            if(_loc5_.resType == param2)
            {
               if(_loc5_.tradeType == TradeConstants.TRADE_TYPE_BUY)
               {
                  this._db715(_loc5_,param1,param3);
                  return false;
               }
               if(!this.cityTimingAllowed("modify",60))
               {
                  return false;
               }
               _loc4_ = _loc5_.amount - _loc5_.dealedAmount;
               this.logMsg("TRADE > Cancel sell due to buy demand " + resourceNames[_loc5_.resType] + ": " + _loc4_ + "@" + _loc5_.price + ", range: " + this.getHighestBidOffer(_loc5_.resType) + "-" + this._hf650(_loc5_.resType),COLR_STD_LOG_MSG);
               CityStateCommands.cancelTrade(this.castleId,_loc5_.id,this._og999);
               this.estResource[resourceIntNames[_loc5_.resType]] += _loc4_;
               return false;
            }
         }
         if(param1 != MAXTRADESIZE)
         {
            param1 = Utils.roundAmount(param1);
         }
         if(param1 <= 10)
         {
            return false;
         }
         if(this.tradesArray.length >= this.getBuildingLevel(BuildingConstants.TYPE_MARKET))
         {
            return false;
         }
         _loc6_ = Math.random() * 0.1 + 0.1;
         _loc7_ = this._hf650(param2) * _loc6_ + this.getHighestBidOffer(param2) * (1 - _loc6_);
         if(param3)
         {
            _loc7_ = this._hf650(param2) * 1.2;
         }
         else if(Math.abs(_loc7_ / this._hf650(param2) - 1) < 0.03)
         {
            _loc7_ = this._hf650(param2);
         }
         _loc7_ = this.getTrimmedMarketPrice(_loc7_);
         if(param1 > MAXTRADESIZE)
         {
            param1 = MAXTRADESIZE;
         }
         if(this.estResource.gold < _loc7_ * param1 * 1.005)
         {
            return false;
         }
         this.logMsg("TRADE > Buy " + resourceNames[param2] + ": " + param1 + " at " + _loc7_ + ", range: " + this.getHighestBidOffer(param2) + "-" + this._hf650(param2),COLR_STD_LOG_MSG);
         CityStateCommands.newTrade(this.castleId,param2,TradeConstants.TRADE_TYPE_BUY,param1,"" + _loc7_,this._ry570);
         this.estResource.gold -= param1 * _loc7_ * 1.005;
         return true;
      }
      
      private function getAllResource() : ResourceBean
      {
         var _loc2_:ArmyBean = null;
         var _loc1_:ResourceBean = new ResourceBean();
         if(this.resource == null)
         {
            return _loc1_;
         }
         _loc1_.gold = this.resource.gold;
         _loc1_.food = this.resource.food.amount;
         _loc1_.wood = this.resource.wood.amount;
         _loc1_.stone = this.resource.stone.amount;
         _loc1_.iron = this.resource.iron.amount;
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.startFieldId != this.castle.fieldId)
            {
               if(_loc2_.targetFieldId != this.castle.fieldId || (_loc2_.missionType != ObjConstants.ARMY_MISSION_SEND && _loc2_.missionType != ObjConstants.ARMY_MISSION_TRANS || _loc2_.direction == ArmyConstants.ARMY_BACKWARD))
               {
                  continue;
               }
            }
            else if((_loc2_.missionType == ObjConstants.ARMY_MISSION_SEND || _loc2_.missionType == ObjConstants.ARMY_MISSION_TRANS) && _loc2_.direction != ArmyConstants.ARMY_BACKWARD)
            {
               continue;
            }
            if(_loc2_.resource != null)
            {
               _loc1_ = Utils.combineResource(_loc1_,_loc2_.resource);
            }
         }
         if(this.getCfg(CityConfigs.CFG_ZEROFOOD) > 0)
         {
            for each(_loc2_ in this.getZeroFoodArmies())
            {
               if(_loc2_.resource != null && _loc2_.direction != ArmyConstants.ARMY_BACKWARD)
               {
                  _loc1_ = Utils.combineResource(_loc1_,_loc2_.resource);
               }
            }
         }
         return _loc1_;
      }
      
      private function _as350() : EstimateResource
      {
         var _loc1_:EstimateResource = null;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:ArmyBean = null;
         var _loc6_:EstimateResource = null;
         var _loc7_:CityState = null;
         _loc1_ = new EstimateResource();
         _loc2_ = null;
         _loc3_ = new Array("food","wood","stone","iron","gold","curPopulation");
         _loc4_ = null;
         for each(_loc5_ in this.selfArmies)
         {
            if(_loc5_.resource != null)
            {
               _loc4_ = _loc5_.resource.toObject();
               for(_loc2_ in _loc4_)
               {
                  _loc1_[_loc2_] += _loc4_[_loc2_];
               }
            }
         }
         _loc6_ = null;
         for each(_loc7_ in MainScreen.getCities())
         {
            if(_loc7_.cityManager.resource != null)
            {
               _loc6_ = _loc7_.cityManager.estResource;
               for each(_loc2_ in _loc3_)
               {
                  _loc1_[_loc2_] += _loc6_[_loc2_];
               }
            }
         }
         return _loc1_;
      }
      
      private function getBarrackQueueFromBuildingBean(param1:BuildingBean) : AllProduceBean
      {
         var _loc2_:AllProduceBean = null;
         for each(_loc2_ in this.troopProduceQueue)
         {
            if(_loc2_.positionId == param1.positionId)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function _jg190(param1:int, param2:Number) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == 0)
         {
            if(this.resource.food.amount < 3000000)
            {
               if(this.doZeroFoodQFarm())
               {
                  return true;
               }
            }
            else if(this.localArmies.length <= 3)
            {
               if(this.doZeroFoodQFarm(3))
               {
                  return true;
               }
            }
         }
         if(this.getZeroFoodArmies().length == 0)
         {
            if(this._sf809(param2))
            {
               return true;
            }
            _loc3_ = Connection.getInstance().getSendQueueLength();
            if(_loc3_ < 20)
            {
               this.zeroFoodManager(param1);
            }
            if(Connection.getInstance().getSendQueueLength() > _loc3_)
            {
               return true;
            }
         }
         if(param1 == 0 && this.localArmies.length > 3 && this.doZeroFoodQFarm())
         {
            return true;
         }
         return false;
      }
      
      public function getBaseTravelTime(param1:int, param2:int, param3:TroopBean, param4:Boolean = true) : Number
      {
         var _loc5_:Number = NaN;
         _loc5_ = this.getTroopSpeed(param3);
         return _loc5_ != 0 ? Map.fieldDistance(param1,param2) * 60000 / _loc5_ * (param4 ? this.getArmySpeedChangeBuffsFactor() : 1) : 0;
      }
      
      public function getLocalBuff(param1:String) : BuffBean
      {
         var _loc2_:BuffBean = null;
         for each(_loc2_ in this.castle.buffsArray)
         {
            if(!(_loc2_ == null || _loc2_.endTime < Utils.getServerTime() || _loc2_.typeId != param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function _gu1148(param1:int) : HeroBean
      {
         var _loc2_:HeroBean = null;
         for each(_loc2_ in this.heroes)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function _tx683(param1:XMLList) : Boolean
      {
         var _loc2_:String = null;
         var _loc4_:XML = null;
         _loc2_ = null;
         var _loc3_:int = 0;
         for each(_loc4_ in param1)
         {
            _loc3_ = int(_loc4_.@typeId);
            _loc2_ = _loc4_.@lose;
            if(!Utils.hasValue(_loc2_))
            {
               return false;
            }
            if(int(_loc2_) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function fastestIdleHero(param1:int = 10, param2:int = 4) : HeroBean
      {
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         var _loc5_:HeroBean = null;
         var _loc6_:HeroBean = null;
         _loc3_ = null;
         _loc4_ = this.bestAttackHero();
         _loc5_ = this.bestPoliticHero();
         for each(_loc6_ in this.heroes)
         {
            if(!(_loc6_.isHero != 0 || _loc6_.id == _loc4_.id || _loc6_.id == _loc5_.id))
            {
               if(!(this.trainingHeroName != null && _loc6_.name.toLowerCase() == this.trainingHeroName.toLowerCase()))
               {
                  if(!(this.notFastKeepResoHeroes != null && this.notFastKeepResoHeroes.indexOf(_loc6_.name.toLowerCase()) != -1))
                  {
                     if(!(_loc6_.stamina < param2 || _loc6_.speed < param1))
                     {
                        if(_loc6_.status == HeroConstants.HERO_FREE_STATU)
                        {
                           if(_loc3_ == null || _loc6_.speed > _loc3_.speed)
                           {
                              _loc3_ = _loc6_;
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function getTotalTroopsInEmbassyArmies() : TroopBean
      {
         var _loc1_:TroopBean = null;
         var _loc2_:ArmyBean = null;
         var _loc3_:int = 0;
         _loc1_ = new TroopBean();
         for each(_loc2_ in this.friendlyArmies)
         {
            if(_loc2_.direction == ArmyConstants.ARMY_STAY)
            {
               for each(_loc3_ in [TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CATAPULT,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_ARCHER])
               {
                  _loc1_[troopIntNames[_loc3_]] += int(_loc2_.troop[troopIntNames[_loc3_]]);
               }
            }
         }
         return _loc1_;
      }
      
      private function _dx690(param1:CityCondition) : Boolean
      {
         var _loc2_:ConditionBean = null;
         var _loc3_:String = null;
         _loc2_ = this.getConditionBeanForUpgradingTo(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         for each(_loc3_ in resourceIntNames)
         {
            if(_loc2_[_loc3_] > this.estResource[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      private function getTrimmedMarketPrice(param1:Number) : Number
      {
         if(param1 >= 10)
         {
            return int(param1 * 100) / 100;
         }
         return int(param1 * 1000) / 1000;
      }
      
      public function _getAllTroopPlusQueued() : TroopBean
      {
         var _loc1_:TroopBean = null;
         var _loc2_:AllProduceBean = null;
         var _loc3_:ProduceBean = null;
         _loc1_ = this.getAllTroopsInCastle();
         for each(_loc2_ in this.troopProduceQueue)
         {
            for each(_loc3_ in _loc2_.allProduceQueueArray)
            {
               _loc1_[troopIntNames[_loc3_.type]] += _loc3_.num;
            }
         }
         return _loc1_;
      }
      
      private function processRequestHelpGoals(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:TroopBean = null;
         var _loc5_:TroopBean = null;
         var _loc6_:ResourceBean = null;
         var _loc7_:ResourceBean = null;
         var _loc8_:* = false;
         _loc2_ = param1.toLowerCase().split(" ");
         if(_loc2_.length != 5 && _loc2_.length != 6)
         {
            this.logMsg("ERROR in requesthelp line:  Invalid parameters, expect requesthelp from_coord troop remote_troop resource remote_resource [waronly]",COLR_ERR_LOG_MSG);
            return false;
         }
         _loc3_ = _loc2_[0] == "any" ? ANYCOORDINATE : Map.coordStringToFieldId(_loc2_[0]);
         _loc4_ = Utils.getTroops(_loc2_[1]);
         _loc5_ = Utils.getTroops(_loc2_[2]);
         _loc6_ = Utils.getEstResoBean(_loc2_[3]);
         _loc7_ = Utils.getEstResoBean(_loc2_[4]);
         _loc8_ = false;
         if(_loc2_.length == 6)
         {
            if(_loc2_[5] != "true" && _loc2_[5] != "false")
            {
               this.logMsg("ERROR in requesthelp line:  Invalid [waronly] condition in requesthelp line. Expecting \'true\' or \'false\' or left blank but getting " + _loc2_[5],COLR_ERR_LOG_MSG);
               return false;
            }
            _loc8_ = _loc2_[5].toLowerCase() == "true";
         }
         if(_loc3_ == -1)
         {
            this.logMsg("ERROR in requesthelp line:  Invalid target coordinate in requesthelp line, must be \'any\' or a valid coordinate",COLR_ERR_LOG_MSG);
            return false;
         }
         if(_loc4_ == null || _loc5_ == null || _loc6_ == null || _loc7_ == null)
         {
            this.logMsg("ERROR in requesthelp line:  Invalid troop or resource condition in requesthelp line",COLR_ERR_LOG_MSG);
            return false;
         }
         this.requestHelpFieldIds.push(_loc3_);
         this.requestTroopLocalConds.push(_loc4_);
         this.requestTroopRemoteConds.push(_loc5_);
         this.requestResourceLocalConds.push(_loc6_);
         this.requestResourceRemoteConds.push(_loc7_);
         this.requestHelpWarConds.push(_loc8_);
         return true;
      }
      
      public function _addTroopGoal(param1:TroopBean) : void
      {
         this.troopRequirements.addItem(param1);
         this.cityCfg.configs[CityConfigs.CFG_TROOP] = 1;
      }
      
      private function getBestIdleAttackHeroByStaminaIncGear(param1:int = -1) : HeroBean
      {
         return this.getBestIdleHeroByTypeAndStaminaIncGear("power",param1);
      }
      
      private function _by706(param1:HeroBean) : HeroBean
      {
         return this._mh723("power",param1.id);
      }
      
      public function getTechLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 10;
         while(_loc2_ >= 1)
         {
            if(this.isResearchAtLevel(param1,_loc2_))
            {
               return _loc2_;
            }
            _loc2_--;
         }
         return 0;
      }
      
      private function getHeroesArmy(param1:HeroBean) : ArmyBean
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.localArmies)
         {
            if(_loc2_.hero == param1.name && _loc2_.heroLevel == param1.level)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function _le863(param1:Object = null) : void
      {
         var _loc2_:ArmyBean = null;
         if(this.loyaltyAttackFieldId == -1)
         {
            this.logMsg("No current loyalty attack");
            return;
         }
         this.logMsg("Cancel loyalty attack on " + Map.fieldIdToString(this.loyaltyAttackFieldId));
         for each(_loc2_ in this.selfArmies)
         {
            if(_loc2_.startFieldId == this.castle.fieldId && _loc2_.targetFieldId == this.loyaltyAttackFieldId && _loc2_.direction == ArmyConstants.ARMY_FORWARD)
            {
               if(this._rf889(_loc2_.troop))
               {
                  this.logMsg("Recall troop to " + Map.fieldIdToString(this.loyaltyAttackFieldId) + ", id: " + _loc2_.armyId);
                  CityStateCommands.callBackArmy(this.castleId,_loc2_.armyId);
               }
            }
         }
         this.loyaltyAttackFieldId = -1;
      }
      
      private function _xy1114(param1:Number) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < this.enemyArmies.length)
         {
            if(this.enemyArmies[_loc3_].reachTime > param1)
            {
               break;
            }
            if(!this.isJunkTroop(this.enemyArmies[_loc3_].troop))
            {
               if(this.isNakedScouts(this.enemyArmies[_loc3_].troop))
               {
                  _loc2_++;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function removeMayor() : void
      {
         if(this._ek905(-1))
         {
            ++this.promoteCount;
            if(this.getCfg(CityConfigs.CFG_DEBUG) > 0)
            {
               this.logMsg("DEBUG(" + this.getCfg(CityConfigs.CFG_DEBUG) + ") > Remove current mayor",COLR_DBG_LOG_MSG);
            }
            CityStateCommands.dischargeChief(this.castleId,this.onHeroDischargeResponse);
         }
      }
      
      private function onUpdateTroopQueueResponse(param1:ProduceQueueResponse) : void
      {
         if(troopProductionUpdateRequested != this.castleId)
         {
            return;
         }
         if(param1.ok != 1)
         {
            this.logErrMsg("get troop produce queue error: " + param1.errorMsg);
         }
         else
         {
            this.troopProduceQueue = param1.allProduceQueueArray;
            troopProductionUpdateRequested = 0;
         }
      }
      
      public function getLocalBuffIndexFromTypeId(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.castle.buffsArray.length)
         {
            if(this.castle.buffsArray[_loc2_].typeId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function _jh1139(param1:XMLList) : FortificationsBean
      {
         var _loc2_:FortificationsBean = null;
         var _loc3_:* = undefined;
         _loc2_ = new FortificationsBean();
         for each(_loc3_ in param1)
         {
            if(!Utils.hasValue(_loc3_.@count))
            {
               return null;
            }
            _loc2_[troopIntNames[int(_loc3_.@typeId)]] = int(_loc3_.@count);
         }
         return _loc2_;
      }
      
      public function getRallyDispatchPerArmyLimit(param1:Boolean = false) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         _loc2_ = this.getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD);
         _loc3_ = 1;
         if(param1 && (this.getLocalBuffByWildCardId("HauntedCastleBuf") != null || this.getBuffByWildCardId("HauntedCastleAdvBuf") != null))
         {
            _loc3_ = 1.25;
         }
         return (_loc2_ <= 10 ? _loc2_ * this.TROOPPERLEVEL : (100 + 15 * (_loc2_ - 10)) * this.TROOPPERLEVEL / 10) * _loc3_;
      }
      
      public function getVar(param1:String) : String
      {
         return this.goalVars[param1] == undefined ? null : this.goalVars[param1];
      }
      
      private function doRescueTownComfortReso() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:CityManager = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:CityManager = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:CityManager = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         _loc1_ = Utils.randOrder(MainScreen.getCities().length);
         _loc2_ = null;
         _loc3_ = NaN;
         _loc4_ = NaN;
         _loc5_ = null;
         _loc6_ = NaN;
         _loc7_ = NaN;
         _loc8_ = null;
         _loc9_ = NaN;
         _loc10_ = NaN;
         _loc11_ = 0;
         _loc12_ = 0;
         _loc13_ = 0;
         _loc14_ = 0;
         while(_loc14_ < _loc1_.length)
         {
            _loc2_ = (MainScreen.getCities()[_loc1_[_loc14_]] as CityState).cityManager;
            if(this != _loc2_)
            {
               if(_loc2_.getCfg(CityConfigs.CFG_NORESCUE) < 1 && _loc2_.getCfg(CityConfigs.CFG_ABANDON) < 1)
               {
                  if((_loc2_.resource.support <= 40 || _loc2_.resource.complaint > 0) && _loc2_.resource.food.amount < _loc2_.getFoodAmountRequiredForComfort())
                  {
                     _loc3_ = Math.max(0,(_loc2_.lastRescueTargetTime + 15.5 * 60 * 1000 - Utils.getServerTime()) / 1000);
                     if(_loc3_ > 2.5 * 3600)
                     {
                        return false;
                     }
                     _loc4_ = 1000000;
                     _loc5_ = null;
                     _loc6_ = 1000000;
                     _loc15_ = 0;
                     while(_loc15_ < MainScreen.getCities().length)
                     {
                        _loc8_ = MainScreen.getCities()[_loc15_].cityManager;
                        _loc9_ = _loc8_.doRescueTownNewArmy(_loc2_,0);
                        if(_loc9_ != -1)
                        {
                           _loc10_ = Math.max(_loc9_ - _loc3_,0);
                           _loc11_ = _loc8_.getMaxRallySlots() - _loc8_.getLocalArmiesCount();
                           _loc12_ = _loc8_.getAvailableRallyMaxHidingSlots() + _loc8_.getAvailableRallyMaxRainbowSlots();
                           if(_loc11_ != 0)
                           {
                              _loc13_ = 0;
                              if(_loc12_ >= _loc11_)
                              {
                                 _loc13_ += 15 * 60 * (_loc12_ - _loc11_ + 1);
                              }
                              if(_loc8_.isLastEnemyTimeLessThan1Hr())
                              {
                                 _loc13_ += 30 * 60;
                              }
                              if(_loc4_ > _loc10_ + _loc13_)
                              {
                                 _loc6_ = _loc9_;
                                 _loc5_ = _loc8_;
                                 _loc4_ = _loc10_ + _loc13_;
                              }
                           }
                        }
                        _loc15_++;
                     }
                     if(_loc6_ + 15 * 60 >= _loc3_)
                     {
                        if(_loc5_ == this)
                        {
                           _loc7_ = this.doRescueTownNewArmy(_loc2_,Utils.getServerTime() + _loc3_ * 1000);
                           if(_loc7_ != -1)
                           {
                              _loc2_.lastRescueTargetTime = Utils.getServerTime() + _loc7_ * 1000;
                              this.logMsg("RESCUETOWN > Target rescue arrival time for " + _loc2_.castle.name + ": " + Utils.getLogTimeStr(_loc2_.lastRescueTargetTime),COLR_DEF_LOG_MSG);
                              return true;
                           }
                        }
                     }
                  }
               }
            }
            _loc14_++;
         }
         return false;
      }
      
      private function searchTradesHandler(param1:SearchTradesResponse) : void
      {
         var _loc2_:int = 0;
         if(param1.ok != 1)
         {
            return;
         }
         if(currMarketInterest != -1)
         {
            _loc2_ = currMarketInterest;
            this.market[currMarketInterest] = param1;
            currMarketInterest = -1;
            if(playerTimingAllowed("recordLagTime",60))
            {
               lastMarketLagTimes.push((new Date().getTime() - lastMarketQueryTime.getTime()) / 1000);
               while(lastMarketLagTimes.length > 5)
               {
                  lastMarketLagTimes.shift();
               }
            }
         }
      }
      
      private function getAdjFHReservedValue() : int
      {
         var _loc1_:Number = NaN;
         _loc1_ = this.getCfg(CityConfigs.CFG_FHRESERVED);
         if(_loc1_ <= 0)
         {
            return 0;
         }
         if(this.trainingHeroName != null && !isNameRoyal(this.trainingHeroName) && this.isTrainingHeroInTown())
         {
            return _loc1_ - 1;
         }
         return _loc1_;
      }
      
      public function getColony(param1:int) : ColonyBean
      {
         var _loc2_:String = null;
         var _loc3_:ColonyBean = null;
         if(this.colonies == null)
         {
            return null;
         }
         _loc2_ = "" + Map.getX(param1) + "." + Map.getY(param1);
         for each(_loc3_ in this.colonies)
         {
            if(_loc3_.position == _loc2_)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function _forceTrainingHeroMove() : void
      {
         delete playerTimingList["movetraininghero"];
         this.moveTrainingHero();
      }
      
      private function injuredTroopHandle(param1:InjuredTroopUpdate) : void
      {
         if(param1.castleId != this.castleId)
         {
            return;
         }
         if(param1.goldNeed == 0)
         {
            return;
         }
         if(this.cityTimingAllowed("troopinjured",300) || this.healingGoldRequired != param1.goldNeed)
         {
            this.logMsg("Troop injured: " + Utils.troopBeanToString(param1.troop) + ", gold needed " + param1.goldNeed,COLR_DEF_LOG_MSG);
         }
         this.healingGoldRequired = param1.goldNeed;
      }
      
      public function getWartownSchedule() : Array
      {
         return this.wartownSchedule;
      }
      
      public function _xl810() : TroopBean
      {
         return this.troop;
      }
      
      private function getItemFromName(param1:String) : ItemBean
      {
         var _loc2_:ItemBean = null;
         for each(_loc2_ in this.player.itemsArray)
         {
            if(_loc2_.id != null && _loc2_.count > 0 && param1.toLowerCase() == Items.getItemName(_loc2_.id).toLowerCase())
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

