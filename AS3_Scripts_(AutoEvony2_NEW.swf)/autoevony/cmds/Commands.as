// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.cmds.Commands

package autoevony.cmds
{
    import com.evony.common.module.CommandResponse;
    import autoevony.common.Utils;
    import com.evony.common.module.colony.ColonialDeployResponse;
    import com.evony.common.beans.HeroBean;
    import com.evony.common.beans.CastleBean;
    import autoevony.gui.MainScreen;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.beans.UnitAlliance;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.beans.ResourceBean;
    import com.evony.common.module.alliance.PlayerInfoResponse;
    import com.evony.common.module.colony.ColonyLevyeRespone;
    import autoevony.player.Map;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.beans.ReportBean;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.evony.common.module.report.ReportListResponse;
    import com.evony.common.beans.MailBean;
    import com.evony.common.module.mail.MailListResponse;
    import com.evony.common.constants.FieldConstants;
    import com.evony.common.module.capital.CapitalCommandResponse;
    import com.evony.common.module.common.GetPackageResponse;
    import com.evony.common.beans.PackageBean;
    import com.evony.common.constants.ObjConstants;
    import com.evony.common.module.common.GetPackageListResponse;
    import autoevony.scripts.CityState;
    import com.evony.common.constants.TFConstants;
    import com.evony.common.paramBeans.NewArmyParam;
    import autoevony.management.CityManager;
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.net.Connection;
    import com.evony.common.module.report.ReportResponse;
    import autoevony.scripts.Script;
    import flash.utils.describeType;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.http.HTTPService;
    import autoevony.player.LoginHelper;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.module.alliance.AllianceFriendshipResponse;
    import com.evony.common.module.alliance.AllianceMembersResponse;
    import com.evony.common.beans.MapCastleBean;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.common.constants.MailConstants;
    import com.rd.REAddons;
    import com.evony.common.beans.MilitarySituation;
    import com.evony.common.module.alliance.MilitarySituationListResponse;
    import com.evony.common.module.mail.MailResponse;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.module.colony.ColonialArmyResponse;
    import com.evony.common.module.alliance.AllianceInfoResponse;

    public class Commands 
    {

        private var lastQFarmRun:Number = 0;
        private var detailReport:Boolean = false;
        private var handleLogMsg:Function = null;

        public function Commands(_arg_1:Function)
        {
            this.handleLogMsg = _arg_1;
        }

        private function onColonyGetSupSettingResponse(_arg_1:ColonialDeployResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("<b>Error received:</b> " + _arg_1.errorMsg));
            }
            else
            {
                this.cmdLogMsg(("Suppression setting is currently " + ((_arg_1.troopBean != null) ? Utils.troopBeanToMsgString(_arg_1.troopBean) : "")));
            };
        }

        private function onColonyOverviewResponse(_arg_1:OverviewColonyCastleRespone):void
        {
            var _local_4:HeroBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("<b>Error received:</b> " + _arg_1.errorMsg));
                return;
            };
            var _local_2:CastleBean = _arg_1.castleBean;
            this.cmdLogMsg(((((((((("Colony resource: g:" + Utils.abbrNum(_local_2.resource.gold)) + " f:") + Utils.abbrNum(_local_2.resource.food.amount)) + " w:") + Utils.abbrNum(_local_2.resource.wood.amount)) + " s:") + Utils.abbrNum(_local_2.resource.stone.amount)) + " i:") + Utils.abbrNum(_local_2.resource.iron.amount)));
            this.cmdLogMsg(("Colony troop: " + Utils.troopStrBeanToMsgString(_local_2.strTroop, true)));
            var _local_3:* = "";
            for each (_local_4 in _local_2.herosArray)
            {
                _local_3 = (_local_3 + (" " + Utils.heroBeanToString(_local_4)));
            };
            MainScreen.getInstance().getSelectedCity().cityManager.logMsg(("Colony heroes: " + _local_3));
            this.cmdLogMsg(("Colony heroes: " + _local_3));
        }

        private function qListPackages():void
        {
            ActionFactory.getInstance().getCommonCommands().getPackageList(this.listPackagesResponse);
        }

        private function _no1000(_arg_1:UnitAlliance, _arg_2:String):String
        {
            return ((((((((((((_arg_2 + " ") + _arg_1.allianceName) + ", host: ") + _arg_1.leaderName) + ", rank ") + _arg_1.rank) + ", count: ") + _arg_1.memberCount) + ", pres: ") + _arg_1.aPrestigeCount) + ", honor: ") + _arg_1.honor);
        }

        private function doQuickMarch(_arg_1:int, _arg_2:TroopBean, _arg_3:int, _arg_4:String="", _arg_5:ResourceBean=null, _arg_6:String="", _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:int=0):void
        {
            this.cmdLogMsg(("  " + MainScreen.getInstance().getSelectedCity()._doQuickMarch(_arg_3, _arg_1, _arg_4, _arg_2, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, this.handleGenericCmdResponse)));
        }

        private function onGetPlayerInfoByNameResponse(_arg_1:PlayerInfoResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("<b>Player info:</b> " + _arg_1.errorMsg));
                return;
            };
            var _local_2:Array = new Array("Civilian", "Knight", "Baronet", "Baron", "Viscount", "Earl", "Marquis", "Duke", "Furstin", "Prinzessin");
            this.cmdLogMsg(((((((((((((((((((((((((((("<b>Player info:</b> " + _arg_1.playerInfo.userName) + ", sex: ") + ((_arg_1.playerInfo.sex == 0) ? "Male" : "Female")) + ", alliance: ") + _arg_1.playerInfo.alliance) + ", castleCount: ") + _arg_1.playerInfo.castleCount) + ", flag: ") + _arg_1.playerInfo.flag) + ", starLvl: ") + _arg_1.playerInfo.starlv) + ", pres: ") + _arg_1.playerInfo.prestige) + ", honor: ") + _arg_1.playerInfo.honor) + ", rank: ") + _arg_1.playerInfo.ranking) + ", pos: ") + _arg_1.playerInfo.office) + ", title: ") + _local_2[_arg_1.playerInfo.titleId]) + ", pop: ") + _arg_1.playerInfo.population) + ", votes: ") + _arg_1.playerInfo.getvotes) + ", voteHistory: ") + _arg_1.playerInfo.historygetvotes));
        }

        private function qColony(argsStr:String):void
        {
            var args:Array;
            var selectType:String;
            var levyType:String;
            var endStr:String;
            var argTroop:TroopBean;
            args = argsStr.split(" ");
            var i:int;
            while (i < args.length)
            {
                if (args[i] == "")
                {
                    args.splice(i, 1);
                    if (i > 0)
                    {
                        i = (i - 1);
                    };
                };
                i = (i + 1);
            };
            if (((!(args.length == 2)) && (!(args.length == 3))))
            {
                this.cmdLogMsg("Usage: <b>\\qcolony operation target [suppressionSetting]</b>");
                return;
            };
            var handleColonyLevyResponse:Function = function (_arg_1:ColonyLevyeRespone):void
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    cmdLogMsg(("<b>Error received:</b> " + _arg_1.errorMsg));
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
                cmdLogMsg(("<b>Colony levy response:</b> " + _local_2));
            };
            var fieldId:int = Map.coordStringToFieldId(args[1]);
            var cB:ColonyBean = MainScreen.getInstance().getSelectedCity().cityManager.getColony(fieldId);
            if (cB == null)
            {
                this.cmdLogMsg(("<b>Error:</b> Invalid colony at " + Map.fieldIdToCoordString(fieldId)));
                return;
            };
            var currCastleId:int = MainScreen.getInstance().getSelectedCity().castle.id;
            var op:String = args[0].toString().toLowerCase().substr(0, 2);
            switch (op)
            {
                case "ab":
                    this.cmdLogMsg(((((((("Abandon colony " + cB.cityName) + " ") + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    ActionFactory.getInstance().getColonyCommands().abandonColony(currCastleId, cB.castleId, this.onColonyGenericResponse);
                    return;
                case "fo":
                    this.cmdLogMsg((((((("Levy food from colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "resource";
                    levyType = "Food Levied!";
                    ActionFactory.getInstance().getColonyCommands().levyFood(currCastleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "ta":
                    this.cmdLogMsg((((((("Tax gold from colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "resource";
                    levyType = "Gold imposed!";
                    ActionFactory.getInstance().getColonyCommands().levyTaxes(currCastleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "ar":
                    this.cmdLogMsg((((((("Draft army from colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "army";
                    levyType = "You have drafted ";
                    endStr = " from the city.";
                    ActionFactory.getInstance().getColonyCommands().levyArmy(currCastleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "po":
                    this.cmdLogMsg((((((("Redeploy population from " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "resource";
                    levyType = "Population redeployed!";
                    ActionFactory.getInstance().getColonyCommands().levyPopulation(currCastleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "di":
                    this.cmdLogMsg((((((("Disarm " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    selectType = "army";
                    levyType = "You have disarmed ";
                    endStr = " in the city.";
                    ActionFactory.getInstance().getColonyCommands().reduceArmaments(currCastleId, cB.castleId, handleColonyLevyResponse);
                    return;
                case "ov":
                    this.cmdLogMsg((((((("Overview colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(currCastleId, cB.castleId, this.onColonyOverviewResponse);
                    return;
                case "so":
                    this.cmdLogMsg((((((("Sow discord on colony " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    ActionFactory.getInstance().getColonyCommands().sowDiscord(currCastleId, cB.castleId, this.onColonyGenericResponse);
                    return;
                case "in":
                    this.cmdLogMsg((((((("Army info for " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                    ActionFactory.getInstance().getColonyCommands().getColonialArmyInfo(currCastleId, cB.castleId, this.onGetColonyArmyInfoResponse);
                    return;
                case "su":
                    argTroop = ((args.length == 3) ? Utils.getTroops(args[2]) : null);
                    if (argTroop != null)
                    {
                        this.cmdLogMsg((((((((("Set suppression troop setting for " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName) + " to ") + Utils.troopBeanToMsgString(argTroop, false)));
                        ActionFactory.getInstance().getColonyCommands().setDeployTroops(currCastleId, cB.castleId, argTroop, this.onColonyGenericResponse);
                    }
                    else
                    {
                        this.cmdLogMsg((((((("Get suppression troop setting for " + cB.cityName) + Map.fieldIdToCoordString(fieldId)) + " by ") + cB.lordName) + " of ") + cB.allianceName));
                        ActionFactory.getInstance().getColonyCommands().getDeployTroopsInfo(currCastleId, cB.castleId, this.onColonyGetSupSettingResponse);
                    };
                    return;
                default:
                    this.cmdLogMsg((("Error: Invalid operation " + args[0]) + ", must be either abandon, food, tax, army, population, disarm, overview, sowdiscord, info, suppress"));
            };
        }

        private function _mv26(response:ReportListResponse):void
        {
            var ids:Array;
            var report:ReportBean;
            var count:int;
            if (response.ok != 1)
            {
                this.cmdLogMsg(("Army report list error: " + response.errorMsg));
                return;
            };
            this.cmdLogMsg(((("Page: " + response.pageNo) + "/") + response.totalPage));
            if (response.reportsArray.length == 0)
            {
                return;
            };
            ids = new Array();
            var type:String;
            for each (report in response.reportsArray)
            {
                type = ((report.attack) ? "ATT" : "DEF");
                if (this.detailReport)
                {
                    ids.push(report.id);
                }
                else
                {
                    this.cmdLogMsg(((((((((((("[" + report.id) + "]") + type) + " ") + report.title) + " from ") + report.startPos) + " to ") + report.targetPos) + " on ") + report.eventTime));
                };
            };
            if (ids.length == 0)
            {
                return;
            };
            var timer:Timer = new Timer(2000, ids.length);
            count = 0;
            timer.addEventListener(TimerEvent.TIMER, function (_arg_1:TimerEvent):void
            {
                handleCmd(("readreport " + ids[count]), false);
                count++;
            });
            timer.start();
        }

        private function _iq346(r:MailListResponse):void
        {
            var ids:Array;
            var mail:MailBean;
            var i:int;
            var handler:Function;
            var timer:Timer;
            if (r.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Mail list error: " + r.errorMsg));
                return;
            };
            this.cmdLogMsg(((("Page: " + r.pageNo) + "/") + r.totalPage));
            if (r.mailsArray.length == 0)
            {
                return;
            };
            ids = new Array();
            for each (mail in r.mailsArray)
            {
                ids.push(mail.mailid);
            };
            i = 0;
            handler = function (_arg_1:TimerEvent):void
            {
                handleCmd(("readmail " + ids[i++]), false);
                if (i >= ids.length)
                {
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, handler);
                };
            };
            timer = new Timer(2000);
            timer.repeatCount = ids.length;
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function qCapitalPolicy(argsStr:String):void
        {
            var operation:String;
            var op:String;
            var currCastlePow:int;
            var currCastleId:int;
            var fieldId:int;
            var maxPolicies:int;
            var targetFieldtype:int;
            var leftPolicies:int;
            var getLeftPoliciesTimesResponseHandler:Function;
            var capitalCommandsResponseHandler:Function;
            var args:Array = argsStr.split(" ");
            var i:int;
            while (i < 4)
            {
                if (args[i] == "")
                {
                    args.splice(i, 1);
                    if (i > 0)
                    {
                        i = (i - 1);
                    };
                };
                i = (i + 1);
            };
            if (args.length != 2)
            {
                this.cmdLogMsg("Usage: <b>\\qcapitalpolicy operation target</b>");
                return;
            };
            operation = args[0].toString().toLowerCase();
            op = operation.substr(0, 2);
            if ((((((op == "fo") || (op == "ar")) || (op == "po")) || (op == "di")) || (op == "ta")))
            {
                currCastlePow = MainScreen.getInstance().getSelectedCity().castle.powerlevel;
                currCastleId = MainScreen.getInstance().getSelectedCity().castle.id;
                fieldId = Map.coordStringToFieldId(args[1]);
                switch (currCastlePow)
                {
                    case 4:
                        this.cmdLogMsg('<b>Error:</b> This city is not an HC. The "\\qcapitalpolicy" command can only be used from a Historic City.');
                        return;
                    case 3:
                        maxPolicies = 4;
                        break;
                    case 2:
                        maxPolicies = 6;
                        break;
                    case 1:
                        maxPolicies = 8;
                        break;
                    case 0:
                        maxPolicies = 10;
                        break;
                    default:
                        this.cmdLogMsg("<b>Error:</b> City data incomplete. Cannot determine if city is an HC. Refresh/try again in a few minutes.");
                        return;
                };
                targetFieldtype = Map.getType(fieldId, 60);
                if (targetFieldtype != -1)
                {
                    if (((targetFieldtype == FieldConstants.TYPE_CASTLE) || (targetFieldtype == FieldConstants.TYPE_NPC)))
                    {
                        getLeftPoliciesTimesResponseHandler = function (_arg_1:CapitalCommandResponse):void
                        {
                            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                            {
                                cmdLogMsg(("<b>Error received:</b> " + _arg_1.errorMsg));
                                return;
                            };
                            if (!(_arg_1.amount > 0))
                            {
                                cmdLogMsg((((("You have <b>" + _arg_1.amount) + "/") + maxPolicies) + '</b> policies left for today. Capital policy operation has been cancelled because <b>"no policies remaining"</b>.'));
                                return;
                            };
                            leftPolicies = _arg_1.amount;
                            switch (op)
                            {
                                case "fo":
                                    cmdLogMsg(("Levy food for capital from " + Map.fieldIdToCoordString(fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyFood(currCastleId, fieldId, capitalCommandsResponseHandler);
                                    return;
                                case "ar":
                                    cmdLogMsg(("Draft army for capital from " + Map.fieldIdToCoordString(fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyArmy(currCastleId, fieldId, capitalCommandsResponseHandler);
                                    return;
                                case "po":
                                    cmdLogMsg(("Redeploy population for capital from " + Map.fieldIdToCoordString(fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyPopulation(currCastleId, fieldId, capitalCommandsResponseHandler);
                                    return;
                                case "di":
                                    cmdLogMsg(("Disarm troops on" + Map.fieldIdToCoordString(fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().reduceArmaments(currCastleId, fieldId, capitalCommandsResponseHandler);
                                    return;
                                case "ta":
                                    cmdLogMsg(("Levy tax for capital on " + Map.fieldIdToCoordString(fieldId)));
                                    ActionFactory.getInstance().getCapitalCommands().levyTaxes(currCastleId, fieldId, capitalCommandsResponseHandler);
                                    return;
                            };
                        };
                        capitalCommandsResponseHandler = function (_arg_1:CapitalCommandResponse):void
                        {
                            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                            {
                                cmdLogMsg((("Error received: " + _arg_1.errorMsg) + ((_arg_1.errorMsg.toLowerCase().search("policy decree used") == -1) ? "" : (((("  [ " + (leftPolicies - 1)) + "/") + maxPolicies) + " policies left ]"))));
                                return;
                            };
                            leftPolicies--;
                            var _local_2:* = "<b>Capitalpolicy response</b>: ";
                            if (op == "fo")
                            {
                                _local_2 = (_local_2 + (((("Successful Food Levy. Acquire <b>" + _arg_1.amount) + " food</b>.  From ") + Map.fieldIdToString(fieldId)) + "."));
                            }
                            else
                            {
                                if (op == "ta")
                                {
                                    _local_2 = (_local_2 + (((("Successful Tax Imposition. Acquire <b>" + _arg_1.amount) + " gold</b>.  From ") + Map.fieldIdToString(fieldId)) + "."));
                                }
                                else
                                {
                                    if (op == "ar")
                                    {
                                        _local_2 = (_local_2 + (((((("Successful Draft. Acquire <b>" + _arg_1.amount) + " ") + _arg_1.armyType) + "</b>.  From ") + Map.fieldIdToString(fieldId)) + "."));
                                    }
                                    else
                                    {
                                        if (op == "po")
                                        {
                                            _local_2 = (_local_2 + (((((("Successful Pop. Redeployment. Acquire <b>" + _arg_1.amount) + " ") + _arg_1.armyType) + "</b>.  From ") + Map.fieldIdToString(fieldId)) + "."));
                                        }
                                        else
                                        {
                                            if (op == "di")
                                            {
                                                _local_2 = (_local_2 + (((((("Successful Disarmament. <b>" + _arg_1.amount) + " ") + _arg_1.armyType) + "</b> are disarmed.  From ") + Map.fieldIdToString(fieldId)) + "."));
                                            }
                                            else
                                            {
                                                _local_2 = (_local_2 + (((((((("Completed capitalpolicy " + operation) + " on ") + Map.fieldIdToString(fieldId)) + ": ") + _arg_1.amount) + " of type ") + _arg_1.armyType) + "."));
                                            };
                                        };
                                    };
                                };
                            };
                            _local_2 = (_local_2 + (((("  [ " + leftPolicies) + "/") + maxPolicies) + " policies left ]"));
                            MainScreen.getCityFromCastleId(currCastleId).cityManager.warLogMsg(_local_2);
                            cmdLogMsg(_local_2);
                        };
                        ActionFactory.getInstance().getCapitalCommands().getLeftPoliciesTimes(currCastleId, getLeftPoliciesTimesResponseHandler);
                    }
                    else
                    {
                        this.cmdLogMsg(("<b>Error:</b> Target is not an NPC nor Castle: " + Map.fieldIdToCoordString(fieldId)));
                        return;
                    };
                }
                else
                {
                    this.cmdLogMsg(("<b>Error:</b> Map is not yet available at " + Map.fieldIdToCoordString(fieldId)));
                    return;
                };
            }
            else
            {
                this.cmdLogMsg((('<b>Invalid operation "' + args[0]) + '"</b>, must be either  <b>fo</b>od, <b>ar</b>my, <b>po</b>pulation, <b>di</b>sarm, <b>ta</b>x'));
                return;
            };
        }

        private function claimPackageResponse(_arg_1:GetPackageResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Error received: " + _arg_1.errorMsg));
                return;
            };
            this.cmdLogMsg("Claimed the package successfully.");
            ActionFactory.getInstance().getCommonCommands().getPackageNumber(MainScreen.getInstance().setBoxNum);
        }

        private function listPackagesResponse(_arg_1:GetPackageListResponse):void
        {
            var _local_8:Date;
            var _local_10:PackageBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Error received: " + _arg_1.errorMsg));
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
            this.cmdLogMsg(((((((((((("List of Gift Packages:\n<u>" + _local_5) + " Available Unclaimed Gifts:</u>  ") + _local_2) + "\n<u>") + _local_6) + " Already Claimed Gifts:</u>  ") + _local_3) + "\n<u>") + _local_7) + " Other Unclaimed Gifts:</u>  ") + _local_4));
        }

        private function clearChatLog(_arg_1:String):void
        {
            MainScreen.getInstance()._chatPanel.clear(true, _arg_1);
        }

        private function doShortCmds(_arg_1:String, _arg_2:String):void
        {
            var _local_6:TroopBean;
            var _local_3:int;
            var _local_4:int;
            var _local_5:* = "";
            var _local_7:ResourceBean;
            var _local_8:* = "";
            var _local_9:Array = _arg_2.replace(new RegExp(";", "g"), ":").split(" ");
            var _local_10:int;
            var _local_11:int;
            while (_local_11 < _local_9.length)
            {
                if (_local_9[_local_11] == "")
                {
                    _local_9.splice(_local_11, 1);
                    if (_local_11 > 0)
                    {
                        _local_11--;
                    };
                };
                _local_11++;
            };
            switch (_arg_1)
            {
                case "ver":
                case "version":
                    this.cmdLogMsg(Version.getVersionStr(true));
                    return;
                case "qa":
                case "qattack":
                    if (((!(_local_9.length == 3)) && (!(_local_9.length == 4))))
                    {
                        this.cmdLogMsg("Usage: \\[qa]ttack target hero troop [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_OCCUPY;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_5 = _local_9[1];
                        _local_6 = Utils.getTroops(_local_9[2]);
                        if (_local_9.length == 4)
                        {
                            _local_8 = _local_9[3];
                        };
                        if (_local_6 == null)
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[2]));
                            return;
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8);
                    };
                    return;
                case "qaa":
                case "qaattack":
                    if (((!(_local_9.length == 3)) && (!(_local_9.length == 4))))
                    {
                        this.cmdLogMsg("Usage: \\[qaa]ttack target hero troop [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_OCCUPY;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_5 = _local_9[1];
                        _local_6 = Utils.getTroops(_local_9[2]);
                        if (_local_9.length == 4)
                        {
                            _local_8 = _local_9[3];
                        };
                        if (_local_6 == null)
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[2]));
                            return;
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8, false, false, 2);
                    };
                    return;
                case "qr":
                case "qreinforce":
                    if (((_local_9.length < 3) || (_local_9.length > 5)))
                    {
                        this.cmdLogMsg("Usage: \\[qr]einforce target hero troop [resource] [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_SEND;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_5 = _local_9[1];
                        _local_6 = Utils.getTroops(_local_9[2]);
                        if (_local_6 == null)
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[2]));
                            return;
                        };
                        if (((_local_9.length > 3) && (!(_local_9[3] == "none"))))
                        {
                            _local_7 = Utils.getEstResoBean(_local_9[3]);
                            if (_local_7 == null)
                            {
                                this.cmdLogMsg(("Invalid resource: " + _local_9[3]));
                                return;
                            };
                        };
                        if (_local_9.length > 4)
                        {
                            _local_8 = _local_9[4];
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8);
                    };
                    return;
                case "qs":
                case "qscout":
                    if (((!(_local_9.length == 3)) && (!(_local_9.length == 4))))
                    {
                        this.cmdLogMsg("Usage: \\[qs]cout target hero troop [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_SCOUT;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_5 = _local_9[1];
                        _local_6 = Utils.getTroops(_local_9[2]);
                        if (_local_9.length == 4)
                        {
                            _local_8 = _local_9[3];
                        };
                        if (((_local_6 == null) || (_local_6.scouter == 0)))
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[2]));
                            return;
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8);
                    };
                    return;
                case "qas":
                case "qascout":
                    if (((!(_local_9.length == 3)) && (!(_local_9.length == 4))))
                    {
                        this.cmdLogMsg("Usage: \\[qas]cout target hero troop [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_SCOUT;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_5 = _local_9[1];
                        _local_6 = Utils.getTroops(_local_9[2]);
                        if (_local_9.length == 4)
                        {
                            _local_8 = _local_9[3];
                        };
                        if (((_local_6 == null) || (_local_6.scouter == 0)))
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[2]));
                            return;
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8, false, false, 2);
                    };
                    return;
                case "qc":
                case "qcolonize":
                    if (((!(_local_9.length == 3)) && (!(_local_9.length == 4))))
                    {
                        this.cmdLogMsg("Usage: \\[qc]olonize target hero troop [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_COLONIZE;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_5 = _local_9[1];
                        _local_6 = Utils.getTroops(_local_9[2]);
                        if (_local_9.length == 4)
                        {
                            _local_8 = _local_9[3];
                        };
                        if (_local_6 == null)
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[2]));
                            return;
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8);
                    };
                    return;
                case "qac":
                case "qacolonize":
                    if (((!(_local_9.length == 3)) && (!(_local_9.length == 4))))
                    {
                        this.cmdLogMsg("Usage: \\[qac]olonize target hero troop [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_COLONIZE;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_5 = _local_9[1];
                        _local_6 = Utils.getTroops(_local_9[2]);
                        if (_local_9.length == 4)
                        {
                            _local_8 = _local_9[3];
                        };
                        if (_local_6 == null)
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[2]));
                            return;
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8, false, false, 2);
                    };
                    return;
                case "qt":
                case "qtransport":
                    if (((!(_local_9.length == 3)) && (!(_local_9.length == 4))))
                    {
                        this.cmdLogMsg("Usage: \\[qt]ransport target troop resource [camptime]");
                    }
                    else
                    {
                        _local_3 = ObjConstants.ARMY_MISSION_TRANS;
                        _local_4 = Map.coordStringToFieldId(_local_9[0]);
                        _local_6 = Utils.getTroops(_local_9[1]);
                        _local_7 = Utils.getEstResoBean(_local_9[2]);
                        if (_local_9.length == 4)
                        {
                            _local_8 = _local_9[3];
                        };
                        if (_local_6 == null)
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[1]));
                            return;
                        };
                        if (_local_7 == null)
                        {
                            this.cmdLogMsg(("Invalid resource: " + _local_9[2]));
                            return;
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, _local_8);
                    };
                    return;
                case "qd":
                case "qdeploy":
                    if (((_local_9.length < 4) || (_local_9.length > 9)))
                    {
                        this.cmdLogMsg("Usage: \\[qd]eploy operation target hero troop [resource] [camptime] [useWarEnsign] [useHordeBanner] [autoGear]");
                    }
                    else
                    {
                        _local_3 = CityState.getMissionConstFromString(_local_9[0]);
                        _local_4 = Map.coordStringToFieldId(_local_9[1]);
                        _local_5 = _local_9[2];
                        if ((_local_6 = Utils.getTroops(_local_9[3])) == null)
                        {
                            this.cmdLogMsg(("Invalid troop: " + _local_9[3]));
                            return;
                        };
                        if (((_local_9.length > 4) && (!(_local_9[4] == "none"))))
                        {
                            if ((_local_7 = Utils.getEstResoBean(_local_9[4])) == null)
                            {
                                this.cmdLogMsg(("Invalid resource: " + _local_9[4]));
                                return;
                            };
                        };
                        this.doQuickMarch(_local_4, _local_6, _local_3, _local_5, _local_7, ((_local_9.length > 5) ? _local_9[5] : ""), ((_local_9.length > 6) ? ((_local_9[6] == "true") ? true : false) : false), ((_local_9.length > 7) ? ((_local_9[7] == "true") ? true : false) : false), ((_local_9.length > 8) ? _local_9[8] : 0));
                    };
                    return;
                case "qdec":
                case "qdeclarewar":
                    if (_local_9.length == 1)
                    {
                        _local_10 = Map.coordStringToFieldId(_local_9[0]);
                        if (_local_10 != -1)
                        {
                            MainScreen.getInstance().getSelectedCity()._declareWar(_local_10);
                        };
                    }
                    else
                    {
                        this.cmdLogMsg("Usage: \\[qdec]larewar target");
                    };
                    return;
                case "qkillwall":
                    MainScreen.getInstance().getSelectedCity()._qKillWall();
                    return;
                case "qwtra":
                case "qwalltrap":
                case "qwalltraps":
                    if (_local_9.length == 1)
                    {
                        _local_10 = int(_local_9[0]);
                        if (_local_10 != 0)
                        {
                            MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_TRAP, _local_10);
                        };
                    }
                    else
                    {
                        this.cmdLogMsg("Usage: \\qwtra [No of Traps]");
                    };
                    return;
                case "qwab":
                case "qwallabatis":
                    if (_local_9.length == 1)
                    {
                        _local_10 = int(_local_9[0]);
                        if (_local_10 != 0)
                        {
                            MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ABATIS, _local_10);
                        };
                    }
                    else
                    {
                        this.cmdLogMsg("Usage: \\qwab [No of abatis]");
                    };
                    return;
                case "qwat":
                case "qwallarchertower":
                case "qwallarchertowers":
                    if (_local_9.length == 1)
                    {
                        _local_10 = int(_local_9[0]);
                        if (_local_10 != 0)
                        {
                            MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ARROWTOWER, _local_10);
                        };
                    }
                    else
                    {
                        this.cmdLogMsg("Usage: \\qwat [No of archer tower]");
                    };
                    return;
                case "qwr":
                case "qwrl":
                case "qwallrollinglog":
                case "qwallrollinglogs":
                    if (_local_9.length == 1)
                    {
                        _local_10 = int(_local_9[0]);
                        if (_local_10 != 0)
                        {
                            MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ROLLINGLOGS, _local_10);
                        };
                    }
                    else
                    {
                        this.cmdLogMsg("Usage: \\qwr [No of rolling logs]");
                    };
                    return;
                case "qwtre":
                case "qwtreb":
                case "qwtrebs":
                case "qwtrebuchets":
                case "qwdefensivetrebuchet":
                case "qwdefensivetrebuchets":
                    if (_local_9.length == 1)
                    {
                        _local_10 = int(_local_9[0]);
                        if (_local_10 != 0)
                        {
                            MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ROCKFALL, _local_10);
                        };
                    }
                    else
                    {
                        this.cmdLogMsg("Usage: \\qwtre [No of trebs]");
                    };
                    return;
                default:
                    this.cmdLogMsg(("Invalid command: " + _arg_1));
            };
        }

        private function handleGenericCmdResponse(_arg_1:Object):void
        {
            if (_arg_1.ok == undefined)
            {
                this.cmdLogMsg("BUG: Bad use of handle generic response");
            }
            else
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    this.cmdLogMsg(("Error Generic: " + _arg_1.errorMsg));
                };
            };
        }

        private function qClaimPackage(_arg_1:int):void
        {
            ActionFactory.getInstance().getCommonCommands().getPackage(_arg_1, "", this.claimPackageResponse);
        }

        public function _kj1046(inline:Boolean=true):void
        {
            var newDate:Date;
            var nextQFarmAllowed:Boolean;
            var qFarmError:Boolean;
            var qFarmCount:int;
            var allArmies:Array;
            var army:NewArmyParam;
            var obj:Object;
            var city:CityState;
            var timer:Timer;
            var count5s:int;
            var lastManager:CityManager;
            var release:Function;
            var handler:Function;
            newDate = new Date();
            if (((inline) && (this.lastQFarmRun > (newDate.getTime() - (5 * 1000)))))
            {
                MainScreen.getInstance().logMsg("qfarm was executed within the last 5 seconds, please try again later");
                return;
            };
            nextQFarmAllowed = true;
            qFarmError = false;
            qFarmCount = 0;
            allArmies = new Array();
            army = null;
            var arr:Array;
            obj = null;
            for each (city in MainScreen.getCities())
            {
                arr = city.cityManager._doQFarm();
                if (arr == null)
                {
                    qFarmError = true;
                }
                else
                {
                    for each (army in arr)
                    {
                        obj = new Object();
                        obj.manager = city.cityManager;
                        obj.army = army;
                        allArmies.push(obj);
                    };
                };
            };
            timer = new Timer(100);
            count5s = 0;
            lastManager = null;
            release = function (_arg_1:CommandResponse):void
            {
                nextQFarmAllowed = true;
            };
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_NEW_ARMY, release);
            handler = function (event:TimerEvent):void
            {
                var success:Boolean;
                var manager:CityManager;
                newDate = new Date();
                lastQFarmRun = newDate.getTime();
                if (!Connection.getInstance().authenticated)
                {
                    allArmies = new Array();
                    lastManager = null;
                    return;
                };
                count5s++;
                if (count5s == 50)
                {
                    nextQFarmAllowed = true;
                };
                if (nextQFarmAllowed)
                {
                    nextQFarmAllowed = false;
                    count5s = 0;
                    if (allArmies.length == 0)
                    {
                        if (inline)
                        {
                            if (qFarmError)
                            {
                                cmdLogMsg((("qfarm: Map is not yet ready for all towns, " + qFarmCount) + " waves sent"));
                            }
                            else
                            {
                                cmdLogMsg((("qfarm: " + qFarmCount) + " waves are sent out according to your goals"));
                            };
                        };
                        ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ARMY_NEW_ARMY, release);
                        timer.removeEventListener(TimerEvent.TIMER, handler);
                        timer.stop();
                        return;
                    };
                    obj = allArmies.shift();
                    manager = obj.manager;
                    army = obj.army;
                    success = manager._sendQuickArmy(army, (manager == lastManager), function (_arg_1:CommandResponse):void
                    {
                        if (_arg_1.ok != 1)
                        {
                            cmdLogMsg(("QFarm partial response: " + _arg_1.errorMsg));
                        };
                    });
                    lastManager = manager;
                    if (success)
                    {
                        qFarmCount++;
                    };
                };
            };
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        private function formatTypeStr(_arg_1:String):String
        {
            if (_arg_1.charAt(0) == "_")
            {
                return ("*");
            };
            if (_arg_1.indexOf("::") != -1)
            {
                _arg_1 = _arg_1.substr((_arg_1.indexOf("::") + 2));
            };
            return (_arg_1);
        }

        private function onColonyGenericResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("<b>Error received:</b> " + _arg_1.errorMsg));
            };
        }

        private function _gc827(_arg_1:ReportResponse):void
        {
            var _local_5:String;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Read report/mark as read error: " + _arg_1.errorMsg));
                return;
            };
            var _local_2:ReportBean = _arg_1.report;
            var _local_3:String = ((_local_2.attack) ? "ATT" : "DEF");
            var _local_4:XML = new XML(_local_2.content);
            if (_local_2.armyType == ObjConstants.ARMY_MISSION_SCOUT)
            {
                this.cmdLogMsg(Utils.formatUrl(((((((((_local_3 + " ") + _local_2.title) + " on ") + _local_2.eventTime) + " from ") + _local_2.startPos) + " to ") + _local_2.targetPos), _local_4.@reportUrl));
                if (((_local_2.attack) && (_local_4.scoutReport.@isSuccess == "true")))
                {
                    this.cmdLogMsg(("  " + CityManager._wd318(_local_4.scoutReport)));
                };
            }
            else
            {
                if (((_local_2.armyType == ObjConstants.ARMY_MISSION_COLONIZE) || (_local_2.armyType == ObjConstants.ARMY_MISSION_OCCUPY)))
                {
                    this.cmdLogMsg(Utils.formatUrl(((((((((_local_3 + " ") + _local_2.title) + " on ") + _local_2.eventTime) + " from ") + _local_2.startPos) + " to ") + _local_2.targetPos), _local_4.@reportUrl));
                    this.cmdLogMsg(("  " + Utils.armyReportToString(_local_4.battleReport)));
                }
                else
                {
                    if (_local_2.type == 2)
                    {
                        _local_5 = _local_4.policyReport.@detail;
                        if (_local_2.content.indexOf("<") == -1)
                        {
                            this.cmdLogMsg(((((("@" + _local_2.title) + " on ") + _local_2.eventTime) + " ") + _local_2.content));
                        }
                        else
                        {
                            if (_local_5 != "")
                            {
                                this.cmdLogMsg(((((("@" + _local_2.title) + " on ") + _local_2.eventTime) + " ") + _local_5));
                            }
                            else
                            {
                                _local_5 = _local_2.content;
                                _local_5 = _local_5.split("<").join("[");
                                _local_5 = _local_5.split(">").join("]");
                                this.cmdLogMsg(((((("@" + _local_2.title) + " on ") + _local_2.eventTime) + " ") + _local_5));
                            };
                        };
                    }
                    else
                    {
                        this.cmdLogMsg(((((((((("Unknown report: " + _local_2.type) + " ") + _local_2.title) + " on ") + _local_2.eventTime) + " from ") + _local_2.startPos) + " to ") + _local_2.targetPos));
                    };
                };
            };
        }

        private function qClaimAllPackages():void
        {
            ActionFactory.getInstance().getCommonCommands().getPackageList(this.qClaimAllPackagesHandler);
        }

        private function doDescribeCmd(_arg_1:String):void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_4:String;
            var _local_5:XML;
            var _local_6:Array;
            var _local_7:Array;
            var _local_8:*;
            var _local_9:Boolean;
            var _local_10:int;
            var _local_11:*;
            if (_arg_1 == "")
            {
                this.cmdLogMsg("Usage \\describe internal_var");
            }
            else
            {
                _local_2 = MainScreen.getInstance().getSelectedCity()._getScript().getValue(_arg_1);
                if (_local_2 == Script.BADOBJECT)
                {
                    this.cmdLogMsg(("Invalid internal variable/method: " + _arg_1));
                }
                else
                {
                    _local_3 = "";
                    _local_4 = "";
                    _local_5 = describeType(_local_2);
                    _local_6 = new Array();
                    _local_7 = new Array();
                    for each (_local_8 in _local_5.variable)
                    {
                        _local_4 = _local_8.@name;
                        if (_local_4.charAt(0) != "_")
                        {
                            _local_3 = (((("<b>" + _local_4) + "</b>") + ":") + this.formatTypeStr(_local_8.@type));
                            _local_6.push(_local_3);
                        };
                    };
                    for each (_local_8 in _local_5.accessor)
                    {
                        _local_4 = _local_8.@name;
                        if (_local_4.charAt(0) != "_")
                        {
                            _local_3 = (((("<b>" + _local_4) + "</b>") + ":") + this.formatTypeStr(_local_8.@type));
                            _local_6.push(_local_3);
                        };
                    };
                    _local_9 = false;
                    for each (_local_8 in _local_5.method)
                    {
                        _local_4 = _local_8.@name;
                        if (!((((((_local_4.charAt(0) == "_") || (_local_4 == "addEventListener")) || (_local_4 == "dispatchEvent")) || (_local_4 == "hasEventListener")) || (_local_4 == "removeEventListener")) || (_local_4 == "willTrigger")))
                        {
                            _local_3 = (("<b>" + _local_4) + "(</b>");
                            _local_9 = true;
                            for each (_local_11 in _local_8.parameter)
                            {
                                if (!_local_9)
                                {
                                    _local_3 = (_local_3 + ",");
                                };
                                _local_9 = false;
                                if (_local_11.@optional == "true")
                                {
                                    _local_3 = (_local_3 + "[");
                                };
                                _local_3 = (_local_3 + this.formatTypeStr(_local_11.@type));
                                if (_local_11.@optional == "true")
                                {
                                    _local_3 = (_local_3 + "]");
                                };
                            };
                            _local_3 = (_local_3 + ("<b>)</b>:" + this.formatTypeStr(_local_8.@returnType)));
                            _local_7.push(_local_3);
                        };
                    };
                    if (_local_6.length > 0)
                    {
                        _local_6.sort(Array.CASEINSENSITIVE);
                    };
                    if (_local_7.length > 0)
                    {
                        _local_7.sort(Array.CASEINSENSITIVE);
                    };
                    _local_3 = "\n  ----------&lt; VARIABLES &gt;----------";
                    _local_10 = 0;
                    while (_local_10 < _local_6.length)
                    {
                        _local_3 = (_local_3 + ("\n" + _local_6[_local_10]));
                        _local_10++;
                    };
                    _local_3 = (_local_3 + "\n\n  ----------&lt; METHODS &gt;----------");
                    _local_10 = 0;
                    while (_local_10 < _local_7.length)
                    {
                        _local_3 = (_local_3 + ("\n" + _local_7[_local_10]));
                        _local_10++;
                    };
                    this.cmdLogMsg((((("<font color='#092D2D'> ========== Description of <b>" + _arg_1) + "</b> ==========\n</font>") + _local_3) + "\n"));
                };
            };
        }

        private function getFbLinks(arg:String=null):void
        {
            var linkNames:Array;
            var args:Array;
            var i:int;
            var fbId:String = MainScreen.getPlayer().playerInfo.facebookId;
            if ((((fbId == null) || (fbId == "null")) || (fbId == "")))
            {
                this.cmdLogMsg("<b>Command failed:</b> Missing facebookId value. Please make sure this account is attached to a Facebook account before using this command.");
                return;
            };
            if (((!(arg == null)) && (!(arg == ""))))
            {
                linkNames = new Array("hnm", "lb", "bp", "wh", "aa", "bw");
                args = arg.toLowerCase().split(",");
                i = 0;
                while (i < args.length)
                {
                    if (linkNames.indexOf(args[i]) == -1)
                    {
                        this.cmdLogMsg((('<b>Command failed:</b> Bad value "<b>' + args[i]) + '</b>" entered in desired link list.\nValid Options are: HNM,LB,BP,WH,AA,BW'));
                        return;
                    };
                    i = (i + 1);
                };
            };
            var handler:Function = function (_arg_1:ResultEvent):void
            {
                var _local_2:XML = new XML(_arg_1.message.body.toString());
                if (int(_local_2.response.@ok) < 1)
                {
                    cmdLogMsg(("<b>Command failed. Error recieved:</b> " + _local_2.response.@message));
                    return;
                };
                var _local_3:* = (((("Remaining time until new fbLinks: " + Utils.formatTime(int((Number(_local_2.response.@timeUntilNextReq) / 1000)))) + "\nDisplaying ") + (((!(args == null)) && (args.length > 0)) ? args.length : 6)) + " fb links:\n");
                if ((((args == null) || (args.length == 0)) || (!(args.indexOf("hnm") == -1))))
                {
                    _local_3 = (_local_3 + ("\n<b><u>Hungry No More link</u></b>:\n" + _local_2.response.@hnmLnk));
                };
                if ((((args == null) || (args.length == 0)) || (!(args.indexOf("lb") == -1))))
                {
                    _local_3 = (_local_3 + ("\n<b><u>Legendary Bard link</u></b>:\n" + _local_2.response.@bardLnk));
                };
                if ((((args == null) || (args.length == 0)) || (!(args.indexOf("bp") == -1))))
                {
                    _local_3 = (_local_3 + ("\n<b><u>Black Plague link</u></b>:\n" + _local_2.response.@plagueLnk));
                };
                if ((((args == null) || (args.length == 0)) || (!(args.indexOf("wh") == -1))))
                {
                    _local_3 = (_local_3 + ("\n<b><u>Wild Horses link</u></b>:\n" + _local_2.response.@wildHorsesLnk));
                };
                if ((((args == null) || (args.length == 0)) || (!(args.indexOf("aa") == -1))))
                {
                    _local_3 = (_local_3 + ("\n<b><u>Ancient Artifact link</u></b>:\n" + _local_2.response.@artifactLnk));
                };
                if ((((args == null) || (args.length == 0)) || (!(args.indexOf("bw") == -1))))
                {
                    _local_3 = (_local_3 + ("\n<b><u>Buxom Wenches link</u></b>:\n" + _local_2.response.@wenchesLnk));
                };
                _local_3 = (_local_3 + "\n");
                cmdLogMsg(_local_3);
            };
            var errorHandler:Function = function (_arg_1:FaultEvent):void
            {
                cmdLogMsg(("<b>The following error has occurred:</b> " + _arg_1.fault.faultString));
            };
            var httpReq:HTTPService = new HTTPService();
            httpReq.url = "http://evonystuff.com/rqstFbLnks/getFbLnk.asp";
            httpReq.method = "POST";
            httpReq.resultFormat = HTTPService.RESULT_FORMAT_XML;
            httpReq.contentType = HTTPService.CONTENT_TYPE_FORM;
            httpReq.method = "POST";
            httpReq.addEventListener(ResultEvent.RESULT, handler);
            httpReq.addEventListener(FaultEvent.FAULT, errorHandler);
            httpReq.send({
                "fbId":(fbId + ""),
                "sName":(LoginHelper.getInstance().server + "")
            });
        }

        private function _yr516(_arg_1:PlayerInfoBean, _arg_2:PlayerInfoBean):int
        {
            if (_arg_1.lastLoginTime > _arg_2.lastLoginTime)
            {
                return (-1);
            };
            if (_arg_1.lastLoginTime < _arg_2.lastLoginTime)
            {
                return (1);
            };
            return (0);
        }

        private function _is776(_arg_1:AllianceFriendshipResponse):void
        {
            var _local_2:UnitAlliance;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("<b>Alliance relationship:</b> " + _arg_1.errorMsg));
                return;
            };
            for each (_local_2 in _arg_1.friendlyListArray)
            {
                this.cmdLogMsg(this._no1000(_local_2, "friend"));
            };
            for each (_local_2 in _arg_1.middleListArray)
            {
                this.cmdLogMsg(this._no1000(_local_2, "neutral"));
            };
            for each (_local_2 in _arg_1.enemyListArray)
            {
                this.cmdLogMsg(this._no1000(_local_2, "enemy"));
            };
        }

        private function qClaimAllPackagesHandler(r:GetPackageListResponse):void
        {
            var ids:Array;
            var pkg:PackageBean;
            var i:int;
            var handler:Function;
            var claimPkg:Function;
            if (r.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Error received: " + r.errorMsg));
                return;
            };
            if (((r.packagesArray == null) || (r.packagesArray.length == 0)))
            {
                this.cmdLogMsg("Received empty package list from server.");
                return;
            };
            ids = new Array();
            for each (pkg in r.packagesArray)
            {
                if (pkg.status == ObjConstants.PACKAGE_STATUS_AVAIBLE)
                {
                    ids.push(pkg.id);
                };
            };
            if (ids.length == 0)
            {
                this.cmdLogMsg("No available packages received from server. Nothing to claim.");
                return;
            };
            this.cmdLogMsg((("Attempting to claim " + ids.length) + " packages..."));
            i = 0;
            handler = function (_arg_1:GetPackageResponse):void
            {
                i++;
                if (_arg_1.ok == GetPackageResponse.ERROR_PACKAGE_EXPIRED)
                {
                    cmdLogMsg(((((("ERROR while claiming package " + i) + " with id: ") + ids[i]) + ": ") + _arg_1.errorMsg));
                }
                else
                {
                    if (_arg_1.ok == GetPackageResponse.ERROR_PACKAGE_NOT_EXISTS)
                    {
                        cmdLogMsg(((((("ERROR while claiming package " + i) + " with id: ") + ids[i]) + ": ") + _arg_1.errorMsg));
                    }
                    else
                    {
                        if (_arg_1.ok == GetPackageResponse.ERROR_REQUIRMENT_NOT_MET)
                        {
                            cmdLogMsg(((((("ERROR while claiming package " + i) + " with id: ") + ids[i]) + ": ") + _arg_1.errorMsg));
                        }
                        else
                        {
                            cmdLogMsg(((("Successfully claimed package " + i) + " with id: ") + ids[i]));
                        };
                    };
                };
                if (i < ids.length)
                {
                    Utils.callLater(50, claimPkg);
                }
                else
                {
                    cmdLogMsg((("Completed attempting to claim " + ids.length) + " packages."));
                    ActionFactory.getInstance().getCommonCommands().getPackageNumber(MainScreen.getInstance().setBoxNum);
                };
            };
            claimPkg = function (_arg_1:TimerEvent=null):void
            {
                ActionFactory.getInstance().getCommonCommands().getPackage(ids[i], "", handler);
            };
            Utils.callLater(50, claimPkg);
        }

        public function doCmd(_arg_1:String, _arg_2:Boolean=true):void
        {
            this.handleCmd(_arg_1, _arg_2);
        }

        private function _wn1051(_arg_1:AllianceMembersResponse):void
        {
            var _local_2:Date;
            var _local_3:PlayerInfoBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Alliance members error: " + _arg_1.errorMsg));
                return;
            };
            _arg_1.membersArray.source.sort(this._yr516);
            this.cmdLogMsg("Alliance members: ");
            for each (_local_3 in _arg_1.membersArray)
            {
                _local_2 = new Date(_local_3.lastLoginTime);
                this.cmdLogMsg((((((((" " + _local_3.userName) + " ") + _local_3.allianceLevel) + " pres: ") + _local_3.prestige) + " last: ") + _local_2.toLocaleString()));
            };
        }

        private function handleCmd(cmdStr:String, external:Boolean=true):void
        {
            var args:String;
            var level:int;
            var type:int;
            var typeStr:String;
            var levelStr:String;
            var coordStr:String;
            var argsArr:Array;
            var fieldId:int;
            var func:Function;
            var t:Timer;
            var minPres3:int;
            var sp1:int;
            var sp2:int;
            var username:String;
            var title:String;
            var content:String;
            var command:String = cmdStr;
            args = "";
            var msg:String = "";
            var count:int;
            var maxTowns:int = 1000;
            var arr:Array;
            var castle:MapCastleBean;
            var varTmpYB42:CityState;
            var mCB:MapCastleBean;
            var nwCorner:int = -1;
            var seCorner:int = -1;
            var sp:int = cmdStr.indexOf(" ");
            if (sp != -1)
            {
                command = cmdStr.substr(0, sp);
                args = cmdStr.substr((sp + 1));
            };
            if (external)
            {
                this.cmdLogMsg(("Command: " + cmdStr));
            };
            switch (command)
            {
                case "clear":
                case "clearcommandwindow":
                    this.clearChatLog("commandText");
                    return;
                case "clearac":
                case "clearalliancechat":
                    this.clearChatLog("aChatText");
                    return;
                case "clearpc":
                case "clearprivatechat":
                    this.clearChatLog("pChatText");
                    return;
                case "clearwc":
                case "clearworldchat":
                    this.clearChatLog("wChatText");
                    return;
                case "clearsys":
                case "clearsystemlog":
                    this.clearChatLog("systemText");
                    return;
                case "who":
                    ActionFactory.getInstance().getCommonCommands().getPlayerInfoByName(Utils.trim(args), this.onGetPlayerInfoByNameResponse);
                    return;
                case "fmth":
                    MainScreen.getInstance().getSelectedCity().cityManager._forceTrainingHeroMove();
                    return;
                case "fmthg":
                    CityManager.deletePlayerTiming("movetraininghero");
                    return;
                case "ver":
                case "version":
                case "qa":
                case "qattack":
                case "qaa":
                case "qaattack":
                case "qr":
                case "qreinforce":
                case "qs":
                case "qscout":
                case "qas":
                case "qascout":
                case "qc":
                case "qcolonize":
                case "qac":
                case "qacolonize":
                case "qt":
                case "qtransport":
                case "qd":
                case "qdeploy":
                case "qdec":
                case "qdeclarewar":
                case "qkillwall":
                case "qwtra":
                case "qwalltrap":
                case "qwalltraps":
                case "qwab":
                case "qwallabatis":
                case "qwat":
                case "qwallarchertower":
                case "qwallarchertowers":
                case "qwr":
                case "qwrl":
                case "qwallrollinglog":
                case "qwallrollinglogs":
                case "qwtre":
                case "qwtreb":
                case "qwtrebs":
                case "qwtrebuchets":
                case "qwdefensivetrebuchet":
                case "qwdefensivetrebuchets":
                    this.doShortCmds(command, args);
                    return;
                case "getfblinks":
                    this.getFbLinks(args);
                    return;
                case "alliance":
                    ActionFactory.getInstance().getAllianceCommands().getAllianceInfo(Utils.trim(args), this._yr821);
                    return;
                case "getrelations":
                    ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList(this._is776);
                    return;
                case "setenemy":
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(Utils.trim(args), AllianceConstants.ENEMY_ALLIANCE, this.handleGenericCmdResponse);
                    return;
                case "setfriend":
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(Utils.trim(args), AllianceConstants.FRIEND_ALLIANCE, this.handleGenericCmdResponse);
                    return;
                case "setneutral":
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(Utils.trim(args), AllianceConstants.MIDDLE_ALLIANCE, this.handleGenericCmdResponse);
                    return;
                case "setnorelation":
                    ActionFactory.getInstance().getAllianceManagementCommands().dropAllianceFriendshipRelation(Utils.trim(args), this.handleGenericCmdResponse);
                    return;
                case "sethost":
                    ActionFactory.getInstance().getAllianceManagementCommands().resetTopPowerForAlliance(Utils.trim(args), this.handleGenericCmdResponse);
                    return;
                case "setvicehost":
                    ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args), AllianceConstants.TOP2_POWER_FOR_ALLIANCE, this.handleGenericCmdResponse);
                    return;
                case "setpresbyter":
                    ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args), AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE, this.handleGenericCmdResponse);
                    return;
                case "setofficer":
                    ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args), AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE, this.handleGenericCmdResponse);
                    return;
                case "setmember":
                    ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args), AllianceConstants.LAST_POWER_FOR_ALLIANCE, this.handleGenericCmdResponse);
                    return;
                case "resign":
                    ActionFactory.getInstance().getAllianceManagementCommands().resignForAlliance(this.handleGenericCmdResponse);
                    return;
                case "loc":
                    fieldId = Map.coordStringToFieldId(Utils.trim(args));
                    if (fieldId == -1)
                    {
                        this.cmdLogMsg(("Invalid location: " + args));
                        return;
                    };
                    Map.updateInfo(fieldId);
                    Map.updateDetailInfo(fieldId);
                    func = function (_arg_1:TimerEvent):void
                    {
                        var _local_2:MapCastleBean = Map.getDetail(fieldId);
                        if (((Map.getType(fieldId) == -1) || (_local_2 == null)))
                        {
                            return;
                        };
                        cmdLogMsg(((((((((((("Location info: " + args) + ": ") + Map.fieldIdToString(fieldId)) + " ") + Map.getStateName(_local_2.state)) + ", ") + _local_2.name) + " ") + _local_2.zoneName) + ", belongs to ") + ((_local_2.userName == null) ? "none" : ((((((((_local_2.userName + " [") + _local_2.allianceName) + "], pres: ") + _local_2.prestige) + ", honor: ") + _local_2.honor) + ", suz: ") + _local_2.suzerain))));
                        t.stop();
                        t.removeEventListener(TimerEvent.TIMER, func);
                    };
                    t = new Timer(500, 20);
                    t.addEventListener(TimerEvent.TIMER, func);
                    t.start();
                    return;
                case "searchcastle":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\searchcastle name|user|alliance [NwCoord] [SeCoord]</b>");
                        return;
                    };
                    argsArr = args.split(" ");
                    if (argsArr.length == 3)
                    {
                        nwCorner = Map.coordStringToFieldId(argsArr[1]);
                        seCorner = Map.coordStringToFieldId(argsArr[2]);
                    };
                    if ((((argsArr.length == 1) || (nwCorner == -1)) || (seCorner == -1)))
                    {
                        arr = Map.searchCastles(args);
                    }
                    else
                    {
                        arr = Map.searchCastlesWithinArea(String(argsArr[0]).split("_").join(" "), nwCorner, seCorner);
                    };
                    arr.sort(this.sortSearchHelper);
                    msg = (("<b>=== search castle for " + args) + " ===</b>");
                    msg = (msg + ("\n" + ((arr.length == 0) ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN")));
                    for each (castle in arr)
                    {
                        level = Map.getLevel(castle.id);
                        type = Map.getType(castle.id);
                        if (((level == 10) && ((type == FieldConstants.TYPE_NPC) || (type == FieldConstants.TYPE_CASTLE))))
                        {
                            mCB = Map.getDetailInfo(castle.id);
                            if (mCB != null)
                            {
                                level = (18 - (2 * mCB.powerLevel));
                            };
                        };
                        typeStr = (((level > 10) && (type == FieldConstants.TYPE_NPC)) ? "HC" : ((type == -1) ? "" : Map.FIELD_NAMES[type]));
                        levelStr = ((level == -1) ? "" : ("" + level));
                        coordStr = Map.fieldIdToCoordinate(castle.id);
                        msg = (msg + ((((((((((((((((((((((("\n" + (int((MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100)) / 100)) + "&#9;") + Map.getRegionName(castle.id)) + "&#9;") + coordStr) + "&#9;") + typeStr) + "&#9;") + levelStr) + "&#9;") + castle.name) + "&#9;") + castle.userName) + "&#9;") + castle.allianceName) + "&#9;") + Map.getStateName(castle.state)) + "&#9;") + castle.prestige) + "&#9;") + castle.honor) + "&#9;") + castle.suzerain));
                    };
                    this.cmdLogMsg((msg + "\n<b>===== end search =====</b>"));
                    return;
                case "searchsuzerain":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\searchsuzerain user</b>");
                        return;
                    };
                    arr = Map.searchSuzerain(args);
                    arr.sort(this.sortSearchHelper);
                    msg = (("<b>=== search suzerain for " + args) + " ===</b>");
                    msg = (msg + ("\n" + ((arr.length == 0) ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN")));
                    for each (castle in arr)
                    {
                        level = Map.getLevel(castle.id);
                        type = Map.getType(castle.id);
                        if (((level == 10) && ((type == FieldConstants.TYPE_NPC) || (type == FieldConstants.TYPE_CASTLE))))
                        {
                            mCB = Map.getDetailInfo(castle.id);
                            if (mCB != null)
                            {
                                level = (18 - (2 * mCB.powerLevel));
                            };
                        };
                        typeStr = (((level > 10) && (type == FieldConstants.TYPE_NPC)) ? "HC" : ((type == -1) ? "" : Map.FIELD_NAMES[type]));
                        levelStr = ((level == -1) ? "" : ("" + level));
                        coordStr = Map.fieldIdToCoordinate(castle.id);
                        msg = (msg + ((((((((((((((((((((((("\n" + (int((MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100)) / 100)) + "&#9;") + Map.getRegionName(castle.id)) + "&#9;") + coordStr) + "&#9;") + typeStr) + "&#9;") + levelStr) + "&#9;") + castle.name) + "&#9;") + castle.userName) + "&#9;") + castle.allianceName) + "&#9;") + Map.getStateName(castle.state)) + "&#9;") + castle.prestige) + "&#9;") + castle.honor) + "&#9;") + castle.suzerain));
                    };
                    this.cmdLogMsg((msg + "\n<b>===== end search =====</b>"));
                    return;
                case "searchenemies":
                    if (args == "")
                    {
                        args = "1000";
                    };
                    if (!Utils.hasValue(args))
                    {
                        this.cmdLogMsg("Usage: <b>\\searchenemies maxtowns</b>");
                        return;
                    };
                    if (int(args) > 1000)
                    {
                        this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be greater than 1000, using default max value instead");
                    }
                    else
                    {
                        if (int(args) < 10)
                        {
                            this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be less than 10, using default min value instead");
                        };
                    };
                    maxTowns = Math.max(Math.min(int(args), 1000), 10);
                    arr = Map.searchEnemyCastles(args);
                    arr.sort(this.sortSearchHelper);
                    msg = "<b>===== search enemy castle =====</b>";
                    msg = (msg + ("\n" + ((arr.length == 0) ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN")));
                    count = 0;
                    for each (castle in arr)
                    {
                        if (++count > maxTowns) break;
                        level = Map.getLevel(castle.id);
                        type = Map.getType(castle.id);
                        if (((level == 10) && ((type == FieldConstants.TYPE_NPC) || (type == FieldConstants.TYPE_CASTLE))))
                        {
                            mCB = Map.getDetailInfo(castle.id);
                            if (mCB != null)
                            {
                                level = (18 - (2 * mCB.powerLevel));
                            };
                        };
                        typeStr = (((level > 10) && (type == FieldConstants.TYPE_NPC)) ? "HC" : ((type == -1) ? "" : Map.FIELD_NAMES[type]));
                        levelStr = ((level == -1) ? "" : ("" + level));
                        coordStr = Map.fieldIdToCoordinate(castle.id);
                        msg = (msg + ((((((((((((((((((((((("\n" + (int((MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100)) / 100)) + "&#9;") + Map.getRegionName(castle.id)) + "&#9;") + coordStr) + "&#9;") + typeStr) + "&#9;") + levelStr) + "&#9;") + castle.name) + "&#9;") + castle.userName) + "&#9;") + castle.allianceName) + "&#9;") + Map.getStateName(castle.state)) + "&#9;") + castle.prestige) + "&#9;") + castle.honor) + "&#9;") + castle.suzerain));
                    };
                    if (arr.length > 1000)
                    {
                        msg = (msg + ("\n" + "<b>Warning:</b> ONLY 1000 nearest enemy towns are shown, please use 'searchcastle alliance' instead"));
                    }
                    else
                    {
                        if (count > 100)
                        {
                            msg = (msg + ("\n" + "<b>Notice:</b> You may want to restrict the search result, for example: \\searchenemies 20"));
                        };
                    };
                    this.cmdLogMsg((msg + "\n<b>===== end search =====</b>"));
                    return;
                case "listcastles":
                    argsArr = args.split(" ");
                    if (argsArr.length < 2)
                    {
                        this.cmdLogMsg("Usage: <b>\\listcastles coord coord [maxtowns] [minprestige]</b>");
                        return;
                    };
                    nwCorner = Map.coordStringToFieldId(argsArr[0]);
                    seCorner = Map.coordStringToFieldId(argsArr[1]);
                    if (((((nwCorner == -1) || (seCorner == -1)) || ((argsArr.length >= 3) && (isNaN(argsArr[2])))) || ((argsArr.length >= 4) && (isNaN(argsArr[3])))))
                    {
                        this.cmdLogMsg("<b>Param error:</b> invalid corner coordinates, max towns, or min prestige");
                        this.cmdLogMsg("Usage: <b>\\listcastles coord coord [maxtowns] [minprestige]</b>");
                        return;
                    };
                    if (int(argsArr[2]) > 1000)
                    {
                        this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be greater than 1000, using default max value instead");
                    }
                    else
                    {
                        if (int(argsArr[2]) < 10)
                        {
                            this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be less than 10, using default min value instead");
                        };
                    };
                    if (argsArr.length >= 3)
                    {
                        maxTowns = Math.max(Math.min(int(argsArr[2]), 1000), 10);
                    };
                    minPres3 = ((argsArr.length >= 4) ? parseInt(argsArr[3]) : 0);
                    arr = Map.listCastles(nwCorner, seCorner, minPres3);
                    arr.sort(this.sortSearchHelper);
                    msg = "<b>===== list castles =====</b>";
                    msg = (msg + ("\n" + ((arr.length == 0) ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN")));
                    count = 0;
                    for each (castle in arr)
                    {
                        if (++count > maxTowns) break;
                        level = Map.getLevel(castle.id);
                        type = Map.getType(castle.id);
                        if (((level == 10) && ((type == FieldConstants.TYPE_NPC) || (type == FieldConstants.TYPE_CASTLE))))
                        {
                            mCB = Map.getDetailInfo(castle.id);
                            if (mCB != null)
                            {
                                level = (18 - (2 * mCB.powerLevel));
                            };
                        };
                        typeStr = (((level > 10) && (type == FieldConstants.TYPE_NPC)) ? "HC" : ((type == -1) ? "" : Map.FIELD_NAMES[type]));
                        levelStr = ((level == -1) ? "" : ("" + level));
                        coordStr = Map.fieldIdToCoordinate(castle.id);
                        msg = (msg + ((((((((((((((((((((((("\n" + (int((MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100)) / 100)) + "&#9;") + Map.getRegionName(castle.id)) + "&#9;") + coordStr) + "&#9;") + typeStr) + "&#9;") + levelStr) + "&#9;") + castle.name) + "&#9;") + castle.userName) + "&#9;") + castle.allianceName) + "&#9;") + Map.getStateName(castle.state)) + "&#9;") + castle.prestige) + "&#9;") + castle.honor) + "&#9;") + castle.suzerain));
                    };
                    if (arr.length > 1000)
                    {
                        msg = (msg + ("\n" + "Warning: ONLY 1000 nearest enemy towns are shown, please use 'searchcastle alliance' instead"));
                    }
                    else
                    {
                        if (count > 100)
                        {
                            msg = (msg + ("\n" + "Notice: You may want to restrict the search result, for example: \\searchenemies 20"));
                        };
                    };
                    this.cmdLogMsg((msg + "\n<b>===== end list castles =====</b>"));
                    return;
                case "searchfields":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\searchfields name|user|alliance</b>");
                        return;
                    };
                    arr = Map.searchFields(args);
                    arr.sort(this.sortSearchHelper);
                    msg = (("<b>=== search fields for " + args) + " ===</b>");
                    msg = (msg + ("\n" + ((arr.length == 0) ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN")));
                    for each (castle in arr)
                    {
                        level = Map.getLevel(castle.id);
                        type = Map.getType(castle.id);
                        if (((level == 10) && ((type == FieldConstants.TYPE_NPC) || (type == FieldConstants.TYPE_CASTLE))))
                        {
                            mCB = Map.getDetailInfo(castle.id);
                            if (mCB != null)
                            {
                                level = (18 - (2 * mCB.powerLevel));
                            };
                        };
                        typeStr = (((level > 10) && (type == FieldConstants.TYPE_NPC)) ? "HC" : ((type == -1) ? "" : Map.FIELD_NAMES[type]));
                        levelStr = ((level == -1) ? "" : ("" + level));
                        coordStr = Map.fieldIdToCoordinate(castle.id);
                        msg = (msg + ((((((((((((((((((((((("\n" + (int((MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100)) / 100)) + "&#9;") + Map.getRegionName(castle.id)) + "&#9;") + coordStr) + "&#9;") + typeStr) + "&#9;") + levelStr) + "&#9;") + castle.name) + "&#9;") + castle.userName) + "&#9;") + castle.allianceName) + "&#9;") + Map.getStateName(castle.state)) + "&#9;") + castle.prestige) + "&#9;") + castle.honor) + "&#9;") + castle.suzerain));
                    };
                    this.cmdLogMsg((msg + "\n<b>===== end search fields =====</b>"));
                    return;
                case "searchenemyfields":
                    if (args == "")
                    {
                        args = "1000";
                    };
                    if (!Utils.hasValue(args))
                    {
                        this.cmdLogMsg("Usage: <b>\\searchenemyfields maxtowns</b>");
                        return;
                    };
                    maxTowns = int(args);
                    arr = Map.searchEnemyFields(args);
                    arr.sort(this.sortSearchHelper);
                    msg = "<b>===== search enemy fields =====</b>";
                    msg = (msg + ("\n" + ((arr.length == 0) ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN")));
                    count = 0;
                    for each (castle in arr)
                    {
                        if (++count > maxTowns) break;
                        level = Map.getLevel(castle.id);
                        type = Map.getType(castle.id);
                        if (((level == 10) && ((type == FieldConstants.TYPE_NPC) || (type == FieldConstants.TYPE_CASTLE))))
                        {
                            mCB = Map.getDetailInfo(castle.id);
                            if (mCB != null)
                            {
                                level = (18 - (2 * mCB.powerLevel));
                            };
                        };
                        typeStr = (((level > 10) && (type == FieldConstants.TYPE_NPC)) ? "HC" : ((type == -1) ? "" : Map.FIELD_NAMES[type]));
                        levelStr = ((level == -1) ? "" : ("" + level));
                        coordStr = Map.fieldIdToCoordinate(castle.id);
                        msg = (msg + ((((((((((((((((((((((("\n" + (int((MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100)) / 100)) + "&#9;") + Map.getRegionName(castle.id)) + "&#9;") + coordStr) + "&#9;") + typeStr) + "&#9;") + levelStr) + "&#9;") + castle.name) + "&#9;") + castle.userName) + "&#9;") + castle.allianceName) + "&#9;") + Map.getStateName(castle.state)) + "&#9;") + castle.prestige) + "&#9;") + castle.honor) + "&#9;") + castle.suzerain));
                    };
                    if (arr.length > 1000)
                    {
                        msg = (msg + ("\n" + "Warning: ONLY 1000 nearest enemy towns are shown, please use 'searchcastle alliance' instead"));
                    }
                    else
                    {
                        if (count > 100)
                        {
                            msg = (msg + ("\n" + "Notice: You may want to restrict the search result, for example: \\searchenemies 20"));
                        };
                    };
                    this.cmdLogMsg((msg + "\n<b>===== end search enemy fields =====</b>"));
                    return;
                case "listmail":
                    if (args == "")
                    {
                        args = "1";
                    };
                    ActionFactory.getInstance().getMailCommands().receiveMailList(int(args), MailConstants.MAIL_RECEIVE, 6, this._iq346);
                    return;
                case "listsystemmail":
                    if (args == "")
                    {
                        args = "1";
                    };
                    ActionFactory.getInstance().getMailCommands().receiveMailList(int(args), MailConstants.MAIL_SYSTEM, 6, this._iq346);
                    return;
                case "listsentmail":
                    if (args == "")
                    {
                        args = "1";
                    };
                    ActionFactory.getInstance().getMailCommands().receiveMailList(int(args), MailConstants.MAIL_SEND, 6, this._iq346);
                    return;
                case "readmail":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\readmail mailId</b>");
                        return;
                    };
                    ActionFactory.getInstance().getMailCommands().readMail(int(args), this._gd426);
                    return;
                case "mail":
                    sp1 = args.indexOf(" ");
                    sp2 = args.indexOf(" ", (sp1 + 1));
                    if (((sp1 == -1) || (sp2 == -1)))
                    {
                        this.cmdLogMsg("Usage <b>\\mail username title content</b>");
                        return;
                    };
                    username = args.substr(0, sp1);
                    username = Utils.searchAndReplace(username, "_", " ");
                    title = args.substr((sp1 + 1), ((sp2 - sp1) - 1));
                    title = Utils.searchAndReplace(title, "_", " ");
                    content = args.substr((sp2 + 1));
                    ActionFactory.getInstance().getMailCommands().sendMail(username, title, content, this.onColonyGenericResponse);
                    return;
                case "quickarmyreport":
                case "qar":
                    if (args == "")
                    {
                        args = "1";
                    };
                    this.detailReport = false;
                    ActionFactory.getInstance().getReportCommands().receiveReportList(int(args), 6, ObjConstants.REPORT_TYPE_ARMY, this._mv26);
                    return;
                case "armyreport":
                    if (args == "")
                    {
                        args = "1";
                    };
                    this.detailReport = true;
                    ActionFactory.getInstance().getReportCommands().receiveReportList(int(args), 6, ObjConstants.REPORT_TYPE_ARMY, this._mv26);
                    return;
                case "quickscoutreport":
                case "qsr":
                    if (args == "")
                    {
                        args = "1";
                    };
                    this.detailReport = false;
                    ActionFactory.getInstance().getReportCommands().receiveReportList(int(args), 6, ObjConstants.REPORT_TYPE_SCOUT, this._mv26);
                    return;
                case "scoutreport":
                    if (args == "")
                    {
                        args = "1";
                    };
                    this.detailReport = true;
                    ActionFactory.getInstance().getReportCommands().receiveReportList(int(args), 6, ObjConstants.REPORT_TYPE_SCOUT, this._mv26);
                    return;
                case "otherreport":
                    if (args == "")
                    {
                        args = "1";
                    };
                    this.detailReport = true;
                    ActionFactory.getInstance().getReportCommands().receiveReportList(int(args), 6, ObjConstants.REPORT_TYPE_OTHER, this._mv26);
                    return;
                case "readreport":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\readreport reportId</b>");
                        return;
                    };
                    ActionFactory.getInstance().getReportCommands().markAsRead(int(args), this._gc827);
                    return;
                case "warreport":
                    if (args == "")
                    {
                        args = "1";
                    };
                    ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(int(args), 6, this._ma393);
                    return;
                case "members":
                    if (args == "")
                    {
                        args = "1";
                    };
                    ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this._wn1051);
                    return;
                case "invite":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\invite nick</b>");
                        return;
                    };
                    this.cmdLogMsg((("Invite " + args) + " into your alliance"));
                    ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAlliance(args, this.handleGenericCmdResponse);
                    return;
                case "accept":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\accept nick</b>");
                        return;
                    };
                    this.cmdLogMsg(("Accept application from: " + args));
                    ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByLeader(args, this.handleGenericCmdResponse);
                    return;
                case "apply":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\apply alliance</b>");
                        return;
                    };
                    this.cmdLogMsg(("Apply into alliance: " + args));
                    ActionFactory.getInstance().getAllianceManagementCommands().userWantInAlliance(args, this.handleGenericCmdResponse);
                    return;
                case "join":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\join alliance</b>");
                        return;
                    };
                    this.cmdLogMsg(("Accept invitation to join alliance: " + args));
                    ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByUser(MainScreen.getInstance().getSelectedCity().castle.id, args, this.handleGenericCmdResponse);
                    return;
                case "eject":
                    if (args == "")
                    {
                        this.cmdLogMsg("Usage <b>\\eject nick</b>");
                        return;
                    };
                    this.cmdLogMsg((("Eject nick from alliance: <b>" + args) + "</b>"));
                    ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(args, this.handleGenericCmdResponse);
                    return;
                case "quitalliance":
                    this.cmdLogMsg((("Quit current alliance: <b>" + args) + "</b>"));
                    ActionFactory.getInstance().getAllianceManagementCommands().sayByetoAlliance(this.handleGenericCmdResponse);
                    return;
                case "qfarm":
                    this.cmdLogMsg("Start all farming waves");
                    this._kj1046();
                    return;
                case "describe":
                    this.doDescribeCmd(args);
                    return;
                case "doheronames":
                    REAddons.getInstance().doHeroNames();
                    return;
                case "doheroname":
                    REAddons.getInstance().doHeroName(MainScreen.getInstance().getSelectedCity());
                    return;
                case "qcolony":
                    this.qColony(args);
                    return;
                case "qcapitalpolicy":
                case "qcappol":
                    this.qCapitalPolicy(args);
                    return;
                case "qlistpackages":
                case "qlp":
                    this.qListPackages();
                    return;
                case "qclaimpackage":
                case "qcp":
                    this.qClaimPackage(int(args));
                    return;
                case "qclaimallpackages":
                case "qcap":
                    this.qClaimAllPackages();
                    return;
                default:
                    this.cmdLogMsg(("<b>Invalid command:</b> " + command));
                    this.cmdLogMsg("<font color='#093333'><b>available commands</b></font>:  <font color='#093333'><b>clear</b></font>commandwindow  <font color='#093333'><b>cleara</b></font>lliance<font color='#093333'><b>c</b></font>hat  <font color='#093333'><b>clearp</b></font>rivate<font color='#093333'><b>c</b></font>hat  <font color='#093333'><b>clearw</b></font>orld<font color='#093333'><b>c</b></font>hat  <font color='#093333'><b>clearsys</b></font>temlog  describe  <font color='#093333'><b>ver</b></font>sion  <font color='#093333'><b>ql</b></font>ist<font color='#093333'><b>p</b></font>ackages  <font color='#093333'><b>qc</b></font>laim<font color='#093333'><b>p</b></font>ackage  <font color='#093333'><b>qc</b></font>laim<font color='#093333'><b>a</b></font>ll<font color='#093333'><b>p</b></font>ackages  who  loc  searchcastle  searchfields  searchenemyfields  searchsuzerain  searchenemies  listcastles  getfblinks  alliance  getrelations  setfriend  setneutral  setenemy  setnorelation  sethost  setvicehost  setpresbyter  setofficer  setmember  resign  members  apply  accept  invite  join  eject  quitalliance  <font color='#093333'><b>qa</b></font>ttack  <font color='#093333'><b>qs</b></font>cout  <font color='#093333'><b>qt</b></font>ransport  <font color='#093333'><b>qr</b></font>einforce  <font color='#093333'><b>qc</b></font>olonize  <font color='#093333'><b>qd</b></font>eploy  <font color='#093333'><b>qdec</b></font>larewar  <font color='#093333'><b>qcap</b></font>ital<font color='#093333'><b>pol</b></font>icy  qcolony  qfarm  doheronames  doheroname  listmail  listsystemmail  listsentmail  readmail  mail  <font color='#093333'><b>q</b></font>uick<font color='#093333'><b>a</b></font>rmy<font color='#093333'><b>r</b></font>eport  armyreport  <font color='#093333'><b>q</b></font>uick<font color='#093333'><b>s</b></font>cout<font color='#093333'><b>r</b></font>eport  scoutreport  otherreport  readreport  warreport  fmth  fmthg  qkillwall  <font color='#093333'><b>qw</b></font>all<font color='#093333'><b>tra</b></font>p  <font color='#093333'><b>qw</b></font>all<font color='#093333'><b>ab</b></font>atis  <font color='#093333'><b>qw</b></font>all<font color='#093333'><b>a</b></font>rcher<font color='#093333'><b>t</b></font>ower  <font color='#093333'><b>qw</b></font>all<font color='#093333'><b>r</b></font>ollinglog  <font color='#093333'><b>qw</b></font>alldefensive<font color='#093333'><b>tre</b></font>buchet\n");
            };
        }

        private function cmdLogMsg(_arg_1:String):void
        {
            this.handleLogMsg.apply(null, [_arg_1]);
        }

        private function _ma393(_arg_1:MilitarySituationListResponse):void
        {
            var _local_6:MilitarySituation;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Military situation list error: " + _arg_1.errorMsg));
                return;
            };
            this.cmdLogMsg(((("Page: " + _arg_1.pageNo) + "/") + _arg_1.totalPage));
            var _local_2:String;
            var _local_3:XML;
            var _local_4:String;
            var _local_5:String;
            for each (_local_6 in _arg_1.situationsArray)
            {
                _local_2 = ((_local_6.attack) ? "ATT" : "DEF");
                _local_3 = new XML(_local_6.xml_data);
                _local_4 = _local_3.@reportUrl;
                if (_local_4 != "")
                {
                    this.cmdLogMsg(((Utils.formatUrl(((((((((((((((_local_2 + " ") + _local_6.otherAllianceName) + " ") + _local_6.eventName) + " at ") + _local_6.time) + " from ") + _local_6.startPos) + " ") + _local_3.battleReport.attackTroop.@king) + " to ") + _local_6.targetPos) + " ") + _local_3.battleReport.defendTroop.@king), _local_3.@reportUrl) + " ") + Utils.armyReportToString(_local_3.battleReport)));
                }
                else
                {
                    _local_5 = ((_local_3.battleReport.@isAttackSuccess == "true") ? "WON" : "LOST");
                    this.cmdLogMsg(((((((((((_local_2 + " ") + _local_6.otherAllianceName) + " ") + _local_6.eventName) + " at ") + _local_6.time) + " from ") + _local_6.startPos) + " ") + Utils.armyReportToString(_local_3.battleReport)));
                };
            };
        }

        private function sortSearchHelper(_arg_1:MapCastleBean, _arg_2:MapCastleBean):int
        {
            var _local_3:Number = MainScreen.getInstance().getDistanceFromClosestCastle(_arg_1.id);
            var _local_4:Number = MainScreen.getInstance().getDistanceFromClosestCastle(_arg_2.id);
            if (_local_3 < _local_4)
            {
                return (-1);
            };
            if (_local_3 > _local_4)
            {
                return (1);
            };
            return (0);
        }

        private function _gd426(_arg_1:MailResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Read mail error: " + _arg_1.errorMsg));
                return;
            };
            this.cmdLogMsg(((((((((((("[" + _arg_1.mailid) + ":") + _arg_1.sender) + ">") + _arg_1.receiver) + "] ") + _arg_1.title) + " at ") + _arg_1.receiveTime) + "\n") + _arg_1.content));
        }

        private function onGetColonyArmyInfoResponse(_arg_1:ColonialArmyResponse):void
        {
            var _local_2:ArmyBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("<b>Error received:</b> " + _arg_1.errorMsg));
                return;
            };
            if (_arg_1.armyBeansArray.length == 0)
            {
                this.cmdLogMsg("No army in colony");
            }
            else
            {
                this.cmdLogMsg("Armies found in colony");
                for each (_local_2 in _arg_1.armyBeansArray)
                {
                    MainScreen.getInstance().getSelectedCity().cityManager.logMsg(("  " + Utils.armyToString(_local_2)));
                    this.cmdLogMsg(("  " + Utils.armyToString(_local_2)));
                };
            };
        }

        private function _yr821(_arg_1:AllianceInfoResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.cmdLogMsg(("Alliance info: " + _arg_1.errorMsg));
                return;
            };
            this.cmdLogMsg(((((((((("Alliance info: " + _arg_1.allinaceInfo) + ", host: ") + _arg_1.leader) + ", creator: ") + _arg_1.creator) + ", members: ") + _arg_1.memberCount) + ", pres: ") + _arg_1.prestigeCount));
        }


    }
}//package autoevony.cmds

