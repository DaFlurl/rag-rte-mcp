// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.scripts.CityState

package autoevony.scripts
{
    import flash.events.EventDispatcher;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.common.beans.CastleBean;
    import autoevony.management.CityManager;
    import mx.collections.ArrayCollection;
    import autoevony.common.ActionFactoryResponse;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.ObjConstants;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.beans.HeroBean;
    import autoevony.common.ScriptError;
    import autoevony.common.CityStateCommands;
    import autoevony.gui.MainScreen;
    import autoevony.common.Utils;
    import com.evony.common.paramBeans.NewArmyParam;
    import com.evony.common.beans.ResourceBean;
    import com.evony.common.module.CommandResponse;
    import autoevony.player.Map;
    import com.evony.common.beans.MapCastleBean;
    import com.evony.common.module.friend.FriendResponse;
    import autoevony.player.LoginHelper;
    import com.evony.common.beans.ArmyBean;
    import autoevony.gui.AccountInfo;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.common.beans.FortificationsBean;
    import com.evony.common.constants.TFConstants;
    import com.evony.common.beans.ColonyBean;
    import autoevony.common.Items;
    import com.evony.common.beans.QuestTypeBean;
    import com.evony.common.module.quest.QuestTypeResponse;
    import com.evony.common.beans.PlayerInfoBean;
    import autoevony.common.CityStateConstants;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.module.shop.UseItemResultResponse;
    import com.skype.SkypeConstants;
    import com.skype.SkypeResponse;
    import com.skype.Skype;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import autoevony.common.GearType;
    import com.evony.common.module.army.ArmyPracticeResponse;
    import com.evony.common.module.colony.ColonialArmyResponse;
    import com.evony.common.constants.FieldConstants;
    import com.evony.common.module.report.ReportListResponse;
    import autoevony.common.CallbackParams;
    import com.evony.common.constants.HeroConstants;
    import com.evony.common.module.gemstone.GemstoneRespone;
    import autoevony.net.Connection;
    import autoevony.common.BuildingType;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.ErrorCode;
    import com.evony.common.module.capital.CapitalCommandResponse;
    import com.evony.common.module.hero.HeroListResponse;
    import com.evony.common.module.common.ChatResponse;
    import com.evony.common.beans.DisappearHeroBean;
    import com.evony.common.module.hero.DisappearHeroResponse;
    import autoevony.event.CityStateResponseEvent;
    import com.evony.common.module.common.GetPackageResponse;
    import autoevony.event.EventHandler;
    import autoevony.event.CityStateCompleteEvent;
    import com.evony.common.module.common.MapInfoSimpleResponse;
    import com.evony.common.beans.PlayerBean;
    import com.evony.common.module.colony.ColonyLevyeRespone;
    import flash.utils.getDefinitionByName;
    import com.evony.common.constants.EquipmentTech;
    import com.evony.common.beans.EquipmentBean;
    import com.evony.common.constants.TradeConstants;
    import com.evony.common.beans.PackageBean;
    import com.evony.common.module.common.GetPackageListResponse;
    import com.evony.common.module.tech.AvailableResearchListResponse;
    import autoevony.common.TrainTroopHelper;
    import com.evony.common.module.colony.ColonialDeployResponse;
    import com.evony.common.server.events.FortificationsUpdate;
    import flash.events.Event;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.common.constants.TechConstants;
    import autoevony.common.TechType;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
    import com.evony.common.constants.CommonConstants;
    import com.evony.common.module.alliance.PlayerInfoResponse;
    import com.evony.common.beans.QuestBean;
    import com.evony.common.beans.QuestTargetBean;
    import com.evony.common.module.quest.QuestListResponse;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.eum.ItemEum;
    import com.evony.common.server.events.ResearchCompleteUpdate;

    public class CityState extends EventDispatcher 
    {

        public static var findQuestCount:int = 0;
        public static var findQuestCastleId:int = 0;
        public static var scriptQuestActive:Boolean = false;
        private static var goalCommandWarning:Boolean = true;
        private static var lastCalibrateTime:Number = 0;
        private static const TRADELIMIT:int = 99999999;
        private static const SPEEDUP:Array = new Array(1, 2, 2, 2, 3, 4, 4, 4, 5, 5, 6);
        private static var campTimeDelta:Number = 0;
        private static var lastEmailMsg:Number = 0;

        public var castleId:int;
        private var currentResearch:AvailableResearchListBean = null;
        public var verboseLogs:Boolean = false;
        private var script:Script;
        private var friendBlockPlayerName:String = null;
        public var castle:CastleBean;
        private var pleaseStop:Boolean = false;
        internal var currentAction:String;
        private var changeHeroGearsParams:Object = null;
        private var researchType:String;
        public var cityManager:CityManager;
        private var scriptCmds:Object = null;

        private var reportIdsToDelete:ArrayCollection = new ArrayCollection();
        private var events:ArrayCollection = new ArrayCollection();
        private var m_techLevels:Object = new Object();
        public var actionResponse:ActionFactoryResponse = new ActionFactoryResponse();

        public function CityState(_arg_1:int, _arg_2:Boolean=true)
        {
            this.castleId = _arg_1;
            this._setCastleBean();
            this.cityManager = new CityManager(this, _arg_1);
            this.script = new Script(this);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, this.buildComplete);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE, this.researchComplete);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, this.updateFort);
            if (_arg_2)
            {
                this.currentAction = "init";
                ActionFactory.getInstance().getTechCommand().getResearchList(this.castleId, this.onGetResearchListResponse);
            };
            this.currentActiveBuilding();
            this.currentAction = "";
            this.onCmdFinshed(true);
        }

        public static function getMissionConstFromString(_arg_1:String):int
        {
            var _local_2:int = int(_arg_1);
            if (_local_2 == 0)
            {
                _arg_1 = _arg_1.toLowerCase().substr(0, 2);
                if (_arg_1 == "at")
                {
                    return (ObjConstants.ARMY_MISSION_OCCUPY);
                };
                if (_arg_1 == "bu")
                {
                    return (ObjConstants.ARMY_MISSION_CONSTRUCT);
                };
                if (_arg_1 == "re")
                {
                    return (ObjConstants.ARMY_MISSION_SEND);
                };
                if (_arg_1 == "sc")
                {
                    return (ObjConstants.ARMY_MISSION_SCOUT);
                };
                if (_arg_1 == "tr")
                {
                    return (ObjConstants.ARMY_MISSION_TRANS);
                };
                if (_arg_1 == "co")
                {
                    return (ObjConstants.ARMY_MISSION_COLONIZE);
                };
                if (_arg_1 == "an")
                {
                    return (ObjConstants.ARMY_MISSION_ANTI_COLONIAL);
                };
                if (_arg_1 == "su")
                {
                    return (ObjConstants.ARMY_MISSION_SUPPRESS);
                };
                if (_arg_1 == "up")
                {
                    return (ObjConstants.ARMY_MISSION_UPRISE);
                };
                if (_arg_1 == "de")
                {
                    return (ObjConstants.ARMY_MISSION_DEPLOY_TROOPS);
                };
                return (ObjConstants.ARMY_MISSION_TRANS);
            };
            return (_local_2);
        }


        private function notSpamHeroes(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "notspamheroes";
            this.cityManager.setSpamHeroes(_arg_1);
            this.onCmdFinshed(true);
        }

        private function aBigAttack(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "abigattack";
            this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY, _arg_1, _arg_2, _arg_3, null, _arg_4, true, false, 2, null);
        }

        private function train(_arg_1:TroopBean, _arg_2:String="atk", _arg_3:String="all", _arg_4:int=1):void
        {
            if (_arg_1 == null)
            {
                this.onCmdResult(" usage: train troops [hero] [barrackid | all | idle] [min amount]", "");
                this.onCmdResult("example: train a:99999", "");
                this.onCmdResult("Trains at least 1 to a maximum of 99999 archers in all barracks, will use the idle hero with highest attack", "");
                this.onCmdResult("", "");
                this.onCmdResult("note: you may specify atk or any as the heroname and the highest attack idle hero will be used, if you have no idle heros the command will still execute, if you specify any other hero name that is not found in your feasting hall or not idle the command will not execute", "");
                this.onCmdResult("", "");
                this.onCmdResult("example: train a:99999 any all 20000", "");
                this.onCmdResult("Train at least 20000 to a maximum of 99999 archers in all barracks with any hero, do not train any if you cannot train at least 20000", "");
                this.onCmdResult("", "");
                this.onCmdResult("example: train a:5000 any idle 5000", "");
                this.onCmdResult("Train exactly 5000 archers in idle barracks with any hero, if 5000 archers cannot be trained train none", "");
                this.onCmdResult("", "");
                this.onCmdResult("example: train a:1000 any 24 1000", "");
                this.onCmdResult("Train exactly 1000 archers in barrack 24 with any hero, use listbarracks to determine barrack id", "");
                this.onCmdResult("", "");
                this.onCmdResult("example: train a:1000 Wilbur 24 1000", "");
                this.onCmdResult("Train exactly 1000 archers in barrack 24 with Wilbur hero, if Wilbur is not available will not train any", "");
                this.onCmdResult("", "");
                this.onCmdFinshed(true);
                return;
            };
            this.onCmdResult("Waiting for town's turn to train troop...");
            this.cityManager._reserveEmergencyTimeSlot();
            this.waitForCmActive(this.train2, [_arg_1, _arg_2, _arg_3, _arg_4]);
        }

        private function addPointHero(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            this.currentAction = "upaddpoint";
            var _local_5:HeroBean = this.findHeroByName(_arg_1);
            if (_local_5 == null)
            {
                this.onCmdFinshed(new ScriptError(("No hero found with name: " + _arg_1), -9999));
                return;
            };
            this.onCmdResult((((((((("Add point(s) to hero " + _local_5.name) + ": ") + _arg_2) + " pol, ") + _arg_3) + " atk, ") + _arg_4) + " int"));
            this.setCmdResponse(ResponseDispatcher.HERO_ADD_POINT2, this.handleCmdResponse);
            CityStateCommands.addPoint2(this.castleId, _local_5.id, _arg_2, _arg_3, _arg_4, this.handleCmdResponse);
        }

        public function getCityFromFieldId(_arg_1:int):CityState
        {
            return (MainScreen.getCityFromFieldId(_arg_1));
        }

        private function idRecall(_arg_1:int):void
        {
            this.currentAction = "idrecall";
            this.cityManager._qk434(_arg_1);
            this.onCmdFinshed(true);
        }

        private function endFieldAttack():void
        {
            this.currentAction = "endfieldattack";
            this.cityManager._scrEndFieldAttack();
            this.onCmdFinshed(true);
        }

        public function formatNum(_arg_1:Number, _arg_2:int=50):String
        {
            return (Utils.formatNum(_arg_1, _arg_2));
        }

        private function aAttack(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "aattack";
            this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY, _arg_1, _arg_2, _arg_3, null, _arg_4, false, false, 2, null);
        }

        public function getArmy(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:TroopBean, _arg_5:ResourceBean=null, _arg_6:int=0, _arg_7:Boolean=false):NewArmyParam
        {
            var _local_8:NewArmyParam = new NewArmyParam();
            _local_8.missionType = getMissionConstFromString(_arg_1);
            _local_8.targetPoint = _arg_2;
            var _local_9:HeroBean = this.findHeroByName(_arg_3);
            if (_local_9 != null)
            {
                _local_8.heroId = _local_9.id;
            };
            _local_8.troops = _arg_4;
            if (_arg_5 == null)
            {
                _arg_5 = new ResourceBean();
            };
            _local_8.resource = _arg_5;
            _local_8.restTime = _arg_6;
            _local_8.useFlag = _arg_7;
            return (_local_8);
        }

        private function changePlayerNickResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            this.cityManager.logMsg((((_arg_1.msg == null) || (_arg_1.msg == "")) ? "Changed name successfully." : _arg_1.msg));
            this.onCmdFinshed(true);
        }

        public function getMapDetail(_arg_1:int):MapCastleBean
        {
            return (Map.getDetail(_arg_1));
        }

        private function blockPlayerResponseHandler(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.friendBlockPlayerName = null;
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            this.player.blockBeansArray = _arg_1.blockArrArray;
            this.cityManager.logMsg((('Player "' + this.friendBlockPlayerName) + '" was successfully added to your Block Players List.'));
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(true);
        }

        private function upgrade(_arg_1:String="*", _arg_2:String="LowestLevel", _arg_3:Boolean=false):void
        {
            if (_arg_3)
            {
                this.upgrade2(_arg_1, _arg_2, _arg_3);
                return;
            };
            if (Version.isTraceOn())
            {
                trace("create - verify buildings");
            };
            if (this.cityManager.isBuildingQueueAvailable())
            {
                this.upgrade2(_arg_1, _arg_2, _arg_3);
                return;
            };
            this.onCmdResult("Waiting for current building to complete...");
            this.waitForBuildingQueue(this.upgrade2, [_arg_1, _arg_2, _arg_3]);
        }

        private function levyByStrType(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:int;
            _local_2 = _arg_1.toLowerCase().substr(0, 1);
            _local_3 = new Array("", "g", "f", "w", "s", "i");
            _local_4 = _local_3.indexOf(((_local_2 == "l") ? "w" : _local_2));
            if (_local_4 > 0)
            {
                this.levyByIntType(_local_4);
            }
            else
            {
                this.onCmdFinshed(new ScriptError(("Unknown Levy type: " + _arg_1), -9999));
            };
        }

        public function parseTime(_arg_1:String, _arg_2:Boolean=false):Number
        {
            var _local_6:Date;
            var _local_3:Date;
            var _local_4:Number = 0;
            var _local_5:Array = _arg_1.split(":");
            if (_local_5.length < 1)
            {
                return (0);
            };
            if (_arg_2)
            {
                _local_6 = new Date();
                _local_6.setTime(Utils.getServerTime());
                switch (_local_5.length)
                {
                    case 2:
                        if ((_local_3 = new Date(_local_6.fullYear, _local_6.getMonth(), _local_6.getDate(), int(_local_5[0]), int(_local_5[1]))).valueOf() < _local_6.valueOf())
                        {
                            _local_3 = new Date(_local_6.fullYear, _local_6.getMonth(), (_local_6.getDate() + 1), int(_local_5[0]), int(_local_5[1]));
                        };
                        break;
                    case 3:
                        if ((_local_3 = new Date(_local_6.fullYear, _local_6.getMonth(), _local_6.getDate(), int(_local_5[0]), int(_local_5[1]), int(_local_5[2]), ((Number(_local_5[2]) - int(_local_5[2])) * 1000))).valueOf() < _local_6.valueOf())
                        {
                            _local_3 = new Date(_local_6.fullYear, _local_6.getMonth(), (_local_6.getDate() + 1), int(_local_5[0]), int(_local_5[1]), int(_local_5[2]), ((Number(_local_5[2]) - int(_local_5[2])) * 1000));
                        };
                        break;
                    default:
                        return (0);
                };
                if (_local_3.getTime() < _local_6.getTime())
                {
                    return (0);
                };
                return ((_local_3.getTime() - _local_6.getTime()) / 1000);
            };
            switch (_local_5.length)
            {
                case 1:
                    _local_4 = Number(_local_5[0]);
                    break;
                case 2:
                    _local_4 = ((int(_local_5[0]) * 60) + Number(_local_5[1]));
                    break;
                case 3:
                    _local_4 = (((int(_local_5[0]) * 3600) + (int(_local_5[1]) * 60)) + Number(_local_5[2]));
                    break;
                default:
                    return (0);
            };
            return (_local_4);
        }

        public function get serverCfg():Object
        {
            var obj:Object;
            obj = {
                "serverAlias":LoginHelper.getInstance().strserverAlias,
                "serverName":LoginHelper.getInstance().server,
                "serverIP":LoginHelper.getInstance().serverIP,
                "evoLoginName":"",
                "evoHashedPw":LoginHelper.getInstance().getHashedEvonyPw()
            };
            obj["toDebugString"] = function ():String
            {
                var _local_2:String;
                var _local_1:* = "";
                for (_local_2 in obj)
                {
                    if (_local_2 != "toDebugString")
                    {
                        _local_1 = (_local_1 + (((_local_2 + " = ") + obj[_local_2]) + "\n"));
                    };
                };
                return (_local_1);
            };
            return (obj);
        }

        public function getLocalTime():Number
        {
            var _local_1:Date = new Date();
            _local_1.setTime(Utils.getServerTime());
            return ((((_local_1.hours * 3600) + (_local_1.minutes * 60)) + _local_1.seconds) + (_local_1.milliseconds / 1000));
        }

        public function getTroopFromArmy(_arg_1:ArmyBean):TroopBean
        {
            return (Utils.getTroopBeanFromTroopStrBean(_arg_1.troop));
        }

        private function collectAllPackages():void
        {
        }

        public function get af():ActionFactory
        {
            return (ActionFactory.getInstance());
        }

        public function get accountTab():AccountInfo
        {
            return (AccountInfo.getInstance());
        }

        public function get ac():Array
        {
            return (MainScreen.getCities());
        }

        private function bigTransport(_arg_1:int, _arg_2:TroopBean, _arg_3:ResourceBean, _arg_4:String=""):void
        {
            this.currentAction = "bigtransport";
            this.doMarch(ObjConstants.ARMY_MISSION_TRANS, _arg_1, "none", _arg_2, _arg_3, _arg_4, true);
        }

        public function get buildingTypes():Object
        {
            var obj:Object;
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
            obj["toDebugString"] = function ():String
            {
                var _local_2:String;
                var _local_1:* = "";
                for (_local_2 in obj)
                {
                    if (_local_2 != "toDebugString")
                    {
                        _local_1 = (_local_1 + (((_local_2 + " = ") + obj[_local_2]) + "\n"));
                    };
                };
                return (_local_1);
            };
            return (obj);
        }

        private function clearQueueType(_arg_1:String):void
        {
            var _local_4:int;
            this.currentAction = "clearqueuetype";
            var _local_2:TroopBean = Utils.getTroops((_arg_1 + ":1"));
            var _local_3:FortificationsBean = Utils.getFortifications((_arg_1 + ":1"));
            if (_local_2 != null)
            {
                _local_4 = TFConstants.T_PEASANTS;
                while (_local_4 <= TFConstants.T_CATAPULT)
                {
                    if (_local_2[Utils.troopIntNames[_local_4]] > 0)
                    {
                        this.cityManager._clearTroopQueuesByType(_local_4);
                    };
                    _local_4++;
                };
            }
            else
            {
                if (_local_3 != null)
                {
                    _local_4 = TFConstants.F_TRAP;
                    while (_local_4 <= TFConstants.F_ROCKFALL)
                    {
                        if (_local_3[Utils.troopIntNames[_local_4]] > 0)
                        {
                            this.cityManager._clearWallQueueByType(_local_4);
                        };
                        _local_4++;
                    };
                }
                else
                {
                    this.onCmdResult(("Invalid troop or fortification: " + _arg_1));
                };
            };
            this.onCmdFinshed(true);
        }

        public function getClosestCity(_arg_1:int, _arg_2:int=-1):CityState
        {
            return (MainScreen.getClosestCityToFieldId(_arg_1, _arg_2));
        }

        public function randomTime(_arg_1:String):int
        {
            var _local_2:Array = _arg_1.replace("rnd:", "").split(":");
            if (_local_2.length == 1)
            {
                return (Utils.getRandomInt(0, int(_local_2[1])));
            };
            if (_local_2.length == 2)
            {
                return (Utils.getRandomInt(int(_local_2[0]), int(_local_2[1])));
            };
            return (0);
        }

        private function dumpResource(_arg_1:int, _arg_2:ResourceBean, _arg_3:ResourceBean):void
        {
            this.currentAction = "dump resource";
            this.cityManager._ls869(_arg_1, _arg_2, _arg_3);
            Utils.callLater(1500, this.onCmdFinshed, [true]);
        }

        private function loyaltyAttack(_arg_1:int, _arg_2:int):void
        {
            this.currentAction = "loyaltyattack";
            this.cityManager._oh316(_arg_1, _arg_2, false);
            this.onCmdFinshed(true);
        }

        private function hideRainbow():void
        {
            this.currentAction = "hiderainbow";
            if (this.cityManager._handleEvasion())
            {
                this.onCmdResult("rainbow has been evacuated");
            }
            else
            {
                this.logCmdResponse("Unable to hide rainbow");
            };
            this.onCmdFinshed(true);
        }

        private function autoHeal(_arg_1:Boolean):void
        {
            this.currentAction = "setAutoHeal";
            this.onCmdResult(("Setting Auto Troop Heal to " + ((_arg_1) ? "True" : "False")));
            ActionFactory.getInstance().getCommonCommands().setAutoHeal(_arg_1);
            this.onCmdFinshed(true);
        }

        private function wallDefenseTo(_arg_1:FortificationsBean):void
        {
            var _local_2:FortificationsBean = this.cityManager._ow687();
            var _local_3:int = TFConstants.F_TRAP;
            while (_local_3 <= TFConstants.F_ROCKFALL)
            {
                if (_local_2[Utils.troopIntNames[_local_3]] < _arg_1[Utils.troopIntNames[_local_3]])
                {
                    this.onCmdResult("Waiting for town's turn to build wall defense...");
                    this.cityManager._reserveEmergencyTimeSlot();
                    this.waitForCmActive(this.wallDefense2, [Utils.troopAbrNames[_local_3], (_arg_1[Utils.troopIntNames[_local_3]] - _local_2[Utils.troopIntNames[_local_3]]), "build"]);
                    return;
                };
                _local_3++;
            };
            this.onCmdResult("No wall defense to build");
            this.onCmdFinshed(true);
        }

        private function rescanMap(_arg_1:int, _arg_2:Number, _arg_3:Boolean=false):void
        {
            this.currentAction = "rescanmap";
            Map.resetArea(Map.getX(_arg_1), Map.getY(_arg_1), _arg_2);
            this.scanMap(_arg_1, _arg_2);
        }

        public function getMapDistance(_arg_1:int, _arg_2:int):Number
        {
            return (Map.fieldDistance(_arg_1, _arg_2));
        }

        private function cancelTech():void
        {
            this.currentAction = "canceltech";
            var _local_1:AvailableResearchListBean = this.cityManager.getResearchInProgress();
            if (_local_1 == null)
            {
                this.onCmdFinshed(new ScriptError("No current research", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.TECH_CANCEL_RESEARCH, this.handleCmdResponse);
            ActionFactory.getInstance().getTechCommand().cancelResearch(this.castleId);
        }

        private function useColonyItem(_arg_1:int, _arg_2:String):void
        {
            var _local_5:ColonyBean;
            this.currentAction = "usecolonyitem";
            if (this.cityManager.colonies.length == 0)
            {
                this.onCmdFinshed(new ScriptError("This town has no colonies.", -9999));
                return;
            };
            var _local_3:int;
            var _local_4:Array;
            for each (_local_5 in this.cityManager.colonies)
            {
                _local_4 = _local_5.position.split(".");
                if (Map.getFieldId(_local_4[0], _local_4[1]) == _arg_1)
                {
                    _local_3 = _local_5.castleId;
                    break;
                };
            };
            if (_local_3 == 0)
            {
                this.onCmdFinshed(new ScriptError("Target is not a colony of this town.", -9999));
                return;
            };
            var _local_6:String = Items.getItemId(_arg_2);
            if (_local_6 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item name.", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.COLONY_SPEED_UP_ABANDON_COLONY, this.handleCmdResponse);
            ActionFactory.getInstance().getColonyCommands().speedUpAbandonColony(this.castleId, _local_3, _local_6, this.handleCmdResponse);
        }

        public function _getScript():Script
        {
            return (this.script);
        }

        private function chatWc(_arg_1:String):void
        {
            this.currentAction = "sendWorldChatMessage";
            ActionFactory.getInstance().getCommonCommands().worldChat(_arg_1, 0, this.chatHandler);
            this.onCmdFinshed(true);
        }

        private function qFarm():void
        {
            this.onCmdResult("Calling inline command \\qfarm...");
            MainScreen.getInstance()._chatPanel.getCommander()._kj1046();
            this.onCmdFinshed(true);
        }

        private function attack(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "attack";
            this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY, _arg_1, _arg_2, _arg_3, null, _arg_4);
        }

        public function get allCities():Array
        {
            return (MainScreen.getCities());
        }

        private function warTeleport(_arg_1:int):void
        {
            this.currentAction = "warteleport";
            this.cityManager._recallIncomingArmies();
            this.setCmdResponse(ResponseDispatcher.CITY__WAR_MOVE_CASTLE, this.handleCmdResponse);
            ActionFactory.getInstance().getCityCommands().WarMoveCastle(this.castleId, _arg_1);
            this.cityManager._resetLocalFieldsInfo();
        }

        public function get missionTypes():Object
        {
            var obj:Object;
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
            obj["toDebugString"] = function ():String
            {
                var _local_2:String;
                var _local_1:* = "";
                for (_local_2 in obj)
                {
                    if (_local_2 != "toDebugString")
                    {
                        _local_1 = (_local_1 + (((_local_2 + " = ") + obj[_local_2]) + "\n"));
                    };
                };
                return (_local_1);
            };
            return (obj);
        }

        private function endSpamAttack():void
        {
            this.currentAction = "endspamattack";
            this.cityManager._yy805();
            this.onCmdFinshed(true);
        }

        public function stateNameFromFieldId(_arg_1:int):String
        {
            return (Map.getRegionName(_arg_1));
        }

        private function doComfortByType(_arg_1:int):void
        {
            this.setCmdResponse(ResponseDispatcher.INTERIOR_PACIFY_PEOPLE, this.handleCmdResponse);
            CityStateCommands.pacifyPeople(this.castleId, _arg_1);
        }

        private function handleCmdResponse(_arg_1:Object):void
        {
            var _local_2:CommandResponse = (_arg_1 as CommandResponse);
            if (_local_2 == null)
            {
                this.onCmdFinshed(new ScriptError(((("Unknown response when handling response for " + this.currentAction) + " - response: ") + _arg_1.toString()), -9999));
            }
            else
            {
                this.onCmdFinshed(_arg_1);
            };
        }

        private function setGate(_arg_1:Boolean):void
        {
            this.currentAction = "setgate";
            this.onCmdResult(("Set gate to " + ((_arg_1) ? "open" : "closed")));
            this.cityManager._nv1116(_arg_1, null, true);
            this.onCmdFinshed(true);
        }

        private function handleQuestTypeResponse(_arg_1:QuestTypeResponse):void
        {
            var _local_3:QuestTypeBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                scriptQuestActive = false;
                this.onCmdFinshed(new ScriptError(("Error executing completequests: " + _arg_1.errorMsg), _arg_1.ok));
                return;
            };
            if (Version.isTraceOn())
            {
                trace("checkQuestType");
            };
            var _local_2:int;
            for each (_local_3 in _arg_1.typesArray)
            {
                if (((((_local_3.isFinish) || (_local_3.name == "Promotion")) || ((_local_3.typeId >= 113) && (_local_3.typeId <= 115))) || (_local_3.typeId == 64)))
                {
                    findQuestCount++;
                    _local_2++;
                    ActionFactory.getInstance().getQuestCommands().getQuestList(this.castleId, _local_3.typeId);
                };
            };
            if (_local_2 == 0)
            {
                this.onCmdResult("No Finished Quests", "");
                findQuestCastleId = 0;
                scriptQuestActive = false;
                this.onCmdFinshed(true);
            };
        }

        public function getCityFromName(_arg_1:String):CityState
        {
            return (MainScreen.getCityFromName(_arg_1, true));
        }

        private function killWall():void
        {
            this.onCmdResult("Waiting for town's turn to kill wall defense...");
            this.cityManager._reserveEmergencyTimeSlot();
            this.waitForCmActive(this.actKillWall, []);
        }

        private function unFriendPlayerResponseHandler(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.friendBlockPlayerName = null;
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            var _local_2:PlayerInfoBean;
            var _local_3:int;
            while (_local_3 < this.player.friendBeansArray.length)
            {
                if (this.player.friendBeansArray[_local_3].userName.toLowerCase() == this.friendBlockPlayerName.toLowerCase())
                {
                    _local_2 = (this.player.friendBeansArray.removeItemAt(_local_3) as PlayerInfoBean);
                    break;
                };
                _local_3++;
            };
            var _local_4:* = "";
            if (_local_2 != null)
            {
                _local_4 = (('Player "' + _local_2.userName) + '" was successfully removed from your Friends List.');
            }
            else
            {
                _local_4 = (('Player "' + this.friendBlockPlayerName) + '" not found in your Friends List. Check spelling before trying again. No action taken.');
            };
            this.cityManager.logMsg(_local_4);
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(true);
        }

        private function getMayor():HeroBean
        {
            var _local_1:Array = this._bw617(CityStateConstants.HERO_STATUS_MAYOR);
            var _local_2:HeroBean;
            if (_local_1.length == 1)
            {
                _local_2 = _local_1[0];
            };
            return (_local_2);
        }

        private function handleUseItemResponse(_arg_1:UseItemResultResponse):void
        {
            var _local_2:ItemBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.onCmdFinshed(new ScriptError(("Use item error: " + _arg_1.errorMsg), -9999));
                return;
            };
            this.onCmdResult("Item used successfully");
            for each (_local_2 in _arg_1.itemBeansArray)
            {
                this.onCmdResult(((("  Got: " + _local_2.count) + " ") + Items.getItemName(_local_2.id)));
            };
            this.onCmdFinshed(true);
        }

        private function honorGuard(_arg_1:int, _arg_2:TroopBean, _arg_3:int=0):void
        {
            this.currentAction = "honorguard";
            this.cityManager._by1090(_arg_1, _arg_2, _arg_3, true);
            this.onCmdFinshed(true);
        }

        private function skypeGm(groupname:String, msg:String):void
        {
            this.currentAction = "sendSkypeGroupMessage";
            var handler:Function = function (_arg_1:SkypeResponse):void
            {
                if (_arg_1.ok != SkypeConstants.OK_DEFAULT)
                {
                    if (currentAction == "sendSkypeGroupMessage")
                    {
                        onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                    }
                    else
                    {
                        cityManager.logMsg(((_arg_1.errorMsg + ":") + _arg_1.ok));
                    };
                }
                else
                {
                    if (!script.silence)
                    {
                        cityManager.logMsg(_arg_1.msg);
                    };
                    if (currentAction == "sendSkypeGroupMessage")
                    {
                        onCmdFinshed(true);
                    };
                };
            };
            var response:SkypeResponse = Skype.queueMsg(groupname, msg, true, handler);
            if (response.ok != SkypeConstants.OK_DEFAULT)
            {
                if (response.ok == SkypeConstants.OK_MSG_QUEUED)
                {
                    this.cityManager.logMsg("Skype group message has been queued, waiting for login to send...");
                    this.onCmdFinshed(true);
                }
                else
                {
                    this.onCmdFinshed(new ScriptError(("Error sending Skype Group Message: " + response.errorMsg), response.ok));
                };
            };
        }

        private function waitForBuildingQueue(func:Function, args:Array):void
        {
            var handler:Function;
            var waitTimer:Timer;
            this.pleaseStop = false;
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    waitTimer = null;
                    return;
                };
                waitTimer.delay = 1000;
                if (cityManager.isBuildingQueueAvailable())
                {
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    waitTimer = null;
                    func.apply(this, args);
                };
            };
            waitTimer = new Timer(0);
            waitTimer.addEventListener(TimerEvent.TIMER, handler);
            waitTimer.start();
        }

        private function unFriendPlayer(_arg_1:String):void
        {
            this.currentAction = "unfriend player";
            this.friendBlockPlayerName = _arg_1;
            ActionFactory.getInstance().getFriendCommands().deleteFriend(_arg_1, this.unFriendPlayerResponseHandler);
        }

        private function endGuardedAttack():void
        {
            this.currentAction = "endguardedattack";
            this.cityManager._dv194();
            this.onCmdFinshed(true);
        }

        private function star(_arg_1:String, _arg_2:String, _arg_3:int):void
        {
            this.currentAction = "star";
            var _local_4:int = GearType.fromString(_arg_1);
            if (_local_4 <= 0)
            {
                this.logCmdResponse(("Invalid gear type: " + _arg_1));
                this.onCmdFinshed(true);
                return;
            };
            if (((!((_arg_2 = _arg_2.substr(0, 2)) == "fl")) && (!(_arg_2 == "de"))))
            {
                this.logCmdResponse((("Invalid gem type: " + _arg_1) + ", must be delicate or flawless"));
                this.onCmdFinshed(true);
                return;
            };
            if (((_arg_3 <= 0) || (_arg_3 > 4)))
            {
                this.logCmdResponse((("Invalid gem count: " + _arg_3) + ", must be between 1-4"));
                this.onCmdFinshed(true);
                return;
            };
            var _local_5:String = ((_arg_2 == "de") ? Items.getItemId("Delicate_gem") : Items.getItemId("Flawless_gem"));
            if (this.getItemCount(_local_5) < _arg_3)
            {
                this.logCmdResponse((("Not enough gem: " + this.getItemCount(_local_5)) + Items.getItemName(_local_5)));
                this.onCmdFinshed(true);
                return;
            };
            this.setCmdResponse(ResponseDispatcher.EQUIPMENT__ENHANCED_STAR_BY_GEM_STONE, this.starHandler);
            ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(_local_5, _arg_3, _local_4);
        }

        private function awardGold(_arg_1:String):void
        {
            var _local_2:HeroBean;
            _local_2 = this.findHeroByName(_arg_1);
            this.currentAction = "awardgold";
            if (_local_2 == null)
            {
                this.onCmdFinshed(new ScriptError(("No hero found with name: " + _arg_1), -9999));
                return;
            };
            this.onCmdResult(("Award gold to hero " + _local_2));
            this.setCmdResponse(ResponseDispatcher.HERO_AWARD_GOLD, this.handleCmdResponse);
            CityStateCommands.awardGold(this.castleId, _local_2.id, this.handleCmdResponse);
        }

        private function huntingPos(_arg_1:int):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "huntingpos";
            this.cityManager._vw697(Map.fieldIdToCoordString(_arg_1));
            this.onCmdFinshed(true);
        }

        private function valleyHeroes(_arg_1:String):void
        {
            this.currentAction = "valleyheroes";
            this.printGoalCommandWarning();
            this.cityManager._ap1008(_arg_1);
            this.onCmdFinshed(true);
        }

        private function setTaxRate(_arg_1:int):void
        {
            this.onCmdResult((("Setting tax rate to " + _arg_1.toString()) + "."));
            CityStateCommands.modifyTaxRate(this.castleId, _arg_1, this.handleCmdResponse);
        }

        public function get cm():CityManager
        {
            return (this.cityManager);
        }

        private function abandonTown2():void
        {
            this.currentAction = "abandontown";
            this.cityManager._recallIncomingArmies();
            this.onCmdResult(("Abandon town " + this.castle.name));
            this.setCmdResponse(ResponseDispatcher.CITY_GIVEUP_CASTLE, this.handleCmdResponse);
            CityStateCommands.giveupCastle(LoginHelper.getInstance().getHashedEvonyPw(), this.castleId);
        }

        private function bigReinforce(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:ResourceBean=null, _arg_5:String=""):void
        {
            this.currentAction = "bigreinforce";
            this.doMarch(ObjConstants.ARMY_MISSION_SEND, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, true);
        }

        private function _fq231(_arg_1:ArmyPracticeResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.logCmdResponse(("Excercise error: " + _arg_1.msg));
                this.onCmdFinshed(true);
                return;
            };
            if (_arg_1.result == ArmyPracticeResponse.ARMY_PRACTICE_RESULT_ATTACK_WIN)
            {
                this.onCmdResult((("  Attacker wins in " + _arg_1.round) + " rounds"));
            }
            else
            {
                this.onCmdResult((("  Defender wins in " + _arg_1.round) + " rounds"));
            };
            this.onCmdResult(("  Attacker lost: " + Utils.troopBeanToString(_arg_1.attackLostTroop)));
            this.onCmdResult(("  Defender lost: " + Utils.troopBeanToString(_arg_1.defendLostTroop)));
            this.onCmdFinshed(true);
        }

        private function npcHeroes(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "npcheroes";
            this.cityManager._cfg_npcHeroes(_arg_1);
            this.onCmdFinshed(true);
        }

        private function claimPackage(_arg_1:int):void
        {
            this.currentAction = "claimGiftPackage";
            ActionFactory.getInstance().getCommonCommands().getPackage(_arg_1, "", this.claimPackageResponse);
        }

        private function npc10Troop(_arg_1:TroopBean):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "npctroops";
            this.cityManager._setNpcTroopCond(Utils.troopBeanToMsgString(_arg_1));
            this.onCmdFinshed(true);
        }

        private function abandon(_arg_1:int):void
        {
            this.currentAction = "abandon";
            CityStateCommands.giveUpField(_arg_1);
            this.onCmdResult(("Abandoned " + Map.fieldIdToString(_arg_1)));
            this.onCmdFinshed(true);
        }

        private function waitResearch(func:Function, args:Array):void
        {
            var handler:Function;
            var waitTimer:Timer;
            this.pleaseStop = false;
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    waitTimer = null;
                    return;
                };
                waitTimer.delay = 1000;
                if (cityManager.getResearchInProgress() == null)
                {
                    func.apply(this, args);
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    waitTimer = null;
                };
            };
            waitTimer = new Timer(0);
            waitTimer.addEventListener(TimerEvent.TIMER, handler);
            waitTimer.start();
        }

        private function handleGetColonyArmyInfoResponse(_arg_1:ColonialArmyResponse):void
        {
            var _local_2:ArmyBean;
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(("Error received: " + _arg_1.errorMsg), -9999));
                return;
            };
            if (_arg_1.armyBeansArray.length == 0)
            {
                this.onCmdResult("No army in colony");
                this.onCmdFinshed(true);
            }
            else
            {
                this.onCmdResult("Armies found in colony");
                for each (_local_2 in _arg_1.armyBeansArray)
                {
                    this.cityManager.logMsg(("  " + Utils.armyToString(_local_2)));
                };
                this.onCmdFinshed(true);
            };
        }

        private function doMarch(marchType:int, targetId:int, hero:String, troopObj:TroopBean, resources:ResourceBean=null, restTime:String="", warEnsign:Boolean=false, stygandrsBannerOfTheHorde:Boolean=false, argGearing:int=0, callback:Function=null):void
        {
            var selectedHero:HeroBean;
            var armyReady:Boolean;
            var minStamina:int;
            var waitTimeCount:int;
            var handler:Function;
            var timer:Timer;
            if (targetId == this.castle.fieldId)
            {
                this.logCmdResponse(this.currentAction, "- destination is the current castle");
                this.onCmdFinshed(true);
                return;
            };
            if (targetId == -1)
            {
                this.logCmdResponse(this.currentAction, "- Invalid target coordinates.  Specify coords as 'x, y'");
                this.onCmdFinshed(true);
                return;
            };
            if (troopObj == null)
            {
                this.logCmdResponse(this.currentAction, "- invalid troop");
                this.onCmdFinshed(true);
                return;
            };
            this.pleaseStop = false;
            selectedHero = null;
            armyReady = false;
            minStamina = ((marchType == ObjConstants.ARMY_MISSION_SEND) ? 1 : ((marchType == ObjConstants.ARMY_MISSION_TRANS) ? 2 : 4));
            waitTimeCount = 0;
            handler = function (e:TimerEvent):void
            {
                var newArmy:NewArmyParam;
                var baseTravelTime:Number;
                var rsSpeedUp:int;
                var heroSpeedUp:Number;
                var travelTime:int;
                var buffsCampFactor:Number;
                var restTimeNumeric:Number;
                if (waitTimeCount == 1)
                {
                    onCmdResult("Checking for available hero and troops...", "");
                };
                waitTimeCount++;
                timer.delay = 1500;
                if (pleaseStop)
                {
                    onCmdFinshed(new ScriptError("Script stop, troop deployment cancelled", -9999));
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    return;
                };
                armyReady = isRallySlotAvailable();
                try
                {
                    if (armyReady)
                    {
                        if (((hero.length == 0) || (hero.toLowerCase() == "none")))
                        {
                            armyReady = ((true) && (armyReady));
                        }
                        else
                        {
                            selectedHero = getHeroByNameOrKey(hero, minStamina);
                            armyReady = ((!(selectedHero == null)) && (armyReady));
                        };
                    };
                }
                catch(se:ScriptError)
                {
                    onCmdFinshed(se);
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    return;
                };
                if (armyReady)
                {
                    armyReady = ((cityHasEnoughTroops(troopObj)) && (armyReady));
                };
                if (armyReady)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    newArmy = new NewArmyParam();
                    newArmy.missionType = marchType;
                    newArmy.targetPoint = targetId;
                    newArmy.troops = troopObj;
                    newArmy.useFlag = warEnsign;
                    newArmy.useItem = stygandrsBannerOfTheHorde;
                    if (selectedHero != null)
                    {
                        newArmy.heroId = selectedHero.id;
                        if (argGearing > 0)
                        {
                            ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(selectedHero.id, argGearing);
                            onCmdResult((((" Changing gear to " + ((argGearing == 1) ? "Pol" : ((argGearing == 2) ? "Atk" : "Int"))) + " for ") + selectedHero.name));
                        };
                    };
                    if (resources == null)
                    {
                        resources = new ResourceBean();
                    };
                    newArmy.resource = resources;
                    baseTravelTime = cityManager.getBaseTravelTime(castle.fieldId, targetId, troopObj);
                    rsSpeedUp = ((((!(MainScreen.getCityFromFieldId(targetId) == null)) || ((((Map.getType(targetId) == FieldConstants.TYPE_CASTLE) && (!(Map.getDetailInfo(targetId, 30).allianceName == null))) && (!(player.playerInfo.alliance == null))) && (Map.getDetailInfo(targetId, 30).allianceName == player.playerInfo.alliance))) && ((marchType == ObjConstants.ARMY_MISSION_SEND) || (marchType == ObjConstants.ARMY_MISSION_TRANS))) ? _getReliefStationSpeedupFactor() : 1);
                    heroSpeedUp = ((selectedHero != null) ? Utils.getHeroSpeedFactor(selectedHero) : 1);
                    travelTime = int(((baseTravelTime / rsSpeedUp) / heroSpeedUp));
                    buffsCampFactor = 1;
                    restTimeNumeric = 0;
                    if (restTime != "")
                    {
                        buffsCampFactor = cityManager.getCampTimeChangeBuffsFactor();
                        if (((travelTime == 0) && (buffsCampFactor == 1)))
                        {
                            onCmdFinshed(new ScriptError("No troop or town has yet to be initialized (research not available)", -9999));
                            return;
                        };
                        if ((restTimeNumeric = _parseRestTime(restTime, travelTime)) > 0)
                        {
                            if (restTimeNumeric > (20 * 3600))
                            {
                                logCmdResponse(("WARNING: Large camp time " + Utils.formatTime(restTimeNumeric)), "", "#FF0000");
                            };
                            if (int((int(restTimeNumeric) * buffsCampFactor)) > ((24 * 60) * 60))
                            {
                                onCmdFinshed(new ScriptError((("Camp time exceeds server limit at " + Utils.formatTime((int(restTimeNumeric) * buffsCampFactor))) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]"), -9999));
                                return;
                            };
                        }
                        else
                        {
                            if (restTimeNumeric < 0)
                            {
                                logCmdResponse("WARNING: Inappropriate camp time is ignored", "", "#FF0000");
                                if (restTime.charAt(0) == "+")
                                {
                                    logCmdResponse("  make sure you run 'calibrate' recently!", "", "#FF0000");
                                };
                                restTimeNumeric = 0;
                            };
                        };
                    };
                    setCmdResponse(ResponseDispatcher.ARMY_NEW_ARMY, handleCmdResponse);
                    newArmy.restTime = int(restTimeNumeric);
                    onCmdResult(currentAction, (((((((((("- starting march to " + Map.fieldIdToCoordString(targetId)) + " arrival at ") + Utils.getLogTimeStr(((Utils.getServerTime() + campTimeDelta) + ((travelTime + restTimeNumeric) * 1000)))) + ((selectedHero == null) ? "" : (" using " + selectedHero.name))) + " with ") + Utils.troopBeanToMsgString(troopObj)) + " carrying ") + Utils.resourceBeanToString(resources)) + " in ") + Utils.formatTime((travelTime + newArmy.restTime))));
                    if (restTime != "")
                    {
                        Utils.callLater(((restTimeNumeric - newArmy.restTime) * 1000), CityStateCommands.newArmy, [castleId, newArmy]);
                    }
                    else
                    {
                        CityStateCommands.newArmy(castleId, newArmy);
                    };
                };
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function completeQuests(_arg_1:String="daily"):void
        {
            this.currentAction = "completequests";
            if (findQuestCastleId != 0)
            {
                if (Version.isTraceOn())
                {
                    trace(("Quest waiting: " + findQuestCastleId));
                };
                this.logCmdResponse("Only one city at a time may use completequests");
                this.onCmdFinshed(false);
                return;
            };
            scriptQuestActive = true;
            findQuestCastleId = this.castleId;
            findQuestCount = 0;
            this.setCmdResponse(ResponseDispatcher.QUEST_GET_QUEST_TYPE, this.handleQuestTypeResponse);
            this.setCmdResponse(ResponseDispatcher.QUEST_GET_QUEST_LIST, this.handleQuestListResponse);
            switch (_arg_1.toLowerCase())
            {
                case "routine":
                    ActionFactory.getInstance().getQuestCommands().getQuestType(this.castleId, 1);
                    return;
                case "daily":
                    ActionFactory.getInstance().getQuestCommands().getQuestType(this.castleId, 3);
                    return;
                case "donate":
                    ActionFactory.getInstance().getQuestCommands().getQuestType(this.castleId, 4);
                    return;
                default:
                    scriptQuestActive = false;
                    findQuestCastleId = 0;
                    this.onCmdFinshed(new ScriptError("Invalid quest type. Valid values are: 'routine', 'daily', 'donate'", -9999));
                    return;
            };
        }

        private function getSpamHero(_arg_1:String="power"):void
        {
            this.currentAction = "getspamhero";
            _arg_1 = _arg_1.toLowerCase();
            if (((_arg_1 == "atk") || (_arg_1 == "attack")))
            {
                _arg_1 = "power";
            }
            else
            {
                if ((((_arg_1 == "pol") || (_arg_1 == "politic")) || (_arg_1 == "politics")))
                {
                    _arg_1 = "management";
                }
                else
                {
                    if ((((_arg_1 == "int") || (_arg_1 == "intel")) || (_arg_1 == "intell")))
                    {
                        _arg_1 = "stratagem";
                    };
                };
            };
            this.cityManager._getSpamHero(_arg_1);
            Utils.callLater(1500, this.onCmdFinshed, [true]);
        }

        public function _qKillWall():void
        {
            var _local_3:int;
            if (this.cityManager.fortification == null)
            {
                this.onCmdResult("No Walls to Destroy");
                return;
            };
            this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT, this.handleCmdResponse);
            var _local_1:int;
            var _local_2:Array = [TFConstants.F_TRAP, TFConstants.F_ABATIS, TFConstants.F_ARROWTOWER, TFConstants.F_ROLLINGLOGS, TFConstants.F_ROCKFALL];
            for each (_local_3 in _local_2)
            {
                _local_1 = this.cityManager.fortification[Utils.troopIntNames[_local_3]];
                this.onCmdResult(((("Destroying " + _local_1) + " of fortification: ") + Utils.troopIntNames[_local_3]));
                CityStateCommands.destructWallProtect(this.castleId, _local_3, _local_1);
            };
            this.cityManager._clearWallQueue(0);
        }

        public function getCityFromCastleId(_arg_1:int):CityState
        {
            return (MainScreen.getCityFromCastleId(_arg_1));
        }

        private function _sp1096(_arg_1:Object):void
        {
            var _local_5:*;
            var _local_6:*;
            var _local_7:*;
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.msg, _arg_1.ok));
                return;
            };
            var _local_2:ReportListResponse = (_arg_1 as ReportListResponse);
            if (((_local_2 == null) || (_local_2.reportsArray.length == 0)))
            {
                this.onCmdFinshed(new ScriptError("No reports", -9999));
                return;
            };
            var _local_3:String = CallbackParams.cleanReportsSearchString;
            var _local_4:Array = _local_3.toLowerCase().split(",");
            for each (_local_5 in _local_2.reportsArray)
            {
                for each (_local_6 in _local_4)
                {
                    if (((_local_5.targetPos.toLowerCase().search(_local_6) > -1) || (_local_5.title.toLowerCase().search(_local_6) > -1)))
                    {
                        if (!this.reportIdsToDelete.contains(_local_5.id))
                        {
                            this.reportIdsToDelete.addItem(_local_5.id);
                            break;
                        };
                    };
                };
            };
            if (_local_2.pageNo < _local_2.totalPage)
            {
                this.cleanReports(_local_3, (_local_2.pageNo + 1));
                return;
            };
            if (this.reportIdsToDelete.length > 0)
            {
                for each (_local_7 in this.reportIdsToDelete)
                {
                    ActionFactory.getInstance().getReportCommands().deleteReport(String(_local_7));
                };
                this.onCmdResult("Delete ", (this.reportIdsToDelete.length + " reports."));
                this.reportIdsToDelete.removeAll();
                this.onCmdFinshed(true);
                return;
            };
            this.onCmdFinshed(new ScriptError("No reports to delete", -9999));
        }

        public function getMapType(_arg_1:int):int
        {
            return (Map.getType(_arg_1));
        }

        public function _qWallDefenseNow(_arg_1:int=14, _arg_2:int=1):void
        {
            if ((((((!(_arg_1 == TFConstants.F_TRAP)) && (!(_arg_1 == TFConstants.F_ABATIS))) && (!(_arg_1 == TFConstants.F_ARROWTOWER))) && (!(_arg_1 == TFConstants.F_ROLLINGLOGS))) && (!(_arg_1 == TFConstants.F_ROCKFALL))))
            {
                this.onCmdResult((("Unknown Wall type :( [" + Utils.troopExtNames[_arg_1]) + "]"));
                return;
            };
            if (_arg_2 > 0)
            {
                this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT, this.handleCmdResponse);
                while (((_arg_2 > 0) && ((!(this.cityManager._isEnoughSlotsOnWall(_arg_2, _arg_1))) || (!(this.cityManager._isEnoughResoToProduceFort(_arg_1, _arg_2))))))
                {
                    _arg_2 = int((_arg_2 / 1.01));
                };
                if (_arg_2 == 0)
                {
                    this.onCmdResult((("No fortifications of type " + Utils.troopExtNames[_arg_1]) + " can be queued at this time."));
                    return;
                };
                this.onCmdResult((((("Queued " + _arg_2) + " fortifications of type: ") + Utils.troopExtNames[_arg_1]) + "."));
                CityStateCommands.produceWallProtect(this.castleId, _arg_1, _arg_2);
                Utils.callLater(2000, this.cityManager.updateWallQueue);
                return;
            };
            if (_arg_2 < 0)
            {
                this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT, this.handleCmdResponse);
                _arg_2 = Math.abs(_arg_2);
                if (((!(this.cityManager.fortification == null)) && (_arg_2 > this.cityManager.fortification[Utils.troopIntNames[_arg_1]])))
                {
                    _arg_2 = this.cityManager.fortification[Utils.troopIntNames[_arg_1]];
                };
                this.onCmdResult(((("Destroyed " + _arg_2) + " of fortification: ") + Utils.troopExtNames[_arg_1]));
                CityStateCommands.destructWallProtect(this.castleId, _arg_1, _arg_2);
                return;
            };
        }

        private function listBuffs():void
        {
            this.currentAction = "listbuffs";
            this.cityManager._printPlayerBuffs();
            this.onCmdFinshed(true);
        }

        public function getItemId(_arg_1:String):String
        {
            return (Items.getItemId(_arg_1));
        }

        private function handleChangeHeroGearResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cityManager.logMsg(("Error: " + _arg_1.errorMsg.split("<").join("&lt;").split(">").join("&gt;")), "#CC0000");
            };
        }

        private function endKeepTroop():void
        {
            this.currentAction = "endkeeptroop";
            this.cityManager._ji428();
            this.onCmdFinshed(true);
        }

        private function useAdvByHiddenPathHandler(_arg_1:Object):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.onCmdFinshed(new ScriptError(((("Error received for " + this.currentAction) + " - response: ") + _arg_1.errorMsg), _arg_1.ok));
            }
            else
            {
                this.cityManager._clearLastAmbushErrorTime();
                this.onCmdFinshed(_arg_1);
            };
        }

        private function changeHeroGear(heroName:String, gearSet:String):void
        {
            var gearTypes:Array;
            var gearType:int;
            var hero:HeroBean;
            var func:Function;
            var timer:Timer;
            this.currentAction = "changeHeroGear";
            gearTypes = new Array("none", "pol", "atk", "int");
            gearType = gearTypes.indexOf(gearSet.toLowerCase());
            if (gearType == -1)
            {
                this.onCmdFinshed(new ScriptError("Invalid gear type, must be either none, pol, atk, or int", -9999));
                return;
            };
            hero = null;
            if (heroName.toLowerCase() == "all")
            {
                for each (hero in this.cityManager.heroes)
                {
                    if (hero.status == HeroConstants.HERO_FREE_STATU)
                    {
                        this.cityManager.logMsg(((("Changing gear on " + hero.name) + " to ") + gearTypes[gearType]), "#000000");
                        if (gearType == 0)
                        {
                            ActionFactory.getInstance().getEquipmentCommands().TakeOffAllEquipmenttech(hero.id, this.handleChangeHeroGearResponse);
                        }
                        else
                        {
                            ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(hero.id, gearType, this.handleChangeHeroGearResponse);
                        };
                    };
                };
                func = function (_arg_1:TimerEvent=null):void
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, func);
                    timer = null;
                    onCmdFinshed(true);
                };
                timer = new Timer(500);
                timer.repeatCount = 1;
                timer.addEventListener(TimerEvent.TIMER, func);
                timer.start();
            }
            else
            {
                hero = this.findHeroByName(heroName);
                if (hero == null)
                {
                    this.onCmdFinshed(new ScriptError(("No hero found with name: " + heroName), -9999));
                    return;
                };
                if (gearType == 0)
                {
                    ActionFactory.getInstance().getEquipmentCommands().TakeOffAllEquipmenttech(hero.id, this.handleCmdResponse);
                }
                else
                {
                    ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(hero.id, gearType, this.handleCmdResponse);
                };
            };
        }

        public function getCityFromCoord(_arg_1:String, _arg_2:String=null):CityState
        {
            return (MainScreen.getCityFromFieldId(Map.coordStringToFieldId((_arg_1 + ((_arg_2 != null) ? ("," + _arg_2) : "")))));
        }

        private function unsetNpcFlag(_arg_1:int):void
        {
            this.currentAction = "unsetnpcflag";
            this.cityManager._markAndUnmarkFlatForNpc(_arg_1, false);
            this.onCmdFinshed(true);
        }

        private function buy(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            this.currentAction = "buy";
            this.trade("buy", _arg_1, _arg_2, _arg_3);
        }

        private function getHeroByNameOrKey(_arg_1:String, _arg_2:int=4):HeroBean
        {
            var _local_12:String;
            var _local_3:ArrayCollection = new ArrayCollection();
            var _local_4:ArrayCollection = new ArrayCollection();
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_8:HeroBean;
            var _local_9:String;
            var _local_10:String;
            var _local_11:Array = _arg_1.toLowerCase().split(",");
            for each (_local_12 in _local_11)
            {
                if (Version.isTraceOn())
                {
                    trace(("heroStr: " + _local_12));
                };
                if (_local_12.substr(0, 1) == "!")
                {
                    _local_9 = this.getHeroNamesFromMacroNames(_local_12.substr(1));
                    if (Version.isTraceOn())
                    {
                        trace(("fromMacro: " + _local_9));
                    };
                    if (_local_9.indexOf(";") > -1)
                    {
                        for each (_local_10 in _local_9.split(";"))
                        {
                            if (Version.isTraceOn())
                            {
                                trace(("heroName" + _local_10));
                            };
                            _local_4.addItem(_local_10);
                        };
                    }
                    else
                    {
                        _local_4.addItem(_local_9);
                    };
                }
                else
                {
                    if (_local_12 == "any")
                    {
                        _local_7 = true;
                    }
                    else
                    {
                        if (((_local_12.substr(0, 4) == "any+") || (_local_12.substr(0, 4) == "any-")))
                        {
                            _local_5 = true;
                            for each (_local_8 in this.cityManager.getHeroesByPowerAndStamina(int(_local_12.substring(3)), _arg_2))
                            {
                                _local_3.addItem(_local_8.name.toLowerCase());
                            };
                        }
                        else
                        {
                            _local_9 = this.getHeroNamesFromMacroNames(_local_12);
                            if (Version.isTraceOn())
                            {
                                trace(("fromMacro: " + _local_9));
                            };
                            if (_local_9.indexOf(";") > -1)
                            {
                                for each (_local_10 in _local_9.split(";"))
                                {
                                    if (Version.isTraceOn())
                                    {
                                        trace(("heroName" + _local_10));
                                    };
                                    _local_3.addItem(_local_10);
                                };
                            }
                            else
                            {
                                _local_3.addItem(_local_9);
                            };
                        };
                    };
                };
            };
            for each (_local_8 in this.cityManager._ox998())
            {
                if (!_local_4.contains(_local_8.name.toLowerCase()))
                {
                    if (((_local_3.contains(_local_8.name.toLowerCase())) || (_local_7)))
                    {
                        _local_6 = true;
                        if (!((!(_local_8.status == CityStateConstants.HERO_STATUS_IDLE)) || (_local_8.stamina < _arg_2)))
                        {
                            this.onVerboseCmdResult(("getIdleHero - hero selected: " + _local_8.name));
                            return (_local_8);
                        };
                    };
                };
            };
            if (((!(_local_6)) && (!(_local_5))))
            {
                throw (new ScriptError("You failed to specify a valid hero or 'any'", -9999));
            };
            return (null);
        }

        private function test():void
        {
            this.onCmdResult("test - nothing to execute");
            this.onCmdFinshed(true);
        }

        private function onVerboseCmdResult(_arg_1:String):void
        {
            if (this.verboseLogs)
            {
                this.onCmdResult(_arg_1);
            };
        }

        public function _parseRestTime(_arg_1:String, _arg_2:int=0):Number
        {
            if (_arg_1.length == 0)
            {
                return (0);
            };
            var _local_3:Boolean = ((_arg_1.charAt(0) == "@") || (_arg_1.charAt(0) == "a"));
            var _local_4:* = (_arg_1.charAt(0) == "+");
            var _local_5:int;
            while (((_local_5 < _arg_1.length) && ((_arg_1.charAt(_local_5) < "0") || (_arg_1.charAt(_local_5) > "9"))))
            {
                _local_5++;
            };
            _arg_1 = _arg_1.slice(_local_5);
            if (_arg_1.length == 0)
            {
                return (0);
            };
            if (_local_4)
            {
                return (((((lastCalibrateTime - campTimeDelta) - Utils.getServerTime()) / 1000) + this.parseTime(_arg_1, false)) - _arg_2);
            };
            if (!_local_3)
            {
                return (this.parseTime(_arg_1, false));
            };
            var _local_6:Number = this.parseTime(_arg_1, true);
            if ((_arg_2 + (campTimeDelta / 1000)) > _local_6)
            {
                return (0);
            };
            return ((_local_6 - _arg_2) - (campTimeDelta / 1000));
        }

        public function qdeploy(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:TroopBean, _arg_5:ResourceBean=null, _arg_6:String="", _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:int=0):String
        {
            return (this._doQuickMarch(getMissionConstFromString(_arg_1), _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9));
        }

        private function rallyMax(_arg_1:String):void
        {
            this.currentAction = "getRallymax";
            this.printGoalCommandWarning();
            this.cityManager._setRallyMax(_arg_1);
            this.onCmdFinshed(true);
        }

        private function setGoal():void
        {
            MainScreen.getInstance()._cityPanel.onSetGoals(this.castleId);
            this.onCmdFinshed(true);
        }

        private function persuadeHero(_arg_1:String):void
        {
            var _local_4:HeroBean;
            var _local_2:HeroBean;
            var _local_3:Boolean;
            this.currentAction = "persuadehero";
            for each (_local_4 in this.cityManager._ox998())
            {
                if (_local_4.name.toLowerCase() == _arg_1.toLowerCase())
                {
                    _local_3 = true;
                    if (_local_4.status == CityStateConstants.HERO_STATUS_CAPTIVE)
                    {
                        _local_2 = _local_4;
                    };
                };
            };
            if (_local_2 != null)
            {
                this.setCmdResponse(ResponseDispatcher.HERO_TRY_GET_SEIZED_HERO, this.handleCmdResponse);
                this.onCmdResult(("Persuade hero " + _arg_1));
                CityStateCommands.tryGetSeizedHero(this.castleId, _local_2.id);
                return;
            };
            this.onCmdFinshed(new ScriptError("You failed to specify a valid idle hero", -9999));
        }

        private function setMayorByType(_arg_1:String="politics"):Object
        {
            var _local_12:HeroBean;
            var _local_13:Array;
            var _local_2:Object = new Object();
            _local_2.finishedresult = true;
            if (this.castle.herosArray.length < 1)
            {
                _local_2.finishedresult = new ScriptError("has no heroes", -9999);
                return (_local_2);
            };
            var _local_3:String;
            var _local_4:String;
            var _local_5:int;
            if ("at" == _arg_1.toLowerCase().substr(0, 2))
            {
                _local_3 = "[attack ";
                _local_4 = "power";
                _local_5 = 2;
            }
            else
            {
                if ("po" == _arg_1.toLowerCase().substr(0, 2))
                {
                    _local_3 = "[politics ";
                    _local_4 = "management";
                    _local_5 = 1;
                }
                else
                {
                    if ("in" != _arg_1.toLowerCase().substr(0, 2))
                    {
                        if ("re" == _arg_1.toLowerCase().substr(0, 2))
                        {
                            CityStateCommands.dischargeChief(this.castleId);
                            this.onCmdResult("Removed current mayor");
                            return (_local_2);
                        };
                        _local_2.finishedresult = new ScriptError((("Invalid Hero search type: [" + _arg_1) + "]"), -9999);
                        return (_local_2);
                    };
                    _local_3 = "[intelligence ";
                    _local_4 = "stratagem";
                    _local_5 = 3;
                };
            };
            var _local_6:HeroBean;
            var _local_7:HeroBean;
            var _local_8:int = -1;
            var _local_9:Number = -1;
            var _local_10:String;
            var _local_11:Number = -1;
            for each (_local_12 in this.castle.herosArray)
            {
                if (_local_12.status == CityStateConstants.HERO_STATUS_MAYOR)
                {
                    _local_11 = Utils.getTotalPointsForHeroAttribute(_local_12, _local_4);
                    _local_6 = _local_12;
                }
                else
                {
                    if (((Utils.getTotalPointsForHeroAttribute(_local_12, _local_4) > _local_9) && (_local_12.status == CityStateConstants.HERO_STATUS_IDLE)))
                    {
                        _local_8 = _local_12.id;
                        _local_7 = _local_12;
                        _local_9 = Utils.getTotalPointsForHeroAttribute(_local_12, _local_4);
                        _local_10 = _local_12.name;
                    };
                };
            };
            _local_13 = null;
            if (((!(_local_8 == -1)) && (_local_9 > _local_11)))
            {
                this.onCmdResult(((((("Promoted " + _local_10) + " to mayor ") + _local_3) + _local_9) + "]"), "");
                CityStateCommands.promoteToChief(this.castleId, _local_8, this.handleCmdResponse);
            }
            else
            {
                _local_2.finishedresult = new ScriptError("Did not change mayor.  None available or current mayor is highest level.", -9999);
                return (_local_2);
            };
            return (_local_2);
        }

        private function starHandler(_arg_1:GemstoneRespone):void
        {
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            this.onCmdResult(((("Star level for " + GearType.toNameString(_arg_1.equipmenttechid)) + " is now ") + _arg_1.enhancedstarlv));
            this.cityManager._handleStarLevelResponse(_arg_1);
            this.onCmdFinshed(true);
        }

        private function releaseHero(_arg_1:int=69, _arg_2:int=150):void
        {
            var _local_5:HeroBean;
            this.currentAction = "releasehero";
            var _local_3:HeroBean;
            var _local_4:ArrayCollection = this.cityManager._ox998();
            for each (_local_5 in _local_4)
            {
                if (_local_5.status == CityStateConstants.HERO_STATUS_CAPTIVE)
                {
                    if ((((((_local_5.management - (_local_5.level - 1)) < _arg_1) && ((_local_5.power - (_local_5.level - 1)) < _arg_1)) && ((_local_5.stratagem - (_local_5.level - 1)) < _arg_1)) && (_local_5.level < _arg_2)))
                    {
                        _local_3 = _local_5;
                    }
                    else
                    {
                        this.onCmdResult(((((((((("Keeping hero " + _local_3.name) + " with stats Lvl:") + _local_3.level) + " Pol:") + _local_3.management) + " Atk:") + _local_3.power) + " Int:") + _local_3.stratagem));
                    };
                };
            };
            if (_local_3 != null)
            {
                this.setCmdResponse(ResponseDispatcher.HERO_RELEASE_HERO, this.handleCmdResponse);
                this.onCmdResult(((((((((("Releasing hero " + _local_3.name) + " with stats Lvl:") + _local_3.level) + " Pol:") + _local_3.management) + " Atk:") + _local_3.power) + " Int:") + _local_3.stratagem));
                CityStateCommands.releaseHero(this.castleId, _local_3.id);
                return;
            };
            this.onCmdFinshed(new ScriptError("Couldn't find any captive hero", -9999));
        }

        private function trainTo(_arg_1:TroopBean, _arg_2:String="atk", _arg_3:String="all", _arg_4:int=1):void
        {
            var _local_7:String;
            if (_arg_1 == null)
            {
                this.onCmdResult(" usage: trainto limit [hero] [barrackid | all | idle] [min amount]", "");
                this.onCmdResult("sample: trainto a:400000,s:200000", "");
                this.onCmdResult("Trains archers or scouts if you don't yet have 400000 archers or 200000 scouts", "");
                this.onCmdResult("Other parameters are similar to train script command", "");
                this.onCmdFinshed(true);
                return;
            };
            var _local_5:TroopBean = this.cityManager._getAllTroopPlusQueued();
            var _local_6:TroopBean = new TroopBean();
            for each (_local_7 in ["", "", "peasants", "militia", "scouter", "pikemen", "swordsmen", "archer", "carriage", "lightCavalry", "heavyCavalry", "ballista", "batteringRam", "catapult"])
            {
                if (_local_7 != "")
                {
                    if ((_local_5[_local_7] < _arg_1[_local_7]))
                    {
                        _local_6[_local_7] = (_arg_1[_local_7] - _local_5[_local_7]);
                        if (_local_6[_local_7] < _arg_4)
                        {
                            _local_6[_local_7] = 0;
                        }
                        else
                        {
                            this.onCmdResult("Waiting for town's turn to train troop...");
                            this.cityManager._reserveEmergencyTimeSlot();
                            this.waitForCmActive(this.train2, [_local_6, _arg_2, _arg_3, _arg_4]);
                            return;
                        };
                    };
                };
            };
            this.onCmdResult("Nothing to train");
            this.onCmdFinshed(true);
        }

        private function abandonTown():void
        {
            this.currentAction = "abandontown";
            if (this.cityManager.localArmies.length > 0)
            {
                this.onCmdResult("Town still has outgoing army, please use 'abandontown!' instead");
                this.onCmdFinshed(true);
                return;
            };
            if (Utils.getTotalTroopCount(this.cityManager.troop) > 250)
            {
                this.onCmdResult("Town still has 250+ troops, please use 'abandontown!' instead");
                this.onCmdFinshed(true);
                return;
            };
            if ((((this.cityManager._cityStillHasGoodHeroes()) || ((!(this.cityManager.bestAttackHero() == null)) && (this.cityManager.bestAttackHero().level >= 90))) || ((!(this.cityManager.bestPoliticHero() == null)) && (this.cityManager.bestPoliticHero().level >= 90))))
            {
                this.onCmdResult("Please fire all good heroes first or use 'abandontown!' instead");
                this.onCmdFinshed(true);
                return;
            };
            this.abandonTown2();
        }

        private function autoStar(tech:String, targetLevel:int, spec1:String=null, spec2:String=null, spec3:String=null, spec4:String=null, spec5:String=null, spec6:String=null, spec7:String=null, spec8:String=null):void
        {
            var techId:int;
            var currentLevel:int;
            var delicateId:String;
            var flawlessId:String;
            var conditions:Array;
            var busy:Boolean;
            var starHandler:Function;
            var handler:Function;
            var timer:Timer;
            var count:int;
            this.currentAction = "autostar";
            if (((targetLevel > 15) || (targetLevel <= 0)))
            {
                this.logCmdResponse(("Invalid gear type: " + tech));
                this.onCmdFinshed(true);
                return;
            };
            techId = GearType.fromString(tech);
            if (techId <= 0)
            {
                this.logCmdResponse(("Invalid gear type: " + tech));
                this.onCmdFinshed(true);
                return;
            };
            if (this.cityManager.gears.length == 0)
            {
                this.cityManager.updateGears();
                this.logCmdResponse("Gears not initialized yet, please rerun later");
                this.onCmdFinshed(true);
                return;
            };
            currentLevel = this.cityManager.getStarLevel(techId);
            if (currentLevel >= targetLevel)
            {
                this.onCmdResult(("autostar: Nothing to do, star level is already " + currentLevel));
                this.onCmdFinshed(true);
                return;
            };
            delicateId = Items.getItemId("Delicate_gem");
            flawlessId = Items.getItemId("Flawless_gem");
            var gem2:String;
            var parts:Array;
            conditions = new Array();
            var specs:Array = new Array();
            if (spec1 != null)
            {
                specs.push(spec1);
            };
            if (spec2 != null)
            {
                specs.push(spec2);
            };
            if (spec3 != null)
            {
                specs.push(spec3);
            };
            if (spec4 != null)
            {
                specs.push(spec4);
            };
            if (spec5 != null)
            {
                specs.push(spec5);
            };
            if (spec6 != null)
            {
                specs.push(spec6);
            };
            if (spec7 != null)
            {
                specs.push(spec7);
            };
            if (spec8 != null)
            {
                specs.push(spec8);
            };
            var i:int;
            while (i < specs.length)
            {
                parts = specs[i].split(":");
                if (parts.length != 4)
                {
                    this.logCmdResponse(("Invalid autostar specification, expect start:end:gem:count, get " + specs[i]));
                    this.onCmdFinshed(true);
                };
                gem2 = parts[2].substr(0, 2);
                if (((!(gem2 == "fl")) && (!(gem2 == "de"))))
                {
                    this.logCmdResponse(((("Invalid gem type: " + tech) + ", must be delicate or flawless in ") + specs[i]));
                    this.onCmdFinshed(true);
                    return;
                };
                count = int(parts[3]);
                if (((count <= 0) || (count > 4)))
                {
                    this.logCmdResponse(((("Invalid gem count: " + tech) + ", must be between 1-4 in ") + specs[i]));
                    this.onCmdFinshed(true);
                    return;
                };
                conditions.push({
                    "start":int(parts[0]),
                    "end":int(parts[1]),
                    "itemId":((gem2 == "fl") ? flawlessId : delicateId),
                    "count":int(parts[3])
                });
                i = (i + 1);
            };
            busy = false;
            this.pleaseStop = false;
            starHandler = function (_arg_1:GemstoneRespone):void
            {
                busy = false;
                if (_arg_1.ok != 1)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    logCmdResponse(("  autostar error: " + _arg_1.errorMsg));
                    onCmdFinshed(true);
                    return;
                };
                var _local_2:String = ((currentLevel > _arg_1.enhancedstarlv) ? "down to" : ((currentLevel < _arg_1.enhancedstarlv) ? "UP TO" : "at"));
                onCmdResult(((((((((("  star level of " + tech) + " is ") + _local_2) + " ") + _arg_1.enhancedstarlv) + ", gems: ") + getItemCount(delicateId)) + " / ") + getItemCount(flawlessId)));
                currentLevel = _arg_1.enhancedstarlv;
                cityManager._handleStarLevelResponse(_arg_1);
                timer.start();
            };
            handler = function (_arg_1:TimerEvent):void
            {
                var _local_2:Object;
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdResult("autostar has been terminated");
                    return;
                };
                timer.reset();
                if (busy)
                {
                    return;
                };
                if (((!(Connection.getInstance().authenticated)) || (Connection.getInstance().paused)))
                {
                    return;
                };
                if (currentLevel >= targetLevel)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdResult(("autostar is successful, star level is now " + currentLevel));
                    onCmdFinshed(true);
                    return;
                };
                for each (_local_2 in conditions)
                {
                    if ((((_local_2.start <= currentLevel) && (_local_2.end >= currentLevel)) && (getItemCount(_local_2.itemId) >= _local_2.count)))
                    {
                        onCmdResult(((((((("Autostar for " + tech) + ":") + currentLevel) + ", use ") + _local_2.count) + " ") + Items.getItemName(_local_2.itemId)));
                        ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(_local_2.itemId, _local_2.count, techId, internal::starHandler);
                        busy = true;
                        break;
                    };
                };
                if (!busy)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdResult(("autostar fails, current star level is " + currentLevel));
                    onCmdFinshed(true);
                    return;
                };
            };
            timer = new Timer(100);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function listMedals():void
        {
            this.currentAction = "listmedals";
            this.cityManager.listMedals();
            this.onCmdFinshed(true);
        }

        private function friendPlayerResponseHandler(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.friendBlockPlayerName = null;
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            this.player.friendBeansArray = _arg_1.friendArrArray;
            this.cityManager.logMsg((('Player "' + this.friendBlockPlayerName) + '" was successfully added to your Friends List.'));
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(true);
        }

        private function demo2(_arg_1:String="*", _arg_2:String="HighestLevel"):void
        {
            var _local_3:int = BuildingType.fromString(_arg_1);
            if (_local_3 == -1)
            {
                this.onCmdFinshed(new ScriptError("Invalid building", -9999));
                return;
            };
            this.onCmdResult("Starting", ("demo of " + BuildingType.toString(_local_3)));
            this.currentAction = "demo";
            var _local_4:BuildingBean = BuildSelectionPolicy.findByPolicy(this.castle.buildingsArray.toArray(), _arg_1, _arg_2, 10);
            if (_local_4 == null)
            {
                this.onCmdFinshed(new ScriptError((("Unable to perform demolish.  Unable to find " + _arg_1) + ". Demo level 10 buildings must explicitly specified with level10 build policy"), ErrorCode.ERROR_BUILDING_POSITION));
                return;
            };
            if (Version.isTraceOn())
            {
                trace("demo - setting up response callbacks");
            };
            this.setCmdResponse(ResponseDispatcher.CASTLE_DESTRUCT_BUILDING, this.buildCmdHandler);
            if (Version.isTraceOn())
            {
                trace(((((("demo - " + _local_4.name) + ", position ") + _local_4.positionId) + " on castle ") + this.castleId));
            };
            CityStateCommands.destructBuilding(this.castleId, _local_4.positionId);
        }

        private function fmthGLB():void
        {
            this.onCmdResult("Move the training hero");
            CityManager.deletePlayerTiming("movetraininghero");
            this.onCmdFinshed(true);
        }

        private function waitResource(resource:ResourceBean):void
        {
            var handler:Function;
            var timer:Timer;
            this.currentAction = "waitresource";
            this.pleaseStop = false;
            this.onCmdResult((("Waiting for resource " + CityManager.resoBeanToString(resource)) + " to be available..."));
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdFinshed(true);
                    return;
                };
                timer.delay = (2 * 1000);
                if ((((((resource.gold > castle.resource.gold) || (resource.food > castle.resource.food.amount)) || (resource.wood > castle.resource.wood.amount)) || (resource.stone > castle.resource.stone.amount)) || (resource.iron > castle.resource.iron.amount)))
                {
                    return;
                };
                onCmdResult(("Resource available: " + CityManager.resoBeanToString(resource)));
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, handler);
                timer = null;
                onCmdFinshed(true);
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function resetHeroStatsResponseHandler(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            this.cityManager.logMsg("Hero has been reset successfully.");
            this.onCmdFinshed(true);
        }

        public function findHeroByName(_arg_1:String):HeroBean
        {
            var _local_2:HeroBean;
            if (((!(_arg_1 == null)) && (!((_arg_1 = _arg_1.toLowerCase()) == ""))))
            {
                for each (_local_2 in this.cityManager.heroes)
                {
                    if (_local_2.name.toLowerCase() == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        private function create2(_arg_1:String, _arg_2:String="FirstAvailable", _arg_3:Boolean=false):void
        {
            var _local_4:int = BuildingType.fromString(_arg_1);
            if (_local_4 == -1)
            {
                this.onCmdFinshed(new ScriptError("Invalid building", -9999));
                return;
            };
            this.currentAction = "create";
            if (Version.isTraceOn())
            {
                trace("create - select building");
            };
            var _local_5:int = CreationPolicy.getPositionByPolicy(this.castle.buildingsArray.toArray(), _arg_1, _arg_2);
            if (_local_5 == -1)
            {
                this.onCmdFinshed(new ScriptError(("Unable to perform create.  Unable to find a free space for " + _arg_1), ErrorCode.ERROR_BUILDING_POSITION));
                return;
            };
            if (_arg_3)
            {
                this.onCmdResult(((("Queue new building " + BuildingType.toString(_local_4)) + " at location ") + _local_5));
                this.setCmdResponse(ResponseDispatcher.CASTLE_NEW_BUILDING_QUEUE, this.handleCmdResponse);
            }
            else
            {
                this.onCmdResult(((("Starting of " + BuildingType.toString(_local_4)) + " at location ") + _local_5));
                this.setCmdResponse(ResponseDispatcher.CASTLE_NEW_BUILDING, this.buildCmdHandler);
            };
            if (Version.isTraceOn())
            {
                trace(((((("create - " + _arg_1) + ", position ") + _local_5) + " on castle ") + this.castle.name));
            };
            CityStateCommands.newBuilding(this.castleId, _local_5, _local_4, null, _arg_3);
        }

        private function skypeWarningPolicy(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            this.currentAction = "";
            this.printGoalCommandWarning();
            if (!this.cityManager._setSkypeWarnPolicy([_arg_1, _arg_2, _arg_3, _arg_4]))
            {
                this.onCmdFinshed(new ScriptError("Parameter error for command skypewarningpolicy", -9999));
            }
            else
            {
                this.onCmdFinshed(true);
            };
        }

        private function production(_arg_1:int=100, _arg_2:int=100, _arg_3:int=100, _arg_4:int=100):void
        {
            this.currentAction = "production";
            _arg_1 = Math.max(0, Math.min(100, _arg_1));
            _arg_2 = Math.max(0, Math.min(100, _arg_2));
            _arg_3 = Math.max(0, Math.min(100, _arg_3));
            _arg_4 = Math.max(0, Math.min(100, _arg_4));
            this.castle.resource.workPeople = (((((_arg_1 * this.castle.resource.food.workPeople) + (_arg_2 * this.castle.resource.wood.workPeople)) + (_arg_3 * this.castle.resource.stone.workPeople)) + (_arg_4 * this.castle.resource.iron.workPeople)) / 100);
            CityStateCommands.modifyCommenceRate(this.castleId, _arg_1, _arg_2, _arg_3, _arg_4, this.handleCmdResponse);
            this.onCmdResult("production", ((((((("- changing production rate f:" + _arg_1) + " w:") + _arg_2) + " s:") + _arg_3) + " i:") + _arg_4));
        }

        private function capitalPolicy(operation:String, fieldId:int):void
        {
            var capitalPolicyCallBackParams:Object;
            var fieldType:int;
            var getLeftPoliciesTimesHandler:Function;
            this.currentAction = "capitalpolicy";
            var op:String = operation.toLowerCase().substr(0, 2);
            if ((((((op == "ar") || (op == "di")) || (op == "po")) || (op == "fo")) || (op == "ta")))
            {
                capitalPolicyCallBackParams = new Object();
                capitalPolicyCallBackParams.operation = operation.toLowerCase();
                switch (this.castle.powerlevel)
                {
                    case 4:
                        capitalPolicyCallBackParams = null;
                        this.onCmdFinshed(new ScriptError('This city is not an HC. The "capitalpolicy" command can only be used from a Historic City.', -9999));
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
                        this.onCmdFinshed(new ScriptError("City data incomplete. Cannot determine if city is an HC. Refresh or try again in a few minutes.", -9999));
                        return;
                };
                fieldType = Map.getType(fieldId, 60);
                if (fieldType != -1)
                {
                    if (((fieldType == FieldConstants.TYPE_CASTLE) || (fieldType == FieldConstants.TYPE_NPC)))
                    {
                        getLeftPoliciesTimesHandler = function (response:CapitalCommandResponse):void
                        {
                            if (response.ok != 1)
                            {
                                onCmdFinshed(new ScriptError(("Error received: " + response.errorMsg), -9999));
                                return;
                            };
                            if (!(response.amount > 0))
                            {
                                onCmdFinshed(new ScriptError((("You have 0/" + capitalPolicyCallBackParams.maxPolicies) + ' policies left for today. Capital policy operation has been cancelled because "no policies remaining"'), -9999));
                                return;
                            };
                            var capitalCommandHandler:Function = function (_arg_1:CapitalCommandResponse):void
                            {
                                if (_arg_1.ok != 1)
                                {
                                    onCmdFinshed(new ScriptError((("Error received: " + _arg_1.errorMsg) + ((_arg_1.errorMsg.toLowerCase().search("policy decree used") == -1) ? "" : (((("  [ " + (capitalPolicyCallBackParams.leftPolicies - 1)) + "/") + capitalPolicyCallBackParams.maxPolicies) + " policies left ]"))), -9999));
                                    return;
                                };
                                capitalPolicyCallBackParams.leftPolicies--;
                                var _local_2:* = "<b>Capitalpolicy Response</b>: ";
                                var _local_3:String = capitalPolicyCallBackParams.operation.substr(0, 2);
                                switch (_local_3)
                                {
                                    case "fo":
                                        _local_2 = (_local_2 + (((("Successful Food Levy. Acquire <b>" + _arg_1.amount) + " food</b>.  From ") + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId)) + "."));
                                        break;
                                    case "ta":
                                        _local_2 = (_local_2 + (((("Successful Tax Imposition. Acquire <b>" + _arg_1.amount) + " gold</b>.  From ") + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId)) + "."));
                                        break;
                                    case "ar":
                                        _local_2 = (_local_2 + (((((("Successful Draft. Acquire <b>" + _arg_1.amount) + " ") + _arg_1.armyType) + "</b>.  From ") + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId)) + "."));
                                        break;
                                    case "po":
                                        _local_2 = (_local_2 + (((((("Successful Pop. Redeployment. Acquire <b>" + _arg_1.amount) + " ") + _arg_1.armyType) + "</b>.  From ") + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId)) + "."));
                                        break;
                                    case "di":
                                        _local_2 = (_local_2 + (((((("Successful Disarmament. <b>" + _arg_1.amount) + " ") + _arg_1.armyType) + "</b> are disarmed.  From ") + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId)) + "."));
                                        break;
                                    default:
                                        _local_2 = (_local_2 + (((((((("Completed capitalpolicy " + capitalPolicyCallBackParams.operation) + " on ") + Map.fieldIdToString(capitalPolicyCallBackParams.fieldId)) + ": ") + _arg_1.amount) + " of type ") + _arg_1.armyType) + "."));
                                };
                                _local_2 = (_local_2 + (((("  [ " + capitalPolicyCallBackParams.leftPolicies) + "/") + capitalPolicyCallBackParams.maxPolicies) + " policies left ]"));
                                if (Map.getType(capitalPolicyCallBackParams.fieldId) != FieldConstants.TYPE_CASTLE)
                                {
                                    cityManager.logMsg(_local_2);
                                }
                                else
                                {
                                    cityManager.warLogMsg(_local_2);
                                };
                                onCmdFinshed(true);
                            };
                            capitalPolicyCallBackParams.leftPolicies = response.amount;
                            var op:String = capitalPolicyCallBackParams.operation.substr(0, 2);
                            switch (op)
                            {
                                case "fo":
                                    onCmdResult(("Levy food for capital from " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyFood(castleId, capitalPolicyCallBackParams.fieldId, capitalCommandHandler);
                                    return;
                                case "ar":
                                    onCmdResult(("Draft army for capital from " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyArmy(castleId, capitalPolicyCallBackParams.fieldId, capitalCommandHandler);
                                    return;
                                case "po":
                                    onCmdResult(("Redeploy population for capital from " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyPopulation(castleId, capitalPolicyCallBackParams.fieldId, capitalCommandHandler);
                                    return;
                                case "di":
                                    onCmdResult(("Disarm troops on" + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().reduceArmaments(castleId, capitalPolicyCallBackParams.fieldId, capitalCommandHandler);
                                    return;
                                case "ta":
                                    onCmdResult(("Levy tax for capital on " + Map.fieldIdToCoordString(capitalPolicyCallBackParams.fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyTaxes(castleId, capitalPolicyCallBackParams.fieldId, capitalCommandHandler);
                                    return;
                                default:
                                    onCmdFinshed(new ScriptError((("Invalid operation " + capitalPolicyCallBackParams.operation) + ", must be either food, army, population, disarm, tax"), -9999));
                            };
                        };
                        capitalPolicyCallBackParams.fieldId = fieldId;
                        ActionFactory.getInstance().getCapitalCommands().getLeftPoliciesTimes(this.castleId, getLeftPoliciesTimesHandler);
                    }
                    else
                    {
                        this.onCmdFinshed(new ScriptError(("Target is not an NPC nor Castle: " + Map.fieldIdToCoordString(fieldId)), -9999));
                        return;
                    };
                }
                else
                {
                    this.onCmdFinshed(new ScriptError(("Map is not yet available at " + Map.fieldIdToCoordString(fieldId)), -9999));
                    return;
                };
            }
            else
            {
                this.onCmdFinshed(new ScriptError((('Invalid operation "' + operation) + '", must be either  food, army, population, disarm, tax'), -9999));
            };
        }

        private function bigColonize(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "bigcolonize";
            this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE, _arg_1, _arg_2, _arg_3, null, _arg_4, true);
        }

        public function _declareWar(targetId:int):void
        {
            var handler:Function;
            var timer:Timer;
            this.currentAction = "declarewar";
            this.pleaseStop = false;
            handler = function (_arg_1:TimerEvent):void
            {
                var _local_2:MapCastleBean;
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    this.onCmdFinshed(true);
                    return;
                };
                timer.delay = 1500;
                _local_2 = Map.getDetail(targetId);
                if (_local_2 != null)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    handleDecWar(_local_2);
                };
            };
            timer = new Timer(0, 10);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function handleUseHeroHuntingResponse(_arg_1:HeroListResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.onCmdFinshed(new ScriptError(("Use item error: " + _arg_1.errorMsg), -9999));
                return;
            };
            this.cityManager._updateInnHandler(_arg_1);
            this.onCmdResult("Item used successfully");
            this.onCmdFinshed(true);
        }

        private function buyItem(_arg_1:String, _arg_2:int=1):void
        {
            this.currentAction = "buyitem";
            var _local_3:String = Items.getItemId(_arg_1);
            if (_local_3 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.SHOP_BUY, this.handleCmdResponse);
            ActionFactory.getInstance().getShopCommands().buy(_local_3, _arg_2);
        }

        private function findField(_arg_1:String, _arg_2:int, _arg_3:Number, _arg_4:String=null, _arg_5:TroopBean=null, _arg_6:int=-1):void
        {
            var _local_13:String;
            var _local_14:HeroBean;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:String;
            this.currentAction = "find field";
            if (_arg_6 == -1)
            {
                _arg_6 = this.castle.fieldId;
            };
            if (_arg_4 == "none")
            {
                _arg_4 = null;
            };
            var _local_7:int = Map.getFieldType(_arg_1);
            if (_local_7 == -1)
            {
                this.logCmdResponse(((("Invalid field type: " + _arg_1) + ", must be among ") + Map.FIELD_NAMES.join(" ")), "", "#ff0000");
                this.onCmdFinshed(true);
                return;
            };
            if (((_arg_2 < 0) || (_arg_2 > 20)))
            {
                this.logCmdResponse(("Field level not in range [0,20]: " + _arg_2), "", "#ff0000");
                this.onCmdFinshed(true);
                return;
            };
            if (_arg_3 < 0)
            {
                this.onCmdResult("Radius is less than 0, no town");
                this.onCmdFinshed(true);
                return;
            };
            if (((!(_arg_4 == null)) && (_arg_5 == null)))
            {
                this.logCmdResponse("Error: if you specify hero, you must specify troop used", "", "#ff0000");
                this.logCmdResponse("Example: findfield npc 5 10 any b:400,t:400", "", "#ff0000");
                this.onCmdFinshed(true);
                return;
            };
            var _local_8:int = Map.getX(_arg_6);
            var _local_9:int = Map.getY(_arg_6);
            if (!Map.isMapReady(_local_8, _local_9, _arg_3))
            {
                this.logCmdResponse(((((("Map is not ready, please run: scanmap " + _local_8) + ",") + _local_9) + " ") + _arg_3), "", "#ff0000");
                this.onCmdFinshed(true);
                return;
            };
            this.onCmdResult(((((((((("Now checking for level " + _arg_2) + " ") + _arg_1) + "(s) in a ") + _arg_3) + " mile radius around ") + _local_8) + ",") + _local_9));
            var _local_10:String = this.getMapFieldList(_arg_1, _arg_2, _arg_3, _arg_6, false);
            var _local_11:Array = ((_local_10 != null) ? _local_10.split(" ") : new Array());
            this.onCmdResult(((((((((((("Found " + _local_11.length) + " ") + ((_arg_2 == 0) ? "all levels" : ("level " + _arg_2))) + " ") + _arg_1) + "(s) within a ") + _arg_3) + " mile radius around ") + _local_8) + ",") + _local_9));
            var _local_12:int;
            if (((_arg_4 == null) && (_arg_5 == null)))
            {
                _local_13 = "";
                for each (_local_12 in _local_11)
                {
                    _local_13 = (_local_13 + (" " + Map.fieldIdToCoordinate(_local_12)));
                };
                this.onCmdResult((((_arg_1 + ":") + _arg_2) + _local_13));
            }
            else
            {
                if (_arg_4 == null)
                {
                    _arg_4 = "none";
                };
                _local_14 = ((_arg_4 != "none") ? this.getHeroByNameOrKey(_arg_4, 0) : null);
                _local_15 = ((_local_14 != null) ? Utils.getHeroSpeedFactor(_local_14) : 1);
                _local_16 = 0;
                _local_17 = 0;
                _local_18 = "Copy and paste this into the script window\n\n";
                for each (_local_12 in _local_11)
                {
                    _local_16 = ((this.cityManager.getBaseTravelTime(this.castle.fieldId, _local_12, _arg_5) / _local_15) * 2);
                    _local_17 = (_local_17 + _local_16);
                    _local_18 = (_local_18 + (((((((((((("attack " + Map.getX(_local_12)) + ",") + Map.getY(_local_12)) + " ") + _arg_4) + " ") + Utils.troopBeanToMsgString(_arg_5)) + " //Distance: ") + (int((Map.fieldDistance(this.castle.fieldId, _local_12) * 100)) / 100)) + " Mission time: ") + Utils.formatTime(_local_16)) + "\n"));
                };
                _local_18 = (_local_18 + (("//Accumulated mission time: " + Utils.formatTime(_local_17)) + "\n"));
                this.onCmdResult(_local_18);
            };
            this.onCmdFinshed(true);
        }

        private function keepResource(_arg_1:int, _arg_2:ResourceBean, _arg_3:Number=0):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "keepresource";
            this.cityManager.processKeepResourceGoal(((((Map.fieldIdToCoordString(_arg_1) + " ") + Utils.resourceBeanToString(_arg_2)) + " ") + _arg_3), true);
            this.onCmdFinshed(true);
        }

        private function waitSuzerain():void
        {
            var cb:ColonyBean;
            var handler:Function;
            var timer:Timer;
            this.currentAction = "waitsuzerain";
            this.pleaseStop = false;
            var heroName:String;
            cb = null;
            if ((((this.cityManager.colonies.length > 0) && ((this.cityManager.colonies[0] as ColonyBean).relation == 2)) && (((this.cityManager.colonies[0] as ColonyBean).status == 1) || ((this.cityManager.colonies[0] as ColonyBean).status == 3))))
            {
                cb = this.cityManager.colonies[0];
                if (cb.status != 1)
                {
                    this.onCmdResult(((("You are uprisinig against Lord " + cb.lordName) + " from ") + cb.position));
                }
                else
                {
                    this.onCmdResult(((("You are being Suzed by Lord " + cb.lordName) + " from ") + cb.position));
                };
                handler = function (_arg_1:TimerEvent):void
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdResult("Suzerain event has ended");
                    onCmdFinshed(true);
                };
                timer = new Timer(0);
                timer.addEventListener(TimerEvent.TIMER, handler);
                timer.delay = (cb.endTime - Utils.getServerTime());
                timer.repeatCount = 1;
                timer.start();
                this.onCmdResult(((("Sleep for " + Utils.formatTime((timer.delay / 1000))) + " which is ") + Utils.getLogTimeStr(cb.endTime)));
            }
            else
            {
                this.onCmdResult("No Suzerain event to wait for");
                this.onCmdFinshed(true);
            };
        }

        private function setMayor(_arg_1:String="politics"):void
        {
            this.currentAction = "setmayor";
            this.onCmdFinshed(this.setMayorByType(_arg_1).finishedresult);
        }

        private function calibrate():void
        {
            var fieldId:int;
            var newArmy:NewArmyParam;
            var startTime:Number;
            this.currentAction = "calibrateCampTime";
            var newDate:Date = new Date();
            if ((newDate.getTime() - lastCalibrateTime) < 5000)
            {
                this.logCmdResponse(this.currentAction, "- please wait a few seconds between calls to calibrate", "#2A9A2A");
                this.onCmdFinshed(true);
            };
            this.onCmdResult(("Calibration at: " + Utils.getTimeStr(Utils.getServerTime())), "", "#2A9A2A");
            newDate = new Date();
            lastCalibrateTime = newDate.getTime();
            if (!this.isRallySlotAvailable())
            {
                this.logCmdResponse(this.currentAction, "- No rally space available", "#2A9A2A");
                this.onCmdFinshed(true);
                return;
            };
            var targetId:int = -1;
            var cx:int = Map.getX(this.castle.fieldId);
            var cy:int = Map.getY(this.castle.fieldId);
            var r:int = 5;
            var y:int;
            var x:int = (cx - r);
            while (((targetId == -1) && (x <= (cx + r))))
            {
                y = (cy - r);
                while (((targetId == -1) && (y <= (cy + r))))
                {
                    fieldId = Map.getFieldId(x, y);
                    if (Map.getType(fieldId) == FieldConstants.TYPE_NPC)
                    {
                        targetId = fieldId;
                    };
                    y = (y + 1);
                };
                x = (x + 1);
            };
            if (targetId == -1)
            {
                this.logCmdResponse(this.currentAction, "- Please try again later, map is not yet available", "#2A9A2A");
                this.onCmdFinshed(true);
                return;
            };
            if (this.castle.troop.scouter == 0)
            {
                this.logCmdResponse(this.currentAction, "- need 1 scout to calibrate", "#2A9A2A");
                this.onCmdFinshed(true);
                return;
            };
            newArmy = new NewArmyParam();
            newArmy.missionType = ObjConstants.ARMY_MISSION_SCOUT;
            newArmy.targetPoint = targetId;
            newArmy.troops = new TroopBean();
            newArmy.troops.scouter = 1;
            newArmy.resource = new ResourceBean();
            Utils._fa102(900);
            startTime = Utils.getServerTime();
            var handler:Function = function (_arg_1:CommandResponse):void
            {
                var _local_3:ArmyBean;
                var _local_2:ArmyBean;
                for each (_local_3 in cityManager._getSelfArmies())
                {
                    if ((((_local_3.missionType == newArmy.missionType) && (_local_3.targetFieldId == newArmy.targetPoint)) && (_local_3.troop.scouter == "1")))
                    {
                        _local_2 = _local_3;
                        break;
                    };
                };
                if (_local_2 != null)
                {
                    campTimeDelta = (_local_3.startTime - startTime);
                    CityStateCommands.callBackArmy(castleId, _local_2.armyId);
                    onCmdResult(currentAction, (("- estimated sending lag time is " + Math.round(campTimeDelta)) + "ms"), "#2A9A2A");
                }
                else
                {
                    logCmdResponse(currentAction, "- unable to calibrate", "#2A9A2A");
                };
                Utils.callLater(1500, onCmdFinshed, [true]);
            };
            CityStateCommands.newArmy(this.castleId, newArmy, handler);
        }

        public function toDebugString():String
        {
            return ("properties: accountTab:AccountInfo actionFactory:ActionFactory actionResponse:ActionFactoryResponse allCities:Array buildingTypes:Object castle:CastleBean cityManager:CityManager coord:String lag:Number m_techLevels:Object math:Object missionTypes:Object player:PlayerBean serverTimeRaw:Number verboseLogs:Boolean,  methods: AnyIdleHero(String,[String]):Boolean changeheroname(String,String):void findHeroById(int):HeroBean findHeroByName(String):HeroBean formatNum(Number,[int]):String getArmy(String,int,String,TroopBean,[ResourceBean],[int],[Boolean]):NewArmyParam getDateFromTime(Number):Date getItemId(String):String getItemName(String):String getLocalTime():Number getMapDetail(int):MapCastleBean getMapDistance(int,int):Number getMapFieldList(String,int,Number,[int],[Boolean]):String getMapLevel(int):int getMapType(int):int getPlayerInfo(String):PlayerInfoBean getRawTime():Number getValue(String,String,[String]):Object getVar(String):String IsHeroInCastle(String):Boolean parseTime(String,[Boolean]):Number qdeploy(String,int,String,TroopBean,[ResourceBean],[String],[Boolean],[int]):String randomTime(String):int stateNameFromFieldId(int):String toDebugString():String toString():String");
        }

        private function techGoals(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "techgoals";
            this.cityManager._tj1139(_arg_1);
            this.onCmdFinshed(true);
        }

        private function keepTroop(_arg_1:int, _arg_2:TroopBean, _arg_3:int=0):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "keeptroop";
            this.cityManager.processKeeptroopGoals(((((Map.fieldIdToCoordString(_arg_1) + " ") + Utils.troopBeanToMsgString(_arg_2)) + " ") + _arg_3), true);
            this.onCmdFinshed(true);
        }

        private function cleanNpcReports(_arg_1:int=1):void
        {
            this.cleanReports("Barbarian", _arg_1);
        }

        private function recallAll():void
        {
            this.currentAction = "recallall";
            this.cityManager._mi1194(-1);
            this.onCmdFinshed(true);
        }

        private function spamHeroes(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "spamheroes";
            this.cityManager._setSpamHeroes(_arg_1);
            this.onCmdFinshed(true);
        }

        private function chatHandler(_arg_1:ChatResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.logCmdResponse(_arg_1.errorMsg, ("" + _arg_1.ok));
            };
        }

        public function getTroopCount(_arg_1:TroopBean):int
        {
            return (Utils.getTotalTroopCount(_arg_1));
        }

        private function useHeroItem(hero:String, itemName:String):void
        {
            var h:HeroBean;
            var getHero:DisappearHeroBean;
            var onHeroListResponse:Function;
            var onHeroRecoverResponse:Function;
            this.currentAction = "useheroitem";
            var itemId:String = Items.getItemId(itemName);
            if (itemId == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            if (itemId != "player.item.stoneoffinding")
            {
                h = this.findHeroByName(hero);
                if (h == null)
                {
                    h = this.findHeroById(int(hero));
                };
                if (h == null)
                {
                    this.onCmdFinshed(new ScriptError(("No hero found with Name/ID: " + hero), -9999));
                    return;
                };
                ActionFactory.getInstance().getHeroCommand().useItem(this.castleId, h.id, itemId, this.handleCmdResponse);
            }
            else
            {
                if (this.cityManager.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) <= (this.cityManager.heroes.length - ((Utils.isRoyalFound(this.cityManager.heroes)) ? 1 : 0)))
                {
                    this.onCmdFinshed(new ScriptError("No available space in Feasting Hall", -9999));
                }
                else
                {
                    getHero = null;
                    onHeroListResponse = function (_arg_1:DisappearHeroResponse):void
                    {
                        var _local_2:DisappearHeroBean;
                        var _local_3:String;
                        if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                        {
                            onCmdFinshed(new ScriptError(("Error getting recoverable hero list: " + _arg_1.errorMsg), -9999));
                        }
                        else
                        {
                            if (((_arg_1.herosArray == null) || (_arg_1.herosArray.length <= 0)))
                            {
                                onCmdFinshed(new ScriptError("There are no recoverable heroes at this time", -9999));
                            }
                            else
                            {
                                for each (_local_2 in _arg_1.herosArray)
                                {
                                    if (((_local_2.name == hero) || (_local_2.id == hero)))
                                    {
                                        getHero = _local_2;
                                        break;
                                    };
                                };
                                if (getHero != null)
                                {
                                    ActionFactory.getInstance().getHeroCommand().RecoverDisappearHero(castleId, getHero.id, onHeroRecoverResponse);
                                }
                                else
                                {
                                    _local_3 = "";
                                    for each (_local_2 in _arg_1.herosArray)
                                    {
                                        _local_3 = (_local_3 + (((((((((((("\n[" + _local_2.id) + "] ") + _local_2.name) + "(") + _local_2.level) + ")") + " ") + _local_2.management) + "/") + _local_2.power) + "/") + _local_2.stratagem));
                                    };
                                    onCmdFinshed(new ScriptError(((("No recoverable hero found with Name/ID: " + hero) + "\nTry copying the ID from the following list:") + _local_3), -9999));
                                };
                            };
                        };
                    };
                    onHeroRecoverResponse = function (_arg_1:CommandResponse):void
                    {
                        if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                        {
                            onCmdFinshed(new ScriptError(((("Error recovering hero with ID: " + getHero.id) + ",") + _arg_1.errorMsg), -9999));
                        }
                        else
                        {
                            onCmdResult("Item used successfully.");
                            handleCmdResponse(_arg_1);
                        };
                    };
                    ActionFactory.getInstance().getHeroCommand().GetDisappearHeros(onHeroListResponse);
                };
            };
        }

        private function levyByIntType(_arg_1:int):void
        {
            this.setCmdResponse(ResponseDispatcher.INTERIOR_TAXATION, this.handleCmdResponse);
            CityStateCommands.taxation(this.castleId, _arg_1);
        }

        private function resetMapData():void
        {
            this.currentAction = "rescanmap";
            Map.fullResetMap();
            this.onCmdFinshed(true);
        }

        private function onCmdResult(_arg_1:Object, _arg_2:String="", _arg_3:String="#000000"):void
        {
            dispatchEvent(new CityStateResponseEvent(_arg_1, _arg_2, _arg_3));
        }

        public function _setCastleBean():void
        {
            this.castle = MainScreen.getCastle(this.castleId);
        }

        private function refresh():void
        {
            this.currentAction = "refreshConnection";
            MainScreen.getInstance().refresh();
            this.onCmdFinshed(true);
        }

        public function getRawTime():Number
        {
            return (Utils.getServerTime());
        }

        private function pioTeleport(_arg_1:int):void
        {
            this.currentAction = "pioteleport";
            this.cityManager._recallIncomingArmies();
            this.setCmdResponse(ResponseDispatcher.CITY_UNITE_ADV_MOVE_CASTLE, this.handleCmdResponse);
            ActionFactory.getInstance().getCityCommands().uniteAdvMoveCastle(this.castleId, _arg_1);
            this.cityManager._resetLocalFieldsInfo();
        }

        private function scanRec(nwCorner:int, seCorner:int):void
        {
            var done:Array;
            var nwX:int;
            var nwY:int;
            var seX:int;
            var seY:int;
            var handler:Function;
            var scanTimer:Timer;
            this.currentAction = "scanrec";
            this.pleaseStop = false;
            done = new Array();
            nwX = Map.getX(nwCorner);
            nwY = Map.getY(nwCorner);
            seX = Map.getX(seCorner);
            seY = Map.getY(seCorner);
            handler = function (_arg_1:TimerEvent):void
            {
                scanTimer.delay = 500;
                scanTimer.reset();
                if (pleaseStop)
                {
                    scanTimer.stop();
                    scanTimer.removeEventListener(TimerEvent.TIMER, handler);
                    scanTimer = null;
                    onCmdFinshed(true);
                    return;
                };
                var _local_2:int;
                var _local_3:int;
                var _local_4:int;
                _local_2 = Math.min(nwX, seX);
                while (_local_2 <= Math.max(nwX, seX))
                {
                    _local_3 = Math.min(nwY, seY);
                    while (_local_3 <= Math.max(nwY, seY))
                    {
                        _local_4 = Map.getFieldId(_local_2, _local_3);
                        if (done[_local_4] == undefined)
                        {
                            if (Map.getLevel(_local_4, 1800, true) == -1)
                            {
                                scanTimer.start();
                                return;
                            };
                            done[_local_4] = true;
                        };
                        _local_3++;
                    };
                    _local_2++;
                };
                onCmdResult(((("SCANREC COMPLETED " + Map.fieldIdToCoordString(nwCorner)) + " ") + Map.fieldIdToCoordString(seCorner)));
                scanTimer.stop();
                scanTimer.removeEventListener(TimerEvent.TIMER, handler);
                scanTimer = null;
                onCmdFinshed(true);
            };
            scanTimer = new Timer(0);
            scanTimer.addEventListener(TimerEvent.TIMER, handler);
            scanTimer.start();
        }

        private function claimPackageResponse(_arg_1:GetPackageResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            this.cityManager.logMsg("Claimed the package successfully.");
            ActionFactory.getInstance().getCommonCommands().getPackageNumber(MainScreen.getInstance().setBoxNum);
            this.onCmdFinshed(true);
        }

        private function onCmdFinshed(obj:Object):void
        {
            var delay:Boolean = (this.events.length > 0);
            this.events.toArray().forEach(function (_arg_1:EventHandler, _arg_2:int, _arg_3:Array):void
            {
                if (((!(_arg_1.type == null)) && (!(_arg_1.callBack == null))))
                {
                    ResponseDispatcher.getInstance().removeEventListener(_arg_1.type, _arg_1.callBack);
                };
            });
            this.events.removeAll();
            this.currentAction = "";
            if (delay)
            {
                Utils.callLater(300, dispatchEvent, [new CityStateCompleteEvent(obj)]);
            }
            else
            {
                dispatchEvent(new CityStateCompleteEvent(obj));
            };
        }

        private function cancelBuild(_arg_1:int=-1000):void
        {
            var _local_2:BuildingBean;
            this.currentAction = "cancelbuild";
            if (_arg_1 == -1000)
            {
                _local_2 = this.cityManager._getCurrentConstruction();
                if (_local_2 == null)
                {
                    this.onCmdFinshed(new ScriptError("No current building", -9999));
                    return;
                };
                _arg_1 = _local_2.positionId;
            };
            this.setCmdResponse(ResponseDispatcher.CASTLE_CANCLE_BUILD_COMMAND, this.handleCmdResponse);
            ActionFactory.getInstance().getCastleCommands().cancleBuildCommand(this.castleId, _arg_1);
        }

        private function deploy(_arg_1:Object, _arg_2:int, _arg_3:String, _arg_4:TroopBean, _arg_5:ResourceBean=null, _arg_6:String="", _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:int=0):void
        {
            var _local_11:int;
            this.currentAction = "deploy";
            var _local_10:int = int(_arg_1);
            if (_local_10 == 0)
            {
                _local_11 = new Array("at", "bu", "re", "sc", "tr", "co", "an", "su", "up", "de").indexOf(_arg_1.toString().toLowerCase().substr(0, 2));
                if (_local_11 == -1)
                {
                    this.logCmdResponse("Invalid deploy value, must be among: attack, build, reinforce, scout, transport, colonize, anticolonize, suppress, uprise, or deploytroop");
                    this.onCmdFinshed(true);
                    return;
                };
                _local_10 = new Array(ObjConstants.ARMY_MISSION_OCCUPY, ObjConstants.ARMY_MISSION_CONSTRUCT, ObjConstants.ARMY_MISSION_SEND, ObjConstants.ARMY_MISSION_SCOUT, ObjConstants.ARMY_MISSION_TRANS, ObjConstants.ARMY_MISSION_COLONIZE, ObjConstants.ARMY_MISSION_ANTI_COLONIAL, ObjConstants.ARMY_MISSION_SUPPRESS, ObjConstants.ARMY_MISSION_UPRISE, ObjConstants.ARMY_MISSION_DEPLOY_TROOPS)[_local_11];
            };
            this.doMarch(_local_10, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9);
        }

        private function travelInfo(_arg_1:int, _arg_2:TroopBean, _arg_3:String=""):void
        {
            var _local_6:Number;
            var _local_7:String;
            var _local_8:Number;
            this.currentAction = "travelinfo";
            if (_arg_2 == null)
            {
                this.logCmdResponse("Invalid troop (cannot be none)");
                this.onCmdFinshed(true);
                return;
            };
            var _local_4:Number = this.cityManager.getBaseTravelTime(this.castle.fieldId, _arg_1, _arg_2);
            var _local_5:HeroBean = this.findHeroByName(_arg_3);
            if (((_arg_3.length > 0) && (_local_5 == null)))
            {
                this.logCmdResponse(("Invalid hero: " + _arg_3));
            }
            else
            {
                if (this.castle.fieldId == _arg_1)
                {
                    this.logCmdResponse((("destination " + Map.fieldIdToCoordString(_arg_1)) + " is the current castle"));
                }
                else
                {
                    if (_local_4 <= 0)
                    {
                        this.logCmdResponse("no troop or research information is not yet available, please try again");
                    }
                    else
                    {
                        if (_local_5 != null)
                        {
                            _local_4 = (_local_4 / Utils.getHeroSpeedFactor(_local_5));
                        };
                        _local_6 = (_local_4 / this._getReliefStationSpeedupFactor());
                        _local_7 = ((_local_5 != null) ? (((", with hero " + _arg_3) + ":") + _local_5.speed) : "");
                        _local_8 = (int((Map.fieldDistance(this.castle.fieldId, _arg_1) * 100)) / 100);
                        this.onCmdResult((((((((((((((("Distance to " + Map.fieldIdToCoordString(_arg_1)) + ": ") + _local_8) + _local_7) + ", attack time: ") + Utils.formatTime(_local_4)) + ", reinforce self/alliance time: ") + Utils.formatTime(_local_6)) + ", carrying load: ") + this.cityManager.getMaxTroopLoad(_arg_2)) + ", food needed to attack: ") + int((((this.cityManager.getTroopFoodValue(_arg_2) * _local_4) / 3600) * 2))) + ", to reinforce: ") + int((((this.cityManager.getTroopFoodValue(_arg_2) * _local_6) / 3600) * 2))));
                    };
                };
            };
            this.onCmdFinshed(true);
        }

        private function useBuildItem(_arg_1:String, _arg_2:int=-1000):void
        {
            var _local_4:BuildingBean;
            this.currentAction = "usebuilditem";
            if (_arg_2 == -1000)
            {
                _local_4 = this.cityManager._getCurrentConstruction();
                if (_local_4 == null)
                {
                    this.onCmdFinshed(new ScriptError("No current building", -9999));
                    return;
                };
                _arg_2 = _local_4.positionId;
            };
            var _local_3:String = Items.getItemId(_arg_1);
            if (_local_3 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.CASTLE_SPEED_UP_BUILD_COMMAND, this.handleCmdResponse);
            ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(this.castleId, _arg_2, _local_3);
        }

        private function vote(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null):void
        {
            this.currentAction = "vote";
            _arg_1 = ((((_arg_1 + ((_arg_2 != null) ? (" " + _arg_2) : "")) + ((_arg_3 != null) ? (" " + _arg_3) : "")) + ((_arg_4 != null) ? (" " + _arg_4) : "")) + ((_arg_5 != null) ? (" " + _arg_5) : ""));
            this.onCmdResult(("Vote for player " + _arg_1));
            this.setCmdResponse(ResponseDispatcher.VOTE_VOTE_TO_PLAYER_BY_NAME, this.handleCmdResponse);
            CityStateCommands.voteForPlayerByName(_arg_1);
        }

        private function isRallySlotAvailable():Boolean
        {
            return (this.cityManager.localArmies.length < this.cityManager.getMaxRallySlots());
        }

        private function warReportIgnoreList(_arg_1:String):void
        {
            this.currentAction = "";
            this.printGoalCommandWarning();
            if (!this.cityManager._setWrIgnoreList(_arg_1))
            {
                this.onCmdFinshed(new ScriptError("Parameter error for command warreportignorelist", -9999));
            }
            else
            {
                this.onCmdFinshed(true);
            };
            this.onCmdFinshed(true);
        }

        private function useAngelItem(_arg_1:String, _arg_2:String):void
        {
            this.currentAction = "useangelitem";
            var _local_3:String = Items.getItemId(_arg_2);
            if (_local_3 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.SHOP_USE_ANGEL_ITEM, this.handleCmdResponse);
            ActionFactory.getInstance().getShopCommands().useAngelItem(_arg_1, _local_3);
        }

        private function clearTroopQueues(_arg_1:int=1):void
        {
            this.currentAction = "cleartroopqueues";
            this.cityManager._clearTroopQueues(_arg_1);
            this.onCmdFinshed(true);
        }

        public function isHeroInCastle(_arg_1:String):Boolean
        {
            return (!(this.findHeroByName(_arg_1) == null));
        }

        private function npcTroop(_arg_1:TroopBean):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "npctroops";
            this.cityManager._setNpcTroopCond(Utils.troopBeanToMsgString(_arg_1));
            this.onCmdFinshed(true);
        }

        private function quickScanMap(zone:String="all", speedFactor:int=3):void
        {
            var x:int;
            var y:int;
            var endX:int;
            var endY:int;
            var waitCount:int;
            var threshold:int;
            var zonesCorners:Array;
            var zInd:int;
            var SIZE:int;
            var reqBuffer:Array;
            var getMapInfo:Function;
            var handler:Function;
            this.currentAction = "quickscan";
            this.pleaseStop = false;
            speedFactor = ((speedFactor > 9) ? 9 : ((speedFactor < 0) ? 0 : speedFactor));
            x = 0;
            y = 0;
            endX = 799;
            endY = 799;
            waitCount = 0;
            threshold = [2, 4, 8, 16, 24, 32, 40, 48, 56, 64][speedFactor];
            zonesCorners = [{
                "x":0,
                "y":0
            }, {
                "x":200,
                "y":0
            }, {
                "x":400,
                "y":0
            }, {
                "x":600,
                "y":0
            }, {
                "x":0,
                "y":200
            }, {
                "x":200,
                "y":200
            }, {
                "x":400,
                "y":200
            }, {
                "x":600,
                "y":200
            }, {
                "x":0,
                "y":400
            }, {
                "x":200,
                "y":400
            }, {
                "x":400,
                "y":400
            }, {
                "x":600,
                "y":400
            }, {
                "x":0,
                "y":600
            }, {
                "x":200,
                "y":600
            }, {
                "x":400,
                "y":600
            }, {
                "x":600,
                "y":600
            }];
            var abbr:String = zone.substr(0, 3).toLowerCase();
            zInd = ["fri", "sax", "nm", "boh", "ll", "fra", "thu", "mor", "ul", "swa", "bav", "car", "bur", "lom", "tus", "rom"].indexOf(abbr);
            if (zInd == -1)
            {
                zInd = ["fri", "sax", "nor", "boh", "low", "fra", "thu", "mor", "upp", "swa", "bav", "car", "bur", "lom", "tus", "rom"].indexOf(abbr);
            };
            if (zInd == -1)
            {
                if (zone.toLowerCase() != "all")
                {
                    this.onCmdFinshed(new ScriptError((("Invalid state: " + zone) + ', consider using the first 3 letters of the desired state instead, or use "all" or leave blank for the entire map'), -9999));
                    return;
                };
            }
            else
            {
                x = zonesCorners[zInd].x;
                y = zonesCorners[zInd].y;
                endX = (x + 199);
                endY = (y + 199);
            };
            this.onCmdResult("Start deleting old map data...");
            if (zone.toLowerCase() == "all")
            {
                Map.fullResetMap();
            }
            else
            {
                Map.resetRectangle(x, y, endX, endY);
            };
            SIZE = 50;
            reqBuffer = new Array();
            getMapInfo = function ():void
            {
                var _local_1:int;
                var _local_2:int;
                var _local_3:int;
                if (pleaseStop)
                {
                    ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE, handler);
                    onCmdResult("QUICK SCAN was cancelled before it could finish");
                    onCmdFinshed(true);
                    return;
                };
                if (((y < endY) || (x < endX)))
                {
                    if (reqBuffer.length < threshold)
                    {
                        while (y < endY)
                        {
                            if (x >= endX)
                            {
                                x = ((zInd == -1) ? 0 : zonesCorners[zInd].x);
                            };
                            while (x < endX)
                            {
                                ActionFactory.getInstance().getCommonCommands().mapInfoSimple(castleId, x, y, ((x + SIZE) - 1), ((y + SIZE) - 1));
                                reqBuffer.push(((Map.getFieldId(x, y) + ":") + Map.getFieldId(((x + SIZE) - 1), ((y + SIZE) - 1))));
                                waitCount = -1;
                                x = (x + SIZE);
                                if (reqBuffer.length >= threshold) break;
                            };
                            if (x >= endX)
                            {
                                y = (y + SIZE);
                            };
                            if (reqBuffer.length >= threshold) break;
                        };
                    };
                }
                else
                {
                    if (reqBuffer.length == 0)
                    {
                        ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE, handler);
                        onCmdResult("QUICK SCAN COMPLETED SUCCESSFULLY");
                        onCmdFinshed(true);
                        return;
                    };
                };
                if (reqBuffer.length > 0)
                {
                    waitCount++;
                };
                if (waitCount >= ((speedFactor < 4) ? 6 : ((speedFactor < 7) ? 4 : 3)))
                {
                    waitCount = 0;
                    _local_3 = 0;
                    while (_local_3 < reqBuffer.length)
                    {
                        _local_1 = Map.getX(int(reqBuffer[_local_3].split(":")[0]));
                        _local_2 = Map.getY(int(reqBuffer[_local_3].split(":")[0]));
                        ActionFactory.getInstance().getCommonCommands().mapInfoSimple(castleId, _local_1, _local_2, ((_local_1 + SIZE) - 1), ((_local_2 + SIZE) - 1));
                        if (_local_3 >= threshold) break;
                        _local_3++;
                    };
                };
                Utils.callLater(((speedFactor < 4) ? 500 : ((speedFactor < 7) ? 1000 : 1500)), getMapInfo);
            };
            handler = function (_arg_1:MapInfoSimpleResponse):void
            {
                var _local_2:int = reqBuffer.indexOf(((Map.getFieldId(_arg_1.x1, _arg_1.y1) + ":") + Map.getFieldId(_arg_1.x2, _arg_1.y2)));
                if (_local_2 != -1)
                {
                    if (waitCount > 0)
                    {
                        waitCount--;
                    };
                    reqBuffer.splice(_local_2, 1);
                };
            };
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE, handler);
            this.onCmdResult("Start recording new map data...");
            getMapInfo.apply();
        }

        private function npc10Limit(_arg_1:TroopBean):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "npc10limit";
            this.cityManager._dp32(Utils.troopBeanToMsgString(_arg_1));
            this.onCmdFinshed(true);
        }

        public function get coord():String
        {
            return (Map.fieldIdToCoordinate(this.castle.fieldId));
        }

        private function useArmyItem(_arg_1:int, _arg_2:String):void
        {
            var _local_5:ArmyBean;
            var _local_6:CityState;
            this.currentAction = "usearmyitem";
            var _local_3:String = Items.getItemId(_arg_2);
            if (_local_3 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            var _local_4:ArmyBean;
            for each (_local_5 in this.cityManager.selfArmies)
            {
                if (_local_5.armyId == _arg_1)
                {
                    _local_4 = _local_5;
                    break;
                };
            };
            if (_local_4 == null)
            {
                for each (_local_6 in MainScreen.getCities())
                {
                    for each (_local_5 in _local_6.cityManager.friendlyArmies)
                    {
                        if (_local_5.armyId == _arg_1)
                        {
                            _local_4 = _local_5;
                            break;
                        };
                    };
                    if (_local_4 != null) break;
                };
            };
            if (_local_4 == null)
            {
                for each (_local_5 in MainScreen.getInstance().getEnemyArmies())
                {
                    if (_local_5.armyId == _arg_1)
                    {
                        _local_4 = _local_5;
                        break;
                    };
                };
            };
            if (_local_4 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid armyId", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.SHOP_USE_TRICK_ITEM, this.handleCmdResponse);
            ActionFactory.getInstance().getShopCommands().useTrickItem(_local_4.startFieldId, _arg_1, _local_3, this.handleCmdResponse);
        }

        private function spamAttack(_arg_1:int, _arg_2:TroopBean, _arg_3:int):void
        {
            this.currentAction = "spamattack";
            this.cityManager._cf1136(_arg_1, _arg_2, _arg_3);
            this.onCmdFinshed(true);
        }

        public function get player():PlayerBean
        {
            return (MainScreen.getPlayer());
        }

        private function colony(operation:String, fieldId:int, tr:TroopBean=null):void
        {
            var selectType:String;
            var levyType:String;
            var endStr:String;
            this.currentAction = "colony";
            var cB:ColonyBean = this.cityManager.getColony(fieldId);
            if (cB == null)
            {
                this.onCmdFinshed(new ScriptError(("Invalid colony at " + Map.fieldIdToCoordString(fieldId)), -9999));
                return;
            };
            var handleColonyLevyResponse:Function = function (_arg_1:ColonyLevyeRespone):void
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    onCmdFinshed(new ScriptError(("Error received: " + _arg_1.errorMsg), -9999));
                    return;
                };
                var _local_2:* = "";
                if (selectType == "resource")
                {
                    _local_2 = ((_arg_1.amount + " amount of ") + levyType);
                }
                else
                {
                    if (selectType == "army")
                    {
                        _local_2 = ((((levyType + _arg_1.amount) + " ") + _arg_1.armyType) + endStr);
                    };
                };
                onCmdResult(("Colony levy response: " + _local_2));
                onCmdFinshed(true);
            };
            var op:String = operation.substr(0, 2);
            switch (op)
            {
                case "ab":
                    this.onCmdResult((((((("Begin abandon colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    this.setCmdResponse(ResponseDispatcher.COLONY_ABANDON_COLONY, this.handleCmdResponse);
                    ActionFactory.getInstance().getColonyCommands().abandonColony(this.castleId, cB.castleId);
                    return;
                case "fo":
                    this.onCmdResult((((((("Levy food from colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "resource";
                    levyType = "Food Levied!";
                    ActionFactory.getInstance().getColonyCommands().levyFood(this.castleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "ta":
                    this.onCmdResult((((((("Tax gold from colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "resource";
                    levyType = "Gold imposed!";
                    ActionFactory.getInstance().getColonyCommands().levyTaxes(this.castleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "ar":
                    this.onCmdResult((((((("Draft army from colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "army";
                    levyType = "You have drafted ";
                    endStr = " from the city.";
                    ActionFactory.getInstance().getColonyCommands().levyArmy(this.castleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "po":
                    this.onCmdResult((((((("Redeploy population from " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "resource";
                    levyType = "Population redeployed!";
                    ActionFactory.getInstance().getColonyCommands().levyPopulation(this.castleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "di":
                    this.onCmdResult((((((("Disarm " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "army";
                    levyType = "You have disarmed ";
                    endStr = " in the city.";
                    ActionFactory.getInstance().getColonyCommands().reduceArmaments(this.castleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "ov":
                    this.onCmdResult((((((("Overview colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(this.castleId, cB.castleId, this.handleGetColonyOverviewResponse);
                    return;
                case "so":
                    this.onCmdResult((((((("Sow discord on colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    this.setCmdResponse(ResponseDispatcher.COLONY_SOW_DISCORD, this.handleCmdResponse);
                    ActionFactory.getInstance().getColonyCommands().sowDiscord(this.castleId, cB.castleId);
                    return;
                case "in":
                    this.onCmdResult((((((("Army info for " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    ActionFactory.getInstance().getColonyCommands().getColonialArmyInfo(this.castleId, cB.castleId, this.handleGetColonyArmyInfoResponse);
                    return;
                case "su":
                    if (tr != null)
                    {
                        this.onCmdResult((((((((("Set suppression troop setting for " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName) + " to ") + Utils.troopBeanToMsgString(tr, false)));
                        ActionFactory.getInstance().getColonyCommands().setDeployTroops(this.castleId, cB.castleId, tr, this.handleCmdResponse);
                    }
                    else
                    {
                        this.onCmdResult((((((("Get suppression troop setting for " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                        ActionFactory.getInstance().getColonyCommands().getDeployTroopsInfo(this.castleId, cB.castleId, this.handleGetSupSettingResponse);
                    };
                    return;
                default:
                    this.onCmdFinshed(new ScriptError((("Invalid operation " + operation) + ", must be either abandon, food, tax, army, population, disarm, overview, sowdiscord, info, suppress"), -9999));
                    return;
            };
        }

        private function create(_arg_1:String, _arg_2:String="FirstAvailable", _arg_3:Boolean=false):void
        {
            if (_arg_3)
            {
                this.create2(_arg_1, _arg_2, _arg_3);
                return;
            };
            if (Version.isTraceOn())
            {
                trace("create - verify buildings");
            };
            if (this.cityManager.isBuildingQueueAvailable())
            {
                this.create2(_arg_1, _arg_2);
                return;
            };
            this.onCmdResult("Waiting for current building to complete...");
            this.waitForBuildingQueue(this.create2, [_arg_1, _arg_2, _arg_3]);
        }

        private function useTradeItem(_arg_1:String, _arg_2:int=-1):void
        {
            this.currentAction = "usetradeitem";
            var _local_3:ArrayCollection = this.cityManager.getTransingTrades();
            if (_local_3.length == 0)
            {
                this.onCmdFinshed(new ScriptError("No trades in transist.", -9999));
                return;
            };
            if (_arg_2 == -1)
            {
                _arg_2 = _local_3[0].id;
            };
            var _local_4:String = Items.getItemId(_arg_1);
            if (_local_4 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item name.", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.TRADE_SPEED_UP_TRANS, this.handleCmdResponse);
            ActionFactory.getInstance().getTradeCommands().speedUpTrans(this.castleId, _arg_2, _local_4, this.handleCmdResponse);
        }

        private function getHeroNamesFromMacroNames(_arg_1:String):String
        {
            _arg_1 = _arg_1.toLowerCase();
            if (_arg_1.substr(0, 1) != "#")
            {
                return (_arg_1);
            };
            if (new Array("#absbest", "#atk", "#satk", "#atk90", "#satk90", "#spm", "#spam", "#absworst", "#worst", "#best", "#bestenergy", "#pol", "#pol2", "#int", "#int2", "#hh", "#lh", "#royal").indexOf(_arg_1) != -1)
            {
                return (this.cityManager._getHeroNameFromMacroName(_arg_1));
            };
            throw (new ScriptError("Accepted #code: #absbest, #atk, #satk, #atk90, #satk90, #spm, #spam, #absworst, #worst, #best, #bestenergy, #pol, #pol2, #int, #int2, #hh, #lh, #royal", -9999));
        }

        private function waitHeroLost(heroList:String):void
        {
            var heroArr:Array;
            var handler:Function;
            var timer:Timer;
            this.currentAction = "waitherolost";
            this.pleaseStop = false;
            heroArr = heroList.split(",");
            this.onCmdResult((("Waiting for a hero in (" + heroList) + ") to be lost..."));
            handler = function (_arg_1:TimerEvent):void
            {
                var _local_2:HeroBean;
                var _local_3:String;
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdFinshed(true);
                    return;
                };
                timer.delay = (2 * 1000);
                _local_2 = null;
                for each (_local_3 in heroArr)
                {
                    if (_local_3 != "")
                    {
                        _local_2 = findHeroByName(_local_3);
                        if (_local_2 == null)
                        {
                            timer.stop();
                            timer.removeEventListener(TimerEvent.TIMER, handler);
                            timer = null;
                            onCmdResult((("Hero " + _local_2) + " is not found"));
                            onCmdFinshed(true);
                        };
                    };
                };
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function actKillWall():void
        {
            var _local_3:int;
            this.currentAction = "killwall";
            if (this.cityManager.fortification == null)
            {
                this.onCmdResult("No Walls to Destroyed");
                return;
            };
            this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT, this.handleCmdResponse);
            var _local_1:int;
            var _local_2:Array = [TFConstants.F_TRAP, TFConstants.F_ABATIS, TFConstants.F_ARROWTOWER, TFConstants.F_ROLLINGLOGS, TFConstants.F_ROCKFALL];
            for each (_local_3 in _local_2)
            {
                _local_1 = this.cityManager.fortification[Utils.troopIntNames[_local_3]];
                this.onCmdResult(((("Destroying " + _local_1) + " of fortification: ") + Utils.troopIntNames[_local_3]));
                CityStateCommands.destructWallProtect(this.castleId, _local_3, _local_1);
            };
            this.clearWallQueue(0);
        }

        private function advTeleport(_arg_1:int):void
        {
            this.currentAction = "advteleport";
            this.cityManager._recallIncomingArmies();
            this.setCmdResponse(ResponseDispatcher.CITY_ADV_MOVE_CASTLE, this.handleCmdResponse);
            ActionFactory.getInstance().getCityCommands().advMoveCastle(this.castleId, _arg_1);
            this.cityManager._resetLocalFieldsInfo();
        }

        private function getItemCount(_arg_1:String):int
        {
            var _local_2:ItemBean;
            for each (_local_2 in this.player.itemsArray)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2.count);
                };
            };
            return (0);
        }

        public function get math():Object
        {
            return (getDefinitionByName("Math"));
        }

        private function changeHeroGearsHandler(r:CommandResponse=null):void
        {
            var techAbbs:Array;
            var func:Function;
            var completed:Function;
            if (((!(r == null)) && (!(r.ok == CommandResponse.OK_DEFAULT))))
            {
                this.changeHeroGearsParams = null;
                this.onCmdFinshed(new ScriptError(("An error occurred while processing change gears command: " + r.errorMsg), -9999));
                return;
            };
            techAbbs = new Array("he", "che", "we", "shi", "le", "cha1", "ri1", "mo", "ne", "sho", "ba", "ga", "be", "cha2", "ri2", "fo");
            if (this.changeHeroGearsParams.i < this.changeHeroGearsParams.setGears.length)
            {
                func = function ():void
                {
                    var _local_1:Array;
                    var _local_2:Array;
                    var _local_3:int;
                    _local_1 = new Array(EquipmentTech.EQUIPMENT_SLOT_HEAD, EquipmentTech.EQUIPMENT_SLOT_CHEST, EquipmentTech.EQUIPMENT_SLOT_WEAPON_L, EquipmentTech.EQUIPMENT_SLOT_SHIELD_L, EquipmentTech.EQUIPMENT_SLOT_LEG_L, EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L, EquipmentTech.EQUIPMENT_SLOT_RING_L, EquipmentTech.EQUIPMENT_SLOT_MOUNT_L, EquipmentTech.EQUIPMENT_SLOT_NECKLACE, EquipmentTech.EQUIPMENT_SLOT_SHOULDERS, EquipmentTech.EQUIPMENT_SLOT_BACK, EquipmentTech.EQUIPMENT_SLOT_WRIST, EquipmentTech.EQUIPMENT_SLOT_WAIST, EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R, EquipmentTech.EQUIPMENT_SLOT_RING_R, EquipmentTech.EQUIPMENT_SLOT_FEET);
                    _local_2 = changeHeroGearsParams.setGears[changeHeroGearsParams.i].split(":");
                    _local_3 = techAbbs.indexOf(_local_2[0].toLowerCase());
                    if (int(_local_2[1]) < 1)
                    {
                        ActionFactory.getInstance().getEquipmentCommands().TakeOffEquipmenttech(changeHeroGearsParams.heroId, "0", _local_1[_local_3]);
                    }
                    else
                    {
                        ActionFactory.getInstance().getEquipmentCommands().WearEquipmenttech(changeHeroGearsParams.heroId, "0", ((_local_1[_local_3] == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L) ? 1 : int(_local_2[1])), _local_1[_local_3], changeHeroGearsHandler);
                    };
                    changeHeroGearsParams.i++;
                };
                Utils.callLater(200, func);
            }
            else
            {
                completed = function ():void
                {
                    var _local_1:String;
                    var _local_2:HeroBean;
                    var _local_3:EquipmentBean;
                    var _local_4:String;
                    var _local_5:int;
                    _local_1 = changeHeroGearsParams.heroName;
                    _local_2 = findHeroByName(_local_1);
                    _local_3 = null;
                    _local_4 = "";
                    _local_5 = 0;
                    while (_local_5 < _local_2.equipmentbeanArray.length)
                    {
                        _local_3 = (_local_2.equipmentbeanArray[_local_5] as EquipmentBean);
                        _local_4 = (_local_4 + ((((((_local_4 != "") ? "," : "") + "<b>") + techAbbs[(_local_3.heroPos - 1)]) + "</b>:") + getGearTypeString(_local_3.addAttributeType)));
                        _local_5++;
                    };
                    cityManager.logMsg(((("Gear for hero " + _local_1) + " has been set to ") + _local_4));
                    onCmdFinshed(true);
                    changeHeroGearsParams = null;
                };
                Utils.callLater(200, completed);
            };
        }

        private function endEvacuate():void
        {
            this.currentAction = "endevacuate";
            this.cityManager._nd1071();
            this.onCmdFinshed(true);
        }

        public function getRandomNum(_arg_1:int, _arg_2:int):int
        {
            return (Utils.getRandomInt(_arg_1, _arg_2));
        }

        private function tradeTo(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number=0):void
        {
            var _local_8:Array;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            if (this.cityManager.getBuildingLevel(BuildingConstants.TYPE_MARKET) == 0)
            {
                this.logCmdResponse("Cannot process the transaction because this city has no Market.");
                this.onCmdFinshed(true);
                return;
            };
            if ((_arg_2 = _arg_2.toLowerCase()) == "wood")
            {
                _arg_2 = "lumber";
            };
            var _local_6:Array = new Array("food", "lumber", "stone", "iron");
            var _local_7:int = _local_6.indexOf(_arg_2);
            if (((!((_arg_1 = _arg_1.toLowerCase()) == "buy")) && (!(_arg_1 == "sell"))))
            {
                this.logCmdResponse((("trade type " + _arg_1) + " must be buy or sell"));
            }
            else
            {
                if (_local_7 == -1)
                {
                    this.logCmdResponse(("Invalid resource, must be among " + _local_6.join(" ")));
                }
                else
                {
                    if (_arg_4 < 0)
                    {
                        this.logCmdResponse("Invalid price, must be a positive number");
                    }
                    else
                    {
                        if (((isNaN(_arg_3)) || (_arg_3 <= 0)))
                        {
                            this.logCmdResponse(("Invalid limit amount: " + _arg_3));
                        }
                        else
                        {
                            if (_arg_3 < _arg_4)
                            {
                                this.logCmdResponse((("The limit amount " + _arg_3) + " is too small"));
                            }
                            else
                            {
                                _local_8 = new Array(this.castle.resource.food.amount, this.castle.resource.wood.amount, this.castle.resource.stone.amount, this.castle.resource.iron.amount);
                                _local_9 = ((_arg_1 == "buy") ? Math.floor(this.cityManager._ok1059()[_local_7]) : Math.floor(_local_8[_local_7]));
                                _local_10 = this.cityManager._getResoGold();
                                if (_arg_4 >= 10)
                                {
                                    _arg_4 = (int((_arg_4 * 100)) / 100);
                                }
                                else
                                {
                                    _arg_4 = (int((_arg_4 * 1000)) / 1000);
                                };
                                this.onCmdResult(("Current resource: " + _local_9));
                                _local_11 = 0;
                                if (_arg_1 == "buy")
                                {
                                    _local_11 = (_arg_3 - _local_9);
                                    if (_local_11 > (((_local_10 - _arg_5) / _arg_4) / 1.005))
                                    {
                                        _local_11 = (((_local_10 - _arg_5) / _arg_4) / 1.005);
                                    };
                                }
                                else
                                {
                                    _local_11 = (_local_9 - _arg_3);
                                    if (_local_11 > ((_local_10 / _arg_4) / 0.005))
                                    {
                                        _local_11 = ((_local_10 / _arg_4) / 0.005);
                                    };
                                    if ((((_local_10 < _arg_5) && (_local_11 < ((_arg_5 - _local_10) / _arg_4))) && (_local_9 > ((_arg_5 - _local_10) / _arg_4))))
                                    {
                                        _local_11 = ((_arg_5 - _local_10) / _arg_4);
                                    };
                                };
                                if (_local_11 > TRADELIMIT)
                                {
                                    _local_11 = TRADELIMIT;
                                }
                                else
                                {
                                    if (_local_11 > 1000)
                                    {
                                        _local_11 = (Math.floor((_local_11 / 1000)) * 1000);
                                    }
                                    else
                                    {
                                        if (_local_11 > 0)
                                        {
                                            _local_11 = Math.floor(_local_11);
                                        };
                                    };
                                };
                                if (_local_11 <= 0)
                                {
                                    this.logCmdResponse("No trade needed");
                                }
                                else
                                {
                                    if (_arg_1 == "buy")
                                    {
                                        this.onCmdResult(((((((("Buy " + _local_6[_local_7]) + ": ") + _local_11) + " at price ") + _arg_4) + " toward limit ") + _arg_3));
                                        CityStateCommands.newTrade(this.castleId, _local_7, TradeConstants.TRADE_TYPE_BUY, _local_11, ("" + _arg_4));
                                        Utils.callLater(1500, this.onCmdFinshed, [true]);
                                        return;
                                    };
                                    if (_arg_1 == "sell")
                                    {
                                        this.onCmdResult(((((((("Sell " + _local_6[_local_7]) + ": ") + _local_11) + " at price ") + _arg_4) + " toward limit ") + _arg_3));
                                        CityStateCommands.newTrade(this.castleId, _local_7, TradeConstants.TRADE_TYPE_SELL, _local_11, ("" + _arg_4));
                                        Utils.callLater(1500, this.onCmdFinshed, [true]);
                                        return;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            this.onCmdFinshed(true);
        }

        private function cancelTrade(_arg_1:int=-1):void
        {
            this.currentAction = "canceltrade";
            if (_arg_1 != -1)
            {
                this.setCmdResponse(ResponseDispatcher.TRADE_CANCEL_TRADE, this.handleCmdResponse);
                ActionFactory.getInstance().getTradeCommands().cancelTrade(this.castleId, _arg_1);
            }
            else
            {
                this.cityManager._hd522();
                Utils.callLater(1500, this.onCmdFinshed, [true]);
            };
        }

        public function getIdleHeroes(_arg_1:int=0):ArrayCollection
        {
            var _local_3:HeroBean;
            var _local_2:ArrayCollection = new ArrayCollection();
            for each (_local_3 in this.cityManager.heroes)
            {
                if (((_local_3.status == HeroConstants.HERO_FREE_STATU) && (_local_3.stamina >= _arg_1)))
                {
                    _local_2.addItem(_local_3);
                };
            };
            return (_local_2);
        }

        private function listPackagesResponse(_arg_1:GetPackageListResponse):void
        {
            var _local_8:Date;
            var _local_10:PackageBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            var _local_2:* = "";
            var _local_3:* = "";
            var _local_4:* = "";
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_9:* = "";
            for each (_local_10 in _arg_1.packagesArray)
            {
                _local_8 = new Date(_local_10.provideTime);
                _local_9 = ((((((((((_local_8.fullYear + "-") + (((_local_8.month + 1) < 10) ? ("0" + (_local_8.month + 1)) : (_local_8.month + 1))) + "-") + ((_local_8.date < 10) ? ("0" + _local_8.date) : _local_8.date)) + " ") + ((_local_8.hours < 10) ? ("0" + _local_8.hours) : _local_8.hours)) + ":") + ((_local_8.minutes < 10) ? ("0" + _local_8.minutes) : _local_8.minutes)) + ":") + ((_local_8.seconds < 10) ? ("0" + _local_8.seconds) : _local_8.seconds));
                if (_local_10.status == ObjConstants.PACKAGE_STATUS_AVAIBLE)
                {
                    if (_local_2 != "")
                    {
                        _local_2 = (_local_2 + ", ");
                    };
                    _local_2 = (_local_2 + ((((("<b>id:</b>" + _local_10.id) + " <b>name:</b>") + _local_10.packageName) + " <b>arrived:</b>") + _local_9));
                    _local_5++;
                }
                else
                {
                    if (_local_10.status == ObjConstants.PACKAGE_STATUS_HAD_GOT)
                    {
                        if (_local_3 != "")
                        {
                            _local_3 = (_local_3 + ", ");
                        };
                        _local_3 = (_local_3 + ((((((("<b>id:</b>" + _local_10.id) + " <b>name:</b>") + _local_10.packageName) + " <b>arrived:</b>") + _local_9) + " <b>claimed:</b>") + _local_10.claimedTime));
                        _local_6++;
                    }
                    else
                    {
                        if (_local_4 != "")
                        {
                            _local_4 = (_local_4 + ", ");
                        };
                        _local_4 = (_local_4 + ((((("<b>id:</b>" + _local_10.id) + " <b>name:</b>") + _local_10.packageName) + " <b>arrived:</b>") + _local_9));
                        _local_7++;
                    };
                };
            };
            this.cityManager.logMsg(((((((((((("List of Gift Packages:\n<u>" + _local_5) + " Available Unclaimed Gifts:</u>  ") + _local_2) + "\n<u>") + _local_6) + " Already Claimed Gifts:</u>  ") + _local_3) + "\n<u>") + _local_7) + " Other Unclaimed Gifts:</u>  ") + _local_4));
            this.onCmdFinshed(true);
        }

        private function _ip715(_arg_1:AvailableResearchListBean, _arg_2:AvailableResearchListResponse):Boolean
        {
            var _local_6:*;
            var _local_9:*;
            var _local_10:*;
            var _local_11:*;
            if (_arg_1.conditionBean == null)
            {
                return (false);
            };
            var _local_3:Boolean = true;
            _local_3 = ((_arg_1.conditionBean.food < this.castle.resource.food.amount) && (_local_3));
            _local_3 = ((_arg_1.conditionBean.gold < this.castle.resource.gold) && (_local_3));
            _local_3 = ((_arg_1.conditionBean.iron < this.castle.resource.iron.amount) && (_local_3));
            _local_3 = ((_arg_1.conditionBean.stone < this.castle.resource.stone.amount) && (_local_3));
            if (!(_local_3 = ((_arg_1.conditionBean.wood < this.castle.resource.wood.amount) && (_local_3))))
            {
                return (false);
            };
            var _local_4:Boolean;
            var _local_5:Boolean = true;
            for each (_local_6 in _arg_1.conditionBean.buildingsArray)
            {
                _local_4 = false;
                for each (_local_10 in this.castle.buildingsArray)
                {
                    if (_local_10.typeId == _local_6.typeId)
                    {
                        if ((_local_10.level >= _local_6.level))
                        {
                            _local_4 = true;
                            break;
                        };
                    };
                };
                _local_5 = ((_local_4) && (_local_5));
            };
            if (!_local_5)
            {
                return (false);
            };
            var _local_7:Boolean;
            var _local_8:Boolean = true;
            for each (_local_9 in _arg_1.conditionBean.techsArray)
            {
                _local_7 = false;
                for each (_local_11 in _arg_2.acailableResearchBeansArray)
                {
                    if (_local_11.typeId == _local_9.id)
                    {
                        if ((_local_11.level >= _local_9.level))
                        {
                            _local_7 = true;
                            break;
                        };
                    };
                };
                _local_8 = ((_local_7) && (_local_8));
            };
            if (!_local_8)
            {
                return (false);
            };
            return (true);
        }

        private function aColonize(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "acolonize";
            this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE, _arg_1, _arg_2, _arg_3, null, _arg_4, false, false, 2, null);
        }

        private function npc10Heroes(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "npc10heroes";
            this.cityManager._cfg_npc10Heroes(_arg_1);
            this.onCmdFinshed(true);
        }

        private function recall(_arg_1:int):void
        {
            this.currentAction = "recall";
            this.cityManager._recallLocalArmiesToTarget(_arg_1);
            this.onCmdFinshed(true);
        }

        private function listLocalBuffs():void
        {
            this.currentAction = "listlocalbuffs";
            this.cityManager._printLocalBuffs();
            this.onCmdFinshed(true);
        }

        private function buildCity(_arg_1:int):void
        {
            this.currentAction = "buildcity";
            this.cityManager._setBuildNewCityLoc(_arg_1);
            this.onCmdFinshed(true);
        }

        private function aScout(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "ascout";
            this.doMarch(ObjConstants.ARMY_MISSION_SCOUT, _arg_1, _arg_2, _arg_3, null, _arg_4, false, false, 2, null);
        }

        private function skypeWarningReceivers(_arg_1:String):void
        {
            this.currentAction = "";
            this.printGoalCommandWarning();
            if (!this.cityManager._setSkypeWarnReceivers(_arg_1))
            {
                this.onCmdFinshed(new ScriptError("Parameter error for command skypewarningreceivers", -9999));
            }
            else
            {
                this.onCmdFinshed(true);
            };
            this.onCmdFinshed(true);
        }

        private function friendPlayer(_arg_1:String):void
        {
            var _local_2:PlayerInfoBean;
            var _local_3:PlayerInfoBean;
            this.currentAction = "friend player";
            for each (_local_2 in this.player.blockBeansArray)
            {
                if (_local_2.userName.toLowerCase() == _arg_1.toLowerCase())
                {
                    this.onCmdFinshed(new ScriptError((((('Player "' + _local_2.userName) + '" is in your Block Players List. Run "unblockplayer ') + _local_2.userName) + '" before trying to add the player to friends list.'), -9999));
                    return;
                };
            };
            for each (_local_3 in this.player.friendBeansArray)
            {
                if (_local_3.userName.toLowerCase() == _arg_1.toLowerCase())
                {
                    this.cityManager.logMsg((("Player <font color='#CC0000'>\"" + _local_3.userName) + '"</font> is already in your Friends List. No action taken.'));
                    this.onCmdFinshed(true);
                    return;
                };
            };
            this.friendBlockPlayerName = _arg_1;
            ActionFactory.getInstance().getFriendCommands().addFriend(_arg_1, this.friendPlayerResponseHandler);
        }

        public function _doQuickMarch(marchType:int, targetId:int, hero:String, troopObj:TroopBean, resources:ResourceBean=null, restTime:String="", warEnsign:Boolean=false, stygandrsBannerOfTheHorde:Boolean=false, argGearing:int=0, callback:Function=null):String
        {
            if (targetId == this.castle.fieldId)
            {
                return ("Invalid target. Target is the current castle");
            };
            if (targetId == -1)
            {
                return ("Error: Invalid target coordinates.  Specify coords as 'x,y'");
            };
            if (!this.isRallySlotAvailable())
            {
                return ("Error: No rally space available");
            };
            var minStamina:int = ((marchType != ObjConstants.ARMY_MISSION_SEND) ? ((marchType != ObjConstants.ARMY_MISSION_TRANS) ? 4 : 2) : 1);
            var selectedHero:HeroBean;
            try
            {
                if (((!(hero == "")) && (!(hero.toLowerCase() == "none"))))
                {
                    selectedHero = this.getHeroByNameOrKey(hero, minStamina);
                    if (selectedHero == null)
                    {
                        return ("Error: No idle hero available");
                    };
                };
            }
            catch(error:Error)
            {
                return ("Error: Invalid hero specified " + hero);
            };
            if ((((((!(marchType == ObjConstants.ARMY_MISSION_SEND)) && (!(marchType == ObjConstants.ARMY_MISSION_TRANS))) && (!(marchType == ObjConstants.ARMY_MISSION_SCOUT))) && (!(marchType == ObjConstants.ARMY_MISSION_CONSTRUCT))) && (selectedHero == null)))
            {
                return ("Error: a hero is required for this mission");
            };
            if (!this.cityHasEnoughTroops(troopObj))
            {
                return ("Error: Not enough troop");
            };
            var newArmy:NewArmyParam = new NewArmyParam();
            newArmy.missionType = marchType;
            newArmy.targetPoint = targetId;
            newArmy.troops = troopObj;
            newArmy.useFlag = warEnsign;
            newArmy.useItem = stygandrsBannerOfTheHorde;
            newArmy.resource = ((resources != null) ? resources : new ResourceBean());
            if (selectedHero != null)
            {
                newArmy.heroId = selectedHero.id;
                if (((argGearing > 0) && (argGearing < 4)))
                {
                    ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(selectedHero.id, argGearing);
                    this.onCmdResult((((" Changing gear to " + ((argGearing == 1) ? "Pol" : ((argGearing == 2) ? "Atk" : "Int"))) + " for ") + selectedHero.name));
                };
            };
            var baseTravelTime:Number = this.cityManager.getBaseTravelTime(this.castle.fieldId, targetId, troopObj);
            var rsSpeedUp:int = ((((!(MainScreen.getCityFromFieldId(targetId) == null)) || ((((Map.getType(targetId) == FieldConstants.TYPE_CASTLE) && (!(Map.getDetailInfo(targetId, 30).allianceName == null))) && (!(this.player.playerInfo.alliance == null))) && (Map.getDetailInfo(targetId, 30).allianceName == this.player.playerInfo.alliance))) && ((marchType == ObjConstants.ARMY_MISSION_SEND) || (marchType == ObjConstants.ARMY_MISSION_TRANS))) ? this._getReliefStationSpeedupFactor() : 1);
            var heroSpeedUp:Number = ((selectedHero != null) ? Utils.getHeroSpeedFactor(selectedHero) : 1);
            var travelTime:int = int(((baseTravelTime / rsSpeedUp) / heroSpeedUp));
            var buffsCampFactor:Number = 1;
            var restTimeNumeric:Number = 0;
            if (restTime != "")
            {
                buffsCampFactor = this.cityManager.getCampTimeChangeBuffsFactor();
                if (((travelTime == 0) && (buffsCampFactor == 1)))
                {
                    return ("ERROR: No troop or town has yet to be initialized (travel time or research not available yet");
                };
                if ((restTimeNumeric = this._parseRestTime(restTime, travelTime)) > 0)
                {
                    if (int((int(restTimeNumeric) * buffsCampFactor)) > ((24 * 60) * 60))
                    {
                        return (("Error: Camp time exceeds server limit at " + Utils.formatTime((int(restTimeNumeric) * buffsCampFactor))) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]");
                    };
                    if (restTimeNumeric > (20 * 3600))
                    {
                        return (("Error: Large camp time " + Utils.formatTime(restTimeNumeric)) + " is more than 20 hours");
                    };
                };
                if (restTimeNumeric < 0)
                {
                    return (((("Error: Bad camp time " + restTime) + ", resulting in negative camp time: ") + restTimeNumeric) + ", make sure you run 'calibrate' recently!");
                };
            };
            if (int((int(restTimeNumeric) * buffsCampFactor)) > ((24 * 60) * 60))
            {
                return (("Camp time exceeds server limit at " + Utils.formatTime((int(restTimeNumeric) * buffsCampFactor))) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]");
            };
            newArmy.restTime = int(restTimeNumeric);
            if (restTime != "")
            {
                Utils.callLater(((restTimeNumeric - newArmy.restTime) * 1000), CityStateCommands.newArmy, [this.castleId, newArmy, callback]);
            }
            else
            {
                CityStateCommands.newArmy(this.castleId, newArmy, callback);
            };
            return (((((((((("- Marching to " + Map.fieldIdToCoordString(targetId)) + " arrival at ") + Utils.getLogTimeStr(((Utils.getServerTime() + campTimeDelta) + ((travelTime + restTimeNumeric) * 1000)))) + ((selectedHero == null) ? "" : (" using " + selectedHero.name))) + " with ") + Utils.troopBeanToMsgString(troopObj)) + " carrying ") + Utils.resourceBeanToString(resources)) + " in ") + Utils.formatTime((travelTime + newArmy.restTime)));
        }

        private function useCastleItem(_arg_1:String):void
        {
            this.currentAction = "usecastleitem";
            var _local_2:String = Items.getItemId(_arg_1);
            if (_local_2 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            ActionFactory.getInstance().getShopCommands().useCastleGoods(this.castleId, _local_2, this.handleCmdResponse);
        }

        private function waitEnemy(ignoreJunk:Boolean=false):void
        {
            var handler:Function;
            var timer:Timer;
            this.currentAction = "waitresource";
            this.pleaseStop = false;
            this.onCmdResult((("Waiting for " + ((ignoreJunk) ? "non junkwave" : "any")) + " incomming enemy army..."));
            handler = function (_arg_1:TimerEvent):void
            {
                var _local_2:Boolean;
                var _local_3:ArmyBean;
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdFinshed(true);
                    return;
                };
                if (ignoreJunk)
                {
                    _local_2 = false;
                    for each (_local_3 in cityManager.enemyArmies)
                    {
                        if (!cityManager.isJunkTroop(_local_3.troop))
                        {
                            _local_2 = true;
                            break;
                        };
                    };
                    if (!_local_2)
                    {
                        return;
                    };
                }
                else
                {
                    if (cityManager.enemyArmies.length < 1)
                    {
                        return;
                    };
                };
                onCmdResult((("Detected new " + ((ignoreJunk) ? "non junkwave" : "")) + " incomming enemy army, resuming script..."));
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, handler);
                timer = null;
                onCmdFinshed(true);
            };
            timer = new Timer(1200);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function waitNoBuilding():void
        {
            var handler:Function;
            var timer:Timer;
            this.pleaseStop = false;
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    return;
                };
                timer.delay = 1000;
                if (cityManager._getCurrentConstruction() == null)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdFinshed(true);
                };
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function qBuildNpc():void
        {
            var handler:Function;
            var waitTimer:Timer;
            this.currentAction = "qbuildnpc";
            this.pleaseStop = false;
            handler = function (_arg_1:TimerEvent):void
            {
                if ((((pleaseStop) || (Connection.getInstance().paused)) || (!(Connection.getInstance().authenticated))))
                {
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    return;
                };
                waitTimer.delay = 5000;
                var _local_2:Boolean;
                var _local_3:Array = MainScreen.getCities();
                var _local_4:Array = Utils.randOrder(_local_3.length);
                var _local_5:CityState;
                var _local_6:int;
                while (_local_6 < _local_4.length)
                {
                    _local_5 = _local_3[_local_4[_local_6]];
                    if (_local_5.cityManager._doQBuildNpc())
                    {
                        _local_2 = true;
                    };
                    _local_6++;
                };
                if (!_local_2)
                {
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    onCmdFinshed(true);
                };
            };
            waitTimer = new Timer(0);
            waitTimer.addEventListener(TimerEvent.TIMER, handler);
            waitTimer.start();
        }

        public function getPlayerInfo(_arg_1:String):PlayerInfoBean
        {
            return (Map.getPlayerInfo(_arg_1, 60));
        }

        private function waitHero(heroName:String):void
        {
            var heroNames:Array;
            var handler:Function;
            var timer:Timer;
            this.currentAction = "waithero";
            this.pleaseStop = false;
            heroNames = this.getHeroNamesFromMacroNames(heroName).split(";");
            this.onCmdResult((("Waiting for " + ((heroNames.length > 1) ? ("one hero out of " + heroNames.join(", ")) : ("hero " + heroNames[0]))) + " to be available..."));
            handler = function (_arg_1:TimerEvent):void
            {
                var _local_3:String;
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdFinshed(true);
                    return;
                };
                timer.delay = (2 * 1000);
                var _local_2:HeroBean;
                if (!(heroNames.length > 1))
                {
                    _local_2 = findHeroByName(heroNames[0]);
                }
                else
                {
                    for each (_local_3 in heroNames)
                    {
                        _local_2 = findHeroByName(_local_3);
                        if (((!(_local_2 == null)) && (_local_2.status == HeroConstants.HERO_FREE_STATU))) break;
                    };
                };
                if (((_local_2 == null) || (!(_local_2.status == HeroConstants.HERO_FREE_STATU))))
                {
                    return;
                };
                onCmdResult((("Hero " + _local_2.name) + " is now available"));
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, handler);
                timer = null;
                onCmdFinshed(true);
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function resetHeroStatsById(_arg_1:int):void
        {
            this.currentAction = "resetHeroStatsById";
            var _local_2:HeroBean = this.findHeroById(_arg_1);
            if (_local_2 != null)
            {
                this.cityManager.logMsg((((("Resetting attributes for hero " + _local_2.name) + " using ") + Math.ceil((_local_2.level / 10))) + " Holy Water(s)."));
                ActionFactory.getInstance().getHeroCommand().resetPoint(this.castleId, _local_2.id, this.resetHeroStatsResponseHandler);
            }
            else
            {
                this.onCmdFinshed(new ScriptError((('Hero id "' + _arg_1) + '" does not exist. Check entred value and try again'), -9999));
            };
        }

        private function transport(_arg_1:int, _arg_2:TroopBean, _arg_3:ResourceBean, _arg_4:String=""):void
        {
            this.currentAction = "transport";
            this.doMarch(ObjConstants.ARMY_MISSION_TRANS, _arg_1, "none", _arg_2, _arg_3, _arg_4);
        }

        private function train2(_arg_1:TroopBean, _arg_2:String="atk", _arg_3:String="all", _arg_4:int=1):void
        {
            this.currentAction = "train";
            var _local_5:HeroBean;
            var _local_6:Boolean;
            if (_arg_1 == null)
            {
                this.onCmdResult("Invalid troop to train");
                this.onCmdFinshed(true);
                return;
            };
            if (this.cityManager.researches == null)
            {
                this.onCmdResult("Research has not been obtained, please try again later");
                this.onCmdFinshed(true);
                return;
            };
            var _local_7:* = (_arg_3.toLowerCase() == "idle");
            var _local_8:Boolean = ((_local_7) || (_arg_3.toLowerCase() == "all"));
            var _local_9:int = ((_local_8) ? 0 : int(_arg_3));
            var _local_10:int;
            while (_local_10 < this.cityManager.researches.length)
            {
                this.m_techLevels[String(this.cityManager.researches[_local_10].typeId)] = this.cityManager.researches[_local_10].avalevel;
                _local_10++;
            };
            var _local_11:Object = TrainTroopHelper.getTrainObj(this, _arg_1, _local_9, _local_8, _arg_4);
            if (_local_11.errormsg.length > 0)
            {
                this.onCmdResult(_local_11.errormsg, "");
            }
            else
            {
                _local_5 = this.getMayor();
                _local_6 = true;
                if (((_arg_2.toLowerCase() == "any") || (_arg_2.toLowerCase() == "atk")))
                {
                    this.setMayorByType("atk");
                }
                else
                {
                    _local_6 = this.fncSetMayorByName(_arg_2);
                    if (_local_6)
                    {
                    };
                };
                if (_local_6)
                {
                    this.onCmdResult((((("Training " + String(_local_11.amount)) + " ") + TrainTroopHelper.lookupName(_local_11.troopid)) + ((_local_7) ? " in all idle barracks" : ((_local_8) ? " in all barracks" : (" in barrack #" + String(_local_11.barrackid))))), "");
                    CityStateCommands.produceTroop(this.castleId, _local_11.barrackid, _local_11.troopid, _local_11.amount, _local_8, _local_7);
                    if (_local_5 != this.getMayor())
                    {
                        if (_local_5 == null)
                        {
                            this.setMayorByType("re");
                        }
                        else
                        {
                            this.fncSetMayorByName(_local_5.name);
                        };
                    };
                }
                else
                {
                    this.logCmdResponse((("Could not set mayor to " + _arg_2) + ". Not training troops."), "");
                };
            };
            this.cityManager.updateTroopQueue();
            Utils.callLater(1000, this.onCmdFinshed, [true]);
        }

        private function teleport(_arg_1:String, _arg_2:String=""):void
        {
            this.currentAction = "teleport";
            var _local_3:String = ((_arg_2 == "") ? _arg_1.substr(0, 3).toLowerCase() : (_arg_1.substr(0, 1).toLowerCase() + _arg_2.substr(0, 1).toLowerCase()));
            var _local_4:int = ["fri", "sax", "nm", "boh", "ll", "fra", "thu", "mor", "ul", "swa", "bav", "car", "bur", "lom", "tus", "rom"].indexOf(_local_3);
            if (_local_4 == -1)
            {
                _local_4 = ["fri", "sax", "nor", "boh", "low", "fra", "thu", "mor", "upp", "swa", "bav", "car", "bur", "lom", "tus", "rom"].indexOf(_local_3);
            };
            if (_local_4 == -1)
            {
                if (((_arg_1.toLowerCase() == "random") || (_arg_1.toLowerCase() == "any")))
                {
                    (_local_4 == int((Math.random() * 16)));
                }
                else
                {
                    this.onCmdFinshed(new ScriptError((("Invalid state: " + _arg_1) + ", consider using the first few letters of the desired state instead"), -9999));
                    return;
                };
            };
            this.cityManager._recallIncomingArmies();
            this.setCmdResponse(ResponseDispatcher.CITY_MOVE_CASTLE, this.handleCmdResponse);
            ActionFactory.getInstance().getCityCommands().moveCastle(this.castleId, _local_4);
            this.cityManager._resetLocalFieldsInfo();
        }

        private function rereadGoals():void
        {
            this.printGoalCommandWarning();
            this.currentAction = "rereadgoals";
            MainScreen.getInstance()._cityPanel.onSetGoals(this.castleId);
            this.onCmdFinshed(true);
        }

        private function handleGetSupSettingResponse(_arg_1:ColonialDeployResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(("Error received: " + _arg_1.errorMsg), -9999));
                return;
            };
            var _local_2:String = ((_arg_1.troopBean != null) ? Utils.troopBeanToMsgString(_arg_1.troopBean) : "");
            this.onCmdResult(("Suppression setting is currently " + _local_2));
            this.onCmdFinshed(true);
        }

        public function getMapFieldList(name:String, lev:int, rad:Number, center:int=-1, rtnCoords:Boolean=true):String
        {
            var y:int;
            var i:int;
            if (center == -1)
            {
                center = this.castle.fieldId;
            };
            var type:int = Map.getFieldType(name);
            if (type == -1)
            {
                return (null);
            };
            if (((lev < 0) || (lev > 20)))
            {
                return (null);
            };
            if (rad < 0)
            {
                return (null);
            };
            var cX:int = Map.getX(center);
            var cY:int = Map.getY(center);
            if (!Map.isMapReady(cX, cY, rad))
            {
                return (null);
            };
            var fieldId:int;
            var fieldLvl:int;
            var fieldObj:MapCastleBean;
            var results:Array = new Array();
            var x:int = (cX - rad);
            while (x <= (cX + rad))
            {
                y = (cY - rad);
                while (y <= (cY + rad))
                {
                    if (!((((x - cX) * (x - cX)) + ((y - cY) * (y - cY))) > (rad * rad)))
                    {
                        fieldId = Map.getFieldId(x, y);
                        if (Map.getType(fieldId) == type)
                        {
                            fieldLvl = Map.getLevel(fieldId);
                            if ((((fieldLvl == 10) && (lev >= 10)) && ((type == FieldConstants.TYPE_NPC) || (type == FieldConstants.TYPE_CASTLE))))
                            {
                                if ((fieldObj = Map.getDetailInfo(fieldId)) != null)
                                {
                                    fieldLvl = (18 - (2 * fieldObj.powerLevel));
                                };
                            };
                            if ((((fieldLvl == lev) || (lev == 0)) && (results.indexOf(fieldId) == -1)))
                            {
                                results.push(fieldId);
                            };
                        };
                    };
                    y = (y + 1);
                };
                x = (x + 1);
            };
            if (results.length == 0)
            {
                return (null);
            };
            var sortOn:Function = function (_arg_1:int, _arg_2:int):int
            {
                var _local_3:Number = Map.fieldDistance(_arg_1, center);
                var _local_4:Number = Map.fieldDistance(_arg_2, center);
                return ((_local_3 < _local_4) ? -1 : ((_local_3 > _local_4) ? 1 : 0));
            };
            results.sort(sortOn);
            if (rtnCoords)
            {
                i = 0;
                while (i < results.length)
                {
                    results[i] = Map.fieldIdToCoordinate(results[i]);
                    i = (i + 1);
                };
            };
            return (results.join(" "));
        }

        private function updateFort(_arg_1:FortificationsUpdate):void
        {
            if (this.castleId == _arg_1.castleId)
            {
                _arg_1.fortification.copyTo(this.castle.fortification);
            };
        }

        private function scanDetail(targetId:int, r:Number):void
        {
            var cx:int;
            var cy:int;
            var handler:Function;
            var scanTimer:Timer;
            this.currentAction = "scandetail";
            this.pleaseStop = false;
            cx = Map.getX(targetId);
            cy = Map.getY(targetId);
            handler = function (_arg_1:TimerEvent):void
            {
                scanTimer.delay = 1500;
                if (pleaseStop)
                {
                    scanTimer.stop();
                    scanTimer.removeEventListener(TimerEvent.TIMER, handler);
                    scanTimer = null;
                    onCmdFinshed(true);
                    return;
                };
                if (Map.isMapDetailReady(cx, cy, r))
                {
                    scanTimer.stop();
                    scanTimer.removeEventListener(TimerEvent.TIMER, handler);
                    scanTimer = null;
                    onCmdResult(((("SCAN DETAIL COMPLETED " + Map.fieldIdToCoordString(targetId)) + " radius ") + r));
                    onCmdFinshed(true);
                };
            };
            scanTimer = new Timer(0);
            scanTimer.addEventListener(TimerEvent.TIMER, handler);
            scanTimer.start();
        }

        private function cleanReports(_arg_1:String="Barbarian", _arg_2:int=1):void
        {
            CallbackParams.cleanReportsSearchString = _arg_1;
            this.setCmdResponse(ResponseDispatcher.REPORT_RECEIVE_REPORT_LIST, this._sp1096);
            ActionFactory.getInstance().getReportCommands().receiveReportList(_arg_2, 10, ObjConstants.REPORT_TYPE_ARMY);
        }

        private function scout(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "scout";
            this.doMarch(ObjConstants.ARMY_MISSION_SCOUT, _arg_1, _arg_2, _arg_3, null, _arg_4);
        }

        private function wallDefense(_arg_1:String="trap", _arg_2:int=1, _arg_3:String="build"):void
        {
            this.onCmdResult("Waiting for town's turn to build wall defense...");
            this.cityManager._reserveEmergencyTimeSlot();
            this.waitForCmActive(this.wallDefense2, [_arg_1, _arg_2, _arg_3]);
        }

        private function setAllGoals():void
        {
            var _local_1:String;
            _local_1 = "SetAllGoals";
            MainScreen.getInstance().dispatchEvent(new Event(_local_1));
            this.onCmdFinshed(true);
        }

        private function useItem(_arg_1:String):void
        {
            this.currentAction = "useitem";
            var _local_2:String = Items.getItemId(_arg_1);
            if (_local_2 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item name.", -9999));
                return;
            };
            if (((((((_local_2 == "player.heart.1.a") || (_local_2 == "player.pop.1.a")) || (_local_2 == "player.halloween.castle")) || (_local_2 == "player.halloween.castle.adv")) || (_local_2 == "player.haunted.castle")) || (_local_2 == "player.haunted.castle.adv")))
            {
                ActionFactory.getInstance().getShopCommands().useCastleGoods(this.castleId, _local_2, this.handleCmdResponse);
            }
            else
            {
                if (_local_2 == Items.getItemId("Truce_Agreement"))
                {
                    ActionFactory.getInstance().getCityCommands().setStopWarState(_local_2, LoginHelper.getInstance().getHashedEvonyPw(), this.handleCmdResponse);
                }
                else
                {
                    if (_local_2 == Items.getItemId("Hero_Hunting"))
                    {
                        ActionFactory.getInstance().getHeroCommand().refreshHerosListFromTavern(this.castleId, this.handleUseHeroHuntingResponse);
                    }
                    else
                    {
                        ActionFactory.getInstance().getShopCommands().useGoods(this.castleId, _local_2, 1, this.handleUseItemResponse);
                    };
                };
            };
        }

        private function changeFlag(_arg_1:String):void
        {
            this.currentAction = "changeflag";
            this.setCmdResponse(ResponseDispatcher.CITY_MODIFY_FLAG, this.handleCmdResponse);
            this.onCmdResult(("Changing flag to " + _arg_1));
            ActionFactory.getInstance().getCityCommands().modifyFlag(_arg_1);
        }

        private function endKeepResource():void
        {
            this.currentAction = "endkeepresource";
            this.cityManager._cp1009();
            this.onCmdFinshed(true);
        }

        private function waitNoEnemy(ignoreJunk:Boolean=false):void
        {
            var handler:Function;
            var timer:Timer;
            this.currentAction = "waitresource";
            this.pleaseStop = false;
            this.onCmdResult((("Waiting for no more " + ((ignoreJunk) ? "non junkwave" : "")) + " incomming enemy armies..."));
            handler = function (_arg_1:TimerEvent):void
            {
                var _local_2:Boolean;
                var _local_3:ArmyBean;
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdFinshed(true);
                    return;
                };
                if (ignoreJunk)
                {
                    _local_2 = false;
                    for each (_local_3 in cityManager.enemyArmies)
                    {
                        if (!cityManager.isJunkTroop(_local_3.troop))
                        {
                            _local_2 = true;
                            break;
                        };
                    };
                    if (_local_2)
                    {
                        return;
                    };
                }
                else
                {
                    if (cityManager.enemyArmies.length > 0)
                    {
                        return;
                    };
                };
                onCmdResult((("Detected no more " + ((ignoreJunk) ? "non junkwave" : "")) + " incomming enemy armies, resuming script..."));
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, handler);
                timer = null;
                onCmdFinshed(true);
            };
            timer = new Timer(1200);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function _tf342(_arg_1:String):int
        {
            var _local_3:String;
            var _local_2:int;
            for (_local_3 in this.castle.buildingsArray)
            {
                if (((this.castle.buildingsArray[_local_3].typeId == BuildingType.fromString(_arg_1)) && (this.castle.buildingsArray[_local_3].level > _local_2)))
                {
                    _local_2 = this.castle.buildingsArray[_local_3].level;
                };
            };
            return (_local_2);
        }

        private function config(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.cityManager._setConfig(_arg_1);
            this.onCmdResult("*** config changes may become effective a few minutes after the script terminates");
            this.onCmdFinshed(true);
        }

        private function setNpcFlag(_arg_1:int):void
        {
            this.currentAction = "setnpcflag";
            this.cityManager._markAndUnmarkFlatForNpc(_arg_1, true);
            this.onCmdFinshed(true);
        }

        private function handleGearCmdResponse(_arg_1:ResearchResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            if (_arg_1.tech.castleId != this.castleId)
            {
                return;
            };
            var _local_2:Date = new Date(_arg_1.tech.endTime);
            this.onCmdResult(((((GearType.toNameString(_arg_1.tech.typeId) + " level ") + (_arg_1.tech.level + 1)) + " research started.  Estimated finish time ") + _local_2.toLocaleString()), "");
            this.cityManager._handleGearCmdResponse(_arg_1);
            this.onCmdFinshed(true);
        }

        private function capture(_arg_1:int, _arg_2:int):void
        {
            this.currentAction = "capture";
            this.cityManager._oh316(_arg_1, _arg_2, true);
            this.onCmdFinshed(true);
        }

        private function rescanRec(_arg_1:int, _arg_2:int):void
        {
            this.currentAction = "rescanrec";
            this.pleaseStop = false;
            Map.resetRectangle(Map.getX(_arg_1), Map.getY(_arg_1), Map.getX(_arg_2), Map.getY(_arg_2));
            this.scanRec(_arg_1, _arg_2);
        }

        private function untrain(_arg_1:TroopBean):void
        {
            this.currentAction = "untrain";
            var _local_2:TroopBean = this.cityManager._xl810();
            if (_local_2 == null)
            {
                this.onCmdResult("Please wait for town to be initialized first");
                this.onCmdFinshed(true);
            };
            var _local_3:int;
            var _local_4:Number = 0;
            var _local_5:Array = new Array("", "", "peasants", "militia", "scouter", "pikemen", "swordsmen", "archer", "carriage", "lightCavalry", "heavyCavalry", "ballista", "batteringRam", "catapult");
            var _local_6:int;
            while (_local_6 < _local_5.length)
            {
                if (_local_5[_local_6] != "")
                {
                    _local_3 = 0;
                    if (_arg_1[_local_5[_local_6]] > 0)
                    {
                        _local_3 = Math.min(_local_2[_local_5[_local_6]], _arg_1[_local_5[_local_6]]);
                    }
                    else
                    {
                        if (_arg_1[_local_5[_local_6]] < 0)
                        {
                            _local_3 = Math.max(0, (_local_2[_local_5[_local_6]] + _arg_1[_local_5[_local_6]]));
                        };
                    };
                    if (_local_3 > 0)
                    {
                        _local_4 = (_local_4 + _local_3);
                        this.onCmdResult(((("Untrain " + _local_3) + " ") + Utils.troopExtNames[_local_6]));
                        CityStateCommands.disbandTroop(this.castleId, _local_6, _local_3);
                    };
                };
                _local_6++;
            };
            if (_local_4 == 0)
            {
                this.onCmdResult("No troop was untrained");
            };
            this.onCmdFinshed(true);
        }

        private function huntingType(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "huntingtype";
            this.cityManager._bx341(_arg_1);
            this.onCmdFinshed(true);
        }

        private function upLevelHero(_arg_1:String):void
        {
            var _local_2:HeroBean;
            this.currentAction = "uplevelhero";
            _local_2 = this.findHeroByName(_arg_1);
            if (_local_2 == null)
            {
                this.onCmdFinshed(new ScriptError(("No hero found with name: " + _arg_1), -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.HERO_LEVEL_UP, this.handleCmdResponse);
            CityStateCommands.levelUp(this.castleId, _local_2.id, this.handleCmdResponse);
            this.onCmdResult((((("Uplevel hero " + _local_2.name) + "(") + _local_2.id) + ")"));
        }

        private function waitForCmActive(func:Function, args:Array):void
        {
            var handler:Function;
            var waitTimer:Timer;
            this.pleaseStop = false;
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    waitTimer = null;
                    return;
                };
                waitTimer.delay = 1000;
                if (cityManager.isActive())
                {
                    func.apply(this, args);
                    waitTimer.stop();
                    waitTimer.removeEventListener(TimerEvent.TIMER, handler);
                    waitTimer = null;
                };
            };
            waitTimer = new Timer(0);
            waitTimer.addEventListener(TimerEvent.TIMER, handler);
            waitTimer.start();
        }

        private function endLoyaltyAttack():void
        {
            this.currentAction = "endloyaltyattack";
            this.cityManager._le863();
            this.onCmdFinshed(true);
        }

        private function doResearch(_arg_1:String):void
        {
            this.currentAction = "research";
            this.setCmdResponse(ResponseDispatcher.TECH_RESEARCH, this.updateResearch);
            this.researchType = _arg_1.toLowerCase();
            this.setCmdResponse(ResponseDispatcher.TECH_GET_RESEARCH_LIST, this.onDoResearchResponse);
            CityStateCommands.getResearchList(this.castleId, this.onGetResearchListResponse);
        }

        private function fireHero(_arg_1:String):void
        {
            var _local_2:HeroBean;
            var _local_4:Array;
            var _local_5:ArrayCollection;
            var _local_6:HeroBean;
            _local_2 = null;
            var _local_3:Boolean;
            this.currentAction = "firehero";
            _local_4 = this.getHeroNamesFromMacroNames(_arg_1).toLowerCase().split(";");
            _local_5 = this.cityManager._ox998();
            for each (_local_6 in _local_5)
            {
                if (_local_4.indexOf(_local_6.name.toLowerCase()) >= 0)
                {
                    _local_3 = true;
                    if ((((_local_6.status == CityStateConstants.HERO_STATUS_CAPTIVE) || (_local_6.status == CityStateConstants.HERO_STATUS_IDLE)) || (_local_6.status == CityStateConstants.HERO_STATUS_MAYOR)))
                    {
                        _local_2 = _local_6;
                    };
                };
            };
            if (_local_2 == null)
            {
                this.onCmdFinshed(new ScriptError("You failed to specify a valid idle hero", -9999));
                return;
            };
            if (_local_2.status != CityStateConstants.HERO_STATUS_CAPTIVE)
            {
                if (_local_2.status == CityStateConstants.HERO_STATUS_MAYOR)
                {
                    CityStateCommands.dischargeChief(this.castleId);
                };
                this.onCmdResult(("Firing hero " + _local_2.name));
                CityStateCommands.fireHero(this.castleId, _local_2.id, this.handleCmdResponse);
                return;
            };
            this.onCmdResult(("Releasing captured hero " + _local_2.name));
            CityStateCommands.releaseHero(this.castleId, _local_2.id, this.handleCmdResponse);
        }

        private function printGoalCommandWarning():void
        {
            if (!goalCommandWarning)
            {
                return;
            };
            this.onCmdResult("*** You are using a command that should normally be done as a goal. To disable this warning, use 'goalcommandwarning false'");
        }

        private function skypeWarReportReceivers(_arg_1:String):void
        {
            this.currentAction = "";
            this.printGoalCommandWarning();
            if (!this.cityManager._setSkypeWrReceivers(_arg_1))
            {
                this.onCmdFinshed(new ScriptError("Parameter error for command skypewarreportreceivers", -9999));
            }
            else
            {
                this.onCmdFinshed(true);
            };
            this.onCmdFinshed(true);
        }

        private function reinforce(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:ResourceBean=null, _arg_5:String=""):void
        {
            this.currentAction = "reinforce";
            this.doMarch(ObjConstants.ARMY_MISSION_SEND, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        private function _xv597(_arg_1:String="atk", _arg_2:int=69, _arg_3:int=1):void
        {
            this.logCmdResponse("findhero requires exclusive control of all Inns while running and must be disabled in AutoEvony, please use appropriate config settings instead.");
            this.onCmdFinshed(true);
        }

        public function changeheroname(_arg_1:String, _arg_2:String):void
        {
            this.changeHeroName(_arg_1, _arg_2);
        }

        public function get serverTimeRaw():Number
        {
            return (Utils.getCurrentServerTimeRaw().getTime());
        }

        private function sell(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            this.currentAction = "sell";
            this.trade("sell", _arg_1, _arg_2, _arg_3);
        }

        public function setCityStopState():void
        {
            this.pleaseStop = true;
        }

        private function resetHeroStatsByName(_arg_1:String):void
        {
            this.currentAction = "resetHeroStatsByName";
            var _local_2:HeroBean = this.findHeroByName(_arg_1);
            if (_local_2 != null)
            {
                this.cityManager.logMsg((((("Resetting attributes for hero " + _local_2.name) + " using ") + Math.ceil((_local_2.level / 10))) + " Holy Water(s)."));
                ActionFactory.getInstance().getHeroCommand().resetPoint(this.castleId, _local_2.id, this.resetHeroStatsResponseHandler);
            }
            else
            {
                this.onCmdFinshed(new ScriptError((('Hero "' + _arg_1) + '" does not exist. Check spelling and try again'), -9999));
            };
        }

        private function changeHeroGears(_arg_1:String, _arg_2:String):void
        {
            var _local_3:HeroBean;
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:int;
            this.currentAction = "changeHeroGear2";
            _local_3 = this.findHeroByName(_arg_1);
            if (_local_3 == null)
            {
                this.onCmdFinshed(new ScriptError(("Hero name not found: " + _arg_1), -9999));
                return;
            };
            _local_4 = _arg_2.replace(new RegExp("none", "gi"), "0").replace(new RegExp("pol", "gi"), "1").replace(new RegExp("atk", "gi"), "2").replace(new RegExp("int", "gi"), "3").split(",");
            if (((_local_4.length < 1) || (_local_4.length > 16)))
            {
                this.onCmdFinshed(new ScriptError(("Invalid number of gear pieces, expecting  we:atk,shi:atk,ri1:atk,...,fe:atk (up to 16 max) but getting  " + _arg_2), -9999));
                return;
            };
            _local_5 = new Array("he", "che", "we", "shi", "le", "cha1", "ri1", "mo", "ne", "sho", "ba", "ga", "be", "cha2", "ri2", "fo");
            _local_6 = new Array(EquipmentTech.EQUIPMENT_SLOT_HEAD, EquipmentTech.EQUIPMENT_SLOT_CHEST, EquipmentTech.EQUIPMENT_SLOT_WEAPON_L, EquipmentTech.EQUIPMENT_SLOT_SHIELD_L, EquipmentTech.EQUIPMENT_SLOT_LEG_L, EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L, EquipmentTech.EQUIPMENT_SLOT_RING_L, EquipmentTech.EQUIPMENT_SLOT_MOUNT_L, EquipmentTech.EQUIPMENT_SLOT_NECKLACE, EquipmentTech.EQUIPMENT_SLOT_SHOULDERS, EquipmentTech.EQUIPMENT_SLOT_BACK, EquipmentTech.EQUIPMENT_SLOT_WRIST, EquipmentTech.EQUIPMENT_SLOT_WAIST, EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R, EquipmentTech.EQUIPMENT_SLOT_RING_R, EquipmentTech.EQUIPMENT_SLOT_FEET);
            _local_7 = null;
            _local_8 = new Array();
            _local_9 = 0;
            while (_local_9 < _local_4.length)
            {
                _local_7 = _local_4[_local_9].split(":");
                if (_local_7.length != 2)
                {
                    this.onCmdFinshed(new ScriptError(("Invalid format for gear:type found in gear list parameter. Expecting  abr:type  but getting  " + _local_4[_local_9]), -9999));
                    return;
                };
                if (_local_5.indexOf(_local_7[0].toLowerCase()) < 0)
                {
                    this.onCmdFinshed(new ScriptError(((("Invalid gear abbreviation '" + _local_7[0]) + "' found in gear list parameter. Valid options are ") + _local_5.join(", ")), -9999));
                    return;
                };
                if ((((isNaN(Number(_local_7[1]))) || (int(_local_7[1]) < 0)) || (int(_local_7[1]) > 3)))
                {
                    this.onCmdFinshed(new ScriptError((("Invalid gear type '" + _local_7[1]) + "' found in gear list parameter. Valid options are (none, pol, atk, int)"), -9999));
                    return;
                };
                _local_7[0] = _local_7[0].toLowerCase();
                if (_local_3.equipmentbeanArray[(_local_6[_local_5.indexOf(_local_7[0])] - 1)].addAttributeType != int(_local_7[1]))
                {
                    _local_8.push(_local_4[_local_9]);
                };
                _local_9++;
            };
            this.changeHeroGearsParams = new Object();
            this.changeHeroGearsParams.heroName = _arg_1;
            this.changeHeroGearsParams.i = 0;
            this.changeHeroGearsParams.heroId = _local_3.id;
            this.changeHeroGearsParams.setGears = _local_8;
            this.changeHeroGearsHandler();
        }

        public function getMapLevel(_arg_1:int):int
        {
            return (Map.getLevel(_arg_1));
        }

        private function setGuard(_arg_1:int, _arg_2:TroopBean, _arg_3:FortificationsBean=null):void
        {
            this.currentAction = "setguard";
            this.cityManager._vf712(_arg_1, _arg_2, _arg_3);
            this.onCmdFinshed(true);
        }

        public function getStatic(_arg_1:String):*
        {
            return (this.script.getStatic(_arg_1));
        }

        public function setVar(_arg_1:String, _arg_2:*):*
        {
            return (this.script.setVar(_arg_1, _arg_2));
        }

        private function aBigScout(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "abigscout";
            this.doMarch(ObjConstants.ARMY_MISSION_SCOUT, _arg_1, _arg_2, _arg_3, null, _arg_4, true, false, 2, null);
        }

        private function bigAttack(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "bigattack";
            this.doMarch(ObjConstants.ARMY_MISSION_OCCUPY, _arg_1, _arg_2, _arg_3, null, _arg_4, true);
        }

        private function healTroops():void
        {
            this.currentAction = "healtroops";
            this.cityManager.doHealInjuredTroop(true);
            this.onCmdFinshed(true);
        }

        private function honorAttack(_arg_1:int, _arg_2:TroopBean, _arg_3:int=0):void
        {
            this.currentAction = "honorattack";
            this.cityManager._by1090(_arg_1, _arg_2, _arg_3);
            this.onCmdFinshed(true);
        }

        private function chatPc(_arg_1:String, _arg_2:String):void
        {
            this.currentAction = "sendPrivateChatMessage";
            ActionFactory.getInstance().getCommonCommands().privateChat(_arg_1, _arg_2, this.chatHandler);
            MainScreen.getInstance()._chatPanel.showWhisperInChats(_arg_1, _arg_2, "To", true);
            this.onCmdFinshed(true);
        }

        private function guardedAttack(_arg_1:int, _arg_2:TroopBean, _arg_3:int, _arg_4:TroopBean, _arg_5:FortificationsBean=null):void
        {
            this.currentAction = "guardedattack";
            if (_arg_3 <= 0)
            {
                this.onCmdFinshed("Invalid number of scouts for guardedattack");
                return;
            };
            this.cityManager._yi129(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            Utils.callLater(1500, this.onCmdFinshed, [true]);
        }

        private function sellTo(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:Number=0):void
        {
            this.currentAction = "sellto";
            this.tradeTo("sell", _arg_1, _arg_2, _arg_3, _arg_4);
        }

        private function _bw617(_arg_1:int, _arg_2:Boolean=false):Array
        {
            var _local_4:HeroBean;
            var _local_3:Array = new Array();
            for each (_local_4 in this.castle.herosArray)
            {
                if (_local_4.status == _arg_1)
                {
                    _local_3[_local_3.length] = _local_4;
                };
            };
            return (_local_3);
        }

        public function setStatic(_arg_1:String, _arg_2:*):*
        {
            return (this.script.setStatic(_arg_1, _arg_2));
        }

        private function loginToSkype(un:String, pw:String):void
        {
            this.currentAction = "loggingIntoSkype";
            var handler:Function = function (_arg_1:SkypeResponse):void
            {
                if (_arg_1.ok != SkypeConstants.OK_DEFAULT)
                {
                    onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                }
                else
                {
                    cityManager.logMsg("Skype login successful");
                    onCmdFinshed(true);
                };
            };
            var response:SkypeResponse = Skype.login(un, pw, handler);
            if (response.ok == SkypeConstants.OK_DEFAULT)
            {
                if (!this.script.silence)
                {
                    this.cityManager.logMsg(((("Attempting login to skype with username: " + un) + " and password: ") + pw));
                };
            }
            else
            {
                if (response.ok == SkypeConstants.ERROR_USER_ALREADY_LOGGED_IN)
                {
                    if (!this.script.silence)
                    {
                        this.cityManager.logMsg(("Already logged into skype with username " + un));
                    };
                    this.onCmdFinshed(true);
                }
                else
                {
                    this.onCmdFinshed(new ScriptError(response.errorMsg, response.ok));
                };
            };
        }

        private function skypePm(userid:String, msg:String):void
        {
            this.currentAction = "sendSkypePrivateMessage";
            var handler:Function = function (_arg_1:SkypeResponse):void
            {
                if (_arg_1.ok != SkypeConstants.OK_DEFAULT)
                {
                    if (currentAction == "sendSkypePrivateMessage")
                    {
                        onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                    }
                    else
                    {
                        cityManager.logMsg(((_arg_1.errorMsg + ":") + _arg_1.ok));
                    };
                }
                else
                {
                    if (!script.silence)
                    {
                        cityManager.logMsg(_arg_1.msg);
                    };
                    if (currentAction == "sendSkypePrivateMessage")
                    {
                        onCmdFinshed(true);
                    };
                };
            };
            var response:SkypeResponse = Skype.queueMsg(userid, msg, false, handler);
            if (response.ok != SkypeConstants.OK_DEFAULT)
            {
                if (response.ok == SkypeConstants.OK_MSG_QUEUED)
                {
                    this.cityManager.logMsg("Skype private message has been queued, waiting for login to send...");
                    this.onCmdFinshed(true);
                }
                else
                {
                    this.onCmdFinshed(new ScriptError(("Error sending Skype Private Message: " + response.errorMsg), response.ok));
                };
            };
        }

        public function _getReliefStationSpeedupFactor():int
        {
            return (SPEEDUP[this.cityManager.getBuildingLevel(BuildingConstants.TYPE_TRANSPORT_STATION)]);
        }

        private function getResources(_arg_1:String):ResourceBean
        {
            return (Utils.getEstResoBean(_arg_1));
        }

        private function qAll():void
        {
            this.currentAction = "qall";
            var _local_1:Array = MainScreen.getCities();
            var _local_2:Array = Utils.randOrder(_local_1.length);
            var _local_3:CityState;
            var _local_4:int;
            while (_local_4 < _local_2.length)
            {
                _local_3 = _local_1[_local_2[_local_4]];
                _local_3.cityManager._manager();
                _local_4++;
            };
            this.onCmdFinshed(true);
        }

        private function _qDeploy(_arg_1:Object, _arg_2:int, _arg_3:String, _arg_4:TroopBean, _arg_5:ResourceBean=null, _arg_6:String="", _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:int=0):void
        {
            var _local_12:int;
            this.currentAction = "qdeploy";
            var _local_10:int = int(_arg_1);
            if (_local_10 == 0)
            {
                _local_12 = new Array("at", "bu", "re", "sc", "tr", "co", "an", "su", "up", "de").indexOf(_arg_1.toString().toLowerCase().substr(0, 2));
                if (_local_12 == -1)
                {
                    this.logCmdResponse("Invalid deploy value, must be among: attack, build, reinforce, scout, transport, colonize, anticolonize, suppress, uprise, or deploytroop");
                    this.onCmdFinshed(true);
                    return;
                };
                _local_10 = new Array(ObjConstants.ARMY_MISSION_OCCUPY, ObjConstants.ARMY_MISSION_CONSTRUCT, ObjConstants.ARMY_MISSION_SEND, ObjConstants.ARMY_MISSION_SCOUT, ObjConstants.ARMY_MISSION_TRANS, ObjConstants.ARMY_MISSION_COLONIZE, ObjConstants.ARMY_MISSION_ANTI_COLONIAL, ObjConstants.ARMY_MISSION_SUPPRESS, ObjConstants.ARMY_MISSION_UPRISE, ObjConstants.ARMY_MISSION_DEPLOY_TROOPS)[_local_12];
            };
            var _local_11:String = this._doQuickMarch(_local_10, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9);
            this.onCmdResult(_local_11);
            if (_local_11.substr(0, 5) == "March")
            {
                this.setCmdResponse(ResponseDispatcher.ARMY_NEW_ARMY, this.handleCmdResponse);
            }
            else
            {
                Utils.callLater(1500, this.onCmdFinshed, [true]);
            };
        }

        private function attackPlayerValleys(_arg_1:String, _arg_2:int, _arg_3:Number, _arg_4:int=8):void
        {
            this.currentAction = "attackplayervalleys";
            this.onCmdFinshed(true);
        }

        private function buildingGoals(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "buildinggoals";
            this.cityManager._vu1098(_arg_1);
            this.onCmdFinshed(true);
        }

        public function deleteVar(_arg_1:String):*
        {
            return (this.script.deleteVar(_arg_1));
        }

        private function endHonorAttack():void
        {
            this.currentAction = "endhonorattack";
            this.cityManager._pi862();
            this.onCmdFinshed(true);
        }

        private function useTechItem(itemName:String):void
        {
            this.currentAction = "usetechitem";
            var itemId:String = Items.getItemId(itemName);
            if (itemId == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            if (this.cityManager.getResearchInProgress() == null)
            {
                this.onCmdFinshed(new ScriptError("No current research", -9999));
                return;
            };
            var handler:Function = function (_arg_1:ResearchResponse):void
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    onCmdFinshed(new ScriptError(("Research error: " + _arg_1.errorMsg), -9999));
                    return;
                };
                if (((currentAction == "research") || (currentAction == "usetechitem")))
                {
                    onCmdResult("Research response ok");
                    onCmdFinshed(true);
                };
            };
            ActionFactory.getInstance().getTechCommand().speedUpResearch(this.castleId, itemId, handler);
        }

        private function changeCastleName(newName:String):void
        {
            this.currentAction = "changename";
            this.setCmdResponse(ResponseDispatcher.CITY_MODIFY_CASTLE_NAME, function (_arg_1:CommandResponse):void
            {
                if (_arg_1.ok == 1)
                {
                    castle.name = newName;
                    MainScreen.getInstance().doCityTabLabel(castle.id);
                };
                handleCmdResponse(_arg_1);
                onCmdFinshed(true);
            });
            this.onCmdResult(((("Changing castle name from " + this.castle.name) + " to ") + newName));
            ActionFactory.getInstance().getCityCommands().modifyCastleName(this.castleId, newName, this.castle.logUrl);
        }

        public function get techTypes():Object
        {
            var obj:Object;
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
            obj["toDebugString"] = function ():String
            {
                var _local_2:String;
                var _local_1:* = "";
                for (_local_2 in obj)
                {
                    if (_local_2 != "toDebugString")
                    {
                        _local_1 = (_local_1 + (((_local_2 + " = ") + obj[_local_2]) + "\n"));
                    };
                };
                return (_local_1);
            };
            return (obj);
        }

        public function _cleanUp():void
        {
            this.cityManager._cleanup();
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, this.buildComplete);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE, this.researchComplete);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, this.updateFort);
        }

        private function useDevilItem(_arg_1:int, _arg_2:String, _arg_3:String=""):void
        {
            this.currentAction = "usedevilitem";
            var _local_4:String = Items.getItemId(_arg_2);
            if (_local_4 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            this.setCmdResponse(ResponseDispatcher.SHOP_USE_DEVIL_ITEM, this.handleCmdResponse);
            ActionFactory.getInstance().getShopCommands().useDevilItem(Map.getX(_arg_1), Map.getY(_arg_1), _local_4, _arg_3);
        }

        private function distancePolicy(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "distancepolicy";
            this.cityManager._le27(((((((((("" + _arg_1) + " ") + _arg_2) + " ") + _arg_3) + " ") + _arg_4) + " ") + _arg_5));
            this.onCmdFinshed(true);
        }

        public function getItem(_arg_1:String):ItemBean
        {
            var _local_3:ItemBean;
            if ((_arg_1 = Items.getItemId(_arg_1.toLowerCase())) == null)
            {
                return (null);
            };
            var _local_2:ItemBean;
            for each (_local_3 in this.player.itemsArray)
            {
                if (_local_3.id.toLowerCase() == _arg_1)
                {
                    _local_2 = _local_3;
                    break;
                };
            };
            if (_local_2 == null)
            {
                _local_2 = new ItemBean();
                _local_2.id = _arg_1;
                _local_2.count = 0;
            };
            _local_2.name = Items.getItemName(_arg_1);
            return (_local_2);
        }

        private function fmth():void
        {
            this.onCmdResult("Move the training hero");
            this.cityManager._forceTrainingHeroMove();
            this.onCmdFinshed(true);
        }

        private function updateResearch(_arg_1:ResearchResponse):void
        {
            var _local_2:Date;
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            if (_arg_1.tech.castleId != this.castleId)
            {
                return;
            };
            _local_2 = new Date(_arg_1.tech.endTime);
            this.onCmdResult(((((TechType.toString(_arg_1.tech.typeId) + " level ") + (_arg_1.tech.level + 1)) + " research started.  Estimated finish time ") + _local_2.toLocaleString()), "");
            this.currentResearch = _arg_1.tech;
            this.cityManager._rv270(_arg_1);
            this.onCmdFinshed(true);
        }

        private function troopGoal(_arg_1:TroopBean):void
        {
            this.printGoalCommandWarning();
            this.cityManager._addTroopGoal(_arg_1);
            this.onCmdFinshed(true);
        }

        private function unBlockPlayer(_arg_1:String):void
        {
            this.currentAction = "unblock player";
            this.friendBlockPlayerName = _arg_1;
            ActionFactory.getInstance().getFriendCommands().deleteBlock(_arg_1, this.unBlockPlayerResponseHandler);
        }

        private function safeStar(tech:String, targetLevel:int, safetyFactor:Number=2):void
        {
            var techId:int;
            var currentLevel:int;
            var delicateId:String;
            var flawlessId:String;
            var origTargetLevel:int;
            var expectedDelicate:Array;
            var expectedFlawless:Array;
            var busy:Boolean;
            var starHandler:Function;
            var handler:Function;
            var timer:Timer;
            this.currentAction = "safestar";
            if (((targetLevel > 15) || (targetLevel <= 0)))
            {
                this.logCmdResponse(("Invalid gear type: " + tech));
                this.onCmdFinshed(true);
                return;
            };
            techId = GearType.fromString(tech);
            if (techId <= 0)
            {
                this.logCmdResponse(("Invalid gear type: " + tech));
                this.onCmdFinshed(true);
                return;
            };
            if (this.cityManager.gears.length == 0)
            {
                this.cityManager.updateGears();
                this.logCmdResponse("Gears not initialized yet, please rerun later");
                this.onCmdFinshed(true);
                return;
            };
            currentLevel = this.cityManager.getStarLevel(techId);
            if (currentLevel >= targetLevel)
            {
                this.onCmdResult(((("safestar: nothing to do, star level is already " + tech) + ":") + currentLevel));
                this.onCmdFinshed(true);
                return;
            };
            delicateId = Items.getItemId("Delicate_gem");
            flawlessId = Items.getItemId("Flawless_gem");
            origTargetLevel = targetLevel;
            expectedDelicate = new Array(0, 1.538, 4.231, 9.51, 16.578, 26.38, 40.547, 45.216, 51.244, 73.206, 122.01, 221.835, 443.671, 985.936, 2190.97, 4868.82);
            expectedFlawless = new Array(0, 0, 0, 0, 0, 0, 0, 4.705, 10.881, 21.259, 42.098, 83.814, 175.628, 399.173, 895.939, 1999.87);
            busy = false;
            this.pleaseStop = false;
            starHandler = function (_arg_1:GemstoneRespone):void
            {
                busy = false;
                if (_arg_1.ok != 1)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    logCmdResponse(((("  safestar " + tech) + " error: ") + _arg_1.errorMsg));
                    onCmdFinshed(true);
                    return;
                };
                onCmdResult(((((((((("  star level of " + tech) + " is ") + ((currentLevel > _arg_1.enhancedstarlv) ? "down to" : ((currentLevel < _arg_1.enhancedstarlv) ? "UP TO" : "at"))) + " ") + _arg_1.enhancedstarlv) + ", gems: ") + getItemCount(delicateId)) + "/") + getItemCount(flawlessId)));
                currentLevel = _arg_1.enhancedstarlv;
                cityManager._handleStarLevelResponse(_arg_1);
                timer.start();
            };
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdResult((("safestar " + tech) + " has been terminated"));
                    return;
                };
                timer.reset();
                if (busy)
                {
                    return;
                };
                if (((!(Connection.getInstance().authenticated)) || (Connection.getInstance().paused)))
                {
                    return;
                };
                while (targetLevel > 0)
                {
                    if (((getItemCount(delicateId) >= (safetyFactor * expectedDelicate[(targetLevel - 1)])) && (getItemCount(flawlessId) >= (safetyFactor * expectedFlawless[(targetLevel - 1)])))) break;
                    targetLevel--;
                };
                if (currentLevel >= targetLevel)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    if (targetLevel != origTargetLevel)
                    {
                        onCmdResult(((((((((((("safestar ends, star level is now " + tech) + ":") + currentLevel) + ", gems: ") + getItemCount(delicateId)) + "/") + getItemCount(flawlessId)) + ", needed ") + Math.ceil((safetyFactor * expectedDelicate[(origTargetLevel - 1)]))) + "/") + Math.ceil((safetyFactor * expectedFlawless[(origTargetLevel - 1)]))));
                    }
                    else
                    {
                        onCmdResult(((("safestar is successful, star level is now " + tech) + ":") + currentLevel));
                    };
                    onCmdFinshed(true);
                    return;
                };
                var _local_2:String = ((currentLevel <= 5) ? delicateId : ((currentLevel >= 8) ? flawlessId : ((currentLevel != 6) ? ((currentLevel != 7) ? flawlessId : ((getItemCount(delicateId) >= (6 * getItemCount(flawlessId))) ? delicateId : flawlessId)) : ((getItemCount(delicateId) >= (3 * getItemCount(flawlessId))) ? delicateId : flawlessId))));
                var _local_3:int = ((currentLevel <= 2) ? 1 : 4);
                busy = true;
                onCmdResult(((((((("Safestar for " + tech) + ":") + currentLevel) + ", use ") + _local_3) + " ") + Items.getItemName(_local_2)));
                ActionFactory.getInstance().getEquipmentCommands().EnhancedStarByGemStone(_local_2, _local_3, techId, internal::starHandler);
            };
            timer = new Timer(100);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function gear(_arg_1:String):void
        {
            this.currentAction = "gear";
            var _local_2:int = GearType.fromString(_arg_1);
            if (_local_2 <= 0)
            {
                this.logCmdResponse(("Invalid gear type: " + _arg_1));
                this.onCmdFinshed(true);
                return;
            };
            this.setCmdResponse(ResponseDispatcher.EQUIPMENTTECH_RESEARCH, this.handleGearCmdResponse);
            ActionFactory.getInstance().getEquipmenttechCommands().research(this.castleId, _local_2);
        }

        private function useStratItem(_arg_1:int, _arg_2:String):void
        {
            this.currentAction = "usestratitem";
            var _local_3:String = Items.getItemId(_arg_2);
            if (_local_3 == null)
            {
                this.onCmdFinshed(new ScriptError("Invalid item", -9999));
                return;
            };
            ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(this.castleId, _arg_1);
            if (_local_3 == Items.getItemId("Advance_by_A_Hidden_Path"))
            {
                this.setCmdResponse(ResponseDispatcher.SHOP_USE_TRICK_ITEM, this.useAdvByHiddenPathHandler);
            }
            else
            {
                this.setCmdResponse(ResponseDispatcher.SHOP_USE_TRICK_ITEM, this.handleCmdResponse);
            };
            ActionFactory.getInstance().getShopCommands().useTrickItem(_arg_1, 0, _local_3);
        }

        private function trade(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number):void
        {
            if (this.cityManager.getBuildingLevel(BuildingConstants.TYPE_MARKET) == 0)
            {
                this.logCmdResponse("Cannot process the transaction because this city has no Market.");
                this.onCmdFinshed(true);
                return;
            };
            if ((_arg_2 = _arg_2.toLowerCase()) == "wood")
            {
                _arg_2 = "lumber";
            };
            var _local_5:Array = new Array("food", "lumber", "stone", "iron");
            var _local_6:int = _local_5.indexOf(_arg_2);
            if (((!((_arg_1 = _arg_1.toLowerCase()) == "buy")) && (!(_arg_1 == "sell"))))
            {
                this.logCmdResponse((("trade type " + _arg_1) + " must be buy or sell"));
            }
            else
            {
                if (_local_6 != -1)
                {
                    if ((((isNaN(_arg_3)) || (_arg_3 <= 0)) || (_arg_3 > TRADELIMIT)))
                    {
                        this.logCmdResponse(("Invalid amount, must be from 1 to " + TRADELIMIT));
                    }
                    else
                    {
                        if (_arg_4 < 0)
                        {
                            this.logCmdResponse("Invalid price, must be a positive number");
                        }
                        else
                        {
                            if (_arg_3 < _arg_4)
                            {
                                this.logCmdResponse((("The trading amount " + _arg_3) + " is too small"));
                            }
                            else
                            {
                                if (_arg_4 >= 10)
                                {
                                    _arg_4 = (int((_arg_4 * 100)) / 100);
                                }
                                else
                                {
                                    _arg_4 = (int((_arg_4 * 1000)) / 1000);
                                };
                                if (_arg_1 == "buy")
                                {
                                    this.onCmdResult(((((("Buy " + _local_5[_local_6]) + ": ") + _arg_3) + " at price ") + _arg_4));
                                    this.setCmdResponse(ResponseDispatcher.TRADE_NEW_TRADE, this.handleCmdResponse);
                                    CityStateCommands.newTrade(this.castleId, _local_6, TradeConstants.TRADE_TYPE_BUY, _arg_3, ("" + _arg_4));
                                    return;
                                };
                                if (_arg_1 == "sell")
                                {
                                    this.onCmdResult(((((("Sell " + _local_5[_local_6]) + ": ") + _arg_3) + " at price ") + _arg_4));
                                    this.setCmdResponse(ResponseDispatcher.TRADE_NEW_TRADE, this.handleCmdResponse);
                                    CityStateCommands.newTrade(this.castleId, _local_6, TradeConstants.TRADE_TYPE_SELL, _arg_3, ("" + _arg_4));
                                    return;
                                };
                            };
                        };
                    };
                }
                else
                {
                    this.logCmdResponse(("Invalid resource, must be among " + _local_5.join(" ")));
                };
            };
            this.onCmdFinshed(true);
        }

        public function get lag():Number
        {
            return (this.cityManager._getMarketLag());
        }

        private function _lx19(_arg_1:String):TroopBean
        {
            return (Utils.getTroops(_arg_1));
        }

        private function unBlockPlayerResponseHandler(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != 1)
            {
                this.friendBlockPlayerName = null;
                this.onCmdFinshed(new ScriptError(_arg_1.errorMsg, _arg_1.ok));
                return;
            };
            var _local_2:PlayerInfoBean;
            var _local_3:int;
            while (_local_3 < this.player.blockBeansArray.length)
            {
                if (this.player.blockBeansArray[_local_3].userName.toLowerCase() == this.friendBlockPlayerName.toLowerCase())
                {
                    _local_2 = (this.player.blockBeansArray.removeItemAt(_local_3) as PlayerInfoBean);
                    break;
                };
                _local_3++;
            };
            var _local_4:* = "";
            if (_local_2 != null)
            {
                _local_4 = (('Player "' + _local_2.userName) + '" was successfully removed from your Block Players List.');
            }
            else
            {
                _local_4 = (('Player "' + this.friendBlockPlayerName) + '" not found in your Block Players List. Check spelling before trying again. No action taken.');
            };
            this.cityManager.logMsg(_local_4);
            this.friendBlockPlayerName = null;
            this.onCmdFinshed(true);
        }

        private function colonize(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "colonize";
            this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE, _arg_1, _arg_2, _arg_3, null, _arg_4);
        }

        private function excercise(_arg_1:TroopBean, _arg_2:TroopBean):void
        {
            this.onCmdResult(((("Excercise: " + Utils.troopBeanToMsgString(_arg_1)) + " v.s. ") + Utils.troopBeanToMsgString(_arg_2)));
            this.setCmdResponse(ResponseDispatcher.ARMY_EXERCISE_ARMY, this._fq231);
            ActionFactory.getInstance().getArmyCommands().exerciseArmy(this.castleId, _arg_1, _arg_2);
        }

        public function _getScriptCmd(_arg_1:String):ScriptCmd
        {
            if (this.scriptCmds == null)
            {
                this.setScriptCmds();
            };
            if (this.scriptCmds[_arg_1] != undefined)
            {
                return (this.scriptCmds[_arg_1] as ScriptCmd);
            };
            return (null);
        }

        private function waitTurn():void
        {
            this.waitForCmActive(this.onCmdFinshed, [true]);
        }

        private function chatAc(_arg_1:String):void
        {
            this.currentAction = "sendAllianceChatMessage";
            ActionFactory.getInstance().getCommonCommands().allianceChat(_arg_1, 0, this.chatHandler);
            this.onCmdFinshed(true);
        }

        public function getTechLevels():Object
        {
            return (this.m_techLevels);
        }

        private function fncSetMayorByName(_arg_1:String):Boolean
        {
            var _local_2:Boolean;
            var _local_3:HeroBean;
            _local_2 = false;
            if (_arg_1 == "none")
            {
                this.onCmdResult("Remove mayor");
                CityStateCommands.dischargeChief(this.castleId);
                return (true);
            };
            _local_3 = this.findHeroByName(_arg_1);
            if (_local_3 == null)
            {
                this.logCmdResponse(("You dont even have a hero named " + _arg_1), "");
            }
            else
            {
                if (_local_3.status == CityStateConstants.HERO_STATUS_IDLE)
                {
                    _local_2 = true;
                    this.onCmdResult((("Promoted " + _arg_1) + " to mayor"), "");
                    CityStateCommands.promoteToChief(this.castleId, _local_3.id);
                }
                else
                {
                    if (_local_3.status == CityStateConstants.HERO_STATUS_MAYOR)
                    {
                        _local_2 = true;
                        this.logCmdResponse((("Hero " + _arg_1) + " is already mayor"), "");
                    }
                    else
                    {
                        this.logCmdResponse((("Hero " + _arg_1) + " is not idle"), "");
                    };
                };
            };
            return (_local_2);
        }

        private function setFocus():void
        {
            this.currentAction = "setfocus";
            this.onCmdResult((((("Focus will be set to " + this.castle.name) + "(") + this.coord) + ")"));
            this.cityManager._reserveEmergencyTimeSlot(true);
            this.onCmdFinshed(true);
        }

        private function scanMap(center:int, r:Number, useFastScan:Boolean=false):void
        {
            var cx:int;
            var cy:int;
            var handler:Function;
            var timer:Timer;
            this.currentAction = "scanmap";
            this.pleaseStop = false;
            cx = Map.getX(center);
            cy = Map.getY(center);
            handler = function (_arg_1:TimerEvent):void
            {
                timer.delay = 500;
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdFinshed(true);
                    return;
                };
                if (Map.isMapReady(cx, cy, r, true))
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdResult(((("SCAN MAP COMPLETED " + Map.fieldIdToCoordString(center)) + " radius ") + r));
                    onCmdFinshed(true);
                };
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function valleyTroops(_arg_1:TroopBean):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "valleytroops";
            this.cityManager._setValleyTroops(Utils.troopBeanToMsgString(_arg_1));
            this.onCmdFinshed(true);
        }

        private function findPlayerValleys(_arg_1:String, _arg_2:int, _arg_3:Number, _arg_4:int=8):void
        {
            this.currentAction = "findplayervalleys";
            this.cityManager._findPlayerValleys(_arg_1.replace("-", " "), _arg_2, _arg_3, _arg_4);
            this.onCmdFinshed(true);
        }

        private function research(_arg_1:String):void
        {
            if (Version.isTraceOn())
            {
                trace("create - verify research");
            };
            if (this.cityManager.getResearchInProgress() == null)
            {
                this.doResearch(_arg_1);
                return;
            };
            this.onCmdResult("Waiting for current tech to complete...");
            this.waitResearch(this.doResearch, [_arg_1]);
        }

        private function doComfortByName(_arg_1:String):void
        {
            switch (_arg_1.toLowerCase().substr(0, 2))
            {
                case "di":
                case "re":
                    this.doComfortByType(CityStateConstants.COMFORT_RELIEF);
                    return;
                case "pr":
                    this.doComfortByType(CityStateConstants.COMFORT_PRAY);
                    return;
                case "bl":
                    this.doComfortByType(CityStateConstants.COMFORT_BLESS);
                    return;
                case "po":
                    this.doComfortByType(CityStateConstants.COMFORT_POPULATION_RAISE);
                    return;
                default:
                    this.onCmdFinshed(new ScriptError((((((((((("Unknown comfort type: " + _arg_1) + "  Must be one of the following: ") + CityStateConstants.COMFORT_RELIEF) + ", ") + CityStateConstants.COMFORT_PRAY) + ", ") + CityStateConstants.COMFORT_BLESS) + ", ") + CityStateConstants.COMFORT_POPULATION_RAISE) + "  or  relief, pray, bless, pop"), -9999));
            };
        }

        private function enemyWarningIgnoreList(_arg_1:String):void
        {
            this.currentAction = "";
            this.printGoalCommandWarning();
            if (!this.cityManager._setEnemyWarningIgnoreLists(_arg_1))
            {
                this.onCmdFinshed(new ScriptError("Parameter error for command enemywarningignoreList", -9999));
            }
            else
            {
                this.onCmdFinshed(true);
            };
            this.onCmdFinshed(true);
        }

        private function upgrade2(_arg_1:String="*", _arg_2:String="LowestLevel", _arg_3:Boolean=false):void
        {
            var _local_4:int = BuildingType.fromString(_arg_1);
            if (_local_4 == -1)
            {
                this.onCmdFinshed(new ScriptError("Invalid building", -9999));
                return;
            };
            this.currentAction = "upgrade";
            var _local_5:BuildingBean = BuildSelectionPolicy.findByPolicy(this.castle.buildingsArray.toArray(), _arg_1, _arg_2, 9);
            if (_local_5 == null)
            {
                this.onCmdFinshed(new ScriptError((("Unable to perform upgrade. Unable to find " + _arg_1) + ". Upgrade level 9 buildings must explicitly specified with level9 build policy"), ErrorCode.ERROR_BUILDING_POSITION));
                return;
            };
            if (_arg_3)
            {
                this.onCmdResult(((("Queue upgrading of building " + BuildingType.toString(_local_4)) + " at location ") + _local_5.positionId));
                this.setCmdResponse(ResponseDispatcher.CASTLE_NEW_BUILDING_QUEUE, this.handleCmdResponse);
            }
            else
            {
                this.onCmdResult(((("Starting upgrade of " + BuildingType.toString(_local_4)) + " at location ") + _local_5.positionId));
                if (Version.isTraceOn())
                {
                    trace("setup upgrade response callbacks");
                };
                this.setCmdResponse(ResponseDispatcher.CASTLE_UPGRADE_BUILDING, this.buildCmdHandler);
            };
            CityStateCommands.upgradeBuilding(this.castleId, _local_5.positionId, null, _arg_3);
            if (Version.isTraceOn())
            {
                trace(((((("upgrading " + _local_5.name) + ", position ") + _local_5.positionId) + " on castle ") + this.castle.name));
            };
        }

        private function fortificationGoal(_arg_1:FortificationsBean):void
        {
            this.printGoalCommandWarning();
            this.cityManager._io1033(_arg_1);
            this.onCmdFinshed(true);
        }

        private function buyTo(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:Number=0):void
        {
            this.currentAction = "buyto";
            this.tradeTo("buy", _arg_1, _arg_2, _arg_3, _arg_4);
        }

        private function handleGetColonyOverviewResponse(_arg_1:OverviewColonyCastleRespone):void
        {
            var _local_3:HeroBean;
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(("Error received: " + _arg_1.errorMsg), -9999));
                return;
            };
            this.onCmdResult(((((((((("Colony resource: g:" + Utils.abbrNum(_arg_1.castleBean.resource.gold)) + " f:") + Utils.abbrNum(_arg_1.castleBean.resource.food.amount)) + " w:") + Utils.abbrNum(_arg_1.castleBean.resource.wood.amount)) + " s:") + Utils.abbrNum(_arg_1.castleBean.resource.stone.amount)) + " i:") + Utils.abbrNum(_arg_1.castleBean.resource.iron.amount)));
            this.onCmdResult(("Colony troop: " + Utils.troopStrBeanToMsgString(_arg_1.castleBean.strTroop, false)));
            var _local_2:* = "";
            for each (_local_3 in _arg_1.castleBean.herosArray)
            {
                _local_2 = (_local_2 + (" " + Utils.heroBeanToString(_local_3)));
            };
            this.onCmdResult(("Colony heroes: " + _local_2));
            this.onCmdFinshed(true);
        }

        private function _fg506(_arg_1:TroopBean):void
        {
            this.valleyTroops(_arg_1);
        }

        private function listPackages():void
        {
            this.currentAction = "listGiftPackages";
            ActionFactory.getInstance().getCommonCommands().getPackageList(this.listPackagesResponse);
        }

        private function aBigColonize(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "abigcolonize";
            this.doMarch(ObjConstants.ARMY_MISSION_COLONIZE, _arg_1, _arg_2, _arg_3, null, _arg_4, true, false, 2, null);
        }

        private function changeHeroName(_arg_1:String, _arg_2:String):void
        {
            var _local_3:HeroBean;
            var _local_4:HeroBean;
            _local_3 = null;
            this.currentAction = "changeheroname";
            for each (_local_4 in this.castle.herosArray)
            {
                if (_local_4.name.toLowerCase() == _arg_1.toLowerCase())
                {
                    _local_3 = _local_4;
                };
            };
            if (_local_3 != null)
            {
                if (((_local_4.status == CityStateConstants.HERO_STATUS_IDLE) || (_local_4.status == CityStateConstants.HERO_STATUS_MAYOR)))
                {
                    this.setCmdResponse(ResponseDispatcher.HERO_CHANGE_NAME, this.handleCmdResponse);
                    this.onCmdResult(((("Changing name on hero " + _arg_1) + " to ") + _arg_2));
                    CityStateCommands.changeName(this.castleId, _local_3.id, _arg_2);
                }
                else
                {
                    this.onCmdFinshed(new ScriptError("The status of the specified hero is not available/free.", -9999));
                };
            }
            else
            {
                this.onCmdFinshed(new ScriptError("You failed to specify a valid hero", -9999));
            };
        }

        private function verbose(_arg_1:String):void
        {
            if (_arg_1.toLowerCase() == "on")
            {
                this.verboseLogs = true;
            }
            else
            {
                this.verboseLogs = false;
            };
            this.onCmdFinshed(true);
        }

        private function resetGoals():void
        {
            this.printGoalCommandWarning();
            this.currentAction = "resetgoals";
            this.cityManager._resetCMVariables();
            this.onCmdFinshed(true);
        }

        private function heroRecall(_arg_1:String):void
        {
            var _local_2:HeroBean = this.findHeroByName(_arg_1);
            if (_local_2 == null)
            {
                this.onCmdResult(("Unable to find hero: " + _arg_1));
                this.onCmdFinshed(true);
                return;
            };
            this.onCmdResult(("Recalling hero " + _arg_1));
            this.setCmdResponse(ResponseDispatcher.HERO_CALL_BACK_HERO, this.handleCmdResponse);
            CityStateCommands.callBackHero(this.castleId, _local_2.id);
        }

        private function donateQuest(_arg_1:int):void
        {
            this.currentAction = "donatequest";
            this.setCmdResponse(ResponseDispatcher.QUEST_DONATE, this.handleCmdResponse);
            ActionFactory.getInstance().getQuestCommands().donate(_arg_1, this.castleId);
        }

        public function getItemName(_arg_1:String):String
        {
            return (Items.getItemName(_arg_1));
        }

        private function logCmdResponse(_arg_1:Object, _arg_2:String="", _arg_3:String="#FF0000"):void
        {
            dispatchEvent(new CityStateResponseEvent(_arg_1, _arg_2, _arg_3));
        }

        private function chatBc(_arg_1:String):void
        {
            this.currentAction = "sendBeginnerChatMessage";
            ActionFactory.getInstance().getCommonCommands().channelChat(CommonConstants.CHAT_CHANNEL_BEGINNER, _arg_1, 0, this.chatHandler);
            this.onCmdFinshed(true);
        }

        private function currentActiveBuilding():BuildingBean
        {
            var _local_2:String;
            var _local_1:BuildingBean;
            for (_local_2 in this.castle.buildingsArray)
            {
                if (this.castle.buildingsArray[_local_2].status != BuildingConstants.STATUS_NORMAL)
                {
                    _local_1 = this.castle.buildingsArray[_local_2];
                    break;
                };
            };
            return (_local_1);
        }

        public function getValue(type:String, data:String, d2:String=null, d3:String=null, d4:String=null, d5:String=null, d6:String=null, d7:String=null, d8:String=null, d9:String=null, d10:String=null, d11:String=null, d13:String=null, d14:String=null, d15:String=null, d16:String=null, d17:String=null):*
        {
            data = (((((((((((((((data + ((d2 != null) ? ("," + d2) : "")) + ((d3 != null) ? ("," + d3) : "")) + ((d4 != null) ? ("," + d4) : "")) + ((d5 != null) ? ("," + d5) : "")) + ((d6 != null) ? ("," + d6) : "")) + ((d7 != null) ? ("," + d7) : "")) + ((d8 != null) ? ("," + d8) : "")) + ((d9 != null) ? ("," + d9) : "")) + ((d10 != null) ? ("," + d10) : "")) + ((d11 != null) ? ("," + d11) : "")) + ((d13 != null) ? ("," + d13) : "")) + ((d14 != null) ? ("," + d14) : "")) + ((d15 != null) ? ("," + d15) : "")) + ((d16 != null) ? ("," + d16) : "")) + ((d17 != null) ? ("," + d17) : ""));
            if (type == "String")
            {
                return (data);
            };
            if (type == "Boolean")
            {
                return (data == "true");
            };
            if (type == "Number")
            {
                return (Utils.removeAbbr(data));
            };
            if (type == "int")
            {
                return (int(Utils.removeAbbr(data)));
            };
            if (type == "XML")
            {
                try
                {
                    return (new XML(data));
                }
                catch(e:Error)
                {
                    throw (new Error((("FATAL ERROR: Invalid type " + type) + " in getValue(), invalid XML or XML that is not well formed")));
                };
            };
            if (type == "Coordinate")
            {
                return (Map.coordStringToFieldId(data));
            };
            if (type == "Resource")
            {
                return ((data != "none") ? Utils.getEstResoBean(data) : null);
            };
            if (type == "Fortification")
            {
                return ((data != "none") ? Utils.getFortifications(data) : null);
            };
            if (type == "Troop")
            {
                return ((data != "none") ? Utils.getTroops(data) : null);
            };
            throw (new Error((("FATAL ERROR: Invalid type " + type) + " in getValue(), must be String, Boolean, Number, int, XML, Coordinate, Resource, Fortification, Troop")));
        }

        private function clearWallQueue(_arg_1:int=1):void
        {
            this.currentAction = "cleartroopqueues";
            this.cityManager._clearWallQueue(_arg_1);
            this.onCmdFinshed(true);
        }

        private function monitorPrestige(nick:String, popChecked:Boolean=false, maxResultCount:int=30):void
        {
            var lastPrest:int;
            var lastPopChange:int;
            var lastPop:int;
            var lastTime:Number;
            var date:Date;
            var result:Array;
            var callBack:Function;
            var handler:Function;
            var timer:Timer;
            this.currentAction = "monitorprestige";
            this.pleaseStop = false;
            lastPrest = -1;
            lastPopChange = -1;
            lastPop = -1;
            var counter:int;
            lastTime = -1;
            date = new Date();
            result = new Array();
            nick = nick.split("-").join(" ");
            callBack = function (_arg_1:PlayerInfoResponse):void
            {
                if (_arg_1.ok != 1)
                {
                    logCmdResponse(("Error retrieving player info: " + _arg_1.errorMsg));
                    onCmdFinshed(true);
                    return;
                };
                if (_arg_1.playerInfo.userName.toLowerCase() != nick.toLowerCase())
                {
                    return;
                };
                if (lastPrest == -1)
                {
                    lastPrest = _arg_1.playerInfo.prestige;
                    lastPop = _arg_1.playerInfo.population;
                    if (lastPopChange == -1)
                    {
                        lastPopChange = (_arg_1.playerInfo.population - lastPop);
                    };
                    lastTime = Utils.getServerTime();
                    date.setTime(lastTime);
                    cityManager.logMsg((((("Monitor player: <b>" + nick) + "</b>   starting Prestige: <b>") + lastPrest) + "</b>"));
                    return;
                };
                if (((_arg_1.playerInfo.prestige == lastPrest) && ((!(popChecked)) || (_arg_1.playerInfo.population == lastPop))))
                {
                    if ((Utils.getServerTime() - lastTime) > ((3 * 60) * 1000))
                    {
                        lastTime = Utils.getServerTime();
                        cityManager.logMsg(((((("Monitor player: <b>" + nick) + "</b>   last Prestige: <b>") + lastPrest) + "</b> ") + result.join("  |  ")), "#00CF00");
                    };
                    return;
                };
                if (((!((_arg_1.playerInfo.prestige - lastPrest) == 0)) || ((popChecked) && (!((_arg_1.playerInfo.population - lastPop) == 0)))))
                {
                    if (popChecked)
                    {
                        result.unshift(((((((((("@" + date.getHours()) + ":") + Utils.format2(date.getMinutes())) + " ") + (((_arg_1.playerInfo.prestige - lastPrest) > 0) ? "+" : "")) + (_arg_1.playerInfo.prestige - lastPrest)) + ":") + (((_arg_1.playerInfo.population - lastPop) > 0) ? "+" : "")) + (_arg_1.playerInfo.population - lastPop)));
                    }
                    else
                    {
                        result.unshift((((((("@" + date.getHours()) + ":") + Utils.format2(date.getMinutes())) + " ") + (((_arg_1.playerInfo.prestige - lastPrest) > 0) ? "+" : "")) + (_arg_1.playerInfo.prestige - lastPrest)));
                    };
                };
                var _local_2:int = (result.length - maxResultCount);
                if (_local_2 > 0)
                {
                    result.splice((result.length - _local_2), _local_2);
                };
                if (((!((_arg_1.playerInfo.prestige - lastPrest) == 0)) || ((popChecked) && (Math.abs((lastPopChange - (_arg_1.playerInfo.population - lastPop))) > 1))))
                {
                    cityManager.logMsg(((((((("Monitor player: <b>" + nick) + "</b>  Change detected  Last pres: <b>") + lastPrest) + "</b>  Now pres: <b>") + _arg_1.playerInfo.prestige) + "</b>  New results: ") + result.join("  |  ")), "#EE0000");
                }
                else
                {
                    if ((Utils.getServerTime() - lastTime) > ((3 * 60) * 1000))
                    {
                        lastTime = Utils.getServerTime();
                        cityManager.logMsg(((((("Monitor player: <b>" + nick) + "</b>  No change  Pres: <b>") + lastPrest) + "</b>  Results: ") + result.join("  |  ")), "#00CF00");
                    };
                };
                lastPrest = _arg_1.playerInfo.prestige;
                lastPopChange = (_arg_1.playerInfo.population - lastPop);
                lastPop = _arg_1.playerInfo.population;
                lastTime = Utils.getServerTime();
                date.setTime(lastTime);
            };
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                    timer = null;
                    onCmdResult(((((("Done monitoring player: " + nick) + "   last Prestige: ") + lastPrest) + " ") + result.join("  |  ")), "", "#00CF00");
                    return;
                };
                timer.delay = (10000 + Utils.getRandomInt(0, 10000));
                if ((counter++ % 6) != 0)
                {
                    return;
                };
                if (!Connection.getInstance().authenticated)
                {
                    return;
                };
                ActionFactory.getInstance().getCommonCommands().getPlayerInfoByName(nick, callBack);
            };
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function dumpTroop(_arg_1:int, _arg_2:TroopBean, _arg_3:TroopBean):void
        {
            this.currentAction = "dump troop";
            this.cityManager._jt504(_arg_1, _arg_2, _arg_3);
            Utils.callLater(1500, this.onCmdFinshed, [true]);
        }

        private function handleQuestListResponse(_arg_1:QuestListResponse):void
        {
            var _local_4:QuestBean;
            var _local_5:QuestTargetBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                scriptQuestActive = false;
                this.onCmdFinshed(new ScriptError(("Error executing completequests: " + _arg_1.errorMsg), _arg_1.ok));
                return;
            };
            if (Version.isTraceOn())
            {
                trace("Enter awardQuests");
            };
            var _local_2:* = "";
            var _local_3:int = new Array("Lieutenant", "Captain", "Major", "Colonel", "General").indexOf(this.player.playerInfo.office);
            for each (_local_4 in _arg_1.questsArray)
            {
                if (Version.isTraceOn())
                {
                    trace(((((("Quest: " + _local_4.description) + " Finished: ") + _local_4.isFinish) + " Award: ") + _local_4.award));
                };
                if (_local_4.isFinish)
                {
                    if ((((_local_3 >= this.player.playerInfo.titleId) && (!(_local_4.award == null))) && (!(_local_4.award.indexOf("Rank") == -1))))
                    {
                        this.onCmdResult((("Skipping rank quest " + _local_4.name) + " due to low title"));
                    }
                    else
                    {
                        this.onCmdResult((_local_4.name + " quest complete."), (" Award item(s): " + _local_4.award));
                        ActionFactory.getInstance().getQuestCommands().award(this.castleId, _local_4.questId);
                    };
                }
                else
                {
                    if (((!(_local_4.award.indexOf("Rank") == -1)) || (!(_local_4.award.indexOf("Title") == -1))))
                    {
                        _local_2 = "";
                        for each (_local_5 in _local_4.targetsArray)
                        {
                            if (!_local_5.finished)
                            {
                                _local_2 = (_local_2 + (" " + _local_5.name));
                            };
                        };
                        this.onCmdResult(((("Current promotion quest: " + _local_4.name) + ", need: ") + _local_2));
                    }
                    else
                    {
                        if (_local_4.name.indexOf("Donation") == 0)
                        {
                            this.onCmdResult(((("donatequest " + _local_4.questId) + " available: ") + _local_4.manual));
                        }
                        else
                        {
                            if (_local_4.name.indexOf("Queen") == 0)
                            {
                                this.onCmdResult(("Current queen quest: " + _local_4.manual));
                            };
                        };
                    };
                };
            };
            findQuestCount--;
            if (findQuestCount <= 0)
            {
                findQuestCastleId = 0;
                scriptQuestActive = false;
                this.onCmdFinshed(true);
            };
        }

        private function _gv907(_arg_1:TroopBean):void
        {
            this.npcTroop(_arg_1);
        }

        private function changePlayerNick(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null):void
        {
            this.currentAction = "changePlayerNick";
            _arg_1 = ((((_arg_1 + ((_arg_2 != null) ? (" " + _arg_2) : "")) + ((_arg_3 != null) ? (" " + _arg_3) : "")) + ((_arg_4 != null) ? (" " + _arg_4) : "")) + ((_arg_5 != null) ? (" " + _arg_5) : ""));
            if (((Utils.specialCharFilter(_arg_1)) || (Utils.isBadWord(_arg_1))))
            {
                this.onCmdFinshed(new ScriptError((("Name Error: '" + _arg_1) + "' contains restricted characters or bad words."), -9999));
                return;
            };
            ActionFactory.getInstance().getCityCommands().modifyUserName(_arg_1, "player.name.1.a", this.changePlayerNickResponse);
        }

        public function findHeroById(_arg_1:int):HeroBean
        {
            var _local_2:HeroBean;
            if (!isNaN(_arg_1))
            {
                for each (_local_2 in this.cityManager.heroes)
                {
                    if (_local_2.id == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        private function resourceLimits(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "resourcelimits";
            this.cityManager.processRresourceLimits(((((((("" + _arg_1) + " ") + _arg_2) + " ") + _arg_3) + " ") + _arg_4));
            this.onCmdFinshed(true);
        }

        private function buildComplete(_arg_1:BuildComplate):void
        {
            if (this.castleId != _arg_1.castleId)
            {
                return;
            };
            this.updateBuildingBean(_arg_1.buildingBean);
            if (_arg_1.buildingBean.status != BuildingConstants.STATUS_NORMAL)
            {
                if ((((this.currentAction == "demo") || (this.currentAction == "create")) || (this.currentAction == "upgrade")))
                {
                    this.onCmdResult(_arg_1, this.currentAction);
                };
            };
        }

        private function listItems(_arg_1:String=""):void
        {
            var _local_4:ItemBean;
            this.currentAction = "listitems";
            var _local_2:String;
            var _local_3:* = "";
            _arg_1 = _arg_1.toLowerCase();
            for each (_local_4 in this.player.itemsArray)
            {
                if (_local_4.id != null)
                {
                    _local_2 = Items.getItemName(_local_4.id);
                    if (_local_2.toLowerCase().replace(/\’/g, "'").indexOf(_arg_1.replace(/\’/g, "'")) != -1)
                    {
                        _local_3 = (_local_3 + (((((_local_3 != "") ? ",  " : "") + _local_4.count) + " ") + _local_2));
                    };
                };
            };
            this.cityManager.logMsg(("<b>Items:</b>   " + _local_3));
            if (_arg_1 == "")
            {
                this.onCmdResult("Consider using 'listitem filter', for example 'listitem guide', to restrict result");
            };
            this.onCmdFinshed(true);
        }

        private function comfort(_arg_1:String):void
        {
            this.currentAction = "comfort";
            this.onCmdResult("Starting", this.currentAction);
            if (int(_arg_1) != 0)
            {
                if (((int(_arg_1) >= CityStateConstants.COMFORT_RELIEF) && (int(_arg_1) <= CityStateConstants.COMFORT_POPULATION_RAISE)))
                {
                    this.doComfortByType(int(_arg_1));
                }
                else
                {
                    this.onCmdFinshed(new ScriptError((((((((((("Unknown comfort type: " + _arg_1) + "  Must be one of the following: ") + CityStateConstants.COMFORT_RELIEF) + ", ") + CityStateConstants.COMFORT_PRAY) + ", ") + CityStateConstants.COMFORT_BLESS) + ", ") + CityStateConstants.COMFORT_POPULATION_RAISE) + "  or  relief, pray, bless, pop"), -9999));
                };
            }
            else
            {
                this.doComfortByName(_arg_1);
            };
            this.onCmdResult(this.currentAction, "complete");
        }

        private function buildCmdHandler(_arg_1:CommandResponse):void
        {
            if (!(((this.currentAction == "demo") || (this.currentAction == "create")) || (this.currentAction == "upgrade")))
            {
                return;
            };
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(("Error executing build command: " + _arg_1.errorMsg), _arg_1.ok));
            }
            else
            {
                this.onCmdFinshed(true);
            };
        }

        private function blockPlayer(_arg_1:String):void
        {
            var _local_2:PlayerInfoBean;
            var _local_3:PlayerInfoBean;
            this.currentAction = "block player";
            for each (_local_2 in this.player.friendBeansArray)
            {
                if (_local_2.userName.toLowerCase() == _arg_1.toLowerCase())
                {
                    this.onCmdFinshed(new ScriptError((((('Player "' + _local_2.userName) + '" is in your Friends List. Run "unfriendplayer ') + _local_2.userName) + '" before trying to block the player.'), -9999));
                    return;
                };
            };
            for each (_local_3 in this.player.blockBeansArray)
            {
                if (_local_3.userName.toLowerCase() == _arg_1.toLowerCase())
                {
                    this.cityManager.logMsg((("Player <font color='#CC0000'>\"" + _local_3.userName) + '"</font> is already in your Block Players List. No action taken.'));
                    this.onCmdFinshed(true);
                    return;
                };
            };
            this.friendBlockPlayerName = _arg_1;
            ActionFactory.getInstance().getFriendCommands().addBlock(_arg_1, this.blockPlayerResponseHandler);
        }

        private function cityHasEnoughTroops(_arg_1:TroopBean):Boolean
        {
            var _local_2:* = "insufficent troops:";
            var _local_3:Boolean = true;
            if (_arg_1.archer > this.castle.troop.archer)
            {
                _local_2 = (_local_2 + ((" archer :(" + (_arg_1.archer - this.castle.troop.archer)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.ballista > this.castle.troop.ballista)
            {
                _local_2 = (_local_2 + ((" ballista :(" + (_arg_1.ballista - this.castle.troop.ballista)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.batteringRam > this.castle.troop.batteringRam)
            {
                _local_2 = (_local_2 + ((" ram :(" + (_arg_1.batteringRam - this.castle.troop.batteringRam)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.carriage > this.castle.troop.carriage)
            {
                _local_2 = (_local_2 + ((" transport :(" + (_arg_1.carriage - this.castle.troop.carriage)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.catapult > this.castle.troop.catapult)
            {
                _local_2 = (_local_2 + ((" catapult :(" + (_arg_1.catapult - this.castle.troop.catapult)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.heavyCavalry > this.castle.troop.heavyCavalry)
            {
                _local_2 = (_local_2 + ((" cataphract :(" + (_arg_1.heavyCavalry - this.castle.troop.heavyCavalry)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.lightCavalry > this.castle.troop.lightCavalry)
            {
                _local_2 = (_local_2 + ((" cavalry :(" + (_arg_1.lightCavalry - this.castle.troop.lightCavalry)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.militia > this.castle.troop.militia)
            {
                _local_2 = (_local_2 + ((" warrior :(" + (_arg_1.militia - this.castle.troop.militia)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.peasants > this.castle.troop.peasants)
            {
                _local_2 = (_local_2 + ((" worker :(" + (_arg_1.peasants - this.castle.troop.peasants)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.pikemen > this.castle.troop.pikemen)
            {
                _local_2 = (_local_2 + ((" pike :(" + (_arg_1.pikemen - this.castle.troop.pikemen)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.scouter > this.castle.troop.scouter)
            {
                _local_2 = (_local_2 + ((" scout :(" + (_arg_1.scouter - this.castle.troop.scouter)) + ")"));
                _local_3 = false;
            };
            if (_arg_1.swordsmen > this.castle.troop.swordsmen)
            {
                _local_2 = (_local_2 + ((" sword :(" + (_arg_1.swordsmen - this.castle.troop.swordsmen)) + ")"));
                _local_3 = false;
            };
            if (((!(_local_3)) && (this.verboseLogs)))
            {
                this.logCmdResponse("TroopError", _local_2);
            };
            return (_local_3);
        }

        private function getGearTypeString(_arg_1:int):String
        {
            return ((_arg_1 == 0) ? "none" : ((_arg_1 == 1) ? "pol" : ((_arg_1 == 2) ? "atk" : ((_arg_1 == 3) ? "int" : null))));
        }

        private function waitNoResearch():void
        {
            this.waitResearch(this.onCmdFinshed, [true]);
        }

        private function handleDecWar(_arg_1:MapCastleBean):void
        {
            if (_arg_1 == null)
            {
                this.onCmdResult("Unable to obtain map info, please try again");
                this.onCmdFinshed(true);
            }
            else
            {
                if (_arg_1.canDeclaredWar)
                {
                    this.setCmdResponse(ResponseDispatcher.COMMON_DECLARED_WAR_AGAINST_PLAYER, this.handleCmdResponse);
                    this.onCmdResult(((("Declare war against " + Map.fieldIdToString(_arg_1.id)) + " ") + _arg_1.userName));
                    ActionFactory.getInstance().getCommonCommands().declaredWarAgainstPlayer(_arg_1.ownerPlayerId);
                }
                else
                {
                    this.onCmdResult(("Unable to declare war against " + Map.fieldIdToString(_arg_1.id)));
                    this.onCmdFinshed(true);
                };
            };
        }

        public function getItemInfo(_arg_1:String):ItemEum
        {
            return (Items.externalItemNames[Items.getItemId(_arg_1)]);
        }

        private function onGetResearchListResponse(_arg_1:AvailableResearchListResponse):void
        {
            var _local_2:AvailableResearchListBean;
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(("Error getting research list: " + _arg_1.errorMsg), _arg_1.ok));
                return;
            };
            for each (_local_2 in _arg_1.acailableResearchBeansArray)
            {
                this.m_techLevels[(_local_2.typeId + "")] = _local_2.avalevel;
                if (((_local_2.castleId == this.castleId) && (_local_2.upgradeing)))
                {
                    this.currentResearch = _local_2;
                };
            };
        }

        private function setCmdResponse(_arg_1:String, _arg_2:Function):void
        {
            if (Version.isTraceOn())
            {
                trace(("setCommandResponse for " + _arg_1));
            };
            this.events.addItem(new EventHandler(_arg_1, _arg_2));
            ResponseDispatcher.getInstance().addEventListener(_arg_1, _arg_2);
        }

        private function evacuateTown(_arg_1:int, _arg_2:Boolean=false):void
        {
            this.currentAction = "evacuatetown";
            if (_arg_2 == "true")
            {
                this.onCmdResult("Evacuate troops only, resource must be moved manually");
                this.cityManager._ov14(_arg_1, true);
            }
            else
            {
                this.cityManager._ov14(_arg_1, false);
            };
            this.onCmdFinshed(true);
        }

        public function _getScriptCmds():Object
        {
            if (this.scriptCmds == null)
            {
                this.setScriptCmds();
            };
            return (this.scriptCmds);
        }

        private function wallDefense2(_arg_1:String="trap", _arg_2:int=1, _arg_3:String="build"):void
        {
            this.currentAction = "walldefense";
            var _local_4:String = _arg_1.substr(0, 3).toLowerCase();
            var _local_5:String = _arg_3.substr(0, 2).toLowerCase();
            var _local_6:int;
            if (((_local_4 == "tra") || (_local_4 == "trap")))
            {
                _local_6 = TFConstants.F_TRAP;
            }
            else
            {
                if (((_local_4 == "ab") || (_local_4 == "aba")))
                {
                    _local_6 = TFConstants.F_ABATIS;
                }
                else
                {
                    if ((((_local_4 == "at") || (_local_4 == "arc")) || (_local_4 == "tow")))
                    {
                        _local_6 = TFConstants.F_ARROWTOWER;
                    }
                    else
                    {
                        if ((((_local_4 == "r") || (_local_4 == "rol")) || (_local_4 == "log")))
                        {
                            _local_6 = TFConstants.F_ROLLINGLOGS;
                        }
                        else
                        {
                            if (((_local_4 == "tre") || (_local_4 == "roc")))
                            {
                                _local_6 = TFConstants.F_ROCKFALL;
                            }
                            else
                            {
                                throw (new ScriptError("You failed to specify a valid fortification name.", -9999));
                            };
                        };
                    };
                };
            };
            if (((_local_5 == "bu") || (_local_5 == "pr")))
            {
                this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT, this.handleCmdResponse);
                while (((_arg_2 > 0) && ((!(this.cityManager._isEnoughSlotsOnWall(_arg_2, _local_6))) || (!(this.cityManager._isEnoughResoToProduceFort(_local_6, _arg_2))))))
                {
                    _arg_2 = int((_arg_2 / 1.01));
                };
                if (_arg_2 == 0)
                {
                    this.onCmdResult((("No fortifications of type " + _local_4) + " can be queued at this time."));
                    this.onCmdFinshed(true);
                    return;
                };
                this.onCmdResult((((("Queued " + _arg_2) + " fortifications of type: ") + _local_4) + "."));
                CityStateCommands.produceWallProtect(this.castleId, _local_6, _arg_2);
                Utils.callLater(2000, this.cityManager.updateWallQueue);
                return;
            };
            if (_local_5 == "de")
            {
                this.setCmdResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT, this.handleCmdResponse);
                if (((!(this.cityManager.fortification == null)) && (_arg_2 > this.cityManager.fortification[Utils.troopIntNames[_local_6]])))
                {
                    _arg_2 = this.cityManager.fortification[Utils.troopIntNames[_local_6]];
                };
                this.onCmdResult((((("Destroyed " + _arg_2) + " fortifications of type: ") + _local_4) + "."));
                CityStateCommands.destructWallProtect(this.castleId, _local_6, _arg_2);
                return;
            };
            throw (new ScriptError("You failed to specify a valid constructType. Valid options are 'build/produce, demo/destruct'.", -9999));
        }

        private function gatePolicy(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int=0):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "gatepolicy";
            this.cityManager._setGatePolicy(((((((((_arg_1 + " ") + _arg_2) + " ") + _arg_3) + " ") + _arg_4) + " ") + _arg_5));
            this.onCmdFinshed(true);
        }

        private function bigScout(_arg_1:int, _arg_2:String, _arg_3:TroopBean, _arg_4:String=""):void
        {
            this.currentAction = "bigscout";
            this.doMarch(ObjConstants.ARMY_MISSION_SCOUT, _arg_1, _arg_2, _arg_3, null, _arg_4, true);
        }

        public function AnyIdleHero(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:String=null, _arg_7:String=null, _arg_8:String=null, _arg_9:String=null, _arg_10:String=null):Boolean
        {
            if (_arg_2 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_2));
            };
            if (_arg_3 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_3));
            };
            if (_arg_4 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_4));
            };
            if (_arg_5 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_5));
            };
            if (_arg_6 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_6));
            };
            if (_arg_7 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_7));
            };
            if (_arg_8 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_8));
            };
            if (_arg_9 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_9));
            };
            if (_arg_10 != null)
            {
                _arg_1 = (_arg_1 + ("," + _arg_10));
            };
            return (!(this.getHeroByNameOrKey(_arg_1) == null));
        }

        public function getDateFromTime(time:Number):Date
        {
            var d:Date;
            d = new Date(time);
            d["toFormattedTimeString"] = function (_arg_1:Boolean=false):String
            {
                return (((((((d.hours < 10) ? ("0" + d.hours) : d.hours) + ":") + ((d.minutes < 10) ? ("0" + d.minutes) : d.minutes)) + ":") + ((d.seconds < 10) ? ("0" + d.seconds) : d.seconds)) + ((_arg_1) ? ("." + d.milliseconds) : ""));
            };
            return (d);
        }

        private function demo(_arg_1:String="*", _arg_2:String="HighestLevel"):void
        {
            if (Version.isTraceOn())
            {
                trace("demo - verify buildings");
            };
            if (this.cityManager._getCurrentConstruction() == null)
            {
                this.demo2(_arg_1, _arg_2);
                return;
            };
            this.onCmdResult("Waiting for current building to complete...");
            this.waitForBuildingQueue(this.demo2, [_arg_1, _arg_2]);
        }

        private function cancelBuildCity():void
        {
            this.currentAction = "cancelbuildcity";
            this.cityManager._nk320();
            this.onCmdFinshed(true);
        }

        private function setScriptCmds():void
        {
            this.scriptCmds = new Object();
            this.scriptCmds["calibrate"] = new ScriptCmd("calibrate", this.calibrate, new Array(), new Array(), 0);
            this.scriptCmds["travelinfo"] = new ScriptCmd("travelinfo", this.travelInfo, new Array("target", "troop", "hero"), new Array("Coordinate", "Troop", "String"), 2);
            this.scriptCmds["attack"] = new ScriptCmd("attack", this.attack, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["aattack"] = new ScriptCmd("aattack", this.aAttack, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["bigattack"] = new ScriptCmd("bigattack", this.bigAttack, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["abigattack"] = new ScriptCmd("abigattack", this.aBigAttack, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["colonize"] = new ScriptCmd("colonize", this.colonize, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["acolonize"] = new ScriptCmd("acolonize", this.aColonize, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["bigcolonize"] = new ScriptCmd("bigcolonize", this.bigColonize, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["abigcolonize"] = new ScriptCmd("abigcolonize", this.aBigColonize, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["scout"] = new ScriptCmd("scout", this.scout, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["ascout"] = new ScriptCmd("ascout", this.aScout, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["bigscout"] = new ScriptCmd("bigscout", this.bigScout, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["abigscout"] = new ScriptCmd("abigscout", this.aBigScout, new Array("target", "hero", "troop", "campTime"), new Array("Coordinate", "String", "Troop", "String"), 3);
            this.scriptCmds["transport"] = new ScriptCmd("transport", this.transport, new Array("target", "troop", "resource", "campTime"), new Array("Coordinate", "Troop", "Resource", "String"), 3);
            this.scriptCmds["bigtransport"] = new ScriptCmd("bigtransport", this.bigTransport, new Array("target", "troop", "resource", "campTime"), new Array("Coordinate", "Troop", "Resource", "String"), 3);
            this.scriptCmds["reinforce"] = new ScriptCmd("reinforce", this.reinforce, new Array("target", "hero", "troop", "resource", "campTime"), new Array("Coordinate", "String", "Troop", "Resource", "String"), 3);
            this.scriptCmds["bigreinforce"] = new ScriptCmd("bigreinforce", this.bigReinforce, new Array("target", "hero", "troop", "resource", "campTime"), new Array("Coordinate", "String", "Troop", "Resource", "String"), 3);
            this.scriptCmds["deploy"] = new ScriptCmd("deploy", this.deploy, new Array("deployType", "target", "hero", "troop", "resource", "campTime", "useEnsign", "useHordeBanner", "autoGearType"), new Array("String", "Coordinate", "String", "Troop", "Resource", "String", "Boolean", "Boolean", "int"), 4);
            this.scriptCmds["qdeploy"] = new ScriptCmd("qdeploy", this._qDeploy, new Array("deployType", "target", "hero", "troop", "resource", "campTime", "useEnsign", "useHordeBanner", "autoGearType"), new Array("String", "Coordinate", "String", "Troop", "Resource", "String", "Boolean", "Boolean", "int"), 4);
            this.scriptCmds["qfarm"] = new ScriptCmd("qfarm", this.qFarm, new Array(), new Array(), 0);
            this.scriptCmds["qbuildnpc"] = new ScriptCmd("qbuildnpc", this.qBuildNpc, new Array(), new Array(), 0);
            this.scriptCmds["qall"] = new ScriptCmd("qall", this.qAll, new Array(), new Array(), 0);
            this.scriptCmds["listmedals"] = new ScriptCmd("listmedals", this.listMedals, new Array(), new Array(), 0);
            this.scriptCmds["listbuffs"] = new ScriptCmd("listbuffs", this.listBuffs, new Array(), new Array(), 0);
            this.scriptCmds["listlocalbuffs"] = new ScriptCmd("listlocalbuffs", this.listLocalBuffs, new Array(), new Array(), 0);
            this.scriptCmds["listitems"] = new ScriptCmd("listitems", this.listItems, new Array("filter"), new Array("String"), 0);
            this.scriptCmds["cancelbuild"] = new ScriptCmd("cancelbuild", this.cancelBuild, new Array("position"), new Array("int"), 0);
            this.scriptCmds["canceltech"] = new ScriptCmd("canceltech", this.cancelTech, new Array(), new Array(), 0);
            this.scriptCmds["dumpresource"] = new ScriptCmd("dumpresource", this.dumpResource, new Array("target", "condition", "resource"), new Array("Coordinate", "Resource", "Resource"), 3);
            this.scriptCmds["dumptroop"] = new ScriptCmd("dumptroop", this.dumpTroop, new Array("target", "condition", "troop"), new Array("Coordinate", "Troop", "Troop"), 3);
            this.scriptCmds["buildcity"] = new ScriptCmd("buildcity", this.buildCity, new Array("location"), new Array("Coordinate"), 1);
            this.scriptCmds["cancelbuildcity"] = new ScriptCmd("cancelbuildcity", this.cancelBuildCity, new Array(), new Array(), 0);
            this.scriptCmds["capture"] = new ScriptCmd("capture", this.capture, new Array("location", "numCav"), new Array("Coordinate", "int"), 2);
            this.scriptCmds["loyaltyattack"] = new ScriptCmd("loyaltyattack", this.loyaltyAttack, new Array("location", "numCav"), new Array("Coordinate", "int"), 2);
            this.scriptCmds["healtroops"] = new ScriptCmd("healtroops", this.healTroops, new Array(), new Array(), 0);
            this.scriptCmds["healtroops!"] = new ScriptCmd("healtroops!", this.healTroops2, new Array(), new Array(), 0);
            this.scriptCmds["healtroops2"] = new ScriptCmd("healtroops2", this.healTroops2, new Array(), new Array(), 0);
            this.scriptCmds["evacuatetown"] = new ScriptCmd("evacuatetown", this.evacuateTown, new Array("target", "troopOnlyFlag"), new Array("Coordinate", "Boolean"), 1);
            this.scriptCmds["endevacuate"] = new ScriptCmd("endevacuate", this.endEvacuate, new Array(), new Array(), 0);
            this.scriptCmds["abandontown"] = new ScriptCmd("abandontown", this.abandonTown, new Array(), new Array(), 0);
            this.scriptCmds["abandontown!"] = new ScriptCmd("abandontown!", this.abandonTown2, new Array(), new Array(), 0);
            this.scriptCmds["fieldattack"] = new ScriptCmd("fieldattack", this.fieldAttack, new Array("allianceList", "center", "radius", "minLevel"), new Array("String", "Coordinate", "Number", "int"), 3);
            this.scriptCmds["findplayervalleys"] = new ScriptCmd("findplayervalleys", this.findPlayerValleys, new Array("playerList", "center", "radius", "minLevel"), new Array("String", "Coordinate", "Number", "int"), 3);
            this.scriptCmds["attackplayervalleys"] = new ScriptCmd("attackplayervalleys", this.attackPlayerValleys, new Array("playerList", "center", "radius", "minLevel"), new Array("String", "Coordinate", "Number", "int"), 3);
            this.scriptCmds["setnpcflag"] = new ScriptCmd("setnpcflag", this.setNpcFlag, new Array("location"), new Array("Coordinate"), 1);
            this.scriptCmds["unsetnpcflag"] = new ScriptCmd("unsetnpcflag", this.unsetNpcFlag, new Array("location"), new Array("Coordinate"), 1);
            this.scriptCmds["spamattack"] = new ScriptCmd("spamattack", this.spamAttack, new Array("location", "troop", "count"), new Array("Coordinate", "Troop", "int"), 3);
            this.scriptCmds["honorattack"] = new ScriptCmd("honorattack", this.honorAttack, new Array("location", "troop", "maxHonorLost"), new Array("Coordinate", "Troop", "int"), 3);
            this.scriptCmds["honorguard"] = new ScriptCmd("honorguard", this.honorGuard, new Array("location", "troop", "maxHonorLost"), new Array("Coordinate", "Troop", "int"), 3);
            this.scriptCmds["attackwait"] = new ScriptCmd("attackwait", this.attackWait, new Array("waitType"), new Array("String"), 1);
            this.scriptCmds["endfieldattack"] = new ScriptCmd("endfieldattack", this.endFieldAttack, new Array(), new Array(), 0);
            this.scriptCmds["endspamattack"] = new ScriptCmd("endspamattack", this.endSpamAttack, new Array(), new Array(), 0);
            this.scriptCmds["endloyaltyattack"] = new ScriptCmd("endloyaltyattack", this.endLoyaltyAttack, new Array(), new Array(), 0);
            this.scriptCmds["endhonorattack"] = new ScriptCmd("endhonorattack", this.endHonorAttack, new Array(), new Array(), 0);
            this.scriptCmds["endguardedattack"] = new ScriptCmd("endguardedattack", this.endGuardedAttack, new Array(), new Array(), 0);
            this.scriptCmds["guardedattack"] = new ScriptCmd("guardedattack", this.guardedAttack, new Array("location", "troop", "nScouts", "defenseCond", "fortCond"), new Array("Coordinate", "Troop", "int", "Troop", "Fortification"), 4);
            this.scriptCmds["setguard"] = new ScriptCmd("setguard", this.setGuard, new Array("location", "defenseCond", "fortCond"), new Array("Coordinate", "Troop", "Fortification"), 2);
            this.scriptCmds["recall"] = new ScriptCmd("recall", this.recall, new Array("target"), new Array("Coordinate"), 1);
            this.scriptCmds["recallall"] = new ScriptCmd("recallall", this.recallAll, new Array(), new Array(), 0);
            this.scriptCmds["herorecall"] = new ScriptCmd("herorecall", this.heroRecall, new Array("heroName"), new Array("String"), 1);
            this.scriptCmds["idrecall"] = new ScriptCmd("idrecall", this.idRecall, new Array("armyId"), new Array("int"), 1);
            this.scriptCmds["cleartroopqueues"] = new ScriptCmd("cleartroopqueues", this.clearTroopQueues, new Array("remainBatchCount"), new Array("int"), 0);
            this.scriptCmds["clearqueuetype"] = new ScriptCmd("clearqueuetype", this.clearQueueType, new Array("troopName"), new Array("String"), 1);
            this.scriptCmds["clearwallqueue"] = new ScriptCmd("clearwallqueue", this.clearWallQueue, new Array("remainBatchCount"), new Array("int"), 0);
            this.scriptCmds["persuadehero"] = new ScriptCmd("persuadehero", this.persuadeHero, new Array("hero"), new Array("String"), 1);
            this.scriptCmds["firehero"] = new ScriptCmd("firehero", this.fireHero, new Array("hero"), new Array("String"), 1);
            this.scriptCmds["releasehero"] = new ScriptCmd("releasehero", this.releaseHero, new Array("baseStat", "level"), new Array("int", "int"), 0);
            this.scriptCmds["changeheroname"] = new ScriptCmd("changeheroname", this.changeHeroName, new Array("oldName", "newName"), new Array("String", "String"), 0);
            this.scriptCmds["awardgold"] = new ScriptCmd("awardgold", this.awardGold, new Array("hero"), new Array("String"), 1);
            this.scriptCmds["uplevelhero"] = new ScriptCmd("uplevelhero", this.upLevelHero, new Array("hero"), new Array("String"), 1);
            this.scriptCmds["addpointhero"] = new ScriptCmd("addpointhero", this.addPointHero, new Array("hero", "pol", "atk", "int"), new Array("String", "int", "int", "int"), 4);
            this.scriptCmds["resetherostatsbyname"] = new ScriptCmd("resetherostatsbyname", this.resetHeroStatsByName, new Array("heroName"), new Array("String"), 1);
            this.scriptCmds["resetherostatsbyid"] = new ScriptCmd("resetherostatsbyid", this.resetHeroStatsById, new Array("heroId"), new Array("int"), 1);
            this.scriptCmds["changeherogear"] = new ScriptCmd("changeherogear", this.changeHeroGear, new Array("hero", "geartype"), new Array("String", "String"), 2);
            this.scriptCmds["changeherogears"] = new ScriptCmd("changeherogears", this.changeHeroGears, new Array("hero", "gear:type,gear:type,..."), new Array("String", "String"), 2);
            this.scriptCmds["resetmapdata"] = new ScriptCmd("resetmapdata", this.resetMapData, new Array(), new Array(), 0);
            this.scriptCmds["scanmap"] = new ScriptCmd("scanmap", this.scanMap, new Array("center", "radius"), new Array("Coordinate", "Number"), 2);
            this.scriptCmds["rescanmap"] = new ScriptCmd("rescanmap", this.rescanMap, new Array("center", "radius"), new Array("Coordinate", "Number"), 2);
            this.scriptCmds["scandetail"] = new ScriptCmd("scandetail", this.scanDetail, new Array("center", "radius"), new Array("Coordinate", "Number"), 2);
            this.scriptCmds["scanrec"] = new ScriptCmd("scanrec", this.scanRec, new Array("corner1", "corner2", "enableFastScan"), new Array("Coordinate", "Coordinate", "Boolean"), 2);
            this.scriptCmds["rescanrec"] = new ScriptCmd("rescanrec", this.rescanRec, new Array("corner1", "corner2", "enableFastScan"), new Array("Coordinate", "Coordinate", "Boolean"), 2);
            this.scriptCmds["quickscanmap"] = new ScriptCmd("quickscanmap", this.quickScanMap, new Array("State", "speedFactor"), new Array("String", "int"), 0);
            this.scriptCmds["monitorprestige"] = new ScriptCmd("monitorprestige", this.monitorPrestige, new Array("nick", "populationFlag", "count"), new Array("String", "Boolean", "int"), 1);
            this.scriptCmds["waitresource"] = new ScriptCmd("waitresource", this.waitResource, new Array("resource"), new Array("Resource"), 1);
            this.scriptCmds["waithero"] = new ScriptCmd("waithero", this.waitHero, new Array("hero"), new Array("String"), 1);
            this.scriptCmds["waitherolost"] = new ScriptCmd("waitherolost", this.waitHeroLost, new Array("heroList"), new Array("String"), 1);
            this.scriptCmds["waitenemy"] = new ScriptCmd("waitenemy", this.waitEnemy, new Array("ignoreJunk"), new Array("Boolean"), 0);
            this.scriptCmds["waitnoenemy"] = new ScriptCmd("waitnoenemy", this.waitNoEnemy, new Array("ignoreJunk"), new Array("Boolean"), 0);
            this.scriptCmds["teleport"] = new ScriptCmd("teleport", this.teleport, new Array("state", "stateWord2"), new Array("String", "String"), 1);
            this.scriptCmds["advteleport"] = new ScriptCmd("advteleport", this.advTeleport, new Array("coord"), new Array("Coordinate"), 1);
            this.scriptCmds["warteleport"] = new ScriptCmd("warteleport", this.warTeleport, new Array("coord"), new Array("Coordinate"), 1);
            this.scriptCmds["pioteleport"] = new ScriptCmd("pioteleport", this.pioTeleport, new Array("coord"), new Array("Coordinate"), 1);
            this.scriptCmds["useitem"] = new ScriptCmd("useitem", this.useItem, new Array("item"), new Array("String"), 1);
            this.scriptCmds["usecastleitem"] = new ScriptCmd("usecastleitem", this.useCastleItem, new Array("item"), new Array("String"), 1);
            this.scriptCmds["buyitem"] = new ScriptCmd("buyitem", this.buyItem, new Array("item", "count"), new Array("String", "int"), 1);
            this.scriptCmds["useheroitem"] = new ScriptCmd("useheroitem", this.useHeroItem, new Array("hero", "item"), new Array("String", "String"), 2);
            this.scriptCmds["usebuilditem"] = new ScriptCmd("usebuilditem", this.useBuildItem, new Array("item", "positionId"), new Array("String", "int"), 1);
            this.scriptCmds["usetechitem"] = new ScriptCmd("usetechitem", this.useTechItem, new Array("item"), new Array("String"), 1);
            this.scriptCmds["usetradeitem"] = new ScriptCmd("usetradeitem", this.useTradeItem, new Array("item", "tradeId"), new Array("String", "int"), 1);
            this.scriptCmds["usestratitem"] = new ScriptCmd("usestratitem", this.useStratItem, new Array("target", "item"), new Array("Coordinate", "String"), 2);
            this.scriptCmds["useangelitem"] = new ScriptCmd("useangelitem", this.useAngelItem, new Array("nick", "item"), new Array("String", "String"), 2);
            this.scriptCmds["usedevilitem"] = new ScriptCmd("usedevilitem", this.useDevilItem, new Array("target", "item", "option"), new Array("Coordinate", "String", "String"), 2);
            this.scriptCmds["usearmyitem"] = new ScriptCmd("usearmyitem", this.useArmyItem, new Array("armyId", "item"), new Array("int", "String"), 2);
            this.scriptCmds["usecolonyitem"] = new ScriptCmd("usecolonyitem", this.useColonyItem, new Array("colonyCoord", "item"), new Array("Coordinate", "String"), 2);
            this.scriptCmds["getspamhero"] = new ScriptCmd("getspamhero", this.getSpamHero, new Array("heroType"), new Array("String"), 0);
            this.scriptCmds["completequests"] = new ScriptCmd("completequests", this.completeQuests, new Array("questType"), new Array("String"), 0);
            this.scriptCmds["donatequest"] = new ScriptCmd("donatequest", this.donateQuest, new Array("questId"), new Array("int"), 0);
            this.scriptCmds["cleanreports"] = new ScriptCmd("cleanreports", this.cleanReports, new Array("key", "startPage"), new Array("String", "int"), 0);
            this.scriptCmds["cleannpcreports"] = new ScriptCmd("cleannpcreports", this.cleanNpcReports, new Array("startPage"), new Array("int"), 0);
            this.scriptCmds["comfort"] = new ScriptCmd("comfort", this.comfort, new Array("comfortType"), new Array("String"), 1);
            this.scriptCmds["levy"] = new ScriptCmd("levy", this.levy, new Array("levyType"), new Array("String"), 1);
            this.scriptCmds["settaxrate"] = new ScriptCmd("settaxrate", this.setTaxRate, new Array("taxRate"), new Array("int"), 1);
            this.scriptCmds["create"] = new ScriptCmd("create", this.create, new Array("buildingType", "positionPolicy", "useHammer"), new Array("String", "String", "Boolean"), 1);
            this.scriptCmds["create!"] = new ScriptCmd("create!", this.create2, new Array("buildingType", "positionPolicy", "useHammer"), new Array("String", "String", "Boolean"), 1);
            this.scriptCmds["upgrade"] = new ScriptCmd("upgrade", this.upgrade, new Array("buildingType", "buildPolicy", "useHammer"), new Array("String", "String", "Boolean"), 0);
            this.scriptCmds["upgrade!"] = new ScriptCmd("upgrade!", this.upgrade2, new Array("buildingType", "buildPolicy", "useHammer"), new Array("String", "String", "Boolean"), 0);
            this.scriptCmds["demo"] = new ScriptCmd("demo", this.demo, new Array("buildingType", "buildPolicy"), new Array("String", "String"), 1);
            this.scriptCmds["demo!"] = new ScriptCmd("demo!", this.demo2, new Array("buildingType", "buildPolicy"), new Array("String", "String"), 1);
            this.scriptCmds["waitnobuilding"] = new ScriptCmd("waitnobuilding", this.waitNoBuilding, new Array(), new Array(), 0);
            this.scriptCmds["research"] = new ScriptCmd("research", this.research, new Array("techType"), new Array("String"), 1);
            this.scriptCmds["gear"] = new ScriptCmd("gear", this.gear, new Array("gearType"), new Array("String"), 1);
            this.scriptCmds["star"] = new ScriptCmd("star", this.star, new Array("gearType", "gemType", "count"), new Array("String", "String", "int"), 3);
            this.scriptCmds["autostar"] = new ScriptCmd("autostar", this.autoStar, new Array("gearType", "targetLevel", "spec1", "spec2", "spec3", "spec4", "spec5", "spec6", "spec7", "spec8"), new Array("String", "String", "String", "String", "String", "String", "String", "String", "String", "String"), 3);
            this.scriptCmds["safestar"] = new ScriptCmd("safestar", this.safeStar, new Array("gearType", "targetLevel", "safetyFactor"), new Array("String", "String", "Number"), 2);
            this.scriptCmds["waitnoresearch"] = new ScriptCmd("waitnoresearch", this.waitNoResearch, new Array(), new Array(), 0);
            this.scriptCmds["waitturn"] = new ScriptCmd("waitturn", this.waitTurn, new Array(), new Array(), 0);
            this.scriptCmds["findfield"] = new ScriptCmd("findfield", this.findField, new Array("valleyType", "level", "radius", "hero", "troop", "centerCoord"), new Array("String", "int", "Number", "String", "Troop", "Coordinate"), 3);
            this.scriptCmds["buy"] = new ScriptCmd("buy", this.buy, new Array("resourceType", "amount", "price"), new Array("String", "Number", "Number"), 3);
            this.scriptCmds["sell"] = new ScriptCmd("sell", this.sell, new Array("resourceType", "amount", "price"), new Array("String", "Number", "Number"), 3);
            this.scriptCmds["buyto"] = new ScriptCmd("buyto", this.buyTo, new Array("resourceType", "limit", "price", "goldReserved"), new Array("String", "Number", "Number", "Number"), 3);
            this.scriptCmds["sellto"] = new ScriptCmd("sellto", this.sellTo, new Array("resourceType", "limit", "price", "goldReserved"), new Array("String", "Number", "Number", "Number"), 3);
            this.scriptCmds["canceltrade"] = new ScriptCmd("canceltrade", this.cancelTrade, new Array("tradeId"), new Array("int"), 0);
            this.scriptCmds["setgate"] = new ScriptCmd("setgate", this.setGate, new Array("status"), new Array("Boolean"), 1);
            this.scriptCmds["setfocus"] = new ScriptCmd("setfocus", this.setFocus, new Array(), new Array(), 0);
            this.scriptCmds["changecastlename"] = new ScriptCmd("changecastlename", this.changeCastleName, new Array("newName"), new Array("String"), 1);
            this.scriptCmds["changeflag"] = new ScriptCmd("changeflag", this.changeFlag, new Array("newFlag"), new Array("String"), 1);
            this.scriptCmds["hiderainbow"] = new ScriptCmd("hiderainbow", this.hideRainbow, new Array(), new Array(), 0);
            this.scriptCmds["excercise"] = new ScriptCmd("excercise", this.excercise, new Array("attackers", "defenders"), new Array("Troop", "Troop"), 2);
            this.scriptCmds["production"] = new ScriptCmd("production", this.production, new Array("food", "lumber", "stone", "iron"), new Array("int", "int", "int", "int"), 0);
            this.scriptCmds["setmayor"] = new ScriptCmd("setmayor", this.setMayor, new Array("mayorType"), new Array("String"), 0);
            this.scriptCmds["setmayorbyname"] = new ScriptCmd("setmayorbyname", this.setMayorByName, new Array("hero"), new Array("String"), 1);
            this.scriptCmds["train"] = new ScriptCmd("train", this.train, new Array("troop", "hero", "barrackList", "minAmount"), new Array("Troop", "String", "String", "int"), 1);
            this.scriptCmds["train!"] = new ScriptCmd("train!", this.train2, new Array("troop", "hero", "barrackList", "minAmount"), new Array("Troop", "String", "String", "int"), 1);
            this.scriptCmds["trainto"] = new ScriptCmd("trainto", this.trainTo, new Array("troop", "hero", "barrackList", "minAmount"), new Array("Troop", "String", "String", "int"), 1);
            this.scriptCmds["untrain"] = new ScriptCmd("untrain", this.untrain, new Array("troop"), new Array("Troop"), 1);
            this.scriptCmds["abandon"] = new ScriptCmd("abandon", this.abandon, new Array("location"), new Array("Coordinate"), 1);
            this.scriptCmds["verbose"] = new ScriptCmd("verbose", this.verbose, new Array("verboseSetting"), new Array("String"), 1);
            this.scriptCmds["walldefense"] = new ScriptCmd("walldefense", this.wallDefense, new Array("fortType", "number", "buildType"), new Array("String", "int", "String"), 2);
            this.scriptCmds["walldefenseto"] = new ScriptCmd("walldefenseto", this.wallDefenseTo, new Array("fortGoal"), new Array("Fortification"), 1);
            this.scriptCmds["walldefense!"] = new ScriptCmd("walldefense!", this.wallDefense2, new Array("fortType", "number", "buildType"), new Array("String", "int", "String"), 2);
            this.scriptCmds["declarewar"] = new ScriptCmd("declarewar", this._declareWar, new Array("target"), new Array("Coordinate"), 1);
            this.scriptCmds["uprise"] = new ScriptCmd("uprise", this.uprise, new Array(), new Array(), 0);
            this.scriptCmds["colony"] = new ScriptCmd("colony", this.colony, new Array("operation", "target", "troop"), new Array("String", "Coordinate", "Troop"), 2);
            this.scriptCmds["capitalpolicy"] = new ScriptCmd("capitalpolicy", this.capitalPolicy, new Array("operation", "target"), new Array("String", "Coordinate"), 2);
            this.scriptCmds["vote"] = new ScriptCmd("vote", this.vote, new Array("name1", "name2", "name3", "name4", "name5"), new Array("String", "String", "String", "String", "String"), 1);
            this.scriptCmds["autoheal"] = new ScriptCmd("autoheal", this.autoHeal, new Array("setAutoHeal"), new Array("Boolean"), 1);
            this.scriptCmds["killwall"] = new ScriptCmd("killwall", this.killWall, new Array(), new Array(), 0);
            this.scriptCmds["waitsuzerain"] = new ScriptCmd("waitsuzerain", this.waitSuzerain, new Array(), new Array(), 0);
            this.scriptCmds["chatac"] = new ScriptCmd("chatac", this.chatAc, new Array("chatText"), new Array("String"), 1);
            this.scriptCmds["chatwc"] = new ScriptCmd("chatwc", this.chatWc, new Array("chatText"), new Array("String"), 1);
            this.scriptCmds["chatpc"] = new ScriptCmd("chatpc", this.chatPc, new Array("nick", "chatText"), new Array("String", "String"), 2);
            this.scriptCmds["chatbc"] = new ScriptCmd("chatbc", this.chatBc, new Array("chatText"), new Array("String"), 1);
            this.scriptCmds["fmth"] = new ScriptCmd("fmth", this.fmth, new Array(), new Array(), 0);
            this.scriptCmds["fmthGLB"] = new ScriptCmd("fmthGLB", this.fmthGLB, new Array(), new Array(), 0);
            this.scriptCmds["blockplayer"] = new ScriptCmd("blockplayer", this.blockPlayer, new Array("playerName"), new Array("String"), 1);
            this.scriptCmds["unblockplayer"] = new ScriptCmd("unblockplayer", this.unBlockPlayer, new Array("playerName"), new Array("String"), 1);
            this.scriptCmds["friendplayer"] = new ScriptCmd("friendplayer", this.friendPlayer, new Array("playerName"), new Array("String"), 1);
            this.scriptCmds["unfriendplayer"] = new ScriptCmd("unfriendplayer", this.unFriendPlayer, new Array("playerName"), new Array("String"), 1);
            this.scriptCmds["listpackages"] = new ScriptCmd("listpackages", this.listPackages, new Array(), new Array(), 0);
            this.scriptCmds["claimpackage"] = new ScriptCmd("claimpackage", this.claimPackage, new Array("packageId"), new Array("int"), 1);
            this.scriptCmds["changeplayernick"] = new ScriptCmd("changeplayernick", this.changePlayerNick, new Array("nick1", "nick2", "nick3", "nick4", "nick5"), new Array("String", "String", "String", "String", "String"), 1);
            this.scriptCmds["refresh"] = new ScriptCmd("refresh", this.refresh, new Array(), new Array(), 0);
            this.scriptCmds["logintoskype"] = new ScriptCmd("logintoskype", this.loginToSkype, new Array("skypeId/email", "password"), new Array("String", "String"), 2);
            this.scriptCmds["skypepm"] = new ScriptCmd("skypepm", this.skypePm, new Array("skypeUserId", "message"), new Array("String", "String"), 2);
            this.scriptCmds["skypegm"] = new ScriptCmd("skypegm", this.skypeGm, new Array("Group name(or partial name)", "message"), new Array("String", "String"), 2);
            this.scriptCmds["config"] = new ScriptCmd("config", this.config, new Array("configString"), new Array("String"), 1);
            this.scriptCmds["rallymax"] = new ScriptCmd("rallymax", this.rallyMax, new Array("configString"), new Array("String"), 1);
            this.scriptCmds["skypewarningpolicy"] = new ScriptCmd("skypewarningpolicy", this.skypeWarningPolicy, new Array("normal", "junk", "valley", "colony"), new Array("int", "int", "int", "int"), 1);
            this.scriptCmds["skypewarningreceivers"] = new ScriptCmd("skypewarningreceivers", this.skypeWarningReceivers, new Array("receiversList"), new Array("String"), 1);
            this.scriptCmds["skypewarreportreceivers"] = new ScriptCmd("skypewarreportreceivers", this.skypeWarReportReceivers, new Array("receiversList"), new Array("String"), 1);
            this.scriptCmds["warreportignorelist"] = new ScriptCmd("warreportignorelist", this.warReportIgnoreList, new Array("ignorList"), new Array("String"), 1);
            this.scriptCmds["enemywarningignorelist"] = new ScriptCmd("enemywarningignorelist", this.enemyWarningIgnoreList, new Array("ignorList"), new Array("String"), 1);
            this.scriptCmds["gatepolicy"] = new ScriptCmd("gatepolicy", this.gatePolicy, new Array("peace", "attack", "scoutbomb", "mix", "pause"), new Array("int", "int", "int", "int", "int"), 4);
            this.scriptCmds["resourcelimits"] = new ScriptCmd("resourcelimits", this.resourceLimits, new Array("food", "lumber", "stone", "iron"), new Array("String", "String", "String", "String"), 4);
            this.scriptCmds["distancepolicy"] = new ScriptCmd("distancepolicy", this.distancePolicy, new Array("farmnpc", "buildnpc", "medalhunting", "resourcevalley", "buildnpc10"), new Array("int", "int", "int", "int", "int"), 5);
            this.scriptCmds["valleytroops"] = new ScriptCmd("valleytroops", this.valleyTroops, new Array("troop"), new Array("Troop"), 1);
            this.scriptCmds["valleytroop"] = new ScriptCmd("valleytroop", this.valleyTroops, new Array("troop"), new Array("Troop"), 1);
            this.scriptCmds["huntingpos"] = new ScriptCmd("huntingpos", this.huntingPos, new Array("troop"), new Array("Coordinate"), 1);
            this.scriptCmds["huntingtype"] = new ScriptCmd("huntingtype", this.huntingType, new Array("valleyType"), new Array("String"), 1);
            this.scriptCmds["setballsused"] = new ScriptCmd("setballsused", this.setBallsUsed, new Array("setting"), new Array("String"), 1);
            this.scriptCmds["ballsused"] = new ScriptCmd("ballsused", this.setBallsUsed, new Array("setting"), new Array("String"), 1);
            this.scriptCmds["npctroop"] = new ScriptCmd("npctroop", this.npcTroop, new Array("troop"), new Array("Troop"), 1);
            this.scriptCmds["npctroops"] = new ScriptCmd("npctroops", this.npcTroop, new Array("troop"), new Array("Troop"), 1);
            this.scriptCmds["valleyheroes"] = new ScriptCmd("valleyheroes", this.valleyHeroes, new Array("heroList"), new Array("String"), 1);
            this.scriptCmds["npcheroes"] = new ScriptCmd("npcheroes", this.npcHeroes, new Array("heroList"), new Array("String"), 1);
            this.scriptCmds["npc10limit"] = new ScriptCmd("npc10limit", this.npc10Limit, new Array("troop"), new Array("Troop"), 1);
            this.scriptCmds["npc10troop"] = new ScriptCmd("npc10troop", this.npc10Troop, new Array("troop"), new Array("String"), 1);
            this.scriptCmds["npc10troops"] = new ScriptCmd("npc10troops", this.npc10Troop, new Array("troop"), new Array("Troop"), 1);
            this.scriptCmds["npc10heroes"] = new ScriptCmd("npc10heroes", this.npc10Heroes, new Array("heroList"), new Array("String"), 1);
            this.scriptCmds["spamheroes"] = new ScriptCmd("spamheroes", this.spamHeroes, new Array("heroList"), new Array("String"), 1);
            this.scriptCmds["notspamheroes"] = new ScriptCmd("notspamheroes", this.notSpamHeroes, new Array("heroList"), new Array("String"), 1);
            this.scriptCmds["keeptroop"] = new ScriptCmd("keeptroop", this.keepTroop, new Array("target", "troop", "minTroopSent"), new Array("Coordinate", "Troop", "int"), 2);
            this.scriptCmds["keepresource"] = new ScriptCmd("keepresource", this.keepResource, new Array("target", "resource", "minResourceSent"), new Array("Coordinate", "String", "Number"), 2);
            this.scriptCmds["endkeeptroop"] = new ScriptCmd("endkeeptroop", this.endKeepTroop, new Array(), new Array(), 0);
            this.scriptCmds["endkeepresource"] = new ScriptCmd("endkeepresource", this.endKeepResource, new Array(), new Array(), 0);
            this.scriptCmds["troopgoal"] = new ScriptCmd("troopgoal", this.troopGoal, new Array("troopStr"), new Array("Troop"), 1);
            this.scriptCmds["troop"] = new ScriptCmd("troop", this.troopGoal, new Array("troopStr"), new Array("Troop"), 1);
            this.scriptCmds["fortificationgoal"] = new ScriptCmd("fortificationgoal", this.fortificationGoal, new Array("fortificationStr"), new Array("Fortification"), 1);
            this.scriptCmds["fortification"] = new ScriptCmd("fortification", this.fortificationGoal, new Array("fortificationStr"), new Array("Fortification"), 1);
            this.scriptCmds["buildinggoals"] = new ScriptCmd("buildinggoals", this.buildingGoals, new Array("buildingString"), new Array("String"), 1);
            this.scriptCmds["build"] = new ScriptCmd("build", this.buildingGoals, new Array("buildingString"), new Array("String"), 1);
            this.scriptCmds["techgoals"] = new ScriptCmd("techgoals", this.techGoals, new Array("techString"), new Array("String"), 1);
            this.scriptCmds["tech"] = new ScriptCmd("tech", this.techGoals, new Array("techString"), new Array("String"), 1);
            this.scriptCmds["setgoal"] = new ScriptCmd("setgoal", this.setGoal, new Array(), new Array(), 0);
            this.scriptCmds["setallgoals"] = new ScriptCmd("setallgoals", this.setAllGoals, new Array(), new Array(), 0);
            this.scriptCmds["resetgoals"] = new ScriptCmd("resetgoals", this.resetGoals, new Array(), new Array(), 0);
            this.scriptCmds["rereadgoals"] = new ScriptCmd("rereadgoals", this.rereadGoals, new Array(), new Array(), 0);
            this.scriptCmds["goalcommandwarning"] = new ScriptCmd("goalcommandwarning", this.goalcommandWarning, new Array("flag"), new Array("Boolean"), 1);
        }

        private function setMayorByName(_arg_1:String):void
        {
            this.currentAction = "setmayorbyname";
            this.fncSetMayorByName(_arg_1);
            this.onCmdFinshed(true);
        }

        private function fieldAttack(_arg_1:String, _arg_2:int, _arg_3:Number, _arg_4:int=8):void
        {
            this.currentAction = "fieldattack";
            this.cityManager._scrFieldAttack(_arg_1, _arg_2, _arg_3, _arg_4);
            this.onCmdFinshed(true);
        }

        private function goalcommandWarning(_arg_1:Boolean):void
        {
            this.currentAction = "goalwarning";
            goalCommandWarning = _arg_1;
            this.onCmdResult(("*** changing warning flag when using goal as command to: " + _arg_1));
            this.onCmdFinshed(true);
        }

        public function getCityFromValleyFieldId(_arg_1:int):CityState
        {
            return (MainScreen.getCityFromValleyFieldId(_arg_1));
        }

        private function attackWait(type:String="honor"):void
        {
            var handler:Function;
            var scanTimer:Timer;
            this.currentAction = "attackwait";
            this.pleaseStop = false;
            if ((((!(type == "honor")) && (!(type == "loyalty"))) && (!(type == "spam"))))
            {
                this.logCmdResponse("Invalid attackwait type, must be honor, loyalty, or spam");
                this.onCmdFinshed(true);
                return;
            };
            handler = function (_arg_1:TimerEvent):void
            {
                if (pleaseStop)
                {
                    scanTimer.stop();
                    scanTimer.removeEventListener(TimerEvent.TIMER, handler);
                    scanTimer = null;
                    onCmdFinshed(true);
                    return;
                };
                scanTimer.delay = 2000;
                if (cityManager._is281(type))
                {
                    return;
                };
                scanTimer.stop();
                scanTimer.removeEventListener(TimerEvent.TIMER, handler);
                scanTimer = null;
                onCmdFinshed(true);
            };
            scanTimer = new Timer(0);
            scanTimer.addEventListener(TimerEvent.TIMER, handler);
            scanTimer.start();
        }

        private function updateBuildingBean(_arg_1:BuildingBean):void
        {
            var _local_2:String;
            for (_local_2 in this.castle.buildingsArray)
            {
                if (this.castle.buildingsArray[_local_2].positionId == _arg_1.positionId)
                {
                    if (_arg_1.level > 0)
                    {
                        this.castle.buildingsArray[_local_2] = _arg_1;
                    }
                    else
                    {
                        this.castle.buildingsArray.removeItemAt(int(_local_2));
                    };
                    return;
                };
            };
            this.castle.buildingsArray.addItem(_arg_1);
        }

        private function setBallsUsed(_arg_1:String):void
        {
            this.printGoalCommandWarning();
            this.currentAction = "setballused";
            this.cityManager._pj342(_arg_1);
            this.onCmdFinshed(true);
        }

        public function getVar(_arg_1:String):*
        {
            return (this.script.getVar(_arg_1));
        }

        private function uprise():void
        {
            this.currentAction = "uprise";
            this.setCmdResponse(ResponseDispatcher.COLONY_UPRISE, this.handleCmdResponse);
            ActionFactory.getInstance().getColonyCommands().uprise(this.castleId);
        }

        public function get actionFactory():ActionFactory
        {
            return (ActionFactory.getInstance());
        }

        private function onDoResearchResponse(_arg_1:AvailableResearchListResponse):void
        {
            var _local_10:AvailableResearchListBean;
            var _local_11:int;
            if (this.currentAction != "research")
            {
                return;
            };
            this.currentAction = "research_step2";
            if (_arg_1.ok != 1)
            {
                this.onCmdFinshed(new ScriptError(("Error executing research: " + _arg_1.errorMsg), _arg_1.ok));
                return;
            };
            var _local_2:int = -1;
            var _local_3:Number = -1;
            var _local_4:int = -1;
            var _local_5:Number = -1;
            var _local_6:int = -1;
            var _local_7:int = -1;
            var _local_8:int = -1;
            var _local_9:int = -1;
            for each (_local_10 in _arg_1.acailableResearchBeansArray)
            {
                if (((_local_10.upgradeing) && (_local_10.castleId == this.castleId)))
                {
                    this.currentResearch = _local_10;
                };
                if (this._ip715(_local_10, _arg_1))
                {
                    if (((_local_2 == -1) || (_local_3 > _local_10.conditionBean.time)))
                    {
                        _local_2 = _local_10.typeId;
                        _local_3 = _local_10.conditionBean.time;
                    };
                    if (((_local_4 == -1) || (_local_5 < _local_10.conditionBean.time)))
                    {
                        _local_4 = _local_10.typeId;
                        _local_5 = _local_10.conditionBean.time;
                    };
                    if (((_local_6 == -1) || (_local_7 < _local_10.conditionBean.gold)))
                    {
                        _local_6 = _local_10.typeId;
                        _local_7 = _local_10.conditionBean.gold;
                    };
                    if (((_local_8 == -1) || (_local_9 > _local_10.conditionBean.gold)))
                    {
                        _local_8 = _local_10.typeId;
                        _local_9 = _local_10.conditionBean.gold;
                    };
                };
            };
            _local_11 = -1;
            switch (this.researchType)
            {
                case "quickest":
                    _local_11 = _local_2;
                    break;
                case "slowest":
                    _local_11 = _local_4;
                    break;
                case "dearest":
                    _local_11 = _local_6;
                    break;
                case "cheapest":
                    _local_11 = _local_8;
                    break;
            };
            if (_local_11 == -1)
            {
                _local_11 = TechType.fromString(this.researchType);
            };
            if (_local_11 > 0)
            {
                CityStateCommands.research(this.castleId, _local_11);
                this.cityManager.updateResearch();
            }
            else
            {
                this.onCmdFinshed(new ScriptError("Unable to perform research.", -9999));
            };
        }

        public function getCityFromColonyFieldId(_arg_1:int):CityState
        {
            return (MainScreen.getCityFromColonyFieldId(_arg_1));
        }

        private function healTroops2():void
        {
            this.currentAction = "healtroops2";
            this.setCmdResponse(ResponseDispatcher.ARMY_CURE_INJURED_TROOP, this.handleCmdResponse);
            CityStateCommands.cureInjuredTroop(this.castleId);
        }

        public function deleteStatic(_arg_1:String):*
        {
            return (this.script.deleteStatic(_arg_1));
        }

        private function researchComplete(_arg_1:ResearchCompleteUpdate):void
        {
            if (_arg_1.castleId != this.castleId)
            {
                return;
            };
            this.currentResearch = null;
        }

        private function levy(_arg_1:Object):void
        {
            var _local_2:int;
            this.currentAction = "levy";
            this.onCmdResult("Starting", this.currentAction);
            _local_2 = int(_arg_1);
            if (_local_2 != 0)
            {
                this.levyByIntType(int(_arg_1));
            }
            else
            {
                this.levyByStrType(_arg_1.toString());
            };
            this.onCmdResult(this.currentAction, "complete");
        }


    }
}//package autoevony.scripts

