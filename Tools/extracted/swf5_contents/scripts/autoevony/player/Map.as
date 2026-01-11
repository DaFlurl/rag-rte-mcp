package autoevony.player
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.MapCastleBean;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.beans.UnitAlliance;
   import com.evony.common.constants.AllianceConstants;
   import com.evony.common.constants.FieldConstants;
   import com.evony.common.module.alliance.AllianceFriendshipResponse;
   import com.evony.common.module.alliance.PlayerInfoResponse;
   import com.evony.common.module.common.MapInfoSimpleResponse;
   import com.evony.common.module.field.OtherFieldInfoResponse;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mx.collections.ArrayList;
   
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
      
      public static const ownColor:uint = 16747520;
      
      public static const noFieldColor:uint = 8355711;
      
      public static const neutralColor:uint = 16765043;
      
      private static var neutralAlliances:ArrayList = new ArrayList();
      
      private static const FIELD_COLORS:Array = new Array(8355711,14741216,16764108,13434726,12357519,11529966,2003199,8355711,8355711,8355711,9144713,16777215,4210736);
      
      private static const RELATION_COLORS:Array = new Array(65280,65535,13566159,16711680);
      
      public static const FIELD_NAMES:Array = new Array("","Forest","Desert","Hill","Swamp","GrassLand","Lake","","","","Flat","Castle","NPC");
      
      public static const TITLES:ArrayList = new ArrayList(["Civilian","Knight","Baronet","Baron","Viscount","Earl","Marquis","Duke","Furstin","Prinzessin"]);
      
      private static const REGIONS:Array = new Array(new Array("Friesland","Lower Lorraine","Upper Lorraine","Burgundy"),new Array("Saxony","Franconia","Swabia","Lombardy"),new Array("North March","Thuringia","Bavaria","Tuscany"),new Array("Bohemia","Moravia","Carinthia","Romagna"));
      
      private static var fetchDetailTimer:Timer = null;
      
      private static var cacheCleanupTimer:Timer = null;
      
      private static const isTrace:Boolean = Version.isTraceMapOn();
      
      public function Map()
      {
         super();
      }
      
      public static function fieldDistance(param1:int, param2:int) : Number
      {
         var _loc3_:int = getX(param1);
         var _loc4_:int = getY(param1);
         var _loc5_:int = getX(param2);
         var _loc6_:int = getY(param2);
         var _loc7_:Number = Math.abs(_loc3_ - _loc5_);
         _loc7_ = Math.min(_loc7_,WIDTH - _loc7_);
         var _loc8_:Number = Math.abs(_loc4_ - _loc6_);
         _loc8_ = Math.min(_loc8_,HEIGHT - _loc8_);
         return Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
      }
      
      public static function updateInfo(param1:int) : void
      {
         if(map[param1] != undefined)
         {
            mapCacheTime[param1] = 0;
         }
         cacheMap(param1);
      }
      
      private static function handleAllianceFriendshipResponse(param1:AllianceFriendshipResponse) : void
      {
         var _loc2_:UnitAlliance = null;
         neutralAlliances.removeAll();
         if(param1.ok != 1)
         {
            return;
         }
         for each(_loc2_ in param1.middleListArray)
         {
            neutralAlliances.addItem(_loc2_.allianceName);
         }
         showValleyFlag = !showValleyFlag;
         refreshBitmap(!showValleyFlag);
      }
      
      public static function isInArea(param1:int, param2:int, param3:int) : Boolean
      {
         return isBetween(getX(param1),getX(param2),WIDTH,getX(param3)) && isBetween(getY(param1),getY(param2),WIDTH,getY(param3));
      }
      
      public static function getStateName(param1:int) : String
      {
         if(param1 == 1)
         {
            return "peace";
         }
         if(param1 == 2)
         {
            return "truce";
         }
         if(param1 == 3)
         {
            return "beginner";
         }
         if(param1 == 4)
         {
            return "war";
         }
         if(param1 == 5)
         {
            return "holiday";
         }
         if(param1 == 6)
         {
            return "dream";
         }
         return "state:" + param1;
      }
      
      private static function handleCleanUpTimer(param1:TimerEvent) : void
      {
         deleteStaleRecords(detail,detailCacheTime,8 * 3600 * 1000);
         deleteStaleRecords(castles,castlesCacheTime,8 * 3600 * 1000);
         deleteStaleRecords(map,mapCacheTime,8 * 3600 * 1000);
         deleteStaleRecords(players,playersCacheTime,8 * 3600 * 1000);
         if(MainScreen.getPlayer().playerInfo.alliance != null)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
         }
      }
      
      public static function getPlayerInfo(param1:String, param2:int = 3600) : PlayerInfoBean
      {
         param1 = param1.toLowerCase();
         if(players[param1] == undefined || playersCacheTime[param1] == undefined || new Date().getTime() > playersCacheTime[param1] + param2 * 1000)
         {
            reqPlayerInfo(param1);
         }
         if(players[param1] == undefined)
         {
            return null;
         }
         return players[param1];
      }
      
      public static function initMap(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         WIDTH = param1;
         HEIGHT = param2;
         if(mapData == null)
         {
            mapData = new Array(WIDTH / WPIECE);
            _loc3_ = 0;
            while(_loc3_ < mapData.length)
            {
               mapData[_loc3_] = new Array(HEIGHT / WPIECE);
               _loc4_ = 0;
               while(_loc4_ < mapData[_loc3_].length)
               {
                  mapData[_loc3_][_loc4_] = new BitmapData(WPIECE,WPIECE,false,noFieldColor);
                  _loc4_++;
               }
               _loc3_++;
            }
         }
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE,handleMapInfoSimpleResponse);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.FIELD_GET_OTHER_FIELD_INFO,handleOtherFieldInfoResponse);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST,handleAllianceFriendshipResponse);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_MAP_INFO_SIMPLE,handleMapInfoSimpleResponse);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FIELD_GET_OTHER_FIELD_INFO,handleOtherFieldInfoResponse);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST,handleAllianceFriendshipResponse);
         if(MainScreen.getPlayer().playerInfo.alliance != null)
         {
            Utils.callLater(15 * 60 * 1000,ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList);
         }
      }
      
      public static function fieldIdToCoordString(param1:int) : String
      {
         return "(" + getX(param1) + "," + getY(param1) + ")";
      }
      
      public static function fieldIdToString(param1:int) : String
      {
         var _loc6_:MapCastleBean = null;
         var _loc2_:int = getLevel(param1);
         var _loc3_:int = getType(param1);
         if(_loc2_ == 10 && (_loc3_ == FieldConstants.TYPE_NPC || _loc3_ == FieldConstants.TYPE_CASTLE))
         {
            _loc6_ = getDetailInfo(param1);
            if(_loc6_ != null)
            {
               _loc2_ = 18 - 2 * _loc6_.powerLevel;
            }
         }
         var _loc4_:String = _loc2_ > 10 && _loc3_ == FieldConstants.TYPE_NPC ? "HC" : (_loc3_ == -1 ? "" : FIELD_NAMES[_loc3_]);
         var _loc5_:String = _loc2_ == -1 ? "" : "" + _loc2_;
         return _loc4_ + " " + _loc5_ + "(" + getX(param1) + "," + getY(param1) + ")";
      }
      
      public static function getDetail(param1:int, param2:int = 1800) : MapCastleBean
      {
         if(detailCacheTime[param1] == undefined || detailCacheTime[param1] < new Date().getTime() - param2 * 1000)
         {
            cacheDetail(param1);
         }
         if(detail[param1] == undefined)
         {
            return null;
         }
         return detail[param1];
      }
      
      private static function getOwnerInfo(param1:MapCastleBean) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:PlayerInfoBean = null;
         if(param1.userName != null)
         {
            _loc2_ = getPlayerInfo(param1.userName);
         }
         return "Status: " + getStateName(param1.state) + "\n" + param1.name + " in " + param1.zoneName + (param1.userName == null ? "\nNo owner" : "\nOwner: " + param1.userName) + (param1.allianceName == null ? "" : "\nAlliance: " + param1.allianceName) + (param1.userName == null ? "" : "\nPrestige: " + param1.prestige + "\nHonor: " + param1.honor) + (param1.userName == null ? "" : (_loc2_ == null ? "\n[Double click to fetch player information]" : "\nRank: " + _loc2_.ranking + "\nTitle: " + TITLES.getItemAt(_loc2_.titleId) + "\nCastle: " + _loc2_.castleCount + "/" + (_loc2_.titleId + 1) + "\nTotal pop: " + _loc2_.population)) + (param1.suzerain == null ? "" : "\nSuzerain: " + param1.suzerain);
      }
      
      public static function updateDetailInfo(param1:int) : void
      {
         if(detail[param1] != undefined)
         {
            detailCacheTime[param1] = 0;
         }
         cacheDetail(param1);
      }
      
      private static function handleOtherFieldInfoResponse(param1:OtherFieldInfoResponse) : void
      {
         if(param1.ok != 1)
         {
            if(isTrace)
            {
               trace("Unable to obtain field info: " + param1.msg);
            }
            return;
         }
         detail[param1.bean.id] = param1.bean;
         detailCacheTime[param1.bean.id] = new Date().getTime();
      }
      
      private static function onFetchDetailTimer(param1:TimerEvent) : void
      {
         if(pendingFieldId.length == 0)
         {
            fetchDetailTimer.reset();
            fetchDetailTimer.removeEventListener(TimerEvent.TIMER,onFetchDetailTimer);
            fetchDetailTimer = null;
            return;
         }
         var _loc2_:int = int(pendingFieldId.shift());
         if(detail[_loc2_] == undefined || detailCacheTime[_loc2_] == undefined || detailCacheTime[_loc2_] < new Date().getTime() - 3600 * 1000)
         {
            if(isTrace)
            {
               trace("Get detail info at " + getX(_loc2_) + "," + getY(_loc2_));
            }
            ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(MainScreen.getClosestCityToFieldId(_loc2_).castleId,_loc2_);
         }
      }
      
      public static function fullResetMap() : void
      {
         resetMap();
         castles = new Object();
         castlesCacheTime = new Object();
         players = new Object();
         playersCacheTime = new Object();
      }
      
      public static function reqPlayerInfo(param1:String, param2:Boolean = false) : void
      {
         param1 = param1.toLowerCase();
         if(param2 || players[param1] == undefined || playersCacheTime[param1] == undefined || new Date().getTime() > playersCacheTime[param1] + 3600 * 1000)
         {
            ActionFactory.getInstance().getCommonCommands().getPlayerInfoByName(param1,handleReqPlayerInfoResponse);
         }
      }
      
      public static function cacheDetail(param1:int, param2:Boolean = false) : void
      {
         if(!param2 && pendingFieldId.length > 100)
         {
            return;
         }
         if(pendingFieldId.indexOf(param1) == -1)
         {
            if(param2)
            {
               pendingFieldId.splice(0,0,param1);
            }
            else
            {
               pendingFieldId.push(param1);
            }
         }
         if(fetchDetailTimer == null)
         {
            fetchDetailTimer = new Timer(1500);
            fetchDetailTimer.addEventListener(TimerEvent.TIMER,onFetchDetailTimer);
            fetchDetailTimer.start();
         }
      }
      
      public static function cacheMap(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:Date = new Date();
         if(!param2 && lastCacheMapTime != null && _loc4_.getTime() - lastCacheMapTime.getTime() < 2000)
         {
            return;
         }
         lastCacheMapTime = _loc4_;
         var _loc5_:int = param3 ? LWSIZE : WSIZE;
         var _loc6_:int = int(getX(param1) / _loc5_) * _loc5_;
         var _loc7_:int = int(getY(param1) / _loc5_) * _loc5_;
         if(isTrace)
         {
            trace("Get map at " + _loc6_ + "," + _loc7_ + ", size: " + _loc5_);
         }
         var _loc8_:int = MainScreen.getClosestCityToFieldId(param1).castle.id;
         ActionFactory.getInstance().getCommonCommands().mapInfoSimple(_loc8_,_loc6_,_loc7_,_loc6_ + _loc5_ - 1,_loc7_ + _loc5_ - 1);
      }
      
      public static function resetArea(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc5_ = param1 - param3;
         while(_loc5_ <= param1 + param3)
         {
            _loc6_ = param2 - param3;
            while(_loc6_ <= param2 + param3)
            {
               if((_loc5_ - param1) * (_loc5_ - param1) + (_loc6_ - param2) * (_loc6_ - param2) <= param3 * param3)
               {
                  _loc4_ = getFieldId(_loc5_,_loc6_);
                  if(map[_loc4_] != undefined)
                  {
                     delete map[_loc4_];
                  }
                  if(mapCacheTime[_loc4_] != undefined)
                  {
                     delete mapCacheTime[_loc4_];
                  }
                  if(detail[_loc4_] != undefined)
                  {
                     delete detail[_loc4_];
                  }
                  if(detailCacheTime[_loc4_] != undefined)
                  {
                     delete detailCacheTime[_loc4_];
                  }
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      private static function isBetween(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = Math.abs(param1 - param2);
         if(_loc5_ < param3 - _loc5_)
         {
            return (param4 - param1) * (param4 - param2) <= 0;
         }
         return (param4 - param1) * (param4 - param2) >= 0;
      }
      
      public static function getFieldId(param1:int, param2:int) : int
      {
         if(param1 >= WIDTH)
         {
            param1 -= WIDTH;
         }
         if(param1 < 0)
         {
            param1 += WIDTH;
         }
         if(param2 >= HEIGHT)
         {
            param2 -= HEIGHT;
         }
         if(param2 < 0)
         {
            param2 += HEIGHT;
         }
         return param2 * WIDTH + param1;
      }
      
      public static function searchFields(param1:String) : Array
      {
         var _loc3_:MapCastleBean = null;
         param1 = param1.toLowerCase();
         var _loc2_:Array = new Array();
         for each(_loc3_ in detail)
         {
            if(_loc3_.allianceName != null && _loc3_.allianceName.toLowerCase() == param1 || _loc3_.name != null && _loc3_.name.toLowerCase() == param1 || _loc3_.userName != null && _loc3_.userName.toLowerCase() == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private static function handleReqPlayerInfoResponse(param1:PlayerInfoResponse) : void
      {
         if(param1.ok != 1)
         {
            return;
         }
         players[param1.playerInfo.userName.toLowerCase()] = param1.playerInfo;
         playersCacheTime[param1.playerInfo.userName.toLowerCase()] = new Date().getTime();
      }
      
      public static function resetMap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         map = new Object();
         mapCacheTime = new Object();
         detail = new Object();
         detailCacheTime = new Object();
         _loc1_ = 0;
         while(_loc1_ < mapData.length)
         {
            _loc2_ = 0;
            while(_loc2_ < mapData[_loc1_].length)
            {
               mapData[_loc1_][_loc2_].fillRect(new Rectangle(0,0,WPIECE,WPIECE),8355711);
               _loc2_++;
            }
            _loc1_++;
         }
         if(cacheCleanupTimer == null)
         {
            cacheCleanupTimer = new Timer(60 * 60 * 1000);
            cacheCleanupTimer.addEventListener(TimerEvent.TIMER,handleCleanUpTimer);
            cacheCleanupTimer.start();
         }
      }
      
      public static function getRegionName(param1:int) : String
      {
         return REGIONS[Math.floor(getX(param1) / 200)][Math.floor(getY(param1) / 200)];
      }
      
      public static function searchEnemyFields(param1:String) : Array
      {
         var _loc3_:MapCastleBean = null;
         var _loc2_:Array = new Array();
         param1 = param1.toLowerCase();
         for each(_loc3_ in detail)
         {
            if(_loc3_.relation == AllianceConstants.ENEMY_ALLIANCE)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function searchEnemyCastles(param1:String) : Array
      {
         param1 = param1.toLowerCase();
         var _loc2_:Array = new Array();
         var _loc3_:MapCastleBean = null;
         for each(_loc3_ in castles)
         {
            if(_loc3_.relation == AllianceConstants.ENEMY_ALLIANCE)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function getDetailInfo(param1:int, param2:int = 1800) : MapCastleBean
      {
         var _loc3_:int = getType(param1,param2);
         if(_loc3_ != FieldConstants.TYPE_CASTLE && _loc3_ != FieldConstants.TYPE_NPC)
         {
            return null;
         }
         if(detail[param1] == undefined)
         {
            return null;
         }
         return detail[param1];
      }
      
      public static function getFieldType(param1:String) : int
      {
         param1 = param1.toLowerCase();
         if(param1 == "hc")
         {
            return FieldConstants.TYPE_NPC;
         }
         var _loc2_:int = 0;
         while(_loc2_ < FIELD_NAMES.length)
         {
            if(FIELD_NAMES[_loc2_].length != 0)
            {
               if(FIELD_NAMES[_loc2_].toLowerCase() == param1)
               {
                  return _loc2_;
               }
            }
            _loc2_++;
         }
         return -1;
      }
      
      public static function isMapDetailReady(param1:int, param2:int, param3:Number) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!isMapReady(param1,param2,param3))
         {
            return false;
         }
         var _loc4_:int = 0;
         _loc5_ = param1 - param3;
         while(_loc5_ <= param1 + param3)
         {
            _loc6_ = param2 - param3;
            while(_loc6_ <= param2 + param3)
            {
               if((_loc5_ - param1) * (_loc5_ - param1) + (_loc6_ - param2) * (_loc6_ - param2) <= param3 * param3)
               {
                  _loc4_ = getFieldId(_loc5_,_loc6_);
                  if(getType(_loc4_) < FieldConstants.TYPE_CASTLE)
                  {
                     if(getDetail(_loc4_) == null)
                     {
                        return false;
                     }
                  }
               }
               _loc6_++;
            }
            _loc5_++;
         }
         return true;
      }
      
      private static function handleMapInfoSimpleResponse(param1:MapInfoSimpleResponse) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:MapCastleBean = null;
         lastCacheMapTime = null;
         if(param1.ok != 1)
         {
            if(isTrace)
            {
               trace("Unable to obtain map: " + param1.msg);
            }
            return;
         }
         if(param1.mapStr == null)
         {
            if(isTrace)
            {
               trace("INVALID MAP RESPONSE RECEIVED -- NO MAP AVAILABLE!!!");
            }
            return;
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = param1.x2 - param1.x1 + 1;
         var _loc8_:Number = Number(new Date().getTime());
         _loc7_ = param1.y1;
         while(_loc7_ <= param1.y2)
         {
            _loc6_ = param1.x1;
            while(_loc6_ <= param1.x2)
            {
               _loc2_ = 2 * ((_loc7_ - param1.y1) * _loc5_ + (_loc6_ - param1.x1));
               map[getFieldId(_loc6_,_loc7_)] = _loc3_ = int("0x" + param1.mapStr.substr(_loc2_,2));
               mapCacheTime[getFieldId(_loc6_,_loc7_)] = _loc8_;
               _loc4_ = noFieldColor;
               if(showValleyFlag)
               {
                  if(_loc3_ != FieldConstants.TYPE_NPC * 16 + 10)
                  {
                     _loc4_ = uint(FIELD_COLORS[int(_loc3_ / 16)]);
                  }
                  else
                  {
                     _loc4_ = npc10Color;
                  }
               }
               mapData[int(_loc6_ % WIDTH / WPIECE)][int(_loc7_ % HEIGHT / WPIECE)].setPixel(_loc6_ % WPIECE,_loc7_ % WPIECE,_loc4_);
               _loc6_++;
            }
            _loc7_++;
         }
         _loc8_ = Number(new Date().getTime());
         for each(_loc9_ in param1.castlesArray)
         {
            castles[_loc9_.id] = _loc9_;
            castlesCacheTime[_loc9_.id] = _loc8_;
            detail[_loc9_.id] = _loc9_;
            detailCacheTime[_loc9_.id] = _loc8_;
            if(!_loc9_.npc && _loc9_.relation >= 0 && _loc9_.relation <= RELATION_COLORS.length)
            {
               _loc6_ = getX(_loc9_.id);
               _loc7_ = getY(_loc9_.id);
               if(_loc9_.userName == MainScreen.getPlayer().playerInfo.userName)
               {
                  mapData[int(_loc6_ % WIDTH / WPIECE)][int(_loc7_ % HEIGHT / WPIECE)].setPixel(_loc6_ % WPIECE,_loc7_ % WPIECE,ownColor);
               }
               else if(_loc9_.allianceName != null && neutralAlliances.getItemIndex(_loc9_.allianceName) != -1)
               {
                  mapData[int(_loc6_ % WIDTH / WPIECE)][int(_loc7_ % HEIGHT / WPIECE)].setPixel(_loc6_ % WPIECE,_loc7_ % WPIECE,neutralColor);
               }
               else
               {
                  mapData[int(_loc6_ % WIDTH / WPIECE)][int(_loc7_ % HEIGHT / WPIECE)].setPixel(_loc6_ % WPIECE,_loc7_ % WPIECE,RELATION_COLORS[_loc9_.relation]);
               }
            }
         }
      }
      
      public static function fieldIdToCoordinate(param1:int) : String
      {
         return getX(param1) + "," + getY(param1);
      }
      
      public static function searchCastlesWithinArea(param1:String, param2:int, param3:int) : Array
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         param1 = param1.toLowerCase();
         var _loc4_:Array = new Array();
         var _loc5_:MapCastleBean = null;
         var _loc6_:int = getX(param2);
         var _loc7_:int = getY(param2);
         var _loc8_:int = getX(param3);
         var _loc9_:int = getY(param3);
         for each(_loc5_ in castles)
         {
            if(isInArea(param2,param3,_loc5_.id))
            {
               if(_loc5_.allianceName != null && _loc5_.allianceName.toLowerCase().indexOf(param1) != -1 || _loc5_.name != null && _loc5_.name.toLowerCase().indexOf(param1) != -1 || _loc5_.userName != null && _loc5_.userName.toLowerCase().indexOf(param1) != -1)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         return _loc4_;
      }
      
      public static function getToolTip(param1:int, param2:int, param3:int) : String
      {
         var _loc4_:int = getFieldId(param2,param3);
         var _loc5_:String = "" + int(fieldDistance(_loc4_,param1) * 100) / 100;
         var _loc6_:String = "" + int(fieldDistance(_loc4_,MainScreen.getInstance().getSelectedCity().castle.fieldId) * 100) / 100;
         if(map[_loc4_] == undefined || map[_loc4_] == null)
         {
            return "(" + param2 + "," + param3 + ")" + "\nDistance: " + _loc5_ + "\n[Click to fetch map]";
         }
         var _loc7_:int = getType(_loc4_);
         var _loc8_:int = getLevel(_loc4_);
         return fieldIdToString(_loc4_) + "\nDistance from city: " + _loc6_ + "\nDistance from coord: " + _loc5_ + "\n" + (detail[_loc4_] == undefined ? "[Click to fetch ownership information]" : getOwnerInfo(detail[_loc4_]));
      }
      
      public static function searchCastles(param1:String) : Array
      {
         param1 = param1.toLowerCase();
         var _loc2_:Array = new Array();
         var _loc3_:MapCastleBean = null;
         for each(_loc3_ in castles)
         {
            if(_loc3_.allianceName != null && _loc3_.allianceName.toLowerCase().indexOf(param1) != -1 || _loc3_.name != null && _loc3_.name.toLowerCase().indexOf(param1) != -1 || _loc3_.userName != null && _loc3_.userName.toLowerCase().indexOf(param1) != -1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function getType(param1:int, param2:int = 1800) : int
      {
         if(mapCacheTime[param1] == undefined || mapCacheTime[param1] < new Date().getTime() - param2 * 1000)
         {
            cacheMap(param1);
         }
         if(map[param1] == undefined || map[param1] == null)
         {
            return -1;
         }
         return map[param1] / 16;
      }
      
      private static function deleteStaleRecords(param1:Object, param2:Object, param3:Number) : void
      {
         var _loc5_:* = undefined;
         var _loc4_:Number = Number(new Date().getTime());
         for(_loc5_ in param2)
         {
            if(param2[_loc5_] < _loc4_ - param3)
            {
               delete param2[_loc5_];
               delete param1[_loc5_];
            }
         }
      }
      
      public static function reqMapInfoAndDetail(param1:int) : void
      {
         var _loc2_:int = int(getX(param1) / WSIZE) * WSIZE;
         var _loc3_:int = int(getY(param1) / WSIZE) * WSIZE;
         var _loc4_:int = MainScreen.getClosestCityToFieldId(param1).castle.id;
         ActionFactory.getInstance().getCommonCommands().mapInfoSimple(_loc4_,_loc2_,_loc3_,_loc2_ + WSIZE - 1,_loc3_ + WSIZE - 1);
         ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(_loc4_,param1);
      }
      
      public static function getX(param1:int) : int
      {
         return param1 % WIDTH;
      }
      
      public static function getY(param1:int) : int
      {
         return param1 / WIDTH;
      }
      
      public static function getLevel(param1:int, param2:int = 1800, param3:Boolean = false) : int
      {
         if(mapCacheTime[param1] == undefined || mapCacheTime[param1] < new Date().getTime() - param2 * 1000)
         {
            cacheMap(param1,false,param3);
         }
         if(map[param1] == undefined || map[param1] == null)
         {
            return -1;
         }
         return map[param1] % 16;
      }
      
      public static function resetRectangle(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc6_ = param1;
         while(_loc6_ <= param3)
         {
            _loc7_ = param2;
            while(_loc7_ <= param4)
            {
               _loc5_ = getFieldId(_loc6_,_loc7_);
               if(map[_loc5_] != undefined)
               {
                  delete map[_loc5_];
               }
               if(mapCacheTime[_loc5_] != undefined)
               {
                  delete mapCacheTime[_loc5_];
               }
               if(detail[_loc5_] != undefined)
               {
                  delete detail[_loc5_];
               }
               if(detailCacheTime[_loc5_] != undefined)
               {
                  delete detailCacheTime[_loc5_];
               }
               _loc7_++;
            }
            _loc6_++;
         }
      }
      
      public static function searchSuzerain(param1:String) : Array
      {
         var _loc3_:MapCastleBean = null;
         var _loc2_:Array = new Array();
         param1 = param1.toLowerCase();
         for each(_loc3_ in castles)
         {
            if(!_loc3_.npc)
            {
               if(_loc3_.suzerain == null && param1 == "none" || _loc3_.suzerain != null && _loc3_.suzerain.toLowerCase() == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public static function getMapData() : Array
      {
         return mapData;
      }
      
      public static function isMapReady(param1:int, param2:int, param3:Number, param4:Boolean = false) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc5_ = param1 - param3;
         while(_loc5_ <= param1 + param3)
         {
            _loc6_ = param2 - param3;
            while(_loc6_ <= param2 + param3)
            {
               if((_loc5_ - param1) * (_loc5_ - param1) + (_loc6_ - param2) * (_loc6_ - param2) <= param3 * param3)
               {
                  if(getLevel(getFieldId(_loc5_,_loc6_),1800,param4) == -1)
                  {
                     return false;
                  }
               }
               _loc6_++;
            }
            _loc5_++;
         }
         return true;
      }
      
      public static function coordStringToFieldId(param1:String) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         param1 = param1.replace(".",",");
         var _loc2_:Array = param1.split(",");
         var _loc3_:int = -1;
         if(_loc2_.length == 2)
         {
            _loc4_ = int(_loc2_[0]);
            _loc5_ = int(_loc2_[1]);
            if(param1 == _loc4_ + "," + _loc5_)
            {
               _loc3_ = getFieldId(_loc4_,_loc5_);
            }
         }
         return _loc3_ < 640000 || _loc3_ > -1 ? _loc3_ : -1;
      }
      
      public static function refreshBitmap(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:String = null;
         if(param1 == showValleyFlag)
         {
            return;
         }
         showValleyFlag = param1;
         _loc2_ = 0;
         while(_loc2_ < mapData.length)
         {
            _loc3_ = 0;
            while(_loc3_ < mapData[_loc2_].length)
            {
               mapData[_loc2_][_loc3_].fillRect(new Rectangle(0,0,WPIECE,WPIECE),noFieldColor);
               _loc3_++;
            }
            _loc2_++;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(showValleyFlag)
         {
            for(_loc7_ in map)
            {
               _loc4_ = getX(int(_loc7_));
               _loc5_ = getY(int(_loc7_));
               if(map[int(_loc7_)] == FieldConstants.TYPE_NPC * 16 + 10)
               {
                  mapData[int(_loc4_ % WIDTH / WPIECE)][int(_loc5_ % HEIGHT / WPIECE)].setPixel(_loc4_ % WPIECE,_loc5_ % WPIECE,npc10Color);
               }
               else
               {
                  mapData[int(_loc4_ % WIDTH / WPIECE)][int(_loc5_ % HEIGHT / WPIECE)].setPixel(_loc4_ % WPIECE,_loc5_ % WPIECE,FIELD_COLORS[int(map[int(_loc7_)] / 16)]);
               }
            }
         }
         var _loc6_:MapCastleBean = null;
         for each(_loc6_ in castles)
         {
            _loc4_ = getX(_loc6_.id);
            _loc5_ = getY(_loc6_.id);
            if(!_loc6_.npc && _loc6_.relation >= 0 && _loc6_.relation <= RELATION_COLORS.length)
            {
               if(_loc6_.userName == MainScreen.getPlayer().playerInfo.userName)
               {
                  mapData[int(_loc4_ / WPIECE)][int(_loc5_ / WPIECE)].setPixel(_loc4_ % WPIECE,_loc5_ % WPIECE,ownColor);
               }
               else if(_loc6_.allianceName != null && neutralAlliances.getItemIndex(_loc6_.allianceName) != -1)
               {
                  mapData[int(_loc4_ % WIDTH / WPIECE)][int(_loc5_ % HEIGHT / WPIECE)].setPixel(_loc4_ % WPIECE,_loc5_ % WPIECE,neutralColor);
               }
               else
               {
                  mapData[int(_loc4_ / WPIECE)][int(_loc5_ / WPIECE)].setPixel(_loc4_ % WPIECE,_loc5_ % WPIECE,RELATION_COLORS[_loc6_.relation]);
               }
            }
         }
      }
      
      public static function listCastles(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = getX(param1);
         var _loc7_:int = getY(param1);
         var _loc8_:int = getX(param2);
         var _loc9_:int = getY(param2);
         var _loc10_:Array = new Array();
         var _loc11_:MapCastleBean = null;
         for each(_loc11_ in castles)
         {
            if(!(Boolean(_loc11_.npc) || _loc11_.prestige < param3))
            {
               _loc4_ = getX(_loc11_.id);
               _loc5_ = getY(_loc11_.id);
               if((_loc4_ - _loc6_) * (_loc4_ - _loc8_) <= 0 && (_loc5_ - _loc7_) * (_loc5_ - _loc9_) <= 0)
               {
                  _loc10_.push(_loc11_);
               }
            }
         }
         return _loc10_;
      }
   }
}

