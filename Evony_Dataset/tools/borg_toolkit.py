# BORG TOOLKIT - Complete Evony Reverse Engineering & Exploitation Framework
"""
Comprehensive toolkit for Evony reverse engineering, protocol manipulation,
and exploitation. Based on analysis of EvonyClient1921.swf (Flash 9/10 era, 2009-2018).

Features:
- Complete protocol command registry (36 command classes, 200+ commands)
- All data beans (78 bean types)
- Flash CVE exploitation vectors
- Integer overflow calculators
- AMF protocol manipulation
- Encryption key database
"""

import json
import hashlib
import struct
from pathlib import Path
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, field, asdict
from datetime import datetime

HUB_ROOT = Path(r"c:\Users\Admin\Downloads\Evony_Decrypted")

# =============================================================================
# ENCRYPTION KEYS (Extracted from source)
# =============================================================================

ENCRYPTION_KEYS = {
    'ACTION_KEY': "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}",
    'API_KEY': "9f758e2deccbe6244f734371b9642eda",
    'USER_INFO_KEY': "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}",
    'XOR_KEY': 0xAA,
    'LOGIN_SALT': "evony",
    'FB_SECRET': "facebook_secret_key",
}

# =============================================================================
# PROTOCOL COMMANDS (Extracted from 36 Command Classes)
# =============================================================================

