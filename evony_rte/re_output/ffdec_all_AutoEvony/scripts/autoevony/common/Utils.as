package autoevony.common
{
   import autoevony.player.Map;
   import com.evony.common.beans.AllProduceBean;
   import com.evony.common.beans.ArmyBean;
   import com.evony.common.beans.CastleBean;
   import com.evony.common.beans.FieldBean;
   import com.evony.common.beans.FortificationsBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.ProduceBean;
   import com.evony.common.beans.ResourceBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.beans.TroopStrBean;
   import com.evony.common.constants.ArmyConstants;
   import com.evony.common.constants.HeroConstants;
   import com.evony.common.constants.ObjConstants;
   import com.evony.common.constants.TFConstants;
   import flash.events.TimerEvent;
   import flash.system.Capabilities;
   import flash.utils.Timer;
   import mx.collections.ArrayCollection;
   
   public class Utils
   {
      
      public static var serverTimeAdjust:Number = 0;
      
      public static var serverTimeZoneAdjust:Number = 0;
      
      public static var disablingExpiredTime:Number = 0;
      
      private static var lastDesiredServerTimeAdjust:Number = 0;
      
      private static var serverTimeLag:Number = 0;
      
      public static var badWords:Array = new Array("anus","arse","arsehole","assbag","assbandit","assbanger","assbite","assclown","asscock","asscracker","asses","assface","assfuck","assfucker","assgoblin","asshat","asshead","asshole","asshopper","assjacker","asslick","asslicker","assmunch","assmuncher","asspirate","assshole","asswipe","bampot","bastard","beaner","bitch","bitches","bitchass","bitchtits","bitchy","blow job","blowjob","boner","brotherfucker","bullshit","bumblefuck","butt plug","butt","buttfucka","buttfucker","camel toe","carpetmuncher","chinc","chink","choad","chode","clit","clitfuck","cock","cockbite","cockface","cockfucker","cockknoker","cockmaster","cockmongruel","cockmonkey","cockmuncher","cockshit","cocksmoker","cocksucker","coochie","coochy","coon","cooter","cracker","cum","cumbubble","cumjockey","cumtart","cunnilingus","cunt","cunthole","deggo","dick","dickbag","dickbeaters","dickface","dickfuck","dickhead","dickhole","dickmonger","dicks","dickweed","dickwod","dildo","dipshit"
      ,"dookie","douche","douche","douchebag","douchewaffle","dumass","dumb ass","dumbass","dumbfuck","dumbshit","dumshit","dyke","fag","fagbag","fagfucker","faggit","faggot","fagtard","fatass","fellatio","feltch","fuck","fuckass","fuckbrain","fucked","fucker","fuckface","fuckhead","fuckhole","fuckin","fucking","fucknut","fucks","fuckstick","fucktard","fuckup","fuckwad","fuckwit","fuckwitt","fudgepacker","gay","gaybob","gaydo","gayfuck","gaytard","gaywad","girls","gooch","gook","gringo","guido","handjob","hard on","heeb","ho","homo","homodumbshit","honkey","humping","jackass","jap","jerk off","jigaboo","jizz","jungle bunny","junglebunny","kike","kooch","kootch","kyke","lesbian","lesbo","lezzie","lick","mcfagget","mick","minge","mothafucka","motherfucker","motherfucking","muff","muffdiver","munging","negro","nigger","iglet","nut sack","nutsack","paki","panooch","pecker","peckerhead","penis","penisfucker","piss","pissed","pissed off","pollock","poon","poonani","poonany","porch monkey","porchmonkey"
      ,"prick","punta","pussies","pussy","pussylicking","puto","queef","queer","queerbait","rape","renob","rimjob","ruski","sand nigger","sandnigger","sex","schlong","scrote","shit","shitbagger","shitcunt","shitdick","shitface","shitfaced","shithead","shithouse","shitspitter","shitstain","shitter","shittiest","shitting","shitty","skank","skeet","skullfuck","slut","sluts","slutbag","snatch","spic","spick","splooge","suck","tard","testicle","thundercunt","tit","titfuck","tits","tittyfuck","twat","twatlips","twats","twatwaffle","vag","vagina","vjayjay","wank","wetback","whore","whorebag","wop","shitt","shittt","shxt","pisss","cunt","cunts","fart","turd");
      
      public static const MISSION_NAMES:Array = new Array("","transport","reinforce","scout","buildcity","attack","","colonize","uprise","suppress","anticolonial","deploytroop");
      
      public static const TROOP_EXP_VALUES:Array = new Array(0,0,225,305,695,900,1350,1350,2975,2850,8750,10000,13750,29000);
      
      public static var troopIntNames:Array = new Array("","","peasants","militia","scouter","pikemen","swordsmen","archer","carriage","lightCavalry","heavyCavalry","ballista","batteringRam","catapult","trap","abatis","arrowTower","rollingLogs","rockfall");
      
      public static var troopExtNames:Array = new Array("","","worker","warrior","scout","pikemen","swordsmen","archer","transport","cavalry","cataphract","ballista","battering ram","catapult","trap","abatis","archer tower","rolling log","trebuchev");
      
      public static var troopAbrNames:Array = new Array("","","wo","w","s","p","sw","a","t","c","cata","b","r","cp","tra","ab","at","r","tre");
      
      private static var troopTypes:Array = new Array(TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_CARRIAGE,TFConstants.T_BALLISTA,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
      
      private static const uncertainValues:Object = {
         "Few":24,
         "Pack":49,
         "Lots":99,
         "Horde":249,
         "Throng":499,
         "Swarm":999,
         "Zounds":2499,
         "Legion":4999,
         "Bulk":10000,
         "Giga":3000000
      };
      
      public static var resourceIntNames:Array = new Array("food","wood","stone","iron","gold");
      
      public static var resourceAbrNames:Array = new Array("f","w","s","i","g");
      
      public static var HEROSPEEDUP:Array = new Array(1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2);
      
      private static const HEROEXPFACTOR:int = 150;
      
      private static var heroTypeCache:Array = new Array();
      
      private static var htmlCharMap:Object = {
         "&nbsp;":"&#160;",
         "&iexcl;":"&#161;",
         "&cent;":"&#162;",
         "&pound;":"&#163;",
         "&curren;":"&#164;",
         "&yen;":"&#165;",
         "&brvbar;":"&#166;",
         "&sect;":"&#167;",
         "&uml;":"&#168;",
         "&copy;":"&#169;",
         "&ordf;":"&#170;",
         "&laquo;":"&#171;",
         "&not;":"&#172;",
         "&shy;":"&#173;",
         "&reg;":"&#174;",
         "&macr;":"&#175;",
         "&deg;":"&#176;",
         "&plusmn;":"&#177;",
         "&sup2;":"&#178;",
         "&sup3;":"&#179;",
         "&acute;":"&#180;",
         "&micro;":"&#181;",
         "&para;":"&#182;",
         "&middot;":"&#183;",
         "&cedil;":"&#184;",
         "&sup1;":"&#185;",
         "&ordm;":"&#186;",
         "&raquo;":"&#187;",
         "&frac14;":"&#188;",
         "&frac12;":"&#189;",
         "&frac34;":"&#190;",
         "&iquest;":"&#191;",
         "&Agrave;":"&#192;",
         "&Aacute;":"&#193;",
         "&Acirc;":"&#194;",
         "&Atilde;":"&#195;",
         "&Auml;":"&#196;",
         "&Aring;":"&#197;",
         "&AElig;":"&#198;",
         "&Ccedil;":"&#199;",
         "&Egrave;":"&#200;",
         "&Eacute;":"&#201;",
         "&Ecirc;":"&#202;",
         "&Euml;":"&#203;",
         "&Igrave;":"&#204;",
         "&Iacute;":"&#205;",
         "&Icirc;":"&#206;",
         "&Iuml;":"&#207;",
         "&ETH;":"&#208;",
         "&Ntilde;":"&#209;",
         "&Ograve;":"&#210;",
         "&Oacute;":"&#211;",
         "&Ocirc;":"&#212;",
         "&Otilde;":"&#213;",
         "&Ouml;":"&#214;",
         "&times;":"&#215;",
         "&Oslash;":"&#216;",
         "&Ugrave;":"&#217;",
         "&Uacute;":"&#218;",
         "&Ucirc;":"&#219;",
         "&Uuml;":"&#220;",
         "&Yacute;":"&#221;",
         "&THORN;":"&#222;",
         "&szlig;":"&#223;",
         "&agrave;":"&#224;",
         "&aacute;":"&#225;",
         "&acirc;":"&#226;",
         "&atilde;":"&#227;",
         "&auml;":"&#228;",
         "&aring;":"&#229;",
         "&aelig;":"&#230;",
         "&ccedil;":"&#231;",
         "&egrave;":"&#232;",
         "&eacute;":"&#233;",
         "&ecirc;":"&#234;",
         "&euml;":"&#235;",
         "&igrave;":"&#236;",
         "&iacute;":"&#237;",
         "&icirc;":"&#238;",
         "&iuml;":"&#239;",
         "&eth;":"&#240;",
         "&ntilde;":"&#241;",
         "&ograve;":"&#242;",
         "&oacute;":"&#243;",
         "&ocirc;":"&#244;",
         "&otilde;":"&#245;",
         "&ouml;":"&#246;",
         "&divide;":"&#247;",
         "&oslash;":"&#248;",
         "&ugrave;":"&#249;",
         "&uacute;":"&#250;",
         "&ucirc;":"&#251;",
         "&uuml;":"&#252;",
         "&yacute;":"&#253;",
         "&thorn;":"&#254;",
         "&yuml;":"&#255;",
         "&fnof;":"&#402;",
         "&Alpha;":"&#913;",
         "&Beta;":"&#914;",
         "&Gamma;":"&#915;",
         "&Delta;":"&#916;",
         "&Epsilon;":"&#917;",
         "&Zeta;":"&#918;",
         "&Eta;":"&#919;",
         "&Theta;":"&#920;",
         "&Iota;":"&#921;",
         "&Kappa;":"&#922;",
         "&Lambda;":"&#923;",
         "&Mu;":"&#924;",
         "&Nu;":"&#925;",
         "&Xi;":"&#926;",
         "&Omicron;":"&#927;",
         "&Pi;":"&#928;",
         "&Rho;":"&#929;",
         "&Sigma;":"&#931;",
         "&Tau;":"&#932;",
         "&Upsilon;":"&#933;",
         "&Phi;":"&#934;",
         "&Chi;":"&#935;",
         "&Psi;":"&#936;",
         "&Omega;":"&#937;",
         "&alpha;":"&#945;",
         "&beta;":"&#946;",
         "&gamma;":"&#947;",
         "&delta;":"&#948;",
         "&epsilon;":"&#949;",
         "&zeta;":"&#950;",
         "&eta;":"&#951;",
         "&theta;":"&#952;",
         "&iota;":"&#953;",
         "&kappa;":"&#954;",
         "&lambda;":"&#955;",
         "&mu;":"&#956;",
         "&nu;":"&#957;",
         "&xi;":"&#958;",
         "&omicron;":"&#959;",
         "&pi;":"&#960;",
         "&rho;":"&#961;",
         "&sigmaf;":"&#962;",
         "&sigma;":"&#963;",
         "&tau;":"&#964;",
         "&upsilon;":"&#965;",
         "&phi;":"&#966;",
         "&chi;":"&#967;",
         "&psi;":"&#968;",
         "&omega;":"&#969;",
         "&thetasym;":"&#977;",
         "&upsih;":"&#978;",
         "&piv;":"&#982;",
         "&bull;":"&#8226;",
         "&hellip;":"&#8230;",
         "&prime;":"&#8242;",
         "&Prime;":"&#8243;",
         "&oline;":"&#8254;",
         "&frasl;":"&#8260;",
         "&weierp;":"&#8472;",
         "&image;":"&#8465;",
         "&real;":"&#8476;",
         "&trade;":"&#8482;",
         "&alefsym;":"&#8501;",
         "&larr;":"&#8592;",
         "&uarr;":"&#8593;",
         "&rarr;":"&#8594;",
         "&darr;":"&#8595;",
         "&harr;":"&#8596;",
         "&crarr;":"&#8629;",
         "&lArr;":"&#8656;",
         "&uArr;":"&#8657;",
         "&rArr;":"&#8658;",
         "&dArr;":"&#8659;",
         "&hArr;":"&#8660;",
         "&forall;":"&#8704;",
         "&part;":"&#8706;",
         "&exist;":"&#8707;",
         "&empty;":"&#8709;",
         "&nabla;":"&#8711;",
         "&isin;":"&#8712;",
         "&notin;":"&#8713;",
         "&ni;":"&#8715;",
         "&prod;":"&#8719;",
         "&sum;":"&#8721;",
         "&minus;":"&#8722;",
         "&lowast;":"&#8727;",
         "&radic;":"&#8730;",
         "&prop;":"&#8733;",
         "&infin;":"&#8734;",
         "&ang;":"&#8736;",
         "&and;":"&#8743;",
         "&or;":"&#8744;",
         "&cap;":"&#8745;",
         "&cup;":"&#8746;",
         "&int;":"&#8747;",
         "&there4;":"&#8756;",
         "&sim;":"&#8764;",
         "&cong;":"&#8773;",
         "&asymp;":"&#8776;",
         "&ne;":"&#8800;",
         "&equiv;":"&#8801;",
         "&le;":"&#8804;",
         "&ge;":"&#8805;",
         "&sub;":"&#8834;",
         "&sup;":"&#8835;",
         "&nsub;":"&#8836;",
         "&sube;":"&#8838;",
         "&supe;":"&#8839;",
         "&oplus;":"&#8853;",
         "&otimes;":"&#8855;",
         "&perp;":"&#8869;",
         "&sdot;":"&#8901;",
         "&lceil;":"&#8968;",
         "&rceil;":"&#8969;",
         "&lfloor;":"&#8970;",
         "&rfloor;":"&#8971;",
         "&lang;":"&#9001;",
         "&rang;":"&#9002;",
         "&loz;":"&#9674;",
         "&spades;":"&#9824;",
         "&clubs;":"&#9827;",
         "&hearts;":"&#9829;",
         "&diams;":"&#9830;",
         "\"":"&#34;",
         "&":"&#38;",
         "<":"&#60;",
         ">":"&#62;",
         "&OElig;":"&#338;",
         "&oelig;":"&#339;",
         "&Scaron;":"&#352;",
         "&scaron;":"&#353;",
         "&Yuml;":"&#376;",
         "&circ;":"&#710;",
         "&tilde;":"&#732;",
         "&ensp;":"&#8194;",
         "&emsp;":"&#8195;",
         "&thinsp;":"&#8201;",
         "&zwnj;":"&#8204;",
         "&zwj;":"&#8205;",
         "&lrm;":"&#8206;",
         "&rlm;":"&#8207;",
         "&ndash;":"&#8211;",
         "&mdash;":"&#8212;",
         "&lsquo;":"&#8216;",
         "&rsquo;":"&#8217;",
         "&sbquo;":"&#8218;",
         "&ldquo;":"&#8220;",
         "&rdquo;":"&#8221;",
         "&bdquo;":"&#8222;",
         "&dagger;":"&#8224;",
         "&Dagger;":"&#8225;",
         "&permil;":"&#8240;",
         "&lsaquo;":"&#8249;",
         "&rsaquo;":"&#8250;",
         "&euro;":"&#8364;"
      };
      
      public function Utils()
      {
         super();
      }
      
      public static function getMaxStatValueByType(param1:HeroBean, param2:String) : Number
      {
         return param1[param2] * (100 + param1[param2 + "BuffAdded"]) / 100 + param1.politics + param1.attack + param1.intelligence;
      }
      
      public static function getStringBetween(param1:String, param2:String, param3:String) : String
      {
         if(param1.indexOf(param2) == -1)
         {
            return null;
         }
         if(param1.indexOf(param3,param1.indexOf(param2) + param2.length) == -1)
         {
            return null;
         }
         return param1.substring(param1.indexOf(param2) + param2.length,param1.indexOf(param3,param1.indexOf(param2) + param2.length));
      }
      
      public static function getServerLagTime() : Number
      {
         return serverTimeLag;
      }
      
      public static function specialCharFilter(param1:String) : Boolean
      {
         var _loc2_:String = "\"\'";
         var _loc3_:Array = param1.split("");
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc2_.indexOf(_loc3_[_loc4_]) > -1)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function formatNum(param1:Number, param2:int = 50) : String
      {
         var _loc7_:int = 0;
         if(isNaN(param1))
         {
            return "";
         }
         if(param2 < 1)
         {
            param2 = 0;
         }
         var _loc3_:* = param1 + "";
         var _loc4_:String = "";
         if(param1 < 0)
         {
            _loc4_ = "-";
            _loc3_ = _loc3_.substring(1);
         }
         var _loc5_:Array = _loc3_.split(".");
         var _loc6_:int = int(_loc5_[0].length);
         if(param1 <= -1000 || param1 >= 1000)
         {
            _loc3_ = _loc5_[0].substring(_loc6_ - 3,_loc6_);
            _loc7_ = 3;
            while(_loc7_ < _loc6_)
            {
               if(_loc7_ % 3 == 0)
               {
                  _loc3_ = "," + _loc3_;
               }
               _loc3_ = _loc5_[0].charAt(_loc6_ - 1 - _loc7_) + _loc3_;
               _loc7_++;
            }
            _loc5_[0] = _loc3_;
         }
         return _loc4_ + _loc5_[0] + (_loc5_.length > 1 && param2 > 0 ? "." + _loc5_[1].substring(0,Math.min(_loc5_[1].length,param2)) : "");
      }
      
      public static function getTotalTroopCount(param1:TroopBean) : Number
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return 0;
         }
         var _loc2_:Number = 0;
         for each(_loc3_ in troopTypes)
         {
            _loc2_ += param1[troopIntNames[_loc3_]];
         }
         return Math.floor(_loc2_);
      }
      
      public static function format1(param1:int) : String
      {
         return (param1 < 10 ? "00" : (param1 < 100 ? "0" : "")) + param1;
      }
      
      public static function format2(param1:int) : String
      {
         return (param1 < 10 ? "0" : "") + param1;
      }
      
      public static function getUnappliedLevels(param1:HeroBean) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(param1.experience >= param1.upgradeExp)
         {
            _loc2_ = param1.level + param1.remainPoint;
            _loc3_ = 1 * (_loc2_ - 1) * _loc2_ * (2 * _loc2_ - 1) / 6 + param1.experience / HEROEXPFACTOR;
            _loc4_ = Math.ceil(Math.pow(_loc3_ * 3,1 / 3) - 0.5);
            if(_loc3_ >= 1 * (_loc4_ + 1) * _loc4_ * (2 * _loc4_ + 1) / 6)
            {
               _loc4_++;
            }
            return _loc4_ - _loc2_;
         }
         return 0;
      }
      
      public static function roundToHundredths(param1:Number) : Number
      {
         return Math.round(param1 * 100) / 100;
      }
      
      public static function isHeroRoyal(param1:HeroBean) : Boolean
      {
         return param1.ability == 0 && (param1.isHero == 1 || param1.isHero == 2);
      }
      
      public static function rand(param1:int, param2:int = 0) : int
      {
         return param1 + Math.random() * (param2 - param1);
      }
      
      public static function randOrder(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = new Array(param1);
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_[_loc3_] = _loc3_;
            _loc3_++;
         }
         _loc3_--;
         while(_loc3_ >= 1)
         {
            _loc4_ = Math.floor(Math.random() * _loc3_);
            _loc5_ = int(_loc2_[_loc4_]);
            _loc2_[_loc4_] = _loc2_[_loc3_];
            _loc2_[_loc3_] = _loc5_;
            _loc3_--;
         }
         return _loc2_;
      }
      
      public static function getTroopBeanFromTroopStrBean(param1:TroopStrBean) : TroopBean
      {
         var _loc5_:int = 0;
         var _loc2_:Object = param1.toObject();
         var _loc3_:TroopBean = new TroopBean();
         var _loc4_:String = null;
         for each(_loc5_ in troopTypes)
         {
            _loc4_ = troopIntNames[_loc5_];
            if(!hasValue(_loc2_[_loc4_]))
            {
               if(uncertainValues[_loc2_[_loc4_]] == undefined)
               {
                  return null;
               }
               _loc3_[_loc4_] = uncertainValues[_loc2_[_loc4_]];
            }
            else
            {
               _loc3_[_loc4_] = int(_loc2_[_loc4_]);
            }
         }
         return _loc3_;
      }
      
      private static function getLocServTime(param1:String) : Number
      {
         var _loc2_:Array = param1.split(" ");
         var _loc3_:Array = _loc2_[0].split(".");
         var _loc4_:Array = _loc2_[1].split(".");
         return new Date(_loc3_[0],_loc3_[1] - 1,_loc3_[2],_loc4_[0],_loc4_[1],_loc4_[2]).getTime();
      }
      
      public static function armyToString(param1:ArmyBean) : String
      {
         var _loc2_:* = "";
         if(param1.missionType == ObjConstants.ARMY_MISSION_OCCUPY)
         {
            _loc2_ += "attack";
         }
         else if(param1.missionType == ObjConstants.ARMY_MISSION_SCOUT)
         {
            _loc2_ += "scout";
         }
         else if(param1.missionType == ObjConstants.ARMY_MISSION_SEND)
         {
            _loc2_ += "reinforce";
         }
         else if(param1.missionType == ObjConstants.ARMY_MISSION_TRANS)
         {
            _loc2_ += "transport";
         }
         else if(param1.missionType == ObjConstants.ARMY_MISSION_CONSTRUCT)
         {
            _loc2_ += "buildcity";
         }
         else if(param1.missionType == ObjConstants.ARMY_MISSION_COLONIZE)
         {
            _loc2_ += "colonize";
         }
         else if(param1.missionType == ObjConstants.ARMY_MISSION_SUPPRESS)
         {
            _loc2_ += "suppress";
         }
         else
         {
            _loc2_ += "unknown...armyToString";
         }
         var _loc3_:String = "";
         if(param1.direction != ArmyConstants.ARMY_FORWARD)
         {
            if(param1.direction != ArmyConstants.ARMY_BACKWARD)
            {
               _loc2_ += " at";
            }
            else
            {
               _loc2_ += " return";
               _loc3_ = " " + formatEndTime(param1.reachTime);
            }
         }
         else
         {
            _loc2_ += " to";
            _loc3_ = " " + formatEndTime(param1.reachTime) + "\nReturn in " + formatEndTime(param1.reachTime + (param1.reachTime - param1.startTime));
         }
         return _loc2_ + (" " + param1.targetPosName + " " + Map.getLevel(param1.targetFieldId) + "(" + Map.getX(param1.targetFieldId) + "," + Map.getY(param1.targetFieldId) + ")" + _loc3_);
      }
      
      public static function trim(param1:String) : String
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length && param1.charCodeAt(_loc2_) < 33)
         {
            _loc2_++;
         }
         var _loc3_:int = param1.length - 1;
         while(_loc3_ >= _loc2_ && param1.charCodeAt(_loc3_) < 33)
         {
            _loc3_--;
         }
         return param1.substring(_loc2_,_loc3_ + 1);
      }
      
      public static function isBadWord(param1:String) : Boolean
      {
         if(badWords.indexOf(param1) > -1)
         {
            return true;
         }
         return false;
      }
      
      public static function troopBeanToMsgString(param1:TroopBean, param2:Boolean = true) : String
      {
         var _loc5_:String = null;
         if(param1 == null)
         {
            return "none";
         }
         var _loc3_:String = "";
         var _loc4_:Object = param1.toObject();
         for(_loc5_ in _loc4_)
         {
            if(_loc4_[_loc5_] > 0 && troopIntNames.indexOf(_loc5_) != -1)
            {
               _loc3_ += (_loc3_.length > 0 ? "," : "") + troopAbrNames[troopIntNames.indexOf(_loc5_)] + ":" + Math.floor(_loc4_[_loc5_]);
            }
         }
         return _loc3_.length > 0 ? _loc3_ : (param2 ? "wo:0" : "none");
      }
      
      public static function getLogTimeStr(param1:Number, param2:Boolean = false) : String
      {
         var _loc3_:Date = new Date(param1);
         if(param2)
         {
            return ["Sun","Mon","Tues","Wed","Thur","Fri","Sat"][_loc3_.day] + ", " + (_loc3_.month + 1) + "/" + _loc3_.date + "/" + _loc3_.fullYear + " " + format2(_loc3_.hours) + ":" + format2(_loc3_.minutes) + ":" + format2(_loc3_.seconds);
         }
         return format2(_loc3_.hours) + ":" + format2(_loc3_.minutes) + ":" + format2(_loc3_.seconds);
      }
      
      public static function getTotalResources(param1:ResourceBean) : Number
      {
         return param1.gold + param1.food + param1.wood + param1.stone + param1.iron;
      }
      
      public static function isWorstHeroByType(param1:String, param2:HeroBean, param3:HeroBean) : Boolean
      {
         var _loc4_:int = _ba40(param2.level,param2[param1] + param2.remainPoint);
         var _loc5_:int = _ba40(param3.level,param3[param1] + param3.remainPoint);
         if(_loc4_ < _loc5_)
         {
            return true;
         }
         if(_loc4_ > _loc5_)
         {
            return false;
         }
         if(param2.level < param3.level)
         {
            return true;
         }
         if(param2.level > param3.level)
         {
            return false;
         }
         return param2.id < param3.id;
      }
      
      public static function myHeroCompare(param1:HeroBean, param2:HeroBean, param3:Array = null) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1.status == HeroConstants.HERO_SEIZED_STATU)
         {
            return 1;
         }
         if(param2.status == HeroConstants.HERO_SEIZED_STATU)
         {
            return -1;
         }
         if(param1.isHero == 2)
         {
            return -1;
         }
         if(param2.isHero == 2)
         {
            return 1;
         }
         if(param1.isHero == 1 || param2.isHero == 1)
         {
            if(param1.isHero == 1 && param2.isHero == 0)
            {
               return -1;
            }
            if(param2.isHero == 1 && param1.isHero == 0)
            {
               return 1;
            }
            if(param1.isHero == 1 && param2.isHero == 1)
            {
               if(param1.level == param2.level)
               {
                  if(param1.name.toLowerCase() <= param2.name.toLowerCase())
                  {
                     return -1;
                  }
                  return 1;
               }
               if(param1.level >= param2.level)
               {
                  return -1;
               }
               return 1;
            }
         }
         if(param1.level == param2.level)
         {
            if(heroTypeCache[param1.id] == undefined)
            {
               if(param1.power > param1.stratagem && param1.power > param1.management)
               {
                  heroTypeCache[param1.id] = 2;
               }
               else if(param1.stratagem > param1.power && param1.stratagem > param1.management)
               {
                  heroTypeCache[param1.id] = 3;
               }
               else if(param1.management > param1.power && param1.management > param1.stratagem)
               {
                  heroTypeCache[param1.id] = 1;
               }
            }
            _loc4_ = int(heroTypeCache[param1.id]);
            if(heroTypeCache[param2.id] == undefined)
            {
               if(param2.power > param2.stratagem && param2.power > param2.management)
               {
                  heroTypeCache[param2.id] = 2;
               }
               else if(param2.stratagem > param2.power && param2.stratagem > param2.management)
               {
                  heroTypeCache[param2.id] = 3;
               }
               else if(param2.management > param2.power && param2.management > param2.stratagem)
               {
                  heroTypeCache[param2.id] = 1;
               }
            }
            _loc5_ = int(heroTypeCache[param2.id]);
            if(_loc4_ == _loc5_)
            {
               if(_loc4_ == 1 && param1.management >= param2.management)
               {
                  return -1;
               }
               if(_loc4_ == 1 && param1.management < param2.management)
               {
                  return 1;
               }
               if(_loc4_ == 2 && param1.power >= param2.power)
               {
                  return -1;
               }
               if(_loc4_ == 2 && param1.power < param2.power)
               {
                  return 1;
               }
               if(_loc4_ == 2 && param1.stratagem >= param2.stratagem)
               {
                  return -1;
               }
               if(_loc4_ == 2 && param1.stratagem < param2.stratagem)
               {
                  return 1;
               }
            }
            if(_loc4_ == 1)
            {
               return -1;
            }
            if(_loc4_ == 3)
            {
               return -1;
            }
            if(_loc5_ == 1)
            {
               return 1;
            }
            if(_loc5_ == 3)
            {
               return -1;
            }
         }
         if(param1.level > param2.level)
         {
            return -1;
         }
         return 1;
      }
      
      public static function setEstimatedServerTime(param1:Number) : void
      {
         var _loc2_:Number = Number(new Date().getTime());
         if(_loc2_ < disablingExpiredTime)
         {
            return;
         }
         var _loc3_:Number = param1 - _loc2_;
         var _loc4_:Number = _loc3_ - lastDesiredServerTimeAdjust;
         lastDesiredServerTimeAdjust = _loc3_;
         if(Math.abs(_loc4_) >= 1000 + 0.3 * Math.abs(serverTimeAdjust - lastDesiredServerTimeAdjust))
         {
            return;
         }
         var _loc5_:Number = lastDesiredServerTimeAdjust - serverTimeAdjust;
         serverTimeLag = Math.abs(_loc5_);
         if(_loc5_ > 5000)
         {
            _loc5_ = 5000;
         }
         if(_loc5_ < -5000)
         {
            _loc5_ = -5000;
         }
         serverTimeAdjust = Math.round(serverTimeAdjust + 0.4 * _loc5_);
         disablingExpiredTime = _loc2_ + Math.abs(_loc5_);
      }
      
      public static function isFlashDebugPlayer() : Boolean
      {
         return Capabilities.isDebugger;
      }
      
      public static function formatEndTime(param1:Number) : String
      {
         var _loc2_:Number = getServerTime();
         if(param1 < _loc2_)
         {
            return "0m:00";
         }
         return formatTime((param1 - _loc2_) / 1000);
      }
      
      public static function getTroops(param1:String) : TroopBean
      {
         var troopObj:TroopBean = null;
         var troopArray:Array = null;
         var troopItem:String = null;
         var t:Array = null;
         var troops:String = param1;
         try
         {
            if((troops = troops.toLowerCase()) == "none")
            {
               return null;
            }
            troopObj = new TroopBean();
            troopArray = troops.split(",");
            if(troopArray.length < 1)
            {
               return null;
            }
            for each(troopItem in troopArray)
            {
               t = troopItem.split(":");
               if(t.length < 2)
               {
                  return null;
               }
               t[1] = parseFloat(String(t[1]).replace(/k/gi,"E3").replace(/m/gi,"E6"));
               switch(t[0].toString())
               {
                  case "wo":
                  case "worker":
                  case "workers":
                     troopObj.peasants = int(t[1]);
                     break;
                  case "w":
                  case "warr":
                  case "warrior":
                  case "warriors":
                     troopObj.militia = int(t[1]);
                     break;
                  case "s":
                  case "scout":
                  case "scouts":
                     troopObj.scouter = int(t[1]);
                     break;
                  case "p":
                  case "pike":
                  case "pikes":
                  case "pikemen":
                     troopObj.pikemen = int(t[1]);
                     break;
                  case "sw":
                  case "sword":
                  case "swords":
                  case "swordsmen":
                     troopObj.swordsmen = int(t[1]);
                     break;
                  case "a":
                  case "arch":
                  case "archer":
                  case "archers":
                     troopObj.archer = int(t[1]);
                     break;
                  case "c":
                  case "cav":
                  case "cavalry":
                     troopObj.lightCavalry = int(t[1]);
                     break;
                  case "cata":
                  case "cataphract":
                  case "phract":
                  case "phracts":
                     troopObj.heavyCavalry = int(t[1]);
                     break;
                  case "t":
                  case "tran":
                  case "trans":
                  case "transport":
                  case "transporter":
                  case "transporters":
                     troopObj.carriage = int(t[1]);
                     break;
                  case "b":
                  case "ball":
                  case "balli":
                  case "balls":
                  case "ballista":
                     troopObj.ballista = int(t[1]);
                     break;
                  case "r":
                  case "br":
                  case "ram":
                  case "rams":
                  case "batteringrams":
                     troopObj.batteringRam = int(t[1]);
                     break;
                  case "cp":
                  case "pult":
                  case "pults":
                  case "catapult":
                  case "catapults":
                     troopObj.catapult = int(t[1]);
                     break;
                  default:
                     return null;
               }
            }
         }
         catch(e:Error)
         {
            troopObj = new TroopBean();
         }
         return troopObj;
      }
      
      public static function _fa102(param1:int) : void
      {
         disablingExpiredTime = new Date().getTime() + param1 * 1000;
      }
      
      public static function isNameKingOrQueen(param1:String) : Boolean
      {
         return param1.toLowerCase() == "queen" || param1.toLowerCase() == "king";
      }
      
      public static function heroBeanToString(param1:HeroBean) : String
      {
         if(param1 == null)
         {
            return "no hero";
         }
         return param1.name + " " + param1.management + "/" + param1.power + "/" + param1.stratagem + " " + param1.level + (param1.remainPoint > 0 ? "-" + param1.remainPoint : "") + ":" + param1.experience;
      }
      
      public static function formatTime(param1:Number) : String
      {
         var _loc2_:int = int(param1 / 3600 / 24);
         var _loc3_:int = int(param1 / 3600) % 24;
         var _loc4_:int = int(param1 / 60) % 60;
         var _loc5_:int = param1 % 60;
         if(_loc2_ > 0)
         {
            return _loc2_ + "d:" + _loc3_ + "h:" + format2(_loc4_) + "m:" + format2(_loc5_);
         }
         if(_loc3_ > 0)
         {
            return _loc3_ + "h:" + format2(_loc4_) + "m:" + format2(_loc5_);
         }
         return format2(_loc4_) + "m:" + format2(_loc5_);
      }
      
      public static function troopStrBeanToMsgString(param1:TroopStrBean, param2:Boolean = false) : String
      {
         var _loc6_:int = 0;
         var _loc3_:Object = param1.toObject();
         var _loc4_:String = "";
         var _loc5_:Array = new Array(TFConstants.T_ARCHER,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CATAPULT,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS);
         for each(_loc6_ in _loc5_)
         {
            if(_loc3_[troopIntNames[_loc6_]] != null && _loc3_[troopIntNames[_loc6_]] != "" && _loc3_[troopIntNames[_loc6_]] != "0")
            {
               _loc4_ += (_loc4_ != "" ? "," : "") + (param2 ? "<b>" : "") + (troopAbrNames[_loc6_] + (param2 ? "</b>:" : ":") + _loc3_[troopIntNames[_loc6_]]);
            }
         }
         return _loc4_;
      }
      
      public static function resourceBeanToString(param1:ResourceBean) : String
      {
         var _loc5_:String = null;
         if(param1 == null)
         {
            return "none";
         }
         var _loc2_:int = 0;
         var _loc3_:* = "";
         var _loc4_:Object = param1.toObject();
         for(_loc5_ in _loc4_)
         {
            if(_loc4_[_loc5_] > 0)
            {
               _loc2_ = int(resourceIntNames.indexOf(_loc5_));
               if(_loc2_ != -1)
               {
                  if(_loc3_.length > 0)
                  {
                     _loc3_ += ",";
                  }
                  _loc3_ = _loc3_ + resourceAbrNames[_loc2_] + ":" + Math.floor(_loc4_[_loc5_]);
               }
            }
         }
         if(_loc3_.length == 0)
         {
            return "g:0";
         }
         return _loc3_;
      }
      
      public static function combineResource(param1:ResourceBean, param2:ResourceBean) : ResourceBean
      {
         param1.food += param2.food;
         param1.gold += param2.gold;
         param1.stone += param2.stone;
         param1.iron += param2.iron;
         param1.wood += param2.wood;
         return param1;
      }
      
      private static function experience(param1:int) : int
      {
         return param1 * (param1 + 1) * (2 * param1 + 1) / 6;
      }
      
      public static function trimDecimalFromResoAmounts(param1:ResourceBean) : void
      {
         param1.gold = Math.floor(param1.gold);
         param1.food = Math.floor(param1.food);
         param1.wood = Math.floor(param1.wood);
         param1.stone = Math.floor(param1.stone);
         param1.iron = Math.floor(param1.iron);
      }
      
      public static function getRandomInt(param1:int, param2:int) : int
      {
         return param1 + Math.floor(Math.random() * (param2 - param1 + 1));
      }
      
      public static function formatInt(param1:int) : String
      {
         if(param1 > -1000 && param1 < 1000)
         {
            return param1 + "";
         }
         var _loc2_:* = param1 + "";
         var _loc3_:String = "";
         if(param1 < 0)
         {
            _loc3_ = "-";
            _loc2_ = _loc2_.substring(1);
         }
         var _loc4_:String = _loc2_;
         var _loc5_:int = _loc4_.length;
         _loc2_ = _loc4_.substring(_loc5_ - 3,_loc5_);
         var _loc6_:int = 3;
         while(_loc6_ < _loc5_)
         {
            if(_loc6_ % 3 == 0)
            {
               _loc2_ = "," + _loc2_;
            }
            _loc2_ = _loc4_.charAt(_loc5_ - 1 - _loc6_) + _loc2_;
            _loc6_++;
         }
         return _loc3_ + _loc2_;
      }
      
      public static function getChatTimeStr(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         return format2(_loc2_.hours) + ":" + format2(_loc2_.minutes);
      }
      
      public static function convertSpecCharToNumCodes(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : String
      {
         var _loc11_:int = 0;
         var _loc9_:String = "";
         var _loc10_:String = "";
         var _loc12_:Array = ["&","#",";","<",">","\'","\"","=","/","\\","|",",",".",":","?","!","@","$","%","^","*","(",")","[","]","{","}","_","-","+"];
         var _loc13_:Array = ["&#38;","&#35;","&#59;","&#60;","&#62;","&#39;","&#34;","&#61;","&#47;","&#92;","&#124;","&#44;","&#46;","&#58;","&#63;","&#33;","&#64;","&#36;","&#37;","&#94;","&#42;","&#40;","&#41;","&#91;","&#93;","&#123;","&#125;","&#95;","&#45;","&#43;"];
         if(!param2)
         {
            _loc12_[0] = "";
         }
         if(!param3)
         {
            _loc12_[1] = "";
         }
         if(!param4)
         {
            _loc12_[2] = "";
         }
         if(!param5)
         {
            _loc12_[3] = "";
         }
         if(!param6)
         {
            _loc12_[4] = "";
         }
         if(!param7)
         {
            _loc12_[5] = "";
         }
         if(!param8)
         {
            _loc12_[6] = "";
         }
         var _loc14_:int = 0;
         while(_loc14_ < param1.length)
         {
            _loc10_ = param1.charAt(_loc14_);
            _loc11_ = int(_loc12_.indexOf(_loc10_));
            _loc9_ += _loc11_ == -1 ? _loc10_ : _loc13_[_loc11_];
            _loc14_++;
         }
         return _loc9_;
      }
      
      public static function isHeroMaxLvl(param1:HeroBean) : Boolean
      {
         return param1.level >= (param1.ability > 0 ? 150 : (param1.isHero == 4 ? 120 : 100));
      }
      
      public static function isNumeric(param1:String) : Boolean
      {
         return !isNaN(removeAbbr(param1));
      }
      
      public static function roundAmount(param1:Number, param2:int = 1) : Number
      {
         var _loc3_:Number = 1e-8;
         if(param1 <= 0)
         {
            return 0;
         }
         var _loc4_:Number = Math.log(param1) / Math.LN10 + _loc3_;
         var _loc5_:Number = Math.floor(_loc4_);
         return Math.floor(Math.pow(10,_loc4_ - _loc5_ + param2 - 1)) * Math.pow(10,_loc5_ - param2 + 1);
      }
      
      public static function isRoyalFound(param1:ArrayCollection) : Boolean
      {
         var _loc2_:HeroBean = null;
         for each(_loc2_ in param1)
         {
            if(isHeroRoyal(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function convertHtmlCharCodesToNumCodes(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:Array = param1.match(/&\w*;/g);
         var _loc3_:Object = new Object();
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc6_];
            _loc5_ = htmlCharMap[_loc4_];
            if((Boolean(_loc5_)) && !_loc3_[_loc4_])
            {
               param1 = param1.split(_loc4_).join(_loc5_);
               _loc3_[_loc4_] = true;
            }
            _loc6_++;
         }
         return param1;
      }
      
      public static function getEstResoBean(param1:String) : ResourceBean
      {
         var _loc6_:String = null;
         param1 = param1.toLowerCase();
         if(param1 == "none")
         {
            return null;
         }
         var _loc2_:ResourceBean = new ResourceBean();
         var _loc3_:Array = param1.split(",");
         if(_loc3_.length < 1 || param1.length == 0)
         {
            return null;
         }
         var _loc4_:String = "";
         var _loc5_:Array = null;
         for each(_loc6_ in _loc3_)
         {
            _loc5_ = _loc6_.split(":");
            if(_loc5_.length < 2 || !isNumeric(_loc5_[1]))
            {
               return null;
            }
            _loc4_ = _loc5_[0].toString().toLocaleLowerCase();
            if(_loc4_.substr(0,1) == "f")
            {
               _loc4_ = "food";
            }
            else if(_loc4_.substr(0,1) == "g")
            {
               _loc4_ = "gold";
            }
            else if(_loc4_.substr(0,1) == "i")
            {
               _loc4_ = "iron";
            }
            else if(_loc4_.substr(0,1) == "s")
            {
               _loc4_ = "stone";
            }
            else
            {
               if(!(_loc4_.substr(0,1) == "w" || _loc4_.substr(0,1) == "l"))
               {
                  return null;
               }
               _loc4_ = "wood";
            }
            _loc2_[_loc4_] = removeAbbr(_loc5_[1]);
         }
         return _loc2_;
      }
      
      public static function isBestHeroByType(param1:String, param2:HeroBean, param3:HeroBean) : Boolean
      {
         var _loc4_:Number = getTotalPointsForHeroAttribute(param2,param1) + param2.remainPoint;
         var _loc5_:Number = getTotalPointsForHeroAttribute(param3,param1) + param3.remainPoint;
         if(_loc4_ > _loc5_)
         {
            return true;
         }
         if(_loc4_ < _loc5_)
         {
            return false;
         }
         if(param2.level < param3.level)
         {
            return true;
         }
         if(param2.level > param3.level)
         {
            return false;
         }
         return param2.id < param3.id;
      }
      
      public static function abbrNum(param1:Number) : String
      {
         var _loc2_:String = "";
         if(param1 < 0)
         {
            _loc2_ = "-";
            param1 = -param1;
         }
         param1 = roundAmount(param1,3);
         if(param1 >= 1000000000000)
         {
            return _loc2_ + param1 / 1000000000000 + "t";
         }
         if(param1 >= 1000000000)
         {
            return _loc2_ + param1 / 1000000000 + "b";
         }
         if(param1 >= 1000000)
         {
            return _loc2_ + param1 / 1000000 + "m";
         }
         if(param1 >= 1000)
         {
            return _loc2_ + param1 / 1000 + "k";
         }
         return _loc2_ + param1 / 1 + "";
      }
      
      public static function searchAndReplace(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:Array = param1.split(param2);
         return _loc4_.join(param3);
      }
      
      public static function getTotalPointsForHeroAttribute(param1:HeroBean, param2:String) : Number
      {
         var _loc3_:String = param2 == "power" ? "attack" : (param2 == "management" ? "politics" : "intelligence");
         return param1[param2] * (100 + param1[param2 + "BuffAdded"]) / 100 + param1[_loc3_];
      }
      
      public static function getServerTimeStr(param1:Boolean = false) : String
      {
         var _loc2_:Date = getCurrentServerTimeRaw();
         return format2(_loc2_.hours) + ":" + format2(_loc2_.minutes) + (param1 ? ":" + format2(_loc2_.seconds) : "");
      }
      
      public static function getTotalQueueEndTime(param1:AllProduceBean) : Number
      {
         var _loc4_:ProduceBean = null;
         var _loc2_:Number = getServerTime();
         var _loc3_:Number = 0;
         for each(_loc4_ in param1.allProduceQueueArray)
         {
            if(_loc3_ == 0)
            {
               _loc3_ = _loc4_.endTime;
            }
            else
            {
               _loc3_ += _loc4_.costTime * 1000;
            }
         }
         return _loc3_;
      }
      
      public static function troopBeanToString(param1:TroopBean) : String
      {
         var _loc5_:int = 0;
         var _loc2_:Array = new Array(TFConstants.T_ARCHER,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_BATTERINGRAM,TFConstants.T_BALLISTA,TFConstants.T_CATAPULT,TFConstants.T_CARRIAGE,TFConstants.T_SWORDSMEN,TFConstants.T_PIKEMAN,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_PEASANTS);
         var _loc3_:Object = param1.toObject();
         var _loc4_:String = "";
         for each(_loc5_ in _loc2_)
         {
            if(_loc3_[troopIntNames[_loc5_]] > 0)
            {
               _loc4_ += (_loc4_.length > 0 ? "," : "") + troopAbrNames[_loc5_] + ":" + _loc3_[troopIntNames[_loc5_]];
            }
         }
         return _loc4_;
      }
      
      public static function setServerTime(param1:Number) : void
      {
         serverTimeAdjust = param1 - new Date().getTime();
      }
      
      public static function isBestHeroByTypeIncGear(param1:String, param2:HeroBean, param3:HeroBean) : Boolean
      {
         var _loc4_:Number = getTotalPointsForHeroAttribute(param2,param1) + param2.remainPoint + param2.politics + param2.attack + param2.intelligence;
         var _loc5_:Number = getTotalPointsForHeroAttribute(param3,param1) + param3.remainPoint + param3.politics + param3.attack + param3.intelligence;
         if(_loc4_ > _loc5_)
         {
            return true;
         }
         if(_loc4_ < _loc5_)
         {
            return false;
         }
         if(param2.level < param3.level)
         {
            return true;
         }
         if(param2.level > param3.level)
         {
            return false;
         }
         return param2.id < param3.id;
      }
      
      public static function getServerTime() : Number
      {
         return new Date().getTime() + serverTimeAdjust;
      }
      
      public static function getFlashPlayerType() : String
      {
         return Capabilities.playerType + " (" + Capabilities.version + ")";
      }
      
      public static function setServerTimeZoneAdjust(param1:Number, param2:String) : void
      {
         var localServerTime:Number = NaN;
         var serverTime:Number = param1;
         var serverTimeStr:String = param2;
         try
         {
            localServerTime = getLocServTime(serverTimeStr);
            serverTimeZoneAdjust = localServerTime - serverTime;
            serverTimeZoneAdjust = Math.round(serverTimeZoneAdjust / 60000) * 60000;
         }
         catch(error:Error)
         {
            serverTimeZoneAdjust = 0;
         }
      }
      
      public static function armyReportToString(param1:XMLList, param2:Boolean = false) : String
      {
         if(param1.troopMovement != undefined)
         {
            if(param1.troopMovement.@isBack == true || param1.troopMovement.@problem == undefined)
            {
               return "Colonize wave returned ";
            }
            return "Colonize wave returned " + param1.troopMovement.@problem;
         }
         var _loc3_:* = param1.@isAttack == "true";
         var _loc4_:* = param1.@isAttackSuccess == "true";
         var _loc5_:* = param1.@isSuppress == "true";
         var _loc6_:Boolean = Boolean(param1.hasOwnProperty("@isSuppress"));
         var _loc7_:* = param1.@isColonial == "true";
         var _loc8_:Boolean = Boolean(param1.hasOwnProperty("@isColonial"));
         var _loc9_:* = param1.@isSuzerain == "true";
         var _loc10_:Boolean = Boolean(param1.hasOwnProperty("@isSuzerain"));
         var _loc11_:String = (param1.attackTroop.@heroName.toString() != "" ? param1.attackTroop.@heroName + "(" + param1.attackTroop.@heroLevel + ") " : "") + (_loc3_ ? "" : " (" + param1.attackTroop.@king[0] + ")") + (param1.backTroop.troops.@isHeroBeSeized != "true" ? "" : " (Captured)");
         var _loc12_:String = param1.defendTroop.@heroName.toString() != "" ? param1.defendTroop.@heroName + "(" + param1.defendTroop.@heroLevel + ") " : "";
         var _loc13_:String = param1.@seizeProblem[0] != undefined ? "f:" + param1.lootResource.food + " g:" + param1.lootResource.gold + " w:" + param1.lootResource.wood + " s:" + param1.lootResource.stone + " i:" + param1.lootResource.iron : "";
         var _loc14_:String = param1.@round != undefined ? " Rnd: " + param1.@round[0] : "";
         var _loc15_:String = param1.@heroExp != undefined ? " Exp: " + param1.@heroExp[0] : "";
         var _loc16_:String = param1.@honor != undefined ? " Honor: " + param1.@honor[0] : "";
         var _loc17_:String = param1.@injuredPer != undefined ? " Heal: " + int(param1.@injuredPer) + "%" : "";
         var _loc18_:String = param1.@seizeProblem != undefined ? " Loy: " + param1.@seizeProblem[0].toString().substr(28,2) : "";
         var _loc19_:* = "";
         var _loc20_:String = "";
         if(_loc3_ && _loc8_ && _loc7_)
         {
            _loc20_ = "You Colonized";
         }
         else if(_loc3_ && _loc6_ && _loc5_)
         {
            _loc20_ = "You Suppressed";
         }
         else if(!_loc3_ && _loc10_ && _loc9_)
         {
            _loc20_ = "Your Colony Was attacked";
         }
         else if(_loc3_)
         {
            _loc20_ = "You Attacked";
         }
         else
         {
            _loc20_ = "You Defended";
         }
         _loc20_ = _loc20_ + " and <b>" + (_loc4_ && _loc3_ && !_loc9_ || !_loc3_ && !_loc4_ || _loc3_ && _loc5_ || !_loc3_ && _loc6_ && !_loc5_ ? "WON :)" : "Lost :(") + "</b>" + _loc14_ + _loc15_ + _loc16_ + _loc18_ + _loc17_;
         var _loc21_:* = "";
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:int = 0;
         for each(_loc22_ in param1.attackTroop.troopUnit)
         {
            _loc24_ = int(_loc22_.@typeId);
            if(!(!hasValue(_loc22_.@count) || !hasValue(_loc22_.@lose)))
            {
               if(int(_loc22_.@count) != 0)
               {
                  if(_loc21_.length != 0)
                  {
                     _loc21_ += ", ";
                  }
                  if(_loc21_.length == 0)
                  {
                     _loc21_ = _loc11_ + " ";
                     while(_loc21_.length < 10)
                     {
                        _loc21_ += " ";
                     }
                  }
                  if(int(_loc22_.@lose) > 0)
                  {
                     _loc21_ += "<b>";
                  }
                  _loc21_ += troopAbrNames[_loc24_] + ":" + int(_loc22_.@count) + "/" + int(_loc22_.@lose);
                  if(_loc3_)
                  {
                     for each(_loc23_ in param1.autoHeal.troopUnit)
                     {
                        if(_loc24_ == int(_loc23_.@typeId))
                        {
                           _loc21_ += "/" + _loc23_.@count;
                           break;
                        }
                     }
                     for each(_loc23_ in param1.backTroop.troops[0])
                     {
                        if(_loc24_ == int(_loc23_.@typeId))
                        {
                           _loc21_ += "/" + _loc23_.@remain;
                           break;
                        }
                     }
                  }
                  if(int(_loc22_.@lose) > 0)
                  {
                     _loc21_ += "</b>";
                  }
               }
            }
         }
         if(_loc21_.length != 0)
         {
            if(_loc3_)
            {
               _loc21_ += _loc17_;
            }
         }
         else
         {
            _loc21_ = "<i>NO TROOP INFO</i>";
         }
         var _loc25_:* = "";
         for each(_loc22_ in param1.defendTroop.troopUnit)
         {
            _loc24_ = int(_loc22_.@typeId);
            if(!(!hasValue(_loc22_.@count) || !hasValue(_loc22_.@lose)))
            {
               if(int(_loc22_.@count) != 0)
               {
                  if(_loc25_.length != 0)
                  {
                     _loc25_ += ", ";
                  }
                  if(_loc25_.length == 0)
                  {
                     _loc25_ = _loc12_ + " ";
                     while(_loc25_.length < 10)
                     {
                        _loc25_ += " ";
                     }
                  }
                  if(int(_loc22_.@lose) > 0)
                  {
                     _loc25_ += "<b>";
                  }
                  _loc25_ += troopAbrNames[_loc24_] + ":" + int(_loc22_.@count) + "/" + int(_loc22_.@lose);
                  if(!_loc3_)
                  {
                     for each(_loc23_ in param1.autoHeal.troopUnit)
                     {
                        if(_loc24_ == int(_loc23_.@typeId))
                        {
                           _loc25_ += "/" + _loc23_.@count;
                           break;
                        }
                     }
                     for each(_loc23_ in param1.backTroop.troops[0])
                     {
                        if(_loc24_ == int(_loc23_.@typeId))
                        {
                           _loc25_ += "/" + _loc23_.@remain;
                           break;
                        }
                     }
                  }
                  if(int(_loc22_.@lose) > 0)
                  {
                     _loc25_ += "</b>";
                  }
               }
            }
         }
         if(_loc25_.length != 0)
         {
            if(!_loc3_)
            {
               _loc25_ += _loc17_;
            }
         }
         else
         {
            _loc25_ = "<i>NO TROOP INFO</i>";
         }
         if(_loc21_ == "<i>NO TROOP INFO</i>" && _loc25_ == "<i>NO TROOP INFO</i>")
         {
            _loc19_ = _loc20_ + " <I>NO REPORT</I>";
         }
         else
         {
            _loc19_ = _loc20_ + "<br>" + (param2 ? "<br>" : "") + "<font color=\"#BB0000\">" + _loc21_ + "</font><br>" + (param2 ? "<br>" : "") + "<font color=\"#007700\">" + _loc25_ + "</font>";
            if(param1.@seizeProblem[0] != undefined)
            {
               _loc19_ += "<br>" + (param2 ? "<br>" : "") + _loc13_;
            }
         }
         return _loc19_;
      }
      
      public static function formatHeroName(param1:HeroBean) : void
      {
         param1.name = param1.name.split(" ").join("").split("-").join("").split(",").join("");
      }
      
      public static function fixNumber(param1:Number) : String
      {
         var _loc2_:String = param1.toFixed(2);
         if(_loc2_.indexOf(".00") != -1)
         {
            return param1.toFixed(0);
         }
         if(_loc2_.lastIndexOf("0") == _loc2_.length - 1)
         {
            return param1.toFixed(1);
         }
         return _loc2_;
      }
      
      public static function sortFieldsByDistance(param1:CastleBean) : void
      {
         var cstleFieldId:int = 0;
         var castle:CastleBean = param1;
         cstleFieldId = castle.fieldId;
         var sortFieldsByDistanceHelper:Function = function(param1:FieldBean, param2:FieldBean):int
         {
            var _loc3_:Number = Map.fieldDistance(param1.id,cstleFieldId);
            var _loc4_:Number = Map.fieldDistance(param2.id,cstleFieldId);
            if(_loc3_ < _loc4_)
            {
               return -1;
            }
            if(_loc3_ > _loc4_)
            {
               return 1;
            }
            return 0;
         };
         castle.fieldsArray.source.sort(sortFieldsByDistanceHelper);
      }
      
      public static function sortByReachTime(param1:ArmyBean, param2:ArmyBean) : int
      {
         if(param1.reachTime < param2.reachTime)
         {
            return -1;
         }
         if(param1.reachTime > param2.reachTime)
         {
            return 1;
         }
         return 0;
      }
      
      public static function callLater(param1:Number, param2:Function, param3:Array = null) : void
      {
         var handler:Function = null;
         var timer:Timer = null;
         var delay:Number = param1;
         var func:Function = param2;
         var args:Array = param3;
         handler = function(param1:TimerEvent):void
         {
            func.apply(null,args);
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER,handler);
         };
         timer = new Timer(delay,1);
         timer.addEventListener(TimerEvent.TIMER,handler);
         timer.start();
      }
      
      public static function getCurrentServerTimeRaw() : Date
      {
         return new Date(getServerTime() + serverTimeZoneAdjust);
      }
      
      private static function _ba40(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param2 < 150)
         {
            _loc3_ = 150 - param2 + param1;
            return experience(_loc3_) - experience(param1);
         }
         return -param2;
      }
      
      public static function removeAbbr(param1:String) : Number
      {
         param1 = param1.toLowerCase();
         var _loc2_:String = param1.charAt(param1.length - 1);
         if(_loc2_ == "k")
         {
            return Number(param1.substring(0,param1.length - 1)) * 1000;
         }
         if(_loc2_ == "m")
         {
            return Number(param1.substring(0,param1.length - 1)) * 1000000;
         }
         if(_loc2_ == "b")
         {
            return Number(param1.substring(0,param1.length - 1)) * 1000000000;
         }
         if(_loc2_ == "t")
         {
            return Number(param1.substring(0,param1.length - 1)) * 1000000000000;
         }
         return Number(param1);
      }
      
      public static function getFortifications(param1:String) : FortificationsBean
      {
         var _loc5_:String = null;
         param1 = param1.toLowerCase();
         if(param1 == "none")
         {
            return null;
         }
         var _loc2_:FortificationsBean = new FortificationsBean();
         var _loc3_:Array = param1.split(",");
         if(_loc3_.length < 1)
         {
            return null;
         }
         var _loc4_:Array = null;
         for each(_loc5_ in _loc3_)
         {
            _loc4_ = _loc5_.split(":");
            if(_loc4_.length < 2)
            {
               return null;
            }
            _loc4_[1] = parseFloat(String(_loc4_[1]).replace(/k/gi,"E3").replace(/m/gi,"E6"));
            switch(_loc4_[0].toString())
            {
               case "tra":
               case "trap":
               case "traps":
                  _loc2_.trap = int(_loc4_[1]);
                  break;
               case "ab":
               case "abs":
               case "abatis":
                  _loc2_.abatis = int(_loc4_[1]);
                  break;
               case "at":
               case "ats":
               case "tower":
               case "towers":
               case "archertower":
               case "archertowers":
                  _loc2_.arrowTower = int(_loc4_[1]);
                  break;
               case "r":
               case "rl":
               case "log":
               case "logs":
               case "rollinglog":
               case "rollinglogs":
                  _loc2_.rollingLogs = int(_loc4_[1]);
                  break;
               case "tre":
               case "treb":
               case "trebs":
               case "trebuchet":
               case "trebuchets":
               case "rf":
               case "rock":
               case "rockfall":
                  _loc2_.rockfall = int(_loc4_[1]);
                  break;
               default:
                  return null;
            }
         }
         return _loc2_;
      }
      
      public static function getServerEndTimeStr(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1 + serverTimeZoneAdjust);
         return format2(_loc2_.hours) + ":" + format2(_loc2_.minutes) + ":" + format2(_loc2_.seconds) + "." + format1(_loc2_.getMilliseconds());
      }
      
      public static function getHeroSpeedFactor(param1:HeroBean) : Number
      {
         if(param1 == null)
         {
            return HEROSPEEDUP[0];
         }
         if(param1.speed < 10)
         {
            return HEROSPEEDUP[0];
         }
         if(param1.speed >= 100)
         {
            return HEROSPEEDUP[10];
         }
         return HEROSPEEDUP[param1.speed / 10];
      }
      
      public static function getTimeStr(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         return format2(_loc2_.hours) + ":" + format2(_loc2_.minutes) + ":" + format2(_loc2_.seconds) + "." + format1(_loc2_.getMilliseconds());
      }
      
      public static function fortBeanToMsgString(param1:FortificationsBean, param2:Boolean = true) : String
      {
         var _loc6_:String = null;
         if(param1 == null)
         {
            return "none";
         }
         var _loc3_:int = 0;
         var _loc4_:String = "";
         var _loc5_:Object = param1.toObject();
         for(_loc6_ in _loc5_)
         {
            if(_loc5_[_loc6_] > 0 && (_loc3_ = int(troopIntNames.indexOf(_loc6_))) != -1)
            {
               _loc4_ += (_loc4_.length > 0 ? "," : "") + troopAbrNames[_loc3_] + ":" + Math.floor(_loc5_[_loc6_]);
            }
         }
         return _loc4_.length > 0 ? _loc4_ : (param2 ? "tra:0" : "none");
      }
      
      public static function hasValue(param1:String) : Boolean
      {
         if(param1 == "")
         {
            return false;
         }
         return !isNaN(Number(param1));
      }
      
      public static function formatUrl(param1:String, param2:String, param3:String = "#4377F9") : String
      {
         return param2 == "" ? param1 : "<u><b><font color=\'" + param3 + "\'><a href=\'event:" + param2 + "\'>" + param1 + "</a></font></b></u>";
      }
   }
}

