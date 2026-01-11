package autoevony.common
{
   import autoevony.gui.MainScreen;
   import autoevony.management.BuildingManager;
   import autoevony.management.CityManager;
   import autoevony.scripts.CityState;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.BuildingBean;
   import com.evony.common.constants.BuildingConstants;
   import com.evony.common.constants.CommonConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.paramBeans.NewArmyParam;
   
   public class CityStateCommands
   {
      private static var lastProduceQueueUpdate:Number = new Date().getTime();
      
      private static var lastCheckedBuilding:int = -1;
      
      public function CityStateCommands()
      {
         super();
      }
      
      public static function getHerosListFromTavern(param1:int, param2:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TAVERN);
         ActionFactory.getInstance().getHeroCommand().getHerosListFromTavern(param1,param2);
      }
      
      public static function giveupCastle(param1:String, param2:int, param3:Function = null) : void
      {
         var c:CityState = null;
         var userPw:String = param1;
         var castleId:int = param2;
         var callBack:Function = param3;
         var otherId:int = 0;
         try
         {
            otherId = -1;
            for each(c in MainScreen.getCities())
            {
               if(c.castle.id != castleId)
               {
                  otherId = c.castle.id;
                  break;
               }
            }
            getBuildRequirements(otherId,BuildingConstants.TYPE_TOWN_HALL);
         }
         catch(error:Error)
         {
         }
         ActionFactory.getInstance().getCityCommands().giveupCastle(userPw,castleId,callBack);
      }
      
      public static function getResourceProduceData(param1:int, param2:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TOWN_HALL);
         ActionFactory.getInstance().getInteriorCommands().getResourceProduceData(param1,param2);
      }
      
      public static function cancelFortificationProduce(param1:int, param2:int, param3:Function = null) : void
      {
         updateProduceQueueIfNeeded(param1);
         ActionFactory.getInstance().getFortificationsCommands().cancelFortificationProduce(param1,param2,param3);
      }
      
      public static function cancelTrade(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_MARKET);
         ActionFactory.getInstance().getTradeCommands().cancelTrade(param1,param2,param3);
      }
      
      private static function doCheckOutUpgrade(param1:int, param2:BuildingBean, param3:Function = null) : void
      {
         var _loc4_:CityManager = MainScreen.getCityManagerFromCastleId(param1);
         if(_loc4_.isBuildingAlreadyMaxLevel(param2))
         {
            return;
         }
         var _loc5_:int = param1 * 100 + param2.positionId;
         if(lastCheckedBuilding == _loc5_)
         {
            return;
         }
         lastCheckedBuilding = _loc5_;
         BuildingManager.getInstance().checkOutUpgrade(param1,param2,param3);
      }
      
      public static function hireHero(param1:int, param2:String, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TAVERN);
         ActionFactory.getInstance().getHeroCommand().hireHero(param1,param2,param3);
      }
      
      public static function tryGetSeizedHero(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().tryGetSeizedHero(param1,param2,param3);
      }
      
      public static function modifyTaxRate(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TOWN_HALL);
         ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(param1,param2,param3);
      }
      
      public static function checkOutUpgrade(param1:int, param2:int, param3:Function = null) : void
      {
         var _loc5_:BuildingBean = null;
         var _loc4_:CityManager = MainScreen.getCityManagerFromCastleId(param1);
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.getBuildingBeanFromPositionId(param2);
            if(_loc5_ != null)
            {
               doCheckOutUpgrade(param1,_loc5_,param3);
            }
         }
      }
      
      public static function setAllowAllianceArmy(param1:int, param2:Boolean, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_EMBASSY);
         ActionFactory.getInstance().getArmyCommands().getStayAllianceArmys(param1);
         ActionFactory.getInstance().getArmyCommands().setAllowAllianceArmy(param1,param2,param3);
      }
      
      public static function releaseHero(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().releaseHero(param1,param2,param3);
      }
      
      public static function dischargeChief(param1:int, param2:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().dischargeChief(param1,param2);
      }
      
      public static function newTrade(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_MARKET);
         ActionFactory.getInstance().getTradeCommands().newTrade(param1,param2,param3,param4,param5,param6);
      }
      
      public static function produceWallProtect(param1:int, param2:int, param3:int, param4:Function = null) : void
      {
         updateProduceQueueIfNeeded(param1);
         ActionFactory.getInstance().getFortificationsCommands().produceWallProtect(param1,param2,param3,param4);
      }
      
      private static function validateBuildRequirements(param1:int, param2:int = -10) : void
      {
         if(param2 == -10)
         {
            getBuildRequirements(param1,BuildingConstants.TYPE_BARRACK);
         }
         else
         {
            checkOutUpgrade(param1,param2);
         }
      }
      
      public static function callBackArmy(param1:int, param2:int, param3:Function = null) : void
      {
         ActionFactory.getInstance().getArmyCommands().callBackArmy(param1,param2,param3);
      }
      
      public static function promoteToChief(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().promoteToChief(param1,param2,param3);
      }
      
      public static function destructWallProtect(param1:int, param2:int, param3:int, param4:Function = null) : void
      {
         updateProduceQueueIfNeeded(param1);
         ActionFactory.getInstance().getFortificationsCommands().destructWallProtect(param1,param2,param3,param4);
      }
      
      public static function modifyCommenceRate(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TOWN_HALL);
         ActionFactory.getInstance().getInteriorCommands().modifyCommenceRate(param1,param2,param3,param4,param5,param6);
      }
      
      public static function addPoint2(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().addPoint2(param1,param2,param3,param4,param5,param6);
      }
      
      public static function research(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_ACADEMY);
         ActionFactory.getInstance().getTechCommand().getResearchList(param1);
         ActionFactory.getInstance().getTechCommand().research(param1,param2,param3);
      }
      
      public static function cureInjuredTroop(param1:int) : CommandResponse
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TRAINNING_FEILD);
         ActionFactory.getInstance().getArmyCommands().getInjuredTroop(param1);
         return ActionFactory.getInstance().getArmyCommands().cureInjuredTroop(param1);
      }
      
      public static function taxation(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TOWN_HALL);
         ActionFactory.getInstance().getInteriorCommands().taxation(param1,param2,param3);
      }
      
      public static function levelUp(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().levelUp(param1,param2,param3);
      }
      
      public static function cancelTroopProduce(param1:int, param2:int, param3:int, param4:Function = null) : void
      {
         validateBuildRequirements(param1,param2);
         ActionFactory.getInstance().getTroopCommands().cancelTroopProduce(param1,param2,param3,param4);
      }
      
      private static function updateProduceQueueIfNeeded(param1:int, param2:Function = null) : void
      {
         var _loc3_:Date = new Date();
         if(lastProduceQueueUpdate + 30 * 1000 > _loc3_.getTime())
         {
            return;
         }
         reqUpdatedProduceQueue(param1,param2);
      }
      
      public static function giveUpField(param1:int, param2:Function = null) : void
      {
         var _loc3_:CityManager = MainScreen.getCityManagerFromFieldId(param1);
         if(_loc3_ != null)
         {
            getBuildRequirements(_loc3_._getCastleId(),BuildingConstants.TYPE_TOWN_HALL);
         }
         ActionFactory.getInstance().getFieldCommand().giveUpField(param1);
      }
      
      public static function getResearchList(param1:int, param2:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_ACADEMY);
         ActionFactory.getInstance().getTechCommand().getResearchList(param1,param2);
      }
      
      public static function fireHero(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().fireHero(param1,param2,param3);
      }
      
      public static function produceTroop(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Function = null) : void
      {
         validateBuildRequirements(param1,param2);
         ActionFactory.getInstance().getTroopCommands().produceTroop(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public static function disbandTroop(param1:int, param2:int, param3:int, param4:Function = null) : void
      {
         validateBuildRequirements(param1);
         ActionFactory.getInstance().getTroopCommands().disbandTroop(param1,param2,param3,param4);
      }
      
      public static function searchTrades(param1:int, param2:Function = null) : void
      {
         getBuildRequirements(MainScreen.getCities()[0].castle.id,BuildingConstants.TYPE_MARKET);
         ActionFactory.getInstance().getTradeCommands().searchTrades(param1,param2);
      }
      
      public static function pacifyPeople(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TOWN_HALL);
         ActionFactory.getInstance().getInteriorCommands().pacifyPeople(param1,param2,param3);
      }
      
      public static function changeName(param1:int, param2:int, param3:String, param4:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().changeName(param1,param2,param3,param4);
      }
      
      public static function awardGold(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().awardGold(param1,param2,param3);
      }
      
      private static function reqUpdatedBuildingList(param1:int, param2:int) : void
      {
         if(param2 >= BuildingConstants.BUILDING_OUTSIDE_MIN)
         {
            ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListOutside(param1);
         }
         else
         {
            ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(param1);
         }
      }
      
      public static function voteForPlayerByName(param1:String, param2:Function = null) : void
      {
         ActionFactory.getInstance().getRankCommands().getVoteRank("",1,10,1);
         ActionFactory.getInstance().getVoteToPlayerCommands().voteToPlayerByName(param1,param2);
         ActionFactory.getInstance().getRankCommands().getVoteRank("",1,10,1);
      }
      
      public static function newArmy(param1:int, param2:NewArmyParam, param3:Function = null) : CommandResponse
      {
         var _loc4_:CityManager = MainScreen.getCityManagerFromCastleId(param1);
         if(_loc4_ != null)
         {
            if(param2.restTime > 0)
            {
               param2.restTime /= _loc4_.getCampTimeChangeBuffsFactor();
            }
            if(param2.restTime < 0)
            {
               param2.restTime = 0;
            }
         }
         Utils.trimDecimalFromResoAmounts(param2.resource);
         getBuildRequirements(param1,BuildingConstants.TYPE_TRAINNING_FEILD);
         ActionFactory.getInstance().getArmyCommands().getTroopParam(param1);
         return ActionFactory.getInstance().getArmyCommands().newArmy(param1,param2,param3);
      }
      
      public static function setArmyGoOut(param1:int, param2:Boolean, param3:Function = null) : CommandResponse
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_TRAINNING_FEILD);
         return ActionFactory.getInstance().getArmyCommands().setArmyGoOut(param1,param2,param3);
      }
      
      private static function getBuildRequirements(param1:int, param2:int) : void
      {
         var _loc3_:CityManager = MainScreen.getCityManagerFromCastleId(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:BuildingBean = _loc3_.getBuildingBeanFromTypeId(param2);
         if(_loc4_ == null)
         {
            return;
         }
         doCheckOutUpgrade(param1,_loc4_);
      }
      
      public static function getTroopProduceList(param1:int, param2:int, param3:Function = null) : void
      {
         validateBuildRequirements(param1);
         ActionFactory.getInstance().getTroopCommands().getTroopProduceList(param1,param2,param3);
      }
      
      public static function destructBuilding(param1:int, param2:int, param3:Function = null) : void
      {
         checkOutUpgrade(param1,param2);
         ActionFactory.getInstance().getCastleCommands().destructBuilding(param1,param2,param3);
      }
      
      public static function reqUpdatedProduceQueue(param1:int, param2:Function = null) : void
      {
         lastProduceQueueUpdate = new Date().getTime();
         checkOutUpgrade(param1,BuildingConstants.POSITION_WALL);
         ActionFactory.getInstance().getFortificationsCommands().getFortificationsProduceList(param1);
         ActionFactory.getInstance().getFortificationsCommands().getProduceQueue(param1,param2);
      }
      
      public static function newBuilding(param1:int, param2:int, param3:int, param4:Function = null, param5:Boolean = false) : void
      {
         reqUpdatedBuildingList(param1,param2);
         if(param5)
         {
            ActionFactory.getInstance().getCastleCommands().newBuildingQueue(param1,param3,1,param2,param4);
         }
         else
         {
            ActionFactory.getInstance().getCastleCommands().newBuilding(param1,param2,param3,param4);
            checkOutUpgrade(param1,param2);
            if(BuildingType.isBuildTime5MinOrLess(param3,1))
            {
               ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(param1,param2,CommonConstants.FREE_SPEED_ITEM_ID);
            }
         }
      }
      
      public static function upgradeBuilding(param1:int, param2:int, param3:Function = null, param4:Boolean = false) : void
      {
         var _loc5_:CityManager = MainScreen.getCityManagerFromCastleId(param1);
         var _loc6_:BuildingBean = _loc5_ != null ? _loc5_.getBuildingBeanFromPositionId(param2) : null;
         checkOutUpgrade(param1,param2);
         if(param4 && _loc6_ != null)
         {
            ActionFactory.getInstance().getCastleCommands().newBuildingQueue(param1,_loc6_.typeId,_loc6_.level + 1,param2,param3);
         }
         else
         {
            ActionFactory.getInstance().getCastleCommands().upgradeBuilding(param1,param2,param3);
            if(_loc6_ != null && BuildingType.isBuildTime5MinOrLess(_loc6_.typeId,_loc6_.level))
            {
               checkOutUpgrade(param1,param2);
               ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(param1,param2,CommonConstants.FREE_SPEED_ITEM_ID);
            }
         }
      }
      
      public static function getMilitarySituationList(param1:int, param2:int, param3:Function = null) : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().getAllianceWanted();
         ActionFactory.getInstance().getAllianceManagementCommands().leaderWantUserInAllianceList();
         ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance();
         ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(param1,param2,param3);
      }
      
      public static function getUpdatedTroopProduceQueue(param1:int, param2:Function = null) : void
      {
         validateBuildRequirements(param1);
         ActionFactory.getInstance().getTroopCommands().getProduceQueue(param1,param2);
      }
      
      public static function callBackHero(param1:int, param2:int, param3:Function = null) : void
      {
         getBuildRequirements(param1,BuildingConstants.TYPE_HEROS_MANSION);
         ActionFactory.getInstance().getHeroCommand().callBackHero(param1,param2,param3);
      }
   }
}

