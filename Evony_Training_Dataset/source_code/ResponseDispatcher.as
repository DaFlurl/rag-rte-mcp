// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.response.ResponseDispatcher

package com.evony.client.response
{
    import flash.events.EventDispatcher;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.NoListenerEvent;
    import com.evony.common.MouseManager;
    import com.evony.common.module.troop.ProduceQueueResponse;
    import com.evony.common.server.events.ChangeName;
    import com.evony.common.module.common.GetDeclaredWarResponse;
    import com.evony.common.server.events.ColonyUpdate;
    import com.evony.common.server.events.StrategyBuff;
    import com.evony.common.module.alliance.AllianceMembersResponse;
    import com.evony.common.server.events.ResourceUpdate;
    import com.evony.common.module.alliance.AllianceFriendshipResponse;
    import com.evony.common.module.common.ChatResponse;
    import com.evony.common.module.report.ReportResponse;
    import com.evony.common.module.furlough.FurloughResponse;
    import com.evony.common.server.events.ChannelChatMsg;
    import com.evony.common.module.alliance.PlayerInfoResponse;
    import com.evony.common.module.capital.CapitalCommandResponse;
    import com.evony.common.server.events.InjuredTroopUpdate;
    import com.evony.common.module.hero.HeroListResponse;
    import com.evony.common.module.gemstone.GemstoneRespone;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.common.server.events.SelfArmysUpdate;
    import com.evony.common.module.visit.GetHelpedPlayersResponse;
    import com.evony.common.module.interior.ResourceProduceDataResponse;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import com.evony.common.module.npchero.NpcHeroListResponse;
    import com.evony.common.module.trade.TradeListResponse;
    import com.evony.common.server.events.QuestCompleteTipResponse;
    import com.evony.common.module.castle.CoinsNeedResponse;
    import com.evony.common.module.gamblingranking.GamblingRankingRespone;
    import com.evony.common.module.alliance.AllianceUserAddResponse;
    import com.evony.common.module.friend.FriendResponse;
    import com.evony.common.module.quest.QuestListResponse;
    import com.evony.common.server.events.AcademyResearchUpdate;
    import com.evony.common.module.common.GetProtectOptionResponse;
    import com.evony.common.module.common.TroopConfigResponse;
    import com.evony.common.module.common.MapInfoSimpleResponse;
    import com.evony.common.server.events.VisitorHelpEvent;
    import com.evony.common.module.colony.ColonyLevyeRespone;
    import com.evony.common.server.events.ConnectionLost;
    import com.evony.common.module.hero.RandomHeroResponse;
    import com.evony.common.module.alliance.HasAllianceResponse;
    import com.evony.common.module.castle.AvailableBuilingListResponse;
    import com.evony.common.module.common.GetItemDefResponse;
    import com.evony.common.module.report.ShareReportResponse;
    import com.evony.common.module.field.OtherFieldInfoResponse;
    import com.evony.common.module.mail.TVResponse;
    import com.evony.common.server.events.AllianceChatMsg;
    import com.evony.common.module.city.StoreListResponse;
    import com.evony.common.module.tech.AvailableResearchListResponse;
    import com.evony.common.module.celeb.CelebResponse;
    import com.evony.common.module.fortifications.FortProduceListResponse;
    import com.evony.common.module.gamemaster.CreateHeroResponse;
    import com.evony.common.module.commission.CommissionQuestRespone;
    import com.evony.common.server.events.EquipmentResearchCompleteUpdate;
    import com.evony.common.module.rank.RankPlayerResponse;
    import com.evony.common.module.field.CastleFieldInfoResponse;
    import com.evony.common.module.alliance.MilitarySituationListResponse;
    import com.evony.common.module.alliance.AllianceListResponse;
    import com.evony.common.module.alliance.AllianceInfoResponse;
    import com.evony.common.server.events.CastleUpdate;
    import com.evony.common.module.common.ChangeNameResponse;
    import com.evony.common.module.shop.BuyResourceInfoResponse;
    import com.evony.common.module.shop.UseItemResultResponse;
    import com.evony.common.server.events.FriendArmysUpdate;
    import com.evony.common.server.events.RegisterResponse;
    import com.evony.common.server.events.MercenaryUpdate;
    import com.evony.common.module.common.MapCastleResponse;
    import com.evony.common.module.rank.RankPlayerVotesResponse;
    import com.evony.common.server.events.PrivateChatMessage;
    import com.evony.common.server.events.SecurityCodeRemovedEvent;
    import com.evony.common.module.commission.CommissionQuestArmyRespone;
    import com.evony.common.module.common.ChangeUserFaceResponse;
    import com.evony.common.module.trade.TransingTradeListResponse;
    import com.evony.common.module.alliance.AllianceInviteOnClientBeanResponse;
    import com.evony.common.module.mail.MailListResponse;
    import com.evony.common.server.events.DeclaredWarStatusChange;
    import com.evony.common.module.common.GetPackageListResponse;
    import com.evony.common.module.colony.ColonialCastlesRespone;
    import com.evony.common.module.alliance.AllianceInviteBeanResponse;
    import com.evony.common.module.colony.ColonialDeployResponse;
    import com.evony.common.module.common.CreatePlayerResponse;
    import com.evony.common.module.alliance.AllianceArmyResponse;
    import com.evony.common.module.alliance.WantedAllianceResponse;
    import com.evony.common.server.events.BuildingQueueUpdate;
    import com.evony.common.module.common.GetCanDeclaredWarAgainstPlayerRespone;
    import com.evony.common.module.quest.QuestTypeResponse;
    import com.evony.common.module.castle.CheckOutBuildingResponse;
    import com.evony.common.module.alliance.AlliancePowerLevelResponse;
    import com.evony.common.module.mail.MailResponse;
    import com.evony.common.server.events.PlayerBuffUpdate;
    import com.evony.common.module.troop.TroopProduceListResponse;
    import com.evony.common.module.report.ReportListResponse;
    import com.evony.common.server.events.PackageList;
    import com.evony.common.server.events.CelebRankCompleteTipResponse;
    import com.evony.common.server.events.PlayerInfoUpdate;
    import com.evony.common.server.events.UnregisteredCreatePlayerResponse;
    import com.evony.common.module.common.GetIsSecurityCodeSettedResponse;
    import com.evony.common.server.events.CastleFieldUpdate;
    import com.evony.common.module.alliance.AllianceEventListResponse;
    import com.evony.common.server.events.GetPlayerVoteInfro;
    import com.evony.common.module.rank.RankHeroResponse;
    import com.evony.common.module.common.ZoneInfoResponse;
    import com.evony.common.module.army.TroopParamResponse;
    import com.evony.common.module.gamblingranking.GamblingRankingRewardRespone;
    import com.evony.common.server.events.WorldChatMsg;
    import com.evony.common.module.rank.RankAllianceResponse;
    import com.evony.common.server.events.TradesUpdate;
    import com.evony.common.server.events.TransingTradeUpdate;
    import com.evony.common.module.castle.CastleSignResponse;
    import com.evony.common.server.events.TroopUpdate;
    import com.evony.common.module.visit.GetAllVisitorCommentsResponse;
    import com.evony.common.server.events.SystemInfoMsg;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
    import com.evony.common.server.events.DeclaredWarUpdate;
    import com.evony.common.server.events.LoginResponse;
    import com.evony.common.module.hero.DisappearHeroResponse;
    import com.evony.common.module.quest.QuestRewardRespone;
    import com.evony.common.server.events.NewReport;
    import com.evony.common.server.events.FleeTroopUpdate;
    import com.evony.common.module.common.GetPackageResponse;
    import com.evony.common.module.common.MapInfoResponse;
    import com.evony.common.module.army.ArmyPracticeResponse;
    import com.evony.common.module.quest.EffortListResponse;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.common.server.events.FortificationsUpdate;
    import com.evony.common.server.events.ItemUpdate;
    import com.evony.common.server.events.HeroUpdate;
    import com.evony.common.server.events.ResearchCompleteUpdate;
    import com.evony.common.server.events.NewFinishedQuest;
    import com.evony.common.server.events.CbUpdate;
    import com.evony.common.server.events.GetTopVotesPlayer;
    import com.evony.common.module.common.GetPackageNumberResponse;
    import com.evony.common.module.army.StayAllianceReponse;
    import com.evony.common.server.events.ItemBuff;
    import com.evony.common.server.events.NewMail;
    import com.evony.common.server.events.CastleBuffUpdate;
    import com.evony.common.module.commission.CommissionQuestArmyInfoRespone;
    import com.evony.common.module.colony.ColonialArmyResponse;
    import com.evony.common.module.trade.SearchTradesResponse;
    import com.evony.common.server.events.QuestFinished;
    import com.evony.common.server.events.EnemyArmysUpdate;
    import com.evony.common.module.common.GetRelationshipRespone;
    import com.evony.common.module.rank.TopVotesPlayersResponse;
    import com.evony.common.server.events.KickedOut;
    import com.evony.common.module.rank.RankCastleResponse;
    import com.evony.common.module.hero.SetShowInfroResponse;
    import com.evony.common.server.events.*;
    import com.evony.common.module.common.*;
    import com.evony.common.module.alliance.*;

    public class ResponseDispatcher extends EventDispatcher 
    {

        public static const ALLIANCE_ADD_USERTO_ALLIANCE:String = "alliance.addUsertoAlliance";
        public static const ALLIANCE_ADD_USERTO_ALLIANCE_LIST:String = "alliance.addUsertoAllianceList";
        public static const ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER:String = "alliance.agreeComeinAllianceByLeader";
        public static const ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_USER:String = "alliance.agreeComeinAllianceByUser";
        public static const ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST:String = "alliance.agreeComeinAllianceList";
        public static const ALLIANCE_CANCEL_USER_WANT_IN_ALLIANCE:String = "alliance.cancelUserWantInAlliance";
        public static const ALLIANCE_CANCELADD_USERTO_ALLIANCE:String = "alliance.canceladdUsertoAlliance";
        public static const ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE:String = "alliance.cancelagreeComeinAlliance";
        public static const ALLIANCE_CREATE_ALLIANCE:String = "alliance.createAlliance";
        public static const ALLIANCE_DROP_ALLIANCE_FRIENDSHIP_RELATION:String = "alliance.dropAllianceFriendshipRelation";
        public static const ALLIANCE_GET_ALLIANCE_ARMY_REPORT:String = "alliance.getAllianceArmyReport";
        public static const ALLIANCE_GET_ALLIANCE_EVENT_LIST:String = "alliance.getAllianceEventList";
        public static const ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST:String = "alliance.getAllianceFriendshipList";
        public static const ALLIANCE_GET_ALLIANCE_INFO:String = "alliance.getAllianceInfo";
        public static const ALLIANCE_GET_ALLIANCE_LIST:String = "alliance.getAllianceList";
        public static const ALLIANCE_GET_ALLIANCE_MEMBERS:String = "alliance.getAllianceMembers";
        public static const ALLIANCE_GET_ALLIANCE_WANTED:String = "alliance.getAllianceWanted";
        public static const ALLIANCE_GET_MILITARY_SITUATION_LIST:String = "alliance.getMilitarySituationList";
        public static const ALLIANCE_GET_POWER_FROM_ALLIANCE:String = "alliance.getPowerFromAlliance";
        public static const ALLIANCE_IS_HAS_ALLIANCE:String = "alliance.isHasAlliance";
        public static const ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE:String = "alliance.kickOutMemberfromAlliance";
        public static const ALLIANCE_LEADER_WANT_USER_IN_ALLIANCE_LIST:String = "alliance.leaderWantUserInAllianceList";
        public static const ALLIANCE_MESSAGES_FOR_ALLIANCE_MEMBER:String = "alliance.messagesForAllianceMember";
        public static const ALLIANCE_REJECT_COMEIN_ALLIANCE:String = "alliance.rejectComeinAlliance";
        public static const ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE:String = "alliance.resetTopPowerForAlliance";
        public static const ALLIANCE_RESIGN_FOR_ALLIANCE:String = "alliance.resignForAlliance";
        public static const ALLIANCE_SAY_BYETO_ALLIANCE:String = "alliance.sayByetoAlliance";
        public static const ALLIANCE_SET_ALL_INFO_FOR_ALLIANCE:String = "alliance.setAllInfoForAlliance";
        public static const ALLIANCE_SET_ALLIANCE_FRIENDSHIP:String = "alliance.setAllianceFriendship";
        public static const ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE:String = "alliance.setPowerForUserByAlliance";
        public static const ALLIANCE_USER_WANT_IN_ALLIANCE:String = "alliance.userWantInAlliance";
        public static const ARMY_CALL_BACK_ARMY:String = "army.callBackArmy";
        public static const ARMY_CURE_INJURED_TROOP:String = "army.cureInjuredTroop";
        public static const ARMY_DISBAND_FLEE_TROOP:String = "army.disbandFleeTroop";
        public static const ARMY_DISBAND_INJURED_TROOP:String = "army.disbandInjuredTroop";
        public static const ARMY_EXERCISE_ARMY:String = "army.exerciseArmy";
        public static const ARMY_GET_FLEE_TROOP:String = "army.getFleeTroop";
        public static const ARMY_GET_INJURED_TROOP:String = "army.getInjuredTroop";
        public static const ARMY_GET_STAY_ALLIANCE_ARMYS:String = "army.getStayAllianceArmys";
        public static const ARMY_GET_TROOP_PARAM:String = "army.getTroopParam";
        public static const ARMY_NEW_ARMY:String = "army.newArmy";
        public static const ARMY_RECRUIT_FLEE_TROOP:String = "army.recruitFleeTroop";
        public static const ARMY_SET_ALLOW_ALLIANCE_ARMY:String = "army.setAllowAllianceArmy";
        public static const ARMY_SET_ARMY_GO_OUT:String = "army.setArmyGoOut";
        public static const CAPITAL_GET_LEFT_POLICIES_TIMES:String = "capital.getLeftPoliciesTimes";
        public static const CAPITAL_GET_USED_POLICIES_TIMES:String = "capital.getUsedPoliciesTimes";
        public static const CAPITAL_LEVY_ARMY:String = "capital.levyArmy";
        public static const CAPITAL_LEVY_FOOD:String = "capital.levyFood";
        public static const CAPITAL_LEVY_POPULATION:String = "capital.levyPopulation";
        public static const CAPITAL_LEVY_TAXES:String = "capital.levyTaxes";
        public static const CAPITAL_REDUCE_ARMAMENTS:String = "capital.reduceArmaments";
        public static const CASTLE__UPDATE_CASTLE_RESOURCES:String = "castle.UpdateCastleResources";
        public static const CASTLE_CANCEL_BUILDING_QUEUE:String = "castle.cancelBuildingQueue";
        public static const CASTLE_CANCLE_BUILD_COMMAND:String = "castle.cancleBuildCommand";
        public static const CASTLE_CHECK_OUT_UPGRADE:String = "castle.checkOutUpgrade";
        public static const CASTLE_DELETE_CASTLE_SIGN:String = "castle.deleteCastleSign";
        public static const CASTLE_DEMOLISH_BUILDING_QUEUE:String = "castle.demolishBuildingQueue";
        public static const CASTLE_DESTRUCT_BUILDING:String = "castle.destructBuilding";
        public static const CASTLE_GET_AVAILABLE_BUILDING_BEAN:String = "castle.getAvailableBuildingBean";
        public static const CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE:String = "castle.getAvailableBuildingListInside";
        public static const CASTLE_GET_AVAILABLE_BUILDING_LIST_OUTSIDE:String = "castle.getAvailableBuildingListOutside";
        public static const CASTLE_GET_BUILDING_QUEUE_COINS_NEED:String = "castle.getBuildingQueueCoinsNeed";
        public static const CASTLE_GET_COINS_NEED:String = "castle.getCoinsNeed";
        public static const CASTLE_GET_DESTRUCT_BUILD_BEAN:String = "castle.getDestructBuildBean";
        public static const CASTLE_NEW_BUILDING:String = "castle.newBuilding";
        public static const CASTLE_NEW_BUILDING_QUEUE:String = "castle.newBuildingQueue";
        public static const CASTLE_SAVE_CASTLE_SIGN_LIST:String = "castle.saveCastleSignList";
        public static const CASTLE_SPEED_UP_BUILD_COMMAND:String = "castle.speedUpBuildCommand";
        public static const CASTLE_SPEEDUP_BUILDING_QUEUE:String = "castle.speedupBuildingQueue";
        public static const CASTLE_UPGRADE_BUILDING:String = "castle.upgradeBuilding";
        public static const CELEB_FIND_ALLIANCE_BY_PRESTIGE:String = "celeb.findAllianceByPrestige";
        public static const CELEB_FIND_PLAYER_BY_PRESTIGE:String = "celeb.findPlayerByPrestige";
        public static const CELEB_FIND_PLAYER_BY_STAR:String = "celeb.findPlayerByStar";
        public static const CELEB_FIND_PLAYER_BY_TITLE:String = "celeb.findPlayerByTitle";
        public static const CITY__WAR_MOVE_CASTLE:String = "city.WarMoveCastle";
        public static const CITY_ADV_MOVE_CASTLE:String = "city.advMoveCastle";
        public static const CITY_CONSTRUCT_CASTLE:String = "city.constructCastle";
        public static const CITY_GET_STORE_LIST:String = "city.getStoreList";
        public static const CITY_GIVEUP_CASTLE:String = "city.giveupCastle";
        public static const CITY_MODIFY_CASTLE_ICON:String = "city.modifyCastleIcon";
        public static const CITY_MODIFY_CASTLE_NAME:String = "city.modifyCastleName";
        public static const CITY_MODIFY_FLAG:String = "city.modifyFlag";
        public static const CITY_MODIFY_STORE_PERCENT:String = "city.modifyStorePercent";
        public static const CITY_MODIFY_USER_NAME:String = "city.modifyUserName";
        public static const CITY_MOVE_CASTLE:String = "city.moveCastle";
        public static const CITY_SET_STOP_WAR_STATE:String = "city.setStopWarState";
        public static const CITY_UNITE_ADV_MOVE_CASTLE:String = "city.uniteAdvMoveCastle";
        public static const COLONY_ABANDON_COLONY:String = "colony.abandonColony";
        public static const COLONY_GET_COLONIAL_ARMY_INFO:String = "colony.getColonialArmyInfo";
        public static const COLONY_GET_COLONIAL_CASTLES_INFO:String = "colony.getColonialCastlesInfo";
        public static const COLONY_GET_DEPLOY_TROOPS_INFO:String = "colony.getDeployTroopsInfo";
        public static const COLONY_GET_SUZERAIN_COLONIAL_CASTLES_INFO:String = "colony.getSuzerainColonialCastlesInfo";
        public static const COLONY_LEVY_ARMY:String = "colony.levyArmy";
        public static const COLONY_LEVY_FOOD:String = "colony.levyFood";
        public static const COLONY_LEVY_POPULATION:String = "colony.levyPopulation";
        public static const COLONY_LEVY_TAXES:String = "colony.levyTaxes";
        public static const COLONY_OVERVIEW_COLONIAL_CASTLE:String = "colony.overviewColonialCastle";
        public static const COLONY_REDUCE_ARMAMENTS:String = "colony.reduceArmaments";
        public static const COLONY_SET_DEPLOY_TROOPS:String = "colony.setDeployTroops";
        public static const COLONY_SOW_DISCORD:String = "colony.sowDiscord";
        public static const COLONY_SPEED_UP_ABANDON_COLONY:String = "colony.speedUpAbandonColony";
        public static const COLONY_UPRISE:String = "colony.uprise";
        public static const COMMISSION_ACCEPT_COMMISSION_QUEST:String = "commission.acceptCommissionQuest";
        public static const COMMISSION_ADD_COMMISSION_QUEST_ARMY:String = "commission.addCommissionQuestArmy";
        public static const COMMISSION_DECLINE_COMMISSION_QUEST:String = "commission.declineCommissionQuest";
        public static const COMMISSION_GET_ALL_COMMISSION_QUEST:String = "commission.getAllCommissionQuest";
        public static const COMMISSION_GET_COMMISSION_QUEST_ARMY_INFO:String = "commission.getCommissionQuestArmyInfo";
        public static const COMMISSION_GET_COMMISSION_QUEST_ARMY_RANKING:String = "commission.getCommissionQuestArmyRanking";
        public static const COMMISSION_GET_MY_ACCEPTED_COMMISSION_QUEST:String = "commission.getMyAcceptedCommissionQuest";
        public static const COMMISSION_GET_MY_COMMISSION_QUEST:String = "commission.getMyCommissionQuest";
        public static const COMMISSION_ISSUE_COMMISSION_QUEST:String = "commission.issueCommissionQuest";
        public static const COMMON_ADD_TO_FAVORITES:String = "common.addToFavorites";
        public static const COMMON_ALLIANCE_CHAT:String = "common.allianceChat";
        public static const COMMON_AUTH_SECURITY_CODE:String = "common.authSecurityCode";
        public static const COMMON_CANCEL_REMOVING_SECURITY_CODE_PROCESS:String = "common.cancelRemovingSecurityCodeProcess";
        public static const COMMON_CHANGE_HEADLINE:String = "common.changeHeadline";
        public static const COMMON_CHANGE_NAME:String = "common.changeName";
        public static const COMMON_CHANGE_SECURITY_CODE:String = "common.changeSecurityCode";
        public static const COMMON_CHANGE_USER_FACE:String = "common.changeUserFace";
        public static const COMMON_CHANNEL_CHAT:String = "common.channelChat";
        public static const COMMON_CREATE_NEW_PLAYER:String = "common.createNewPlayer";
        public static const COMMON_DECLARED_WAR_AGAINST_PLAYER:String = "common.declaredWarAgainstPlayer";
        public static const COMMON_DEL_UNITE_SERVER_PEACE_STATUS:String = "common.delUniteServerPeaceStatus";
        public static const COMMON_DELETE_USER_AND_RESTART:String = "common.deleteUserAndRestart";
        public static const COMMON_DENY_PLAYER_SPEAK:String = "common.denyPlayerSpeak";
        public static const COMMON_FACEBOOK_CONNECT:String = "common.facebookConnect";
        public static const COMMON_GET_CAN_DECLARED_WAR_AGAINST_PLAYER:String = "common.getCanDeclaredWarAgainstPlayer";
        public static const COMMON_GET_IS_SECURITY_CODE_SETTED:String = "common.getIsSecurityCodeSetted";
        public static const COMMON_GET_ITEM_DEF_XML:String = "common.getItemDefXml";
        public static const COMMON_GET_PACKAGE:String = "common.getPackage";
        public static const COMMON_GET_PACKAGE_LIST:String = "common.getPackageList";
        public static const COMMON_GET_PACKAGE_NUMBER:String = "common.getPackageNumber";
        public static const COMMON_GET_PLAYER_DECLARED_WAR_STATUS:String = "common.getPlayerDeclaredWarStatus";
        public static const COMMON_GET_PLAYER_INFO_BY_NAME:String = "common.getPlayerInfoByName";
        public static const COMMON_GET_PROTECT_OPTION:String = "common.getProtectOption";
        public static const COMMON_GET_RELATIONSHIP:String = "common.getRelationship";
        public static const COMMON_MAP_CASTLE:String = "common.mapCastle";
        public static const COMMON_MAP_INFO:String = "common.mapInfo";
        public static const COMMON_MAP_INFO_SIMPLE:String = "common.mapInfoSimple";
        public static const COMMON_PRIVATE_CHAT:String = "common.privateChat";
        public static const COMMON_REMOVE_SECURITY_CODE:String = "common.removeSecurityCode";
        public static const COMMON_SAVE_UNREGISTERED_PLAYER:String = "common.saveUnregisteredPlayer";
        public static const COMMON_SET_AUTO_HEAL:String = "common.setAutoHeal";
        public static const COMMON_SET_EOVNY_MEMBER:String = "common.setEovnyMember";
        public static const COMMON_SET_EVENT_DONE:String = "common.setEventDone";
        public static const COMMON_SET_EVONY_MEMBER_E_MAIL:String = "common.setEvonyMemberEMail";
        public static const COMMON_SET_PROTECT_OPTION:String = "common.setProtectOption";
        public static const COMMON_SET_RECEIVE_INCOMING_ATTACK:String = "common.setReceiveIncomingAttack";
        public static const COMMON_SET_RETURN_REPORT:String = "common.setReturnReport";
        public static const COMMON_SET_SECURITY_CODE:String = "common.setSecurityCode";
        public static const COMMON_SET_TROOP_CONFIG:String = "common.setTroopConfig";
        public static const COMMON_SET_UNLOCK_OPTION:String = "common.setUnlockOption";
        public static const COMMON_STEP:String = "common.step";
        public static const COMMON_WORLD_CHAT:String = "common.worldChat";
        public static const COMMON_ZONE_INFO:String = "common.zoneInfo";
        public static const EQUIPMENT__ENHANCED_BY_GEM_STONE:String = "equipment.EnhancedByGemStone";
        public static const EQUIPMENT__ENHANCED_STAR_BY_GEM_STONE:String = "equipment.EnhancedStarByGemStone";
        public static const EQUIPMENT__TAKE_OFF_ALL_EQUIPMENTTECH:String = "equipment.TakeOffAllEquipmenttech";
        public static const EQUIPMENT__TAKE_OFF_EQUIPMENTTECH:String = "equipment.TakeOffEquipmenttech";
        public static const EQUIPMENT__WEAR_ALL_EQUIPMENTTECH:String = "equipment.WearAllEquipmenttech";
        public static const EQUIPMENT__WEAR_EQUIPMENTTECH:String = "equipment.WearEquipmenttech";
        public static const EQUIPMENTTECH_CANCEL_RESEARCH:String = "equipmenttech.cancelResearch";
        public static const EQUIPMENTTECH_GET_COINS_NEED:String = "equipmenttech.getCoinsNeed";
        public static const EQUIPMENTTECH_GET_RESEARCH_LIST:String = "equipmenttech.getResearchList";
        public static const EQUIPMENTTECH_RESEARCH:String = "equipmenttech.research";
        public static const EQUIPMENTTECH_SPEED_UP_RESEARCH:String = "equipmenttech.speedUpResearch";
        public static const FIELD_GET_CASTLE_FIELD_INFO:String = "field.getCastleFieldInfo";
        public static const FIELD_GET_OTHER_FIELD_INFO:String = "field.getOtherFieldInfo";
        public static const FIELD_GIVE_UP_FIELD:String = "field.giveUpField";
        public static const FORTIFICATIONS_ACC_TROOP_PRODUCE:String = "fortifications.accTroopProduce";
        public static const FORTIFICATIONS_CANCEL_FORTIFICATION_PRODUCE:String = "fortifications.cancelFortificationProduce";
        public static const FORTIFICATIONS_DESTRUCT_WALL_PROTECT:String = "fortifications.destructWallProtect";
        public static const FORTIFICATIONS_GET_FORTIFICATIONS_PRODUCE_LIST:String = "fortifications.getFortificationsProduceList";
        public static const FORTIFICATIONS_GET_PRODUCE_QUEUE:String = "fortifications.getProduceQueue";
        public static const FORTIFICATIONS_PRODUCE_WALL_PROTECT:String = "fortifications.produceWallProtect";
        public static const FRIEND_ADD_BLOCK:String = "friend.addBlock";
        public static const FRIEND_ADD_FRIEND:String = "friend.addFriend";
        public static const FRIEND_DELETE_BLOCK:String = "friend.deleteBlock";
        public static const FRIEND_DELETE_FRIEND:String = "friend.deleteFriend";
        public static const FRIEND_IS_BLOCK_MAIL_PLAYER:String = "friend.isBlockMailPlayer";
        public static const FURLOUGH_CANCEL_FURLOUGHT:String = "furlough.cancelFurlought";
        public static const FURLOUGH_IS_FURLOUGHT:String = "furlough.isFurlought";
        public static const GAMBLINGRANKING_GET_GAMBLING_RANKING_REWARD:String = "gamblingranking.getGamblingRankingReward";
        public static const GAMBLINGRANKING_GET_GAMBLING_RANKING_TODAY:String = "gamblingranking.getGamblingRankingToday";
        public static const GAMBLINGRANKING_GET_GAMBLING_RANKING_YESTERDAY:String = "gamblingranking.getGamblingRankingYesterday";
        public static const GAMEMASTER_ADD_BUILDING:String = "gamemaster.addBuilding";
        public static const GAMEMASTER_ADD_HERO:String = "gamemaster.addHero";
        public static const GAMEMASTER_ADD_ITEMS:String = "gamemaster.addItems";
        public static const GAMEMASTER_REMOVE_BUILDING:String = "gamemaster.removeBuilding";
        public static const GAMEMASTER_REMOVE_HERO:String = "gamemaster.removeHero";
        public static const GAMEMASTER_REMOVE_ITEM:String = "gamemaster.removeItem";
        public static const GAMEMASTER_SET_RESOURCES:String = "gamemaster.setResources";
        public static const GAMEMASTER_SET_TECHNOLOGY:String = "gamemaster.setTechnology";
        public static const HERO__GEN_SAVE_RANDOM_HERO:String = "hero.GenSaveRandomHero";
        public static const HERO__GET_DISAPPEAR_HEROS:String = "hero.GetDisappearHeros";
        public static const HERO__GET_RANDOM_HERO:String = "hero.GetRandomHero";
        public static const HERO__RECOVER_DISAPPEAR_HERO:String = "hero.RecoverDisappearHero";
        public static const HERO__RET_SET_HERO_ATTRI:String = "hero.RetSetHeroAttri";
        public static const HERO__SET_SHOW_HERO_ID:String = "hero.SetShowHeroId";
        public static const HERO__SHOW_PLAYER_HEROS_BY_USER_NAME:String = "hero.ShowPlayerHerosByUserName";
        public static const HERO_ADD_POINT:String = "hero.addPoint";
        public static const HERO_ADD_POINT2:String = "hero.addPoint2";
        public static const HERO_AWARD_GOLD:String = "hero.awardGold";
        public static const HERO_CALL_BACK_HERO:String = "hero.callBackHero";
        public static const HERO_CHANGE_NAME:String = "hero.changeName";
        public static const HERO_DISCHARGE_CHIEF:String = "hero.dischargeChief";
        public static const HERO_FIRE_HERO:String = "hero.fireHero";
        public static const HERO_GET_FLEE_HERO_LIST:String = "hero.getFleeHeroList";
        public static const HERO_GET_HEROS_LIST_FROM_TAVERN:String = "hero.getHerosListFromTavern";
        public static const HERO_HIRE_FACEBOOK_FRIEND_HERO:String = "hero.hireFacebookFriendHero";
        public static const HERO_HIRE_HERO:String = "hero.hireHero";
        public static const HERO_LEVEL_UP:String = "hero.levelUp";
        public static const HERO_PROMOTE_TO_CHIEF:String = "hero.promoteToChief";
        public static const HERO_RECRUIT_FLEE_HERO:String = "hero.recruitFleeHero";
        public static const HERO_REFRESH_HEROS_LIST_FROM_TAVERN:String = "hero.refreshHerosListFromTavern";
        public static const HERO_RELEASE_HERO:String = "hero.releaseHero";
        public static const HERO_RESET_POINT:String = "hero.resetPoint";
        public static const HERO_SET_HERO_FACEBOOK_ID:String = "hero.setHeroFacebookId";
        public static const HERO_TRY_GET_SEIZED_HERO:String = "hero.tryGetSeizedHero";
        public static const HERO_USE_ITEM:String = "hero.useItem";
        public static const INTERIOR_GET_RESOURCE_PRODUCE_DATA:String = "interior.getResourceProduceData";
        public static const INTERIOR_MODIFY_COMMENCE_RATE:String = "interior.modifyCommenceRate";
        public static const INTERIOR_MODIFY_TAX_RATE:String = "interior.modifyTaxRate";
        public static const INTERIOR_PACIFY_PEOPLE:String = "interior.pacifyPeople";
        public static const INTERIOR_TAXATION:String = "interior.taxation";
        public static const MAIL_DELETE_MAIL:String = "mail.deleteMail";
        public static const MAIL_GET_ALL_T_V_MSG:String = "mail.getAllTVMsg";
        public static const MAIL_READ_MAIL:String = "mail.readMail";
        public static const MAIL_READ_OVER_MAIL_LIST:String = "mail.readOverMailList";
        public static const MAIL_RECEIVE_MAIL_LIST:String = "mail.receiveMailList";
        public static const MAIL_REPORT_BUG:String = "mail.reportBug";
        public static const MAIL_REPORT_PLAYER:String = "mail.reportPlayer";
        public static const MAIL_SEND_MAIL:String = "mail.sendMail";
        public static const NPCHERO_GET_NPC_HERO_INFRO_BY_I_D:String = "npchero.getNpcHeroInfroByID";
        public static const NPCHERO_GET_NPC_HEROS_LIST:String = "npchero.getNpcHerosList";
        public static const NPCHERO_GET_NPC_HEROS_LIST_BY_FILTER:String = "npchero.getNpcHerosListByFilter";
        public static const NPCHERO_GET_NPC_HEROS_LIST_BY_MONEY:String = "npchero.getNpcHerosListByMoney";
        public static const QUEST_ABANDON:String = "quest.abandon";
        public static const QUEST_ACCEPT:String = "quest.accept";
        public static const QUEST_AWARD:String = "quest.award";
        public static const QUEST_AWARD_PACKET:String = "quest.awardPacket";
        public static const QUEST_DONATE:String = "quest.donate";
        public static const QUEST_GET_AWARD_ITEMS:String = "quest.getAwardItems";
        public static const QUEST_GET_EFFORT_LIST:String = "quest.getEffortList";
        public static const QUEST_GET_EFFORT_LIST_BY_TARGE_TYPEID:String = "quest.getEffortListByTargeTypeid";
        public static const QUEST_GET_QUEST_LIST:String = "quest.getQuestList";
        public static const QUEST_GET_QUEST_TYPE:String = "quest.getQuestType";
        public static const RANK_GET_ALLIANCE_RANK:String = "rank.getAllianceRank";
        public static const RANK_GET_CASTLE_RANK:String = "rank.getCastleRank";
        public static const RANK_GET_HERO_RANK:String = "rank.getHeroRank";
        public static const RANK_GET_PLAYER_RANK:String = "rank.getPlayerRank";
        public static const RANK_GET_TOP_VOTES_PLAYER:String = "rank.getTopVotesPlayer";
        public static const RANK_GET_VOTE_RANK:String = "rank.getVoteRank";
        public static const REPORT_DELETE_ALL_REPORTS:String = "report.deleteAllReports";
        public static const REPORT_DELETE_REPORT:String = "report.deleteReport";
        public static const REPORT_MARK_AS_READ:String = "report.markAsRead";
        public static const REPORT_READ_OVER_REPORT:String = "report.readOverReport";
        public static const REPORT_RECEIVE_REPORT_LIST:String = "report.receiveReportList";
        public static const REPORT_SHARE_REPORT:String = "report.shareReport";
        public static const SERVER_ACADEMY_RESEARCH_UPDATE:String = "server.AcademyResearchUpdate";
        public static const SERVER_ALLIANCE_CHAT_MSG:String = "server.AllianceChatMsg";
        public static const SERVER_BUILD_COMPLATE:String = "server.BuildComplate";
        public static const SERVER_BUILDING_QUEUE_UPDATE:String = "server.BuildingQueueUpdate";
        public static const SERVER_CASTLE_BUFF_UPDATE:String = "server.CastleBuffUpdate";
        public static const SERVER_CASTLE_FIELD_UPDATE:String = "server.CastleFieldUpdate";
        public static const SERVER_CASTLE_UPDATE:String = "server.CastleUpdate";
        public static const SERVER_CB_UPDATE:String = "server.CbUpdate";
        public static const SERVER_CELEB_RANK_COMPLETE_TIP_RESPONSE:String = "server.CelebRankCompleteTipResponse";
        public static const SERVER_CHANGE_NAME:String = "server.ChangeName";
        public static const SERVER_CHANNEL_CHAT_MSG:String = "server.ChannelChatMsg";
        public static const SERVER_COLONY_UPDATE:String = "server.ColonyUpdate";
        public static const SERVER_CONNECTION_LOST:String = "server.ConnectionLost";
        public static const SERVER_DECLARED_WAR_STATUS_CHANGE:String = "server.DeclaredWarStatusChange";
        public static const SERVER_DECLARED_WAR_UPDATE:String = "server.DeclaredWarUpdate";
        public static const SERVER_ENEMY_ARMYS_UPDATE:String = "server.EnemyArmysUpdate";
        public static const SERVER_EQUIPMENT_RESEARCH_COMPLETE_UPDATE:String = "server.EquipmentResearchCompleteUpdate";
        public static const SERVER_FLEE_TROOP_UPDATE:String = "server.FleeTroopUpdate";
        public static const SERVER_FORTIFICATIONS_UPDATE:String = "server.FortificationsUpdate";
        public static const SERVER_FRIEND_ARMYS_UPDATE:String = "server.FriendArmysUpdate";
        public static const SERVER_GET_PLAYER_VOTE_INFRO:String = "server.GetPlayerVoteInfro";
        public static const SERVER_GET_TOP_VOTES_PLAYER:String = "server.GetTopVotesPlayer";
        public static const SERVER_HERO_UPDATE:String = "server.HeroUpdate";
        public static const SERVER_INJURED_TROOP_UPDATE:String = "server.InjuredTroopUpdate";
        public static const SERVER_ITEM_BUFF:String = "server.ItemBuff";
        public static const SERVER_ITEM_UPDATE:String = "server.ItemUpdate";
        public static const SERVER_KICKED_OUT:String = "server.KickedOut";
        public static const SERVER_LOGIN_RESPONSE:String = "server.LoginResponse";
        public static const SERVER_MERCENARY_UPDATE:String = "server.MercenaryUpdate";
        public static const SERVER_NEW_FINISHED_QUEST:String = "server.NewFinishedQuest";
        public static const SERVER_NEW_MAIL:String = "server.NewMail";
        public static const SERVER_NEW_REPORT:String = "server.NewReport";
        public static const SERVER_PACKAGE_LIST:String = "server.PackageList";
        public static const SERVER_PLAYER_BUFF_UPDATE:String = "server.PlayerBuffUpdate";
        public static const SERVER_PLAYER_INFO_UPDATE:String = "server.PlayerInfoUpdate";
        public static const SERVER_PRIVATE_CHAT_MESSAGE:String = "server.PrivateChatMessage";
        public static const SERVER_QUEST_COMPLETE_TIP_RESPONSE:String = "server.QuestCompleteTipResponse";
        public static const SERVER_QUEST_FINISHED:String = "server.QuestFinished";
        public static const SERVER_REGISTER_RESPONSE:String = "server.RegisterResponse";
        public static const SERVER_RESEARCH_COMPLETE_UPDATE:String = "server.ResearchCompleteUpdate";
        public static const SERVER_RESOURCE_UPDATE:String = "server.ResourceUpdate";
        public static const SERVER_SECURITY_CODE_REMOVED_EVENT:String = "server.SecurityCodeRemovedEvent";
        public static const SERVER_SELF_ARMYS_UPDATE:String = "server.SelfArmysUpdate";
        public static const SERVER_STRATEGY_BUFF:String = "server.StrategyBuff";
        public static const SERVER_SYSTEM_INFO_MSG:String = "server.SystemInfoMsg";
        public static const SERVER_TRADES_UPDATE:String = "server.TradesUpdate";
        public static const SERVER_TRANSING_TRADE_UPDATE:String = "server.TransingTradeUpdate";
        public static const SERVER_TROOP_UPDATE:String = "server.TroopUpdate";
        public static const SERVER_UNREGISTERED_CREATE_PLAYER_RESPONSE:String = "server.UnregisteredCreatePlayerResponse";
        public static const SERVER_VISITOR_HELP_EVENT:String = "server.VisitorHelpEvent";
        public static const SERVER_WORLD_CHAT_MSG:String = "server.WorldChatMsg";
        public static const SHOP__GEM__SMELTING:String = "shop.Gem_Smelting";
        public static const SHOP_BUY:String = "shop.buy";
        public static const SHOP_BUY_RESOURCE:String = "shop.buyResource";
        public static const SHOP_GET_BUY_RESOURCE_INFO:String = "shop.getBuyResourceInfo";
        public static const SHOP_USE_ANGEL_ITEM:String = "shop.useAngelItem";
        public static const SHOP_USE_CASTLE_GOODS:String = "shop.useCastleGoods";
        public static const SHOP_USE_DEVIL_ITEM:String = "shop.useDevilItem";
        public static const SHOP_USE_GOODS:String = "shop.useGoods";
        public static const SHOP_USE_TRICK_ITEM:String = "shop.useTrickItem";
        public static const STRATAGEM_USE_STRATAGEM:String = "stratagem.useStratagem";
        public static const TECH_CANCEL_RESEARCH:String = "tech.cancelResearch";
        public static const TECH_GET_COINS_NEED:String = "tech.getCoinsNeed";
        public static const TECH_GET_RESEARCH_LIST:String = "tech.getResearchList";
        public static const TECH_RESEARCH:String = "tech.research";
        public static const TECH_SPEED_UP_RESEARCH:String = "tech.speedUpResearch";
        public static const TRADE_CANCEL_TRADE:String = "trade.cancelTrade";
        public static const TRADE_GET_MY_TRADE_LIST:String = "trade.getMyTradeList";
        public static const TRADE_GET_TRANSING_TRADE_LIST:String = "trade.getTransingTradeList";
        public static const TRADE_NEW_TRADE:String = "trade.newTrade";
        public static const TRADE_SEARCH_TRADES:String = "trade.searchTrades";
        public static const TRADE_SPEED_UP_TRANS:String = "trade.speedUpTrans";
        public static const TROOP_ACC_TROOP_PRODUCE:String = "troop.accTroopProduce";
        public static const TROOP_CANCEL_TROOP_PRODUCE:String = "troop.cancelTroopProduce";
        public static const TROOP_CHECK_IDLE_BARRACK:String = "troop.checkIdleBarrack";
        public static const TROOP_DISBAND_TROOP:String = "troop.disbandTroop";
        public static const TROOP_GET_PRODUCE_QUEUE:String = "troop.getProduceQueue";
        public static const TROOP_GET_TROOP_PRODUCE_LIST:String = "troop.getTroopProduceList";
        public static const TROOP_PRODUCE_TROOP:String = "troop.produceTroop";
        public static const TRUCE_CANCEL_DREAM_TRUCE:String = "truce.cancelDreamTruce";
        public static const TRUCE_CHANGE_DREAM_TRUCE_TIME:String = "truce.changeDreamTruceTime";
        public static const TRUCE_SET_DREAM_TRUCE:String = "truce.setDreamTruce";
        public static const VISIT_DELETE_COMMENT:String = "visit.deleteComment";
        public static const VISIT_GET_ALL_VISITOR_COMMENTS:String = "visit.getAllVisitorComments";
        public static const VISIT_GET_HELPED_PLAYERS:String = "visit.getHelpedPlayers";
        public static const VISIT_GET_VISITOR_COMMENTS:String = "visit.getVisitorComments";
        public static const VISIT_HELP_INCREASE_PRODUCTION:String = "visit.helpIncreaseProduction";
        public static const VISIT_MARK_COMMENT_AS_READ:String = "visit.markCommentAsRead";
        public static const VISIT_VISITOR_COMMENT:String = "visit.visitorComment";
        public static const VOTE_VOTE_TO_PLAYER_BY_ID:String = "vote.voteToPlayerById";
        public static const VOTE_VOTE_TO_PLAYER_BY_NAME:String = "vote.voteToPlayerByName";
        private static var instance:ResponseDispatcher = new (ResponseDispatcher)();
        private static var istrace:Boolean = Version.isTraceResponseOn();

        private var onRegisterResponse:Function = null;
        private var onSelfArmysUpdate:Function = null;
        private var onPrivateChatMessage:Function = null;
        private var onKickedOut:Function = null;
        private var onNewMail:Function = null;
        private var onWorldChatMsg:Function = null;
        private var onHeroUpdate:Function = null;
        private var onTradesUpdate:Function = null;
        private var onPlayerBuffUpdate:Function = null;
        private var onDeclaredWarStatusChange:Function = null;
        private var onPlayerInfoUpdate:Function = null;
        private var onAllianceChatMsg:Function = null;
        private var onItemUpdate:Function = null;
        private var onItemBuff:Function = null;
        private var onSecurityCodeRemovedEvent:Function = null;
        private var onCbUpdate:Function = null;
        private var onGetPlayerVoteInfro:Function = null;
        private var onFriendArmysUpdate:Function = null;
        private var onMercenaryUpdate:Function = null;
        private var onBuildingQueueUpdate:Function = null;
        private var onChangeName:Function = null;
        public var _id:String = "ResponseDispatcher";
        private var onNewFinishedQuest:Function = null;
        private var onColonyUpdate:Function = null;
        private var onStrategyBuff:Function = null;
        private var actionFactory:ActionFactory;
        private var onCastleBuffUpdate:Function = null;
        private var onCastleFieldUpdate:Function = null;
        private var sender:Sender;
        private var onEnemyArmysUpdate:Function = null;
        private var onResourceUpdate:Function = null;
        private var onChannelChatMsg:Function = null;
        private var onCelebRankCompleteTipResponse:Function = null;
        private var onTransingTradeUpdate:Function = null;
        private var onFortificationsUpdate:Function = null;
        private var onResearchCompleteUpdate:Function = null;
        private var onDeclaredWarUpdate:Function = null;
        private var onPackageList:Function = null;
        private var onUnregisteredCreatePlayerResponse:Function = null;
        private var onInjuredTroopUpdate:Function = null;
        private var onConnectionLost:Function = null;
        private var onVisitorHelpEvent:Function = null;
        private var onFleeTroopUpdate:Function = null;
        private var onBuildComplate:Function = null;
        private var onSystemInfoMsg:Function = null;
        private var onLoginResponse:Function = null;
        private var onEquipmentResearchCompleteUpdate:Function = null;
        private var onGetTopVotesPlayer:Function = null;
        private var onTroopUpdate:Function = null;
        private var onCastleUpdate:Function = null;
        private var respMap:Object;
        private var onAcademyResearchUpdate:Function = null;
        private var onQuestCompleteTipResponse:Function = null;
        private var onNewReport:Function = null;
        private var onQuestFinished:Function = null;

        public function ResponseDispatcher()
        {
            this.actionFactory = ActionFactory.getInstance();
            this.respMap = new Object();
            this.respMap[ALLIANCE_ADD_USERTO_ALLIANCE] = this._resp_alliance_addUsertoAlliance;
            this.respMap[ALLIANCE_ADD_USERTO_ALLIANCE_LIST] = this._resp_alliance_addUsertoAllianceList;
            this.respMap[ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER] = this._resp_alliance_agreeComeinAllianceByLeader;
            this.respMap[ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_USER] = this._resp_alliance_agreeComeinAllianceByUser;
            this.respMap[ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST] = this._resp_alliance_agreeComeinAllianceList;
            this.respMap[ALLIANCE_CANCELADD_USERTO_ALLIANCE] = this._resp_alliance_canceladdUsertoAlliance;
            this.respMap[ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE] = this._resp_alliance_cancelagreeComeinAlliance;
            this.respMap[ALLIANCE_CANCEL_USER_WANT_IN_ALLIANCE] = this._resp_alliance_cancelUserWantInAlliance;
            this.respMap[ALLIANCE_CREATE_ALLIANCE] = this._resp_alliance_createAlliance;
            this.respMap[ALLIANCE_DROP_ALLIANCE_FRIENDSHIP_RELATION] = this._resp_alliance_dropAllianceFriendshipRelation;
            this.respMap[ALLIANCE_GET_ALLIANCE_ARMY_REPORT] = this._resp_alliance_getAllianceArmyReport;
            this.respMap[ALLIANCE_GET_ALLIANCE_EVENT_LIST] = this._resp_alliance_getAllianceEventList;
            this.respMap[ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST] = this._resp_alliance_getAllianceFriendshipList;
            this.respMap[ALLIANCE_GET_ALLIANCE_INFO] = this._resp_alliance_getAllianceInfo;
            this.respMap[ALLIANCE_GET_ALLIANCE_LIST] = this._resp_alliance_getAllianceList;
            this.respMap[ALLIANCE_GET_ALLIANCE_MEMBERS] = this._resp_alliance_getAllianceMembers;
            this.respMap[ALLIANCE_GET_ALLIANCE_WANTED] = this._resp_alliance_getAllianceWanted;
            this.respMap[ALLIANCE_GET_MILITARY_SITUATION_LIST] = this._resp_alliance_getMilitarySituationList;
            this.respMap[ALLIANCE_GET_POWER_FROM_ALLIANCE] = this._resp_alliance_getPowerFromAlliance;
            this.respMap[ALLIANCE_IS_HAS_ALLIANCE] = this._resp_alliance_isHasAlliance;
            this.respMap[ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE] = this._resp_alliance_kickOutMemberfromAlliance;
            this.respMap[ALLIANCE_LEADER_WANT_USER_IN_ALLIANCE_LIST] = this._resp_alliance_leaderWantUserInAllianceList;
            this.respMap[ALLIANCE_MESSAGES_FOR_ALLIANCE_MEMBER] = this._resp_alliance_messagesForAllianceMember;
            this.respMap[ALLIANCE_REJECT_COMEIN_ALLIANCE] = this._resp_alliance_rejectComeinAlliance;
            this.respMap[ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE] = this._resp_alliance_resetTopPowerForAlliance;
            this.respMap[ALLIANCE_RESIGN_FOR_ALLIANCE] = this._resp_alliance_resignForAlliance;
            this.respMap[ALLIANCE_SAY_BYETO_ALLIANCE] = this._resp_alliance_sayByetoAlliance;
            this.respMap[ALLIANCE_SET_ALLIANCE_FRIENDSHIP] = this._resp_alliance_setAllianceFriendship;
            this.respMap[ALLIANCE_SET_ALL_INFO_FOR_ALLIANCE] = this._resp_alliance_setAllInfoForAlliance;
            this.respMap[ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE] = this._resp_alliance_setPowerForUserByAlliance;
            this.respMap[ALLIANCE_USER_WANT_IN_ALLIANCE] = this._resp_alliance_userWantInAlliance;
            this.respMap[ARMY_CALL_BACK_ARMY] = this._resp_army_callBackArmy;
            this.respMap[ARMY_CURE_INJURED_TROOP] = this._resp_army_cureInjuredTroop;
            this.respMap[ARMY_DISBAND_FLEE_TROOP] = this._resp_army_disbandFleeTroop;
            this.respMap[ARMY_DISBAND_INJURED_TROOP] = this._resp_army_disbandInjuredTroop;
            this.respMap[ARMY_EXERCISE_ARMY] = this._resp_army_exerciseArmy;
            this.respMap[ARMY_GET_FLEE_TROOP] = this._resp_army_getFleeTroop;
            this.respMap[ARMY_GET_INJURED_TROOP] = this._resp_army_getInjuredTroop;
            this.respMap[ARMY_GET_STAY_ALLIANCE_ARMYS] = this._resp_army_getStayAllianceArmys;
            this.respMap[ARMY_GET_TROOP_PARAM] = this._resp_army_getTroopParam;
            this.respMap[ARMY_NEW_ARMY] = this._resp_army_newArmy;
            this.respMap[ARMY_RECRUIT_FLEE_TROOP] = this._resp_army_recruitFleeTroop;
            this.respMap[ARMY_SET_ALLOW_ALLIANCE_ARMY] = this._resp_army_setAllowAllianceArmy;
            this.respMap[ARMY_SET_ARMY_GO_OUT] = this._resp_army_setArmyGoOut;
            this.respMap[CAPITAL_GET_LEFT_POLICIES_TIMES] = this._resp_capital_getLeftPoliciesTimes;
            this.respMap[CAPITAL_GET_USED_POLICIES_TIMES] = this._resp_capital_getUsedPoliciesTimes;
            this.respMap[CAPITAL_LEVY_ARMY] = this._resp_capital_levyArmy;
            this.respMap[CAPITAL_LEVY_FOOD] = this._resp_capital_levyFood;
            this.respMap[CAPITAL_LEVY_POPULATION] = this._resp_capital_levyPopulation;
            this.respMap[CAPITAL_LEVY_TAXES] = this._resp_capital_levyTaxes;
            this.respMap[CAPITAL_REDUCE_ARMAMENTS] = this._resp_capital_reduceArmaments;
            this.respMap[CASTLE_CANCEL_BUILDING_QUEUE] = this._resp_castle_cancelBuildingQueue;
            this.respMap[CASTLE_CANCLE_BUILD_COMMAND] = this._resp_castle_cancleBuildCommand;
            this.respMap[CASTLE_CHECK_OUT_UPGRADE] = this._resp_castle_checkOutUpgrade;
            this.respMap[CASTLE_DELETE_CASTLE_SIGN] = this._resp_castle_deleteCastleSign;
            this.respMap[CASTLE_DEMOLISH_BUILDING_QUEUE] = this._resp_castle_demolishBuildingQueue;
            this.respMap[CASTLE_DESTRUCT_BUILDING] = this._resp_castle_destructBuilding;
            this.respMap[CASTLE_GET_AVAILABLE_BUILDING_BEAN] = this._resp_castle_getAvailableBuildingBean;
            this.respMap[CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE] = this._resp_castle_getAvailableBuildingListInside;
            this.respMap[CASTLE_GET_AVAILABLE_BUILDING_LIST_OUTSIDE] = this._resp_castle_getAvailableBuildingListOutside;
            this.respMap[CASTLE_GET_BUILDING_QUEUE_COINS_NEED] = this._resp_castle_getBuildingQueueCoinsNeed;
            this.respMap[CASTLE_GET_COINS_NEED] = this._resp_castle_getCoinsNeed;
            this.respMap[CASTLE_GET_DESTRUCT_BUILD_BEAN] = this._resp_castle_getDestructBuildBean;
            this.respMap[CASTLE_NEW_BUILDING] = this._resp_castle_newBuilding;
            this.respMap[CASTLE_NEW_BUILDING_QUEUE] = this._resp_castle_newBuildingQueue;
            this.respMap[CASTLE_SAVE_CASTLE_SIGN_LIST] = this._resp_castle_saveCastleSignList;
            this.respMap[CASTLE_SPEED_UP_BUILD_COMMAND] = this._resp_castle_speedUpBuildCommand;
            this.respMap[CASTLE_SPEEDUP_BUILDING_QUEUE] = this._resp_castle_speedupBuildingQueue;
            this.respMap[CASTLE__UPDATE_CASTLE_RESOURCES] = this._resp_castle_UpdateCastleResources;
            this.respMap[CASTLE_UPGRADE_BUILDING] = this._resp_castle_upgradeBuilding;
            this.respMap[CELEB_FIND_ALLIANCE_BY_PRESTIGE] = this._resp_celeb_findAllianceByPrestige;
            this.respMap[CELEB_FIND_PLAYER_BY_PRESTIGE] = this._resp_celeb_findPlayerByPrestige;
            this.respMap[CELEB_FIND_PLAYER_BY_STAR] = this._resp_celeb_findPlayerByStar;
            this.respMap[CELEB_FIND_PLAYER_BY_TITLE] = this._resp_celeb_findPlayerByTitle;
            this.respMap[CITY_ADV_MOVE_CASTLE] = this._resp_city_advMoveCastle;
            this.respMap[CITY_CONSTRUCT_CASTLE] = this._resp_city_constructCastle;
            this.respMap[CITY_GET_STORE_LIST] = this._resp_city_getStoreList;
            this.respMap[CITY_GIVEUP_CASTLE] = this._resp_city_giveupCastle;
            this.respMap[CITY_MODIFY_CASTLE_ICON] = this._resp_city_modifyCastleIcon;
            this.respMap[CITY_MODIFY_CASTLE_NAME] = this._resp_city_modifyCastleName;
            this.respMap[CITY_MODIFY_FLAG] = this._resp_city_modifyFlag;
            this.respMap[CITY_MODIFY_STORE_PERCENT] = this._resp_city_modifyStorePercent;
            this.respMap[CITY_MODIFY_USER_NAME] = this._resp_city_modifyUserName;
            this.respMap[CITY_MOVE_CASTLE] = this._resp_city_moveCastle;
            this.respMap[CITY_SET_STOP_WAR_STATE] = this._resp_city_setStopWarState;
            this.respMap[CITY_UNITE_ADV_MOVE_CASTLE] = this._resp_city_uniteAdvMoveCastle;
            this.respMap[CITY__WAR_MOVE_CASTLE] = this._resp_city_WarMoveCastle;
            this.respMap[COLONY_ABANDON_COLONY] = this._resp_colony_abandonColony;
            this.respMap[COLONY_GET_COLONIAL_ARMY_INFO] = this._resp_colony_getColonialArmyInfo;
            this.respMap[COLONY_GET_COLONIAL_CASTLES_INFO] = this._resp_colony_getColonialCastlesInfo;
            this.respMap[COLONY_GET_DEPLOY_TROOPS_INFO] = this._resp_colony_getDeployTroopsInfo;
            this.respMap[COLONY_GET_SUZERAIN_COLONIAL_CASTLES_INFO] = this._resp_colony_getSuzerainColonialCastlesInfo;
            this.respMap[COLONY_LEVY_ARMY] = this._resp_colony_levyArmy;
            this.respMap[COLONY_LEVY_FOOD] = this._resp_colony_levyFood;
            this.respMap[COLONY_LEVY_POPULATION] = this._resp_colony_levyPopulation;
            this.respMap[COLONY_LEVY_TAXES] = this._resp_colony_levyTaxes;
            this.respMap[COLONY_OVERVIEW_COLONIAL_CASTLE] = this._resp_colony_overviewColonialCastle;
            this.respMap[COLONY_REDUCE_ARMAMENTS] = this._resp_colony_reduceArmaments;
            this.respMap[COLONY_SET_DEPLOY_TROOPS] = this._resp_colony_setDeployTroops;
            this.respMap[COLONY_SOW_DISCORD] = this._resp_colony_sowDiscord;
            this.respMap[COLONY_SPEED_UP_ABANDON_COLONY] = this._resp_colony_speedUpAbandonColony;
            this.respMap[COLONY_UPRISE] = this._resp_colony_uprise;
            this.respMap[COMMISSION_ACCEPT_COMMISSION_QUEST] = this._resp_commission_acceptCommissionQuest;
            this.respMap[COMMISSION_ADD_COMMISSION_QUEST_ARMY] = this._resp_commission_addCommissionQuestArmy;
            this.respMap[COMMISSION_DECLINE_COMMISSION_QUEST] = this._resp_commission_declineCommissionQuest;
            this.respMap[COMMISSION_GET_ALL_COMMISSION_QUEST] = this._resp_commission_getAllCommissionQuest;
            this.respMap[COMMISSION_GET_COMMISSION_QUEST_ARMY_INFO] = this._resp_commission_getCommissionQuestArmyInfo;
            this.respMap[COMMISSION_GET_COMMISSION_QUEST_ARMY_RANKING] = this._resp_commission_getCommissionQuestArmyRanking;
            this.respMap[COMMISSION_GET_MY_ACCEPTED_COMMISSION_QUEST] = this._resp_commission_getMyAcceptedCommissionQuest;
            this.respMap[COMMISSION_GET_MY_COMMISSION_QUEST] = this._resp_commission_getMyCommissionQuest;
            this.respMap[COMMISSION_ISSUE_COMMISSION_QUEST] = this._resp_commission_issueCommissionQuest;
            this.respMap[COMMON_ADD_TO_FAVORITES] = this._resp_common_addToFavorites;
            this.respMap[COMMON_ALLIANCE_CHAT] = this._resp_common_allianceChat;
            this.respMap[COMMON_AUTH_SECURITY_CODE] = this._resp_common_authSecurityCode;
            this.respMap[COMMON_CANCEL_REMOVING_SECURITY_CODE_PROCESS] = this._resp_common_cancelRemovingSecurityCodeProcess;
            this.respMap[COMMON_CHANGE_HEADLINE] = this._resp_common_changeHeadline;
            this.respMap[COMMON_CHANGE_NAME] = this._resp_common_changeName;
            this.respMap[COMMON_CHANGE_SECURITY_CODE] = this._resp_common_changeSecurityCode;
            this.respMap[COMMON_CHANGE_USER_FACE] = this._resp_common_changeUserFace;
            this.respMap[COMMON_CHANNEL_CHAT] = this._resp_common_channelChat;
            this.respMap[COMMON_CREATE_NEW_PLAYER] = this._resp_common_createNewPlayer;
            this.respMap[COMMON_DECLARED_WAR_AGAINST_PLAYER] = this._resp_common_declaredWarAgainstPlayer;
            this.respMap[COMMON_DELETE_USER_AND_RESTART] = this._resp_common_deleteUserAndRestart;
            this.respMap[COMMON_DEL_UNITE_SERVER_PEACE_STATUS] = this._resp_common_delUniteServerPeaceStatus;
            this.respMap[COMMON_DENY_PLAYER_SPEAK] = this._resp_common_denyPlayerSpeak;
            this.respMap[COMMON_FACEBOOK_CONNECT] = this._resp_common_facebookConnect;
            this.respMap[COMMON_GET_CAN_DECLARED_WAR_AGAINST_PLAYER] = this._resp_common_getCanDeclaredWarAgainstPlayer;
            this.respMap[COMMON_GET_IS_SECURITY_CODE_SETTED] = this._resp_common_getIsSecurityCodeSetted;
            this.respMap[COMMON_GET_ITEM_DEF_XML] = this._resp_common_getItemDefXml;
            this.respMap[COMMON_GET_PACKAGE] = this._resp_common_getPackage;
            this.respMap[COMMON_GET_PACKAGE_LIST] = this._resp_common_getPackageList;
            this.respMap[COMMON_GET_PACKAGE_NUMBER] = this._resp_common_getPackageNumber;
            this.respMap[COMMON_GET_PLAYER_DECLARED_WAR_STATUS] = this._resp_common_getPlayerDeclaredWarStatus;
            this.respMap[COMMON_GET_PLAYER_INFO_BY_NAME] = this._resp_common_getPlayerInfoByName;
            this.respMap[COMMON_GET_PROTECT_OPTION] = this._resp_common_getProtectOption;
            this.respMap[COMMON_GET_RELATIONSHIP] = this._resp_common_getRelationship;
            this.respMap[COMMON_MAP_CASTLE] = this._resp_common_mapCastle;
            this.respMap[COMMON_MAP_INFO] = this._resp_common_mapInfo;
            this.respMap[COMMON_MAP_INFO_SIMPLE] = this._resp_common_mapInfoSimple;
            this.respMap[COMMON_PRIVATE_CHAT] = this._resp_common_privateChat;
            this.respMap[COMMON_REMOVE_SECURITY_CODE] = this._resp_common_removeSecurityCode;
            this.respMap[COMMON_SAVE_UNREGISTERED_PLAYER] = this._resp_common_saveUnregisteredPlayer;
            this.respMap[COMMON_SET_AUTO_HEAL] = this._resp_common_setAutoHeal;
            this.respMap[COMMON_SET_EOVNY_MEMBER] = this._resp_common_setEovnyMember;
            this.respMap[COMMON_SET_EVENT_DONE] = this._resp_common_setEventDone;
            this.respMap[COMMON_SET_EVONY_MEMBER_E_MAIL] = this._resp_common_setEvonyMemberEMail;
            this.respMap[COMMON_SET_PROTECT_OPTION] = this._resp_common_setProtectOption;
            this.respMap[COMMON_SET_RECEIVE_INCOMING_ATTACK] = this._resp_common_setReceiveIncomingAttack;
            this.respMap[COMMON_SET_RETURN_REPORT] = this._resp_common_setReturnReport;
            this.respMap[COMMON_SET_SECURITY_CODE] = this._resp_common_setSecurityCode;
            this.respMap[COMMON_SET_TROOP_CONFIG] = this._resp_common_setTroopConfig;
            this.respMap[COMMON_SET_UNLOCK_OPTION] = this._resp_common_setUnlockOption;
            this.respMap[COMMON_STEP] = this._resp_common_step;
            this.respMap[COMMON_WORLD_CHAT] = this._resp_common_worldChat;
            this.respMap[COMMON_ZONE_INFO] = this._resp_common_zoneInfo;
            this.respMap[EQUIPMENT__ENHANCED_BY_GEM_STONE] = this._resp_equipment_EnhancedByGemStone;
            this.respMap[EQUIPMENT__ENHANCED_STAR_BY_GEM_STONE] = this._resp_equipment_EnhancedStarByGemStone;
            this.respMap[EQUIPMENT__TAKE_OFF_ALL_EQUIPMENTTECH] = this._resp_equipment_TakeOffAllEquipmenttech;
            this.respMap[EQUIPMENT__TAKE_OFF_EQUIPMENTTECH] = this._resp_equipment_TakeOffEquipmenttech;
            this.respMap[EQUIPMENT__WEAR_ALL_EQUIPMENTTECH] = this._resp_equipment_WearAllEquipmenttech;
            this.respMap[EQUIPMENT__WEAR_EQUIPMENTTECH] = this._resp_equipment_WearEquipmenttech;
            this.respMap[EQUIPMENTTECH_CANCEL_RESEARCH] = this._resp_equipmenttech_cancelResearch;
            this.respMap[EQUIPMENTTECH_GET_COINS_NEED] = this._resp_equipmenttech_getCoinsNeed;
            this.respMap[EQUIPMENTTECH_GET_RESEARCH_LIST] = this._resp_equipmenttech_getResearchList;
            this.respMap[EQUIPMENTTECH_RESEARCH] = this._resp_equipmenttech_research;
            this.respMap[EQUIPMENTTECH_SPEED_UP_RESEARCH] = this._resp_equipmenttech_speedUpResearch;
            this.respMap[FIELD_GET_CASTLE_FIELD_INFO] = this._resp_field_getCastleFieldInfo;
            this.respMap[FIELD_GET_OTHER_FIELD_INFO] = this._resp_field_getOtherFieldInfo;
            this.respMap[FIELD_GIVE_UP_FIELD] = this._resp_field_giveUpField;
            this.respMap[FORTIFICATIONS_ACC_TROOP_PRODUCE] = this._resp_fortifications_accTroopProduce;
            this.respMap[FORTIFICATIONS_CANCEL_FORTIFICATION_PRODUCE] = this._resp_fortifications_cancelFortificationProduce;
            this.respMap[FORTIFICATIONS_DESTRUCT_WALL_PROTECT] = this._resp_fortifications_destructWallProtect;
            this.respMap[FORTIFICATIONS_GET_FORTIFICATIONS_PRODUCE_LIST] = this._resp_fortifications_getFortificationsProduceList;
            this.respMap[FORTIFICATIONS_GET_PRODUCE_QUEUE] = this._resp_fortifications_getProduceQueue;
            this.respMap[FORTIFICATIONS_PRODUCE_WALL_PROTECT] = this._resp_fortifications_produceWallProtect;
            this.respMap[FRIEND_ADD_BLOCK] = this._resp_friend_addBlock;
            this.respMap[FRIEND_ADD_FRIEND] = this._resp_friend_addFriend;
            this.respMap[FRIEND_DELETE_BLOCK] = this._resp_friend_deleteBlock;
            this.respMap[FRIEND_DELETE_FRIEND] = this._resp_friend_deleteFriend;
            this.respMap[FRIEND_IS_BLOCK_MAIL_PLAYER] = this._resp_friend_isBlockMailPlayer;
            this.respMap[FURLOUGH_CANCEL_FURLOUGHT] = this._resp_furlough_cancelFurlought;
            this.respMap[FURLOUGH_IS_FURLOUGHT] = this._resp_furlough_isFurlought;
            this.respMap[GAMBLINGRANKING_GET_GAMBLING_RANKING_REWARD] = this._resp_gamblingranking_getGamblingRankingReward;
            this.respMap[GAMBLINGRANKING_GET_GAMBLING_RANKING_TODAY] = this._resp_gamblingranking_getGamblingRankingToday;
            this.respMap[GAMBLINGRANKING_GET_GAMBLING_RANKING_YESTERDAY] = this._resp_gamblingranking_getGamblingRankingYesterday;
            this.respMap[GAMEMASTER_ADD_BUILDING] = this._resp_gamemaster_addBuilding;
            this.respMap[GAMEMASTER_ADD_HERO] = this._resp_gamemaster_addHero;
            this.respMap[GAMEMASTER_ADD_ITEMS] = this._resp_gamemaster_addItems;
            this.respMap[GAMEMASTER_REMOVE_BUILDING] = this._resp_gamemaster_removeBuilding;
            this.respMap[GAMEMASTER_REMOVE_HERO] = this._resp_gamemaster_removeHero;
            this.respMap[GAMEMASTER_REMOVE_ITEM] = this._resp_gamemaster_removeItem;
            this.respMap[GAMEMASTER_SET_RESOURCES] = this._resp_gamemaster_setResources;
            this.respMap[GAMEMASTER_SET_TECHNOLOGY] = this._resp_gamemaster_setTechnology;
            this.respMap[HERO_ADD_POINT] = this._resp_hero_addPoint;
            this.respMap[HERO_ADD_POINT2] = this._resp_hero_addPoint2;
            this.respMap[HERO_AWARD_GOLD] = this._resp_hero_awardGold;
            this.respMap[HERO_CALL_BACK_HERO] = this._resp_hero_callBackHero;
            this.respMap[HERO_CHANGE_NAME] = this._resp_hero_changeName;
            this.respMap[HERO_DISCHARGE_CHIEF] = this._resp_hero_dischargeChief;
            this.respMap[HERO_FIRE_HERO] = this._resp_hero_fireHero;
            this.respMap[HERO__GEN_SAVE_RANDOM_HERO] = this._resp_hero_GenSaveRandomHero;
            this.respMap[HERO__GET_DISAPPEAR_HEROS] = this._resp_hero_GetDisappearHeros;
            this.respMap[HERO_GET_FLEE_HERO_LIST] = this._resp_hero_getFleeHeroList;
            this.respMap[HERO_GET_HEROS_LIST_FROM_TAVERN] = this._resp_hero_getHerosListFromTavern;
            this.respMap[HERO__GET_RANDOM_HERO] = this._resp_hero_GetRandomHero;
            this.respMap[HERO_HIRE_FACEBOOK_FRIEND_HERO] = this._resp_hero_hireFacebookFriendHero;
            this.respMap[HERO_HIRE_HERO] = this._resp_hero_hireHero;
            this.respMap[HERO_LEVEL_UP] = this._resp_hero_levelUp;
            this.respMap[HERO_PROMOTE_TO_CHIEF] = this._resp_hero_promoteToChief;
            this.respMap[HERO__RECOVER_DISAPPEAR_HERO] = this._resp_hero_RecoverDisappearHero;
            this.respMap[HERO_RECRUIT_FLEE_HERO] = this._resp_hero_recruitFleeHero;
            this.respMap[HERO_REFRESH_HEROS_LIST_FROM_TAVERN] = this._resp_hero_refreshHerosListFromTavern;
            this.respMap[HERO_RELEASE_HERO] = this._resp_hero_releaseHero;
            this.respMap[HERO_RESET_POINT] = this._resp_hero_resetPoint;
            this.respMap[HERO__RET_SET_HERO_ATTRI] = this._resp_hero_RetSetHeroAttri;
            this.respMap[HERO_SET_HERO_FACEBOOK_ID] = this._resp_hero_setHeroFacebookId;
            this.respMap[HERO__SET_SHOW_HERO_ID] = this._resp_hero_SetShowHeroId;
            this.respMap[HERO__SHOW_PLAYER_HEROS_BY_USER_NAME] = this._resp_hero_ShowPlayerHerosByUserName;
            this.respMap[HERO_TRY_GET_SEIZED_HERO] = this._resp_hero_tryGetSeizedHero;
            this.respMap[HERO_USE_ITEM] = this._resp_hero_useItem;
            this.respMap[INTERIOR_GET_RESOURCE_PRODUCE_DATA] = this._resp_interior_getResourceProduceData;
            this.respMap[INTERIOR_MODIFY_COMMENCE_RATE] = this._resp_interior_modifyCommenceRate;
            this.respMap[INTERIOR_MODIFY_TAX_RATE] = this._resp_interior_modifyTaxRate;
            this.respMap[INTERIOR_PACIFY_PEOPLE] = this._resp_interior_pacifyPeople;
            this.respMap[INTERIOR_TAXATION] = this._resp_interior_taxation;
            this.respMap[MAIL_DELETE_MAIL] = this._resp_mail_deleteMail;
            this.respMap[MAIL_GET_ALL_T_V_MSG] = this._resp_mail_getAllTVMsg;
            this.respMap[MAIL_READ_MAIL] = this._resp_mail_readMail;
            this.respMap[MAIL_READ_OVER_MAIL_LIST] = this._resp_mail_readOverMailList;
            this.respMap[MAIL_RECEIVE_MAIL_LIST] = this._resp_mail_receiveMailList;
            this.respMap[MAIL_REPORT_BUG] = this._resp_mail_reportBug;
            this.respMap[MAIL_REPORT_PLAYER] = this._resp_mail_reportPlayer;
            this.respMap[MAIL_SEND_MAIL] = this._resp_mail_sendMail;
            this.respMap[NPCHERO_GET_NPC_HERO_INFRO_BY_I_D] = this._resp_npchero_getNpcHeroInfroByID;
            this.respMap[NPCHERO_GET_NPC_HEROS_LIST] = this._resp_npchero_getNpcHerosList;
            this.respMap[NPCHERO_GET_NPC_HEROS_LIST_BY_FILTER] = this._resp_npchero_getNpcHerosListByFilter;
            this.respMap[NPCHERO_GET_NPC_HEROS_LIST_BY_MONEY] = this._resp_npchero_getNpcHerosListByMoney;
            this.respMap[QUEST_ABANDON] = this._resp_quest_abandon;
            this.respMap[QUEST_ACCEPT] = this._resp_quest_accept;
            this.respMap[QUEST_AWARD] = this._resp_quest_award;
            this.respMap[QUEST_AWARD_PACKET] = this._resp_quest_awardPacket;
            this.respMap[QUEST_DONATE] = this._resp_quest_donate;
            this.respMap[QUEST_GET_AWARD_ITEMS] = this._resp_quest_getAwardItems;
            this.respMap[QUEST_GET_EFFORT_LIST] = this._resp_quest_getEffortList;
            this.respMap[QUEST_GET_EFFORT_LIST_BY_TARGE_TYPEID] = this._resp_quest_getEffortListByTargeTypeid;
            this.respMap[QUEST_GET_QUEST_LIST] = this._resp_quest_getQuestList;
            this.respMap[QUEST_GET_QUEST_TYPE] = this._resp_quest_getQuestType;
            this.respMap[RANK_GET_ALLIANCE_RANK] = this._resp_rank_getAllianceRank;
            this.respMap[RANK_GET_CASTLE_RANK] = this._resp_rank_getCastleRank;
            this.respMap[RANK_GET_HERO_RANK] = this._resp_rank_getHeroRank;
            this.respMap[RANK_GET_PLAYER_RANK] = this._resp_rank_getPlayerRank;
            this.respMap[RANK_GET_TOP_VOTES_PLAYER] = this._resp_rank_getTopVotesPlayer;
            this.respMap[RANK_GET_VOTE_RANK] = this._resp_rank_getVoteRank;
            this.respMap[REPORT_DELETE_ALL_REPORTS] = this._resp_report_deleteAllReports;
            this.respMap[REPORT_DELETE_REPORT] = this._resp_report_deleteReport;
            this.respMap[REPORT_MARK_AS_READ] = this._resp_report_markAsRead;
            this.respMap[REPORT_READ_OVER_REPORT] = this._resp_report_readOverReport;
            this.respMap[REPORT_RECEIVE_REPORT_LIST] = this._resp_report_receiveReportList;
            this.respMap[REPORT_SHARE_REPORT] = this._resp_report_shareReport;
            this.respMap[SERVER_ACADEMY_RESEARCH_UPDATE] = this._resp_AcademyResearchUpdate;
            this.respMap[SERVER_ALLIANCE_CHAT_MSG] = this._resp_AllianceChatMsg;
            this.respMap[SERVER_BUILD_COMPLATE] = this._resp_BuildComplate;
            this.respMap[SERVER_BUILDING_QUEUE_UPDATE] = this._resp_BuildingQueueUpdate;
            this.respMap[SERVER_CASTLE_BUFF_UPDATE] = this._resp_CastleBuffUpdate;
            this.respMap[SERVER_CASTLE_FIELD_UPDATE] = this._resp_CastleFieldUpdate;
            this.respMap[SERVER_CASTLE_UPDATE] = this._resp_CastleUpdate;
            this.respMap[SERVER_CB_UPDATE] = this._resp_CbUpdate;
            this.respMap[SERVER_CELEB_RANK_COMPLETE_TIP_RESPONSE] = this._resp_CelebRankCompleteTipResponse;
            this.respMap[SERVER_CHANGE_NAME] = this._resp_ChangeName;
            this.respMap[SERVER_CHANNEL_CHAT_MSG] = this._resp_ChannelChatMsg;
            this.respMap[SERVER_COLONY_UPDATE] = this._resp_ColonyUpdate;
            this.respMap[SERVER_CONNECTION_LOST] = this._resp_ConnectionLost;
            this.respMap[SERVER_DECLARED_WAR_STATUS_CHANGE] = this._resp_DeclaredWarStatusChange;
            this.respMap[SERVER_DECLARED_WAR_UPDATE] = this._resp_DeclaredWarUpdate;
            this.respMap[SERVER_ENEMY_ARMYS_UPDATE] = this._resp_EnemyArmysUpdate;
            this.respMap[SERVER_EQUIPMENT_RESEARCH_COMPLETE_UPDATE] = this._resp_EquipmentResearchCompleteUpdate;
            this.respMap[SERVER_FLEE_TROOP_UPDATE] = this._resp_FleeTroopUpdate;
            this.respMap[SERVER_FORTIFICATIONS_UPDATE] = this._resp_FortificationsUpdate;
            this.respMap[SERVER_FRIEND_ARMYS_UPDATE] = this._resp_FriendArmysUpdate;
            this.respMap[SERVER_GET_PLAYER_VOTE_INFRO] = this._resp_GetPlayerVoteInfro;
            this.respMap[SERVER_GET_TOP_VOTES_PLAYER] = this._resp_GetTopVotesPlayer;
            this.respMap[SERVER_HERO_UPDATE] = this._resp_HeroUpdate;
            this.respMap[SERVER_INJURED_TROOP_UPDATE] = this._resp_InjuredTroopUpdate;
            this.respMap[SERVER_ITEM_BUFF] = this._resp_ItemBuff;
            this.respMap[SERVER_ITEM_UPDATE] = this._resp_ItemUpdate;
            this.respMap[SERVER_KICKED_OUT] = this._resp_KickedOut;
            this.respMap[SERVER_LOGIN_RESPONSE] = this._resp_LoginResponse;
            this.respMap[SERVER_MERCENARY_UPDATE] = this._resp_MercenaryUpdate;
            this.respMap[SERVER_NEW_FINISHED_QUEST] = this._resp_NewFinishedQuest;
            this.respMap[SERVER_NEW_MAIL] = this._resp_NewMail;
            this.respMap[SERVER_NEW_REPORT] = this._resp_NewReport;
            this.respMap[SERVER_PACKAGE_LIST] = this._resp_PackageList;
            this.respMap[SERVER_PLAYER_BUFF_UPDATE] = this._resp_PlayerBuffUpdate;
            this.respMap[SERVER_PLAYER_INFO_UPDATE] = this._resp_PlayerInfoUpdate;
            this.respMap[SERVER_PRIVATE_CHAT_MESSAGE] = this._resp_PrivateChatMessage;
            this.respMap[SERVER_QUEST_COMPLETE_TIP_RESPONSE] = this._resp_QuestCompleteTipResponse;
            this.respMap[SERVER_QUEST_FINISHED] = this._resp_QuestFinished;
            this.respMap[SERVER_REGISTER_RESPONSE] = this._resp_RegisterResponse;
            this.respMap[SERVER_RESEARCH_COMPLETE_UPDATE] = this._resp_ResearchCompleteUpdate;
            this.respMap[SERVER_RESOURCE_UPDATE] = this._resp_ResourceUpdate;
            this.respMap[SERVER_SECURITY_CODE_REMOVED_EVENT] = this._resp_SecurityCodeRemovedEvent;
            this.respMap[SERVER_SELF_ARMYS_UPDATE] = this._resp_SelfArmysUpdate;
            this.respMap[SERVER_STRATEGY_BUFF] = this._resp_StrategyBuff;
            this.respMap[SERVER_SYSTEM_INFO_MSG] = this._resp_SystemInfoMsg;
            this.respMap[SERVER_TRADES_UPDATE] = this._resp_TradesUpdate;
            this.respMap[SERVER_TRANSING_TRADE_UPDATE] = this._resp_TransingTradeUpdate;
            this.respMap[SERVER_TROOP_UPDATE] = this._resp_TroopUpdate;
            this.respMap[SERVER_UNREGISTERED_CREATE_PLAYER_RESPONSE] = this._resp_UnregisteredCreatePlayerResponse;
            this.respMap[SERVER_VISITOR_HELP_EVENT] = this._resp_VisitorHelpEvent;
            this.respMap[SERVER_WORLD_CHAT_MSG] = this._resp_WorldChatMsg;
            this.respMap[SHOP_BUY] = this._resp_shop_buy;
            this.respMap[SHOP_BUY_RESOURCE] = this._resp_shop_buyResource;
            this.respMap[SHOP__GEM__SMELTING] = this._resp_shop_Gem_Smelting;
            this.respMap[SHOP_GET_BUY_RESOURCE_INFO] = this._resp_shop_getBuyResourceInfo;
            this.respMap[SHOP_USE_ANGEL_ITEM] = this._resp_shop_useAngelItem;
            this.respMap[SHOP_USE_CASTLE_GOODS] = this._resp_shop_useCastleGoods;
            this.respMap[SHOP_USE_DEVIL_ITEM] = this._resp_shop_useDevilItem;
            this.respMap[SHOP_USE_GOODS] = this._resp_shop_useGoods;
            this.respMap[SHOP_USE_TRICK_ITEM] = this._resp_shop_useTrickItem;
            this.respMap[STRATAGEM_USE_STRATAGEM] = this._resp_stratagem_useStratagem;
            this.respMap[TECH_CANCEL_RESEARCH] = this._resp_tech_cancelResearch;
            this.respMap[TECH_GET_COINS_NEED] = this._resp_tech_getCoinsNeed;
            this.respMap[TECH_GET_RESEARCH_LIST] = this._resp_tech_getResearchList;
            this.respMap[TECH_RESEARCH] = this._resp_tech_research;
            this.respMap[TECH_SPEED_UP_RESEARCH] = this._resp_tech_speedUpResearch;
            this.respMap[TRADE_CANCEL_TRADE] = this._resp_trade_cancelTrade;
            this.respMap[TRADE_GET_MY_TRADE_LIST] = this._resp_trade_getMyTradeList;
            this.respMap[TRADE_GET_TRANSING_TRADE_LIST] = this._resp_trade_getTransingTradeList;
            this.respMap[TRADE_NEW_TRADE] = this._resp_trade_newTrade;
            this.respMap[TRADE_SEARCH_TRADES] = this._resp_trade_searchTrades;
            this.respMap[TRADE_SPEED_UP_TRANS] = this._resp_trade_speedUpTrans;
            this.respMap[TROOP_ACC_TROOP_PRODUCE] = this._resp_troop_accTroopProduce;
            this.respMap[TROOP_CANCEL_TROOP_PRODUCE] = this._resp_troop_cancelTroopProduce;
            this.respMap[TROOP_CHECK_IDLE_BARRACK] = this._resp_troop_checkIdleBarrack;
            this.respMap[TROOP_DISBAND_TROOP] = this._resp_troop_disbandTroop;
            this.respMap[TROOP_GET_PRODUCE_QUEUE] = this._resp_troop_getProduceQueue;
            this.respMap[TROOP_GET_TROOP_PRODUCE_LIST] = this._resp_troop_getTroopProduceList;
            this.respMap[TROOP_PRODUCE_TROOP] = this._resp_troop_produceTroop;
            this.respMap[TRUCE_CANCEL_DREAM_TRUCE] = this._resp_truce_cancelDreamTruce;
            this.respMap[TRUCE_CHANGE_DREAM_TRUCE_TIME] = this._resp_truce_changeDreamTruceTime;
            this.respMap[TRUCE_SET_DREAM_TRUCE] = this._resp_truce_setDreamTruce;
            this.respMap[VISIT_DELETE_COMMENT] = this._resp_visit_deleteComment;
            this.respMap[VISIT_GET_ALL_VISITOR_COMMENTS] = this._resp_visit_getAllVisitorComments;
            this.respMap[VISIT_GET_HELPED_PLAYERS] = this._resp_visit_getHelpedPlayers;
            this.respMap[VISIT_GET_VISITOR_COMMENTS] = this._resp_visit_getVisitorComments;
            this.respMap[VISIT_HELP_INCREASE_PRODUCTION] = this._resp_visit_helpIncreaseProduction;
            this.respMap[VISIT_MARK_COMMENT_AS_READ] = this._resp_visit_markCommentAsRead;
            this.respMap[VISIT_VISITOR_COMMENT] = this._resp_visit_visitorComment;
            this.respMap[VOTE_VOTE_TO_PLAYER_BY_ID] = this._resp_vote_voteToPlayerById;
            this.respMap[VOTE_VOTE_TO_PLAYER_BY_NAME] = this._resp_vote_voteToPlayerByName;
        }

        public static function getInstance():ResponseDispatcher
        {
            return (instance);
        }


        private function _resp_army_cureInjuredTroop(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(ARMY_CURE_INJURED_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._cureInjuredTroop_callback != null)
            {
                this.actionFactory.getArmyCommands()._cureInjuredTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._cureInjuredTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_getProduceQueue(_arg_1:Object):void
        {
            var _local_2:ProduceQueueResponse = new ProduceQueueResponse(TROOP_GET_PRODUCE_QUEUE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTroopCommands()._getProduceQueue_callback != null)
            {
                this.actionFactory.getTroopCommands()._getProduceQueue_callback.apply(this, [_local_2]);
                this.actionFactory.getTroopCommands()._getProduceQueue_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ChangeName(_arg_1:Object):void
        {
            var _local_2:ChangeName = new ChangeName(SERVER_CHANGE_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onChangeName != null)
            {
                this.onChangeName.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_getPlayerDeclaredWarStatus(_arg_1:Object):void
        {
            var _local_2:GetDeclaredWarResponse = new GetDeclaredWarResponse(COMMON_GET_PLAYER_DECLARED_WAR_STATUS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getPlayerDeclaredWarStatus_callback != null)
            {
                this.actionFactory.getCommonCommands()._getPlayerDeclaredWarStatus_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getPlayerDeclaredWarStatus_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_addToFavorites(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COMMON_ADD_TO_FAVORITES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._addToFavorites_callback != null)
            {
                this.actionFactory.getCommonCommands()._addToFavorites_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._addToFavorites_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ColonyUpdate(_arg_1:Object):void
        {
            var _local_2:ColonyUpdate = new ColonyUpdate(SERVER_COLONY_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onColonyUpdate != null)
            {
                this.onColonyUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_shop_useAngelItem(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(SHOP_USE_ANGEL_ITEM, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._useAngelItem_callback != null)
            {
                this.actionFactory.getShopCommands()._useAngelItem_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._useAngelItem_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_StrategyBuff(_arg_1:Object):void
        {
            var _local_2:StrategyBuff = new StrategyBuff(SERVER_STRATEGY_BUFF, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onStrategyBuff != null)
            {
                this.onStrategyBuff.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_colony_sowDiscord(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COLONY_SOW_DISCORD, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._sowDiscord_callback != null)
            {
                this.actionFactory.getColonyCommands()._sowDiscord_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._sowDiscord_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_hireHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_HIRE_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._hireHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._hireHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._hireHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceMembers(_arg_1:Object):void
        {
            var _local_2:AllianceMembersResponse = new AllianceMembersResponse(ALLIANCE_GET_ALLIANCE_MEMBERS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceCommands()._getAllianceMembers_callback != null)
            {
                this.actionFactory.getAllianceCommands()._getAllianceMembers_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceCommands()._getAllianceMembers_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ResourceUpdate(_arg_1:Object):void
        {
            var _local_2:ResourceUpdate = new ResourceUpdate(SERVER_RESOURCE_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onResourceUpdate != null)
            {
                this.onResourceUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_alliance_getAllianceFriendshipList(_arg_1:Object):void
        {
            var _local_2:AllianceFriendshipResponse = new AllianceFriendshipResponse(ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_addPoint2(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_ADD_POINT2, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._addPoint2_callback != null)
            {
                this.actionFactory.getHeroCommand()._addPoint2_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._addPoint2_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getFleeTroop(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(ARMY_GET_FLEE_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._getFleeTroop_callback != null)
            {
                this.actionFactory.getArmyCommands()._getFleeTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._getFleeTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_changeName(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_CHANGE_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._changeName_callback != null)
            {
                this.actionFactory.getHeroCommand()._changeName_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._changeName_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_cancelFortificationProduce(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(FORTIFICATIONS_CANCEL_FORTIFICATION_PRODUCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback != null)
            {
                this.actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback.apply(this, [_local_2]);
                this.actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_channelChat(_arg_1:Object):void
        {
            var _local_2:ChatResponse = new ChatResponse(COMMON_CHANNEL_CHAT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._channelChat_callback != null)
            {
                this.actionFactory.getCommonCommands()._channelChat_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._channelChat_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_report_readOverReport(_arg_1:Object):void
        {
            var _local_2:ReportResponse = new ReportResponse(REPORT_READ_OVER_REPORT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getReportCommands()._readOverReport_callback != null)
            {
                this.actionFactory.getReportCommands()._readOverReport_callback.apply(this, [_local_2]);
                this.actionFactory.getReportCommands()._readOverReport_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_furlough_isFurlought(_arg_1:Object):void
        {
            var _local_2:FurloughResponse = new FurloughResponse(FURLOUGH_IS_FURLOUGHT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFurloughCommands()._isFurlought_callback != null)
            {
                this.actionFactory.getFurloughCommands()._isFurlought_callback.apply(this, [_local_2]);
                this.actionFactory.getFurloughCommands()._isFurlought_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ChannelChatMsg(_arg_1:Object):void
        {
            var _local_2:ChannelChatMsg = new ChannelChatMsg(SERVER_CHANNEL_CHAT_MSG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onChannelChatMsg != null)
            {
                this.onChannelChatMsg.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_army_recruitFleeTroop(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(ARMY_RECRUIT_FLEE_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._recruitFleeTroop_callback != null)
            {
                this.actionFactory.getArmyCommands()._recruitFleeTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._recruitFleeTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_speedUpAbandonColony(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COLONY_SPEED_UP_ABANDON_COLONY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._speedUpAbandonColony_callback != null)
            {
                this.actionFactory.getColonyCommands()._speedUpAbandonColony_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._speedUpAbandonColony_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPlayerInfoByName(_arg_1:Object):void
        {
            var _local_2:PlayerInfoResponse = new PlayerInfoResponse(COMMON_GET_PLAYER_INFO_BY_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getPlayerInfoByName_callback != null)
            {
                this.actionFactory.getCommonCommands()._getPlayerInfoByName_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getPlayerInfoByName_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyArmy(_arg_1:Object):void
        {
            var _local_2:CapitalCommandResponse = new CapitalCommandResponse(CAPITAL_LEVY_ARMY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCapitalCommands()._levyArmy_callback != null)
            {
                this.actionFactory.getCapitalCommands()._levyArmy_callback.apply(this, [_local_2]);
                this.actionFactory.getCapitalCommands()._levyArmy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_giveupCastle(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CITY_GIVEUP_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._giveupCastle_callback != null)
            {
                this.actionFactory.getCityCommands()._giveupCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._giveupCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_taxation(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(INTERIOR_TAXATION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getInteriorCommands()._taxation_callback != null)
            {
                this.actionFactory.getInteriorCommands()._taxation_callback.apply(this, [_local_2]);
                this.actionFactory.getInteriorCommands()._taxation_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_InjuredTroopUpdate(_arg_1:Object):void
        {
            var _local_2:InjuredTroopUpdate = new InjuredTroopUpdate(SERVER_INJURED_TROOP_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onInjuredTroopUpdate != null)
            {
                this.onInjuredTroopUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_equipmenttech_cancelResearch(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(EQUIPMENTTECH_CANCEL_RESEARCH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmenttechCommands()._cancelResearch_callback != null)
            {
                this.actionFactory.getEquipmenttechCommands()._cancelResearch_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmenttechCommands()._cancelResearch_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_newArmy(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(ARMY_NEW_ARMY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._newArmy_callback != null)
            {
                this.actionFactory.getArmyCommands()._newArmy_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._newArmy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_ShowPlayerHerosByUserName(_arg_1:Object):void
        {
            var _local_2:HeroListResponse = new HeroListResponse(HERO__SHOW_PLAYER_HEROS_BY_USER_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._ShowPlayerHerosByUserName_callback != null)
            {
                this.actionFactory.getHeroCommand()._ShowPlayerHerosByUserName_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._ShowPlayerHerosByUserName_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_EnhancedStarByGemStone(_arg_1:Object):void
        {
            var _local_2:GemstoneRespone = new GemstoneRespone(EQUIPMENT__ENHANCED_STAR_BY_GEM_STONE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmentCommands()._EnhancedStarByGemStone_callback != null)
            {
                this.actionFactory.getEquipmentCommands()._EnhancedStarByGemStone_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmentCommands()._EnhancedStarByGemStone_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_speedUpResearch(_arg_1:Object):void
        {
            var _local_2:ResearchResponse = new ResearchResponse(EQUIPMENTTECH_SPEED_UP_RESEARCH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmenttechCommands()._speedUpResearch_callback != null)
            {
                this.actionFactory.getEquipmenttechCommands()._speedUpResearch_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmenttechCommands()._speedUpResearch_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_report_deleteReport(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(REPORT_DELETE_REPORT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getReportCommands()._deleteReport_callback != null)
            {
                this.actionFactory.getReportCommands()._deleteReport_callback.apply(this, [_local_2]);
                this.actionFactory.getReportCommands()._deleteReport_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_SelfArmysUpdate(_arg_1:Object):void
        {
            var _local_2:SelfArmysUpdate = new SelfArmysUpdate(SERVER_SELF_ARMYS_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onSelfArmysUpdate != null)
            {
                this.onSelfArmysUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_vote_voteToPlayerById(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(VOTE_VOTE_TO_PLAYER_BY_ID, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVoteToPlayerCommands()._voteToPlayerById_callback != null)
            {
                this.actionFactory.getVoteToPlayerCommands()._voteToPlayerById_callback.apply(this, [_local_2]);
                this.actionFactory.getVoteToPlayerCommands()._voteToPlayerById_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeSecurityCode(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_CHANGE_SECURITY_CODE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._changeSecurityCode_callback != null)
            {
                this.actionFactory.getSecurityCommands()._changeSecurityCode_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._changeSecurityCode_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_getHelpedPlayers(_arg_1:Object):void
        {
            var _local_2:GetHelpedPlayersResponse = new GetHelpedPlayersResponse(VISIT_GET_HELPED_PLAYERS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVisitCommands()._getHelpedPlayers_callback != null)
            {
                this.actionFactory.getVisitCommands()._getHelpedPlayers_callback.apply(this, [_local_2]);
                this.actionFactory.getVisitCommands()._getHelpedPlayers_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_getResourceProduceData(_arg_1:Object):void
        {
            var _local_2:ResourceProduceDataResponse = new ResourceProduceDataResponse(INTERIOR_GET_RESOURCE_PRODUCE_DATA, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getInteriorCommands()._getResourceProduceData_callback != null)
            {
                this.actionFactory.getInteriorCommands()._getResourceProduceData_callback.apply(this, [_local_2]);
                this.actionFactory.getInteriorCommands()._getResourceProduceData_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_addUsertoAlliance(_arg_1:Object):void
        {
            var _local_2:AllianceManagementResponse = new AllianceManagementResponse(ALLIANCE_ADD_USERTO_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_furlough_cancelFurlought(_arg_1:Object):void
        {
            var _local_2:FurloughResponse = new FurloughResponse(FURLOUGH_CANCEL_FURLOUGHT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFurloughCommands()._cancelFurlought_callback != null)
            {
                this.actionFactory.getFurloughCommands()._cancelFurlought_callback.apply(this, [_local_2]);
                this.actionFactory.getFurloughCommands()._cancelFurlought_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHerosListByMoney(_arg_1:Object):void
        {
            var _local_2:NpcHeroListResponse = new NpcHeroListResponse(NPCHERO_GET_NPC_HEROS_LIST_BY_MONEY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getNpcHeroCommand()._getNpcHerosListByMoney_callback != null)
            {
                this.actionFactory.getNpcHeroCommand()._getNpcHerosListByMoney_callback.apply(this, [_local_2]);
                this.actionFactory.getNpcHeroCommand()._getNpcHerosListByMoney_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_getMyTradeList(_arg_1:Object):void
        {
            var _local_2:TradeListResponse = new TradeListResponse(TRADE_GET_MY_TRADE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTradeCommands()._getMyTradeList_callback != null)
            {
                this.actionFactory.getTradeCommands()._getMyTradeList_callback.apply(this, [_local_2]);
                this.actionFactory.getTradeCommands()._getMyTradeList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_cancelTroopProduce(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TROOP_CANCEL_TROOP_PRODUCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTroopCommands()._cancelTroopProduce_callback != null)
            {
                this.actionFactory.getTroopCommands()._cancelTroopProduce_callback.apply(this, [_local_2]);
                this.actionFactory.getTroopCommands()._cancelTroopProduce_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_QuestCompleteTipResponse(_arg_1:Object):void
        {
            var _local_2:QuestCompleteTipResponse = new QuestCompleteTipResponse(SERVER_QUEST_COMPLETE_TIP_RESPONSE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onQuestCompleteTipResponse != null)
            {
                this.onQuestCompleteTipResponse.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        public function dispatch(_arg_1:String, _arg_2:Object):void
        {
            var _local_3:Function = (this.respMap[_arg_1] as Function);
            if (_local_3 != null)
            {
                _local_3.apply(this, [_arg_2]);
            }
            else
            {
                if (istrace)
                {
                    trace((("ResponseDispatcher.dispatch: [" + _arg_1) + "] not found!"));
                };
            };
        }

        private function _resp_tech_getCoinsNeed(_arg_1:Object):void
        {
            var _local_2:CoinsNeedResponse = new CoinsNeedResponse(TECH_GET_COINS_NEED, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTechCommand()._getCoinsNeed_callback != null)
            {
                this.actionFactory.getTechCommand()._getCoinsNeed_callback.apply(this, [_local_2]);
                this.actionFactory.getTechCommand()._getCoinsNeed_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useDevilItem(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(SHOP_USE_DEVIL_ITEM, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._useDevilItem_callback != null)
            {
                this.actionFactory.getShopCommands()._useDevilItem_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._useDevilItem_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_accTroopProduce(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(FORTIFICATIONS_ACC_TROOP_PRODUCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFortificationsCommands()._accTroopProduce_callback != null)
            {
                this.actionFactory.getFortificationsCommands()._accTroopProduce_callback.apply(this, [_local_2]);
                this.actionFactory.getFortificationsCommands()._accTroopProduce_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_setTechnology(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(GAMEMASTER_SET_TECHNOLOGY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._setTechnology_callback != null)
            {
                this.actionFactory.getModifyCommands()._setTechnology_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._setTechnology_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_addPoint(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_ADD_POINT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._addPoint_callback != null)
            {
                this.actionFactory.getHeroCommand()._addPoint_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._addPoint_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamblingranking_getGamblingRankingToday(_arg_1:Object):void
        {
            var _local_2:GamblingRankingRespone = new GamblingRankingRespone(GAMBLINGRANKING_GET_GAMBLING_RANKING_TODAY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getGamblingRankingCommands()._getGamblingRankingToday_callback != null)
            {
                this.actionFactory.getGamblingRankingCommands()._getGamblingRankingToday_callback.apply(this, [_local_2]);
                this.actionFactory.getGamblingRankingCommands()._getGamblingRankingToday_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_abandon(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(QUEST_ABANDON, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._abandon_callback != null)
            {
                this.actionFactory.getQuestCommands()._abandon_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._abandon_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_agreeComeinAllianceList(_arg_1:Object):void
        {
            var _local_2:AllianceUserAddResponse = new AllianceUserAddResponse(ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_GenSaveRandomHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO__GEN_SAVE_RANDOM_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._GenSaveRandomHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._GenSaveRandomHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._GenSaveRandomHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_deleteFriend(_arg_1:Object):void
        {
            var _local_2:FriendResponse = new FriendResponse(FRIEND_DELETE_FRIEND, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFriendCommands()._deleteFriend_callback != null)
            {
                this.actionFactory.getFriendCommands()._deleteFriend_callback.apply(this, [_local_2]);
                this.actionFactory.getFriendCommands()._deleteFriend_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_accept(_arg_1:Object):void
        {
            var _local_2:QuestListResponse = new QuestListResponse(QUEST_ACCEPT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._accept_callback != null)
            {
                this.actionFactory.getQuestCommands()._accept_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._accept_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_AcademyResearchUpdate(_arg_1:Object):void
        {
            var _local_2:AcademyResearchUpdate = new AcademyResearchUpdate(SERVER_ACADEMY_RESEARCH_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onAcademyResearchUpdate != null)
            {
                this.onAcademyResearchUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_getProtectOption(_arg_1:Object):void
        {
            var _local_2:GetProtectOptionResponse = new GetProtectOptionResponse(COMMON_GET_PROTECT_OPTION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._getProtectOption_callback != null)
            {
                this.actionFactory.getSecurityCommands()._getProtectOption_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._getProtectOption_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setTroopConfig(_arg_1:Object):void
        {
            var _local_2:TroopConfigResponse = new TroopConfigResponse(COMMON_SET_TROOP_CONFIG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._setTroopConfig_callback != null)
            {
                this.actionFactory.getCommonCommands()._setTroopConfig_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._setTroopConfig_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_mapInfoSimple(_arg_1:Object):void
        {
            var _local_2:MapInfoSimpleResponse = new MapInfoSimpleResponse(COMMON_MAP_INFO_SIMPLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._mapInfoSimple_callback != null)
            {
                this.actionFactory.getCommonCommands()._mapInfoSimple_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._mapInfoSimple_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_VisitorHelpEvent(_arg_1:Object):void
        {
            var _local_2:VisitorHelpEvent = new VisitorHelpEvent(SERVER_VISITOR_HELP_EVENT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onVisitorHelpEvent != null)
            {
                this.onVisitorHelpEvent.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_colony_levyPopulation(_arg_1:Object):void
        {
            var _local_2:ColonyLevyeRespone = new ColonyLevyeRespone(COLONY_LEVY_POPULATION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._levyPopulation_callback != null)
            {
                this.actionFactory.getColonyCommands()._levyPopulation_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._levyPopulation_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_helpIncreaseProduction(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(VISIT_HELP_INCREASE_PRODUCTION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVisitCommands()._helpIncreaseProduction_callback != null)
            {
                this.actionFactory.getVisitCommands()._helpIncreaseProduction_callback.apply(this, [_local_2]);
                this.actionFactory.getVisitCommands()._helpIncreaseProduction_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_modifyCastleName(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CITY_MODIFY_CASTLE_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._modifyCastleName_callback != null)
            {
                this.actionFactory.getCityCommands()._modifyCastleName_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._modifyCastleName_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_privateChat(_arg_1:Object):void
        {
            var _local_2:ChatResponse = new ChatResponse(COMMON_PRIVATE_CHAT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._privateChat_callback != null)
            {
                this.actionFactory.getCommonCommands()._privateChat_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._privateChat_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_userWantInAlliance(_arg_1:Object):void
        {
            var _local_2:AllianceManagementResponse = new AllianceManagementResponse(ALLIANCE_USER_WANT_IN_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ConnectionLost(_arg_1:Object):void
        {
            var _local_2:ConnectionLost = new ConnectionLost(SERVER_CONNECTION_LOST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onConnectionLost != null)
            {
                this.onConnectionLost.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_setEovnyMember(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_SET_EOVNY_MEMBER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._setEovnyMember_callback != null)
            {
                this.actionFactory.getCommonCommands()._setEovnyMember_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._setEovnyMember_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_markCommentAsRead(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(VISIT_MARK_COMMENT_AS_READ, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVisitCommands()._markCommentAsRead_callback != null)
            {
                this.actionFactory.getVisitCommands()._markCommentAsRead_callback.apply(this, [_local_2]);
                this.actionFactory.getVisitCommands()._markCommentAsRead_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setReceiveIncomingAttack(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_SET_RECEIVE_INCOMING_ATTACK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._setReceiveIncomingAttack_callback != null)
            {
                this.actionFactory.getCommonCommands()._setReceiveIncomingAttack_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._setReceiveIncomingAttack_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_addCommissionQuestArmy(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMISSION_ADD_COMMISSION_QUEST_ARMY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._addCommissionQuestArmy_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._addCommissionQuestArmy_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._addCommissionQuestArmy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_truce_cancelDreamTruce(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TRUCE_CANCEL_DREAM_TRUCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTruceCommands()._cancelDreamTruce_callback != null)
            {
                this.actionFactory.getTruceCommands()._cancelDreamTruce_callback.apply(this, [_local_2]);
                this.actionFactory.getTruceCommands()._cancelDreamTruce_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_RetSetHeroAttri(_arg_1:Object):void
        {
            var _local_2:RandomHeroResponse = new RandomHeroResponse(HERO__RET_SET_HERO_ATTRI, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._RetSetHeroAttri_callback != null)
            {
                this.actionFactory.getHeroCommand()._RetSetHeroAttri_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._RetSetHeroAttri_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_setStopWarState(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CITY_SET_STOP_WAR_STATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._setStopWarState_callback != null)
            {
                this.actionFactory.getCityCommands()._setStopWarState_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._setStopWarState_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_isHasAlliance(_arg_1:Object):void
        {
            var _local_2:HasAllianceResponse = new HasAllianceResponse(ALLIANCE_IS_HAS_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._isHasAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._isHasAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._isHasAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getDestructBuildBean(_arg_1:Object):void
        {
            var _local_2:AvailableBuilingListResponse = new AvailableBuilingListResponse(CASTLE_GET_DESTRUCT_BUILD_BEAN, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._getDestructBuildBean_callback != null)
            {
                this.actionFactory.getCastleCommands()._getDestructBuildBean_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._getDestructBuildBean_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_setDeployTroops(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COLONY_SET_DEPLOY_TROOPS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._setDeployTroops_callback != null)
            {
                this.actionFactory.getColonyCommands()._setDeployTroops_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._setDeployTroops_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getItemDefXml(_arg_1:Object):void
        {
            var _local_2:GetItemDefResponse = new GetItemDefResponse(COMMON_GET_ITEM_DEF_XML, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getItemDefXml_callback != null)
            {
                this.actionFactory.getCommonCommands()._getItemDefXml_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getItemDefXml_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_report_shareReport(_arg_1:Object):void
        {
            var _local_2:ShareReportResponse = new ShareReportResponse(REPORT_SHARE_REPORT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getReportCommands()._shareReport_callback != null)
            {
                this.actionFactory.getReportCommands()._shareReport_callback.apply(this, [_local_2]);
                this.actionFactory.getReportCommands()._shareReport_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_field_getOtherFieldInfo(_arg_1:Object):void
        {
            var _local_2:OtherFieldInfoResponse = new OtherFieldInfoResponse(FIELD_GET_OTHER_FIELD_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFieldCommand()._getOtherFieldInfo_callback != null)
            {
                this.actionFactory.getFieldCommand()._getOtherFieldInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getFieldCommand()._getOtherFieldInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_setAllianceFriendship(_arg_1:Object):void
        {
            var _local_2:AllianceManagementResponse = new AllianceManagementResponse(ALLIANCE_SET_ALLIANCE_FRIENDSHIP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_report_deleteAllReports(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(REPORT_DELETE_ALL_REPORTS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getReportCommands()._deleteAllReports_callback != null)
            {
                this.actionFactory.getReportCommands()._deleteAllReports_callback.apply(this, [_local_2]);
                this.actionFactory.getReportCommands()._deleteAllReports_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_setPowerForUserByAlliance(_arg_1:Object):void
        {
            var _local_2:AllianceManagementResponse = new AllianceManagementResponse(ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_step(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMON_STEP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._step_callback != null)
            {
                this.actionFactory.getCommonCommands()._step_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._step_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_visitorComment(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(VISIT_VISITOR_COMMENT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVisitCommands()._visitorComment_callback != null)
            {
                this.actionFactory.getVisitCommands()._visitorComment_callback.apply(this, [_local_2]);
                this.actionFactory.getVisitCommands()._visitorComment_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_addBuilding(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(GAMEMASTER_ADD_BUILDING, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._addBuilding_callback != null)
            {
                this.actionFactory.getModifyCommands()._addBuilding_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._addBuilding_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_getAllTVMsg(_arg_1:Object):void
        {
            var _local_2:TVResponse = new TVResponse(MAIL_GET_ALL_T_V_MSG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._getAllTVMsg_callback != null)
            {
                this.actionFactory.getMailCommands()._getAllTVMsg_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._getAllTVMsg_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_cancelTrade(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TRADE_CANCEL_TRADE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTradeCommands()._cancelTrade_callback != null)
            {
                this.actionFactory.getTradeCommands()._cancelTrade_callback.apply(this, [_local_2]);
                this.actionFactory.getTradeCommands()._cancelTrade_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_AllianceChatMsg(_arg_1:Object):void
        {
            var _local_2:AllianceChatMsg = new AllianceChatMsg(SERVER_ALLIANCE_CHAT_MSG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onAllianceChatMsg != null)
            {
                this.onAllianceChatMsg.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_equipment_TakeOffAllEquipmenttech(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(EQUIPMENT__TAKE_OFF_ALL_EQUIPMENTTECH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmentCommands()._TakeOffAllEquipmenttech_callback != null)
            {
                this.actionFactory.getEquipmentCommands()._TakeOffAllEquipmenttech_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmentCommands()._TakeOffAllEquipmenttech_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_getStoreList(_arg_1:Object):void
        {
            var _local_2:StoreListResponse = new StoreListResponse(CITY_GET_STORE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._getStoreList_callback != null)
            {
                this.actionFactory.getCityCommands()._getStoreList_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._getStoreList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_getResearchList(_arg_1:Object):void
        {
            var _local_2:AvailableResearchListResponse = new AvailableResearchListResponse(TECH_GET_RESEARCH_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTechCommand()._getResearchList_callback != null)
            {
                this.actionFactory.getTechCommand()._getResearchList_callback.apply(this, [_local_2]);
                this.actionFactory.getTechCommand()._getResearchList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_upgradeBuilding(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_UPGRADE_BUILDING, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._upgradeBuilding_callback != null)
            {
                this.actionFactory.getCastleCommands()._upgradeBuilding_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._upgradeBuilding_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_newBuilding(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_NEW_BUILDING, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._newBuilding_callback != null)
            {
                this.actionFactory.getCastleCommands()._newBuilding_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._newBuilding_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_GetRandomHero(_arg_1:Object):void
        {
            var _local_2:RandomHeroResponse = new RandomHeroResponse(HERO__GET_RANDOM_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._GetRandomHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._GetRandomHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._GetRandomHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_Gem_Smelting(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(SHOP__GEM__SMELTING, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._Gem_Smelting_callback != null)
            {
                this.actionFactory.getShopCommands()._Gem_Smelting_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._Gem_Smelting_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_destructBuilding(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_DESTRUCT_BUILDING, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._destructBuilding_callback != null)
            {
                this.actionFactory.getCastleCommands()._destructBuilding_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._destructBuilding_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_reduceArmaments(_arg_1:Object):void
        {
            var _local_2:CapitalCommandResponse = new CapitalCommandResponse(CAPITAL_REDUCE_ARMAMENTS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCapitalCommands()._reduceArmaments_callback != null)
            {
                this.actionFactory.getCapitalCommands()._reduceArmaments_callback.apply(this, [_local_2]);
                this.actionFactory.getCapitalCommands()._reduceArmaments_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setEventDone(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_SET_EVENT_DONE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._setEventDone_callback != null)
            {
                this.actionFactory.getCommonCommands()._setEventDone_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._setEventDone_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        private function _resp_quest_award(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(QUEST_AWARD, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._award_callback != null)
            {
                this.actionFactory.getQuestCommands()._award_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._award_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_vote_voteToPlayerByName(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(VOTE_VOTE_TO_PLAYER_BY_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVoteToPlayerCommands()._voteToPlayerByName_callback != null)
            {
                this.actionFactory.getVoteToPlayerCommands()._voteToPlayerByName_callback.apply(this, [_local_2]);
                this.actionFactory.getVoteToPlayerCommands()._voteToPlayerByName_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_demolishBuildingQueue(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_DEMOLISH_BUILDING_QUEUE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._demolishBuildingQueue_callback != null)
            {
                this.actionFactory.getCastleCommands()._demolishBuildingQueue_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._demolishBuildingQueue_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_celeb_findAllianceByPrestige(_arg_1:Object):void
        {
            var _local_2:CelebResponse = new CelebResponse(CELEB_FIND_ALLIANCE_BY_PRESTIGE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCelebRankCommands()._findAllianceByPrestige_callback != null)
            {
                this.actionFactory.getCelebRankCommands()._findAllianceByPrestige_callback.apply(this, [_local_2]);
                this.actionFactory.getCelebRankCommands()._findAllianceByPrestige_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_getFortificationsProduceList(_arg_1:Object):void
        {
            var _local_2:FortProduceListResponse = new FortProduceListResponse(FORTIFICATIONS_GET_FORTIFICATIONS_PRODUCE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback != null)
            {
                this.actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback.apply(this, [_local_2]);
                this.actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getCoinsNeed(_arg_1:Object):void
        {
            var _local_2:CoinsNeedResponse = new CoinsNeedResponse(CASTLE_GET_COINS_NEED, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._getCoinsNeed_callback != null)
            {
                this.actionFactory.getCastleCommands()._getCoinsNeed_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._getCoinsNeed_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_disbandFleeTroop(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(ARMY_DISBAND_FLEE_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._disbandFleeTroop_callback != null)
            {
                this.actionFactory.getArmyCommands()._disbandFleeTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._disbandFleeTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_addBlock(_arg_1:Object):void
        {
            var _local_2:FriendResponse = new FriendResponse(FRIEND_ADD_BLOCK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFriendCommands()._addBlock_callback != null)
            {
                this.actionFactory.getFriendCommands()._addBlock_callback.apply(this, [_local_2]);
                this.actionFactory.getFriendCommands()._addBlock_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_addHero(_arg_1:Object):void
        {
            var _local_2:CreateHeroResponse = new CreateHeroResponse(GAMEMASTER_ADD_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._addHero_callback != null)
            {
                this.actionFactory.getModifyCommands()._addHero_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._addHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getMyAcceptedCommissionQuest(_arg_1:Object):void
        {
            var _local_2:CommissionQuestRespone = new CommissionQuestRespone(COMMISSION_GET_MY_ACCEPTED_COMMISSION_QUEST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._getMyAcceptedCommissionQuest_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._getMyAcceptedCommissionQuest_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._getMyAcceptedCommissionQuest_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_EquipmentResearchCompleteUpdate(_arg_1:Object):void
        {
            var _local_2:EquipmentResearchCompleteUpdate = new EquipmentResearchCompleteUpdate(SERVER_EQUIPMENT_RESEARCH_COMPLETE_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onEquipmentResearchCompleteUpdate != null)
            {
                this.onEquipmentResearchCompleteUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_rank_getPlayerRank(_arg_1:Object):void
        {
            var _local_2:RankPlayerResponse = new RankPlayerResponse(RANK_GET_PLAYER_RANK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getRankCommands()._getPlayerRank_callback != null)
            {
                this.actionFactory.getRankCommands()._getPlayerRank_callback.apply(this, [_local_2]);
                this.actionFactory.getRankCommands()._getPlayerRank_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_releaseHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_RELEASE_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._releaseHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._releaseHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._releaseHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_UpdateCastleResources(_arg_1:Object):void
        {
            var _local_2:AvailableBuilingListResponse = new AvailableBuilingListResponse(CASTLE__UPDATE_CASTLE_RESOURCES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._UpdateCastleResources_callback != null)
            {
                this.actionFactory.getCastleCommands()._UpdateCastleResources_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._UpdateCastleResources_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_field_getCastleFieldInfo(_arg_1:Object):void
        {
            var _local_2:CastleFieldInfoResponse = new CastleFieldInfoResponse(FIELD_GET_CASTLE_FIELD_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFieldCommand()._getCastleFieldInfo_callback != null)
            {
                this.actionFactory.getFieldCommand()._getCastleFieldInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getFieldCommand()._getCastleFieldInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getMilitarySituationList(_arg_1:Object):void
        {
            var _local_2:MilitarySituationListResponse = new MilitarySituationListResponse(ALLIANCE_GET_MILITARY_SITUATION_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceCommands()._getMilitarySituationList_callback != null)
            {
                this.actionFactory.getAllianceCommands()._getMilitarySituationList_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceCommands()._getMilitarySituationList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceList(_arg_1:Object):void
        {
            var _local_2:AllianceListResponse = new AllianceListResponse(ALLIANCE_GET_ALLIANCE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceCommands()._getAllianceList_callback != null)
            {
                this.actionFactory.getAllianceCommands()._getAllianceList_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceCommands()._getAllianceList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getEffortListByTargeTypeid(_arg_1:Object):void
        {
            var _local_2:QuestListResponse = new QuestListResponse(QUEST_GET_EFFORT_LIST_BY_TARGE_TYPEID, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._getEffortListByTargeTypeid_callback != null)
            {
                this.actionFactory.getQuestCommands()._getEffortListByTargeTypeid_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._getEffortListByTargeTypeid_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getBuildingQueueCoinsNeed(_arg_1:Object):void
        {
            var _local_2:CoinsNeedResponse = new CoinsNeedResponse(CASTLE_GET_BUILDING_QUEUE_COINS_NEED, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._getBuildingQueueCoinsNeed_callback != null)
            {
                this.actionFactory.getCastleCommands()._getBuildingQueueCoinsNeed_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._getBuildingQueueCoinsNeed_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_celeb_findPlayerByTitle(_arg_1:Object):void
        {
            var _local_2:CelebResponse = new CelebResponse(CELEB_FIND_PLAYER_BY_TITLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCelebRankCommands()._findPlayerByTitle_callback != null)
            {
                this.actionFactory.getCelebRankCommands()._findPlayerByTitle_callback.apply(this, [_local_2]);
                this.actionFactory.getCelebRankCommands()._findPlayerByTitle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceInfo(_arg_1:Object):void
        {
            var _local_2:AllianceInfoResponse = new AllianceInfoResponse(ALLIANCE_GET_ALLIANCE_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceCommands()._getAllianceInfo_callback != null)
            {
                this.actionFactory.getAllianceCommands()._getAllianceInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceCommands()._getAllianceInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_levyTaxes(_arg_1:Object):void
        {
            var _local_2:ColonyLevyeRespone = new ColonyLevyeRespone(COLONY_LEVY_TAXES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._levyTaxes_callback != null)
            {
                this.actionFactory.getColonyCommands()._levyTaxes_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._levyTaxes_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_delUniteServerPeaceStatus(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_DEL_UNITE_SERVER_PEACE_STATUS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._delUniteServerPeaceStatus_callback != null)
            {
                this.actionFactory.getCommonCommands()._delUniteServerPeaceStatus_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._delUniteServerPeaceStatus_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_cancleBuildCommand(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_CANCLE_BUILD_COMMAND, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._cancleBuildCommand_callback != null)
            {
                this.actionFactory.getCastleCommands()._cancleBuildCommand_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._cancleBuildCommand_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_CastleUpdate(_arg_1:Object):void
        {
            var _local_2:CastleUpdate = new CastleUpdate(SERVER_CASTLE_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onCastleUpdate != null)
            {
                this.onCastleUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_city_modifyUserName(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CITY_MODIFY_USER_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._modifyUserName_callback != null)
            {
                this.actionFactory.getCityCommands()._modifyUserName_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._modifyUserName_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setUnlockOption(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_SET_UNLOCK_OPTION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._setUnlockOption_callback != null)
            {
                this.actionFactory.getSecurityCommands()._setUnlockOption_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._setUnlockOption_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_research(_arg_1:Object):void
        {
            var _local_2:ResearchResponse = new ResearchResponse(TECH_RESEARCH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTechCommand()._research_callback != null)
            {
                this.actionFactory.getTechCommand()._research_callback.apply(this, [_local_2]);
                this.actionFactory.getTechCommand()._research_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeName(_arg_1:Object):void
        {
            var _local_2:ChangeNameResponse = new ChangeNameResponse(COMMON_CHANGE_NAME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._changeName_callback != null)
            {
                this.actionFactory.getCommonCommands()._changeName_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._changeName_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_getBuyResourceInfo(_arg_1:Object):void
        {
            var _local_2:BuyResourceInfoResponse = new BuyResourceInfoResponse(SHOP_GET_BUY_RESOURCE_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._getBuyResourceInfo_callback != null)
            {
                this.actionFactory.getShopCommands()._getBuyResourceInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._getBuyResourceInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useGoods(_arg_1:Object):void
        {
            var _local_2:UseItemResultResponse = new UseItemResultResponse(SHOP_USE_GOODS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._useGoods_callback != null)
            {
                this.actionFactory.getShopCommands()._useGoods_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._useGoods_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_recruitFleeHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_RECRUIT_FLEE_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._recruitFleeHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._recruitFleeHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._recruitFleeHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_newTrade(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TRADE_NEW_TRADE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTradeCommands()._newTrade_callback != null)
            {
                this.actionFactory.getTradeCommands()._newTrade_callback.apply(this, [_local_2]);
                this.actionFactory.getTradeCommands()._newTrade_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_FriendArmysUpdate(_arg_1:Object):void
        {
            var _local_2:FriendArmysUpdate = new FriendArmysUpdate(SERVER_FRIEND_ARMYS_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onFriendArmysUpdate != null)
            {
                this.onFriendArmysUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_hero_refreshHerosListFromTavern(_arg_1:Object):void
        {
            var _local_2:HeroListResponse = new HeroListResponse(HERO_REFRESH_HEROS_LIST_FROM_TAVERN, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback != null)
            {
                this.actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_RegisterResponse(_arg_1:Object):void
        {
            var _local_2:RegisterResponse = new RegisterResponse(SERVER_REGISTER_RESPONSE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onRegisterResponse != null)
            {
                this.onRegisterResponse.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_MercenaryUpdate(_arg_1:Object):void
        {
            var _local_2:MercenaryUpdate = new MercenaryUpdate(SERVER_MERCENARY_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onMercenaryUpdate != null)
            {
                this.onMercenaryUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_mapCastle(_arg_1:Object):void
        {
            var _local_2:MapCastleResponse = new MapCastleResponse(COMMON_MAP_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._mapCastle_callback != null)
            {
                this.actionFactory.getCommonCommands()._mapCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._mapCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getVoteRank(_arg_1:Object):void
        {
            var _local_2:RankPlayerVotesResponse = new RankPlayerVotesResponse(RANK_GET_VOTE_RANK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getRankCommands()._getVoteRank_callback != null)
            {
                this.actionFactory.getRankCommands()._getVoteRank_callback.apply(this, [_local_2]);
                this.actionFactory.getRankCommands()._getVoteRank_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_PrivateChatMessage(_arg_1:Object):void
        {
            var _local_2:PrivateChatMessage = new PrivateChatMessage(SERVER_PRIVATE_CHAT_MESSAGE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onPrivateChatMessage != null)
            {
                this.onPrivateChatMessage.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_SecurityCodeRemovedEvent(_arg_1:Object):void
        {
            var _local_2:SecurityCodeRemovedEvent = new SecurityCodeRemovedEvent(SERVER_SECURITY_CODE_REMOVED_EVENT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onSecurityCodeRemovedEvent != null)
            {
                this.onSecurityCodeRemovedEvent.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_mail_reportBug(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(MAIL_REPORT_BUG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._reportBug_callback != null)
            {
                this.actionFactory.getMailCommands()._reportBug_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._reportBug_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_modifyStorePercent(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CITY_MODIFY_STORE_PERCENT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._modifyStorePercent_callback != null)
            {
                this.actionFactory.getCityCommands()._modifyStorePercent_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._modifyStorePercent_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_acceptCommissionQuest(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMISSION_ACCEPT_COMMISSION_QUEST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._acceptCommissionQuest_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._acceptCommissionQuest_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._acceptCommissionQuest_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_getCoinsNeed(_arg_1:Object):void
        {
            var _local_2:CoinsNeedResponse = new CoinsNeedResponse(EQUIPMENTTECH_GET_COINS_NEED, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmenttechCommands()._getCoinsNeed_callback != null)
            {
                this.actionFactory.getEquipmenttechCommands()._getCoinsNeed_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmenttechCommands()._getCoinsNeed_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_disbandInjuredTroop(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(ARMY_DISBAND_INJURED_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._disbandInjuredTroop_callback != null)
            {
                this.actionFactory.getArmyCommands()._disbandInjuredTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._disbandInjuredTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_accTroopProduce(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TROOP_ACC_TROOP_PRODUCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTroopCommands()._accTroopProduce_callback != null)
            {
                this.actionFactory.getTroopCommands()._accTroopProduce_callback.apply(this, [_local_2]);
                this.actionFactory.getTroopCommands()._accTroopProduce_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_newBuildingQueue(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_NEW_BUILDING_QUEUE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._newBuildingQueue_callback != null)
            {
                this.actionFactory.getCastleCommands()._newBuildingQueue_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._newBuildingQueue_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_awardPacket(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(QUEST_AWARD_PACKET, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._awardPacket_callback != null)
            {
                this.actionFactory.getQuestCommands()._awardPacket_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._awardPacket_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getCommissionQuestArmyRanking(_arg_1:Object):void
        {
            var _local_2:CommissionQuestArmyRespone = new CommissionQuestArmyRespone(COMMISSION_GET_COMMISSION_QUEST_ARMY_RANKING, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyRanking_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyRanking_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyRanking_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeUserFace(_arg_1:Object):void
        {
            var _local_2:ChangeUserFaceResponse = new ChangeUserFaceResponse(COMMON_CHANGE_USER_FACE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._changeUserFace_callback != null)
            {
                this.actionFactory.getCommonCommands()._changeUserFace_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._changeUserFace_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_getTransingTradeList(_arg_1:Object):void
        {
            var _local_2:TransingTradeListResponse = new TransingTradeListResponse(TRADE_GET_TRANSING_TRADE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTradeCommands()._getTransingTradeList_callback != null)
            {
                this.actionFactory.getTradeCommands()._getTransingTradeList_callback.apply(this, [_local_2]);
                this.actionFactory.getTradeCommands()._getTransingTradeList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_setResources(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(GAMEMASTER_SET_RESOURCES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._setResources_callback != null)
            {
                this.actionFactory.getModifyCommands()._setResources_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._setResources_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHerosListByFilter(_arg_1:Object):void
        {
            var _local_2:NpcHeroListResponse = new NpcHeroListResponse(NPCHERO_GET_NPC_HEROS_LIST_BY_FILTER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getNpcHeroCommand()._getNpcHerosListByFilter_callback != null)
            {
                this.actionFactory.getNpcHeroCommand()._getNpcHerosListByFilter_callback.apply(this, [_local_2]);
                this.actionFactory.getNpcHeroCommand()._getNpcHerosListByFilter_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_setAllowAllianceArmy(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(ARMY_SET_ALLOW_ALLIANCE_ARMY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._setAllowAllianceArmy_callback != null)
            {
                this.actionFactory.getArmyCommands()._setAllowAllianceArmy_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._setAllowAllianceArmy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_reduceArmaments(_arg_1:Object):void
        {
            var _local_2:ColonyLevyeRespone = new ColonyLevyeRespone(COLONY_REDUCE_ARMAMENTS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._reduceArmaments_callback != null)
            {
                this.actionFactory.getColonyCommands()._reduceArmaments_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._reduceArmaments_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getMyCommissionQuest(_arg_1:Object):void
        {
            var _local_2:CommissionQuestRespone = new CommissionQuestRespone(COMMISSION_GET_MY_COMMISSION_QUEST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._getMyCommissionQuest_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._getMyCommissionQuest_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._getMyCommissionQuest_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_deleteMail(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(MAIL_DELETE_MAIL, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._deleteMail_callback != null)
            {
                this.actionFactory.getMailCommands()._deleteMail_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._deleteMail_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_donate(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(QUEST_DONATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._donate_callback != null)
            {
                this.actionFactory.getQuestCommands()._donate_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._donate_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_leaderWantUserInAllianceList(_arg_1:Object):void
        {
            var _local_2:AllianceInviteOnClientBeanResponse = new AllianceInviteOnClientBeanResponse(ALLIANCE_LEADER_WANT_USER_IN_ALLIANCE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_promoteToChief(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_PROMOTE_TO_CHIEF, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._promoteToChief_callback != null)
            {
                this.actionFactory.getHeroCommand()._promoteToChief_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._promoteToChief_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_receiveMailList(_arg_1:Object):void
        {
            var _local_2:MailListResponse = new MailListResponse(MAIL_RECEIVE_MAIL_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._receiveMailList_callback != null)
            {
                this.actionFactory.getMailCommands()._receiveMailList_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._receiveMailList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_DeclaredWarStatusChange(_arg_1:Object):void
        {
            var _local_2:DeclaredWarStatusChange = new DeclaredWarStatusChange(SERVER_DECLARED_WAR_STATUS_CHANGE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onDeclaredWarStatusChange != null)
            {
                this.onDeclaredWarStatusChange.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_commission_getAllCommissionQuest(_arg_1:Object):void
        {
            var _local_2:* = new CommissionQuestRespone(COMMISSION_GET_ALL_COMMISSION_QUEST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._getAllCommissionQuest_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._getAllCommissionQuest_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._getAllCommissionQuest_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setSecurityCode(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMON_SET_SECURITY_CODE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._setSecurityCode_callback != null)
            {
                this.actionFactory.getSecurityCommands()._setSecurityCode_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._setSecurityCode_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useCastleGoods(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(SHOP_USE_CASTLE_GOODS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._useCastleGoods_callback != null)
            {
                this.actionFactory.getShopCommands()._useCastleGoods_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._useCastleGoods_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_speedupBuildingQueue(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_SPEEDUP_BUILDING_QUEUE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._speedupBuildingQueue_callback != null)
            {
                this.actionFactory.getCastleCommands()._speedupBuildingQueue_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._speedupBuildingQueue_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getAvailableBuildingBean(_arg_1:Object):void
        {
            var _local_2:* = new AvailableBuilingListResponse(CASTLE_GET_AVAILABLE_BUILDING_BEAN, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._getAvailableBuildingBean_callback != null)
            {
                this.actionFactory.getCastleCommands()._getAvailableBuildingBean_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._getAvailableBuildingBean_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getAvailableBuildingListInside(_arg_1:Object):void
        {
            var _local_2:* = new AvailableBuilingListResponse(CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback != null)
            {
                this.actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPackageList(_arg_1:Object):void
        {
            var _local_2:* = new GetPackageListResponse(COMMON_GET_PACKAGE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getPackageList_callback != null)
            {
                this.actionFactory.getCommonCommands()._getPackageList_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getPackageList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getColonialCastlesInfo(_arg_1:Object):void
        {
            var _local_2:* = new ColonialCastlesRespone(COLONY_GET_COLONIAL_CASTLES_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._getColonialCastlesInfo_callback != null)
            {
                this.actionFactory.getColonyCommands()._getColonialCastlesInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._getColonialCastlesInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_tryGetSeizedHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_TRY_GET_SEIZED_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._tryGetSeizedHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._tryGetSeizedHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._tryGetSeizedHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_addUsertoAllianceList(_arg_1:Object):void
        {
            var _local_2:AllianceInviteBeanResponse = new AllianceInviteBeanResponse(ALLIANCE_ADD_USERTO_ALLIANCE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_agreeComeinAllianceByLeader(_arg_1:Object):void
        {
            var _local_2:AllianceManagementResponse = new AllianceManagementResponse(ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getDeployTroopsInfo(_arg_1:Object):void
        {
            var _local_2:ColonialDeployResponse = new ColonialDeployResponse(COLONY_GET_DEPLOY_TROOPS_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._getDeployTroopsInfo_callback != null)
            {
                this.actionFactory.getColonyCommands()._getDeployTroopsInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._getDeployTroopsInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_cancelBuildingQueue(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_CANCEL_BUILDING_QUEUE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._cancelBuildingQueue_callback != null)
            {
                this.actionFactory.getCastleCommands()._cancelBuildingQueue_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._cancelBuildingQueue_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_createNewPlayer(_arg_1:Object):void
        {
            var _local_2:CreatePlayerResponse = new CreatePlayerResponse(COMMON_CREATE_NEW_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._createNewPlayer_callback != null)
            {
                this.actionFactory.getCommonCommands()._createNewPlayer_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._createNewPlayer_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_setAllInfoForAlliance(_arg_1:Object):void
        {
            var _local_2:AllianceManagementResponse = new AllianceManagementResponse(ALLIANCE_SET_ALL_INFO_FOR_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_saveUnregisteredPlayer(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_SAVE_UNREGISTERED_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._saveUnregisteredPlayer_callback != null)
            {
                this.actionFactory.getCommonCommands()._saveUnregisteredPlayer_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._saveUnregisteredPlayer_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceArmyReport(_arg_1:Object):void
        {
            var _local_2:AllianceArmyResponse = new AllianceArmyResponse(ALLIANCE_GET_ALLIANCE_ARMY_REPORT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceCommands()._getAllianceArmyReport_callback != null)
            {
                this.actionFactory.getAllianceCommands()._getAllianceArmyReport_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceCommands()._getAllianceArmyReport_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceWanted(_arg_1:Object):void
        {
            var _local_2:WantedAllianceResponse = new WantedAllianceResponse(ALLIANCE_GET_ALLIANCE_WANTED, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_worldChat(_arg_1:Object):void
        {
            var _local_2:ChatResponse = new ChatResponse(COMMON_WORLD_CHAT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._worldChat_callback != null)
            {
                this.actionFactory.getCommonCommands()._worldChat_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._worldChat_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_BuildingQueueUpdate(_arg_1:Object):void
        {
            var _local_2:BuildingQueueUpdate = new BuildingQueueUpdate(SERVER_BUILDING_QUEUE_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onBuildingQueueUpdate != null)
            {
                this.onBuildingQueueUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_getCanDeclaredWarAgainstPlayer(_arg_1:Object):void
        {
            var _local_2:GetCanDeclaredWarAgainstPlayerRespone = new GetCanDeclaredWarAgainstPlayerRespone(COMMON_GET_CAN_DECLARED_WAR_AGAINST_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getCanDeclaredWarAgainstPlayer_callback != null)
            {
                this.actionFactory.getCommonCommands()._getCanDeclaredWarAgainstPlayer_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getCanDeclaredWarAgainstPlayer_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getQuestType(_arg_1:Object):void
        {
            var _local_2:QuestTypeResponse = new QuestTypeResponse(QUEST_GET_QUEST_TYPE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._getQuestType_callback != null)
            {
                this.actionFactory.getQuestCommands()._getQuestType_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._getQuestType_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_modifyTaxRate(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(INTERIOR_MODIFY_TAX_RATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getInteriorCommands()._modifyTaxRate_callback != null)
            {
                this.actionFactory.getInteriorCommands()._modifyTaxRate_callback.apply(this, [_local_2]);
                this.actionFactory.getInteriorCommands()._modifyTaxRate_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_celeb_findPlayerByStar(_arg_1:Object):void
        {
            var _local_2:CelebResponse = new CelebResponse(CELEB_FIND_PLAYER_BY_STAR, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCelebRankCommands()._findPlayerByStar_callback != null)
            {
                this.actionFactory.getCelebRankCommands()._findPlayerByStar_callback.apply(this, [_local_2]);
                this.actionFactory.getCelebRankCommands()._findPlayerByStar_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_dropAllianceFriendshipRelation(_arg_1:Object):void
        {
            var _local_2:* = new AllianceFriendshipResponse(ALLIANCE_DROP_ALLIANCE_FRIENDSHIP_RELATION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_TakeOffEquipmenttech(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(EQUIPMENT__TAKE_OFF_EQUIPMENTTECH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmentCommands()._TakeOffEquipmenttech_callback != null)
            {
                this.actionFactory.getEquipmentCommands()._TakeOffEquipmenttech_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmentCommands()._TakeOffEquipmenttech_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useTrickItem(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(SHOP_USE_TRICK_ITEM, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._useTrickItem_callback != null)
            {
                this.actionFactory.getShopCommands()._useTrickItem_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._useTrickItem_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_getLeftPoliciesTimes(_arg_1:Object):void
        {
            var _local_2:* = new CapitalCommandResponse(CAPITAL_GET_LEFT_POLICIES_TIMES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCapitalCommands()._getLeftPoliciesTimes_callback != null)
            {
                this.actionFactory.getCapitalCommands()._getLeftPoliciesTimes_callback.apply(this, [_local_2]);
                this.actionFactory.getCapitalCommands()._getLeftPoliciesTimes_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_WearAllEquipmenttech(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(EQUIPMENT__WEAR_ALL_EQUIPMENTTECH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmentCommands()._WearAllEquipmenttech_callback != null)
            {
                this.actionFactory.getEquipmentCommands()._WearAllEquipmenttech_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmentCommands()._WearAllEquipmenttech_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_fireHero(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(HERO_FIRE_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._fireHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._fireHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._fireHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_checkOutUpgrade(_arg_1:Object):void
        {
            var _local_2:* = new CheckOutBuildingResponse(CASTLE_CHECK_OUT_UPGRADE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._checkOutUpgrade_callback != null)
            {
                this.actionFactory.getCastleCommands()._checkOutUpgrade_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._checkOutUpgrade_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getPowerFromAlliance(_arg_1:Object):void
        {
            var _local_2:* = new AlliancePowerLevelResponse(ALLIANCE_GET_POWER_FROM_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_getUsedPoliciesTimes(_arg_1:Object):void
        {
            var _local_2:* = new CapitalCommandResponse(CAPITAL_GET_USED_POLICIES_TIMES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCapitalCommands()._getUsedPoliciesTimes_callback != null)
            {
                this.actionFactory.getCapitalCommands()._getUsedPoliciesTimes_callback.apply(this, [_local_2]);
                this.actionFactory.getCapitalCommands()._getUsedPoliciesTimes_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_kickOutMemberfromAlliance(_arg_1:Object):void
        {
            var _local_2:* = new AllianceManagementResponse(ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_readMail(_arg_1:Object):void
        {
            var _local_2:* = new MailResponse(MAIL_READ_MAIL, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._readMail_callback != null)
            {
                this.actionFactory.getMailCommands()._readMail_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._readMail_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_PlayerBuffUpdate(_arg_1:Object):void
        {
            var _local_2:* = new PlayerBuffUpdate(SERVER_PLAYER_BUFF_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onPlayerBuffUpdate != null)
            {
                this.onPlayerBuffUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_report_markAsRead(_arg_1:Object):void
        {
            var _local_2:* = new ReportResponse(REPORT_MARK_AS_READ, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getReportCommands()._markAsRead_callback != null)
            {
                this.actionFactory.getReportCommands()._markAsRead_callback.apply(this, [_local_2]);
                this.actionFactory.getReportCommands()._markAsRead_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_removeItem(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(GAMEMASTER_REMOVE_ITEM, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._removeItem_callback != null)
            {
                this.actionFactory.getModifyCommands()._removeItem_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._removeItem_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_allianceChat(_arg_1:Object):void
        {
            var _local_2:* = new ChatResponse(COMMON_ALLIANCE_CHAT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._allianceChat_callback != null)
            {
                this.actionFactory.getCommonCommands()._allianceChat_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._allianceChat_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_getTroopProduceList(_arg_1:Object):void
        {
            var _local_2:* = new TroopProduceListResponse(TROOP_GET_TROOP_PRODUCE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTroopCommands()._getTroopProduceList_callback != null)
            {
                this.actionFactory.getTroopCommands()._getTroopProduceList_callback.apply(this, [_local_2]);
                this.actionFactory.getTroopCommands()._getTroopProduceList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_messagesForAllianceMember(_arg_1:Object):void
        {
            var _local_2:* = new AllianceManagementResponse(ALLIANCE_MESSAGES_FOR_ALLIANCE_MEMBER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHeroInfroByID(_arg_1:Object):void
        {
            var _local_2:* = new NpcHeroListResponse(NPCHERO_GET_NPC_HERO_INFRO_BY_I_D, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getNpcHeroCommand()._getNpcHeroInfroByID_callback != null)
            {
                this.actionFactory.getNpcHeroCommand()._getNpcHeroInfroByID_callback.apply(this, [_local_2]);
                this.actionFactory.getNpcHeroCommand()._getNpcHeroInfroByID_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_report_receiveReportList(_arg_1:Object):void
        {
            var _local_2:ReportListResponse = new ReportListResponse(REPORT_RECEIVE_REPORT_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getReportCommands()._receiveReportList_callback != null)
            {
                this.actionFactory.getReportCommands()._receiveReportList_callback.apply(this, [_local_2]);
                this.actionFactory.getReportCommands()._receiveReportList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_buyResource(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(SHOP_BUY_RESOURCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._buyResource_callback != null)
            {
                this.actionFactory.getShopCommands()._buyResource_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._buyResource_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_facebookConnect(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMON_FACEBOOK_CONNECT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._facebookConnect_callback != null)
            {
                this.actionFactory.getCommonCommands()._facebookConnect_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._facebookConnect_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_PackageList(_arg_1:Object):void
        {
            var _local_2:* = new PackageList(SERVER_PACKAGE_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onPackageList != null)
            {
                this.onPackageList.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_city_constructCastle(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(CITY_CONSTRUCT_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._constructCastle_callback != null)
            {
                this.actionFactory.getCityCommands()._constructCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._constructCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_CelebRankCompleteTipResponse(_arg_1:Object):void
        {
            var _local_2:* = new CelebRankCompleteTipResponse(SERVER_CELEB_RANK_COMPLETE_TIP_RESPONSE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onCelebRankCompleteTipResponse != null)
            {
                this.onCelebRankCompleteTipResponse.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_PlayerInfoUpdate(_arg_1:Object):void
        {
            var _local_2:* = new PlayerInfoUpdate(SERVER_PLAYER_INFO_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onPlayerInfoUpdate != null)
            {
                this.onPlayerInfoUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_UnregisteredCreatePlayerResponse(_arg_1:Object):void
        {
            var _local_2:* = null;
            _local_2 = new UnregisteredCreatePlayerResponse(SERVER_UNREGISTERED_CREATE_PLAYER_RESPONSE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onUnregisteredCreatePlayerResponse != null)
            {
                this.onUnregisteredCreatePlayerResponse.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_alliance_sayByetoAlliance(_arg_1:Object):void
        {
            var _local_2:* = new AllianceManagementResponse(ALLIANCE_SAY_BYETO_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_levyFood(_arg_1:Object):void
        {
            var _local_2:* = new ColonyLevyeRespone(COLONY_LEVY_FOOD, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._levyFood_callback != null)
            {
                this.actionFactory.getColonyCommands()._levyFood_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._levyFood_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_modifyCommenceRate(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(INTERIOR_MODIFY_COMMENCE_RATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getInteriorCommands()._modifyCommenceRate_callback != null)
            {
                this.actionFactory.getInteriorCommands()._modifyCommenceRate_callback.apply(this, [_local_2]);
                this.actionFactory.getInteriorCommands()._modifyCommenceRate_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_removeBuilding(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(GAMEMASTER_REMOVE_BUILDING, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._removeBuilding_callback != null)
            {
                this.actionFactory.getModifyCommands()._removeBuilding_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._removeBuilding_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_callBackHero(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(HERO_CALL_BACK_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._callBackHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._callBackHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._callBackHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_readOverMailList(_arg_1:Object):void
        {
            var _local_2:* = new MailResponse(MAIL_READ_OVER_MAIL_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._readOverMailList_callback != null)
            {
                this.actionFactory.getMailCommands()._readOverMailList_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._readOverMailList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getIsSecurityCodeSetted(_arg_1:Object):void
        {
            var _local_2:* = new GetIsSecurityCodeSettedResponse(COMMON_GET_IS_SECURITY_CODE_SETTED, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._getIsSecurityCodeSetted_callback != null)
            {
                this.actionFactory.getSecurityCommands()._getIsSecurityCodeSetted_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._getIsSecurityCodeSetted_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_CastleFieldUpdate(_arg_1:Object):void
        {
            var _local_2:* = new CastleFieldUpdate(SERVER_CASTLE_FIELD_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onCastleFieldUpdate != null)
            {
                this.onCastleFieldUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_alliance_getAllianceEventList(_arg_1:Object):void
        {
            var _local_2:* = new AllianceEventListResponse(ALLIANCE_GET_ALLIANCE_EVENT_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceCommands()._getAllianceEventList_callback != null)
            {
                this.actionFactory.getAllianceCommands()._getAllianceEventList_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceCommands()._getAllianceEventList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_getResearchList(_arg_1:Object):void
        {
            var _local_2:* = new AvailableResearchListResponse(EQUIPMENTTECH_GET_RESEARCH_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmenttechCommands()._getResearchList_callback != null)
            {
                this.actionFactory.getEquipmenttechCommands()._getResearchList_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmenttechCommands()._getResearchList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_declaredWarAgainstPlayer(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMON_DECLARED_WAR_AGAINST_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._declaredWarAgainstPlayer_callback != null)
            {
                this.actionFactory.getCommonCommands()._declaredWarAgainstPlayer_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._declaredWarAgainstPlayer_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_disbandTroop(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(TROOP_DISBAND_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTroopCommands()._disbandTroop_callback != null)
            {
                this.actionFactory.getTroopCommands()._disbandTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getTroopCommands()._disbandTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_GetPlayerVoteInfro(_arg_1:Object):void
        {
            var _local_2:* = new GetPlayerVoteInfro(SERVER_GET_PLAYER_VOTE_INFRO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onGetPlayerVoteInfro != null)
            {
                this.onGetPlayerVoteInfro.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_city_modifyCastleIcon(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(CITY_MODIFY_CASTLE_ICON, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._modifyCastleIcon_callback != null)
            {
                this.actionFactory.getCityCommands()._modifyCastleIcon_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._modifyCastleIcon_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_deleteComment(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(VISIT_DELETE_COMMENT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVisitCommands()._deleteComment_callback != null)
            {
                this.actionFactory.getVisitCommands()._deleteComment_callback.apply(this, [_local_2]);
                this.actionFactory.getVisitCommands()._deleteComment_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getHeroRank(_arg_1:Object):void
        {
            var _local_2:* = new RankHeroResponse(RANK_GET_HERO_RANK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getRankCommands()._getHeroRank_callback != null)
            {
                this.actionFactory.getRankCommands()._getHeroRank_callback.apply(this, [_local_2]);
                this.actionFactory.getRankCommands()._getHeroRank_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_zoneInfo(_arg_1:Object):void
        {
            var _local_2:* = new ZoneInfoResponse(COMMON_ZONE_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._zoneInfo_callback != null)
            {
                this.actionFactory.getCommonCommands()._zoneInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._zoneInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getTroopParam(_arg_1:Object):void
        {
            var _local_2:* = new TroopParamResponse(ARMY_GET_TROOP_PARAM, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._getTroopParam_callback != null)
            {
                this.actionFactory.getArmyCommands()._getTroopParam_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._getTroopParam_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_getProduceQueue(_arg_1:Object):void
        {
            var _local_2:ProduceQueueResponse = new ProduceQueueResponse(FORTIFICATIONS_GET_PRODUCE_QUEUE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFortificationsCommands()._getProduceQueue_callback != null)
            {
                this.actionFactory.getFortificationsCommands()._getProduceQueue_callback.apply(this, [_local_2]);
                this.actionFactory.getFortificationsCommands()._getProduceQueue_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamblingranking_getGamblingRankingReward(_arg_1:Object):void
        {
            var _local_2:* = new GamblingRankingRewardRespone(GAMBLINGRANKING_GET_GAMBLING_RANKING_REWARD, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getGamblingRankingCommands()._getGamblingRankingReward_callback != null)
            {
                this.actionFactory.getGamblingRankingCommands()._getGamblingRankingReward_callback.apply(this, [_local_2]);
                this.actionFactory.getGamblingRankingCommands()._getGamblingRankingReward_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_createAlliance(_arg_1:Object):void
        {
            var _local_2:AllianceManagementResponse = new AllianceManagementResponse(ALLIANCE_CREATE_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._createAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._createAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._createAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_WarMoveCastle(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CITY__WAR_MOVE_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._WarMoveCastle_callback != null)
            {
                this.actionFactory.getCityCommands()._WarMoveCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._WarMoveCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_WorldChatMsg(_arg_1:Object):void
        {
            var _local_2:WorldChatMsg = new WorldChatMsg(SERVER_WORLD_CHAT_MSG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onWorldChatMsg != null)
            {
                this.onWorldChatMsg.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_fortifications_produceWallProtect(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(FORTIFICATIONS_PRODUCE_WALL_PROTECT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFortificationsCommands()._produceWallProtect_callback != null)
            {
                this.actionFactory.getFortificationsCommands()._produceWallProtect_callback.apply(this, [_local_2]);
                this.actionFactory.getFortificationsCommands()._produceWallProtect_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_abandonColony(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COLONY_ABANDON_COLONY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._abandonColony_callback != null)
            {
                this.actionFactory.getColonyCommands()._abandonColony_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._abandonColony_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_speedUpResearch(_arg_1:Object):void
        {
            var _local_2:* = new ResearchResponse(TECH_SPEED_UP_RESEARCH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTechCommand()._speedUpResearch_callback != null)
            {
                this.actionFactory.getTechCommand()._speedUpResearch_callback.apply(this, [_local_2]);
                this.actionFactory.getTechCommand()._speedUpResearch_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeHeadline(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMON_CHANGE_HEADLINE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._changeHeadline_callback != null)
            {
                this.actionFactory.getCommonCommands()._changeHeadline_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._changeHeadline_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_cancelUserWantInAlliance(_arg_1:Object):void
        {
            var _local_2:* = new AllianceManagementResponse(ALLIANCE_CANCEL_USER_WANT_IN_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_RecoverDisappearHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO__RECOVER_DISAPPEAR_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._RecoverDisappearHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._RecoverDisappearHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._RecoverDisappearHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_stratagem_useStratagem(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(STRATAGEM_USE_STRATAGEM, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getStratagemCommands()._useStratagem_callback != null)
            {
                this.actionFactory.getStratagemCommands()._useStratagem_callback.apply(this, [_local_2]);
                this.actionFactory.getStratagemCommands()._useStratagem_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getAllianceRank(_arg_1:Object):void
        {
            var _local_2:RankAllianceResponse = new RankAllianceResponse(RANK_GET_ALLIANCE_RANK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getRankCommands()._getAllianceRank_callback != null)
            {
                this.actionFactory.getRankCommands()._getAllianceRank_callback.apply(this, [_local_2]);
                this.actionFactory.getRankCommands()._getAllianceRank_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_TradesUpdate(_arg_1:Object):void
        {
            var _local_2:TradesUpdate = new TradesUpdate(SERVER_TRADES_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onTradesUpdate != null)
            {
                this.onTradesUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_city_advMoveCastle(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(CITY_ADV_MOVE_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._advMoveCastle_callback != null)
            {
                this.actionFactory.getCityCommands()._advMoveCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._advMoveCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_resetTopPowerForAlliance(_arg_1:Object):void
        {
            var _local_2:* = new AllianceManagementResponse(ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_pacifyPeople(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(INTERIOR_PACIFY_PEOPLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getInteriorCommands()._pacifyPeople_callback != null)
            {
                this.actionFactory.getInteriorCommands()._pacifyPeople_callback.apply(this, [_local_2]);
                this.actionFactory.getInteriorCommands()._pacifyPeople_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyFood(_arg_1:Object):void
        {
            var _local_2:* = new CapitalCommandResponse(CAPITAL_LEVY_FOOD, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCapitalCommands()._levyFood_callback != null)
            {
                this.actionFactory.getCapitalCommands()._levyFood_callback.apply(this, [_local_2]);
                this.actionFactory.getCapitalCommands()._levyFood_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_TransingTradeUpdate(_arg_1:Object):void
        {
            var _local_2:* = null;
            _local_2 = new TransingTradeUpdate(SERVER_TRANSING_TRADE_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onTransingTradeUpdate != null)
            {
                this.onTransingTradeUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_castle_saveCastleSignList(_arg_1:Object):void
        {
            var _local_2:* = new CastleSignResponse(CASTLE_SAVE_CASTLE_SIGN_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleSignCommand()._saveCastleSignList_callback != null)
            {
                this.actionFactory.getCastleSignCommand()._saveCastleSignList_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleSignCommand()._saveCastleSignList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_denyPlayerSpeak(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMON_DENY_PLAYER_SPEAK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._denyPlayerSpeak_callback != null)
            {
                this.actionFactory.getCommonCommands()._denyPlayerSpeak_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._denyPlayerSpeak_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getAvailableBuildingListOutside(_arg_1:Object):void
        {
            var _local_2:* = new AvailableBuilingListResponse(CASTLE_GET_AVAILABLE_BUILDING_LIST_OUTSIDE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback != null)
            {
                this.actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_TroopUpdate(_arg_1:Object):void
        {
            var _local_2:* = null;
            _local_2 = new TroopUpdate(SERVER_TROOP_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onTroopUpdate != null)
            {
                this.onTroopUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_city_modifyFlag(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(CITY_MODIFY_FLAG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._modifyFlag_callback != null)
            {
                this.actionFactory.getCityCommands()._modifyFlag_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._modifyFlag_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_getAllVisitorComments(_arg_1:Object):void
        {
            var _local_2:* = new GetAllVisitorCommentsResponse(VISIT_GET_ALL_VISITOR_COMMENTS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVisitCommands()._getAllVisitorComments_callback != null)
            {
                this.actionFactory.getVisitCommands()._getAllVisitorComments_callback.apply(this, [_local_2]);
                this.actionFactory.getVisitCommands()._getAllVisitorComments_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_SystemInfoMsg(_arg_1:Object):void
        {
            var _local_2:* = null;
            _local_2 = new SystemInfoMsg(SERVER_SYSTEM_INFO_MSG, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onSystemInfoMsg != null)
            {
                this.onSystemInfoMsg.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_setEvonyMemberEMail(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMON_SET_EVONY_MEMBER_E_MAIL, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._setEvonyMemberEMail_callback != null)
            {
                this.actionFactory.getCommonCommands()._setEvonyMemberEMail_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._setEvonyMemberEMail_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_resignForAlliance(_arg_1:Object):void
        {
            var _local_2:* = new AllianceManagementResponse(ALLIANCE_RESIGN_FOR_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._resignForAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._resignForAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._resignForAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_cancelagreeComeinAlliance(_arg_1:Object):void
        {
            var _local_2:* = new AllianceUserAddResponse(ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_overviewColonialCastle(_arg_1:Object):void
        {
            var _local_2:* = new OverviewColonyCastleRespone(COLONY_OVERVIEW_COLONIAL_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._overviewColonialCastle_callback != null)
            {
                this.actionFactory.getColonyCommands()._overviewColonialCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._overviewColonialCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_DeclaredWarUpdate(_arg_1:Object):void
        {
            var _local_2:* = new DeclaredWarUpdate(SERVER_DECLARED_WAR_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onDeclaredWarUpdate != null)
            {
                this.onDeclaredWarUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_friend_deleteBlock(_arg_1:Object):void
        {
            var _local_2:FriendResponse = new FriendResponse(FRIEND_DELETE_BLOCK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFriendCommands()._deleteBlock_callback != null)
            {
                this.actionFactory.getFriendCommands()._deleteBlock_callback.apply(this, [_local_2]);
                this.actionFactory.getFriendCommands()._deleteBlock_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_addItems(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(GAMEMASTER_ADD_ITEMS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._addItems_callback != null)
            {
                this.actionFactory.getModifyCommands()._addItems_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._addItems_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_truce_setDreamTruce(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TRUCE_SET_DREAM_TRUCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTruceCommands()._setDreamTruce_callback != null)
            {
                this.actionFactory.getTruceCommands()._setDreamTruce_callback.apply(this, [_local_2]);
                this.actionFactory.getTruceCommands()._setDreamTruce_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_uniteAdvMoveCastle(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CITY_UNITE_ADV_MOVE_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._uniteAdvMoveCastle_callback != null)
            {
                this.actionFactory.getCityCommands()._uniteAdvMoveCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._uniteAdvMoveCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHerosList(_arg_1:Object):void
        {
            var _local_2:NpcHeroListResponse = new NpcHeroListResponse(NPCHERO_GET_NPC_HEROS_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getNpcHeroCommand()._getNpcHerosList_callback != null)
            {
                this.actionFactory.getNpcHeroCommand()._getNpcHerosList_callback.apply(this, [_local_2]);
                this.actionFactory.getNpcHeroCommand()._getNpcHerosList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_speedUpBuildCommand(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(CASTLE_SPEED_UP_BUILD_COMMAND, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleCommands()._speedUpBuildCommand_callback != null)
            {
                this.actionFactory.getCastleCommands()._speedUpBuildCommand_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleCommands()._speedUpBuildCommand_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_LoginResponse(_arg_1:Object):void
        {
            var _local_2:LoginResponse = new LoginResponse(SERVER_LOGIN_RESPONSE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onLoginResponse != null)
            {
                this.onLoginResponse.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_setProtectOption(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_SET_PROTECT_OPTION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._setProtectOption_callback != null)
            {
                this.actionFactory.getSecurityCommands()._setProtectOption_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._setProtectOption_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getSuzerainColonialCastlesInfo(_arg_1:Object):void
        {
            var _local_2:ColonialCastlesRespone = new ColonialCastlesRespone(COLONY_GET_SUZERAIN_COLONIAL_CASTLES_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._getSuzerainColonialCastlesInfo_callback != null)
            {
                this.actionFactory.getColonyCommands()._getSuzerainColonialCastlesInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._getSuzerainColonialCastlesInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_canceladdUsertoAlliance(_arg_1:Object):void
        {
            var _local_2:AllianceInviteBeanResponse;
            _local_2 = new AllianceInviteBeanResponse(ALLIANCE_CANCELADD_USERTO_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_removeSecurityCode(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COMMON_REMOVE_SECURITY_CODE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._removeSecurityCode_callback != null)
            {
                this.actionFactory.getSecurityCommands()._removeSecurityCode_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._removeSecurityCode_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_GetDisappearHeros(_arg_1:Object):void
        {
            var _local_2:DisappearHeroResponse = new DisappearHeroResponse(HERO__GET_DISAPPEAR_HEROS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._GetDisappearHeros_callback != null)
            {
                this.actionFactory.getHeroCommand()._GetDisappearHeros_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._GetDisappearHeros_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_setArmyGoOut(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(ARMY_SET_ARMY_GO_OUT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._setArmyGoOut_callback != null)
            {
                this.actionFactory.getArmyCommands()._setArmyGoOut_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._setArmyGoOut_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getAwardItems(_arg_1:Object):void
        {
            var _local_2:QuestRewardRespone;
            _local_2 = new QuestRewardRespone(QUEST_GET_AWARD_ITEMS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._getAwardItems_callback != null)
            {
                this.actionFactory.getQuestCommands()._getAwardItems_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._getAwardItems_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_reportPlayer(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(MAIL_REPORT_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._reportPlayer_callback != null)
            {
                this.actionFactory.getMailCommands()._reportPlayer_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._reportPlayer_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_declineCommissionQuest(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COMMISSION_DECLINE_COMMISSION_QUEST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._declineCommissionQuest_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._declineCommissionQuest_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._declineCommissionQuest_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_speedUpTrans(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(TRADE_SPEED_UP_TRANS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTradeCommands()._speedUpTrans_callback != null)
            {
                this.actionFactory.getTradeCommands()._speedUpTrans_callback.apply(this, [_local_2]);
                this.actionFactory.getTradeCommands()._speedUpTrans_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_uprise(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COLONY_UPRISE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._uprise_callback != null)
            {
                this.actionFactory.getColonyCommands()._uprise_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._uprise_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_deleteUserAndRestart(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COMMON_DELETE_USER_AND_RESTART, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._deleteUserAndRestart_callback != null)
            {
                this.actionFactory.getCommonCommands()._deleteUserAndRestart_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._deleteUserAndRestart_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setReturnReport(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COMMON_SET_RETURN_REPORT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._setReturnReport_callback != null)
            {
                this.actionFactory.getCommonCommands()._setReturnReport_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._setReturnReport_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_NewReport(_arg_1:Object):void
        {
            var _local_2:NewReport;
            _local_2 = new NewReport(SERVER_NEW_REPORT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onNewReport != null)
            {
                this.onNewReport.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_FleeTroopUpdate(_arg_1:Object):void
        {
            var _local_2:FleeTroopUpdate;
            _local_2 = new FleeTroopUpdate(SERVER_FLEE_TROOP_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onFleeTroopUpdate != null)
            {
                this.onFleeTroopUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_gamblingranking_getGamblingRankingYesterday(_arg_1:Object):void
        {
            var _local_2:GamblingRankingRespone;
            _local_2 = new GamblingRankingRespone(GAMBLINGRANKING_GET_GAMBLING_RANKING_YESTERDAY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getGamblingRankingCommands()._getGamblingRankingYesterday_callback != null)
            {
                this.actionFactory.getGamblingRankingCommands()._getGamblingRankingYesterday_callback.apply(this, [_local_2]);
                this.actionFactory.getGamblingRankingCommands()._getGamblingRankingYesterday_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_buy(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(SHOP_BUY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getShopCommands()._buy_callback != null)
            {
                this.actionFactory.getShopCommands()._buy_callback.apply(this, [_local_2]);
                this.actionFactory.getShopCommands()._buy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_getVisitorComments(_arg_1:Object):void
        {
            var _local_2:GetAllVisitorCommentsResponse;
            _local_2 = new GetAllVisitorCommentsResponse(VISIT_GET_VISITOR_COMMENTS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getVisitCommands()._getVisitorComments_callback != null)
            {
                this.actionFactory.getVisitCommands()._getVisitorComments_callback.apply(this, [_local_2]);
                this.actionFactory.getVisitCommands()._getVisitorComments_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPackage(_arg_1:Object):void
        {
            var _local_2:GetPackageResponse;
            _local_2 = new GetPackageResponse(COMMON_GET_PACKAGE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getPackage_callback != null)
            {
                this.actionFactory.getCommonCommands()._getPackage_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getPackage_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyTaxes(_arg_1:Object):void
        {
            var _local_2:CapitalCommandResponse;
            _local_2 = new CapitalCommandResponse(CAPITAL_LEVY_TAXES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCapitalCommands()._levyTaxes_callback != null)
            {
                this.actionFactory.getCapitalCommands()._levyTaxes_callback.apply(this, [_local_2]);
                this.actionFactory.getCapitalCommands()._levyTaxes_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_sendMail(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(MAIL_SEND_MAIL, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getMailCommands()._sendMail_callback != null)
            {
                this.actionFactory.getMailCommands()._sendMail_callback.apply(this, [_local_2]);
                this.actionFactory.getMailCommands()._sendMail_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_authSecurityCode(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(COMMON_AUTH_SECURITY_CODE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._authSecurityCode_callback != null)
            {
                this.actionFactory.getSecurityCommands()._authSecurityCode_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._authSecurityCode_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_resetPoint(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(HERO_RESET_POINT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._resetPoint_callback != null)
            {
                this.actionFactory.getHeroCommand()._resetPoint_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._resetPoint_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_mapInfo(_arg_1:Object):void
        {
            var _local_2:MapInfoResponse;
            _local_2 = new MapInfoResponse(COMMON_MAP_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._mapInfo_callback != null)
            {
                this.actionFactory.getCommonCommands()._mapInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._mapInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_exerciseArmy(_arg_1:Object):void
        {
            var _local_2:ArmyPracticeResponse;
            _local_2 = new ArmyPracticeResponse(ARMY_EXERCISE_ARMY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._exerciseArmy_callback != null)
            {
                this.actionFactory.getArmyCommands()._exerciseArmy_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._exerciseArmy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_removeHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(GAMEMASTER_REMOVE_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getModifyCommands()._removeHero_callback != null)
            {
                this.actionFactory.getModifyCommands()._removeHero_callback.apply(this, [_local_2]);
                this.actionFactory.getModifyCommands()._removeHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_cancelResearch(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(TECH_CANCEL_RESEARCH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTechCommand()._cancelResearch_callback != null)
            {
                this.actionFactory.getTechCommand()._cancelResearch_callback.apply(this, [_local_2]);
                this.actionFactory.getTechCommand()._cancelResearch_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getEffortList(_arg_1:Object):void
        {
            var _local_2:EffortListResponse;
            _local_2 = new EffortListResponse(QUEST_GET_EFFORT_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._getEffortList_callback != null)
            {
                this.actionFactory.getQuestCommands()._getEffortList_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._getEffortList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_BuildComplate(_arg_1:Object):void
        {
            var _local_2:BuildComplate;
            _local_2 = new BuildComplate(SERVER_BUILD_COMPLATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onBuildComplate != null)
            {
                this.onBuildComplate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_alliance_rejectComeinAlliance(_arg_1:Object):void
        {
            var _local_2:AllianceUserAddResponse;
            _local_2 = new AllianceUserAddResponse(ALLIANCE_REJECT_COMEIN_ALLIANCE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_FortificationsUpdate(_arg_1:Object):void
        {
            var _local_2:FortificationsUpdate = new FortificationsUpdate(SERVER_FORTIFICATIONS_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onFortificationsUpdate != null)
            {
                this.onFortificationsUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_army_callBackArmy(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(ARMY_CALL_BACK_ARMY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._callBackArmy_callback != null)
            {
                this.actionFactory.getArmyCommands()._callBackArmy_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._callBackArmy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_getFleeHeroList(_arg_1:Object):void
        {
            var _local_2:HeroListResponse;
            _local_2 = new HeroListResponse(HERO_GET_FLEE_HERO_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._getFleeHeroList_callback != null)
            {
                this.actionFactory.getHeroCommand()._getFleeHeroList_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._getFleeHeroList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ItemUpdate(_arg_1:Object):void
        {
            var _local_2:ItemUpdate;
            _local_2 = new ItemUpdate(SERVER_ITEM_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onItemUpdate != null)
            {
                this.onItemUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_hero_useItem(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(HERO_USE_ITEM, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._useItem_callback != null)
            {
                this.actionFactory.getHeroCommand()._useItem_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._useItem_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_HeroUpdate(_arg_1:Object):void
        {
            var _local_2:HeroUpdate;
            _local_2 = new HeroUpdate(SERVER_HERO_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onHeroUpdate != null)
            {
                this.onHeroUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_hero_hireFacebookFriendHero(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_HIRE_FACEBOOK_FRIEND_HERO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._hireFacebookFriendHero_callback != null)
            {
                this.actionFactory.getHeroCommand()._hireFacebookFriendHero_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._hireFacebookFriendHero_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_field_giveUpField(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(FIELD_GIVE_UP_FIELD, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFieldCommand()._giveUpField_callback != null)
            {
                this.actionFactory.getFieldCommand()._giveUpField_callback.apply(this, [_local_2]);
                this.actionFactory.getFieldCommand()._giveUpField_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_truce_changeDreamTruceTime(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TRUCE_CHANGE_DREAM_TRUCE_TIME, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTruceCommands()._changeDreamTruceTime_callback != null)
            {
                this.actionFactory.getTruceCommands()._changeDreamTruceTime_callback.apply(this, [_local_2]);
                this.actionFactory.getTruceCommands()._changeDreamTruceTime_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_isBlockMailPlayer(_arg_1:Object):void
        {
            var _local_2:FriendResponse = new FriendResponse(FRIEND_IS_BLOCK_MAIL_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFriendCommands()._isBlockMailPlayer_callback != null)
            {
                this.actionFactory.getFriendCommands()._isBlockMailPlayer_callback.apply(this, [_local_2]);
                this.actionFactory.getFriendCommands()._isBlockMailPlayer_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ResearchCompleteUpdate(_arg_1:Object):void
        {
            var _local_2:ResearchCompleteUpdate = new ResearchCompleteUpdate(SERVER_RESEARCH_COMPLETE_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onResearchCompleteUpdate != null)
            {
                this.onResearchCompleteUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_NewFinishedQuest(_arg_1:Object):void
        {
            var _local_2:NewFinishedQuest = new NewFinishedQuest(SERVER_NEW_FINISHED_QUEST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onNewFinishedQuest != null)
            {
                this.onNewFinishedQuest.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_hero_levelUp(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_LEVEL_UP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._levelUp_callback != null)
            {
                this.actionFactory.getHeroCommand()._levelUp_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._levelUp_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_setHeroFacebookId(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_SET_HERO_FACEBOOK_ID, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._setHeroFacebookId_callback != null)
            {
                this.actionFactory.getHeroCommand()._setHeroFacebookId_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._setHeroFacebookId_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_checkIdleBarrack(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TROOP_CHECK_IDLE_BARRACK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTroopCommands()._checkIdleBarrack_callback != null)
            {
                this.actionFactory.getTroopCommands()._checkIdleBarrack_callback.apply(this, [_local_2]);
                this.actionFactory.getTroopCommands()._checkIdleBarrack_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_produceTroop(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(TROOP_PRODUCE_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTroopCommands()._produceTroop_callback != null)
            {
                this.actionFactory.getTroopCommands()._produceTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getTroopCommands()._produceTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyPopulation(_arg_1:Object):void
        {
            var _local_2:CapitalCommandResponse = new CapitalCommandResponse(CAPITAL_LEVY_POPULATION, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCapitalCommands()._levyPopulation_callback != null)
            {
                this.actionFactory.getCapitalCommands()._levyPopulation_callback.apply(this, [_local_2]);
                this.actionFactory.getCapitalCommands()._levyPopulation_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_agreeComeinAllianceByUser(_arg_1:Object):void
        {
            var _local_2:AllianceUserAddResponse = new AllianceUserAddResponse(ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_USER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback != null)
            {
                this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback.apply(this, [_local_2]);
                this.actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_deleteCastleSign(_arg_1:Object):void
        {
            var _local_2:CastleSignResponse = new CastleSignResponse(CASTLE_DELETE_CASTLE_SIGN, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCastleSignCommand()._deleteCastleSign_callback != null)
            {
                this.actionFactory.getCastleSignCommand()._deleteCastleSign_callback.apply(this, [_local_2]);
                this.actionFactory.getCastleSignCommand()._deleteCastleSign_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_CbUpdate(_arg_1:Object):void
        {
            var _local_2:CbUpdate = new CbUpdate(SERVER_CB_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onCbUpdate != null)
            {
                this.onCbUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_GetTopVotesPlayer(_arg_1:Object):void
        {
            var _local_2:GetTopVotesPlayer = new GetTopVotesPlayer(SERVER_GET_TOP_VOTES_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onGetTopVotesPlayer != null)
            {
                this.onGetTopVotesPlayer.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_celeb_findPlayerByPrestige(_arg_1:Object):void
        {
            var _local_2:CelebResponse = new CelebResponse(CELEB_FIND_PLAYER_BY_PRESTIGE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCelebRankCommands()._findPlayerByPrestige_callback != null)
            {
                this.actionFactory.getCelebRankCommands()._findPlayerByPrestige_callback.apply(this, [_local_2]);
                this.actionFactory.getCelebRankCommands()._findPlayerByPrestige_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPackageNumber(_arg_1:Object):void
        {
            var _local_2:GetPackageNumberResponse = new GetPackageNumberResponse(COMMON_GET_PACKAGE_NUMBER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getPackageNumber_callback != null)
            {
                this.actionFactory.getCommonCommands()._getPackageNumber_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getPackageNumber_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getQuestList(_arg_1:Object):void
        {
            var _local_2:QuestListResponse = new QuestListResponse(QUEST_GET_QUEST_LIST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getQuestCommands()._getQuestList_callback != null)
            {
                this.actionFactory.getQuestCommands()._getQuestList_callback.apply(this, [_local_2]);
                this.actionFactory.getQuestCommands()._getQuestList_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getStayAllianceArmys(_arg_1:Object):void
        {
            var _local_2:StayAllianceReponse = new StayAllianceReponse(ARMY_GET_STAY_ALLIANCE_ARMYS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._getStayAllianceArmys_callback != null)
            {
                this.actionFactory.getArmyCommands()._getStayAllianceArmys_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._getStayAllianceArmys_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_cancelRemovingSecurityCodeProcess(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_CANCEL_REMOVING_SECURITY_CODE_PROCESS, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getSecurityCommands()._cancelRemovingSecurityCodeProcess_callback != null)
            {
                this.actionFactory.getSecurityCommands()._cancelRemovingSecurityCodeProcess_callback.apply(this, [_local_2]);
                this.actionFactory.getSecurityCommands()._cancelRemovingSecurityCodeProcess_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_ItemBuff(_arg_1:Object):void
        {
            var _local_2:ItemBuff = new ItemBuff(SERVER_ITEM_BUFF, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onItemBuff != null)
            {
                this.onItemBuff.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_NewMail(_arg_1:Object):void
        {
            var _local_2:NewMail = new NewMail(SERVER_NEW_MAIL, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onNewMail != null)
            {
                this.onNewMail.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_CastleBuffUpdate(_arg_1:Object):void
        {
            var _local_2:CastleBuffUpdate = new CastleBuffUpdate(SERVER_CASTLE_BUFF_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onCastleBuffUpdate != null)
            {
                this.onCastleBuffUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_friend_addFriend(_arg_1:Object):void
        {
            var _local_2:FriendResponse = new FriendResponse(FRIEND_ADD_FRIEND, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFriendCommands()._addFriend_callback != null)
            {
                this.actionFactory.getFriendCommands()._addFriend_callback.apply(this, [_local_2]);
                this.actionFactory.getFriendCommands()._addFriend_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getCommissionQuestArmyInfo(_arg_1:Object):void
        {
            var _local_2:CommissionQuestArmyInfoRespone = new CommissionQuestArmyInfoRespone(COMMISSION_GET_COMMISSION_QUEST_ARMY_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyInfo_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_WearEquipmenttech(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(EQUIPMENT__WEAR_EQUIPMENTTECH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmentCommands()._WearEquipmenttech_callback != null)
            {
                this.actionFactory.getEquipmentCommands()._WearEquipmenttech_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmentCommands()._WearEquipmenttech_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_getHerosListFromTavern(_arg_1:Object):void
        {
            var _local_2:HeroListResponse = new HeroListResponse(HERO_GET_HEROS_LIST_FROM_TAVERN, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._getHerosListFromTavern_callback != null)
            {
                this.actionFactory.getHeroCommand()._getHerosListFromTavern_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._getHerosListFromTavern_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_levyArmy(_arg_1:Object):void
        {
            var _local_2:ColonyLevyeRespone = new ColonyLevyeRespone(COLONY_LEVY_ARMY, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._levyArmy_callback != null)
            {
                this.actionFactory.getColonyCommands()._levyArmy_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._levyArmy_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_destructWallProtect(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(FORTIFICATIONS_DESTRUCT_WALL_PROTECT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getFortificationsCommands()._destructWallProtect_callback != null)
            {
                this.actionFactory.getFortificationsCommands()._destructWallProtect_callback.apply(this, [_local_2]);
                this.actionFactory.getFortificationsCommands()._destructWallProtect_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getColonialArmyInfo(_arg_1:Object):void
        {
            var _local_2:ColonialArmyResponse = new ColonialArmyResponse(COLONY_GET_COLONIAL_ARMY_INFO, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getColonyCommands()._getColonialArmyInfo_callback != null)
            {
                this.actionFactory.getColonyCommands()._getColonialArmyInfo_callback.apply(this, [_local_2]);
                this.actionFactory.getColonyCommands()._getColonialArmyInfo_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_searchTrades(_arg_1:Object):void
        {
            var _local_2:SearchTradesResponse = new SearchTradesResponse(TRADE_SEARCH_TRADES, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getTradeCommands()._searchTrades_callback != null)
            {
                this.actionFactory.getTradeCommands()._searchTrades_callback.apply(this, [_local_2]);
                this.actionFactory.getTradeCommands()._searchTrades_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_EnhancedByGemStone(_arg_1:Object):void
        {
            var _local_2:* = undefined;
            _local_2 = new GemstoneRespone(EQUIPMENT__ENHANCED_BY_GEM_STONE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmentCommands()._EnhancedByGemStone_callback != null)
            {
                this.actionFactory.getEquipmentCommands()._EnhancedByGemStone_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmentCommands()._EnhancedByGemStone_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_QuestFinished(_arg_1:Object):void
        {
            var _local_2:QuestFinished = new QuestFinished(SERVER_QUEST_FINISHED, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onQuestFinished != null)
            {
                this.onQuestFinished.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_EnemyArmysUpdate(_arg_1:Object):void
        {
            var _local_2:EnemyArmysUpdate = new EnemyArmysUpdate(SERVER_ENEMY_ARMYS_UPDATE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onEnemyArmysUpdate != null)
            {
                this.onEnemyArmysUpdate.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_commission_issueCommissionQuest(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(COMMISSION_ISSUE_COMMISSION_QUEST, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommissionQuestCommands()._issueCommissionQuest_callback != null)
            {
                this.actionFactory.getCommissionQuestCommands()._issueCommissionQuest_callback.apply(this, [_local_2]);
                this.actionFactory.getCommissionQuestCommands()._issueCommissionQuest_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getRelationship(_arg_1:Object):void
        {
            var _local_2:* = undefined;
            _local_2 = new GetRelationshipRespone(COMMON_GET_RELATIONSHIP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._getRelationship_callback != null)
            {
                this.actionFactory.getCommonCommands()._getRelationship_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._getRelationship_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_city_moveCastle(_arg_1:Object):void
        {
            var _local_2:* = undefined;
            _local_2 = new CommandResponse(CITY_MOVE_CASTLE, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCityCommands()._moveCastle_callback != null)
            {
                this.actionFactory.getCityCommands()._moveCastle_callback.apply(this, [_local_2]);
                this.actionFactory.getCityCommands()._moveCastle_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getTopVotesPlayer(_arg_1:Object):void
        {
            var _local_2:TopVotesPlayersResponse = new TopVotesPlayersResponse(RANK_GET_TOP_VOTES_PLAYER, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getRankCommands()._getTopVotesPlayer_callback != null)
            {
                this.actionFactory.getRankCommands()._getTopVotesPlayer_callback.apply(this, [_local_2]);
                this.actionFactory.getRankCommands()._getTopVotesPlayer_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_awardGold(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(HERO_AWARD_GOLD, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._awardGold_callback != null)
            {
                this.actionFactory.getHeroCommand()._awardGold_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._awardGold_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_research(_arg_1:Object):void
        {
            var _local_2:* = new ResearchResponse(EQUIPMENTTECH_RESEARCH, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getEquipmenttechCommands()._research_callback != null)
            {
                this.actionFactory.getEquipmenttechCommands()._research_callback.apply(this, [_local_2]);
                this.actionFactory.getEquipmenttechCommands()._research_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getInjuredTroop(_arg_1:Object):void
        {
            var _local_2:* = new CommandResponse(ARMY_GET_INJURED_TROOP, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getArmyCommands()._getInjuredTroop_callback != null)
            {
                this.actionFactory.getArmyCommands()._getInjuredTroop_callback.apply(this, [_local_2]);
                this.actionFactory.getArmyCommands()._getInjuredTroop_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_dischargeChief(_arg_1:Object):void
        {
            var _local_2:CommandResponse;
            _local_2 = new CommandResponse(HERO_DISCHARGE_CHIEF, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._dischargeChief_callback != null)
            {
                this.actionFactory.getHeroCommand()._dischargeChief_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._dischargeChief_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_KickedOut(_arg_1:Object):void
        {
            var _local_2:KickedOut;
            _local_2 = new KickedOut(SERVER_KICKED_OUT, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.onKickedOut != null)
            {
                this.onKickedOut.apply(this, [_local_2]);
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
        }

        private function _resp_common_setAutoHeal(_arg_1:Object):void
        {
            var _local_2:CommandResponse = new CommandResponse(COMMON_SET_AUTO_HEAL, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getCommonCommands()._setAutoHeal_callback != null)
            {
                this.actionFactory.getCommonCommands()._setAutoHeal_callback.apply(this, [_local_2]);
                this.actionFactory.getCommonCommands()._setAutoHeal_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getCastleRank(_arg_1:Object):void
        {
            var _local_2:RankCastleResponse = new RankCastleResponse(RANK_GET_CASTLE_RANK, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getRankCommands()._getCastleRank_callback != null)
            {
                this.actionFactory.getRankCommands()._getCastleRank_callback.apply(this, [_local_2]);
                this.actionFactory.getRankCommands()._getCastleRank_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_SetShowHeroId(_arg_1:Object):void
        {
            var _local_2:SetShowInfroResponse = new SetShowInfroResponse(HERO__SET_SHOW_HERO_ID, _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (this.actionFactory.getHeroCommand()._SetShowHeroId_callback != null)
            {
                this.actionFactory.getHeroCommand()._SetShowHeroId_callback.apply(this, [_local_2]);
                this.actionFactory.getHeroCommand()._SetShowHeroId_callback = null;
            };
            if (hasEventListener(_local_2.type))
            {
                dispatchEvent(_local_2);
            }
            else
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            };
            MouseManager.setNormal();
        }


    }
}//package com.evony.client.response

