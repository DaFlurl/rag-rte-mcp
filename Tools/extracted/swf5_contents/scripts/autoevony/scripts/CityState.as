package autoevony.scripts
{
   import autoevony.common.ActionFactoryResponse;
   import autoevony.common.BuildingType;
   import autoevony.common.CallbackParams;
   import autoevony.common.CityStateCommands;
   import autoevony.common.CityStateConstants;
   import autoevony.common.GearType;
   import autoevony.common.Items;
   import autoevony.common.ScriptError;
   import autoevony.common.TechType;
   import autoevony.common.TrainTroopHelper;
   import autoevony.common.Utils;
   import autoevony.event.CityStateCompleteEvent;
   import autoevony.event.CityStateResponseEvent;
   import autoevony.event.EventHandler;
   import autoevony.gui.AccountInfo;
   import autoevony.gui.MainScreen;
   import autoevony.management.CityManager;
   import autoevony.net.Connection;
   import autoevony.player.LoginHelper;
   import autoevony.player.Map;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.ArmyBean;
   import com.evony.common.beans.AvailableResearchListBean;
   import com.evony.common.beans.BuildingBean;
   import com.evony.common.beans.CastleBean;
   import com.evony.common.beans.ColonyBean;
   import com.evony.common.beans.DisappearHeroBean;
   import com.evony.common.beans.EquipmentBean;
   import com.evony.common.beans.FortificationsBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.ItemBean;
   import com.evony.common.beans.MapCastleBean;
   import com.evony.common.beans.PackageBean;
   import com.evony.common.beans.PlayerBean;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.beans.QuestBean;
   import com.evony.common.beans.QuestTargetBean;
   import com.evony.common.beans.QuestTypeBean;
   import com.evony.common.beans.ResourceBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.constants.BuildingConstants;
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
   import com.evony.common.module.alliance.PlayerInfoResponse;
   import com.evony.common.module.army.ArmyPracticeResponse;
   import com.evony.common.module.capital.CapitalCommandResponse;
   import com.evony.common.module.colony.ColonialArmyResponse;
   import com.evony.common.module.colony.ColonialDeployResponse;
   import com.evony.common.module.colony.ColonyLevyeRespone;
   import com.evony.common.module.colony.OverviewColonyCastleRespone;
   import com.evony.common.module.common.ChatResponse;
   import com.evony.common.module.common.GetPackageListResponse;
   import com.evony.common.module.common.GetPackageResponse;
   import com.evony.common.module.common.MapInfoSimpleResponse;
   import com.evony.common.module.friend.FriendResponse;
   import com.evony.common.module.gemstone.GemstoneRespone;
   import com.evony.common.module.hero.DisappearHeroResponse;
   import com.evony.common.module.hero.HeroListResponse;
   import com.evony.common.module.quest.QuestListResponse;
   import com.evony.common.module.quest.QuestTypeResponse;
   import com.evony.common.module.report.ReportListResponse;
   import com.evony.common.module.shop.UseItemResultResponse;
   import com.evony.common.module.tech.AvailableResearchListResponse;
   import com.evony.common.module.tech.ResearchResponse;
   import com.evony.common.paramBeans.NewArmyParam;
   import com.evony.common.server.events.BuildComplate;
   import com.evony.common.server.events.FortificationsUpdate;
   import com.evony.common.server.events.ResearchCompleteUpdate;
   import com.evony.eum.ItemEum;
   import com.skype.Skype;
   import com.skype.SkypeConstants;
   import com.skype.SkypeResponse;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import mx.collections.ArrayCollection;
   
   public class CityState extends EventDispatcher
   {
      public static var findQuestCount:int = 0;
      
      public static var findQuestCastleId:int = 0;
      
      public static var scriptQuestActive:Boolean = false;
      
      private static var goalCommandWarning:Boolean = true;
      
      private static var lastCalibrateTime:Number = 0;
      
      private static const TRADELIMIT:int = 99999999;
      
      private static const SPEEDUP:Array = new Array(1,2,2,2,3,4,4,4,5,5,6);
      
      private static var campTimeDelta:Number = 0;
      
      private static var lastEmailMsg:Number = 0;
      
      public var castleId:int;
      
      private var currentResearch:AvailableResearchListBean = null;
      
      public var verboseLogs:Boolean = false;
      
      public var actionResponse:ActionFactoryResponse = new ActionFactoryResponse();
      
      private var m_techLevels:Object = new Object();
      
      private var script:Script;
      
      private var friendBlockPlayerName:String = null;
      
      public var castle:CastleBean;
      
      private var reportIdsToDelete:ArrayCollection = new ArrayCollection();
      
      private var pleaseStop:Boolean = false;
      
      internal var currentAction:String;
      
      private var events:ArrayCollection = new ArrayCollection();
      
      private var changeHeroGearsParams:Object = null;
      
      private var researchType:String;
      
      public var cityManager:CityManager;
      
      private var scriptCmds:Object = null;
      
      public function CityState(param1:int, param2:Boolean = true)
      {
         super();
         this.castleId = param1;
         this._setCastleBean();
         this.cityManager = new CityManager(this,param1);
         this.script = new Script(this);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE,this.buildComplete);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE,this.researchComplete);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE,this.updateFort);
         if(param2)
         {
            this.currentAction = "init";
            ActionFactory.getInstance().getTechCommand().getResearchList(this.castleId,this.onGetResearchListResponse);
         }
         this.currentActiveBuilding();
         this.currentAction = "";
         this.onCmdFinshed(true);
      }
      
      public static function getMissionConstFromString(param1:String) : int
      {
         var _loc2_:int = int(param1);
         if(_loc2_ == 0)
         {
            param1 = param1.toLowerCase().substr(0,2);
            if(param1 == "at")
            {
               return ObjConstants.ARMY_MISSION_OCCUPY;
            }
            if(param1 == "bu")
            {
               return ObjConstants.ARMY_MISSION_CONSTRUCT;
            }
            if(param1 == "re")
            {
               return ObjConstants.ARMY_MISSION_SEND;
            }
            if(param1 == "sc")
            {
               return ObjConstants.ARMY_MISSION_SCOUT;
            }
            if(param1 == "tr")
            {
               return ObjConstants.ARMY_MISSION_TRANS;
            }
            if(param1 == "co")
            {
               return ObjConstants.ARMY_MISSION_COLONIZE;
            }
            if(param1 == "an")
            {
               return ObjConstants.ARMY_MISSION_ANTI_COLONIAL;
            }
            if(param1 == "su")
            {
               return ObjConstants.ARMY_MISSION_SUPPRESS;
            }
            if(param1 == "up")
            {
               return ObjConstants.ARMY_MISSION_UPRISE;
            }
            if(param1 == "de")
            {
               return ObjConstants.ARMY_MISSION_DEPLOY_TROOPS;
            }
            return ObjConstants.ARMY_MISSION_TRANS;
         }
         return _loc2_;
      }
      
      private function notSpamHeroes(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "notspamheroes";
         this.cityManager.setSpamHeroes(param1);
         this.onCmdFinshed(true);
      }
      
      private function aBigAttack(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "abigattack";
         this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY,param1,param2,param3,null,param4,true,false,2,null);
      }
      
      private function train(param1:TroopBean, param2:String = "atk", param3:String = "all", param4:int = 1) : void
      {
         if(param1 == null)
         {
            this.onCmdResult(" usage: train troops [hero] [barrackid | all | idle] [min amount]","");
            this.onCmdResult("example: train a:99999","");
            this.onCmdResult("Trains at least 1 to a maximum of 99999 archers in all barracks, will use the idle hero with highest attack","");
            this.onCmdResult("","");
            this.onCmdResult("note: you may specify atk or any as the heroname and the highest attack idle hero will be used, if you have no idle heros the command will still execute, if you specify any other hero name that is not found in your feasting hall or not idle the command will not execute","");
            this.onCmdResult("","");
            this.onCmdResult("example: train a:99999 any all 20000","");
            this.onCmdResult("Train at least 20000 to a maximum of 99999 archers in all barracks with any hero, do not train any if you cannot train at least 20000","");
            this.onCmdResult("","");
            this.onCmdResult("example: train a:5000 any idle 5000","");
            this.onCmdResult("Train exactly 5000 archers in idle barracks with any hero, if 5000 archers cannot be trained train none","");
            this.onCmdResult("","");
            this.onCmdResult("example: train a:1000 any 24 1000","");
            this.onCmdResult("Train exactly 1000 archers in barrack 24 with any hero, use listbarracks to determine barrack id","");
            this.onCmdResult("","");
            this.onCmdResult("example: train a:1000 Wilbur 24 1000","");
            this.onCmdResult("Train exactly 1000 archers in barrack 24 with Wilbur hero, if Wilbur is not available will not train any","");
            this.onCmdResult("","");
            this.onCmdFinshed(true);
            return;
         }
         this.onCmdResult("Waiting for town\'s turn to train troop...");
         this.cityManager._reserveEmergencyTimeSlot();
         this.waitForCmActive(this.train2,[param1,param2,param3,param4]);
      }
      
      private function addPointHero(param1:String, param2:int, param3:int, param4:int) : void
      {
         this.currentAction = "upaddpoint";
         var _loc5_:HeroBean = this.findHeroByName(param1);
         if(_loc5_ == null)
         {
            this.onCmdFinshed(new ScriptError("No hero found with name: " + param1,-9999));
            return;
         }
         this.onCmdResult("Add point(s) to hero " + _loc5_.name + ": " + param2 + " pol, " + param3 + " atk, " + param4 + " int");
         this.setCmdResponse(ResponseDispatcher.HERO_ADD_POINT2,this.handleCmdResponse);
         CityStateCommands.addPoint2(this.castleId,_loc5_.id,param2,param3,param4,this.handleCmdResponse);
      }
      
      public function getCityFromFieldId(param1:int) : CityState
      {
         return MainScreen.getCityFromFieldId(param1);
      }
      
      private function idRecall(param1:int) : void
      {
         this.currentAction = "idrecall";
         this.cityManager._qk434(param1);
         this.onCmdFinshed(true);
      }
      
      private function endFieldAttack() : void
      {
         this.currentAction = "endfieldattack";
         this.cityManager._scrEndFieldAttack();
         this.onCmdFinshed(true);
      }
      
      public function formatNum(param1:Number, param2:int = 50) : String
      {
         return Utils.formatNum(param1,param2);
      }
      
      private function aAttack(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "aattack";
         this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY,param1,param2,param3,null,param4,false,false,2,null);
      }
      
      public function getArmy(param1:String, param2:int, param3:String, param4:TroopBean, param5:ResourceBean = null, param6:int = 0, param7:Boolean = false) : NewArmyParam
      {
         var _loc8_:NewArmyParam = new NewArmyParam();
         _loc8_.missionType = getMissionConstFromString(param1);
         _loc8_.targetPoint = param2;
         var _loc9_:HeroBean = this.findHeroByName(param3);
         if(_loc9_ != null)
         {
            _loc8_.heroId = _loc9_.id;
         }
         _loc8_.troops = param4;
         if(param5 == null)
         {
            param5 = new ResourceBean();
         }
         _loc8_.resource = param5;
         _loc8_.restTime = param6;
         _loc8_.useFlag = param7;
         return _loc8_;
      }
      
      private function changePlayerNickResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         this.cityManager.logMsg(param1.msg == null || param1.msg == "" ? "Changed name successfully." : param1.msg);
         this.onCmdFinshed(true);
      }
      
      public function getMapDetail(param1:int) : MapCastleBean
      {
         return Map.getDetail(param1);
      }
      
      private function blockPlayerResponseHandler(param1:FriendResponse) : void
      {
         if(param1.ok != 1)
         {
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         this.player.blockBeansArray = param1.blockArrArray;
         this.cityManager.logMsg("Player \"" + this.friendBlockPlayerName + "\" was successfully added to your Block Players List.");
         this.friendBlockPlayerName = null;
         this.onCmdFinshed(true);
      }
      
      private function upgrade(param1:String = "*", param2:String = "LowestLevel", param3:Boolean = false) : void
      {
         if(param3)
         {
            this.upgrade2(param1,param2,param3);
            return;
         }
         if(Version.isTraceOn())
         {
            trace("create - verify buildings");
         }
         if(this.cityManager.isBuildingQueueAvailable())
         {
            this.upgrade2(param1,param2,param3);
            return;
         }
         this.onCmdResult("Waiting for current building to complete...");
         this.waitForBuildingQueue(this.upgrade2,[param1,param2,param3]);
      }
      
      private function levyByStrType(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         _loc2_ = param1.toLowerCase().substr(0,1);
         _loc3_ = new Array("","g","f","w","s","i");
         _loc4_ = int(_loc3_.indexOf(_loc2_ == "l" ? "w" : _loc2_));
         if(_loc4_ > 0)
         {
            this.levyByIntType(_loc4_);
         }
         else
         {
            this.onCmdFinshed(new ScriptError("Unknown Levy type: " + param1,-9999));
         }
      }
      
      public function parseTime(param1:String, param2:Boolean = false) : Number
      {
         var _loc6_:Date = null;
         var _loc3_:Date = null;
         var _loc4_:Number = 0;
         var _loc5_:Array = param1.split(":");
         if(_loc5_.length < 1)
         {
            return 0;
         }
         if(param2)
         {
            _loc6_ = new Date();
            _loc6_.setTime(Utils.getServerTime());
            switch(_loc5_.length)
            {
               case 2:
                  _loc3_ = new Date(_loc6_.fullYear,_loc6_.getMonth(),_loc6_.getDate(),int(_loc5_[0]),int(_loc5_[1]));
                  if(_loc3_.valueOf() < _loc6_.valueOf())
                  {
                     _loc3_ = new Date(_loc6_.fullYear,_loc6_.getMonth(),_loc6_.getDate() + 1,int(_loc5_[0]),int(_loc5_[1]));
                  }
                  break;
               case 3:
                  _loc3_ = new Date(_loc6_.fullYear,_loc6_.getMonth(),_loc6_.getDate(),int(_loc5_[0]),int(_loc5_[1]),int(_loc5_[2]),(Number(_loc5_[2]) - int(_loc5_[2])) * 1000);
                  if(_loc3_.valueOf() < _loc6_.valueOf())
                  {
                     _loc3_ = new Date(_loc6_.fullYear,_loc6_.getMonth(),_loc6_.getDate() + 1,int(_loc5_[0]),int(_loc5_[1]),int(_loc5_[2]),(Number(_loc5_[2]) - int(_loc5_[2])) * 1000);
                  }
                  break;
               default:
                  return 0;
            }
            if(_loc3_.getTime() < _loc6_.getTime())
            {
               return 0;
            }
            return (_loc3_.getTime() - _loc6_.getTime()) / 1000;
         }
         switch(_loc5_.length)
         {
            case 1:
               _loc4_ = Number(_loc5_[0]);
               break;
            case 2:
               _loc4_ = int(_loc5_[0]) * 60 + Number(_loc5_[1]);
               break;
            case 3:
               _loc4_ = int(_loc5_[0]) * 3600 + int(_loc5_[1]) * 60 + Number(_loc5_[2]);
               break;
            default:
               return 0;
         }
         return _loc4_;
      }
      
      public function get serverCfg() : Object
      {
         var obj:Object = null;
         obj = {
            "serverAlias":LoginHelper.getInstance().strserverAlias,
            "serverName":LoginHelper.getInstance().server,
            "serverIP":LoginHelper.getInstance().serverIP,
            "evoLoginName":"",
            "evoHashedPw":LoginHelper.getInstance().getHashedEvonyPw()
         };
         obj["toDebugString"] = function():String
         {
            var _loc2_:String = null;
            var _loc1_:String = "";
            for(_loc2_ in obj)
            {
               if(_loc2_ != "toDebugString")
               {
                  _loc1_ += _loc2_ + " = " + obj[_loc2_] + "\n";
               }
            }
            return _loc1_;
         };
         return obj;
      }
      
      public function getLocalTime() : Number
      {
         var _loc1_:Date = new Date();
         _loc1_.setTime(Utils.getServerTime());
         return _loc1_.hours * 3600 + _loc1_.minutes * 60 + _loc1_.seconds + _loc1_.milliseconds / 1000;
      }
      
      public function getTroopFromArmy(param1:ArmyBean) : TroopBean
      {
         return Utils.getTroopBeanFromTroopStrBean(param1.troop);
      }
      
      private function collectAllPackages() : void
      {
      }
      
      public function get af() : ActionFactory
      {
         return ActionFactory.getInstance();
      }
      
      public function get accountTab() : AccountInfo
      {
         return AccountInfo.getInstance();
      }
      
      public function get ac() : Array
      {
         return MainScreen.getCities();
      }
      
      private function bigTransport(param1:int, param2:TroopBean, param3:ResourceBean, param4:String = "") : void
      {
         this.currentAction = "bigtransport";
         this.doMarch(ObjConstants.ARMY_MISSION_TRANS,param1,"none",param2,param3,param4,true);
      }
      
      public function get buildingTypes() : Object
      {
         var obj:Object = null;
         obj = {
            "cottage":BuildingConstants.TYPE_HOUSE,
            "c":BuildingConstants.TYPE_HOUSE,
            "barrack":BuildingConstants.TYPE_BARRACK,
            "b":BuildingConstants.TYPE_BARRACK,
            "warehouse":BuildingConstants.TYPE_WAREHOUSE,
            "wh":BuildingConstants.TYPE_WAREHOUSE,
            "sawmill":BuildingConstants.TYPE_LUMBER_MILL,
            "s":BuildingConstants.TYPE_LUMBER_MILL,
            "quarry":BuildingConstants.TYPE_STONE_MINE,
            "q":BuildingConstants.TYPE_STONE_MINE,
            "ironmine":BuildingConstants.TYPE_IRON_MINE,
            "i":BuildingConstants.TYPE_IRON_MINE,
            "farm":BuildingConstants.TYPE_FARM_LAND,
            "f":BuildingConstants.TYPE_FARM_LAND,
            "stable":BuildingConstants.TYPE_STABLE,
            "st":BuildingConstants.TYPE_STABLE,
            "inn":BuildingConstants.TYPE_TAVERN,
            "forge":BuildingConstants.TYPE_BLACKSMITH,
            "fo":BuildingConstants.TYPE_BLACKSMITH,
            "market":BuildingConstants.TYPE_MARKET,
            "m":BuildingConstants.TYPE_MARKET,
            "reliefstation":BuildingConstants.TYPE_TRANSPORT_STATION,
            "rs":BuildingConstants.TYPE_TRANSPORT_STATION,
            "academy":BuildingConstants.TYPE_ACADEMY,
            "a":BuildingConstants.TYPE_ACADEMY,
            "workshop":BuildingConstants.TYPE_WORKSHOP,
            "ws":BuildingConstants.TYPE_WORKSHOP,
            "feastinghall":BuildingConstants.TYPE_HEROS_MANSION,
            "fh":BuildingConstants.TYPE_HEROS_MANSION,
            "embassy":BuildingConstants.TYPE_EMBASSY,
            "e":BuildingConstants.TYPE_EMBASSY,
            "rallyspot":BuildingConstants.TYPE_TRAINNING_FEILD,
            "r":BuildingConstants.TYPE_TRAINNING_FEILD,
            "beacontower":BuildingConstants.TYPE_SENTRY_BUILDING,
            "be":BuildingConstants.TYPE_SENTRY_BUILDING,
            "townhall":BuildingConstants.TYPE_TOWN_HALL,
            "t":BuildingConstants.TYPE_TOWN_HALL,
            "wall":BuildingConstants.TYPE_WALL,
            "w":BuildingConstants.TYPE_WALL
         };
         obj["toDebugString"] = function():String
         {
            var _loc2_:String = null;
            var _loc1_:String = "";
            for(_loc2_ in obj)
            {
               if(_loc2_ != "toDebugString")
               {
                  _loc1_ += _loc2_ + " = " + obj[_loc2_] + "\n";
               }
            }
            return _loc1_;
         };
         return obj;
      }
      
      private function clearQueueType(param1:String) : void
      {
         var _loc4_:int = 0;
         this.currentAction = "clearqueuetype";
         var _loc2_:TroopBean = Utils.getTroops(param1 + ":1");
         var _loc3_:FortificationsBean = Utils.getFortifications(param1 + ":1");
         if(_loc2_ != null)
         {
            _loc4_ = TFConstants.T_PEASANTS;
            while(_loc4_ <= TFConstants.T_CATAPULT)
            {
               if(_loc2_[Utils.troopIntNames[_loc4_]] > 0)
               {
                  this.cityManager._clearTroopQueuesByType(_loc4_);
               }
               _loc4_++;
            }
         }
         else if(_loc3_ != null)
         {
            _loc4_ = TFConstants.F_TRAP;
            while(_loc4_ <= TFConstants.F_ROCKFALL)
            {
               if(_loc3_[Utils.troopIntNames[_loc4_]] > 0)
               {
                  this.cityManager._clearWallQueueByType(_loc4_);
               }
               _loc4_++;
            }
         }
         else
         {
            this.onCmdResult("Invalid troop or fortification: " + param1);
         }
         this.onCmdFinshed(true);
      }
      
      public function getClosestCity(param1:int, param2:int = -1) : CityState
      {
         return MainScreen.getClosestCityToFieldId(param1,param2);
      }
      
      public function randomTime(param1:String) : int
      {
         var _loc2_:Array = param1.replace("rnd:","").split(":");
         if(_loc2_.length == 1)
         {
            return Utils.getRandomInt(0,int(_loc2_[1]));
         }
         if(_loc2_.length == 2)
         {
            return Utils.getRandomInt(int(_loc2_[0]),int(_loc2_[1]));
         }
         return 0;
      }
      
      private function dumpResource(param1:int, param2:ResourceBean, param3:ResourceBean) : void
      {
         this.currentAction = "dump resource";
         this.cityManager._ls869(param1,param2,param3);
         Utils.callLater(1500,this.onCmdFinshed,[true]);
      }
      
      private function loyaltyAttack(param1:int, param2:int) : void
      {
         this.currentAction = "loyaltyattack";
         this.cityManager._oh316(param1,param2,false);
         this.onCmdFinshed(true);
      }
      
      private function hideRainbow() : void
      {
         this.currentAction = "hiderainbow";
         if(this.cityManager._handleEvasion())
         {
            this.onCmdResult("rainbow has been evacuated");
         }
         else
         {
            this.logCmdResponse("Unable to hide rainbow");
         }
         this.onCmdFinshed(true);
      }
      
      private function autoHeal(param1:Boolean) : void
      {
         this.currentAction = "setAutoHeal";
         this.onCmdResult("Setting Auto Troop Heal to " + (param1 ? "True" : "False"));
         ActionFactory.getInstance().getCommonCommands().setAutoHeal(param1);
         this.onCmdFinshed(true);
      }
      
      private function wallDefenseTo(param1:FortificationsBean) : void
      {
         var _loc2_:FortificationsBean = this.cityManager._ow687();
         var _loc3_:int = TFConstants.F_TRAP;
         while(_loc3_ <= TFConstants.F_ROCKFALL)
         {
            if(_loc2_[Utils.troopIntNames[_loc3_]] < param1[Utils.troopIntNames[_loc3_]])
            {
               this.onCmdResult("Waiting for town\'s turn to build wall defense...");
               this.cityManager._reserveEmergencyTimeSlot();
               this.waitForCmActive(this.wallDefense2,[Utils.troopAbrNames[_loc3_],param1[Utils.troopIntNames[_loc3_]] - _loc2_[Utils.troopIntNames[_loc3_]],"build"]);
               return;
            }
            _loc3_++;
         }
         this.onCmdResult("No wall defense to build");
         this.onCmdFinshed(true);
      }
      
      private function rescanMap(param1:int, param2:Number, param3:Boolean = false) : void
      {
         this.currentAction = "rescanmap";
         Map.resetArea(Map.getX(param1),Map.getY(param1),param2);
         this.scanMap(param1,param2);
      }
      
      public function getMapDistance(param1:int, param2:int) : Number
      {
         return Map.fieldDistance(param1,param2);
      }
      
      private function cancelTech() : void
      {
         this.currentAction = "canceltech";
         var _loc1_:AvailableResearchListBean = this.cityManager.getResearchInProgress();
         if(_loc1_ == null)
         {
            this.onCmdFinshed(new ScriptError("No current research",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.TECH_CANCEL_RESEARCH,this.handleCmdResponse);
         ActionFactory.getInstance().getTechCommand().cancelResearch(this.castleId);
      }
      
      private function useColonyItem(param1:int, param2:String) : void
      {
         var _loc5_:ColonyBean = null;
         this.currentAction = "usecolonyitem";
         if(this.cityManager.colonies.length == 0)
         {
            this.onCmdFinshed(new ScriptError("This town has no colonies.",-9999));
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         for each(_loc5_ in this.cityManager.colonies)
         {
            _loc4_ = _loc5_.position.split(".");
            if(Map.getFieldId(_loc4_[0],_loc4_[1]) == param1)
            {
               _loc3_ = _loc5_.castleId;
               break;
            }
         }
         if(_loc3_ == 0)
         {
            this.onCmdFinshed(new ScriptError("Target is not a colony of this town.",-9999));
            return;
         }
         var _loc6_:String = Items.getItemId(param2);
         if(_loc6_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item name.",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.COLONY_SPEED_UP_ABANDON_COLONY,this.handleCmdResponse);
         ActionFactory.getInstance().getColonyCommands().speedUpAbandonColony(this.castleId,_loc3_,_loc6_,this.handleCmdResponse);
      }
      
      public function _getScript() : Script
      {
         return this.script;
      }
      
      private function chatWc(param1:String) : void
      {
         this.currentAction = "sendWorldChatMessage";
         ActionFactory.getInstance().getCommonCommands().worldChat(param1,0,this.chatHandler);
         this.onCmdFinshed(true);
      }
      
      private function qFarm() : void
      {
         this.onCmdResult("Calling inline command \\qfarm...");
         MainScreen.getInstance()._chatPanel.getCommander()._kj1046();
         this.onCmdFinshed(true);
      }
      
      private function attack(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "attack";
         this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY,param1,param2,param3,null,param4);
      }
      
      public function get allCities() : Array
      {
         return MainScreen.getCities();
      }
      
      private function warTeleport(param1:int) : void
      {
         this.currentAction = "warteleport";
         this.cityManager._recallIncomingArmies();
         this.setCmdResponse(ResponseDispatcher.CITY__WAR_MOVE_CASTLE,this.handleCmdResponse);
         ActionFactory.getInstance().getCityCommands().WarMoveCastle(this.castleId,param1);
         this.cityManager._resetLocalFieldsInfo();
      }
      
      public function get missionTypes() : Object
      {
         var obj:Object = null;
         obj = {
            "transport":ObjConstants.ARMY_MISSION_TRANS,
            "reinforce":ObjConstants.ARMY_MISSION_SEND,
            "scout":ObjConstants.ARMY_MISSION_SCOUT,
            "buildcity":ObjConstants.ARMY_MISSION_CONSTRUCT,
            "occupy":ObjConstants.ARMY_MISSION_OCCUPY,
            "declaredwar":ObjConstants.ARMY_DECLARED_WAR,
            "colonize":ObjConstants.ARMY_MISSION_COLONIZE,
            "uprise":ObjConstants.ARMY_MISSION_UPRISE,
            "suppress":ObjConstants.ARMY_MISSION_SUPPRESS,
            "anticolonial":ObjConstants.ARMY_MISSION_ANTI_COLONIAL,
            "deploytroops":ObjConstants.ARMY_MISSION_DEPLOY_TROOPS
         };
         obj["toDebugString"] = function():String
         {
            var _loc2_:String = null;
            var _loc1_:String = "";
            for(_loc2_ in obj)
            {
               if(_loc2_ != "toDebugString")
               {
                  _loc1_ += _loc2_ + " = " + obj[_loc2_] + "\n";
               }
            }
            return _loc1_;
         };
         return obj;
      }
      
      private function endSpamAttack() : void
      {
         this.currentAction = "endspamattack";
         this.cityManager._yy805();
         this.onCmdFinshed(true);
      }
      
      public function stateNameFromFieldId(param1:int) : String
      {
         return Map.getRegionName(param1);
      }
      
      private function doComfortByType(param1:int) : void
      {
         this.setCmdResponse(ResponseDispatcher.INTERIOR_PACIFY_PEOPLE,this.handleCmdResponse);
         CityStateCommands.pacifyPeople(this.castleId,param1);
      }
      
      private function handleCmdResponse(param1:Object) : void
      {
         var _loc2_:CommandResponse = param1 as CommandResponse;
         if(_loc2_ == null)
         {
            this.onCmdFinshed(new ScriptError("Unknown response when handling response for " + this.currentAction + " - response: " + param1.toString(),-9999));
         }
         else
         {
            this.onCmdFinshed(param1);
         }
      }
      
      private function setGate(param1:Boolean) : void
      {
         this.currentAction = "setgate";
         this.onCmdResult("Set gate to " + (param1 ? "open" : "closed"));
         this.cityManager._nv1116(param1,null,true);
         this.onCmdFinshed(true);
      }
      
      private function handleQuestTypeResponse(param1:QuestTypeResponse) : void
      {
         var _loc3_:QuestTypeBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            scriptQuestActive = false;
            this.onCmdFinshed(new ScriptError("Error executing completequests: " + param1.errorMsg,param1.ok));
            return;
         }
         if(Version.isTraceOn())
         {
            trace("checkQuestType");
         }
         var _loc2_:int = 0;
         for each(_loc3_ in param1.typesArray)
         {
            if(_loc3_.isFinish || _loc3_.name == "Promotion" || _loc3_.typeId >= 113 && _loc3_.typeId <= 115 || _loc3_.typeId == 64)
            {
               ++findQuestCount;
               _loc2_++;
               ActionFactory.getInstance().getQuestCommands().getQuestList(this.castleId,_loc3_.typeId);
            }
         }
         if(_loc2_ == 0)
         {
            this.onCmdResult("No Finished Quests","");
            findQuestCastleId = 0;
            scriptQuestActive = false;
            this.onCmdFinshed(true);
         }
      }
      
      public function getCityFromName(param1:String) : CityState
      {
         return MainScreen.getCityFromName(param1,true);
      }
      
      private function killWall() : void
      {
         this.onCmdResult("Waiting for town\'s turn to kill wall defense...");
         this.cityManager._reserveEmergencyTimeSlot();
         this.waitForCmActive(this.actKillWall,[]);
      }
      
      private function unFriendPlayerResponseHandler(param1:FriendResponse) : void
      {
         if(param1.ok != 1)
         {
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         var _loc2_:PlayerInfoBean = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.player.friendBeansArray.length)
         {
            if(this.player.friendBeansArray[_loc3_].userName.toLowerCase() == this.friendBlockPlayerName.toLowerCase())
            {
               _loc2_ = this.player.friendBeansArray.removeItemAt(_loc3_) as PlayerInfoBean;
               break;
            }
            _loc3_++;
         }
         var _loc4_:* = "";
         if(_loc2_ != null)
         {
            _loc4_ = "Player \"" + _loc2_.userName + "\" was successfully removed from your Friends List.";
         }
         else
         {
            _loc4_ = "Player \"" + this.friendBlockPlayerName + "\" not found in your Friends List. Check spelling before trying again. No action taken.";
         }
         this.cityManager.logMsg(_loc4_);
         this.friendBlockPlayerName = null;
         this.onCmdFinshed(true);
      }
      
      private function getMayor() : HeroBean
      {
         var _loc1_:Array = this._bw617(CityStateConstants.HERO_STATUS_MAYOR);
         var _loc2_:HeroBean = null;
         if(_loc1_.length == 1)
         {
            _loc2_ = _loc1_[0];
         }
         return _loc2_;
      }
      
      private function handleUseItemResponse(param1:UseItemResultResponse) : void
      {
         var _loc2_:ItemBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.onCmdFinshed(new ScriptError("Use item error: " + param1.errorMsg,-9999));
            return;
         }
         this.onCmdResult("Item used successfully");
         for each(_loc2_ in param1.itemBeansArray)
         {
            this.onCmdResult("  Got: " + _loc2_.count + " " + Items.getItemName(_loc2_.id));
         }
         this.onCmdFinshed(true);
      }
      
      private function honorGuard(param1:int, param2:TroopBean, param3:int = 0) : void
      {
         this.currentAction = "honorguard";
         this.cityManager._by1090(param1,param2,param3,true);
         this.onCmdFinshed(true);
      }
      
      private function skypeGm(param1:String, param2:String) : void
      {
         var response:SkypeResponse;
         var handler:Function;
         var groupname:String = param1;
         var msg:String = param2;
         this.currentAction = "sendSkypeGroupMessage";
         handler = function(param1:SkypeResponse):void
         {
            if(param1.ok != SkypeConstants.OK_DEFAULT)
            {
               if(currentAction == "sendSkypeGroupMessage")
               {
                  onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
               }
               else
               {
                  cityManager.logMsg(param1.errorMsg + ":" + param1.ok);
               }
            }
            else
            {
               if(!script.silence)
               {
                  cityManager.logMsg(param1.msg);
               }
               if(currentAction == "sendSkypeGroupMessage")
               {
                  onCmdFinshed(true);
               }
            }
         };
         response = Skype.queueMsg(groupname,msg,true,handler);
         if(response.ok != SkypeConstants.OK_DEFAULT)
         {
            if(response.ok == SkypeConstants.OK_MSG_QUEUED)
            {
               this.cityManager.logMsg("Skype group message has been queued, waiting for login to send...");
               this.onCmdFinshed(true);
            }
            else
            {
               this.onCmdFinshed(new ScriptError("Error sending Skype Group Message: " + response.errorMsg,response.ok));
            }
         }
      }
      
      private function waitForBuildingQueue(param1:Function, param2:Array) : void
      {
         var handler:Function = null;
         var waitTimer:Timer = null;
         var func:Function = param1;
         var args:Array = param2;
         this.pleaseStop = false;
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               waitTimer = null;
               return;
            }
            waitTimer.delay = 1000;
            if(cityManager.isBuildingQueueAvailable())
            {
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               waitTimer = null;
               func.apply(this,args);
            }
         };
         waitTimer = new Timer(0);
         waitTimer.addEventListener(TimerEvent.TIMER,handler);
         waitTimer.start();
      }
      
      private function unFriendPlayer(param1:String) : void
      {
         this.currentAction = "unfriend player";
         this.friendBlockPlayerName = param1;
         ActionFactory.getInstance().getFriendCommands().deleteFriend(param1,this.unFriendPlayerResponseHandler);
      }
      
      private function endGuardedAttack() : void
      {
         this.currentAction = "endguardedattack";
         this.cityManager._dv194();
         this.onCmdFinshed(true);
      }
      
      private function star(param1:String, param2:String, param3:int) : void
      {
         this.currentAction = "star";
         var _loc4_:int = GearType.fromString(param1);
         if(_loc4_ <= 0)
         {
            this.logCmdResponse("Invalid gear type: " + param1);
            this.onCmdFinshed(true);
            return;
         }
         param2 = param2.substr(0,2);
         if(param2 != "fl" && param2 != "de")
         {
            this.logCmdResponse("Invalid gem type: " + param1 + ", must be delicate or flawless");
            this.onCmdFinshed(true);
            return;
         }
         if(param3 <= 0 || param3 > 4)
         {
            this.logCmdResponse("Invalid gem count: " + param3 + ", must be between 1-4");
            this.onCmdFinshed(true);
            return;
         }
         var _loc5_:String = param2 == "de" ? Items.getItemId("Delicate_gem") : Items.getItemId("Flawless_gem");
         if(this.getItemCount(_loc5_) < param3)
         {
            this.logCmdResponse("Not enough gem: " + this.getItemCount(_loc5_) + Items.getItemName(_loc5_));
            this.onCmdFinshed(true);
            return;
         }
         this.setCmdResponse(ResponseDispatcher.EQUIPMENT__ENHANCED_STAR_BY_GEM_STONE,this.starHandler);
         ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(_loc5_,param3,_loc4_);
      }
      
      private function awardGold(param1:String) : void
      {
         var _loc2_:HeroBean = null;
         _loc2_ = this.findHeroByName(param1);
         this.currentAction = "awardgold";
         if(_loc2_ == null)
         {
            this.onCmdFinshed(new ScriptError("No hero found with name: " + param1,-9999));
            return;
         }
         this.onCmdResult("Award gold to hero " + _loc2_);
         this.setCmdResponse(ResponseDispatcher.HERO_AWARD_GOLD,this.handleCmdResponse);
         CityStateCommands.awardGold(this.castleId,_loc2_.id,this.handleCmdResponse);
      }
      
      private function huntingPos(param1:int) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "huntingpos";
         this.cityManager._vw697(Map.fieldIdToCoordString(param1));
         this.onCmdFinshed(true);
      }
      
      private function valleyHeroes(param1:String) : void
      {
         this.currentAction = "valleyheroes";
         this.printGoalCommandWarning();
         this.cityManager._ap1008(param1);
         this.onCmdFinshed(true);
      }
      
      private function setTaxRate(param1:int) : void
      {
         this.onCmdResult("Setting tax rate to " + param1.toString() + ".");
         CityStateCommands.modifyTaxRate(this.castleId,param1,this.handleCmdResponse);
      }
      
      public function get cm() : CityManager
      {
         return this.cityManager;
      }
      
      private function abandonTown2() : void
      {
         this.currentAction = "abandontown";
         this.cityManager._recallIncomingArmies();
         this.onCmdResult("Abandon town " + this.castle.name);
         this.setCmdResponse(ResponseDispatcher.CITY_GIVEUP_CASTLE,this.handleCmdResponse);
         CityStateCommands.giveupCastle(LoginHelper.getInstance().getHashedEvonyPw(),this.castleId);
      }
      
      private function bigReinforce(param1:int, param2:String, param3:TroopBean, param4:ResourceBean = null, param5:String = "") : void
      {
         this.currentAction = "bigreinforce";
         this.doMarch(ObjConstants.ARMY_MISSION_SEND,param1,param2,param3,param4,param5,true);
      }
      
      private function _fq231(param1:ArmyPracticeResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logCmdResponse("Excercise error: " + param1.msg);
            this.onCmdFinshed(true);
            return;
         }
         if(param1.result == ArmyPracticeResponse.ARMY_PRACTICE_RESULT_ATTACK_WIN)
         {
            this.onCmdResult("  Attacker wins in " + param1.round + " rounds");
         }
         else
         {
            this.onCmdResult("  Defender wins in " + param1.round + " rounds");
         }
         this.onCmdResult("  Attacker lost: " + Utils.troopBeanToString(param1.attackLostTroop));
         this.onCmdResult("  Defender lost: " + Utils.troopBeanToString(param1.defendLostTroop));
         this.onCmdFinshed(true);
      }
      
      private function npcHeroes(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "npcheroes";
         this.cityManager._cfg_npcHeroes(param1);
         this.onCmdFinshed(true);
      }
      
      private function claimPackage(param1:int) : void
      {
         this.currentAction = "claimGiftPackage";
         ActionFactory.getInstance().getCommonCommands().getPackage(param1,"",this.claimPackageResponse);
      }
      
      private function npc10Troop(param1:TroopBean) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "npctroops";
         this.cityManager._setNpcTroopCond(Utils.troopBeanToMsgString(param1));
         this.onCmdFinshed(true);
      }
      
      private function abandon(param1:int) : void
      {
         this.currentAction = "abandon";
         CityStateCommands.giveUpField(param1);
         this.onCmdResult("Abandoned " + Map.fieldIdToString(param1));
         this.onCmdFinshed(true);
      }
      
      private function waitResearch(param1:Function, param2:Array) : void
      {
         var handler:Function = null;
         var waitTimer:Timer = null;
         var func:Function = param1;
         var args:Array = param2;
         this.pleaseStop = false;
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               waitTimer = null;
               return;
            }
            waitTimer.delay = 1000;
            if(cityManager.getResearchInProgress() == null)
            {
               func.apply(this,args);
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               waitTimer = null;
            }
         };
         waitTimer = new Timer(0);
         waitTimer.addEventListener(TimerEvent.TIMER,handler);
         waitTimer.start();
      }
      
      private function handleGetColonyArmyInfoResponse(param1:ColonialArmyResponse) : void
      {
         var _loc2_:ArmyBean = null;
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError("Error received: " + param1.errorMsg,-9999));
            return;
         }
         if(param1.armyBeansArray.length == 0)
         {
            this.onCmdResult("No army in colony");
            this.onCmdFinshed(true);
         }
         else
         {
            this.onCmdResult("Armies found in colony");
            for each(_loc2_ in param1.armyBeansArray)
            {
               this.cityManager.logMsg("  " + Utils.armyToString(_loc2_));
            }
            this.onCmdFinshed(true);
         }
      }
      
      private function doMarch(param1:int, param2:int, param3:String, param4:TroopBean, param5:ResourceBean = null, param6:String = "", param7:Boolean = false, param8:Boolean = false, param9:int = 0, param10:Function = null) : void
      {
         var selectedHero:HeroBean = null;
         var armyReady:Boolean = false;
         var minStamina:int = 0;
         var waitTimeCount:int = 0;
         var handler:Function = null;
         var timer:Timer = null;
         var marchType:int = param1;
         var targetId:int = param2;
         var hero:String = param3;
         var troopObj:TroopBean = param4;
         var resources:ResourceBean = param5;
         var restTime:String = param6;
         var warEnsign:Boolean = param7;
         var stygandrsBannerOfTheHorde:Boolean = param8;
         var argGearing:int = param9;
         var callback:Function = param10;
         if(targetId == this.castle.fieldId)
         {
            this.logCmdResponse(this.currentAction,"- destination is the current castle");
            this.onCmdFinshed(true);
            return;
         }
         if(targetId == -1)
         {
            this.logCmdResponse(this.currentAction,"- Invalid target coordinates.  Specify coords as \'x, y\'");
            this.onCmdFinshed(true);
            return;
         }
         if(troopObj == null)
         {
            this.logCmdResponse(this.currentAction,"- invalid troop");
            this.onCmdFinshed(true);
            return;
         }
         this.pleaseStop = false;
         selectedHero = null;
         armyReady = false;
         minStamina = marchType == ObjConstants.ARMY_MISSION_SEND ? 1 : (marchType == ObjConstants.ARMY_MISSION_TRANS ? 2 : 4);
         waitTimeCount = 0;
         handler = function(param1:TimerEvent):void
         {
            var newArmy:NewArmyParam = null;
            var baseTravelTime:Number = NaN;
            var rsSpeedUp:int = 0;
            var heroSpeedUp:Number = NaN;
            var travelTime:int = 0;
            var buffsCampFactor:Number = NaN;
            var restTimeNumeric:Number = NaN;
            var e:TimerEvent = param1;
            if(waitTimeCount == 1)
            {
               onCmdResult("Checking for available hero and troops...","");
            }
            ++waitTimeCount;
            timer.delay = 1500;
            if(pleaseStop)
            {
               onCmdFinshed(new ScriptError("Script stop, troop deployment cancelled",-9999));
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               return;
            }
            armyReady = isRallySlotAvailable();
            try
            {
               if(armyReady)
               {
                  if(hero.length == 0 || hero.toLowerCase() == "none")
                  {
                     armyReady = armyReady;
                  }
                  else
                  {
                     selectedHero = getHeroByNameOrKey(hero,minStamina);
                     armyReady = selectedHero != null && armyReady;
                  }
               }
            }
            catch(se:ScriptError)
            {
               onCmdFinshed(se);
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               return;
            }
            if(armyReady)
            {
               armyReady = cityHasEnoughTroops(troopObj) && armyReady;
            }
            if(armyReady)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               newArmy = new NewArmyParam();
               newArmy.missionType = marchType;
               newArmy.targetPoint = targetId;
               newArmy.troops = troopObj;
               newArmy.useFlag = warEnsign;
               newArmy.useItem = stygandrsBannerOfTheHorde;
               if(selectedHero != null)
               {
                  newArmy.heroId = selectedHero.id;
                  if(argGearing > 0)
                  {
                     ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(selectedHero.id,argGearing);
                     onCmdResult(" Changing gear to " + (argGearing == 1 ? "Pol" : (argGearing == 2 ? "Atk" : "Int")) + " for " + selectedHero.name);
                  }
               }
               if(resources == null)
               {
                  resources = new ResourceBean();
               }
               newArmy.resource = resources;
               baseTravelTime = cityManager.getBaseTravelTime(castle.fieldId,targetId,troopObj);
               rsSpeedUp = (MainScreen.getCityFromFieldId(targetId) != null || Map.getType(targetId) == FieldConstants.TYPE_CASTLE && Map.getDetailInfo(targetId,30).allianceName != null && player.playerInfo.alliance != null && Map.getDetailInfo(targetId,30).allianceName == player.playerInfo.alliance) && (marchType == ObjConstants.ARMY_MISSION_SEND || marchType == ObjConstants.ARMY_MISSION_TRANS) ? _getReliefStationSpeedupFactor() : 1;
               heroSpeedUp = selectedHero != null ? Utils.getHeroSpeedFactor(selectedHero) : 1;
               travelTime = baseTravelTime / rsSpeedUp / heroSpeedUp;
               buffsCampFactor = 1;
               restTimeNumeric = 0;
               if(restTime != "")
               {
                  buffsCampFactor = cityManager.getCampTimeChangeBuffsFactor();
                  if(travelTime == 0 && buffsCampFactor == 1)
                  {
                     onCmdFinshed(new ScriptError("No troop or town has yet to be initialized (research not available)",-9999));
                     return;
                  }
                  if((restTimeNumeric = _parseRestTime(restTime,travelTime)) > 0)
                  {
                     if(restTimeNumeric > 20 * 3600)
                     {
                        logCmdResponse("WARNING: Large camp time " + Utils.formatTime(restTimeNumeric),"","#FF0000");
                     }
                     if(int(int(restTimeNumeric) * buffsCampFactor) > 24 * 60 * 60)
                     {
                        onCmdFinshed(new ScriptError("Camp time exceeds server limit at " + Utils.formatTime(int(restTimeNumeric) * buffsCampFactor) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]",-9999));
                        return;
                     }
                  }
                  else if(restTimeNumeric < 0)
                  {
                     logCmdResponse("WARNING: Inappropriate camp time is ignored","","#FF0000");
                     if(restTime.charAt(0) == "+")
                     {
                        logCmdResponse("  make sure you run \'calibrate\' recently!","","#FF0000");
                     }
                     restTimeNumeric = 0;
                  }
               }
               setCmdResponse(ResponseDispatcher.ARMY_NEW_ARMY,handleCmdResponse);
               newArmy.restTime = int(restTimeNumeric);
               onCmdResult(currentAction,"- starting march to " + Map.fieldIdToCoordString(targetId) + " arrival at " + Utils.getLogTimeStr(Utils.getServerTime() + campTimeDelta + (travelTime + restTimeNumeric) * 1000) + (selectedHero == null ? "" : " using " + selectedHero.name) + " with " + Utils.troopBeanToMsgString(troopObj) + " carrying " + Utils.resourceBeanToString(resources) + " in " + Utils.formatTime(travelTime + newArmy.restTime));
               if(restTime != "")
               {
                  Utils.callLater((restTimeNumeric - newArmy.restTime) * 1000,CityStateCommands.newArmy,[castleId,newArmy]);
               }
               else
               {
                  CityStateCommands.newArmy(castleId,newArmy);
               }
            }
         };
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function completeQuests(param1:String = "daily") : void
      {
         this.currentAction = "completequests";
         if(findQuestCastleId != 0)
         {
            if(Version.isTraceOn())
            {
               trace("Quest waiting: " + findQuestCastleId);
            }
            this.logCmdResponse("Only one city at a time may use completequests");
            this.onCmdFinshed(false);
            return;
         }
         scriptQuestActive = true;
         findQuestCastleId = this.castleId;
         findQuestCount = 0;
         this.setCmdResponse(ResponseDispatcher.QUEST_GET_QUEST_TYPE,this.handleQuestTypeResponse);
         this.setCmdResponse(ResponseDispatcher.QUEST_GET_QUEST_LIST,this.handleQuestListResponse);
         switch(param1.toLowerCase())
         {
            case "routine":
               ActionFactory.getInstance().getQuestCommands().getQuestType(this.castleId,1);
               break;
            case "daily":
               ActionFactory.getInstance().getQuestCommands().getQuestType(this.castleId,3);
               break;
            case "donate":
               ActionFactory.getInstance().getQuestCommands().getQuestType(this.castleId,4);
               break;
            default:
               scriptQuestActive = false;
               findQuestCastleId = 0;
               this.onCmdFinshed(new ScriptError("Invalid quest type. Valid values are: \'routine\', \'daily\', \'donate\'",-9999));
               return;
         }
      }
      
      private function getSpamHero(param1:String = "power") : void
      {
         this.currentAction = "getspamhero";
         param1 = param1.toLowerCase();
         if(param1 == "atk" || param1 == "attack")
         {
            param1 = "power";
         }
         else if(param1 == "pol" || param1 == "politic" || param1 == "politics")
         {
            param1 = "management";
         }
         else if(param1 == "int" || param1 == "intel" || param1 == "intell")
         {
            param1 = "stratagem";
         }
         this.cityManager._getSpamHero(param1);
         Utils.callLater(1500,this.onCmdFinshed,[true]);
      }
      
      public function _qKillWall() : void
      {
         var _loc3_:int = 0;
         if(this.cityManager.fortification == null)
         {
            this.onCmdResult("No Walls to Destroy");
            return;
         }
         this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT,this.handleCmdResponse);
         var _loc1_:int = 0;
         var _loc2_:Array = [TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ARROWTOWER,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL];
         for each(_loc3_ in _loc2_)
         {
            _loc1_ = int(this.cityManager.fortification[Utils.troopIntNames[_loc3_]]);
            this.onCmdResult("Destroying " + _loc1_ + " of fortification: " + Utils.troopIntNames[_loc3_]);
            CityStateCommands.destructWallProtect(this.castleId,_loc3_,_loc1_);
         }
         this.cityManager._clearWallQueue(0);
      }
      
      public function getCityFromCastleId(param1:int) : CityState
      {
         return MainScreen.getCityFromCastleId(param1);
      }
      
      private function _sp1096(param1:Object) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError(param1.msg,param1.ok));
            return;
         }
         var _loc2_:ReportListResponse = param1 as ReportListResponse;
         if(_loc2_ == null || _loc2_.reportsArray.length == 0)
         {
            this.onCmdFinshed(new ScriptError("No reports",-9999));
            return;
         }
         var _loc3_:String = CallbackParams.cleanReportsSearchString;
         var _loc4_:Array = _loc3_.toLowerCase().split(",");
         for each(_loc5_ in _loc2_.reportsArray)
         {
            for each(_loc6_ in _loc4_)
            {
               if(_loc5_.targetPos.toLowerCase().search(_loc6_) > -1 || _loc5_.title.toLowerCase().search(_loc6_) > -1)
               {
                  if(!this.reportIdsToDelete.contains(_loc5_.id))
                  {
                     this.reportIdsToDelete.addItem(_loc5_.id);
                     break;
                  }
               }
            }
         }
         if(_loc2_.pageNo < _loc2_.totalPage)
         {
            this.cleanReports(_loc3_,_loc2_.pageNo + 1);
            return;
         }
         if(this.reportIdsToDelete.length > 0)
         {
            for each(_loc7_ in this.reportIdsToDelete)
            {
               ActionFactory.getInstance().getReportCommands().deleteReport(String(_loc7_));
            }
            this.onCmdResult("Delete ",this.reportIdsToDelete.length + " reports.");
            this.reportIdsToDelete.removeAll();
            this.onCmdFinshed(true);
            return;
         }
         this.onCmdFinshed(new ScriptError("No reports to delete",-9999));
      }
      
      public function getMapType(param1:int) : int
      {
         return Map.getType(param1);
      }
      
      public function _qWallDefenseNow(param1:int = 14, param2:int = 1) : void
      {
         if(param1 != TFConstants.F_TRAP && param1 != TFConstants.F_ABATIS && param1 != TFConstants.F_ARROWTOWER && param1 != TFConstants.F_ROLLINGLOGS && param1 != TFConstants.F_ROCKFALL)
         {
            this.onCmdResult("Unknown Wall type :( [" + Utils.troopExtNames[param1] + "]");
            return;
         }
         if(param2 > 0)
         {
            this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT,this.handleCmdResponse);
            while(param2 > 0 && (!this.cityManager._isEnoughSlotsOnWall(param2,param1) || !this.cityManager._isEnoughResoToProduceFort(param1,param2)))
            {
               param2 /= 1.01;
            }
            if(param2 == 0)
            {
               this.onCmdResult("No fortifications of type " + Utils.troopExtNames[param1] + " can be queued at this time.");
               return;
            }
            this.onCmdResult("Queued " + param2 + " fortifications of type: " + Utils.troopExtNames[param1] + ".");
            CityStateCommands.produceWallProtect(this.castleId,param1,param2);
            Utils.callLater(2000,this.cityManager.updateWallQueue);
            return;
         }
         if(param2 < 0)
         {
            this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT,this.handleCmdResponse);
            param2 = Math.abs(param2);
            if(this.cityManager.fortification != null && param2 > this.cityManager.fortification[Utils.troopIntNames[param1]])
            {
               param2 = int(this.cityManager.fortification[Utils.troopIntNames[param1]]);
            }
            this.onCmdResult("Destroyed " + param2 + " of fortification: " + Utils.troopExtNames[param1]);
            CityStateCommands.destructWallProtect(this.castleId,param1,param2);
            return;
         }
      }
      
      private function listBuffs() : void
      {
         this.currentAction = "listbuffs";
         this.cityManager._printPlayerBuffs();
         this.onCmdFinshed(true);
      }
      
      public function getItemId(param1:String) : String
      {
         return Items.getItemId(param1);
      }
      
      private function handleChangeHeroGearResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cityManager.logMsg("Error: " + param1.errorMsg.split("<").join("&lt;").split(">").join("&gt;"),"#CC0000");
         }
      }
      
      private function endKeepTroop() : void
      {
         this.currentAction = "endkeeptroop";
         this.cityManager._ji428();
         this.onCmdFinshed(true);
      }
      
      private function useAdvByHiddenPathHandler(param1:Object) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.onCmdFinshed(new ScriptError("Error received for " + this.currentAction + " - response: " + param1.errorMsg,param1.ok));
         }
         else
         {
            this.cityManager._clearLastAmbushErrorTime();
            this.onCmdFinshed(param1);
         }
      }
      
      private function changeHeroGear(param1:String, param2:String) : void
      {
         var gearTypes:Array = null;
         var gearType:int = 0;
         var hero:HeroBean = null;
         var func:Function = null;
         var timer:Timer = null;
         var heroName:String = param1;
         var gearSet:String = param2;
         this.currentAction = "changeHeroGear";
         gearTypes = new Array("none","pol","atk","int");
         gearType = int(gearTypes.indexOf(gearSet.toLowerCase()));
         if(gearType == -1)
         {
            this.onCmdFinshed(new ScriptError("Invalid gear type, must be either none, pol, atk, or int",-9999));
            return;
         }
         hero = null;
         if(heroName.toLowerCase() == "all")
         {
            for each(hero in this.cityManager.heroes)
            {
               if(hero.status == HeroConstants.HERO_FREE_STATU)
               {
                  this.cityManager.logMsg("Changing gear on " + hero.name + " to " + gearTypes[gearType],"#000000");
                  if(gearType == 0)
                  {
                     ActionFactory.getInstance().getEquipmentCommands().TakeOffAllEquipmenttech(hero.id,this.handleChangeHeroGearResponse);
                  }
                  else
                  {
                     ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(hero.id,gearType,this.handleChangeHeroGearResponse);
                  }
               }
            }
            func = function(param1:TimerEvent = null):void
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,func);
               timer = null;
               onCmdFinshed(true);
            };
            timer = new Timer(500);
            timer.repeatCount = 1;
            timer.addEventListener(TimerEvent.TIMER,func);
            timer.start();
         }
         else
         {
            hero = this.findHeroByName(heroName);
            if(hero == null)
            {
               this.onCmdFinshed(new ScriptError("No hero found with name: " + heroName,-9999));
               return;
            }
            if(gearType == 0)
            {
               ActionFactory.getInstance().getEquipmentCommands().TakeOffAllEquipmenttech(hero.id,this.handleCmdResponse);
            }
            else
            {
               ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(hero.id,gearType,this.handleCmdResponse);
            }
         }
      }
      
      public function getCityFromCoord(param1:String, param2:String = null) : CityState
      {
         return MainScreen.getCityFromFieldId(Map.coordStringToFieldId(param1 + (param2 != null ? "," + param2 : "")));
      }
      
      private function unsetNpcFlag(param1:int) : void
      {
         this.currentAction = "unsetnpcflag";
         this.cityManager._markAndUnmarkFlatForNpc(param1,false);
         this.onCmdFinshed(true);
      }
      
      private function buy(param1:String, param2:Number, param3:Number) : void
      {
         this.currentAction = "buy";
         this.trade("buy",param1,param2,param3);
      }
      
      private function getHeroByNameOrKey(param1:String, param2:int = 4) : HeroBean
      {
         var _loc12_:String = null;
         var _loc3_:ArrayCollection = new ArrayCollection();
         var _loc4_:ArrayCollection = new ArrayCollection();
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:HeroBean = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Array = param1.toLowerCase().split(",");
         for each(_loc12_ in _loc11_)
         {
            if(Version.isTraceOn())
            {
               trace("heroStr: " + _loc12_);
            }
            if(_loc12_.substr(0,1) == "!")
            {
               _loc9_ = this.getHeroNamesFromMacroNames(_loc12_.substr(1));
               if(Version.isTraceOn())
               {
                  trace("fromMacro: " + _loc9_);
               }
               if(_loc9_.indexOf(";") > -1)
               {
                  for each(_loc10_ in _loc9_.split(";"))
                  {
                     if(Version.isTraceOn())
                     {
                        trace("heroName" + _loc10_);
                     }
                     _loc4_.addItem(_loc10_);
                  }
               }
               else
               {
                  _loc4_.addItem(_loc9_);
               }
            }
            else if(_loc12_ == "any")
            {
               _loc7_ = true;
            }
            else if(_loc12_.substr(0,4) == "any+" || _loc12_.substr(0,4) == "any-")
            {
               _loc5_ = true;
               for each(_loc8_ in this.cityManager.getHeroesByPowerAndStamina(int(_loc12_.substring(3)),param2))
               {
                  _loc3_.addItem(_loc8_.name.toLowerCase());
               }
            }
            else
            {
               _loc9_ = this.getHeroNamesFromMacroNames(_loc12_);
               if(Version.isTraceOn())
               {
                  trace("fromMacro: " + _loc9_);
               }
               if(_loc9_.indexOf(";") > -1)
               {
                  for each(_loc10_ in _loc9_.split(";"))
                  {
                     if(Version.isTraceOn())
                     {
                        trace("heroName" + _loc10_);
                     }
                     _loc3_.addItem(_loc10_);
                  }
               }
               else
               {
                  _loc3_.addItem(_loc9_);
               }
            }
         }
         for each(_loc8_ in this.cityManager._ox998())
         {
            if(!_loc4_.contains(_loc8_.name.toLowerCase()))
            {
               if(_loc3_.contains(_loc8_.name.toLowerCase()) || _loc7_)
               {
                  _loc6_ = true;
                  if(!(_loc8_.status != CityStateConstants.HERO_STATUS_IDLE || _loc8_.stamina < param2))
                  {
                     this.onVerboseCmdResult("getIdleHero - hero selected: " + _loc8_.name);
                     return _loc8_;
                  }
               }
            }
         }
         if(!_loc6_ && !_loc5_)
         {
            throw new ScriptError("You failed to specify a valid hero or \'any\'",-9999);
         }
         return null;
      }
      
      private function test() : void
      {
         this.onCmdResult("test - nothing to execute");
         this.onCmdFinshed(true);
      }
      
      private function onVerboseCmdResult(param1:String) : void
      {
         if(this.verboseLogs)
         {
            this.onCmdResult(param1);
         }
      }
      
      public function _parseRestTime(param1:String, param2:int = 0) : Number
      {
         if(param1.length == 0)
         {
            return 0;
         }
         var _loc3_:Boolean = param1.charAt(0) == "@" || param1.charAt(0) == "a";
         var _loc4_:* = param1.charAt(0) == "+";
         var _loc5_:int = 0;
         while(_loc5_ < param1.length && (param1.charAt(_loc5_) < "0" || param1.charAt(_loc5_) > "9"))
         {
            _loc5_++;
         }
         param1 = param1.slice(_loc5_);
         if(param1.length == 0)
         {
            return 0;
         }
         if(_loc4_)
         {
            return (lastCalibrateTime - campTimeDelta - Utils.getServerTime()) / 1000 + this.parseTime(param1,false) - param2;
         }
         if(!_loc3_)
         {
            return this.parseTime(param1,false);
         }
         var _loc6_:Number = this.parseTime(param1,true);
         if(param2 + campTimeDelta / 1000 > _loc6_)
         {
            return 0;
         }
         return _loc6_ - param2 - campTimeDelta / 1000;
      }
      
      public function qdeploy(param1:String, param2:int, param3:String, param4:TroopBean, param5:ResourceBean = null, param6:String = "", param7:Boolean = false, param8:Boolean = false, param9:int = 0) : String
      {
         return this._doQuickMarch(getMissionConstFromString(param1),param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      private function rallyMax(param1:String) : void
      {
         this.currentAction = "getRallymax";
         this.printGoalCommandWarning();
         this.cityManager._setRallyMax(param1);
         this.onCmdFinshed(true);
      }
      
      private function setGoal() : void
      {
         MainScreen.getInstance()._cityPanel.onSetGoals(this.castleId);
         this.onCmdFinshed(true);
      }
      
      private function persuadeHero(param1:String) : void
      {
         var _loc4_:HeroBean = null;
         var _loc2_:HeroBean = null;
         var _loc3_:Boolean = false;
         this.currentAction = "persuadehero";
         for each(_loc4_ in this.cityManager._ox998())
         {
            if(_loc4_.name.toLowerCase() == param1.toLowerCase())
            {
               _loc3_ = true;
               if(_loc4_.status == CityStateConstants.HERO_STATUS_CAPTIVE)
               {
                  _loc2_ = _loc4_;
               }
            }
         }
         if(_loc2_ != null)
         {
            this.setCmdResponse(ResponseDispatcher.HERO_TRY_GET_SEIZED_HERO,this.handleCmdResponse);
            this.onCmdResult("Persuade hero " + param1);
            CityStateCommands.tryGetSeizedHero(this.castleId,_loc2_.id);
            return;
         }
         this.onCmdFinshed(new ScriptError("You failed to specify a valid idle hero",-9999));
      }
      
      private function setMayorByType(param1:String = "politics") : Object
      {
         var _loc12_:HeroBean = null;
         var _loc13_:Array = null;
         var _loc2_:Object = new Object();
         _loc2_.finishedresult = true;
         if(this.castle.herosArray.length < 1)
         {
            _loc2_.finishedresult = new ScriptError("has no heroes",-9999);
            return _loc2_;
         }
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if("at" == param1.toLowerCase().substr(0,2))
         {
            _loc3_ = "[attack ";
            _loc4_ = "power";
            _loc5_ = 2;
         }
         else if("po" == param1.toLowerCase().substr(0,2))
         {
            _loc3_ = "[politics ";
            _loc4_ = "management";
            _loc5_ = 1;
         }
         else
         {
            if("in" != param1.toLowerCase().substr(0,2))
            {
               if("re" == param1.toLowerCase().substr(0,2))
               {
                  CityStateCommands.dischargeChief(this.castleId);
                  this.onCmdResult("Removed current mayor");
                  return _loc2_;
               }
               _loc2_.finishedresult = new ScriptError("Invalid Hero search type: [" + param1 + "]",-9999);
               return _loc2_;
            }
            _loc3_ = "[intelligence ";
            _loc4_ = "stratagem";
            _loc5_ = 3;
         }
         var _loc6_:HeroBean = null;
         var _loc7_:HeroBean = null;
         var _loc8_:int = -1;
         var _loc9_:Number = -1;
         var _loc10_:String = null;
         var _loc11_:Number = -1;
         for each(_loc12_ in this.castle.herosArray)
         {
            if(_loc12_.status == CityStateConstants.HERO_STATUS_MAYOR)
            {
               _loc11_ = Utils.getTotalPointsForHeroAttribute(_loc12_,_loc4_);
               _loc6_ = _loc12_;
            }
            else if(Utils.getTotalPointsForHeroAttribute(_loc12_,_loc4_) > _loc9_ && _loc12_.status == CityStateConstants.HERO_STATUS_IDLE)
            {
               _loc8_ = _loc12_.id;
               _loc7_ = _loc12_;
               _loc9_ = Utils.getTotalPointsForHeroAttribute(_loc12_,_loc4_);
               _loc10_ = _loc12_.name;
            }
         }
         _loc13_ = null;
         if(_loc8_ != -1 && _loc9_ > _loc11_)
         {
            this.onCmdResult("Promoted " + _loc10_ + " to mayor " + _loc3_ + _loc9_ + "]","");
            CityStateCommands.promoteToChief(this.castleId,_loc8_,this.handleCmdResponse);
            return _loc2_;
         }
         _loc2_.finishedresult = new ScriptError("Did not change mayor.  None available or current mayor is highest level.",-9999);
         return _loc2_;
      }
      
      private function starHandler(param1:GemstoneRespone) : void
      {
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         this.onCmdResult("Star level for " + GearType.toNameString(param1.equipmenttechid) + " is now " + param1.enhancedstarlv);
         this.cityManager._handleStarLevelResponse(param1);
         this.onCmdFinshed(true);
      }
      
      private function releaseHero(param1:int = 69, param2:int = 150) : void
      {
         var _loc5_:HeroBean = null;
         this.currentAction = "releasehero";
         var _loc3_:HeroBean = null;
         var _loc4_:ArrayCollection = this.cityManager._ox998();
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.status == CityStateConstants.HERO_STATUS_CAPTIVE)
            {
               if(_loc5_.management - (_loc5_.level - 1) < param1 && _loc5_.power - (_loc5_.level - 1) < param1 && _loc5_.stratagem - (_loc5_.level - 1) < param1 && _loc5_.level < param2)
               {
                  _loc3_ = _loc5_;
               }
               else
               {
                  this.onCmdResult("Keeping hero " + _loc3_.name + " with stats Lvl:" + _loc3_.level + " Pol:" + _loc3_.management + " Atk:" + _loc3_.power + " Int:" + _loc3_.stratagem);
               }
            }
         }
         if(_loc3_ != null)
         {
            this.setCmdResponse(ResponseDispatcher.HERO_RELEASE_HERO,this.handleCmdResponse);
            this.onCmdResult("Releasing hero " + _loc3_.name + " with stats Lvl:" + _loc3_.level + " Pol:" + _loc3_.management + " Atk:" + _loc3_.power + " Int:" + _loc3_.stratagem);
            CityStateCommands.releaseHero(this.castleId,_loc3_.id);
            return;
         }
         this.onCmdFinshed(new ScriptError("Couldn\'t find any captive hero",-9999));
      }
      
      private function trainTo(param1:TroopBean, param2:String = "atk", param3:String = "all", param4:int = 1) : void
      {
         var _loc7_:String = null;
         if(param1 == null)
         {
            this.onCmdResult(" usage: trainto limit [hero] [barrackid | all | idle] [min amount]","");
            this.onCmdResult("sample: trainto a:400000,s:200000","");
            this.onCmdResult("Trains archers or scouts if you don\'t yet have 400000 archers or 200000 scouts","");
            this.onCmdResult("Other parameters are similar to train script command","");
            this.onCmdFinshed(true);
            return;
         }
         var _loc5_:TroopBean = this.cityManager._getAllTroopPlusQueued();
         var _loc6_:TroopBean = new TroopBean();
         for each(_loc7_ in ["","","peasants","militia","scouter","pikemen","swordsmen","archer","carriage","lightCavalry","heavyCavalry","ballista","batteringRam","catapult"])
         {
            if(_loc7_ != "")
            {
               if(_loc5_[_loc7_] < param1[_loc7_])
               {
                  _loc6_[_loc7_] = param1[_loc7_] - _loc5_[_loc7_];
                  if(_loc6_[_loc7_] >= param4)
                  {
                     this.onCmdResult("Waiting for town\'s turn to train troop...");
                     this.cityManager._reserveEmergencyTimeSlot();
                     this.waitForCmActive(this.train2,[_loc6_,param2,param3,param4]);
                     return;
                  }
                  _loc6_[_loc7_] = 0;
               }
            }
         }
         this.onCmdResult("Nothing to train");
         this.onCmdFinshed(true);
      }
      
      private function abandonTown() : void
      {
         this.currentAction = "abandontown";
         if(this.cityManager.localArmies.length > 0)
         {
            this.onCmdResult("Town still has outgoing army, please use \'abandontown!\' instead");
            this.onCmdFinshed(true);
            return;
         }
         if(Utils.getTotalTroopCount(this.cityManager.troop) > 250)
         {
            this.onCmdResult("Town still has 250+ troops, please use \'abandontown!\' instead");
            this.onCmdFinshed(true);
            return;
         }
         if(this.cityManager._cityStillHasGoodHeroes() || this.cityManager.bestAttackHero() != null && this.cityManager.bestAttackHero().level >= 90 || this.cityManager.bestPoliticHero() != null && this.cityManager.bestPoliticHero().level >= 90)
         {
            this.onCmdResult("Please fire all good heroes first or use \'abandontown!\' instead");
            this.onCmdFinshed(true);
            return;
         }
         this.abandonTown2();
      }
      
      private function autoStar(param1:String, param2:int, param3:String = null, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = null, param10:String = null) : void
      {
         var gem2:String;
         var specs:Array;
         var parts:Array;
         var i:int;
         var techId:int = 0;
         var currentLevel:int = 0;
         var delicateId:String = null;
         var flawlessId:String = null;
         var conditions:Array = null;
         var busy:Boolean = false;
         var starHandler:Function = null;
         var handler:Function = null;
         var timer:Timer = null;
         var count:int = 0;
         var tech:String = param1;
         var targetLevel:int = param2;
         var spec1:String = param3;
         var spec2:String = param4;
         var spec3:String = param5;
         var spec4:String = param6;
         var spec5:String = param7;
         var spec6:String = param8;
         var spec7:String = param9;
         var spec8:String = param10;
         this.currentAction = "autostar";
         if(targetLevel > 15 || targetLevel <= 0)
         {
            this.logCmdResponse("Invalid gear type: " + tech);
            this.onCmdFinshed(true);
            return;
         }
         techId = GearType.fromString(tech);
         if(techId <= 0)
         {
            this.logCmdResponse("Invalid gear type: " + tech);
            this.onCmdFinshed(true);
            return;
         }
         if(this.cityManager.gears.length == 0)
         {
            this.cityManager.updateGears();
            this.logCmdResponse("Gears not initialized yet, please rerun later");
            this.onCmdFinshed(true);
            return;
         }
         currentLevel = this.cityManager.getStarLevel(techId);
         if(currentLevel >= targetLevel)
         {
            this.onCmdResult("autostar: Nothing to do, star level is already " + currentLevel);
            this.onCmdFinshed(true);
            return;
         }
         delicateId = Items.getItemId("Delicate_gem");
         flawlessId = Items.getItemId("Flawless_gem");
         gem2 = null;
         parts = null;
         conditions = new Array();
         specs = new Array();
         if(spec1 != null)
         {
            specs.push(spec1);
         }
         if(spec2 != null)
         {
            specs.push(spec2);
         }
         if(spec3 != null)
         {
            specs.push(spec3);
         }
         if(spec4 != null)
         {
            specs.push(spec4);
         }
         if(spec5 != null)
         {
            specs.push(spec5);
         }
         if(spec6 != null)
         {
            specs.push(spec6);
         }
         if(spec7 != null)
         {
            specs.push(spec7);
         }
         if(spec8 != null)
         {
            specs.push(spec8);
         }
         i = 0;
         while(i < specs.length)
         {
            parts = specs[i].split(":");
            if(parts.length != 4)
            {
               this.logCmdResponse("Invalid autostar specification, expect start:end:gem:count, get " + specs[i]);
               this.onCmdFinshed(true);
            }
            gem2 = parts[2].substr(0,2);
            if(gem2 != "fl" && gem2 != "de")
            {
               this.logCmdResponse("Invalid gem type: " + tech + ", must be delicate or flawless in " + specs[i]);
               this.onCmdFinshed(true);
               return;
            }
            count = int(parts[3]);
            if(count <= 0 || count > 4)
            {
               this.logCmdResponse("Invalid gem count: " + tech + ", must be between 1-4 in " + specs[i]);
               this.onCmdFinshed(true);
               return;
            }
            conditions.push({
               "start":int(parts[0]),
               "end":int(parts[1]),
               "itemId":(gem2 == "fl" ? flawlessId : delicateId),
               "count":int(parts[3])
            });
            i++;
         }
         busy = false;
         this.pleaseStop = false;
         starHandler = function(param1:GemstoneRespone):void
         {
            busy = false;
            if(param1.ok != 1)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               logCmdResponse("  autostar error: " + param1.errorMsg);
               onCmdFinshed(true);
               return;
            }
            var _loc2_:String = currentLevel > param1.enhancedstarlv ? "down to" : (currentLevel < param1.enhancedstarlv ? "UP TO" : "at");
            onCmdResult("  star level of " + tech + " is " + _loc2_ + " " + param1.enhancedstarlv + ", gems: " + getItemCount(delicateId) + " / " + getItemCount(flawlessId));
            currentLevel = param1.enhancedstarlv;
            cityManager._handleStarLevelResponse(param1);
            timer.start();
         };
         handler = function(param1:TimerEvent):void
         {
            var _loc2_:Object = null;
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdResult("autostar has been terminated");
               return;
            }
            timer.reset();
            if(busy)
            {
               return;
            }
            if(!Connection.getInstance().authenticated || Connection.getInstance().paused)
            {
               return;
            }
            if(currentLevel >= targetLevel)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdResult("autostar is successful, star level is now " + currentLevel);
               onCmdFinshed(true);
               return;
            }
            for each(_loc2_ in conditions)
            {
               if(_loc2_.start <= currentLevel && _loc2_.end >= currentLevel && getItemCount(_loc2_.itemId) >= _loc2_.count)
               {
                  onCmdResult("Autostar for " + tech + ":" + currentLevel + ", use " + _loc2_.count + " " + Items.getItemName(_loc2_.itemId));
                  ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(_loc2_.itemId,_loc2_.count,techId,starHandler);
                  busy = true;
                  break;
               }
            }
            if(!busy)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdResult("autostar fails, current star level is " + currentLevel);
               onCmdFinshed(true);
               return;
            }
         };
         timer = new Timer(100);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function listMedals() : void
      {
         this.currentAction = "listmedals";
         this.cityManager.listMedals();
         this.onCmdFinshed(true);
      }
      
      private function friendPlayerResponseHandler(param1:FriendResponse) : void
      {
         if(param1.ok != 1)
         {
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         this.player.friendBeansArray = param1.friendArrArray;
         this.cityManager.logMsg("Player \"" + this.friendBlockPlayerName + "\" was successfully added to your Friends List.");
         this.friendBlockPlayerName = null;
         this.onCmdFinshed(true);
      }
      
      private function demo2(param1:String = "*", param2:String = "HighestLevel") : void
      {
         var _loc3_:int = BuildingType.fromString(param1);
         if(_loc3_ == -1)
         {
            this.onCmdFinshed(new ScriptError("Invalid building",-9999));
            return;
         }
         this.onCmdResult("Starting","demo of " + BuildingType.toString(_loc3_));
         this.currentAction = "demo";
         var _loc4_:BuildingBean = BuildSelectionPolicy.findByPolicy(this.castle.buildingsArray.toArray(),param1,param2,10);
         if(_loc4_ == null)
         {
            this.onCmdFinshed(new ScriptError("Unable to perform demolish.  Unable to find " + param1 + ". Demo level 10 buildings must explicitly specified with level10 build policy",ErrorCode.ERROR_BUILDING_POSITION));
            return;
         }
         if(Version.isTraceOn())
         {
            trace("demo - setting up response callbacks");
         }
         this.setCmdResponse(ResponseDispatcher.CASTLE_DESTRUCT_BUILDING,this.buildCmdHandler);
         if(Version.isTraceOn())
         {
            trace("demo - " + _loc4_.name + ", position " + _loc4_.positionId + " on castle " + this.castleId);
         }
         CityStateCommands.destructBuilding(this.castleId,_loc4_.positionId);
      }
      
      private function fmthGLB() : void
      {
         this.onCmdResult("Move the training hero");
         CityManager.deletePlayerTiming("movetraininghero");
         this.onCmdFinshed(true);
      }
      
      private function waitResource(param1:ResourceBean) : void
      {
         var handler:Function = null;
         var timer:Timer = null;
         var resource:ResourceBean = param1;
         this.currentAction = "waitresource";
         this.pleaseStop = false;
         this.onCmdResult("Waiting for resource " + CityManager.resoBeanToString(resource) + " to be available...");
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdFinshed(true);
               return;
            }
            timer.delay = 2 * 1000;
            if(resource.gold > castle.resource.gold || resource.food > castle.resource.food.amount || resource.wood > castle.resource.wood.amount || resource.stone > castle.resource.stone.amount || resource.iron > castle.resource.iron.amount)
            {
               return;
            }
            onCmdResult("Resource available: " + CityManager.resoBeanToString(resource));
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER,handler);
            timer = null;
            onCmdFinshed(true);
         };
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function resetHeroStatsResponseHandler(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         this.cityManager.logMsg("Hero has been reset successfully.");
         this.onCmdFinshed(true);
      }
      
      public function findHeroByName(param1:String) : HeroBean
      {
         var _loc2_:HeroBean = null;
         if(param1 != null && (param1 = param1.toLowerCase()) != "")
         {
            for each(_loc2_ in this.cityManager.heroes)
            {
               if(_loc2_.name.toLowerCase() == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function create2(param1:String, param2:String = "FirstAvailable", param3:Boolean = false) : void
      {
         var _loc4_:int = BuildingType.fromString(param1);
         if(_loc4_ == -1)
         {
            this.onCmdFinshed(new ScriptError("Invalid building",-9999));
            return;
         }
         this.currentAction = "create";
         if(Version.isTraceOn())
         {
            trace("create - select building");
         }
         var _loc5_:int = CreationPolicy.getPositionByPolicy(this.castle.buildingsArray.toArray(),param1,param2);
         if(_loc5_ == -1)
         {
            this.onCmdFinshed(new ScriptError("Unable to perform create.  Unable to find a free space for " + param1,ErrorCode.ERROR_BUILDING_POSITION));
            return;
         }
         if(param3)
         {
            this.onCmdResult("Queue new building " + BuildingType.toString(_loc4_) + " at location " + _loc5_);
            this.setCmdResponse(ResponseDispatcher.CASTLE_NEW_BUILDING_QUEUE,this.handleCmdResponse);
         }
         else
         {
            this.onCmdResult("Starting of " + BuildingType.toString(_loc4_) + " at location " + _loc5_);
            this.setCmdResponse(ResponseDispatcher.CASTLE_NEW_BUILDING,this.buildCmdHandler);
         }
         if(Version.isTraceOn())
         {
            trace("create - " + param1 + ", position " + _loc5_ + " on castle " + this.castle.name);
         }
         CityStateCommands.newBuilding(this.castleId,_loc5_,_loc4_,null,param3);
      }
      
      private function skypeWarningPolicy(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.currentAction = "";
         this.printGoalCommandWarning();
         if(!this.cityManager._setSkypeWarnPolicy([param1,param2,param3,param4]))
         {
            this.onCmdFinshed(new ScriptError("Parameter error for command skypewarningpolicy",-9999));
         }
         else
         {
            this.onCmdFinshed(true);
         }
      }
      
      private function production(param1:int = 100, param2:int = 100, param3:int = 100, param4:int = 100) : void
      {
         this.currentAction = "production";
         param1 = Math.max(0,Math.min(100,param1));
         param2 = Math.max(0,Math.min(100,param2));
         param3 = Math.max(0,Math.min(100,param3));
         param4 = Math.max(0,Math.min(100,param4));
         this.castle.resource.workPeople = (param1 * this.castle.resource.food.workPeople + param2 * this.castle.resource.wood.workPeople + param3 * this.castle.resource.stone.workPeople + param4 * this.castle.resource.iron.workPeople) / 100;
         CityStateCommands.modifyCommenceRate(this.castleId,param1,param2,param3,param4,this.handleCmdResponse);
         this.onCmdResult("production","- changing production rate f:" + param1 + " w:" + param2 + " s:" + param3 + " i:" + param4);
      }
      
      private function capitalPolicy(param1:String, param2:int) : void
      {
         var op:String;
         var capitalPolicyCallBackParams:Object = null;
         var fieldType:int = 0;
         var getLeftPoliciesTimesHandler:Function = null;
         var operation:String = param1;
         var fieldId:int = param2;
         this.currentAction = "capitalpolicy";
         op = operation.toLowerCase().substr(0,2);
         if(op == "ar" || op == "di" || op == "po" || op == "fo" || op == "ta")
         {
            capitalPolicyCallBackParams = new Object();
            capitalPolicyCallBackParams.operation = operation.toLowerCase();
            switch(this.castle.powerlevel)
            {
               case 4:
                  capitalPolicyCallBackParams = null;
                  this.onCmdFinshed(new ScriptError("This city is not an HC. The \"capitalpolicy\" command can only be used from a Historic City.",-9999));
                  return;
               case 3:
                  capitalPolicyCallBackParams.maxPolicies = 4;
                  break;
               case 2:
                  capitalPolicyCallBackParams.maxPolicies = 6;
                  break;
               case 1:
                  capitalPolicyCallBackParams.maxPolicies = 8;
                  break;
               case 0:
                  capitalPolicyCallBackParams.maxPolicies = 10;
                  break;
               default:
                  capitalPolicyCallBackParams = null;
                  this.onCmdFinshed(new ScriptError("City data incomplete. Cannot determine if city is an HC. Refresh or try again in a few minutes.",-9999));
                  return;
            }
            fieldType = Map.getType(fieldId,60);
            if(fieldType == -1)
            {
               this.onCmdFinshed(new ScriptError("Map is not yet available at " + Map.fieldIdToCoordString(fieldId),-9999));
               return;
            }
            if(!(fieldType == FieldConstants.TYPE_CASTLE || fieldType == FieldConstants.TYPE_NPC))
            {
               this.onCmdFinshed(new ScriptError("Target is not an NPC nor Castle: " + Map.fieldIdToCoordString(fieldId),-9999));
               return;
            }
            getLeftPoliciesTimesHandler = function(param1:CapitalCommandResponse):void
            {
               var op:String;
               var capitalCommandHandler:Function;
               var response:CapitalCommandResponse = param1;
               if(response.ok != 1)
               {
                  onCmdFinshed(new ScriptError("Error received: " + response.errorMsg,-9999));
                  return;
               }
               if(response.amount <= 0)
               {
                  onCmdFinshed(new ScriptError("You have 0/" + capitalPolicyCallBackParams.maxPolicies + " policies left for today. Capital policy operation has been cancelled because \"no policies remaining\"",-9999));
                  return;
               }
               capitalCommandHandler = function(param1:CapitalCommandResponse):void
               {
                  if(param1.ok != 1)
                  {
                     onCmdFinshed(new ScriptError("Error received: " + param1.errorMsg + (param1.errorMsg.toLowerCase().search("policy decree used") == -1 ? "" : "  [ " + (capitalPolicyCallBackParams.leftPolicies - 1) + "/" + capitalPolicyCallBackParams.maxPolicies + " policies left ]"),-9999));
                     return;
                  }
                  --capitalPolicyCallBackParams.leftPolicies;
                  var _loc2_:String = "<b>Capitalpolicy Response</b>: ";
                  var _loc3_:String = capitalPolicyCallBackParams.operation.substr(0,2);
                  switch(_loc3_)
                  {
                     case "fo":
                        _loc2_ += "Successful Food Levy. Acquire <b>" + param1.amount + " food</b>.  From " + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId) + ".";
                        break;
                     case "ta":
                        _loc2_ += "Successful Tax Imposition. Acquire <b>" + param1.amount + " gold</b>.  From " + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId) + ".";
                        break;
                     case "ar":
                        _loc2_ += "Successful Draft. Acquire <b>" + param1.amount + " " + param1.armyType + "</b>.  From " + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId) + ".";
                        break;
                     case "po":
                        _loc2_ += "Successful Pop. Redeployment. Acquire <b>" + param1.amount + " " + param1.armyType + "</b>.  From " + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId) + ".";
                        break;
                     case "di":
                        _loc2_ += "Successful Disarmament. <b>" + param1.amount + " " + param1.armyType + "</b> are disarmed.  From " + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId) + ".";
                        break;
                     default:
                        _loc2_ += "Completed capitalpolicy " + capitalPolicyCallBackParams.operation + " on " + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId) + ": " + param1.amount + " of type " + param1.armyType + ".";
                  }
                  _loc2_ += "  [ " + capitalPolicyCallBackParams.leftPolicies + "/" + capitalPolicyCallBackParams.maxPolicies + " policies left ]";
                  if(Map.getType(capitalPolicyCallBackParams.fieldId) != FieldConstants.TYPE_CASTLE)
                  {
                     cityManager.logMsg(_loc2_);
                  }
                  else
                  {
                     cityManager.warLogMsg(_loc2_);
                  }
                  onCmdFinshed(true);
               };
               capitalPolicyCallBackParams.leftPolicies = response.amount;
               op = capitalPolicyCallBackParams.operation.substr(0,2);
               switch(op)
               {
                  case "fo":
                     onCmdResult("Levy food for capital from " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId));
                     ActionFactory.getInstance().getCapitalCommands().levyFood(castleId,capitalPolicyCallBackParams.fieldId,capitalCommandHandler);
                     break;
                  case "ar":
                     onCmdResult("Draft army for capital from " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId));
                     ActionFactory.getInstance().getCapitalCommands().levyArmy(castleId,capitalPolicyCallBackParams.fieldId,capitalCommandHandler);
                     break;
                  case "po":
                     onCmdResult("Redeploy population for capital from " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId));
                     ActionFactory.getInstance().getCapitalCommands().levyPopulation(castleId,capitalPolicyCallBackParams.fieldId,capitalCommandHandler);
                     break;
                  case "di":
                     onCmdResult("Disarm troops on" + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId));
                     ActionFactory.getInstance().getCapitalCommands().reduceArmaments(castleId,capitalPolicyCallBackParams.fieldId,capitalCommandHandler);
                     break;
                  case "ta":
                     onCmdResult("Levy tax for capital on " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId));
                     ActionFactory.getInstance().getCapitalCommands().levyTaxes(castleId,capitalPolicyCallBackParams.fieldId,capitalCommandHandler);
                     break;
                  default:
                     onCmdFinshed(new ScriptError("Invalid operation " + capitalPolicyCallBackParams.operation + ", must be either food, army, population, disarm, tax",-9999));
               }
            };
            capitalPolicyCallBackParams.fieldId = fieldId;
            ActionFactory.getInstance().getCapitalCommands().getLeftPoliciesTimes(this.castleId,getLeftPoliciesTimesHandler);
         }
         else
         {
            this.onCmdFinshed(new ScriptError("Invalid operation \"" + operation + "\", must be either  food, army, population, disarm, tax",-9999));
         }
      }
      
      private function bigColonize(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "bigcolonize";
         this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE,param1,param2,param3,null,param4,true);
      }
      
      public function _declareWar(param1:int) : void
      {
         var handler:Function = null;
         var timer:Timer = null;
         var targetId:int = param1;
         this.currentAction = "declarewar";
         this.pleaseStop = false;
         handler = function(param1:TimerEvent):void
         {
            var _loc2_:MapCastleBean = null;
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               this.onCmdFinshed(true);
               return;
            }
            timer.delay = 1500;
            _loc2_ = Map.getDetail(targetId);
            if(_loc2_ != null)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               handleDecWar(_loc2_);
            }
         };
         timer = new Timer(0,10);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function handleUseHeroHuntingResponse(param1:HeroListResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.onCmdFinshed(new ScriptError("Use item error: " + param1.errorMsg,-9999));
            return;
         }
         this.cityManager._updateInnHandler(param1);
         this.onCmdResult("Item used successfully");
         this.onCmdFinshed(true);
      }
      
      private function buyItem(param1:String, param2:int = 1) : void
      {
         this.currentAction = "buyitem";
         var _loc3_:String = Items.getItemId(param1);
         if(_loc3_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.SHOP_BUY,this.handleCmdResponse);
         ActionFactory.getInstance().getShopCommands().buy(_loc3_,param2);
      }
      
      private function findField(param1:String, param2:int, param3:Number, param4:String = null, param5:TroopBean = null, param6:int = -1) : void
      {
         var _loc13_:String = null;
         var _loc14_:HeroBean = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:String = null;
         this.currentAction = "find field";
         if(param6 == -1)
         {
            param6 = this.castle.fieldId;
         }
         if(param4 == "none")
         {
            param4 = null;
         }
         var _loc7_:int = Map.getFieldType(param1);
         if(_loc7_ == -1)
         {
            this.logCmdResponse("Invalid field type: " + param1 + ", must be among " + Map.FIELD_NAMES.join(" "),"","#ff0000");
            this.onCmdFinshed(true);
            return;
         }
         if(param2 < 0 || param2 > 20)
         {
            this.logCmdResponse("Field level not in range [0,20]: " + param2,"","#ff0000");
            this.onCmdFinshed(true);
            return;
         }
         if(param3 < 0)
         {
            this.onCmdResult("Radius is less than 0, no town");
            this.onCmdFinshed(true);
            return;
         }
         if(param4 != null && param5 == null)
         {
            this.logCmdResponse("Error: if you specify hero, you must specify troop used","","#ff0000");
            this.logCmdResponse("Example: findfield npc 5 10 any b:400,t:400","","#ff0000");
            this.onCmdFinshed(true);
            return;
         }
         var _loc8_:int = Map.getX(param6);
         var _loc9_:int = Map.getY(param6);
         if(!Map.isMapReady(_loc8_,_loc9_,param3))
         {
            this.logCmdResponse("Map is not ready, please run: scanmap " + _loc8_ + "," + _loc9_ + " " + param3,"","#ff0000");
            this.onCmdFinshed(true);
            return;
         }
         this.onCmdResult("Now checking for level " + param2 + " " + param1 + "(s) in a " + param3 + " mile radius around " + _loc8_ + "," + _loc9_);
         var _loc10_:String = this.getMapFieldList(param1,param2,param3,param6,false);
         var _loc11_:Array = _loc10_ != null ? _loc10_.split(" ") : new Array();
         this.onCmdResult("Found " + _loc11_.length + " " + (param2 == 0 ? "all levels" : "level " + param2) + " " + param1 + "(s) within a " + param3 + " mile radius around " + _loc8_ + "," + _loc9_);
         var _loc12_:int = 0;
         if(param4 == null && param5 == null)
         {
            _loc13_ = "";
            for each(_loc12_ in _loc11_)
            {
               _loc13_ += " " + Map.fieldIdToCoordinate(_loc12_);
            }
            this.onCmdResult(param1 + ":" + param2 + _loc13_);
         }
         else
         {
            if(param4 == null)
            {
               param4 = "none";
            }
            _loc14_ = param4 != "none" ? this.getHeroByNameOrKey(param4,0) : null;
            _loc15_ = _loc14_ != null ? Utils.getHeroSpeedFactor(_loc14_) : 1;
            _loc16_ = 0;
            _loc17_ = 0;
            _loc18_ = "Copy and paste this into the script window\n\n";
            for each(_loc12_ in _loc11_)
            {
               _loc16_ = this.cityManager.getBaseTravelTime(this.castle.fieldId,_loc12_,param5) / _loc15_ * 2;
               _loc17_ += _loc16_;
               _loc18_ += "attack " + Map.getX(_loc12_) + "," + Map.getY(_loc12_) + " " + param4 + " " + Utils.troopBeanToMsgString(param5) + " //Distance: " + int(Map.fieldDistance(this.castle.fieldId,_loc12_) * 100) / 100 + " Mission time: " + Utils.formatTime(_loc16_) + "\n";
            }
            _loc18_ += "//Accumulated mission time: " + Utils.formatTime(_loc17_) + "\n";
            this.onCmdResult(_loc18_);
         }
         this.onCmdFinshed(true);
      }
      
      private function keepResource(param1:int, param2:ResourceBean, param3:Number = 0) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "keepresource";
         this.cityManager.processKeepResourceGoal(Map.fieldIdToCoordString(param1) + " " + Utils.resourceBeanToString(param2) + " " + param3,true);
         this.onCmdFinshed(true);
      }
      
      private function waitSuzerain() : void
      {
         var heroName:String;
         var cb:ColonyBean = null;
         var handler:Function = null;
         var timer:Timer = null;
         this.currentAction = "waitsuzerain";
         this.pleaseStop = false;
         heroName = null;
         cb = null;
         if(this.cityManager.colonies.length > 0 && (this.cityManager.colonies[0] as ColonyBean).relation == 2 && ((this.cityManager.colonies[0] as ColonyBean).status == 1 || (this.cityManager.colonies[0] as ColonyBean).status == 3))
         {
            cb = this.cityManager.colonies[0];
            if(cb.status != 1)
            {
               this.onCmdResult("You are uprisinig against Lord " + cb.lordName + " from " + cb.position);
            }
            else
            {
               this.onCmdResult("You are being Suzed by Lord " + cb.lordName + " from " + cb.position);
            }
            handler = function(param1:TimerEvent):void
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdResult("Suzerain event has ended");
               onCmdFinshed(true);
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER,handler);
            timer.delay = cb.endTime - Utils.getServerTime();
            timer.repeatCount = 1;
            timer.start();
            this.onCmdResult("Sleep for " + Utils.formatTime(timer.delay / 1000) + " which is " + Utils.getLogTimeStr(cb.endTime));
         }
         else
         {
            this.onCmdResult("No Suzerain event to wait for");
            this.onCmdFinshed(true);
         }
      }
      
      private function setMayor(param1:String = "politics") : void
      {
         this.currentAction = "setmayor";
         this.onCmdFinshed(this.setMayorByType(param1).finishedresult);
      }
      
      private function calibrate() : void
      {
         var handler:Function;
         var newDate:Date;
         var r:int;
         var targetId:int;
         var cx:int;
         var cy:int;
         var y:int;
         var x:int;
         var fieldId:int = 0;
         var newArmy:NewArmyParam = null;
         var startTime:Number = NaN;
         this.currentAction = "calibrateCampTime";
         newDate = new Date();
         if(newDate.getTime() - lastCalibrateTime < 5000)
         {
            this.logCmdResponse(this.currentAction,"- please wait a few seconds between calls to calibrate","#2A9A2A");
            this.onCmdFinshed(true);
         }
         this.onCmdResult("Calibration at: " + Utils.getTimeStr(Utils.getServerTime()),"","#2A9A2A");
         newDate = new Date();
         lastCalibrateTime = newDate.getTime();
         if(!this.isRallySlotAvailable())
         {
            this.logCmdResponse(this.currentAction,"- No rally space available","#2A9A2A");
            this.onCmdFinshed(true);
            return;
         }
         targetId = -1;
         cx = Map.getX(this.castle.fieldId);
         cy = Map.getY(this.castle.fieldId);
         r = 5;
         y = 0;
         x = cx - r;
         while(targetId == -1 && x <= cx + r)
         {
            y = cy - r;
            while(targetId == -1 && y <= cy + r)
            {
               fieldId = Map.getFieldId(x,y);
               if(Map.getType(fieldId) == FieldConstants.TYPE_NPC)
               {
                  targetId = fieldId;
               }
               y++;
            }
            x++;
         }
         if(targetId == -1)
         {
            this.logCmdResponse(this.currentAction,"- Please try again later, map is not yet available","#2A9A2A");
            this.onCmdFinshed(true);
            return;
         }
         if(this.castle.troop.scouter == 0)
         {
            this.logCmdResponse(this.currentAction,"- need 1 scout to calibrate","#2A9A2A");
            this.onCmdFinshed(true);
            return;
         }
         newArmy = new NewArmyParam();
         newArmy.missionType = ObjConstants.ARMY_MISSION_SCOUT;
         newArmy.targetPoint = targetId;
         newArmy.troops = new TroopBean();
         newArmy.troops.scouter = 1;
         newArmy.resource = new ResourceBean();
         Utils._fa102(900);
         startTime = Utils.getServerTime();
         handler = function(param1:CommandResponse):void
         {
            var _loc3_:ArmyBean = null;
            var _loc2_:ArmyBean = null;
            for each(_loc3_ in cityManager._getSelfArmies())
            {
               if(_loc3_.missionType == newArmy.missionType && _loc3_.targetFieldId == newArmy.targetPoint && _loc3_.troop.scouter == "1")
               {
                  _loc2_ = _loc3_;
                  break;
               }
            }
            if(_loc2_ != null)
            {
               campTimeDelta = _loc3_.startTime - startTime;
               CityStateCommands.callBackArmy(castleId,_loc2_.armyId);
               onCmdResult(currentAction,"- estimated sending lag time is " + Math.round(campTimeDelta) + "ms","#2A9A2A");
            }
            else
            {
               logCmdResponse(currentAction,"- unable to calibrate","#2A9A2A");
            }
            Utils.callLater(1500,onCmdFinshed,[true]);
         };
         CityStateCommands.newArmy(this.castleId,newArmy,handler);
      }
      
      public function toDebugString() : String
      {
         return "properties: accountTab:AccountInfo actionFactory:ActionFactory actionResponse:ActionFactoryResponse allCities:Array buildingTypes:Object castle:CastleBean cityManager:CityManager coord:String lag:Number m_techLevels:Object math:Object missionTypes:Object player:PlayerBean serverTimeRaw:Number verboseLogs:Boolean,  methods: AnyIdleHero(String,[String]):Boolean changeheroname(String,String):void findHeroById(int):HeroBean findHeroByName(String):HeroBean formatNum(Number,[int]):String getArmy(String,int,String,TroopBean,[ResourceBean],[int],[Boolean]):NewArmyParam getDateFromTime(Number):Date getItemId(String):String getItemName(String):String getLocalTime():Number getMapDetail(int):MapCastleBean getMapDistance(int,int):Number getMapFieldList(String,int,Number,[int],[Boolean]):String getMapLevel(int):int getMapType(int):int getPlayerInfo(String):PlayerInfoBean getRawTime():Number getValue(String,String,[String]):Object getVar(String):String IsHeroInCastle(String):Boolean parseTime(String,[Boolean]):Number qdeploy(String,int,String,TroopBean,[ResourceBean],[String],[Boolean],[int]):String randomTime(String):int stateNameFromFieldId(int):String toDebugString():String toString():String";
      }
      
      private function techGoals(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "techgoals";
         this.cityManager._tj1139(param1);
         this.onCmdFinshed(true);
      }
      
      private function keepTroop(param1:int, param2:TroopBean, param3:int = 0) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "keeptroop";
         this.cityManager.processKeeptroopGoals(Map.fieldIdToCoordString(param1) + " " + Utils.troopBeanToMsgString(param2) + " " + param3,true);
         this.onCmdFinshed(true);
      }
      
      private function cleanNpcReports(param1:int = 1) : void
      {
         this.cleanReports("Barbarian",param1);
      }
      
      private function recallAll() : void
      {
         this.currentAction = "recallall";
         this.cityManager._mi1194(-1);
         this.onCmdFinshed(true);
      }
      
      private function spamHeroes(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "spamheroes";
         this.cityManager._setSpamHeroes(param1);
         this.onCmdFinshed(true);
      }
      
      private function chatHandler(param1:ChatResponse) : void
      {
         if(param1.ok != 1)
         {
            this.logCmdResponse(param1.errorMsg,"" + param1.ok);
         }
      }
      
      public function getTroopCount(param1:TroopBean) : int
      {
         return Utils.getTotalTroopCount(param1);
      }
      
      private function useHeroItem(param1:String, param2:String) : void
      {
         var itemId:String;
         var h:HeroBean = null;
         var getHero:DisappearHeroBean = null;
         var onHeroListResponse:Function = null;
         var onHeroRecoverResponse:Function = null;
         var hero:String = param1;
         var itemName:String = param2;
         this.currentAction = "useheroitem";
         itemId = Items.getItemId(itemName);
         if(itemId == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         if(itemId != "player.item.stoneoffinding")
         {
            h = this.findHeroByName(hero);
            if(h == null)
            {
               h = this.findHeroById(int(hero));
            }
            if(h == null)
            {
               this.onCmdFinshed(new ScriptError("No hero found with Name/ID: " + hero,-9999));
               return;
            }
            ActionFactory.getInstance().getHeroCommand().useItem(this.castleId,h.id,itemId,this.handleCmdResponse);
         }
         else if(this.cityManager.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) <= this.cityManager.heroes.length - (Utils.isRoyalFound(this.cityManager.heroes) ? 1 : 0))
         {
            this.onCmdFinshed(new ScriptError("No available space in Feasting Hall",-9999));
         }
         else
         {
            getHero = null;
            onHeroListResponse = function(param1:DisappearHeroResponse):void
            {
               var _loc2_:DisappearHeroBean = null;
               var _loc3_:String = null;
               if(param1.ok != CommandResponse.OK_DEFAULT)
               {
                  onCmdFinshed(new ScriptError("Error getting recoverable hero list: " + param1.errorMsg,-9999));
               }
               else if(param1.herosArray == null || param1.herosArray.length <= 0)
               {
                  onCmdFinshed(new ScriptError("There are no recoverable heroes at this time",-9999));
               }
               else
               {
                  for each(_loc2_ in param1.herosArray)
                  {
                     if(_loc2_.name == hero || _loc2_.id == hero)
                     {
                        getHero = _loc2_;
                        break;
                     }
                  }
                  if(getHero != null)
                  {
                     ActionFactory.getInstance().getHeroCommand().RecoverDisappearHero(castleId,getHero.id,onHeroRecoverResponse);
                  }
                  else
                  {
                     _loc3_ = "";
                     for each(_loc2_ in param1.herosArray)
                     {
                        _loc3_ += "\n[" + _loc2_.id + "] " + _loc2_.name + "(" + _loc2_.level + ")" + " " + _loc2_.management + "/" + _loc2_.power + "/" + _loc2_.stratagem;
                     }
                     onCmdFinshed(new ScriptError("No recoverable hero found with Name/ID: " + hero + "\nTry copying the ID from the following list:" + _loc3_,-9999));
                  }
               }
            };
            onHeroRecoverResponse = function(param1:CommandResponse):void
            {
               if(param1.ok != CommandResponse.OK_DEFAULT)
               {
                  onCmdFinshed(new ScriptError("Error recovering hero with ID: " + getHero.id + "," + param1.errorMsg,-9999));
               }
               else
               {
                  onCmdResult("Item used successfully.");
                  handleCmdResponse(param1);
               }
            };
            ActionFactory.getInstance().getHeroCommand().GetDisappearHeros(onHeroListResponse);
         }
      }
      
      private function levyByIntType(param1:int) : void
      {
         this.setCmdResponse(ResponseDispatcher.INTERIOR_TAXATION,this.handleCmdResponse);
         CityStateCommands.taxation(this.castleId,param1);
      }
      
      private function resetMapData() : void
      {
         this.currentAction = "rescanmap";
         Map.fullResetMap();
         this.onCmdFinshed(true);
      }
      
      private function onCmdResult(param1:Object, param2:String = "", param3:String = "#000000") : void
      {
         dispatchEvent(new CityStateResponseEvent(param1,param2,param3));
      }
      
      public function _setCastleBean() : void
      {
         this.castle = MainScreen.getCastle(this.castleId);
      }
      
      private function refresh() : void
      {
         this.currentAction = "refreshConnection";
         MainScreen.getInstance().refresh();
         this.onCmdFinshed(true);
      }
      
      public function getRawTime() : Number
      {
         return Utils.getServerTime();
      }
      
      private function pioTeleport(param1:int) : void
      {
         this.currentAction = "pioteleport";
         this.cityManager._recallIncomingArmies();
         this.setCmdResponse(ResponseDispatcher.CITY_UNITE_ADV_MOVE_CASTLE,this.handleCmdResponse);
         ActionFactory.getInstance().getCityCommands().uniteAdvMoveCastle(this.castleId,param1);
         this.cityManager._resetLocalFieldsInfo();
      }
      
      private function scanRec(param1:int, param2:int) : void
      {
         var done:Array = null;
         var nwX:int = 0;
         var nwY:int = 0;
         var seX:int = 0;
         var seY:int = 0;
         var handler:Function = null;
         var scanTimer:Timer = null;
         var nwCorner:int = param1;
         var seCorner:int = param2;
         this.currentAction = "scanrec";
         this.pleaseStop = false;
         done = new Array();
         nwX = Map.getX(nwCorner);
         nwY = Map.getY(nwCorner);
         seX = Map.getX(seCorner);
         seY = Map.getY(seCorner);
         handler = function(param1:TimerEvent):void
         {
            scanTimer.delay = 500;
            scanTimer.reset();
            if(pleaseStop)
            {
               scanTimer.stop();
               scanTimer.removeEventListener(TimerEvent.TIMER,handler);
               scanTimer = null;
               onCmdFinshed(true);
               return;
            }
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            _loc2_ = Math.min(nwX,seX);
            while(_loc2_ <= Math.max(nwX,seX))
            {
               _loc3_ = Math.min(nwY,seY);
               while(_loc3_ <= Math.max(nwY,seY))
               {
                  _loc4_ = Map.getFieldId(_loc2_,_loc3_);
                  if(done[_loc4_] == undefined)
                  {
                     if(Map.getLevel(_loc4_,1800,true) == -1)
                     {
                        scanTimer.start();
                        return;
                     }
                     done[_loc4_] = true;
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
            onCmdResult("SCANREC COMPLETED " + Map.fieldIdToCoordString(nwCorner) + " " + Map.fieldIdToCoordString(seCorner));
            scanTimer.stop();
            scanTimer.removeEventListener(TimerEvent.TIMER,handler);
            scanTimer = null;
            onCmdFinshed(true);
         };
         scanTimer = new Timer(0);
         scanTimer.addEventListener(TimerEvent.TIMER,handler);
         scanTimer.start();
      }
      
      private function claimPackageResponse(param1:GetPackageResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         this.cityManager.logMsg("Claimed the package successfully.");
         ActionFactory.getInstance().getCommonCommands().getPackageNumber(MainScreen.getInstance().setBoxNum);
         this.onCmdFinshed(true);
      }
      
      private function onCmdFinshed(param1:Object) : void
      {
         var obj:Object = param1;
         var delay:Boolean = this.events.length > 0;
         this.events.toArray().forEach(function(param1:EventHandler, param2:int, param3:Array):void
         {
            if(param1.type != null && param1.callBack != null)
            {
               ResponseDispatcher.getInstance().removeEventListener(param1.type,param1.callBack);
            }
         });
         this.events.removeAll();
         this.currentAction = "";
         if(delay)
         {
            Utils.callLater(300,dispatchEvent,[new CityStateCompleteEvent(obj)]);
         }
         else
         {
            dispatchEvent(new CityStateCompleteEvent(obj));
         }
      }
      
      private function cancelBuild(param1:int = -1000) : void
      {
         var _loc2_:BuildingBean = null;
         this.currentAction = "cancelbuild";
         if(param1 == -1000)
         {
            _loc2_ = this.cityManager._getCurrentConstruction();
            if(_loc2_ == null)
            {
               this.onCmdFinshed(new ScriptError("No current building",-9999));
               return;
            }
            param1 = _loc2_.positionId;
         }
         this.setCmdResponse(ResponseDispatcher.CASTLE_CANCLE_BUILD_COMMAND,this.handleCmdResponse);
         ActionFactory.getInstance().getCastleCommands().cancleBuildCommand(this.castleId,param1);
      }
      
      private function deploy(param1:Object, param2:int, param3:String, param4:TroopBean, param5:ResourceBean = null, param6:String = "", param7:Boolean = false, param8:Boolean = false, param9:int = 0) : void
      {
         var _loc11_:int = 0;
         this.currentAction = "deploy";
         var _loc10_:int = int(param1);
         if(_loc10_ == 0)
         {
            _loc11_ = int(new Array("at","bu","re","sc","tr","co","an","su","up","de").indexOf(param1.toString().toLowerCase().substr(0,2)));
            if(_loc11_ == -1)
            {
               this.logCmdResponse("Invalid deploy value, must be among: attack, build, reinforce, scout, transport, colonize, anticolonize, suppress, uprise, or deploytroop");
               this.onCmdFinshed(true);
               return;
            }
            _loc10_ = int(new Array(ObjConstants.ARMY_MISSION_OCCUPY,ObjConstants.ARMY_MISSION_CONSTRUCT,ObjConstants.ARMY_MISSION_SEND,ObjConstants.ARMY_MISSION_SCOUT,ObjConstants.ARMY_MISSION_TRANS,ObjConstants.ARMY_MISSION_COLONIZE,ObjConstants.ARMY_MISSION_ANTI_COLONIAL,ObjConstants.ARMY_MISSION_SUPPRESS,ObjConstants.ARMY_MISSION_UPRISE,ObjConstants.ARMY_MISSION_DEPLOY_TROOPS)[_loc11_]);
         }
         this.doMarch(_loc10_,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      private function travelInfo(param1:int, param2:TroopBean, param3:String = "") : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         this.currentAction = "travelinfo";
         if(param2 == null)
         {
            this.logCmdResponse("Invalid troop (cannot be none)");
            this.onCmdFinshed(true);
            return;
         }
         var _loc4_:Number = this.cityManager.getBaseTravelTime(this.castle.fieldId,param1,param2);
         var _loc5_:HeroBean = this.findHeroByName(param3);
         if(param3.length > 0 && _loc5_ == null)
         {
            this.logCmdResponse("Invalid hero: " + param3);
         }
         else if(this.castle.fieldId == param1)
         {
            this.logCmdResponse("destination " + Map.fieldIdToCoordString(param1) + " is the current castle");
         }
         else if(_loc4_ <= 0)
         {
            this.logCmdResponse("no troop or research information is not yet available, please try again");
         }
         else
         {
            if(_loc5_ != null)
            {
               _loc4_ /= Utils.getHeroSpeedFactor(_loc5_);
            }
            _loc6_ = _loc4_ / this._getReliefStationSpeedupFactor();
            _loc7_ = _loc5_ != null ? ", with hero " + param3 + ":" + _loc5_.speed : "";
            _loc8_ = int(Map.fieldDistance(this.castle.fieldId,param1) * 100) / 100;
            this.onCmdResult("Distance to " + Map.fieldIdToCoordString(param1) + ": " + _loc8_ + _loc7_ + ", attack time: " + Utils.formatTime(_loc4_) + ", reinforce self/alliance time: " + Utils.formatTime(_loc6_) + ", carrying load: " + this.cityManager.getMaxTroopLoad(param2) + ", food needed to attack: " + int(this.cityManager.getTroopFoodValue(param2) * _loc4_ / 3600 * 2) + ", to reinforce: " + int(this.cityManager.getTroopFoodValue(param2) * _loc6_ / 3600 * 2));
         }
         this.onCmdFinshed(true);
      }
      
      private function useBuildItem(param1:String, param2:int = -1000) : void
      {
         var _loc4_:BuildingBean = null;
         this.currentAction = "usebuilditem";
         if(param2 == -1000)
         {
            _loc4_ = this.cityManager._getCurrentConstruction();
            if(_loc4_ == null)
            {
               this.onCmdFinshed(new ScriptError("No current building",-9999));
               return;
            }
            param2 = _loc4_.positionId;
         }
         var _loc3_:String = Items.getItemId(param1);
         if(_loc3_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.CASTLE_SPEED_UP_BUILD_COMMAND,this.handleCmdResponse);
         ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(this.castleId,param2,_loc3_);
      }
      
      private function vote(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null) : void
      {
         this.currentAction = "vote";
         param1 = param1 + (param2 != null ? " " + param2 : "") + (param3 != null ? " " + param3 : "") + (param4 != null ? " " + param4 : "") + (param5 != null ? " " + param5 : "");
         this.onCmdResult("Vote for player " + param1);
         this.setCmdResponse(ResponseDispatcher.VOTE_VOTE_TO_PLAYER_BY_NAME,this.handleCmdResponse);
         CityStateCommands.voteForPlayerByName(param1);
      }
      
      private function isRallySlotAvailable() : Boolean
      {
         return this.cityManager.localArmies.length < this.cityManager.getMaxRallySlots();
      }
      
      private function warReportIgnoreList(param1:String) : void
      {
         this.currentAction = "";
         this.printGoalCommandWarning();
         if(!this.cityManager._setWrIgnoreList(param1))
         {
            this.onCmdFinshed(new ScriptError("Parameter error for command warreportignorelist",-9999));
         }
         else
         {
            this.onCmdFinshed(true);
         }
         this.onCmdFinshed(true);
      }
      
      private function useAngelItem(param1:String, param2:String) : void
      {
         this.currentAction = "useangelitem";
         var _loc3_:String = Items.getItemId(param2);
         if(_loc3_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.SHOP_USE_ANGEL_ITEM,this.handleCmdResponse);
         ActionFactory.getInstance().getShopCommands().useAngelItem(param1,_loc3_);
      }
      
      private function clearTroopQueues(param1:int = 1) : void
      {
         this.currentAction = "cleartroopqueues";
         this.cityManager._clearTroopQueues(param1);
         this.onCmdFinshed(true);
      }
      
      public function isHeroInCastle(param1:String) : Boolean
      {
         return this.findHeroByName(param1) != null;
      }
      
      private function npcTroop(param1:TroopBean) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "npctroops";
         this.cityManager._setNpcTroopCond(Utils.troopBeanToMsgString(param1));
         this.onCmdFinshed(true);
      }
      
      private function quickScanMap(param1:String = "all", param2:int = 3) : void
      {
         var abbr:String;
         var x:int = 0;
         var y:int = 0;
         var endX:int = 0;
         var endY:int = 0;
         var waitCount:int = 0;
         var threshold:int = 0;
         var zonesCorners:Array = null;
         var zInd:int = 0;
         var SIZE:int = 0;
         var reqBuffer:Array = null;
         var getMapInfo:Function = null;
         var handler:Function = null;
         var zone:String = param1;
         var speedFactor:int = param2;
         this.currentAction = "quickscan";
         this.pleaseStop = false;
         speedFactor = speedFactor > 9 ? 9 : (speedFactor < 0 ? 0 : speedFactor);
         x = 0;
         y = 0;
         endX = 799;
         endY = 799;
         waitCount = 0;
         threshold = int([2,4,8,16,24,32,40,48,56,64][speedFactor]);
         zonesCorners = [{
            "x":0,
            "y":0
         },{
            "x":200,
            "y":0
         },{
            "x":400,
            "y":0
         },{
            "x":600,
            "y":0
         },{
            "x":0,
            "y":200
         },{
            "x":200,
            "y":200
         },{
            "x":400,
            "y":200
         },{
            "x":600,
            "y":200
         },{
            "x":0,
            "y":400
         },{
            "x":200,
            "y":400
         },{
            "x":400,
            "y":400
         },{
            "x":600,
            "y":400
         },{
            "x":0,
            "y":600
         },{
            "x":200,
            "y":600
         },{
            "x":400,
            "y":600
         },{
            "x":600,
            "y":600
         }];
         abbr = zone.substr(0,3).toLowerCase();
         zInd = int(["fri","sax","nm","boh","ll","fra","thu","mor","ul","swa","bav","car","bur","lom","tus","rom"].indexOf(abbr));
         if(zInd == -1)
         {
            zInd = int(["fri","sax","nor","boh","low","fra","thu","mor","upp","swa","bav","car","bur","lom","tus","rom"].indexOf(abbr));
         }
         if(zInd == -1)
         {
            if(zone.toLowerCase() != "all")
            {
               this.onCmdFinshed(new ScriptError("Invalid state: " + zone + ", consider using the first 3 letters of the desired state instead, or use \"all\" or leave blank for the entire map",-9999));
               return;
            }
         }
         else
         {
            x = int(zonesCorners[zInd].x);
            y = int(zonesCorners[zInd].y);
            endX = x + 199;
            endY = y + 199;
         }
         this.onCmdResult("Start deleting old map data...");
         if(zone.toLowerCase() == "all")
         {
            Map.fullResetMap();
         }
         else
         {
            Map.resetRectangle(x,y,endX,endY);
         }
         SIZE = 50;
         reqBuffer = new Array();
         getMapInfo = function():void
         {
            var _loc1_:int = 0;
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            if(pleaseStop)
            {
               ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE,handler);
               onCmdResult("QUICK SCAN was cancelled before it could finish");
               onCmdFinshed(true);
               return;
            }
            if(y < endY || x < endX)
            {
               if(reqBuffer.length < threshold)
               {
                  while(y < endY)
                  {
                     if(x >= endX)
                     {
                        x = zInd == -1 ? 0 : int(zonesCorners[zInd].x);
                     }
                     while(x < endX)
                     {
                        ActionFactory.getInstance().getCommonCommands().mapInfoSimple(castleId,x,y,x + SIZE - 1,y + SIZE - 1);
                        reqBuffer.push(Map.getFieldId(x,y) + ":" + Map.getFieldId(x + SIZE - 1,y + SIZE - 1));
                        waitCount = -1;
                        x += SIZE;
                        if(reqBuffer.length >= threshold)
                        {
                           break;
                        }
                     }
                     if(x >= endX)
                     {
                        y += SIZE;
                     }
                     if(reqBuffer.length >= threshold)
                     {
                        break;
                     }
                  }
               }
            }
            else if(reqBuffer.length == 0)
            {
               ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE,handler);
               onCmdResult("QUICK SCAN COMPLETED SUCCESSFULLY");
               onCmdFinshed(true);
               return;
            }
            if(reqBuffer.length > 0)
            {
               ++waitCount;
            }
            if(waitCount >= (speedFactor < 4 ? 6 : (speedFactor < 7 ? 4 : 3)))
            {
               waitCount = 0;
               _loc3_ = 0;
               while(_loc3_ < reqBuffer.length)
               {
                  _loc1_ = Map.getX(int(reqBuffer[_loc3_].split(":")[0]));
                  _loc2_ = Map.getY(int(reqBuffer[_loc3_].split(":")[0]));
                  ActionFactory.getInstance().getCommonCommands().mapInfoSimple(castleId,_loc1_,_loc2_,_loc1_ + SIZE - 1,_loc2_ + SIZE - 1);
                  if(_loc3_ >= threshold)
                  {
                     break;
                  }
                  _loc3_++;
               }
            }
            Utils.callLater(speedFactor < 4 ? 500 : (speedFactor < 7 ? 1000 : 1500),getMapInfo);
         };
         handler = function(param1:MapInfoSimpleResponse):void
         {
            var _loc2_:int = int(reqBuffer.indexOf(Map.getFieldId(param1.x1,param1.y1) + ":" + Map.getFieldId(param1.x2,param1.y2)));
            if(_loc2_ != -1)
            {
               if(waitCount > 0)
               {
                  --waitCount;
               }
               reqBuffer.splice(_loc2_,1);
            }
         };
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE,handler);
         this.onCmdResult("Start recording new map data...");
         getMapInfo.apply();
      }
      
      private function npc10Limit(param1:TroopBean) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "npc10limit";
         this.cityManager._dp32(Utils.troopBeanToMsgString(param1));
         this.onCmdFinshed(true);
      }
      
      public function get coord() : String
      {
         return Map.fieldIdToCoordinate(this.castle.fieldId);
      }
      
      private function useArmyItem(param1:int, param2:String) : void
      {
         var _loc5_:ArmyBean = null;
         var _loc6_:CityState = null;
         this.currentAction = "usearmyitem";
         var _loc3_:String = Items.getItemId(param2);
         if(_loc3_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         var _loc4_:ArmyBean = null;
         for each(_loc5_ in this.cityManager.selfArmies)
         {
            if(_loc5_.armyId == param1)
            {
               _loc4_ = _loc5_;
               break;
            }
         }
         if(_loc4_ == null)
         {
            for each(_loc6_ in MainScreen.getCities())
            {
               for each(_loc5_ in _loc6_.cityManager.friendlyArmies)
               {
                  if(_loc5_.armyId == param1)
                  {
                     _loc4_ = _loc5_;
                     break;
                  }
               }
               if(_loc4_ != null)
               {
                  break;
               }
            }
         }
         if(_loc4_ == null)
         {
            for each(_loc5_ in MainScreen.getInstance().getEnemyArmies())
            {
               if(_loc5_.armyId == param1)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
         }
         if(_loc4_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid armyId",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.SHOP_USE_TRICK_ITEM,this.handleCmdResponse);
         ActionFactory.getInstance().getShopCommands().useTrickItem(_loc4_.startFieldId,param1,_loc3_,this.handleCmdResponse);
      }
      
      private function spamAttack(param1:int, param2:TroopBean, param3:int) : void
      {
         this.currentAction = "spamattack";
         this.cityManager._cf1136(param1,param2,param3);
         this.onCmdFinshed(true);
      }
      
      public function get player() : PlayerBean
      {
         return MainScreen.getPlayer();
      }
      
      private function colony(param1:String, param2:int, param3:TroopBean = null) : void
      {
         var op:String;
         var handleColonyLevyResponse:Function;
         var cB:ColonyBean;
         var selectType:String = null;
         var levyType:String = null;
         var endStr:String = null;
         var operation:String = param1;
         var fieldId:int = param2;
         var tr:TroopBean = param3;
         this.currentAction = "colony";
         cB = this.cityManager.getColony(fieldId);
         if(cB == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid colony at " + Map.fieldIdToCoordString(fieldId),-9999));
            return;
         }
         handleColonyLevyResponse = function(param1:ColonyLevyeRespone):void
         {
            if(param1.ok != CommandResponse.OK_DEFAULT)
            {
               onCmdFinshed(new ScriptError("Error received: " + param1.errorMsg,-9999));
               return;
            }
            var _loc2_:String = "";
            if(selectType == "resource")
            {
               _loc2_ = param1.amount + " amount of " + levyType;
            }
            else if(selectType == "army")
            {
               _loc2_ = levyType + param1.amount + " " + param1.armyType + endStr;
            }
            onCmdResult("Colony levy response: " + _loc2_);
            onCmdFinshed(true);
         };
         op = operation.substr(0,2);
         switch(op)
         {
            case "ab":
               this.onCmdResult("Begin abandon colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               this.setCmdResponse(ResponseDispatcher.COLONY_ABANDON_COLONY,this.handleCmdResponse);
               ActionFactory.getInstance().getColonyCommands().abandonColony(this.castleId,cB.castleId);
               break;
            case "fo":
               this.onCmdResult("Levy food from colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "resource";
               levyType = "Food Levied!";
               ActionFactory.getInstance().getColonyCommands().levyFood(this.castleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "ta":
               this.onCmdResult("Tax gold from colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "resource";
               levyType = "Gold imposed!";
               ActionFactory.getInstance().getColonyCommands().levyTaxes(this.castleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "ar":
               this.onCmdResult("Draft army from colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "army";
               levyType = "You have drafted ";
               endStr = " from the city.";
               ActionFactory.getInstance().getColonyCommands().levyArmy(this.castleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "po":
               this.onCmdResult("Redeploy population from " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "resource";
               levyType = "Population redeployed!";
               ActionFactory.getInstance().getColonyCommands().levyPopulation(this.castleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "di":
               this.onCmdResult("Disarm " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "army";
               levyType = "You have disarmed ";
               endStr = " in the city.";
               ActionFactory.getInstance().getColonyCommands().reduceArmaments(this.castleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "ov":
               this.onCmdResult("Overview colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(this.castleId,cB.castleId,this.handleGetColonyOverviewResponse);
               break;
            case "so":
               this.onCmdResult("Sow discord on colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               this.setCmdResponse(ResponseDispatcher.COLONY_SOW_DISCORD,this.handleCmdResponse);
               ActionFactory.getInstance().getColonyCommands().sowDiscord(this.castleId,cB.castleId);
               break;
            case "in":
               this.onCmdResult("Army info for " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               ActionFactory.getInstance().getColonyCommands().getColonialArmyInfo(this.castleId,cB.castleId,this.handleGetColonyArmyInfoResponse);
               break;
            case "su":
               if(tr != null)
               {
                  this.onCmdResult("Set suppression troop setting for " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName + " to " + Utils.troopBeanToMsgString(tr,false));
                  ActionFactory.getInstance().getColonyCommands().setDeployTroops(this.castleId,cB.castleId,tr,this.handleCmdResponse);
               }
               else
               {
                  this.onCmdResult("Get suppression troop setting for " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
                  ActionFactory.getInstance().getColonyCommands().getDeployTroopsInfo(this.castleId,cB.castleId,this.handleGetSupSettingResponse);
               }
               break;
            default:
               this.onCmdFinshed(new ScriptError("Invalid operation " + operation + ", must be either abandon, food, tax, army, population, disarm, overview, sowdiscord, info, suppress",-9999));
               return;
         }
      }
      
      private function create(param1:String, param2:String = "FirstAvailable", param3:Boolean = false) : void
      {
         if(param3)
         {
            this.create2(param1,param2,param3);
            return;
         }
         if(Version.isTraceOn())
         {
            trace("create - verify buildings");
         }
         if(this.cityManager.isBuildingQueueAvailable())
         {
            this.create2(param1,param2);
            return;
         }
         this.onCmdResult("Waiting for current building to complete...");
         this.waitForBuildingQueue(this.create2,[param1,param2,param3]);
      }
      
      private function useTradeItem(param1:String, param2:int = -1) : void
      {
         this.currentAction = "usetradeitem";
         var _loc3_:ArrayCollection = this.cityManager.getTransingTrades();
         if(_loc3_.length == 0)
         {
            this.onCmdFinshed(new ScriptError("No trades in transist.",-9999));
            return;
         }
         if(param2 == -1)
         {
            param2 = int(_loc3_[0].id);
         }
         var _loc4_:String = Items.getItemId(param1);
         if(_loc4_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item name.",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.TRADE_SPEED_UP_TRANS,this.handleCmdResponse);
         ActionFactory.getInstance().getTradeCommands().speedUpTrans(this.castleId,param2,_loc4_,this.handleCmdResponse);
      }
      
      private function getHeroNamesFromMacroNames(param1:String) : String
      {
         param1 = param1.toLowerCase();
         if(param1.substr(0,1) != "#")
         {
            return param1;
         }
         if(new Array("#absbest","#atk","#satk","#atk90","#satk90","#spm","#spam","#absworst","#worst","#best","#bestenergy","#pol","#pol2","#int","#int2","#hh","#lh","#royal").indexOf(param1) != -1)
         {
            return this.cityManager._getHeroNameFromMacroName(param1);
         }
         throw new ScriptError("Accepted #code: #absbest, #atk, #satk, #atk90, #satk90, #spm, #spam, #absworst, #worst, #best, #bestenergy, #pol, #pol2, #int, #int2, #hh, #lh, #royal",-9999);
      }
      
      private function waitHeroLost(param1:String) : void
      {
         var heroArr:Array = null;
         var handler:Function = null;
         var timer:Timer = null;
         var heroList:String = param1;
         this.currentAction = "waitherolost";
         this.pleaseStop = false;
         heroArr = heroList.split(",");
         this.onCmdResult("Waiting for a hero in (" + heroList + ") to be lost...");
         handler = function(param1:TimerEvent):void
         {
            var _loc2_:HeroBean = null;
            var _loc3_:String = null;
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdFinshed(true);
               return;
            }
            timer.delay = 2 * 1000;
            _loc2_ = null;
            for each(_loc3_ in heroArr)
            {
               if(_loc3_ != "")
               {
                  _loc2_ = findHeroByName(_loc3_);
                  if(_loc2_ == null)
                  {
                     timer.stop();
                     timer.removeEventListener(TimerEvent.TIMER,handler);
                     timer = null;
                     onCmdResult("Hero " + _loc2_ + " is not found");
                     onCmdFinshed(true);
                  }
               }
            }
         };
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function actKillWall() : void
      {
         var _loc3_:int = 0;
         this.currentAction = "killwall";
         if(this.cityManager.fortification == null)
         {
            this.onCmdResult("No Walls to Destroyed");
            return;
         }
         this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT,this.handleCmdResponse);
         var _loc1_:int = 0;
         var _loc2_:Array = [TFConstants.F_TRAP,TFConstants.F_ABATIS,TFConstants.F_ARROWTOWER,TFConstants.F_ROLLINGLOGS,TFConstants.F_ROCKFALL];
         for each(_loc3_ in _loc2_)
         {
            _loc1_ = int(this.cityManager.fortification[Utils.troopIntNames[_loc3_]]);
            this.onCmdResult("Destroying " + _loc1_ + " of fortification: " + Utils.troopIntNames[_loc3_]);
            CityStateCommands.destructWallProtect(this.castleId,_loc3_,_loc1_);
         }
         this.clearWallQueue(0);
      }
      
      private function advTeleport(param1:int) : void
      {
         this.currentAction = "advteleport";
         this.cityManager._recallIncomingArmies();
         this.setCmdResponse(ResponseDispatcher.CITY_ADV_MOVE_CASTLE,this.handleCmdResponse);
         ActionFactory.getInstance().getCityCommands().advMoveCastle(this.castleId,param1);
         this.cityManager._resetLocalFieldsInfo();
      }
      
      private function getItemCount(param1:String) : int
      {
         var _loc2_:ItemBean = null;
         for each(_loc2_ in this.player.itemsArray)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_.count;
            }
         }
         return 0;
      }
      
      public function get math() : Object
      {
         return getDefinitionByName("Math");
      }
      
      private function changeHeroGearsHandler(param1:CommandResponse = null) : void
      {
         var techAbbs:Array = null;
         var func:Function = null;
         var completed:Function = null;
         var r:CommandResponse = param1;
         if(r != null && r.ok != CommandResponse.OK_DEFAULT)
         {
            this.changeHeroGearsParams = null;
            this.onCmdFinshed(new ScriptError("An error occurred while processing change gears command: " + r.errorMsg,-9999));
            return;
         }
         techAbbs = new Array("he","che","we","shi","le","cha1","ri1","mo","ne","sho","ba","ga","be","cha2","ri2","fo");
         if(this.changeHeroGearsParams.i < this.changeHeroGearsParams.setGears.length)
         {
            func = function():void
            {
               var _loc1_:Array = null;
               var _loc2_:Array = null;
               var _loc3_:int = 0;
               _loc1_ = new Array(EquipmentTech.EQUIPMENT_SLOT_HEAD,EquipmentTech.EQUIPMENT_SLOT_CHEST,EquipmentTech.EQUIPMENT_SLOT_WEAPON_L,EquipmentTech.EQUIPMENT_SLOT_SHIELD_L,EquipmentTech.EQUIPMENT_SLOT_LEG_L,EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L,EquipmentTech.EQUIPMENT_SLOT_RING_L,EquipmentTech.EQUIPMENT_SLOT_MOUNT_L,EquipmentTech.EQUIPMENT_SLOT_NECKLACE,EquipmentTech.EQUIPMENT_SLOT_SHOULDERS,EquipmentTech.EQUIPMENT_SLOT_BACK,EquipmentTech.EQUIPMENT_SLOT_WRIST,EquipmentTech.EQUIPMENT_SLOT_WAIST,EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R,EquipmentTech.EQUIPMENT_SLOT_RING_R,EquipmentTech.EQUIPMENT_SLOT_FEET);
               _loc2_ = changeHeroGearsParams.setGears[changeHeroGearsParams.i].split(":");
               _loc3_ = int(techAbbs.indexOf(_loc2_[0].toLowerCase()));
               if(int(_loc2_[1]) < 1)
               {
                  ActionFactory.getInstance().getEquipmentCommands().TakeOffEquipmenttech(changeHeroGearsParams.heroId,"0",_loc1_[_loc3_]);
               }
               else
               {
                  ActionFactory.getInstance().getEquipmentCommands().WearEquipmenttech(changeHeroGearsParams.heroId,"0",_loc1_[_loc3_] == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L ? 1 : int(_loc2_[1]),_loc1_[_loc3_],changeHeroGearsHandler);
               }
               ++changeHeroGearsParams.i;
            };
            Utils.callLater(200,func);
         }
         else
         {
            completed = function():void
            {
               var _loc1_:String = null;
               var _loc2_:HeroBean = null;
               var _loc3_:EquipmentBean = null;
               var _loc4_:String = null;
               var _loc5_:int = 0;
               _loc1_ = changeHeroGearsParams.heroName;
               _loc2_ = findHeroByName(_loc1_);
               _loc3_ = null;
               _loc4_ = "";
               _loc5_ = 0;
               while(_loc5_ < _loc2_.equipmentbeanArray.length)
               {
                  _loc3_ = _loc2_.equipmentbeanArray[_loc5_] as EquipmentBean;
                  _loc4_ += (_loc4_ != "" ? "," : "") + "<b>" + techAbbs[_loc3_.heroPos - 1] + "</b>:" + getGearTypeString(_loc3_.addAttributeType);
                  _loc5_++;
               }
               cityManager.logMsg("Gear for hero " + _loc1_ + " has been set to " + _loc4_);
               onCmdFinshed(true);
               changeHeroGearsParams = null;
            };
            Utils.callLater(200,completed);
         }
      }
      
      private function endEvacuate() : void
      {
         this.currentAction = "endevacuate";
         this.cityManager._nd1071();
         this.onCmdFinshed(true);
      }
      
      public function getRandomNum(param1:int, param2:int) : int
      {
         return Utils.getRandomInt(param1,param2);
      }
      
      private function tradeTo(param1:String, param2:String, param3:Number, param4:Number, param5:Number = 0) : void
      {
         var _loc8_:Array = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(this.cityManager.getBuildingLevel(BuildingConstants.TYPE_MARKET) == 0)
         {
            this.logCmdResponse("Cannot process the transaction because this city has no Market.");
            this.onCmdFinshed(true);
            return;
         }
         param2 = param2.toLowerCase();
         if(param2 == "wood")
         {
            param2 = "lumber";
         }
         var _loc6_:Array = new Array("food","lumber","stone","iron");
         var _loc7_:int = int(_loc6_.indexOf(param2));
         param1 = param1.toLowerCase();
         if(param1 != "buy" && param1 != "sell")
         {
            this.logCmdResponse("trade type " + param1 + " must be buy or sell");
         }
         else if(_loc7_ == -1)
         {
            this.logCmdResponse("Invalid resource, must be among " + _loc6_.join(" "));
         }
         else if(param4 < 0)
         {
            this.logCmdResponse("Invalid price, must be a positive number");
         }
         else if(isNaN(param3) || param3 <= 0)
         {
            this.logCmdResponse("Invalid limit amount: " + param3);
         }
         else if(param3 < param4)
         {
            this.logCmdResponse("The limit amount " + param3 + " is too small");
         }
         else
         {
            _loc8_ = new Array(this.castle.resource.food.amount,this.castle.resource.wood.amount,this.castle.resource.stone.amount,this.castle.resource.iron.amount);
            _loc9_ = param1 == "buy" ? Math.floor(this.cityManager._ok1059()[_loc7_]) : Math.floor(_loc8_[_loc7_]);
            _loc10_ = this.cityManager._getResoGold();
            if(param4 >= 10)
            {
               param4 = int(param4 * 100) / 100;
            }
            else
            {
               param4 = int(param4 * 1000) / 1000;
            }
            this.onCmdResult("Current resource: " + _loc9_);
            _loc11_ = 0;
            if(param1 == "buy")
            {
               _loc11_ = param3 - _loc9_;
               if(_loc11_ > (_loc10_ - param5) / param4 / 1.005)
               {
                  _loc11_ = (_loc10_ - param5) / param4 / 1.005;
               }
            }
            else
            {
               _loc11_ = _loc9_ - param3;
               if(_loc11_ > _loc10_ / param4 / 0.005)
               {
                  _loc11_ = _loc10_ / param4 / 0.005;
               }
               if(_loc10_ < param5 && _loc11_ < (param5 - _loc10_) / param4 && _loc9_ > (param5 - _loc10_) / param4)
               {
                  _loc11_ = (param5 - _loc10_) / param4;
               }
            }
            if(_loc11_ > TRADELIMIT)
            {
               _loc11_ = TRADELIMIT;
            }
            else if(_loc11_ > 1000)
            {
               _loc11_ = Math.floor(_loc11_ / 1000) * 1000;
            }
            else if(_loc11_ > 0)
            {
               _loc11_ = Math.floor(_loc11_);
            }
            if(_loc11_ <= 0)
            {
               this.logCmdResponse("No trade needed");
            }
            else
            {
               if(param1 == "buy")
               {
                  this.onCmdResult("Buy " + _loc6_[_loc7_] + ": " + _loc11_ + " at price " + param4 + " toward limit " + param3);
                  CityStateCommands.newTrade(this.castleId,_loc7_,TradeConstants.TRADE_TYPE_BUY,_loc11_,"" + param4);
                  Utils.callLater(1500,this.onCmdFinshed,[true]);
                  return;
               }
               if(param1 == "sell")
               {
                  this.onCmdResult("Sell " + _loc6_[_loc7_] + ": " + _loc11_ + " at price " + param4 + " toward limit " + param3);
                  CityStateCommands.newTrade(this.castleId,_loc7_,TradeConstants.TRADE_TYPE_SELL,_loc11_,"" + param4);
                  Utils.callLater(1500,this.onCmdFinshed,[true]);
                  return;
               }
            }
         }
         this.onCmdFinshed(true);
      }
      
      private function cancelTrade(param1:int = -1) : void
      {
         this.currentAction = "canceltrade";
         if(param1 != -1)
         {
            this.setCmdResponse(ResponseDispatcher.TRADE_CANCEL_TRADE,this.handleCmdResponse);
            ActionFactory.getInstance().getTradeCommands().cancelTrade(this.castleId,param1);
         }
         else
         {
            this.cityManager._hd522();
            Utils.callLater(1500,this.onCmdFinshed,[true]);
         }
      }
      
      public function getIdleHeroes(param1:int = 0) : ArrayCollection
      {
         var _loc3_:HeroBean = null;
         var _loc2_:ArrayCollection = new ArrayCollection();
         for each(_loc3_ in this.cityManager.heroes)
         {
            if(_loc3_.status == HeroConstants.HERO_FREE_STATU && _loc3_.stamina >= param1)
            {
               _loc2_.addItem(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function listPackagesResponse(param1:GetPackageListResponse) : void
      {
         var _loc8_:Date = null;
         var _loc10_:PackageBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         var _loc2_:* = "";
         var _loc3_:* = "";
         var _loc4_:* = "";
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:String = "";
         for each(_loc10_ in param1.packagesArray)
         {
            _loc8_ = new Date(_loc10_.provideTime);
            _loc9_ = _loc8_.fullYear + "-" + (_loc8_.month + 1 < 10 ? "0" + (_loc8_.month + 1) : _loc8_.month + 1) + "-" + (_loc8_.date < 10 ? "0" + _loc8_.date : _loc8_.date) + " " + (_loc8_.hours < 10 ? "0" + _loc8_.hours : _loc8_.hours) + ":" + (_loc8_.minutes < 10 ? "0" + _loc8_.minutes : _loc8_.minutes) + ":" + (_loc8_.seconds < 10 ? "0" + _loc8_.seconds : _loc8_.seconds);
            if(_loc10_.status == ObjConstants.PACKAGE_STATUS_AVAIBLE)
            {
               if(_loc2_ != "")
               {
                  _loc2_ += ", ";
               }
               _loc2_ += "<b>id:</b>" + _loc10_.id + " <b>name:</b>" + _loc10_.packageName + " <b>arrived:</b>" + _loc9_;
               _loc5_++;
            }
            else if(_loc10_.status == ObjConstants.PACKAGE_STATUS_HAD_GOT)
            {
               if(_loc3_ != "")
               {
                  _loc3_ += ", ";
               }
               _loc3_ += "<b>id:</b>" + _loc10_.id + " <b>name:</b>" + _loc10_.packageName + " <b>arrived:</b>" + _loc9_ + " <b>claimed:</b>" + _loc10_.claimedTime;
               _loc6_++;
            }
            else
            {
               if(_loc4_ != "")
               {
                  _loc4_ += ", ";
               }
               _loc4_ += "<b>id:</b>" + _loc10_.id + " <b>name:</b>" + _loc10_.packageName + " <b>arrived:</b>" + _loc9_;
               _loc7_++;
            }
         }
         this.cityManager.logMsg("List of Gift Packages:\n<u>" + _loc5_ + " Available Unclaimed Gifts:</u>  " + _loc2_ + "\n<u>" + _loc6_ + " Already Claimed Gifts:</u>  " + _loc3_ + "\n<u>" + _loc7_ + " Other Unclaimed Gifts:</u>  " + _loc4_);
         this.onCmdFinshed(true);
      }
      
      private function _ip715(param1:AvailableResearchListBean, param2:AvailableResearchListResponse) : Boolean
      {
         var _loc6_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         if(param1.conditionBean == null)
         {
            return false;
         }
         var _loc3_:Boolean = true;
         _loc3_ = param1.conditionBean.food < this.castle.resource.food.amount && _loc3_;
         _loc3_ = param1.conditionBean.gold < this.castle.resource.gold && _loc3_;
         _loc3_ = param1.conditionBean.iron < this.castle.resource.iron.amount && _loc3_;
         _loc3_ = param1.conditionBean.stone < this.castle.resource.stone.amount && _loc3_;
         _loc3_ = param1.conditionBean.wood < this.castle.resource.wood.amount && _loc3_;
         if(!_loc3_)
         {
            return false;
         }
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = true;
         for each(_loc6_ in param1.conditionBean.buildingsArray)
         {
            _loc4_ = false;
            for each(_loc10_ in this.castle.buildingsArray)
            {
               if(_loc10_.typeId == _loc6_.typeId)
               {
                  if(_loc10_.level >= _loc6_.level)
                  {
                     _loc4_ = true;
                     break;
                  }
               }
            }
            _loc5_ = _loc4_ && _loc5_;
         }
         if(!_loc5_)
         {
            return false;
         }
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = true;
         for each(_loc9_ in param1.conditionBean.techsArray)
         {
            _loc7_ = false;
            for each(_loc11_ in param2.acailableResearchBeansArray)
            {
               if(_loc11_.typeId == _loc9_.id)
               {
                  if(_loc11_.level >= _loc9_.level)
                  {
                     _loc7_ = true;
                     break;
                  }
               }
            }
            _loc8_ = _loc7_ && _loc8_;
         }
         if(!_loc8_)
         {
            return false;
         }
         return true;
      }
      
      private function aColonize(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "acolonize";
         this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE,param1,param2,param3,null,param4,false,false,2,null);
      }
      
      private function npc10Heroes(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "npc10heroes";
         this.cityManager._cfg_npc10Heroes(param1);
         this.onCmdFinshed(true);
      }
      
      private function recall(param1:int) : void
      {
         this.currentAction = "recall";
         this.cityManager._recallLocalArmiesToTarget(param1);
         this.onCmdFinshed(true);
      }
      
      private function listLocalBuffs() : void
      {
         this.currentAction = "listlocalbuffs";
         this.cityManager._printLocalBuffs();
         this.onCmdFinshed(true);
      }
      
      private function buildCity(param1:int) : void
      {
         this.currentAction = "buildcity";
         this.cityManager._setBuildNewCityLoc(param1);
         this.onCmdFinshed(true);
      }
      
      private function aScout(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "ascout";
         this.doMarch(ObjConstants.ARMY_MISSION_SCOUT,param1,param2,param3,null,param4,false,false,2,null);
      }
      
      private function skypeWarningReceivers(param1:String) : void
      {
         this.currentAction = "";
         this.printGoalCommandWarning();
         if(!this.cityManager._setSkypeWarnReceivers(param1))
         {
            this.onCmdFinshed(new ScriptError("Parameter error for command skypewarningreceivers",-9999));
         }
         else
         {
            this.onCmdFinshed(true);
         }
         this.onCmdFinshed(true);
      }
      
      private function friendPlayer(param1:String) : void
      {
         var _loc2_:PlayerInfoBean = null;
         var _loc3_:PlayerInfoBean = null;
         this.currentAction = "friend player";
         for each(_loc2_ in this.player.blockBeansArray)
         {
            if(_loc2_.userName.toLowerCase() == param1.toLowerCase())
            {
               this.onCmdFinshed(new ScriptError("Player \"" + _loc2_.userName + "\" is in your Block Players List. Run \"unblockplayer " + _loc2_.userName + "\" before trying to add the player to friends list.",-9999));
               return;
            }
         }
         for each(_loc3_ in this.player.friendBeansArray)
         {
            if(_loc3_.userName.toLowerCase() == param1.toLowerCase())
            {
               this.cityManager.logMsg("Player <font color=\'#CC0000\'>\"" + _loc3_.userName + "\"</font> is already in your Friends List. No action taken.");
               this.onCmdFinshed(true);
               return;
            }
         }
         this.friendBlockPlayerName = param1;
         ActionFactory.getInstance().getFriendCommands().addFriend(param1,this.friendPlayerResponseHandler);
      }
      
      public function _doQuickMarch(param1:int, param2:int, param3:String, param4:TroopBean, param5:ResourceBean = null, param6:String = "", param7:Boolean = false, param8:Boolean = false, param9:int = 0, param10:Function = null) : String
      {
         var minStamina:int;
         var rsSpeedUp:int;
         var restTimeNumeric:Number;
         var travelTime:int;
         var buffsCampFactor:Number;
         var newArmy:NewArmyParam;
         var heroSpeedUp:Number;
         var selectedHero:HeroBean;
         var baseTravelTime:Number;
         var marchType:int = param1;
         var targetId:int = param2;
         var hero:String = param3;
         var troopObj:TroopBean = param4;
         var resources:ResourceBean = param5;
         var restTime:String = param6;
         var warEnsign:Boolean = param7;
         var stygandrsBannerOfTheHorde:Boolean = param8;
         var argGearing:int = param9;
         var callback:Function = param10;
         if(targetId == this.castle.fieldId)
         {
            return "Invalid target. Target is the current castle";
         }
         if(targetId == -1)
         {
            return "Error: Invalid target coordinates.  Specify coords as \'x,y\'";
         }
         if(!this.isRallySlotAvailable())
         {
            return "Error: No rally space available";
         }
         minStamina = marchType != ObjConstants.ARMY_MISSION_SEND ? (marchType != ObjConstants.ARMY_MISSION_TRANS ? 4 : 2) : 1;
         selectedHero = null;
         try
         {
            if(hero != "" && hero.toLowerCase() != "none")
            {
               selectedHero = this.getHeroByNameOrKey(hero,minStamina);
               if(selectedHero == null)
               {
                  return "Error: No idle hero available";
               }
            }
         }
         catch(error:Error)
         {
            return "Error: Invalid hero specified " + hero;
         }
         if(marchType != ObjConstants.ARMY_MISSION_SEND && marchType != ObjConstants.ARMY_MISSION_TRANS && marchType != ObjConstants.ARMY_MISSION_SCOUT && marchType != ObjConstants.ARMY_MISSION_CONSTRUCT && selectedHero == null)
         {
            return "Error: a hero is required for this mission";
         }
         if(!this.cityHasEnoughTroops(troopObj))
         {
            return "Error: Not enough troop";
         }
         newArmy = new NewArmyParam();
         newArmy.missionType = marchType;
         newArmy.targetPoint = targetId;
         newArmy.troops = troopObj;
         newArmy.useFlag = warEnsign;
         newArmy.useItem = stygandrsBannerOfTheHorde;
         newArmy.resource = resources != null ? resources : new ResourceBean();
         if(selectedHero != null)
         {
            newArmy.heroId = selectedHero.id;
            if(argGearing > 0 && argGearing < 4)
            {
               ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(selectedHero.id,argGearing);
               this.onCmdResult(" Changing gear to " + (argGearing == 1 ? "Pol" : (argGearing == 2 ? "Atk" : "Int")) + " for " + selectedHero.name);
            }
         }
         baseTravelTime = this.cityManager.getBaseTravelTime(this.castle.fieldId,targetId,troopObj);
         rsSpeedUp = (MainScreen.getCityFromFieldId(targetId) != null || Map.getType(targetId) == FieldConstants.TYPE_CASTLE && Map.getDetailInfo(targetId,30).allianceName != null && this.player.playerInfo.alliance != null && Map.getDetailInfo(targetId,30).allianceName == this.player.playerInfo.alliance) && (marchType == ObjConstants.ARMY_MISSION_SEND || marchType == ObjConstants.ARMY_MISSION_TRANS) ? this._getReliefStationSpeedupFactor() : 1;
         heroSpeedUp = selectedHero != null ? Utils.getHeroSpeedFactor(selectedHero) : 1;
         travelTime = baseTravelTime / rsSpeedUp / heroSpeedUp;
         buffsCampFactor = 1;
         restTimeNumeric = 0;
         if(restTime != "")
         {
            buffsCampFactor = this.cityManager.getCampTimeChangeBuffsFactor();
            if(travelTime == 0 && buffsCampFactor == 1)
            {
               return "ERROR: No troop or town has yet to be initialized (travel time or research not available yet";
            }
            if((restTimeNumeric = this._parseRestTime(restTime,travelTime)) > 0)
            {
               if(int(int(restTimeNumeric) * buffsCampFactor) > 24 * 60 * 60)
               {
                  return "Error: Camp time exceeds server limit at " + Utils.formatTime(int(restTimeNumeric) * buffsCampFactor) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]";
               }
               if(restTimeNumeric > 20 * 3600)
               {
                  return "Error: Large camp time " + Utils.formatTime(restTimeNumeric) + " is more than 20 hours";
               }
            }
            if(restTimeNumeric < 0)
            {
               return "Error: Bad camp time " + restTime + ", resulting in negative camp time: " + restTimeNumeric + ", make sure you run \'calibrate\' recently!";
            }
         }
         if(int(int(restTimeNumeric) * buffsCampFactor) > 24 * 60 * 60)
         {
            return "Camp time exceeds server limit at " + Utils.formatTime(int(restTimeNumeric) * buffsCampFactor) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]";
         }
         newArmy.restTime = int(restTimeNumeric);
         if(restTime != "")
         {
            Utils.callLater((restTimeNumeric - newArmy.restTime) * 1000,CityStateCommands.newArmy,[this.castleId,newArmy,callback]);
         }
         else
         {
            CityStateCommands.newArmy(this.castleId,newArmy,callback);
         }
         return "- Marching to " + Map.fieldIdToCoordString(targetId) + " arrival at " + Utils.getLogTimeStr(Utils.getServerTime() + campTimeDelta + (travelTime + restTimeNumeric) * 1000) + (selectedHero == null ? "" : " using " + selectedHero.name) + " with " + Utils.troopBeanToMsgString(troopObj) + " carrying " + Utils.resourceBeanToString(resources) + " in " + Utils.formatTime(travelTime + newArmy.restTime);
      }
      
      private function useCastleItem(param1:String) : void
      {
         this.currentAction = "usecastleitem";
         var _loc2_:String = Items.getItemId(param1);
         if(_loc2_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         ActionFactory.getInstance().getShopCommands().useCastleGoods(this.castleId,_loc2_,this.handleCmdResponse);
      }
      
      private function waitEnemy(param1:Boolean = false) : void
      {
         var handler:Function = null;
         var timer:Timer = null;
         var ignoreJunk:Boolean = param1;
         this.currentAction = "waitresource";
         this.pleaseStop = false;
         this.onCmdResult("Waiting for " + (ignoreJunk ? "non junkwave" : "any") + " incomming enemy army...");
         handler = function(param1:TimerEvent):void
         {
            var _loc2_:Boolean = false;
            var _loc3_:ArmyBean = null;
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdFinshed(true);
               return;
            }
            if(ignoreJunk)
            {
               _loc2_ = false;
               for each(_loc3_ in cityManager.enemyArmies)
               {
                  if(!cityManager.isJunkTroop(_loc3_.troop))
                  {
                     _loc2_ = true;
                     break;
                  }
               }
               if(!_loc2_)
               {
                  return;
               }
            }
            else if(cityManager.enemyArmies.length < 1)
            {
               return;
            }
            onCmdResult("Detected new " + (ignoreJunk ? "non junkwave" : "") + " incomming enemy army, resuming script...");
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER,handler);
            timer = null;
            onCmdFinshed(true);
         };
         timer = new Timer(1200);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function waitNoBuilding() : void
      {
         var handler:Function = null;
         var timer:Timer = null;
         this.pleaseStop = false;
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               return;
            }
            timer.delay = 1000;
            if(cityManager._getCurrentConstruction() == null)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdFinshed(true);
            }
         };
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function qBuildNpc() : void
      {
         var handler:Function = null;
         var waitTimer:Timer = null;
         this.currentAction = "qbuildnpc";
         this.pleaseStop = false;
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop || Connection.getInstance().paused || !Connection.getInstance().authenticated)
            {
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               return;
            }
            waitTimer.delay = 5000;
            var _loc2_:Boolean = false;
            var _loc3_:Array = MainScreen.getCities();
            var _loc4_:Array = Utils.randOrder(_loc3_.length);
            var _loc5_:CityState = null;
            var _loc6_:int = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc5_ = _loc3_[_loc4_[_loc6_]];
               if(_loc5_.cityManager._doQBuildNpc())
               {
                  _loc2_ = true;
               }
               _loc6_++;
            }
            if(!_loc2_)
            {
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               onCmdFinshed(true);
            }
         };
         waitTimer = new Timer(0);
         waitTimer.addEventListener(TimerEvent.TIMER,handler);
         waitTimer.start();
      }
      
      public function getPlayerInfo(param1:String) : PlayerInfoBean
      {
         return Map.getPlayerInfo(param1,60);
      }
      
      private function waitHero(param1:String) : void
      {
         var heroNames:Array = null;
         var handler:Function = null;
         var timer:Timer = null;
         var heroName:String = param1;
         this.currentAction = "waithero";
         this.pleaseStop = false;
         heroNames = this.getHeroNamesFromMacroNames(heroName).split(";");
         this.onCmdResult("Waiting for " + (heroNames.length > 1 ? "one hero out of " + heroNames.join(", ") : "hero " + heroNames[0]) + " to be available...");
         handler = function(param1:TimerEvent):void
         {
            var _loc3_:String = null;
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdFinshed(true);
               return;
            }
            timer.delay = 2 * 1000;
            var _loc2_:HeroBean = null;
            if(heroNames.length <= 1)
            {
               _loc2_ = findHeroByName(heroNames[0]);
            }
            else
            {
               for each(_loc3_ in heroNames)
               {
                  _loc2_ = findHeroByName(_loc3_);
                  if(_loc2_ != null && _loc2_.status == HeroConstants.HERO_FREE_STATU)
                  {
                     break;
                  }
               }
            }
            if(_loc2_ == null || _loc2_.status != HeroConstants.HERO_FREE_STATU)
            {
               return;
            }
            onCmdResult("Hero " + _loc2_.name + " is now available");
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER,handler);
            timer = null;
            onCmdFinshed(true);
         };
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function resetHeroStatsById(param1:int) : void
      {
         this.currentAction = "resetHeroStatsById";
         var _loc2_:HeroBean = this.findHeroById(param1);
         if(_loc2_ != null)
         {
            this.cityManager.logMsg("Resetting attributes for hero " + _loc2_.name + " using " + Math.ceil(_loc2_.level / 10) + " Holy Water(s).");
            ActionFactory.getInstance().getHeroCommand().resetPoint(this.castleId,_loc2_.id,this.resetHeroStatsResponseHandler);
         }
         else
         {
            this.onCmdFinshed(new ScriptError("Hero id \"" + param1 + "\" does not exist. Check entred value and try again",-9999));
         }
      }
      
      private function transport(param1:int, param2:TroopBean, param3:ResourceBean, param4:String = "") : void
      {
         this.currentAction = "transport";
         this.doMarch(ObjConstants.ARMY_MISSION_TRANS,param1,"none",param2,param3,param4);
      }
      
      private function train2(param1:TroopBean, param2:String = "atk", param3:String = "all", param4:int = 1) : void
      {
         this.currentAction = "train";
         var _loc5_:HeroBean = null;
         var _loc6_:Boolean = false;
         if(param1 == null)
         {
            this.onCmdResult("Invalid troop to train");
            this.onCmdFinshed(true);
            return;
         }
         if(this.cityManager.researches == null)
         {
            this.onCmdResult("Research has not been obtained, please try again later");
            this.onCmdFinshed(true);
            return;
         }
         var _loc7_:* = param3.toLowerCase() == "idle";
         var _loc8_:Boolean = (_loc7_) || param3.toLowerCase() == "all";
         var _loc9_:int = _loc8_ ? 0 : int(param3);
         var _loc10_:int = 0;
         while(_loc10_ < this.cityManager.researches.length)
         {
            this.m_techLevels[String(this.cityManager.researches[_loc10_].typeId)] = this.cityManager.researches[_loc10_].avalevel;
            _loc10_++;
         }
         var _loc11_:Object = TrainTroopHelper.getTrainObj(this,param1,_loc9_,_loc8_,param4);
         if(_loc11_.errormsg.length > 0)
         {
            this.onCmdResult(_loc11_.errormsg,"");
         }
         else
         {
            _loc5_ = this.getMayor();
            _loc6_ = true;
            if(param2.toLowerCase() == "any" || param2.toLowerCase() == "atk")
            {
               this.setMayorByType("atk");
            }
            else
            {
               _loc6_ = this.fncSetMayorByName(param2);
               if(_loc6_)
               {
               }
            }
            if(_loc6_)
            {
               this.onCmdResult("Training " + String(_loc11_.amount) + " " + TrainTroopHelper.lookupName(_loc11_.troopid) + (_loc7_ ? " in all idle barracks" : (_loc8_ ? " in all barracks" : " in barrack #" + String(_loc11_.barrackid))),"");
               CityStateCommands.produceTroop(this.castleId,_loc11_.barrackid,_loc11_.troopid,_loc11_.amount,_loc8_,_loc7_);
               if(_loc5_ != this.getMayor())
               {
                  if(_loc5_ == null)
                  {
                     this.setMayorByType("re");
                  }
                  else
                  {
                     this.fncSetMayorByName(_loc5_.name);
                  }
               }
            }
            else
            {
               this.logCmdResponse("Could not set mayor to " + param2 + ". Not training troops.","");
            }
         }
         this.cityManager.updateTroopQueue();
         Utils.callLater(1000,this.onCmdFinshed,[true]);
      }
      
      private function teleport(param1:String, param2:String = "") : void
      {
         this.currentAction = "teleport";
         var _loc3_:String = param2 == "" ? param1.substr(0,3).toLowerCase() : param1.substr(0,1).toLowerCase() + param2.substr(0,1).toLowerCase();
         var _loc4_:int = int(["fri","sax","nm","boh","ll","fra","thu","mor","ul","swa","bav","car","bur","lom","tus","rom"].indexOf(_loc3_));
         if(_loc4_ == -1)
         {
            _loc4_ = int(["fri","sax","nor","boh","low","fra","thu","mor","upp","swa","bav","car","bur","lom","tus","rom"].indexOf(_loc3_));
         }
         if(_loc4_ == -1)
         {
            if(!(param1.toLowerCase() == "random" || param1.toLowerCase() == "any"))
            {
               this.onCmdFinshed(new ScriptError("Invalid state: " + param1 + ", consider using the first few letters of the desired state instead",-9999));
               return;
            }
            _loc4_ == int(Math.random() * 16);
         }
         this.cityManager._recallIncomingArmies();
         this.setCmdResponse(ResponseDispatcher.CITY_MOVE_CASTLE,this.handleCmdResponse);
         ActionFactory.getInstance().getCityCommands().moveCastle(this.castleId,_loc4_);
         this.cityManager._resetLocalFieldsInfo();
      }
      
      private function rereadGoals() : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "rereadgoals";
         MainScreen.getInstance()._cityPanel.onSetGoals(this.castleId);
         this.onCmdFinshed(true);
      }
      
      private function handleGetSupSettingResponse(param1:ColonialDeployResponse) : void
      {
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError("Error received: " + param1.errorMsg,-9999));
            return;
         }
         var _loc2_:String = param1.troopBean != null ? Utils.troopBeanToMsgString(param1.troopBean) : "";
         this.onCmdResult("Suppression setting is currently " + _loc2_);
         this.onCmdFinshed(true);
      }
      
      public function getMapFieldList(param1:String, param2:int, param3:Number, param4:int = -1, param5:Boolean = true) : String
      {
         var fieldLvl:int;
         var fieldObj:MapCastleBean;
         var cX:int;
         var cY:int;
         var sortOn:Function;
         var fieldId:int;
         var results:Array;
         var x:int;
         var type:int;
         var y:int = 0;
         var i:int = 0;
         var name:String = param1;
         var lev:int = param2;
         var rad:Number = param3;
         var center:int = param4;
         var rtnCoords:Boolean = param5;
         if(center == -1)
         {
            center = this.castle.fieldId;
         }
         type = Map.getFieldType(name);
         if(type == -1)
         {
            return null;
         }
         if(lev < 0 || lev > 20)
         {
            return null;
         }
         if(rad < 0)
         {
            return null;
         }
         cX = Map.getX(center);
         cY = Map.getY(center);
         if(!Map.isMapReady(cX,cY,rad))
         {
            return null;
         }
         fieldId = 0;
         fieldLvl = 0;
         fieldObj = null;
         results = new Array();
         x = cX - rad;
         while(x <= cX + rad)
         {
            y = cY - rad;
            while(y <= cY + rad)
            {
               if((x - cX) * (x - cX) + (y - cY) * (y - cY) <= rad * rad)
               {
                  fieldId = Map.getFieldId(x,y);
                  if(Map.getType(fieldId) == type)
                  {
                     fieldLvl = Map.getLevel(fieldId);
                     if(fieldLvl == 10 && lev >= 10 && (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE))
                     {
                        if((fieldObj = Map.getDetailInfo(fieldId)) != null)
                        {
                           fieldLvl = 18 - 2 * fieldObj.powerLevel;
                        }
                     }
                     if((fieldLvl == lev || lev == 0) && results.indexOf(fieldId) == -1)
                     {
                        results.push(fieldId);
                     }
                  }
               }
               y++;
            }
            x++;
         }
         if(results.length == 0)
         {
            return null;
         }
         sortOn = function(param1:int, param2:int):int
         {
            var _loc3_:Number = Map.fieldDistance(param1,center);
            var _loc4_:Number = Map.fieldDistance(param2,center);
            return _loc3_ < _loc4_ ? -1 : (_loc3_ > _loc4_ ? 1 : 0);
         };
         results.sort(sortOn);
         if(rtnCoords)
         {
            i = 0;
            while(i < results.length)
            {
               results[i] = Map.fieldIdToCoordinate(results[i]);
               i++;
            }
         }
         return results.join(" ");
      }
      
      private function updateFort(param1:FortificationsUpdate) : void
      {
         if(this.castleId == param1.castleId)
         {
            param1.fortification.copyTo(this.castle.fortification);
         }
      }
      
      private function scanDetail(param1:int, param2:Number) : void
      {
         var cx:int = 0;
         var cy:int = 0;
         var handler:Function = null;
         var scanTimer:Timer = null;
         var targetId:int = param1;
         var r:Number = param2;
         this.currentAction = "scandetail";
         this.pleaseStop = false;
         cx = Map.getX(targetId);
         cy = Map.getY(targetId);
         handler = function(param1:TimerEvent):void
         {
            scanTimer.delay = 1500;
            if(pleaseStop)
            {
               scanTimer.stop();
               scanTimer.removeEventListener(TimerEvent.TIMER,handler);
               scanTimer = null;
               onCmdFinshed(true);
               return;
            }
            if(Map.isMapDetailReady(cx,cy,r))
            {
               scanTimer.stop();
               scanTimer.removeEventListener(TimerEvent.TIMER,handler);
               scanTimer = null;
               onCmdResult("SCAN DETAIL COMPLETED " + Map.fieldIdToCoordString(targetId) + " radius " + r);
               onCmdFinshed(true);
            }
         };
         scanTimer = new Timer(0);
         scanTimer.addEventListener(TimerEvent.TIMER,handler);
         scanTimer.start();
      }
      
      private function cleanReports(param1:String = "Barbarian", param2:int = 1) : void
      {
         CallbackParams.cleanReportsSearchString = param1;
         this.setCmdResponse(ResponseDispatcher.REPORT_RECEIVE_REPORT_LIST,this._sp1096);
         ActionFactory.getInstance().getReportCommands().receiveReportList(param2,10,ObjConstants.REPORT_TYPE_ARMY);
      }
      
      private function scout(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "scout";
         this.doMarch(ObjConstants.ARMY_MISSION_SCOUT,param1,param2,param3,null,param4);
      }
      
      private function wallDefense(param1:String = "trap", param2:int = 1, param3:String = "build") : void
      {
         this.onCmdResult("Waiting for town\'s turn to build wall defense...");
         this.cityManager._reserveEmergencyTimeSlot();
         this.waitForCmActive(this.wallDefense2,[param1,param2,param3]);
      }
      
      private function setAllGoals() : void
      {
         var _loc1_:String = null;
         _loc1_ = "SetAllGoals";
         MainScreen.getInstance().dispatchEvent(new Event(_loc1_));
         this.onCmdFinshed(true);
      }
      
      private function useItem(param1:String) : void
      {
         this.currentAction = "useitem";
         var _loc2_:String = Items.getItemId(param1);
         if(_loc2_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item name.",-9999));
            return;
         }
         if(_loc2_ == "player.heart.1.a" || _loc2_ == "player.pop.1.a" || _loc2_ == "player.halloween.castle" || _loc2_ == "player.halloween.castle.adv" || _loc2_ == "player.haunted.castle" || _loc2_ == "player.haunted.castle.adv")
         {
            ActionFactory.getInstance().getShopCommands().useCastleGoods(this.castleId,_loc2_,this.handleCmdResponse);
         }
         else if(_loc2_ == Items.getItemId("Truce_Agreement"))
         {
            ActionFactory.getInstance().getCityCommands().setStopWarState(_loc2_,LoginHelper.getInstance().getHashedEvonyPw(),this.handleCmdResponse);
         }
         else if(_loc2_ == Items.getItemId("Hero_Hunting"))
         {
            ActionFactory.getInstance().getHeroCommand().refreshHerosListFromTavern(this.castleId,this.handleUseHeroHuntingResponse);
         }
         else
         {
            ActionFactory.getInstance().getShopCommands().useGoods(this.castleId,_loc2_,1,this.handleUseItemResponse);
         }
      }
      
      private function changeFlag(param1:String) : void
      {
         this.currentAction = "changeflag";
         this.setCmdResponse(ResponseDispatcher.CITY_MODIFY_FLAG,this.handleCmdResponse);
         this.onCmdResult("Changing flag to " + param1);
         ActionFactory.getInstance().getCityCommands().modifyFlag(param1);
      }
      
      private function endKeepResource() : void
      {
         this.currentAction = "endkeepresource";
         this.cityManager._cp1009();
         this.onCmdFinshed(true);
      }
      
      private function waitNoEnemy(param1:Boolean = false) : void
      {
         var handler:Function = null;
         var timer:Timer = null;
         var ignoreJunk:Boolean = param1;
         this.currentAction = "waitresource";
         this.pleaseStop = false;
         this.onCmdResult("Waiting for no more " + (ignoreJunk ? "non junkwave" : "") + " incomming enemy armies...");
         handler = function(param1:TimerEvent):void
         {
            var _loc2_:Boolean = false;
            var _loc3_:ArmyBean = null;
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdFinshed(true);
               return;
            }
            if(ignoreJunk)
            {
               _loc2_ = false;
               for each(_loc3_ in cityManager.enemyArmies)
               {
                  if(!cityManager.isJunkTroop(_loc3_.troop))
                  {
                     _loc2_ = true;
                     break;
                  }
               }
               if(_loc2_)
               {
                  return;
               }
            }
            else if(cityManager.enemyArmies.length > 0)
            {
               return;
            }
            onCmdResult("Detected no more " + (ignoreJunk ? "non junkwave" : "") + " incomming enemy armies, resuming script...");
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER,handler);
            timer = null;
            onCmdFinshed(true);
         };
         timer = new Timer(1200);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function _tf342(param1:String) : int
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         for(_loc3_ in this.castle.buildingsArray)
         {
            if(this.castle.buildingsArray[_loc3_].typeId == BuildingType.fromString(param1) && this.castle.buildingsArray[_loc3_].level > _loc2_)
            {
               _loc2_ = int(this.castle.buildingsArray[_loc3_].level);
            }
         }
         return _loc2_;
      }
      
      private function config(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.cityManager._setConfig(param1);
         this.onCmdResult("*** config changes may become effective a few minutes after the script terminates");
         this.onCmdFinshed(true);
      }
      
      private function setNpcFlag(param1:int) : void
      {
         this.currentAction = "setnpcflag";
         this.cityManager._markAndUnmarkFlatForNpc(param1,true);
         this.onCmdFinshed(true);
      }
      
      private function handleGearCmdResponse(param1:ResearchResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         if(param1.tech.castleId != this.castleId)
         {
            return;
         }
         var _loc2_:Date = new Date(param1.tech.endTime);
         this.onCmdResult(GearType.toNameString(param1.tech.typeId) + " level " + (param1.tech.level + 1) + " research started.  Estimated finish time " + _loc2_.toLocaleString(),"");
         this.cityManager._handleGearCmdResponse(param1);
         this.onCmdFinshed(true);
      }
      
      private function capture(param1:int, param2:int) : void
      {
         this.currentAction = "capture";
         this.cityManager._oh316(param1,param2,true);
         this.onCmdFinshed(true);
      }
      
      private function rescanRec(param1:int, param2:int) : void
      {
         this.currentAction = "rescanrec";
         this.pleaseStop = false;
         Map.resetRectangle(Map.getX(param1),Map.getY(param1),Map.getX(param2),Map.getY(param2));
         this.scanRec(param1,param2);
      }
      
      private function untrain(param1:TroopBean) : void
      {
         this.currentAction = "untrain";
         var _loc2_:TroopBean = this.cityManager._xl810();
         if(_loc2_ == null)
         {
            this.onCmdResult("Please wait for town to be initialized first");
            this.onCmdFinshed(true);
         }
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         var _loc5_:Array = new Array("","","peasants","militia","scouter","pikemen","swordsmen","archer","carriage","lightCavalry","heavyCavalry","ballista","batteringRam","catapult");
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_] != "")
            {
               _loc3_ = 0;
               if(param1[_loc5_[_loc6_]] > 0)
               {
                  _loc3_ = Math.min(_loc2_[_loc5_[_loc6_]],param1[_loc5_[_loc6_]]);
               }
               else if(param1[_loc5_[_loc6_]] < 0)
               {
                  _loc3_ = Math.max(0,_loc2_[_loc5_[_loc6_]] + param1[_loc5_[_loc6_]]);
               }
               if(_loc3_ > 0)
               {
                  _loc4_ += _loc3_;
                  this.onCmdResult("Untrain " + _loc3_ + " " + Utils.troopExtNames[_loc6_]);
                  CityStateCommands.disbandTroop(this.castleId,_loc6_,_loc3_);
               }
            }
            _loc6_++;
         }
         if(_loc4_ == 0)
         {
            this.onCmdResult("No troop was untrained");
         }
         this.onCmdFinshed(true);
      }
      
      private function huntingType(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "huntingtype";
         this.cityManager._bx341(param1);
         this.onCmdFinshed(true);
      }
      
      private function upLevelHero(param1:String) : void
      {
         var _loc2_:HeroBean = null;
         this.currentAction = "uplevelhero";
         _loc2_ = this.findHeroByName(param1);
         if(_loc2_ == null)
         {
            this.onCmdFinshed(new ScriptError("No hero found with name: " + param1,-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.HERO_LEVEL_UP,this.handleCmdResponse);
         CityStateCommands.levelUp(this.castleId,_loc2_.id,this.handleCmdResponse);
         this.onCmdResult("Uplevel hero " + _loc2_.name + "(" + _loc2_.id + ")");
      }
      
      private function waitForCmActive(param1:Function, param2:Array) : void
      {
         var handler:Function = null;
         var waitTimer:Timer = null;
         var func:Function = param1;
         var args:Array = param2;
         this.pleaseStop = false;
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               waitTimer = null;
               return;
            }
            waitTimer.delay = 1000;
            if(cityManager.isActive())
            {
               func.apply(this,args);
               waitTimer.stop();
               waitTimer.removeEventListener(TimerEvent.TIMER,handler);
               waitTimer = null;
            }
         };
         waitTimer = new Timer(0);
         waitTimer.addEventListener(TimerEvent.TIMER,handler);
         waitTimer.start();
      }
      
      private function endLoyaltyAttack() : void
      {
         this.currentAction = "endloyaltyattack";
         this.cityManager._le863();
         this.onCmdFinshed(true);
      }
      
      private function doResearch(param1:String) : void
      {
         this.currentAction = "research";
         this.setCmdResponse(ResponseDispatcher.TECH_RESEARCH,this.updateResearch);
         this.researchType = param1.toLowerCase();
         this.setCmdResponse(ResponseDispatcher.TECH_GET_RESEARCH_LIST,this.onDoResearchResponse);
         CityStateCommands.getResearchList(this.castleId,this.onGetResearchListResponse);
      }
      
      private function fireHero(param1:String) : void
      {
         var _loc2_:HeroBean = null;
         var _loc4_:Array = null;
         var _loc5_:ArrayCollection = null;
         var _loc6_:HeroBean = null;
         _loc2_ = null;
         var _loc3_:Boolean = false;
         this.currentAction = "firehero";
         _loc4_ = this.getHeroNamesFromMacroNames(param1).toLowerCase().split(";");
         _loc5_ = this.cityManager._ox998();
         for each(_loc6_ in _loc5_)
         {
            if(_loc4_.indexOf(_loc6_.name.toLowerCase()) >= 0)
            {
               _loc3_ = true;
               if(_loc6_.status == CityStateConstants.HERO_STATUS_CAPTIVE || _loc6_.status == CityStateConstants.HERO_STATUS_IDLE || _loc6_.status == CityStateConstants.HERO_STATUS_MAYOR)
               {
                  _loc2_ = _loc6_;
               }
            }
         }
         if(_loc2_ == null)
         {
            this.onCmdFinshed(new ScriptError("You failed to specify a valid idle hero",-9999));
            return;
         }
         if(_loc2_.status != CityStateConstants.HERO_STATUS_CAPTIVE)
         {
            if(_loc2_.status == CityStateConstants.HERO_STATUS_MAYOR)
            {
               CityStateCommands.dischargeChief(this.castleId);
            }
            this.onCmdResult("Firing hero " + _loc2_.name);
            CityStateCommands.fireHero(this.castleId,_loc2_.id,this.handleCmdResponse);
            return;
         }
         this.onCmdResult("Releasing captured hero " + _loc2_.name);
         CityStateCommands.releaseHero(this.castleId,_loc2_.id,this.handleCmdResponse);
      }
      
      private function printGoalCommandWarning() : void
      {
         if(!goalCommandWarning)
         {
            return;
         }
         this.onCmdResult("*** You are using a command that should normally be done as a goal. To disable this warning, use \'goalcommandwarning false\'");
      }
      
      private function skypeWarReportReceivers(param1:String) : void
      {
         this.currentAction = "";
         this.printGoalCommandWarning();
         if(!this.cityManager._setSkypeWrReceivers(param1))
         {
            this.onCmdFinshed(new ScriptError("Parameter error for command skypewarreportreceivers",-9999));
         }
         else
         {
            this.onCmdFinshed(true);
         }
         this.onCmdFinshed(true);
      }
      
      private function reinforce(param1:int, param2:String, param3:TroopBean, param4:ResourceBean = null, param5:String = "") : void
      {
         this.currentAction = "reinforce";
         this.doMarch(ObjConstants.ARMY_MISSION_SEND,param1,param2,param3,param4,param5);
      }
      
      private function _xv597(param1:String = "atk", param2:int = 69, param3:int = 1) : void
      {
         this.logCmdResponse("findhero requires exclusive control of all Inns while running and must be disabled in AutoEvony, please use appropriate config settings instead.");
         this.onCmdFinshed(true);
      }
      
      public function changeheroname(param1:String, param2:String) : void
      {
         this.changeHeroName(param1,param2);
      }
      
      public function get serverTimeRaw() : Number
      {
         return Utils.getCurrentServerTimeRaw().getTime();
      }
      
      private function sell(param1:String, param2:Number, param3:Number) : void
      {
         this.currentAction = "sell";
         this.trade("sell",param1,param2,param3);
      }
      
      public function setCityStopState() : void
      {
         this.pleaseStop = true;
      }
      
      private function resetHeroStatsByName(param1:String) : void
      {
         this.currentAction = "resetHeroStatsByName";
         var _loc2_:HeroBean = this.findHeroByName(param1);
         if(_loc2_ != null)
         {
            this.cityManager.logMsg("Resetting attributes for hero " + _loc2_.name + " using " + Math.ceil(_loc2_.level / 10) + " Holy Water(s).");
            ActionFactory.getInstance().getHeroCommand().resetPoint(this.castleId,_loc2_.id,this.resetHeroStatsResponseHandler);
         }
         else
         {
            this.onCmdFinshed(new ScriptError("Hero \"" + param1 + "\" does not exist. Check spelling and try again",-9999));
         }
      }
      
      private function changeHeroGears(param1:String, param2:String) : void
      {
         var _loc3_:HeroBean = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         this.currentAction = "changeHeroGear2";
         _loc3_ = this.findHeroByName(param1);
         if(_loc3_ == null)
         {
            this.onCmdFinshed(new ScriptError("Hero name not found: " + param1,-9999));
            return;
         }
         _loc4_ = param2.replace(/none/gi,"0").replace(/pol/gi,"1").replace(/atk/gi,"2").replace(/int/gi,"3").split(",");
         if(_loc4_.length < 1 || _loc4_.length > 16)
         {
            this.onCmdFinshed(new ScriptError("Invalid number of gear pieces, expecting  we:atk,shi:atk,ri1:atk,...,fe:atk (up to 16 max) but getting  " + param2,-9999));
            return;
         }
         _loc5_ = new Array("he","che","we","shi","le","cha1","ri1","mo","ne","sho","ba","ga","be","cha2","ri2","fo");
         _loc6_ = new Array(EquipmentTech.EQUIPMENT_SLOT_HEAD,EquipmentTech.EQUIPMENT_SLOT_CHEST,EquipmentTech.EQUIPMENT_SLOT_WEAPON_L,EquipmentTech.EQUIPMENT_SLOT_SHIELD_L,EquipmentTech.EQUIPMENT_SLOT_LEG_L,EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L,EquipmentTech.EQUIPMENT_SLOT_RING_L,EquipmentTech.EQUIPMENT_SLOT_MOUNT_L,EquipmentTech.EQUIPMENT_SLOT_NECKLACE,EquipmentTech.EQUIPMENT_SLOT_SHOULDERS,EquipmentTech.EQUIPMENT_SLOT_BACK,EquipmentTech.EQUIPMENT_SLOT_WRIST,EquipmentTech.EQUIPMENT_SLOT_WAIST,EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R,EquipmentTech.EQUIPMENT_SLOT_RING_R,EquipmentTech.EQUIPMENT_SLOT_FEET);
         _loc7_ = null;
         _loc8_ = new Array();
         _loc9_ = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc9_].split(":");
            if(_loc7_.length != 2)
            {
               this.onCmdFinshed(new ScriptError("Invalid format for gear:type found in gear list parameter. Expecting  abr:type  but getting  " + _loc4_[_loc9_],-9999));
               return;
            }
            if(_loc5_.indexOf(_loc7_[0].toLowerCase()) < 0)
            {
               this.onCmdFinshed(new ScriptError("Invalid gear abbreviation \'" + _loc7_[0] + "\' found in gear list parameter. Valid options are " + _loc5_.join(", "),-9999));
               return;
            }
            if(isNaN(Number(_loc7_[1])) || int(_loc7_[1]) < 0 || int(_loc7_[1]) > 3)
            {
               this.onCmdFinshed(new ScriptError("Invalid gear type \'" + _loc7_[1] + "\' found in gear list parameter. Valid options are (none, pol, atk, int)",-9999));
               return;
            }
            _loc7_[0] = _loc7_[0].toLowerCase();
            if(_loc3_.equipmentbeanArray[_loc6_[_loc5_.indexOf(_loc7_[0])] - 1].addAttributeType != int(_loc7_[1]))
            {
               _loc8_.push(_loc4_[_loc9_]);
            }
            _loc9_++;
         }
         this.changeHeroGearsParams = new Object();
         this.changeHeroGearsParams.heroName = param1;
         this.changeHeroGearsParams.i = 0;
         this.changeHeroGearsParams.heroId = _loc3_.id;
         this.changeHeroGearsParams.setGears = _loc8_;
         this.changeHeroGearsHandler();
      }
      
      public function getMapLevel(param1:int) : int
      {
         return Map.getLevel(param1);
      }
      
      private function setGuard(param1:int, param2:TroopBean, param3:FortificationsBean = null) : void
      {
         this.currentAction = "setguard";
         this.cityManager._vf712(param1,param2,param3);
         this.onCmdFinshed(true);
      }
      
      public function getStatic(param1:String) : *
      {
         return this.script.getStatic(param1);
      }
      
      public function setVar(param1:String, param2:*) : *
      {
         return this.script.setVar(param1,param2);
      }
      
      private function aBigScout(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "abigscout";
         this.doMarch(ObjConstants.ARMY_MISSION_SCOUT,param1,param2,param3,null,param4,true,false,2,null);
      }
      
      private function bigAttack(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "bigattack";
         this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY,param1,param2,param3,null,param4,true);
      }
      
      private function healTroops() : void
      {
         this.currentAction = "healtroops";
         this.cityManager.doHealInjuredTroop(true);
         this.onCmdFinshed(true);
      }
      
      private function honorAttack(param1:int, param2:TroopBean, param3:int = 0) : void
      {
         this.currentAction = "honorattack";
         this.cityManager._by1090(param1,param2,param3);
         this.onCmdFinshed(true);
      }
      
      private function chatPc(param1:String, param2:String) : void
      {
         this.currentAction = "sendPrivateChatMessage";
         ActionFactory.getInstance().getCommonCommands().privateChat(param1,param2,this.chatHandler);
         MainScreen.getInstance()._chatPanel.showWhisperInChats(param1,param2,"To",true);
         this.onCmdFinshed(true);
      }
      
      private function guardedAttack(param1:int, param2:TroopBean, param3:int, param4:TroopBean, param5:FortificationsBean = null) : void
      {
         this.currentAction = "guardedattack";
         if(param3 <= 0)
         {
            this.onCmdFinshed("Invalid number of scouts for guardedattack");
            return;
         }
         this.cityManager._yi129(param1,param2,param3,param4,param5);
         Utils.callLater(1500,this.onCmdFinshed,[true]);
      }
      
      private function sellTo(param1:String, param2:Number, param3:Number, param4:Number = 0) : void
      {
         this.currentAction = "sellto";
         this.tradeTo("sell",param1,param2,param3,param4);
      }
      
      private function _bw617(param1:int, param2:Boolean = false) : Array
      {
         var _loc4_:HeroBean = null;
         var _loc3_:Array = new Array();
         for each(_loc4_ in this.castle.herosArray)
         {
            if(_loc4_.status == param1)
            {
               _loc3_[_loc3_.length] = _loc4_;
            }
         }
         return _loc3_;
      }
      
      public function setStatic(param1:String, param2:*) : *
      {
         return this.script.setStatic(param1,param2);
      }
      
      private function loginToSkype(param1:String, param2:String) : void
      {
         var response:SkypeResponse;
         var handler:Function;
         var un:String = param1;
         var pw:String = param2;
         this.currentAction = "loggingIntoSkype";
         handler = function(param1:SkypeResponse):void
         {
            if(param1.ok != SkypeConstants.OK_DEFAULT)
            {
               onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            }
            else
            {
               cityManager.logMsg("Skype login successful");
               onCmdFinshed(true);
            }
         };
         response = Skype.login(un,pw,handler);
         if(response.ok == SkypeConstants.OK_DEFAULT)
         {
            if(!this.script.silence)
            {
               this.cityManager.logMsg("Attempting login to skype with username: " + un + " and password: " + pw);
            }
         }
         else if(response.ok == SkypeConstants.ERROR_USER_ALREADY_LOGGED_IN)
         {
            if(!this.script.silence)
            {
               this.cityManager.logMsg("Already logged into skype with username " + un);
            }
            this.onCmdFinshed(true);
         }
         else
         {
            this.onCmdFinshed(new ScriptError(response.errorMsg,response.ok));
         }
      }
      
      private function skypePm(param1:String, param2:String) : void
      {
         var response:SkypeResponse;
         var handler:Function;
         var userid:String = param1;
         var msg:String = param2;
         this.currentAction = "sendSkypePrivateMessage";
         handler = function(param1:SkypeResponse):void
         {
            if(param1.ok != SkypeConstants.OK_DEFAULT)
            {
               if(currentAction == "sendSkypePrivateMessage")
               {
                  onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
               }
               else
               {
                  cityManager.logMsg(param1.errorMsg + ":" + param1.ok);
               }
            }
            else
            {
               if(!script.silence)
               {
                  cityManager.logMsg(param1.msg);
               }
               if(currentAction == "sendSkypePrivateMessage")
               {
                  onCmdFinshed(true);
               }
            }
         };
         response = Skype.queueMsg(userid,msg,false,handler);
         if(response.ok != SkypeConstants.OK_DEFAULT)
         {
            if(response.ok == SkypeConstants.OK_MSG_QUEUED)
            {
               this.cityManager.logMsg("Skype private message has been queued, waiting for login to send...");
               this.onCmdFinshed(true);
            }
            else
            {
               this.onCmdFinshed(new ScriptError("Error sending Skype Private Message: " + response.errorMsg,response.ok));
            }
         }
      }
      
      public function _getReliefStationSpeedupFactor() : int
      {
         return SPEEDUP[this.cityManager.getBuildingLevel(BuildingConstants.TYPE_TRANSPORT_STATION)];
      }
      
      private function getResources(param1:String) : ResourceBean
      {
         return Utils.getEstResoBean(param1);
      }
      
      private function qAll() : void
      {
         this.currentAction = "qall";
         var _loc1_:Array = MainScreen.getCities();
         var _loc2_:Array = Utils.randOrder(_loc1_.length);
         var _loc3_:CityState = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc1_[_loc2_[_loc4_]];
            _loc3_.cityManager._manager();
            _loc4_++;
         }
         this.onCmdFinshed(true);
      }
      
      private function _qDeploy(param1:Object, param2:int, param3:String, param4:TroopBean, param5:ResourceBean = null, param6:String = "", param7:Boolean = false, param8:Boolean = false, param9:int = 0) : void
      {
         var _loc12_:int = 0;
         this.currentAction = "qdeploy";
         var _loc10_:int = int(param1);
         if(_loc10_ == 0)
         {
            _loc12_ = int(new Array("at","bu","re","sc","tr","co","an","su","up","de").indexOf(param1.toString().toLowerCase().substr(0,2)));
            if(_loc12_ == -1)
            {
               this.logCmdResponse("Invalid deploy value, must be among: attack, build, reinforce, scout, transport, colonize, anticolonize, suppress, uprise, or deploytroop");
               this.onCmdFinshed(true);
               return;
            }
            _loc10_ = int(new Array(ObjConstants.ARMY_MISSION_OCCUPY,ObjConstants.ARMY_MISSION_CONSTRUCT,ObjConstants.ARMY_MISSION_SEND,ObjConstants.ARMY_MISSION_SCOUT,ObjConstants.ARMY_MISSION_TRANS,ObjConstants.ARMY_MISSION_COLONIZE,ObjConstants.ARMY_MISSION_ANTI_COLONIAL,ObjConstants.ARMY_MISSION_SUPPRESS,ObjConstants.ARMY_MISSION_UPRISE,ObjConstants.ARMY_MISSION_DEPLOY_TROOPS)[_loc12_]);
         }
         var _loc11_:String = this._doQuickMarch(_loc10_,param2,param3,param4,param5,param6,param7,param8,param9);
         this.onCmdResult(_loc11_);
         if(_loc11_.substr(0,5) == "March")
         {
            this.setCmdResponse(ResponseDispatcher.ARMY_NEW_ARMY,this.handleCmdResponse);
         }
         else
         {
            Utils.callLater(1500,this.onCmdFinshed,[true]);
         }
      }
      
      private function attackPlayerValleys(param1:String, param2:int, param3:Number, param4:int = 8) : void
      {
         this.currentAction = "attackplayervalleys";
         this.onCmdFinshed(true);
      }
      
      private function buildingGoals(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "buildinggoals";
         this.cityManager._vu1098(param1);
         this.onCmdFinshed(true);
      }
      
      public function deleteVar(param1:String) : *
      {
         return this.script.deleteVar(param1);
      }
      
      private function endHonorAttack() : void
      {
         this.currentAction = "endhonorattack";
         this.cityManager._pi862();
         this.onCmdFinshed(true);
      }
      
      private function useTechItem(param1:String) : void
      {
         var handler:Function;
         var itemId:String;
         var itemName:String = param1;
         this.currentAction = "usetechitem";
         itemId = Items.getItemId(itemName);
         if(itemId == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         if(this.cityManager.getResearchInProgress() == null)
         {
            this.onCmdFinshed(new ScriptError("No current research",-9999));
            return;
         }
         handler = function(param1:ResearchResponse):void
         {
            if(param1.ok != CommandResponse.OK_DEFAULT)
            {
               onCmdFinshed(new ScriptError("Research error: " + param1.errorMsg,-9999));
               return;
            }
            if(currentAction == "research" || currentAction == "usetechitem")
            {
               onCmdResult("Research response ok");
               onCmdFinshed(true);
            }
         };
         ActionFactory.getInstance().getTechCommand().speedUpResearch(this.castleId,itemId,handler);
      }
      
      private function changeCastleName(param1:String) : void
      {
         var newName:String = param1;
         this.currentAction = "changename";
         this.setCmdResponse(ResponseDispatcher.CITY_MODIFY_CASTLE_NAME,function(param1:CommandResponse):void
         {
            if(param1.ok == 1)
            {
               castle.name = newName;
               MainScreen.getInstance().doCityTabLabel(castle.id);
            }
            handleCmdResponse(param1);
            onCmdFinshed(true);
         });
         this.onCmdResult("Changing castle name from " + this.castle.name + " to " + newName);
         ActionFactory.getInstance().getCityCommands().modifyCastleName(this.castleId,newName,this.castle.logUrl);
      }
      
      public function get techTypes() : Object
      {
         var obj:Object = null;
         obj = {
            "agriculture":TechConstants.CROP_TECH,
            "lumbering":TechConstants.HEW_TECH,
            "masonry":TechConstants.EXCAVATION_TECH,
            "mining":TechConstants.SMELT_TECH,
            "metalcasting":TechConstants.MAKE_TECH,
            "informatics":TechConstants.SCOUT_SKILL,
            "militaryscience":TechConstants.TRAIN_SKILL,
            "militarytradition":TechConstants.COMBAT_SKILL,
            "ironworking":TechConstants.DEFEND_SKILL,
            "logistics":TechConstants.LOAD_TECH,
            "compass":TechConstants.MARCH_SKILL,
            "horsebackriding":TechConstants.DRIVE_SKILL,
            "archery":TechConstants.THROW_SKILL,
            "stockpile":TechConstants.STORE_TECH,
            "construction":TechConstants.BUILD_TECH,
            "medicine":TechConstants.SUPPLY_SKILL,
            "machinery":TechConstants.FORTIFICATION_TECH,
            "engineering":TechConstants.REPAIR_TECH,
            "privateering":TechConstants.HARRY_SKILL
         };
         obj["toDebugString"] = function():String
         {
            var _loc2_:String = null;
            var _loc1_:String = "";
            for(_loc2_ in obj)
            {
               if(_loc2_ != "toDebugString")
               {
                  _loc1_ += _loc2_ + " = " + obj[_loc2_] + "\n";
               }
            }
            return _loc1_;
         };
         return obj;
      }
      
      public function _cleanUp() : void
      {
         this.cityManager._cleanup();
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE,this.buildComplete);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE,this.researchComplete);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE,this.updateFort);
      }
      
      private function useDevilItem(param1:int, param2:String, param3:String = "") : void
      {
         this.currentAction = "usedevilitem";
         var _loc4_:String = Items.getItemId(param2);
         if(_loc4_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         this.setCmdResponse(ResponseDispatcher.SHOP_USE_DEVIL_ITEM,this.handleCmdResponse);
         ActionFactory.getInstance().getShopCommands().useDevilItem(Map.getX(param1),Map.getY(param1),_loc4_,param3);
      }
      
      private function distancePolicy(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "distancepolicy";
         this.cityManager._le27("" + param1 + " " + param2 + " " + param3 + " " + param4 + " " + param5);
         this.onCmdFinshed(true);
      }
      
      public function getItem(param1:String) : ItemBean
      {
         var _loc3_:ItemBean = null;
         param1 = Items.getItemId(param1.toLowerCase());
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:ItemBean = null;
         for each(_loc3_ in this.player.itemsArray)
         {
            if(_loc3_.id.toLowerCase() == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         if(_loc2_ == null)
         {
            _loc2_ = new ItemBean();
            _loc2_.id = param1;
            _loc2_.count = 0;
         }
         _loc2_.name = Items.getItemName(param1);
         return _loc2_;
      }
      
      private function fmth() : void
      {
         this.onCmdResult("Move the training hero");
         this.cityManager._forceTrainingHeroMove();
         this.onCmdFinshed(true);
      }
      
      private function updateResearch(param1:ResearchResponse) : void
      {
         var _loc2_:Date = null;
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         if(param1.tech.castleId != this.castleId)
         {
            return;
         }
         _loc2_ = new Date(param1.tech.endTime);
         this.onCmdResult(TechType.toString(param1.tech.typeId) + " level " + (param1.tech.level + 1) + " research started.  Estimated finish time " + _loc2_.toLocaleString(),"");
         this.currentResearch = param1.tech;
         this.cityManager._rv270(param1);
         this.onCmdFinshed(true);
      }
      
      private function troopGoal(param1:TroopBean) : void
      {
         this.printGoalCommandWarning();
         this.cityManager._addTroopGoal(param1);
         this.onCmdFinshed(true);
      }
      
      private function unBlockPlayer(param1:String) : void
      {
         this.currentAction = "unblock player";
         this.friendBlockPlayerName = param1;
         ActionFactory.getInstance().getFriendCommands().deleteBlock(param1,this.unBlockPlayerResponseHandler);
      }
      
      private function safeStar(param1:String, param2:int, param3:Number = 2) : void
      {
         var techId:int = 0;
         var currentLevel:int = 0;
         var delicateId:String = null;
         var flawlessId:String = null;
         var origTargetLevel:int = 0;
         var expectedDelicate:Array = null;
         var expectedFlawless:Array = null;
         var busy:Boolean = false;
         var starHandler:Function = null;
         var handler:Function = null;
         var timer:Timer = null;
         var tech:String = param1;
         var targetLevel:int = param2;
         var safetyFactor:Number = param3;
         this.currentAction = "safestar";
         if(targetLevel > 15 || targetLevel <= 0)
         {
            this.logCmdResponse("Invalid gear type: " + tech);
            this.onCmdFinshed(true);
            return;
         }
         techId = GearType.fromString(tech);
         if(techId <= 0)
         {
            this.logCmdResponse("Invalid gear type: " + tech);
            this.onCmdFinshed(true);
            return;
         }
         if(this.cityManager.gears.length == 0)
         {
            this.cityManager.updateGears();
            this.logCmdResponse("Gears not initialized yet, please rerun later");
            this.onCmdFinshed(true);
            return;
         }
         currentLevel = this.cityManager.getStarLevel(techId);
         if(currentLevel >= targetLevel)
         {
            this.onCmdResult("safestar: nothing to do, star level is already " + tech + ":" + currentLevel);
            this.onCmdFinshed(true);
            return;
         }
         delicateId = Items.getItemId("Delicate_gem");
         flawlessId = Items.getItemId("Flawless_gem");
         origTargetLevel = targetLevel;
         expectedDelicate = new Array(0,1.538,4.231,9.51,16.578,26.38,40.547,45.216,51.244,73.206,122.01,221.835,443.671,985.936,2190.97,4868.82);
         expectedFlawless = new Array(0,0,0,0,0,0,0,4.705,10.881,21.259,42.098,83.814,175.628,399.173,895.939,1999.87);
         busy = false;
         this.pleaseStop = false;
         starHandler = function(param1:GemstoneRespone):void
         {
            busy = false;
            if(param1.ok != 1)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               logCmdResponse("  safestar " + tech + " error: " + param1.errorMsg);
               onCmdFinshed(true);
               return;
            }
            onCmdResult("  star level of " + tech + " is " + (currentLevel > param1.enhancedstarlv ? "down to" : (currentLevel < param1.enhancedstarlv ? "UP TO" : "at")) + " " + param1.enhancedstarlv + ", gems: " + getItemCount(delicateId) + "/" + getItemCount(flawlessId));
            currentLevel = param1.enhancedstarlv;
            cityManager._handleStarLevelResponse(param1);
            timer.start();
         };
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdResult("safestar " + tech + " has been terminated");
               return;
            }
            timer.reset();
            if(busy)
            {
               return;
            }
            if(!Connection.getInstance().authenticated || Connection.getInstance().paused)
            {
               return;
            }
            while(targetLevel > 0)
            {
               if(getItemCount(delicateId) >= safetyFactor * expectedDelicate[targetLevel - 1] && getItemCount(flawlessId) >= safetyFactor * expectedFlawless[targetLevel - 1])
               {
                  break;
               }
               --targetLevel;
            }
            if(currentLevel >= targetLevel)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               if(targetLevel != origTargetLevel)
               {
                  onCmdResult("safestar ends, star level is now " + tech + ":" + currentLevel + ", gems: " + getItemCount(delicateId) + "/" + getItemCount(flawlessId) + ", needed " + Math.ceil(safetyFactor * expectedDelicate[origTargetLevel - 1]) + "/" + Math.ceil(safetyFactor * expectedFlawless[origTargetLevel - 1]));
               }
               else
               {
                  onCmdResult("safestar is successful, star level is now " + tech + ":" + currentLevel);
               }
               onCmdFinshed(true);
               return;
            }
            var _loc2_:String = currentLevel <= 5 ? delicateId : (currentLevel >= 8 ? flawlessId : (currentLevel != 6 ? (currentLevel != 7 ? flawlessId : (getItemCount(delicateId) >= 6 * getItemCount(flawlessId) ? delicateId : flawlessId)) : (getItemCount(delicateId) >= 3 * getItemCount(flawlessId) ? delicateId : flawlessId)));
            var _loc3_:int = currentLevel <= 2 ? 1 : 4;
            busy = true;
            onCmdResult("Safestar for " + tech + ":" + currentLevel + ", use " + _loc3_ + " " + Items.getItemName(_loc2_));
            ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(_loc2_,_loc3_,techId,starHandler);
         };
         timer = new Timer(100);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function gear(param1:String) : void
      {
         this.currentAction = "gear";
         var _loc2_:int = GearType.fromString(param1);
         if(_loc2_ <= 0)
         {
            this.logCmdResponse("Invalid gear type: " + param1);
            this.onCmdFinshed(true);
            return;
         }
         this.setCmdResponse(ResponseDispatcher.EQUIPMENTTECH_RESEARCH,this.handleGearCmdResponse);
         ActionFactory.getInstance().getEquipmenttechCommands().research(this.castleId,_loc2_);
      }
      
      private function useStratItem(param1:int, param2:String) : void
      {
         this.currentAction = "usestratitem";
         var _loc3_:String = Items.getItemId(param2);
         if(_loc3_ == null)
         {
            this.onCmdFinshed(new ScriptError("Invalid item",-9999));
            return;
         }
         ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(this.castleId,param1);
         if(_loc3_ == Items.getItemId("Advance_by_A_Hidden_Path"))
         {
            this.setCmdResponse(ResponseDispatcher.SHOP_USE_TRICK_ITEM,this.useAdvByHiddenPathHandler);
         }
         else
         {
            this.setCmdResponse(ResponseDispatcher.SHOP_USE_TRICK_ITEM,this.handleCmdResponse);
         }
         ActionFactory.getInstance().getShopCommands().useTrickItem(param1,0,_loc3_);
      }
      
      private function trade(param1:String, param2:String, param3:Number, param4:Number) : void
      {
         if(this.cityManager.getBuildingLevel(BuildingConstants.TYPE_MARKET) == 0)
         {
            this.logCmdResponse("Cannot process the transaction because this city has no Market.");
            this.onCmdFinshed(true);
            return;
         }
         param2 = param2.toLowerCase();
         if(param2 == "wood")
         {
            param2 = "lumber";
         }
         var _loc5_:Array = new Array("food","lumber","stone","iron");
         var _loc6_:int = int(_loc5_.indexOf(param2));
         param1 = param1.toLowerCase();
         if(param1 != "buy" && param1 != "sell")
         {
            this.logCmdResponse("trade type " + param1 + " must be buy or sell");
         }
         else if(_loc6_ != -1)
         {
            if(isNaN(param3) || param3 <= 0 || param3 > TRADELIMIT)
            {
               this.logCmdResponse("Invalid amount, must be from 1 to " + TRADELIMIT);
            }
            else if(param4 < 0)
            {
               this.logCmdResponse("Invalid price, must be a positive number");
            }
            else if(param3 < param4)
            {
               this.logCmdResponse("The trading amount " + param3 + " is too small");
            }
            else
            {
               if(param4 >= 10)
               {
                  param4 = int(param4 * 100) / 100;
               }
               else
               {
                  param4 = int(param4 * 1000) / 1000;
               }
               if(param1 == "buy")
               {
                  this.onCmdResult("Buy " + _loc5_[_loc6_] + ": " + param3 + " at price " + param4);
                  this.setCmdResponse(ResponseDispatcher.TRADE_NEW_TRADE,this.handleCmdResponse);
                  CityStateCommands.newTrade(this.castleId,_loc6_,TradeConstants.TRADE_TYPE_BUY,param3,"" + param4);
                  return;
               }
               if(param1 == "sell")
               {
                  this.onCmdResult("Sell " + _loc5_[_loc6_] + ": " + param3 + " at price " + param4);
                  this.setCmdResponse(ResponseDispatcher.TRADE_NEW_TRADE,this.handleCmdResponse);
                  CityStateCommands.newTrade(this.castleId,_loc6_,TradeConstants.TRADE_TYPE_SELL,param3,"" + param4);
                  return;
               }
            }
         }
         else
         {
            this.logCmdResponse("Invalid resource, must be among " + _loc5_.join(" "));
         }
         this.onCmdFinshed(true);
      }
      
      public function get lag() : Number
      {
         return this.cityManager._getMarketLag();
      }
      
      private function _lx19(param1:String) : TroopBean
      {
         return Utils.getTroops(param1);
      }
      
      private function unBlockPlayerResponseHandler(param1:FriendResponse) : void
      {
         if(param1.ok != 1)
         {
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(new ScriptError(param1.errorMsg,param1.ok));
            return;
         }
         var _loc2_:PlayerInfoBean = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.player.blockBeansArray.length)
         {
            if(this.player.blockBeansArray[_loc3_].userName.toLowerCase() == this.friendBlockPlayerName.toLowerCase())
            {
               _loc2_ = this.player.blockBeansArray.removeItemAt(_loc3_) as PlayerInfoBean;
               break;
            }
            _loc3_++;
         }
         var _loc4_:* = "";
         if(_loc2_ != null)
         {
            _loc4_ = "Player \"" + _loc2_.userName + "\" was successfully removed from your Block Players List.";
         }
         else
         {
            _loc4_ = "Player \"" + this.friendBlockPlayerName + "\" not found in your Block Players List. Check spelling before trying again. No action taken.";
         }
         this.cityManager.logMsg(_loc4_);
         this.friendBlockPlayerName = null;
         this.onCmdFinshed(true);
      }
      
      private function colonize(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "colonize";
         this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE,param1,param2,param3,null,param4);
      }
      
      private function excercise(param1:TroopBean, param2:TroopBean) : void
      {
         this.onCmdResult("Excercise: " + Utils.troopBeanToMsgString(param1) + " v.s. " + Utils.troopBeanToMsgString(param2));
         this.setCmdResponse(ResponseDispatcher.ARMY_EXERCISE_ARMY,this._fq231);
         ActionFactory.getInstance().getArmyCommands().exerciseArmy(this.castleId,param1,param2);
      }
      
      public function _getScriptCmd(param1:String) : ScriptCmd
      {
         if(this.scriptCmds == null)
         {
            this.setScriptCmds();
         }
         if(this.scriptCmds[param1] != undefined)
         {
            return this.scriptCmds[param1] as ScriptCmd;
         }
         return null;
      }
      
      private function waitTurn() : void
      {
         this.waitForCmActive(this.onCmdFinshed,[true]);
      }
      
      private function chatAc(param1:String) : void
      {
         this.currentAction = "sendAllianceChatMessage";
         ActionFactory.getInstance().getCommonCommands().allianceChat(param1,0,this.chatHandler);
         this.onCmdFinshed(true);
      }
      
      public function getTechLevels() : Object
      {
         return this.m_techLevels;
      }
      
      private function fncSetMayorByName(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:HeroBean = null;
         _loc2_ = false;
         if(param1 == "none")
         {
            this.onCmdResult("Remove mayor");
            CityStateCommands.dischargeChief(this.castleId);
            return true;
         }
         _loc3_ = this.findHeroByName(param1);
         if(_loc3_ == null)
         {
            this.logCmdResponse("You dont even have a hero named " + param1,"");
         }
         else if(_loc3_.status == CityStateConstants.HERO_STATUS_IDLE)
         {
            _loc2_ = true;
            this.onCmdResult("Promoted " + param1 + " to mayor","");
            CityStateCommands.promoteToChief(this.castleId,_loc3_.id);
         }
         else if(_loc3_.status == CityStateConstants.HERO_STATUS_MAYOR)
         {
            _loc2_ = true;
            this.logCmdResponse("Hero " + param1 + " is already mayor","");
         }
         else
         {
            this.logCmdResponse("Hero " + param1 + " is not idle","");
         }
         return _loc2_;
      }
      
      private function setFocus() : void
      {
         this.currentAction = "setfocus";
         this.onCmdResult("Focus will be set to " + this.castle.name + "(" + this.coord + ")");
         this.cityManager._reserveEmergencyTimeSlot(true);
         this.onCmdFinshed(true);
      }
      
      private function scanMap(param1:int, param2:Number, param3:Boolean = false) : void
      {
         var cx:int = 0;
         var cy:int = 0;
         var handler:Function = null;
         var timer:Timer = null;
         var center:int = param1;
         var r:Number = param2;
         var useFastScan:Boolean = param3;
         this.currentAction = "scanmap";
         this.pleaseStop = false;
         cx = Map.getX(center);
         cy = Map.getY(center);
         handler = function(param1:TimerEvent):void
         {
            timer.delay = 500;
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdFinshed(true);
               return;
            }
            if(Map.isMapReady(cx,cy,r,true))
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdResult("SCAN MAP COMPLETED " + Map.fieldIdToCoordString(center) + " radius " + r);
               onCmdFinshed(true);
            }
         };
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function valleyTroops(param1:TroopBean) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "valleytroops";
         this.cityManager._setValleyTroops(Utils.troopBeanToMsgString(param1));
         this.onCmdFinshed(true);
      }
      
      private function findPlayerValleys(param1:String, param2:int, param3:Number, param4:int = 8) : void
      {
         this.currentAction = "findplayervalleys";
         this.cityManager._findPlayerValleys(param1.replace("-"," "),param2,param3,param4);
         this.onCmdFinshed(true);
      }
      
      private function research(param1:String) : void
      {
         if(Version.isTraceOn())
         {
            trace("create - verify research");
         }
         if(this.cityManager.getResearchInProgress() == null)
         {
            this.doResearch(param1);
            return;
         }
         this.onCmdResult("Waiting for current tech to complete...");
         this.waitResearch(this.doResearch,[param1]);
      }
      
      private function doComfortByName(param1:String) : void
      {
         switch(param1.toLowerCase().substr(0,2))
         {
            case "di":
            case "re":
               this.doComfortByType(CityStateConstants.COMFORT_RELIEF);
               break;
            case "pr":
               this.doComfortByType(CityStateConstants.COMFORT_PRAY);
               break;
            case "bl":
               this.doComfortByType(CityStateConstants.COMFORT_BLESS);
               break;
            case "po":
               this.doComfortByType(CityStateConstants.COMFORT_POPULATION_RAISE);
               break;
            default:
               this.onCmdFinshed(new ScriptError("Unknown comfort type: " + param1 + "  Must be one of the following: " + CityStateConstants.COMFORT_RELIEF + ", " + CityStateConstants.COMFORT_PRAY + ", " + CityStateConstants.COMFORT_BLESS + ", " + CityStateConstants.COMFORT_POPULATION_RAISE + "  or  relief, pray, bless, pop",-9999));
         }
      }
      
      private function enemyWarningIgnoreList(param1:String) : void
      {
         this.currentAction = "";
         this.printGoalCommandWarning();
         if(!this.cityManager._setEnemyWarningIgnoreLists(param1))
         {
            this.onCmdFinshed(new ScriptError("Parameter error for command enemywarningignoreList",-9999));
         }
         else
         {
            this.onCmdFinshed(true);
         }
         this.onCmdFinshed(true);
      }
      
      private function upgrade2(param1:String = "*", param2:String = "LowestLevel", param3:Boolean = false) : void
      {
         var _loc4_:int = BuildingType.fromString(param1);
         if(_loc4_ == -1)
         {
            this.onCmdFinshed(new ScriptError("Invalid building",-9999));
            return;
         }
         this.currentAction = "upgrade";
         var _loc5_:BuildingBean = BuildSelectionPolicy.findByPolicy(this.castle.buildingsArray.toArray(),param1,param2,9);
         if(_loc5_ == null)
         {
            this.onCmdFinshed(new ScriptError("Unable to perform upgrade. Unable to find " + param1 + ". Upgrade level 9 buildings must explicitly specified with level9 build policy",ErrorCode.ERROR_BUILDING_POSITION));
            return;
         }
         if(param3)
         {
            this.onCmdResult("Queue upgrading of building " + BuildingType.toString(_loc4_) + " at location " + _loc5_.positionId);
            this.setCmdResponse(ResponseDispatcher.CASTLE_NEW_BUILDING_QUEUE,this.handleCmdResponse);
         }
         else
         {
            this.onCmdResult("Starting upgrade of " + BuildingType.toString(_loc4_) + " at location " + _loc5_.positionId);
            if(Version.isTraceOn())
            {
               trace("setup upgrade response callbacks");
            }
            this.setCmdResponse(ResponseDispatcher.CASTLE_UPGRADE_BUILDING,this.buildCmdHandler);
         }
         CityStateCommands.upgradeBuilding(this.castleId,_loc5_.positionId,null,param3);
         if(Version.isTraceOn())
         {
            trace("upgrading " + _loc5_.name + ", position " + _loc5_.positionId + " on castle " + this.castle.name);
         }
      }
      
      private function fortificationGoal(param1:FortificationsBean) : void
      {
         this.printGoalCommandWarning();
         this.cityManager._io1033(param1);
         this.onCmdFinshed(true);
      }
      
      private function buyTo(param1:String, param2:Number, param3:Number, param4:Number = 0) : void
      {
         this.currentAction = "buyto";
         this.tradeTo("buy",param1,param2,param3,param4);
      }
      
      private function handleGetColonyOverviewResponse(param1:OverviewColonyCastleRespone) : void
      {
         var _loc3_:HeroBean = null;
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError("Error received: " + param1.errorMsg,-9999));
            return;
         }
         this.onCmdResult("Colony resource: g:" + Utils.abbrNum(param1.castleBean.resource.gold) + " f:" + Utils.abbrNum(param1.castleBean.resource.food.amount) + " w:" + Utils.abbrNum(param1.castleBean.resource.wood.amount) + " s:" + Utils.abbrNum(param1.castleBean.resource.stone.amount) + " i:" + Utils.abbrNum(param1.castleBean.resource.iron.amount));
         this.onCmdResult("Colony troop: " + Utils.troopStrBeanToMsgString(param1.castleBean.strTroop,false));
         var _loc2_:String = "";
         for each(_loc3_ in param1.castleBean.herosArray)
         {
            _loc2_ += " " + Utils.heroBeanToString(_loc3_);
         }
         this.onCmdResult("Colony heroes: " + _loc2_);
         this.onCmdFinshed(true);
      }
      
      private function _fg506(param1:TroopBean) : void
      {
         this.valleyTroops(param1);
      }
      
      private function listPackages() : void
      {
         this.currentAction = "listGiftPackages";
         ActionFactory.getInstance().getCommonCommands().getPackageList(this.listPackagesResponse);
      }
      
      private function aBigColonize(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "abigcolonize";
         this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE,param1,param2,param3,null,param4,true,false,2,null);
      }
      
      private function changeHeroName(param1:String, param2:String) : void
      {
         var _loc3_:HeroBean = null;
         var _loc4_:HeroBean = null;
         _loc3_ = null;
         this.currentAction = "changeheroname";
         for each(_loc4_ in this.castle.herosArray)
         {
            if(_loc4_.name.toLowerCase() == param1.toLowerCase())
            {
               _loc3_ = _loc4_;
            }
         }
         if(_loc3_ != null)
         {
            if(_loc4_.status == CityStateConstants.HERO_STATUS_IDLE || _loc4_.status == CityStateConstants.HERO_STATUS_MAYOR)
            {
               this.setCmdResponse(ResponseDispatcher.HERO_CHANGE_NAME,this.handleCmdResponse);
               this.onCmdResult("Changing name on hero " + param1 + " to " + param2);
               CityStateCommands.changeName(this.castleId,_loc3_.id,param2);
            }
            else
            {
               this.onCmdFinshed(new ScriptError("The status of the specified hero is not available/free.",-9999));
            }
         }
         else
         {
            this.onCmdFinshed(new ScriptError("You failed to specify a valid hero",-9999));
         }
      }
      
      private function verbose(param1:String) : void
      {
         if(param1.toLowerCase() == "on")
         {
            this.verboseLogs = true;
         }
         else
         {
            this.verboseLogs = false;
         }
         this.onCmdFinshed(true);
      }
      
      private function resetGoals() : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "resetgoals";
         this.cityManager._resetCMVariables();
         this.onCmdFinshed(true);
      }
      
      private function heroRecall(param1:String) : void
      {
         var _loc2_:HeroBean = this.findHeroByName(param1);
         if(_loc2_ == null)
         {
            this.onCmdResult("Unable to find hero: " + param1);
            this.onCmdFinshed(true);
            return;
         }
         this.onCmdResult("Recalling hero " + param1);
         this.setCmdResponse(ResponseDispatcher.HERO_CALL_BACK_HERO,this.handleCmdResponse);
         CityStateCommands.callBackHero(this.castleId,_loc2_.id);
      }
      
      private function donateQuest(param1:int) : void
      {
         this.currentAction = "donatequest";
         this.setCmdResponse(ResponseDispatcher.QUEST_DONATE,this.handleCmdResponse);
         ActionFactory.getInstance().getQuestCommands().donate(param1,this.castleId);
      }
      
      public function getItemName(param1:String) : String
      {
         return Items.getItemName(param1);
      }
      
      private function logCmdResponse(param1:Object, param2:String = "", param3:String = "#FF0000") : void
      {
         dispatchEvent(new CityStateResponseEvent(param1,param2,param3));
      }
      
      private function chatBc(param1:String) : void
      {
         this.currentAction = "sendBeginnerChatMessage";
         ActionFactory.getInstance().getCommonCommands().channelChat(CommonConstants.CHAT_CHANNEL_BEGINNER,param1,0,this.chatHandler);
         this.onCmdFinshed(true);
      }
      
      private function currentActiveBuilding() : BuildingBean
      {
         var _loc2_:String = null;
         var _loc1_:BuildingBean = null;
         for(_loc2_ in this.castle.buildingsArray)
         {
            if(this.castle.buildingsArray[_loc2_].status != BuildingConstants.STATUS_NORMAL)
            {
               _loc1_ = this.castle.buildingsArray[_loc2_];
               break;
            }
         }
         return _loc1_;
      }
      
      public function getValue(param1:String, param2:String, param3:String = null, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = null, param10:String = null, param11:String = null, param12:String = null, param13:String = null, param14:String = null, param15:String = null, param16:String = null, param17:String = null) : *
      {
         var type:String = param1;
         var data:String = param2;
         var d2:String = param3;
         var d3:String = param4;
         var d4:String = param5;
         var d5:String = param6;
         var d6:String = param7;
         var d7:String = param8;
         var d8:String = param9;
         var d9:String = param10;
         var d10:String = param11;
         var d11:String = param12;
         var d13:String = param13;
         var d14:String = param14;
         var d15:String = param15;
         var d16:String = param16;
         var d17:String = param17;
         data = data + (d2 != null ? "," + d2 : "") + (d3 != null ? "," + d3 : "") + (d4 != null ? "," + d4 : "") + (d5 != null ? "," + d5 : "") + (d6 != null ? "," + d6 : "") + (d7 != null ? "," + d7 : "") + (d8 != null ? "," + d8 : "") + (d9 != null ? "," + d9 : "") + (d10 != null ? "," + d10 : "") + (d11 != null ? "," + d11 : "") + (d13 != null ? "," + d13 : "") + (d14 != null ? "," + d14 : "") + (d15 != null ? "," + d15 : "") + (d16 != null ? "," + d16 : "") + (d17 != null ? "," + d17 : "");
         if(type == "String")
         {
            return data;
         }
         if(type == "Boolean")
         {
            return data == "true";
         }
         if(type == "Number")
         {
            return Utils.removeAbbr(data);
         }
         if(type == "int")
         {
            return int(Utils.removeAbbr(data));
         }
         if(type == "XML")
         {
            try
            {
               return new XML(data);
            }
            catch(e:Error)
            {
               throw new Error("FATAL ERROR: Invalid type " + type + " in getValue(), invalid XML or XML that is not well formed");
            }
         }
         else
         {
            if(type == "Coordinate")
            {
               return Map.coordStringToFieldId(data);
            }
            if(type == "Resource")
            {
               return data != "none" ? Utils.getEstResoBean(data) : null;
            }
            if(type == "Fortification")
            {
               return data != "none" ? Utils.getFortifications(data) : null;
            }
            if(type == "Troop")
            {
               return data != "none" ? Utils.getTroops(data) : null;
            }
            throw new Error("FATAL ERROR: Invalid type " + type + " in getValue(), must be String, Boolean, Number, int, XML, Coordinate, Resource, Fortification, Troop");
         }
      }
      
      private function clearWallQueue(param1:int = 1) : void
      {
         this.currentAction = "cleartroopqueues";
         this.cityManager._clearWallQueue(param1);
         this.onCmdFinshed(true);
      }
      
      private function monitorPrestige(param1:String, param2:Boolean = false, param3:int = 30) : void
      {
         var counter:int;
         var lastPrest:int = 0;
         var lastPopChange:int = 0;
         var lastPop:int = 0;
         var lastTime:Number = NaN;
         var date:Date = null;
         var result:Array = null;
         var callBack:Function = null;
         var handler:Function = null;
         var timer:Timer = null;
         var nick:String = param1;
         var popChecked:Boolean = param2;
         var maxResultCount:int = param3;
         this.currentAction = "monitorprestige";
         this.pleaseStop = false;
         lastPrest = -1;
         lastPopChange = -1;
         lastPop = -1;
         counter = 0;
         lastTime = -1;
         date = new Date();
         result = new Array();
         nick = nick.split("-").join(" ");
         callBack = function(param1:PlayerInfoResponse):void
         {
            if(param1.ok != 1)
            {
               logCmdResponse("Error retrieving player info: " + param1.errorMsg);
               onCmdFinshed(true);
               return;
            }
            if(param1.playerInfo.userName.toLowerCase() != nick.toLowerCase())
            {
               return;
            }
            if(lastPrest == -1)
            {
               lastPrest = param1.playerInfo.prestige;
               lastPop = param1.playerInfo.population;
               if(lastPopChange == -1)
               {
                  lastPopChange = param1.playerInfo.population - lastPop;
               }
               lastTime = Utils.getServerTime();
               date.setTime(lastTime);
               cityManager.logMsg("Monitor player: <b>" + nick + "</b>   starting Prestige: <b>" + lastPrest + "</b>");
               return;
            }
            if(param1.playerInfo.prestige == lastPrest && (!popChecked || param1.playerInfo.population == lastPop))
            {
               if(Utils.getServerTime() - lastTime > 3 * 60 * 1000)
               {
                  lastTime = Utils.getServerTime();
                  cityManager.logMsg("Monitor player: <b>" + nick + "</b>   last Prestige: <b>" + lastPrest + "</b> " + result.join("  |  "),"#00CF00");
               }
               return;
            }
            if(param1.playerInfo.prestige - lastPrest != 0 || popChecked && param1.playerInfo.population - lastPop != 0)
            {
               if(popChecked)
               {
                  result.unshift("@" + date.getHours() + ":" + Utils.format2(date.getMinutes()) + " " + (param1.playerInfo.prestige - lastPrest > 0 ? "+" : "") + (param1.playerInfo.prestige - lastPrest) + ":" + (param1.playerInfo.population - lastPop > 0 ? "+" : "") + (param1.playerInfo.population - lastPop));
               }
               else
               {
                  result.unshift("@" + date.getHours() + ":" + Utils.format2(date.getMinutes()) + " " + (param1.playerInfo.prestige - lastPrest > 0 ? "+" : "") + (param1.playerInfo.prestige - lastPrest));
               }
            }
            var _loc2_:int = result.length - maxResultCount;
            if(_loc2_ > 0)
            {
               result.splice(result.length - _loc2_,_loc2_);
            }
            if(param1.playerInfo.prestige - lastPrest != 0 || popChecked && Math.abs(lastPopChange - (param1.playerInfo.population - lastPop)) > 1)
            {
               cityManager.logMsg("Monitor player: <b>" + nick + "</b>  Change detected  Last pres: <b>" + lastPrest + "</b>  Now pres: <b>" + param1.playerInfo.prestige + "</b>  New results: " + result.join("  |  "),"#EE0000");
            }
            else if(Utils.getServerTime() - lastTime > 3 * 60 * 1000)
            {
               lastTime = Utils.getServerTime();
               cityManager.logMsg("Monitor player: <b>" + nick + "</b>  No change  Pres: <b>" + lastPrest + "</b>  Results: " + result.join("  |  "),"#00CF00");
            }
            lastPrest = param1.playerInfo.prestige;
            lastPopChange = param1.playerInfo.population - lastPop;
            lastPop = param1.playerInfo.population;
            lastTime = Utils.getServerTime();
            date.setTime(lastTime);
         };
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
               timer = null;
               onCmdResult("Done monitoring player: " + nick + "   last Prestige: " + lastPrest + " " + result.join("  |  "),"","#00CF00");
               return;
            }
            timer.delay = 10000 + Utils.getRandomInt(0,10000);
            if(counter++ % 6 != 0)
            {
               return;
            }
            if(!Connection.getInstance().authenticated)
            {
               return;
            }
            ActionFactory.getInstance().getCommonCommands().getPlayerInfoByName(nick,callBack);
         };
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function dumpTroop(param1:int, param2:TroopBean, param3:TroopBean) : void
      {
         this.currentAction = "dump troop";
         this.cityManager._jt504(param1,param2,param3);
         Utils.callLater(1500,this.onCmdFinshed,[true]);
      }
      
      private function handleQuestListResponse(param1:QuestListResponse) : void
      {
         var _loc4_:QuestBean = null;
         var _loc5_:QuestTargetBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            scriptQuestActive = false;
            this.onCmdFinshed(new ScriptError("Error executing completequests: " + param1.errorMsg,param1.ok));
            return;
         }
         if(Version.isTraceOn())
         {
            trace("Enter awardQuests");
         }
         var _loc2_:String = "";
         var _loc3_:int = int(new Array("Lieutenant","Captain","Major","Colonel","General").indexOf(this.player.playerInfo.office));
         for each(_loc4_ in param1.questsArray)
         {
            if(Version.isTraceOn())
            {
               trace("Quest: " + _loc4_.description + " Finished: " + _loc4_.isFinish + " Award: " + _loc4_.award);
            }
            if(_loc4_.isFinish)
            {
               if(_loc3_ >= this.player.playerInfo.titleId && _loc4_.award != null && _loc4_.award.indexOf("Rank") != -1)
               {
                  this.onCmdResult("Skipping rank quest " + _loc4_.name + " due to low title");
               }
               else
               {
                  this.onCmdResult(_loc4_.name + " quest complete."," Award item(s): " + _loc4_.award);
                  ActionFactory.getInstance().getQuestCommands().award(this.castleId,_loc4_.questId);
               }
            }
            else if(_loc4_.award.indexOf("Rank") != -1 || _loc4_.award.indexOf("Title") != -1)
            {
               _loc2_ = "";
               for each(_loc5_ in _loc4_.targetsArray)
               {
                  if(!_loc5_.finished)
                  {
                     _loc2_ += " " + _loc5_.name;
                  }
               }
               this.onCmdResult("Current promotion quest: " + _loc4_.name + ", need: " + _loc2_);
            }
            else if(_loc4_.name.indexOf("Donation") == 0)
            {
               this.onCmdResult("donatequest " + _loc4_.questId + " available: " + _loc4_.manual);
            }
            else if(_loc4_.name.indexOf("Queen") == 0)
            {
               this.onCmdResult("Current queen quest: " + _loc4_.manual);
            }
         }
         --findQuestCount;
         if(findQuestCount <= 0)
         {
            findQuestCastleId = 0;
            scriptQuestActive = false;
            this.onCmdFinshed(true);
         }
      }
      
      private function _gv907(param1:TroopBean) : void
      {
         this.npcTroop(param1);
      }
      
      private function changePlayerNick(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null) : void
      {
         this.currentAction = "changePlayerNick";
         param1 = param1 + (param2 != null ? " " + param2 : "") + (param3 != null ? " " + param3 : "") + (param4 != null ? " " + param4 : "") + (param5 != null ? " " + param5 : "");
         if(Utils.specialCharFilter(param1) || Utils.isBadWord(param1))
         {
            this.onCmdFinshed(new ScriptError("Name Error: \'" + param1 + "\' contains restricted characters or bad words.",-9999));
            return;
         }
         ActionFactory.getInstance().getCityCommands().modifyUserName(param1,"player.name.1.a",this.changePlayerNickResponse);
      }
      
      public function findHeroById(param1:int) : HeroBean
      {
         var _loc2_:HeroBean = null;
         if(!isNaN(param1))
         {
            for each(_loc2_ in this.cityManager.heroes)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function resourceLimits(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "resourcelimits";
         this.cityManager.processRresourceLimits("" + param1 + " " + param2 + " " + param3 + " " + param4);
         this.onCmdFinshed(true);
      }
      
      private function buildComplete(param1:BuildComplate) : void
      {
         if(this.castleId != param1.castleId)
         {
            return;
         }
         this.updateBuildingBean(param1.buildingBean);
         if(param1.buildingBean.status != BuildingConstants.STATUS_NORMAL)
         {
            if(this.currentAction == "demo" || this.currentAction == "create" || this.currentAction == "upgrade")
            {
               this.onCmdResult(param1,this.currentAction);
            }
         }
      }
      
      private function listItems(param1:String = "") : void
      {
         var _loc4_:ItemBean = null;
         this.currentAction = "listitems";
         var _loc2_:String = null;
         var _loc3_:String = "";
         param1 = param1.toLowerCase();
         for each(_loc4_ in this.player.itemsArray)
         {
            if(_loc4_.id != null)
            {
               _loc2_ = Items.getItemName(_loc4_.id);
               if(_loc2_.toLowerCase().replace(/\’/g,"\'").indexOf(param1.replace(/\’/g,"\'")) != -1)
               {
                  _loc3_ += (_loc3_ != "" ? ",  " : "") + _loc4_.count + " " + _loc2_;
               }
            }
         }
         this.cityManager.logMsg("<b>Items:</b>   " + _loc3_);
         if(param1 == "")
         {
            this.onCmdResult("Consider using \'listitem filter\', for example \'listitem guide\', to restrict result");
         }
         this.onCmdFinshed(true);
      }
      
      private function comfort(param1:String) : void
      {
         this.currentAction = "comfort";
         this.onCmdResult("Starting",this.currentAction);
         if(int(param1) != 0)
         {
            if(int(param1) >= CityStateConstants.COMFORT_RELIEF && int(param1) <= CityStateConstants.COMFORT_POPULATION_RAISE)
            {
               this.doComfortByType(int(param1));
            }
            else
            {
               this.onCmdFinshed(new ScriptError("Unknown comfort type: " + param1 + "  Must be one of the following: " + CityStateConstants.COMFORT_RELIEF + ", " + CityStateConstants.COMFORT_PRAY + ", " + CityStateConstants.COMFORT_BLESS + ", " + CityStateConstants.COMFORT_POPULATION_RAISE + "  or  relief, pray, bless, pop",-9999));
            }
         }
         else
         {
            this.doComfortByName(param1);
         }
         this.onCmdResult(this.currentAction,"complete");
      }
      
      private function buildCmdHandler(param1:CommandResponse) : void
      {
         if(!(this.currentAction == "demo" || this.currentAction == "create" || this.currentAction == "upgrade"))
         {
            return;
         }
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError("Error executing build command: " + param1.errorMsg,param1.ok));
         }
         else
         {
            this.onCmdFinshed(true);
         }
      }
      
      private function blockPlayer(param1:String) : void
      {
         var _loc2_:PlayerInfoBean = null;
         var _loc3_:PlayerInfoBean = null;
         this.currentAction = "block player";
         for each(_loc2_ in this.player.friendBeansArray)
         {
            if(_loc2_.userName.toLowerCase() == param1.toLowerCase())
            {
               this.onCmdFinshed(new ScriptError("Player \"" + _loc2_.userName + "\" is in your Friends List. Run \"unfriendplayer " + _loc2_.userName + "\" before trying to block the player.",-9999));
               return;
            }
         }
         for each(_loc3_ in this.player.blockBeansArray)
         {
            if(_loc3_.userName.toLowerCase() == param1.toLowerCase())
            {
               this.cityManager.logMsg("Player <font color=\'#CC0000\'>\"" + _loc3_.userName + "\"</font> is already in your Block Players List. No action taken.");
               this.onCmdFinshed(true);
               return;
            }
         }
         this.friendBlockPlayerName = param1;
         ActionFactory.getInstance().getFriendCommands().addBlock(param1,this.blockPlayerResponseHandler);
      }
      
      private function cityHasEnoughTroops(param1:TroopBean) : Boolean
      {
         var _loc2_:String = "insufficent troops:";
         var _loc3_:Boolean = true;
         if(param1.archer > this.castle.troop.archer)
         {
            _loc2_ += " archer :(" + (param1.archer - this.castle.troop.archer) + ")";
            _loc3_ = false;
         }
         if(param1.ballista > this.castle.troop.ballista)
         {
            _loc2_ += " ballista :(" + (param1.ballista - this.castle.troop.ballista) + ")";
            _loc3_ = false;
         }
         if(param1.batteringRam > this.castle.troop.batteringRam)
         {
            _loc2_ += " ram :(" + (param1.batteringRam - this.castle.troop.batteringRam) + ")";
            _loc3_ = false;
         }
         if(param1.carriage > this.castle.troop.carriage)
         {
            _loc2_ += " transport :(" + (param1.carriage - this.castle.troop.carriage) + ")";
            _loc3_ = false;
         }
         if(param1.catapult > this.castle.troop.catapult)
         {
            _loc2_ += " catapult :(" + (param1.catapult - this.castle.troop.catapult) + ")";
            _loc3_ = false;
         }
         if(param1.heavyCavalry > this.castle.troop.heavyCavalry)
         {
            _loc2_ += " cataphract :(" + (param1.heavyCavalry - this.castle.troop.heavyCavalry) + ")";
            _loc3_ = false;
         }
         if(param1.lightCavalry > this.castle.troop.lightCavalry)
         {
            _loc2_ += " cavalry :(" + (param1.lightCavalry - this.castle.troop.lightCavalry) + ")";
            _loc3_ = false;
         }
         if(param1.militia > this.castle.troop.militia)
         {
            _loc2_ += " warrior :(" + (param1.militia - this.castle.troop.militia) + ")";
            _loc3_ = false;
         }
         if(param1.peasants > this.castle.troop.peasants)
         {
            _loc2_ += " worker :(" + (param1.peasants - this.castle.troop.peasants) + ")";
            _loc3_ = false;
         }
         if(param1.pikemen > this.castle.troop.pikemen)
         {
            _loc2_ += " pike :(" + (param1.pikemen - this.castle.troop.pikemen) + ")";
            _loc3_ = false;
         }
         if(param1.scouter > this.castle.troop.scouter)
         {
            _loc2_ += " scout :(" + (param1.scouter - this.castle.troop.scouter) + ")";
            _loc3_ = false;
         }
         if(param1.swordsmen > this.castle.troop.swordsmen)
         {
            _loc2_ += " sword :(" + (param1.swordsmen - this.castle.troop.swordsmen) + ")";
            _loc3_ = false;
         }
         if(!_loc3_ && this.verboseLogs)
         {
            this.logCmdResponse("TroopError",_loc2_);
         }
         return _loc3_;
      }
      
      private function getGearTypeString(param1:int) : String
      {
         return param1 == 0 ? "none" : (param1 == 1 ? "pol" : (param1 == 2 ? "atk" : (param1 == 3 ? "int" : null)));
      }
      
      private function waitNoResearch() : void
      {
         this.waitResearch(this.onCmdFinshed,[true]);
      }
      
      private function handleDecWar(param1:MapCastleBean) : void
      {
         if(param1 == null)
         {
            this.onCmdResult("Unable to obtain map info, please try again");
            this.onCmdFinshed(true);
         }
         else if(param1.canDeclaredWar)
         {
            this.setCmdResponse(ResponseDispatcher.COMMON_DECLARED_WAR_AGAINST_PLAYER,this.handleCmdResponse);
            this.onCmdResult("Declare war against " + Map.fieldIdToString(param1.id) + " " + param1.userName);
            ActionFactory.getInstance().getCommonCommands().declaredWarAgainstPlayer(param1.ownerPlayerId);
         }
         else
         {
            this.onCmdResult("Unable to declare war against " + Map.fieldIdToString(param1.id));
            this.onCmdFinshed(true);
         }
      }
      
      public function getItemInfo(param1:String) : ItemEum
      {
         return Items.externalItemNames[Items.getItemId(param1)];
      }
      
      private function onGetResearchListResponse(param1:AvailableResearchListResponse) : void
      {
         var _loc2_:AvailableResearchListBean = null;
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError("Error getting research list: " + param1.errorMsg,param1.ok));
            return;
         }
         for each(_loc2_ in param1.acailableResearchBeansArray)
         {
            this.m_techLevels[_loc2_.typeId + ""] = _loc2_.avalevel;
            if(_loc2_.castleId == this.castleId && _loc2_.upgradeing)
            {
               this.currentResearch = _loc2_;
            }
         }
      }
      
      private function setCmdResponse(param1:String, param2:Function) : void
      {
         if(Version.isTraceOn())
         {
            trace("setCommandResponse for " + param1);
         }
         this.events.addItem(new EventHandler(param1,param2));
         ResponseDispatcher.getInstance().addEventListener(param1,param2);
      }
      
      private function evacuateTown(param1:int, param2:Boolean = false) : void
      {
         this.currentAction = "evacuatetown";
         if(param2 == "true")
         {
            this.onCmdResult("Evacuate troops only, resource must be moved manually");
            this.cityManager._ov14(param1,true);
         }
         else
         {
            this.cityManager._ov14(param1,false);
         }
         this.onCmdFinshed(true);
      }
      
      public function _getScriptCmds() : Object
      {
         if(this.scriptCmds == null)
         {
            this.setScriptCmds();
         }
         return this.scriptCmds;
      }
      
      private function wallDefense2(param1:String = "trap", param2:int = 1, param3:String = "build") : void
      {
         this.currentAction = "walldefense";
         var _loc4_:String = param1.substr(0,3).toLowerCase();
         var _loc5_:String = param3.substr(0,2).toLowerCase();
         var _loc6_:int = 0;
         if(_loc4_ == "tra" || _loc4_ == "trap")
         {
            _loc6_ = TFConstants.F_TRAP;
         }
         else if(_loc4_ == "ab" || _loc4_ == "aba")
         {
            _loc6_ = TFConstants.F_ABATIS;
         }
         else if(_loc4_ == "at" || _loc4_ == "arc" || _loc4_ == "tow")
         {
            _loc6_ = TFConstants.F_ARROWTOWER;
         }
         else if(_loc4_ == "r" || _loc4_ == "rol" || _loc4_ == "log")
         {
            _loc6_ = TFConstants.F_ROLLINGLOGS;
         }
         else
         {
            if(!(_loc4_ == "tre" || _loc4_ == "roc"))
            {
               throw new ScriptError("You failed to specify a valid fortification name.",-9999);
            }
            _loc6_ = TFConstants.F_ROCKFALL;
         }
         if(_loc5_ == "bu" || _loc5_ == "pr")
         {
            this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT,this.handleCmdResponse);
            while(param2 > 0 && (!this.cityManager._isEnoughSlotsOnWall(param2,_loc6_) || !this.cityManager._isEnoughResoToProduceFort(_loc6_,param2)))
            {
               param2 /= 1.01;
            }
            if(param2 == 0)
            {
               this.onCmdResult("No fortifications of type " + _loc4_ + " can be queued at this time.");
               this.onCmdFinshed(true);
               return;
            }
            this.onCmdResult("Queued " + param2 + " fortifications of type: " + _loc4_ + ".");
            CityStateCommands.produceWallProtect(this.castleId,_loc6_,param2);
            Utils.callLater(2000,this.cityManager.updateWallQueue);
            return;
         }
         if(_loc5_ == "de")
         {
            this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT,this.handleCmdResponse);
            if(this.cityManager.fortification != null && param2 > this.cityManager.fortification[Utils.troopIntNames[_loc6_]])
            {
               param2 = int(this.cityManager.fortification[Utils.troopIntNames[_loc6_]]);
            }
            this.onCmdResult("Destroyed " + param2 + " fortifications of type: " + _loc4_ + ".");
            CityStateCommands.destructWallProtect(this.castleId,_loc6_,param2);
            return;
         }
         throw new ScriptError("You failed to specify a valid constructType. Valid options are \'build/produce, demo/destruct\'.",-9999);
      }
      
      private function gatePolicy(param1:int, param2:int, param3:int, param4:int, param5:int = 0) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "gatepolicy";
         this.cityManager._setGatePolicy(param1 + " " + param2 + " " + param3 + " " + param4 + " " + param5);
         this.onCmdFinshed(true);
      }
      
      private function bigScout(param1:int, param2:String, param3:TroopBean, param4:String = "") : void
      {
         this.currentAction = "bigscout";
         this.doMarch(ObjConstants.ARMY_MISSION_SCOUT,param1,param2,param3,null,param4,true);
      }
      
      public function AnyIdleHero(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = null, param10:String = null) : Boolean
      {
         if(param2 != null)
         {
            param1 += "," + param2;
         }
         if(param3 != null)
         {
            param1 += "," + param3;
         }
         if(param4 != null)
         {
            param1 += "," + param4;
         }
         if(param5 != null)
         {
            param1 += "," + param5;
         }
         if(param6 != null)
         {
            param1 += "," + param6;
         }
         if(param7 != null)
         {
            param1 += "," + param7;
         }
         if(param8 != null)
         {
            param1 += "," + param8;
         }
         if(param9 != null)
         {
            param1 += "," + param9;
         }
         if(param10 != null)
         {
            param1 += "," + param10;
         }
         return this.getHeroByNameOrKey(param1) != null;
      }
      
      public function getDateFromTime(param1:Number) : Date
      {
         var d:Date = null;
         var time:Number = param1;
         d = new Date(time);
         d["toFormattedTimeString"] = function(param1:Boolean = false):String
         {
            return (d.hours < 10 ? "0" + d.hours : d.hours) + ":" + (d.minutes < 10 ? "0" + d.minutes : d.minutes) + ":" + (d.seconds < 10 ? "0" + d.seconds : d.seconds) + (param1 ? "." + d.milliseconds : "");
         };
         return d;
      }
      
      private function demo(param1:String = "*", param2:String = "HighestLevel") : void
      {
         if(Version.isTraceOn())
         {
            trace("demo - verify buildings");
         }
         if(this.cityManager._getCurrentConstruction() == null)
         {
            this.demo2(param1,param2);
            return;
         }
         this.onCmdResult("Waiting for current building to complete...");
         this.waitForBuildingQueue(this.demo2,[param1,param2]);
      }
      
      private function cancelBuildCity() : void
      {
         this.currentAction = "cancelbuildcity";
         this.cityManager._nk320();
         this.onCmdFinshed(true);
      }
      
      private function setScriptCmds() : void
      {
         this.scriptCmds = new Object();
         this.scriptCmds["calibrate"] = new ScriptCmd("calibrate",this.calibrate,new Array(),new Array(),0);
         this.scriptCmds["travelinfo"] = new ScriptCmd("travelinfo",this.travelInfo,new Array("target","troop","hero"),new Array("Coordinate","Troop","String"),2);
         this.scriptCmds["attack"] = new ScriptCmd("attack",this.attack,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["aattack"] = new ScriptCmd("aattack",this.aAttack,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["bigattack"] = new ScriptCmd("bigattack",this.bigAttack,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["abigattack"] = new ScriptCmd("abigattack",this.aBigAttack,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["colonize"] = new ScriptCmd("colonize",this.colonize,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["acolonize"] = new ScriptCmd("acolonize",this.aColonize,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["bigcolonize"] = new ScriptCmd("bigcolonize",this.bigColonize,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["abigcolonize"] = new ScriptCmd("abigcolonize",this.aBigColonize,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["scout"] = new ScriptCmd("scout",this.scout,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["ascout"] = new ScriptCmd("ascout",this.aScout,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["bigscout"] = new ScriptCmd("bigscout",this.bigScout,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["abigscout"] = new ScriptCmd("abigscout",this.aBigScout,new Array("target","hero","troop","campTime"),new Array("Coordinate","String","Troop","String"),3);
         this.scriptCmds["transport"] = new ScriptCmd("transport",this.transport,new Array("target","troop","resource","campTime"),new Array("Coordinate","Troop","Resource","String"),3);
         this.scriptCmds["bigtransport"] = new ScriptCmd("bigtransport",this.bigTransport,new Array("target","troop","resource","campTime"),new Array("Coordinate","Troop","Resource","String"),3);
         this.scriptCmds["reinforce"] = new ScriptCmd("reinforce",this.reinforce,new Array("target","hero","troop","resource","campTime"),new Array("Coordinate","String","Troop","Resource","String"),3);
         this.scriptCmds["bigreinforce"] = new ScriptCmd("bigreinforce",this.bigReinforce,new Array("target","hero","troop","resource","campTime"),new Array("Coordinate","String","Troop","Resource","String"),3);
         this.scriptCmds["deploy"] = new ScriptCmd("deploy",this.deploy,new Array("deployType","target","hero","troop","resource","campTime","useEnsign","useHordeBanner","autoGearType"),new Array("String","Coordinate","String","Troop","Resource","String","Boolean","Boolean","int"),4);
         this.scriptCmds["qdeploy"] = new ScriptCmd("qdeploy",this._qDeploy,new Array("deployType","target","hero","troop","resource","campTime","useEnsign","useHordeBanner","autoGearType"),new Array("String","Coordinate","String","Troop","Resource","String","Boolean","Boolean","int"),4);
         this.scriptCmds["qfarm"] = new ScriptCmd("qfarm",this.qFarm,new Array(),new Array(),0);
         this.scriptCmds["qbuildnpc"] = new ScriptCmd("qbuildnpc",this.qBuildNpc,new Array(),new Array(),0);
         this.scriptCmds["qall"] = new ScriptCmd("qall",this.qAll,new Array(),new Array(),0);
         this.scriptCmds["listmedals"] = new ScriptCmd("listmedals",this.listMedals,new Array(),new Array(),0);
         this.scriptCmds["listbuffs"] = new ScriptCmd("listbuffs",this.listBuffs,new Array(),new Array(),0);
         this.scriptCmds["listlocalbuffs"] = new ScriptCmd("listlocalbuffs",this.listLocalBuffs,new Array(),new Array(),0);
         this.scriptCmds["listitems"] = new ScriptCmd("listitems",this.listItems,new Array("filter"),new Array("String"),0);
         this.scriptCmds["cancelbuild"] = new ScriptCmd("cancelbuild",this.cancelBuild,new Array("position"),new Array("int"),0);
         this.scriptCmds["canceltech"] = new ScriptCmd("canceltech",this.cancelTech,new Array(),new Array(),0);
         this.scriptCmds["dumpresource"] = new ScriptCmd("dumpresource",this.dumpResource,new Array("target","condition","resource"),new Array("Coordinate","Resource","Resource"),3);
         this.scriptCmds["dumptroop"] = new ScriptCmd("dumptroop",this.dumpTroop,new Array("target","condition","troop"),new Array("Coordinate","Troop","Troop"),3);
         this.scriptCmds["buildcity"] = new ScriptCmd("buildcity",this.buildCity,new Array("location"),new Array("Coordinate"),1);
         this.scriptCmds["cancelbuildcity"] = new ScriptCmd("cancelbuildcity",this.cancelBuildCity,new Array(),new Array(),0);
         this.scriptCmds["capture"] = new ScriptCmd("capture",this.capture,new Array("location","numCav"),new Array("Coordinate","int"),2);
         this.scriptCmds["loyaltyattack"] = new ScriptCmd("loyaltyattack",this.loyaltyAttack,new Array("location","numCav"),new Array("Coordinate","int"),2);
         this.scriptCmds["healtroops"] = new ScriptCmd("healtroops",this.healTroops,new Array(),new Array(),0);
         this.scriptCmds["healtroops!"] = new ScriptCmd("healtroops!",this.healTroops2,new Array(),new Array(),0);
         this.scriptCmds["healtroops2"] = new ScriptCmd("healtroops2",this.healTroops2,new Array(),new Array(),0);
         this.scriptCmds["evacuatetown"] = new ScriptCmd("evacuatetown",this.evacuateTown,new Array("target","troopOnlyFlag"),new Array("Coordinate","Boolean"),1);
         this.scriptCmds["endevacuate"] = new ScriptCmd("endevacuate",this.endEvacuate,new Array(),new Array(),0);
         this.scriptCmds["abandontown"] = new ScriptCmd("abandontown",this.abandonTown,new Array(),new Array(),0);
         this.scriptCmds["abandontown!"] = new ScriptCmd("abandontown!",this.abandonTown2,new Array(),new Array(),0);
         this.scriptCmds["fieldattack"] = new ScriptCmd("fieldattack",this.fieldAttack,new Array("allianceList","center","radius","minLevel"),new Array("String","Coordinate","Number","int"),3);
         this.scriptCmds["findplayervalleys"] = new ScriptCmd("findplayervalleys",this.findPlayerValleys,new Array("playerList","center","radius","minLevel"),new Array("String","Coordinate","Number","int"),3);
         this.scriptCmds["attackplayervalleys"] = new ScriptCmd("attackplayervalleys",this.attackPlayerValleys,new Array("playerList","center","radius","minLevel"),new Array("String","Coordinate","Number","int"),3);
         this.scriptCmds["setnpcflag"] = new ScriptCmd("setnpcflag",this.setNpcFlag,new Array("location"),new Array("Coordinate"),1);
         this.scriptCmds["unsetnpcflag"] = new ScriptCmd("unsetnpcflag",this.unsetNpcFlag,new Array("location"),new Array("Coordinate"),1);
         this.scriptCmds["spamattack"] = new ScriptCmd("spamattack",this.spamAttack,new Array("location","troop","count"),new Array("Coordinate","Troop","int"),3);
         this.scriptCmds["honorattack"] = new ScriptCmd("honorattack",this.honorAttack,new Array("location","troop","maxHonorLost"),new Array("Coordinate","Troop","int"),3);
         this.scriptCmds["honorguard"] = new ScriptCmd("honorguard",this.honorGuard,new Array("location","troop","maxHonorLost"),new Array("Coordinate","Troop","int"),3);
         this.scriptCmds["attackwait"] = new ScriptCmd("attackwait",this.attackWait,new Array("waitType"),new Array("String"),1);
         this.scriptCmds["endfieldattack"] = new ScriptCmd("endfieldattack",this.endFieldAttack,new Array(),new Array(),0);
         this.scriptCmds["endspamattack"] = new ScriptCmd("endspamattack",this.endSpamAttack,new Array(),new Array(),0);
         this.scriptCmds["endloyaltyattack"] = new ScriptCmd("endloyaltyattack",this.endLoyaltyAttack,new Array(),new Array(),0);
         this.scriptCmds["endhonorattack"] = new ScriptCmd("endhonorattack",this.endHonorAttack,new Array(),new Array(),0);
         this.scriptCmds["endguardedattack"] = new ScriptCmd("endguardedattack",this.endGuardedAttack,new Array(),new Array(),0);
         this.scriptCmds["guardedattack"] = new ScriptCmd("guardedattack",this.guardedAttack,new Array("location","troop","nScouts","defenseCond","fortCond"),new Array("Coordinate","Troop","int","Troop","Fortification"),4);
         this.scriptCmds["setguard"] = new ScriptCmd("setguard",this.setGuard,new Array("location","defenseCond","fortCond"),new Array("Coordinate","Troop","Fortification"),2);
         this.scriptCmds["recall"] = new ScriptCmd("recall",this.recall,new Array("target"),new Array("Coordinate"),1);
         this.scriptCmds["recallall"] = new ScriptCmd("recallall",this.recallAll,new Array(),new Array(),0);
         this.scriptCmds["herorecall"] = new ScriptCmd("herorecall",this.heroRecall,new Array("heroName"),new Array("String"),1);
         this.scriptCmds["idrecall"] = new ScriptCmd("idrecall",this.idRecall,new Array("armyId"),new Array("int"),1);
         this.scriptCmds["cleartroopqueues"] = new ScriptCmd("cleartroopqueues",this.clearTroopQueues,new Array("remainBatchCount"),new Array("int"),0);
         this.scriptCmds["clearqueuetype"] = new ScriptCmd("clearqueuetype",this.clearQueueType,new Array("troopName"),new Array("String"),1);
         this.scriptCmds["clearwallqueue"] = new ScriptCmd("clearwallqueue",this.clearWallQueue,new Array("remainBatchCount"),new Array("int"),0);
         this.scriptCmds["persuadehero"] = new ScriptCmd("persuadehero",this.persuadeHero,new Array("hero"),new Array("String"),1);
         this.scriptCmds["firehero"] = new ScriptCmd("firehero",this.fireHero,new Array("hero"),new Array("String"),1);
         this.scriptCmds["releasehero"] = new ScriptCmd("releasehero",this.releaseHero,new Array("baseStat","level"),new Array("int","int"),0);
         this.scriptCmds["changeheroname"] = new ScriptCmd("changeheroname",this.changeHeroName,new Array("oldName","newName"),new Array("String","String"),0);
         this.scriptCmds["awardgold"] = new ScriptCmd("awardgold",this.awardGold,new Array("hero"),new Array("String"),1);
         this.scriptCmds["uplevelhero"] = new ScriptCmd("uplevelhero",this.upLevelHero,new Array("hero"),new Array("String"),1);
         this.scriptCmds["addpointhero"] = new ScriptCmd("addpointhero",this.addPointHero,new Array("hero","pol","atk","int"),new Array("String","int","int","int"),4);
         this.scriptCmds["resetherostatsbyname"] = new ScriptCmd("resetherostatsbyname",this.resetHeroStatsByName,new Array("heroName"),new Array("String"),1);
         this.scriptCmds["resetherostatsbyid"] = new ScriptCmd("resetherostatsbyid",this.resetHeroStatsById,new Array("heroId"),new Array("int"),1);
         this.scriptCmds["changeherogear"] = new ScriptCmd("changeherogear",this.changeHeroGear,new Array("hero","geartype"),new Array("String","String"),2);
         this.scriptCmds["changeherogears"] = new ScriptCmd("changeherogears",this.changeHeroGears,new Array("hero","gear:type,gear:type,..."),new Array("String","String"),2);
         this.scriptCmds["resetmapdata"] = new ScriptCmd("resetmapdata",this.resetMapData,new Array(),new Array(),0);
         this.scriptCmds["scanmap"] = new ScriptCmd("scanmap",this.scanMap,new Array("center","radius"),new Array("Coordinate","Number"),2);
         this.scriptCmds["rescanmap"] = new ScriptCmd("rescanmap",this.rescanMap,new Array("center","radius"),new Array("Coordinate","Number"),2);
         this.scriptCmds["scandetail"] = new ScriptCmd("scandetail",this.scanDetail,new Array("center","radius"),new Array("Coordinate","Number"),2);
         this.scriptCmds["scanrec"] = new ScriptCmd("scanrec",this.scanRec,new Array("corner1","corner2","enableFastScan"),new Array("Coordinate","Coordinate","Boolean"),2);
         this.scriptCmds["rescanrec"] = new ScriptCmd("rescanrec",this.rescanRec,new Array("corner1","corner2","enableFastScan"),new Array("Coordinate","Coordinate","Boolean"),2);
         this.scriptCmds["quickscanmap"] = new ScriptCmd("quickscanmap",this.quickScanMap,new Array("State","speedFactor"),new Array("String","int"),0);
         this.scriptCmds["monitorprestige"] = new ScriptCmd("monitorprestige",this.monitorPrestige,new Array("nick","populationFlag","count"),new Array("String","Boolean","int"),1);
         this.scriptCmds["waitresource"] = new ScriptCmd("waitresource",this.waitResource,new Array("resource"),new Array("Resource"),1);
         this.scriptCmds["waithero"] = new ScriptCmd("waithero",this.waitHero,new Array("hero"),new Array("String"),1);
         this.scriptCmds["waitherolost"] = new ScriptCmd("waitherolost",this.waitHeroLost,new Array("heroList"),new Array("String"),1);
         this.scriptCmds["waitenemy"] = new ScriptCmd("waitenemy",this.waitEnemy,new Array("ignoreJunk"),new Array("Boolean"),0);
         this.scriptCmds["waitnoenemy"] = new ScriptCmd("waitnoenemy",this.waitNoEnemy,new Array("ignoreJunk"),new Array("Boolean"),0);
         this.scriptCmds["teleport"] = new ScriptCmd("teleport",this.teleport,new Array("state","stateWord2"),new Array("String","String"),1);
         this.scriptCmds["advteleport"] = new ScriptCmd("advteleport",this.advTeleport,new Array("coord"),new Array("Coordinate"),1);
         this.scriptCmds["warteleport"] = new ScriptCmd("warteleport",this.warTeleport,new Array("coord"),new Array("Coordinate"),1);
         this.scriptCmds["pioteleport"] = new ScriptCmd("pioteleport",this.pioTeleport,new Array("coord"),new Array("Coordinate"),1);
         this.scriptCmds["useitem"] = new ScriptCmd("useitem",this.useItem,new Array("item"),new Array("String"),1);
         this.scriptCmds["usecastleitem"] = new ScriptCmd("usecastleitem",this.useCastleItem,new Array("item"),new Array("String"),1);
         this.scriptCmds["buyitem"] = new ScriptCmd("buyitem",this.buyItem,new Array("item","count"),new Array("String","int"),1);
         this.scriptCmds["useheroitem"] = new ScriptCmd("useheroitem",this.useHeroItem,new Array("hero","item"),new Array("String","String"),2);
         this.scriptCmds["usebuilditem"] = new ScriptCmd("usebuilditem",this.useBuildItem,new Array("item","positionId"),new Array("String","int"),1);
         this.scriptCmds["usetechitem"] = new ScriptCmd("usetechitem",this.useTechItem,new Array("item"),new Array("String"),1);
         this.scriptCmds["usetradeitem"] = new ScriptCmd("usetradeitem",this.useTradeItem,new Array("item","tradeId"),new Array("String","int"),1);
         this.scriptCmds["usestratitem"] = new ScriptCmd("usestratitem",this.useStratItem,new Array("target","item"),new Array("Coordinate","String"),2);
         this.scriptCmds["useangelitem"] = new ScriptCmd("useangelitem",this.useAngelItem,new Array("nick","item"),new Array("String","String"),2);
         this.scriptCmds["usedevilitem"] = new ScriptCmd("usedevilitem",this.useDevilItem,new Array("target","item","option"),new Array("Coordinate","String","String"),2);
         this.scriptCmds["usearmyitem"] = new ScriptCmd("usearmyitem",this.useArmyItem,new Array("armyId","item"),new Array("int","String"),2);
         this.scriptCmds["usecolonyitem"] = new ScriptCmd("usecolonyitem",this.useColonyItem,new Array("colonyCoord","item"),new Array("Coordinate","String"),2);
         this.scriptCmds["getspamhero"] = new ScriptCmd("getspamhero",this.getSpamHero,new Array("heroType"),new Array("String"),0);
         this.scriptCmds["completequests"] = new ScriptCmd("completequests",this.completeQuests,new Array("questType"),new Array("String"),0);
         this.scriptCmds["donatequest"] = new ScriptCmd("donatequest",this.donateQuest,new Array("questId"),new Array("int"),0);
         this.scriptCmds["cleanreports"] = new ScriptCmd("cleanreports",this.cleanReports,new Array("key","startPage"),new Array("String","int"),0);
         this.scriptCmds["cleannpcreports"] = new ScriptCmd("cleannpcreports",this.cleanNpcReports,new Array("startPage"),new Array("int"),0);
         this.scriptCmds["comfort"] = new ScriptCmd("comfort",this.comfort,new Array("comfortType"),new Array("String"),1);
         this.scriptCmds["levy"] = new ScriptCmd("levy",this.levy,new Array("levyType"),new Array("String"),1);
         this.scriptCmds["settaxrate"] = new ScriptCmd("settaxrate",this.setTaxRate,new Array("taxRate"),new Array("int"),1);
         this.scriptCmds["create"] = new ScriptCmd("create",this.create,new Array("buildingType","positionPolicy","useHammer"),new Array("String","String","Boolean"),1);
         this.scriptCmds["create!"] = new ScriptCmd("create!",this.create2,new Array("buildingType","positionPolicy","useHammer"),new Array("String","String","Boolean"),1);
         this.scriptCmds["upgrade"] = new ScriptCmd("upgrade",this.upgrade,new Array("buildingType","buildPolicy","useHammer"),new Array("String","String","Boolean"),0);
         this.scriptCmds["upgrade!"] = new ScriptCmd("upgrade!",this.upgrade2,new Array("buildingType","buildPolicy","useHammer"),new Array("String","String","Boolean"),0);
         this.scriptCmds["demo"] = new ScriptCmd("demo",this.demo,new Array("buildingType","buildPolicy"),new Array("String","String"),1);
         this.scriptCmds["demo!"] = new ScriptCmd("demo!",this.demo2,new Array("buildingType","buildPolicy"),new Array("String","String"),1);
         this.scriptCmds["waitnobuilding"] = new ScriptCmd("waitnobuilding",this.waitNoBuilding,new Array(),new Array(),0);
         this.scriptCmds["research"] = new ScriptCmd("research",this.research,new Array("techType"),new Array("String"),1);
         this.scriptCmds["gear"] = new ScriptCmd("gear",this.gear,new Array("gearType"),new Array("String"),1);
         this.scriptCmds["star"] = new ScriptCmd("star",this.star,new Array("gearType","gemType","count"),new Array("String","String","int"),3);
         this.scriptCmds["autostar"] = new ScriptCmd("autostar",this.autoStar,new Array("gearType","targetLevel","spec1","spec2","spec3","spec4","spec5","spec6","spec7","spec8"),new Array("String","String","String","String","String","String","String","String","String","String"),3);
         this.scriptCmds["safestar"] = new ScriptCmd("safestar",this.safeStar,new Array("gearType","targetLevel","safetyFactor"),new Array("String","String","Number"),2);
         this.scriptCmds["waitnoresearch"] = new ScriptCmd("waitnoresearch",this.waitNoResearch,new Array(),new Array(),0);
         this.scriptCmds["waitturn"] = new ScriptCmd("waitturn",this.waitTurn,new Array(),new Array(),0);
         this.scriptCmds["findfield"] = new ScriptCmd("findfield",this.findField,new Array("valleyType","level","radius","hero","troop","centerCoord"),new Array("String","int","Number","String","Troop","Coordinate"),3);
         this.scriptCmds["buy"] = new ScriptCmd("buy",this.buy,new Array("resourceType","amount","price"),new Array("String","Number","Number"),3);
         this.scriptCmds["sell"] = new ScriptCmd("sell",this.sell,new Array("resourceType","amount","price"),new Array("String","Number","Number"),3);
         this.scriptCmds["buyto"] = new ScriptCmd("buyto",this.buyTo,new Array("resourceType","limit","price","goldReserved"),new Array("String","Number","Number","Number"),3);
         this.scriptCmds["sellto"] = new ScriptCmd("sellto",this.sellTo,new Array("resourceType","limit","price","goldReserved"),new Array("String","Number","Number","Number"),3);
         this.scriptCmds["canceltrade"] = new ScriptCmd("canceltrade",this.cancelTrade,new Array("tradeId"),new Array("int"),0);
         this.scriptCmds["setgate"] = new ScriptCmd("setgate",this.setGate,new Array("status"),new Array("Boolean"),1);
         this.scriptCmds["setfocus"] = new ScriptCmd("setfocus",this.setFocus,new Array(),new Array(),0);
         this.scriptCmds["changecastlename"] = new ScriptCmd("changecastlename",this.changeCastleName,new Array("newName"),new Array("String"),1);
         this.scriptCmds["changeflag"] = new ScriptCmd("changeflag",this.changeFlag,new Array("newFlag"),new Array("String"),1);
         this.scriptCmds["hiderainbow"] = new ScriptCmd("hiderainbow",this.hideRainbow,new Array(),new Array(),0);
         this.scriptCmds["excercise"] = new ScriptCmd("excercise",this.excercise,new Array("attackers","defenders"),new Array("Troop","Troop"),2);
         this.scriptCmds["production"] = new ScriptCmd("production",this.production,new Array("food","lumber","stone","iron"),new Array("int","int","int","int"),0);
         this.scriptCmds["setmayor"] = new ScriptCmd("setmayor",this.setMayor,new Array("mayorType"),new Array("String"),0);
         this.scriptCmds["setmayorbyname"] = new ScriptCmd("setmayorbyname",this.setMayorByName,new Array("hero"),new Array("String"),1);
         this.scriptCmds["train"] = new ScriptCmd("train",this.train,new Array("troop","hero","barrackList","minAmount"),new Array("Troop","String","String","int"),1);
         this.scriptCmds["train!"] = new ScriptCmd("train!",this.train2,new Array("troop","hero","barrackList","minAmount"),new Array("Troop","String","String","int"),1);
         this.scriptCmds["trainto"] = new ScriptCmd("trainto",this.trainTo,new Array("troop","hero","barrackList","minAmount"),new Array("Troop","String","String","int"),1);
         this.scriptCmds["untrain"] = new ScriptCmd("untrain",this.untrain,new Array("troop"),new Array("Troop"),1);
         this.scriptCmds["abandon"] = new ScriptCmd("abandon",this.abandon,new Array("location"),new Array("Coordinate"),1);
         this.scriptCmds["verbose"] = new ScriptCmd("verbose",this.verbose,new Array("verboseSetting"),new Array("String"),1);
         this.scriptCmds["walldefense"] = new ScriptCmd("walldefense",this.wallDefense,new Array("fortType","number","buildType"),new Array("String","int","String"),2);
         this.scriptCmds["walldefenseto"] = new ScriptCmd("walldefenseto",this.wallDefenseTo,new Array("fortGoal"),new Array("Fortification"),1);
         this.scriptCmds["walldefense!"] = new ScriptCmd("walldefense!",this.wallDefense2,new Array("fortType","number","buildType"),new Array("String","int","String"),2);
         this.scriptCmds["declarewar"] = new ScriptCmd("declarewar",this._declareWar,new Array("target"),new Array("Coordinate"),1);
         this.scriptCmds["uprise"] = new ScriptCmd("uprise",this.uprise,new Array(),new Array(),0);
         this.scriptCmds["colony"] = new ScriptCmd("colony",this.colony,new Array("operation","target","troop"),new Array("String","Coordinate","Troop"),2);
         this.scriptCmds["capitalpolicy"] = new ScriptCmd("capitalpolicy",this.capitalPolicy,new Array("operation","target"),new Array("String","Coordinate"),2);
         this.scriptCmds["vote"] = new ScriptCmd("vote",this.vote,new Array("name1","name2","name3","name4","name5"),new Array("String","String","String","String","String"),1);
         this.scriptCmds["autoheal"] = new ScriptCmd("autoheal",this.autoHeal,new Array("setAutoHeal"),new Array("Boolean"),1);
         this.scriptCmds["killwall"] = new ScriptCmd("killwall",this.killWall,new Array(),new Array(),0);
         this.scriptCmds["waitsuzerain"] = new ScriptCmd("waitsuzerain",this.waitSuzerain,new Array(),new Array(),0);
         this.scriptCmds["chatac"] = new ScriptCmd("chatac",this.chatAc,new Array("chatText"),new Array("String"),1);
         this.scriptCmds["chatwc"] = new ScriptCmd("chatwc",this.chatWc,new Array("chatText"),new Array("String"),1);
         this.scriptCmds["chatpc"] = new ScriptCmd("chatpc",this.chatPc,new Array("nick","chatText"),new Array("String","String"),2);
         this.scriptCmds["chatbc"] = new ScriptCmd("chatbc",this.chatBc,new Array("chatText"),new Array("String"),1);
         this.scriptCmds["fmth"] = new ScriptCmd("fmth",this.fmth,new Array(),new Array(),0);
         this.scriptCmds["fmthGLB"] = new ScriptCmd("fmthGLB",this.fmthGLB,new Array(),new Array(),0);
         this.scriptCmds["blockplayer"] = new ScriptCmd("blockplayer",this.blockPlayer,new Array("playerName"),new Array("String"),1);
         this.scriptCmds["unblockplayer"] = new ScriptCmd("unblockplayer",this.unBlockPlayer,new Array("playerName"),new Array("String"),1);
         this.scriptCmds["friendplayer"] = new ScriptCmd("friendplayer",this.friendPlayer,new Array("playerName"),new Array("String"),1);
         this.scriptCmds["unfriendplayer"] = new ScriptCmd("unfriendplayer",this.unFriendPlayer,new Array("playerName"),new Array("String"),1);
         this.scriptCmds["listpackages"] = new ScriptCmd("listpackages",this.listPackages,new Array(),new Array(),0);
         this.scriptCmds["claimpackage"] = new ScriptCmd("claimpackage",this.claimPackage,new Array("packageId"),new Array("int"),1);
         this.scriptCmds["changeplayernick"] = new ScriptCmd("changeplayernick",this.changePlayerNick,new Array("nick1","nick2","nick3","nick4","nick5"),new Array("String","String","String","String","String"),1);
         this.scriptCmds["refresh"] = new ScriptCmd("refresh",this.refresh,new Array(),new Array(),0);
         this.scriptCmds["logintoskype"] = new ScriptCmd("logintoskype",this.loginToSkype,new Array("skypeId/email","password"),new Array("String","String"),2);
         this.scriptCmds["skypepm"] = new ScriptCmd("skypepm",this.skypePm,new Array("skypeUserId","message"),new Array("String","String"),2);
         this.scriptCmds["skypegm"] = new ScriptCmd("skypegm",this.skypeGm,new Array("Group name(or partial name)","message"),new Array("String","String"),2);
         this.scriptCmds["config"] = new ScriptCmd("config",this.config,new Array("configString"),new Array("String"),1);
         this.scriptCmds["rallymax"] = new ScriptCmd("rallymax",this.rallyMax,new Array("configString"),new Array("String"),1);
         this.scriptCmds["skypewarningpolicy"] = new ScriptCmd("skypewarningpolicy",this.skypeWarningPolicy,new Array("normal","junk","valley","colony"),new Array("int","int","int","int"),1);
         this.scriptCmds["skypewarningreceivers"] = new ScriptCmd("skypewarningreceivers",this.skypeWarningReceivers,new Array("receiversList"),new Array("String"),1);
         this.scriptCmds["skypewarreportreceivers"] = new ScriptCmd("skypewarreportreceivers",this.skypeWarReportReceivers,new Array("receiversList"),new Array("String"),1);
         this.scriptCmds["warreportignorelist"] = new ScriptCmd("warreportignorelist",this.warReportIgnoreList,new Array("ignorList"),new Array("String"),1);
         this.scriptCmds["enemywarningignorelist"] = new ScriptCmd("enemywarningignorelist",this.enemyWarningIgnoreList,new Array("ignorList"),new Array("String"),1);
         this.scriptCmds["gatepolicy"] = new ScriptCmd("gatepolicy",this.gatePolicy,new Array("peace","attack","scoutbomb","mix","pause"),new Array("int","int","int","int","int"),4);
         this.scriptCmds["resourcelimits"] = new ScriptCmd("resourcelimits",this.resourceLimits,new Array("food","lumber","stone","iron"),new Array("String","String","String","String"),4);
         this.scriptCmds["distancepolicy"] = new ScriptCmd("distancepolicy",this.distancePolicy,new Array("farmnpc","buildnpc","medalhunting","resourcevalley","buildnpc10"),new Array("int","int","int","int","int"),5);
         this.scriptCmds["valleytroops"] = new ScriptCmd("valleytroops",this.valleyTroops,new Array("troop"),new Array("Troop"),1);
         this.scriptCmds["valleytroop"] = new ScriptCmd("valleytroop",this.valleyTroops,new Array("troop"),new Array("Troop"),1);
         this.scriptCmds["huntingpos"] = new ScriptCmd("huntingpos",this.huntingPos,new Array("troop"),new Array("Coordinate"),1);
         this.scriptCmds["huntingtype"] = new ScriptCmd("huntingtype",this.huntingType,new Array("valleyType"),new Array("String"),1);
         this.scriptCmds["setballsused"] = new ScriptCmd("setballsused",this.setBallsUsed,new Array("setting"),new Array("String"),1);
         this.scriptCmds["ballsused"] = new ScriptCmd("ballsused",this.setBallsUsed,new Array("setting"),new Array("String"),1);
         this.scriptCmds["npctroop"] = new ScriptCmd("npctroop",this.npcTroop,new Array("troop"),new Array("Troop"),1);
         this.scriptCmds["npctroops"] = new ScriptCmd("npctroops",this.npcTroop,new Array("troop"),new Array("Troop"),1);
         this.scriptCmds["valleyheroes"] = new ScriptCmd("valleyheroes",this.valleyHeroes,new Array("heroList"),new Array("String"),1);
         this.scriptCmds["npcheroes"] = new ScriptCmd("npcheroes",this.npcHeroes,new Array("heroList"),new Array("String"),1);
         this.scriptCmds["npc10limit"] = new ScriptCmd("npc10limit",this.npc10Limit,new Array("troop"),new Array("Troop"),1);
         this.scriptCmds["npc10troop"] = new ScriptCmd("npc10troop",this.npc10Troop,new Array("troop"),new Array("String"),1);
         this.scriptCmds["npc10troops"] = new ScriptCmd("npc10troops",this.npc10Troop,new Array("troop"),new Array("Troop"),1);
         this.scriptCmds["npc10heroes"] = new ScriptCmd("npc10heroes",this.npc10Heroes,new Array("heroList"),new Array("String"),1);
         this.scriptCmds["spamheroes"] = new ScriptCmd("spamheroes",this.spamHeroes,new Array("heroList"),new Array("String"),1);
         this.scriptCmds["notspamheroes"] = new ScriptCmd("notspamheroes",this.notSpamHeroes,new Array("heroList"),new Array("String"),1);
         this.scriptCmds["keeptroop"] = new ScriptCmd("keeptroop",this.keepTroop,new Array("target","troop","minTroopSent"),new Array("Coordinate","Troop","int"),2);
         this.scriptCmds["keepresource"] = new ScriptCmd("keepresource",this.keepResource,new Array("target","resource","minResourceSent"),new Array("Coordinate","String","Number"),2);
         this.scriptCmds["endkeeptroop"] = new ScriptCmd("endkeeptroop",this.endKeepTroop,new Array(),new Array(),0);
         this.scriptCmds["endkeepresource"] = new ScriptCmd("endkeepresource",this.endKeepResource,new Array(),new Array(),0);
         this.scriptCmds["troopgoal"] = new ScriptCmd("troopgoal",this.troopGoal,new Array("troopStr"),new Array("Troop"),1);
         this.scriptCmds["troop"] = new ScriptCmd("troop",this.troopGoal,new Array("troopStr"),new Array("Troop"),1);
         this.scriptCmds["fortificationgoal"] = new ScriptCmd("fortificationgoal",this.fortificationGoal,new Array("fortificationStr"),new Array("Fortification"),1);
         this.scriptCmds["fortification"] = new ScriptCmd("fortification",this.fortificationGoal,new Array("fortificationStr"),new Array("Fortification"),1);
         this.scriptCmds["buildinggoals"] = new ScriptCmd("buildinggoals",this.buildingGoals,new Array("buildingString"),new Array("String"),1);
         this.scriptCmds["build"] = new ScriptCmd("build",this.buildingGoals,new Array("buildingString"),new Array("String"),1);
         this.scriptCmds["techgoals"] = new ScriptCmd("techgoals",this.techGoals,new Array("techString"),new Array("String"),1);
         this.scriptCmds["tech"] = new ScriptCmd("tech",this.techGoals,new Array("techString"),new Array("String"),1);
         this.scriptCmds["setgoal"] = new ScriptCmd("setgoal",this.setGoal,new Array(),new Array(),0);
         this.scriptCmds["setallgoals"] = new ScriptCmd("setallgoals",this.setAllGoals,new Array(),new Array(),0);
         this.scriptCmds["resetgoals"] = new ScriptCmd("resetgoals",this.resetGoals,new Array(),new Array(),0);
         this.scriptCmds["rereadgoals"] = new ScriptCmd("rereadgoals",this.rereadGoals,new Array(),new Array(),0);
         this.scriptCmds["goalcommandwarning"] = new ScriptCmd("goalcommandwarning",this.goalcommandWarning,new Array("flag"),new Array("Boolean"),1);
      }
      
      private function setMayorByName(param1:String) : void
      {
         this.currentAction = "setmayorbyname";
         this.fncSetMayorByName(param1);
         this.onCmdFinshed(true);
      }
      
      private function fieldAttack(param1:String, param2:int, param3:Number, param4:int = 8) : void
      {
         this.currentAction = "fieldattack";
         this.cityManager._scrFieldAttack(param1,param2,param3,param4);
         this.onCmdFinshed(true);
      }
      
      private function goalcommandWarning(param1:Boolean) : void
      {
         this.currentAction = "goalwarning";
         goalCommandWarning = param1;
         this.onCmdResult("*** changing warning flag when using goal as command to: " + param1);
         this.onCmdFinshed(true);
      }
      
      public function getCityFromValleyFieldId(param1:int) : CityState
      {
         return MainScreen.getCityFromValleyFieldId(param1);
      }
      
      private function attackWait(param1:String = "honor") : void
      {
         var handler:Function = null;
         var scanTimer:Timer = null;
         var type:String = param1;
         this.currentAction = "attackwait";
         this.pleaseStop = false;
         if(type != "honor" && type != "loyalty" && type != "spam")
         {
            this.logCmdResponse("Invalid attackwait type, must be honor, loyalty, or spam");
            this.onCmdFinshed(true);
            return;
         }
         handler = function(param1:TimerEvent):void
         {
            if(pleaseStop)
            {
               scanTimer.stop();
               scanTimer.removeEventListener(TimerEvent.TIMER,handler);
               scanTimer = null;
               onCmdFinshed(true);
               return;
            }
            scanTimer.delay = 2000;
            if(cityManager._is281(type))
            {
               return;
            }
            scanTimer.stop();
            scanTimer.removeEventListener(TimerEvent.TIMER,handler);
            scanTimer = null;
            onCmdFinshed(true);
         };
         scanTimer = new Timer(0);
         scanTimer.addEventListener(TimerEvent.TIMER,handler);
         scanTimer.start();
      }
      
      private function updateBuildingBean(param1:BuildingBean) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.castle.buildingsArray)
         {
            if(this.castle.buildingsArray[_loc2_].positionId == param1.positionId)
            {
               if(param1.level > 0)
               {
                  this.castle.buildingsArray[_loc2_] = param1;
               }
               else
               {
                  this.castle.buildingsArray.removeItemAt(int(_loc2_));
               }
               return;
            }
         }
         this.castle.buildingsArray.addItem(param1);
      }
      
      private function setBallsUsed(param1:String) : void
      {
         this.printGoalCommandWarning();
         this.currentAction = "setballused";
         this.cityManager._pj342(param1);
         this.onCmdFinshed(true);
      }
      
      public function getVar(param1:String) : *
      {
         return this.script.getVar(param1);
      }
      
      private function uprise() : void
      {
         this.currentAction = "uprise";
         this.setCmdResponse(ResponseDispatcher.COLONY_UPRISE,this.handleCmdResponse);
         ActionFactory.getInstance().getColonyCommands().uprise(this.castleId);
      }
      
      public function get actionFactory() : ActionFactory
      {
         return ActionFactory.getInstance();
      }
      
      private function onDoResearchResponse(param1:AvailableResearchListResponse) : void
      {
         var _loc10_:AvailableResearchListBean = null;
         var _loc11_:int = 0;
         if(this.currentAction != "research")
         {
            return;
         }
         this.currentAction = "research_step2";
         if(param1.ok != 1)
         {
            this.onCmdFinshed(new ScriptError("Error executing research: " + param1.errorMsg,param1.ok));
            return;
         }
         var _loc2_:int = -1;
         var _loc3_:Number = -1;
         var _loc4_:int = -1;
         var _loc5_:Number = -1;
         var _loc6_:int = -1;
         var _loc7_:int = -1;
         var _loc8_:int = -1;
         var _loc9_:int = -1;
         for each(_loc10_ in param1.acailableResearchBeansArray)
         {
            if(Boolean(_loc10_.upgradeing) && _loc10_.castleId == this.castleId)
            {
               this.currentResearch = _loc10_;
            }
            if(this._ip715(_loc10_,param1))
            {
               if(_loc2_ == -1 || _loc3_ > _loc10_.conditionBean.time)
               {
                  _loc2_ = _loc10_.typeId;
                  _loc3_ = _loc10_.conditionBean.time;
               }
               if(_loc4_ == -1 || _loc5_ < _loc10_.conditionBean.time)
               {
                  _loc4_ = _loc10_.typeId;
                  _loc5_ = _loc10_.conditionBean.time;
               }
               if(_loc6_ == -1 || _loc7_ < _loc10_.conditionBean.gold)
               {
                  _loc6_ = _loc10_.typeId;
                  _loc7_ = _loc10_.conditionBean.gold;
               }
               if(_loc8_ == -1 || _loc9_ > _loc10_.conditionBean.gold)
               {
                  _loc8_ = _loc10_.typeId;
                  _loc9_ = _loc10_.conditionBean.gold;
               }
            }
         }
         _loc11_ = -1;
         switch(this.researchType)
         {
            case "quickest":
               _loc11_ = _loc2_;
               break;
            case "slowest":
               _loc11_ = _loc4_;
               break;
            case "dearest":
               _loc11_ = _loc6_;
               break;
            case "cheapest":
               _loc11_ = _loc8_;
         }
         if(_loc11_ == -1)
         {
            _loc11_ = TechType.fromString(this.researchType);
         }
         if(_loc11_ > 0)
         {
            CityStateCommands.research(this.castleId,_loc11_);
            this.cityManager.updateResearch();
         }
         else
         {
            this.onCmdFinshed(new ScriptError("Unable to perform research.",-9999));
         }
      }
      
      public function getCityFromColonyFieldId(param1:int) : CityState
      {
         return MainScreen.getCityFromColonyFieldId(param1);
      }
      
      private function healTroops2() : void
      {
         this.currentAction = "healtroops2";
         this.setCmdResponse(ResponseDispatcher.ARMY_CURE_INJURED_TROOP,this.handleCmdResponse);
         CityStateCommands.cureInjuredTroop(this.castleId);
      }
      
      public function deleteStatic(param1:String) : *
      {
         return this.script.deleteStatic(param1);
      }
      
      private function researchComplete(param1:ResearchCompleteUpdate) : void
      {
         if(param1.castleId != this.castleId)
         {
            return;
         }
         this.currentResearch = null;
      }
      
      private function levy(param1:Object) : void
      {
         var _loc2_:int = 0;
         this.currentAction = "levy";
         this.onCmdResult("Starting",this.currentAction);
         _loc2_ = int(param1);
         if(_loc2_ != 0)
         {
            this.levyByIntType(int(param1));
         }
         else
         {
            this.levyByStrType(param1.toString());
         }
         this.onCmdResult(this.currentAction,"complete");
      }
   }
}

