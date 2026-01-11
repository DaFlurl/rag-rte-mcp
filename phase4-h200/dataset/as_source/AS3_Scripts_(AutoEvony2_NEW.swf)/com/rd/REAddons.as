// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.rd.REAddons

package com.rd
{
    import flash.utils.Timer;
    import autoevony.management.CityManager;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.beans.HeroBean;
    import flash.events.TimerEvent;
    import autoevony.scripts.CityState;
    import autoevony.common.CityStateConstants;
    import autoevony.common.CityStateCommands;
    import autoevony.net.Connection;
    import autoevony.event.CityStateResponseEvent;
    import autoevony.gui.MainScreen;

    public class REAddons 
    {

        private static var CitySuppresionTimers:Array = new Array();
        private static var CityColonizationTimers:Array = new Array();
        private static var _suppressionPreTime:int = 3000;
        private static var _suppressionPostTime:int = 3000;
        private static var _colonizationPostTime:int = 3000;
        private static var _colonizationPostTime2:int = 3000;
        private static var colonizationPostTimeOffset:Number = 1000000;
        private static var _varAutoNames:Array = new Array();
        private static var suppTroopsArray:Object = new Object();
        private static var _varLordIgnoreRed:Array = new Array();
        private static var HeroRenameTimer:Timer = null;
        private static var ArrayOfHerosToRename:Array = null;
        private static var me:REAddons = null;
        private static var KingRenameTimer:Timer = null;
        private static var KingRenameTimerCM:CityManager = null;

        {
            _suppressionPreTime = 3000;
            _suppressionPostTime = 3000;
            _colonizationPostTime = 3000;
            _colonizationPostTime2 = 3000;
            colonizationPostTimeOffset = 1000000;
            HeroRenameTimer = null;
            ArrayOfHerosToRename = null;
            me = null;
            KingRenameTimer = null;
            KingRenameTimerCM = null;
        }

        public function REAddons()
        {
            var _local_1:TroopBean = new TroopBean();
            _local_1.peasants = 0;
            _local_1.militia = 0;
            _local_1.scouter = 0;
            _local_1.pikemen = 0;
            _local_1.swordsmen = 0;
            _local_1.archer = 0;
            _local_1.lightCavalry = 0;
            _local_1.heavyCavalry = 0;
            _local_1.carriage = 0;
            _local_1.ballista = 0;
            _local_1.batteringRam = 0;
            _local_1.catapult = 0;
            suppTroopsArray[0] = _local_1;
            super();
        }

        public static function set varLordIgnoreRed(_arg_1:Array):void
        {
            _varLordIgnoreRed = _arg_1;
        }

        public static function getInstance():REAddons
        {
            if (me == null)
            {
                me = new (REAddons)();
            };
            return (me);
        }

        public static function set varAutoNames(_arg_1:Array):void
        {
            _varAutoNames = _arg_1;
        }

        public static function get varLordIgnoreRed():Array
        {
            return (_varLordIgnoreRed);
        }

        public static function get varAutoNames():Array
        {
            return (_varAutoNames);
        }


        public function doHeroName(_arg_1:CityState):void
        {
            var _local_3:HeroBean;
            if (HeroRenameTimer != null)
            {
                HeroRenameTimer.removeEventListener(TimerEvent.TIMER, this.doProcessHeroNames);
            }
            else
            {
                HeroRenameTimer = new Timer(5000);
            };
            HeroRenameTimer.stop();
            ArrayOfHerosToRename = new Array();
            var _local_2:Object;
            for each (_local_3 in _arg_1.cityManager.heroes)
            {
                _local_2 = new Object();
                _local_2.city = _arg_1;
                _local_2.hero = _local_3;
                ArrayOfHerosToRename.push(_local_2);
            };
            HeroRenameTimer.addEventListener(TimerEvent.TIMER, this.doProcessHeroNames);
            HeroRenameTimer.start();
        }

        private function doRenameKingEvent(_arg_1:TimerEvent):void
        {
            var _local_2:HeroBean;
            KingRenameTimer.reset();
            KingRenameTimer.delay = 750;
            KingRenameTimer.repeatCount = 1;
            for each (_local_2 in KingRenameTimerCM.heroes)
            {
                if (((_local_2.name.toLocaleLowerCase() == "king") && (_local_2.isHero == 0)))
                {
                    if (((_local_2.status == CityStateConstants.HERO_STATUS_IDLE) || (_local_2.status == CityStateConstants.HERO_STATUS_MAYOR)))
                    {
                        KingRenameTimerCM.logMsg("AUTO CHANGE NAME OF NON ROYAL KING > Trying to Rename non Royal King to Kinglet", "#00006A");
                        CityStateCommands.changeName(KingRenameTimerCM._getCastleId(), _local_2.id, "Kinglet");
                        KingRenameTimerCM.setHeroUpdateNeeded(true);
                        break;
                    };
                    KingRenameTimerCM.logMsg("AUTO CHANGE NAME OF NON ROYAL KING > King is busy, will try again later", "#00006A");
                    KingRenameTimer.start();
                    return;
                };
            };
            KingRenameTimerCM.logMsg("AUTO CHANGE NAME OF NON ROYAL KING > Canceling attempts to rename non royal King to 'Kinga'", "#00006A");
            KingRenameTimer.reset();
            KingRenameTimer.stop();
            KingRenameTimer = null;
            KingRenameTimer.removeEventListener(TimerEvent.TIMER, this.doRenameKingEvent);
        }

        private function doProcessHeroNames(_arg_1:TimerEvent):void
        {
            var _local_3:String;
            if (!Connection.getInstance().authenticated)
            {
                ArrayOfHerosToRename = new Array();
                HeroRenameTimer.stop();
                return;
            };
            if (ArrayOfHerosToRename.length <= 0)
            {
                HeroRenameTimer.stop();
                return;
            };
            var _local_2:Object = ArrayOfHerosToRename.shift();
            if ((((!(_local_2.hero.status == CityStateConstants.HERO_STATUS_IDLE)) && (!(_local_2.hero.status == CityStateConstants.HERO_STATUS_MAYOR))) || (HeroBean(_local_2.hero).isHero > 0)))
            {
                ArrayOfHerosToRename.push(_local_2);
                HeroRenameTimer.delay = 500;
            }
            else
            {
                _local_3 = null;
                if (((_local_2.hero.power > _local_2.hero.stratagem) && (_local_2.hero.power > _local_2.hero.management)))
                {
                    _local_3 = ((((("a" + (_local_2.hero.power - _local_2.hero.level)) + "i") + _local_2.hero.stratagem) + "p") + _local_2.hero.management);
                }
                else
                {
                    if (((_local_2.hero.stratagem > _local_2.hero.power) && (_local_2.hero.stratagem > _local_2.hero.management)))
                    {
                        _local_3 = ((((("i" + (_local_2.hero.stratagem - _local_2.hero.level)) + "a") + _local_2.hero.power) + "p") + _local_2.hero.management);
                    }
                    else
                    {
                        if (((_local_2.hero.management > _local_2.hero.power) && (_local_2.hero.management > _local_2.hero.stratagem)))
                        {
                            _local_3 = ((((("p" + (_local_2.hero.management - _local_2.hero.level)) + "a") + _local_2.hero.power) + "i") + _local_2.hero.stratagem);
                        };
                    };
                };
                if (_local_2.hero.name.toLowerCase() != _local_3.toLowerCase())
                {
                    _local_2.city.dispatchEvent(new CityStateResponseEvent(((("Hero Rename: " + _local_2.hero.name) + " to: ") + _local_3), "", "#ff0000"));
                    _local_2.city.changeheroname(_local_2.hero.name, _local_3);
                    HeroRenameTimer.delay = (5000 + Math.floor((Math.random() * 5000)));
                }
                else
                {
                    _local_2.city.dispatchEvent(new CityStateResponseEvent(("Not Renaming Hero: " + _local_2.hero.name), "", "#ff0000"));
                    HeroRenameTimer.delay = 500;
                };
            };
            HeroRenameTimer.start();
        }

        public function renameKing(_arg_1:CityManager):void
        {
            if (KingRenameTimer != null)
            {
                KingRenameTimerCM = _arg_1;
                KingRenameTimer = new Timer(750);
                KingRenameTimer.delay = 750;
                KingRenameTimer.repeatCount = 1;
                KingRenameTimer.addEventListener(TimerEvent.TIMER, this.doRenameKingEvent);
                KingRenameTimer.start();
            };
        }

        public function doHeroNames():void
        {
            var _local_2:CityState;
            var _local_3:HeroBean;
            if (HeroRenameTimer != null)
            {
                HeroRenameTimer.removeEventListener(TimerEvent.TIMER, this.doProcessHeroNames);
            }
            else
            {
                HeroRenameTimer = new Timer(5000);
            };
            HeroRenameTimer.stop();
            ArrayOfHerosToRename = new Array();
            var _local_1:Object;
            for each (_local_2 in MainScreen.getCities())
            {
                for each (_local_3 in _local_2.cityManager.heroes)
                {
                    _local_1 = new Object();
                    _local_1.city = _local_2;
                    _local_1.hero = _local_3;
                    ArrayOfHerosToRename.push(_local_1);
                };
            };
            HeroRenameTimer.addEventListener(TimerEvent.TIMER, this.doProcessHeroNames);
            HeroRenameTimer.start();
        }


    }
}//package com.rd

