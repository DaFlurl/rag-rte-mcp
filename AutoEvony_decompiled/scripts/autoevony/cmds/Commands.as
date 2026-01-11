package autoevony.cmds
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import autoevony.management.CityManager;
   import autoevony.net.Connection;
   import autoevony.player.LoginHelper;
   import autoevony.player.Map;
   import autoevony.scripts.CityState;
   import autoevony.scripts.Script;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.ArmyBean;
   import com.evony.common.beans.CastleBean;
   import com.evony.common.beans.ColonyBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.MailBean;
   import com.evony.common.beans.MapCastleBean;
   import com.evony.common.beans.MilitarySituation;
   import com.evony.common.beans.PackageBean;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.beans.ReportBean;
   import com.evony.common.beans.ResourceBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.beans.UnitAlliance;
   import com.evony.common.constants.AllianceConstants;
   import com.evony.common.constants.FieldConstants;
   import com.evony.common.constants.MailConstants;
   import com.evony.common.constants.ObjConstants;
   import com.evony.common.constants.TFConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.AllianceFriendshipResponse;
   import com.evony.common.module.alliance.AllianceInfoResponse;
   import com.evony.common.module.alliance.AllianceMembersResponse;
   import com.evony.common.module.alliance.MilitarySituationListResponse;
   import com.evony.common.module.alliance.PlayerInfoResponse;
   import com.evony.common.module.capital.CapitalCommandResponse;
   import com.evony.common.module.colony.ColonialArmyResponse;
   import com.evony.common.module.colony.ColonialDeployResponse;
   import com.evony.common.module.colony.ColonyLevyeRespone;
   import com.evony.common.module.colony.OverviewColonyCastleRespone;
   import com.evony.common.module.common.GetPackageListResponse;
   import com.evony.common.module.common.GetPackageResponse;
   import com.evony.common.module.mail.MailListResponse;
   import com.evony.common.module.mail.MailResponse;
   import com.evony.common.module.report.ReportListResponse;
   import com.evony.common.module.report.ReportResponse;
   import com.evony.common.paramBeans.NewArmyParam;
   import com.rd.REAddons;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.describeType;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   
   public class Commands
   {
      
      private var lastQFarmRun:Number = 0;
      
      private var detailReport:Boolean = false;
      
      private var handleLogMsg:Function = null;
      
      public function Commands(param1:Function)
      {
         super();
         this.handleLogMsg = param1;
      }
      
      private function onColonyGetSupSettingResponse(param1:ColonialDeployResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("<b>Error received:</b> " + param1.errorMsg);
         }
         else
         {
            this.cmdLogMsg("Suppression setting is currently " + (param1.troopBean != null ? Utils.troopBeanToMsgString(param1.troopBean) : ""));
         }
      }
      
      private function onColonyOverviewResponse(param1:OverviewColonyCastleRespone) : void
      {
         var _loc4_:HeroBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("<b>Error received:</b> " + param1.errorMsg);
            return;
         }
         var _loc2_:CastleBean = param1.castleBean;
         this.cmdLogMsg("Colony resource: g:" + Utils.abbrNum(_loc2_.resource.gold) + " f:" + Utils.abbrNum(_loc2_.resource.food.amount) + " w:" + Utils.abbrNum(_loc2_.resource.wood.amount) + " s:" + Utils.abbrNum(_loc2_.resource.stone.amount) + " i:" + Utils.abbrNum(_loc2_.resource.iron.amount));
         this.cmdLogMsg("Colony troop: " + Utils.troopStrBeanToMsgString(_loc2_.strTroop,true));
         var _loc3_:String = "";
         for each(_loc4_ in _loc2_.herosArray)
         {
            _loc3_ += " " + Utils.heroBeanToString(_loc4_);
         }
         MainScreen.getInstance().getSelectedCity().cityManager.logMsg("Colony heroes: " + _loc3_);
         this.cmdLogMsg("Colony heroes: " + _loc3_);
      }
      
      private function qListPackages() : void
      {
         ActionFactory.getInstance().getCommonCommands().getPackageList(this.listPackagesResponse);
      }
      
      private function _no1000(param1:UnitAlliance, param2:String) : String
      {
         return param2 + " " + param1.allianceName + ", host: " + param1.leaderName + ", rank " + param1.rank + ", count: " + param1.memberCount + ", pres: " + param1.aPrestigeCount + ", honor: " + param1.honor;
      }
      
      private function doQuickMarch(param1:int, param2:TroopBean, param3:int, param4:String = "", param5:ResourceBean = null, param6:String = "", param7:Boolean = false, param8:Boolean = false, param9:int = 0) : void
      {
         this.cmdLogMsg("  " + MainScreen.getInstance().getSelectedCity()._doQuickMarch(param3,param1,param4,param2,param5,param6,param7,param8,param9,this.handleGenericCmdResponse));
      }
      
      private function onGetPlayerInfoByNameResponse(param1:PlayerInfoResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("<b>Player info:</b> " + param1.errorMsg);
            return;
         }
         var _loc2_:Array = new Array("Civilian","Knight","Baronet","Baron","Viscount","Earl","Marquis","Duke","Furstin","Prinzessin");
         this.cmdLogMsg("<b>Player info:</b> " + param1.playerInfo.userName + ", sex: " + (param1.playerInfo.sex == 0 ? "Male" : "Female") + ", alliance: " + param1.playerInfo.alliance + ", castleCount: " + param1.playerInfo.castleCount + ", flag: " + param1.playerInfo.flag + ", starLvl: " + param1.playerInfo.starlv + ", pres: " + param1.playerInfo.prestige + ", honor: " + param1.playerInfo.honor + ", rank: " + param1.playerInfo.ranking + ", pos: " + param1.playerInfo.office + ", title: " + _loc2_[param1.playerInfo.titleId] + ", pop: " + param1.playerInfo.population + ", votes: " + param1.playerInfo.getvotes + ", voteHistory: " + param1.playerInfo.historygetvotes);
      }
      
      private function qColony(param1:String) : void
      {
         var op:String;
         var cB:ColonyBean;
         var currCastleId:int;
         var fieldId:int;
         var handleColonyLevyResponse:Function;
         var args:Array = null;
         var selectType:String = null;
         var levyType:String = null;
         var endStr:String = null;
         var argTroop:TroopBean = null;
         var argsStr:String = param1;
         args = argsStr.split(" ");
         var i:int = 0;
         while(i < args.length)
         {
            if(args[i] == "")
            {
               args.splice(i,1);
               if(i > 0)
               {
                  i--;
               }
            }
            i++;
         }
         if(args.length != 2 && args.length != 3)
         {
            this.cmdLogMsg("Usage: <b>\\qcolony operation target [suppressionSetting]</b>");
            return;
         }
         handleColonyLevyResponse = function(param1:ColonyLevyeRespone):void
         {
            if(param1.ok != CommandResponse.OK_DEFAULT)
            {
               cmdLogMsg("<b>Error received:</b> " + param1.errorMsg);
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
            cmdLogMsg("<b>Colony levy response:</b> " + _loc2_);
         };
         fieldId = Map.coordStringToFieldId(args[1]);
         cB = MainScreen.getInstance().getSelectedCity().cityManager.getColony(fieldId);
         if(cB == null)
         {
            this.cmdLogMsg("<b>Error:</b> Invalid colony at " + Map.fieldIdToCoordString(fieldId));
            return;
         }
         currCastleId = MainScreen.getInstance().getSelectedCity().castle.id;
         op = args[0].toString().toLowerCase().substr(0,2);
         switch(op)
         {
            case "ab":
               this.cmdLogMsg("Abandon colony " + cB.cityName + " " + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               ActionFactory.getInstance().getColonyCommands().abandonColony(currCastleId,cB.castleId,this.onColonyGenericResponse);
               break;
            case "fo":
               this.cmdLogMsg("Levy food from colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "resource";
               levyType = "Food Levied!";
               ActionFactory.getInstance().getColonyCommands().levyFood(currCastleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "ta":
               this.cmdLogMsg("Tax gold from colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "resource";
               levyType = "Gold imposed!";
               ActionFactory.getInstance().getColonyCommands().levyTaxes(currCastleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "ar":
               this.cmdLogMsg("Draft army from colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "army";
               levyType = "You have drafted ";
               endStr = " from the city.";
               ActionFactory.getInstance().getColonyCommands().levyArmy(currCastleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "po":
               this.cmdLogMsg("Redeploy population from " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "resource";
               levyType = "Population redeployed!";
               ActionFactory.getInstance().getColonyCommands().levyPopulation(currCastleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "di":
               this.cmdLogMsg("Disarm " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               selectType = "army";
               levyType = "You have disarmed ";
               endStr = " in the city.";
               ActionFactory.getInstance().getColonyCommands().reduceArmaments(currCastleId,cB.castleId,handleColonyLevyResponse);
               break;
            case "ov":
               this.cmdLogMsg("Overview colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(currCastleId,cB.castleId,this.onColonyOverviewResponse);
               break;
            case "so":
               this.cmdLogMsg("Sow discord on colony " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               ActionFactory.getInstance().getColonyCommands().sowDiscord(currCastleId,cB.castleId,this.onColonyGenericResponse);
               break;
            case "in":
               this.cmdLogMsg("Army info for " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               ActionFactory.getInstance().getColonyCommands().getColonialArmyInfo(currCastleId,cB.castleId,this.onGetColonyArmyInfoResponse);
               break;
            case "su":
               argTroop = args.length == 3 ? Utils.getTroops(args[2]) : null;
               if(argTroop != null)
               {
                  this.cmdLogMsg("Set suppression troop setting for " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName + " to " + Utils.troopBeanToMsgString(argTroop,false));
                  ActionFactory.getInstance().getColonyCommands().setDeployTroops(currCastleId,cB.castleId,argTroop,this.onColonyGenericResponse);
                  break;
               }
               this.cmdLogMsg("Get suppression troop setting for " + cB.cityName + Map.fieldIdToCoordString(fieldId) + " by " + cB.lordName + " of " + cB.allianceName);
               ActionFactory.getInstance().getColonyCommands().getDeployTroopsInfo(currCastleId,cB.castleId,this.onColonyGetSupSettingResponse);
               break;
            default:
               this.cmdLogMsg("Error: Invalid operation " + args[0] + ", must be either abandon, food, tax, army, population, disarm, overview, sowdiscord, info, suppress");
         }
      }
      
      private function _mv26(param1:ReportListResponse) : void
      {
         var timer:Timer;
         var type:String;
         var ids:Array = null;
         var report:ReportBean = null;
         var count:int = 0;
         var response:ReportListResponse = param1;
         if(response.ok != 1)
         {
            this.cmdLogMsg("Army report list error: " + response.errorMsg);
            return;
         }
         this.cmdLogMsg("Page: " + response.pageNo + "/" + response.totalPage);
         if(response.reportsArray.length == 0)
         {
            return;
         }
         ids = new Array();
         type = null;
         for each(report in response.reportsArray)
         {
            type = report.attack ? "ATT" : "DEF";
            if(this.detailReport)
            {
               ids.push(report.id);
            }
            else
            {
               this.cmdLogMsg("[" + report.id + "]" + type + " " + report.title + " from " + report.startPos + " to " + report.targetPos + " on " + report.eventTime);
            }
         }
         if(ids.length == 0)
         {
            return;
         }
         timer = new Timer(2000,ids.length);
         count = 0;
         timer.addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
         {
            handleCmd("readreport " + ids[count],false);
            ++count;
         });
         timer.start();
      }
      
      private function _iq346(param1:MailListResponse) : void
      {
         var ids:Array = null;
         var mail:MailBean = null;
         var i:int = 0;
         var handler:Function = null;
         var timer:Timer = null;
         var r:MailListResponse = param1;
         if(r.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Mail list error: " + r.errorMsg);
            return;
         }
         this.cmdLogMsg("Page: " + r.pageNo + "/" + r.totalPage);
         if(r.mailsArray.length == 0)
         {
            return;
         }
         ids = new Array();
         for each(mail in r.mailsArray)
         {
            ids.push(mail.mailid);
         }
         i = 0;
         handler = function(param1:TimerEvent):void
         {
            handleCmd("readmail " + ids[i++],false);
            if(i >= ids.length)
            {
               timer.stop();
               timer.removeEventListener(TimerEvent.TIMER,handler);
            }
         };
         timer = new Timer(2000);
         timer.repeatCount = ids.length;
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function qCapitalPolicy(param1:String) : void
      {
         var operation:String = null;
         var op:String = null;
         var currCastlePow:int = 0;
         var currCastleId:int = 0;
         var fieldId:int = 0;
         var maxPolicies:int = 0;
         var targetFieldtype:int = 0;
         var leftPolicies:int = 0;
         var getLeftPoliciesTimesResponseHandler:Function = null;
         var capitalCommandsResponseHandler:Function = null;
         var argsStr:String = param1;
         var args:Array = argsStr.split(" ");
         var i:int = 0;
         while(i < 4)
         {
            if(args[i] == "")
            {
               args.splice(i,1);
               if(i > 0)
               {
                  i--;
               }
            }
            i++;
         }
         if(args.length != 2)
         {
            this.cmdLogMsg("Usage: <b>\\qcapitalpolicy operation target</b>");
            return;
         }
         operation = args[0].toString().toLowerCase();
         op = operation.substr(0,2);
         if(op == "fo" || op == "ar" || op == "po" || op == "di" || op == "ta")
         {
            currCastlePow = MainScreen.getInstance().getSelectedCity().castle.powerlevel;
            currCastleId = MainScreen.getInstance().getSelectedCity().castle.id;
            fieldId = Map.coordStringToFieldId(args[1]);
            switch(currCastlePow)
            {
               case 4:
                  this.cmdLogMsg("<b>Error:</b> This city is not an HC. The \"\\qcapitalpolicy\" command can only be used from a Historic City.");
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
            }
            targetFieldtype = Map.getType(fieldId,60);
            if(targetFieldtype != -1)
            {
               if(targetFieldtype == FieldConstants.TYPE_CASTLE || targetFieldtype == FieldConstants.TYPE_NPC)
               {
                  getLeftPoliciesTimesResponseHandler = function(param1:CapitalCommandResponse):void
                  {
                     if(param1.ok != CommandResponse.OK_DEFAULT)
                     {
                        cmdLogMsg("<b>Error received:</b> " + param1.errorMsg);
                        return;
                     }
                     if(param1.amount <= 0)
                     {
                        cmdLogMsg("You have <b>" + param1.amount + "/" + maxPolicies + "</b> policies left for today. Capital policy operation has been cancelled because <b>\"no policies remaining\"</b>.");
                        return;
                     }
                     leftPolicies = param1.amount;
                     switch(op)
                     {
                        case "fo":
                           cmdLogMsg("Levy food for capital from " + Map.fieldIdToCoordString(fieldId));
                           ActionFactory.getInstance().getCapitalCommands().levyFood(currCastleId,fieldId,capitalCommandsResponseHandler);
                           break;
                        case "ar":
                           cmdLogMsg("Draft army for capital from " + Map.fieldIdToCoordString(fieldId));
                           ActionFactory.getInstance().getCapitalCommands().levyArmy(currCastleId,fieldId,capitalCommandsResponseHandler);
                           break;
                        case "po":
                           cmdLogMsg("Redeploy population for capital from " + Map.fieldIdToCoordString(fieldId));
                           ActionFactory.getInstance().getCapitalCommands().levyPopulation(currCastleId,fieldId,capitalCommandsResponseHandler);
                           break;
                        case "di":
                           cmdLogMsg("Disarm troops on" + Map.fieldIdToCoordString(fieldId));
                           ActionFactory.getInstance().getCapitalCommands().reduceArmaments(currCastleId,fieldId,capitalCommandsResponseHandler);
                           break;
                        case "ta":
                           cmdLogMsg("Levy tax for capital on " + Map.fieldIdToCoordString(fieldId));
                           ActionFactory.getInstance().getCapitalCommands().levyTaxes(currCastleId,fieldId,capitalCommandsResponseHandler);
                     }
                  };
                  capitalCommandsResponseHandler = function(param1:CapitalCommandResponse):void
                  {
                     if(param1.ok != CommandResponse.OK_DEFAULT)
                     {
                        cmdLogMsg("Error received: " + param1.errorMsg + (param1.errorMsg.toLowerCase().search("policy decree used") == -1 ? "" : "  [ " + (leftPolicies - 1) + "/" + maxPolicies + " policies left ]"));
                        return;
                     }
                     --leftPolicies;
                     var _loc2_:String = "<b>Capitalpolicy response</b>: ";
                     if(op == "fo")
                     {
                        _loc2_ += "Successful Food Levy. Acquire <b>" + param1.amount + " food</b>.  From " + Map.fieldIdToString(fieldId) + ".";
                     }
                     else if(op == "ta")
                     {
                        _loc2_ += "Successful Tax Imposition. Acquire <b>" + param1.amount + " gold</b>.  From " + Map.fieldIdToString(fieldId) + ".";
                     }
                     else if(op == "ar")
                     {
                        _loc2_ += "Successful Draft. Acquire <b>" + param1.amount + " " + param1.armyType + "</b>.  From " + Map.fieldIdToString(fieldId) + ".";
                     }
                     else if(op == "po")
                     {
                        _loc2_ += "Successful Pop. Redeployment. Acquire <b>" + param1.amount + " " + param1.armyType + "</b>.  From " + Map.fieldIdToString(fieldId) + ".";
                     }
                     else if(op == "di")
                     {
                        _loc2_ += "Successful Disarmament. <b>" + param1.amount + " " + param1.armyType + "</b> are disarmed.  From " + Map.fieldIdToString(fieldId) + ".";
                     }
                     else
                     {
                        _loc2_ += "Completed capitalpolicy " + operation + " on " + Map.fieldIdToString(fieldId) + ": " + param1.amount + " of type " + param1.armyType + ".";
                     }
                     _loc2_ += "  [ " + leftPolicies + "/" + maxPolicies + " policies left ]";
                     MainScreen.getCityFromCastleId(currCastleId).cityManager.warLogMsg(_loc2_);
                     cmdLogMsg(_loc2_);
                  };
                  ActionFactory.getInstance().getCapitalCommands().getLeftPoliciesTimes(currCastleId,getLeftPoliciesTimesResponseHandler);
                  return;
               }
               this.cmdLogMsg("<b>Error:</b> Target is not an NPC nor Castle: " + Map.fieldIdToCoordString(fieldId));
               return;
            }
            this.cmdLogMsg("<b>Error:</b> Map is not yet available at " + Map.fieldIdToCoordString(fieldId));
            return;
         }
         this.cmdLogMsg("<b>Invalid operation \"" + args[0] + "\"</b>, must be either  <b>fo</b>od, <b>ar</b>my, <b>po</b>pulation, <b>di</b>sarm, <b>ta</b>x");
      }
      
      private function claimPackageResponse(param1:GetPackageResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Error received: " + param1.errorMsg);
            return;
         }
         this.cmdLogMsg("Claimed the package successfully.");
         ActionFactory.getInstance().getCommonCommands().getPackageNumber(MainScreen.getInstance().setBoxNum);
      }
      
      private function listPackagesResponse(param1:GetPackageListResponse) : void
      {
         var _loc8_:Date = null;
         var _loc10_:PackageBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Error received: " + param1.errorMsg);
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
         this.cmdLogMsg("List of Gift Packages:\n<u>" + _loc5_ + " Available Unclaimed Gifts:</u>  " + _loc2_ + "\n<u>" + _loc6_ + " Already Claimed Gifts:</u>  " + _loc3_ + "\n<u>" + _loc7_ + " Other Unclaimed Gifts:</u>  " + _loc4_);
      }
      
      private function clearChatLog(param1:String) : void
      {
         MainScreen.getInstance()._chatPanel.clear(true,param1);
      }
      
      private function doShortCmds(param1:String, param2:String) : void
      {
         var _loc6_:TroopBean = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         var _loc7_:ResourceBean = null;
         var _loc8_:String = "";
         var _loc9_:Array = param2.replace(/;/g,":").split(" ");
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         while(_loc11_ < _loc9_.length)
         {
            if(_loc9_[_loc11_] == "")
            {
               _loc9_.splice(_loc11_,1);
               if(_loc11_ > 0)
               {
                  _loc11_--;
               }
            }
            _loc11_++;
         }
         switch(param1)
         {
            case "ver":
            case "version":
               this.cmdLogMsg(Version.getVersionStr(true));
               break;
            case "qa":
            case "qattack":
               if(_loc9_.length != 3 && _loc9_.length != 4)
               {
                  this.cmdLogMsg("Usage: \\[qa]ttack target hero troop [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_OCCUPY;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc5_ = _loc9_[1];
               _loc6_ = Utils.getTroops(_loc9_[2]);
               if(_loc9_.length == 4)
               {
                  _loc8_ = _loc9_[3];
               }
               if(_loc6_ == null)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[2]);
                  return;
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_);
               break;
            case "qaa":
            case "qaattack":
               if(_loc9_.length != 3 && _loc9_.length != 4)
               {
                  this.cmdLogMsg("Usage: \\[qaa]ttack target hero troop [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_OCCUPY;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc5_ = _loc9_[1];
               _loc6_ = Utils.getTroops(_loc9_[2]);
               if(_loc9_.length == 4)
               {
                  _loc8_ = _loc9_[3];
               }
               if(_loc6_ == null)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[2]);
                  return;
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_,false,false,2);
               break;
            case "qr":
            case "qreinforce":
               if(_loc9_.length < 3 || _loc9_.length > 5)
               {
                  this.cmdLogMsg("Usage: \\[qr]einforce target hero troop [resource] [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_SEND;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc5_ = _loc9_[1];
               _loc6_ = Utils.getTroops(_loc9_[2]);
               if(_loc6_ == null)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[2]);
                  return;
               }
               if(_loc9_.length > 3 && _loc9_[3] != "none")
               {
                  _loc7_ = Utils.getEstResoBean(_loc9_[3]);
                  if(_loc7_ == null)
                  {
                     this.cmdLogMsg("Invalid resource: " + _loc9_[3]);
                     return;
                  }
               }
               if(_loc9_.length > 4)
               {
                  _loc8_ = _loc9_[4];
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_);
               break;
            case "qs":
            case "qscout":
               if(_loc9_.length != 3 && _loc9_.length != 4)
               {
                  this.cmdLogMsg("Usage: \\[qs]cout target hero troop [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_SCOUT;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc5_ = _loc9_[1];
               _loc6_ = Utils.getTroops(_loc9_[2]);
               if(_loc9_.length == 4)
               {
                  _loc8_ = _loc9_[3];
               }
               if(_loc6_ == null || _loc6_.scouter == 0)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[2]);
                  return;
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_);
               break;
            case "qas":
            case "qascout":
               if(_loc9_.length != 3 && _loc9_.length != 4)
               {
                  this.cmdLogMsg("Usage: \\[qas]cout target hero troop [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_SCOUT;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc5_ = _loc9_[1];
               _loc6_ = Utils.getTroops(_loc9_[2]);
               if(_loc9_.length == 4)
               {
                  _loc8_ = _loc9_[3];
               }
               if(_loc6_ == null || _loc6_.scouter == 0)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[2]);
                  return;
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_,false,false,2);
               break;
            case "qc":
            case "qcolonize":
               if(_loc9_.length != 3 && _loc9_.length != 4)
               {
                  this.cmdLogMsg("Usage: \\[qc]olonize target hero troop [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_COLONIZE;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc5_ = _loc9_[1];
               _loc6_ = Utils.getTroops(_loc9_[2]);
               if(_loc9_.length == 4)
               {
                  _loc8_ = _loc9_[3];
               }
               if(_loc6_ == null)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[2]);
                  return;
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_);
               break;
            case "qac":
            case "qacolonize":
               if(_loc9_.length != 3 && _loc9_.length != 4)
               {
                  this.cmdLogMsg("Usage: \\[qac]olonize target hero troop [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_COLONIZE;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc5_ = _loc9_[1];
               _loc6_ = Utils.getTroops(_loc9_[2]);
               if(_loc9_.length == 4)
               {
                  _loc8_ = _loc9_[3];
               }
               if(_loc6_ == null)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[2]);
                  return;
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_,false,false,2);
               break;
            case "qt":
            case "qtransport":
               if(_loc9_.length != 3 && _loc9_.length != 4)
               {
                  this.cmdLogMsg("Usage: \\[qt]ransport target troop resource [camptime]");
                  break;
               }
               _loc3_ = ObjConstants.ARMY_MISSION_TRANS;
               _loc4_ = Map.coordStringToFieldId(_loc9_[0]);
               _loc6_ = Utils.getTroops(_loc9_[1]);
               _loc7_ = Utils.getEstResoBean(_loc9_[2]);
               if(_loc9_.length == 4)
               {
                  _loc8_ = _loc9_[3];
               }
               if(_loc6_ == null)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[1]);
                  return;
               }
               if(_loc7_ == null)
               {
                  this.cmdLogMsg("Invalid resource: " + _loc9_[2]);
                  return;
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc8_);
               break;
            case "qd":
            case "qdeploy":
               if(_loc9_.length < 4 || _loc9_.length > 9)
               {
                  this.cmdLogMsg("Usage: \\[qd]eploy operation target hero troop [resource] [camptime] [useWarEnsign] [useHordeBanner] [autoGear]");
                  break;
               }
               _loc3_ = CityState.getMissionConstFromString(_loc9_[0]);
               _loc4_ = Map.coordStringToFieldId(_loc9_[1]);
               _loc5_ = _loc9_[2];
               _loc6_ = Utils.getTroops(_loc9_[3]);
               if(_loc6_ == null)
               {
                  this.cmdLogMsg("Invalid troop: " + _loc9_[3]);
                  return;
               }
               if(_loc9_.length > 4 && _loc9_[4] != "none")
               {
                  _loc7_ = Utils.getEstResoBean(_loc9_[4]);
                  if(_loc7_ == null)
                  {
                     this.cmdLogMsg("Invalid resource: " + _loc9_[4]);
                     return;
                  }
               }
               this.doQuickMarch(_loc4_,_loc6_,_loc3_,_loc5_,_loc7_,_loc9_.length > 5 ? _loc9_[5] : "",_loc9_.length > 6 ? (_loc9_[6] == "true" ? true : false) : false,_loc9_.length > 7 ? (_loc9_[7] == "true" ? true : false) : false,_loc9_.length > 8 ? int(_loc9_[8]) : 0);
               break;
            case "qdec":
            case "qdeclarewar":
               if(_loc9_.length == 1)
               {
                  _loc10_ = Map.coordStringToFieldId(_loc9_[0]);
                  if(_loc10_ != -1)
                  {
                     MainScreen.getInstance().getSelectedCity()._declareWar(_loc10_);
                  }
                  break;
               }
               this.cmdLogMsg("Usage: \\[qdec]larewar target");
               break;
            case "qkillwall":
               MainScreen.getInstance().getSelectedCity()._qKillWall();
               break;
            case "qwtra":
            case "qwalltrap":
            case "qwalltraps":
               if(_loc9_.length == 1)
               {
                  _loc10_ = int(_loc9_[0]);
                  if(_loc10_ != 0)
                  {
                     MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_TRAP,_loc10_);
                  }
                  break;
               }
               this.cmdLogMsg("Usage: \\qwtra [No of Traps]");
               break;
            case "qwab":
            case "qwallabatis":
               if(_loc9_.length == 1)
               {
                  _loc10_ = int(_loc9_[0]);
                  if(_loc10_ != 0)
                  {
                     MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ABATIS,_loc10_);
                  }
                  break;
               }
               this.cmdLogMsg("Usage: \\qwab [No of abatis]");
               break;
            case "qwat":
            case "qwallarchertower":
            case "qwallarchertowers":
               if(_loc9_.length == 1)
               {
                  _loc10_ = int(_loc9_[0]);
                  if(_loc10_ != 0)
                  {
                     MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ARROWTOWER,_loc10_);
                  }
                  break;
               }
               this.cmdLogMsg("Usage: \\qwat [No of archer tower]");
               break;
            case "qwr":
            case "qwrl":
            case "qwallrollinglog":
            case "qwallrollinglogs":
               if(_loc9_.length == 1)
               {
                  _loc10_ = int(_loc9_[0]);
                  if(_loc10_ != 0)
                  {
                     MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ROLLINGLOGS,_loc10_);
                  }
                  break;
               }
               this.cmdLogMsg("Usage: \\qwr [No of rolling logs]");
               break;
            case "qwtre":
            case "qwtreb":
            case "qwtrebs":
            case "qwtrebuchets":
            case "qwdefensivetrebuchet":
            case "qwdefensivetrebuchets":
               if(_loc9_.length == 1)
               {
                  _loc10_ = int(_loc9_[0]);
                  if(_loc10_ != 0)
                  {
                     MainScreen.getInstance().getSelectedCity()._qWallDefenseNow(TFConstants.F_ROCKFALL,_loc10_);
                  }
                  break;
               }
               this.cmdLogMsg("Usage: \\qwtre [No of trebs]");
               break;
            default:
               this.cmdLogMsg("Invalid command: " + param1);
         }
      }
      
      private function handleGenericCmdResponse(param1:Object) : void
      {
         if(param1.ok == undefined)
         {
            this.cmdLogMsg("BUG: Bad use of handle generic response");
         }
         else if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Error Generic: " + param1.errorMsg);
         }
      }
      
      private function qClaimPackage(param1:int) : void
      {
         ActionFactory.getInstance().getCommonCommands().getPackage(param1,"",this.claimPackageResponse);
      }
      
      public function _kj1046(param1:Boolean = true) : void
      {
         var arr:Array;
         var newDate:Date = null;
         var nextQFarmAllowed:Boolean = false;
         var qFarmError:Boolean = false;
         var qFarmCount:int = 0;
         var allArmies:Array = null;
         var army:NewArmyParam = null;
         var obj:Object = null;
         var city:CityState = null;
         var timer:Timer = null;
         var count5s:int = 0;
         var lastManager:CityManager = null;
         var release:Function = null;
         var handler:Function = null;
         var inline:Boolean = param1;
         newDate = new Date();
         if(inline && this.lastQFarmRun > newDate.getTime() - 5 * 1000)
         {
            MainScreen.getInstance().logMsg("qfarm was executed within the last 5 seconds, please try again later");
            return;
         }
         nextQFarmAllowed = true;
         qFarmError = false;
         qFarmCount = 0;
         allArmies = new Array();
         army = null;
         arr = null;
         obj = null;
         for each(city in MainScreen.getCities())
         {
            arr = city.cityManager._doQFarm();
            if(arr == null)
            {
               qFarmError = true;
            }
            else
            {
               for each(army in arr)
               {
                  obj = new Object();
                  obj.manager = city.cityManager;
                  obj.army = army;
                  allArmies.push(obj);
               }
            }
         }
         timer = new Timer(100);
         count5s = 0;
         lastManager = null;
         release = function(param1:CommandResponse):void
         {
            nextQFarmAllowed = true;
         };
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_NEW_ARMY,release);
         handler = function(param1:TimerEvent):void
         {
            var event:TimerEvent = param1;
            var success:Boolean = false;
            var manager:CityManager = null;
            newDate = new Date();
            lastQFarmRun = newDate.getTime();
            if(!Connection.getInstance().authenticated)
            {
               allArmies = new Array();
               lastManager = null;
               return;
            }
            ++count5s;
            if(count5s == 50)
            {
               nextQFarmAllowed = true;
            }
            if(nextQFarmAllowed)
            {
               nextQFarmAllowed = false;
               count5s = 0;
               if(allArmies.length == 0)
               {
                  if(inline)
                  {
                     if(qFarmError)
                     {
                        cmdLogMsg("qfarm: Map is not yet ready for all towns, " + qFarmCount + " waves sent");
                     }
                     else
                     {
                        cmdLogMsg("qfarm: " + qFarmCount + " waves are sent out according to your goals");
                     }
                  }
                  ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ARMY_NEW_ARMY,release);
                  timer.removeEventListener(TimerEvent.TIMER,handler);
                  timer.stop();
                  return;
               }
               obj = allArmies.shift();
               manager = obj.manager;
               army = obj.army;
               success = manager._sendQuickArmy(army,manager == lastManager,function(param1:CommandResponse):void
               {
                  if(param1.ok != 1)
                  {
                     cmdLogMsg("QFarm partial response: " + param1.errorMsg);
                  }
               });
               lastManager = manager;
               if(success)
               {
                  ++qFarmCount;
               }
            }
         };
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      private function formatTypeStr(param1:String) : String
      {
         if(param1.charAt(0) == "_")
         {
            return "*";
         }
         if(param1.indexOf("::") != -1)
         {
            param1 = param1.substr(param1.indexOf("::") + 2);
         }
         return param1;
      }
      
      private function onColonyGenericResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("<b>Error received:</b> " + param1.errorMsg);
         }
      }
      
      private function _gc827(param1:ReportResponse) : void
      {
         var _loc5_:String = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Read report/mark as read error: " + param1.errorMsg);
            return;
         }
         var _loc2_:ReportBean = param1.report;
         var _loc3_:String = _loc2_.attack ? "ATT" : "DEF";
         var _loc4_:XML = new XML(_loc2_.content);
         if(_loc2_.armyType == ObjConstants.ARMY_MISSION_SCOUT)
         {
            this.cmdLogMsg(Utils.formatUrl(_loc3_ + " " + _loc2_.title + " on " + _loc2_.eventTime + " from " + _loc2_.startPos + " to " + _loc2_.targetPos,_loc4_.@reportUrl));
            if(_loc2_.attack && _loc4_.scoutReport.@isSuccess == "true")
            {
               this.cmdLogMsg("  " + CityManager._wd318(_loc4_.scoutReport));
            }
         }
         else if(_loc2_.armyType == ObjConstants.ARMY_MISSION_COLONIZE || _loc2_.armyType == ObjConstants.ARMY_MISSION_OCCUPY)
         {
            this.cmdLogMsg(Utils.formatUrl(_loc3_ + " " + _loc2_.title + " on " + _loc2_.eventTime + " from " + _loc2_.startPos + " to " + _loc2_.targetPos,_loc4_.@reportUrl));
            this.cmdLogMsg("  " + Utils.armyReportToString(_loc4_.battleReport));
         }
         else if(_loc2_.type == 2)
         {
            _loc5_ = _loc4_.policyReport.@detail;
            if(_loc2_.content.indexOf("<") == -1)
            {
               this.cmdLogMsg("@" + _loc2_.title + " on " + _loc2_.eventTime + " " + _loc2_.content);
            }
            else if(_loc5_ != "")
            {
               this.cmdLogMsg("@" + _loc2_.title + " on " + _loc2_.eventTime + " " + _loc5_);
            }
            else
            {
               _loc5_ = _loc2_.content;
               _loc5_ = _loc5_.split("<").join("[");
               _loc5_ = _loc5_.split(">").join("]");
               this.cmdLogMsg("@" + _loc2_.title + " on " + _loc2_.eventTime + " " + _loc5_);
            }
         }
         else
         {
            this.cmdLogMsg("Unknown report: " + _loc2_.type + " " + _loc2_.title + " on " + _loc2_.eventTime + " from " + _loc2_.startPos + " to " + _loc2_.targetPos);
         }
      }
      
      private function qClaimAllPackages() : void
      {
         ActionFactory.getInstance().getCommonCommands().getPackageList(this.qClaimAllPackagesHandler);
      }
      
      private function doDescribeCmd(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = null;
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:* = undefined;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:* = undefined;
         if(param1 == "")
         {
            this.cmdLogMsg("Usage \\describe internal_var");
         }
         else
         {
            _loc2_ = MainScreen.getInstance().getSelectedCity()._getScript().getValue(param1);
            if(_loc2_ == Script.BADOBJECT)
            {
               this.cmdLogMsg("Invalid internal variable/method: " + param1);
            }
            else
            {
               _loc3_ = "";
               _loc4_ = "";
               _loc5_ = describeType(_loc2_);
               _loc6_ = new Array();
               _loc7_ = new Array();
               for each(_loc8_ in _loc5_.variable)
               {
                  _loc4_ = _loc8_.@name;
                  if(_loc4_.charAt(0) != "_")
                  {
                     _loc3_ = "<b>" + _loc4_ + "</b>" + ":" + this.formatTypeStr(_loc8_.@type);
                     _loc6_.push(_loc3_);
                  }
               }
               for each(_loc8_ in _loc5_.accessor)
               {
                  _loc4_ = _loc8_.@name;
                  if(_loc4_.charAt(0) != "_")
                  {
                     _loc3_ = "<b>" + _loc4_ + "</b>" + ":" + this.formatTypeStr(_loc8_.@type);
                     _loc6_.push(_loc3_);
                  }
               }
               _loc9_ = false;
               for each(_loc8_ in _loc5_.method)
               {
                  _loc4_ = _loc8_.@name;
                  if(!(_loc4_.charAt(0) == "_" || _loc4_ == "addEventListener" || _loc4_ == "dispatchEvent" || _loc4_ == "hasEventListener" || _loc4_ == "removeEventListener" || _loc4_ == "willTrigger"))
                  {
                     _loc3_ = "<b>" + _loc4_ + "(</b>";
                     _loc9_ = true;
                     for each(_loc11_ in _loc8_.parameter)
                     {
                        if(!_loc9_)
                        {
                           _loc3_ += ",";
                        }
                        _loc9_ = false;
                        if(_loc11_.@optional == "true")
                        {
                           _loc3_ += "[";
                        }
                        _loc3_ += this.formatTypeStr(_loc11_.@type);
                        if(_loc11_.@optional == "true")
                        {
                           _loc3_ += "]";
                        }
                     }
                     _loc3_ += "<b>)</b>:" + this.formatTypeStr(_loc8_.@returnType);
                     _loc7_.push(_loc3_);
                  }
               }
               if(_loc6_.length > 0)
               {
                  _loc6_.sort(Array.CASEINSENSITIVE);
               }
               if(_loc7_.length > 0)
               {
                  _loc7_.sort(Array.CASEINSENSITIVE);
               }
               _loc3_ = "\n  ----------&lt; VARIABLES &gt;----------";
               _loc10_ = 0;
               while(_loc10_ < _loc6_.length)
               {
                  _loc3_ += "\n" + _loc6_[_loc10_];
                  _loc10_++;
               }
               _loc3_ += "\n\n  ----------&lt; METHODS &gt;----------";
               _loc10_ = 0;
               while(_loc10_ < _loc7_.length)
               {
                  _loc3_ += "\n" + _loc7_[_loc10_];
                  _loc10_++;
               }
               this.cmdLogMsg("<font color=\'#092D2D\'> ========== Description of <b>" + param1 + "</b> ==========\n</font>" + _loc3_ + "\n");
            }
         }
      }
      
      private function getFbLinks(param1:String = null) : void
      {
         var errorHandler:Function;
         var handler:Function;
         var httpReq:HTTPService;
         var linkNames:Array = null;
         var args:Array = null;
         var i:int = 0;
         var arg:String = param1;
         var fbId:String = MainScreen.getPlayer().playerInfo.facebookId;
         if(fbId == null || fbId == "null" || fbId == "")
         {
            this.cmdLogMsg("<b>Command failed:</b> Missing facebookId value. Please make sure this account is attached to a Facebook account before using this command.");
            return;
         }
         if(arg != null && arg != "")
         {
            linkNames = new Array("hnm","lb","bp","wh","aa","bw");
            args = arg.toLowerCase().split(",");
            i = 0;
            while(i < args.length)
            {
               if(linkNames.indexOf(args[i]) == -1)
               {
                  this.cmdLogMsg("<b>Command failed:</b> Bad value \"<b>" + args[i] + "</b>\" entered in desired link list.\nValid Options are: HNM,LB,BP,WH,AA,BW");
                  return;
               }
               i++;
            }
         }
         handler = function(param1:ResultEvent):void
         {
            var _loc2_:XML = new XML(param1.message.body.toString());
            if(int(_loc2_.response.@ok) < 1)
            {
               cmdLogMsg("<b>Command failed. Error recieved:</b> " + _loc2_.response.@message);
               return;
            }
            var _loc3_:* = "Remaining time until new fbLinks: " + Utils.formatTime(int(Number(_loc2_.response.@timeUntilNextReq) / 1000)) + "\nDisplaying " + (args != null && args.length > 0 ? args.length : 6) + " fb links:\n";
            if(args == null || args.length == 0 || args.indexOf("hnm") != -1)
            {
               _loc3_ += "\n<b><u>Hungry No More link</u></b>:\n" + _loc2_.response.@hnmLnk;
            }
            if(args == null || args.length == 0 || args.indexOf("lb") != -1)
            {
               _loc3_ += "\n<b><u>Legendary Bard link</u></b>:\n" + _loc2_.response.@bardLnk;
            }
            if(args == null || args.length == 0 || args.indexOf("bp") != -1)
            {
               _loc3_ += "\n<b><u>Black Plague link</u></b>:\n" + _loc2_.response.@plagueLnk;
            }
            if(args == null || args.length == 0 || args.indexOf("wh") != -1)
            {
               _loc3_ += "\n<b><u>Wild Horses link</u></b>:\n" + _loc2_.response.@wildHorsesLnk;
            }
            if(args == null || args.length == 0 || args.indexOf("aa") != -1)
            {
               _loc3_ += "\n<b><u>Ancient Artifact link</u></b>:\n" + _loc2_.response.@artifactLnk;
            }
            if(args == null || args.length == 0 || args.indexOf("bw") != -1)
            {
               _loc3_ += "\n<b><u>Buxom Wenches link</u></b>:\n" + _loc2_.response.@wenchesLnk;
            }
            _loc3_ += "\n";
            cmdLogMsg(_loc3_);
         };
         errorHandler = function(param1:FaultEvent):void
         {
            cmdLogMsg("<b>The following error has occurred:</b> " + param1.fault.faultString);
         };
         httpReq = new HTTPService();
         httpReq.url = "http://evonystuff.com/rqstFbLnks/getFbLnk.asp";
         httpReq.method = "POST";
         httpReq.resultFormat = HTTPService.RESULT_FORMAT_XML;
         httpReq.contentType = HTTPService.CONTENT_TYPE_FORM;
         httpReq.method = "POST";
         httpReq.addEventListener(ResultEvent.RESULT,handler);
         httpReq.addEventListener(FaultEvent.FAULT,errorHandler);
         httpReq.send({
            "fbId":fbId + "",
            "sName":LoginHelper.getInstance().server + ""
         });
      }
      
      private function _yr516(param1:PlayerInfoBean, param2:PlayerInfoBean) : int
      {
         if(param1.lastLoginTime > param2.lastLoginTime)
         {
            return -1;
         }
         if(param1.lastLoginTime < param2.lastLoginTime)
         {
            return 1;
         }
         return 0;
      }
      
      private function _is776(param1:AllianceFriendshipResponse) : void
      {
         var _loc2_:UnitAlliance = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("<b>Alliance relationship:</b> " + param1.errorMsg);
            return;
         }
         for each(_loc2_ in param1.friendlyListArray)
         {
            this.cmdLogMsg(this._no1000(_loc2_,"friend"));
         }
         for each(_loc2_ in param1.middleListArray)
         {
            this.cmdLogMsg(this._no1000(_loc2_,"neutral"));
         }
         for each(_loc2_ in param1.enemyListArray)
         {
            this.cmdLogMsg(this._no1000(_loc2_,"enemy"));
         }
      }
      
      private function qClaimAllPackagesHandler(param1:GetPackageListResponse) : void
      {
         var ids:Array = null;
         var pkg:PackageBean = null;
         var i:int = 0;
         var handler:Function = null;
         var claimPkg:Function = null;
         var r:GetPackageListResponse = param1;
         if(r.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Error received: " + r.errorMsg);
            return;
         }
         if(r.packagesArray == null || r.packagesArray.length == 0)
         {
            this.cmdLogMsg("Received empty package list from server.");
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
            this.cmdLogMsg("No available packages received from server. Nothing to claim.");
            return;
         }
         this.cmdLogMsg("Attempting to claim " + ids.length + " packages...");
         i = 0;
         handler = function(param1:GetPackageResponse):void
         {
            ++i;
            if(param1.ok == GetPackageResponse.ERROR_PACKAGE_EXPIRED)
            {
               cmdLogMsg("ERROR while claiming package " + i + " with id: " + ids[i] + ": " + param1.errorMsg);
            }
            else if(param1.ok == GetPackageResponse.ERROR_PACKAGE_NOT_EXISTS)
            {
               cmdLogMsg("ERROR while claiming package " + i + " with id: " + ids[i] + ": " + param1.errorMsg);
            }
            else if(param1.ok == GetPackageResponse.ERROR_REQUIRMENT_NOT_MET)
            {
               cmdLogMsg("ERROR while claiming package " + i + " with id: " + ids[i] + ": " + param1.errorMsg);
            }
            else
            {
               cmdLogMsg("Successfully claimed package " + i + " with id: " + ids[i]);
            }
            if(i < ids.length)
            {
               Utils.callLater(50,claimPkg);
            }
            else
            {
               cmdLogMsg("Completed attempting to claim " + ids.length + " packages.");
               ActionFactory.getInstance().getCommonCommands().getPackageNumber(MainScreen.getInstance().setBoxNum);
            }
         };
         claimPkg = function(param1:TimerEvent = null):void
         {
            ActionFactory.getInstance().getCommonCommands().getPackage(ids[i],"",handler);
         };
         Utils.callLater(50,claimPkg);
      }
      
      public function doCmd(param1:String, param2:Boolean = true) : void
      {
         this.handleCmd(param1,param2);
      }
      
      private function _wn1051(param1:AllianceMembersResponse) : void
      {
         var _loc2_:Date = null;
         var _loc3_:PlayerInfoBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Alliance members error: " + param1.errorMsg);
            return;
         }
         param1.membersArray.source.sort(this._yr516);
         this.cmdLogMsg("Alliance members: ");
         for each(_loc3_ in param1.membersArray)
         {
            _loc2_ = new Date(_loc3_.lastLoginTime);
            this.cmdLogMsg(" " + _loc3_.userName + " " + _loc3_.allianceLevel + " pres: " + _loc3_.prestige + " last: " + _loc2_.toLocaleString());
         }
      }
      
      private function handleCmd(param1:String, param2:Boolean = true) : void
      {
         var args:String = null;
         var level:int = 0;
         var type:int = 0;
         var typeStr:String = null;
         var levelStr:String = null;
         var coordStr:String = null;
         var argsArr:Array = null;
         var fieldId:int = 0;
         var func:Function = null;
         var t:Timer = null;
         var minPres3:int = 0;
         var sp1:int = 0;
         var sp2:int = 0;
         var username:String = null;
         var title:String = null;
         var content:String = null;
         var cmdStr:String = param1;
         var external:Boolean = param2;
         var command:String = cmdStr;
         args = "";
         var msg:String = "";
         var count:int = 0;
         var maxTowns:int = 1000;
         var arr:Array = null;
         var castle:MapCastleBean = null;
         var varTmpYB42:CityState = null;
         var mCB:MapCastleBean = null;
         var nwCorner:int = -1;
         var seCorner:int = -1;
         var sp:int = int(cmdStr.indexOf(" "));
         if(sp != -1)
         {
            command = cmdStr.substr(0,sp);
            args = cmdStr.substr(sp + 1);
         }
         if(external)
         {
            this.cmdLogMsg("Command: " + cmdStr);
         }
         switch(command)
         {
            case "clear":
            case "clearcommandwindow":
               this.clearChatLog("commandText");
               break;
            case "clearac":
            case "clearalliancechat":
               this.clearChatLog("aChatText");
               break;
            case "clearpc":
            case "clearprivatechat":
               this.clearChatLog("pChatText");
               break;
            case "clearwc":
            case "clearworldchat":
               this.clearChatLog("wChatText");
               break;
            case "clearsys":
            case "clearsystemlog":
               this.clearChatLog("systemText");
               break;
            case "who":
               ActionFactory.getInstance().getCommonCommands().getPlayerInfoByName(Utils.trim(args),this.onGetPlayerInfoByNameResponse);
               break;
            case "fmth":
               MainScreen.getInstance().getSelectedCity().cityManager._forceTrainingHeroMove();
               break;
            case "fmthg":
               CityManager.deletePlayerTiming("movetraininghero");
               break;
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
               this.doShortCmds(command,args);
               break;
            case "getfblinks":
               this.getFbLinks(args);
               break;
            case "alliance":
               ActionFactory.getInstance().getAllianceCommands().getAllianceInfo(Utils.trim(args),this._yr821);
               break;
            case "getrelations":
               ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList(this._is776);
               break;
            case "setenemy":
               ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(Utils.trim(args),AllianceConstants.ENEMY_ALLIANCE,this.handleGenericCmdResponse);
               break;
            case "setfriend":
               ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(Utils.trim(args),AllianceConstants.FRIEND_ALLIANCE,this.handleGenericCmdResponse);
               break;
            case "setneutral":
               ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(Utils.trim(args),AllianceConstants.MIDDLE_ALLIANCE,this.handleGenericCmdResponse);
               break;
            case "setnorelation":
               ActionFactory.getInstance().getAllianceManagementCommands().dropAllianceFriendshipRelation(Utils.trim(args),this.handleGenericCmdResponse);
               break;
            case "sethost":
               ActionFactory.getInstance().getAllianceManagementCommands().resetTopPowerForAlliance(Utils.trim(args),this.handleGenericCmdResponse);
               break;
            case "setvicehost":
               ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args),AllianceConstants.TOP2_POWER_FOR_ALLIANCE,this.handleGenericCmdResponse);
               break;
            case "setpresbyter":
               ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args),AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE,this.handleGenericCmdResponse);
               break;
            case "setofficer":
               ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args),AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE,this.handleGenericCmdResponse);
               break;
            case "setmember":
               ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(Utils.trim(args),AllianceConstants.LAST_POWER_FOR_ALLIANCE,this.handleGenericCmdResponse);
               break;
            case "resign":
               ActionFactory.getInstance().getAllianceManagementCommands().resignForAlliance(this.handleGenericCmdResponse);
               break;
            case "loc":
               fieldId = Map.coordStringToFieldId(Utils.trim(args));
               if(fieldId == -1)
               {
                  this.cmdLogMsg("Invalid location: " + args);
                  return;
               }
               Map.updateInfo(fieldId);
               Map.updateDetailInfo(fieldId);
               func = function(param1:TimerEvent):void
               {
                  var _loc2_:MapCastleBean = Map.getDetail(fieldId);
                  if(Map.getType(fieldId) == -1 || _loc2_ == null)
                  {
                     return;
                  }
                  cmdLogMsg("Location info: " + args + ": " + Map.fieldIdToString(fieldId) + " " + Map.getStateName(_loc2_.state) + ", " + _loc2_.name + " " + _loc2_.zoneName + ", belongs to " + (_loc2_.userName == null ? "none" : _loc2_.userName + " [" + _loc2_.allianceName + "], pres: " + _loc2_.prestige + ", honor: " + _loc2_.honor + ", suz: " + _loc2_.suzerain));
                  t.stop();
                  t.removeEventListener(TimerEvent.TIMER,func);
               };
               t = new Timer(500,20);
               t.addEventListener(TimerEvent.TIMER,func);
               t.start();
               break;
            case "searchcastle":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\searchcastle name|user|alliance [NwCoord] [SeCoord]</b>");
                  return;
               }
               argsArr = args.split(" ");
               if(argsArr.length == 3)
               {
                  nwCorner = Map.coordStringToFieldId(argsArr[1]);
                  seCorner = Map.coordStringToFieldId(argsArr[2]);
               }
               if(argsArr.length == 1 || nwCorner == -1 || seCorner == -1)
               {
                  arr = Map.searchCastles(args);
               }
               else
               {
                  arr = Map.searchCastlesWithinArea(String(argsArr[0]).split("_").join(" "),nwCorner,seCorner);
               }
               arr.sort(this.sortSearchHelper);
               msg = "<b>=== search castle for " + args + " ===</b>";
               msg += "\n" + (arr.length == 0 ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN");
               for each(castle in arr)
               {
                  level = Map.getLevel(castle.id);
                  type = Map.getType(castle.id);
                  if(level == 10 && (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE))
                  {
                     mCB = Map.getDetailInfo(castle.id);
                     if(mCB != null)
                     {
                        level = 18 - 2 * mCB.powerLevel;
                     }
                  }
                  typeStr = level > 10 && type == FieldConstants.TYPE_NPC ? "HC" : (type == -1 ? "" : Map.FIELD_NAMES[type]);
                  levelStr = level == -1 ? "" : "" + level;
                  coordStr = Map.fieldIdToCoordinate(castle.id);
                  msg += "\n" + int(MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100) / 100 + "&#9;" + Map.getRegionName(castle.id) + "&#9;" + coordStr + "&#9;" + typeStr + "&#9;" + levelStr + "&#9;" + castle.name + "&#9;" + castle.userName + "&#9;" + castle.allianceName + "&#9;" + Map.getStateName(castle.state) + "&#9;" + castle.prestige + "&#9;" + castle.honor + "&#9;" + castle.suzerain;
               }
               this.cmdLogMsg(msg + "\n<b>===== end search =====</b>");
               break;
            case "searchsuzerain":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\searchsuzerain user</b>");
                  return;
               }
               arr = Map.searchSuzerain(args);
               arr.sort(this.sortSearchHelper);
               msg = "<b>=== search suzerain for " + args + " ===</b>";
               msg += "\n" + (arr.length == 0 ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN");
               for each(castle in arr)
               {
                  level = Map.getLevel(castle.id);
                  type = Map.getType(castle.id);
                  if(level == 10 && (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE))
                  {
                     mCB = Map.getDetailInfo(castle.id);
                     if(mCB != null)
                     {
                        level = 18 - 2 * mCB.powerLevel;
                     }
                  }
                  typeStr = level > 10 && type == FieldConstants.TYPE_NPC ? "HC" : (type == -1 ? "" : Map.FIELD_NAMES[type]);
                  levelStr = level == -1 ? "" : "" + level;
                  coordStr = Map.fieldIdToCoordinate(castle.id);
                  msg += "\n" + int(MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100) / 100 + "&#9;" + Map.getRegionName(castle.id) + "&#9;" + coordStr + "&#9;" + typeStr + "&#9;" + levelStr + "&#9;" + castle.name + "&#9;" + castle.userName + "&#9;" + castle.allianceName + "&#9;" + Map.getStateName(castle.state) + "&#9;" + castle.prestige + "&#9;" + castle.honor + "&#9;" + castle.suzerain;
               }
               this.cmdLogMsg(msg + "\n<b>===== end search =====</b>");
               break;
            case "searchenemies":
               if(args == "")
               {
                  args = "1000";
               }
               if(!Utils.hasValue(args))
               {
                  this.cmdLogMsg("Usage: <b>\\searchenemies maxtowns</b>");
                  return;
               }
               if(int(args) > 1000)
               {
                  this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be greater than 1000, using default max value instead");
               }
               else if(int(args) < 10)
               {
                  this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be less than 10, using default min value instead");
               }
               maxTowns = Math.max(Math.min(int(args),1000),10);
               arr = Map.searchEnemyCastles(args);
               arr.sort(this.sortSearchHelper);
               msg = "<b>===== search enemy castle =====</b>";
               msg += "\n" + (arr.length == 0 ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN");
               count = 0;
               for each(castle in arr)
               {
                  if(++count > maxTowns)
                  {
                     break;
                  }
                  level = Map.getLevel(castle.id);
                  type = Map.getType(castle.id);
                  if(level == 10 && (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE))
                  {
                     mCB = Map.getDetailInfo(castle.id);
                     if(mCB != null)
                     {
                        level = 18 - 2 * mCB.powerLevel;
                     }
                  }
                  typeStr = level > 10 && type == FieldConstants.TYPE_NPC ? "HC" : (type == -1 ? "" : Map.FIELD_NAMES[type]);
                  levelStr = level == -1 ? "" : "" + level;
                  coordStr = Map.fieldIdToCoordinate(castle.id);
                  msg += "\n" + int(MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100) / 100 + "&#9;" + Map.getRegionName(castle.id) + "&#9;" + coordStr + "&#9;" + typeStr + "&#9;" + levelStr + "&#9;" + castle.name + "&#9;" + castle.userName + "&#9;" + castle.allianceName + "&#9;" + Map.getStateName(castle.state) + "&#9;" + castle.prestige + "&#9;" + castle.honor + "&#9;" + castle.suzerain;
               }
               if(arr.length > 1000)
               {
                  msg += "\n" + "<b>Warning:</b> ONLY 1000 nearest enemy towns are shown, please use \'searchcastle alliance\' instead";
               }
               else if(count > 100)
               {
                  msg += "\n" + "<b>Notice:</b> You may want to restrict the search result, for example: \\searchenemies 20";
               }
               this.cmdLogMsg(msg + "\n<b>===== end search =====</b>");
               break;
            case "listcastles":
               argsArr = args.split(" ");
               if(argsArr.length < 2)
               {
                  this.cmdLogMsg("Usage: <b>\\listcastles coord coord [maxtowns] [minprestige]</b>");
                  return;
               }
               nwCorner = Map.coordStringToFieldId(argsArr[0]);
               seCorner = Map.coordStringToFieldId(argsArr[1]);
               if(nwCorner == -1 || seCorner == -1 || argsArr.length >= 3 && isNaN(argsArr[2]) || argsArr.length >= 4 && isNaN(argsArr[3]))
               {
                  this.cmdLogMsg("<b>Param error:</b> invalid corner coordinates, max towns, or min prestige");
                  this.cmdLogMsg("Usage: <b>\\listcastles coord coord [maxtowns] [minprestige]</b>");
                  return;
               }
               if(int(argsArr[2]) > 1000)
               {
                  this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be greater than 1000, using default max value instead");
               }
               else if(int(argsArr[2]) < 10)
               {
                  this.cmdLogMsg("<b>Param error:</b> maxtowns cannot be less than 10, using default min value instead");
               }
               if(argsArr.length >= 3)
               {
                  maxTowns = Math.max(Math.min(int(argsArr[2]),1000),10);
               }
               minPres3 = argsArr.length >= 4 ? int(parseInt(argsArr[3])) : 0;
               arr = Map.listCastles(nwCorner,seCorner,minPres3);
               arr.sort(this.sortSearchHelper);
               msg = "<b>===== list castles =====</b>";
               msg += "\n" + (arr.length == 0 ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN");
               count = 0;
               for each(castle in arr)
               {
                  if(++count > maxTowns)
                  {
                     break;
                  }
                  level = Map.getLevel(castle.id);
                  type = Map.getType(castle.id);
                  if(level == 10 && (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE))
                  {
                     mCB = Map.getDetailInfo(castle.id);
                     if(mCB != null)
                     {
                        level = 18 - 2 * mCB.powerLevel;
                     }
                  }
                  typeStr = level > 10 && type == FieldConstants.TYPE_NPC ? "HC" : (type == -1 ? "" : Map.FIELD_NAMES[type]);
                  levelStr = level == -1 ? "" : "" + level;
                  coordStr = Map.fieldIdToCoordinate(castle.id);
                  msg += "\n" + int(MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100) / 100 + "&#9;" + Map.getRegionName(castle.id) + "&#9;" + coordStr + "&#9;" + typeStr + "&#9;" + levelStr + "&#9;" + castle.name + "&#9;" + castle.userName + "&#9;" + castle.allianceName + "&#9;" + Map.getStateName(castle.state) + "&#9;" + castle.prestige + "&#9;" + castle.honor + "&#9;" + castle.suzerain;
               }
               if(arr.length > 1000)
               {
                  msg += "\n" + "Warning: ONLY 1000 nearest enemy towns are shown, please use \'searchcastle alliance\' instead";
               }
               else if(count > 100)
               {
                  msg += "\n" + "Notice: You may want to restrict the search result, for example: \\searchenemies 20";
               }
               this.cmdLogMsg(msg + "\n<b>===== end list castles =====</b>");
               break;
            case "searchfields":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\searchfields name|user|alliance</b>");
                  return;
               }
               arr = Map.searchFields(args);
               arr.sort(this.sortSearchHelper);
               msg = "<b>=== search fields for " + args + " ===</b>";
               msg += "\n" + (arr.length == 0 ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN");
               for each(castle in arr)
               {
                  level = Map.getLevel(castle.id);
                  type = Map.getType(castle.id);
                  if(level == 10 && (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE))
                  {
                     mCB = Map.getDetailInfo(castle.id);
                     if(mCB != null)
                     {
                        level = 18 - 2 * mCB.powerLevel;
                     }
                  }
                  typeStr = level > 10 && type == FieldConstants.TYPE_NPC ? "HC" : (type == -1 ? "" : Map.FIELD_NAMES[type]);
                  levelStr = level == -1 ? "" : "" + level;
                  coordStr = Map.fieldIdToCoordinate(castle.id);
                  msg += "\n" + int(MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100) / 100 + "&#9;" + Map.getRegionName(castle.id) + "&#9;" + coordStr + "&#9;" + typeStr + "&#9;" + levelStr + "&#9;" + castle.name + "&#9;" + castle.userName + "&#9;" + castle.allianceName + "&#9;" + Map.getStateName(castle.state) + "&#9;" + castle.prestige + "&#9;" + castle.honor + "&#9;" + castle.suzerain;
               }
               this.cmdLogMsg(msg + "\n<b>===== end search fields =====</b>");
               break;
            case "searchenemyfields":
               if(args == "")
               {
                  args = "1000";
               }
               if(!Utils.hasValue(args))
               {
                  this.cmdLogMsg("Usage: <b>\\searchenemyfields maxtowns</b>");
                  return;
               }
               maxTowns = int(args);
               arr = Map.searchEnemyFields(args);
               arr.sort(this.sortSearchHelper);
               msg = "<b>===== search enemy fields =====</b>";
               msg += "\n" + (arr.length == 0 ? "" : "DISTANCE&#9;STATE&#9;COORDS&#9;TYPE&#9;LEVEL&#9;NAME&#9;BY&#9;OF&#9;STATUS&#9;PRESTIGE&#9;HONOR&#9;SUZERAIN");
               count = 0;
               for each(castle in arr)
               {
                  if(++count > maxTowns)
                  {
                     break;
                  }
                  level = Map.getLevel(castle.id);
                  type = Map.getType(castle.id);
                  if(level == 10 && (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE))
                  {
                     mCB = Map.getDetailInfo(castle.id);
                     if(mCB != null)
                     {
                        level = 18 - 2 * mCB.powerLevel;
                     }
                  }
                  typeStr = level > 10 && type == FieldConstants.TYPE_NPC ? "HC" : (type == -1 ? "" : Map.FIELD_NAMES[type]);
                  levelStr = level == -1 ? "" : "" + level;
                  coordStr = Map.fieldIdToCoordinate(castle.id);
                  msg += "\n" + int(MainScreen.getInstance().getDistanceFromClosestCastle(castle.id) * 100) / 100 + "&#9;" + Map.getRegionName(castle.id) + "&#9;" + coordStr + "&#9;" + typeStr + "&#9;" + levelStr + "&#9;" + castle.name + "&#9;" + castle.userName + "&#9;" + castle.allianceName + "&#9;" + Map.getStateName(castle.state) + "&#9;" + castle.prestige + "&#9;" + castle.honor + "&#9;" + castle.suzerain;
               }
               if(arr.length > 1000)
               {
                  msg += "\n" + "Warning: ONLY 1000 nearest enemy towns are shown, please use \'searchcastle alliance\' instead";
               }
               else if(count > 100)
               {
                  msg += "\n" + "Notice: You may want to restrict the search result, for example: \\searchenemies 20";
               }
               this.cmdLogMsg(msg + "\n<b>===== end search enemy fields =====</b>");
               break;
            case "listmail":
               if(args == "")
               {
                  args = "1";
               }
               ActionFactory.getInstance().getMailCommands().receiveMailList(int(args),MailConstants.MAIL_RECEIVE,6,this._iq346);
               break;
            case "listsystemmail":
               if(args == "")
               {
                  args = "1";
               }
               ActionFactory.getInstance().getMailCommands().receiveMailList(int(args),MailConstants.MAIL_SYSTEM,6,this._iq346);
               break;
            case "listsentmail":
               if(args == "")
               {
                  args = "1";
               }
               ActionFactory.getInstance().getMailCommands().receiveMailList(int(args),MailConstants.MAIL_SEND,6,this._iq346);
               break;
            case "readmail":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\readmail mailId</b>");
                  return;
               }
               ActionFactory.getInstance().getMailCommands().readMail(int(args),this._gd426);
               break;
            case "mail":
               sp1 = int(args.indexOf(" "));
               sp2 = int(args.indexOf(" ",sp1 + 1));
               if(sp1 == -1 || sp2 == -1)
               {
                  this.cmdLogMsg("Usage <b>\\mail username title content</b>");
                  return;
               }
               username = args.substr(0,sp1);
               username = Utils.searchAndReplace(username,"_"," ");
               title = args.substr(sp1 + 1,sp2 - sp1 - 1);
               title = Utils.searchAndReplace(title,"_"," ");
               content = args.substr(sp2 + 1);
               ActionFactory.getInstance().getMailCommands().sendMail(username,title,content,this.onColonyGenericResponse);
               break;
            case "quickarmyreport":
            case "qar":
               if(args == "")
               {
                  args = "1";
               }
               this.detailReport = false;
               ActionFactory.getInstance().getReportCommands().receiveReportList(int(args),6,ObjConstants.REPORT_TYPE_ARMY,this._mv26);
               break;
            case "armyreport":
               if(args == "")
               {
                  args = "1";
               }
               this.detailReport = true;
               ActionFactory.getInstance().getReportCommands().receiveReportList(int(args),6,ObjConstants.REPORT_TYPE_ARMY,this._mv26);
               break;
            case "quickscoutreport":
            case "qsr":
               if(args == "")
               {
                  args = "1";
               }
               this.detailReport = false;
               ActionFactory.getInstance().getReportCommands().receiveReportList(int(args),6,ObjConstants.REPORT_TYPE_SCOUT,this._mv26);
               break;
            case "scoutreport":
               if(args == "")
               {
                  args = "1";
               }
               this.detailReport = true;
               ActionFactory.getInstance().getReportCommands().receiveReportList(int(args),6,ObjConstants.REPORT_TYPE_SCOUT,this._mv26);
               break;
            case "otherreport":
               if(args == "")
               {
                  args = "1";
               }
               this.detailReport = true;
               ActionFactory.getInstance().getReportCommands().receiveReportList(int(args),6,ObjConstants.REPORT_TYPE_OTHER,this._mv26);
               break;
            case "readreport":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\readreport reportId</b>");
                  return;
               }
               ActionFactory.getInstance().getReportCommands().markAsRead(int(args),this._gc827);
               break;
            case "warreport":
               if(args == "")
               {
                  args = "1";
               }
               ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(int(args),6,this._ma393);
               break;
            case "members":
               if(args == "")
               {
                  args = "1";
               }
               ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this._wn1051);
               break;
            case "invite":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\invite nick</b>");
                  return;
               }
               this.cmdLogMsg("Invite " + args + " into your alliance");
               ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAlliance(args,this.handleGenericCmdResponse);
               break;
            case "accept":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\accept nick</b>");
                  return;
               }
               this.cmdLogMsg("Accept application from: " + args);
               ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByLeader(args,this.handleGenericCmdResponse);
               break;
            case "apply":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\apply alliance</b>");
                  return;
               }
               this.cmdLogMsg("Apply into alliance: " + args);
               ActionFactory.getInstance().getAllianceManagementCommands().userWantInAlliance(args,this.handleGenericCmdResponse);
               break;
            case "join":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\join alliance</b>");
                  return;
               }
               this.cmdLogMsg("Accept invitation to join alliance: " + args);
               ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByUser(MainScreen.getInstance().getSelectedCity().castle.id,args,this.handleGenericCmdResponse);
               break;
            case "eject":
               if(args == "")
               {
                  this.cmdLogMsg("Usage <b>\\eject nick</b>");
                  return;
               }
               this.cmdLogMsg("Eject nick from alliance: <b>" + args + "</b>");
               ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(args,this.handleGenericCmdResponse);
               break;
            case "quitalliance":
               this.cmdLogMsg("Quit current alliance: <b>" + args + "</b>");
               ActionFactory.getInstance().getAllianceManagementCommands().sayByetoAlliance(this.handleGenericCmdResponse);
               break;
            case "qfarm":
               this.cmdLogMsg("Start all farming waves");
               this._kj1046();
               break;
            case "describe":
               this.doDescribeCmd(args);
               break;
            case "doheronames":
               REAddons.getInstance().doHeroNames();
               break;
            case "doheroname":
               REAddons.getInstance().doHeroName(MainScreen.getInstance().getSelectedCity());
               break;
            case "qcolony":
               this.qColony(args);
               break;
            case "qcapitalpolicy":
            case "qcappol":
               this.qCapitalPolicy(args);
               break;
            case "qlistpackages":
            case "qlp":
               this.qListPackages();
               break;
            case "qclaimpackage":
            case "qcp":
               this.qClaimPackage(int(args));
               break;
            case "qclaimallpackages":
            case "qcap":
               this.qClaimAllPackages();
               break;
            default:
               this.cmdLogMsg("<b>Invalid command:</b> " + command);
               this.cmdLogMsg("<font color=\'#093333\'><b>available commands</b></font>:  <font color=\'#093333\'><b>clear</b></font>commandwindow  <font color=\'#093333\'><b>cleara</b></font>lliance<font color=\'#093333\'><b>c</b></font>hat  <font color=\'#093333\'><b>clearp</b></font>rivate<font color=\'#093333\'><b>c</b></font>hat  <font color=\'#093333\'><b>clearw</b></font>orld<font color=\'#093333\'><b>c</b></font>hat  <font color=\'#093333\'><b>clearsys</b></font>temlog  describe  <font color=\'#093333\'><b>ver</b></font>sion  <font color=\'#093333\'><b>ql</b></font>ist<font color=\'#093333\'><b>p</b></font>ackages  <font color=\'#093333\'><b>qc</b></font>laim<font color=\'#093333\'><b>p</b></font>ackage  <font color=\'#093333\'><b>qc</b></font>laim<font color=\'#093333\'><b>a</b></font>ll<font color=\'#093333\'><b>p</b></font>ackages  who  loc  searchcastle  searchfields  searchenemyfields  searchsuzerain  searchenemies  listcastles  getfblinks  alliance  getrelations  setfriend  setneutral  setenemy  setnorelation  sethost  setvicehost  setpresbyter  setofficer  setmember  resign  members  apply  accept  invite  join  eject  quitalliance  <font color=\'#093333\'><b>qa</b></font>ttack  <font color=\'#093333\'><b>qs</b></font>cout  <font color=\'#093333\'><b>qt</b></font>ransport  <font color=\'#093333\'><b>qr</b></font>einforce  <font color=\'#093333\'><b>qc</b></font>olonize  <font color=\'#093333\'><b>qd</b></font>eploy  <font color=\'#093333\'><b>qdec</b></font>larewar  <font color=\'#093333\'><b>qcap</b></font>ital<font color=\'#093333\'><b>pol</b></font>icy  qcolony  qfarm  doheronames  doheroname  listmail  listsystemmail  listsentmail  readmail  mail  <font color=\'#093333\'><b>q</b></font>uick<font color=\'#093333\'><b>a</b></font>rmy<font color=\'#093333\'><b>r</b></font>eport  armyreport  <font color=\'#093333\'><b>q</b></font>uick<font color=\'#093333\'><b>s</b></font>cout<font color=\'#093333\'><b>r</b></font>eport  scoutreport  otherreport  readreport  warreport  fmth  fmthg  qkillwall  <font color=\'#093333\'><b>qw</b></font>all<font color=\'#093333\'><b>tra</b></font>p  <font color=\'#093333\'><b>qw</b></font>all<font color=\'#093333\'><b>ab</b></font>atis  <font color=\'#093333\'><b>qw</b></font>all<font color=\'#093333\'><b>a</b></font>rcher<font color=\'#093333\'><b>t</b></font>ower  <font color=\'#093333\'><b>qw</b></font>all<font color=\'#093333\'><b>r</b></font>ollinglog  <font color=\'#093333\'><b>qw</b></font>alldefensive<font color=\'#093333\'><b>tre</b></font>buchet\n");
         }
      }
      
      private function cmdLogMsg(param1:String) : void
      {
         this.handleLogMsg.apply(null,[param1]);
      }
      
      private function _ma393(param1:MilitarySituationListResponse) : void
      {
         var _loc6_:MilitarySituation = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Military situation list error: " + param1.errorMsg);
            return;
         }
         this.cmdLogMsg("Page: " + param1.pageNo + "/" + param1.totalPage);
         var _loc2_:String = null;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         for each(_loc6_ in param1.situationsArray)
         {
            _loc2_ = _loc6_.attack ? "ATT" : "DEF";
            _loc3_ = new XML(_loc6_.xml_data);
            _loc4_ = _loc3_.@reportUrl;
            if(_loc4_ != "")
            {
               this.cmdLogMsg(Utils.formatUrl(_loc2_ + " " + _loc6_.otherAllianceName + " " + _loc6_.eventName + " at " + _loc6_.time + " from " + _loc6_.startPos + " " + _loc3_.battleReport.attackTroop.@king + " to " + _loc6_.targetPos + " " + _loc3_.battleReport.defendTroop.@king,_loc3_.@reportUrl) + " " + Utils.armyReportToString(_loc3_.battleReport));
            }
            else
            {
               _loc5_ = _loc3_.battleReport.@isAttackSuccess == "true" ? "WON" : "LOST";
               this.cmdLogMsg(_loc2_ + " " + _loc6_.otherAllianceName + " " + _loc6_.eventName + " at " + _loc6_.time + " from " + _loc6_.startPos + " " + Utils.armyReportToString(_loc3_.battleReport));
            }
         }
      }
      
      private function sortSearchHelper(param1:MapCastleBean, param2:MapCastleBean) : int
      {
         var _loc3_:Number = MainScreen.getInstance().getDistanceFromClosestCastle(param1.id);
         var _loc4_:Number = MainScreen.getInstance().getDistanceFromClosestCastle(param2.id);
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      private function _gd426(param1:MailResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Read mail error: " + param1.errorMsg);
            return;
         }
         this.cmdLogMsg("[" + param1.mailid + ":" + param1.sender + ">" + param1.receiver + "] " + param1.title + " at " + param1.receiveTime + "\n" + param1.content);
      }
      
      private function onGetColonyArmyInfoResponse(param1:ColonialArmyResponse) : void
      {
         var _loc2_:ArmyBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("<b>Error received:</b> " + param1.errorMsg);
            return;
         }
         if(param1.armyBeansArray.length == 0)
         {
            this.cmdLogMsg("No army in colony");
         }
         else
         {
            this.cmdLogMsg("Armies found in colony");
            for each(_loc2_ in param1.armyBeansArray)
            {
               MainScreen.getInstance().getSelectedCity().cityManager.logMsg("  " + Utils.armyToString(_loc2_));
               this.cmdLogMsg("  " + Utils.armyToString(_loc2_));
            }
         }
      }
      
      private function _yr821(param1:AllianceInfoResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.cmdLogMsg("Alliance info: " + param1.errorMsg);
            return;
         }
         this.cmdLogMsg("Alliance info: " + param1.allinaceInfo + ", host: " + param1.leader + ", creator: " + param1.creator + ", members: " + param1.memberCount + ", pres: " + param1.prestigeCount);
      }
   }
}