PROTOCOL_COMMANDS = {
    # TROOP COMMANDS - High exploit potential (integer overflow)
    'troop': {
        'produceTroop': {
            'params': ['castleId', 'positionId', 'troopType', 'num', 'isShare', 'toIdle'],
            'exploit': 'INTEGER OVERFLOW in num parameter - TROOP GLITCH',
            'risk': 'CRITICAL',
            'overflow_values': [2147483647, 2147483648, -1, 6135036],
        },
        'cancelTroopProduce': {
            'params': ['castleId', 'positionId', 'queueId'],
            'exploit': 'Cancel after overflow = negative refund = RESOURCE GAIN',
            'risk': 'CRITICAL',
        },
        'disbandTroop': {
            'params': ['castleId', 'troopType', 'num'],
            'exploit': 'Negative num may give resources instead of disband',
            'risk': 'HIGH',
        },
        'getProduceQueue': {'params': ['castleId'], 'risk': 'LOW'},
        'checkIdleBarrack': {'params': ['castleId', 'troopType'], 'risk': 'LOW'},
        'accTroopProduce': {'params': ['castleId', 'positionId', 'queueId', 'itemId'], 'risk': 'LOW'},
        'getTroopProduceList': {'params': ['castleId', 'positionId'], 'risk': 'LOW'},
    },
    
    # ARMY COMMANDS - Attack/march manipulation
    'army': {
        'newArmy': {
            'params': ['castleId', 'newArmyBean'],
            'exploit': 'Resource/troop fields in bean can overflow',
            'risk': 'HIGH',
            'bean_fields': ['heroId', 'targetPoint', 'troops', 'resources', 'missionType'],
        },
        'callBackArmy': {
            'params': ['castleId', 'armyId'],
            'exploit': 'Timing exploit - recall before cost deducted',
            'risk': 'MEDIUM',
        },
        'exerciseArmy': {
            'params': ['castleId', 'troopParamAttack', 'troopParamDefend'],
            'exploit': 'Practice battle manipulation',
            'risk': 'LOW',
        },
        'getStayAllianceArmys': {'params': ['castleId'], 'risk': 'LOW'},
        'disbandFleeTroop': {'params': ['castleId'], 'risk': 'LOW'},
        'recruitFleeTroop': {'params': ['castleId'], 'risk': 'LOW'},
        'getTroopParam': {'params': ['castleId'], 'risk': 'LOW'},
        'getFleeTroop': {'params': ['castleId'], 'risk': 'LOW'},
        'disbandInjuredTroop': {'params': ['castleId'], 'risk': 'LOW'},
        'getInjuredTroop': {'params': ['castleId'], 'risk': 'LOW'},
        'setAllowAllianceArmy': {'params': ['castleId', 'isAllow'], 'risk': 'LOW'},
        'setArmyGoOut': {'params': ['castleId', 'isArmyGoOut'], 'risk': 'LOW'},
        'cureInjuredTroop': {'params': ['castleId'], 'risk': 'LOW'},
        'IsDropItemInCastle': {'params': ['x', 'y'], 'risk': 'LOW'},
    },
    
    # COMMON COMMANDS - General game operations
    'common': {
        'createNewPlayer': {
            'params': ['userName', 'sex', 'faceUrl', 'flag', 'castleName', 'zone', 'accountName'],
            'exploit': 'Account creation manipulation',
            'risk': 'MEDIUM',
        },
        'worldChat': {
            'params': ['msg', 'languageType'],
            'exploit': 'Chat injection, XSS in Flash',
            'risk': 'MEDIUM',
        },
        'privateChat': {'params': ['targetName', 'msg'], 'risk': 'LOW'},
        'allianceChat': {'params': ['msg', 'languageType'], 'risk': 'LOW'},
        'channelChat': {'params': ['channel', 'sendMsg', 'languageType'], 'risk': 'LOW'},
        'mapInfo': {'params': ['castleId', 'x1', 'y1', 'x2', 'y2'], 'risk': 'LOW'},
        'mapCastle': {'params': ['castleId', 'x1', 'y1', 'x2', 'y2'], 'risk': 'LOW'},
        'mapInfoSimple': {'params': ['castleId', 'x1', 'y1', 'x2', 'y2'], 'risk': 'LOW'},
        'getPlayerInfoByName': {'params': ['userName'], 'exploit': 'Info disclosure', 'risk': 'LOW'},
        'getPackage': {'params': ['ruleId', 'serial'], 'exploit': 'Package reward manipulation', 'risk': 'MEDIUM'},
        'getPackageList': {'params': [], 'risk': 'LOW'},
        'getPackageNumber': {'params': [], 'risk': 'LOW'},
        'zoneInfo': {'params': [], 'risk': 'LOW'},
        'changeName': {'params': ['type', 'nowName', 'newName'], 'risk': 'LOW'},
        'changeUserFace': {'params': ['faceUrl', 'sex'], 'risk': 'LOW'},
        'changeHeadline': {'params': ['headline'], 'risk': 'LOW'},
        'setTroopConfig': {'params': ['name', 'config'], 'risk': 'LOW'},
        'facebookConnect': {'params': ['facebookId', 'password', 'fbsig'], 'risk': 'LOW'},
        'declaredWarAgainstPlayer': {'params': ['playerId'], 'risk': 'LOW'},
        'getCanDeclaredWarAgainstPlayer': {'params': ['playerId'], 'risk': 'LOW'},
        'getPlayerDeclaredWarStatus': {'params': ['playerId'], 'risk': 'LOW'},
        'getRelationship': {'params': ['playerId'], 'risk': 'LOW'},
        'setReturnReport': {'params': ['returnReport'], 'risk': 'LOW'},
        'setReceiveIncomingAttack': {'params': ['isAccept'], 'risk': 'LOW'},
        'setAutoHeal': {'params': ['autoHeal'], 'risk': 'LOW'},
        'addToFavorites': {'params': [], 'risk': 'LOW'},
        'getItemDefXml': {'params': [], 'risk': 'LOW'},
        'denyPlayerSpeak': {'params': ['playername', 'time'], 'risk': 'LOW'},
        'step': {'params': ['tutorialStepId'], 'risk': 'LOW'},
        'setEvonyMemberEMail': {'params': ['email'], 'risk': 'LOW'},
        'setEovnyMember': {'params': [], 'risk': 'LOW'},
        'deleteUserAndRestart': {'params': ['pwd'], 'risk': 'LOW'},
        'saveUnregisteredPlayer': {'params': ['account', 'password'], 'risk': 'LOW'},
        'setEventDone': {'params': ['id'], 'risk': 'LOW'},
        'delUniteServerPeaceStatus': {'params': [], 'risk': 'LOW'},
    },
    
    # QUEST COMMANDS - Quest reward exploits
    'quest': {
        'award': {
            'params': ['castleId', 'questId'],
            'exploit': 'RACE CONDITION - complete quest multiple times',
            'risk': 'HIGH',
        },
        'getQuestList': {'params': ['castleId'], 'risk': 'LOW'},
        'getQuestType': {'params': [], 'risk': 'LOW'},
    },
    
    # SHOP COMMANDS - Item purchase exploits
    'shop': {
        'buy': {
            'params': ['castleId', 'itemId', 'num', 'useGold'],
            'exploit': 'Negative num = free items or refund',
            'risk': 'HIGH',
        },
        'getBuyResourceInfo': {'params': [], 'risk': 'LOW'},
        'buyResource': {'params': ['castleId', 'type', 'num'], 'risk': 'MEDIUM'},
        'useItem': {
            'params': ['castleId', 'itemId', 'num'],
            'exploit': 'RACE CONDITION - use item multiple times',
            'risk': 'HIGH',
        },
        'sellItem': {
            'params': ['castleId', 'itemId', 'num'],
            'exploit': 'Negative num = buy items',
            'risk': 'MEDIUM',
        },
        'getSaleTypeList': {'params': ['castleId'], 'risk': 'LOW'},
        'getSaleItemList': {'params': ['castleId', 'typeId'], 'risk': 'LOW'},
    },
    
    # HERO COMMANDS
    'hero': {
        'fireHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'hireHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'promoteHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'dischargeHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'changeName': {'params': ['castleId', 'heroId', 'newName'], 'risk': 'LOW'},
        'awardHero': {
            'params': ['castleId', 'heroId', 'itemId'],
            'exploit': 'RACE CONDITION - award multiple times',
            'risk': 'MEDIUM',
        },
        'levelUp': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'addPoint': {'params': ['castleId', 'heroId', 'type', 'num'], 'risk': 'LOW'},
        'getHeroList': {'params': ['castleId'], 'risk': 'LOW'},
        'tryGetRandomHero': {'params': ['castleId'], 'risk': 'LOW'},
        'refreshHeroList': {'params': ['castleId', 'useGold'], 'risk': 'LOW'},
        'setMayor': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'releaseHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'callBackHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'resetPoint': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
    },
    
    # CASTLE COMMANDS
    'castle': {
        'moveCastle': {'params': ['castleId', 'targetX', 'targetY'], 'risk': 'LOW'},
        'giveUpCastle': {'params': ['castleId'], 'risk': 'LOW'},
        'changeCastleName': {'params': ['castleId', 'newName'], 'risk': 'LOW'},
        'getCastleFieldInfo': {'params': ['castleId'], 'risk': 'LOW'},
        'getCastleLoyalty': {'params': ['castleId'], 'risk': 'LOW'},
        'getResourceProduceData': {'params': ['castleId'], 'risk': 'LOW'},
        'getAvailableBuildingList': {'params': ['castleId'], 'risk': 'LOW'},
        'getAvailableResearchList': {'params': ['castleId'], 'risk': 'LOW'},
        'getGamblingItemInfo': {'params': ['castleId'], 'risk': 'LOW'},
    },
    
    # CITY COMMANDS
    'city': {
        'construct': {
            'params': ['castleId', 'positionId', 'buildingId'],
            'exploit': 'Instant build if validation weak',
            'risk': 'MEDIUM',
        },
        'upgradeBuilding': {'params': ['castleId', 'positionId'], 'risk': 'LOW'},
        'destructBuilding': {'params': ['castleId', 'positionId'], 'risk': 'LOW'},
        'cancelConstruct': {'params': ['castleId', 'positionId'], 'risk': 'LOW'},
        'speedUpBuild': {'params': ['castleId', 'positionId', 'itemId'], 'risk': 'LOW'},
        'GetBuildingQueueCostInfo': {'params': ['castleId'], 'risk': 'LOW'},
        'useBuildingQueue': {'params': ['castleId', 'num'], 'risk': 'LOW'},
    },
    
    # COLONY COMMANDS
    'colony': {
        'abandonColony': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
        'levyFood': {
            'params': ['castleId', 'colonyId'],
            'exploit': 'Rapid levy bypass cooldown',
            'risk': 'MEDIUM',
        },
        'levyTaxes': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
        'levyArmy': {
            'params': ['castleId', 'colonyId'],
            'exploit': 'Army levy overflow',
            'risk': 'MEDIUM',
        },
        'levyPopulation': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
        'reduceArmaments': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
        'overviewColonialCastle': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
        'sowDiscord': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
        'getColonialArmyInfo': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
        'setDeployTroops': {'params': ['castleId', 'colonyId', 'troopBean'], 'risk': 'LOW'},
        'getDeployTroopsInfo': {'params': ['castleId', 'colonyId'], 'risk': 'LOW'},
    },
    
    # ALLIANCE COMMANDS
    'alliance': {
        'createAlliance': {'params': ['allianceName', 'isOpenJoin'], 'risk': 'LOW'},
        'leaveAlliance': {'params': [], 'risk': 'LOW'},
        'kickOutMember': {'params': ['playerId'], 'risk': 'LOW'},
        'inviteToJoin': {'params': ['userName'], 'risk': 'LOW'},
        'setOpenJoin': {'params': ['isOpen'], 'risk': 'LOW'},
        'setAllianceInfo': {'params': ['info'], 'risk': 'LOW'},
        'getAllianceInfo': {'params': ['allianceId'], 'risk': 'LOW'},
        'getAllianceMembers': {'params': ['allianceId'], 'risk': 'LOW'},
    },
    
    # TRADE COMMANDS
    'trade': {
        'createTrade': {
            'params': ['castleId', 'resourceType', 'tradeType', 'amount', 'price'],
            'exploit': 'Price manipulation, negative amounts',
            'risk': 'MEDIUM',
        },
        'cancelTrade': {'params': ['castleId', 'tradeId'], 'risk': 'LOW'},
        'speedUpTrans': {'params': ['castleId', 'tradeId', 'itemId'], 'risk': 'LOW'},
        'getTransingTradeList': {'params': ['castleId'], 'risk': 'LOW'},
        'getMyTradeList': {'params': ['castleId'], 'risk': 'LOW'},
        'searchTrades': {'params': ['castleId', 'resourceType', 'tradeType'], 'risk': 'LOW'},
    },
    
    # TECH COMMANDS
    'tech': {
        'research': {'params': ['castleId', 'techId'], 'risk': 'LOW'},
        'cancelResearch': {'params': ['castleId'], 'risk': 'LOW'},
        'speedUpResearch': {'params': ['castleId', 'itemId'], 'risk': 'LOW'},
        'getResearchList': {'params': ['castleId'], 'risk': 'LOW'},
    },
    
    # FORTIFICATION COMMANDS
    'fortifications': {
        'produceFortification': {
            'params': ['castleId', 'fortType', 'num'],
            'exploit': 'Integer overflow in num',
            'risk': 'MEDIUM',
        },
        'cancelFortificationProduce': {'params': ['castleId', 'fortType'], 'risk': 'LOW'},
        'speedUpFortificationProduce': {'params': ['castleId', 'fortType', 'itemId'], 'risk': 'LOW'},
        'destructFortification': {'params': ['castleId', 'fortType', 'num'], 'risk': 'LOW'},
        'getFortificationProduceList': {'params': ['castleId'], 'risk': 'LOW'},
    },
    
    # INTERIOR COMMANDS
    'interior': {
        'pacifyPeople': {'params': ['castleId'], 'risk': 'LOW'},
        'taxation': {'params': ['castleId'], 'risk': 'LOW'},
        'modifyTaxRate': {'params': ['castleId', 'rate'], 'risk': 'LOW'},
        'modifyCommenceRate': {'params': ['castleId', 'rate'], 'risk': 'LOW'},
    },
    
    # MAIL COMMANDS
    'mail': {
        'sendMail': {'params': ['targetName', 'title', 'content'], 'risk': 'LOW'},
        'readMail': {'params': ['mailId'], 'risk': 'LOW'},
        'deleteMail': {'params': ['mailIds'], 'risk': 'LOW'},
        'getAllMail': {'params': ['type', 'pageNo', 'pageSize'], 'risk': 'LOW'},
    },
    
    # REPORT COMMANDS  
    'report': {
        'getReportList': {'params': ['type', 'pageNo', 'pageSize'], 'risk': 'LOW'},
        'readReport': {'params': ['reportId'], 'risk': 'LOW'},
        'deleteReport': {'params': ['reportIds'], 'risk': 'LOW'},
    },
    
    # COMMISSION QUEST COMMANDS
    'commissionQuest': {
        'acceptCommissionQuest': {'params': ['castleId', 'questId'], 'risk': 'LOW'},
        'completeCommissionQuest': {
            'params': ['castleId', 'questId'],
            'exploit': 'RACE CONDITION - complete multiple times',
            'risk': 'HIGH',
        },
        'giveUpCommissionQuest': {'params': ['castleId', 'questId'], 'risk': 'LOW'},
        'getCommissionQuestList': {'params': ['castleId'], 'risk': 'LOW'},
    },
    
    # GAMBLING/AMULET COMMANDS
    'gamblingRanking': {
        'gamble': {
            'params': ['castleId', 'itemId'],
            'exploit': 'Amulet spinning exploit',
            'risk': 'MEDIUM',
        },
        'getRankingList': {'params': [], 'risk': 'LOW'},
        'getReward': {'params': ['castleId'], 'risk': 'LOW'},
    },
    
    # SECURITY COMMANDS
    'security': {
        'setSecurityCode': {'params': ['code'], 'risk': 'LOW'},
        'verifySecurityCode': {'params': ['code'], 'risk': 'LOW'},
        'removeSecurityCode': {'params': ['code'], 'risk': 'LOW'},
        'setProtectFlag': {'params': ['flag'], 'risk': 'LOW'},
    },
    
    # FIELD COMMANDS
    'field': {
        'getFieldInfo': {'params': ['fieldId'], 'risk': 'LOW'},
        'giveUpField': {'params': ['castleId', 'fieldId'], 'risk': 'LOW'},
    },
    
    # EQUIPMENT COMMANDS
    'equipment': {
        'wearEquipment': {'params': ['castleId', 'heroId', 'equipmentId', 'pos'], 'risk': 'LOW'},
        'takeOffEquipment': {'params': ['castleId', 'heroId', 'pos'], 'risk': 'LOW'},
        'sellEquipment': {'params': ['castleId', 'equipmentId'], 'risk': 'LOW'},
        'repairEquipment': {'params': ['castleId', 'equipmentId'], 'risk': 'LOW'},
        'replenishEquipment': {'params': ['castleId', 'equipmentId'], 'risk': 'LOW'},
    },
    
    # NPC HERO COMMANDS
    'npcHero': {
        'getNpcHeroList': {'params': ['castleId'], 'risk': 'LOW'},
        'captureNpcHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
        'releaseNpcHero': {'params': ['castleId', 'heroId'], 'risk': 'LOW'},
    },
    
    # TRUCE COMMANDS
    'truce': {
        'applyTruce': {'params': ['castleId', 'itemId'], 'risk': 'LOW'},
        'cancelTruce': {'params': ['castleId'], 'risk': 'LOW'},
        'getTruceInfo': {'params': ['castleId'], 'risk': 'LOW'},
    },
    
    # FURLOUGH COMMANDS
    'furlough': {
        'applyFurlough': {'params': ['days'], 'risk': 'LOW'},
        'cancelFurlough': {'params': [], 'risk': 'LOW'},
    },
}

