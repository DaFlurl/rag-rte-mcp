# ============================================================================
# EVONY MEGA TOOLKIT - COMPLETE PROTOCOL (246 COMMANDS)
# ============================================================================
# Extracted from EvonyClient1921.swf decompiled source
# ============================================================================

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any
from enum import Enum
import hashlib
import struct

# ============================================================================
# ENCRYPTION KEYS (Extracted from source)
# ============================================================================
class EvonyKeys:
    ACTION_KEY = "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"
    API_KEY = "9f758e2deccbe6244f734371b9642eda"
    USER_INFO_KEY = "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"
    XOR_KEY = 0xAA
    LOGIN_SALT = "evony"
    GAME_KEY = "EvonyGameKey2009"
    NETWORK_KEY = "EvonyNetKey2009"

# ============================================================================
# GAME LIMITS (CRITICAL - Overflow thresholds)
# ============================================================================
class GameLimits:
    INT32_MAX = 2147483647
    MAX_SAFE_FOOD = 485_000_000        # Flips to 0 at 999M!
    MAX_SAFE_TROOP_SINGLE = 700_000_000
    MAX_VALLEY_TRANSPORT = 495_000_000
    
    # Troop overflow thresholds (INT32_MAX / cost)
    OVERFLOW = {
        'worker': {'cost': 50, 'threshold': 42_949_673},
        'warrior': {'cost': 75, 'threshold': 28_633_116},
        'scout': {'cost': 100, 'threshold': 21_474_837},
        'pikeman': {'cost': 200, 'threshold': 10_737_419},
        'swordsman': {'cost': 250, 'threshold': 8_589_935},
        'archer': {'cost': 350, 'threshold': 6_135_037},
        'cavalry': {'cost': 800, 'threshold': 2_684_355},
        'cataphract': {'cost': 1500, 'threshold': 1_431_656},
        'transporter': {'cost': 500, 'threshold': 4_294_967},
        'ballista': {'cost': 2000, 'threshold': 1_073_742},
        'ram': {'cost': 3000, 'threshold': 715_827},
        'catapult': {'cost': 5000, 'threshold': 429_496}
    }

# ============================================================================
# TROOP TYPES
# ============================================================================
class TroopType(Enum):
    WORKER = 0
    WARRIOR = 1
    SCOUT = 2
    PIKEMAN = 3
    SWORDSMAN = 4
    ARCHER = 5
    CAVALRY = 6
    CATAPHRACT = 7
    TRANSPORTER = 8
    BALLISTA = 9
    RAM = 10
    CATAPULT = 11

