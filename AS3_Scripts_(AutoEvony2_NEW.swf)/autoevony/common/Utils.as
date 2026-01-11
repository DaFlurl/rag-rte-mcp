// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.Utils

package autoevony.common
{
    import com.evony.common.constants.TFConstants;
    import com.evony.common.beans.HeroBean;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.beans.TroopStrBean;
    import com.evony.common.constants.ObjConstants;
    import com.evony.common.constants.ArmyConstants;
    import autoevony.player.Map;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.beans.ResourceBean;
    import com.evony.common.constants.HeroConstants;
    import flash.system.Capabilities;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ProduceBean;
    import com.evony.common.beans.AllProduceBean;
    import com.evony.common.beans.FieldBean;
    import com.evony.common.beans.CastleBean;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.evony.common.beans.FortificationsBean;

    public class Utils 
    {

        public static var serverTimeAdjust:Number = 0;
        public static var serverTimeZoneAdjust:Number = 0;
        public static var disablingExpiredTime:Number = 0;
        private static var lastDesiredServerTimeAdjust:Number = 0;
        private static var serverTimeLag:Number = 0;
        public static var badWords:Array = new Array("anus", "arse", "arsehole", "assbag", "assbandit", "assbanger", "assbite", "assclown", "asscock", "asscracker", "asses", "assface", "assfuck", "assfucker", "assgoblin", "asshat", "asshead", "asshole", "asshopper", "assjacker", "asslick", "asslicker", "assmunch", "assmuncher", "asspirate", "assshole", "asswipe", "bampot", "bastard", "beaner", "bitch", "bitches", "bitchass", "bitchtits", "bitchy", "blow job", "blowjob", "boner", "brotherfucker", "bullshit", "bumblefuck", "butt plug", "butt", "buttfucka", "buttfucker", "camel toe", "carpetmuncher", "chinc", "chink", "choad", "chode", "clit", "clitfuck", "cock", "cockbite", "cockface", "cockfucker", "cockknoker", "cockmaster", "cockmongruel", "cockmonkey", "cockmuncher", "cockshit", "cocksmoker", "cocksucker", "coochie", "coochy", "coon", "cooter", "cracker", "cum", "cumbubble", "cumjockey", "cumtart", "cunnilingus", "cunt", "cunthole", "deggo", "dick", "dickbag", "dickbeaters", "dickface", "dickfuck", "dickhead", "dickhole", "dickmonger", "dicks", "dickweed", "dickwod", "dildo", "dipshit", "dookie", "douche", "douche", "douchebag", "douchewaffle", "dumass", "dumb ass", "dumbass", "dumbfuck", "dumbshit", "dumshit", "dyke", "fag", "fagbag", "fagfucker", "faggit", "faggot", "fagtard", "fatass", "fellatio", "feltch", "fuck", "fuckass", "fuckbrain", "fucked", "fucker", "fuckface", "fuckhead", "fuckhole", "fuckin", "fucking", "fucknut", "fucks", "fuckstick", "fucktard", "fuckup", "fuckwad", "fuckwit", "fuckwitt", "fudgepacker", "gay", "gaybob", "gaydo", "gayfuck", "gaytard", "gaywad", "girls", "gooch", "gook", "gringo", "guido", "handjob", "hard on", "heeb", "ho", "homo", "homodumbshit", "honkey", "humping", "jackass", "jap", "jerk off", "jigaboo", "jizz", "jungle bunny", "junglebunny", "kike", "kooch", "kootch", "kyke", "lesbian", "lesbo", "lezzie", "lick", "mcfagget", "mick", "minge", "mothafucka", "motherfucker", "motherfucking", "muff", "muffdiver", "munging", "negro", "nigger", "iglet", "nut sack", "nutsack", "paki", "panooch", "pecker", "peckerhead", "penis", "penisfucker", "piss", "pissed", "pissed off", "pollock", "poon", "poonani", "poonany", "porch monkey", "porchmonkey", "prick", "punta", "pussies", "pussy", "pussylicking", "puto", "queef", "queer", "queerbait", "rape", "renob", "rimjob", "ruski", "sand nigger", "sandnigger", "sex", "schlong", "scrote", "shit", "shitbagger", "shitcunt", "shitdick", "shitface", "shitfaced", "shithead", "shithouse", "shitspitter", "shitstain", "shitter", "shittiest", "shitting", "shitty", "skank", "skeet", "skullfuck", "slut", "sluts", "slutbag", "snatch", "spic", "spick", "splooge", "suck", "tard", "testicle", "thundercunt", "tit", "titfuck", "tits", "tittyfuck", "twat", "twatlips", "twats", "twatwaffle", "vag", "vagina", "vjayjay", "wank", "wetback", "whore", "whorebag", "wop", "shitt", "shittt", "shxt", "pisss", "cunt", "cunts", "fart", "turd");
        public static const MISSION_NAMES:Array = new Array("", "transport", "reinforce", "scout", "buildcity", "attack", "", "colonize", "uprise", "suppress", "anticolonial", "deploytroop");
        public static const TROOP_EXP_VALUES:Array = new Array(0, 0, 225, 305, 695, 900, 1350, 1350, 2975, 2850, 8750, 10000, 13750, 29000);
        public static var troopIntNames:Array = new Array("", "", "peasants", "militia", "scouter", "pikemen", "swordsmen", "archer", "carriage", "lightCavalry", "heavyCavalry", "ballista", "batteringRam", "catapult", "trap", "abatis", "arrowTower", "rollingLogs", "rockfall");
        public static var troopExtNames:Array = new Array("", "", "worker", "warrior", "scout", "pikemen", "swordsmen", "archer", "transport", "cavalry", "cataphract", "ballista", "battering ram", "catapult", "trap", "abatis", "archer tower", "rolling log", "trebuchev");
        public static var troopAbrNames:Array = new Array("", "", "wo", "w", "s", "p", "sw", "a", "t", "c", "cata", "b", "r", "cp", "tra", "ab", "at", "r", "tre");
        private static var troopTypes:Array = new Array(TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN, TFConstants.T_ARCHER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_CARRIAGE, TFConstants.T_BALLISTA, TFConstants.T_BATTERINGRAM, TFConstants.T_CATAPULT);
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
        public static var resourceIntNames:Array = new Array("food", "wood", "stone", "iron", "gold");
        public static var resourceAbrNames:Array = new Array("f", "w", "s", "i", "g");
        public static var HEROSPEEDUP:Array = new Array(1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2);
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
            '"':"&#34;",
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


        public static function getMaxStatValueByType(_arg_1:HeroBean, _arg_2:String):Number
        {
            return (((((_arg_1[_arg_2] * (100 + _arg_1[(_arg_2 + "BuffAdded")])) / 100) + _arg_1.politics) + _arg_1.attack) + _arg_1.intelligence);
        }

        public static function getStringBetween(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            if (_arg_1.indexOf(_arg_2) == -1)
            {
                return (null);
            };
            if (_arg_1.indexOf(_arg_3, (_arg_1.indexOf(_arg_2) + _arg_2.length)) == -1)
            {
                return (null);
            };
            return (_arg_1.substring((_arg_1.indexOf(_arg_2) + _arg_2.length), _arg_1.indexOf(_arg_3, (_arg_1.indexOf(_arg_2) + _arg_2.length))));
        }

        public static function getServerLagTime():Number
        {
            return (serverTimeLag);
        }

        public static function specialCharFilter(_arg_1:String):Boolean
        {
            var _local_2:* = "\"'";
            var _local_3:Array = _arg_1.split("");
            var _local_4:int;
            while (_local_4 < _local_3.length)
            {
                if (_local_2.indexOf(_local_3[_local_4]) > -1)
                {
                    return (true);
                };
                _local_4++;
            };
            return (false);
        }

        public static function formatNum(_arg_1:Number, _arg_2:int=50):String
        {
            var _local_7:int;
            if (isNaN(_arg_1))
            {
                return ("");
            };
            if (_arg_2 < 1)
            {
                _arg_2 = 0;
            };
            var _local_3:* = (_arg_1 + "");
            var _local_4:* = "";
            if (_arg_1 < 0)
            {
                _local_4 = "-";
                _local_3 = _local_3.substring(1);
            };
            var _local_5:Array = _local_3.split(".");
            var _local_6:int = _local_5[0].length;
            if (((_arg_1 <= -1000) || (_arg_1 >= 1000)))
            {
                _local_3 = _local_5[0].substring((_local_6 - 3), _local_6);
                _local_7 = 3;
                while (_local_7 < _local_6)
                {
                    if ((_local_7 % 3) == 0)
                    {
                        _local_3 = ("," + _local_3);
                    };
                    _local_3 = (_local_5[0].charAt(((_local_6 - 1) - _local_7)) + _local_3);
                    _local_7++;
                };
                _local_5[0] = _local_3;
            };
            return ((_local_4 + _local_5[0]) + (((_local_5.length > 1) && (_arg_2 > 0)) ? ("." + _local_5[1].substring(0, Math.min(_local_5[1].length, _arg_2))) : ""));
        }

        public static function getTotalTroopCount(_arg_1:TroopBean):Number
        {
            var _local_3:int;
            if (_arg_1 == null)
            {
                return (0);
            };
            var _local_2:Number = 0;
            for each (_local_3 in troopTypes)
            {
                _local_2 = (_local_2 + _arg_1[troopIntNames[_local_3]]);
            };
            return (Math.floor(_local_2));
        }

        public static function format1(_arg_1:int):String
        {
            return (((_arg_1 < 10) ? "00" : ((_arg_1 < 100) ? "0" : "")) + _arg_1);
        }

        public static function format2(_arg_1:int):String
        {
            return (((_arg_1 < 10) ? "0" : "") + _arg_1);
        }

        public static function getUnappliedLevels(_arg_1:HeroBean):int
        {
            var _local_2:int;
            var _local_3:Number;
            var _local_4:int;
            if (_arg_1.experience >= _arg_1.upgradeExp)
            {
                _local_2 = (_arg_1.level + _arg_1.remainPoint);
                _local_3 = (((((1 * (_local_2 - 1)) * _local_2) * ((2 * _local_2) - 1)) / 6) + (_arg_1.experience / HEROEXPFACTOR));
                _local_4 = int(Math.ceil((Math.pow((_local_3 * 3), (1 / 3)) - 0.5)));
                if (_local_3 >= ((((1 * (_local_4 + 1)) * _local_4) * ((2 * _local_4) + 1)) / 6))
                {
                    _local_4++;
                };
                return (_local_4 - _local_2);
            };
            return (0);
        }

        public static function roundToHundredths(_arg_1:Number):Number
        {
            return (Math.round((_arg_1 * 100)) / 100);
        }

        public static function isHeroRoyal(_arg_1:HeroBean):Boolean
        {
            return ((_arg_1.ability == 0) && ((_arg_1.isHero == 1) || (_arg_1.isHero == 2)));
        }

        public static function rand(_arg_1:int, _arg_2:int=0):int
        {
            return (_arg_1 + (Math.random() * (_arg_2 - _arg_1)));
        }

        public static function randOrder(_arg_1:int):Array
        {
            var _local_3:int;
            var _local_2:Array = new Array(_arg_1);
            var _local_4:int;
            var _local_5:int;
            _local_3 = 0;
            while (_local_3 < _arg_1)
            {
                _local_2[_local_3] = _local_3;
                _local_3++;
            };
            _local_3--;
            while (_local_3 >= 1)
            {
                _local_4 = int(Math.floor((Math.random() * _local_3)));
                _local_5 = _local_2[_local_4];
                _local_2[_local_4] = _local_2[_local_3];
                _local_2[_local_3] = _local_5;
                _local_3--;
            };
            return (_local_2);
        }

        public static function getTroopBeanFromTroopStrBean(_arg_1:TroopStrBean):TroopBean
        {
            var _local_5:int;
            var _local_2:Object = _arg_1.toObject();
            var _local_3:TroopBean = new TroopBean();
            var _local_4:String;
            for each (_local_5 in troopTypes)
            {
                _local_4 = troopIntNames[_local_5];
                if (!hasValue(_local_2[_local_4]))
                {
                    if (uncertainValues[_local_2[_local_4]] == undefined)
                    {
                        return (null);
                    };
                    _local_3[_local_4] = uncertainValues[_local_2[_local_4]];
                }
                else
                {
                    _local_3[_local_4] = int(_local_2[_local_4]);
                };
            };
            return (_local_3);
        }

        private static function getLocServTime(_arg_1:String):Number
        {
            var _local_2:Array = _arg_1.split(" ");
            var _local_3:Array = _local_2[0].split(".");
            var _local_4:Array = _local_2[1].split(".");
            return (new Date(_local_3[0], (_local_3[1] - 1), _local_3[2], _local_4[0], _local_4[1], _local_4[2]).getTime());
        }

        public static function armyToString(_arg_1:ArmyBean):String
        {
            var _local_2:* = "";
            if (_arg_1.missionType == ObjConstants.ARMY_MISSION_OCCUPY)
            {
                _local_2 = (_local_2 + "attack");
            }
            else
            {
                if (_arg_1.missionType == ObjConstants.ARMY_MISSION_SCOUT)
                {
                    _local_2 = (_local_2 + "scout");
                }
                else
                {
                    if (_arg_1.missionType == ObjConstants.ARMY_MISSION_SEND)
                    {
                        _local_2 = (_local_2 + "reinforce");
                    }
                    else
                    {
                        if (_arg_1.missionType == ObjConstants.ARMY_MISSION_TRANS)
                        {
                            _local_2 = (_local_2 + "transport");
                        }
                        else
                        {
                            if (_arg_1.missionType == ObjConstants.ARMY_MISSION_CONSTRUCT)
                            {
                                _local_2 = (_local_2 + "buildcity");
                            }
                            else
                            {
                                if (_arg_1.missionType == ObjConstants.ARMY_MISSION_COLONIZE)
                                {
                                    _local_2 = (_local_2 + "colonize");
                                }
                                else
                                {
                                    if (_arg_1.missionType == ObjConstants.ARMY_MISSION_SUPPRESS)
                                    {
                                        _local_2 = (_local_2 + "suppress");
                                    }
                                    else
                                    {
                                        _local_2 = (_local_2 + "unknown...armyToString");
                                    };
                                };
                            };
                        };
                    };
                };
            };
            var _local_3:* = "";
            if (_arg_1.direction != ArmyConstants.ARMY_FORWARD)
            {
                if (_arg_1.direction != ArmyConstants.ARMY_BACKWARD)
                {
                    _local_2 = (_local_2 + " at");
                }
                else
                {
                    _local_2 = (_local_2 + " return");
                    _local_3 = (" " + formatEndTime(_arg_1.reachTime));
                };
            }
            else
            {
                _local_2 = (_local_2 + " to");
                _local_3 = (((" " + formatEndTime(_arg_1.reachTime)) + "\nReturn in ") + formatEndTime((_arg_1.reachTime + (_arg_1.reachTime - _arg_1.startTime))));
            };
            return (_local_2 + (((((((((" " + _arg_1.targetPosName) + " ") + Map.getLevel(_arg_1.targetFieldId)) + "(") + Map.getX(_arg_1.targetFieldId)) + ",") + Map.getY(_arg_1.targetFieldId)) + ")") + _local_3));
        }

        public static function trim(_arg_1:String):String
        {
            var _local_2:int;
            while (((_local_2 < _arg_1.length) && (_arg_1.charCodeAt(_local_2) < 33)))
            {
                _local_2++;
            };
            var _local_3:int = (_arg_1.length - 1);
            while (((_local_3 >= _local_2) && (_arg_1.charCodeAt(_local_3) < 33)))
            {
                _local_3--;
            };
            return (_arg_1.substring(_local_2, (_local_3 + 1)));
        }

        public static function isBadWord(_arg_1:String):Boolean
        {
            if (badWords.indexOf(_arg_1) > -1)
            {
                return (true);
            };
            return (false);
        }

        public static function troopBeanToMsgString(_arg_1:TroopBean, _arg_2:Boolean=true):String
        {
            var _local_5:String;
            if (_arg_1 == null)
            {
                return ("none");
            };
            var _local_3:* = "";
            var _local_4:Object = _arg_1.toObject();
            for (_local_5 in _local_4)
            {
                if (((_local_4[_local_5] > 0) && (!(troopIntNames.indexOf(_local_5) == -1))))
                {
                    _local_3 = (_local_3 + (((((_local_3.length > 0) ? "," : "") + troopAbrNames[troopIntNames.indexOf(_local_5)]) + ":") + Math.floor(_local_4[_local_5])));
                };
            };
            return ((_local_3.length > 0) ? _local_3 : ((_arg_2) ? "wo:0" : "none"));
        }

        public static function getLogTimeStr(_arg_1:Number, _arg_2:Boolean=false):String
        {
            var _local_3:Date = new Date(_arg_1);
            if (_arg_2)
            {
                return ((((((((((((["Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat"][_local_3.day] + ", ") + (_local_3.month + 1)) + "/") + _local_3.date) + "/") + _local_3.fullYear) + " ") + format2(_local_3.hours)) + ":") + format2(_local_3.minutes)) + ":") + format2(_local_3.seconds));
            };
            return ((((format2(_local_3.hours) + ":") + format2(_local_3.minutes)) + ":") + format2(_local_3.seconds));
        }

        public static function getTotalResources(_arg_1:ResourceBean):Number
        {
            return ((((_arg_1.gold + _arg_1.food) + _arg_1.wood) + _arg_1.stone) + _arg_1.iron);
        }

        public static function isWorstHeroByType(_arg_1:String, _arg_2:HeroBean, _arg_3:HeroBean):Boolean
        {
            var _local_4:int = _ba40(_arg_2.level, (_arg_2[_arg_1] + _arg_2.remainPoint));
            var _local_5:int = _ba40(_arg_3.level, (_arg_3[_arg_1] + _arg_3.remainPoint));
            if (_local_4 < _local_5)
            {
                return (true);
            };
            if (_local_4 > _local_5)
            {
                return (false);
            };
            if (_arg_2.level < _arg_3.level)
            {
                return (true);
            };
            if (_arg_2.level > _arg_3.level)
            {
                return (false);
            };
            return (_arg_2.id < _arg_3.id);
        }

        public static function myHeroCompare(_arg_1:HeroBean, _arg_2:HeroBean, _arg_3:Array=null):int
        {
            var _local_4:int;
            var _local_5:int;
            if (_arg_1.status == HeroConstants.HERO_SEIZED_STATU)
            {
                return (1);
            };
            if (_arg_2.status == HeroConstants.HERO_SEIZED_STATU)
            {
                return (-1);
            };
            if (_arg_1.isHero == 2)
            {
                return (-1);
            };
            if (_arg_2.isHero == 2)
            {
                return (1);
            };
            if (((_arg_1.isHero == 1) || (_arg_2.isHero == 1)))
            {
                if (((_arg_1.isHero == 1) && (_arg_2.isHero == 0)))
                {
                    return (-1);
                };
                if (((_arg_2.isHero == 1) && (_arg_1.isHero == 0)))
                {
                    return (1);
                };
                if (((_arg_1.isHero == 1) && (_arg_2.isHero == 1)))
                {
                    if (_arg_1.level == _arg_2.level)
                    {
                        if (_arg_1.name.toLowerCase() <= _arg_2.name.toLowerCase())
                        {
                            return (-1);
                        };
                        return (1);
                    };
                    if (_arg_1.level >= _arg_2.level)
                    {
                        return (-1);
                    };
                    return (1);
                };
            };
            if (_arg_1.level == _arg_2.level)
            {
                if (heroTypeCache[_arg_1.id] == undefined)
                {
                    if (((_arg_1.power > _arg_1.stratagem) && (_arg_1.power > _arg_1.management)))
                    {
                        heroTypeCache[_arg_1.id] = 2;
                    }
                    else
                    {
                        if (((_arg_1.stratagem > _arg_1.power) && (_arg_1.stratagem > _arg_1.management)))
                        {
                            heroTypeCache[_arg_1.id] = 3;
                        }
                        else
                        {
                            if (((_arg_1.management > _arg_1.power) && (_arg_1.management > _arg_1.stratagem)))
                            {
                                heroTypeCache[_arg_1.id] = 1;
                            };
                        };
                    };
                };
                _local_4 = heroTypeCache[_arg_1.id];
                if (heroTypeCache[_arg_2.id] == undefined)
                {
                    if (((_arg_2.power > _arg_2.stratagem) && (_arg_2.power > _arg_2.management)))
                    {
                        heroTypeCache[_arg_2.id] = 2;
                    }
                    else
                    {
                        if (((_arg_2.stratagem > _arg_2.power) && (_arg_2.stratagem > _arg_2.management)))
                        {
                            heroTypeCache[_arg_2.id] = 3;
                        }
                        else
                        {
                            if (((_arg_2.management > _arg_2.power) && (_arg_2.management > _arg_2.stratagem)))
                            {
                                heroTypeCache[_arg_2.id] = 1;
                            };
                        };
                    };
                };
                _local_5 = heroTypeCache[_arg_2.id];
                if (_local_4 == _local_5)
                {
                    if (((_local_4 == 1) && (_arg_1.management >= _arg_2.management)))
                    {
                        return (-1);
                    };
                    if (((_local_4 == 1) && (_arg_1.management < _arg_2.management)))
                    {
                        return (1);
                    };
                    if (((_local_4 == 2) && (_arg_1.power >= _arg_2.power)))
                    {
                        return (-1);
                    };
                    if (((_local_4 == 2) && (_arg_1.power < _arg_2.power)))
                    {
                        return (1);
                    };
                    if (((_local_4 == 2) && (_arg_1.stratagem >= _arg_2.stratagem)))
                    {
                        return (-1);
                    };
                    if (((_local_4 == 2) && (_arg_1.stratagem < _arg_2.stratagem)))
                    {
                        return (1);
                    };
                };
                if (_local_4 == 1)
                {
                    return (-1);
                };
                if (_local_4 == 3)
                {
                    return (-1);
                };
                if (_local_5 == 1)
                {
                    return (1);
                };
                if (_local_5 == 3)
                {
                    return (-1);
                };
            };
            if (_arg_1.level > _arg_2.level)
            {
                return (-1);
            };
            return (1);
        }

        public static function setEstimatedServerTime(_arg_1:Number):void
        {
            var _local_2:Number = new Date().getTime();
            if (_local_2 < disablingExpiredTime)
            {
                return;
            };
            var _local_3:Number = (_arg_1 - _local_2);
            var _local_4:Number = (_local_3 - lastDesiredServerTimeAdjust);
            lastDesiredServerTimeAdjust = _local_3;
            if (Math.abs(_local_4) >= (1000 + (0.3 * Math.abs((serverTimeAdjust - lastDesiredServerTimeAdjust)))))
            {
                return;
            };
            var _local_5:Number = (lastDesiredServerTimeAdjust - serverTimeAdjust);
            serverTimeLag = Math.abs(_local_5);
            if (_local_5 > 5000)
            {
                _local_5 = 5000;
            };
            if (_local_5 < -5000)
            {
                _local_5 = -5000;
            };
            serverTimeAdjust = Math.round((serverTimeAdjust + (0.4 * _local_5)));
            disablingExpiredTime = (_local_2 + Math.abs(_local_5));
        }

        public static function isFlashDebugPlayer():Boolean
        {
            return (Capabilities.isDebugger);
        }

        public static function formatEndTime(_arg_1:Number):String
        {
            var _local_2:Number = getServerTime();
            if (_arg_1 < _local_2)
            {
                return ("0m:00");
            };
            return (formatTime(((_arg_1 - _local_2) / 1000)));
        }

        public static function getTroops(troops:String):TroopBean
        {
            var troopObj:TroopBean;
            var troopArray:Array;
            var troopItem:String;
            var t:Array;
            try
            {
                if ((troops = troops.toLowerCase()) == "none")
                {
                    return (null);
                };
                troopObj = new TroopBean();
                troopArray = troops.split(",");
                if (troopArray.length < 1)
                {
                    return (null);
                };
                for each (troopItem in troopArray)
                {
                    t = troopItem.split(":");
                    if (t.length < 2)
                    {
                        return (null);
                    };
                    t[1] = parseFloat(String(t[1]).replace(new RegExp("k", "gi"), "E3").replace(new RegExp("m", "gi"), "E6"));
                    switch (t[0].toString())
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
                            return (null);
                    };
                };
            }
            catch(e:Error)
            {
                troopObj = new TroopBean();
            };
            return (troopObj);
        }

        public static function _fa102(_arg_1:int):void
        {
            disablingExpiredTime = (new Date().getTime() + (_arg_1 * 1000));
        }

        public static function isNameKingOrQueen(_arg_1:String):Boolean
        {
            return ((_arg_1.toLowerCase() == "queen") || (_arg_1.toLowerCase() == "king"));
        }

        public static function heroBeanToString(_arg_1:HeroBean):String
        {
            if (_arg_1 == null)
            {
                return ("no hero");
            };
            return (((((((((((_arg_1.name + " ") + _arg_1.management) + "/") + _arg_1.power) + "/") + _arg_1.stratagem) + " ") + _arg_1.level) + ((_arg_1.remainPoint > 0) ? ("-" + _arg_1.remainPoint) : "")) + ":") + _arg_1.experience);
        }

        public static function formatTime(_arg_1:Number):String
        {
            var _local_2:int = int(int(((_arg_1 / 3600) / 24)));
            var _local_3:int = int((int((_arg_1 / 3600)) % 24));
            var _local_4:int = int((int((_arg_1 / 60)) % 60));
            var _local_5:int = (_arg_1 % 60);
            if (_local_2 > 0)
            {
                return ((((((_local_2 + "d:") + _local_3) + "h:") + format2(_local_4)) + "m:") + format2(_local_5));
            };
            if (_local_3 > 0)
            {
                return ((((_local_3 + "h:") + format2(_local_4)) + "m:") + format2(_local_5));
            };
            return ((format2(_local_4) + "m:") + format2(_local_5));
        }

        public static function troopStrBeanToMsgString(_arg_1:TroopStrBean, _arg_2:Boolean=false):String
        {
            var _local_6:int;
            var _local_3:Object = _arg_1.toObject();
            var _local_4:* = "";
            var _local_5:Array = new Array(TFConstants.T_ARCHER, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CATAPULT, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS);
            for each (_local_6 in _local_5)
            {
                if ((((!(_local_3[troopIntNames[_local_6]] == null)) && (!(_local_3[troopIntNames[_local_6]] == ""))) && (!(_local_3[troopIntNames[_local_6]] == "0"))))
                {
                    _local_4 = (_local_4 + ((((_local_4 != "") ? "," : "") + ((_arg_2) ? "<b>" : "")) + ((troopAbrNames[_local_6] + ((_arg_2) ? "</b>:" : ":")) + _local_3[troopIntNames[_local_6]])));
                };
            };
            return (_local_4);
        }

        public static function resourceBeanToString(_arg_1:ResourceBean):String
        {
            var _local_5:String;
            if (_arg_1 == null)
            {
                return ("none");
            };
            var _local_2:int;
            var _local_3:* = "";
            var _local_4:Object = _arg_1.toObject();
            for (_local_5 in _local_4)
            {
                if (_local_4[_local_5] > 0)
                {
                    if ((_local_2 = resourceIntNames.indexOf(_local_5)) != -1)
                    {
                        if (_local_3.length > 0)
                        {
                            _local_3 = (_local_3 + ",");
                        };
                        _local_3 = (((_local_3 + resourceAbrNames[_local_2]) + ":") + Math.floor(_local_4[_local_5]));
                    };
                };
            };
            if (_local_3.length == 0)
            {
                return ("g:0");
            };
            return (_local_3);
        }

        public static function combineResource(_arg_1:ResourceBean, _arg_2:ResourceBean):ResourceBean
        {
            _arg_1.food = (_arg_1.food + _arg_2.food);
            _arg_1.gold = (_arg_1.gold + _arg_2.gold);
            _arg_1.stone = (_arg_1.stone + _arg_2.stone);
            _arg_1.iron = (_arg_1.iron + _arg_2.iron);
            _arg_1.wood = (_arg_1.wood + _arg_2.wood);
            return (_arg_1);
        }

        private static function experience(_arg_1:int):int
        {
            return (((_arg_1 * (_arg_1 + 1)) * ((2 * _arg_1) + 1)) / 6);
        }

        public static function trimDecimalFromResoAmounts(_arg_1:ResourceBean):void
        {
            _arg_1.gold = Math.floor(_arg_1.gold);
            _arg_1.food = Math.floor(_arg_1.food);
            _arg_1.wood = Math.floor(_arg_1.wood);
            _arg_1.stone = Math.floor(_arg_1.stone);
            _arg_1.iron = Math.floor(_arg_1.iron);
        }

        public static function getRandomInt(_arg_1:int, _arg_2:int):int
        {
            return (_arg_1 + Math.floor((Math.random() * ((_arg_2 - _arg_1) + 1))));
        }

        public static function formatInt(_arg_1:int):String
        {
            if (((_arg_1 > -1000) && (_arg_1 < 1000)))
            {
                return (_arg_1 + "");
            };
            var _local_2:* = (_arg_1 + "");
            var _local_3:* = "";
            if (_arg_1 < 0)
            {
                _local_3 = "-";
                _local_2 = _local_2.substring(1);
            };
            var _local_4:String = _local_2;
            var _local_5:int = _local_4.length;
            _local_2 = _local_4.substring((_local_5 - 3), _local_5);
            var _local_6:int = 3;
            while (_local_6 < _local_5)
            {
                if ((_local_6 % 3) == 0)
                {
                    _local_2 = ("," + _local_2);
                };
                _local_2 = (_local_4.charAt(((_local_5 - 1) - _local_6)) + _local_2);
                _local_6++;
            };
            return (_local_3 + _local_2);
        }

        public static function getChatTimeStr(_arg_1:Number):String
        {
            var _local_2:Date = new Date(_arg_1);
            return ((format2(_local_2.hours) + ":") + format2(_local_2.minutes));
        }

        public static function convertSpecCharToNumCodes(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false, _arg_8:Boolean=false):String
        {
            var _local_11:int;
            var _local_9:* = "";
            var _local_10:* = "";
            var _local_12:Array = ["&", "#", ";", "<", ">", "'", '"', "=", "/", "\\", "|", ",", ".", ":", "?", "!", "@", "$", "%", "^", "*", "(", ")", "[", "]", "{", "}", "_", "-", "+"];
            var _local_13:Array = ["&#38;", "&#35;", "&#59;", "&#60;", "&#62;", "&#39;", "&#34;", "&#61;", "&#47;", "&#92;", "&#124;", "&#44;", "&#46;", "&#58;", "&#63;", "&#33;", "&#64;", "&#36;", "&#37;", "&#94;", "&#42;", "&#40;", "&#41;", "&#91;", "&#93;", "&#123;", "&#125;", "&#95;", "&#45;", "&#43;"];
            if (!_arg_2)
            {
                _local_12[0] = "";
            };
            if (!_arg_3)
            {
                _local_12[1] = "";
            };
            if (!_arg_4)
            {
                _local_12[2] = "";
            };
            if (!_arg_5)
            {
                _local_12[3] = "";
            };
            if (!_arg_6)
            {
                _local_12[4] = "";
            };
            if (!_arg_7)
            {
                _local_12[5] = "";
            };
            if (!_arg_8)
            {
                _local_12[6] = "";
            };
            var _local_14:int;
            while (_local_14 < _arg_1.length)
            {
                _local_10 = _arg_1.charAt(_local_14);
                _local_11 = _local_12.indexOf(_local_10);
                _local_9 = (_local_9 + ((_local_11 == -1) ? _local_10 : _local_13[_local_11]));
                _local_14++;
            };
            return (_local_9);
        }

        public static function isHeroMaxLvl(_arg_1:HeroBean):Boolean
        {
            return (_arg_1.level >= ((_arg_1.ability > 0) ? 150 : ((_arg_1.isHero == 4) ? 120 : 100)));
        }

        public static function isNumeric(_arg_1:String):Boolean
        {
            return (!(isNaN(removeAbbr(_arg_1))));
        }

        public static function roundAmount(_arg_1:Number, _arg_2:int=1):Number
        {
            var _local_3:Number = 1E-8;
            if (_arg_1 <= 0)
            {
                return (0);
            };
            var _local_4:Number = ((Math.log(_arg_1) / Math.LN10) + _local_3);
            var _local_5:Number = Math.floor(_local_4);
            return (Math.floor(Math.pow(10, (((_local_4 - _local_5) + _arg_2) - 1))) * Math.pow(10, ((_local_5 - _arg_2) + 1)));
        }

        public static function isRoyalFound(_arg_1:ArrayCollection):Boolean
        {
            var _local_2:HeroBean;
            for each (_local_2 in _arg_1)
            {
                if (isHeroRoyal(_local_2))
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function convertHtmlCharCodesToNumCodes(_arg_1:String):String
        {
            var _local_4:String;
            var _local_5:String;
            var _local_2:Array = _arg_1.match(/&\w*;/g);
            var _local_3:Object = new Object();
            var _local_6:int;
            while (_local_6 < _local_2.length)
            {
                _local_4 = _local_2[_local_6];
                _local_5 = htmlCharMap[_local_4];
                if (((_local_5) && (!(_local_3[_local_4]))))
                {
                    _arg_1 = _arg_1.split(_local_4).join(_local_5);
                    _local_3[_local_4] = true;
                };
                _local_6++;
            };
            return (_arg_1);
        }

        public static function getEstResoBean(_arg_1:String):ResourceBean
        {
            var _local_6:String;
            if ((_arg_1 = _arg_1.toLowerCase()) == "none")
            {
                return (null);
            };
            var _local_2:ResourceBean = new ResourceBean();
            var _local_3:Array = _arg_1.split(",");
            if (((_local_3.length < 1) || (_arg_1.length == 0)))
            {
                return (null);
            };
            var _local_4:* = "";
            var _local_5:Array;
            for each (_local_6 in _local_3)
            {
                _local_5 = _local_6.split(":");
                if (((_local_5.length < 2) || (!(isNumeric(_local_5[1])))))
                {
                    return (null);
                };
                _local_4 = _local_5[0].toString().toLocaleLowerCase();
                if (_local_4.substr(0, 1) == "f")
                {
                    _local_4 = "food";
                }
                else
                {
                    if (_local_4.substr(0, 1) == "g")
                    {
                        _local_4 = "gold";
                    }
                    else
                    {
                        if (_local_4.substr(0, 1) == "i")
                        {
                            _local_4 = "iron";
                        }
                        else
                        {
                            if (_local_4.substr(0, 1) == "s")
                            {
                                _local_4 = "stone";
                            }
                            else
                            {
                                if (((_local_4.substr(0, 1) == "w") || (_local_4.substr(0, 1) == "l")))
                                {
                                    _local_4 = "wood";
                                }
                                else
                                {
                                    return (null);
                                };
                            };
                        };
                    };
                };
                _local_2[_local_4] = removeAbbr(_local_5[1]);
            };
            return (_local_2);
        }

        public static function isBestHeroByType(_arg_1:String, _arg_2:HeroBean, _arg_3:HeroBean):Boolean
        {
            var _local_4:Number = (getTotalPointsForHeroAttribute(_arg_2, _arg_1) + _arg_2.remainPoint);
            var _local_5:Number = (getTotalPointsForHeroAttribute(_arg_3, _arg_1) + _arg_3.remainPoint);
            if (_local_4 > _local_5)
            {
                return (true);
            };
            if (_local_4 < _local_5)
            {
                return (false);
            };
            if (_arg_2.level < _arg_3.level)
            {
                return (true);
            };
            if (_arg_2.level > _arg_3.level)
            {
                return (false);
            };
            return (_arg_2.id < _arg_3.id);
        }

        public static function abbrNum(_arg_1:Number):String
        {
            var _local_2:* = "";
            if (_arg_1 < 0)
            {
                _local_2 = "-";
                _arg_1 = -(_arg_1);
            };
            _arg_1 = roundAmount(_arg_1, 3);
            if (_arg_1 >= 1000000000000)
            {
                return ((_local_2 + (_arg_1 / 1000000000000)) + "t");
            };
            if (_arg_1 >= 0x3B9ACA00)
            {
                return ((_local_2 + (_arg_1 / 0x3B9ACA00)) + "b");
            };
            if (_arg_1 >= 1000000)
            {
                return ((_local_2 + (_arg_1 / 1000000)) + "m");
            };
            if (_arg_1 >= 1000)
            {
                return ((_local_2 + (_arg_1 / 1000)) + "k");
            };
            return ((_local_2 + (_arg_1 / 1)) + "");
        }

        public static function searchAndReplace(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            var _local_4:Array = _arg_1.split(_arg_2);
            return (_local_4.join(_arg_3));
        }

        public static function getTotalPointsForHeroAttribute(_arg_1:HeroBean, _arg_2:String):Number
        {
            var _local_3:String = ((_arg_2 == "power") ? "attack" : ((_arg_2 == "management") ? "politics" : "intelligence"));
            return (((_arg_1[_arg_2] * (100 + _arg_1[(_arg_2 + "BuffAdded")])) / 100) + _arg_1[_local_3]);
        }

        public static function getServerTimeStr(_arg_1:Boolean=false):String
        {
            var _local_2:Date = getCurrentServerTimeRaw();
            return (((format2(_local_2.hours) + ":") + format2(_local_2.minutes)) + ((_arg_1) ? (":" + format2(_local_2.seconds)) : ""));
        }

        public static function getTotalQueueEndTime(_arg_1:AllProduceBean):Number
        {
            var _local_4:ProduceBean;
            var _local_2:Number = getServerTime();
            var _local_3:Number = 0;
            for each (_local_4 in _arg_1.allProduceQueueArray)
            {
                if (_local_3 == 0)
                {
                    _local_3 = _local_4.endTime;
                }
                else
                {
                    _local_3 = (_local_3 + (_local_4.costTime * 1000));
                };
            };
            return (_local_3);
        }

        public static function troopBeanToString(_arg_1:TroopBean):String
        {
            var _local_5:int;
            var _local_2:Array = new Array(TFConstants.T_ARCHER, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CATAPULT, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS);
            var _local_3:Object = _arg_1.toObject();
            var _local_4:* = "";
            for each (_local_5 in _local_2)
            {
                if (_local_3[troopIntNames[_local_5]] > 0)
                {
                    _local_4 = (_local_4 + (((((_local_4.length > 0) ? "," : "") + troopAbrNames[_local_5]) + ":") + _local_3[troopIntNames[_local_5]]));
                };
            };
            return (_local_4);
        }

        public static function setServerTime(_arg_1:Number):void
        {
            serverTimeAdjust = (_arg_1 - new Date().getTime());
        }

        public static function isBestHeroByTypeIncGear(_arg_1:String, _arg_2:HeroBean, _arg_3:HeroBean):Boolean
        {
            var _local_4:Number = ((((getTotalPointsForHeroAttribute(_arg_2, _arg_1) + _arg_2.remainPoint) + _arg_2.politics) + _arg_2.attack) + _arg_2.intelligence);
            var _local_5:Number = ((((getTotalPointsForHeroAttribute(_arg_3, _arg_1) + _arg_3.remainPoint) + _arg_3.politics) + _arg_3.attack) + _arg_3.intelligence);
            if (_local_4 > _local_5)
            {
                return (true);
            };
            if (_local_4 < _local_5)
            {
                return (false);
            };
            if (_arg_2.level < _arg_3.level)
            {
                return (true);
            };
            if (_arg_2.level > _arg_3.level)
            {
                return (false);
            };
            return (_arg_2.id < _arg_3.id);
        }

        public static function getServerTime():Number
        {
            return (new Date().getTime() + serverTimeAdjust);
        }

        public static function getFlashPlayerType():String
        {
            return (((Capabilities.playerType + " (") + Capabilities.version) + ")");
        }

        public static function setServerTimeZoneAdjust(serverTime:Number, serverTimeStr:String):void
        {
            var localServerTime:Number;
            try
            {
                localServerTime = getLocServTime(serverTimeStr);
                serverTimeZoneAdjust = (localServerTime - serverTime);
                serverTimeZoneAdjust = (Math.round((serverTimeZoneAdjust / 60000)) * 60000);
            }
            catch(error:Error)
            {
                serverTimeZoneAdjust = 0;
            };
        }

        public static function armyReportToString(_arg_1:XMLList, _arg_2:Boolean=false):String
        {
            if (_arg_1.troopMovement != undefined)
            {
                if (((_arg_1.troopMovement.@isBack == true) || (_arg_1.troopMovement.@problem == undefined)))
                {
                    return ("Colonize wave returned ");
                };
                return ("Colonize wave returned " + _arg_1.troopMovement.@problem);
            };
            var _local_3:* = (_arg_1.@isAttack == "true");
            var _local_4:* = (_arg_1.@isAttackSuccess == "true");
            var _local_5:* = (_arg_1.@isSuppress == "true");
            var _local_6:Boolean = _arg_1.hasOwnProperty("@isSuppress");
            var _local_7:* = (_arg_1.@isColonial == "true");
            var _local_8:Boolean = _arg_1.hasOwnProperty("@isColonial");
            var _local_9:* = (_arg_1.@isSuzerain == "true");
            var _local_10:Boolean = _arg_1.hasOwnProperty("@isSuzerain");
            var _local_11:String = ((((_arg_1.attackTroop.@heroName.toString() != "") ? (((_arg_1.attackTroop.@heroName + "(") + _arg_1.attackTroop.@heroLevel) + ") ") : "") + ((_local_3) ? "" : ((" (" + _arg_1.attackTroop.@king[0]) + ")"))) + ((_arg_1.backTroop.troops.@isHeroBeSeized != "true") ? "" : " (Captured)"));
            var _local_12:String = ((_arg_1.defendTroop.@heroName.toString() != "") ? (((_arg_1.defendTroop.@heroName + "(") + _arg_1.defendTroop.@heroLevel) + ") ") : "");
            var _local_13:String = ((_arg_1.@seizeProblem[0] != undefined) ? ((((((((("f:" + _arg_1.lootResource.food) + " g:") + _arg_1.lootResource.gold) + " w:") + _arg_1.lootResource.wood) + " s:") + _arg_1.lootResource.stone) + " i:") + _arg_1.lootResource.iron) : "");
            var _local_14:String = ((_arg_1.@round != undefined) ? (" Rnd: " + _arg_1.@round[0]) : "");
            var _local_15:String = ((_arg_1.@heroExp != undefined) ? (" Exp: " + _arg_1.@heroExp[0]) : "");
            var _local_16:String = ((_arg_1.@honor != undefined) ? (" Honor: " + _arg_1.@honor[0]) : "");
            var _local_17:String = ((_arg_1.@injuredPer != undefined) ? ((" Heal: " + int(_arg_1.@injuredPer)) + "%") : "");
            var _local_18:String = ((_arg_1.@seizeProblem != undefined) ? (" Loy: " + _arg_1.@seizeProblem[0].toString().substr(28, 2)) : "");
            var _local_19:* = "";
            var _local_20:* = "";
            if ((((_local_3) && (_local_8)) && (_local_7)))
            {
                _local_20 = "You Colonized";
            }
            else
            {
                if ((((_local_3) && (_local_6)) && (_local_5)))
                {
                    _local_20 = "You Suppressed";
                }
                else
                {
                    if ((((!(_local_3)) && (_local_10)) && (_local_9)))
                    {
                        _local_20 = "Your Colony Was attacked";
                    }
                    else
                    {
                        if (_local_3)
                        {
                            _local_20 = "You Attacked";
                        }
                        else
                        {
                            _local_20 = "You Defended";
                        };
                    };
                };
            };
            _local_20 = ((((((((_local_20 + " and <b>") + (((((((_local_4) && (_local_3)) && (!(_local_9))) || ((!(_local_3)) && (!(_local_4)))) || ((_local_3) && (_local_5))) || (((!(_local_3)) && (_local_6)) && (!(_local_5)))) ? "WON :)" : "Lost :(")) + "</b>") + _local_14) + _local_15) + _local_16) + _local_18) + _local_17);
            var _local_21:* = "";
            var _local_22:* = undefined;
            var _local_23:* = undefined;
            var _local_24:int;
            for each (_local_22 in _arg_1.attackTroop.troopUnit)
            {
                _local_24 = int(_local_22.@typeId);
                if (!((!(hasValue(_local_22.@count))) || (!(hasValue(_local_22.@lose)))))
                {
                    if (int(_local_22.@count) != 0)
                    {
                        if (_local_21.length != 0)
                        {
                            _local_21 = (_local_21 + ", ");
                        };
                        if (_local_21.length == 0)
                        {
                            _local_21 = (_local_11 + " ");
                            while (_local_21.length < 10)
                            {
                                _local_21 = (_local_21 + " ");
                            };
                        };
                        if (int(_local_22.@lose) > 0)
                        {
                            _local_21 = (_local_21 + "<b>");
                        };
                        _local_21 = (_local_21 + ((((troopAbrNames[_local_24] + ":") + int(_local_22.@count)) + "/") + int(_local_22.@lose)));
                        if (_local_3)
                        {
                            for each (_local_23 in _arg_1.autoHeal.troopUnit)
                            {
                                if (_local_24 == int(_local_23.@typeId))
                                {
                                    _local_21 = (_local_21 + ("/" + _local_23.@count));
                                    break;
                                };
                            };
                            for each (_local_23 in _arg_1.backTroop.troops[0])
                            {
                                if (_local_24 == int(_local_23.@typeId))
                                {
                                    _local_21 = (_local_21 + ("/" + _local_23.@remain));
                                    break;
                                };
                            };
                        };
                        if ((int(_local_22.@lose) > 0))
                        {
                            _local_21 = (_local_21 + "</b>");
                        };
                    };
                };
            };
            if (_local_21.length != 0)
            {
                if (_local_3)
                {
                    _local_21 = (_local_21 + _local_17);
                };
            }
            else
            {
                _local_21 = "<i>NO TROOP INFO</i>";
            };
            var _local_25:* = "";
            for each (_local_22 in _arg_1.defendTroop.troopUnit)
            {
                _local_24 = int(_local_22.@typeId);
                if (!((!(hasValue(_local_22.@count))) || (!(hasValue(_local_22.@lose)))))
                {
                    if (int(_local_22.@count) != 0)
                    {
                        if (_local_25.length != 0)
                        {
                            _local_25 = (_local_25 + ", ");
                        };
                        if (_local_25.length == 0)
                        {
                            _local_25 = (_local_12 + " ");
                            while (_local_25.length < 10)
                            {
                                _local_25 = (_local_25 + " ");
                            };
                        };
                        if (int(_local_22.@lose) > 0)
                        {
                            _local_25 = (_local_25 + "<b>");
                        };
                        _local_25 = (_local_25 + ((((troopAbrNames[_local_24] + ":") + int(_local_22.@count)) + "/") + int(_local_22.@lose)));
                        if (!_local_3)
                        {
                            for each (_local_23 in _arg_1.autoHeal.troopUnit)
                            {
                                if (_local_24 == int(_local_23.@typeId))
                                {
                                    _local_25 = (_local_25 + ("/" + _local_23.@count));
                                    break;
                                };
                            };
                            for each (_local_23 in _arg_1.backTroop.troops[0])
                            {
                                if (_local_24 == int(_local_23.@typeId))
                                {
                                    _local_25 = (_local_25 + ("/" + _local_23.@remain));
                                    break;
                                };
                            };
                        };
                        if ((int(_local_22.@lose) > 0))
                        {
                            _local_25 = (_local_25 + "</b>");
                        };
                    };
                };
            };
            if (_local_25.length != 0)
            {
                if (!_local_3)
                {
                    _local_25 = (_local_25 + _local_17);
                };
            }
            else
            {
                _local_25 = "<i>NO TROOP INFO</i>";
            };
            if (((_local_21 == "<i>NO TROOP INFO</i>") && (_local_25 == "<i>NO TROOP INFO</i>")))
            {
                _local_19 = (_local_20 + " <I>NO REPORT</I>");
            }
            else
            {
                _local_19 = (((((((((_local_20 + "<br>") + ((_arg_2) ? "<br>" : "")) + '<font color="#BB0000">') + _local_21) + "</font><br>") + ((_arg_2) ? "<br>" : "")) + '<font color="#007700">') + _local_25) + "</font>");
                if (_arg_1.@seizeProblem[0] != undefined)
                {
                    _local_19 = (_local_19 + (("<br>" + ((_arg_2) ? "<br>" : "")) + _local_13));
                };
            };
            return (_local_19);
        }

        public static function formatHeroName(_arg_1:HeroBean):void
        {
            _arg_1.name = _arg_1.name.split(" ").join("").split("-").join("").split(",").join("");
        }

        public static function fixNumber(_arg_1:Number):String
        {
            var _local_2:String = _arg_1.toFixed(2);
            if (_local_2.indexOf(".00") != -1)
            {
                return (_arg_1.toFixed(0));
            };
            if (_local_2.lastIndexOf("0") == (_local_2.length - 1))
            {
                return (_arg_1.toFixed(1));
            };
            return (_local_2);
        }

        public static function sortFieldsByDistance(castle:CastleBean):void
        {
            var cstleFieldId:int;
            cstleFieldId = castle.fieldId;
            var sortFieldsByDistanceHelper:Function = function (_arg_1:FieldBean, _arg_2:FieldBean):int
            {
                var _local_3:Number = Map.fieldDistance(_arg_1.id, cstleFieldId);
                var _local_4:Number = Map.fieldDistance(_arg_2.id, cstleFieldId);
                if (_local_3 < _local_4)
                {
                    return (-1);
                };
                if (_local_3 > _local_4)
                {
                    return (1);
                };
                return (0);
            };
            castle.fieldsArray.source.sort(sortFieldsByDistanceHelper);
        }

        public static function sortByReachTime(_arg_1:ArmyBean, _arg_2:ArmyBean):int
        {
            if (_arg_1.reachTime < _arg_2.reachTime)
            {
                return (-1);
            };
            if (_arg_1.reachTime > _arg_2.reachTime)
            {
                return (1);
            };
            return (0);
        }

        public static function callLater(delay:Number, func:Function, args:Array=null):void
        {
            var handler:Function;
            var timer:Timer;
            handler = function (_arg_1:TimerEvent):void
            {
                func.apply(null, args);
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, handler);
            };
            timer = new Timer(delay, 1);
            timer.addEventListener(TimerEvent.TIMER, handler);
            timer.start();
        }

        public static function getCurrentServerTimeRaw():Date
        {
            return (new Date((getServerTime() + serverTimeZoneAdjust)));
        }

        private static function _ba40(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            if (_arg_2 < 150)
            {
                _local_3 = ((150 - _arg_2) + _arg_1);
                return (experience(_local_3) - experience(_arg_1));
            };
            return (-(_arg_2));
        }

        public static function removeAbbr(_arg_1:String):Number
        {
            _arg_1 = _arg_1.toLowerCase();
            var _local_2:String = _arg_1.charAt((_arg_1.length - 1));
            if (_local_2 == "k")
            {
                return (Number(_arg_1.substring(0, (_arg_1.length - 1))) * 1000);
            };
            if (_local_2 == "m")
            {
                return (Number(_arg_1.substring(0, (_arg_1.length - 1))) * 1000000);
            };
            if (_local_2 == "b")
            {
                return (Number(_arg_1.substring(0, (_arg_1.length - 1))) * 0x3B9ACA00);
            };
            if (_local_2 == "t")
            {
                return (Number(_arg_1.substring(0, (_arg_1.length - 1))) * 1000000000000);
            };
            return (Number(_arg_1));
        }

        public static function getFortifications(_arg_1:String):FortificationsBean
        {
            var _local_5:String;
            if ((_arg_1 = _arg_1.toLowerCase()) == "none")
            {
                return (null);
            };
            var _local_2:FortificationsBean = new FortificationsBean();
            var _local_3:Array = _arg_1.split(",");
            if (_local_3.length < 1)
            {
                return (null);
            };
            var _local_4:Array;
            for each (_local_5 in _local_3)
            {
                _local_4 = _local_5.split(":");
                if (_local_4.length < 2)
                {
                    return (null);
                };
                _local_4[1] = parseFloat(String(_local_4[1]).replace(new RegExp("k", "gi"), "E3").replace(new RegExp("m", "gi"), "E6"));
                switch (_local_4[0].toString())
                {
                    case "tra":
                    case "trap":
                    case "traps":
                        _local_2.trap = int(_local_4[1]);
                        break;
                    case "ab":
                    case "abs":
                    case "abatis":
                        _local_2.abatis = int(_local_4[1]);
                        break;
                    case "at":
                    case "ats":
                    case "tower":
                    case "towers":
                    case "archertower":
                    case "archertowers":
                        _local_2.arrowTower = int(_local_4[1]);
                        break;
                    case "r":
                    case "rl":
                    case "log":
                    case "logs":
                    case "rollinglog":
                    case "rollinglogs":
                        _local_2.rollingLogs = int(_local_4[1]);
                        break;
                    case "tre":
                    case "treb":
                    case "trebs":
                    case "trebuchet":
                    case "trebuchets":
                    case "rf":
                    case "rock":
                    case "rockfall":
                        _local_2.rockfall = int(_local_4[1]);
                        break;
                    default:
                        return (null);
                };
            };
            return (_local_2);
        }

        public static function getServerEndTimeStr(_arg_1:Number):String
        {
            var _local_2:Date = new Date((_arg_1 + serverTimeZoneAdjust));
            return ((((((format2(_local_2.hours) + ":") + format2(_local_2.minutes)) + ":") + format2(_local_2.seconds)) + ".") + format1(_local_2.getMilliseconds()));
        }

        public static function getHeroSpeedFactor(_arg_1:HeroBean):Number
        {
            if (_arg_1 == null)
            {
                return (HEROSPEEDUP[0]);
            };
            if (_arg_1.speed < 10)
            {
                return (HEROSPEEDUP[0]);
            };
            if (_arg_1.speed >= 100)
            {
                return (HEROSPEEDUP[10]);
            };
            return (HEROSPEEDUP[(_arg_1.speed / 10)]);
        }

        public static function getTimeStr(_arg_1:Number):String
        {
            var _local_2:Date = new Date(_arg_1);
            return ((((((format2(_local_2.hours) + ":") + format2(_local_2.minutes)) + ":") + format2(_local_2.seconds)) + ".") + format1(_local_2.getMilliseconds()));
        }

        public static function fortBeanToMsgString(_arg_1:FortificationsBean, _arg_2:Boolean=true):String
        {
            var _local_6:String;
            if (_arg_1 == null)
            {
                return ("none");
            };
            var _local_3:int;
            var _local_4:* = "";
            var _local_5:Object = _arg_1.toObject();
            for (_local_6 in _local_5)
            {
                if (((_local_5[_local_6] > 0) && (!((_local_3 = troopIntNames.indexOf(_local_6)) == -1))))
                {
                    _local_4 = (_local_4 + (((((_local_4.length > 0) ? "," : "") + troopAbrNames[_local_3]) + ":") + Math.floor(_local_5[_local_6])));
                };
            };
            return ((_local_4.length > 0) ? _local_4 : ((_arg_2) ? "tra:0" : "none"));
        }

        public static function hasValue(_arg_1:String):Boolean
        {
            if (_arg_1 == "")
            {
                return (false);
            };
            return (!(isNaN(Number(_arg_1))));
        }

        public static function formatUrl(_arg_1:String, _arg_2:String, _arg_3:String="#4377F9"):String
        {
            return ((_arg_2 == "") ? _arg_1 : (((((("<u><b><font color='" + _arg_3) + "'><a href='event:") + _arg_2) + "'>") + _arg_1) + "</a></font></b></u>"));
        }


    }
}//package autoevony.common

