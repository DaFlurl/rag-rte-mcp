// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.player.Map

package autoevony.player
{
    import mx.collections.ArrayList;
    import flash.utils.Timer;
    import com.evony.common.beans.UnitAlliance;
    import com.evony.common.module.alliance.AllianceFriendshipResponse;
    import autoevony.gui.MainScreen;
    import com.evony.client.action.ActionFactory;
    import flash.events.TimerEvent;
    import com.evony.common.beans.PlayerInfoBean;
    import flash.display.BitmapData;
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.common.Utils;
    import com.evony.common.beans.MapCastleBean;
    import com.evony.common.constants.FieldConstants;
    import com.evony.common.module.field.OtherFieldInfoResponse;
    import com.evony.common.module.alliance.PlayerInfoResponse;
    import flash.geom.Rectangle;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.common.module.common.MapInfoSimpleResponse;

    public class Map 
    {

        private static var map:Object = new Object();
        private static var mapData:Array = null;
        private static var mapCacheTime:Object = new Object();
        private static var lastCacheMapTime:Date = null;
        private static var detail:Object = new Object();
        private static var detailCacheTime:Object = new Object();
        private static var castles:Object = new Object();
        private static var castlesCacheTime:Object = new Object();
        private static var players:Object = new Object();
        private static var playersCacheTime:Object = new Object();
        private static var pendingFieldId:Array = new Array();
        private static var WIDTH:int = 800;
        private static var HEIGHT:int = 800;
        private static var WSIZE:int = 21;
        private static var LWSIZE:int = 40;
        private static var WPIECE:int = 50;
        private static var showValleyFlag:Boolean = true;
        public static const npc10Color:uint = 0;
        public static const ownColor:uint = 0xFF8C00;
        public static const noFieldColor:uint = 0x7F7F7F;
        public static const neutralColor:uint = 16765043;
        private static var neutralAlliances:ArrayList = new ArrayList();
        private static const FIELD_COLORS:Array = new Array(0x7F7F7F, 14741216, 16764108, 13434726, 12357519, 11529966, 2003199, 0x7F7F7F, 0x7F7F7F, 0x7F7F7F, 9144713, 0xFFFFFF, 4210736);
        private static const RELATION_COLORS:Array = new Array(0xFF00, 0xFFFF, 0xCF00CF, 0xFF0000);
        public static const FIELD_NAMES:Array = new Array("", "Forest", "Desert", "Hill", "Swamp", "GrassLand", "Lake", "", "", "", "Flat", "Castle", "NPC");
        public static const TITLES:ArrayList = new ArrayList(["Civilian", "Knight", "Baronet", "Baron", "Viscount", "Earl", "Marquis", "Duke", "Furstin", "Prinzessin"]);
        private static const REGIONS:Array = new Array(new Array("Friesland", "Lower Lorraine", "Upper Lorraine", "Burgundy"), new Array("Saxony", "Franconia", "Swabia", "Lombardy"), new Array("North March", "Thuringia", "Bavaria", "Tuscany"), new Array("Bohemia", "Moravia", "Carinthia", "Romagna"));
        private static var fetchDetailTimer:Timer = null;
        private static var cacheCleanupTimer:Timer = null;
        private static const isTrace:Boolean = Version.isTraceMapOn();


        public static function fieldDistance(_arg_1:int, _arg_2:int):Number
        {
            var _local_3:int = getX(_arg_1);
            var _local_4:int = getY(_arg_1);
            var _local_5:int = getX(_arg_2);
            var _local_6:int = getY(_arg_2);
            var _local_7:Number = Math.abs((_local_3 - _local_5));
            _local_7 = Math.min(_local_7, (WIDTH - _local_7));
            var _local_8:Number = Math.abs((_local_4 - _local_6));
            _local_8 = Math.min(_local_8, (HEIGHT - _local_8));
            return (Math.sqrt(((_local_7 * _local_7) + (_local_8 * _local_8))));
        }

        public static function updateInfo(_arg_1:int):void
        {
            if (map[_arg_1] != undefined)
            {
                mapCacheTime[_arg_1] = 0;
            };
            cacheMap(_arg_1);
        }

        private static function handleAllianceFriendshipResponse(_arg_1:AllianceFriendshipResponse):void
        {
            var _local_2:UnitAlliance;
            neutralAlliances.removeAll();
            if (_arg_1.ok != 1)
            {
                return;
            };
            for each (_local_2 in _arg_1.middleListArray)
            {
                neutralAlliances.addItem(_local_2.allianceName);
            };
            showValleyFlag = (!(showValleyFlag));
            refreshBitmap((!(showValleyFlag)));
        }

        public static function isInArea(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            return ((isBetween(getX(_arg_1), getX(_arg_2), WIDTH, getX(_arg_3))) && (isBetween(getY(_arg_1), getY(_arg_2), WIDTH, getY(_arg_3))));
        }

        public static function getStateName(_arg_1:int):String
        {
            if (_arg_1 == 1)
            {
                return ("peace");
            };
            if (_arg_1 == 2)
            {
                return ("truce");
            };
            if (_arg_1 == 3)
            {
                return ("beginner");
            };
            if (_arg_1 == 4)
            {
                return ("war");
            };
            if (_arg_1 == 5)
            {
                return ("holiday");
            };
            if (_arg_1 == 6)
            {
                return ("dream");
            };
            return ("state:" + _arg_1);
        }

        private static function handleCleanUpTimer(_arg_1:TimerEvent):void
        {
            deleteStaleRecords(detail, detailCacheTime, ((8 * 3600) * 1000));
            deleteStaleRecords(castles, castlesCacheTime, ((8 * 3600) * 1000));
            deleteStaleRecords(map, mapCacheTime, ((8 * 3600) * 1000));
            deleteStaleRecords(players, playersCacheTime, ((8 * 3600) * 1000));
            if (MainScreen.getPlayer().playerInfo.alliance != null)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
            };
        }

        public static function getPlayerInfo(_arg_1:String, _arg_2:int=3600):PlayerInfoBean
        {
            _arg_1 = _arg_1.toLowerCase();
            if ((((players[_arg_1] == undefined) || (playersCacheTime[_arg_1] == undefined)) || (new Date().getTime() > (playersCacheTime[_arg_1] + (_arg_2 * 1000)))))
            {
                reqPlayerInfo(_arg_1);
            };
            if (players[_arg_1] == undefined)
            {
                return (null);
            };
            return (players[_arg_1]);
        }

        public static function initMap(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:int;
            WIDTH = _arg_1;
            HEIGHT = _arg_2;
            if (mapData == null)
            {
                mapData = new Array((WIDTH / WPIECE));
                _local_3 = 0;
                while (_local_3 < mapData.length)
                {
                    mapData[_local_3] = new Array((HEIGHT / WPIECE));
                    _local_4 = 0;
                    while (_local_4 < mapData[_local_3].length)
                    {
                        mapData[_local_3][_local_4] = new BitmapData(WPIECE, WPIECE, false, noFieldColor);
                        _local_4++;
                    };
                    _local_3++;
                };
            };
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE, handleMapInfoSimpleResponse);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.FIELD_GET_OTHER_FIELD_INFO, handleOtherFieldInfoResponse);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST, handleAllianceFriendshipResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE, handleMapInfoSimpleResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FIELD_GET_OTHER_FIELD_INFO, handleOtherFieldInfoResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST, handleAllianceFriendshipResponse);
            if (MainScreen.getPlayer().playerInfo.alliance != null)
            {
                Utils.callLater(((15 * 60) * 1000), ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList);
            };
        }

        public static function fieldIdToCoordString(_arg_1:int):String
        {
            return (((("(" + getX(_arg_1)) + ",") + getY(_arg_1)) + ")");
        }

        public static function fieldIdToString(_arg_1:int):String
        {
            var _local_6:MapCastleBean;
            var _local_2:int = getLevel(_arg_1);
            var _local_3:int = getType(_arg_1);
            if (((_local_2 == 10) && ((_local_3 == FieldConstants.TYPE_NPC) || (_local_3 == FieldConstants.TYPE_CASTLE))))
            {
                _local_6 = getDetailInfo(_arg_1);
                if (_local_6 != null)
                {
                    _local_2 = (18 - (2 * _local_6.powerLevel));
                };
            };
            var _local_4:String = (((_local_2 > 10) && (_local_3 == FieldConstants.TYPE_NPC)) ? "HC" : ((_local_3 == -1) ? "" : FIELD_NAMES[_local_3]));
            var _local_5:String = ((_local_2 == -1) ? "" : ("" + _local_2));
            return (((((((_local_4 + " ") + _local_5) + "(") + getX(_arg_1)) + ",") + getY(_arg_1)) + ")");
        }

        public static function getDetail(_arg_1:int, _arg_2:int=1800):MapCastleBean
        {
            if (((detailCacheTime[_arg_1] == undefined) || (detailCacheTime[_arg_1] < (new Date().getTime() - (_arg_2 * 1000)))))
            {
                cacheDetail(_arg_1);
            };
            if (detail[_arg_1] == undefined)
            {
                return (null);
            };
            return (detail[_arg_1]);
        }

        private static function getOwnerInfo(_arg_1:MapCastleBean):String
        {
            if (_arg_1 == null)
            {
                return ("");
            };
            var _local_2:PlayerInfoBean;
            if (_arg_1.userName != null)
            {
                _local_2 = getPlayerInfo(_arg_1.userName);
            };
            return (((((((((("Status: " + getStateName(_arg_1.state)) + "\n") + _arg_1.name) + " in ") + _arg_1.zoneName) + ((_arg_1.userName == null) ? "\nNo owner" : ("\nOwner: " + _arg_1.userName))) + ((_arg_1.allianceName == null) ? "" : ("\nAlliance: " + _arg_1.allianceName))) + ((_arg_1.userName == null) ? "" : ((("\nPrestige: " + _arg_1.prestige) + "\nHonor: ") + _arg_1.honor))) + ((_arg_1.userName == null) ? "" : ((_local_2 == null) ? "\n[Double click to fetch player information]" : ((((((((("\nRank: " + _local_2.ranking) + "\nTitle: ") + TITLES.getItemAt(_local_2.titleId)) + "\nCastle: ") + _local_2.castleCount) + "/") + (_local_2.titleId + 1)) + "\nTotal pop: ") + _local_2.population)))) + ((_arg_1.suzerain == null) ? "" : ("\nSuzerain: " + _arg_1.suzerain)));
        }

        public static function updateDetailInfo(_arg_1:int):void
        {
            if (detail[_arg_1] != undefined)
            {
                detailCacheTime[_arg_1] = 0;
            };
            cacheDetail(_arg_1);
        }

        private static function handleOtherFieldInfoResponse(_arg_1:OtherFieldInfoResponse):void
        {
            if (_arg_1.ok != 1)
            {
                if (isTrace)
                {
                    trace(("Unable to obtain field info: " + _arg_1.msg));
                };
                return;
            };
            detail[_arg_1.bean.id] = _arg_1.bean;
            detailCacheTime[_arg_1.bean.id] = new Date().getTime();
        }

        private static function onFetchDetailTimer(_arg_1:TimerEvent):void
        {
            if (pendingFieldId.length == 0)
            {
                fetchDetailTimer.reset();
                fetchDetailTimer.removeEventListener(TimerEvent.TIMER, onFetchDetailTimer);
                fetchDetailTimer = null;
                return;
            };
            var _local_2:int = pendingFieldId.shift();
            if ((((detail[_local_2] == undefined) || (detailCacheTime[_local_2] == undefined)) || (detailCacheTime[_local_2] < (new Date().getTime() - (3600 * 1000)))))
            {
                if (isTrace)
                {
                    trace(((("Get detail info at " + getX(_local_2)) + ",") + getY(_local_2)));
                };
                ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(MainScreen.getClosestCityToFieldId(_local_2).castleId, _local_2);
            };
        }

        public static function fullResetMap():void
        {
            resetMap();
            castles = new Object();
            castlesCacheTime = new Object();
            players = new Object();
            playersCacheTime = new Object();
        }

        public static function reqPlayerInfo(_arg_1:String, _arg_2:Boolean=false):void
        {
            _arg_1 = _arg_1.toLowerCase();
            if (((((_arg_2) || (players[_arg_1] == undefined)) || (playersCacheTime[_arg_1] == undefined)) || (new Date().getTime() > (playersCacheTime[_arg_1] + (3600 * 1000)))))
            {
                ActionFactory.getInstance().getCommonCommands().getPlayerInfoByName(_arg_1, handleReqPlayerInfoResponse);
            };
        }

        public static function cacheDetail(_arg_1:int, _arg_2:Boolean=false):void
        {
            if (((!(_arg_2)) && (pendingFieldId.length > 100)))
            {
                return;
            };
            if (pendingFieldId.indexOf(_arg_1) == -1)
            {
                if (_arg_2)
                {
                    pendingFieldId.splice(0, 0, _arg_1);
                }
                else
                {
                    pendingFieldId.push(_arg_1);
                };
            };
            if (fetchDetailTimer == null)
            {
                fetchDetailTimer = new Timer(1500);
                fetchDetailTimer.addEventListener(TimerEvent.TIMER, onFetchDetailTimer);
                fetchDetailTimer.start();
            };
        }

        public static function cacheMap(_arg_1:int, _arg_2:Boolean=false, _arg_3:Boolean=false):void
        {
            var _local_4:Date = new Date();
            if ((((!(_arg_2)) && (!(lastCacheMapTime == null))) && ((_local_4.getTime() - lastCacheMapTime.getTime()) < 2000)))
            {
                return;
            };
            lastCacheMapTime = _local_4;
            var _local_5:int = ((_arg_3) ? LWSIZE : WSIZE);
            var _local_6:int = int((int((getX(_arg_1) / _local_5)) * _local_5));
            var _local_7:int = int((int((getY(_arg_1) / _local_5)) * _local_5));
            if (isTrace)
            {
                trace(((((("Get map at " + _local_6) + ",") + _local_7) + ", size: ") + _local_5));
            };
            var _local_8:int = MainScreen.getClosestCityToFieldId(_arg_1).castle.id;
            ActionFactory.getInstance().getCommonCommands().mapInfoSimple(_local_8, _local_6, _local_7, ((_local_6 + _local_5) - 1), ((_local_7 + _local_5) - 1));
        }

        public static function resetArea(_arg_1:int, _arg_2:int, _arg_3:Number):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            _local_5 = (_arg_1 - _arg_3);
            while (_local_5 <= (_arg_1 + _arg_3))
            {
                _local_6 = (_arg_2 - _arg_3);
                while (_local_6 <= (_arg_2 + _arg_3))
                {
                    if (!((((_local_5 - _arg_1) * (_local_5 - _arg_1)) + ((_local_6 - _arg_2) * (_local_6 - _arg_2))) > (_arg_3 * _arg_3)))
                    {
                        _local_4 = getFieldId(_local_5, _local_6);
                        if (map[_local_4] != undefined)
                        {
                            delete map[_local_4];
                        };
                        if (mapCacheTime[_local_4] != undefined)
                        {
                            delete mapCacheTime[_local_4];
                        };
                        if (detail[_local_4] != undefined)
                        {
                            delete detail[_local_4];
                        };
                        if (detailCacheTime[_local_4] != undefined)
                        {
                            delete detailCacheTime[_local_4];
                        };
                    };
                    _local_6++;
                };
                _local_5++;
            };
        }

        private static function isBetween(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:int = Math.abs((_arg_1 - _arg_2));
            if (_local_5 < (_arg_3 - _local_5))
            {
                return (((_arg_4 - _arg_1) * (_arg_4 - _arg_2)) <= 0);
            };
            return (((_arg_4 - _arg_1) * (_arg_4 - _arg_2)) >= 0);
        }

        public static function getFieldId(_arg_1:int, _arg_2:int):int
        {
            if (_arg_1 >= WIDTH)
            {
                _arg_1 = (_arg_1 - WIDTH);
            };
            if (_arg_1 < 0)
            {
                _arg_1 = (_arg_1 + WIDTH);
            };
            if (_arg_2 >= HEIGHT)
            {
                _arg_2 = (_arg_2 - HEIGHT);
            };
            if (_arg_2 < 0)
            {
                _arg_2 = (_arg_2 + HEIGHT);
            };
            return ((_arg_2 * WIDTH) + _arg_1);
        }

        public static function searchFields(_arg_1:String):Array
        {
            var _local_3:MapCastleBean;
            _arg_1 = _arg_1.toLowerCase();
            var _local_2:Array = new Array();
            for each (_local_3 in detail)
            {
                if (((((!(_local_3.allianceName == null)) && (_local_3.allianceName.toLowerCase() == _arg_1)) || ((!(_local_3.name == null)) && (_local_3.name.toLowerCase() == _arg_1))) || ((!(_local_3.userName == null)) && (_local_3.userName.toLowerCase() == _arg_1))))
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        private static function handleReqPlayerInfoResponse(_arg_1:PlayerInfoResponse):void
        {
            if (_arg_1.ok != 1)
            {
                return;
            };
            players[_arg_1.playerInfo.userName.toLowerCase()] = _arg_1.playerInfo;
            playersCacheTime[_arg_1.playerInfo.userName.toLowerCase()] = new Date().getTime();
        }

        public static function resetMap():void
        {
            var _local_1:int;
            var _local_2:int;
            map = new Object();
            mapCacheTime = new Object();
            detail = new Object();
            detailCacheTime = new Object();
            _local_1 = 0;
            while (_local_1 < mapData.length)
            {
                _local_2 = 0;
                while (_local_2 < mapData[_local_1].length)
                {
                    mapData[_local_1][_local_2].fillRect(new Rectangle(0, 0, WPIECE, WPIECE), 0x7F7F7F);
                    _local_2++;
                };
                _local_1++;
            };
            if (cacheCleanupTimer == null)
            {
                cacheCleanupTimer = new Timer(((60 * 60) * 1000));
                cacheCleanupTimer.addEventListener(TimerEvent.TIMER, handleCleanUpTimer);
                cacheCleanupTimer.start();
            };
        }

        public static function getRegionName(_arg_1:int):String
        {
            return (REGIONS[Math.floor((getX(_arg_1) / 200))][Math.floor((getY(_arg_1) / 200))]);
        }

        public static function searchEnemyFields(_arg_1:String):Array
        {
            var _local_3:MapCastleBean;
            var _local_2:Array = new Array();
            _arg_1 = _arg_1.toLowerCase();
            for each (_local_3 in detail)
            {
                if (_local_3.relation == AllianceConstants.ENEMY_ALLIANCE)
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        public static function searchEnemyCastles(_arg_1:String):Array
        {
            _arg_1 = _arg_1.toLowerCase();
            var _local_2:Array = new Array();
            var _local_3:MapCastleBean;
            for each (_local_3 in castles)
            {
                if (_local_3.relation == AllianceConstants.ENEMY_ALLIANCE)
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        public static function getDetailInfo(_arg_1:int, _arg_2:int=1800):MapCastleBean
        {
            var _local_3:int = getType(_arg_1, _arg_2);
            if (((!(_local_3 == FieldConstants.TYPE_CASTLE)) && (!(_local_3 == FieldConstants.TYPE_NPC))))
            {
                return (null);
            };
            if (detail[_arg_1] == undefined)
            {
                return (null);
            };
            return (detail[_arg_1]);
        }

        public static function getFieldType(_arg_1:String):int
        {
            if ((_arg_1 = _arg_1.toLowerCase()) == "hc")
            {
                return (FieldConstants.TYPE_NPC);
            };
            var _local_2:int;
            while (_local_2 < FIELD_NAMES.length)
            {
                if (FIELD_NAMES[_local_2].length != 0)
                {
                    if (FIELD_NAMES[_local_2].toLowerCase() == _arg_1)
                    {
                        return (_local_2);
                    };
                };
                _local_2++;
            };
            return (-1);
        }

        public static function isMapDetailReady(_arg_1:int, _arg_2:int, _arg_3:Number):Boolean
        {
            var _local_5:int;
            var _local_6:int;
            if (!isMapReady(_arg_1, _arg_2, _arg_3))
            {
                return (false);
            };
            var _local_4:int;
            _local_5 = (_arg_1 - _arg_3);
            while (_local_5 <= (_arg_1 + _arg_3))
            {
                _local_6 = (_arg_2 - _arg_3);
                while (_local_6 <= (_arg_2 + _arg_3))
                {
                    if ((((_local_5 - _arg_1) * (_local_5 - _arg_1)) + ((_local_6 - _arg_2) * (_local_6 - _arg_2))) <= (_arg_3 * _arg_3))
                    {
                        _local_4 = getFieldId(_local_5, _local_6);
                        if (getType(_local_4) < FieldConstants.TYPE_CASTLE)
                        {
                            if (getDetail(_local_4) == null)
                            {
                                return (false);
                            };
                        };
                    };
                    _local_6++;
                };
                _local_5++;
            };
            return (true);
        }

        private static function handleMapInfoSimpleResponse(_arg_1:MapInfoSimpleResponse):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_9:MapCastleBean;
            lastCacheMapTime = null;
            if (_arg_1.ok != 1)
            {
                if (isTrace)
                {
                    trace(("Unable to obtain map: " + _arg_1.msg));
                };
                return;
            };
            if (_arg_1.mapStr == null)
            {
                if (isTrace)
                {
                    trace("INVALID MAP RESPONSE RECEIVED -- NO MAP AVAILABLE!!!");
                };
                return;
            };
            var _local_2:int;
            var _local_3:int;
            var _local_4:uint;
            var _local_5:int = ((_arg_1.x2 - _arg_1.x1) + 1);
            var _local_8:Number = new Date().getTime();
            _local_7 = _arg_1.y1;
            while (_local_7 <= _arg_1.y2)
            {
                _local_6 = _arg_1.x1;
                while (_local_6 <= _arg_1.x2)
                {
                    _local_2 = (2 * (((_local_7 - _arg_1.y1) * _local_5) + (_local_6 - _arg_1.x1)));
                    map[getFieldId(_local_6, _local_7)] = (_local_3 = int(("0x" + _arg_1.mapStr.substr(_local_2, 2))));
                    mapCacheTime[getFieldId(_local_6, _local_7)] = _local_8;
                    _local_4 = noFieldColor;
                    if (showValleyFlag)
                    {
                        if (_local_3 != ((FieldConstants.TYPE_NPC * 16) + 10))
                        {
                            _local_4 = uint(FIELD_COLORS[int((_local_3 / 16))]);
                        }
                        else
                        {
                            _local_4 = npc10Color;
                        };
                    };
                    mapData[int(((_local_6 % WIDTH) / WPIECE))][int(((_local_7 % HEIGHT) / WPIECE))].setPixel((_local_6 % WPIECE), (_local_7 % WPIECE), _local_4);
                    _local_6++;
                };
                _local_7++;
            };
            _local_8 = new Date().getTime();
            for each (_local_9 in _arg_1.castlesArray)
            {
                castles[_local_9.id] = _local_9;
                castlesCacheTime[_local_9.id] = _local_8;
                detail[_local_9.id] = _local_9;
                detailCacheTime[_local_9.id] = _local_8;
                if ((((!(_local_9.npc)) && (_local_9.relation >= 0)) && (_local_9.relation <= RELATION_COLORS.length)))
                {
                    _local_6 = getX(_local_9.id);
                    _local_7 = getY(_local_9.id);
                    if (_local_9.userName == MainScreen.getPlayer().playerInfo.userName)
                    {
                        mapData[int(((_local_6 % WIDTH) / WPIECE))][int(((_local_7 % HEIGHT) / WPIECE))].setPixel((_local_6 % WPIECE), (_local_7 % WPIECE), ownColor);
                    }
                    else
                    {
                        if (((!(_local_9.allianceName == null)) && (!(neutralAlliances.getItemIndex(_local_9.allianceName) == -1))))
                        {
                            mapData[int(((_local_6 % WIDTH) / WPIECE))][int(((_local_7 % HEIGHT) / WPIECE))].setPixel((_local_6 % WPIECE), (_local_7 % WPIECE), neutralColor);
                        }
                        else
                        {
                            mapData[int(((_local_6 % WIDTH) / WPIECE))][int(((_local_7 % HEIGHT) / WPIECE))].setPixel((_local_6 % WPIECE), (_local_7 % WPIECE), RELATION_COLORS[_local_9.relation]);
                        };
                    };
                };
            };
        }

        public static function fieldIdToCoordinate(_arg_1:int):String
        {
            return ((getX(_arg_1) + ",") + getY(_arg_1));
        }

        public static function searchCastlesWithinArea(_arg_1:String, _arg_2:int, _arg_3:int):Array
        {
            var _local_10:int;
            var _local_11:int;
            _arg_1 = _arg_1.toLowerCase();
            var _local_4:Array = new Array();
            var _local_5:MapCastleBean;
            var _local_6:int = getX(_arg_2);
            var _local_7:int = getY(_arg_2);
            var _local_8:int = getX(_arg_3);
            var _local_9:int = getY(_arg_3);
            for each (_local_5 in castles)
            {
                if (isInArea(_arg_2, _arg_3, _local_5.id))
                {
                    if (((((!(_local_5.allianceName == null)) && (!(_local_5.allianceName.toLowerCase().indexOf(_arg_1) == -1))) || ((!(_local_5.name == null)) && (!(_local_5.name.toLowerCase().indexOf(_arg_1) == -1)))) || ((!(_local_5.userName == null)) && (!(_local_5.userName.toLowerCase().indexOf(_arg_1) == -1)))))
                    {
                        _local_4.push(_local_5);
                    };
                };
            };
            return (_local_4);
        }

        public static function getToolTip(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            var _local_4:int = getFieldId(_arg_2, _arg_3);
            var _local_5:String = ("" + (int((fieldDistance(_local_4, _arg_1) * 100)) / 100));
            var _local_6:String = ("" + (int((fieldDistance(_local_4, MainScreen.getInstance().getSelectedCity().castle.fieldId) * 100)) / 100));
            if (((map[_local_4] == undefined) || (map[_local_4] == null)))
            {
                return ((((((("(" + _arg_2) + ",") + _arg_3) + ")") + "\nDistance: ") + _local_5) + "\n[Click to fetch map]");
            };
            var _local_7:int = getType(_local_4);
            var _local_8:int = getLevel(_local_4);
            return ((((((fieldIdToString(_local_4) + "\nDistance from city: ") + _local_6) + "\nDistance from coord: ") + _local_5) + "\n") + ((detail[_local_4] == undefined) ? "[Click to fetch ownership information]" : getOwnerInfo(detail[_local_4])));
        }

        public static function searchCastles(_arg_1:String):Array
        {
            _arg_1 = _arg_1.toLowerCase();
            var _local_2:Array = new Array();
            var _local_3:MapCastleBean;
            for each (_local_3 in castles)
            {
                if (((((!(_local_3.allianceName == null)) && (!(_local_3.allianceName.toLowerCase().indexOf(_arg_1) == -1))) || ((!(_local_3.name == null)) && (!(_local_3.name.toLowerCase().indexOf(_arg_1) == -1)))) || ((!(_local_3.userName == null)) && (!(_local_3.userName.toLowerCase().indexOf(_arg_1) == -1)))))
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        public static function getType(_arg_1:int, _arg_2:int=1800):int
        {
            if (((mapCacheTime[_arg_1] == undefined) || (mapCacheTime[_arg_1] < (new Date().getTime() - (_arg_2 * 1000)))))
            {
                cacheMap(_arg_1);
            };
            if (((map[_arg_1] == undefined) || (map[_arg_1] == null)))
            {
                return (-1);
            };
            return (map[_arg_1] / 16);
        }

        private static function deleteStaleRecords(_arg_1:Object, _arg_2:Object, _arg_3:Number):void
        {
            var _local_5:*;
            var _local_4:Number = new Date().getTime();
            for (_local_5 in _arg_2)
            {
                if ((_arg_2[_local_5] < (_local_4 - _arg_3)))
                {
                    delete _arg_2[_local_5];
                    delete _arg_1[_local_5];
                };
            };
        }

        public static function reqMapInfoAndDetail(_arg_1:int):void
        {
            var _local_2:int = int((int((getX(_arg_1) / WSIZE)) * WSIZE));
            var _local_3:int = int((int((getY(_arg_1) / WSIZE)) * WSIZE));
            var _local_4:int = MainScreen.getClosestCityToFieldId(_arg_1).castle.id;
            ActionFactory.getInstance().getCommonCommands().mapInfoSimple(_local_4, _local_2, _local_3, ((_local_2 + WSIZE) - 1), ((_local_3 + WSIZE) - 1));
            ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(_local_4, _arg_1);
        }

        public static function getX(_arg_1:int):int
        {
            return (_arg_1 % WIDTH);
        }

        public static function getY(_arg_1:int):int
        {
            return (_arg_1 / WIDTH);
        }

        public static function getLevel(_arg_1:int, _arg_2:int=1800, _arg_3:Boolean=false):int
        {
            if (((mapCacheTime[_arg_1] == undefined) || (mapCacheTime[_arg_1] < (new Date().getTime() - (_arg_2 * 1000)))))
            {
                cacheMap(_arg_1, false, _arg_3);
            };
            if (((map[_arg_1] == undefined) || (map[_arg_1] == null)))
            {
                return (-1);
            };
            return (map[_arg_1] % 16);
        }

        public static function resetRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            _local_6 = _arg_1;
            while (_local_6 <= _arg_3)
            {
                _local_7 = _arg_2;
                while (_local_7 <= _arg_4)
                {
                    _local_5 = getFieldId(_local_6, _local_7);
                    if (map[_local_5] != undefined)
                    {
                        delete map[_local_5];
                    };
                    if (mapCacheTime[_local_5] != undefined)
                    {
                        delete mapCacheTime[_local_5];
                    };
                    if (detail[_local_5] != undefined)
                    {
                        delete detail[_local_5];
                    };
                    if (detailCacheTime[_local_5] != undefined)
                    {
                        delete detailCacheTime[_local_5];
                    };
                    _local_7++;
                };
                _local_6++;
            };
        }

        public static function searchSuzerain(_arg_1:String):Array
        {
            var _local_3:MapCastleBean;
            var _local_2:Array = new Array();
            _arg_1 = _arg_1.toLowerCase();
            for each (_local_3 in castles)
            {
                if (!_local_3.npc)
                {
                    if ((((_local_3.suzerain == null) && (_arg_1 == "none")) || ((!(_local_3.suzerain == null)) && (_local_3.suzerain.toLowerCase() == _arg_1))))
                    {
                        _local_2.push(_local_3);
                    };
                };
            };
            return (_local_2);
        }

        public static function getMapData():Array
        {
            return (mapData);
        }

        public static function isMapReady(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Boolean=false):Boolean
        {
            var _local_5:int;
            var _local_6:int;
            _local_5 = (_arg_1 - _arg_3);
            while (_local_5 <= (_arg_1 + _arg_3))
            {
                _local_6 = (_arg_2 - _arg_3);
                while (_local_6 <= (_arg_2 + _arg_3))
                {
                    if ((((_local_5 - _arg_1) * (_local_5 - _arg_1)) + ((_local_6 - _arg_2) * (_local_6 - _arg_2))) <= (_arg_3 * _arg_3))
                    {
                        if (getLevel(getFieldId(_local_5, _local_6), 1800, _arg_4) == -1)
                        {
                            return (false);
                        };
                    };
                    _local_6++;
                };
                _local_5++;
            };
            return (true);
        }

        public static function coordStringToFieldId(_arg_1:String):int
        {
            var _local_4:int;
            var _local_5:int;
            _arg_1 = _arg_1.replace(".", ",");
            var _local_2:Array = _arg_1.split(",");
            var _local_3:int = -1;
            if (_local_2.length == 2)
            {
                _local_4 = int(_local_2[0]);
                _local_5 = int(_local_2[1]);
                if (_arg_1 == ((_local_4 + ",") + _local_5))
                {
                    _local_3 = getFieldId(_local_4, _local_5);
                };
            };
            return (((_local_3 < 640000) || (_local_3 > -1)) ? _local_3 : -1);
        }

        public static function refreshBitmap(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_7:String;
            if (_arg_1 == showValleyFlag)
            {
                return;
            };
            showValleyFlag = _arg_1;
            _local_2 = 0;
            while (_local_2 < mapData.length)
            {
                _local_3 = 0;
                while (_local_3 < mapData[_local_2].length)
                {
                    mapData[_local_2][_local_3].fillRect(new Rectangle(0, 0, WPIECE, WPIECE), noFieldColor);
                    _local_3++;
                };
                _local_2++;
            };
            var _local_4:int;
            var _local_5:int;
            if (showValleyFlag)
            {
                for (_local_7 in map)
                {
                    _local_4 = getX(int(_local_7));
                    _local_5 = getY(int(_local_7));
                    if (map[int(_local_7)] == ((FieldConstants.TYPE_NPC * 16) + 10))
                    {
                        mapData[int(((_local_4 % WIDTH) / WPIECE))][int(((_local_5 % HEIGHT) / WPIECE))].setPixel((_local_4 % WPIECE), (_local_5 % WPIECE), npc10Color);
                    }
                    else
                    {
                        mapData[int(((_local_4 % WIDTH) / WPIECE))][int(((_local_5 % HEIGHT) / WPIECE))].setPixel((_local_4 % WPIECE), (_local_5 % WPIECE), FIELD_COLORS[int((map[int(_local_7)] / 16))]);
                    };
                };
            };
            var _local_6:MapCastleBean;
            for each (_local_6 in castles)
            {
                _local_4 = getX(_local_6.id);
                _local_5 = getY(_local_6.id);
                if ((((!(_local_6.npc)) && (_local_6.relation >= 0)) && (_local_6.relation <= RELATION_COLORS.length)))
                {
                    if (_local_6.userName == MainScreen.getPlayer().playerInfo.userName)
                    {
                        mapData[int((_local_4 / WPIECE))][int((_local_5 / WPIECE))].setPixel((_local_4 % WPIECE), (_local_5 % WPIECE), ownColor);
                    }
                    else
                    {
                        if (((!(_local_6.allianceName == null)) && (!(neutralAlliances.getItemIndex(_local_6.allianceName) == -1))))
                        {
                            mapData[int(((_local_4 % WIDTH) / WPIECE))][int(((_local_5 % HEIGHT) / WPIECE))].setPixel((_local_4 % WPIECE), (_local_5 % WPIECE), neutralColor);
                        }
                        else
                        {
                            mapData[int((_local_4 / WPIECE))][int((_local_5 / WPIECE))].setPixel((_local_4 % WPIECE), (_local_5 % WPIECE), RELATION_COLORS[_local_6.relation]);
                        };
                    };
                };
            };
        }

        public static function listCastles(_arg_1:int, _arg_2:int, _arg_3:int):Array
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int = getX(_arg_1);
            var _local_7:int = getY(_arg_1);
            var _local_8:int = getX(_arg_2);
            var _local_9:int = getY(_arg_2);
            var _local_10:Array = new Array();
            var _local_11:MapCastleBean;
            for each (_local_11 in castles)
            {
                if (!((_local_11.npc) || (_local_11.prestige < _arg_3)))
                {
                    _local_4 = getX(_local_11.id);
                    _local_5 = getY(_local_11.id);
                    if (((((_local_4 - _local_6) * (_local_4 - _local_8)) <= 0) && (((_local_5 - _local_7) * (_local_5 - _local_9)) <= 0)))
                    {
                        _local_10.push(_local_11);
                    };
                };
            };
            return (_local_10);
        }


    }
}//package autoevony.player

