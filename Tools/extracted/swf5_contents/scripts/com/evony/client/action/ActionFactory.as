package com.evony.client.action
{
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.Sender;
   
   public class ActionFactory
   {
      private static var _instance:ActionFactory = new ActionFactory();
      
      private var truceCommands:TruceCommands;
      
      private var tradeCommands:TradeCommands;
      
      private var capitalCommands:CapitalCommands;
      
      private var cityCommands:CityCommands;
      
      private var stratagemCommands:StratagemCommands;
      
      private var equipmentCommands:EquipmentCommands;
      
      private var armyCommands:ArmyCommands;
      
      private var friendCommands:FriendCommands;
      
      private var npcHeroCommand:NpcHeroCommand;
      
      private var interiorCommands:InteriorCommands;
      
      private var modifyCommands:ModifyCommands;
      
      private var mailCommands:MailCommands;
      
      private var commissionQuestCommands:CommissionQuestCommands;
      
      private var allianceManagementCommands:AllianceManagementCommands;
      
      private var fortificationsCommands:FortificationsCommands;
      
      private var questCommands:QuestCommands;
      
      private var commonCommands:CommonCommands;
      
      private var shopCommands:ShopCommands;
      
      private var castleCommands:CastleCommands;
      
      private var colonyCommands:ColonyCommands;
      
      private var gamblingRankingCommands:GamblingRankingCommands;
      
      private var castleSignCommand:CastleSignCommand;
      
      private var furloughCommands:FurloughCommands;
      
      private var equipmenttechCommands:EquipmenttechCommands;
      
      private var rankCommands:RankCommands;
      
      private var techCommand:TechCommand;
      
      private var celebRankCommands:CelebRankCommands;
      
      private var reportCommands:ReportCommands;
      
      private var allianceCommands:AllianceCommands;
      
      private var securityCommands:SecurityCommands;
      
      private var voteToPlayerCommands:VoteToPlayerCommands;
      
      private var heroCommand:HeroCommand;
      
      private var visitCommands:VisitCommands;
      
      private var fieldCommand:FieldCommand;
      
      private var troopCommands:TroopCommands;
      
      public function ActionFactory()
      {
         super();
         this.allianceCommands = new AllianceCommands();
         this.allianceManagementCommands = new AllianceManagementCommands();
         this.armyCommands = new ArmyCommands();
         this.capitalCommands = new CapitalCommands();
         this.castleCommands = new CastleCommands();
         this.castleSignCommand = new CastleSignCommand();
         this.celebRankCommands = new CelebRankCommands();
         this.cityCommands = new CityCommands();
         this.colonyCommands = new ColonyCommands();
         this.commissionQuestCommands = new CommissionQuestCommands();
         this.commonCommands = new CommonCommands();
         this.securityCommands = new SecurityCommands();
         this.equipmentCommands = new EquipmentCommands();
         this.equipmenttechCommands = new EquipmenttechCommands();
         this.fieldCommand = new FieldCommand();
         this.fortificationsCommands = new FortificationsCommands();
         this.friendCommands = new FriendCommands();
         this.furloughCommands = new FurloughCommands();
         this.gamblingRankingCommands = new GamblingRankingCommands();
         this.modifyCommands = new ModifyCommands();
         this.heroCommand = new HeroCommand();
         this.interiorCommands = new InteriorCommands();
         this.mailCommands = new MailCommands();
         this.npcHeroCommand = new NpcHeroCommand();
         this.questCommands = new QuestCommands();
         this.rankCommands = new RankCommands();
         this.reportCommands = new ReportCommands();
         this.shopCommands = new ShopCommands();
         this.stratagemCommands = new StratagemCommands();
         this.techCommand = new TechCommand();
         this.tradeCommands = new TradeCommands();
         this.troopCommands = new TroopCommands();
         this.truceCommands = new TruceCommands();
         this.visitCommands = new VisitCommands();
         this.voteToPlayerCommands = new VoteToPlayerCommands();
      }
      
      public static function getInstance() : ActionFactory
      {
         return _instance;
      }
      
      public function getCastleSignCommand() : CastleSignCommand
      {
         return this.castleSignCommand;
      }
      
      public function getEquipmenttechCommands() : EquipmenttechCommands
      {
         return this.equipmenttechCommands;
      }
      
      public function getShopCommands() : ShopCommands
      {
         return this.shopCommands;
      }
      
      public function getCelebRankCommands() : CelebRankCommands
      {
         return this.celebRankCommands;
      }
      
      public function getCommissionQuestCommands() : CommissionQuestCommands
      {
         return this.commissionQuestCommands;
      }
      
      public function getFurloughCommands() : FurloughCommands
      {
         return this.furloughCommands;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.allianceCommands.setSender(param1);
         this.allianceManagementCommands.setSender(param1);
         this.armyCommands.setSender(param1);
         this.capitalCommands.setSender(param1);
         this.castleCommands.setSender(param1);
         this.castleSignCommand.setSender(param1);
         this.celebRankCommands.setSender(param1);
         this.cityCommands.setSender(param1);
         this.colonyCommands.setSender(param1);
         this.commissionQuestCommands.setSender(param1);
         this.commonCommands.setSender(param1);
         this.securityCommands.setSender(param1);
         this.equipmentCommands.setSender(param1);
         this.equipmenttechCommands.setSender(param1);
         this.fieldCommand.setSender(param1);
         this.fortificationsCommands.setSender(param1);
         this.friendCommands.setSender(param1);
         this.furloughCommands.setSender(param1);
         this.gamblingRankingCommands.setSender(param1);
         this.modifyCommands.setSender(param1);
         this.heroCommand.setSender(param1);
         this.interiorCommands.setSender(param1);
         this.mailCommands.setSender(param1);
         this.npcHeroCommand.setSender(param1);
         this.questCommands.setSender(param1);
         this.rankCommands.setSender(param1);
         this.reportCommands.setSender(param1);
         this.shopCommands.setSender(param1);
         this.stratagemCommands.setSender(param1);
         this.techCommand.setSender(param1);
         this.tradeCommands.setSender(param1);
         this.troopCommands.setSender(param1);
         this.truceCommands.setSender(param1);
         this.visitCommands.setSender(param1);
         this.voteToPlayerCommands.setSender(param1);
         ResponseDispatcher.getInstance().setSender(param1);
      }
      
      public function getVisitCommands() : VisitCommands
      {
         return this.visitCommands;
      }
      
      public function getFriendCommands() : FriendCommands
      {
         return this.friendCommands;
      }
      
      public function getRankCommands() : RankCommands
      {
         return this.rankCommands;
      }
      
      public function getTroopCommands() : TroopCommands
      {
         return this.troopCommands;
      }
      
      public function getNpcHeroCommand() : NpcHeroCommand
      {
         return this.npcHeroCommand;
      }
      
      public function getTruceCommands() : TruceCommands
      {
         return this.truceCommands;
      }
      
      public function getAllianceCommands() : AllianceCommands
      {
         return this.allianceCommands;
      }
      
      public function getTradeCommands() : TradeCommands
      {
         return this.tradeCommands;
      }
      
      public function getModifyCommands() : ModifyCommands
      {
         return this.modifyCommands;
      }
      
      public function getSecurityCommands() : SecurityCommands
      {
         return this.securityCommands;
      }
      
      public function getStratagemCommands() : StratagemCommands
      {
         return this.stratagemCommands;
      }
      
      public function getFieldCommand() : FieldCommand
      {
         return this.fieldCommand;
      }
      
      public function getVoteToPlayerCommands() : VoteToPlayerCommands
      {
         return this.voteToPlayerCommands;
      }
      
      public function getAllianceManagementCommands() : AllianceManagementCommands
      {
         return this.allianceManagementCommands;
      }
      
      public function getFortificationsCommands() : FortificationsCommands
      {
         return this.fortificationsCommands;
      }
      
      public function getEquipmentCommands() : EquipmentCommands
      {
         return this.equipmentCommands;
      }
      
      public function getGamblingRankingCommands() : GamblingRankingCommands
      {
         return this.gamblingRankingCommands;
      }
      
      public function getCityCommands() : CityCommands
      {
         return this.cityCommands;
      }
      
      public function getCommonCommands() : CommonCommands
      {
         return this.commonCommands;
      }
      
      public function getCastleCommands() : CastleCommands
      {
         return this.castleCommands;
      }
      
      public function getColonyCommands() : ColonyCommands
      {
         return this.colonyCommands;
      }
      
      public function getTechCommand() : TechCommand
      {
         return this.techCommand;
      }
      
      public function getArmyCommands() : ArmyCommands
      {
         return this.armyCommands;
      }
      
      public function getHeroCommand() : HeroCommand
      {
         return this.heroCommand;
      }
      
      public function getInteriorCommands() : InteriorCommands
      {
         return this.interiorCommands;
      }
      
      public function getReportCommands() : ReportCommands
      {
         return this.reportCommands;
      }
      
      public function getCapitalCommands() : CapitalCommands
      {
         return this.capitalCommands;
      }
      
      public function getMailCommands() : MailCommands
      {
         return this.mailCommands;
      }
      
      public function getQuestCommands() : QuestCommands
      {
         return this.questCommands;
      }
   }
}