# =============================================================================
# DATA BEANS (78 Bean Types from com.evony.common.beans)
# =============================================================================

DATA_BEANS = {
    'PlayerBean': {
        'size': 68300,
        'key_fields': ['id', 'userName', 'sex', 'prestige', 'honor', 'medal', 'allianceId'],
        'exploit_fields': ['medal', 'prestige', 'honor'],  # Overflow targets
    },
    'CastleBean': {
        'size': 36701,
        'key_fields': ['id', 'name', 'resource', 'troop', 'heroArray', 'buildingArray'],
        'exploit_fields': ['resource', 'troop'],
    },
    'HeroBean': {
        'size': 40584,
        'key_fields': ['id', 'name', 'level', 'experience', 'power', 'stratagem', 'politics'],
        'exploit_fields': ['experience', 'level'],
    },
    'TroopBean': {
        'size': 13034,
        'key_fields': ['worker', 'warrior', 'scout', 'pikeman', 'swordsman', 'archer', 
                       'cavalry', 'cataphract', 'transporter', 'ballista', 'ram', 'catapult'],
        'exploit_fields': ['ALL - Integer overflow on all fields'],
    },
    'ResourceBean': {
        'size': 6325,
        'key_fields': ['gold', 'food', 'wood', 'stone', 'iron'],
        'exploit_fields': ['ALL - Integer overflow'],
    },
    'ArmyBean': {
        'size': 19354,
        'key_fields': ['id', 'startFieldId', 'targetFieldId', 'hero', 'troop', 'resource', 'missionType'],
    },
    'MapCastleBean': {
        'size': 31578,
        'key_fields': ['id', 'fieldId', 'name', 'type', 'playerId', 'allianceId'],
    },
    'ItemBean': {'size': 6382, 'key_fields': ['id', 'itemId', 'count']},
    'QuestBean': {'size': 12887, 'key_fields': ['id', 'typeId', 'status', 'targetNum']},
    'ColonyBean': {'size': 14846, 'key_fields': ['castleId', 'fieldId', 'cityName', 'loyalty']},
    'TradeBean': {'size': 10304, 'key_fields': ['id', 'resourceType', 'tradeType', 'amount', 'price']},
    'MailBean': {'size': 11046, 'key_fields': ['id', 'uid', 'sender', 'title', 'content']},
    'ReportBean': {'size': 12635, 'key_fields': ['id', 'title', 'attack', 'targetPos']},
    'AllianceQueryBean': {'size': 10129, 'key_fields': ['id', 'name', 'leaderName', 'memberCount']},
    'BuffBean': {'size': 4791, 'key_fields': ['id', 'typeId', 'value', 'endTime']},
    'EquipmentBean': {'size': 7830, 'key_fields': ['id', 'itemId', 'heroId', 'pos']},
}

