// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.factory.ImageManager

package com.evony.factory
{
    import view.castle.world.FieldImageMc;
    import com.evony.common.constants.TFConstants;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.common.constants.TechConstants;
    import com.evony.common.constants.CommonConstants;
    import view.castle.PLayerBuffConstants;
    import com.evony.common.constants.HeroConstants;

    public class ImageManager 
    {

        private static var instance:ImageManager = new (ImageManager)();

        private var techLogoMap:Object;

        private var troopSmallLogoMap:Object = new Object();
        private var troopLargeLogoMap:Object = new Object();
        private var resourceLogoMap:Object = new Object();
        private var fortSmallLogoMap:Object = new Object();
        private var fortBigLogoMap:Object = new Object();
        private var commonImgMap:Object = new Object();
        private var heroStatusImgMap:Object = new Object();
        private var allianceLevelMap:Object = new Object();
        private var bufferMap:Object = new Object();

        public function ImageManager()
        {
            this.initTechLogo();
            this.initTroopSmallLogo();
            this.initTroopLargeLogo();
            this.initResourceLogoMap();
            this.initFortBigLogoMap();
            this.initFortSmallLogoMap();
            this.initCommonImgMap();
            this.initAllianceLevelMap();
            this.initBufferMap();
            this.initHeroStatusImgMap();
        }

        public static function getAllianceLevelMap(_arg_1:int):Object
        {
            return (instance.allianceLevelMap[_arg_1]);
        }

        public static function getBufferMap(_arg_1:String):Object
        {
            return (instance.bufferMap[_arg_1]);
        }

        public static function getCommonImg(_arg_1:String):Object
        {
            return (instance.commonImgMap[_arg_1]);
        }

        public static function getFortBigLogo(_arg_1:int):Object
        {
            return (instance.fortBigLogoMap[_arg_1]);
        }

        public static function getResourceLogo(_arg_1:String):Object
        {
            return (instance.resourceLogoMap[_arg_1]);
        }

        public static function getFortSmallLogo(_arg_1:int):Object
        {
            return (instance.fortSmallLogoMap[_arg_1]);
        }

        public static function getMcFieldImg(_arg_1:int, _arg_2:int):Object
        {
            var _local_3:FieldImageMc = new FieldImageMc();
            _local_3.setFieldType(_arg_1, 10, _arg_2);
            return (_local_3);
        }

        public static function getTroopSmallLogo(_arg_1:int):Object
        {
            return (instance.troopSmallLogoMap[_arg_1]);
        }

        public static function getTechLogo(_arg_1:int):Object
        {
            return (instance.techLogoMap[_arg_1]);
        }

        public static function getTroopLargeLogo(_arg_1:int):Object
        {
            return (instance.troopLargeLogoMap[_arg_1]);
        }

        public static function getHeroStatusImgMap(_arg_1:int):Object
        {
            return (instance.heroStatusImgMap[_arg_1]);
        }

        public static function getFieldImg(_arg_1:int, _arg_2:int):Object
        {
            var _local_3:FieldImageMc = new FieldImageMc();
            _local_3.setFieldType(_arg_1, _arg_2, 4);
            return (_local_3);
        }


        private function initTroopLargeLogo():void
        {
            this.troopLargeLogoMap[TFConstants.T_PEASANTS] = "images/icon/army/Peasants.png";
            this.troopLargeLogoMap[TFConstants.T_MILITIA] = "images/icon/army/militia.png";
            this.troopLargeLogoMap[TFConstants.T_SCOUTER] = "images/icon/army/scouter.png";
            this.troopLargeLogoMap[TFConstants.T_PIKEMAN] = "images/icon/army/Pikeman.png";
            this.troopLargeLogoMap[TFConstants.T_SWORDSMEN] = "images/icon/army/swordsmen.png";
            this.troopLargeLogoMap[TFConstants.T_ARCHER] = "images/icon/army/Archer.png";
            this.troopLargeLogoMap[TFConstants.T_LIGHTCAVALRY] = "images/icon/army/lightCavalry.png";
            this.troopLargeLogoMap[TFConstants.T_HEAVYCAVALRY] = "images/icon/army/heavyCavalry.png";
            this.troopLargeLogoMap[TFConstants.T_CARRIAGE] = "images/icon/army/carriage.png";
            this.troopLargeLogoMap[TFConstants.T_BALLISTA] = "images/icon/army/Ballista.png";
            this.troopLargeLogoMap[TFConstants.T_BATTERINGRAM] = "images/icon/army/BatteringRam.png";
            this.troopLargeLogoMap[TFConstants.T_CATAPULT] = "images/icon/army/Catapult.png";
        }

        private function initFortSmallLogoMap():void
        {
            this.fortSmallLogoMap[TFConstants.F_TRAP] = "images/Controls/tab/icon_t4_1.png";
            this.fortSmallLogoMap[TFConstants.F_ABATIS] = "images/Controls/tab/icon_t4_2.png";
            this.fortSmallLogoMap[TFConstants.F_ARROWTOWER] = "images/Controls/tab/icon_t4_3.png";
            this.fortSmallLogoMap[TFConstants.F_ROLLINGLOGS] = "images/Controls/tab/icon_t4_4.png";
            this.fortSmallLogoMap[TFConstants.F_ROCKFALL] = "images/Controls/tab/icon_t4_5.png";
        }

        private function initAllianceLevelMap():void
        {
            allianceLevelMap[AllianceConstants.TOP_POWER_FOR_ALLIANCE] = "images/EmbedImages/alliance/lv5.png";
            allianceLevelMap[AllianceConstants.TOP2_POWER_FOR_ALLIANCE] = "images/EmbedImages/alliance/lv4.png";
            allianceLevelMap[AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE] = "images/EmbedImages/alliance/lv3.png";
            allianceLevelMap[AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE] = "images/EmbedImages/alliance/lv2.png";
            allianceLevelMap[AllianceConstants.LAST_POWER_FOR_ALLIANCE] = "images/EmbedImages/alliance/lv1.png";
        }

        private function initTroopSmallLogo():void
        {
            this.troopSmallLogoMap[TFConstants.T_PEASANTS] = "images/Controls/tab/icon_t3_1.png";
            this.troopSmallLogoMap[TFConstants.T_MILITIA] = "images/Controls/tab/icon_t3_7.png";
            this.troopSmallLogoMap[TFConstants.T_SCOUTER] = "images/Controls/tab/icon_t3_2.png";
            this.troopSmallLogoMap[TFConstants.T_PIKEMAN] = "images/Controls/tab/icon_t3_8.png";
            this.troopSmallLogoMap[TFConstants.T_SWORDSMEN] = "images/Controls/tab/icon_t3_3.png";
            this.troopSmallLogoMap[TFConstants.T_ARCHER] = "images/Controls/tab/icon_t3_9.png";
            this.troopSmallLogoMap[TFConstants.T_LIGHTCAVALRY] = "images/Controls/tab/icon_t3_4.png";
            this.troopSmallLogoMap[TFConstants.T_HEAVYCAVALRY] = "images/Controls/tab/icon_t3_10.png";
            this.troopSmallLogoMap[TFConstants.T_CARRIAGE] = "images/Controls/tab/icon_t3_5.png";
            this.troopSmallLogoMap[TFConstants.T_BALLISTA] = "images/Controls/tab/icon_t3_11.png";
            this.troopSmallLogoMap[TFConstants.T_BATTERINGRAM] = "images/Controls/tab/icon_t3_6.png";
            this.troopSmallLogoMap[TFConstants.T_CATAPULT] = "images/Controls/tab/icon_t3_12.png";
        }

        private function initTechLogo():void
        {
            var _local_1:Object = new Object();
            _local_1[TechConstants.CROP_TECH] = "images/dynamicImages/tech/CropTech.png";
            _local_1[TechConstants.HEW_TECH] = "images/dynamicImages/tech/HewTech.png";
            _local_1[TechConstants.EXCAVATION_TECH] = "images/dynamicImages/tech/ExcavationTech.png";
            _local_1[TechConstants.SMELT_TECH] = "images/dynamicImages/tech/SmeltTech.png";
            _local_1[TechConstants.MAKE_TECH] = "images/dynamicImages/tech/MakeTech.png";
            _local_1[TechConstants.SCOUT_SKILL] = "images/dynamicImages/tech/ScoutSkill.png";
            _local_1[TechConstants.TRAIN_SKILL] = "images/dynamicImages/tech/TrainSkill.png";
            _local_1[TechConstants.COMBAT_SKILL] = "images/dynamicImages/tech/CombatSkill.png";
            _local_1[TechConstants.DEFEND_SKILL] = "images/dynamicImages/tech/DefendSkill.png";
            _local_1[TechConstants.LOAD_TECH] = "images/dynamicImages/tech/LoadTech.png";
            _local_1[TechConstants.MARCH_SKILL] = "images/dynamicImages/tech/MarchSkill.png";
            _local_1[TechConstants.DRIVE_SKILL] = "images/dynamicImages/tech/DriveSkill.png";
            _local_1[TechConstants.THROW_SKILL] = "images/dynamicImages/tech/ThrowSkill.png";
            _local_1[TechConstants.STORE_TECH] = "images/dynamicImages/tech/StoreTech.png";
            _local_1[TechConstants.SUPPLY_SKILL] = "images/dynamicImages/tech/SupplySkill.png";
            _local_1[TechConstants.BUILD_TECH] = "images/dynamicImages/tech/BuildTech.png";
            _local_1[TechConstants.FORTIFICATION_TECH] = "images/dynamicImages/tech/FortificationTech.png";
            _local_1[TechConstants.REPAIR_TECH] = "images/dynamicImages/tech/RepairTech.png";
            _local_1[TechConstants.HARRY_SKILL] = "images/dynamicImages/tech/HarrySkill.png";
            this.techLogoMap = _local_1;
        }

        private function initResourceLogoMap():void
        {
            this.resourceLogoMap["food"] = "images/Controls/tab/icon_t1_1.png";
            this.resourceLogoMap["iron"] = "images/Controls/tab/icon_t1_4.png";
            this.resourceLogoMap["stone"] = "images/Controls/tab/icon_t1_3.png";
            this.resourceLogoMap["wood"] = "images/Controls/tab/icon_t1_2.png";
            this.resourceLogoMap["gold"] = "images/Controls/Icon/CityInfo/icon_16.png";
        }

        private function initCommonImgMap():void
        {
            commonImgMap[CommonConstants.ITEM_MEDAL_ID] = "images/icon/shop/Medal.png";
        }

        private function initBufferMap():void
        {
            bufferMap[PLayerBuffConstants.PLAYER_NEW_BUFF] = "images/EmbedImages/buffer/newPlayer.png";
            bufferMap[PLayerBuffConstants.INCFOODPRODUCE_BUFF] = "images/EmbedImages/buffer/food.png";
            bufferMap[PLayerBuffConstants.INCIRONPRODUCE_BUFF] = "images/EmbedImages/buffer/iron.png";
            bufferMap[PLayerBuffConstants.INCSTONEPRODUCE_BUFF] = "images/EmbedImages/buffer/stone.png";
            bufferMap[PLayerBuffConstants.INCWOODPRODUCE_BUFF] = "images/EmbedImages/buffer/lumber.png";
            bufferMap[PLayerBuffConstants.INCGOLDPRODUCE_BUFF] = "images/EmbedImages/buffer/gold.png";
            bufferMap[PLayerBuffConstants.PLAYERINCARMYATTACH_BUFF] = "images/EmbedImages/buffer/attack.png";
            bufferMap[PLayerBuffConstants.PLAYERINCARMYDEFENCE_BUFF] = "images/EmbedImages/buffer/defence.png";
            bufferMap[PLayerBuffConstants.PLAYERPEACE_BUFF] = "images/EmbedImages/buffer/peace.png";
            bufferMap[PLayerBuffConstants.PLAYERNOPEACE_BUFF] = "images/EmbedImages/buffer/nopeace.png";
            bufferMap[PLayerBuffConstants.PLAYERPEACECOOLDOWN_BUFF] = "images/EmbedImages/buffer/cooldownpeace.png";
            bufferMap[PLayerBuffConstants.TROOPRELIVE_BUFF] = "images/EmbedImages/buffer/penicillin.png";
            bufferMap[PLayerBuffConstants.KEEPSILENCE_BUFF] = "images/EmbedImages/buffer/jinyan.png";
            bufferMap[PLayerBuffConstants.RITUALOFPACTBUF] = "images/EmbedImages/buffer/ritualOfPactBuf.png";
            bufferMap[PLayerBuffConstants.RITUALOFPACTDELAYBUF] = "images/EmbedImages/buffer/ritualOfPactDelayBuf.png";
            bufferMap[PLayerBuffConstants.RITUALOFPACTBUFX] = "images/EmbedImages/buffer/ritualOfPactBufX.png";
            bufferMap[PLayerBuffConstants.RITUALOFPACTDELAYBUFX] = "images/EmbedImages/buffer/ritualOfPactDelayBufX.png";
            bufferMap[PLayerBuffConstants.RITUALOFPACTBUFXX] = "images/EmbedImages/buffer/ritualOfPactBufXX.png";
            bufferMap[PLayerBuffConstants.RITUALOFPACTDELAYBUFXX] = "images/EmbedImages/buffer/ritualOfPactDelayBufXX.png";
        }

        private function initFortBigLogoMap():void
        {
            this.fortBigLogoMap[TFConstants.F_TRAP] = "images/icon/fortification/64xianjing.png";
            this.fortBigLogoMap[TFConstants.F_ABATIS] = "images/icon/fortification/64juma.png";
            this.fortBigLogoMap[TFConstants.F_ARROWTOWER] = "images/icon/fortification/64jianta.png";
            this.fortBigLogoMap[TFConstants.F_ROLLINGLOGS] = "images/icon/fortification/64gunmu.png";
            this.fortBigLogoMap[TFConstants.F_ROCKFALL] = "images/icon/fortification/64leishi.png";
        }

        private function initHeroStatusImgMap():void
        {
            heroStatusImgMap[HeroConstants.HERO_FREE_STATU] = "images/EmbedImages/castleInfo/heroStatus/spare.png";
            heroStatusImgMap[HeroConstants.HERO_CHIEF_STATU] = "images/EmbedImages/castleInfo/heroStatus/mayor.png";
            heroStatusImgMap[HeroConstants.HERO_GUARD_STATU] = "images/EmbedImages/castleInfo/heroStatus/camp.png";
            heroStatusImgMap[HeroConstants.HERO_SEND_STATU] = "images/EmbedImages/castleInfo/heroStatus/march.png";
            heroStatusImgMap[HeroConstants.HERO_BACK_STATU] = "images/EmbedImages/castleInfo/heroStatus/march.png";
            heroStatusImgMap[HeroConstants.HERO_SEIZED_STATU] = "images/EmbedImages/castleInfo/heroStatus/captive.png";
        }


    }
}//package com.evony.factory

