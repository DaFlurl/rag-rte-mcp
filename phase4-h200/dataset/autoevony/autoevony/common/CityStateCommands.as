// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.CityStateCommands

package autoevony.common
{
    import com.evony.common.constants.BuildingConstants;
    import com.evony.client.action.ActionFactory;
    import autoevony.scripts.CityState;
    import autoevony.gui.MainScreen;
    import autoevony.management.CityManager;
    import autoevony.management.BuildingManager;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.paramBeans.NewArmyParam;
    import com.evony.common.constants.CommonConstants;

    public class CityStateCommands 
    {

        private static var lastProduceQueueUpdate:Number = new Date().getTime();
        private static var lastCheckedBuilding:int = -1;


        public static function getHerosListFromTavern(_arg_1:int, _arg_2:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TAVERN);
            ActionFactory.getInstance().getHeroCommand().getHerosListFromTavern(_arg_1, _arg_2);
        }

        public static function giveupCastle(userPw:String, castleId:int, callBack:Function=null):void
        {
            var c:CityState;
            var otherId:int;
            try
            {
                otherId = -1;
                for each (c in MainScreen.getCities())
                {
                    if (c.castle.id != castleId)
                    {
                        otherId = c.castle.id;
                        break;
                    };
                };
                getBuildRequirements(otherId, BuildingConstants.TYPE_TOWN_HALL);
            }
            catch(error:Error)
            {
            };
            ActionFactory.getInstance().getCityCommands().giveupCastle(userPw, castleId, callBack);
        }

        public static function getResourceProduceData(_arg_1:int, _arg_2:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TOWN_HALL);
            ActionFactory.getInstance().getInteriorCommands().getResourceProduceData(_arg_1, _arg_2);
        }

        public static function cancelFortificationProduce(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            updateProduceQueueIfNeeded(_arg_1);
            ActionFactory.getInstance().getFortificationsCommands().cancelFortificationProduce(_arg_1, _arg_2, _arg_3);
        }

        public static function cancelTrade(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_MARKET);
            ActionFactory.getInstance().getTradeCommands().cancelTrade(_arg_1, _arg_2, _arg_3);
        }

        private static function doCheckOutUpgrade(_arg_1:int, _arg_2:BuildingBean, _arg_3:Function=null):void
        {
            var _local_4:CityManager = MainScreen.getCityManagerFromCastleId(_arg_1);
            if (_local_4.isBuildingAlreadyMaxLevel(_arg_2))
            {
                return;
            };
            var _local_5:int = ((_arg_1 * 100) + _arg_2.positionId);
            if (lastCheckedBuilding == _local_5)
            {
                return;
            };
            lastCheckedBuilding = _local_5;
            BuildingManager.getInstance().checkOutUpgrade(_arg_1, _arg_2, _arg_3);
        }

        public static function hireHero(_arg_1:int, _arg_2:String, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TAVERN);
            ActionFactory.getInstance().getHeroCommand().hireHero(_arg_1, _arg_2, _arg_3);
        }

        public static function tryGetSeizedHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().tryGetSeizedHero(_arg_1, _arg_2, _arg_3);
        }

        public static function modifyTaxRate(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TOWN_HALL);
            ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(_arg_1, _arg_2, _arg_3);
        }

        public static function checkOutUpgrade(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            var _local_5:BuildingBean;
            var _local_4:CityManager = MainScreen.getCityManagerFromCastleId(_arg_1);
            if (_local_4 != null)
            {
                _local_5 = _local_4.getBuildingBeanFromPositionId(_arg_2);
                if (_local_5 != null)
                {
                    doCheckOutUpgrade(_arg_1, _local_5, _arg_3);
                };
            };
        }

        public static function setAllowAllianceArmy(_arg_1:int, _arg_2:Boolean, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_EMBASSY);
            ActionFactory.getInstance().getArmyCommands().getStayAllianceArmys(_arg_1);
            ActionFactory.getInstance().getArmyCommands().setAllowAllianceArmy(_arg_1, _arg_2, _arg_3);
        }

        public static function releaseHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().releaseHero(_arg_1, _arg_2, _arg_3);
        }

        public static function dischargeChief(_arg_1:int, _arg_2:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().dischargeChief(_arg_1, _arg_2);
        }

        public static function newTrade(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_MARKET);
            ActionFactory.getInstance().getTradeCommands().newTrade(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        public static function produceWallProtect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):void
        {
            updateProduceQueueIfNeeded(_arg_1);
            ActionFactory.getInstance().getFortificationsCommands().produceWallProtect(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private static function validateBuildRequirements(_arg_1:int, _arg_2:int=-10):void
        {
            if (_arg_2 == -10)
            {
                getBuildRequirements(_arg_1, BuildingConstants.TYPE_BARRACK);
            }
            else
            {
                checkOutUpgrade(_arg_1, _arg_2);
            };
        }

        public static function callBackArmy(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            ActionFactory.getInstance().getArmyCommands().callBackArmy(_arg_1, _arg_2, _arg_3);
        }

        public static function promoteToChief(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().promoteToChief(_arg_1, _arg_2, _arg_3);
        }

        public static function destructWallProtect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):void
        {
            updateProduceQueueIfNeeded(_arg_1);
            ActionFactory.getInstance().getFortificationsCommands().destructWallProtect(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public static function modifyCommenceRate(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TOWN_HALL);
            ActionFactory.getInstance().getInteriorCommands().modifyCommenceRate(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        public static function addPoint2(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().addPoint2(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        public static function research(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_ACADEMY);
            ActionFactory.getInstance().getTechCommand().getResearchList(_arg_1);
            ActionFactory.getInstance().getTechCommand().research(_arg_1, _arg_2, _arg_3);
        }

        public static function cureInjuredTroop(_arg_1:int):CommandResponse
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TRAINNING_FEILD);
            ActionFactory.getInstance().getArmyCommands().getInjuredTroop(_arg_1);
            return (ActionFactory.getInstance().getArmyCommands().cureInjuredTroop(_arg_1));
        }

        public static function taxation(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TOWN_HALL);
            ActionFactory.getInstance().getInteriorCommands().taxation(_arg_1, _arg_2, _arg_3);
        }

        public static function levelUp(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().levelUp(_arg_1, _arg_2, _arg_3);
        }

        public static function cancelTroopProduce(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):void
        {
            validateBuildRequirements(_arg_1, _arg_2);
            ActionFactory.getInstance().getTroopCommands().cancelTroopProduce(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private static function updateProduceQueueIfNeeded(_arg_1:int, _arg_2:Function=null):void
        {
            var _local_3:Date = new Date();
            if ((lastProduceQueueUpdate + (30 * 1000)) > _local_3.getTime())
            {
                return;
            };
            reqUpdatedProduceQueue(_arg_1, _arg_2);
        }

        public static function giveUpField(_arg_1:int, _arg_2:Function=null):void
        {
            var _local_3:CityManager = MainScreen.getCityManagerFromFieldId(_arg_1);
            if (_local_3 != null)
            {
                getBuildRequirements(_local_3._getCastleId(), BuildingConstants.TYPE_TOWN_HALL);
            };
            ActionFactory.getInstance().getFieldCommand().giveUpField(_arg_1);
        }

        public static function getResearchList(_arg_1:int, _arg_2:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_ACADEMY);
            ActionFactory.getInstance().getTechCommand().getResearchList(_arg_1, _arg_2);
        }

        public static function fireHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().fireHero(_arg_1, _arg_2, _arg_3);
        }

        public static function produceTroop(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Function=null):void
        {
            validateBuildRequirements(_arg_1, _arg_2);
            ActionFactory.getInstance().getTroopCommands().produceTroop(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
        }

        public static function disbandTroop(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):void
        {
            validateBuildRequirements(_arg_1);
            ActionFactory.getInstance().getTroopCommands().disbandTroop(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public static function searchTrades(_arg_1:int, _arg_2:Function=null):void
        {
            getBuildRequirements(MainScreen.getCities()[0].castle.id, BuildingConstants.TYPE_MARKET);
            ActionFactory.getInstance().getTradeCommands().searchTrades(_arg_1, _arg_2);
        }

        public static function pacifyPeople(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TOWN_HALL);
            ActionFactory.getInstance().getInteriorCommands().pacifyPeople(_arg_1, _arg_2, _arg_3);
        }

        public static function changeName(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().changeName(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public static function awardGold(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().awardGold(_arg_1, _arg_2, _arg_3);
        }

        private static function reqUpdatedBuildingList(_arg_1:int, _arg_2:int):void
        {
            if (_arg_2 >= BuildingConstants.BUILDING_OUTSIDE_MIN)
            {
                ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListOutside(_arg_1);
            }
            else
            {
                ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(_arg_1);
            };
        }

        public static function voteForPlayerByName(_arg_1:String, _arg_2:Function=null):void
        {
            ActionFactory.getInstance().getRankCommands().getVoteRank("", 1, 10, 1);
            ActionFactory.getInstance().getVoteToPlayerCommands().voteToPlayerByName(_arg_1, _arg_2);
            ActionFactory.getInstance().getRankCommands().getVoteRank("", 1, 10, 1);
        }

        public static function newArmy(_arg_1:int, _arg_2:NewArmyParam, _arg_3:Function=null):CommandResponse
        {
            var _local_4:CityManager = MainScreen.getCityManagerFromCastleId(_arg_1);
            if (_local_4 != null)
            {
                if (_arg_2.restTime > 0)
                {
                    _arg_2.restTime = (_arg_2.restTime / _local_4.getCampTimeChangeBuffsFactor());
                };
                if (_arg_2.restTime < 0)
                {
                    _arg_2.restTime = 0;
                };
            };
            Utils.trimDecimalFromResoAmounts(_arg_2.resource);
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TRAINNING_FEILD);
            ActionFactory.getInstance().getArmyCommands().getTroopParam(_arg_1);
            return (ActionFactory.getInstance().getArmyCommands().newArmy(_arg_1, _arg_2, _arg_3));
        }

        public static function setArmyGoOut(_arg_1:int, _arg_2:Boolean, _arg_3:Function=null):CommandResponse
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_TRAINNING_FEILD);
            return (ActionFactory.getInstance().getArmyCommands().setArmyGoOut(_arg_1, _arg_2, _arg_3));
        }

        private static function getBuildRequirements(_arg_1:int, _arg_2:int):void
        {
            var _local_3:CityManager = MainScreen.getCityManagerFromCastleId(_arg_1);
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:BuildingBean = _local_3.getBuildingBeanFromTypeId(_arg_2);
            if (_local_4 == null)
            {
                return;
            };
            doCheckOutUpgrade(_arg_1, _local_4);
        }

        public static function getTroopProduceList(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            validateBuildRequirements(_arg_1);
            ActionFactory.getInstance().getTroopCommands().getTroopProduceList(_arg_1, _arg_2, _arg_3);
        }

        public static function destructBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            checkOutUpgrade(_arg_1, _arg_2);
            ActionFactory.getInstance().getCastleCommands().destructBuilding(_arg_1, _arg_2, _arg_3);
        }

        public static function reqUpdatedProduceQueue(_arg_1:int, _arg_2:Function=null):void
        {
            lastProduceQueueUpdate = new Date().getTime();
            checkOutUpgrade(_arg_1, BuildingConstants.POSITION_WALL);
            ActionFactory.getInstance().getFortificationsCommands().getFortificationsProduceList(_arg_1);
            ActionFactory.getInstance().getFortificationsCommands().getProduceQueue(_arg_1, _arg_2);
        }

        public static function newBuilding(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null, _arg_5:Boolean=false):void
        {
            reqUpdatedBuildingList(_arg_1, _arg_2);
            if (_arg_5)
            {
                ActionFactory.getInstance().getCastleCommands().newBuildingQueue(_arg_1, _arg_3, 1, _arg_2, _arg_4);
            }
            else
            {
                ActionFactory.getInstance().getCastleCommands().newBuilding(_arg_1, _arg_2, _arg_3, _arg_4);
                checkOutUpgrade(_arg_1, _arg_2);
                if (BuildingType.isBuildTime5MinOrLess(_arg_3, 1))
                {
                    ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(_arg_1, _arg_2, CommonConstants.FREE_SPEED_ITEM_ID);
                };
            };
        }

        public static function upgradeBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null, _arg_4:Boolean=false):void
        {
            var _local_5:CityManager = MainScreen.getCityManagerFromCastleId(_arg_1);
            var _local_6:BuildingBean = ((_local_5 != null) ? _local_5.getBuildingBeanFromPositionId(_arg_2) : null);
            checkOutUpgrade(_arg_1, _arg_2);
            if (((_arg_4) && (!(_local_6 == null))))
            {
                ActionFactory.getInstance().getCastleCommands().newBuildingQueue(_arg_1, _local_6.typeId, (_local_6.level + 1), _arg_2, _arg_3);
            }
            else
            {
                ActionFactory.getInstance().getCastleCommands().upgradeBuilding(_arg_1, _arg_2, _arg_3);
                if (((!(_local_6 == null)) && (BuildingType.isBuildTime5MinOrLess(_local_6.typeId, _local_6.level))))
                {
                    checkOutUpgrade(_arg_1, _arg_2);
                    ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(_arg_1, _arg_2, CommonConstants.FREE_SPEED_ITEM_ID);
                };
            };
        }

        public static function getMilitarySituationList(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().getAllianceWanted();
            ActionFactory.getInstance().getAllianceManagementCommands().leaderWantUserInAllianceList();
            ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance();
            ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(_arg_1, _arg_2, _arg_3);
        }

        public static function getUpdatedTroopProduceQueue(_arg_1:int, _arg_2:Function=null):void
        {
            validateBuildRequirements(_arg_1);
            ActionFactory.getInstance().getTroopCommands().getProduceQueue(_arg_1, _arg_2);
        }

        public static function callBackHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):void
        {
            getBuildRequirements(_arg_1, BuildingConstants.TYPE_HEROS_MANSION);
            ActionFactory.getInstance().getHeroCommand().callBackHero(_arg_1, _arg_2, _arg_3);
        }


    }
}//package autoevony.common