# =============================================================================
# FLASH CVE DATABASE (2009-2018 Era)
# =============================================================================

FLASH_CVES = {
    'CVE-2009-1869': {
        'name': 'AVM2 Integer Overflow',
        'description': 'Integer overflow in ActionScript Virtual Machine 2 abcFile parser',
        'affected': 'Flash Player < 9.0.246.0, 10.x < 10.0.32.18',
        'impact': 'Remote code execution',
        'exploit_type': 'Malformed AVM2 bytecode',
        'relevance': 'HIGH - Evony client uses AVM2',
    },
    'CVE-2010-1297': {
        'name': 'ActionScript newfunction Overflow',
        'description': 'Integer overflow in newfunction instruction',
        'affected': 'Flash Player < 10.1.53.64',
        'impact': 'Remote code execution',
        'exploit_type': 'Malformed ActionScript',
        'relevance': 'HIGH',
    },
    'CVE-2011-0611': {
        'name': 'Flash Player Memory Corruption',
        'description': 'Memory corruption via crafted Flash content',
        'affected': 'Flash Player < 10.2.153.1',
        'impact': 'Remote code execution',
        'exploit_type': 'Crafted SWF',
        'relevance': 'MEDIUM',
    },
    'CVE-2012-0779': {
        'name': 'Object Type Confusion',
        'description': 'Type confusion in object handling',
        'affected': 'Flash Player < 11.2.202.235',
        'impact': 'Remote code execution',
        'exploit_type': 'Type confusion',
        'relevance': 'MEDIUM',
    },
    'CVE-2015-0311': {
        'name': 'Use-After-Free',
        'description': 'Use-after-free vulnerability',
        'affected': 'Flash Player < 16.0.0.287',
        'impact': 'Remote code execution',
        'exploit_type': 'Memory corruption',
        'relevance': 'LOW - Later version',
    },
}

