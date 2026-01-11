// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.management.CityConfigs

package autoevony.management
{
    import autoevony.common.Utils;

    public class CityConfigs 
    {

        public static const CFG_DEBUG:String = "debug";
        public static const CFG_NPC:String = "npc";
        public static const CFG_NPCLIMIT:String = "npclimit";
        public static const CFG_TRAINING:String = "training";
        public static const CFG_COMFORT:String = "comfort";
        public static const CFG_MINTAXRATE:String = "mintaxrate";
        public static const CFG_NORESCUE:String = "norescue";
        public static const CFG_ABANDON:String = "abandon";
        public static const CFG_BUILDING:String = "building";
        public static const CFG_RESEARCH:String = "research";
        public static const CFG_TROOP:String = "troop";
        public static const CFG_FORTIFICATION:String = "fortification";
        public static const CFG_TRADING:String = "trade";
        public static const CFG_HERO:String = "hero";
        public static const CFG_FASTHERO:String = "fasthero";
        public static const CFG_HEROMINATTACK:String = "herominattack";
        public static const CFG_NOCAPTURE:String = "nocapture";
        public static const CFG_AUTOMEDAL:String = "automedal";
        public static const CFG_JUNKHERO:String = "junkhero";
        public static const CFG_RESERVEDENERGY:String = "reservedenergy";
        public static const CFG_AUTOGEAR:String = "autogear";
        public static const CFG_NOMAYOR:String = "nomayor";
        public static const CFG_FHRESERVED:String = "fhreserved";
        public static const CFG_VALLEY:String = "valley";
        public static const CFG_HUNTING:String = "hunting";
        public static const CFG_SLOWHUNTING:String = "slowhunting";
        public static const CFG_HIDING:String = "hiding";
        public static const CFG_MARKETHIDING:String = "markethiding";
        public static const CFG_BUILDNPC:String = "buildnpc";
        public static const CFG_FLATROLLING:String = "flatrolling";
        public static const CFG_DUMPING:String = "dumping";
        public static const CFG_DUMPINGMAX:String = "dumpingmax";
        public static const CFG_GATE:String = "gate";
        public static const CFG_ATTACKGAP:String = "attackgap";
        public static const CFG_EMBOPEN:String = "embopen";
        public static const CFG_KEEPREPORTS:String = "keepreports";
        public static const CFG_NOREPORTS:String = "noreports";
        public static const CFG_KEEPJUNKARMYREPORTS:String = "keepjunkarmyreports";
        public static const CFG_KEEPJUNKSCOUTREPORTS:String = "keepjunkscoutreports";
        public static const CFG_WARREPORT:String = "warreport";
        public static const CFG_SKYPEWARREPORT:String = "skypewarreport";
        public static const CFG_SKYPEJUNKWARREPORT:String = "skypejunkwarreport";
        public static const CFG_ATTACKWARNING:String = "attackwarning";
        public static const CFG_SKYPEWARNING:String = "skypewarning";
        public static const CFG_EMAILWARNING:String = "emailwarning";
        public static const CFG_LIMITATKWARNINGLOGMSG:String = "limitatkwarninglogmsg";
        public static const CFG_JUNKWAVE:String = "junkwave";
        public static const CFG_JUNKSCOUT:String = "junkscout";
        public static const CFG_RESPONSE:String = "response";
        public static const CFG_WARTOWN:String = "wartown";
        public static const CFG_AUTOWARPOL:String = "autowarpol";
        public static const CFG_NOHEALING:String = "nohealing";
        public static const CFG_SAFEMAINT:String = "safemaint";
        public static const CFG_EXTRAFOOD:String = "extrafood";
        public static const CFG_RELOGIN:String = "relogin";
        public static const CFG_ENEMYWARNING:String = "enemywarning";
        public static const CFG_ADVEVASION:String = "advevasion";
        public static const CFG_ADVEVASIONMINLAYERSIZE:String = "advevasionminlayersize";
        public static const CFG_ADVEVASIONLAYERMULTI:String = "advevasionlayermulti";
        public static const CFG_ADVEVASIONDBG:String = "advevasiondbg";
        public static const CFG_FASTKEEPRESO:String = "fastkeepreso";
        public static const CFG_NOAUTOQUEST:String = "noautoquest";
        public static const CFG_NOAUTOCLAIMGIFTS:String = "noautoclaimgifts";
        public static const CFG_ALLOWDISABLESECCODE:String = "allowdisableseccode";
        public static const CFG_ZEROFOOD:String = "zerofood";
        public static const CFG_MAXPRODUCTION:String = "maxproduction";
        public static const CFG_LOOKAHEAD:String = "lookahead";
        public static const DBG_NORMAL:int = 1;
        public static const DBG_POPULATION:int = 10;
        public static const DBG_NPCATTACK:int = 11;
        public static const DBG_WARREPORT:int = 12;
        public static const DBG_TRADING:int = 13;
        public static const DBG_BUILDNPC:int = 14;
        public static const DBG_ADVEVASION:int = 30;
        public static const DBG_ADVEVASION1:int = 31;
        public static const DBG_ADVEVASION2:int = 32;

        public var configs:Object = new Object();


        public function deleteAllCfgs():void
        {
            var _local_1:String;
            for (_local_1 in this.configs)
            {
                delete this.configs[_local_1];
            };
        }

        public function deleteCfg(_arg_1:String):void
        {
            if (this.configs[_arg_1] != undefined)
            {
                delete this.configs[_arg_1];
            };
        }

        public function setCfg(_arg_1:String, _arg_2:Function, _arg_3:Function):Boolean
        {
            var _local_8:String;
            var _local_4:Array = new Array(CFG_NPC, CFG_NPCLIMIT, CFG_COMFORT, CFG_RESEARCH, CFG_BUILDING, CFG_TRADING, CFG_FORTIFICATION, CFG_TROOP, CFG_HERO, CFG_HUNTING, CFG_SLOWHUNTING, CFG_HIDING, CFG_MARKETHIDING, CFG_BUILDNPC, CFG_DEBUG, CFG_VALLEY, CFG_DUMPING, CFG_TRAINING, CFG_FASTHERO, CFG_ABANDON, CFG_GATE, CFG_WARREPORT, CFG_SKYPEWARREPORT, CFG_SKYPEJUNKWARREPORT, CFG_ATTACKWARNING, CFG_NOCAPTURE, CFG_RESPONSE, CFG_WARTOWN, CFG_ATTACKGAP, CFG_NOHEALING, CFG_JUNKHERO, CFG_KEEPREPORTS, CFG_SAFEMAINT, CFG_NOMAYOR, CFG_EXTRAFOOD, CFG_RELOGIN, CFG_SKYPEWARNING, CFG_EMAILWARNING, CFG_HEROMINATTACK, CFG_FHRESERVED, CFG_MINTAXRATE, CFG_ENEMYWARNING, CFG_AUTOGEAR, CFG_FLATROLLING, CFG_NORESCUE, CFG_MAXPRODUCTION, CFG_RESERVEDENERGY, CFG_LOOKAHEAD, CFG_NOAUTOQUEST, CFG_NOAUTOCLAIMGIFTS, CFG_ALLOWDISABLESECCODE, CFG_ZEROFOOD, CFG_NOREPORTS, CFG_JUNKWAVE, CFG_JUNKSCOUT, CFG_KEEPJUNKARMYREPORTS, CFG_KEEPJUNKSCOUTREPORTS, CFG_ADVEVASION, CFG_ADVEVASIONDBG, CFG_ADVEVASIONMINLAYERSIZE, CFG_ADVEVASIONLAYERMULTI, CFG_LIMITATKWARNINGLOGMSG, CFG_FASTKEEPRESO, CFG_DUMPINGMAX, CFG_EMBOPEN, CFG_AUTOWARPOL, CFG_AUTOMEDAL);
            if (_arg_1 == null)
            {
                (_arg_3(("Empty config, available: " + _local_4.join(" "))));
                return (false);
            };
            var _local_5:Boolean = true;
            var _local_6:Array = _arg_1.toLowerCase().split(",");
            var _local_7:Array;
            for each (_local_8 in _local_6)
            {
                _local_7 = _local_8.split(":");
                if (_local_7.length != 2)
                {
                    (_arg_3(("Invalid config setting, expecting name:value but getting " + _local_8)));
                    _local_5 = false;
                }
                else
                {
                    if (_local_4.indexOf(_local_7[0]) != -1)
                    {
                        if (Utils.hasValue(_local_7[1]))
                        {
                            if (this.configs[_local_7[0]] != undefined)
                            {
                                (_arg_2((((("Config value of " + _local_7[0]) + " is changed to ") + _local_7[1]) + ", previous value discarded")));
                            };
                            this.configs[_local_7[0]] = Number(_local_7[1]);
                        }
                        else
                        {
                            (_arg_3(((("Invalid numeric value for " + _local_7[0]) + ":") + _local_7[1])));
                            _local_5 = false;
                        };
                    }
                    else
                    {
                        (_arg_3(((("Invalid config name: " + _local_7[0]) + ", available: ") + _local_4.join(" "))));
                        _local_5 = false;
                    };
                };
            };
            return (_local_5);
        }

        public function getCfg(_arg_1:String):Number
        {
            return ((this.configs[_arg_1] == undefined) ? ((_arg_1 != CFG_JUNKWAVE) ? 0 : 100) : this.configs[_arg_1]);
        }


    }
}//package autoevony.management