# ============================================================================
# ALL 246 PROTOCOL COMMANDS
# ============================================================================
PROTOCOL_COMMANDS = {
    # ========== ALLIANCE COMMANDS (30) ==========
    'alliance': [
        'addUsertoAlliance',
        'addUsertoAllianceList', 
        'agreeComeinAllianceByLeader',
        'agreeComeinAllianceByUser',
        'agreeComeinAllianceList',
        'canceladdUsertoAlliance',
        'cancelagreeComeinAlliance',
        'cancelUserWantInAlliance',
        'createAlliance',
        'dropAllianceFriendshipRelation',
        'getAllianceArmyReport',
        'getAllianceEventList',
        'getAllianceFriendshipList',
        'getAllianceInfo',
        'getAllianceList',
        'getAllianceMembers',
        'getAllianceWanted',
        'getMilitarySituationList',
        'getPowerFromAlliance',
        'isHasAlliance',
        'kickOutMemberfromAlliance',
        'leaderWantUserInAllianceList',
        'messagesForAllianceMember',
        'rejectComeinAlliance',
        'resetTopPowerForAlliance',
        'resignForAlliance',
        'sayByetoAlliance',
        'setAllianceFriendship',
        'setAllInfoForAlliance',
        'setPowerForUserByAlliance',
        'userWantInAlliance'
    ],
    
    # ========== ARMY COMMANDS (14) ==========
    'army': [
        'callBackArmy',
        'cureInjuredTroop',
        'disbandFleeTroop',
        'disbandInjuredTroop',
        'exerciseArmy',
        'getFleeTroop',
        'getInjuredTroop',
        'getStayAllianceArmys',
        'getTroopParam',
        'IsDropItemInCastle',
        'newArmy',
        'recruitFleeTroop',
        'setAllowAllianceArmy',
        'setArmyGoOut'
    ],
    
    # ========== CAPITAL COMMANDS (6) ==========
    'capital': [
        'getLeftPoliciesTimes',
        'getUsedPoliciesTimes',
        'levyArmy',
        'levyFood',
        'levyPopulation',
        'levyTaxes',
        'reduceArmaments'
    ],
    
    # ========== CASTLE COMMANDS (17) ==========
    'castle': [
        'cancelBuildingQueue',
        'cancleBuildCommand',
        'checkOutUpgrade',
        'deleteCastleSign',
        'demolishBuildingQueue',
        'destructBuilding',
        'getAvailableBuildingBean',
        'getAvailableBuildingListInside',
        'getAvailableBuildingListOutside',
        'getBuildingQueueCoinsNeed',
        'getCoinsNeed',
        'getDestructBuildBean',
        'newBuilding',
        'newBuildingQueue',
        'saveCastleSignList',
        'speedUpBuildCommand',
        'speedupBuildingQueue',
        'UpdateCastleResources',
        'upgradeBuilding'
    ],
    
    # ========== CELEB COMMANDS (4) ==========
    'celeb': [
        'findAllianceByPrestige',
        'findPlayerByPrestige',
        'findPlayerByStar',
        'findPlayerByTitle'
    ],
    
    # ========== CITY COMMANDS (13) ==========
    'city': [
        'advMoveCastle',
        'constructCastle',
        'getStoreList',
        'giveupCastle',
        'modifyCastleIcon',
        'modifyCastleName',
        'modifyFlag',
        'modifyStorePercent',
        'modifyUserName',
        'moveCastle',
        'setStopWarState',
        'uniteAdvMoveCastle',
        'WarMoveCastle'
    ],
    
    # ========== COLONY COMMANDS (14) ==========
    'colony': [
        'abandonColony',
        'getColonialArmyInfo',
        'getColonialCastlesInfo',
        'getDeployTroopsInfo',
        'getSuzerainColonialCastlesInfo',
        'levyArmy',
        'levyFood',
        'levyPopulation',
        'levyTaxes',
        'overviewColonialCastle',
        'reduceArmaments',
        'setDeployTroops',
        'sowDiscord',
        'speedUpAbandonColony',
        'uprise'
    ],
    
    # ========== COMMISSION QUEST COMMANDS (9) ==========
    'commission': [
        'acceptCommissionQuest',
        'addCommissionQuestArmy',
        'declineCommissionQuest',
        'getAllCommissionQuest',
        'getCommissionQuestArmyInfo',
        'getCommissionQuestArmyRanking',
        'getMyAcceptedCommissionQuest',
        'getMyCommissionQuest',
        'issueCommissionQuest'
    ],
    
    # ========== COMMON COMMANDS (45) ==========
    'common': [
        'addToFavorites',
        'allianceChat',
        'authSecurityCode',
        'cancelRemovingSecurityCodeProcess',
        'changeHeadline',
        'changeName',
        'changeSecurityCode',
        'changeUserFace',
        'channelChat',
        'createNewPlayer',
        'declaredWarAgainstPlayer',
        'deleteUserAndRestart',
        'delUniteServerPeaceStatus',
        'denyPlayerSpeak',
        'facebookConnect',
        'getCanDeclaredWarAgainstPlayer',
        'getIsSecurityCodeSetted',
        'getItemDefXml',
        'getPackage',
        'getPackageList',
        'getPackageNumber',
        'getPlayerDeclaredWarStatus',
        'getPlayerInfoByName',
        'getProtectOption',
        'getRelationship',
        'mapCastle',
        'mapInfo',
        'mapInfoSimple',
        'privateChat',
        'removeSecurityCode',
        'saveUnregisteredPlayer',
        'setAutoHeal',
        'setEovnyMember',
        'setEventDone',
        'setEvonyMemberEMail',
        'setProtectOption',
        'setReceiveIncomingAttack',
        'setReturnReport',
        'setSecurityCode',
        'setTroopConfig',
        'setUnlockOption',
        'step',
        'worldChat',
        'zoneInfo'
    ],
    
    # ========== EQUIPMENT COMMANDS (5) ==========
    'equipment': [
        'EnhancedByGemStone',
        'EnhancedStarByGemStone',
        'TakeOffAllEquipmenttech',
        'TakeOffEquipmenttech',
        'WearAllEquipmenttech',
        'WearEquipmenttech'
    ],
    
    # ========== EQUIPMENT TECH COMMANDS (5) ==========
    'equipmenttech': [
        'cancelResearch',
        'getCoinsNeed',
        'getResearchList',
        'research',
        'speedUpResearch'
    ],
    
    # ========== FIELD COMMANDS (3) ==========
    'field': [
        'getCastleFieldInfo',
        'getOtherFieldInfo',
        'giveUpField'
    ],
    
    # ========== FORTIFICATIONS COMMANDS (6) ==========
    'fortifications': [
        'accTroopProduce',
        'cancelFortificationProduce',
        'destructWallProtect',
        'getFortificationsProduceList',
        'getProduceQueue',
        'produceWallProtect'
    ],
    
    # ========== FRIEND COMMANDS (5) ==========
    'friend': [
        'addBlock',
        'addFriend',
        'deleteBlock',
        'deleteFriend',
        'isBlockMailPlayer'
    ],
    
    # ========== FURLOUGH COMMANDS (2) ==========
    'furlough': [
        'cancelFurlought',
        'isFurlought'
    ],
    
    # ========== GAMBLING RANKING COMMANDS (3) ==========
    'gamblingranking': [
        'getGamblingRankingReward',
        'getGamblingRankingToday',
        'getGamblingRankingYesterday'
    ],
    
    # ========== GAMEMASTER COMMANDS (8) - ADMIN ONLY ==========
    'gamemaster': [
        'addBuilding',
        'addHero',
        'addItems',
        'removeBuilding',
        'removeHero',
        'removeItem',
        'setResources',
        'setTechnology'
    ],
    
    # ========== HERO COMMANDS (22) ==========
    'hero': [
        'addPoint',
        'addPoint2',
        'awardGold',
        'callBackHero',
        'changeName',
        'dischargeChief',
        'fireHero',
        'GenSaveRandomHero',
        'GetDisappearHeros',
        'getFleeHeroList',
        'getHerosListFromTavern',
        'GetRandomHero',
        'hireFacebookFriendHero',
        'hireHero',
        'levelUp',
        'promoteToChief',
        'RecoverDisappearHero',
        'recruitFleeHero',
        'refreshHerosListFromTavern',
        'releaseHero',
        'resetPoint',
        'RetSetHeroAttri',
        'setHeroFacebookId',
        'SetShowHeroId',
        'ShowPlayerHerosByUserName',
        'tryGetSeizedHero',
        'useItem'
    ],
    
    # ========== INTERIOR COMMANDS (5) ==========
    'interior': [
        'getResourceProduceData',
        'modifyCommenceRate',
        'modifyTaxRate',
        'pacifyPeople',
        'taxation'
    ],
    
    # ========== MAIL COMMANDS (8) ==========
    'mail': [
        'deleteMail',
        'getAllTVMsg',
        'readMail',
        'readOverMailList',
        'receiveMailList',
        'reportBug',
        'reportPlayer',
        'sendMail'
    ],
    
    # ========== NPC HERO COMMANDS (4) ==========
    'npchero': [
        'getNpcHeroInfroByID',
        'getNpcHerosList',
        'getNpcHerosListByFilter',
        'getNpcHerosListByMoney'
    ],
    
    # ========== QUEST COMMANDS (10) ==========
    'quest': [
        'abandon',
        'accept',
        'AllowRegister',
        'award',
        'awardPacket',
        'donate',
        'getAwardItems',
        'getEffortList',
        'getEffortListByTargeTypeid',
        'getQuestList',
        'getQuestType'
    ],
    
    # ========== RANK COMMANDS (5) ==========
    'rank': [
        'getAllianceRank',
        'getCastleRank',
        'getHeroRank',
        'getPlayerRank',
        'getTopVotesPlayer',
        'getVoteRank'
    ],
    
    # ========== REPORT COMMANDS (6) ==========
    'report': [
        'deleteAllReports',
        'deleteReport',
        'markAsRead',
        'readOverReport',
        'receiveReportList',
        'shareReport'
    ],
    
    # ========== SHOP COMMANDS (9) - EXPLOIT TARGETS ==========
    'shop': [
        'buy',
        'buyResource',
        'Gem_Smelting',
        'getBuyResourceInfo',
        'useAngelItem',
        'useCastleGoods',
        'useDevilItem',
        'useGoods',  # Race condition exploit!
        'useTrickItem'
    ],
    
    # ========== STRATAGEM COMMANDS (1) ==========
    'stratagem': [
        'useStratagem'
    ],
    
    # ========== TECH COMMANDS (5) ==========
    'tech': [
        'cancelResearch',
        'getCoinsNeed',
        'getResearchList',
        'research',
        'speedUpResearch'
    ],
    
    # ========== TRADE COMMANDS (5) ==========
    'trade': [
        'cancelTrade',
        'getMyTradeList',
        'getTransingTradeList',
        'newTrade',
        'searchTrades',
        'speedUpTrans'
    ],
    
    # ========== TROOP COMMANDS (7) - OVERFLOW EXPLOITS ==========
    'troop': [
        'accTroopProduce',
        'cancelTroopProduce',
        'checkIdleBarrack',
        'disbandTroop',
        'getProduceQueue',
        'getTroopProduceList',
        'produceTroop'  # Integer overflow exploit!
    ],
    
    # ========== TRUCE COMMANDS (3) ==========
    'truce': [
        'cancelDreamTruce',
        'changeDreamTruceTime',
        'setDreamTruce'
    ],
    
    # ========== VISIT COMMANDS (6) ==========
    'visit': [
        'deleteComment',
        'getAllVisitorComments',
        'getHelpedPlayers',
        'getVisitorComments',
        'helpIncreaseProduction',
        'markCommentAsRead',
        'visitorComment'
    ],
    
    # ========== VOTE COMMANDS (2) ==========
    'vote': [
        'voteToPlayerById',
        'voteToPlayerByName'
    ]
}