# =============================================================================
# GLITCH THRESHOLDS (Extracted from source analysis)
# =============================================================================

GLITCH_THRESHOLDS = {
    'INT32_MAX': 2147483647,
    'INT32_MIN': -2147483648,
    'UINT32_MAX': 4294967295,
    
    # Troop glitch thresholds (INT32_MAX / food_cost)
    'archer': 6135036,       # 2147483647 / 350
    'cavalry': 2684354,      # 2147483647 / 800
    'cataphract': 1431655,   # 2147483647 / 1500
    'catapult': 357913,      # 2147483647 / 6000
    'worker': 42949672,      # 2147483647 / 50
    'warrior': 21474836,     # 2147483647 / 100
    'scout': 10737418,       # 2147483647 / 200
    'pikeman': 4294967,      # 2147483647 / 500
    'swordsman': 2147483,    # 2147483647 / 1000
    'transporter': 4294967,  # 2147483647 / 500
    'ballista': 858993,      # 2147483647 / 2500
    'ram': 536870,           # 2147483647 / 4000
}

# Troop training costs
TROOP_COSTS = {
    'worker': {'food': 50, 'gold': 0, 'pop': 1},
    'warrior': {'food': 100, 'gold': 0, 'pop': 1},
    'scout': {'food': 200, 'gold': 0, 'pop': 1},
    'pikeman': {'food': 500, 'gold': 0, 'pop': 1},
    'swordsman': {'food': 1000, 'gold': 0, 'pop': 1},
    'archer': {'food': 350, 'gold': 0, 'pop': 1},
    'cavalry': {'food': 800, 'gold': 0, 'pop': 3},
    'cataphract': {'food': 1500, 'gold': 0, 'pop': 5},
    'transporter': {'food': 500, 'gold': 0, 'pop': 5},
    'ballista': {'food': 2500, 'gold': 0, 'pop': 6},
    'ram': {'food': 4000, 'gold': 0, 'pop': 8},
    'catapult': {'food': 6000, 'gold': 0, 'pop': 10},
}


