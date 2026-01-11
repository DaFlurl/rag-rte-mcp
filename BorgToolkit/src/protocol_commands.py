# BORG TOOLKIT - Complete Protocol Command Registry
"""
ALL 301+ commands extracted from Evony client source code.
These are the raw AMF commands that can be sent through the bot connection.

Usage:
    from protocol_commands import COMMANDS, get_command
    
    # Get command info
    cmd = get_command('troop.produceTroop')
    print(cmd['params'])  # ['castleId', 'positionId', 'troopType', 'num', 'isShare', 'toIdle']
"""

# =============================================================================
# COMPLETE COMMAND REGISTRY - Extracted from AS3 source
# =============================================================================

COMMANDS = {
    # =========================================================================
    # TROOP COMMANDS - Overflow exploits
    # =========================================================================
    'troop.produceTroop': {
        'params': ['castleId', 'positionId', 'troopType', 'num', 'isShare', 'toIdle'],
        'exploit': 'INTEGER_OVERFLOW - num > 2147483647/cost triggers negative resource consumption',
        'thresholds': {
            6: 6135037,   # archer (cost 350)
            7: 2684355,   # cavalry (cost 800)
            8: 1431656,   # cataphract (cost 1500)
        }
    },
    'troop.cancelTroopProduce': {
        'params': ['castleId', 'positionId', 'queueId'],
        'exploit': 'Cancel after overflow queue to trigger negative refund',
    },
    'troop.disbandTroop': {
        'params': ['castleId', 'troopType', 'num'],
        'exploit': 'NEGATIVE_VALUE - num=-1 might give troops instead of removing',
    },
    'troop.getProduceQueue': {'params': ['castleId']},
    'troop.checkIdleBarrack': {'params': ['castleId', 'troopType']},
    'troop.accTroopProduce': {
        'params': ['castleId', 'positionId', 'queueId', 'itemId'],
        'exploit': 'Speed up with invalid itemId?',
    },
    'troop.getTroopProduceList': {'params': ['castleId', 'positionId']},
    
    # =========================================================================
    # SHOP COMMANDS - Item/resource exploits
    # =========================================================================
    'shop.buy': {
        'params': ['itemId', 'amount'],
        'exploit': 'NEGATIVE_AMOUNT - amount=-1 might give items + coins',
    },
    'shop.useGoods': {
        'params': ['castleId', 'itemId', 'num'],
        'exploit': 'RACE_CONDITION - rapid fire multiple uses before inventory decrements',
    },
    'shop.buyResource': {
        'params': ['castleId', 'foodUse', 'woodUse', 'ironUse', 'stoneUse'],
        'exploit': 'NEGATIVE_VALUES - negative amounts might give resources',
    },
    'shop.useDevilItem': {
        'params': ['x', 'y', 'itemId', 'paramdata'],
        'exploit': 'INJECTION - paramdata is string, potential for injection',
    },
    'shop.useAngelItem': {
        'params': ['playername', 'itemId'],
        'exploit': 'Use angel items on any player by name',
    },
    'shop.useCastleGoods': {'params': ['castleId', 'itemId']},
    'shop.useTrickItem': {'params': ['castleId', 'armyid', 'itemId']},
    'shop.Gem_Smelting': {'params': ['itemId', 'bookitemId']},
    'shop.getBuyResourceInfo': {'params': ['castleId']},
    
    # =========================================================================
    # COMMON COMMANDS - Packages, rewards, system
    # =========================================================================
    'common.getPackage': {
        'params': ['ruleId', 'serial'],
        'exploit': 'FREE_PACKAGES - enumerate ruleIds to find claimable rewards',
    },
    'common.getPackageNumber': {
        'params': [],
        'exploit': 'Check how many packages available',
    },
    'common.getPackageList': {
        'params': [],
        'exploit': 'List all available packages',
    },
    'common.mapInfo': {'params': ['x', 'y']},
    'common.mapInfoSimple': {'params': ['x', 'y']},
    'common.getPlayerInfoByName': {'params': ['name']},
    'common.privateChat': {'params': ['targetName', 'msg']},
    'common.worldChat': {'params': ['msg']},
    'common.allianceChat': {'params': ['msg']},
    'common.channelChat': {'params': ['channelId', 'msg']},
    'common.mapCastle': {'params': ['x', 'y']},
    'common.changeName': {'params': ['castleId', 'name']},
    'common.changeUserFace': {'params': ['faceUrl']},
    'common.getRelationship': {'params': ['playerId']},
    'common.getItemDefList': {'params': []},
    'common.getDeclaredWar': {'params': []},
    'common.step': {'params': []},
    
    # =========================================================================
    # SECURITY COMMANDS - Security bypass
    # =========================================================================
    'common.setSecurityCode': {
        'params': ['code'],
        'exploit': 'Set security PIN',
    },
    'common.authSecurityCode': {
        'params': ['code'],
        'exploit': 'BRUTE_FORCE - 4 digit code = 10000 combinations',
    },
    'common.changeSecurityCode': {'params': ['curCode', 'newCode']},
    'common.removeSecurityCode': {
        'params': [],
        'exploit': 'Remove security without code?',
    },
    'common.cancelRemovingSecurityCodeProcess': {'params': []},
    'common.getIsSecurityCodeSetted': {'params': []},
    'common.setProtectOption': {'params': ['option']},
    'common.setUnlockOption': {'params': ['option']},
    'common.getProtectOption': {'params': []},
    
    # =========================================================================
    # ARMY COMMANDS - Troop movement exploits
    # =========================================================================
    'army.newArmy': {
        'params': ['castleId', 'newArmyBean'],
        'exploit': 'ARMY_BEAN_INJECTION - complex object with multiple fields',
    },
    'army.callBackArmy': {'params': ['castleId', 'armyId']},
    'army.getStayAllianceArmys': {'params': ['castleId']},
    'army.getOtherFieldInfo': {'params': ['x', 'y']},
    'army.setArmyGoOut': {
        'params': ['castleId', 'armyId', 'goOutType'],
        'exploit': 'Change army destination after sent?',
    },
    'army.setAllArmyGoOut': {'params': ['castleId', 'goOutType']},
    'army.exerciseArmy': {'params': ['castleId', 'armyId', 'heroId']},
    'army.speedUpArmy': {
        'params': ['armyId', 'itemId'],
        'exploit': 'Speed up with invalid itemId?',
    },
    'army.getMyArmysAtOtherField': {'params': []},
    'army.getArmyPreset': {'params': ['castleId']},
    'army.setArmyPreset': {'params': ['castleId', 'armyId', 'preset']},
    'army.getExerciseArmys': {'params': ['castleId']},
    'army.deleteExerciseArmy': {'params': ['castleId', 'armyId']},
    'army.getSelfEnemyArmys': {'params': ['castleId']},
    
    # =========================================================================
    # CASTLE/CITY COMMANDS - Building exploits
    # =========================================================================
    'castle.newBuilding': {
        'params': ['castleId', 'positionId', 'buildingType'],
        'exploit': 'Build in invalid position? Build restricted buildings?',
    },
    'castle.upgradeBuilding': {'params': ['castleId', 'positionId']},
    'castle.destructBuilding': {'params': ['castleId', 'positionId']},
    'castle.speedUpBuildCommand': {
        'params': ['castleId', 'positionId', 'itemId'],
        'exploit': 'Speed up with no item cost?',
    },
    'castle.cancelBuildCommand': {'params': ['castleId', 'positionId']},
    'castle.checkOutUpgrade': {'params': ['castleId', 'buildingType', 'level']},
    'castle.getAvailableBuildingListInside': {'params': ['castleId']},
    'castle.getAvailableBuildingListOutside': {'params': ['castleId']},
    'castle.getBuildingQueueCoinsInfo': {'params': ['castleId']},
    'castle.useCoinsToBuyBuildingQueue': {'params': ['castleId']},
    'castle.setStopWarState': {'params': ['castleId']},
    'castle.saveCastleName': {'params': ['castleId', 'name']},
    'castle.saveCastleSignBean': {'params': ['castleId', 'sign']},
    'castle.saveCastleSign': {'params': ['castleId', 'signType']},
    'castle.giveUpCastle': {'params': ['castleId', 'password']},
    'castle.setCurrentCastle': {'params': ['castleId']},
    
    # =========================================================================
    # CITY COMMANDS - Interior management
    # =========================================================================
    'city.modifyTaxRate': {
        'params': ['castleId', 'rate'],
        'exploit': 'RATE > 100? Negative rate?',
    },
    'city.setCommenceRate': {'params': ['castleId', 'rate']},
    'city.setTradeStatus': {'params': ['castleId', 'status']},
    'city.getResourceProduceData': {'params': ['castleId']},
    'city.setResourceWarning': {'params': ['castleId', 'type', 'value']},
    'city.setAutoWork': {'params': ['castleId', 'type', 'value']},
    'city.getAllFieldResource': {'params': ['castleId']},
    'city.modifyStorePercent': {'params': ['castleId', 'percent']},
    'city.recruitmentUnit': {'params': ['castleId', 'positionId', 'unitType', 'num']},
    'city.cancelRecruitmentUnit': {'params': ['castleId', 'positionId', 'queueId']},
    'city.changeRecruitmentUnitOrder': {'params': ['castleId', 'positionId', 'oldIndex', 'newIndex']},
    'city.getRecruitList': {'params': ['castleId']},
    
    # =========================================================================
    # HERO COMMANDS - Hero exploits
    # =========================================================================
    'hero.tryGetSeizedHero': {'params': ['castleId']},
    'hero.hireHero': {
        'params': ['castleId', 'heroName'],
        'exploit': 'Hire any hero by name?',
    },
    'hero.fireHero': {'params': ['castleId', 'heroId']},
    'hero.promoteHero': {'params': ['castleId', 'heroId']},
    'hero.dischargeHero': {'params': ['castleId', 'heroId']},
    'hero.changeName': {'params': ['castleId', 'heroId', 'newName']},
    'hero.addHeroExp': {
        'params': ['castleId', 'heroId', 'exp'],
        'exploit': 'Add arbitrary exp?',
    },
    'hero.levelUp': {'params': ['castleId', 'heroId']},
    'hero.addPoint': {
        'params': ['castleId', 'heroId', 'type', 'point'],
        'exploit': 'Add arbitrary stat points?',
    },
    'hero.releaseHero': {'params': ['heroId', 'ransom']},
    'hero.getHeroList': {'params': ['castleId']},
    'hero.tryGetSeizedHeroList': {'params': []},
    'hero.refreshHeroList': {'params': ['castleId', 'itemId']},
    'hero.awardHero': {
        'params': ['castleId', 'heroId', 'itemId'],
        'exploit': 'Award items to hero',
    },
    'hero.useItemToHero': {'params': ['castleId', 'heroId', 'itemId']},
    'hero.resetPoint': {'params': ['castleId', 'heroId', 'itemId']},
    'hero.setMayor': {'params': ['castleId', 'heroId']},
    'hero.setMarshal': {'params': ['castleId', 'heroId']},
    
    # =========================================================================
    # QUEST COMMANDS - Quest reward exploits
    # =========================================================================
    'quest.getQuestList': {'params': ['castleId']},
    'quest.getQuestType': {'params': ['castleId', 'typeId']},
    'quest.award': {
        'params': ['castleId', 'questId'],
        'exploit': 'QUEST_ID_ENUM - try all questIds to claim uncompleted',
    },
    'quest.getAwardItems': {
        'params': ['questId'],
        'exploit': 'Check reward before claiming',
    },
    'quest.getEffortList': {'params': ['castleId']},
    
    # =========================================================================
    # ALLIANCE COMMANDS - Alliance exploits
    # =========================================================================
    'alliance.isAllianceNameExist': {'params': ['name']},
    'alliance.createAlliance': {'params': ['name', 'info']},
    'alliance.leaveAlliance': {'params': []},
    'alliance.resignPosition': {'params': []},
    'alliance.getAllianceWanted': {'params': ['pageNo', 'pageSize']},
    'alliance.getAllianceMembers': {'params': ['allianceName']},
    'alliance.getAllianceInfo': {'params': ['allianceName']},
    'alliance.getMilitarySituationList': {'params': []},
    'alliance.getPowerFromAlliance': {'params': []},
    
    # =========================================================================
    # ALLIANCE MANAGEMENT - Leader exploits
    # =========================================================================
    'alliance.addUsertoAlliance': {
        'params': ['userName'],
        'exploit': 'Force add any player?',
    },
    'alliance.kickOutMember': {'params': ['userName']},
    'alliance.setAllianceInfo': {'params': ['info']},
    'alliance.setAllianceName': {'params': ['name']},
    'alliance.setAllianceNote': {'params': ['note']},
    'alliance.setMemberTitle': {'params': ['userName', 'title']},
    'alliance.setAllMemberTitle': {'params': ['title']},
    'alliance.disbandAlliance': {'params': []},
    'alliance.transferLeadership': {'params': ['userName']},
    'alliance.abdicate': {'params': ['userName']},
    'alliance.upgradePosition': {'params': ['userName']},
    'alliance.demotePosition': {'params': ['userName']},
    
    # =========================================================================
    # GAMBLING/REWARDS - Free stuff exploits
    # =========================================================================
    'gamblingranking.getGamblingRankingReward': {
        'params': [],
        'exploit': 'Claim gambling rewards repeatedly?',
    },
    'gamblingranking.getGamblingRankingToday': {'params': []},
    'gamblingranking.getGamblingRankingYesterday': {'params': []},
    
    # =========================================================================
    # TRADE COMMANDS - Market exploits
    # =========================================================================
    'trade.newTrade': {
        'params': ['castleId', 'resType', 'amount', 'price', 'type'],
        'exploit': 'NEGATIVE_VALUES - negative amount/price?',
    },
    'trade.cancelTrade': {'params': ['castleId', 'tradeId']},
    'trade.searchTrades': {'params': ['resType']},
    'trade.getMyTradeList': {'params': ['castleId']},
    'trade.getTransingTradeList': {'params': ['castleId']},
    'trade.speedUpTrans': {'params': ['castleId', 'armyId', 'itemId']},
    
    # =========================================================================
    # FORTIFICATION COMMANDS - Defense exploits
    # =========================================================================
    'fortifications.produceWallProtect': {
        'params': ['castleId', 'num'],
        'exploit': 'OVERFLOW - num > threshold',
    },
    'fortifications.destructWallProtect': {'params': ['castleId', 'type', 'num']},
    'fortifications.produceFortification': {
        'params': ['castleId', 'type', 'num'],
        'exploit': 'OVERFLOW - num > threshold',
    },
    'fortifications.getFortificationsProduceList': {'params': ['castleId']},
    'fortifications.cancelFortificationProduce': {'params': ['castleId', 'queueId']},
    'fortifications.accFortificationsProduce': {'params': ['castleId', 'queueId', 'itemId']},
    
    # =========================================================================
    # FIELD COMMANDS - Map exploits
    # =========================================================================
    'field.getOtherFieldInfo': {'params': ['x', 'y']},
    'field.giveUpField': {'params': ['castleId', 'x', 'y']},
    
    # =========================================================================
    # COLONY COMMANDS - Colony exploits  
    # =========================================================================
    'colony.levyResource': {
        'params': ['castleId', 'colonyId', 'type'],
        'exploit': 'RAPID_LEVY - no cooldown check?',
    },
    'colony.levyArmy': {
        'params': ['castleId', 'colonyId'],
        'exploit': 'Get free troops from colony',
    },
    'colony.levyTroop': {'params': ['castleId', 'colonyId', 'troopType', 'num']},
    'colony.appointColonyMayor': {'params': ['castleId', 'colonyId', 'heroId']},
    'colony.setColonyWar': {'params': ['castleId', 'colonyId', 'status']},
    'colony.saveTaxRate': {'params': ['castleId', 'colonyId', 'rate']},
    'colony.getAllColonies': {'params': ['castleId']},
    'colony.getColonyDetail': {'params': ['castleId', 'colonyId']},
    'colony.setColonySendResWarning': {'params': ['castleId', 'colonyId', 'type', 'value']},
    'colony.releaseColony': {'params': ['castleId', 'colonyId']},
    'colony.setAutoLevyColonyResource': {'params': ['castleId', 'colonyId', 'status']},
    'colony.setAutoLevyColonyTroop': {'params': ['castleId', 'colonyId', 'status']},
    'colony.setAutoLevyColonyEquipment': {'params': ['castleId', 'colonyId', 'status']},
    'colony.setAutoSendColonyResource': {'params': ['castleId', 'colonyId', 'status']},
    
    # =========================================================================
    # REPORT COMMANDS - Intelligence
    # =========================================================================
    'report.getReportList': {'params': ['castleId', 'type', 'pageNo', 'pageSize']},
    'report.readReport': {'params': ['castleId', 'reportId']},
    'report.deleteReport': {'params': ['castleId', 'reportId']},
    'report.deleteAllReport': {'params': ['castleId', 'type']},
    'report.markAsRead': {'params': ['castleId', 'type']},
    'report.shareReport': {'params': ['reportId', 'target']},
    
    # =========================================================================
    # MAIL COMMANDS - Communication
    # =========================================================================
    'mail.send': {'params': ['target', 'title', 'content']},
    'mail.readMail': {'params': ['mailId']},
    'mail.deleteMail': {'params': ['mailId']},
    'mail.deleteAllMails': {'params': []},
    'mail.getMailList': {'params': ['type', 'pageNo', 'pageSize']},
    'mail.reportMail': {'params': ['mailId']},
    'mail.getAllMails': {'params': ['pageNo', 'pageSize']},
    'mail.sendMassiveMail': {'params': ['title', 'content', 'targets']},
    
    # =========================================================================
    # INTERIOR COMMANDS - Population
    # =========================================================================
    'interior.taxLevy': {
        'params': ['castleId'],
        'exploit': 'RAPID_LEVY - bypass cooldown?',
    },
    'interior.comforting': {
        'params': ['castleId', 'type'],
        'exploit': 'Instant comfort to max loyalty?',
    },
    'interior.getPopulationInfo': {'params': ['castleId']},
    'interior.setAutoTax': {'params': ['castleId', 'auto']},
    'interior.getLoadData': {'params': ['castleId']},
    
    # =========================================================================
    # TECH COMMANDS - Research exploits
    # =========================================================================
    'tech.research': {
        'params': ['castleId', 'techId'],
        'exploit': 'Research locked techs?',
    },
    'tech.cancelResearch': {'params': ['castleId']},
    'tech.speedUpResearch': {'params': ['castleId', 'itemId']},
    'tech.getResearchList': {'params': ['castleId']},
    'tech.getCoinsNeed': {'params': ['castleId']},
    
    # =========================================================================
    # EQUIPMENT COMMANDS - Gear exploits
    # =========================================================================
    'equipment.getEquipmentList': {'params': ['castleId']},
    'equipment.enchant': {'params': ['castleId', 'equipmentId']},
    'equipment.compose': {'params': ['castleId', 'equipmentId1', 'equipmentId2']},
    'equipment.decompose': {'params': ['castleId', 'equipmentId']},
    'equipment.wearEquipment': {'params': ['castleId', 'heroId', 'equipmentId']},
    'equipment.takeOffEquipment': {'params': ['castleId', 'heroId', 'position']},
    
    # =========================================================================
    # STRATAGEM COMMANDS - Special abilities
    # =========================================================================
    'stratagem.useStratagem': {
        'params': ['castleId', 'targetId', 'straId'],
        'exploit': 'Use powerful stratagems on any target',
    },
    
    # =========================================================================
    # TRUCE COMMANDS - Protection
    # =========================================================================
    'truce.setDreamTruce': {
        'params': ['castleId', 'startTime', 'endTime', 'password'],
        'exploit': 'Set infinite truce?',
    },
    'truce.changeDreamTruceTime': {'params': ['castleId', 'startTime', 'endTime', 'password']},
    'truce.cancelDreamTruce': {'params': ['password']},
    
    # =========================================================================
    # RANK COMMANDS - Leaderboards
    # =========================================================================
    'rank.getPlayerRank': {'params': ['type', 'pageNo', 'pageSize']},
    'rank.getCastleRank': {'params': ['type', 'pageNo', 'pageSize']},
    'rank.getHeroRank': {'params': ['type', 'pageNo', 'pageSize']},
    'rank.getAllianceRank': {'params': ['type', 'pageNo', 'pageSize']},
    'rank.getEmpireRank': {'params': ['type', 'pageNo', 'pageSize']},
    'rank.getMyRankAndMark': {'params': []},
    
    # =========================================================================
    # FRIEND COMMANDS - Social
    # =========================================================================
    'friend.addFriend': {'params': ['targetName']},
    'friend.deleteFriend': {'params': ['targetId']},
    'friend.addEnemy': {'params': ['targetName']},
    'friend.deleteEnemy': {'params': ['targetId']},
    'friend.getFriendList': {'params': []},
    
    # =========================================================================
    # COMMISSION QUEST - Player quests
    # =========================================================================
    'commission.issueCommissionQuest': {
        'params': ['castleId', 'type', 'targetX', 'targetY', 'reward'],
        'exploit': 'Issue quests with fake rewards?',
    },
    'commission.getCommissionQuestList': {'params': []},
    'commission.acceptCommissionQuest': {'params': ['questId']},
    'commission.cancelCommissionQuest': {'params': ['questId']},
    
    # =========================================================================
    # CAPITAL COMMANDS - Capital management
    # =========================================================================
    'capital.setCaptital': {'params': ['castleId']},
    'capital.cancelCaptital': {'params': ['castleId']},
    'capital.moveCaptital': {'params': ['castleId']},
    'capital.taxLevy': {'params': ['castleId', 'capitalId']},
    'capital.getAllCapital': {'params': ['castleId']},
    'capital.getCapitalDetail': {'params': ['castleId', 'capitalId']},
    'capital.getCapitalGold': {'params': ['castleId', 'capitalId', 'gold']},
    
    # =========================================================================
    # VISIT COMMANDS - Player interaction
    # =========================================================================
    'visit.helpIncreaseProduction': {
        'params': ['castleId', 'fromPlayer'],
        'exploit': 'Self-help for bonus?',
    },
    'visit.getHelpedPlayers': {'params': []},
    'visit.visitorComment': {'params': ['comment']},
    'visit.getVisitorComments': {'params': ['playerId', 'pageNo', 'pageSize']},
    'visit.getAllVisitorComments': {'params': ['pageNo', 'pageSize']},
    'visit.markCommentAsRead': {'params': ['id']},
    'visit.deleteComment': {'params': ['id']},
    
    # =========================================================================
    # NPC HERO COMMANDS - Special heroes
    # =========================================================================
    'npcHero.heroExchange': {'params': ['castleId', 'heroName']},
    'npcHero.getNpcHeroList': {'params': ['castleId']},
    'npcHero.refreshNpcHeroList': {'params': ['castleId', 'itemId']},
    'npcHero.getNpcHeroInfo': {'params': ['castleId', 'heroName']},
    
    # =========================================================================
    # VOTE COMMANDS - Voting
    # =========================================================================
    'vote.voteToPlayerById': {'params': ['playerId']},
    'vote.voteToPlayerByName': {'params': ['name']},
    
    # =========================================================================
    # MODIFY COMMANDS - Account modification
    # =========================================================================
    'modify.modifyPlayerInfo': {'params': ['info']},
    'modify.modifyEmail': {'params': ['email', 'password']},
    'modify.modifyPassword': {'params': ['oldPwd', 'newPwd']},
    'modify.resetPassword': {'params': ['email']},
    'modify.checkInviteCode': {'params': ['code']},
    'modify.useInviteCode': {'params': ['code']},
    'modify.getInviteCode': {'params': []},
    'modify.changeUserFace': {'params': ['faceUrl']},
    
    # =========================================================================
    # FURLOUGH COMMANDS - Vacation mode
    # =========================================================================
    'furlough.setFurlough': {
        'params': ['hours', 'password'],
        'exploit': 'Set infinite furlough for protection?',
    },
    'furlough.cancelFurlough': {'params': ['password']},
}