# ============================================================================
# COMMAND BUILDER
# ============================================================================
@dataclass
class Command:
    category: str
    action: str
    params: Dict[str, Any] = field(default_factory=dict)
    
    @property
    def full_name(self) -> str:
        return f"{self.category}.{self.action}"
    
    def to_dict(self) -> Dict:
        return {
            'cmd': self.full_name,
            'params': self.params
        }

def build_command(category: str, action: str, **params) -> Command:
    """Build a protocol command"""
    return Command(category=category, action=action, params=params)

# ============================================================================
# EXPLOIT GENERATORS
# ============================================================================
class ExploitGenerator:
    @staticmethod
    def troop_overflow(troop_type: int, amount: int = None) -> Command:
        """Generate troop overflow exploit command"""
        troop_names = ['worker','warrior','scout','pikeman','swordsman',
                       'archer','cavalry','cataphract','transporter',
                       'ballista','ram','catapult']
        if amount is None:
            name = troop_names[troop_type]
            amount = GameLimits.OVERFLOW[name]['threshold']
        return build_command('troop', 'produceTroop',
                           troopType=troop_type, num=amount)
    
    @staticmethod
    def race_condition_item(item_id: str, count: int = 100) -> List[Command]:
        """Generate race condition exploit (rapid item use)"""
        return [build_command('shop', 'useGoods', itemId=item_id, num=1) 
                for _ in range(count)]
    
    @staticmethod
    def security_brute_force(start: int = 0, end: int = 9999) -> List[Command]:
        """Generate security code brute force commands"""
        return [build_command('common', 'authSecurityCode', 
                            code=f"{i:04d}") for i in range(start, end)]
    
    @staticmethod
    def negative_value(category: str, action: str, 
                       param_name: str, value: int = -1) -> Command:
        """Generate negative value exploit"""
        return build_command(category, action, **{param_name: value})

# ============================================================================
# STATS
# ============================================================================
def get_command_count() -> int:
    return sum(len(cmds) for cmds in PROTOCOL_COMMANDS.values())

def get_categories() -> List[str]:
    return list(PROTOCOL_COMMANDS.keys())

if __name__ == '__main__':
    print(f"Total commands: {get_command_count()}")
    print(f"Categories: {len(get_categories())}")
    for cat, cmds in PROTOCOL_COMMANDS.items():
        print(f"  {cat}: {len(cmds)} commands")