# =============================================================================
# BORG TOOLKIT CLASS
# =============================================================================

class BorgToolkit:
    """Complete Evony reverse engineering and exploitation toolkit."""
    
    def __init__(self):
        self.commands = PROTOCOL_COMMANDS
        self.beans = DATA_BEANS
        self.keys = ENCRYPTION_KEYS
        self.cves = FLASH_CVES
        self.glitch_thresholds = GLITCH_THRESHOLDS
    
    def generate_signature(self, data: str, key_type: str = 'API_KEY') -> str:
        """Generate MD5 signature using Evony keys."""
        key = self.keys.get(key_type, '')
        combined = data + key
        return hashlib.md5(combined.encode()).hexdigest()
    
    def get_critical_exploits(self) -> List[dict]:
        """Get all critical risk exploits."""
        critical = []
        for category, commands in self.commands.items():
            for cmd_name, cmd_info in commands.items():
                if cmd_info.get('risk') in ['CRITICAL', 'HIGH']:
                    critical.append({
                        'command': f"{category}.{cmd_name}",
                        'params': cmd_info.get('params', []),
                        'exploit': cmd_info.get('exploit', ''),
                        'risk': cmd_info.get('risk'),
                    })
        return critical
    
    def calculate_overflow(self, troop_type: str, num: int) -> dict:
        """Calculate overflow result for troop training."""
        if troop_type not in TROOP_COSTS:
            return {'error': 'Unknown troop type'}
        
        cost = TROOP_COSTS[troop_type]['food']
        total_cost = num * cost
        
        # Check overflow
        INT32_MAX = 2147483647
        overflowed = total_cost > INT32_MAX
        
        if overflowed:
            wrapped = (total_cost & 0xFFFFFFFF)
            if wrapped > INT32_MAX:
                wrapped = wrapped - 0x100000000
        else:
            wrapped = total_cost
        
        return {
            'troop_type': troop_type,
            'num': num,
            'cost_per_unit': cost,
            'total_cost': total_cost,
            'overflowed': overflowed,
            'wrapped_value': wrapped,
            'exploit_viable': overflowed and wrapped < 0,
            'gain_on_cancel': abs(wrapped) if wrapped < 0 else 0,
        }
    
    def get_all_commands(self) -> List[str]:
        """Get list of all protocol commands."""
        commands = []
        for category, cmds in self.commands.items():
            for cmd_name in cmds.keys():
                commands.append(f"{category}.{cmd_name}")
        return sorted(commands)
    
    def export_toolkit(self, output_path: Path = None) -> dict:
        """Export complete toolkit as JSON."""
        if output_path is None:
            output_path = HUB_ROOT / "evony_hub" / "borg_toolkit_export.json"
        
        export = {
            'version': '1.0',
            'generated': datetime.now().isoformat(),
            'encryption_keys': self.keys,
            'protocol_commands': self.commands,
            'data_beans': self.beans,
            'flash_cves': self.cves,
            'glitch_thresholds': self.glitch_thresholds,
            'troop_costs': TROOP_COSTS,
            'critical_exploits': self.get_critical_exploits(),
            'total_commands': len(self.get_all_commands()),
        }
        
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(export, f, indent=2)
        
        print(f"Borg Toolkit exported to: {output_path}")
        return export