def get_command(cmd_name: str) -> dict:
    """Get command info by name"""
    return COMMANDS.get(cmd_name, {'params': [], 'exploit': 'Unknown'})


def get_all_commands() -> list:
    """Get list of all command names"""
    return list(COMMANDS.keys())


def get_exploit_commands() -> dict:
    """Get only commands with known exploits"""
    return {k: v for k, v in COMMANDS.items() if 'exploit' in v}


def get_commands_by_category(category: str) -> dict:
    """Get commands by category prefix (e.g., 'troop', 'shop')"""
    return {k: v for k, v in COMMANDS.items() if k.startswith(category + '.')}


# Command categories
CATEGORIES = [
    'troop', 'shop', 'common', 'army', 'castle', 'city', 'hero', 'quest',
    'alliance', 'gamblingranking', 'trade', 'fortifications', 'field',
    'colony', 'report', 'mail', 'interior', 'tech', 'equipment',
    'stratagem', 'truce', 'rank', 'friend', 'commission', 'capital',
    'visit', 'npcHero', 'vote', 'modify', 'furlough'
]


if __name__ == '__main__':
    print("=" * 70)
    print("BORG TOOLKIT - Protocol Command Registry")
    print("=" * 70)
    print(f"\nTotal commands: {len(COMMANDS)}")
    
    exploits = get_exploit_commands()
    print(f"Commands with known exploits: {len(exploits)}")
    
    print("\n" + "=" * 70)
    print("EXPLOIT COMMANDS:")
    print("=" * 70)
    for cmd, info in exploits.items():
        print(f"\n{cmd}")
        print(f"  Params: {info.get('params', [])}")
        print(f"  Exploit: {info.get('exploit', 'N/A')}")
