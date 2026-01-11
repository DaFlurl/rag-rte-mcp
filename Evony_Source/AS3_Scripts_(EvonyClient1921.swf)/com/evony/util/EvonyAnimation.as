// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.EvonyAnimation

package com.evony.util
{
    import mx.core.UIComponent;
    import flash.display.Sprite;
    import com.evony.common.constants.FieldConstants;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import com.evony.common.constants.BuildingConstants;
    import flash.display.MovieClip;
    import mx.core.Application;
    import flash.display.DisplayObject;

    public class EvonyAnimation extends UIComponent 
    {

        public static const POS_TOWNHALL:int = 12;
        public static const POS_WALL:int = 33;
        public static const POS_CITY_THUMBNAIL:int = 40;
        public static const TYPE_LOZENGE_SMALL:int = -2;
        public static const TYPE_LOZENGE_BIG:int = -1;
        public static const TYPE_CottageCLv1:int = 0;
        public static const TYPE_CottageStructCLv1:int = 1;
        public static const TYPE_CottageCLv2:int = 2;
        public static const TYPE_CottageStructCLv2:int = 3;
        public static const TYPE_CottageCLv3:int = 4;
        public static const TYPE_CottageStructCLv3:int = 5;
        public static const TYPE_CottageCLv4:int = 6;
        public static const TYPE_CottageStructCLv4:int = 7;
        public static const TYPE_StoreHouseCLv1:int = 8;
        public static const TYPE_StoreHouseStructCLv1:int = 9;
        public static const TYPE_StoreHouseCLv2:int = 10;
        public static const TYPE_StoreHouseStructCLv2:int = 11;
        public static const TYPE_StoreHouseCLv3:int = 12;
        public static const TYPE_StoreHouseStructCLv3:int = 13;
        public static const TYPE_StoreHouseCLv4:int = 14;
        public static const TYPE_StoreHouseStructCLv4:int = 15;
        public static const TYPE_InnCLv1:int = 16;
        public static const TYPE_InnStructCLv1:int = 17;
        public static const TYPE_InnCLv2:int = 18;
        public static const TYPE_InnStructCLv2:int = 19;
        public static const TYPE_InnCLv3:int = 20;
        public static const TYPE_InnStructCLv3:int = 21;
        public static const TYPE_InnCLv4:int = 22;
        public static const TYPE_InnStructCLv4:int = 23;
        public static const TYPE_MarketPlaceCLv1:int = 24;
        public static const TYPE_MarketPlaceStructCLv1:int = 25;
        public static const TYPE_MarketPlaceCLv2:int = 26;
        public static const TYPE_MarketPlaceStructCLv2:int = 27;
        public static const TYPE_MarketPlaceCLv3:int = 28;
        public static const TYPE_MarketPlaceStructCLv3:int = 29;
        public static const TYPE_MarketPlaceCLv4:int = 30;
        public static const TYPE_MarketPlaceStructCLv4:int = 31;
        public static const TYPE_WatchTowerCLv1:int = 32;
        public static const TYPE_WatchTowerStructCLv1:int = 33;
        public static const TYPE_WatchTowerCLv2:int = 34;
        public static const TYPE_WatchTowerStructCLv2:int = 35;
        public static const TYPE_WatchTowerCLv3:int = 36;
        public static const TYPE_WatchTowerStructCLv3:int = 37;
        public static const TYPE_WatchTowerCLv4:int = 38;
        public static const TYPE_WatchTowerStructCLv4:int = 39;
        public static const TYPE_ReleifStationCLv1:int = 40;
        public static const TYPE_ReleifStationStructCLv1:int = 41;
        public static const TYPE_ReleifStationCLv2:int = 42;
        public static const TYPE_ReleifStationStructCLv2:int = 43;
        public static const TYPE_ReleifStationCLv3:int = 44;
        public static const TYPE_ReleifStationStructCLv3:int = 45;
        public static const TYPE_ReleifStationCLv4:int = 46;
        public static const TYPE_ReleifStationStructCLv4:int = 47;
        public static const TYPE_ForgeCLv1:int = 48;
        public static const TYPE_ForgeStructCLv1:int = 49;
        public static const TYPE_ForgeCLv2:int = 50;
        public static const TYPE_ForgeStructCLv2:int = 51;
        public static const TYPE_ForgeCLv3:int = 52;
        public static const TYPE_ForgeStructCLv3:int = 53;
        public static const TYPE_ForgeCLv4:int = 54;
        public static const TYPE_ForgeStructCLv4:int = 55;
        public static const TYPE_RallyPointCLv1:int = 56;
        public static const TYPE_RallyPointStructCLv1:int = 57;
        public static const TYPE_RallyPointCLv2:int = 58;
        public static const TYPE_RallyPointStructCLv2:int = 59;
        public static const TYPE_RallyPointCLv3:int = 60;
        public static const TYPE_RallyPointStructCLv3:int = 61;
        public static const TYPE_RallyPointCLv4:int = 62;
        public static const TYPE_RallyPointStructCLv4:int = 63;
        public static const TYPE_FeastingHallCLv1:int = 64;
        public static const TYPE_FeastingHallStructCLv1:int = 65;
        public static const TYPE_FeastingHallCLv2:int = 66;
        public static const TYPE_FeastingHallStructCLv2:int = 67;
        public static const TYPE_FeastingHallCLv3:int = 68;
        public static const TYPE_FeastingHallStructCLv3:int = 69;
        public static const TYPE_FeastingHallCLv4:int = 70;
        public static const TYPE_FeastingHallStructCLv4:int = 71;
        public static const TYPE_EmbassyCLv1:int = 72;
        public static const TYPE_EmbassyStructCLv1:int = 73;
        public static const TYPE_EmbassyCLv2:int = 74;
        public static const TYPE_EmbassyStructCLv2:int = 75;
        public static const TYPE_EmbassyCLv3:int = 76;
        public static const TYPE_EmbassyStructCLv3:int = 77;
        public static const TYPE_EmbassyCLv4:int = 78;
        public static const TYPE_EmbassyStructCLv4:int = 79;
        public static const TYPE_BarracksCLv1:int = 80;
        public static const TYPE_BarracksStructCLv1:int = 81;
        public static const TYPE_BarracksCLv2:int = 82;
        public static const TYPE_BarracksStructCLv2:int = 83;
        public static const TYPE_BarracksCLv3:int = 84;
        public static const TYPE_BarracksStructCLv3:int = 85;
        public static const TYPE_BarracksCLv4:int = 86;
        public static const TYPE_BarracksStructCLv4:int = 87;
        public static const TYPE_StablesCLv1:int = 88;
        public static const TYPE_StablesStructCLv1:int = 89;
        public static const TYPE_StablesCLv2:int = 90;
        public static const TYPE_StablesStructCLv2:int = 91;
        public static const TYPE_StablesCLv3:int = 92;
        public static const TYPE_StablesStructCLv3:int = 93;
        public static const TYPE_StablesCLv4:int = 94;
        public static const TYPE_StablesStructCLv4:int = 95;
        public static const TYPE_AcademyCLv1:int = 96;
        public static const TYPE_AcademyStructCLv1:int = 97;
        public static const TYPE_AcademyCLv2:int = 98;
        public static const TYPE_AcademyStructCLv2:int = 99;
        public static const TYPE_AcademyCLv3:int = 100;
        public static const TYPE_AcademyStructCLv3:int = 101;
        public static const TYPE_AcademyCLv4:int = 102;
        public static const TYPE_AcademyStructCLv4:int = 103;
        public static const TYPE_WorkShopCLv1:int = 104;
        public static const TYPE_WorkShopStructCLv1:int = 105;
        public static const TYPE_WorkShopCLv2:int = 106;
        public static const TYPE_WorkShopStructCLv2:int = 107;
        public static const TYPE_WorkShopCLv3:int = 108;
        public static const TYPE_WorkShopStructCLv3:int = 109;
        public static const TYPE_WorkShopCLv4:int = 110;
        public static const TYPE_WorkShopStructCLv4:int = 111;
        public static const TYPE_WallCLv1:int = 112;
        public static const TYPE_WallStructCLv1:int = 113;
        public static const TYPE_WallCLv2:int = 114;
        public static const TYPE_WallStructCLv2:int = 115;
        public static const TYPE_WallCLv3:int = 116;
        public static const TYPE_WallStructCLv3:int = 117;
        public static const TYPE_WallCLv4:int = 118;
        public static const TYPE_WallStructCLv4:int = 119;
        public static const TYPE_TownhallCLv1:int = 120;
        public static const TYPE_TownhallStructCLv1:int = 121;
        public static const TYPE_TownhallCLv2:int = 122;
        public static const TYPE_TownhallStructCLv2:int = 123;
        public static const TYPE_TownhallCLv3:int = 124;
        public static const TYPE_TownhallStructCLv3:int = 125;
        public static const TYPE_TownhallCLv4:int = 126;
        public static const TYPE_TownhallStructCLv4:int = 127;
        public static const TYPE_TownviewFloorTile:int = 128;
        public static const TYPE_FarmCLv1:int = 129;
        public static const TYPE_FarmStructCLv1:int = 130;
        public static const TYPE_FarmCLv2:int = 131;
        public static const TYPE_FarmStructCLv2:int = 132;
        public static const TYPE_FarmCLv3:int = 133;
        public static const TYPE_FarmStructCLv3:int = 134;
        public static const TYPE_FarmCLv4:int = 135;
        public static const TYPE_FarmStructCLv4:int = 136;
        public static const TYPE_StoneCLv1:int = 137;
        public static const TYPE_StoneStructCLv1:int = 138;
        public static const TYPE_StoneCLv2:int = 139;
        public static const TYPE_StoneStructCLv2:int = 140;
        public static const TYPE_StoneCLv3:int = 141;
        public static const TYPE_StoneStructCLv3:int = 142;
        public static const TYPE_StoneCLv4:int = 143;
        public static const TYPE_StoneStructCLv4:int = 144;
        public static const TYPE_IronCLv1:int = 145;
        public static const TYPE_IronStructCLv1:int = 146;
        public static const TYPE_IronCLv2:int = 147;
        public static const TYPE_IronStructCLv2:int = 148;
        public static const TYPE_IronCLv3:int = 149;
        public static const TYPE_IronStructCLv3:int = 150;
        public static const TYPE_IronCLv4:int = 151;
        public static const TYPE_IronStructCLv4:int = 152;
        public static const TYPE_LumberCLv1:int = 153;
        public static const TYPE_LumberStructCLv1:int = 154;
        public static const TYPE_LumberCLv2:int = 155;
        public static const TYPE_LumberStructCLv2:int = 156;
        public static const TYPE_LumberCLv3:int = 157;
        public static const TYPE_LumberStructCLv3:int = 158;
        public static const TYPE_LumberCLv4:int = 159;
        public static const TYPE_LumberStructCLv4:int = 160;
        public static const TYPE_ForestLv1:int = 161;
        public static const TYPE_ForestLv2:int = 162;
        public static const TYPE_ForestLv3:int = 163;
        public static const TYPE_SwampLv1:int = 164;
        public static const TYPE_SwampLv2:int = 165;
        public static const TYPE_SwampLv3:int = 166;
        public static const TYPE_MountainLv1:int = 167;
        public static const TYPE_MountainLv2:int = 168;
        public static const TYPE_MountainLv3:int = 169;
        public static const TYPE_DesertLv1:int = 170;
        public static const TYPE_DesertLv2:int = 171;
        public static const TYPE_DesertLv3:int = 172;
        public static const TYPE_GrassLv1:int = 173;
        public static const TYPE_GrassLv2:int = 174;
        public static const TYPE_GrassLv3:int = 175;
        public static const TYPE_LakeLv1:int = 176;
        public static const TYPE_LakeLv2:int = 177;
        public static const TYPE_LakeLv3:int = 178;
        public static const TYPE_CastleLvl:int = 179;
        public static const TYPE_CastleLv2:int = 180;
        public static const TYPE_CastleLv3:int = 181;
        public static const TYPE_CastleLv4:int = 182;
        public static const TYPE_FlatLv1:int = 183;
        public static const TYPE_HistoryCastleLv1:int = 186;
        public static const TYPE_HistoryCastleLv2:int = 185;
        public static const TYPE_HistoryCastleLv3:int = 184;
        public static const TYPE_HistoryCastleLv4:int = 187;
        public static const TYPE_CityViewFloorTile:int = 188;
        public static const TYPE_MapViewFloorTile:int = 189;
        public static const TYPE_HammerIn:int = 190;
        public static const TYPE_HammerOut:int = 191;
        public static const TYPE_HammerOver:int = 192;
        public static const TYPE_HammerClick:int = 193;
        public static const TYPE_constructFrontDown:int = 194;
        public static const TYPE_constructFrontUp:int = 195;
        public static const TYPE_constructBackDown:int = 196;
        public static const TYPE_constructBackUp:int = 197;
        public static const TYPE_constructTWFrontDown:int = 198;
        public static const TYPE_constructTWFrontUp:int = 199;
        public static const TYPE_constructTWBackDown:int = 200;
        public static const TYPE_constructTWBackUp:int = 201;
        public static const TYPE_Cloud:int = 202;
        public static const TYPE_OuterSpace:int = 203;
        public static const TYPE_ArrowSign:int = 204;
        public static const TYPE_Banner:int = 205;
        public static const TYPE_MyHost:int = 206;
        public static const TYPE_Select:int = 207;
        public static const TYPE_FieldImageMc:int = 208;
        public static const TYPE_BuildingLogo:int = 209;
        public static const TYPE_Cottageloginlevel2:int = 210;
        public static const TYPE_Cottageloginlevel3:int = 211;
        public static const TYPE_Cottageloginlevel4:int = 212;
        public static const TYPE_StoreHouseloginlevel2:int = 213;
        public static const TYPE_StoreHouseloginlevel3:int = 214;
        public static const TYPE_StoreHouseloginlevel4:int = 215;
        public static const TYPE_Innloginlevel2:int = 216;
        public static const TYPE_Innloginlevel3:int = 217;
        public static const TYPE_Innloginlevel4:int = 218;
        public static const TYPE_MarketPlaceloginlevel2:int = 219;
        public static const TYPE_MarketPlaceloginlevel3:int = 220;
        public static const TYPE_MarketPlaceloginlevel4:int = 221;
        public static const TYPE_WatchTowerloginlevel2:int = 222;
        public static const TYPE_WatchTowerloginlevel3:int = 223;
        public static const TYPE_WatchTowerloginlevel4:int = 224;
        public static const TYPE_ReleifStationloginlevel2:int = 225;
        public static const TYPE_ReleifStationloginlevel3:int = 226;
        public static const TYPE_ReleifStationloginlevel4:int = 227;
        public static const TYPE_Forgeloginlevel2:int = 228;
        public static const TYPE_Forgeloginlevel3:int = 229;
        public static const TYPE_Forgeloginlevel4:int = 230;
        public static const TYPE_RallyPointloginlevel2:int = 231;
        public static const TYPE_RallyPointloginlevel3:int = 232;
        public static const TYPE_RallyPointloginlevel4:int = 233;
        public static const TYPE_FeastingHallloginlevel2:int = 234;
        public static const TYPE_FeastingHallloginlevel3:int = 235;
        public static const TYPE_FeastingHallloginlevel4:int = 236;
        public static const TYPE_Embassyloginlevel2:int = 237;
        public static const TYPE_Embassyloginlevel3:int = 238;
        public static const TYPE_Embassyloginlevel4:int = 239;
        public static const TYPE_Barracksloginlevel2:int = 240;
        public static const TYPE_Barracksloginlevel3:int = 241;
        public static const TYPE_Barracksloginlevel4:int = 242;
        public static const TYPE_Stablesloginlevel2:int = 243;
        public static const TYPE_Stablesloginlevel3:int = 244;
        public static const TYPE_Stablesloginlevel4:int = 245;
        public static const TYPE_Academyloginlevel2:int = 246;
        public static const TYPE_Academyloginlevel3:int = 247;
        public static const TYPE_Academyloginlevel4:int = 248;
        public static const TYPE_WorkShoploginlevel2:int = 249;
        public static const TYPE_WorkShoploginlevel3:int = 250;
        public static const TYPE_WorkShoploginlevel4:int = 251;
        public static const TYPE_Forumloginlevel2:int = 252;
        public static const TYPE_Forumloginlevel3:int = 253;
        public static const TYPE_Forumloginlevel4:int = 254;
        public static const TYPE_WallWorker:int = 0xFF;
        public static const TYPE_Cottage2CLv1:int = 0x0100;
        public static const TYPE_Cottage2StructCLv1:int = 0x0101;
        public static const TYPE_Cottage2CLv2:int = 258;
        public static const TYPE_Cottage2StructCLv2:int = 259;
        public static const TYPE_Cottage2CLv3:int = 260;
        public static const TYPE_Cottage2StructCLv3:int = 261;
        public static const TYPE_Cottage2CLv4:int = 262;
        public static const TYPE_Cottage2StructCLv4:int = 263;
        public static const TYPE_TurnTableItem:int = 264;
        public static const TYPE_HalloCastle:int = 265;
        public static const TYPE_HalloWall:int = 266;
        public static const TYPE_MAX:int = 266;
        public static const SPRITE_LOADED:String = "SPRITE_LOADED";
        public static const EVENT_LAST_FRAME:String = "evony_evnet_last_frame";
        private static var aniInfoList:Array = null;
        private static var aniInfoLoadCallBack:Function = null;

        private const EVENT_FIRST_FRAME:String = "evony_evnet_first_frame";

        private var bStopped:Boolean = true;
        private var duration:Number = 0;
        public var mc:Sprite = null;
        private var maxFrames:int = 1;
        private var pendingGotoAndStopFrame:Object = null;
        public var type:int = -1;
        private var percent:Number = 0;
        public var pos:int = -1;
        public var reverse:Boolean = false;
        private var fps:Number = 0;
        private var accFrame:Number = 0;
        private var currentGotoAddedFrame:int = 1;
        private var currentFrame:int = 1;


        public static function getAniFullInfo(_arg_1:int):String
        {
            return ((("file:" + aniInfoList[_arg_1].file) + " symbol:") + aniInfoList[_arg_1].symbol);
        }

        public static function getFirstLevelUpAni(_arg_1:int):int
        {
            if (_arg_1 < EvonyAnimation.TYPE_TownviewFloorTile)
            {
                _arg_1 = int(((Math.floor((_arg_1 / 8)) * 8) + 1));
            }
            else
            {
                if (((_arg_1 > EvonyAnimation.TYPE_TownviewFloorTile) && (_arg_1 <= EvonyAnimation.TYPE_LumberStructCLv4)))
                {
                    _arg_1 = int(((Math.floor((((_arg_1 - EvonyAnimation.TYPE_TownviewFloorTile) - 1) / 8)) * 8) + 1));
                };
            };
            return (_arg_1);
        }

        private static function GetFieldLevelDep(_arg_1:int):int
        {
            if (_arg_1 <= 3)
            {
                return (0);
            };
            if (_arg_1 <= 8)
            {
                return (1);
            };
            return (2);
        }

        public static function isConstruct(_arg_1:int):Boolean
        {
            if ((((_arg_1 < TYPE_TownviewFloorTile) && ((_arg_1 % 2) == 1)) || (((_arg_1 > TYPE_TownviewFloorTile) && (_arg_1 <= TYPE_LumberStructCLv4)) && ((_arg_1 % 2) == 0))))
            {
                return (true);
            };
            return (false);
        }

        public static function getWorkingAniId(_arg_1:int):int
        {
            if ((((_arg_1 > TYPE_LumberStructCLv4) || (_arg_1 == TYPE_TownviewFloorTile)) || (!(isConstruct(_arg_1)))))
            {
                return (-1);
            };
            return (_arg_1 - 1);
        }

        public static function getAniIdFromFieldType(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            switch (_arg_1)
            {
                case FieldConstants.TYPE_FLAT:
                    return (TYPE_FlatLv1);
                case FieldConstants.TYPE_CASTLE:
                    if (_arg_3 < 4)
                    {
                        return ((TYPE_HistoryCastleLv3 + 3) - _arg_3);
                    };
                    return (TYPE_CastleLvl + GetLevelDep(_arg_2));
                case FieldConstants.TYPE_NPC:
                    if (_arg_3 < 4)
                    {
                        return ((TYPE_HistoryCastleLv3 + 3) - _arg_3);
                    };
                    return (TYPE_CastleLvl + GetLevelDep(_arg_2));
                case FieldConstants.TYPE_FOREST:
                    return (TYPE_ForestLv1 + GetFieldLevelDep(_arg_2));
                case FieldConstants.TYPE_DESERT:
                    return (TYPE_DesertLv1 + GetFieldLevelDep(_arg_2));
                case FieldConstants.TYPE_HILL:
                    return (TYPE_MountainLv1 + GetFieldLevelDep(_arg_2));
                case FieldConstants.TYPE_SWAMP:
                    return (TYPE_SwampLv1 + GetFieldLevelDep(_arg_2));
                case FieldConstants.TYPE_GRASSLAND:
                    return (TYPE_GrassLv1 + GetFieldLevelDep(_arg_2));
                case FieldConstants.TYPE_LAKE:
                    return (TYPE_LakeLv1 + GetFieldLevelDep(_arg_2));
                default:
                    return (-1);
            };
        }

        private static function onLoadAniInit(_arg_1:Event):void
        {
            var _local_6:RegExp;
            var _local_7:Object;
            var _local_2:URLLoader = URLLoader(_arg_1.target);
            var _local_3:String = (_local_2.data as String);
            if (ResourceLoader.onDemandProgressFunc != null)
            {
                ResourceLoader.onDemandProgressFunc("aniInfo.txt", 100, 100);
            };
            var _local_4:Array = _local_3.split("\n");
            aniInfoList = new Array();
            var _local_5:int;
            while (_local_5 < _local_4.length)
            {
                _local_3 = _local_4[_local_5];
                _local_6 = /[ \t]*(?P<id>\d+)[ \t]*,[ \t]*(?P<file>[^ \t\r\n]+)[ \t]*,[ \t]*(?P<symbol>[^ \t\r\n]+)[ \t]*,[ \t]*(?P<dx>\-*\d+)[ \t]*,[ \t]*(?P<dy>\-*\d+)[ \t]*[, \t\n\r]*/;
                _local_7 = _local_6.exec(_local_3);
                if (_local_7 != null)
                {
                    aniInfoList.push(new AnimationInfo());
                    AnimationInfo(aniInfoList[(aniInfoList.length - 1)]).id = int(_local_7.id);
                    AnimationInfo(aniInfoList[(aniInfoList.length - 1)]).file = ("fla/" + _local_7.file);
                    AnimationInfo(aniInfoList[(aniInfoList.length - 1)]).symbol = _local_7.symbol;
                    AnimationInfo(aniInfoList[(aniInfoList.length - 1)]).dx = int(_local_7.dx);
                    AnimationInfo(aniInfoList[(aniInfoList.length - 1)]).dy = int(_local_7.dy);
                };
                _local_5++;
            };
            aniInfoLoadCallBack();
            _local_2.removeEventListener(Event.COMPLETE, onLoadAniInit);
            _local_2.removeEventListener(ProgressEvent.PROGRESS, onConfigLoadingProgress);
        }

        public static function preload(_arg_1:int):void
        {
            ResourceLoader.loadResource(aniInfoList[_arg_1].file, aniInfoList[_arg_1].symbol, null, ResourceLoader.LOAD_BACKGROUND);
        }

        public static function readAniInfo(_arg_1:Function):void
        {
            aniInfoLoadCallBack = _arg_1;
            var _local_2:URLLoader = new URLLoader();
            _local_2.addEventListener(Event.COMPLETE, onLoadAniInit);
            _local_2.addEventListener(ProgressEvent.PROGRESS, onConfigLoadingProgress);
            _local_2.load(new URLRequest(ResourceLoader.getNormalUrl("fla/aniInfo.txt")));
        }

        public static function getAniIdFromCityAndTownBuildingType(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            var _local_5:int = (_arg_4 % 2);
            switch (_arg_1)
            {
                case BuildingConstants.TYPE_HOUSE:
                    return (((((_local_5 == 0) ? 0 : 0x0100) + TYPE_CottageCLv1) + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_WAREHOUSE:
                    return ((TYPE_StoreHouseCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_TAVERN:
                    return ((TYPE_InnCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_MARKET:
                    return ((TYPE_MarketPlaceCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_SENTRY_BUILDING:
                    return ((TYPE_WatchTowerCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_TRANSPORT_STATION:
                    return ((TYPE_ReleifStationCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_BLACKSMITH:
                    return ((TYPE_ForgeCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_TRAINNING_FEILD:
                    return ((TYPE_RallyPointCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_HEROS_MANSION:
                    return ((TYPE_FeastingHallCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_EMBASSY:
                    return ((TYPE_EmbassyCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_BARRACK:
                    return ((TYPE_BarracksCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_STABLE:
                    return ((TYPE_StablesCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_ACADEMY:
                    return ((TYPE_AcademyCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_WORKSHOP:
                    return ((TYPE_WorkShopCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_TOWN_HALL:
                    return ((TYPE_TownhallCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_WALL:
                    return ((TYPE_WallCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_LUMBER_MILL:
                    return ((TYPE_LumberCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_STONE_MINE:
                    return ((TYPE_StoneCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_IRON_MINE:
                    return ((TYPE_IronCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                case BuildingConstants.TYPE_FARM_LAND:
                    return ((TYPE_FarmCLv1 + ((_arg_2 == BuildingConstants.STATUS_NORMAL) ? 0 : 1)) + (2 * GetLevelDep(_arg_3)));
                default:
                    return (0);
            };
        }

        public static function getAniInfoById(_arg_1:int):AnimationInfo
        {
            return (aniInfoList[_arg_1]);
        }

        public static function getLevelById(_arg_1:int):int
        {
            if (((_arg_1 > TYPE_LakeLv3) || (_arg_1 == TYPE_TownviewFloorTile)))
            {
                return (0);
            };
            if (_arg_1 < TYPE_TownviewFloorTile)
            {
                return (Math.floor(((_arg_1 % 8) / 2)) + 1);
            };
            if (((_arg_1 > TYPE_TownviewFloorTile) && (_arg_1 <= TYPE_LumberStructCLv4)))
            {
                return (Math.floor(((((_arg_1 - TYPE_TownviewFloorTile) - 1) % 8) / 2)) + 1);
            };
            return (((_arg_1 - TYPE_LumberStructCLv4) - 1) % 3);
        }

        public static function preLoadAllInBackground():void
        {
            preload(TYPE_WallCLv2);
            preload(TYPE_WallCLv3);
            preload(TYPE_WallCLv4);
            preload(TYPE_WallStructCLv4);
            preload(TYPE_WallStructCLv3);
            preload(TYPE_WallStructCLv2);
            preload(TYPE_WallStructCLv1);
            preload(TYPE_ForestLv1);
            preload(TYPE_ForestLv2);
            preload(TYPE_ForestLv3);
            preload(TYPE_SwampLv1);
            preload(TYPE_SwampLv2);
            preload(TYPE_SwampLv3);
            preload(TYPE_MountainLv1);
            preload(TYPE_MountainLv2);
            preload(TYPE_MountainLv3);
            preload(TYPE_DesertLv1);
            preload(TYPE_DesertLv2);
            preload(TYPE_DesertLv3);
            preload(TYPE_GrassLv1);
            preload(TYPE_GrassLv2);
            preload(TYPE_GrassLv3);
            preload(TYPE_LakeLv1);
            preload(TYPE_LakeLv2);
            preload(TYPE_LakeLv3);
            preload(TYPE_CastleLvl);
            preload(TYPE_CastleLv2);
            preload(TYPE_CastleLv3);
            preload(TYPE_CastleLv4);
            preload(TYPE_FlatLv1);
            preload(TYPE_HistoryCastleLv1);
            preload(TYPE_HistoryCastleLv2);
            preload(TYPE_HistoryCastleLv3);
            preload(TYPE_HistoryCastleLv4);
            preload(TYPE_HammerIn);
            preload(TYPE_HammerOut);
            preload(TYPE_HammerOver);
            preload(TYPE_HammerClick);
            preload(TYPE_constructFrontDown);
            preload(TYPE_constructFrontUp);
            preload(TYPE_constructBackDown);
            preload(TYPE_constructBackUp);
            preload(TYPE_constructTWFrontDown);
            preload(TYPE_constructTWFrontUp);
            preload(TYPE_constructTWBackDown);
            preload(TYPE_constructTWBackUp);
            preload(TYPE_Cloud);
            preload(TYPE_OuterSpace);
            preload(TYPE_ArrowSign);
            preload(TYPE_Banner);
            preload(TYPE_MyHost);
            preload(TYPE_Select);
            preload(TYPE_FieldImageMc);
            preload(TYPE_BuildingLogo);
            preload(TYPE_MapViewFloorTile);
            preload(TYPE_FarmCLv1);
            preload(TYPE_FarmStructCLv1);
            preload(TYPE_FarmCLv2);
            preload(TYPE_FarmStructCLv2);
            preload(TYPE_FarmCLv3);
            preload(TYPE_FarmStructCLv3);
            preload(TYPE_FarmCLv4);
            preload(TYPE_FarmStructCLv4);
            preload(TYPE_StoneCLv1);
            preload(TYPE_StoneStructCLv1);
            preload(TYPE_StoneCLv2);
            preload(TYPE_StoneStructCLv2);
            preload(TYPE_StoneCLv3);
            preload(TYPE_StoneStructCLv3);
            preload(TYPE_StoneCLv4);
            preload(TYPE_StoneStructCLv4);
            preload(TYPE_IronCLv1);
            preload(TYPE_IronStructCLv1);
            preload(TYPE_IronCLv2);
            preload(TYPE_IronStructCLv2);
            preload(TYPE_IronCLv3);
            preload(TYPE_IronStructCLv3);
            preload(TYPE_IronCLv4);
            preload(TYPE_IronStructCLv4);
            preload(TYPE_LumberCLv1);
            preload(TYPE_LumberStructCLv1);
            preload(TYPE_LumberCLv2);
            preload(TYPE_LumberStructCLv2);
            preload(TYPE_LumberCLv3);
            preload(TYPE_LumberStructCLv3);
            preload(TYPE_LumberCLv4);
            preload(TYPE_LumberStructCLv4);
            preload(TYPE_CityViewFloorTile);
            preload(TYPE_CottageCLv1);
            preload(TYPE_CottageStructCLv1);
            preload(TYPE_CottageCLv2);
            preload(TYPE_CottageStructCLv2);
            preload(TYPE_CottageCLv3);
            preload(TYPE_CottageStructCLv3);
            preload(TYPE_CottageCLv4);
            preload(TYPE_CottageStructCLv4);
            preload(TYPE_StoreHouseCLv1);
            preload(TYPE_StoreHouseStructCLv1);
            preload(TYPE_StoreHouseCLv2);
            preload(TYPE_StoreHouseStructCLv2);
            preload(TYPE_StoreHouseCLv3);
            preload(TYPE_StoreHouseStructCLv3);
            preload(TYPE_StoreHouseCLv4);
            preload(TYPE_StoreHouseStructCLv4);
            preload(TYPE_InnCLv1);
            preload(TYPE_InnStructCLv1);
            preload(TYPE_InnCLv2);
            preload(TYPE_InnStructCLv2);
            preload(TYPE_InnCLv3);
            preload(TYPE_InnStructCLv3);
            preload(TYPE_InnCLv4);
            preload(TYPE_InnStructCLv4);
            preload(TYPE_MarketPlaceCLv1);
            preload(TYPE_MarketPlaceStructCLv1);
            preload(TYPE_MarketPlaceCLv2);
            preload(TYPE_MarketPlaceStructCLv2);
            preload(TYPE_MarketPlaceCLv3);
            preload(TYPE_MarketPlaceStructCLv3);
            preload(TYPE_MarketPlaceCLv4);
            preload(TYPE_MarketPlaceStructCLv4);
            preload(TYPE_WatchTowerCLv1);
            preload(TYPE_WatchTowerStructCLv1);
            preload(TYPE_WatchTowerCLv2);
            preload(TYPE_WatchTowerStructCLv2);
            preload(TYPE_WatchTowerCLv3);
            preload(TYPE_WatchTowerStructCLv3);
            preload(TYPE_WatchTowerCLv4);
            preload(TYPE_WatchTowerStructCLv4);
            preload(TYPE_ReleifStationCLv1);
            preload(TYPE_ReleifStationStructCLv1);
            preload(TYPE_ReleifStationCLv2);
            preload(TYPE_ReleifStationStructCLv2);
            preload(TYPE_ReleifStationCLv3);
            preload(TYPE_ReleifStationStructCLv3);
            preload(TYPE_ReleifStationCLv4);
            preload(TYPE_ReleifStationStructCLv4);
            preload(TYPE_ForgeCLv1);
            preload(TYPE_ForgeStructCLv1);
            preload(TYPE_ForgeCLv2);
            preload(TYPE_ForgeStructCLv2);
            preload(TYPE_ForgeCLv3);
            preload(TYPE_ForgeStructCLv3);
            preload(TYPE_ForgeCLv4);
            preload(TYPE_ForgeStructCLv4);
            preload(TYPE_RallyPointCLv1);
            preload(TYPE_RallyPointStructCLv1);
            preload(TYPE_RallyPointCLv2);
            preload(TYPE_RallyPointStructCLv2);
            preload(TYPE_RallyPointCLv3);
            preload(TYPE_RallyPointStructCLv3);
            preload(TYPE_RallyPointCLv4);
            preload(TYPE_RallyPointStructCLv4);
            preload(TYPE_FeastingHallCLv1);
            preload(TYPE_FeastingHallStructCLv1);
            preload(TYPE_FeastingHallCLv2);
            preload(TYPE_FeastingHallStructCLv2);
            preload(TYPE_FeastingHallCLv3);
            preload(TYPE_FeastingHallStructCLv3);
            preload(TYPE_FeastingHallCLv4);
            preload(TYPE_FeastingHallStructCLv4);
            preload(TYPE_EmbassyCLv1);
            preload(TYPE_EmbassyStructCLv1);
            preload(TYPE_EmbassyCLv2);
            preload(TYPE_EmbassyStructCLv2);
            preload(TYPE_EmbassyCLv3);
            preload(TYPE_EmbassyStructCLv3);
            preload(TYPE_EmbassyCLv4);
            preload(TYPE_EmbassyStructCLv4);
            preload(TYPE_BarracksCLv1);
            preload(TYPE_BarracksStructCLv1);
            preload(TYPE_BarracksCLv2);
            preload(TYPE_BarracksStructCLv2);
            preload(TYPE_BarracksCLv3);
            preload(TYPE_BarracksStructCLv3);
            preload(TYPE_BarracksCLv4);
            preload(TYPE_BarracksStructCLv4);
            preload(TYPE_StablesCLv1);
            preload(TYPE_StablesStructCLv1);
            preload(TYPE_StablesCLv2);
            preload(TYPE_StablesStructCLv2);
            preload(TYPE_StablesCLv3);
            preload(TYPE_StablesStructCLv3);
            preload(TYPE_StablesCLv4);
            preload(TYPE_StablesStructCLv4);
            preload(TYPE_AcademyCLv1);
            preload(TYPE_AcademyStructCLv1);
            preload(TYPE_AcademyCLv2);
            preload(TYPE_AcademyStructCLv2);
            preload(TYPE_AcademyCLv3);
            preload(TYPE_AcademyStructCLv3);
            preload(TYPE_AcademyCLv4);
            preload(TYPE_AcademyStructCLv4);
            preload(TYPE_WorkShopCLv1);
            preload(TYPE_WorkShopStructCLv1);
            preload(TYPE_WorkShopCLv2);
            preload(TYPE_WorkShopStructCLv2);
            preload(TYPE_WorkShopCLv3);
            preload(TYPE_WorkShopStructCLv3);
            preload(TYPE_WorkShopCLv4);
            preload(TYPE_WorkShopStructCLv4);
            preload(TYPE_TownhallStructCLv1);
            preload(TYPE_TownhallCLv2);
            preload(TYPE_TownhallStructCLv2);
            preload(TYPE_TownhallCLv3);
            preload(TYPE_TownhallStructCLv3);
            preload(TYPE_TownhallCLv4);
            preload(TYPE_TownhallStructCLv4);
            preload(TYPE_TownhallCLv1);
            preload(TYPE_WallCLv1);
            preload(TYPE_TownviewFloorTile);
        }

        private static function GetLevelDep(_arg_1:int):int
        {
            if (_arg_1 <= 3)
            {
                return (0);
            };
            if (_arg_1 <= 6)
            {
                return (1);
            };
            if (_arg_1 <= 9)
            {
                return (2);
            };
            return (3);
        }

        private static function onConfigLoadingProgress(_arg_1:ProgressEvent):void
        {
            if (ResourceLoader.onDemandProgressFunc != null)
            {
                ResourceLoader.onDemandProgressFunc("aniInfo.txt", _arg_1.bytesLoaded, _arg_1.bytesTotal);
            };
        }

        public static function getConstructAniId(_arg_1:int):int
        {
            if (((_arg_1 > TYPE_LumberStructCLv4) || (_arg_1 == TYPE_TownviewFloorTile)))
            {
                return (-1);
            };
            var _local_2:int;
            if (_arg_1 < TYPE_TownviewFloorTile)
            {
                _local_2 = (_arg_1 - (_arg_1 % 8));
            }
            else
            {
                if (_arg_1 > TYPE_TownviewFloorTile)
                {
                    _local_2 = ((_arg_1 - (_arg_1 % 8)) + 1);
                };
            };
            if (isConstruct(_arg_1))
            {
                _arg_1 = (_arg_1 + 2);
            }
            else
            {
                _arg_1 = (_arg_1 + 1);
            };
            if (_arg_1 >= (_local_2 + 8))
            {
                _arg_1 = (_local_2 + 1);
            };
            return (_arg_1);
        }

        public static function getLoginAniIdFromTownBuildingType(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            var _local_5:int = (_arg_4 % 2);
            _local_5 = ((_local_5 == 0) ? 0 : 0x0100);
            var _local_6:int = GetLevelDep(_arg_3);
            if (_arg_1 != BuildingConstants.TYPE_WALL)
            {
                _local_6 = 0;
            };
            switch (_arg_1)
            {
                case BuildingConstants.TYPE_HOUSE:
                    return (_local_5 + ((_local_6 == 0) ? TYPE_CottageStructCLv1 : ((TYPE_Cottageloginlevel2 + _local_6) - 1)));
                case BuildingConstants.TYPE_WAREHOUSE:
                    return ((_local_6 == 0) ? TYPE_StoreHouseStructCLv1 : ((TYPE_StoreHouseloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_TAVERN:
                    return ((_local_6 == 0) ? TYPE_InnStructCLv1 : ((TYPE_Innloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_MARKET:
                    return ((_local_6 == 0) ? TYPE_MarketPlaceStructCLv1 : ((TYPE_MarketPlaceloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_SENTRY_BUILDING:
                    return ((_local_6 == 0) ? TYPE_WatchTowerStructCLv1 : ((TYPE_WatchTowerloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_TRANSPORT_STATION:
                    return ((_local_6 == 0) ? TYPE_ReleifStationStructCLv1 : ((TYPE_ReleifStationloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_BLACKSMITH:
                    return ((_local_6 == 0) ? TYPE_ForgeStructCLv1 : ((TYPE_Forgeloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_TRAINNING_FEILD:
                    return ((_local_6 == 0) ? TYPE_RallyPointStructCLv1 : ((TYPE_RallyPointloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_HEROS_MANSION:
                    return ((_local_6 == 0) ? TYPE_FeastingHallStructCLv1 : ((TYPE_FeastingHallloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_EMBASSY:
                    return ((_local_6 == 0) ? TYPE_EmbassyStructCLv1 : ((TYPE_Embassyloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_BARRACK:
                    return ((_local_6 == 0) ? TYPE_BarracksStructCLv1 : ((TYPE_Barracksloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_STABLE:
                    return ((_local_6 == 0) ? TYPE_StablesStructCLv1 : ((TYPE_Stablesloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_ACADEMY:
                    return ((_local_6 == 0) ? TYPE_AcademyStructCLv1 : ((TYPE_Academyloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_WORKSHOP:
                    return ((_local_6 == 0) ? TYPE_WorkShopStructCLv1 : ((TYPE_WorkShoploginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_TOWN_HALL:
                    return ((_local_6 == 0) ? TYPE_TownhallStructCLv1 : ((TYPE_Forumloginlevel2 + _local_6) - 1));
                case BuildingConstants.TYPE_WALL:
                    return (TYPE_WallStructCLv1 + (2 * GetLevelDep(_arg_3)));
                default:
                    return (0);
            };
        }


        public function stop():void
        {
            bStopped = true;
            if (this.mc != null)
            {
                ResourceLoader.traverseMovieClip(this.mc, 1, doStop);
            };
        }

        private function doStopAtLastFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.gotoAndStop(_arg_1.totalFrames);
            return (_arg_2);
        }

        public function setMovieDuration(_arg_1:Number):void
        {
            if (((_arg_1 <= 0) || (maxFrames == 1)))
            {
                this.fps = 0;
            }
            else
            {
                this.fps = (Number(maxFrames) / _arg_1);
            };
        }

        private function doPlayAtLastFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.gotoAndPlay(_arg_1.totalFrames);
            return (_arg_2);
        }

        private function doStop(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.stop();
            return (_arg_2);
        }

        public function gotoAndStop(_arg_1:Boolean):void
        {
            bStopped = true;
            if (this.mc != null)
            {
                if (_arg_1)
                {
                    ResourceLoader.traverseMovieClip(this.mc, 1, doStopAtFirstFrame);
                }
                else
                {
                    ResourceLoader.traverseMovieClip(this.mc, 1, doStopAtLastFrame);
                };
            };
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            var _local_2:Number;
            var _local_3:Number;
            if (bStopped)
            {
                return;
            };
            if (fps > 0)
            {
                _local_2 = 20;
                _local_3 = (this.fps / _local_2);
                this.accFrame = (this.accFrame + _local_3);
                currentGotoAddedFrame = (Math.floor(this.accFrame) + 30);
                this.accFrame = (this.accFrame - currentGotoAddedFrame);
            }
            else
            {
                currentGotoAddedFrame = 1;
            };
            if (currentGotoAddedFrame > 0)
            {
                if (reverse)
                {
                    if (ResourceLoader.traverseMovieClip(_arg_1.target, 0, doPreveFrame) == 0)
                    {
                        this.dispatchEvent(new Event(EVENT_LAST_FRAME));
                    };
                }
                else
                {
                    if (fps > 0)
                    {
                        if (ResourceLoader.traverseMovieClip(_arg_1.target, 0, doNextFrame) == 0)
                        {
                            this.dispatchEvent(new Event(EVENT_LAST_FRAME));
                        };
                    }
                    else
                    {
                        if (currentFrame == maxFrames)
                        {
                            this.dispatchEvent(new Event(EVENT_LAST_FRAME));
                        };
                        currentFrame = (currentFrame + currentGotoAddedFrame);
                    };
                };
            };
        }

        private function doPlayAtFirstFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.gotoAndPlay(1);
            return (_arg_2);
        }

        private function drawLozenge(_arg_1:int, _arg_2:int):void
        {
            this.mc = new Sprite();
            this.mc.graphics.beginFill(0xFFFFFF, 0);
            this.mc.graphics.moveTo(0, (_arg_2 / 2));
            this.mc.graphics.lineTo((_arg_1 / 2), 0);
            this.mc.graphics.lineTo(_arg_1, (_arg_2 / 2));
            this.mc.graphics.lineTo((_arg_1 / 2), _arg_2);
            this.mc.graphics.endFill();
            this.addChild(this.mc);
        }

        public function play():void
        {
            bStopped = false;
            accFrame = 0;
            if (this.mc != null)
            {
                if (((!(reverse)) && (fps == 0)))
                {
                    ResourceLoader.traverseMovieClip(this.mc, 1, doPlay);
                };
            };
        }

        public function setPercentageAndStop(_arg_1:Number):void
        {
            this.percent = _arg_1;
            ResourceLoader.traverseMovieClip(this.mc, 0, doPercentageAndStop);
        }

        private function doPercentageAndStop(_arg_1:MovieClip, _arg_2:int):int
        {
            var _local_3:int;
            if (this.reverse)
            {
                _local_3 = (maxFrames - Math.floor((_arg_1.maxFrames * this.percent)));
                if (_local_3 == 0)
                {
                    _local_3 = 1;
                };
                _arg_1.gotoAndStop(_local_3);
            }
            else
            {
                _local_3 = Math.floor((_arg_1.maxFrames * this.percent));
                if (_local_3 == 0)
                {
                    _local_3 = 1;
                };
                _arg_1.gotoAndStop(_local_3);
            };
            return (_arg_2);
        }

        public function gotoAndPlay(_arg_1:Boolean):void
        {
            bStopped = false;
            accFrame = 0;
            if (this.mc != null)
            {
                if (_arg_1)
                {
                    ResourceLoader.traverseMovieClip(this.mc, 1, doStopAtFirstFrame);
                }
                else
                {
                    ResourceLoader.traverseMovieClip(this.mc, 1, doStopAtLastFrame);
                };
            };
        }

        private function onLoaded(_arg_1:Object):void
        {
            if (_arg_1 == null)
            {
                Object(Application.application).traceErrorMessage((("!!!!ERROR!!!! Loading Symbol " + getAniFullInfo(this.type)) + " failed!!"));
                this.dispatchEvent(new Event(SPRITE_LOADED));
                return;
            };
            this.mc = Sprite(_arg_1);
            this.mc.cacheAsBitmap = true;
            this.mc.x = getAniInfoById(this.type).dx;
            this.mc.y = getAniInfoById(this.type).dy;
            if ((((type == TYPE_CityViewFloorTile) || (type == TYPE_TownviewFloorTile)) || (type == TYPE_MapViewFloorTile)))
            {
                this.addChild(DisplayObject(_arg_1));
                this.dispatchEvent(new Event(SPRITE_LOADED));
                return;
            };
            maxFrames = ResourceLoader.traverseMovieClip(this.mc, 1, getMaxFrame);
            setMovieDuration(this.duration);
            currentFrame = 1;
            if (fps > 0)
            {
            };
            this.mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            if (((this.bStopped) || (reverse)))
            {
                ResourceLoader.traverseMovieClip(_arg_1, 1, ((reverse) ? doStopAtLastFrame : doStopAtFirstFrame));
            };
            if (reverse)
            {
                this.currentFrame = this.maxFrames;
            };
            if (this.pendingGotoAndStopFrame != null)
            {
                if ((this.mc is MovieClip))
                {
                    MovieClip(this.mc).gotoAndStop(this.pendingGotoAndStopFrame);
                };
                this.pendingGotoAndStopFrame = null;
            };
            if (type == TYPE_Cloud)
            {
                trace("TYPE_Cloud");
            };
            this.addChild(DisplayObject(_arg_1));
            this.dispatchEvent(new Event(SPRITE_LOADED));
        }

        public function stopped():Boolean
        {
            return (bStopped);
        }

        private function getMaxFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            if (_arg_1.totalFrames > _arg_2)
            {
                return (_arg_1.totalFrames);
            };
            return (_arg_2);
        }

        public function gotoAndStopNative(_arg_1:Object):void
        {
            if (this.mc != null)
            {
                if ((this.mc is MovieClip))
                {
                    MovieClip(this.mc).gotoAndStop(_arg_1);
                };
            }
            else
            {
                this.pendingGotoAndStopFrame = _arg_1;
            };
        }

        private function doPlay(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.play();
            return (_arg_2);
        }

        public function load(_arg_1:int, _arg_2:int, _arg_3:int=1, _arg_4:Number=0, _arg_5:Boolean=false, _arg_6:Boolean=false):void
        {
            this.type = _arg_1;
            this.pos = _arg_2;
            this.mc = null;
            this.reverse = _arg_5;
            this.bStopped = _arg_6;
            this.duration = _arg_4;
            var _local_7:Object = AnimationCache.singleton().getAni(this.type);
            if (_local_7 != null)
            {
                if (((_arg_1 < 0) || (_arg_1 > TYPE_MAX)))
                {
                    this.mc = Sprite(_local_7);
                    this.addChild(this.mc);
                    this.dispatchEvent(new Event(SPRITE_LOADED));
                }
                else
                {
                    onLoaded(_local_7);
                };
                return;
            };
            if (((_arg_1 < 0) || (_arg_1 > TYPE_MAX)))
            {
                if (_arg_1 == TYPE_LOZENGE_BIG)
                {
                    drawLozenge(220, 110);
                }
                else
                {
                    if (_arg_1 == TYPE_LOZENGE_SMALL)
                    {
                        drawLozenge(220, 110);
                    };
                };
                this.dispatchEvent(new Event(SPRITE_LOADED));
                return;
            };
            var _local_8:AnimationInfo = getAniInfoById(_arg_1);
            ResourceLoader.loadResource(_local_8.file, _local_8.symbol, onLoaded, _arg_3);
        }

        private function doNextFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            var _local_3:int;
            if (_arg_1.currentFrame != _arg_1.totalFrames)
            {
                _local_3 = (_arg_1.currentFrame + currentGotoAddedFrame);
                if (_local_3 <= _arg_1.totalFrames)
                {
                    _arg_1.gotoAndStop(_local_3);
                    return (-1);
                };
                _arg_1.gotoAndStop(_arg_1.totalFrames);
            }
            else
            {
                _arg_1.stop();
            };
            if (_arg_2 == 0)
            {
                return (0);
            };
            return (-1);
        }

        private function doPreveFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            var _local_3:int;
            if (_arg_1.currentFrame != 1)
            {
                _local_3 = (_arg_1.currentFrame - currentGotoAddedFrame);
                if (_local_3 < 1)
                {
                    _arg_1.gotoAndStop(1);
                }
                else
                {
                    _arg_1.gotoAndStop(_local_3);
                    return (-1);
                };
            }
            else
            {
                _arg_1.stop();
            };
            if (_arg_2 == 0)
            {
                return (0);
            };
            return (-1);
        }

        public function destroy():void
        {
            if (this.mc != null)
            {
                AnimationCache.singleton().putAni(this.type, this.mc);
                this.mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                this.removeChild(mc);
                mc = null;
            };
        }

        private function doStopAtFirstFrame(_arg_1:MovieClip, _arg_2:int):int
        {
            _arg_1.gotoAndStop(1);
            return (_arg_2);
        }


    }
}//package com.evony.util