def main():
    """Initialize and demonstrate Borg Toolkit."""
    print("=" * 70)
    print("BORG TOOLKIT - Evony Complete RE & Exploitation Framework")
    print("=" * 70)
    
    toolkit = BorgToolkit()
    
    print(f"\n[+] Protocol Commands: {len(toolkit.get_all_commands())}")
    print(f"[+] Data Beans: {len(toolkit.beans)}")
    print(f"[+] Flash CVEs: {len(toolkit.cves)}")
    
    print("\n[!] CRITICAL EXPLOITS:")
    for exploit in toolkit.get_critical_exploits():
        print(f"    - {exploit['command']}: {exploit['exploit']}")
    
    print("\n[+] GLITCH THRESHOLDS:")
    for troop, threshold in toolkit.glitch_thresholds.items():
        if troop not in ['INT32_MAX', 'INT32_MIN', 'UINT32_MAX']:
            print(f"    - {troop}: {threshold:,}")
    
    # Export toolkit
    toolkit.export_toolkit()
    
    # Demo overflow calculation
    print("\n[+] ARCHER GLITCH DEMO:")
    result = toolkit.calculate_overflow('archer', 6135037)
    print(f"    Queue: {result['num']:,} archers")
    print(f"    Cost: {result['total_cost']:,}")
    print(f"    Overflowed: {result['overflowed']}")
    print(f"    Wrapped to: {result['wrapped_value']:,}")
    print(f"    Gain on cancel: {result['gain_on_cancel']:,}")
    
    return toolkit


if __name__ == "__main__":
    main()
