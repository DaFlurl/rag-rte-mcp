// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.response.ResponseDispatcher

package com.evony.client.response
{
    import flash.events.EventDispatcher;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.BaseBean;
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
    import com.evony.common.module.common.MapCastleResponse;
    import com.evony.common.module.rank.RankPlayerVotesResponse;
    import com.evony.common.server.events.PrivateChatMessage;
    import com.evony.common.server.events.MercenaryUpdate;
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
    import com.evony.common.module.alliance.WantedAllianceResponse;
    import com.evony.common.module.alliance.AllianceArmyResponse;
    import com.evony.common.module.common.GetCanDeclaredWarAgainstPlayerRespone;
    import com.evony.common.module.quest.QuestTypeResponse;
    import com.evony.common.module.castle.CheckOutBuildingResponse;
    import com.evony.common.module.alliance.AlliancePowerLevelResponse;
    import com.evony.common.module.mail.MailResponse;
    import com.evony.common.server.events.PlayerBuffUpdate;
    import com.evony.common.server.events.BuildingQueueUpdate;
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
    import com.evony.common.module.hero.DisappearHeroResponse;
    import com.evony.common.module.quest.QuestRewardRespone;
    import com.evony.common.server.events.LoginResponse;
    import com.evony.common.server.events.NewReport;
    import com.evony.common.server.events.FleeTroopUpdate;
    import com.evony.common.module.common.GetPackageResponse;
    import com.evony.common.server.events.DeclaredWarUpdate;
    import com.evony.common.module.common.MapInfoResponse;
    import com.evony.common.module.army.ArmyPracticeResponse;
    import com.evony.common.module.quest.EffortListResponse;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.common.server.events.ItemUpdate;
    import com.evony.common.server.events.HeroUpdate;
    import com.evony.common.server.events.FortificationsUpdate;
    import com.evony.common.server.events.ResearchCompleteUpdate;
    import com.evony.common.server.events.NewFinishedQuest;
    import com.evony.common.server.events.CbUpdate;
    import com.evony.common.server.events.GetTopVotesPlayer;
    import com.evony.common.module.common.GetPackageNumberResponse;
    import com.evony.common.module.army.StayAllianceReponse;
    import com.evony.common.server.events.ItemBuff;
    import com.evony.common.server.events.NewMail;
    import com.evony.common.module.commission.CommissionQuestArmyInfoRespone;
    import com.evony.common.server.events.CastleBuffUpdate;
    import com.evony.common.module.colony.ColonialArmyResponse;
    import com.evony.common.server.events.EnemyArmysUpdate;
    import com.evony.common.module.trade.SearchTradesResponse;
    import com.evony.common.module.common.GetRelationshipRespone;
    import com.evony.common.module.rank.TopVotesPlayersResponse;
    import com.evony.common.server.events.QuestFinished;
    import com.evony.common.module.rank.RankCastleResponse;
    import com.evony.common.server.events.KickedOut;
    import com.evony.common.module.hero.SetShowInfroResponse;

    public class ResponseDispatcher extends EventDispatcher 
    {

        public static const ALLIANCE_GET_ALLIANCE_ARMY_REPORT:String = "alliance.getAllianceArmyReport";
        public static const ALLIANCE_GET_ALLIANCE_EVENT_LIST:String = "alliance.getAllianceEventList";
        public static const ALLIANCE_GET_ALLIANCE_INFO:String = "alliance.getAllianceInfo";
        public static const ALLIANCE_GET_ALLIANCE_LIST:String = "alliance.getAllianceList";
        public static const ALLIANCE_GET_ALLIANCE_MEMBERS:String = "alliance.getAllianceMembers";
        public static const ALLIANCE_GET_MILITARY_SITUATION_LIST:String = "alliance.getMilitarySituationList";
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
        public static const ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST:String = "alliance.getAllianceFriendshipList";
        public static const ALLIANCE_GET_ALLIANCE_WANTED:String = "alliance.getAllianceWanted";
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
        public static const ARMY__IS_DROP_ITEM_IN_CASTLE:String = "army.IsDropItemInCastle";
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
        public static const CASTLE_SPEED_UP_BUILD_COMMAND:String = "castle.speedUpBuildCommand";
        public static const CASTLE_SPEEDUP_BUILDING_QUEUE:String = "castle.speedupBuildingQueue";
        public static const CASTLE_UPGRADE_BUILDING:String = "castle.upgradeBuilding";
        public static const CASTLE_DELETE_CASTLE_SIGN:String = "castle.deleteCastleSign";
        public static const CASTLE_SAVE_CASTLE_SIGN_LIST:String = "castle.saveCastleSignList";
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
        public static const COMMON_CHANGE_HEADLINE:String = "common.changeHeadline";
        public static const COMMON_CHANGE_NAME:String = "common.changeName";
        public static const COMMON_CHANGE_USER_FACE:String = "common.changeUserFace";
        public static const COMMON_CHANNEL_CHAT:String = "common.channelChat";
        public static const COMMON_CREATE_NEW_PLAYER:String = "common.createNewPlayer";
        public static const COMMON_DECLARED_WAR_AGAINST_PLAYER:String = "common.declaredWarAgainstPlayer";
        public static const COMMON_DEL_UNITE_SERVER_PEACE_STATUS:String = "common.delUniteServerPeaceStatus";
        public static const COMMON_DELETE_USER_AND_RESTART:String = "common.deleteUserAndRestart";
        public static const COMMON_DENY_PLAYER_SPEAK:String = "common.denyPlayerSpeak";
        public static const COMMON_FACEBOOK_CONNECT:String = "common.facebookConnect";
        public static const COMMON_GET_CAN_DECLARED_WAR_AGAINST_PLAYER:String = "common.getCanDeclaredWarAgainstPlayer";
        public static const COMMON_GET_ITEM_DEF_XML:String = "common.getItemDefXml";
        public static const COMMON_GET_PACKAGE:String = "common.getPackage";
        public static const COMMON_GET_PACKAGE_LIST:String = "common.getPackageList";
        public static const COMMON_GET_PACKAGE_NUMBER:String = "common.getPackageNumber";
        public static const COMMON_GET_PLAYER_DECLARED_WAR_STATUS:String = "common.getPlayerDeclaredWarStatus";
        public static const COMMON_GET_PLAYER_INFO_BY_NAME:String = "common.getPlayerInfoByName";
        public static const COMMON_GET_RELATIONSHIP:String = "common.getRelationship";
        public static const COMMON_MAP_CASTLE:String = "common.mapCastle";
        public static const COMMON_MAP_INFO:String = "common.mapInfo";
        public static const COMMON_MAP_INFO_SIMPLE:String = "common.mapInfoSimple";
        public static const COMMON_PRIVATE_CHAT:String = "common.privateChat";
        public static const COMMON_SAVE_UNREGISTERED_PLAYER:String = "common.saveUnregisteredPlayer";
        public static const COMMON_SET_AUTO_HEAL:String = "common.setAutoHeal";
        public static const COMMON_SET_EOVNY_MEMBER:String = "common.setEovnyMember";
        public static const COMMON_SET_EVENT_DONE:String = "common.setEventDone";
        public static const COMMON_SET_EVONY_MEMBER_E_MAIL:String = "common.setEvonyMemberEMail";
        public static const COMMON_SET_RECEIVE_INCOMING_ATTACK:String = "common.setReceiveIncomingAttack";
        public static const COMMON_SET_RETURN_REPORT:String = "common.setReturnReport";
        public static const COMMON_SET_TROOP_CONFIG:String = "common.setTroopConfig";
        public static const COMMON_STEP:String = "common.step";
        public static const COMMON_WORLD_CHAT:String = "common.worldChat";
        public static const COMMON_ZONE_INFO:String = "common.zoneInfo";
        public static const COMMON_AUTH_SECURITY_CODE:String = "common.authSecurityCode";
        public static const COMMON_CANCEL_REMOVING_SECURITY_CODE_PROCESS:String = "common.cancelRemovingSecurityCodeProcess";
        public static const COMMON_CHANGE_SECURITY_CODE:String = "common.changeSecurityCode";
        public static const COMMON_GET_IS_SECURITY_CODE_SETTED:String = "common.getIsSecurityCodeSetted";
        public static const COMMON_GET_PROTECT_OPTION:String = "common.getProtectOption";
        public static const COMMON_REMOVE_SECURITY_CODE:String = "common.removeSecurityCode";
        public static const COMMON_SET_PROTECT_OPTION:String = "common.setProtectOption";
        public static const COMMON_SET_SECURITY_CODE:String = "common.setSecurityCode";
        public static const COMMON_SET_UNLOCK_OPTION:String = "common.setUnlockOption";
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
        public static const QUEST__ALLOW_REGISTER:String = "quest.AllowRegister";
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
        private static var instance:ResponseDispatcher = new (ResponseDispatcher)();
        private static var istrace:Boolean = false;

        public var onRegisterResponse:Function = null;
        public var onSelfArmysUpdate:Function = null;
        public var onPrivateChatMessage:Function = null;
        public var onKickedOut:Function = null;
        public var onNewMail:Function = null;
        public var onWorldChatMsg:Function = null;
        public var onHeroUpdate:Function = null;
        public var onTradesUpdate:Function = null;
        public var onPlayerBuffUpdate:Function = null;
        public var onDeclaredWarStatusChange:Function = null;
        public var onPlayerInfoUpdate:Function = null;
        public var onAllianceChatMsg:Function = null;
        public var onItemUpdate:Function = null;
        public var onItemBuff:Function = null;
        public var onSecurityCodeRemovedEvent:Function = null;
        public var onCbUpdate:Function = null;
        public var onGetPlayerVoteInfro:Function = null;
        public var onFriendArmysUpdate:Function = null;
        public var onMercenaryUpdate:Function = null;
        public var onBuildingQueueUpdate:Function = null;
        public var onChangeName:Function = null;
        public var onNewFinishedQuest:Function = null;
        public var onColonyUpdate:Function = null;
        public var onStrategyBuff:Function = null;
        private var actionFactory:ActionFactory = ActionFactory.getInstance();
        public var onCastleBuffUpdate:Function = null;
        public var onCastleFieldUpdate:Function = null;
        public var onEnemyArmysUpdate:Function = null;
        public var onResourceUpdate:Function = null;
        public var onChannelChatMsg:Function = null;
        public var onCelebRankCompleteTipResponse:Function = null;
        public var onTransingTradeUpdate:Function = null;
        public var onFortificationsUpdate:Function = null;
        public var onResearchCompleteUpdate:Function = null;
        public var onDeclaredWarUpdate:Function = null;
        public var onPackageList:Function = null;
        public var onUnregisteredCreatePlayerResponse:Function = null;
        public var onInjuredTroopUpdate:Function = null;
        public var onConnectionLost:Function = null;
        public var onVisitorHelpEvent:Function = null;
        public var onFleeTroopUpdate:Function = null;
        public var onBuildComplate:Function = null;
        public var onSystemInfoMsg:Function = null;
        public var onLoginResponse:Function = null;
        public var onEquipmentResearchCompleteUpdate:Function = null;
        public var onGetTopVotesPlayer:Function = null;
        public var onTroopUpdate:Function = null;
        public var onCastleUpdate:Function = null;
        private var respMap:Object = new Object();
        public var onAcademyResearchUpdate:Function = null;
        public var onQuestCompleteTipResponse:Function = null;
        public var onNewReport:Function = null;
        public var onQuestFinished:Function = null;

        public function ResponseDispatcher()
        {
            respMap["alliance.getAllianceArmyReport"] = _resp_alliance_getAllianceArmyReport;
            respMap["alliance.getAllianceEventList"] = _resp_alliance_getAllianceEventList;
            respMap["alliance.getAllianceInfo"] = _resp_alliance_getAllianceInfo;
            respMap["alliance.getAllianceList"] = _resp_alliance_getAllianceList;
            respMap["alliance.getAllianceMembers"] = _resp_alliance_getAllianceMembers;
            respMap["alliance.getMilitarySituationList"] = _resp_alliance_getMilitarySituationList;
            respMap["alliance.addUsertoAlliance"] = _resp_alliance_addUsertoAlliance;
            respMap["alliance.addUsertoAllianceList"] = _resp_alliance_addUsertoAllianceList;
            respMap["alliance.agreeComeinAllianceByLeader"] = _resp_alliance_agreeComeinAllianceByLeader;
            respMap["alliance.agreeComeinAllianceByUser"] = _resp_alliance_agreeComeinAllianceByUser;
            respMap["alliance.agreeComeinAllianceList"] = _resp_alliance_agreeComeinAllianceList;
            respMap["alliance.cancelUserWantInAlliance"] = _resp_alliance_cancelUserWantInAlliance;
            respMap["alliance.canceladdUsertoAlliance"] = _resp_alliance_canceladdUsertoAlliance;
            respMap["alliance.cancelagreeComeinAlliance"] = _resp_alliance_cancelagreeComeinAlliance;
            respMap["alliance.createAlliance"] = _resp_alliance_createAlliance;
            respMap["alliance.dropAllianceFriendshipRelation"] = _resp_alliance_dropAllianceFriendshipRelation;
            respMap["alliance.getAllianceFriendshipList"] = _resp_alliance_getAllianceFriendshipList;
            respMap["alliance.getAllianceWanted"] = _resp_alliance_getAllianceWanted;
            respMap["alliance.getPowerFromAlliance"] = _resp_alliance_getPowerFromAlliance;
            respMap["alliance.isHasAlliance"] = _resp_alliance_isHasAlliance;
            respMap["alliance.kickOutMemberfromAlliance"] = _resp_alliance_kickOutMemberfromAlliance;
            respMap["alliance.leaderWantUserInAllianceList"] = _resp_alliance_leaderWantUserInAllianceList;
            respMap["alliance.messagesForAllianceMember"] = _resp_alliance_messagesForAllianceMember;
            respMap["alliance.rejectComeinAlliance"] = _resp_alliance_rejectComeinAlliance;
            respMap["alliance.resetTopPowerForAlliance"] = _resp_alliance_resetTopPowerForAlliance;
            respMap["alliance.resignForAlliance"] = _resp_alliance_resignForAlliance;
            respMap["alliance.sayByetoAlliance"] = _resp_alliance_sayByetoAlliance;
            respMap["alliance.setAllInfoForAlliance"] = _resp_alliance_setAllInfoForAlliance;
            respMap["alliance.setAllianceFriendship"] = _resp_alliance_setAllianceFriendship;
            respMap["alliance.setPowerForUserByAlliance"] = _resp_alliance_setPowerForUserByAlliance;
            respMap["alliance.userWantInAlliance"] = _resp_alliance_userWantInAlliance;
            respMap["army.IsDropItemInCastle"] = _resp_army_IsDropItemInCastle;
            respMap["army.callBackArmy"] = _resp_army_callBackArmy;
            respMap["army.cureInjuredTroop"] = _resp_army_cureInjuredTroop;
            respMap["army.disbandFleeTroop"] = _resp_army_disbandFleeTroop;
            respMap["army.disbandInjuredTroop"] = _resp_army_disbandInjuredTroop;
            respMap["army.exerciseArmy"] = _resp_army_exerciseArmy;
            respMap["army.getFleeTroop"] = _resp_army_getFleeTroop;
            respMap["army.getInjuredTroop"] = _resp_army_getInjuredTroop;
            respMap["army.getStayAllianceArmys"] = _resp_army_getStayAllianceArmys;
            respMap["army.getTroopParam"] = _resp_army_getTroopParam;
            respMap["army.newArmy"] = _resp_army_newArmy;
            respMap["army.recruitFleeTroop"] = _resp_army_recruitFleeTroop;
            respMap["army.setAllowAllianceArmy"] = _resp_army_setAllowAllianceArmy;
            respMap["army.setArmyGoOut"] = _resp_army_setArmyGoOut;
            respMap["capital.getLeftPoliciesTimes"] = _resp_capital_getLeftPoliciesTimes;
            respMap["capital.getUsedPoliciesTimes"] = _resp_capital_getUsedPoliciesTimes;
            respMap["capital.levyArmy"] = _resp_capital_levyArmy;
            respMap["capital.levyFood"] = _resp_capital_levyFood;
            respMap["capital.levyPopulation"] = _resp_capital_levyPopulation;
            respMap["capital.levyTaxes"] = _resp_capital_levyTaxes;
            respMap["capital.reduceArmaments"] = _resp_capital_reduceArmaments;
            respMap["castle.UpdateCastleResources"] = _resp_castle_UpdateCastleResources;
            respMap["castle.cancelBuildingQueue"] = _resp_castle_cancelBuildingQueue;
            respMap["castle.cancleBuildCommand"] = _resp_castle_cancleBuildCommand;
            respMap["castle.checkOutUpgrade"] = _resp_castle_checkOutUpgrade;
            respMap["castle.demolishBuildingQueue"] = _resp_castle_demolishBuildingQueue;
            respMap["castle.destructBuilding"] = _resp_castle_destructBuilding;
            respMap["castle.getAvailableBuildingBean"] = _resp_castle_getAvailableBuildingBean;
            respMap["castle.getAvailableBuildingListInside"] = _resp_castle_getAvailableBuildingListInside;
            respMap["castle.getAvailableBuildingListOutside"] = _resp_castle_getAvailableBuildingListOutside;
            respMap["castle.getBuildingQueueCoinsNeed"] = _resp_castle_getBuildingQueueCoinsNeed;
            respMap["castle.getCoinsNeed"] = _resp_castle_getCoinsNeed;
            respMap["castle.getDestructBuildBean"] = _resp_castle_getDestructBuildBean;
            respMap["castle.newBuilding"] = _resp_castle_newBuilding;
            respMap["castle.newBuildingQueue"] = _resp_castle_newBuildingQueue;
            respMap["castle.speedUpBuildCommand"] = _resp_castle_speedUpBuildCommand;
            respMap["castle.speedupBuildingQueue"] = _resp_castle_speedupBuildingQueue;
            respMap["castle.upgradeBuilding"] = _resp_castle_upgradeBuilding;
            respMap["castle.deleteCastleSign"] = _resp_castle_deleteCastleSign;
            respMap["castle.saveCastleSignList"] = _resp_castle_saveCastleSignList;
            respMap["celeb.findAllianceByPrestige"] = _resp_celeb_findAllianceByPrestige;
            respMap["celeb.findPlayerByPrestige"] = _resp_celeb_findPlayerByPrestige;
            respMap["celeb.findPlayerByStar"] = _resp_celeb_findPlayerByStar;
            respMap["celeb.findPlayerByTitle"] = _resp_celeb_findPlayerByTitle;
            respMap["city.WarMoveCastle"] = _resp_city_WarMoveCastle;
            respMap["city.advMoveCastle"] = _resp_city_advMoveCastle;
            respMap["city.constructCastle"] = _resp_city_constructCastle;
            respMap["city.getStoreList"] = _resp_city_getStoreList;
            respMap["city.giveupCastle"] = _resp_city_giveupCastle;
            respMap["city.modifyCastleIcon"] = _resp_city_modifyCastleIcon;
            respMap["city.modifyCastleName"] = _resp_city_modifyCastleName;
            respMap["city.modifyFlag"] = _resp_city_modifyFlag;
            respMap["city.modifyStorePercent"] = _resp_city_modifyStorePercent;
            respMap["city.modifyUserName"] = _resp_city_modifyUserName;
            respMap["city.moveCastle"] = _resp_city_moveCastle;
            respMap["city.setStopWarState"] = _resp_city_setStopWarState;
            respMap["city.uniteAdvMoveCastle"] = _resp_city_uniteAdvMoveCastle;
            respMap["colony.abandonColony"] = _resp_colony_abandonColony;
            respMap["colony.getColonialArmyInfo"] = _resp_colony_getColonialArmyInfo;
            respMap["colony.getColonialCastlesInfo"] = _resp_colony_getColonialCastlesInfo;
            respMap["colony.getDeployTroopsInfo"] = _resp_colony_getDeployTroopsInfo;
            respMap["colony.getSuzerainColonialCastlesInfo"] = _resp_colony_getSuzerainColonialCastlesInfo;
            respMap["colony.levyArmy"] = _resp_colony_levyArmy;
            respMap["colony.levyFood"] = _resp_colony_levyFood;
            respMap["colony.levyPopulation"] = _resp_colony_levyPopulation;
            respMap["colony.levyTaxes"] = _resp_colony_levyTaxes;
            respMap["colony.overviewColonialCastle"] = _resp_colony_overviewColonialCastle;
            respMap["colony.reduceArmaments"] = _resp_colony_reduceArmaments;
            respMap["colony.setDeployTroops"] = _resp_colony_setDeployTroops;
            respMap["colony.sowDiscord"] = _resp_colony_sowDiscord;
            respMap["colony.speedUpAbandonColony"] = _resp_colony_speedUpAbandonColony;
            respMap["colony.uprise"] = _resp_colony_uprise;
            respMap["commission.acceptCommissionQuest"] = _resp_commission_acceptCommissionQuest;
            respMap["commission.addCommissionQuestArmy"] = _resp_commission_addCommissionQuestArmy;
            respMap["commission.declineCommissionQuest"] = _resp_commission_declineCommissionQuest;
            respMap["commission.getAllCommissionQuest"] = _resp_commission_getAllCommissionQuest;
            respMap["commission.getCommissionQuestArmyInfo"] = _resp_commission_getCommissionQuestArmyInfo;
            respMap["commission.getCommissionQuestArmyRanking"] = _resp_commission_getCommissionQuestArmyRanking;
            respMap["commission.getMyAcceptedCommissionQuest"] = _resp_commission_getMyAcceptedCommissionQuest;
            respMap["commission.getMyCommissionQuest"] = _resp_commission_getMyCommissionQuest;
            respMap["commission.issueCommissionQuest"] = _resp_commission_issueCommissionQuest;
            respMap["common.addToFavorites"] = _resp_common_addToFavorites;
            respMap["common.allianceChat"] = _resp_common_allianceChat;
            respMap["common.changeHeadline"] = _resp_common_changeHeadline;
            respMap["common.changeName"] = _resp_common_changeName;
            respMap["common.changeUserFace"] = _resp_common_changeUserFace;
            respMap["common.channelChat"] = _resp_common_channelChat;
            respMap["common.createNewPlayer"] = _resp_common_createNewPlayer;
            respMap["common.declaredWarAgainstPlayer"] = _resp_common_declaredWarAgainstPlayer;
            respMap["common.delUniteServerPeaceStatus"] = _resp_common_delUniteServerPeaceStatus;
            respMap["common.deleteUserAndRestart"] = _resp_common_deleteUserAndRestart;
            respMap["common.denyPlayerSpeak"] = _resp_common_denyPlayerSpeak;
            respMap["common.facebookConnect"] = _resp_common_facebookConnect;
            respMap["common.getCanDeclaredWarAgainstPlayer"] = _resp_common_getCanDeclaredWarAgainstPlayer;
            respMap["common.getItemDefXml"] = _resp_common_getItemDefXml;
            respMap["common.getPackage"] = _resp_common_getPackage;
            respMap["common.getPackageList"] = _resp_common_getPackageList;
            respMap["common.getPackageNumber"] = _resp_common_getPackageNumber;
            respMap["common.getPlayerDeclaredWarStatus"] = _resp_common_getPlayerDeclaredWarStatus;
            respMap["common.getPlayerInfoByName"] = _resp_common_getPlayerInfoByName;
            respMap["common.getRelationship"] = _resp_common_getRelationship;
            respMap["common.mapCastle"] = _resp_common_mapCastle;
            respMap["common.mapInfo"] = _resp_common_mapInfo;
            respMap["common.mapInfoSimple"] = _resp_common_mapInfoSimple;
            respMap["common.privateChat"] = _resp_common_privateChat;
            respMap["common.saveUnregisteredPlayer"] = _resp_common_saveUnregisteredPlayer;
            respMap["common.setAutoHeal"] = _resp_common_setAutoHeal;
            respMap["common.setEovnyMember"] = _resp_common_setEovnyMember;
            respMap["common.setEventDone"] = _resp_common_setEventDone;
            respMap["common.setEvonyMemberEMail"] = _resp_common_setEvonyMemberEMail;
            respMap["common.setReceiveIncomingAttack"] = _resp_common_setReceiveIncomingAttack;
            respMap["common.setReturnReport"] = _resp_common_setReturnReport;
            respMap["common.setTroopConfig"] = _resp_common_setTroopConfig;
            respMap["common.step"] = _resp_common_step;
            respMap["common.worldChat"] = _resp_common_worldChat;
            respMap["common.zoneInfo"] = _resp_common_zoneInfo;
            respMap["common.authSecurityCode"] = _resp_common_authSecurityCode;
            respMap["common.cancelRemovingSecurityCodeProcess"] = _resp_common_cancelRemovingSecurityCodeProcess;
            respMap["common.changeSecurityCode"] = _resp_common_changeSecurityCode;
            respMap["common.getIsSecurityCodeSetted"] = _resp_common_getIsSecurityCodeSetted;
            respMap["common.getProtectOption"] = _resp_common_getProtectOption;
            respMap["common.removeSecurityCode"] = _resp_common_removeSecurityCode;
            respMap["common.setProtectOption"] = _resp_common_setProtectOption;
            respMap["common.setSecurityCode"] = _resp_common_setSecurityCode;
            respMap["common.setUnlockOption"] = _resp_common_setUnlockOption;
            respMap["equipment.EnhancedByGemStone"] = _resp_equipment_EnhancedByGemStone;
            respMap["equipment.EnhancedStarByGemStone"] = _resp_equipment_EnhancedStarByGemStone;
            respMap["equipment.TakeOffAllEquipmenttech"] = _resp_equipment_TakeOffAllEquipmenttech;
            respMap["equipment.TakeOffEquipmenttech"] = _resp_equipment_TakeOffEquipmenttech;
            respMap["equipment.WearAllEquipmenttech"] = _resp_equipment_WearAllEquipmenttech;
            respMap["equipment.WearEquipmenttech"] = _resp_equipment_WearEquipmenttech;
            respMap["equipmenttech.cancelResearch"] = _resp_equipmenttech_cancelResearch;
            respMap["equipmenttech.getCoinsNeed"] = _resp_equipmenttech_getCoinsNeed;
            respMap["equipmenttech.getResearchList"] = _resp_equipmenttech_getResearchList;
            respMap["equipmenttech.research"] = _resp_equipmenttech_research;
            respMap["equipmenttech.speedUpResearch"] = _resp_equipmenttech_speedUpResearch;
            respMap["field.getCastleFieldInfo"] = _resp_field_getCastleFieldInfo;
            respMap["field.getOtherFieldInfo"] = _resp_field_getOtherFieldInfo;
            respMap["field.giveUpField"] = _resp_field_giveUpField;
            respMap["fortifications.accTroopProduce"] = _resp_fortifications_accTroopProduce;
            respMap["fortifications.cancelFortificationProduce"] = _resp_fortifications_cancelFortificationProduce;
            respMap["fortifications.destructWallProtect"] = _resp_fortifications_destructWallProtect;
            respMap["fortifications.getFortificationsProduceList"] = _resp_fortifications_getFortificationsProduceList;
            respMap["fortifications.getProduceQueue"] = _resp_fortifications_getProduceQueue;
            respMap["fortifications.produceWallProtect"] = _resp_fortifications_produceWallProtect;
            respMap["friend.addBlock"] = _resp_friend_addBlock;
            respMap["friend.addFriend"] = _resp_friend_addFriend;
            respMap["friend.deleteBlock"] = _resp_friend_deleteBlock;
            respMap["friend.deleteFriend"] = _resp_friend_deleteFriend;
            respMap["friend.isBlockMailPlayer"] = _resp_friend_isBlockMailPlayer;
            respMap["furlough.cancelFurlought"] = _resp_furlough_cancelFurlought;
            respMap["furlough.isFurlought"] = _resp_furlough_isFurlought;
            respMap["gamblingranking.getGamblingRankingReward"] = _resp_gamblingranking_getGamblingRankingReward;
            respMap["gamblingranking.getGamblingRankingToday"] = _resp_gamblingranking_getGamblingRankingToday;
            respMap["gamblingranking.getGamblingRankingYesterday"] = _resp_gamblingranking_getGamblingRankingYesterday;
            respMap["gamemaster.addBuilding"] = _resp_gamemaster_addBuilding;
            respMap["gamemaster.addHero"] = _resp_gamemaster_addHero;
            respMap["gamemaster.addItems"] = _resp_gamemaster_addItems;
            respMap["gamemaster.removeBuilding"] = _resp_gamemaster_removeBuilding;
            respMap["gamemaster.removeHero"] = _resp_gamemaster_removeHero;
            respMap["gamemaster.removeItem"] = _resp_gamemaster_removeItem;
            respMap["gamemaster.setResources"] = _resp_gamemaster_setResources;
            respMap["gamemaster.setTechnology"] = _resp_gamemaster_setTechnology;
            respMap["hero.GenSaveRandomHero"] = _resp_hero_GenSaveRandomHero;
            respMap["hero.GetDisappearHeros"] = _resp_hero_GetDisappearHeros;
            respMap["hero.GetRandomHero"] = _resp_hero_GetRandomHero;
            respMap["hero.RecoverDisappearHero"] = _resp_hero_RecoverDisappearHero;
            respMap["hero.RetSetHeroAttri"] = _resp_hero_RetSetHeroAttri;
            respMap["hero.SetShowHeroId"] = _resp_hero_SetShowHeroId;
            respMap["hero.ShowPlayerHerosByUserName"] = _resp_hero_ShowPlayerHerosByUserName;
            respMap["hero.addPoint"] = _resp_hero_addPoint;
            respMap["hero.addPoint2"] = _resp_hero_addPoint2;
            respMap["hero.awardGold"] = _resp_hero_awardGold;
            respMap["hero.callBackHero"] = _resp_hero_callBackHero;
            respMap["hero.changeName"] = _resp_hero_changeName;
            respMap["hero.dischargeChief"] = _resp_hero_dischargeChief;
            respMap["hero.fireHero"] = _resp_hero_fireHero;
            respMap["hero.getFleeHeroList"] = _resp_hero_getFleeHeroList;
            respMap["hero.getHerosListFromTavern"] = _resp_hero_getHerosListFromTavern;
            respMap["hero.hireFacebookFriendHero"] = _resp_hero_hireFacebookFriendHero;
            respMap["hero.hireHero"] = _resp_hero_hireHero;
            respMap["hero.levelUp"] = _resp_hero_levelUp;
            respMap["hero.promoteToChief"] = _resp_hero_promoteToChief;
            respMap["hero.recruitFleeHero"] = _resp_hero_recruitFleeHero;
            respMap["hero.refreshHerosListFromTavern"] = _resp_hero_refreshHerosListFromTavern;
            respMap["hero.releaseHero"] = _resp_hero_releaseHero;
            respMap["hero.resetPoint"] = _resp_hero_resetPoint;
            respMap["hero.setHeroFacebookId"] = _resp_hero_setHeroFacebookId;
            respMap["hero.tryGetSeizedHero"] = _resp_hero_tryGetSeizedHero;
            respMap["hero.useItem"] = _resp_hero_useItem;
            respMap["interior.getResourceProduceData"] = _resp_interior_getResourceProduceData;
            respMap["interior.modifyCommenceRate"] = _resp_interior_modifyCommenceRate;
            respMap["interior.modifyTaxRate"] = _resp_interior_modifyTaxRate;
            respMap["interior.pacifyPeople"] = _resp_interior_pacifyPeople;
            respMap["interior.taxation"] = _resp_interior_taxation;
            respMap["mail.deleteMail"] = _resp_mail_deleteMail;
            respMap["mail.getAllTVMsg"] = _resp_mail_getAllTVMsg;
            respMap["mail.readMail"] = _resp_mail_readMail;
            respMap["mail.readOverMailList"] = _resp_mail_readOverMailList;
            respMap["mail.receiveMailList"] = _resp_mail_receiveMailList;
            respMap["mail.reportBug"] = _resp_mail_reportBug;
            respMap["mail.reportPlayer"] = _resp_mail_reportPlayer;
            respMap["mail.sendMail"] = _resp_mail_sendMail;
            respMap["npchero.getNpcHeroInfroByID"] = _resp_npchero_getNpcHeroInfroByID;
            respMap["npchero.getNpcHerosList"] = _resp_npchero_getNpcHerosList;
            respMap["npchero.getNpcHerosListByFilter"] = _resp_npchero_getNpcHerosListByFilter;
            respMap["npchero.getNpcHerosListByMoney"] = _resp_npchero_getNpcHerosListByMoney;
            respMap["quest.AllowRegister"] = _resp_quest_AllowRegister;
            respMap["quest.abandon"] = _resp_quest_abandon;
            respMap["quest.accept"] = _resp_quest_accept;
            respMap["quest.award"] = _resp_quest_award;
            respMap["quest.awardPacket"] = _resp_quest_awardPacket;
            respMap["quest.donate"] = _resp_quest_donate;
            respMap["quest.getAwardItems"] = _resp_quest_getAwardItems;
            respMap["quest.getEffortList"] = _resp_quest_getEffortList;
            respMap["quest.getEffortListByTargeTypeid"] = _resp_quest_getEffortListByTargeTypeid;
            respMap["quest.getQuestList"] = _resp_quest_getQuestList;
            respMap["quest.getQuestType"] = _resp_quest_getQuestType;
            respMap["rank.getAllianceRank"] = _resp_rank_getAllianceRank;
            respMap["rank.getCastleRank"] = _resp_rank_getCastleRank;
            respMap["rank.getHeroRank"] = _resp_rank_getHeroRank;
            respMap["rank.getPlayerRank"] = _resp_rank_getPlayerRank;
            respMap["rank.getTopVotesPlayer"] = _resp_rank_getTopVotesPlayer;
            respMap["rank.getVoteRank"] = _resp_rank_getVoteRank;
            respMap["report.deleteAllReports"] = _resp_report_deleteAllReports;
            respMap["report.deleteReport"] = _resp_report_deleteReport;
            respMap["report.markAsRead"] = _resp_report_markAsRead;
            respMap["report.readOverReport"] = _resp_report_readOverReport;
            respMap["report.receiveReportList"] = _resp_report_receiveReportList;
            respMap["report.shareReport"] = _resp_report_shareReport;
            respMap["shop.Gem_Smelting"] = _resp_shop_Gem_Smelting;
            respMap["shop.buy"] = _resp_shop_buy;
            respMap["shop.buyResource"] = _resp_shop_buyResource;
            respMap["shop.getBuyResourceInfo"] = _resp_shop_getBuyResourceInfo;
            respMap["shop.useAngelItem"] = _resp_shop_useAngelItem;
            respMap["shop.useCastleGoods"] = _resp_shop_useCastleGoods;
            respMap["shop.useDevilItem"] = _resp_shop_useDevilItem;
            respMap["shop.useGoods"] = _resp_shop_useGoods;
            respMap["shop.useTrickItem"] = _resp_shop_useTrickItem;
            respMap["stratagem.useStratagem"] = _resp_stratagem_useStratagem;
            respMap["tech.cancelResearch"] = _resp_tech_cancelResearch;
            respMap["tech.getCoinsNeed"] = _resp_tech_getCoinsNeed;
            respMap["tech.getResearchList"] = _resp_tech_getResearchList;
            respMap["tech.research"] = _resp_tech_research;
            respMap["tech.speedUpResearch"] = _resp_tech_speedUpResearch;
            respMap["trade.cancelTrade"] = _resp_trade_cancelTrade;
            respMap["trade.getMyTradeList"] = _resp_trade_getMyTradeList;
            respMap["trade.getTransingTradeList"] = _resp_trade_getTransingTradeList;
            respMap["trade.newTrade"] = _resp_trade_newTrade;
            respMap["trade.searchTrades"] = _resp_trade_searchTrades;
            respMap["trade.speedUpTrans"] = _resp_trade_speedUpTrans;
            respMap["troop.accTroopProduce"] = _resp_troop_accTroopProduce;
            respMap["troop.cancelTroopProduce"] = _resp_troop_cancelTroopProduce;
            respMap["troop.checkIdleBarrack"] = _resp_troop_checkIdleBarrack;
            respMap["troop.disbandTroop"] = _resp_troop_disbandTroop;
            respMap["troop.getProduceQueue"] = _resp_troop_getProduceQueue;
            respMap["troop.getTroopProduceList"] = _resp_troop_getTroopProduceList;
            respMap["troop.produceTroop"] = _resp_troop_produceTroop;
            respMap["truce.cancelDreamTruce"] = _resp_truce_cancelDreamTruce;
            respMap["truce.changeDreamTruceTime"] = _resp_truce_changeDreamTruceTime;
            respMap["truce.setDreamTruce"] = _resp_truce_setDreamTruce;
            respMap["visit.deleteComment"] = _resp_visit_deleteComment;
            respMap["visit.getAllVisitorComments"] = _resp_visit_getAllVisitorComments;
            respMap["visit.getHelpedPlayers"] = _resp_visit_getHelpedPlayers;
            respMap["visit.getVisitorComments"] = _resp_visit_getVisitorComments;
            respMap["visit.helpIncreaseProduction"] = _resp_visit_helpIncreaseProduction;
            respMap["visit.markCommentAsRead"] = _resp_visit_markCommentAsRead;
            respMap["visit.visitorComment"] = _resp_visit_visitorComment;
            respMap["vote.voteToPlayerById"] = _resp_vote_voteToPlayerById;
            respMap["vote.voteToPlayerByName"] = _resp_vote_voteToPlayerByName;
            respMap["server.AcademyResearchUpdate"] = _resp_AcademyResearchUpdate;
            respMap["server.AllianceChatMsg"] = _resp_AllianceChatMsg;
            respMap["server.BuildComplate"] = _resp_BuildComplate;
            respMap["server.BuildingQueueUpdate"] = _resp_BuildingQueueUpdate;
            respMap["server.CastleBuffUpdate"] = _resp_CastleBuffUpdate;
            respMap["server.CastleFieldUpdate"] = _resp_CastleFieldUpdate;
            respMap["server.CastleUpdate"] = _resp_CastleUpdate;
            respMap["server.CbUpdate"] = _resp_CbUpdate;
            respMap["server.CelebRankCompleteTipResponse"] = _resp_CelebRankCompleteTipResponse;
            respMap["server.ChangeName"] = _resp_ChangeName;
            respMap["server.ChannelChatMsg"] = _resp_ChannelChatMsg;
            respMap["server.ColonyUpdate"] = _resp_ColonyUpdate;
            respMap["server.ConnectionLost"] = _resp_ConnectionLost;
            respMap["server.DeclaredWarStatusChange"] = _resp_DeclaredWarStatusChange;
            respMap["server.DeclaredWarUpdate"] = _resp_DeclaredWarUpdate;
            respMap["server.EnemyArmysUpdate"] = _resp_EnemyArmysUpdate;
            respMap["server.EquipmentResearchCompleteUpdate"] = _resp_EquipmentResearchCompleteUpdate;
            respMap["server.FleeTroopUpdate"] = _resp_FleeTroopUpdate;
            respMap["server.FortificationsUpdate"] = _resp_FortificationsUpdate;
            respMap["server.FriendArmysUpdate"] = _resp_FriendArmysUpdate;
            respMap["server.GetPlayerVoteInfro"] = _resp_GetPlayerVoteInfro;
            respMap["server.GetTopVotesPlayer"] = _resp_GetTopVotesPlayer;
            respMap["server.HeroUpdate"] = _resp_HeroUpdate;
            respMap["server.InjuredTroopUpdate"] = _resp_InjuredTroopUpdate;
            respMap["server.ItemBuff"] = _resp_ItemBuff;
            respMap["server.ItemUpdate"] = _resp_ItemUpdate;
            respMap["server.KickedOut"] = _resp_KickedOut;
            respMap["server.LoginResponse"] = _resp_LoginResponse;
            respMap["server.MercenaryUpdate"] = _resp_MercenaryUpdate;
            respMap["server.NewFinishedQuest"] = _resp_NewFinishedQuest;
            respMap["server.NewMail"] = _resp_NewMail;
            respMap["server.NewReport"] = _resp_NewReport;
            respMap["server.PackageList"] = _resp_PackageList;
            respMap["server.PlayerBuffUpdate"] = _resp_PlayerBuffUpdate;
            respMap["server.PlayerInfoUpdate"] = _resp_PlayerInfoUpdate;
            respMap["server.PrivateChatMessage"] = _resp_PrivateChatMessage;
            respMap["server.QuestCompleteTipResponse"] = _resp_QuestCompleteTipResponse;
            respMap["server.QuestFinished"] = _resp_QuestFinished;
            respMap["server.RegisterResponse"] = _resp_RegisterResponse;
            respMap["server.ResearchCompleteUpdate"] = _resp_ResearchCompleteUpdate;
            respMap["server.ResourceUpdate"] = _resp_ResourceUpdate;
            respMap["server.SecurityCodeRemovedEvent"] = _resp_SecurityCodeRemovedEvent;
            respMap["server.SelfArmysUpdate"] = _resp_SelfArmysUpdate;
            respMap["server.StrategyBuff"] = _resp_StrategyBuff;
            respMap["server.SystemInfoMsg"] = _resp_SystemInfoMsg;
            respMap["server.TradesUpdate"] = _resp_TradesUpdate;
            respMap["server.TransingTradeUpdate"] = _resp_TransingTradeUpdate;
            respMap["server.TroopUpdate"] = _resp_TroopUpdate;
            respMap["server.UnregisteredCreatePlayerResponse"] = _resp_UnregisteredCreatePlayerResponse;
            respMap["server.VisitorHelpEvent"] = _resp_VisitorHelpEvent;
            respMap["server.WorldChatMsg"] = _resp_WorldChatMsg;
        }

        public static function getInstance():ResponseDispatcher
        {
            return (instance);
        }


        private function _resp_army_cureInjuredTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.cureInjuredTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._cureInjuredTroop_callback != null)
            {
                actionFactory.getArmyCommands()._cureInjuredTroop_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._cureInjuredTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_getProduceQueue(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ProduceQueueResponse("troop.getProduceQueue", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTroopCommands()._getProduceQueue_callback != null)
            {
                actionFactory.getTroopCommands()._getProduceQueue_callback.apply(this, [_local_2]);
                actionFactory.getTroopCommands()._getProduceQueue_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ChangeName(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ChangeName("server.ChangeName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onChangeName != null)
            {
                onChangeName.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_common_getPlayerDeclaredWarStatus(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetDeclaredWarResponse("common.getPlayerDeclaredWarStatus", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getPlayerDeclaredWarStatus_callback != null)
            {
                actionFactory.getCommonCommands()._getPlayerDeclaredWarStatus_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getPlayerDeclaredWarStatus_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_addToFavorites(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.addToFavorites", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._addToFavorites_callback != null)
            {
                actionFactory.getCommonCommands()._addToFavorites_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._addToFavorites_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ColonyUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ColonyUpdate("server.ColonyUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onColonyUpdate != null)
            {
                onColonyUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_shop_useAngelItem(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("shop.useAngelItem", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._useAngelItem_callback != null)
            {
                actionFactory.getShopCommands()._useAngelItem_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._useAngelItem_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_StrategyBuff(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new StrategyBuff("server.StrategyBuff", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onStrategyBuff != null)
            {
                onStrategyBuff.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_hero_hireHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.hireHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._hireHero_callback != null)
            {
                actionFactory.getHeroCommand()._hireHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._hireHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceMembers(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceMembersResponse("alliance.getAllianceMembers", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceCommands()._getAllianceMembers_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceMembers_callback.apply(this, [_local_2]);
                actionFactory.getAllianceCommands()._getAllianceMembers_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ResourceUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ResourceUpdate("server.ResourceUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onResourceUpdate != null)
            {
                onResourceUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_alliance_getAllianceFriendshipList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceFriendshipResponse("alliance.getAllianceFriendshipList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_addPoint2(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.addPoint2", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._addPoint2_callback != null)
            {
                actionFactory.getHeroCommand()._addPoint2_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._addPoint2_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getFleeTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.getFleeTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._getFleeTroop_callback != null)
            {
                actionFactory.getArmyCommands()._getFleeTroop_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._getFleeTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_changeName(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.changeName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._changeName_callback != null)
            {
                actionFactory.getHeroCommand()._changeName_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._changeName_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_cancelFortificationProduce(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("fortifications.cancelFortificationProduce", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback != null)
            {
                actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback.apply(this, [_local_2]);
                actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_channelChat(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ChatResponse("common.channelChat", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._channelChat_callback != null)
            {
                actionFactory.getCommonCommands()._channelChat_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._channelChat_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_report_readOverReport(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ReportResponse("report.readOverReport", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getReportCommands()._readOverReport_callback != null)
            {
                actionFactory.getReportCommands()._readOverReport_callback.apply(this, [_local_2]);
                actionFactory.getReportCommands()._readOverReport_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_furlough_isFurlought(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FurloughResponse("furlough.isFurlought", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFurloughCommands()._isFurlought_callback != null)
            {
                actionFactory.getFurloughCommands()._isFurlought_callback.apply(this, [_local_2]);
                actionFactory.getFurloughCommands()._isFurlought_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ChannelChatMsg(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ChannelChatMsg("server.ChannelChatMsg", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onChannelChatMsg != null)
            {
                onChannelChatMsg.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_army_recruitFleeTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.recruitFleeTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._recruitFleeTroop_callback != null)
            {
                actionFactory.getArmyCommands()._recruitFleeTroop_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._recruitFleeTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_speedUpAbandonColony(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("colony.speedUpAbandonColony", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._speedUpAbandonColony_callback != null)
            {
                actionFactory.getColonyCommands()._speedUpAbandonColony_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._speedUpAbandonColony_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPlayerInfoByName(_arg_1:Object):void
        {
            var _local_2:BaseBean = new PlayerInfoResponse("common.getPlayerInfoByName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getPlayerInfoByName_callback != null)
            {
                actionFactory.getCommonCommands()._getPlayerInfoByName_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getPlayerInfoByName_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyArmy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CapitalCommandResponse("capital.levyArmy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCapitalCommands()._levyArmy_callback != null)
            {
                actionFactory.getCapitalCommands()._levyArmy_callback.apply(this, [_local_2]);
                actionFactory.getCapitalCommands()._levyArmy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_giveupCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.giveupCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._giveupCastle_callback != null)
            {
                actionFactory.getCityCommands()._giveupCastle_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._giveupCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_taxation(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("interior.taxation", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getInteriorCommands()._taxation_callback != null)
            {
                actionFactory.getInteriorCommands()._taxation_callback.apply(this, [_local_2]);
                actionFactory.getInteriorCommands()._taxation_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_InjuredTroopUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new InjuredTroopUpdate("server.InjuredTroopUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onInjuredTroopUpdate != null)
            {
                onInjuredTroopUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_equipmenttech_cancelResearch(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("equipmenttech.cancelResearch", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmenttechCommands()._cancelResearch_callback != null)
            {
                actionFactory.getEquipmenttechCommands()._cancelResearch_callback.apply(this, [_local_2]);
                actionFactory.getEquipmenttechCommands()._cancelResearch_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_newArmy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.newArmy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._newArmy_callback != null)
            {
                actionFactory.getArmyCommands()._newArmy_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._newArmy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_ShowPlayerHerosByUserName(_arg_1:Object):void
        {
            var _local_2:BaseBean = new HeroListResponse("hero.ShowPlayerHerosByUserName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._ShowPlayerHerosByUserName_callback != null)
            {
                actionFactory.getHeroCommand()._ShowPlayerHerosByUserName_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._ShowPlayerHerosByUserName_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_EnhancedStarByGemStone(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GemstoneRespone("equipment.EnhancedStarByGemStone", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmentCommands()._EnhancedStarByGemStone_callback != null)
            {
                actionFactory.getEquipmentCommands()._EnhancedStarByGemStone_callback.apply(this, [_local_2]);
                actionFactory.getEquipmentCommands()._EnhancedStarByGemStone_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_speedUpResearch(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ResearchResponse("equipmenttech.speedUpResearch", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmenttechCommands()._speedUpResearch_callback != null)
            {
                actionFactory.getEquipmenttechCommands()._speedUpResearch_callback.apply(this, [_local_2]);
                actionFactory.getEquipmenttechCommands()._speedUpResearch_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_report_deleteReport(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("report.deleteReport", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getReportCommands()._deleteReport_callback != null)
            {
                actionFactory.getReportCommands()._deleteReport_callback.apply(this, [_local_2]);
                actionFactory.getReportCommands()._deleteReport_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_SelfArmysUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new SelfArmysUpdate("server.SelfArmysUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onSelfArmysUpdate != null)
            {
                onSelfArmysUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_vote_voteToPlayerById(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CommandResponse("vote.voteToPlayerById", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVoteToPlayerCommands()._voteToPlayerById_callback != null)
            {
                actionFactory.getVoteToPlayerCommands()._voteToPlayerById_callback.apply(this, [_local_2]);
                actionFactory.getVoteToPlayerCommands()._voteToPlayerById_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeSecurityCode(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.changeSecurityCode", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._changeSecurityCode_callback != null)
            {
                actionFactory.getSecurityCommands()._changeSecurityCode_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._changeSecurityCode_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_getHelpedPlayers(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetHelpedPlayersResponse("visit.getHelpedPlayers", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVisitCommands()._getHelpedPlayers_callback != null)
            {
                actionFactory.getVisitCommands()._getHelpedPlayers_callback.apply(this, [_local_2]);
                actionFactory.getVisitCommands()._getHelpedPlayers_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_getResourceProduceData(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ResourceProduceDataResponse("interior.getResourceProduceData", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getInteriorCommands()._getResourceProduceData_callback != null)
            {
                actionFactory.getInteriorCommands()._getResourceProduceData_callback.apply(this, [_local_2]);
                actionFactory.getInteriorCommands()._getResourceProduceData_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_addUsertoAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.addUsertoAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_furlough_cancelFurlought(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FurloughResponse("furlough.cancelFurlought", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFurloughCommands()._cancelFurlought_callback != null)
            {
                actionFactory.getFurloughCommands()._cancelFurlought_callback.apply(this, [_local_2]);
                actionFactory.getFurloughCommands()._cancelFurlought_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHerosListByMoney(_arg_1:Object):void
        {
            var _local_2:BaseBean = new NpcHeroListResponse("npchero.getNpcHerosListByMoney", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getNpcHeroCommand()._getNpcHerosListByMoney_callback != null)
            {
                actionFactory.getNpcHeroCommand()._getNpcHerosListByMoney_callback.apply(this, [_local_2]);
                actionFactory.getNpcHeroCommand()._getNpcHerosListByMoney_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_getMyTradeList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new TradeListResponse("trade.getMyTradeList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTradeCommands()._getMyTradeList_callback != null)
            {
                actionFactory.getTradeCommands()._getMyTradeList_callback.apply(this, [_local_2]);
                actionFactory.getTradeCommands()._getMyTradeList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_cancelTroopProduce(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("troop.cancelTroopProduce", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTroopCommands()._cancelTroopProduce_callback != null)
            {
                actionFactory.getTroopCommands()._cancelTroopProduce_callback.apply(this, [_local_2]);
                actionFactory.getTroopCommands()._cancelTroopProduce_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_QuestCompleteTipResponse(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new QuestCompleteTipResponse("server.QuestCompleteTipResponse", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onQuestCompleteTipResponse != null)
            {
                onQuestCompleteTipResponse.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_gamemaster_setTechnology(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("gamemaster.setTechnology", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._setTechnology_callback != null)
            {
                actionFactory.getModifyCommands()._setTechnology_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._setTechnology_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_getCoinsNeed(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CoinsNeedResponse("tech.getCoinsNeed", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTechCommand()._getCoinsNeed_callback != null)
            {
                actionFactory.getTechCommand()._getCoinsNeed_callback.apply(this, [_local_2]);
                actionFactory.getTechCommand()._getCoinsNeed_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useDevilItem(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("shop.useDevilItem", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._useDevilItem_callback != null)
            {
                actionFactory.getShopCommands()._useDevilItem_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._useDevilItem_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_accTroopProduce(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("fortifications.accTroopProduce", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFortificationsCommands()._accTroopProduce_callback != null)
            {
                actionFactory.getFortificationsCommands()._accTroopProduce_callback.apply(this, [_local_2]);
                actionFactory.getFortificationsCommands()._accTroopProduce_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        public function dispatch(_arg_1:String, _arg_2:Object):void
        {
            var _local_3:Function;
            _local_3 = (this.respMap[_arg_1] as Function);
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

        private function _resp_hero_addPoint(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.addPoint", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._addPoint_callback != null)
            {
                actionFactory.getHeroCommand()._addPoint_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._addPoint_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamblingranking_getGamblingRankingToday(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GamblingRankingRespone("gamblingranking.getGamblingRankingToday", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getGamblingRankingCommands()._getGamblingRankingToday_callback != null)
            {
                actionFactory.getGamblingRankingCommands()._getGamblingRankingToday_callback.apply(this, [_local_2]);
                actionFactory.getGamblingRankingCommands()._getGamblingRankingToday_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_abandon(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("quest.abandon", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._abandon_callback != null)
            {
                actionFactory.getQuestCommands()._abandon_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._abandon_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_agreeComeinAllianceList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceUserAddResponse("alliance.agreeComeinAllianceList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_GenSaveRandomHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.GenSaveRandomHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._GenSaveRandomHero_callback != null)
            {
                actionFactory.getHeroCommand()._GenSaveRandomHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._GenSaveRandomHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_deleteFriend(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FriendResponse("friend.deleteFriend", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFriendCommands()._deleteFriend_callback != null)
            {
                actionFactory.getFriendCommands()._deleteFriend_callback.apply(this, [_local_2]);
                actionFactory.getFriendCommands()._deleteFriend_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_accept(_arg_1:Object):void
        {
            var _local_2:BaseBean = new QuestListResponse("quest.accept", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._accept_callback != null)
            {
                actionFactory.getQuestCommands()._accept_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._accept_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_AcademyResearchUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new AcademyResearchUpdate("server.AcademyResearchUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onAcademyResearchUpdate != null)
            {
                onAcademyResearchUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_common_getProtectOption(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetProtectOptionResponse("common.getProtectOption", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._getProtectOption_callback != null)
            {
                actionFactory.getSecurityCommands()._getProtectOption_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._getProtectOption_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setTroopConfig(_arg_1:Object):void
        {
            var _local_2:BaseBean = new TroopConfigResponse("common.setTroopConfig", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._setTroopConfig_callback != null)
            {
                actionFactory.getCommonCommands()._setTroopConfig_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._setTroopConfig_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_mapInfoSimple(_arg_1:Object):void
        {
            var _local_2:BaseBean = new MapInfoSimpleResponse("common.mapInfoSimple", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._mapInfoSimple_callback != null)
            {
                actionFactory.getCommonCommands()._mapInfoSimple_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._mapInfoSimple_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_VisitorHelpEvent(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new VisitorHelpEvent("server.VisitorHelpEvent", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onVisitorHelpEvent != null)
            {
                onVisitorHelpEvent.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_colony_levyPopulation(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonyLevyeRespone("colony.levyPopulation", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._levyPopulation_callback != null)
            {
                actionFactory.getColonyCommands()._levyPopulation_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._levyPopulation_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_AllowRegister(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("quest.AllowRegister", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._AllowRegister_callback != null)
            {
                actionFactory.getQuestCommands()._AllowRegister_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._AllowRegister_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_helpIncreaseProduction(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CommandResponse("visit.helpIncreaseProduction", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVisitCommands()._helpIncreaseProduction_callback != null)
            {
                actionFactory.getVisitCommands()._helpIncreaseProduction_callback.apply(this, [_local_2]);
                actionFactory.getVisitCommands()._helpIncreaseProduction_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_modifyCastleName(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.modifyCastleName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._modifyCastleName_callback != null)
            {
                actionFactory.getCityCommands()._modifyCastleName_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._modifyCastleName_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_privateChat(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ChatResponse("common.privateChat", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._privateChat_callback != null)
            {
                actionFactory.getCommonCommands()._privateChat_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._privateChat_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_userWantInAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.userWantInAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ConnectionLost(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ConnectionLost("server.ConnectionLost", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onConnectionLost != null)
            {
                onConnectionLost.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_common_setEovnyMember(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setEovnyMember", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._setEovnyMember_callback != null)
            {
                actionFactory.getCommonCommands()._setEovnyMember_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._setEovnyMember_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_markCommentAsRead(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CommandResponse("visit.markCommentAsRead", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVisitCommands()._markCommentAsRead_callback != null)
            {
                actionFactory.getVisitCommands()._markCommentAsRead_callback.apply(this, [_local_2]);
                actionFactory.getVisitCommands()._markCommentAsRead_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setReceiveIncomingAttack(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setReceiveIncomingAttack", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._setReceiveIncomingAttack_callback != null)
            {
                actionFactory.getCommonCommands()._setReceiveIncomingAttack_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._setReceiveIncomingAttack_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_addCommissionQuestArmy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("commission.addCommissionQuestArmy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._addCommissionQuestArmy_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._addCommissionQuestArmy_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._addCommissionQuestArmy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_truce_cancelDreamTruce(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("truce.cancelDreamTruce", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTruceCommands()._cancelDreamTruce_callback != null)
            {
                actionFactory.getTruceCommands()._cancelDreamTruce_callback.apply(this, [_local_2]);
                actionFactory.getTruceCommands()._cancelDreamTruce_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_RetSetHeroAttri(_arg_1:Object):void
        {
            var _local_2:BaseBean = new RandomHeroResponse("hero.RetSetHeroAttri", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._RetSetHeroAttri_callback != null)
            {
                actionFactory.getHeroCommand()._RetSetHeroAttri_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._RetSetHeroAttri_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_setStopWarState(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.setStopWarState", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._setStopWarState_callback != null)
            {
                actionFactory.getCityCommands()._setStopWarState_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._setStopWarState_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_isHasAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new HasAllianceResponse("alliance.isHasAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._isHasAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._isHasAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._isHasAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getDestructBuildBean(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AvailableBuilingListResponse("castle.getDestructBuildBean", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._getDestructBuildBean_callback != null)
            {
                actionFactory.getCastleCommands()._getDestructBuildBean_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._getDestructBuildBean_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_setDeployTroops(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("colony.setDeployTroops", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._setDeployTroops_callback != null)
            {
                actionFactory.getColonyCommands()._setDeployTroops_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._setDeployTroops_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getItemDefXml(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetItemDefResponse("common.getItemDefXml", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getItemDefXml_callback != null)
            {
                actionFactory.getCommonCommands()._getItemDefXml_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getItemDefXml_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_report_shareReport(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ShareReportResponse("report.shareReport", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getReportCommands()._shareReport_callback != null)
            {
                actionFactory.getReportCommands()._shareReport_callback.apply(this, [_local_2]);
                actionFactory.getReportCommands()._shareReport_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_field_getOtherFieldInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new OtherFieldInfoResponse("field.getOtherFieldInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFieldCommand()._getOtherFieldInfo_callback != null)
            {
                actionFactory.getFieldCommand()._getOtherFieldInfo_callback.apply(this, [_local_2]);
                actionFactory.getFieldCommand()._getOtherFieldInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_setAllianceFriendship(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.setAllianceFriendship", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_report_deleteAllReports(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("report.deleteAllReports", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getReportCommands()._deleteAllReports_callback != null)
            {
                actionFactory.getReportCommands()._deleteAllReports_callback.apply(this, [_local_2]);
                actionFactory.getReportCommands()._deleteAllReports_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_setPowerForUserByAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.setPowerForUserByAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_step(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.step", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._step_callback != null)
            {
                actionFactory.getCommonCommands()._step_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._step_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_visitorComment(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CommandResponse("visit.visitorComment", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVisitCommands()._visitorComment_callback != null)
            {
                actionFactory.getVisitCommands()._visitorComment_callback.apply(this, [_local_2]);
                actionFactory.getVisitCommands()._visitorComment_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_addBuilding(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("gamemaster.addBuilding", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._addBuilding_callback != null)
            {
                actionFactory.getModifyCommands()._addBuilding_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._addBuilding_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_getAllTVMsg(_arg_1:Object):void
        {
            var _local_2:BaseBean = new TVResponse("mail.getAllTVMsg", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._getAllTVMsg_callback != null)
            {
                actionFactory.getMailCommands()._getAllTVMsg_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._getAllTVMsg_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_cancelTrade(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("trade.cancelTrade", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTradeCommands()._cancelTrade_callback != null)
            {
                actionFactory.getTradeCommands()._cancelTrade_callback.apply(this, [_local_2]);
                actionFactory.getTradeCommands()._cancelTrade_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_AllianceChatMsg(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new AllianceChatMsg("server.AllianceChatMsg", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onAllianceChatMsg != null)
            {
                onAllianceChatMsg.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_equipment_TakeOffAllEquipmenttech(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("equipment.TakeOffAllEquipmenttech", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmentCommands()._TakeOffAllEquipmenttech_callback != null)
            {
                actionFactory.getEquipmentCommands()._TakeOffAllEquipmenttech_callback.apply(this, [_local_2]);
                actionFactory.getEquipmentCommands()._TakeOffAllEquipmenttech_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_getStoreList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new StoreListResponse("city.getStoreList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._getStoreList_callback != null)
            {
                actionFactory.getCityCommands()._getStoreList_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._getStoreList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_getResearchList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AvailableResearchListResponse("tech.getResearchList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTechCommand()._getResearchList_callback != null)
            {
                actionFactory.getTechCommand()._getResearchList_callback.apply(this, [_local_2]);
                actionFactory.getTechCommand()._getResearchList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_upgradeBuilding(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.upgradeBuilding", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._upgradeBuilding_callback != null)
            {
                actionFactory.getCastleCommands()._upgradeBuilding_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._upgradeBuilding_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_newBuilding(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.newBuilding", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._newBuilding_callback != null)
            {
                actionFactory.getCastleCommands()._newBuilding_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._newBuilding_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setEventDone(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setEventDone", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._setEventDone_callback != null)
            {
                actionFactory.getCommonCommands()._setEventDone_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._setEventDone_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_Gem_Smelting(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("shop.Gem_Smelting", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._Gem_Smelting_callback != null)
            {
                actionFactory.getShopCommands()._Gem_Smelting_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._Gem_Smelting_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_destructBuilding(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.destructBuilding", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._destructBuilding_callback != null)
            {
                actionFactory.getCastleCommands()._destructBuilding_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._destructBuilding_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_reduceArmaments(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CapitalCommandResponse("capital.reduceArmaments", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCapitalCommands()._reduceArmaments_callback != null)
            {
                actionFactory.getCapitalCommands()._reduceArmaments_callback.apply(this, [_local_2]);
                actionFactory.getCapitalCommands()._reduceArmaments_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_GetRandomHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new RandomHeroResponse("hero.GetRandomHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._GetRandomHero_callback != null)
            {
                actionFactory.getHeroCommand()._GetRandomHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._GetRandomHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_award(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("quest.award", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._award_callback != null)
            {
                actionFactory.getQuestCommands()._award_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._award_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_vote_voteToPlayerByName(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CommandResponse("vote.voteToPlayerByName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVoteToPlayerCommands()._voteToPlayerByName_callback != null)
            {
                actionFactory.getVoteToPlayerCommands()._voteToPlayerByName_callback.apply(this, [_local_2]);
                actionFactory.getVoteToPlayerCommands()._voteToPlayerByName_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_demolishBuildingQueue(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.demolishBuildingQueue", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._demolishBuildingQueue_callback != null)
            {
                actionFactory.getCastleCommands()._demolishBuildingQueue_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._demolishBuildingQueue_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_celeb_findAllianceByPrestige(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CelebResponse("celeb.findAllianceByPrestige", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCelebRankCommands()._findAllianceByPrestige_callback != null)
            {
                actionFactory.getCelebRankCommands()._findAllianceByPrestige_callback.apply(this, [_local_2]);
                actionFactory.getCelebRankCommands()._findAllianceByPrestige_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_getFortificationsProduceList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FortProduceListResponse("fortifications.getFortificationsProduceList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback != null)
            {
                actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback.apply(this, [_local_2]);
                actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getCoinsNeed(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CoinsNeedResponse("castle.getCoinsNeed", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._getCoinsNeed_callback != null)
            {
                actionFactory.getCastleCommands()._getCoinsNeed_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._getCoinsNeed_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_disbandFleeTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.disbandFleeTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._disbandFleeTroop_callback != null)
            {
                actionFactory.getArmyCommands()._disbandFleeTroop_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._disbandFleeTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_addBlock(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FriendResponse("friend.addBlock", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFriendCommands()._addBlock_callback != null)
            {
                actionFactory.getFriendCommands()._addBlock_callback.apply(this, [_local_2]);
                actionFactory.getFriendCommands()._addBlock_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_addHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CreateHeroResponse("gamemaster.addHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._addHero_callback != null)
            {
                actionFactory.getModifyCommands()._addHero_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._addHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getMyAcceptedCommissionQuest(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommissionQuestRespone("commission.getMyAcceptedCommissionQuest", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._getMyAcceptedCommissionQuest_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._getMyAcceptedCommissionQuest_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._getMyAcceptedCommissionQuest_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_EquipmentResearchCompleteUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new EquipmentResearchCompleteUpdate("server.EquipmentResearchCompleteUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onEquipmentResearchCompleteUpdate != null)
            {
                onEquipmentResearchCompleteUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_rank_getPlayerRank(_arg_1:Object):void
        {
            var _local_2:BaseBean = new RankPlayerResponse("rank.getPlayerRank", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getRankCommands()._getPlayerRank_callback != null)
            {
                actionFactory.getRankCommands()._getPlayerRank_callback.apply(this, [_local_2]);
                actionFactory.getRankCommands()._getPlayerRank_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_releaseHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.releaseHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._releaseHero_callback != null)
            {
                actionFactory.getHeroCommand()._releaseHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._releaseHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_UpdateCastleResources(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AvailableBuilingListResponse("castle.UpdateCastleResources", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._UpdateCastleResources_callback != null)
            {
                actionFactory.getCastleCommands()._UpdateCastleResources_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._UpdateCastleResources_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_field_getCastleFieldInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CastleFieldInfoResponse("field.getCastleFieldInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFieldCommand()._getCastleFieldInfo_callback != null)
            {
                actionFactory.getFieldCommand()._getCastleFieldInfo_callback.apply(this, [_local_2]);
                actionFactory.getFieldCommand()._getCastleFieldInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getMilitarySituationList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new MilitarySituationListResponse("alliance.getMilitarySituationList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceCommands()._getMilitarySituationList_callback != null)
            {
                actionFactory.getAllianceCommands()._getMilitarySituationList_callback.apply(this, [_local_2]);
                actionFactory.getAllianceCommands()._getMilitarySituationList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceListResponse("alliance.getAllianceList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceCommands()._getAllianceList_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceList_callback.apply(this, [_local_2]);
                actionFactory.getAllianceCommands()._getAllianceList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getEffortListByTargeTypeid(_arg_1:Object):void
        {
            var _local_2:BaseBean = new QuestListResponse("quest.getEffortListByTargeTypeid", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._getEffortListByTargeTypeid_callback != null)
            {
                actionFactory.getQuestCommands()._getEffortListByTargeTypeid_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._getEffortListByTargeTypeid_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getBuildingQueueCoinsNeed(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CoinsNeedResponse("castle.getBuildingQueueCoinsNeed", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._getBuildingQueueCoinsNeed_callback != null)
            {
                actionFactory.getCastleCommands()._getBuildingQueueCoinsNeed_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._getBuildingQueueCoinsNeed_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_celeb_findPlayerByTitle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CelebResponse("celeb.findPlayerByTitle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCelebRankCommands()._findPlayerByTitle_callback != null)
            {
                actionFactory.getCelebRankCommands()._findPlayerByTitle_callback.apply(this, [_local_2]);
                actionFactory.getCelebRankCommands()._findPlayerByTitle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceInfoResponse("alliance.getAllianceInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceCommands()._getAllianceInfo_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceInfo_callback.apply(this, [_local_2]);
                actionFactory.getAllianceCommands()._getAllianceInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_levyTaxes(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonyLevyeRespone("colony.levyTaxes", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._levyTaxes_callback != null)
            {
                actionFactory.getColonyCommands()._levyTaxes_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._levyTaxes_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_delUniteServerPeaceStatus(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.delUniteServerPeaceStatus", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._delUniteServerPeaceStatus_callback != null)
            {
                actionFactory.getCommonCommands()._delUniteServerPeaceStatus_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._delUniteServerPeaceStatus_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_cancleBuildCommand(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.cancleBuildCommand", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._cancleBuildCommand_callback != null)
            {
                actionFactory.getCastleCommands()._cancleBuildCommand_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._cancleBuildCommand_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_CastleUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CastleUpdate("server.CastleUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onCastleUpdate != null)
            {
                onCastleUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_city_modifyUserName(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.modifyUserName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._modifyUserName_callback != null)
            {
                actionFactory.getCityCommands()._modifyUserName_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._modifyUserName_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setUnlockOption(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setUnlockOption", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._setUnlockOption_callback != null)
            {
                actionFactory.getSecurityCommands()._setUnlockOption_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._setUnlockOption_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_research(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ResearchResponse("tech.research", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTechCommand()._research_callback != null)
            {
                actionFactory.getTechCommand()._research_callback.apply(this, [_local_2]);
                actionFactory.getTechCommand()._research_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeName(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ChangeNameResponse("common.changeName", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._changeName_callback != null)
            {
                actionFactory.getCommonCommands()._changeName_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._changeName_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_getBuyResourceInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new BuyResourceInfoResponse("shop.getBuyResourceInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._getBuyResourceInfo_callback != null)
            {
                actionFactory.getShopCommands()._getBuyResourceInfo_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._getBuyResourceInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useGoods(_arg_1:Object):void
        {
            var _local_2:BaseBean = new UseItemResultResponse("shop.useGoods", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._useGoods_callback != null)
            {
                actionFactory.getShopCommands()._useGoods_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._useGoods_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_recruitFleeHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.recruitFleeHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._recruitFleeHero_callback != null)
            {
                actionFactory.getHeroCommand()._recruitFleeHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._recruitFleeHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_reportBug(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("mail.reportBug", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._reportBug_callback != null)
            {
                actionFactory.getMailCommands()._reportBug_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._reportBug_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_FriendArmysUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new FriendArmysUpdate("server.FriendArmysUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onFriendArmysUpdate != null)
            {
                onFriendArmysUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_hero_refreshHerosListFromTavern(_arg_1:Object):void
        {
            var _local_2:BaseBean = new HeroListResponse("hero.refreshHerosListFromTavern", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback != null)
            {
                actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_RegisterResponse(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new RegisterResponse("server.RegisterResponse", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onRegisterResponse != null)
            {
                onRegisterResponse.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_trade_newTrade(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("trade.newTrade", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTradeCommands()._newTrade_callback != null)
            {
                actionFactory.getTradeCommands()._newTrade_callback.apply(this, [_local_2]);
                actionFactory.getTradeCommands()._newTrade_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_mapCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new MapCastleResponse("common.mapCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._mapCastle_callback != null)
            {
                actionFactory.getCommonCommands()._mapCastle_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._mapCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getVoteRank(_arg_1:Object):void
        {
            var _local_2:BaseBean = new RankPlayerVotesResponse("rank.getVoteRank", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getRankCommands()._getVoteRank_callback != null)
            {
                actionFactory.getRankCommands()._getVoteRank_callback.apply(this, [_local_2]);
                actionFactory.getRankCommands()._getVoteRank_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_PrivateChatMessage(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new PrivateChatMessage("server.PrivateChatMessage", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onPrivateChatMessage != null)
            {
                onPrivateChatMessage.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_MercenaryUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new MercenaryUpdate("server.MercenaryUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onMercenaryUpdate != null)
            {
                onMercenaryUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_city_modifyStorePercent(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.modifyStorePercent", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._modifyStorePercent_callback != null)
            {
                actionFactory.getCityCommands()._modifyStorePercent_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._modifyStorePercent_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_SecurityCodeRemovedEvent(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new SecurityCodeRemovedEvent("server.SecurityCodeRemovedEvent", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onSecurityCodeRemovedEvent != null)
            {
                onSecurityCodeRemovedEvent.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_commission_acceptCommissionQuest(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("commission.acceptCommissionQuest", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._acceptCommissionQuest_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._acceptCommissionQuest_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._acceptCommissionQuest_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_getCoinsNeed(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CoinsNeedResponse("equipmenttech.getCoinsNeed", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmenttechCommands()._getCoinsNeed_callback != null)
            {
                actionFactory.getEquipmenttechCommands()._getCoinsNeed_callback.apply(this, [_local_2]);
                actionFactory.getEquipmenttechCommands()._getCoinsNeed_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_disbandInjuredTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.disbandInjuredTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._disbandInjuredTroop_callback != null)
            {
                actionFactory.getArmyCommands()._disbandInjuredTroop_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._disbandInjuredTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_accTroopProduce(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("troop.accTroopProduce", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTroopCommands()._accTroopProduce_callback != null)
            {
                actionFactory.getTroopCommands()._accTroopProduce_callback.apply(this, [_local_2]);
                actionFactory.getTroopCommands()._accTroopProduce_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_newBuildingQueue(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.newBuildingQueue", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._newBuildingQueue_callback != null)
            {
                actionFactory.getCastleCommands()._newBuildingQueue_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._newBuildingQueue_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_awardPacket(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("quest.awardPacket", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._awardPacket_callback != null)
            {
                actionFactory.getQuestCommands()._awardPacket_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._awardPacket_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getCommissionQuestArmyRanking(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommissionQuestArmyRespone("commission.getCommissionQuestArmyRanking", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyRanking_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyRanking_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyRanking_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeUserFace(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ChangeUserFaceResponse("common.changeUserFace", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._changeUserFace_callback != null)
            {
                actionFactory.getCommonCommands()._changeUserFace_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._changeUserFace_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_getTransingTradeList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new TransingTradeListResponse("trade.getTransingTradeList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTradeCommands()._getTransingTradeList_callback != null)
            {
                actionFactory.getTradeCommands()._getTransingTradeList_callback.apply(this, [_local_2]);
                actionFactory.getTradeCommands()._getTransingTradeList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_setResources(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("gamemaster.setResources", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._setResources_callback != null)
            {
                actionFactory.getModifyCommands()._setResources_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._setResources_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHerosListByFilter(_arg_1:Object):void
        {
            var _local_2:BaseBean = new NpcHeroListResponse("npchero.getNpcHerosListByFilter", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getNpcHeroCommand()._getNpcHerosListByFilter_callback != null)
            {
                actionFactory.getNpcHeroCommand()._getNpcHerosListByFilter_callback.apply(this, [_local_2]);
                actionFactory.getNpcHeroCommand()._getNpcHerosListByFilter_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_setAllowAllianceArmy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.setAllowAllianceArmy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._setAllowAllianceArmy_callback != null)
            {
                actionFactory.getArmyCommands()._setAllowAllianceArmy_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._setAllowAllianceArmy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_reduceArmaments(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonyLevyeRespone("colony.reduceArmaments", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._reduceArmaments_callback != null)
            {
                actionFactory.getColonyCommands()._reduceArmaments_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._reduceArmaments_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getMyCommissionQuest(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommissionQuestRespone("commission.getMyCommissionQuest", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._getMyCommissionQuest_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._getMyCommissionQuest_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._getMyCommissionQuest_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_deleteMail(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("mail.deleteMail", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._deleteMail_callback != null)
            {
                actionFactory.getMailCommands()._deleteMail_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._deleteMail_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_donate(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("quest.donate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._donate_callback != null)
            {
                actionFactory.getQuestCommands()._donate_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._donate_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_leaderWantUserInAllianceList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceInviteOnClientBeanResponse("alliance.leaderWantUserInAllianceList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_promoteToChief(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.promoteToChief", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._promoteToChief_callback != null)
            {
                actionFactory.getHeroCommand()._promoteToChief_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._promoteToChief_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_receiveMailList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new MailListResponse("mail.receiveMailList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._receiveMailList_callback != null)
            {
                actionFactory.getMailCommands()._receiveMailList_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._receiveMailList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_DeclaredWarStatusChange(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new DeclaredWarStatusChange("server.DeclaredWarStatusChange", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onDeclaredWarStatusChange != null)
            {
                onDeclaredWarStatusChange.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_commission_getAllCommissionQuest(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommissionQuestRespone("commission.getAllCommissionQuest", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._getAllCommissionQuest_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._getAllCommissionQuest_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._getAllCommissionQuest_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setSecurityCode(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setSecurityCode", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._setSecurityCode_callback != null)
            {
                actionFactory.getSecurityCommands()._setSecurityCode_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._setSecurityCode_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useCastleGoods(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("shop.useCastleGoods", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._useCastleGoods_callback != null)
            {
                actionFactory.getShopCommands()._useCastleGoods_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._useCastleGoods_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_speedupBuildingQueue(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.speedupBuildingQueue", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._speedupBuildingQueue_callback != null)
            {
                actionFactory.getCastleCommands()._speedupBuildingQueue_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._speedupBuildingQueue_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getAvailableBuildingBean(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AvailableBuilingListResponse("castle.getAvailableBuildingBean", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._getAvailableBuildingBean_callback != null)
            {
                actionFactory.getCastleCommands()._getAvailableBuildingBean_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._getAvailableBuildingBean_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getAvailableBuildingListInside(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AvailableBuilingListResponse("castle.getAvailableBuildingListInside", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback != null)
            {
                actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPackageList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetPackageListResponse("common.getPackageList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getPackageList_callback != null)
            {
                actionFactory.getCommonCommands()._getPackageList_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getPackageList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getColonialCastlesInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonialCastlesRespone("colony.getColonialCastlesInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._getColonialCastlesInfo_callback != null)
            {
                actionFactory.getColonyCommands()._getColonialCastlesInfo_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._getColonialCastlesInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_tryGetSeizedHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.tryGetSeizedHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._tryGetSeizedHero_callback != null)
            {
                actionFactory.getHeroCommand()._tryGetSeizedHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._tryGetSeizedHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_addUsertoAllianceList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceInviteBeanResponse("alliance.addUsertoAllianceList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_agreeComeinAllianceByLeader(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.agreeComeinAllianceByLeader", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getDeployTroopsInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonialDeployResponse("colony.getDeployTroopsInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._getDeployTroopsInfo_callback != null)
            {
                actionFactory.getColonyCommands()._getDeployTroopsInfo_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._getDeployTroopsInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_setAllInfoForAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.setAllInfoForAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_createNewPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CreatePlayerResponse("common.createNewPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._createNewPlayer_callback != null)
            {
                actionFactory.getCommonCommands()._createNewPlayer_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._createNewPlayer_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceWanted(_arg_1:Object):void
        {
            var _local_2:BaseBean = new WantedAllianceResponse("alliance.getAllianceWanted", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getAllianceArmyReport(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceArmyResponse("alliance.getAllianceArmyReport", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceCommands()._getAllianceArmyReport_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceArmyReport_callback.apply(this, [_local_2]);
                actionFactory.getAllianceCommands()._getAllianceArmyReport_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_celeb_findPlayerByStar(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CelebResponse("celeb.findPlayerByStar", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCelebRankCommands()._findPlayerByStar_callback != null)
            {
                actionFactory.getCelebRankCommands()._findPlayerByStar_callback.apply(this, [_local_2]);
                actionFactory.getCelebRankCommands()._findPlayerByStar_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_saveUnregisteredPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.saveUnregisteredPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._saveUnregisteredPlayer_callback != null)
            {
                actionFactory.getCommonCommands()._saveUnregisteredPlayer_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._saveUnregisteredPlayer_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_worldChat(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ChatResponse("common.worldChat", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._worldChat_callback != null)
            {
                actionFactory.getCommonCommands()._worldChat_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._worldChat_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_cancelBuildingQueue(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.cancelBuildingQueue", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._cancelBuildingQueue_callback != null)
            {
                actionFactory.getCastleCommands()._cancelBuildingQueue_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._cancelBuildingQueue_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getCanDeclaredWarAgainstPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetCanDeclaredWarAgainstPlayerRespone("common.getCanDeclaredWarAgainstPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getCanDeclaredWarAgainstPlayer_callback != null)
            {
                actionFactory.getCommonCommands()._getCanDeclaredWarAgainstPlayer_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getCanDeclaredWarAgainstPlayer_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getQuestType(_arg_1:Object):void
        {
            var _local_2:BaseBean = new QuestTypeResponse("quest.getQuestType", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._getQuestType_callback != null)
            {
                actionFactory.getQuestCommands()._getQuestType_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._getQuestType_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_modifyTaxRate(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("interior.modifyTaxRate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getInteriorCommands()._modifyTaxRate_callback != null)
            {
                actionFactory.getInteriorCommands()._modifyTaxRate_callback.apply(this, [_local_2]);
                actionFactory.getInteriorCommands()._modifyTaxRate_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_dropAllianceFriendshipRelation(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceFriendshipResponse("alliance.dropAllianceFriendshipRelation", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_TakeOffEquipmenttech(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("equipment.TakeOffEquipmenttech", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmentCommands()._TakeOffEquipmenttech_callback != null)
            {
                actionFactory.getEquipmentCommands()._TakeOffEquipmenttech_callback.apply(this, [_local_2]);
                actionFactory.getEquipmentCommands()._TakeOffEquipmenttech_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_useTrickItem(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("shop.useTrickItem", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._useTrickItem_callback != null)
            {
                actionFactory.getShopCommands()._useTrickItem_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._useTrickItem_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_getLeftPoliciesTimes(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CapitalCommandResponse("capital.getLeftPoliciesTimes", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCapitalCommands()._getLeftPoliciesTimes_callback != null)
            {
                actionFactory.getCapitalCommands()._getLeftPoliciesTimes_callback.apply(this, [_local_2]);
                actionFactory.getCapitalCommands()._getLeftPoliciesTimes_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_WearAllEquipmenttech(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("equipment.WearAllEquipmenttech", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmentCommands()._WearAllEquipmenttech_callback != null)
            {
                actionFactory.getEquipmentCommands()._WearAllEquipmenttech_callback.apply(this, [_local_2]);
                actionFactory.getEquipmentCommands()._WearAllEquipmenttech_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_fireHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.fireHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._fireHero_callback != null)
            {
                actionFactory.getHeroCommand()._fireHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._fireHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_checkOutUpgrade(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CheckOutBuildingResponse("castle.checkOutUpgrade", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._checkOutUpgrade_callback != null)
            {
                actionFactory.getCastleCommands()._checkOutUpgrade_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._checkOutUpgrade_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_getPowerFromAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AlliancePowerLevelResponse("alliance.getPowerFromAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_getUsedPoliciesTimes(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CapitalCommandResponse("capital.getUsedPoliciesTimes", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCapitalCommands()._getUsedPoliciesTimes_callback != null)
            {
                actionFactory.getCapitalCommands()._getUsedPoliciesTimes_callback.apply(this, [_local_2]);
                actionFactory.getCapitalCommands()._getUsedPoliciesTimes_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_kickOutMemberfromAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.kickOutMemberfromAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_readMail(_arg_1:Object):void
        {
            var _local_2:BaseBean = new MailResponse("mail.readMail", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._readMail_callback != null)
            {
                actionFactory.getMailCommands()._readMail_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._readMail_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_PlayerBuffUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new PlayerBuffUpdate("server.PlayerBuffUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onPlayerBuffUpdate != null)
            {
                onPlayerBuffUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_BuildingQueueUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new BuildingQueueUpdate("server.BuildingQueueUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onBuildingQueueUpdate != null)
            {
                onBuildingQueueUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_report_markAsRead(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ReportResponse("report.markAsRead", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getReportCommands()._markAsRead_callback != null)
            {
                actionFactory.getReportCommands()._markAsRead_callback.apply(this, [_local_2]);
                actionFactory.getReportCommands()._markAsRead_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_constructCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.constructCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._constructCastle_callback != null)
            {
                actionFactory.getCityCommands()._constructCastle_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._constructCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_allianceChat(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ChatResponse("common.allianceChat", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._allianceChat_callback != null)
            {
                actionFactory.getCommonCommands()._allianceChat_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._allianceChat_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_getTroopProduceList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new TroopProduceListResponse("troop.getTroopProduceList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTroopCommands()._getTroopProduceList_callback != null)
            {
                actionFactory.getTroopCommands()._getTroopProduceList_callback.apply(this, [_local_2]);
                actionFactory.getTroopCommands()._getTroopProduceList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_messagesForAllianceMember(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.messagesForAllianceMember", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHeroInfroByID(_arg_1:Object):void
        {
            var _local_2:BaseBean = new NpcHeroListResponse("npchero.getNpcHeroInfroByID", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getNpcHeroCommand()._getNpcHeroInfroByID_callback != null)
            {
                actionFactory.getNpcHeroCommand()._getNpcHeroInfroByID_callback.apply(this, [_local_2]);
                actionFactory.getNpcHeroCommand()._getNpcHeroInfroByID_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_removeItem(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("gamemaster.removeItem", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._removeItem_callback != null)
            {
                actionFactory.getModifyCommands()._removeItem_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._removeItem_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_report_receiveReportList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ReportListResponse("report.receiveReportList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getReportCommands()._receiveReportList_callback != null)
            {
                actionFactory.getReportCommands()._receiveReportList_callback.apply(this, [_local_2]);
                actionFactory.getReportCommands()._receiveReportList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_buyResource(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("shop.buyResource", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._buyResource_callback != null)
            {
                actionFactory.getShopCommands()._buyResource_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._buyResource_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_facebookConnect(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.facebookConnect", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._facebookConnect_callback != null)
            {
                actionFactory.getCommonCommands()._facebookConnect_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._facebookConnect_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_PackageList(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new PackageList("server.PackageList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onPackageList != null)
            {
                onPackageList.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_CelebRankCompleteTipResponse(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CelebRankCompleteTipResponse("server.CelebRankCompleteTipResponse", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onCelebRankCompleteTipResponse != null)
            {
                onCelebRankCompleteTipResponse.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_PlayerInfoUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new PlayerInfoUpdate("server.PlayerInfoUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onPlayerInfoUpdate != null)
            {
                onPlayerInfoUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_UnregisteredCreatePlayerResponse(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new UnregisteredCreatePlayerResponse("server.UnregisteredCreatePlayerResponse", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onUnregisteredCreatePlayerResponse != null)
            {
                onUnregisteredCreatePlayerResponse.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_alliance_sayByetoAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.sayByetoAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_levyFood(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonyLevyeRespone("colony.levyFood", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._levyFood_callback != null)
            {
                actionFactory.getColonyCommands()._levyFood_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._levyFood_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_modifyCommenceRate(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("interior.modifyCommenceRate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getInteriorCommands()._modifyCommenceRate_callback != null)
            {
                actionFactory.getInteriorCommands()._modifyCommenceRate_callback.apply(this, [_local_2]);
                actionFactory.getInteriorCommands()._modifyCommenceRate_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_removeBuilding(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("gamemaster.removeBuilding", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._removeBuilding_callback != null)
            {
                actionFactory.getModifyCommands()._removeBuilding_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._removeBuilding_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_callBackHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.callBackHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._callBackHero_callback != null)
            {
                actionFactory.getHeroCommand()._callBackHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._callBackHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_readOverMailList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new MailResponse("mail.readOverMailList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._readOverMailList_callback != null)
            {
                actionFactory.getMailCommands()._readOverMailList_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._readOverMailList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getIsSecurityCodeSetted(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetIsSecurityCodeSettedResponse("common.getIsSecurityCodeSetted", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._getIsSecurityCodeSetted_callback != null)
            {
                actionFactory.getSecurityCommands()._getIsSecurityCodeSetted_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._getIsSecurityCodeSetted_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_CastleFieldUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CastleFieldUpdate("server.CastleFieldUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onCastleFieldUpdate != null)
            {
                onCastleFieldUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_alliance_getAllianceEventList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceEventListResponse("alliance.getAllianceEventList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceCommands()._getAllianceEventList_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceEventList_callback.apply(this, [_local_2]);
                actionFactory.getAllianceCommands()._getAllianceEventList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_getResearchList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AvailableResearchListResponse("equipmenttech.getResearchList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmenttechCommands()._getResearchList_callback != null)
            {
                actionFactory.getEquipmenttechCommands()._getResearchList_callback.apply(this, [_local_2]);
                actionFactory.getEquipmenttechCommands()._getResearchList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_declaredWarAgainstPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.declaredWarAgainstPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._declaredWarAgainstPlayer_callback != null)
            {
                actionFactory.getCommonCommands()._declaredWarAgainstPlayer_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._declaredWarAgainstPlayer_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_disbandTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("troop.disbandTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTroopCommands()._disbandTroop_callback != null)
            {
                actionFactory.getTroopCommands()._disbandTroop_callback.apply(this, [_local_2]);
                actionFactory.getTroopCommands()._disbandTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_GetPlayerVoteInfro(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new GetPlayerVoteInfro("server.GetPlayerVoteInfro", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onGetPlayerVoteInfro != null)
            {
                onGetPlayerVoteInfro.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_city_modifyCastleIcon(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.modifyCastleIcon", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._modifyCastleIcon_callback != null)
            {
                actionFactory.getCityCommands()._modifyCastleIcon_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._modifyCastleIcon_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_deleteComment(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("visit.deleteComment", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVisitCommands()._deleteComment_callback != null)
            {
                actionFactory.getVisitCommands()._deleteComment_callback.apply(this, [_local_2]);
                actionFactory.getVisitCommands()._deleteComment_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getHeroRank(_arg_1:Object):void
        {
            var _local_2:BaseBean = new RankHeroResponse("rank.getHeroRank", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getRankCommands()._getHeroRank_callback != null)
            {
                actionFactory.getRankCommands()._getHeroRank_callback.apply(this, [_local_2]);
                actionFactory.getRankCommands()._getHeroRank_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_zoneInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ZoneInfoResponse("common.zoneInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._zoneInfo_callback != null)
            {
                actionFactory.getCommonCommands()._zoneInfo_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._zoneInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getTroopParam(_arg_1:Object):void
        {
            var _local_2:BaseBean = new TroopParamResponse("army.getTroopParam", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._getTroopParam_callback != null)
            {
                actionFactory.getArmyCommands()._getTroopParam_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._getTroopParam_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_getProduceQueue(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ProduceQueueResponse("fortifications.getProduceQueue", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFortificationsCommands()._getProduceQueue_callback != null)
            {
                actionFactory.getFortificationsCommands()._getProduceQueue_callback.apply(this, [_local_2]);
                actionFactory.getFortificationsCommands()._getProduceQueue_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamblingranking_getGamblingRankingReward(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GamblingRankingRewardRespone("gamblingranking.getGamblingRankingReward", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getGamblingRankingCommands()._getGamblingRankingReward_callback != null)
            {
                actionFactory.getGamblingRankingCommands()._getGamblingRankingReward_callback.apply(this, [_local_2]);
                actionFactory.getGamblingRankingCommands()._getGamblingRankingReward_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_createAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.createAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._createAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._createAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._createAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_WarMoveCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.WarMoveCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._WarMoveCastle_callback != null)
            {
                actionFactory.getCityCommands()._WarMoveCastle_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._WarMoveCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_WorldChatMsg(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new WorldChatMsg("server.WorldChatMsg", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onWorldChatMsg != null)
            {
                onWorldChatMsg.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_fortifications_produceWallProtect(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("fortifications.produceWallProtect", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFortificationsCommands()._produceWallProtect_callback != null)
            {
                actionFactory.getFortificationsCommands()._produceWallProtect_callback.apply(this, [_local_2]);
                actionFactory.getFortificationsCommands()._produceWallProtect_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_abandonColony(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("colony.abandonColony", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._abandonColony_callback != null)
            {
                actionFactory.getColonyCommands()._abandonColony_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._abandonColony_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_speedUpResearch(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ResearchResponse("tech.speedUpResearch", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTechCommand()._speedUpResearch_callback != null)
            {
                actionFactory.getTechCommand()._speedUpResearch_callback.apply(this, [_local_2]);
                actionFactory.getTechCommand()._speedUpResearch_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_changeHeadline(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.changeHeadline", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._changeHeadline_callback != null)
            {
                actionFactory.getCommonCommands()._changeHeadline_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._changeHeadline_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_cancelUserWantInAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.cancelUserWantInAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_RecoverDisappearHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.RecoverDisappearHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._RecoverDisappearHero_callback != null)
            {
                actionFactory.getHeroCommand()._RecoverDisappearHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._RecoverDisappearHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_stratagem_useStratagem(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("stratagem.useStratagem", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getStratagemCommands()._useStratagem_callback != null)
            {
                actionFactory.getStratagemCommands()._useStratagem_callback.apply(this, [_local_2]);
                actionFactory.getStratagemCommands()._useStratagem_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getAllianceRank(_arg_1:Object):void
        {
            var _local_2:BaseBean = new RankAllianceResponse("rank.getAllianceRank", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getRankCommands()._getAllianceRank_callback != null)
            {
                actionFactory.getRankCommands()._getAllianceRank_callback.apply(this, [_local_2]);
                actionFactory.getRankCommands()._getAllianceRank_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_TradesUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new TradesUpdate("server.TradesUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onTradesUpdate != null)
            {
                onTradesUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_city_advMoveCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.advMoveCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._advMoveCastle_callback != null)
            {
                actionFactory.getCityCommands()._advMoveCastle_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._advMoveCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_resetTopPowerForAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.resetTopPowerForAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_IsDropItemInCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.IsDropItemInCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._IsDropItemInCastle_callback != null)
            {
                actionFactory.getArmyCommands()._IsDropItemInCastle_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._IsDropItemInCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_interior_pacifyPeople(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("interior.pacifyPeople", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getInteriorCommands()._pacifyPeople_callback != null)
            {
                actionFactory.getInteriorCommands()._pacifyPeople_callback.apply(this, [_local_2]);
                actionFactory.getInteriorCommands()._pacifyPeople_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyFood(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CapitalCommandResponse("capital.levyFood", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCapitalCommands()._levyFood_callback != null)
            {
                actionFactory.getCapitalCommands()._levyFood_callback.apply(this, [_local_2]);
                actionFactory.getCapitalCommands()._levyFood_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_TransingTradeUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new TransingTradeUpdate("server.TransingTradeUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onTransingTradeUpdate != null)
            {
                onTransingTradeUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_castle_saveCastleSignList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CastleSignResponse("castle.saveCastleSignList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleSignCommand()._saveCastleSignList_callback != null)
            {
                actionFactory.getCastleSignCommand()._saveCastleSignList_callback.apply(this, [_local_2]);
                actionFactory.getCastleSignCommand()._saveCastleSignList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_denyPlayerSpeak(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.denyPlayerSpeak", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._denyPlayerSpeak_callback != null)
            {
                actionFactory.getCommonCommands()._denyPlayerSpeak_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._denyPlayerSpeak_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_getAvailableBuildingListOutside(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AvailableBuilingListResponse("castle.getAvailableBuildingListOutside", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback != null)
            {
                actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_TroopUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new TroopUpdate("server.TroopUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onTroopUpdate != null)
            {
                onTroopUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_city_modifyFlag(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.modifyFlag", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._modifyFlag_callback != null)
            {
                actionFactory.getCityCommands()._modifyFlag_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._modifyFlag_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_getAllVisitorComments(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetAllVisitorCommentsResponse("visit.getAllVisitorComments", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVisitCommands()._getAllVisitorComments_callback != null)
            {
                actionFactory.getVisitCommands()._getAllVisitorComments_callback.apply(this, [_local_2]);
                actionFactory.getVisitCommands()._getAllVisitorComments_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_SystemInfoMsg(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new SystemInfoMsg("server.SystemInfoMsg", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onSystemInfoMsg != null)
            {
                onSystemInfoMsg.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_common_setEvonyMemberEMail(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setEvonyMemberEMail", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._setEvonyMemberEMail_callback != null)
            {
                actionFactory.getCommonCommands()._setEvonyMemberEMail_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._setEvonyMemberEMail_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_resignForAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceManagementResponse("alliance.resignForAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._resignForAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._resignForAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._resignForAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_cancelagreeComeinAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceUserAddResponse("alliance.cancelagreeComeinAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_overviewColonialCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new OverviewColonyCastleRespone("colony.overviewColonialCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._overviewColonialCastle_callback != null)
            {
                actionFactory.getColonyCommands()._overviewColonialCastle_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._overviewColonialCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_uniteAdvMoveCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.uniteAdvMoveCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._uniteAdvMoveCastle_callback != null)
            {
                actionFactory.getCityCommands()._uniteAdvMoveCastle_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._uniteAdvMoveCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_deleteBlock(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FriendResponse("friend.deleteBlock", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFriendCommands()._deleteBlock_callback != null)
            {
                actionFactory.getFriendCommands()._deleteBlock_callback.apply(this, [_local_2]);
                actionFactory.getFriendCommands()._deleteBlock_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_addItems(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("gamemaster.addItems", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._addItems_callback != null)
            {
                actionFactory.getModifyCommands()._addItems_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._addItems_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_truce_setDreamTruce(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("truce.setDreamTruce", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTruceCommands()._setDreamTruce_callback != null)
            {
                actionFactory.getTruceCommands()._setDreamTruce_callback.apply(this, [_local_2]);
                actionFactory.getTruceCommands()._setDreamTruce_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setProtectOption(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setProtectOption", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._setProtectOption_callback != null)
            {
                actionFactory.getSecurityCommands()._setProtectOption_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._setProtectOption_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_npchero_getNpcHerosList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new NpcHeroListResponse("npchero.getNpcHerosList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getNpcHeroCommand()._getNpcHerosList_callback != null)
            {
                actionFactory.getNpcHeroCommand()._getNpcHerosList_callback.apply(this, [_local_2]);
                actionFactory.getNpcHeroCommand()._getNpcHerosList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_speedUpBuildCommand(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("castle.speedUpBuildCommand", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleCommands()._speedUpBuildCommand_callback != null)
            {
                actionFactory.getCastleCommands()._speedUpBuildCommand_callback.apply(this, [_local_2]);
                actionFactory.getCastleCommands()._speedUpBuildCommand_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_trade_speedUpTrans(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("trade.speedUpTrans", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTradeCommands()._speedUpTrans_callback != null)
            {
                actionFactory.getTradeCommands()._speedUpTrans_callback.apply(this, [_local_2]);
                actionFactory.getTradeCommands()._speedUpTrans_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_reportPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("mail.reportPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._reportPlayer_callback != null)
            {
                actionFactory.getMailCommands()._reportPlayer_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._reportPlayer_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getSuzerainColonialCastlesInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonialCastlesRespone("colony.getSuzerainColonialCastlesInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._getSuzerainColonialCastlesInfo_callback != null)
            {
                actionFactory.getColonyCommands()._getSuzerainColonialCastlesInfo_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._getSuzerainColonialCastlesInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_canceladdUsertoAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceInviteBeanResponse("alliance.canceladdUsertoAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_removeSecurityCode(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.removeSecurityCode", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._removeSecurityCode_callback != null)
            {
                actionFactory.getSecurityCommands()._removeSecurityCode_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._removeSecurityCode_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_GetDisappearHeros(_arg_1:Object):void
        {
            var _local_2:BaseBean = new DisappearHeroResponse("hero.GetDisappearHeros", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._GetDisappearHeros_callback != null)
            {
                actionFactory.getHeroCommand()._GetDisappearHeros_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._GetDisappearHeros_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_setArmyGoOut(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.setArmyGoOut", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._setArmyGoOut_callback != null)
            {
                actionFactory.getArmyCommands()._setArmyGoOut_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._setArmyGoOut_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getAwardItems(_arg_1:Object):void
        {
            var _local_2:BaseBean = new QuestRewardRespone("quest.getAwardItems", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._getAwardItems_callback != null)
            {
                actionFactory.getQuestCommands()._getAwardItems_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._getAwardItems_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_LoginResponse(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new LoginResponse("server.LoginResponse", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onLoginResponse != null)
            {
                onLoginResponse.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_commission_declineCommissionQuest(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("commission.declineCommissionQuest", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._declineCommissionQuest_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._declineCommissionQuest_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._declineCommissionQuest_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_uprise(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("colony.uprise", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._uprise_callback != null)
            {
                actionFactory.getColonyCommands()._uprise_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._uprise_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_deleteUserAndRestart(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.deleteUserAndRestart", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._deleteUserAndRestart_callback != null)
            {
                actionFactory.getCommonCommands()._deleteUserAndRestart_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._deleteUserAndRestart_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_setReturnReport(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setReturnReport", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._setReturnReport_callback != null)
            {
                actionFactory.getCommonCommands()._setReturnReport_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._setReturnReport_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_NewReport(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new NewReport("server.NewReport", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onNewReport != null)
            {
                onNewReport.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_FleeTroopUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new FleeTroopUpdate("server.FleeTroopUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onFleeTroopUpdate != null)
            {
                onFleeTroopUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_gamblingranking_getGamblingRankingYesterday(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GamblingRankingRespone("gamblingranking.getGamblingRankingYesterday", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getGamblingRankingCommands()._getGamblingRankingYesterday_callback != null)
            {
                actionFactory.getGamblingRankingCommands()._getGamblingRankingYesterday_callback.apply(this, [_local_2]);
                actionFactory.getGamblingRankingCommands()._getGamblingRankingYesterday_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_shop_buy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("shop.buy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getShopCommands()._buy_callback != null)
            {
                actionFactory.getShopCommands()._buy_callback.apply(this, [_local_2]);
                actionFactory.getShopCommands()._buy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_visit_getVisitorComments(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetAllVisitorCommentsResponse("visit.getVisitorComments", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getVisitCommands()._getVisitorComments_callback != null)
            {
                actionFactory.getVisitCommands()._getVisitorComments_callback.apply(this, [_local_2]);
                actionFactory.getVisitCommands()._getVisitorComments_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPackage(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetPackageResponse("common.getPackage", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getPackage_callback != null)
            {
                actionFactory.getCommonCommands()._getPackage_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getPackage_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyTaxes(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CapitalCommandResponse("capital.levyTaxes", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCapitalCommands()._levyTaxes_callback != null)
            {
                actionFactory.getCapitalCommands()._levyTaxes_callback.apply(this, [_local_2]);
                actionFactory.getCapitalCommands()._levyTaxes_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_mail_sendMail(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("mail.sendMail", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getMailCommands()._sendMail_callback != null)
            {
                actionFactory.getMailCommands()._sendMail_callback.apply(this, [_local_2]);
                actionFactory.getMailCommands()._sendMail_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_authSecurityCode(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.authSecurityCode", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._authSecurityCode_callback != null)
            {
                actionFactory.getSecurityCommands()._authSecurityCode_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._authSecurityCode_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_DeclaredWarUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new DeclaredWarUpdate("server.DeclaredWarUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onDeclaredWarUpdate != null)
            {
                onDeclaredWarUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_hero_resetPoint(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.resetPoint", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._resetPoint_callback != null)
            {
                actionFactory.getHeroCommand()._resetPoint_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._resetPoint_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_mapInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new MapInfoResponse("common.mapInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._mapInfo_callback != null)
            {
                actionFactory.getCommonCommands()._mapInfo_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._mapInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_exerciseArmy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ArmyPracticeResponse("army.exerciseArmy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._exerciseArmy_callback != null)
            {
                actionFactory.getArmyCommands()._exerciseArmy_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._exerciseArmy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_gamemaster_removeHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("gamemaster.removeHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getModifyCommands()._removeHero_callback != null)
            {
                actionFactory.getModifyCommands()._removeHero_callback.apply(this, [_local_2]);
                actionFactory.getModifyCommands()._removeHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_tech_cancelResearch(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("tech.cancelResearch", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTechCommand()._cancelResearch_callback != null)
            {
                actionFactory.getTechCommand()._cancelResearch_callback.apply(this, [_local_2]);
                actionFactory.getTechCommand()._cancelResearch_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getEffortList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new EffortListResponse("quest.getEffortList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._getEffortList_callback != null)
            {
                actionFactory.getQuestCommands()._getEffortList_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._getEffortList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_callBackArmy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.callBackArmy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._callBackArmy_callback != null)
            {
                actionFactory.getArmyCommands()._callBackArmy_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._callBackArmy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_BuildComplate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new BuildComplate("server.BuildComplate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onBuildComplate != null)
            {
                onBuildComplate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_alliance_rejectComeinAlliance(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceUserAddResponse("alliance.rejectComeinAlliance", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_field_giveUpField(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("field.giveUpField", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFieldCommand()._giveUpField_callback != null)
            {
                actionFactory.getFieldCommand()._giveUpField_callback.apply(this, [_local_2]);
                actionFactory.getFieldCommand()._giveUpField_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ItemUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ItemUpdate("server.ItemUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onItemUpdate != null)
            {
                onItemUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_hero_getFleeHeroList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new HeroListResponse("hero.getFleeHeroList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._getFleeHeroList_callback != null)
            {
                actionFactory.getHeroCommand()._getFleeHeroList_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._getFleeHeroList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_useItem(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.useItem", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._useItem_callback != null)
            {
                actionFactory.getHeroCommand()._useItem_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._useItem_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_HeroUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new HeroUpdate("server.HeroUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onHeroUpdate != null)
            {
                onHeroUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_hero_hireFacebookFriendHero(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.hireFacebookFriendHero", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._hireFacebookFriendHero_callback != null)
            {
                actionFactory.getHeroCommand()._hireFacebookFriendHero_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._hireFacebookFriendHero_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_FortificationsUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new FortificationsUpdate("server.FortificationsUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onFortificationsUpdate != null)
            {
                onFortificationsUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_truce_changeDreamTruceTime(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("truce.changeDreamTruceTime", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTruceCommands()._changeDreamTruceTime_callback != null)
            {
                actionFactory.getTruceCommands()._changeDreamTruceTime_callback.apply(this, [_local_2]);
                actionFactory.getTruceCommands()._changeDreamTruceTime_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_isBlockMailPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FriendResponse("friend.isBlockMailPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFriendCommands()._isBlockMailPlayer_callback != null)
            {
                actionFactory.getFriendCommands()._isBlockMailPlayer_callback.apply(this, [_local_2]);
                actionFactory.getFriendCommands()._isBlockMailPlayer_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ResearchCompleteUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ResearchCompleteUpdate("server.ResearchCompleteUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onResearchCompleteUpdate != null)
            {
                onResearchCompleteUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_NewFinishedQuest(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new NewFinishedQuest("server.NewFinishedQuest", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onNewFinishedQuest != null)
            {
                onNewFinishedQuest.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_hero_levelUp(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.levelUp", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._levelUp_callback != null)
            {
                actionFactory.getHeroCommand()._levelUp_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._levelUp_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_setHeroFacebookId(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.setHeroFacebookId", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._setHeroFacebookId_callback != null)
            {
                actionFactory.getHeroCommand()._setHeroFacebookId_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._setHeroFacebookId_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_checkIdleBarrack(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("troop.checkIdleBarrack", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTroopCommands()._checkIdleBarrack_callback != null)
            {
                actionFactory.getTroopCommands()._checkIdleBarrack_callback.apply(this, [_local_2]);
                actionFactory.getTroopCommands()._checkIdleBarrack_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_troop_produceTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("troop.produceTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTroopCommands()._produceTroop_callback != null)
            {
                actionFactory.getTroopCommands()._produceTroop_callback.apply(this, [_local_2]);
                actionFactory.getTroopCommands()._produceTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_capital_levyPopulation(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CapitalCommandResponse("capital.levyPopulation", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCapitalCommands()._levyPopulation_callback != null)
            {
                actionFactory.getCapitalCommands()._levyPopulation_callback.apply(this, [_local_2]);
                actionFactory.getCapitalCommands()._levyPopulation_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_alliance_agreeComeinAllianceByUser(_arg_1:Object):void
        {
            var _local_2:BaseBean = new AllianceUserAddResponse("alliance.agreeComeinAllianceByUser", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback.apply(this, [_local_2]);
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_castle_deleteCastleSign(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CastleSignResponse("castle.deleteCastleSign", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCastleSignCommand()._deleteCastleSign_callback != null)
            {
                actionFactory.getCastleSignCommand()._deleteCastleSign_callback.apply(this, [_local_2]);
                actionFactory.getCastleSignCommand()._deleteCastleSign_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_CbUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CbUpdate("server.CbUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onCbUpdate != null)
            {
                onCbUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_GetTopVotesPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new GetTopVotesPlayer("server.GetTopVotesPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onGetTopVotesPlayer != null)
            {
                onGetTopVotesPlayer.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_celeb_findPlayerByPrestige(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CelebResponse("celeb.findPlayerByPrestige", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCelebRankCommands()._findPlayerByPrestige_callback != null)
            {
                actionFactory.getCelebRankCommands()._findPlayerByPrestige_callback.apply(this, [_local_2]);
                actionFactory.getCelebRankCommands()._findPlayerByPrestige_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getPackageNumber(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetPackageNumberResponse("common.getPackageNumber", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getPackageNumber_callback != null)
            {
                actionFactory.getCommonCommands()._getPackageNumber_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getPackageNumber_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_quest_getQuestList(_arg_1:Object):void
        {
            var _local_2:BaseBean = new QuestListResponse("quest.getQuestList", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getQuestCommands()._getQuestList_callback != null)
            {
                actionFactory.getQuestCommands()._getQuestList_callback.apply(this, [_local_2]);
                actionFactory.getQuestCommands()._getQuestList_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getStayAllianceArmys(_arg_1:Object):void
        {
            var _local_2:BaseBean = new StayAllianceReponse("army.getStayAllianceArmys", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._getStayAllianceArmys_callback != null)
            {
                actionFactory.getArmyCommands()._getStayAllianceArmys_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._getStayAllianceArmys_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_cancelRemovingSecurityCodeProcess(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.cancelRemovingSecurityCodeProcess", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getSecurityCommands()._cancelRemovingSecurityCodeProcess_callback != null)
            {
                actionFactory.getSecurityCommands()._cancelRemovingSecurityCodeProcess_callback.apply(this, [_local_2]);
                actionFactory.getSecurityCommands()._cancelRemovingSecurityCodeProcess_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_ItemBuff(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new ItemBuff("server.ItemBuff", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onItemBuff != null)
            {
                onItemBuff.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_NewMail(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new NewMail("server.NewMail", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onNewMail != null)
            {
                onNewMail.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_equipment_WearEquipmenttech(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("equipment.WearEquipmenttech", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmentCommands()._WearEquipmenttech_callback != null)
            {
                actionFactory.getEquipmentCommands()._WearEquipmenttech_callback.apply(this, [_local_2]);
                actionFactory.getEquipmentCommands()._WearEquipmenttech_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_levyArmy(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonyLevyeRespone("colony.levyArmy", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._levyArmy_callback != null)
            {
                actionFactory.getColonyCommands()._levyArmy_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._levyArmy_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_getCommissionQuestArmyInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommissionQuestArmyInfoRespone("commission.getCommissionQuestArmyInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyInfo_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyInfo_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._getCommissionQuestArmyInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_CastleBuffUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new CastleBuffUpdate("server.CastleBuffUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onCastleBuffUpdate != null)
            {
                onCastleBuffUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_hero_getHerosListFromTavern(_arg_1:Object):void
        {
            var _local_2:BaseBean = new HeroListResponse("hero.getHerosListFromTavern", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._getHerosListFromTavern_callback != null)
            {
                actionFactory.getHeroCommand()._getHerosListFromTavern_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._getHerosListFromTavern_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_friend_addFriend(_arg_1:Object):void
        {
            var _local_2:BaseBean = new FriendResponse("friend.addFriend", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFriendCommands()._addFriend_callback != null)
            {
                actionFactory.getFriendCommands()._addFriend_callback.apply(this, [_local_2]);
                actionFactory.getFriendCommands()._addFriend_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_fortifications_destructWallProtect(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("fortifications.destructWallProtect", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getFortificationsCommands()._destructWallProtect_callback != null)
            {
                actionFactory.getFortificationsCommands()._destructWallProtect_callback.apply(this, [_local_2]);
                actionFactory.getFortificationsCommands()._destructWallProtect_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_colony_getColonialArmyInfo(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ColonialArmyResponse("colony.getColonialArmyInfo", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._getColonialArmyInfo_callback != null)
            {
                actionFactory.getColonyCommands()._getColonialArmyInfo_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._getColonialArmyInfo_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_commission_issueCommissionQuest(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("commission.issueCommissionQuest", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommissionQuestCommands()._issueCommissionQuest_callback != null)
            {
                actionFactory.getCommissionQuestCommands()._issueCommissionQuest_callback.apply(this, [_local_2]);
                actionFactory.getCommissionQuestCommands()._issueCommissionQuest_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_army_getInjuredTroop(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("army.getInjuredTroop", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getArmyCommands()._getInjuredTroop_callback != null)
            {
                actionFactory.getArmyCommands()._getInjuredTroop_callback.apply(this, [_local_2]);
                actionFactory.getArmyCommands()._getInjuredTroop_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipmenttech_research(_arg_1:Object):void
        {
            var _local_2:BaseBean = new ResearchResponse("equipmenttech.research", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmenttechCommands()._research_callback != null)
            {
                actionFactory.getEquipmenttechCommands()._research_callback.apply(this, [_local_2]);
                actionFactory.getEquipmenttechCommands()._research_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_EnemyArmysUpdate(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new EnemyArmysUpdate("server.EnemyArmysUpdate", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onEnemyArmysUpdate != null)
            {
                onEnemyArmysUpdate.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_trade_searchTrades(_arg_1:Object):void
        {
            var _local_2:BaseBean = new SearchTradesResponse("trade.searchTrades", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getTradeCommands()._searchTrades_callback != null)
            {
                actionFactory.getTradeCommands()._searchTrades_callback.apply(this, [_local_2]);
                actionFactory.getTradeCommands()._searchTrades_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_common_getRelationship(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GetRelationshipRespone("common.getRelationship", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._getRelationship_callback != null)
            {
                actionFactory.getCommonCommands()._getRelationship_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._getRelationship_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_equipment_EnhancedByGemStone(_arg_1:Object):void
        {
            var _local_2:BaseBean = new GemstoneRespone("equipment.EnhancedByGemStone", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getEquipmentCommands()._EnhancedByGemStone_callback != null)
            {
                actionFactory.getEquipmentCommands()._EnhancedByGemStone_callback.apply(this, [_local_2]);
                actionFactory.getEquipmentCommands()._EnhancedByGemStone_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_city_moveCastle(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("city.moveCastle", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCityCommands()._moveCastle_callback != null)
            {
                actionFactory.getCityCommands()._moveCastle_callback.apply(this, [_local_2]);
                actionFactory.getCityCommands()._moveCastle_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getTopVotesPlayer(_arg_1:Object):void
        {
            var _local_2:BaseBean = new TopVotesPlayersResponse("rank.getTopVotesPlayer", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getRankCommands()._getTopVotesPlayer_callback != null)
            {
                actionFactory.getRankCommands()._getTopVotesPlayer_callback.apply(this, [_local_2]);
                actionFactory.getRankCommands()._getTopVotesPlayer_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_awardGold(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.awardGold", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._awardGold_callback != null)
            {
                actionFactory.getHeroCommand()._awardGold_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._awardGold_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_QuestFinished(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new QuestFinished("server.QuestFinished", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onQuestFinished != null)
            {
                onQuestFinished.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_common_setAutoHeal(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("common.setAutoHeal", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getCommonCommands()._setAutoHeal_callback != null)
            {
                actionFactory.getCommonCommands()._setAutoHeal_callback.apply(this, [_local_2]);
                actionFactory.getCommonCommands()._setAutoHeal_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_rank_getCastleRank(_arg_1:Object):void
        {
            var _local_2:BaseBean = new RankCastleResponse("rank.getCastleRank", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getRankCommands()._getCastleRank_callback != null)
            {
                actionFactory.getRankCommands()._getCastleRank_callback.apply(this, [_local_2]);
                actionFactory.getRankCommands()._getCastleRank_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_dischargeChief(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("hero.dischargeChief", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._dischargeChief_callback != null)
            {
                actionFactory.getHeroCommand()._dischargeChief_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._dischargeChief_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_KickedOut(_arg_1:Object):void
        {
            var _local_2:BaseBean;
            _local_2 = new KickedOut("server.KickedOut", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (onKickedOut != null)
            {
                onKickedOut.apply(this, [_local_2]);
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
        }

        private function _resp_colony_sowDiscord(_arg_1:Object):void
        {
            var _local_2:BaseBean = new CommandResponse("colony.sowDiscord", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getColonyCommands()._sowDiscord_callback != null)
            {
                actionFactory.getColonyCommands()._sowDiscord_callback.apply(this, [_local_2]);
                actionFactory.getColonyCommands()._sowDiscord_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }

        private function _resp_hero_SetShowHeroId(_arg_1:Object):void
        {
            var _local_2:BaseBean = new SetShowInfroResponse("hero.SetShowHeroId", _arg_1);
            if (istrace)
            {
                trace(_local_2.toDebugString());
            };
            if (actionFactory.getHeroCommand()._SetShowHeroId_callback != null)
            {
                actionFactory.getHeroCommand()._SetShowHeroId_callback.apply(this, [_local_2]);
                actionFactory.getHeroCommand()._SetShowHeroId_callback = null;
            };
            if (!hasEventListener(_local_2.type))
            {
                if (istrace)
                {
                    trace((("EventListener:" + _local_2.type) + " not found!"));
                };
                dispatchEvent(new NoListenerEvent(_local_2.type, _local_2));
            }
            else
            {
                dispatchEvent(_local_2);
            };
            MouseManager.setNormal();
        }


    }
}//package com.evony.client.response

